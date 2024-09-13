return {
	ACTIONFAIL =
	{
        APPRAISE =
        {
            NOTNOW = "它们现在肯定很忙.",
        },
        REPAIR =
        {
            WRONGPIECE = "这些碎片合不上...",
        },
        BUILD =
        {
            MOUNTED = "顾不得关心.",
            HASPET = "一个随从已经过多了...",--questioned
			TICOON = "跟随它的引导.",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "屠宰野兽前它得是睡着的.",
			GENERIC = "无毛可拔.",
			NOBITS = "无毛可拔.",
            REFUSE = "only_used_by_woodie",
            SOMEONEELSESBEEFALO = "这头野兽有主.",
		},
		STORE =
		{
			GENERIC = "它满到口子上了.",
			NOTALLOWED = "绝不.",
			INUSE = "有人在用.",
            NOTMASTERCHEF = "这超出了我的能力.",
		},
        CONSTRUCT =
        {
            INUSE = "朽败的恶魔, 滚开.",
            NOTALLOWED = "不.",
            EMPTY = "它需要改进.",
            MISMATCH = "不对.",
        },
		RUMMAGE =
		{	
			GENERIC = "现在不是时候...",
			INUSE = "让他们翻去吧.",
            NOTMASTERCHEF = "这超出了我的能力.",
		},
		UNLOCK =
        {
        	WRONGKEY = "钥匙不对...",
        },
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "我早就猜到了.",
        	KLAUS = "专为我准备的珍贵礼物.",
			QUAGMIRE_WRONGKEY = "钥匙不对.",
        },
		ACTIVATE = 
		{
			LOCKED_GATE = "大门被封死了.",
            HOSTBUSY = "他此刻似乎有点心事重重.",
            CARNIVAL_HOST_HERE = "出来吧, 丑鸟.",
            NOCARNIVAL = "鸟没了.",
			EMPTY_CATCOONDEN = "邪恶无存. 暂时的.",
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDERS = "小恶魔不够了.",
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDING_SPOTS = "它们需要更多的藏身之处.",
			KITCOON_HIDEANDSEEK_ONE_GAME_PER_DAY = "我想这就够了.",
            MANNEQUIN_EQUIPSWAPFAILED = "恐怕不太适合穿.",
		},
		OPEN_CRAFTING =
		{
            PROFESSIONALCHEF = "这超出了我的烹饪能力.",
			SHADOWMAGIC = "暗影, 编织.",
		},
        COOK =
        {
            GENERIC = "我现在不能烹饪.",
            INUSE = "让他们用去吧.",
            TOOFAR = "再近点...",
        },
        START_CARRAT_RACE =
        {
            NO_RACERS = "我跟丢了什么东西.",
        },

		DISMANTLE =
		{
			COOKING = "only_used_by_warly",
			INUSE = "only_used_by_warly",
			NOTEMPTY = "only_used_by_warly",
        },
        FISH_OCEAN =
		{
			TOODEEP = "必须要用更好的工具.",
		},
        OCEAN_FISHING_POND =
		{
			WRONGGEAR = "这没用.",
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
            GENERIC = "没用.",
            DEAD = "鬼没有手, 真遗憾.",
            SLEEPING = "醒醒懒鬼, 我有东西给你.",
            BUSY = "停止你在做的事.",
            ABIGAILHEART = "这个实体已经不是一个真实的人类了.",
            GHOSTHEART = "又错了...",
            NOTGEM = "它需要更好的能源.",
            WRONGGEM = "宝石不对.",
            NOTSTAFF = "它需要根法杖.",
            MUSHROOMFARM_NEEDSSHROOM = "它以死亡之花为食.",
            MUSHROOMFARM_NEEDSLOG = "用活木的尖叫填充燃料.",
            MUSHROOMFARM_NOMOONALLOWED = "这些蘑菇看起来拒绝被种!",
            SLOTFULL = "里面已经有东西了...",
            FOODFULL = "里面已经有东西了...",
            NOTDISH = "不是凡人的食物.",
            DUPLICATE = "我们全知...",
            NOTSCULPTABLE = "这种物质不适合雕刻.",
            NOTATRIUMKEY = "我刚刚在想什么? 只有那把钥匙.",
            CANTSHADOWREVIVE = "复活是不可能的.",
            WRONGSHADOWFORM = "它没被拼对.",
            NOMOON = "它们是不可见的.",
			PIGKINGGAME_MESSY = "太乱了.",
			PIGKINGGAME_DANGER = "先清除危险.",
			PIGKINGGAME_TOOLATE = "胖混蛋睡着了.",
			CARNIVALGAME_INVALID_ITEM = "我正需要代币.",
			CARNIVALGAME_ALREADY_PLAYING = "已经开始了.",
            SPIDERNOHAT = "我口袋里装不下它们.",
            TERRARIUM_REFUSE = "也许我应该用不同的燃料做实验...",
            TERRARIUM_COOLDOWN = "我想我们再给它东西之前得等树长出来.",
            NOTAMONKEY = "对你的语言没兴趣.",
            QUEENBUSY = "女王在忙.",
        },
        GIVETOPLAYER =
        {
            FULL = "为我要送给你的礼物腾点地方!",
            DEAD = "你的鬼魂没有手, 真遗憾.",
            SLEEPING = "凡人睡着了.",
            BUSY = "呆着别动，丑陋的虫子.",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "为我要送给你的礼物腾点地方!",
            DEAD = "Y你的鬼魂没有手, 真遗憾.",
            SLEEPING = "凡人睡着了.",
            BUSY = "呆着别动，丑陋的虫子.",
        },
        WRITE =
        {
            GENERIC = "我无法覆写历史.",
            INUSE = "桌子有人在用.",
        },
        DRAW =
        {
            NOIMAGE = "缪斯女神得再近一些.",
        },
        CHANGEIN =
        {
            GENERIC = "现在不是打扮的时候.",
            BURNING = "里面的衣服都烧了.",
            INUSE = "有人想当国王.",
            NOTENOUGHHAIR = "没有足够的毛来做造型.",
            NOOCCUPANT = "它需要一些东西来固定.",
        },
        ATTUNE =
        {
            NOHEALTH = "再洒点物质出来我就要死了.",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "愤怒的野兽, 冷静下来!",
            INUSE = "有人抢先我一步!",
			SLEEPING = "起床时间到了!",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "愤怒的野兽, 冷静下来!",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "知识就是一切, 而我已经拥有了.",
            CANTLEARN = "这超出了我的理解能力, 有趣...",

            --MapRecorder/MapExplorer
            WRONGWORLD = "这不是我们所在的地点.",

			--MapSpotRevealer/messagebottle
			MESSAGEBOTTLEMANAGER_NOT_FOUND = "在这种光线下我什么也看不清!",--Likely trying to read messagebottle treasure map in caves

            STASH_MAP_NOT_FOUND = "没有X标志.",-- Likely trying to read stash map  in world without stash
        },
        WRAPBUNDLE =
        {
            EMPTY = "把空气包起来也太蠢了.",
        },
        PICKUP =
        {
			RESTRICTION = "它不是为我准备的.",
			INUSE = "让他们拿去吧.",
            NOTMINE_SPIDER = "only_used_by_webber",
            NOTMINE_YOTC =
            {
                "不是我的随从.",
                "别咬我, 老鼠!",
            },
			NO_HEAVY_LIFTING = "only_used_by_wanda",
            FULL_OF_CURSES = "我才不要碰那个.",
        },
        SLAUGHTER =
        {
            TOOFAR = "让它逃了.",
        },
        REPLATE =
        {
            MISMATCH = "食物错误.",
            SAMEDISH = "食物相同.",
        },
        SAIL =
        {
        	REPAIR = "它状态很好.",
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "我需要更好地把握时机.",
            BAD_TIMING1 = "别着急.",
            BAD_TIMING2 = "...",
        },
        LOWER_SAIL_FAIL =
        {
            "我的下巴打滑了.",
            "不.",
            "我不是故意放低的.",
        },
        BATHBOMB =
        {
            GLASSED = "先打破玻璃.",
            ALREADY_BOMBED = "不需要再放一个了.",
        },
		GIVE_TACKLESKETCH =
		{
			DUPLICATE = "这一个已经处理过了.",
		},
		COMPARE_WEIGHABLE =
		{
            FISH_TOO_SMALL = "无关紧要的大小.",
            OVERSIZEDVEGGIES_TOO_SMALL = "无关紧要的大小.",
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
            GENERIC = "没有东西要学了.",
            FERTILIZER = "我不想再知道更多了.",
        },
        FILL_OCEAN =
        {
            UNSUITABLE_FOR_PLANTS = "由于某些原因, 植物不喜欢盐水.",
        },
        POUR_WATER =
        {
            OUT_OF_WATER = "空的.",
        },
        POUR_WATER_GROUNDTILE =
        {
            OUT_OF_WATER = "空的.",
        },
        USEITEMON =
        {
            --GENERIC = "I can't use this on that!",

            --construction is PREFABNAME_REASON
            BEEF_BELL_INVALID_TARGET = "生物不对.",
            BEEF_BELL_ALREADY_USED = "别人的问题.",
            BEEF_BELL_HAS_BEEF_ALREADY = "我已经有一头野兽了.",
        },
        HITCHUP =
        {
            NEEDBEEF = "铃铛.",
            NEEDBEEF_CLOSER = "太远了.",
            BEEF_HITCHED = "已经绑上了.",
            INMOOD = "坏种.",
        },
        MARK =
        {
            ALREADY_MARKED = "我已经决定了.",
            NOT_PARTICIPANT = "别烦我, 这不关我事.",
        },
        YOTB_STARTCONTEST =
        {
            DOESNTWORK = "我猜他们不支持这里的艺术.",
            ALREADYACTIVE = "他肯定在哪忙着弄另一场比赛.",
        },
        YOTB_UNLOCKSKIN =
        {
            ALREADYKNOWN = "我已经学过这个了!",
        },
        CARNIVALGAME_FEED =
        {
            TOO_LATE = "快点!",
        },
        HERD_FOLLOWERS =
        {
            WEBBERONLY = "它们不会听我的, 不过它们也许会听韦伯的.",
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
            DOER_ISNT_MODULE_OWNER = "我看着像台机器吗?",
        },
    },

	ANNOUNCE_CANNOT_BUILD =
	{
		NO_INGREDIENTS = "组件缺失.",
		NO_TECH = "需要机器.",
		NO_STATION = "我放弃.",
	},

	ACTIONFAIL_GENERIC = "...",
	ANNOUNCE_BOAT_LEAK = "开始沉没了.",
	ANNOUNCE_BOAT_SINK = "我们的身体会漂起来.",
	ANNOUNCE_DIG_DISEASE_WARNING = "疾病不再.",
	ANNOUNCE_PICK_DISEASE_WARNING = "它在腐烂.",
	ANNOUNCE_ADVENTUREFAIL = "失败.",
    ANNOUNCE_MOUNT_LOWHEALTH = "野兽受伤了.",

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

	ANNOUNCE_BEES = "飞吧，我的随从们!",
	ANNOUNCE_BOOMERANG = "...!",
	ANNOUNCE_CHARLIE = "你想摆脱我, 有趣.",
	ANNOUNCE_CHARLIE_ATTACK = "我经历过更糟的...",
	ANNOUNCE_CHARLIE_MISSED = "only_used_by_winona", --winona specific 
	ANNOUNCE_COLD = "我们的物质正在变得迟钝.",
	ANNOUNCE_HOT = "我们在融化.",
	ANNOUNCE_CRAFTING_FAIL = "物质缺失.",
	ANNOUNCE_DEERCLOPS = "它来找人了.",
	ANNOUNCE_CAVEIN = "它们被激怒了.",
	ANNOUNCE_ANTLION_SINKHOLE = 
	{
		"沙漠之怒要困扰我们了.",
		"野兽!",
		"硬物下落中.",
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "我是否要表达敬意?",
        "一份礼物, 伟大的蚁狮.",
        "停止你的食欲.",
	},
	ANNOUNCE_SACREDCHEST_YES = "我把我们的东西拿走了.",
	ANNOUNCE_SACREDCHEST_NO = "...",
    ANNOUNCE_DUSK = "黑暗将吞噬一切.",
    
    --wx-78 specific
    ANNOUNCE_CHARGE = "only_used_by_wx78",
	ANNOUNCE_DISCHARGE = "only_used_by_wx78",

	ANNOUNCE_EAT =
	{
		GENERIC = "尽情享用!",
		PAINFUL = "真有趣.",
		SPOILED = "腐烂了.",
		STALE = "对有机物来说时间过得飞快.",
		INVALID = "吃不得.",
        YUCKY = "...不.",
        
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
        "黏住.",
        "慢而稳.",
        "用你的背... 背起来...",
        "我这把老骨头不适合这种工作.",
        "这是必须的.",
        "哼...!",
        "...",
        "...!",
        "...!",
    },
    ANNOUNCE_ATRIUM_DESTABILIZING = 
    {
		"终于!",
		"失败了?!",
		"不! 是我们的错!",
	},
    ANNOUNCE_RUINS_RESET = "好像时间偏移了...",
    ANNOUNCE_SNARED = "锋利的骨头.",
    ANNOUNCE_SNARED_IVY = "植物大战僵尸...",
    ANNOUNCE_REPELLED = "抵御攻击.",
	ANNOUNCE_ENTER_DARK = "黑暗.",
	ANNOUNCE_ENTER_LIGHT = "光明.",
	ANNOUNCE_FREEDOM = "自由!",
	ANNOUNCE_HIGHRESEARCH = "知识就是一切.",
	ANNOUNCE_HOUNDS = "野兽, 来你的屠宰场.",
	ANNOUNCE_WORMS = "野兽, 来你的屠宰场.",
	ANNOUNCE_HUNGRY = "我们. 饥饿.",
	ANNOUNCE_HUNT_BEAST_NEARBY = "狩猎即将结束.",
	ANNOUNCE_HUNT_LOST_TRAIL = "迷失在它的愚蠢中.",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "痕迹泥泞不堪.",
	ANNOUNCE_INV_FULL = "丢下它吧, 我有更重要的东西要关心.",
	ANNOUNCE_KNOCKEDOUT = "我的脸还在吗?",
	ANNOUNCE_LOWRESEARCH = "遗憾.",
	ANNOUNCE_MOSQUITOS = "吸血鬼.",
    ANNOUNCE_NOWARDROBEONFIRE = "衣服烧了.",
    ANNOUNCE_NODANGERGIFT = "怪物仍在周围潜藏.",
    ANNOUNCE_NOMOUNTEDGIFT = "我们要跳下去才能那么做.",
	ANNOUNCE_NODANGERSLEEP = "那个可以先等等.",
	ANNOUNCE_NODAYSLEEP = "光明让我困扰.",
	ANNOUNCE_NODAYSLEEP_CAVE = "光明依然让我困扰.",
	ANNOUNCE_NOHUNGERSLEEP = "我们渴望鲜血而不是休息.",
	ANNOUNCE_NOSLEEPONFIRE = "我们不该在烈焰中休息.",
	ANNOUNCE_NODANGERSIESTA = "野兽仍在周围潜藏.",
	ANNOUNCE_NONIGHTSIESTA = "现在是晚上.",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "不是时候.",
	ANNOUNCE_NOHUNGERSIESTA = "我太饿了睡不好!",
	ANNOUNCE_NODANGERAFK = "我们饥渴, 没时间休息了.",
	ANNOUNCE_NO_TRAP = "蠢货.",
	ANNOUNCE_PECKED = "...",
	ANNOUNCE_QUAKE = "我的下巴在发抖.",
	ANNOUNCE_RESEARCH = "更多需要掌握的知识.",
	ANNOUNCE_SHELTER = "终于, 庇护所.",
	ANNOUNCE_THORNS = "...",
	ANNOUNCE_BURNT = "火焰缠绕着我们.",
	ANNOUNCE_TORCH_OUT = "甜美的黑暗.",
	ANNOUNCE_THURIBLE_OUT = "甜美的黑暗逝去了.",
	ANNOUNCE_FAN_OUT = "飞走了.",
    ANNOUNCE_COMPASS_OUT = "设备坏了.",
	ANNOUNCE_TRAP_WENT_OFF = "有埋伏?",
	ANNOUNCE_UNIMPLEMENTED = "不管这是什么意思.",
	ANNOUNCE_WORMHOLE = "可爱.",
	ANNOUNCE_TOWNPORTALTELEPORT = "...",
	ANNOUNCE_CANFIX = "\n它需要改进, 我能提供!",
	ANNOUNCE_ACCOMPLISHMENT = "干得好，流浪者.",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "了不起...",
	ANNOUNCE_INSUFFICIENTFERTILIZER = "更多营养.",
	ANNOUNCE_TOOL_SLIP = "它飞走了.",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "那真烫.",
	ANNOUNCE_TOADESCAPING = "蟾蜍失去了兴趣.",
	ANNOUNCE_TOADESCAPED = "蟾蜍跑了.",


	ANNOUNCE_DAMP = "湿透了.",
	ANNOUNCE_WET = "我与水一体.",
	ANNOUNCE_WETTER = "...我讨厌这里.",
	ANNOUNCE_SOAKED = "我要淹死了.",

	ANNOUNCE_WASHED_ASHORE = "...",

    ANNOUNCE_DESPAWN = "是时候再次去物质化了.",
	ANNOUNCE_BECOMEGHOST = "抵达终点.",
	ANNOUNCE_GHOSTDRAIN = "我的生命刚要开始溜走...",
	ANNOUNCE_PETRIFED_TREES = "树在叫吗?",
	ANNOUNCE_KLAUS_ENRAGE = "我喜欢挑战.",
	ANNOUNCE_KLAUS_UNCHAINED = "限制解除.",
	ANNOUNCE_KLAUS_CALLFORHELP = "随从来了.",

	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "出来.",
		GLASS_LOW = "我看到你了.",
		GLASS_REVEAL = "我知道你的用途.",
		IDOL_MED = "出来.",
		IDOL_LOW = "我看到你了.",
		IDOL_REVEAL = "我知道你的用途.",
		SEED_MED = "出来.",
		SEED_LOW = "我看到你了.",
		SEED_REVEAL = "我知道你的用途.",
	},

    --hallowed nights
    ANNOUNCE_SPOOKED = "啊.",
	ANNOUNCE_BRAVERY_POTION = "我真的需要喝那个吗?",
	ANNOUNCE_MOONPOTION_FAILED = "有趣... 这没用.",

	--winter's feast
	ANNOUNCE_EATING_NOT_FEASTING = "...",
	ANNOUNCE_WINTERS_FEAST_BUFF = "...",
	ANNOUNCE_IS_FEASTING = "...",
	ANNOUNCE_WINTERS_FEAST_BUFF_OVER = "呃...",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "回来, 回到生者的世界.",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "不用谢.",
    ANNOUNCE_REVIVED_FROM_CORPSE = "我已回归.",

    ANNOUNCE_FLARE_SEEN = "上面的光?",
    ANNOUNCE_MEGA_FLARE_SEEN = "这是正式宣战.",
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "海洋中的野兽, 在地平线上.",

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
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "这烧不出东西.",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "烧焦了.",
    QUAGMIRE_ANNOUNCE_LOSE = "I smell something fishy. Glorp florp.", -- ？
    QUAGMIRE_ANNOUNCE_WIN = "Naura!",

    ANNOUNCE_ROYALTY =
    {
        "呛死它.",
        "首席白痴.",
        "我对你的死亡表示哀悼.",
    },

    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "闪电充斥着我!",
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "力量, 增强!",
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "我的皮肤变硬了.",
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "这是怎么做到的...",
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "水迹无存.",
    ANNOUNCE_ATTACH_BUFF_SLEEPRESISTANCE   = "我拒绝向你屈服, 梦神.",

    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "闪电离开了我的身体.",
    ANNOUNCE_DETACH_BUFF_ATTACK            = "我虚弱了.",
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "我重新变得易碎.",
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "它走了.",
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "阴雨再临.",
    ANNOUNCE_DETACH_BUFF_SLEEPRESISTANCE   = "好累...",

	ANNOUNCE_OCEANFISHING_LINESNAP = "线断了.",
	ANNOUNCE_OCEANFISHING_LINETOOLOOSE = "收线.",
	ANNOUNCE_OCEANFISHING_GOTAWAY = "鱼跑了.",
	ANNOUNCE_OCEANFISHING_BADCAST = "那是啥...",
	ANNOUNCE_OCEANFISHING_IDLE_QUOTE =
	{
		"耐心.",
		"这里没有鱼.",
		"人需要我, 水兽惧怕我.",
		"随时会上钩.",
	},

	ANNOUNCE_WEIGHT = "重量: {weight}",
	ANNOUNCE_WEIGHT_HEAVY  = "重量: {weight}\n我是重量级钓鱼选手!",

	ANNOUNCE_WINCH_CLAW_MISS = "我想我没击中目标.",
	ANNOUNCE_WINCH_CLAW_NO_ITEM = "见鬼! 我空手而归.",

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
    ANNOUNCE_WEAK_RAT = "真弱.",

    ANNOUNCE_CARRAT_START_RACE = "快跑吧, 讨厌的老鼠!",

    ANNOUNCE_CARRAT_ERROR_WRONG_WAY = {
        "蠢老鼠!",
        "转身!",
    },
    ANNOUNCE_CARRAT_ERROR_FELL_ASLEEP = "起来.",
    ANNOUNCE_CARRAT_ERROR_WALKING = "加速!",
    ANNOUNCE_CARRAT_ERROR_STUNNED = "冲! 冲!",

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

	ANNOUNCE_POCKETWATCH_PORTAL = "时不我待.",

	ANNOUNCE_POCKETWATCH_MARK = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_RECALL = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL_DIFFERENTSHARD = "only_used_by_wanda",

    ANNOUNCE_ARCHIVE_NEW_KNOWLEDGE = "哈哈, 我知道了...",
    ANNOUNCE_ARCHIVE_OLD_KNOWLEDGE = "我已经知道那个了.",
    ANNOUNCE_ARCHIVE_NO_POWER = "力量消失了.",

    ANNOUNCE_PLANT_RESEARCHED =
    {
        "我对这种植物的了解越来越多了!",
    },

    ANNOUNCE_PLANT_RANDOMSEED = "我想知道它会长成什么.",

    ANNOUNCE_FERTILIZER_RESEARCHED = "...",

	ANNOUNCE_FIRENETTLE_TOXIN =
	{
		"好热!",
		"...!",
	},
	ANNOUNCE_FIRENETTLE_TOXIN_DONE = "荨麻毒素失效了.",

	ANNOUNCE_TALK_TO_PLANTS =
	{
        "神圣的母亲, 帮助这个年轻的灵魂触碰光明!",
        "来吧孩子, 触碰我.",
		"*亲亲*!",
        "生长，闪耀!",
        "别让我失望.",
	},

	ANNOUNCE_KITCOON_HIDEANDSEEK_START = "我要来找了.",
	ANNOUNCE_KITCOON_HIDEANDSEEK_JOIN = "嗷~~~它们在玩捉迷藏呢.",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND =
	{
		"找到你了!",
		"你在这啊.",
		"我就知道你会藏在这!",
		"我看到你了!",
	},
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_ONE_MORE = "最后一只藏在哪呢?",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE = "我找到最后一只了!",
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE_TEAM = "{name} 找到最后一只了!",
	ANNOUNCE_KITCOON_HIDANDSEEK_TIME_ALMOST_UP = "这些小东西一定等的不耐烦了...",
	ANNOUNCE_KITCOON_HIDANDSEEK_LOSEGAME = "我想它们不想再玩了...",
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR = "它们不会藏这么远吧, 不是吗?",
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR_RETURN = "小浣猫应该就在附近.",
	ANNOUNCE_KITCOON_FOUND_IN_THE_WILD = "我就知道我看到附近藏了什么东西!",

	ANNOUNCE_TICOON_START_TRACKING	= "它闻着味了!",
	ANNOUNCE_TICOON_NOTHING_TO_TRACK = "看起来它什么也找不到.",
	ANNOUNCE_TICOON_WAITING_FOR_LEADER = "我应该跟上它!",
	ANNOUNCE_TICOON_GET_LEADER_ATTENTION = "它非常想让我跟上.",
	ANNOUNCE_TICOON_NEAR_KITCOON = "它一定找到什么了!",
	ANNOUNCE_TICOON_LOST_KITCOON = "看起来其他人找到它正在找的东西了.",
	ANNOUNCE_TICOON_ABANDONED = "我会自己找到那些小不点的.",
	ANNOUNCE_TICOON_DEAD = "可怜的家伙... 好了，它刚刚指的哪?",

    -- YOTB
    ANNOUNCE_CALL_BEEF = "过来!",
    ANNOUNCE_CANTBUILDHERE_YOTB_POST = "裁判在这看不到我的牛.",
    ANNOUNCE_YOTB_LEARN_NEW_PATTERN =  "我脑子里满是牛牛造型的灵感!",

    -- AE4AE
    ANNOUNCE_EYEOFTERROR_ARRIVE = "给我你的眼睛!",
    ANNOUNCE_EYEOFTERROR_FLYBACK = "面对我!",
    ANNOUNCE_EYEOFTERROR_FLYAWAY = "面对我，懦夫!",

    -- PIRATES
    ANNOUNCE_CANT_ESCAPE_CURSE = "当然没那么容易.",
    ANNOUNCE_MONKEY_CURSE_1 = "...",
    ANNOUNCE_MONKEY_CURSE_CHANGE = "...?!",
    ANNOUNCE_MONKEY_CURSE_CHANGEBACK = "很高兴这结束了.",

    ANNOUNCE_PIRATES_ARRIVE = "诅咒你.",

    ANNOUNCE_BOOK_MOON_DAYTIME = "only_used_by_waxwell_and_wicker",

    ANNOUNCE_OFF_SCRIPT = "没按剧本演, 好多地方都错了.",

	BATTLECRY =
	{
		GENERIC = "我要挖了你的眼睛!",
		PIG = "你不是我的对手!",
		PREY = "给我死!",
		SPIDER = "败倒在我脚下!",
		SPIDER_WARRIOR = "尽管来吧!",
		DEER = "好! 快跑吧!",
	},
	COMBAT_QUIT =
	{
		GENERIC = "没时间做那个了!",
		PIG = "滚出我的视线.",
		PREY = "你得救了!",
		SPIDER = "让它们再活一天.",
		SPIDER_WARRIOR = "你已经够让我火大的了.",
	},

	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "诱骗更多傻瓜.",
        MULTIPLAYER_PORTAL_MOONROCK = "一命换一命.",
        MOONROCKIDOL = "伪神.",
        CONSTRUCTION_PLANS = "虚假的逃生方法.",

        ANTLION =
        {
            GENERIC = "伟大的蚁狮要求供品.",
            VERYHAPPY = "满意了.",
            UNHAPPY = "生气了.",
        },
        ANTLIONTRINKET = "看看这沙漠之心.",
        SANDSPIKE = "愤怒的神, 你能做的还有很多.",
        SANDBLOCK = "这挡不住我.",
        GLASSSPIKE = "这就像有了骨头的沙子.",
        GLASSBLOCK = "不够重建帝国.",
        ABIGAIL_FLOWER =
        {
            GENERIC ="攥紧回忆.",
			LEVEL1 = "扭曲思想.",
			LEVEL2 = "激励渴望.",
			LEVEL3 = "但这种希望是种愚蠢的特质.",

			-- deprecated
            LONG = "我看着那东西灵魂就受伤了.",
            MEDIUM = "这让我浑身起鸡皮疙瘩.",
            SOON = "那朵花有点不对劲!",
            HAUNTED_POCKET = "我觉得我不该留着这个.",
            HAUNTED_GROUND = "我很想知道它的作用.",
        },

        BALLOONS_EMPTY = "它看起来像小丑的货币.",
        BALLOON = "扔了吧, 这没用.",
		BALLOONPARTY = "...找点乐子?",
		BALLOONSPEED =
        {
            DEFLATED = "没用.",
            GENERIC = "对, 一个提高速度的愚蠢尝试.",
        },
		BALLOONVEST = "吱吱声烦死我了.",
		BALLOONHAT = "皇冠的糟糕之选.",

        BERNIE_INACTIVE =
        {
            BROKEN = "恶魔离开了.",
            GENERIC = "恶魔在里面.",
        },

        BERNIE_ACTIVE = "它吸引祈祷, 不过不完全能战斗.",
        BERNIE_BIG = "它想要挣脱牢笼.",

		BOOKSTATION =
		{
			GENERIC = "好东西都烧了.",
			BURNT = "煤与灰.",
		},
        BOOK_BIRDS = "唤鸟者.",
        BOOK_TENTACLES = "畸形的同人小说.",
        BOOK_GARDENING = "赞美伟大母亲.",
		BOOK_SILVICULTURE = "赞美伟大母亲.",
		BOOK_HORTICULTURE = "赞美伟大母亲.",
        BOOK_SLEEP = "生不如死.",
        BOOK_BRIMSTONE = "激怒天空.",

        BOOK_FISH = "召唤海兽.",
        BOOK_FIRE = "收获燃烧.",
        BOOK_WEB = "...?",
        BOOK_TEMPERATURE = "Ok.", -- reserve this for the pun
        BOOK_LIGHT = "想要战胜恐惧, 你必须面对它.",
        BOOK_RAIN = "上达天听.",
        BOOK_MOON = "我思念他们.",
        BOOK_BEES = "被蛰了...",
        
        BOOK_HORTICULTURE_UPGRADED = "这就像看草生长一样令人兴奋.",
        BOOK_RESEARCH_STATION = "这个我也行.",
        BOOK_LIGHT_UPGRADED = "启迪.",

        FIREPEN = "烫，真的烫!",

        PLAYER =
        {
            GENERIC = "呃，看看你, %s!",
            ATTACKER = "%s是威胁.",
            MURDERER = "叛徒.",
            REVIVER = "%s, 暖心的重聚.",
            GHOST = "%s, 你那样看上去更好.",
            FIRESTARTER = "拿点草, %s. 但别点着了.",
        },
        WILSON =
        {
            GENERIC = "你的逻辑是你的弱点.",
            ATTACKER = "现在不太友好了?",
            MURDERER = "我就知道, 和他们一样疯.",
            REVIVER = "我稍后会告诉你真正的复活是什么样子的...",
            GHOST = "科学家倒下了, 还差几个.",
            FIRESTARTER = "%s, 你是个傻瓜.",
        },
        WOLFGANG =
        {
            GENERIC = "坚固你的心灵, %s!",
            ATTACKER = "别碰我, 畜生.",
            MURDERER = "我会击败你.",
            REVIVER = "心地善良.",
            GHOST = "肌肉少少, 思考多多.",
            FIRESTARTER = "提醒我了, 你们每个都不可信任.",
        },
        WAXWELL =
        {
            GENERIC = "你念错咒了, %s.",
            ATTACKER = "你把想不明白的东西都砍了?",
            MURDERER = "你也是他们中的一员, 别犹豫.", -- questioned
            REVIVER = "%s在用他的能力干好事.",
            GHOST = "别求我.",
            FIRESTARTER = "一种吸引我注意力的方式是当个白痴.",
        },
        WX78 =
        {
            GENERIC = "我认识你吗?",
            ATTACKER = "你无法无天.",
            MURDERER = "杀手机器人, 真奇特.",
            REVIVER = "同理心是你的底线.",
            GHOST = "灵魂被压进金属监狱.",
            FIRESTARTER = "寻求复仇.",
        },
        WILLOW =
        {
            GENERIC = "火焰女士, %s!",
            ATTACKER = "烈焰小姐, 你让我失望了.",
            MURDERER = "我以为你没那么糟.",
            REVIVER = "%s,幽灵之友.",
            GHOST = "尘归尘.",
            FIRESTARTER = "我确信这对你很有意思.",
        },
        WENDY =
        {
            GENERIC = "孩子.",
            ATTACKER = "一种发泄怒气的方式.",
            MURDERER = "杀手行动.",
            REVIVER = "鬼魂缠身.",
            GHOST = "我最好为%s造颗心.",
            FIRESTARTER = "另一种发泄怒气的方式.",
        },
        WOODIE =
        {
            GENERIC = "%s...",
            ATTACKER = "%s最近是不是有点犯傻...",
            MURDERER = "杀人犯! 给我把斧子，我们适应一下新环境!",
            REVIVER = "%s救了所有人的命.",
            GHOST = "\"全包\" 保险包括虚空吗, %s?",
            BEAVER = "你看起来像只老鼠.",
            BEAVERGHOST = "你怎么死的?",
            MOOSE = "我更喜欢你那样.",
            MOOSEGHOST = "你怎么死的?",
            GOOSE = "看看!",
            GOOSEGHOST = "你怎么死的?",
            FIRESTARTER = "别把自己烧着了, %s.",
        },
        WICKERBOTTOM =
        {
            GENERIC = "我更年长, %s!",
            ATTACKER = "平庸.",
            MURDERER = "你需要一把匕首.",
            REVIVER = "我对%s实用的定理抱有深深敬意.",
            GHOST = "你对来世了解多少.",
            FIRESTARTER = "我确信你纵火一定有个明智的理由.",
        },
        WES =
        {
            GENERIC = "没理由和你说话.",
            ATTACKER = "没理由和你说话.",
            MURDERER = "没理由和你说话.",
            REVIVER = "没理由和你说话.",
            GHOST = "没理由和你说话.",
            FIRESTARTER = "没理由和你说话.",
        },
        WEBBER =
        {
            GENERIC = "可怜的孩子, %s, 你还好吗?",
            ATTACKER = "控制你的情绪.",
            MURDERER = "显然你让怪物控制了你.",
            REVIVER = "表现很好，年轻人.",
            GHOST = "%s, 你怎么受伤的?",
            FIRESTARTER = "别碰纵火工具, 算我求你了.",
        },
        WATHGRITHR =
        {
            GENERIC = "野蛮人, 收起你的做作!",
            ATTACKER = "我不是你可以轻易猎杀的怪物.",
            MURDERER = "她的眼中有嗜血的光芒.",
            REVIVER = "%s能完全掌控灵魂.",
            GHOST = "你现在还不配拥有来世.",
            FIRESTARTER = "刀耕火种? 好连招.",
        },
        WINONA =
        {
            GENERIC = "发明家, 唤星!",
            ATTACKER = "%s今天休假.",
            MURDERER = "这看起来不像是另一起事故，%s!",
            REVIVER = "感谢你的服务, %s.",
            GHOST = "看来有人往你的计划里丢了个扳手.",
            FIRESTARTER = "工厂里的东西在燃烧.",
        },
        WORTOX =
        {
            GENERIC = "你看着毛茸茸的.",
            ATTACKER = "坏小鬼, 去去去!",
            MURDERER = "我等会会惩罚你的.",
            REVIVER = "谢谢你的援助之爪, %s.",
            GHOST = "你现在一点都不软了.",
            FIRESTARTER = "我知道一些你可以烧的东西, 这个不是.",
        },
        WORMWOOD =
        {
            GENERIC = "%s...",
            ATTACKER = "他们派你来的吗?",
            MURDERER = "你是受雇的刺客吗?",
            REVIVER = "%s和我想的判若两草.",
            GHOST = "你的水晶掉哪去了?",
            FIRESTARTER = "真是讽刺, %s.",
        },
        WARLY =
        {
            GENERIC = "大厨!",
            ATTACKER = "特殊应急菜谱?",
            MURDERER = "他想做个骨制蛋糕.",
            REVIVER = "总得靠%s来想办法.",
            GHOST = "烹饪可不是儿戏.",
            FIRESTARTER = "你忘了关火了, 看看这场乱子.",
        },

        WURT =
        {
            GENERIC = "浮浪噗 %s!",
            ATTACKER = "%s 格浪皮 浮浪噗!",
            MURDERER = "杀手鱼蛙人!",
            REVIVER = "哦天哪, 你真不必这样的, %s!",
            GHOST = "%s 看起来更浮浪噗了.",
            FIRESTARTER = "我该停止开鱼人玩笑了.",
        },

        WALTER =
        {
            GENERIC = "又一个孩子, 真棒...",
            ATTACKER = "表现良好...",
            MURDERER = "不予评价, 你的狗沾到血了.",
            REVIVER = "有用, 谢谢%s.",
            GHOST = "这不是种有趣的体验吗?",
            FIRESTARTER = "是我太蠢才预设你懂得怎么生火.",
        },

        WANDA =
        {
            GENERIC = "奶奶.",
            ATTACKER = "该停下了.",
            MURDERER = "以前就见过你这一样邪恶的微笑!",
            REVIVER = "万分感谢.",
            GHOST = "时间追上你了.",
            FIRESTARTER = "这没必要吧.",
        },

        WONKEY =
        {
            GENERIC = "变回来.",
            ATTACKER = "变回来，畜生.",
            MURDERER = "变回来，杀人犯.",
            REVIVER = "...",
            GHOST = "这样变不回来的.",
            FIRESTARTER = "这是不是就是恐龙的感受.",
        },

        MIGRATION_PORTAL =
        {
        --    GENERIC = "If I had any friends, this could take me to them.",
        --    OPEN = "If I step through, will I still be me?",
        --    FULL = "It seems to be popular over there.",
        },
        GLOMMER = 
        {
            GENERIC = "它们有胡萝卜一样的腿.",
            SLEEPING = "你摸他们的时候它们会吱吱叫.",
        },
        GLOMMERFLOWER =
        {
            GENERIC = "我应该把这个放在安全的地方.",
            DEAD = "安息吧, 萝卜腿三世.",
        },
        GLOMMERWINGS = "这让我回忆万千.",
        GLOMMERFUEL = "萝卜腿三世! 注意举止!",
        BELL = "哦, 就是这个!",
        STATUEGLOMMER =
        {
            GENERIC = "它在满月会活过来.",
            EMPTY = "现在这里没有秘密了.",
        },

        LAVA_POND_ROCK = "哦天啊, 一块卵石.",

		WEBBERSKULL = "戴上手套把这扔了.",
		WORMLIGHT = "好吃.",
		WORMLIGHT_LESSER = "不够多汁.",
		WORM =
		{
		    PLANT = "为什么不呢.",
		    DIRT = "地下深潜者.",
		    WORM = "真是个惊喜, 深潜者!",
		},
        WORMLIGHT_PLANT = "我觉得挺安全.",
		MOLE =
		{
			HELD = "挖掘机哈罗德.",
			UNDERGROUND = "等我抓到你, 我会给你起个名.",
			ABOVEGROUND = "昏倒了.",
		},
		MOLEHILL = "鼹鼠窝.",
		MOLEHAT = "太臭了，我不戴这个.",

		EEL = "令人惊讶，这些玩意还在这.",
		EEL_COOKED = "我不太喜欢吃鱼, 不过这也行.",
		UNAGI = "食物.",
		EYETURRET = "这在我们那时候用途大不一样.",
		EYETURRET_ITEM = "未激活.",
		MINOTAURHORN = "你令我失望了, 现在我拿到你的鼻子了.",
		MINOTAURCHEST = "我的东西!",
		THULECITE_PIECES = "最好拿着这些.",
		POND_ALGAE = "池塘.",
		GREENSTAFF = "我知道宝石更好的用途, 但是，好吧.",
		GIFT = "我的.",
        GIFTWRAP = "这个也是我的.",
		POTTEDFERN = "装饰品, 愉悦我的眼睛.",
        SUCCULENT_POTTED = "了不起.",
		SUCCULENT_PLANT = "沙漠的黄沙编织出非凡的造物.",
		SUCCULENT_PICKED = "在美消失前捕捉它.",
		SENTRYWARD = "映射工具.",
        TOWNPORTAL =
        {
			GENERIC = "这没用.",
			ACTIVE = "不妨用这个.",
		},
        TOWNPORTALTALISMAN = 
        {
			GENERIC = "这是沙漠给我眼睛的礼物.",
			ACTIVE = "我宁愿走路.",
		},
        WETPAPER = "湿的...",
        WETPOUCH = "湿的.",
        MOONROCK_PIECES = "不要暴露在他们的光芒下, 也许有一天会变成这样.",
        MOONBASE =
        {
            GENERIC = "这是, 召唤他们的装置?",
            BROKEN = "不! 请让我和他们对话!",
            STAFFED = "现在等着就行.",
            WRONGSTAFF = "它需要唤星者魔杖.",
            MOONSTAFF = "...",
        },
        MOONDIAL = 
        {
			GENERIC = "饮水池, 为什么要在这上面用宝石?",
			NIGHT_NEW = "它们由黑暗编织而成.",
			NIGHT_WAX = "重聚的时刻近了.",
			NIGHT_FULL = "我想你，亲爱的.",
			NIGHT_WANE = "你离去了, 像以前一样.",
			CAVE = "没用.",
			WEREBEAVER = "Brr.", --woodie specific
			GLASSED = "我希望你安然无恙, 无论你在哪.",
        },
		THULECITE = "还记得我们以前是怎么雕刻和摆弄这个的吗?",
		ARMORRUINS = "从不令我失望.",
		ARMORSKELETON = "我需要一个不同的身体.",
		SKELETONHAT = "你现在和我一样缺脸了.",
		RUINS_BAT = "它相当重.",
		RUINSHAT = "我自己的王冠...",
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "暴风雨前的宁静.",
            WARN = "要开始了.",
            WAXING = "噩梦周期要开始了.",
            STEADY = "我永远不会原谅他们从我身边带走你.",
            WANING = "它离开了.",
            DAWN = "它走了, 我可以留下了.",
            NOMAGIC = "...",
		},
		BISHOP_NIGHTMARE = "病态又扭曲!",
		ROOK_NIGHTMARE = "放马过来，大家伙!",
		KNIGHT_NIGHTMARE = "我要把你当鼓敲!",
		MINOTAUR = "嗨，是我，只是少了面部特征的我.",
		SPIDER_DROPPER = "它有六条腿，我只有两条, 这怎么能公平呢?",
		NIGHTMARELIGHT = "不要崇拜伪神.",
		NIGHTSTICK = "它带电!",
		GREENGEM = "这种宝石能改变物质.",
		MULTITOOL_AXE_PICKAXE = "诶? 哦对，这是痒痒挠.",
		ORANGESTAFF = "我不太懂, 为什么现在这个会用坏了?",
		YELLOWAMULET = "用燃料维持这个效率好低.",
		GREENAMULET = "老派科技, 真的会让你思考.",
		SLURPERPELT = "不, 就不.",

		SLURPER = "毛茸茸的!",
		SLURPER_PELT = "不, 就不.",
		ARMORSLURPER = "不, 就不...",
		ORANGEAMULET = "我知道一个更好的.",
		YELLOWSTAFF = "这是我的最爱.",
		YELLOWGEM = "这种宝石摩擦时会发出明亮的光.",
		ORANGEGEM = "这种宝石用于运输.",
        OPALSTAFF = "为什么我现在这么痛苦?",
        OPALPRECIOUSGEM = "我想你, 王.",
        TELEBASE = 
		{
			VALID = "降落场地准备完毕.",
			GEMS = "这是对宝石极大的浪费.",
		},
		GEMSOCKET = 
		{
			VALID = "已就绪.",
			GEMS = "把宝石拿过来.",
		},
		STAFFLIGHT = "温暖的光.",
        STAFFCOLDLIGHT = "悲伤的月光低语.",

        ANCIENT_ALTAR = "我造的这个.",

        ANCIENT_ALTAR_BROKEN = "他们把我的艺术毁了.",

        ANCIENT_STATUE = "一个纪念碑, 为一场渐强的癔症.",

        LICHEN = "零食.",
		CUTLICHEN = "咬一小口.",

		CAVE_BANANA = "好吃.",
		CAVE_BANANA_COOKED = "美味!",
		CAVE_BANANA_TREE = "我们在Alter的花园里吃过这个.",
		ROCKY = "你好，朋友.",
		
		COMPASS =
		{
			GENERIC="大家现在用这个?",
			N = "北.",
			S = "南.",
			E = "东.",
			W = "西.",
			NE = "东北.",
			SE = "东南.",
			NW = "西北.",
			SW = "西南.",
		},

        HOUNDSTOOTH = "为利刃准备!",
        ARMORSNURTLESHELL = "有趣的发现.",
        BAT = "这个是新的.",
        BATBAT = "这是根应援棒吗？",
        BATWING = "丢到汤里.",
        BATWING_COOKED = "吃.",
        BATCAVE = "睡相难看.",
        BEDROLL_FURRY = "它温暖又舒适.",
        BUNNYMAN = "晚上好.",
        FLOWER_CAVE = "光照让它生长.",
        GUANO = "肥料.",
        LANTERN = "把它挂在杆子上.",
        LIGHTBULB = "它奇怪地看起来很好吃.",
        MANRABBIT_TAIL = "我拿着这个的时候感觉好点了.",
        MUSHROOMHAT = "噫.",
        MUSHROOM_LIGHT2 =
        {
            ON = "开着.",
            OFF = "关着.",
            BURNT = "烧焦了.",
        },
        MUSHROOM_LIGHT =
        {
            ON = "开着.",
            OFF = "关着.",
            BURNT = "烧焦了.",
        },
        SLEEPBOMB = "大规模杀伤性武器? 不是?",
        MUSHROOMBOMB = "不是?",
        SHROOM_SKIN = "...",
        TOADSTOOL_CAP =
        {
            EMPTY = "不在这.",
            INGROUND = "那只蟾蜍.",
            GENERIC = "砍它.",
        },
        TOADSTOOL =
        {
            GENERIC = "胖小子, 你长大了点.",
            RAGE = "噫!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "烦人!",
            BURNT = "好多了.",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "太大了.",
            BLOOM = "好臭.",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "不予置评.",
            BLOOM = "我有点被冒犯到.",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "一株魔法蘑菇?",
            BLOOM = "它试图繁殖.",
        },
        MUSHTREE_TALL_WEBBED = "蜘蛛觉得这棵很重要.",
        SPORE_TALL =
        {
            GENERIC = "它只是四处飘荡.",
            HELD = "我会在口袋里放好这盏小灯.",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "在这世上无忧无虑.",
            HELD = "我会在口袋里放好这盏小灯.",
        },
        SPORE_SMALL =
        {
            GENERIC = "这是孢子眼中的景象.",
            HELD = "我会在口袋里放好这盏小灯.",
        },
        RABBITHOUSE =
        {
            GENERIC = "兔人房.",
            BURNT = "像生活一样残酷.",
        },
        SLURTLE = "噫.",
        SLURTLE_SHELLPIECES = "没什么用.",
        SLURTLEHAT = "没什么用.",
        SLURTLEHOLE = "一个巢穴.",
        SLURTLESLIME = "我不会碰它的.",
        SNURTLE = "恶心.",
        SPIDER_HIDER = "嘎!",
        SPIDER_SPITTER = "你怎么敢.",
        SPIDERHOLE = "上面结满了蜘蛛网.",
        SPIDERHOLE_ROCK = "上面结满了蜘蛛网.",
        STALAGMITE = "里面可能有什么有价值的东西.",
        STALAGMITE_TALL = "石头... 到处都是石头.",

        TURF_CARPETFLOOR = "我可不想让它出现在我家里.",
        TURF_CHECKERFLOOR = "形状和颜色.",
        TURF_DIRT = "大地的顶端.",
        TURF_FOREST = "大地的顶端.",
        TURF_GRASS = "大地的顶端.",
        TURF_MARSH = "大地的顶端.",
        TURF_METEOR = "一块你走路的地方.",
        TURF_PEBBLEBEACH = "现在怎么办?",
        TURF_ROAD = "匆匆铺成的鹅卵石.",
        TURF_ROCKY = "大地的顶端.",
        TURF_SAVANNA = "大地的顶端.",
        TURF_WOODFLOOR = "出于某种原因，我认为这个是最好的.",

		TURF_CAVE="我们领土的一部分.",
		TURF_FUNGUS="我们领土的一部分.",
		TURF_FUNGUS_MOON = "我们的森林, 浸泡在你的眼泪中.",
		TURF_ARCHIVE = "家.",
		TURF_SINKHOLE="我们领土的一部分.",
		TURF_UNDERROCK="我们领土的一部分.",
		TURF_MUD="我们领土的一部分.",

		TURF_DECIDUOUS = "大地的顶端.",
		TURF_SANDY = "大地的顶端.",
		TURF_BADLANDS = "大地的顶端.",
		TURF_DESERTDIRT = "大地的顶端.",
		TURF_FUNGUS_GREEN = "我们领土的一部分",
		TURF_FUNGUS_RED = "我们领土的一部分",
		TURF_DRAGONFLY = "它还是温的.",

        TURF_SHELLBEACH = "大地的顶端.",

		TURF_RUINSBRICK = "我们领土的一部分.",
		TURF_RUINSBRICK_GLOW = "我们领土的一部分.",
		TURF_RUINSTILES = "我们领土的一部分.",
		TURF_RUINSTILES_GLOW = "我们领土的一部分.",
		TURF_RUINSTRIM = "我们领土的一部分.",
		TURF_RUINSTRIM_GLOW = "我们领土的一部分.",

        TURF_MONKEY_GROUND = "大地的顶端.",

        TURF_CARPETFLOOR2 = "它令人惊讶地柔软.",
        TURF_MOSAIC_GREY = "大地的顶端.",
        TURF_MOSAIC_RED = "大地的顶端.",
        TURF_MOSAIC_BLUE = "大地的顶端.",

		POWCAKE = "呕.",
        CAVE_ENTRANCE = "回去的时候到了?",
        CAVE_ENTRANCE_RUINS = "是时候回家了.",
       
       	CAVE_ENTRANCE_OPEN = 
        {
            GENERIC = "跳.",
            OPEN = "我知道.",
            FULL = "怎么会?",
        },
        CAVE_EXIT = 
        {
            GENERIC = "我宁愿坐在这里.",
            OPEN = "我现在还不想离开.",
            FULL = "地表太拥挤了!",
        },

		MAXWELLPHONOGRAPH = "那音乐, 它让人发疯.",
		BOOMERANG = "抓住!",
		PIGGUARD = "滚远点, 伪神的崇拜者!",
		ABIGAIL =
		{
            LEVEL1 =
            {
                "一具躯壳，企图模仿一个人.",
                "一具躯壳，企图模仿一个人.",
            },
            LEVEL2 =
            {
                "一具躯壳，企图模仿一个人.",
                "一具躯壳，企图模仿一个人.",
            },
            LEVEL3 =
            {
                "一具躯壳，企图模仿一个人.",
                "一具躯壳，企图模仿一个人.",
            },
		},
		ADVENTURE_PORTAL = "不是这个.",
		AMULET = "我有更好的宝石用法.",
		ANIMAL_TRACK = "狩猎时间.",
		ARMORGRASS = "找点更安全的东西.",
		ARMORMARBLE = "不错.",
		ARMORWOOD = "这个够了.",
		ARMOR_SANITY = "我不想这个出现在我附近.",
		ASH =
		{
			GENERIC = "粉末.",
			REMAINS_GLOMMERFLOWER = "花被火焰吞噬.",
			REMAINS_EYE_BONE = "眼骨被火焰吞噬.",
			REMAINS_THINGIE = "行.",
		},
		AXE = "还记得我得亲手砍树的时候, 哦等等我现在也得亲手来.",
		BABYBEEFALO = 
		{
			GENERIC = "长大吧.",
		    SLEEPING = "睡着了.",
        },
        BUNDLE = "真希望早点想到这个.",
        BUNDLEWRAP = "真方便.",
		BACKPACK = "储存.",
		BACONEGGS = "吃.",
		BANDAGE = "这对我没用.", -- still useless when equipping red gem eye？
		BASALT = "坚固的结构.",
		BEARDHAIR = "把这个放到火里.",
		BEARGER = "跨季情人中的第二个.",
		BEARGERVEST = "我很遗憾要在这个冬天给你的丈夫看这个.",
		ICEPACK = "就像冬天和秋天真的很相配.",
		BEARGER_FUR = "闻起来一股土味, 像桦栗果.",
		BEDROLL_STRAW = "让我歇歇这把骨头.",
		BEEQUEEN = "皇室? 别逗我!",
		BEEQUEENHIVE = 
		{
			GENERIC = "嗯, 不.",
			GROWING = "正在再生.",
		},
        BEEQUEENHIVEGROWN = "用锤子再敲敲它.",
        BEEGUARD = "嗡嗡.",
        HIVEHAT = "不，这个皇冠不适合我.",
        MINISIGN =
        {
            GENERIC = "我喜欢这个, 大师之作.",
            UNDRAWN = "画布空白.",
        },
        MINISIGN_ITEM = "把它放在什么地方.",
		BEE =
		{
			GENERIC = "嗡.",
			HELD = "嗡!",
		},
		BEEBOX =
		{
			READY = "准备收获.",
			FULLHONEY = "蜂蜜溢出来了.",
			GENERIC = "嗡!",
			NOHONEY = "它是空的.",
			SOMEHONEY = "耐心点.",
			BURNT = "它不防火",
		},
		MUSHROOM_FARM =
		{
			STUFFED = "死亡之花的牧场.",
			LOTS = "一束死亡之花.",
			SOME = "一些死亡出现.",
			EMPTY = "空无一物.",
			ROTTEN = "这块木头死了.",
			BURNT = "毕竟它是块木头.",
			SNOWCOVERED = "凛冬.",
		},
		BEEFALO =
		{
			FOLLOWER = "它平静地走来了.",
			GENERIC = "这是头皮弗洛牛!",
			NAKED = "赤身裸体.",
			SLEEPING = "睡着了.",
            --Domesticated states:
            DOMESTICATED = "梳洗整洁.",
            ORNERY = "战士.",
            RIDER = "跑者.",
            PUDGY = "懒牛.",
            MYPARTNER = "牛肉仔.",
		},

		BEEFALOHAT = "不.",
		BEEFALOWOOL = "不.",
		BEEHAT = "不.",
        BEESWAX = "为了保存物品.",
		BEEHIVE = "蜂巢.",
		BEEMINE = "战争用具.",
		BEEMINE_MAXWELL = "这家伙疯了!",
		BERRIES = "最好放在沙拉里.",
		BERRIES_COOKED = "噫.",
        BERRIES_JUICY = "我们说话这会就在烂了.",
        BERRIES_JUICY_COOKED = "我们说话这会就在烂了.",
		BERRYBUSH =
		{
			BARREN = "施肥.",
			WITHERED = "缺水.",
			GENERIC = "灌木丛.",
			PICKED = "它们会长回来的.",
			DISEASED = "疾病再现.",
			DISEASING = "疾病再现.",
			BURNING = "着火了.",
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "不长了.",
			WITHERED = "枯萎了.",
			GENERIC = "更多果实, 更快腐烂.",
			PICKED = "现在没有果实了.",
			DISEASED = "疾病再现.",
			DISEASING = "疾病再现.",
			BURNING = "好奇特.",
		},
		BIGFOOT = "巨人来了.",
		BIRDCAGE =
		{
			GENERIC = "困住另一个灵魂.",
			OCCUPIED = "我也处于孤立状态.",
			SLEEPING = "你也在某处睡着.",
			HUNGRY = "喂它们点吃的.",
			STARVING = "它们想吃东西.",
			DEAD = "离别.",
			SKELETON = "空余骨架.",
		},
		BIRDTRAP = "从天空落入我的手中.",
		CAVE_BANANA_BURNT = "灰烬.",
		BIRD_EGG = "蛋般柔滑.",
		BIRD_EGG_COOKED = "烤鸟蛋好吃.",
		BISHOP = "我可能想把你砸成碎片然后偷走你的眼睛.",
		BLOWDART_FIRE = "用于点燃.",
		BLOWDART_SLEEP = "用于呼唤梦神.",
		BLOWDART_PIPE = "用于屠杀.",
		BLOWDART_YELLOW = "用于重击.",
		BLUEAMULET = "为什么这个这么大? 真没必要.",
		BLUEGEM = "这个宝石未经精制.",
		BLUEPRINT = 
		{ 
            COMMON = "一种组合.",
            RARE = "豪华组合.",
        },
        SKETCH = "一件精美的艺术品.",
		COOKINGRECIPECARD = 
		{
			GENERIC = "烹饪书的一页, 上面有丑陋的涂鸦.",
		},
		BLUE_CAP = "我最爱的死亡之花.",
		BLUE_CAP_COOKED = "这浓香让我恶心.",
		BLUE_MUSHROOM =
		{
			GENERIC = "死亡之种.",
			INGROUND = "从曾经智慧的头脑中绽放.",
			PICKED = "花被摘走了, 现在大地会重塑它.",
		},
		BOARDS = "精制的有机材料.",
		BONESHARD = "为了重构自我, 并活到看到另一面.",
		BONESTEW = "这很冒犯.",
		BUGNET = "原始的工具.",
		BUSHHAT = "小丑礼服.",
		BUTTER = "油脂.",
		BUTTERFLY =
		{
			GENERIC = "我很想见你.",
			HELD = "长大吧.",
		},
		BUTTERFLYMUFFIN = "残忍的做法.",
		BUTTERFLYWINGS = "对不起，朋友.",
		BUZZARD = "肉食者.",

		SHADOWDIGGER = "这个魔法无法达成它的目的.",
        SHADOWDANCER = "...我很震惊.",

		CACTUS = 
		{
			GENERIC = "我喜欢它带刺的味道.",
			PICKED = "我会回来宅更多的.",
		},
		CACTUS_MEAT_COOKED = "差点意思.",
		CACTUS_MEAT = "刺是用来加点口感的.",
		CACTUS_FLOWER = "以前我房间里有一束.",

		COLDFIRE =
		{
			EMBERS = "这火需要更多燃料，不然就要灭了.",
			GENERIC = "当然能战胜黑暗.",
			HIGH = "火势要失控了!",
			LOW = "火有点小了.",
			NORMAL = "又好又舒适.",
			OUT = "好吧，烧完了.",
		},
		CAMPFIRE =
		{
			EMBERS = "这火需要更多燃料，不然就要灭了.",
			GENERIC = "当然能战胜黑暗.",
			HIGH = "火势要失控了!",
			LOW = "火有点小了.",
			NORMAL = "又好又舒适.",
			OUT = "好吧，烧完了.",
		},
		CANE = "喜欢散步.",
		CATCOON = "恶魔.",
		CATCOONDEN = 
		{
			GENERIC = "地狱.",
			EMPTY = "地狱冰冻了.",
		},
		CATCOONHAT = "真可笑.",
		COONTAIL = "围巾或背心?",
		CARROT = "美味.",
		CARROT_COOKED = "还能尝到汁.",
		CARROT_PLANTED = "快长.",
		CARROT_SEEDS = "这是胡萝卜种子.",
		CARTOGRAPHYDESK =
		{
			GENERIC = "为了绘制地图.",
			BURNING = "别谈那个了.",
			BURNT = "收回殖民地行动暂停.",
		},
		WATERMELON_SEEDS = "这是西瓜种子.",
		CAVE_FERN = "蕨类.",
		CHARCOAL = "一块不错的绘图材料.",
        CHESSPIECE_PAWN = "苦力.",
        CHESSPIECE_ROOK =
        {
            GENERIC = "我的宝贝蛋子.",
            STRUGGLE = "棋子在自己移动!",
        },
        CHESSPIECE_KNIGHT =
        {
            GENERIC = "马.",
            STRUGGLE = "棋子在自己移动!",
        },
        CHESSPIECE_BISHOP =
        {
            GENERIC = "烦人鬼.",
            STRUGGLE = "棋子在自己移动!",
        },
        CHESSPIECE_MUSE = "女王.",
        CHESSPIECE_FORMAL = "国王.",
        CHESSPIECE_HORNUCOPIA = "无法理解.",
        CHESSPIECE_PIPE = "上瘾纪念碑.",
        CHESSPIECE_DEERCLOPS = "抱歉...",
        CHESSPIECE_BEARGER = "抱歉...",
        CHESSPIECE_MOOSEGOOSE =
        {
            "抱歉，才怪, 你的孩子太烦人了.",
        },
        CHESSPIECE_DRAGONFLY = "我吃了你的战利品, 小虫.",
		CHESSPIECE_MINOTAUR = "我的宝贝!",
        CHESSPIECE_BUTTERFLY = "我不能盯着这个看太久.",
        CHESSPIECE_ANCHOR = "这看起来没必要.",
        CHESSPIECE_MOON = "这是我渴望的颂歌, 我想念你，我亲爱的王.",
        CHESSPIECE_CARRAT = "族群.",
        CHESSPIECE_MALBATROSS = "噗.", -- questioned
        CHESSPIECE_CRABKING = "我讨厌被提醒你的存在.",
        CHESSPIECE_TOADSTOOL = "我讨厌被提醒你的存在.",
        CHESSPIECE_STALKER = "父亲.",
        CHESSPIECE_KLAUS = "爸爸.", -- why？
        CHESSPIECE_BEEQUEEN = "我讨厌被提醒你的存在.",
        CHESSPIECE_ANTLION = "美丽.",
        CHESSPIECE_BEEFALO = "臭.",
		CHESSPIECE_KITCOON = "恶魔成群.",
		CHESSPIECE_CATCOON = "恶魔.",
        CHESSPIECE_GUARDIANPHASE3 = "家园护卫.",
        CHESSPIECE_EYEOFTERROR = "我能说什么?",
        CHESSPIECE_TWINSOFTERROR = "为什么我听到Boss战音乐了?",

        CHESSJUNK1 = "一堆金属骨架.",
        CHESSJUNK2 = "另一堆金属骨架. ",
        CHESSJUNK3 = "更多金属骨架.",
		CHESTER = "从古至今的好伙伴.",
		CHESTER_EYEBONE =
		{
			GENERIC = "可以理解.",
			WAITING = "这个生物被冷血地谋杀了.",
		},
		COOKEDMANDRAKE = "喜欢.",
		COOKEDMEAT = "食物.",
		COOKEDMONSTERMEAT = "食物.",
		COOKEDSMALLMEAT = "小食物!",
		COOKPOT =
		{
			COOKING_LONG = "这需要很多时间.",
			COOKING_SHORT = "随时会好.",
			DONE = "完成.",
			EMPTY = "放东西进去, 拿东西出来.",
			BURNT = "有人失去了对厨房的掌控.",
		},
		CORN = "这是玉米! 丰富多汁!",
		CORN_COOKED = "想不出更棒的东西了!",
		CORN_SEEDS = "这是玉米种子.",
        CANARY =
		{
			GENERIC = "天堂之鸟.",
			HELD = "把它眼睛捏凸出来.",
		},
        CANARY_POISONED = "啐.",

		CRITTERLAB = "领养也可以.",
        CRITTER_GLOMLING = "你的名字叫阿蒙.",
        CRITTER_DRAGONLING = "你的名字叫别西卜.",
		CRITTER_LAMB = "你的名字叫巴风特.",
        CRITTER_PUPPY = "你的名字叫刻耳柏洛斯.",
        CRITTER_KITTEN = "你的名字叫阿斯蒙蒂斯.",
        CRITTER_PERDLING = "你的名字叫阿萨谢尔.",
		CRITTER_LUNARMOTHLING = "你的名字叫阿巴顿.",

		CROW =
		{
			GENERIC = "聪明的家伙.",
			HELD = "它很温暖，还在颤抖.",
		},
		CUTGRASS = "点燃它, 闻闻它.",
		CUTREEDS = "为了造纸.",
		CUTSTONE = "原始构件.",
		DEADLYFEAST = "美味.",
		DEER =
		{
			GENERIC = "这个生物能理解我.",
			ANTLER = "不错的鹿角, 介意我借一点吗?",
		},
        DEER_ANTLER = "奇妙的结构.",
        DEER_GEMMED = "它用我的战术对付我! 呀!",
		DEERCLOPS = "你好大家伙, 你丈夫还好吗?",
		DEERCLOPS_EYEBALL = "眼睛是心灵之窗.",
		EYEBRELLAHAT =	"显然无用.",
		DEPLETED_GRASS =
		{
			GENERIC = "都被温度烤枯了.",
		},
        GOGGLESHAT = "丑.",
        DESERTHAT = "要戴这个的世界也太残酷了.",
        ANTLIONHAT = "可惜我戴不上.",
		DEVTOOL = "Pachnie wołowym plackiem!", -- ？
		DEVTOOL_NODEV = "Portki mi sie spociły jak to macam.", -- ？
		DIRTPILE = "我们一起翻开它怎么样?",
		DIVININGROD =
		{
			COLD = "不在这.",
			GENERIC = "它引导我们.",
			HOT = "我能感觉到了.",
			WARM = "不错, 靠近了.",
			WARMER = "几乎到了.",
		},
		DIVININGRODBASE =
		{
			GENERIC = "真好奇.",
			READY = "它需要那根魔杖.",
			UNLOCKED = "起效了.",
		},
		DIVININGRODSTART = "魔杖会指引道路.",
		DRAGONFLY = "我想狠狠咬你一口.",
		ARMORDRAGONFLY = "疯孩子.", -- questioned
		DRAGON_SCALES = "我想知道这尝起来怎么样?",
		DRAGONFLYCHEST = "珍贵的宝藏.",
		DRAGONFLYFURNACE = 
		{
			HAMMERED = "我不认为它应该是这样的.",
			GENERIC = "能供热, 但不够亮.", --no gems
			NORMAL = "它在对我抛媚眼吗?", --one gem
			HIGH = "滚烫!", --two gems
		},
        
        HUTCH = "从古至今的好伙伴.",
        HUTCH_FISHBOWL =
        {
            GENERIC = "这个缸对那条鱼太小了, 但是也还行.",
            WAITING = "死了, 那条鱼死了, 猜猜为什么?",
        },
		LAVASPIT = 
		{
			HOT = "烫!",
			COOL = "凉了.",
		},
		LAVA_POND = "跳进去以永久放松!",
		LAVAE = "烧着呢.",
		LAVAE_COCOON = "熄灭了.",
		LAVAE_PET = 
		{
			STARVING = "挨饿之火...",
			HUNGRY = "饥饿之火.",
			CONTENT = "欢乐之火.",
			GENERIC = "珍贵之火.",
		},
		LAVAE_EGG = 
		{
			GENERIC = "温暖它.",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "冷了.",
			COMFY = "快乐的蛋.",
		},
		LAVAE_TOOTH = "它会跟上的.",

		DRAGONFRUIT = "我们以龙为食, 奢华至极.",
		DRAGONFRUIT_COOKED = "多汁的龙肉.",
		DRAGONFRUIT_SEEDS = "这是龙种.",
		DRAGONPIE = "这都称得上贡品了.",
		DRUMSTICK = "肉.",
		DRUMSTICK_COOKED = "肉.",
		DUG_BERRYBUSH = "灌木丛, 为花园准备.",
		DUG_BERRYBUSH_JUICY = "很适合花园的灌木丛.",
		DUG_GRASS = "把它给大地母亲.",
		DUG_MARSH_BUSH = "把它给大地母亲.",
		DUG_SAPLING = "把它给大地母亲.",
		DURIAN = "就是种水果.",
		DURIAN_COOKED = "我想我喜欢它.",
		DURIAN_SEEDS = "这是榴莲种子.",
		EARMUFFSHAT = "不?",
		EGGPLANT = "它粘乎乎的.",
		EGGPLANT_COOKED = "像颗蛋.",
		EGGPLANT_SEEDS = "这是茄子种子.",
		
		ENDTABLE = 
		{
			BURNT = "一个烧焦的花瓶，放在一张烧焦的茶几上.",
			GENERIC = "是大自然, 也是装饰.",
			EMPTY = "花, 放那.",
			WILTED = "美丽易逝, 就像时间一样.",
			FRESHLIGHT = "我的小夜灯.",
			OLDLIGHT = "我们在黑暗中尖叫.", -- will be wilted soon, light radius will be very small at this point
		},
		DECIDUOUSTREE = 
		{
			BURNING = "火焰, 饥饿地吞噬.",
			BURNT = "全烧焦了.",
			CHOPPED = "树桩.",
			POISON = "森林之神, 见到你真好.",
			GENERIC = "零食树.",
		},
		ACORN = "小零食?",
        ACORN_SAPLING = "种零食树拿零食.",
		ACORN_COOKED = "零食!",
		BIRCHNUTDRAKE = "坚果.",
		EVERGREEN =
		{
			BURNING = "火焰, 饥饿地吞噬.",
			BURNT = "全烧焦了.",
			CHOPPED = "树桩.",
			GENERIC = "长吧, 地表的森林.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "火焰, 饥饿地吞噬.",
			BURNT = "全烧焦了.",
			CHOPPED = "树桩.",
			GENERIC = "扩张吧, 地表的森林.",
		},
		TWIGGYTREE = 
		{
			BURNING = "火焰, 饥饿地吞噬.",
			BURNT = "全烧焦了.",
			CHOPPED = "树桩.",
			GENERIC = "弱树.",
			DISEASED = "病了.",
		},
		TWIGGY_NUT_SAPLING = "它不需要任何帮助就能长.",
        TWIGGY_OLD = "那棵树看起来很弱.",
		TWIGGY_NUT = "里面有一棵多枝的树想出来.",
		EYEPLANT = "...古怪, 但不有趣，哈哈.",
		INSPECTSELF = "Wonder, 仍在徘徊.",
		FARMPLOT =
		{
			GENERIC = "为了大地母亲的礼物.",
			GROWING = "长吧, 生命的礼物!",
			NEEDSFERTILIZER = "修好土壤.",
			BURNT = "灰?",
		},
		FEATHERHAT = "不.",
		FEATHER_CROW = "为了智慧.",
		FEATHER_ROBIN = "为了火焰.",
		FEATHER_ROBIN_WINTER = "为了战争.",
		FEATHER_CANARY = "为了恩赐.",
		FEATHERPENCIL = "铭记.",
        COOKBOOK = "不是我习惯的那种文学.",
		FEM_PUPPET = "她被困住了!",
		FIREFLIES =
		{
			GENERIC = "闪闪发光的小魂灵?",
			HELD = "它们让我的心都暖了.",
		},
		FIREHOUND = "地狱的野兽.",
		FIREPIT =
		{
			EMBERS = "拥抱温暖, 吞没死亡.",
			GENERIC = "微光.",
			HIGH = "看着光芒攀升.",
			LOW = "火焰减弱.",
			NORMAL = "它在燃烧.",
			OUT = "灭了.",
		},
		COLDFIREPIT =
		{
			EMBERS = "寒冷易忘, 生命易逝.",
			GENERIC = "微光.",
			HIGH = "看着光芒攀升.",
			LOW = "火焰减弱.",
			NORMAL = "它在燃烧.",
			OUT = "灭了.",
		},
		FIRESTAFF = "做成火炬形状的打火匣.",
		FIRESUPPRESSOR = 
		{	
			ON = "机器正在运行.",
			OFF = "机器正在休眠.",
			LOWFUEL = "燃料水平低.",
		},

		FISH = "这是种简单的水生生物.",
		FISHINGROD = "一种残忍的怀疑手段.",
		FISHSTICKS = "食物.",
		FISHTACOS = "壳很容易碎.",
		FISH_COOKED = "真野蛮.",
		FLINT = "为了做把刀.",
		FLOWER = 
		{
            GENERIC = "无辜的灵魂.",
            ROSE = "至死不渝.",
        },
        FLOWER_WITHERED = "蜷缩，然后死去.",
		FLOWERHAT = "会腐烂的.",
		FLOWER_EVIL = "这对我没用.",
		FOLIAGE = "这是种植物.",
		FOOTBALLHAT = "噫.",
        FOSSIL_PIECE = "坚固的材料, 适合用于制造.",
        FOSSIL_STALKER =
        {
			GENERIC = "少骨头了.",
			FUNNY = "拼的不对.",
			COMPLETE = "老友的模样.",
        },
        STALKER = "它还是老友的模样!",
        STALKER_ATRIUM = "你好Nyx, 老朋友.",
        STALKER_MINION = "喷发.",
        THURIBLE = "我又来找你聊天了.",
        ATRIUM_OVERGROWTH = "跑.",
		FROG =
		{
			DEAD = "不呱了.",
			GENERIC = "两栖类.",
			SLEEPING = "它的眼睛藏在头骨里.",
		},
		FROGGLEBUNWICH = "噫.",
		FROGLEGS = "噫.",
		FROGLEGS_COOKED = "噫.",
		FRUITMEDLEY = "果味的.",
		FURTUFT = "黑白的皮毛.",
		GEARS = "机械之血.",
		GHOST = "我曾以为我已经死亡.",
		GOLDENAXE = "为了谋杀者.",
		GOLDENPICKAXE = "为了岩石杀手?",
		GOLDENPITCHFORK = "这有必要.",
		GOLDENSHOVEL = "为了铲一大堆洞.",
		GOLDNUGGET = "我希望我能吃这个.",
--		GRASS =
--		{
--			BARREN = "它需要便便.",
--			WITHERED = "这么热的情况下它长不回来.",
--			BURNING = "它烧的好快!",
--			GENERIC = "这是一簇草.",
--			PICKED = "它在生命最美好的时候被收割了.",
--			DISEASED = "看起来真恶心.",
--			DISEASING = "呃, 有什么不对劲.",
--		},
--		GRASSGEKKO =
--		{
--			GENERIC = "这是一种多叶蜥蜴.",
--			DISEASED = "看起来真恶心.",
--		},
--		GREEN_CAP = "看起来很普通.",
--		GREEN_CAP_COOKED = "现在不太一样了...",
--		GREEN_MUSHROOM =
--		{
--			GENERIC = "这是个蘑菇.",
--			INGROUND = "它在睡觉.",
--			PICKED = "我想知道它还会长出来吗?",
--		},
--		GUNPOWDER = "看着像胡椒.",
--		HAMBAT = "看着不太卫生.",
--		HAMMER = "止步! 是时候! 锤东西了!",
		HEALINGSALVE = "我可以把它当抛光剂用.除此之外我没有伤口可以用它治愈.",
--		HEATROCK =
--		{
--			FROZEN = "比冰还冷.",
--			COLD = "这是块冷石头.",
--			GENERIC = "我可以控制它的温度.",
--			WARM = "对石头来说算得上温暖又可爱了!",
--			HOT = "又好又烫!",
--		},
--		HOME = "有人住在里面.",
--		HOMESIGN =
--		{
--			GENERIC = "这写着 \"你在这\".",
--            UNWRITTEN = "这上面现在是空的.",
--			BURNT = "\"别玩火.\"",
--		},
--		ARROWSIGN_POST =
--		{
--			GENERIC = "这写着 \"走那边\".",
--            UNWRITTEN = "这上面现在是空的.",
--			BURNT = "\"别玩火.\"",
--		},
--		ARROWSIGN_PANEL =
--		{
--			GENERIC = "这写着 \"走那边\".",
--            UNWRITTEN = "这上面现在是空的.",
--			BURNT = "\"别玩火.\"",
--		},
--		HONEY = "看着挺美味!",
--		HONEYCOMB = "蜜蜂曾生活在这里.",
--		HONEYHAM = "又甜又咸.",
--		HONEYNUGGETS = "尝着像鸡肉, 不过我不觉得真是.",
--		HORN = "听起来像有个皮弗洛牛场.",
--		HOUND = "你什么都不是, 猎犬!",
		HOUNDCORPSE =
		{
			--GENERIC = "气味不太好闻.",
			--BURNING = "我想我们现在安全了.",
			REVIVING = "无尽的悲剧!",
		},
--		HOUNDBONE = "吓人.",
--		HOUNDMOUND = "我和巢主没什么可谈的. 真的.",
--		ICEBOX = "我已经驾驭了寒冷的力量!",
--		ICEHAT = "保持凉爽, 小子.",
--		ICEHOUND = "每个季节都有种猎犬吗?",
--		INSANITYROCK =
--		{
--			ACTIVE = "尝尝这个, 自我恢复!",
--			INACTIVE = "比起方尖碑这更像个金字塔.",
--		},
--		JAMMYPRESERVES = "也许该做个罐子.",
--
--		KABOBS = "棍子上的午餐.",
--		KILLERBEE =
--		{
--			GENERIC = "哦不! 是杀人蜂!",
--			HELD = "这看着很危险.",
--		},
--		KNIGHT = "看看这个!",
--		KOALEFANT_SUMMER = "又可爱又美味.",
--		KOALEFANT_WINTER = "它看起来温暖且多肉.",
--		KRAMPUS = "它在偷我的东西!",
--		KRAMPUS_SACK = "噫. 它上面全是坎普斯的粘液.",
--		LEIF = "它好大!",
--		LEIF_SPARSE = "它好大!",
--		LIGHTER  = "这是她的幸运打火机.",
--		LIGHTNING_ROD =
--		{
--			CHARGED = "力量为我所用!",
--			GENERIC = "驾驭天空!",
--		},
--		LIGHTNINGGOAT =
--		{
--			GENERIC = "电你自己去!",
--			CHARGED = "我觉得它不喜欢被闪电击中.",
--		},
--		LIGHTNINGGOATHORN = "它就像个微型避雷针.",
--		GOATMILK = "充满美味!",
--		LITTLE_WALRUS = "它不会永远那么可爱的.",
--		LIVINGLOG = "它看起来很忧心.",
--		LOG =
--		{
--			BURNING = "That's some hot wood!",
--			GENERIC = "It's big, it's heavy, and it's wood.",
--		},
--		LUCY = "That's a prettier axe than I'm used to.",
--		LUREPLANT = "It's so alluring.",
--		LUREPLANTBULB = "Now I can start my very own meat farm.",
--		MALE_PUPPET = "He's trapped!",
--
--		MANDRAKE_ACTIVE = "Cut it out!",
--		MANDRAKE_PLANTED = "I've heard strange things about those plants.",
--		MANDRAKE = "Mandrake roots have strange properties.",
--
--        MANDRAKESOUP = "Well, he won't be waking up again.",
--        MANDRAKE_COOKED = "It doesn't seem so strange anymore.",
--        MAPSCROLL = "A blank map. Doesn't seem very useful.",
--        MARBLE = "Fancy!",
--        MARBLEBEAN = "I traded the old family cow for it.",
--        MARBLEBEAN_SAPLING = "It looks carved.",
--        MARBLESHRUB = "Makes sense to me.",
--        MARBLEPILLAR = "I think I could use that.",
--        MARBLETREE = "I don't think an axe will cut it.",
--        MARSH_BUSH =
--        {
--			BURNT = "One less thorn patch to worry about.",
--            BURNING = "That's burning fast!",
--            GENERIC = "It looks thorny.",
--            PICKED = "Ouch.",
--        },
--        BURNT_MARSH_BUSH = "It's 全烧焦了 up.",
--        MARSH_PLANT = "It's a plant.",
--        MARSH_TREE =
--        {
--            BURNING = "Spikes and fire!",
--            BURNT = "Now it's burnt and spiky.",
--            CHOPPED = "Not so spiky now!",
--            GENERIC = "Those spikes look sharp!",
--        },
--        MAXWELL = "I hate that guy.",
--        MAXWELLHEAD = "I can see into his pores.",
--        MAXWELLLIGHT = "I wonder how they work.",
--        MAXWELLLOCK = "Looks almost like a key hole.",
--        MAXWELLTHRONE = "That doesn't look very comfortable.",
--        MEAT = "It's a bit gamey, but it'll do.",
--        MEATBALLS = "It's just a big wad of meat.",
        MEATRACK =
        {
            --DONE = "Jerky time!",
            --DRYING = "Meat takes a while to dry.",
            --DRYINGINRAIN = "Meat takes even longer to dry in rain.",
            --GENERIC = "I should dry some meats.",
            --BURNT = "The rack got dried.",
            --DONE_NOTMEAT = "In laboratory terms, we would call that \"dry\".",
            DRYING_NOTMEAT = "晒东西.",
            --DRYINGINRAIN_NOTMEAT = "Rain, rain, go away. Be wet again another day.",
        },
--        MEAT_DRIED = "Just jerky enough.",
--        MERM = "Smells fishy!",
--        MERMHEAD =
--        {
--            GENERIC = "The stinkiest thing I'll smell all day.",
--            BURNT = "Burnt merm flesh somehow smells even worse.",
--        },
--        MERMHOUSE =
--        {
--            GENERIC = "Who would live here?",
--            BURNT = "Nothing to live in, now.",
--        },
--        MINERHAT = "A hands-free way to brighten your day.",
--        MONKEY = "Curious little guy.",
--        MONKEYBARREL = "Did that just move?",
        MONSTERLASAGNA = "美味?",
--        FLOWERSALAD = "A bowl of foliage.",
--        ICECREAM = "I scream for ice cream!",
--        WATERMELONICLE = "Cryogenic watermelon.",
--        TRAILMIX = "A healthy, natural snack.",
--        HOTCHILI = "Five alarm!",
--        GUACAMOLE = "Avogadro's favorite dish.",
--        MONSTERMEAT = "Ugh. I don't think I should eat that.",
--        MONSTERMEAT_DRIED = "Strange-smelling jerky.",
--        MOOSE = "I don't exactly know what that thing is.",
--        MOOSE_NESTING_GROUND = "It puts its babies there.",
--        MOOSEEGG = "The babies are like excited electrons trying to escape.",
--        MOSSLING = "Aaah! You are definitely not an electron!",
--        FEATHERFAN = "Down, to bring the temperature down.",
--        MINIFAN = "Somehow the breeze comes out the back twice as fast.",
--        GOOSE_FEATHER = "Fluffy!",
--        STAFF_TORNADO = "Spinning doom.",
--        MOSQUITO =
--        {
--            GENERIC = "Disgusting little bloodsucker.",
--            HELD = "Hey, is that my blood?",
--        },
--        MOSQUITOSACK = "It's probably someone else's blood...",
--        MOUND =
--        {
--            DUG = "He probably deserved it.",
--            GENERIC = "I bet there's all sorts of good stuff down there!",
--        },
--        NIGHTLIGHT = "It gives off a spooky light.",
--        NIGHTMAREFUEL = "Tears of madness.",
--        NIGHTSWORD = "Edge of the night.",
--        NITRE = "More minerals.",
--        ONEMANBAND = "We should add a beefalo bell.",
--        OASISLAKE =
--		{
--			GENERIC = "Is that a mirage?",
--			EMPTY = "It's dry as a bone.",
--		},
--        PANDORASCHEST = "It may contain something fantastic! Or horrible.",
--        PANFLUTE = "To serenade the animals.",
--        PAPYRUS = "Some sheets of paper.",
--        WAXPAPER = "Some sheets of wax paper.",
--        PENGUIN = "Must be breeding season.",
--        PERD = "Stupid bird! Stay away from those berries!",
--        PEROGIES = "These turned out pretty good.",
--        PETALS = "Sure showed those flowers who's boss!",
--        PETALS_EVIL = "I'm not sure I want to hold those.",
--        PHLEGM = "It's thick and pliable. And salty.",
--        PICKAXE = "Iconic, isn't it?",
--        PIGGYBACK = "This little piggy's gone... \"home\".",
--        PIGHEAD =
--        {
--            GENERIC = "Looks like an offering to the beast.",
--            BURNT = "Crispy.",
--        },
--        PIGHOUSE =
--        {
--            FULL = "I can see a snout pressed up against the window.",
--            GENERIC = "These pigs have pretty fancy houses.",
--            LIGHTSOUT = "Come ON! I know you're home!",
--            BURNT = "Not so fancy now, pig!",
--        },
--        PIGKING = "Ewwww, he smells!",
--        PIGMAN =
--        {
--            DEAD = "Someone should tell its family.",
--            FOLLOWER = "You're part of my entourage.",
--            GENERIC = "They kind of creep me out.",
--            GUARD = "Looks serious.",
--            WEREPIG = "Not a friendly pig!!",
--        },
--        PIGSKIN = "It still has the tail on it.",
--        PIGTENT = "Smells like bacon.",
--        PIGTORCH = "Sure looks cozy.",
--        PINECONE = "I can hear a tiny tree inside it, trying to get out.",
--        PINECONE_SAPLING = "It'll be a tree soon!",
--        LUMPY_SAPLING = "How did this tree even reproduce?",
--        PITCHFORK = "Now I just need an angry mob to join.",
--        PLANTMEAT = "That doesn't look very appealing.",
--        PLANTMEAT_COOKED = "At least it's warm now.",
--        PLANT_NORMAL =
--        {
--            GENERIC = "Leafy!",
--            GROWING = "Guh! It's growing so slowly!",
--            READY = "Mmmm. Ready to harvest.",
--            WITHERED = "The heat killed it.",
--        },
--        POMEGRANATE = "It looks like the inside of an alien's brain.",
--        POMEGRANATE_COOKED = "Haute Cuisine!",
--        POMEGRANATE_SEEDS = "It's a pome-whatsit seed.",
--        POND = "I can't see the bottom!",
--        POOP = "I should fill my pockets!",
--        FERTILIZER = "That is definitely a bucket full of poop.",
--        PUMPKIN = "It's as big as my head!",
--        PUMPKINCOOKIE = "That's a pretty gourd cookie!",
--        PUMPKIN_COOKED = "How did it not turn into a pie?",
--        PUMPKIN_LANTERN = "Nice face you have.",
--        PUMPKIN_SEEDS = "It's a pumpkin seed.",
--        PURPLEAMULET = "It's whispering nonsense.",
--        PURPLEGEM = "Madness in a glass prison.",
--        RABBIT =
--        {
--            GENERIC = "He's looking for carrots.",
--            HELD = "Do you like pets?",
--        },
--        RABBITHOLE =
--        {
--            GENERIC = "That must lead to the Kingdom of the Bunnymen.",
--            SPRING = "The Kingdom of the Bunnymen is closed for the season.",
--        },
--        RAINOMETER =
--        {
--            GENERIC = "It measures cloudiness.",
--            BURNT = "The measuring parts went up in a cloud of smoke.",
--        },
--        RAINCOAT = "Keeps the rain where it ought to be. Outside your body.",
--        RAINHAT = "Nuh-uh.",
--        RATATOUILLE = "An excellent source of fiber.",
--        RAZOR = "A sharpened rock tied to a stick. For hygiene!",
--        REDGEM = "It sparkles with inner warmth.",
--        RED_CAP = "It smells funny.",
--        RED_CAP_COOKED = "It's different now...",
--        RED_MUSHROOM =
--        {
--            GENERIC = "这是个蘑菇.",
--            INGROUND = "它在睡觉.",
--            PICKED = "我想知道它还会长出来吗?",
--        },
--        REEDS =
--        {
--            BURNING = "That's really burning!",
--            GENERIC = "It's a clump of reeds.",
--            PICKED = "All the useful reeds have already been picked.",
--        },
--        RELIC = "Ancient household goods.",
--        RUINS_RUBBLE = "This can be fixed.",
--        RUBBLE = "Just bits and pieces of rock.",
--        RESEARCHLAB =
--        {
--            GENERIC = "It breaks down objects into their components.",
--            BURNT = "Gone.",
--        },
--        RESEARCHLAB2 =
--        {
--            GENERIC = "It's even more science-y than the last one!",
--            BURNT = "Gone.",
--        },
--        RESEARCHLAB3 =
--        {
--            GENERIC = "I didn't know I would have to look at it again.",
--            BURNT = "Gone.",
--        },
--        RESEARCHLAB4 =
--        {
--            GENERIC = "Pathetic magic tricks. They do not know our ways.",
--            BURNT = "Gone.",
--        },
--        RESURRECTIONSTATUE =
--        {
--            GENERIC = "What a handsome devil!",
--            BURNT = "Not much use anymore.",
--        },
--        RESURRECTIONSTONE = "It's always a good idea to touch base.",
--        ROBIN =
--        {
--            GENERIC = "Does that mean winter is gone?",
--            HELD = "He likes my pocket.",
--        },
--        ROBIN_WINTER =
--        {
--            GENERIC = "Life in the frozen wastes.",
--            HELD = "It's so soft.",
--        },
--        ROBOT_PUPPET = "They're trapped!",
--        ROCK_LIGHT =
--        {
--            GENERIC = "A crusted over lava pit.",
--            OUT = "Looks fragile.",
--            LOW = "The lava's crusting over.",
--            NORMAL = "Nice and comfy.",
--        },
--        CAVEIN_BOULDER =
--        {
--            GENERIC = "I think I can lift this one.",
--            RAISED = "It's out of reach.",
--        },
--        ROCK = "It wouldn't fit in my pocket.",
--        PETRIFIED_TREE = "It looks scared stiff.",
--        ROCK_PETRIFIED_TREE = "It looks scared stiff.",
--        ROCK_PETRIFIED_TREE_OLD = "It looks scared stiff.",
--        ROCK_ICE =
--        {
--            GENERIC = "Ice to meet you.",
--            MELTED = "Won't be useful until it freezes again.",
--        },
--        ROCK_ICE_MELTED = "Won't be useful until it freezes again.",
--        ICE = "Ice to meet you.",
--        ROCKS = "We could make stuff with these.",
--        ROOK = "Storm the castle!",
--        ROPE = "Some short lengths of rope.",
--        ROTTENEGG = "噫! It stinks!",
--        ROYAL_JELLY = "Flavourful.",
--        JELLYBEAN = "One part jelly, one part bean.",
--        SADDLE_BASIC = "That'll allow the mounting of some smelly animal.",
--        SADDLE_RACE = "This saddle really flies!",
--        SADDLE_WAR = "The only problem is the saddle sores.",
--        SADDLEHORN = "This could take a saddle off.",
--        SALTLICK = "How many licks does it take to get to the center?",
--        BRUSH = "I bet the beefalo really like this.",
--		SANITYROCK =
--		{
--			ACTIVE = "That's a CRAZY looking rock!",
--			INACTIVE = "Where did the rest of it go?",
--		},
--		SAPLING =
--		{
--			BURNING = "That's burning fast!",
--			WITHERED = "It might be okay if it cooled down.",
--			GENERIC = "Baby trees are so cute!",
--			PICKED = "That'll teach him.",
--			DISEASED = "It looks pretty sick.",
--			DISEASING = "Err, something's not right.",
--		},
--   		SCARECROW =
--   		{
--			GENERIC = "All dressed up and no where to crow.",
--			BURNING = "Someone made that strawman eat crow.",
--			BURNT = "Someone MURDERed that scarecrow!",
--   		},
--   		SCULPTINGTABLE=
--   		{
--			EMPTY = "We can make stone sculptures with this.",
--			BLOCK = "Ready for sculpting.",
--			SCULPTURE = "A masterpiece!",
--			BURNT = "Burnt right down.",
--   		},
--        SCULPTURE_KNIGHTHEAD = "Where's the rest of it?",
--		SCULPTURE_KNIGHTBODY =
--		{
--			COVERED = "It's an odd marble statue.",
--			UNCOVERED = "I guess he cracked under the pressure.",
--			FINISHED = "At least it's back in one piece now.",
--			READY = "Something's moving inside.",
--		},
--        SCULPTURE_BISHOPHEAD = "Is that a head?",
--		SCULPTURE_BISHOPBODY =
--		{
--			COVERED = "It looks old, but it feels new.",
--			UNCOVERED = "There's a big piece missing.",
--			FINISHED = "Now what?",
--			READY = "Something's moving inside.",
--		},
--        SCULPTURE_ROOKNOSE = "Where did this come from?",
--		SCULPTURE_ROOKBODY =
--		{
--			COVERED = "It's some sort of marble statue.",
--			UNCOVERED = "It's not in the best shape.",
--			FINISHED = "All patched up.",
--			READY = "Something's moving inside.",
--		},
--        GARGOYLE_HOUND = "I don't like how it's looking at me.",
--        GARGOYLE_WEREPIG = "It looks very lifelike.",
--		SEEDS = "Each one is a tiny mystery.",
--		SEEDS_COOKED = "That cooked the life right out of 'em!",
--		SEWING_KIT = "Darn it! Darn it all to heck!",
--		SEWING_TAPE = "Good for mending.",
--		SHOVEL = "There's a lot going on underground.",
--		SILK = "It comes from a spider's butt.",
--		SKELETON = "Better you than me.",
--		SCORCHED_SKELETON = "Spooky.",
--		SKULLCHEST = "I'm not sure if I want to open it.",
--		SMALLBIRD =
--		{
--			GENERIC = "That's a rather small bird.",
--			HUNGRY = "It looks hungry.",
--			STARVING = "It must be starving.",
--			SLEEPING = "It's barely making a peep.",
--		},
--		SMALLMEAT = "A tiny chunk of dead animal.",
--		SMALLMEAT_DRIED = "A little jerky.",
--		SPAT = "What a crusty looking animal.",
        SPEAR = "原始的工具, 你会用吗?",
        SPEAR_WATHGRITHR = "这是件小小的舞台道具.",
        WATHGRITHRHAT = "边缘有点粗糙.",
--		SPIDER =
--		{
--			DEAD = "Ewwww!",
--			GENERIC = "I hate spiders.",
--			SLEEPING = "I'd better not be here when he wakes up.",
--		},
--		SPIDERDEN = "Sticky!",
--		SPIDEREGGSACK = "I hope these don't hatch. Period.",
--		SPIDERGLAND = "It has a tangy, antiseptic smell.",
--		SPIDERHAT = "I hope I got all of the spider goo out of it.",
--		SPIDERQUEEN = "AHHHHHHHH! That spider is huge!",
--		SPIDER_WARRIOR =
--		{
--			DEAD = "Good riddance!",
--			GENERIC = "Looks even meaner than usual.",
--			SLEEPING = "I should keep my distance.",
--		},
		SPOILED_FOOD = "腐坏.",
        STAGEHAND =
        {
			AWAKE = "向光而舞.",
			HIDING = "布制茶几，死味萦绕.",
        },
--        STATUE_MARBLE =
--        {
--            GENERIC = "It's a fancy marble statue.",
--            TYPE1 = "Don't lose your head now!",
--            TYPE2 = "Statuesque.",
--            TYPE3 = "I wonder who the artist is.", --bird bath type statue
--        },
--		STATUEHARP = "What happened to the head?",
--		STATUEMAXWELL = "He's a lot shorter in person.",
--		STEELWOOL = "Scratchy metal fibers.",
--		STINGER = "Looks sharp!",
		STRAWHAT = "农民用品.",
--		STUFFEDEGGPLANT = "It's really stuffing!",
--		SWEATERVEST = "This vest is dapper as all get-out.",
--		REFLECTIVEVEST = "Keep off, evil sun!",
--		HAWAIIANSHIRT = "Atrocious...",
--		TAFFY = "If I had a dentist they'd be mad I ate stuff like that.",
--		TALLBIRD = "That's a tall bird!",
--		TALLBIRDEGG = "Will it hatch?",
--		TALLBIRDEGG_COOKED = "Delicious and nutritious.",
--		TALLBIRDEGG_CRACKED =
--		{
--			COLD = "Is it shivering or am I?",
--			GENERIC = "Looks like it's hatching!",
--			HOT = "Are eggs supposed to sweat?",
--			LONG = "I have a feeling this is going to take a while...",
--			SHORT = "It should hatch any time now.",
--		},
--		TALLBIRDNEST =
--		{
--			GENERIC = "That's quite an egg!",
--			PICKED = "The nest is empty.",
--		},
--		TEENBIRD =
--		{
--			GENERIC = "Not a very tall bird.",
--			HUNGRY = "You need some food and quick, huh?",
--			STARVING = "It has a dangerous look in its eye.",
--			SLEEPING = "It's getting some shut-eye.",
--		},
--		TELEPORTATO_BASE =
--		{
--			ACTIVE = "With this I can surely pass through space and time!",
--			GENERIC = "This appears to be a nexus to another world!",
--			LOCKED = "There's still something missing.",
--			PARTIAL = "Soon, the invention will be complete!",
--		},
--		TELEPORTATO_BOX = "This may control the polarity of the whole universe.",
--		TELEPORTATO_CRANK = "Crank.",
--		TELEPORTATO_POTATO = "This metal potato contains great and fearful power...",
--		TELEPORTATO_RING = "A ring that could focus dimensional energies.",
--		TELESTAFF = "Whole new perspective.",
--		TENT =
--		{
--			GENERIC = "I get sort of crazy when I don't sleep.",
--			BURNT = "Nothing left to sleep in.",
--		},
--		SIESTAHUT =
--		{
--			GENERIC = "A nice place for an afternoon rest, safely out of the heat.",
--			BURNT = "It won't provide much shade now.",
--		},
		TENTACLE = "请别再来一次了.",
        TENTACLESPIKE = "恶心但结实.",
        TENTACLESPOTS = "敌人的皮肤.",
        TENTACLE_PILLAR = "我看过更大的.",
        TENTACLE_PILLAR_HOLE = "前路唯上? 还是向下?.",
        TENTACLE_PILLAR_ARM = "恐惧小不点们的怒火吧.",
        TENTACLE_GARDEN = "我看过更大的.",
		TOPHAT = "农民用品.",
        TORCH = "握住余光.",
        TRANSISTOR = "原始的发明.",
--		TRAP = "I wove it real tight.",
		TRAP_TEETH = "有时候最蠢的主意也能有用.",
--		TRAP_TEETH_MAXWELL = "I'll want to avoid stepping on that!",
		TREASURECHEST =
		{
            GENERIC = "污泥与财富, 就是大海的腥臭.",
            BURNT = "真浪费.",
		},
--		TREASURECHEST_TRAP = "How convenient!",
--		SACRED_CHEST =
--		{
--			GENERIC = "I hear whispers. It wants something.",
--			LOCKED = "It's passing its judgment.",
--		},
--		TREECLUMP = "It's almost like someone is trying to prevent me from going somewhere.",
--
--		TRINKET_1 = "Melted. Maybe Willow had some fun with them?", --Melted Marbles
--		TRINKET_2 = "What's kazoo with you?", --Fake Kazoo
--		TRINKET_3 = "The knot is stuck. Forever.", --Gord's Knot
--		TRINKET_4 = "It must be some kind of religious artifact.", --Gnome
--		TRINKET_5 = "Sadly it's too small for me to escape on.", --Toy Rocketship
--		TRINKET_6 = "Their electricity carrying days are over.", --Frazzled Wires
--		TRINKET_7 = "There's no time for fun and games!", --Ball and Cup
--		TRINKET_8 = "Great. All of my tub stopping needs are met.", --Rubber Bung
--		TRINKET_9 = "I'm more of a zipper person, myself.", --Mismatched Buttons
--		TRINKET_10 = "They've quickly become Wes' favorite prop.", --Dentures
--		TRINKET_11 = "Hal whispers beautiful lies to me.", --Lying Robot
--		TRINKET_12 = "It's soft.", --Dessicated Tentacle
--		TRINKET_13 = "It must be some kind of religious artifact.", --Gnomette
--		TRINKET_14 = "Now if I only had some tea...", --Leaky Teacup
--		TRINKET_15 = "...Maxwell left his stuff out again.", --Pawn
--		TRINKET_16 = "...Maxwell left his stuff out again.", --Pawn
--		TRINKET_17 = "A horrifying utensil fusion.", --Bent Spork
--		TRINKET_18 = "I wonder what it's hiding?", --Trojan Horse
--		TRINKET_19 = "It doesn't spin very well.", --Unbalanced Top
--		TRINKET_20 = "Wigfrid keeps jumping out and hitting me with it?!", --Backscratcher
--		TRINKET_21 = "This egg beater is all bent out of shape.", --Egg Beater
--		TRINKET_22 = "I have a weird feeling of putting this in my eye socket.", --Frayed Yarn
--		TRINKET_23 = "I can put my shoes on without help, thanks.", --Shoehorn
--		TRINKET_24 = "I think Wickerbottom had a cat.", --Lucky Cat Jar
--		TRINKET_25 = "It smells kind of stale.", --Air Unfreshener
--		TRINKET_26 = "Food and a cup! The ultimate survival container.", --Potato Cup
--		TRINKET_27 = "If you unwound it you could poke someone from really far away.", --Coat Hanger
--		TRINKET_28 = "How Machiavellian.", --Rook
--        TRINKET_29 = "How Machiavellian.", --Rook
--        TRINKET_30 = "Honestly, he just leaves them out wherever.", --Knight
--        TRINKET_31 = "Honestly, he just leaves them out wherever.", --Knight
--        TRINKET_32 = "I know someone who'd have a ball with this!", --Cubic Zirconia Ball
--        TRINKET_33 = "I hope this doesn't attract spiders.", --Spider Ring
--        TRINKET_34 = "Let's make a wish.", --Monkey Paw
--        TRINKET_35 = "Hard to find a good flask around here.", --Empty Elixir
--        TRINKET_36 = "I might need these after all that candy.", --Faux fangs
--        TRINKET_37 = "Rumors.", --Broken Stake
--        TRINKET_38 = "I think it came from another world. One with grifts.", -- Binoculars Griftlands trinket
--        TRINKET_39 = "I wonder where the other one is?", -- Lone Glove Griftlands trinket
--        TRINKET_40 = "Holding it makes me feel like bartering.", -- Snail Scale Griftlands trinket
--        TRINKET_41 = "It's a little warm to the touch.", -- Goop Canister Hot Lava trinket
--        TRINKET_42 = "It's full of someone's childhood memories.", -- Toy Cobra Hot Lava trinket
--        TRINKET_43= "It's not very good at jumping.", -- Crocodile Toy Hot Lava trinket
--        TRINKET_44 = "It's some sort of plant specimen.", -- Broken Terrarium ONI trinket
--        TRINKET_45 = "It's picking up frequencies from another world.", -- Odd Radio ONI trinket
--        TRINKET_46 = "Maybe a tool for testing aerodynamics?", -- Hairdryer ONI trinket
--
--        -- The numbers align with the trinket numbers above.
--        LOST_TOY_1  = "Lost memories.",
--        LOST_TOY_2  = "Lost memories.",
--        LOST_TOY_7  = "Lost memories.",
--        LOST_TOY_10 = "Lost memories.",
--        LOST_TOY_11 = "Lost memories.",
--        LOST_TOY_14 = "Lost memories.",
--        LOST_TOY_18 = "Lost memories.",
--        LOST_TOY_19 = "Lost memories.",
--        LOST_TOY_42 = "Lost memories.",
--        LOST_TOY_43 = "Lost memories.",
--
--        HALLOWEENCANDY_1 = "The cavities are probably worth it, right?",
--        HALLOWEENCANDY_2 = "What?",
--        HALLOWEENCANDY_3 = "It's... corn.",
--        HALLOWEENCANDY_4 = "They wriggle on the way down.",
--        HALLOWEENCANDY_5 = "My teeth are going to have something to say about this tomorrow.",
--        HALLOWEENCANDY_6 = "I... don't think I'll be eating those.",
--        HALLOWEENCANDY_7 = "Everyone'll be raisin' a fuss over these.",
--        HALLOWEENCANDY_8 = "Only a sucker wouldn't love this.",
--        HALLOWEENCANDY_9 = "Sticks to your teeth.",
--        HALLOWEENCANDY_10 = "Only a sucker wouldn't love this.",
--        HALLOWEENCANDY_11 = "Much better tasting than the real thing.",
--        HALLOWEENCANDY_12 = "Did that candy just move?", --ONI meal lice candy
--        HALLOWEENCANDY_13 = "Oh, my poor jaw.", --Griftlands themed candy
--        HALLOWEENCANDY_14 = "I don't do well with spice.", --Hot Lava pepper candy
--        CANDYBAG = "It's some sort of delicious pocket dimension for sugary treats.",
--
--		HALLOWEEN_ORNAMENT_1 = "A spectornament I could hang in a tree.",
--		HALLOWEEN_ORNAMENT_2 = "Completely batty decoration.",
--		HALLOWEEN_ORNAMENT_3 = "This wood look good hanging somewhere.",
--		HALLOWEEN_ORNAMENT_4 = "Almost i-tentacle to the real ones.",
--		HALLOWEEN_ORNAMENT_5 = "Eight-armed adornment.",
--		HALLOWEEN_ORNAMENT_6 = "Everyone's raven about tree decorations these days.",
--
--		HALLOWEENPOTION_DRINKS_WEAK = "I was hoping for something bigger.",
--		HALLOWEENPOTION_DRINKS_POTENT = "A potent potion.",
--        HALLOWEENPOTION_BRAVERY = "Full of grit.",
--		HALLOWEENPOTION_MOON = "Infused with transforming such-and-such.",
--		HALLOWEENPOTION_FIRE_FX = "Crystallized inferno.",
--		MADSCIENCE_LAB = "Sanity is a small price.",
--		LIVINGTREE_ROOT = "Something's in there! I'll have to root it out.",
--		LIVINGTREE_SAPLING = "It'll grow up big and horrifying.",
--
        DRAGONHEADHAT = "节日兽装.",
        DRAGONBODYHAT = "节日兽装.",
        DRAGONTAILHAT = "节日兽装.",
--        PERDSHRINE =
--        {
--            GENERIC = "I feel like it wants something.",
--            EMPTY = "I've got to plant something there.",
--            BURNT = "That won't do at all.",
--        },
--        REDLANTERN = "This lantern feels more special than the others.",
--        LUCKY_GOLDNUGGET = "What a lucky find!",
        FIRECRACKERS = "喜庆又危险.",
--        PERDFAN = "It's inordinately large.",
--        REDPOUCH = "Is there something inside?",
--        WARGSHRINE =
--        {
--            GENERIC = "I should make something fun.",
--            EMPTY = "I need to put a torch in it.",
--            BURNING = "I should make something fun.", --for willow to override
--            BURNT = "It burned down.",
--        },
        CLAYWARG =
        {
        	GENERIC = "美丽的造物，动起来更壮观了",
        	STATUE = "它刚刚是不是动了?",
        },
        CLAYHOUND =
        {
            GENERIC = "喉部的细节着实吸引了我的注意.",
            STATUE = "纹理非常不错.",
        },
        HOUNDWHISTLE = "这是演奏用的吗.",
--        CHESSPIECE_CLAYHOUND = "That thing's the leashed of my worries.",
--        CHESSPIECE_CLAYWARG = "And I didn't even get eaten!",
--
--		PIGSHRINE =
--		{
--            GENERIC = "More stuff to make.",
--            EMPTY = "It's hungry for meat.",
--            BURNT = "Burnt out.",
--		},
--		PIG_TOKEN = "This looks important.",
--		PIG_COIN = "This'll pay off in a fight.",
--		YOTP_FOOD1 = "A feast fit for me.",
--		YOTP_FOOD2 = "A meal only a beast would love.",
--		YOTP_FOOD3 = "Nothing fancy.",
--
--		PIGELITE1 = "What are you looking at?", --BLUE
--		PIGELITE2 = "He's got gold fever!", --RED
--		PIGELITE3 = "Here's mud in your eye!", --WHITE
--		PIGELITE4 = "Wouldn't you rather hit someone else?", --GREEN
--
--		PIGELITEFIGHTER1 = "What are you looking at?", --BLUE
--		PIGELITEFIGHTER2 = "He's got gold fever!", --RED
--		PIGELITEFIGHTER3 = "Here's mud in your eye!", --WHITE
--		PIGELITEFIGHTER4 = "Wouldn't you rather hit someone else?", --GREEN
--
--		CARRAT_GHOSTRACER = "That's... disconcerting.",
--
--        YOTC_CARRAT_RACE_START = "It's a good enough place to start.",
--        YOTC_CARRAT_RACE_CHECKPOINT = "You've made your point.",
--        YOTC_CARRAT_RACE_FINISH =
--        {
--            GENERIC = "It's really more of a finish circle than a line.",
--            BURNT = "It's all gone up in flames!",
--            I_WON = "Ha HA!",
--            SOMEONE_ELSE_WON = "Sigh... congratulations, {winner}.",
--        },
--
--		YOTC_CARRAT_RACE_START_ITEM = "Well, it's a start.",
--        YOTC_CARRAT_RACE_CHECKPOINT_ITEM = "That checks out.",
--		YOTC_CARRAT_RACE_FINISH_ITEM = "The end's in sight.",
--
--		YOTC_SEEDPACKET = "Looks pretty seedy, if you ask me.",
--		YOTC_SEEDPACKET_RARE = "Hey there, fancy-plants!",
--
--		MINIBOATLANTERN = "How illuminating!",
--
--        YOTC_CARRATSHRINE =
--        {
--            GENERIC = "What to make...",
--            EMPTY = "Hm... what does a carrat like to eat?",
--            BURNT = "Smells like roasted carrots.",
--        },
--
--        YOTC_CARRAT_GYM_DIRECTION =
--        {
--            GENERIC = "This'll get things moving in the right direction.",
--            RAT = "You would make an excellent lab rat.",
--            BURNT = "My training regimen crashed and burned.",
--        },
--        YOTC_CARRAT_GYM_SPEED =
--        {
--            GENERIC = "I need to get my carrat up to speed.",
--            RAT = "Faster... faster!",
--            BURNT = "I may have overdone it.",
--        },
--        YOTC_CARRAT_GYM_REACTION =
--        {
--            GENERIC = "Let's train those carrat-like reflexes!",
--            RAT = "The subject's response time is steadily improving!",
--            BURNT = "...",
--        },
--        YOTC_CARRAT_GYM_STAMINA =
--        {
--            GENERIC = "Getting strong now!",
--            RAT = "This carrat... will be unstoppable!!",
--            BURNT = "You can't stop progress! But this will delay it...",
--        },
--
--        YOTC_CARRAT_GYM_DIRECTION_ITEM = "I'd better get training!",
--        YOTC_CARRAT_GYM_SPEED_ITEM = "I'd better get this assembled.",
--        YOTC_CARRAT_GYM_STAMINA_ITEM = "This should help improve my carrat's stamina.",
--        YOTC_CARRAT_GYM_REACTION_ITEM = "This should improve my carrat's reaction time considerably.",
--
--        YOTC_CARRAT_SCALE_ITEM = "This will help car-rate my car-rat.",
--        YOTC_CARRAT_SCALE =
--        {
--            GENERIC = "Hopefully the scales tip in my favor.",
--            CARRAT = "I suppose no matter what, it's still just a sentient vegetable.",
--            CARRAT_GOOD = "This carrat looks ripe for racing!",
--            BURNT = "What a mess.",
--        },
--
--        YOTB_BEEFALOSHRINE =
--        {
--            GENERIC = "What to make...",
--            EMPTY = "Hm... what makes a beefalo?",
--            BURNT = "Smells like barbeque.",
--        },
--
--        BEEFALO_GROOMER =
--        {
--            GENERIC = "There's no beefalo here to groom.",
--            OCCUPIED = "Let's beautify this beefalo!",
--            BURNT = "I styled my beefalo in the hottest fashions... and paid the price.",
--        },
--        BEEFALO_GROOMER_ITEM = "I'd better set this up somewhere.",
--
		BISHOP_CHARGE_HIT = "几乎不可能躲开!",
--		TRUNKVEST_SUMMER = "Wilderness casual.",
--		TRUNKVEST_WINTER = "Winter survival gear.",
--		TRUNK_COOKED = "Somehow even more nasal than before.",
--		TRUNK_SUMMER = "A light breezy trunk.",
--		TRUNK_WINTER = "A thick, hairy trunk.",
--		TUMBLEWEED = "Who knows what that tumbleweed has picked up.",
--		TURKEYDINNER = "Mmmm.",
--		TWIGS = "It's a bunch of small twigs.",
--		UMBRELLA = "I always hate when I'm wet.",
--		GRASS_UMBRELLA = "Eh.",
--		UNIMPLEMENTED = "It doesn't look finished! It could be dangerous.",
--		WAFFLES = "I'm waffling on whether it needs more syrup.",
--		WALL_HAY =
--		{
--			GENERIC = "Hmmmm. I guess that'll have to do.",
--			BURNT = "That won't do at all.",
--		},
--		WALL_HAY_ITEM = "This seems like a bad idea.",
--		WALL_STONE = "That's a nice wall.",
--		WALL_STONE_ITEM = "They make me feel so safe.",
--		WALL_RUINS = "An ancient piece of wall.",
		WALL_RUINS_ITEM = "看看这些细节.",
--		WALL_WOOD =
--		{
--			GENERIC = "Pointy!",
--			BURNT = "Burnt!",
--		},
--		WALL_WOOD_ITEM = "Pickets!",
--		WALL_MOONROCK = "Spacey and smooth!",
--		WALL_MOONROCK_ITEM = "Very light, but surprisingly tough.",
--		FENCE = "It's just a wood fence.",
--        FENCE_ITEM = "All we need to build a nice, sturdy fence.",
--        FENCE_GATE = "It opens. And closes sometimes, too.",
--        FENCE_GATE_ITEM = "All we need to build a nice, sturdy gate.",
--		WALRUS = "Walruses are natural predators.",
		WALRUSHAT = "温暖的编织品.",
--		WALRUS_CAMP =
--		{
--			EMPTY = "Looks like somebody was camping here.",
--			GENERIC = "It looks warm and cozy inside.",
--		},
--		WALRUS_TUSK = "I'm sure I'll find a use for it eventually.",
--		WARDROBE =
--		{
--			GENERIC = "It holds dark, forbidden secrets...",
--            BURNING = "That's burning fast!",
--			BURNT = "It's out of style now.",
--		},
--		WARG = "You might be something to reckon with, big dog.",
--        WARGLET = "It's going to be one of those days...",
--
--		WASPHIVE = "I think those bees are mad.",
--		WATERBALLOON = "Balloon?",
--		WATERMELON = "Sticky sweet.",
--		WATERMELON_COOKED = "Juicy and warm.",
--		WATERMELONHAT = "I cannot wear this.",
--		WAXWELLJOURNAL = "Spooky.",
--		WETGOOP = "It tastes like nothing.",
--        WHIP = "Nothing like loud noises to help keep the peace.",
		WINTERHAT = "当然，接下来呢?",
--		WINTEROMETER =
--		{
--			GENERIC = "Mercurial.",
--			BURNT = "Its measuring days are over.",
--		},
--
--        WINTER_TREE =
--        {
--            BURNT = "That puts a damper on the festivities.",
--            BURNING = "That was a mistake, I think.",
--            CANDECORATE = "Happy Winter's Feast!",
--            YOUNG = "It's almost Winter's Feast!",
--        },
--		WINTER_TREESTAND =
--		{
--			GENERIC = "I need a pine cone for that.",
--            BURNT = "That puts a damper on the festivities.",
--		},
--        WINTER_ORNAMENT = "Every man appreciates a good bauble.",
--        WINTER_ORNAMENTLIGHT = "A tree's not complete without some electricity.",
--        WINTER_ORNAMENTBOSS = "This one is especially impressive.",
--		WINTER_ORNAMENTFORGE = "I should hang this one over a fire.",
--		WINTER_ORNAMENTGORGE = "For some reason it makes me hungry.",
--
--        WINTER_FOOD1 = "The anatomy's not right, but I'll overlook it.", --gingerbread cookie
--        WINTER_FOOD2 = "I'm going to eat forty.", --sugar cookie
--        WINTER_FOOD3 = "A Yuletide toothache waiting to happen.", --candy cane
--        WINTER_FOOD4 = "Mmmm.", --fruitcake
--        WINTER_FOOD5 = "It's nice to eat something other than berries for once.", --yule log cake
--        WINTER_FOOD6 = "I'm puddin' that straight in my mouth!", --plum pudding
--        WINTER_FOOD7 = "It's a hollowed apple filled with yummy juice.", --apple cider
--        WINTER_FOOD8 = "How does it stay warm? A thermodynamical mug?", --hot cocoa
--        WINTER_FOOD9 = "Can someone explain why it tastes so good?", --eggnog
--
--		WINTERSFEASTOVEN =
--		{
--			GENERIC = "A festive furnace for flame-grilled foodstuffs!",
--			COOKING = "Cooking.",
--			ALMOST_DONE_COOKING = "It is almost done!",
--			DISH_READY = "It's done.",
--		},
--		BERRYSAUCE = "Equal parts merry and berry.",
--		BIBINGKA = "Soft and spongy.",
--		CABBAGEROLLS = "The meat hides inside the cabbage to avoid predators.",
--		FESTIVEFISH = "I wouldn't mind sampling some seasonal seafood.",
--		GRAVY = "It's all gravy.",
--		LATKES = "I could eat a latke more of these.",
--		LUTEFISK = "Is there any trumpetfisk?",
--		MULLEDDRINK = "This punch has a kick to it.",
--		PANETTONE = "This Yuletide bread really rose to the occasion.",
--		PAVLOVA = "I lova good Pavlova.",
--		PICKLEDHERRING = "You won't be herring any complaints from me.",
--		POLISHCOOKIE = "I'll polish off this whole plate!",
--		PUMPKINPIE = "I should probably just eat the whole thing...",
--		ROASTTURKEY = "I see a big juicy drumstick with my name on it.",
--		STUFFING = "That's the good stuff!",
--		SWEETPOTATO = "I have created a hybrid between dinner and dessert.",
--		TAMALES = "If I eat much more I'm going to start feeling a bit husky.",
--		TOURTIERE = "Pleased to eat you.",
--
--		TABLE_WINTERS_FEAST =
--		{
--			GENERIC = "A feastival table.",
--			HAS_FOOD = "Time to eat!",
--			WRONG_TYPE = "It's not the season for that.",
--			BURNT = "Who would do such a thing?",
--		},
--
--		GINGERBREADWARG = "Time to desert this dessert.",
--		GINGERBREADHOUSE = "Room and board all rolled into one.",
--		GINGERBREADPIG = "I'd better follow him.",
--		CRUMBS = "A crummy way to hide yourself.",
--		WINTERSFEASTFUEL = "The spirit of the season!",
--
--        KLAUS = "What on earth is that thing!",
--        KLAUS_SACK = "We should definitely open that.",
--		KLAUSSACKKEY = "It's really fancy for a deer antler.",
--		WORMHOLE =
--		{
--			GENERIC = "Soft and undulating.",
--			OPEN = "Jump in.",
--		},
--		WORMHOLE_LIMITED = "Guh, that thing looks worse off than usual.",
--		ACCOMPLISHMENT_SHRINE = "I want to use it, and I want the world to know that I did.",
--		LIVINGTREE = "Is it watching me?",
--		ICESTAFF = "It's like a children's toy.",
--		REVIVER = "The beating of this hideous heart will bring a ghost back to life!",
--		SHADOWHEART = "I can feel my heart now...",
--        ATRIUM_RUBBLE =
--        {
--			LINE_1 = "It depicts an old civilization. The people look hungry and scared.",
--			LINE_2 = "This tablet is too worn to make out.",
--			LINE_3 = "Something dark creeps over the city and its people.",
--			LINE_4 = "The people are shedding their skins. They look different underneath.",
--			LINE_5 = "It shows a massive, technologically advanced city.",
--		},
--        ATRIUM_STATUE = "It doesn't seem fully real.",
--        ATRIUM_LIGHT =
--        {
--			ON = "A truly unsettling light.",
--			OFF = "Something must power it.",
--		},
--        ATRIUM_GATE =
--        {
--			ON = "Back in working order.",
--			OFF = "The essential components are still intact.",
--			CHARGING = "It's gaining power.",
--			DESTABILIZING = "The gateway is destabilizing.",
--			COOLDOWN = "It needs time to recover. Me too.",
--        },
--        ATRIUM_KEY = "There is power emanating from it.",
--		LIFEINJECTOR = "Garbage.",
--		--SKELETON_PLAYER =
--		--{
--		--	MALE = "%s must've died performing an experiment with %s.",
--		--	FEMALE = "%s must've died performing an experiment with %s.",
--		--	ROBOT = "%s must've died performing an experiment with %s.",
--		--	DEFAULT = "%s must've died performing an experiment with %s.",
--		--},
--		HUMANMEAT = "Flesh is flesh. Where do I draw the line?",
--		HUMANMEAT_COOKED = "Cooked nice and pink, but still morally gray.",
--		HUMANMEAT_DRIED = "Letting it dry makes it not come from a human, right?",
--		ROCK_MOON = "That rock came from the moon.",
--		MOONROCKNUGGET = "That rock came from the moon.",
--		MOONROCKCRATER = "I should stick something shiny in it. For research.",
--		MOONROCKSEED = "There's something inside!",
--
--        REDMOONEYE = "It can see and be seen for miles!",
--        PURPLEMOONEYE = "Makes a good marker, but I wish it'd stop looking at me.",
--        GREENMOONEYE = "That'll keep a watchful eye on the place.",
--        ORANGEMOONEYE = "No one could get lost with that thing looking out for them.",
--        YELLOWMOONEYE = "That ought to show everyone the way.",
--        BLUEMOONEYE = "It's always smart to keep an eye out.",
--
--                --Arena Event
--        LAVAARENA_BOARLORD = "A ruthless man.",
--        BOARRIOR = "Your death will be swift.",
--        BOARON = "A shame you have to perish.",
--        PEGHOOK = "My faith will defend me.",
--        TRAILS = "You shall fall.",
--        TURTILLUS = "You cannot shield yourself from this world.",
--        SNAPPER = "Death will be a blessing.",
--		RHINODRILL = "Brotherly camaraderie will not save you.",
--		BEETLETAUR = "You are a prisoner of your own doomed destiny.",
--
--        LAVAARENA_PORTAL =
--        {
--            ON = "I bid you good day.",
--            GENERIC = "I dared not hope it would take me home.",
--        },
--        LAVAARENA_KEYHOLE = "Empty as my heart.",
--		LAVAARENA_KEYHOLE_FULL = "Full as my sorrows.",
--        LAVAARENA_BATTLESTANDARD = "That Battle Standard needs to be destroyed...",
--        LAVAARENA_SPAWNER = "That's where they come from...",
--
--        HEALINGSTAFF = "I could restore my allies.",
--        FIREBALLSTAFF = "To call death from the skies.",
--        HAMMER_MJOLNIR = "What a brutal implement.",
--        SPEAR_GUNGNIR = "To cut and slash...",
--        BLOWDART_LAVA = "To pierce the hearts of my foes...",
--        BLOWDART_LAVA2 = "To burn and pierce!",
--        LAVAARENA_LUCY = "Hello again, Lucy.",
--        WEBBER_SPIDER_MINION = "Webber seems proud of them.",
--        BOOK_FOSSIL = "There is power in words.",
--		LAVAARENA_BERNIE = "How do you do, Bernie?",
--		SPEAR_LANCE = "Such a brutal weapon...",
--		BOOK_ELEMENTAL = "I would not want such power.",
--		LAVAARENA_ELEMENTAL = "When will you be free from this torment?",
--
--   		LAVAARENA_ARMORLIGHT = "If only my heart were as light.",
--		LAVAARENA_ARMORLIGHTSPEED = "They'll have to catch me to hurt me.",
--		LAVAARENA_ARMORMEDIUM = "Protect my fragile frame.",
--		LAVAARENA_ARMORMEDIUMDAMAGER = "Even our armor is fanged.",
--		LAVAARENA_ARMORMEDIUMRECHARGER = "It will restore one's power.",
--		LAVAARENA_ARMORHEAVY = "Heavy protection for one's heart.",
--		LAVAARENA_ARMOREXTRAHEAVY = "This world is nothing but hurt.",
--
--		LAVAARENA_FEATHERCROWNHAT = "But what of the birds?",
--        LAVAARENA_HEALINGFLOWERHAT = "It eases pain of the body, but not of the heart.",
--        LAVAARENA_LIGHTDAMAGERHAT = "It brings more pain into the world.",
--        LAVAARENA_STRONGDAMAGERHAT = "Hit harder, stronger...",
--        LAVAARENA_TIARAFLOWERPETALSHAT = "The wearer shall be a force of good.",
--        LAVAARENA_EYECIRCLETHAT = "There is dastardly power within.",
--        LAVAARENA_RECHARGERHAT = "I'll be able to attack so often...",
--        LAVAARENA_HEALINGGARLANDHAT = "But will it heal my soul?",
--        LAVAARENA_CROWNDAMAGERHAT = "I forsee a wave of death.",
--
--		LAVAARENA_ARMOR_HP = "It protects from damage, but not from sorrow.",
--
--		LAVAARENA_FIREBOMB = "A bombardment of pain.",
--		LAVAARENA_HEAVYBLADE = "It's too heavy. Like my soul.",
--
--        --Quagmire
--        QUAGMIRE_ALTAR =
--        {
--        	GENERIC = "The monster's hunger shall never cease.",
--        	FULL = "We have prolonged our horrific demise.",
--    	},
--		QUAGMIRE_ALTAR_STATUE1 = "What horror have those eyes witnessed?",
--		QUAGMIRE_PARK_FOUNTAIN = "Long dry.",
--
--        QUAGMIRE_HOE = "To till the corrupt soil.",
--
--        QUAGMIRE_TURNIP = "It's... a turnip.",
--        QUAGMIRE_TURNIP_COOKED = "The turnip is now cooked.",
--        QUAGMIRE_TURNIP_SEEDS = "The life they contain is a mystery.",
--
--        QUAGMIRE_GARLIC = "It gives food flavor.",
--        QUAGMIRE_GARLIC_COOKED = "It smells a bit nice.",
--        QUAGMIRE_GARLIC_SEEDS = "The life they contain is a mystery.",
--
--        QUAGMIRE_ONION = "I never cry.",
--        QUAGMIRE_ONION_COOKED = "It will never make anyone cry again.",
--        QUAGMIRE_ONION_SEEDS = "The life they contain is a mystery.",
--
--        QUAGMIRE_POTATO = "It has eyes, yet it never cries.",
--        QUAGMIRE_POTATO_COOKED = "Now its eyes will never open.",
--        QUAGMIRE_POTATO_SEEDS = "The life they contain is a mystery.",
--
--        QUAGMIRE_TOMATO = "Red as heart's blood.",
--        QUAGMIRE_TOMATO_COOKED = "Its flesh is far more bloody now.",
--        QUAGMIRE_TOMATO_SEEDS = "The life they contain is a mystery.",
--
--        QUAGMIRE_FLOUR = "Flour by any other name would smell as sweet.",
--        QUAGMIRE_WHEAT = "We can grind it down into flour.",
--        QUAGMIRE_WHEAT_SEEDS = "The life they contain is a mystery.",
--        --NOTE: raw/cooked carrot uses regular carrot strings
--        QUAGMIRE_CARROT_SEEDS = "The life they contain is a mystery.",
--
--        QUAGMIRE_ROTTEN_CROP = "Time came for it.",
--
--		QUAGMIRE_SALMON = "It flops as its life slowly leaves its body.",
--		QUAGMIRE_SALMON_COOKED = "Not so lively now.",
--		QUAGMIRE_CRABMEAT = "Its insides are as horrid as its outsides.",
--		QUAGMIRE_CRABMEAT_COOKED = "It's ready now.",
--		QUAGMIRE_SUGARWOODTREE =
--		{
--			GENERIC = "It has a sickly beauty.",
--			STUMP = "All things must end.",
--			TAPPED_EMPTY = "Like a dagger through the heart. A tree heart.",
--			TAPPED_READY = "I can harvest it now.",
--			TAPPED_BUGS = "All that sacrifice for nothing.",
--			WOUNDED = "Its life ebbs.",
--		},
--		QUAGMIRE_SPOTSPICE_SHRUB =
--		{
--			GENERIC = "I suppose it could be edible.",
--			PICKED = "We've taken all there was to take.",
--		},
--		QUAGMIRE_SPOTSPICE_SPRIG = "We ripped it from its home on the shrub.",
--		QUAGMIRE_SPOTSPICE_GROUND = "Just a dash.",
--		QUAGMIRE_SAPBUCKET = "For collecting tree blood.",
--		QUAGMIRE_SAP = "Tree blood.",
--		QUAGMIRE_SALT_RACK =
--		{
--			READY = "There is salt to be had.",
--			GENERIC = "There is no salt, yet.",
--		},
--
--		QUAGMIRE_POND_SALT = "Water, water, everywhere...",
--		QUAGMIRE_SALT_RACK_ITEM = "It's for collecting salt from the pond.",
--
--		QUAGMIRE_SAFE =
--		{
--			GENERIC = "Let's have a peek inside...",
--			LOCKED = "Locked, like my heart.",
--		},
--
--		QUAGMIRE_KEY = "It is the key to something precious.",
--		QUAGMIRE_KEY_PARK = "The key to a beautiful place, locked long away.",
--        QUAGMIRE_PORTAL_KEY = "Perhaps I'll be happier in the next world.",
--
--
--		QUAGMIRE_MUSHROOMSTUMP =
--		{
--			GENERIC = "They thrive on a stump made by death.",
--			PICKED = "All things die. Even fungus.",
--		},
--		QUAGMIRE_MUSHROOMS = "Maybe we'll get lucky and they'll be poisonous.",
--        QUAGMIRE_MEALINGSTONE = "I am ground down on the mealing stone of life.",
--		QUAGMIRE_PEBBLECRAB = "Had I such a shell, I would never emerge.",
--
--
--		QUAGMIRE_RUBBLE_CARRIAGE = "It's been forgotten.",
--        QUAGMIRE_RUBBLE_CLOCK = "Time is an illusion.",
--        QUAGMIRE_RUBBLE_CATHEDRAL = "Nothing more to pray for.",
--        QUAGMIRE_RUBBLE_PUBDOOR = "A door that leads nowhere.",
--        QUAGMIRE_RUBBLE_ROOF = "The roof cannot protect you when death comes.",
--        QUAGMIRE_RUBBLE_CLOCKTOWER = "Time is death's ally.",
--        QUAGMIRE_RUBBLE_BIKE = "Nothing escaped this plague.",
--        QUAGMIRE_RUBBLE_HOUSE =
--        {
--            "Death has been here.",
--            "It's a ghost town.",
--            "Some tragedy has struck this house.",
--        },
--        QUAGMIRE_RUBBLE_CHIMNEY = "This was once a happy home.",
--        QUAGMIRE_RUBBLE_CHIMNEY2 = "Its hearth no longer has a home.",
--        QUAGMIRE_MERMHOUSE = "Seclusion has not been kind to it.",
--        QUAGMIRE_SWAMPIG_HOUSE = "I see no joy in this house.",
--        QUAGMIRE_SWAMPIG_HOUSE_RUBBLE = "Neither a house nor a home.",
--        QUAGMIRE_SWAMPIGELDER =
--        {
--            GENERIC = "How do you do, sir?",
--            SLEEPING = "He is practicing for the big sleep.",
--        },
--        QUAGMIRE_SWAMPIG = "They're less standoffish than their brethren.",
--
--        QUAGMIRE_PORTAL = "There's no night here. It is a nice change.",
--        QUAGMIRE_SALTROCK = "It needs to be ground down before we can use it.",
--        QUAGMIRE_SALT = "It adds flavor...",
--        --food--
--        QUAGMIRE_FOOD_BURNT = "A waste.",
--        QUAGMIRE_FOOD =
--        {
--        	GENERIC = "We should offer it to the beast.",
--            MISMATCH = "The beast doesn't want that.",
--            MATCH = "The beast will be satisfied with this.",
--            MATCH_BUT_SNACK = "This will satisfy the beast, but not for long.",
--        },
--
--        QUAGMIRE_FERN = "Wilson calls them \"greens\"... but they're purple...",
--        QUAGMIRE_FOLIAGE_COOKED = "Cooked purples.",
--        QUAGMIRE_COIN1 = "I shall put them on my eyes when I die.",
--        QUAGMIRE_COIN2 = "Money will not bring you any happiness.",
--        QUAGMIRE_COIN3 = "Wealth cannot buy immortality.",
--        QUAGMIRE_COIN4 = "It came from above.",
--        QUAGMIRE_GOATMILK = "But no honey.",
--        QUAGMIRE_SYRUP = "Not as sweet as my king.",
--        QUAGMIRE_SAP_SPOILED = "As bittersweet as life.",
--        QUAGMIRE_SEEDPACKET = "Planting seeds requires an optimism I don't possess.",
--
--        QUAGMIRE_POT = "We cook to stave off death.",
--        QUAGMIRE_POT_SMALL = "We will cook, or we will die.",
--        QUAGMIRE_POT_SYRUP = "Sweetness begets sweetness.",
--        QUAGMIRE_POT_HANGER = "The hanger is a noose for a pot.",
--        QUAGMIRE_POT_HANGER_ITEM = "It's for hanging the pot over the fire.",
--        QUAGMIRE_GRILL = "It can't make life more palatable.",
--        QUAGMIRE_GRILL_ITEM = "I don't want to carry this around.",
--        QUAGMIRE_GRILL_SMALL = "It makes a little bit of food.",
--        QUAGMIRE_GRILL_SMALL_ITEM = "It only works if I place it somewhere.",
--        QUAGMIRE_OVEN = "It looks okay.",
--        QUAGMIRE_OVEN_ITEM = "Sigh... Why bother?",
--        QUAGMIRE_CASSEROLEDISH = "For making food.",
--        QUAGMIRE_CASSEROLEDISH_SMALL = "For making a small amount of food.",
--        QUAGMIRE_PLATE_SILVER = "If only life had been handed to me on a silver plate.",
--        QUAGMIRE_BOWL_SILVER = "It is empty, like my heart.",
----fallback to speech_wilson.lua         QUAGMIRE_CRATE = "Kitchen stuff.",
--
--        QUAGMIRE_MERM_CART1 = "I, too, cart around my baggage.", --sammy's wagon
--        QUAGMIRE_MERM_CART2 = "Nothing in there could bring me happiness.", --pipton's cart
--        QUAGMIRE_PARK_ANGEL = "It's winged, but it's no angel.",
--        QUAGMIRE_PARK_ANGEL2 = "My emperor needs a statue.",
--        QUAGMIRE_PARK_URN = "Dust to dust.",
--        QUAGMIRE_PARK_OBELISK = "A monument. But not to the king.",
--        QUAGMIRE_PARK_GATE =
--        {
--            GENERIC = "Now I may enter the park.",
--            LOCKED = "I need a key to enter.",
--        },
--        QUAGMIRE_PARKSPIKE = "Looks dangerous.",
--        QUAGMIRE_CRABTRAP = "Life is a trap.",
--        QUAGMIRE_TRADER_MERM = "How do you do?",
--        QUAGMIRE_TRADER_MERM2 = "How do you do?",
--
--        QUAGMIRE_GOATMUM = "Hello, ma'am. Care to trade?",
--        QUAGMIRE_GOATKID = "What childhood is this for you?",
--        QUAGMIRE_PIGEON =
--        {
--            DEAD = "Cold and dead.",
--            GENERIC = "Would you like to be a pie, little bird?",
--            SLEEPING = "It's practicing for the big sleep.",
--        },
--        QUAGMIRE_LAMP_POST = "It sheds light on nothing important.",
--
--        QUAGMIRE_BEEFALO = "Don't worry. You'll be dead soon.",
--        QUAGMIRE_SLAUGHTERTOOL = "Is all of life not a slaughter?",
--
--        QUAGMIRE_SAPLING = "We will perish before this grows back.",
--        QUAGMIRE_BERRYBUSH = "It shall never grow another berry.",
--
--        QUAGMIRE_ALTAR_STATUE2 = "Yet another reminder of death.",
--        QUAGMIRE_ALTAR_QUEEN = "I am not impressed by opulence.",
--        QUAGMIRE_ALTAR_BOLLARD = "A post. Not very exciting.",
--        QUAGMIRE_ALTAR_IVY = "Like death, it creeps everywhere.",
--
--        QUAGMIRE_LAMP_SHORT = "The only light in my life is you my emperor.",
--
--        --v2 Winona
--        WINONA_CATAPULT =
--        {
--        	GENERIC = "She's made a sort of automatic defense system.",
--        	OFF = "It needs some electricity.",
--        	BURNING = "It's on fire!",
--        	BURNT = "Ash.",
--        },
--        WINONA_SPOTLIGHT =
--        {
--        	GENERIC = "What an ingenious idea!",
--        	OFF = "It needs some electricity.",
--        	BURNING = "It's on fire!",
--        	BURNT = "Ash.",
--        },
--        WINONA_BATTERY_LOW =
--        {
--        	GENERIC = "How does it work?",
--        	LOWPOWER = "It's getting low on power.",
--        	OFF = "I could get it working, if Winona's busy.",
--        	BURNING = "It's on fire!",
--        	BURNT = "Ash.",
--        },
--        WINONA_BATTERY_HIGH =
--        {
--        	GENERIC = "Ok, now we are talking.",
--        	LOWPOWER = "It'll turn off soon.",
--        	OFF = "It's not working.",
--        	BURNING = "It's on fire!",
--        	BURNT = "Ash.",
--        },
--
--        --Wormwood
        COMPOSTWRAP = "为植物准备的.",
        ARMOR_BRAMBLE = "植物也会碎吗?",
        --TRAP_BRAMBLE = "It'd really poke whoever stepped on it.",
--
--        BOATFRAGMENT03 = "Not much left of it.",
--        BOATFRAGMENT04 = "Not much left of it.",
--        BOATFRAGMENT05 = "Not much left of it.",
--		BOAT_LEAK = "I should patch that up before we sink.",
--        MAST = "Avast! A mast!",
--        SEASTACK = "It's a rock.",
--        FISHINGNET = "Nothing but net.",
--        ANTCHOVIES = "Yeesh. Can I toss it back?",
--        STEERINGWHEEL = "I could have been a sailor in another life.",
--        ANCHOR = "I wouldn't want my boat to float away.",
--        BOATPATCH = "Just in case of disaster.",
--        DRIFTWOOD_TREE =
--        {
--            BURNING = "That driftwood's burning!",
--            BURNT = "Doesn't look very useful anymore.",
--            CHOPPED = "There might still be something worth digging up.",
--            GENERIC = "A dead tree that washed up on shore.",
--        },
--
--        DRIFTWOOD_LOG = "It floats on water.",
--
--        MOON_TREE =
--        {
--            BURNING = "The tree is burning!",
--            BURNT = "The tree burned down.",
--            CHOPPED = "That was a pretty thick tree.",
--            GENERIC = "I didn't know trees grew on the moon.",
--        },
		MOON_TREE_BLOSSOM = "花瓣在细腻地拂过我的物质.",
--
--        MOONBUTTERFLY =
--        {
--        	GENERIC = "A moon butterfly.",
--        	HELD = "I've got you now.",
--        },
--		MOONBUTTERFLYWINGS = "We're really winging it now.",
--        MOONBUTTERFLY_SAPLING = "A moth turned into a tree? Lunacy!",
--        ROCK_AVOCADO_FRUIT = "I'd shatter my teeth on that.",
--        ROCK_AVOCADO_FRUIT_RIPE = "Uncooked stone fruit is the pits.",
--        ROCK_AVOCADO_FRUIT_RIPE_COOKED = "It's actually soft enough to eat now.",
--        ROCK_AVOCADO_FRUIT_SPROUT = "It's growing.",
--        ROCK_AVOCADO_BUSH =
--        {
--        	BARREN = "Its fruit growing days are over.",
--			WITHERED = "It's pretty hot out.",
--			GENERIC = "It's a bush... from the moon!",
--			PICKED = "It'll take awhile to grow more fruit.",
--			DISEASED = "It looks pretty sick.",
--            DISEASING = "Err, something's not right.",
--			BURNING = "It's burning!",
--		},
--        DEAD_SEA_BONES = "That's what they get for coming up on land.",
--        HOTSPRING =
--        {
--        	GENERIC = "If only I could soak my weary bones.",
--        	BOMBED = "Just a simple chemical reaction.",
--        	GLASS = "Water turns to glass under the moon.",
--			EMPTY = "I'll just have to wait for it to fill up again.",
--        },
--        MOONGLASS = "It's very sharp.",
--        MOONGLASS_CHARGED = "I should put this to use before the energy fades!",
--        MOONGLASS_ROCK = "I can practically see my reflection in it.",
--        BATHBOMB = "It's just textbook chemistry.",
--        TRAP_STARFISH =
--        {
--            GENERIC = "Aw, what a cute little starfish!",
--            CLOSED = "It tried to chomp me!",
--        },
--        DUG_TRAP_STARFISH = "It's not fooling anyone now.",
--        SPIDER_MOON =
--        {
--        	GENERIC = "Oh good. The moon mutated it.",
--        	SLEEPING = "It stopped moving.",
--        	DEAD = "Is it really dead?",
--        },
--        MOONSPIDERDEN = "That's not a normal spider den.",
--		FRUITDRAGON =
--		{
--			GENERIC = "It's cute, but it's not ripe yet.",
--			RIPE = "I think it's ripe now.",
--			SLEEPING = "It's snoozing.",
--		},
--        PUFFIN =
--        {
--            GENERIC = "I've never seen a live puffin before!",
--            HELD = "Catching one ain't puffin to brag about.",
--            SLEEPING = "Peacefully huffin' and puffin'.",
--        },
--
--		MOONGLASSAXE = "I've made it extra effective.",
--		GLASSCUTTER = "I'm not really cut out for fighting.",
--
--        ICEBERG =
--        {
--            GENERIC = "Let's steer clear of that.",
--            MELTED = "It's completely melted.",
--        },
--        ICEBERG_MELTED = "It's completely melted.",
--
--        MINIFLARE = "I can light it to let everyone know I'm here.",
--        MEGAFLARE = "It will let everything know I'm here. Everything.",
--
--		MOON_FISSURE =
--		{
--			GENERIC = "My brain pulses with peace and terror.",
--			NOLIGHT = "The cracks in this place are starting to show.",
--		},
--        MOON_ALTAR =
--        {
--            MOON_ALTAR_WIP = "It wants to be finished.",
--            GENERIC = "Hm? What did you say?",
--        },
--
--        MOON_ALTAR_IDOL = "I feel compelled to carry it somewhere.",
--        MOON_ALTAR_GLASS = "It doesn't want to be on the ground.",
--        MOON_ALTAR_SEED = "It wants me to give it a home.",
--
--        MOON_ALTAR_ROCK_IDOL = "There's something trapped inside.",
--        MOON_ALTAR_ROCK_GLASS = "There's something trapped inside.",
--        MOON_ALTAR_ROCK_SEED = "There's something trapped inside.",
--
--        MOON_ALTAR_CROWN = "I fished it up, now to find a fissure!",
--        MOON_ALTAR_COSMIC = "It feels like it's waiting for something.",
--
--        MOON_ALTAR_ASTRAL = "It seems to be part of a larger mechanism.",
--        MOON_ALTAR_ICON = "I think I know just where you belong.",
--        MOON_ALTAR_WARD = "It wants to be with the others.",
--
--        SEAFARING_PROTOTYPER =
--        {
--            GENERIC = "I think tanks are in order.",
--            BURNT = "Has been lost to sea.",
--        },
--        BOAT_ITEM = "It would be nice to swim in the water.",
--        BOAT_GRASS_ITEM = "It's technically a boat.",
--        STEERINGWHEEL_ITEM = "That's going to be the steering wheel.",
--        ANCHOR_ITEM = "Now I can build an anchor.",
--        MAST_ITEM = "Now I can build a mast.",
--        MUTATEDHOUND =
--        {
--        	DEAD = "Now I can breathe easy.",
--        	GENERIC = "Save us emperor!",
--        	SLEEPING = "I have a very strong desire to run.",
--        },
--
--        MUTATED_PENGUIN =
--        {
--			DEAD = "That's the end of that.",
--			GENERIC = "That thing's terrifying!",
--			SLEEPING = "Thank goodness. 它在睡觉.",
--		},
--        CARRAT =
--        {
--        	DEAD = "That's the end of that.",
--        	GENERIC = "Are carrots supposed to have legs?",
--        	HELD = "You're kind of ugly up close.",
--        	SLEEPING = "It's almost cute.",
--        },
--
--		BULLKELP_PLANT =
--        {
--            GENERIC = "Welp. It's kelp.",
--            PICKED = "I just couldn't kelp myself.",
--        },
--		BULLKELP_ROOT = "I can plant it in deep water.",
--        KELPHAT = "I cannot wear this.",
--		KELP = "It gets my pockets all wet and gross.",
--		KELP_COOKED = "It's closer to a liquid than a solid.",
--		KELP_DRIED = "The sodium content's kinda high.",
--
--		GESTALT = "I don't want to know.",
--        GESTALT_GUARD = "They're promising me... a good smack if I get too close.",
--
--		COOKIECUTTER = "I don't like the way it's looking at my boat...",
--		COOKIECUTTERSHELL = "A shell of its former self.",
--		COOKIECUTTERHAT = "I cannot wear this.",
--		SALTSTACK =
--		{
--			GENERIC = "Are those natural formations?",
--			MINED_OUT = "It's mined... it's all mined!",
--			GROWING = "I guess it just grows like that.",
--		},
--		SALTROCK = "I have an urge.",
--		SALTBOX = "Just the cure for spoiling food!",
--
--		TACKLESTATION = "Time to tackle my reel problems.",
--		TACKLESKETCH = "A picture of some fishing tackle. I bet I could make this...",
--
--        MALBATROSS = "A fowl beast indeed!",
--        MALBATROSS_FEATHER = "Plucked from a fine feathered fiend.",
--        MALBATROSS_BEAK = "Smells fishy.",
--        MAST_MALBATROSS_ITEM = "It's lighter than it looks.",
--        MAST_MALBATROSS = "Spread my wings and sail away!",
--		MALBATROSS_FEATHERED_WEAVE = "I'm making a quill-t!",
--
--        GNARWAIL =
--        {
--            GENERIC = "My, what a big horn you have.",
--            BROKENHORN = "Got your nose!",
--            FOLLOWER = "This is all whale and good.",
--            BROKENHORN_FOLLOWER = "That's what happens when you nose around!",
--        },
--        GNARWAIL_HORN = "Gnarly!",
--
--        WALKINGPLANK = "Couldn't we have just made a lifeboat?",
--        WALKINGPLANK_GRASS = "Couldn't we have just made a lifeboat?",
--        OAR = "Manual ship acceleration.",
--		OAR_DRIFTWOOD = "Manual ship acceleration.",
--
--		OCEANFISHINGROD = "Now this is the reel deal!",
--		OCEANFISHINGBOBBER_NONE = "A bobber might improve its accuracy.",
--        OCEANFISHINGBOBBER_BALL = "The fish will have a ball with this.",
--        OCEANFISHINGBOBBER_OVAL = "Those fish won't give me the slip this time!",
--		OCEANFISHINGBOBBER_CROW = "I'd rather eat fish than crow.",
--		OCEANFISHINGBOBBER_ROBIN = "Hopefully it won't attract any red herrings.",
--		OCEANFISHINGBOBBER_ROBIN_WINTER = "The snowbird quill helps me stay frosty.",
--		OCEANFISHINGBOBBER_CANARY = "Say y'ello to my little friend!",
--		OCEANFISHINGBOBBER_GOOSE = "You're going down, fish!",
--		OCEANFISHINGBOBBER_MALBATROSS = "Where there's a quill, there's a way.",
--
--		OCEANFISHINGLURE_SPINNER_RED = "Some fish might find this a-luring!",
--		OCEANFISHINGLURE_SPINNER_GREEN = "Some fish might find this a-luring!",
--		OCEANFISHINGLURE_SPINNER_BLUE = "Some fish might find this a-luring!",
--		OCEANFISHINGLURE_SPOON_RED = "Some smaller fish might find this a-luring!",
--		OCEANFISHINGLURE_SPOON_GREEN = "Some smaller fish might find this a-luring!",
--		OCEANFISHINGLURE_SPOON_BLUE = "Some smaller fish might find this a-luring!",
--		OCEANFISHINGLURE_HERMIT_RAIN = "Soaking myself might help me think like a fish...",
--		OCEANFISHINGLURE_HERMIT_SNOW = "The fish won't snow what hit them!",
--		OCEANFISHINGLURE_HERMIT_DROWSY = "My brain is protected.",
--		OCEANFISHINGLURE_HERMIT_HEAVY = "This feels a bit heavy handed.",
--
--		OCEANFISH_SMALL_1 = "Looks like the runt of its school.",
--		OCEANFISH_SMALL_2 = "I won't win any bragging rights with this one.",
--		OCEANFISH_SMALL_3 = "It's a bit on the small side.",
--		OCEANFISH_SMALL_4 = "A fish this size won't tide me over for long.",
--		OCEANFISH_SMALL_5 = "I can't wait to pop it in my mouth.",
--		OCEANFISH_SMALL_6 = "You have to sea it to beleaf it.",
--		OCEANFISH_SMALL_7 = "I finally caught this bloomin' fish!",
--		OCEANFISH_SMALL_8 = "It's a scorcher!",
--        OCEANFISH_SMALL_9 = "Just spit-balling, but I might have a use for you...",
--
--		OCEANFISH_MEDIUM_1 = "I certainly hope it tastes better than it looks.",
--		OCEANFISH_MEDIUM_2 = "I went to a lot of treble to catch it.",
--		OCEANFISH_MEDIUM_3 = "I wasn't lion about my aptitude for fishing!",
--		OCEANFISH_MEDIUM_4 = "I'm sure this won't bring me any bad luck.",
--		OCEANFISH_MEDIUM_5 = "This one seems kind of corny.",
--		OCEANFISH_MEDIUM_6 = "Now that's the real McKoi!",
--		OCEANFISH_MEDIUM_7 = "Now that's the real McKoi!",
--		OCEANFISH_MEDIUM_8 = "Ice bream, youse bream.",
--        OCEANFISH_MEDIUM_9 = "That's the sweet smell of a successful fishing trip.",
--
--		PONDFISH = "Now I shall eat for a day.",
--		PONDEEL = "This will make a delicious meal.",
--
--        FISHMEAT = "A chunk of fish meat.",
--        FISHMEAT_COOKED = "Grilled to perfection.",
--        FISHMEAT_SMALL = "A small bit of fish.",
--        FISHMEAT_SMALL_COOKED = "A small bit of cooked fish.",
--		SPOILED_FISH = "I'm not terribly curious about the smell.",
--
--		FISH_BOX = "They're stuffed in there like sardines!",
--        POCKET_SCALE = "A scaled-down weighing device.",
--
--		TACKLECONTAINER = "This extra storage space has me hooked!",
--		SUPERTACKLECONTAINER = "I had to shell out quite a bit to get this.",
--
--		TROPHYSCALE_FISH =
--		{
--			GENERIC = "I wonder how my catch of the day will measure up!",
--			HAS_ITEM = "Weight: {weight}\nCaught by: {owner}",
--			HAS_ITEM_HEAVY = "Weight: {weight}\nCaught by: {owner}\nWhat a catch!",
--			BURNING = "On a scale of 1 to on fire... that's pretty on fire.",
--			BURNT = "All my bragging rights, gone up in flames!",
--			OWNER = "Not to throw my weight around, buuut...\nWeight: {weight}\nCaught by: {owner}",
--			OWNER_HEAVY = "Weight: {weight}\nCaught by: {owner}\nIt's the one that DIDN'T get away!",
--		},
--
--		OCEANFISHABLEFLOTSAM = "Just some muddy grass.",
--
--		CALIFORNIAROLL = "But I don't have chopsticks.",
--		SEAFOODGUMBO = "It's a jumbo seafood gumbo.",
--		SURFNTURF = "It's perf!",
--
--        WOBSTER_SHELLER = "What a wascally Wobster.",
--        WOBSTER_DEN = "It's a rock with Wobsters in it.",
--        WOBSTER_SHELLER_DEAD = "You should cook up nicely.",
--        WOBSTER_SHELLER_DEAD_COOKED = "I can't wait to eat you.",
--
--        LOBSTERBISQUE = "Could use more salt, but that's none of my bisque-ness.",
--        LOBSTERDINNER = "If I eat it in the morning is it still dinner?",
--
--        WOBSTER_MOONGLASS = "What a wascally Lunar Wobster.",
--        MOONGLASS_WOBSTER_DEN = "It's a chunk of moonglass with Lunar Wobsters in it.",
--
--		TRIDENT = "This is going to be a blast!",
--
--		WINCH =
--		{
--			GENERIC = "It'll do in a pinch.",
--			RETRIEVING_ITEM = "I'll let it do the heavy lifting.",
--			HOLDING_ITEM = "What do we have here?",
--		},
--
--        HERMITHOUSE = {
--            GENERIC = "It's just an empty shell of a house.",
--            BUILTUP = "It just needed a little love.",
--        },
--
--        SHELL_CLUSTER = "I bet there's some nice shells in there.",
--        --
--		SINGINGSHELL_OCTAVE3 =
--		{
--			GENERIC = "It's a bit more toned down.",
--		},
--		SINGINGSHELL_OCTAVE4 =
--		{
--			GENERIC = "Is that what the ocean sounds like?",
--		},
--		SINGINGSHELL_OCTAVE5 =
--		{
--			GENERIC = "It's ready for the high C's.",
--        },
--
--        CHUM = "It's a fish meal!",
--
--        SUNKENCHEST =
--        {
--            GENERIC = "The real treasure is the treasure we found along the way.",
--            LOCKED = "It's clammed right up!",
--        },
--
--        HERMIT_BUNDLE = "She shore shells out a lot of these.",
--        HERMIT_BUNDLE_SHELLS = "She DOES sell sea shells!",
--
--        RESKIN_TOOL = "I like the dust! It feels scholarly!",
--        MOON_FISSURE_PLUGGED = "Pretty effective.",
--
--
--		----------------------- ROT STRINGS GO ABOVE HERE ------------------
--
--		-- Walter
--        WOBYBIG =
--        {
--            "You have been feeding her good lately?",
--            "You have been feeding her good lately?",
--        },
--        WOBYSMALL =
--        {
--            "Petting a good dog will improve your day.",
--            "Petting a good dog will improve your day.",
--        },
--		WALTERHAT = "I cannot wear this.",
--		SLINGSHOT = "The bane of windows everywhere.",
--		SLINGSHOTAMMO_ROCK = "Shots to be slinged.",
--		SLINGSHOTAMMO_MARBLE = "Shots to be slinged.",
--		SLINGSHOTAMMO_THULECITE = "Shots to be slinged.",
--        SLINGSHOTAMMO_GOLD = "Shots to be slinged.",
--        SLINGSHOTAMMO_SLOW = "Shots to be slinged.",
--        SLINGSHOTAMMO_FREEZE = "Shots to be slinged.",
--		SLINGSHOTAMMO_POOP = "Poop projectiles.",
--        PORTABLETENT = "I feel like I haven't had a proper night's sleep in ages!",
--        PORTABLETENT_ITEM = "This requires some a-tent-tion.",
--
--        -- Wigfrid
--        BATTLESONG_DURABILITY = "Theater makes me fidgety.",
--        BATTLESONG_HEALTHGAIN = "Theater makes me fidgety.",
--        BATTLESONG_SANITYGAIN = "Theater makes me fidgety.",
--        BATTLESONG_SANITYAURA = "Theater makes me fidgety.",
--        BATTLESONG_FIRERESISTANCE = "I once burned my vest before seeing a play. I call that dramatic ironing.",
--        BATTLESONG_INSTANT_TAUNT = "I'm afraid I'm not a licensed poetic.",
--        BATTLESONG_INSTANT_PANIC = "I'm afraid I'm not a licensed poetic.",
--
--        -- Webber
--        MUTATOR_WARRIOR = "Oh wow, that looks um... delicious, Webber!",
--        MUTATOR_DROPPER = "Ah, I... just ate! Why don't you give it to one of your spider friends?",
--        MUTATOR_HIDER = "Oh wow, that looks um... delicious, Webber!",
--        MUTATOR_SPITTER = "Ah, I... just ate! Why don't you give it to one of your spider friends?",
--        MUTATOR_MOON = "Oh wow, that looks um... delicious, Webber!",
--        MUTATOR_HEALER = "Ah, I... just ate! Why don't you give it to one of your spider friends?",
--        SPIDER_WHISTLE = "I don't want to call any spiders over to me!",
--        SPIDERDEN_BEDAZZLER = "It looks like someone's been getting crafty.",
--        SPIDER_HEALER = "Oh wonderful. Now the spiders can heal themselves.",
--        SPIDER_REPELLENT = "...",
--        SPIDER_HEALER_ITEM = "If I see any spiders around I'll be sure to give it to them. Maybe.",
--
--		-- Wendy
--		GHOSTLYELIXIR_SLOWREGEN = "Potions! My favourite type of magic.",
--		GHOSTLYELIXIR_FASTREGEN = "Potions! My favourite type of magic.",
--		GHOSTLYELIXIR_SHIELD = "Potions! My favourite type of magic.",
--		GHOSTLYELIXIR_ATTACK = "Potions! My favourite type of magic.",
--		GHOSTLYELIXIR_SPEED = "Potions! My favourite type of magic.",
--		GHOSTLYELIXIR_RETALIATION = "Potions! My favourite type of magic.",
--		SISTURN =
--		{
--			GENERIC = "Some flowers would liven it up a bit.",
--			SOME_FLOWERS = "A few more flowers should do the trick.",
--			LOTS_OF_FLOWERS = "What a brilliant boo-quet!",
--		},
--
--        --Wortox
--        WORTOX_SOUL = "only_used_by_wortox", --only wortox can inspect souls
--
--        PORTABLECOOKPOT_ITEM =
--        {
--            GENERIC = "Now we're cookin'!",
--            DONE = "Now we're done cookin'!",
--
--            COOKING_LONG = "It needs a lot of time.",
--			COOKING_SHORT = "Any minute now.",
--			EMPTY = "I bet there's nothing in there.",
--        },
--
--        PORTABLEBLENDER_ITEM = "It mixes all the food.",
--        PORTABLESPICER_ITEM =
--        {
--            GENERIC = "This will spice things up.",
--            DONE = "Should make things a little tastier.",
--        },
--        SPICEPACK = "A breakthrough in culinary art!",
--        SPICE_GARLIC = "A powerfully potent powder.",
--        SPICE_SUGAR = "Sweet! It's sweet!",
--        SPICE_CHILI = "A flagon of fiery fluid.",
--        SPICE_SALT = "A little sodium's good for the heart.",
--        MONSTERTARTARE = "There's got to be something else to eat around here.",
--        FRESHFRUITCREPES = "Sugary fruit! Part of a balanced breakfast.",
--        FROGFISHBOWL = "Is that just... frogs stuffed inside a fish?",
--        POTATOTORNADO = "Potato, infused with the power of a tornado!",
--        DRAGONCHILISALAD = "I hope I can handle the spice level.",
--        GLOWBERRYMOUSSE = "Warly sure can cook.",
--        VOLTGOATJELLY = "It's shockingly delicious.",
--        NIGHTMAREPIE = "It's a little spooky.",
--        BONESOUP = "No bones about it, Warly can cook.",
--        MASHEDPOTATOES = "I've heard cooking is basically chemistry. I should try it.",
--        POTATOSOUFFLE = "I forgot what good food tasted like.",
--        MOQUECA = "He's as talented a chef as I am a dead person.",
--        GAZPACHO = "It tastes so good?",
--        ASPARAGUSSOUP = "Smells like it tastes.",
--        VEGSTINGER = "Can you use the celery as a straw?",
--        BANANAPOP = "No, not brain freeze!",
--        CEVICHE = "Can I get a bigger bowl? This one looks a little shrimpy.",
--        SALSA = "So... hot...!",
--        PEPPERPOPPER = "What a mouthful!",
--
--        TURNIP = "It's a raw turnip.",
--        TURNIP_COOKED = "Cooking in practice.",
--        TURNIP_SEEDS = "A handful of odd seeds.",
--
--        GARLIC = "The number one breath enhancer.",
--        GARLIC_COOKED = "Perfectly browned.",
--        GARLIC_SEEDS = "A handful of odd seeds.",
--
--        ONION = "Looks crunchy.",
--        ONION_COOKED = "A successful chemical reaction.",
--        ONION_SEEDS = "A handful of odd seeds.",
--
--        POTATO = "The apples of the earth.",
--        POTATO_COOKED = "Baked apples of the earth.",
--        POTATO_SEEDS = "A handful of odd seeds.",
--
--        TOMATO = "It's red because it's full of blood.",
--        TOMATO_COOKED = "Cooking's easy if you understand chemistry.",
--        TOMATO_SEEDS = "A handful of odd seeds.",
--
--        ASPARAGUS = "A vegetable.",
--        ASPARAGUS_COOKED = "It's good for us.",
--        ASPARAGUS_SEEDS = "It's asparagus seeds.",
--
--        PEPPER = "Nice and spicy.",
--        PEPPER_COOKED = "It was already hot to begin with.",
--        PEPPER_SEEDS = "A handful of seeds.",
--
--        WEREITEM_BEAVER = "What.",
--        WEREITEM_GOOSE = "That thing's giving ME goosebumps!",
--        WEREITEM_MOOSE = "A perfectly normal cursed moose thing.",
--
--        MERMHAT = "I cannot wear this.",
--        MERMTHRONE =
--        {
--            GENERIC = "Looks fit for a swamp king!",
--            BURNT = "There was something fishy about that throne anyway.",
--        },
--        MERMTHRONE_CONSTRUCTION =
--        {
--            GENERIC = "Just what is she planning?",
--            BURNT = "I suppose we'll never know what it was for now.",
--        },
--        MERMHOUSE_CRAFTED =
--        {
--            GENERIC = "It's actually kind of cute.",
--            BURNT = "Ugh, the smell!",
--        },
--
--        MERMWATCHTOWER_REGULAR = "They seem happy to have found a king.",
--        MERMWATCHTOWER_NOKING = "A royal guard with no Royal to guard.",
--        MERMKING = "Your Majesty!",
--        MERMGUARD = "I feel very guarded around these guys...",
--        MERM_PRINCE = "They operate on a first-come, first-sovereigned basis.",
--
--        SQUID = "I have an inkling they'll come in handy.",
--
--		GHOSTFLOWER = "Yes, yes. Oh my.",
--        SMALLGHOST = "Aww, does someone have a little boo-boo?",
--
--        CRABKING =
--        {
--            GENERIC = "Yikes! A little too crabby for me.",
--            INERT = "That castle needs a little decoration.",
--        },
--		CRABKING_CLAW = "That's claws for alarm!",
--
--		MESSAGEBOTTLE = "I wonder if it's for me!",
--		MESSAGEBOTTLEEMPTY = "It's full of nothing.",
--
--        MEATRACK_HERMIT =
--        {
--            DONE = "Jerky time!",
--            DRYING = "Meat takes a while to dry.",
--            DRYINGINRAIN = "Meat takes even longer to dry in rain.",
--            GENERIC = "Those look like they could use some meat.",
--            BURNT = "The rack got dried.",
--            DONE_NOTMEAT = "In laboratory terms, we would call that \"dry\".",
--            DRYING_NOTMEAT = "Drying thing.",
--            DRYINGINRAIN_NOTMEAT = "Rain, rain, go away. Be wet again another day.",
--        },
--        BEEBOX_HERMIT =
--        {
--            READY = "It's full of honey.",
--            FULLHONEY = "It's full of honey.",
--            GENERIC = "I'm sure there's a little sweetness to be found inside.",
--            NOHONEY = "It's empty.",
--            SOMEHONEY = "Need to wait a bit.",
--            BURNT = "How did it get burned?!!",
--        },
--
--        HERMITCRAB = "Living by yourshellf must get abalonely.",
--
--        HERMIT_PEARL = "I'll take good care of it.",
--        HERMIT_CRACKED_PEARL = "I... didn't take good care of it.",
--
--        -- DSEAS
--        WATERPLANT = "As long as we don't take their barnacles, they'll stay our buds.",
--        WATERPLANT_BOMB = "We're under seedge!",
--        WATERPLANT_BABY = "This one's just a sprout.",
--        WATERPLANT_PLANTER = "They seem to grow best on oceanic rocks.",
--
--        SHARK = "We may need a bigger boat...",
--
--        MASTUPGRADE_LAMP_ITEM = "I'm full of bright ideas.",
--        MASTUPGRADE_LIGHTNINGROD_ITEM = "I've harnessed the power of electricity over land and sea!",
--
--        WATERPUMP = "It puts out fires very a-fish-iently.",
--
--        BARNACLE = "They don't look like knuckles to me.",
--        BARNACLE_COOKED = "I'm told it's quite a delicacy.",
--
--        BARNACLEPITA = "Barnacles taste better when you can't see them.",
--        BARNACLESUSHI = "I still seem to have misplaced my chopsticks.",
--        BARNACLINGUINE = "Pass the pasta!",
--        BARNACLESTUFFEDFISHHEAD = "I'm just hungry enough to consider it...",
--
--        LEAFLOAF = "Mystery leaf meat.",
--        LEAFYMEATBURGER = "Vegetarian, but not cruelty-free.",
--        LEAFYMEATSOUFFLE = "Curious.",
--        MEATYSALAD = "Strangely filling, for a salad.",
--
--        -- GROTTO
--
--		MOLEBAT = "A regular Noseferatu.",
--        MOLEBATHILL = "I wonder what might be stuck in that rat's nest.",
--
--        BATNOSE = "Why would I eat that?",
--        BATNOSE_COOKED = "It is still disgusting.",
--        BATNOSEHAT = "No way I am putting this on.",
--
--        MUSHGNOME = "It might be aggressive, but only sporeradically.",
--
--        SPORE_MOON = "I'll keep as mushroom between me and those spores as I can.",
--
--        MOON_CAP = "Death flower of longing.",
--        MOON_CAP_COOKED = "Ok?",
--
--        MUSHTREE_MOON = "This mushroom tree is clearly stranger than the rest.",
--
--        LIGHTFLIER = "How strange!",
--
--        GROTTO_POOL_BIG = "The moon water makes the glass grow.",
--        GROTTO_POOL_SMALL = "The moon water makes the glass grow.",
--
        DUSTMOTH = "爱整洁的小家伙, 不是吗?",
--
        DUSTMOTHDEN = "它们在里面会像幼虫一样舒适.",
--
--        ARCHIVE_LOCKBOX = "Give me a piece now.",
        ARCHIVE_CENTIPEDE = "我的脸丢了, 所以它会攻击我.",
        ARCHIVE_CENTIPEDE_HUSK = "好吧.",
--
--        ARCHIVE_COOKPOT =
--        {
--            COOKING_LONG = "It needs a lot of time.",
--			COOKING_SHORT = "Any minute now.",
--			DONE = "Done.",
--			EMPTY = "Put things in, take things out.",
--			BURNT = "Someone lost control of the kitchen.",
--        },
--
        ARCHIVE_MOON_STATUE = "我希望你们喜欢它, 它是我的创作.",
        ARCHIVE_RUNE_STATUE =
        {
            LINE_1 = "这些是我的笔记!",
            LINE_2 = "这个是关于怎么去月球的逃脱计划.",
            LINE_3 = "这个是关于能量使用的!",
            LINE_4 = "哦不.",
            LINE_5 = "...",
        },
--
--        ARCHIVE_RESONATOR = {
--            GENERIC = "Why use a map when you could use a mind-bogglingly complex piece of machinery?",
--            IDLE = "It seems to have found everything worth finding.",
--        },
--
--        ARCHIVE_RESONATOR_ITEM = "Find him.",
--
--        ARCHIVE_LOCKBOX_DISPENCER = {
--          POWEROFF = "The power is off.",
--          GENERIC =  "Give me a piece now.",
--        },
--
        ARCHIVE_SECURITY_DESK = {
            POWEROFF = "电源未启用.",
            GENERIC = "工作情况正如预期.",
        },
--
--        ARCHIVE_SECURITY_PULSE = "Howdy?",
--
--        ARCHIVE_SWITCH = {
--            VALID = "The gem is right.",
--            GEMS = "The socket is empty.",
--        },
--
        ARCHIVE_PORTAL = {
            POWEROFF = "先激活电源.",
            GENERIC = "其他部分哪里去了?",
        },
--
--        WALL_STONE_2 = "That's a nice wall.",
--        WALL_RUINS_2 = "A wall.",
--
        REFINED_DUST = "和揉面团差不多. 但只是差不多.",   -----------------------new
        DUSTMERINGUE = "我很乐意吃, 但它看起来太棒了!",  ----------------new
--
--        SHROOMCAKE = "It lives up to its name.",
--
--        NIGHTMAREGROWTH = "Those crystals might be cause for some concern.",
--
--        TURFCRAFTINGSTATION = "To make the good stuff!",
--
--        MOON_ALTAR_LINK = "It must be building up to something.",
--
--        -- FARMING
--        COMPOSTINGBIN =
--        {
--            GENERIC = "I can barrel-y stand the smell.",
--            WET = "That looks too soggy.",
--            DRY = "Hm... too dry.",
--            BALANCED = "Just right!",
--            BURNT = "I didn't think it could smell any worse...",
--        },
--        COMPOST = "Food for plants, and not much else.",
--        SOIL_AMENDER =
--		{
--			GENERIC = "Now we wait.",
--			STALE = "Wait longer.",
--			SPOILED = "That stomach-churning smell means it's working!",
--		},
--
--		SOIL_AMENDER_FERMENTED = "That's some strong fertilizer!",
--
--        WATERINGCAN =
--        {
--            GENERIC = "I can water the plants with this.",
--            EMPTY = "Maybe there's a pond around here somewhere...",
--        },
--        PREMIUMWATERINGCAN =
--        {
--            GENERIC = "Gross!",
--            EMPTY = "It won't do me much good without water.",
--        },
--
--		FARM_PLOW = "A convenient plot device.",
--		FARM_PLOW_ITEM = "Plan your farms carefully.",
--		FARM_HOE = "Me too.",
--		GOLDEN_FARM_HOE = "Me too.",
--		NUTRIENTSGOGGLESHAT = "I used to wear this, now I can't seem to fit it on my head.",
--		PLANTREGISTRYHAT = "I used to wear this, now I can't seem to fit it on my head.",
--
--        FARM_SOIL_DEBRIS = "It's making a mess of my garden.",
--
--		FIRENETTLES = "If you can't stand the heat, stay out of the garden.",
--		FORGETMELOTS = "Hm. I can't remember what I was going to say about those.",
--		SWEETTEA = "A nice cup of tea to forget all my problems.",
--		TILLWEED = "Out of my garden, you!",
--		TILLWEEDSALVE = "My salve-ation.",
--        WEED_IVY = "Hey, you're not a vegetable!",
--        IVY_SNARE = "Now that's just rude.",
--
--		TROPHYSCALE_OVERSIZEDVEGGIES =
--		{
--			GENERIC = "I can mesaure.",
--			HAS_ITEM = "Weight: {weight}\nHarvested on day: {day}\nNot bad.",
--			HAS_ITEM_HEAVY = "Weight: {weight}\nHarvested on day: {day}\nWho knew they grew that big?",
--            HAS_ITEM_LIGHT = "It's so average the scale isn't even bothering to tell me its weight.",
--			BURNING = "Mmm, what's cooking?",
--			BURNT = "I suppose that wasn't the best way to cook it.",
--        },
--
--        CARROT_OVERSIZED = "That's one big bunch of carrots!",
--        CORN_OVERSIZED = "Big knob!",
--        PUMPKIN_OVERSIZED = "Pumpkin.",
--        EGGPLANT_OVERSIZED = "Is it friend shaped?",
--        DURIAN_OVERSIZED = "Love it.",
--        POMEGRANATE_OVERSIZED = "The sinful fruit.",
--        DRAGONFRUIT_OVERSIZED = "Shall it fly off?",
--        WATERMELON_OVERSIZED = "A big, juicy watermelon.",
--        TOMATO_OVERSIZED = "A tomato of incredible proportions.",
--        POTATO_OVERSIZED = "Feeds big families.",
--        ASPARAGUS_OVERSIZED = "I guess we'll be eating asparagus for a while...",
--        ONION_OVERSIZED = "Oi!",
--        GARLIC_OVERSIZED = "A gargantuan garlic!",
--        PEPPER_OVERSIZED = "A pepper of rather unusual size.",
--
--        VEGGIE_OVERSIZED_ROTTEN = "What rotten luck.",
--
--		FARM_PLANT =
--		{
--			GENERIC = "That's a plant!",
--			SEED = "And now, we wait.",
--			GROWING = "Grow my beautiful creation, grow!",
--			FULL = "Time to reap.",
--			ROTTEN = "Too late.",
--			FULL_OVERSIZED = "!",
--			ROTTEN_OVERSIZED = "Burn it.",
--			FULL_WEED = "I knew I'd weed out the imposter eventually!",
--
--			BURNING = "That can't be good for the plants...",
--		},
--
--        FRUITFLY = "Buzz off!",
--        LORDFRUITFLY = "Hey, stop upsetting the plants!",
--        FRIENDLYFRUITFLY = "The garden seems happier with it around.",
--        FRUITFLYFRUIT = "Now I'm in charge!",
--
--        SEEDPOUCH = "I was getting tired of carrying loose seeds in my pockets.",
--
--		-- Crow Carnival
--		CARNIVAL_HOST = "What an odd fellow.",
--		CARNIVAL_CROWKID = "Good day to you, small bird person.",
--		CARNIVAL_GAMETOKEN = "One shiny token.",
--		CARNIVAL_PRIZETICKET =
--		{
--			GENERIC = "That's the ticket!",
--			GENERIC_SMALLSTACK = "That's the tickets!",
--			GENERIC_LARGESTACK = "That's a lot of tickets!",
--		},
--
--		CARNIVALGAME_FEEDCHICKS_NEST = "It's a little trapdoor.",
--		CARNIVALGAME_FEEDCHICKS_STATION =
--		{
--			GENERIC = "It won't let me play until I give it something shiny.",
--			PLAYING = "This looks like fun!",
--		},
--		CARNIVALGAME_FEEDCHICKS_KIT = "This really is a pop-up carnival.",
--		CARNIVALGAME_FEEDCHICKS_FOOD = "I don't need to chew them up first, do I?",
--
--		CARNIVALGAME_MEMORY_KIT = "This really is a pop-up carnival.",
--		CARNIVALGAME_MEMORY_STATION =
--		{
--			GENERIC = "It won't let me play until I give it something shiny.",
--			PLAYING = "Not to brag, but I've been called a bit of an egghead in the past.",
--		},
--		CARNIVALGAME_MEMORY_CARD =
--		{
--			GENERIC = "It's a little trapdoor.",
--			PLAYING = "Is this the right one?",
--		},
--
--		CARNIVALGAME_HERDING_KIT = "This really is a pop-up carnival.",
--		CARNIVALGAME_HERDING_STATION =
--		{
--			GENERIC = "It won't let me play until I give it something shiny.",
--			PLAYING = "Those eggs are looking a little runny.",
--		},
--		CARNIVALGAME_HERDING_CHICK = "Come back here!",
--
--		CARNIVALGAME_SHOOTING_KIT = "This really is a pop-up carnival.",
--		CARNIVALGAME_SHOOTING_STATION =
--		{
--			GENERIC = "It won't let me play until I give it something shiny.",
--			PLAYING = "I could calculate the trajectory, but it involves a lot of complicated numbers and squiggles.",
--		},
--		CARNIVALGAME_SHOOTING_TARGET =
--		{
--			GENERIC = "It's a little trapdoor.",
--			PLAYING = "That target's really starting to bug me.",
--		},
--
--		CARNIVALGAME_SHOOTING_BUTTON =
--		{
--			GENERIC = "It won't let me play until I give it something shiny.",
--			PLAYING = "What is it?",
--		},
--
--		CARNIVALGAME_WHEELSPIN_KIT = "This really is a pop-up carnival.",
--		CARNIVALGAME_WHEELSPIN_STATION =
--		{
--			GENERIC = "It won't let me play until I give it something shiny.",
--			PLAYING = "It turns out that spinning your wheels is actually very productive.",
--		},
--
--		CARNIVALGAME_PUCKDROP_KIT = "This really is a pop-up carnival.",
--		CARNIVALGAME_PUCKDROP_STATION =
--		{
--			GENERIC = "It won't let me play until I give it something shiny.",
--			PLAYING = "Physics don't always work the same way twice.",
--		},
--
--		CARNIVAL_PRIZEBOOTH_KIT = "The real prize is the booth we made along the way.",
--		CARNIVAL_PRIZEBOOTH =
--		{
--			GENERIC = "I've got my eyes on the prize. That one, over there!",
--		},
--
--		CARNIVALCANNON_KIT = "Pow.",
--		CARNIVALCANNON =
--		{
--			GENERIC = "Boom!",
--			COOLDOWN = "What a blast!",
--		},
--
--		CARNIVAL_PLAZA_KIT = "Birds love trees.",
--		CARNIVAL_PLAZA =
--		{
--			GENERIC = "It doesn't really scream \"Cawnival\" yet, does it?",
--			LEVEL_2 = "A little birdy told me it could use some more decorations around here.",
--			LEVEL_3 = "This tree is caws for celebration!",
--		},
--
--		CARNIVALDECOR_EGGRIDE_KIT = "I hope this prize is all it's cracked up to be.",
--		CARNIVALDECOR_EGGRIDE = "I could watch it for hours.",
--
--		CARNIVALDECOR_LAMP_KIT = "Only some light work left to do.",
--		CARNIVALDECOR_LAMP = "It's powered by whimsy.",
--		CARNIVALDECOR_PLANT_KIT = "Maybe it's a boxwood?",
--		CARNIVALDECOR_PLANT = "Either it's small, or I'm gigantic.",
--		CARNIVALDECOR_BANNER_KIT = "I have to build it myself? I should have known there'd be a catch.",
--		CARNIVALDECOR_BANNER = "I think all these shiny decorations reflect well on me.",
--
--		CARNIVALDECOR_FIGURE =
--		{
--			RARE = "See? Proof that trying the exact same thing over and over will eventually lead to success!",
--			UNCOMMON = "You don't see this kind of design too often.",
--			GENERIC = "I seem to be getting a lot of these...",
--		},
--		CARNIVALDECOR_FIGURE_KIT = "The thrill of discovery!",
--		CARNIVALDECOR_FIGURE_KIT_SEASON2 = "The thrill of discovery!",
--
--        CARNIVAL_BALL = "It's genius in its simplicity.", --unimplemented
--		CARNIVAL_SEEDPACKET = "I was feeling a bit peckish.",
--		CARNIVALFOOD_CORNTEA = "Is this drink supposed to be crunchy?",
--
--        CARNIVAL_VEST_A = "I think it makes me look adventurous.",
--        CARNIVAL_VEST_B = "It's like wearing my own shade tree.",
--        CARNIVAL_VEST_C = "I hope there's no bugs in it...",
--
--        -- YOTB
--        YOTB_SEWINGMACHINE = "Sewing can't be that hard... can it?",
--        YOTB_SEWINGMACHINE_ITEM = "There looks to be a bit of assembly required.",
--        YOTB_STAGE = "Strange, I never see him enter or leave...",
--        YOTB_POST =  "This contest is going to go off without a hitch! Well, figuratively speaking.",
--        YOTB_STAGE_ITEM = "It looks like a bit of building is in order.",
--        YOTB_POST_ITEM =  "I'd better get that set up.",
--
--
--        YOTB_PATTERN_FRAGMENT_1 = "If I put some of these together, I bet I could make a folkwear.",
--        YOTB_PATTERN_FRAGMENT_2 = "If I put some of these together, I bet I could make a folkwear.",
--        YOTB_PATTERN_FRAGMENT_3 = "If I put some of these together, I bet I could make some folkwear.",
--
--        YOTB_BEEFALO_DOLL_WAR = {
--            GENERIC = "A doll of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--        YOTB_BEEFALO_DOLL_DOLL = {
--            GENERIC = "A dool of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--        YOTB_BEEFALO_DOLL_FESTIVE = {
--            GENERIC = "A dool of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--        YOTB_BEEFALO_DOLL_NATURE = {
--            GENERIC = "A dool of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--        YOTB_BEEFALO_DOLL_ROBOT = {
--            GENERIC = "A dool of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--        YOTB_BEEFALO_DOLL_ICE = {
--            GENERIC = "A dool of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--        YOTB_BEEFALO_DOLL_FORMAL = {
--            GENERIC = "A dool of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--        YOTB_BEEFALO_DOLL_VICTORIAN = {
--            GENERIC = "A dool of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--        YOTB_BEEFALO_DOLL_BEAST = {
--            GENERIC = "A dool of a beast dressed in a folkwear.",
--            YOTB = "I wonder what the Judge would say about this?",
--        },
--
--        WAR_BLUEPRINT = "How ferocious!",
--        DOLL_BLUEPRINT = "My beefalo will look as cute as a button!",
--        FESTIVE_BLUEPRINT = "This is just the occasion for some festivity!",
--        ROBOT_BLUEPRINT = "This requires a suspicious amount of welding for a sewing project.",
--        NATURE_BLUEPRINT = "You really can't go wrong with flowers.",
--        FORMAL_BLUEPRINT = "This is a costume for some Grade A beefalo.",
--        VICTORIAN_BLUEPRINT = "I think my grandmother wore something similar.",
--        ICE_BLUEPRINT = "I usually like my beefalo fresh, not frozen.",
--        BEAST_BLUEPRINT = "I'm feeling lucky about this one!",
--
--        BEEF_BELL = "It makes beefalo friendly.",
--
--		-- YOT Catcoon
--		KITCOONDEN =
--		{
--			GENERIC = "You'd have to be pretty small to fit in there.",
--            BURNT = "NOOOO!",
--			PLAYING_HIDEANDSEEK = "Now where could they be...",
--			PLAYING_HIDEANDSEEK_TIME_ALMOST_UP = "Not much time left! Where are they?!",
--		},
--
--		KITCOONDEN_KIT = "The whole kit and caboodle.",
--
--		TICOON =
--		{
--			GENERIC = "He looks like he knows what he's doing!",
--			ABANDONED = "I'm sure I can find them on my own.",
--			SUCCESS = "Hey, he found one!",
--			LOST_TRACK = "Someone else found them first.",
--			NEARBY = "Looks like there's something nearby.",
--			TRACKING = "I should follow his lead.",
--			TRACKING_NOT_MINE = "He's leading the way for someone else.",
--			NOTHING_TO_TRACK = "It doesn't look like there's anything left to find.",
--			TARGET_TOO_FAR_AWAY = "They might be too far away for him to sniff out.",
--		},
--
--		YOT_CATCOONSHRINE =
--        {
--            GENERIC = "What to make...",
--            EMPTY = "Maybe it would like a feather to play with...",
--            BURNT = "Smells like scorched fur.",
--        },
--
--		KITCOON_FOREST = "Little devil.",
--		KITCOON_SAVANNA = "Little devil.",
--		KITCOON_MARSH = "Little devil.",
--		KITCOON_DECIDUOUS = "Little devil.",
--		KITCOON_GRASS = "Little devil.",
--		KITCOON_ROCKY = "Little devil.",
--		KITCOON_DESERT = "Little devil.",
--		KITCOON_MOON = "How are you holding up, Lucio?",
--		KITCOON_YOT = "Little devil.",
--
--        -- Moon Storm
--        ALTERGUARDIAN_PHASE1 = {
--            GENERIC = "Is it only the beginning?",
--            DEAD = "I think there is more where that came from.",
--        },
--        ALTERGUARDIAN_PHASE2 = {
--            GENERIC = "I think I just made it angry...",
--            DEAD = "It is not the end yet.",
--        },
--        ALTERGUARDIAN_PHASE2SPIKE = "I understand now!",
--        ALTERGUARDIAN_PHASE3 = "It's definitely angry now!",
--        ALTERGUARDIAN_PHASE3TRAP = "No sleep.",
--        ALTERGUARDIAN_PHASE3DEADORB = "I have killed a part of the moon.",
--        ALTERGUARDIAN_PHASE3DEAD = "I have killed a part of the moon.",
--
--        ALTERGUARDIANHAT = "Lets break it down and use the pieces in something else!",
--        ALTERGUARDIANHATSHARD = "Now I should go to the Divine Globe Clock and make something nice for myself.",
--
--        MOONSTORM_GLASS = {
--            GENERIC = "It's glassy.",
--            INFUSED = "It'll come in handy."
--        },
--
--        MOONSTORM_STATIC = "...",
--        MOONSTORM_STATIC_ITEM = "I wish I could meet with you here.",
--        MOONSTORM_SPARK = "Shocking.",
--
--        BIRD_MUTANT = "I think that used to be a crow.",
--        BIRD_MUTANT_SPITTER = "I don't like the way it's looking at me...",
--
--        WAGSTAFF_NPC = "I despise you.",
--        ALTERGUARDIAN_CONTAINED = "NO!",
--
--        WAGSTAFF_TOOL_1 = "It looks like my tool! Reticulating Buffer.",
--        WAGSTAFF_TOOL_2 = "It looks like my tool! Widget Deflubber.",
--        WAGSTAFF_TOOL_3 = "It looks like my tool! Grommet Scriber.",
--        WAGSTAFF_TOOL_4 = "It looks like my tool! Conceptual Scrubber.",
--        WAGSTAFF_TOOL_5 = "It looks like my tool! Calibrated Perceiver.",
--
--        MOONSTORM_GOGGLESHAT = "This is not fitted for my head.",
--
--        MOON_DEVICE = {
--            GENERIC = "Am I going to see you again my love?",
--            CONSTRUCTION1 = "Only one step closer to you.",
--            CONSTRUCTION2 = "Closer...",
--        },
--
--		-- Wanda
--        POCKETWATCH_HEAL = {
--			GENERIC = "It can be used.",
--			RECHARGING = "The time is always wrong.",
--		},
--
--        POCKETWATCH_REVIVE = {
--			GENERIC = "It can be used.",
--			RECHARGING = "The time is always wrong.",
--		},
--
--        POCKETWATCH_WARP = {
--			GENERIC = "It can be used.",
--			RECHARGING = "The time is always wrong.",
--		},
--
--        POCKETWATCH_RECALL = {
--			GENERIC = "It can be used.",
--			RECHARGING = "The time is always wrong.",
--			UNMARKED = "only_used_by_wanda",
--			MARKED_SAMESHARD = "only_used_by_wanda",
--			MARKED_DIFFERENTSHARD = "only_used_by_wanda",
--		},
--
--        POCKETWATCH_PORTAL = {
--			GENERIC = "It can be used.",
--			RECHARGING = "The time is always wrong.",
--			UNMARKED = "only_used_by_wanda unmarked",
--			MARKED_SAMESHARD = "only_used_by_wanda same shard",
--			MARKED_DIFFERENTSHARD = "only_used_by_wanda other shard",
--		},
--
--        POCKETWATCH_WEAPON = {
--			GENERIC = "The time is always wrong.",
--			DEPLETED = "only_used_by_wanda",
--		},
--
--        POCKETWATCH_PARTS = "Time guts.",
--        POCKETWATCH_DISMANTLER = "Tools.",
--
--        POCKETWATCH_PORTAL_ENTRANCE =
--		{
--			GENERIC = "Onward!",
--			DIFFERENTSHARD = "Onward!",
--		},
--        POCKETWATCH_PORTAL_EXIT = "It's a long drop down.",
--
--        -- Waterlog
--        WATERTREE_PILLAR = "That tree is massive!",
--        OCEANTREE = "I think these trees are a little lost.",
--        OCEANTREENUT = "There's something alive inside.",
--        WATERTREE_ROOT = "It's not a square root.",
--
--        OCEANTREE_PILLAR = "Cool.",
--
--        OCEANVINE = "Like little lamps.",
--        FIG = "Smells like nothing.",
--        FIG_COOKED = "It's almost tasteless.",
--
--        SPIDER_WATER = "I hope you fall in the water.",
--        MUTATOR_WATER = "Spider food.",
--        OCEANVINE_COCOON = "Interesting construction.",
--        OCEANVINE_COCOON_BURNT = "I smell burnt toast.",
--
--        GRASSGATOR = "I want to kiss those grassy cheeks.",
--
--        TREEGROWTHSOLUTION = "Growth goo for the tree.",
--
--        FIGATONI = "Yes.",
--        FIGKABAB = "Yummy.",
--        KOALEFIG_TRUNK = "This should be illegal.",
--        FROGNEWTON = "Ok.",
--
--        -- The Terrorarium
--        TERRARIUM = {
--            GENERIC = "Looking at it makes my head feel fuzzy... or... blocky?",
--            CRIMSON = "I have a nasty feeling about this...",
--            ENABLED = "Am I on the other side of the rainbow?!",
--			WAITING_FOR_DARK = "What could it be? Maybe I'll sleep on it.",
--			COOLDOWN = "It needs to cool down after that.",
--			SPAWN_DISABLED = "I shouldn't be bothered by anymore prying eyes now.",
--        },
--
--        -- Wolfgang
--        MIGHTY_GYM =
--        {
--            GENERIC = "For what?",
--            BURNT = "For that.",
--        },
--
--        DUMBBELL = "A tool?",
--        DUMBBELL_GOLDEN = "A shiny tool?",
--		DUMBBELL_MARBLE = "A heavy tool!",
--        DUMBBELL_GEM = "A tool.",
--        POTATOSACK = "It is filled with precious rocks.",
--
--
--        TERRARIUMCHEST =
--		{
--			GENERIC = "And it doesn't need a key, now we are talking!",
--			BURNT = "Ehh.",
--			SHIMMER = "Play Terraria now.",
--		},
--
--		EYEMASKHAT = "Eww gross.",
--
--        EYEOFTERROR = "Go for the eye!",
--        EYEOFTERROR_MINI = "I'm starting to feel self-conscious.",
--        EYEOFTERROR_MINI_GROUNDED = "I think it's about to hatch...",
--
--        FROZENBANANADAIQUIRI = "Yellow and mellow.",
--        BUNNYSTEW = "This one's luck has run out.",
--        MILKYWHITES = "...噫.",
--
--        CRITTER_EYEOFTERROR = "Always good to have another set of eyes! Er... eye.",
--
--        SHIELDOFTERROR ="What does that mouth do?",
--        TWINOFTERROR1 = "Soul of sight? Anyone?",
--        TWINOFTERROR2 = "Hallowed bars? Anyone?",
--
--        -- Year of the Catcoon
--        CATTOY_MOUSE = "Mice with wheels.",
--        KITCOON_NAMETAG = "Makes these creatures think of being tame.",
--
--		KITCOONDECOR1 =
--        {
--            GENERIC = "It's not a real bird, but the kits don't know that.",
--            BURNT = "Combustion!",
--        },
--		KITCOONDECOR2 =
--        {
--            GENERIC = "Those kits are so easily distracted. Now what was I doing again?",
--            BURNT = "It went up in flames.",
--        },
--
--		KITCOONDECOR1_KIT = "It looks like there's some assembly required.",
--		KITCOONDECOR2_KIT = "It doesn't look too hard to build.",
--
--        -- WX78
--        WX78MODULE_MAXHEALTH = "Washing machine heart.",
--        WX78MODULE_MAXSANITY1 = "Washing machine heart.",
--        WX78MODULE_MAXSANITY = "Washing machine heart.",
--        WX78MODULE_MOVESPEED = "Washing machine heart.",
--        WX78MODULE_MOVESPEED2 = "Washing machine heart.",
--        WX78MODULE_HEAT = "Washing machine heart.",
--        WX78MODULE_NIGHTVISION = "Washing machine heart.",
--        WX78MODULE_COLD = "Washing machine heart.",
--        WX78MODULE_TASER = "Washing machine heart.",
--        WX78MODULE_LIGHT = "Washing machine heart.",
--        WX78MODULE_MAXHUNGER1 = "Washing machine heart.",
--        WX78MODULE_MAXHUNGER = "Washing machine heart.",
--        WX78MODULE_MUSIC = "Washing machine heart.",
--        WX78MODULE_BEE = "Washing machine heart.",
--        WX78MODULE_MAXHEALTH2 = "Washing machine heart.",
--
--        WX78_SCANNER =
--        {
--            GENERIC ="WX-78 really puts a piece of themselves into their work.",
--            HUNTING = "Get that data!",
--            SCANNING = "Seems like it's found something.",
--        },
--
--        WX78_SCANNER_ITEM = "Is it a fly?",
--        WX78_SCANNER_SUCCEEDED = "It's got the look of someone eager to show their work.",
--
--        WX78_MODULEREMOVER = "Obviously a very delicate and complicated scientific instrument.",
--
--        SCANDATA = "Notes written in a weird sequence.",
--
--		-- QOL 2022
--		JUSTEGGS = "Yum.",
--		VEGGIEOMLET = "Mmmmm.",
--		TALLEGGS = "Big food.",
--		BEEFALOFEED = "None for me, thank you.",
--		BEEFALOTREAT = "A bit too grainy for my taste.",
--
--        -- Pirates
--        BOAT_ROTATOR = "Things are going in the right direction. Or maybe the left.",
--        BOAT_ROTATOR_KIT = "I think I'll take it out for a spin.",
--        BOAT_BUMPER_KELP = "It won't save the boat from everything, but it sure kelps.",
--        BOAT_BUMPER_KELP_KIT = "A soon-to-be boat bumper.",
--        BOAT_BUMPER_SHELL = "It gives the boat a little shellf defence.",
--        BOAT_BUMPER_SHELL_KIT = "A soon-to-be boat bumper.",
--        BOAT_CANNON = {
--            GENERIC = "I should load it with something.",
--            AMMOLOADED = "The cannon is ready to fire!",
--            NOAMMO = "I didn't forget the cannonballs, I'm just letting the anticipation build.",
--        },
--        BOAT_CANNON_KIT = "It's not a cannon yet, but it will be.",
--        CANNONBALL_ROCK_ITEM = "This will fit into a cannon perfectly.",
--
--        OCEAN_TRAWLER = {
--            GENERIC = "It makes fishing more effishient.",
--            LOWERED = "And now we wait.",
--            CAUGHT = "It caught something!",
--            ESCAPED = "Looks like something was caught, but it escaped...",
--            FIXED = "All ready to catch fish again!",
--        },
--        OCEAN_TRAWLER_KIT = "I should put it somewhere with lots of fish.",
--
--        BOAT_MAGNET =
--        {
--            GENERIC = "I'm always drawn to physics, like a... ah, can't think of the word.",
--            ACTIVATED = "It's working!! Er, I knew it would work, of course.",
--        },
--        BOAT_MAGNET_KIT = "One of my more genius ideas, if I do say so myself.",
--
--        BOAT_MAGNET_BEACON =
--        {
--            GENERIC = "This will attract any strong magnets nearby.",
--            ACTIVATED = "Magnetism!",
--        },
--        DOCK_KIT = "Everything I need to build a dock for my boat.",
--        DOCK_WOODPOSTS_ITEM = "Aha! I thought the dock was missing something.",
--
--        MONKEYHUT =
--        {
--            GENERIC = "Treehouses are terribly flammable places.",
--            BURNT = "Like I said!",
--        },
--        POWDER_MONKEY = "Don't you dare monkey around with my boat!",
--        PRIME_MATE = "A nice hat is always a clear indicator of who's in charge.",
--		LIGHTCRAB = "It's bioluminous!",
--        CUTLESS = "What it lacks in slicing it makes up for in splinters.",
--        CURSED_MONKEY_TOKEN = "Attaches to the soul.",
--        OAR_MONKEY = "It really puts the paddle to the battle.",
--        BANANABUSH = "That bush is bananas!",
--        DUG_BANANABUSH = "That bush is bananas!",
--        PALMCONETREE = "Palm tree.",
--        PALMCONE_SEED = "The very beginnings of a tree.",
--        PALMCONE_SAPLING = "It has big dreams of being a tree one day.",
--        PALMCONE_SCALE = "If trees had toenails, I imagine they'd look like this.",
--        MONKEYTAIL = "I wonder if they're edible?",
--        DUG_MONKEYTAIL = "I wonder if they're edible?",
--
--        MONKEY_MEDIUMHAT = "No.",
--        MONKEY_SMALLHAT = "No.",
--        POLLY_ROGERSHAT = "No.",
--        POLLY_ROGERS = "Little bird.",
--
--        MONKEYISLAND_PORTAL = "I can't escape.",
--        MONKEYISLAND_PORTAL_DEBRIS = "Trash.",
--        MONKEYQUEEN = "Primate.",
--        MONKEYPILLAR = "A real pillar of the community.",
--        PIRATE_FLAG_POLE = "Ahoy!",
--
--        BLACKFLAG = "Yar.",
--        PIRATE_STASH = "For treasure.",
--        STASH_MAP = "Read it.",
--
--
--        BANANAJUICE = "Food.",
--
--        FENCE_ROTATOR = "Watch me swirl.",
--
--        CHARLIE_STAGE_POST = "The set.",
--        CHARLIE_LECTURN = "For storytelling.",
--
--        CHARLIE_HECKLER = "Brr.",
--
--        PLAYBILL_THE_DOLL = "\"Authored by C.W.\"",
--        STATUEHARP_HEDGESPAWNER = "The flowers grew back, but the head didn't.",
--        HEDGEHOUND = "Twisted brambles, that sting.",
--        HEDGEHOUND_BUSH = "It moves.",
--
--        MASK_DOLLHAT = "It's a doll mask.",
--        MASK_DOLLBROKENHAT = "It's a cracked doll mask.",
--        MASK_DOLLREPAIREDHAT = "It was a doll mask at one point.",
--        MASK_BLACKSMITHHAT = "It's a blacksmith mask.",
--        MASK_MIRRORHAT = "It's a mirror mask.",
--        MASK_QUEENHAT = "It's a Queen mask.",
--        MASK_KINGHAT = "It's a King mask.",
--        MASK_TREEHAT = "It's a tree mask.",
--        MASK_FOOLHAT = "It's a fool's mask.",
--
--        COSTUME_DOLL_BODY = "It's a doll costume.",
--        COSTUME_QUEEN_BODY = "It's a Queen costume.",
--        COSTUME_KING_BODY = "It's a King costume.",
--        COSTUME_BLACKSMITH_BODY = "It's a blacksmith costume.",
--        COSTUME_MIRROR_BODY = "It's a costume.",
--        COSTUME_TREE_BODY = "It's a tree costume.",
--        COSTUME_FOOL_BODY = "It's a fool's costume.",
--
--        STAGEUSHER =
--        {
--            STANDING = "Don't touch me.",
--            SITTING = "Wrong.",
--        },
--        SEWING_MANNEQUIN =
--        {
--            GENERIC = "Rest now.",
--            BURNT = "...",
--        },
--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		LIQUID_MIRROR = "气体流转, 固体回旋, 液体之镜.",
		WHY_REDGEM_SEED = "心的碎片, 温暖的拥抱.",
		WHY_REDGEM_FORMATION = "它的心跳与我共鸣.",
		WHY_REDGEM_OVERGROWN = "奇妙的深红色, 不是吗?",
		WHY_BLUEGEM_SEED = "寒不可测的碎片.",
		WHY_BLUEGEM_FORMATION = "让人脊背发凉.",
		WHY_BLUEGEM_OVERGROWN = "我安心了.",
		WHY_PURPLEGEM_SEED = "疯狂的碎片.",
		WHY_PURPLEGEM_FORMATION = "它把你困住，永远不让离开.",
		WHY_PURPLEGEM_OVERGROWN = "你相信魔法吗?",
		WHY_GREENGEM_SEED = "变形的碎片.",
		WHY_GREENGEM_FORMATION = "你碰它的时候它会变形.",
		WHY_GREENGEM_OVERGROWN = "现在不要看别处，它在生气.",
		WHY_ORANGEGEM_SEED = "时间和记忆的碎片.",
		WHY_ORANGEGEM_FORMATION = "陷入恐惧.",
		WHY_ORANGEGEM_OVERGROWN = "伫立在过去和现在之间的纪念碑.",
		WHY_YELLOWGEM_SEED = "光明和希望的碎片.",
		WHY_YELLOWGEM_FORMATION = "带我出去走走吧美人.",
		WHY_YELLOWGEM_OVERGROWN = "我相信你知道它看起来像什么.",
		WHY_OPALGEM_SEED = "宇宙恐怖的碎片.",
		WHY_OPALGEM_FORMATION = "无法想象之物成为可信之物.",
		WHY_OPALGEM_OVERGROWN = "它吓到我了.",
		WHY_REFINED_LUREPLANT = "大地之手!",
		WHY_REFINED_PLANTERA = "为大地母亲唱颂赞歌.",
		WHY_REFINED_DESERTSTONE = "成为宇宙中心.",
		WHY_REFINED_MILKY = "反转饥饿.",
		WHY_REFINED_LIGHTBULB = "微弱之光.",
		WHY_REFINED_BUTTERFLY = "击倒我们.", --TODO
		WHY_REFINED_BUTTERFLY_MOON = "月亮上来的小子.", --TODO
		WHY_REFINED_GLASSWHITES = "我看到你了.",
		WHY_REFINED_GOLD = "获得*压倒性*的智慧.",
		WHY_REFINED_MARBLE = "喵.哞?",
		WHY_REFINED_MOONROCK = "也许有一天它会如雨坠落.",
		WHY_REFINED_FLINT = "锐化视野.",
		WHY_REFINED_REDGEM = "比起眼睛更像个胃...",
		WHY_REFINED_BLUEGEM = "冷意萦绕我身.",
		WHY_REFINED_PURPLEGEM = "窥视疯狂, 想看多久都行.",
		WHY_REFINED_GREENGEM = "看看时间, 现在是植物时间.",
		WHY_REFINED_ORANGEGEM = "吞噬一切.",
		WHY_REFINED_YELLOWGEM = "放光.",
		WHY_REFINED_OPALGEM = "冬眠.",
		WHY_PERFECTIONGEM = "再也不会虚弱.",
		WHY_NOTHINGNESSGEM = "尖叫, 脓液和血腥的味道充斥着我的口腔, 但我感觉到了. 我感觉到力量.",
		ANCIENTDREAMS_GEMSHARD = "灵魂盛宴.",
		WHYEHAT_HELM = "还没完成, 但目前已经尽力了.", --TODO
		WHYEHAT_HELMET = "终于. 全力之作.", --TODO
		WHYEHAT_DREADSTONE = "我会乖乖的...请回来...", --TODO
		WHYEHAT_DREADSTONE_BROKEN = "坏了", --TODO
		WHYEHAT = "曾经的我留下的遗物.",
		WHYEHAT_FACE = "我现在美吗?",
		WHYEARMOR = "我重新完整了.",
		WHYEARMOR_BACKPACK = "我把它叫做珠宝储藏单元!",
		WHYEARMOR_INCOMPLETE = "我再次感觉完整.",
		WHYEARMOR_PROSTHESIS = "我再次感觉完整.",
		WHYEARMOR_PILE = "我被粉碎成小块.",
		WHYCRANK = "为了测量我的眼眶.",
		WHYTORCH = "我会指引道路.",
		WHYPIERCER = "我会开辟道路.",
		WHYLIFEPEELER = "一片片释放灵魂.",
		WHYTEPADLO = "随时随地, 这就是为什么我喜欢我的发明!",
		WHYBRELLA = "在雨中跳华尔兹, 带着它的荣耀.",
		WHYFLUTOSCOPE = "号手用来宣战的工具.",
		WHYLANTERN = "壳形设计是放大光照必不可少的.",
		WHYFREEZER = "温度低至致死 - 也是我这么喜欢它的原因.",
		WHYCRUSHER = "向它致敬，享受它的精华.",
		WHYJEWELLAB = "和我工坊里的一样好.",
		WHYGLOBELAB = "以远古部族的方式.",
        --
        WHY_KLAUS_SACK_PIECE = "这种质地的破布可以用来存放珠宝...",
        ANCIENTDREAMS_GEGG = "一天中最重要的一餐, 宝石风格.",
        ANCIENTDREAMS_CANDY = "精制的宝石碎片与蜂蜜涂层, 有助于消化.",
        --1.8
        WHY_CRYSTAL_FLOWERS = "水晶壳包裹着的美丽之物, 我却不同.",
        ANCIENTDREAMS_CUBE = "我造物的副产物的有效利用方式!",
        ANCIENTDREAMS_GEOCAKE = "有时候你应该犒劳一下自己.",

        
        
        WHYLUNARWHIP = "我确实说过我要把那顶皇冠用起来的!",
        WHY_CHURCHSTATUE_RED = "展示我们的力量.",
        WHY_CHURCHSTATUE_BLUE = "以痛苦猛烈还击.",
        WHY_CHURCHSTATUE_PURPLE = "混乱有时就是答案.",
        WHY_CHURCHSTATUE_GREEN = "提醒你不要遗忘过去.",
        WHY_CHURCHSTATUE_ORANGE = "永不放弃.",
        WHY_CHURCHSTATUE_YELLOW = "急促是效率的证明.",
        WHY_CHURCHSTATUE_OPAL = "爱让我们最终走到一起.",
        
          --1.8.9
        ANCIENTDREAMS_HYUBSIP = "XXX",
        ANCIENTDREAMS_KOZISIP = "XXX",
        ANCIENTDREAMS_TART = "XXX",
        ANCIENTDREAMS_SPEAR = "XXX",
        ANCIENTDREAMS_EVILBRED = "XXX",
        ANCIENTDREAMS_GELL = "XXX",
        ANCIENTDREAMS_QUASO = "XXX",
        ANCIENTDREAMS_FHISH = "XXX",
        ANCIENTDREAMS_LOMBTER = "XXX",
        ANCIENTDREAMS_PIZZA = "XXX",
        ANCIENTDREAMS_SER = "XXX",
--
--		BEDROLL_GNARCOON = "Rest for the townsfolk.",
--		BEDROLL_GNARCOON_WINTER = "Delightful sleep for kings.",
--		COONTAIL_SHADOW = "Catnip, or maybe worse...",
--		GNARANG = "Forge your ways with ash and bones.",
--		GNARANG_FORGE = "Fight your ways, or die trying.",
--		GNARANG_IMPROVED = "Your sins eventually come back to you.",
--
--		GNARCOON_1_AWARD = "Utter garbage.",
--		GNARCOON_2_AWARD = "Utter garbage.",
--		GNARCOON_3_AWARD = "Utter garbage.",
--		GNARCOON_4_AWARD = "Slightly better utter garbage.",
--		GNARCOON_AWARDHAT = "Slightly better utter garbage.",
--		GNARCOON_DOLL = "Reeks of flesh, bound by enraged soul.",
--		GNARCOON_EYE = "...",
--		GNARCOON_JUNIOR = "Naive creature.",
--		GNARCOON_SLY_CANE = "If I might jump my bones shall fall out.",
--		GNARCOON_TAILNECKLACE = "For fussy eaters.",
--		GNARCOON_UMBRA_CANE = "Good.",
--		GNARCOON_UMBRA_SWORD = "The shadow spoils.",
--		GNARCOON_UMBRA_TOOL_POINT = "Alluring...",
--		GNARCOON_UMBRA_TOOL_ROUND = "Tool for transportation of matter.",
--		GNARCOON_UMBRA_TOOL_SHARP = "Technology worthy of the ancients.",
--		GNARCOON_UMBRASKELETON = "Delightful dreams for weak minds...",
--		GNARCOONBONES = "Rich anatomy.",
--		GNARCOONDEN = {
--			GENERIC = "Root of all evil.",
--			EMPTY = "And there were none.",},
--		EMPTY_GNARCOONDEN = "Hell is empty.",
--		GNARCOONSEABONES = "Wonderful structure.",
--		GNARCOONSKELETON = "A fake.",
--		GNARGLASSES = "Why would you want to see less?",
--		GNARGLASSES_JONES = "Pointless disguise.",
--		GNARGLASSES_KAT = "No.",
--		GNARGLASSES_KING = "Caricature, such foul creature.",
--		GNARGLASSES_MADNESS = "See in red.",
--		GNARHAT = "Pretty.",
--		GNARHAT_ENNO = "Friendly face.",
--		GNARHAT_FORGE = "The bone that blesses you with proficiency.",
--		GNARHAT_IMPROVED = "The bone that blesses you with proficiency.",
--		GNARHAT_KING = "Caricature, such foul creature.",
--		GNARHAT_UMBRA = "Yes... wonderful.",
--		GNARHAT_UMBRA_HELMET = "Of creatures not long gone.",
--		GNARHAT_WONDERWHY = "I can't force a tear to show my feelings.",
--		SHADOW_GNARCOON_JUNIOR = "The demons of the underworld are shaking and crying right now.",
--		WINLEY_EYE = "...",
--		WINLEY_EYEMULET_EMPTY = "...",
--		WINLEY_EYEMULET_BLACK = "...",
--		WINLEY_EYEMULET_WHITE = "...",
--		WINLEY_EYEMULET_BOTH = "...",
--
--		GNARCOON =
--        {
--            GENERIC = "Your bones remember my times.",
--            ATTACKER = "Oh? You remember now?",
--            MURDERER = "His memory isn't lost after all.",
--            REVIVER = "Allies tend to gather naturally.",
--            GHOST = "I still can see your heart.",
--            FIRESTARTER = "This isn't like you, %s.",
--        },
--
		SKELETON_PLAYER =
		{
			MALE = "%s 一定是死于 %s.",
			FEMALE = "%s 一定是死于 %s.",
			ROBOT = "%s 一定是死于 %s.",
			DEFAULT = "%s 一定是死于 %s.",
			PLURAL = "%s 一定是死于 %s.",
		},

    },

	DESCRIBE_ANCIENTEYEPERSPECTIVE = "I cannot tell if it's from this dimension .", --"only_used_by_wonderwhy", --notused anymore

    DESCRIBE_GENERIC = "It's a... thing.",
    DESCRIBE_TOODARK = "It's too dark to see!",
    DESCRIBE_SMOLDERING = "That thing is about to catch fire.",

    DESCRIBE_PLANTHAPPY = "What a happy plant!",
    DESCRIBE_PLANTVERYSTRESSED = "This plant seems to be under a lot of stress.",
    DESCRIBE_PLANTSTRESSED = "It's a little cranky.",
    DESCRIBE_PLANTSTRESSORKILLJOYS = "I might have to do a bit of weeding...",
    DESCRIBE_PLANTSTRESSORFAMILY = "This plant seems lonely.",
    DESCRIBE_PLANTSTRESSOROVERCROWDING = "There are too many plants competing for this small space.",
    DESCRIBE_PLANTSTRESSORSEASON = "This season is not being kind to this plant.",
    DESCRIBE_PLANTSTRESSORMOISTURE = "This looks really dehydrated.",
    DESCRIBE_PLANTSTRESSORNUTRIENTS = "This poor plant needs nutrients!",
    DESCRIBE_PLANTSTRESSORHAPPINESS = "It's hungry for some good conversation.",

    EAT_FOOD =
    {
        TALLBIRDEGG_CRACKED = "I eat babies.",
		WINTERSFEASTFUEL = "The taste of broken families.",
    },

}