
-- Stone
SMODS.Enhancement {
    key = 'brick',
    atlas = "TextureAtlasEnhancements",
    loc_txt = {
        name = "Brick Card",
        text = {
            "{C:mult}+#1#{} Mult",
            "no rank or suit",
        }
    },
    pos = { x = 0, y = 0 },
    config = { mult = 10 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult} }
    end,
}

SMODS.Enhancement {
    key = 'table_cloth',
    atlas = "TextureAtlasEnhancements",
    loc_txt = {
        name = "Table Cloth",
        text = {
            "{X:chips,C:white}X1.25{} Chips"
        }
    },
    pos = { x = 0, y = 0 },
    config = { x_chips = 1.25 },
    replace_base_card = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.xchips} }
    end,
}
