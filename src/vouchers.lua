SMODS.Voucher {
    key = 'warhead',
    atlas = "TextureAtlasVouchers",
    loc_txt = {
        name = "Warhead",
        text = {
            "{C:attention}+#1#{} Ante,",
            "{C:blue}+#1#{} hand",
            "each round",
        }
    },
    pos = { x = 0, y = 0 },
    config = { extra = { deduction = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.deduction

        -- Apply hand change
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.deduction
        ease_hands_played(card.ability.extra.deduction)
    end
}

SMODS.Voucher {
    key = 'fallout',
    atlas = "TextureAtlasVouchers",
    loc_txt = {
        name = "Fallout",
        text = {
            "{C:attention}+#1#{} Ante,",
            "{C:blue}+#1#{} hand",
            "each round",
        }
    },
    pos = { x = 1, y = 0 },
    config = { extra = { deduction = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.deduction

        -- Apply hand change
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.deduction
        ease_hands_played(card.ability.extra.deduction)
    end
}