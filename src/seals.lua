SMODS.Seal {
    key = 'bronze',
    loc_txt = {
        name = "Bronze Seal",
        label = "Bronze Seal",
        text = {
            "Copies the effect of",
            "the leftmost played card",
        },
    },
    atlas = "TextureAtlasSeals",
    pos = { x = 0, y = 0 },
    config = { extra = { retriggers = 1 } },
    badge_colour = HEX('623938'),
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.seal.extra.retriggers,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end
}