SMODS.Consumable {
    key = "vault",
    set = "Spectral",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = true,
    unlocked = true,
    pools = { ["c_Visibility"] = true },
    pos = { x = 0, y = 2 },
    use = function(self)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = (function()
                G.jokers.highlighted[1]:set_eternal(true)
                G.jokers.highlighted[1]:juice_up(0.3, 0.5)
                play_sound('tarot2')
                return true
            end),
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted == 1
    end
}