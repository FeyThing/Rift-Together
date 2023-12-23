local Assets = {
    Asset("ANIM", "anim/respiratormask.zip"),
    
}

local function OnEquip(inst, owner)
    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD_HAT")
        owner.AnimState:Show("HEAD_HAT_HELM")
        owner.AnimState:UseHeadHatExchange(true)
        owner.AnimState:SetSymbolMultColour("headbase_hat", 0,0,0,0)
    else
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR_HAT")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
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
end

local function OnUnequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")
    owner.AnimState:SetSymbolMultColour("headbase_hat", 1,1,1,1)

    if inst.fx ~= nil then
        inst.fx:Remove()
        inst.fx = nil
    end

	owner.AnimState:Hide("HAT")
	owner:RemoveTag("has_gasmask")
    owner.AnimState:UseHeadHatExchange(false)

	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
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
	inst.components.inventoryitem.imagename = "respiratormask"
	inst.components.inventoryitem.atlasname = "images/rnc_inventoryimages.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetRadiationProtectPercent(0.5) -- from .2 to .5 temporarily until more rad combating equipment is created
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = FUELTYPE.USAGE
	inst.components.fueled:InitializeFuelLevel(480*5)
	inst.components.fueled:SetDepletedFn(inst.Remove)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0.5) -- supposed to match rad absorbtion, temp increase
	
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
	local follow_symbol = owner:HasTag("player") and owner.AnimState:BuildHasSymbol("headbase_hat") and "headbase_hat" or "swap_hat"
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
