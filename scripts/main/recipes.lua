local atlas = "images/rnc_inventoryimages.xml"
AddRecipe2("owrench",
        {Ingredient("raritaniumore", 3, atlas), Ingredient("nanotech", 2, atlas), Ingredient("gears", 2)},
        _G.TECH.NONE,
        {builder_tag="veldin_mechanic",atlas=atlas},
		{"CHARACTER","TOOLS"})

AddRecipe2("cryomod",
        {Ingredient("raritanium_bar", 1, atlas), Ingredient("nanotech", 4, atlas), Ingredient("bluegem", 1)},
        _G.TECH.LOST,
        {atlas=atlas},
		{"WEAPONS"})

AddRecipe2("napalmmod",
        {Ingredient("raritanium_bar", 1, atlas), Ingredient("nanotech", 4, atlas), Ingredient("redgem", 1)},
        _G.TECH.LOST,
        {atlas=atlas},
		{"WEAPONS"})

AddRecipe2("shockmod",
        {Ingredient("raritanium_bar", 1, atlas), Ingredient("nanotech", 4, atlas), Ingredient("lightninggoathorn", 1)},
        _G.TECH.LOST,
        {atlas=atlas},
		{"WEAPONS"})

AddRecipe2("nanoboost", 
		{ Ingredient("nanotech", 2, atlas), Ingredient("raritaniumore", 2, atlas), Ingredient("ice", 3) }, 
		_G.TECH.NONE, 
        {builder_tag="solana_galaxy_resident",atlas=atlas},
		{"CHARACTER","RESTORATION"})
		
AddRecipe2("rarisword", 
		{ Ingredient("purplegem", 1), Ingredient("raritanium_bar", 1, atlas), Ingredient("gears", 3) }, 
		_G.TECH.LOST, 
        {atlas=atlas},
		{"WEAPONS"})
		
AddRecipe2("respiratormask", 
		{ Ingredient("transistor", 4), Ingredient("raritanium_bar", 1, atlas), Ingredient("gears", 2) }, 
		_G.TECH.LOST, 
        {atlas=atlas},
		{"ARMOUR"})

AddRecipe2("rarispear", 
		{ Ingredient("moonrocknugget", 1), Ingredient("raritaniumore", 1, atlas), Ingredient("spear", 1) }, 
		_G.TECH.SCIENCE_ONE, 
        {atlas=atlas},
		{"WEAPONS"})
		
AddRecipe2("commando_helmet", 
		{ Ingredient("raritanium_bar", 1, atlas), Ingredient("gears", 2), Ingredient("moonglass", 3) }, 
		_G.TECH.SCIENCE_TWO, 
        {builder_tag="veldin_mechanic",atlas=atlas},
		{"CHARACTER","ARMOUR"})

AddCharacterRecipe("wx78module_maxresist",
		{Ingredient("scandata", 4), Ingredient("luminous_fruit", 1, atlas, nil, "luminousfruit.tex"), Ingredient("wx78module_maxhealth", 1)},
		_G.TECH.ROBOTMODULECRAFT_ONE,
		{builder_tag="upgrademoduleowner",atlas=atlas})

if _G.EQUIPSLOTS.SHOES then		
AddRecipe2("shoes_hover", 
		{Ingredient("shoes_radiation", 1, atlas), Ingredient("shoes_slurper", 1), Ingredient("gears", 4)}, 
		_G.TECH.LOST, 
		{atlas=atlas},  
		{"CRAFTING_STATION"} or {"CLOTHING", "MAGIC"})
		
AddRecipe2("shoes_radiation", 
		{Ingredient("goldnugget", 1), Ingredient("raritanium_bar", 1, atlas), Ingredient("pigskin", 2)}, 
		_G.TECH.SHOES_ONE, 
		{atlas=atlas},  
		{"CRAFTING_STATION"} or {"CLOTHING", "MAGIC"})
end