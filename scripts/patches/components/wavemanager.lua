local function TrySpawnSteam(self, map, x, y, z)
	if map:IsSurroundedByWater(x, y, z, 2) then
		local wave = SpawnPrefab("toxic_oceanbubbles")
		wave.Transform:SetPosition( x, y, z )
	end
end

return function(self)
	if WORLD_TILES.OCEAN_TOXIC then
		self.shimmer[WORLD_TILES.OCEAN_TOXIC] = {per_sec = 80, spawn_rate = 0, tryspawn = TrySpawnSteam}
	end
end 