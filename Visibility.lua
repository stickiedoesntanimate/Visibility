SMODS.Atlas {
	key = "TextureAtlasJokers",
	path = "TextureAtlasJokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "TextureAtlasConsumables",
	path = "TextureAtlasConsumables.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "TextureAtlasEnhancements",
	path = "TextureAtlasEnhancements.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "TextureAtlasVouchers",
	path = "TextureAtlasVouchers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "TextureAtlasVouchers",
	path = "TextureAtlasVouchers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "TextureAtlasDecks",
	path = "TextureAtlasDecks.png",
	px = 71,
	py = 95
}

assert(SMODS.load_file('src/jokers.lua'))()
assert(SMODS.load_file('src/consumables.lua'))()
assert(SMODS.load_file('src/enhancements.lua'))()
assert(SMODS.load_file('src/vouchers.lua'))()
assert(SMODS.load_file('src/backs.lua'))()
----------------------------------------------
------------MOD CODE END----------------------
