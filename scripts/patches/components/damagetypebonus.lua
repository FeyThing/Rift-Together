local SourceModifierList = require("util/sourcemodifierlist")
local DamageType = require("main/damagetype")
local DamageTypesUtil = require("main/damagetypesutil")

return function(self)
	self.rt_types = {}
	
	-- Our own special kind of bonus for our special damage types
	-- Doing it through damagetypebonus (and damagetyperesist) because these components are called by Klei in convenient places
	-- Includes a fn check if the bonus isn't always supposed to work (a lot simpler than having to hook into stategraphs and all of that)
	function self:RT_AddMult(type, mult, key, checkfn)
		local dmgtype = self.rt_types[type]
		if dmgtype == nil then
			dmgtype = DamageType(self.inst)
			self.rt_types[type] = dmgtype
		end
		dmgtype:AddModifier(mult, key, checkfn)
	end
	
	function self:RT_RemoveMult(type, key)
	local dmgtype = self.rt_types[type]
		if dmgtype ~= nil then
			dmgtype:RemoveModifier(key)
			if dmgtype:IsEmpty() then
				self.rt_types[type] = nil
			end
		end
	end
	
	-- Swap a vanilla tag into our damage type, we can use it for example to turn any "shadow_aligned" bonus into our "shadow" damage type
	local _old_addbonus = self.AddBonus
	function self:AddBonus(tag, src, pct, key, ...)
		local type = DamageTypesUtil.ShouldSwapTag(tag)
		
		if type ~= nil then
			self:RT_AddMult(type, pct, key)
		else
			_old_addbonus(self, tag, src, pct, key, ...)
		end
	end
	
	local _old_removebonus = self.RemoveBonus
	function self:RemoveBonus(tag, src, key, ...)
		local type = DamageTypesUtil.ShouldSwapTag(tag)
		
		if type ~= nil then
			self:RT_RemoveMult(type, key)
		else
			_old_removebonus(self, tag, src, key, ...)
		end
	end
	
	-- Hook into GetBonus to do our intended behavior
	local _old_getbonus = self.GetBonus
	function self:GetBonus(target, ...)
		local mult = _old_getbonus(self, target, ...)
		
		-- Our system relies on the target having damagetyperesist!
		if target ~= nil and target.components.damagetyperesist ~= nil then
			for type,dmgtype in pairs(self.rt_types) do
				local rt_mult = dmgtype:Get()
				-- An attack being effective means the defense multiplier is above 1 (takes more damage from it)
				if target.components.damagetyperesist:RT_IsAttackEffective(type) then
					mult = mult * rt_mult
				end
			end
		end
		
		return mult
	end
	
	-- Defense being effective means the attack type corresponds to the defense (so it gets reduced/amplified accordingly)
	function self:RT_IsDefenseEffective(type, mult)
		
		local dmgtype = self.rt_types[type]
		
		if dmgtype ~= nil then
			-- If the type of resistance (mult less than 1) is physical and we have an active magic bonus, ignore the resistance
			if mult < 1 and DamageTypesUtil.IsPhysical(type) then
				for t,dt in pairs(self.rt_types) do
					if DamageTypesUtil.IsMagical(t) then
						for key,data in pairs(dt.modifiers) do
							if data.checkfn == nil or data.checkfn(self.inst) then
								return false
							end
						end
					end
				end
			end
			
			-- Otherwise only check if we have an active damage type of the same type
			for key,data in pairs(dmgtype.modifiers) do
				if data.checkfn == nil or data.checkfn(self.inst) then
					return true
				end
			end
		end
		
		return false
	end
end