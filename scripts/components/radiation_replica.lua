local function SetDirty(netvar, val)
    --Forces a netvar to be dirty regardless of value
    netvar:set_local(val)
    netvar:set(val)
end

local function OnRadiationDelta(parent, data)
    if data.overtime then

    elseif data.newpercent > data.oldpercent then
        SetDirty(parent.player_classified.isradiationpulseup, true)
    elseif data.newpercent < data.oldpercent then
        SetDirty(parent.player_classified.isradiationpulsedown, true)
    end
end

local function OnRadiationDirty(self)
    local oldpercent = self._oldradiationpercent
    local percent = self.currentradiation:value() / self.maxradiation:value()
    local data =
    {
        oldpercent = oldpercent,
        newpercent = percent,
        overtime =
            not (self.isradiationpulseup:value() and percent > oldpercent) and
            not (self.isradiationpulsedown:value() and percent < oldpercent),
    }
    self._oldradiationpercent = percent
    self.isradiationpulseup:set_local(false)
    self.isradiationpulsedown:set_local(false)
    self.inst:PushEvent("radiationdelta", data)
end

local function RegisterNetListeners_local(self)
    self.inst:ListenForEvent("radiationdirty", function() OnRadiationDirty(self) end)
end


local function RegisterNetListeners(self)
    self.isradiationpulseup:set_local(false)
    self.isradiationpulsedown:set_local(false)
    RegisterNetListeners_local(self)
    --fns.OnInitialDirtyStates(inst)
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
    
    self._oldradiationpercent = 1
    self.currentradiation = net_ushortint(self.inst.GUID, "radiation.current", "radiationdirty")
    self.maxradiation = net_ushortint(self.inst.GUID, "radiation.max", "radiationdirty")
    self.radiationpenalty = net_byte(self.inst.GUID, "radiation.penalty", "radiationdirty")
    self.radiationratescale = net_tinybyte(self.inst.GUID, "radiation.ratescale")
    self.isradiationpulseup = net_bool(self.inst.GUID, "radiation.dodeltaovertime(up)", "radiationdirty")
    self.isradiationpulsedown = net_bool(self.inst.GUID, "radiation.dodeltaovertime(down)", "radiationdirty")
    self.currentradiation:set(100)
    self.maxradiation:set(100)

    inst:DoStaticTaskInTime(0, function() RegisterNetListeners(self) end)
end)

--------------------------------------------------------------------------

--------------------------------------------------------------------------
--Client helpers

local function GetPenaltyPercent_Client(self)
    return self.radiationpenalty:value() / 200
end

local function MaxWithPenalty_Client(self)
    --V2C: precision error.. gg...
    --return self.maxradiation:value() * (1 - GetPenaltyPercent_Client(self))
    return self.maxradiation:value() * (200 - self.radiationpenalty:value()) / 200
end

--------------------------------------------------------------------------

function Radiation:SetCurrent(current)
    self.currentradiation:set(current)
end

function Radiation:SetMax(max)
    self.maxradiation:set(max)
end

function Radiation:SetPenalty(penalty)
    assert(penalty >= 0 and penalty <= 1, "Player radiationpenalty out of range "..tostring(penalty))
    self.radiationpenalty:set(math.floor(penalty * 200 + .5))
end

function Radiation:Max()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation.max
    else
        return self.maxradiation:value() or 100
    end
end

function Radiation:MaxWithPenalty()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetMaxWithPenalty()
    else
        return MaxWithPenalty_Client(self) or 100
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
    return self.currentradiation:value() / self.maxradiation:value() or 1
end

function Radiation:GetCurrent()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation.current
    else
        return self.currentradiation:value() or 100
    end
end

function Radiation:GetPercentWithPenalty()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetPercentWithPenalty()
    else
        return self.currentradiation:value() / MaxWithPenalty_Client(self) or 1
    end
end

function Radiation:GetPenaltyPercent()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetPenaltyPercent()
    else
        return GetPenaltyPercent_Client(self) or 0
    end
end

function Radiation:SetRateScale(ratescale)
    self.radiationratescale:set(ratescale)
end

function Radiation:GetRateScale()
    if self.inst.components.radiation ~= nil then
        return self.inst.components.radiation:GetRateScale()
    else
        return self.radiationratescale:value() or RATE_SCALE.NEUTRAL
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