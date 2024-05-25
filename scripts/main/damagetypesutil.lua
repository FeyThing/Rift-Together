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

-- Bonus tag swaps are inverted, because if something does more to lunar_aligned then it's doing shadow damage in our system
local BONUS_TAG_SWAPS = {
	shadow_aligned = "lunar",
	lunar_aligned = "shadow",
}

local function ShouldBonusSwapTag(tag)
	return BONUS_TAG_SWAPS[tag]
end

local RESIST_TAG_SWAPS = {
	shadow_aligned = "shadow",
	lunar_aligned = "lunar",
}

local function ShouldSwapResistTag(tag)
	return RESIST_TAG_SWAPS[tag]
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
	
	-- Shadow attack type
	if (inst:HasTag("shadow_item") or inst.prefab == "ruins_bat")
	-- Make sure it doesn't have a bonus already (existing shadow weapons that had a bonus against lunar_aligned are swapped to our system automatically)
	and not (inst.components.damagetypebonus ~= nil and inst.components.damagetypebonus.rt_types["shadow"] ~= nil) then
		AddBonus(inst, "shadow")
	end
end

local function ArmorDefenseModifiers(inst, armor_cmp)
end

local function IsLarge(inst)
	return inst:HasTag("large")
		or inst:HasTag("largecreature")
		or inst:HasTag("epic") -- Bosses
end

local function IsTiny(inst)
	return not IsLarge(inst)
		and (inst.prefab == "mandrake_active"
		or inst:HasTag("insect")
		or inst:HasTag("NET_workable") -- Catchable by a Bug Net
		or inst:HasTag("stunnedbybomb") -- Stunned by a Seed Shell, typically only catchable critters
		or inst:HasTag("frog")
		or inst:HasTag("smallbird"))
end

local function IsScaled(inst)
	return inst.prefab == "wormwood_fruitdragon"
		or inst:HasTag("fish")
		or inst:HasTag("pondfish")
		or inst:HasTag("oceanfish")
		or inst:HasTag("merm")
		or inst:HasTag("fruitdragon")
		or inst:HasTag("gnarwail")
		or inst:HasTag("dragonfly")
		or inst:HasTag("malbatross")
		or inst:HasTag("hutch")
end

local function IsShelled(inst)
	return inst.prefab == "lightcrab"
		or inst:HasTag("cookiecutter")
		or inst:HasTag("crabking")
		or inst:HasTag("rocky") -- Rock Lobster
end

local function IsMetal(inst)
	return inst:HasTag("chess")
		or inst:HasTag("mech")
		or inst:HasTag("engineering")
end

local function IsPlant(inst)
	return inst.prefab == "carrat"
		or inst.prefab == "wormwood_carrat"
		or inst.prefab == "wormwood_fruitdragon"
		or inst.prefab == "mandrake_active"
		or inst:HasTag("veggie")
		or inst:HasTag("plant")
		or inst:HasTag("tree")
		or inst:HasTag("fruitdragon")
		or inst:HasTag("lightflier")
		or inst:HasTag("grassgekko")
		or inst:HasTag("grassgator")
		or inst:HasTag("fruitfly")
		or inst:HasTag("friendlyfruitfly")
end

local function IsHideThick(inst)
	return inst:HasTag("merm")
		or inst:HasTag("walrus")
		or inst:HasTag("gnarwail")
		or inst:HasTag("bearger")
		or inst:HasTag("minotaur")
		or inst:HasTag("toadstool")
end

local function IsShadow(inst)
	return inst:HasTag("shadow")
		or inst:HasTag("shadowminion")
		or inst:HasTag("shadowchesspiece")
		or inst:HasTag("stalker")
		or inst:HasTag("stalkerminion")
		or inst:HasTag("shadowthrall")
end

local function EntityAttackModifiers(inst, combat_cmp)
	if inst:HasTag("player") then
		return
	end
end

local function EntityDefenseModifiers(inst, combat_cmp)
	if inst:HasTag("player") then
		return
	end

	-- Bludgeoning
	if IsLarge(inst) or IsShadow(inst) then
		AddResistance(inst, "bludgeoning")
	elseif IsTiny(inst) or inst:HasTag("spider") then
		AddVulnerability(inst, "bludgeoning")
	end
	
	-- Piercing
	if IsTiny(inst) or IsShadow(inst) then
		AddResistance(inst, "piercing")
	elseif IsScaled(inst) or IsShelled(inst) then
		AddVulnerability(inst, "piercing")
	end
	
	-- Slashing
	if IsShelled(inst) or IsHideThick(inst) or IsMetal(inst) or IsShadow(inst) then
		AddResistance(inst, "slashing")
	elseif IsPlant(inst) or inst:HasTag("beaverchewable") then
		AddVulnerability(inst, "slashing")
	end
end



return {
	IsPhysical = IsPhysical,
	IsMagical = IsMagical,
	ShouldBonusSwapTag = ShouldBonusSwapTag,
	ShouldSwapResistTag = ShouldSwapResistTag,
	
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