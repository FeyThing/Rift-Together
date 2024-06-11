local Assets = {
    Asset("ANIM", "anim/hazhat.zip"),
    
}

local function OnEquip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_hat", "hazhat", "swap_hat")
	
	owner.AnimState:Show("HAT")
	owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Hide("HAIR_NOHAT")
	owner.AnimState:Hide("HAIR")
	
	if owner:HasTag("player") then
		owner.AnimState:Hide("HEAD")
		owner.AnimState:Show("HEAD_HAT")
		owner.AnimState:Hide("HEAD_HAT_NOHELM")
		owner.AnimState:Show("HEAD_HAT_HELM")
		
		owner.AnimState:HideSymbol("face")
		owner.AnimState:HideSymbol("swap_face")
		--owner.AnimState:HideSymbol("beard")
		owner.AnimState:HideSymbol("cheeks")
	end
	
    owner:AddTag("has_gasmask")
	
	if inst.components.container ~= nil then
		inst.components.container:Open(owner)
	end
	
	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
end

local function OnUnequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")
	
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
	
	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAT")
		owner.AnimState:Hide("HEAD_HAT_NOHELM")
		owner.AnimState:Hide("HEAD_HAT_HELM")
		
		owner.AnimState:ShowSymbol("face")
		owner.AnimState:ShowSymbol("swap_face")
		--owner.AnimState:ShowSymbol("beard")
		owner.AnimState:ShowSymbol("cheeks")
	end
	
    owner:RemoveTag("has_gasmask")
	
	if inst.components.container ~= nil then
		inst.components.container:Close()
	end
	
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
end

local function OnEquipToModel(inst)
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
end

local function StartConsumingFilter(filter)
	if filter.components.fueled ~= nil then
		filter.components.fueled:StartConsuming()
	end
end

local function StopConsumingFilter(filter)
	if filter.components.fueled ~= nil then
		filter.components.fueled:StopConsuming()
	end
end

local function HasFilter(inst)
	local container = inst.components.container
	
	return container ~= nil and container:IsFull()
end

local function UpdateBonus(inst)
	local setbonus = inst.components.setbonus
	local equippable = inst.components.equippable
	local owner = inst.components.inventoryitem.owner
	
	if setbonus ~= nil and equippable ~= nil and equippable:IsEquipped() and owner ~= nil and owner.components.inventory ~= nil then
		local has_setbonus, setname = setbonus:_HasSetBonus(owner.components.inventory)
		local should_enable = HasFilter(inst) and has_setbonus
		owner.components.inventory:ForEachEquipment(should_enable and setbonus.EnableBonusForEquip or setbonus.DisableBonusForEquip, setname)
	end
end

local function OnEnabledSetBonus(inst)
	local owner = inst.components.inventoryitem.owner
	local container = inst.components.container
	
	if owner ~= nil and container ~= nil then
		if HasFilter(inst) then
			owner.components.radiation:AddPenalty(inst, 1)
			inst.components.container:ForEachItem(StartConsumingFilter)
		end
	end
end

local function OnDisabledSetBonus(inst)
	local owner = inst.components.inventoryitem.owner
	local container = inst.components.container
	
	if owner ~= nil and container ~= nil then
		owner.components.radiation:RemovePenalty(inst)
		inst.components.container:ForEachItem(StopConsumingFilter)
	end
end

local function OnGetItem(inst, data)
	local setbonus = inst.components.setbonus
	
	if setbonus ~= nil and setbonus:IsEnabled(EQUIPMENTSETNAMES.RT_HAZMAT) then
		OnEnabledSetBonus(inst)
	end
end

local function OnLoseItem(inst, data)
	OnDisabledSetBonus(inst)
	
	if data ~= nil and data.prev_item ~= nil then
		StopConsumingFilter(data.prev_item)
	end
end

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("hazhat")
    inst.AnimState:SetBuild("hazhat")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("respiratormask")
	inst:AddTag("has_gasmask")
	inst:AddTag("waterproofer")
	inst:AddTag("goggles")
	
	MakeInventoryFloatable(inst, "small", 0.1, 1.12)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then

        return inst
    end
	
    inst:AddComponent("inspectable")

    inst:AddComponent("tradable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(TUNING.HAZHAT_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)
	
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("hazhat")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable.insulated = true
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	inst.components.equippable:SetOnEquipToModel(OnEquipToModel)

    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_SMALL)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)
	
	inst:AddComponent("setbonus")
	inst.components.setbonus:SetSetName(EQUIPMENTSETNAMES.RT_HAZMAT)
	inst.components.setbonus:SetOnEnabledFn(OnEnabledSetBonus)
	inst.components.setbonus:SetOnDisabledFn(OnDisabledSetBonus)
	
	inst:ListenForEvent("itemget", OnGetItem)
	inst:ListenForEvent("itemlose", OnLoseItem)
	
    MakeHauntableLaunch(inst)

    return inst
end



return Prefab("hazhat", fn, Assets)
