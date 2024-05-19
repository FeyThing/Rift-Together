
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
local atlas = "images/rnc_inventoryimages.xml"

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
        WINKY = 120,
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
	
    RAD_TOTAL = 100,
    
    RAD_EFFECT_RANGE = 5,
    RAD_AURA_SEARCH_RANGE = 10,
    
    RADIATION_SMALL = 2,
    RADIATION_MED = 5,
    RADIATION_LARGE = 10,
    RADIATION_HUGE = 20,
    RADIATION_GIANT = 30,
    
    RAD_THRESH = .6,
	
	RAD_CORRODE_DAMAGE_TIME = 1.5, -- How quickly the game polls to deal acidrain damage.
    RAD_CORRODE_DAMAGE_PER_SECOND = 2.0,
	RAD_CORRODE_DAMAGE_FUELED_SCALER = 2.0,
    
    IRRADIATED = 1,
    
    RAD_INJECT_DAMAGE = 75,
    RAD_INJECT_MIN_HEALTH = 5,
    
    RAD_IMMUNE_DURATION = total_day_time, -- the time you are immune to radiation 
    RAD_DAMAGE_PER_INTERVAL = 2, -- the amount of health damage radiation causes per interval
    RAD_INTERVAL = 10, -- how frequently damage is applied

    RAD_DAMAGE_MOD = -.25,
    RAD_ATTACK_PERIOD_MOD = .25,
    RAD_SPEED_MOD = .75,
    
    AREA_RAD_CHECK_INTERVAL = .5, -- How frequently radiation checks for nearby entities to infect
    
    RAD_SANITY_SCALE = .05, -- sanity hit = radiation hit * RAD_SANITY_SCALE  set to 0 to turn off

	---- Ocean
	
	TOXIC_RADIUS = 1,
	TOXIC_TILE_RADIUS = 5,
	
	
	---- Weather
	DUSTDEVIL_LIFETIME = 50,
	DUSTDEVIL_DAMAGE = 27,
	

	--- Creatures
	RT_PAWN_HEALTH = 200,
	RT_PAWN_DAMAGE = 10,
	RT_PAWN_TARGET_DIST = 10,
	RT_PAWN_PULSE_COOLDOWN = 10,
	RT_PAWN_PULSE_TRAP_LT = 5,

	----
	
    RADIATION_THRESH = {
        LOW = {
            ENTER = .375,
            LEAVE = .35,
        },
        MED = {
            ENTER = .575,
            LEAVE = .55,
        },
        HIGH = {
            ENTER = .775,
            LEAVE = .75,
        },
        CRITICAL = {
            ENTER = .925,
            LEAVE = .90,
        }
    },

    RADIATION_AURA_SEACH_RANGE = 16,

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