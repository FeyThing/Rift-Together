---- Damage Types
-- Blugeoning - Objects such as hammers, tools, most of walter's  slingshot ammo, tooth traps, wolfgang dumbells, fists, or creatures that attempts to charge/pummel/ or stomp on you.
-- Piercing - Objects such as spears, tentacle spike, blow darts, fencing sword, tridents, cactus pricks and any creature that tries to bite.
-- Slashing- Objects such as Swords, scythes, and creatures that attempt to maul with claws.
-- Fire - Being exposed to lava, fire staff, torch, lighter and walking into a fire. Overheating does not count as fire damage.
-- Electricity - Getting struck by lightning, the morning star,  jolted by volt goats, and triggering the robomutt's electrical discharge.
-- Ice - Being frozen, ice staff, and taking damage from freezing effects.
-- Lunar - This is already ingame, we just need it to be fleshed out with the other damage types.
-- Shadow - Same case with Lunar.

---- Resistances
-- Bludgeoning - Shadows. Larger creatures take less damage from being hit with this type.
-- Piercing - Shadows and Gestalts. Creatures such as bees, mosquitoes and anything smaller than your average rabbit is resistant.
-- Slashing - Shadows. Any creature that has a thick shell, hide or is metal.
-- Fire - Creatures of the element of fire such as firehounds, Dfly, etc are resistant to ice and should be immune to being frozen.
-- Electricity - Clockworks and robotic contraptions don't take as much eletrical damage and can sometimes be empowered by it.
-- Ice - Resistant to bludgeoning, due to the hardiness of the ice element.
-- Lunar - Resist all blugeoning, piercing and slashing
-- Shadow - Resist all blugeoning, piercing and slashing

---- Vulnerabilities
-- Bludgeoning - Smaller unarmored creatures hurt more.
-- Piercing - Shelled, fish, and scaled creatures hurt.
-- Slashing - Plant-like creatures.
-- Fire - Fire creatures are special and become vulnerable when they are wet. There is no flat elemental water damage that exposes them yet.
-- Electricity - Can't think of anything.
-- Ice - Vulnerable to fire.
-- Lunar - To Shadow
-- Shadow - To Lunar



local PREFAB_SKIP_DAMAGE_TYPES = {}

local function SkipAutomatic(prefab_name)
	PREFAB_SKIP_DAMAGE_TYPES[prefab_name] = true
end

local function ShouldSkip(inst)
	return PREFAB_SKIP_DAMAGE_TYPES[inst.prefab] == true
end



local function GetAttackTag(type)
	return type.."_attack"
end

local function GetDefenseTag(type)
	return type.."_vulnerable"
end

local function GetMult(inst, tuning, tag)
	return tuning[tag] ~= nil and (tuning[tag][inst.prefab] or tuning[tag].DEFAULT) or 1
end

local ALLEGIANCE_TAGS = {
	shadow_aligned = true,
	lunar_aligned = true,
}

local ALLEGIANCE_TAGS_OPPOSITE = {
	shadow_aligned = "lunar_aligned",
	lunar_aligned = "shadow_aligned",
}

local function IsAllegianceTag(tag)
	return ALLEGIANCE_TAGS[tag] ~= nil
end

local function GetOppositeAllegiance(tag)
	return ALLEGIANCE_TAGS_OPPOSITE[tag]
end



---- Defense modifiers

local function AddDefenseModifier(inst, attack_tag, defense_tag, mult, condition)
	local key = "base_"..attack_tag -- Example: "base_bludgeoning_attack"
	
	if inst.components.damagetyperesist == nil then
		inst:AddComponent("damagetyperesist")
	end
	if condition ~= nil then
		inst.components.damagetyperesist:AddConditionalResist(attack_tag, defense_tag, inst, mult, key, condition)
	else
		inst.components.damagetyperesist:AddResist(attack_tag, inst, mult, key)
	end
end

local function AddResistance(inst, type, condition)
	local attack_tag = GetAttackTag(type)
	local mult = GetMult(inst, TUNING.DAMAGETYPE_RESISTANCE, attack_tag)
	
	if mult ~= nil and mult ~= 1 then
		AddDefenseModifier(inst, attack_tag, nil, mult, condition)
	end
	
	print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": "..attack_tag.." x"..mult)
end

local function AddAllegianceResistance(inst, tag, condition)
	if IsAllegianceTag(tag) then
		local attack_tag = tag
		local mult = GetMult(inst, TUNING.DAMAGETYPE_RESISTANCE, attack_tag)
		
		if mult ~= nil and mult ~= 1 then
			AddDefenseModifier(inst, attack_tag, nil, mult, condition)
		end
		
		print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": "..attack_tag.." x"..mult)
	end
end

local function AddVulnerability(inst, type, condition)
	local attack_tag = GetAttackTag(type)
	local defense_tag = GetDefenseTag(type)
	local mult = GetMult(inst, TUNING.DAMAGETYPE_VULNERABILITY, attack_tag)
	
	if condition == nil then
		inst:AddTag(defense_tag)
	end
	
	if mult ~= nil and mult ~= 1 then
		AddDefenseModifier(inst, attack_tag, defense_tag, mult, condition)
	end
	
	print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": "..attack_tag.." x"..mult)
end

local function AddAllegianceVulnerability(inst, tag, condition, do_opposite)
	if IsAllegianceTag(tag) then
		local attack_tag = tag
		local defense_tag = (do_opposite and inst.components.armor ~= nil) and GetOppositeAllegiance(tag) or nil
		local mult = GetMult(inst, TUNING.DAMAGETYPE_VULNERABILITY, attack_tag)
		
		if defense_tag ~= nil and condition == nil then
			inst:AddTag(defense_tag)
		end
		
		if mult ~= nil and mult ~= 1 then
			AddDefenseModifier(inst, attack_tag, defense_tag, mult, condition)
		end
		
		print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": "..attack_tag.." x"..mult)
	end
end



---- Attack modifiers

local function AddAttackModifier(inst, attack_tag, defense_tag, mult, condition)
	local key = "base_"..defense_tag -- Example: "base_bludgeoning_vulnerable"
	
	if inst.components.damagetypebonus == nil then
		inst:AddComponent("damagetypebonus")
	end
	if condition ~= nil then
		inst.components.damagetypebonus:AddConditionalBonus(defense_tag, attack_tag, inst, mult, key, condition)
	else
		inst.components.damagetypebonus:AddBonus(defense_tag, inst, mult, key)
	end
end

local function AddBonus(inst, type, condition)
	local attack_tag = GetAttackTag(type)
	local defense_tag = GetDefenseTag(type)
	local mult = GetMult(inst, TUNING.DAMAGETYPE_BONUS, defense_tag)
	
	if condition == nil then
		inst:AddTag(attack_tag)
	end
	
	if mult ~= nil and mult ~= 1 then
		AddAttackModifier(inst, attack_tag, defense_tag, mult, condition)
	end
	
	print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": "..defense_tag.." x"..mult)
end

local function AddAllegianceBonus(inst, tag, condition, do_opposite)
	if IsAllegianceTag(tag) then
		local attack_tag = (do_opposite and inst.components.weapon ~= nil) and GetOppositeAllegiance(tag) or nil
		local defense_tag = tag
		local mult = GetMult(inst, TUNING.DAMAGETYPE_BONUS, defense_tag)
		
		if attack_tag ~= nil and condition == nil then
			inst:AddTag(attack_tag)
		end
		
		if mult ~= nil and mult ~= 1 then
			AddAttackModifier(inst, attack_tag, defense_tag, mult, condition)
		end
		
		print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": "..defense_tag.." x"..mult)
	end
end



---- For AddPrefabPostInitAny

local BASIC_WEAPON_TAG_OVERRIDE = {
	tentaclespike = "piercing",
	ruins_bat = "bludgeoning",
	glasscutter = "slashing",
	houndstooth_proj = "piercing",
}

local function GetBasicWeaponModifier(inst, weapon_cmp)
	if BASIC_WEAPON_TAG_OVERRIDE[inst.prefab] ~= nil then
		return BASIC_WEAPON_TAG_OVERRIDE[inst.prefab]
	end
	
	-- Ranged weapons
	if inst:HasTag("rangedweapon") or inst:HasTag("projectile") then
		if inst:HasTag("blowdart") then
			return "piercing"
		elseif inst:HasTag("slingshotammo") then
			return "bludgeoning"
		end
	-- Melee weapons
	else
		if inst:HasTag("pointy") or inst.components.terraformer ~= nil then
			return "piercing"
		elseif inst:HasTag("sharp") or inst:HasTag("whip") then
			return "slashing"
		else
			return "bludgeoning"
		end
	end
end

local function WeaponAttackModifiers(inst, weapon_cmp)	
	if inst:HasTag("propweapon") then
		return
	end
	
	-- Basic attack type
	local basic_attack = GetBasicWeaponModifier(inst, weapon_cmp)
	
	if basic_attack ~= nil then
		AddBonus(inst, basic_attack)
	end
	
	-- Elemental attack type
	if weapon_cmp.stimuli == "electric" then
		AddBonus(inst, "electric")
	end
	
	-- Shadow attack type (don't stack with existing multipliers?)
	if (inst:HasTag("shadow_item") or inst.prefab == "ruins_bat")
	and not (inst.components.damagetypebonus ~= nil and inst.components.damagetypebonus.tags["lunar_aligned"] ~= nil) then
		AddAllegianceBonus(inst, "lunar_aligned", nil, true)
	end
end

local function ArmorDefenseModifiers(inst, armor_cmp)
end

local function EntityAttackModifiers(inst, combat_cmp)
	if inst:HasTag("player") then
		return
	end
end

local function EntityDefenseModifiers(inst, combat_cmp)
	-- Bludgeoning
	if inst:HasTag("shadow")
	or inst:HasTag("shadowminion")
	or inst:HasTag("shadowchesspiece")
	or inst:HasTag("large")
	or inst:HasTag("largecreature") then
		AddResistance(inst, "bludgeoning")
	elseif inst:HasTag("smallcreature")
	or inst:HasTag("small") then
		AddVulnerability(inst, "bludgeoning")
	end
	
	-- Piercing
	
	-- Slashing
end



return {
	AddDefenseModifier = AddDefenseModifier,
	AddResistance = AddResistance,
	AddAllegianceResistance = AddAllegianceResistance,
	AddVulnerability = AddVulnerability,
	AddAllegianceVulnerability = AddAllegianceVulnerability,
	
	AddAttackModifier = AddAttackModifier,
	AddBonus = AddBonus,
	AddAllegianceBonus = AddAllegianceBonus,
	
	GetBasicWeaponModifier = GetBasicWeaponModifier,
	WeaponAttackModifiers = WeaponAttackModifiers,
	ArmorDefenseModifiers = ArmorDefenseModifiers,
	EntityAttackModifiers = EntityAttackModifiers,
	EntityDefenseModifiers = EntityDefenseModifiers,
	
	SkipAutomatic = SkipAutomatic,
	ShouldSkip = ShouldSkip,
}