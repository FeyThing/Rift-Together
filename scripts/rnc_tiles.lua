local NOISES = require("noisetilefunctions")

local TORRENIV_OCEAN_COLOR =
{
    primary_color =        {153, 76, 0,  28},
    secondary_color =      {102,  51, 0, 0},
    secondary_color_dusk = {51,  25, 0, 80},
    minimap_color =        {132,  67,  13,  51},
}


AddTile("JUNK", "LAND",
	{
		ground_name 	= "Junky Ground",
-- Unique ID, please change to anything else. Don't use 832 if you're referencing my mod.
		old_static_id 	= 832,  
-- Prevents compatibility issues.
	},
	{
		name			= "junk",
		noise_texture	= "levels/textures/ground_noise_junk.tex",
		runsound 		= "dontstarve/movement/run_marble",
        walksound 		= "dontstarve/movement/walk_marble",
		snowsound		= "dontstarve/movement/run_snow",
		mudsound        = "dontstarve/movement/run_mud",
		hard			= true,
		ocean_depth = "BASIC",
		colors = TORRENIV_OCEAN_COLOR,
	},
	{
		name 			= "map_edge",
		noise_texture	= "levels/textures/mini_noise_junk.tex",
	}
	
)

AddTile("DESERTSAND", "LAND",
	{
		ground_name 	= "Sandy Desert",
-- Unique ID, please change to anything else. Don't use 833 if you're referencing my mod.
		old_static_id 	= 833,  
-- Prevents compatibility issues.
	},
	{
		name			= "desertsand",
		noise_texture	= "levels/textures/ground_noise_desertsand.tex",
		runsound 		= "dontstarve/movement/run_carpet",
        walksound 		= "dontstarve/movement/walk_carpet",
		snowsound		= "dontstarve/movement/run_snow",
		mudsound        = "dontstarve/movement/run_mud",
		ocean_depth = "BASIC",
		colors = TORRENIV_OCEAN_COLOR,
	},
	{
		name 			= "map_edge",
		noise_texture	= "levels/textures/mini_noise_desertsand.tex",
		pickupsound = "grainy",
	}
	
)

AddTile("JUNK_NOISE", "NOISE")

local function GetTileForJunkNoise(noise)
    return noise < math.random() and WORLD_TILES.JUNK or WORLD_TILES.DESERTSAND
end

NOISES[WORLD_TILES.JUNK_NOISE] = GetTileForJunkNoise

AddTile("DESERTSAND_NOISE", "NOISE")

local function GetTileFordesertsandNoise(noise)
    return noise < .5 and WORLD_TILES.DESERTSAND or WORLD_TILES.DESERT_DIRT or WORLD_TILES.ROCKY
end

NOISES[WORLD_TILES.DESERTSAND_NOISE] = GetTileFordesertsandNoise


local TORRENIV_GROUND_TYPES =
{
    WORLD_TILES.IMPASSABLE, WORLD_TILES.GRASS, WORLD_TILES.FOREST, WORLD_TILES.ROCKY, WORLD_TILES.DIRT, -- 1, 2, 3, 4, 5
    WORLD_TILES.JUNK, WORLD_TILES.OCEAN_COASTAL, WORLD_TILES.OCEAN_COASTAL_SHORE, WORLD_TILES.OCEAN_BRINEPOOL, -- 6, 7, 8, 9
}

GLOBAL.TORRENIV_GROUND_TYPES = TORRENIV_GROUND_TYPES