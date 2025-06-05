SMODS.Joker {
	key = 'teto',
	config = { extra = { triggered = false } },
	rarity = 1,
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
    eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 8, y = 0 },
	cost = -7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.triggered and "{s:0}" or "Active!" } }
    end,
    calculate = function (self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return not card.ability.extra.triggered and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.pre_discard and not card.ability.extra.triggered then
            local poker_hands = evaluate_poker_hand(context.full_hand)
            if next(poker_hands["Two Pair"]) then
                card.ability.extra.triggered = true
                -- Create an uncommon tag
                local tag = Tag("tag_uncommon")
                add_tag(tag)
                return {
                    message = "Teto Territory!"
                }
            end
        end
        if context.end_of_round and not context.game_over then
            card.ability.extra.triggered = false
        end
    end
}