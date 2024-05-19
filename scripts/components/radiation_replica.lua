local Radiation = Class(function(self, inst)
    self.inst = inst

    if inst:HasTag("player") then
        self.radfx = SpawnPrefab("radiation_dust")
        self.radfx.entity:SetParent(inst.entity)
        self.radfx.particles_per_tick = 200
        self.radfx:PostInit()
    end

    if TheWorld.ismastersim then
        self.classified = inst.player_classified
    elseif self.classified == nil and inst.player_classified then
        self:AttachClassified(inst.player_classified)
    end
end)

function Radiation:AttachClassified(classified)
    self.classified = classified
    self.ondetachclassified = function() self:DetachClassified() end
    self.inst:ListenForEvent("onremove", self.ondetachclassified, classified)
end

function Radiation:DetachClassified()
    self.classified = nil
    self.ondetachclassified = nil
end

--------------------------------------------------------------------------
--Client helpers
local function GetPenaltyPercent_Client(self)
    return self.classified.radiationpenalty:value() / 200 -- Why 200 tho? o_◦
end

local function MaxWithPenalty_Client(self)
    --V2C: precision error.. gg...
    --return self.maxradiation:value() * (1 - GetPenaltyPercent_Client(self))
    return self.classified.maxradiation:value() * (200 - self.classified.radiationpenalty:value()) / 200
end

--------------------------------------------------------------------------

function Radiation:SetCurrent(current)
    if self.classified then
        self.classified.currentradiation:set(current)
    end
end

function Radiation:SetMax(max)
    if self.classified then
        self.classified.maxradiation:set(max)
    end
end

function Radiation:SetPenalty(penalty)
    if self.classified then
        assert(penalty >= 0 and penalty <= 1, "Player radiationpenalty out of range "..tostring(penalty))
        self.classified.radiationpenalty:set(math.floor(penalty * 200 + 0.5))
    end
end

function Radiation:Max()
    if self.inst.components.radiation then
        return self.inst.components.radiation.max
    elseif self.classified then
        return self.classified.maxradiation:value() or 100
    else
        return 100
    end
end

function Radiation:MaxWithPenalty()
    if self.inst.components.radiation then
        return self.inst.components.radiation:GetMaxWithPenalty()
    elseif self.classified then
        return MaxWithPenalty_Client(self) or 100
    else
        return 100
    end
end

function Radiation:GetPercent()
    if self.inst.components.radiation then
        return self.inst.components.radiation:GetPercent()
    elseif self.classified then
        return self:GetPercentNetworked()
    else
        return 1
    end
end

function Radiation:GetPercentNetworked()
    --Use networked value whether we are server or client
    return self.classified.currentradiation:value() / self.classified.maxradiation:value() or 1
end

function Radiation:GetCurrent()
    if self.inst.components.radiation then
        return self.inst.components.radiation.current
    elseif self.classified then
        return self.classified.currentradiation:value() or 100
    else
        return 100
    end
end

function Radiation:GetPercentWithPenalty()
    if self.inst.components.radiation then
        return self.inst.components.radiation:GetPercentWithPenalty()
    elseif self.classified then
        return self.classified.currentradiation:value() / MaxWithPenalty_Client(self) or 1
    else
        return 1
    end
end

function Radiation:GetPenaltyPercent()
    if self.inst.components.radiation then
        return self.inst.components.radiation:GetPenaltyPercent()
    elseif self.classified then
        return GetPenaltyPercent_Client(self) or 0
    else
        return 0
    end
end

function Radiation:SetRateScale(ratescale)
    if self.classified then
        self.classified.radiationratescale:set(ratescale)
    end
end

function Radiation:GetRateScale()
    if self.inst.components.radiation then
        return self.inst.components.radiation:GetRateScale()
    elseif self.classified then
        return self.classified.radiationratescale:value() or RATE_SCALE.NEUTRAL
    else
        return RATE_SCALE.NEUTRAL
    end
end

return Radiation