-- Unemployed Joker
SMODS.Joker {
    key = "unemployed",
	discovered = true,
	unlocked = true,
	blueprint_compat = false,
	brainstorm_compat = false,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
    config = { extra = { generated_card = nil }},
    rarity = 2,
    atlas = "TextureAtlasJokers",
    pos = { x = 4, y = 0},
    cost = 6,
    calculate = function(self, card, context)
        if context.setting_blind then
            local cards = create_card("Food", G.jokers, nil, nil, nil, nil, nil)
			cards:add_to_deck()
			cards:set_edition('e_negative', false)
			cards.sell_cost = -1
			G.jokers:emplace(cards)
			card.ability.extra.generated_card = cards
		end
		if context.end_of_round and not context.game_over and card.ability.extra.generated_card then
			local cards = card.ability.extra.generated_card
			cards:remove_from_deck()
			cards:start_dissolve()
		end
	end,
}