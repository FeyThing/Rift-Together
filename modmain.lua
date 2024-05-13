-- GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

env._G = GLOBAL._G
GLOBAL.setfenv(1, env) -- Sets the mods environment to the games'

local require = require
local STRINGS = _G.STRINGS
local containers = require "containers"


local ToLoad = require("main/to_load")
PrefabFiles = ToLoad.Prefabs
Assets = ToLoad.Assets
for k, v in ipairs(ToLoad.MiniMaps) do
    AddMinimapAtlas(v)
end

UpvalueHacker = require("tools/upvaluehacker")
_G.UpvalueHacker = UpvalueHacker

modimport("scripts/main/utils.lua")
modimport("scripts/main/constants.lua")
modimport("scripts/main/tuning.lua")
modimport("scripts/main/languages.lua")
modimport("scripts/main/recipes.lua")
modimport("scripts/main/patches.lua")
modimport("scripts/main/retrofit.lua")
modimport("scripts/main/actions.lua")
modimport("scripts/main/characters.lua")
modimport("scripts/main/containers.lua")
modimport("scripts/main/skins.lua")
modimport("scripts/main/mod_compatibility.lua")


AddReplicableComponent("radiation")



-----------------------
-- modimport("scripts/stategraphs/SGannihilator")
--modimport("scripts/util/nefarious_powers")
modimport("scripts/stategraphs/SGratchet")

