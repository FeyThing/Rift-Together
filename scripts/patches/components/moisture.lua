return function(self,inst, range)

	local OldCanSplash = self.GetMoistureRate
	
	function self:GetMoistureRate(...)
		local rate = OldCanSplash(self, ...)
		
		local target = FindEntity(inst, range or 5, function(pool) return pool:HasTag("watersplasher") end)
	
	if target and target.nodesize and target:GetDistanceSqToInst(inst) <= (target.nodesize/5.5) then
		return target
	end

	if target then
			local waterproofness = 1 - self:GetWaterproofness()
			rate = rate + (2 * waterproofness)		
	end	
		return rate
	end
end