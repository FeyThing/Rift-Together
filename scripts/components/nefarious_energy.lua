--[[function AddReplicableComponent(nefarious_energy)
	REPLICABLE_COMPONENTS[nefarious_energy] = true
end]]

local function onmax(self, max)
    -- self.inst.replica.nefarious_energy:SetMax(max)
end

local function oncurrent(self, current)
    -- self.inst.replica.nefarious_energy:SetCurrent(current)
end

local function OnTaskTick(inst, self, period)
	if(self.current > self.max) then
		self.current = self.max
	end
    self:DoDelta(TUNING.NEFARIOUS_ENERGY_COST)
end

local nefarious_energy = Class(function(self, inst)
    self.inst = inst
	self.max = TUNING.NEFARIOUS_ENERGY
	self.current = 0
    self.min = 0
	self.infinite = false
	if TheWorld.ismastersim then
		local period = 1
		self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	end
end,
nil,
{
	max = onmax,
    current = oncurrent,
})




function nefarious_energy:OnSave()
	return {
		max = self.max,
		current = self.current,
	}
end

function nefarious_energy:OnLoad(data)
	if TUNING.NEFARIOUS_ENERGY ~= nil then
		self.max = TUNING.NEFARIOUS_ENERGY
		self:DoDelta(0)
	end
    if data.current ~= nil then
        self.current = data.current
        self:DoDelta(0)
    elseif data.percent ~= nil then
        self:SetPercent(data.percent, true)
        self:DoDelta(0)
    end
end

function nefarious_energy:LongUpdate(dt)
	self:DoDelta((dt))
end

function nefarious_energy:GetPercent()
    return self.current / self.max
end

function nefarious_energy:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function nefarious_energy:SetCurrent(amount)
	self:DoDelta(amount)
end


function nefarious_energy:SetMax(amount)
    self.max = amount
    self.current = amount
end

function nefarious_energy:DoDelta(delta, overtime)

    local old = self.current
	local new = math.clamp(self.current + delta, self.min, self.max)
	
	self.current = new
	self.inst:PushEvent("nefarious_energy_delta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
	
	if self.current > self.max then 
		self.current = self.max 
	end
end
function nefarious_energy:DoDec(dt)
        if self.current > 0 then
            self:DoDelta(-1 * dt , true)
        end
end

function nefarious_energy:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("nefarious_energy_delta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
end


return nefarious_energy