local RadiationImmunity = Class(function(self, inst)
	self.inst = inst
	self.sources = {}

	self._onremovesource = function(src)
		self.sources[src] = nil
		if next(self.sources) == nil then
			inst:RemoveComponent("radiationimmunity")
		end
	end
end)

function RadiationImmunity:OnRemoveFromEntity()
	self.inst:RemoveTag("radiationimmunity")

	for src in pairs(self.sources) do
		self:RemoveSource_Internal(src)
	end
end

function RadiationImmunity:AddSource(src)
	if not self.sources[src] then
		if next(self.sources) == nil then
			self.inst:AddTag("radiationimmunity")
		end
		self.sources[src] = true
		if src ~= self.inst then
			self.inst:ListenForEvent("onremove", self._onremovesource, src)
		end

		if self.inst.components.radiation ~= nil then
			self.inst.components.radiation:ForceDecay(true, src)
		end
	end
end

function RadiationImmunity:RemoveSource_Internal(src)
	--V2C: this is here and not in the _onremovesource because
	--     radiation component force dry already handles source
	--     "onremove" on its own.
	if self.inst.components.radiation ~= nil then
		self.inst.components.radiation:ForceDecay(false, src)
	end

	if src ~= self.inst then
		self.inst:RemoveEventCallback("onremove", self._onremovesource, src)
	end
end

function RadiationImmunity:RemoveSource(src)
	if self.sources[src] then
		self:RemoveSource_Internal(src)
		self._onremovesource(src)
	end
end

return RadiationImmunity
