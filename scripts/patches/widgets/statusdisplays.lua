local NefBadge = require "widgets/nefbadge"
local RadiationBadge = require "widgets/radiationbadge"

local function OnSetGhostMode(inst, self)
    if self.owner.replica.radiation then
        if self.onradiationdelta then
            self.inst:RemoveEventCallback("radiationdelta", self.onradiationdelta, self.owner)
            self.onradiationdelta = nil
        end
    end
end

local function OnSetPlayerMode(inst, self)
    if self.owner.replica.radiation then
        if self.onradiationdelta == nil then
            self.onradiationdelta = function(owner, data) self:RadiationDelta(data) end
            self.inst:ListenForEvent("radiationdelta", self.onradiationdelta, self.owner)
            self:SetRadiationPercent(self.owner.replica.radiation:GetPercent())
        end
    end
end

local function OnFinishSeamlessPlayerSwap(owner)
    local self = owner.HUD.controls.status
    self.inst:RemoveEventCallback("finishseamlessplayerswap", OnFinishSeamlessPlayerSwap, owner)

    if self.isghostmode then
        OnSetGhostMode(self.inst, self)
    else
        OnSetPlayerMode(self.inst, self)
    end
end

local StatusDisplays = require("widgets/statusdisplays") -- LukaS: I need to override the SetGhostMode method before
                                                         -- the _ctor of StatusDisplays runs, with the current way of how the "patches"
                                                         -- work that's impossible to do from inside of the returning function
                                                         -- Might have to revise how "patches" work
local old_StatusDisplays_SetGhostMode = StatusDisplays.SetGhostMode
StatusDisplays.SetGhostMode = function(self, ghostmode, ...)
    old_StatusDisplays_SetGhostMode(self, ghostmode, ...)

    if ghostmode then
        if self.radiation then
            self.radiation:Hide()
        end
    else
        if self.radiation then
            self.radiation:Show()
        end
    end

    if self.modetask then
        local old_modetask_fn = self.modetask.fn
        self.modetask.fn = function(inst, self)
            old_modetask_fn(inst, self)
    
            if ghostmode then
                OnSetGhostMode(inst, self)
            else
                OnSetPlayerMode(inst, self)
            end
        end
    end
end

StatusDisplays = nil

return function(self)
	function self:SetRadiationPercent(pct)
        local oldpenalty = self.radiation.penaltypercent or 0
        local newpenalty = self.owner.replica.radiation:GetPenaltyPercent()
        self.radiation:SetPercent(pct, self.owner.replica.radiation:Max(), newpenalty)

        return oldpenalty, newpenalty
    end
    
    function self:RadiationDelta(data)
        local oldpenalty, newpenalty = self:SetRadiationPercent(data.newpercent)
        local green, red
        if not data.overtime then
            if data.newpercent < data.oldpercent then
                green = true
            elseif data.newpercent > data.oldpercent then
                red = true
            end
        end

        if newpenalty < oldpenalty then
            red = true
        elseif newpenalty > oldpenalty then
            green = true
        end

        if red then
            self.radiation:PulseRed()
            TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/sanity_down")
        elseif green then
            self.radiation:PulseGreen()
            TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/sanity_up")
        end
    end

    local old_ShowStatusNumbers = self.ShowStatusNumbers
    function self:ShowStatusNumbers(self, ...)
        old_ShowStatusNumbers(self, ...)
    
        if self.radiation then
            self.radiation.num:Show()
        end
    end
    
    local old_HideStatusNumbers = self.HideStatusNumbers
    function self:HideStatusNumbers(self, ...)
        old_HideStatusNumbers(self, ...)
    
        if self.radiation then
            self.radiation.num:Hide()
        end
    end

-----------Radiation Badge positions	
    self.radiation = self:AddChild(RadiationBadge(self.owner))

	if self.radiation then
        local currentPlaform = self.inst:GetCurrentPlatform()
        if _G.KnownModIndex:IsModEnabled("workshop-376333686") then
            self.radiation:SetPosition(-125, 35, 0) -- combined stat pos
                                                    -- LukaS: -[TODO]- Probably should also consider the SEASONOPTIONS option in Combined Status
        elseif currentPlaform and currentPlaform.components.healthsyncer then
            self.radiation:SetPosition(-220, 20, 0) -- LukaS: This will not work, the DisplayStatus constructor will only run once
        else
            self.radiation:SetPosition(-120, 20, 0) -- base pos
        end
        
        if self.owner.isseamlessswaptarget then
            self.inst:ListenForEvent("finishseamlessplayerswap", OnFinishSeamlessPlayerSwap, self.owner)
        end

        -- if not self.inst:HasTag("playerghost") or _G.KnownModIndex:IsModEnabled("workshop-3004639365") then -- LukaS: ???
        --     self.radiation:Show()
        -- else
        --     self.radiation:Hide()
        -- end
    end	

    -- if _G.KnownModIndex:IsModEnabled("workshop-3004639365") then -- LukaS: ???
    --     self.radiation:Hide() 
    -- end

   --[[if self.owner.prefab == "nefarious" then
		self.energyhud = self:AddChild(NefBadge(self, self.owner))
        self.owner.energyhud = self.energyhud
        self.owner.UpdateBadges = function()
            local percent_Energy = self.owner.current_energy and (self.owner.current_energy:value())/TUNING.NEFARIOUS_ENERGY or 0
            self.energyhud:SetPercent(percent_Energy, TUNING.NEFARIOUS_ENERGY)
        end
		if self.energyhud ~= nil then
			local currentPlaform = self.inst:GetCurrentPlatform()
            if currentPlaform ~= nil and currentPlaform.components.healthsyncer ~= nil 
                    and _G.KnownModIndex:IsModEnabled("workshop-376333686") then
                        self.energyhud:SetPosition(-125,35,0)
                    elseif _G.KnownModIndex:IsModEnabled("workshop-376333686") then
                        self.energyhud:SetPosition(-62,-52,0)
                    elseif currentPlaform ~= nil and currentPlaform.components.healthsyncer ~= nil then
                        self.energyhud:SetPosition(-120, 20,0)
                    else
                        self.energyhud:SetPosition(-80,-40,0)
                    end
            if not self.inst:HasTag("playerghost") then
                        self.energyhud:Show()
                    else
                        self.energyhud:Hide()
                    end
            end		
	end]]
end
