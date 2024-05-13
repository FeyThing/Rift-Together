local DamageTypes = require("main/damagetypes")
DamageTypes.SkipAutomatic("pocketwatch_weapon")

return function(inst)
	if not TheWorld.ismastersim then
		return
	end
	
	local function HasFuel(inst)
		return inst.components.fueled == nil or not inst.components.fueled:IsEmpty()
	end
	
	DamageTypes.AddBonus(inst, "bludgeoning")
	DamageTypes.AddBonus(inst, "slashing")
	DamageTypes.AddAllegianceBonus(inst, "lunar_aligned", HasFuel, true)
end