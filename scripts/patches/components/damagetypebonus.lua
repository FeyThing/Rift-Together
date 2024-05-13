local SourceModifierList = require("util/sourcemodifierlist")

return function(self)
	self.conditional_tags = {}
	self.tags_to_remove = {}
	
	-- Conditional bonus: only works when fn passes
	-- Having a fn check is a lot simpler than having to hook into stategraphs and all of that
	function self:AddConditionalBonus(target_tag, inst_tag, src, pct, key, fn)
		local data = self.conditional_tags[target_tag]
		if data == nil then
			data = {}
			data.tag = inst_tag
			data.fn = fn
			data.modifier = SourceModifierList(self.inst)
			self.conditional_tags[target_tag] = data
		end
		if data.modifier ~= nil then
			data.modifier:SetModifier(src, pct, key)
		end
	end
	
	function self:RemoveConditionalBonus(tag, src, key)
		local data = self.conditional_tags[tag]
		if data ~= nil and data.modifier ~= nil then
			data.modifier:RemoveModifier(src, key)
			if data.modifier:IsEmpty() then
				self.conditional_tags[tag] = nil
			end
		end
	end
	
	-- Conditional tags are for damagetyperesist, added before GetResist runs so that the tag checks pass as intended
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
	
	-- Hook into GetBonus and add our behavior as intended
	local _old_getbonus = self.GetBonus
	function self:GetBonus(target, ...)
		if target ~= nil and target.components.damagetyperesist ~= nil then
			target.components.damagetyperesist:AddConditionalTags()
		end
		
		local mult = _old_getbonus(self, target, ...)
		
		if target ~= nil then
			for k,v in pairs(self.conditional_tags) do
				if (v.fn == nil or v.fn(self.inst)) and target:HasTag(k) then
					if v.modifier ~= nil then
						mult = mult * v.modifier:Get()
					end
				end
			end
		end
		
		if target ~= nil and target.components.damagetyperesist ~= nil then
			target.components.damagetyperesist:RemoveConditionalTags()
		end
		
		return mult
	end
	
	-- Just in case remove the conditional tags when the component is removed from an entity
	-- Shouldn't be needed but better be safe than sorry!
	local _old_onremovefromentity = self.OnRemoveFromEntity
	function self:OnRemoveFromEntity(...)
		if _old_onremovefromentity ~= nil then
			_old_onremovefromentity(self, ...)
		end
		
		self:RemoveConditionalTags()
	end
end