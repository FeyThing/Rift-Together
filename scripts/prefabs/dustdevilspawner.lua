local prefabs =
{
    "dustdevil",
}

local function OnIsSummer(inst)
  print("Spawning dustdevils in summer")
  inst:DoTaskInTime(0, function(inst)
  inst.components.childspawner:StartSpawning()
  end)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")
	
	inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "dustdevil"
    inst.components.childspawner:SetMaxChildren(math.random(3,5))
    inst.components.childspawner:SetSpawnPeriod(math.random(TUNING.MIN_TUMBLEWEED_SPAWN_PERIOD, TUNING.MAX_TUMBLEWEED_SPAWN_PERIOD))
    inst.components.childspawner:SetRegenPeriod(TUNING.TUMBLEWEED_REGEN_PERIOD)
    inst.components.childspawner.spawnoffscreen = true
		
	 
	inst:WatchWorldState("issummer", OnIsSummer)
	
	if not TheWorld.state.issummer then
		print("It is not summer, do not spawn dust devils")
		inst:DoTaskInTime(0, function(inst)
		inst.components.childspawner:StopSpawning()
		end)
	end	

    return inst
end

return Prefab("dustdevilspawner", fn, nil, prefabs)
