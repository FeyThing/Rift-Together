return function(inst)

if not TheWorld.ismastersim then
		return
	end
		
	inst.components.equippable:SetRadiationProtectPercent(0.25)


end