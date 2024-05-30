local Assets = {
    Asset("ANIM", "anim/hazhat.zip"),
    
}

local function OnEquip(inst, owner)
		owner.AnimState:OverrideSymbol("swap_hat", "hazhat", "swap_hat")      
			owner.AnimState:Show("HAT")
			owner.AnimState:Hide("HAIR_HAT")
			owner.AnimState:Hide("HAIR_NOHAT")
			owner.AnimState:Hide("HAIR")

			owner.AnimState:Hide("HEAD")
			owner.AnimState:Show("HEAD_HAT")
			--owner.AnimState:Hide("HEAD_HAT_NOHELM")
			--owner.AnimState:Show("HEAD_HAT_HELM")

			--owner.AnimState:HideSymbol("face")
			--owner.AnimState:HideSymbol("swap_face")
			owner.AnimState:HideSymbol("beard")
			owner.AnimState:HideSymbol("cheeks")

            owner:AddTag("has_gasmask")
			--owner.AnimState:UseHeadHatExchange(true)

end

local function OnUnequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")

    owner.AnimState:Hide("HAT")
    owner.AnimState:Show("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

    owner.AnimState:Show("HEAD")
    owner.AnimState:Hide("HEAD_HAT")
    --owner.AnimState:Show("HEAD_HAT_NOHELM")
    --owner.AnimState:Hide("HEAD_HAT_HELM")

   -- owner.AnimState:ShowSymbol("face")
    --owner.AnimState:ShowSymbol("swap_face")
    owner.AnimState:ShowSymbol("beard")
    owner.AnimState:ShowSymbol("cheeks")

    owner:RemoveTag("has_gasmask")
    --owner.AnimState:UseHeadHatExchange(false)
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
	
    inst:AddComponent("waterproofer")

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(TUNING.RAINCOAT_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable.insulated = true
    inst.components.equippable:SetRadiationProtectPercent(0.5)
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_SMALL)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)
	
    MakeHauntableLaunch(inst)

    return inst
end



return Prefab("hazhat", fn, Assets)
