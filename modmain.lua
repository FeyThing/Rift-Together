-- GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

env._G = GLOBAL._G
GLOBAL.setfenv(1, env) -- Sets the mods environment to the games'

local require = require
local STRINGS = _G.STRINGS
local containers = require "containers"

local AddSimPostInit = AddSimPostInit

local ToLoad = require("main/to_load")
PrefabFiles = ToLoad.Prefabs
Assets = ToLoad.Assets
for k, v in ipairs(ToLoad.MiniMaps) do
    AddMinimapAtlas(v)
end

UpvalueHacker = require("tools/upvaluehacker")
_G.UpvalueHacker = UpvalueHacker
_G.inspect = require("tools/inspect")

local inits = {
    "utils",
    "constants",
    "tuning",
    "languages",
    "recipes",
    "cooking",
    "patches",
    "retrofit",
    "actions",
    "characters",
    "containers",
	"wxmodules",
    "skins",
    "mod_compatibility",  
}

for _, v in pairs(inits) do
    modimport("scripts/main/"..v)
end

AddReplicableComponent("radiation")

-----------------------

AddSimPostInit(function()
modimport("scripts/main/shadeeffects")
end)

modimport("scripts/stategraphs/SGratchet")

