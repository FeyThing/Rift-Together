local env = env
local GetModConfigData = GetModConfigData
local KnownModIndex = _G.KnownModIndex
local AddBrainPostInit = AddBrainPostInit
local AddStategraphPostInit = AddStategraphPostInit
local AddPrefabPostInit = AddPrefabPostInit
local AddComponentPostInit = AddComponentPostInit
local AddStategraphState = AddStategraphState
local AddGlobalClassPostConstruct = AddGlobalClassPostConstruct
local AddClassPostConstruct = AddClassPostConstruct
local AddPlayerPostInit = AddPlayerPostInit
local AddPrefabPostInitAny = AddPrefabPostInitAny

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
		"retrofitforestmap_anr",
		"carefulwalker",
		"damagetypebonus",
		"damagetyperesist",
		"weapon",
		"moisture",
	},
	
	REPLICAS = {
		--"builder_replica",
		--"combat_replica",
	},

	PREFABS = {
		alterguardian_phase1 = "alterguardian_phase1",
		alterguardian_phase2 = "alterguardian_phase2",
		alterguardian_phase3 = "alterguardian_phase3",
		archive_centipede = "archive_centipede",
		armor_lunarplant = "armor_lunarplant",
		bearger = "mutatedbearger",
		chess = {"knight", "bishop", "rook"},
		chess_nightmare = {"knight_nightmare", "bishop_nightmare", "rook_nightmare"},
		chessjunk = {"chessjunk1", "chessjunk2", "chessjunk3", "chessjunk"},
		crabking = "crabking",
		deerclops = "mutateddeerclops",
		eyeofterror = {"twinofterror1", "twinofterror2"},
		forest = "forest",
		frog = "lunarfrog",
		gestalt = "gestalt",		
		gestalt_alterguardian_projectile = {"gestalt_alterguardian_projectile", "smallguard_alterguardian_projectile", "alterguardianhat_projectile", "largeguard_alterguardian_projectile"},
		gestalt_guard = "gestalt_guard",
		hats = "lunarplanthat",
		hats_hideable = {"catcoonhat", "molehat", "footballhat", "wagpunkhat", "watermelonhat", "hivehat", "spiderhat"},
		hats_viewable = {"rainhat", "tophat", "beehat", "beefalohat", "winterhat", "moonstorm_goggleshat", "dreadstonehat", "plantregistryhat", 
		"nutrientsgoggleshat", "cookiecutterhat", "woodcarvedhat", "minerhat", "antlionhat", "icehat", "blue_mushroomhat", "green_mushroomhat", 
		"red_mushroomhat", "skeletonhat", "polly_rogershat", "moon_mushroomhat", "strawhat"},
		hound = "mutatedhound",
		lunar_grazer = "lunar_grazer",
		meats = {"meat","cookedmeat", "meat_dried", "monstermeat", "cookedmonstermeat", "monstermeat_dried", "smallmeat", "cookedsmallmeat",
		"smallmeat_dried", "batwing", "batwing_cooked", "humanmeat", "humanmeat_cooked", "humanmeat_dried", "quagmire_smallmeat", 
		"quagmire_cookedsmallmeat","barnacle", "barnacle_cooked", "batnose", "batnose_cooked"},	
		moon_mushroom = {"moon_cap", "moon_cap_cooked"},
		mushrooms = {"blue_cap", "blue_cap_cooked", "red_cap", "red_cap_cooked", "green_cap", "green_cap_cooked"},
		penguin = "mutated_penguin",
		player_classified = "player_classified",
		pocketwatch_weapon = "pocketwatch_weapon",
		rabbithole = "rabbithole",
		rocky = "rocky",
		slurtle = {"slurtle", "snurtle"},
		spider = "spider_moon",
		warg = "mutatedwarg",
		world = "world",
		veggies = {"carrot", "carrot_cooked", "potato", "potato_cooked", "cave_banana", "cave_banana_cooked"},
				
		--prefab_template = "beefalo",
	},

	PLAYERS = {
		--"prefab_template", --"wilson"
	},
	STATEGRAPHS = { --it's creating new one
		"wilson",
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


local network_postinits = {}
local done_inits = {}

local _MakeWorldNetwork = require("prefabs/world_network")
local function MakeWorldNetwork(...)
	local inst = _MakeWorldNetwork(...)
	local prefab = inst.prefab or inst.name

	if not done_inits[prefab] then
		done_inits[prefab] = true
		AddPrefabPostInit(prefab, function(inst)
			for _, v in ipairs(network_postinits) do
				v(inst)
			end
		end)
	end

	return inst
end
_G.package.loaded["prefabs/world_network"] = MakeWorldNetwork

function AddNetworkPostInit(fn)
	table.insert(network_postinits, fn)
end

local GenericNetworkFn = require("patches/prefabs/world_network")
AddNetworkPostInit(GenericNetworkFn)


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
