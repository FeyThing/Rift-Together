STRINGS.CHARACTERS.RATCHET = require "speech_ratchet"
--STRINGS.CHARACTERS.NEFARIOUS = require "speech_nefarious"


local strings = {
	CHARACTER_TITLES = {
		ratchet = "The Galactic Hero",
		nefarious = "The Robotic Mastermind",
	},
	CHARACTER_NAMES = {
		ratchet = "Ratchet",
		nefarious = "Nefarious",
	},
	SKIN_NAMES = {
		ratchet_none = "Ratchet",
		nefarious_none = "Nefarious",
		ms_rivet = "The Interdimensional Rebel",
		ms_owrench_hammer = "Rivet's Hammer",
	},
	SKIN_DESCRIPTIONS = {
		ms_rivet = "Ratchet's dimensional counterpart, Rivet.",
		ms_owrench_hammer = "A hammer used by Ratchet's counterpart, Rivet.",
	},
	SKIN_QUOTES = {
		ms_rivet = "W...where am I?.",
	},
	CHARACTER_DESCRIPTIONS = {
		ratchet = "*Starts with a modifiable wrench\n*Is very nimble\n*Fearless",
		nefarious = "*Cannot wear armor\n*Doesn't get hungry as fast\n*Abilities are powered by energy",
	},
	CHARACTER_QUOTES = {
		ratchet = "\"Clank? Where are you!\"",
		nefarious = "\"LAWRENCE!!!\"",
	},
	CHARACTER_SURVIVABILITY = {
		ratchet = "Slim",
		nefarious = "Grim",
	},
	CHARACTER_ABOUTME = {
		ratchet = "",
		nefarious = "Insert text here",
	},
	CHARACTER_BIOS = {
		ratchet = {
					{ title = "Birthday", desc = "Unknown" },
					{ title = "Favorite Food", desc = "Unknown" },
					{ title = "Past...", desc = "Ratchet, an orphen originally born from Fastoon, is a headstrong and challenge seeking savior of multiple galaxies. Originally a jerk, he has now developed a light-hearted yet wise-cracking personality with the help of clank, his best friend. Though he has struggled balancing his own needs and those of others, he always chooses the right thing to do in order to keep the universe safe. Especially his friends and his foster home, Veldin."},
				},
		
		nefarious = {
					{ title = "Birthday", desc = "Unknown" },
					{ title = "Favorite Food", desc = "Unknown" },
					{ title = "Past...", desc = "Is yet to be revealed."},
				},
		
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

				VULLARD_LAMP = "Looks like someone made them with scrap.",
				SCRAPROCK = "I hear something coming from it.",
				JUNKPILE = "I should be careful touching it with bare hands.",
				VULLARD_SMELTER = "That's incredibly hot! I could make something useful with this.",
				
				
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

				NANOTECH = "Nanotech, just what the doctor ordered.",
				NANOCRATE = "This could patch me up!",
				RARITANIUMORE = "Raritanium! I wonder if I could use it for upgrades?",
				RARITANIUM_CRYSTALS = "That looks like raritanium.",
				SCRAPMETAL = "Maybe I could make use of this scrap.",
				DIMENSIONAL_RIFT = "It must be the work of the dimensionator. I need to find a way to close it.",

				HOUND_ROBOMUTT = "Oh no, not these things again.",

				VULLARD_LAMP = "Huh, seems like the work of vullards.",
				SCRAPROCK = "Maybe if I bust it open, I'll find something of use.",
				JUNKPILE = "That's your typical vullard pile of junk.",
				VULLARD_SMELTER = "Oh hey, reminds me of home. Maybe I can make use of the scrap around here.",
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
		
		NANOTECH = "Nanotech",
		NANOCRATE = "Nanotech Crate",
		RARITANIUMORE = "Raritanium Crystal",
		RARITANIUM_BAR= "Refined Raritanium",
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

		HOUND_ROBOMUTT = "RoboMutt",

		VULLARD_LAMP = "Junk Lamp",
		SCRAPROCK = "Scrap Mound",
		JUNKPILE = "Junk Pile",
		VULLARD_SMELTER = "Smelter",

		RADIATION = "Radiation",
	},

	RECIPE_DESC = {
		OWRENCH = "Just in case I ever misplace it.",

		CRYOMOD = "Adds frost damage to modifiable weapons.",
		NAPALMMOD = "Adds fire damage to modifiable weapons.",
		SHOCKMOD = "Adds electric damage to modifiable weapons.",

		RESPIRATORMASK = "It provides minor protection against harsh elements.",
		RARISWORD = "This raritanium sword is highly modifiable and extra effective against artificial enemies.",
		RARISPEAR = "Turns that flimsy spear of yours into an effective weapon against artificial creatures.",

		RARITANIUM_BAR = "Makes raritanium crystals useful",

		NANOBOOST = "An energy restoring drink!",
	},
	ACTIONS = {
		DODGE_RATCHET = "Dodge"
	},
}

TransferTable(strings, STRINGS)





