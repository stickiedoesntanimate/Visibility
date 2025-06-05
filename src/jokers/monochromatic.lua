-- Monochromatic Joker
SMODS.Joker {
	key = 'monochromatic_joker',
	config = { extra = { odds = 8 } },
	rarity = 1,
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 1, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
	    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
	    if context.end_of_round and G.GAME.blind.boss and context.game_over == false then
			local eligable_editionless_jokers = {}
			for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    table.insert(eligable_editionless_jokers, v)
                end
            end
	        if #eligable_editionless_jokers == 0 then
	            return { message = 'Nope!' }
	        end
	        if pseudorandom('monochromatic_joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
	            local joker = pseudorandom_element(eligable_editionless_jokers, pseudoseed('monochromatic_joker'))
	            joker:set_edition('e_negative', true)
	            return { message = localize('k_edition_negative') }
	        else
	            return { message = 'Nope!' }
	        end
	    end
	end
}