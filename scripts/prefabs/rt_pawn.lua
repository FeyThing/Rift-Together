local clockwork_common = require "prefabs/clockwork_common"
local RuinsRespawner = require "prefabs/ruinsrespawner"

local assets =
{
    Asset("ANIM", "anim/rt_pawn.zip"),
    Asset("ANIM", "anim/rt_pawn_nightmare.zip"),
    Asset("SOUND", "sound/chess.fsb"),
    Asset("SCRIPT", "scripts/prefabs/clockwork_common.lua"),
    Asset("SCRIPT", "scripts/prefabs/ruinsrespawner.lua"),
}

local prefabs =
{
    "gears",
}

local prefabs_nightmare =
{
    "gears",
    "thulecite_pieces",
    "nightmarefuel",
    "rt_pawn_nightmare_ruinsrespawner_inst",
}

local brain = require "brains/rt_pawnbrain"

SetSharedLootTable("rt_pawn",
{
    {"gears",  0.2},
})

SetSharedLootTable("rt_pawn_nightmare",
{
    {"gears",             0.1},
    {"nightmarefuel",     0.5},
    {"thulecite_pieces",  0.2},
})

local EXPLODE_RANGE = 3.0
local EXPLODE_HIT_MUST_TAGS = {"_combat"}
local EXPLODE_HIT_CANT_TAGS = {"DECOR", "INLIMBO", "NOCLICK", "FX", "playerghost", "durasteel_plating"}
local function do_explosion_effect(inst, ix, iy, iz)
    if not ix then
        ix, iy, iz = inst.Transform:GetWorldPosition()
    end
    SpawnPrefab("explode_small").Transform:SetPosition(ix, iy, iz)

    local exploded_entities = TheSim:FindEntities(ix, iy, iz, EXPLODE_RANGE, EXPLODE_HIT_MUST_TAGS, EXPLODE_HIT_CANT_TAGS)
    for _, exploded_entity in ipairs(exploded_entities) do
        exploded_entity.components.combat:GetAttacked(inst, TUNING.FUSED_SHADELING_BOMB_EXPLOSION_DAMAGE, nil, nil, {planar = TUNING.FUSED_SHADELING_BOMB_EXPLOSION_PLANARDAMAGE})
    end
    SpawnPrefab("fused_shadeling_bomb_scorch").Transform:SetPosition(ix, iy, iz)
end

local function ShouldSleep(inst)
    return clockwork_common.ShouldSleep(inst)
end

local function ShouldWake(inst)
    return clockwork_common.ShouldWake(inst)
end

local function Retarget(inst)
    return clockwork_common.Retarget(inst, TUNING.RT_PAWN_TARGET_DIST)
end

local function KeepTarget(inst, target)
    return clockwork_common.KeepTarget(inst, target)
end

local function OnAttacked(inst, data)
    clockwork_common.OnAttacked(inst, data)
end

local function SetHomePosition(inst)
    inst.components.knownlocations:RememberLocation("home", inst:GetPosition())
end

local function do_quick_explode(inst)
    do_explosion_effect(inst)

    inst:Remove()
end

local function fn_common(build, tag)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddLight()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 50, .5)

    inst.DynamicShadow:SetSize(1.5, .75)
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("rt_pawn")
    inst.AnimState:SetBuild(build)
	

	
	inst.Light:SetColour(.65, .65, .5) 
    --inst.Light:Enable(true)

    inst:AddTag("chess")
    inst:AddTag("hostile")
    inst:AddTag("pawn")
    inst:AddTag("monster")
	inst:AddTag("soulless")
	inst:AddTag("noradiation")

    if tag ~= nil then
        inst:AddTag(tag)
    end

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    --inst.kind = ""

	inst:AddComponent("armoredbody")

    --
    local combat = inst:AddComponent("combat")
    combat.hiteffectsymbol = "body"
    combat:SetAttackPeriod(TUNING.KNIGHT_ATTACK_PERIOD)
    combat:SetDefaultDamage(TUNING.KNIGHT_DAMAGE)
    combat:SetRetargetFunction(3, Retarget)
    combat:SetKeepTargetFunction(KeepTarget)

    --
    inst:AddComponent("follower")

    --
    local health = inst:AddComponent("health")
    health:SetMaxHealth(TUNING.RT_PAWN_HEALTH)

    --
    inst:AddComponent("inspectable")

    --
    inst:AddComponent("knownlocations")
	--[[inst:AddComponent("groundpounder")
	inst.components.groundpounder:UseRingMode()
	inst.components.groundpounder.damageRings = 1
	--inst.components.groundpounder.destructionRings = 1
	inst.components.groundpounder.platformPushingRings = 1
    inst.components.groundpounder.numRings = 1
	inst.components.groundpounder.radiusStepDistance = 1
	inst.components.groundpounder.ringWidth = 1.5]]
    inst:AddComponent("timer")

    --
    local locomotor = inst:AddComponent("locomotor")
    locomotor.walkspeed = TUNING.KNIGHT_WALK_SPEED

    --
    inst:AddComponent("lootdropper")

    --
    local sleeper = inst:AddComponent("sleeper")
    sleeper:SetWakeTest(ShouldWake)
    sleeper:SetSleepTest(ShouldSleep)
    sleeper:SetResistance(3)

    --
    MakeMediumBurnableCharacter(inst, "body")
    MakeMediumFreezableCharacter(inst, "body")

    --
    MakeHauntablePanic(inst)

    --
    inst:SetStateGraph("SGrt_pawn")
    inst:SetBrain(brain)

    --
    inst:DoTaskInTime(0, SetHomePosition)

    --
    inst:ListenForEvent("attacked", OnAttacked)

    return inst
end

local function fn()
    local inst = fn_common("rt_pawn")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.kind = ""
    inst.components.lootdropper:SetChanceLootTable("rt_pawn")

    return inst
end

local QUICKFUSE_TIME = 0 
local function nightmarefn()
    local inst = fn_common("rt_pawn_nightmare", "cavedweller")
	

	inst.Light:SetColour(.65, .5, .65) 

    inst:AddTag("shadow_aligned")
	inst:AddTag("explosive")

    if not TheWorld.ismastersim then
        return inst
    end
	
    --
    local acidinfusible = inst:AddComponent("acidinfusible")
    acidinfusible:SetFXLevel(2)
    acidinfusible:SetMultipliers(TUNING.ACID_INFUSION_MULT.WEAKER)

    --
    inst.kind = "_nightmare"
    inst.components.lootdropper:SetChanceLootTable("rt_pawn_nightmare")
	
	
	-- pawn go boom on death
	
	inst:ListenForEvent("death", function(inst)
       -- local x,y,z = inst.Transform:GetWorldPosition()
		--local explode = SpawnPrefab("explode_small")
		--explode.Transform:SetPosition(x, 0, z)
		inst:DoTaskInTime(QUICKFUSE_TIME, do_quick_explode)
    end)
	

    return inst
end

local function onruinsrespawn(inst, respawner)
	if not respawner:IsAsleep() then
		inst.sg:GoToState("ruinsrespawn")
	end
end

return Prefab("rt_pawn", fn, assets, prefabs),
    Prefab("rt_pawn_nightmare", nightmarefn, assets, prefabs_nightmare),
    RuinsRespawner.Inst("rt_pawn_nightmare", onruinsrespawn), RuinsRespawner.WorldGen("rt_pawn_nightmare", onruinsrespawn)
