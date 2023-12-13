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


return unpack(prefabs)