local DamageTypes = require("main/damagetypes")

return function(inst)
	-- Radiation immunity
	if inst:IsValid() and inst.components and inst.components.health and inst:HasTag("lunar_aligned") then
		inst:AddTag("radiationimmunity")
	end
	
    --CLIENT
    if not TheWorld.ismastersim then
        return
    end
	
	-- Radiation
	if inst:IsValid() and inst.components and inst.components.health and not inst.components.radiation then
		inst:AddComponent("radiation")
		inst.components.radiation:SetMax(TUNING.CHARACTERS_RADIATION.WILSON)
	end
	
	-- Damage types
	if not DamageTypes.ShouldSkip(inst) then
		local weapon_cmp = inst.components.weapon
		local armor_cmp = inst.components.armor
		local combat_cmp = inst.components.combat
		
		if weapon_cmp ~= nil or armor_cmp ~= nil then
			if weapon_cmp ~= nil then
				DamageTypes.WeaponAttackModifiers(inst, weapon_cmp)
			end
			if armor_cmp ~= nil then
				DamageTypes.ArmorDefenseModifiers(inst, armor_cmp)
			end
		elseif combat_cmp ~= nil then
			DamageTypes.EntityAttackModifiers(inst, combat_cmp)
			DamageTypes.EntityDefenseModifiers(inst, combat_cmp)
		end
	end
end