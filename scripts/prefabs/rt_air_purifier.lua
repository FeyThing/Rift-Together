local assets =
{
	Asset("ANIM", "anim/rt_air_purifier.zip"),
	Asset("ANIM", "anim/firefighter_placement.zip"),
}

local prefabs =
{
	"collapse_small",
}

local function StartConsumingFilter(filter)
	if filter.components.fueled ~= nil then
		filter.components.fueled:StartConsuming()
	end
end

local function StopConsumingFilter(filter)
	if filter.components.fueled ~= nil then
		filter.components.fueled:StopConsuming()
	end
end

local function HasFilter(inst)
	local container = inst.components.container
	
	return container ~= nil and container:IsFull()
end

local function IsMachineOn(inst)
	local machine = inst.components.machine
	
	return machine ~= nil and machine:IsOn()
end

local function TurnOn(inst, instant)
	-- Need the HasFilter in case the filter is removed as the player is approaching to perform the action
	-- But the filter doesn't exist as the game is loading, so I'll check for POPULATING too
	if POPULATING or HasFilter(inst) then
		if inst.components.fueled ~= nil then
			inst.components.fueled:StartConsuming()
		end
		
		if inst.components.container ~= nil then
			inst.components.container:ForEachItem(StartConsumingFilter)
		end
		
		if not inst.SoundEmitter:PlayingSound("firesuppressor_idle") then
			inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_idle", "firesuppressor_idle")
		end
		
		inst.AnimState:PlayAnimation("idle_on_loop", true)
	end
end

local function TurnOff(inst, instant)
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
	
	if inst.components.container ~= nil then
		inst.components.container:ForEachItem(StopConsumingFilter)
	end
	
	inst.AnimState:PlayAnimation("idle_off")
end

local function OnFuelEmpty(inst)
	if inst.components.machine ~= nil then
		inst.components.machine:TurnOff()
	end
end

local function OnAddFuel(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/machine_fuel")
	
	if IsMachineOn(inst) and HasFilter(inst) then
		inst.components.machine:TurnOn()
	end
end

local function OnFuelSectionChange(new, old, inst)
	if inst._fuellevel ~= new then
		inst._fuellevel = new
		
		--inst.AnimState:OverrideSymbol("swap_meter", "firefighter_meter", tostring(new))
	end
end

local function OnHammered(inst, worker)
	inst.SoundEmitter:KillSound("firesuppressor_idle")
	
	if inst.components.lootdropper ~= nil then
		inst.components.lootdropper:DropLoot()
	end
	
	if inst.components.container ~= nil then
		inst.components.container:DropEverything()
	end
	
	local fx = SpawnPrefab("collapse_small")
	fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	fx:SetMaterial("metal")
	inst:Remove()
end

local function OnHit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	
	if IsMachineOn(inst) then
		inst.AnimState:PushAnimation("idle_on_loop", true)
	else
		inst.AnimState:PushAnimation("idle_off")
	end
end

local function GetStatus(inst, viewer)
	local lowfuel = inst.components.fueled ~= nil and inst.components.fueled:GetCurrentSection() <= 2
	
	return (not HasFilter(inst) and "NOFILTER")
		or (lowfuel and "LOWFUEL")
		or (IsMachineOn(inst) and "ON")
		or nil
end

local function OnOpen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
end

local function OnClose(inst)
	inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
end

local function OnEntitySleep(inst)
	inst.SoundEmitter:KillSound("firesuppressor_idle")
end

local function OnEntityWake(inst)
	if IsMachineOn(inst) and not inst.SoundEmitter:PlayingSound("firesuppressor_idle") then
		inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_idle", "firesuppressor_idle")
	end
end

local function OnBuilt(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_craft")
	
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle_off", false)
end

local function OnGetItem(inst, data)
	if inst.components.machine ~= nil then
		inst.components.machine.enabled = true
	end
end

local function OnLoseItem(inst, data)
	if inst.components.machine ~= nil then
		if IsMachineOn(inst) then
			inst.components.machine:TurnOff()
		end
		
		inst.components.machine.enabled = false
	end
	
	if data ~= nil and data.prev_item ~= nil then
		StopConsumingFilter(data.prev_item)
	end
end

local CIRCLE_RADIUS_SCALE = 1888 / 150 / 2 -- Source art size / anim_scale / 2 (halved to get radius).

local function CreateHelperRadiusCircle()
	local inst = CreateEntity()
	
	--[[Non-networked entity]]
	inst.entity:SetCanSleep(false)
	inst.persists = false
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	
	inst:AddTag("CLASSIFIED")
	inst:AddTag("NOCLICK")
	inst:AddTag("placer")
	
	inst.AnimState:SetBank("firefighter_placement")
	inst.AnimState:SetBuild("firefighter_placement")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetLightOverride(1)
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(1)
	inst.AnimState:SetAddColour(0, .2, .5, 0)
	
	local scale = TUNING.RT_AIR_PURIFIER_RADIUS / CIRCLE_RADIUS_SCALE
	
	inst.AnimState:SetScale(scale, scale)
	
	return inst
end

local function OnEnableHelper(inst, enabled)
	if enabled then
		if inst.helper == nil then
			inst.helper = CreateHelperRadiusCircle()
			
			inst.helper.entity:SetParent(inst.entity)
		end
	elseif inst.helper ~= nil then
		inst.helper:Remove()
		inst.helper = nil
	end
end

local SECTIONS = 10

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()
	
	inst.MiniMapEntity:SetPriority(4)
	inst.MiniMapEntity:SetIcon("rt_air_purifier.png")
	
	MakeObstaclePhysics(inst, 1)
	
	inst.AnimState:SetBank("rt_air_purifier")
	inst.AnimState:SetBuild("rt_air_purifier")
	inst.AnimState:PlayAnimation("idle_off")
	--inst.AnimState:OverrideSymbol("swap_meter", "firefighter_meter", "10") -- to-do?
	
	inst:AddTag("structure")
	
	--Dedicated server does not need deployhelper
	if not TheNet:IsDedicated() then
		inst:AddComponent("deployhelper")
		inst.components.deployhelper.onenablehelper = OnEnableHelper
	end
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst._fuellevel = SECTIONS
	
	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = GetStatus
	
	inst:AddComponent("machine")
	inst.components.machine.turnonfn = TurnOn
	inst.components.machine.turnofffn = TurnOff
	inst.components.machine.cooldowntime = 0.5
	inst.components.machine.enabled = false
	
	inst:AddComponent("fueled")
	inst.components.fueled:SetDepletedFn(OnFuelEmpty)
	inst.components.fueled:SetTakeFuelFn(OnAddFuel)
	inst.components.fueled.accepting = true
	inst.components.fueled:SetSections(SECTIONS)
	inst.components.fueled:SetSectionCallback(OnFuelSectionChange)
	inst.components.fueled:InitializeFuelLevel(TUNING.RT_AIR_PURIFIER_MAX_FUEL_TIME)
	inst.components.fueled.bonusmult = 5
	inst.components.fueled.fueltype = FUELTYPE.BURNABLE
	inst.components.fueled.secondaryfueltype = FUELTYPE.CHEMICAL
	
	inst:AddComponent("lootdropper")
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(OnHammered)
	inst.components.workable:SetOnWorkCallback(OnHit)
	
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("rt_air_purifier")
	inst.components.container.onopenfn = OnOpen
	inst.components.container.onclosefn = OnClose
	inst.components.container.skipclosesnd = true
	inst.components.container.skipopensnd = true
	
	inst:ListenForEvent("onbuilt", OnBuilt)
	inst:ListenForEvent("itemget", OnGetItem)
	inst:ListenForEvent("itemlose", OnLoseItem)
	
	inst.OnEntitySleep = OnEntitySleep
	inst.OnEntityWake = OnEntityWake
	
	MakeHauntableWork(inst)
	
	return inst
end

local function placer_postinit_fn(inst)
	local helper = CreateHelperRadiusCircle()
	
	helper.entity:SetParent(inst.entity)
	
	inst.components.placer:LinkEntity(helper)
end

return Prefab("rt_air_purifier", fn, assets, prefabs),
	MakePlacer("rt_air_purifier_placer", "rt_air_purifier", "rt_air_purifier", "idle_off", nil, nil, nil, nil, nil, nil, placer_postinit_fn)
