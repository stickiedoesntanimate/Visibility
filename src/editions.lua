SMODS.Shader{key = "shiny", path = "shiny.fs"}

SMODS.Edition {
    key = "shiny",
    shader = 'mvan_shiny',
    loc_txt = {
        name = "Shiny",
        text = {
            "{C:money}$#1#{} dollars",
        },
    },
    config = { p_dollars = 3 },
    in_shop = true,
    weight = 20,
    extra_cost = 2,
    sound = { sound = "foil1", per = 1.2, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.p_dollars } }
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            print("hi")
            return {
                dollars = card.edition.p_dollars
            }
        end
    end
}