local assets =
{
    Asset("ANIM", "anim/dimensional_rift.zip"),
}

local prefabs = {
"dimensional_rift_fx",
}

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

local function SpawnStageFx(inst)
    local scale = inst._stage * 0.5

    local fx = SpawnPrefab("statue_transition")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx.Transform:SetScale(scale, scale, scale)

    return fx
end

local function GetStageUpTime(inst)
    return 900 + TUNING.RIFT_SHADOW1_STAGEUP_RANDOM_TIME * math.random()
end

local function Initialize(inst)

	inst:SpawnStageFx()

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
		
		if inst._fx then
            inst._fx:PlayStage(next_stage)
        end

        inst:SpawnStageFx()

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
		
		if inst._fx then
            inst._fx:Disappear()
        end

        local time = inst.AnimState:GetCurrentAnimationLength() - inst.AnimState:GetCurrentAnimationTime() + FRAMES
        inst.components.timer:StartTimer("be_removed", time)
    end
end

local PORTALLOOT_TIMER_NAME = "spawnportalloot_tick"
local STARTEVENT_TIMER_NAME = "startportalevent"
local FIREEVENT_TIMER_NAME = "fireportalevent"

local FIREEVENT_TIME = 3

-- We weight in some FX loot here as well, for some presentation and
-- to break up the spawn of objects with behaviour.
local PORTAL_LOOT_PREFABS =
{
    cutgrass                            = 5.0,
    dug_bananabush                      = "MONKEYISLAND_PORTAL_BANANABUSHWEIGHT",
    dug_monkeytail                      = "MONKEYISLAND_PORTAL_MONKEYTAILWEIGHT",
	lightcrab                           = "MONKEYISLAND_PORTAL_LIGHTCRABWEIGHT",
    monkeyisland_portal_fxloot          = 10.0,
    palmcone_seed                       = "MONKEYISLAND_PORTAL_PALMCONE_SEEDWEIGHT",
    powder_monkey                       = "MONKEYISLAND_PORTAL_POWDERMONKEYWEIGHT",
    rocks                               = 5.0,
    twigs                               = 5.0,
}

local PORTAL_LOOT_FXYOFFSET =
{
    cutgrass        = 0.25,
    dug_bananabush  = 0.40,
    dug_monkeytail  = 0.40,
    lightcrab       = 0.25,
    palmcone_seed   = 0.25,
    powder_monkey   = 1.80,
    rocks           = 0.25,
    twigs           = 0.25,
}

local LOOT_LIGHT_OVERRIDE_AMOUNT = 0.6

--------------------------------------------------------------------------------
-- Follow FX --
--------------------------------------------------------------------------------
local function follow_fx_finish(fx)
    fx.AnimState:PlayAnimation("idle_pst")
    fx:ListenForEvent("animover", fx.Remove)
end

local function followfx_fn()
    local inst = CreateEntity("MonkeyIslandPortalLoot.SpawnFollowFX")

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOBLOCK")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("monkey_island_portal_fx")
    inst.AnimState:SetBuild("monkey_island_portal_fx")
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst.AnimState:SetFinalOffset(1)
    inst.AnimState:SetScale(0.65, 0.65)
    inst.AnimState:SetMultColour(1, 1, 1, 0.4)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(LOOT_LIGHT_OVERRIDE_AMOUNT)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst.fx_len = inst.AnimState:GetCurrentAnimationLength()
    inst:DoTaskInTime(inst.fx_len, follow_fx_finish)

    return inst
end
--------------------------------------------------------------------------------

local function cleanup_outofscope_loot(inst)
    -- If loot has gone invalid or too far away, remove it.
    for i = #inst._loot, 1, -1 do
        local loot = inst._loot[i]
        if loot == nil or not loot:IsValid()
                or loot:IsInLimbo()
                or not inst:IsNear(loot, TUNING.MONKEYISLAND_PORTAL_LOOTMAXDST) then
            table.remove(inst._loot, i)
        end
    end
end

local VERTICAL_FLING_OFFSET = Vector3(0, 0, 0)
local function fling_portal_loot(inst, loot_to_drop)
    local portal_pos = inst:GetPosition()
    local fling_pos = portal_pos + VERTICAL_FLING_OFFSET

    if loot_to_drop.components.embarker == nil then
        inst.SoundEmitter:PlaySound("monkeyisland/portal/spit_item")
        inst.components.lootdropper:FlingItem(loot_to_drop, fling_pos)
		if loot_to_drop.sg ~= nil then
			loot_to_drop.sg:GoToState("portal_spawn")
		end
    else
        loot_to_drop.Transform:SetPosition(fling_pos:Get())

        local hopout_offset = FindWalkableOffset(portal_pos, 2*PI*math.random(), 3, nil, true, false)
        if hopout_offset then
            portal_pos = portal_pos + hopout_offset
        end

        loot_to_drop.components.locomotor:StartHopping(portal_pos.x, portal_pos.z)
    end
end

local function spawn_real_loot(inst)
    -- Rebuild the table here each time in case the tuning variables change.
    local loot_to_test = {}
    for loot_prefab_to_test, chance in pairs(PORTAL_LOOT_PREFABS) do
        loot_to_test[loot_prefab_to_test] = (type(chance) == "string" and TUNING[chance]) or chance
    end
    local loot_prefab = weighted_random_choice(loot_to_test)

    local loot_to_drop = SpawnPrefab(loot_prefab)
    if loot_to_drop == nil then
        return nil
    end

    table.insert(inst._loot, loot_to_drop)

    fling_portal_loot(inst, loot_to_drop)

    return loot_to_drop
end

local function spawn_fx_loot(inst)
    local loot_fx = SpawnPrefab("monkeyisland_portal_fxloot")

    inst.components.lootdropper:FlingItem(loot_fx, inst:GetPosition() + VERTICAL_FLING_OFFSET)

    return loot_fx
end

local function reset_attach_target_after_light(inst)
    inst.AnimState:SetLightOverride(0)
    inst:RemoveTag("outofreach")
end

local function attach_light_fx(attach_target)
    local spawn_fx = SpawnPrefab("monkeyisland_portal_lootfollowfx")
    spawn_fx.Transform:SetPosition(0, PORTAL_LOOT_FXYOFFSET[attach_target.prefab] or 0, 0)
    attach_target:AddChild(spawn_fx)
    if spawn_fx.fx_len then
        attach_target:AddTag("outofreach")
        attach_target.AnimState:SetLightOverride(LOOT_LIGHT_OVERRIDE_AMOUNT)
        attach_target:DoTaskInTime(spawn_fx.fx_len, reset_attach_target_after_light)
    end
end

local function try_portal_spawn(inst)
    cleanup_outofscope_loot(inst)

    local loot_to_drop = (#inst._loot < TUNING.MONKEYISLAND_PORTAL_MAXLOOT and spawn_real_loot(inst))
        or spawn_fx_loot(inst)

    if loot_to_drop ~= nil then
        inst.SoundEmitter:PlaySound("monkeyisland/portal/spit_item")
        attach_light_fx(loot_to_drop)
    end
end

--------------------------------------------------------------------------------

local function on_cycles_changed(inst, cycles)
    if TUNING.MONKEYISLAND_PORTAL_ENABLED and
            not inst.components.timer:TimerExists(STARTEVENT_TIMER_NAME) then
        inst.components.timer:StartTimer(STARTEVENT_TIMER_NAME, TUNING.TOTAL_DAY_TIME / 2)
    end
end

local function spawn_event_loot(inst, loot_prefab)
    local loot = SpawnPrefab(loot_prefab)

    if loot ~= nil then
        fling_portal_loot(inst, loot)

        inst.SoundEmitter:PlaySound("monkeyisland/portal/spit_item")
        attach_light_fx(loot)
    end
end

local function enable_trading(inst)
    inst._event_is_busy = false
end

local function fire_portal_event(inst)
    local portal_event_spawns = {
        "cutgrass",
        "cutgrass",
        "dug_bananabush",
        "dug_monkeytail",
        "palmcone_seed",
        "palmcone_seed",
        "powder_monkey",
        "rocks",
        "rocks",
        "twigs",
        "twigs",
    }
    shuffleArray(portal_event_spawns)

    -- Being explicit that we want to reference i after the loop, so we can
    -- identify when all of the event objects have finished spawning.
    local i = 1
    while i <= #portal_event_spawns do
        inst:DoTaskInTime(10*(i+1)*FRAMES, spawn_event_loot, portal_event_spawns[i])
        i = i + 1
    end

    inst:DoTaskInTime(10*(i+2)*FRAMES, enable_trading)
end

local function start_portal_event(inst)
    if not TUNING.MONKEYISLAND_PORTAL_ENABLED then
        return
    end

    local do_event = false
    local px, py, pz = inst.Transform:GetWorldPosition()
    for _, player in ipairs(AllPlayers) do
        if player:GetDistanceSqToPoint(px, py, pz) < 400 then
            do_event = true
            break
        end
    end
    if not do_event then
        return
    end

    inst._event_is_busy = true

    -- If the event was triggered in a non-timer way, clear the timer
    -- so we don't do it again until the next day.
    if inst.components.timer:TimerExists(STARTEVENT_TIMER_NAME) then
        inst.components.timer:StopTimer(STARTEVENT_TIMER_NAME)
    end

    inst.SoundEmitter:PlaySound("monkeyisland/portal/buildup_burst")
    inst.components.timer:StartTimer(FIREEVENT_TIMER_NAME, FIREEVENT_TIME)
end

--------------------------------------------------------------------------------
local EVENT_TRIGGER_TIME = 3
local function portal_on_near(inst, player)
    -- If we're waiting on an event timer, try to fire it sooner.
    local time_left = inst.components.timer:GetTimeLeft(STARTEVENT_TIMER_NAME)
    if time_left ~= nil and time_left > EVENT_TRIGGER_TIME then
        inst.components.timer:SetTimeLeft(STARTEVENT_TIMER_NAME, EVENT_TRIGGER_TIME)
    end
end

--------------------------------------------------------------------------------
local function able_to_accept_trade_test(inst, item, giver)
    if inst._event_is_busy then
        return false, "BUSY"
    elseif not item:HasTag("moonstorm_spark") then
        return false, "GENERIC"
    else
        return true
    end
end

local function on_accept_item(inst, giver, item)
    start_portal_event(inst)
end

--------------------------------------------------------------------------------

local function OnTimerDone(inst, data)
    if data.name == PORTALLOOT_TIMER_NAME then
        try_portal_spawn(inst)

        -- The portal loot timer is repeating!
        inst.components.timer:StartTimer(PORTALLOOT_TIMER_NAME, TUNING.MONKEYISLAND_PORTAL_SPEWTIME)
    elseif data.name == STARTEVENT_TIMER_NAME then
        start_portal_event(inst)
    elseif data.name == FIREEVENT_TIMER_NAME then
        fire_portal_event(inst)
    elseif data.name == "trynextstage" then
        inst:TryStageUp()
    elseif data.name == "be_removed" then
        inst:Remove()
    elseif data.name == "close" then
        ClosePortal(inst)
    elseif data.name == "initialize" then
        Initialize(inst)
    end
end

----------------------------------------------------------------------------------

local function CreateParticleFx(inst)
    local fx = SpawnPrefab("dimensional_rift_fx")
    inst:AddChild(fx)

    return fx
end

local function ParticlePlayStage(inst, stage, load)
    if load then
        inst.AnimState:PlayAnimation("particle_"..stage.."_loop", true)
    else
        inst.AnimState:PlayAnimation("particle_"..stage.."_pre")
        inst.AnimState:PushAnimation("particle_"..stage.."_loop", true)
    end
end

local function ParticleDisappear(inst)
    inst.AnimState:PlayAnimation("particle_disappear")
end

--------------------------------------------------------------------------------

local function OnPortalSleep(inst)
    inst.SoundEmitter:KillSound(AMBIENT_SOUND_LOOP_NAME)
<<<<<<< HEAD
	if inst._fx then
        inst._fx:Remove()
        inst._fx = nil
        inst.highlightchildren = nil
    end
=======
    inst.components.timer:PauseTimer(PORTALLOOT_TIMER_NAME)
>>>>>>> 73b9a6c99457d3b209fb7a6b4fd735b707e4b5f0
end

local function OnPortalWake(inst)
    inst.components.timer:ResumeTimer(PORTALLOOT_TIMER_NAME)
    inst.SoundEmitter:PlaySound(AMBIENT_SOUND_PATH, AMBIENT_SOUND_LOOP_NAME)
    inst.SoundEmitter:SetParameter(AMBIENT_SOUND_LOOP_NAME, AMBIENT_SOUND_PARAM_NAME, AMBIENT_SOUND_STAGE_TO_INTENSITY[inst._stage])
	
	if not inst._fx then
        inst._fx = CreateParticleFx(inst)
        inst._fx:PlayStage(inst._stage, true)
        inst.highlightchildren = {inst._fx}
    end
end

--------------------------------------------------------------------------------

local function OnPortalSave(inst, data)
    data.stage = inst._stage

    if inst._loot ~= nil and #inst._loot > 0 then
		local loot = {}
        for _, loot_item in ipairs(inst._loot) do
			if loot_item.persists and loot_item:IsValid() then
				table.insert(loot, loot_item.GUID)
			end
        end
		if #loot > 0 then
			data.loot = loot
			return loot
		end
    end

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
			if inst._fx then
                inst._fx:Disappear()
            end
        else
            inst.AnimState:PlayAnimation("stage_"..inst._stage.."_loop", true)
			if inst._fx then
                inst._fx:PlayStage(inst._stage, true)
            end
        end
    end
end

local function OnPortalLoadPostPass(inst, newents, data)
    if data ~= nil and data.loot ~= nil then
        for _, loot_guid in ipairs(data.loot) do
            if newents[loot_guid] ~= nil and newents[loot_guid].entity ~= nil then
                table.insert(inst._loot, newents[loot_guid].entity)
            end
        end
    end

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
    inst.entity:AddLight()
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
    inst.AnimState:SetMultColour(.8,.8,.8,1)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst:SetDeployExtraSpacing(5)

    inst.AnimState:SetSymbolLightOverride("fx_beam",   1)
    inst.AnimState:SetSymbolLightOverride("fx_spiral", 1)
    inst.AnimState:SetLightOverride(0.5)

    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(3)
    inst.Light:SetFalloff(.8)
    inst.Light:SetColour(25/255, 255/255, 100/255)
    inst.Light:Enable(true)

    inst:AddTag("birdblocker")
    inst:AddTag("ignorewalkableplatforms")
    inst:AddTag("notarget")
    inst:AddTag("scarytoprey")
    inst:AddTag("dimensional_rift")

    inst._loot = {}
    inst._event_is_busy = false

    inst.entity:SetPristine()
	
	inst._fx = CreateParticleFx(inst)
    inst.highlightchildren = {inst._fx}    
    inst.highlightoverride = {0.15, 0, 0}

    if not TheWorld.ismastersim then
        return inst
    end

    inst._stage = 1

    inst:AddComponent("inspectable")

    ----------------------------------------------------------
    inst:AddComponent("lootdropper")
    inst.components.lootdropper.min_speed = 4
    inst.components.lootdropper.max_speed = 6
    inst.components.lootdropper.y_speed_variance = 2
    ----------------------------------------------------------
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(10, 15)
    inst.components.playerprox:SetOnPlayerNear(portal_on_near)

    inst:AddComponent("timer")
    inst.components.timer:StartTimer("initialize", 0)
    inst.components.timer:StartTimer("close", TUNING.RIFT_SHADOW1_CLOSE_TIME)
    inst.components.timer:StartTimer("trynextstage", GetStageUpTime())
    inst.components.timer:StartTimer(PORTALLOOT_TIMER_NAME, TUNING.MONKEYISLAND_PORTAL_SPEWTIME)

    inst:WatchWorldState("cycles", on_cycles_changed)

    inst:ListenForEvent("timerdone", OnTimerDone)

	inst.Test = try_portal_spawn
    inst._TestPortalEvent = start_portal_event

    inst.OnEntitySleep = OnPortalSleep
    inst.OnEntityWake = OnPortalWake
    inst.OnSave = OnPortalSave
    inst.OnLoad = OnPortalLoad
    inst.OnLoadPostPass = OnPortalLoadPostPass
    inst.OnLongUpdate = OnPortalLongUpdate

    inst.TryStageUp = TryStageUp

	inst.SpawnStageFx = SpawnStageFx
    inst.SetMaxMinimapStatus = SetMaxMinimapStatus

    return inst
end

<<<<<<< HEAD
local function portalfxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    local animstate = inst.AnimState
    animstate:SetBank("dimensional_rift")
    animstate:SetBuild("dimensional_rift")
    animstate:PlayAnimation("particle_1_pre")
    animstate:PushAnimation("particle_1_loop", true)

    inst.AnimState:SetLightOverride(1)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:AddTag("NOBLOCK")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst.PlayStage = ParticlePlayStage
    inst.Disappear = ParticleDisappear

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

return Prefab("dimensional_rift",    portalfn,   assets, prefabs),
	   Prefab("dimensional_rift_fx", portalfxfn, assets, prefabs)
=======
return Prefab("dimensional_rift", portalfn, assets, prefabs)
>>>>>>> 73b9a6c99457d3b209fb7a6b4fd735b707e4b5f0

