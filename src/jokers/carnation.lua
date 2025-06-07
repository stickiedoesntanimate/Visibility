SMODS.Joker {
    key = "carnation",
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    unlocked = true,
	discovered = true,
    atlas = "TextureAtlasJokers",
    pos = { x = 9, y = 0 },
    config = { },
    calculate = function(self, card, context)
        if context.selling_card and context.card == card then
            local _viable_jokers = {}
            for k, v in pairs(G.jokers.cards) do
                if not (v == context.card or v == card or v.ability.eternal) then
                    _viable_jokers[#_viable_jokers+1] = v
                end
            end
            print("Viable Jokers for replacement: "..#_viable_jokers)
            for k, v in pairs(_viable_jokers) do
                print(" - "..v.label.." (rarity: "..v.config.center.rarity..")")
            end
            if #_viable_jokers == 0 then
                return -- Welp, no jokers to replace
            end
            local joker_to_replace = pseudorandom_element(_viable_jokers, pseudoseed("carnation"))
            local joker_to_replace_rarity = joker_to_replace.config.center.rarity
            print("Picked "..joker_to_replace.label.." to replace by Carnation with rarity "..joker_to_replace.config.center.rarity)
            local stringified_rarity = "Common"
            if joker_to_replace_rarity == 2 then stringified_rarity = "Uncommon"
            elseif joker_to_replace_rarity == 3 then stringified_rarity = "Rare"
            elseif joker_to_replace_rarity == 4 then stringified_rarity = "Legendary" 
            end
            SMODS.add_card({ set = "Joker", rarity = stringified_rarity })
            joker_to_replace:remove_from_deck()
            joker_to_replace:start_dissolve(nil)
        end
    end
}