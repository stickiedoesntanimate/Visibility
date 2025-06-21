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
    credits = {
        developer = true,
    },
    config = { extra = { dollars_per_level = 2, hand_picked = "High Card" } },
    
    loc_vars = function(self, info_queue, card)
        local hand_level = G.GAME.hands[card.ability.extra.hand_picked] and G.GAME.hands[card.ability.extra.hand_picked].level or 0
        local total = hand_level * card.ability.extra.dollars_per_level
        return { vars = { card.ability.extra.hand_picked, card.ability.extra.dollars_per_level, hand_level, total } }
    end,

    update = function (self, card, dt)
        local _handname, _played, _order = 'High Card', 100, -1
        for k, v in pairs(G.GAME.hands) do
            if v.played < _played or (v.played == _played and _order < v.order) then 
                _played = v.played
                _order = v.order
                _handname = k
            end
        end
        card.ability.extra.hand_picked = _handname
    end,

    calc_dollar_bonus = function(self, card)
        local full_house_level = G.GAME.hands[card.ability.extra.hand_picked] and G.GAME.hands[card.ability.extra.hand_picked].level or 0
        return full_house_level > 0 and full_house_level * card.ability.extra.dollars_per_level or nil
    end
}
