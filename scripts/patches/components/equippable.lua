return function(self)
    self.radiationprotectprocent = 0
    local _Equip = self.Equip
    function self:Equip(owner, ...)
        _Equip(self, owner, ...)
        if self.radiationprotectprocent and owner.components.radiation then
            owner.components.radiation:AddPenalty(self.inst, self.radiationprotectprocent)
        end
    end
    
    local _Unequip = self.Unequip
    function self:Unequip(owner, ...)
        _Unequip(self, owner, ...)
        if self.radiationprotectprocent and owner.components.radiation then
            owner.components.radiation:RemovePenalty(self.inst)
        end
    end
    
    function self:SetRadiationProtectPercent(perc)
        self.radiationprotectprocent = perc
    end

    function self:GetRadiation(owner, ignore_wetness)
        return 0
    end
end
