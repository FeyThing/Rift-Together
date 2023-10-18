local require = GLOBAL.require

GLOBAL.require("map/terrain")
GLOBAL.require("tilemanager")

local GROUND = GLOBAL.GROUND
local Layouts = GLOBAL.require("map/layouts").Layouts
local StaticLayout = GLOBAL.require("map/static_layout")

modimport("scripts/util/utils_worldgen")
modimport("scripts/rnc_tiles")
modimport("scripts/map/tasks/torreniv")

local TORRENIV_GROUND_TYPES = GLOBAL.TORRENIV_GROUND_TYPES

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


GLOBAL.terrain.filter.raritanium_crystals = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.JUNK}
GLOBAL.terrain.filter.nanocrate = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER}


GLOBAL.terrain.filter.torren_grass = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.JUNK}
GLOBAL.terrain.filter.torren_cactus = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.JUNK}
GLOBAL.terrain.filter.torrenivdesert_pillar = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER,GLOBAL.GROUND.JUNK, GLOBAL.GROUND.MUD, GLOBAL.GROUND.DIRT}
GLOBAL.terrain.filter.torrenivdesert_pillar_small = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.JUNK, GLOBAL.GROUND.MUD, GLOBAL.GROUND.DIRT}


Layouts["gunkywateringhole"] = StaticLayout.Get("map/static_layouts/gunkywateringhole")
Layouts["gunkywateringhole"].ground_types = TORRENIV_GROUND_TYPES


if GetModConfigData("Torren IV") == 1 then


	AddTaskSetPreInit("default", function(taskset)
			table.insert(taskset.tasks, "Torren IV")
	end)
	
	AddTaskSetPreInit("default", function(taskset)
			table.insert(taskset.tasks, "Torren Wastes")
	end)
	
	AddTaskSetPreInit("default", function(taskset)
			table.insert(taskset.tasks, "Torren Wastes Crags")
	end)
end




---ChangeTileRenderOrder(WORLD_TILES.JUNK, WORLD_TILES.DIRT_NOISE,true)