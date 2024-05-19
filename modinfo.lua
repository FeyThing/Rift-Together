name = "Ratchet and Clank: Rift Together"
--description = "Experience the world of the Ratchet and Clank series crashing straight into the constant."
author = "XenoMind, Asura"
version = "Beta 1.1.2"
local info_version = "󰀔 [ Version "..version.." ]\n"

description = info_version..[[
Rift Together, shortened to RT is an open source expansion of Don't Starve Together based off the Ratchet and Clank series. 
With an emphasis on combating a new kind of survival threat, it's up to you to gather up your buddies or struggle to stay alive on your own and get ready to explore a familiar world ravaged by the debris of alien industrialization, as the thread keeping together the dimensions begins to unfurl and crack. Empowering and inflicting devestation upon the very reality you stand.  

󰀛 Explore :
Travel to new biomes polluted from worlds crossing over, discover new modular weapons, find the smelter to forge new gear, fight against empowered lunar threats, face new mobs, endure against a world where everything is tainted and very much wants you dead.

󰀏 Configure the mod to your choosing in the settings!
]]


forumthread = ""

api_version = 10

dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
gorge_compatible = true

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
    "character", "environment", "scenario", "worldgen", "item", "creature", "art", "ratchet", "clank", "qwark", "nefarious",
}

--[[mod_dependencies = {
    {--Skin Api
        workshop = "workshop-2812783478",
    },
}]]

local function CreateLanguageOption(name, default, label, hover)
    return {
        name = name,
        label = label,
		hover = hover,
		
        options = {
            {description = "English", hover = "By Feything", data = "en"},
            --{description = "NA", hover = "By Insertname", data = "vi"},
        },
        default = default or "en",
    }
end

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

local function CreateTypeOption(name, default, label, hover)
    return {
        name = name,
        label = label,
        hover = hover,
        options = {
            {description = "Enabled", data = "torren_iv"},
            {description = "Disabled", data = ""},
        },
        default = default or "torren_iv",
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

local function CreatePercentageOption(name, default, label, hover)
    return {
        name = name,
        label = label, 
        hover = hover,
        options = {
			{description = "25%", data = 25},
			{description = "50%", data = 50},
			{description = "75%", data = 75},
        },
        default = default or 50,
    }
end

local function CreateTimerOption(name, default, label, hover)
    return {
        name = name,
        label = label, 
        hover = hover,
        options = {
			{description = "0", data = 0},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
        },
        default = 5,
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
	
	CreateLanguageOption("language", "en", "Language", "Change the mod language."),	
    CreateEnableOption("rt_music", 1, "Rift Together Music", "Turns on Rift Together OST for custom biomes."),	

	DIVIDE,
	Title("WorldGen Options"),
		
	{
        name = "biome_retrofit",
        label = "Retrofit",
        hover = "Retrofit the Torren IV island into an existing world.",
        options =
        {
            {description = "Disabled", data = 0},
            {description = "Enabled", data = 1},
        },
        default = 0,
    },
		
    CreateDensityOption("raritanium_crystals", 0.5, "Raritanium Crystals", "How many raritanium rock formations spawn."),
    CreateDensityOption("nanotech_crates", 0.5, "Nanotech Crates", "How many nanotech crates spawn within the world."),
	CreatePercentageOption("Barrels", 25, nil, "How polluted do you want your ocean to be?"),
	CreateEnableOption("Torren IV", 1, nil, "Allow the new biome, a chunk of Torren IV to spawn from the polaris galaxy."),
	CreateEnableOption("Island Generation", 1, "Generate as island", "The new biome is an island by default. Disabling this generates the new biome on the mainland."),
	CreateEnableOption("Raritanium Meteors", 1, nil, "Allow resources to become renewable beyond Torren IV."),
	CreateEnableOption("Roaming RoboMutts", 1, nil, "Whether you'll run into a pack of robotic hounds on the mainland."),
	CreateEnableOption("Dust Devils", 1, nil, "Enable or Disable the spawn of dust devil tornados in the summer."),
	
	DIVIDE,
	Title("Compatibility Options"),
	
	CreateEnableOption("rt_um", 1, "Uncompromising Mode", "Radioactive effects are applied to Uncompromising Mode mobs."),
	CreateEnableOption("rt_cf", 1, "Cherry Forest", "When Cherry Forest is active, armors provide protection and certain mobs gain immunities to radiation."),
	CreateEnableOption("rt_ia", 1, "Island Adventures", "Robotic hounds, and resources spawn in island adventure worlds."),
	CreateEnableOption("rt_dm", 1, "Dehydrated Mode", "Allow radiation curing drinks when Dehydrated is active."),
	CreateEnableOption("rt_shoe", 1, "Shoes", "Protective boots and Hover boots become available with Shoetime."),
	CreatePercentageOption("shoes_hover_speed", 50, "Hover Boot Speed", "Adjusts hover speed for the Hover boots if shoe slot is active."),
	CreateTimerOption("shoes_hover_speed_combat", 5, "Hover Boot Speed Cooldown", "Adjusts the cooldown timer for speed regain for Hover boots after combat."),
	
	DIVIDE,
	Title("Character Options"),
	
	CreateEnableOption("Ratchet And Clank Characters", 1, nil, "Allow playable Ratchet and Clank Characters."),
	
}


