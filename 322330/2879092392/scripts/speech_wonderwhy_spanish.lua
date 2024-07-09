










return {
	ACTIONFAIL =
	{
        APPRAISE =
        {
            NOTNOW = "Deben estar ocupados ahora.",
        },
        REPAIR =
        {
            WRONGPIECE = "Las piezas no encajan entre sí..",
        },
        BUILD =
        {
            MOUNTED = "Demasiado alto para preocuparme.",
            HASPET = "Un seguidor es más que suficiente...",
			TICOON = "Sigue la pista de uno.",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "La bestia necesita estar dormida antes de la matanza.",
			GENERIC = "Sin pelo para cosechar.",
			NOBITS = "Sin pelaje para cosechar.",
            REFUSE = "only_used_by_woodie",
            SOMEONEELSESBEEFALO = "La bestia le pertenece a alguien más.",
		},
		STORE =
		{
			GENERIC = "Está lleno hasta el borde.",
			NOTALLOWED = "Nunca más.",
			INUSE = "La máquina está en uso.",
            NOTMASTERCHEF = "Esto está más allá de mí.",
		},
        CONSTRUCT =
        {
            INUSE = "Perece demonio, hazte a un lado.",
            NOTALLOWED = "No.",
            EMPTY = "Necesita trabajo.",
            MISMATCH = "Incorrecto.",
        },
		RUMMAGE =
		{	
			GENERIC = "No en este momento..",
			INUSE = "Déjalos hurgar.",
            NOTMASTERCHEF = "Esto está más allá de mí.",
		},
		UNLOCK =
        {
        	WRONGKEY = "Llave incorrecta...",
        },
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "Me lo figuraba.",
        	KLAUS = "Regalos preciosos solo para mí.",
			QUAGMIRE_WRONGKEY = "Llave incorrecta.",
        },
		ACTIVATE = 
		{
			LOCKED_GATE = "La puerta está sellada.",
            HOSTBUSY = "El parece un poco preocupado en este momento.",
            CARNIVAL_HOST_HERE = "Muéstrate a ti mismo, aviar feo.",
            NOCARNIVAL = "Los aviares se han ido.",
			EMPTY_CATCOONDEN = "No hay mal dentro. Todavía.",
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDERS = "No hay suficientes pequeños demonios.",
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDING_SPOTS = "Requieren más escondites.",
			KITCOON_HIDEANDSEEK_ONE_GAME_PER_DAY = "Creo que eso es suficiente.",
            MANNEQUIN_EQUIPSWAPFAILED = "No apto para usar, me lo temo.",
		},
		OPEN_CRAFTING =
		{
            PROFESSIONALCHEF = "Esta cocción está más allá de mi nivel.",
			SHADOWMAGIC = "Sombras, téjanse.",
		},
        COOK =
        {
            GENERIC = "No puedo cocinar en este momento.",
            INUSE = "Deja que lo tengan.",
            TOOFAR = "más cerca...",
        },
        START_CARRAT_RACE =
        {
            NO_RACERS = "me está faltando algo aquí.",
        },

		DISMANTLE =
		{
			COOKING = "only_used_by_warly",
			INUSE = "only_used_by_warly",
			NOTEMPTY = "only_used_by_warly",
        },
        FISH_OCEAN =
		{
			TOODEEP = "Se necesita una mejor herramienta.",
		},
        OCEAN_FISHING_POND =
		{
			WRONGGEAR = "Esto no sirve de nada.",
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
            GENERIC = "Inútil.",
            DEAD = "Los fantasmas no tienen manos, qué lamentable.",
            SLEEPING = "Despierta somnoliento, tengo algo para ti.",
            BUSY = "Deja lo que estás haciendo.",
            ABIGAILHEART = "Esta entidad ya no es un humano real.",
            GHOSTHEART = "Incorrecto de nuevo...",
            NOTGEM = "Necesita mejor poder.",
            WRONGGEM = "Joya equivocada.",
            NOTSTAFF = "Necesita una vara.",
            MUSHROOMFARM_NEEDSSHROOM = "Se alimenta de las flores muertas.",
            MUSHROOMFARM_NEEDSLOG = "Alimentado por los gritos de la madera viviente.",
            MUSHROOMFARM_NOMOONALLOWED = "¡Estos hongos parecen resistirse a ser plantados!",
            SLOTFULL = "Ya hay algo aquí...",
            FOODFULL = "Ya hay algo aquí...",
            NOTDISH = "No es comida mortal.",
            DUPLICATE = "Lo sabemos todo...",
            NOTSCULPTABLE = "La sustancia no es adecuada para la escultura.",
            NOTATRIUMKEY = "¿Qué estaba pensando? Solo hay una llave.",
            CANTSHADOWREVIVE = "La resurrección no es posible.",
            WRONGSHADOWFORM = "No está armado correctamente.",
            NOMOON = "No son visibles.",
			PIGKINGGAME_MESSY = "Demasiado desordenado.",
			PIGKINGGAME_DANGER = "Purga el peligro primero.",
			PIGKINGGAME_TOOLATE = "El bastardo gordo está dormido.",
			CARNIVALGAME_INVALID_ITEM = "Los tokens son lo que necesito.",
			CARNIVALGAME_ALREADY_PLAYING = "Ya ha comenzado.",
            SPIDERNOHAT = "No puedo juntarlos en mi bolsillo.",
            TERRARIUM_REFUSE = "Tal vez debería experimentar con diferentes tipos de combustible...",
            TERRARIUM_COOLDOWN = "Supongo que el árbol tiene que volver a crecer antes de que podamos darle algo.",
            NOTAMONKEY = "No soy un fan de tu idioma.",
            QUEENBUSY = "La reina está ocupada.",
        },
        GIVETOPLAYER =
        {
            FULL = "¡Haz lugar para el regalo que te otorgaré!",
            DEAD = "Tu fantasma no tiene manos, qué lamentable.",
            SLEEPING = "El mortal está dormido.",
            BUSY = "Quédate quieto gusano feo.",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "¡Haz lugar para el regalo que te otorgaré!",
            DEAD = "Tu fantasma no tiene manos, qué lamentable.",
            SLEEPING = "El mortal está dormido.",
            BUSY = "Quédate quieto gusano feo.",
        },
        WRITE =
        {
            GENERIC = "No puedo sobrescribir la historia.",
            INUSE = "El escritorio está en uso.",
        },
        DRAW =
        {
            NOIMAGE = "Musa necesita estar más cerca.",
        },
        CHANGEIN =
        {
            GENERIC = "No es el momento de vestirse.",
            BURNING = "La tela se quema en el interior.",
            INUSE = "Alguien más desea ser el rey.",
            NOTENOUGHHAIR = "No hay suficiente pelaje para peinar.",
            NOOCCUPANT = "Necesita algo enganchado.",
        },
        ATTUNE =
        {
            NOHEALTH = "Derramar más materia me matará.",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "¡Bestia furiosa, calma tus maneras!",
            INUSE = "¡Alguien me golpeó en la silla de montar!",
			SLEEPING = "¡Hora de despertar!",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "¡Bestia furiosa, calma tus maneras!",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "El conocimiento es todo, ya lo tengo.",
            CANTLEARN = "Esto está más allá de mi intelecto, curioso...",

            --MapRecorder/MapExplorer
            WRONGWORLD = "Esa no es la ubicación en la que estamos.",

			--MapSpotRevealer/messagebottle
			MESSAGEBOTTLEMANAGER_NOT_FOUND = "¡No puedo distinguir nada en esta iluminación!",--Likely trying to read messagebottle treasure map in caves

            STASH_MAP_NOT_FOUND = "Sin marca X.",-- Likely trying to read stash map  in world without stash
        },
        WRAPBUNDLE =
        {
            EMPTY = "Tonto para envolver el fino aire.",
        },
        PICKUP =
        {
			RESTRICTION = "No fue intencionado para mí.",
			INUSE = "Deja que lo tengan.",
            NOTMINE_SPIDER = "only_used_by_webber",
            NOTMINE_YOTC =
            {
                "No es mi súbdito.",
                "¡No me muerdas, roedor!",
            },
			NO_HEAVY_LIFTING = "only_used_by_wanda",
            FULL_OF_CURSES = "No voy a tocar eso.",
        },
        SLAUGHTER =
        {
            TOOFAR = "Fugado.",
        },
        REPLATE =
        {
            MISMATCH = "Comida equivocada.", 
            SAMEDISH = "Es lo mismo.", 
        },
        SAIL =
        {
        	REPAIR = "Está en excelente estado.",
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "Necesito cronometrar mejor mis acciones.",
            BAD_TIMING1 = "No hay prisa necesaria.",
            BAD_TIMING2 = "...",
        },
        LOWER_SAIL_FAIL =
        {
            "Mi mandíbula se resbaló.",
            "No.",
            "No quise bajarlo ahora.",
        },
        BATHBOMB =
        {
            GLASSED = "Aplasta el vidrio primero.",
            ALREADY_BOMBED = "No necesita otra.",
        },
		GIVE_TACKLESKETCH =
		{
			DUPLICATE = "Esto ya lo tengo equipado.",
		},
		COMPARE_WEIGHABLE =
		{
            FISH_TOO_SMALL = "Tamaño insignificante.",
            OVERSIZEDVEGGIES_TOO_SMALL = "Tamaño insignificante.",
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
            GENERIC = "No queda nada por aprender.",
            FERTILIZER = "preferiría no saber nada más.",
        },
        FILL_OCEAN =
        {
            UNSUITABLE_FOR_PLANTS = "Por alguna razón, a las plantas no les gusta el agua salada.",
        },
        POUR_WATER =
        {
            OUT_OF_WATER = "Vacía.",
        },
        POUR_WATER_GROUNDTILE =
        {
            OUT_OF_WATER = "Vacía.",
        },
        USEITEMON =
        {
            --GENERIC = "I can't use this on that!",

            --construction is PREFABNAME_REASON
            BEEF_BELL_INVALID_TARGET = "Criatura equivocada.",
            BEEF_BELL_ALREADY_USED = "El problema de alguien más.",
            BEEF_BELL_HAS_BEEF_ALREADY = "Tengo una bestia a raya.",
        },
        HITCHUP =
        {
            NEEDBEEF = "El cencerro.",
            NEEDBEEF_CLOSER = "Demasiado lejos.",
            BEEF_HITCHED = "Ya está enganchado.",
            INMOOD = "Honky.",
        },
        MARK =
        {
            ALREADY_MARKED = "Ya, he decidido.",
            NOT_PARTICIPANT = "No interrumpas, no es asunto mío.",
        },
        YOTB_STARTCONTEST =
        {
            DOESNTWORK = "Supongo que no apoyan las artes aquí.",
            ALREADYACTIVE = "Debe estar ocupado con otro concurso en algún lugar.",
        },
        YOTB_UNLOCKSKIN =
        {
            ALREADYKNOWN = "¡Ya he aprendido esto!",
        },
        CARNIVALGAME_FEED =
        {
            TOO_LATE = "¡Más rápido!",
        },
        HERD_FOLLOWERS =
        {
            WEBBERONLY = "No me escucharán, pero podrían escuchar a Webber.",
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
            DOER_ISNT_MODULE_OWNER = "¿Me veo cómo una máquina?",
        },
    },

	ANNOUNCE_CANNOT_BUILD =
	{
		NO_INGREDIENTS = "Faltan componentes.",
		NO_TECH = "Máquina necesaria.",
		NO_STATION = "Lo olvisé.",
	},

	ACTIONFAIL_GENERIC = "...",
	ANNOUNCE_BOAT_LEAK = "Empieza a hundirse.",
	ANNOUNCE_BOAT_SINK = "Nuestro cuerpo flotará.",
	ANNOUNCE_DIG_DISEASE_WARNING = "La enfermedad ya no existe.",
	ANNOUNCE_PICK_DISEASE_WARNING = "Está podrido.",
	ANNOUNCE_ADVENTUREFAIL = "Fracaso.",
    ANNOUNCE_MOUNT_LOWHEALTH = "La bestia está herida.",

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

	ANNOUNCE_BEES = "¡Vuelen mis súbditos!",
	ANNOUNCE_BOOMERANG = "...!",
	ANNOUNCE_CHARLIE = "Deseas deshacerte de mí, interesante.",
	ANNOUNCE_CHARLIE_ATTACK = "Tuve peores...",
	ANNOUNCE_CHARLIE_MISSED = "only_used_by_winona", --winona specific 
	ANNOUNCE_COLD = "Nuestro asunto se está volviendo entumecedor.",
	ANNOUNCE_HOT = "Nos estamos derritiendo.",
	ANNOUNCE_CRAFTING_FAIL = "Falta materia.",
	ANNOUNCE_DEERCLOPS = "El está viniendo por su chico.",
	ANNOUNCE_CAVEIN = "Están enfurecidos.",
	ANNOUNCE_ANTLION_SINKHOLE = 
	{
		"La ira del desierto está a punto de perseguirnos.",
		"¡Bestia!",
		"Materia dura cayendo.",
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "¿Debo rendir homenaje a la?",
        "Un homenaje para ti, gran hormigaleón.",
        "Cesa tu apetito.",
	},
	ANNOUNCE_SACREDCHEST_YES = "Tomo lo que es nuestro.",
	ANNOUNCE_SACREDCHEST_NO = "...",
    ANNOUNCE_DUSK = "La oscuridad se lo tragará todo.",
    
    --wx-78 specific
    ANNOUNCE_CHARGE = "only_used_by_wx78",
	ANNOUNCE_DISCHARGE = "only_used_by_wx78",

	ANNOUNCE_EAT =
	{
		GENERIC = "¡Yo festejo!",
		PAINFUL = "Eso es interesante.",
		SPOILED = "Podrido.",
		STALE = "El tiempo pasó volando para la materia orgánica.",
		INVALID = "No comestible.",
        YUCKY = "...no.",
        
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
        "Manteniendo la pasta.",
        "Lento y constante.",
        "Subir... con la espalda...",
        "Este trabajo no es adecuado para mis viejos huesos.",
        "Esto es necesario.",
        "¡Aghhh...!",
        "...",
        "¡...!",
        "¡...!",
    },
    ANNOUNCE_ATRIUM_DESTABILIZING = 
    {
		"¡Finalmente!",
		"¡¿Falló?!",
		"¡No! ¡Tenemos la culpa!",
	},
    ANNOUNCE_RUINS_RESET = "Es como si el tiempo cambiara...",
    ANNOUNCE_SNARED = "Huesos afilados.",
    ANNOUNCE_SNARED_IVY = "Plantas vs un zombi...",
    ANNOUNCE_REPELLED = "Repele ataques.",
	ANNOUNCE_ENTER_DARK = "Oscuridad.",
	ANNOUNCE_ENTER_LIGHT = "Brillante.",
	ANNOUNCE_FREEDOM = "¡Libertad!",
	ANNOUNCE_HIGHRESEARCH = "El conocimiento significa todo.",
	ANNOUNCE_HOUNDS = "Bestias, vienen a la matanza.",
	ANNOUNCE_WORMS = "Bestias, vienen a la matanza.",
	ANNOUNCE_HUNGRY = "NOSOTROS. HAMBRE.",
	ANNOUNCE_HUNT_BEAST_NEARBY = "Pronto la caza habrá terminado.",
	ANNOUNCE_HUNT_LOST_TRAIL = "Perdido en su propia estupidez.",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "El rastro se embarró.",
	ANNOUNCE_INV_FULL = "Antes déjamelo a mi, tengo asuntos más importantes que atender.",
	ANNOUNCE_KNOCKEDOUT = "¿Mi cara todavía está en su lugar?",
	ANNOUNCE_LOWRESEARCH = "Lamentable.",
	ANNOUNCE_MOSQUITOS = "Sanguijuelas.",
    ANNOUNCE_NOWARDROBEONFIRE = "Tela arde.",
    ANNOUNCE_NODANGERGIFT = "Los monstruos todavía acechan.",
    ANNOUNCE_NOMOUNTEDGIFT = "Saltaremos del monte para hacer eso.",
	ANNOUNCE_NODANGERSLEEP = "Eso puede esperar.",
	ANNOUNCE_NODAYSLEEP = "El brillo me molesta.",
	ANNOUNCE_NODAYSLEEP_CAVE = "El brillo todavía me molesta.",
	ANNOUNCE_NOHUNGERSLEEP = "TENEMOS HAMBRE DE SANGRE, NO DE DESCANSO.",
	ANNOUNCE_NOSLEEPONFIRE = "No descansaremos en llamas.",
	ANNOUNCE_NODANGERSIESTA = "Las bestias acechan alrededor.",
	ANNOUNCE_NONIGHTSIESTA = "Ahora hay noche.",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "Ahora no.",
	ANNOUNCE_NOHUNGERSIESTA = "¡Tengo demasiada hambre para una siesta!",
	ANNOUNCE_NODANGERAFK = "TENEMOS HAMBRE, NO TENEMOS TIEMPO PARA DESCANSAR.",
	ANNOUNCE_NO_TRAP = "Tonto.",
	ANNOUNCE_PECKED = "...",
	ANNOUNCE_QUAKE = "Mi mandíbula está temblando.",
	ANNOUNCE_RESEARCH = "Más conocimiento para captar.",
	ANNOUNCE_SHELTER = "Refugio, por fin.",
	ANNOUNCE_THORNS = "...",
	ANNOUNCE_BURNT = "Las llamas nos rodean.",
	ANNOUNCE_TORCH_OUT = "Dulce oscuridad.",
	ANNOUNCE_THURIBLE_OUT = "La dulce oscuridad pereció.",
	ANNOUNCE_FAN_OUT = "Voló.",
    ANNOUNCE_COMPASS_OUT = "Dispositivo roto.",
	ANNOUNCE_TRAP_WENT_OFF = "¿Una emboscada?",
	ANNOUNCE_UNIMPLEMENTED = "Sea lo que sea que esto signifique.",
	ANNOUNCE_WORMHOLE = "Precioso.",
	ANNOUNCE_TOWNPORTALTELEPORT = "...",
	ANNOUNCE_CANFIX = "\n¡Necesita trabajo, yo proveeré!",
	ANNOUNCE_ACCOMPLISHMENT = "Buen trabajo errante.",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "Maravilloso...",	
	ANNOUNCE_INSUFFICIENTFERTILIZER = "Más nutriciones.",
	ANNOUNCE_TOOL_SLIP = "Y sale volando.",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Eso fue caliente.",
	ANNOUNCE_TOADESCAPING = "El sapo está perdiendo el interés.",
	ANNOUNCE_TOADESCAPED = "El sapo se ha escapado.",


	ANNOUNCE_DAMP = "Remojando.",
	ANNOUNCE_WET = "Soy uno con el agua.",
	ANNOUNCE_WETTER = "...Lo odio aquí.",
	ANNOUNCE_SOAKED = "Me siento como ahogandome.",

	ANNOUNCE_WASHED_ASHORE = "...",

    ANNOUNCE_DESPAWN = "Hora de desmaterializarse de nuevo.",
	ANNOUNCE_BECOMEGHOST = "Llegué al final.",
	ANNOUNCE_GHOSTDRAIN = "Mi vida está a punto de empezar a escaparse...",
	ANNOUNCE_PETRIFED_TREES = "¿Los árboles están gritando?",
	ANNOUNCE_KLAUS_ENRAGE = "Me gusta un reto.",
	ANNOUNCE_KLAUS_UNCHAINED = "Ataduras rotas.",
	ANNOUNCE_KLAUS_CALLFORHELP = "Vienen esbirros.",

	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "Vente afuera.",
		GLASS_LOW = "Puedo verte.",
		GLASS_REVEAL = "Conozco tu uso.",
		IDOL_MED = "Vente afuera.",
		IDOL_LOW = "Puedo verte.",
		IDOL_REVEAL = "Conozco tu uso.",
		SEED_MED = "Vente afuera.",
		SEED_LOW = "Puedo verte.",
		SEED_REVEAL = "Conozco tu uso.",
	},

    --hallowed nights
    ANNOUNCE_SPOOKED = "Ah.",
	ANNOUNCE_BRAVERY_POTION = "¿Realmente necesitaba beber eso?",
	ANNOUNCE_MOONPOTION_FAILED = "Interesante... no sirve de nada",

	--winter's feast
	ANNOUNCE_EATING_NOT_FEASTING = "...",
	ANNOUNCE_WINTERS_FEAST_BUFF = "...",
	ANNOUNCE_IS_FEASTING = "...",
	ANNOUNCE_WINTERS_FEAST_BUFF_OVER = "Agh...",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "Vuelve, AL MUNDO DE LOS VIVOS.",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "De nada.",
    ANNOUNCE_REVIVED_FROM_CORPSE = "VOLVÍ.",

    ANNOUNCE_FLARE_SEEN = "¿Luces arriba?",
    ANNOUNCE_MEGA_FLARE_SEEN = "Es una declaración de guerra.",
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "Bestia marina, en el horizonte.",

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
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "Esto no es cocinar.",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "Quemado.",
    QUAGMIRE_ANNOUNCE_LOSE = "Huelo algo a pescado. Glorp florp.",
    QUAGMIRE_ANNOUNCE_WIN = "Naura!",

    ANNOUNCE_ROYALTY =
    {
        "Atragántate con él.",
        "El mejor idiota alrededor.",
        "Mis condolencias por tu muerte de ego.",
    },

    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "¡El rayo llena mi esencia!",
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "¡PODER, CRECE!",
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "Mi piel se endurece.",
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "¿Cómo funciona eso...?",
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "El agua ya no es nada.",
    ANNOUNCE_ATTACH_BUFF_SLEEPRESISTANCE   = "Me niego a sucumbirme a ti, Morfeo.",

    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "El rayo abandona mi cuerpo.",
    ANNOUNCE_DETACH_BUFF_ATTACK            = "Estoy debilitado.",
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "Me siento frágil de nuevo.",
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "Y se ha ido.",
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "La humedad ataca de nuevo.",
    ANNOUNCE_DETACH_BUFF_SLEEPRESISTANCE   = "Cansado..",

	ANNOUNCE_OCEANFISHING_LINESNAP = "La línea se rompió.",
	ANNOUNCE_OCEANFISHING_LINETOOLOOSE = "Tira del carrete.",
	ANNOUNCE_OCEANFISHING_GOTAWAY = "Se ha ido.",
	ANNOUNCE_OCEANFISHING_BADCAST = "Qué fue eso...",
	ANNOUNCE_OCEANFISHING_IDLE_QUOTE =
	{
		"Paciencia.",
		"No hay peces aquí.",
		"Los hombres me quieren, las bestias acuáticas me temen.",
		"Cualquier día ahora.",
	},

	ANNOUNCE_WEIGHT = "Peso: {weight}",
	ANNOUNCE_WEIGHT_HEAVY  = "Peso: {weight}\n¡Estoy pescando un peso pesado!",

	ANNOUNCE_WINCH_CLAW_MISS = "Creo que perdí la marca.",
	ANNOUNCE_WINCH_CLAW_NO_ITEM = "¡Maldición! Al final acabo con las manos vacías.",

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
    ANNOUNCE_WEAK_RAT = "Débil.",

    ANNOUNCE_CARRAT_START_RACE = "¡CORRAN POR SUS VIDAS, MOLESTOS ROEDORES!",

    ANNOUNCE_CARRAT_ERROR_WRONG_WAY = {
        "¡Roedor tonto!",
        "¡Da la vuelta!",
    },
    ANNOUNCE_CARRAT_ERROR_FELL_ASLEEP = "DESPIERTA.",
    ANNOUNCE_CARRAT_ERROR_WALKING = "¡ACELERA!",
    ANNOUNCE_CARRAT_ERROR_STUNNED = "¡VE! ¡VE!",

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

    ANNOUNCE_ARCHIVE_NEW_KNOWLEDGE = "Ja, ja, lo sabía...",
    ANNOUNCE_ARCHIVE_OLD_KNOWLEDGE = "Ese lo conozco.",
    ANNOUNCE_ARCHIVE_NO_POWER = "El poder se ha ido.",

    ANNOUNCE_PLANT_RESEARCHED =
    {
        "¡Cada vez sé más cosas de esta planta!",
    },

    ANNOUNCE_PLANT_RANDOMSEED = "Me preguntó en qué se convertirá.",

    ANNOUNCE_FERTILIZER_RESEARCHED = "...",

	ANNOUNCE_FIRENETTLE_TOXIN =
	{
		"¡Cosa caliente!",
		"¡...!",
	},
	ANNOUNCE_FIRENETTLE_TOXIN_DONE = "La toxina dejó de funcionar.",

	ANNOUNCE_TALK_TO_PLANTS =
	{
        "¡Madre sagrada, ayuda a esta joven alma a alcanzar la luz!",
        "Ven niño, alcánzame.",
		"¡*besito*!",
        "¡Levántate y brilla!",
        "No me falles.",
	},

	ANNOUNCE_KITCOON_HIDEANDSEEK_START = "Yo busco ahora.",
	ANNOUNCE_KITCOON_HIDEANDSEEK_JOIN = "Ohhh, están jugando al escondite.",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND =
	{
		"¡Te encontré!",
		"Te pillé.",
		"¡Sabía que te esconderías ahí!",
		"¡Te veo!",
	},
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_ONE_MORE = "Bueno, ¿dónde estará el ultimo?",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE = "¡He encontrado al último!",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE_TEAM = "¡{name} ha encontrado al último!",
	ANNOUNCE_KITCOON_HIDANDSEEK_TIME_ALMOST_UP = "Los pequeñines deben estar impacientándose...",
	ANNOUNCE_KITCOON_HIDANDSEEK_LOSEGAME = "Supongo que no quieren seguir jugando...",
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR = "No creo que se alejen tanto para esconderse, ¿no?",
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR_RETURN = "Los gapachitos no pueden andar lejos.",
	ANNOUNCE_KITCOON_FOUND_IN_THE_WILD = "¡Sabía que había algo escondido por ahí!",

	ANNOUNCE_TICOON_START_TRACKING	= "¡Ha olfateado algo!",
	ANNOUNCE_TICOON_NOTHING_TO_TRACK = "Parece que no ha encontrado nada.",
	ANNOUNCE_TICOON_WAITING_FOR_LEADER = "¡Debería ir tras él!",
	ANNOUNCE_TICOON_GET_LEADER_ATTENTION = "Quiere que lo siga.",
	ANNOUNCE_TICOON_NEAR_KITCOON = "¡Habrá encontrado algo!",
	ANNOUNCE_TICOON_LOST_KITCOON = "Parece que alguien ha encontrado lo que buscaba.",
	ANNOUNCE_TICOON_ABANDONED = "Encontraré a los pequeñines sin ayuda.",
	ANNOUNCE_TICOON_DEAD = "Pobrecillo... ¿A dónde me llevaba?",

    -- YOTB
    ANNOUNCE_CALL_BEEF = "¡Ven aquí!",
    ANNOUNCE_CANTBUILDHERE_YOTB_POST = "El juez no podrá ver a mi beefalo desde aquí.",
    ANNOUNCE_YOTB_LEARN_NEW_PATTERN =  "¡Me ha invadido la inspiración de la esquila de beefalos!",

    -- AE4AE
    ANNOUNCE_EYEOFTERROR_ARRIVE = "¡Dame tu OJO!",
    ANNOUNCE_EYEOFTERROR_FLYBACK = "¡ENFRÉNTAME!",
    ANNOUNCE_EYEOFTERROR_FLYAWAY = "¡ENFRÉNTAME COBARDE!",

    -- PIRATES
    ANNOUNCE_CANT_ESCAPE_CURSE = "Por supuesto que no podría ser tan fácil.",
    ANNOUNCE_MONKEY_CURSE_1 = "...",
    ANNOUNCE_MONKEY_CURSE_CHANGE = "¡¿...?!",
    ANNOUNCE_MONKEY_CURSE_CHANGEBACK = "Me alegro de que se haya terminado.",

    ANNOUNCE_PIRATES_ARRIVE = "Maldigo.",

    ANNOUNCE_BOOK_MOON_DAYTIME = "only_used_by_waxwell_and_wicker",

    ANNOUNCE_OFF_SCRIPT = "Está fuera de guión, está mal en muchos niveles.",

	BATTLECRY =
	{
		GENERIC = "¡Te voy a arrancar los ojos!",
		PIG = "¡No eres rival para mí!",
		PREY = "¡Muere por mí!",
		SPIDER = "¡Cae debajo de mí!",
		SPIDER_WARRIOR = "¡Tráelo!",
		DEER = "¡Bien! ¡CORRE POR TU VIDA!",
	},
	COMBAT_QUIT =
	{
		GENERIC = "¡No hay tiempo para eso!",
		PIG = "Quítate de mi vista.",
		PREY = "'Has sido perdonado!",
		SPIDER = "Déjalos vivir otro día.",
		SPIDER_WARRIOR = "Me enojaste lo suficiente.",
	},

	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "Para atrapar a más tontos.",
        MULTIPLAYER_PORTAL_MOONROCK = "Una vida por otra.",
        MOONROCKIDOL = "Dios falso.",
        CONSTRUCTION_PLANS = "falsifica el escape.",

        ANTLION =
        {
            GENERIC = "El gran hormigaleón exige un homenaje.",
            VERYHAPPY = "Complacido.",
            UNHAPPY = "Enfureció.",
        },
        ANTLIONTRINKET = "Véase el corazón del desierto.",
        SANDSPIKE = "Dios enfureció, hay tanto que puedes hacer.",
        SANDBLOCK = "Esto no me detendrá.",
        GLASSSPIKE = "Es como si la arena tuviera huesos.",
        GLASSBLOCK = "No es suficiente para reconstruir el imperio.",
        ABIGAIL_FLOWER =
        {
            GENERIC ="Mantiene los recuerdos.",
			LEVEL1 = "Retuerce la mente.",
			LEVEL2 = "Fomenta el anhelo.",
			LEVEL3 = "Pero la esperanza es un rasgo tonto.",

			-- deprecated
            LONG = "Me duele el alma de mirarla.",
            MEDIUM = "Me está poniendo los pelos de punta.",
            SOON = "¡Algo le pasa a esa flor!",
            HAUNTED_POCKET = "Creo que no debería guardarme esto.",
            HAUNTED_GROUND = "Me muero por saber lo que hace.",
        },

        BALLOONS_EMPTY = "Parece como dinero de payasos.",
        BALLOON = "Tira eso, es inútil.",
		BALLOONPARTY = "...¿Por diversión?",
		BALLOONSPEED =
        {
            DEFLATED = "Inútil.",
            GENERIC = "Sí, un intento tonto de aumentar la velocidad.",
        },
		BALLOONVEST = "El chirrido me molesta.",
		BALLOONHAT = "Terrible elección de una corona.",

        BERNIE_INACTIVE =
        {
            BROKEN = "El demonio se fue.",
            GENERIC = "El demonio está dentro.",
        },

        BERNIE_ACTIVE = "Atrae en ruegos, pero no puede luchar completamente.",
        BERNIE_BIG = "Quiere liberarse de su prisión.",

		BOOKSTATION =
		{
			GENERIC = "Todos los buenos se quemaron.",
			BURNT = "Cenizas y carbón.",
		},
        BOOK_BIRDS = "Llamador aviar.",
        BOOK_TENTACLES = "Fanfiction rarito.",
        BOOK_GARDENING = "Odas para la gran madre.",
		BOOK_SILVICULTURE = "Odas para la gran madre.",
		BOOK_HORTICULTURE = "Odas para la gran madre.",
        BOOK_SLEEP = "El destino es peor que la muerte.",
        BOOK_BRIMSTONE = "Enfurece el cielo.",

        BOOK_FISH = "Para llamar a las bestias oceánicas.",
        BOOK_FIRE = "Cosecha Ignición.",
        BOOK_WEB = "¿...?",
        BOOK_TEMPERATURE = "Ok.",
        BOOK_LIGHT = "Para combatir al miedo, necesitas enfrentarlo.",
        BOOK_RAIN = "Invoca al cielo.",
        BOOK_MOON = "Los extraño.",
        BOOK_BEES = "Tengo una picadura..",
        
        BOOK_HORTICULTURE_UPGRADED = "Es tan emocionante como ver crecer la hierba.",
        BOOK_RESEARCH_STATION = "Yo también puedo hacer eso.",
        BOOK_LIGHT_UPGRADED = "iluminador.",

        FIREPEN = "Toma controversialmente caliente: ¡literalmente!",

        PLAYER =
        {
            GENERIC = "Agh ¡mírate a ti mismo, %s!",
            ATTACKER = "%s es peligro.",
            MURDERER = "Traidor.",
            REVIVER = "%s, con conmovedores retoques.",
            GHOST = "%s, eres más bonito de esa manera",
            FIRESTARTER = "Toca un poco de hierba, %s. Sin embargo, no lo quemes.",
        },
        WILSON =
        {
            GENERIC = "Tu lógica es tu perdición.",
            ATTACKER = "¿No eres tan amigable ahora?",
            MURDERER = "Eso me pareció, loco como todos ellos.",
            REVIVER = "Puedo mostrarte cómo se ve una verdadera resurrección más tarde...",
            GHOST = "Científico abajo, faltan algunos más.",
            FIRESTARTER = "%s, eres un tonto.",
        },
        WOLFGANG =
        {
            GENERIC = "¡Fortalece tu corazón!",
            ATTACKER = "No me pongas un dedo encima, bruto.",
            MURDERER = "Te derribaré.",
            REVIVER = "Bueno de corazón.",
            GHOST = "Menos músculo, más pensamiento.",
            FIRESTARTER = "Eso me recuerda, no confiar en ninguno de ustedes.",
        },
        WAXWELL =
        {
            GENERIC = "Tus hechizos están mal, %s.",
            ATTACKER = "¿Cortas todo lo que no puedes entender?",
            MURDERER = "Tú de todos, no vaciles.",
            REVIVER = "%s está usando sus poderes para el bien.",
            GHOST = "No me supliques ahora.",
            FIRESTARTER = "Una forma de llamar mi atención es ser un idiota.",
        },
        WX78 =
        {
            GENERIC = "¿Te conozco?",
            ATTACKER = "No conoces ninguna ley.",
            MURDERER = "Robot asesino, qué pintoresco.",
            REVIVER = "La empatía es lo menos que puedes hacer.",
            GHOST = "Alma aplastada en prisión de metal.",
            FIRESTARTER = "Busca venganza.",
        },
        WILLOW =
        {
            GENERIC = "¡Dama del fuego, %s!",
            ATTACKER = "Señora flama, me decepcionas.",
            MURDERER = "Pensé que eras mejor que esto.",
            REVIVER = "%s, amiga de los fantasmas.",
            GHOST = "Cenizas a cenizas.",
            FIRESTARTER = "Esto es divertido para ti, lo apuesto.",
        },
        WENDY =
        {
            GENERIC = "Niña.",
            ATTACKER = "Una forma de hacer una rabieta.",
            MURDERER = "Movimientos asesinos.",
            REVIVER = "Obsesión fantasma.",
            GHOST = "Será mejor que confeccione un corazón para %s.",
            FIRESTARTER = "La otra forma de hacer una rabieta.",
        },
        WOODIE =
        {
            GENERIC = "%s...",
            ATTACKER = "%s ha sido un poco de savia últimamente...",
            MURDERER = "¡Asesino! ¡Tráeme un hacha y pongámonos en marcha!",
            REVIVER = "%s salvó el tocino trasero de todos.",
            GHOST = "¿La cobertura \"universal\" incluye al vacío, %s?",
            BEAVER = "Te ves como una rata.",
            BEAVERGHOST = "¿Cómo moriste?",
            MOOSE = "Me gustas más de esa manera.",
            MOOSEGHOST = "¿Cómo moriste?",
            GOOSE = "¡Echale una ganseasa a eso!",
            GOOSEGHOST = "¿Cómo moriste?",
            FIRESTARTER = "No te quemes a ti mismo, %s.",
        },
        WICKERBOTTOM =
        {
            GENERIC = "¡Soy mayor, %s!",
            ATTACKER = "Cliché.",
            MURDERER = "Lo que necesitas es una daga.",
            REVIVER = "Tengo un profundo respeto por los teoremas prácticos de %s.",
            GHOST = "¿Qué sabes sobre la vida después de la muerte?",
            FIRESTARTER = "Estoy seguro de que tenías una razón muy inteligente para ese fuego.",
        },
        WES =
        {
            GENERIC = "No hay razón para hablar contigo.",
            ATTACKER = "No hay razón para hablar contigo.",
            MURDERER = "No hay razón para hablar contigo.",
            REVIVER = "No hay razón para hablar contigo.",
            GHOST = "No hay razón para hablar contigo.",
            FIRESTARTER = "No hay razón para hablar contigo.",
        },
        WEBBER =
        {
            GENERIC = "Pobre niño, %s, ¿cómo estás?",
            ATTACKER = "Mantén tus emociones a raya.",
            MURDERER = "Claramente dejas que el monstruo te controle.",
            REVIVER = "Joven muy bien educado.",
            GHOST = "%s, ¿cómo te lastimaste?",
            FIRESTARTER = "No toques las herramientas pirómanos, te lo ruego.",
        },
        WATHGRITHR =
        {
            GENERIC = "¡Bárbara, deja el acto!",
            ATTACKER = "No soy otro monstruo que puedas simplemente matar.",
            MURDERER = "Hay sed de sangre en sus ojos.",
            REVIVER = "%s tiene pleno comando de los espíritus.",
            GHOST = "Todavía no merecías la vida después de la muerte.",
            FIRESTARTER = "¿Cortar y quemar? Qué combo.",
        },
        WINONA =
        {
            GENERIC = "¡Inventora, bienvenida!",
            ATTACKER = "%s se libra hoy.",
            MURDERER = "¡Eso no parece otro accidente %s!",
            REVIVER = "Su servicio es apreciado, %s.",
            GHOST = "Parece que alguien lanzó una llave inglesa en tus planes.",
            FIRESTARTER = "Las cosas se están quemando en la fábrica.",
        },
        WORTOX =
        {
            GENERIC = "Te ves tan esponjoso.",
            ATTACKER = "¡Mal diablillo, bu!",
            MURDERER = "Te voy a castigar más tarde.",
            REVIVER = "Gracias por la patita servicial, %s.",
            GHOST = "Ya no eres suave.",
            FIRESTARTER = "Sé algunas otras cosas que puedes prender fuego, esta no es una de ellas.",
        },
        WORMWOOD =
        {
            GENERIC = "%s...",
            ATTACKER = "¿Te enviaron?",
            MURDERER = "¿Eres un asesino pagado?",
            REVIVER = "%s no es una maleza como pensaba.",
            GHOST = "¿Dónde dejaste caer tu cristal?",
            FIRESTARTER = "Irónico, realmente, %s.",
        },
        WARLY =
        {
            GENERIC = "¡Chef!",
            ATTACKER = "¿Receta especial de emergencia?",
            MURDERER = "Quiere hacer un pastel con huesos.",
            REVIVER = "Confía siempre en %s para cocinar un plan.",
            GHOST = "Cocinar no es un juego de niños.",
            FIRESTARTER = "Dejaste tus sartenes en llamas, ahora mira el desorden.",
        },

        WURT =
        {
            GENERIC = "¡Florp %s!",
            ATTACKER = "¡%s Glorby florp!",
            MURDERER = "¡Persona asesina de rana pez!",
            REVIVER = "¡Vaya, tenías que hacerlo, %s!",
            GHOST = "%s se ve más florpido.",
            FIRESTARTER = "Debería parar con los chistes de tritón.",
        },

        WALTER =
        {
            GENERIC = "Otro niño, genial...",
            ATTACKER = "Echa un vistazo al buen comportamiento...",
            MURDERER = "Sin comentarios, tienes sangre en tu perro.",
            REVIVER = "Útil, gracias %s.",
            GHOST = "¿No fue una experiencia divertida?",
            FIRESTARTER = "Tonto de mi parte fue asumir que sabías cómo encender un fuego.",
        },

        WANDA =
        {
            GENERIC = "Abuela.",
            ATTACKER = "Hora de parar.",
            MURDERER = "¡Te vi antes, con la misma sonrisa malvada!",
            REVIVER = "Muchas gracias.",
            GHOST = "El tiempo te ha alcanzado.",
            FIRESTARTER = "Eso era simplemente innecesario.",
        },

        WONKEY =
        {
            GENERIC = "Cámbiate de nuevo.",
            ATTACKER = "Cámbiate de nuevo bruto.",
            MURDERER = "Cámbiate de nuevo asesino.",
            REVIVER = "...",
            GHOST = "Eso no va a funcionar.",
            FIRESTARTER = "Me pregunto si así es como se sentían los dinosaurios.",
        },

        MIGRATION_PORTAL =
        {
        --    GENERIC = "If I had any friends, this could take me to them.",
        --    OPEN = "If I step through, will I still be me?",
        --    FULL = "It seems to be popular over there.",
        },
        GLOMMER = 
        {
            GENERIC = "Tienen patas de zanahoria.",
            SLEEPING = "Chirrían cuando los acaricias.",
        },
        GLOMMERFLOWER =
        {
            GENERIC = "Debería mantener esto en un lugar seguro.",
            DEAD = "Descansa en paz, Piernahoria el tercero.",
        },
        GLOMMERWINGS = "Me resulta familiar.",
        GLOMMERFUEL = "¡Piernahoria el tercero! ¡Compórtese!",
        BELL = "¡Oh, eso es!",
        STATUEGLOMMER =
        {
            GENERIC = "Cobra vida en la luna llena.",
            EMPTY = "Eso ya no guarda secretos.",
        },

        LAVA_POND_ROCK = "Vaya, una piedra.",

		WEBBERSKULL = "Tira esto en una tumba.",
		WORMLIGHT = "Delicioso.",
		WORMLIGHT_LESSER = "No es lo suficientemente jugoso.",
		WORM =
		{
		    PLANT = "¿Por qué no después de todo?",
		    DIRT = "Acechadores subterráneos.",
		    WORM = "¡Qué sorpresa, los acechadores!",
		},
        WORMLIGHT_PLANT = "Me parece seguro.",
		MOLE =
		{
			HELD = "Harold el excavador.",
			UNDERGROUND = "Cuando te capture, obtendrás un nombre.",
			ABOVEGROUND = "Aturdido.",
		},
		MOLEHILL = "Nido de topo.",
		MOLEHAT = "Apesta no usaré esto.",

		EEL = "Impactante estos todavía están aquí.",
		EEL_COOKED = "No me gusta el pescado, pero servirá.",
		UNAGI = "Comida.",
		EYETURRET = "Esto sirvió para un propósito muy diferente en el pasado.",
		EYETURRET_ITEM = "Inactivo.",
		MINOTAURHORN = "Me fallaste, ahora tengo tu nariz.",
		MINOTAURCHEST = "¡Mis cosas!",
		THULECITE_PIECES = "Es posible que quiera aferrarme a estas.",
		POND_ALGAE = "Estanque.",
		GREENSTAFF = "Conozco un mejor uso de la gema, pero bueno.",
		GIFT = "Mío.",
        GIFTWRAP = "Asimismo, esto ahora es mío.",
		POTTEDFERN = "Decoración, agrada mi ojo.",
        SUCCULENT_POTTED = "Maravilloso.",
		SUCCULENT_PLANT = "La arena del desierto teje creaciones maravillosas.",
		SUCCULENT_PICKED = "Captura la belleza antes de que se desvanezca.",
		SENTRYWARD = "Herramienta de mapeo.",
        TOWNPORTAL =
        {
			GENERIC = "Esto es inútil.",
			ACTIVE = "También podría usar esto.",
		},
        TOWNPORTALTALISMAN = 
        {
			GENERIC = "Regalo del desierto para mis ojos.",
			ACTIVE = "Preferiría caminar.",
		},
        WETPAPER = "Mojado..",
        WETPOUCH = "Mojado.",
        MOONROCK_PIECES = "No disfrutes de su luz, podrías terminar así algún día.",
        MOONBASE =
        {
            GENERIC = "¿Es eso, un dispositivo para llamarlos?",
            BROKEN = "¡No! ¡Por favor, déjame hablar con ellos!",
            STAFFED = "Ahora esperamos.",
            WRONGSTAFF = "Necesita el invocador de estrellas.",
            MOONSTAFF = "...",
        },
        MOONDIAL = 
        {
			GENERIC = "Cuenco de agua, ¿por qué necesitas una gema para eso?",
			NIGHT_NEW = "Están tejidos por la oscuridad.",
			NIGHT_WAX = "Se acerca el momento de la reunión.",
			NIGHT_FULL = "Te extraño mi querido.",
			NIGHT_WANE = "Te vas, igual que antes.",
			CAVE = "Inútil.",
			WEREBEAVER = "Brr.", --woodie specific
			GLASSED = "Espero que estés a salvo, estés donde estés.",
        },
		THULECITE = "Cómo solíamos esculpir y jugar alrededor de esto, ¿recuerdas?",
		ARMORRUINS = "Nunca me falló.",
		ARMORSKELETON = "Necesito un cuerpo diferente a esto.",
		SKELETONHAT = "Ahora eres tan sin rostro como yo.",
		RUINS_BAT = "Tiene bastante peso.",
		RUINSHAT = "No puedo usar esto, espero al regreso de mi rey.",
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "Calma antes de la tormenta.",
            WARN = "Está empezando.",
            WAXING = "El ciclo de pesadilla está a punto de comenzar.",
            STEADY = "Nunca los perdonaré por alejarte de mí.",
            WANING = "Se está yendo.",
            DAWN = "Como se va, me quedo aquí.",
            NOMAGIC = "...",
		},
		BISHOP_NIGHTMARE = "¡No tengo miedo de tus secuaces!",
		ROOK_NIGHTMARE = "¡No tengo miedo de tus secuaces!",
		KNIGHT_NIGHTMARE = "¡No tengo miedo de tus secuaces!",
		MINOTAUR = "Soy yo, animal tonto.",
		SPIDER_DROPPER = "Tiene 6 patas tengo dos, ¿cómo es eso justo?",
		NIGHTMARELIGHT = "Nunca adores al dios falso.",
		NIGHTSTICK = "¡Es eléctrico!",
		GREENGEM = "La joya transforma la materia.",
		MULTITOOL_AXE_PICKAXE = "¿Eh? Oh sí, el rascador de espalda.",
		ORANGESTAFF = "No entiendo, ¿por qué se rompe ahora?",
		YELLOWAMULET = "Es ineficiente si utiliza combustible.",
		GREENAMULET = "Tecnología antigua, realmente te hace pensar.",
		SLURPERPELT = "No, simplemente no.",	

		SLURPER = "¡Peludo!",
		SLURPER_PELT = "No, simplemente no.",
		ARMORSLURPER = "No, simplemente no..",
		ORANGEAMULET = "Conozco uno mejor.",
		YELLOWSTAFF = "Ahora este es mi favorito.",
		YELLOWGEM = "La joya brilla intensamente cuando la frotas.",
		ORANGEGEM = "La joya se utiliza en el transporte.",
        OPALSTAFF = "¿Por qué soy tan miserable ahora?",
        OPALPRECIOUSGEM = "Te extraño, rey.",
        TELEBASE = 
		{
			VALID = "El campo de aterrizaje está listo.",
			GEMS = "Es un desperdicio de gemas.",
		},
		GEMSOCKET = 
		{
			VALID = "Listo.",
			GEMS = "Las joyas, tráelas.",
		},
		STAFFLIGHT = "Luz cálida.",
        STAFFCOLDLIGHT = "Susurros entristecedores de la luna.",

        ANCIENT_ALTAR = "Construí esto.",

        ANCIENT_ALTAR_BROKEN = "Ellos destruyeron mi arte.",

        ANCIENT_STATUE = "Un memorial, un crescendo de histeria.",

        LICHEN = "Aperitivo.",
		CUTLICHEN = "Una mordida rápida.",

		CAVE_BANANA = "Delicioso.",
		CAVE_BANANA_COOKED = "¡Ñam!",
		CAVE_BANANA_TREE = "Tuvimos esto en el jardín del altar.",
		ROCKY = "Hola amigos.",
		
		COMPASS =
		{
			GENERIC="¿La gente usa esto?",
			N = "Norte.",
			S = "Sur.",
			E = "Este.",
			W = "Oeste.",
			NE = "Nordeste.",
			SE = "Sureste.",
			NW = "Noroeste.",
			SW = "Sudoeste.",
		},

        HOUNDSTOOTH = "¡Hecho para cuchillas!",
        ARMORSNURTLESHELL = "Interesante hallazgo.",
        BAT = "Eso es nuevo.",
        BATBAT = "Devuelve la fuerza vital al cuerpo.",
        BATWING = "Tíralo en una sopa.",
        BATWING_COOKED = "Come.",
        BATCAVE = "Duerme feo.",
        BEDROLL_FURRY = "Es tan cálido y cómodo.",
        BUNNYMAN = "Tarde.",
        FLOWER_CAVE = "La luz la hace brillar.",
        GUANO = "Estiércol.",
        LANTERN = "Colócalo en un poste.",
        LIGHTBULB = "Es extrañamente sabroso.",
        MANRABBIT_TAIL = "Me siento un poquito mejor cuando sostengo uno.",
        MUSHROOMHAT = "Puaj.",
        MUSHROOM_LIGHT2 =
        {
            ON = "Encendido.",
            OFF = "Apagado.",
            BURNT = "Quemado.",
        },
        MUSHROOM_LIGHT =
        {
            ON = "Encendido.",
            OFF = "Apagado.",
            BURNT = "Quemado.",
        },
        SLEEPBOMB = "¿El arma de destrucción masiva? ¿No?",
        MUSHROOMBOMB = "¿No?",
        SHROOM_SKIN = "...",
        TOADSTOOL_CAP =
        {
            EMPTY = "Aquí no.",
            INGROUND = "La rana.",
            GENERIC = "Córtalo.",
        },
        TOADSTOOL =
        {
            GENERIC = "Niño grandote, creciste un poco.",
            RAGE = "¡Reee!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "¡Molesto!",
            BURNT = "Mejor.",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "Demasiado grande.",
            BLOOM = "Apesta.",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "Sin comentarios.",
            BLOOM = "Estoy ligeramente ofendido por esto.",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "¿Una champiñón mágica?",
            BLOOM = "Está tratando de reproducirse.",
        },
        MUSHTREE_TALL_WEBBED = "Las arañas pensaron que este era importante.",
        SPORE_TALL =
        {
            GENERIC = "Simplemente está a la deriva.",
            HELD = "Mantendré una pequeña luz en mi bolsillo.",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "No tiene cuidado en el mundo.",
            HELD = "Mantendré una pequeña luz en mi bolsillo.",
        },
        SPORE_SMALL =
        {
            GENERIC = "Eso es un espectáculo para los ojos de las esporas.",
            HELD = "Mantendré una pequeña luz en mi bolsillo.",
        },
        RABBITHOUSE =
        {
            GENERIC = "Casa del conejo.",
            BURNT = "Cruel, como es la vida.",
        },
        SLURTLE = "Puaj.",
        SLURTLE_SHELLPIECES = "Sin uso real.",
        SLURTLEHAT = "Sin uso real.",
        SLURTLEHOLE = "Una guarida.",
        SLURTLESLIME = "No lo tocaría.",
        SNURTLE = "Asqueroso.",
        SPIDER_HIDER = "¡Bah!",
        SPIDER_SPITTER = "Cómo te atreves.",
        SPIDERHOLE = "Está incrustado con viejas telarañas.",
        SPIDERHOLE_ROCK = "Está incrustado con viejas telarañas.",
        STALAGMITE = "Puede haber algo de valor dentro.",
        STALAGMITE_TALL = "Rocas... rocas por todas partes.",

        TURF_CARPETFLOOR = "No lo querría en ningún lugar de mi casa.",
        TURF_CHECKERFLOOR = "Formas y colores.",
        TURF_DIRT = "Terra máxima.",
        TURF_FOREST = "Terra máxima.",
        TURF_GRASS = "Terra máxima.",
        TURF_MARSH = "Terra máxima.",
        TURF_METEOR = "Una pieza por donde caminas.",
        TURF_PEBBLEBEACH = "¿Y ahora qué?",
        TURF_ROAD = "Piedras empedradas apresuradamente.",
        TURF_ROCKY = "Terra máxima.",
        TURF_SAVANNA = "Terra máxima.",
        TURF_WOODFLOOR = "Por alguna razón este creo que es el mejor.",

		TURF_CAVE="Un pedazo de nuestra tierra.",
		TURF_FUNGUS="Un pedazo de nuestra tierra.",
		TURF_FUNGUS_MOON = "Nuestro bosque, empapado en tus lágrimas.",
		TURF_ARCHIVE = "Hogar.",
		TURF_SINKHOLE="Un pedazo de nuestra tierra.",
		TURF_UNDERROCK="Un pedazo de nuestra tierra.",
		TURF_MUD="Un pedazo de nuestra tierra.",

		TURF_DECIDUOUS = "Terra máxima.",
		TURF_SANDY = "Terra máxima.",
		TURF_BADLANDS = "Terra máxima.",
		TURF_DESERTDIRT = "Terra máxima.",
		TURF_FUNGUS_GREEN = "AUn pedazo de nuestra tierra.",
		TURF_FUNGUS_RED = "Un pedazo de nuestra tierra",
		TURF_DRAGONFLY = "Todavía está cálido.",

        TURF_SHELLBEACH = "Terra máxima.",

		TURF_RUINSBRICK = "Un pedazo de nuestra tierra.",
		TURF_RUINSBRICK_GLOW = "Un pedazo de nuestra tierra.",
		TURF_RUINSTILES = "Un pedazo de nuestra tierra.",
		TURF_RUINSTILES_GLOW = "Un pedazo de nuestra tierra.",
		TURF_RUINSTRIM = "Un pedazo de nuestra tierra.",
		TURF_RUINSTRIM_GLOW = "Un pedazo de nuestra tierra.",

        TURF_MONKEY_GROUND = "Terra máxima.",

        TURF_CARPETFLOOR2 = "Es sorprendentemente suave.",
        TURF_MOSAIC_GREY = "Terra máxima.",
        TURF_MOSAIC_RED = "Terra máxima.",
        TURF_MOSAIC_BLUE = "Terra máxima.",

		POWCAKE = "Vómito.",
        CAVE_ENTRANCE = "¿Es hora de volver?",
        CAVE_ENTRANCE_RUINS = "Es hora de volver a casa.",
       
       	CAVE_ENTRANCE_OPEN = 
        {
            GENERIC = "Salta.",
            OPEN = "Lo sé.",
            FULL = "¿Cómo?",
        },
        CAVE_EXIT = 
        {
            GENERIC = "preferiría sentarme aquí.",
            OPEN = "No quiero irme todavía.",
            FULL = "¡La superficie está demasiado concurrida!",
        },

		MAXWELLPHONOGRAPH = "La música, te vuelve insano.",
		BOOMERANG = "¡Atrapa!",
		PIGGUARD = "¡Muévete a un lado, adorador de dioses falsos!",
		ABIGAIL =
		{
            LEVEL1 =
            {
                "Una cáscara, que trata de imitar a una persona.",
                "Una cáscara, que trata de imitar a una persona.",
            },
            LEVEL2 =
            {
                "Una cáscara, que trata de imitar a una persona.",
                "Una cáscara, que trata de imitar a una persona.",
            },
            LEVEL3 =
            {
                "Una cáscara, que trata de imitar a una persona.",
                "Una cáscara, que trata de imitar a una persona.",
            },
		},
		ADVENTURE_PORTAL = "Esto no.",
		AMULET = "Tengo un mejor uso de la gema.",
		ANIMAL_TRACK = "Tiempo para una cacería.",
		ARMORGRASS = "Encuentra algo más seguro.",
		ARMORMARBLE = "Bien.",
		ARMORWOOD = "Eso lo hará.",
		ARMOR_SANITY = "No quiero esto cerca de mí.",
		ASH =
		{
			GENERIC = "Polvo.",
			REMAINS_GLOMMERFLOWER = "La flor fue consumida por el fuego.",
			REMAINS_EYE_BONE = "El huesojo fue consumido por el fuego.",
			REMAINS_THINGIE = "OK.",
		},
		AXE = "Recuerdo cuando tuve que hacerlo yo mismo, oh espera, todavía tengo que hacerlo.",
		BABYBEEFALO = 
		{
			GENERIC = "Crece.",
		    SLEEPING = "Duerme.",
        },
        BUNDLE = "Ojalá hubiera pensado en esto antes.",
        BUNDLEWRAP = "Conveniente.",
		BACKPACK = "Almacenamiento.",
		BACONEGGS = "Comer.",
		BANDAGE = "No sirve de nada sin mi ojo rojo.",
		BASALT = "Formación fuerte.",
		BEARDHAIR = "Pon esto en el fuego.",
		BEARGER = "El segundo de los amantes de la temporada.",
		BEARGERVEST = "Me siento mal por mostrarle esto a tu esposo este invierno.",
		ICEPACK = "Es como si el invierno y el otoño fueran muy bien juntos.",
		BEARGER_FUR = "Huele muy terroso, como nueces de abedul.",
		BEDROLL_STRAW = "Para descansar mis huesos en el.",
		BEEQUEEN = "¿Realeza? ¡Oh, por favor!",
		BEEQUEENHIVE = 
		{
			GENERIC = "Sí, no.",
			GROWING = "Regenerándose.",
		},
        BEEQUEENHIVEGROWN = "Aplastalo de nuevo con un martillo.",
        BEEGUARD = "Bzz bzz.",
        HIVEHAT = "Nop, esta corona no me va.",
        MINISIGN =
        {
            GENERIC = "Me gusta, Picasso.",
            UNDRAWN = "Lienzo vacío.",
        },
        MINISIGN_ITEM = "Ponlo en algún lugar.",
		BEE =
		{
			GENERIC = "Bzz.",
			HELD = "¡Bzz!",
		},
		BEEBOX =
		{
			READY = "Listo para cosechar.",
			FULLHONEY = "La miel se desborda.",
			GENERIC = "¡Bzz!",
			NOHONEY = "Está vacío.",
			SOMEHONEY = "Paciencia.",
			BURNT = "No es ignífugo.",
		},
		MUSHROOM_FARM =
		{
			STUFFED = "Un prado de flores de muerte.",
			LOTS = "Ramo de flores de muerte.",
			SOME = "Algunos engendros de muerte.",
			EMPTY = "Ninguno.",
			ROTTEN = "El tronco está muerto",
			BURNT = "Era un tronco después de todo.",
			SNOWCOVERED = "Invierno.",
		},
		BEEFALO =
		{
			FOLLOWER = "Él viene conmigo de forma pacífica.",
			GENERIC = "¡Es un beefalo!",
			NAKED = "Desnudito.",
			SLEEPING = "Dormido.",
            --Domesticated states:
            DOMESTICATED = "Bien arreglado.",
            ORNERY = "Luchador.",
            RIDER = "Corredor.",
            PUDGY = "Vaca perezosa.",
            MYPARTNER = "Chico beefoso.",
		},

		BEEFALOHAT = "No.",
		BEEFALOWOOL = "No.",
		BEEHAT = "No.",
        BEESWAX = "Para preservar.",
		BEEHIVE = "Colmena.",
		BEEMINE = "Herramienta de guerra.",
		BEEMINE_MAXWELL = "¡Este hombre está loco!",
		BERRIES = "Mejor en un plato de ensalada.",
		BERRIES_COOKED = "Agh.",
        BERRIES_JUICY = "Pudriéndose mientras hablamos.",
        BERRIES_JUICY_COOKED = "Pudriéndose mientras hablamos.",
		BERRYBUSH =
		{
			BARREN = "Fertilizar.",
			WITHERED = "No hay agua para crecer.",
			GENERIC = "Un arbusto.",
			PICKED = "Volverán a crecer.",
			DISEASED = "La plaga ha vuelto.",
			DISEASING = "La plaga ha vuelto.",
			BURNING = "Ardiendo.",
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "Estéril.",
			WITHERED = "Marchito.",
			GENERIC = "Más fruta, se pudre más rápido.",
			PICKED = "No hay fruta ahora.",
			DISEASED = "La plaga ha vuelto.",
			DISEASING = "La plaga ha vuelto.",
			BURNING = "Qué pintoresco.",
		},
		BIGFOOT = "El gigante está viniendo.",
		BIRDCAGE =
		{
			GENERIC = "Para atrapar a otra alma dentro.",
			OCCUPIED = "Yo también estoy, en estado de aislamiento.",
			SLEEPING = "Duermes allí en algún lugar también.",
			HUNGRY = "Aliméntalos bien.",
			STARVING = "Quieren darse un festín.",
			DEAD = "Separación.",
			SKELETON = "Solo huesos ahora.",
		},
		BIRDTRAP = "Desde el cielo a mis manos.",
		CAVE_BANANA_BURNT = "Cenizas.",
		BIRD_EGG = "Huevoxcepcionalmente suave.",
		BIRD_EGG_COOKED = "Feto de pájaro humeado delicioso.",
		BISHOP = "Podría querer hacerte pedazos y robarte el ojo.",
		BLOWDART_FIRE = "Para prender fuego.",
		BLOWDART_SLEEP = "Para invocar a Morfeo.",
		BLOWDART_PIPE = "Para matar.",
		BLOWDART_YELLOW = "Para golpear.",
		BLUEAMULET = "¿Por qué es tan grande? Innecesario.",
		BLUEGEM = "Esa joya no está lo suficientemente refinada.",
		BLUEPRINT = 
		{ 
            COMMON = "Un esquema.",
            RARE = "Esquema de lujo.",
        },
        SKETCH = "Una obra de arte.",
		COOKINGRECIPECARD = 
		{
			GENERIC = "Un pedazo de un libro de cocina, con garabatos horribles.",
		},
		BLUE_CAP = "Mi flor de muerte favorita.",
		BLUE_CAP_COOKED = "El aroma me enferma.",
		BLUE_MUSHROOM =
		{
			GENERIC = "Una semilla de muerte.",
			INGROUND = "Floreció de mentes que alguna vez fueron sabias.",
			PICKED = "Recogí la flor, ahora la tierra se regenerará.",
		},
		BOARDS = "Pieza refinada de material orgánico.",
		BONESHARD = "Para reconstruirme y vivir para ver el otro lado.",
		BONESTEW = "Me parece ofensivo.",
		BUGNET = "Herramienta primitiva.",
		BUSHHAT = "Bata de payaso.",
		BUTTER = "Grasa.",
		BUTTERFLY =
		{
			GENERIC = "Extraño verte.",
			HELD = "Ahora crece.",
		},
		BUTTERFLYMUFFIN = "Práctica cruel.",
		BUTTERFLYWINGS = "Lo siento amigo.",
		BUZZARD = "Comedores de carne.",

		SHADOWDIGGER = "Esta magia no sirve para ese propósito.",
        SHADOWDANCER = "...Estoy sacudido.",

		CACTUS = 
		{
			GENERIC = "Me encanta cómo sabía con los pinchos.",
			PICKED = "Volveré por más.",
		},
		CACTUS_MEAT_COOKED = "Patético.",
		CACTUS_MEAT = "Los picos son solo para agregar sabor.",
		CACTUS_FLOWER = "Solía tener un ramo en mi recámara.",

		COLDFIRE =
		{
			EMBERS = "That fire needs more fuel or it's going to go out.",
			GENERIC = "Sure beats darkness.",
			HIGH = "That fire is getting out of hand!",
			LOW = "The fire's getting a bit low.",
			NORMAL = "Nice and comfy.",
			OUT = "Well, that's over.",
		},
		CAMPFIRE =
		{
			EMBERS = "Ese fuego necesita más combustible o se va a apagar.",
			GENERIC = "Seguro que vence a la oscuridad.",
			HIGH = "¡Ese fuego se está yendo de las manos!",
			LOW = "El fuego está bajando un poco.",
			NORMAL = "Agradable y cómodo.",
			OUT = "Bueno, eso se acabó.",
		},
		CANE = "Adoro un paseo encantador.",
		CATCOON = "Diablo.",
		CATCOONDEN = 
		{
			GENERIC = "Infierno.",
			EMPTY = "El infierno congelado.",
		},
		CATCOONHAT = "Ridículo.",
		COONTAIL = "¿Bufanda o un chaleco?",
		CARROT = "Riquísimo.",
		CARROT_COOKED = "Todavía tiene el jugo.",
		CARROT_PLANTED = "Crece.",
		CARROT_SEEDS = "Es una semilla de zanahoria.",
		CARTOGRAPHYDESK =
		{
			GENERIC = "Para la creación de mapas.",
			BURNING = "Demasiado para eso.",
			BURNT = "Terminé de recuperar tierras colonizadas por ahora.",
		},
		WATERMELON_SEEDS = "Es una semilla de melón.",
		CAVE_FERN = "Un helecho.",
		CHARCOAL = "Buena pieza de material de dibujo.",
        CHESSPIECE_PAWN = "Peón.",
        CHESSPIECE_ROOK =
        {
            GENERIC = "Mi precioso niñito bebé.",
            STRUGGLE = "¡Las piezas de ajedrez se están moviendo solas!",
        },
        CHESSPIECE_KNIGHT =
        {
            GENERIC = "Caballo.",
            STRUGGLE = "¡Las piezas de ajedrez se están moviendo solas!",
        },
        CHESSPIECE_BISHOP =
        {
            GENERIC = "Molestia.",
            STRUGGLE = "¡Las piezas de ajedrez se están moviendo solas!",
        },
        CHESSPIECE_MUSE = "Reina.",
        CHESSPIECE_FORMAL = "Rey.",
        CHESSPIECE_HORNUCOPIA = "No puedo identificarme.",
        CHESSPIECE_PIPE = "Monumento de la adicción.",
        CHESSPIECE_DEERCLOPS = "Lo siento...",
        CHESSPIECE_BEARGER = "Lo siento...",
        CHESSPIECE_MOOSEGOOSE =
        {
            "Lo siento, no lo siento, tus hijos son molestos.",
        },
        CHESSPIECE_DRAGONFLY = "Me comí tu botín, bicho.",
		CHESSPIECE_MINOTAUR = "¡Mi niñito bebé!",
        CHESSPIECE_BUTTERFLY = "No puedo mirarlo por mucho tiempo.",
        CHESSPIECE_ANCHOR = "Eso parece innecesario.",
        CHESSPIECE_MOON = "Es una oda a mi anhelo, pienso en ti mi querido rey.",
        CHESSPIECE_CARRAT = "Sociedad.",
        CHESSPIECE_MALBATROSS = "Péjarro.",
        CHESSPIECE_CRABKING = "Odio que me recuerden tu existencia.",
        CHESSPIECE_TOADSTOOL = "Odio que me recuerden tu existencia.",
        CHESSPIECE_STALKER = "Padre.",
        CHESSPIECE_KLAUS = "Papi.",
        CHESSPIECE_BEEQUEEN = "Odio que me recuerden tu existencia.",
        CHESSPIECE_ANTLION = "Hermosura.",
        CHESSPIECE_BEEFALO = "Apesta.",
		CHESSPIECE_KITCOON = "Diablos.",
		CHESSPIECE_CATCOON = "Diablo.",
        CHESSPIECE_GUARDIANPHASE3 = "Guardia de casa.",
        CHESSPIECE_EYEOFTERROR = "¿Qué puedo decir?",
        CHESSPIECE_TWINSOFTERROR = "¿Por qué escucho música de jefe?",

        CHESSJUNK1 = "Una pila de huesos de metal.",
        CHESSJUNK2 = "Otra pila de huesos de metal. ",
        CHESSJUNK3 = "Aún más huesos metálicos.",
		CHESTER = "El mejor chico desde la antigüedad.",
		CHESTER_EYEBONE =
		{
			GENERIC = "Puedo identificarme.",
			WAITING = "La criatura fue asesinada a sangre fría.",
		},
		COOKEDMANDRAKE = "Me encanta.",
		COOKEDMEAT = "Comida.",
		COOKEDMONSTERMEAT = "Comida.",
		COOKEDSMALLMEAT = "¡Comida pequeña!",
		COOKPOT =
		{
			COOKING_LONG = "Necesita un montón de tiempo.",
			COOKING_SHORT = "En cualquier momento.",
			DONE = "Hecho.",
			EMPTY = "Pon cosas, saca cosas.",
			BURNT = "Alguien perdió el control de la cocina.",
		},
		CORN = "¡Es maíz! ¡Tiene el jugo!",
		CORN_COOKED = "¡No podría pensar en algo más maravilloso!",
		CORN_SEEDS = "Es una semilla de maíz.",
        CANARY =
		{
			GENERIC = "Pájaro del paraíso.",
			HELD = "Aprietalo hasta que los ojos se le salgan.",
		},
        CANARY_POISONED = "Puaj.",

		CRITTERLAB = "La adopción es una opción.",
        CRITTER_GLOMLING = "Tu nombre será Amón.",
        CRITTER_DRAGONLING = "Tu nombre será Belcebú.",
		CRITTER_LAMB = "Tu nombre será Baphomet.",
        CRITTER_PUPPY = "Su nombre será Cancerbero.",
        CRITTER_KITTEN = "Tu nombre será Asmodeus.",
        CRITTER_PERDLING = "Tu nombre será Azazel.",
		CRITTER_LUNARMOTHLING = "Tu nombre será Abadón.",

		CROW =
		{
			GENERIC = "Muchachos inteligentes.",
			HELD = "está caliente y tembloroso.",
		},
		CUTGRASS = "Fumalo, huelelo.",
		CUTREEDS = "Para papel.",
		CUTSTONE = "Pieza de construcción primitiva.",
		DEADLYFEAST = "Delicioso.",
		DEER =
		{
			GENERIC = "Esta criatura me entiende.",
			ANTLER = "Buenos cuernos, ¿te importa si tomo prestado alguno?",
		},
        DEER_ANTLER = "Estructura maravillosa.",
        DEER_GEMMED = "¡Usa mis tácticas contra mí! ¡GYAH!",
		DEERCLOPS = "Hola chico grande, ¿cómo está tu esposo?",
		DEERCLOPS_EYEBALL = "Los ojos son una ventana al alma.",
		EYEBRELLAHAT =	"Absolutamente inútil.",
		DEPLETED_GRASS =
		{
			GENERIC = "Todo chamuscado por el calor.",
		},
        GOGGLESHAT = "Feo.",
        DESERTHAT = "En qué mundo cruel debemos vivir para usar esto.",
        ANTLIONHAT = "Lástima que no pueda colocarlo sobre mi cabeza.",
		DEVTOOL = "Pachnie wołowym plackiem!",
		DEVTOOL_NODEV = "Portki mi sie spociły jak to macam.",
		DIRTPILE = "Vamos a destapar eso, ¿de acuerdo?",
		DIVININGROD =
		{
			COLD = "Aquí no.",
			GENERIC = "Lidera.",
			HOT = "Lo siento.",
			WARM = "Bueno, más cerca.",
			WARMER = "Casi estamos.",
		},
		DIVININGRODBASE =
		{
			GENERIC = "Me pregunto.",
			READY = "Necesita la vara.",
			UNLOCKED = "funcionando.",
		},
		DIVININGRODSTART = "Esa vara, lidera.",
		DRAGONFLY = "Quiero morderte muy mal.",
		ARMORDRAGONFLY = "Muchacho loco.",
		DRAGON_SCALES = "Me pregunto ¿cómo saben?",
		DRAGONFLYCHEST = "Tesoro precioso.",
		DRAGONFLYFURNACE = 
		{
			HAMMERED = "No creo que se suponga que se vea así.",
			GENERIC = "Produce mucho calor, pero no mucha luz.", --no gems
			NORMAL = "¿Me está guiñando un ojo?", --one gem
			HIGH = "¡Está hirviendo!", --two gems
		},
        
        HUTCH = "La mejor chica desde la antigüedad.",
        HUTCH_FISHBOWL =
        {
            GENERIC = "El tazón no es suficiente para el pez, pero está bien.",
            WAITING = "Muerto, el pez está muerto, ¿adivina por qué?",
        },
		LAVASPIT = 
		{
			HOT = "¡Caliente!",
			COOL = "Fresco.",
		},
		LAVA_POND = "¡Un hombre puede saltar y relajarse por la eternidad!",
		LAVAE = "Fuegín.",
		LAVAE_COCOON = "No más fuegín.",
		LAVAE_PET = 
		{
			STARVING = "Fuegín muerto de hambre..",
			HUNGRY = "Fuegín hambriento.",
			CONTENT = "Fuegín feliz.",
			GENERIC = "Fuegín precioso.",
		},
		LAVAE_EGG = 
		{
			GENERIC = "Caliéntalo.",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "Frío.",
			COMFY = "Huevo feliz.",
		},
		LAVAE_TOOTH = "El sigue.",

		DRAGONFRUIT = "Nos deleitamos con dragones, locos y lujosos.",
		DRAGONFRUIT_COOKED = "Jugosa carne de dragón.",
		DRAGONFRUIT_SEEDS = "Es una semilla de dragón.",
		DRAGONPIE = "Ahora esto es una ofrenda.",
		DRUMSTICK = "Carne.",
		DRUMSTICK_COOKED = "Carne.",
		DUG_BERRYBUSH = "Un arbusto, para un jardín.",
		DUG_BERRYBUSH_JUICY = "Un arbusto adecuado para un jardín.",
		DUG_GRASS = "Dáselo a la madre tierra.",
		DUG_MARSH_BUSH = "Dáselo a la madre tierra.",
		DUG_SAPLING = "Dáselo a la madre tierra.",
		DURIAN = "Es una fruta normal.",
		DURIAN_COOKED = "Creo que me gusta.",
		DURIAN_SEEDS = "Es una semilla de durián.",
		EARMUFFSHAT = "¿No?",
		EGGPLANT = "Es blando.",
		EGGPLANT_COOKED = "Como un huevo.",
		EGGPLANT_SEEDS = "Es una semilla de berenjena.",
		
		ENDTABLE = 
		{
			BURNT = "Un jarrón quemado sobre una mesa quemada.",
			GENERIC = "Naturaleza quieta, o una decoración.",
			EMPTY = "Una flor, aquí.",
			WILTED = "La belleza se desvanece, como el tiempo.",
			FRESHLIGHT = "Mi pequeña luz nocturna.",
			OLDLIGHT = "En la oscuridad gritamos.", -- will be wilted soon, light radius will be very small at this point
		},
		DECIDUOUSTREE = 
		{
			BURNING = "Las llamas, devoran hambrientas.",
			BURNT = "Todo quemado.",
			CHOPPED = "Tocón.",
			POISON = "Leshy, qué bueno verte.",
			GENERIC = "Árbol de aperitivos.",
		},
		ACORN = "¿Un aperitivo?",
        ACORN_SAPLING = "Un árbol de aperitivos para aperitivos.",
		ACORN_COOKED = "¡APERITIVO!",
		BIRCHNUTDRAKE = "Nuez.",
		EVERGREEN =
		{
			BURNING = "Las llamas, devoran hambrientas.",
			BURNT = "Todo quemado.",
			CHOPPED = "Tocón.",
			GENERIC = "Crece, sobre el bosque hacia arriba.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "Las llamas, devoran hambrientas.",
			BURNT = "Todo quemado.",
			CHOPPED = "Tocón.",
			GENERIC = "Se propaga, sobre el bosque hacia arriba.",
		},
		TWIGGYTREE = 
		{
			BURNING = "Las llamas, devoran hambrientas.",
			BURNT = "Todo quemado.",
			CHOPPED = "Tocón.",
			GENERIC = "Árbol débil.",			
			DISEASED = "Enfermo.",
		},
		TWIGGY_NUT_SAPLING = "No necesita ayuda para crecer.",
        TWIGGY_OLD = "Ese árbol se ve bastante débil.",
		TWIGGY_NUT = "Hay un árbol muy recto en su interior que quiere salir.",
		EYEPLANT = "...Gracioso, pero no gracioso, ja, ja.",
		INSPECTSELF = "Wonder, todavía vagando.",
		FARMPLOT =
		{
			GENERIC = "Para regalos de la madre tierra.",
			GROWING = "¡Crece, el regalo de la vida!",
			NEEDSFERTILIZER = "Repara el suelo.",
			BURNT = "¿Cenizas?",
		},
		FEATHERHAT = "No.",
		FEATHER_CROW = "Para sensatez.",
		FEATHER_ROBIN = "Para piromanía.",
		FEATHER_ROBIN_WINTER = "Para guerra.",
		FEATHER_CANARY = "Para gracia.",
		FEATHERPENCIL = "Inscribe.",
        COOKBOOK = "No es el tipo de literatura a la que estoy acostumbrado.",
		FEM_PUPPET = "¡Está atrapada!",
		FIREFLIES =
		{
			GENERIC = "¿Pequeños cuerpos astrales chispeantes?",
			HELD = "Hacen que mi corazón se caliente.",
		},
		FIREHOUND = "La bestia del infierno.",
		FIREPIT =
		{
			EMBERS = "Calor que abraza, muerte que traga.",
			GENERIC = "Poca luz.",
			HIGH = "Mira cómo la luz sube más alto.",
			LOW = "Debilita la llama.",
			NORMAL = "Quema.",
			OUT = "Apagado.",
		},
		COLDFIREPIT =
		{
			EMBERS = "Frío que olvida, vida que termina rápido.",
			GENERIC = "Poca luz.",
			HIGH = "Mira cómo la luz sube más alto.",
			LOW = "Flojea la llama.",
			NORMAL = "Eso quema.",
			OUT = "Apagado.",
		},
		FIRESTAFF = "Lata de yesca, en forma de antorcha.",
		FIRESUPPRESSOR = 
		{	
			ON = "La máquina funciona.",
			OFF = "La máquina está dormida.",
			LOWFUEL = "Bajo combustible.",
		},

		FISH = "Es un simple animal acuático.",
		FISHINGROD = "Una forma brutal de desconfianza.",
		FISHSTICKS = "Comida.",
		FISHTACOS = "La cáscara se rompe.",
		FISH_COOKED = "Brutalidad.",
		FLINT = "Para una cuchilla que corta.",
		FLOWER = 
		{
            GENERIC = "Almas de los inocentes.",
            ROSE = "Muerte al romance.",
        },
        FLOWER_WITHERED = "Se enrosca y muere.",
		FLOWERHAT = "Perece.",
		FLOWER_EVIL = "Eso no me afecta.",
		FOLIAGE = "Es una planta.",
		FOOTBALLHAT = "Agh.",
        FOSSIL_PIECE = "Material resistente, bueno para manualidades.",
        FOSSIL_STALKER =
        {
			GENERIC = "Huesos faltantes.",
			FUNNY = "No está colocado correctamente.",
			COMPLETE = "Tiene forma de amigo.",
        },
        STALKER = "¡Todavía tiene forma de amigo!",
        STALKER_ATRIUM = "Hola Nyx, mi vieja amiga.",
        STALKER_MINION = "Gush.",
        THURIBLE = "He venido a hablar contigo de nuevo.",
        ATRIUM_OVERGROWTH = "Corre.",
		FROG =
		{
			DEAD = "No más croac.",
			GENERIC = "Anfibio.",
			SLEEPING = "It's eyes go inside the skull.",
		},
		FROGGLEBUNWICH = "Puaj.",
		FROGLEGS = "Puaj.",
		FROGLEGS_COOKED = "Puaj.",
		FRUITMEDLEY = "Afrutado.",
		FURTUFT = "Pelaje blanca y negra.", 
		GEARS = "Sangre de máquina.",
		GHOST = "Pensé que yo también era un fantasma.",
		GOLDENAXE = "Para asesinato.",
		GOLDENPICKAXE = "¿Para cómo el asesinato de roca?",
		GOLDENPITCHFORK = "Es necesario.",
		GOLDENSHOVEL = "Para hacer un montón de agujeros.",
		GOLDNUGGET = "Desearía poder comerlo.",
		GRASS =
		{
			BARREN = "Necesita estiércol.",
			WITHERED = "No va a volver a crecer mientras haga tanto calor.",
			BURNING = "¡Está ardiendo rápido!",
			GENERIC = "Es una mata de hierba.",
			PICKED = "Se cortó cuando estaba en la flor de la vida.",
			DISEASED = "Parece bastante enfermo.",
			DISEASING = "Eh, algo va mal aquí.",
		},
		GRASSGEKKO = 
		{
			GENERIC = "Es un lagarto muy frondoso.",	
			DISEASED = "Parece bastante enfermo.",
		},
		GREEN_CAP = "Parece bastante normal.",
		GREEN_CAP_COOKED = "Ahora es diferente...",
		GREEN_MUSHROOM =
		{
			GENERIC = "Es una seta.",
			INGROUND = "Está durmiendo.",
			PICKED = "Me pregunto si volverá a crecer.",
		},
		GUNPOWDER = "Parece pimienta.",
		HAMBAT = "Esto parece antihigiénico.",
		HAMMER = "¡Alto! ¡Es momento de martillear cosas!",
		HEALINGSALVE = "El escozor significa que funciona.",
		HEATROCK =
		{
			FROZEN = "Es más fría que el hielo.",
			COLD = "Una piedra fría.",
			GENERIC = "Podría manipular su temperatura.",
			WARM = "Es bastante cálida y tierna... ¡para ser una roca!",
			HOT = "¡Una piedra calentita!",
		},
		HOME = "Alguien tiene que vivir aquí.",
		HOMESIGN =
		{
			GENERIC = "Dice \"Usted está aquí\".",
            UNWRITTEN = "La señal está en blanco.",
			BURNT = "\"No juegues con cerillas\".",
		},
		ARROWSIGN_POST =
		{
			GENERIC = "Dice \"Por ahí\".",
            UNWRITTEN = "La señal está en blanco.",
			BURNT = "\"No juegues con cerillas\".",
		},
		ARROWSIGN_PANEL =
		{
			GENERIC = "Dice \"Por ahí\".",
            UNWRITTEN = "La señal está en blanco.",
			BURNT = "\"No juegues con cerillas\".",
		},
		HONEY = "¡Se ve delicioso!",
		HONEYCOMB = "Las abejas solían vivir en esto.",
		HONEYHAM = "Dulce y sabroso.",
		HONEYNUGGETS = "Sabe a pollo, pero no creo que sea.",
		HORN = "Suena como un campo de beefalos.",
		HOUND = "¡No eres nada, cachorro!",
		HOUNDCORPSE =
		{
			GENERIC = "El olor no es demasiado agradable.",
			BURNING = "Creo que ahora estamos a salvo.",
			REVIVING = "¡Tragedia interminable!",
		},
		HOUNDBONE = "Espeluznante.",
		HOUNDMOUND = "No tengo ninguna cuenta pendiente con el dueño. De verdad.",
		ICEBOX = "¡He aprovechado el poder del frío!",
		ICEHAT = "No te calientes, muchacho.",
		ICEHOUND = "¿Hay perros para cada estación del año?",
		INSANITYROCK =
		{
			ACTIVE = "¡TOMA ESA, YO SANO!",
			INACTIVE = "Es más una pirámide que un obelisco.",
		},
		JAMMYPRESERVES = "Probablemente debería haber hecho un tarro.",

		KABOBS = "Comida en un palo.",
		KILLERBEE =
		{
			GENERIC = "¡Oh, no! ¡Es una abeja asesina!",
			HELD = "Parece peligrosa.",
		},
		KNIGHT = "¡Échale un vistazo!",
		KOALEFANT_SUMMER = "Adorablemente delicioso.",
		KOALEFANT_WINTER = "Parece calentito y lleno de carne.",
		KRAMPUS = "¡Va tras mis cosas!",
		KRAMPUS_SACK = "¡Qué asco! Tiene baba de krampus por todas partes.",
		LEIF = "¡Es enorme!",
		LEIF_SPARSE = "¡Es enorme!",
		LIGHTER  = "Es su mechero de la suerte.",
		LIGHTNING_ROD =
		{
			CHARGED = "¡El poder es mío!",
			GENERIC = "¡Para dominar los cielos!",
		},
		LIGHTNINGGOAT = 
		{
			GENERIC = "¡\"Beeeeehhhh\" para ti!",
			CHARGED = "No creo que le haya gustado que le haya alcanzado un rayo.",
		},
		LIGHTNINGGOATHORN = "Es como un pararrayos en miniatura.",
		GOATMILK = "¡Está llena de sabor!",
		LITTLE_WALRUS = "No va a ser tan bonito y tierno para siempre.",
		LIVINGLOG = "Parece preocupado.",
		LOG =
		{
			BURNING = "¡Un poco de madera caliente!",
			GENERIC = "Es grande, es pesado y es de madera.",
		},
		LUCY = "Esa hacha es más bonita que las que suelo ver.",
		LUREPLANT = "Qué bulbosa.",
		LUREPLANTBULB = "Ahora puedo empezar mi propia granja de carne.",
		MALE_PUPPET = "¡Está atrapado!",

		MANDRAKE_ACTIVE = "¡Córtala!",
		MANDRAKE_PLANTED = "He oído cosas extrañas sobre estas plantas.",
		MANDRAKE = "Las raíces de mandrágora tienen propiedades extrañas.",

        MANDRAKESOUP = "Bueno, ya no se despertará otra vez.",
        MANDRAKE_COOKED = "Ya no parece tan extraña.",
        MAPSCROLL = "Un mapa en blanco. No parece muy útil.",
        MARBLE = "¡Qué lujoso!",
        MARBLEBEAN = "Cambié la vieja vaca de la familia por esto.",
        MARBLEBEAN_SAPLING = "Parece tallado.",
        MARBLESHRUB = "Tiene sentido para mí.",
        MARBLEPILLAR = "Creo que podría utilizarlo.",
        MARBLETREE = "No creo que un hacha pueda cortarlo.",
        MARSH_BUSH =
        {
			BURNT = "Un terreno espinoso menos del que preocuparse.",
            BURNING = "¡Está ardiendo rápido!",
            GENERIC = "Parece espinoso.",
            PICKED = "Ay.",
        },
        BURNT_MARSH_BUSH = "Se ha quemado por completo.",
        MARSH_PLANT = "Es una planta.",
        MARSH_TREE =
        {
            BURNING = "¡Púas y fuego!",
            BURNT = "Ahora está quemado y pincha.",
            CHOPPED = "¡Ahora ya no pincha tanto!",
            GENERIC = "¡Esas púas parece que pinchan mucho!",
        },
        MAXWELL = "Odio a ese tipo.",
        MAXWELLHEAD = "Puedo ver a través de sus poros.",
        MAXWELLLIGHT = "Me pregunto cómo funciona.",
        MAXWELLLOCK = "Parece casi como una cerradura.",
        MAXWELLTHRONE = "No parece muy cómodo.",
        MEAT = "Sabe un poco fuerte, pero servirá.",
        MEATBALLS = "Es tan solo un trozo grande de carne.",
        MEATRACK =
        {
            DONE = "¡Hora de cecina!",
            DRYING = "La carne tarda un tiempo en secarse.",
            DRYINGINRAIN = "La carne tarda aún más en secarse en la lluvia.",
            GENERIC = "Debo secar algo de carne.",
            BURNT = "El costillar se ha secado.",
            DONE_NOTMEAT = "En términos de laboratorio, esto está lo que diríamos \"seco\".",
            DRYING_NOTMEAT = "Cosas secándose.",
            DRYINGINRAIN_NOTMEAT = "Lluvia, lluvia, vete de aquí. Que llueva mejor otro día al fin.",
        },
        MEAT_DRIED = "Está lo bastante seca.",
        MERM = "¡Huele mal!",
        MERMHEAD =
        {
            GENERIC = "La cosa más apestosa que oleré todo el día.",
            BURNT = "La carne quemada de tritón huele aún peor.",
        },
        MERMHOUSE =
        {
            GENERIC = "¿Quién podría vivir aquí?",
            BURNT = "Nada donde vivir, ahora.",
        },
        MINERHAT = "Una forma de manos libres para iluminar el día.",
        MONKEY = "Qué bicho tan curioso.",
        MONKEYBARREL = "¿Se acaba de mover?",
        MONSTERLASAGNA = "¿Delicioso?",
        FLOWERSALAD = "Un cuenco de follaje.",
        ICECREAM = "¡Helado, al rico helado!",
        WATERMELONICLE = "Sandía criogénica.",
        TRAILMIX = "Un aperitivo sano y natural.",
        HOTCHILI = "¡Nivel máximo de ardor!",
        GUACAMOLE = "El plato favorito de Avogadro.",
        MONSTERMEAT = "Puf. Creo que no debería comer eso.",
        MONSTERMEAT_DRIED = "Esta cecina huele raro.",
        MOOSE = "No sé exactamente lo que es eso.",
        MOOSE_NESTING_GROUND = "Pone allí a sus bebés.",
        MOOSEEGG = "Los bebés son como electrones emocionados tratando de escapar.",
        MOSSLING = "¡Aaah! ¡Definitivamente no eres un electrón!",
        FEATHERFAN = "Menos calor, quiero menos calor.",
        MINIFAN = "De alguna manera la brisa sale el doble de rápida.",
        GOOSE_FEATHER = "¡Qué mullida!",
        STAFF_TORNADO = "La muerte giratoria.",
        MOSQUITO =
        {
            GENERIC = "Pequeña sanguijuela asquerosa.",
            HELD = "Eh, ¿es esa mi sangre?",
        },
        MOSQUITOSACK = "Probablemente sea la sangre de otra persona...",
        MOUND =
        {
            DUG = "Probablemente se lo merecía.",
            GENERIC = "¡Apuesto a que hay todo tipo de cosas buenas ahí abajo!",
        },
        NIGHTLIGHT = "Emite una luz fantasmagórica.",
        NIGHTMAREFUEL = "Lágrimas de locura.",
        NIGHTSWORD = "Al filo de la noche.",
        NITRE = "No me dedico a la geología.",
        ONEMANBAND = "Deberíamos añadir un cencerro de beefalo.",
        OASISLAKE =
		{
			GENERIC = "¿Es un espejismo?",
			EMPTY = "Seco como un hueso.",
		},
        PANDORASCHEST = "¡Puede que contenga algo fantástico! U horrible.",
        PANFLUTE = "Para dar una serenata a los animales.",
        PAPYRUS = "Algunas hojas de papel.",
        WAXPAPER = "Algunas hojas de papel encerado.",
        PENGUIN = "Debe ser la temporada de cría.",
        PERD = "¡Pájaro estúpido! ¡Aléjate de las bayas!",
        PEROGIES = "Han salido bastante bien.",
        PETALS = "¡Seguro que ha enseñado a esas flores quién manda!",
        PETALS_EVIL = "No sé si quiero recogerlos.",
        PHLEGM = "Espesa y maleable. Y salada.",
        PICKAXE = "Emblemática, ¿verdad?",
        PIGGYBACK = "Este cerdido se ha ido a... \"casa\".",
        PIGHEAD =
        {
            GENERIC = "Parece una ofrenda para las bestias.",
            BURNT = "Crujiente.",
        },
        PIGHOUSE =
        {
            FULL = "Puedo ver un hocico pegado a la ventana.",
            GENERIC = "Estos cerdos tienen casas muy bonitas.",
            LIGHTSOUT = "¡Vamos! ¡Sé que estás en casa!",
            BURNT = "¡Ahora no es tan bonita, cerdo!",
        },
        PIGKING = "¡Qué asco! ¡Apesta!",
        PIGMAN =
        {
            DEAD = "Alguien debería contárselo a su familia.",
            FOLLOWER = "Eres parte de mi séquito.",
            GENERIC = "Me dan como un poco de asco.",
            GUARD = "Parece serio.",
            WEREPIG = "¡¡No es un cerdo amistoso!!",
        },
        PIGSKIN = "Todavía tiene la cola.",
        PIGTENT = "Huele a tocino.",
        PIGTORCH = "Parece acogedor.",
        PINECONE = "Puedo escuchar un pequeño árbol en su interior, tratando de salir.",
        PINECONE_SAPLING = "¡Pronto será un árbol!",
        LUMPY_SAPLING = "¿Cómo ha podido reproducirse este árbol?",
        PITCHFORK = "Ahora solo necesito una muchedumbre enfadada a la que unirme.",
        PLANTMEAT = "No parece que esté muy buena.",
        PLANTMEAT_COOKED = "Al menos está caliente ahora.",
        PLANT_NORMAL =
        {
            GENERIC = "¡Es frondosa!",
            GROWING = "¡Agh! ¡Está creciendo tan lentamente!",
            READY = "Mmmm. Lista para la cosecha.",
            WITHERED = "El calor la ha matado.",
        },
        POMEGRANATE = "Parece el interior de un cerebro de extraterrestre.",
        POMEGRANATE_COOKED = "¡Alta cocina!",
        POMEGRANATE_SEEDS = "Es una semilla de granaquées.",
        POND = "¡No puedo ver el fondo!",
        POOP = "¡Debería llenar mis bolsillos!",
        FERTILIZER = "Es sin duda un cubo lleno de estiércol.",
        PUMPKIN = "¡Es tan grande como mi cabeza!",
        PUMPKINCOOKIE = "¡Es una galleta de calabaza bastante bonita!",
        PUMPKIN_COOKED = "¿Cómo es que no se ha convertido en una tarta?",
        PUMPKIN_LANTERN = "Bonita cara que tienes.",
        PUMPKIN_SEEDS = "Es una semilla de calabaza.",
        PURPLEAMULET = "Está susurrando tonterías.",
        PURPLEGEM = "Locura en una prisión de cristal.",
        RABBIT =
        {
            GENERIC = "Está buscando zanahorias.",
            HELD = "¿Te gustan las mascotas?",
        },
        RABBITHOLE =
        {
            GENERIC = "Eso debe conducir al Reino de los Hombres Conejito.",
            SPRING = "El Reino de los Hombres Conejito está cerrado por temporada.",
        },
        RAINOMETER =
        {
            GENERIC = "Mide la nubosidad.",
            BURNT = "Las piezas que se encargan de medir se fueron en una nube de humo.",
        },
        RAINCOAT = "Mantiene la lluvia donde debe estar. Fuera del cuerpo.",
        RAINHAT = "No-oh.",
        RATATOUILLE = "Una fuente de fibra excelente.",
        RAZOR = "Una roca afilada atada a un palo. ¡Qué higiénico!",
        REDGEM = "Irradia calidez desde el interior.",
        RED_CAP = "Huele raro.",
        RED_CAP_COOKED = "Ahora es diferente...",
        RED_MUSHROOM =
        {
            GENERIC = "Una seta.",
            INGROUND = "Está durmiendo.",
            PICKED = "Me pregunto si volverá a crecer",
        },
        REEDS =
        {
            BURNING = "¡Está ardiendo realmente!",
            GENERIC = "Es una mata de juncos.",
            PICKED = "Todas los juntos útiles ya se han recogido.",
        },
        RELIC = "Antiguos artículos para el hogar.",
        RUINS_RUBBLE = "Esto se puede arreglar.",
        RUBBLE = "Solo son fragmentos de roca.",
        RESEARCHLAB =
        {
            GENERIC = "Descompone objetos en sus componentes.",
            BURNT = "Ido.",
        },
        RESEARCHLAB2 =
        {
            GENERIC = "¡Es aún más científico que el anterior!",
            BURNT = "Ido.",
        },
        RESEARCHLAB3 =
        {
            GENERIC = "No sabía que tendría que mirarlo de nuevo.",
            BURNT = "Ido.",
        },
        RESEARCHLAB4 =
        {
            GENERIC = "Patéticos trucos de magia. No conocen nuestras maneras.",
            BURNT = "Ido.",
        },
        RESURRECTIONSTATUE =
        {
            GENERIC = "¡Qué demonio tan guapo!",
            BURNT = "Ya no sirve de mucho.",
        },
        RESURRECTIONSTONE = "Así que esto resucita... Me he quedado de piedra.",
        ROBIN =
        {
            GENERIC = "¿Significa eso que el invierno se ha terminado?",
            HELD = "Le gusta mi bolsillo.",
        },
        ROBIN_WINTER =
        {
            GENERIC = "La vida en las tierras heladas.",
            HELD = "Es tan suave.",
        },
        ROBOT_PUPPET = "¡Está atrapado!",
        ROCK_LIGHT =
        {
            GENERIC = "Un pozo de lava duro.",
            OUT = "Parece frágil.",
            LOW = "La lava se está secando.",
            NORMAL = "Agradable y confortable.",
        },
        CAVEIN_BOULDER =
        {
            GENERIC = "Creo que puedo levantarla.",
            RAISED = "No está a mi alcance.",
        },
        ROCK = "No cabría en mi bolsillo.",
        PETRIFIED_TREE = "Parece tieso de miedo.",
        ROCK_PETRIFIED_TREE = "Parece tieso de miedo.",
        ROCK_PETRIFIED_TREE_OLD = "Parece tieso de miedo.",
        ROCK_ICE =
        {
            GENERIC = "Congelado de conocerte.",
            MELTED = "No será útil hasta que se congele de nuevo.",
        },
        ROCK_ICE_MELTED = "No será útil hasta que se congele de nuevo.",
        ICE = "Congelado de conocerte.",
        ROCKS = "Podríamos hacer cosas con ellas.",
        ROOK = "¡Asalta el castillo!",
        ROPE = "Algunos tramos cortos de cuerda.",
        ROTTENEGG = "¡Puaj! ¡Apesta!",
        ROYAL_JELLY = "Saboroso.",
        JELLYBEAN = "Tienen forma de judía, pero son caramelos.",
        SADDLE_BASIC = "Con esto se podrá montar a algún animal maloliente.",
        SADDLE_RACE = "¡Esta silla vuela!",
        SADDLE_WAR = "El único problema es que luego te duele todo.",
        SADDLEHORN = "Esto podría quitar una silla de montar.",
        SALTLICK = "¿Cuántos lametones hacen falta para llegar hasta el centro?",
        BRUSH = "Apuesto a que al beefalo le gusta mucho.",
		SANITYROCK =
		{
			ACTIVE = "¡Esa roca tiene un aspecto LOCO!",
			INACTIVE = "¿A dónde se ha ido el resto?",
		},
		SAPLING =
		{
			BURNING = "¡Está ardiendo rápido!",
			WITHERED = "Tal vez esté bien si se enfría.",
			GENERIC = "¡Los árboles pequeñitos son tan monos!",
			PICKED = "Así aprenderá.",
			DISEASED = "Parece bastante enfermo.",
			DISEASING = "Eh, algo va mal aquí.",
		},
   		SCARECROW = 
   		{
			GENERIC = "Tan preparado y sin cuervos que asustar.",
			BURNING = "El espantapájaros ha quedado negro como un cuervo.",
			BURNT = "¡Alguien ha MATADO a ese espantapájaros!",
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "Podemos hacer esculturas de piedra con esto.",
			BLOCK = "Lista para esculpir.",
			SCULPTURE = "¡Una obra maestra!",
			BURNT = "Está completamente quemada.",
   		},
        SCULPTURE_KNIGHTHEAD = "¿Dónde está el resto?",
		SCULPTURE_KNIGHTBODY = 
		{
			COVERED = "Una extraña estatua de mármol.",
			UNCOVERED = "Supongo que no ha resistido la presión.",
			FINISHED = "Al menos ahora está de una pieza.",
			READY = "Algo se está moviendo dentro.",
		},
        SCULPTURE_BISHOPHEAD = "¿Es eso una cabeza?",
		SCULPTURE_BISHOPBODY = 
		{
			COVERED = "Es viejo, pero está como nuevo.",
			UNCOVERED = "Falta una pieza grande.",
			FINISHED = "¿Y ahora qué?",
			READY = "Algo se está moviendo dentro.",
		},
        SCULPTURE_ROOKNOSE = "Where did this come from?",
		SCULPTURE_ROOKBODY = 
		{
			COVERED = "Una especie de estatua de mármol.",
			UNCOVERED = "No está en su mejor momento.",
			FINISHED = "Está terminada.",
			READY = "Algo se está moviendo dentro.",
		},
        GARGOYLE_HOUND = "No me gusta cómo me está mirando.",
        GARGOYLE_WEREPIG = "Parece muy real.",
		SEEDS = "Cada una es un pequeño misterio.",
		SEEDS_COOKED = "¡Le ha quitado toda la vida!",
		SEWING_KIT = "¡Maldita sea! ¡Maldición, todo se fue al diablo!",
		SEWING_TAPE = "Útil para reparar.",
		SHOVEL = "Hay mucho por desenterrar.",
		SILK = "Esto sale del trasero de una araña.",
		SKELETON = "Mejor tú que yo.",
		SCORCHED_SKELETON = "Escalofriante.",
		SKULLCHEST = "No sé si quiero abrirlo.",
		SMALLBIRD =
		{
			GENERIC = "Es un pájaro bastante pequeño.",
			HUNGRY = "Parece hambriento.",
			STARVING = "Debe estar muriéndose de hambre.",
			SLEEPING = "Hasta sus ronquidos parecen trinos.",
		},
		SMALLMEAT = "Un pequeño pedazo de animal muerto.",
		SMALLMEAT_DRIED = "Está un poco tiesa.",
		SPAT = "Qué animal de aspecto tan crujiente.",
		SPEAR = "Es un palo puntiagudo.",
		SPEAR_WATHGRITHR = "Parece lista para apuñalar.",
		WATHGRITHRHAT = "Un sombrero bastante bonito.",
		SPIDER =
		{
			DEAD = "¡Qué asco!",
			GENERIC = "Odio las arañas.",
			SLEEPING = "Será mejor no estar aquí cuando despierte.",
		},
		SPIDERDEN = "¡Está pegajoso!",
		SPIDEREGGSACK = "Espero que no eclosione. Punto.",
		SPIDERGLAND = "Tiene un olor antiséptico y penetrante.",
		SPIDERHAT = "Espero haber quitado toda la viscosidad.",
		SPIDERQUEEN = "¡AHHHHHHHH! ¡Esa araña es enorme!",
		SPIDER_WARRIOR =
		{
			DEAD = "¡Hasta nunca!",
			GENERIC = "Parece más mala de lo habitual.",
			SLEEPING = "Debería mantener la distancia.",
		},
		SPOILED_FOOD = "Es una bola peluda de comida podrida.",
        STAGEHAND =
        {
			AWAKE = "No toques nada, ¿vale?",
			HIDING = "Aquí hay algo extraño, pero se me escapa de las manos.",
        },
        STATUE_MARBLE = 
        {
            GENERIC = "Una bonita estatua de mármol.",
            TYPE1 = "¡No pierdas la cabeza!",
            TYPE2 = "Estatuesco.",
            TYPE3 = "Me pregunto quién será el artista.", --bird bath type statue
        },
		STATUEHARP = "¿Qué pasó con la cabeza?",
		STATUEMAXWELL = "Es mucho más bajo en persona.",
		STEELWOOL = "Fibras de metal ásperas.",
		STINGER = "Parece puntiagudo!",
		STRAWHAT = "No puedo usar esto.",
		STUFFEDEGGPLANT = "¡Está realmente rellena!",
		SWEATERVEST = "Este chaleco es muy elegante y apuesto.",
		REFLECTIVEVEST = "¡Mantente alejado, sol del demonio!",
		HAWAIIANSHIRT = "Atroz...",
		TAFFY = "Si tuviera dentista, me regañaría mucho por comer estas cosas.",
		TALLBIRD = "¡Qué pájaro tan alto!",
		TALLBIRDEGG = "¿Saldrá del cascarón?",
		TALLBIRDEGG_COOKED = "Delicioso y nutritivo.",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "¿Está temblando o soy yo?",
			GENERIC = "¡Parece que va a salir del cascarón!",
			HOT = "¿Acaso los huevos sudan?",
			LONG = "Tengo la sensación de que va a tardar un poco más...",
			SHORT = "Podría salir del cascarón en cualquier momento.",
		},
		TALLBIRDNEST =
		{
			GENERIC = "¡Menudo huevo!",
			PICKED = "El nido está vacío.",
		},
		TEENBIRD =
		{
			GENERIC = "No es un pájaro muy alto.",
			HUNGRY = "Necesitas algo de comida y rápido, ¿eh?",
			STARVING = "Tiene una mirada peligrosa.",
			SLEEPING = "Se está echando una cabezada.",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "¡Con esto seguro que puedo atravesar el espacio y el tiempo!",
			GENERIC = "¡Esto parece ser un nexo hacia otro mundo!",
			LOCKED = "Todavía falta algo.",
			PARTIAL = "¡Pronto mi invención estará terminada!",
		},
		TELEPORTATO_BOX = "Esto puede controlar la polaridad de todo el universo.",
		TELEPORTATO_CRANK = "Manivela.",
		TELEPORTATO_POTATO = "Esta patata de metal contiene un gran y temible poder...",
		TELEPORTATO_RING = "Un anillo que podría concentrar energías dimensionales.",
		TELESTAFF = "Perspectiva completamente nueva.",
		TENT = 
		{
			GENERIC = "Enloquezco cuando no duermo.",
			BURNT = "No queda nada donde dormir.",
		},
		SIESTAHUT = 
		{
			GENERIC = "Un buen lugar para descansar del calor de la tarde.",
			BURNT = "Ahora ya no dará mucha sombra.",
		},
		TENTACLE = "Parece peligroso.",
		TENTACLESPIKE = "Es puntiagudo y viscoso.",
		TENTACLESPOTS = "Creo que estos eran sus genitales.",
		TENTACLE_PILLAR = "Un poste viscoso.",
        TENTACLE_PILLAR_HOLE = "Parece que apesta, pero vale la pena explorarlo.",
		TENTACLE_PILLAR_ARM = "Unos brazos resbaladizos.",
		TENTACLE_GARDEN = "Otro poste viscoso más.",
		TOPHAT = "No puedo usar esto.",
		TORCH = "Algo para alumbrar la noche.",
		TRANSISTOR = "Está zumbando de electricidad.",
		TRAP = "La he apretado bien.",
		TRAP_TEETH = "Es una sorpresa desagradable.",
		TRAP_TEETH_MAXWELL = "¡Querré evitar pisar eso!",
		TREASURECHEST = 
		{
			GENERIC = "¡Es un cofre!",
			BURNT = "Ese baúl se ha chamuscado.",
		},
		TREASURECHEST_TRAP = "¡Qué conveniente!",
		SACRED_CHEST = 
		{
			GENERIC = "Oigo susurros. Quiere algo.",
			LOCKED = "Emite su juicio.",
		},
		TREECLUMP = "Es casi como si alguien estuviera tratando de evitar que vaya a alguna parte.",
		
		TRINKET_1 = "Están muy blandas. ¿Igual Willow se ha estado divirtiendo con ellas?", --Melted Marbles
		TRINKET_2 = "¿Y este nombre tan raro que tienes?", --Fake Kazoo
		TRINKET_3 = "El nudo no se puede deshacer. Para siempre.", --Gord's Knot
		TRINKET_4 = "Parece una especie de artefacto religioso.", --Gnome
		TRINKET_5 = "Por desgracia, es demasiado pequeño para escapar en él.", --Toy Rocketship
		TRINKET_6 = "Sus días de conducir electricidad han terminado.", --Frazzled Wires
		TRINKET_7 = "¡No hay tiempo para divertirse y jugar!", --Ball and Cup
		TRINKET_8 = "Genial. Esto satisface todas mis necesidades de baño.", --Rubber Bung
		TRINKET_9 = "A mí me van más las cremalleras.", --Mismatched Buttons
		TRINKET_10 = "Se han convertido rápidamente en el attrezzo favorito de Wes.", --Dentures
		TRINKET_11 = "Hal me susurra bonitas mentiras.", --Lying Robot
		TRINKET_12 = "Es suave.", --Dessicated Tentacle
		TRINKET_13 = "Parece una especie de artefacto religioso.", --Gnomette
		TRINKET_14 = "Ojalá tuviera algo de té...", --Leaky Teacup
		TRINKET_15 = "... Maxwell no ha vuelto a recoger sus cosas.", --Pawn
		TRINKET_16 = "... Maxwell no ha vuelto a recoger sus cosas.", --Pawn
		TRINKET_17 = "Una fusión de utensilios horrorosa.", --Bent Spork
		TRINKET_18 = "Me pregunto qué esconde.", --Trojan Horse
		TRINKET_19 = "No gira muy bien.", --Unbalanced Top
		TRINKET_20 = "¿¡Wigfrid sigue saltando y golpeándome con él!?", --Backscratcher
		TRINKET_21 = "Esta batidora se ha quedado chafada.", --Egg Beater
		TRINKET_22 = "Tengo una sensación extraña de poner esto en la cuenca de mi ojo.", --Frayed Yarn
		TRINKET_23 = "Puedo ponerme los zapatos sin ayuda, gracias.", --Shoehorn
		TRINKET_24 = "Creo que Wickerbottom tenía un gato.", --Lucky Cat Jar
		TRINKET_25 = "Huele un poco a rancio.", --Air Unfreshener
		TRINKET_26 = "¡Comida y una taza! El recipiente de supervivencia definitivo.", --Potato Cup
		TRINKET_27 = "Si la abres, puedes tocar a alguien desde muy lejos.", --Coat Hanger
		TRINKET_28 = "Qué maquiavélico.", --Rook
        TRINKET_29 = "Qué maquiavélico.", --Rook
        TRINKET_30 = "De verdad, siempre deja las piezas por todas partes.", --Knight
        TRINKET_31 = "De verdad, siempre deja las piezas por todas partes.", --Knight
        TRINKET_32 = "¡Conozco a alguien que se lo pasaría en grande con esto!", --Cubic Zirconia Ball
        TRINKET_33 = "Espero que no atraiga a las arañas.", --Spider Ring
        TRINKET_34 = "Pidamos un deseo.", --Monkey Paw
        TRINKET_35 = "Es difícil encontrar un buen frasco por aquí.", --Empty Elixir
        TRINKET_36 = "Tal vez me haga falta después de tantas golosinas.", --Faux fangs
        TRINKET_37 = "Rumores.", --Broken Stake
        TRINKET_38 = "Creo que viene de otro mundo. Un tal Grift...", -- Binoculars Griftlands trinket
        TRINKET_39 = "¿Dónde estará el otro?", -- Lone Glove Griftlands trinket
        TRINKET_40 = "Con esto me dan ganas de hacer trueques.", -- Snail Scale Griftlands trinket
        TRINKET_41 = "Está un poco caliente al tacto.", -- Goop Canister Hot Lava trinket
        TRINKET_42 = "Tiene muchos recuerdos de la infancia para alguien.", -- Toy Cobra Hot Lava trinket
        TRINKET_43= "No se le da muy bien saltar.", -- Crocodile Toy Hot Lava trinket
        TRINKET_44 = "Es una especie de planta.", -- Broken Terrarium ONI trinket
        TRINKET_45 = "Está recibiendo frecuencias de otro mundo.", -- Odd Radio ONI trinket
        TRINKET_46 = "¿Quizás una herramienta para probar la aerodinámica?", -- Hairdryer ONI trinket

        -- The numbers align with the trinket numbers above.
        LOST_TOY_1  = "Recuerdos perdidos.",
        LOST_TOY_2  = "Recuerdos perdidos.",
        LOST_TOY_7  = "Recuerdos perdidos.",
        LOST_TOY_10 = "Recuerdos perdidos.",
        LOST_TOY_11 = "Recuerdos perdidos.",
        LOST_TOY_14 = "Recuerdos perdidos.",
        LOST_TOY_18 = "Recuerdos perdidos.",
        LOST_TOY_19 = "Recuerdos perdidos.",
        LOST_TOY_42 = "Recuerdos perdidos.",
        LOST_TOY_43 = "Recuerdos perdidos.",

        HALLOWEENCANDY_1 = "Las caries seguro que merecen la pena, ¿no?",
        HALLOWEENCANDY_2 = "¿Qué?",
        HALLOWEENCANDY_3 = "Es... maíz.",
        HALLOWEENCANDY_4 = "Se retuercen cuando las tragas.",
        HALLOWEENCANDY_5 = "Mis dientes no estarán muy contentos con esto mañana.",
        HALLOWEENCANDY_6 = "Creo que... no me los comeré.",
        HALLOWEENCANDY_7 = "Todo el mundo va a hablar de esto.",
        HALLOWEENCANDY_8 = "Solo a un idiota no le gustaría.",
        HALLOWEENCANDY_9 = "Se queda pegado a los dientes.",
        HALLOWEENCANDY_10 = "Solo a un idiota no le gustaría.",
        HALLOWEENCANDY_11 = "Sabe mucho mejor que el de verdad.",
        HALLOWEENCANDY_12 = "¿Se acaba de mover ese caramelo?", --ONI meal lice candy
        HALLOWEENCANDY_13 = "Ay, mi pobre mandíbula.", --Griftlands themed candy
        HALLOWEENCANDY_14 = "No me gusta lo picante.", --Hot Lava pepper candy
        CANDYBAG = "Algún tipo de deliciosa dimensión de bolsillo para golosinas.",

		HALLOWEEN_ORNAMENT_1 = "Un espectrornamento que podría colgar de un árbol.",
		HALLOWEEN_ORNAMENT_2 = "Una decoración aterradora.",
		HALLOWEEN_ORNAMENT_3 = "Quedaría bien colgado en alguna parte.", 
		HALLOWEEN_ORNAMENT_4 = "Estos tentáculos son como los de verdad.",
		HALLOWEEN_ORNAMENT_5 = "Un adorno de ocho patas.",
		HALLOWEEN_ORNAMENT_6 = "Cría cuervos y tendrás muchas decoraciones para los árboles.", 

		HALLOWEENPOTION_DRINKS_WEAK = "Esperaba algo más grande.",
		HALLOWEENPOTION_DRINKS_POTENT = "Una pócima poderosa.",
        HALLOWEENPOTION_BRAVERY = "Qué agallas.",
		HALLOWEENPOTION_MOON = "Imbuida de cositas transformadoras.",
		HALLOWEENPOTION_FIRE_FX = "Infierno de cristal.", 
		MADSCIENCE_LAB = "La cordura es un pequeño precio.",
		LIVINGTREE_ROOT = "¡Hay algo aquí! Tendré que sacarlo de raíz.", 
		LIVINGTREE_SAPLING = "Crecerá hasta convertirse en grande y horrible.",

        DRAGONHEADHAT = "No puedo usar esto.",
        DRAGONBODYHAT = "No puedo usar esto.",
        DRAGONTAILHAT = "No puedo usar esto.",
        PERDSHRINE =
        {
            GENERIC = "Presiento que quiere algo.",
            EMPTY = "Tengo que plantar algo aquí.",
            BURNT = "Esto no bastará.",
        },
        REDLANTERN = "Este farol parece más especial que los demás.",
        LUCKY_GOLDNUGGET = "¡Menudo hallazgo!",
        FIRECRACKERS = "¡Llenos de explosivos!",
        PERDFAN = "Es extraordinariamente grande.",
        REDPOUCH = "¿Hay algo dentro?",
        WARGSHRINE = 
        {
            GENERIC = "Debería hacer algo divertido.",
            EMPTY = "Necesito ponerle una antorcha.",
            BURNING = "Debería hacer algo divertido.", --for willow to override
            BURNT = "Se ha quemado.",
        },
        CLAYWARG = 
        {
        	GENERIC = "¡Un terrorífico monstruo de terracota!",
        	STATUE = "¿Se acaba de mover?",
        },
        CLAYHOUND = 
        {
        	GENERIC = "¡Le han desatado!",
        	STATUE = "Parece tan real.",
        },
        HOUNDWHISTLE = "Esto detendría a un perro.",
        CHESSPIECE_CLAYHOUND = "Esa cosa es el motivo de mis preocupaciones.",
        CHESSPIECE_CLAYWARG = "¡Y ni siquiera me han comido!",

		PIGSHRINE =
		{
            GENERIC = "Más cosas que hacer.",
            EMPTY = "Tiene hambre de carne.",
            BURNT = "Totalmente quemado.",
		},
		PIG_TOKEN = "Esto parece importante.",
		PIG_COIN = "Esto saldrá a cuenta en una pelea.",
		YOTP_FOOD1 = "Un festín para mí.",
		YOTP_FOOD2 = "Una comida que solo le gustaría a una bestia.",
		YOTP_FOOD3 = "Nada sofisticado.",

		PIGELITE1 = "¿Qué miras?", --BLUE
		PIGELITE2 = "¡Tiene la fiebre del oro!", --RED
		PIGELITE3 = "¡Tienes barro en el ojo!", --WHITE
		PIGELITE4 = "¿Por qué no golpeas a otro?", --GREEN

		PIGELITEFIGHTER1 = "¿Qué miras?", --BLUE
		PIGELITEFIGHTER2 = "¡Tiene la fiebre del oro!", --RED
		PIGELITEFIGHTER3 = "¡Tienes barro en el ojo!", --WHITE
		PIGELITEFIGHTER4 = "¿Por qué no golpeas a otro?", --GREEN

		CARRAT_GHOSTRACER = "Es... desconcertante.",

        YOTC_CARRAT_RACE_START = "No es mal sitio para empezar.",
        YOTC_CARRAT_RACE_CHECKPOINT = "Tienes tus metas claras.",
        YOTC_CARRAT_RACE_FINISH =
        {
            GENERIC = "Es más un círculo que una línea de meta.",
            BURNT = "¡Ha ardido en llamas!",
            I_WON = "¡JA, JA!",
            SOMEONE_ELSE_WON = "Ay... Enhorabuena, {winner}.",
        },

		YOTC_CARRAT_RACE_START_ITEM = "Bueno, es un comienzo.",
        YOTC_CARRAT_RACE_CHECKPOINT_ITEM = "La vida es una carrera.",
		YOTC_CARRAT_RACE_FINISH_ITEM = "El fin está a la vista.",

		YOTC_SEEDPACKET = "Casi preferiría alpiste, la verdad.",
		YOTC_SEEDPACKET_RARE = "¡Hola, plantitas en potencia!",

		MINIBOATLANTERN = "¡Una opción iluminadora!",

        YOTC_CARRATSHRINE =
        {
            GENERIC = "¿Qué hacer...?",
            EMPTY = "Mmm... ¿Qué come una zanarrata?",
            BURNT = "Huele a zanahorias asadas.",
        },

        YOTC_CARRAT_GYM_DIRECTION =
        {
            GENERIC = "Esto hará moverse las cosas en la dirección correcta.",
            RAT = "Serías una excelente rata de laboratorio.",
            BURNT = "Mi rutina de entrenamiento destrozada y quemada.",
        },
        YOTC_CARRAT_GYM_SPEED =
        {
            GENERIC = "Tengo que poner en forma a mi zanarrata.",
            RAT = "¡Mejor! ¡Más rápido!",
            BURNT = "Puede que me haya pasado.",
        },
        YOTC_CARRAT_GYM_REACTION =
        {
            GENERIC = "¡Vamos a entrenar esos reflejos de zanarrata!",
            RAT = "¡El tiempo de respuesta del sujeto no hace más que mejorar!",
            BURNT = "...",
        },
        YOTC_CARRAT_GYM_STAMINA =
        {
            GENERIC = "¡Se está poniendo cachas!",
            RAT = "¡¡¡Esta zanarrata... será imparable!!!",
            BURNT = "¡El progreso no se puede detener! Pero esto lo retrasará.",
        },

        YOTC_CARRAT_GYM_DIRECTION_ITEM = "¡Será mejor ponerse a entrenar!",
        YOTC_CARRAT_GYM_SPEED_ITEM = "Será mejor que monte esto.",
        YOTC_CARRAT_GYM_STAMINA_ITEM = "Esto debería mejorar la vitalidad de mi zanarrata.",
        YOTC_CARRAT_GYM_REACTION_ITEM = "Esto debería mejorar considerablemente el tiempo de reacción de mi zanarrata.",

        YOTC_CARRAT_SCALE_ITEM = "Tengo motivos de peso para usar esto.",
        YOTC_CARRAT_SCALE =
        {
            GENERIC = "Espero que la balanza se incline a mi favor.",
            CARRAT = "Supongo que, pase lo que pase, es un vegetal consciente.",
            CARRAT_GOOD = "¡Esta zanarrata ha madurado para competir!",
            BURNT = "Qué desastre.",
        },

        YOTB_BEEFALOSHRINE =
        {
            GENERIC = "¿Qué hacer...?",
            EMPTY = "Um... ¿Qué es lo que vuelve beefalo a un beefalo?",
            BURNT = "Huele a barbacoa.",
        },

        BEEFALO_GROOMER =
        {
            GENERIC = "Aquí no hay beefalos a los que acicalar.",
            OCCUPIED = "¡Vamos a dejarte despampanante!",
            BURNT = "Quería que mi beefalo estuviera radiante..., pero creo que se han pasado.",
        },
        BEEFALO_GROOMER_ITEM = "Tendré que poner esto en algún lado.",

		BISHOP_CHARGE_HIT = "¡Ay!",
		TRUNKVEST_SUMMER = "Indómito, pero casual.",
		TRUNKVEST_WINTER = "Equipo de supervivencia invernal.",
		TRUNK_COOKED = "De alguna manera es aún más nasal que antes.",
		TRUNK_SUMMER = "Una trompa muy fresquita.",
		TRUNK_WINTER = "Un chaleco grueso y peludo.",
		TUMBLEWEED = "Quién sabe lo que habrá recogido la rodadora.",
		TURKEYDINNER = "Mmmm.",
		TWIGS = "Es un montón de pequeñas ramitas.",
		UMBRELLA = "Siempre odio cuando estoy mojado.",
		GRASS_UMBRELLA = "Eh.",
		UNIMPLEMENTED = "¡No parece terminado! ¡Podría ser peligroso!",
		WAFFLES = "¿Necesitará más sirope el gofre?",
		WALL_HAY = 
		{	
			GENERIC = "Hmmmm. Supongo que con esto bastará.",
			BURNT = "Esto no bastará.",
		},
		WALL_HAY_ITEM = "Esto parece una mala idea.",
		WALL_STONE = "Qué pared tan bonita.",
		WALL_STONE_ITEM = "Me hacen sentir muy a salvo.",
		WALL_RUINS = "Un trozo de muro antiguo.",
		WALL_RUINS_ITEM = "Un fragmento de historia sólido.",
		WALL_WOOD = 
		{
			GENERIC = "¡Puntiagudo!",
			BURNT = "¡Quemada!",
		},
		WALL_WOOD_ITEM = "¡Estacas!",
		WALL_MOONROCK = "¡Espacial y lisa!",
		WALL_MOONROCK_ITEM = "Muy ligera, pero sorprendentemente resistente.",
		FENCE = "No es más que una valla de madera.",
        FENCE_ITEM = "Todo lo que necesitamos para construir una buena valla resistente.",
        FENCE_GATE = "Se abre. Y a veces también se cierra.",
        FENCE_GATE_ITEM = "Todo lo que necesitamos para construir una buena puerta resistente.",
		WALRUS = "Las morsas son depredadores naturales.",
		WALRUSHAT = "Es una pena que no pueda usar esto.",
		WALRUS_CAMP =
		{
			EMPTY = "Parece que alguien estuvo acampando aquí.",
			GENERIC = "Parece cálida y acogedora por dentro.",
		},
		WALRUS_TUSK = "Seguro que acabaré encontrándole un uso.",
		WARDROBE = 
		{
			GENERIC = "Guarda secretos oscuros y prohibidos...",
            BURNING = "¡Está ardiendo rápido!",
			BURNT = "Ahora ya no tiene estilo.",
		},
		WARG = "Tal vez se te deba tener en cuenta, perro grande.",
        WARGLET = "Hoy no es mi día...",

		WASPHIVE = "Creo que esas abejas están locas.",
		WATERBALLOON = "¿Globo?",
		WATERMELON = "Dulce y pegajoso.",
		WATERMELON_COOKED = "Jugoso y caliente.",
		WATERMELONHAT = "No puedo usar esto.",
		WAXWELLJOURNAL = "Escalofriante.",
		WETGOOP = "No sabe a nada.",
        WHIP = "Nada como ruidos fuertes para ayudar a mantener la paz.",
		WINTERHAT = "No puedo usar esto.",
		WINTEROMETER = 
		{
			GENERIC = "Mercúrico.",
			BURNT = "us días de medición han terminado.",
		},

        WINTER_TREE =
        {
            BURNT = "Ha amargado las fiestas.",
            BURNING = "Fue un error, creo.",
            CANDECORATE = "¡Feliz Fiesta Invernal!",
            YOUNG = "¡Ya casi es la Fiesta Invernal!",
        },
		WINTER_TREESTAND = 
		{
			GENERIC = "Necesito una piña para eso.",
            BURNT = "Ha amargado las fiestas.",
		},
        WINTER_ORNAMENT = "A todos los hombres les gustan los adornos.",
        WINTER_ORNAMENTLIGHT = "Un árbol no está completo sin electricidad.",
        WINTER_ORNAMENTBOSS = "Este es particularmente impresionante.",
		WINTER_ORNAMENTFORGE = "Debería colgarlo sobre un fuego.",
		WINTER_ORNAMENTGORGE = "Por alguna razón me da hambre.",

        WINTER_FOOD1 = "La anatomía no está bien, pero lo pasaré por alto.", --gingerbread cookie
        WINTER_FOOD2 = "Voy a comerme cuarenta.", --sugar cookie
        WINTER_FOOD3 = "Unas caries navideñas en potencia.", --candy cane
        WINTER_FOOD4 = "Mmmm.", --fruitcake
        WINTER_FOOD5 = "Está bien comer algo que no sean bayas de vez en cuando.", --yule log cake
        WINTER_FOOD6 = "¡Voy a zamparme eso!", --plum pudding
        WINTER_FOOD7 = "Una manzana hueca rellena de delicioso zumo.", --apple cider
        WINTER_FOOD8 = "¿Cómo permanece caliente? ¿La taza es termodinámica?", --hot cocoa
        WINTER_FOOD9 = "¿Puede alguien explicar por qué está tan bueno?", --eggnog

		WINTERSFEASTOVEN =
		{
			GENERIC = "¡Un horno festivo para comiditas a la brasa!",
			COOKING = "Cocinando.",
			ALMOST_DONE_COOKING = "¡Ya casi está hecho!",
			DISH_READY = "Está hecho.",
		},
		BERRYSAUCE = "Bayas y alegría a partes iguales.",
		BIBINGKA = "Suave y de textura esponjosa.",
		CABBAGEROLLS = "La carne se esconde dentro de la col para evitar depredadores.",
		FESTIVEFISH = "No me importaría probar un poco de marisco de temporada.",
		GRAVY = "Es todo salsa.",
		LATKES = "Podría comer latkes a manojillo.",
		LUTEFISK = "¿Hay algún trompefisk?",
		MULLEDDRINK = "Este ponche tiene personalidad.",
		PANETTONE = "Este pan navideño no ha defraudado.",
		PAVLOVA = "No hay nada como una buena pavlova.",
		PICKLEDHERRING = "No te daré arengas sobre el arenque.",
		POLISHCOOKIE = "¡Dejaré el plato reluciente!",
		PUMPKINPIE = "Probablemente debería comérmelo todo...",
		ROASTTURKEY = "Veo un muslito jugoso y grande con mi nombre escrito.",
		STUFFING = "¡Esto me re-llena de alegría!",
		SWEETPOTATO = "He creado un híbrido entre la cena y el postre.",
		TAMALES = "Como zampe mucho más, me voy a empezar a sentir una mole.",
		TOURTIERE = "Un placer comerte.",

		TABLE_WINTERS_FEAST =
		{
			GENERIC = "Una mesa de banquete.",
			HAS_FOOD = "¡Hora de comer!",
			WRONG_TYPE = "No es el momento adecuado para eso.",
			BURNT = "¿Quién haría algo así?",
		},

		GINGERBREADWARG = "Hora de postergar el postre.",
		GINGERBREADHOUSE = "Alojamiento y comida, todo en uno.",
		GINGERBREADPIG = "Será mejor que lo siga.",
		CRUMBS = "Una forma deliciosa de esconderse.",
		WINTERSFEASTFUEL = "¡El espíritu de las fiestas!",

        KLAUS = "¿¡Qué demonios es eso!?",
        KLAUS_SACK = "Sin duda deberíamos abrirlo.",
		KLAUSSACKKEY = "Para ser una cornamenta de ciervo mola mucho.",
		WORMHOLE =
		{
			GENERIC = "Suave y ondulante.",
			OPEN = "Salta dentro de él.",
		},
		WORMHOLE_LIMITED = "Agh, esa cosa tiene peor pinta que de costumbre.",
		ACCOMPLISHMENT_SHRINE = "Quiero usarlo, y quiero que el mundo sepa lo que hice.",        
		LIVINGTREE = "¿Me está mirando?",
		ICESTAFF = "Es como un juguete para niños.",
		REVIVER = "¡El latido de este corazón horrible traerá a un fantasma a la vida!",
		SHADOWHEART = "Puedo sentir mi corazón ahora...",
        ATRIUM_RUBBLE = 
        {
			LINE_1 = "Muestra una civilización antigua. La gente parece hambrienta y asustada.",
			LINE_2 = "Esta tabla está demasiado desgastada para ver lo que hay en ella.",
			LINE_3 = "Algo oscuro se cierne sobre la ciudad y sus habitantes.",
			LINE_4 = "La gente está mudando la piel. Parecen diferentes debajo.",
			LINE_5 = "Muestra una ciudad inmensa y con una tecnología avanzada.",
		},
        ATRIUM_STATUE = "No parece del todo real.",
        ATRIUM_LIGHT = 
        {
			ON = "Una luz muy perturbadora.",
			OFF = "Algo debe de alimentarlo.",
		},
        ATRIUM_GATE =
        {
			ON = "Vuelve a funcionar bien.",
			OFF = "Los componentes esenciales siguen intactos.",
			CHARGING = "Está cobrando poder.",
			DESTABILIZING = "El portal se está desestabilizando.",
			COOLDOWN = "Necesita tiempo para recuperarse. Igual que yo.",
        },
        ATRIUM_KEY = "Emana una energía.",
		LIFEINJECTOR = "Basura.",
		--SKELETON_PLAYER =
		--{
		--	MALE = "%s debe de haber muerto realizando un experimento con %s.",
		--	FEMALE = "%s debe de haber muerto realizando un experimento con %s.",
		--	ROBOT = "%s debe de haber muerto realizando un experimento con %s.",
		--	DEFAULT = "%s debe de haber muerto realizando un experimento con %s.",
		--},
		HUMANMEAT = "La carne es carne. ¿Donde trazo el límite?",
		HUMANMEAT_COOKED = "Cocinada tiene un bonito color rosado, pero moralmente sigue siendo gris.",
		HUMANMEAT_DRIED = "Si se deja secar ya no procede de un humano, ¿verdad?",
		ROCK_MOON = "Esa roca proviene de la luna.",
		MOONROCKNUGGET = "Esa roca proviene de la luna.",
		MOONROCKCRATER = "Debería meter algo brillante. Para investigar.",
		MOONROCKSEED = "¡Hay algo dentro!",

        REDMOONEYE = "¡Puede ver y que le vean a kilómetros a la redonda!",
        PURPLEMOONEYE = "Es un buen indicador, pero ojalá dejará de mirarme.",
        GREENMOONEYE = "Vigilará bien el lugar.",
        ORANGEMOONEYE = "Nadie se perderá si ese chisme los busca.",
        YELLOWMOONEYE = "Indicará el camino a todo el mundo.",
        BLUEMOONEYE = "Siempre es conveniente estar ojo avizor.",

                --Arena Event
        LAVAARENA_BOARLORD = "Un hombre despiadado.",
        BOARRIOR = "Tu muerte será rápida.",
        BOARON = "Lástima que tengas que morir.",
        PEGHOOK = "Mi fe me defenderá.",
        TRAILS = "Caerás.",
        TURTILLUS = "No puedes protegerte de este mundo.",
        SNAPPER = "La muerte será una bendición.",
		RHINODRILL = "La camaradería fraternal no te salvará.",
		BEETLETAUR = "Eres prisionero de tu propio destino condenado.",

        LAVAARENA_PORTAL =
        {
            ON = "Te deseo un buen día.",
            GENERIC = "No me atrevía a esperar que me llevara a casa.",
        },
        LAVAARENA_KEYHOLE = "Vacío como mi corazón.",
		LAVAARENA_KEYHOLE_FULL = "Lleno como mis penas.",
        LAVAARENA_BATTLESTANDARD = "Hay que destruir ese estandarte de batalla...",
        LAVAARENA_SPAWNER = "De ahí es de donde salen...",

        HEALINGSTAFF = "Podría curar a mis aliados.",
        FIREBALLSTAFF = "Para llamar a la muerte desde el cielo.",
        HAMMER_MJOLNIR = "Qué accesorio tan brutal.",
        SPEAR_GUNGNIR = "Para cortar y rajar...",
        BLOWDART_LAVA = "Para perforar los corazones de mis enemigos...",
        BLOWDART_LAVA2 = "¡Para quemar y perforar!",
        LAVAARENA_LUCY = "Hola de nuevo, Lucy.",
        WEBBER_SPIDER_MINION = "Webber parece orgulloso de ellas.",
        BOOK_FOSSIL = "Hay poder en las palabras.",
		LAVAARENA_BERNIE = "¿Qué tal, Bernie?",
		SPEAR_LANCE = "Qué arma tan brutal...",
		BOOK_ELEMENTAL = "No querría tener tal poder.",
		LAVAARENA_ELEMENTAL = "¿Cuándo te librarás de este tormento?",

   		LAVAARENA_ARMORLIGHT = "Ojalá mi corazón pesara tan poco.",
		LAVAARENA_ARMORLIGHTSPEED = "Tendrán que atraparme para hacerme daño.",
		LAVAARENA_ARMORMEDIUM = "Protege mi cuerpo frágil.",
		LAVAARENA_ARMORMEDIUMDAMAGER = "Hasta nuestra armadura está rota.",
		LAVAARENA_ARMORMEDIUMRECHARGER = "Restaurará la energía de uno.",
		LAVAARENA_ARMORHEAVY = "Una protección pesada para el corazón.",
		LAVAARENA_ARMOREXTRAHEAVY = "Este mundo no es más que dolor.",

		LAVAARENA_FEATHERCROWNHAT = "¿Y qué hay de los pájaros?",
        LAVAARENA_HEALINGFLOWERHAT = "Alivia el dolor del cuerpo, pero no del corazón.",
        LAVAARENA_LIGHTDAMAGERHAT = "Trae más dolor al mundo.",
        LAVAARENA_STRONGDAMAGERHAT = "Golpea más fuerte, aún más fuerte...",
        LAVAARENA_TIARAFLOWERPETALSHAT = "Quien lo lleve será una fuerza de bien.",
        LAVAARENA_EYECIRCLETHAT = "Hay un poder cobarde en su interior.",
        LAVAARENA_RECHARGERHAT = "Podré atacar a menudo...",
        LAVAARENA_HEALINGGARLANDHAT = "¿Pero curará mi alma?",
        LAVAARENA_CROWNDAMAGERHAT = "Preveo una oleada de muerte.",

		LAVAARENA_ARMOR_HP = "Protege de los daños, pero no del pesar.",

		LAVAARENA_FIREBOMB = "Un bombardeo de dolor.",
		LAVAARENA_HEAVYBLADE = "Pesa mucho. Como mi alma.",

        --Quagmire
        QUAGMIRE_ALTAR =
        {
        	GENERIC = "El hambre del monstruo nunca cesará.",
        	FULL = "Hemos prolongado nuestra muerte horrible.",
    	},
		QUAGMIRE_ALTAR_STATUE1 = "¿Qué horrores han presenciado esos ojos?",
		QUAGMIRE_PARK_FOUNTAIN = "Lleva mucho tiempo seca.",

        QUAGMIRE_HOE = "Para labrar el suelo corrupto.",

        QUAGMIRE_TURNIP = "Es... un nabo.",
        QUAGMIRE_TURNIP_COOKED = "El nabo ahora está cocinado.",
        QUAGMIRE_TURNIP_SEEDS = "La vida que contienen es un misterio.",

        QUAGMIRE_GARLIC = "Da sabor a la comida.",
        QUAGMIRE_GARLIC_COOKED = "Huele un poco bien.",
        QUAGMIRE_GARLIC_SEEDS = "La vida que contienen es un misterio.",

        QUAGMIRE_ONION = "Yo nunca lloro.",
        QUAGMIRE_ONION_COOKED = "No volverá a hacer llorar a nadie.",
        QUAGMIRE_ONION_SEEDS = "La vida que contienen es un misterio.",

        QUAGMIRE_POTATO = "Tiene ojos, pero nunca llora.",
        QUAGMIRE_POTATO_COOKED = "Ahora ya no se le abrirán los ojos.",
        QUAGMIRE_POTATO_SEEDS = "La vida que contienen es un misterio.",

        QUAGMIRE_TOMATO = "Rojo como la sangre del corazón.",
        QUAGMIRE_TOMATO_COOKED = "Su carne es mucho más sangrienta ahora.",
        QUAGMIRE_TOMATO_SEEDS = "La vida que contienen es un misterio.",

        QUAGMIRE_FLOUR = "La harina con otro nombre no olería tan dulce.",
        QUAGMIRE_WHEAT = "Podemos molerlo para convertirlo en harina.",
        QUAGMIRE_WHEAT_SEEDS = "La vida que contienen es un misterio.",
        --NOTE: raw/cooked carrot uses regular carrot strings
        QUAGMIRE_CARROT_SEEDS = "La vida que contienen es un misterio.",

        QUAGMIRE_ROTTEN_CROP = "Le ha llegado su momento.",

		QUAGMIRE_SALMON = "Aletea mientras la vida abandona lentamente su cuerpo.",
		QUAGMIRE_SALMON_COOKED = "Ya no tiene tanta vida.",
		QUAGMIRE_CRABMEAT = "Su interior es tan horrible como su exterior.",
		QUAGMIRE_CRABMEAT_COOKED = "Está lista.",
		QUAGMIRE_SUGARWOODTREE =
		{
			GENERIC = "Tiene una belleza enfermiza.",
			STUMP = "Todas las cosas deben terminar.",
			TAPPED_EMPTY = "Como una daga a través del corazón. El corazón de un árbol.",
			TAPPED_READY = "Ahora puedo recogerla.",
			TAPPED_BUGS = "Tanto sacrificio para nada.",
			WOUNDED = "Su vida muere.",
		},
		QUAGMIRE_SPOTSPICE_SHRUB =
		{
			GENERIC = "Supongo que podría ser comestible.",
			PICKED = "Nos hemos llevado todo lo que había que llevarse.",
		},
		QUAGMIRE_SPOTSPICE_SPRIG = "Lo hemos arrancado de su hogar en el arbusto.",
		QUAGMIRE_SPOTSPICE_GROUND = "Tan solo un poco.",
		QUAGMIRE_SAPBUCKET = "Para recoger la sangre del árbol.",
		QUAGMIRE_SAP = "La sangre del árbol.",
		QUAGMIRE_SALT_RACK =
		{
			READY = "Ahora ya hay sal.",
			GENERIC = "Aún no hay sal.",
		},

		QUAGMIRE_POND_SALT = "Agua, agua por todas partes...",
		QUAGMIRE_SALT_RACK_ITEM = "Es para recoger la sal de la laguna.",

		QUAGMIRE_SAFE =
		{
			GENERIC = "Vamos a echar un vistazo...",
			LOCKED = "Cerrado, como mi corazón.",
		},

		QUAGMIRE_KEY = "Es la llave a algo precioso.",
		QUAGMIRE_KEY_PARK = "La llave a un lugar bonito, cerrado hace mucho tiempo.",
        QUAGMIRE_PORTAL_KEY = "Quizás sea más feliz en el otro mundo.",


		QUAGMIRE_MUSHROOMSTUMP =
		{
			GENERIC = "Crecen en un tocón hecho por la muerte.",
			PICKED = "Todas las cosas mueren. Incluso los hongos.",
		},
		QUAGMIRE_MUSHROOMS = "Tal vez tengamos suerte y sean venenosas.",
        QUAGMIRE_MEALINGSTONE = "Estoy molida en la piedra de la vida.",
		QUAGMIRE_PEBBLECRAB = "Si tuviera caparazón jamás saldría.",


		QUAGMIRE_RUBBLE_CARRIAGE = "Lo han olvidado.",
        QUAGMIRE_RUBBLE_CLOCK = "El tiempo es una ilusión.",
        QUAGMIRE_RUBBLE_CATHEDRAL = "No hay nada más por lo que rezar.",
        QUAGMIRE_RUBBLE_PUBDOOR = "Una puerta que no conduce a ninguna parte.",
        QUAGMIRE_RUBBLE_ROOF = "El techo no puede protegerte cuando llega la muerte.",
        QUAGMIRE_RUBBLE_CLOCKTOWER = "El tiempo es aliado de la muerte.",
        QUAGMIRE_RUBBLE_BIKE = "Nada ha escapado a esta peste.",
        QUAGMIRE_RUBBLE_HOUSE =
        {
            "La muerte ha estado aquí.",
            "Es una ciudad fantasma.",
            "Alguna tragedia ha golpeado esta casa.",
        },
        QUAGMIRE_RUBBLE_CHIMNEY = "Esto era una vez un hogar feliz.",
        QUAGMIRE_RUBBLE_CHIMNEY2 = "El hogar ya no tiene un hogar.",
        QUAGMIRE_MERMHOUSE = "El aislamiento no le ha hecho ningún bien.",
        QUAGMIRE_SWAMPIG_HOUSE = "No veo alegría en esta casa.",
        QUAGMIRE_SWAMPIG_HOUSE_RUBBLE = "Ni una casa ni un hogar.",
        QUAGMIRE_SWAMPIGELDER =
        {
            GENERIC = "¿Qué tal, señor?",
            SLEEPING = "Está practicando para el gran sueño.",
        },
        QUAGMIRE_SWAMPIG = "Son menos peces que sus hermanos.",

        QUAGMIRE_PORTAL = "Aquí no hay noche. Es un buen cambio.",
        QUAGMIRE_SALTROCK = "Hay que molerla antes de poder usarla.",
        QUAGMIRE_SALT = "Añade sabor...",
        --food--
        QUAGMIRE_FOOD_BURNT = "Un desperdicio.",
        QUAGMIRE_FOOD =
        {
        	GENERIC = "Deberíamos ofrecérsela a la bestia.",
            MISMATCH = "La bestia no quiere eso.",
            MATCH = "La bestia estará satisfecha con esto.",
            MATCH_BUT_SNACK = "Esto satisfará a la bestia, pero no por mucho tiempo.",
        },

        QUAGMIRE_FERN = "Wilson las llama \"verduras\"... pero son moradas...",
        QUAGMIRE_FOLIAGE_COOKED = "Verduras moradas cocinadas.",
        QUAGMIRE_COIN1 = "Me la pondré en los ojos cuando me muera.",
        QUAGMIRE_COIN2 = "El dinero no te traerá ninguna felicidad.",
        QUAGMIRE_COIN3 = "La riqueza no puede comprar la inmortalidad.",
        QUAGMIRE_COIN4 = "Ha venido de arriba.",
        QUAGMIRE_GOATMILK = "Pero no hay miel.",
        QUAGMIRE_SYRUP = "No es tan dulce como mi rey.",
        QUAGMIRE_SAP_SPOILED = "Tan agridulce como la vida.",
        QUAGMIRE_SEEDPACKET = "Plantar semillas requiere un optimismo que yo no tengo.",

        QUAGMIRE_POT = "Cocinamos para aplazar la muerte.",
        QUAGMIRE_POT_SMALL = "Cocinaremos o moriremos.",
        QUAGMIRE_POT_SYRUP = "La dulzura engendra dulzura.",
        QUAGMIRE_POT_HANGER = "El gancho es una soga para una olla.",
        QUAGMIRE_POT_HANGER_ITEM = "Es para colgar la olla sobre el fuego.",
        QUAGMIRE_GRILL = "No puede hacer que la vida sea más agradable.",
        QUAGMIRE_GRILL_ITEM = "No quiero llevar esto.",
        QUAGMIRE_GRILL_SMALL = "Hace un poco de comida.",
        QUAGMIRE_GRILL_SMALL_ITEM = "Solo funciona si lo coloco en algún lugar.",
        QUAGMIRE_OVEN = "Parece que está bien.",
        QUAGMIRE_OVEN_ITEM = "Ay... ¿Para qué molestarse?",
        QUAGMIRE_CASSEROLEDISH = "Para hacer comida.",
        QUAGMIRE_CASSEROLEDISH_SMALL = "Para hacer una cantidad pequeña de comida.",
        QUAGMIRE_PLATE_SILVER = "Ojalá la vida se me hubiera dado en un plato de plata.",
        QUAGMIRE_BOWL_SILVER = "Está vacío, como mi corazón.",
--fallback to speech_wilson.lua         QUAGMIRE_CRATE = "Kitchen stuff.",

        QUAGMIRE_MERM_CART1 = "Yo también transporto mi carga.", --sammy's wagon
        QUAGMIRE_MERM_CART2 = "Nada ahí me traerá felicidad.", --pipton's cart
        QUAGMIRE_PARK_ANGEL = "Tiene alas, pero no es un ángel.",
        QUAGMIRE_PARK_ANGEL2 = "Mi emperador necesita una estatua.",
        QUAGMIRE_PARK_URN = "Polvo al polvo.",
        QUAGMIRE_PARK_OBELISK = "Un monumento. Pero no al rey.",
        QUAGMIRE_PARK_GATE =
        {
            GENERIC = "Ahora puedo entrar en el parque.",
            LOCKED = "Necesito una llave para entrar.",
        },
        QUAGMIRE_PARKSPIKE = "Parece peligroso.",
        QUAGMIRE_CRABTRAP = "La vida es una trampa.",
        QUAGMIRE_TRADER_MERM = "¿Qué tal?",
        QUAGMIRE_TRADER_MERM2 = "¿Qué tal?",

        QUAGMIRE_GOATMUM = "Hola, señora. ¿Quiere comerciar?",
        QUAGMIRE_GOATKID = "¿Qué infancia es esta para ti?",
        QUAGMIRE_PIGEON =
        {
            DEAD = "Frío y muerto.",
            GENERIC = "¿Quieres ser un pastel, pajarito?",
            SLEEPING = "Está practicando para el sueño eterno.",
        },
        QUAGMIRE_LAMP_POST = "No ilumina nada importante.",

        QUAGMIRE_BEEFALO = "No te preocupes. Pronto estarás muerto.",
        QUAGMIRE_SLAUGHTERTOOL = "¿Acaso no es la vida un sacrificio?",

        QUAGMIRE_SAPLING = "Moriremos antes de que vuelva a crecer.",
        QUAGMIRE_BERRYBUSH = "Nunca volverá a dar otra baya.",

        QUAGMIRE_ALTAR_STATUE2 = "Otro recordatorio de la muerte.",
        QUAGMIRE_ALTAR_QUEEN = "No me impresiona la opulencia.",
        QUAGMIRE_ALTAR_BOLLARD = "Un poste. No muy emocionante.",
        QUAGMIRE_ALTAR_IVY = "Como la muerte, repta por todas partes.",

        QUAGMIRE_LAMP_SHORT = "La única luz en mi vida eres tú, mi emperador.",

        --v2 Winona
        WINONA_CATAPULT = 
        {
        	GENERIC = "Ha hecho una especie de sistema de defensa automático.",
        	OFF = "Necesita algo de electricidad.",
        	BURNING = "¡Está ardiendo!",
        	BURNT = "Ceniza.",
        },
        WINONA_SPOTLIGHT = 
        {
        	GENERIC = "¡Qué idea tan ingeniosa!",
        	OFF = "Necesita algo de electricidad.",
        	BURNING = "¡Está ardiendo!",
        	BURNT = "Ceniza.",
        },
        WINONA_BATTERY_LOW = 
        {
        	GENERIC = "¿Cómo funciona?",
        	LOWPOWER = "Se está quedando sin batería.",
        	OFF = "Podría hacerlo funcionar, si Winona está ocupada.",
        	BURNING = "¡Está ardiendo!",
        	BURNT = "Ceniza.",
        },
        WINONA_BATTERY_HIGH = 
        {
        	GENERIC = "Bueno, ahora estamos hablando.",
        	LOWPOWER = "Se apagará pronto.",
        	OFF = "No está funcionando.",
        	BURNING = "¡Está ardiendo!",
        	BURNT = "Ceniza.",
        },

        --Wormwood
        COMPOSTWRAP = "Wormwood me ha ofrecido probar, pero he declinado amablemente.",
        ARMOR_BRAMBLE = "El mejor ataque es una buena defensa.",
        TRAP_BRAMBLE = "Pincha a cualquiera que ponga el pie encima.",

        BOATFRAGMENT03 = "No queda gran cosa.",
        BOATFRAGMENT04 = "No queda gran cosa.",
        BOATFRAGMENT05 = "No queda gran cosa.",
		BOAT_LEAK = "Debería parchearlo antes de que nos hundamos.",
        MAST = "¡No más! ¡Un mástil!",
        SEASTACK = "Es una roca.",
        FISHINGNET = "Nada más que una red.",
        ANTCHOVIES = "Jope. ¿Puedo volverlo a lanzar?",
        STEERINGWHEEL = "Podría haber surcado los mares en otra vida.",
        ANCHOR = "No querría que mi barco se fuese por ahí solo.",
        BOATPATCH = "Por si ocurre un desastre.",
        DRIFTWOOD_TREE = 
        {
            BURNING = "¡Esa madera a la deriva está ardiendo!",
            BURNT = "Ya no parece demasiado útil.",
            CHOPPED = "A lo mejor aún queda algo que merezca la pena sacar.",
            GENERIC = "Un árbol muerto arrastrado a la orilla.",
        },

        DRIFTWOOD_LOG = "Flota en el agua.",

        MOON_TREE = 
        {
            BURNING = "¡El árbol está ardiendo!",
            BURNT = "El árbol se ha quemado.",
            CHOPPED = "Era un árbol bastante grueso.",
            GENERIC = "No sabía que en la luna pudieran crecer árboles.",
        },
		MOON_TREE_BLOSSOM = "Se ha caído del árbol lunar.",

        MOONBUTTERFLY = 
        {
        	GENERIC = "Es una mariposa lunar.",
        	HELD = "Ya te tengo.",
        },
		MOONBUTTERFLYWINGS = "Estas cosas me dan alas.",
        MOONBUTTERFLY_SAPLING = "¿Una polilla convertida en árbol? ¡De locos!",
        ROCK_AVOCADO_FRUIT = "Me partiría los dientes con eso.",
        ROCK_AVOCADO_FRUIT_RIPE = "La fruta de piedra sin cocinar no mola.",
        ROCK_AVOCADO_FRUIT_RIPE_COOKED = "Ahora ya se puede morder.",
        ROCK_AVOCADO_FRUIT_SPROUT = "Está creciendo.",
        ROCK_AVOCADO_BUSH = 
        {
        	BARREN = "Sus días de dar fruto se acabaron.",
			WITHERED = "Hace mucho calor.",
			GENERIC = "Es un arbusto... ¡de la luna!",
			PICKED = "Tardará un tiempo en dar más frutos.",
			DISEASED = "Parece bastante enfermo.",
            DISEASING = "Eh, algo va mal aquí.",
			BURNING = "¡Está ardiendo!",
		},
        DEAD_SEA_BONES = "Eso les pasa por venir a tierra firme.",
        HOTSPRING = 
        {
        	GENERIC = "Si pudiera remojar mis cansados huesos.",
        	BOMBED = "No es más que una reacción química sencilla.",
        	GLASS = "El agua se vuelve cristal bajo la luna.",
			EMPTY = "Tendré que volver a esperar a que se llene.",
        },
        MOONGLASS = "Está muy afilada.",
        MOONGLASS_CHARGED = "¡Tendría que darle uso antes de que se agote la energía!",
        MOONGLASS_ROCK = "Prácticamente veo mi reflejo en ella.",
        BATHBOMB = "Es química de libro de texto.",
        TRAP_STARFISH =
        {
            GENERIC = "¡Oh, qué estrella de mar tan preciosa!",
            CLOSED = "¡Ha intentado zamparme!",
        },
        DUG_TRAP_STARFISH = "Ya no engaña a nadie.",
        SPIDER_MOON = 
        {
        	GENERIC = "Oh, bien. La luna la ha mutado.",
        	SLEEPING = "Ha dejado de moverse.",
        	DEAD = "¿De verdad ha muerto?",
        },
        MOONSPIDERDEN = "No es el típico cubil de arañas.",
		FRUITDRAGON =
		{
			GENERIC = "Es bonito, pero aún está maduro.",
			RIPE = "Creo que ya ha madurado.",
			SLEEPING = "Está dormitando.",
		},
        PUFFIN =
        {
            GENERIC = "¡Nunca había visto un monaguillo vivo!",
            HELD = "Cazar un monaguillo seguro que es pecado.",
            SLEEPING = "Los monaguillos sueñan con los angelitos.",
        },

		MOONGLASSAXE = "La he hecho ultraefectiva.",
		GLASSCUTTER = "Lo de luchar no está hecho para mí.",

        ICEBERG =
        {
            GENERIC = "Mejor no acercarse a eso.",
            MELTED = "Se ha derretido por completo.",
        },
        ICEBERG_MELTED = "Se ha derretido por completo.",

        MINIFLARE = "Puedo encender para que todos sepan que estoy aquí.",
        MEGAFLARE = "Hará saber a todo que estoy aquí. Todo.",

		MOON_FISSURE = 
		{
			GENERIC = "Me palpita el cerebro de paz y terror.", 
			NOLIGHT = "Ya empiezan a mostrarse las grietas de este lugar.",
		},
        MOON_ALTAR =
        {
            MOON_ALTAR_WIP = "Quiere que lo acaben.",
            GENERIC = "¿Mm? ¿Qué dices?",
        },

        MOON_ALTAR_IDOL = "Me siento en la obligación de llevarlo a otro lado.",
        MOON_ALTAR_GLASS = "No quiere estar en el suelo.",
        MOON_ALTAR_SEED = "Quiere que le dé un hogar.",

        MOON_ALTAR_ROCK_IDOL = "Hay algo atrapado dentro.",
        MOON_ALTAR_ROCK_GLASS = "Hay algo atrapado dentro.",
        MOON_ALTAR_ROCK_SEED = "Hay algo atrapado dentro.",

        MOON_ALTAR_CROWN = "¡Después de pescar esto, a buscar una grieta!",
        MOON_ALTAR_COSMIC = "Es como si estuviera esperando algo.",

        MOON_ALTAR_ASTRAL = "Parece una parte de un mecanismo mayor.",
        MOON_ALTAR_ICON = "Creo que sé dónde vas.",
        MOON_ALTAR_WARD = "Quiere estar con el resto.",

        SEAFARING_PROTOTYPER =
        {
            GENERIC = "Espero que no dé malas ideas.",
            BURNT = "Ha hecho aguas.",
        },
        BOAT_ITEM = "Estaría bien nadar en el agua.",
        BOAT_GRASS_ITEM = "Técnicamente es un barco.",
        STEERINGWHEEL_ITEM = "Esto será el volante.",
        ANCHOR_ITEM = "Ahora puedo construir un ancla.",
        MAST_ITEM = "Ahora puedo construir un mástil.",
        MUTATEDHOUND = 
        {
        	DEAD = "Ahora puedo respirar sin agobios.",
        	GENERIC = "¡Sálvanos emperador!",
        	SLEEPING = "El cuerpo me pide correr.",
        },

        MUTATED_PENGUIN = 
        {
			DEAD = "Es su fin.",
			GENERIC = "¡Esa cosa es aterradora!",
			SLEEPING = "Gracias al cielo. Está durmiendo.",
		},
        CARRAT = 
        {
        	DEAD = "Es su fin.",
        	GENERIC = "¿Se supone que las zanahorias tienen patas?",
        	HELD = "Eres un horror de cerca.",
        	SLEEPING = "Es casi adorable.",
        },

		BULLKELP_PLANT = 
        {
            GENERIC = "Aggh. Algas.",
            PICKED = "Algo haré con las algas.",
        },
		BULLKELP_ROOT = "Puedo plantar esto en alta mar.",
        KELPHAT = "No puedo usar esto.",
		KELP = "Me deja los bolsillos empapados y perdidos.",
		KELP_COOKED = "Es más líquido que sólido.",
		KELP_DRIED = "El contenido en sodio es un pelín alto.",

		GESTALT = "No quiero saber.",
        GESTALT_GUARD = "Creo que me van a dar... un buen guantazo si me acerco demasiado.",

		COOKIECUTTER = "No me gusta cómo mira mi barco...",
		COOKIECUTTERSHELL = "Una carcasa de su antiguo ser.",
		COOKIECUTTERHAT = "No puedo usar esto.",
		SALTSTACK =
		{
			GENERIC = "¿Son formaciones naturales?",
			MINED_OUT = "Está minado... ¡Está todo minado!",
			GROWING = "Supongo que crece así, sin más.",
		},
		SALTROCK = "Siento unas ganas.",
		SALTBOX = "¡Para que la comida no se eche a perder!",

		TACKLESTATION = "Hora de echar el anzuelo a mis problemas.",
		TACKLESKETCH = "Una imagen de unos aparejos de pesca. Seguro que podría hacerlo...",

        MALBATROSS = "¡Una bestia abyecta, sin duda!",
        MALBATROSS_FEATHER = "Arrancada de un emplumado amigo.",
        MALBATROSS_BEAK = "¡Huele mal!.",
        MAST_MALBATROSS_ITEM = "Es más ligero de lo que parece.",
        MAST_MALBATROSS = "¡Extiende mis alas y zarpa!",
		MALBATROSS_FEATHERED_WEAVE = "¡Voy a hacer una colcha de altos vuelos!",

        GNARWAIL =
        {
            GENERIC = "¡Vaya, menudo cuerno que tienes!.",
            BROKENHORN = "¡Te pillé la nariz!",
            FOLLOWER = "Esto es todo ballena y está bien.",
            BROKENHORN_FOLLOWER = "¡Eso te pasa por meter las narices!",
        },
        GNARWAIL_HORN = "¡Mola!",

        WALKINGPLANK = "¿No podríamos haber hecho un bote salvavidas?",
        WALKINGPLANK_GRASS = "¿No podríamos haber hecho un bote salvavidas?",
        OAR = "Aceleración manual de navíos.",
		OAR_DRIFTWOOD = "Aceleración manual de navíos.",

		OCEANFISHINGROD = "¡Este carrete sí que da buen rollo!",
		OCEANFISHINGBOBBER_NONE = "Un corcho de pesca mejoraría su precisión.",
        OCEANFISHINGBOBBER_BALL = "El pez dirá \"recorcho\" cuando lo vea.",
        OCEANFISHINGBOBBER_OVAL = "¡Esos peces no me la darán más con queso!",
		OCEANFISHINGBOBBER_CROW = "Prefiero comer pescado a cuervo.",
		OCEANFISHINGBOBBER_ROBIN = "Espero que no atraiga más distracciones.",
		OCEANFISHINGBOBBER_ROBIN_WINTER = "La pluma de pinzón me ayuda a estar alerta.",
		OCEANFISHINGBOBBER_CANARY = "¡Saludad a mi coleguilla amarillo!",
		OCEANFISHINGBOBBER_GOOSE = "¡Vete despidiendo, pez!",
		OCEANFISHINGBOBBER_MALBATROSS = "Donde hay plumas, hay esperanza.",

		OCEANFISHINGLURE_SPINNER_RED = "¡Espero que los peces no se \"ceben\" conmigo!",
		OCEANFISHINGLURE_SPINNER_GREEN = "¡Espero que los peces no se \"ceben\" conmigo!",
		OCEANFISHINGLURE_SPINNER_BLUE = "¡Espero que los peces no se \"ceben\" conmigo!",
		OCEANFISHINGLURE_SPOON_RED = "¡Espero que los pececillos no se \"ceben\" conmigo!",
		OCEANFISHINGLURE_SPOON_GREEN = "¡Espero que los pececillos no se \"ceben\" conmigo!",
		OCEANFISHINGLURE_SPOON_BLUE = "¡Espero que los pececillos no se \"ceben\" conmigo!",
		OCEANFISHINGLURE_HERMIT_RAIN = "Empaparme podría ayudarme a pensar como un pez.",
		OCEANFISHINGLURE_HERMIT_SNOW = "¡El pez no tendrá \"ni-evidea\" de lo que ha pasado!",
		OCEANFISHINGLURE_HERMIT_DROWSY = "Tengo el cerebro protegido.",
		OCEANFISHINGLURE_HERMIT_HEAVY = "Esto me parece una pesadez.",

		OCEANFISH_SMALL_1 = "Parece el mocoso de su escuela.",
		OCEANFISH_SMALL_2 = "No me ganaré el derecho a fardar con esta minucia.",
		OCEANFISH_SMALL_3 = "Es un pelín pequeño.",
		OCEANFISH_SMALL_4 = "Un pez de este tamaño no me sacará del apuro mucho tiempo.",
		OCEANFISH_SMALL_5 = "Estoy deseando explotarlo en mi boca.",
		OCEANFISH_SMALL_6 = "¿Vegetal o animal? Difícil de descifrar.",
		OCEANFISH_SMALL_7 = "¡Por fin he atrapado este pez en flor!",
		OCEANFISH_SMALL_8 = "¡Qué brasa!",
        OCEANFISH_SMALL_9 = "Es solo una escupidea, pero podrías serme útil...",

		OCEANFISH_MEDIUM_1 = "Espero que sepa mejor de lo que parece.",
		OCEANFISH_MEDIUM_2 = "Este pescado ha sido muy pesado.",
		OCEANFISH_MEDIUM_3 = "¡Tengo una habilidad felina para la pesca!",
		OCEANFISH_MEDIUM_4 = "Seguro que esto no me dará mala suerte.",
		OCEANFISH_MEDIUM_5 = "¿Pez o mazorca?",
		OCEANFISH_MEDIUM_6 = "¡Okey MacKoi!",
		OCEANFISH_MEDIUM_7 = "¡Okey MacKoi!",
		OCEANFISH_MEDIUM_8 = "Besugo remojado, besugo helado.",
        OCEANFISH_MEDIUM_9 = "Ay, el dulce olor de una pesca fructífera.",

		PONDFISH = "Ahora debo comer por un día.",
		PONDEEL = "Esto será una deliciosa comida.",

        FISHMEAT = "Un trozo de carne de pescado.",
        FISHMEAT_COOKED = "Perfectamente asado.",
        FISHMEAT_SMALL = "¡Un pequeño trozo de pescado!.",
        FISHMEAT_SMALL_COOKED = "Un poco de pescado asado.",
		SPOILED_FISH = "No tengo mucha curiosidad por ver cómo huele.",

		FISH_BOX = "¡Están embutidos como sardinas!",
        POCKET_SCALE = "Un dispositivo pesador a escala mini.",

		TACKLECONTAINER = "¡El espacio de almacenamiento adicional me ha enganchado!",
		SUPERTACKLECONTAINER = "Me ha costado lo mío conseguir esto.",

		TROPHYSCALE_FISH =
		{
			GENERIC = "Me pregunto cuánto medirá mi captura del día.",
			HAS_ITEM = "Peso: {weight}\nCapturado por: {owner}",
			HAS_ITEM_HEAVY = "Peso: {weight}\nCapturado por: {owner}\n¡Buena pesca!",
			BURNING = "En una escala del 1 al 5... ¡está ardiendo que no veas!",
			BURNT = "¡Mis derechos de fardar, ardiendo en llamas!",
			OWNER = "No quiero ponerme en plan pesado, peeeero...\nPeso: {weight}\nCapturado por: {owner}",
			OWNER_HEAVY = "Peso: {weight}\nCapturado por: {owner}\n¡Ese fue el que NO se escapó!",
		},

		OCEANFISHABLEFLOTSAM = "No es más que un césped enfangado.",

		CALIFORNIAROLL = "Pero no tengo palillos.",
		SEAFOODGUMBO = "Gumbo jumbo de marisco.",
		SURFNTURF = "¡Perfecto!",

        WOBSTER_SHELLER = "Qué langüosta más güanuja.",
        WOBSTER_DEN = "Una roca con langüostas.",
        WOBSTER_SHELLER_DEAD = "Cocinado debes de estar muy bien.",
        WOBSTER_SHELLER_DEAD_COOKED = "Qué ganas tengo de comerte.",

        LOBSTERBISQUE = "Le hace falta más sal, pero un marisco siempre es un marisco.",
        LOBSTERDINNER = "¿Si me lo como por la mañana todavía sigue siendo cena?",

        WOBSTER_MOONGLASS = "Qué langüosta lunar más güanuja.",
        MOONGLASS_WOBSTER_DEN = "Es un trozo de cristal lunar con langüostas lunares.",

		TRIDENT = "¡Esto va a ser la bomba!",

		WINCH =
		{
			GENERIC = "Valdrá en caso de apuro.",
			RETRIEVING_ITEM = "Dejaré que se ocupe de levantar lo pesado.",
			HOLDING_ITEM = "¿Qué tenemos aquí?",
		},

        HERMITHOUSE = {
            GENERIC = "No es más que la carcasa vacía de un hogar.",
            BUILTUP = "Solo necesitaba un poco de amor.",
        },

        SHELL_CLUSTER = "Apuesto a que hay conchas chulas dentro.",
        --
		SINGINGSHELL_OCTAVE3 =
		{
			GENERIC = "Está un pelín desafinada.",
		},
		SINGINGSHELL_OCTAVE4 =
		{
			GENERIC = "¿Así es como suena el océano?",
		},
		SINGINGSHELL_OCTAVE5 =
		{
			GENERIC = "Está lista para dar la nota.",
        },

        CHUM = "¡Es una comida de peces!",

        SUNKENCHEST =
        {
            GENERIC = "El verdadero tesoro es el tesoro hallado en el camino.",
            LOCKED = "¡No hay quien abra!",
        },

        HERMIT_BUNDLE = "¿Cuántas conchas tendrá la cangreja ermitaña?.",
        HERMIT_BUNDLE_SHELLS = "¡Tiene tantas que las vende!",

        RESKIN_TOOL = "¡Me gusta el polvo! ¡Le da un aire intelectual!",
        MOON_FISSURE_PLUGGED = "Bastante efectivo.",


		----------------------- ROT STRINGS GO ABOVE HERE ------------------

		-- Walter
        WOBYBIG =
        {
            "¿La has estado alimentando bien últimamente?",
            "¿La has estado alimentando bien últimamente?",
        },
        WOBYSMALL =
        {
            "Acariciar a un buen perro mejora tu día.",
            "Acariciar a un buen perro mejora tu día.",
        },
		WALTERHAT = "No puedo usar esto.",
		SLINGSHOT = "La pesadilla de las ventanas de todo el mundo.",
		SLINGSHOTAMMO_ROCK = "Chinas para lanzar.",
		SLINGSHOTAMMO_MARBLE = "Chinas para lanzar.",
		SLINGSHOTAMMO_THULECITE = "Chinas para lanzar.",
        SLINGSHOTAMMO_GOLD = "Chinas para lanzar.",
        SLINGSHOTAMMO_SLOW = "Chinas para lanzar.",
        SLINGSHOTAMMO_FREEZE = "Chinas para lanzar.",
		SLINGSHOTAMMO_POOP = "Proyectiles de caca.",
        PORTABLETENT = "¡Me siento como si no hubiera dormido bien desde hace siglos!",
        PORTABLETENT_ITEM = "Esto exige cierta a-tiend-ción.",

        -- Wigfrid
        BATTLESONG_DURABILITY = "El teatro me pone de los nervios.",
        BATTLESONG_HEALTHGAIN = "El teatro me pone de los nervios.",
        BATTLESONG_SANITYGAIN = "El teatro me pone de los nervios.",
        BATTLESONG_SANITYAURA = "El teatro me pone de los nervios.",
        BATTLESONG_FIRERESISTANCE = "Una vez, me quemé el chaleco antes de ir a ver una obra. Hubo más drama con la plancha que en la obra.",--amogus123
        BATTLESONG_INSTANT_TAUNT = "Me temo que no tengo dotes poéticos...",
        BATTLESONG_INSTANT_PANIC = "Me temo que no tengo dotes poéticos...",

        -- Webber
        MUTATOR_WARRIOR = "Anda, qué... buena pinta tiene, Webber.",
        MUTATOR_DROPPER = "Ay, es que... acabo de comer. ¿Y si se lo das a tus amigas las arañas?",
        MUTATOR_HIDER = "Anda, qué... buena pinta tiene, Webber.",
        MUTATOR_SPITTER = "Ay, es que... acabo de comer. ¿Y si se lo das a tus amigas las arañas?",
        MUTATOR_MOON = "Anda, qué... buena pinta tiene, Webber.",
        MUTATOR_HEALER = "Ay, es que... acabo de comer. ¿Y si se lo das a tus amigas las arañas?",
        SPIDER_WHISTLE = "Anda, qué... buena pinta tiene, Webber.",
        SPIDERDEN_BEDAZZLER = "A alguien le ha dado por hacer manualidades.",
        SPIDER_HEALER = "Qué maravilla. ¡Ahora las arañas pueden curarse!",
        SPIDER_REPELLENT = "...",
        SPIDER_HEALER_ITEM = "Si veo alguna araña por aquí, se lo daré. O a lo mejor me lo pienso...",

		-- Wendy
		GHOSTLYELIXIR_SLOWREGEN = "¡Pociones! Mi tipo favorito de magia.",
		GHOSTLYELIXIR_FASTREGEN = "¡Pociones! Mi tipo favorito de magia.",
		GHOSTLYELIXIR_SHIELD = "¡Pociones! Mi tipo favorito de magia.",
		GHOSTLYELIXIR_ATTACK = "¡Pociones! Mi tipo favorito de magia.",
		GHOSTLYELIXIR_SPEED = "¡Pociones! Mi tipo favorito de magia.",
		GHOSTLYELIXIR_RETALIATION = "¡Pociones! Mi tipo favorito de magia.",
		SISTURN =
		{
			GENERIC = "Unas flores alegrarían esto un poco.",
			SOME_FLOWERS = "Unas cuantas flores más y listo.",
			LOTS_OF_FLOWERS = "¡Flores escalofriantemente bonitas!",
		},

        --Wortox
        WORTOX_SOUL = "only_used_by_wortox", --only wortox can inspect souls

        PORTABLECOOKPOT_ITEM =
        {
            GENERIC = "¡Esto sí que es cocinar!",
            DONE = "¡Ya hemos terminado de cocinar!",

            COOKING_LONG = "Necesita un montón de tiempo.",
			COOKING_SHORT = "Ahora en cualquier momento.",
			EMPTY = "Apuesto a que no hay nada dentro.",
        },
        
        PORTABLEBLENDER_ITEM = "Mezcla toda la comida.",
        PORTABLESPICER_ITEM =
        {
            GENERIC = "Esto aderezará la cosa.",
            DONE = "Le dará un poco más de sabor a todo.",
        },
        SPICEPACK = "¡Una revelación en artes culinarias!",
        SPICE_GARLIC = "Un polvo poderosamente potente.",
        SPICE_SUGAR = "¡Dulce! ¡Es dulce!",
        SPICE_CHILI = "Una jarra de fluido incandescente.",
        SPICE_SALT = "Un poco de sodio es bueno para el corazón.",
        MONSTERTARTARE = "Tiene que haber algo más para comer por aquí.",
        FRESHFRUITCREPES = "¡Una planta con azúcar! Parte de un desayuno equilibrado.",
        FROGFISHBOWL = "¿Son... ranas metidas en un pez?",
        POTATOTORNADO = "¡Patata dotada con el poder de un tornado!",
        DRAGONCHILISALAD = "Espero poder lidiar con el nivel de especias.",
        GLOWBERRYMOUSSE = "Warly cocina que da gusto.",
        VOLTGOATJELLY = "Es sorprendentemente delicioso.",
        NIGHTMAREPIE = "Da un poco de yuyu.",
        BONESOUP = "Hasta los huesos alimentan, si Warly los cocina.",
        MASHEDPOTATOES = "Dicen que la cocina es básicamente química. Podría probar.",
        POTATOSOUFFLE = "Se me había olvidado cómo sabe la buena comida.",
        MOQUECA = "Tiene tanto talento cocinando como yo siendo una persona muerta.",
        GAZPACHO = "Escuché que sabe... creo que ¿bien...?",
        ASPARAGUSSOUP = "Huele tal y como sabe.",
        VEGSTINGER = "¿Se puede usar el apio de pajita?",
        BANANAPOP = "¡No, no se me puede congelar el cerebro!",
        CEVICHE = "¿Hay un cuenco más grande? Este parece un poco pequeño.",
        SALSA = "¡Está... que arde!",
        PEPPERPOPPER = "¡Qué delicia!",

        TURNIP = "Es un nabo crudo.",
        TURNIP_COOKED = "Cocinando en práctica.",
        TURNIP_SEEDS = "Un puñado de semillas inidentificables.",
        
        GARLIC = "El potenciador del aliento número uno.",
        GARLIC_COOKED = "Perfectamente tostado.",
        GARLIC_SEEDS = "Un puñado de semillas inidentificables.",
        
        ONION = "Parece crujiente.",
        ONION_COOKED = "Una reacción química exitosa.",
        ONION_SEEDS = "Un puñado de semillas inidentificables.",
        
        POTATO = "Las manzanas de la tierra.",
        POTATO_COOKED = "Manzanas horneadas de la tierra.",
        POTATO_SEEDS = "Un puñado de semillas inidentificables.",
        
        TOMATO = "Es rojo porque está lleno de sangre.",
        TOMATO_COOKED = "Cocinar es fácil si entiendes la química.",
        TOMATO_SEEDS = "Un puñado de semillas inidentificables.",

        ASPARAGUS = "Una verdura.", 
        ASPARAGUS_COOKED = "Es bueno para nosotros.",
        ASPARAGUS_SEEDS = "Son semillas de espárragos.",

        PEPPER = "Rico y picante.",
        PEPPER_COOKED = "Y ya te subía antes la temperatura que no veas.",
        PEPPER_SEEDS = "Un puñado de semillas inidentificables.",

        WEREITEM_BEAVER = "Que.",
        WEREITEM_GOOSE = "¡Me está poniendo A MÍ los pelos de punta!",
        WEREITEM_MOOSE = "Una especie de alce maldito perfectamente normal.",

        MERMHAT = "No puedo usar esto.",
        MERMTHRONE =
        {
            GENERIC = "¡Perfecto para un rey del pantano!",
            BURNT = "Algo olía a podrido en ese trono de todos modos.",
        },        
        MERMTHRONE_CONSTRUCTION =
        {
            GENERIC = "¿Qué anda planeando?",
            BURNT = "Supongo que ya nunca sabremos para qué era.",
        },        
        MERMHOUSE_CRAFTED = 
        {
            GENERIC = "La verdad es que tiene su encanto.",
            BURNT = "¡Agh! Vaya olor.",
        },

        MERMWATCHTOWER_REGULAR = "Parecen felices de haber encontrado un rey.",
        MERMWATCHTOWER_NOKING = "Un guardia real sin nada real que guardar.",
        MERMKING = "¡Majestad!",
        MERMGUARD = "Me siento a tope de seguridad con estos tipos...",
        MERM_PRINCE = "Siguen la máxima de quien antes llegue, antes reina.",

        SQUID = "No quedarme esto sería echar un borrón.",

		GHOSTFLOWER = "Sí, sí, oh, vaya.",
        SMALLGHOST = "Oooh, ¿quién es la cosita fantasmal más espeluznante?",

        CRABKING =
        {
            GENERIC = "¡Puf! No me van los crustáceos.",
            INERT = "Ese castillo necesita un poco de decoración.",
        },
		CRABKING_CLAW = "¡Esas pinzas son alarmantes!",

		MESSAGEBOTTLE = "Me pregunto si será para mí...",
		MESSAGEBOTTLEEMPTY = "Está llena de nada.",

        MEATRACK_HERMIT =
        {
            DONE = "¡Hora de cecina!",
            DRYING = "La carne tarda un tiempo en secarse.",
            DRYINGINRAIN = "La carne tarda aún más en secarse en la lluvia.",
            GENERIC = "Seguro que le vendría bien algo de carne.",
            BURNT = "El costillar se ha secado.",
            DONE_NOTMEAT = "En términos de laboratorio, esto está lo que diríamos \"seco\".",
            DRYING_NOTMEAT = "Cosas secándose.",
            DRYINGINRAIN_NOTMEAT = "Lluvia, lluvia, vete de aquí. Que llueva mejor otro día al fin.",
        },
        BEEBOX_HERMIT =
        {
            READY = "Está lleno de miel.",
            FULLHONEY = "Está lleno de miel.",
            GENERIC = "No tengo muy claro que vaya a contener mucha dulzura.",
            NOHONEY = "Está vacío.",
            SOMEHONEY = "Hay que esperar un poco.",
            BURNT = "¡¡¿Cómo se habrá quemado?!!",
        },

        HERMITCRAB = "Vivir en tu caparazón debe de ser moluscolitario.",

        HERMIT_PEARL = "La cuidaré bien.",
        HERMIT_CRACKED_PEARL = "No... la he cuidado bien.",

        -- DSEAS
        WATERPLANT = "Mientras no les quitemos los percebes, serán amigables.",
        WATERPLANT_BOMB = "¡Estamos bajo asedio!",
        WATERPLANT_BABY = "Esta es solo un retoño.",
        WATERPLANT_PLANTER = "Parecen crecer mejor en rocas oceánicas.",

        SHARK = "Quizá necesitemos un barco más grande...",

        MASTUPGRADE_LAMP_ITEM = "Estoy rebosante de ideas brillantes.",
        MASTUPGRADE_LIGHTNINGROD_ITEM = "¡He aprovechado el poder de la electricidad sobre la tierra y el mar!",

        WATERPUMP = "Apaga fuegos de forma muy eficiente.",

        BARNACLE = "A mí no me parecen unos nudillos.",
        BARNACLE_COOKED = "Dicen que es una exquisitez.",

        BARNACLEPITA = "Los percebes saben mejor cuando no puedes verlos.",
        BARNACLESUSHI = "Parece que sigo sin encontrar mis palillos.",
        BARNACLINGUINE = "¡A mí la pasta!",
        BARNACLESTUFFEDFISHHEAD = "Tengo el hambre suficiente como para considerarlo...",

        LEAFLOAF = "Misteriosa carne de hoja.",
        LEAFYMEATBURGER = "Vegetariana, pero no libre de crueldad.",
        LEAFYMEATSOUFFLE = "Curioso.",
        MEATYSALAD = "Extraño relleno para una ensalada.",

        -- GROTTO

		MOLEBAT = "Un napiaferatu normal y corriente.",
        MOLEBATHILL = "¿Qué se habrá quedado atascado en el nido de la rata?",

        BATNOSE = "¿Por qué iba a comer eso?",
        BATNOSE_COOKED = "Todavía es asqueroso.",
        BATNOSEHAT = "De ninguna manera me estoy poniendo esto.",

        MUSHGNOME = "Es agresivo, pero no espora siempre.",

        SPORE_MOON = "Me alejaré todo lo que pueda de esas esporas. Espora mi propio bien.",

        MOON_CAP = "Flor de la muerte del anhelo.",
        MOON_CAP_COOKED = "¿Okey?",

        MUSHTREE_MOON = "Este árbol de hongos es más raro que el resto.",

        LIGHTFLIER = "¡Qué cosa tan rara!",

        GROTTO_POOL_BIG = "El agua lunar hace que crezca el vidrio.",
        GROTTO_POOL_SMALL = "El agua lunar hace que crezca el vidrio.",

        DUSTMOTH = "Qué pulcras que son, ¿eh?",

        DUSTMOTHDEN = "Están como bicho por su casa.",

        ARCHIVE_LOCKBOX = "Dame una pieza ahora.",
        ARCHIVE_CENTIPEDE = "Me falta la cara, por supuesto.",
        ARCHIVE_CENTIPEDE_HUSK = "Ok.",

        ARCHIVE_COOKPOT =
        {
            COOKING_LONG = "Necesita un montón de tiempo.",
			COOKING_SHORT = "En cualquier momento.",
			DONE = "Hecho.",
			EMPTY = "Pon cosas, saca cosas.",
			BURNT = "Alguien perdió el control de la cocina.",
        },

        ARCHIVE_MOON_STATUE = "Espero que a todos les guste, es mi artesanía.",
        ARCHIVE_RUNE_STATUE =
        {
            LINE_1 = "¡Estas son mis notas!",
            LINE_2 = "Este es sobre el escape planeado a la luna.",
            LINE_3 = "¡Este es sobre el uso de energía!",
            LINE_4 = "Oh no.",
            LINE_5 = "...",
        },

        ARCHIVE_RESONATOR = {
            GENERIC = "¿Por qué usar un mapa cuando podrías usar una maquinaria alucinantemente compleja?",
            IDLE = "Parece que ha encontrado todo lo que merece la pena.",
        },

        ARCHIVE_RESONATOR_ITEM = "Encuéntralo.",

        ARCHIVE_LOCKBOX_DISPENCER = {
          POWEROFF = "La energía está apagada.",
          GENERIC =  "Dame una pieza ahora.",
        },

        ARCHIVE_SECURITY_DESK = {
            POWEROFF = "La energía está apagada.",
            GENERIC = "Funcionando según lo previsto.",
        },

        ARCHIVE_SECURITY_PULSE = "¿Qué tal?",

        ARCHIVE_SWITCH = {
            VALID = "La gema es correcta.",
            GEMS = "No hay nada en el hueco.",
        },

        ARCHIVE_PORTAL = {
            POWEROFF = "Energía primero.",
            GENERIC = "¿Dónde están las otras partes?",
        },

        WALL_STONE_2 = "Qué pared tan bonita.",
        WALL_RUINS_2 = "Una pared.",

        REFINED_DUST = "Casi como hacer masa. Pero casi.",
        DUSTMERINGUE = "Me encantaría comerlo, ¡pero se ve tan bien como está!",

        SHROOMCAKE = "Hace honor a su nombre.",

        NIGHTMAREGROWTH = "Esos cristales podrían ser motivo de preocupación.",

        TURFCRAFTINGSTATION = "¡Para hacer las cosas buenas!",

        MOON_ALTAR_LINK = "Supongo que se está preparando para algo.",

        -- FARMING
        COMPOSTINGBIN =
        {
            GENERIC = "Cómo puede oler tan mal un solo barril...",
            WET = "Está demasiado húmedo.",
            DRY = "Um... Está muy seco.",
            BALANCED = "¡Perfecto!",
            BURNT = "Creía que no podía oler peor...",
        },
        COMPOST = "Comida para las plantas y poco más.",
        SOIL_AMENDER =
		{
			GENERIC = "Ahora a esperar.",
			STALE = "Espera más tiempo.",
			SPOILED = "¡Esta peste insoportable quiere decir que funciona!",
		},

		SOIL_AMENDER_FERMENTED = "¡Qué fertilizante tan potente!",

        WATERINGCAN =
        {
            GENERIC = "Puedo regar las plantas con esto.",
            EMPTY = "A lo mejor hay un estanque por aquí cerca...",
        },
        PREMIUMWATERINGCAN =
        {
            GENERIC = "¡Asqueroso!",
            EMPTY = "No me servirá de mucho si no tiene agua.",
        },

		FARM_PLOW = "Qué herramienta tan útil.",
		FARM_PLOW_ITEM = "Planifica tus granjas cuidadosamente.",
		FARM_HOE = "Yo también.",
		GOLDEN_FARM_HOE = "Yo también.",
		NUTRIENTSGOGGLESHAT = "Solía usar esto, ahora parece que no puedo encajarlo en mi cabeza.",
		PLANTREGISTRYHAT = "Solía usar esto, ahora parece que no puedo encajarlo en mi cabeza.",

        FARM_SOIL_DEBRIS = "La huerta está hecha un desastre por su culpa...",

		FIRENETTLES = "Si no aguantas bien el calor, no te acerques a la huerta.",
		FORGETMELOTS = "Um... No me acuerdo de qué iba a decir de estos.",
		SWEETTEA = "Una tacita de té para olvidarme de todos los problemas.",
		TILLWEED = "¡Largo de mi huerta!",
		TILLWEEDSALVE = "Bálsamo curador en todo su esplendor.",
        WEED_IVY = "Oye, ¡tú no eres una verdura!",
        IVY_SNARE = "Qué poca educación.",

		TROPHYSCALE_OVERSIZEDVEGGIES =
		{
			GENERIC = "Puedo medir.",
			HAS_ITEM = "Peso: {weight}\nCosecha del día: {day}\nNo está mal.",
			HAS_ITEM_HEAVY = "Peso: {weight}\nCosecha del día: {day}\nNo me imaginaba que podrían crecer tanto.",
            HAS_ITEM_LIGHT = "Es tan normal que la báscula ni siquiera se molesta en decirme cuánto pesa.",
			BURNING = "Mmm... ¿Qué se está haciendo?",
			BURNT = "Supongo que no era la mejor forma de preparar esto.",
        },

        CARROT_OVERSIZED = "¡Qué montón de zanahorias gigantes!",
        CORN_OVERSIZED = "¡Gran abrazadera!",
        PUMPKIN_OVERSIZED = "Calabaza.",
        EGGPLANT_OVERSIZED = "¿Tiene forma de amigo?",
        DURIAN_OVERSIZED = "Me encanta.",
        POMEGRANATE_OVERSIZED = "El fruto pecaminoso.",
        DRAGONFRUIT_OVERSIZED = "¿Saldrá volando?",
        WATERMELON_OVERSIZED = "Una sandía grande y jugosa.",
        TOMATO_OVERSIZED = "Un tomate con unas proporciones impresionantes.",
        POTATO_OVERSIZED = "Alimenta familias numerosas.",
        ASPARAGUS_OVERSIZED = "Me da que estaremos comiendo espárragos una buena temporada.",
        ONION_OVERSIZED = "¡Uy!",
        GARLIC_OVERSIZED = "¡Un ajo colosal!",
        PEPPER_OVERSIZED = "Un pimiento de un tamaño un tanto atípico.",

        VEGGIE_OVERSIZED_ROTTEN = "Qué mala suerte.",

		FARM_PLANT =
		{
			GENERIC = "¡Es una planta!",
			SEED = "Hora de esperar.",
			GROWING = "Crece, mi hermosa creación, ¡crece!",
			FULL = "Hora de cosechar.",
			ROTTEN = "Demasiado tarde.",
			FULL_OVERSIZED = "¡!",
			ROTTEN_OVERSIZED = "Quemalo.",
			FULL_WEED = "Sabía que acabaría arrancando a la impostora...",

			BURNING = "Eso no puede ser bueno para las plantas...",
		},

        FRUITFLY = "¡Fuera, bicho!",
        LORDFRUITFLY = "Eh, ¡deja de molestar a las plantas!",
        FRIENDLYFRUITFLY = "La huerta parece más alegre ahora que está aquí.",
        FRUITFLYFRUIT = "¡Ahora mando yo!",

        SEEDPOUCH = "Ya empezaba a cansarme de llevar semillas sueltas en los bolsillos.",

		-- Crow Carnival
		CARNIVAL_HOST = "Qué persona tan peculiar...",
		CARNIVAL_CROWKID = "Que tengas un buen día, pequeña ave humanoide.",
		CARNIVAL_GAMETOKEN = "Una ficha brillante.",
		CARNIVAL_PRIZETICKET =
		{
			GENERIC = "Aquí está el tíquet.",
			GENERIC_SMALLSTACK = "Aquí están los tíquets.",
			GENERIC_LARGESTACK = "¡Cuántos tíquets!",
		},

		CARNIVALGAME_FEEDCHICKS_NEST = "Es una pequeña trampilla.",
		CARNIVALGAME_FEEDCHICKS_STATION =
		{
			GENERIC = "No podré jugar hasta que le dé algo brillante.",
			PLAYING = "¡Parece divertido!",
		},
		CARNIVALGAME_FEEDCHICKS_KIT = "Esta feria aparece y desaparece como si nada.",
		CARNIVALGAME_FEEDCHICKS_FOOD = "No tendré que masticarlos antes, ¿no?",

		CARNIVALGAME_MEMORY_KIT = "Esta feria aparece y desaparece como si nada.",
		CARNIVALGAME_MEMORY_STATION =
		{
			GENERIC = "No podré jugar hasta que le dé algo brillante.",
			PLAYING = "No es por presumir, pero alguna vez me han dicho que soy un genio.",
		},
		CARNIVALGAME_MEMORY_CARD =
		{
			GENERIC = "Es una pequeña trampilla.",
			PLAYING = "¿Seguro que es esta?",
		},

		CARNIVALGAME_HERDING_KIT = "Esta feria aparece y desaparece como si nada.",
		CARNIVALGAME_HERDING_STATION =
		{
			GENERIC = "No podré jugar hasta que le dé algo brillante.",
			PLAYING = "Those eggs are looking a little runny.",
		},
		CARNIVALGAME_HERDING_CHICK = "Come back here!",

		CARNIVALGAME_SHOOTING_KIT = "Esta feria aparece y desaparece como si nada.",
		CARNIVALGAME_SHOOTING_STATION =
		{
			GENERIC = "No podré jugar hasta que le dé algo brillante.",
			PLAYING = "Podría calcular la trayectoria, pero implica muchos números complicados y garabatos.",
		},
		CARNIVALGAME_SHOOTING_TARGET =
		{
			GENERIC = "Es una pequeña trampilla.",
			PLAYING = "Ese objetivo realmente está empezando a molestarme.",
		},

		CARNIVALGAME_SHOOTING_BUTTON =
		{
			GENERIC = "No podré jugar hasta que le dé algo brillante.",
			PLAYING = "¿Qué es?",
		},

		CARNIVALGAME_WHEELSPIN_KIT = "Esta feria aparece y desaparece como si nada.",
		CARNIVALGAME_WHEELSPIN_STATION =
		{
			GENERIC = "No podré jugar hasta que le dé algo brillante.",
			PLAYING = "Resulta que girar las ruedas es realmente muy productivo.",
		},

		CARNIVALGAME_PUCKDROP_KIT = "Esta feria aparece y desaparece como si nada.",
		CARNIVALGAME_PUCKDROP_STATION =
		{
			GENERIC = "No podré jugar hasta que le dé algo brillante.",
			PLAYING = "La física no siempre funciona de la misma manera dos veces.",
		},

		CARNIVAL_PRIZEBOOTH_KIT = "El verdadero premio es el puesto que montamos por el camino.",
		CARNIVAL_PRIZEBOOTH =
		{
			GENERIC = "Ya sé lo que quiero... ¡Eso de ahí!",
		},

		CARNIVALCANNON_KIT = "Pum.",
		CARNIVALCANNON =
		{
			GENERIC = "¡Bum!",
			COOLDOWN = "¡Es la bomba!",
		},

		CARNIVAL_PLAZA_KIT = "A los pájaros les encantan los árboles.",
		CARNIVAL_PLAZA =
		{
			GENERIC = "Todavía no hay mucho ambiente de Cuerviferia, ¿no?",
			LEVEL_2 = "Un parajito me ha dicho que esto podría estar un poquito más decorado.",
			LEVEL_3 = "Cría cuervos y... ¡vendrán al árbol a celebrarlo!",
		},

		CARNIVALDECOR_EGGRIDE_KIT = "Espero que este premio lo parta.",
		CARNIVALDECOR_EGGRIDE = "Podría estar mirándolo durante horas.",

		CARNIVALDECOR_LAMP_KIT = "Ya solo queda lo fácil: ponerse con las luces.",
		CARNIVALDECOR_LAMP = "Le da energía algo sin sentido.",
		CARNIVALDECOR_PLANT_KIT = "¿Será un boj?",
		CARNIVALDECOR_PLANT = "O es diminuta... o yo soy gigante.",
		CARNIVALDECOR_BANNER_KIT = "¿Tengo que construirlo yo mismo? Debería haber sabido que habría una trampa.",
		CARNIVALDECOR_BANNER = "Creo que todas estas decoraciones brillantes se reflejan bien en mí.",

		CARNIVALDECOR_FIGURE =
		{
			RARE = "Aquí tenemos una prueba de que repetir lo mismo una y otra vez acaba dando sus frutos.",
			UNCOMMON = "Este tipo de diseño no es muy común.",
			GENERIC = "Tengo un montón de cosas como esta...",
		},
		CARNIVALDECOR_FIGURE_KIT = "¡Ay, la emoción de los descubrimientos!",
		CARNIVALDECOR_FIGURE_KIT_SEASON2 = "¡Ay, la emoción de los descubrimientos!",

        CARNIVAL_BALL = "Su sencillez es una genialidad.", --unimplemented
		CARNIVAL_SEEDPACKET = "Qué ganas tenía de picar algo.",
		CARNIVALFOOD_CORNTEA = "¿Se supone que la bebida tiene que ser crujiente?",

        CARNIVAL_VEST_A = "Me da un toque aventurero.",
        CARNIVAL_VEST_B = "Es como llevar mi propio árbol de sombra.",
        CARNIVAL_VEST_C = "Espero que no tenga bichos...",

        -- YOTB
        YOTB_SEWINGMACHINE = "Coser no puede ser tan difícil..., ¿no?",
        YOTB_SEWINGMACHINE_ITEM = "Parece que requiere algo de montaje.",
        YOTB_STAGE = "Qué raro... Nunca lo veo entrar ni salir.",
        YOTB_POST =  "El concurso irá sobre ruedas, aunque no lo digo literalmente...",
        YOTB_STAGE_ITEM = "Todo apunta a que requiere de construcción.",
        YOTB_POST_ITEM =  "Será mejor que lo prepare.",


        YOTB_PATTERN_FRAGMENT_1 = "Si junto alguno más, seguro que me puedo hacer una ropa folclórica.",
        YOTB_PATTERN_FRAGMENT_2 = "Si junto alguno más, seguro que me puedo hacer una ropa folclórica.",
        YOTB_PATTERN_FRAGMENT_3 = "Si junto alguno más, seguro que me puedo hacer alguna ropa folclórica.",

        YOTB_BEEFALO_DOLL_WAR = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },
        YOTB_BEEFALO_DOLL_DOLL = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },
        YOTB_BEEFALO_DOLL_FESTIVE = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },
        YOTB_BEEFALO_DOLL_NATURE = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },
        YOTB_BEEFALO_DOLL_ROBOT = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },
        YOTB_BEEFALO_DOLL_ICE = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },
        YOTB_BEEFALO_DOLL_FORMAL = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },
        YOTB_BEEFALO_DOLL_VICTORIAN = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },
        YOTB_BEEFALO_DOLL_BEAST = {
            GENERIC = "Una muñeca de una bestia vestida en una ropa folclórica.",
            YOTB = "¿Qué le parecerá esto al juez?",
        },

        WAR_BLUEPRINT = "¡Menuda fiera!",
        DOLL_BLUEPRINT = "¡Mi beefalo va a quedar como un figurín!",
        FESTIVE_BLUEPRINT = "¡Es el momento perfecto para sacar el espíritu festivo!",
        ROBOT_BLUEPRINT = "Me parece un poco sospechoso que haya que soldar tanto en un proyecto de costura.",
        NATURE_BLUEPRINT = "Las flores nunca fallan.",
        FORMAL_BLUEPRINT = "Es un disfraz para un beefalo de primera.",
        VICTORIAN_BLUEPRINT = "Creo que mi abuela solía ponerse algo parecido.",
        ICE_BLUEPRINT = "Prefiero el beefalo fresco, no congelado.",
        BEAST_BLUEPRINT = "¡Creo que este a lo mejor da suerte!",

        BEEF_BELL = "Vuelve dóciles a los beefalos.",

		-- YOT Catcoon
		KITCOONDEN =
		{
			GENERIC = "Hay que ser muy pequeñito para caber ahí.",
            BURNT = "¡NOOOO!",
			PLAYING_HIDEANDSEEK = "¿Dónde estarán...?",
			PLAYING_HIDEANDSEEK_TIME_ALMOST_UP = "¡No queda mucho tiempo! ¿¡Dónde están!?",
		},

		KITCOONDEN_KIT = "Todo el gatarro.",

		TICOON =
		{
			GENERIC = "¡Parece que sabe lo que hace!",
			ABANDONED = "Seguro que puedo encontrarlos sin ayuda.",
			SUCCESS = "¡Oye, ha encontrado uno!",
			LOST_TRACK = "Alguien los ha encontrado antes que yo.",
			NEARBY = "Parece que hay algo cerca.",
			TRACKING = "Debería seguirle.",
			TRACKING_NOT_MINE = "Está guiando a otra persona.",
			NOTHING_TO_TRACK = "Parece que ya no queda nada.",
			TARGET_TOO_FAR_AWAY = "Estarán demasiado lejos para captar su olor.",
		},

		YOT_CATCOONSHRINE =
        {
            GENERIC = "¿Qué hacer...?",
            EMPTY = "Tal vez le gustaría tener una pluma para jugar...",
            BURNT = "Huele a pelo quemado.",
        },

		KITCOON_FOREST = "Pequeño demonio.",
		KITCOON_SAVANNA = "Pequeño demonio.",
		KITCOON_MARSH = "Pequeño demonio.",
		KITCOON_DECIDUOUS = "Pequeño demonio.",
		KITCOON_GRASS = "Pequeño demonio.",
		KITCOON_ROCKY = "Pequeño demonio.",
		KITCOON_DESERT = "Pequeño demonio.",
		KITCOON_MOON = "¿Cómo lo estás llevando, Lucio?",
		KITCOON_YOT = "Pequeño demonio.",

        -- Moon Storm
        ALTERGUARDIAN_PHASE1 = {
            GENERIC = "¿Es solo el comienzo?",
            DEAD = "Creo que hay más de dónde vino eso.",
        },
        ALTERGUARDIAN_PHASE2 = {
            GENERIC = "Creo que se ha enfadado...",
            DEAD = "Todavía no es el final.",
        },
        ALTERGUARDIAN_PHASE2SPIKE = "¡Ahora lo entiendo!",
        ALTERGUARDIAN_PHASE3 = "¡Ahora sí que se ha enfadado!",
        ALTERGUARDIAN_PHASE3TRAP = "No dormir.",
        ALTERGUARDIAN_PHASE3DEADORB = "He matado una parte de la luna.",
        ALTERGUARDIAN_PHASE3DEAD = "He matado una parte de la luna.",

        ALTERGUARDIANHAT = "¡Vamos a desglosarlo y usar las piezas en otra cosa!",
        ALTERGUARDIANHATSHARD = "Ahora debería ir al reloj divino de globo y hacer algo bonito para mí.",

        MOONSTORM_GLASS = {
            GENERIC = "Es de cristal.",
            INFUSED = "Será útil."
        },

        MOONSTORM_STATIC = "...",
        MOONSTORM_STATIC_ITEM = "Ojalá pudiera reunirme contigo aquí.",
        MOONSTORM_SPARK = "Impactante.",

        BIRD_MUTANT = "Creo que antes era un cuervo.",
        BIRD_MUTANT_SPITTER = "No me gusta que me mire así...",

        WAGSTAFF_NPC = "Te desprecio.",
        ALTERGUARDIAN_CONTAINED = "¡NO!",

        WAGSTAFF_TOOL_1 = "¡Se parece a mi herramienta! Estetoscopio reticular.",
        WAGSTAFF_TOOL_2 = "¡Se parece a mi herramienta! Mando dentado.",
        WAGSTAFF_TOOL_3 = "¡Se parece a mi herramienta! Libreta teledirigida.",
        WAGSTAFF_TOOL_4 = "¡Se parece a mi herramienta! Multiusos conceptual.",
        WAGSTAFF_TOOL_5 = "¡Se parece a mi herramienta! Perceptor calibrado.",

        MOONSTORM_GOGGLESHAT = "Esto no se ajusta a mi cabeza.",

        MOON_DEVICE = {
            GENERIC = "¿Te voy a volver a ver mi amor?",
            CONSTRUCTION1 = "Sólo un paso más cerca de ti.",
            CONSTRUCTION2 = "Más cerca...",
        },

		-- Wanda
        POCKETWATCH_HEAL = {
			GENERIC = "Se puede utilizar.",
			RECHARGING = "El tiempo siempre está incorrecto.",
		},

        POCKETWATCH_REVIVE = {
			GENERIC = "Se puede utilizar.",
			RECHARGING = "El tiempo siempre está incorrecto.",
		},

        POCKETWATCH_WARP = {
			GENERIC = "Se puede utilizar.",
			RECHARGING = "El tiempo siempre está incorrecto.",
		},

        POCKETWATCH_RECALL = {
			GENERIC = "Se puede utilizar.",
			RECHARGING = "El tiempo siempre está incorrecto.",
			UNMARKED = "only_used_by_wanda",
			MARKED_SAMESHARD = "only_used_by_wanda",
			MARKED_DIFFERENTSHARD = "only_used_by_wanda",
		},

        POCKETWATCH_PORTAL = {
			GENERIC = "Se puede utilizar.",
			RECHARGING = "El tiempo siempre está incorrecto.",
			UNMARKED = "only_used_by_wanda unmarked",
			MARKED_SAMESHARD = "only_used_by_wanda same shard",
			MARKED_DIFFERENTSHARD = "only_used_by_wanda other shard",
		},

        POCKETWATCH_WEAPON = {
			GENERIC = "El tiempo siempre está incorrecto.",
			DEPLETED = "only_used_by_wanda",
		},

        POCKETWATCH_PARTS = "Tripas de tiempo.",
        POCKETWATCH_DISMANTLER = "Herramientas.",

        POCKETWATCH_PORTAL_ENTRANCE =
		{
			GENERIC = "¡Adelante!",
			DIFFERENTSHARD = "¡Adelante!",
		},
        POCKETWATCH_PORTAL_EXIT = "Menuda caída...",

        -- Waterlog
        WATERTREE_PILLAR = "¡Ese árbol es gigantesco!",
        OCEANTREE = "Creo que estos árboles están un poco perdidos...",
        OCEANTREENUT = "Hay algo vivo en su interior.",
        WATERTREE_ROOT = "No es una raíz cuadrada.",

        OCEANTREE_PILLAR = "Mola.",

        OCEANVINE = "Como pequeñas lámparas.",
        FIG = "Huele a nada.",
        FIG_COOKED = "Es casi desabrido.",

        SPIDER_WATER = "Espero que te caigas al agua.",
        MUTATOR_WATER = "Comida para arañas.",
        OCEANVINE_COCOON = "Interesante Construcción.",
        OCEANVINE_COCOON_BURNT = "Huele a tostada quemada.",

        GRASSGATOR = "Quiero besar esas mejillas herbosas.",

        TREEGROWTHSOLUTION = "Baba de crecimiento para el árbol.",

        FIGATONI = "Sí.",
        FIGKABAB = "Rico.",
        KOALEFIG_TRUNK = "Esto debería ser ilegal.",
        FROGNEWTON = "De acuerdo.",

        -- The Terrorarium
        TERRARIUM = {
            GENERIC = "Su sola visión me confunde... o... ¿me deja a cuadros?",
            CRIMSON = "Tengo un mal presentimiento...",
            ENABLED = "¿¡He llegado al otro lado del arcoíris!?",
			WAITING_FOR_DARK = "¿Qué será? Tal vez debería consultarlo con la almohada.",
			COOLDOWN = "Tiene que recargarse.",
			SPAWN_DISABLED = "Se acabaron las miradas curiosas.",
        },

        -- Wolfgang
        MIGHTY_GYM =
        {
            GENERIC = "¿Para qué?",
            BURNT = "Para eso.",
        },

        DUMBBELL = "¿Una herramienta?",
        DUMBBELL_GOLDEN = "¿Una herramienta brillante?",
		DUMBBELL_MARBLE = "¡Una herramienta pesada!",
        DUMBBELL_GEM = "Una herramienta.",
        POTATOSACK = "Está lleno de rocas preciosas.",


        TERRARIUMCHEST =
		{
			GENERIC = "Y no necesita llave, ¡ahora estamos hablando!",
			BURNT = "Ehh.",
			SHIMMER = "Juega Terraria ahora.",
		},

		EYEMASKHAT = "Agh asqueroso.",

        EYEOFTERROR = "¡Ataca al ojo!",
        EYEOFTERROR_MINI = "Me da un poco de cosita.",
        EYEOFTERROR_MINI_GROUNDED = "Creo que está a punto de eclosionar...",

        FROZENBANANADAIQUIRI = "Amarillo y delicioso.",
        BUNNYSTEW = "Se le ha acabado la suerte.",
        MILKYWHITES = "...Puaj.",

        CRITTER_EYEOFTERROR = "¡Un par de ojos extra nunca vienen mal! U... ojo.",

        SHIELDOFTERROR ="¿Qué hace esa boca?",
        TWINOFTERROR1 = "¿Alma de visión? ¿Nadie?",
        TWINOFTERROR2 = "¿Lingotes sagrados? ¿Nadie?",

        -- Year of the Catcoon
        CATTOY_MOUSE = "Ratones con ruedas.",
        KITCOON_NAMETAG = "Hace que estas criaturas piensen en ser domesticadas.",

		KITCOONDECOR1 =
        {
            GENERIC = "No es un pájaro de verdad, pero eso las crías no lo saben.",
            BURNT = "¡Combustión!",
        },
		KITCOONDECOR2 =
        {
            GENERIC = "Esas crías se distraen con nada. ¿Qué estaba haciendo yo?",
            BURNT = "Todos han ardido.",
        },

		KITCOONDECOR1_KIT = "Parece que requiere montaje.",
		KITCOONDECOR2_KIT = "No parece demasiado difícil de montar.",

        -- WX78
        WX78MODULE_MAXHEALTH = "Corazón de lavadora.",
        WX78MODULE_MAXSANITY1 = "Corazón de lavadora.",
        WX78MODULE_MAXSANITY = "Corazón de lavadora.",
        WX78MODULE_MOVESPEED = "Corazón de lavadora.",
        WX78MODULE_MOVESPEED2 = "Corazón de lavadora.",
        WX78MODULE_HEAT = "Corazón de lavadora.",
        WX78MODULE_NIGHTVISION = "Corazón de lavadora.",
        WX78MODULE_COLD = "Corazón de lavadora.",
        WX78MODULE_TASER = "Corazón de lavadora.",
        WX78MODULE_LIGHT = "Corazón de lavadora.",
        WX78MODULE_MAXHUNGER1 = "Corazón de lavadora.",
        WX78MODULE_MAXHUNGER = "Corazón de lavadora.",
        WX78MODULE_MUSIC = "Corazón de lavadora.",
        WX78MODULE_BEE = "Corazón de lavadora.",
        WX78MODULE_MAXHEALTH2 = "Corazón de lavadora.",

        WX78_SCANNER =
        {
            GENERIC ="Se nota que WX-78 se deja una parte de su ser en sus creaciones.",
            HUNTING = "¡A por los datos!",
            SCANNING = "Creo que ha encontrado algo.",
        },

        WX78_SCANNER_ITEM = "¿Es una mosca?",
        WX78_SCANNER_SUCCEEDED = "Tiene el aspecto de alguien con ganas de enseñar lo que ha hecho.",

        WX78_MODULEREMOVER = "Es evidente que es un instrumento científico muy complicado y delicado.",

        SCANDATA = "Notas escritas en una secuencia extraña.",

		-- QOL 2022
		JUSTEGGS = "Ñam.",
		VEGGIEOMLET = "Mmmmm.",
		TALLEGGS = "Gran comida.",
		BEEFALOFEED = "No quiero, gracias.",
		BEEFALOTREAT = "Un poco demasiado granulado para mi gusto.",

        -- Pirates
        BOAT_ROTATOR = "Las cosas van en la dirección correcta. O tal vez la otra correcta.",
        BOAT_ROTATOR_KIT = "Creo que lo sacaré a dar una vuelta.",
        BOAT_BUMPER_KELP = "No salvará al barco de todo, pero seguro que ayudalga.",
        BOAT_BUMPER_KELP_KIT = "Un parachoques de barco que pronto será.",
        BOAT_BUMPER_SHELL = "Le da al barco un poco de defensarazón propio.",
        BOAT_BUMPER_SHELL_KIT = "Un parachoques de barco que pronto será.",
        BOAT_CANNON = {
            GENERIC = "Debería cargarlo con algo.",
            AMMOLOADED = "¡El cañón está listo para disparar!",
            NOAMMO = "No olvidé las balas de cañón, solo estoy dejando que la anticipación crezca.",
        },
        BOAT_CANNON_KIT = "Todavía no es un cañón, pero lo será.",
        CANNONBALL_ROCK_ITEM = "Esto encajará perfectamente en un cañón.",

        OCEAN_TRAWLER = {
            GENERIC = "Hace que la pesca sea más eficiente.",
            LOWERED = "Y ahora a esperar.",
            CAUGHT = "¡Atrapó algo!",
            ESCAPED = "Parece que algo fue atrapado, pero se escapó...",
            FIXED = "¡Todo listo para pescar de nuevo!",
        },
        OCEAN_TRAWLER_KIT = "Debería ponerlo en algún lugar con muchos peces.",

        BOAT_MAGNET =
        {
            GENERIC = "Siempre me atrae la física, como un... ah, no puedo pensar en la palabra.",
            ACTIVATED = "¡¡Está funcionando!! Eh, sabía que funcionaría, por supuesto.",
        },
        BOAT_MAGNET_KIT = "Una de mis ideas más geniales, si lo digo yo mismo.",

        BOAT_MAGNET_BEACON =
        {
            GENERIC = "Esto atraerá cualquier imán fuerte cercano.",
            ACTIVATED = "¡Magnetismo!",
        },
        DOCK_KIT = "Todo lo que necesito para construir un muelle para mi barco.",
        DOCK_WOODPOSTS_ITEM = "¡Ajá! Pensé que al muelle le faltaba algo.",

        MONKEYHUT =
        {
            GENERIC = "Las casas en los árboles son lugares terriblemente inflamables.",
            BURNT = "¡Como dije!",
        },
        POWDER_MONKEY = "¡No te atrevas a andar mono con mi bote!",
        PRIME_MATE = "Un sombrero bonito siempre es un claro indicador de quién está a cargo.",
		LIGHTCRAB = "¡Es bioluminoso!",
        CUTLESS = "Lo que le falta en el corte lo compensa en astillas.",
        CURSED_MONKEY_TOKEN = "Se adhiere al alma.",
        OAR_MONKEY = "Realmente pone el remo a la batalla.",
        BANANABUSH = "¡Ese arbusto son plátanos!",
        DUG_BANANABUSH = "¡Ese arbusto es de plátanolocos!",
        PALMCONETREE = "Palmera.",
        PALMCONE_SEED = "Los orígenes de un árbol.",
        PALMCONE_SAPLING = "Tiene grandes sueños de ser un árbol algún día.",
        PALMCONE_SCALE = "Si los árboles tuvieran uñas de los pies, me imagino que se verían así.",
        MONKEYTAIL = "Me pregunto si son comestibles.",
        DUG_MONKEYTAIL = "Me pregunto si son comestibles.",

        MONKEY_MEDIUMHAT = "No.",
        MONKEY_SMALLHAT = "No.",
        POLLY_ROGERSHAT = "No.",
        POLLY_ROGERS = "Pequeño pajarito.",

        MONKEYISLAND_PORTAL = "No puedo escapar.",
        MONKEYISLAND_PORTAL_DEBRIS = "Basura.",
        MONKEYQUEEN = "Primate.",
        MONKEYPILLAR = "Un verdadero pilar de la comunidad.",
        PIRATE_FLAG_POLE = "¡Ahoy!",

        BLACKFLAG = "Yar.",
        PIRATE_STASH = "Para tesoro.",
        STASH_MAP = "Léelo.",


        BANANAJUICE = "Comida.",

        FENCE_ROTATOR = "Mírame girar.",

        CHARLIE_STAGE_POST = "El set.",
        CHARLIE_LECTURN = "Para contar historias.",

        CHARLIE_HECKLER = "Brr.",

        PLAYBILL_THE_DOLL = "\"Escrito por C.W.\"",
        STATUEHARP_HEDGESPAWNER = "Las flores volvieron a crecer, pero la cabeza no.",
        HEDGEHOUND = "Zarzas retorcidas, esa picadura.",
        HEDGEHOUND_BUSH = "Se mueve.",

        MASK_DOLLHAT = "Es una máscara de muñeca.",
        MASK_DOLLBROKENHAT = "Es una máscara de muñeca agrietada.",
        MASK_DOLLREPAIREDHAT = "Era una máscara de muñeca en un momento dado.",
        MASK_BLACKSMITHHAT = "Es una máscara de herrero.",
        MASK_MIRRORHAT = "Es una máscara de espejo.",
        MASK_QUEENHAT = "Es una máscara de reina.",
        MASK_KINGHAT = "Es una máscara de rey.",
        MASK_TREEHAT = "Es una máscara de árbol.",
        MASK_FOOLHAT = "Es una máscara de tonto.",

        COSTUME_DOLL_BODY = "Es un disfraz de muñeca.",
        COSTUME_QUEEN_BODY = "Es un disfraz de reina.",
        COSTUME_KING_BODY = "Es un disfraz de rey.",
        COSTUME_BLACKSMITH_BODY = "Es un disfraz de herrero.",
        COSTUME_MIRROR_BODY = "Es un disfraz.",
        COSTUME_TREE_BODY = "Es un disfraz de árbol.",
        COSTUME_FOOL_BODY = "Es un disfraz de tonto.",

        STAGEUSHER =
        {
            STANDING = "No me toques.",
            SITTING = "Incorrecto.",
        },
        SEWING_MANNEQUIN =
        {
            GENERIC = "Descansa ahora.",
            BURNT = "...",
        },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		LIQUID_MIRROR = "Gas cambiante, sólido rotando, espejo líquido.",
		WHY_REDGEM_SEED = "Fragmentos de un corazón, cálido abrazo.",
		WHY_REDGEM_FORMATION = "Sus saltos cardíacos resuenan con los míos.",
		WHY_REDGEM_OVERGROWN = "Maravillosa formación carmesí, ¿no lo es?",
		WHY_BLUEGEM_SEED = "Fragmentos de hielo, frío impredecible.",
		WHY_BLUEGEM_FORMATION = "Envía escalofríos por la columna vertebral.",
		WHY_BLUEGEM_OVERGROWN = "Me siento seguro.",
		WHY_PURPLEGEM_SEED = "Fragmentos de insania.",
		WHY_PURPLEGEM_FORMATION = "Te engancha y nunca te deja ir.",
		WHY_PURPLEGEM_OVERGROWN = "¿Crees en la magia?",
		WHY_GREENGEM_SEED = "Fragmentos de transformación.",
		WHY_GREENGEM_FORMATION = "Cambia cuando lo tocas.",
		WHY_GREENGEM_OVERGROWN = "No mires hacia otro lado ahora, está enojado.",
		WHY_ORANGEGEM_SEED = "Fragmentos de memoria y tiempo.",
		WHY_ORANGEGEM_FORMATION = "Espiral hacia el horror.",
		WHY_ORANGEGEM_OVERGROWN = "El monumento al borde entre el pasado y el presente.",
		WHY_YELLOWGEM_SEED = "Fragmentos de luz y esperanza.",
		WHY_YELLOWGEM_FORMATION = "Llévame a algún lugar bonito.",
		WHY_YELLOWGEM_OVERGROWN = "Estoy seguro de que entiendes cómo se ve.",
		WHY_OPALGEM_SEED = "Fragmentos de horrores cósmicos.",
		WHY_OPALGEM_FORMATION = "Lo inimaginable se vuelve creíble.",
		WHY_OPALGEM_OVERGROWN = "Me asusta.",
		WHY_REFINED_LUREPLANT = "¡Manos de tierra!",
		WHY_REFINED_PLANTERA = "Canta una oda para la madre tierra.",
		WHY_REFINED_DESERTSTONE = "Conviértete en el centro del universo.",
		WHY_REFINED_MILKY = "Invierte la inanición.",
		WHY_REFINED_LIGHTBULB = "Pequeña luz.",
		WHY_REFINED_GLASSWHITES = "Te veo.",
		WHY_REFINED_GOLD = "Obtén una sabiduría abrumadora.",
		WHY_REFINED_MARBLE = "MIAU.¿MUR?",
		WHY_REFINED_MOONROCK = "Puede que llueva algún día.",
		WHY_REFINED_FLINT = "Afila la visión.",
		WHY_REFINED_REDGEM = "Se siente más como un estómago que como un ojo ...",
		WHY_REFINED_BLUEGEM = "El frío no me abandona.",
		WHY_REFINED_PURPLEGEM = "Echa un vistazo a la locura, todo el tiempo que quieras.",
		WHY_REFINED_GREENGEM = "Mira la hora, es la planta en punto.",
		WHY_REFINED_ORANGEGEM = "Devora todo.",
		WHY_REFINED_YELLOWGEM = "Brilla.",
		WHY_REFINED_OPALGEM = "Inverna.",
		WHY_PERFECTIONGEM = "Nunca más te sientas débil.",
		WHY_NOTHINGNESSGEM = "Los gritos, el sabor del icor y la sangre llenan mi boca, pero lo siento. Me siento poderoso.",
		ANCIENTDREAMS_GEMSHARD = "Comida para el alma.",
		WHYEHAT_HELM = "No es mucho, pero es un trabajo honesto.",
		WHYEHAT_HELMET = "Finalmente. un trabajo honesto.",
		WHYEHAT = "Una reliquia de quién fui una vez.",
		WHYEHAT_FACE = "¿Soy bonito ahora?",
		WHYEARMOR = "Soy yo quien se siente completo de nuevo.",
		WHYEARMOR_BACKPACK = "¡Yo lo llamo el unidad-almacena-joyas-inador!",
		WHYEARMOR_INCOMPLETE = "Quiero sentirme completo de nuevo.",
		WHYEARMOR_PILE = "Estoy triturado en trozos y pedazos.",
		WHYCRANK = "Para medir las cuencas de mis ojos.",
		WHYTORCH = "Lideraré el camino.",
		WHYPIERCER = "Haré el camino.",
		WHYLIFEPEELER = "Libera alma, pieza a pieza.",
		WHYTEPADLO = "Estar en cualquier lugar en cualquier momento, ¡por eso amo mis inventos!",
		WHYBRELLA = "Vals bajo la lluvia, en toda su gloria.",
		WHYFLUTOSCOPE = "Una herramienta del trompetista que anuncia la guerra.",
		WHYLANTERN = "La forma de caparazón es esencial para amplificar la distribución de luz.",
		WHYCRUSHER = "Rinde homenaje y disfruta de su esencia.",
		WHYJEWELLAB = "Justo como en mi taller.",
		WHYGLOBELAB = "Para maneras ancestrales.",

		BEDROLL_GNARCOON = "Descanso para la gente del pueblo.",
		BEDROLL_GNARCOON_WINTER = "Deleitoso sueño para reyes.",
		COONTAIL_SHADOW = "Hierba gatera, o tal vez peor...",
		GNARANG = "Forja tus maneras con ceniza y huesos.",
		GNARANG_FORGE = "Lucha tus maneras, o muere en el intento.",
		GNARANG_IMPROVED = "Tus pecados eventualmente regresan a ti.",

		GNARCOON_1_AWARD = "Basura absoluta.",
		GNARCOON_2_AWARD = "Basura absoluta.",
		GNARCOON_3_AWARD = "Basura absoluta.",
		GNARCOON_4_AWARD = "Basura absoluta ligeramente mejor.",
		GNARCOON_AWARDHAT = "Basura absoluta ligeramente mejor.",
		GNARCOON_DOLL = "Apesta a carne, atada por el alma enfurecida.",
		GNARCOON_EYE = "...",
		GNARCOON_JUNIOR = "Criatura ingenua.",
		GNARCOON_SLY_CANE = "Si pudiera saltar, mis huesos se caerán.",
		GNARCOON_TAILNECKLACE = "Para comedores quisquillosos.",
		GNARCOON_UMBRA_CANE = "Buena.",
		GNARCOON_UMBRA_SWORD = "La sombra se echa a perder.",
		GNARCOON_UMBRA_TOOL_POINT = "Atrayente...",
		GNARCOON_UMBRA_TOOL_ROUND = "Herramienta para el transporte de materia.",
		GNARCOON_UMBRA_TOOL_SHARP = "Tecnología digna de los antiguos.",
		GNARCOON_UMBRASKELETON = "Sueños deleitosos para mentes débiles...",
		GNARCOONBONES = "Rica anatomía.",
		GNARCOONDEN = {
			GENERIC = "Raíz de todo mal.",
			EMPTY = "Y no hubo ninguno.",},
		EMPTY_GNARCOONDEN = "El infierno está vacío.",
		GNARCOONSEABONES = "Maravillosa estructura.",
		GNARCOONSKELETON = "Una falsificación.",
		GNARGLASSES = "¿Por qué querrías ver menos?",
		GNARGLASSES_JONES = "Disfraz sin sentido.",
		GNARGLASSES_KAT = "No.",
		GNARGLASSES_KING = "Caricatura, tal criatura asquerosa.",
		GNARGLASSES_MADNESS = "Ver en rojo.",
		GNARHAT = "Bonita.",
		GNARHAT_ENNO = "Cara amigable.",
		GNARHAT_FORGE = "El hueso que te bendice con proficiencia.",
		GNARHAT_IMPROVED = "El hueso que te bendice con proficiencia.",
		GNARHAT_KING = "Caricatura, tal criatura asquerosa.",
		GNARHAT_UMBRA = "Síí... maravilloso.",
		GNARHAT_UMBRA_HELMET = "De criaturas no desaparecidas hace mucho.",
		GNARHAT_WONDERWHY = "No puedo forzar una lágrima para mostrar mis sentimientos.",
		SHADOW_GNARCOON_JUNIOR = "Los demonios del inframundo están temblando y llorando en este momento.",
		WINLEY_EYE = "...",
		WINLEY_EYEMULET_EMPTY = "...",
		WINLEY_EYEMULET_BLACK = "...",
		WINLEY_EYEMULET_WHITE = "...",
		WINLEY_EYEMULET_BOTH = "...",

		GNARCOON =
        {
            GENERIC = "Tus huesos recuerdan mis tiempos.",
            ATTACKER = "¿Oh? ¿Te acuerdas ahora?",
            MURDERER = "Su memoria no se perdió después de todo.",
            REVIVER = "Los aliados tienden a reunirse naturalmente.",
            GHOST = "Todavía puedo ver tu corazón.",
            FIRESTARTER = "Esto no es como tú, %s.",
        },
		
		SKELETON_PLAYER =
		{
			MALE = "%s debe haber muerto cachondeando con %s.",
			FEMALE = "%s debe haber muerto cachondeando con %s.",
			ROBOT = "%s debe haber muerto cachondeando con %s.",
			DEFAULT = "%s debe haber muerto cachondeando con %s.",
			PLURAL = "%s debe haber muerto cachondeando con %s.",
		},

    },

	DESCRIBE_ANCIENTEYEPERSPECTIVE = "No puedo decir si es de esta dimensión.", --"only_used_by_wonderwhy", --notused anymore

    DESCRIBE_GENERIC = "Es una... cosa.",
    DESCRIBE_TOODARK = "¡Está demasiado oscuro para poder ver!",
    DESCRIBE_SMOLDERING = "Eso está a punto de prenderse fuego.",

    DESCRIBE_PLANTHAPPY = "Qué planta tan alegre.",
    DESCRIBE_PLANTVERYSTRESSED = "Esta planta está muy estresada.",
    DESCRIBE_PLANTSTRESSED = "No está de buen humor.",
    DESCRIBE_PLANTSTRESSORKILLJOYS = "Creo que voy a tener que quitar los hierbajos...",
    DESCRIBE_PLANTSTRESSORFAMILY = "Esta planta se siente sola",
    DESCRIBE_PLANTSTRESSOROVERCROWDING = "Hay demasiadas plantas peleándose por este espacio tan pequeño.",
    DESCRIBE_PLANTSTRESSORSEASON = "La estación no se está portando muy bien con esta planta.",
    DESCRIBE_PLANTSTRESSORMOISTURE = "Se está deshidratando.",
    DESCRIBE_PLANTSTRESSORNUTRIENTS = "Esta pobre planta necesita nutrientes.",
    DESCRIBE_PLANTSTRESSORHAPPINESS = "Tiene ganas de mantener una conversación agradable.",

    EAT_FOOD =
    {
        TALLBIRDEGG_CRACKED = "Como bebés.",
		WINTERSFEASTFUEL = "El sabor de familias rotas.",
    },

}