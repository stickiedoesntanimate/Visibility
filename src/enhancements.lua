SMODS.Enhancement {
    key = 'brick',
    atlas = "TextureAtlasEnhancements",
    pos = { x = 0, y = 0 },
    config = { mult = 10 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end,
}

SMODS.Enhancement {
    key = 'table_cloth',
    atlas = "TextureAtlasEnhancements",
    pos = { x = 1, y = 0 },
    config = { x_chips = 1.25 },
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.xchips } }
    end,
}

SMODS.Enhancement {
    key = 'notebook',
    atlas = "TextureAtlasEnhancements",
    pos = { x = 3, y = 0 },
    config = { extra = { chips = 80, dollars = 6, chips_odds = 4, dollars_odds = 6 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.chips, card.ability.extra.chips_odds, card.ability.extra.dollars, card.ability.extra.dollars_odds } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local ret = {}
            if pseudorandom('plastic_mult') < G.GAME.probabilities.normal / card.ability.extra.chips_odds then
                ret.chips = card.ability.extra.chips
            end
            if pseudorandom('plastic_money') < G.GAME.probabilities.normal / card.ability.extra.dollars_odds then
                ret.dollars = card.ability.extra.dollars
            end
            return ret
        end
    end,
}

SMODS.Enhancement {
    key = 'plastic',
    atlas = "TextureAtlasEnhancements",
    pos = { x = 2, y = 0 },
    config = { h_x_chips = 1.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_chips } }
    end,
}