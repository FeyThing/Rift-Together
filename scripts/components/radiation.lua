local easing = require("easing")
local SourceModifierList = require("util/sourcemodifierlist")
local STATES = {
    NONE = 0,
    IRRITATED = 1,
    PAIN = 2,
    SUFFERING = 3,
    DYING = 4,
}

local function onmax(self, max)
    self.inst.replica.radiation:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.radiation:SetCurrent(current)
end

local function onratescale(self, ratescale)
    self.inst.replica.radiation:SetRateScale(ratescale)
end

local function ondying(self, dying)
    self.inst.replica.radiation:SetDying(dying)
end

local function onpenalty(self, penalty)
    self.inst.replica.radiation:SetPenalty(penalty)
end


local Radiation = Class(function(self, inst)
    self.inst = inst
    self.max = 100
    self.current = 0
	self.lastpos = Vector3(0, 0, 0)

    self.rate = 0
    self.ratescale = RATE_SCALE.NEUTRAL
    self.rate_modifier = 1
    
    self.dying = false
    self.resistance = 0.15
	
	self.maxDamageDeltaPerTick = -1

	self.externalmodifiers = SourceModifierList(self.inst, 0, SourceModifierList.additive)
    self.health_state = STATES.NONE
    self.penalty = 0

    self.radiation_penalties = {}

    self.custom_rate_fn = nil

    self._oldisdying = self:IsNotDying()
    self._oldpercent = self:GetPercent()
	
    
    self.inst:StartUpdatingComponent(self)
end,
nil,
{
    max = onmax,
    current = oncurrent,
    ratescale = onratescale,
    dying = ondying,
    penalty = onpenalty,
})


function Radiation:IsNotDying()
    return not self.dying
end

function Radiation:IsDying()
    return self.dying
end

function Radiation:AddPenalty(key, mod)
    self.radiation_penalties[key] = mod
    self:RecalculatePenalty()
end

function Radiation:RemovePenalty(key)
    self.radiation_penalties[key] = nil
    self:RecalculatePenalty()
end

function Radiation:RecalculatePenalty()
    local penalty = 0

    for k,v in pairs(self.radiation_penalties) do
        penalty = penalty + v
    end

    penalty = math.min(penalty, 1-(5/self.max))

    self.penalty = penalty

    self:DoDelta(0)
end

function Radiation:SetResistance(resistance)
    self.resistance = resistance
end

function Radiation:GetPenaltyPercent()
    return self.penalty
end

function Radiation:GetRealPercent()
    return self.current / self.max
end

function Radiation:GetPercent()
    return self:GetRealPercent()
end

function Radiation:GetPercentWithPenalty()
    return self.current / (self.max - (self.max * self.penalty))
end

function Radiation:SetPercent(per, overtime)
    local target = per * self.max
    local delta = target - self.current
    self:DoDelta(delta, overtime)
end

function Radiation:GetDebugString()
    return string.format("%2.2f / %2.2f at %2.4f. Penalty %2.2f", self.current, self.max, self.rate, self.penalty)
end

function Radiation:SetMax(amount)
    self.max = amount
    self.current = 0
    self:DoDelta(0)
end

function Radiation:GetMaxWithPenalty()
    return self.max - (self.max * self.penalty)
end

function Radiation:GetRateScale()
    return self.ratescale
end


function Radiation:DoDelta(delta, overtime)
    if self.redirect ~= nil then
        self.redirect(self.inst, delta, overtime)
        return
    end

    if self.ignore then
        return
    end	

    if self.current >= self:GetMaxWithPenalty() and delta >= 0 then
        self.current = self.current 
    else
        self.current = math.min(math.max(self.current + delta, 0), self.max)
    end

    self:TryAnnounce()
    if self.inst.AnimState then
        self.inst.AnimState:SetAddColour(0,Remap(self:GetPercent(),0,1,0,.65),0,1)
        if self:GetPercent() > .65 then
            self.inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        elseif self:GetPercent() < .35 then
            self.inst.AnimState:ClearBloomEffectHandle()
        end
        self.inst.AnimState:SetLightOverride(Remap(self:GetPercent(),0,1,0,.2))
    end
    if self.dying and self:GetPercent() <= TUNING.RADIATION_THRESH.DYING.PRE then --30
        self.dying = false
    elseif not self.dying and self:GetPercent() >= TUNING.RADIATION_THRESH.DYING.POST then --35
        self.dying = true
    end

    self.inst:PushEvent("radiationdelta", { oldpercent = self._oldpercent, newpercent = self:GetPercent(), overtime = overtime })

    -- Re-call GetPercent on the slight chance that "radiationdelta" changed it.
    self._oldpercent = self:GetPercent()
end

function Radiation:TryAnnounce()
    if self._oldpercent < self:GetPercent() then
        if self.health_state == STATES.SUFFERING and self:GetPercent() >= TUNING.RADIATION_THRESH.DYING.POST then
            self.inst:PushEvent("goingtodie")
            self.health_state = STATES.DYING
        elseif self.health_state == STATES.PAIN and self:GetPercent() >= TUNING.RADIATION_THRESH.SUFFERING.POST then
            self.inst:PushEvent("feelsuffering")
            self.health_state = STATES.SUFFERING
        elseif self.health_state == STATES.IRRITATED and self:GetPercent() >= TUNING.RADIATION_THRESH.PAIN.POST then
            self.inst:PushEvent("feelhardpain")
            self.health_state = STATES.PAIN
        elseif self.health_state == STATES.NONE and self:GetPercent() >= TUNING.RADIATION_THRESH.IRRITATED.POST then
            self.inst:PushEvent("feelirritation")
            self.health_state = STATES.IRRITATED
        end
    else
        if self.health_state == STATES.DYING and self:GetPercent() <= TUNING.RADIATION_THRESH.DYING.PRE then
            self.health_state = STATES.SUFFERING
        elseif self.health_state == STATES.SUFFERING and self:GetPercent() <= TUNING.RADIATION_THRESH.SUFFERING.PRE then
            self.health_state = STATES.PAIN
        elseif self.health_state == STATES.PAIN and self:GetPercent() <= TUNING.RADIATION_THRESH.PAIN.PRE then
            self.health_state = STATES.IRRITATED
        elseif self.health_state == STATES.IRRITATED and self:GetPercent() <= TUNING.RADIATION_THRESH.IRRITATED.PRE then
            self.health_state = STATES.NONE
        end
    end
end


function Radiation:OnUpdate(dt)
	local map = TheWorld.Map
	
    if not map then 
        return 
    end

	local x, y, z = self.inst.Transform:GetWorldPosition()
	local pos = Vector3(map:GetTileCenterPoint(x, y, z))
    local radiation = TheWorld.components.radiation_manager:GetRadiationAtPoint(pos.x, pos.y, pos.z)
	if self.current > 0 or radiation ~= 0 then
        self.lastpos = pos
        if not (self.inst.components.health:IsInvincible() or
                self.inst:HasTag("spawnprotection") or
				self.inst:HasTag("radiationimmunity") or
                self.inst.sg and self.inst.sg:HasStateTag("sleeping") or --need this now because you are no longer invincible during sleep
                self.inst.is_teleporting or
                (self.ignore and self.redirect == nil)) then
            self:Recalc(dt, radiation)
	if self.inst.components.health and not self.inst.components.health:IsDead() then
		if self:GetPercent() >= TUNING.RADIATION_THRESH.PAIN.POST then
		self.inst.components.health:DoDelta(self.maxDamageDeltaPerTick * dt, true, "physical")
		end	
	end
        else
            --Disable arrows
            self.rate = 0
            self.ratescale = RATE_SCALE.NEUTRAL
        end
	end
end

function Radiation:Recalc(dt, radiation)
    self.rate = (radiation + self.externalmodifiers:Get() - self.resistance) * self.rate_modifier

    local prc = self.rate/10
    self.ratescale =
        (prc > .5 and RATE_SCALE.INCREASE_HIGH) or
        (prc > .2 and RATE_SCALE.INCREASE_MED) or
        (prc > .01 and RATE_SCALE.INCREASE_LOW) or
        (prc < -.3 and RATE_SCALE.DECREASE_HIGH) or
        (prc < -.1 and RATE_SCALE.DECREASE_MED) or
        (prc < -.01 and RATE_SCALE.DECREASE_LOW) or
        RATE_SCALE.NEUTRAL

    self:DoDelta(self.rate * dt, true)
end

function Radiation:OnSave()
    return
    {
        current = self.current,
        dying = self.dying,
    }
end

function Radiation:OnLoad(data)
    if data.dying ~= nil then
        self.dying = data.dying
    end

    if data.current ~= nil then
        self.current = data.current
    end
    self:DoDelta(1)
end

function Radiation:TransferComponent(newinst)
    local newcomponent = newinst.components.radiation
    newcomponent:SetPercent(self:GetPercent())
end

Radiation.LongUpdate = Radiation.OnUpdate

return Radiation
