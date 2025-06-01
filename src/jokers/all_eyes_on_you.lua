SMODS.Joker {
	key = 'all_eyes_on_you',
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 9, y = 9 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.cond_discards } }
	end,
	calculate = function(self, card, context)
        local spawn_tarot = 0
		if context.remove_playing_cards then
            for k, v in pairs(context.removed) do
                if v:get_id() == 9 or v:get_id() == 8 or v:get_id() == 7 then
                    spawn_tarot = spawn_tarot + 1
                end
            end
            spawn_tarot = math.min(G.consumeables.config.card_limit - #G.consumeables.cards, #G.consumeables.cards + spawn_tarot)
            if spawn_tarot <= 0 then
                return
            end
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + spawn_tarot
            print("Consumable buffer: "..tostring(G.GAME.consumeable_buffer))
            G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = (
                function()
                    local card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_death')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                    print("Consumable buffer: "..tostring(G.GAME.consumeable_buffer))
                    return G.GAME.consumeable_buffer <= 0
                end)})
            )
            return {
                message = localize { type = 'variable', key = 'k_plus_x_tarot', vars = { spawn_tarot } },
                colour = G.C.PURPLE
            }
        end
    end
}