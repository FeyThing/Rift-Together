local veggies_radiation = {
	cave_banana = 5,
	cave_banana_cooked = 2,

	kelp = -2,
	kelp_cooked = -3,

	onion = -1,
	onion_cooked = -2,

	garlic = -1,
	garlic_cooked = -2,

	asparagus = -1,
	asparagus_cooked = -2,

	pepper = -1,
	pepper_cooked = -2,

	tomato = -1,
	tomato_cooked = -2,

	pumpkin = -1,
	pumpkin_cooked = -2,
}


return function(inst, name)
	if not _G.TheWorld.ismastersim then
		return
	end

	inst.components.edible.radiationvalue = veggies_radiation[name] or 0
end