---
--- Created by gunnablescum.
--- DateTime: 20.05.25 17:36
---
-- Hanged Joker
SMODS.Joker {
	key = 'hanged_joker',
	loc_txt = {
		name = 'Hanged Joker',
		text = {
			"{C:red}+#1#{} Mult for every",
			"{C:attention}hanged man {}used this run",
			"{C:inactive}(Currently: {C:mult}+#2# {C:inactive}Mult)"
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { mult = 0, mult_mod = 6 } },
	rarity = 1,
	atlas = 'TextureAtlasJokers',
	pos = { x = 0, y = 0 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
	        if
    			context.using_consumeable and
    			context.consumeable.ability.name == 'The Hanged Man' and
    			not context.blueprint
    		then
    			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
    			return {
    				message = localize('k_upgrade_ex'),
    				colour = G.C.MULT,
    				card = card
    			}
    		end
    		if context.joker_main then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
	end
}

-- Monochromatic Joker
SMODS.Joker {
	key = 'monochromatic_joker',
	loc_txt = {
		name = 'Monochromatic Joker',
		text = {
			"{C:green}#1# in #2#{} chance to change a non-edition joker into a",
			"{C:dark_edition}negative{} after defeating the {C:mult}Boss Blind{}",
		}
	},
	config = { extra = { odds = 8, eligable = {} } },
	rarity = 3,
	atlas = 'TextureAtlasJokers',
	pos = { x = 1, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
	    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
	    if context.end_of_round and G.GAME.blind.boss and context.game_over == false then
	        if #card.ability.extra.eligable == 0 then
	            for k, v in pairs(G.jokers.cards) do
                    if v.ability.set == 'Joker' and (not v.edition) then
                        table.insert(card.ability.extra.eligable, v)
                    end
                end
	        end
	        if #card.ability.extra.eligable == 0 then
	            return { message = 'Nope!' }
	        end
	        if pseudorandom('monochromatic_joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
	            local joker = pseudorandom_element(card.ability.extra.eligable, pseudoseed('monochromatic_joker'))
	            joker:set_edition('e_negative', true)
	            card.ability.extra.eligable = {}
	            return { message = 'Subtraction!' }
	        else
	            return { message = 'Nope!' }
	        end
	    end
	end
}

-- Blood Pact
SMODS.Joker {
	key = 'blood_pact',
	loc_txt = {
		name = 'Blood Pact',
		text = {
            "Played {C:attention}6{}s are {C:mult}destroyed{}",
			"after scoring in exchange for a red seal on",
			"a random card in hand",
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { } },
	rarity = 3,
	atlas = 'TextureAtlasJokers',
	pos = { x = 2, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_mod } }
	end,
	calculate = function(self, card, context)
	    if context.destroy_card and context.cardarea == G.play then
	        for k, v in pairs(context.scoring_hand) do
                if v:get_id() == 6 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            if v.ability.name == 'Glass Card' then
                                v:shatter()
                            else
                                v:start_dissolve(nil)
                            end
                            local changed_card = pseudorandom_element(G.hand.cards, pseudoseed('blood_pact'))
                            changed_card:set_seal('Red', true)
                            return true
                        end
                    }))
                    return { message = 'Blood Pact!' }
                end
            end
	    end
	end,
}

-- Crystal Dice
SMODS.Joker {
	key = 'crystal_dice',
	loc_txt = {
		name = 'Crystal Dice',
		text = {
            "All {C:green}odds{} are guaranteed",
			"{s:2}BUT",
			"{C:mult}self destruct {}after one round",
			"{C:inactive,s:0.6}handle with care..."
		}
	},
	config = { extra = { } },
	rarity = 2,
	atlas = 'TextureAtlasJokers',
	pos = { x = 3, y = 0 },
	eternal_compat = false,
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
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v/4000
        end
    end
}

-- Estrogen
SMODS.Joker {
	key = 'estrogen',
	loc_txt = {
		name = 'Estrogen',
		text = {
			"Using {C:attention}strength {}or {C:attention}weakness {}",
			"forces selected cards to be made queens",
		}
	},
	config = { extra = { } },
	rarity = 3,
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.using_consumeable and (context.consumeable.ability.name == 'Strength' or context.consumeable.ability.name == 'c_mvan_weakness') then
            for k, v in pairs(G.hand.highlighted) do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local suit_prefix = string.sub(v.base.suit, 1, 1)
                    v:set_base(G.P_CARDS[suit_prefix..'_Q'])
                return true end }))
            end
            return { message = 'Go Girls!' }
        end
    end,
}

-- Lean (Broken)
--[[
SMODS.Joker {
	key = 'lean',
	loc_txt = {
		name = 'Lean',
		text = {
			"Playing a {C:attention}three of a kind{} discards",
			"your entire hand",
		}
	},
	config = { extra = { } },
	rarity = 3,
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.after and context.scoring_name == "Three of a Kind" then
            print("We have permission to nuke the hand, sir.")
            local destroyed_cards = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i] then
                    local v = G.hand.cards[i]
                    print("Handling:")
                    print(v)
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        play_sound('card1', 1)
                        v:calculate_seal({discard = true})
                        local removed = false
                        for j = 1, #G.jokers.cards do
                            local eval = nil
                            eval = G.jokers.cards[j]:calculate_joker({discard = true, other_card =  v, full_hand = G.hand.highlighted})
                            if eval then
                                if eval.remove then removed = true end
                                card_eval_status_text(G.jokers.cards[j], 'jokers', nil, 1, nil, eval)
                            end
                        end
                        if removed then
                            destroyed_cards[#destroyed_cards + 1] = v
                            if v.ability.name == 'Glass Card' then
                                v:shatter()
                            else
                                v:start_dissolve()
                            end
                        else
                            v.ability.discarded = true
                            draw_card(G.hand, G.discard, i*100/#G.hand.cards, 'down', false, v)
                        end
                    return true end }))
                end
            end
        end
    end,
}]]
