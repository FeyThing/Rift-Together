local Assets = {
    Asset("ANIM", "anim/respiratormask.zip"),
    
}

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_hat", "respiratormask", "swap_hat")
	
        owner.AnimState:Show("HAT")
		owner:AddTag("has_gasmask")
	
	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
end

local function OnUnequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")
	
	owner.AnimState:Hide("HAT")
	owner:RemoveTag("has_gasmask")
	
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
end

local function MainFunction()
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
	inst.components.inventoryitem.imagename = "respiratormask"
	inst.components.inventoryitem.atlasname = "images/rnc_inventoryimages.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetRadiationProtectPercent(0.2) 
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = FUELTYPE.USAGE
	inst.components.fueled:InitializeFuelLevel(480*5)
	inst.components.fueled:SetDepletedFn(inst.Remove)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0.2)
	
    MakeHauntableLaunch(inst)

    return inst
end

return  Prefab("respiratormask", MainFunction, Assets)
