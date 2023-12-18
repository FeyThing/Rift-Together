local prefabs = {}

table.insert(prefabs, CreatePrefabSkin("ratchet_none", {
	assets = {
		Asset("ANIM", "anim/ratchet.zip"),
	},
	skins = {
		normal_skin = "ratchet",
		ghost_skin = "ghost_ratchet_build",
	},

	base_prefab = "ratchet",
	build_name_override = "ratchet",

	type = "base",
	rarity = "Character",

	skin_tags = { "BASE", "RATCHET"},
}))

table.insert(prefabs, CreatePrefabSkin("ms_rivet", {
	assets = {
        Asset("ANIM", "anim/ms_rivet.zip"),
        Asset("ANIM", "anim/ghost_ratchet_build.zip"),
    },
	skins = {
		normal_skin = "ms_rivet",
		ghost_skin = "ghost_ratchet_build",
	},

	base_prefab = "ratchet",
	build_name_override = "ms_rivet",

	--torso_untuck_builds = { "ms_rivet", },
	type = "base",
	rarity = "ModMade",

	skin_tags = { "BASE", "RIVET"},
}))


table.insert(prefabs, CreatePrefabSkin("ms_owrench_hammer", { --The ID of our skin
    assets = { --Our assets
        Asset( "ANIM", "anim/ms_owrench_hammer.zip"),
		Asset( "ANIM", "anim/ms_swap_owrench_hammer.zip"),
    },
    base_prefab = "owrench", --The prefab of the item/structure we're adding a skin for
    build_name_override = "ms_owrench_hammer",

    type = "item", --We are now creating a modded item/structure! Thus our skin's type is "item" (Note: there aren't different types for modded "structures", to the game there is no difference between skinning an item, a structure, or even a mob! (Yes you could create mob skins if you wanted!)
    rarity = "ModMade",

    skin_tags = {"OWRENCH"}, --Skin tags, you should add a tag matching the original prefab of the item/structure we're adding a skin for in full capitalization
}))


return unpack(prefabs)