local general_scripts = require("play_generalscripts")
local fn = require("play_commonfn")

STRINGS.CHARACTERS.RATCHET = require "speech_ratchet"
--STRINGS.CHARACTERS.NEFARIOUS = require "speech_nefarious"


local strings = {
	CHARACTER_TITLES = {
		ratchet = "The Galactic Hero",
		--clank = "The Intellectual",
		--qwark = "The False Hero",
		--nefarious = "The RoboticMastermind",
	},
	CHARACTER_NAMES = {
		ratchet = "Ratchet",
		--clank = "Clank",
		--qwark = "Qwark",
		--nefarious = "Nefarious",
	},
	SKIN_NAMES = {
		ratchet_none = "Ratchet",
		--clank_none = "Clank",
		--qwark_none = "Qwark",
		--nefarious_none = "Nefarious",
		ms_rivet = "The Interdimensional Rebel",
		ms_owrench_hammer = "Rivet's Hammer",
		ms_loading_ratchet1 = "Rift Together"
	},
	SKIN_DESCRIPTIONS = {
		ms_rivet = "Ratchet's dimensional counterpart, Rivet.",
		ms_owrench_hammer = "A hammer used by Ratchet's counterpart, Rivet.",
		ms_loading_ratchet1 = "Reality in this dimension is being torn apart by its very seams. The only way to escape it's collapse is to find a way out...if there is a way out."
	},
	SKIN_QUOTES = {
		ms_rivet = "W...where am I?.",
	},
	CHARACTER_DESCRIPTIONS = {
		ratchet = "*Starts with a modifiable wrench\n*Is very nimble\n*Fearless",
		--clank = "*Built in portable fridge\n*Upgradeable\n*Chrono Adept",
		--qwark = "*Has a partial broken blaster\n*Is strong\n*Cowardly",
		--nefarious = "*Cannot wear armor\n*Doesn't get hungry as fast\n*Abilities are powered by energy",
	},
	CHARACTER_QUOTES = {
		ratchet = "\"Clank? Where are you!\"",
		--clank = "\"Hmmm, by my calculations I think we maybe in the middle of...nil...\"",
		--qwark = "\"Did anyone say they need a hero?\"",
		--nefarious = "\"LAWRENCE!!!\"",
	},
	CHARACTER_SURVIVABILITY = {
		ratchet = "Slim",
		--nefarious = "Grim",
	},
	CHARACTER_ABOUTME = {
		ratchet = "",
		--clank = "",
		--qwark = "",
		--nefarious = "",
	},
	CHARACTER_BIOS = {
		ratchet = {
					{ title = "Birthday", desc = "Unknown" },
					{ title = "Favorite Food", desc = "Unknown" },
					{ title = "Past...", desc = "Ratchet, an orphen originally born from Fastoon, is a headstrong and challenge seeking savior of multiple galaxies. Originally a jerk, he has now developed a light-hearted yet wise-cracking personality with the help of clank, his best friend. Though he has struggled balancing his own needs and those of others, he always chooses the right thing to do in order to keep the universe safe. Especially his friends and his foster home, Veldin."},
				},
		
		--[[clank = {
					{ title = "Birthday", desc = "Unknown" },
					{ title = "Favorite Food", desc = "Unknown" },
					{ title = "Past...", desc = "Is yet to be revealed."},
				},
				
		qwark = {
					{ title = "Birthday", desc = "Unknown" },
					{ title = "Favorite Food", desc = "Unknown" },
					{ title = "Past...", desc = "Is yet to be revealed."},
				},		
		
		nefarious = {
					{ title = "Birthday", desc = "Unknown" },
					{ title = "Favorite Food", desc = "Unknown" },
					{ title = "Past...", desc = "Is yet to be revealed."},
				},]]
		
	},
	CHARACTERS = {
		GENERIC = {
			DESCRIBE = {
				nefarious = {
					GENERIC = "He's kinda loud...",
					ATTACKER = "That Nefarious looks suspicious...",
					MURDERER = "Murderer!",
					REVIVER = "Nefarious? I can't believe it.",
					GHOST = "Nefarious could use a heart...I think?",
				},
				
				ratchet = {
					GENERIC = "Looks like a cross between a cat and something else.",
					ATTACKER = "Why are you doing this!",
					MURDERER = "Murderer!",
					REVIVER = "Thanks for saving me",
					GHOST = "Ratchet could use a heart...I think?",
				},

				OWRENCH = "It's an oversized wrench.",
				
				RESPIRATORMASK = "Maybe it'll provide some protection.",
				RARISWORD = "I could slice through metal with this!",
				RARISPEAR = "I could poke through metal with this.",
				COMMANDO_HELMET = "It's a strange helmet with holes on the sides. I don't think I can wear this.",
				
				NANOTECH = "It emits some sort of aura.",
				NANOCRATE = "It glows faintly.",
				RARITANIUMORE = "Hey, this could help!",
				RARITANIUM_BAR= "Now it's useful!",
				RARITANIUM_CRYSTALS = "Looks like some sort of crystal formation.",
				SCRAPMETAL = "Pieces of metal litter the ground.",
				BARREL_RADIOACTIVE = "I don't want to get too close.",
				DIMENSIONAL_RIFT = "Oh no, there must be a way to close it...",

				TORREN_GRASS = "It's a strange patch of grass.",
				TORREN_CACTUS = "It's a large cactus.",
				LUMINOUSTREE = "It's a glowing tree.",
				LUMINOUSTREE_SAPLING = "It's starting to grow.",
				LUMINOUS_FRUIT = "Doesn't look too appetizing.",
				LUMINOUS_FRUIT_COOKED = "It may taste better now that it's cooked.",

				NANOBOOST = "Looks refreshing.",

				HOUND_ROBOMUTT = "Their teeth are sharp!",
				RT_PAWN = "They're smaller so surely they're easier to beat right?",
				RT_PAWN_NIGHTMARE = "That one looks like it has seen better days.",

				VULLARD_LAMP = "Looks like someone made them with scrap.",
				SCRAPROCK = "I hear something coming from it.",
				JUNKPILE = "I should be careful touching it with bare hands.",
				VULLARD_SMELTER = "That's incredibly hot! I could make something useful with this.",
				
				--- Turfs
				TURF_JUNK = "It's a bunch of welded together clumps metal.",
				TURF_LUSH = "Smells like a freshly mowed lawn.",
				TURF_DESERTSAND = "Rocky, but also coarse, rough, irritating and it gets everywhere.",
				
				--- Shoetime mod
				SHOES_HOVER = "I can glide over almost anything!",
				SHOES_RADIATION = "Keeps the pain at bay.",
			},
			
			ANNOUNCE_IRRITATED = "What's this prickly sensation?",
			ANNOUNCE_PAIN = "I feel sore.",
			ANNOUNCE_SUFFERING = "My entire body is in pain.",
			ANNOUNCE_DYING = "I need medical attention...",
		},

		RATCHET = {
			DESCRIBE = {
				OWRENCH = "My trusty wrench!",
				
				CRYOMOD = "Let's add some cold damage to it!",
				NAPALMMOD = "Let's add heat to it!",
				SHOCKMOD = "Let's electrify it!",

				RESPIRATORMASK = "Should provide some great protection against that radiation!",
				RARISWORD = "With this amount of raritanium, I bet it's a lot like my wrench",
				RARISPEAR = "Sharp, but not as good at bashing in robots like my wrench",
				COMMANDO_HELMET = "Hey my old megacorp helmet! This could help with survivability.",

				NANOTECH = "Nanotech, just what the doctor ordered.",
				NANOCRATE = "This could patch me up!",
				RARITANIUMORE = "Raritanium! I wonder if I could use it for upgrades?",
				RARITANIUM_CRYSTALS = "That looks like raritanium.",
				SCRAPMETAL = "Maybe I could make use of this scrap.",
				DIMENSIONAL_RIFT = "It must be the work of the dimensionator. I need to find a way to close it.",

				HOUND_ROBOMUTT = "Oh no, not these things again.",
				RT_PAWN = "Well they're smaller. An easier job for my good 'ole Wrench.",
				RT_PAWN_NIGHTMARE = "Looks broken. Should be a cakewalk!",

				VULLARD_LAMP = "Huh, seems like the work of vullards.",
				SCRAPROCK = "Maybe if I bust it open, I'll find something of use.",
				JUNKPILE = "That's your typical vullard pile of junk.",
				VULLARD_SMELTER = "Oh hey, reminds me of home. Maybe I can make use of the scrap around here.",
				--- Shoetime mod
				SHOES_HOVER = "Looks like my old hoverboots! Let's take them out for a spin.",
				SHOES_RADIATION = "They're somewhat safe enough to even walk through aquatos's sewers.",
				SHOES_ARMOR = "These offer some great protection!",
				SHOES_SPEED = "I'm all ready to run!",
				SHOES_RAIN = "Should keep my feet dry.",
				SHOES_WET = "Eugh, these are gross. They're a pair of soggy socks!",
				SHOES_WINTER = "These could protect me even from the Tundor Wastes!",
				SHOES_SUMMER = "Ahhh, nice and breezy.",
				SHOES_SLURPER = "Ewww, I think it licked me.",
				SHOES_WATERPLANT = "These should make traversal a cakewalk!",
				SHOES_FROG = "Wow these are great! Too bad they feel a little slimy.",
				SHOES_BATTLE = "Usually I like a good wrench to the face, but with these a kick will do too!",
				SHOES_MOONROCK = "The dark doesn't seem that bad with these on.",
				SHOES_FERN = "They can take a beating for me.",
				SHOES_MUSHROOM_RED = "Whoohoo, these are great during the day!",
				SHOES_MUSHROOM_GREEN = "Whoohoo, these are great during dusk!",
				SHOES_MUSHROOM_BLUE = "Whoohoo, these are great during the night!",
				SHOESHINE_KIT = "Makes repairing footwear easier.",
				SHOES_DESK = {
				BURNT = "Yikes, I definitely didn't do that.",
				GENERIC = "Whoever constructed a table like this is pretty great at improvising.",
				},
				SHOES_DESK_MOREL = "Looks like he's ready to open up shop.",
				SHOES_SELLER = {
				GENERIC = "Probably not a florana resident, which may be a good thing.",
				HUNGRY = "I think he'll appreciate it if I grab him a bite to eat.",
				},
				SHOES_SELLER_PET = "Awww, look at the little guy."
				},
		},
	},
	
	NAMES = {
		ratchet = "Ratchet",
		nefarious = "Nefarious",
		ms_rivet = "The Interdimensional Rebel",

		OWRENCH = "OmniWrench",

		CRYOMOD = "Cryo Modification",
		NAPALMMOD = "Napalm Modification",
		SHOCKMOD = "Shock Modification",

		RESPIRATORMASK = "Respirator",
		RARISWORD = "Crystalass",
		RARISPEAR = "Reinforced Spear",
		COMMANDO_HELMET = "Megacorp Helmet",
		
		NANOTECH = "Nanotech",
		NANOCRATE = "Nanotech Crate",
		RARITANIUMORE = "Raritanium Crystal",
		RARITANIUM_BAR= "Raritanium Alloy",
		RARITANIUM_CRYSTALS= "Raritanium",
		SCRAPMETAL = "Scrap Metal",
		BARREL_RADIOACTIVE = "Metal Drum",
		DIMENSIONAL_RIFT = "Dimensional Rift",

		TORREN_GRASS = "Alien Grass",
		TORREN_CACTUS = "Cactus",
		LUMINOUSTREE = "Luminous Tree",
		LUMINOUSTREE_SAPLING = "Luminous Sapling",
		LUMINOUS_FRUIT = "Luminous Fruit",
		LUMINOUS_FRUIT_COOKED = "Roasted Luminous Fruit",

		NANOBOOST = "Nanotech Boost",

		--- Mobs
		HOUND_ROBOMUTT = "RoboMutt",
		RT_PAWN = "Clockwork Pawn",
		RT_PAWN_NIGHTMARE = "Damaged Pawn",
		

		VULLARD_LAMP = "Junk Lamp",
		SCRAPROCK = "Scrap Mound",
		JUNKPILE = "Junk Pile",
		VULLARD_SMELTER = "Smelter",

		RADIATION = "Radiation",
		
		--- Turfs
		TURF_JUNK = "Junk Turf",
		TURF_LUSH = "Lush Turf",
		TURF_DESERTSAND = "Desertsand Turf",	
		
		--- Shoetime mod
		SHOES_HOVER = "Hover Boots",
		SHOES_RADIATION = "Protective Boots",
	},
	
	STAGEACTOR = {
		RATCHET1 = 
		{
		-- RATCHET
        "Oh...um...h..hi.",
        "Usually Qwark is the one who does the whole acting and speech kinda thing...",
        "B...but I sure can try! Uhhh lemme see. Think Ratchet, think.",
        
        -- BIRDS
        "Sure go ahead, take your \"sweeeeet time.\"",
        "It's not like WE have all the time in the world here!",
        
        -- RATCHET
        "Okay, okay \"sheesh\",",
        "I have something-",
        
        -- BIRDS
        "Good.",
        "Let's hear it then.",
        
        -- RATCHET
        "Once upon a time there was a lone lombax,",
        "Nothing particular was happening on that day,",
		"Except maybe boredom...",
        "Your usual killer robot legion",
        "...and death",
        "since...it was on Umbris...",
        "Hot and muddy planet you know, heheh!.",
		
		-- BIRDS
        "...what?",
		
		-- RATCHET
        "Anyway, the lombax came up with an objectively great idea!",
        "He named the invention stunderwear!",
        "Who knew it'll sell surprisingly well, since Qwark is the only person I've seen living there. ",
				
	    -- BIRDS
        "...",

		-- RATCHET
        "O...okay that story may had sounded better in my head.",
        "Ohhh...well look at the time I think...I may have left the stove on. Gotta split! Bye!",		
		}
	
	},

	RECIPE_DESC = {
		OWRENCH = "Just in case I ever misplace it.",

		CRYOMOD = "Adds frost damage to modifiable weapons.",
		NAPALMMOD = "Adds fire damage to modifiable weapons.",
		SHOCKMOD = "Adds electric damage to modifiable weapons.",

		RESPIRATORMASK = "It provides minor protection against harsh elements.",
		RARISWORD = "This raritanium sword is highly modifiable and extra effective against artificial enemies.",
		RARISPEAR = "Turns that flimsy spear of yours into an effective weapon against artificial or heavily armored creatures.",
		COMMANDO_HELMET = "Provides decent protection and keeps particles from obscuring the wearers view.",

		RARITANIUM_BAR = "Makes raritanium crystals useful",

		NANOBOOST = "An energy restoring drink!",
		
		--- Shoetime mod
		SHOES_HOVER = "The terrain is the thing of the past with these!",
		SHOES_RADIATION = "Protect your feet from those deadly gamma rays.",
	},
	ACTIONS = {
		DODGE_RATCHET = "Dodge",
		DRINK = "Drink",
		VULLARD_SMELT = "Smelt",
	},
	UI = {
		LOADING_SCREEN_LORE_TIPS = {
			DIMENSIONAL_RIFT = "Danger leaks from the rifts. It is rumored to be a tear from the space below.",
			PORTALS = "It is believed that the rifts lead to somewhere...but as of right now the radiation that may originate from space or a sewer is too potent to start traveling there as of now.",					
		},
		LOADING_SCREEN_SURVIVAL_TIPS = {
			RADIATION = "Radiation is a deadly affliction that will lead to certain death. Protect yourself accordigly with the appropiate gear, and eat proper food to prevent poisoning.",
			AFFLICTION = "The effects of radiation sickness comes with supposedly random afflictions. But death is always a guarantee.",
			ARMORED = "Make sure you are equipped with magical or properly reinforced weapons. Armored enemies and those encased in metal will break stone, glass and naturally dropped weapons faster.",
			RARITANIUM = "Raritanium is an extremely durable crystal that is widely used in the creation of equipment modifications, protective armor, and weapons. Collecting these crystals and refining them may prove useful against armored enemies and combating radioactive effects.",
			DIMENSIONAL_RIFT = "Beware the Rifts. These highly radioactive portals spew out monsters, and many objects from alternative realities.",
			CAVE_BANANA = "Some foods may cause radioactive effects, especially bananas. Be careful with how many you eat because even your equipment can't save you.",
			LUNAR = "Creatures of lunar alignment are immune to radioactive effects, but in turn they have a high chance of afflicting a lethal dose of radiation to their targets.",
			SMELTER = "Only the smelter found in a vast junkyard biome can refine raritanium. Survivors must seek it out to craft new gear that can combat armored enemies and the deadly effects of radiation.",
		},
		LOADING_SCREEN_OTHER_TIPS = {
			CONFIGS = "Is the current configs not to your liking? If not, then you can always tweak Rift Together's settings in configurations!",
			BIOMES = "Are you tired of traveling to the island smelter? Fear not, you can always toggle Rift Together's biomes to generate on the mainland instead.",
			WIKI = "Having trouble with finding something? Don't know what something does? Check out Rift Together's wiki found on the mod page!",	
			COMPAT = "To activate Rift Together's effects in other mods. Make sure compatibility is toggled on in configs.",
		},				
	},
	
}

TransferTable(strings, STRINGS)

---Performance for Ratchet

general_scripts.RATCHET1 = {
	cast = {"ratchet"},
	lines = {
		{roles = {"ratchet"}, 	duration = 1.5, line = STRINGS.STAGEACTOR.RATCHET1[1], 		anim = "emote_waving"},
		{roles = {"ratchet"}, 	duration = 3, 	line = STRINGS.STAGEACTOR.RATCHET1[2]},
		{actionfn = fn.callbirds, 	duration = 1.5},
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[3]}, 	
		{roles = {"BIRD2"}, 	duration = 1.5, line = STRINGS.STAGEACTOR.RATCHET1[4], 		sgparam = "disappointed"},
		{roles = {"BIRD1"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[5]},
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[6],		anim = "emote_annoyed_facepalm"},
		{roles = {"ratchet"}, 	duration = 1.5, line = STRINGS.STAGEACTOR.RATCHET1[7]},		
		{roles = {"BIRD1"}, 	duration = 1.5, line = STRINGS.STAGEACTOR.RATCHET1[8]},
		{roles = {"BIRD2"}, 	duration = 1, 	line = STRINGS.STAGEACTOR.RATCHET1[9]},
		{roles = {"ratchet"}, 	duration = 1.8, line = STRINGS.STAGEACTOR.RATCHET1[10]}, 	
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[11]},
		{roles = {"ratchet"}, 	duration = 1.8, line = STRINGS.STAGEACTOR.RATCHET1[12]},
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[13]},
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[14],     anim= "look"},
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[15]},
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[16]},
		{roles = {"BIRD1"}, 	duration = 1.5, line = STRINGS.STAGEACTOR.RATCHET1[17], 	sgparam = "laugh"},
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[18]}, 	
		{roles = {"ratchet"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[19],     anim= "emote_strikepose"},
		{roles = {"ratchet"}, 	duration = 3.5, 	line = STRINGS.STAGEACTOR.RATCHET1[20],		anim= "emote_shrug"},
		{roles = {"BIRD2"}, 	duration = 2, 	line = STRINGS.STAGEACTOR.RATCHET1[21], 	sgparam = "disappointed"},
		
		{roles = {"ratchet"}, 	duration = 3, 	line = STRINGS.STAGEACTOR.RATCHET1[22],		anim = "emote_annoyed_palmdown"},
		{roles = {"ratchet"}, 	duration = 1.5, line = STRINGS.STAGEACTOR.RATCHET1[23], 	anim = {"idle_hot_loop", "idle_hot_pst"}},	
		{actionfn = fn.exitbirds, 	duration = 1},
	}
}



