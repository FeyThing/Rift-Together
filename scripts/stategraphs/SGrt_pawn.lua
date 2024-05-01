require("stategraphs/commonstates")
local easing = require("easing")


--------------------------------------------------------------------------

local ARC = 90 * DEGREES --degrees to each side
local AOE_RANGE_PADDING = 3
local AOE_TARGET_MUSTHAVE_TAGS = { "_combat" }
local AOE_TARGET_CANT_TAGS = { "INLIMBO", "flight", "invisible", "notarget", "noattack", "chess" }
local MAX_SIDE_TOSS_STR = 0.2

local function DoAOEAttack(inst, dist, radius, heavymult, mult, forcelanded, targets, knockback_existing_targets)
	inst.components.combat.ignorehitrange = true
	local x, y, z = inst.Transform:GetWorldPosition()
	local rot = inst.Transform:GetRotation() * DEGREES
	if dist ~= 0 then
		x = x + dist * math.cos(rot)
		z = z - dist * math.sin(rot)
	end
	for i, v in ipairs(TheSim:FindEntities(x, y, z, radius + AOE_RANGE_PADDING, AOE_TARGET_MUSTHAVE_TAGS, AOE_TARGET_CANT_TAGS)) do
		if v ~= inst and v:IsValid() and not v:IsInLimbo() and
			not (v.components.health ~= nil and v.components.health:IsDead())
		then
			local is_existing_target = targets ~= nil and targets[v]
			if not is_existing_target or knockback_existing_targets then
				local range = radius + v:GetPhysicsRadius(0)
				local distsq = v:GetDistanceSqToPoint(x, y, z)
				if distsq < range * range then
					local should_knockback = is_existing_target
					if not is_existing_target and inst.components.combat:CanTarget(v) then
						inst.components.combat:DoAttack(v)
						should_knockback = true
						if targets ~= nil then
							targets[v] = true
						end
					end
					if should_knockback and mult ~= nil then
						v:PushEvent("knockback", { knocker = inst, radius = radius + dist, strengthmult = (v.components.inventory ~= nil and v.components.inventory:ArmorHasTag("heavyarmor") or v:HasTag("heavybody")) and heavymult or mult, forcelanded = 1 })
					end
				end
			end
		end
	end
	inst.components.combat.ignorehitrange = false
end


local actionhandlers =
{
}

local events=
{
   CommonHandlers.OnLocomote(false, true),
   CommonHandlers.OnSleep(),
   CommonHandlers.OnFreeze(),
   CommonHandlers.OnAttack(),
   CommonHandlers.OnAttacked(),
   CommonHandlers.OnDeath(),
   
}



local function set_lightvalues(inst, val)
	
	inst.Light:SetIntensity(.5 * val)
    inst.Light:SetRadius(0.5 * val)
	inst.Light:SetFalloff(0.1)
	
	inst.AnimState:SetSymbolBloom("bulb")
	inst.AnimState:SetSymbolLightOverride("bulb", .5)
	inst.AnimState:SetLightOverride(.5 * val)
    
end

local states =
{
	 State{
		name = "idle",
		tags = {"idle", "canrotate"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("idle", true)
			inst.Physics:Stop()
			
			set_lightvalues(inst, 0.0)
		end,
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
		},
	},
	
	State{
		name = "taunt",
		tags = {"busy", "canrotate"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("taunt")
			inst.Physics:Stop()
			
			set_lightvalues(inst, .1)
		end,
		
		timeline =
        {
		    TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("WX_rework/scanner/ping") end ),
		    TimeEvent(28*FRAMES, function(inst) inst.SoundEmitter:PlaySound("WX_rework/scanner/ping") end ),
        },
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
		},
	},
	
	State{
		name = "walk_start",
		tags = {"moving", "canrotate"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("walk_pre")
		end,
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("walk")
			end),
		},
	},
	
	State{
		name = "walk",
		tags = {"moving", "canrotate"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("walk_loop")
			inst.components.locomotor:RunForward()
		end,
		
		timeline=
        {
            TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spider/walk_spider") end),
            TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spider/walk_spider") end),
            TimeEvent(7*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spider/walk_spider") end),
            TimeEvent(12*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spider/walk_spider") end),
        },
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("walk")
			end),
		},
	},
	
	State{
		name = "walk_stop",
		tags = {"moving", "canrotate"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("walk_pst")
			inst.Physics:Stop()
		end,
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
		},
	},
	
	--[[State{
		name = "attack_pre",
		tags = {"attack", "busy", "canrotate"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("inject_pre")
			inst.Physics:Stop()
		end,
		
	    timeline =
        {
        		TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/bounce") end ),
        		TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/land") end ),
        },
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
		},
	},]]
	
	State{
		name = "attack",
		tags = {"attack", "busy", "canrotate"},
		
		onenter = function(inst)
			inst.sg:SetTimeout(3.8)
            inst.AnimState:PlayAnimation("inject_pre")
			inst.AnimState:PushAnimation("inject_loop", true)
			inst.Physics:Stop()
			
			set_lightvalues(inst, .1)
		end,
		
		timeline =
		{
			TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/bounce") end ),       		
			TimeEvent(6 * FRAMES, function(inst)
				inst.components.combat:DoAttack()
			end),
			FrameEvent(8, function(inst)
			
				local x, y, z = inst.Transform:GetWorldPosition()
				local sparks = SpawnPrefab("wx78_big_spark")
				sparks.Transform:SetPosition(x, 0, z)
				--inst.components.groundpounder:GroundPound()
				--inst.components.timer:StopTimer("GroundPound")
				--inst.components.timer:StartTimer("GroundPound", TUNING.RT_PAWN_PULSE_COOLDOWN)
				--inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
			end),
			FrameEvent(9, function(inst)
				local x, y, z = inst.Transform:GetWorldPosition()
				local rot = inst.Transform:GetRotation() * DEGREES
				local dist = -1
				x = x + dist * math.cos(rot)
				z = z - dist * math.sin(rot)

				--extra "true" to knockback existing targets from groundpound
				DoAOEAttack(inst, dist, 4, 1.2, 1.5, nil, inst.sg.statemem.targets, true)
				ToggleOnCharacterCollisions(inst)


				
				--local sinkhole = SpawnPrefab("daywalker_sinkhole")
				--sinkhole.Transform:SetPosition(x, 0, z)
				--sinkhole:PushEvent("docollapse")

			end),
			TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/land") end ),
		},
		
		ontimeout = function(inst)
            inst.sg:GoToState("attack_pst")
        end,
		
		
	},
	
	State{
		name = "attack_pst",
		tags = {"busy", "canrotate"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("inject_pst")
			inst.Physics:Stop()
		end,
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
		},
	},
	
	State{
		name = "hit",
		tags = {"busy", "canrotate", "hit"},
		
		onenter = function(inst)			
			inst.AnimState:PlayAnimation("hit")
			inst.Physics:Stop()
		end,
		
		timeline=
        {
            TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt") end),
        },
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
		},
	},
	
	State{
		name = "death",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("death")
			inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
		end,
		
		timeline=
        {
            TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/rook/explo") end),
        },
	},
	
}

CommonStates.AddSleepStates(states,
{
	starttimeline = {
	TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/bishop/liedown") end ),
	},
	
	sleeptimeline = {
	TimeEvent(18*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/bishop/sleep") end),
	},
})

--[[CommonStates.AddCombatStates(states,
{

    hittimeline =
    {
        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt") end),
    },
})]]

CommonStates.AddFrozenStates(states)


return StateGraph("rt_pawn", states, events, "idle", actionhandlers)

