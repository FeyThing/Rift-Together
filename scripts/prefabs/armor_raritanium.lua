local assets =
{
	Asset("ANIM", "anim/armor_raritanium.zip"),
}

local function OnBlocked(owner)
	owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function OnEquip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_body", "armor_raritanium", "swap_body")
	inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function OnUnequip(inst, owner)
	owner.AnimState:ClearOverrideSymbol("swap_body")
	inst:RemoveEventCallback("blocked", OnBlocked, owner)
end

local function SetupEquippable(inst)
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	inst.components.equippable:SetOnEquip(OnEquip)
	inst.components.equippable:SetOnUnequip(OnUnequip)
end

local function OnBroken(inst)
	if inst.components.equippable ~= nil then
		inst:RemoveComponent("equippable")
		inst:AddTag("broken")
		inst.components.inspectable.nameoverride = "BROKEN_FORGEDITEM"
	end
end

local function OnRepaired(inst)
	if inst.components.equippable == nil then
		SetupEquippable(inst)
		inst:RemoveTag("broken")
		inst.components.inspectable.nameoverride = nil
	end
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("armor_raritanium")
	inst.AnimState:SetBuild("armor_raritanium")
	inst.AnimState:PlayAnimation("anim")
	
	inst:AddTag("raritanium")
	inst:AddTag("show_broken_ui")
	
	inst.foleysound = "dontstarve/movement/foley/dreadstonearmour"
	
	local swap_data = {bank = "armor_raritanium", anim = "anim"}
	MakeInventoryFloatable(inst, "small", 0.2, 0.80, nil, nil, swap_data)
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
	
	inst:AddComponent("armor")
	inst.components.armor:InitCondition(TUNING.ARMOR_RARITANIUM, TUNING.ARMOR_RARITANIUM_ABSORPTION)
	
	SetupEquippable(inst)
	
	inst:AddComponent("damagetyperesist")
	inst.components.damagetyperesist:AddResist("explosive", inst, TUNING.ARMOR_RARITANIUM_EXPLOSIVE_RESIST)
	
	MakeForgeRepairable(inst, FORGEMATERIALS.RARITANIUM_BAR, OnBroken, OnRepaired)
	
	MakeHauntableLaunch(inst)
	
	return inst
end

return Prefab("armor_raritanium", fn, assets)

