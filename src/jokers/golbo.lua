SMODS.Joker {
    key = "golbo",
    atlas = "TextureAtlasJokers",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    pos = { x = 9, y = 3 },
    pools = { ["Visibility"] = true },
    loc_vars = function (self, info_queue, card)
        return { vars = { colours = { G.C.SET.Divine } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.add_card {
                                        set = 'Divine',
                                        key_append = 'golbo'
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end
                            }))
                            SMODS.calculate_effect({ message = localize('k_plus_divine'), colour = G.C.SET.DIVINE },
                                context.blueprint_card or card)
                            return true
                        end)
                    }))
                end
            }
        end
    end,
}