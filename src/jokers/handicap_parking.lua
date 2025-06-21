SMODS.Joker {
    key = "handicap_parking",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 3, y = 5 },
    atlas = "TextureAtlasJokers",
    config = { extra = { odds = 2, dollars = 3 } },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local empty_slots = G.jokers and (G.jokers.config.card_limit - #G.jokers.cards) or 0
        return { vars = { card.ability.extra.dollars, empty_slots, G.GAME and G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and pseudorandom('vishandicap_parking') < G.GAME.probabilities.normal / card.ability.extra.odds then
            local empty_slots = G.jokers and (G.jokers.config.card_limit - #G.jokers.cards) or 0
            if empty_slots > 0 then
                local total_dollars = card.ability.extra.dollars * empty_slots
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + total_dollars
                return {
                    dollars = total_dollars,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end
}
