SMODS.Joker {
    key = "atomic_bomb",
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 5,
    config = { extra = { }},
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 5, y = 0 },
    calculate = function(self, card, context)
        if #G.hand.cards == 0 then
            card:set_eternal(true)
        else
            card:set_eternal(false)
        end

        if context.selling_self then
            -- Dissolve and remove all hand cards
            for k, v in pairs(G.hand.cards) do
                v:start_dissolve(nil)
                v:remove_from_deck()
            end

            -- Return effect for SMODS retriggering
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    play_sound('timpani')
                                    return true
                                end
                            }))
                            SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                            return true
                        end
                    }))
                    return true
                end
            }
        end
    end,
    in_pool = function (self, args)
        return false
    end
}