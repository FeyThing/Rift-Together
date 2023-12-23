local assets =
{
    Asset("ANIM", "anim/irradiated_pond.zip"),
    Asset("ANIM", "anim/splash.zip"),
}

local prefabs =
{
    "trinket_10",
	"trinket_17",
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1.95)

    inst.AnimState:SetBuild("irradiated_pond")
    inst.AnimState:SetBank("irradiated_pond")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst:AddTag("watersource")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")
    

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("radiationspreader")
    inst.components.radiationspreader:SetRadius(2)

    return inst
end

return Prefab("irradiated_pond", fn, assets, prefabs)
