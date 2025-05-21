

SMODS.Back {
    key = "poptart",
    atlas = "TextureAtlasDecks",
    loc_txt = {
        name = "Poptart Deck",
        text = {
            "{C:blue}+#1#{} hand",
            "every round",
        }
    },
    pos = { x = 0, y = 0 },
    config = { extra = { hands = 1 } },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.hands } }
    end,
    apply = function(self, back)
        G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.extra.hands
    end,
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 20 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 20
    end
}
