SMODS.Voucher {
    key = 'warhead',
    atlas = "TextureAtlasVouchers",
    loc_txt = {
        name = "Warhead",
        text = {
            "{C:attention}-#1#{} Ante,",
            "{C:attention}-#1#{} hand size",
            "each round",
        }
    },
    pos = { x = 0, y = 0 },
    config = { extra = { deduction = 1, size = 1 } },
    unlocked = true,
    atlas = "TextureAtlasVouchers",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 12 } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction
        G.hand:change_size(-card.ability.extra.size)
    end,
    check_for_unlock = function(self, args)
        return args.type == 'ante_up' and args.ante >= 12
    end
}

SMODS.Voucher {
    key = 'fallout',
    loc_txt = {
        name = "Fallout",
        text = {
            "{C:attention}-#1#{} Ante,",
            "{C:attention}-#1#{} consumable size",
            "each round",
        }
    },
    pos = { x = 1, y = 0 },
    config = { extra = { deduction = 1, slots = 1 } },
    unlocked = true,
    atlas = "TextureAtlasVouchers",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 12 } }
    end,
    redeem = function(self, card)
        -- Apply ante change
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
