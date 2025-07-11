SMODS.Joker {
    key = "handheld",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    cost = 8,
    atlas = "TextureAtlasJokers",
    pools = { ["Visibility"] = true },
    unlocked = true,
    discovered = true,
    pos = { x = 6, y = 6 },
    credits = {
        idea = "StickieAnimates",
        art = "StickieAnimates",
    },
    config = { extra = { xchips = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:get_id() == 14) then
            return {
                xchips = card.ability.extra.xchips,
            }
        end
    end
}