name = "Ratchet and Clank: Rift Together"
description = "Experience the world of the Ratchet and Clank series crashing straight into the constant."
author = "XenoMind, Asura"
version = "1.2.6"

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
    "character", "environment", "worldgen", "item", "ratchet", "clank", "nefarious",
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
        default = default or 1,
    }
end

configuration_options = {

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
	
	CreateEnableOption("rt_um", 1, "Uncompromising Mode", "Allow compatibility with Uncompromising Mode."),
	CreateEnableOption("rt_cf", 1, "Cherry Forest", "Allow compatibility with Cherry Forest."),
    CreateEnableOption("Raritanium Crystals", 1, nil, "Whether or not raritanium rock formations spawns."),
    CreateEnableOption("Nanotech Crates", 1, nil, "Whether or not nanotech spawns."),
	CreateEnableOption("Torren IV", 1, nil, "Allow a chunk of the Torren IV to spawn from the polaris galaxy."),
	CreateEnableOption("Roaming RoboMutts", 1, nil, "Whether you'll run into a pack of robotic hounds on the mainland."),
	CreateEnableOption("Ratchet And Clank Characters", 1, nil, "Allow playable Ratchet and Clank Characters."),
	
}


