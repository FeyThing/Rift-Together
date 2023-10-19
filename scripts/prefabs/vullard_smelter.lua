require "prefabutil"
local smelterrecipe = require "main/smelterrecipe"

local assets = {
	Asset("ANIM", "anim/vullard_smelter.zip"),
}

local function SmeltItems(inst, item)

	if item and smelterrecipe[item.prefab] then
		if item.components.stackable then
			if item.components.stackable:StackSize() >= smelterrecipe[item.prefab].stacksize then
				for i = 1, smelterrecipe[item.prefab].returnamount do
					inst.components.container:GiveItem(SpawnPrefab(smelterrecipe[item.prefab].newitem), 2)
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				end
				if item.components.stackable:StackSize() == smelterrecipe[item.prefab].stacksize then
					inst.components.container:RemoveItemBySlot(1)
					inst.components.machine:TurnOff()
					inst.AnimState:PlayAnimation("idle")
					inst.SoundEmitter:KillSound("snd")
				else
					item.components.stackable:SetStackSize(item.components.stackable:StackSize() - smelterrecipe[item.prefab].stacksize)
					if item.components.stackable:StackSize() < smelterrecipe[item.prefab].stacksize then
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
			for i = 1, smelterrecipe[item.prefab].returnamount do
				inst.components.container:GiveItem(SpawnPrefab(smelterrecipe[item.prefab].newitem), 2)
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
end

local function onbuilt(inst)

	inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/chest_craft")
end


local function onopen(inst)
		inst.SoundEmitter:KillSound("snd")
        inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_open")		
		inst.components.machine:TurnOff()
end 

local function onclose(inst)
		inst.SoundEmitter:KillSound("snd")
        inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
end



local function TurnOn(inst)

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
end


    local function init()
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
        inst:AddTag("smelter")
		--inst:AddTag("HASHEATER")
		
		inst.Light:Enable(true)
		inst.Light:SetRadius(1.0)
		inst.Light:SetFalloff(.9)
		inst.Light:SetIntensity(0.5)
		inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)

        inst.AnimState:SetBank("vullard_smelter")
        inst.AnimState:SetBuild("vullard_smelter")
        inst.AnimState:PlayAnimation("idle")
		inst.AnimState:SetLightOverride(0.4)

	
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")
		
        inst:AddComponent("container")
        inst.components.container:WidgetSetup("vullard_smelter")
        inst.components.container.onopenfn = onopen
        inst.components.container.onclosefn = onclose		
		
		inst:AddComponent("machine")
		inst.components.machine.turnonfn = TurnOn
		inst.components.machine.turnofffn = TurnOff
		inst.components.machine.cooldowntime = 0.5
		
		--inst:AddComponent("heater")
		--inst.components.heater.heat = 115
		
        inst:ListenForEvent("onbuilt", onbuilt)
		
        return inst
    end

    return Prefab("vullard_smelter", init, assets),
		MakePlacer("vullard_smelter_placer", "vullard_smelter", "vullard_smelter", "idle")