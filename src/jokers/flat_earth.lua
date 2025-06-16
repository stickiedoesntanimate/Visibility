SMODS.Joker {
    key = "flat_earth",
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = false,
    atlas = "TextureAtlasJokers",
    pos = { x = 3, y = 6 },
    config = { extra = { dollars_per_level = 2 } },
    
    loc_vars = function(self, info_queue, card)
        local full_house_level = G.GAME.hands["Full House"] and G.GAME.hands["Full House"].level or 0
        local total = full_house_level * card.ability.extra.dollars_per_level
        return { vars = { card.ability.extra.dollars_per_level, full_house_level, total } }
    end,

    calc_dollar_bonus = function(self, card)
        local full_house_level = G.GAME.hands["Full House"] and G.GAME.hands["Full House"].level or 0
        return full_house_level > 0 and full_house_level * card.ability.extra.dollars_per_level or nil
    end
}
