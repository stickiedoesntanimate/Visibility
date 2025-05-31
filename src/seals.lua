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


SMODS.Seal {
    key = "wooden",
    loc_txt = {
        name = "Wooden Seal",
        label = "Wooden Seal",
        text = {
            "{X:mult,C:white} X#1# {} Mult",
            "{C:green}#2# in #3#{} chance to",
            "destroy card",
        },
    },
    atlas = "TextureAtlasSeals",
    pos = { x = 1, y = 0 },
    config = { retriggers = 2, extra = { odds = 4 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { "I don't fucking know", "Yeet", "what is even this why did you not finish this code invisible like why the hell would you do this to me" } }
    end,
    badge_colour = HEX('623938'),
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and pseudorandom('wooden') < G.GAME.probabilities.normal / card.ability.seal.extra.odds then
            return { remove = true }
        end
        if context.repetition then
            return {
                repetitions = card.ability.seal.extra.retriggers,
            }
        end
    end,
}