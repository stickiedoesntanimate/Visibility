-- Fridge
SMODS.Joker {
	key = 'fridge',
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { chips = 0, chip_mod = 25 } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 2, y = 2 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chip_mod, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			-- Add chips if chips > 0
			if card.ability.extra.chips > 0 then
				return {
					chips = card.ability.extra.chips
				}
			end
		end

		if context.before and not context.blueprint then
			-- Check for a Full House
			if not context.poker_hands['Full House'] then
				return
			end
			local suits = {
				['Hearts'] = 0,
				['Diamonds'] = 0,
				['Spades'] = 0,
				['Clubs'] = 0
			}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name ~= 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
					elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
					elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
				end
			end
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name == 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
					elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
					elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
				end
			end
			if suits["Hearts"] > 0 and
			suits["Diamonds"] > 0 and
			suits["Spades"] > 0 and
			suits["Clubs"] > 0 then
				-- Full House with all suits
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			else
				print("Not all suits found.")
			end
		end
    end,
}