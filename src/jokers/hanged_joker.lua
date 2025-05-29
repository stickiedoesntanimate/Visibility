-- Hanged Joker
SMODS.Joker {
	key = 'hanged_joker',
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { mult = 0, mult_mod = 6 } },
	blueprint_compat = true,
	discovered = true,
	unlocked = true,
	rarity = 1,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 0, y = 0 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
	        if
    			context.using_consumeable and
    			context.consumeable.ability.name == 'The Hanged Man' and
    			not context.blueprint
    		then
    			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
    			return {
    				message = localize('k_upgrade_ex'),
    				colour = G.C.MULT,
    				card = card
    			}
    		end
    		if context.joker_main then
				if card.ability.extra.mult > 0 then
					return {
						mult_mod = card.ability.extra.mult,
						message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
					}
				end
            end
	end
}