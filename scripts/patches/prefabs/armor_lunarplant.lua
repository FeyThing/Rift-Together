return function(inst)

	if not _G.TheWorld.ismastersim then
		return
	end
		
	inst.components.equippable:SetRadiationProtectPercent(0.25)
end