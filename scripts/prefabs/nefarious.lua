local MakePlayerCharacter = require "prefabs/player_common"
local applyupgrades = require "storage.nefarious_applyupgrades"
local oneat = require "storage.nefarious_oneat"
local onsciondeath = require "storage.nefarious_onsciondeath"
local noarmor = require "storage.nefarious_noarmor"
--- For neatness sake, I put some functions in the my custom storage folder and is pulling from them

local assets = {
        Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

}

local prefabs = {
}

-- Custom starting items
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.nefarious = {		
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.nefarious
end
local prefabs = FlattenTree(start_inv, true)

local function onpreload(inst, data)
	if data then
		if data.level then
			inst.level = data.level
			applyupgrades(inst)
			--re-set these from the save data, because of load-order clipping issues
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			if data.hunger and data.hunger.hunger then inst.components.hunger.current = data.hunger.hunger end
			if data.sanity and data.sanity.current then inst.components.sanity.current = data.sanity.current end
			inst.components.health:DoDelta(0)
			--inst.components.hunger:DoDelta(0)
			--inst.components.sanity:DoDelta(0)
		end
	end
end

local function OnSave(inst, data)
--- we need to store nefarious's energy and level    
	data.level = inst.level
	data.charge_time = inst.charge_time
	end


-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set upgrades so you keep them even after death
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "nefarious_speed_mod", 1)
	applyupgrades(inst)	
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "nefarious_speed_mod")
end

-- When loading or spawning the character
local function onload(inst,data)
---we load up nefarious's stored energy

    --if data and data.energy then
	--	inst.energy:set(data.energy)
	--end
	inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
	end
	   

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "nefarious.tex" )
	
	
	--inst:SetStateGraph("SGannihilator")
	
	--- Untangled that wild nest down there, and made a seperate file that pulls from storage/nefarious_noarmor.
	inst:AddTag("solana_galaxy_resident")
	inst:AddTag("robot")
	
	inst:AddComponent("nefkeyhandler")
	inst.components.nefkeyhandler:AddActionListener("nefarious", TUNING.STEALTH.KEY, "STEALTH")
    inst.components.nefkeyhandler:AddActionListener("nefarious", TUNING.COMBAT.KEY, "COMBAT")
	inst.components.nefkeyhandler:AddActionListener("nefarious", TUNING.SHIELDING.KEY, "SHIELDING")
end


-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)

    inst.level = 0
	
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	-- choose which sounds this character will play	
	inst.soundsname = "wilson"
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	-- Stats	
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
    inst:ListenForEvent("entity_death", function(wrld, data) onsciondeath(inst, data) end, TheWorld)
end


return MakePlayerCharacter("nefarious", prefabs, assets, common_postinit, master_postinit, prefabs)
