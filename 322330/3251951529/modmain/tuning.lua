--- 全局配置
TUNING.MYM_MATE_GLOBAL = {
    IGNORE_HUNGER = GetModConfigData("ignore_hunger"),     --是否忽略饥饿影响
    IGNORE_TEMP = GetModConfigData("ignore_temp"),         --是否忽略温度影响
    IMMUNE_NIGHT = GetModConfigData("immune_night"),       --免疫夜晚查理伤害
    IGNORE_MOISTURE = GetModConfigData("immune_moisture"), --免疫潮湿
    KEEPONDEATH = GetModConfigData("keepondeath"),         --死亡物品不掉落
    HEALTH_REGEN = GetModConfigData("health_regen"),       --每秒回血
    WANDER = GetModConfigData("wander"),                   --是否来回走动
}

----------------------------------------------------------------------------------------------------

TUNING.MYM_MATE_PANIC_THRESH = 0.25                                                    --恐惧逃跑需要的血量下限
TUNING.MYM_MATE_HEAL_NEED_PERCENT = GetModConfigData("use_heal_need_percent")          --队友需要治疗的血量百分比
TUNING.MYM_DURABILITY_CONSUME = GetModConfigData("durability_consume")                 --装备耐久消耗
TUNING.MYM_MATE_DEATH_DISAPPEAR_TIME = GetModConfigData("death_disappear_time")        --队友死亡后灵魂状态持续时长
TUNING.MYM_UNLOCK_ALL_SKILLS = GetModConfigData("unlock_all_skills")                   --直接解锁所有技能
TUNING.MYM_SHOW_NAME_LABEL = GetModConfigData("show_name_label")                       --队友头上是否显示名字
TUNING.MYM_ALLOW_WRITEABLE = GetModConfigData("allow_writeable")                       --允许为队友命名
TUNING.MYM_FIND_RESOURCE_MODE = GetModConfigData("find_resource_mode")                 --资源收集模式
TUNING.MYM_WEAPON_NOT_DISARM = GetModConfigData("weapon_not_disarm")                   --队友被攻击武器不会脱手
TUNING.MYM_COOK_UNLOCK_RECIPES = GetModConfigData("cook_unlock_recipes")               --自动做饭可制作大部分料理
TUNING.MYM_FORBID_SELECT_MODCHARACTER = GetModConfigData("forbid_select_modcharacter") --不能制作mod角色
TUNING.MYM_COMBAT_USE_SKILL = GetModConfigData("combat_use_skill")                     --战斗时使用通用技能
TUNING.MYM_FOLLOW_MIN_DISTANCE = GetModConfigData("follow_min_distance")               --最小跟随距离
TUNING.MYM_FOLLOW_MAX_DISTANCE = GetModConfigData("follow_max_distance")               --最大跟随距离
TUNING.MYM_ATTACK_TAKEN_MULT = GetModConfigData("attack_taken_mult")                   --队友受击倍率
TUNING.MYM_ATTACK_MULT = GetModConfigData("attack_mult")                               --队友攻击倍率
TUNING.MYM_SPEED_MULT = GetModConfigData("speed_mult")                                 --队友移速倍率
TUNING.MYM_SPAWN_MATE_START_ITEM = GetModConfigData("spawn_mate_start_item")           --队友出生带有初始道具


TUNING.MYM_SKILL_UNLOCK_DAY = 3 --解锁技能所需天数
