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
	{"gears",			 0.1},
	{"nightmarefuel",	 0.5},
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

local function OnNewTarget(inst, data)
	inst.components.combat:ShareTarget(data.target, TUNING.RT_PAWN_SEE_CHESS_RANGE, function(dude) return dude:HasTag("chess") end, TUNING.RT_PAWN_MAX_TARGET_SHARES)
	inst.components.combat:BattleCry()
end

local function SetHomePosition(inst)
	inst.components.knownlocations:RememberLocation("home", inst:GetPosition())
end

local function do_quick_explode(inst)
	do_explosion_effect(inst)

	inst:Remove()
end

local function ShouldShockTarget(target)
	if target.components.health ~= nil and target.components.health:IsDead() then
		return false
	end
	
	local insulated = target.components.inventory ~= nil and target.components.inventory:IsInsulated()
	
	if target.components.upgrademoduleowner ~= nil then
		if not target.components.upgrademoduleowner:ChargeIsMaxed() then
			target.components.upgrademoduleowner:AddCharge(1)
		end
		
		if target.components.sanity ~= nil then
			target.components.sanity:DoDelta(-TUNING.SANITY_SMALL)
		end
		
		if not insulated and target.sg ~= nil and not target.sg:HasStateTag("dead") then
			target.sg:GoToState("electrocute")
		end
		
		return false -- Returning false so that WX doesn't get hit by the attack, but the code above still runs to charge them up
	elseif insulated then
		return false
	end
	
	return true
end

local POWERUP_MUST_TAGS = {"chess"}

local ATTACK_CANT_TAGS = {"DECOR", "FX", "INLIMBO", "chess", "playerghost", "wall", "structure"}

local function DoPulse(inst)
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, TUNING.RT_PAWN_PULSE_RANGE, POWERUP_MUST_TAGS)
	
	for i,ent in ipairs(ents) do
		if ent.entity:IsVisible() and (ent.components.health == nil or not ent.components.health:IsDead()) then
			if ent:HasTag("knight") then
				ent:AddDebuff("rt_pawn_buff_knight", "rt_pawn_buff_knight")
			elseif ent:HasTag("bishop") then
				ent:AddDebuff("rt_pawn_buff_bishop", "rt_pawn_buff_bishop")
			elseif ent:HasTag("rook") then
				ent:AddDebuff("rt_pawn_buff_rook", "rt_pawn_buff_rook")
			end
		end
	end
	
	inst.components.combat:DoAreaAttack(inst, TUNING.RT_PAWN_PULSE_RANGE, nil, inst.ShouldShockTarget, "electric", ATTACK_CANT_TAGS)
end

local function StartPulse(inst)
	if inst._pulse_fx == nil or not inst._pulse_fx:IsValid() then
		inst._pulse_fx = SpawnPrefab("alterguardian_phase3trapgroundfx")
		inst._pulse_fx.Transform:SetPosition(0,0,0)
		inst:AddChild(inst._pulse_fx)
	else
		inst._pulse_fx:RemoveEventCallback("animover", inst._pulse_fx.Remove)
	end
	
	inst._pulse_fx.AnimState:PlayAnimation("meteorground_pre")
	inst._pulse_fx.AnimState:PushAnimation("meteorground_loop", true)
	
	inst._pulse_task = inst:DoPeriodicTask(TUNING.RT_PAWN_PULSE_TICK_TIME, DoPulse, 1) -- to-do adjust delay
end

local function EndPulse(inst)
	if inst._pulse_fx ~= nil and inst._pulse_fx:IsValid() and not inst._pulse_fx.AnimState:IsCurrentAnimation("meteorground_pst") then
		inst._pulse_fx.AnimState:PlayAnimation("meteorground_pst")
		
		inst._pulse_fx:ListenForEvent("animover", inst._pulse_fx.Remove)
	end
	
	if inst._pulse_task ~= nil then
		inst._pulse_task:Cancel()
		inst._pulse_task = nil
	end
end

local function OnDeath(inst)
	inst:EndPulse()
end



local pawn_sounds = {
	walk = "dontstarve/creatures/spider/walk_spider",
	hit = "dontstarve/creatures/knight/hurt",
	death = "dontstarve/creatures/rook/explo",
	liedown = "dontstarve/creatures/bishop/liedown",
	sleep = "dontstarve/creatures/bishop/sleep",
	inject = "dontstarve/creatures/knight/land",
	ping = "WX_rework/scanner/ping",
}

local pawn_nightmare_sounds = {
	walk = "dontstarve/creatures/spider/walk_spider",
	hit = "dontstarve/creatures/knight_nightmare/hurt",
	death = "dontstarve/creatures/rook_nightmare/explo",
	liedown = "dontstarve/creatures/bishop_nightmare/liedown",
	sleep = "dontstarve/creatures/bishop_nightmare/sleep",
	inject = "dontstarve/creatures/knight_nightmare/land",
	ping = "WX_rework/scanner/ping",
}



local function fn_common(build)
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
	inst:AddTag("armoredbody")
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst.kind = ""
	inst.sounds = pawn_sounds
	
	local combat = inst:AddComponent("combat")
	combat.hiteffectsymbol = "body"
	combat:SetAttackPeriod(TUNING.KNIGHT_ATTACK_PERIOD)
	combat:SetDefaultDamage(TUNING.RT_PAWN_DAMAGE)
	combat:SetRetargetFunction(3, Retarget)
	combat:SetKeepTargetFunction(KeepTarget)
	combat.battlecryinterval = 15
	
	inst:AddComponent("follower")
	
	local health = inst:AddComponent("health")
	health:SetMaxHealth(TUNING.RT_PAWN_HEALTH)
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("knownlocations")
	
	local locomotor = inst:AddComponent("locomotor")
	locomotor.walkspeed = TUNING.RT_PAWN_WALK_SPEED
	
	local lootdropper = inst:AddComponent("lootdropper")
	lootdropper:SetChanceLootTable("rt_pawn")
	
	local sleeper = inst:AddComponent("sleeper")
	sleeper:SetWakeTest(ShouldWake)
	sleeper:SetSleepTest(ShouldSleep)
	sleeper:SetResistance(3)
	
	MakeMediumBurnableCharacter(inst, "body")
	MakeMediumFreezableCharacter(inst, "body")
	
	MakeHauntablePanic(inst)
	
	inst:SetStateGraph("SGrt_pawn")
	inst:SetBrain(brain)
	
	inst:DoTaskInTime(0, SetHomePosition)
	
	inst.StartPulse = StartPulse
	inst.EndPulse = EndPulse
	inst.ShouldShockTarget = ShouldShockTarget
	
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("newcombattarget", OnNewTarget)
	inst:ListenForEvent("death", OnDeath)
	
	return inst
end

local function fn()
	local inst = fn_common("rt_pawn")

	if not TheWorld.ismastersim then
		return inst
	end
	
	return inst
end

local QUICKFUSE_TIME = 0 

local function nightmarefn()
	local inst = fn_common("rt_pawn_nightmare")
	
	inst.Light:SetColour(.65, .5, .65)
	
	inst:AddTag("cavedweller")
	inst:AddTag("shadow_aligned")
	inst:AddTag("explosive")
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	local acidinfusible = inst:AddComponent("acidinfusible")
	acidinfusible:SetFXLevel(2)
	acidinfusible:SetMultipliers(TUNING.ACID_INFUSION_MULT.WEAKER)
	
	inst.kind = "_nightmare"
	inst.sounds = pawn_nightmare_sounds
	
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
