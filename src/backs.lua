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

SMODS.Back {
    key = "gardening",
    atlas = "TextureAtlasDecks",
    loc_txt = {
        name = "Gardening Deck",
        text = {
            "Start run with",
            "{C:attention}26{C:clubs} Clubs{} and",
            "{C:attention}26{C:diamonds} Diamonds{} in deck",
        }
    },
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
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_black'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_black' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_black') > 1
    end
}