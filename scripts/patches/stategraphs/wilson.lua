local ACTIONS = _G.ACTIONS
local EQUIPSLOTS = _G.EQUIPSLOTS
local EventHandler = _G.EventHandler
local FRAMES = _G.FRAMES
local State = _G.State
local TimeEvent = _G.TimeEvent

local PlayFootstep = _G.PlayFootstep
local function DoEquipmentFoleySounds(inst)
	for k, v in pairs(inst.components.inventory.equipslots) do
		if v.foleysound then
			inst.SoundEmitter:PlaySound(v.foleysound, nil, nil, true)
		end
	end
end

local function DoFoleySounds(inst)
	DoEquipmentFoleySounds(inst)
	if inst.foleysound then
		inst.SoundEmitter:PlaySound(inst.foleysound, nil, nil, true)
	end
end

local states = {

State{
        name = "hover_start",
        tags = { "moving", "running", "canrotate", "hovering", "autopredict" },

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("shoehover_pre")
		if not inst.AnimState:IsCurrentAnimation("shoeshover_pre") then
				inst.AnimState:PlayAnimation("shoeshover_pre")
			end
            
        end,

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("run_hover")
                end
            end),
        },
    },
	
		State{
		name = "run_hover",
		tags = {"moving", "running", "canrotate", "hovering", "autopredict"},
		
		onenter = function(inst)
			inst.components.locomotor:RunForward()
			if not inst.AnimState:IsCurrentAnimation("shoeshover_loop") then
				inst.AnimState:PlayAnimation("shoeshover_loop", true)
			end
			inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
		end,
		
		timeline =
		{
			TimeEvent(1 * FRAMES, function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/spark", nil, nil, true)
				PlayFootstep(inst, 0.3)
			end),
			TimeEvent(6 * FRAMES, function(inst) 
				DoFoleySounds(inst)
			end),
			TimeEvent(15 * FRAMES, function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/spark", nil, nil, true)
				PlayFootstep(inst, 0.3)
			end),
		},
		
		events =
        {
            EventHandler("carefulwalking", function(inst, data)
                if data.careful then
                    if inst.sg.statemem.careful then
                        inst.sg:GoToState("run_hover")
                    end
                end
            end),
        },
		
		onupdate = function(inst)
			inst.components.locomotor:RunForward()
		end,
		
		ontimeout = function(inst)
			inst.sg:GoToState("run_hover")
		end,
	},
	
	State{
        name = "hover_stop",
        tags = { "canrotate", "hovering", "idle", "autopredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("shoeshover_pst")
			if not inst.AnimState:IsCurrentAnimation("shoeshover_pst") then
				inst.AnimState:PlayAnimation("shoeshover_pst")
			end
            
        end,
            
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle_hover")
                end
            end),
        },
    },
	
	    State{
        name = "idle_hover",
        tags = { "idle", "canrotate", "hovering", },

        onenter = function(inst, pushanim)
            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
			
			if inst.components.drownable ~= nil and inst.components.drownable:ShouldDrown() then
                inst.sg:GoToState("sink_fast")
                return
            end
						
            inst.sg.statemem.ignoresandstorm = true
			
			if not inst.AnimState:IsCurrentAnimation("shoeshover_idle") then
				inst.AnimState:PlayAnimation("shoeshover_idle", true)
			end
			inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
			end,
     
        events =
        {
			EventHandler("stormlevel", function(inst, data)
                if not inst.sg.statemem.ignoresandstorm then
                    if data.level < TUNING.SANDSTORM_FULL_LEVEL then
                        if inst.sg.statemem.sandstorm then
                            inst.sg:GoToState("idle_hover")
                        end
                    elseif not (inst.sg.statemem.sandstorm or inst.components.playervision:HasGoggleVision()) then
                        inst.sg:GoToState("idle_hover")
                    end
                end
            end),
			EventHandler("miasmalevel", function(inst, data)
				if not inst.sg.statemem.ignoresandstorm then
					if data.level < 1 then
						if inst.sg.statemem.sandstorm then
							inst.sg:GoToState("idle_hover")
						end
					elseif not (inst.sg.statemem.sandstorm or inst.components.playervision:HasGoggleVision()) then
						inst.sg:GoToState("idle_hover")
					end
				end
			end),
        },

        ontimeout = function(inst)
		inst.sg:GoToState("idle_hover")
		
            --[[local royalty = nil
            local mindistsq = 25
            for i, v in ipairs(AllPlayers) do
                if v ~= inst and
                    not v:HasTag("playerghost") and
                    v.entity:IsVisible() and
                    v.components.inventory:EquipHasTag("regal") then
                    local distsq = v:GetDistanceSqToInst(inst)
                    if distsq < mindistsq then
                        mindistsq = distsq
                        royalty = v
                    end
                end
            end
            if royalty ~= nil then
                inst.sg:GoToState("bow", royalty)
            else
                inst.sg:GoToState("idle_hover")
            end]]
        end,
    },

}


return function(sg)


for _, state in pairs(states) do
		sg.states[state.name] = state
	end
	
---hover
	local oldrun_startenter2 = sg.states["run_start"].onenter
	sg.states["run_start"].onenter = function(inst, ...)
		oldrun_startenter2(inst, ...)
		print("Run_Start:", inst:HasTag("hovershoed"))
		if inst:HasTag("hovershoed") and inst.AnimState:IsCurrentAnimation("run_start") then
			inst.AnimState:PlayAnimation("shoeshover_pre")
		end
	end
	
	local oldrunenter2 = sg.states["run"].onenter
	sg.states["run"].onenter = function(inst, ...)
		oldrunenter2(inst, ...)
		if inst:HasTag("hovershoed") then
			inst.sg:GoToState("run_hover")
		elseif inst:HasTag("wonkey") and inst:HasTag("monkeyshoed") and inst.components.locomotor:GetTimeMoving() >= TUNING.SHOES_MONKEY_TIME_TO_RUN then
			inst.sg:GoToState("run_monkey_start")
		end
	end
	
	local oldrun_stopenter2 = sg.states["run_stop"].onenter
	sg.states["run_stop"].onenter = function(inst, ...)
		oldrun_stopenter2(inst, ...)
		
		if inst:HasTag("hovershoed") and inst.AnimState:IsCurrentAnimation("run_pst") then
			inst.AnimState:PlayAnimation("shoeshover_pst")
		end
	end
	
	local oldidle = sg.states["idle"].onenter
	sg.states["idle"].onenter = function(inst, ...)
		oldidle(inst, ...)
		
		if inst:HasTag("hovershoed") then
			inst.sg:GoToState("idle_hover")
		end
	end

end
