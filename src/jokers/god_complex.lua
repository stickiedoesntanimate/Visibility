-- God Complex
SMODS.Joker {
	key = 'god_complex',
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { money = 5, deduction = 1 } },
	rarity = 3,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 1, y = 2 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.deduction } }
	end,
	calculate = function(self, card, context)
		if context.pre_discard then
			G.hand:change_size(-card.ability.extra.deduction)
			card.ability.extra.deducted = card.ability.extra.deducted + card.ability.extra.deduction
		end
		if context.end_of_round and context.cardarea == G.jokers then
			G.hand:change_size(card.ability.extra.deducted)
			card.ability.extra.deducted = 0
			-- Get hands remaining
			local hands_remaining = G.GAME.current_round.hands_left
			if hands_remaining > 0 then
				local money = hands_remaining * card.ability.extra.money
				return {
					dollars = money,
				}
			end
		end
    end,
	add_to_deck = function (self, card, from_debuff)
		card.ability.extra.deducted = 0
	end,
	remove_from_deck = function (self, card, from_debuff)
		G.hand:change_size(card.ability.extra.deducted)
	end,
	joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
		return {
            text = {
                { text = "+$" },
                { ref_table = "card.joker_display_values", ref_value = "dollars" }
            },
            text_config = { colour = G.C.GOLD },
            calc_function = function (card)
                card.joker_display_values.dollars = G.GAME.current_round.hands_left * card.ability.extra.money
            end
        }
    end,
}