SMODS.Consumable {
    key = "crystal_ball",
    set = "Tarot",
    atlas = "TextureAtlasConsumables",
    discovered = true,
    unlocked = true,
    pools = { ["c_Visibility"] = true },
    pos = { x = 3, y = 0 },
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    use = function(self, card, area, copier)
        if pseudorandom('vis_crystal_ball') < G.GAME.probabilities.normal / card.ability.extra.odds then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					card_to_generate = 'c_soul'
            G.GAME.consumeable_buffer = 0
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                        offset = {
                            x = 0,
                            y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0
                        },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
    end
}