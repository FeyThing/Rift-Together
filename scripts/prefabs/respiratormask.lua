local Assets = {
    Asset("ANIM", "anim/respiratormask.zip"),
    
}

local function EnableRadProtection(inst)
	local owner = inst.components.inventoryitem.owner
	
	if owner ~= nil and owner.components.radiation ~= nil then
		owner.components.radiation:AddPenalty(inst, TUNING.RESPIRATORMASK_RAD_PROTECTION)
	end
end

local function DisableRadProtection(inst)
	local owner = inst.components.inventoryitem.owner
	
	if owner ~= nil and owner.components.radiation ~= nil then
		owner.components.radiation:RemovePenalty(inst)
	end
end

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_hat", "respiratormask", "swap_hat")
    if owner:HasTag("player") then
        owner.AnimState:Show("HAT")
    end
    owner:AddTag("has_gasmask")
	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
	
	EnableRadProtection(inst)
end

local function OnUnequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")
	owner.AnimState:Hide("HAT")
	owner:RemoveTag("has_gasmask")
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
	
	DisableRadProtection(inst)
end

local function OnEquipToModel(inst)
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
end

local function OnPerish(inst)
	DisableRadProtection(inst)
end

local function OnTakeFuel(inst)
	if inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
		EnableRadProtection(inst)
	end
end

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("respiratormask")
    inst.AnimState:SetBuild("respiratormask")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("respiratormask")
	inst:AddTag("has_gasmask")
	inst:AddTag("waterproofer")
	
	MakeInventoryFloatable(inst, "small", 0.1, 1.12)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then

        return inst
    end
	
    inst:AddComponent("inspectable")

    inst:AddComponent("tradable")

    inst:AddComponent("inventoryitem")
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	--inst.components.equippable:SetRadiationProtectPercent(TUNING.RESPIRATORMASK_RAD_PROTECTION)
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	inst.components.equippable:SetOnEquipToModel(OnEquipToModel)

	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = FUELTYPE.RT_FILTER
	inst.components.fueled:InitializeFuelLevel(TUNING.RESPIRATORMASK_PERISHTIME)
	inst.components.fueled:SetDepletedFn(OnPerish)
	inst.components.fueled:SetTakeFuelFn(OnTakeFuel)
	inst.components.fueled.accepting = true

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)
	
    MakeHauntableLaunch(inst)

    return inst
end


return Prefab("respiratormask", fn, Assets)
