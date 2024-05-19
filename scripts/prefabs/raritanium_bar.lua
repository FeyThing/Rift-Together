local assets =
{
    Asset("ANIM", "anim/raritanium_bar.zip"),
}

local prefabs =
{
 
}

local function shine(inst)
    if inst.task then
        inst.task:Cancel()
        inst.task = nil
    end
    inst.AnimState:PlayAnimation("sparkle")
    inst.AnimState:PushAnimation("idle")
    inst.task = inst:DoTaskInTime(4 + math.random() * 5, shine)
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("raritanium_bar")
    inst.AnimState:SetBank("raritanium_bar")
    inst.AnimState:PlayAnimation("idle")

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
	shine(inst)

    return inst
end

return Prefab("raritanium_bar", fn, assets, prefabs)