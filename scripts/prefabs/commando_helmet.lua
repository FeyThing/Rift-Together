local Assets = {
    Asset("ANIM", "anim/commando_helmet.zip"),
    
}

local function OnEquip(inst, owner)
		owner.AnimState:OverrideSymbol("swap_hat", "commando_helmet", "swap_hat")
        owner.AnimState:Show("HAT")
end

local function OnUnequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")
	owner.AnimState:Hide("HAT")
end

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("commando_helmet")
    inst.AnimState:SetBuild("commando_helmet")
    inst.AnimState:PlayAnimation("anim")

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
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	inst.components.equippable.restrictedtag = "veldin_mechanic"

	inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.ARMOR_FOOTBALLHAT, TUNING.ARMOR_FOOTBALLHAT_ABSORPTION)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)
	
    MakeHauntableLaunch(inst)

    return inst
end



return Prefab("commando_helmet", fn, Assets)
