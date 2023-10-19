local NefBadge = require "widgets/nefbadge"

return function(self)
	if self.owner.prefab == "nefarious" then
		self.energyhud = self:AddChild(NefBadge(self, self.owner))
        self.owner.energyhud = self.energyhud
        self.owner.UpdateBadges = function()
            local percent_Energy = self.owner.current_energy and (self.owner.current_energy:value())/TUNING.NEFARIOUS_ENERGY or 0
            self.energyhud:SetPercent(percent_Energy, TUNING.NEFARIOUS_ENERGY)
        end
	end
end
