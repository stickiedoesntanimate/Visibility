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
            'Visibility cards',
        }
    },
    boss = {  min = 8 },
    boss_colour = HEX('ffffff'),

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