local assets =
{
    Asset("ANIM", "anim/rt_alloys.zip"),
}

local prefabs =
{
 
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("rt_alloys")
    inst.AnimState:SetBank("rt_alloys")
    inst.AnimState:PlayAnimation("idle_raritanium")

    inst:AddTag("raritanium_bar")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("raritanium_bar", fn, assets, prefabs)