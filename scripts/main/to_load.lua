local INVENTORY_ITEMS = {
	"commando_helmet",
	"armor_raritanium",
	"cryomod",
	"turf_desertsand",
	"turf_junk",
	"luminous_fruit",
	"luminous_fruit_cooked",
	"starfruit",
	"starfruit_cooked",
	"turf_lush",
	"wx78module_maxresist",
	"ms_owrench_hammer",
	"nanoboost",
	"nanotech",
	"napalmmod",
	"owrench",
	"rarispear",
	"rarisword",
	"raritanium_bar",
	"gold_bar",
	"scrap_bar",
	"moonglass_bar",
	"raritaniumore",
	"respiratormask",
	"shockmod",
	"scrapbits",
	"shoes_hover",
	"shoes_radiation",
	"rt_spaceshake",
	"rt_fabric",
	"rt_filter_small",
	"rt_filter_large",
	"hazhat",
	"hazmat",
}

for i,v in ipairs(INVENTORY_ITEMS) do
	RegisterInventoryItemAtlas(_G.resolvefilepath("images/rnc_inventoryimages.xml"), v..".tex")
	RegisterInventoryItemAtlas(_G.resolvefilepath("images/rnc_inventoryimages.xml"), _G.hash(v..".tex"))
end

return {
	Prefabs = {	
		"ratchet",
		"ratchet_none",
		--"nefarious",
		--"nefarious_none",				
		"owrench",		
		"forcefieldfx1",
		"chessjunk_spawner",
		"sparks",
		"nanocrate",
		"nanotech",
		"nanoboost",
		"raritanium_crystals",
		"raritaniumore",
		"rnc_mods",
		"respiratormask",
		"hound_robomutt",
		"vullard_lamp",
		"vullard_smelter",
		"scraprock",
		"scrapmetal",
		"scrapbits",
		"junkpile",
		"torren_pillars",
		"torren_grass",
		"torren_cactus",
		"mud_puddle",
		"raritaniummeteor",
		"raritaniumspawner",
		"radiation_clouds",
		"luminoustrees",
		"luminous_fruit",
		"rarisword",
		"rarispear",
		"toxic_oceanbubbles",
		"barrel_radioactive",
		"hound_robomuttherd",
		"dimensional_rift",
		"radiation_dust",
		"irradiated_pond",
		"luminoustree_sapling",
		"commando_helmet",
		"armor_raritanium",
		"dustdevil",
		"dustdevilspawner",
		"dustdevil_fx",
		"rt_pawn",
		"rt_tarp",
		"rt_alloys",
		"rt_anvil",
		"rt_fabric",
		"filters",	
		"starfruit",
		"hazhat",
		"hazmat",
	},

	Assets = {
		Asset( "ANIM", "anim/radiation_meter.zip"),
		Asset( "ANIM", "anim/player_shoeshover.zip"),
		Asset( "ANIM", "anim/player_drink.zip"),
		Asset( "ANIM", "anim/winterfood.zip"),
		Asset( "ANIM", "anim/rt_crockpotfood.zip"),
		Asset( "ANIM", "anim/rnc_turf.zip"),
		Asset( "ANIM", "anim/rtstatus_wx.zip"),
		Asset( "ANIM", "anim/rt_chips.zip"),
		
		Asset( "IMAGE", "images/saveslot_portraits/ratchet.tex" ),
		Asset( "ATLAS", "images/saveslot_portraits/ratchet.xml" ),

		Asset( "IMAGE", "images/selectscreen_portraits/ratchet.tex" ),
		Asset( "ATLAS", "images/selectscreen_portraits/ratchet.xml" ),
		
		Asset( "IMAGE", "images/selectscreen_portraits/ratchet_silho.tex" ),
		Asset( "ATLAS", "images/selectscreen_portraits/ratchet_silho.xml" ),

		Asset( "IMAGE", "bigportraits/ratchet.tex" ),
		Asset( "ATLAS", "bigportraits/ratchet.xml" ),
		
		Asset( "IMAGE", "bigportraits/ratchet_none.tex" ),
		Asset( "ATLAS", "bigportraits/ratchet_none.xml" ),
		
		Asset( "IMAGE", "bigportraits/ms_rivet.tex" ),
		Asset( "ATLAS", "bigportraits/ms_rivet.xml" ),
		
		Asset( "IMAGE", "images/avatars/avatar_ratchet.tex" ),
		Asset( "ATLAS", "images/avatars/avatar_ratchet.xml" ),
		
		Asset( "IMAGE", "images/avatars/avatar_ghost_ratchet.tex" ),
		Asset( "ATLAS", "images/avatars/avatar_ghost_ratchet.xml" ),
		
		Asset( "IMAGE", "images/avatars/self_inspect_ratchet.tex" ),
		Asset( "ATLAS", "images/avatars/self_inspect_ratchet.xml" ),
		
		Asset( "IMAGE", "images/names_gold_ratchet.tex" ),
		Asset( "ATLAS", "images/names_gold_ratchet.xml" ),

		Asset( "IMAGE", "images/rtjunkpillar.tex" ),
		
		--[[
		
		--Asset( "IMAGE", "images/ratchet_skilltree.tex" ),
		--Asset( "ATLAS", "images/ratchet_skilltree.xml" ),

		--Nefarious
		Asset( "IMAGE", "images/saveslot_portraits/nefarious.tex" ),
		Asset( "ATLAS", "images/saveslot_portraits/nefarious.xml" ),

		Asset( "IMAGE", "images/selectscreen_portraits/nefarious.tex" ),
		Asset( "ATLAS", "images/selectscreen_portraits/nefarious.xml" ),
		
		Asset( "IMAGE", "images/selectscreen_portraits/nefarious_silho.tex" ),
		Asset( "ATLAS", "images/selectscreen_portraits/nefarious_silho.xml" ),

		Asset( "IMAGE", "bigportraits/nefarious.tex" ),
		Asset( "ATLAS", "bigportraits/nefarious.xml" ),
		
		Asset( "IMAGE", "images/avatars/avatar_nefarious.tex" ),
		Asset( "ATLAS", "images/avatars/avatar_nefarious.xml" ),
		
		Asset( "IMAGE", "images/avatars/avatar_ghost_nefarious.tex" ),
		Asset( "ATLAS", "images/avatars/avatar_ghost_nefarious.xml" ),
		
		Asset( "IMAGE", "images/names_nefarious.tex" ),
		Asset( "ATLAS", "images/names_nefarious.xml" ),]]

				
		--sound
		Asset("SOUNDPACKAGE", "sound/ratchet.fev"),
		Asset("SOUND", "sound/ratchet.fsb"),

		Asset("SOUNDPACKAGE", "sound/rt_music.fev"),
		Asset("SOUND", "sound/rt_music.fsb"),
		
		-- Asset("SOUNDPACKAGE", "sound/radiation.fev"),
		-- Asset("SOUND", "sound/radiation.fsb"),
				
		--items
		Asset("ATLAS", "images/rnc_inventoryimages.xml"),
		Asset("IMAGE", "images/rnc_inventoryimages.tex"),
		Asset("ATLAS_BUILD", "images/rnc_inventoryimages.xml", 256),

		Asset("ATLAS", "images/rt_cookbook.xml"),
		Asset("IMAGE", "images/rt_cookbook.tex"),

		Asset("ATLAS", "images/rnc_ui_images.xml"),
		Asset("IMAGE", "images/rnc_ui_images.tex"),
		
		Asset("ATLAS", "images/rnc_hud.xml"),
		Asset("IMAGE", "images/rnc_hud.tex"),
		
		Asset("ATLAS", "images/rnc_map_icons.xml"),
		Asset("IMAGE", "images/rnc_map_icons.tex"),
	},

	MiniMaps = {
		"images/rnc_map_icons.xml",
	},	
}

