name = "Ratchet and Clank: Rift Together"
description = "Experience the world of the Ratchet and Clank series crashing straight into the constant."
author = "XenoMind"
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
    "character", "environment", "worldgen", "item"
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
        name = "ckey",
        label = "Combat Mode Key",
        hover = "Map key to activate nefarious's combat mode.",
        options =
        {
            {description="C", data = 99},

            {description="UP", data = 273},

            {description="0", data = 48},
            {description="1", data = 49},
            {description="2", data = 50},
            {description="3", data = 51},
            {description="4", data = 52},
        },
        default = 99,
    },
	{
        name = "zkey",
        label = "Shield Mode Key",
        hover = "Map key to activate nefarious's shield mode.",
        options =
        {
            {description="X", data = 120},
            {description="Z", data = 122},
            
            {description="DOWN", data = 274},
  
            {description="5", data = 53},
            {description="6", data = 54},
            {description="7", data = 55},
            
        },
        default = 122,
    },
	{
        name = "vkey",
        label = "Stealth Mode Key",
        hover = "Map key to activate nefarious's stealth mode.",
        options =
        {
            {description="V", data = 118},


            {description="8", data = 56},
            {description="9", data = 57},
        },
        default = 118,
    },


    CreateEnableOption("Raritanium Crystals", 1, nil, "Whether or not raritanium rock formations spawns."),
    CreateEnableOption("Nanotech Crates", 1, nil, "Whether or not nanotech spawns."),
	CreateEnableOption("Torren IV", 1, nil, "Allow a chunk of the Torren IV to spawn from the polaris galaxy."),
	--CreateEnableOption("Show Gieger Meter", 1, nil, "For testing purposes."),
}


