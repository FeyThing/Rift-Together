local assets =
{
    Asset("ANIM", "anim/pillar_junk.zip"),
    Asset("MINIMAP_IMAGE", "pillar_junk"),
}



--[[local function choosebroken(inst, broken)
    local state = "full"
    if broken ~= nil then
        if broken == true then
            state = "broken"
        end
    else
        state = math.random() < 0.2 and "broken"
    end

    if state == "broken" then
        inst.broken = true
        inst.AnimState:SetBank("pillar_junk_broken")
        inst.AnimState:SetBuild("pillar_junk_broken")
    else
        inst.broken = false
    end
end]]

--[[local function OnSave(inst, data)
    data.broken = inst.broken
end]]

--[[local function OnLoad(inst, data)
    if data ~= nil and data.broken ~= nil then
        inst.broken = data.broken
        choosebroken(inst, inst.broken)
    end
end]]

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()

    MakeObstaclePhysics(inst, 2.5)
    inst.Physics:SetCylinder(1.8, 6)

    inst.MiniMapEntity:SetIcon("pillar_junk.tex")

    inst.AnimState:SetBank("pillar_junk")
    inst.AnimState:SetBuild("pillar_junk")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    --inst.OnSave = OnSave
    --inst.OnLoad = OnLoad
   -- inst:ListenForEvent("atriumpowered", function(_, ispowered) OnPoweredFn(inst, ispowered) end, TheWorld)

    return inst
end

return Prefab("junk_pillar", fn, assets)
