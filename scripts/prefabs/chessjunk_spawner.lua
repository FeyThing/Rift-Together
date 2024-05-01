local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	

    
    inst:DoTaskInTime(0, function() 
        SpawnAt("chessjunk", inst):SetLessLoot()		
        inst:Remove()
    end)

    return inst
end

return Prefab("chessjunk_spawner", fn, prefabs)
    
