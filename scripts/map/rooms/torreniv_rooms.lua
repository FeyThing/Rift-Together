	AddRoom("BG Torren IV",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.JUNK_NOISE,
		contents = {
			distributepercent = 0.07,
			distributeprefabs =
			{
				chessjunk = 0.1,
				lava_pond = 0.1,
				nanocrate = 0.25,
				scrapmetal = 0.33,
				raritanium_crystals = 0.01,
				
				torren_grass = 1,
				torren_cactus = 0.33,
				
				vullard_lamp = 0.1,
				junkpile = 0.3,
				junk_pillar = 0.25,
				torrenivdesert_pillar = 0.15,
				torrenivdesert_pillar_small = 0.1,
				mud_puddle = 0.1,
			},
		}
	})
	
	AddRoom("BG Torren Wastes",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.DESERTSAND,
		contents = {
			distributepercent = 0.05,
			distributeprefabs =
			{
				chessjunk = 0.1,
				rock_avocado_bush = 0.1,
				torren_cactus = 0.33,
				succulent_plant = 0.3,
				fireflies = 0.33,
				torren_grass = 1,
				driftwood_tall = 0.1,
				raritanium_crystals = 0.01,
				scrapmetal = 0.15,
				torrenivdesert_pillar = 0.15,
				torrenivdesert_pillar_small = 0.1,
				marsh_tree = 0.66,
				mud_puddle = 0.1,
			},
		}
	})

	AddRoom("Torren IV",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.JUNK_NOISE,
		contents = {
			countprefabs= {
			scrapmound = function() return math.random(1,2) end,
			vullard_smelter = 1
			},
			distributepercent = 0.07,
			distributeprefabs =
			{
				raritanium_crystals = 0.1,
				nanocrate = 0.25,
								
				chessjunk = 0.15,
				scrapmound = 0.01,
				junkpile = 4,
				scrapmetal = 0.6,
				vullard_lamp = 0.1,
				
				torren_grass = 2,
				torren_cactus = 0.33,
				
				lava_pond = .1,
				junk_pillar = 1,
				torrenivdesert_pillar = 0.15,
				torrenivdesert_pillar_small = 0.5,
				mud_puddle = 0.1,
			},
		},
		
	})
	
	AddRoom("Torren IV Wastes Crags",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.DESERTSAND_NOISE,
		contents = {
			countprefabs= {
				raritaniumspawner = function() return math.random(1,2) end,
				burntground_faded = function() return math.random(3,5) end,
			},
			distributepercent = 0.1,
			distributeprefabs =
			{
				raritanium_crystals = 0.01,
				nanocrate = 0.1,
				scrapmetal = 1,
												
				torren_grass = 2,
				marsh_tree = 1,
				fireflies = 0.33,
				torren_cactus = 0.33,
				marsh_bush = 0.66,
				succulent_plant = 0.3,
				
				stalagmite_med = 0.25,
				torrenivdesert_pillar = 0.07,
				torrenivdesert_pillar_small = 1,
				mud_puddle = 0.5,
			},
		},
		
	})
	
	AddRoom("Torren IV Lake",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.DESERTSAND,
		contents = {			
			countstaticlayouts={["gunkywateringhole"] = 1},
			distributepercent = 0.1,
			distributeprefabs =
			{
				raritanium_crystals = 0.01,
				nanocrate = 0.01,
				scrapmetal = 1,
				
				butterfly = .5,				
				flower = .3,
												
				torren_grass = 1,
				marsh_tree = 1,
				fireflies = 0.33,
				torren_cactus = 0.33,
				marsh_bush = 0.66,
				rock_avocado_bush = 0.1,
				succulent_plant = 0.3,				
			
				torrenivdesert_pillar = 0.8,
				torrenivdesert_pillar_small = 0.4,
				mud_puddle = 0.6,
			},
		},
		
	})
	
	AddRoom("Torren IV Wastes",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.DESERTSAND_NOISE,
		contents = {						
			distributepercent = 0.1,
			distributeprefabs =
			{
				raritanium_crystals = 0.01,
				nanocrate = 0.01,
				scrapmetal = 1,					
                					
				torren_grass = 3,
				marsh_tree = 1,
				fireflies = 0.33,
				torren_cactus = 0.33,
				marsh_bush = 0.66,
				rock_avocado_bush = 0.1,
				succulent_plant = 0.3,
										
				torrenivdesert_pillar = 4,					
				torrenivdesert_pillar_small = 2,
				mud_puddle = 0.1,
				--rubbish = {weight = 6, prefabs = {"scrapmetal", "junkpile"}}
			},
		},
		
	})
	
		AddRoom("Torren IV Ponds",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.DESERTSAND_NOISE,
		contents = {
			distributepercent = 0.13,
			--countstaticlayouts = {
				--["ChessSpot1"] = function() return math.random(0,3) end,			
				--},
			distributeprefabs =
			{
				raritanium_crystals = 0.2,
								
				pond_cave = 0.1,
				butterfly = .5,				
				flower = .2,				

				torren_cactus = 0.33,
				fireflies = 0.33,
				torren_grass = .25,
				tumbleweedspawner = .01,
				marsh_tree = .5,
				succulent_plant = 0.3,
				
				chessjunk = 0.1,				
				
				torrenivdesert_pillar = 0.1,
				torrenivdesert_pillar_small = 1,

			},
			countprefabs= {
			pond_cave = 1
			},
		},
	})	