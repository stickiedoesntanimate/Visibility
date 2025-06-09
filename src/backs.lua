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