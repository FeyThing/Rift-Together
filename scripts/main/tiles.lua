local NOISES = require("noisetilefunctions")
local ChangeTileRenderOrder = ChangeTileRenderOrder

local TORRENIV_OCEAN_COLOR =
{
    primary_color =        {153, 76, 0,  28},
    secondary_color =      {102,  51, 0, 90},
    secondary_color_dusk = {51,  25, 0, 80},
    minimap_color =        {132,  67,  13,  51},
}

local TORRENIV_WAVETINTS =
{
    rust = {1,  0.20,   0.10},
	--toxic = {0.40,  0.62,   0.50},  for later use
}

AddTile("OCEAN_RUST", "OCEAN",
    {
		ground_name = "Hazardous Waste", 
	},
    {
        name = "cave",
        noise_texture = "levels/textures/ocean_noise.tex",
        runsound="dontstarve/movement/run_marsh",
        walksound="dontstarve/movement/walk_marsh",
        snowsound="dontstarve/movement/run_ice",
        mudsound = "dontstarve/movement/run_mud",
        ocean_depth = "SHALLOW",
        colors = TORRENIV_OCEAN_COLOR,
        wavetint = TORRENIV_WAVETINTS.rust,
    },
    {
        name = "map_edge",
        noise_texture = "levels/textures/mini_water_coral.tex",
    }
)

AddTile("JUNK", "LAND",
	{
		ground_name 	= "Junky Ground",
	},
	{
		name			= "blocky",
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

AddTile("DESERTFERTILE_NOISE", "NOISE")

local function GetTileFordesertfertileNoise(noise)
    return noise < .6 and WORLD_TILES.FOREST or WORLD_TILES.DESERTSAND
end

NOISES[WORLD_TILES.DESERTFERTILE_NOISE] = GetTileFordesertfertileNoise

