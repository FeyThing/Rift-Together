local strings = {
	CHARACTER_TITLES = {
		ratchet = "The Galactic Hero",
		nefarious = "The Robotic Mastermind",
	},
	CHARACTER_NAMES = {
		ratchet = "Ratchet",
		nefarious = "Nefarious",
	},
	CHARACTER_DESCRIPTIONS = {
		ratchet = "*Starts with a wrench\n*Modifiable Weapons\n*Levels up\n*Fearless",
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
	CHARACTERS = {
		ratchet = require("speech_ratchet"),
		nefarious = require("speech_nefarious"),

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
					GENERIC = "TO-DO",
					ATTACKER = "TO-DO",
					MURDERER = "TO-DO",
					REVIVER = "TO-DO",
					GHOST = "TO-DO",
				},

				ANNOUNCE_IRRITATED = "I feel sore.",
				ANNOUNCE_PAIN = "My entire body hurts.",
				ANNOUNCE_SUFFERING = "It's so painful.",
				ANNOUNCE_DYING = "No! I must leave! I cannot take it anymore.",

				OWRENCH = "It's an oversized wrench.",
				
				NANOTECH = "It emits some sort of aura.",
				NANOCRATE = "It glows faintly.",
				RARITANIUMORE = "Hey, this could help!",
				RARITANIUM_BAR= "Now it's more useful!",
				RARITANIUM_CRYSTALS= "Looks like some sort of crystal formation.",
				SCRAPMETAL = "Pieces of metal litter the ground.",

				TORREN_GRASS = "It's a strange patch of grass.",
				TORREN_CACTUS = "It's a large cactus.",

				NANOBOOST = "That looks refreshing.",

				HOUND_ROBOMUTT= "Their teeth are sharp!",

				VULLARD_LAMP= "Looks like someone made them with scrap.",
				SCRAPMOUND = "I hear something coming from it.",
				JUNKPILE= "I should be careful touching it with bare hands.",
				VULLARD_SMELTER= "That's incredibly hot! I could maybe make something with this.",
			},
		},

		RATCHET = {
			DESCRIBE = {
				OWRENCH = "My trusty wrench!",
				
				CRYOMOD = "Let's add some cold damage to it!",
				NAPALMMOD = "Let's add heat to it!",
				SHOCKMOD = "Let's electrify it!",

				COMMANDO_HELMET = "Should provide some great protection!",

				NANOTECH = "Nanotech, just what the doctor ordered.",
				NANOCRATE = "This could patch me up!",
				RARITANIUMORE = "Raritanium! I wonder if I could use it for upgrades?",
				RARITANIUM_CRYSTALS = "That looks like raritanium.",
				SCRAPMETAL = "Maybe I could make use of this scrap.",

				HOUND_ROBOMUTT = "Not these thing again.",

				VULLARD_LAMP = "Huh, seems like the work of vullards.",
				SCRAPMOUND = "Oh no, not more scrap metal.",
				JUNKPILE = "That's your typical vullard pile of junk.",
				VULLARD_SMELTER = "Oh hey, reminds me of home. Maybe I can make use of the scrap around here.",
			},
		},
	},
	
	NAMES = {
		ratchet = "Ratchet",
		nefarious = "Nefarious",

		OWRENCH = "OmniWrench",

		CRYOMOD = "Cryo Modification",
		NAPALMMOD = "Napalm Modification",
		SHOCKMOD = "Shock Modification",

		COMMANDO_HELMET = "Commando helmet",

		NANOTECH = "Nanotech",
		NANOCRATE = "Nanotech Crate",
		RARITANIUMORE = "Raritanium Crystal",
		RARITANIUM_BAR= "Refined Raritanium",
		RARITANIUM_CRYSTALS= "Raritanium",
		SCRAPMETAL = "Scrap Metal",
		TORREN_GRASS = "Alien Grass",
		TORREN_CACTUS = "Cactus",

		NANOBOOST = "Nanotech Boost",

		HOUND_ROBOMUTT = "RoboMutt",

		VULLARD_LAMP = "Junk Lamp",
		SCRAPMOUND = "Scrap Mound",
		JUNKPILE = "Junk Pile",
		VULLARD_SMELTER = "Smelter",
	},
	SKIN_NAMES = {
		ratchet_none = "Ratchet",
		nefarious_none = "Nefarious",
	},
	RECIPE_DESC = {
		OWRENCH = "Just in case I ever misplace it.",

		CRYOMOD = "Adds frost damage to modifiable weapons.",
		NAPALMMOD = "Adds fire damage to modifiable weapons.",
		SHOCKMOD = "Adds electric damage to modifiable weapons.",

		COMMANDO_HELMET = "First issue commando Helmet.",

		RARITANIUM_BAR = "Makes raritanium crystals useful",

		NANOBOOST = "A energy restoring drink!",
	},
	ACTIONS = {
		DODGE_RATCHET = "Dodge"
	},
}

TransferTable(strings, STRINGS)

