local KnownModIndex = _G.KnownModIndex
local STRINGS = _G.STRINGS


-- Uncompromising Mode


if TUNING.RT_UNCOMP and MOD.UNCOMP_ENABLED then
	modimport("scripts/main/mods/uncomp")
end

--- Cherry Forest
if TUNING.RT_CHERRY and MOD.CHERRY_ENABLED then
	modimport("scripts/main/mods/cherryforest")
end

--- Island Adventures
if TUNING.RT_ISLAND and MOD.ISLAND_ENABLED then
	modimport("scripts/main/mods/ia")
end

--- Dehydration Mode
if TUNING.RT_DEHYDRATED and MOD.DEHYDRATED_ENABLED then
	modimport("scripts/main/mods/dehydration")
end

--- Shoes
if TUNING.RT_SHOES and MOD.SHOES_ENABLED then
	modimport("scripts/main/mods/shoetime")
end

--- Just in case the shoe slot is enabled without the original shoetime mod. Rift Together's shoes will become available.
if _G.EQUIPSLOTS.SHOES then
	table.insert(PrefabFiles, "shoes_hover")
	table.insert(PrefabFiles, "shoes_radiation")
		
end


