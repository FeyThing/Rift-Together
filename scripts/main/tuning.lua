
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
            NEFARIOUS = {},
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
    NEFARIOUS_ENERGY = 100,
    NEFARIOUS_ENERGY_COST = 1,
    
    STEALTH = {
        KEY = GetModConfigData("vkey") or 118,
    },
    
    COMBAT = {
        KEY = GetModConfigData("ckey") or 99,
    },
    
    SHIELDING = {
        KEY = GetModConfigData("zkey") or 122,
    },
    
    NEFARIOUS_HEALTH = 200,
    NEFARIOUS_HEALTH_ABSORB = .30,
    NEFARIOUS_HUNGER = 175,
    NEFARIOUS_SANITY = 150,
    
    RATCHET_HEALTH = 100,
    RATCHET_HUNGER = 150,
    RATCHET_SANITY = 200,
    RATCHET_RADIATION = 100,
    
    RAD_TOTAL = 100,
    
    RAD_EFFECT_RANGE = 5,
    RAD_AURA_SEARCH_RANGE = 10,
    
    RADIATION_SMALL = 2,
    RADIATION_MED = 5,
    RADIATION_LARGE = 10,
    RADIATION_HUGE = 20,
    RADIATION_GIANT = 30,
    
    RAD_THRESH = .6,
    
    IRRADIATED = 1,
    
    RAD_INJECT_DAMAGE = 75,
    RAD_INJECT_MIN_HEALTH = 5,
    
    RAD_IMMUNE_DURATION = total_day_time, -- the time you are immune to radiation after taking antivenom
    RAD_DAMAGE_PER_INTERVAL = 2, -- the amount of health damage radiation causes per interval
    RAD_INTERVAL = 10, -- how frequently damage is applied

    RAD_DAMAGE_MOD = -.25,
    RAD_ATTACK_PERIOD_MOD = .25,
    RAD_SPEED_MOD = .75,
    
    AREA_RAD_CHECK_INTERVAL = .5, -- How frequently radiation checks for nearby entities to infect
    
    RAD_SANITY_SCALE = .05, -- sanity hit = radiation hit * RAD_SANITY_SCALE  set to 0 to turn off
}

TransferTable(tunings, TUNING)