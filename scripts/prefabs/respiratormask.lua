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
    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAT")
        owner.AnimState:Hide("HEAD_HAT_NOHELM")
        owner.AnimState:Hide("HEAD_HAT_HELM")
        --owner.AnimState:UseHeadHatExchange(true)
        --owner.AnimState:SetSymbolMultColour("headbase", 0,0,0,0)
    else
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR_HAT")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
    end
    owner:AddTag("has_gasmask")
    
    if inst.fx ~= nil then
        inst.fx:Remove()
    end
    inst.fx = SpawnPrefab("respiratormask_fx")
    inst.fx:AttachToOwner(owner)

	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
	
	EnableRadProtection(inst)
end

local function OnUnequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")
    --owner.AnimState:SetSymbolMultColour("headbase", 1,1,1,1)

    if inst.fx ~= nil then
        inst.fx:Remove()
        inst.fx = nil
    end

	owner.AnimState:Hide("HAT")
	owner:RemoveTag("has_gasmask")
    --owner.AnimState:UseHeadHatExchange(false)

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
--------------------------------------------------------------------------

local function CreateFxFollowFrame(i)
	local inst = CreateEntity()

	--[[Non-networked entity]]
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddFollower()

	inst:AddTag("FX")

	inst.AnimState:SetBank("respiratormask")
	inst.AnimState:SetBuild("respiratormask")
	inst.AnimState:PlayAnimation("idle"..tostring(i), true)

	inst:AddComponent("highlightchild")

	inst.persists = false

	return inst
end
local function FollowFx_OnRemoveEntity(inst)
	for i, v in ipairs(inst.fx) do
		v:Remove()
	end
end

local function FollowFx_ColourChanged(inst, r, g, b, a)
	for i, v in ipairs(inst.fx) do
		v.AnimState:SetAddColour(r, g, b, a)
	end
end

local function SpawnFollowFxForOwner(inst, owner)
	local follow_symbol = owner:HasTag("player") and owner.AnimState:BuildHasSymbol("headbase") and "headbase" or "swap_hat"
	inst.fx = {}
	local frame
	for i = 1, 3 do        
		local fx = CreateFxFollowFrame(i)
		frame = frame or math.random(fx.AnimState:GetCurrentAnimationNumFrames()) - 1
		fx.entity:SetParent(owner.entity)
		fx.Follower:FollowSymbol(owner.GUID, follow_symbol, nil, nil, nil, true, nil, i - 1)
		fx.AnimState:SetFrame(frame)
		fx.components.highlightchild:SetOwner(owner)
		table.insert(inst.fx, fx)
	end
	inst.components.colouraddersync:SetColourChangedFn(FollowFx_ColourChanged)
	inst.OnRemoveEntity = FollowFx_OnRemoveEntity
end

local function OnEntityReplicated(inst)
    local owner = inst.entity:GetParent()
    if owner ~= nil then
        SpawnFollowFxForOwner(inst, owner)
    end
end

local function AttachToOwner(inst, owner)        
    inst.entity:SetParent(owner.entity)
    if owner.components.colouradder ~= nil then
        owner.components.colouradder:AttachChild(inst)
    end
    --Dedicated server does not need to spawn the local fx
    if not TheNet:IsDedicated() then            
        SpawnFollowFxForOwner(inst, owner)
    end
end

local function fnfx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst:AddComponent("colouraddersync")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = OnEntityReplicated

        return inst
    end

    inst.AttachToOwner = AttachToOwner
    inst.persists = false

    return inst
end

return Prefab("respiratormask", fn, Assets),
    Prefab("respiratormask_fx", fnfx, Assets)
