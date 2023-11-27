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

modimport("scripts/main/tiles")
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
	GenerateCrystalsForRoom("BuzzardyBadlands", 0.095)
	GenerateCrystalsForRoom("Lightning", 0.075)	
	GenerateCrystalsForRoom("MoonIsland_Mine", 0.125)
	GenerateCrystalsForRoom("MoonIsland_Baths", 0.080)
	GenerateCrystalsForRoom("MoonIsland_Meadows", 0.055)
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
	GenerateForRoom("Marsh", 0.090)	
	GenerateForRoom("CrappyForest", 0.015)			
end


local TORRENIV_GROUND_TYPES =
{
    WORLD_TILES.IMPASSABLE, WORLD_TILES.GRASS, WORLD_TILES.FOREST, WORLD_TILES.ROCKY, WORLD_TILES.DIRT, -- 1, 2, 3, 4, 5
    WORLD_TILES.JUNK, WORLD_TILES.OCEAN_COASTAL, WORLD_TILES.OCEAN_COASTAL_SHORE, WORLD_TILES.OCEAN_RUST, WORLD_TILES.METALPLATFORM, -- 6, 7, 8, 9, 10
	WORLD_TILES.OCEAN_TOXIC -- 11
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
Layouts["lonely_depot"] = StaticLayout.Get("map/static_layouts/lonely_depot")

Layouts["gunkywateringhole"].ground_types = TORRENIV_GROUND_TYPES
Layouts["lonely_depot"].ground_types = TORRENIV_GROUND_TYPES


if GetModConfigData("Torren IV") == 1 then
	AddTaskSetPreInit("default", function(taskset)
		table.insert(taskset.tasks, "Torren IV")
		table.insert(taskset.tasks, "Torren Wastes")
		table.insert(taskset.tasks, "Torren Wastes Crags")
		table.insert(taskset.tasks, "Torren Wastes Fertile")
	end)
end


local function IsBiomeToBlend(ground)
	return ground == WORLD_TILES.DESERTSAND or ground == WORLD_TILES.JUNK
end
 
local function IsCloseToWater(world, x, y, radius)
	for i = -radius, radius, 1 do
		if IsOceanTile(world:GetTile(x - radius, y + i)) or IsOceanTile(world:GetTile(x + radius, y + i)) then
			return true
		end
	end
	for i = -(radius - 1), radius - 1, 1 do
		if IsOceanTile(world:GetTile(x + i, y - radius)) or IsOceanTile(world:GetTile(x + i, y + radius)) then
			return true
		end
	end
	return false
end

local function IsCloseToTileType(world, x, y, radius, tile)
	for i = -radius, radius, 1 do
		if world:GetTile(x - radius, y + i) == tile or world:GetTile(x + radius, y + i) == tile then
			return true
		end
	end
	for i = -(radius - 1), radius - 1, 1 do
		if world:GetTile(x + i, y - radius) == tile or world:GetTile(x + i, y + radius) == tile then
			return true
		end
	end
	return false
end

local function is_waterlined(tile)
	return IsLandTile(tile) 
end

local function isWaterOrInvalid(ground)
	return IsOceanTile(ground) or ground == WORLD_TILES.INVALID
end

local function IsSurroundedByWaterOrInvalid(world, x, y, radius)
	for i = -radius, radius, 1 do
		if not isWaterOrInvalid(world:GetTile(x - radius, y + i)) or not isWaterOrInvalid(world:GetTile(x + radius, y + i)) then
			return false
		end
	end
	for i = -(radius - 1), radius - 1, 1 do
		if not isWaterOrInvalid(world:GetTile(x + i, y - radius)) or not isWaterOrInvalid(world:GetTile(x + i, y + radius)) then
			return false
		end
	end
	return true
end

local function squareFill(world, width, height, x, y, radius, ground)
	for yy = y - radius, y + radius, 1 do
		for xx = x - radius, x + radius, 1 do
			if 0 <= xx and xx < width and 0 <= yy and yy < height then
				local t = world:GetTile(xx, yy)
				if not is_waterlined(t) then
					world:SetTile(xx, yy, ground)
				end
				if IsOceanTile(t) and not IsSurroundedByWaterOrInvalid(world, xx, yy, 1) then --фиксим приколдес с обрезаными тайлами
					if t == WORLD_TILES.OCEAN_BRINEPOOL then
						world:SetTile(xx, yy, WORLD_TILES.OCEAN_BRINEPOOL_SHORE)
					else
						world:SetTile(xx, yy, WORLD_TILES.OCEAN_COASTAL_SHORE)
					end
				end
			end
		end
	end
end

local function do_squarefill(world, w, h)
	print("[RUST WATER]  Square fill...")
	local radius = 2
	for y = 0, h - 1, 1 do
		for x = 0, w - 1, 1 do 
			local ground = world:GetTile(x, y)
			if IsBiomeToBlend(ground) and is_waterlined(ground) and (IsCloseToTileType(world, x, y, 5, WORLD_TILES.IMPASSABLE) or IsCloseToWater(world, x, y, 5)) then
				squareFill(world, w, h, x, y, radius, WORLD_TILES.OCEAN_RUST)
			end
		end
	end
end

require("map/ocean_gen")
local _Ocean_ConvertImpassibleToWater = Ocean_ConvertImpassibleToWater
Ocean_ConvertImpassibleToWater = function(...)
	local args = {...}

	local w, h = args[1], args[2]
	local data = args[3]
	local world = WorldSim
	
	local val = _Ocean_ConvertImpassibleToWater(...)

	do_squarefill(world, w, h)

	return val
end
