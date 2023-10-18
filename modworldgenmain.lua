env._G = GLOBAL
local env = env
local modimport = modimport
local AddRoomPreInit = AddRoomPreInit
local AddTaskSetPreInit = AddTaskSetPreInit
local GetModConfigData = GetModConfigData

_G.setfenv(1, _G)

require("map/terrain")
require("tilemanager")

local Layouts = require("map/layouts").Layouts
local StaticLayout = require("map/static_layout")

modimport("scripts/rnc_tiles")
modimport("scripts/map/tasks/torreniv")

local function GenerateCrystalsForRoom(room, factor)
	AddRoomPreInit(room, function(room)
		if room.contents.distributeprefabs then
			room.contents.distributeprefabs.raritanium_crystals = factor
		end
	end)
end

if GetModConfigData("Raritanium Crystals") == 1 then
	GenerateCrystalsForRoom("Badlands", 0.125)
	GenerateCrystalsForRoom("BGBadlands", 0.110)
	GenerateCrystalsForRoom("BuzzardyBadlands", 0.095)
	GenerateCrystalsForRoom("Lightning", 0.075)	
	GenerateCrystalsForRoom("MoonIsland_Mine", 0.125)
	GenerateCrystalsForRoom("MoonIsland_Baths", 0.080)
	GenerateCrystalsForRoom("MoonIsland_Meadows", 0.055)
	GenerateCrystalsForRoom("BGRocky", 0.055)
	GenerateCrystalsForRoom("Rocky", 0.035)
end


local function GenerateForRoom(room, factor)
	AddRoomPreInit(room, function(room)
		if room.contents.distributeprefabs then
			room.contents.distributeprefabs.nanocrate = factor
		end
	end)
end

if GetModConfigData("Nanotech Crates") == 1 then
	GenerateForRoom("BGMarsh", 0.125)
	GenerateForRoom("Marsh", 0.090)
	GenerateForRoom("BGCrappyForest", 0.025)	
	GenerateForRoom("CrappyForest", 0.015)			
end

local TORRENIV_GROUND_TYPES =
{
    WORLD_TILES.IMPASSABLE, WORLD_TILES.GRASS, WORLD_TILES.FOREST, WORLD_TILES.ROCKY, WORLD_TILES.DIRT, -- 1, 2, 3, 4, 5
    WORLD_TILES.JUNK, WORLD_TILES.OCEAN_COASTAL, WORLD_TILES.OCEAN_COASTAL_SHORE, WORLD_TILES.OCEAN_BRINEPOOL, -- 6, 7, 8, 9
}

local filters = {
	["raritanium_crystals"] = {WORLD_TILES.ROAD, WORLD_TILES.WOODFLOOR, WORLD_TILES.CARPET, WORLD_TILES.CHECKER, WORLD_TILES.JUNK},
	["nanocrate"] = {WORLD_TILES.ROAD, WORLD_TILES.WOODFLOOR, WORLD_TILES.CARPET, WORLD_TILES.CHECKER},
	["torren_grass"] = {WORLD_TILES.ROAD, WORLD_TILES.WOODFLOOR, WORLD_TILES.CARPET, WORLD_TILES.CHECKER, WORLD_TILES.JUNK},
	["torren_cactus"] = {WORLD_TILES.ROAD, WORLD_TILES.WOODFLOOR, WORLD_TILES.CARPET, WORLD_TILES.CHECKER, WORLD_TILES.JUNK},
	["torrenivdesert_pillar"] = {WORLD_TILES.ROAD, WORLD_TILES.WOODFLOOR, WORLD_TILES.CARPET, WORLD_TILES.CHECKER,WORLD_TILES.JUNK, WORLD_TILES.MUD, WORLD_TILES.DIRT},
	["torrenivdesert_pillar_small"] = {WORLD_TILES.ROAD, WORLD_TILES.WOODFLOOR, WORLD_TILES.CARPET, WORLD_TILES.CHECKER,WORLD_TILES.JUNK, WORLD_TILES.MUD, WORLD_TILES.DIRT}
}

for k, v in pairs(filters) do
	terrain.filter[k] = v
end

Layouts["gunkywateringhole"] = StaticLayout.Get("map/static_layouts/gunkywateringhole")
Layouts["gunkywateringhole"].ground_types = TORRENIV_GROUND_TYPES


if GetModConfigData("Torren IV") == 1 then
	AddTaskSetPreInit("default", function(taskset)
		table.insert(taskset.tasks, "Torren IV")
		table.insert(taskset.tasks, "Torren Wastes")
		table.insert(taskset.tasks, "Torren Wastes Crags")
	end)
end
