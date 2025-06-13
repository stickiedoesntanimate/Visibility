SMODS.Atlas({
    key = 'TextureAtlasBlinds',
    path = 'TextureAtlasBlinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    name = "boss_transparent",
    key = "boss_transparent",
    dollars = 5,
    mult = 2,
    atlas = 'TextureAtlasBlinds',
    pos = {x=0, y=0},
    loc_txt = {
        name = 'Transparent',
        text = {
            'Debuffs all',
            'Visibility Jokers',
        }
    },
    boss = { showdown = true },
    boss_colour = HEX('eb4bf8'),
    recalc_debuff = function(self, card)
        for i = 1, #G.jokers.cards do
            if not G.GAME.blind.disabled and G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Visibility then
                G.jokers.cards[i]:set_debuff(true)
            end
        end
    end,

    disable = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,

    defeat = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,
}

SMODS.Blind {
    name = "boss_flip",
    loc_txt = {
        name = 'The Flip',
        text = {
            "Playing a #1# sets",
            "the starting {C:mult}mult{} to {C:mult}-1{}",
        }
    },
    key = "boss_flip",
    dollars = 5,
    mult = 3,
    boss = { min = 4 },
    boss_colour = HEX('177CAD'),
    atlas = 'TextureAtlasBlinds',
    pos = {x=0, y=1},
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.modify_hand then
                if context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                    blind.triggered = true
                    mult = -1
                    update_hand_text({ sound = 'debuff1', modded = true }, { mult = mult })
                end
            end
        end
    end
}


