local NefBadge = require "widgets/nefbadge"
local RadiationBadge = require "widgets/radiationbadge"

return function(self)
    self.radiation = self:AddChild(RadiationBadge(self.owner))
    self.radiation:SetPosition(self.column2, -100, 0)

    function self:SetRadiationPercent(pct)
        local oldpenalty = self.radiation.penaltypercent or 0
        local newpenalty = self.owner.replica.radiation:GetPenaltyPercent()
        self.radiation:SetPercent(pct, self.owner.replica.radiation:Max(), newpenalty)
    
        if self.owner.replica.radiation:IsDying() then
            self.radiation:StartWarning()
        else
            self.radiation:StopWarning()
        end
        return oldpenalty, newpenalty
    end
    
    function self:RadiationDelta(data)
        local oldpenalty, newpenalty = self:SetRadiationPercent(data.newpercent)
    
        if self.radiation ~= nil and self.radiation.RadiationDelta then
            self.radiation:RadiationDelta(data)
        else
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
    end

    self.inst:DoTaskInTime(0, function()
        if self.onradiationdelta == nil then
            self.onradiationdelta = function(owner, data) self:RadiationDelta(data) end
            self.inst:ListenForEvent("radiationdelta", self.onradiationdelta, self.owner)
            self:SetRadiationPercent(self.owner.replica.radiation:GetPercent())
        end
    end)

    if self.owner.prefab == "nefarious" then
		self.energyhud = self:AddChild(NefBadge(self, self.owner))
        self.owner.energyhud = self.energyhud
        self.owner.UpdateBadges = function()
            local percent_Energy = self.owner.current_energy and (self.owner.current_energy:value())/TUNING.NEFARIOUS_ENERGY or 0
            self.energyhud:SetPercent(percent_Energy, TUNING.NEFARIOUS_ENERGY)
        end
	end
end
