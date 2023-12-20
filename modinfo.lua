name = "Ratchet and Clank: Rift Together"
description = "Experience the world of the Ratchet and Clank series crashing straight into the constant."
author = "XenoMind, Asura"
version = "Beta 1.0"

forumthread = "/files/file/950-extended-sample-character/"

api_version = 10

dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
    "character", "environment", "scenario", "worldgen", "item", "creature", "art", "ratchet", "clank", "qwark", "nefarious",
}

mod_dependencies = {
    {--Skin Api
        workshop = "workshop-2812783478",
    },
}


local function CreateEnableOption(name, default, label, hover)
    return {
        name = name,
        label = label,
        hover = hover,
        options = {
            {description = "Enabled", data = 1},
            {description = "Disabled", data = 0},
        },
        default = 1,
    }
end

local function CreateDensityOption(name, default, label, hover)
    return {
        name = name,
        label = label, 
        hover = hover,
        options = {
			{description = "None", data = 0},
			{description = "Less", data = 0.15},
			{description = "Default", data = 0.5},
			{description = "More", data = 0.7},
			{description = "Lots", data = 1},
        },
        default = 0.5,
    }
end

local opt_na = {{description = "", data = 0}}
local function Title(title,hover)
	return {
		name=title,
		hover=hover,
		options=opt_na,
		default=0,
	}
end

local DIVIDE = Title("")

configuration_options = {

	DIVIDE,
	Title("WorldGen Options"),
		
	{
        name = "biome_retrofit",
        label = "Retrofit",
        hover = "Retrofit Torren IV into an existing world.",
        options =
        {
            {description = "Disabled", data = 0},
            {description = "Enabled", data = 1},
        },
        default = 0,
    },
		
    CreateDensityOption("raritanium_crystals", 0.5, "Raritanium Crystals", "How many raritanium rock formations spawns."),
    CreateDensityOption("nanotech_crates", 0.5, "Nanotech Crates", "How many nanotech crates spawn within the world."),
	CreateEnableOption("Torren IV", 1, nil, "Allow a chunk of the Torren IV to spawn from the polaris galaxy."),
	CreateEnableOption("Raritanium Meteors", 1, nil, "Allow resources to become renewable beyond Torren IV."),
	CreateEnableOption("Roaming RoboMutts", 1, nil, "Whether you'll run into a pack of robotic hounds on the mainland."),
	
	DIVIDE,
	Title("Compatibility Options"),
	
	CreateEnableOption("rt_um", 1, "Uncompromising Mode", "Allow compatibility with Uncompromising Mode."),
	CreateEnableOption("rt_cf", 1, "Cherry Forest", "Allow compatibility with Cherry Forest."),
	CreateEnableOption("rt_ia", 1, "Island Adventures", "Allow compatibility with Island Adventures."),
	CreateEnableOption("rt_dm", 1, "Dehydrated Mode", "Allow compatibility with Dehydrated."),
	
	DIVIDE,
	Title("Character Options"),
	
	CreateEnableOption("Ratchet And Clank Characters", 1, nil, "Allow playable Ratchet and Clank Characters."),
	
}


