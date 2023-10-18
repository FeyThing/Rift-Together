local applyupgrades = require "storage.nefarious_applyupgrades"


local function oneat(inst, food)
	
	--- Checks to see if energy is under 100 and allows nefarious to gain 2 energy from eating food
	
	if food and food.components.edible then
	inst.components.nefarious_energy:DoDelta(2);
	end
	
	--- This is compatibility with the Ratchet mod's nanodrinks, which triggers a level up and status upgrades
	
	if food and food.components.edible and food.prefab == "nanoboost" then
		inst.level = inst.level + 1
		applyupgrades(inst)	
		inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
		inst.components.hunger:DoDelta(70);
		inst.components.health:DoDelta(70);
		inst.components.sanity:DoDelta(50);
	end
end
	


return oneat