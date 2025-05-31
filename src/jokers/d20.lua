SMODS.Joker {
    key = "d20",
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    unlocked = true,
	discovered = true,
    atlas = "TextureAtlasJokers",
    pos = { x = 0, y = 4 },
    config = { extra = { odds = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context) -- TODO: Make the packs in the shop save and actually be buyable
        if context.reroll_shop then
            --if pseudorandom(pseudoseed('d20')) < (G.GAME.probabilities.normal / card.ability.extra.odds) then
                for k, v in pairs(G.shop_booster.cards) do
                    v:start_dissolve(nil)
                    G.shop_booster.remove_card(v)
                end
                -- Generate x more booster packs where x is the amount of booster pack slots
                local booster_slots = G.shop_booster.config.card_limit
                for i = 1, booster_slots do
                    local booster = create_card("Booster", G.shop_booster)
                    G.shop_booster:emplace(booster)
                end
                return {
                    message = "Pizza's here"
                }
            --end
        end
    end
}