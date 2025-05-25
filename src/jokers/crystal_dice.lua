-- Crystal Dice
SMODS.Joker {
	key = 'crystal_dice',
	loc_txt = {
		name = 'Crystal Dice',
		text = {
            "All {C:green}odds{} are guaranteed",
			"{s:2}BUT",
			"{C:mult}self destruct {}after one round",
			"{C:inactive,s:0.7}handle with care... it will not appear again."
		}
	},
	config = { extra = { } },
	rarity = 1,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 3, y = 0 },
	discovered = true,
	unlocked = true,
	eternal_compat = false,
	no_pool_flag = "crystal_shortage",
	blueprint_compat = false,
	cost = 12,
	loc_vars = function(self, info_queue, card)
        return { vars = { } }
	end,
	calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and context.game_over == false then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('glass5')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil
                            return true
                        end
                    }))
                    return true
                end
            }))
            return {
                message = 'Shattered!'
            }
        end
	end,
	add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v*4000
        end
		G.GAME.pool_flags.crystal_shortage = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v/4000
        end
    end
}