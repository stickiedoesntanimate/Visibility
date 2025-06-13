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
    "cosplayer",
    "conquian",
    "forged",
    "carnation",
    "totem", 
    "party_noob",
    "golbo",
    "conspiracy",
    "minuteman",
    "9_ball",
    "handicap_parking",
    "delirious", -- Works mostly, known issue: Texture disappears when loading the run
}

-- There's probably a better way to do this, but I have no idea.
local consumables_list = {
    "type",
    "divine/constant",
    "divine/crystal_ball",
    "divine/echo",
    "divine/future",
    "divine/mint",
    "divine/shore",
    "divine/slate",
    "divine/weakness",
    "spectral/calamity",
    "spectral/chaos",
    "spectral/denial",
    "spectral/desideratum",
    "spectral/hamsa",
    "spectral/mortal",
    "spectral/pact",
    "spectral/spire",
    "spectral/vault",
    "blackmarket/gum",
    "blackmarket/nails"
}

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
}

assert(SMODS.load_file('src/textures.lua'))()
assert(SMODS.load_file('src/blinds.lua'))()
assert(SMODS.load_file('src/enhancements.lua'))()
assert(SMODS.load_file('src/vouchers.lua'))()
assert(SMODS.load_file('src/backs.lua'))()
assert(SMODS.load_file('src/hooks.lua'))()
assert(SMODS.load_file('src/seals.lua'))()
assert(SMODS.load_file('src/boosters.lua'))()
assert(SMODS.load_file('src/objecttypes.lua'))()
assert(SMODS.load_file('src/hands.lua'))()
--assert(SMODS.load_file('src/sticker.lua'))()
assert(SMODS.load_file('src/tags.lua'))()

for _, joker in ipairs(joker_list) do
    local joker_path = 'src/jokers/' .. joker .. '.lua'
    assert(SMODS.load_file(joker_path))()
end

for _, consumable in ipairs(consumables_list) do
    local consumable_path = 'src/consumables/' .. consumable .. '.lua'
    assert(SMODS.load_file(consumable_path))()
end

----------------------------------------------
------------MOD CODE END----------------------
