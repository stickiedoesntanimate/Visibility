SMODS.Consumable {
    key = "chaos",
    set = "Spectral",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = true,
    unlocked = true,
    pools = { ["c_Visibility"] = true },
    pos = { x = 3, y = 2 },
    use = function(self)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag(get_next_tag_key()))
                add_tag(Tag(get_next_tag_key()))
                return true
            end),
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}