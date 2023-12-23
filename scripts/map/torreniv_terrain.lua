local filters = terrain.filter

local function OnlyAllow(approved)
	local filter = {}
	for _,v in pairs(GetWorldTileMap()) do
		if not table.contains(approved, v) then
			table.insert(filter, v)
		end
	end
	return filter
end

local torren_filters =
{
	luminoustree = {WORLD_TILES.DESERTDIRT, WORLD_TILES.DESERTSAND, WORLD_TILES.DESERTSAND_NOISE},
	luminoustree_burnt = {WORLD_TILES.LUSH, WORLD_TILES.DESERTFERTILE_NOISE},
	luminoustree_stump = {WORLD_TILES.LUSH},
	torren_grass = {WORLD_TILES.JUNK, WORLD_TILES.DESERTDIRT, WORLD_TILES.DESERTSAND_NOISE},
	torren_cactus = {WORLD_TILES.LUSH, WORLD_TILES.JUNK},
	mud_puddle = {WORLD_TILES.JUNK, WORLD_TILES.LUSH},
	
	torrenivdesert_pillar = {WORLD_TILES.LUSH, WORLD_TILES.JUNK, WORLD_TILES.DESERTFERTILE_NOISE},
	torrenivdesert_pillar_small = {WORLD_TILES.LUSH, WORLD_TILES.JUNK, WORLD_TILES.DESERTFERTILE_NOISE},
	junk_pillar = {WORLD_TILES.DESERTDIRT, WORLD_TILES.DESERTSAND, WORLD_TILES.DESERTFERTILE_NOISE},
	
	chessjunk_spawner = {WORLD_TILES.DESERTSAND, WORLD_TILES.LUSH},
	junkpile = {WORLD_TILES.DESERTSAND, WORLD_TILES.LUSH},
	scraprock = {WORLD_TILES.DESERTSAND, WORLD_TILES.LUSH},
	scrapmetal = {WORLD_TILES.DESERTSAND, WORLD_TILES.LUSH},
	barrel_radioactive = {WORLD_TILES.DESERTSAND, WORLD_TILES.LUSH},
}

for terrain, tiles in pairs(torren_filters) do
	filters[terrain] = tiles
end