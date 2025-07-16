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
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" }
                    },
                    border_colour = G.C.CHIPS
                }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text_ace"},
                { text = ")" },
            },
            calc_function = function(card)
                local count = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:get_id() and scoring_card:get_id() == 14 then
                            count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.x_chips = card.ability.extra.xchips * count
                card.joker_display_values.localized_text_ace = localize("Ace", "ranks")
            end
        }
    end,
}
