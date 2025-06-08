SMODS.Voucher {
    key = 'warhead',
    atlas = "TextureAtlasVouchers",
    pos = { x = 0, y = 0 },
    config = { extra = { deduction = 1, size = 1 } },
    discovered = true,
    unlocked = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction, card.ability.extra.size } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction
        G.hand:change_size(-card.ability.extra.size)
    end,
}


SMODS.Voucher {
    key = 'fallout',
    pos = { x = 1, y = 0 },
    config = { extra = { deduction = 1, slots = 1 } },
    unlocked = true,
    discovered = true,
    atlas = "TextureAtlasVouchers",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction, card.ability.extra.slots } }
    end,
    redeem = function(self, card)
        ease_ante(-card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction
        G.E_MANAGER:add_event(Event({
            func = function()
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
                return true
            end
        }))
    end
}
