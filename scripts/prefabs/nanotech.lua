local assets =
{
	Asset("ANIM", "anim/nanotech.zip"),
}

local prefabs =
{

}

local function OnDropped(inst)
    inst.Light:Enable(true)
end

local function OnPickup(inst)
    inst.Light:Enable(false)
end	

local function to_ground(inst)
    if inst.AnimState:IsCurrentAnimation("idle_loop") then
		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
    end
end	
	
local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddLight()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("nanotech")
	inst.AnimState:SetBuild("nanotech")
	inst.AnimState:PlayAnimation("idle_loop", true)
	inst.Transform:SetScale(.8,.8,.8)
	
	inst.Light:SetFalloff(1)
	inst.Light:SetIntensity(.5)
	inst.Light:SetRadius(1)
	inst.Light:SetColour(0/255,255/255,255/255)
	inst.Light:Enable(true)

	inst:AddTag("light")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()

	inst:AddComponent("healer")
	inst.components.healer:SetHealthAmount(TUNING.HEALING_MEDSMALL)
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime (TUNING.PERISH_TWO_DAY)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "ash"

	inst:AddComponent("stackable")
	
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	to_ground(inst)
	
	inst.components.inventoryitem.atlasname = "images/rnc_inventoryimages.xml"


	MakeSmallPropagator(inst)
	---------------------        

	------------------------------------------------
	inst:AddComponent("tradable")

	------------------------------------------------  

	inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
	inst.components.inventoryitem:SetOnPickupFn(OnPickup)


	MakeHauntableLaunchAndPerish(inst)

	return inst
end

return Prefab( "nanotech", fn, assets, prefabs)
	