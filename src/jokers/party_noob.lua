SMODS.Joker {
	key = "party_noob",
	atlas = "TextureAtlasJokers",
	discovered = true,
	unlocked = true,
	blueprint_compat = false,
	rarity = 3,
	cost = 7,
	pools = { ["Visibility"] = true },
	pos = { x = 9, y = 2 },
	config = { extra = { } },
    calculate = function (self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			-- Check if the joker is adjacent
			local this_joker_index = nil
			for i, current_card in ipairs(G.jokers.cards) do
				if current_card == card then
					this_joker_index = i
					break
				end
			end
			if not this_joker_index then return end
			if is_adjacent_joker(this_joker_index, context.other_card) and context.other_card.config.center.rarity == 1 then
				return {
					repetitions = 1,
				}
			end
		end
    end
}

function is_adjacent_joker(cardindex, joker)
	return (cardindex > 1 and G.jokers.cards[cardindex - 1] == joker) or
	       (cardindex < #G.jokers.cards and G.jokers.cards[cardindex + 1] == joker)
end