AddRecipe2("owrench",
        {Ingredient("raritaniumore", 3), Ingredient("nanotech", 2), Ingredient("gears", 2)},
        _G.TECH.NONE,
        {builder_tag="veldin_mechanic"},
		{"CHARACTER","TOOLS"})

AddRecipe2("cryomod",
        {Ingredient("raritanium_bar", 1), Ingredient("nanotech", 4), Ingredient("bluegem", 1)},
        _G.TECH.LOST,
		{},
		{"WEAPONS"})

AddRecipe2("napalmmod",
        {Ingredient("raritanium_bar", 1), Ingredient("nanotech", 4), Ingredient("redgem", 1)},
        _G.TECH.LOST,
        {},
		{"WEAPONS"})

AddRecipe2("shockmod",
        {Ingredient("raritanium_bar", 1), Ingredient("nanotech", 4), Ingredient("lightninggoathorn", 1)},
        _G.TECH.LOST,
        {},
		{"WEAPONS"})

AddRecipe2("nanoboost", 
		{ Ingredient("nanotech", 2), Ingredient("raritaniumore", 2), Ingredient("ice", 3) }, 
		_G.TECH.NONE, 
        {builder_tag="solana_galaxy_resident"},
		{"CHARACTER","RESTORATION"})
		
AddRecipe2("rarisword", 
		{ Ingredient("purplegem", 1), Ingredient("raritanium_bar", 1), Ingredient("gears", 3) }, 
		_G.TECH.LOST, 
        {},
		{"WEAPONS"})
		
AddRecipe2("respiratormask", 
		{ Ingredient("rt_filter_small", 1), Ingredient("raritanium_bar", 1), Ingredient("gears", 2) }, 
		_G.TECH.LOST, 
        {},
		{"ARMOUR"})

AddRecipe2("armor_raritanium", 
		{ Ingredient("rt_fabric", 1), Ingredient("raritanium_bar", 4), Ingredient("scrapbits", 2) }, 
		_G.TECH.LOST, 
        {},
		{"ARMOUR"})

AddRecipe2("rarispear", 
		{ Ingredient("moonrocknugget", 1), Ingredient("raritaniumore", 1), Ingredient("spear", 1) }, 
		_G.TECH.SCIENCE_ONE, 
        {},
		{"WEAPONS"})
		
AddRecipe2("commando_helmet", 
		{ Ingredient("raritanium_bar", 1), Ingredient("gears", 2), Ingredient("moonglass", 3) }, 
		_G.TECH.SCIENCE_TWO, 
        {builder_tag="veldin_mechanic"},
		{"CHARACTER","ARMOUR"})

AddCharacterRecipe("wx78module_maxresist",
		{Ingredient("scandata", 4), Ingredient("luminous_fruit", 1), Ingredient("wx78module_maxhealth", 1)},
		_G.TECH.ROBOTMODULECRAFT_ONE,
		{builder_tag="upgrademoduleowner"})

AddRecipe2("hazhat", 
		{ Ingredient("tentaclespots", 2), Ingredient("moonglass", 4), Ingredient("rt_filter_large", 2) }, 
		_G.TECH.SCIENCE_TWO, 
        {},
		{"CLOTHING"})

AddRecipe2("hazmat", 
		{ Ingredient("tentaclespots", 4), Ingredient("rt_fabric", 3), Ingredient("scrapbits", 4) }, 
		_G.TECH.SCIENCE_TWO, 
        {},
		{"CLOTHING"})

AddRecipe2("rt_fabric", 
		{ Ingredient("silk", 10) }, 
		_G.TECH.SCIENCE_ONE, 
        {},
		{"REFINE"})

AddRecipe2("rt_filter_small", 
		{ Ingredient("petals", 6), Ingredient("papyrus", 1), Ingredient("scrapbits", 2) }, 
		_G.TECH.SCIENCE_TWO, 
        {},
		{"REFINE"})

AddRecipe2("rt_filter_large", 
		{ Ingredient("luminous_fruit", 2), Ingredient("rt_fabric", 1), Ingredient("scrapbits", 2) }, 
		_G.TECH.SCIENCE_TWO, 
        {},
		{"REFINE"})

if _G.EQUIPSLOTS.SHOES then		
AddRecipe2("shoes_hover", 
		{Ingredient("shoes_radiation", 1), Ingredient("shoes_slurper", 1), Ingredient("gears", 4)}, 
		_G.TECH.LOST, 
		{},  
		{"CRAFTING_STATION"} or {"CLOTHING", "MAGIC"})
		
AddRecipe2("shoes_radiation", 
		{Ingredient("goldnugget", 1), Ingredient("scrapbits", 1), Ingredient("pigskin", 2)}, 
		_G.TECH.SHOES_ONE, 
		{},  
		{"CRAFTING_STATION"} or {"CLOTHING", "MAGIC"})
end