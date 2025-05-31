SMODS.Joker:take_ownership("baron",
{
    calculate = function (self, card, context)
        if not context.end_of_round and context.individual and context.cardarea == G.hand then
            if context.other_card:get_id() == 13 or (context.other_card:get_id() == 14 and next(SMODS.find_card("j_vis_living_card"))) then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                else
                    return {
                        x_mult = card.ability.extra,
                        card = card
                    }
                end
            end
        end
    end,
},
true
)

SMODS.Joker:take_ownership("hit_the_road",
{
    calculate = function (self, card, context)
        if context.discard then
            if not context.other_card.debuff and not context.blueprint and (context.other_card:get_id() == 11 or (context.other_card:get_id() == 14 and next(SMODS.find_card("j_vis_living_card")))) then
                card.ability.x_mult = card.ability.x_mult + card.ability.extra
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
                        colour = G.C.RED,
                        delay = 0.45, 
                    card = card
                }
            end
        end
    end,
},
true
)

SMODS.Joker:take_ownership("shoot_the_moon",
{
    calculate = function (self, card, context)
        if not context.end_of_round and context.individual and context.cardarea == G.hand then
            if context.other_card:get_id() == 12 or (context.other_card:get_id() == 14 and next(SMODS.find_card("j_vis_living_card"))) then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                else
                    return {
                        h_mult = 13,
                        card = card
                    }
                end
            end
        end
    end,
},
true
)


SMODS.Joker:take_ownership("triboulet",
{
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 12 or context.other_card:get_id() == 13 or (context.other_card:get_id() == 14 and next(SMODS.find_card("j_vis_living_card")))) then
                return {
                    x_mult = card.ability.extra,
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end,
},
true
)


SMODS.Joker {
    key = "living_card",
    blueprint_compat = false,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 9, y = 9 },
    rarity = 2,
    cost = 5,
}

local card_is_face_ref = Card.is_face
function Card:is_face(from_boss)
    return card_is_face_ref(self, from_boss) or (self:get_id() == 14 and next(SMODS.find_card("j_vis_living_card")))
end