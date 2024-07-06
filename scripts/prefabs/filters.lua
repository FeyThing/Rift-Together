local function MakeFilter(name, anim, fuelvalue)
    local assets = {
        Asset("ANIM", "anim/rt_filter.zip"),
    }
    local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("rt_filter")
    inst.AnimState:SetBank("rt_filter")
    inst.AnimState:PlayAnimation(anim)

    inst:AddTag("filter")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	
	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = FUELTYPE.USAGE
	inst.components.fueled.no_sewing = true
	inst.components.fueled:InitializeFuelLevel(fuelvalue)
	inst.components.fueled:SetDepletedFn(inst.Remove)
	
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = fuelvalue
	inst.components.fuel.fueltype = FUELTYPE.RT_FILTER
	
    MakeHauntableLaunch(inst)

    return inst
    end

return Prefab(name, fn, assets)
end

return MakeFilter("rt_filter_small", "filter_small", TUNING.RT_FILTER_SMALL_PERISHTIME),
       MakeFilter("rt_filter_large", "filter_large", TUNING.RT_FILTER_LARGE_PERISHTIME)