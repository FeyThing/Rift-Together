local assets =
{
    Asset("ANIM", "anim/raritanium_bar.zip"),
}

local function shine(inst)
    inst.task = nil
    inst.AnimState:PlayAnimation("sparkle")
    inst.AnimState:PushAnimation("idle")
    inst.task = inst:DoTaskInTime(4 + math.random() * 5, shine)
end

local prefabs =
{
 
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("raritanium_bar")
    inst.AnimState:SetBank("flint")
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
	inst.components.inventoryitem.atlasname = "images/inventoryimages/raritanium_bar.xml"

    MakeHauntableLaunchAndPerish(inst)
	shine(inst)

    return inst
end

return Prefab("common/inventory/raritanium_bar", fn, assets, prefabs)