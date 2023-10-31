local assets =
{
    Asset("ANIM", "anim/dimensional_rift.zip"),
}

local prefabs = {}

------ Constants ---------------------------------------------------------------

local AMBIENT_SOUND_PATH = "rifts2/shadow_rift/shadowrift_portal_allstage"
local AMBIENT_SOUND_LOOP_NAME = "shadowrift_portal_ambience"
local AMBIENT_SOUND_PARAM_NAME = "stage"
local AMBIENT_SOUND_STAGE_TO_INTENSITY = {0.1, 0.4, 0.7}
local PHYSICS_SIZE_BY_STAGE = {1.2, 2.2, 3.2}

local SHAKE_PARAMS_BY_STAGE = {
    {0.5, .01, .1, 50 },
    {1.0, .03, .2, 100},
    {1.5, .06, .3, 200},
}

local function SetMaxMinimapStatus(inst)
    inst.MiniMapEntity:SetCanUseCache(false)
    inst.MiniMapEntity:SetDrawOverFogOfWar(true)
    inst.MiniMapEntity:SetPriority(22)
    inst.MiniMapEntity:SetIcon("shadowrift_portal_max.png")

    inst.icon = SpawnPrefab("globalmapicon")
    inst.icon:TrackEntity(inst)
    inst.icon.MiniMapEntity:SetPriority(22)
end

local function GetStageUpTime(inst)
    return 900 + TUNING.RIFT_SHADOW1_STAGEUP_RANDOM_TIME * math.random()
end

local function Initialize(inst)
    inst.SoundEmitter:PlaySound("rifts2/shadow_rift/groundcrack_expand")

    local duration, speed, scale, max_dist = unpack(SHAKE_PARAMS_BY_STAGE[inst._stage])
    ShakeAllCameras(CAMERASHAKE.FULL, duration, speed, scale, inst, max_dist)
end

local function TryStageUp(inst)
    if inst._closing then 
        return 
    end

    if inst._stage < TUNING.RIFT_SHADOW1_MAXSTAGE then
        local next_stage = inst._stage + 1
        inst._stage = next_stage

        inst.Physics:SetCylinder(PHYSICS_SIZE_BY_STAGE[next_stage], 6)

        local duration, speed, scale, max_dist = unpack(SHAKE_PARAMS_BY_STAGE[next_stage])
        ShakeAllCameras(CAMERASHAKE.FULL, duration, speed, scale, inst, max_dist)

        inst.AnimState:PlayAnimation("stage_"..next_stage.."_pre")
        inst.AnimState:PushAnimation("stage_"..next_stage.."_loop", true)

        inst.SoundEmitter:SetParameter(AMBIENT_SOUND_LOOP_NAME, AMBIENT_SOUND_PARAM_NAME, AMBIENT_SOUND_STAGE_TO_INTENSITY[next_stage])
        inst.SoundEmitter:PlaySound("rifts2/shadow_rift/groundcrack_expand")

        if next_stage < TUNING.RIFT_SHADOW1_MAXSTAGE then
            if not inst.components.timer:TimerExists("trynextstage") then
                inst.components.timer:StartTimer("trynextstage", GetStageUpTime())
            end
        else
            inst.components.timer:StopTimer("trynextstage")
        end

        if next_stage == TUNING.RIFT_SHADOW1_MAXSTAGE then
            inst:SetMaxMinimapStatus()
            TheWorld:PushEvent("ms_shadowrift_maxsize", inst)
        end
    else
        inst.AnimState:PlayAnimation("stage_"..inst._stage.."_loop", true)
    end
end

local function ClosePortal(inst)
    inst._closing = true

    if inst:IsAsleep() then
        inst:Remove()
    else
        inst.AnimState:PlayAnimation("disappear")
        inst.SoundEmitter:PlaySound("rifts/portal/portal_disappear")

        local time = inst.AnimState:GetCurrentAnimationLength() - inst.AnimState:GetCurrentAnimationTime() + FRAMES
        inst.components.timer:StartTimer("be_removed", time)
    end
end

--------------------------------------------------------------------------------

local function OnTimerDone(inst, data)
    if data.name == "trynextstage" then
        inst:TryStageUp()
    elseif data.name == "be_removed" then
        inst:Remove()
    elseif data.name == "close" then
        ClosePortal(inst)
    elseif data.name == "initialize" then
        Initialize(inst)
    end
end

--------------------------------------------------------------------------------

local function OnPortalSleep(inst)
    inst.SoundEmitter:KillSound(AMBIENT_SOUND_LOOP_NAME)
end

local function OnPortalWake(inst)
    inst.SoundEmitter:PlaySound(AMBIENT_SOUND_PATH, AMBIENT_SOUND_LOOP_NAME)
    inst.SoundEmitter:SetParameter(AMBIENT_SOUND_LOOP_NAME, AMBIENT_SOUND_PARAM_NAME, AMBIENT_SOUND_STAGE_TO_INTENSITY[inst._stage])
end

--------------------------------------------------------------------------------

local function OnPortalSave(inst, data)
    data.stage = inst._stage

    data.finished = inst.components.timer:TimerExists("be_removed")
end

local function OnPortalLoad(inst, data)
    if data then
        inst._stage = data.stage or inst._stage
        if inst._stage >= TUNING.RIFT_SHADOW1_MAXSTAGE then
            inst.components.timer:StopTimer("trynextstage")
        end

        inst.Physics:SetCylinder(PHYSICS_SIZE_BY_STAGE[inst._stage], 6)

        if data.finished then
            inst.AnimState:PlayAnimation("disappear")
            inst.components.timer:StartTimer("be_removed", 5)
        else
            inst.AnimState:PlayAnimation("stage_"..inst._stage.."_loop", true)
        end
    end
end

local function OnPortalLoadPostPass(inst, newents, data)
    inst.components.timer:StopTimer("initialize")

    inst.SoundEmitter:KillSound(AMBIENT_SOUND_LOOP_NAME)

    if not inst:IsAsleep() then
        inst.SoundEmitter:PlaySound(AMBIENT_SOUND_PATH, AMBIENT_SOUND_LOOP_NAME)
        inst.SoundEmitter:SetParameter(AMBIENT_SOUND_LOOP_NAME, AMBIENT_SOUND_PARAM_NAME, AMBIENT_SOUND_STAGE_TO_INTENSITY[inst._stage])
    end

    if inst._stage == TUNING.RIFT_SHADOW1_MAXSTAGE then
        inst:SetMaxMinimapStatus()
        TheWorld:PushEvent("ms_shadowrift_maxsize", inst)
    end
end

local function OnPortalLongUpdate(inst, dt)
    if inst._stage + 1 >= TUNING.RIFT_SHADOW1_MAXSTAGE then
        return
    end

    local timer = inst.components.timer

    local trynextstage_timeleft = timer:GetTimeLeft("trynextstage")
    
    if trynextstage_timeleft ~= nil then
        local stageup_time = GetStageUpTime()

        if dt >= stageup_time then
            inst:TryStageUp()

            timer:SetTimeLeft("trynextstage", trynextstage_timeleft + stageup_time)
        end
    end
end

--------------------------------------------------------------------------------

local function portalfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, PHYSICS_SIZE_BY_STAGE[1])
    inst.Physics:SetCylinder(PHYSICS_SIZE_BY_STAGE[1], 6)

    inst.MiniMapEntity:SetIcon("dimensional_rift.png")
    inst.MiniMapEntity:SetPriority(1)

    inst.AnimState:SetBank ("dimensional_rift")
    inst.AnimState:SetBuild("dimensional_rift")
    inst.AnimState:PlayAnimation("stage_1_pre")
    inst.AnimState:PushAnimation("stage_1_loop", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGroundFixed)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(2)

    inst:SetDeployExtraSpacing(5)

    inst.AnimState:SetSymbolLightOverride("fx_beam",   1)
    inst.AnimState:SetSymbolLightOverride("fx_spiral", 1)
    inst.AnimState:SetLightOverride(0.5)

    inst:AddTag("birdblocker")
    inst:AddTag("ignorewalkableplatforms")
    inst:AddTag("notarget")
    inst:AddTag("scarytoprey")
    inst:AddTag("dimensional_rift")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst._stage = 1

    inst:AddComponent("inspectable")

    local timer = inst:AddComponent("timer")
    timer:StartTimer("initialize", 0)
    timer:StartTimer("close", TUNING.RIFT_SHADOW1_CLOSE_TIME)
    timer:StartTimer("trynextstage", GetStageUpTime())

    inst:ListenForEvent("timerdone", OnTimerDone)

    inst.OnEntitySleep = OnPortalSleep
    inst.OnEntityWake = OnPortalWake
    inst.OnSave = OnPortalSave
    inst.OnLoad = OnPortalLoad
    inst.OnLoadPostPass = OnPortalLoadPostPass
    inst.OnLongUpdate = OnPortalLongUpdate

    inst.TryStageUp = TryStageUp

    inst.SetMaxMinimapStatus = SetMaxMinimapStatus

    return inst
end

local rift_portal_defs = require("prefabs/rift_portal_defs")
local RIFTPORTAL_FNS = rift_portal_defs.RIFTPORTAL_FNS
local RIFTPORTAL_CONST = rift_portal_defs.RIFTPORTAL_CONST

RIFTPORTAL_FNS.CreateRiftPortalDefinition("dimensional_rift", {
    CustomAllowTest = function(_map, x, y, z)
        return true
    end,
    Affinity = RIFTPORTAL_CONST.AFFINITY.NONE,
})

return Prefab("dimensional_rift",    portalfn,   assets, prefabs)

