










return {
	ACTIONFAIL =
	{
        APPRAISE =
        {
            NOTNOW = "They must be busy now.",
        },
        REPAIR =
        {
            WRONGPIECE = "The pieces do not fit together...",
        },
        BUILD =
        {
            MOUNTED = "I must get down from my steed first.",
            HASPET = "I've already got a little critter with me.",
			TICOON = "This goofball wants me to follow them!",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "I need them to be asleep before I destroy their coat.",
			GENERIC = "No hair to harvest.",
			NOBITS = "No fur to harvest.",
            REFUSE = "only_used_by_woodie",
            SOMEONEELSESBEEFALO = "Would be quite rude to shave someone else's pet.",
		},
		STORE =
		{
			GENERIC = "I can't cram anything else inside.",
			NOTALLOWED = "That wouldn't make sense.",
			INUSE = "The machine is in use.",
            NOTMASTERCHEF = "I do not master this art.",
		},
        CONSTRUCT =
        {
            INUSE = "Sorry, you're in my way.",
            NOTALLOWED = "That's not how it works.",
            EMPTY = "It requires more.",
            MISMATCH = "Let's reconsider this one.",
        },
		RUMMAGE =
		{	
			GENERIC = "I am unable at the time.",
			INUSE = "They're using it first.",
            NOTMASTERCHEF = "I do not master this art.",
		},
		UNLOCK =
        {
        	WRONGKEY = "This key didn't fit the lock.",
        },
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "Here comes the boy!",
        	KLAUS = "It's all mine now!",
			QUAGMIRE_WRONGKEY = "Wrong key.",
        },
		ACTIVATE = 
		{
			LOCKED_GATE = "The gate is sealed shut.",
            HOSTBUSY = "He seems a bit preoccupied at the moment.",
            CARNIVAL_HOST_HERE = "Show yourself, clever avian.",
            NOCARNIVAL = "They're gone!",
			EMPTY_CATCOONDEN = "Home of the fluffies, empty.",
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDERS = "Not enough little demons.",
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDING_SPOTS = "They require more hiding spots.",
			KITCOON_HIDEANDSEEK_ONE_GAME_PER_DAY = "I must let the little ones rest.",
            MANNEQUIN_EQUIPSWAPFAILED = "This wooden husk cannot hold this.",
		},
		OPEN_CRAFTING =
		{
            PROFESSIONALCHEF = "This art beyond my knowledge.",
			SHADOWMAGIC = "Shadows, woven.",
		},
        COOK =
        {
            GENERIC = "I cannot cook at this time.",
            INUSE = "They're already making a nice meal!",
            TOOFAR = "I'm a bit too far from it.",
        },
        START_CARRAT_RACE =
        {
            NO_RACERS = "I'm missing something here.",
        },

		DISMANTLE =
		{
			COOKING = "only_used_by_warly",
			INUSE = "only_used_by_warly",
			NOTEMPTY = "only_used_by_warly",
        },
        FISH_OCEAN =
		{
			TOODEEP = "I'd need a better fishing tool.",
		},
        OCEAN_FISHING_POND =
		{
			WRONGGEAR = "This one is for deeper fishing action.",
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
            GENERIC = "Useless.",
            DEAD = "Ghosts cannot hold items, sillyhead.",
            SLEEPING = "Wake up sleepyhead, I have something for you.",
            BUSY = "I'll need your attention once you're done.",
            ABIGAILHEART = "They are too far gone.",
            GHOSTHEART = "Anger spirits cannot be willed to live.",
            NOTGEM = "This isn't not a good power source.",
            WRONGGEM = "Not enough energy within this gem.",
            NOTSTAFF = "It needs a rod.",
            MUSHROOMFARM_NEEDSSHROOM = "I need something to grow within it.",
            MUSHROOMFARM_NEEDSLOG = "Mushrooms need to feed off a living log.",
            MUSHROOMFARM_NOMOONALLOWED = "Our plant friend might have a solution for this.",
            SLOTFULL = "There already is something in here...",
            FOODFULL = "There already is something in here...",
            NOTDISH = "Inedible.",
            DUPLICATE = "We already know this one!",
            NOTSCULPTABLE = "My sculpting requires the finest materials!",
            NOTATRIUMKEY = "I need the key, to all this madness.",
            CANTSHADOWREVIVE = "Resurrection is not possible.",
            WRONGSHADOWFORM = "This is no shell fit for revival.",
            NOMOON = "They are not visible.",
			PIGKINGGAME_MESSY = "Too cluttered.",
			PIGKINGGAME_DANGER = "A bit too lively here, I shall wait.",
			PIGKINGGAME_TOOLATE = "They need the light of day to enjoy a bit of play.",
			CARNIVALGAME_INVALID_ITEM = "Those silly machines need tokens.",
			CARNIVALGAME_ALREADY_PLAYING = "Now we wait!",
            SPIDERNOHAT = "I can't fit them together in my pocket.",
            TERRARIUM_REFUSE = "The fuel would only anger them further.",
            TERRARIUM_COOLDOWN = "It must regenerate itself for now.",
            NOTAMONKEY = "Not a fan of your language.",
            QUEENBUSY = "The queen is busy.",
        },
        GIVETOPLAYER =
        {
            FULL = "I want to give you the greatest thing ever, make some space!",
            DEAD = "I should be giving them a heart.",
            SLEEPING = "What an eeper!",
            BUSY = "Let me bug you for a second, hehe.",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "I want to give you the greatest thing ever, make some space!",
            DEAD = "I should be giving them a heart.",
            SLEEPING = "What an eeper!",
            BUSY = "Let me bug you for a second, hehe.",
        },
        WRITE =
        {
            GENERIC = "I can't overwrite history.",
            INUSE = "The desk is in use.",
        },
        DRAW =
        {
            NOIMAGE = "My reference is too far away.",
        },
        CHANGEIN =
        {
            GENERIC = "No time for fashion!",
            BURNING = "Fabric burns inside.",
            INUSE = "I see someone enjoys a bit of fashion.",
            NOTENOUGHHAIR = "There isn't enough fur to style.",
            NOOCCUPANT = "It needs a steed hitched up.",
        },
        ATTUNE =
        {
            NOHEALTH = "I'm too weak to bond with this.",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "Oh dear, it does seem quite upset.",
            INUSE = "Get off your high hors- cow!",
			SLEEPING = "Time to wake up!",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "Oh dear, it does seem quite upset.",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "I already know this one.",
            CANTLEARN = "This is beyond my intellect, curious...",

            --MapRecorder/MapExplorer
            WRONGWORLD = "That's not the location we are in.",

			--MapSpotRevealer/messagebottle
			MESSAGEBOTTLEMANAGER_NOT_FOUND = "I need sunlight to read this.",--Likely trying to read messagebottle treasure map in caves

            STASH_MAP_NOT_FOUND = "No X mark.",-- Likely trying to read stash map  in world without stash
        },
        WRAPBUNDLE =
        {
            EMPTY = "Air is rare, but I'd rather my bundles filled.",
        },
        PICKUP =
        {
			RESTRICTION = "It was not meant for me.",
			INUSE = "It's theirs!",
            NOTMINE_SPIDER = "only_used_by_webber",
            NOTMINE_YOTC =
            {
                "Not my minion.",
                "Not my little critter.",
            },
			NO_HEAVY_LIFTING = "only_used_by_wanda",
            FULL_OF_CURSES = "I'm not touching that.",
        },
        SLAUGHTER =
        {
            TOOFAR = "The beast got away.",
        },
        REPLATE =
        {
            MISMATCH = "Wrong food.", 
            SAMEDISH = "It's the same.", 
        },
        SAIL =
        {
        	REPAIR = "It's in excellent state.",
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "I'm no sailor!",
            BAD_TIMING1 = "No haste needed.",
            BAD_TIMING2 = "...",
        },
        LOWER_SAIL_FAIL =
        {
            "My jaw slipped.",
            "I hit my face by accident.",
            "I didn't mean to lower it now.",
        },
        BATHBOMB =
        {
            GLASSED = "I must clear the waters first.",
            ALREADY_BOMBED = "I already bombed it before.",
        },
		GIVE_TACKLESKETCH =
		{
			DUPLICATE = "I've already tackled this one.",
		},
		COMPARE_WEIGHABLE =
		{
            FISH_TOO_SMALL = "What a little fishy!",
            OVERSIZEDVEGGIES_TOO_SMALL = "A bit lighter than most.",
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
            GENERIC = "Nothing left to learn.",
            FERTILIZER = "I'd rather not know anything further.",
        },
        FILL_OCEAN =
        {
            UNSUITABLE_FOR_PLANTS = "I can't believe plants wouldn't like salt.",
        },
        POUR_WATER =
        {
            OUT_OF_WATER = "Needs a refill!",
        },
        POUR_WATER_GROUNDTILE =
        {
            OUT_OF_WATER = "Needs a refill!",
        },
        USEITEMON =
        {
            --GENERIC = "I can't use this on that!",

            --construction is PREFABNAME_REASON
            BEEF_BELL_INVALID_TARGET = "This bell only works on the boofies!",
            BEEF_BELL_ALREADY_USED = "Boofy already taken.",
            BEEF_BELL_HAS_BEEF_ALREADY = "I have my own steed already.",
        },
        HITCHUP =
        {
            NEEDBEEF = "I need to be carrying the bell.	",
            NEEDBEEF_CLOSER = "Boofy is a bit too far!",
            BEEF_HITCHED = "Already hitched up.",
            INMOOD = "Honky.",
        },
        MARK =
        {
            ALREADY_MARKED = "I have decided, already.",
            NOT_PARTICIPANT = "Let's not interrupt them.",
        },
        YOTB_STARTCONTEST =
        {
            DOESNTWORK = "I guess they don't support the arts here.",
            ALREADYACTIVE = "He must be busy with another contest somewhere.",
        },
        YOTB_UNLOCKSKIN =
        {
            ALREADYKNOWN = "I've learned this already!",
        },
        CARNIVALGAME_FEED =
        {
            TOO_LATE = "Faster!",
        },
        HERD_FOLLOWERS =
        {
            WEBBERONLY = "They won't listen to me, but they might listen to the spiderboy.",
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
            DOER_ISNT_MODULE_OWNER = "I'm no machinery.",
        },
    },

	ANNOUNCE_CANNOT_BUILD =
	{
		NO_INGREDIENTS = "I'm missing a few elements for this one.",
		NO_TECH = "I need a station to make this.",
		NO_STATION = "I forgor.",
	},

	ACTIONFAIL_GENERIC = "Let's try that again.",
	ANNOUNCE_BOAT_LEAK = "It starts to sink.",
	ANNOUNCE_BOAT_SINK = "Good thing I don't mind water that much.",
	ANNOUNCE_DIG_DISEASE_WARNING = "The sickness is no more.",
	ANNOUNCE_PICK_DISEASE_WARNING = "It's rotten.",
	ANNOUNCE_ADVENTUREFAIL = "Failure.",
    ANNOUNCE_MOUNT_LOWHEALTH = "Boofy is wounded.",

    --waxwell and wickerbottom specific strings
    ANNOUNCE_TOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
    ANNOUNCE_WAYTOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
    ANNOUNCE_NOWATERNEARBY = "only_used_by_waxwell_and_wicker",

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

	ANNOUNCE_BEES = "Fly my minions!",
	ANNOUNCE_BOOMERANG = "...Ouch.",
	ANNOUNCE_CHARLIE = "You must want me gone, I see.",
	ANNOUNCE_CHARLIE_ATTACK = "Doesn't beat the despair I've felt...",
	ANNOUNCE_CHARLIE_MISSED = "only_used_by_winona", --winona specific 
	ANNOUNCE_COLD = "Our matter is becoming numb.",
	ANNOUNCE_HOT = "We are melting.",
	ANNOUNCE_CRAFTING_FAIL = "Missing matter.",
	ANNOUNCE_DEERCLOPS = "He is coming for his boy.",
	ANNOUNCE_CAVEIN = "Into the depth, we are.",
	ANNOUNCE_ANTLION_SINKHOLE = 
	{
		"Desert anger is about to haunt us.",
		"The world is shattering.",
		"Matter breaking below.",
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "Shall I pay tribute to them?",
        "A tribute for you, great Antlion.",
        "Cease your appetite.",
	},
	ANNOUNCE_SACREDCHEST_YES = "I take what's ours.",
	ANNOUNCE_SACREDCHEST_NO = "A trap?",
    ANNOUNCE_DUSK = "Darkness shall swallow all.",
    
    --wx-78 specific
    ANNOUNCE_CHARGE = "only_used_by_wx78",
	ANNOUNCE_DISCHARGE = "only_used_by_wx78",

	ANNOUNCE_EAT =
	{
		GENERIC = "I feast!",
		PAINFUL = "Poison matter doesn't affect us.",
		SPOILED = "It has lost most nutrition.",
		STALE = "Time passed by for organic matter.",
		INVALID = "Not edible.",
        YUCKY = "...No.",
        
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
        "Keeping the pace.",
        "Slow and steady.",
        "Lift... with your back...",
        "This work is not suited for my old bones.",
        "This is necessary.",
        "Hngh...!",
        "Urgh... Must I do all the work?",
        "I'll lose a rib doing this!",
        "...!",
    },
    ANNOUNCE_ATRIUM_DESTABILIZING = 
    {
		"At last!",
		"They are pushing for freedom.",
		"We have freed them.",
	},
    ANNOUNCE_RUINS_RESET = "Everything is back, but after the chaos.",
    ANNOUNCE_SNARED = "Sharp bones.",
    ANNOUNCE_SNARED_IVY = "What a feisty garden!",
    ANNOUNCE_REPELLED = "Repels attacks.",
	ANNOUNCE_ENTER_DARK = "Darkness.",
	ANNOUNCE_ENTER_LIGHT = "And we're back in the light.",
	ANNOUNCE_FREEDOM = "Freedom!",
	ANNOUNCE_HIGHRESEARCH = "Knowledge means all.",
	ANNOUNCE_HOUNDS = "The pack is approaching.",
	ANNOUNCE_WORMS = "The slitherers are coming.",
	ANNOUNCE_HUNGRY = "WE. HUNGER. Sorry, force of habit.",
	ANNOUNCE_HUNT_BEAST_NEARBY = "Soon the hunt shall be over.",
	ANNOUNCE_HUNT_LOST_TRAIL = "Lost in its own stupidity.",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "The trail muddied over.",
	ANNOUNCE_HUNT_START_FORK = "This trail looks dangerous.",
    ANNOUNCE_HUNT_SUCCESSFUL_FORK = "Let's see where this leads.",
    ANNOUNCE_HUNT_WRONG_FORK = "We might be in trouble.",
    ANNOUNCE_HUNT_AVOID_FORK = "Seems safe.",
	ANNOUNCE_INV_FULL = "I should sort out my belongings.",
	ANNOUNCE_KNOCKEDOUT = "Is my face still in place?",
	ANNOUNCE_LOWRESEARCH = "I need to research more!",
	ANNOUNCE_MOSQUITOS = "Leeches.",
    ANNOUNCE_NOWARDROBEONFIRE = "Cloth burns.",
    ANNOUNCE_NODANGERGIFT = "Monsters still lurk around.",
    ANNOUNCE_NOMOUNTEDGIFT = "We shall hop off the mount to do that.",
	ANNOUNCE_NODANGERSLEEP = "That can wait.",
	ANNOUNCE_NODAYSLEEP = "The day bothers me.",
	ANNOUNCE_NODAYSLEEP_CAVE = "We do not need rest.",
	ANNOUNCE_NOHUNGERSLEEP = "We hunger for matter!",
	ANNOUNCE_NOSLEEPONFIRE = "We shall not rest in flames.",
	ANNOUNCE_NODANGERSIESTA = "Beasts lurk around.",
	ANNOUNCE_NONIGHTSIESTA = "No time to nap.",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "Not now.",
	ANNOUNCE_NOHUNGERSIESTA = "WE HUNGER, NO TIME TO REST.",
	ANNOUNCE_NODANGERAFK = "Let's not.",
	ANNOUNCE_NO_TRAP = "Foolish.",
	ANNOUNCE_PECKED = "...",
	ANNOUNCE_QUAKE = "My jaw is shaking.",
	ANNOUNCE_RESEARCH = "More knowledge to grasp.",
	ANNOUNCE_SHELTER = "Shelter, at last.",
	ANNOUNCE_THORNS = "Sweet armor of thorns...",
	ANNOUNCE_BURNT = "Flames around us.",
	ANNOUNCE_TORCH_OUT = "Into the night we go.",
	ANNOUNCE_THURIBLE_OUT = "Sweet darkness perished.",
	ANNOUNCE_FAN_OUT = "Flied off.",
    ANNOUNCE_COMPASS_OUT = "Broken device.",
	ANNOUNCE_TRAP_WENT_OFF = "Magic traps.",
	ANNOUNCE_UNIMPLEMENTED = "I'm unsure how to react.",
	ANNOUNCE_WORMHOLE = "What a sweet ride, intense.",
	ANNOUNCE_TOWNPORTALTELEPORT = "...",
	ANNOUNCE_CANFIX = "\nIt needs repairs, I shall provide!",
	ANNOUNCE_ACCOMPLISHMENT = "Good work Wanderer.",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "Marvelous...",	
	ANNOUNCE_INSUFFICIENTFERTILIZER = "More nutrition needed.",
	ANNOUNCE_TOOL_SLIP = "And it flies off.",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "That was close.",
	ANNOUNCE_TOADESCAPING = "The toad is losing interest.",
	ANNOUNCE_TOADESCAPED = "The toad got away.",


	ANNOUNCE_DAMP = "Soaking.",
	ANNOUNCE_WET = "I am one with the water.",
	ANNOUNCE_WETTER = "This weighs me down.",
	ANNOUNCE_SOAKED = "I feel like I'm drowning.",

	ANNOUNCE_WASHED_ASHORE = "...That could have been prevented.",

    ANNOUNCE_DESPAWN = "Time to dematerialize again.",
	ANNOUNCE_BECOMEGHOST = "Reached the end.",
	ANNOUNCE_GHOSTDRAIN = "My life is about to start slipping away...",
	ANNOUNCE_PETRIFED_TREES = "The trees are screaming?",
	ANNOUNCE_KLAUS_ENRAGE = "I like a challenge.",
	ANNOUNCE_KLAUS_UNCHAINED = "Broken restraints.",
	ANNOUNCE_KLAUS_CALLFORHELP = "Their kin is incoming.",

	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "Come out.",
		GLASS_LOW = "I can see you.",
		GLASS_REVEAL = "I know your use.",
		IDOL_MED = "Come out.",
		IDOL_LOW = "I can see you.",
		IDOL_REVEAL = "I know your use.",
		SEED_MED = "Come out.",
		SEED_LOW = "I can see you.",
		SEED_REVEAL = "I know your use.",
	},

    --hallowed nights
    ANNOUNCE_SPOOKED = "Ah.",
	ANNOUNCE_BRAVERY_POTION = "Did I really needed to drink that?",
	ANNOUNCE_MOONPOTION_FAILED = "Interesting... it's of no use.",

	--winter's feast
	ANNOUNCE_EATING_NOT_FEASTING = "Jolly.",
	ANNOUNCE_WINTERS_FEAST_BUFF = "Is this... festivities?",
	ANNOUNCE_IS_FEASTING = "...",
	ANNOUNCE_WINTERS_FEAST_BUFF_OVER = "Ugh...",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "Come back, TO THE WORLD OF THE LIVING.",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "You are welcome.",
    ANNOUNCE_REVIVED_FROM_CORPSE = "I RETURN!",

    ANNOUNCE_FLARE_SEEN = "Lights above?",
    ANNOUNCE_MEGA_FLARE_SEEN = "It's a war declaration.",
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "Sea beast, on the horizon.",

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
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "This isn't cooking.",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "Burnt.",
    QUAGMIRE_ANNOUNCE_LOSE = "I smell something fishy. Glorp florp.",
    QUAGMIRE_ANNOUNCE_WIN = "Naura!",

    ANNOUNCE_ROYALTY =
    {
        "Bowing to you.",
        "Best idiot around.",
        "Don't take that stance.",
    },

    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "The lightning fills my essence!",
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "POWER, GROWS!",
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "My shell hardens.",
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "I feel efficient!",
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "The water is no more.",
    ANNOUNCE_ATTACH_BUFF_SLEEPRESISTANCE   = "I refuse to succumb to you, Morpheus.",

    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "The lightning leaves my body.",
    ANNOUNCE_DETACH_BUFF_ATTACK            = "I am weakened.",
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "I feel frail again.",
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "And it's gone.",
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "Wetness strikes again.",
    ANNOUNCE_DETACH_BUFF_SLEEPRESISTANCE   = "Tiredness finds me.",

	ANNOUNCE_OCEANFISHING_LINESNAP = "The line broke.",
	ANNOUNCE_OCEANFISHING_LINETOOLOOSE = "Reel in.",
	ANNOUNCE_OCEANFISHING_GOTAWAY = "Gone.",
	ANNOUNCE_OCEANFISHING_BADCAST = "What was that...",
	ANNOUNCE_OCEANFISHING_IDLE_QUOTE =
	{
		"Patience.",
		"There are no fish here.",
		"Aquatic beasts fear me.",
		"Any day now.",
	},

	ANNOUNCE_WEIGHT = "Weight: {weight}",
	ANNOUNCE_WEIGHT_HEAVY  = "Weight: {weight}\nWhat a chonker!",

	ANNOUNCE_WINCH_CLAW_MISS = "I think I missed the mark.",
	ANNOUNCE_WINCH_CLAW_NO_ITEM = "I've come up empty handed.",

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

        BOOK_HORTICULTURE_UPGRADED = "only_used_by_wurt",
        BOOK_RESEARCH_STATION = "only_used_by_wurt",
        BOOK_LIGHT_UPGRADED = "only_used_by_wurt",
    },
    ANNOUNCE_WEAK_RAT = "Weak.",

    ANNOUNCE_CARRAT_START_RACE = "RUN FOR YOUR LIVES, PESKY RODENTS!",

    ANNOUNCE_CARRAT_ERROR_WRONG_WAY = {
        "Dumb rodent!",
        "Turn around!",
    },
    ANNOUNCE_CARRAT_ERROR_FELL_ASLEEP = "WAKE UP.",
    ANNOUNCE_CARRAT_ERROR_WALKING = "SPEED UP!",
    ANNOUNCE_CARRAT_ERROR_STUNNED = "GO! GO!",

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

	ANNOUNCE_POCKETWATCH_PORTAL = "Time doesn't favour me.",

	ANNOUNCE_POCKETWATCH_MARK = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_RECALL = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL_DIFFERENTSHARD = "only_used_by_wanda",

    ANNOUNCE_ARCHIVE_NEW_KNOWLEDGE = "Ha ha, I knew that...",
    ANNOUNCE_ARCHIVE_OLD_KNOWLEDGE = "I know that one.",
    ANNOUNCE_ARCHIVE_NO_POWER = "The power is gone.",

    ANNOUNCE_PLANT_RESEARCHED =
    {
        "I've learned more!",
    },

    ANNOUNCE_PLANT_RANDOMSEED = "I wonder what it will grow into.",

    ANNOUNCE_FERTILIZER_RESEARCHED = "...",

	ANNOUNCE_FIRENETTLE_TOXIN =
	{
		"Hot stuff!",
		"...!",
	},
	ANNOUNCE_FIRENETTLE_TOXIN_DONE = "The toxin stopped working.",

	ANNOUNCE_TALK_TO_PLANTS =
	{
        "Sacred mother, help this young soul reach the light!",
        "Come child, reach me.",
		"*smooch*!",
        "Rise and shine!",
        "Don't fail me.",
	},

	ANNOUNCE_KITCOON_HIDEANDSEEK_START = "I search now.",
	ANNOUNCE_KITCOON_HIDEANDSEEK_JOIN = "Aww, they're playing hide and seek.",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND =
	{
		"Found you!",
		"There you are.",
		"I knew you'd be hiding there!",
		"I see you!",
	},
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_ONE_MORE = "Now where's that last one hiding?",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE = "I found the last one!",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE_TEAM = "{name} found the last one!",
	ANNOUNCE_KITCOON_HIDANDSEEK_TIME_ALMOST_UP = "These little guys must be getting impatient...",
	ANNOUNCE_KITCOON_HIDANDSEEK_LOSEGAME = "I guess they don't want to play any more...",
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR = "They probably wouldn't hide this far away, would they?",
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR_RETURN = "The kitcoons should be nearby.",
	ANNOUNCE_KITCOON_FOUND_IN_THE_WILD = "I knew I saw something hiding over here!",

	ANNOUNCE_TICOON_START_TRACKING	= "He's caught the scent!",
	ANNOUNCE_TICOON_NOTHING_TO_TRACK = "Looks like he couldn't find anything.",
	ANNOUNCE_TICOON_WAITING_FOR_LEADER = "I should follow him!",
	ANNOUNCE_TICOON_GET_LEADER_ATTENTION = "He really wants me to follow him.",
	ANNOUNCE_TICOON_NEAR_KITCOON = "He must have found something!",
	ANNOUNCE_TICOON_LOST_KITCOON = "Looks like someone else found what he was looking for.",
	ANNOUNCE_TICOON_ABANDONED = "I'll find those little guys on my own.",
	ANNOUNCE_TICOON_DEAD = "Poor guy... Now where was he leading me?",

    -- YOTB
    ANNOUNCE_CALL_BEEF = "Come on over!",
    ANNOUNCE_CANTBUILDHERE_YOTB_POST = "The judge won't be able to see my boofy from here.",
    ANNOUNCE_YOTB_LEARN_NEW_PATTERN =  "I can rock a new boofy style now!",

    -- AE4AE
    ANNOUNCE_EYEOFTERROR_ARRIVE = "GIVE ME YOUR EYE!",
    ANNOUNCE_EYEOFTERROR_FLYBACK = "FACE ME!",
    ANNOUNCE_EYEOFTERROR_FLYAWAY = "FACE ME COWARD!",

    -- PIRATES
    ANNOUNCE_CANT_ESCAPE_CURSE = "Of course it couldn't be that easy.",
    ANNOUNCE_MONKEY_CURSE_1 = "...",
    ANNOUNCE_MONKEY_CURSE_CHANGE = "...?!",
    ANNOUNCE_MONKEY_CURSE_CHANGEBACK = "I'm glad that's over.",

    ANNOUNCE_PIRATES_ARRIVE = "Curse you.",

    ANNOUNCE_BOOK_MOON_DAYTIME = "only_used_by_waxwell_and_wicker",

    ANNOUNCE_OFF_SCRIPT = "Let's follow their script now.",
	
	ANNOUNCE_TOOL_TOOWEAK = "I need a stronger tool!",

    ANNOUNCE_LUNAR_RIFT_MAX = "They are out there.",
    ANNOUNCE_SHADOW_RIFT_MAX = "They are poking out.",

    ANNOUNCE_SCRAPBOOK_FULL = "I already have all these.",

    ANNOUNCE_CHAIR_ON_FIRE = "Do you smell something?",

	BATTLECRY =
	{
		GENERIC = "I'll rip your eyes out!",
		PIG = "You are no match for me!",
		PREY = "Die for me!",
		SPIDER = "Fall beneath me!",
		SPIDER_WARRIOR = "Bring it on!",
		DEER = "GOOD! RUN FOR YOUR LIFE!",
	},
	COMBAT_QUIT =
	{
		GENERIC = "No time for that!",
		PIG = "Get out of my sight.",
		PREY = "You have been spared!",
		SPIDER = "Let them live another day.",
		SPIDER_WARRIOR = "You angered me enough.",
	},

	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "Where everyone came from.",
        MULTIPLAYER_PORTAL_MOONROCK = "To exchange a life for another.",
        MOONROCKIDOL = "The eye is watching, offer them this.",
        CONSTRUCTION_PLANS = "Fake the escape.",

        ANTLION =
        {
            GENERIC = "The great Antlion demands a tribute.",
            VERYHAPPY = "Pleased.",
            UNHAPPY = "Angered.",
        },
        ANTLIONTRINKET = "See the heart of the desert.",
        SANDSPIKE = "They appear to shift the ground below.",
        SANDBLOCK = "This won't stop me.",
        GLASSSPIKE = "It's like the sand has bones.",
        GLASSBLOCK = "Not enough to rebuild the empire.",
        ABIGAIL_FLOWER =
        {
            GENERIC ="Hold the memories.",
			LEVEL1 = "Twist the mind.",
			LEVEL2 = "Encourage yearning.",
			LEVEL3 = "But hope is a foolish trait.",

			-- deprecated
            LONG = "It hurts my soul to look at that thing.",
            MEDIUM = "It's giving me the creeps.",
            SOON = "Something is up with that flower!",
            HAUNTED_POCKET = "I don't think I should hang on to this.",
            HAUNTED_GROUND = "I'd die to find out what it does.",
        },

        BALLOONS_EMPTY = "It looks like clown currency.",
        BALLOON = "I fancy a little decor!",
		BALLOONPARTY = "The art of entertainment, air filled.",
		BALLOONSPEED =
        {
            DEFLATED = "And it's empty.",
            GENERIC = "Thank you dear, I'll use this well.",
        },
		BALLOONVEST = "Squeak, squeak, squeak!",
		BALLOONHAT = "What a silly hat!",

        BERNIE_INACTIVE =
        {
            BROKEN = "The demon is injured.",
            GENERIC = "The demon is within.",
        },

        BERNIE_ACTIVE = "It lures in pray, but cannot fully fight.",
        BERNIE_BIG = "It wants to break free from its prison.",

		BOOKSTATION =
		{
			GENERIC = "A library of knowledge, like our own.",
			BURNT = "Ashes and coal.",
		},
        BOOK_BIRDS = "Avian summoner.",
        BOOK_TENTACLES = "Summon them from the great depths.",
        BOOK_GARDENING = "Odes for the great mother.",
		BOOK_SILVICULTURE = "Power of growth.",
		BOOK_HORTICULTURE = "Harness the earth!",
        BOOK_SLEEP = "I've slept enough until now.",
        BOOK_BRIMSTONE = "Enrage the sky.",

        BOOK_FISH = "To call the ocean beasts.",
        BOOK_FIRE = "Harvest ignition.",
        BOOK_WEB = "To impede the attackers.",
        BOOK_TEMPERATURE = "My eyes are a bit more effective than this.",
        BOOK_LIGHT = "To fight the fear, you need to face it.",
        BOOK_RAIN = "Call upon the sky.",
        BOOK_MOON = "I miss our emperor.",
        BOOK_BEES = "The bees are here!",
        
        BOOK_HORTICULTURE_UPGRADED = "It's about as exciting as watching grass grow.",
        BOOK_RESEARCH_STATION = "A bit of enlightenment.",
        BOOK_LIGHT_UPGRADED = "May the darkness disperse!",

        FIREPEN = "Hot take: literally!",

        PLAYER =
        {
            GENERIC = "Greetings, %s.",
            ATTACKER = "%s is danger.",
            MURDERER = "Traitor.",
            REVIVER = "%s, with heartwarming reunions.",
            GHOST = "%s, you are prettier that way.",
            FIRESTARTER = "Watching the world burn isn't the way %s.",
        },
        WILSON =
        {
            GENERIC = "Greetings, %s, how are your studies and experiments going?",
            ATTACKER = "Not so friendly now?",
            MURDERER = "You've fell to the same level as them all.",
            REVIVER = "Good display of altruism %s.",
            GHOST = "Thankfully you're not completely gone yet %s.",
            FIRESTARTER = "%s, fire experiments are meant to be controlled.",
        },
        WOLFGANG =
        {
            GENERIC = "%s has a great sense of body construction and resilience.",
            ATTACKER = "Your strength has gotten you mad!",
            MURDERER = "I'm sorry but I must take you down.",
            REVIVER = "Strong and kind hearted, thank you %s.",
            GHOST = "It seems you've overextended yourself %s.",
            FIRESTARTER = "I'd rather you protecting us, not burning us.",
        },
        WAXWELL =
        {
            GENERIC = "I sense you must be the jester of the group, %s?",
            ATTACKER = "Our knowledge isn't made to hurt others %s.",
            MURDERER = "You've gotten mad with power, %s.",
            REVIVER = "Despite our differences %s has come to the aid of us all.",
            GHOST = "As we did you've fallen, you're not far gone yet %s, hold on.",
            FIRESTARTER = "I'll suggest you stick to your shadow magic, not fire tricks.",
        },
        WX78 =
        {
            GENERIC = "You are quite an impressive feat of technology, aren't you %s?",
            ATTACKER = "Someone must have programmed you wrong.",
            MURDERER = "You're not better than the ones in the ruins.",
            REVIVER = "I was told you lacked empathy %s, perhaps they were wrong.",
            GHOST = "Interesting phenomenon, I shall return you to your shell.",
            FIRESTARTER = "I get you wish to rule the world but don't destroy it beforehand, alright?",
        },
        WILLOW =
        {
            GENERIC = "Fire bending is quite an impressive art, miss %s.",
            ATTACKER = "A beauty in flames destroyed by violence.",
            MURDERER = "You've truly gone mad, my dear.",
            REVIVER = "I thank you for your assistance %s.",
            GHOST = "As you burned you turned into a floating soul, hold on.",
            FIRESTARTER = "Mind your art miss %s.",
        },
        WENDY =
        {
            GENERIC = "I too sense loneliness and sorrow within you, young %s.",
            ATTACKER = "You must be in the third stage of grief, calm down %s.",
            MURDERER = "Killing others won't bring your sister back.",
            REVIVER = "%s knows to be reliable to others despite their sadness.",
            GHOST = "You are bound to this place %s, death is not an escape.",
            FIRESTARTER = "Destruction isn't the way you'll be at peace, my young.",
        },
        WOODIE =
        {
            GENERIC = "Controlling the beast within you is formidable, %s.",
            ATTACKER = "%s has lost control of themselves.",
            MURDERER = "You must fall as you've felled the forest.",
            REVIVER = "%s is a good willed individual.",
            GHOST = "Tree fell on you %s?",
            BEAVER = "Strong performance of control %s!",
            BEAVERGHOST = "Oh dear, the beast has fallen.",
            MOOSE = "This must be your power form, am I right?",
            MOOSEGHOST = "You fought well %s, let me help you back on your hooves.",
            GOOSE = "Tell me, what is this one for?",
            GOOSEGHOST = "Someone plucked your feathers.",
            FIRESTARTER = "I thought you took values in keeping fires away from the forest, %s.",
        },
        WICKERBOTTOM =
        {
            GENERIC = "I notice a keen sense of interest of knowledge in you, %s.",
            ATTACKER = "We could be sharing our studies insteaf of fighting, miss.",
            MURDERER = "Power leads to madness, sadly.",
            REVIVER = "Ms. %s has a great sense of selflessness.",
            GHOST = "Oh my, let's give you some aid %s.",
            FIRESTARTER = "I'm sure you had a very clever reason for that fire.",
        },
        WES =
        {
            GENERIC = "Greetings, sir %s, right?",
            ATTACKER = "No reasons to be this upset, %s.",
            MURDERER = "I'm sorry little sir but I must stop your bloodthirst.",
            REVIVER = "I knew %s had a king heart despite their silence.",
            GHOST = "Let me grant you some help, %s.",
            FIRESTARTER = "Fire isn't as harmless as silence, %s!",
        },
        WEBBER =
        {
            GENERIC = "I see you're stuck in your body as well, %s.",
            ATTACKER = "Let's not get angry now!",
            MURDERER = "And I thought you and the monster within you were at harmony.",
            REVIVER = "Thank you young sir, you've been raised well!",
            GHOST = "%s, how did you get hurt?",
            FIRESTARTER = "Have you been shown the art of fire by Willow as well?",
        },
        WATHGRITHR =
        {
            GENERIC = "Greetings, %s! I must say I hold your sense of performance in high regards!",
            ATTACKER = "There must be a misunderstanding %s, I'm not here to cause harm!",
            MURDERER = "She's gotten bloodthirsty, barbaric!",
            REVIVER = "%s is a selfless warrior.",
            GHOST = "Oh dear, you must've fought valiantly %s, let me aid you.",
            FIRESTARTER = "Hel's fire, right? Let's not abuse it miss.",
        },
        WINONA =
        {
            GENERIC = "Ah an engineer! Greetings, %s!",
            ATTACKER = "Careful %s, you'll hurt others.",
            MURDERER = "That didn't seem like another accident, %s!",
            REVIVER = "A hard working lady and a good will, thank you %s.",
            GHOST = "Looks like someone threw a wrench into your plans.",
            FIRESTARTER = "Let's not burn down your blueprints.",
        },
        WORTOX =
        {
            GENERIC = "Oh my, a fellow caprine! Greetings fluffy sir!",
            ATTACKER = "A prank is supposed to be harmless, act nicer!",
            MURDERER = "I'll get rid of you for our safety, sorry.",
            REVIVER = "Kind hearted floofster you are %s!",
            GHOST = "You don't keep the softness as a ghost sadly.",
            FIRESTARTER = "Careful to not burn yourself, sir.",
        },
        WORMWOOD =
        {
            GENERIC = "I see you come from far away, %s!",
            ATTACKER = "Let's settle this over a bit of gardening.",
            MURDERER = "Have you lost your mind, %s?",
            REVIVER = "%s weren't lying when they called us friend.",
            GHOST = "Let's leaf you right back to your leaves, %s!",
            FIRESTARTER = "Ironic, to burn things as a plant.",
        },
        WARLY =
        {
            GENERIC = "I must call your art of foodmaking quite majestic, %s!",
            ATTACKER = "Have you eaten something wrong %s?",
            MURDERER = "I've seen a bone stew in your cookbook, let's not. Please.",
            REVIVER = "A chef is always kind hearted!",
            GHOST = "If you needed help getting a special ingredient you could've asked, %s!",
            FIRESTARTER = "Have you burned something up in the oven?",
        },

        WURT =
        {
            GENERIC = "Florp! %s!",
            ATTACKER = "Did I say something wrong?",
            MURDERER = "The killer fish is on the loose!",
            REVIVER = "What a nice fishfolk you are %s!",
            GHOST = "The fishy smell is mostly gone from %s.",
            FIRESTARTER = "Let's not burn now your whole village!",
        },

        WALTER =
        {
            GENERIC = "What are those shiny little baubles all over your shirt %s?",
            ATTACKER = "I don't think there's a killing badge.",
            MURDERER = "Are you sure your dog should see all this?",
            REVIVER = "%s is a dependable friend.",
            GHOST = "I see your adventures caught up to you.",
            FIRESTARTER = "I thought you had a fire control badge.",
        },

        WANDA =
        {
            GENERIC = "So when do you come from %s?",
            ATTACKER = "Let's not get to fighting, please.",
            MURDERER = "As you say, I'll send you back in time!",
            REVIVER = "%s always has time to spare for a bit of altruism.",
            GHOST = "Bad time management I presume %s? I shall aid you.",
            FIRESTARTER = "That was just an unnecessary fire.",
        },

        WONKEY =
        {
            GENERIC = "Odd movements, sir of the isles.",
            ATTACKER = "You've gone wild!",
            MURDERER = "I'll end your business now!",
            REVIVER = "Thank you... Who are you again?",
            GHOST = "Fine, I'll aid you.",
            FIRESTARTER = "Did you just discover fire?",
        },

        MIGRATION_PORTAL =
        {
        --    GENERIC = "If I had any friends, this could take me to them.",
        --    OPEN = "If I step through, will I still be me?",
        --    FULL = "It seems to be popular over there.",
        },
        GLOMMER = 
        {
            GENERIC = "They have carrot legs.",
            SLEEPING = "They squeak when you pet them.",
        },
        GLOMMERFLOWER =
        {
            GENERIC = "I'll call them Carrotleggy!",
            DEAD = "I'm sorry sir Leggy.",
        },
        GLOMMERWINGS = "This rings a bell.",
        GLOMMERFUEL = "Thank you sir Carrotleggy, for the aid!",
        BELL = "Oh, that's it!",
        STATUEGLOMMER =
        {
            GENERIC = "It comes alive on the full moon.",
            EMPTY = "That holds no secrets anymore.",
        },

        LAVA_POND_ROCK = "Oh my, a pebble.",

		WEBBERSKULL = "Throw this in a grave.",
		WORMLIGHT = "Yummy little fruit.",
		WORMLIGHT_LESSER = "Not juicy enough.",
		WORM =
		{
		    PLANT = "Why not after all.",
		    DIRT = "Underground lurkers.",
		    WORM = "What a surprise, the lurkers!",
		},
        WORMLIGHT_PLANT = "Seems safe to me.",
		MOLE =
		{
			HELD = "Harold the digger.",
			UNDERGROUND = "When I capture you, you'll get a name.",
			ABOVEGROUND = "I see you.",
		},
		MOLEHILL = "Mole nest.",
		MOLEHAT = "I'll give this to someone who can use it.",

		EEL = "Shocking these are still here.",
		EEL_COOKED = "This'll do for now.",
		UNAGI = "A simple fish dish.",
		EYETURRET = "This served a very different purpose back in the day.",
		EYETURRET_ITEM = "Inactive.",
		MINOTAURHORN = "Got your nose!",
		MINOTAURCHEST = "It's all mine to take now!",
		THULECITE_PIECES = "Shards of us, shards of me.",
		POND_ALGAE = "A bit of water in this mud.",
		GREENSTAFF = "Deconstruct, to build better later.",
		GIFT = "Mine!",
        GIFTWRAP = "Also, this is now mine!",
		POTTEDFERN = "Decorations, pleases my eye!",
        SUCCULENT_POTTED = "Marvelous!",
		SUCCULENT_PLANT = "Desert sands weave just marvelous creations!",
		SUCCULENT_PICKED = "Capture the beauty before it fades away.",
		SENTRYWARD = "Mapping tool.",
        TOWNPORTAL =
        {
			GENERIC = "This is useless.",
			ACTIVE = "Might as well use this.",
		},
        TOWNPORTALTALISMAN = 
        {
			GENERIC = "Gift of the desert for my eyes.",
			ACTIVE = "I'd rather walk.",
		},
        WETPAPER = "Wet...",
        WETPOUCH = "Wet.",
        MOONROCK_PIECES = "Don't bask in their light, or you'll end up rocked.",
        MOONBASE =
        {
            GENERIC = "It is a device to call upon them.",
            BROKEN = "No! Please let me reach them!",
            STAFFED = "Now we wait.",
            WRONGSTAFF = "It needs the star caller.",
            MOONSTAFF = "They accepted our offer.",
        },
        MOONDIAL = 
        {
			GENERIC = "Tells us when they're the most active.",
			NIGHT_NEW = "They are woven by darkness.",
			NIGHT_WAX = "The time of reunion is close.",
			NIGHT_FULL = "I miss you, my darling.",
			NIGHT_WANE = "You go away, the same as before.",
			CAVE = "It doesn't reach down there.",
			WEREBEAVER = "Brr.", --woodie specific
			GLASSED = "I hope you are safe, wherever you are.",
        },
		THULECITE = "How we used to sculpt and play around this, remember?",
		ARMORRUINS = "It has never failed us.",
		ARMORSKELETON = "I'd rather my own bones.",
		SKELETONHAT = "Now you are as faceless as I am.",
		RUINS_BAT = "Our weapons, mostly for defense.",
		RUINSHAT = "A crown... We used to wear it long ago.",
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "Calm before the storm.",
            WARN = "It's starting.",
            WAXING = "The nightmare cycle is about to start.",
            STEADY = "I will never forgive them for taking you away from me.",
            WANING = "It's going away.",
            DAWN = "As it leaves, I stay here.",
            NOMAGIC = "...",
		},
		BISHOP_NIGHTMARE = "Sick and twisted!",
		ROOK_NIGHTMARE = "Bring it on big guy!",
		KNIGHT_NIGHTMARE = "I'll play you like an instrument!",
		MINOTAUR = "Hi, it's me, but without my facial features.",
		SPIDER_DROPPER = "It has six legs I have two, how is that fair?",
		NIGHTMARELIGHT = "Never worship the essence of madness.",
		NIGHTSTICK = "Zap zap!",
		GREENGEM = "The jewel transforms the matter.",
		MULTITOOL_AXE_PICKAXE = "Eh? Oh yes, the back scratcher!",
		ORANGESTAFF = "It has limited powers.",
		YELLOWAMULET = "It needs the fuel to work, sadly.",
		GREENAMULET = "I could use this for cheaper gem seedmaking.",
		SLURPERPELT = "I'd rather my digestion uninterrupted.",	

		SLURPER = "Fuzzy!",
		SLURPER_PELT = "No, just no.",
		ARMORSLURPER = "I'd rather my digestion uninterrupted.",
		ORANGEAMULET = "I know a better one.",
		YELLOWSTAFF = "Call upon the skies.",
		YELLOWGEM = "The jewel shines brightly when you rub it.",
		ORANGEGEM = "This one is used in transportation.",
        OPALSTAFF = "I feel their presence.",
        OPALPRECIOUSGEM = "I miss you, king.",
        TELEBASE = 
		{
			VALID = "The landing field is ready.",
			GEMS = "The gems will allow us to warp back here.",
		},
		GEMSOCKET = 
		{
			VALID = "Ready.",
			GEMS = "The jewels, bring them over.",
		},
		STAFFLIGHT = "A bit of comfort, in this prowling tomb.",
        STAFFCOLDLIGHT = "Saddening whispers of the moon.",

        ANCIENT_ALTAR = "I built this.",

        ANCIENT_ALTAR_BROKEN = "They destroyed my art.",

        ANCIENT_STATUE = "A memorial, a crescendo of hysteria.",

        LICHEN = "Snack.",
		CUTLICHEN = "A quick bite.",

		CAVE_BANANA = "Yummy snack.",
		CAVE_BANANA_COOKED = "We used those in salads back in the days.",
		CAVE_BANANA_TREE = "We had this at the altar's garden.",
		ROCKY = "Hello friends.",
		
		COMPASS =
		{
			GENERIC="How crude, does this even function?",
			N = "North.",
			S = "South.",
			E = "East.",
			W = "West.",
			NE = "Northeast.",
			SE = "Southeast.",
			NW = "Northwest.",
			SW = "Southwest.",
		},

        HOUNDSTOOTH = "Quite sharp!",
        ARMORSNURTLESHELL = "Interesting find.",
        BAT = "That's new.",
        BATBAT = "Is it a waving stick?",
        BATWING = "It has a bit of magic within.",
        BATWING_COOKED = "Sustain.",
        BATCAVE = "Go back home, bat.",
        BEDROLL_FURRY = "It's so warm and comfy.",
        BUNNYMAN = "Evening.",
        FLOWER_CAVE = "Light makes it glow.",
        GUANO = "Manure.",
        LANTERN = "Put it up on a pole.",
        LIGHTBULB = "It's strangely tasty looking.",
        MANRABBIT_TAIL = "I feel a lil' better when I hold one.",
        MUSHROOMHAT = "This would grow on rotting corpses.",
        MUSHROOM_LIGHT2 =
        {
            ON = "On.",
            OFF = "Off.",
            BURNT = "Burnt.",
        },
        MUSHROOM_LIGHT =
        {
            ON = "On.",
            OFF = "Off.",
            BURNT = "Burnt.",
        },
        SLEEPBOMB = "That was barely worth the hassle.",
        MUSHROOMBOMB = "Careful.",
        SHROOM_SKIN = "Quite literally decay.",
        TOADSTOOL_CAP =
        {
            EMPTY = "Not here.",
            INGROUND = "The frog.",
            GENERIC = "Cut it.",
        },
        TOADSTOOL =
        {
            GENERIC = "Chonky boy, you grew a tad.",
            RAGE = "Reee!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "How annoying.",
            BURNT = "Better.",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "Quite tall indeed.",
            BLOOM = "It smells horrible.",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "A big mushroom growing around.",
            BLOOM = "It's spreading.",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "A magic mushroom?",
            BLOOM = "It's trying to reproduce.",
        },
        MUSHTREE_TALL_WEBBED = "The spiders thought this one was important.",
        SPORE_TALL =
        {
            GENERIC = "It's just drifting around.",
            HELD = "I'll keep a little light in my pocket.",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "Sporey.",
            HELD = "I'll keep a little light in my pocket.",
        },
        SPORE_SMALL =
        {
            GENERIC = "It's just vibing.",
            HELD = "I'll keep a little light in my pocket.",
        },
        RABBITHOUSE =
        {
            GENERIC = "Rabbit house.",
            BURNT = "Cruel, as life is.",
        },
        SLURTLE = "You produce something I need.",
        SLURTLE_SHELLPIECES = "This could make a neat piece of decor.",
        SLURTLEHAT = "I should give it to someone else.",
        SLURTLEHOLE = "Their den.",
        SLURTLESLIME = "I need this for my craft!",
        SNURTLE = "Must be the weak link of the herd.",
        SPIDER_HIDER = "Stop hiding!",
        SPIDER_SPITTER = "How dare you.",
        SPIDERHOLE = "Webbing almost as old as I am.",
        SPIDERHOLE_ROCK = "Webbing almost as old as I am.",
        STALAGMITE = "There might be something of value inside.",
        STALAGMITE_TALL = "Rocks... rocks everywhere.",

        TURF_CARPETFLOOR = "I wouldn't want it anywhere in my home.",
        TURF_CHECKERFLOOR = "Shapes and colors.",
        TURF_DIRT = "Terra maxima.",
        TURF_FOREST = "Terra maxima.",
        TURF_GRASS = "Terra maxima.",
        TURF_MARSH = "Terra maxima.",
        TURF_METEOR = "A piece where you walk.",
        TURF_PEBBLEBEACH = "Now what?",
        TURF_ROAD = "Hastily cobbled stones.",
        TURF_ROCKY = "Terra maxima.",
        TURF_SAVANNA = "Terra maxima.",
        TURF_WOODFLOOR = "For some reason this I think is the best one.",

		TURF_CAVE="A piece of our land.",
		TURF_FUNGUS="A piece of our land.",
		TURF_FUNGUS_MOON = "Our forest, soaked in your tears.",
		TURF_ARCHIVE = "Home.",
		TURF_SINKHOLE="A piece of our land.",
		TURF_UNDERROCK="A piece of our land.",
		TURF_MUD="A piece of our land.",

		TURF_DECIDUOUS = "Terra maxima.",
		TURF_SANDY = "Terra maxima.",
		TURF_BADLANDS = "Terra maxima.",
		TURF_DESERTDIRT = "Terra maxima.",
		TURF_FUNGUS_GREEN = "A piece of our land",
		TURF_FUNGUS_RED = "A piece of our land",
		TURF_DRAGONFLY = "It's still warm.",

        TURF_SHELLBEACH = "Terra maxima.",

		TURF_RUINSBRICK = "A piece of our land.",
		TURF_RUINSBRICK_GLOW = "A piece of our land.",
		TURF_RUINSTILES = "A piece of our land.",
		TURF_RUINSTILES_GLOW = "A piece of our land.",
		TURF_RUINSTRIM = "A piece of our land.",
		TURF_RUINSTRIM_GLOW = "A piece of our land.",

        TURF_MONKEY_GROUND = "Terra maxima.",

        TURF_CARPETFLOOR2 = "It's surprisingly soft.",
        TURF_MOSAIC_GREY = "Terra maxima.",
        TURF_MOSAIC_RED = "Terra maxima.",
        TURF_MOSAIC_BLUE = "Terra maxima.",

		POWCAKE = "It never expires, how I wish.",
        CAVE_ENTRANCE = "Time to go.",
        CAVE_ENTRANCE_RUINS = "Time to go back home.",
       
       	CAVE_ENTRANCE_OPEN = 
        {
            GENERIC = "Hop.",
            OPEN = "Let's go.",
            FULL = "How?",
        },
        CAVE_EXIT = 
        {
            GENERIC = "I'd rather sit here.",
            OPEN = "I don't want to leave yet.",
            FULL = "The surface is too crowded!",
        },

		MAXWELLPHONOGRAPH = "The music, it drives you insane.",
		BOOMERANG = "Catch!",
		PIGGUARD = "You're quite dedicated to your role.",
		ABIGAIL =
		{
            LEVEL1 =
            {
                "A husk, that tries to mimic a person.",
                "A husk, that tries to mimic a person.",
            },
            LEVEL2 =
            {
                "A husk, that tries to mimic a person.",
                "A husk, that tries to mimic a person.",
            },
            LEVEL3 =
            {
                "A husk, that tries to mimic a person.",
                "A husk, that tries to mimic a person.",
            },
		},
		ADVENTURE_PORTAL = "Not this.",
		AMULET = "This could save another's life.",
		ANIMAL_TRACK = "Time for a hunt.",
		ARMORGRASS = "Even my old bones are better.",
		ARMORMARBLE = "I'll keep my jaw with this.",
		ARMORWOOD = "That will do.",
		ARMOR_SANITY = "Protect your flesh, lose your mind.",
		ASH =
		{
			GENERIC = "The result of combustion.",
			REMAINS_GLOMMERFLOWER = "The flower was consumed by fire.",
			REMAINS_EYE_BONE = "The eyebone was consumed by fire.",
			REMAINS_THINGIE = "Gone.",
		},
		AXE = "I remember when I had to do it myself... Oh wait I still do.",
		BABYBEEFALO = 
		{
			GENERIC = "The small one.",
		    SLEEPING = "Sleep.",
        },
        BUNDLE = "Quite an useful piece of equipment.",
        BUNDLEWRAP = "Convenient storage.",
		BACKPACK = "Feeble woven storage, useful for a few elements.",
		BACONEGGS = "Matter to sustain.",
		BANDAGE = "It's of no use to me.",
		BASALT = "Strong formation.",
		BEARDHAIR = "I'm not leaving my crumbles everywhere, am I?",
		BEARGER = "The second one of the seasonal lovers.",
		BEARGERVEST = "I feel bad for showing this to your sir this winter.",
		ICEPACK = "It's like winter and fall go really well together.",
		BEARGER_FUR = "It smells very earthy, like birchnuts.",
		BEDROLL_STRAW = "To rest my bones on.",
		BEEQUEEN = "Royalty? Oh please!",
		BEEQUEENHIVE = 
		{
			GENERIC = "To summon the big one.",
			GROWING = "Regenerating.",
		},
        BEEQUEENHIVEGROWN = "Smash it to bits.",
        BEEGUARD = "Bzz bzz.",
        HIVEHAT = "This crown isn't as worthy as my old one.",
        MINISIGN =
        {
            GENERIC = "I love the arts!",
            UNDRAWN = "Empty canvas.",
        },
        MINISIGN_ITEM = "Put it somewhere.",
		BEE =
		{
			GENERIC = "Bzz.",
			HELD = "Bzz!",
		},
		BEEBOX =
		{
			READY = "Ready for harvest.",
			FULLHONEY = "Honey overflows.",
			GENERIC = "Bzz!",
			NOHONEY = "It's empty.",
			SOMEHONEY = "Patience.",
			BURNT = "Their house is gone.",
		},
		MUSHROOM_FARM =
		{
			STUFFED = "That's a lot of them!",
			LOTS = "Bouquet of mushrooms.",
			SOME = "A few of them have appeared.",
			EMPTY = "None.",
			ROTTEN = "The log is dead.",
			BURNT = "We could've prevented that.",
			SNOWCOVERED = "It does not function in the cold.",
		},
		BEEFALO =
		{
			FOLLOWER = "You are my friend now.",
			GENERIC = "What a boofy lad!",
			NAKED = "You've been stripped.",
			SLEEPING = "Asleep.",
            --Domesticated states:
            DOMESTICATED = "Well-groomed.",
            ORNERY = "He's angry.",
            RIDER = "I too run from my issues.",
            PUDGY = "Good cuddle companion.",
            MYPARTNER = "Beefy boy.",
		},

		BEEFALOHAT = "This'll scratch my eye.",
		BEEFALOWOOL = "This is not soft fur.",
		BEEHAT = "The net doesn't fit on me.",
        BEESWAX = "It preserves the matter.",
		BEEHIVE = "Home of the bzz's!",
		BEEMINE = "Meager weapon, might still have an use.",
		BEEMINE_MAXWELL = "This man is insane!",
		BERRIES = "Best in a salad dish.",
		BERRIES_COOKED = "It's all goopy now...",
        BERRIES_JUICY = "Rotting as we speak.",
        BERRIES_JUICY_COOKED = "Now they'll decay even faster.",
		BERRYBUSH =
		{
			BARREN = "Give it fertilizer!",
			WITHERED = "The soil is too dry.",
			GENERIC = "It'll grow salad worthy elements.",
			PICKED = "They'll grow back.",
			DISEASED = "The plague is back.",
			DISEASING = "The plague is back.",
			BURNING = "On fire.",
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "Barren.",
			WITHERED = "It's dehydrated.",
			GENERIC = "More fruit, rots faster.",
			PICKED = "No fruit now.",
			DISEASED = "The plague is back.",
			DISEASING = "The plague is back.",
			BURNING = "How quaint.",
		},
		BIGFOOT = "The giant is coming.",
		BIRDCAGE =
		{
			GENERIC = "To trap another soul inside.",
			OCCUPIED = "I am too, in a state of isolation.",
			SLEEPING = "You sleep there somewhere too.",
			HUNGRY = "Feed them good.",
			STARVING = "They want to feast.",
			DEAD = "Separation.",
			SKELETON = "Just bones now.",
		},
		BIRDTRAP = "From the sky into my hands.",
		CAVE_BANANA_BURNT = "Ashes.",
		BIRD_EGG = "Eggceptionally smooth.",
		BIRD_EGG_COOKED = "Smoldered unbirthed bird.",
		BISHOP = "I want to smash you to pieces and steal your eye.",
		BLOWDART_FIRE = "To set ablaze.",
		BLOWDART_SLEEP = "To call upon Morpheus.",
		BLOWDART_PIPE = "To slay my foes.",
		BLOWDART_YELLOW = "To smite.",
		BLUEAMULET = "Calls the cold, quite inefficient, though.",
		BLUEGEM = "That jewel is not refined enough.",
		BLUEPRINT = 
		{ 
            COMMON = "A scheme.",
            RARE = "Luxurious scheme.",
        },
        SKETCH = "A fine piece of art.",
		COOKINGRECIPECARD = 
		{
			GENERIC = "A piece of a cookbook.",
		},
		BLUE_CAP = "My favourite one by far.",
		BLUE_CAP_COOKED = "Now I've wasted it.",
		BLUE_MUSHROOM =
		{
			GENERIC = "A blue one, spreading.",
			INGROUND = "Bloomed from once wise minds.",
			PICKED = "Picked the flower, now the earth shall regenerate.",
		},
		BOARDS = "Refined piece of organic material.",
		BONESHARD = "To rebuild myself, and live to see the other side.",
		BONESTEW = "Broth of flesh.",
		BUGNET = "A simple tool to catch bugs.",
		BUSHHAT = "That's quite a silly hat!",
		BUTTER = "Building blocks for a good cake!",
		BUTTERFLY =
		{
			GENERIC = "I miss seeing my king.",
			HELD = "Now grow.",
		},
		BUTTERFLYMUFFIN = "Cruel practice.",
		BUTTERFLYWINGS = "I am sorry, dear.",
		BUZZARD = "They feast upon the dead.",

		SHADOWDIGGER = "This magic doesn't serve that purpose.",
        SHADOWDANCER = "...I am shaken.",

		CACTUS = 
		{
			GENERIC = "I love how it tastes with the spikes.",
			PICKED = "I'll come back for more.",
		},
		CACTUS_MEAT_COOKED = "Why did we remove the spikes?",
		CACTUS_MEAT = "The spikes are just for adding flavour.",
		CACTUS_FLOWER = "I used to have a bouquet in my chamber.",

		COLDFIRE =
		{
			EMBERS = "It's going to disappear soon.",
			GENERIC = "Sure beats darkness.",
			HIGH = "The flames grow high!",
			LOW = "It's dying slowly.",
			NORMAL = "Nice and comfy.",
			OUT = "Well, that's over.",
		},
		CAMPFIRE =
		{
			EMBERS = "It's going to disappear soon.",
			GENERIC = "Sure beats darkness.",
			HIGH = "The flames grow high!",
			LOW = "It's dying slowly.",
			NORMAL = "Nice and comfy.",
			OUT = "Well, that's over.",
		},
		CANE = "Adore a lovely walk.",
		CATCOON = "Little devil!",
		CATCOONDEN = 
		{
			GENERIC = "Homes of the little demons.",
			EMPTY = "They've run out of free revives.",
		},
		CATCOONHAT = "I adore the fluffiness of that one!",
		COONTAIL = "For a scarf or a vest?",
		CARROT = "A bit of a snack.",
		CARROT_COOKED = "Pretty juicy!",
		CARROT_PLANTED = "Gift of the earth.",
		CARROT_SEEDS = "It's a carrot seed.",
		CARTOGRAPHYDESK =
		{
			GENERIC = "For map making.",
			BURNING = "So much for that.",
			BURNT = "Done retrieving colonized land for now.",
		},
		WATERMELON_SEEDS = "It's a melon seed.",
		CAVE_FERN = "A simple fern, decorative options.",
		CHARCOAL = "A fine piece of drawing material.",
        CHESSPIECE_PAWN = "Peon.",
        CHESSPIECE_ROOK =
        {
            GENERIC = "My precious baby boy.",
            STRUGGLE = "The chess pieces are moving themselves!",
        },
        CHESSPIECE_KNIGHT =
        {
            GENERIC = "Horse.",
            STRUGGLE = "The chess pieces are moving themselves!",
        },
        CHESSPIECE_BISHOP =
        {
            GENERIC = "Annoyance.",
            STRUGGLE = "The chess pieces are moving themselves!",
        },
        CHESSPIECE_MUSE = "Queen.",
        CHESSPIECE_FORMAL = "King.",
        CHESSPIECE_HORNUCOPIA = "Can't relate.",
        CHESSPIECE_PIPE = "Monument of addiction.",
        CHESSPIECE_DEERCLOPS = "Sorry...",
        CHESSPIECE_BEARGER = "Sorry...",
        CHESSPIECE_MOOSEGOOSE =
        {
            "Sorry not sorry, your children are annoying.",
        },
        CHESSPIECE_DRAGONFLY = "I ate your loot, bug.",
		CHESSPIECE_MINOTAUR = "My baby boy!",
        CHESSPIECE_BUTTERFLY = "I can't look at it for too long.",
        CHESSPIECE_ANCHOR = "That seems unnecessary.",
        CHESSPIECE_MOON = "It's an ode to my longing, I think of you, my dear king.",
        CHESSPIECE_CARRAT = "Society.",
        CHESSPIECE_MALBATROSS = "Big bird, not worth the hunt.",
        CHESSPIECE_CRABKING = "I hate to be reminded of your existence.",
        CHESSPIECE_TOADSTOOL = "Finally got you down.",
        CHESSPIECE_STALKER = "Father.",
        CHESSPIECE_KLAUS = "The big one, bringing me free stuff, hehe.",
        CHESSPIECE_BEEQUEEN = "I hate to be reminded of your existence.",
        CHESSPIECE_ANTLION = "Beauty.",
        CHESSPIECE_BEEFALO = "The boofy!",
		CHESSPIECE_KITCOON = "Little demons!",
		CHESSPIECE_CATCOON = "Demonic floofies.",
        CHESSPIECE_GUARDIANPHASE3 = "Home guard.",
        CHESSPIECE_EYEOFTERROR = "Eye see you!",
        CHESSPIECE_TWINSOFTERROR = "The twins of pain.",
		CHESSPIECE_DAYWALKER = "The fighter is trapped in stone.",
        CHESSPIECE_DEERCLOPS_MUTATED = "Vanquished once again.",
        CHESSPIECE_WARG_MUTATED = "The pack was taken down.",
        CHESSPIECE_BEARGER_MUTATED = "My poor poor fluffy bear...",

        CHESSJUNK1 = "A pile of metal bones.",
        CHESSJUNK2 = "Another pile of metal bones. ",
        CHESSJUNK3 = "Even more metal bones.",
		CHESTER = "Best boy since the ancient times.",
		CHESTER_EYEBONE =
		{
			GENERIC = "Can relate.",
			WAITING = "The creature was murdered in cold blood.",
		},
		COOKEDMANDRAKE = "Love it.",
		COOKEDMEAT = "Piece of flesh.",
		COOKEDMONSTERMEAT = "Monster flesh, edible.",
		COOKEDSMALLMEAT = "A fine snack.",
		COOKPOT =
		{
			COOKING_LONG = "Cooking is a slow and admirable art.",
			COOKING_SHORT = "Anyyyyy second now.",
			DONE = "There it is.",
			EMPTY = "The art of cooking.",
			BURNT = "Someone lost control of the kitchen.",
		},
		CORN = "It's corn! It has the juice!",
		CORN_COOKED = "Couldn't think of more wonderful thing!",
		CORN_SEEDS = "It's a corn seed.",
        CANARY =
		{
			GENERIC = "Bird of paradise.",
			HELD = "Squeeze it!",
		},
        CANARY_POISONED = "It has caught a bad case of the sniffles.",

		CRITTERLAB = "Adoption is an option.",
        CRITTER_GLOMLING = "Your name shall be Amon.",
        CRITTER_DRAGONLING = "Your name shall be Beelzebub.",
		CRITTER_LAMB = "Your name shall be Baphomet.",
        CRITTER_PUPPY = "Your name shall be Cerberus.",
        CRITTER_KITTEN = "Your name shall be Asmodeus.",
        CRITTER_PERDLING = "Your name shall be Azazel.",
		CRITTER_LUNARMOTHLING = "Your name shall be Abaddon.",

		CROW =
		{
			GENERIC = "Intelligent fellas.",
			HELD = "It's warm and shaking.",
		},
		CUTGRASS = "Smoke it, smell it.",
		CUTREEDS = "For scrolls!",
		CUTSTONE = "Primitive construction piece.",
		DEADLYFEAST = "Yummy.",
		DEER =
		{
			GENERIC = "This creature understands me.",
			ANTLER = "Fine antlers, mind if I borrow some?",
		},
        DEER_ANTLER = "Marvelous structure.",
        DEER_GEMMED = "It uses my own tactics against me!",
		DEERCLOPS = "Hello big guy, how's your man doing?",
		DEERCLOPS_EYEBALL = "Eyes are a window to the soul.",
		EYEBRELLAHAT =	"Someone else might have an use for it.",
		DEPLETED_GRASS =
		{
			GENERIC = "All scorched by heat.",
		},
        GOGGLESHAT = "My masks are more efficient.",
        DESERTHAT = "What cruel world we must live in to wear this.",
        ANTLIONHAT = "Too bad I can't fit it over my shell.",
		DEVTOOL = "Silly little tool!",
		DEVTOOL_NODEV = "Sire would be quite upset about that.",
		DIRTPILE = "Let's uncover that shall we?",
		DIVININGROD =
		{
			COLD = "Not here.",
			GENERIC = "It leads.",
			HOT = "I sense it.",
			WARM = "Good, closer.",
			WARMER = "Almost there.",
		},
		DIVININGRODBASE =
		{
			GENERIC = "I wonder.",
			READY = "It needs the rod.",
			UNLOCKED = "Working.",
		},
		DIVININGRODSTART = "That rod, it leads.",
		DRAGONFLY = "I want to bite you real bad.",
		ARMORDRAGONFLY = "The scales could've been something much more useful.",
		DRAGON_SCALES = "I wonder how they taste like?",
		DRAGONFLYCHEST = "Precious treasury.",
		DRAGONFLYFURNACE = 
		{
			HAMMERED = "I don't think it's supposed to look like that.",
			GENERIC = "Produces a lot of heat, but not much light.", --no gems
			NORMAL = "Is it winking at me?", --one gem
			HIGH = "Lava melting warmth inbound.", --two gems
		},
        
        HUTCH = "Best girl since the ancient times.",
        HUTCH_FISHBOWL =
        {
            GENERIC = "The bowl is a bit too small for the fish.",
            WAITING = "The fish is dead.",
        },
		LAVASPIT = 
		{
			HOT = "Hot!",
			COOL = "Cool.",
		},
		LAVA_POND = "Would boil even the toughest stones.",
		LAVAE = "Fireling.",
		LAVAE_COCOON = "Firelingn't.",
		LAVAE_PET = 
		{
			STARVING = "Starved fireling...",
			HUNGRY = "Hungry fireling.",
			CONTENT = "Happy fireling.",
			GENERIC = "Precious fireling.",
		},
		LAVAE_EGG = 
		{
			GENERIC = "Warm it.",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "Cold.",
			COMFY = "Happy egg.",
		},
		LAVAE_TOOTH = "It follows.",

		DRAGONFRUIT = "We feast on dragons, how luxurious.",
		DRAGONFRUIT_COOKED = "Juicy dragon flesh.",
		DRAGONFRUIT_SEEDS = "It's a dragon seed.",
		DRAGONPIE = "Now this is an offering.",
		DRUMSTICK = "Meat from avians.",
		DRUMSTICK_COOKED = "This one is better for the mortals.",
		DUG_BERRYBUSH = "A bush, for a garden.",
		DUG_BERRYBUSH_JUICY = "A bush suited for a garden.",
		DUG_GRASS = "Give it to mother earth.",
		DUG_MARSH_BUSH = "Give it to mother earth.",
		DUG_SAPLING = "Give it to mother earth.",
		DURIAN = "It's a normal fruit.",
		DURIAN_COOKED = "I enjoy the shell of this one.",
		DURIAN_SEEDS = "It's a durian seed.",
		EARMUFFSHAT = "Now that's just cruel.",
		EGGPLANT = "It's squishy.",
		EGGPLANT_COOKED = "We cut it in half.",
		EGGPLANT_SEEDS = "It's an eggplant seed.",
		
		ENDTABLE = 
		{
			BURNT = "A burnt vase on a burnt table.",
			GENERIC = "Still nature, or a decoration.",
			EMPTY = "A flower, there.",
			WILTED = "Beauty fades, everything in time.",
			FRESHLIGHT = "My little night light.",
			OLDLIGHT = "In the darkness we scream.", -- will be wilted soon, light radius will be very small at this point
		},
		DECIDUOUSTREE = 
		{
			BURNING = "The flames, hungrily devour.",
			BURNT = "All burnt.",
			CHOPPED = "Stump.",
			POISON = "Leshy, how good to see you.",
			GENERIC = "Snack tree.",
		},
		ACORN = "A snack?",
        ACORN_SAPLING = "A snack tree for snacks.",
		ACORN_COOKED = "SNACK!",
		BIRCHNUTDRAKE = "Nutty one.",
		EVERGREEN =
		{
			BURNING = "The flames, hungrily devour.",
			BURNT = "All burnt.",
			CHOPPED = "Stump.",
			GENERIC = "Grows, the forest up above.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "The flames, hungrily devour.",
			BURNT = "All burnt.",
			CHOPPED = "Stump.",
			GENERIC = "Spreads, the forest up above.",
		},
		TWIGGYTREE = 
		{
			BURNING = "The flames, hungrily devour.",
			BURNT = "All burnt.",
			CHOPPED = "Stump.",
			GENERIC = "Weak tree.",			
			DISEASED = "Sick.",
		},
		TWIGGY_NUT_SAPLING = "It doesn't need any help to grow.",
        TWIGGY_OLD = "This one looks quite dead.",
		TWIGGY_NUT = "Stick tree, for my pocket.",
		EYEPLANT = "It lures in things horribly.",
		INSPECTSELF = "Wonder, still wandering.",
		FARMPLOT =
		{
			GENERIC = "For gifts of the earth mother.",
			GROWING = "Grow, the gift of life!",
			NEEDSFERTILIZER = "Repair the soil.",
			BURNT = "Ashes?",
		},
		FEATHERHAT = "Hat made of the avians coating.",
		FEATHER_CROW = "Feather of wisdom.",
		FEATHER_ROBIN = "Feather of arson.",
		FEATHER_ROBIN_WINTER = "Feather of war.",
		FEATHER_CANARY = "Feather of grace.",
		FEATHERPENCIL = "Make art, you shall!",
        COOKBOOK = "Learn the finer details of the art of cooking!",
		FEM_PUPPET = "She's trapped!",
		FIREFLIES =
		{
			GENERIC = "Sparkling tiny astral bodies.",
			HELD = "They make my heart warm.",
		},
		FIREHOUND = "The beast of hell.",
		FIREPIT =
		{
			EMBERS = "Warmth that embraces, death that swallows.",
			GENERIC = "Little light.",
			HIGH = "Watch the light climb up higher.",
			LOW = "Weakens the flame.",
			NORMAL = "It burns.",
			OUT = "Out.",
		},
		COLDFIREPIT =
		{
			EMBERS = "Cold that forgets, life that ends quickly.",
			GENERIC = "Little light.",
			HIGH = "Watch the light climb up higher.",
			LOW = "Weakens the flame.",
			NORMAL = "It burns.",
			OUT = "Out.",
		},
		FIRESTAFF = "Tinder-box, in a form of a torch.",
		FIRESUPPRESSOR = 
		{	
			ON = "The machine works.",
			OFF = "The machine is asleep.",
			LOWFUEL = "Low fuel.",
		},

		FISH = "It's a simple aquatic animal.",
		FISHINGROD = "A brutal way of distrust.",
		FISHSTICKS = "Food from the seas.",
		FISHTACOS = "The shell breaks off.",
		FISH_COOKED = "Fishy popsicle.",
		FLINT = "For tools of basic efficiency.",
		FLOWER = 
		{
            GENERIC = "From where the world grows.",
            ROSE = "Death to romance.",
        },
        FLOWER_WITHERED = "Curls up and dies.",
		FLOWERHAT = "Wear a limited beauty...",
		FLOWER_EVIL = "This one was corrupted.",
		FOLIAGE = "It's a plant.",
		FOOTBALLHAT = "Really not for me.",
        FOSSIL_PIECE = "Sturdy material, good for crafts.",
        FOSSIL_STALKER =
        {
			GENERIC = "Missing bones.",
			FUNNY = "It is not correctly put.",
			COMPLETE = "It's friend shaped.",
        },
        STALKER = "It's friend shaped!",
        STALKER_ATRIUM = "Hello, my old friend.",
        STALKER_MINION = "I've got a follower of my own!",
        THURIBLE = "I've come to talk with you again.",
        ATRIUM_OVERGROWTH = "Run.",
		FROG =
		{
			DEAD = "Ribbitn't.",
			GENERIC = "Amphibian.",
			SLEEPING = "Its eyes go inside the skull.",
		},
		FROGGLEBUNWICH = "It's still twitching.",
		FROGLEGS = "I'll give this to a friend.",
		FROGLEGS_COOKED = "Crude cooking.",
		FRUITMEDLEY = "Sweetness in a cup!",
		FURTUFT = "Black and white fur.", 
		GEARS = "So the cogs and wheels may turn.",
		GHOST = "I am the husk of myself, yet I am in better shape than you.",
		GOLDENAXE = "I could refine it further.",
		GOLDENPICKAXE = "I see they appreciate rich tools like us.",
		GOLDENPITCHFORK = "It's quite useful in a way.",
		GOLDENSHOVEL = "How is that sturdier than the one made from flint?",
		GOLDNUGGET = "I wish I could eat it.",
		GRASS =
		{
			BARREN = "It needs poop.",
			WITHERED = "It's not going to grow back while it's so hot.",
			BURNING = "That's burning fast!",
			GENERIC = "The simplest of them all.",
			PICKED = "It was cut down in the prime of its life.",
			DISEASED = "It looks pretty sick.",
			DISEASING = "Err, something's not right.",
		},
		GRASSGEKKO = 
		{
			GENERIC = "Magnificent, run till your skin'll turn grey.",	
			DISEASED = "Sickness got it.",
		},
		GREEN_CAP = "Insanity and cure in one!",
		GREEN_CAP_COOKED = "It's lost it's meaning.",
		GREEN_MUSHROOM =
		{
			GENERIC = "It's a mushroom.",
			INGROUND = "It's sleeping.",
			PICKED = "I wonder if it will come back?",
		},
		GUNPOWDER = "It looks like pepper.",
		HAMBAT = "Beat the flesh with the flesh of the other!",
		HAMMER = "Smash and destroy... Not my favourite.",
		HEALINGSALVE = "I could turn it into a nice polishing paste.",
		HEATROCK =
		{
			FROZEN = "Frozen as a... rock.",
			COLD = "A bit of cooling.",
			GENERIC = "Temperature storage.",
			WARM = "It's quite warm and cuddly... for a rock!",
			HOT = "May I feel warmth in my heart again.",
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
		HONEY = "A sugary snack!",
		HONEYCOMB = "I've stolen it from the bees.",
		HONEYHAM = "Sweet flesh.",
		HONEYNUGGETS = "Sweet cookery.",
		HORN = "I could use this to socket gems.",
		HOUND = "Part of the pack.",
		HOUNDCORPSE =
		{
			GENERIC = "Remains of the pack.",
			BURNING = "That amplified the smell.",
			REVIVING = "Neverending nightmare!",
		},
		HOUNDBONE = "May the bones lay to rest.",
		HOUNDMOUND = "Home of the pack!",
		ICEBOX = "Keep your food fresh, avoid the decay.",
		ICEHAT = "This is just a bad idea altogether.",
		ICEHOUND = "The ice ones of the pack.",
		INSANITYROCK =
		{
			ACTIVE = "It watched us go insane.",
			INACTIVE = "It wants us to forfeit our mind.",
		},
		JAMMYPRESERVES = "Now that's just an ugly display.",

		KABOBS = "Impaled flesh, for sustenance!",
		KILLERBEE =
		{
			GENERIC = "Bzz's are mad at us.",
			HELD = "This seems dangerous.",
		},
		KNIGHT = "Mechanical hazards.",
		KOALEFANT_SUMMER = "What a fat elephant.",
		KOALEFANT_WINTER = "I see you've adapted to the climate.",
		KOALEFANT_CARCASS = "Hunted down.",
		KRAMPUS = "Kin of the goats, senseless robbers.",
		KRAMPUS_SACK = "The spaciousness is a secret to most!",
		LEIF = "Protector of the forests!",
		LEIF_SPARSE = "Protector of the forests!",
		LIGHTER  = "Simple light source, at least it lasts a while.",
		LIGHTNING_ROD =
		{
			CHARGED = "It has gathered energy now!",
			GENERIC = "It'll keep my workshop safe.",
		},
		LIGHTNINGGOAT = 
		{
			GENERIC = "My kin. A bit less refined though.",
			CHARGED = "They do harness the lightnings well.",
		},
		LIGHTNINGGOATHORN = "...Sorry for that, I need it.",
		GOATMILK = "This feels wrong, but also right.",
		LITTLE_WALRUS = "Child of the tormentor.",
		LIVINGLOG = "It has useful magic properties I can use.",
		LOG =
		{
			BURNING = "Not the most efficient way of using it.",
			GENERIC = "A simple log of firewood.",
		},
		LUCY = "Bound for life to her owner.",
		LUREPLANT = "Leech off the life of others.",
		LUREPLANTBULB = "I can exploit it for my own now.",
		MALE_PUPPET = "He's trapped!",

		MANDRAKE_ACTIVE = "The screams echoes.",
		MANDRAKE_PLANTED = "It's resting in peace.",
		MANDRAKE = "I quite like this I dare say.",

        MANDRAKESOUP = "It's taking a little bath.",
        MANDRAKE_COOKED = "Poor guy.",
        MAPSCROLL = "It has nothing within!",
        MARBLE = "Good structure for sculpting!",
        MARBLEBEAN = "I appreciate this art of growing the unexpected.",
        MARBLEBEAN_SAPLING = "It's getting there!",
        MARBLESHRUB = "Makes sense to me.",
        MARBLEPILLAR = "Nice art, my dear.",
        MARBLETREE = "Grind it away.",
        MARSH_BUSH =
        {
			BURNT = "One less thorn patch to worry about.",
            BURNING = "That's burning fast!",
            GENERIC = "That could hurt a bit.",
            PICKED = "My shell...",
        },
        BURNT_MARSH_BUSH = "And it's gone.",
        MARSH_PLANT = "Plant.",
        MARSH_TREE =
        {
            BURNING = "Spikes and fire!",
            BURNT = "Not so fireproof, are you?",
            CHOPPED = "I've won!",
            GENERIC = "My shell doesn't fight back like this.",
        },
        MAXWELL = "I hate that guy.",
        MAXWELLHEAD = "I can see into his pores.",
        MAXWELLLIGHT = "I wonder how they work.",
        MAXWELLLOCK = "Looks almost like a key hole.",
        MAXWELLTHRONE = "That doesn't look very comfortable.",
        MEAT = "Fresh flesh, recently harvested!",
        MEATBALLS = "Packed flesh in a coat of... more flesh.",
        MEATRACK =
        {
            DONE = "It is done!",
            DRYING = "The flesh must leak the blood out.",
            DRYINGINRAIN = "Wetness is the opposite of dryness.",
            GENERIC = "I can use this to preserve the food.",
            BURNT = "That did speed up the process.",
            DONE_NOTMEAT = "It is done!",
            DRYING_NOTMEAT = "Getting there.",
            DRYINGINRAIN_NOTMEAT = "Rain, rain, go away.",
        },
        MEAT_DRIED = "Bloodless flesh.",
        MERM = "A walking simple minded being.",
        MERMHEAD =
        {
            GENERIC = "Now even for them, that's cruel.",
            BURNT = "Consumed by hellfire.",
        },
        MERMHOUSE =
        {
            GENERIC = "A rundown lair.",
            BURNT = "Nothing to live in left.",
        },
        MINERHAT = "My eyes can do that job better.",
        MONKEY = "I see you've adapted yourself to this place well.",
        MONKEYBARREL = "Home of the cheeky sirs.",
        MONSTERLASAGNA = "Refined monster flesh.",
        FLOWERSALAD = "A bowl of foliage.",
        ICECREAM = "I appreciate the cold feeling.",
        WATERMELONICLE = "Little snack!",
        TRAILMIX = "A snack made of snacks!!!",
        HOTCHILI = "A little bit of warmth in a dish.",
        GUACAMOLE = "I'd rather the cactus raw by itself.",
        MONSTERMEAT = "Monster flesh.",
        MONSTERMEAT_DRIED = "Refined monster flesh.",
        MOOSE = "Mother of the little monsters.",
        MOOSE_NESTING_GROUND = "They live here.",
        MOOSEEGG = "Egg of the monsters.",
        MOSSLING = "I must get rid of you, hellspawn.",
        FEATHERFAN = "A gust of wind on a rock doesn't do much.",
        MINIFAN = "Looks like a little toy, perhaps the young would be interested?",
        GOOSE_FEATHER = "Fluffy and soft!",
        STAFF_TORNADO = "Master the winds.",
        MOSQUITO =
        {
            GENERIC = "You won't get much from me.",
            HELD = "I've caught the little leech.",
        },
        MOSQUITOSACK = "I don't think they can suck moon mass.",
        MOUND =
        {
            DUG = "Mole hole is gone now.",
            GENERIC = "Let's see what you've gathered.",
        },
        NIGHTLIGHT = "Light of the madness fuel.",
        NIGHTMAREFUEL = "Overuse it and you'll feel it growing in you.",
        NIGHTSWORD = "Fight back, at the cost of your mind.",
        NITRE = "This can cause a spark if needed.",
        ONEMANBAND = "We should leave this one to the jester.",
        OASISLAKE =
		{
			GENERIC = "A lake of summer freshness.",
			EMPTY = "It's dry.",
		},
        PANDORASCHEST = "Let us see what's within!",
        PANFLUTE = "A flute that may leave some dead asleep.",
        PAPYRUS = "I could make a little doodle on this for sure.",
        WAXPAPER = "Paper of preservation.",
        PENGUIN = "They come to land in order to settle for winter.",
        PERD = "A bird hungry for simple food, not knowledge obviously.",
        PEROGIES = "Healthy meal, just not for me.",
        PETALS = "An art destroyed...",
        PETALS_EVIL = "I've purged the evil.",
        PHLEGM = "Quite squishy, I must think of a use one day.",
        PICKAXE = "Tools of flint, simple indeed.",
        PIGGYBACK = "This bag is quite heavy.",
        PIGHEAD =
        {
            GENERIC = "Looks like an offering of some sort.",
            BURNT = "The offering was cleansed.",
        },
        PIGHOUSE =
        {
            FULL = "They're home, hiding.",
            GENERIC = "A decently built house, for pigs as such.",
            LIGHTSOUT = "I must be a night stalker to them.",
            BURNT = "They didn't invest in fireproof materials.",
        },
        PIGKING = "You must be the king, how low have kings come...",
        PIGMAN =
        {
            DEAD = "I've slaughtered it.",
            FOLLOWER = "It is my ally for a time.",
            GENERIC = "A simple bipedal pig, capable of basic civilized interactions.",
            GUARD = "You're quite dedicated!",
            WEREPIG = "I see you're cursed by the moon, interesting!",
        },
        PIGSKIN = "Piece of leather, recently harvested.",
        PIGTENT = "Piggy place.",
        PIGTORCH = "They're quite good at keeping it ablaze.",
        PINECONE = "To grow a forest of my own.",
        PINECONE_SAPLING = "Grow, my child.",
        LUMPY_SAPLING = "Magic of birth.",
        PITCHFORK = "Tools of the devil, for the floor.",
        PLANTMEAT = "Feels like flesh but isn't as such.",
        PLANTMEAT_COOKED = "Cooked fake flesh?",
        PLANT_NORMAL =
        {
            GENERIC = "Leafy!",
            GROWING = "Guh! It's growing so slowly!",
            READY = "Mmmm. Ready to harvest.",
            WITHERED = "The heat killed it.",
        },
        POMEGRANATE = "I know a fluffy sir who'd enjoy this.",
        POMEGRANATE_COOKED = "You could spend an afternoon counting those.",
        POMEGRANATE_SEEDS = "Seeds of the hell fruit.",
        POND = "Quite deep for it's size!",
        POOP = "Piles of remains from mortal digestion.",
        FERTILIZER = "It is good for the soil.",
        PUMPKIN = "Our king would love this one.",
        PUMPKINCOOKIE = "The art of baking...",
        PUMPKIN_COOKED = "For a more refined palate.",
        PUMPKIN_LANTERN = "Is this a tradition here?",
        PUMPKIN_SEEDS = "It's a pumpkin seed.",
        PURPLEAMULET = "Jewels of the insane.",
        PURPLEGEM = "It amplifies the fuel's effect.",
        RABBIT =
        {
            GENERIC = "Taking a step outside of your home?",
            HELD = "I'll keep you.",
        },
        RABBITHOLE =
        {
            GENERIC = "Their den, their hole.",
            SPRING = "It has collapsed below the rain.",
        },
        RAINOMETER =
        {
            GENERIC = "Now that is a regression of knowledge.",
            BURNT = "Good riddance.",
        },
        RAINCOAT = "I'd rather my own items for that.",
        RAINHAT = "Doesn't fit above my head.",
        RATATOUILLE = "A clean variety of vegetables.",
        RAZOR = "I could harvest some of my shell with this.",
        REDGEM = "It is unrefined, I could amplify it.",
        RED_CAP = "A source of poison.",
        RED_CAP_COOKED = "I lost interest in it now.",
        RED_MUSHROOM =
        {
            GENERIC = "It's a mushroom.",
            INGROUND = "It's sleeping.",
            PICKED = "I wonder if it will come back?",
        },
        REEDS =
        {
            BURNING = "That's really burning!",
            GENERIC = "The unrefined elements of scrollmaking.",
            PICKED = "All the useful reeds have already been picked.",
        },
        RELIC = "Remember about the good times.",
        RUINS_RUBBLE = "Who did this?",
        RUBBLE = "Just bits and pieces of rock.",
        RESEARCHLAB =
        {
            GENERIC = "Is this a sculpture?",
            BURNT = "Gone.",
        },
        RESEARCHLAB2 =
        {
            GENERIC = "Doesn't beat my lab, but it is a start.",
            BURNT = "Gone.",
        },
        RESEARCHLAB3 =
        {
            GENERIC = "Magic, aimed towards the darkness.",
            BURNT = "Gone.",
        },
        RESEARCHLAB4 =
        {
            GENERIC = "That almost feels insulting to use, I'd rather my workshop.",
            BURNT = "Gone.",
        },
        RESURRECTIONSTATUE =
        {
            GENERIC = "Give them another chance.",
            BURNT = "Not much use anymore.",
        },
        RESURRECTIONSTONE = "They strike upon the soul to give it a body again.",
        ROBIN =
        {
            GENERIC = "Quite found of you avian.",
            HELD = "He likes my rib pocket.",
        },
        ROBIN_WINTER =
        {
            GENERIC = "Life in the frozen wastes.",
            HELD = "It's so soft.",
        },
        ROBOT_PUPPET = "They're trapped!",
        ROCK_LIGHT =
        {
            GENERIC = "A crusted over lava pit.",
            OUT = "Looks fragile.",
            LOW = "The lava's crusting over.",
            NORMAL = "Nice and comfy.",
        },
        CAVEIN_BOULDER =
        {
            GENERIC = "Pieces of the world, a heavy weight.",
            RAISED = "It's out of reach.",
        },
        ROCK = "A simple rock suited for manual labour.",
        PETRIFIED_TREE = "Like me, it has shelled itself in stones.",
        ROCK_PETRIFIED_TREE = "Like me, it has shelled itself in stones.",
        ROCK_PETRIFIED_TREE_OLD = "Like me, it has shelled itself in stones.",
        ROCK_ICE =
        {
            GENERIC = "Frozen in place, unable to move.",
            MELTED = "Where the ice forms overtime.",
        },
        ROCK_ICE_MELTED = "Where the ice forms overtime.",
        ICE = "I limited lifetime outside of good conditions.",
        ROCKS = "Basic materials, might need refining.",
        ROOK = "You can only go one way in life.",
        ROPE = "So things may hold in place.",
        ROTTENEGG = "A life, not even started and already gone.",
        ROYAL_JELLY = "Quite a sugary reward!",
        JELLYBEAN = "Refined honey, suitable for a bit of snacking.",
        SADDLE_BASIC = "For we may find a friend.",
        SADDLE_RACE = "A lightweight saddle so our friend doesn't feel our burden.",
        SADDLE_WAR = "It's to assume our fighting stance.",
        SADDLEHORN = "To remove their burden.",
        SALTLICK = "Oh my! Are we sure it's only for livestock?",
        BRUSH = "So we may soften the softness.",
		SANITYROCK =
		{
			ACTIVE = "They prefer the good minded beings.",
			INACTIVE = "Into hiding it went.",
		},
		SAPLING =
		{
			BURNING = "It is ablaze wildly.",
			WITHERED = "Dehydrated flora.",
			GENERIC = "Produces a decent amount of sticks.",
			PICKED = "We have plucked it clean.",
			DISEASED = "It looks pretty sick.",
			DISEASING = "Err, something's not right.",
		},
   		SCARECROW = 
   		{
			GENERIC = "An empty shell, made to represent us.",
			BURNING = "At least it cannot scream.",
			BURNT = "Good thing it wasn't really alive!",
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "Ahhh, my favourite art!",
			BLOCK = "Let's get to it!",
			SCULPTURE = "A successful job!",
			BURNT = "Who would destroy such a beauty...",
   		},
        SCULPTURE_KNIGHTHEAD = "You're missing a piece sir!",
		SCULPTURE_KNIGHTBODY = 
		{
			COVERED = "I found a part of you!",
			UNCOVERED = "Let's get you your face back.",
			FINISHED = "Whole again.",
			READY = "It wants to be free.",
		},
        SCULPTURE_BISHOPHEAD = "Hello mister.",
		SCULPTURE_BISHOPBODY = 
		{
			COVERED = "You're under this.",
			UNCOVERED = "I'll grant you your wholeness again.",
			FINISHED = "No need to thank me.",
			READY = "Let's get you free.",
		},
        SCULPTURE_ROOKNOSE = "You left your nose lying around!",
		SCULPTURE_ROOKBODY = 
		{
			COVERED = "Let's reveal your reality.",
			UNCOVERED = "Now let's find the rest.",
			FINISHED = "You are whole.",
			READY = "You wish for freedom.",
		},
        GARGOYLE_HOUND = "Frozen in place.",
        GARGOYLE_WEREPIG = "As I ended up.",
		SEEDS = "Life, spread into seeds.",
		SEEDS_COOKED = "New life won't sprout now.",
		SEWING_KIT = "I cannot fix myself that way sadly.",
		SEWING_TAPE = "I'd rather actual repairs than mending.",
		SHOVEL = "Dig below, where we were.",
		SILK = "Smooth piece of silk, useful for fabrics.",
		SKELETON = "Remains of another's attempt to live.",
		SCORCHED_SKELETON = "You've dealt with the wrong dragon it seems.",
		SKULLCHEST = "I'm not sure if I want to open it.",
		SMALLBIRD =
		{
			GENERIC = "Tiny attempt at living.",
			HUNGRY = "It is hungry.",
			STARVING = "They require a feast.",
			SLEEPING = "It is resting calmly.",
		},
		SMALLMEAT = "Small amount of flesh.",
		SMALLMEAT_DRIED = "Small bloodless flesh.",
		SPAT = "An animal of thick and unruly fur.",
		SPEAR = "Our weapons could do much better than this.",
		SPEAR_WATHGRITHR = "Her weapons of war.",
		WATHGRITHRHAT = "It's purely powered by belief.",
		SPIDER =
		{
			DEAD = "Gone.",
			GENERIC = "A being of herding.",
			SLEEPING = "They have lost their home.",
		},
		SPIDERDEN = "Home of the spiders.",
		SPIDEREGGSACK = "A portable sack of spiders.",
		SPIDERGLAND = "It might help me in polishing my gems.",
		SPIDERHAT = "Become one of them.",
		SPIDERQUEEN = "The maker of them all.",
		SPIDER_WARRIOR =
		{
			DEAD = "Good riddance!",
			GENERIC = "The protectors of the den.",
			SLEEPING = "Even the best warriors need rest.",
		},
		SPOILED_FOOD = "Decay.",
        STAGEHAND =
        {
			AWAKE = "Dancing towards the light.",
			HIDING = "They are trying to hide under the art.",
        },
        STATUE_MARBLE = 
        {
            GENERIC = "Quite a fancy one!",
            TYPE1 = "Headless as I am.",
            TYPE2 = "Interesting.",
            TYPE3 = "I wonder who the artist is.", --bird bath type statue
        },
		STATUEHARP = "It has lost its face.",
		STATUEMAXWELL = "Statue of an egomaniac.",
		STEELWOOL = "Those could harness energy well.",
		STINGER = "The bee's main defense.",
		STRAWHAT = "I'd rather my face than this.",
		STUFFEDEGGPLANT = "Vegetables, in other vegetables.",
		SWEATERVEST = "Senseless fashion of no value.",
		REFLECTIVEVEST = "A simple sunny defense.",
		HAWAIIANSHIRT = "And I believed fashion couldn't get worse.",
		TAFFY = "Refined sugar, let's not turn shugary now!",
		TALLBIRD = "They live to kill and protect their egg.",
		TALLBIRDEGG = "Life in a peculiar form.",
		TALLBIRDEGG_COOKED = "Cooked the life right out of it.",
		TURF_BEARD_RUG = "Can I make a gem floor myself?",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "It needs heat.",
			GENERIC = "It is trying to get out.",
			HOT = "They're overheating.",
			LONG = "It takes a while to escape.",
			SHORT = "They'll be out any second now.",
		},
		TALLBIRDNEST =
		{
			GENERIC = "This one wouldn't fit my socket.",
			PICKED = "It is empty.",
		},
		TEENBIRD =
		{
			GENERIC = "A decently grown bird.",
			HUNGRY = "They're hungry.",
			STARVING = "Hunger would drive them crazy.",
			SLEEPING = "It is doing the eepies.",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "It is time to go.",
			GENERIC = "It can transport us.",
			LOCKED = "There's still something missing.",
			PARTIAL = "We are working on it.",
		},
		TELEPORTATO_BOX = "This may control the whole universe.",
		TELEPORTATO_CRANK = "Crank.",
		TELEPORTATO_POTATO = "Odd shape.",
		TELEPORTATO_RING = "We'll fix it.",
		TELESTAFF = "Bring us elsewhere.",
		TENT = 
		{
			GENERIC = "A simple resting place.",
			BURNT = "Not so much resting now.",
		},
		SIESTAHUT = 
		{
			GENERIC = "Have a little nap.",
			BURNT = "Nap eliminated.",
		},
		TENTACLE = "From the earth below.",
		TENTACLESPIKE = "A simple but effective weapon.",
		TENTACLESPOTS = "What is left of them after the fight.",
		TENTACLE_PILLAR = "They are all connected.",
        TENTACLE_PILLAR_HOLE = "They act as wormholes for us.",
		TENTACLE_PILLAR_ARM = "Fear the rage of the tiny ones.",
		TENTACLE_GARDEN = "They're connected.",
		TOPHAT = "That doesn't make me look any better.",
		TORCH = "Hold the embers bright.",
		TRANSISTOR = "Primitive invention.",
		TRAP = "I wove it real tight.",
		TRAP_TEETH = "Effective defense mechanism.",
		TRAP_TEETH_MAXWELL = "Worthless.",
		TREASURECHEST = 
		{
			GENERIC = "Simple storage, but quite organised.",
			BURNT = "What a waste.",
		},
		TREASURECHEST_TRAP = "It leads somewhere.",
		SACRED_CHEST = 
		{
			GENERIC = "Whispers of the damned.",
			LOCKED = "It's passing its judgment.",
		},
		TREECLUMP = "It's almost like someone is trying to prevent me from going somewhere.",
		
		TRINKET_1 = "Melted.", --Melted Marbles
		TRINKET_2 = "Little music.", --Fake Kazoo
		TRINKET_3 = "The knot is stuck.", --Gord's Knot
		TRINKET_4 = "It must be some kind of religious artifact.", --Gnome
		TRINKET_5 = "Is it a little toy?", --Toy Rocketship
		TRINKET_6 = "Those could come in handy.", --Frazzled Wires
		TRINKET_7 = "Is that a weapon of sorts?", --Ball and Cup
		TRINKET_8 = "I don't get it.", --Rubber Bung
		TRINKET_9 = "They make up their clothes.", --Mismatched Buttons
		TRINKET_10 = "Are those Maxwell's?", --Dentures
		TRINKET_11 = "Is it saying the truth or just sitting there?", --Lying Robot
		TRINKET_12 = "It's soft.", --Dessicated Tentacle
		TRINKET_13 = "It must be some kind of religious artifact.", --Gnomette
		TRINKET_14 = "It's broken.", --Leaky Teacup
		TRINKET_15 = "...Maxwell left his stuff out again.", --Pawn
		TRINKET_16 = "...Maxwell left his stuff out again.", --Pawn
		TRINKET_17 = "A horrifying utensil fusion.", --Bent Spork
		TRINKET_18 = "Good carving.", --Trojan Horse
		TRINKET_19 = "It doesn't spin well.", --Unbalanced Top
		TRINKET_20 = "Ours is better.", --Backscratcher
		TRINKET_21 = "Beat these eggs.", --Egg Beater
		TRINKET_22 = "I have a weird wish to put this in my eye socket.", --Frayed Yarn
		TRINKET_23 = "I don't wear shoes.", --Shoehorn
		TRINKET_24 = "I think Wickerbottom had a cat.", --Lucky Cat Jar
		TRINKET_25 = "It's old as I am.", --Air Unfreshener
		TRINKET_26 = "Why would you even...", --Potato Cup
		TRINKET_27 = "Do they make mask hangers?", --Coat Hanger
		TRINKET_28 = "Pieces.", --Rook
        TRINKET_29 = "Pieces.", --Rook
        TRINKET_30 = "Defensive.", --Knight
        TRINKET_31 = "Defensive.", --Knight
        TRINKET_32 = "Spirits are lifted.", --Cubic Zirconia Ball
        TRINKET_33 = "The spiderboy might enjoy it.", --Spider Ring
        TRINKET_34 = "Let's make a wish.", --Monkey Paw
        TRINKET_35 = "Someone used it.", --Empty Elixir
        TRINKET_36 = "My jaw can't fit those.", --Faux fangs
        TRINKET_37 = "Rumors.", --Broken Stake
        TRINKET_38 = "I think it came from another world.", -- Binoculars Griftlands trinket
        TRINKET_39 = "I wonder where the other one is?", -- Lone Glove Griftlands trinket
        TRINKET_40 = "Holding it makes me feel like bartering.", -- Snail Scale Griftlands trinket
        TRINKET_41 = "It's a little warm to the touch.", -- Goop Canister Hot Lava trinket
        TRINKET_42 = "It's full of someone's childhood memories.", -- Toy Cobra Hot Lava trinket
        TRINKET_43= "It's not very good at jumping.", -- Crocodile Toy Hot Lava trinket
        TRINKET_44 = "It's a plant specimen.", -- Broken Terrarium ONI trinket
        TRINKET_45 = "It's picking up frequencies from another world.", -- Odd Radio ONI trinket
        TRINKET_46 = "I don't have anything to dry.", -- Hairdryer ONI trinket

        -- The numbers align with the trinket numbers above.
        LOST_TOY_1  = "Lost memories.",
        LOST_TOY_2  = "Lost memories.",
        LOST_TOY_7  = "Lost memories.",
        LOST_TOY_10 = "Lost memories.",
        LOST_TOY_11 = "Lost memories.",
        LOST_TOY_14 = "Lost memories.",
        LOST_TOY_18 = "Lost memories.",
        LOST_TOY_19 = "Lost memories.",
        LOST_TOY_42 = "Lost memories.",
        LOST_TOY_43 = "Lost memories.",

        HALLOWEENCANDY_1 = "Little snack.",
        HALLOWEENCANDY_2 = "Let's not end up shugary after this many!",
        HALLOWEENCANDY_3 = "It's corn!",
        HALLOWEENCANDY_4 = "Nom!",
        HALLOWEENCANDY_5 = "Chomp!",
        HALLOWEENCANDY_6 = "A snack is a snack!",
        HALLOWEENCANDY_7 = "I can get used to this.",
        HALLOWEENCANDY_8 = "It's a palace for snacks.",
        HALLOWEENCANDY_9 = "My jaw's all sticky now.",
        HALLOWEENCANDY_10 = "Monch!",
        HALLOWEENCANDY_11 = "Why fake what's already good?",
        HALLOWEENCANDY_12 = "Little worm, but sugary!", --ONI meal lice candy
        HALLOWEENCANDY_13 = "My poor jaw.", --Griftlands themed candy
        HALLOWEENCANDY_14 = "Spicy snack!", --Hot Lava pepper candy
        CANDYBAG = "A big sack for little snacks!",

		HALLOWEEN_ORNAMENT_1 = "A spectornament I could hang in a tree.",
		HALLOWEEN_ORNAMENT_2 = "No magic within.",
		HALLOWEEN_ORNAMENT_3 = "I can decor with it.", 
		HALLOWEEN_ORNAMENT_4 = "I prefer the real ones.",
		HALLOWEEN_ORNAMENT_5 = "Little spider!",
		HALLOWEEN_ORNAMENT_6 = "I quite enjoy this little raven.", 

		HALLOWEENPOTION_DRINKS_WEAK = "I was hoping for something better.",
		HALLOWEENPOTION_DRINKS_POTENT = "A worthy craft.",
        HALLOWEENPOTION_BRAVERY = "Full of grit.",
		HALLOWEENPOTION_MOON = "Essence of the moon.",
		HALLOWEENPOTION_FIRE_FX = "Crystallized fires.", 
		MADSCIENCE_LAB = "It can brew various potions.",
		LIVINGTREE_ROOT = "It is growing.", 
		LIVINGTREE_SAPLING = "Soon you'll be tall.",

        DRAGONHEADHAT = "Festive beast attire.",
        DRAGONBODYHAT = "Festive beast attire.",
        DRAGONTAILHAT = "Festive beast attire.",
        PERDSHRINE =
        {
            GENERIC = "It wants something.",
            EMPTY = "It needs something.",
            BURNT = "That won't do at all.",
        },
        REDLANTERN = "This lantern can last a while.",
        LUCKY_GOLDNUGGET = "Material that speaks to the greediest souls.",
        FIRECRACKERS = "Festive, and dangerous.",
        PERDFAN = "Could cause devastation.",
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
        	GENERIC = "Beautiful creation, even more spactacular in motion.",
        	STATUE = "Beautiful creation.",
        },
        CLAYHOUND = 
        {
        	GENERIC = "The maw details really caught my eye.",
        	STATUE = "Very good texture.",
        },
        HOUNDWHISTLE = "Is this for music?",
        CHESSPIECE_CLAYHOUND = "Fancy one.",
        CHESSPIECE_CLAYWARG = "Frozen in stone.",

		PIGSHRINE =
		{
            GENERIC = "More stuff to make.",
            EMPTY = "It's hungry for meat.",
            BURNT = "Burnt out.",
		},
		PIG_TOKEN = "This looks important.",
		PIG_COIN = "This could help.",
		YOTP_FOOD1 = "A feast fit for me.",
		YOTP_FOOD2 = "A meal only a beast would love.",
		YOTP_FOOD3 = "Nothing fancy.",

		PIGELITE1 = "What are you looking at?", --BLUE
		PIGELITE2 = "They'll go for the gold.", --RED
		PIGELITE3 = "Here's mud in your eye!", --WHITE
		PIGELITE4 = "Wouldn't you rather hit someone else?", --GREEN

		PIGELITEFIGHTER1 = "What are you looking at?", --BLUE
		PIGELITEFIGHTER2 = "They'll go for the gold.", --RED
		PIGELITEFIGHTER3 = "Here's mud in your eye!", --WHITE
		PIGELITEFIGHTER4 = "Wouldn't you rather hit someone else?", --GREEN

		CARRAT_GHOSTRACER = "That's... disconcerting.",

        YOTC_CARRAT_RACE_START = "It's a good enough place to start.",
        YOTC_CARRAT_RACE_CHECKPOINT = "It reached the checkpoint.",
        YOTC_CARRAT_RACE_FINISH =
        {
            GENERIC = "And it's done.",
            BURNT = "It's all gone up in flames!",
            I_WON = "Ha HA!",
            SOMEONE_ELSE_WON = "Congratulations, {winner}.",
        },

		YOTC_CARRAT_RACE_START_ITEM = "Well, it's a start.",
        YOTC_CARRAT_RACE_CHECKPOINT_ITEM = "That checks out.",
		YOTC_CARRAT_RACE_FINISH_ITEM = "The end's in sight.",

		YOTC_SEEDPACKET = "A few seeds of life within.",
		YOTC_SEEDPACKET_RARE = "Rarers seeds!",

		MINIBOATLANTERN = "A floating beacon of light!",

        YOTC_CARRATSHRINE =
        {
            GENERIC = "What to make...",
            EMPTY = "What would a carrat desire?",
            BURNT = "Reduced to nothingness.",
        },

        YOTC_CARRAT_GYM_DIRECTION =
        {
            GENERIC = "Train them to be stronger.",
            RAT = "You're good little guy!",
            BURNT = "My training regimen crashed and burned.",
        },
        YOTC_CARRAT_GYM_SPEED =
        {
            GENERIC = "This'il speed them up",
            RAT = "Faster. Faster!",
            BURNT = "I may have overdone it.",
        },
        YOTC_CARRAT_GYM_REACTION =
        {
            GENERIC = "Make them more aware.",
            RAT = "Getting there.",
            BURNT = "...",
        },
        YOTC_CARRAT_GYM_STAMINA =
        {
            GENERIC = "Getting strong now!",
            RAT = "Nothing will stop them.",
            BURNT = "And fire got to it.",
        },

        YOTC_CARRAT_GYM_DIRECTION_ITEM = "Time to train those little guys!",
        YOTC_CARRAT_GYM_SPEED_ITEM = "I'll set this up.",
        YOTC_CARRAT_GYM_STAMINA_ITEM = "Make them more durable.",
        YOTC_CARRAT_GYM_REACTION_ITEM = "Make them more aware.",

        YOTC_CARRAT_SCALE_ITEM = "This will tell us how good they are.",
        YOTC_CARRAT_SCALE =
        {
            GENERIC = "Let's see.",
            CARRAT = "They could be a little better.",
            CARRAT_GOOD = "This little guy has done me proud!",
            BURNT = "What a mess.",
        },

        YOTB_BEEFALOSHRINE =
        {
            GENERIC = "What to make...",
            EMPTY = "The boofy needs a treat.",
            BURNT = "Smells like barbeque.",
        },

        BEEFALO_GROOMER =
        {
            GENERIC = "I need a boofy boof to attach.",
            OCCUPIED = "Let's do what we call fashion now!",
            BURNT = "Fashion was too much.",
        },
        BEEFALO_GROOMER_ITEM = "Let's put it somewhere nice.",

		BISHOP_CHARGE_HIT = "Almost couldn't dodge it.",
		TRUNKVEST_SUMMER = "So you tell me, they're hunting them to make this?",
		TRUNKVEST_WINTER = "Well at least this one is useful.",
		TRUNK_COOKED = "Cooked game flesh.",
		TRUNK_SUMMER = "We have hunted them down and riped their nose off.",
		TRUNK_WINTER = "They were ready for winter, but not for us.",
		TUMBLEWEED = "An unalive bundle of living things.",
		TURKEYDINNER = "Bird flesh, with a good decor.",
		TWIGS = "Those basic sticks can lead to big things!",
		UMBRELLA = "I could upgrade this!",
		GRASS_UMBRELLA = "That's essentially worthless.",
		UNIMPLEMENTED = "It doesn't look finished! It could be dangerous.",
		WAFFLES = "A nice little sugary and elegant snack.",
		WALL_HAY = 
		{	
			GENERIC = "Should we even call this a wall?",
			BURNT = "That was to be expected.",
		},
		WALL_HAY_ITEM = "For a bonfire, I hope?",
		WALL_STONE = "That's decently sturdy!",
		WALL_STONE_ITEM = "A pile of rocks, destined to protect.",
		WALL_RUINS = "Reminds me of home!",
		WALL_RUINS_ITEM = "Appreciate the details and the resilience.",
		WALL_WOOD = 
		{
			GENERIC = "I think those are more show than tell.",
			BURNT = "And gone.",
		},
		WALL_WOOD_ITEM = "I'd rather a fence.",
		WALL_MOONROCK = "Quite sturdy!",
		WALL_MOONROCK_ITEM = "Very light, but could stop a crowd!",
		WALL_SCRAP = "Made from fragments of what once was.",
        WALL_SCRAP_ITEM = "I suppose it can be a bit of protection.",
		FENCE = "A little decor goes a long way.",
        FENCE_ITEM = "I love a good picket fence.",
        FENCE_GATE = "So we may enter and leave.",
        FENCE_GATE_ITEM = "To enter the enclosure.",
		WALRUS = "I'd love to have your tusk for my craft!",
		WALRUSHAT = "Good design, none of my usage though.",
		WALRUS_CAMP =
		{
			EMPTY = "They're gone for the season.",
			GENERIC = "I'd barge inside and ransack the place if I could.",
		},
		WALRUS_TUSK = "Perfect! I could use it to transmit sound further!",
		WARDROBE = 
		{
			GENERIC = "Fashion box.",
            BURNING = "The fashion is ablaze.",
			BURNT = "Stylish no more.",
		},
		WARG = "They summon and lead the pack.",
        WARGLET = "Climbing the ladder of the pack are we?",

		WASPHIVE = "They don't want to be bothered.",
		WATERBALLOON = "Pocket of water, for crops or to annoy others.",
		WATERMELON = "A fresh little snack!",
		WATERMELON_COOKED = "That improved the juice but reduced the fresh feeling.",
		WATERMELONHAT = "I'd rather my eyes not completely sticky, thanks.",
		WAXWELLJOURNAL = "Is this your little repertory of circus tricks?",
		WETGOOP = "Failure is part of the art.",
        WHIP = "I know some who'd enjoy using this back in the days.",
		WINTERHAT = "That would never fit over my face.",
		WINTEROMETER = 
		{
			GENERIC = "Are people unable of feeling the temperature?",
			BURNT = "Not like we used it.",
		},

        WINTER_TREE =
        {
            BURNT = "I doubt that's part of the decor.",
            BURNING = "A bonfire.",
            CANDECORATE = "So now I put the decors on it?",
            YOUNG = "Are we waiting for it to grow?",
        },
		WINTER_TREESTAND = 
		{
			GENERIC = "Let's plant one within.",
            BURNT = "I doubt that's part of the decor.",
		},
        WINTER_ORNAMENT = "Little trinkets for the winter tree.",
        WINTER_ORNAMENTLIGHT = "I'd rather the electricity in a craft, but decor is fine.",
        WINTER_ORNAMENTBOSS = "This one is especially impressive.",
		WINTER_ORNAMENTFORGE = "Nice little decor.",
		WINTER_ORNAMENTGORGE = "Fit for a meal at night!",

        WINTER_FOOD1 = "So we can devour people, technically.", --gingerbread cookie
        WINTER_FOOD2 = "I don't think snow looks like that.", --sugar cookie
        WINTER_FOOD3 = "The fluffy sir had four on their horns the other day.", --candy cane
        WINTER_FOOD4 = "Is this truly edible?", --fruitcake
        WINTER_FOOD5 = "Snack!", --yule log cake
        WINTER_FOOD6 = "It sticks to my jaw.", --plum pudding
        WINTER_FOOD7 = "Quite a treat.", --apple cider
        WINTER_FOOD8 = "I quite enjoy this one.", --hot cocoa
        WINTER_FOOD9 = "Does it have egg inside, or is it a play on words?", --eggnog

		WINTERSFEASTOVEN =
		{
			GENERIC = "We can make fancy dishes within.",
			COOKING = "Cooking.",
			ALMOST_DONE_COOKING = "Almost done doing its art.",
			DISH_READY = "It's done.",
		},
		BERRYSAUCE = "A sweet covered in fruity juice.",
		BIBINGKA = "The variety in mortal food is amazing.",
		CABBAGEROLLS = "Our warrior wouldn't enjoy that one much.",
		FESTIVEFISH = "Flesh from the sea, decorated for the occasion.",
		GRAVY = "I assume this is supposed to go with something else.",
		LATKES = "A fancy dish for our festivities.",
		LUTEFISK = "Culture of cooking is impressive!",
		MULLEDDRINK = "Liquid yet so filling!",
		PANETTONE = "I see festivities call for a lot of dessert!",
		PAVLOVA = "What variety!",
		PICKLEDHERRING = "Lots of fish flesh in those.",
		POLISHCOOKIE = "Polish? Like gem polish?",
		PUMPKINPIE = "A pie form of a pumpkin.",
		ROASTTURKEY = "Sharable with the whole group.",
		STUFFING = "Stuffing.",
		SWEETPOTATO = "Is this a whole meal by itself?",
		TAMALES = "Quite filling!",
		TOURTIERE = "Nice on the eyes.",

		TABLE_WINTERS_FEAST =
		{
			GENERIC = "Where we can expose our future feast.",
			HAS_FOOD = "It is time to consume.",
			WRONG_TYPE = "That doesn't go there, silly!",
			BURNT = "The festivities are over.",
		},

		GINGERBREADWARG = "It is leaving frosting everywhere.",
		GINGERBREADHOUSE = "I could crush a civilization of my own!",
		GINGERBREADPIG = "Lead me to your house, dear.",
		CRUMBS = "They are shattering like me.",
		WINTERSFEASTFUEL = "A different sort of magic than I'm used to.",

        KLAUS = "Oh hello sir, you come bearing gifts for me?",
        KLAUS_SACK = "We should get our rewards.",
		KLAUSSACKKEY = "Amazing construct, if only it wasn't a key.",
		WORMHOLE =
		{
			GENERIC = "Soft and undulating.",
			OPEN = "I assure you! It is completely safe.",
		},
		WORMHOLE_LIMITED = "Our friend appears sick.",
		ACCOMPLISHMENT_SHRINE = "I did it.",        
		LIVINGTREE = "A living part of the forest.",
		ICESTAFF = "A quite unrefined use for a blue gem, does a decent job.",
		REVIVER = "Trade your wholeness for another's.",
		SHADOWHEART = "The beating awakes my poor old heart.",
        ATRIUM_RUBBLE = 
        {
			LINE_1 = "Hunger reaps it's victims.",
			LINE_2 = "Wasted by time.",
			LINE_3 = "I remember that day.",
			LINE_4 = "We all became beauty.",
			LINE_5 = "Once broken was reborn anew.",
		},
        ATRIUM_STATUE = "Mirages of my broken mind.",
        ATRIUM_LIGHT = 
        {
			ON = "Impurity run down this sanctuary.",
			OFF = "Left a mess.",
		},
        ATRIUM_GATE =
        {
			ON = "Flashing lights of once sacred flame.",
			OFF = "I'm afraid of the ruin you'll bring.",
			CHARGING = "It is full of impurities.",
			DESTABILIZING = "It is losing control.",
			COOLDOWN = "It needs time. Us too.",
        },
        ATRIUM_KEY = "It can power the main gate.",
		LIFEINJECTOR = "That doesn't do anything for my shell.",
		--SKELETON_PLAYER =
		--{
		--	MALE = "%s must've died performing an experiment with %s.",
		--	FEMALE = "%s must've died performing an experiment with %s.",
		--	ROBOT = "%s must've died performing an experiment with %s.",
		--	DEFAULT = "%s must've died performing an experiment with %s.",
		--},
		HUMANMEAT = "Human flesh.",
		HUMANMEAT_COOKED = "Human flesh, brutally cooked.",
		HUMANMEAT_DRIED = "Bloodless human flesh.",
		ROCK_MOON = "This material is inspiring!",
		MOONROCKNUGGET = "This material is inspiring!",
		MOONROCKCRATER = "You may socket a gem to make your presence known.",
		MOONROCKSEED = "It reveals powerful magic.",

        REDMOONEYE = "We can now see it from afar.",
        PURPLEMOONEYE = "Madness reveals all.",
        GREENMOONEYE = "That felt like a waste.",
        ORANGEMOONEYE = "It marks, but doesn't transport.",
        YELLOWMOONEYE = "A gem of light, wasted that way.",
        BLUEMOONEYE = "It'll make it easier to see where we are.",

                --Arena Event
        LAVAARENA_BOARLORD = "A ruthless man.",
        BOARRIOR = "Your death will be swift.",
        BOARON = "A shame you have to perish.",
        PEGHOOK = "My faith will defend me.",
        TRAILS = "You shall fall.",
        TURTILLUS = "You cannot shield yourself from this world.",
        SNAPPER = "Death will be a blessing.",
		RHINODRILL = "Brotherly camaraderie will not save you.",
		BEETLETAUR = "You are a prisoner of your own doomed destiny.",

        LAVAARENA_PORTAL =
        {
            ON = "I bid you good day.",
            GENERIC = "I dared not hope it would take me home.",
        },
        LAVAARENA_KEYHOLE = "Empty as my heart.",
		LAVAARENA_KEYHOLE_FULL = "Full as my sorrows.",
        LAVAARENA_BATTLESTANDARD = "That Battle Standard needs to be destroyed...",
        LAVAARENA_SPAWNER = "That's where they come from...",

        HEALINGSTAFF = "I could restore my allies.",
        FIREBALLSTAFF = "To call death from the skies.",
        HAMMER_MJOLNIR = "What a brutal implement.",
        SPEAR_GUNGNIR = "To cut and slash...",
        BLOWDART_LAVA = "To pierce the hearts of my foes...",
        BLOWDART_LAVA2 = "To burn and pierce!",
        LAVAARENA_LUCY = "Hello again, Lucy.",
        WEBBER_SPIDER_MINION = "Webber seems proud of them.",
        BOOK_FOSSIL = "There is power in words.",
		LAVAARENA_BERNIE = "How do you do, Bernie?",
		SPEAR_LANCE = "Such a brutal weapon...",
		BOOK_ELEMENTAL = "I would not want such power.",
		LAVAARENA_ELEMENTAL = "When will you be free from this torment?",

   		LAVAARENA_ARMORLIGHT = "If only my heart were as light.",
		LAVAARENA_ARMORLIGHTSPEED = "They'll have to catch me to hurt me.",
		LAVAARENA_ARMORMEDIUM = "Protect my fragile frame.",
		LAVAARENA_ARMORMEDIUMDAMAGER = "Even our armor is fanged.",
		LAVAARENA_ARMORMEDIUMRECHARGER = "It will restore one's power.",
		LAVAARENA_ARMORHEAVY = "Heavy protection for one's heart.",
		LAVAARENA_ARMOREXTRAHEAVY = "This world is nothing but hurt.",

		LAVAARENA_FEATHERCROWNHAT = "But what of the birds?",
        LAVAARENA_HEALINGFLOWERHAT = "It eases pain of the body, but not of the heart.",
        LAVAARENA_LIGHTDAMAGERHAT = "It brings more pain into the world.",
        LAVAARENA_STRONGDAMAGERHAT = "Hit harder, stronger...",
        LAVAARENA_TIARAFLOWERPETALSHAT = "The wearer shall be a force of good.",
        LAVAARENA_EYECIRCLETHAT = "There is dastardly power within.",
        LAVAARENA_RECHARGERHAT = "I'll be able to attack so often...",
        LAVAARENA_HEALINGGARLANDHAT = "But will it heal my soul?",
        LAVAARENA_CROWNDAMAGERHAT = "I forsee a wave of death.",

		LAVAARENA_ARMOR_HP = "It protects from damage, but not from sorrow.",

		LAVAARENA_FIREBOMB = "A bombardment of pain.",
		LAVAARENA_HEAVYBLADE = "It's too heavy. Like my soul.",

        --Quagmire
        QUAGMIRE_ALTAR =
        {
        	GENERIC = "The monster's hunger shall never cease.",
        	FULL = "We have prolonged our horrific demise.",
    	},
		QUAGMIRE_ALTAR_STATUE1 = "What horror have those eyes witnessed?",
		QUAGMIRE_PARK_FOUNTAIN = "Long dry.",

        QUAGMIRE_HOE = "To till the corrupt soil.",

        QUAGMIRE_TURNIP = "It's... a turnip.",
        QUAGMIRE_TURNIP_COOKED = "The turnip is now cooked.",
        QUAGMIRE_TURNIP_SEEDS = "The life they contain is a mystery.",

        QUAGMIRE_GARLIC = "It gives food flavor.",
        QUAGMIRE_GARLIC_COOKED = "It smells a bit nice.",
        QUAGMIRE_GARLIC_SEEDS = "The life they contain is a mystery.",

        QUAGMIRE_ONION = "I never cry.",
        QUAGMIRE_ONION_COOKED = "It will never make anyone cry again.",
        QUAGMIRE_ONION_SEEDS = "The life they contain is a mystery.",

        QUAGMIRE_POTATO = "It has eyes, yet it never cries.",
        QUAGMIRE_POTATO_COOKED = "Now its eyes will never open.",
        QUAGMIRE_POTATO_SEEDS = "The life they contain is a mystery.",

        QUAGMIRE_TOMATO = "Red as heart's blood.",
        QUAGMIRE_TOMATO_COOKED = "Its flesh is far more bloody now.",
        QUAGMIRE_TOMATO_SEEDS = "The life they contain is a mystery.",

        QUAGMIRE_FLOUR = "Flour by any other name would smell as sweet.",
        QUAGMIRE_WHEAT = "We can grind it down into flour.",
        QUAGMIRE_WHEAT_SEEDS = "The life they contain is a mystery.",
        --NOTE: raw/cooked carrot uses regular carrot strings
        QUAGMIRE_CARROT_SEEDS = "The life they contain is a mystery.",

        QUAGMIRE_ROTTEN_CROP = "Time came for it.",

		QUAGMIRE_SALMON = "It flops as its life slowly leaves its body.",
		QUAGMIRE_SALMON_COOKED = "Not so lively now.",
		QUAGMIRE_CRABMEAT = "Its insides are as horrid as its outsides.",
		QUAGMIRE_CRABMEAT_COOKED = "It's ready now.",
		QUAGMIRE_SUGARWOODTREE =
		{
			GENERIC = "It has a sickly beauty.",
			STUMP = "All things must end.",
			TAPPED_EMPTY = "Like a dagger through the heart. A tree heart.",
			TAPPED_READY = "I can harvest it now.",
			TAPPED_BUGS = "All that sacrifice for nothing.",
			WOUNDED = "Its life ebbs.",
		},
		QUAGMIRE_SPOTSPICE_SHRUB =
		{
			GENERIC = "I suppose it could be edible.",
			PICKED = "We've taken all there was to take.",
		},
		QUAGMIRE_SPOTSPICE_SPRIG = "We ripped it from its home on the shrub.",
		QUAGMIRE_SPOTSPICE_GROUND = "Just a dash.",
		QUAGMIRE_SAPBUCKET = "For collecting tree blood.",
		QUAGMIRE_SAP = "Tree blood.",
		QUAGMIRE_SALT_RACK =
		{
			READY = "There is salt to be had.",
			GENERIC = "There is no salt, yet.",
		},

		QUAGMIRE_POND_SALT = "Water, water, everywhere...",
		QUAGMIRE_SALT_RACK_ITEM = "It's for collecting salt from the pond.",

		QUAGMIRE_SAFE =
		{
			GENERIC = "Let's have a peek inside...",
			LOCKED = "Locked, like my heart.",
		},

		QUAGMIRE_KEY = "It is the key to something precious.",
		QUAGMIRE_KEY_PARK = "The key to a beautiful place, locked long away.",
        QUAGMIRE_PORTAL_KEY = "Perhaps I'll be happier in the next world.",


		QUAGMIRE_MUSHROOMSTUMP =
		{
			GENERIC = "They thrive on a stump made by death.",
			PICKED = "All things die. Even fungus.",
		},
		QUAGMIRE_MUSHROOMS = "Maybe we'll get lucky and they'll be poisonous.",
        QUAGMIRE_MEALINGSTONE = "I am ground down on the mealing stone of life.",
		QUAGMIRE_PEBBLECRAB = "Had I such a shell, I would never emerge.",


		QUAGMIRE_RUBBLE_CARRIAGE = "It's been forgotten.",
        QUAGMIRE_RUBBLE_CLOCK = "Time is an illusion.",
        QUAGMIRE_RUBBLE_CATHEDRAL = "Nothing more to pray for.",
        QUAGMIRE_RUBBLE_PUBDOOR = "A door that leads nowhere.",
        QUAGMIRE_RUBBLE_ROOF = "The roof cannot protect you when death comes.",
        QUAGMIRE_RUBBLE_CLOCKTOWER = "Time is death's ally.",
        QUAGMIRE_RUBBLE_BIKE = "Nothing escaped this plague.",
        QUAGMIRE_RUBBLE_HOUSE =
        {
            "Death has been here.",
            "It's a ghost town.",
            "Some tragedy has struck this house.",
        },
        QUAGMIRE_RUBBLE_CHIMNEY = "This was once a happy home.",
        QUAGMIRE_RUBBLE_CHIMNEY2 = "Its hearth no longer has a home.",
        QUAGMIRE_MERMHOUSE = "Seclusion has not been kind to it.",
        QUAGMIRE_SWAMPIG_HOUSE = "I see no joy in this house.",
        QUAGMIRE_SWAMPIG_HOUSE_RUBBLE = "Neither a house nor a home.",
        QUAGMIRE_SWAMPIGELDER =
        {
            GENERIC = "How do you do, sir?",
            SLEEPING = "He is practicing for the big sleep.",
        },
        QUAGMIRE_SWAMPIG = "They're less standoffish than their brethren.",

        QUAGMIRE_PORTAL = "There's no night here. It is a nice change.",
        QUAGMIRE_SALTROCK = "It needs to be ground down before we can use it.",
        QUAGMIRE_SALT = "It adds flavor...",
        --food--
        QUAGMIRE_FOOD_BURNT = "A waste.",
        QUAGMIRE_FOOD =
        {
        	GENERIC = "We should offer it to the beast.",
            MISMATCH = "The beast doesn't want that.",
            MATCH = "The beast will be satisfied with this.",
            MATCH_BUT_SNACK = "This will satisfy the beast, but not for long.",
        },

        QUAGMIRE_FERN = "Wilson calls them \"greens\"... but they're purple...",
        QUAGMIRE_FOLIAGE_COOKED = "Cooked purples.",
        QUAGMIRE_COIN1 = "I shall put them on my eyes when I die.",
        QUAGMIRE_COIN2 = "Money will not bring you any happiness.",
        QUAGMIRE_COIN3 = "Wealth cannot buy immortality.",
        QUAGMIRE_COIN4 = "It came from above.",
        QUAGMIRE_GOATMILK = "But no honey.",
        QUAGMIRE_SYRUP = "Not as sweet as my king.",
        QUAGMIRE_SAP_SPOILED = "As bittersweet as life.",
        QUAGMIRE_SEEDPACKET = "Planting seeds requires an optimism I don't possess.",

        QUAGMIRE_POT = "We cook to stave off death.",
        QUAGMIRE_POT_SMALL = "We will cook, or we will die.",
        QUAGMIRE_POT_SYRUP = "Sweetness begets sweetness.",
        QUAGMIRE_POT_HANGER = "The hanger is a noose for a pot.",
        QUAGMIRE_POT_HANGER_ITEM = "It's for hanging the pot over the fire.",
        QUAGMIRE_GRILL = "It can't make life more palatable.",
        QUAGMIRE_GRILL_ITEM = "I don't want to carry this around.",
        QUAGMIRE_GRILL_SMALL = "It makes a little bit of food.",
        QUAGMIRE_GRILL_SMALL_ITEM = "It only works if I place it somewhere.",
        QUAGMIRE_OVEN = "It looks okay.",
        QUAGMIRE_OVEN_ITEM = "Sigh... Why bother?",
        QUAGMIRE_CASSEROLEDISH = "For making food.",
        QUAGMIRE_CASSEROLEDISH_SMALL = "For making a small amount of food.",
        QUAGMIRE_PLATE_SILVER = "If only life had been handed to me on a silver plate.",
        QUAGMIRE_BOWL_SILVER = "It is empty, like my heart.",
--fallback to speech_wilson.lua         QUAGMIRE_CRATE = "Kitchen stuff.",

        QUAGMIRE_MERM_CART1 = "I, too, cart around my baggage.", --sammy's wagon
        QUAGMIRE_MERM_CART2 = "Nothing in there could bring me happiness.", --pipton's cart
        QUAGMIRE_PARK_ANGEL = "It's winged, but it's no angel.",
        QUAGMIRE_PARK_ANGEL2 = "My emperor needs a statue.",
        QUAGMIRE_PARK_URN = "Dust to dust.",
        QUAGMIRE_PARK_OBELISK = "A monument. But not to the king.",
        QUAGMIRE_PARK_GATE =
        {
            GENERIC = "Now I may enter the park.",
            LOCKED = "I need a key to enter.",
        },
        QUAGMIRE_PARKSPIKE = "Looks dangerous.",
        QUAGMIRE_CRABTRAP = "Life is a trap.",
        QUAGMIRE_TRADER_MERM = "How do you do?",
        QUAGMIRE_TRADER_MERM2 = "How do you do?",

        QUAGMIRE_GOATMUM = "Hello, ma'am. Care to trade?",
        QUAGMIRE_GOATKID = "What childhood is this for you?",
        QUAGMIRE_PIGEON =
        {
            DEAD = "Cold and dead.",
            GENERIC = "Would you like to be a pie, little bird?",
            SLEEPING = "It's practicing for the big sleep.",
        },
        QUAGMIRE_LAMP_POST = "It sheds light on nothing important.",

        QUAGMIRE_BEEFALO = "Don't worry. You'll be dead soon.",
        QUAGMIRE_SLAUGHTERTOOL = "Is all of life not a slaughter?",

        QUAGMIRE_SAPLING = "We will perish before this grows back.",
        QUAGMIRE_BERRYBUSH = "It shall never grow another berry.",

        QUAGMIRE_ALTAR_STATUE2 = "Yet another reminder of death.",
        QUAGMIRE_ALTAR_QUEEN = "I am not impressed by opulence.",
        QUAGMIRE_ALTAR_BOLLARD = "A post. Not very exciting.",
        QUAGMIRE_ALTAR_IVY = "Like death, it creeps everywhere.",

        QUAGMIRE_LAMP_SHORT = "The only light in my life is you my emperor.",

        --v2 Winona
        WINONA_CATAPULT = 
        {
        	GENERIC = "A good structure of defense.",
        	OFF = "I see it isn't magic powered.",
        	BURNING = "It's been lit ablaze.",
        	BURNT = "Ash.",
        },
        WINONA_SPOTLIGHT = 
        {
        	GENERIC = "That feels inefficient.",
        	OFF = "It neeeds power.",
        	BURNING = "It's on fire.",
        	BURNT = "Ash.",
        },
        WINONA_BATTERY_LOW = 
        {
        	GENERIC = "Simple power storage.",
        	LOWPOWER = "Slowly running out.",
        	OFF = "It's empty.",
        	BURNING = "It's on fire.",
        	BURNT = "Ash.",
        },
        WINONA_BATTERY_HIGH = 
        {
        	GENERIC = "A battery run by gem powers.",
        	LOWPOWER = "It'll turn off soon.",
        	OFF = "It needs gems.",
        	BURNING = "It's on fire.",
        	BURNT = "Ash.",
        },

        --Wormwood
        COMPOSTWRAP = "Good fertilizer for plants.",
        ARMOR_BRAMBLE = "Plants shatter too?",
        TRAP_BRAMBLE = "Sedentary trap for our enemies.",

        BOATFRAGMENT03 = "Not much left of it.",
        BOATFRAGMENT04 = "Not much left of it.",
        BOATFRAGMENT05 = "Not much left of it.",
		BOAT_LEAK = "I see our ship wasn't tough enough.",
        MAST = "Catches the wind, to lower the manual labour required.",
        SEASTACK = "An obstacle of the sea.",
        FISHINGNET = "It'll catch us a bit of fish.",
        ANTCHOVIES = "What a minow.",
        STEERINGWHEEL = "To drive our raft to new lands.",
        ANCHOR = "Keeps it in place when needed.",
        BOATPATCH = "Basic mending for our craft.",
        DRIFTWOOD_TREE = 
        {
            BURNING = "Wood this dry burns well.",
            BURNT = "No more use for it now.",
            CHOPPED = "We can dig up the rest.",
            GENERIC = "Lightweight wood material.",
        },

        DRIFTWOOD_LOG = "It's floating around.",

        MOON_TREE = 
        {
            BURNING = "Those aren't immune to flames either.",
            BURNT = "Reduced to ashes.",
            CHOPPED = "A more than average thick tree.",
            GENERIC = "What a wide tree!",
        },
		MOON_TREE_BLOSSOM = "Petals are delicately brushing my matter.",

        MOONBUTTERFLY = 
        {
        	GENERIC = "Moth creature.",
        	HELD = "I'll plant you elsewhere.",
        },
		MOONBUTTERFLYWINGS = "We have destroyed more life yet again.",
        MOONBUTTERFLY_SAPLING = "Now it may grow again.",
        ROCK_AVOCADO_FRUIT = "Do those reveal a sweet snack when mined?",
        ROCK_AVOCADO_FRUIT_RIPE = "Almost as tough as birchnuts.",
        ROCK_AVOCADO_FRUIT_RIPE_COOKED = "Quite edible for stones.",
        ROCK_AVOCADO_FRUIT_SPROUT = "It's growing.",
        ROCK_AVOCADO_BUSH = 
        {
        	BARREN = "It needs fertilizer.",
			WITHERED = "Dried up.",
			GENERIC = "The moon can sustain us with fruits.",
			PICKED = "It needs time to regrow more of them.",
			DISEASED = "It looks pretty sick.",
            DISEASING = "Something's not right.",
			BURNING = "It's burning.",
		},
        DEAD_SEA_BONES = "Sons of the oceans, perished once revealed.",
        HOTSPRING = 
        {
        	GENERIC = "If only I could soak my weary bones.",
        	BOMBED = "Boiling, yet so relaxing.",
        	GLASS = "It froze by the moonlight.",
			EMPTY = "I'll just have to wait for it to fill up again.",
        },
        MOONGLASS = "Light frozen forever in a tiny shard of glass.",
        MOONGLASS_CHARGED = "I shall make myself something nice with this!",
        MOONGLASS_ROCK = "A chunk of trapped light.",
        BATHBOMB = "It releases a sweet aroma upon contact with water.",
        TRAP_STARFISH =
        {
            GENERIC = "It can and will trap us.",
            CLOSED = "It needs time to recoil.",
        },
        DUG_TRAP_STARFISH = "Now we may use you for our own purpose.",
        SPIDER_MOON = 
        {
        	GENERIC = "The moon changed it.",
        	SLEEPING = "It is resting still.",
        	DEAD = "We crushed it.",
        },
        MOONSPIDERDEN = "The mutated spiders live in there.",
		FRUITDRAGON =
		{
			GENERIC = "A living dragonfruit, closer to a lizard.",
			RIPE = "It turned fiery.",
			SLEEPING = "It's snoozing.",
		},
        PUFFIN =
        {
            GENERIC = "Bird of the sea, eye can see!",
            HELD = "You are mine now.",
            SLEEPING = "He's taking a deserved nap.",
        },

		MOONGLASSAXE = "An effective but short lived tool.",
		GLASSCUTTER = "A tool against the evergrowing shadows.",

        ICEBERG =
        {
            GENERIC = "Let's steer clear of that.",
            MELTED = "It's completely melted.",
        },
        ICEBERG_MELTED = "It's completely melted.",

        MINIFLARE = "Gather the others.",
        MEGAFLARE = "Attract a fight to you.",

		MOON_FISSURE = 
		{
			GENERIC = "Their whispers will break even the weakest minds.", 
			NOLIGHT = "It'll light up again.",
		},
        MOON_ALTAR =
        {
            MOON_ALTAR_WIP = "It wants to be finished.",
            GENERIC = "It is telling us secrets.",
        },

        MOON_ALTAR_IDOL = "I'll build you.",
        MOON_ALTAR_GLASS = "I'll do as I wish, not as you say.",
        MOON_ALTAR_SEED = "You'll bring me to him.",

        MOON_ALTAR_ROCK_IDOL = "There's something trapped inside.",
        MOON_ALTAR_ROCK_GLASS = "There's something trapped inside.",
        MOON_ALTAR_ROCK_SEED = "There's something trapped inside.",

        MOON_ALTAR_CROWN = "You are a piece of my puzzle.",
        MOON_ALTAR_COSMIC = "I'll lead you home.",

        MOON_ALTAR_ASTRAL = "Our main tool to capture lunar energy.",
        MOON_ALTAR_ICON = "With the others you go.",
        MOON_ALTAR_WARD = "It wants to be with the others.",

        SEAFARING_PROTOTYPER =
        {
            GENERIC = "Crude station to obtain sea knowledge.",
            BURNT = "Not enough water here I suppose.",
        },
        BOAT_ITEM = "I wish I could swim.",
        BOAT_GRASS_ITEM = "Does the job.",
        STEERINGWHEEL_ITEM = "Places the wheel on the boat.",
        ANCHOR_ITEM = "Now I can build an anchor.",
        MAST_ITEM = "Now I can build a mast.",
        MUTATEDHOUND = 
        {
        	DEAD = "Now I can breathe easy.",
        	GENERIC = "I don't think our emperor wanted this.",
        	SLEEPING = "I have a very strong desire to run.",
        },

        MUTATED_PENGUIN = 
        {
			DEAD = "That's the end of that.",
			GENERIC = "They kept their habits from before all this.",
			SLEEPING = "It's asleep.",
		},
        CARRAT = 
        {
        	DEAD = "That's the end of that.",
        	GENERIC = "A walking carrot, how specific.",
        	HELD = "Your name is Cinnamon now.",
        	SLEEPING = "It's cute.",
        },

		BULLKELP_PLANT = 
        {
            GENERIC = "Treat of the sea.",
            PICKED = "It'll regrow soon.",
        },
		BULLKELP_ROOT = "We can replant it where needed.",
        KELPHAT = "I can't think of an use for this.",
		KELP = "Treat of the sea, grossly in my pocket.",
		KELP_COOKED = "Treat of the sea, cooked and somehow even mushier.",
		KELP_DRIED = "A fine salty snack!",

		GESTALT = "I don't wanna hear it.",
        GESTALT_GUARD = "You seem quite angry at us.",

		COOKIECUTTER = "Natural predator of our boats.",
		COOKIECUTTERSHELL = "I've taken your shell.",
		COOKIECUTTERHAT = "Is this supposed to be a crown?",
		SALTSTACK =
		{
			GENERIC = "Now that's quite marvelous!",
			MINED_OUT = "I've gathered it all.",
			GROWING = "It is reforming.",
		},
		SALTROCK = "I have an urge.",
		SALTBOX = "It'll aid food with spoiling slower.",

		TACKLESTATION = "The art of fishing, in a station.",
		TACKLESKETCH = "We could research this.",

        MALBATROSS = "You're quite bigger than most other birds I've seen.",
        MALBATROSS_FEATHER = "What a soft material!",
        MALBATROSS_BEAK = "A sturdy tool for rowing.",
        MAST_MALBATROSS_ITEM = "This will speed up our boat.",
        MAST_MALBATROSS = "Spread the bird's wings into the sunset.",
		MALBATROSS_FEATHERED_WEAVE = "It can help us with fishing.",

        GNARWAIL =
        {
            GENERIC = "Is it a horn or a sword?",
            BROKENHORN = "Got your nose!",
            FOLLOWER = "I believe we've made a friend!",
            BROKENHORN_FOLLOWER = "You've lost your horn my good sir!",
        },
        GNARWAIL_HORN = "I can perhaps use this for something.",

        WALKINGPLANK = "For a last ditch escape, or a nice bath.",
        WALKINGPLANK_GRASS = "For a last ditch escape, or a nice bath.",
        OAR = "We can row around now.",
		OAR_DRIFTWOOD = "Better ship acceleration.",

		OCEANFISHINGROD = "The art of deep sea fishing!",
		OCEANFISHINGBOBBER_NONE = "I think I'm missing something.",
        OCEANFISHINGBOBBER_BALL = "This will help.",
        OCEANFISHINGBOBBER_OVAL = "How many others of those are there?",
		OCEANFISHINGBOBBER_CROW = "A feather of fishing.",
		OCEANFISHINGBOBBER_ROBIN = "Feather of fire, out of its element.",
		OCEANFISHINGBOBBER_ROBIN_WINTER = "The snowbird quill doesn't freeze water.",
		OCEANFISHINGBOBBER_CANARY = "It doesn't electrocute the fish.",
		OCEANFISHINGBOBBER_GOOSE = "I probably can't do better than this.",
		OCEANFISHINGBOBBER_MALBATROSS = "The sea bird, to catch the fish.",

		OCEANFISHINGLURE_SPINNER_RED = "This could attract some fish.",
		OCEANFISHINGLURE_SPINNER_GREEN = "This could attract some fish.",
		OCEANFISHINGLURE_SPINNER_BLUE = "This could attract some fish.",
		OCEANFISHINGLURE_SPOON_RED = "This could attract some smaller fish.",
		OCEANFISHINGLURE_SPOON_GREEN = "This could attract some smaller fish.",
		OCEANFISHINGLURE_SPOON_BLUE = "This could attract some smaller fish.",
		OCEANFISHINGLURE_HERMIT_RAIN = "I didn't think fishing in the rain made it easier.",
		OCEANFISHINGLURE_HERMIT_SNOW = "Fish in the dead of winter.",
		OCEANFISHINGLURE_HERMIT_DROWSY = "Tires the fishes faster.",
		OCEANFISHINGLURE_HERMIT_HEAVY = "I'll get the heavy ones.",

		OCEANFISH_SMALL_1 = "You'll be slaughtered into a nice treat.",
		OCEANFISH_SMALL_2 = "A tiny fish, yet still some flesh for us.",
		OCEANFISH_SMALL_3 = "There might be bigger elsewhere.",
		OCEANFISH_SMALL_4 = "We might need to go for bigger game.",
		OCEANFISH_SMALL_5 = "A corn of fish, good snack to keep going.",
		OCEANFISH_SMALL_6 = "Eye can see the sea!",
		OCEANFISH_SMALL_7 = "I've got you.",
		OCEANFISH_SMALL_8 = "This could cause a forest fire.",
        OCEANFISH_SMALL_9 = "It could control fires.",

		OCEANFISH_MEDIUM_1 = "A bigger snack.",
		OCEANFISH_MEDIUM_2 = "You'll cook great.",
		OCEANFISH_MEDIUM_3 = "Was that worth the time?",
		OCEANFISH_MEDIUM_4 = "Meow.",
		OCEANFISH_MEDIUM_5 = "The best fish around.",
		OCEANFISH_MEDIUM_6 = "I've heard this one is quite rare.",
		OCEANFISH_MEDIUM_7 = "I've heard this one is quite rare.",
		OCEANFISH_MEDIUM_8 = "A fish made of frost.",
        OCEANFISH_MEDIUM_9 = "You seem like a sweet bite.",

		PONDFISH = "A simple fish of simple flesh.",
		PONDEEL = "We used to eat those at the grand feast.",

        FISHMEAT = "A chunk of fish flesh.",
        FISHMEAT_COOKED = "The flesh was seared.",
        FISHMEAT_SMALL = "A small amount of fish flesh.",
        FISHMEAT_SMALL_COOKED = "Seared small fish flesh.",
		SPOILED_FISH = "It has decayed like the others.",

		FISH_BOX = "Preserve them, trapped.",
        POCKET_SCALE = "Weighs your catch.",

		TACKLECONTAINER = "So the artful fisher may store more.",
		SUPERTACKLECONTAINER = "Quite portable for its capacity!",

		TROPHYSCALE_FISH =
		{
			GENERIC = "Let's measure them up.",
			HAS_ITEM = "Weight: {weight}\nCaught by: {owner}",
			HAS_ITEM_HEAVY = "Weight: {weight}\nCaught by: {owner}\nWhat a catch!",
			BURNING = "You'd wonder how the fire isn't cleansed.",
			BURNT = "It's gone.",
			OWNER = "It is as so \nWeight: {weight}\nCaught by: {owner}",
			OWNER_HEAVY = "Weight: {weight}\nCaught by: {owner}\nQuite a chonker!",
		},

		OCEANFISHABLEFLOTSAM = "Just some muddy grass.",

		CALIFORNIAROLL = "A clean way to eat fish flesh.",
		SEAFOODGUMBO = "Crushed fish flesh in a bowl.",
		SURFNTURF = "A most refined fish flesh!",

        WOBSTER_SHELLER = "A little sir of the seas.",
        WOBSTER_DEN = "They live in there.",
        WOBSTER_SHELLER_DEAD = "I'm sorry.",
        WOBSTER_SHELLER_DEAD_COOKED = "This doesn't feel good.",

        LOBSTERBISQUE = "How disheartening...",
        LOBSTERDINNER = "Cruelty in the form of a meal.",

        WOBSTER_MOONGLASS = "They've adapted to the moon.",
        MOONGLASS_WOBSTER_DEN = "They live within this glass prison.",

		TRIDENT = "Magic of the seas, in my paws.",

		WINCH =
		{
			GENERIC = "Effective grabbing device.",
			RETRIEVING_ITEM = "I've caught on something.",
			HOLDING_ITEM = "Let's see what it is.",
		},

        HERMITHOUSE = {
            GENERIC = "A decrepit living quarter, how I feel you.",
            BUILTUP = "A bit of care goes a long way.",
        },

        SHELL_CLUSTER = "It could give us a good amount of bells.",
        --
		SINGINGSHELL_OCTAVE3 =
		{
			GENERIC = "It's a low toned one.",
		},
		SINGINGSHELL_OCTAVE4 =
		{
			GENERIC = "Deeper.",
		},
		SINGINGSHELL_OCTAVE5 =
		{
			GENERIC = "It can go higher.",
        },

        CHUM = "It attracts the fish to one spot.",

        SUNKENCHEST =
        {
            GENERIC = "We've found it deep in the sea.",
            LOCKED = "Let's smash this open.",
        },

        HERMIT_BUNDLE = "A gift for our good deeds.",
        HERMIT_BUNDLE_SHELLS = "Thank you for the shells, I'll take more sopranos please.",

        RESKIN_TOOL = "So you may change how you see things.",
        MOON_FISSURE_PLUGGED = "Pretty effective.",


		----------------------- ROT STRINGS GO ABOVE HERE ------------------

		-- Walter
        WOBYBIG =
        {
            "What a floofster!",
            "What a floofster!",
        },
        WOBYSMALL =
        {
            "What a good little dog!",
            "What a good little dog!",
        },
		WALTERHAT = "Looks a little silly, but I appreciate the commitment.",
		SLINGSHOT = "Quite inventive for how simple it is.",
		SLINGSHOTAMMO_ROCK = "Don't shoot for the eyes, I'd want them.",
		SLINGSHOTAMMO_MARBLE = "Don't shoot for the eyes, I'd want them.",
		SLINGSHOTAMMO_THULECITE = "Don't shoot for the eyes, I'd want them.",
        SLINGSHOTAMMO_GOLD = "Don't shoot for the eyes, I'd want them.",
        SLINGSHOTAMMO_SLOW = "Don't shoot for the eyes, I'd want them.",
        SLINGSHOTAMMO_FREEZE = "Don't shoot for the eyes, I'd want them.",
		SLINGSHOTAMMO_POOP = "Remains used to distract.",
        PORTABLETENT = "A simple but portable solution for the restless.",
        PORTABLETENT_ITEM = "I'm all about portable and functional!",

        -- Wigfrid
        BATTLESONG_DURABILITY = "An empowering experience!",
        BATTLESONG_HEALTHGAIN = "I don't quite get this one.",
        BATTLESONG_SANITYGAIN = "A song of bravery!",
        BATTLESONG_SANITYAURA = "...I suppose not all songs are for everyone.",
        BATTLESONG_FIRERESISTANCE = "The fires of the battle.",
        BATTLESONG_INSTANT_TAUNT = "How crude yet so powerful!",
        BATTLESONG_INSTANT_PANIC = "She has quite the stance.",

        -- Webber
        MUTATOR_WARRIOR = "The spiderchild has some good making skills.",
        MUTATOR_DROPPER = "The spiderchild has some good making skills.",
        MUTATOR_HIDER = "The spiderchild has some good making skills.",
        MUTATOR_SPITTER = "The spiderchild has some good making skills.",
        MUTATOR_MOON = "The spiderchild has some good making skills.",
        MUTATOR_HEALER = "The spiderchild has some good making skills.",
        SPIDER_WHISTLE = "It calls spiders toward him.",
        SPIDERDEN_BEDAZZLER = "I'll get rid of them.",
        SPIDER_HEALER = "Their source of vitality.",
        SPIDER_REPELLENT = "Scare them away.",
        SPIDER_HEALER_ITEM = "I've caught the nurse.",

		-- Wendy
		GHOSTLYELIXIR_SLOWREGEN = "She makes ailments in her free time.",
		GHOSTLYELIXIR_FASTREGEN = "She makes ailments in her free time.",
		GHOSTLYELIXIR_SHIELD = "She makes ailments in her free time.",
		GHOSTLYELIXIR_ATTACK = "She makes ailments in her free time.",
		GHOSTLYELIXIR_SPEED = "She makes ailments in her free time.",
		GHOSTLYELIXIR_RETALIATION = "She makes ailments in her free time.",
		SISTURN =
		{
			GENERIC = "It needs some flowers within.",
			SOME_FLOWERS = "It is coming to life.",
			LOTS_OF_FLOWERS = "Her will to survive has manifested itself.",
		},

        --Wortox
        WORTOX_SOUL = "only_used_by_wortox", --only wortox can inspect souls

        PORTABLECOOKPOT_ITEM =
        {
            GENERIC = "The chef's workshop!",
            DONE = "The chef's workshop!",

            COOKING_LONG = "Their art must take patience.",
			COOKING_SHORT = "It'll be done soon.",
			EMPTY = "They must gather more before cooking.",
        },
        
        PORTABLEBLENDER_ITEM = "It reduces them to shards... powder?",
        PORTABLESPICER_ITEM =
        {
            GENERIC = "Can make treats and snacks better.",
            DONE = "Thank you, chef!",
        },
        SPICEPACK = "A small pouch, for their own convinience.",
        SPICE_GARLIC = "It seems to repel enemies.",
        SPICE_SUGAR = "I do appreciate all things sweet.",
        SPICE_CHILI = "Spice of the dragon, in powder.",
        SPICE_SALT = "This one's my favourite!",
        MONSTERTARTARE = "Monster flesh, in a good display!",
        FRESHFRUITCREPES = "Sugary fruit!",
        FROGFISHBOWL = "So we may feel dry.",
        POTATOTORNADO = "The swirls remind me of thulecite.",
        DRAGONCHILISALAD = "It makes us feel warm inside.",
        GLOWBERRYMOUSSE = "We may glow as we go.",
        VOLTGOATJELLY = "Harness the lightnings, for a time.",
        NIGHTMAREPIE = "I've never thought of eating the fuel.",
        BONESOUP = "What a way to cook using the bare minimum.",
        MASHEDPOTATOES = "Simple snack.",
        POTATOSOUFFLE = "The power of the eggs show.",
        MOQUECA = "Could bring the dead back to life... If only!",
        GAZPACHO = "It makes me feel colder inside.",
        ASPARAGUSSOUP = "That feels almost insulting.",
        VEGSTINGER = "Small drink, mostly for relaxing.",
        BANANAPOP = "How simple!",
        CEVICHE = "Crushed fish.",
        SALSA = "I'd take a sugary treat instead.",
        PEPPERPOPPER = "I don't hear them pop in my jaw, is that normal?",

        TURNIP = "It's a raw turnip.",
        TURNIP_COOKED = "Cooking in practice.",
        TURNIP_SEEDS = "A handful of odd seeds.",
        
        GARLIC = "A spice if you will.",
        GARLIC_COOKED = "Not so much for a spice anymore.",
        GARLIC_SEEDS = "A handful of odd seeds.",
        
        ONION = "Crunchy.",
        ONION_COOKED = "The crunch is gone.",
        ONION_SEEDS = "A handful of odd seeds.",
        
        POTATO = "Are they like our glow berries?",
        POTATO_COOKED = "We've cooked it.",
        POTATO_SEEDS = "A handful of odd seeds.",
        
        TOMATO = "A bloody display.",
        TOMATO_COOKED = "Boiled flesh.",
        TOMATO_SEEDS = "A handful of odd seeds.",

        ASPARAGUS = "A vegetable.", 
        ASPARAGUS_COOKED = "It's good for us.",
        ASPARAGUS_SEEDS = "It's odd seeds.",

        PEPPER = "Nice and spicy.",
        PEPPER_COOKED = "It was already hot enough to begin with.",
        PEPPER_SEEDS = "A handful of seeds.",

        WEREITEM_BEAVER = "The hunger idol.",
        WEREITEM_GOOSE = "The fear idol.",
        WEREITEM_MOOSE = "The wrath idol.",

        MERMHAT = "I'll keep my face, thank you.",
        MERMTHRONE =
        {
            GENERIC = "I'd take a real throne, this is just the floor!",
            BURNT = "Good riddance.",
        },        
        MERMTHRONE_CONSTRUCTION =
        {
            GENERIC = "Let's see what this turns into.",
            BURNT = "I suppose we'll never know.",
        },        
        MERMHOUSE_CRAFTED = 
        {
            GENERIC = "A little home, made from love.",
            BURNT = "Love doesn't protect all.",
        },

        MERMWATCHTOWER_REGULAR = "They seem to love their royalty.",
        MERMWATCHTOWER_NOKING = "They have lost their purpose.",
        MERMKING = "I prefered my leader...",
        MERMGUARD = "They're here to protect.",
        MERM_PRINCE = "No rite of passage? You're the new king just for sitting there?!",

        SQUID = "Descendants of the old ones.",

		GHOSTFLOWER = "Yes, yes. Oh my.",
        SMALLGHOST = "A spirit of a child.",

        CRABKING =
        {
            GENERIC = "They snip and snap.",
            INERT = "That castle needs a little decoration.",
        },
		CRABKING_CLAW = "They're sinking the boat.",

		MESSAGEBOTTLE = "Perhaps we should read it.",
		MESSAGEBOTTLEEMPTY = "Now it's empty.",

        MEATRACK_HERMIT =
        {
            DONE = "Jerky time!",
            DRYING = "Meat takes a while to dry.",
            DRYINGINRAIN = "Meat takes even longer to dry in rain.",
            GENERIC = "Those look like they could use some meat.",
            BURNT = "The rack got dried.",
            DONE_NOTMEAT = "In laboratory terms, we would call that \"dry\".",
            DRYING_NOTMEAT = "Drying thing.",
            DRYINGINRAIN_NOTMEAT = "Rain, rain, go away. Be wet again another day.",
        },
        BEEBOX_HERMIT =
        {
            READY = "It's full.",
            FULLHONEY = "It's full.",
            GENERIC = "There's a bit of sugary treat.",
            NOHONEY = "Nothing yet.",
            SOMEHONEY = "A bit of honey to find.",
            BURNT = "Ash.",
        },

        HERMITCRAB = "Daughter of the see.",

        HERMIT_PEARL = "This is a marvelous craft.",
        HERMIT_CRACKED_PEARL = "The spirit left the body.",

        -- DSEAS
        WATERPLANT = "They are infested with barnacles.",
        WATERPLANT_BOMB = "Quite the power in this.",
        WATERPLANT_BABY = "It's growing.",
        WATERPLANT_PLANTER = "They are bound to the ocean rocks.",

        SHARK = "Teeth of the sea.",

        MASTUPGRADE_LAMP_ITEM = "Simple brightness.",
        MASTUPGRADE_LIGHTNINGROD_ITEM = "I'd rather an eye for this.",

        WATERPUMP = "Puts out the flames.",

        BARNACLE = "Hardened flesh from the sea.",
        BARNACLE_COOKED = "Squishier now.",

        BARNACLEPITA = "We stuffed them in a loaf and called it a dish.",
        BARNACLESUSHI = "That's more presentable.",
        BARNACLINGUINE = "That removed all the hard shells.",
        BARNACLESTUFFEDFISHHEAD = "That feels a bit too crude for my tastes.",

        LEAFLOAF = "Plant flesh... coating?",
        LEAFYMEATBURGER = "Is this a more familiar approach?",
        LEAFYMEATSOUFFLE = "Curious.",
        MEATYSALAD = "Vegetables and fake meat.",

        -- GROTTO

		MOLEBAT = "Rodent of the depths.",
        MOLEBATHILL = "The home of the disease.",

        BATNOSE = "Food is food.",
        BATNOSE_COOKED = "A bit better.",
        BATNOSEHAT = "Sure.",

        MUSHGNOME = "A living part of our home.",

        SPORE_MOON = "Pop, pop!",

        MOON_CAP = "A mushroom full of sleep doses.",
        MOON_CAP_COOKED = "Well it cannot make you sleep anymore.",

        MUSHTREE_MOON = "Mushroom, from our home.",

        LIGHTFLIER = "How strange!",

        GROTTO_POOL_BIG = "The moon water makes the glass grow.",
        GROTTO_POOL_SMALL = "The moon water makes the glass grow.",

        DUSTMOTH = "I love these little guys!",

        DUSTMOTHDEN = "Their little tiny home.",

        ARCHIVE_LOCKBOX = "I'll take a piece.",
        ARCHIVE_CENTIPEDE = "Right, you cannot see that it's me.",
        ARCHIVE_CENTIPEDE_HUSK = "It's downed.",

        ARCHIVE_COOKPOT =
        {
            COOKING_LONG = "It's doing work.",
			COOKING_SHORT = "Any minute now.",
			DONE = "Done.",
			EMPTY = "The art of ancient cooking.",
			BURNT = "Someone lost control of the kitchen.",
        },

        ARCHIVE_MOON_STATUE = "I hope you all like it, it's my craft.",
        ARCHIVE_RUNE_STATUE =
        {
            LINE_1 = "These are my notes!",
            LINE_2 = "This one is about the planned escape to the moon.",
            LINE_3 = "It's about the energy use!",
            LINE_4 = "I remember writing this one just before the collapse.",
            LINE_5 = "...Some things are better not written.",
        },

        ARCHIVE_RESONATOR = {
            GENERIC = "I remember using this often.",
            IDLE = "We have found everything.",
        },

        ARCHIVE_RESONATOR_ITEM = "Find him.",

        ARCHIVE_LOCKBOX_DISPENCER = {
          POWEROFF = "The power is off.",
          GENERIC =  "Give me a piece now.",
        },

        ARCHIVE_SECURITY_DESK = {
            POWEROFF = "The power is off.",
            GENERIC = "Working as intended.",
        },

        ARCHIVE_SECURITY_PULSE = "I see you still work just as well.",

        ARCHIVE_SWITCH = {
            VALID = "This is the right energy.",
            GEMS = "The socket is empty.",
        },

        ARCHIVE_PORTAL = {
            POWEROFF = "Power first.",
            GENERIC = "Where are the other parts?",
        },

        WALL_STONE_2 = "That's a nice wall.",
        WALL_RUINS_2 = "A wall.",

        REFINED_DUST = "Almost like making dough!",   -----------------------new
        DUSTMERINGUE = "I would monch that down!",  ----------------new

        SHROOMCAKE = "So you may never sleep again.",

        NIGHTMAREGROWTH = "They are expanding.",

        TURFCRAFTINGSTATION = "To make the good stuff!",

        MOON_ALTAR_LINK = "It must be building up to something.",

        -- FARMING
        COMPOSTINGBIN =
        {
            GENERIC = "Makes compost.",
            WET = "Too soggy.",
            DRY = "Too dry.",
            BALANCED = "Just right!",
            BURNT = "No more compost for us.",
        },
        COMPOST = "Food for plants.",
        SOIL_AMENDER =
		{
			GENERIC = "Now we wait.",
			STALE = "Wait longer.",
			SPOILED = "It's working.",
		},

		SOIL_AMENDER_FERMENTED = "Very good plant food.",

        WATERINGCAN =
        {
            GENERIC = "I can water the crops with it.",
            EMPTY = "Let's fill it with fresh water.",
        },
        PREMIUMWATERINGCAN =
        {
            GENERIC = "More capacity for water.",
            EMPTY = "Let's fill it right up.",
        },

		FARM_PLOW = "A convenient plot device.",
		FARM_PLOW_ITEM = "Plan your farms carefully.",
		FARM_HOE = "It tills the ground for us.",
		GOLDEN_FARM_HOE = "Same.",
		NUTRIENTSGOGGLESHAT = "I know better alternatives.",
		PLANTREGISTRYHAT = "Knowledge beats all.",

        FARM_SOIL_DEBRIS = "It's making a mess!",

		FIRENETTLES = "If you can't stand the heat, stay out of the garden.",
		FORGETMELOTS = "Hm. I can't remember what I was going to say about those.",
		SWEETTEA = "A nice cup of tea to relax.",
		TILLWEED = "I'll get rid of you!",
		TILLWEEDSALVE = "How worthless.",
        WEED_IVY = "You're not useful to me.",
        IVY_SNARE = "Let me move.",

		TROPHYSCALE_OVERSIZEDVEGGIES =
		{
			GENERIC = "I can weigh my veggies here.",
			HAS_ITEM = "Weight: {weight}\nHarvested on day: {day}\nNot bad.",
			HAS_ITEM_HEAVY = "Weight: {weight}\nHarvested on day: {day}\nQuite heavy!",
            HAS_ITEM_LIGHT = "It's so average the scale isn't even bothering to tell me its weight.",
			BURNING = "It's cooking.",
			BURNT = "I suppose that wasn't the best way to cook it.",
        },

        CARROT_OVERSIZED = "Mother earth has blessed us.",
        CORN_OVERSIZED = "My favourite!",
        PUMPKIN_OVERSIZED = "Pumpkin.",
        EGGPLANT_OVERSIZED = "Is it friend shaped?",
        DURIAN_OVERSIZED = "Love it.",
        POMEGRANATE_OVERSIZED = "The fruit of the fluffy sir!",
        DRAGONFRUIT_OVERSIZED = "Will it fly away?",
        WATERMELON_OVERSIZED = "A big, juicy watermelon.",
        TOMATO_OVERSIZED = "A big juicy tomato.",
        POTATO_OVERSIZED = "Feeds big families.",
        ASPARAGUS_OVERSIZED = "Spear of veggies!",
        ONION_OVERSIZED = "What a big one!",
        GARLIC_OVERSIZED = "A gargantuan garlic!",
        PEPPER_OVERSIZED = "Bite down onto this one, if you dare.",

        VEGGIE_OVERSIZED_ROTTEN = "We left it to decay.",

		FARM_PLANT =
		{
			GENERIC = "It's growing.",
			SEED = "And now, we wait.",
			GROWING = "Grow my beautiful creation, grow!",
			FULL = "Time to reap.",
			ROTTEN = "Too late.",
			FULL_OVERSIZED = "Wowie!",
			ROTTEN_OVERSIZED = "Burn it.",
			FULL_WEED = "I'll dig you out!",

			BURNING = "That won't help them grow...",
		},

        FRUITFLY = "Get away from the garden!",
        LORDFRUITFLY = "I'll bring you down, cursed insect!",
        FRIENDLYFRUITFLY = "It helps us with the garden now.",
        FRUITFLYFRUIT = "I'm the master now.",

        SEEDPOUCH = "Helps us storing little seeds of life.",

		-- Crow Carnival
		CARNIVAL_HOST = "What an odd fellow.",
		CARNIVAL_CROWKID = "Good day to you, small bird person.",
		CARNIVAL_GAMETOKEN = "One shiny token.",
		CARNIVAL_PRIZETICKET =
		{
			GENERIC = "That's the ticket!",
			GENERIC_SMALLSTACK = "That's the tickets!",
			GENERIC_LARGESTACK = "That's a lot of tickets!",
		},

		CARNIVALGAME_FEEDCHICKS_NEST = "It's a little trapdoor.",
		CARNIVALGAME_FEEDCHICKS_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "Seems fun!",
		},
		CARNIVALGAME_FEEDCHICKS_KIT = "Little games.",
		CARNIVALGAME_FEEDCHICKS_FOOD = "Is this edible?",

		CARNIVALGAME_MEMORY_KIT = "Little games.",
		CARNIVALGAME_MEMORY_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "We need to remember well.",
		},
		CARNIVALGAME_MEMORY_CARD =
		{
			GENERIC = "It's a little trapdoor.",
			PLAYING = "Is this the right one?",
		},

		CARNIVALGAME_HERDING_KIT = "Little games.",
		CARNIVALGAME_HERDING_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "Eggs are really good!",
		},
		CARNIVALGAME_HERDING_CHICK = "Come back here!",

		CARNIVALGAME_SHOOTING_KIT = "Little games.",
		CARNIVALGAME_SHOOTING_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "A bit of aiming.",
		},
		CARNIVALGAME_SHOOTING_TARGET =
		{
			GENERIC = "It's a little trapdoor.",
			PLAYING = "That target's really starting to bug me.",
		},

		CARNIVALGAME_SHOOTING_BUTTON =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "What is it?",
		},

		CARNIVALGAME_WHEELSPIN_KIT = "Little games.",
		CARNIVALGAME_WHEELSPIN_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "The best way to earn those!",
		},

		CARNIVALGAME_PUCKDROP_KIT = "Little games.",
		CARNIVALGAME_PUCKDROP_STATION =
		{
			GENERIC = "It won't let me play until I give it something shiny.",
			PLAYING = "Physics don't always work the same way twice.",
		},

		CARNIVAL_PRIZEBOOTH_KIT = "The real prize is the booth we made along the way.",
		CARNIVAL_PRIZEBOOTH =
		{
			GENERIC = "I'll get something nice.",
		},

		CARNIVALCANNON_KIT = "Pow.",
		CARNIVALCANNON =
		{
			GENERIC = "Boom!",
			COOLDOWN = "I liked that.",
		},

		CARNIVAL_PLAZA_KIT = "Birds love trees.",
		CARNIVAL_PLAZA =
		{
			GENERIC = "We need more decorations.",
			LEVEL_2 = "We could add some more.",
			LEVEL_3 = "This is very pretty!",
		},

		CARNIVALDECOR_EGGRIDE_KIT = "Looks pretty.",
		CARNIVALDECOR_EGGRIDE = "We could watch it for hours.",

		CARNIVALDECOR_LAMP_KIT = "Little lamp.",
		CARNIVALDECOR_LAMP = "I like it.",
		CARNIVALDECOR_PLANT_KIT = "Little plant.",
		CARNIVALDECOR_PLANT = "It's tiny, but pretty!",
		CARNIVALDECOR_BANNER_KIT = "Let's build it.",
		CARNIVALDECOR_BANNER = "That was worth it.",

		CARNIVALDECOR_FIGURE =
		{
			RARE = "This one seems rare!",
			UNCOMMON = "I like it.",
			GENERIC = "Those are all nice!",
		},
		CARNIVALDECOR_FIGURE_KIT = "The thrill of discovery!",
		CARNIVALDECOR_FIGURE_KIT_SEASON2 = "The thrill of discovery!",

        CARNIVAL_BALL = "It's genius in its simplicity.", --unimplemented
		CARNIVAL_SEEDPACKET = "More seeds of life, trapped.",
		CARNIVALFOOD_CORNTEA = "Little corn snack!",

        CARNIVAL_VEST_A = "I sadly cannot enjoy these.",
        CARNIVAL_VEST_B = "I wish I could wear it.",
        CARNIVAL_VEST_C = "Perhaps I'll pass it to a friend.",

        -- YOTB
        YOTB_SEWINGMACHINE = "We can sew here.",
        YOTB_SEWINGMACHINE_ITEM = "There looks to be a bit of assembly required.",
        YOTB_STAGE = "He's always within.",
        YOTB_POST =  "Let's get going!",
        YOTB_STAGE_ITEM = "Let's build it.",
        YOTB_POST_ITEM =  "I'd better get that set up.",


        YOTB_PATTERN_FRAGMENT_1 = "We can make good fabric with those.",
        YOTB_PATTERN_FRAGMENT_2 = "We can make good fabric with those.",
        YOTB_PATTERN_FRAGMENT_3 = "We can make good fabric with those.",

        YOTB_BEEFALO_DOLL_WAR = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },
        YOTB_BEEFALO_DOLL_DOLL = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },
        YOTB_BEEFALO_DOLL_FESTIVE = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },
        YOTB_BEEFALO_DOLL_NATURE = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },
        YOTB_BEEFALO_DOLL_ROBOT = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },
        YOTB_BEEFALO_DOLL_ICE = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },
        YOTB_BEEFALO_DOLL_FORMAL = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },
        YOTB_BEEFALO_DOLL_VICTORIAN = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },
        YOTB_BEEFALO_DOLL_BEAST = {
            GENERIC = "A little doll.",
            YOTB = "Let's see what the gamemaster says.",
        },

        WAR_BLUEPRINT = "Boofy of war!",
        DOLL_BLUEPRINT = "A little cutesy.",
        FESTIVE_BLUEPRINT = "Sparkly little boof.",
        ROBOT_BLUEPRINT = "Fake mechanics.",
        NATURE_BLUEPRINT = "The beauty of nature.",
        FORMAL_BLUEPRINT = "Do people wear this to look cool?",
        VICTORIAN_BLUEPRINT = "It feels ancient... Not me!",
        ICE_BLUEPRINT = "In the ice.",
        BEAST_BLUEPRINT = "I like this one, very dragon-like.",

        BEEF_BELL = "Makes the boofies friendly.",

		-- YOT Catcoon
		KITCOONDEN =
		{
			GENERIC = "Little devils inside.",
            BURNT = "NOOOO!",
			PLAYING_HIDEANDSEEK = "Now where could they be...",
			PLAYING_HIDEANDSEEK_TIME_ALMOST_UP = "Where are they hiding.",
		},

		KITCOONDEN_KIT = "Little house for the devils.",

		TICOON =
		{
			GENERIC = "Let's see.",
			ABANDONED = "I'll find them myself.",
			SUCCESS = "He found one!",
			LOST_TRACK = "Someone else found them first.",
			NEARBY = "Looks like there's something nearby.",
			TRACKING = "Let's follow him.",
			TRACKING_NOT_MINE = "He's leading the way for someone else.",
			NOTHING_TO_TRACK = "We got them all.",
			TARGET_TOO_FAR_AWAY = "We need to get closer.",
		},

		YOT_CATCOONSHRINE =
        {
            GENERIC = "What to make...",
            EMPTY = "Let's give it a feather.",
            BURNT = "Smells like scorched fur.",
        },

		KITCOON_FOREST = "Little devil.",
		KITCOON_SAVANNA = "Little devil.",
		KITCOON_MARSH = "Little devil.",
		KITCOON_DECIDUOUS = "Little devil.",
		KITCOON_GRASS = "Little devil.",
		KITCOON_ROCKY = "Little devil.",
		KITCOON_DESERT = "Little devil.",
		KITCOON_MOON = "Little devil.",
		KITCOON_YOT = "Little devil.",

        -- Moon Storm
        ALTERGUARDIAN_PHASE1 = {
            GENERIC = "It has only begun.",
            DEAD = "One third done.",
        },
        ALTERGUARDIAN_PHASE2 = {
            GENERIC = "Now we continue.",
            DEAD = "Two parts down.",
        },
        ALTERGUARDIAN_PHASE2SPIKE = "Let's avoid that!",
        ALTERGUARDIAN_PHASE3 = "The final one.",
        ALTERGUARDIAN_PHASE3TRAP = "No sleep.",
        ALTERGUARDIAN_PHASE3DEADORB = "We have destroyed it.",
        ALTERGUARDIAN_PHASE3DEAD = "We have destroyed it.",

        ALTERGUARDIANHAT = "Let's whip up something nice at the clock!",
        ALTERGUARDIANHATSHARD = "I can't use it anymore.",

        MOONSTORM_GLASS = {
            GENERIC = "A bit of glass.",
            INFUSED = "It'll come in handy."
        },

        MOONSTORM_STATIC = "...",
        MOONSTORM_STATIC_ITEM = "I wish I could meet with you here.",
        MOONSTORM_SPARK = "Zapping!",

        BIRD_MUTANT = "Poor fellas.",
        BIRD_MUTANT_SPITTER = "I cannot help you...",

        WAGSTAFF_NPC = "You aren't doing this world a favour.",
		
		WAGSTAFF_NPC_MUTATIONS = "What a crude way to do research.",
        WAGSTAFF_NPC_WAGPUNK = "Is he leading us somewhere?",
		
        ALTERGUARDIAN_CONTAINED = "He's gotten trapped...",

        WAGSTAFF_TOOL_1 = "He said he called it reticulating buffer.",
        WAGSTAFF_TOOL_2 = "He said he called it widget deflubber.",
        WAGSTAFF_TOOL_3 = "He said he called it grommet scriber.",
        WAGSTAFF_TOOL_4 = "He said he called it conceptual scrubber.",
        WAGSTAFF_TOOL_5 = "He said he called it calibrated perceiver.",

        MOONSTORM_GOGGLESHAT = "That doesn't fit my face.",

        MOON_DEVICE = {
            GENERIC = "Am I going to see you again my love?",
            CONSTRUCTION1 = "Only one step closer to you.",
            CONSTRUCTION2 = "Closer...",
        },

		-- Wanda
        POCKETWATCH_HEAL = {
			GENERIC = "It can be used.",
			RECHARGING = "The time is always wrong.",
		},

        POCKETWATCH_REVIVE = {
			GENERIC = "It can be used.",
			RECHARGING = "The time is always wrong.",
		},

        POCKETWATCH_WARP = {
			GENERIC = "It can be used.",
			RECHARGING = "The time is always wrong.",
		},

        POCKETWATCH_RECALL = {
			GENERIC = "It can be used.",
			RECHARGING = "The time is always wrong.",
			UNMARKED = "only_used_by_wanda",
			MARKED_SAMESHARD = "only_used_by_wanda",
			MARKED_DIFFERENTSHARD = "only_used_by_wanda",
		},

        POCKETWATCH_PORTAL = {
			GENERIC = "It can be used.",
			RECHARGING = "The time is always wrong.",
			UNMARKED = "only_used_by_wanda unmarked",
			MARKED_SAMESHARD = "only_used_by_wanda same shard",
			MARKED_DIFFERENTSHARD = "only_used_by_wanda other shard",
		},

        POCKETWATCH_WEAPON = {
			GENERIC = "The time is always wrong.",
			DEPLETED = "only_used_by_wanda",
		},

        POCKETWATCH_PARTS = "Time guts.",
        POCKETWATCH_DISMANTLER = "Tools.",

        POCKETWATCH_PORTAL_ENTRANCE =
		{
			GENERIC = "Onward!",
			DIFFERENTSHARD = "Onward!",
		},
        POCKETWATCH_PORTAL_EXIT = "Quite the drop!",

        -- Waterlog
        WATERTREE_PILLAR = "As the nature makes it's roots.",
        OCEANTREE = "They aren't grown to their potential yet.",
        OCEANTREENUT = "We can plant this.",
        WATERTREE_ROOT = "The extra limbs of the trees.",

        OCEANTREE_PILLAR = "They are quite tall!",

        OCEANVINE = "Reminds me of.... bat flies.",
        FIG = "Smells like nothing.",
        FIG_COOKED = "Sweet, yet without taste.",

        SPIDER_WATER = "They adapted to the sea.",
        MUTATOR_WATER = "Spider food.",
        OCEANVINE_COCOON = "Quite fitting for the environment.",
        OCEANVINE_COCOON_BURNT = "It burnt down.",

        GRASSGATOR = "I'll smooch you on the forehead, you fluffy gator!",

        TREEGROWTHSOLUTION = "It'll aid the tree in their growth.",

        FIGATONI = "That made the figs taste much better.",
        FIGKABAB = "Impaled fig flesh.",
        KOALEFIG_TRUNK = "A poor beast went into the making of this.",
        FROGNEWTON = "That's very unfilling for what it is.",

        -- The Terrorarium
        TERRARIUM = {
            GENERIC = "Eye think I know what this is.",
            CRIMSON = "Let's bring them down.",
            ENABLED = "Let's get ready!",
			WAITING_FOR_DARK = "We fight at night.",
			COOLDOWN = "We need to give it time to make new eyes.",
			SPAWN_DISABLED = "Someone didn't allow us to get eyes...",
        },

        -- Wolfgang
        MIGHTY_GYM =
        {
            GENERIC = "Allows them to maintain their force.",
            BURNT = "Too much exercising.",
        },

        DUMBBELL = "Is it a tool?",
        DUMBBELL_GOLDEN = "Is it supposed to do something?",
		DUMBBELL_MARBLE = "It is pretty heavy!",
        DUMBBELL_GEM = "You've used my materials for this?",
        POTATOSACK = "A rock bag?",
		
		DUMBBELL_HEAT = "Pocket heat source.",
        DUMBBELL_REDGEM = "I'd rather using the gem for something nicer.",
        DUMBBELL_BLUEGEM = "I suppose it is useful sometimes.",


        TERRARIUMCHEST =
		{
			GENERIC = "Ours now.",
			BURNT = "Who burnt it down?!",
			SHIMMER = "We want what's within.",
		},

		EYEMASKHAT = "Of no use for me.",

        EYEOFTERROR = "I'll get your eye!",
        EYEOFTERROR_MINI = "Their minions.",
        EYEOFTERROR_MINI_GROUNDED = "Let's kill it before it hatches.",

        FROZENBANANADAIQUIRI = "Little sugary snack of the isles.",
        BUNNYSTEW = "Little flesh in a broth.",
        MILKYWHITES = "I could refine this into an eye!",

        CRITTER_EYEOFTERROR = "Eye enjoy your presence!",

        SHIELDOFTERROR ="What does that mouth do?",
        TWINOFTERROR1 = "Soul of sight? Anyone?",
        TWINOFTERROR2 = "Hallowed bars? Anyone?",
		
		
		-- Cult of the Lamb
		COTL_TRINKET = "Not a crown fit for me.",
		TURF_COTL_GOLD = "How opulent.",
		TURF_COTL_BRICK = "I'd rather a feeling of home...",
		COTL_TABERNACLE_LEVEL1 =
		{
			LIT = "What a soothing light.",
			GENERIC = "It needs some fuel.",
		},
		COTL_TABERNACLE_LEVEL2 =
		{
			LIT = "An odd preacher?",
			GENERIC = "It needs some fuel.",
		},
		COTL_TABERNACLE_LEVEL3 =
		{
			LIT = "I don't understand this God.",
			GENERIC = "It needs some fuel.",
		},

        -- Year of the Catcoon
        CATTOY_MOUSE = "Mice with wheels.",
        KITCOON_NAMETAG = "Give them little names!",

		KITCOONDECOR1 =
        {
            GENERIC = "It's not a real bird, but they're unaware.",
            BURNT = "Combustion!",
        },
		KITCOONDECOR2 =
        {
            GENERIC = "I love those tiny decors.",
            BURNT = "It went up in flames.",
        },

		KITCOONDECOR1_KIT = "It looks like there's some assembly required.",
		KITCOONDECOR2_KIT = "It doesn't look too hard to build.",

        -- WX78
        WX78MODULE_MAXHEALTH = "Little baubles for the robot.",
        WX78MODULE_MAXSANITY1 = "Little baubles for the robot.",
        WX78MODULE_MAXSANITY = "Little baubles for the robot.",
        WX78MODULE_MOVESPEED = "Little baubles for the robot.",
        WX78MODULE_MOVESPEED2 = "Little baubles for the robot.",
        WX78MODULE_HEAT = "Little baubles for the robot.",
        WX78MODULE_NIGHTVISION = "Little baubles for the robot.",
        WX78MODULE_COLD = "Little baubles for the robot.",
        WX78MODULE_TASER = "Little baubles for the robot.",
        WX78MODULE_LIGHT = "Little baubles for the robot.",
        WX78MODULE_MAXHUNGER1 = "Little baubles for the robot.",
        WX78MODULE_MAXHUNGER = "Little baubles for the robot.",
        WX78MODULE_MUSIC = "Little baubles for the robot.",
        WX78MODULE_BEE = "Little baubles for the robot.",
        WX78MODULE_MAXHEALTH2 = "Little baubles for the robot.",

        WX78_SCANNER =
        {
            GENERIC ="It's their sidekick.",
            HUNTING = "It's researching.",
            SCANNING = "Seems like it's found something.",
        },

        WX78_SCANNER_ITEM = "Get to work, little robot.",
        WX78_SCANNER_SUCCEEDED = "It got something.",

        WX78_MODULEREMOVER = "About as delicate as me using a razor on myself.",

        SCANDATA = "I cannot comprehend those.",

		-- QOL 2022
		JUSTEGGS = "Eggs onto more eggs!",
		VEGGIEOMLET = "A little egg with a side of vegetables!",
		TALLEGGS = "A big meal fit for a.. me!",
		BEEFALOFEED = "That's food for the boofies!",
		BEEFALOTREAT = "A sweet treat for the boofies!",

        -- Pirates
        BOAT_ROTATOR = "It turns the boat around.",
        BOAT_ROTATOR_KIT = "Let's settle it down, shall we?",
        BOAT_BUMPER_KELP = "A small protection, so we don't sink.",
        BOAT_BUMPER_KELP_KIT = "Let's stick it to the boat.",
        BOAT_BUMPER_SHELL = "I could've used those shells!",
        BOAT_BUMPER_SHELL_KIT = "I'm disappointed in the usage of those shells.",
        BOAT_CANNON = {
            GENERIC = "Let's load it.",
            AMMOLOADED = "Ready to shoot!",
            NOAMMO = "I need to load it first.",
        },
        BOAT_CANNON_KIT = "A good piece of craftmanship!",
        CANNONBALL_ROCK_ITEM = "Cannon ammo.",

        OCEAN_TRAWLER = {
            GENERIC = "Catch the flesh easier.",
            LOWERED = "And now we wait.",
            CAUGHT = "We got something.",
            ESCAPED = "The net is destroyed.",
            FIXED = "It can work again.",
        },
        OCEAN_TRAWLER_KIT = "Put it somewhere with lots of fish.",

        BOAT_MAGNET =
        {
            GENERIC = "Can attract other magnets.",
            ACTIVATED = "Good thing this wasn't my invention.",
        },
        BOAT_MAGNET_KIT = "Quite an insane idea.",

        BOAT_MAGNET_BEACON =
        {
            GENERIC = "It attracts them towards eachother.",
            ACTIVATED = "It's on.",
        },
        DOCK_KIT = "We may expand our influence to the sea!",
        DOCK_WOODPOSTS_ITEM = "Appreciate little details.",

        MONKEYHUT =
        {
            GENERIC = "Burn it down.",
            BURNT = "Good riddance.",
        },
        POWDER_MONKEY = "Sir of the isles, in spirits of stealing.",
        PRIME_MATE = "Seems to be the leader.",
		LIGHTCRAB = "A little bit of energy.",
        CUTLESS = "That's not a weapon.",
        CURSED_MONKEY_TOKEN = "Attached to the soul.",
        OAR_MONKEY = "A paddle that can do serious damage.",
        BANANABUSH = "It'll grow some of those fruits from underground.",
        DUG_BANANABUSH = "Plant it where you need it!",
        PALMCONETREE = "Palm tree.",
        PALMCONE_SEED = "The very beginnings of a tree.",
        PALMCONE_SAPLING = "It'll get there.",
        PALMCONE_SCALE = "Husk of the palm tree.",
        MONKEYTAIL = "Grow some scroll materials.",
        DUG_MONKEYTAIL = "Grow some scroll materials.",

        MONKEY_MEDIUMHAT = "None for me, thank you.",
        MONKEY_SMALLHAT = "I'll rather my own.",
        POLLY_ROGERSHAT = "Someone else may wear this!",
        POLLY_ROGERS = "Little birdie.",

        MONKEYISLAND_PORTAL = "This is no escape.",
        MONKEYISLAND_PORTAL_DEBRIS = "Remains of an experiment.",
        MONKEYQUEEN = "The leader of them all.",
        MONKEYPILLAR = "It holds it together.",
        PIRATE_FLAG_POLE = "I miss our old banners...",

        BLACKFLAG = "A better looking flag.",
        PIRATE_STASH = "Let's get digging.",
        STASH_MAP = "Read it.",


        BANANAJUICE = "Sweet snack from bananas.",

        FENCE_ROTATOR = "Watch me swirl.",

        CHARLIE_STAGE_POST = "The set.",
        CHARLIE_LECTURN = "For storytelling.",

        CHARLIE_HECKLER = "Brr.",

        PLAYBILL_THE_DOLL = "\"Authored by C.W.\"",
        STATUEHARP_HEDGESPAWNER = "The flowers grew back, but the head hasn't.",
        HEDGEHOUND = "Twisted brambles.",
        HEDGEHOUND_BUSH = "It moves and bites, to no result.",

        MASK_DOLLHAT = "It's a doll mask.",
        MASK_DOLLBROKENHAT = "It's a cracked doll mask.",
        MASK_DOLLREPAIREDHAT = "It was a doll mask at one point.",
        MASK_BLACKSMITHHAT = "It's a blacksmith mask.",
        MASK_MIRRORHAT = "It's a mirror mask.",
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
            STANDING = "Don't touch me.",
            SITTING = "Wrong.",
        },
        SEWING_MANNEQUIN =
        {
            GENERIC = "Rest now.",
            BURNT = "...",
        },
		-- Waxwell
		MAGICIAN_CHEST = "Storage to a small pocket dimension.",
		TOPHAT_MAGICIAN = "My face is more important than this.",

        -- Year of the Rabbit
        YOTR_FIGHTRING_KIT = "Some celebratory formation.",
        YOTR_FIGHTRING_BELL =
        {
            GENERIC = "It's peaceful, for now.",
            PLAYING = "As long as I get to keep my face on.",
        },

        YOTR_DECOR_1 = {
            GENERAL = "Small whimsical light.",
            OUT = "It's out.",
        },
        YOTR_DECOR_2 = {
            GENERAL = "Small whimsical light.",
            OUT = "It's out.",
        },

        HAREBALL = "Regurgitared snack.",
        YOTR_DECOR_1_ITEM = "I know just the place for it.",
        YOTR_DECOR_2_ITEM = "I know just the place for it.",

		--
		DREADSTONE = "Sturdy self mending material.",
		HORRORFUEL = "A much more concentrated form of the fuel.",
		DAYWALKER =
		{
			GENERIC = "The fighter is free.",
			IMPRISONED = "I too, was trapped for a while.",
		},
		DAYWALKER_PILLAR =
		{
			GENERIC = "We can mine this.",
			EXPOSED = "This might need some brute force.",
		},
		DAYWALKER2 =
		{
			GENERIC = "Someone looks mad.",
			BURIED = "Got yourself in quite the situation, didn't you?",
			HOSTILE = "Here comes the raging anger.",
		},
		ARMORDREADSTONE = "Self mending, at the cost of one's mind.",
		DREADSTONEHAT = "Even I have some shred of decency in appearance.",

        -- Rifts 1
        LUNARRIFT_PORTAL = "Are you within, my dear?",
        LUNARRIFT_CRYSTAL = "A form of brightness, as a material.",

        LUNARTHRALL_PLANT = "I don't remember allowing you here.",
        LUNARTHRALL_PLANT_VINE_END = "They're pretty territorial.",

		LUNAR_GRAZER = "Protector of the rift.",

        PUREBRILLIANCE = "I could use this in my craft!",
        LUNARPLANT_HUSK = "A strong shell.",

		LUNAR_FORGE = "Workshop of the lunar worker.",
		LUNAR_FORGE_KIT = "Place it somewhere nice!",

		LUNARPLANT_KIT = "Fix the broken equipment.",
		ARMOR_LUNARPLANT = "My exoskeleton might fit the task better.",
		LUNARPLANTHAT = "I'd rather my own face.",
		BOMB_LUNARPLANT = "Quite the explosion!",
		STAFF_LUNARPLANT = "It casts orbs that disperse shadows.",
		SWORD_LUNARPLANT = "Harness the moon.",
		PICKAXE_LUNARPLANT = "Mine it all.",
		SHOVEL_LUNARPLANT = "Multitool of the farmer.",

		BROKEN_FORGEDITEM = "It needs mending.",

        PUNCHINGBAG = "To test our strength.",

        -- Rifts 2
        SHADOWRIFT_PORTAL = "It goes deep within the depths.",

		SHADOW_FORGE = "Meddle closely with the shadows.",
		SHADOW_FORGE_KIT = "Almost like an evil lab.",

        FUSED_SHADELING = "Here you are again.",
        FUSED_SHADELING_BOMB = "Explosives.",

		VOIDCLOTH = "Cloth from below.",
		VOIDCLOTH_KIT = "Mend the nightmares.",
		VOIDCLOTHHAT = "Feel entrapped in Them.",
		ARMOR_VOIDCLOTH = "Dance in it, and you will feel yourself going astray.",

        VOIDCLOTH_UMBRELLA = "My own umbrella does the job just as well.",
        VOIDCLOTH_SCYTHE = "Tool of the worker.",

		SHADOWTHRALL_HANDS = "Hello you.",
		SHADOWTHRALL_HORNS = "Could eat you whole.",
		SHADOWTHRALL_WINGS = "It doesn't seem to fly.",

        CHARLIE_NPC = "The new ruler of the below.",
        CHARLIE_HAND = "Will you make an offering?",

        NITRE_FORMATION = "Harvestable.",
        DREADSTONE_STACK = "Formation of strong material.",
        
        SCRAPBOOK_PAGE = "A fellow researcher's results!",

        LEIF_IDOL = "A minuscule version of the protectors of the forest.",
        WOODCARVEDHAT = "I'm not cut for this.",
        WALKING_STICK = "Helps us not trip of rocks.",

        IPECACSYRUP = "Forced digestion syrup.",
        BOMB_LUNARPLANT_WORMWOOD = "Nice job.", -- Unused
        WORMWOOD_MUTANTPROXY_CARRAT =
        {
        	DEAD = "That's the end of that.",
        	GENERIC = "Are carrots supposed to have legs?",
        	HELD = "You're kind of ugly up close.",
        	SLEEPING = "It's almost cute.",
        },
        WORMWOOD_MUTANTPROXY_LIGHTFLIER = "Flying lights.",
		WORMWOOD_MUTANTPROXY_FRUITDRAGON =
		{
			GENERIC = "Hello little dragon.",
			RIPE = "It has reached potential.",
			SLEEPING = "It's snoozing.",
		},

        SUPPORT_PILLAR_SCAFFOLD = "We must provide some more.",
        SUPPORT_PILLAR = "It needs fixing.",
        SUPPORT_PILLAR_COMPLETE = "Protects us from debris.",
        SUPPORT_PILLAR_BROKEN = "And so everything collapsed.",

		SUPPORT_PILLAR_DREADSTONE_SCAFFOLD = "It needs work.",
		SUPPORT_PILLAR_DREADSTONE = "It needs fixing.",
		SUPPORT_PILLAR_DREADSTONE_COMPLETE = "Self mending, and resistant.",
		SUPPORT_PILLAR_DREADSTONE_BROKEN = "Even the strongest ones can fall.",

        WOLFGANG_WHISTLE = "A sound of encouragement.",

        -- Rifts 3

        MUTATEDDEERCLOPS = "Forced to move once more.",
        MUTATEDWARG = "It has lost control of itself.",
        MUTATEDBEARGER = "Cursed by the moon, mind invaded.",

        LUNARFROG = "The normal ones were already bad.",

        DEERCLOPSCORPSE =
        {
            GENERIC  = "Down it goes.",
            BURNING  = "Can't be too careful.",
            REVIVING = "Forced to live.",
        },

        WARGCORPSE =
        {
            GENERIC  = "Put down.",
            BURNING  = "It's for the best.",
            REVIVING = "Up again.",
        },

        BEARGERCORPSE =
        {
            GENERIC  = "Poor guy.",
            BURNING  = "That was close.",
            REVIVING = "A shell forced to live again.",
        },

        BEARGERFUR_SACK = "A portable freezer?",
        HOUNDSTOOTH_BLOWPIPE = "Fight with safety.",
        DEERCLOPSEYEBALL_SENTRYWARD =
        {
            GENERIC = "Freeze the world.",    -- Enabled.
            NOEYEBALL = "Add a sight.",  -- Disabled.
        },
        DEERCLOPSEYEBALL_SENTRYWARD_KIT = "Place it down.",

        SECURITY_PULSE_CAGE = "It needs energy, from home.",
        SECURITY_PULSE_CAGE_FULL = "Rekindled with our energy.",

		CARPENTRY_STATION =
        {
            GENERIC = "It makes furniture.",
            BURNT = "It doesn't make furniture anymore.",
        },

        WOOD_TABLE = -- Shared between the round and square tables.
        {
            GENERIC = "Art of the table.",
            HAS_ITEM = "Art of the table.",
            BURNT = "And it burns.",
        },

        WOOD_CHAIR =
        {
            GENERIC = "Get some restful sitting.",
            OCCUPIED = "I can't sit with someone on it already.",
            BURNT = "I wouldn't like to sit on that.",
        },

        DECOR_CENTERPIECE = "Art is a respectable way of life.",
        DECOR_LAMP = "A welcoming light.",
        DECOR_FLOWERVASE =
        {
            GENERIC = "A vase of flowers.",
            EMPTY = "It needs flowers.",
            WILTED = "Not looking very fresh.",
            FRESHLIGHT = "It's  a little light.",
            OLDLIGHT = "It's dying out.",
        },
        DECOR_PICTUREFRAME =
        {
            GENERIC = "It's beautiful.",
            UNDRAWN = "I should draw something in this.",
        },
        DECOR_PORTRAITFRAME = "Looking good!",

        PHONOGRAPH = "Play the songs and you shall soothe yourself.",
        RECORD = "Could drive you insane.",
        RECORD_CREEPYFOREST = "Music is an art in itself!",
        RECORD_DANGER = "To feel on the edge.",
        RECORD_DAWN = "Interesting.",
        RECORD_DRSTYLE = "Music is an art in itself!",
        RECORD_DUSK = "A little jingle.",
        RECORD_EFS = "An attempt at variety.",
        RECORD_END = "Music is an art in itself!",
        RECORD_MAIN = "One could feel invested in this.",
        RECORD_WORKTOBEDONE = "Finally a little tune.",

        ARCHIVE_ORCHESTRINA_MAIN = "Improved security.",

        WAGPUNKHAT = "A mechanics helmet.",
        ARMORWAGPUNK = "Combat analysis.",
        WAGSTAFF_MACHINERY = "We can harvest it.",
        WAGPUNK_BITS = "Might be useful.",
        WAGPUNKBITS_KIT = "Mend the bits of gears.",

        WAGSTAFF_MUTATIONS_NOTE = "A scientist's notes.",
		
		-- Meta 3

        BATTLESONG_INSTANT_REVIVE = "To delay your final gasp!",

        WATHGRITHR_IMPROVEDHAT = "I'm still in desbelief that it provides any protective value.",
        SPEAR_WATHGRITHR_LIGHTNING = "Now that's how you harness their power!",

        BATTLESONG_CONTAINER = "I too own something of the same convenience for my craft, good idea!",

        SADDLE_WATHGRITHR = "Share your pure raw emotions with your steed to steel through battle.",

        WATHGRITHR_SHIELD = "Perhaps I could come up with something similar...",

        BATTLESONG_SHADOWALIGNED = "Harness the shadows!",
        BATTLESONG_LUNARALIGNED = "Harness the moon!",

		SHARKBOI = "A resident of the frozen wastes!",
        BOOTLEG = "I wonder if the smell is necessary for the portal.",
        OCEANWHIRLPORTAL = "Effective ocean travelling, masterful!",

        EMBERLIGHT = "A residue of their beings, fueled with rage.",
        WILLOW_EMBER = "only_used_by_willow",

        -- Year of the Dragon
        YOTD_DRAGONSHRINE =
        {
            GENERIC = "We have made an offering.",
            EMPTY = "Let us add a bit of coal.",
            BURNT = "Well, now it turned into coal.",
        },

        DRAGONBOAT_KIT = "A boat of peculiar design.",
        DRAGONBOAT_PACK = "A gizmo kit for a full themed boat!",

        BOATRACE_CHECKPOINT = "We've reached it.",
        BOATRACE_CHECKPOINT_THROWABLE_DEPLOYKIT = "Trace the path.",
        BOATRACE_START = "There's always a start.",
        BOATRACE_START_THROWABLE_DEPLOYKIT = "A race needs a start and a finish.",

        BOATRACE_PRIMEMATE = "I see someone enjoys the festivities!",
        BOATRACE_SPECTATOR_DRAGONLING = "Thanks for the cheering, kind one!",

        YOTD_STEERINGWHEEL = "Driving your point at sea.",
        YOTD_STEERINGWHEEL_ITEM = "Let's place that on a boat.",
        YOTD_OAR = "Manual labour.",
        YOTD_ANCHOR = "To set your foot down.",
        YOTD_ANCHOR_ITEM = "I can build an anchor.",
        MAST_YOTD = "On theme with the festivities, I see!",
        MAST_YOTD_ITEM = "Let's place that down.",
        BOAT_BUMPER_YOTD = "Protective measures.",
        BOAT_BUMPER_YOTD_KIT = "Kit made with safety in mind.",
        BOATRACE_SEASTACK = "An obstacle.",
        BOATRACE_SEASTACK_THROWABLE_DEPLOYKIT = "An obstacle.",
        BOATRACE_SEASTACK_MONKEY = "An obstacle.",
        BOATRACE_SEASTACK_MONKEY_THROWABLE_DEPLOYKIT = "An obstacle.",
        MASTUPGRADE_LAMP_YOTD = "A friendly onlook of brightness.",
        MASTUPGRADE_LAMP_ITEM_YOTD = "Hands-free boating.",
        WALKINGPLANK_YOTD = "Just in case.",
        CHESSPIECE_YOTD = "A cheery being!",
------------------------------------------------------------------------------------------------------------------ MARCH 2024 QOL --------------------------------------------------------------------
		HEALINGSALVE_ACID = "I highly doubt that'll function for me.",

        BEESWAX_SPRAY = "Freeze them in a neverending glory.",
        WAXED_PLANT = "The pictural beauty frozen in place.", -- Used for all waxed plants, from farm plants to trees.

        STORAGE_ROBOT = {
            GENERIC = "We used to have carriers in our times, this can do.",
            BROKEN = "It needs repairs.",
        },

        SCRAP_MONOCLEHAT = "Improves one's onlook of the world.",
        SCRAPHAT = "That won't come to much use to me.",

        FENCE_JUNK = "It barely holds itself together.",
        JUNK_PILE = "We could find something within.",
        JUNK_PILE_BIG = "Quite unstable.",

        ARMOR_LUNARPLANT_HUSK = "Great way to improve on one's design!",
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		LIQUID_MIRROR = "Shifting gas, rotating solid, liquid mirror.",
		WHY_REDGEM_SEED = "Shards of a heart, warming embrace.",
		WHY_REDGEM_FORMATION = "Its heart skips resonate with mine.",
		WHY_REDGEM_OVERGROWN = "Wonderful crimson formation, isn't it?",
		WHY_BLUEGEM_SEED = "Shards of ice, cold unpredictable.",
		WHY_BLUEGEM_FORMATION = "Sends shivers down my spine.",
		WHY_BLUEGEM_OVERGROWN = "I feel safe.",
		WHY_PURPLEGEM_SEED = "Shards of insanity.",
		WHY_PURPLEGEM_FORMATION = "It hooks you in and never allows you to leave.",
		WHY_PURPLEGEM_OVERGROWN = "Do you believe in magic?",
		WHY_GREENGEM_SEED = "Shards of transformation.",
		WHY_GREENGEM_FORMATION = "It shifts when you touch it.",
		WHY_GREENGEM_OVERGROWN = "Don't look away now, it's angry.",
		WHY_ORANGEGEM_SEED = "Shards of memory, and time.",
		WHY_ORANGEGEM_FORMATION = "Spiral into horror.",
		WHY_ORANGEGEM_OVERGROWN = "The monument on edge between the past and present.",
		WHY_YELLOWGEM_SEED = "Shards of light and hope.",
		WHY_YELLOWGEM_FORMATION = "Take me somewhere pretty.",
		WHY_YELLOWGEM_OVERGROWN = "I'm sure you understand what it looks like.",
		WHY_OPALGEM_SEED = "Shards of cosmic horrors.",
		WHY_OPALGEM_FORMATION = "Unimaginable becomes believable.",
		WHY_OPALGEM_OVERGROWN = "It scares me.",
		WHY_REFINED_LUREPLANT = "Earth hands!",
		WHY_REFINED_PLANTERA = "Sing an ode, for mother earth.",
		WHY_REFINED_DESERTSTONE = "Become the center of the universe.",
		WHY_REFINED_MILKY = "Reverse starvation.",
		WHY_REFINED_LIGHTBULB = "Little light.",
		WHY_REFINED_BUTTERFLY = "I am sorry for this.", --TODO
		WHY_REFINED_BUTTERFLY_MOON = "Moths from the moon, crushed.", --TODO
		WHY_REFINED_GLASSWHITES = "I see you.",
		WHY_REFINED_GOLD = "Obtain overwhelming and crushing wisdom.",
		WHY_REFINED_MARBLE = "MEOW.MUR?",
		WHY_REFINED_MOONROCK = "May it rain from the skies.",
		WHY_REFINED_FLINT = "Sharpen the vision.",
		WHY_REFINED_REDGEM = "It consumes me, as a stomach would.",
		WHY_REFINED_BLUEGEM = "The cold doesn't leave.",
		WHY_REFINED_PURPLEGEM = "Peek into insanity, as long as you like.",
		WHY_REFINED_GREENGEM = "Look at the time, it's plant o'clock.",
		WHY_REFINED_ORANGEGEM = "Devour everything.",
		WHY_REFINED_YELLOWGEM = "Glow.",
		WHY_REFINED_OPALGEM = "Hibernate.",
		WHY_PERFECTIONGEM = "Never feel weak again.",
		WHY_NOTHINGNESSGEM = "Work tirelessly through the night.",
		ANCIENTDREAMS_GEMSHARD = "Food for the soul.",
		WHYEHAT_HELM = "Merely chunks of what makes a face.", --TODO
		WHYEHAT_HELMET = "This can be worn, it will protect.", --TODO
		WHYEHAT_DREADSTONE = "I'll unleash my anger upon my enemies!", --TODO
		WHYEHAT_DREADSTONE_BROKEN = "My anger has led to it breaking, it will regenerate.", --TODO
        WHYEHAT_DREADSTONE_ADRAMMELECH = "I'll unleash my anger upon my enemies!", --TODO
		WHYEHAT_DREADSTONE_BROKEN_ADRAMMELECH = "My anger has led to it breaking, it will regenerate.", --TODO
		WHYEHAT = "A relic of who I once was.",
		WHYEHAT_FACE = "Am I pretty now?",
        WHYEHAT_FACE_TENTACLE = "Am I pretty now?",
        WHYEHAT_FACE_DEMON = "Am I pretty now?",
		WHYEARMOR = "It is me who feels whole again.",
		WHYEARMOR_BACKPACK = "I call it the jewel-storage-unit-inator!",
		WHYEARMOR_INCOMPLETE = "I want to feel whole again.",
		WHYEARMOR_PROSTHESIS = "I want to feel whole again.",
		WHYEARMOR_PILE = "I am crushed into bits and pieces.",
		WHYCRANK = "For holding gems in place while we refine them.",
		WHYTORCH = "Lighten up your path.",
		WHYPIERCER = "I'll make the way.",
		WHYLIFEPEELER = "Soul release, piece by piece.",
		WHYTEPADLO = "Be anywhere anytime, that's why I love my inventions!",
		WHYBRELLA = "Waltz around in the rain, in all its glory.",
		WHYFLUTOSCOPE = "A tool of the trumpeter that announces war.",
		WHYLANTERN = "The shell shape is essential to amplify the light distribution.",
		WHYFREEZER = "The temperature, deathly low - just how I like it.",
		WHYCRUSHER = "Pay tribute and enjoy its essence.",
		WHYJEWELLAB = "Just like in my workshop.",
		WHYGLOBELAB = "For ancient ways.",
        --1.7
        WHY_KLAUS_SACK_PIECE = "Torn cloth of this quality may be useful for storing jewels...",
		ANCIENTDREAMS_GEGG = "The most important meal of the day, gem style.",
		ANCIENTDREAMS_CANDY = "A refined gem shard with a honey coating, helps consumption.",
        WHY_CRYSTAL_FLOWERS = "A beauty captured in a crystal shell, unlike I.",
        ANCIENTDREAMS_CUBE = "My efficient way to use extra parts of my art!",
        ANCIENTDREAMS_GEOCAKE = "You owe yourself a little treat sometimes.",
         --Misc
		WHYLUNARWHIP = "I did say I'd manage to use that crown for something!",
        WHY_CHURCHSTATUE_RED = "Demonstrate our strength.",
        WHY_CHURCHSTATUE_BLUE = "Make pain a sharp payback.",
        WHY_CHURCHSTATUE_PURPLE = "Chaos is sometimes the answer.",
        WHY_CHURCHSTATUE_GREEN = "Remind yourself of the past.",
        WHY_CHURCHSTATUE_ORANGE = "Never give up.",
        WHY_CHURCHSTATUE_YELLOW = "Haste is proof of efficiency.",
        WHY_CHURCHSTATUE_OPAL = "Love is what brings us together in the end.",
        --1.8
        TURF_WHY_CHURCH_TURF = "Floor of the frozen wastes.",
        TURF_WHY_CHURCH_TURF_PINK = "This one is used mostly in the celebration rooms.",
        TURF_WHY_CHURCH_TURF_RED = "Blood of the fallen.",
        TURF_WHY_CHURCH_TURF_PURPLE = "Floor of the maddening whine.",
        TURF_WHY_CHURCH_TURF_GREEN = "Maybe we didn't use gems as well back then.",
        WHYEHAT_DREADSTONE_GREEN = "You have to make do sometimes." ,

		BEDROLL_GNARCOON = "Rest for the townsfolk.",
		BEDROLL_GNARCOON_WINTER = "Delightful sleep for kings.",
		COONTAIL_SHADOW = "Catnip, or maybe worse...",
		GNARANG = "Forge your ways with ash and bones.",
		GNARANG_FORGE = "Fight your ways, or die trying.",
		GNARANG_IMPROVED = "Your sins eventually come back to you.",

		GNARCOON_1_AWARD = "Utter garbage.",
		GNARCOON_2_AWARD = "Utter garbage.",
		GNARCOON_3_AWARD = "Utter garbage.",
		GNARCOON_4_AWARD = "Slightly better utter garbage.",
		GNARCOON_AWARDHAT = "Slightly better utter garbage.",
		GNARCOON_DOLL = "Reeks of flesh, bound by enraged soul.",
		GNARCOON_EYE = "...",
		GNARCOON_JUNIOR = "Naive creature.",
		GNARCOON_SLY_CANE = "If I might jump my bones shall fall out.",
		GNARCOON_TAILNECKLACE = "For fussy eaters.",
		GNARCOON_UMBRA_CANE = "Good.",
		GNARCOON_UMBRA_SWORD = "The shadow spoils.",
		GNARCOON_UMBRA_TOOL_POINT = "Alluring...",
		GNARCOON_UMBRA_TOOL_ROUND = "Tool for transportation of matter.",
		GNARCOON_UMBRA_TOOL_SHARP = "Technology worthy of the ancients.",
		GNARCOON_UMBRASKELETON = "Delightful dreams for weak minds...",
		GNARCOONBONES = "Rich anatomy.",
		GNARCOONDEN = {
			GENERIC = "Root of all evil.",
			EMPTY = "And there were none.",},
		EMPTY_GNARCOONDEN = "Hell is empty.",
		GNARCOONSEABONES = "Wonderful structure.",
		GNARCOONSKELETON = "A fake.",
		GNARGLASSES = "Why would you want to see less?",
		GNARGLASSES_JONES = "Pointless disguise.",
		GNARGLASSES_KAT = "No.",
		GNARGLASSES_KING = "Caricature, such foul creature.",
		GNARGLASSES_MADNESS = "See in red.",
		GNARHAT = "Pretty.",
		GNARHAT_ENNO = "Friendly face.",
		GNARHAT_FORGE = "The bone that blesses you with proficiency.",
		GNARHAT_IMPROVED = "The bone that blesses you with proficiency.",
		GNARHAT_KING = "Caricature, such foul creature.",
		GNARHAT_UMBRA = "Yes... wonderful.",
		GNARHAT_UMBRA_HELMET = "Of creatures not long gone.",
		GNARHAT_WONDERWHY = "I can't force a tear to show my feelings.",
		SHADOW_GNARCOON_JUNIOR = "The demons of the underworld are shaking and crying right now.",
		WINLEY_EYE = "...",
		WINLEY_EYEMULET_EMPTY = "...",
		WINLEY_EYEMULET_BLACK = "...",
		WINLEY_EYEMULET_WHITE = "...",
		WINLEY_EYEMULET_BOTH = "...",

		GNARCOON =
        {
            GENERIC = "Your bones remember my times.",
            ATTACKER = "Oh? You remember now?",
            MURDERER = "His memory isn't lost after all.",
            REVIVER = "Allies tend to gather naturally.",
            GHOST = "I still can see your heart.",
            FIRESTARTER = "This isn't like you, %s.",
        },
		
		SKELETON_PLAYER =
		{
			MALE = "%s must've died messing with %s.",
			FEMALE = "%s must've died messing with %s.",
			ROBOT = "%s must've died messing with %s.",
			DEFAULT = "%s must've died messing with %s.",
			PLURAL = "%s must've died messing with %s.",
		},

    },

	DESCRIBE_ANCIENTEYEPERSPECTIVE = "I cannot tell if it's from this dimension .", --"only_used_by_wonderwhy", --notused anymore

    DESCRIBE_GENERIC = "It's a... thing.",
    DESCRIBE_TOODARK = "My eye cannot pierce this darkness.",
    DESCRIBE_SMOLDERING = "It'll soon burn.",

    DESCRIBE_PLANTHAPPY = "It is satisfied.",
    DESCRIBE_PLANTVERYSTRESSED = "A lot of stress within.",
    DESCRIBE_PLANTSTRESSED = "It's a little cranky.",
    DESCRIBE_PLANTSTRESSORKILLJOYS = "I must get rid of the weeds.",
    DESCRIBE_PLANTSTRESSORFAMILY = "This plant seems lonely.",
    DESCRIBE_PLANTSTRESSOROVERCROWDING = "It is being crushed by others.",
    DESCRIBE_PLANTSTRESSORSEASON = "The season is not being kind to this plant.",
    DESCRIBE_PLANTSTRESSORMOISTURE = "It is dehydrated.",
    DESCRIBE_PLANTSTRESSORNUTRIENTS = "They need fertilizer.",
    DESCRIBE_PLANTSTRESSORHAPPINESS = "It needs a bit of talking.",

    EAT_FOOD =
    {
        TALLBIRDEGG_CRACKED = "A life, reduced to a meal.",
		WINTERSFEASTFUEL = "The taste of broken families.",
    },

}