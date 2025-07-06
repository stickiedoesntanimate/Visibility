SMODS.Joker {
    key = "charlie",
	discovered = true,
	unlocked = true,
    credits = {
        idea = "WarpedCloset",
        art = "Monachrome",
    },
	blueprint_compat = true,
	eternal_compat = true,
	--pools = { ["Visibility"] = true },
    rarity = 4,
    atlas = "TextureAtlasJokers",
    pos = { x = 5, y = 5 },
    soul_pos = { x = 6, y = 5 },
    cost = 20,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative_playing_card
    end,
    calculate = function(self, card, context)
        if context.after and G.GAME.current_round.hands_played == 0 then
            local _cards = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if not scored_card.edition then
                    _cards[#_cards + 1] = scored_card
                end
            end
            local picked_card = pseudorandom_element(_cards, pseudoseed('charlie'))
            if not picked_card then
                -- Welp, no non-negative cards to pick from
                return nil
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    picked_card:set_edition('e_negative', true)
                    picked_card:juice_up()
                    return true
                end
            }))
            return {
                message = localize('k_edition_negative'),
                colour = G.C.DARK_EDITION
            }
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "count" },
                { text = " " .. localize('negative', 'labels') },
            },
            reminder_text = {
                { text = "(first hand)"}
            },
            text_config = { colour = G.C.DARK_EDITION },
            calc_function = function(card)
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                local eligable = {}
                if text ~= "Unknown" then
                    for _, scoring_card in pairs(scoring_hand) do
                        if not scoring_card.edition then
                            eligable[#eligable + 1] = scoring_card
                        end
                    end
                end
                card.joker_display_values.count = math.min(1, #eligable)
            end,
        }
    end
}