SMODS.Consumable {
    key = 'echo',
    set = 'Tarot',
    atlas = "TextureAtlasConsumables",
    discovered = true,
    unlocked = true,
    pools = { ["c_Visibility"] = true },
    pos = { x = 4, y = 0 },
    config = { },
    can_use = function (self, card)
        local all_jokers_unperishable = true
        if G.jokers and #G.jokers.cards > 0 then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config.center.perishable_compat then
                    all_jokers_unperishable = false
                    break
                end
            end
        end
        return G.jokers and ((#G.jokers.cards < G.jokers.config.card_limit) and (#G.jokers.cards > 0)) and not all_jokers_unperishable
    end,
    use = function (self, card, area, copier)
        local _perishable = {}
        if G.jokers and #G.jokers.cards > 0 then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config.center.perishable_compat then
                    _perishable[#_perishable + 1] = joker
                    break
                end
            end
        end
        local random_joker = pseudorandom_element(_perishable, pseudoseed('echo'))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                local copy = copy_card(random_joker)
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