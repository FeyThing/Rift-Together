local prefabs = {
	"dimensional_rift",
}

local function SpawnDimensionalRift(inst)
    local day = 25 + math.random(0, 3)
    if _G.TheWorld.state.cycles >= day and _G.TheWorld.components.dimensionalriftspawner then
        _G.TheWorld.components.dimensionalriftspawner:EnableRifts()
        _G.TheWorld.components.dimensionalriftspawner:SpawnRift()
    end
end

return function(inst)
	  --CLIENT
  
    if not TheNet:IsDedicated() and TUNING.RIFT_TOGETHER_OST then
        inst:AddComponent("rt_music")
    end
  
	  if not _G.TheWorld.ismastersim then
        return
    end
    --SERVER
end