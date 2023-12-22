local atlas = "images/rnc_inventoryimages.xml"
AddRecipe2("owrench",
        {Ingredient("raritaniumore", 3, atlas), Ingredient("nanotech", 2, atlas), Ingredient("gears", 2)},
        TECH.NONE,
        {builder_tag="veldin_mechanic",atlas=atlas},
		{"CHARACTER","TOOLS"})

AddRecipe2("cryomod",
        {Ingredient("raritanium_bar", 1, atlas), Ingredient("nanotech", 4, atlas), Ingredient("bluegem", 1)},
        TECH.LOST,
        {atlas=atlas},
		{"CHARACTER","WEAPONS"})

AddRecipe2("napalmmod",
        {Ingredient("raritanium_bar", 1, atlas), Ingredient("nanotech", 4, atlas), Ingredient("redgem", 1)},
        TECH.LOST,
        {atlas=atlas},
		{"CHARACTER","WEAPONS"})

AddRecipe2("shockmod",
        {Ingredient("raritanium_bar", 1, atlas), Ingredient("nanotech", 4, atlas), Ingredient("lightninggoathorn", 1)},
        TECH.LOST,
        {atlas=atlas},
		{"CHARACTER","WEAPONS"})

AddRecipe2("nanoboost", 
		{ Ingredient("nanotech", 3, atlas), Ingredient("raritanium_bar", 1, atlas), Ingredient("ice", 3) }, 
		TECH.NONE, 
        {builder_tag="solana_galaxy_resident",atlas=atlas},
		{"CHARACTER","RESTORATION"})
		
AddRecipe2("rarisword", 
		{ Ingredient("purplegem", 1), Ingredient("raritanium_bar", 1, atlas), Ingredient("gears", 3) }, 
		TECH.LOST, 
        {atlas=atlas},
		{"CHARACTER","WEAPONS"})
		
AddRecipe2("respiratormask", 
		{ Ingredient("transistor", 4), Ingredient("raritanium_bar", 1, atlas), Ingredient("gears", 2) }, 
		TECH.LOST, 
        {atlas=atlas},
		{"CHARACTER","ARMOUR"})

AddRecipe2("rarispear", 
		{ Ingredient("moonrocknugget", 1), Ingredient("raritaniumore", 1, atlas), Ingredient("spear", 1) }, 
		TECH.SCIENCE_ONE, 
        {atlas=atlas},
		{"CHARACTER","WEAPONS"})