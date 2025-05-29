SMODS.Joker {
	key = 'crystal_geode',
	config = { extra = { balance_percentage = 8 } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 4 },
	discovered = true,
	unlocked = true,
	eternal_compat = true,
	blueprint_compat = false,
	cost = 9,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.balance_percentage } }
	end,
	calculate = function(self, card, context)
        if context.final_scoring_step then
            local percentage_mult = mult * (card.ability.extra.balance_percentage / 100)
            local percentage_chips = hand_chips * (card.ability.extra.balance_percentage / 100)
            mult = mult - math.floor(percentage_mult)
            hand_chips = hand_chips - math.floor(percentage_chips)
            local balance = math.floor((percentage_mult + percentage_chips) / 2)
            mult = mult + balance
            hand_chips = hand_chips + balance
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    -- scored_card:juice_up()
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  0.8,
                        func = (function() 
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
                                ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  1.3,
                        func = (function() 
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_pbalanced'), colour =  {0.8, 0.45, 0.85, 1} })
            delay(0.6)
        end
	end,
}