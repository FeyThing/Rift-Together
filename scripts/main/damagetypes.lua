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

local TUNING = _G.TUNING

local function AddDefenseModifier(inst, tag, default_to_vulnerability)
	local mult = default_to_vulnerability and TUNING.ATTACKTYPE_VULNERABILITY_DEFAULT[tag] or TUNING.ATTACKTYPE_RESISTANCE_DEFAULT[tag]
	local key = "base_"..tag -- Example: "base_bludgeoning_attacktype"
	
	if TUNING.ATTACKTYPE_MODIFIERS[tag] ~= nil and TUNING.ATTACKTYPE_MODIFIERS[tag][inst.prefab] ~= nil then
		mult = TUNING.ATTACKTYPE_MODIFIERS[tag][inst.prefab]
	end
	
	if mult ~= nil then
		if inst.components.damagetyperesist == nil then
			inst:AddComponent("damagetyperesist")
		end
		inst.components.damagetyperesist:AddResist(tag, inst, mult, key)
		
		print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": "..tag.." x"..mult)
	end
end

local BASIC_WEAPON_TAGS = {
	"bludgeoning_attacktype",
	"piercing_attacktype",
	"slashing_attacktype",
}

local BASIC_WEAPON_TAG_OVERRIDE = {
	tentaclespike = "piercing_attacktype",
	ruins_bat = "bludgeoning_attacktype",
	glasscutter = "slashing_attacktype",
	houndstooth_proj = "piercing_attacktype",
	pocketwatch_weapon = "slashing_attacktype",
}

local function GetBasicWeaponTag(inst, weapon_cmp)
	if inst:HasOneOfTags(BASIC_WEAPON_TAGS) then
		return nil
	end
	
	if BASIC_WEAPON_TAG_OVERRIDE[inst.prefab] ~= nil then
		return BASIC_WEAPON_TAG_OVERRIDE[inst.prefab]
	end
	
	-- Ranged weapons
	if inst:HasTag("rangedweapon") or inst:HasTag("projectile") then
		if inst:HasTag("blowdart") then
			return "piercing_attacktype"
		elseif inst:HasTag("slingshotammo") then
			return "bludgeoning_attacktype"
		end
	-- Melee weapons
	else
		if inst:HasTag("pointy") or inst.components.terraformer ~= nil then
			return "piercing_attacktype"
		elseif inst:HasTag("sharp") or inst:HasTag("whip") then
			return "slashing_attacktype"
		else
			return "bludgeoning_attacktype"
		end
	end
end

local function WeaponAttackTags(inst, weapon_cmp)	
	if inst:HasTag("propweapon") then
		return -- Not a real weapon, no need to do anything
	end
	
	-- Basic attack type
	local basic_attacktype = GetBasicWeaponTag(inst, weapon_cmp)
	
	if basic_attacktype ~= nil then
		inst:AddTag(basic_attacktype)
		print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": "..basic_attacktype)
	end
	
	-- Elemental attack type
	if weapon_cmp.stimuli == "electric" then
		inst:AddTag("electric_attacktype")
		print("[RT] -DAMAGE TYPES TEST- "..inst.prefab..": electric_attacktype")
	end
	
	-- Shadow attack type (don't stack with existing multipliers?)
	if (inst:HasTag("shadow_item") or inst.prefab == "ruins_bat")
	and not (inst.components.damagetypebonus ~= nil and inst.components.damagetypebonus.tags["lunar_aligned"] ~= nil) then
		inst:AddTag("shadow_aligned")
	end
	-- to-do the Alarming Clock needs Shadow attack type only when fueled
end

local function ArmorDefenseModifiers(inst, armor_cmp)
end

local function EntityAttackTags(inst, combat_cmp)
	if inst:HasOneOfTags(BASIC_WEAPON_TAGS) or inst:HasTag("player") then
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
		AddDefenseModifier(inst, "bludgeoning_attacktype")
	elseif inst:HasTag("smallcreature")
	or inst:HasTag("small") then
		AddDefenseModifier(inst, "bludgeoning_attacktype", true)
	end
	
	-- Piercing
	
	-- Slashing
end

AddPrefabPostInitAny(function(inst)
	if not _G.TheWorld.ismastersim then
		return
	end
	
	local weapon_cmp = inst.components.weapon
	local armor_cmp = inst.components.armor
	local combat_cmp = inst.components.combat
	
	if weapon_cmp ~= nil or armor_cmp ~= nil then
		if weapon_cmp ~= nil then
			WeaponAttackTags(inst, weapon_cmp)
		end
		if armor_cmp ~= nil then
			ArmorDefenseModifiers(inst, armor_cmp)
		end
	elseif combat_cmp ~= nil then
		EntityAttackTags(inst, combat_cmp)
		EntityDefenseModifiers(inst, combat_cmp)
	end
end)