SMODS.Joker {
    key = "forged",
    atlas = "TextureAtlasJokers",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 5,
    pos = { x = 8, y = 4 },
    config = { extra = { chips = 50 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}