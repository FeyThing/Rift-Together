local DamageTypesUtil = require("main/damagetypesutil")
DamageTypesUtil.SkipAutomatic("slurtle")
DamageTypesUtil.SkipAutomatic("snurtle")

return function(inst)
	if not TheWorld.ismastersim then
		return
	end
	
	local function IsInsideShell(inst)
		return inst:HasTag("shell")
	end
	
	DamageTypesUtil.AddBonus(inst, "piercing")
	DamageTypesUtil.AddVulnerability(inst, "bludgeoning", IsInsideShell)
end