return function(inst)

if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
		
	inst.components.equippable:SetRadiationProtectPercent(0.25)


end