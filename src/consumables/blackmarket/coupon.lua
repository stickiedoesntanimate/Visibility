SMODS.Consumable {
    key = "coupon",
    set = "BlackMarket",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = true,
    unlocked = true,
    pools = { ["c_Visibility"] = true },
    pos = { x = 8, y = 0 },
    config = { extra = { } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.consumables } }
    end,
    use = function(self, card, area, copier)
        if G.GAME.current_round.reroll_cost <= 10 then
            G.GAME.current_round.reroll_cost_increase = 0
            G.GAME.current_round.reroll_cost = 5
            return
        end
        local half = math.floor(G.GAME.current_round.reroll_cost / 2)
        G.GAME.current_round.reroll_cost_increase = half - 5
        G.GAME.current_round.reroll_cost = 5 + G.GAME.current_round.reroll_cost_increase
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
    end
}