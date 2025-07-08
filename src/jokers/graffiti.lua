SMODS.Joker {
	key = "graffiti",
	config = { },
	rarity = 2,
	cost = 6,
	discovered = true,
	unlocked = true,
	eternal_compat = true,
	blueprint_compat = false,
	pools = { ["Visibility"] = true },
	atlas = "TextureAtlasJokers",
	pos = { x = 5, y = 4 },
	loc_vars = function (self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[("m_stone")]
		info_queue[#info_queue + 1] = G.P_CENTERS[("m_vis_brick")]
		info_queue[#info_queue+1] = G.P_CENTERS.m_wild
	end
}