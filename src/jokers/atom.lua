SMODS.Joker {
    key = "atom",
    loc_txt = {
        name = "Atom",
        text = {
            "{C:chips}+20{} Chips"
        }
    },
    config = { extra = { chips = 20 }},
    rarity = 1,
    unlocked = true,
    discovered = true,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 0, y = 3 },
    cost = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}