SMODS.Seal {
    key = 'bronze',
    atlas = "TextureAtlasSeals",
    pos = { x = 0, y = 0 },
    config = { extra = { retriggers = 1 } },
    badge_colour = HEX('623938'),
    calculate = function(self, card, context)
        if context.main_scoring then
            if context.scoring_hand[1].seal == "vis_bronze" then return end
            local effects = eval_card(context.scoring_hand[1], context)
            return effects["playing_card"]
        end
        if context.repetition and context.scoring_hand and context.scoring_hand[1].seal == "vis_bronze" then
            return { repetitions = 1 }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end
}


SMODS.Seal {
    key = "wooden",
    atlas = "TextureAtlasSeals",
    pos = { x = 1, y = 0 },
    config = { extra = { x_mult = 2, odds = 4 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.seal.extra.x_mult, G.GAME.probabilities.normal, card.ability.seal.extra.odds } }
    end,
    badge_colour = HEX('623938'),
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and pseudorandom('wooden') < G.GAME.probabilities.normal / card.ability.seal.extra.odds then
            return { remove = true }
        end
        if context.main_scoring then
            return {
                x_mult = card.ability.seal.extra.x_mult,
            }
        end
    end,
}

SMODS.Seal {
    key = "mitosis",
    atlas = "TextureAtlasSeals",
    pos = { x = 2, y = 0 },
    config = {  },
    badge_colour = HEX('DC6094'),
    calculate = function(self, card, context)
        if context.main_scoring and context.full_hand[1] == card then
            if #context.full_hand ~= 1 then return end
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local copy_card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            copy_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy_card)
            G.hand:emplace(copy_card)
            copy_card.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    copy_card:start_materialize()
                    return true
                end
            }))
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                            return true
                        end
                    }))
                end
            }
        end
    end,
}