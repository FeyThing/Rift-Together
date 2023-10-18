local assets =
{
    Asset("ANIM", "anim/torren_cactus.zip"),
}

local prefabs =
{
    "cactus_meat",
}

local function ontransplantfn(inst)
    inst.components.pickable:MakeEmpty()
end

local function onpickedfn(inst, picker)
    inst.Physics:SetActive(false)
	inst.AnimState:PushAnimation("empty", true)

    if picker ~= nil then
        if picker.components.combat ~= nil and not (picker.components.inventory ~= nil and picker.components.inventory:EquipHasTag("bramble_resistant")) and not picker:HasTag("shadowminion") then
            picker.components.combat:GetAttacked(inst, TUNING.CACTUS_DAMAGE)
            picker:PushEvent("thorns")
        end                                             
        end
    end

local function onregenfn(inst)
        inst.AnimState:PlayAnimation("grow")
        inst.AnimState:PushAnimation("idle", true)
   
    inst.Physics:SetActive(true)
end

local function makeemptyfn(inst)
    inst.Physics:SetActive(false)
end


local function MakeCactus(name)
    local function torren_cactusfn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        inst.MiniMapEntity:SetIcon("torren_cactus.tex")

        inst.AnimState:SetBuild(name)
        inst.AnimState:SetBank(name)
        inst.AnimState:PlayAnimation("idle", true)

        inst:AddTag("plant")
        inst:AddTag("thorny")

        MakeObstaclePhysics(inst, .3)

        inst:SetPrefabNameOverride("torren_cactus")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/harvest_sticks"

        inst.components.pickable:SetUp("cactus_meat", TUNING.CACTUS_REGROW_TIME)
        inst.components.pickable.onregenfn = onregenfn
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
        inst.components.pickable.ontransplantfn = ontransplantfn

        inst:AddComponent("inspectable")

        MakeLargeBurnable(inst)
        AddToRegrowthManager(inst)
        MakeMediumPropagator(inst)

        MakeHauntableIgnite(inst)

        return inst
    end

    return Prefab(name, torren_cactusfn, assets, prefabs)
end


return MakeCactus("torren_cactus")
   
