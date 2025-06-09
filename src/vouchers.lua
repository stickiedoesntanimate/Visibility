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
    requires = { 'v_vis_warhead' },
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

SMODS.Voucher {
    key = 'divine_merchant',
    atlas = "TextureAtlasVouchers",
    pos = { x = 2, y = 0 },
    discovered = true,
    unlocked = true,
    config = { extra = { display = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display, colours = { G.C.SET.Divine } } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.divine_rate = (G.GAME.divine_rate or 3) * card.ability.extra.display
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'divine_tycoon',
    atlas = "TextureAtlasVouchers",
    pos = { x = 3, y = 0 },
    config = { extra = { display = 4 } },
    discovered = true,
    unlocked = true,
    requires = { 'v_vis_divine_merchant' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display, colours = { G.C.SET.Divine } } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                print("Divine Tycoon check, rate: "..tostring(G.GAME.divine_rate))
                G.GAME.divine_rate = (G.GAME.divine_rate or 6) * math.floor(card.ability.extra.display/2)
                print("Divine Tycoon check, rate: "..tostring(G.GAME.divine_rate))
                return true
            end
        }))
    end
}
