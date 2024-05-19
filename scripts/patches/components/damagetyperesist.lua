local SourceModifierList = require("util/sourcemodifierlist")
local DamageType = require("main/damagetype")

return function(self)
	self.rt_types = {}
	
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
	
	local _old_addresist = self.AddResist
	function self:AddResist(tag, src, pct, key, ...)
		local type = DamageTypesUtil.ShouldSwapTag(tag)
		
		if type ~= nil then
			self:RT_AddMult(type, pct, key)
		else
			_old_addresist(self, tag, src, pct, key, ...)
		end
	end
	
	local _old_removeresist = self.RemoveResist
	function self:RemoveResist(tag, src, key, ...)
		local type = DamageTypesUtil.ShouldSwapTag(tag)
		
		if type ~= nil then
			self:RT_RemoveMult(type, key)
		else
			_old_removeresist(self, tag, src, key, ...)
		end
	end
	
	local _old_getresist = self.GetResist
	function self:GetResist(attacker, weapon, ...)
		local mult = _old_getresist(self, attacker, weapon, ...)
		
		local target = weapon or attacker
		
		if target ~= nil and target.components.damagetypebonus ~= nil then
			for type,dmgtype in pairs(self.rt_types) do
				local rt_mult = dmgtype:Get()
				if target.components.damagetypebonus:RT_IsDefenseEffective(type, rt_mult) then
					mult = mult * rt_mult
				end
			end
		end
		
		return mult
	end
	
	function self:RT_IsAttackEffective(type)
		local dmgtype = self.rt_types[type]
		
		if dmgtype ~= nil then
			local mult = dmgtype:Get()
			
			if mult > 1 then
				return true
			end
		end
		
		return false
	end
end