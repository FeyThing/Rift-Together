local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.RATCHET
end
local prefabs = FlattenTree(start_inv, true)

local function applyupgrades(inst)
	local max_upgrades = 10
	local upgrades = math.min(inst.level, max_upgrades)

	local health_percent = inst.components.health:GetPercent()

	inst.components.health.maxhealth = math.ceil (100 + upgrades * 10) --200
		
	inst.components.talker:Say("Level : ".. (inst.level))
	
	if inst.level > 9 then
		inst.components.talker:Say("Level : Max!")
	end

	inst.components.health:SetPercent(health_percent)
end

local function oneat(inst, food)
	if food and food.components.edible and food.prefab == "nanoboost" then
		inst.level = inst.level + 1
		applyupgrades(inst)	
		inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
		inst.components.hunger:DoDelta(70)
		inst.components.health:DoDelta(70)
		inst.components.sanity:DoDelta(50)
	end
end

local function onpreload(inst, data)
	if data then
		if data.level then
			inst.level = data.level
			applyupgrades(inst)
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			inst.components.health:DoDelta(0)
		end
	end
end

local function OnSave(inst, data)
	data.level = inst.level
	data.charge_time = inst.charge_time
end

local function onbecamehuman(inst)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "ratchet_speed_mod", 1)
	applyupgrades(inst)	
end

local function onbecameghost(inst)
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "ratchet_speed_mod")
end

local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local function CanDodge(inst)
	local rider = inst.replica.rider
	return (rider == nil or not rider:IsRiding()) and (GetTime() - inst.last_dodge_time > inst.dodge_cooldown)
end

local function GetPointSpecialActions(inst, pos, useitem, right)
    if right and CanDodge(inst) then
		return { ACTIONS.RATCHET_DODGE }
    end
    return {}
end

local function OnSetOwner(inst)
    if inst.components.playeractionpicker ~= nil then
        inst.components.playeractionpicker.pointspecialactionsfn = GetPointSpecialActions
    end
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "ratchet.tex" )
	inst:AddTag("fastbuilder")
	inst:AddTag("solana_galaxy_resident")
	inst:AddTag("veldin_mechanic")
	
	inst.dodgetime = net_bool(inst.GUID, "player.dodgetime", "dodgetimedirty")
	inst:ListenForEvent("dodgetimedirty", function()
		inst.last_dodge_time = GetTime()
	end)
	inst:ListenForEvent("setowner", OnSetOwner)
	inst.last_dodge_time = GetTime()
	inst.dodge_cooldown = 1
end

local master_postinit = function(inst)
	inst.level = 0
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	
	inst.soundsname = "wilson"
	
	inst.components.health:SetMaxHealth(TUNING.RATCHET_HEALTH)
	inst.components.hunger:SetMax(TUNING.RATCHET_HUNGER)
	inst.components.sanity:SetMax(TUNING.RATCHET_SANITY)
	
    inst.components.sanity:SetPlayerGhostImmunity(true)
    inst.components.sanity:SetNegativeAuraImmunity(true)
	
	inst.components.eater:SetOnEatFn(oneat)
	
    inst.components.combat.damagemultiplier = 1
	
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	inst.OnPreLoad = onpreload  
	inst.OnSave = OnSave
	
end

return MakePlayerCharacter("ratchet", prefabs, assets, common_postinit, master_postinit, prefabs)
