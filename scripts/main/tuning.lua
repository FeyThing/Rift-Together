
local seg_time = 30
local total_day_time = seg_time*16

local day_segs = 10
local dusk_segs = 4
local night_segs = 2

--default day composition. changes in winter, etc
local day_time = seg_time * day_segs
local dusk_time = seg_time * dusk_segs
local night_time = seg_time * night_segs

local multiplayer_attack_modifier = 1--0.6--0.75
local multiplayer_goldentool_modifier = 1--0.5--0.75
local multiplayer_armor_durability_modifier = 0.7
local multiplayer_armor_absorption_modifier = 1--0.75
local multiplayer_wildlife_respawn_modifier = 1--2

local wilson_attack = 34 * multiplayer_attack_modifier
local wilson_health = 150
local wilson_hunger = 150
local wilson_sanity = 200
local calories_per_day = 75

local wilson_attack_period = 0.4 --prevents players

local tunings = {
    GAMEMODE_STARTING_ITEMS = {
        DEFAULT = {
            RATCHET = { "owrench", "nanoboost" },
            --NEFARIOUS = {},
        },
    },

    STARTING_ITEM_IMAGE_OVERRIDE = {
        owrench = {
            atlas = atlas,
            image = "owrench.tex",
        },
        nanoboost = {
            atlas = atlas,
            image = "nanoboost.tex",
        },
    },

    CHARACTERS_MAX_RADIATION = {
        -- Base characters
        WILSON = 100,
        WILLOW = 100,
        WENDY = 80,
        WOLFGANG = 150,
        WX78 = 200,
        WICKERBOTTOM = 100,
        WES = 55,
        WAXWELL = 120,
        WOODIE = 150,
        WATHGRITHR = 150,
        WEBBER = 200,
        WINONA = 100,
        WORTOX = 150, 
        WORMWOOD = 200, 
        WARLY = 100, 
        WURT = 100, 
        WALTER = 100, 
        WANDA = 100,
        WONKEY = 100, 
        RATCHET = 120,

        -- Cherry Forest characters
        WHIRLYWINGS = 150,

        -- Island Adventures characters
        WALANI = 100,
        WILBER = 100,
        WOODLEGS = 150,

        -- Uncompromising Mode characters
        WINKY = 200,
        WATHOM = 150,
        WIXIE = 100
    },

    MAX_RADIATION_DEFAULT = 100,

    ROBOT_RADIATION_RESISTANCE = .35,

	RT_UNCOMP = {
	    GetModConfigData("rt_um"),
	},
	RT_CHERRY = {
	    GetModConfigData("rt_cf"),
	},
	RT_ISLAND = {
	    GetModConfigData("rt_ia"),
	},
	RT_DEHYDRATED = {
	    GetModConfigData("rt_dm"),
	},
	
	RT_SHOES = {
	    GetModConfigData("rt_shoe"),
	},

    RIFT_TOGETHER_OST = {
	    GetModConfigData("rt_music"),
	},
	
	DAMAGETYPE_BONUS = {
		bludgeoning = {
			DEFAULT = 1,
		},
		piercing = {
			DEFAULT = 1,
		},
		slashing = {
			DEFAULT = 1,
		},
		fire = {
			DEFAULT = 1,
		},
		electric = {
			DEFAULT = 1,
		},
		ice = {
			DEFAULT = 1,
		},
		shadow = {
			DEFAULT = 1,
		},
		lunar = {
			DEFAULT = 1,
		},
	},
	
	DAMAGETYPE_RESISTANCE = {
		bludgeoning = {
			DEFAULT = 0.5,
		},
		piercing = {
			DEFAULT = 0.5,
		},
		slashing = {
			DEFAULT = 0.5,
		},
		fire = {
			DEFAULT = 0.5,
		},
		electric = {
			DEFAULT = 0.5,
		},
		ice = {
			DEFAULT = 0.5,
		},
		shadow = {
			DEFAULT = 0.5,
		},
		lunar = {
			DEFAULT = 0.5,
		},
	},
	
	DAMAGETYPE_VULNERABILITY = {
		bludgeoning = {
			DEFAULT = 1.5,
			slurtle = 0.5 / (1 - TUNING.SLURTLE_SHELL_ABSORB), -- This vulnerability is only active when they're in their shell
			snurtle = 0.5 / (1 - TUNING.SLURTLE_SHELL_ABSORB), -- Do 0.5 damage against it (instead of 0.05)
		},
		piercing = {
			DEFAULT = 1.5,
		},
		slashing = {
			DEFAULT = 1.5,
		},
		fire = {
			DEFAULT = 1.5,
		},
		electric = {
			DEFAULT = 1.5,
		},
		ice = {
			DEFAULT = 1.5,
		},
		shadow = {
			DEFAULT = 1.5,
		},
		lunar = {
			DEFAULT = 1.5,
		},
	},
	
	ARMOREDBODY_ATTACKWEAR_MULT = 4,
	
	ARMOR_RARITANIUM = wilson_health * 6 * multiplayer_armor_durability_modifier,
	ARMOR_RARITANIUM_ABSORPTION = 0.8 * multiplayer_armor_absorption_modifier,
	ARMOR_RARITANIUM_EXPLOSIVE_RESIST = 0.2,
	
	RT_FILTER_SMALL_PERISHTIME = total_day_time * 1,
	RT_FILTER_LARGE_PERISHTIME = total_day_time * 6,
	
	RESPIRATORMASK_PERISHTIME = total_day_time * 5,
	RESPIRATORMASK_RAD_PROTECTION = 0.2,
	
	HAZHAT_PERISHTIME = total_day_time * 10,
	HAZMAT_PERISHTIME = total_day_time * 10,
	
	RT_AIR_PURIFIER_MAX_FUEL_TIME = total_day_time * 5,
	RT_AIR_PURIFIER_RADIUS = 10,
	
	STARFRUITVINE_SPAWN_TIME_MIN = total_day_time,
	STARFRUITVINE_SPAWN_TIME_VARIANCE = total_day_time * 2,
	STARFRUITVINE_GROW_TIME = total_day_time,
	
	--- Biomes


--- Character moved for later release
    --[[NEFARIOUS_ENERGY = 100,
    NEFARIOUS_ENERGY_COST = 1,
        
    NEFARIOUS_HEALTH = 200,
    NEFARIOUS_HEALTH_ABSORB = .30,
    NEFARIOUS_HUNGER = 175,
    NEFARIOUS_SANITY = 100,
	NEFARIOUS_RADIATION = 200,]]

    RATCHET_HEALTH = 125,
	
    RATCHET_HUNGER = 150,
	
    RATCHET_SANITY = 200,
    
	---Shoes Mod
	SHOES_HOVER_SPEED = 1 + ((GetModConfigData("shoes_hover_speed") or 20) * 0.01),
	SHOES_HOVER_COMBAT_TIME = GetModConfigData("shoes_hover_speed_combat") or 5,

	---- Ocean
	
	TOXIC_RADIUS = 1,
	TOXIC_TILE_RADIUS = 5,
	
	
	---- Weather
	DUSTDEVIL_LIFETIME = 50,
	DUSTDEVIL_DAMAGE = 27,
	
    --Pillar
    JUNK_SHADE_MAX_ROTATION = 0,
    JUNK_SHADE_ROTATION_SPEED = 0,
    JUNK_SHADE_MAX_TRANSLATION = 0,
    JUNK_SHADE_TRANSLATION_SPEED = 0,
    JUNK_SHADE_SCALE = 1,
    JUNK_SHADE_MIN_STRENGTH = 0.2,
    JUNK_SHADE_MAX_STRENGTH = 0.5,

	--- Creatures
	RT_PAWN_HEALTH = 200,
	RT_PAWN_DAMAGE = 10,
	RT_PAWN_TARGET_DIST = 10,
	RT_PAWN_PULSE_COOLDOWN = 10,
	RT_PAWN_PULSE_TRAP_LT = 5,

	----
	
    RADIATION_THRESH = {
        LOW = {
            ENTER = .375
        },
        MED = {
            ENTER = .575
        },
        HIGH = {
            ENTER = .775
        },
        CRITICAL = {
            ENTER = .925
        }
    },

    RADIATION_STATE_HIGH_DMG = 0.25,
    RADIATION_STATE_CRITICAL_DMG = 1,

    RADIATION_SMALL = 2,
    RADIATION_MED = 5,
    RADIATION_LARGE = 10,
    RADIATION_HUGE = 20,
    RADIATION_GIANT = 30,


    MAX_TILE_RAD = 100,
    TILE_RAD_INTAKE_FACTOR = 1/25;

    ALLOW_BUTTERFLY_SPAWN_RADIATION_LIMIT = 20, -- The maximum radiation value the tile can have to still allow butterflies to spawn
    START_MOONMOTH_SPAWN_RADIATION = 60, -- The minimum radiation value the tile has to have to spawn a moon moth

    ALLOW_BIRD_SPAWN_RADIATION_LIMIT = 20, -- The maximum radiation value the tile can have to still allow birds to spawn

    ROBOMUTTHERD = {
        MAX = 3,
        DELAY = 1420,
        VARIANCE = 560,
    },

    DIMENSIONAL_RIFTS = {
        MAX_AMOUNT = 2,
        TIME_VARIANCE = 480,

        LOOT_PREFABS = {
            nanotech                            = 5.0,
            petals                              = 5.0,
            trinket_4                           = 5.0,
            rarttaniumore                       = 2.0,
            monkeyisland_portal_fxloot          = 10.0,
            moonrocknugget                      = 5.0,
            hound_robomutt                      = 1.0,
            wetgoop                             = 5.0,
            twigs                               = 5.0,
        },

        STAGES = {
            { --FIRST
                LIGHT = 2,
                LOOTSPAWNTIME = 60,
                MAXLOOT = 10,
                SHAKECAMERA = {0.5, .01, .1, 50},
                AMBIENT_INTENSITY = 0.1,
                PHYSICS = 1.2,

                TIME = total_day_time*.75,
            },
            { --SECOND
                LIGHT = 5,
                LOOTSPAWNTIME = 45,
                MAXLOOT = 15,
                SHAKECAMERA = {1.0, .03, .2, 100},
                AMBIENT_INTENSITY = 0.4,
                PHYSICS = 2.2,

                TIME = total_day_time*1.25,
            }, --THIRD
            {
                LIGHT = 9,
                LOOTSPAWNTIME = 20,
                MAXLOOT = 25,
                SHAKECAMERA = {1.5, .06, .3, 200},
                AMBIENT_INTENSITY = 0.7,
                PHYSICS = 3.2,

                TIME = total_day_time*1.5,
            },
        },
    },
}

TransferTable(tunings, TUNING)