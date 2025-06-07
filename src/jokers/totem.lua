SMODS.Joker {
    key = "totem",
    rarity = 2,
    cost = 4,
    eternal_compat = true,
    blueprint_compat = true,
    unlocked = true,
	discovered = true,
    atlas = "TextureAtlasJokers",
    pos = { x = 9, y = 1 },
    config = { extra = { retriggers = 2 } },
    loc_vars = function(self, info_queue, card)
        local idol_card = G.GAME.current_round.idol_card or { rank = 'Ace', suit = 'Spades' }
        return { vars = { card.ability.extra.retriggers, localize(idol_card.rank, 'ranks'), localize(idol_card.suit, 'suits_plural'), colours = { G.C.SUITS[idol_card.suit] } } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and
            context.other_card:get_id() == G.GAME.current_round.idol_card.id and
            context.other_card:is_suit(G.GAME.current_round.idol_card.suit) then
            return {
                repetitions = card.ability.extra.retriggers,
            }
        end
    end,
}