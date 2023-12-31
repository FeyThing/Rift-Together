	AddRoom("BG Torren IV",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.JUNK_NOISE,
		contents = {
			distributepercent = 0.12,
			distributeprefabs =
			{
				chessjunk_spawner = 0.1,
				lava_pond = 0.1,
				nanocrate = 0.25,
				scrapmetal = 0.33,
				raritanium_crystals = 0.01,
				
				torren_grass_spawner = .2,
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
			distributepercent = 0.1,
			distributeprefabs =
			{
				chessjunk_spawner = 0.1,
				torren_cactus = 0.33,
				succulent_plant = 0.3,
				fireflies = 0.33,
				torren_grass_spawner = .1,
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
				hound_robomuttherd = function() return math.random(1,2) end,
				barrel_radioactive = 2,
			},
			distributepercent = 0.25,
			distributeprefabs =
			{
				raritanium_crystals = 0.1,
				nanocrate = 0.25,
								
				chessjunk_spawner = 0.15,
				hound_robomuttherd = 0.01,
				scraprock = 3,
				junkpile = 4,
				scrapmetal = 0.6,
				vullard_lamp = 0.1,
				
				torren_grass_spawner = .3,
				torren_cactus = 0.33,
				
				lava_pond = .1,
				junk_pillar = 1,
				torrenivdesert_pillar = 0.15,
				torrenivdesert_pillar_small = 0.5,
				mud_puddle = 0.1,
			},
		},
		
	})
	
AddRoom("Torren IV Depot",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.JUNK_NOISE,
		contents = {
			countstaticlayouts={["lonely_depot"] = 1},
			distributepercent = 0.07,
			distributeprefabs =
			{								
				scraprock = 3,
				scrapmetal = 0.6,
				vullard_lamp = 0.1,
				
				torren_grass_spawner = .2,
				torren_cactus = 0.33,
				
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
			distributepercent = 0.15,
			distributeprefabs =
			{
				raritanium_crystals = 0.01,
				nanocrate = 0.1,
				scrapmetal = 1,
												
				torren_grass_spawner = .1,
				marsh_tree = 1,
				fireflies = 0.33,
				torren_cactus = 0.33,
				marsh_bush = 0.66,
				succulent_plant = 0.3,				
		
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
			distributepercent = 0.15,
			distributeprefabs =
			{
				raritanium_crystals = 0.01,
				nanocrate = 0.01,
				scrapmetal = 1,
				
				butterfly = .5,				
				flower = .3,
				luminoustree = 3,
												
				torren_grass_spawner = .2,
				marsh_tree = 1,
				fireflies = 0.33,
				torren_cactus = 0.43,
				marsh_bush = 0.66,
				rabbithole = 0.1,
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
			distributepercent = 0.15,
			distributeprefabs =
			{
				raritanium_crystals = 0.01,
				nanocrate = 0.01,
				scrapmetal = 1,					
                					
				torren_grass_spawner = .01,
				marsh_tree = 1,
				fireflies = 0.33,
				torren_cactus = 0.33,
				marsh_bush = 0.66,
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
			distributepercent = 0.23,
			--countstaticlayouts = {
				--["ChessSpot1"] = function() return math.random(0,3) end,			
				--},
			distributeprefabs =
			{
				raritanium_crystals = 0.2,
								
				irradiated_pond = 0.1,
				butterfly = .5,				
				flower = .2,
				luminoustree = 3,				

				torren_cactus = 0.33,
				fireflies = 0.33,
				torren_grass_spawner = .15,
				tumbleweedspawner = .01,
				marsh_tree = .5,
				succulent_plant = 0.3,
				
				chessjunk_spawner = 0.1,				
				
				torrenivdesert_pillar = 0.1,
				torrenivdesert_pillar_small = 1,

			},
			countprefabs= {
			irradiated_pond = 1
			},
		},
	})	
	
AddRoom("Torren IV Fertile",  {
		colour={r=0.3,g=0.2,b=0.1,a=0.3},
		value = WORLD_TILES.DESERTFERTILE_NOISE,
		contents = {
			distributepercent = 0.23,

			distributeprefabs =
			{
				raritanium_crystals = 0.2,
								
				butterfly = .5,				
				flower = .2,				

				notthebees = {weight = .2, prefabs = {"beehive", "wasphive"}},
				torren_cactus = 0.33,
				fireflies = 0.33,
				torren_grass_spawner = .3,
				berrybush2 = 0.4,
				succulent_plant = 0.3,
				luminoustree = 6,				
				
				torrenivdesert_pillar = 0.1,
				torrenivdesert_pillar_small = .5,

			},
		},
	})	