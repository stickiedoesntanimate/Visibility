--Creates an atlas for cards to use
SMODS.Atlas {
	-- Key for code to find it with
	key = "ModdedVanilla",
	-- The name of the file, for the code to pull the atlas from
	path = "ModdedVanilla.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- Hanged Joker
SMODS.Joker {
	key = 'hanged_joker',
	loc_txt = {
		name = 'Hanged Joker',
		text = {
			--"Using a non-{C:dark_edition}negative {C:planet}Planet{} card",
			--"has a {C:green}#1# in #2#{} chance to create a",
			--"{C:dark_edition}Negative{} copy of it",
			"{C:red}+#1#{} Mult for every",
			"{C:attention}hanged man {}used this run",
			"{C:inactive}(Currently: {C:mult}+#2# {C:inactive}Mult)"
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { mult = 0, mult_mod = 6 } },
	rarity = 1,
	atlas = 'ModdedVanilla',
	pos = { x = 1, y = 0 },
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
	    --[[if
	        context.using_consumeable
	        and context.consumeable.ability.set == "Planet"
            and not context.consumeable.beginning_end
            and context.consumeable.edition ~= "e_negative"
	    then
	        if pseudorandom('nasa_employee') < G.GAME.probabilities.normal / card.ability.extra.odds then
	            G.E_MANAGER:add_event(Event({
                    func = function()
                        local cards = copy_card(context.consumeable)
                        cards:set_edition('e_negative', true)
                        cards:add_to_deck()
                        G.consumeables:emplace(cards)
                        return true
                    end,
                }))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                				{ message = localize('k_duplicated_ex') })
	        end
	    end]]
	end
}

-- Monochromatic Joker
SMODS.Joker {
	key = 'monochromatic_joker',
	loc_txt = {
		name = 'Monochromatic Joker',
		text = {
			--"Using a non-{C:dark_edition}negative {C:planet}Planet{} card",
			--"has a {C:green}#1# in #2#{} chance to create a",
			--"{C:dark_edition}Negative{} copy of it",
			"{C:green}#1# in #2#{} chance to change a non-edition joker into a",
			"{C:dark_edition}negative{} after defeating the {C:mult}Boss Blind{}",
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { odds = 8, eligable = {} } },
	rarity = 3,
	atlas = 'ModdedVanilla',
	pos = { x = 2, y = 0 },
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
			--"Using a non-{C:dark_edition}negative {C:planet}Planet{} card",
			--"has a {C:green}#1# in #2#{} chance to create a",
			--"{C:dark_edition}Negative{} copy of it",
			"{X:mult,C:white} X#1# {} Mult",
			"Gains {X:mult, C:white} X#2# {} Mult for",
			"every {C:attention}6{} added to your deck",
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { x_mult = 1, x_mult_mod = 0.3 } },
	rarity = 3,
	atlas = 'ModdedVanilla',
	pos = { x = 3, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_mod } }
	end,
	calculate = function(self, card, context)
	    if
            context.using_consumeable
            and context.consumeable.ability.set == "Planet"
            and not context.consumeable.beginning_end
        then

        end
	end
}

-- Estrogen
SMODS.Joker {
	key = 'estrogen',
	loc_txt = {
		name = 'Estrogen',
		text = {
			--"Using a non-{C:dark_edition}negative {C:planet}Planet{} card",
			--"has a {C:green}#1# in #2#{} chance to create a",
			--"{C:dark_edition}Negative{} copy of it",
			"{C:attention}Strength {} causes a rank-decrease",
			"instead of a rank-increase",
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { x_mult = 1, x_mult_mod = 0.3 } },
	rarity = 3,
	atlas = 'ModdedVanilla',
	pos = { x = 3, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_mod } }
	end,
	calculate = function(self, card, context)
	    if context.playing_card_added and not card.getting_sliced then
            if not context.blueprint and context.cards and context.cards[1] then
                print(table.concat(context, '\n'))
                if context.cards[1]:get_id() == 6 then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                    return {
                        message = "Upgrade!",
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.x_mult,
                --message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
	end
}

----------------------------------------------
------------MOD CODE END----------------------
