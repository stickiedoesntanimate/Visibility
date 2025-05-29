SMODS.Joker {
	key = 'sd_card',
	config = { extra = { extra_slots = 1 } },
	rarity = 1,
	discovered = true,
	unlocked = true,
	blueprint_compat = false,
    no_pool_flag = "sd_full",
    eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 2, y = 4 },
	cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.extra_slots } }
    end,
	add_to_deck = function (self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.extra_slots
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.extra_slots
        G.GAME.pool_flags.sd_full = true
    end,
}

SMODS.Joker {
	key = 'the_cooler_sd_card',
	config = { extra = { extra_slots = 3 } },
	rarity = 3,
	discovered = true,
	unlocked = true,
	blueprint_compat = false,
    yes_pool_flag = "sd_full",
    eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 3, y = 4 },
	cost = 8,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.extra_slots } }
    end,
	add_to_deck = function (self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.extra_slots
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.extra_slots
    end,
}