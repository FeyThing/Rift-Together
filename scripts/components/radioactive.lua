local function DefaultRadAttackFn(inst, target)
	if target.components.radiation then
		target.components.radiation:DoDelta()
	end
end


local Radioactive = Class(function(self, inst)	
    self.inst = inst
	self.aura = 0
	
    self.radiation = true
    self.radsfn = nil
	self.equippedrads = nil
	self.equippedradsfn = nil
	self.carriedrads = nil
	self.carriedradsfn = nil
	self.carriedradsmultiplier = 1
	
	self.onradattackfn = DefaultRadAttackFn


	
    --V2C: Recommended to explicitly add tag to prefab pristine state
	inst:AddTag("HASRADIOACTIVE")
end)

function Radioactive:OnRemoveFromEntity()
    self.inst:RemoveTag("HASRADIOACTIVE")
end

---Affects players that equip or possess radioactive material--

function Radioactive:GetRads(observer)
	if self.radsfn then
		return self.radsfn(self.inst, observer)
	end
	return self.radiation
end

function Radioactive:GetEquippedRads(observer)
	if self.equippedradsfn then
		return self.equippedradsfn(self.inst, observer)
	end
	return self.equippedrads
end

function Radioactive:GetCarriedRads(observer)
	if self.carriedradsfn then
		return self.carriedradsfn(self.inst, observer), self.carriedradsmultiplier
	end
	return self.carriedrads, self.carriedradsmultiplier
end

function Radioactive:GetDebugString()
	return string.format("radiation: %s carriedrads: %s",
			self.radsfn and "<fn>" or self.radiation or "<nil>",
			self.carriedradsfn and "<fn>" or self.carriedrads or "<nil>",
			self.equippedradsfn and "<fn>" or self.equippedrads or "<nil>"
			)
end


--Irriated attacks--

function Radioactive:SetOnRadAttackFn(onradattackfn)
	self.onradattackfn = onradattackfn
end

--Radiation aura--

function Radioactive:GetAura(observer)
	local aura_val = 0
	local distsq = observer:GetDistanceSqToInst(self.inst)
	if distsq <= (self.max_distsq or (TUNING.RAD_EFFECT_RANGE*TUNING.RAD_EFFECT_RANGE)) then
	    aura_val = (self.aurafn == nil and self.aura or self.aurafn(self.inst, observer)) / (self.fallofffn ~= nil and self.fallofffn(self.inst, observer, distsq) or math.max(1, distsq))
	end
    return aura_val
end



--[[function Radioactive:StartSpreading(duration)
	self.duration = duration or 0
	self.spreading = true
	if self.duration > 0 then
		self.start_time = GetTime()
	end
	
	self:DoRads()
	if not self.task then
		self.task = self.inst:DoPeriodicTask(TUNING.AREA_RAD_CHECK_INTERVAL, function() self:DoRads() end)
	end
end

function Radioactive:StopSpreading()
	self.spreading = false
	self.start_time = nil
	
	if self.task then
		self.task:Cancel()
		self.task = nil
	end
end

function Radioactive:DoRads(oneoff)
	if self.duration > 0 and GetTime() - self.start_time > self.duration then
		self:StopSpreading()
		return
	end

	if (self.spreading or oneoff) and self.radrange > 0 then
		-- in here we are targeting other entities and damaging them
		local pos = Vector3(self.inst.Transform:GetWorldPosition())
		local prop_range = self.radrange
		local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, prop_range, {"radiation"})
		
		for k,v in pairs(ents) do
			if not v:IsInLimbo() then
				if v ~= self.inst and v.components.radiation then
					if self.onradattackfn then
						self.onradattackfn(self.inst, v)
					end
				end
			end
		end
	end
end

function Radioactive:OnSave()    
	return 
	{
		timeleft = self.start_time and self.duration - (GetTime() - self.start_time) or nil,
	}
end

function Radioactive:OnLoad(data)
	if data.timeleft then
		self:StartSpreading(data.timeleft)
	end
end]]




return Radioactive