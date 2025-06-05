local joker_list = {
    "atom",
    "blood_pact",
    "brick_up",
    "cave_man",
    "crystal_dice",
    "echo_chamber",
    "estrogen",
    "fridge",
    "ghost_print",
    "god_complex",
    "hanged_joker",
    "job_application",
    "lean",
    "monochromatic",
    "stoner_joker",
    "unemployed",
    "gambling_addict",
    "3d_glasses",
    "biker",
    "poker_face",
    "garrab",
    "sd_card",
    "crystal_geode",
    "atomic_bomb",
    "alternate",
    "caution_sign",
    "pama",
    "wholesale_card",
    "rv_lab",
    "monolith",
    "d20",
    "living_card",
    "building_bricks",
    "middle_of_nowhere",
    "all_eyes_on_you",
    "creamer",
    "teto",
    "yo_gurt", -- Gurt: Yo
    -- "totem", THERE IS SOMETHING WRONG WITH THIS JOKER. End credits
}

assert(SMODS.load_file('src/textures.lua'))()
assert(SMODS.load_file('src/consumables.lua'))()
assert(SMODS.load_file('src/enhancements.lua'))()
assert(SMODS.load_file('src/vouchers.lua'))()
assert(SMODS.load_file('src/backs.lua'))()
assert(SMODS.load_file('src/hooks.lua'))()
assert(SMODS.load_file('src/seals.lua'))()
assert(SMODS.load_file('src/boosters.lua'))()
assert(SMODS.load_file('src/objecttypes.lua'))()
assert(SMODS.load_file('src/hands.lua'))()

for _, joker in ipairs(joker_list) do
    local joker_path = 'src/jokers/' .. joker .. '.lua'
    assert(SMODS.load_file(joker_path))()
end


----------------------------------------------
------------MOD CODE END----------------------
