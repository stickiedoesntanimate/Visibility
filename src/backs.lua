SMODS.Back {
    key = "poptart",
    atlas = "TextureAtlasDecks",
    loc_txt = {
        name = "Poptart Deck",
        text = {
            "{C:attention}Visibility{} Jokers are",
            "{X:blue}X#1#{} more likely to appear",
            "in the shop"
        }
    },
    pos = { x = 0, y = 0 },
    config = { extra = { likeliness = 3 } },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.likeliness } }
    end,
    apply = function(self, back)
        G.GAME.visibility_rate = self.config.extra.likeliness * G.GAME.visibility_rate
        print("New Rate: ")
        print(G.GAME.visibility_rate)
    end
}
