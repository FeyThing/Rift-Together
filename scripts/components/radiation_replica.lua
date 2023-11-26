local function SetDirty(netvar, val)
    --Forces a netvar to be dirty regardless of value
    netvar:set_local(val)
    netvar:set(val)
end

local Radiation = Class(function(self, inst)
    self.inst = inst

    self._isdying = net_bool(inst.GUID, "radiation._isdying")
    if inst:HasTag('player') then
        self.radfx = SpawnPrefab("radiation_dust")
        self.radfx.entity:SetParent(inst.entity)
        self.radfx.particles_per_tick = 200
        self.radfx:PostInit()
    end

    self.inst:DoTaskInTime(0, function()
        if TheWorld.ismastersim then
            self.classified = inst.player_classified
        elseif self.classified == nil and inst.player_classified ~= nil then
            self:AttachClassified(inst.player_classified)
        end
    end)
end)

--------------------------------------------------------------------------

function Radiation:OnRemoveFromEntity()
    if self.classified ~= nil then
        if TheWorld.ismastersim then
            self.classified = nil
        else
            self.inst:RemoveEventCallback("onremove", self.ondetachclassified, self.classified)
            self:DetachClassified()
        end
    end
end

Radiation.OnRemoveEntity = Radiation.OnRemoveFromEntity

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
    return self.classified.radiationpenalty:value() / 200
end

local function MaxWithPenalty_Client(self)
    --V2C: precision error.. gg...
    --return self.classified.maxradiation:value() * (1 - GetPenaltyPercent_Client(self))
    return self.classified.maxradiation:value() * (200 - self.classified.radiationpenalty:value()) / 200
end

--------------------------------------------------------------------------

function Radiation:SetCurrent(current)
    if self.classified ~= nil then
        self.classified.currentradiation:set(current)
    end
end

function Radiation:SetMax(max)
    if self.classified ~= nil then
        self.classified.maxradiation:set(max)
    end
end

function Radiation:SetPenalty(penalty)
    if self.classified ~= nil then
        assert(penalty >= 0 and penalty <= 1, "Player radiationpenalty out of range "..tostring(penalty))
        self.classified.radiationpenalty:set(math.floor(penalty * 200 + .5))
    end
end

function Radiation:Max()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation.max
    elseif self.classified ~= nil then
        return self.classified.maxradiation:value()
    else
        return 100
    end
end

function Radiation:MaxWithPenalty()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetMaxWithPenalty()
    elseif self.classified ~= nil then
        return MaxWithPenalty_Client(self)
    else
        return 100
    end
end

function Radiation:GetPercent()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetPercent()
    end
    return self:GetPercentNetworked()
end

function Radiation:GetPercentNetworked()
    --Use networked value whether we are server or client
    return self.classified ~= nil and self.classified.currentradiation:value() / self.classified.maxradiation:value() or 1
end

function Radiation:GetCurrent()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation.current
    elseif self.classified ~= nil then
        return self.classified.currentradiation:value()
    else
        return 100
    end
end

function Radiation:GetPercentWithPenalty()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetPercentWithPenalty()
    elseif self.classified ~= nil then
        return self.classified.currentradiation:value() / MaxWithPenalty_Client(self)
    else
        return 1
    end
end

function Radiation:GetPenaltyPercent()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetPenaltyPercent()
    elseif self.classified ~= nil then
        return GetPenaltyPercent_Client(self)
    else
        return 0
    end
end

function Radiation:SetRateScale(ratescale)
    if self.classified ~= nil then
        self.classified.radiationratescale:set(ratescale)
    end
end

function Radiation:GetRateScale()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetRateScale()
    elseif self.classified ~= nil then
        return self.classified.radiationratescale:value()
    else
        return RATE_SCALE.NEUTRAL
    end
end

function Radiation:SetDying(dying)
    self._isdying:set(dying)
end

function Radiation:IsNotDying()
    return not self._isdying:value()
end

function Radiation:IsDying()
    return self._isdying:value()
end

return Radiation