AddRecipe2("owrench",
        {Ingredient("raritaniumore", 8, "images/inventoryimages/raritaniumore.xml"), Ingredient("nanotech", 6, "images/inventoryimages/nanotech.xml"), Ingredient("gears", 4)},
        TECH.NONE,
        {atlas="images/inventoryimages/owrench.xml", image= "owrench.tex"},
		{builder_tag="veldin_mechanic"},{"CHARACTER","TOOLS"})

AddRecipe2("cryomod",
        {Ingredient("raritanium_bar", 1, "images/inventoryimages/raritanium_bar.xml"), Ingredient("nanotech", 8, "images/inventoryimages/nanotech.xml"), Ingredient("bluegem", 1)},
        TECH.SCIENCE_TWO,
        {atlas="images/inventoryimages/cryomod.xml", image= "cryomod.tex"},
		{builder_tag= "solana_galaxy_resident"},{"CHARACTER","WEAPONS"})

AddRecipe2("napalmmod",
        {Ingredient("raritanium_bar", 1, "images/inventoryimages/raritanium_bar.xml"), Ingredient("nanotech", 8, "images/inventoryimages/nanotech.xml"), Ingredient("redgem", 1)},
        TECH.SCIENCE_TWO,
        {atlas="images/inventoryimages/napalmmod.xml", image= "napalmmod.tex"},
		{builder_tag="solana_galaxy_resident"},{"CHARACTER","WEAPONS"})

AddRecipe2("shockmod",
        {Ingredient("raritanium_bar", 1, "images/inventoryimages/raritanium_bar.xml"), Ingredient("nanotech", 8, "images/inventoryimages/nanotech.xml"), Ingredient("lightninggoathorn", 1)},
        TECH.SCIENCE_TWO,
        {atlas="images/inventoryimages/shockmod.xml", image= "shockmod.tex"},     
		{builder_tag="solana_galaxy_resident"},{"CHARACTER","WEAPONS"})

AddRecipe2("nanoboost", 
		{ Ingredient("nanotech", 3, "images/inventoryimages/nanotech.xml"), Ingredient("raritanium_bar", 1, "images/inventoryimages/raritanium_bar.xml"), Ingredient("ice", 3) }, 
		TECH.NONE, 
		{atlas="images/inventoryimages/nanoboost.xml", image= "nanoboost.tex"},	 
		{builder_tag="solana_galaxy_resident"},{"CHARACTER","RESTORATION"})
