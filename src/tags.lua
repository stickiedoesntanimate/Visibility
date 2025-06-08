--[[SMODS.Tag {
    key = "black_tag",
    loc_txt = {
        name = "Black Market Tag",
        text = 
        "Gives a {C:attention}Black Market{} pack"
    },
    atlas = "TexturesAtlasTags",
    pos = { x = 0, y = 0},
    min_ante = 2,

    apply = function(self, tag, context)
        tag:yep('+', G.C.DARK_EDITION, print() )
        print("hello")

        tag.triggered = true
        return true
    end,
}]]

SMODS.Tag {
    key = "divine",
    atlas = "TextureAtlasTags",
    pos = { x = 0, y = 0 },
    apply = function(self, tag, context)
        if context.type == 'store_joker_create' then
            local card = create_card('Spectral', context.area, nil, 1, nil, nil, nil, 'sta')
            create_shop_card_ui(card, 'Spectral', context.area)
            return card
        elseif context.type == 'shop_final_pass' then
            tag:yep('+', G.C.DARK_EDITION, function() tag.triggered = true return true end)
            return true
        end
    end,
    in_pool = function (self, args)
        return false -- Cannot appear in skip pool
    end
}
