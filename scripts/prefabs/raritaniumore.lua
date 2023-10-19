local assets =
{
    Asset("ANIM", "anim/raritaniumore.zip"),
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

    inst.AnimState:SetBuild("raritaniumore")
    inst.AnimState:SetBank("raritaniumore")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("raritaniumore")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")


    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/rnc_inventoryimages.xml"

    MakeHauntableLaunch(inst)
	shine(inst)

    return inst
end

return Prefab("raritaniumore", fn, assets, prefabs)