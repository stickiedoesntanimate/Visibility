SMODS.Joker {
    key = "charlie",
	discovered = true,
    loc_txt = {
                name = "Charlie",
                text = {
                    "If {C:attention}poker hand{} is a {C:attention}#1#{},",
                    "apply a {C:negative}negative edition{}",
                    "to all {C:attention}played cards{}",
                    "in that hand",
                    "{C:inactive}(changes each round)"
                }
            },
	unlocked = true,
	blueprint_compat = false,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
    rarity = 4,
    atlas = "TextureAtlasJokers",
    pos = { x = 5, y = 5 },
    soul_pos = { x = 6, y = 5},
    cost = 20,
    config = { extra = { poker_hand = 'High Card' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                local negative_editions = {
                    'e_negative',
                }
                local neg_edition = pseudorandom_element(negative_editions, pseudoseed('charlie_edition'))
                scored_card:set_edition(neg_edition, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        scored_card:juice_up()
                        return true
                    end
                }))
            end
            return {
                message = localize('k_negative'),
                colour = G.C.RED
            }
        end
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and k ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = k
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('charlie_remake'))
            return {
                message = localize('k_reset')
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible and k ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = k
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands,
            pseudoseed((card.area and card.area.config.type == 'title') and 'charlie_false' or 'charlie_remake'))
    end
}