local containers = require "containers"

local assets =
{
    Asset("ANIM", "anim/shockmod.zip"),
	Asset("ATLAS", "images/inventoryimages/shockmod.xml"),
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

    inst.AnimState:SetBuild("shockmod")
    inst.AnimState:SetBank("shockmod")
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
	inst.components.inventoryitem.atlasname = "images/inventoryimages/shockmod.xml"

    MakeHauntableLaunch(inst)
	

    return inst
end

return Prefab("common/inventory/shockmod", fn, assets, prefabs)