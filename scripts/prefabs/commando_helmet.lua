local Assets = {
    Asset("ANIM", "anim/commando_helmet.zip"),
    
}

local function OnEquip(inst, owner)
	-- This will override symbol "swap_body" of the equipping player with your custom build symbol.
	-- Here's what this function is overriding:
	-- owner.AnimState:OverrideSymbol(Player's_symbol, Your_build(*.zip_filename), Symbol_from_your_build(name_of_subfolder_with_art)
    owner.AnimState:OverrideSymbol("swap_hat", "commando_helmet", "swap_hat")
	
	-- Show/Hide some of the layers of the character while equipping the hat.
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAIR_HAT")
	owner.AnimState:Hide("HAIR_NOHAT")
	owner.AnimState:Hide("HAIR")
	
	-- If the equipping guy is the player, do some additional stuff.
	if owner:HasTag("player") then
		owner.AnimState:Hide("HEAD")
		owner.AnimState:Show("HEAD_HAT")
	end
	
	-- If we should lose usage percent over time while wearing the hat - start dropping the percentage when we're equipping the hat.
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
	end
	
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
end

local function MainFunction()
	-- Functions which are performed both on Client and Server start here.
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

	
	local minimap = inst.entity:AddMiniMapEntity()
	--minimap:SetIcon("commando_helmet.tex")
	

    inst.AnimState:SetBank("commando_helmet")
    inst.AnimState:SetBuild("commando_helmet")
    inst.AnimState:PlayAnimation("anim")

	--[[ TAGS ]]--
	inst:AddTag("HASRADIOACTIVE")
    inst:AddTag("commando_helmet")
	inst:AddTag("waterproofer")
	
	MakeInventoryFloatable(inst, "small", 0.1, 1.12)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then

        return inst
    end
	
    inst:AddComponent("inspectable")

	-- Allow "trading" the hat - used for giving the hat to Pigmen.
    inst:AddComponent("tradable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "commando_helmet"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/commando_helmet.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = FUELTYPE.USAGE
	inst.components.fueled:InitializeFuelLevel(480*5)
	inst.components.fueled:SetDepletedFn(inst.Remove)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0.2)

    inst:AddComponent("radioactive")	
	inst.components.radioactive.aura = TUNING.RADIATION_SMALL
	

    MakeHauntableLaunch(inst)

    return inst
end

return  Prefab("common/inventory/commando_helmet", MainFunction, Assets)
