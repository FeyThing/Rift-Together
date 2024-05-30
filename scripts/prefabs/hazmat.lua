local assets =
{
    Asset("ANIM", "anim/armor_hazmat.zip"),
}

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_body", "armor_hazmat", "swap_body")

end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function onequiptomodel(inst)
    inst.components.fueled:StopConsuming()
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("armor_hazmat")
    inst.AnimState:SetBuild("armor_hazmat")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("waterproofer")

    inst.foleysound = "dontstarve/movement/foley/grassarmour"
    
    local swap_data = {bank = "armor_hazmat", anim = "anim"}
    MakeInventoryFloatable(inst, "small", 0.2, 0.80, nil, nil, swap_data)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("waterproofer")

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(TUNING.RAINCOAT_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.insulated = true
    inst.components.equippable:SetRadiationProtectPercent(0.5)
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable:SetOnEquipToModel(onequiptomodel)

    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_SMALL)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("hazmat", fn, assets)

