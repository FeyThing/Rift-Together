local easing = require("easing")
local SourceModifierList = require("util/sourcemodifierlist")

--[[local RAD_SOURCE = "radiation"

local function onirradiated(self, radiation)
    if self.inst.player_classified ~= nil then
       self.inst.player_classified.radiation:set(radiation)
    end
end

local function onratescale(self, ratescale)
    if self.inst.player_classified ~= nil then
        self.inst.player_classified.radiationratescale:set(ratescale)
    end
end

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
end]]



local function Healthy(food)
    return food ~= nil and
	(food.prefab:match("cutlichen") or
 	food.prefab:match("succulent_picked"))
end


--Eating irradiated food is dangerous!
local function OnEat(inst, data)
	local food = data.food
       	if --[[(food:HasTag("edible") and]] (food:HasTag("radioactive") and not inst.components.radiation) then
		if inst:HasTag("player") then
		    if inst.components.radiation then
		        inst.components.radiation:DoDelta(TUNING.RADIATION_GIANT, "food", true)
		    end
			if inst:HasTag("player") then
                    	    inst.components.talker:Say("My entire body hurts.")
			end
		end

	elseif food:HasTag("rejuvenation") then 
	    inst.components.radiation:DoDelta(-50)
	elseif food.prefab:match("nanoboost") then 
		if inst.components.radiation then
		    inst.components.radiation:Cured()

				if inst:HasTag("player") then
				    inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/happy")
                    		    SpawnPrefab("chester_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
				    --if not inst:HasTag("mime") then inst.components.talker:Say("Relief") end
				end

		end

	elseif Healthy(food)  then 
	    inst.components.radiation:DoDelta(-10)
	end
  end


local function OnTaskTick(inst, self, period)
    self:OnUpdate(period)
end

local Radiation = Class(function(self, inst)
    self.inst = inst
    self.max = 100
    self.current = 0

	self.radThreshold = 0.6
	self.maxDamageDeltaPerTick = -1
    self.rate = 0
    self.ratescale = RATE_SCALE.NEUTRAL
    self.rate_modifier = 1
    self.radiation = true
    self.fxtime = 0
    self.irradiated = 0
	self.externalmodifiers = SourceModifierList(self.inst, 0, SourceModifierList.additive)

    self.neg_aura_mult = 1 -- Deprecated, use the SourceModifier below
    self.neg_aura_modifiers = SourceModifierList(self.inst)
    self.neg_aura_absorb = 0

    self.irradiated_mult = 1
    self.penalty = 0

    self.radiation_penalties = {}


    self.custom_rate_fn = nil

    self._oldpercent = self:GetPercent()

	self.inst:ListenForEvent("oneat", OnEat)
    self.inst:StartUpdatingComponent(self)
	self.inst:ListenForEvent("death", function(inst) self:OnDeath() end)
   
end,
nil,


{
	--irradiated = onirradiated,
	--ratescale = onratescale,
    --max = onmax,
    --current = oncurrent,
    --ratescale = onratescale,
    --penalty = onpenalty,
    
})


function Radiation:AddRadiationPenalty(key, mod)
    self.radiation_penalties[key] = mod
    self:RecalculatePenalty()
end

function Radiation:RemoveRadiationPenalty(key)
    self.radiation_penalties[key] = nil
    self:RecalculatePenalty()
end

function Radiation:RecalculatePenalty()
    local penalty = 0

    for k,v in pairs(self.radiation_penalties) do
        penalty = penalty + v
    end

    penalty = math.min(penalty, 1+(80/self.max)) 

    self.penalty = penalty

    self:DoDelta(0)
end

function Radiation:AddRadiationAuraImmunity(tag)
	if self.radiation_aura_immunities == nil then
		self.radiation_aura_immunities = {}
	end
	self.radiation_aura_immunities[tag] = true
end

function Radiation:RemoveRadiationAuraImmunity(tag)
	self.radiation_aura_immunities[tag] = nil
	if next(self.radiation_aura_immunities) == nil then
		self.radiation_aura_immunities = nil
	end
end

function Radiation:SetFullAuraImmunity(immunity)
    self.radiation_aura_immune = immunity
end


function Radiation:OnSave()
    return
    {
        current = self.current,       
    }
end

function Radiation:OnLoad(data)    

    if data.current ~= nil then
        self.current = data.current
        self:DoDelta(0)
    end
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


function Radiation:SetMax(amount)
    self.max = amount
    self.current = amount
    self:DoDelta(0)
end

function Radiation:GetMaxWithPenalty()
    return self.max - (self.max * self.penalty)
end

function Radiation:GetRateScale()
    return self.ratescale
end

function Radiation:Cured()
	self.radiation = false
	self.current = 0	
end

function Radiation:OnDeath()
	self:Cured()
end

--[[function Radiation:AnnounceRadiation()

    if self.inst.components.talker and self.current >= self.radThreshold then  
			self.inst:StopUpdatingComponent(self)
            self.inst.components.talker:Say("The pain...so painful.")
			else
			self.inst:StartUpdatingComponent(self)
    end
end]]

---pain---
function Radiation:DoDelta(delta, overtime)
    if self.redirect ~= nil then
        self.redirect(self.inst, delta, overtime)
        return
    end

    if self.ignore then
        return
    end


    self.current = math.min(math.max(self.current + delta, 0), self.max - (self.max * self.penalty))

    self.inst:PushEvent("radiationdelta", { oldpercent = self._oldpercent, newpercent = self:GetPercent(), overtime = overtime })

    self._oldpercent = self:GetPercent()
		   
end



function Radiation:CreateFX()
		
		if self.radiation then
        self.fx = SpawnPrefab("radiation_clouds")

        if self.fx then
            self.fx.Transform:SetNoFaced()

            local xOffset = math.random(-1, 1) * (math.random()/2)
            local yOffset = 2.2 + math.random()/5
            local zOffset = math.random(-1, 1) * (math.random()/2)

            if self.inst.components.rider ~= nil and self.inst.components.rider:IsRiding() then
                yOffset = yOffset + 3.3
                xOffset = xOffset + 0.5
                zOffset = zOffset + 0.5
            end

            self.inst:AddChild(self.fx)
            self.fx.Transform:SetPosition(xOffset, yOffset, zOffset)

            self.fx.Transform:SetScale(0.2, 0.2, 0.2)
        end
		elseif self.current < self.radThreshold then
		self.fx:KillFX()
		--self.fx:Remove()
		self.fx = nil
	
		end	
		
    
end

function Radiation:OnUpdate(dt)
self:Recalc(dt)
    if self.inst.components.health and not self.inst.components.health:IsDead() then        
		if self.current >= self.radThreshold then			
			self.radiation = true
			self.inst.components.health:DoDelta(self.maxDamageDeltaPerTick * dt, true, "physical")
			self:CreateFX()
			
			--self:AnnounceRadiation()
			
    else
        --Always want to update badge       
        --Disable arrows
        self.rate = 0
        self.ratescale = RATE_SCALE.NEUTRAL
		self.radiation = false
		
	end
		
		end
					
end


function Radiation:GetAuraMultipliers()
    return self.neg_aura_mult * self.neg_aura_modifiers:Get()
end

local RADRECALC_MUST_TAGS _MUST_TAGS = { "HASRADIOACTIVE" }
local RADRECALC_CANT_TAGS = { "FX", "NOCLICK", "DECOR","INLIMBO" }
function Radiation:Recalc(dt)
	local irradiated_delta = 0
	if self.irradiated_mult ~= 0 then
		local total_irradiated = self.irradiated
	
		total_irradiated = total_irradiated * self.irradiated_mult
		irradiated_delta = total_irradiated * TUNING.IRRADIATED
	end

    local aura_delta = 0
	if not self.radiation_aura_immune then
		local x, y, z = self.inst.Transform:GetWorldPosition()
	    local ents = TheSim:FindEntities(x, y, z, TUNING.RAD_AURA_SEARCH_RANGE, RADRECALC_MUST_TAGS, RADRECALC_CANT_TAGS)
	    for i, v in ipairs(ents) do
	        if v.components.radioactive ~= nil and v ~= self.inst then
                local is_aura_immune = false
				if self.radiation_aura_immunities ~= nil then
					for tag, _ in pairs(self.radiation_aura_immunities) do
						if v:HasTag(tag) then
							is_aura_immune = true
							break
						end
					end
				end

                if not is_aura_immune then
                    local aura_val = v.components.radioactive:GetAura(self.inst)
					aura_val = (aura_val < 0 and (self.neg_aura_absorb > 0 and self.neg_aura_absorb * -aura_val or aura_val) * self:GetAuraMultipliers() or aura_val)
                    aura_delta = aura_delta + ((aura_val < 0 and self.neg_aura_immune) and 0 or aura_val)
                end
            end
        end
    end

    local mount = self.inst.components.rider:IsRiding() and self.inst.components.rider:GetMount() or nil
    if mount ~= nil and mount.components.radioactive ~= nil then
        local aura_val = mount.components.radioactive:GetAura(self.inst)
		aura_val = (aura_val < 0 and (self.neg_aura_absorb > 0 and self.neg_aura_absorb * -aura_val or aura_val) * self:GetAuraMultipliers() or aura_val)
        aura_delta = aura_delta + ((aura_val < 0 and self.neg_aura_immune) and 0 or aura_val)
    end


    self.rate = irradiated_delta + aura_delta + self.externalmodifiers:Get()

    if self.custom_rate_fn ~= nil then
       
        self.rate = self.rate + self.custom_rate_fn(self.inst, dt)
    end
	
	
	
	if self.inst.components.inventory ~= nil then
            for k, v in pairs(self.inst.components.inventory.equipslots) do
                if v.components.radioactive ~= nil then
                    local radiation = v.components.radioactive:GetEquippedRads()
                    if radiation ~= nil and (self.radThreshold > self.current) then
			self.radiation = true
			self.inst.components.health:DoDelta(self.maxDamageDeltaPerTick * dt, true, "physical")			
                    end
					
                end
            end
            for k, v in pairs(self.inst.components.inventory.itemslots) do
                if v.components.radioactive ~= nil then
                    local radiation, carriedmult = v.components.radioactive:GetCarriedRads()
                    if radiation ~= nil and (self.radThreshold > self.current) then                      
			self.radiation = true
			self.inst.components.health:DoDelta(self.maxDamageDeltaPerTick * dt, true, "physical")			

                    end
                end
            end
            local overflow = self.inst.components.inventory:GetOverflowContainer()
            if overflow ~= nil then
                for k, v in pairs(overflow.slots) do
                    if v.components.radioactive ~= nil then
                        local radiation, carriedmult = v.components.radioactive:GetCarriedRads()
                        if radiation ~= nil and (self.radThreshold > self.current) then                       			
			self.radiation = true
			self.inst.components.health:DoDelta(self.maxDamageDeltaPerTick * dt, true, "physical")				
                        end
                    end
                end
            end
        end

    self.rate = self.rate * self.rate_modifier
    self.ratescale =
        (self.rate > .2 and RATE_SCALE.INCREASE_HIGH) or
        (self.rate > .1 and RATE_SCALE.INCREASE_MED) or
        (self.rate > .01 and RATE_SCALE.INCREASE_LOW) or
        (self.rate < -.3 and RATE_SCALE.DECREASE_HIGH) or
        (self.rate < -.1 and RATE_SCALE.DECREASE_MED) or
        (self.rate < -.02 and RATE_SCALE.DECREASE_LOW) or
        RATE_SCALE.NEUTRAL
				

    self:DoDelta(self.rate * dt, true)
end

function Radiation:TransferComponent(newinst)
    local newcomponent = newinst.components.radiation
    newcomponent:SetPercent(self:GetPercent())
end

Radiation.LongUpdate = Radiation.OnUpdate

return Radiation
