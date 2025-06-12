SMODS.Consumable {
    key = 'echo',
    set = 'Divine',
    atlas = "TextureAtlasConsumables",
    discovered = true,
    unlocked = true,
    pools = { ["c_Visibility"] = true },
    pos = { x = 4, y = 0 },
    config = { },
    can_use = function (self, card)
        local has_valid_joker = false
        if G.jokers and #G.jokers.cards > 0 then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config.center.perishable_compat then
                    has_valid_joker = true
                    break
                end
            end
        end
        return G.jokers and ((#G.jokers.cards < G.jokers.config.card_limit) and (#G.jokers.cards > 0)) and has_valid_joker
    end,
    use = function (self, card, area, copier)
        local valid_jokers = {}
        for _, joker in ipairs(G.jokers.cards) do
            if joker.config.center.perishable_compat then
                table.insert(valid_jokers, joker)
            end
        end
        local random_joker = pseudorandom_element(valid_jokers, pseudoseed('echo'))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                local copy = copy_card(random_joker)
                if copy.set_eternal then
                    copy:set_eternal(false)
                else
                    copy.eternal = false 
                end
                copy:set_perishable(true)
                copy.ability.perish_tally = 1
                copy:add_to_deck()
                G.jokers:emplace(copy)
                play_sound('timpani')
                return true
            end
        }))
    end
}
