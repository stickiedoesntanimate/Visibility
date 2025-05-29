SMODS.Joker {
    key = "alternate",
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    unlocked = true,
	discovered = true,
    eternal_compat = true,
    atlas = "TextureAtlasJokers",
    pos = { x = 5, y = 2 },
    config = { extra = { previous_joker = nil, last_debuffed = nil } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    update = function (self, card, dt)
        for i, v in ipairs(G.jokers.cards) do
            if v == card then
                if i <= 1 then
                    card.ability.extra.previous_joker = nil
                else
                    card.ability.extra.previous_joker = G.jokers.cards[i - 1]
                end
                break
            end
        end
    end,
    calculate = function(self, card, context)
        if context.before then
            if card.ability.extra.last_debuffed then
                if card.ability.extra.previous_joker == card.ability.extra.last_debuffed then
                    return -- Do not debuff if the last debuffed joker is the same as the previous one
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        -- Check if last debuffed even has a set_debuff function
                        if card.ability.extra.last_debuffed.set_debuff then
                            card.ability.extra.last_debuffed:set_debuff(false)
                        else
                            return true
                        end
                        card.ability.extra.last_debuffed = nil
                        return true
                    end
                }))
            end
        end
        if card.ability.extra.previous_joker then
            
            if card.ability.extra.previous_joker.debuff and not card.ability.extra.last_debuffed == card.ability.extra.previous_joker then
                return -- Do not continue if the previous joker is debuffed and it wasn't alternate
            end

            if context.final_scoring_step then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.last_debuffed = card.ability.extra.previous_joker
                        card.ability.extra.previous_joker:set_debuff(true)
                        return true
                    end
                }))
            end
            if card.ability.extra.previous_joker.config.center.blueprint_compat then
                return SMODS.blueprint_effect(card, card.ability.extra.previous_joker, context)
            end
        end
    end,
    remove_from_deck = function (self, card, from_debuff)
        if card.ability.extra.last_debuffed then
            if card.ability.extra.previous_joker == card.ability.extra.last_debuffed then
                return -- Do not debuff if the last debuffed joker is the same as the previous one
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    -- Check if last debuffed even has a set_debuff function
                    if card.ability.extra.last_debuffed.set_debuff then
                        card.ability.extra.last_debuffed:set_debuff(false)
                    else
                        return true
                    end
                    card.ability.extra.last_debuffed = nil
                    return true
                end
            }))
        end
    end
}