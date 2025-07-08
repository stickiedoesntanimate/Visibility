SMODS.Joker {
    key = "comp_notebook",
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    atlas = "TextureAtlasJokers",
    pos = { x = 5, y = 6 },
    config = { extra = { odds = 4 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[("m_vis_notebook")]
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,

     calculate = function(self, card, context)
        if context.before and context.main_eval then --modified midas mask from vanillaremade
            local changedcards = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if pseudorandom('j_vis_comp_notebook') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    changedcards = changedcards + 1
                    scored_card:set_ability('m_vis_notebook', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if changedcards > 0 then
                return {
                    message = localize('k_noted'),
                    colour = G.C.UI.TEXT_DARK
                }
            end
        end
    end
}