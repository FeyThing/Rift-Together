local radiation = 0

local VEGGIES = {

carrot = {radiation = 2},
carrot_cooked = {radiation = 1},

potato = {radiation = 2},
potato_cooked = {radiation = 1},

cave_banana = {radiation = 5},
cave_banana_cooked = {radiation = 2},


}


return function(inst, name)

--local function fn()
--CLIENT
	if not TheWorld.ismastersim then
		return
	end
	--SERVER
        inst.components.edible.radiationvalue = VEGGIES[name].radiation				
		   --return inst
    --end
end