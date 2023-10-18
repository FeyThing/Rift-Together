local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS


STRINGS.CHARACTER_TITLES.nefarious = "The Robotic Mastermind"
STRINGS.CHARACTER_NAMES.nefarious = "Nefarious"
STRINGS.CHARACTER_DESCRIPTIONS.nefarious = "*Cannot wear armor\n*Doesn't get hungry as fast\n*Abilities are powered by energy"
STRINGS.CHARACTER_QUOTES.nefarious = "\"LAWRENCE!!!\""
STRINGS.CHARACTER_SURVIVABILITY.nefarious = "Grim"

STRINGS.CHARACTERS.nefarious = require "speech_nefarious"

STRINGS.NAMES.nefarious = "Nefarious"
STRINGS.SKIN_NAMES.nefarious_none = "Nefarious"


STRINGS.CHARACTERS.GENERIC.DESCRIBE.nefarious = 
{
	GENERIC = "He's kinda loud...",
	ATTACKER = "That Nefarious looks suspicious...",
	MURDERER = "Murderer!",
	REVIVER = "Nefarious? I can't believe it.",
	GHOST = "Nefarious could use a heart...I think?",
}


STRINGS.CHARACTER_TITLES.ratchet = "The Galactic Hero"
STRINGS.CHARACTER_NAMES.ratchet = "Ratchet"
STRINGS.CHARACTER_DESCRIPTIONS.ratchet = "*Starts with a wrench\n*Modifiable Weapons\n*Levels up\n*Fearless"
STRINGS.CHARACTER_QUOTES.ratchet = "\"Clank? Where are you!\""
STRINGS.CHARACTER_SURVIVABILITY.ratchet = "Slim"


-- Custom speech strings
STRINGS.CHARACTERS.RATCHET = require "speech_ratchet"

-- The character's name as appears in-game 
STRINGS.NAMES.ratchet = "Ratchet"
STRINGS.SKIN_NAMES.ratchet_none = "Ratchet"

STRINGS.RATCHETSTRINGS ={
[3] = "Dodge",
}


--------------Weapons-----------

GLOBAL.STRINGS.NAMES.OWRENCH = "OmniWrench"
GLOBAL.STRINGS.RECIPE_DESC.OWRENCH= "Just in case I ever misplace it."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.OWRENCH = "It's an oversized wrench."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.OWRENCH = "My trusty wrench!"

GLOBAL.STRINGS.NAMES.CRYOMOD= "Cryo Modification"
GLOBAL.STRINGS.RECIPE_DESC.CRYOMOD= "Adds frost damage to modifiable weapons."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.CRYOMOD= "Let's add some cold damage to it!"

GLOBAL.STRINGS.NAMES.NAPALMMOD= "Napalm Modification"
GLOBAL.STRINGS.RECIPE_DESC.NAPALMMOD= "Adds fire damage to modifiable weapons."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.NAPALMMOD= "Let's add heat to it!"

GLOBAL.STRINGS.NAMES.SHOCKMOD= "Shock Modification"
GLOBAL.STRINGS.RECIPE_DESC.SHOCKMOD= "Adds electric damage to modifiable weapons."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.SHOCKMOD= "Let's electrify it!"

--------------Armor-----------

GLOBAL.STRINGS.NAMES.COMMANDO_HELMET= "Commando helmet"
GLOBAL.STRINGS.RECIPE_DESC.COMMANDO_HELMET= "First issue commando Helmet."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.COMMANDO_HELMET= "Should provide some great protection!"

--------------Resources-----------

GLOBAL.STRINGS.NAMES.NANOTECH = "Nanotech"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.NANOTECH = "It emits some sort of aura."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.NANOTECH = "Nanotech, just what the doctor ordered."

GLOBAL.STRINGS.NAMES.NANOCRATE = "Nanotech Crate"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.NANOCRATE = "It glows faintly."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.NANOCRATE = "This could patch me up!"

GLOBAL.STRINGS.NAMES.RARITANIUMORE = "Raritanium Crystal"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.RARITANIUMORE = "Hey, this could help!"
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.RARITANIUMORE = "Raritanium! I wonder if I could use it for upgrades?"

GLOBAL.STRINGS.NAMES.RARITANIUM_BAR= "Refined Raritanium"
GLOBAL.STRINGS.RECIPE_DESC.RARITANIUM_BAR= "Makes raritanium crystals useful"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.RARITANIUM_BAR= "Now it's more useful!"

GLOBAL.STRINGS.NAMES.RARITANIUM_CRYSTALS= "Raritanium"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.RARITANIUM_CRYSTALS= "Looks like some sort of crystal formation."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.RARITANIUM_CRYSTALS= "That looks like raritanium."

GLOBAL.STRINGS.NAMES.SCRAPMETAL = "Scrap Metal"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCRAPMETAL = "Pieces of metal litter the ground."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.SCRAPMETAL = "Maybe I could make use of this scrap."

GLOBAL.STRINGS.NAMES.TORREN_GRASS = "Alien Grass"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.TORREN_GRASS = "It's a strange patch of grass."

GLOBAL.STRINGS.NAMES.TORREN_CACTUS = "Cactus"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.TORREN_CACTUS = "It's a large cactus."

----------------Food-------------

GLOBAL.STRINGS.NAMES.NANOBOOST = "Nanotech Boost"
GLOBAL.STRINGS.RECIPE_DESC.NANOBOOST = "A energy restoring drink!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.NANOBOOST = "That looks refreshing."

----------------Mobs-------------

GLOBAL.STRINGS.NAMES.HOUND_ROBOMUTT= "RoboMutt"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HOUND_ROBOMUTT= "Their teeth are sharp!"
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.HOUND_ROBOMUTT= "Not these thing again."

-------------Structures-----------

GLOBAL.STRINGS.NAMES.VULLARD_LAMP= "Junk Lamp"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.VULLARD_LAMP= "Looks like someone made them with scrap."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.VULLARD_LAMP= "Huh, seems like the work of vullards."

GLOBAL.STRINGS.NAMES.SCRAPMOUND = "Scrap Mound"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCRAPMOUND = "I hear something coming from it."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.SCRAPMOUND = "Oh no, not more scrap metal."

GLOBAL.STRINGS.NAMES.JUNKPILE= "Junk Pile"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.JUNKPILE= "I should be careful touching it with bare hands."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.JUNKPILE= "That's your typical vullard pile of junk."

GLOBAL.STRINGS.NAMES.VULLARD_SMELTER= "Smelter"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.VULLARD_SMELTER= "That's incredibly hot! I could maybe make something with this."
GLOBAL.STRINGS.CHARACTERS.RATCHET.DESCRIBE.VULLARD_SMELTER= "Oh hey, reminds me of home. Maybe I can make use of the scrap around here."

GLOBAL.STRINGS.NAMES.CHESSJUNK4 = "Broken Clockworks"
GLOBAL.STRINGS.NAMES.CHESSJUNK5 = "Broken Clockworks"
GLOBAL.STRINGS.NAMES.CHESSJUNK6 = "Broken Clockworks"


-------------Announce------------------

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ANNOUNCE_IRRITATED = "I feel sore."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ANNOUNCE_PAIN = "My entire body hurts."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ANNOUNCE_SUFFERING = "It's so painful."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ANNOUNCE_DYING = "No! I must leave! I cannot take it anymore."