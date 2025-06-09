SMODS.Seal {
    key = 'bronze',
    loc_txt = {
        name = "Bronze Seal",
        label = "Bronze Seal",
        text = {
            "Copies the effect of",
            "the leftmost scored card",
            "{C:attention}Copying{} other bronze-sealed cards",
            "{C:attention}retriggers{} this card instead",
        },
    },
    atlas = "TextureAtlasSeals",
    pos = { x = 0, y = 0 },
    config = { extra = { retriggers = 1 } },
    badge_colour = HEX('623938'),
    calculate = function(self, card, context)
        if context.main_scoring then
            if context.scoring_hand[1].seal == "vis_bronze" then return end
            local effects = eval_card(context.scoring_hand[1], context)
            return effects["playing_card"]
        end
        if context.repetition and context.scoring_hand and context.scoring_hand[1].seal == "vis_bronze" then
            return { repetitions = 1 }
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
    config = { extra = { x_mult = 2, odds = 4 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.seal.extra.x_mult, G.GAME.probabilities.normal, card.ability.seal.extra.odds } }
    end,
    badge_colour = HEX('623938'),
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and pseudorandom('wooden') < G.GAME.probabilities.normal / card.ability.seal.extra.odds then
            return { remove = true }
        end
        if context.main_scoring then
            return {
                x_mult = card.ability.seal.extra.x_mult,
            }
        end
    end,
}