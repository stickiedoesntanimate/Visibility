-- Stoner Joker
SMODS.Joker {
	key = "stoner",
	loc_txt = {
		name = "Stoner Joker",
		text = {
			"Each played",
			"{C:attention}Stone Card{} and {C:attention}Brick Card",
			"gives {X:mult,C:white}X1.3{} Mult",

		}
	},
	config = { extra = { Xmult = 1.3 } },
	rarity = 2,
	discovered = true,
	unlocked = true,
	eternal_compat = true,
	blueprint_compat = true,
	pools = { ["Visibility"] = true },
	atlas = "TextureAtlasJokers",
	pos = { x = 0, y = 1},
	cost = 5,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and (SMODS.has_enhancement(context.other_card, 'm_stone') or SMODS.has_enhancement(context.other_card, 'm_vis_brick')) then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
				Xmult_mod = card.ability.extra.Xmult
			}
		end
	end
}