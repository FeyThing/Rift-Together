env._G = GLOBAL._G
GLOBAL.setfenv(1, env)

--- Had to do it the old fashioned way. It just was not having it with any modimports ;U;

PrefabFiles = {
	"ratchet",
	"ratchet_none"
}

Assets = {
	Asset( "IMAGE", "bigportraits/ratchet.tex" ),
    Asset( "ATLAS", "bigportraits/ratchet.xml" ),

    Asset( "IMAGE", "bigportraits/ratchet_none.tex" ),
    Asset( "ATLAS", "bigportraits/ratchet_none.xml" ),
	
	Asset( "IMAGE", "bigportraits/ms_rivet.tex" ),
    Asset( "ATLAS", "bigportraits/ms_rivet.xml" ),

    Asset( "IMAGE", "images/saveslot_portraits/ratchet.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/ratchet.xml" ),

    Asset( "IMAGE", "images/names_gold_ratchet.tex" ),
    Asset( "ATLAS", "images/names_gold_ratchet.xml" ),

    Asset("IMAGE", "images/rnc_inventoryimages.tex" ),
    Asset("ATLAS", "images/rnc_inventoryimages.xml"), 
 
}

local STRINGS = _G.STRINGS

STRINGS.NAMES.RATCHET = "Ratchet"
STRINGS.SKIN_NAMES.ratchet_none = "Ratchet"
STRINGS.SKIN_DESCRIPTIONS.ratchet_none = "Your basic lombax."

STRINGS.CHARACTER_TITLES.ratchet = "The Galactic Hero"
STRINGS.CHARACTER_NAMES.ratchet = "Ratchet"
STRINGS.CHARACTER_DESCRIPTIONS.ratchet = "*Starts with a modifiable wrench\n*Is very nimble\n*Fearless"
STRINGS.CHARACTER_QUOTES.ratchet = "\"Clank? Where are you!\""
STRINGS.CHARACTER_ABOUTME.ratchet = "Ratchet is the hero of multiple galaxies, he wishes to one day be reunited with his kind one day."
STRINGS.CHARACTER_BIOS.ratchet = {
 { title = "Birthday", desc = "Unknown" },
					{ title = "Favorite Food", desc = "Barnacle Pita" },
					{ title = "A Hero trapped between dimensions", desc = "Ratchet, an orphen originally born from Fastoon, is a headstrong and challenge seeking savior of multiple galaxies. Originally a jerk, he has now developed a light-hearted yet wise-cracking personality with the help of clank, his best friend. Though he has struggled balancing his own needs and those of others, he always chooses the right thing to do in order to keep the universe safe. Especially his friends and his foster home, Veldin."},
				
}

STRINGS.SKIN_NAMES.ms_rivet = "The Interdimensional Rebel"
STRINGS.SKIN_DESCRIPTIONS.ms_rivet = "Ratchet's dimensional counterpart, Rivet."
STRINGS.SKIN_QUOTES.ms_rivet = "W...where am I?."

STRINGS.SKIN_NAMES.ms_loading_ratchet1 = "Rift Together"
STRINGS.SKIN_DESCRIPTIONS.ms_loading_ratchet1 = "Reality in this dimension is being torn apart by its very seams. The only way to escape it's collapse is to find a way out...if there is a way out. ~Art created by Gearless"

STRINGS.CHARACTER_SURVIVABILITY.ratchet= "Slim"

TUNING.RATCHET_HEALTH = 125
TUNING.RATCHET_HUNGER = 150
TUNING.RATCHET_SANITY = 200

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.RATCHET = { "owrench", "nanoboost" }
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["owrench"] = {
    atlas = "images/rnc_inventoryimages.xml",
    image = "owrench.tex",
}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["nanoboost"] = {
    atlas = "images/rnc_inventoryimages.xml",
    image = "nanoboost.tex",
}

_G.owrench_init_fn = function(inst, build_name)
    _G.basic_init_fn(inst, build_name, "owrench" )
end

_G.owrench_clear_fn = function(inst)
    _G.basic_clear_fn(inst, "owrench" )
end

if GetModConfigData("Ratchet And Clank Characters") then
	AddModCharacter("ratchet", "MALE")
end

ModdedCurios = {
  ms_loading_ratchet1 = {
        type = "loading",
        skin_tags = {},
        rarity = "ModMade",
        assets = {
            Asset("ATLAS", "images/bg_loading_ms_loading_ratchet1.xml"),
            Asset("IMAGE", "images/bg_loading_ms_loading_ratchet1.tex"),
            
            Asset("DYNAMIC_ANIM", "anim/dynamic/ms_loading_ratchet1.zip"),
            Asset("PKGREF", "anim/dynamic/ms_loading_ratchet1.dyn")
        },
    },
}




