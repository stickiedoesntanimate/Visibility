SMODS.Consumable {
    key = 'hamsa',
    set = 'Spectral',
    pos = { x = 2, y = 2 },
    atlas = "TextureAtlasConsumables",
    discovered = true,
    unlocked = true,
    pools = { ["c_Visibility"] = true },
    config = {  },
    can_use = function(self, card)
        return (G.jokers and #G.jokers.cards < G.jokers.config.card_limit) and (G.GAME.round_resets.hands > 1 and  G.GAME.current_round.hands_left > 1)
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', legendary = true })
                check_for_unlock { type = 'spawn_legendary' }
                card:juice_up(0.3, 0.5)
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
                ease_hands_played(-1)
                return true
            end
        }))
        delay(0.6)
    end
}