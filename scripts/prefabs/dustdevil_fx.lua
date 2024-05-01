local assets =
{
    Asset("ANIM", "anim/structure_collapse_fx.zip"),
}

local function OnStartFade(inst)
    inst.task = nil
    inst.AnimState:PlayAnimation("collapse_small")
end

local function OnAnimOver(inst)
    if inst.AnimState:IsCurrentAnimation("collapse_large") then
        inst.AnimState:PlayAnimation(inst.trailname)
        if inst.task ~= nil then
            inst.task:Cancel()
        end
        inst.task = inst:DoTaskInTime(inst.duration, OnStartFade)
    elseif inst.AnimState:IsCurrentAnimation("collapse_small") then
        inst:Remove()
    end
end

local function SetVariation(inst, rand, scale, duration)
    if inst.trailname == nil then
        inst.task:Cancel()
        inst.task = nil

        inst.Transform:SetScale(scale, scale, scale)

        inst.trailname = "collapse_large"
        inst.duration = duration
        inst.AnimState:PlayAnimation("collapse_large")
        inst:ListenForEvent("animover", OnAnimOver)
    end
end

local function Refresh(inst)
    if inst.trailname ~= nil and inst.task ~= nil then
        inst.task:Cancel()
        inst.task = inst:DoTaskInTime(inst.duration, OnStartFade)
    end
end

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
