SMODS.Joker {
    key = "russian_roulette",
    config = { extra = { x_mult = 6 }},
    rarity = 2,
    unlocked = true,
    discovered = true,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 8, y = 5 },
    cost = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
    calculate = function(self, card, context)
        if not context.joker_main then return end 
         local roll = math.random(1, 6)
        if roll == 6 then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}