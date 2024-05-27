local function MakeAlloy(name, anim)
    local assets = {
        Asset("ANIM", "anim/rt_alloys.zip"),
    }
    local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("rt_alloys")
    inst.AnimState:SetBank("rt_alloys")
    inst.AnimState:PlayAnimation(anim)

    inst:AddTag("alloy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")


    inst:AddComponent("inventoryitem")

    MakeHauntableLaunch(inst)

    return inst
    end

return Prefab(name, fn, assets)
end

return MakeAlloy("raritanium_bar", "idle_raritanium"),
       MakeAlloy("gold_bar", "idle_gold"),
       MakeAlloy("scrap_bar", "idle_scrap"),
       MakeAlloy("moonglass_bar", "idle_moonglass")




