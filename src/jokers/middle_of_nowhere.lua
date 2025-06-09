SMODS.Joker {
	key = 'middle_of_nowhere',
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { retriggers = 1, cond_discards = 3 } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 7, y = 2 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
        return { 
			vars = { 
				card.ability.extra.retriggers, 
				card.ability.extra.cond_discards, 
				G.GAME.current_round.discards_used == card.ability.extra.cond_discards 
				and "Active!" 
				or G.GAME.current_round.discards_used.."/"..card.ability.extra.cond_discards
			}
		}
	end,
	calculate = function(self, card, context)
		if context.discard then
			local eval = function() return G.GAME.current_round.discards_used == card.ability.extra.cond_discards and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
		end
		if context.repetition and context.cardarea == G.play then
            if G.GAME.current_round.discards_used == card.ability.extra.cond_discards then
                return {
                    repetitions = card.ability.extra.retriggers
                }
            end
        end
    end
}