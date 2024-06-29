return function(inst)
	
	--CLIENT
	if not _G.TheWorld.ismastersim then
		return
	end
	--SERVER
	inst:AddComponent("radiationmanager")
	inst:AddComponent("dimensionalrifts")
end
