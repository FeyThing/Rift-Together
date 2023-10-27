return function(self)
    local _GetAttacked = self.GetAttacked
    function self:GetAttacked(attacker, damage, ...)
        _GetAttacked(self, attacker, damage, ...)
        if attacker and attacker.components.radiation and self.inst.components.radiation then
            if self.inst.components.radiation:GetPercent() < attacker.components.radiation:GetPercent() then
                self.inst.components.radiation:DoDelta(damage*.25)
            end
        end
    end
    local _DoAttack = self.DoAttack
    function self:DoAttack(targ, weapon, projectile, stimuli, instancemult, ...)
        _DoAttack(self, targ, weapon, projectile, stimuli, instancemult, ...)
        if weapon == nil then
            weapon = self:GetWeapon()
        end
        if targ and targ.components.radiation and self.inst.components.radiation then
            local mult =
            (   stimuli == "electric" or
                (weapon ~= nil and weapon.components.weapon ~= nil and weapon.components.weapon.stimuli == "electric")
            )
            and not (targ:HasTag("electricdamageimmune") or
                    (targ.components.inventory ~= nil and targ.components.inventory:IsInsulated()))
            and TUNING.ELECTRIC_DAMAGE_MULT + TUNING.ELECTRIC_WET_DAMAGE_MULT * (targ.components.moisture ~= nil and targ.components.moisture:GetMoisturePercent() or (targ:GetIsWet() and 1 or 0))
            or 1
            local dmg, spdmg = self:CalcDamage(targ, weapon, mult)
            dmg = dmg * (instancemult or 1)
            if self.inst.components.radiation:GetPercent() < targ.components.radiation:GetPercent() then
                self.inst.components.radiation:DoDelta(dmg*.1)
            end
        end
    end
end
