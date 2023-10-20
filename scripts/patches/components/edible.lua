return function(self)
    local _OnEaten = self.OnEaten
    function self:OnEaten(eater, ...)
        _OnEaten(self, eater, ...)
        if self.radiationvalue and eater.components.radiation then
            eater.components.radiation:DoDelta(self.radiationvalue)
        end
    end
end
