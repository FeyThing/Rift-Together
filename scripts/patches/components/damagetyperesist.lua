local SourceModifierList = require("util/sourcemodifierlist")

return function(self)
	self.conditional_tags = {}
	self.tags_to_remove = {}
	
	function self:AddConditionalResist(attacker_tag, inst_tag, src, pct, key, fn)
		local data = self.conditional_tags[attacker_tag]
		if data == nil then
			data = {}
			data.tag = inst_tag
			data.fn = fn
			data.modifier = SourceModifierList(self.inst)
			self.conditional_tags[attacker_tag] = data
		end
		if data.modifier ~= nil then
			data.modifier:SetModifier(src, pct, key)
		end
	end
	
	function self:RemoveConditionalResist(tag, src, key)
		local data = self.conditional_tags[tag]
		if data ~= nil and data.modifier ~= nil then
			data.modifier:RemoveModifier(src, key)
			if data.modifier:IsEmpty() then
				self.conditional_tags[tag] = nil
			end
		end
	end
	
	function self:AddConditionalTags()
		for k,v in pairs(self.conditional_tags) do
			if v.tag ~= nil and (v.fn == nil or v.fn(self.inst)) and not self.inst:HasTag(v.tag) then
				self.inst:AddTag(v.tag)
				table.insert(self.tags_to_remove, v.tag)
			end
		end
	end
	
	function self:RemoveConditionalTags()
		for k,v in pairs(self.tags_to_remove) do
			self.inst:RemoveTag(v)
		end
		
		self.tags_to_remove = {}
	end
	
	local _old_getresist = self.GetResist
	function self:GetResist(attacker, weapon, ...)
		if attacker ~= nil and attacker.components.damagetypebonus ~= nil then
			attacker.components.damagetypebonus:AddConditionalTags()
		end
		if weapon ~= nil and weapon.components.damagetypebonus ~= nil then
			weapon.components.damagetypebonus:AddConditionalTags()
		end
		
		local mult = _old_getresist(self, attacker, weapon, ...)
		
		if attacker ~= nil then
			for k,v in pairs(self.conditional_tags) do
				if (v.fn == nil or v.fn(self.inst)) and (attacker:HasTag(k) or (weapon ~= nil and weapon:HasTag(k))) then
					if v.modifier ~= nil then
						mult = mult * v.modifier:Get()
					end
				end
			end
		end
		
		if attacker ~= nil and attacker.components.damagetypebonus ~= nil then
			attacker.components.damagetypebonus:RemoveConditionalTags()
		end
		if weapon ~= nil and weapon.components.damagetypebonus ~= nil then
			weapon.components.damagetypebonus:RemoveConditionalTags()
		end
		
		return mult
	end
	
	local _old_onremovefromentity = self.OnRemoveFromEntity
	function self:OnRemoveFromEntity(...)
		if _old_onremovefromentity ~= nil then
			_old_onremovefromentity(self, ...)
		end
		
		self:RemoveConditionalTags()
	end
end
