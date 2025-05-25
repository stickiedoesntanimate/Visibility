SMODS.Joker {
	key = "job",
	loc_txt = {
		name = "Job Application",
		text = {
			"{C:green}#1# in #2#{} chance to create a Judgement",
			"when a Full House is played",
			"{C:green}#1# in #3#{} chance to create a Wraith",
			"when a Flush House is played"
		}
	},
	config = { extra = { judgement_odds = 4, wraith_odds = 8} },
	rarity = 2,
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 2 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.judgement_odds, card.ability.extra.wraith_odds } }
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval then
			local random_number = pseudorandom('job')
			local card_to_generate = nil

			if context.scoring_name == 'Full House' then
				if random_number < G.GAME.probabilities.normal / card.ability.extra.judgement_odds then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					card_to_generate = 'c_judgement'
				end
			elseif context.scoring_name == 'Flush House' then
				if random_number < G.GAME.probabilities.normal / card.ability.extra.wraith_odds then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					card_to_generate = 'c_wraith'
				end
			end

			if card_to_generate and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, card_to_generate)
						n_card:add_to_deck()
						G.consumeables:emplace(n_card)
						G.GAME.consumeable_buffer = 0
						return true
					end
				}))
				return { message = 'You got the job!' }
			end
		end
	end
}