local radiation = 0

local VEGGIES = {

carrot = {radiation = 2},
carrot_cooked = {radiation = 1},

potato = {radiation = 2},
potato_cooked = {radiation = 1},

cave_banana = {radiation = 5},
cave_banana_cooked = {radiation = 2},

kelp = {radiation = -2},
kelp_cooked = {radiation = -3},

onion = {radiation = -1},
onion_cooked = {radiation = -2},

garlic = {radiation = -1},
garlic_cooked = {radiation = -2},

asparagus = {radiation = -1},
asparagus_cooked = {radiation = -2},

pepper = {radiation = -1},
pepper_cooked = {radiation = -2},

tomato = {radiation = -1},
tomato_cooked = {radiation = -2},

watermelon = {radiation = -1},
watermelon_cooked = {radiation = -2},

pumpkin = {radiation = -1},
pumpkin_cooked = {radiation = -2},

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