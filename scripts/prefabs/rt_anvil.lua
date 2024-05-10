local assets = {
	Asset("ANIM", "anim/rt_anvil.zip"),
	Asset("ANIM", "anim/ui_anvil.zip"),
}

local function OnBuilt(inst)
	inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/chest_craft")
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddLight()
	inst.entity:AddNetwork()
	
	MakeObstaclePhysics(inst, 1)
	
	
	inst:AddTag("structure")
	inst:AddTag("anvil")
	
	
	inst.AnimState:SetBank("rt_anvil")
	inst.AnimState:SetBuild("rt_anvil")
	inst.AnimState:PlayAnimation("idle")
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("rt_anvil")

	
	inst:ListenForEvent("onbuilt", OnBuilt)
	
	return inst
end

return Prefab("rt_anvil", fn, assets),
	MakePlacer("rt_anvil_placer", "rt_anvil", "rt_anvil", "idle")