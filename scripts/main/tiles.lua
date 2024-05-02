local NOISES = require("noisetilefunctions")
local ChangeTileRenderOrder = ChangeTileRenderOrder

local TORRENIV_OCEAN_COLOR =
{
	primary_color =        {25, 15, 5,  255}, -- {153, 76, 0,  200},
	secondary_color =      {20,  9, 2, 200}, -- {102,  51, 0, 255/2},
	secondary_color_dusk = {10,  2, 0, 125}, -- {51,  25, 0, 80},
	minimap_color =        {23,  12,  3,  150},
}

local TORRENIV_OCEAN_COLOR_TOXIC =
{
	primary_color =        {44, 250, 31,  28},
	secondary_color =      {152,251,152, 90},
	secondary_color_dusk = {51,  25, 0, 80},
	minimap_color =        {132,  67,  13,  51},
}

local TORRENIV_WAVETINTS =
{
    rust = {249, 180, 45}, -- 1,  0.20,   0.10
	toxic = {0.40,  0.62,   0.50},
}

AddTile("OCEAN_RUST", "OCEAN",
    {
		ground_name = "Rusted Waves", 
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

AddTile("OCEAN_TOXIC", "OCEAN",
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
        ocean_depth = "DEEP",
        colors = TORRENIV_OCEAN_COLOR_TOXIC,
        wavetint = TORRENIV_WAVETINTS.toxic,
    },
    {
        name = "map_edge",
        noise_texture = "levels/textures/mini_water_coral.tex",
    }
)

AddTile("METALPLATFORM", "LAND",
	{
		ground_name 	= "Metal Platform",
	},
	{
		name			= "carpet",
		noise_texture	= "levels/textures/ground_noise_metalplatform.tex",
		runsound 		= "dontstarve/movement/run_marble",
        walksound 		= "dontstarve/movement/walk_marble",
		snowsound		= "dontstarve/movement/run_snow",
		mudsound        = "dontstarve/movement/run_mud",
		flooring = true,
		hard			= true,
		ocean_depth = "BASIC",
		colors = TORRENIV_OCEAN_COLOR,
	},
	{
		name 			= "map_edge",
		noise_texture	= "levels/textures/mini_noise_metalplatform.tex",
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
		ocean_depth = "SHALLOW",
		colors = TORRENIV_OCEAN_COLOR,
	},
	{
		name 			= "map_edge",
		noise_texture	= "levels/textures/mini_noise_junk.tex",
	},
	{
        name = "junk",
        anim = "junk",
        bank_build = "rnc_turf",
        pickupsound = "rock",
    }
)


AddTile("DESERTSAND", "LAND",
	{
		ground_name 	= "Sandy Desert",
	},
	{
		name			= "desertsand",
		noise_texture	= "levels/textures/ground_noise_desertsand.tex",
		runsound 		= "dontstarve/movement/run_dirt",
        walksound 		= "dontstarve/movement/walk_dirt",
		snowsound		= "dontstarve/movement/run_ice",
		mudsound        = "dontstarve/movement/run_mud",
		ocean_depth = "SHALLOW",
		colors = TORRENIV_OCEAN_COLOR,
	},
	{
		name 			= "map_edge",
		noise_texture	= "levels/textures/mini_noise_desertsand.tex",
		pickupsound = "grainy",
	},
	{
        name = "desertsand",
        anim = "desertsand",
        bank_build = "rnc_turf",
        pickupsound = "rock",
    }
)

AddTile("LUSH", "LAND",
	{
		ground_name 	= "Lush Forest",
	},
	{
		name			= "lush",
		noise_texture	= "levels/textures/ground_noise_lush.tex",
		runsound="dontstarve/movement/run_woods",
        walksound="dontstarve/movement/walk_woods",
        snowsound="dontstarve/movement/run_snow",
        mudsound="dontstarve/movement/run_mud",
		ocean_depth = "SHALLOW",
		colors = TORRENIV_OCEAN_COLOR,
	},
	{
		name 			= "map_edge",
		noise_texture	= "levels/textures/ground_noise_lush.tex",
	},
	{
        name = "lush",
        anim = "lush",
        bank_build = "rnc_turf",
        pickupsound = "cloth",
    }
)

AddTile("JUNK_NOISE", "NOISE")

local function GetTileForJunkNoise(noise)
    return noise < .5 and WORLD_TILES.JUNK or WORLD_TILES.DESERTSAND
end

NOISES[WORLD_TILES.JUNK_NOISE] = GetTileForJunkNoise

AddTile("DESERTSAND_NOISE", "NOISE")

local function GetTileFordesertsandNoise(noise)
    return noise < .6 and WORLD_TILES.DESERTSAND or noise < .3 and WORLD_TILES.DESERT_DIRT or WORLD_TILES.LUSH
end

NOISES[WORLD_TILES.DESERTSAND_NOISE] = GetTileFordesertsandNoise

AddTile("DESERTFERTILE_NOISE", "NOISE")

local function GetTileFordesertfertileNoise(noise)
    return noise < .6 and WORLD_TILES.LUSH or WORLD_TILES.DESERTSAND
end

NOISES[WORLD_TILES.DESERTFERTILE_NOISE] = GetTileFordesertfertileNoise

ChangeTileRenderOrder(WORLD_TILES.OCEAN_RUST, WORLD_TILES.OCEAN_HAZARDOUS, true)
ChangeTileRenderOrder(WORLD_TILES.OCEAN_TOXIC, WORLD_TILES.OCEAN_HAZARDOUS, true)

ChangeTileRenderOrder(WORLD_TILES.JUNK, WORLD_TILES.DIRT)
ChangeTileRenderOrder(WORLD_TILES.LUSH, WORLD_TILES.DIRT)
ChangeTileRenderOrder(WORLD_TILES.DESERTSAND, WORLD_TILES.DIRT)
ChangeTileRenderOrder(WORLD_TILES.METALPLATFORM, WORLD_TILES.DIRT)

--RegisterInventoryItemAtlas(_G.resolvefilepath("images/rnc_inventoryimages.xml"),"turf_lush.tex")
--RegisterInventoryItemAtlas(_G.resolvefilepath("images/rnc_inventoryimages.xml"),"turf_junk.tex")
--RegisterInventoryItemAtlas(_G.resolvefilepath("images/rnc_inventoryimages.xml"),"turf_desertsand.tex")


