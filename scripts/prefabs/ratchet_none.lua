local assets =
{
	Asset( "ANIM", "anim/ratchet.zip" ),
	Asset( "ANIM", "anim/ghost_ratchet_build.zip" ),
}

local skins =
{
	normal_skin = "ratchet",
	ghost_skin = "ghost_ratchet_build",
}

return CreatePrefabSkin("ratchet_none",
{
	base_prefab = "ratchet",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"ratchet", "CHARACTER", "BASE"},
	build_name_override = "ratchet",
	rarity = "Character",
})