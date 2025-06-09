SMODS.Consumable {
    key = 'denial',
    set = 'Spectral',
    pos = { x = 6, y = 2 },
    discovered = true,
    unlocked = true,
    pools = { ["c_Spectral"] = true },
    atlas = "TextureAtlasConsumables",
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local candidates = {}

                -- Only include cards with NO edition
                for _, c in ipairs(G.hand.cards) do
                    if not c.edition then
                        table.insert(candidates, c)
                    end
                end

                if #candidates > 0 then
                    local target_card = pseudorandom_element(candidates, pseudoseed('vis_denial'))
                    target_card:set_edition('e_negative', true)
                    target_card:juice_up(0.3, 0.5)
                end

                return true
            end
        }))
    end,
    can_use = function(self, card)
        if not G.hand or #G.hand.cards == 0 then return false end

        -- Only usable if there's at least one card with no edition
        for _, c in ipairs(G.hand.cards) do
            if not c.edition then
                return true
            end
        end
        return false
    end
}