SMODS.Joker {
    key = "d20",
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    unlocked = true,
	discovered = true,
    atlas = "TextureAtlasJokers",
    pos = { x = 7, y = 1 },
    config = { extra = { odds = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop then
            --if pseudorandom(pseudoseed('d20')) < (G.GAME.probabilities.normal / card.ability.extra.odds) then
                for k, v in pairs(G.shop_booster.cards) do
                    v:remove()
                end
                local booster_slots = G.shop_booster.config.card_limit
                for i = 1, booster_slots do
                    local _pool, _pool_key = get_current_pool("Booster")
                    local key = pseudorandom_element(_pool, pseudoseed(_pool_key))
                    local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2, G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    create_shop_card_ui(card, "Booster", G.shop_booster)
                    G.shop_booster:emplace(card)
                end
                return {
                    message = "Pizza's here"
                }
            --end
        end
    end
}