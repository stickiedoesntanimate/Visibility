SMODS.Joker {
    key = "gambling_addict",
    config = { extra = { odds = 4, x_mult = 2, x_chips = 2, cost = 2, gain = 6 }},
    rarity = 2,
    unlocked = true,
    discovered = true,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 1, y = 3 },
    cost = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.x_mult, card.ability.extra.x_chips, card.ability.extra.gain, card.ability.extra.cost } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('gambling_addict') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    x_mult = card.ability.extra.x_mult,
                    x_chips = card.ability.extra.x_chips,
                    dollars = card.ability.extra.gain-card.ability.extra.cost
                }
            else
                return {
                    dollars = -card.ability.extra.cost
                }
            end
        end
    end
}