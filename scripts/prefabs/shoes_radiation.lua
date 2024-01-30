local assets =
{
	Asset("ANIM", "anim/swap_shoes_radiation.zip"),
}

local function OnEquip(inst, owner)
	Shoes_OnEquip(inst, owner)
end

local function OnUnequip(inst, owner)	
	Shoes_OnUnequip(inst, owner)
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	
	MakeInventoryFloatable(inst, "small", 0, {0.85, 0.6, 0.85})
	
	inst:AddTag("shoes")
	inst:AddTag("waterproofer")
	
	inst.AnimState:SetBank("swap_shoes_radiation")
	inst.AnimState:SetBuild("swap_shoes_radiation")
	inst.AnimState:PlayAnimation("idle_radiation")
	
	inst.shoesanim = "radiation"
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst._hidefeet = true
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "shoes_radiation"
    inst.components.inventoryitem.atlasname = "images/rnc_inventoryimages.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.SHOES
	inst.components.equippable:SetRadiationProtectPercent(0.25)
	inst.components.equippable:SetOnEquip(OnEquip)
	inst.components.equippable:SetOnUnequip(OnUnequip)
	
	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = FUELTYPE.USAGE
	inst.components.fueled:InitializeFuelLevel(480*5)
	inst.components.fueled:SetDepletedFn(inst.Remove)
	
	inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_SMALL)
	
	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALLMED)
	
	inst:AddComponent("inspectable")
	
	MakeHauntableLaunch(inst)
	
	
	return inst
end

return Prefab("shoes_radiation", fn, assets)
