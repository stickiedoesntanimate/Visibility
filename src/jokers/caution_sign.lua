SMODS.Joker {
    key = "caution_sign",
	discovered = true,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
    config = { extra = { repetition = 1, repetitions_done = 0 }},
    rarity = 1,
    atlas = "TextureAtlasJokers",
    pos = { x = 5, y = 3 },
    cost = 5,
    -- TODO: Fix this joker
    calculate = function(self, card, context)
        if context.before or context.after then
            card.ability.extra.repetitions_done = 0
            print("Resetting...")
        end
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
            print(inspect(context.card_effects[1]))
            if card.ability.extra.repetitions_done >= 2 then
                print("Done more than 2 repetitions, stopping.")
                return
            end
            print("Repetition: "..tostring(card.ability.extra.repetitions_done).." on "..context.other_card.label)
            card.ability.extra.repetitions_done = card.ability.extra.repetitions_done + 1
            return {
                repetitions = card.ability.extra.repetition,
                card = context.other_card
            }
        end
	end,
}