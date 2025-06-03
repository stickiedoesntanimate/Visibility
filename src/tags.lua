SMODS.Tag {
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
}
