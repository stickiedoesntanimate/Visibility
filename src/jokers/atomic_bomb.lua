SMODS.Joker {
    key = "atomic_bomb",
    unlocked = false,
    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    config = { extra = { destroy = 5 }},
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 0, y = 3 },
    calculate = function(self, card, context)
        if context.selling_self then
            return {
                func = function()
                    -- This is for retrigger purposes, Jokers need to return something to retrigger
                    -- You can also do this outside the return and `return nil, true` instead
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    delay(0.4)
                                    return true
                                end
                            }))
                            SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                            return true
                        end
                    }))
                end
            }
        end
    end,

}