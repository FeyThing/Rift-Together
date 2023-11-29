GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local containers = require "containers"

GLOBAL.CHEATS_ENABLED = true

local ToLoad = require("main/to_load")
PrefabFiles = ToLoad.Prefabs
Assets = ToLoad.Assets
for k, v in ipairs(ToLoad.MiniMaps) do
    AddMinimapAtlas(v)
end

GLOBAL.UpvalueHacker = require("tools/upvaluehacker")

STRINGS.CHARACTERS.RATCHET = require "speech_ratchet"
STRINGS.CHARACTERS.NEFARIOUS = require "speech_nefarious"

modimport("scripts/main/utils.lua")
modimport("scripts/main/tuning.lua")
modimport("scripts/main/strings.lua")
modimport("scripts/main/recipes.lua")
modimport("scripts/main/patches.lua")
modimport("scripts/main/actions.lua")
modimport("scripts/main/characters.lua")
modimport("scripts/main/containers.lua")

AddReplicableComponent("radiation")

-----------------------
modimport("scripts/stategraphs/SGannihilator")
modimport("scripts/util/nefarious_powers")
modimport("scripts/stategraphs/SGratchet")
