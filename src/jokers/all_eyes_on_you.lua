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
	pos = { x = 7, y = 3 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.cond_discards } }
	end,
	calculate = function(self, card, context)
        local spawn_tarot = 0
		if context.remove_playing_cards and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            for k, v in pairs(context.removed) do
                if v:get_id() == 9 or v:get_id() == 8 or v:get_id() == 7 then
                    spawn_tarot = spawn_tarot + 1
                end
            end
            if spawn_tarot > G.consumeables.config.card_limit + G.GAME.consumeable_buffer - #G.consumeables.cards then
                spawn_tarot = G.consumeables.config.card_limit + G.GAME.consumeable_buffer - #G.consumeables.cards
            end
            for i = 1, spawn_tarot do
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (
                        function()
                            local card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_death')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true
                        end)
                }))
            end
            return {
                message = localize { type = 'variable', key = 'k_plus_x_tarot', vars = { spawn_tarot } },
                colour = G.C.PURPLE
            }
        end
    end
}