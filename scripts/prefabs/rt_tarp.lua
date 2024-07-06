local assets =
{
    Asset("ANIM", "anim/rt_tarp.zip"),
}


-----------------------------------------------------------------------

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", true)
    end
end


local function onbuilt_rt_tarp(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/tent_craft")
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

local function OnInit(inst)
    if inst._front == nil then
		inst._front = SpawnPrefab("rt_tarp_front")
		inst._front.Transform:SetScale(1, 1, 1)
		inst._front.entity:SetParent(inst.entity)
		inst._front.Transform:SetPosition(0, 0, 3) 
		table.insert(inst.highlightchildren, inst._front)
        
	end
	if inst._back == nil then
		inst._back = SpawnPrefab("rt_tarp_back")
		inst._back.Transform:SetScale(1, 1, 1)
		inst._back.entity:SetParent(inst.entity)
		inst._back.Transform:SetPosition(0, 0, -3) 
		table.insert(inst.highlightchildren, inst._back)
	end
    if inst._stick == nil then
		inst._stick = SpawnPrefab("rt_tarp_stick")
		inst._stick.Transform:SetScale(1, 1, 1)
		inst._stick.entity:SetParent(inst.entity)
		inst._stick.entity:AddFollower()
		inst._stick.Follower:FollowSymbol(inst.GUID, "shadow", 0, 0, 0)
		table.insert(inst.highlightchildren, inst._stick)
	end		
end

local function OnEntityReplicated(inst)
	local parent = inst.entity:GetParent()
	if parent ~= nil and parent.prefab == "rt_tarp" then
		parent.highlightchildren = parent.highlightchildren or {}
		table.insert(parent.highlightchildren, inst)
	end
end

local function tarp_back()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	

	inst:AddTag("NOBLOCK")
	inst:AddTag("NOCLICK")
	
	inst.AnimState:SetBuild("rt_tarp")
	inst.AnimState:SetBank("rt_tarp")
	inst.AnimState:PlayAnimation("idle2")
    inst.AnimState:SetDefaultEffectHandle(resolvefilepath("shaders/tarpslant.ksh"))
    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst:DoTaskInTime(0, function() 
        local x,y,z = inst.Transform:GetWorldPosition()
        inst.Transform:SetRotation(0)
        inst.AnimState:SetFloatParams(x, y, z)
    end)
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = OnEntityReplicated
		return inst
	end
	
	inst.persists = false
	
	return inst
end

local function tarp_front()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	

	inst:AddTag("NOBLOCK")
	inst:AddTag("NOCLICK")
	
	inst.AnimState:SetBuild("rt_tarp")
	inst.AnimState:SetBank("rt_tarp")
	inst.AnimState:PlayAnimation("idle2")
    inst.AnimState:SetDefaultEffectHandle(resolvefilepath("shaders/tarpslant_r.ksh"))
    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst:DoPeriodicTask(0, function() 
        local x,y,z = inst.Transform:GetWorldPosition()
        inst.Transform:SetRotation(0)
        inst.Transform:SetPosition(0, 0, 20)      
        inst.AnimState:SetFloatParams(x, y, z)
    end)
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = OnEntityReplicated
		return inst
	end
	
	inst.persists = false
	
	return inst
end

local function tarp_stick()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	inst:AddTag("NOBLOCK")
	inst:AddTag("NOCLICK")
	
	inst.AnimState:SetBuild("rt_tarp")
	inst.AnimState:SetBank("rt_tarp")
	inst.AnimState:PlayAnimation("stick1")
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = OnEntityReplicated
		return inst
	end
	
	inst.persists = false
	
	return inst
end

local function common_fn(onbuiltfn)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst:AddTag("shelter")
    inst:AddTag("structure")

    inst.AnimState:SetBank("rt_tarp")
    inst.AnimState:SetBuild("rt_tarp")
    inst.AnimState:PlayAnimation("shadow")
    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
 

    --inst.MiniMapEntity:SetIcon(icon)

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    MakeSnowCovered(inst)
    inst:ListenForEvent("onbuilt", onbuiltfn)

    MakeLargeBurnable(inst, nil, nil, true)
    MakeMediumPropagator(inst)

    inst.OnSave = onsave
    inst.OnLoad = onload
	
	inst.highlightchildren = {}
	
    inst:DoTaskInTime(0, OnInit)

    MakeHauntableWork(inst)

    return inst
end

return Prefab("rt_tarp", common_fn, assets),
       Prefab("rt_tarp_back", tarp_back, assets),
       Prefab("rt_tarp_front", tarp_front, assets),
       Prefab("rt_tarp_stick", tarp_stick, assets),
    MakePlacer("rt_tarp_placer", "rt_tarp", "rt_tarp", "idle")
