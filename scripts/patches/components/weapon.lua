return function(self)
	-- Removed the modifier applied to weapons when attacking armoredbody
	local _old_onattack = self.OnAttack
	
	function self:OnAttack(attacker, target, projectile, ...)
		_old_onattack(self, attacker, target, projectile, ...)
		
		self.attackwearmultipliers:RemoveModifier(self.inst, "armoredbody_attackwear")
	end
end