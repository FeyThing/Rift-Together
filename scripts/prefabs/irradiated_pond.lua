local assets =
{
    Asset("ANIM", "anim/irradiated_pond.zip"),
    Asset("ANIM", "anim/splash.zip"),
}

local prefabs =
{
    "splash",
    "crab_king_bubble1",
    "crab_king_bubble2",
    "crab_king_bubble3",
}

local function CreateBubbles(inst)
    local fx = SpawnPrefab("crab_king_bubble"..math.random(3))
	fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	--inst.entity:AddLight()
    inst.entity:AddNetwork()

	inst:SetPhysicsRadiusOverride(3)

    inst.AnimState:SetBuild("irradiated_pond")
    inst.AnimState:SetBank("irradiated_pond")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)
	
	--inst.AnimState:SetSymbolBloom("toxicwater")
	--inst.AnimState:SetSymbolLightOverride("toxic", .1)
	--inst.AnimState:SetLightOverride(.1)
	
	inst.Transform:SetEightFaced()

    inst:AddTag("watersource")
    inst:AddTag("watersplasher")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")
    

    inst.no_wet_prefix = true


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("watersource")

	inst:AddComponent("unevenground")
    inst.components.unevenground.radius = 2

    inst:AddComponent("radiationsource")
    inst.components.radiationsource:SetRadius(18)
    inst.components.radiationsource:SetContaminationAmount(0.2)
    inst.components.radiationsource:SetRadiationAmount(12)
    inst.components.radiationsource:ShouldContaminateTiles(true)

	inst:DoPeriodicTask(0.5, CreateBubbles)

    return inst
end

return Prefab("irradiated_pond", fn, assets, prefabs)