local assets = {
	Asset("ANIM", "anim/rt_anvil.zip"),
	Asset("ANIM", "anim/ui_anvil.zip"),
}

function Default_PlayAnimation(inst, anim, loop)
    inst.AnimState:PlayAnimation(forge_loop, loop)
end

function Default_PushAnimation(inst, anim, loop)
    inst.AnimState:PushAnimation(forg_loop, loop)
end


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
	
	MakeObstaclePhysics(inst, .5)
	
	
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
	
	inst._PlayAnimation = Default_PlayAnimation
	inst._PushAnimation = Default_PushAnimation

	return inst
end

return Prefab("rt_anvil", fn, assets),
	MakePlacer("rt_anvil_placer", "rt_anvil", "rt_anvil", "idle")