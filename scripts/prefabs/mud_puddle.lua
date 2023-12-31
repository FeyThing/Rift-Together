local assets =
{
    Asset("ANIM", "anim/mud_puddle.zip"),
}



local function fn()
    local inst = CreateEntity()
   
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("mud_puddle")
    inst.AnimState:SetBuild("mud_puddle")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGroundFixed)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.Transform:SetRotation(90)
    inst.AnimState:SetSortOrder(3)
	
	inst:AddTag("antlion_sinkhole_blocker")
	inst:AddTag("NOCLICK")
	inst:SetDeployExtraSpacing(2)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("unevenground")			
    inst.components.unevenground.radius = 1.5	
	
    return inst
end

return Prefab("mud_puddle", fn, assets)
