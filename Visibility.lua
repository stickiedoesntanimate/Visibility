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

assert(SMODS.load_file('src/jokers.lua'))()
assert(SMODS.load_file('src/consumables.lua'))()

----------------------------------------------
------------MOD CODE END----------------------
