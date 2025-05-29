SMODS.Joker {
    key = "garrab",
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
    config = { extra = { Xmult = 1, Xmult_mod = 0.25 } },
    rarity = 4,
    atlas = "TextureAtlasJokers",
    pos = { x = 2, y = 3 },
    soul_pos = { x = 3, y = 3 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false then
            local remaining_hands = G.GAME.current_round.hands_left
            if remaining_hands > 0 then
                card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod * remaining_hands)
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                }
            end
        end

        if context.joker_main then
            if card.ability.extra.Xmult > 1 then
                return {
                    Xmult = card.ability.extra.Xmult,
                }
            end
        end

	end,
}