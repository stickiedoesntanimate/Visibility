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
