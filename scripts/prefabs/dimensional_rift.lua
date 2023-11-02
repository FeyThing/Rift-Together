local assets =
{
    Asset("ANIM", "anim/dimensional_rift.zip"),
}

local prefabs = {
    "dimensional_rift_fx",
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
    return TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].TIME + TUNING.DIMENSIONAL_RIFTS.TIME_VARIANCE * math.random()
end

local function Initialize(inst)
	inst:SpawnStageFx()

    inst.SoundEmitter:PlaySound("rifts2/shadow_rift/groundcrack_expand")

    local duration, speed, scale, max_dist = unpack(TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].SHAKECAMERA)
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

        inst.Physics:SetCylinder(TUNING.DIMENSIONAL_RIFTS.STAGES[next_stage].PHYSICS, 6)

        local duration, speed, scale, max_dist = unpack(TUNING.DIMENSIONAL_RIFTS.STAGES[next_stage].SHAKECAMERA)
        ShakeAllCameras(CAMERASHAKE.FULL, duration, speed, scale, inst, max_dist)

        inst.AnimState:PlayAnimation("stage_"..next_stage.."_pre")
        inst.AnimState:PushAnimation("stage_"..next_stage.."_loop", true)

        inst.SoundEmitter:SetParameter("shadowrift_portal_ambience", "stage", TUNING.DIMENSIONAL_RIFTS.STAGES[next_stage].AMBIENT_INTENSITY)
        inst.SoundEmitter:PlaySound("rifts2/shadow_rift/groundcrack_expand")

        if next_stage < TUNING.RIFT_SHADOW1_MAXSTAGE then
            if not inst.components.timer:TimerExists("trynextstage") then
                inst.components.timer:StartTimer("trynextstage", GetStageUpTime(inst))
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

local function cleanup_outofscope_loot(inst)
    for i = #inst._loot, 1, -1 do
        local loot = inst._loot[i]
        if loot == nil or not loot:IsValid()
                or loot:IsInLimbo()
                or not inst:IsNear(loot, TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].MAXLOOT) then
            table.remove(inst._loot, i)
        end
    end
end

local function fling_portal_loot(inst, loot_to_drop)
    local portal_pos = inst:GetPosition()
    local fling_pos = portal_pos

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

local function reset_attach_target_after_light(inst)
    inst.AnimState:SetLightOverride(0)
    inst:RemoveTag("outofreach")
end

local function attach_light_fx(attach_target)
    local spawn_fx = SpawnPrefab("monkeyisland_portal_lootfollowfx")
    spawn_fx.Transform:SetPosition(0, 0, 0)
    attach_target:AddChild(spawn_fx)
    if spawn_fx.fx_len then
        attach_target:AddTag("outofreach")
        attach_target.AnimState:SetLightOverride(0.6)
        attach_target:DoTaskInTime(spawn_fx.fx_len, reset_attach_target_after_light)
    end
end

local function SpawnLoot(inst, isfxonly)
    local loot_to_drop
    if not isfxonly then
        local loot_to_test = {}
        for loot_prefab_to_test, chance in pairs(TUNING.DIMENSIONAL_RIFTS.LOOT_PREFABS) do
            loot_to_test[loot_prefab_to_test] = (type(chance) == "string" and TUNING[chance]) or chance
        end
        local loot_prefab = weighted_random_choice(loot_to_test)

        loot_to_drop = SpawnPrefab(loot_prefab)
        if loot_to_drop == nil then
            return nil
        end

        table.insert(inst._loot, loot_to_drop)

        fling_portal_loot(inst, loot_to_drop)
    else
        loot_to_drop = SpawnPrefab("monkeyisland_portal_fxloot")

        inst.components.lootdropper:FlingItem(loot_to_drop, inst:GetPosition())
    end
    if loot_to_drop then
        inst.SoundEmitter:PlaySound("monkeyisland/portal/spit_item")
        attach_light_fx(loot_to_drop)
    end
    return loot_to_drop
end

local function try_portal_spawn(inst)
    cleanup_outofscope_loot(inst)

    SpawnLoot(inst, #inst._loot < TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].MAXLOOT)
end

local function on_cycles_changed(inst, cycles)
    if not inst.components.timer:TimerExists("startportalevent") then
        inst.components.timer:StartTimer("startportalevent", TUNING.TOTAL_DAY_TIME / 2)
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

local function fire_portal_event(inst)
    local portal_event_spawns = {
        "nanotech",
        "nanotech",
        "petals",
        "trinket_4",
        "moonrocknugget",
        "hound_robomutt",
        "hound_robomutt",
        "wetgoop",
        "wetgoop",
        "twigs",
        "twigs",
    }
    shuffleArray(portal_event_spawns)

    local i = 1
    while i <= #portal_event_spawns do
        inst:DoTaskInTime(10*(i+1)*FRAMES, spawn_event_loot, portal_event_spawns[i])
        i = i + 1
    end
end

local function start_portal_event(inst)
    if inst.components.timer:TimerExists("startportalevent") then
        inst.components.timer:StopTimer("startportalevent")
    end

    inst.SoundEmitter:PlaySound("monkeyisland/portal/buildup_burst")
    inst.components.timer:StartTimer("fireportalevent", 3)
end

local function OnTimerDone(inst, data)
    if data.name == "spawnportalloot_tick" then
        try_portal_spawn(inst)
        inst.components.timer:StartTimer("spawnportalloot_tick", TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].LOOTSPAWNTIME)
    elseif data.name == "startportalevent" then
        start_portal_event(inst)
    elseif data.name == "fireportalevent" then
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

local function CreateParticleFx(inst)
    local fx = SpawnPrefab("dimensional_rift_fx")
    inst:AddChild(fx)

    return fx
end

local function OnPortalSleep(inst)
    inst.SoundEmitter:KillSound("shadowrift_portal_ambience")

	if inst._fx then
        inst._fx:Remove()
        inst._fx = nil
        inst.highlightchildren = nil
    end

    inst.components.timer:PauseTimer("spawnportalloot_tick")
end

local function OnPortalWake(inst)
    inst.components.timer:ResumeTimer("spawnportalloot_tick")
    inst.SoundEmitter:PlaySound("rifts2/shadow_rift/shadowrift_portal_allstage", "shadowrift_portal_ambience")
    inst.SoundEmitter:SetParameter("shadowrift_portal_ambience", "stage",TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].AMBIENT_INTENSITY)
	
	if not inst._fx then
        inst._fx = CreateParticleFx(inst)
        inst._fx:PlayStage(inst._stage, true)
        inst.highlightchildren = {inst._fx}
    end
end

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

        inst.Physics:SetCylinder(TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].PHYSICS, 6)

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

    inst.SoundEmitter:KillSound("shadowrift_portal_ambience")

    if not inst:IsAsleep() then
        inst.SoundEmitter:PlaySound("rifts2/shadow_rift/shadowrift_portal_allstage", "shadowrift_portal_ambience")
        inst.SoundEmitter:SetParameter("shadowrift_portal_ambience", "stage", TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].AMBIENT_INTENSITY)
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
        local stageup_time = GetStageUpTime(inst)

        if dt >= stageup_time then
            inst:TryStageUp()

            timer:SetTimeLeft("trynextstage", trynextstage_timeleft + stageup_time)
        end
    end
end

local function portalfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, TUNING.DIMENSIONAL_RIFTS.STAGES[1].PHYSICS)
    inst.Physics:SetCylinder(TUNING.DIMENSIONAL_RIFTS.STAGES[1].PHYSICS, 6)

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

    inst.entity:SetPristine()
	
	inst._fx = CreateParticleFx(inst)
    inst.highlightchildren = {inst._fx}    
    inst.highlightoverride = {0.15, 0, 0}

    if not TheWorld.ismastersim then
        return inst
    end

    inst._stage = 1

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    inst:AddComponent("timer")
    inst.components.timer:StartTimer("initialize", 0)
    inst.components.timer:StartTimer("close", TUNING.RIFT_SHADOW1_CLOSE_TIME)
    inst.components.timer:StartTimer("trynextstage", GetStageUpTime(inst))
    inst.components.timer:StartTimer("spawnportalloot_tick", TUNING.DIMENSIONAL_RIFTS.STAGES[inst._stage].LOOTSPAWNTIME)

    inst:WatchWorldState("cycles", on_cycles_changed)

    inst:ListenForEvent("timerdone", OnTimerDone)

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

local function portalfxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("shadowrift_portal")
    inst.AnimState:SetBuild("dimensional_rift")
    inst.AnimState:PlayAnimation("particle_1_pre")
    inst.AnimState:PushAnimation("particle_1_loop", true)

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

return Prefab("dimensional_rift",    portalfn,   assets, prefabs),
	   Prefab("dimensional_rift_fx", portalfxfn, assets, prefabs)


