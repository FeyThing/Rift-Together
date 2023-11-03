local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
        Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

}

local prefabs = {
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.NEFARIOUS
end
local prefabs = FlattenTree(start_inv, true)

local function applyupgrades(inst)
	local max_upgrades = 10
	local upgrades = math.min(inst.level, max_upgrades)

	local health_percent = inst.components.health:GetPercent()
	inst.components.health.maxhealth = math.ceil (200 + upgrades * 10) --250
	
		
	inst.components.talker:Say("Level : ".. (inst.level))
	
	if inst.level >9 then
		inst.components.talker:Say("Level : Max!")
	end

	inst.components.health:SetPercent(health_percent)
end

local function oneat(inst, food)
	if food and food.components.edible then
		inst.components.nefarious_energy:DoDelta(2)
	end
	
	if food and food.components.edible and food.prefab == "nanoboost" then
		inst.level = inst.level + 1
		applyupgrades(inst)	
		inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
		inst.components.hunger:DoDelta(70)
		inst.components.health:DoDelta(70)
		inst.components.sanity:DoDelta(50)
	end
end

local function noarmor(inst)
	local _Equip = inst.components.inventory.Equip	
	
	inst.components.inventory.Equip = function(self, item, old_to_active)
		if not item or not item.components.equippable or not item:IsValid() then
			return		
		end		
		
		if item.components.equippable.equipslot == EQUIPSLOTS.HEAD and not (item.prefab == "ruinshat") and not (item.prefab == "flowerhat") and not (item.prefab == "eyebrellahat") and not (item.prefab == "kelphat") and not (item.prefab == "respiratormask") 
		or item.components.equippable.equipslot == EQUIPSLOTS.BODY and item.components.armor then		
			self:DropItem(item)
			self:GiveItem(item)
			if inst and inst.components.talker then
				inst.components.talker:Say("Bah, does it look like that fits me?")
			end
			return
		end		
		return _Equip(self, item, old_to_active)
	end
end
local function onpreload(inst, data)
	if data then
		if data.level then
			inst.level = data.level
			applyupgrades(inst)
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			if data.hunger and data.hunger.hunger then inst.components.hunger.current = data.hunger.hunger end
			if data.sanity and data.sanity.current then inst.components.sanity.current = data.sanity.current end
			inst.components.health:DoDelta(0)
		end
	end
end

local function OnSave(inst, data)
	data.level = inst.level
	data.charge_time = inst.charge_time
end


local function onbecamehuman(inst)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "nefarious_speed_mod", 1)
	applyupgrades(inst)	
end

local function onbecameghost(inst)
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "nefarious_speed_mod")
end

local function onload(inst,data)
	inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "nefarious.tex" )
	
	inst:AddTag("solana_galaxy_resident")
	inst:AddTag("robot")
	inst:AddTag("chesskiller")
end

local master_postinit = function(inst)
    inst.level = 0
	
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	inst.soundsname = "wilson"
	
	inst.customidleanim = "idle_wilson"

	inst.components.health:SetMaxHealth(TUNING.NEFARIOUS_HEALTH)
	inst.components.hunger:SetMax(TUNING.NEFARIOUS_HUNGER)
	inst.components.sanity:SetMax(TUNING.NEFARIOUS_SANITY)
	
	inst.components.eater:SetOnEatFn(oneat)
	inst.components.eater.strongstomach = true
	
	inst.components.sanity.night_drain_mult = 1
	
	inst:AddTag("mechagenius")
	
	-- Damage multiplier (optional)
	inst.components.health.absorb = (TUNING.NEFARIOUS_HEALTH_ABSORB)
    inst.components.combat.damagemultiplier = 1	
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = .2 * TUNING.WILSON_HUNGER_RATE
	inst.components.builder.science_bonus = 1

	noarmor(inst)

	inst.OnLoad = onload
	inst.OnSave = OnSave
    inst.OnNewSpawn = onload
	inst.OnPreLoad = onpreload 
end


return MakePlayerCharacter("nefarious", prefabs, assets, common_postinit, master_postinit, prefabs)
