local ACTIONS = _G.ACTIONS
local EQUIPSLOTS = _G.EQUIPSLOTS
local EventHandler = _G.EventHandler
local FRAMES = _G.FRAMES
local State = _G.State
local TimeEvent = _G.TimeEvent
local cooking = require("cooking")


_G.USE_DRINK_ANIM = {
    sweettea = true,
    vegstinger = true,
    winter_food8 = {build = "winterfood", sym = "coco"},
	winter_food7 = {build = "winterfood", sym = "cider"},
	winter_food9 = {build = "winterfood", sym = "eggnog"},
	nanoboost = {build = "nanoboost", sym = "nanoboost"},
}

local function GetFoodBuild(foodname) -- foodname is prefab
    local build = "cook_pot_food"
    local overridesymbol = foodname
    for k, v in pairs(cooking.recipes) do
        local recipe = cooking.GetRecipe(k, foodname)
        if recipe then
            if recipe.overridebuild ~= nil then
                build = recipe.overridebuild
            end
            if recipe.overridesymbolname ~= nil then
                overridesymbol = recipe.overridesymbol
            end
            
            break
        end
    end
    
    return build, overridesymbol
end

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
        tags = { "moving", "running", "canrotate", "hovering", "noslip", "autopredict" },

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
		tags = {"moving", "running", "canrotate", "hovering", "noslip", "autopredict"},
		
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
        tags = { "canrotate", "hovering", "idle", "noslip", "autopredict" },

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
        tags = { "idle", "canrotate","noslip", "hovering", },

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
		
        end,
    },
	
	State{
        name = "idle_hover_stop",
        tags = { "canrotate","noslip", "hovering", "idle", "autopredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("shoeshover_pst_idle")
			if not inst.AnimState:IsCurrentAnimation("shoeshover_pst") then
				inst.AnimState:PlayAnimation("shoeshover_pst")
			end
            
        end,
            
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
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
	
local oldquickeat = sg.states["quickeat"].onenter
    sg.states["quickeat"].onenter = function(inst, foodinfo, ...)
		
	
        local feed = foodinfo and foodinfo.feed
        local act = inst:GetBufferedAction()
        if feed == nil and act and act.invobject then
            feed = act.invobject
        end
		
		
        oldquickeat(inst, foodinfo, ...)
        		
		
        local drink_data = feed and _G.USE_DRINK_ANIM[feed.prefab]
        if drink_data then
            inst.AnimState:PlayAnimation("quick_drink")
			inst.SoundEmitter:KillSound("eating")
			--inst.SoundEmitter:PlaySound("dontstarve/creatures/slurper/burp")
            
            local build, overridesymbol
            if type(drink_data) == "table" then
                build, overridesymbol = drink_data.build, drink_data.sym
				print ("Show non-crockpot drink", drink_data.build, drink_data.sym)
            else
                build, overridesymbol = GetFoodBuild(feed.prefab)
            end
            local basename = string.match(overridesymbol, "(.*)_spice")
            inst.AnimState:OverrideSymbol("drink", build, basename or overridesymbol)
        end
    end
	
	local oldeat = sg.states["eat"].onenter
    sg.states["eat"].onenter = function(inst, foodinfo, ...)
		
	
        local feed = foodinfo and foodinfo.feed
        local act = inst:GetBufferedAction()
        if feed == nil and act and act.invobject then
            feed = act.invobject
        end
		
		
        oldeat(inst, foodinfo, ...)
        		
		
        local drink_data = feed and _G.USE_DRINK_ANIM[feed.prefab]
        if drink_data then
            inst.AnimState:PlayAnimation("drink")
			inst.SoundEmitter:KillSound("eating")
			--inst.SoundEmitter:PlaySound("dontstarve/creatures/slurper/burp")
            
            local build, overridesymbol
            if type(drink_data) == "table" then
                build, overridesymbol = drink_data.build, drink_data.sym
				print ("Show non-crockpot drink", drink_data.build, drink_data.sym)
            else
                build, overridesymbol = GetFoodBuild(feed.prefab)
            end
            local basename = string.match(overridesymbol, "(.*)_spice")
            inst.AnimState:OverrideSymbol("drink", build, basename or overridesymbol)
        end
    end
	
	local oldeat2 = sg.actionhandlers[ACTIONS.EAT].deststate
	sg.actionhandlers[ACTIONS.EAT].deststate = function(inst, action, ...)
    local obj = action.target or action.invobject
    if obj and obj.prefab == "nanoboost" then
        return "eat"
    end
    
    return oldeat2(inst, action, ...)
	end
	
	local EATSTR = ACTIONS.EAT.stroverridefn
	ACTIONS.EAT.stroverridefn = function(act)
    if table.contains(_G.USE_DRINK_ANIM, act.invobject.prefab) then
        return _G.STRINGS.ACTIONS.DRINK
    end
    
    if EATSTR ~= nil then
        return EATSTR(act)
    end
	end
end
