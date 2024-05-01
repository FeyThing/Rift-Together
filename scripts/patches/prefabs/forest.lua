local prefabs =
{
	"dimensional_rift",
}

local function SpawnDimensionalRift(inst)
    local day = 25 + math.random(0, 3)
    if TheWorld.state.cycles >= day and TheWorld.components.dimensionalriftspawner then
        TheWorld.components.dimensionalriftspawner:EnableRifts()
        TheWorld.components.dimensionalriftspawner:SpawnRift()
    end
end

return function(inst)
	
	--CLIENT
	if not TheWorld.ismastersim then
		return
	end
	--SERVER
	inst:AddComponent("dimensionalrifts")
	
	inst:WatchWorldState("cycles", SpawnDimensionalRift)
end
