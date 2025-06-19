SMODS.Sound({
	key = "music_divine",
	path = "music_divine.ogg",
	select_music_track = function()
        if not G.pack_cards or not G.pack_cards.cards then return false end
        if #G.pack_cards.cards == 0 then return false end
        local divine = true
        for _, v in ipairs(G.pack_cards.cards) do
            if v.ability.set ~= "Divine" then
                divine = false
            end
        end
        return divine
	end,
})

SMODS.Booster{
    key = 'black_market_normal_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_visibility_pack",
    pos = { x = 0, y = 3 },
    discovered = true,
    unlocked = true,

    draw_hand = false,
    config = {
        extra = 3,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("bdc3c7") }} }
    end,
    weight = 0.5,
    cost = 6,
    kind = "VisibilityPack",

    create_card = function(self, card, i)
        local _types = {}
        for k, v in ipairs(SMODS.ConsumableType.ctype_buffer) do
            _types[#_types + 1] = v
        end
        local type = pseudorandom_element(_types, pseudoseed('bmp'))
        return SMODS.create_card({
            set = type,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = (G.pack_cards and G.pack_cards.cards and G.pack_cards.highlighted[1].set == "Joker") and "joker" or 'consumeables',

    in_pool = function() return true end
}

SMODS.Booster{
    key = 'black_market_jumbo_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_visibility_pack",
    pos = { x = 1, y = 3 },
    discovered = true,
    unlocked = true,

    draw_hand = false,
    config = {
        extra = 5,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("bdc3c7") } } }
    end,
    weight = 0.66,
    cost = 8,
    kind = "VisibilityPack",

    create_card = function(self, card, i)
        local _types = {}
        for k, v in ipairs(SMODS.ConsumableType.ctype_buffer) do
            _types[#_types + 1] = v
        end
        local type = pseudorandom_element(_types, pseudoseed('bmp'))
        return SMODS.create_card({
            set = type,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'consumeables',

    in_pool = function() return true end
}

SMODS.Booster{
    key = 'black_market_mega_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_visibility_pack",
    pos = { x = 2, y = 3 },
    discovered = true,
    unlocked = true,

    draw_hand = false,
    config = {
        extra = 5,
        choose = 2,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("bdc3c7") } } }
    end,
    weight = 0.66,
    cost = 10,
    kind = "VisibilityPack",

    create_card = function(self, card, i)
        local _types = {}
        for k, v in ipairs(SMODS.ConsumableType.ctype_buffer) do
            _types[#_types + 1] = v
        end
        local type = pseudorandom_element(_types, pseudoseed('bmp'))
        return SMODS.create_card({
            set = type,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'consumeables',

    in_pool = function() return true end
}

SMODS.Booster{
    key = 'divine_normal_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_divine_pack",
    pos = { x = 3, y = 3 },
    discovered = true,
    unlocked = true,

    draw_hand = true,
    config = {
        extra = 3,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("B4CEFF") } } }
    end,
    weight = 0.66,
    cost = 4,
    kind = "Divine",

    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "Divine",
            area = G.pack_cards,
            skip_materialize = true,
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Divine)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Divine, special_colour = G.C.CHIPS, contrast = 2 })
    end,
    --select_card = 'consumeables',

    in_pool = function() return true end
}

SMODS.Booster{
    key = 'divine_normal_2',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_divine_pack",
    pos = { x = 4, y = 3 },
    discovered = true,
    unlocked = true,

    draw_hand = true,
    config = {
        extra = 3,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("B4CEFF") } } }
    end,
    weight = 0.66,
    cost = 4,
    kind = "Divine",

    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "Divine",
            area = G.pack_cards,
            skip_materialize = true,
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Divine)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Divine, special_colour = G.C.CHIPS, contrast = 2 })
    end,
    --select_card = 'consumeables',

    in_pool = function() return true end
}

SMODS.Booster{
    key = 'divine_jumbo_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_divine_pack",
    pos = { x = 5, y = 3 },
    discovered = true,
    unlocked = true,

    draw_hand = true,
    config = {
        extra = 5,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("B4CEFF") } } }
    end,
    weight = 0.66,
    cost = 6,
    kind = "Divine",

    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "Divine",
            area = G.pack_cards,
            skip_materialize = true,
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Divine)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Divine, special_colour = G.C.CHIPS, contrast = 2 })
    end,
    --select_card = 'consumeables',

    in_pool = function() return true end
}

SMODS.Booster{
    key = 'divine_mega_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_divine_pack",
    pos = { x = 6, y = 3 },
    discovered = true,
    unlocked = true,

    draw_hand = true,
    config = {
        extra = 5,
        choose = 2,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("B4CEFF") } } }
    end,
    weight = 0.66,
    cost = 8,
    kind = "Divine",

    create_card = function(self, card, i)
        ease_background_colour(HEX("B4CEFF"))
        return SMODS.create_card({
            set = "Divine",
            area = G.pack_cards,
            skip_materialize = true,
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Divine)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Divine, special_colour = G.C.CHIPS, contrast = 2 })
    end,
    --select_card = 'consumeables',

    in_pool = function() return true end
}