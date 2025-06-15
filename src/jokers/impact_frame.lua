SMODS.Joker {
   key = "impact_frame",
    atlas = "TextureAtlasJokers",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 5,
    pools = { ["Visibility"] = true },
    pos = { x = 7, y = 5 },
    config = { extra = { mult = 25 } },
    loc_vars = function(self, info_queue, card)
        local idol_card = G.GAME.current_round.idol_card or { rank = 'Ace', suit = 'Spades' }
        return { vars = { card.ability.extra.mult, localize(idol_card.rank, 'ranks'), localize(idol_card.suit, 'suits_plural'), colours = { G.C.SUITS[idol_card.suit] } } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:get_id() == G.GAME.current_round.idol_card.id and
            context.other_card:is_suit(G.GAME.current_round.idol_card.suit) then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end,
}
