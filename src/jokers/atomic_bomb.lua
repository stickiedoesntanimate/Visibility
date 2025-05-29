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
            for k, v in pairs(G.hand.cards) do
                v:start_dissolve(nil)
                v:remove_from_deck()
            end
        end
    end,
    in_pool = function (self, args)
        return false
    end,
    add_to_deck = function (self, card, from_debuff)
        card:set_eternal(true)
    end

}