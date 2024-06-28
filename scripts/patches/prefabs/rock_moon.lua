local STARFRUIT_PER_STAGE = {
	full = 3,
	med = 3,
	low = 2,
}

local STARFRUIT_ON_WORKED = 1

local function StartSpawnVineTimer(inst)
	if inst._startfruitvine == nil and inst.components.timer ~= nil and not inst.components.timer:TimerExists("spawn_starfruitvine") then
		inst.components.timer:StartTimer("spawn_starfruitvine", TUNING.STARFRUITVINE_SPAWN_TIME_MIN + math.random() * TUNING.STARFRUITVINE_SPAWN_TIME_VARIANCE)
	end
end

local function GetStage(inst)
	if inst.components.workable ~= nil then
		local workleft = inst.components.workable.workleft
		
		return (workleft < TUNING.ROCKS_MINE / 3 and "low") or
		(workleft < TUNING.ROCKS_MINE * 2 / 3 and "med") or
		"full"
	end
	
	return "full"
end

local function MakeEmpty(inst)
	if inst._startfruitvine ~= nil then
		local stage = inst.currentstage
		
		if POPULATING then
			inst._startfruitvine:PlayAnim(stage, "empty", true)
		else
			inst._startfruitvine:PlayAnim(stage, "spread")
			inst._startfruitvine:PlayAnim(stage, "empty", true, true)
		end
		
		if inst.components.pickable ~= nil then
			inst.components.pickable.numtoharvest = STARFRUIT_PER_STAGE[stage]
			inst.components.pickable:Resume()
		end
	end
end

local function SpawnVines(inst)
	if inst._startfruitvine == nil then
		inst._startfruitvine = SpawnPrefab("starfruitvine")
		inst._startfruitvine.entity:SetParent(inst.entity)
		
		if inst.highlightchildren == nil then
			inst.highlightchildren = { inst._startfruitvine }
		else
			table.insert(inst.highlightchildren, inst._startfruitvine)
		end
	end
end

local function OnTimerDone(inst, data)
	if inst._startfruitvine == nil and data ~= nil and data.name == "spawn_starfruitvine" then
		SpawnVines(inst)
		
		MakeEmpty(inst)
		
		if inst.components.pickable ~= nil then
			inst.components.pickable:Resume()
		end
	end
end

local function OnPicked(inst, picker, loot)
	if inst._startfruitvine ~= nil then
		inst._startfruitvine:Remove()
		inst._startfruitvine = nil
		
		if inst.components.pickable ~= nil then
			inst.components.pickable:Pause()
			inst.components.pickable:MakeEmpty()
		end
		
		StartSpawnVineTimer(inst)
	end
end

local function OnWorked(inst, data)
	local stage = GetStage(inst)
	local workleft = data ~= nil and data.workleft
	
	if not inst.AnimState:IsCurrentAnimation(stage) or (workleft ~= nil and workleft <= 0) then
		if inst.components.pickable ~= nil and inst.components.pickable:CanBePicked() then
			inst.components.pickable.numtoharvest = STARFRUIT_ON_WORKED
			inst.components.pickable.droppicked = true -- With this they get launched instead of spawning inside the boulder
			inst.components.pickable:Pick(TheWorld)
			inst.components.pickable.droppicked = nil
		else
			OnPicked(inst) -- Still run this so the vines go away and the timer restarts
		end
	end
	
	-- Pickable needs workable to load first to set proper animations when loading
	-- so I'm instead saving the stage so it's consistent
	inst.currentstage = stage
end

local function MakeFull(inst)
	if inst._startfruitvine ~= nil then
		local stage = inst.currentstage
		
		if POPULATING then
			inst._startfruitvine:PlayAnim(stage, "idle", true)
		else
			inst._startfruitvine:PlayAnim(stage, "grow")
			inst._startfruitvine:PlayAnim(stage, "idle", true, true)
		end
		
		if inst.components.pickable ~= nil then
			inst.components.pickable.numtoharvest = STARFRUIT_PER_STAGE[stage]
		end
	end
end

return function(inst)
	if not TheWorld.ismastersim then
		return
	end
	
	if inst.components.timer == nil then
		inst:AddComponent("timer")
	end
	
	if inst.components.pickable == nil then
		inst:AddComponent("pickable")
	end
	inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
	inst.components.pickable.makeemptyfn = MakeEmpty
	inst.components.pickable.makefullfn = MakeFull
	inst.components.pickable.onpickedfn = OnPicked
	inst.components.pickable.max_cycles = 1 -- Cycles don't actually matter since it's not transplanted
	inst.components.pickable.cycles_left = inst.components.pickable.max_cycles
	inst.components.pickable:SetUp("starfruit", TUNING.STARFRUITVINE_GROW_TIME)
	inst.components.pickable:Pause()
	inst.components.pickable:MakeEmpty()
	
	if inst.components.workable ~= nil then
		inst.components.workable.savestate = true
		
		local _old_onloadfn = inst.components.workable.onloadfn
		inst.components.workable:SetOnLoadFn(function(inst, data, ...)
			if _old_onloadfn ~= nil then
				_old_onloadfn(inst, data, ...)
			end
			
			if inst.components.workable.onwork ~= nil then
				inst.components.workable.onwork(inst, nil, inst.components.workable.workleft, 0)
			end
			
			inst.currentstage = GetStage(inst)
		end)
	end
	
	inst.currentstage = "full"
	
	inst:ListenForEvent("timerdone", OnTimerDone)
	inst:ListenForEvent("worked", OnWorked)
	
	local _old_onsave = inst.OnSave
	inst.OnSave = function(inst, data, ...)
		if _old_onsave ~= nil then
			_old_onsave(inst, data, ...)
		end
		
		if data ~= nil then
			data.starfruitvine = inst._startfruitvine ~= nil
			data.currentstage = inst.currentstage
		end
	end
	
	local _old_onpreload = inst.OnPreLoad
	inst.OnPreLoad = function(inst, data, ...)
		if _old_onpreload ~= nil then
			_old_onpreload(inst, data, ...)
		end
		
		if data ~= nil then
			if data.starfruitvine then
				SpawnVines(inst)
			end
			if data.currentstage then
				inst.currentstage = data.currentstage
			end
		end
	end
	
	inst:DoTaskInTime(0, StartSpawnVineTimer)
end