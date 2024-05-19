return function(inst)
	--CLIENT
	if not _G.TheWorld.ismastersim then
		return
	end

	--SERVER
	inst.components.edible.radiationvalue = 1
end