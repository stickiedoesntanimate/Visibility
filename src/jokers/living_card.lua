function Card:is_vfaces(from_boss)
    if self.debuff and not from_boss then return end
    local id = self:get_id()
    if id == 11 or id == 12 or id == 13 or next(find_joker("Pareidolia")) then
        return true
    end
end


SMODS.Joker {
    key = "living_card",
    blueprint_compat = false,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 5,
    pos = { x = 7, y = 0 },
}

local card_is_face_ref = Card.is_face
function Card:is_face(from_boss)
    return card_is_face_ref(self, from_boss) or (self:get_id() and next(SMODS.find_card("j_vis_living_card")))
end