SMODS.Consumable {
    key = "mortal",
    set = "Spectral",
    atlas = "TextureAtlasConsumables",
    discovered = true,
    unlocked = true,
    pools = { ["c_Visibility"] = true },
    pos = { x = 4, y = 2 },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = 'Common', edition = "e_negative"})
                card:juice_up(0.3, 0.5)
                if G.GAME.dollars ~= 0 then
                    ease_dollars(-G.GAME.dollars, true)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}