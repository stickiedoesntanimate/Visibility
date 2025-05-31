SMODS.Joker {
	key = "rv_lab",
	atlas = "TextureAtlasJokers",
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	rarity = 3,
	pools = { ["Visibility"] = true },
	cost = 10,
	pos = { x = 6, y = 0 },
	config = { extra = { xchips = 1.25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and (context.other_card:get_id() == 11 or (context.other_card:get_id() == 14 and next(SMODS.find_card("j_vis_living_card")))) then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end
    end,
}
