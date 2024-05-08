require "prefabutil"
local Smelter = require "main/smelterrecipe"

local assets = {
	Asset("ANIM", "anim/vullard_smelter.zip"),
	Asset("ANIM", "anim/ui_smelter.zip"),
}

--[[local function SmeltItems(inst, item)
	if item and SmelterRecipes[item.prefab] then
		if item.components.stackable then
			if item.components.stackable:StackSize() >= SmelterRecipes[item.prefab].stacksize then
				for i = 1, SmelterRecipes[item.prefab].returnamount do
					inst.components.container:GiveItem(SpawnPrefab(SmelterRecipes[item.prefab].newitem), 2)
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				end
				if item.components.stackable:StackSize() == SmelterRecipes[item.prefab].stacksize then
					inst.components.container:RemoveItemBySlot(1)
					inst.components.machine:TurnOff()
					inst.AnimState:PlayAnimation("idle")
					inst.SoundEmitter:KillSound("snd")
				else
					item.components.stackable:SetStackSize(item.components.stackable:StackSize() - SmelterRecipes[item.prefab].stacksize)
					if item.components.stackable:StackSize() < SmelterRecipes[item.prefab].stacksize then
						inst.components.machine:TurnOff()
						inst.AnimState:PlayAnimation("idle")
						inst.SoundEmitter:KillSound("snd")
					end
				end
			else
			inst.components.machine:TurnOff()
			inst.AnimState:PlayAnimation("idle")
			inst.SoundEmitter:KillSound("snd")
			end
		else
			for i = 1, SmelterRecipes[item.prefab].returnamount do
				inst.components.container:GiveItem(SpawnPrefab(SmelterRecipes[item.prefab].newitem), 2)
				inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
			end
			inst.components.container:RemoveItemBySlot(1)
			inst.components.machine:TurnOff()
			inst.AnimState:PlayAnimation("idle")
			inst.SoundEmitter:KillSound("snd")
		end
	else
		inst.components.machine:TurnOff()
		inst.AnimState:PlayAnimation("idle")
		inst.SoundEmitter:KillSound("snd")
	end
end]]

local function OnStartSmelting(inst)
	inst.AnimState:PushAnimation("bubble_loop", true)
	inst.SoundEmitter:KillSound("snd")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot", "snd")
end

local function OnStopSmelting(inst)
	inst.AnimState:PlayAnimation("idle", true)
	inst.SoundEmitter:KillSound("snd")
end

local function OnDoneSmelting(inst)
	OnStopSmelting(inst)
	inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
end

local function OnBuilt(inst)
	inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/chest_craft")
end

local function OnOpen(inst)
	inst.SoundEmitter:KillSound("snd")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_open")
end 

local function OnClose(inst)
	inst.SoundEmitter:KillSound("snd")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
end

--[[local function TurnOn(inst)
	inst.on = true
	
	if inst.components.container:IsOpen() then
		inst.components.container:Close()
	end	
	inst.AnimState:PushAnimation("bubble_loop", true)
	inst.SoundEmitter:KillSound("snd")
	inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot", "snd")
	local item = inst.components.container:GetItemInSlot(1)
	inst.tasksmelt = inst:DoPeriodicTask(30, SmeltItems, nil, item)
end

local function TurnOff(inst)
    inst.on = false
	inst.AnimState:PlayAnimation("idle", true)
	
	if inst.tasksmelt ~= nil then
		inst.tasksmelt:Cancel()
		inst.tasksmelt = nil
	end
end]]

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddLight()
	inst.entity:AddNetwork()
	
	MakeObstaclePhysics(inst, 2.5)
	
	inst.MiniMapEntity:SetIcon("vullard_smelter.tex")
	
	inst.Transform:SetScale(2, 2, 1)
	
	inst:AddTag("structure")
	inst:AddTag("vullard_smelter")
	inst:AddTag("HASHEATER")
	inst:AddTag("container_stacksizechange_refresh")
	
	inst.Light:Enable(true)
	inst.Light:SetRadius(1.0)
	inst.Light:SetFalloff(.9)
	inst.Light:SetIntensity(0.5)
	inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)
	
	inst.AnimState:SetBank("vullard_smelter")
	inst.AnimState:SetBuild("vullard_smelter")
	inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetLightOverride(0.4)
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("vullard_smelter")
	inst.components.container.onopenfn = OnOpen
	inst.components.container.onclosefn = OnClose
	
	inst:AddComponent("vullard_smelter")
	inst.components.vullard_smelter.onstartsmelting = OnStartSmelting
	inst.components.vullard_smelter.onstopsmelting = OnStopSmelting
	inst.components.vullard_smelter.ondonesmelting = OnDoneSmelting
	
	inst:AddComponent("heater")
	inst.components.heater.heat = 90
	
	inst:ListenForEvent("onbuilt", OnBuilt)
	
	return inst
end

return Prefab("vullard_smelter", fn, assets),
	MakePlacer("vullard_smelter_placer", "vullard_smelter", "vullard_smelter", "idle")