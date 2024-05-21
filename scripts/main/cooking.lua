local TUNING = _G.TUNING
local FOODTYPE = _G.FOODTYPE
local STRINGS = _G.STRINGS
local Cooking = require("cooking")
local PreparedFoods = require("preparedfoods")
local SpicedFoods = require("spicedfoods")



-- Our custom ingredients
AddIngredientValues({"luminous_fruit", "starfruit"}, {fruit=1}, true)



-- Useful functions for recipe checks
local function HasBerries(names, amount)
	return ((names.berries or 0) + (names.berries_cooked or 0) + (names.berries_juicy or 0) + (names.berries_juicy_cooked or 0)) >= amount
end



-- Our custom recipes
local RT_COOKINGRECIPES = {
	rt_spaceshake = {
		-- 1 Starfruit, 1 Luminous Fruit, 1 Ice, 1 Berries
		-- 1 Starfruit, 1 Luminous Fruit, 2 Berries
		test = function(cooker, names, tags) return (names.starfruit or names.starfruit_cooked) and (names.luminous_fruit or names.luminous_fruit_cooked) and ((tags.frozen and HasBerries(names, 1)) or HasBerries(names, 2)) and not tags.meat and not tags.fish and not tags.monster end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		health = TUNING.HEALING_MED/2, -- 10
		hunger = TUNING.CALORIES_MEDSMALL, -- 18.75
		sanity = TUNING.SANITY_MEDLARGE, -- 20
		radiation = -TUNING.RADIATION_GIANT, -- -30
		perishtime = TUNING.PERISH_SLOW, -- 15 days
		cooktime = 0.5,
		floater = {"small", 0, 0.5},
	},
}

local function AddRadiationValues(recipe, radiation)
	AddPrefabPostInit(recipe, function(inst)
		if not _G.TheWorld.ismastersim then
			return inst
		end
		
		if inst.components.edible ~= nil then
			inst.components.edible.radiationvalue = radiation
		end
	end)
end



-- This is more general data that applies to all of them
for recipe,data in pairs(RT_COOKINGRECIPES) do
	data.name = recipe
	data.rt_dish = true
	data.weight = data.weight or 1
	data.priority = data.priority or 1
	data.cooktime = data.cooktime or 0.5
	data.overridebuild = "rt_crockpotfood"
	data.cookbook_atlas = "images/rt_cookbook.xml"
	
	-- Add them to the regular vanilla cookers
	AddCookerRecipe("cookpot", data)
	AddCookerRecipe("portablecookpot", data)
	AddCookerRecipe("archive_cookpot", data)
	
	-- This will automatically generate them through Klei's prefabs/preparedfoods.lua
	PreparedFoods[recipe] = data
	
	-- Add radiation values
	if data.radiation ~= nil then
		AddRadiationValues(data.name, data.radiation)
		
		if data.radiation > 0 then
			data.oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_RADIATION_INCREASE
		elseif data.radiation < 0 then
			data.oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_RADIATION_DECREASE
		end
	end
end

-- Make spiced recipes, will also be automatically generated in prefabs/preparedfoods.lua
_G.GenerateSpicedFoods(RT_COOKINGRECIPES)

-- Unfortunately GenerateSpicedFoods doesn't return a table, but we need to add those recipes to the Portable Seasoning Station
for name,data in pairs(SpicedFoods) do
	if Cooking.recipes.portablespicer[data.name] == nil and data.rt_dish then
		AddCookerRecipe("portablespicer", data)
		
		-- Also add radiation values
		if data.radiation ~= nil then
			AddRadiationValues(data.name, data.radiation)
		end
	end
end