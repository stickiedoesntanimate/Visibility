SMODS.Consumable {
    key = 'slate',
    set = 'Tarot',
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    loc_txt = {
        name = "Slate",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "card into a",
            "{C:attention}Brick",
        }
    },
    pos = { x = 2, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_vis_brick' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

-- Weakness (Thanks to VanillaRemade for this one)
SMODS.Consumable {
    key = 'weakness',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 2 },
    pools = { ["c_Visibility"] = true },
    atlas = "TextureAtlasConsumables",
    loc_txt = {
        name = 'Weakness',
        text = {
            "Decreases rank of",
            "up to {C:attention}#1#{} selected",
            "cards by {C:attention}1",
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.modify_rank(G.hand.highlighted[i], -1))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.35,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.6)
    end
}

-- Printshop (TODO: Better name)
SMODS.Consumable {
    key = 'echo',
    set = 'Tarot',
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    pos = { x = 4, y = 0 }, -- Texture TBD
    config = { },
    can_use = function (self, card)
        return G.jokers and ((#G.jokers.cards < G.jokers.config.card_limit) and (#G.jokers.cards > 0))
    end,
    use = function (self, card, area, copier)
        local random_joker = pseudorandom_element(G.jokers.cards, pseudoseed('echo'))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                local copy = copy_card(random_joker)
                copy:set_perishable(true)
                copy.ability.perish_tally = 1
                copy:add_to_deck()
                G.jokers:emplace(copy)
                play_sound('timpani')
                return true
            end
        }))
    end
}

-- The Mint
SMODS.Consumable {
    key = 'mint',
    set = 'Tarot',
    pos = { x = 1, y = 0 },
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    loc_txt = {
        name = 'The Mint',
        text = {
            "Gives you a {C:attention}quarter{} of all",
            "{C:chips}+Chips{} cards in your hand as {C:gold}money{}",
            "{C:inactive}(Currently: {C:gold}$#1#{C:inactive}, Max: {C:gold}$#2#{C:inactive})"
        }
    },
    config = { extra = { current = 0, max = 35 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current, card.ability.extra.max } }
    end,
    can_use = function (self, card)
        -- Return true if there are any cards in hand
        return G.hand and #G.hand.cards > 0
    end,
    update = function (self, card, dt)
        -- Ran every frame
        if G.hand and #G.hand.cards == 0 then
            card.ability.extra.current = 0
            return
        end
        local total_chips = 0
        if not G.hand then
            goto no_hand
        end
        for i = 1, #G.hand.cards do
            local c = G.hand.cards[i]
            if c.ability.bonus or c.ability.perma_bonus then
                total_chips = total_chips + (c.ability.bonus or 0) + (c.ability.perma_bonus or 0)
            end
            -- Do not add rank to total chips if the enhancement has no_rank active
            if SMODS.has_no_rank(c) then
                goto continue
            end
            -- Card is (maybe) not enhanced, so it just adds (rank) chips, limit it to 10 except for ace, which is 11
            total_chips = total_chips + c.base.nominal
            ::continue::
        end
        ::no_hand::
        card.ability.extra.current = math.min(math.floor(total_chips / 4), card.ability.extra.max)
    end,
    use = function(self, card, area, copier)
        -- Loop through all cards in hand
        local total_chips = 0
        for i = 1, #G.hand.cards do
            local c = G.hand.cards[i]
            if c.ability.bonus or c.ability.perma_bonus then
                total_chips = total_chips + (c.ability.bonus or 0) + (c.ability.perma_bonus or 0)
            end
            -- Do not add rank to total chips if the enhancement has no_rank active
            if SMODS.has_no_rank(c) then
                goto continue
            end
            -- Card is (maybe) not enhanced, so it just adds (rank) chips, limit it to 10 except for ace, which is 11
            total_chips = total_chips + c.base.nominal
            ::continue::
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(math.min(math.floor(total_chips/4), card.ability.extra.max), true)
                return true
            end
        }))
        delay(0.6)
    end
}


--------------------------
----    SPECTRALS     ----
--------------------------

-- Hamsa
SMODS.Consumable {
    key = 'hamsa',
    set = 'Spectral',
    pos = { x = 2, y = 2 },
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    config = {  },
    can_use = function(self, card)
        return (G.jokers and #G.jokers.cards < G.jokers.config.card_limit) and (G.GAME.round_resets.hands > 1 and  G.GAME.current_round.hands_left > 1)
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', legendary = true })
                check_for_unlock { type = 'spawn_legendary' }
                card:juice_up(0.3, 0.5)
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
                ease_hands_played(-1)
                return true
            end
        }))
        delay(0.6)
    end
}

-- Mortal
SMODS.Consumable {
    key = "mortal",
    set = "Spectral",
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    pos = { x = 4, y = 2 },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = 'Common', edition = "e_negative"})
                card:juice_up(0.3, 0.5)
                if G.GAME.dollars ~= 0 then
                    ease_dollars(-G.GAME.dollars, true)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = "vault",
    set = "Spectral",
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    pos = { x = 0, y = 2 },
    use = function(self)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = (function()
                G.jokers.highlighted[1]:set_eternal(true)
                G.jokers.highlighted[1]:juice_up(0.3, 0.5)
                play_sound('tarot2')
                return true
            end),
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted == 1
    end
}

-- Spire
SMODS.Consumable {
    key = 'spire',
    set = 'Spectral',
    pos = { x = 1, y = 2 },
    atlas = "TextureAtlasConsumables",
    config = { extra = { seal = 'vis_bronze' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { 
            vars = { card.ability.max_highlighted,
            colours = {
                HEX('623938')
            }
         },
        }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}

SMODS.Consumable {
    key = "chaos",
    set = "Spectral",
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    pos = { x = 3, y = 2 },
    use = function(self)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag(get_next_tag_key()))
                add_tag(Tag(get_next_tag_key()))
                return true
            end),
        }))
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = "crystal_ball",
    set = "Tarot",
    loc_txt = {
        name = "Crystal Ball",
        text = {
            "{C:green}#1# in #2#{} chance to create",
            "a {C:spectral}Spectral{} card"
        },
    },
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    pos = { x = 3, y = 0 },
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    use = function(self, card, area, copier)
        if pseudorandom('vis_crystal_ball') < G.GAME.probabilities.normal / card.ability.extra.odds then
            SMODS.add_card {
                set = 'Spectral',
                key_append = 'vis_crystal_ball'
            }
            G.GAME.consumeable_buffer = 0
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                        offset = {
                            x = 0,
                            y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0
                        },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
    end
}

SMODS.Consumable {
    key = 'hi',
    set = 'Tarot',
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    loc_txt = {
        name = "hi",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "card into a",
            "{C:attention}Plastic Card",
        }
    },
    pos = { x = 0, y = 1 },
    config = { max_highlighted = 1, mod_conv = 'm_vis_plastic' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

SMODS.Consumable {
    key = 'constant',
    set = 'Tarot',
    atlas = "TextureAtlasConsumables",
    pools = { ["c_Visibility"] = true },
    loc_txt = {
        name = "Constant",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "card into a",
            "{C:attention}Notebook Page",
        }
    },
    pos = { x = 1, y = 1 },
    config = { max_highlighted = 2, mod_conv = 'm_vis_notebook' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}
