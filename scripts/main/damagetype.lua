local DamageTypesUtil = require("main/damagetypesutil")

DamageType = Class(function(self, inst)
	self.inst = inst
	
	self.basemult = 1
	self.modifiers = {}
end)

function DamageType:IsEmpty()
	return next(self.modifiers) == nil
end

function DamageType:AddModifier(mult, key, checkfn)
	if mult == nil then
		return
	end
	
	if key == nil then
		key = "key"
	end
	
	self.modifiers[key] = {
		mult = mult,
		checkfn = checkfn
	}
end

function DamageType:RemoveModifier(key)
	if key == nil then
		key = "key"
	end
	
	self.modifiers[key] = nil
end

function DamageType:Get()
	local mult = self.basemult
	
	for key,data in pairs(self.modifiers) do
		if data.checkfn == nil or data.checkfn(self.inst) then
			mult = mult * data.mult
		end
	end
	
	return mult
end

return DamageType