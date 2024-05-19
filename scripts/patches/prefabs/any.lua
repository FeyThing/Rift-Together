local DamageTypesUtil = require("main/damagetypesutil")

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
	if not DamageTypesUtil.ShouldSkip(inst) then
		local weapon_cmp = inst.components.weapon
		local armor_cmp = inst.components.armor
		local combat_cmp = inst.components.combat
		
		if weapon_cmp ~= nil or armor_cmp ~= nil then
			-- Doing weapon and armor together because items like the Shield of Terror exist
			if weapon_cmp ~= nil then
				DamageTypesUtil.WeaponAttackModifiers(inst, weapon_cmp)
			end
			if armor_cmp ~= nil then
				DamageTypesUtil.ArmorDefenseModifiers(inst, armor_cmp)
			end
		elseif combat_cmp ~= nil then
			DamageTypesUtil.EntityAttackModifiers(inst, combat_cmp)
			DamageTypesUtil.EntityDefenseModifiers(inst, combat_cmp)
		end
	end
end