SMODS.Shader({key = 'tinted', path = "tinted.fs"})

SMODS.Edition {
    key = "tinted",
    discovered = false,
    unlocked = true,
    shader = 'tinted',
    loc_txt = {
        name = "Tinted",
        text = {
            "{C:money}$#1#{} of",
            "{C:attention}sell value{} at",
            "end of round",
        },
    },
    config = { price = 3 },
    in_shop = true,
    weight = 20,
    extra_cost = 4,
    apply_to_float = true,
    sound = { sound = "foil1", per = 1.2, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.price } }
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra_value = (card.ability.extra_value or 0) + self.config.price
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}


--[[SMODS.Shader{key = "shiny", path = "shiny.fs"}

SMODS.Edition {
    key = "shiny",
    shader = 'vis_shiny',
    loc_txt = {
        name = "Shiny",
        text = {
            "{C:money}$#1#{} dollars",
        },
    },
    config = { extra = { money = 2 } },
    in_shop = true,
    weight = 20,
    extra_cost = 2,
    sound = { sound = "foil1", per = 1.2, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.extra.money } }
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_dollars(card.edition.extra.money, false)
                    return true
                end
            }))
            return { message = "Oooh..." }
        end
    end,
}
--]]