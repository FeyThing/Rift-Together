local containers = require "containers"

local assets =
{
    Asset("ANIM", "anim/napalmmod.zip"),
	Asset("ATLAS", "images/inventoryimages/napalmmod.xml"),
}


local prefabs =
{

}

local function Onfueled(inst)

local installed = inst.components.container ~= nil and inst:HasTag("weaponmod")

if installed ~= nil then	
inst.components.fueled:StartConsuming()
end

end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("napalmmod")
    inst.AnimState:SetBank("napalmmod")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("weaponmod")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("inspectable")

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(TUNING.SWEATERVEST_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)

	Onfueled(inst)

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/napalmmod.xml"

    MakeHauntableLaunch(inst)
	

    return inst
end

return Prefab("napalmmod", fn, assets, prefabs)