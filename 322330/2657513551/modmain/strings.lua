local L = true

-- get system language
local lan = require "languages/loc".GetLanguage()
if lan == LANGUAGE.CHINESE_S or lan == LANGUAGE.CHINESE_S_RAIL then
    L = false
end

env.L = L

env.S = {
	OK 			= L and "OK" or "确定",
	CANCEL 		= L and "Cancel" or "取消",
	WARNING 	= L and "Warning" or "温馨提示",
	VIEW_DETAIL = L and "View details" or "查看详情",
	ONE_PLAYER_STRICT = L and 
		"[Don't Starve Alone] only runs on single player server.\nYou must set the number of max players to 1." or
		"[独行长路] 仅在单人模式生效。\n若要运行该mod，你必须先将服务器玩家数量设为1。",
	CLOUD_SAVE_WARNING = L and 
		"[Don't Starve Alone] with cloud save mode may cause some nasty bugs, such as save slot copy, overwriting, etc. \n"..
		"This bug is still being fixed. It is highly recommended to use local save mode for games for now. " or
		
		"[独行长路] 在云存档模式下可能会引发一些恶性bug, 如角色重选、存档复制、存档内容覆盖等。\n"..
		"这个bug仍在修复中, 在此之前, 强烈推荐使用本地存档进行游戏。",
	BAN_CLOUDSAVE = L and "[Don't Starve Alone] does not support cloudsave. Please switch to localsave." or "[独行长路] 暂不支持云存档, 请切换到本地存档。",
	SHARD_NAMES = {
		Master = L and "Forest" or "地面",
		Caves  = L and "Cave"   or "洞穴",
		Unknown = L and "Unknown" or "未知世界",
	},

	SUGGEST_RECOVERY = L and "Turning off [Don't Starve Alone] will cause cave content to be lost.\nPlease click the button in the upper right corner to return to multiplayer mode." or "直接关闭[独行长路]会导致洞穴游玩进度丢失,\n请点击右上角按钮恢复到多人模式。",
	START_ANYWAY = L and "Start world anyway" or "仍要启动世界",

	RECOVERY_SAVE_TITLE = L and "Recover to multiplayer mode" or "恢复多人模式",
	RECOVERY_SAVE_NAME = L and "Recovery of {name}" or "恢复的 - {name}",
	RECOVERY_SAVE_DESC = L and "Create a replica of the current save and convert it to multiplayer mode.\n(Current save is not affected)\n\nEnter the name of the new save:" or 
		"创建一个当前存档的复制品, 并转换为多人模式。\n（当前存档不受影响）\n\n请输入新存档的名字:",
	RECOVERY_MOD_DISABLED = L and "To use the recovery mode, you must first enabled [Don't Starve Alone]" or 
		"若要使用恢复功能, 必须先启动[独行长路]mod。",
	RECOVERY_OFFLINE = L and "This is an online save and you must login to use the recovery mode." or "这是一个在线存档, 你必须先登录游戏才能进入恢复功能。",
	RECOVERY_SAVE_DESC_DISABLED = {
		MAIN = L and "[Don't Starve Alone] cannot restore current save, cause :\n%s (%s).\n\nTip: The button in the upper right corner will turn green if recovery mode is available." or 
			"[独行长路]无法恢复当前存档, 原因:\n%s（%s）。\n\n温馨提示: 恢复功能可用时, 右上角按钮会变为绿色。",
		-- ERROR
		MASTER_NOT_EXISTS = L and "Uncreated world" or "未创建世界",
		MASTER_FILE_NOT_EXISTS = L and "Error: Failed to get world info" or "发生错误, 无法获取主世界信息",
		CAVES_NOT_EXISTS = L and "Uncreated cave" or "未创建洞穴",
		CAVES_FILE_NOT_EXISTS = L and "Error: Failed to get cave info" or "发生错误, 无法获取洞穴信息",
		IN_SYNC = L and "Files have been synchronized, you can directly close the mod" or "文件已同步, 无需恢复, 可直接关闭mod",
	},
	RECOVERY_SAVE_PROCESSING = L and "Converting... It will take some time. Go make a cup of tea?" or "正在转换, 需要一些时间, 请耐心等待。",
	RECOVERY_SAVE_SUCCESS = L and "" or "转换成功!\n你可以在新存档 ({newname}) 邀请好友一起游玩, \n也可以在当前存档 ({oldname}) 继续你的单人冒险。",
	RECOVERY_SAVE_ERROR = L and "Uh-oh, there were some problems with the conversion.\nYou can try to turn off some mods, if the problem can't be fixed, please report to the author.\n\n"..
		"Do you want to delete the new save that has not been converted successfully? (Current save is not affected)" or 
		"啊哦，转换过程中出现了一些问题。\n你可以试着关闭一些mod, 如果问题无法解决, 请向作者反馈。\n\n是否删除未转换成功的新存档?（当前存档不受影响）",
	RECOVERY_SAVE_ERRORBTN = {
		DELETE = L and "Delete" or "删除存档",
		PRESERVE = L and "Preserve" or "保留存档",
	},
	RECOVERY_RUN = L and "Start processing" or "开始转换",

	MOD_OUT_OF_DATE = L and "Mod \"%s\" is out of date. The server needs to get the latest version from the Steam Workshop so other users cannot join."
		or "\"%s\"模组 已过期。服务器需要从 Steam 创意工坊获得最新版本，这样其他的用户还是不能加入。",
	MOD_OUT_OF_DATE_RAIL = L and "Mod \"%s\" is out of date. The server needs to get the latest version so other users can join."
		or "\"%s\"MOD过时了。服务器需要从创客空间下载最新版本以让其他玩家不加入。"
}

if ONE_PLAYER_MODE then
	AddSimPostInit(function()

	STRINGS.UI.BUILTINCOMMANDS.REGENERATE.DESC = STRINGS.UI.BUILTINCOMMANDS.REGENERATE.DESC .. 
	"\n" .. 
	string.format(L and "With mod [%s Don't Starve Alone] on, the process of regenerating the world may be a little different from common, don't worry about it." or 
		"你开启了[%s独行长路]，重新生成世界的过程会有些不一样，无需在意。",
		EMOJI_ITEMS.emoji_torch.data.utf8_str)

	end)
end