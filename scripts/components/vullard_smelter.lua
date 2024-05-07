local Smelter = require "main/smelterrecipe"

local function OnCheckReady(inst)
	local self = inst.components.vullard_smelter
	
	if self ~= nil then
		if self:IsSmelting() then
			self:StopSmelting(true)
		end
		
		if Smelter.IsReadyToSmelt(inst) then
			inst:AddTag("readytosmelt")
		else
			inst:RemoveTag("readytosmelt")
		end
		
	end
end

local Vullard_Smelter = Class(function(self, inst)
	self.inst = inst
	
	self.targettime = nil
	self.task = nil
	self.smelttimemult = 1
	
	self.onstartsmelting = nil
	self.onstopsmelting = nil
	self.ondonesmelting = nil
	
	inst:ListenForEvent("itemget", OnCheckReady)
	inst:ListenForEvent("itemlose", OnCheckReady)
	inst:ListenForEvent("stacksizechange", OnCheckReady)
	
	inst:AddTag("vullard_smelter")
end)

function Vullard_Smelter:OnRemoveFromEntity()
	self.inst:RemoveTag("vullard_smelter")
	self.inst:RemoveTag("readytosmelt")
end

local function DoSmelt(inst, self)
	self.task = nil
	self.targettime = nil
	
	local isready, data = Smelter.IsReadyToSmelt(self.inst)
	
	if isready then
		Smelter.DoSmelt(inst, data)
	end
	
	self.inst.components.container.canbeopened = true
	
	if self.ondonesmelting ~= nil then
		self.ondonesmelting(inst)
	end
end

function Vullard_Smelter:IsSmelting()
	return self.targettime ~= nil
end

function Vullard_Smelter:GetTimeToSmelt()
	return self.targettime ~= nil and self.targettime - GetTime() or 0
end

function Vullard_Smelter:CanSmelt()
	return Smelter.IsReadyToSmelt(self.inst)
end

function Vullard_Smelter:StartSmelting(doer)
	if self.targettime == nil and self.inst.components.container ~= nil then
		if self.onstartsmelting ~= nil then
			self.onstartsmelting(self.inst)
		end
		
		local smelttime = TUNING.VULLARD_SMELTER_SMELT_TIME * self.smelttimemult
		self.targettime = GetTime() + smelttime
		
		if self.task ~= nil then
			self.task:Cancel()
		end
		self.task = self.inst:DoTaskInTime(smelttime, DoSmelt, self)
		
		self.inst.components.container:Close()
		self.inst.components.container.canbeopened = false
		
		self.inst:RemoveTag("readytosmelt")
	end
end

function Vullard_Smelter:StopSmelting(fromcheck)
	if self.task ~= nil then
		self.task:Cancel()
		self.task = nil
	end
	self.targettime = nil
	
	self.inst.components.container.canbeopened = true
	
	if not fromcheck then
		OnCheckReady(self.inst)
	end
	
	if self.onstopsmelting ~= nil then
		self.onstopsmelting(self.inst)
	end
end

function Vullard_Smelter:OnSave()
	local remainingtime = self.targettime ~= nil and self.targettime - GetTime() or 0
	
	return {
		remainingtime = remainingtime > 0 and remainingtime or nil,
	}
end

function Vullard_Smelter:OnLoad(data)
	if data.remainingtime ~= nil then
		if self.task ~= nil then
			self.task:Cancel()
			self.task = nil
		end
		
		self.targettime = GetTime() + math.max(0, data.remainingtime)
		self.task = self.inst:DoTaskInTime(data.remainingtime, DoSmelt, self)
		
		if self.inst.components.container ~= nil then
			self.inst.components.container.canbeopened = false
		end
	end
end

function Vullard_Smelter:GetDebugString()
	local status = self:IsSmelting() and "SMELTING" or "EMPTY"
	
	return string.format("%s timetosmelt: %.2f", status, self:GetTimeToSmelt())
end

function Vullard_Smelter:LongUpdate(dt)
	if self:IsSmelting() then
		if self.task ~= nil then
			self.task:Cancel()
		end
		if self.targettime - dt > GetTime() then
			self.targettime = self.targettime - dt
			self.task = self.inst:DoTaskInTime(self.targettime - GetTime(), DoSmelt, self)
		else
			DoSmelt(self.inst, self)
		end
	end
end

return Vullard_Smelter
