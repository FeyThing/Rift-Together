local assets =
{
    Asset("ANIM", "anim/structure_collapse_fx.zip"),
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst.Transform:SetScale(1, GetRandomMinMax(0.2, 1), 1)

    inst:AddTag("FX")
	inst:AddTag("NOCLICK")
	
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.AnimState:SetBank("collapse")
    inst.AnimState:SetBuild("structure_collapse_fx")
	inst.AnimState:PlayAnimation("collapse_small", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    --[[inst.SetVariation = SetVariation
    inst.Refresh = Refresh]]

    inst.persists = false
    inst.task = inst:DoTaskInTime(1, inst.Remove)

    return inst
end

return Prefab("dustdevil_fx", fn, assets)
