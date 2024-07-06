local assets =
{
	Asset("ANIM", "anim/starfruitvine.zip"),
}

local function PlayAnim(inst, stage, anim, loop, push)
	if anim == "idle" then
		anim = ""
	end
	
	local fullanim = "vine"..stage..anim
	
	if push then
		inst.AnimState:PushAnimation(fullanim, loop)
	else
		inst.AnimState:PlayAnimation(fullanim, loop)
	end
end

local function OnEntityReplicated(inst)
	local parent = inst.entity:GetParent()
	
	if parent ~= nil and parent:HasTag("boulder") then
		if parent.highlightchildren == nil then
			parent.highlightchildren = { inst }
		else
			table.insert(parent.highlightchildren, inst)
		end
	end
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("starfruitvine")
	inst.AnimState:SetBuild("starfruitvine")
	inst.AnimState:PlayAnimation("vinefullempty")
	inst.AnimState:SetFinalOffset(1)
	
	inst:AddTag("DECOR")
	inst:AddTag("NOBLOCK")
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = OnEntityReplicated
		
		return inst
	end
	
	inst.persists = false
	
	inst.PlayAnim = PlayAnim
	
	return inst
end

return Prefab("starfruitvine", fn, assets)
