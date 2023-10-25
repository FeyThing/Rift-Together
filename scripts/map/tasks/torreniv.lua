require("map/rooms/torreniv_rooms")

AddTask("Torren IV", {
		locks={},
		keys_given={KEYS.ISLAND_TIER2},
		region_id = "torren_iv",
		level_set_piece_blocker = true,
		room_tags = {"RoadPoison", "not_mainland", "Astral_1"},
		room_choices={
			["Torren IV"] = 2,			
		},
		room_bg=WORLD_TILES.JUNK,
		background_room = "BG Torren IV",
		cove_room_name = "Empty_Cove",
		make_loop = true,
		crosslink_factor = 2,
		cove_room_chance = 1,
		cove_room_max_edges = 2,
		colour={r=.05,g=.5,b=.05,a=1},
	})
	
	AddTask("Torren Wastes", {
		locks={LOCKS.ISLAND_TIER2},
		keys_given={KEYS.ISLAND_TIER3},
		region_id = "torren_iv",
		level_set_piece_blocker = true,
		room_tags = {"RoadPoison", "not_mainland", "Astral_1"},
		room_choices={
			["Torren IV Wastes"] = 1,			
			["Torren IV Lake"] = 1,
		},
		room_bg=WORLD_TILES.DIRT_NOISE,
		background_room = "BG Torren Wastes",
		cove_room_name = "Empty_Cove", -- Temp Cove until I make nasty water tiles
		cove_room_chance = 1,
		cove_room_max_edges = 2,
		colour={r=.05,g=.5,b=.05,a=1},
	})
	
AddTask("Torren Wastes Fertile", {
		locks={},
		keys_given={KEYS.ISLAND_TIER2},
		region_id = "torren_iv",
		level_set_piece_blocker = true,
		room_tags = {"RoadPoison", "not_mainland", "Astral_1"},
		room_choices={
			["Torren IV Fertile"] = 1,
			["Torren IV Ponds"] = 1,			
		},
		room_bg=WORLD_TILES.DESERTSAND_NOISE,
		background_room = "BG Torren Wastes",
		--cove_room_name = "Empty_Cove",
		--cove_room_chance = 1,
		--cove_room_max_edges = 2,
		colour={r=.05,g=.5,b=.05,a=1},
	})
	
	AddTask("Torren Wastes Crags", {
		locks={LOCKS.ISLAND_TIER2},
		keys_given={KEYS.ISLAND_TIER3},
		region_id = "torren_iv",
		level_set_piece_blocker = true,
		room_tags = {"RoadPoison", "not_mainland", "Astral_1"},
		room_choices={
			["Torren IV Wastes Crags"] = 1,			
		},
		room_bg=WORLD_TILES.DIRT_NOISE,
		background_room = "BG Torren Wastes",
		--cove_room_name = "Empty_Cove",
		--cove_room_chance = 1,
		--cove_room_max_edges = 2,
		colour={r=.05,g=.5,b=.05,a=1},
	})