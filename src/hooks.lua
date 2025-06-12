local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.visibility_rate = 0 -- Poptart
    ret.last_spectral = nil -- Pact
    return ret
end

-- Hook for Pact
local scu = set_consumeable_usage
function set_consumeable_usage(card)
    scu(card)
    if not (card.config.center_key and card.ability.consumeable) then return end
    if card.config.center.set == 'Spectral' then 
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.GAME.last_spectral = card.config.center_key
                        return true
                    end
                }))
                return true
            end
        }))
    end
    G:save_settings()
end

-- Bugfix for Ankh in Black Market Pack
local cu = Card.check_use
function Card:check_use()
    if self.ability.name == "Ankh" and G.pack_cards and G.pack_cards.cards then
        for _, v in ipairs(G.pack_cards.cards) do
            if v == self then
                return false
            end
        end
    end
    
    local ret = cu(self)
    return ret
end

