local assets =
{
    Asset("ANIM", "anim/armor_hazmat.zip"),
}

local function OnEquip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_body", "armor_hazmat", "swap_body")
	
	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
end

local function OnUnequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")
	
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
end

local function OnEquipToModel(inst)
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
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
    inst.components.fueled:InitializeFuelLevel(TUNING.HAZMAT_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.insulated = true
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable:SetOnEquipToModel(OnEquipToModel)

    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_SMALL)
	
	inst:AddComponent("setbonus")
	inst.components.setbonus:SetSetName(EQUIPMENTSETNAMES.RT_HAZMAT)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("hazmat", fn, assets)

