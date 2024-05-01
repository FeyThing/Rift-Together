
return {
	ACTIONFAIL =
	{
        APPRAISE =
        {
            NOTNOW = "They must be busy now.",
        },
        REPAIR =
        {
            WRONGPIECE = "I don't think that was right.",
        },
        BUILD =
        {
            MOUNTED = "I can't place that from way up here.",
            HASPET = "I think one is more than enough.",
			TICOON = "I'm too invested in my own little bud to follow another one.",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "Eh, not a good idea.",
			GENERIC = "Sorry can't shave that!",
			NOBITS = "Well I guess it's better them than me!",
            REFUSE = "only_used_by_woodie",
            SOMEONEELSESBEEFALO = "Wellllll, it would be funny but clank would disapprove...",
		},
		STORE =
		{
			GENERIC = "It's a bit too full.",
			NOTALLOWED = "I don't think that can go in there.",
			INUSE = "I should be patient.",
            NOTMASTERCHEF = "Clank is the better chef. I'm more of an eat on the go kind of guy.",
		},
        CONSTRUCT =
        {
            INUSE = "Son of a blarg, someone beat me to it.",
            NOTALLOWED = "It won't fit.",
            EMPTY = "Even with my wrench, I don't think I can build it without proper tools.",
            MISMATCH = "I think I grabbed the wrong schematics.",
            NOTREADY = "Eventhing is way too unstable for it to work properly.",
        },
		RUMMAGE =
		{
			GENERIC = "Not right now.",
			INUSE = "Alright Ratchet, be patient. They'll be done soon.",
            NOTMASTERCHEF = "Clank is the better chef. I'm more of an eat on the go kind of guy.",
		},
		UNLOCK =
        {
        	WRONGKEY = "Ah, wrong key.",
        },
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "Erugh! Doesn't fit.",
        	KLAUS = "I'm a little preoccupied!!",
			QUAGMIRE_WRONGKEY = "Whelp looks like I need to find the right key.",
        },
		ACTIVATE =
		{
			LOCKED_GATE = "The gate is locked.",
            HOSTBUSY = "Son of a Qwark!",
            CARNIVAL_HOST_HERE = "There must be an owner somewhere.",
            NOCARNIVAL = "I guess they all left.",
			EMPTY_CATCOONDEN = "Nothing here.",
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDERS = "It would be too easy, perhaps if there were more of these little guys...",
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDING_SPOTS = "There aren't a lot of places around for them to hide.",
			KITCOON_HIDEANDSEEK_ONE_GAME_PER_DAY = "I think that's enough for one day.",
            MANNEQUIN_EQUIPSWAPFAILED = "I don't think he can wear this.",
            PILLOWFIGHT_NO_HANDPILLOW = "I don't have a pillow.",
		},
		OPEN_CRAFTING =
		{
            PROFESSIONALCHEF = "I better leave this to someone like clank.",
			SHADOWMAGIC = "Something tells me that I should not mess with this kind of stuff.",
		},
        COOK =
        {
            GENERIC = "I can't cook right now.",
            INUSE = "I better wait my turn.",
            TOOFAR = "I can't reach that far!",
        },
        START_CARRAT_RACE =
        {
            NO_RACERS = "I think I'm missing something here.",
        },

		DISMANTLE =
		{
			COOKING = "Must...resist the need to upgrade it. Must keep my hands to myself.",
			INUSE = "I'll wait until it's my turn.",
			NOTEMPTY = "Whoa, I better clean this out first.",
        },
        FISH_OCEAN =
		{
			TOODEEP = "Something tells me that this isn't made to work here.",
		},
        OCEAN_FISHING_POND =
		{
			WRONGGEAR = "That's way too shallow for this kind of tool.",
		},
        --wickerbottom specific action
        READ =
        {
            GENERIC = "only_used_by_waxwell_and_wicker",
            NOBIRDS = "only_used_by_waxwell_and_wicker",
            NOWATERNEARBY = "only_used_by_waxwell_and_wicker",
            TOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
            WAYTOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
            NOFIRES =       "only_used_by_waxwell_and_wicker",
            NOSILVICULTURE = "only_used_by_waxwell_and_wicker",
            NOHORTICULTURE = "only_used_by_waxwell_and_wicker",
            NOTENTACLEGROUND = "only_used_by_waxwell_and_wicker",
            NOSLEEPTARGETS = "only_used_by_waxwell_and_wicker",
            TOOMANYBEES = "only_used_by_waxwell_and_wicker",
            NOMOONINCAVES = "only_used_by_waxwell_and_wicker",
            ALREADYFULLMOON = "only_used_by_waxwell_and_wicker",
        },

        GIVE =
        {
            GENERIC = "That doesn't go there.",
            DEAD = "Maybe I'll just hold on to this.",
            SLEEPING = "I shouldn't wake them up.",
            BUSY = "I'll try again in a second.",
            ABIGAILHEART = "It was worth a shot.",
            GHOSTHEART = "Perhaps this is a bad idea.",
            NOTGEM = "I'm not sticking that in there!",
            WRONGGEM = "This gem won't work here.",
            NOTSTAFF = "It's not quite the right shape.",
            MUSHROOMFARM_NEEDSSHROOM = "Maybe it needs mushrooms.",
            MUSHROOMFARM_NEEDSLOG = "I think it needs one of those funny logs.",
            MUSHROOMFARM_NOMOONALLOWED = "I don't think they want to be planted.",
            SLOTFULL = "We already put something there.",
            FOODFULL = "There's already a meal there.",
            NOTDISH = "It won't want to eat that.",
            DUPLICATE = "Eh, I think I already learned this.",
            NOTSCULPTABLE = "I think that's impossible.",
            NOTATRIUMKEY = "It's not quite the right shape.",
            CANTSHADOWREVIVE = "It won't resurrect.",
            WRONGSHADOWFORM = "It's not put together right.",
            NOMOON = "I need to see the moon for that to work.",
			PIGKINGGAME_MESSY = "I need to clean up first.",
			PIGKINGGAME_DANGER = "It's too dangerous for that right now.",
			PIGKINGGAME_TOOLATE = "It's too late for that now.",
			CARNIVALGAME_INVALID_ITEM = "I need to buy some tokens.",
			CARNIVALGAME_ALREADY_PLAYING = "A game is already underway.",
            SPIDERNOHAT = "I can't fit them together in my pocket",
            TERRARIUM_REFUSE = "Maybe I should experiment with different kinds of fuel...",
            TERRARIUM_COOLDOWN = "I suppose the tree has to grow back before we can give it anything.",
            NOTAMONKEY = "This seems to be Qwark's kind of deal. I don't speak monkey.",
            QUEENBUSY = "She seems busy.",
        },
        GIVETOPLAYER =
        {
            FULL = "Your pockets are too full!",
            DEAD = "Maybe I'll just hold on to this.",
            SLEEPING = "I really shouldn't wake them.",
            BUSY = "I'll try again in a second.",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "Your pockets are too full!",
            DEAD = "Maybe I'll just hold on to this.",
            SLEEPING = "I really shouldn't wake them.",
            BUSY = "I'll try again in a second.",
        },
        WRITE =
        {
            GENERIC = "I see nothing wrong with it.",
            INUSE = "I really shouldn't overwrite it.",
        },
        DRAW =
        {
            NOIMAGE = "I can't draw what I can't see.",
        },
        CHANGEIN =
        {
            GENERIC = "I don't want to change right now.",
            BURNING = "It's too dangerous right now!",
            INUSE = "It can only handle one style change at a time.",
            NOTENOUGHHAIR = "There isn't enough fur to style.",
            NOOCCUPANT = "It needs something hitched up.",
        },
        ATTUNE =
        {
            NOHEALTH = "I don't feel well enough.",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "Nice beefalo, oh who am I kidding I think this is a bad idea.",
            INUSE = "Awww come on, someon beat me to it!",
			SLEEPING = "Time to wake up!",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "It's a really bad idea to mess with it when it's angry.",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "I already know that one.",
            CANTLEARN = "I can't learn that one.",

            --MapRecorder/MapExplorer
            WRONGWORLD = "This map was made for some other place.",

			--MapSpotRevealer/messagebottle
			MESSAGEBOTTLEMANAGER_NOT_FOUND = "I can't make anything out in this lighting!",--Likely trying to read messagebottle treasure map in caves

            STASH_MAP_NOT_FOUND = "I don't see an \"X marks the spot\". They must've forgotten to draw it.",-- Likely trying to read stash map  in world without stash                  
        },
        WRAPBUNDLE =
        {
            EMPTY = "I'm completely empty handed.",
        },
        PICKUP =
        {
			RESTRICTION = "I'm not skilled enough to use that.",
			INUSE = "I should be patient.",
            NOTMINE_SPIDER = "only_used_by_webber",
            NOTMINE_YOTC =
            {
                "You're not my carrat.",
                "OW, it bit me!",
            },
			NO_HEAVY_LIFTING = "only_used_by_wanda",
            FULL_OF_CURSES = "I think I'm getting some bad vibes off it.",
        },
        SLAUGHTER =
        {
            TOOFAR = "Awww blarg, it got away.",
        },
        REPLATE =
        {
            MISMATCH = "It needs another type of dish.",
            SAMEDISH = "I only need to use one dish.",
        },
        SAIL =
        {
        	REPAIR = "It doesn't need repairing.",
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "Too soon!",
            BAD_TIMING1 = "My timing is off!",
            BAD_TIMING2 = "Not again!",
        },
        LOWER_SAIL_FAIL =
        {
            "Whoops!",
            "Uh, my bad!",
            "I don't think that's supposed to do that!",
        },
        BATHBOMB =
        {
            GLASSED = "I can't, the surface is glassed over.",
            ALREADY_BOMBED = "That would be a waste of a bath bomb.",
        },
		GIVE_TACKLESKETCH =
		{
			DUPLICATE = "Deja vu, I think I've already sketched this.",
		},
		COMPARE_WEIGHABLE =
		{
            FISH_TOO_SMALL = "Wow, that's really small.",
            OVERSIZEDVEGGIES_TOO_SMALL = "Not quite heavy enough.",
		},
        BEGIN_QUEST =
        {
            ONEGHOST = "only_used_by_wendy",
        },
		TELLSTORY =
		{
			GENERIC = "only_used_by_walter",
			NOT_NIGHT = "only_used_by_walter",
			NO_FIRE = "only_used_by_walter",
		},
        SING_FAIL =
        {
            SAMESONG = "only_used_by_wathgrithr",
        },
        PLANTREGISTRY_RESEARCH_FAIL =
        {
            GENERIC = "I have nothing left to learn.",
            FERTILIZER = "I'd rather not know anything further.",
        },
        FILL_OCEAN =
        {
            UNSUITABLE_FOR_PLANTS = "I don't think that's right.",
        },
        POUR_WATER =
        {
            OUT_OF_WATER = "Looks like it's empty.",
        },
        POUR_WATER_GROUNDTILE =
        {
            OUT_OF_WATER = "I'm out.",
        },
        USEITEMON =
        {
            --GENERIC = "I can't use this on that!",

            --construction is PREFABNAME_REASON
            BEEF_BELL_INVALID_TARGET = "Ah, sorry that doesn't work!",
            BEEF_BELL_ALREADY_USED = "I think it belongs to someone else. I better find my own.",
            BEEF_BELL_HAS_BEEF_ALREADY = "I think one is more than enough for me.",
        },
        HITCHUP =
        {
            NEEDBEEF = "I wonder if this bell could tame those beefalo.",
            NEEDBEEF_CLOSER = "My new beefalo is a bit too far away.",
            BEEF_HITCHED = "I already hitched it up.",
            INMOOD = "Well that's a new turn of events.",
        },
        MARK =
        {
            ALREADY_MARKED = "I've already made my pick.",
            NOT_PARTICIPANT = "I passed up the opportunity.",
        },
        YOTB_STARTCONTEST =
        {
            DOESNTWORK = "I guess they don't support the arts here.",
            ALREADYACTIVE = "He must be busy with another contest somewhere.",
        },
        YOTB_UNLOCKSKIN =
        {
            ALREADYKNOWN = "I'm seeing a familiar pattern... I've learned this already!",
        },
        CARNIVALGAME_FEED =
        {
            TOO_LATE = "I need to be quicker!",
        },
        HERD_FOLLOWERS =
        {
            WEBBERONLY = "They won't listen to me, but they might listen to Webber.",
        },
        BEDAZZLE =
        {
            BURNING = "only_used_by_webber",
            BURNT = "only_used_by_webber",
            FROZEN = "only_used_by_webber",
            ALREADY_BEDAZZLED = "only_used_by_webber",
        },
        UPGRADE =
        {
            BEDAZZLED = "only_used_by_webber",
        },
		CAST_POCKETWATCH =
		{
			GENERIC = "only_used_by_wanda",
			REVIVE_FAILED = "only_used_by_wanda",
			WARP_NO_POINTS_LEFT = "only_used_by_wanda",
			SHARD_UNAVAILABLE = "only_used_by_wanda",
		},
        DISMANTLE_POCKETWATCH =
        {
            ONCOOLDOWN = "only_used_by_wanda",
        },

        ENTER_GYM =
        {
            NOWEIGHT = "only_used_by_wolfang",
            UNBALANCED = "only_used_by_wolfang",
            ONFIRE = "only_used_by_wolfang",
            SMOULDER = "only_used_by_wolfang",
            HUNGRY = "only_used_by_wolfang",
            FULL = "only_used_by_wolfang",
        },

        APPLYMODULE =
        {
            COOLDOWN = "only_used_by_wx78",
            NOTENOUGHSLOTS = "only_used_by_wx78",
        },
        REMOVEMODULES =
        {
            NO_MODULES = "only_used_by_wx78",
        },
        CHARGE_FROM =
        {
            NOT_ENOUGH_CHARGE = "only_used_by_wx78",
            CHARGE_FULL = "only_used_by_wx78",
        },

        HARVEST =
        {
            DOER_ISNT_MODULE_OWNER = "Uninterested I guess.",
        },

		CAST_SPELLBOOK =
		{
			NO_TOPHAT = "only_used_by_waxwell",
		},

		CASTAOE =
		{
			NO_MAX_SANITY = "only_used_by_waxwell",
		},
    },

	ANNOUNCE_CANNOT_BUILD =
	{
		NO_INGREDIENTS = "I maybe good with my hands, but I'm missing some components.",
		NO_TECH = "Seems to be missing further instruction!",
		NO_STATION = "I going to need a proper work station to start working first.",
	},

	ACTIONFAIL_GENERIC = "I can't do that.",
	ANNOUNCE_BOAT_LEAK = "Nonono! We need to patch it up!",
	ANNOUNCE_BOAT_SINK = "Please no sharkgators, please no sharkigators!",
	ANNOUNCE_DIG_DISEASE_WARNING = "It looks better already.", --removed
	ANNOUNCE_PICK_DISEASE_WARNING = "Uh, is it supposed to smell like that?", --removed
	ANNOUNCE_ADVENTUREFAIL = "That didn't go well. I'll have to try again.",
    ANNOUNCE_MOUNT_LOWHEALTH = "Hang on buddy, you can make it.",

    --waxwell and wickerbottom specific strings
    ANNOUNCE_TOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
    ANNOUNCE_WAYTOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
    ANNOUNCE_NOWATERNEARBY = "only_used_by_waxwell_and_wicker",

	--waxwell specific
	ANNOUNCE_SHADOWLEVEL_ITEM = "only_used_by_waxwell",
	ANNOUNCE_EQUIP_SHADOWLEVEL_T1 = "only_used_by_waxwell",
	ANNOUNCE_EQUIP_SHADOWLEVEL_T2 = "only_used_by_waxwell",
	ANNOUNCE_EQUIP_SHADOWLEVEL_T3 = "only_used_by_waxwell",
	ANNOUNCE_EQUIP_SHADOWLEVEL_T4 = "only_used_by_waxwell",

    --wolfgang specific
    ANNOUNCE_NORMALTOMIGHTY = "only_used_by_wolfang",
    ANNOUNCE_NORMALTOWIMPY = "only_used_by_wolfang",
    ANNOUNCE_WIMPYTONORMAL = "only_used_by_wolfang",
    ANNOUNCE_MIGHTYTONORMAL = "only_used_by_wolfang",
    ANNOUNCE_EXITGYM = {
        MIGHTY = "only_used_by_wolfang",
        NORMAL = "only_used_by_wolfang",
        WIMPY = "only_used_by_wolfang",
    },

	ANNOUNCE_BEES = "BEEEEEEEEEEEEES!!!!",
	ANNOUNCE_BOOMERANG = "Owowow! That hurt!",
	ANNOUNCE_CHARLIE = "Somethings following me.",
	ANNOUNCE_CHARLIE_ATTACK = "OW! Show yourself!",
	ANNOUNCE_CHARLIE_MISSED = "only_used_by_winona", --winona specific
	ANNOUNCE_COLD = "Freezing...n...need warmth!",
	ANNOUNCE_HOT = "Hot...hot...hot...need ice!",
	ANNOUNCE_CRAFTING_FAIL = "I'm missing a couple key ingredients.",
	ANNOUNCE_DEERCLOPS = "That doesn't sound good!",
	ANNOUNCE_CAVEIN = "Whoa, look out!",
	ANNOUNCE_ANTLION_SINKHOLE =
	{
		"Is that an earthquake!",
		"I have to keep my footing steady!",
		"Watch out!",
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "It's not much, but you can have it.",
        "I was going to keep it as a souvenir but I guess you can have it.",
        "It's all I have, but here.",
	},
	ANNOUNCE_SACREDCHEST_YES = "Wow, thanks!",
	ANNOUNCE_SACREDCHEST_NO = "Oh no.",
    ANNOUNCE_DUSK = "I better find shelter, it's starting become dark.",

    --wx-78 specific
    ANNOUNCE_CHARGE = "only_used_by_wx78",
	ANNOUNCE_DISCHARGE = "only_used_by_wx78",

	ANNOUNCE_EAT =
	{
		GENERIC = "Oh, nice!",
		PAINFUL = "I don't feel so good.",
		SPOILED = "Yuck! That was terrible!",
		STALE = "That wasn't all that great.",
		INVALID = "No way am I eating that!",
        YUCKY = "Ugh, no way!",

        --Warly specific ANNOUNCE_EAT strings
		COOKED = "only_used_by_warly",
		DRIED = "only_used_by_warly",
        PREPARED = "only_used_by_warly",
        RAW = "only_used_by_warly",
		SAME_OLD_1 = "only_used_by_warly",
		SAME_OLD_2 = "only_used_by_warly",
		SAME_OLD_3 = "only_used_by_warly",
		SAME_OLD_4 = "only_used_by_warly",
        SAME_OLD_5 = "only_used_by_warly",
		TASTY = "only_used_by_warly",
    },

	ANNOUNCE_FOODMEMORY = "only_used_by_warly",

    ANNOUNCE_ENCUMBERED =
    {
        "Huff... Pant...",
        "I...I'm....not...built for this...",
        "Lift...Qwark...need...help...",
        "Hnng...",
        "Where's...Helga...when you...need her!",
        "Why...did...I...leave all...of my...gadgets...at home...",
        "Hngh...I...should...not have...skipped...training with...Helga!",
        "Pant... Pant...",
        "I...wish....I kept....my tractor beam...",
    },
    ANNOUNCE_ATRIUM_DESTABILIZING =
    {
		"I think it's time to leave!",
		"What's that?!",
		"It's not safe here.",
	},
    ANNOUNCE_RUINS_RESET = "Argh, they all came back!",
    ANNOUNCE_SNARED = "Owowow! That's sharp!!",
    ANNOUNCE_SNARED_IVY = "Little help right here! I think the weeds are after me!",
    ANNOUNCE_REPELLED = "It's shielded!",
	ANNOUNCE_ENTER_DARK = "It's pitch dark!",
	ANNOUNCE_ENTER_LIGHT = "I can see again!",
	ANNOUNCE_FREEDOM = "I'm free! I'm finally free!",
	ANNOUNCE_HIGHRESEARCH = "I feel accomplished!",
	ANNOUNCE_HOUNDS = "Clank, is that you?",
	ANNOUNCE_WORMS = "I don't like the feeling of those tremors under my feet...",
	ANNOUNCE_HUNGRY = "Ugh..I'm so hungry!",
	ANNOUNCE_HUNT_BEAST_NEARBY = "Whohoo! The creature must be nearby.",
	ANNOUNCE_HUNT_LOST_TRAIL = "Awww, frak monkeys. I lost it.",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "It's way too wet, I can't seem to find the trail anymore.",
    ANNOUNCE_HUNT_START_FORK = "This trail looks dangerous.",
    ANNOUNCE_HUNT_SUCCESSFUL_FORK = "Ohohoho, you're not getting away from me!",
    ANNOUNCE_HUNT_WRONG_FORK = "I get the feeling that something is watching me.",
    ANNOUNCE_HUNT_AVOID_FORK = "This trail looks safer.",
	ANNOUNCE_INV_FULL = "Sorry my pockets are full!",
	ANNOUNCE_KNOCKEDOUT = "Ugh, my aching head!",
	ANNOUNCE_LOWRESEARCH = "I didn't learn very much from that.",
	ANNOUNCE_MOSQUITOS = "Well they're not mutant swampflies but they're defiantly more annoying!",
    ANNOUNCE_NOWARDROBEONFIRE = "I can't change while it's on fire!",
    ANNOUNCE_NODANGERGIFT = "Bad idea. Somethings lurking around the corner!",
    ANNOUNCE_NOMOUNTEDGIFT = "I should get off this guy first.",
	ANNOUNCE_NODANGERSLEEP = "I should take care of whatever is lurking around before I think about sleeping!",
	ANNOUNCE_NODAYSLEEP = "It's too bright out.",
	ANNOUNCE_NODAYSLEEP_CAVE = "I'm not tired.",
	ANNOUNCE_NOHUNGERSLEEP = "I can't sleep when I'm this hungry!",
	ANNOUNCE_NOSLEEPONFIRE = "No thanks, but I really should douse it.",
    ANNOUNCE_NOSLEEPHASPERMANENTLIGHT = "only_used_by_wx78",
	ANNOUNCE_NODANGERSIESTA = "It's too dangerous to lie down right now!",
	ANNOUNCE_NONIGHTSIESTA = "Yeah, I'm not a fan of relaxing in the middle of the night.",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "I don't think I could really relax down here.",
	ANNOUNCE_NOHUNGERSIESTA = "I can't rest with food on my mind!",
	ANNOUNCE_NO_TRAP = "Well, that was easy.",
	ANNOUNCE_PECKED = "Hey! knock it off!",
	ANNOUNCE_QUAKE = "I don't like the sound of that1",
	ANNOUNCE_RESEARCH = "Whooohoo, one step towards getting outta here!",
	ANNOUNCE_SHELTER = "This tree should help keep some of the weather out.",
	ANNOUNCE_THORNS = "Ow!",
	ANNOUNCE_BURNT = "Yikes! That was hot!",
	ANNOUNCE_TORCH_OUT = "Oh, that's not good!",
	ANNOUNCE_THURIBLE_OUT = "It's depleted.",
	ANNOUNCE_FAN_OUT = "My fan just broke.",
    ANNOUNCE_COMPASS_OUT = "I think it's broken.",
	ANNOUNCE_TRAP_WENT_OFF = "Oops.",
	ANNOUNCE_UNIMPLEMENTED = "OW! I don't think it's ready yet.",
	ANNOUNCE_WORMHOLE = "Well that...was not pleasent.",
	ANNOUNCE_TOWNPORTALTELEPORT = "Still no way back.",
	ANNOUNCE_CANFIX = "\nHey maybe I can fix this!",
	ANNOUNCE_ACCOMPLISHMENT = "I feel so accomplished!",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "If only talwyn were here to see me...",
	ANNOUNCE_INSUFFICIENTFERTILIZER = "I think it needs more.",
	ANNOUNCE_TOOL_SLIP = "Nononono, not the tools!",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Yow, that was close!",
	ANNOUNCE_TOADESCAPING = "The toad is losing interest.",
	ANNOUNCE_TOADESCAPED = "Yeah, run away!",


	ANNOUNCE_DAMP = "Just my day, I'm all wet",
	ANNOUNCE_WET = "I can never get used to being drenched.",
	ANNOUNCE_WETTER = "Aww, not my clothes!",
	ANNOUNCE_SOAKED = "Ugh, I feel like I fell into one of pokitaru's oceans!",

	ANNOUNCE_WASHED_ASHORE = "Th...that was horrible!",

    ANNOUNCE_DESPAWN = "I can see the light!",
	ANNOUNCE_BECOMEGHOST = "oOooOooo!!",
	ANNOUNCE_GHOSTDRAIN = "My humanity is about to start slipping away...",
	ANNOUNCE_PETRIFED_TREES = "Did I just hear trees screaming?",
	ANNOUNCE_KLAUS_ENRAGE = "There's no way to beat it now!!",
	ANNOUNCE_KLAUS_UNCHAINED = "Its chains came off!",
	ANNOUNCE_KLAUS_CALLFORHELP = "I think it's calling for backup!",

	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "There's a form trapped inside.",
		GLASS_LOW = "I've almost got it out.",
		GLASS_REVEAL = "You're free!",
		IDOL_MED = "There's a form trapped inside.",
		IDOL_LOW = "I've almost got it out.",
		IDOL_REVEAL = "You're free!",
		SEED_MED = "There's a form trapped inside.",
		SEED_LOW = "I've almost got it out.",
		SEED_REVEAL = "You're free!",
	},

    --hallowed nights
    ANNOUNCE_SPOOKED = "Did you see that?!",
	ANNOUNCE_BRAVERY_POTION = "Those trees don't seem so spooky anymore.",
	ANNOUNCE_MOONPOTION_FAILED = "Perhaps I didn't let it steep long enough...",

	--winter's feast
	ANNOUNCE_EATING_NOT_FEASTING = "Nothing shows holiday cheer than sharing with others.",
	ANNOUNCE_WINTERS_FEAST_BUFF = "I'm feeling a surge of holiday spirit!",
	ANNOUNCE_IS_FEASTING = "Happy Winter's Feast!",
	ANNOUNCE_WINTERS_FEAST_BUFF_OVER = "The holiday goes by so fast...",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "Let me help you.",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "Good as new!",
    ANNOUNCE_REVIVED_FROM_CORPSE = "It must be nanotech, thank-you.",

    ANNOUNCE_FLARE_SEEN = "I wonder who set that flare?",
    ANNOUNCE_MEGA_FLARE_SEEN = "That flash is gonna bring trouble.",
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "Sea monsters, not sea monsters again.",

    --willow specific
	ANNOUNCE_LIGHTFIRE =
	{
		"only_used_by_willow",
    },

    --winona specific
    ANNOUNCE_HUNGRY_SLOWBUILD =
    {
	    "only_used_by_winona",
    },
    ANNOUNCE_HUNGRY_FASTBUILD =
    {
	    "only_used_by_winona",
    },

    --wormwood specific
    ANNOUNCE_KILLEDPLANT =
    {
        "only_used_by_wormwood",
    },
    ANNOUNCE_GROWPLANT =
    {
        "only_used_by_wormwood",
    },
    ANNOUNCE_BLOOMING =
    {
        "only_used_by_wormwood",
    },

    --wortox specfic
    ANNOUNCE_SOUL_EMPTY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_FEW =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_MANY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_OVERLOAD =
    {
        "only_used_by_wortox",
    },

    --walter specfic
	ANNOUNCE_SLINGHSOT_OUT_OF_AMMO =
	{
		"only_used_by_walter",
		"only_used_by_walter",
	},
	ANNOUNCE_STORYTELLING_ABORT_FIREWENTOUT =
	{
        "only_used_by_walter",
	},
	ANNOUNCE_STORYTELLING_ABORT_NOT_NIGHT =
	{
        "only_used_by_walter",
	},

    -- wx specific
    ANNOUNCE_WX_SCANNER_NEW_FOUND = "only_used_by_wx78",
    ANNOUNCE_WX_SCANNER_FOUND_NO_DATA = "only_used_by_wx78",

    --quagmire event
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "Those ingredients didn't make anything.",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "I left it on too long.",
    QUAGMIRE_ANNOUNCE_LOSE = "I have a bad feeling about this.",
    QUAGMIRE_ANNOUNCE_WIN = "Time to go!",

    ANNOUNCE_ROYALTY =
    {
        "Your majesty.",
        "Your highness.",
        "My liege!",
    },

    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "I feel positively electric!",
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "Let's see how it feels to have a wrench to the face!",
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "I feel much safer now!",
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "Productivity intensifying!",
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "I feel as dry as one of Wickerbottom's lectures!",
    ANNOUNCE_ATTACH_BUFF_SLEEPRESISTANCE   = "I feel so refreshed, I'll never get tired again!",

    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "The electricity's gone, but the static clings.",
    ANNOUNCE_DETACH_BUFF_ATTACK            = "It seems my brawniness was short-lived.",
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "Well, that was nice while it lasted.",
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "Desire to procrastinate... creeping back...",
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "Looks like my dry spell is over.",
    ANNOUNCE_DETACH_BUFF_SLEEPRESISTANCE   = "I'll... (yawn) never get... tired...",

	ANNOUNCE_OCEANFISHING_LINESNAP = "All my hard work, gone in a snap!",
	ANNOUNCE_OCEANFISHING_LINETOOLOOSE = "Maybe reeling would help.",
	ANNOUNCE_OCEANFISHING_GOTAWAY = "It got away.",
	ANNOUNCE_OCEANFISHING_BADCAST = "My casting needs work...",
	ANNOUNCE_OCEANFISHING_IDLE_QUOTE =
	{
		"Where are the fish?",
		"I would have had better luck at Jowai Resort, there's nothing here!",
		"Am I doing something wrong?",
		"At least it's relaxing...",
	},

	ANNOUNCE_WEIGHT = "Weight: {weight}",
	ANNOUNCE_WEIGHT_HEAVY  = "Weight: {weight}\nI'm a fishing heavyweight!",

	ANNOUNCE_WINCH_CLAW_MISS = "I think I missed the mark.",
	ANNOUNCE_WINCH_CLAW_NO_ITEM = "So close.",

    --Wurt announce strings
    ANNOUNCE_KINGCREATED = "only_used_by_wurt",
    ANNOUNCE_KINGDESTROYED = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_THRONE = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_HOUSE = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_WATCHTOWER = "only_used_by_wurt",
    ANNOUNCE_READ_BOOK =
    {
        BOOK_SLEEP = "only_used_by_wurt",
        BOOK_BIRDS = "only_used_by_wurt",
        BOOK_TENTACLES =  "only_used_by_wurt",
        BOOK_BRIMSTONE = "only_used_by_wurt",
        BOOK_GARDENING = "only_used_by_wurt",
		BOOK_SILVICULTURE = "only_used_by_wurt",
		BOOK_HORTICULTURE = "only_used_by_wurt",

        BOOK_FISH = "only_used_by_wurt",
        BOOK_FIRE = "only_used_by_wurt",
        BOOK_WEB = "only_used_by_wurt",
        BOOK_TEMPERATURE = "only_used_by_wurt",
        BOOK_LIGHT = "only_used_by_wurt",
        BOOK_RAIN = "only_used_by_wurt",
        BOOK_MOON = "only_used_by_wurt",
        BOOK_BEES = "only_used_by_wurt",

        BOOK_HORTICULTURE_UPGRADED = "only_used_by_wurt",
        BOOK_RESEARCH_STATION = "only_used_by_wurt",
        BOOK_LIGHT_UPGRADED = "only_used_by_wurt",
    },
    ANNOUNCE_WEAK_RAT = "This carrat is in no shape to be training.",

    ANNOUNCE_CARRAT_START_RACE = "Let the experim- er, race begin!",

    ANNOUNCE_CARRAT_ERROR_WRONG_WAY = {
        "No, no! You're going the wrong way!",
        "Turn around!",
    },
    ANNOUNCE_CARRAT_ERROR_FELL_ASLEEP = "Don't you dare! Wake up, we have a race to win!",
    ANNOUNCE_CARRAT_ERROR_WALKING = "Don't walk, RUN!",
    ANNOUNCE_CARRAT_ERROR_STUNNED = "Get up! GO GO!",

    ANNOUNCE_GHOST_QUEST = "only_used_by_wendy",
    ANNOUNCE_GHOST_HINT = "only_used_by_wendy",
    ANNOUNCE_GHOST_TOY_NEAR = {
        "only_used_by_wendy",
    },
	ANNOUNCE_SISTURN_FULL = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_DEATH = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_RETRIEVE = "only_used_by_wendy",
	ANNOUNCE_ABIGAIL_LOW_HEALTH = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_SUMMON =
	{
		LEVEL1 = "only_used_by_wendy",
		LEVEL2 = "only_used_by_wendy",
		LEVEL3 = "only_used_by_wendy",
	},

    ANNOUNCE_GHOSTLYBOND_LEVELUP =
	{
		LEVEL2 = "only_used_by_wendy",
		LEVEL3 = "only_used_by_wendy",
	},

    ANNOUNCE_NOINSPIRATION = "only_used_by_wathgrithr",
    ANNOUNCE_BATTLESONG_INSTANT_TAUNT_BUFF = "only_used_by_wathgrithr",
    ANNOUNCE_BATTLESONG_INSTANT_PANIC_BUFF = "only_used_by_wathgrithr",

    ANNOUNCE_WANDA_YOUNGTONORMAL = "only_used_by_wanda",
    ANNOUNCE_WANDA_NORMALTOOLD = "only_used_by_wanda",
    ANNOUNCE_WANDA_OLDTONORMAL = "only_used_by_wanda",
    ANNOUNCE_WANDA_NORMALTOYOUNG = "only_used_by_wanda",

	ANNOUNCE_POCKETWATCH_PORTAL = "Nobody told me time travel would be such a pain in the rear...",

	ANNOUNCE_POCKETWATCH_MARK = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_RECALL = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL_DIFFERENTSHARD = "only_used_by_wanda",

    ANNOUNCE_ARCHIVE_NEW_KNOWLEDGE = "Well that's a new discovery! ",
    ANNOUNCE_ARCHIVE_OLD_KNOWLEDGE = "I already knew that.",
    ANNOUNCE_ARCHIVE_NO_POWER = "Maybe it needs more juice.",

    ANNOUNCE_PLANT_RESEARCHED =
    {
        "Well that's something I didn't think I'll learn.",
    },

    ANNOUNCE_PLANT_RANDOMSEED = "I am curious of what it could grow into.",

    ANNOUNCE_FERTILIZER_RESEARCHED = "I never thought I'd end up doing this of all things.",

	ANNOUNCE_FIRENETTLE_TOXIN =
	{
		"My insides are burning!",
		"Ouch, that's hot!",
	},
	ANNOUNCE_FIRENETTLE_TOXIN_DONE = "Note to self: Not everything is for consumption.",

	ANNOUNCE_TALK_TO_PLANTS =
	{
        "Alright little guy, you can do it!",
        "Hey pal, how you doing?.",
		"Want to grow for me?",
        "What a nice plant you are.",
        "Come on, come on!",
	},

	ANNOUNCE_KITCOON_HIDEANDSEEK_START = "3, 2, 1... Ready or not, here I come!",
	ANNOUNCE_KITCOON_HIDEANDSEEK_JOIN = "Aww, they're playing hide and seek.",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND =
	{
		"Found you!",
		"Gotcha!",
		"I knew you'd be hiding there!",
		"I see you!",
	},
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_ONE_MORE = "There's only one left?",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE = "I found the last one!",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE_TEAM = "{name} found the last one!",
	ANNOUNCE_KITCOON_HIDANDSEEK_TIME_ALMOST_UP = "These little guys must be getting impatient...",
	ANNOUNCE_KITCOON_HIDANDSEEK_LOSEGAME = "I guess play time is over...",
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR = "They probably wouldn't hide this far away, would they?",
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR_RETURN = "The kitcoons should be nearby.",
	ANNOUNCE_KITCOON_FOUND_IN_THE_WILD = "Ahaha, I knew it!",

	ANNOUNCE_TICOON_START_TRACKING	= "He's caught the scent!",
	ANNOUNCE_TICOON_NOTHING_TO_TRACK = "Looks like he couldn't find anything.",
	ANNOUNCE_TICOON_WAITING_FOR_LEADER = "I should follow him!",
	ANNOUNCE_TICOON_GET_LEADER_ATTENTION = "He really wants me to follow him.",
	ANNOUNCE_TICOON_NEAR_KITCOON = "He must have found something!",
	ANNOUNCE_TICOON_LOST_KITCOON = "Looks like someone else found what he was looking for.",
	ANNOUNCE_TICOON_ABANDONED = "I'll find those little guys on my own.",
	ANNOUNCE_TICOON_DEAD = "Poor little guy...",

    -- YOTB
    ANNOUNCE_CALL_BEEF = "Come on over!",
    ANNOUNCE_CANTBUILDHERE_YOTB_POST = "The judge won't be able to see my beefalo from here.",
    ANNOUNCE_YOTB_LEARN_NEW_PATTERN =  "My mind has been filled with beefalo styling inspiration!",

    -- AE4AE
    ANNOUNCE_EYEOFTERROR_ARRIVE = "Deja vu, it can't be another nether!",
    ANNOUNCE_EYEOFTERROR_FLYBACK = "Finally!",
    ANNOUNCE_EYEOFTERROR_FLYAWAY = "Get back here, I'm not finished with you yet!",

    -- PIRATES
    ANNOUNCE_CANT_ESCAPE_CURSE = "Of course it couldn't be that easy.",
    ANNOUNCE_MONKEY_CURSE_1 = "I'm feeling a little wonkey...",
    ANNOUNCE_MONKEY_CURSE_CHANGE = "Hey! What's happening to me!",
    ANNOUNCE_MONKEY_CURSE_CHANGEBACK = "N...never again!",

    ANNOUNCE_PIRATES_ARRIVE = "Is...is that a shanty?",

    ANNOUNCE_BOOK_MOON_DAYTIME = "only_used_by_waxwell_and_wicker",

    ANNOUNCE_OFF_SCRIPT = "I have a feeling that wasn't in the script.",

    ANNOUNCE_COZY_SLEEP = "I feel so refreshed!",

	--
	ANNOUNCE_TOOL_TOOWEAK = "I need a stronger tool!",

    ANNOUNCE_LUNAR_RIFT_MAX = "That flash! Was that moonlight?",
    ANNOUNCE_SHADOW_RIFT_MAX = "Something is wrong, very very wrong.",

    ANNOUNCE_SCRAPBOOK_FULL = "I already have all these.",

    ANNOUNCE_CHAIR_ON_FIRE = "This is fine.",

    ANNOUNCE_COACH = 
    {
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
    },
    ANNOUNCE_WOLFGANG_WIMPY_COACHING = "only_used_by_wolfgang",
    ANNOUNCE_WOLFGANG_MIGHTY_COACHING = "only_used_by_wolfgang",
    ANNOUNCE_WOLFGANG_BEGIN_COACHING = "only_used_by_wolfgang",
    ANNOUNCE_WOLFGANG_END_COACHING = "only_used_by_wolfgang",
    ANNOUNCE_WOLFGANG_NOTEAM = 
    {
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
    },

	BATTLECRY =
	{
		GENERIC = "Take this!",
		PIG = "Come and get some!",
		PREY = "Come here!",
		SPIDER = "Let's go!",
		SPIDER_WARRIOR = "Let's see if you can fight better than your pals here!",
		DEER = "You're blaster slag!",
	},
	COMBAT_QUIT =
	{
		GENERIC = "Eh, I'll leave it!",
		PIG = "I'll let him go. This time.",
		PREY = "Can't keep up!",
		SPIDER = "Good it's leaving.",
		SPIDER_WARRIOR = "Seems to have lost interest.",
	},

	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "Doesn't look like the rift I came from. I need to find my way home.",
        MULTIPLAYER_PORTAL_MOONROCK = "Maybe Clank has some explanation for it?",
        MOONROCKIDOL = "Huh, that's strange.",
        CONSTRUCTION_PLANS = "Hey, these look like schematics!",

        ANTLION =
        {
            GENERIC = "Maybe I should fetch something for it.",
            VERYHAPPY = "It seems satisfied.",
            UNHAPPY = "I don't think it's pleased.",
        },
        ANTLIONTRINKET = "Hey! I wonder if clank would like it as a souvenir. If not I'm sure someone else will take it.",
        SANDSPIKE = "Whoa, that was a close one!",
        SANDBLOCK = "It's so gritty!",
        GLASSSPIKE = "Whoa, not again!",
        GLASSBLOCK = "Huh, interesting.",
        ABIGAIL_FLOWER =
        {
            GENERIC ="It's hauntingly beautiful.",
			LEVEL1 = "Do you need some alone time?",
			LEVEL2 = "I think she's starting to open up to us.",
			LEVEL3 = "Looks like someone's feeling especially spirited today!",

			-- deprecated
            LONG = "It hurts my soul to look at that thing.",
            MEDIUM = "It's giving me the creeps.",
            SOON = "Something is up with that flower!",
            HAUNTED_POCKET = "I don't think I should hang on to this.",
            HAUNTED_GROUND = "I'd die to find out what it does.",
        },

        BALLOONS_EMPTY = "Reminds me of somewhere.",
        BALLOON = "I've seen them at the festival before. But not these kinds.",
		BALLOONPARTY = "Huh, neat.",
		BALLOONSPEED =
        {
            DEFLATED = "Now it's just another balloon.",
            GENERIC = "The hole in the center makes it more aerodynamic, that's just physics!",
        },
		BALLOONVEST = "I know Clank would scold me for it. But if I had a needle to stop the squeaking, I would so help me...",
		BALLOONHAT = "It makes my fur stand up.",

        BERNIE_INACTIVE =
        {
            BROKEN = "It finally fell apart.",
            GENERIC = "It's all scorched.",
        },

        BERNIE_ACTIVE = "It must have some mechnical component that makes it move. Right?",
        BERNIE_BIG = "Whoa, it's just like clank, or is it?",

		BOOKSTATION =
		{
			GENERIC = "Nah, I don't need to read right now.",
			BURNT = "Well that's unfortunate.",
		},
        BOOK_BIRDS = "I think Clank would prefer it.",
        BOOK_TENTACLES = "Whoa, okay not for me.",
        BOOK_GARDENING = "I really don't get it.",
		BOOK_SILVICULTURE = "I'll stick to building things.",
		BOOK_HORTICULTURE = "I really don't get it.",
        BOOK_SLEEP = "I don't think I can read this.",
        BOOK_BRIMSTONE = "Seems more like Clanks kind of thing.",

        BOOK_FISH = "I don't really want to read it.",
        BOOK_FIRE = "These are oddly specific.",
        BOOK_WEB = "Well that's a strange topic.",
        BOOK_TEMPERATURE = "Sorry I just don't get it.",
        BOOK_LIGHT = "These are oddly specific.",
        BOOK_RAIN = "Why rain though?",
        BOOK_MOON = "Everything seems to point towards the moon around here, huh.",
        BOOK_BEES = "I doubt it's about schematics for the Bee Mine glove.",
        
        BOOK_HORTICULTURE_UPGRADED = "I can't really follow it.",
        BOOK_RESEARCH_STATION = "That lady seems to really like working here.",
        BOOK_LIGHT_UPGRADED = "Oh nice!",

        FIREPEN = "Take that!",

        PLAYER =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "%s looks shifty...",
            MURDERER = "Murderer!",
            REVIVER = "%s, friend of ghosts.",
            GHOST = "%s could use a heart.",
            FIRESTARTER = "Burning that wasn't very scientific, %s.",
        },
        WILSON =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "Yeesh. Do I always look that creepy?",
            MURDERER = "Your existence is an affront to the laws of science, %s!",
            REVIVER = "%s has expertly put our theories into practice.",
            GHOST = "Best concoct a revival device. Can't leave another man of science floating.",
            FIRESTARTER = "Burning that wasn't very scientific, %s.",
        },
        WOLFGANG =
        {
            GENERIC = "It's good to see you, %s!",
            ATTACKER = "Let's not start a fight with the strongman...",
            MURDERER = "Murderer! I can take you!",
            REVIVER = "%s is just a big teddy bear.",
            GHOST = "I told you you couldn't deadlift that boulder. The numbers were all wrong.",
            FIRESTARTER = "You can't actually \"fight\" fire, %s!",
        },
        WAXWELL =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "Seems you've gone from \"dapper\" to \"slapper\".",
            MURDERER = "I'll show you Logic and Reason... those're my fists!",
            REVIVER = "%s is using his powers for good.",
            GHOST = "Don't look at me like that, %s! I'm working on it!",
            FIRESTARTER = "%s's just asking to get roasted.",
        },
        WX78 =
        {
            GENERIC = "Hello, %s!",
            ATTACKER = "I think we need to tweak your primary directive, %s...",
            MURDERER = "%s! You've violated the first law!",
            REVIVER = "I guess %s got that empathy module up and running.",
            GHOST = "I always thought %s could use a heart. Now I'm certain!",
            FIRESTARTER = "You look like you're gonna melt, %s. What happened?",
        },
        WILLOW =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "%s is holding that lighter pretty tightly...",
            MURDERER = "Murderer! Arsonist!",
            REVIVER = "%s, friend of ghosts.",
            GHOST = "I bet you're just burning for a heart, %s.",
            FIRESTARTER = "Again?",
        },
        WENDY =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "%s doesn't have any sharp objects, does she?",
            MURDERER = "Murderer!",
            REVIVER = "%s treats ghosts like family.",
            GHOST = "I'm seeing double! I'd better concoct a heart for %s.",
            FIRESTARTER = "I know you set those flames, %s.",
        },
        WOODIE =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "%s has been a bit of a sap lately...",
            MURDERER = "Murderer! Bring me an axe and let's get in the swing of things!",
            REVIVER = "%s saved everyone's backbacon.",
            GHOST = "Does \"universal\" coverage include the void, %s?",
            BEAVER = "%s's gone on a wood chucking rampage!",
            BEAVERGHOST = "Will you bea-very mad if I don't revive you, %s?",
            MOOSE = "Gad-zooks, that's a moose!",
            MOOSEGHOST = "That moose'nt be very comfortable.",
            GOOSE = "Take a gander at that!",
            GOOSEGHOST = "Be more careful, you silly goose!",
            FIRESTARTER = "Don't burn yourself out, %s.",
        },
        WICKERBOTTOM =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "I think %s's planning to throw the book at me.",
            MURDERER = "Here comes my peer review!",
            REVIVER = "I have deep respect for %s's practical theorems.",
            GHOST = "This doesn't seem very scientific, does it, %s?",
            FIRESTARTER = "I'm sure you had a very clever reason for that fire.",
        },
        WES =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "%s is silent, but deadly...",
            MURDERER = "Mime this!",
            REVIVER = "%s thinks outside the invisible box.",
            GHOST = "How do you say \"I'll get a revival device\" in mime?",
            FIRESTARTER = "Wait, don't tell me. You lit a fire.",
        },
        WEBBER =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "I'm gonna roll up a papyrus newspaper, just in case.",
            MURDERER = "Murderer! I'll squash you, %s!",
            REVIVER = "%s is playing well with others.",
            GHOST = "%s is really buggin' me for a heart.",
            FIRESTARTER = "We need to have a group meeting about fire safety.",
        },
        WATHGRITHR =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "I'd like to avoid a punch from %s, if possible.",
            MURDERER = "%s's gone berserk!",
            REVIVER = "%s has full command of spirits.",
            GHOST = "Nice try. You're not escaping to Valhalla yet, %s.",
            FIRESTARTER = "%s is really heating things up today.",
        },
        WINONA =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "%s is a safety hazard.",
            MURDERER = "It ends here, %s!",
            REVIVER = "You're pretty handy to have around, %s.",
            GHOST = "Looks like someone threw a wrench into your plans.",
            FIRESTARTER = "Things are burning up at the factory.",
        },
        WORTOX =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "I knew %s couldn't be trusted!",
            MURDERER = "Time to grab the imp by the horns!",
            REVIVER = "Thanks for lending a helping claw, %s.",
            GHOST = "I reject the reality of ghosts and imps.",
            FIRESTARTER = "%s is becoming a survival liability.",
        },
        WORMWOOD =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "%s seems pricklier than usual today.",
            MURDERER = "Prepare to get weed whacked, %s!",
            REVIVER = "%s never gives up on his friends.",
            GHOST = "You need some help, lil guy?",
            FIRESTARTER = "I thought you hated fire, %s.",
        },
        WARLY =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "Well, this is a recipe for disaster.",
            MURDERER = "I hope you don't have any half-baked plans to murder me!",
            REVIVER = "Always rely on %s to cook up a plan.",
            GHOST = "Maybe he was cooking with ghost peppers.",
            FIRESTARTER = "He's gonna flambé the place right down!",
        },

        WURT =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "%s is looking especially monstrous today...",
            MURDERER = "You're just another murderous merm!",
            REVIVER = "Why thank you, %s!",
            GHOST = "%s is looking greener around the gills than usual.",
            FIRESTARTER = "Didn't anyone teach you not to play with fire?!",
        },

        WALTER =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "Is that how a Pinetree Pioneer is meant to behave?",
            MURDERER = "Did you run out of material for your stories, %s?",
            REVIVER = "I can always count on %s.",
            GHOST = "I know you're having fun, but we'd best find a heart.",
            FIRESTARTER = "That doesn't look like a campfire, %s.",
        },

        WANDA =
        {
            GENERIC = "Hey, %s!",
            ATTACKER = "This really isn't the time or place for that, %s!",
            MURDERER = "Murderer! You won't get any second chances from me!",
            REVIVER = "If it wasn't for %s, I'd be history!",
            GHOST = "I'd better hurry up and find a heart.",
            FIRESTARTER = "Let me guess, this has something to do with \"preserving the timeline\"?",
        },

        WONKEY =
        {
            GENERIC = "Skrunch? No, wait it can't be.",
            ATTACKER = "Hey, stop it!",
            MURDERER = "Whoa I knew they were ferocious!",
            REVIVER = "My life has been saved... by a monkey?",
            GHOST = "That's one spooky monkey.",
            FIRESTARTER = "Did that monkey, just set a fire?",
        },

        MIGRATION_PORTAL =
        {
        --    GENERIC = "If I had any friends, this could take me to them.",
        --    OPEN = "If I step through, will I still be me?",
        --    FULL = "It seems to be popular over there.",
        },
        GLOMMER =
        {
            GENERIC = "I think it looks kinda cute.",
            SLEEPING = "Aww, look at him.",
        },
        GLOMMERFLOWER =
        {
            GENERIC = "That's a pretty big flower.",
            DEAD = "Looks like it's dead.",
        },
        GLOMMERWINGS = "I really feel bad now!",
        GLOMMERFUEL = "Ick, that's disgusting.",
        BELL = "What happens if I ring it.",
        STATUEGLOMMER =
        {
            GENERIC = "It looks to depict something.",
            EMPTY = "Well it's gone.",
        },

        LAVA_POND_ROCK = "As gneiss a place as any.",

		WEBBERSKULL = "Poor little guy. He deserves a proper funeral.",
		WORMLIGHT = "Looks delicious.",
		WORMLIGHT_LESSER = "Kinda wrinkled.",
		WORM =
		{
		    PLANT = "Seems safe to me.",
		    DIRT = "Just looks like a pile of dirt.",
		    WORM = "It's a worm!",
		},
        WORMLIGHT_PLANT = "Seems safe to me.",
		MOLE =
		{
			HELD = "Ha, gotcha!",
			UNDERGROUND = "Better keep on my toes, somethings underground.",
			ABOVEGROUND = "A nice wrench to the face should teach it.",
		},
		MOLEHILL = "So that's where they're hiding!",
		MOLEHAT = "Ohohoh, neat! I can see everything with this.",

		EEL = "This will make a delicious meal.",
		EEL_COOKED = "Smells great!",
		UNAGI = "I hope this doesn't make anyone eel!",
		EYETURRET = "I hope it doesn't turn on me.",
		EYETURRET_ITEM = "I think it's sleeping.",
		MINOTAURHORN = "Wow! I'm glad that didn't gore me!",
		MINOTAURCHEST = "It may contain a bigger something fantastic! Or horrible.",
		THULECITE_PIECES = "It's some smaller chunks of Thulecite.",
		POND_ALGAE = "Some algae by a pond.",
		GREENSTAFF = "This will come in handy.",
		GIFT = "Is that for me? Thank you.",
        GIFTWRAP = "I should wrap this!",
		POTTEDFERN = "A fern in a pot.",
        SUCCULENT_POTTED = "A succulent in a pot.",
		SUCCULENT_PLANT = "It's not very nutritious.",
		SUCCULENT_PICKED = "I could eat that, but I'd rather not.",
		SENTRYWARD = "That's an entirely scientific mapping tool.",
        TOWNPORTAL =
        {
			GENERIC = "This pyramid controls the sands.",
			ACTIVE = "Ready for departiculation.",
		},
        TOWNPORTALTALISMAN =
        {
			GENERIC = "A mini departiculator.",
			ACTIVE = "A more sane person would walk.",
		},
        WETPAPER = "I hope it dries off soon.",
        WETPOUCH = "This package is barely holding together.",
        MOONROCK_PIECES = "I could probably break that.",
        MOONBASE =
        {
            GENERIC = "There's a hole in the middle for something to go in.",
            BROKEN = "It's all smashed up.",
            STAFFED = "Now what?",
            WRONGSTAFF = "I have a distinct feeling this isn't right.",
            MOONSTAFF = "The stone lit it up somehow.",
        },
        MOONDIAL =
        {
			GENERIC = "Water amplifies the science, allowing us to measure the moon.",
			NIGHT_NEW = "It's a new moon.",
			NIGHT_WAX = "The moon is waxing.",
			NIGHT_FULL = "It's a full moon.",
			NIGHT_WANE = "The moon is waning.",
			CAVE = "There's no moon down here to measure.",
			WEREBEAVER = "only_used_by_woodie", --woodie specific
			GLASSED = "I have the strangest feeling I'm being watched.",
        },
		THULECITE = "I wonder where this is from?",
		ARMORRUINS = "It's oddly light.",
		ARMORSKELETON = "No bones about it.",
		SKELETONHAT = "It gives me terrible visions.",
		RUINS_BAT = "It has quite a heft to it.",
		RUINSHAT = "It's ruffling up my fur a bit.",
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "Everything seems to be at ease.",
            WARN = "Something tells me that I should be wary.",
            WAXING = "This isn't good!",
            STEADY = "Stay on alert Ratchet, danger could be around any corner.",
            WANING = "Good, it's now starting to fade.",
            DAWN = "Finally almost gone!",
            NOMAGIC = "It's over.",
		},
		BISHOP_NIGHTMARE = "Rusted joints and faulty coils? Eat wrench!",
		ROOK_NIGHTMARE = "Leaky fuel lines and crackling crank shafts? Take this!",
		KNIGHT_NIGHTMARE = "Loose gasket and faulty springs? Easy!",
		MINOTAUR = "That thing doesn't look happy.",
		SPIDER_DROPPER = "Note to self: Don't look up.",
		NIGHTMARELIGHT = "Whatever it is, I don't quite get it.",
		NIGHTSTICK = "Nice! I could power stuff on the go with this!",
		GREENGEM = "It's a green gem of some sort.",
		MULTITOOL_AXE_PICKAXE = "I've always wanted a multi-tool! But not in this sense.",
		ORANGESTAFF = "This beats walking.",
		YELLOWAMULET = "Warm to the touch.",
		GREENAMULET = "No base should be without one!",
		SLURPERPELT = "Doesn't look all that much different dead.",

		SLURPER = "Is that a moving hairball?",
		SLURPER_PELT = "Okay, someone please tell me that's a hairball?",
		ARMORSLURPER = "A soggy, sustaining, succulent suit.",
		ORANGEAMULET = "Teleportation can be so useful.",
		YELLOWSTAFF = "A genius invention... a gem on a stick.",
		YELLOWGEM = "Neat, a yellow gem.",
		ORANGEGEM = "Nice. It's an orange gem.",
        OPALSTAFF = "It's scientifically proven that gems look better on top of sticks.",
        OPALPRECIOUSGEM = "This gem seems special.",
        TELEBASE =
		{
			VALID = "It's ready to go.",
			GEMS = "It needs more purple gems.",
		},
		GEMSOCKET =
		{
			VALID = "Looks ready.",
			GEMS = "It needs a gem.",
		},
		STAFFLIGHT = "That seems really dangerous.",
        STAFFCOLDLIGHT = "Brr! It...It's a bit chilly.",

        ANCIENT_ALTAR = "An ancient and mysterious structure.",

        ANCIENT_ALTAR_BROKEN = "This seems to be broken.",

        ANCIENT_STATUE = "Reminds me of the ancient statues found on Quantos.",

        LICHEN = "It's maybe useful.",
		CUTLICHEN = "Nutritious, but it won't last long.",

		CAVE_BANANA = "I'm pretty sure Skrunch would fight me for it if he were here.",
		CAVE_BANANA_COOKED = "Yum!",
		CAVE_BANANA_TREE = "Is that a bananna tree?",
		ROCKY = "Wow, I don't think I want to get on their bad side.",

		COMPASS =
		{
			GENERIC="Which way am I facing?",
			N = "North.",
			S = "South.",
			E = "East.",
			W = "West.",
			NE = "Northeast.",
			SE = "Southeast.",
			NW = "Northwest.",
			SW = "Southwest.",
		},

        HOUNDSTOOTH = "It's sharp!",
        ARMORSNURTLESHELL = "It sticks to your back when you wear it.",
        BAT = "Ack! Back off!",
        BATBAT = "This could make for a good temporary weapon.",
        BATWING = "I hate those things, even when they're dead.",
        BATWING_COOKED = "At least it's not coming back.",
        BATCAVE = "Bad idea to wake them.",
        BEDROLL_FURRY = "It's so warm and comfy.",
        BUNNYMAN = "Are those oversized rabbits, or am I just imaging things.",
        FLOWER_CAVE = "Wow, it's pretty pleasent to look at.",
        GUANO = "Argh, it's so gross.",
        LANTERN = "More light is always welcome.",
        LIGHTBULB = "I wonder if it's safe to eat.",
        MANRABBIT_TAIL = "I feel a lil better when I hold one.",
        MUSHROOMHAT = "Makes the wearer look like a fun guy.",
        MUSHROOM_LIGHT2 =
        {
            ON = "Blue is obviously the most scientific color.",
            OFF = "We could make a prime light source with some primary colors.",
            BURNT = "I didn't mildew it, I swear.",
        },
        MUSHROOM_LIGHT =
        {
            ON = "Science makes it light up.",
            OFF = "It's a big, science-y 'shroom.",
            BURNT = "Comboletely burnt.",
        },
        SLEEPBOMB = "It makes snooze circles when I throw it.",
        MUSHROOMBOMB = "A mushroom cloud in the making!",
        SHROOM_SKIN = "It sure is unpleasent.",
        TOADSTOOL_CAP =
        {
            EMPTY = "Just a hole in the ground.",
            INGROUND = "There's something poking out.",
            GENERIC = "Maybe I should chop it down, what's the worst that could happen.",
        },
        TOADSTOOL =
        {
            GENERIC = "Looks like I'm going to have some work cut out for me!",
            RAGE = "Watch out!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "Hey, it's sprouting!",
            BURNT = "Oh, well.",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "Wow, that's a huge mushroom.",
            BLOOM = "Whew, it looks far pleasent than it smells.",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "Still pretty big.",
            BLOOM = "It's mildly pleasent to look at.",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "These ones have gotten pretty large.",
            BLOOM = "It's making my nose itchy.",
        },
        MUSHTREE_TALL_WEBBED = "I have to keep my wits about. Spiders maybe nearby.",
        SPORE_TALL =
        {
            GENERIC = "It's just drifting around.",
            HELD = "I'll keep a little light in my pocket.",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "It's lazily floating about.",
            HELD = "I'll keep a little light in my pocket.",
        },
        SPORE_SMALL =
        {
            GENERIC = "They're pretty but they aren't doing my nose any favors.",
            HELD = "I'll keep a little light in my pocket.",
        },
        RABBITHOUSE =
        {
            GENERIC = "Wait, is that a giant carrot?",
            BURNT = "Well that's unfortunate.",
        },
        SLURTLE = "I've experienced much worst than this guy.",
        SLURTLE_SHELLPIECES = "A puzzle with no solution.",
        SLURTLEHAT = "Wearing it could really stick to my fur.",
        SLURTLEHOLE = "Looks like they live here. I can tell by the slime.",
        SLURTLESLIME = "If it wasn't useful, I wouldn't touch it.",
        SNURTLE = "This one has a different shell.",
        SPIDER_HIDER = "Wah, that surprised me!",
        SPIDER_SPITTER = "Oh no you don't! Spitting isn't going to save you now!",
        SPIDERHOLE = "It's encrusted with old webbing.",
        SPIDERHOLE_ROCK = "It's encrusted with old webbing.",
        STALAGMITE = "Looks like a normal rock to me.",
        STALAGMITE_TALL = "Rocks, rocks, rocks, and more rocks...",

        TURF_CARPETFLOOR = "It's surprisingly comfortable under my boots.",
        TURF_CHECKERFLOOR = "Eh, I'm not too much of a fan.",
        TURF_DIRT = "A chunk of ground.",
        TURF_FOREST = "A chunk of ground.",
        TURF_GRASS = "A chunk of ground.",
        TURF_MARSH = "A chunk of ground.",
        TURF_METEOR = "A chunk of moon ground.",
        TURF_PEBBLEBEACH = "A chunk of beach.",
        TURF_ROAD = "Hastily cobbled stones.",
        TURF_ROCKY = "A chunk of ground.",
        TURF_SAVANNA = "A chunk of ground.",
        TURF_WOODFLOOR = "These are floorboards.",

		TURF_CAVE="Yet another ground type.",
		TURF_FUNGUS="Yet another ground type.",
		TURF_FUNGUS_MOON = "Yet another ground type.",
		TURF_ARCHIVE = "Yet another ground type.",
		TURF_SINKHOLE="Yet another ground type.",
		TURF_UNDERROCK="Yet another ground type.",
		TURF_MUD="Yet another ground type.",

		TURF_DECIDUOUS = "Yet another ground type.",
		TURF_SANDY = "Yet another ground type.",
		TURF_BADLANDS = "Yet another ground type.",
		TURF_DESERTDIRT = "A chunk of ground.",
		TURF_FUNGUS_GREEN = "A chunk of ground.",
		TURF_FUNGUS_RED = "A chunk of ground.",
		TURF_DRAGONFLY = "Do you want proof that it's fireproof?",

        TURF_SHELLBEACH = "A chunk of beach.",

		TURF_RUINSBRICK = "Yet another ground type.",
		TURF_RUINSBRICK_GLOW = "Yet another ground type.",
		TURF_RUINSTILES = "Yet another ground type.",
		TURF_RUINSTILES_GLOW = "Yet another ground type.",
		TURF_RUINSTRIM = "Yet another ground type.",
		TURF_RUINSTRIM_GLOW = "Yet another ground type.",

        TURF_MONKEY_GROUND = "A chunk of sand.",

        TURF_CARPETFLOOR2 = "It's surprisingly soft.",
        TURF_MOSAIC_GREY = "Yet another ground type.",
        TURF_MOSAIC_RED = "Yet another ground type.",
        TURF_MOSAIC_BLUE = "Yet another ground type.",

        TURF_BEARD_RUG = "Okay, this freaks me out a little.",

		POWCAKE = "Science help us.",
        CAVE_ENTRANCE = "Maybe a good whack from my wrench will open it up.",
        CAVE_ENTRANCE_RUINS = "It's probably hiding something.",

       	CAVE_ENTRANCE_OPEN =
        {
            GENERIC = "It's really deep down there.",
            OPEN = "What could go wrong, it's just like the other millions of caves I've explored.",
            FULL = "Someone's blocking the entrance.",
        },
        CAVE_EXIT =
        {
            GENERIC = "I'll just stay down here, I suppose.",
            OPEN = "I've had enough adventure for now.",
            FULL = "The surface is too crowded!",
        },

		MAXWELLPHONOGRAPH = "So that's where the music was coming from.",--single player
		BOOMERANG = "I'm pretty sure Qwark hit me with one of these before.",
		PIGGUARD = "Looks like he wants to start a fight!",
		ABIGAIL =
		{
            LEVEL1 =
            {
                "Awww, she has a cute little bow.",
                "Awww, she has a cute little bow.",
            },
            LEVEL2 =
            {
                "Awww, she has a cute little bow.",
                "Awww, she has a cute little bow.",
            },
            LEVEL3 =
            {
                "Awww, she has a cute little bow.",
                "Awww, she has a cute little bow.",
            },
		},
		ADVENTURE_PORTAL = "I need to find a way back home.",
		AMULET = "It's not a nano pack, but it's better than nothing.",
		ANIMAL_TRACK = "Something must had left these tracks. Hmmm, couldn't be a snagglebeast.",
		ARMORGRASS = "It looks very itchy, almost like kerchu hair.",
		ARMORMARBLE = "Better than no protection, and at least my bolts are safe this time.",
		ARMORWOOD = "I'm used to gadgetron based protection but this will do the trick for now. At least I'm not being charged!",
		ARMOR_SANITY = "It has to at least be more comfortable than my old marauder armor.",
		ASH =
		{
			GENERIC = "All that's left after the fire has done its job.",
			REMAINS_GLOMMERFLOWER = "The flower was consumed by fire in the teleportation!",
			REMAINS_EYE_BONE = "The eyebone was consumed by fire in the teleportation!",
			REMAINS_THINGIE = "I'm unsure as to what it used to be.",
		},
		AXE = "Aw yeah, an Axe!",
		BABYBEEFALO =
		{
			GENERIC = "Hey little guy!",
		    SLEEPING = "Aww, the little guy's sleeping.",
        },
        BUNDLE = "Alright! Extra supplies!",
        BUNDLEWRAP = "Let's wrap it all up.",
		BACKPACK = "Ahhh how I miss nanotechnology. But it's better than nothing!",
		BACONEGGS = "Awww yeah! Bacon and eggs!",
		BANDAGE = "Seems sterile enough.",
		BASALT = "That's too strong to break through!", --removed
		BEARDHAIR = "Oh yuck, was that dropped from someone's face?",
		BEARGER = "Is that a Zanifarian Death Weasel? Where's the pepper spray when I need it.",
		BEARGERVEST = "Why is it so itchy!",
		ICEPACK = "The fur keeps the temperature inside stable.",
		BEARGER_FUR = "A mat of thick fur.",
		BEDROLL_STRAW = "Looks comfy, but it smells like a blargians backside.",
		BEEQUEEN = "Back off, or I'll bash you in!",
		BEEQUEENHIVE =
		{
			GENERIC = "It's too sticky to walk on.",
			GROWING = "Was that there before?",
		},
        BEEQUEENHIVEGROWN = "Whoa, Clank would love to see this!",
        BEEGUARD = "It's guarding the queen.",
        HIVEHAT = "The world seems less a little crazy when I wear it.",
        MINISIGN =
        {
            GENERIC = "I'm sure I could draw better than that!",
            UNDRAWN = "We should draw something on there.",
        },
        MINISIGN_ITEM = "It's not much use like this. We should place it.",
		BEE =
		{
			GENERIC = "Hey I've seen these little guys before.",
			HELD = "I wonder if I could make a Bee Mine glove out of them.",
		},
		BEEBOX =
		{
			READY = "It's full of honey.",
			FULLHONEY = "It's full of honey.",
			GENERIC = "Bees!",
			NOHONEY = "It's empty.",
			SOMEHONEY = "Need to wait a bit.",
			BURNT = "How did it get burned?!!",
		},
		MUSHROOM_FARM =
		{
			STUFFED = "That's a lot of mushrooms!",
			LOTS = "The mushrooms have really taken to the log.",
			SOME = "It should keep growing now.",
			EMPTY = "It could use a spore. Or a mushroom transplant.",
			ROTTEN = "The log is dead. We should replace it with a live one.",
			BURNT = "Well that's unfortunate.",
			SNOWCOVERED = "I don't think it can grow in this cold.",
		},
		BEEFALO =
		{
			FOLLOWER = "It's following me! Neat.",
			GENERIC = "It's a beefalo!",
			NAKED = "I shouldn't laugh.",
			SLEEPING = "These guys are really heavy sleepers.",
            --Domesticated states:
            DOMESTICATED = "At least they don't smell like dung beavers.",
            ORNERY = "It looks deeply angry.",
            RIDER = "This fellow appears quite ridable.",
            PUDGY = "Hmmm, there may be too much food inside it.",
            MYPARTNER = "We're beef friends forever.",
		},

		BEEFALOHAT = "That's a case of hat-hair waiting to happen.",
		BEEFALOWOOL = "Bleh, it smells like a florana dung beaver.",
		BEEHAT = "Protection! Now I can approach those bees.",
        BEESWAX = "Beeswax! Maybe I can make something out of it.",
		BEEHIVE = "It's buzzing with activity.",
		BEEMINE = "Oh yeah! Not as good as the glove but still effective!",
		BEEMINE_MAXWELL = "Bottled mosquito rage!",--removed
		BERRIES = "Red berries taste the best.",
		BERRIES_COOKED = "I don't think heat improved them.",
        BERRIES_JUICY = "Extra tasty, though they won't last long.",
        BERRIES_JUICY_COOKED = "Better eat them before they spoil!",
		BERRYBUSH =
		{
			BARREN = "I think it needs to be fertilized.",
			WITHERED = "Nothing will grow in this heat.",
			GENERIC = "I think those are the edible kind.",
			PICKED = "Maybe they'll grow back?",
			DISEASED = "It looks pretty sick.",--removed
			DISEASING = "Err, something's not right.",--removed
			BURNING = "It's very much on fire.",
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "It won't make any berries in this state.",
			WITHERED = "The heat even dehydrated the juicy berries!",
			GENERIC = "I should leave them there until it's time to eat.",
			PICKED = "The bush is working hard on the next batch.",
			DISEASED = "It looks pretty sick.",--removed
			DISEASING = "Err, something's not right.",--removed
			BURNING = "It's very much on fire.",
		},
		BIGFOOT = "That is one biiig foot.",--removed
		BIRDCAGE =
		{
			GENERIC = "I think I could catch a bird for it.",
			OCCUPIED = "Hey little fella.",
			SLEEPING = "Awwww, he's asleep.",
			HUNGRY = "They seem hungry, I should feed them.",
			STARVING = "Has no one fed you in awhile? I need to find food for you.",
			DEAD = "Uh no...that can't be good.",
			SKELETON = "....It wasn't me.",
		},
		BIRDTRAP = "Alright, it's all set and ready to go!",
		CAVE_BANANA_BURNT = "It's completely turned to mush.",
		BIRD_EGG = "A small, normal egg.",
		BIRD_EGG_COOKED = "Sunny side yum!",
		BISHOP = "Time to dismantle!",
		BLOWDART_FIRE = "This seems fundamentally unsafe.",
		BLOWDART_SLEEP = "Just don't breathe in.",
		BLOWDART_PIPE = "Maybe I could arm it with something!",
		BLOWDART_YELLOW = "It has shocking accuracy.",
		BLUEAMULET = "Cool as ice!",
		BLUEGEM = "It sparkles with cold energy.",
		BLUEPRINT =
		{
            COMMON = "Oh hey, schematics!",
            RARE = "Wow, these are well thought out schematics!",
        },
        SKETCH = "A picture of a sculpture. We'll need somewhere to make it.",
		COOKINGRECIPECARD = 
		{
			GENERIC = "Science help me, I can't decipher this handwriting.",
		},
		BLUE_CAP = "It's strange.",
		BLUE_CAP_COOKED = "It's different now...",
		BLUE_MUSHROOM =
		{
			GENERIC = "It's a mushroom.",
			INGROUND = "It's sleeping.",
			PICKED = "I wonder if it will come back?",
		},
		BOARDS = "Boards.",
		BONESHARD = "Bits of bone.",
		BONESTEW = "Beats starving I guess.",
		BUGNET = "I could catch bugs with this. Could be useful.",
		BUSHHAT = "Ouch, it's poking me in the face.",
		BUTTER = "I can't believe butter came from that butterfly! I'm also pretty sure that's not normal.",
		BUTTERFLY =
		{
			GENERIC = "Oh hey little guy.",
			HELD = "Now I have you!",
		},
		BUTTERFLYMUFFIN = "I might have messed up the recipe. I'm pretty sure the wings aren't supposed to stick out like that.",
		BUTTERFLYWINGS = "Am I really going to eat these?",
		BUZZARD = "I'm pretty sure I've seen these flying above me during my travels across Tabora!",

		SHADOWDIGGER = "No going to lie, whatever tech that guy is using is pretty useful.",
        SHADOWDANCER = "Ehhhhh, I'm not really much of a fan.",

		CACTUS =
		{
			GENERIC = "It's prickly.",
			PICKED = "Ow, that's going to leave a mark.",
		},
		CACTUS_MEAT_COOKED = "Maybe it'll hurt less cooked.",
		CACTUS_MEAT = "It's still covered in spines.",
		CACTUS_FLOWER = "I can't believe flowers like these grow off it.",

		COLDFIRE =
		{
			EMBERS = "That fire needs more fuel or it's going to go out.",
			GENERIC = "Sure beats darkness.",
			HIGH = "Maybe I should tone it down!",
			LOW = "The fire's getting a bit low.",
			NORMAL = "Nice and comfy.",
			OUT = "Well, that's over.",
		},
		CAMPFIRE =
		{
			EMBERS = "That fire needs more fuel or it's going to go out.",
			GENERIC = "Sure beats darkness.",
			HIGH = "Maybe I should tone it down!",
			LOW = "The fire's getting a bit low.",
			NORMAL = "Nice and comfy.",
			OUT = "Well, that's over.",
		},
		CANE = "Whohoo! Not as great as my hoverboots but it sure helps speed things up!",
		CATCOON = "Looks like it's playing around.",
		CATCOONDEN =
		{
			GENERIC = "I think there's something that lives inside.",
			EMPTY = "It's empty.",
		},
		CATCOONHAT = "I really feel bad right now!",
		COONTAIL = "I think it's still swishing.",
		CARROT = "Maybe I could cook something with it.",
		CARROT_COOKED = "Mushy.",
		CARROT_PLANTED = "It's a carrot.",
		CARROT_SEEDS = "It's a seed.",
		CARTOGRAPHYDESK =
		{
			GENERIC = "Now I can show everyone what I found!",
			BURNING = "So much for that.",
			BURNT = "Nothing but ash now.",
		},
		WATERMELON_SEEDS = "It's a seed.",
		CAVE_FERN = "It's a fern.",
		CHARCOAL = "It's small, dark, and smells like burnt wood.",
        CHESSPIECE_PAWN = "I can relate.",
        CHESSPIECE_ROOK =
        {
            GENERIC = "It's even heavier than it looks.",
            STRUGGLE = "The chess pieces are moving themselves!",
        },
        CHESSPIECE_KNIGHT =
        {
            GENERIC = "It's a horse, of course.",
            STRUGGLE = "The chess pieces are moving themselves!",
        },
        CHESSPIECE_BISHOP =
        {
            GENERIC = "It's a stone bishop.",
            STRUGGLE = "The chess pieces are moving themselves!",
        },
        CHESSPIECE_MUSE = "Hmm... Looks familiar.",
        CHESSPIECE_FORMAL = "Doesn't seem very \"kingly\" to me.",
        CHESSPIECE_HORNUCOPIA = "Makes my stomach rumble just looking at it.",
        CHESSPIECE_PIPE = "That was never really my thing.",
        CHESSPIECE_DEERCLOPS = "It feels like its eye follows you.",
        CHESSPIECE_BEARGER = "It was a lot bigger up close.",
        CHESSPIECE_MOOSEGOOSE =
        {
            "Eurgh. It's so lifelike.",
        },
        CHESSPIECE_DRAGONFLY = "Ah, that brings back memories. Bad ones.",
		CHESSPIECE_MINOTAUR = "Now you're the one scared stiff!",
        CHESSPIECE_BUTTERFLY = "It looks nice, doesn't it?",
        CHESSPIECE_ANCHOR = "It's as heavy as it looks.",
        CHESSPIECE_MOON = "I've been feeling pretty inspired lately.",
        CHESSPIECE_CARRAT = "We have a winner!",
        CHESSPIECE_MALBATROSS = "It's not so bad when it isn't trying to kill you.",
        CHESSPIECE_CRABKING = "Still not as crabby as Maxwell.",
        CHESSPIECE_TOADSTOOL = "Not really a great stool though, is it?",
        CHESSPIECE_STALKER = "Exactly as stationary as a skeleton should be.",
        CHESSPIECE_KLAUS = "Can I invoke the \"no holiday decorations\" Klaus?",
        CHESSPIECE_BEEQUEEN = "Very statuesque.",
        CHESSPIECE_ANTLION = "A stagn-antlion.",
        CHESSPIECE_BEEFALO = "This sculpture is pretty beefy.",
		CHESSPIECE_KITCOON = "These ones are much easier to find.",
		CHESSPIECE_CATCOON = "It would probably make a great scratching post.",
        CHESSPIECE_MANRABBIT = "I want to hug it, but the stone chafes.",
        CHESSPIECE_GUARDIANPHASE3 = "I much prefer it this way.",
        CHESSPIECE_EYEOFTERROR = "It's giving me a stony stare.",
        CHESSPIECE_TWINSOFTERROR = "That was a terrible night of very uncomfortable eye contact.",
        CHESSPIECE_DAYWALKER = "Now he's off who-knows-were.",
        CHESSPIECE_DEERCLOPS_MUTATED = "This sculpture is a bit of an eyesore.",
        CHESSPIECE_WARG_MUTATED = "It's just missing that horrible breath.",
        CHESSPIECE_BEARGER_MUTATED = "Somehow it seems crankier than the real one.",

        CHESSJUNK1 = "Looks like a pile of scrapmetal.",
        CHESSJUNK2 = "Another pile of scrap?",
        CHESSJUNK3 = "Where do these piles come from?",
		CHESTER = "I've seen stranger creatures on Magnus.",
		CHESTER_EYEBONE =
		{
			GENERIC = "It's looking at me.",
			WAITING = "It went to sleep.",
		},
		COOKEDMANDRAKE = "Poor little guy.",
		COOKEDMEAT = "Charbroiled to perfection.",
		COOKEDMONSTERMEAT = "That's only somewhat more appetizing than when it was raw.",
		COOKEDSMALLMEAT = "Finally some edible food!",
		COOKPOT =
		{
			COOKING_LONG = "This is going to take a while.",
			COOKING_SHORT = "It's almost done!",
			DONE = "Mmmmm! It's ready to eat!",
			EMPTY = "It makes me hungry just to look at it.",
			BURNT = "I did not do it.",
		},
		CORN = "Nice corn!",
		CORN_COOKED = "I could make popcorn out of this",
		CORN_SEEDS = "It's a kernal.",
        CANARY =
		{
			GENERIC = "Some sort of yellow creature.",
			HELD = "I'm not squishing you, am I?",
		},
        CANARY_POISONED = "It's probably fine.",

		CRITTERLAB = "Is there something in there?",
        CRITTER_GLOMLING = "It's a smaller version of the thing from the statue!",
        CRITTER_DRAGONLING = "I don't know how to feel about it.",
		CRITTER_LAMB = "Much less mucusy than its momma.",
        CRITTER_PUPPY = "Pretty cute for a lil monster!",
        CRITTER_KITTEN = "You'd make a good lab assistant.",
        CRITTER_PERDLING = "My feathered friend.",
		CRITTER_LUNARMOTHLING = "I keep her around.",

		CROW =
		{
			GENERIC = "I think that bird is staring at me!",
			HELD = "He's not very happy in there.",
		},
		CUTGRASS = "Cut grass? Maybe I can make use of it.",
		CUTREEDS = "Cut reeds, I could really use this for my tools.",
		CUTSTONE = "Smoooooooth.",
		DEADLYFEAST = "A most potent dish.", --unimplemented
		DEER =
		{
			GENERIC = "Is it staring at me? ...No, I guess not.",
			ANTLER = "What an impressive antler!",
		},
        DEER_ANTLER = "Was that supposed to come off?",
        DEER_GEMMED = "It's being controlled by that beast!",
		DEERCLOPS = "Whoa, it's big! But I won't back down!",
		DEERCLOPS_EYEBALL = "Yuck, that's gross.",
		EYEBRELLAHAT =	"Was it really a good idea to make it into an umbrella? It's staring at me.",
		DEPLETED_GRASS =
		{
			GENERIC = "It's probably a tuft of grass.",
		},
        GOGGLESHAT = "What a stylish pair of goggles.",
        DESERTHAT = "Ohohoho, now we're talking.",
        ANTLIONHAT = "It's alright.",
		DEVTOOL = "It smells of bacon!",
		DEVTOOL_NODEV = "I'm not strong enough to wield it.",
		DIRTPILE = "It's a pile of dirt... or IS it?",
		DIVININGROD =
		{
			COLD = "The signal is very faint.", --singleplayer
			GENERIC = "It's some kind of homing device.", --singleplayer
			HOT = "This thing's going crazy!", --singleplayer
			WARM = "I'm headed in the right direction.", --singleplayer
			WARMER = "Must be getting pretty close.", --singleplayer
		},
		DIVININGRODBASE =
		{
			GENERIC = "I wonder what it does.", --singleplayer
			READY = "It looks like it needs a large key.", --singleplayer
			UNLOCKED = "Now the machine can work!", --singleplayer
		},
		DIVININGRODSTART = "That rod looks useful!", --singleplayer
		DRAGONFLY = "I thought mutant fireflies were bad. I think this one takes the cake!",
		ARMORDRAGONFLY = "Hot mail!",
		DRAGON_SCALES = "They're still warm to the touch.",
		DRAGONFLYCHEST = "Next best thing to a lockbox!",
		DRAGONFLYFURNACE =
		{
			HAMMERED = "I don't think it's supposed to look like that.",
			GENERIC = "Produces a lot of heat, but not much light.", --no gems
			NORMAL = "Is it winking at me?", --one gem
			HIGH = "It's scalding!", --two gems
		},

        HUTCH = "I think this fish...thing...is following me.",
        HUTCH_FISHBOWL =
        {
            GENERIC = "What's a fish bowl doing down here?",
            WAITING = "I think it needs time to catch up",
        },
		LAVASPIT =
		{
			HOT = "Hot spit!",
			COOL = "I like to call it \"Basaliva\".",
		},
		LAVA_POND = "I better keep my distance. It could singe off all my fur!",
		LAVAE = "Too hot to handle.",
		LAVAE_COCOON = "Cooled off and chilled out.",
		LAVAE_PET =
		{
			STARVING = "Poor guy must be starving.",
			HUNGRY = "I hear a tiny stomach grumbling.",
			CONTENT = "It seems happy.",
			GENERIC = "Aww. Who's a good little creature?",
		},
		LAVAE_EGG =
		{
			GENERIC = "There's a faint warmth coming from inside.",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "I don't think that egg is warm enough.",
			COMFY = "I never thought I would see a happy egg.",
		},
		LAVAE_TOOTH = "Can't believe it has teeth.",

		DRAGONFRUIT = "What a weird fruit.",
		DRAGONFRUIT_COOKED = "The fruit's still weird.",
		DRAGONFRUIT_SEEDS = "It's a seed.",
		DRAGONPIE = "The dragonfruit is very filling.",
		DRUMSTICK = "Ready for gobbling.",
		DRUMSTICK_COOKED = "Even better for gobbling!",
		DUG_BERRYBUSH = "Now it can be taken anywhere.",
		DUG_BERRYBUSH_JUICY = "This could be replanted closer to home.",
		DUG_GRASS = "It can be planted anywhere now.",
		DUG_MARSH_BUSH = "This needs to be planted.",
		DUG_SAPLING = "This needs to be planted.",
		DURIAN = "My nose feels like it's about to burn off!",
		DURIAN_COOKED = "It ready just did have to get worst!",
		DURIAN_SEEDS = "It's a seed.",
		EARMUFFSHAT = "Ahhh, Nice and warm around the ears.",
		EGGPLANT = "It doesn't look like an egg.",
		EGGPLANT_COOKED = "It's even less eggy.",
		EGGPLANT_SEEDS = "It's a seed.",

		ENDTABLE =
		{
			BURNT = "A burnt vase on a burnt table.",
			GENERIC = "A flower in a vase on a table.",
			EMPTY = "I should put something in there.",
			WILTED = "Not looking too fresh.",
			FRESHLIGHT = "It's nice to have a little light.",
			OLDLIGHT = "Did we remember to pick up new bulbs?", -- will be wilted soon, light radius will be very small at this point
		},
		DECIDUOUSTREE =
		{
			BURNING = "What a waste of wood.",
			BURNT = "I feel like I could have prevented that.",
			CHOPPED = "Sorry, I need the wood!",
			POISON = "Whoops my bad. I wouldn't suppose me replanting those will make you happier? No? Oh well...",
			GENERIC = "It's all leafy. Most of the time.",
		},
		ACORN = "There's definitely something inside there.",
        ACORN_SAPLING = "It'll be a tree soon!",
		ACORN_COOKED = "Roasted to perfection.",
		BIRCHNUTDRAKE = "A mad little nut.",
		EVERGREEN =
		{
			BURNING = "What a waste of wood.",
			BURNT = "I feel like I could have prevented that.",
			CHOPPED = "Sorry, I need the wood!",
			GENERIC = "There's some cones in here.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "What a waste of wood.",
			BURNT = "I feel like I could have prevented that.",
			CHOPPED = "Sorry, I need the wood!",
			GENERIC = "It's thin tree.",
		},
		TWIGGYTREE =
		{
			BURNING = "What a waste of wood.",
			BURNT = "I feel like I could have prevented that.",
			CHOPPED = "Sorry, I need the wood!",
			GENERIC = "I could gather sticks from this.",
			DISEASED = "It looks sick. More so than usual.", --unimplemented
		},
		TWIGGY_NUT_SAPLING = "It doesn't need any help to grow.",
        TWIGGY_OLD = "That tree looks pretty wimpy.",
		TWIGGY_NUT = "There's a stick-y tree inside it that wants to get out.",
		EYEPLANT = "Yikes, what is that thing. It's nothing but eyes.",
		INSPECTSELF = "Am I still in one piece?",
		FARMPLOT =
		{
			GENERIC = "I should try planting some crops.",
			GROWING = "Go plants go!",
			NEEDSFERTILIZER = "I think it needs to be fertilized.",
			BURNT = "I don't think anything will grow in a pile of ash.",
		},
		FEATHERHAT = "At least it feels nice.",
		FEATHER_CROW = "A feather from a black bird.",
		FEATHER_ROBIN = "A redbird feather.",
		FEATHER_ROBIN_WINTER = "A snowbird feather.",
		FEATHER_CANARY = "A canary feather.",
		FEATHERPENCIL = "I guess you could write with it.",
        COOKBOOK = "I bet Clank would love this.",
		FEM_PUPPET = "She's trapped!", --single player
		FIREFLIES =
		{
			GENERIC = "Maybe I can catch them!",
			HELD = "They make my pocket glow!",
		},
		FIREHOUND = "Not these things, and oh no it's on fire too.",
		FIREPIT =
		{
			EMBERS = "I should put something on the fire before it goes out.",
			GENERIC = "Sure beats darkness.",
			HIGH = "Good thing it's contained!",
			LOW = "The fire's getting a bit low.",
			NORMAL = "Nice and comfy.",
			OUT = "At least I can start it up again.",
		},
		COLDFIREPIT =
		{
			EMBERS = "I should put something on the fire before it goes out.",
			GENERIC = "Sure beats darkness.",
			HIGH = "Good thing it's contained!",
			LOW = "The fire's getting a bit low.",
			NORMAL = "Nice and comfy.",
			OUT = "At least I can start it up again.",
		},
		FIRESTAFF = "I don't want to set the world on fire.",
		FIRESUPPRESSOR =
		{
			ON = "Fling on!",
			OFF = "All quiet on the flinging front.",
			LOWFUEL = "The fuel tank is getting a bit low.",
		},

		FISH = "Now I shall eat for a day.",
		FISHINGROD = "Hook, line and stick!",
		FISHSTICKS = "These look delicious.",
		FISHTACOS = "Crunchy and delicious!",
		FISH_COOKED = "Grilled to perfection.",
		FLINT = "It's a very sharp rock.",
		FLOWER =
		{
            GENERIC = "Well they do look nice.",
            ROSE = "Looks nice.",
        },
        FLOWER_WITHERED = "I don't think it got enough sun.",
		FLOWERHAT = "It smells like prettiness.",
		FLOWER_EVIL = "I don't know, it does look a little wilted",
		FOLIAGE = "Some leafy greens.",
		FOOTBALLHAT = "It's a substitute until I can find an armor vendor.",
        FOSSIL_PIECE = "We should put them back together.",
        FOSSIL_STALKER =
        {
			GENERIC = "Still missing some pieces.",
			FUNNY = "I don't think it looks quite right.",
			COMPLETE = "It's alive! Oh wait, no, it's not.",
        },
        STALKER = "The skeleton fused with the shadows!",
        STALKER_ATRIUM = "Why'd it have to be so big?",
        STALKER_MINION = "Oh no you don't! I'll take you down.",
        THURIBLE = "It smells like chemicals.",
        ATRIUM_OVERGROWTH = "I don't recognize any of these symbols.",
		FROG =
		{
			DEAD = "Good!",
			GENERIC = "Reminds me of horned toads but smaller.",
			SLEEPING = "Whew, they're sleeping.",
		},
		FROGGLEBUNWICH = "Uhh, I don't know how to feel about the legs poking out from it.",
		FROGLEGS = "I've heard it's a delicacy.",
		FROGLEGS_COOKED = "Tastes like chicken.",
		FRUITMEDLEY = "Fruity.",
		FURTUFT = "Black and white fur.",
		GEARS = "Sweet! A pile of mechanical parts.",
		GHOST = "Ahhh! Is that a ghost?",
		GOLDENAXE = "That's one fancy axe.",
		GOLDENPICKAXE = "Hey, isn't gold really soft?",
		GOLDENPITCHFORK = "Why did I even make a pitchfork this fancy?",
		GOLDENSHOVEL = "I can't wait to dig holes.",
		GOLDNUGGET = "Maybe I could smelt things down into more.",
		GRASS =
		{
			BARREN = "It needs fertilizer.",
			WITHERED = "It's not going to grow back while it's so hot.",
			BURNING = "That's burning fast!",
			GENERIC = "It's just grass.",
			PICKED = "I'm sure it'll grow back.",
			DISEASED = "It looks pretty sick.", --unimplemented
			DISEASING = "Err, something's not right.", --unimplemented
		},
		GRASSGEKKO =
		{
			GENERIC = "It's an extra leafy lizard.",
			DISEASED = "It looks really sick.", --unimplemented
		},
		GREEN_CAP = "It seems pretty normal.",
		GREEN_CAP_COOKED = "It's different now...",
		GREEN_MUSHROOM =
		{
			GENERIC = "It's a mushroom.",
			INGROUND = "It's sleeping.",
			PICKED = "I wonder if it will come back?",
		},
		GUNPOWDER = "Nice! I could really use the fire power.",
		HAMBAT = "This seems unsanitary.",
		HAMMER = "I don't know. I think my wrench is a bit better for the job!",
		HEALINGSALVE = "It stings.",
		HEATROCK =
		{
			FROZEN = "It's colder than ice.",
			COLD = "That's a cold stone.",
			GENERIC = "I could manipulate its temperature.",
			WARM = "It's quite warm and cuddly... for a rock!",
			HOT = "Nice and toasty hot!",
		},
		HOME = "Someone must live here.",
		HOMESIGN =
		{
			GENERIC = "It says \"You are here\".",
            UNWRITTEN = "The sign is currently blank.",
			BURNT = "\"Don't play with matches.\"",
		},
		ARROWSIGN_POST =
		{
			GENERIC = "It says \"Thataway\".",
            UNWRITTEN = "The sign is currently blank.",
			BURNT = "\"Don't play with matches.\"",
		},
		ARROWSIGN_PANEL =
		{
			GENERIC = "It says \"Thataway\".",
            UNWRITTEN = "The sign is currently blank.",
			BURNT = "\"Don't play with matches.\"",
		},
		HONEY = "Looks delicious!",
		HONEYCOMB = "Reminds me of my old beemine glove.",
		HONEYHAM = "Sweet and savory.",
		HONEYNUGGETS = "Tastes like chicken, but I don't think it is.",
		HORN = "It's sound is quite loud.",
		HOUND = "Take this!",
		HOUNDCORPSE =
		{
			GENERIC = "The smell is not the most pleasant.",
			BURNING = "I think we're safe now.",
			REVIVING = "This is a bad idea!",
		},
		HOUNDBONE = "Creepy.",
		HOUNDMOUND = "There's more of them here.",
		ICEBOX = "Finally I can refridgerate my food!",
		ICEHAT = "Stay cool, boy.",
		ICEHOUND = "Oh no, this one's let me guess? A frost hound.",
		INSANITYROCK =
		{
			ACTIVE = "TAKE THAT, SANE SELF!",
			INACTIVE = "It's more of a pyramid than an obelisk.",
		},
		JAMMYPRESERVES = "Probably should have made a jar.",

		KABOBS = "Lunch on a stick.",
		KILLERBEE =
		{
			GENERIC = "Oh no! It's a killer bee!",
			HELD = "This seems dangerous.",
		},
		KNIGHT = "You're scrap!",
		KOALEFANT_SUMMER = "Adorably delicious.",
		KOALEFANT_WINTER = "It looks warm and full of meat.",
		KOALEFANT_CARCASS = "Adorably dead.",
		KRAMPUS = "Oh no you don't. Get away from my stuff!",
		KRAMPUS_SACK = "What do you have in here?",
		LEIF = "He's huge!",
		LEIF_SPARSE = "He's huge!",
		LIGHTER  = "It's her lucky lighter.",
		LIGHTNING_ROD =
		{
			CHARGED = "The power is mine!",
			GENERIC = "To harness the heavens!",
		},
		LIGHTNINGGOAT =
		{
			GENERIC = "I should be wary about them.",
			CHARGED = "I don't think it liked being struck by lightning.",
		},
		LIGHTNINGGOATHORN = "Maybe I can make use of it for one of my upgrades.",
		GOATMILK = "It's buzzing with tastiness!",
		LITTLE_WALRUS = "Should I leave them be?",
		LIVINGLOG = "Is that log watching me?",
		LOG =
		{
			BURNING = "That's some hot wood!",
			GENERIC = "It's big, it's heavy, and it's wood.",
		},
		LUCY = "That's a prettier axe than I'm used to.",
		LUREPLANT = "It's so alluring.",
		LUREPLANTBULB = "Now I can start my very own meat farm.",
		MALE_PUPPET = "He's trapped!", --single player

		MANDRAKE_ACTIVE = "Cut it out!",
		MANDRAKE_PLANTED = "I've heard strange things about those plants.",
		MANDRAKE = "Mandrake roots have strange properties.",

        MANDRAKESOUP = "Well, he won't be waking up again.",
        MANDRAKE_COOKED = "It doesn't seem so strange anymore.",
        MAPSCROLL = "A blank map. Doesn't seem very useful.",
        MARBLE = "Fancy!",
        MARBLEBEAN = "I should stop asking questions at this point.",
        MARBLEBEAN_SAPLING = "It looks carved.",
        MARBLESHRUB = "Makes sense to me.",
        MARBLEPILLAR = "I think I could use that.",
        MARBLETREE = "I don't think an axe will cut it.",
        MARSH_BUSH =
        {
			BURNT = "One less thorn patch to worry about.",
            BURNING = "That's burning fast!",
            GENERIC = "It looks thorny.",
            PICKED = "Ouch.",
        },
        BURNT_MARSH_BUSH = "It's all burnt up.",
        MARSH_PLANT = "It's a plant.",
        MARSH_TREE =
        {
            BURNING = "Spikes and fire!",
            BURNT = "Now it's burnt and spiky.",
            CHOPPED = "Not so spiky now!",
            GENERIC = "Those spikes look sharp!",
        },
        MAXWELL = "I hate that guy.",--single player
        MAXWELLHEAD = "I can see into his pores.",--removed
        MAXWELLLIGHT = "I wonder how they work.",--single player
        MAXWELLLOCK = "Looks almost like a key hole.",--single player
        MAXWELLTHRONE = "That doesn't look very comfortable.",--single player
        MEAT = "It's a bit gamey, but it'll do.",
        MEATBALLS = "It's just a big wad of meat.",
        MEATRACK =
        {
            DONE = "Awww yeah, Jerky!",
            DRYING = "Looks like I better wait, it's going to take a moment.",
            DRYINGINRAIN = "Awww, it's wet. This might delay the process.",
            GENERIC = "I could dry my catch with this.",
            BURNT = "I guess not everything lasts long.",
            DONE_NOTMEAT = "Ahhhh yeah, it's done!",
            DRYING_NOTMEAT = "If I can dry it, I'll dry it.",
            DRYINGINRAIN_NOTMEAT = "Aww no, not the rain.",
        },
        MEAT_DRIED = "Tasty, tasy beef jerky.",
        MERM = "Eugh can smell them before I see them!",
        MERMHEAD =
        {
            GENERIC = "I..I think I'm about to lose my lunch.",
            BURNT = "Nope, that made it worst.",
        },
        MERMHOUSE =
        {
            GENERIC = "Who would live here?",
            BURNT = "Nothing to live in, now.",
        },
        MINERHAT = "Yes! Hands free and ready to bash in some skulls.",
        MONKEY = "Skrunch, is that you?.",
        MONKEYBARREL = "Did that just move?",
        MONSTERLASAGNA = "Do I really have to eat this?",
        FLOWERSALAD = "A bowl of foliage.",
        ICECREAM = "I scream for ice cream!",
        WATERMELONICLE = "Cryogenic watermelon.",
        TRAILMIX = "A healthy, natural snack.",
        HOTCHILI = "Five alarm!",
        GUACAMOLE = "Avogadro's favorite dish.",
        MONSTERMEAT = "Ugh. I don't think I should eat that.",
        MONSTERMEAT_DRIED = "Strange-smelling jerky.",
        MOOSE = "I don't exactly know what that thing is.",
        MOOSE_NESTING_GROUND = "Looks like some sort of nesting ground.",
        MOOSEEGG = "I have a bad feeling about this.",
        MOSSLING = "Aaah! They're everywhere!",
        FEATHERFAN = "Down, to bring the temperature down.",
        MINIFAN = "Somehow the breeze comes out the back twice as fast.",
        GOOSE_FEATHER = "Fluffy!",
        STAFF_TORNADO = "Spinning doom.",
        MOSQUITO =
        {
            GENERIC = "At least they're not mutant swampflies.",
            HELD = "Hey, is that my blood?",
        },
        MOSQUITOSACK = "It's probably someone else's blood...",
        MOUND =
        {
            DUG = "Yeahhhh, I think Clank would judge me for doing this.",
            GENERIC = "I really don't think this is a good idea...",
        },
        NIGHTLIGHT = "It's eerie but doesn't really bother me.",
        NIGHTMAREFUEL = "Something tells me I should not mess with it!",
        NIGHTSWORD = "Why would anyone make this? It's terrifying.",
        NITRE = "I'm not a geologist.",
        ONEMANBAND = "We should add a beefalo bell.",
        OASISLAKE =
		{
			GENERIC = "Is that a mirage?",
			EMPTY = "It's dry.",
		},
        PANDORASCHEST = "It may contain something fantastic! Or horrible.",
        PANFLUTE = "Oh hey, a flute. Maybe it'll calm the wildlife.",
        PAPYRUS = "Some sheets of paper.",
        WAXPAPER = "Some sheets of wax paper.",
        PENGUIN = "I should leave them alone.",
        PERD = "Hey, I was eating those!",
        PEROGIES = "These turned out pretty good.",
        PETALS = "I took them off of the flowers.",
        PETALS_EVIL = "I'm not sure I want to hold those.",
        PHLEGM = "It's thick and pliable. And salty.",
        PICKAXE = "Iconic, isn't it?",
        PIGGYBACK = "This little piggy's gone... \"home\".",
        PIGHEAD =
        {
            GENERIC = "Looks like an offering to the beast.",
            BURNT = "Crispy.",
        },
        PIGHOUSE =
        {
            FULL = "They're watching me, aren't they?",
            GENERIC = "These pigs have pretty fancy houses.",
            LIGHTSOUT = "I know you're home! I can see you!",
            BURNT = "Ha, take that, pig!",
        },
        PIGKING = "I don't think it's time to make a plumbers crack joke, hehe.",
        PIGMAN =
        {
            DEAD = "Someone should tell their family.",
            FOLLOWER = "Come on, follow me!",
            GENERIC = "They kind of creep me out.",
            GUARD = "Oh come on guys! Why are you so serious.",
            WEREPIG = "Whoa back off!!",
        },
        PIGSKIN = "Is it supposed to still have the tail on it?",
        PIGTENT = "Smells like bacon.",
        PIGTORCH = "Sure looks cozy.",
        PINECONE = "I think a tree grows from it.",
        PINECONE_SAPLING = "It'll be a tree soon!",
        LUMPY_SAPLING = "How did this tree even reproduce?",
        PITCHFORK = "Now I just need an angry mob to join.",
        PLANTMEAT = "That doesn't look very appealing.",
        PLANTMEAT_COOKED = "At least it's warm now.",
        PLANT_NORMAL =
        {
            GENERIC = "Leafy!",
            GROWING = "Guh! It's growing so slowly!",
            READY = "Mmmm. Ready to harvest.",
            WITHERED = "The heat killed it.",
        },
        POMEGRANATE = "It looks like the inside of an alien's brain.",
        POMEGRANATE_COOKED = "Haute Cuisine!",
        POMEGRANATE_SEEDS = "It's a seed.",
        POND = "I can't see the bottom!",
        POOP = "Oh ew, that reeks like a florana dung beaver.",
        FERTILIZER = "Do I really have to carry this bucket around?",
        PUMPKIN = "It's as big as my head!",
        PUMPKINCOOKIE = "That's a pretty tasty cookie!",
        PUMPKIN_COOKED = "How did it not turn into a pie?",
        PUMPKIN_LANTERN = "Spooky!",
        PUMPKIN_SEEDS = "It's a seed.",
        PURPLEAMULET = "It's whispering to me.",
        PURPLEGEM = "It's just a purple gem.",
        RABBIT =
        {
            GENERIC = "Scavenging just like me.",
            HELD = "Looks like you're coming with me.",
        },
        RABBITHOLE =
        {
            GENERIC = "Must be where it lives.",
            SPRING = "It's blocked off.",
        },
        RAINOMETER =
        {
            GENERIC = "It measures cloudiness.",
            BURNT = "I don't know if I should say that's my fault or not.",
        },
        RAINCOAT = "Feels good to be dry.",
        RAINHAT = "At least I'm dry.",
        RATATOUILLE = "An excellent source of fiber.",
        RAZOR = "It's at least better than that faulty personal hygienator I brought once!",
        REDGEM = "It sparkles with inner warmth.",
        RED_CAP = "I don't think it's safe to eat.",
        RED_CAP_COOKED = "Eh, still a little dicey.",
        RED_MUSHROOM =
        {
            GENERIC = "It's a mushroom.",
            INGROUND = "It's sleeping.",
            PICKED = "I wonder if it will come back?",
        },
        REEDS =
        {
            BURNING = "That's really burning!",
            GENERIC = "It's a clump of reeds.",
            PICKED = "All the useful reeds have already been picked.",
        },
        RELIC = "Ancient household goods.",
        RUINS_RUBBLE = "Maybe I can fix it.",
        RUBBLE = "Just bits and pieces of rock.",
        RESEARCHLAB =
        {
            GENERIC = "Well it is basic, but it gives me something to work with.",
            BURNT = "Well that's a bummer.",
        },
        RESEARCHLAB2 =
        {
            GENERIC = "Nice, I can upgrade my tools with this!",
            BURNT = "Well that's a bummer.",
        },
        RESEARCHLAB3 =
        {
            GENERIC = "I'm unsure if Clank would approve of this. Aw well, couldn't hurt!",
            BURNT = "Well now it's burnt. Great.",
        },
        RESEARCHLAB4 =
        {
            GENERIC = "Who would name something that?",
            BURNT = "Well now it's gone.",
        },
        RESURRECTIONSTATUE =
        {
            GENERIC = "Huh, what's this?",
            BURNT = "Not much use anymore.",
        },
        RESURRECTIONSTONE = "Huh, did the locals create it?",
        ROBIN =
        {
            GENERIC = "Does that mean winter is gone?",
            HELD = "He likes my pocket.",
        },
        ROBIN_WINTER =
        {
            GENERIC = "Life in the frozen wastes.",
            HELD = "It's so soft.",
        },
        ROBOT_PUPPET = "They're trapped!", --single player
        ROCK_LIGHT =
        {
            GENERIC = "A crusted over lava pit.",--removed
            OUT = "Looks fragile.",--removed
            LOW = "The lava's crusting over.",--removed
            NORMAL = "Nice and comfy.",--removed
        },
        CAVEIN_BOULDER =
        {
            GENERIC = "I think I can lift this one.",
            RAISED = "It's out of reach.",
        },
        ROCK = "There's only one solution. Smash it.",
        PETRIFIED_TREE = "I wonder what happened to this tree?",
        ROCK_PETRIFIED_TREE = "I wonder what happened to this tree?",
        ROCK_PETRIFIED_TREE_OLD = "I wonder what happened to this tree?",
        ROCK_ICE =
        {
            GENERIC = "It's a pile of ice! Maybe I could use this!",
            MELTED = "Won't be useful until it freezes again.",
        },
        ROCK_ICE_MELTED = "Won't be useful until it freezes again.",
        ICE = "Ice! I can use this to cool down.",
        ROCKS = "We could make stuff with these.",
        ROOK = "Eat Wrench!",
        ROPE = "Some short lengths of rope.",
        ROTTENEGG = "Ugh! I think I'm going to be sick.",
        ROYAL_JELLY = "I looks energizing!",
        JELLYBEAN = "One part jelly, one part bean.",
        SADDLE_BASIC = "Nice! Maybe I could ride one of those beefalos.",
        SADDLE_RACE = "Ahaha! Time for everyone to eat my dust",
        SADDLE_WAR = "The only problem is the saddle sores.",
        SADDLEHORN = "This could take a saddle off.",
        SALTLICK = "That's really salty.",
        BRUSH = "I bet the beefalo really like this.",
		SANITYROCK =
		{
			ACTIVE = "That's a CRAZY looking rock!",
			INACTIVE = "Where did the rest of it go?",
		},
		SAPLING =
		{
			BURNING = "That's burning fast!",
			WITHERED = "It might be okay if it cooled down.",
			GENERIC = "It's a sapling!",
			PICKED = "It's picked already.",
			DISEASED = "It looks pretty sick.", --removed
			DISEASING = "Err, something's not right.", --removed
		},
   		SCARECROW =
   		{
			GENERIC = "All dressed up and no where to crow.",
			BURNING = "Someone made that strawman eat crow.",
			BURNT = "Someone MURDERed that scarecrow!",
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "We can make stone sculptures with this.",
			BLOCK = "Ready for sculpting.",
			SCULPTURE = "A masterpiece!",
			BURNT = "Burnt right down.",
   		},
        SCULPTURE_KNIGHTHEAD = "Where's the rest of it?",
		SCULPTURE_KNIGHTBODY =
		{
			COVERED = "It's an odd marble statue.",
			UNCOVERED = "I guess he cracked under the pressure.",
			FINISHED = "At least it's back in one piece now.",
			READY = "Something's moving inside.",
		},
        SCULPTURE_BISHOPHEAD = "Is that a head?",
		SCULPTURE_BISHOPBODY =
		{
			COVERED = "It looks old, but it feels new.",
			UNCOVERED = "There's a big piece missing.",
			FINISHED = "Now what?",
			READY = "Something's moving inside.",
		},
        SCULPTURE_ROOKNOSE = "Where did this come from?",
		SCULPTURE_ROOKBODY =
		{
			COVERED = "It's some sort of marble statue.",
			UNCOVERED = "It's not in the best shape.",
			FINISHED = "All patched up.",
			READY = "Something's moving inside.",
		},
        GARGOYLE_HOUND = "I don't like how it's looking at me.",
        GARGOYLE_WEREPIG = "It looks very lifelike.",
		SEEDS = "I used to buy these near my local mart.",
		SEEDS_COOKED = "That cooked the life right out of 'em!",
		SEWING_KIT = "Darn it! Darn it all to heck!",
		SEWING_TAPE = "Good for mending.",
		SHOVEL = "There's a lot going on underground.",
		SILK = "Wow this stuff is really strong.",
		SKELETON = "Poor guy, I'll hate to end up like them.",
		SCORCHED_SKELETON = "Spooky.",
		SKULLCHEST = "I'm not sure if I want to open it.", --removed
		SMALLBIRD =
		{
			GENERIC = "That's a rather small bird.",
			HUNGRY = "It looks hungry.",
			STARVING = "It must be starving.",
			SLEEPING = "It's barely making a peep.",
		},
		SMALLMEAT = "A tiny chunk of dead animal.",
		SMALLMEAT_DRIED = "A little jerky.",
		SPAT = "What a crusty looking animal.",
		SPEAR = "That's one pointy stick.",
		SPEAR_WATHGRITHR = "It feels very stabby.",
		WATHGRITHRHAT = "Pretty fancy hat, that.",
		SPIDER =
		{
			DEAD = "Well, that's gross!",
			GENERIC = "I fought fair more scarier things than them.",
			SLEEPING = "I'd better not be here when it wakes up.",
		},
		SPIDERDEN = "Sticky!",
		SPIDEREGGSACK = "I hope these don't hatch while I'm holding them.",
		SPIDERGLAND = "It has a tangy, antiseptic smell.",
		SPIDERHAT = "I hope I got all of the spider goo out of it.",
		SPIDERQUEEN = "Ready to fight if I need to!",
		SPIDER_WARRIOR =
		{
			DEAD = "Good riddance!",
			GENERIC = "Looks even meaner than usual.",
			SLEEPING = "I should keep my distance.",
		},
		SPOILED_FOOD = "Do I really have to touch it?",
        STAGEHAND =
        {
			AWAKE = "What is it?",
			HIDING = "Yeah, I'm not fooled. Come on out.",
        },
        STATUE_MARBLE =
        {
            GENERIC = "It's a fancy marble statue.",
            TYPE1 = "Don't lose your head now!",
            TYPE2 = "Statuesque.",
            TYPE3 = "I wonder who the artist is.", --bird bath type statue
        },
		STATUEHARP = "What happened to the head?",
		STATUEMAXWELL = "So is he compensating for something?",
		STEELWOOL = "Scratchy metal fibers.",
		STINGER = "Looks sharp!",
		STRAWHAT = "I don't look great in it, but at least it provides shade.",
		STUFFEDEGGPLANT = "It's really stuffing!",
		SWEATERVEST = "Hey, this is pretty cozy.",
		REFLECTIVEVEST = "At least it'll keep me cool!",
		HAWAIIANSHIRT = "It's not lab-safe!",
		TAFFY = "Ahh, a little junk food won't hurt.",
		TALLBIRD = "That's a tall bird!",
		TALLBIRDEGG = "Will it hatch?",
		TALLBIRDEGG_COOKED = "Delicious and nutritious.",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "It's cold to the touch.",
			GENERIC = "Looks like it's hatching!",
			HOT = "Looks like it's overheating.",
			LONG = "I have a feeling this is going to take a while...",
			SHORT = "It should hatch any time now.",
		},
		TALLBIRDNEST =
		{
			GENERIC = "That's quite an egg!",
			PICKED = "The nest is empty.",
		},
		TEENBIRD =
		{
			GENERIC = "Not a very tall bird.",
			HUNGRY = "You need some food and quick, huh?",
			STARVING = "Um, nice birdy. I'm not exactly that tasty.",
			SLEEPING = "It's getting some shut-eye",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "With this I can surely pass through space and time!", --single player
			GENERIC = "This appears to be a nexus to another world!", --single player
			LOCKED = "There's still something missing.", --single player
			PARTIAL = "Soon, the invention will be complete!", --single player
		},
		TELEPORTATO_BOX = "This may control the polarity of the whole universe.", --single player
		TELEPORTATO_CRANK = "Tough enough to handle the most intense experiments.", --single player
		TELEPORTATO_POTATO = "This metal potato contains great and fearful power...", --single player
		TELEPORTATO_RING = "A ring that could focus dimensional energies.", --single player
		TELESTAFF = "It reminds me of my old warp pad, except it's far more crude.",
		TENT =
		{
			GENERIC = "Without nanotech, I can't function without sleep.",
			BURNT = "Nothing left to sleep in.",
		},
		SIESTAHUT =
		{
			GENERIC = "A nice place for a brief rest.",
			BURNT = "It won't provide much shade now.",
		},
		TENTACLE = "I better keep my distance from it.",
		TENTACLESPIKE = "A weapon's a weapon but I think I prefer my wrench over it, yuck.",
		TENTACLESPOTS = "It's days like this that makes me glad I always wear gloves.",
		TENTACLE_PILLAR = "I don't want to know what it's attached to.",
        TENTACLE_PILLAR_HOLE = "Aww gross. It smells like an ameboid infested sewer down there.",
		TENTACLE_PILLAR_ARM = "It's quite disturbing.",
		TENTACLE_GARDEN = "I still don't want to know what it's attached to.",
		TOPHAT = "Nice hat.",
		TORCH = "It should help me see better.",
		TRANSISTOR = "Hey! Maybe I could use this to upgrade my tools.",
		TRAP = "This should catch something.",
		TRAP_TEETH = "Wouldn't want to be caught in that.",
		TRAP_TEETH_MAXWELL = "I'll want to avoid stepping on that!", --single player
		TREASURECHEST =
		{
			GENERIC = "I can finally store my belongings!",
			BURNT = "Awwww, blarg.",
		},
		TREASURECHEST_TRAP = "Well, that's just great!",
		SACRED_CHEST =
		{
			GENERIC = "I hear whispers. It wants something.",
			LOCKED = "It's passing its judgment.",
		},
		TREECLUMP = "It's almost like someone is trying to prevent me from going somewhere.", --removed

		TRINKET_1 = "Looks like someone left them out too long on Tabora.", --Melted Marbles
		TRINKET_2 = "What's a kazoo doing out here?", --Fake Kazoo
		TRINKET_3 = "It's a random piece of tied rope.", --Gord's Knot
		TRINKET_4 = "Hey, look! A lawn ninja ornament!", --Gnome
		TRINKET_5 = "If only it were big enough and functional to escape away on.", --Toy Rocketship
		TRINKET_6 = "Oh hey, maybe I could make use out of these to upgrade my wrench.", --Frazzled Wires
		TRINKET_7 = "I wonder who lost these!", --Ball and Cup
		TRINKET_8 = "Well, that's random.", --Rubber Bung
		TRINKET_9 = "Who lost these?", --Mismatched Buttons
		TRINKET_10 = "Um, I think someone might be missing these.", --Dentures
		TRINKET_11 = "Hmmmm, I wonder if I can rewire and....nah it's not worth it...or maybe...", --Lying Robot
		TRINKET_12 = "Uhhh, not thanks.", --Dessicated Tentacle
		TRINKET_13 = "Hey, look! A lawn ninja ornament!.", --Gnomette
		TRINKET_14 = "Now if I only had some tea...", --Leaky Teacup
		TRINKET_15 = "...Maxwell left his stuff out again.", --Pawn
		TRINKET_16 = "...Maxwell left his stuff out again.", --Pawn
		TRINKET_17 = "A horrifying utensil fusion. Maybe science *can* go too far.", --Bent Spork
		TRINKET_18 = "I wonder what it's hiding?", --Trojan Horse
		TRINKET_19 = "It doesn't spin very well.", --Unbalanced Top
		TRINKET_20 = "It just makes me wish for a nice hot shower at my apartment in metropolis.", --Backscratcher
		TRINKET_21 = "This egg beater is all bent out of shape.", --Egg Beater
		TRINKET_22 = "I have a few theories about this string.", --Frayed Yarn
		TRINKET_23 = "I can put my shoes on without help, thanks.", --Shoehorn
		TRINKET_24 = "I think Wickerbottom had a cat.", --Lucky Cat Jar
		TRINKET_25 = "I know a few places that would need it.", --Air Unfreshener
		TRINKET_26 = "Food and a cup! The ultimate survival container.", --Potato Cup
		TRINKET_27 = "If you unwound it you could poke someone from really far away.", --Coat Hanger
		TRINKET_28 = "How Machiavellian.", --Rook
        TRINKET_29 = "How Machiavellian.", --Rook
        TRINKET_30 = "Honestly, he just leaves them out wherever.", --Knight
        TRINKET_31 = "Honestly, he just leaves them out wherever.", --Knight
        TRINKET_32 = "I know someone who'd have a ball with this!", --Cubic Zirconia Ball
        TRINKET_33 = "I hope this doesn't attract spiders.", --Spider Ring
        TRINKET_34 = "Let's make a wish. For science.", --Monkey Paw
        TRINKET_35 = "Hard to find a good flask around here.", --Empty Elixir
        TRINKET_36 = "I might need these after all that candy.", --Faux fangs
        TRINKET_37 = "Was it really used as a weapon?", --Broken Stake
        TRINKET_38 = "I think it came from another world. One with grifts.", -- Binoculars Griftlands trinket
        TRINKET_39 = "I wonder where the other one is?", -- Lone Glove Griftlands trinket
        TRINKET_40 = "Holding it makes me feel like bartering.", -- Snail Scale Griftlands trinket
        TRINKET_41 = "It's a little warm to the touch.", -- Goop Canister Hot Lava trinket
        TRINKET_42 = "It's full of someone's childhood memories.", -- Toy Cobra Hot Lava trinket
        TRINKET_43= "It's not very good at jumping.", -- Crocodile Toy Hot Lava trinket
        TRINKET_44 = "It's some sort of plant specimen.", -- Broken Terrarium ONI trinket
        TRINKET_45 = "If this is picking up frequencies from elsewhere. Maybe I can catch the right ones home too.", -- Odd Radio ONI trinket
        TRINKET_46 = "Is that a hairdryer?", -- Hairdryer ONI trinket

        -- The numbers align with the trinket numbers above.
        LOST_TOY_1  = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_2  = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_7  = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_10 = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_11 = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_14 = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_18 = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_19 = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_42 = "I'm sure there's a perfectly scientific explanation for that.",
        LOST_TOY_43 = "I'm sure there's a perfectly scientific explanation for that.",

        HALLOWEENCANDY_1 = "The cavities are probably worth it, right?",
        HALLOWEENCANDY_2 = "What corruption of science grew these?",
        HALLOWEENCANDY_3 = "It's... corn.",
        HALLOWEENCANDY_4 = "They wriggle on the way down.",
        HALLOWEENCANDY_5 = "My teeth are going to have something to say about this tomorrow.",
        HALLOWEENCANDY_6 = "I... don't think I'll be eating those.",
        HALLOWEENCANDY_7 = "Everyone'll be raisin' a fuss over these.",
        HALLOWEENCANDY_8 = "Only a sucker wouldn't love this.",
        HALLOWEENCANDY_9 = "Sticks to your teeth.",
        HALLOWEENCANDY_10 = "Only a sucker wouldn't love this.",
        HALLOWEENCANDY_11 = "Much better tasting than the real thing.",
        HALLOWEENCANDY_12 = "Did that candy just move?", --ONI meal lice candy
        HALLOWEENCANDY_13 = "Oh, my poor jaw.", --Griftlands themed candy
        HALLOWEENCANDY_14 = "I don't do well with spice.", --Hot Lava pepper candy
        CANDYBAG = "It's some sort of delicious pocket dimension for sugary treats.",

		HALLOWEEN_ORNAMENT_1 = "A spectornament I could hang in a tree.",
		HALLOWEEN_ORNAMENT_2 = "Completely batty decoration.",
		HALLOWEEN_ORNAMENT_3 = "This wood look good hanging somewhere.",
		HALLOWEEN_ORNAMENT_4 = "Almost i-tentacle to the real ones.",
		HALLOWEEN_ORNAMENT_5 = "Eight-armed adornment.",
		HALLOWEEN_ORNAMENT_6 = "Everyone's raven about tree decorations these days.",

		HALLOWEENPOTION_DRINKS_WEAK = "I was hoping for something bigger.",
		HALLOWEENPOTION_DRINKS_POTENT = "A potent potion.",
        HALLOWEENPOTION_BRAVERY = "Full of grit.",
		HALLOWEENPOTION_MOON = "Infused with transforming such-and-such.",
		HALLOWEENPOTION_FIRE_FX = "Crystallized inferno.",
		MADSCIENCE_LAB = "Seems like something Nefarious would mess around with.",
		LIVINGTREE_ROOT = "Something's in there! I'll have to root it out.",
		LIVINGTREE_SAPLING = "It'll grow up big and horrifying.",

        DRAGONHEADHAT = "Haha! Look I'm a dragon!",
        DRAGONBODYHAT = "It could be worst. I could be in the rear end.",
        DRAGONTAILHAT = "Nuh uh, I'm not going to be the butt.",
        PERDSHRINE =
        {
            GENERIC = "I feel like it wants something.",
            EMPTY = "I've got to plant something there.",
            BURNT = "That won't do at all.",
        },
        REDLANTERN = "This lantern feels more special than the others.",
        LUCKY_GOLDNUGGET = "What a lucky find!",
        FIRECRACKERS = "Filled with explosion science!",
        PERDFAN = "It's inordinately large.",
        REDPOUCH = "Is there something inside?",
        WARGSHRINE =
        {
            GENERIC = "I should make something fun.",
            EMPTY = "I need to put a torch in it.",
            BURNING = "I should make something fun.", --for willow to override
            BURNT = "It burned down.",
        },
        CLAYWARG =
        {
        	GENERIC = "A terror cotta monster!",
        	STATUE = "Did it just move?",
        },
        CLAYHOUND =
        {
        	GENERIC = "It's been unleashed!",
        	STATUE = "It looks so real.",
        },
        HOUNDWHISTLE = "With this, maybe those dogs will stop biting me.",
        CHESSPIECE_CLAYHOUND = "That thing's the leashed of my worries.",
        CHESSPIECE_CLAYWARG = "And I didn't even get eaten!",

		PIGSHRINE =
		{
            GENERIC = "More stuff to make.",
            EMPTY = "It's hungry for meat.",
            BURNT = "Burnt out.",
		},
		PIG_TOKEN = "This looks important.",
		PIG_COIN = "This'll pay off in a fight.",
		YOTP_FOOD1 = "A feast fit for me.",
		YOTP_FOOD2 = "A meal only a beast would love.",
		YOTP_FOOD3 = "Nothing fancy.",

		PIGELITE1 = "What are you looking at?", --BLUE
		PIGELITE2 = "He's got gold fever!", --RED
		PIGELITE3 = "Here's mud in your eye!", --WHITE
		PIGELITE4 = "Wouldn't you rather hit someone else?", --GREEN

		PIGELITEFIGHTER1 = "What are you looking at?", --BLUE
		PIGELITEFIGHTER2 = "He's got gold fever!", --RED
		PIGELITEFIGHTER3 = "Here's mud in your eye!", --WHITE
		PIGELITEFIGHTER4 = "Wouldn't you rather hit someone else?", --GREEN

		CARRAT_GHOSTRACER = "That's... disconcerting.",

        YOTC_CARRAT_RACE_START = "It's a good enough place to start.",
        YOTC_CARRAT_RACE_CHECKPOINT = "You've made your point.",
        YOTC_CARRAT_RACE_FINISH =
        {
            GENERIC = "It's really more of a finish circle than a line.",
            BURNT = "It's all gone up in flames!",
            I_WON = "Ha HA! Science prevails!",
            SOMEONE_ELSE_WON = "Sigh... congratulations, {winner}.",
        },

		YOTC_CARRAT_RACE_START_ITEM = "Well, it's a start.",
        YOTC_CARRAT_RACE_CHECKPOINT_ITEM = "That checks out.",
		YOTC_CARRAT_RACE_FINISH_ITEM = "The end's in sight.",

		YOTC_SEEDPACKET = "Looks pretty seedy, if you ask me.",
		YOTC_SEEDPACKET_RARE = "Hey there, fancy-plants!",

		MINIBOATLANTERN = "How illuminating!",

        YOTC_CARRATSHRINE =
        {
            GENERIC = "What to make...",
            EMPTY = "Hm... what does a carrat like to eat?",
            BURNT = "Smells like roasted carrots.",
        },

        YOTC_CARRAT_GYM_DIRECTION =
        {
            GENERIC = "This'll get things moving in the right direction.",
            RAT = "You would make an excellent lab rat.",
            BURNT = "My training regimen crashed and burned.",
        },
        YOTC_CARRAT_GYM_SPEED =
        {
            GENERIC = "I need to get my carrat up to speed.",
            RAT = "Faster... faster!",
            BURNT = "I may have overdone it.",
        },
        YOTC_CARRAT_GYM_REACTION =
        {
            GENERIC = "Let's train those carrat-like reflexes!",
            RAT = "The subject's response time is steadily improving!",
            BURNT = "A small loss to take in the pursuit of science.",
        },
        YOTC_CARRAT_GYM_STAMINA =
        {
            GENERIC = "Getting strong now!",
            RAT = "This carrat... will be unstoppable!!",
            BURNT = "You can't stop progress! But this will delay it...",
        },

        YOTC_CARRAT_GYM_DIRECTION_ITEM = "I'd better get training!",
        YOTC_CARRAT_GYM_SPEED_ITEM = "I'd better get this assembled.",
        YOTC_CARRAT_GYM_STAMINA_ITEM = "This should help improve my carrat's stamina",
        YOTC_CARRAT_GYM_REACTION_ITEM = "This should improve my carrat's reaction time considerably.",

        YOTC_CARRAT_SCALE_ITEM = "This will help car-rate my car-rat.",
        YOTC_CARRAT_SCALE =
        {
            GENERIC = "Hopefully the scales tip in my favor.",
            CARRAT = "I suppose no matter what, it's still just a sentient vegetable.",
            CARRAT_GOOD = "This carrat looks ripe for racing!",
            BURNT = "What a mess.",
        },

        YOTB_BEEFALOSHRINE =
        {
            GENERIC = "What to make...",
            EMPTY = "Hm... what makes a beefalo?",
            BURNT = "Smells like barbeque.",
        },

        BEEFALO_GROOMER =
        {
            GENERIC = "There's no beefalo here to groom.",
            OCCUPIED = "Let's beautify this beefalo!",
            BURNT = "I styled my beefalo in the hottest fashions... and paid the price.",
        },
        BEEFALO_GROOMER_ITEM = "I'd better set this up somewhere.",

        YOTR_RABBITSHRINE =
        {
            GENERIC = "What to make...",
            EMPTY = "That rabbit looks hungry.",
            BURNT = "Smells like veggie barbecue.",
        },

        NIGHTCAPHAT = "No more bedhead for this scientist!",

        YOTR_FOOD1 = "It's made with carrots, so science says it must be healthy.",
        YOTR_FOOD2 = "Blue is the most scientific flavor.",
        YOTR_FOOD3 = "A jiggly treat.",
        YOTR_FOOD4 = "Bunny-hop right into my mouth!",

        YOTR_TOKEN = "I should be careful who I hand this out to.",

        COZY_BUNNYMAN = "They look so cozy.",

        HANDPILLOW_BEEFALOWOOL = "If only it didn't also smell like a beefalo.",
        HANDPILLOW_KELP = "It's soggier than I would like.",
        HANDPILLOW_PETALS = "At least it smells nicer than the beefalo pillow.",
        HANDPILLOW_STEELWOOL = "Who would sleep on this?",

        BODYPILLOW_BEEFALOWOOL = "If only it didn't also smell like a beefalo.",
        BODYPILLOW_KELP = "It's soggier than I would like.",
        BODYPILLOW_PETALS = "At least it smells nicer than the beefalo pillow.",
        BODYPILLOW_STEELWOOL = "Who would sleep on this?",

		BISHOP_CHARGE_HIT = "Ow!",
		TRUNKVEST_SUMMER = "Wilderness casual.",
		TRUNKVEST_WINTER = "Winter survival gear.",
		TRUNK_COOKED = "Doesn't look very appealing but I'll eat it.",
		TRUNK_SUMMER = "It came off that creature.",
		TRUNK_WINTER = "It came off that creature.",
		TUMBLEWEED = "Who knows what that tumbleweed has picked up.",
		TURKEYDINNER = "Mmmm.",
		TWIGS = "It's a bunch of small twigs.",
		UMBRELLA = "Okay good, an easy way to keep dry.",
		GRASS_UMBRELLA = "Well, it's better than nothing.",
		UNIMPLEMENTED = "It doesn't look finished! It could be dangerous.",
		WAFFLES = "I'm waffling on whether it needs more syrup.",
		WALL_HAY =
		{
			GENERIC = "Hmmmm. I guess that'll have to do.",
			BURNT = "That won't do at all.",
		},
		WALL_HAY_ITEM = "This seems like a bad idea.",
		WALL_STONE = "That's a nice wall.",
		WALL_STONE_ITEM = "They make me feel so safe.",
		WALL_RUINS = "An ancient piece of wall.",
		WALL_RUINS_ITEM = "A solid piece of history.",
		WALL_WOOD =
		{
			GENERIC = "Pointy!",
			BURNT = "Burnt!",
		},
		WALL_WOOD_ITEM = "Pickets!",
		WALL_MOONROCK = "Spacey and smooth!",
		WALL_MOONROCK_ITEM = "Very light, but surprisingly tough.",
		WALL_DREADSTONE = " I feel so... safe?",
		WALL_DREADSTONE_ITEM = "What could go wrong?",
		FENCE = "It's just a wood fence.",
        FENCE_ITEM = "All we need to build a nice, sturdy fence.",
        FENCE_GATE = "It opens. And closes sometimes, too.",
        FENCE_GATE_ITEM = "All we need to build a nice, sturdy gate.",
		WALRUS = "They look like they're searching for a fight.",
		WALRUSHAT = "Less itchy than the straw, but overall nice.",
		WALRUS_CAMP =
		{
			EMPTY = "Looks like somebody was camping here.",
			GENERIC = "It looks warm and cozy inside.",
		},
		WALRUS_TUSK = "I'm sure I'll find a use for it eventually.",
		WARDROBE =
		{
			GENERIC = "I could use for a change of clothes.",
            BURNING = "That's burning fast!",
			BURNT = "Blarg, that's a bummer.",
		},
		WARG = "You must be their leader. If so, I won't back down.",
        WARGLET = "It's going to be one of those days...",

		WASPHIVE = "Better keep my distance, I think they sound pretty angry.",
		WATERBALLOON = "I wonder if I could get away with tossing it at someone!",
		WATERMELON = "Sticky sweet.",
		WATERMELON_COOKED = "Juicy and warm.",
		WATERMELONHAT = "Ahhh yuck, it's sticking to my fur.",
		WAXWELLJOURNAL =
		{
			GENERIC = "I don't think I should read someone elses diary.",
			NEEDSFUEL = "only_used_by_waxwell",
		},
		WETGOOP = "It tastes like nothing.",
        WHIP = "Oh hey, it reminds me of my old plasma whip.",
		WINTERHAT = "It'll be good for when winter comes.",
		WINTEROMETER =
		{
			GENERIC = "Mercurial.",
			BURNT = "Its measuring days are over.",
		},

        WINTER_TREE =
        {
            BURNT = "That puts a damper on the festivities.",
            BURNING = "That was a mistake, I think.",
            CANDECORATE = "Happy Winter's Feast!",
            YOUNG = "It's almost Winter's Feast!",
        },
		WINTER_TREESTAND =
		{
			GENERIC = "I need a pine cone for that.",
            BURNT = "That puts a damper on the festivities.",
		},
        WINTER_ORNAMENT = "Every scientist appreciates a good bauble.",
        WINTER_ORNAMENTLIGHT = "A tree's not complete without some electricity.",
        WINTER_ORNAMENTBOSS = "This one is especially impressive.",
		WINTER_ORNAMENTFORGE = "I should hang this one over a fire.",
		WINTER_ORNAMENTGORGE = "For some reason it makes me hungry.",

        WINTER_FOOD1 = "The anatomy's not right, but I'll overlook it.", --gingerbread cookie
        WINTER_FOOD2 = "I'm going to eat forty. For science.", --sugar cookie
        WINTER_FOOD3 = "A Yuletide toothache waiting to happen.", --candy cane
        WINTER_FOOD4 = "That experiment may have been a tiny bit unethical.", --fruitcake
        WINTER_FOOD5 = "It's nice to eat something other than berries for once.", --yule log cake
        WINTER_FOOD6 = "I'm puddin' that straight in my mouth!", --plum pudding
        WINTER_FOOD7 = "It's a hollowed apple filled with yummy juice.", --apple cider
        WINTER_FOOD8 = "How does it stay warm? A thermodynamical mug?", --hot cocoa
        WINTER_FOOD9 = "Can science explain why it tastes so good?", --eggnog

		WINTERSFEASTOVEN =
		{
			GENERIC = "A festive furnace for flame-grilled foodstuffs!",
			COOKING = "Cooking really is a science.",
			ALMOST_DONE_COOKING = "The science is almost done!",
			DISH_READY = "Science says it's done.",
		},
		BERRYSAUCE = "Equal parts merry and berry.",
		BIBINGKA = "Soft and spongy.",
		CABBAGEROLLS = "The meat hides inside the cabbage to avoid predators.",
		FESTIVEFISH = "I wouldn't mind sampling some seasonal seafood.",
		GRAVY = "It's all gravy.",
		LATKES = "I could eat a latke more of these.",
		LUTEFISK = "Is there any trumpetfisk?",
		MULLEDDRINK = "This punch has a kick to it.",
		PANETTONE = "This Yuletide bread really rose to the occasion.",
		PAVLOVA = "I lova good Pavlova.",
		PICKLEDHERRING = "You won't be herring any complaints from me.",
		POLISHCOOKIE = "I'll polish off this whole plate!",
		PUMPKINPIE = "I should probably just eat the whole thing... for science.",
		ROASTTURKEY = "I see a big juicy drumstick with my name on it.",
		STUFFING = "That's the good stuff!",
		SWEETPOTATO = "Science has created a hybrid between dinner and dessert.",
		TAMALES = "If I eat much more I'm going to start feeling a bit husky.",
		TOURTIERE = "Pleased to eat you.",

		TABLE_WINTERS_FEAST =
		{
			GENERIC = "A feastival table.",
			HAS_FOOD = "Time to eat!",
			WRONG_TYPE = "It's not the season for that.",
			BURNT = "Who would do such a thing?",
		},

		GINGERBREADWARG = "Time to desert this dessert.",
		GINGERBREADHOUSE = "Room and board all rolled into one.",
		GINGERBREADPIG = "I'd better follow him.",
		CRUMBS = "A crummy way to hide yourself.",
		WINTERSFEASTFUEL = "The spirit of the season!",

        KLAUS = "What on earth is that thing!",
        KLAUS_SACK = "We should definitely open that.",
		KLAUSSACKKEY = "It's really fancy for a deer antler.",
		WORMHOLE =
		{
			GENERIC = "Soft and undulating.",
			OPEN = "Science compels me to jump in.",
		},
		WORMHOLE_LIMITED = "Guh, that thing looks worse off than usual.",
		ACCOMPLISHMENT_SHRINE = "I want to use it, and I want the world to know that I did.", --single player
		LIVINGTREE = "Is it watching me?",
		ICESTAFF = "It's cold to the touch.",
		REVIVER = "Well this turned morbid.",
		SHADOWHEART = "Okay now that's a bit dicey...",
        ATRIUM_RUBBLE =
        {
			LINE_1 = "It depicts an old civilization. The people look hungry and scared.",
			LINE_2 = "This tablet is too worn to make out.",
			LINE_3 = "Something dark creeps over the city and its people.",
			LINE_4 = "The people are shedding their skins. They look different underneath.",
			LINE_5 = "It shows a massive, technologically advanced city.",
		},
        ATRIUM_STATUE = "It doesn't seem fully real.",
        ATRIUM_LIGHT =
        {
			ON = "A truly unsettling light.",
			OFF = "Something must power it.",
		},
        ATRIUM_GATE =
        {
			ON = "Back in working order.",
			OFF = "The essential components are still intact.",
			CHARGING = "It's gaining power.",
			DESTABILIZING = "The gateway is destabilizing.",
			COOLDOWN = "It needs time to recover. Me too.",
        },
        ATRIUM_KEY = "There is power emanating from it.",
		LIFEINJECTOR = "A scientific breakthrough! The cure!",
		SKELETON_PLAYER =
		{
			MALE = "%s must've died performing an experiment with %s.",
			FEMALE = "%s must've died performing an experiment with %s.",
			ROBOT = "%s must've died performing an experiment with %s.",
			DEFAULT = "%s must've died performing an experiment with %s.",
		},
		HUMANMEAT = "Flesh is flesh. Where do I draw the line?",
		HUMANMEAT_COOKED = "Cooked nice and pink, but still morally gray.",
		HUMANMEAT_DRIED = "Letting it dry makes it not come from a human, right?",
		ROCK_MOON = "That rock came from the moon.",
		MOONROCKNUGGET = "I think it came from the moon.",
		MOONROCKCRATER = "I should stick something shiny in it. For research.",
		MOONROCKSEED = "There's science inside!",

        REDMOONEYE = "It can see and be seen for miles!",
        PURPLEMOONEYE = "Makes a good marker, but I wish it'd stop looking at me.",
        GREENMOONEYE = "That'll keep a watchful eye on the place.",
        ORANGEMOONEYE = "No one could get lost with that thing looking out for them.",
        YELLOWMOONEYE = "That ought to show everyone the way.",
        BLUEMOONEYE = "It's always smart to keep an eye out.",

        --Arena Event
        LAVAARENA_BOARLORD = "That's the guy in charge here.",
        BOARRIOR = "You sure are big!",
        BOARON = "I can take him!",
        PEGHOOK = "That spit is corrosive!",
        TRAILS = "He's got a strong arm on him.",
        TURTILLUS = "Its shell is so spiky!",
        SNAPPER = "This one's got bite.",
		RHINODRILL = "He's got a nose for this kind of work.",
		BEETLETAUR = "I can smell him from here!",

        LAVAARENA_PORTAL =
        {
            ON = "I'll just be going now.",
            GENERIC = "That's how we got here. Hopefully how we get back, too.",
        },
        LAVAARENA_KEYHOLE = "It needs a key.",
		LAVAARENA_KEYHOLE_FULL = "That should do it.",
        LAVAARENA_BATTLESTANDARD = "Everyone, break the Battle Standard!",
        LAVAARENA_SPAWNER = "This is where those enemies are coming from.",

        HEALINGSTAFF = "It conducts regenerative energy.",
        FIREBALLSTAFF = "It calls a meteor from above.",
        HAMMER_MJOLNIR = "It's a heavy hammer for hitting things.",
        SPEAR_GUNGNIR = "I could do a quick charge with that.",
        BLOWDART_LAVA = "That's a weapon I could use from range.",
        BLOWDART_LAVA2 = "It uses a strong blast of air to propel a projectile.",
        LAVAARENA_LUCY = "That weapon's for throwing.",
        WEBBER_SPIDER_MINION = "I guess they're fighting for us.",
        BOOK_FOSSIL = "This'll keep those monsters held for a little while.",
		LAVAARENA_BERNIE = "He might make a good distraction for us.",
		SPEAR_LANCE = "It gets to the point.",
		BOOK_ELEMENTAL = "I can't make out the text.",
		LAVAARENA_ELEMENTAL = "It's a rock monster!",

   		LAVAARENA_ARMORLIGHT = "Light, but not very durable.",
		LAVAARENA_ARMORLIGHTSPEED = "Lightweight and designed for mobility.",
		LAVAARENA_ARMORMEDIUM = "It offers a decent amount of protection.",
		LAVAARENA_ARMORMEDIUMDAMAGER = "That could help me hit a little harder.",
		LAVAARENA_ARMORMEDIUMRECHARGER = "I'd have energy for a few more stunts wearing that.",
		LAVAARENA_ARMORHEAVY = "That's as good as it gets.",
		LAVAARENA_ARMOREXTRAHEAVY = "This armor has been petrified for maximum protection.",

		LAVAARENA_FEATHERCROWNHAT = "Those fluffy feathers make me want to run!",
        LAVAARENA_HEALINGFLOWERHAT = "The blossom interacts well with healing magic.",
        LAVAARENA_LIGHTDAMAGERHAT = "My strikes would hurt a little more wearing that.",
        LAVAARENA_STRONGDAMAGERHAT = "It looks like it packs a wallop.",
        LAVAARENA_TIARAFLOWERPETALSHAT = "Looks like it amplifies healing expertise.",
        LAVAARENA_EYECIRCLETHAT = "It has a gaze full of science.",
        LAVAARENA_RECHARGERHAT = "Those crystals will quicken my abilities.",
        LAVAARENA_HEALINGGARLANDHAT = "This garland will restore a bit of my vitality.",
        LAVAARENA_CROWNDAMAGERHAT = "That could cause some major destruction.",

		LAVAARENA_ARMOR_HP = "That should keep me safe.",

		LAVAARENA_FIREBOMB = "It smells like brimstone.",
		LAVAARENA_HEAVYBLADE = "A sharp looking instrument.",

        --Quagmire
        QUAGMIRE_ALTAR =
        {
        	GENERIC = "We'd better start cooking some offerings.",
        	FULL = "It's in the process of digestinating.",
    	},
		QUAGMIRE_ALTAR_STATUE1 = "It's an old statue.",
		QUAGMIRE_PARK_FOUNTAIN = "Been a long time since it was hooked up to water.",

        QUAGMIRE_HOE = "It's a farming instrument.",

        QUAGMIRE_TURNIP = "It's a raw turnip.",
        QUAGMIRE_TURNIP_COOKED = "Cooking is science in practice.",
        QUAGMIRE_TURNIP_SEEDS = "A handful of odd seeds.",

        QUAGMIRE_GARLIC = "The number one breath enhancer.",
        QUAGMIRE_GARLIC_COOKED = "Perfectly browned.",
        QUAGMIRE_GARLIC_SEEDS = "A handful of odd seeds.",

        QUAGMIRE_ONION = "Looks crunchy.",
        QUAGMIRE_ONION_COOKED = "A successful chemical reaction.",
        QUAGMIRE_ONION_SEEDS = "A handful of odd seeds.",

        QUAGMIRE_POTATO = "The apples of the earth.",
        QUAGMIRE_POTATO_COOKED = "A successful temperature experiment.",
        QUAGMIRE_POTATO_SEEDS = "A handful of odd seeds.",

        QUAGMIRE_TOMATO = "It's red because it's full of science.",
        QUAGMIRE_TOMATO_COOKED = "Cooking's easy if you understand chemistry.",
        QUAGMIRE_TOMATO_SEEDS = "A handful of odd seeds.",

        QUAGMIRE_FLOUR = "Ready for baking.",
        QUAGMIRE_WHEAT = "It looks a bit grainy.",
        QUAGMIRE_WHEAT_SEEDS = "A handful of odd seeds.",
        --NOTE: raw/cooked carrot uses regular carrot strings
        QUAGMIRE_CARROT_SEEDS = "A handful of odd seeds.",

        QUAGMIRE_ROTTEN_CROP = "I don't think the altar will want that.",

		QUAGMIRE_SALMON = "Mm, fresh fish.",
		QUAGMIRE_SALMON_COOKED = "Ready for the dinner table.",
		QUAGMIRE_CRABMEAT = "No imitations here.",
		QUAGMIRE_CRABMEAT_COOKED = "I can put a meal together in a pinch.",
		QUAGMIRE_SUGARWOODTREE =
		{
			GENERIC = "It's full of delicious, delicious sap.",
			STUMP = "Where'd the tree go? I'm stumped.",
			TAPPED_EMPTY = "Here sappy, sappy, sap.",
			TAPPED_READY = "Sweet golden sap.",
			TAPPED_BUGS = "That's how you get ants.",
			WOUNDED = "It looks ill.",
		},
		QUAGMIRE_SPOTSPICE_SHRUB =
		{
			GENERIC = "It reminds me of those tentacle monsters.",
			PICKED = "I can't get anymore out of that shrub.",
		},
		QUAGMIRE_SPOTSPICE_SPRIG = "I could grind it up to make a spice.",
		QUAGMIRE_SPOTSPICE_GROUND = "Flavorful.",
		QUAGMIRE_SAPBUCKET = "We can use it to gather sap from the trees.",
		QUAGMIRE_SAP = "It tastes sweet.",
		QUAGMIRE_SALT_RACK =
		{
			READY = "Salt has gathered on the rope.",
			GENERIC = "Science takes time.",
		},

		QUAGMIRE_POND_SALT = "A little salty spring.",
		QUAGMIRE_SALT_RACK_ITEM = "For harvesting salt from the pond.",

		QUAGMIRE_SAFE =
		{
			GENERIC = "It's a safe. For keeping things safe.",
			LOCKED = "It won't open without the key.",
		},

		QUAGMIRE_KEY = "Safe bet this'll come in handy.",
		QUAGMIRE_KEY_PARK = "I'll park it in my pocket until I get to the park.",
        QUAGMIRE_PORTAL_KEY = "This looks science-y.",


		QUAGMIRE_MUSHROOMSTUMP =
		{
			GENERIC = "Are those mushrooms? I'm stumped.",
			PICKED = "I don't think it's growing back.",
		},
		QUAGMIRE_MUSHROOMS = "These are edible mushrooms.",
        QUAGMIRE_MEALINGSTONE = "The daily grind.",
		QUAGMIRE_PEBBLECRAB = "That rock's alive!",


		QUAGMIRE_RUBBLE_CARRIAGE = "On the road to nowhere.",
        QUAGMIRE_RUBBLE_CLOCK = "Someone beat the clock. Literally.",
        QUAGMIRE_RUBBLE_CATHEDRAL = "Preyed upon.",
        QUAGMIRE_RUBBLE_PUBDOOR = "No longer a-door-able.",
        QUAGMIRE_RUBBLE_ROOF = "Someone hit the roof.",
        QUAGMIRE_RUBBLE_CLOCKTOWER = "That clock's been punched.",
        QUAGMIRE_RUBBLE_BIKE = "Must have mis-spoke.",
        QUAGMIRE_RUBBLE_HOUSE =
        {
            "No one's here.",
            "Something destroyed this town.",
            "I wonder who they angered.",
        },
        QUAGMIRE_RUBBLE_CHIMNEY = "Something put a damper on that chimney.",
        QUAGMIRE_RUBBLE_CHIMNEY2 = "Something put a damper on that chimney.",
        QUAGMIRE_MERMHOUSE = "What an ugly little house.",
        QUAGMIRE_SWAMPIG_HOUSE = "It's seen better days.",
        QUAGMIRE_SWAMPIG_HOUSE_RUBBLE = "Some pig's house was ruined.",
        QUAGMIRE_SWAMPIGELDER =
        {
            GENERIC = "I guess you're in charge around here?",
            SLEEPING = "It's sleeping, for now.",
        },
        QUAGMIRE_SWAMPIG = "It's a super hairy pig.",

        QUAGMIRE_PORTAL = "Another dead end.",
        QUAGMIRE_SALTROCK = "Salt. The tastiest mineral.",
        QUAGMIRE_SALT = "It's full of salt.",
        --food--
        QUAGMIRE_FOOD_BURNT = "That one was an experiment.",
        QUAGMIRE_FOOD =
        {
        	GENERIC = "I should offer it on the Altar of Gnaw.",
            MISMATCH = "That's not what it wants.",
            MATCH = "Science says this will appease the sky God.",
            MATCH_BUT_SNACK = "It's more of a light snack, really.",
        },

        QUAGMIRE_FERN = "Probably chock full of vitamins.",
        QUAGMIRE_FOLIAGE_COOKED = "We cooked the foliage.",
        QUAGMIRE_COIN1 = "I'd like more than a penny for my thoughts.",
        QUAGMIRE_COIN2 = "A decent amount of coin.",
        QUAGMIRE_COIN3 = "Seems valuable.",
        QUAGMIRE_COIN4 = "We can use these to reopen the Gateway.",
        QUAGMIRE_GOATMILK = "Good if you don't think about where it came from.",
        QUAGMIRE_SYRUP = "Adds sweetness to the mixture.",
        QUAGMIRE_SAP_SPOILED = "Might as well toss it on the fire.",
        QUAGMIRE_SEEDPACKET = "Sow what?",

        QUAGMIRE_POT = "This pot holds more ingredients.",
        QUAGMIRE_POT_SMALL = "Let's get cooking!",
        QUAGMIRE_POT_SYRUP = "I need to sweeten this pot.",
        QUAGMIRE_POT_HANGER = "It has hang-ups.",
        QUAGMIRE_POT_HANGER_ITEM = "For suspension-based cookery.",
        QUAGMIRE_GRILL = "Now all I need is a backyard to put it in.",
        QUAGMIRE_GRILL_ITEM = "I'll have to grill someone about this.",
        QUAGMIRE_GRILL_SMALL = "Barbecurious.",
        QUAGMIRE_GRILL_SMALL_ITEM = "For grilling small meats.",
        QUAGMIRE_OVEN = "It needs ingredients to make the science work.",
        QUAGMIRE_OVEN_ITEM = "For scientifically burning things.",
        QUAGMIRE_CASSEROLEDISH = "A dish for all seasonings.",
        QUAGMIRE_CASSEROLEDISH_SMALL = "For making minuscule motleys.",
        QUAGMIRE_PLATE_SILVER = "A silver plated plate.",
        QUAGMIRE_BOWL_SILVER = "A bright bowl.",
        QUAGMIRE_CRATE = "Kitchen stuff.",

        QUAGMIRE_MERM_CART1 = "Got any spare parts?", --sammy's wagon
        QUAGMIRE_MERM_CART2 = "I could use some stuff.", --pipton's cart
        QUAGMIRE_PARK_ANGEL = "Take that, creature!",
        QUAGMIRE_PARK_ANGEL2 = "So lifelike.",
        QUAGMIRE_PARK_URN = "Ashes to ashes.",
        QUAGMIRE_PARK_OBELISK = "A monumental monument.",
        QUAGMIRE_PARK_GATE =
        {
            GENERIC = "I guess it needs a key.",
            LOCKED = "Locked...",
        },
        QUAGMIRE_PARKSPIKE = "The scientific term is: \"Sharp pointy thing\".",
        QUAGMIRE_CRABTRAP = "A crabby trap.",
        QUAGMIRE_TRADER_MERM = "Maybe they'd be willing to trade.",
        QUAGMIRE_TRADER_MERM2 = "Maybe they'd be willing to trade.",

        QUAGMIRE_GOATMUM = "Oh hey!",
        QUAGMIRE_GOATKID = "This goat's much smaller.",
        QUAGMIRE_PIGEON =
        {
            DEAD = "They're dead.",
            GENERIC = "He's just winging it.",
            SLEEPING = "It's sleeping, for now.",
        },
        QUAGMIRE_LAMP_POST = "Huh. Reminds me of home.",

        QUAGMIRE_BEEFALO = "Science says it should have died by now.",
        QUAGMIRE_SLAUGHTERTOOL = "Laboratory tools for surgical butchery.",

        QUAGMIRE_SAPLING = "I can't get anything else out of that.",
        QUAGMIRE_BERRYBUSH = "Those berries are all gone.",

        QUAGMIRE_ALTAR_STATUE2 = "What are you looking at?",
        QUAGMIRE_ALTAR_QUEEN = "A monumental monument.",
        QUAGMIRE_ALTAR_BOLLARD = "As far as posts go, this one is adequate.",
        QUAGMIRE_ALTAR_IVY = "Kind of clingy.",

        QUAGMIRE_LAMP_SHORT = "Enlightening.",

        --v2 Winona
        WINONA_CATAPULT =
        {
        	GENERIC = "She's made a sort of automatic defense system.",
        	OFF = "It needs some electricity.",
        	BURNING = "It's on fire!",
        	BURNT = "Science couldn't save it.",
        },
        WINONA_SPOTLIGHT =
        {
        	GENERIC = "What an ingenious idea!",
        	OFF = "It needs some electricity.",
        	BURNING = "It's on fire!",
        	BURNT = "Science couldn't save it.",
        },
        WINONA_BATTERY_LOW =
        {
        	GENERIC = "Looks science-y. How does it work?",
        	LOWPOWER = "It's getting low on power.",
        	OFF = "I could get it working, if Winona's busy.",
        	BURNING = "It's on fire!",
        	BURNT = "Science couldn't save it.",
        },
        WINONA_BATTERY_HIGH =
        {
        	GENERIC = "Hey! That's not science!",
        	LOWPOWER = "It'll turn off soon.",
        	OFF = "Science beats magic, every time.",
        	BURNING = "It's on fire!",
        	BURNT = "Science couldn't save it.",
        },

        --Wormwood
        COMPOSTWRAP = "Wormwood offered me a bite, but I respectfully declined.",
        ARMOR_BRAMBLE = "The best offense is a good defense.",
        TRAP_BRAMBLE = "It'd really poke whoever stepped on it.",

        BOATFRAGMENT03 = "Not much left of it.",
        BOATFRAGMENT04 = "Not much left of it.",
        BOATFRAGMENT05 = "Not much left of it.",
		BOAT_LEAK = "I should patch that up before it sinks.",
        MAST = "Should speed things up!",
        SEASTACK = "It's a rock.",
        FISHINGNET = "Nothing but net.", --unimplemented
        ANTCHOVIES = "Yeesh. Can I toss it back?", --unimplemented
        STEERINGWHEEL = "It's much harder to pilot than a starship.",
        ANCHOR = "Let's secure it, or it may drift away.",
        BOATPATCH = "Just in case of disaster.",
        DRIFTWOOD_TREE =
        {
            BURNING = "That driftwood's burning!",
            BURNT = "Doesn't look very useful anymore.",
            CHOPPED = "There might still be something worth digging up.",
            GENERIC = "A dead tree that washed up on shore.",
        },

        DRIFTWOOD_LOG = "It floats on water.",

        MOON_TREE =
        {
            BURNING = "The tree is burning!",
            BURNT = "The tree burned down.",
            CHOPPED = "That was a pretty thick tree.",
            GENERIC = "I didn't know trees grew on the moon.",
        },
		MOON_TREE_BLOSSOM = "It fell from the moon tree.",

        MOONBUTTERFLY =
        {
        	GENERIC = "Is that a shimmering moth?",
        	HELD = "I've got you now.",
        },
		MOONBUTTERFLYWINGS = "Do these also taste like butter or is it just butterflies?",
        MOONBUTTERFLY_SAPLING = "Annndddd I thought I've seen everything.",
        ROCK_AVOCADO_FRUIT = "I'd shatter my teeth on that.",
        ROCK_AVOCADO_FRUIT_RIPE = "Uncooked stone fruit is the pits.",
        ROCK_AVOCADO_FRUIT_RIPE_COOKED = "It's actually soft enough to eat now.",
        ROCK_AVOCADO_FRUIT_SPROUT = "It's growing.",
        ROCK_AVOCADO_BUSH =
        {
        	BARREN = "No fruit here.",
			WITHERED = "It's pretty hot out.",
			GENERIC = "It's a bush... from the moon!",
			PICKED = "It'll take awhile to grow more fruit.",
			DISEASED = "It looks pretty sick.", --unimplemented
            DISEASING = "Err, something's not right.", --unimplemented
			BURNING = "It's burning!",
		},
        DEAD_SEA_BONES = "Poor guy, I wonder what happened?",
        HOTSPRING =
        {
        	GENERIC = "Ohoho, that looks relaxing.",
        	BOMBED = "That's just right!",
        	GLASS = "Huh, is that normal?",
			EMPTY = "Awww, I'll have to water for it to fill up again.",
        },
        MOONGLASS = "It's very sharp.",
        MOONGLASS_CHARGED = "I should put this to scientific use before the energy fades!",
        MOONGLASS_ROCK = "I can practically see my reflection in it.",
        BATHBOMB = "It's just textbook chemistry.",
        TRAP_STARFISH =
        {
            GENERIC = "Note to self, if it looks harmless. It's probably going to bite you.",
            CLOSED = "I was right!",
        },
        DUG_TRAP_STARFISH = "It's not fooling anyone now.",
        SPIDER_MOON =
        {
        	GENERIC = "Okay something seriously is wrong with that moon!",
        	SLEEPING = "Okay whew, it's asleep.",
        	DEAD = "Is it really dead?",
        },
        MOONSPIDERDEN = "That's not a normal spider den.",
		FRUITDRAGON =
		{
			GENERIC = "It's cute, but it's not ripe yet.",
			RIPE = "I think it's ripe now.",
			SLEEPING = "It's snoozing.",
		},
        PUFFIN =
        {
            GENERIC = "They are pretty exotic!",
            HELD = "I caught it!",
            SLEEPING = "I admit, it is kinda cute when asleep.",
        },

		MOONGLASSAXE = "I've made it extra effective.",
		GLASSCUTTER = "Nice, now we're talking.",

        ICEBERG =
        {
            GENERIC = "Let's steer clear of that.", --unimplemented
            MELTED = "It's completely melted.", --unimplemented
        },
        ICEBERG_MELTED = "It's completely melted.", --unimplemented

        MINIFLARE = "I can light it to let everyone know I'm here.",
        MEGAFLARE = "It will let everything know I'm here. Everything.",

		MOON_FISSURE =
		{
			GENERIC = "I feel like I'm gently floating in my mind. I don't know is that's a good sign.",
			NOLIGHT = "The cracks in this place are starting to show.",
		},
        MOON_ALTAR =
        {
            MOON_ALTAR_WIP = "It wants to be finished.",
            GENERIC = "Hm? What did you say?",
        },

        MOON_ALTAR_IDOL = "I should rendezvous back to the rest and put it together.",
        MOON_ALTAR_GLASS = "It doesn't want to be on the ground.",
        MOON_ALTAR_SEED = "It wants me to give it a home.",

        MOON_ALTAR_ROCK_IDOL = "There's something trapped inside.",
        MOON_ALTAR_ROCK_GLASS = "There's something trapped inside.",
        MOON_ALTAR_ROCK_SEED = "There's something trapped inside.",

        MOON_ALTAR_CROWN = "I fished it up, now to find a fissure!",
        MOON_ALTAR_COSMIC = "It feels like it's waiting for something.",

        MOON_ALTAR_ASTRAL = "It seems to be part of a larger mechanism.",
        MOON_ALTAR_ICON = "I think I know just where you belong.",
        MOON_ALTAR_WARD = "It wants to be with the others.",

        SEAFARING_PROTOTYPER =
        {
            GENERIC = "Ahaha, yes! Now we're getting somewhere! If only I had the tools for a starship though.",
            BURNT = "Nonono! Aww it burnt down.",
        },
        BOAT_ITEM = "It would be nice to do some experiments on the water.",
        BOAT_GRASS_ITEM = "It's technically a boat.",
        STEERINGWHEEL_ITEM = "That's going to be the steering wheel.",
        ANCHOR_ITEM = "Now I can build an anchor.",
        MAST_ITEM = "Now I can build a mast.",
        MUTATEDHOUND =
        {
        	DEAD = "Alright, that's dead. Hopefully there aren't more...there's probably more.",
        	GENERIC = "Whoa whoa, not the tail!",
        	SLEEPING = "Good it's sleeping for now.",
        },

        MUTATED_PENGUIN =
        {
			DEAD = "That's the end of that...or is it.",
			GENERIC = "That's definately not normal!",
			SLEEPING = "Blarg...It's sleeping.",
		},
        CARRAT =
        {
        	DEAD = "That's the end of that.",
        	GENERIC = "Are carrots supposed to have legs?",
        	HELD = "You're kind of ugly up close.",
        	SLEEPING = "It's almost cute.",
        },

		BULLKELP_PLANT =
        {
            GENERIC = "Hey, look it's kelp.",
            PICKED = "Just going to take that.",
        },
		BULLKELP_ROOT = "I can plant it in deep water.",
        KELPHAT = "Sometimes you have to feel worse to feel better.",
		KELP = "It gets my pockets all wet and gross.",
		KELP_COOKED = "It's closer to a liquid than a solid.",
		KELP_DRIED = "Eh, I'm not too much a fan but I'll eat it.",

		GESTALT = "They're promising me... knowledge.",
        GESTALT_GUARD = "They're promising me... a good smack if I get too close.",

		COOKIECUTTER = "I don't like the way it's looking at my boat...",
		COOKIECUTTERSHELL = "That's what you deserve for messing with me.",
		COOKIECUTTERHAT = "At least my fur will stay dry.",
		SALTSTACK =
		{
			GENERIC = "Are those natural formations?",
			MINED_OUT = "Looks like it was all mined out!",
			GROWING = "I guess it just grows like that.",
		},
		SALTROCK = "It's way too salty.",
		SALTBOX = "Sweet! Better preservation!",

		TACKLESTATION = "Time to tackle my reel problems.",
		TACKLESKETCH = "A picture of some fishing tackle. I bet I could make this...",

        MALBATROSS = "That's a really big bird!",
        MALBATROSS_FEATHER = "Plucked from a fine feathered fiend.",
        MALBATROSS_BEAK = "Maybe sharp enough use as a weapon or even move the boat.",
        MAST_MALBATROSS_ITEM = "It's lighter than it looks.",
        MAST_MALBATROSS = "It's a much better quality mast!",
		MALBATROSS_FEATHERED_WEAVE = "I could use this to maybe improve the sail! It just needs a few tweaks.",

        GNARWAIL =
        {
            GENERIC = "I wouldn't want to be poked by them.",
            BROKENHORN = "Got your nose!",
            FOLLOWER = "This is all whale and good.",
            BROKENHORN_FOLLOWER = "That's what happens when you nose around!",
        },
        GNARWAIL_HORN = "Gnarly!",

        WALKINGPLANK = "Couldn't we have just made a lifeboat?",
        WALKINGPLANK_GRASS = "Couldn't we have just made a lifeboat?",
        OAR = "It's better than nothing.",
		OAR_DRIFTWOOD = "With just a few tweaks, a new and improved oar!",

		OCEANFISHINGROD = "Now we're ready to really fish!",
		OCEANFISHINGBOBBER_NONE = "A bobber might improve its accuracy.",
        OCEANFISHINGBOBBER_BALL = "The fish will have a ball with this.",
        OCEANFISHINGBOBBER_OVAL = "Those fish won't give me the slip this time!",
		OCEANFISHINGBOBBER_CROW = "I'd rather eat fish than crow.",
		OCEANFISHINGBOBBER_ROBIN = "Hopefully it won't attract any red herrings.",
		OCEANFISHINGBOBBER_ROBIN_WINTER = "The snowbird quill helps me stay frosty.",
		OCEANFISHINGBOBBER_CANARY = "Say y'ello to my little friend!",
		OCEANFISHINGBOBBER_GOOSE = "You're going down, fish!",
		OCEANFISHINGBOBBER_MALBATROSS = "Where there's a quill, there's a way.",

		OCEANFISHINGLURE_SPINNER_RED = "Some fish might find this a-luring!",
		OCEANFISHINGLURE_SPINNER_GREEN = "Some fish might find this a-luring!",
		OCEANFISHINGLURE_SPINNER_BLUE = "Some fish might find this a-luring!",
		OCEANFISHINGLURE_SPOON_RED = "Some smaller fish might find this a-luring!",
		OCEANFISHINGLURE_SPOON_GREEN = "Some smaller fish might find this a-luring!",
		OCEANFISHINGLURE_SPOON_BLUE = "Some smaller fish might find this a-luring!",
		OCEANFISHINGLURE_HERMIT_RAIN = "Soaking myself might help me think like a fish...",
		OCEANFISHINGLURE_HERMIT_SNOW = "The fish won't snow what hit them!",
		OCEANFISHINGLURE_HERMIT_DROWSY = "My brain is protected by a thick layer of hard science!",
		OCEANFISHINGLURE_HERMIT_HEAVY = "This feels a bit heavy handed.",

		OCEANFISH_SMALL_1 = "Looks like the runt of its school.",
		OCEANFISH_SMALL_2 = "I won't win any bragging rights with this one.",
		OCEANFISH_SMALL_3 = "It's a bit on the small side.",
		OCEANFISH_SMALL_4 = "A fish this size won't tide me over for long.",
		OCEANFISH_SMALL_5 = "I can't wait to pop it in my mouth.",
		OCEANFISH_SMALL_6 = "You have to sea it to beleaf it.",
		OCEANFISH_SMALL_7 = "I finally caught this bloomin' fish!",
		OCEANFISH_SMALL_8 = "It's a scorcher!",
        OCEANFISH_SMALL_9 = "Just spit-balling, but I might have a use for you...",

		OCEANFISH_MEDIUM_1 = "I certainly hope it tastes better than it looks.",
		OCEANFISH_MEDIUM_2 = "I went to a lot of treble to catch it.",
		OCEANFISH_MEDIUM_3 = "I wasn't lion about my aptitude for fishing!",
		OCEANFISH_MEDIUM_4 = "I'm sure this won't bring me any bad luck.",
		OCEANFISH_MEDIUM_5 = "This one seems kind of corny.",
		OCEANFISH_MEDIUM_6 = "Now that's the real McKoi!",
		OCEANFISH_MEDIUM_7 = "Now that's the real McKoi!",
		OCEANFISH_MEDIUM_8 = "Ice bream, youse bream.",
        OCEANFISH_MEDIUM_9 = "That's the sweet smell of a successful fishing trip.",

		PONDFISH = "Now I shall eat for a day.",
		PONDEEL = "This will make a delicious meal.",

        FISHMEAT = "A chunk of fish meat.",
        FISHMEAT_COOKED = "Grilled to perfection.",
        FISHMEAT_SMALL = "A small bit of fish.",
        FISHMEAT_SMALL_COOKED = "A small bit of cooked fish.",
		SPOILED_FISH = "I'm not terribly curious about the smell.",

		FISH_BOX = "They're stuffed in there like sardines!",
        POCKET_SCALE = "A scaled-down weighing device.",

		TACKLECONTAINER = "This extra storage space has me hooked!",
		SUPERTACKLECONTAINER = "I had to shell out quite a bit to get this.",

		TROPHYSCALE_FISH =
		{
			GENERIC = "I wonder how my catch of the day will measure up!",
			HAS_ITEM = "Weight: {weight}\nCaught by: {owner}",
			HAS_ITEM_HEAVY = "Weight: {weight}\nCaught by: {owner}\nWhat a catch!",
			BURNING = "On a scale of 1 to on fire... that's pretty on fire.",
			BURNT = "All my bragging rights, gone up in flames!",
			OWNER = "Not to throw my weight around, buuut...\nWeight: {weight}\nCaught by: {owner}",
			OWNER_HEAVY = "Weight: {weight}\nCaught by: {owner}\nIt's the one that DIDN'T get away!",
		},

		OCEANFISHABLEFLOTSAM = "Just some muddy grass.",

		CALIFORNIAROLL = "But I don't have chopsticks.",
		SEAFOODGUMBO = "It's a jumbo seafood gumbo.",
		SURFNTURF = "It's perf!",

        WOBSTER_SHELLER = "What a wascally Wobster.",
        WOBSTER_DEN = "It's a rock with Wobsters in it.",
        WOBSTER_SHELLER_DEAD = "You should cook up nicely.",
        WOBSTER_SHELLER_DEAD_COOKED = "I can't wait to eat you.",

        LOBSTERBISQUE = "Could use more salt, but that's none of my bisque-ness.",
        LOBSTERDINNER = "If I eat it in the morning is it still dinner?",

        WOBSTER_MOONGLASS = "What a wascally Lunar Wobster.",
        MOONGLASS_WOBSTER_DEN = "It's a chunk of moonglass with Lunar Wobsters in it.",

		TRIDENT = "This is going to be a blast!",

		WINCH =
		{
			GENERIC = "It'll do in a pinch.",
			RETRIEVING_ITEM = "I'll let it do the heavy lifting.",
			HOLDING_ITEM = "What do we have here?",
		},

        HERMITHOUSE = {
            GENERIC = "It's just an empty shell of a house.",
            BUILTUP = "It just needed a little love.",
        },

        SHELL_CLUSTER = "I bet there's some nice shells in there.",
        --
		SINGINGSHELL_OCTAVE3 =
		{
			GENERIC = "It's a bit more toned down.",
		},
		SINGINGSHELL_OCTAVE4 =
		{
			GENERIC = "Is that what the ocean sounds like?",
		},
		SINGINGSHELL_OCTAVE5 =
		{
			GENERIC = "It's ready for the high C's.",
        },

        CHUM = "It's a fish meal!",

        SUNKENCHEST =
        {
            GENERIC = "The real treasure is the treasure we found along the way.",
            LOCKED = "It's clammed right up!",
        },

        HERMIT_BUNDLE = "She shore shells out a lot of these.",
        HERMIT_BUNDLE_SHELLS = "She DOES sell sea shells!",

        RESKIN_TOOL = "I like the dust! It feels scholarly!",
        MOON_FISSURE_PLUGGED = "It's not very scientific... but pretty effective.",


		----------------------- ROT STRINGS GO ABOVE HERE ------------------

		-- Walter
        WOBYBIG =
        {
            "That's a big dog. Is that normal?",
            "That's a big dog. Is that normal?",
        },
        WOBYSMALL =
        {
            "Aww, hey little guy.",
            "Aww, hey little guy.",
        },
		WALTERHAT = "I was never exactly \"outdoorsy\" in my youth.",
		SLINGSHOT = "The bane of windows everywhere.",
		SLINGSHOTAMMO_ROCK = "Shots to be slinged.",
		SLINGSHOTAMMO_MARBLE = "Shots to be slinged.",
		SLINGSHOTAMMO_THULECITE = "Shots to be slinged.",
        SLINGSHOTAMMO_GOLD = "Shots to be slinged.",
        SLINGSHOTAMMO_SLOW = "Shots to be slinged.",
        SLINGSHOTAMMO_FREEZE = "Shots to be slinged.",
		SLINGSHOTAMMO_POOP = "Poop projectiles.",
        PORTABLETENT = "I feel like I haven't had a proper night's sleep in ages!",
        PORTABLETENT_ITEM = "This requires some a-tent-tion.",

        -- Wigfrid
        BATTLESONG_DURABILITY = "Theater makes me fidgety.",
        BATTLESONG_HEALTHGAIN = "Theater makes me fidgety.",
        BATTLESONG_SANITYGAIN = "Theater makes me fidgety.",
        BATTLESONG_SANITYAURA = "Theater makes me fidgety.",
        BATTLESONG_FIRERESISTANCE = "I once burned my vest before seeing a play. I call that dramatic ironing.",
        BATTLESONG_INSTANT_TAUNT = "I'm afraid I'm not a licensed poetic.",
        BATTLESONG_INSTANT_PANIC = "I'm afraid I'm not a licensed poetic.",

        -- Webber
        MUTATOR_WARRIOR = "Oh wow, that looks um... delicious, Webber!",
        MUTATOR_DROPPER = "Ah, I... just ate! Why don't you give it to one of your spider friends?",
        MUTATOR_HIDER = "Oh wow, that looks um... delicious, Webber!",
        MUTATOR_SPITTER = "Ah, I... just ate! Why don't you give it to one of your spider friends?",
        MUTATOR_MOON = "Oh wow, that looks um... delicious, Webber!",
        MUTATOR_HEALER = "Ah, I... just ate! Why don't you give it to one of your spider friends?",
        SPIDER_WHISTLE = "I don't want to call any spiders over to me!",
        SPIDERDEN_BEDAZZLER = "It looks like someone's been getting crafty.",
        SPIDER_HEALER = "Oh wonderful. Now the spiders can heal themselves.",
        SPIDER_REPELLENT = "If only I could make use of it.",
        SPIDER_HEALER_ITEM = "If I see any spiders around I'll be sure to give it to them. Maybe.",

		-- Wendy
		GHOSTLYELIXIR_SLOWREGEN = "Ah yes. Ghost.",
		GHOSTLYELIXIR_FASTREGEN = "Ah yes. Ghost.",
		GHOSTLYELIXIR_SHIELD = "Ah yes. Ghost.",
		GHOSTLYELIXIR_ATTACK = "Ah yes. Ghost.",
		GHOSTLYELIXIR_SPEED = "Ah yes. Ghost.",
		GHOSTLYELIXIR_RETALIATION = "Ah Ghost.",
		SISTURN =
		{
			GENERIC = "Some flowers would liven it up a bit.",
			SOME_FLOWERS = "A few more flowers should do the trick.",
			LOTS_OF_FLOWERS = "What a brilliant boo-quet!",
		},

        --Wortox
        WORTOX_SOUL = "only_used_by_wortox", --only wortox can inspect souls

        PORTABLECOOKPOT_ITEM =
        {
            GENERIC = "Now we're cookin'!",
            DONE = "Now we're done cookin'!",

			COOKING_LONG = "That meal is going to take a while.",
			COOKING_SHORT = "It'll be ready in no-time!",
			EMPTY = "I bet there's nothing in there.",
        },

        PORTABLEBLENDER_ITEM = "It mixes all the food.",
        PORTABLESPICER_ITEM =
        {
            GENERIC = "This will spice things up.",
            DONE = "Should make things a little tastier.",
        },
        SPICEPACK = "Finally seasoning!",
        SPICE_GARLIC = "A powerfully potent powder.",
        SPICE_SUGAR = "Sweet! It's sweet!",
        SPICE_CHILI = "A flagon of fiery fluid.",
        SPICE_SALT = "A little sodium's good for the heart.",
        MONSTERTARTARE = "There's got to be something else to eat around here.",
        FRESHFRUITCREPES = "Sugary fruit! Part of a balanced breakfast.",
        FROGFISHBOWL = "Is that just... frogs stuffed inside a fish?",
        POTATOTORNADO = "Potato, scientifically infused with the power of a tornado!",
        DRAGONCHILISALAD = "I hope I can handle the spice level.",
        GLOWBERRYMOUSSE = "Warly sure can cook.",
        VOLTGOATJELLY = "It's shockingly delicious.",
        NIGHTMAREPIE = "It's a little spooky.",
        BONESOUP = "No bones about it, Warly can cook.",
        MASHEDPOTATOES = "I've heard cooking is basically chemistry. I should try it.",
        POTATOSOUFFLE = "I forgot what good food tasted like.",
        MOQUECA = "He's as talented a chef as I am a scientist.",
        GAZPACHO = "How in science does it taste so good?",
        ASPARAGUSSOUP = "Smells like it tastes.",
        VEGSTINGER = "Can you use the celery as a straw?",
        BANANAPOP = "No, not brain freeze! I need that for science!",
        CEVICHE = "Can I get a bigger bowl? This one looks a little shrimpy.",
        SALSA = "So... hot...!",
        PEPPERPOPPER = "What a mouthful!",

        TURNIP = "It's a raw turnip.",
        TURNIP_COOKED = "Cooking is science in practice.",
        TURNIP_SEEDS = "A handful of odd seeds.",

        GARLIC = "The number one breath enhancer.",
        GARLIC_COOKED = "Perfectly browned.",
        GARLIC_SEEDS = "A handful of odd seeds.",

        ONION = "Do I really want to eat an onion raw?",
        ONION_COOKED = "Now that's better.",
        ONION_SEEDS = "A handful of odd seeds.",

        POTATO = "I wonder if I could make galaxyburger fries out of these.",
        POTATO_COOKED = "It needs butter and maybe some salt.",
        POTATO_SEEDS = "A handful of odd seeds.",

        TOMATO = "It's red because it's full of science.",
        TOMATO_COOKED = "Cooking's easy if you understand chemistry.",
        TOMATO_SEEDS = "A handful of odd seeds.",

        ASPARAGUS = "A vegetable.",
        ASPARAGUS_COOKED = "Science says it's good for me.",
        ASPARAGUS_SEEDS = "It's some seeds.",

        PEPPER = "Nice and spicy.",
        PEPPER_COOKED = "It was already hot to begin with.",
        PEPPER_SEEDS = "A handful of seeds.",

        WEREITEM_BEAVER = "I guess science works differently up North.",
        WEREITEM_GOOSE = "That thing's giving ME goosebumps!",
        WEREITEM_MOOSE = "A perfectly normal cursed moose thing.",

        MERMHAT = "Finally, I can show my face in public.",
        MERMTHRONE =
        {
            GENERIC = "Looks fit for a swamp king!",
            BURNT = "There was something fishy about that throne anyway.",
        },
        MERMTHRONE_CONSTRUCTION =
        {
            GENERIC = "Just what is she planning?",
            BURNT = "I suppose we'll never know what it was for now.",
        },
        MERMHOUSE_CRAFTED =
        {
            GENERIC = "It's actually kind of cute.",
            BURNT = "Ugh, the smell!",
        },

        MERMWATCHTOWER_REGULAR = "They seem happy to have found a king.",
        MERMWATCHTOWER_NOKING = "A royal guard with no Royal to guard.",
        MERMKING = "Your Majesty!",
        MERMGUARD = "I feel very guarded around these guys...",
        MERM_PRINCE = "They operate on a first-come, first-sovereigned basis.",

        SQUID = "Hopefully they don't get any bigger.",

		GHOSTFLOWER = "Wow that's eerie.",
        SMALLGHOST = "That's a tiny ghost, isn't it?",

        CRABKING =
        {
            GENERIC = "Yikes! A little too crabby for me.",
            INERT = "That castle needs a little decoration.",
        },
		CRABKING_CLAW = "That's claws for alarm!",

		MESSAGEBOTTLE = "I wonder if it's for me!",
		MESSAGEBOTTLEEMPTY = "It's full of nothing.",

        MEATRACK_HERMIT =
        {
            DONE = "Jerky time!",
            DRYING = "Meat takes a while to dry.",
            DRYINGINRAIN = "Meat takes even longer to dry in rain.",
            GENERIC = "Those look like they could use some meat.",
            BURNT = "The rack got dried.",
            DONE_NOTMEAT = "In laboratory terms, we would call that \"dry\".",
            DRYING_NOTMEAT = "Drying things is not an exact science.",
            DRYINGINRAIN_NOTMEAT = "Rain, rain, go away. Be wet again another day.",
        },
        BEEBOX_HERMIT =
        {
            READY = "It's full of honey.",
            FULLHONEY = "It's full of honey.",
            GENERIC = "I'm sure there's a little sweetness to be found inside.",
            NOHONEY = "It's empty.",
            SOMEHONEY = "Need to wait a bit.",
            BURNT = "How did it get burned?!!",
        },

        HERMITCRAB = "Oh, hello.",

        HERMIT_PEARL = "I'll take good care of it.",
        HERMIT_CRACKED_PEARL = "I... didn't take good care of it.",

        -- DSEAS
        WATERPLANT = "As long as we don't take their barnacles, they'll stay our buds.",
        WATERPLANT_BOMB = "We're under seedge!",
        WATERPLANT_BABY = "This one's just a sprout.",
        WATERPLANT_PLANTER = "They seem to grow best on oceanic rocks.",

        SHARK = "Oh no, not the sharkagator flashbacks...",

        MASTUPGRADE_LAMP_ITEM = "I just need to tighten the electrical coils, annnnnnd...ahaha it works!",
        MASTUPGRADE_LIGHTNINGROD_ITEM = "Okay with this we should be safe from any lightning strikes!",

        WATERPUMP = "Time to put out those fires.",

        BARNACLE = "I heard they're pests.",
        BARNACLE_COOKED = "I'm told it's quite a delicacy.",

        BARNACLEPITA = "Barnacles taste better when you can't see them.",
        BARNACLESUSHI = "I still seem to have misplaced my chopsticks.",
        BARNACLINGUINE = "Pass the pasta!",
        BARNACLESTUFFEDFISHHEAD = "I'm just hungry enough to consider it...",

        LEAFLOAF = "Mystery leaf meat.",
        LEAFYMEATBURGER = "Vegetarian, but not cruelty-free.",
        LEAFYMEATSOUFFLE = "Has science gone too far?",
        MEATYSALAD = "Strangely filling, for a salad.",

        -- GROTTO

		MOLEBAT = "Ack, they're after my food.",
        MOLEBATHILL = "I wonder what might be stuck in that rat's nest.",

        BATNOSE = "That's really on the nose",
        BATNOSE_COOKED = "It came out smelling like a nose.",
        BATNOSEHAT = "It's not weird at this point to place food on your head.",

        MUSHGNOME = "It might be aggressive, but only sporeradically.",

        SPORE_MOON = "I'll keep as mushroom between me and those spores as I can.",

        MOON_CAP = "It doesn't look particularly appetizing.",
        MOON_CAP_COOKED = "The things I do in the name of science...",

        MUSHTREE_MOON = "This mushroom tree is clearly stranger than the rest.",

        LIGHTFLIER = "How strange, carrying one makes my pocket feel lighter!",

        GROTTO_POOL_BIG = "The moon water makes the glass grow. That's just science.",
        GROTTO_POOL_SMALL = "The moon water makes the glass grow. That's just science.",

        DUSTMOTH = "Tidy little guys, aren't they?",

        DUSTMOTHDEN = "They're sleeping in there.",

        ARCHIVE_LOCKBOX = "Hmmm, there must be some kind of mechanism to unlock it",
        ARCHIVE_CENTIPEDE = "I think you have a couple of loose sprockets!",
        ARCHIVE_CENTIPEDE_HUSK = "A pile of old spare parts.",

        ARCHIVE_COOKPOT =
        {
            COOKING_LONG = "This is going to take a while.",
            COOKING_SHORT = "It's almost done!",
            DONE = "Mmmmm! It's ready to eat!",
            EMPTY = "Let's dust off this old crockery, shall we?",
            BURNT = "The pot got cooked.",
        },

        ARCHIVE_MOON_STATUE = "These magnificent moon statues have me waxing poetic.",
        ARCHIVE_RUNE_STATUE =
        {
            LINE_1 = "I can't make out what it says.",
            LINE_2 = "These markings look different from the ones in the rest of the ruins.",
            LINE_3 = "I can't make out what it says.",
            LINE_4 = "These markings look different from the ones in the rest of the ruins.",
            LINE_5 = "I can't make out what it says.",
        },

        ARCHIVE_RESONATOR = {
            GENERIC = "Right up my alley!",
            IDLE = "It seems to have found everything worth finding.",
        },

        ARCHIVE_RESONATOR_ITEM = "Aha! I used the secret knowledge to build a device! Why does this feel familiar...",

        ARCHIVE_LOCKBOX_DISPENCER = {
          POWEROFF = "Maybe if I reverse the polarity and...nah there must be some other way.",
          GENERIC =  "I have the strongest urge to stand around it and talk about nothing in particular.",
        },

        ARCHIVE_SECURITY_DESK = {
            POWEROFF = "Looks like it's none functional. Maybe I can find a way to power it back online.",
            GENERIC = "It looks inviting.",
        },

        ARCHIVE_SECURITY_PULSE = "Where are you going? Someplace interesting?",

        ARCHIVE_SWITCH = {
            VALID = "Looks like those gems are it's power source. Maybe I can find more.",
            GEMS = "The socket is empty.",
        },

        ARCHIVE_PORTAL = {
            POWEROFF = "Aww, it's dead.",
            GENERIC = "Strange, the power is on but this isn't.",
        },

        WALL_STONE_2 = "That's a nice wall.",
        WALL_RUINS_2 = "An ancient piece of wall.",

        REFINED_DUST = "Ah-CHOO!",
        DUSTMERINGUE = "Who or what would eat this?",

        SHROOMCAKE = "It lives up to its name.",

        NIGHTMAREGROWTH = "Those crystals might be cause for some concern.",

        TURFCRAFTINGSTATION = "This will tidy up out camp!",

        MOON_ALTAR_LINK = "It must be building up to something.",

        -- FARMING
        COMPOSTINGBIN =
        {
            GENERIC = "Yuck, .",
            WET = "That looks too soggy.",
            DRY = "Hm... too dry.",
            BALANCED = "Just right!",
            BURNT = "I didn't think it could smell any worse...",
        },
        COMPOST = "Food for plants, and not much else.",
        SOIL_AMENDER =
		{
			GENERIC = "Now we wait for science to do its work.",
			STALE = "It's creating what we scientists call a chemical reaction!",
			SPOILED = "That stomach-churning smell means it's working!",
		},

		SOIL_AMENDER_FERMENTED = "That's some strong science!",

        WATERINGCAN =
        {
            GENERIC = "I can water the plants with this.",
            EMPTY = "Maybe there's a pond around here somewhere...",
        },
        PREMIUMWATERINGCAN =
        {
            GENERIC = "It's been improved with science... and bird parts!",
            EMPTY = "It won't do me much good without water.",
        },

		FARM_PLOW = "A convenient plot device.",
		FARM_PLOW_ITEM = "I'd better find a good spot for my garden before I use it.",
		FARM_HOE = "I have to make the ground more comfortable for the seeds.",
		GOLDEN_FARM_HOE = "Do I really need something this fancy to move dirt around?",
		NUTRIENTSGOGGLESHAT = "This should keep the dirt from my eyes.",
		PLANTREGISTRYHAT = "I admit, I really don't know what I'm doing.",

        FARM_SOIL_DEBRIS = "It's making a mess of my garden.",

		FIRENETTLES = "That burns and stings. Hot, hot, hot!",
		FORGETMELOTS = "Hm. I can't remember what I was going to say about those.",
		SWEETTEA = "A nice cup of tea to forget all my problems.",
		TILLWEED = "Oh no, it's ruining the garden!",
		TILLWEEDSALVE = "At least there's a use for them.",
        WEED_IVY = "Hey, you're not a vegetable!",
        IVY_SNARE = "Now that's just rude.",

		TROPHYSCALE_OVERSIZEDVEGGIES =
		{
			GENERIC = "I bet I could impress Clank with this, or disappoint him.",
			HAS_ITEM = "Weight: {weight}\nHarvested on day: {day}\nNot bad.",
			HAS_ITEM_HEAVY = "Weight: {weight}\nHarvested on day: {day}\nWho knew they grew that big?",
            HAS_ITEM_LIGHT = "It's so average the scale isn't even bothering to tell me its weight.",
			BURNING = "Mmm, what's cooking?",
			BURNT = "I suppose that wasn't the best way to cook it.",
        },

        CARROT_OVERSIZED = "That's one big bunch of carrots!",
        CORN_OVERSIZED = "Wow, imagine all the popcorn I could make!",
        PUMPKIN_OVERSIZED = "A rather pumped up pumpkin.",
        EGGPLANT_OVERSIZED = "I still don't see any resemblance to an egg.",
        DURIAN_OVERSIZED = "Argh, now my nose and eyes are burning. It stinks.",
        POMEGRANATE_OVERSIZED = "That might be the biggest pomegranate I've ever seen.",
        DRAGONFRUIT_OVERSIZED = "I half expect it to sprout wings.",
        WATERMELON_OVERSIZED = "A big, juicy watermelon.",
        TOMATO_OVERSIZED = "A tomato of incredible proportions.",
        POTATO_OVERSIZED = "Now I wonder if I could make a whole batch of galaxyburger fries!",
        ASPARAGUS_OVERSIZED = "I guess we'll be eating asparagus for a while...",
        ONION_OVERSIZED = "They grow up so fast! It's... it's bringing a tear to my eye.",
        GARLIC_OVERSIZED = "A gargantuan garlic!",
        PEPPER_OVERSIZED = "A pepper of rather unusual size.",

        VEGGIE_OVERSIZED_ROTTEN = "What rotten luck.",

		FARM_PLANT =
		{
			GENERIC = "That's a plant!",
			SEED = "And now, we wait.",
			GROWING = "Oh hey, it's growing!",
			FULL = "It's fully grown, haha!",
			ROTTEN = "I think I left it there too long. That's a shame.",
			FULL_OVERSIZED = "Wow, that's huge! I bet Clank would be impressed!",
			ROTTEN_OVERSIZED = "Argh, why'd I wait too long.",
			FULL_WEED = "Oh no, not the weeds. Get out of here!",

			BURNING = "That can't be good for the plants...",
		},

        FRUITFLY = "Buzz off!",
        LORDFRUITFLY = "Hey, stop upsetting the plants!",
        FRIENDLYFRUITFLY = "The garden seems happier with it around.",
        FRUITFLYFRUIT = "Now I'm in charge!",

        SEEDPOUCH = "I was getting tired of carrying loose seeds in my pockets.",

		-- Crow Carnival
		CARNIVAL_HOST = "Maybe if I ask him, I could finally check out the games.",
		CARNIVAL_CROWKID = "Hey there.",
		CARNIVAL_GAMETOKEN = "One shiny token.",
		CARNIVAL_PRIZETICKET =
		{
			GENERIC = "Hey a ticket! I should check out the rest of the games for more.",
			GENERIC_SMALLSTACK = "Wow look at these tickets!",
			GENERIC_LARGESTACK = "Whoohoo, that's a lot of tickets!",
		},

		CARNIVALGAME_FEEDCHICKS_NEST = "It's a little trapdoor.",
		CARNIVALGAME_FEEDCHICKS_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "This looks like fun!",
		},
		CARNIVALGAME_FEEDCHICKS_KIT = "This really is a pop-up carnival.",
		CARNIVALGAME_FEEDCHICKS_FOOD = "I don't need to chew them up first, do I?",

		CARNIVALGAME_MEMORY_KIT = "This really is a pop-up carnival.",
		CARNIVALGAME_MEMORY_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "Not to brag, but I've been called a bit of an egghead in the past.",
		},
		CARNIVALGAME_MEMORY_CARD =
		{
			GENERIC = "It's a little trapdoor.",
			PLAYING = "Is this the right one?",
		},

		CARNIVALGAME_HERDING_KIT = "This really is a pop-up carnival.",
		CARNIVALGAME_HERDING_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "Those eggs are looking a little runny.",
		},
		CARNIVALGAME_HERDING_CHICK = "Come back here!",

		CARNIVALGAME_SHOOTING_KIT = "This really is a pop-up carnival.",
		CARNIVALGAME_SHOOTING_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "I could calculate the trajectory, but it involves a lot of complicated numbers and squiggles.",
		},
		CARNIVALGAME_SHOOTING_TARGET =
		{
			GENERIC = "It's a little trapdoor.",
			PLAYING = "That target's really starting to bug me.",
		},

		CARNIVALGAME_SHOOTING_BUTTON =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "Science compels me to press that big shiny button!",
		},

		CARNIVALGAME_WHEELSPIN_KIT = "This really is a pop-up carnival.",
		CARNIVALGAME_WHEELSPIN_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "It turns out that spinning your wheels is actually very productive.",
		},

		CARNIVALGAME_PUCKDROP_KIT = "This really is a pop-up carnival.",
		CARNIVALGAME_PUCKDROP_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "Physics don't always work the same way twice.",
		},

		CARNIVAL_PRIZEBOOTH_KIT = "The real prize is the booth we made along the way.",
		CARNIVAL_PRIZEBOOTH =
		{
			GENERIC = "I've got my eyes on the prize. That one, over there!",
		},

		CARNIVALCANNON_KIT = "I've got a lot of experience in making things explode.",
		CARNIVALCANNON =
		{
			GENERIC = "This experiment blows up on purpose!",
			COOLDOWN = "What a blast!",
		},

		CARNIVAL_PLAZA_KIT = "It's a scientifically proven fact that birds love trees.",
		CARNIVAL_PLAZA =
		{
			GENERIC = "It doesn't really scream \"Cawnival\" yet, does it?",
			LEVEL_2 = "A little birdy told me it could use some more decorations around here.",
			LEVEL_3 = "This tree is caws for celebration!",
		},

		CARNIVALDECOR_EGGRIDE_KIT = "I hope this prize is all it's cracked up to be.",
		CARNIVALDECOR_EGGRIDE = "I could watch it for hours.",

		CARNIVALDECOR_LAMP_KIT = "Only some light work left to do.",
		CARNIVALDECOR_LAMP = "It's powered by whimsy.",
		CARNIVALDECOR_PLANT_KIT = "Maybe it's a boxwood?",
		CARNIVALDECOR_PLANT = "Either it's small, or I'm gigantic.",
		CARNIVALDECOR_BANNER_KIT = "I have to build it myself? I should have known there'd be a catch.",
		CARNIVALDECOR_BANNER = "I think all these shiny decorations reflect well on me.",

		CARNIVALDECOR_FIGURE =
		{
			RARE = "See? Proof that trying the exact same thing over and over will eventually lead to success!",
			UNCOMMON = "You don't see this kind of design too often.",
			GENERIC = "I seem to be getting a lot of these...",
		},
		CARNIVALDECOR_FIGURE_KIT = "The thrill of discovery!",
		CARNIVALDECOR_FIGURE_KIT_SEASON2 = "The thrill of discovery!",

        CARNIVAL_BALL = "It's genius in its simplicity.", --unimplemented
		CARNIVAL_SEEDPACKET = "I was feeling a bit peckish.",
		CARNIVALFOOD_CORNTEA = "Is this drink supposed to be crunchy?",

        CARNIVAL_VEST_A = "I think it makes me look adventurous.",
        CARNIVAL_VEST_B = "It's like wearing my own shade tree.",
        CARNIVAL_VEST_C = "I hope there's no bugs in it...",

        -- YOTB
        YOTB_SEWINGMACHINE = "Sewing can't be that hard... can it?",
        YOTB_SEWINGMACHINE_ITEM = "There looks to be a bit of assembly required.",
        YOTB_STAGE = "Strange, I never see him enter or leave...",
        YOTB_POST =  "This contest is going to go off without a hitch! Well, figuratively speaking.",
        YOTB_STAGE_ITEM = "It looks like a bit of building is in order.",
        YOTB_POST_ITEM =  "I'd better get that set up.",


        YOTB_PATTERN_FRAGMENT_1 = "If I put some of these together, I bet I could make a beefalo costume.",
        YOTB_PATTERN_FRAGMENT_2 = "If I put some of these together, I bet I could make a beefalo costume.",
        YOTB_PATTERN_FRAGMENT_3 = "If I put some of these together, I bet I could make a beefalo costume.",

        YOTB_BEEFALO_DOLL_WAR = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },
        YOTB_BEEFALO_DOLL_DOLL = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },
        YOTB_BEEFALO_DOLL_FESTIVE = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },
        YOTB_BEEFALO_DOLL_NATURE = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },
        YOTB_BEEFALO_DOLL_ROBOT = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },
        YOTB_BEEFALO_DOLL_ICE = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },
        YOTB_BEEFALO_DOLL_FORMAL = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },
        YOTB_BEEFALO_DOLL_VICTORIAN = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },
        YOTB_BEEFALO_DOLL_BEAST = {
            GENERIC = "Scientifically formulated for maximum huggableness.",
            YOTB = "I wonder what the Judge would say about this?",
        },

        WAR_BLUEPRINT = "How ferocious!",
        DOLL_BLUEPRINT = "My beefalo will look as cute as a button!",
        FESTIVE_BLUEPRINT = "This is just the occasion for some festivity!",
        ROBOT_BLUEPRINT = "This requires a suspicious amount of welding for a sewing project.",
        NATURE_BLUEPRINT = "You really can't go wrong with flowers.",
        FORMAL_BLUEPRINT = "This is a costume for some Grade A beefalo.",
        VICTORIAN_BLUEPRINT = "I think my grandmother wore something similar.",
        ICE_BLUEPRINT = "I usually like my beefalo fresh, not frozen.",
        BEAST_BLUEPRINT = "I'm feeling lucky about this one!",

        BEEF_BELL = "It makes beefalo friendly. I'm sure there's a very scientific explanation.",

		-- YOT Catcoon
		KITCOONDEN =
		{
			GENERIC = "You'd have to be pretty small to fit in there.",
            BURNT = "NOOOO!",
			PLAYING_HIDEANDSEEK = "Now where could they be...",
			PLAYING_HIDEANDSEEK_TIME_ALMOST_UP = "Not much time left! Where are they?!",
		},

		KITCOONDEN_KIT = "The whole kit and caboodle.",

		TICOON =
		{
			GENERIC = "He looks like he knows what he's doing!",
			ABANDONED = "I'm sure I can find them on my own.",
			SUCCESS = "Hey, he found one!",
			LOST_TRACK = "Someone else found them first.",
			NEARBY = "Looks like there's something nearby.",
			TRACKING = "I should follow his lead.",
			TRACKING_NOT_MINE = "He's leading the way for someone else.",
			NOTHING_TO_TRACK = "It doesn't look like there's anything left to find.",
			TARGET_TOO_FAR_AWAY = "They might be too far away for him to sniff out.",
		},

		YOT_CATCOONSHRINE =
        {
            GENERIC = "What to make...",
            EMPTY = "Maybe it would like a feather to play with...",
            BURNT = "Smells like scorched fur.",
        },

		KITCOON_FOREST = "Aren't you the cutest little cat thing!",
		KITCOON_SAVANNA = "Aren't you the cutest little cat thing!",
		KITCOON_MARSH = "I must collect more... for research!",
		KITCOON_DECIDUOUS = "Aren't you the cutest little cat thing!",
		KITCOON_GRASS = "Aren't you the cutest little cat thing!",
		KITCOON_ROCKY = "I must collect more... for research!",
		KITCOON_DESERT = "I must collect more... for research!",
		KITCOON_MOON = "I must collect more... for research!",
		KITCOON_YOT = "I must collect more... for research!",

        -- Moon Storm
        ALTERGUARDIAN_PHASE1 = {
            GENERIC = "You want to fight? Let's fight then!",
            DEAD = "Gotcha!",
        },
        ALTERGUARDIAN_PHASE2 = {
            GENERIC = "Uh oh, I think it just got angrier!",
            DEAD = "Pl...please let that be the end of it.",
        },
        ALTERGUARDIAN_PHASE2SPIKE = "You've made your point!",
        ALTERGUARDIAN_PHASE3 = "It's definitely angry now!",
        ALTERGUARDIAN_PHASE3TRAP = "So tired...",
        ALTERGUARDIAN_PHASE3DEADORB = "Is it dead? That strange energy still seems to be lingering around it.",
        ALTERGUARDIAN_PHASE3DEAD = "whew...I hope it stays down.",

        ALTERGUARDIANHAT = "It shows me infinite possibilities...",
        ALTERGUARDIANHATSHARD = "Even a single piece is pretty illuminating!",

        MOONSTORM_GLASS = {
            GENERIC = "It's glassy.",
            INFUSED = "It's glowing with unearthly energy."
        },

        MOONSTORM_STATIC = "A new discovery, how electrifying!",
        MOONSTORM_STATIC_ITEM = "It makes my hair do crazy things.",
        MOONSTORM_SPARK = "I think I'll call it the \"Higgsbury Particle.\"",

        BIRD_MUTANT = "That can't be good. I don't think it's supposed to look like that.",
        BIRD_MUTANT_SPITTER = "I don't like the way it's looking at me...",

        WAGSTAFF_NPC = "I have to help. Maybe he knows a way back home!",

        WAGSTAFF_NPC_MUTATIONS = "That's not good!",
        WAGSTAFF_NPC_WAGPUNK = "I wonder where he's off to...",

        ALTERGUARDIAN_CONTAINED = "It's draining the energy right out of that monster!",

        WAGSTAFF_TOOL_1 = "That has to be the tool I'm looking for!",
        WAGSTAFF_TOOL_2 = "Of course I know what it is! It's just, er... too complicated to explain.",
        WAGSTAFF_TOOL_3 = "Clearly a very scientific tool!",
        WAGSTAFF_TOOL_4 = "My scientific instincts tell me that this is the tool I'm looking for!",
        WAGSTAFF_TOOL_5 = "I know exactly what it does! Science!",

        MOONSTORM_GOGGLESHAT = "Of course! Combining moon energy with potato energy, why didn't I think of that?",

        MOON_DEVICE = {
            GENERIC = "It's containing the energy! I knew what it was for all along, of course.",
            CONSTRUCTION1 = "The science has only just started.",
            CONSTRUCTION2 = "That's looking much more science-y already!",
        },

		-- Wanda
        POCKETWATCH_HEAL = {
			GENERIC = "Could it may be a way out of here?.",
			RECHARGING = "This is more of Clank's kind of deal.",
		},

        POCKETWATCH_REVIVE = {
			GENERIC = "Could it may be a way out of here?",
			RECHARGING = "This is more of Clank's kind of deal.",
		},

        POCKETWATCH_WARP = {
			GENERIC = "Could it may be a way out of here?.",
			RECHARGING = "This is more of Clank's kind of deal.",
		},

        POCKETWATCH_RECALL = {
			GENERIC = "Could it may be a way out of here?",
			RECHARGING = "This is more of Clank's kind of deal.",
			UNMARKED = "only_used_by_wanda",
			MARKED_SAMESHARD = "only_used_by_wanda",
			MARKED_DIFFERENTSHARD = "only_used_by_wanda",
		},

        POCKETWATCH_PORTAL = {
			GENERIC = "Could it may be a way out of here?",
			RECHARGING = "This is more of Clank's kind of deal.",
			UNMARKED = "only_used_by_wanda unmarked",
			MARKED_SAMESHARD = "only_used_by_wanda same shard",
			MARKED_DIFFERENTSHARD = "only_used_by_wanda other shard",
		},

        POCKETWATCH_WEAPON = {
			GENERIC = "I don't specialize in this kind of stuff. Clank on the otherhand would love to take a look at this.",
			DEPLETED = "only_used_by_wanda",
		},

        POCKETWATCH_PARTS = "Wait a minute, this is starting to look more like magic than science!",
        POCKETWATCH_DISMANTLER = "I wonder if she got them second hand.",

        POCKETWATCH_PORTAL_ENTRANCE =
		{
			GENERIC = "Onward, to discovery!",
			DIFFERENTSHARD = "Onward, to discovery!",
		},
        POCKETWATCH_PORTAL_EXIT = "It's a long drop down.",

        -- Waterlog
        WATERTREE_PILLAR = "Wow, these trees are huge. Reminds me of sargasso or florana!",
        OCEANTREE = "I think these trees are a little lost.",
        OCEANTREENUT = "There's something alive inside.",
        WATERTREE_ROOT = "Look at the roots on these trees.",

        OCEANTREE_PILLAR = "It's not quite as great as the original, but still pretty good.",

        OCEANVINE = "The scientific term is \"tree noodles\".",
        FIG = "I'll call it \"Newton's Fig\".",
        FIG_COOKED = "It's been warmed by science.",

        SPIDER_WATER = "Why in the name of science do they get to float?",
        MUTATOR_WATER = "Oh wow, that looks um... delicious, Webber!",
        OCEANVINE_COCOON = "What if I just gave it a little poke?",
        OCEANVINE_COCOON_BURNT = "I smell burnt toast.",

        GRASSGATOR = "I don't think he likes me very much.",

        TREEGROWTHSOLUTION = "Mmmm, tree food!",

        FIGATONI = "Mama mia!",
        FIGKABAB = "Fig with a side of stick.",
        KOALEFIG_TRUNK = "Great, now I've got a stuffed nose.",
        FROGNEWTON = "The fig really brings it all together.",

        -- The Terrorarium
        TERRARIUM = {
            GENERIC = "Looking at it makes my head feel fuzzy... or... blocky?",
            CRIMSON = "I have a nasty feeling about this...",
            ENABLED = "Am I on the other side of the rainbow?!",
			WAITING_FOR_DARK = "What could it be? Maybe I'll sleep on it.",
			COOLDOWN = "It needs to cool down after that.",
			SPAWN_DISABLED = "I shouldn't be bothered by anymore prying eyes now.",
        },

        -- Wolfgang
        MIGHTY_GYM =
        {
            GENERIC = "I think I'll leave this stuff to Qwark or Helga.",
            BURNT = "I don't think I'll be missing it.",
        },

        DUMBBELL = "I usually let my mind do all the heavy lifting.",
        DUMBBELL_GOLDEN = "It's worth its weight in gold.",
		DUMBBELL_MARBLE = "I've trained my brain to be the strongest muscle in my body.",
        DUMBBELL_GEM = "I'll conquer this weight with the power of-- ACK! My spine!!",
        POTATOSACK = "It's either filled with potato-shaped rocks or rock-shaped potatoes.",

        DUMBBELL_HEAT = "It's good for a warm-up.",
        DUMBBELL_REDGEM = "It'll really make you feel the burn.",
        DUMBBELL_BLUEGEM = "You can't get much cooler than that.",

        TERRARIUMCHEST =
		{
			GENERIC = "What harm ever came from peeking inside a box?",
			BURNT = "It won't be bothering anyone anymore.",
			SHIMMER = "That seems a bit out of place...",
		},

		EYEMASKHAT = "You could say I have an eye for style.",

        EYEOFTERROR = "Go for the eye!",
        EYEOFTERROR_MINI = "I'm starting to feel self-conscious.",
        EYEOFTERROR_MINI_GROUNDED = "I think it's about to hatch...",

        FROZENBANANADAIQUIRI = "Yellow and mellow.",
        BUNNYSTEW = "This one's luck has run out.",
        MILKYWHITES = "...Ew.",

        CRITTER_EYEOFTERROR = "Always good to have another set of eyes! Er... eye.",

        SHIELDOFTERROR ="The best defense is a good mawfence.",
        TWINOFTERROR1 = "Maybe they're friendly? ...Maybe not.",
        TWINOFTERROR2 = "Maybe they're friendly? ...Maybe not.",

		-- Cult of the Lamb
		COTL_TRINKET = "What a crowning achievement.",
		TURF_COTL_GOLD = "Don't walk on that, it was expensive!",
		TURF_COTL_BRICK = "Bricks are the building blocks of the floor.",
		COTL_TABERNACLE_LEVEL1 =
		{
			LIT = "What a soothing light.",
			GENERIC = "It needs some fuel.",
		},
		COTL_TABERNACLE_LEVEL2 =
		{
			LIT = "What an inspirational figure!",
			GENERIC = "It needs some fuel.",
		},
		COTL_TABERNACLE_LEVEL3 =
		{
			LIT = "I could stare at it forever... and ever...",
			GENERIC = "It needs some fuel.",
		},

        -- Year of the Catcoon
        CATTOY_MOUSE = "Mice with wheels, what will science think up next?",
        KITCOON_NAMETAG = "I should think of some names! Let's see, Wilson Jr., Wilson Jr. 2...",

		KITCOONDECOR1 =
        {
            GENERIC = "It's not a real bird, but the kits don't know that.",
            BURNT = "Combustion!",
        },
		KITCOONDECOR2 =
        {
            GENERIC = "Those kits are so easily distracted. Now what was I doing again?",
            BURNT = "It went up in flames.",
        },

		KITCOONDECOR1_KIT = "It looks like there's some assembly required.",
		KITCOONDECOR2_KIT = "It doesn't look too hard to build.",

        -- WX78
        WX78MODULE_MAXHEALTH = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_MAXSANITY1 = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_MAXSANITY = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_MOVESPEED = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_MOVESPEED2 = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_HEAT = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_NIGHTVISION = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_COLD = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_TASER = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_LIGHT = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_MAXHUNGER1 = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_MAXHUNGER = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_MUSIC = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_BEE = "If I have anytime, I'll love to examine these components.",
        WX78MODULE_MAXHEALTH2 = "If I have anytime, I'll love to examine these components.",

        WX78_SCANNER =
        {
            GENERIC ="WX-78 really puts a piece of themselves into their work.",
            HUNTING = "Get that data!",
            SCANNING = "Seems like it's found something.",
        },

        WX78_SCANNER_ITEM = "I wonder if it dreams about scanning sheep.",
        WX78_SCANNER_SUCCEEDED = "It's got the look of someone eager to show their work.",

        WX78_MODULEREMOVER = "Obviously a very delicate and complicated scientific instrument.",

        SCANDATA = "Smells like fresh research.",

		-- QOL 2022
		JUSTEGGS = "It could use some bacon.",
		VEGGIEOMLET = "Breakfast is the most scientific meal of the day.",
		TALLEGGS = "A breakthrough in breakfast technology!",
		BEEFALOFEED = "None for me, thank you.",
		BEEFALOTREAT = "A bit too grainy for my taste.",

        -- Pirates
        BOAT_ROTATOR = "Things are going in the right direction. Or maybe the left.",
        BOAT_ROTATOR_KIT = "I think I'll take it out for a spin.",
        BOAT_BUMPER_KELP = "At this point anything works.",
        BOAT_BUMPER_KELP_KIT = "A soon-to-be boat bumper.",
		BOAT_BUMPER_SHELL = "It gives the boat a little shellf defense.",
        BOAT_BUMPER_SHELL_KIT = "A soon-to-be boat bumper.",
        BOAT_CANNON = {
            GENERIC = "I should load it with something.",
            AMMOLOADED = "The cannon is ready to fire!",
            NOAMMO = "I didn't forget the cannonballs, I'm just letting the anticipation build.",
        },
        BOAT_CANNON_KIT = "It's not a cannon yet, but it will be.",
        CANNONBALL_ROCK_ITEM = "This will fit into a cannon perfectly.",

        OCEAN_TRAWLER = {
            GENERIC = "I could catch more fish with this.",
            LOWERED = "And now we wait.",
            CAUGHT = "It caught something!",
            ESCAPED = "Looks like something was caught, but it escaped...",
            FIXED = "All ready to catch fish again!",
        },
        OCEAN_TRAWLER_KIT = "I should put it somewhere with lots of fish.",

        BOAT_MAGNET =
        {
            GENERIC = "I'm always drawn to physics, like a... ah, can't think of the word.",
            ACTIVATED = "It's working!! Er, I knew it would work, of course.",
        },
        BOAT_MAGNET_KIT = "One of my more genius ideas, if I do say so myself.",

        BOAT_MAGNET_BEACON =
        {
            GENERIC = "This will attract any strong magnets nearby.",
            ACTIVATED = "Magnetism!",
        },
        DOCK_KIT = "Everything I need to build a dock for my boat.",
        DOCK_WOODPOSTS_ITEM = "Aha! I thought the dock was missing something.",

        MONKEYHUT =
        {
            GENERIC = "Treehouses are terribly flammable places to conduct experiments.",
            BURNT = "Like I said!",
        },
        POWDER_MONKEY = "Don't you dare monkey around with my boat!",
        PRIME_MATE = "A nice hat is always a clear indicator of who's in charge.",
		LIGHTCRAB = "It's bioluminous!",
        CUTLESS = "What it lacks in slicing it makes up for in splinters.",
        CURSED_MONKEY_TOKEN = "It seems harmless.",
        OAR_MONKEY = "It really puts the paddle to the battle.",
        BANANABUSH = "That bush is bananas!",
        DUG_BANANABUSH = "That bush is bananas!",
        PALMCONETREE = "Kind of piney, for a palm tree.",
        PALMCONE_SEED = "The very beginnings of a tree.",
        PALMCONE_SAPLING = "It has big dreams of being a tree one day.",
        PALMCONE_SCALE = "If trees had toenails, I imagine they'd look like this.",
        MONKEYTAIL = "I wonder if they're edible? Maybe an experiment is in order.",
        DUG_MONKEYTAIL = "I wonder if they're edible? Maybe an experiment is in order.",

        MONKEY_MEDIUMHAT = "I think it makes me look very dashing and captain-like.",
        MONKEY_SMALLHAT = "At least it will keep my hair dry.",
        POLLY_ROGERSHAT = "A little bird told me it will come in handy.",
        POLLY_ROGERS = "That's the little bird.",

        MONKEYISLAND_PORTAL = "Nothing can get in, but it keeps spitting things out.",
        MONKEYISLAND_PORTAL_DEBRIS = "This machinery looks oddly familiar...",
        MONKEYQUEEN = "She looks like the top banana around here.",
        MONKEYPILLAR = "A real pillar of the community.",
        PIRATE_FLAG_POLE = "Argggh! Eh, doesn't really suit me.",

        BLACKFLAG = "Reminds me of Captain Slag and his crew of goons.",
        PIRATE_STASH = "I'm diggin' the decor.",
        STASH_MAP = "It's nice to have some direction in life.",

        BANANAJUICE = "Makes me feel a bit rogueish.",

        FENCE_ROTATOR = "Two in one!",

        CHARLIE_STAGE_POST = "It's a setup! It feels too... staged.",
        CHARLIE_LECTURN = "Is someone doing a play?",

        CHARLIE_HECKLER = "They're just here to stir up drama.",

        PLAYBILL_THE_DOLL = "\"Authored by C.W.\"",
        STATUEHARP_HEDGESPAWNER = "The flowers grew back, but the head didn't.",
        HEDGEHOUND = "It's an ambush!",
        HEDGEHOUND_BUSH = "It's a bush.",

        MASK_DOLLHAT = "It's a doll mask.",
        MASK_DOLLBROKENHAT = "It's a cracked doll mask.",
        MASK_DOLLREPAIREDHAT = "It was a doll mask at one point.",
        MASK_BLACKSMITHHAT = "It's a blacksmith mask.",
        MASK_MIRRORHAT = "It's a mask, but it looks like a mirror.",
        MASK_QUEENHAT = "It's a Queen mask.",
        MASK_KINGHAT = "It's a King mask.",
        MASK_TREEHAT = "It's a tree mask.",
        MASK_FOOLHAT = "It's a fool's mask.",

        COSTUME_DOLL_BODY = "It's a doll costume.",
        COSTUME_QUEEN_BODY = "It's a Queen costume.",
        COSTUME_KING_BODY = "It's a King costume.",
        COSTUME_BLACKSMITH_BODY = "It's a blacksmith costume.",
        COSTUME_MIRROR_BODY = "It's a costume.",
        COSTUME_TREE_BODY = "It's a tree costume.",
        COSTUME_FOOL_BODY = "It's a fool's costume.",

        STAGEUSHER =
        {
            STANDING = "Just keep your hand to yourself, alright?",
            SITTING = "Something's odd here, but I can't put my finger on it.",
        },
        SEWING_MANNEQUIN =
        {
            GENERIC = "All dressed up and nowhere to go.",
            BURNT = "All burnt up and nowhere to go.",
        },

		-- Waxwell
		MAGICIAN_CHEST = "Why am I starting to feel a bit uneasy...?",
		TOPHAT_MAGICIAN = "That hat just oozes style.",

        -- Year of the Rabbit
        YOTR_FIGHTRING_KIT = "It must be built, for science!",
        YOTR_FIGHTRING_BELL =
        {
            GENERIC = "It's peaceful, for now.",
            PLAYING = "I think we've all learned a lot here today.",
        },

        YOTR_DECOR_1 = {
            GENERAL = "That rabbit can really light up a room.",
            OUT = "That rabbit isn't lighting up anything.",
        },
        YOTR_DECOR_2 = {
            GENERAL = "That rabbit can really light up a room.",
            OUT = "That rabbit isn't lighting up anything.",
        },

        HAREBALL = "At this point... I've eaten worse things.",
        YOTR_DECOR_1_ITEM = "I know just the place for it.",
        YOTR_DECOR_2_ITEM = "I know just the place for it.",

		--
		DREADSTONE = "It seems to reflect shadows instead of light.",
		HORRORFUEL = "It sends a terrible shiver down my spine.",
		DAYWALKER =
		{
			GENERIC = "Yup! Defiantly was not a good idea! Run!",
			IMPRISONED = "I'm unsure if it's a good idea to free him. He's giving me some slight Agorian vibes.",
		},
		DAYWALKER_PILLAR =
		{
			GENERIC = "There's something glinting inside the marble.",
			EXPOSED = "A pillar of impossibly hard stone.",
		},
		ARMORDREADSTONE = "Lightweight, sturdy, and snazzy!",
		DREADSTONEHAT = "To keep my brilliant brain safe and sound.",

        -- Rifts 1
        LUNARRIFT_PORTAL = "I don't think this is one of rifts created by the dimensionator.",
        LUNARRIFT_CRYSTAL = "Crystallized illuminosity.",

        LUNARTHRALL_PLANT = "It doesn't seem to care about personal space.",
        LUNARTHRALL_PLANT_VINE_END = "It has a prickly disposition.",

		LUNAR_GRAZER = "It must have come through that strange rift!",

        PUREBRILLIANCE = "It's blinding me with science!",
        LUNARPLANT_HUSK = "It's incredibly tough. I could use this!",

		LUNAR_FORGE = "Just the place to make something very clever and scientific.",
		LUNAR_FORGE_KIT = "A simple combination of elements!",

		LUNARPLANT_KIT = "I'm moonlighting as a tailor.",
		ARMOR_LUNARPLANT = "This armor doesn't leaf any room for improvement.",
		LUNARPLANTHAT = "It makes me look even brighter than usual.",
		BOMB_LUNARPLANT = "Botany and chemistry, working together.",
		STAFF_LUNARPLANT = "Plant power!",
		SWORD_LUNARPLANT = "It's hard not to make sound effects when I wave it around.",
		PICKAXE_LUNARPLANT = "Smashing!",
		SHOVEL_LUNARPLANT = "The dirt displacing possibilities are endless!",

		BROKEN_FORGEDITEM = "It's broken, but I think I could repair it.",

        PUNCHINGBAG = "It comes with a finely calibrated ouch-o-meter.",

        -- Rifts 2
        SHADOWRIFT_PORTAL = "That's defiantly not one of the rifts created by the dimensionator.",

		SHADOW_FORGE = "What dark designs will it bring to life?",
		SHADOW_FORGE_KIT = "It would be unscientific of me not to at least do some experiments.",

        FUSED_SHADELING = "I liked you better when you were smaller, and bothering someone else.",
        FUSED_SHADELING_BOMB = "Bombastic!",

		VOIDCLOTH = "Those shadows are all cut from the same cloth.",
		VOIDCLOTH_KIT = "My knowledge of sewing with shadows is patchy at best.",
		VOIDCLOTHHAT = "It makes me feel dark and mysterious.",
		ARMOR_VOIDCLOTH = "Oh drat, there's a tear across the front!",

        VOIDCLOTH_UMBRELLA = "Shaving those beefalo was funny, but losing my fur to acid is less so. This should protect me.",
        VOIDCLOTH_SCYTHE = "It makes harvesting so easy, it's scary!",

		SHADOWTHRALL_HANDS = "Hands off!",
		SHADOWTHRALL_HORNS = "It looks hungry for a fight.",
		SHADOWTHRALL_WINGS = "The wings seem to be just for show.",

        CHARLIE_NPC = "I have a feeling I've seen her before...?",
        CHARLIE_HAND = "It wants something from me.",

        NITRE_FORMATION = "It's definitely some kind of rock.",
        DREADSTONE_STACK = "It's coming from deep down in those chasms...",
        
        SCRAPBOOK_PAGE = "Someone else out there likes to scrapbook.",

        LEIF_IDOL = "Carving a tree out of wood seems a bit redundant.",
        WOODCARVEDHAT = "It looks like it's been lovingly carved.",
        WALKING_STICK = "It's a very nice stick.",

        IPECACSYRUP = "I don't think I want to eat this.",
        BOMB_LUNARPLANT_WORMWOOD = "Our friend seems to be getting more in touch with his lunar roots.", -- Unused
        WORMWOOD_MUTANTPROXY_CARRAT =
        {
        	DEAD = "That's the end of that.",
        	GENERIC = "Are carrots supposed to have legs?",
        	HELD = "You're kind of ugly up close.",
        	SLEEPING = "It's almost cute.",
        },
        WORMWOOD_MUTANTPROXY_LIGHTFLIER = "How strange, carrying one makes my pocket feel lighter!",
		WORMWOOD_MUTANTPROXY_FRUITDRAGON =
		{
			GENERIC = "It's cute, but it's not ripe yet.",
			RIPE = "I think it's ripe now.",
			SLEEPING = "It's snoozing.",
		},

        SUPPORT_PILLAR_SCAFFOLD = "It's all under wraps for now.",
        SUPPORT_PILLAR = "I should really get around to fixing that.",
        SUPPORT_PILLAR_COMPLETE = "It fills me with confidence.",
        SUPPORT_PILLAR_BROKEN = "You were once tall and strong.",

		SUPPORT_PILLAR_DREADSTONE_SCAFFOLD = "It's all under wraps for now.",
		SUPPORT_PILLAR_DREADSTONE = "I should really get around to fixing that.",
		SUPPORT_PILLAR_DREADSTONE_COMPLETE = "That looks dreadfully strong.",
		SUPPORT_PILLAR_DREADSTONE_BROKEN = "How dreadful.",

        WOLFGANG_WHISTLE = "Reminds me of Helga and her intensive obstable course training.",

        -- Rifts 3

        MUTATEDDEERCLOPS = "That looks painful, but whatever happened I'm here to end it.",
        MUTATEDWARG = "Something clearly went wrong, and I'm here to stop it.",
        MUTATEDBEARGER = "Everything is going wrong here, this is clearly not right.",

        LUNARFROG = "It got you too!",

        DEERCLOPSCORPSE =
        {
            GENERIC  = "It's over... right? Who am I kidding it's probably not.",
            BURNING  = "Can't be too careful.",
            REVIVING = "Uh oh that's not good!",
        },

        WARGCORPSE =
        {
            GENERIC  = "Pretty sure I encountered this smell under the sewers of Aquatos",
            BURNING  = "I'm not taking any chances.",
            REVIVING = "It's really just not my day!",
        },

        BEARGERCORPSE =
        {
            GENERIC  = "Gross, it reeks worst than rilgar's sewers! But defiantly not a Death weasel.",
            BURNING  = "Better safe than sorry.",
            REVIVING = "Why can't things just stay dead!",
        },

        BEARGERFUR_SACK = "There's still fur on it. Chilling.",
        HOUNDSTOOTH_BLOWPIPE = "Teeth? Doesn't seem all that hygenic.",
        DEERCLOPSEYEBALL_SENTRYWARD =
        {
            GENERIC = "How's that for an icy gaze?",    -- Enabled.
            NOEYEBALL = "Someone lose an eye?",  -- Disabled.
        },
        DEERCLOPSEYEBALL_SENTRYWARD_KIT = "Stand back everyone, I am a trained scientist!",

        SECURITY_PULSE_CAGE = "Interesting. It's empty.",
        SECURITY_PULSE_CAGE_FULL = "Aren't you the cutest little ball of pure energy?",

		CARPENTRY_STATION =
        {
            GENERIC = "It makes furniture.",
            BURNT = "It doesn't make furniture anymore.",
        },

        WOOD_TABLE = -- Shared between the round and square tables.
        {
            GENERIC = "I use tables periodically.",
            HAS_ITEM = "I use tables periodically.",
            BURNT = "I don't think I'll be using it anymore.",
        },

        WOOD_CHAIR =
        {
            GENERIC = "Finally a chair!",
            OCCUPIED = "Somebody else is sitting on that.",
            BURNT = "I wouldn't like to sit on that.",
        },

        DECOR_CENTERPIECE = "How sophisticated.",
        DECOR_LAMP = "A welcoming light.",
        DECOR_FLOWERVASE =
        {
            GENERIC = "A nice vase of flowers.",
            EMPTY = "A nice vase without any flowers.",
            WILTED = "Not looking very fresh.",
            FRESHLIGHT = "It's nice to have a little light.",
            OLDLIGHT = "I know I told Maxwell to replace the bulb.",
        },
        DECOR_PICTUREFRAME =
        {
            GENERIC = "It's beautiful.",
            UNDRAWN = "I should draw something in this.",
        },
        DECOR_PORTRAITFRAME = "Looking good!",

        PHONOGRAPH = "Is that an antique?",
        RECORD = "It's not bad, but not really my kind of music!",
        RECORD_CREEPYFOREST = "I could use some pirate radio about now.",
        RECORD_DANGER = "Not my favorite.",
        RECORD_DAWN = "Needs more trumpet.",
        RECORD_DRSTYLE = "I could use some pirate radio about now.",
        RECORD_DUSK = "Needs more trumpet.",
        RECORD_EFS = "One of their more experimental tracks.",
        RECORD_END = "I could use some pirate radio about now.",
        RECORD_MAIN = "Needs more trumpet.",
        RECORD_WORKTOBEDONE = "One of their more experimental tracks.",

        ARCHIVE_ORCHESTRINA_MAIN = "It's like they made it puzzling on purpose.",

        WAGPUNKHAT = "It really gets my gears turning.",
        ARMORWAGPUNK = "Fearsome and gearsome.",
        WAGSTAFF_MACHINERY = "Neat! I could use for some spare parts.",
        WAGPUNK_BITS = "With this maybe I could create a gadget to help.",
        WAGPUNKBITS_KIT = "Finally we're getting somewhere. With this our stuff should last longer.",

        WAGSTAFF_MUTATIONS_NOTE = "Fascinating! Illuminating! Brain-embiggening!",
    },

    DESCRIBE_GENERIC = "It's a... thing.",
    DESCRIBE_TOODARK = "It's too dark to see!",
    DESCRIBE_SMOLDERING = "That thing is about to catch fire.",

    DESCRIBE_PLANTHAPPY = "Looks health to me!",
    DESCRIBE_PLANTVERYSTRESSED = "I'm not the best at telling, but I think it looks a bit wilty.",
    DESCRIBE_PLANTSTRESSED = "It's a bit wilty.",
    DESCRIBE_PLANTSTRESSORKILLJOYS = "I might have to do a bit of weeding...",
    DESCRIBE_PLANTSTRESSORFAMILY = "Am I supposed to talk to it?",
    DESCRIBE_PLANTSTRESSOROVERCROWDING = "Looks too crowded.",
    DESCRIBE_PLANTSTRESSORSEASON = "This season is not being kind to this plant.",
    DESCRIBE_PLANTSTRESSORMOISTURE = "This looks really dehydrated.",
    DESCRIBE_PLANTSTRESSORNUTRIENTS = "It looks hungry I think!",
    DESCRIBE_PLANTSTRESSORHAPPINESS = "Ahhh, panicking! Do I talk to it or do I feed it?",

    EAT_FOOD =
    {
        TALLBIRDEGG_CRACKED = "Mmm. Tasty.",
		WINTERSFEASTFUEL = "Tastes like the holidays.",
    },
}
