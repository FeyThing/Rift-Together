local assets =
{
	Asset( "ANIM", "anim/nefarious.zip" ),
	Asset( "ANIM", "anim/ghost_nefarious_build.zip" ),
	Asset( "ANIM", "anim/annihilator_attacks.zip" ),
	Asset( "ANIM", "anim/annihilator_basic.zip" ),
	Asset( "ANIM", "anim/annihilator_idles.zip" ),
	Asset( "ANIM", "anim/annihilator_jump.zip" ),
	Asset("ANIM", "anim/annihilator_actions.zip"),
	Asset("ANIM", "anim/annihilator_boat_jump.zip"),
	Asset("ANIM", "anim/annihilator_actions_item.zip"),
	Asset("ANIM", "anim/annihilator_actions_eat.zip"),
}

local skins =
{
	normal_skin = "nefarious",
	ghost_skin = "ghost_nefarious_build",
}

return CreatePrefabSkin("nefarious_none",
{
	base_prefab = "nefarious",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"nefarious", "CHARACTER", "BASE"},
	build_name_override = "nefarious",
	rarity = "Character",
})