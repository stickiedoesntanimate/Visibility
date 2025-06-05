return {
    descriptions = {
        Back={},
        Blind={},
        Edition={},
        Enhanced={
            m_vis_notebook = {
                name = "Notebook Page",
                text = {
                    "{C:green}#1# in #3#{} chance",
                    "for {C:chips}+#2#{} Chips",
                    "{C:green}#1# in #5#{} chance",
                    "to win {C:money}$#4#",
                }
            },
        },
        Joker={
            j_vis_unemployed = {
                name = "Unemployed Joker",
                text = {
                    "Spawns a {C:dark_edition}negative{} food Joker",
                    "with {C:gold}$-1{} sell value that",
                    "is {C:mult}destroyed{} at the end of the round",
                }
            },
            j_vis_monolith = {
                name = "Monolith",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult for every played hand",
                    "that is not {C:attention}#2#{} or {C:attention}#3#{}",
                    "Hands {C:attention}change{} every played hand,",
                    "{C:red}resets{} when either is played",
                    "{C:inactive}(Currently: {X:mult,C:white}X#4#{} {C:inactive}Mult)",
                }
            },
            j_vis_garrab = {
                name = "Garrab",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult for every {C:blue}hand",
                    "remaining at the end of the round",
                    "{C:inactive}(Currently: {X:mult,C:white}X#2#{} {C:inactive}Mult)",
                }
            },
            j_vis_stoner = {
                name = "Stoner Joker",
                text = {
                    "Each played",
                    "{C:attention}Stone Card{} and {C:attention}Brick Card",
                    "gives {X:mult,C:white}X1.3{} Mult",
        
                }
            },
            j_vis_monochromatic_joker = {
                name = 'Monochromatic Joker',
                text = {
                    "{C:green}#1# in #2#{} chance to change a non-edition joker into a",
                    "{C:dark_edition}negative{} after defeating the {C:mult}Boss Blind{}",
                }
            },
            j_vis_lean = {
                name = 'Lean',
                text = {
                    "Playing a {C:attention}three of a kind{} discards",
                    "{C:attention}all{} cards from hand",
                }
            },
            j_vis_job = {
                name = "Job Application",
                text = {
                    "{C:green}#1# in #2#{} chance to create a {C:tarot}Judgement{}",
                    "when a {C:attention}Full House{} is played",
                    "{C:green}#1# in #3#{} chance to create a {C:spectral}Wraith{}",
                    "when a {C:attention}Flush House{} is played"
                }
            },
            j_vis_hanged_joker = {
                name = 'Hanged Joker',
                text = {
                    "{C:red}+#1#{} Mult for every",
                    "{C:attention}hanged man {}used this run",
                    "{C:inactive}(Currently: {C:mult}+#2# {C:inactive}Mult)"
                }
            },
            j_vis_ghost_print = {
                name = "Ghost Print",
                text = {
                    "{C:green}#1# in #2#{} chance to retrigger",
                    "every played card",
                }
            },
            j_vis_god_complex = {
                name = 'God Complex',
                text = {
                    "At the end of round, gain {C:gold}+$#1#{}",
                    "for all {C:blue}hands{} remaining",
                    "{s:2}BUT",
                    "{C:attention}-#2# Hand Size{} every time a {C:mult}discard{} is used"
                }
            },
            j_vis_living_card = {
                name = "Living Card",
                text = {
                    "{C:attention}Aces{} are also considered as {C:attention}Kings",
                    "{C:attention}Queens{} and {C:attention}Jacks{}"
                }
            },
            j_vis_crystal_geode = {
                name = "Crystal Geode",
                text = {
                    "All {C:attention}scored{} Rankless and Suitless cards",
                    "Balance {C:mult}Mult{} and {C:chips}Chips{} by {C:attention}#1#%{}",
                }
            },
            j_vis_gambling_addict = {
                name = "Gambling Addict",
                text = {
                    "{C:green}#1# in #2#{} chance for",
                    "{X:mult,C:white}X#3#{} Mult",
                    "{X:chips,C:white}X#4#{} Chips",
                    "and gaining {C:gold}$#5#",
                    "{s:2}BUT",
                    "lose {C:gold}$#6#{} for every hand played"
                }
            },
            j_vis_sd_card = {
                name = "Standard SD Card",
                text = {
                    "{C:attention}+#1#{} consumable slots",
                }
            },
            j_vis_the_cooler_sd_card = {
                name = "The Cooler SD Card",
                text = {
                    "{C:attention}+#1#{} consumable slots",
                }
            },
            j_vis_atomic_bomb = {
                name = "Atomic Bomb",
                text = {
                    "Disables the current boss blind when sold and",
                    "{C:red}destroys{} {C:attention}all{} random cards in hand"
                }
            },
            j_vis_alternate = {
                name = "Alternate",
                text = {
                    "{C:attention}Copies{} the abillity of",
                    "the joker to the right, but it is",
                    "{C:mult}debuffed{} until you change the Joker it's copying",
                }
            },
            j_vis_poker_face = {
                name = "Poker Face",
                text = {
                    "This Joker gains {X:chips,C:white} X#1# {} Mult",
                    "every time a {C:attention}Lucky{} card",
                    "{C:green}successfully{} triggers",
                    "{C:inactive}(Currently {X:chips,C:white} X#2# {C:inactive} Chips)",
                },
            },
            j_vis_building_bricks = {
              name = "Building Bricks Joker",
              text = {
                  "Adds one {C:attention}Plastic{} card",
                  "to deck when",
                  "{C:attention}Blind{} is selected",
              }
            },
            j_vis_biker = {
                name = "Biker",
                text = {
                    "{C:mult}+#1#{} Mult,",
                    "{C:red}-#2#{} discards",

                }
            },
            j_vis_fridge = {
                name = 'Fridge',
                text = {
                    "Gains {C:chips}+#1#{} Chips",
                    "if played hand",
                    "contains a {C:attention}Full House{} and",
                    "contains every suit",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_vis_estrogen = {
                name = 'Estrogen',
                text = {
                    "Using {C:attention}strength {}or {C:attention}weakness {}",
                    "forces selected cards to be made queens",
                }
            },
            j_vis_echo_chamber = {
                name = "Echo Chamber",
                text = {
                    "When a {C:mult}Boss Blind{} is defeated",
                    "create a {C:attention,T:tag_double}#1#"
                }
            },
            j_vis_crystal_dice = {
                name = 'Crystal Dice',
                text = {
                    "All {C:green}odds{} are guaranteed",
                    "{s:2}BUT",
                    "{C:mult}self destruct {}after one round",
                    "{C:inactive,s:0.7}handle with care... it will not appear again."
                }
            },
            j_vis_cave_man = {
                name = 'Cave Man',
                text = {
                    "Playing a {C:attention}Stone Card{} has a",
                    "{C:green}#1# in #2#{} chance to create",
                    "a {C:purple}Tarot Card",
                    "{C:inactive}(must have room)"
                }
            },
            j_vis_brick_up = {
                name = "Brick up",
                text = {
                    "Retriggers every",
                    "{C:attention}Stone Card{} and {C:attention}Brick Card",
                    "{C:attention}1{} additional time"
        
                }
            },
            j_vis_atom = {
                name = "Atom",
                text = {
                    "{C:chips}+#1#{} Chips"
                }
            },
            j_vis_blood_pact = {
                name = 'Blood Pact',
                text = {
                    "Played {C:attention}6{}s are {C:mult}destroyed{}",
                    "after scoring in exchange for a red seal on",
                    "a random card in hand",
                }
            },
            j_vis_3d_glasses = {
                name = "3D Glasses",
                text = {
                    "{X:chips,C:white}X#1#{} Chips if all",
                    "cards held in hand",
                    "are {C:diamonds}#2#{} or {C:hearts}#3#{}",
                },
            },
            j_vis_pama = {
                name = "P.A.M.A.",
                text = {
                    "During scoring,",
                    "{C:blue}Blue Seals{} are treated as {C:red}Red Seals{} and",
                    "{C:purple}Purple Seals{} are treated as {C:gold}Gold Seals",
                    "and in hand,",
                    "{C:red}Red Seals{} are treated as {C:blue}Blue Seals{} and",
                    "{C:gold}Gold Seals{} are treated as {C:purple}Purple Seals",
                    "{C:inactive,s:0.7}\"You will be made useful!\""
                },
            },
            j_vis_wholesale_card = {
                name = "Wholesale Card",
                text = {
                    "Everything is {C:attention}25%{} cheaper",
                    "{C:inactive,s:0.7}(stacks with vouchers)",
                },
            },
            j_vis_rv_lab = {
                name = "RV Lab",
                text = {
                    "Each {C:attention}Jack{}",
                    "held in hand",
                    "gives {X:chips,C:white} X#1# {} Chips",
                },
            },
            j_creamer = {
                name = "Creamer",
                text = {
                    "At the end of the round",
                    "create a {C:attention}random{} tag",
                    "gets destroyed after 3 rounds",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#3# rounds)",
                }
            },
            j_vis_d20 = {
                name = "Oops all.. hold on-",
                text = {
                    "{C:green}#1# in #2#{} chance to also restock",
                    "{C:attention}booster packs{} in the shop when {C:green}rerolling{}",
                },
            },
            j_vis_middle_of_nowhere = {
                name = "Middle of Nowhere",
                text = {
                    "All {C:attention}scored{} cards are retriggered {C:attention}#1#{} times",
                    "if {C:attention}#2# {C:red}discards{} were used",
                },
            },
            j_vis_all_eyes_on_you = {
                name = "All eyes on you",
                text = {
                    "Destroyed {C:attention}7{}s, {C:attention}8{}s and {C:attention}9{}s",
                    "spawn a {C:tarot}Death{}",
                    "{C:inactive}(must have room)",
                },
            },
            j_vis_caution_sign = {
                name = "Caution Sign",
                text = {
                    "Retriggers the first",
                    "{C:attention}card held in hand {C:attention}#1#{} additional times",
                }
            },
            j_vis_teto = {
                name = "Teto",
                text = {
                    "Discarding a {C:attention}Two Pair{} creates an",
                    "{C:green}Uncommon Tag{}, works once per round",
                    -- Invisible I swear to god stop breaking the localization
                    "{C:inactive}#1#",
                },
            },
        },
        Other={},
        Planet={},
        Spectral={
            c_vis_chaos = {
                name = "Chaos",
                text = {
                    "Gain two {C:attention}random{} tags"
                }
            },
            c_vis_vault = {
                name = "Vault",
                text = {
                    "Mark {C:attention}1{} selected Joker as {C:attention}Eternal",
                }
            },
            c_vis_hamsa = {
                name = 'Hamsa',
                text = {
                    "Summon a {C:legendary,E:1}Legendary{} Joker",
                    "{s:2}BUT",
                    "{C:blue}-1{} hand"
                }
            },
            c_vis_mortal = {
                name = 'Mortal',
                text = {
                    "Summon a {C:attention}random{} {C:dark_edition}negative{}",
                    "{C:common}Common{} Joker, and sets money to {C:gold}$0{}",
                }
            },
            c_vis_spire = {
                name="Spire",
                text={
                    "Add a {V:1}Bronze Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },
        },
        Stake={},
        Tag={},
        Tarot={
            c_vis_echo = {
                name = "Echo",
                text = {
                    "Create a {C:attention}copy{} of a random",
                    "Joker that is {C:attention}debuffed{} at the end of the round",
                }
            },
            c_vis_mortal = {
                name = "Mortal",
                text = {
                    "Summon a random {C:dark_edition}negative{} {C:common}Common{} Joker",
                }
            },
        },
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_shuffle = "Shuffled!",
            k_restock = "Restocked!",
            k_plus_plastic = "+1 Plastic"
        },
        high_scores={},
        labels={},
        poker_hand_descriptions={
            ["vis_industrialization"] = {'Five Brick Cards'}
        },
        poker_hands={
            ["vis_industrialization"] = "Industrialization"
        },
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            k_plus_x_tarot="+#1# Tarot",
            k_pbalanced = "Balanced by #1#%"
        },
        v_text={},
    },
}