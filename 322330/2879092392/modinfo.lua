local isCh = locale == "zh" or locale == "zhr"--是否为中文
name = isCh and "远古梦境 - Endurance" or "Ancient Dreams - Endurance"
description = "We are thou, thou art I\nThou hast acquired a new vow\nAncient dreams bestowed upon thy,\nWith the awakening of the ancient dreamer\nShall the world sucummb to darkness\nor shall it bask in flames of theirs?\n\nSpiral into horror with ancient knowledge\n\n-Adds a character\n-Structures\n-Items\n-Decorations\n-New mechanics\n-Egg\n\nVer. 1.8.9.1"
author = "Koziciel, ForxeNN, DH & Hyuyu"
version = "1.8.9.1"
--id = "ancient_horrors"
forumthread = ""
api_version = 10
api_version_dst = 10
priority = -11  
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
all_clients_require_mod = true 
icon_atlas = "images/modicon/ancient_dreams_act_1.xml"
icon = "ancient_dreams_act_1.tex"
server_filter_tags = {
"furry","goat","why","gemtrees","gemformations","endurance","dragon","durability","celestial","astral","cosmic","character","ancients","ruins","nightmare", "creatures", "sanity", "monster", "hard", "insane", "glasscannon","structures","lategame","content","thulecite","gems","wonder","thefunny","alphabetmafia","psychicdamage","hole",}
local emptyspaceoption = {name = "",label = "",hover = "",options ={{description = "",data = 0},},default = 0,}

configuration_options = isCh and
{
	-- Chinese options
	---------------------------------------------------------------------------------------------------------------------\
	------------------------------------------------------------------------------------------------------------------------\
	{name = "Title", label = "Why的游戏设置", options = {{description = "", data = "0"},}, default = "0",},--|>
	-----------------------------------------------------------------------------------------------------------------------/
	{name = "why_difficulty",
	 label = "游戏难度",
	 hover = "Why已经是一个复杂且难度很高的角色了.",
	 options = {
		 {description = "简单", data = "-1", hover = "懦夫."},
		 {description = "默认", data = "0", hover = "正如预期."},
		 {description = "困难", data = "1", hover = "这才像话."},},
	 default = "0",},

	{name = "why_caveless_recipes",
	 label = "制作配方",
	 hover = "调整制作配方以适应无洞穴世界.",
	 options = {
		 {description = "有洞穴", data = "0", hover = "正如预期."},
		 {description = "无洞穴", data = "1", hover = "铥矿现在可以在家制作."},},
	 default = "0",},

	{name = "why_pairofeyes",
	 label = "眼睛制作",
	 hover = "Why能一次制作多个眼睛吗?",
	 options = {
		 {description = "单眼", data = 1, hover = "正如预期."},
		 {description = "双眼", data = 2, hover = "一个放在面具里, 另一个备用."},
		 {description = "三眼", data = 3, hover = "第三只眼是为其他目的准备的."},},
	 default = 1,},

	{name = "why_eye_option",
	 label = "被攻击时，眼睛会",
	 hover = "面具里的眼睛被攻击时会怎么样?",
	 options = {
		 {description = "破碎", data = 0, hover = "正如预期."},
		 {description = "掉落", data = 1, hover = "它会从你的面具里掉出来."},
		 {description = "不变", data = 2, hover = "被胶水粘住了."},},
	 default = 0,},

	{name = "whyehat_slot_option",
	 label = "面具的物品栏在什么时候关闭",
	 hover = "用你喜欢的方式与面具的物品栏互动.",
	 options = {
		 {description = "放置时", data = "0", hover = "正如预期."},
		 {description = "移动时", data = "1", hover = "移动一寸都会让它关上."},
		 {description = "总是开着", data = "2", hover = "随用随取."},
		 {description = "总是关着", data = "3", hover = "永远要点几下."},},
	 default = "0",},

	{name = "whyehat_hp_option",
	 label = "面具耐久",
	 hover = "面具会坏吗?",
	 options = {
		 {description = "有耐久", data = "0", hover = "正如预期."},
		 {description = "无耐久", data = "1", hover = "懦夫. (还是能被锤子砸坏!)"},},
	 default = "0",},

	{name = "nothingness_option",
	 label = "虚无眼伤害倍率",
	 hover = "麻木?或虚无?",
	 options = {
		 {description = "麻木", data = "0", hover = "厌倦了战斗."},
		 {description = "虚无", data = "1", hover = "远古之怒再临."},},
	 default = "0",},
	emptyspaceoption,

	----------------------------------------------------------------------------------------------------------------------------\
	{name = "Title", label = "耐久度设置", options = {{description = "", data = "0"},}, default = "0",},--|>
	----------------------------------------------------------------------------------------------------------------------------/
	{name = "why_endurance_heal",
	 label = "耐久度治疗机制",
	 hover = "什么样的治疗能回复耐久度.",
	 options = {
		 {description = "默认", data = "1", hover = "只有部分治疗有效."},
		 {description = "所有", data = "0", hover = "所有治疗都有效."},},
	 default = "1",},
	emptyspaceoption,
	------------------------------------------------------------------------------------------------------------------------\
	{name = "Title", label = "语言设置", options = {{description = "", data = "0"},}, default = "0",},--|>
	-----------------------------------------------------------------------------------------------------------------------/
	{name = "why_language_option",
	 label = "语言",
	 hover = "为什么不呢",
	 options = {
		 {description = "英文", data = "0", hover = "Item Names/Strings/Speech made by our glorious Amon Gumka"},
		 {description = "西班牙语", data = "spanish", hover = "Translated by Bombobbit"},
		 {description = "中文", data = "chinese", hover = "Translated by 好黑好黑的大黑"},
	 },
	 default = "chinese",},
	emptyspaceoption,
	------------------------------------------------------------------------------------------------------------------------\
	{name = "Title", label = "视觉效果设置", options = {{description = "", data = "0"},}, default = "0",},--|>
	-----------------------------------------------------------------------------------------------------------------------/
	{name = "why_overlay",
	 label = "视野限制",
	 hover = "不穿戴面具的情况下视野是否受限.",
	 options = {
		 {description = "是的", data = "1", hover = "面具是必须的，即使没有眼睛."},
		 {description = "才不", data = "0", hover = "懦夫."},},
	 default = "1",},

	{name = "why_hat_overlay",
	 label = "眼球外观",
	 hover = "根据当前放入的眼球而定. 有时候很烦, 有时候很棒.",
	 options = {
		 {description = "是的", data = "1", hover = "告诉你哪个眼球处于危险中."},
		 {description = "才不", data = "0", hover = "眼眶里有什么得自己记住."},},
	 default = "1",},

	{name = "why_borealis_light",
	 label = "极光光效",
	 hover = "有时候很烦, 有时候很美.",
	 options = {
		 {description = "彩虹顺序", data = "0", hover = "跟随彩虹的路径."},
		 {description = "随机颜色", data = "1", hover = "你永远不知道什么样的光会点亮你的路途."},
		 {description = "纯白", data = "2", hover = "明亮而耀眼，就像每条坦途应有的模样."},},
	 default = "0",},
} or
{
	-- Other language options
---------------------------------------------------------------------------------------------------------------------\
------------------------------------------------------------------------------------------------------------------------\
		{name = "Title", label = "Why's Gameplay Options", options = {{description = "", data = "0"},}, default = "0",},--|>
-----------------------------------------------------------------------------------------------------------------------/
		{name = "why_difficulty",
		label = "Difficulty",
		hover = "Why is already complex and demanding to play.",
		options = {
			{description = "Easy", data = "-1", hover = "Coward."},
			{description = "Default", data = "0", hover = "As intended."},
			{description = "Hard", data = "1", hover = "That's more like it."},},
	 	default = "0",},

		{name = "why_caveless_recipes",
		label = "Crafting Recipes",
		hover = "Adjust crafting recipes to use materials and stations found on the surface.",
		options = {
			{description = "Caves", data = "0", hover = "As intended."},
			{description = "Caveless", data = "1", hover = "Thulecite is now homemade."},},
	 	default = "0",},

		{name = "why_pairofeyes",
		label = "Eyes Crafting",
		hover = "Can Why craft multiple eyes per craft?",
		options = {
			{description = "Single", data = 1, hover = "As intended."},
			{description = "Double", data = 2, hover = "One eye for mask, second for later."},
			{description = "Triple", data = 3, hover = "Two eyes for mask last one for other thing."},},
	 	default = 1,},

		{name = "why_eye_option",
		label = "On Hit, The Eye",
		hover = "How should the eye behave in your mask upon getting hit?",
		options = {
			{description = "Breaks", data = 0, hover = "As intended."},
			{description = "Drops", data = 1, hover = "It falls out of your mask."},
			{description = "Stays", data = 2, hover = "Glued tight."},},
	 	default = 0,},

		{name = "whyehat_slot_option",
		label = "Mask's Slot Closes When",
		hover = "Create your own way to interact with mask's slot.",
		options = {
			{description = "Placing", data = "0", hover = "As intended."},
			{description = "Moving", data = "1", hover = "Moving an inch makes the slot close."},
			{description = "Stays open", data = "2", hover = "Place and remove your eye at any time."},
			{description = "Always", data = "3", hover = "Whatever you do, it's going to take few more clicks."},},
	 	default = "0",},

		{name = "whyehat_hp_option",
		label = "Despair Mask Durability",
		hover = "Should the mask be breakable?",
		options = {
			{description = "Finite", data = "0", hover = "As intended."},
			{description = "Infinite", data = "1", hover = "Coward. (Still can be hammered!)"},},
	 	default = "0",},

		{name = "nothingness_option",
		 label = "Nothingness eye dmg multiplier",
		 hover = "Numbness?Or Nothingness?",
		 options = {
			 {description = "Numbness", data = "0", hover = "Too Numb to fight."},
			 {description = "Nothingness", data = "1", hover = "Ancient fury returns."},},
		 default = "0",},
		emptyspaceoption,

		----------------------------------------------------------------------------------------------------------------------------\
		{name = "Title", label = "Endurance Options", options = {{description = "", data = "0"},}, default = "0",},--|>
		----------------------------------------------------------------------------------------------------------------------------/
		{name = "why_endurance_heal",
		 label = "Endurance Healing Mechanism",
		 hover = "What kind of healing works for endurance.",
		 options = {
			 {description = "Default", data = "1", hover = "Only permitted healing methods are effective."},
			 {description = "All healing", data = "0", hover = "All healing methods works."},},
		 default = "1",},
		emptyspaceoption,
------------------------------------------------------------------------------------------------------------------------\
		{name = "Title", label = "Language Options", options = {{description = "", data = "0"},}, default = "0",},--|>
-----------------------------------------------------------------------------------------------------------------------/
		{name = "why_language_option",
		label = "Language",
		hover = "cause Why not",
		options = {
			{description = "English", data = "0", hover = "Item Names/Strings/Speech made by our glorious Amon Gumka"},
			{description = "Spanish", data = "spanish", hover = "Translated by Bombobbit"},
			{description = "Chinese", data = "chinese", hover = "Translated by 好黑好黑的大黑"},
		},
	 	default = "0",},
		emptyspaceoption,
------------------------------------------------------------------------------------------------------------------------\
		{name = "Title", label = "Why's Visual Options", options = {{description = "", data = "0"},}, default = "0",},--|>
-----------------------------------------------------------------------------------------------------------------------/
		{name = "why_overlay",
		label = "Eye Hole Overlay",
		hover = "Tell me if you want the eye-hole overlay for Why.",
		options = {
			{description = "Yes", data = "1", hover = "Ancient Despair Mask is necessary for that issue, which is no-eyes at all."},
			{description = "Hell No", data = "0", hover = "Coward."},},
	 	default = "1",},

		{name = "why_hat_overlay",
		label = "Eye Ball Overlay",
		hover = "Depends on inserted Eyeball. Sometimes it disturbs, sometimes it helps.",
		options = {
			{description = "Yes", data = "1", hover = "Indicator whenever an eye is in danger."},
			{description = "Hell No", data = "0", hover = "One should remember about eye in his hole."},},
	 	default = "1",},

		{name = "why_borealis_light",
		label = "Aurora Borealis Light",
		hover = "Sometimes it disturbs, sometimes it's pretty to look at.",
		options = {
			{description = "Rainbow Cycle", data = "0", hover = "Follow the path along with the cycle of rainbow."},
			{description = "Random Colour", data = "1", hover = "You can never know what colour will illuminate your path."},
			{description = "Static White", data = "2", hover = "Bright and luminous, as every path should be."},},
	 	default = "0",},

}
