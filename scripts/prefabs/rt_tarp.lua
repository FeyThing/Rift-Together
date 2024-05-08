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
	if inst._back == nil then
		inst._back = SpawnPrefab("rt_tarp_back")
		inst._back.Transform:SetScale(1, 1, 1)
		inst._back.entity:SetParent(inst.entity)
		inst._back.entity:AddFollower()
		inst._back.Follower:FollowSymbol(inst.GUID, "tent_front", -1, 0, -2)
	end
    if inst._stick == nil then
		inst._stick = SpawnPrefab("rt_tarp_stick")
		inst._stick.Transform:SetScale(1, 1, 1)
		inst._stick.entity:SetParent(inst.entity)
		inst._stick.entity:AddFollower()
		inst._stick.Follower:FollowSymbol(inst.GUID, "tent_front", 0, 0, -0.6)
	end		
end

local function tarp_back()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
    inst.Transform:SetFourFaced()

	inst:AddTag("NOBLOCK")
	inst:AddTag("NOCLICK")
	
	inst.AnimState:SetBuild("rt_tarp")
	inst.AnimState:SetBank("rt_tarp")
	inst.AnimState:PlayAnimation("back", true)
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
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
	
    inst.Transform:SetFourFaced()

	inst:AddTag("NOBLOCK")
	inst:AddTag("NOCLICK")
	
	inst.AnimState:SetBuild("rt_tarp")
	inst.AnimState:SetBank("rt_tarp")
	inst.AnimState:PlayAnimation("stick", true)
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
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

    inst.Transform:SetFourFaced()

    inst:AddTag("shelter")
    inst:AddTag("structure")

    inst.AnimState:SetBank("rt_tarp")
    inst.AnimState:SetBuild("rt_tarp")
    inst.AnimState:PlayAnimation("idle", true)

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

    inst:DoTaskInTime(0, OnInit)

    MakeHauntableWork(inst)

    return inst
end

return Prefab("rt_tarp", common_fn, assets),
       Prefab("rt_tarp_back", tarp_back, assets),
       Prefab("rt_tarp_stick", tarp_stick, assets),
    MakePlacer("rt_tarp_placer", "rt_tarp", "rt_tarp", "idle")
