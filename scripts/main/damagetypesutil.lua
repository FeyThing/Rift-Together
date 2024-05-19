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



local PHYSICAL_TYPES = {
	bludgeoning = true,
	piercing = true,
	slashing = true,
}

local function IsPhysical(type)
	return PHYSICAL_TYPES[type] == true
end

local MAGICAL_TYPES = {
	shadow = true,
	lunar = true,
}

local function IsMagical(type)
	return MAGICAL_TYPES[type] == true
end

local TAG_SWAPS = {
	shadow_aligned = "shadow",
	lunar_aligned = "lunar",
}

local function ShouldSwapTag(tag)
	return TAG_SWAPS[tag]
end



local function GetMult(inst, tuning, type)
	return tuning[type] ~= nil and (tuning[type][inst.prefab] or tuning[type].DEFAULT) or 1
end



---- Defense modifiers

local function AddDefenseModifier(inst, type, mult, condition)
	local key = "base_"..type -- Example: "base_bludgeoning"
	
	if inst.components.damagetyperesist == nil then
		inst:AddComponent("damagetyperesist")
	end
	inst.components.damagetyperesist:RT_AddMult(type, mult, key, condition)
	
	print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": Incoming "..type.." x"..mult)
end

local function AddResistance(inst, type, condition)
	local mult = GetMult(inst, TUNING.DAMAGETYPE_RESISTANCE, type)
	
	AddDefenseModifier(inst, type, mult, condition)
end

local function AddVulnerability(inst, type, condition)
	local mult = GetMult(inst, TUNING.DAMAGETYPE_VULNERABILITY, type)
	
	AddDefenseModifier(inst, type, mult, condition)
end



---- Attack modifiers

local function AddAttackModifier(inst, type, mult, condition)
	local key = "base_"..type -- Example: "base_bludgeoning"
	
	if inst.components.damagetypebonus == nil then
		inst:AddComponent("damagetypebonus")
	end
	inst.components.damagetypebonus:RT_AddMult(type, mult, key, condition)
	
	print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": Outgoing "..type.." x"..mult)
end

local function AddBonus(inst, type, condition)
	local mult = GetMult(inst, TUNING.DAMAGETYPE_BONUS, type)
	
	AddAttackModifier(inst, type, mult, condition)
end



---- For AddPrefabPostInitAny

local BASIC_WEAPON_TYPE_OVERRIDE = {
	tentaclespike = "piercing",
	ruins_bat = "bludgeoning",
	glasscutter = "slashing",
	houndstooth_proj = "piercing",
}

local function GetBasicWeaponModifier(inst, weapon_cmp)
	if BASIC_WEAPON_TYPE_OVERRIDE[inst.prefab] ~= nil then
		return BASIC_WEAPON_TYPE_OVERRIDE[inst.prefab]
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
	
	--[[ Shadow attack type (don't stack with existing multipliers?)
	if (inst:HasTag("shadow_item") or inst.prefab == "ruins_bat")
	and not (inst.components.damagetypebonus ~= nil and inst.components.damagetypebonus.tags["lunar_aligned"] ~= nil) then
		AddBonus(inst, "shadow")
	end]]
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
	IsPhysical = IsPhysical,
	IsMagical = IsMagical,
	ShouldSwapTag = ShouldSwapTag,
	
	AddDefenseModifier = AddDefenseModifier,
	AddResistance = AddResistance,
	AddVulnerability = AddVulnerability,
	
	AddAttackModifier = AddAttackModifier,
	AddBonus = AddBonus,
	
	GetBasicWeaponModifier = GetBasicWeaponModifier,
	WeaponAttackModifiers = WeaponAttackModifiers,
	
	ArmorDefenseModifiers = ArmorDefenseModifiers,
	
	EntityAttackModifiers = EntityAttackModifiers,
	EntityDefenseModifiers = EntityDefenseModifiers,
	
	SkipAutomatic = SkipAutomatic,
	ShouldSkip = ShouldSkip,
}