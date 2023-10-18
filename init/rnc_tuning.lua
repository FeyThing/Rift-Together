local require = GLOBAL.require
local TUNING = GLOBAL.TUNING

--ENERGY
TUNING.NEFARIOUS_ENERGY = 100
TUNING.NEFARIOUS_ENERGY_COST = 1

GLOBAL.TUNING.STEALTH = {}
GLOBAL.TUNING.STEALTH.KEY = GetModConfigData("vkey") or 118

GLOBAL.TUNING.COMBAT = {}
GLOBAL.TUNING.COMBAT.KEY = GetModConfigData("ckey") or 99

GLOBAL.TUNING.SHIELDING = {}
GLOBAL.TUNING.SHIELDING.KEY = GetModConfigData("zkey") or 122

-- Nefarious's stats
TUNING.NEFARIOUS_HEALTH = 200
TUNING.NEFARIOUS_HEALTH_ABSORB = 0.30
TUNING.NEFARIOUS_HUNGER = 175
TUNING.NEFARIOUS_SANITY = 150

-- Ratchet's stats
TUNING.RATCHET_HEALTH = 100
TUNING.RATCHET_HUNGER = 150
TUNING.RATCHET_SANITY = 200
TUNING.RATCHET_RADIATION = 100

-- standard radiation
-- Ref SW poison. Unused stuff for now. Thinking about damage ramp as days go. Must test.
TUNING.RAD_TOTAL = 100

TUNING.RAD_EFFECT_RANGE = 5
TUNING.RAD_AURA_SEARCH_RANGE = 10


--TUNING.RADIATION_ENABLED = GetModConfigData("enable_creatures") == true and true or false

TUNING.RADIATION_SMALL = 2
TUNING.RADIATION_MED = 5
TUNING.RADIATION_LARGE = 10
TUNING.RADIATION_HUGE = 20
TUNING.RADIATION_GIANT = 30


TUNING.RAD_THRESH = .6

TUNING.IRRADIATED = 1

TUNING.RAD_INJECT_DAMAGE = 75
TUNING.RAD_INJECT_MIN_HEALTH = 5

TUNING.RAD_IMMUNE_DURATION = total_day_time -- the time you are immune to radiation after taking antivenom
TUNING.RAD_DAMAGE_PER_INTERVAL = 2 -- the amount of health damage radiation causes per interval
TUNING.RAD_INTERVAL = 10 -- how frequently damage is applied

-- Total radiation attack dmg = normal attack dmg + (RAD_DURATION/RAD_INTERVAL * RAD_DAMAGE_PER_INTERVAL)

--[[TUNING.RAD_DAMAGE_RAMP = {--Elapsed time must be greater than the time value for the associated damage_scale/fxlevel value to be used
    -- (total damage after 3 days: 289.54)
    {time = 0.00*total_day_time,     damage_scale = 0.50,     interval_scale = 1.0,     fxlevel = 1}, -- 48.00 DMG
    {time = 1.00*total_day_time,     damage_scale = 0.75,     interval_scale = 1.0,     fxlevel = 1}, -- 54.00 DMG
    {time = 1.75*total_day_time,     damage_scale = 1.00,     interval_scale = 1.0,     fxlevel = 2}, -- 48.00 DMG
    {time = 2.25*total_day_time,     damage_scale = 1.25,     interval_scale = 0.9,     fxlevel = 2}, -- 60.00 DMG
    {time = 2.70*total_day_time,     damage_scale = 1.50,     interval_scale = 0.7,     fxlevel = 3}, -- 41.14 DMG
    {time = 2.90*total_day_time,     damage_scale = 2.00,     interval_scale = 0.5,     fxlevel = 4}, -- 38.40 DMG
}
]]
TUNING.RAD_DAMAGE_MOD = -0.25
TUNING.RAD_ATTACK_PERIOD_MOD = 0.25
TUNING.RAD_SPEED_MOD = 0.75

TUNING.AREA_RAD_CHECK_INTERVAL = .5 -- How frequently radiation checks for nearby entities to infect

TUNING.RAD_SANITY_SCALE = 0.05 -- sanity hit = radiation hit * RAD_SANITY_SCALE  set to 0 to turn off

--[[TUNING.RAD_TICKS =
{
	
	radiationPenalty = GetModConfigData("Radiation Penalty") or 0.5,
}]]

