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
	blueprint_compat = true,
	discovered = true,
	unlocked = true,
	rarity = 1,
	pools = { ["Visibility"] = true },
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
				if card.ability.extra.mult > 0 then
					return {
						mult_mod = card.ability.extra.mult,
						message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
					}
				end
            end
	end
}

-- Brick Up
SMODS.Joker {
	key = "brick_up",
	loc_txt = {
		name = "Brick up",
		text = {
			"Retriggers every",
			"{C:attention}Stone Card{} and {C:attention}Brick Card",
			"{C:attention}1{} additional time"

		}
	},
	atlas = "TextureAtlasJokers",
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	rarity = 2,
	pools = { ["Visibility"] = true },
	cost = 6,
	pos = { x = 1, y = 1 },
	config = { extra = { repetitions = 1 } },
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and (SMODS.has_enhancement(context.other_card, 'm_stone') or SMODS.has_enhancement(context.other_card, 'm_vis_brick')) then
			return {
				repetitions = card.ability.extra.repetitions
			}
		end
	end,
}

-- Ghost Print
SMODS.Joker {
	key = "ghost_print",
	loc_txt = {
		name = "Ghost Print",
		text = {
			"{C:green}#1# in #2#{} chance to retrigger",
			"every played card",
		}
	},
	config = { extra = {repetitions = 1, odds = 4 }},
	rarity = 1,
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = "TextureAtlasJokers",
	pos = { x = 2, y = 1},
	cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if pseudorandom('ghost_print') < G.GAME.probabilities.normal / card.ability.extra.odds then
				return {
					repetitions = card.ability.extra.repetitions
				}
			end
		end
	end,
}

-- Stoner Joker
SMODS.Joker {
	key = "stoner",
	loc_txt = {
		name = "Stoner Joker",
		text = {
			"Each played",
			"{C:attention}Stone Card{} and {C:attention}Brick Card",
			"gives {X:mult,C:white}X1.3{} Mult",

		}
	},
	config = { extra = { Xmult = 1.3 } },
	rarity = 2,
	discovered = true,
	unlocked = true,
	eternal_compat = true,
	blueprint_compat = true,
	pools = { ["Visibility"] = true },
	atlas = "TextureAtlasJokers",
	pos = { x = 0, y = 1},
	cost = 5,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and (SMODS.has_enhancement(context.other_card, 'm_stone')) or SMODS.has_enhancement(context.other_card, 'm_vis_brick') then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
				Xmult_mod = card.ability.extra.Xmult
			}
		end
	end
}

-- Unemployed Joker
SMODS.Joker {
    key = "unemployed",
    loc_txt = {
        name = "Unemployed Joker",
		text = {
			"Spawns a {C:attention}Perishable{} {C:dark_edition}negative{} food Joker",
			"with {C:gold}$-1{} sell value that",
			"debuffs after {C:attention}one{} round",
		}
    },
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
    config = { extra = {}},
    rarity = 2,
    atlas = "TextureAtlasJokers",
    pos = { x = 4, y = 0},
    cost = 6,
    calculate = function(self, card, context)
        if context.setting_blind then
            local cards = create_card("Food", G.jokers, nil, nil, nil, nil, nil)
			cards:add_to_deck()
			cards:set_edition('e_negative', false)
			cards.sell_cost = -1
			G.jokers:emplace(cards)
			cards.ability.perishable = true
			cards.ability.perish_tally = 1
		end
	end
}

SMODS.Joker {
	key = "job",
	loc_txt = {
		name = "Job Application",
		text = {
			"{C:green}#1# in #2#{} chance to create a Judgement",
			"when a Full House is played",
			"{C:green}#1# in #3#{} chance to create a Wraith",
			"when a Flush House is played"
		}
	},
	config = { extra = { judgement_odds = 4, wraith_odds = 8} },
	rarity = 2,
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 2 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.judgement_odds, card.ability.extra.wraith_odds } }
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint and (context.scoring_name == 'Full House') then
			if pseudorandom('job') < G.GAME.probabilities.normal / card.ability.extra.judgement_odds then
				local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_judgement', nil)
				n_card:add_to_deck()
				G.consumeables:emplace(n_card)
				G.GAME.consumeable_buffer = 0
			end
		end
		if context.before and context.main_eval and not context.blueprint and (context.scoring_name == 'Flush House') then
			if pseudorandom('job') < G.GAME.probabilities.normal / card.ability.extra.wraith_odds then
				local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_wraith', nil)
				n_card:add_to_deck()
				G.consumeables:emplace(n_card)
				G.GAME.consumeable_buffer = 0
			end
		end
	end,
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
	config = { extra = { odds = 8 } },
	rarity = 1,
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 1, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
	    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
	    if context.end_of_round and G.GAME.blind.boss and context.game_over == false then
			local eligable_editionless_jokers = {}
			for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    table.insert(eligable_editionless_jokers, v)
                end
            end
	        if #eligable_editionless_jokers == 0 then
	            return { message = 'Nope!' }
	        end
	        if pseudorandom('monochromatic_joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
	            local joker = pseudorandom_element(eligable_editionless_jokers, pseudoseed('monochromatic_joker'))
	            joker:set_edition('e_negative', true)
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
	rarity = 2,
	discovered = true,
	unlocked = true,
	blueprint_compat = false,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
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
                            v:remove_from_deck()
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
	blueprint_compat = false,
	eternal_compat = true,
	unlocked = true,
	discovered = true,
	rarity = 1,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 3, y = 1 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.using_consumeable and (context.consumeable.ability.name == 'Strength' or context.consumeable.ability.name == 'c_vis_weakness') then
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

-- Lean
SMODS.Joker {
	key = 'lean',
	loc_txt = {
		name = 'Lean',
		text = {
			"Playing a {C:attention}three of a kind{} discards",
			"{C:attention}all{} cards from hand",
		}
	},
	config = { extra = { } },
	rarity = 2,
	discovered = true,
	unlocked = true,
	blueprint_compat = false,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 1 },
	cost = 8,
	calculate = function(self, card, context)
		if context.before and context.scoring_name == "Three of a Kind" then
			G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.5, func = function()
				local any_selected = nil
				for i = 1, #G.hand.cards do
					local selected_card = G.hand.cards[i]
					if selected_card then 
						G.hand.highlighted[#G.hand.highlighted+1] = selected_card
            			selected_card:highlight(true)
						any_selected = true
						play_sound('card1', 1)
					end
				end
				if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
			return true end })) 
		end
    end,
}

SMODS.Joker {
	key = "echo_chamber",
	loc_txt = {
		name = "Echo Chamber",
		text = {
			"When a {C:mult}Boss Blind{} is defeated",
			"create a {C:attention,T:tag_double}#1#"
		}
	},
	rarity = 3,
	atlas = 'TextureAtlasJokers',
	pos = { x = 3, y = 2 },
	cost = 3,
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	loc_vars = function(self, info_queue, back)
		return { vars = { localize { type = 'name_text', key = 'tag_double', set = 'Tag' } } }
	end,
	calculate = function(self, back, context)
		if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag('tag_double'))
					play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
					play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
					return true
				end
			}))
		end
	end,
}

-- Cave Man
SMODS.Joker {
	key = 'caveman',
	loc_txt = {
		name = 'Cave Man',
		text = {
			"Playing a {C:attention}Stone Card{} has a",
			"{C:green}#1# in #2#{} chance to create",
			"a {C:purple}Tarot Card",
			"{C:inactive}(must have room)"
		}
	},
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { odds = 8 } },
	rarity = 1,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 0, y = 2 },
	cost = 3,
	loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone') then
			if #G.consumeables.cards >= G.consumeables.config.card_limit then
				return
			end
			if pseudorandom('caveman') < G.GAME.probabilities.normal / card.ability.extra.odds then
				local tarot_card = create_card('Tarot', G.consumeables)
				tarot_card:add_to_deck()
				G.consumeables:emplace(tarot_card)
				return { message = 'Ooga Booga.'}
			else
				return { message = 'Rock.' }
			end
		end
    end,
	in_pool = function(self, card)
		for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
	end,
}

-- God Complex
SMODS.Joker {
	key = 'god_complex',
	loc_txt = {
		name = 'God Complex',
		text = {
			"At the end of round, gain {C:gold}+$#1#{}",
			"for all {C:blue}hands{} remaining",
			"{s:2}BUT",
			"{C:attention}-#2# Hand Size{} every time a {C:mult}discard{} is used"
		}
	},
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { money = 1, deduction = 1 } },
	rarity = 3,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 1, y = 2 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.deduction } }
	end,
	calculate = function(self, card, context)
		if context.pre_discard then
			G.hand:change_size(-card.ability.extra.deduction)
			card.ability.extra.deducted = card.ability.extra.deducted + card.ability.extra.deduction
		end
		if context.end_of_round and context.cardarea == G.jokers then
			G.hand:change_size(card.ability.extra.deducted)
			card.ability.extra.deducted = 0
			-- Get hands remaining
			local hands_remaining = G.GAME.current_round.hands_left
			if hands_remaining > 0 then
				local money = hands_remaining * card.ability.extra.money
				return {
					dollars = money,
				}
			end
		end
    end,
	add_to_deck = function (self, card, from_debuff)
		card.ability.extra.deducted = 0
	end,
	remove_from_deck = function (self, card, from_debuff)
		G.hand:change_size(card.ability.extra.deducted)
	end
}

-- Fridge
SMODS.Joker {
	key = 'fridge',
	loc_txt = {
		name = 'Fridge',
		text = {
			"Gains {C:chips}+#1#{} Chips",
			"if played hand",
			"contains a {C:attention}Full House{} and",
			"contains every suit",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
		}
	},
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { chips = 0, chip_mod = 25 } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 2, y = 2 }, -- TODO: Texture
	cost = 10,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chip_mod, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			-- Add chips if chips > 0
			if card.ability.extra.chips > 0 then
				return {
					chips = card.ability.extra.chips
				}
			end
		end

		if context.before and not context.blueprint then
			-- Check for a Full House
			if not context.poker_hands['Full House'] then
				return
			end
			local suits = {
				['Hearts'] = 0,
				['Diamonds'] = 0,
				['Spades'] = 0,
				['Clubs'] = 0
			}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name ~= 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
					elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
					elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
				end
			end
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name == 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
					elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
					elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
				end
			end
			if suits["Hearts"] > 0 and
			suits["Diamonds"] > 0 and
			suits["Spades"] > 0 and
			suits["Clubs"] > 0 then
				-- Full House with all suits
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			else
				print("Not all suits found.")
			end
		end
    end,
}