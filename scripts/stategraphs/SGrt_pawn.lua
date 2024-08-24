require("stategraphs/commonstates")



local actionhandlers = {
}

local events = {
	CommonHandlers.OnLocomote(false, true),
	CommonHandlers.OnSleep(),
	CommonHandlers.OnFreeze(),
	--CommonHandlers.OnAttack(),
	CommonHandlers.OnAttacked(),
	CommonHandlers.OnDeath(),
	EventHandler("inject", function(inst)
		if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then
			inst.sg:GoToState("inject_pre")
		end
	end),
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
			FrameEvent(3, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.ping) end),
			FrameEvent(12, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.ping) end),
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
			FrameEvent(0, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.walk) end),
			FrameEvent(3, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.walk) end),
			FrameEvent(7, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.walk) end),
			FrameEvent(12, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.walk) end),
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
	
	State{
		name = "inject_pre",
		tags = {"busy", "canrotate"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			
			inst.AnimState:PlayAnimation("inject_pre")
		end,
		
		timeline =
		{
			FrameEvent(7, function(inst)
				inst:StartPulse()
				
				local x, y, z = inst.Transform:GetWorldPosition()
				local sparks = SpawnPrefab("wx78_big_spark") -- to-do
				sparks.Transform:SetPosition(x, 0, z)
				
				inst.SoundEmitter:PlaySound(inst.sounds.inject)
			end),
		},
		
		events =
		{
			EventHandler("animover", function(inst)
				inst.sg.statemem.injecting = true
				inst.sg:GoToState("inject")
			end),
		},
		
		onexit = function(inst)
			if not inst.sg.statemem.injecting then
				inst:EndPulse()
			end
		end,
	},
	
	State{
		name = "inject",
		tags = {"busy", "canrotate"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			
			inst.AnimState:PlayAnimation("inject_loop")
			for i=1,4 do
				inst.AnimState:PushAnimation("inject_loop", false)
			end
			
			set_lightvalues(inst, .1)
			
			inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/bounce")
		end,
		
		--[[timeline =
		{  		
			FrameEvent(6, function(inst)
				-- to-do DoAttack was here
			end),
			FrameEvent(8, function(inst)
			end),
			FrameEvent(9, function(inst)
				-- to-do AoeAttack was here
			end),
			FrameEvent(11, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/land")
			end),
		},]]
		
		events =
		{
			EventHandler("animqueueover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("inject_pst")
				end
			end),
		},
		
		onexit = function(inst)
			inst:EndPulse()
		end,
	},
	
	State{
		name = "inject_pst",
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
}

CommonStates.AddSleepStates(states,
{
	starttimeline = {
		FrameEvent(11, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.liedown) end),
	},
	
	sleeptimeline = {
		FrameEvent(18, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.sleep) end),
	},
})

CommonStates.AddHitState(states)
CommonStates.AddDeathState(states, {
	FrameEvent(0, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.death) end),
})

CommonStates.AddFrozenStates(states)



return StateGraph("rt_pawn", states, events, "idle", actionhandlers)