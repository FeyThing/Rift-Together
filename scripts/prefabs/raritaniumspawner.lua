local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("raritaniummeteorshower")

    return inst
end

return Prefab("raritaniumspawner", fn)