SMODS.Back({
    key = "poptart",
    atlas = "TextureAtlasDecks",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    config = { likeliness = 3 },
    loc_vars = function(self, info_queue, card)
        return {vars = { self.config.likeliness }}
    end,
    apply = function (self, back)
        G.GAME.visibility_rate = 45
    end
})


SMODS.Back {
    key = "gardening",
    atlas = "TextureAtlasDecks",
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Spades' then
                        v:change_suit('Clubs')
                    end
                    if v.base.suit == 'Hearts' then
                        v:change_suit('Diamonds')
                    end
                end
                return true
            end
        }))
    end,
}

SMODS.Back {
    key = "heavenly",
    atlas = "TextureAtlasDecks",
    pos = { x = 2, y = 0 },
    config = { voucher = 'v_vis_divine_merchant', consumables = { 'c_vis_pact' } },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                "Divine Merchant",
                "Pact",
                colours = { G.C.SET.Divine } 
            },
        }
    end,
    unlocked = true,
    discovered = true,
}

SMODS.Back {
    key = "burnt",
    atlas = "TextureAtlasDecks",
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = true,
    calculate = function (self, back, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            return {
                level_up = true,
                level_up_hand = text
            }
        end
    end
}