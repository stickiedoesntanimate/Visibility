SMODS.Joker {
    key = 'conspiracy',
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 0, y = 5 },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset",
    },
	cost = 3,
    config = { extra = { odds = 3 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.x_mult, card.ability.extra.x_chips, card.ability.extra.gain, card.ability.extra.cost } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('conspiracy') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    balance = true
                }
            end
        end
    end
}