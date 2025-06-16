SMODS.Joker {
    key = "russian_roulette",
    config = { extra = { odds = 6, x_mult = 6 }},
    rarity = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 8, y = 5 },
    credits = {
        art = "WarpedCloset",
        remix = "Monachrome",
        developer = true,
    },
    cost = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { 1, card.ability.extra.odds, card.ability.extra.x_mult } }
    end,
    calculate = function(self, card, context)
        if not context.joker_main then return end 
        local roll = pseudorandom("russian_roulette")
        if roll < 1 / card.ability.extra.odds then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}