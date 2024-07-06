require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/starfruit.zip"),
}

local prefabs =
{
    "starfruit_cooked",
    "spoiled_food",
   
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("starfruit")
    inst.AnimState:SetBuild("starfruit")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("icebox_valid")
    inst:AddTag("cattoy")
    inst:AddTag("show_spoilage")

    inst:AddTag("cookable")

    MakeInventoryFloatable(inst, "small", 0.15)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("cookable")
    inst.components.cookable.product = "starfruit_cooked"

    inst:AddComponent("tradable")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("edible")
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.secondaryfoodtype = FOODTYPE.BERRY
    inst.components.edible.radiationvalue = -10

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    inst:AddComponent("inventoryitem")

    inst:AddComponent("forcecompostable")
    inst.components.forcecompostable.brown = true

    MakeHauntableLaunchAndPerish(inst)


    return inst
end

local function cooked()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("starfruit")
    inst.AnimState:SetBuild("starfruit")
    inst.AnimState:PlayAnimation("cooked")

    MakeInventoryFloatable(inst, "small", 0.1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.secondaryfoodtype = FOODTYPE.BERRY
    inst.components.edible.radiationvalue = -15

    inst:AddComponent("tradable")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    inst:AddComponent("inventoryitem")

    inst:AddComponent("forcecompostable")
    inst.components.forcecompostable.brown = true

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("starfruit", fn, assets, prefabs),
       Prefab("starfruit_cooked", cooked, assets)
