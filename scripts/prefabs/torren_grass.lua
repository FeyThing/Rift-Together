require("worldsettingsutil")

local assets =
{
    Asset("ANIM", "anim/torren_grass.zip"),
    Asset("SOUND", "sound/common.fsb"),
}

local torren_grasspart_assets =
{
    Asset("ANIM", "anim/torren_grass.zip"),
  
}

local prefabs =
{
    "cutgrass",
    "dug_grass",
    "grassgekko",
    "torren_grasspartfx",
}

local function canmorph(inst)
    return inst.AnimState:IsCurrentAnimation("idle")
end

local TRIGGERMORPH_MUST_TAGS = { "renewable" }
local TRIGGERMORPH_CANT_TAGS = { "INLIMBO" }
local function triggernearbymorph(inst, quick, range)
    range = range or 1

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, range, TRIGGERMORPH_MUST_TAGS, TRIGGERMORPH_CANT_TAGS)
    local count = 0

    for i, v in ipairs(ents) do
        if v ~= inst and
            v.prefab == "torren_grass" and
            v.components.worldsettingstimer ~= nil and
            not (v.components.worldsettingstimer:ActiveTimerExists("morphdelay") or
                v.components.worldsettingstimer:ActiveTimerExists("morphing") or
                v.components.worldsettingstimer:ActiveTimerExists("morphrelay")) then

            count = count + 1

            if canmorph(v) and math.random() < 0.75 then
                v.components.worldsettingstimer:StartTimer(
                    "morphing",
                    ((not quick or count > 3) and .75 + math.random() * 1.5) or
                    (.2 + math.random() * .2) * count
                )
            else
                v.components.worldsettingstimer:StartTimer("morphrelay", count * FRAMES)
            end
        end
    end

    if count <= 0 and range < 4 then
        triggernearbymorph(inst, quick, range * 2)
    end
end

local function dig_up(inst, worker)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()

        if not TheWorld.state.iswinter
            and worker ~= nil
            and worker:HasTag("player")
            and math.random() < TUNING.GRASSGEKKO_MORPH_CHANCE then
            triggernearbymorph(inst, true)
        end

        if inst.components.pickable:CanBePicked() then
            inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
        end

        inst.components.lootdropper:SpawnLootPrefab(withered and "cutgrass" or "dug_grass")
    end
    inst:Remove()
end

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle", true)
end

local function makeemptyfn(inst)
    if not POPULATING and
        (   inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered() or
            inst.AnimState:IsCurrentAnimation("idle_dead")
        ) then
        inst.AnimState:PlayAnimation("dead_to_empty")
        inst.AnimState:PushAnimation("picked", false)
    else
        inst.AnimState:PlayAnimation("picked")
    end
end

local function makebarrenfn(inst, wasempty)
    if not POPULATING and
        (   inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered()
        ) then
        inst.AnimState:PlayAnimation(wasempty and "empty_to_dead" or "full_to_dead")
        inst.AnimState:PushAnimation("idle_dead", false)
    else
        inst.AnimState:PlayAnimation("idle_dead")
    end
end

local GRASS_TAGS = {"torrengrass"}

local function onpickedfn(inst, picker)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
    inst.AnimState:PlayAnimation("picking")

    if not TheWorld.state.iswinter
        and picker ~= nil
        and picker:HasTag("player")
        and math.random() < TUNING.GRASSGEKKO_MORPH_CHANCE then
        triggernearbymorph(inst, true)
    end

    if inst.components.pickable:IsBarren() then
        inst.AnimState:PushAnimation("empty_to_dead")
        inst.AnimState:PushAnimation("idle_dead", false)
    else
        inst.AnimState:PushAnimation("picked", false)
    end
	
	local x, y, z = inst.Transform:GetWorldPosition()
	local grass = TheSim:FindEntities(x, y, z, 2, nil, nil, GRASS_TAGS)
	for i, v in ipairs(grass) do
		if v.components.pickable and v.components.pickable:CanBePicked() then
			v.components.pickable:MakeEmpty()
		end
	end
end

local FINDGRASSGEKKO_MUST_TAGS = { "grassgekko" }
local function onmorphtimer(inst, data)
    local morphing = data.name == "morphing"
    if morphing or data.name == "morphrelay" then
        if morphing and canmorph(inst) then
            local x, y, z = inst.Transform:GetWorldPosition()
            if #TheSim:FindEntities(x, y, z, TUNING.GRASSGEKKO_DENSITY_RANGE, FINDGRASSGEKKO_MUST_TAGS) < TUNING.GRASSGEKKO_MAX_DENSITY then
                local gekko = SpawnPrefab("grassgekko")
                gekko.Transform:SetPosition(x, y, z)
                gekko.sg:GoToState("emerge")

                local partfx = SpawnPrefab("torren_grasspartfx")
                partfx.Transform:SetPosition(x, y, z)
                partfx.Transform:SetRotation(inst.Transform:GetRotation())
                partfx.AnimState:SetMultColour(inst.AnimState:GetMultColour())

                triggernearbymorph(inst, false)
                inst:Remove()
                return
            end
        end
        inst.components.worldsettingstimer:StartTimer("morphdelay", GetRandomWithVariance(TUNING.GRASSGEKKO_MORPH_DELAY, TUNING.GRASSGEKKO_MORPH_DELAY_VARIANCE))
        triggernearbymorph(inst, false)
    end
end

local function makemorphable(inst)
    if inst.components.worldsettingstimer == nil then
        inst:AddComponent("worldsettingstimer")
        inst.components.worldsettingstimer:AddTimer("morphdelay", TUNING.GRASSGEKKO_MORPH_DELAY, TUNING.GRASSGEKKO_MORPH_ENABLED)
        inst.components.worldsettingstimer:AddTimer("morphing", 1, TUNING.GRASSGEKKO_MORPH_ENABLED)
        inst.components.worldsettingstimer:AddTimer("morphrelay", FRAMES, TUNING.GRASSGEKKO_MORPH_ENABLED)
        inst:ListenForEvent("timerdone", onmorphtimer)
    end
end

local function ontransplantfn(inst)
    inst.components.pickable:MakeBarren()
    makemorphable(inst)
    inst.components.worldsettingstimer:StartTimer("morphdelay", GetRandomWithVariance(TUNING.GRASSGEKKO_MORPH_DELAY, TUNING.GRASSGEKKO_MORPH_DELAY_VARIANCE))
end

local function OnSave(inst, data)
    data.was_herd = inst.components.herdmember and true or nil
end

local function OnPreLoad(inst, data)
    WorldSettings_Timer_PreLoad(inst, data, "morphdelay", TUNING.GRASSGEKKO_MORPH_DELAY + TUNING.GRASSGEKKO_MORPH_DELAY_VARIANCE)
    WorldSettings_Timer_PreLoad_Fix(inst, data, "morphdelay", 1)
    WorldSettings_Timer_PreLoad(inst, data, "morphing")
    WorldSettings_Timer_PreLoad_Fix(inst, data, "morphing", 1)
    WorldSettings_Timer_PreLoad(inst, data, "morphrelay")
    WorldSettings_Timer_PreLoad_Fix(inst, data, "morphrelay", 1)
    if data ~= nil then
        if data.pickable ~= nil and data.pickable.transplanted then
            makemorphable(inst)
        else
            if data.worldsettingstimer ~= nil then
                makemorphable(inst)
            end
        end
    end

    if data and data.was_herd then
        if TheWorld.components.lunarthrall_plantspawner then
            TheWorld.components.lunarthrall_plantspawner:setHerdsOnPlantable(inst)
        end
    end
end

local function torren_grass(name, stage)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        inst.MiniMapEntity:SetIcon("torren_grass.tex")

        inst.AnimState:SetBank("grass")
        inst.AnimState:SetBuild("torren_grass")
        inst.AnimState:PlayAnimation("idle", true)

        inst:AddTag("plant")
        inst:AddTag("renewable")
		inst:AddTag("silviculture") -- for silviculture book
        inst:AddTag("lunarplant_target")
		inst:AddTag("torrengrass")

        --witherable (from witherable component) added to pristine state for optimization
        inst:AddTag("witherable")

        inst.scrapbook_specialinfo = "NEEDFERTILIZER"

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
        local color = 0.75 + math.random() * 0.25
        inst.AnimState:SetMultColour(color, color, color, 1)

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"

        inst.components.pickable:SetUp("cutgrass", TUNING.GRASS_REGROW_TIME)
        inst.components.pickable.onregenfn = onregenfn
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
        inst.components.pickable.makebarrenfn = makebarrenfn
        inst.components.pickable.max_cycles = TUNING.GRASS_CYCLES
        inst.components.pickable.cycles_left = TUNING.GRASS_CYCLES
        inst.components.pickable.ontransplantfn = ontransplantfn

        inst:AddComponent("witherable")

        if stage == 1 then
            inst.components.pickable:MakeBarren()
        end

        inst:AddComponent("lootdropper")
        inst:AddComponent("inspectable")

		if not GetGameModeProperty("disable_transplanting") then
			inst:AddComponent("workable")
			inst.components.workable:SetWorkAction(ACTIONS.DIG)
			inst.components.workable:SetOnFinishCallback(dig_up)
			inst.components.workable:SetWorkLeft(1)
		end
        ---------------------

        MakeMediumBurnable(inst)
        MakeSmallPropagator(inst)
        MakeNoGrowInWinter(inst)
        MakeHauntableIgnite(inst)
        ---------------------

        inst.OnPreLoad = OnPreLoad
        inst.OnSave = OnSave

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local function torren_grasspart_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("grass")
    inst.AnimState:SetBuild("torren_grass")
    inst.AnimState:PlayAnimation("torren_grass_part")
    inst.AnimState:SetFinalOffset(1)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local GRASS_BLOCKER_TAGS = {"antlion_sinkhole_blocker", "birdblocker", "blocker", "_inventoryitem"}
local PLANT_TAGS = {"plant"}

local function customcheckfn(pt)
	return #TheSim:FindEntities(pt.x, pt.y, pt.z, 2, nil, nil, GRASS_BLOCKER_TAGS) == 0 and #TheSim:FindEntities(pt.x, pt.y, pt.z, 0.25, nil, nil, PLANT_TAGS) == 0
		and not TheWorld.Map:IsPointNearHole(pt) and TheWorld.Map:CanPlantAtPoint(pt.x, pt.y, pt.z)
end

local function OnInit(inst)
	local numgrass = math.random(20, 36)
	local pt = inst:GetPosition()
	for i = 1, numgrass do
		local offset = FindWalkableOffset(pt, math.random() * 2 * PI, GetRandomMinMax(0, 8), 12, false, true, customcheckfn)
		if offset ~= nil then
			local prefab = math.random() > 0.02 and "torren_grass" or "rocks"
			local grass = SpawnPrefab(prefab)
			grass.Transform:SetPosition((pt + offset):Get())
		end
	end
	inst:Remove()
end

local function spawner_fn()
    local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddNetwork()
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoTaskInTime(0.1, OnInit)
	
	inst.persists = false

    return inst
end

return torren_grass("torren_grass", 0),
       torren_grass("depleted_torren_grass", 1),
       Prefab("torren_grasspartfx", torren_grasspart_fn, torren_grasspart_assets),
	   Prefab("torren_grass_spawner", spawner_fn)