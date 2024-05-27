local function MakeFilter(name, anim)
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

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM


    inst:AddComponent("inspectable")


    inst:AddComponent("inventoryitem")

    MakeHauntableLaunch(inst)

    return inst
    end

return Prefab(name, fn, assets)
end

return MakeFilter("rt_filter_small", "filter_small"),
       MakeFilter("rt_filter_large", "filter_large")