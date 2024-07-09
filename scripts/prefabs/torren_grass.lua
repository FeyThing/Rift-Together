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
    "torren_grasspartfx",
}



local function dig_up(inst, worker)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()
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


local function ontransplantfn(inst)
    inst.components.pickable:MakeBarren()
end

local function OnSave(inst, data)
    data.was_herd = inst.components.herdmember and true or nil
end

local function OnPreLoad(inst, data)
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