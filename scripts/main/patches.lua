local env = env
local AddBrainPostInit = AddBrainPostInit
local AddStategraphPostInit = AddStategraphPostInit
local AddPrefabPostInit = AddPrefabPostInit
local AddComponentPostInit = AddComponentPostInit
local AddStategraphState = AddStategraphState
local AddGlobalClassPostConstruct = AddGlobalClassPostConstruct
local AddClassPostConstruct = AddClassPostConstruct
local AddPlayerPostInit = AddPlayerPostInit
local AddPrefabPostInitAny = AddPrefabPostInitAny
_G.setfenv(1, _G)

local GenericPlayerFn = require("patches/prefabs/player")
local AnyFn = require("patches/prefabs/any")

local PATCHES = 
{
	COMPONENTS = {
		"ambientsound",
		"edible",
		"equippable",
		"wisecracker",
		"combat",
		"wavemanager",
	},
	
	REPLICAS = {
		--"builder_replica",
		--"combat_replica",
	},

	PREFABS = {
		chess = {"knight", "bishop", "rook"},
		chessjunk = {"chessjunk1", "chessjunk2", "chessjunk3", "chessjunk"},
		player_classified = "player_classified",
		world = "world",
		--prefab_template = "spider",
	},

	PLAYERS = {
		--"prefab_template", --"wilson"
	},
	STATEGRAPHS = { --it's creating new one
		--"wilson",
	},
	STATES = { --it's patches
		--"wilson",
	},
	BRAINS = {
		--brain_template = "powdermonkeybrain",
	},
	WIDGETS = {
		"statusdisplays",
	},
	SCREENS = {

	},
}


for i, prefab in ipairs(PATCHES.PLAYERS) do
	PATCHES.PREFABS[prefab] = prefab
end

local function patch(prefab, fn)
	AddPrefabPostInit(prefab, fn)
end
	
for path, data in pairs(PATCHES.PREFABS) do
	local fn = require("patches/prefabs/"..path)
	
	if type(data) == "string" then
		patch(data, function(inst) fn(inst, data) end)
	else
		for _, pref in ipairs(data) do
			patch(pref, function(inst) fn(inst, pref) end)
		end
	end
end

AddPlayerPostInit(GenericPlayerFn)
AddPrefabPostInitAny(AnyFn)

for _, name in ipairs(PATCHES.STATEGRAPHS) do
	AddStategraphPostInit(name, require("patches/stategraphs/"..name))
end

local function patchbrain(prefab, fn)
	AddBrainPostInit(prefab, fn)
end

local function patchclass(prefab, fn)
	AddClassPostConstruct(prefab, fn)
end

for path, data in pairs(PATCHES.BRAINS) do
	local fn = require("patches/brains/"..path)
	
	if type(data) == "string" then
		patchbrain(data, function(inst) fn(inst, data) end)
	else
		for _, pref in ipairs(data) do
			patchbrain(pref, function(inst) fn(inst, pref) end)
		end
	end
end

for _, file in ipairs(PATCHES.COMPONENTS) do
	local fn = require("patches/components/"..file)
	AddComponentPostInit(file, fn)
end

for _, file in ipairs(PATCHES.REPLICAS) do
	local fn = require("patches/components/"..file)
	patchclass("components/"..file, fn)
end

for _, file in ipairs(PATCHES.WIDGETS) do
	local fn = require("patches/widgets/"..file)
	patchclass("widgets/"..file, fn)
end

for _, file in ipairs(PATCHES.SCREENS) do
	local fn = require("patches/screens/"..file)
	patchclass("screens/"..file, fn)
end

for _, file in ipairs(PATCHES.STATES) do
	local server_states = require("patches/states/"..file)
	for i, state in ipairs(server_states) do
		AddStategraphState(file, state)
	end
end
