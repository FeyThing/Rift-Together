local SourceModifierList = require("util/sourcemodifierlist")

local function onmax(self, max)
    self.inst.replica.radiation:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.radiation:SetCurrent(current)
end

local function onratescale(self, ratescale)
    self.inst.replica.radiation:SetRateScale(ratescale)
end

local function onpenalty(self, penalty)
    self.inst.replica.radiation:SetPenalty(penalty)
end

local Radiation = Class(function(self, inst)
    self.inst = inst
    self.max = 100
    self.current = 0

    self.rate = 0
    self.falloff = -0.04
    self.externalmodifiers_multiply = SourceModifierList(self.inst, 1, SourceModifierList.multiply)
    self.ratescale = RATE_SCALE.NEUTRAL 
    self.resistance = 0
    self.radiation_sources = {  } -- To calculate self.rate

    self.ignore = false

    self.penalty = 0
    self.radiation_penalties = {  }

    self._oldpercent = self:GetPercent()

    self.inst:AddTag("radiation")

    self.inst:StartUpdatingComponent(self)
end,
nil,
{
    max = onmax,
    current = oncurrent,
    ratescale = onratescale,
    penalty = onpenalty
})

function Radiation:OnRemoveFromEntity()
    if self.inst.AnimState then
        self.inst.AnimState:SetAddColour(0, 0, 0, 1)
        self.inst.AnimState:ClearBloomEffectHandle()
        self.inst.AnimState:SetLightOverride(0)
    end
end

function Radiation:AddPenalty(key, mod)
    mod = math.clamp(mod, 0, 1)
    if mod == 0 then
        return
    end
    
    self.radiation_penalties[key] = mod
    self:RecalculatePenalty()
end

function Radiation:RemovePenalty(key)
    self.radiation_penalties[key] = nil
    self:RecalculatePenalty()
end

function Radiation:RecalculatePenalty()
    local penalty = 0

    for _, val in pairs(self.radiation_penalties) do
        penalty = penalty + val
    end

    self.penalty = math.min(penalty, 1 - (5/self.max))

    self:DoDelta(0)
end

function Radiation:SetResistance(resistance)
    self.resistance = resistance
end

function Radiation:GetPenaltyPercent()
    return self.penalty
end

function Radiation:GetPercent()
    return self.current / self.max
end

function Radiation:GetPercentWithPenalty()
    return self.current / (self.max - (self.max*self.penalty))
end

function Radiation:SetPercent(per, overtime)
    local delta = per*self.max - self.current
    self:DoDelta(delta, overtime)
end

function Radiation:GetDebugString()
    return string.format("%2.2f / %2.2f at %2.4f. Penalty %2.2f", self.current, self.max, self.rate, self.penalty)
end

function Radiation:SetMax(amount)
    local old_percent = self:GetPercent()
    self.max = amount
    self.current = old_percent * amount
    self:DoDelta(0, true)
end

function Radiation:SetIgnore(val)
    self.ignore = val
end

function Radiation:GetMaxWithPenalty()
    return self.max - (self.max * self.penalty)
end

function Radiation:GetRateScale()
    return self.ratescale
end

function Radiation:DoDelta(delta, overtime)
    if self.ignore then
        return
    end

    self._oldpercent = self:GetPercent()
    self.current = math.clamp(self.current + delta, 0, self.max - (self.max*self.penalty))

    self:TryAnnounce()

    -- LukaS: -[TODO]- Revamp the radiation visual effects
    if self.inst.AnimState then
        self.inst.AnimState:SetAddColour(0, Remap(self:GetPercent(), 0, 1, 0, 0.65), 0, 1)
        if self:GetPercent() > 0.65 then
            self.inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        elseif self:GetPercent() < 0.35 then
            self.inst.AnimState:ClearBloomEffectHandle()
        end

        self.inst.AnimState:SetLightOverride(Remap(self:GetPercent(), 0, 1, 0, 0.2))
    end

    self.inst:PushEvent("radiationdelta", { oldpercent = self._oldpercent, newpercent = self:GetPercent(), overtime = overtime })
end

function Radiation:TryAnnounce()
    if self._oldpercent < self:GetPercent() then
        if self._oldpercent < TUNING.RADIATION_THRESH.CRITICAL.ENTER and self:GetPercent() >= TUNING.RADIATION_THRESH.CRITICAL.ENTER then
            self.inst:PushEvent("goingtodie")
        elseif self._oldpercent < TUNING.RADIATION_THRESH.HIGH.ENTER and self:GetPercent() >= TUNING.RADIATION_THRESH.HIGH.ENTER then
            self.inst:PushEvent("feelsuffering")
        elseif self._oldpercent < TUNING.RADIATION_THRESH.MED.ENTER and self:GetPercent() >= TUNING.RADIATION_THRESH.MED.ENTER then
            self.inst:PushEvent("feelhardpain")
        elseif self._oldpercent < TUNING.RADIATION_THRESH.LOW.ENTER and self:GetPercent() >= TUNING.RADIATION_THRESH.LOW.ENTER then
            self.inst:PushEvent("feelirritation")
        end
    end
end

function Radiation:OnUpdate(dt)
    if not (self.inst.components.health and self.inst.components.health:IsInvincible() or
    self.inst:HasTag("spawnprotection") or
    self.inst.is_teleporting or -- Teleportato ?
    self.ignore) then
        self:Recalc(dt)
        
        -- if self.inst.components.health and not self.inst.components.health:IsDead() then
        --     -- LukaS: -[TODO]- Revamp the radiation DOT
        --     if self:GetPercent() >= TUNING.RADIATION_THRESH.HIGH.POST then
        --         self.inst.components.health:DoDelta(self.maxDamageDeltaPerTick * dt, true, "radiation")
        --     end
        -- end
    else
        self.rate = 0
        self.ratescale = RATE_SCALE.NEUTRAL -- Disable arrows
    end
end

function Radiation:Recalc(dt)
    local rad_aura = 0

    -- Per tile radiation delta
    local x, y, z = self.inst.Transform:GetWorldPosition()
    local tile_rad = TheWorld.components.radiationmanager:GetAtPoint(x, y, z)
    if tile_rad > 0 and self.current < tile_rad then
        local diff_factor = 1 - (self.current/tile_rad)*0.75
        rad_aura = rad_aura + tile_rad*TUNING.TILE_RAD_INTAKE_FACTOR*diff_factor
    end

    -- Per source radiation delta
    for source, _ in pairs(self.radiation_sources) do
        if source:IsValid() then -- Can be invalid if it gets removed
            local distsq = self.inst:GetDistanceSqToInst(source)
            local radiussq = source.components.radiationsource.radius*source.components.radiationsource.radius
            if distsq <= radiussq then
                local dist_factor = 1 - (distsq/radiussq)
                rad_aura = rad_aura + source.components.radiationsource.radiation_amount*dist_factor
            end
        end
    end

    -- Per radioactive inventory item
    if self.inst.components.inventory then
        for i, item in ipairs(self.inst.components.inventory:ReferenceAllItems()) do
            if item:IsValid() and item.components.radiationsource then
                rad_aura = rad_aura + item.components.radiationsource.radiation_amount
            end
        end
    end

    self.rate = rad_aura*self.externalmodifiers_multiply:Get()

    if self.rate > 0 then
        self.rate = self.rate*(1 - self.resistance)
    elseif self.current > 0 then
        self.rate = self.rate + self.falloff
    end

    local new_ratescale = (self.rate > 0.4 and RATE_SCALE.INCREASE_HIGH) or
                          (self.rate > 0.2 and RATE_SCALE.INCREASE_MED) or
                          (self.rate > 0.05 and RATE_SCALE.INCREASE_LOW) or
                          (self.rate < -0.8 and RATE_SCALE.DECREASE_HIGH) or
                          (self.rate < -0.3 and RATE_SCALE.DECREASE_MED) or
                          (self.rate < -0.1 and RATE_SCALE.DECREASE_LOW) or -- LukaS: -0.09 to catch the self.falloff decrease
                           RATE_SCALE.NEUTRAL

    if self.ratescale ~= new_ratescale then
        self.ratescale = new_ratescale
    end

    if self.rate ~= 0 then
        self:DoDelta(self.rate*dt, true)
    end
end

function Radiation:OnSave()
    return { current = self.current }
end

function Radiation:OnLoad(data)
    if data.current then
        self.current = data.current
    end
end

function Radiation:TransferComponent(newinst)
    local newcomponent = newinst.components.radiation
    newcomponent:SetPercent(self:GetPercent())
end

Radiation.LongUpdate = Radiation.OnUpdate

return Radiation