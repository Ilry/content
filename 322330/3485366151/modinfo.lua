local locale = locale or "en"
local chinese = locale == "zh" or locale == "zhr" or locale == "zhs"
local L = chinese

name = chinese and "最好的技能施法" or "Best Spell Casting"
description = chinese and 
[[将游戏中各角色的技能轮盘重写UI，添加快捷键绑定

支持的角色：温蒂,薇洛,麦斯威尔,沃尔特,薇诺娜,女武神
- 点击和使用不会关闭技能 • 兼容各种快捷键MOD
- 正确显示CD和技能状态 • 图标大小跟随HUD设置
- 可拖动到任意位置(右键拖动,中键重置,拖动后的位置将被保存,中键重置)
- 自定义所有角色的技能快捷键绑定，支持快速施法]]
or
[[Rewrites the UI for character skill wheels and adds hotkey bindings

Supported characters: Wendy, Willow, Maxwell, Walter, Winona, Wigfrid
- Clicking and using skills won't close the wheel • Compatible with other hotkey mods
- Properly displays cooldowns & skill states • Icon size follows HUD settings
- Draggable to any position (right-click drag, middle-click reset, positions are saved after dragging)
- Custom hotkey bindings for all character skills, supports quick casting]]

author = "唤月惬意未了"
version = "1.2.1"

forumthread = ""

api_version = 10

dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true

client_only_mod = true
all_clients_require_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

defaultkeyhover = L and "无->F键->底排->中排->上排->鼠标指针->无" or "None->F Keys->Bottom row->Mid->Upper->Numpad->Mouse->None"

local KeybindOptions = {
    {description = L and "无" or "None", data = -1},
    {description = "F1", data = 282},
    {description = "F2", data = 283},
    {description = "F3", data = 284},
    {description = "F4", data = 285},
    {description = "F5", data = 286},
    {description = "F6", data = 287},
    {description = "F7", data = 288},
    {description = "F8", data = 289},
    {description = "F9", data = 290},
    {description = "F10", data = 291},
    {description = "F11", data = 292},
    {description = "F12", data = 293},
    {description = "Z", data = 122},
    {description = "X", data = 120},
    {description = "C", data = 99},
    {description = "V", data = 118},
    {description = "B", data = 98},
    {description = "N", data = 110},
    {description = "M", data = 109},
    {description = "A", data = 97},
    {description = "S", data = 115},
    {description = "D", data = 100},
    {description = "F", data = 102},
    {description = "G", data = 103},
    {description = "H", data = 104},
    {description = "J", data = 106},
    {description = "K", data = 107},
    {description = "L", data = 108},
    {description = "Q", data = 113},
    {description = "W", data = 119},
    {description = "E", data = 101},
    {description = "R", data = 114},
    {description = "T", data = 116},
    {description = "Y", data = 121},
    {description = "U", data = 117},
    {description = "I", data = 105},
    {description = "O", data = 111},
    {description = "P", data = 112},
    {description = "1", data = 49},
    {description = "2", data = 50},
    {description = "3", data = 51},
    {description = "4", data = 52},
    {description = "5", data = 53},
    {description = "6", data = 54},
    {description = "7", data = 55},
    {description = "8", data = 56},
    {description = "9", data = 57},
    {description = "0", data = 48},
    {description = "-", data = 45},
    {description = "=", data = 61},
    {description = "Num 1", data = 257},
    {description = "Num 2", data = 258},
    {description = "Num 3", data = 259},
    {description = "Num 4", data = 260},
    {description = "Num 5", data = 261},
    {description = "Num 6", data = 262},
    {description = "Num 7", data = 263},
    {description = "Num 8", data = 264},
    {description = "Num 9", data = 265},
    {description = "Num 0", data = 256},
    {description = "Num -", data = 269},
    {description = "Num +", data = 270},
    {description = "Num *", data = 268},
    {description = "Num /", data = 267},
    {description = "Num .", data = 266},
    {description = '\238\132\130', data = 1002, hover = L and "鼠标中键" or "Middle Mouse Button"}, -- Middle Mouse Button
    {description = '\238\132\131', data = 1005, hover = L and "鼠标键4" or"Mouse Button 4"}, -- Mouse Button 4
    {description = '\238\132\132', data = 1006, hover = L and "鼠标键5" or"Mouse Button 5"}, -- Mouse Button 5
    {description = "Caps Lock", data = 301},
    {description = L and "无" or "None", data = -1},
}
local BoolOptions = {
    {description = L and "开" or "On", data = true},
    {description = L and "关" or "Off", data = false},
}

function MakeFakeConfig(label, name, is_header)
    return {name = name or "fake", label = label or "", hover = "", options = {{description = "", data = -1, hover = ""},}, default = 1, is_header = is_header}
end

function MakeBindConfig(label, name, default)
    return {name = name, label = label or "", hover = defaultkeyhover, options = KeybindOptions, default = default, is_keybind = true}
end

function MakeQCConfig(label, spellname)
    return {name = "QC_"..spellname, label = label or "", hover = "", options = BoolOptions, default = true}
end

configuration_options = {
    MakeFakeConfig(L and "常规" or "General", "HEADER_GENERAL", true),
    {
        name = "RMB_ENABLED",
        label = L and "法术书访问模式" or "Spell book access mode",
        options = 
        {
            {description = L and "右键" or "RMB", data = true, hover = L and "使用右键访问你的法术书。" or "Use RMB to access your spell book."},
            {description = L and "快捷键" or "Hotkey", data = false, hover = L and "通过按下下面指定的键来访问法术书。" or "The spell book is accessed by pressing a key specified below."},
        },
        default = true,
        hover = L and "选择你想要使用法术书的方式：右键或快捷键。" or "Select the desired way to operate with your spell book: RMB or a hotkey."
    },
    {
        name = "RMB_REPLACEMENT_KEY",
        label = L and "法术书快捷键" or "Spell book hotkey",
        options = KeybindOptions,
        default = -1,
        hover = L and "仅在上一个选项设置为'快捷键'时有效。\n选择打开法术书的键。" or "Only works if the previous option is set to 'Hotkey'.\nSelect the key to open your spell book with.",
        is_keybind = true,
    },
    {
        name = "RMB_ENABLER_KEY",
        label = L and "右键激活修饰键" or "RMB activation modifier",
        options = {
            {description = L and "无" or "None", data = -1},
            {description = "L Alt", data = 308},
            {description = "L Ctrl", data = 306},
            {description = "L Shift", data = 304},
            {description = L and "无" or "None", data = -1},
        },
        default = -1,
        hover = L and "如果启用此选项，右键只有在按住指定键时才会生效。" or "If this is enabled, RMB will only work when the specified key is held.",
        is_keybind = true,
    },
    {
        name = "SHOW_ACTION_PROMPT",
        label = L and "显示右键动作提示" or "Show RMB action prompt",
        options = 
        {
            {description = L and "是" or "Yes", data = true},
            {description = L and "否" or "No", data = false},
        },
        default = true,
        hover = L and "选择是否显示右键动作提示（施法.../燃烧.../等）。" or "Choose whether you'd like the RMB action prompt (Cast.../Burn.../etc) to be displayed."
    },
    {
        name = "SPELL_HOTKEY_MODE",
        label = L and "法术访问模式" or "Spell access mode",
        options = 
        {
            {description = L and "自定义快捷键" or "Custom hotkeys", data = "keys", hover = L and "此模式可以使用瞬发施法。" or "Instant Cast can be used with this mode."},
            {description = L and "数字键" or "Number keys", data = "nums", hover = L and "法术将自动分配1-9键，但仅在轮盘打开时有效。" or "Spells will be automatically assigned keys 1-9, but only while the wheel is open."},
            {description = L and "快捷键和数字键" or "Hotkeys & Numbers", data = "nums+keys", hover = L and "两种模式的组合。" or "A combination of the two modes."},
            {description = L and "无" or "None", data = "", hover = L and "完全禁用法术快捷键。" or "Spell hotkeys will be disabled altogether."},
        },
        default = "keys",
        hover = L and "选择访问单个法术的首选方式。" or "Choose the preferred way or accessing individual spells."
    },
    {
        name = "TRACK_CURSOR",
        label = L and "法术轮位置" or "Spell wheel position",
        options = 
        {
            {description = L and "光标" or "Cursor", data = true},
            {description = L and "角色" or "Character", data = false},
        },
        default = true,
        hover = L and "选择你的法术轮是在光标位置还是角色位置打开。" or "Choose if you'd like your spell wheel to open at your cursor or character."
    },
    {
        name = "QUICKCAST",
        label = L and "快速施法" or "Instant Cast",
        options = 
        {
            {description = L and "全部启用" or "All enabled", data = true},
            {description = L and "全部禁用" or "All disabled", data = false},
            {description = L and "可配置" or "Configurable", data = "nil", hover = L and "单独调整每个法术的设置。" or "Tune each spell individually at the bottom section."},
        },
        default = false,
        hover = L and "允许快捷键直接施放法术，跳过目标选择部分。\n仅在自定义快捷键模式下工作。" or "Allow hotkeys to cast their spell instantly, skipping the targeting part.\nOnly works with custom hotkeys."
    },
    {
        name = "ENABLE_TIMERS",
        label = L and "显示冷却计时器" or "Show cooldown timers",
        options = 
        {
            {description = L and "是" or "Yes", data = true},
            {description = L and "无声音" or "No sound", data = "nosound"},
            {description = L and "不显示" or "Don't show", data = false},
        },
        default = true,
        hover = L and "选择是否为薇洛和温蒂显示冷却计时器。" or "Choose whether to display cooldown timers for Willow and Wendy."
    },
    
    MakeFakeConfig(L and "角色专用" or "Character-specific", "HEADER_CHARSETTINGS"),
    {
        name = "DASH_KEY",
        label = L and "沃比冲刺键" or "Woby dash key",
        options = KeybindOptions,
        default = -1,
        hover = L and "选择一个键来执行冲刺，而不是双击。" or "Select a key that will perform dashes instead of double clicking.",
        is_keybind = true,
    },
    {
        name = "DASH_MODE",
        label = L and "沃比冲刺模式" or "Woby dash mode",
        options = {
            {description = L and "光标" or "Cursor", data = "cursor", hover = L and "冲刺将朝向光标方向。" or "The dash will be directed towards the cursor."},
            {description = L and "当前方向" or "Current direction", data = "movement", hover = L and "冲刺将跟随角色当前面朝的方向。" or "The dash will follow the direction the character is currently looking at."},
        },
        default = "cursor",
        hover = L and "选择冲刺快捷键的工作方式。" or "Choose how the dash hotkey should work.",
    },
    {
        name = "RESTORE_WOBY_RMB_MOUNT",
        label = L and "右键骑乘/下马沃比" or "(Dis)mount Woby with RMB",
        options = 
        {
            {description = L and "是" or "Yes", data = true},
            {description = L and "否" or "No", data = false},
        },
        default = true,
        hover = L and "如果启用，你将能够通过右键点击来骑乘/下马沃比。\n这将和技能树之前一样。" or "If enabled, you'll be able to mount/dismount Woby by right clicking on her.\nIt'll be just how it was before the skill tree."
    },
    {
        name = "BASKET_KEY",
        label = L and "打开野餐篮快捷键" or "Open Picnic Casket key",
        options = KeybindOptions,
        default = -1,
        hover = L and "选择一个键，在玩温蒂时用来打开野餐篮。" or "Select a key that will open Picnic Caskets when playing Wendy.",
        is_keybind = true,
    },

    MakeFakeConfig(L and "歌谣轮盘" or "Song Wheel", "HEADER_SONGWHEEL"),
    {
        name = "ENABLE_SONGWHEEL",
        label = L and "启用歌谣轮盘" or "Enable song wheel",
        options = 
        {
            {description = L and "启用" or "Enabled", data = true},
            {description = L and "禁用" or "Disabled", data = false},
        },
        default = true,
        hover = L and "该修改器可将歌谣组合成一个轮盘，除非您不希望它这样做。" or "The mod can combine songs into a wheel, unless you'd like it not to."
    },

    {
        name = "SHOW_UNAVAILABLE_SONGS",
        label = L and "显示不可用歌谣" or "Show unavailable songs",
        options = 
        {
            {description = L and "启用" or "Enabled", data = true},
            {description = L and "禁用" or "Disabled", data = false},
        },
        default = false,
        hover = L and "选择是否显示你没有的歌谣。" or "Choose if you'd like songs you don't have to be present or hidden in the song wheel."
    },

    {
        name = "KEEP_SONGWHEEL_OPEN",
        label = L and "保持歌谣轮盘打开" or "Keep song wheel open",
        options = 
        {
            {description = L and "启用" or "Enabled", data = true},
            {description = L and "禁用" or "Disabled", data = false},
        },
        default = false,
        hover = L and "选择是否在选择歌谣后保持歌谣轮盘打开。" or "Choose if you'd like the song wheel to stay open upon selecting a song."
    },

    MakeFakeConfig(L and "暗影法典补充燃料" or "Codex Refueling", "HEADER_CODEXREFUELING", true),
    {
        name = "WAXWELL_REFUEL",
        label = L and "暗影法典补充燃料快捷键" or "Codex refuel hotkey",
        options = KeybindOptions,
        default = -1,
        hover = defaultkeyhover,
        is_keybind = true,
    },
    {
        name = "WAXWELL_REFUEL_MODIFIER",
        label = L and "暗影法典补充燃料修饰键" or "Codex refuel modifier key",
        options = {
            {description = L and "无" or "None", data = -1},
            {description = "Alt", data = 308},
            {description = "Ctrl", data = 306},
            {description = "Shift", data = 304},
            {description = L and "无" or "None", data = -1},
        },
        default = -1,
        hover = L and "按住指定键再按法术按钮将为暗影法典补充燃料。" or "Pressing Spells Button while this key is held will refuel your Codex.",
        is_keybind = true,
    },


    MakeFakeConfig(L and "烈焰热键：薇洛" or "Trick Hotkeys: Willow", "HEADER_WILLOW", true),
    MakeBindConfig(L and "火焰投掷" or "Flame Cast", "WILLOW_SPELL_1", 257),
    MakeBindConfig(L and "燃烧术" or "Combustion", "WILLOW_SPELL_2", 258),
    MakeBindConfig(L and "火球术" or "Fire Ball", "WILLOW_SPELL_3", 259),
    MakeBindConfig(L and "狂热焚烧" or "Burning Frenzy", "WILLOW_SPELL_4", 260),
    MakeBindConfig(L and "月焰纵火犯" or "Lunar Flame", "WILLOW_SPELL_5", 261),
    MakeBindConfig(L and "暗影纵火犯" or "Shadow Fire", "WILLOW_SPELL_6", 261),

    MakeFakeConfig(L and "法术热键：麦斯威尔" or "Spell Hotkeys: Maxwell", "WAXWELL_SPELL_0",true), -- fake config for a non-existent spell lmao
    MakeBindConfig(L and "暗影仆人" or "Shadow Servant", "WAXWELL_SPELL_1", 257),
    MakeBindConfig(L and "暗影角斗士" or "Shadow Duelist", "WAXWELL_SPELL_2", 258),
    MakeBindConfig(L and "暗影陷阱" or "Shadow Sneak", "WAXWELL_SPELL_3", 259),
    MakeBindConfig(L and "暗影囚牢" or "Shadow Prison", "WAXWELL_SPELL_4", 260),

    MakeFakeConfig(L and "歌谣热键：薇格弗德" or "Song Hotkeys: Wigfrid", "WIGFRID_BATTLESONG_FAKE",true),
    --MakeBindConfig(L and "心碎歌谣" or "Heartrending Ballad", "WIGFRID_BATTLESONG_HEALTHGAIN", -1),  
    --MakeBindConfig(L and "醍醐灌顶华彩" or "Clear Minded Cadenza", "WIGFRID_BATTLESONG_SANITYGAIN", -1),  
    --MakeBindConfig(L and "英勇美声颂" or "Bel Canto of Courage", "WIGFRID_BATTLESONG_SANITYAURA", -1), 
    --MakeBindConfig(L and "武器化的颤音" or "Weaponized Warble", "WIGFRID_BATTLESONG_DURABILITY", -1),
    --MakeBindConfig(L and "防火假声" or "Fireproof Falsetto", "WIGFRID_BATTLESONG_FIRERESISTANCE", -1),  
    MakeBindConfig(L and "使用下一个持久歌" or "Next buff song", "WIGFRID_NEXTSONG", -1),
    MakeBindConfig(L and "粗鲁插曲" or "Rude Interlude", "WIGFRID_BATTLESONG_INSTANT_TAUNT", -1),
    MakeBindConfig(L and "惊心独白" or "Startling Soliloquy", "WIGFRID_BATTLESONG_INSTANT_PANIC", -1),  
    MakeBindConfig(L and "战士重奏" or "Warrior's Reprise", "WIGFRID_BATTLESONG_INSTANT_REVIVE", -1),
    --MakeBindConfig(L and "启迪摇篮曲" or "Enlightened Lullaby", "WIGFRID_BATTLESONG_LUNARALIGNED", -1), 
    --MakeBindConfig(L and "黑暗悲歌" or "Dark Lament", "WIGFRID_BATTLESONG_SHADOWALIGNED", -1),

    MakeFakeConfig(L and "指令热键：薇诺娜" or "Command Hotkeys: Winona", "WINONA_COMMAND_FAKE",true),
    MakeBindConfig(L and "射击靶" or "Target", "WINONA_COMMAND_VOLLEY", -1),  
    MakeBindConfig(L and "快速开火" or "Rapid-Fire", "WINONA_COMMAND_BOOST", -1), 
    MakeBindConfig(L and "武装投石机" or "Arm Catapult", "WINONA_COMMAND_WAKEUP", -1),  
    MakeBindConfig(L and "位面袭击" or "Planar Strike", "WINONA_COMMAND_ELEMENTAL_VOLLEY", -1),

    MakeFakeConfig(L and "低语热键：温蒂" or "Whisper Hotkeys: Wendy", "WENDY_WHISPER_FAKE",true),
    MakeBindConfig(L and "解除召唤" or "Unsummon", "WENDY_WHISPER_UNSUMMON", -1),  
    MakeBindConfig(L and "激怒/安慰" or "Rile Up/Soothe", "WENDY_WHISPER_COMMUNE", -1),  
    MakeBindConfig(L and "攻击" or "Attack At", "WENDY_WHISPER_ATTACK_AT", -1), 
    MakeBindConfig(L and "惊吓" or "Scare", "WENDY_WHISPER_SCARE", -1),
    MakeBindConfig(L and "作祟" or "Haunt At", "WENDY_WHISPER_HAUNT_AT", -1),
    MakeBindConfig(L and "逃离" or "Escape", "WENDY_WHISPER_ESCAPE", -1),

    MakeFakeConfig(L and "指令热键：沃尔特" or "Command Hotkeys: Walter", "WALTER_COMMAND_FAKE",true),
    MakeBindConfig(L and "宠物" or "Pet", "WALTER_COMMAND_PET", -1),  
    MakeBindConfig(L and "骑乘/下马" or "Mount/Dismount", "WALTER_COMMAND_MOUNT", -1),  
    MakeBindConfig(L and "骑乘时打开" or "Open while riding", "WALTER_COMMAND_OPEN", -1),  
    MakeBindConfig(L and "变形" or "Transform", "WALTER_COMMAND_SHRINK", -1), 
    MakeBindConfig(L and "切换等待" or "Toggle staying", "WALTER_COMMAND_SIT", -1),
    MakeBindConfig(L and "切换取物" or "Toggle fetching", "WALTER_COMMAND_PICKUP", -1),
    MakeBindConfig(L and "切换觅食" or "Toggle foraging", "WALTER_COMMAND_FORAGING", -1),
    MakeBindConfig(L and "切换工作" or "Toggle working", "WALTER_COMMAND_WORKING", -1),
    MakeBindConfig(L and "切换冲刺" or "Toggle sprinting", "WALTER_COMMAND_SPRINTING", -1),
    MakeBindConfig(L and "切换暗影冲刺" or "Toggle shadow dash", "WALTER_COMMAND_SHADOWDASH", -1),
    MakeBindConfig(L and "标记地点" or "Mark Spot", "WALTER_COMMAND_REMEMBERCHEST", -1),
    MakeBindConfig(L and "配送" or "Deliver", "WALTER_COMMAND_COURIER", -1),

    MakeFakeConfig(L and "瞬发施法" or "Instant Cast", "QC_TITLE"),
    MakeQCConfig(L and "火焰投掷" or "Flame Cast", "WILLOW_SPELL_1"),
    MakeQCConfig(L and "燃烧术" or "Combustion", "WILLOW_SPELL_2"),
    MakeQCConfig(L and "火球术" or "Fire Ball", "WILLOW_SPELL_3"),
    MakeQCConfig(L and "狂热焚烧" or "Burning Frenzy", "WILLOW_SPELL_4"),
    MakeQCConfig(L and "月焰纵火犯" or "Lunar Flame", "WILLOW_SPELL_5"),
    MakeQCConfig(L and "暗影纵火犯" or "Shadow Fire", "WILLOW_SPELL_6"),
    MakeQCConfig(L and "暗影仆人" or "Shadow Servant", "WAXWELL_SPELL_1"),
    MakeQCConfig(L and "暗影角斗士" or "Shadow Duelist", "WAXWELL_SPELL_2"),
    MakeQCConfig(L and "暗影陷阱" or "Shadow Sneak", "WAXWELL_SPELL_3"),
    MakeQCConfig(L and "暗影囚牢" or "Shadow Prison", "WAXWELL_SPELL_4"),
    MakeQCConfig(L and "射击靶" or "Target", "WINONA_COMMAND_VOLLEY"),  
    MakeQCConfig(L and "武装投石机" or "Arm Catapult", "WINONA_COMMAND_WAKEUP"),  
    MakeQCConfig(L and "快速开火" or "Rapid-Fire", "WINONA_COMMAND_BOOST"), 
    MakeQCConfig(L and "位面袭击" or "Planar Strike", "WINONA_COMMAND_ELEMENTAL_VOLLEY"),
    MakeQCConfig(L and "攻击" or "Attack At", "WENDY_WHISPER_ATTACK_AT"),
    MakeQCConfig(L and "作祟" or "Haunt At", "WENDY_WHISPER_HAUNT_AT"),

}

priority = 0