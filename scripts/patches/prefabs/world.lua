return function(inst)
	
	--CLIENT
	if not TheWorld.ismastersim then
		return
	end
	--SERVER
	inst:AddComponent("radiation_manager")
	inst:AddComponent("dimensionalrifts")
end
