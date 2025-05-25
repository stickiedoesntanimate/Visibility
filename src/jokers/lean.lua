-- Lean
SMODS.Joker {
	key = 'lean',
	loc_txt = {
		name = 'Lean',
		text = {
			"Playing a {C:attention}three of a kind{} discards",
			"{C:attention}all{} cards from hand",
		}
	},
	config = { extra = { } },
	rarity = 2,
	discovered = true,
	unlocked = true,
	blueprint_compat = false,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 1 },
	cost = 8,
	calculate = function(self, card, context)
		if context.before and context.scoring_name == "Three of a Kind" then
			G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.5, func = function()
				local any_selected = nil
				for i = 1, #G.hand.cards do
					local selected_card = G.hand.cards[i]
					if selected_card then 
						G.hand.highlighted[#G.hand.highlighted+1] = selected_card
            			selected_card:highlight(true)
						any_selected = true
						play_sound('card1', 1)
					end
				end
				if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
			return true end })) 
		end
    end,
}