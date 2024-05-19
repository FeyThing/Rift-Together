local DamageTypesUtil = require("main/damagetypesutil")
DamageTypesUtil.SkipAutomatic("pocketwatch_weapon")

return function(inst)
	if not TheWorld.ismastersim then
		return
	end
	
	local function HasFuel(inst)
		return inst.components.fueled == nil or not inst.components.fueled:IsEmpty()
	end
	
	DamageTypesUtil.AddBonus(inst, "bludgeoning")
	DamageTypesUtil.AddBonus(inst, "slashing")
	DamageTypesUtil.AddBonus(inst, "shadow", HasFuel)
end