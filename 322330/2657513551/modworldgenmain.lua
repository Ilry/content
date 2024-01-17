-- [Don't Starve Alone (DSA)] should run at server creation screen, so all codes are located in modworldgenmain.lua

local GLOBAL = GLOBAL
local rawget = GLOBAL.rawget
GLOBAL.setmetatable(env, {
	__index = function(t,k) return rawget(GLOBAL,k) end
})

-----------------------------------------------------------------------
-- Some classes are modified only when [ONE_PLAYER_MODE] is true to simplify my codes.
-- Note:
--   when [ONE_PLAYER_MODE] is true:
--      * We are in main.lua environment (not worldgen_main.lua).
--      * Save slot must have multiply levels.
--      * Only one world will be loaded and launched. (Master or Caves)
--      * MaxPlayer is 1.
--      * This mod is enabled.
--     
-- (see modmain/servercreation.lua, line 276)
------------------------------------------------------------------------

if GLOBAL.MAIN == 1 then
	assert(TheNet and TheSim and ShardIndex and ShardSaveIndex)

	-- Force crash on dedicated server
	if TheNet:IsDedicated() and not TheNet:GetServerIsClientHosted() then
		error("[Don't Starve Alone] is not allowed to run on dedicated server.\n[独行长路] 禁止在专服运行. ")
	end

	-- Check one_player_mode
	if Settings ~= nil and Settings.save_slot ~= nil and Settings.one_player_mode == true 
        and TheNet:GetIsServer() == true then
    	print("[DSA] Switch to single player mode. (slot = "..Settings.save_slot..")")

    	ONE_PLAYER_MODE = true
    	TUNING.DSA_ONE_PLAYER_MODE = true -- for other mods

    	P_MODE = GetModConfigData("OPT")
    end

    DEVFLAG = {
    	RECOVRE_MODE = true, -- 测试项目: 从单人版存档还原到联机存档格式
    	RECOVREY_TO_MASTER = true, -- 测试项目: 将玩家强制恢复到地面
    	BYPASS_CLOUDSAVE_CACHE = true, -- 测试项目: 绕过云存档 TheSim:GetPersistentStringInClusterSlot 的缓存机制
    	BYPASS_CLOUDSAVE_CACHE_IN_ROLLBACK = false,
    	BAN_CLOUDSAVE = true, -- 测试项目: 禁用云存档
    	BYPASS_CHARACTER_CHECK = true, -- 测试项目: 读档时绕过付费角色检测
    }

    if DEVFLAG.BAN_CLOUDSAVE then
    	BAN_CLOUDSAVE = GetModConfigData("BAN_CLOUDSAVE") ~= 2
    end

    function SEE(src) return " (see "..MODROOT..src..")" end

    -- Import modules
	footprint = function(...) --[[print(...)]] end

	modimport "modmain/mainfunctions"
	modimport "modmain/strings"
	modimport "modmain/save"
	modimport "modmain/snapshot"
	modimport "modmain/recovery"
	modimport "modmain/sync"
	modimport "modmain/reset"
	modimport "modmain/servercreation"
	modimport "modmain/shard"
	modimport "modmain/log"
	modimport "modmain/misc"
else
	-- [Don't Starve Alone] doesn't affect worldgen.
	print("[DSA] In worldgen_main.lua environment, skip all submodules.")
end

-- debug
if modname ~= nil and modname:sub(1,3) == "dsa" then
	print("[DSA] ENABLE DEBUG")
	DEBUG = true
	GLOBAL.PRINT_SOURCE = true
	footprint = print
	require "debugcommands"

	if GLOBAL.MAIN == 1 then

		AddPlayerPostInit(function(inst)
			inst:AddTag("clockmaker")
			inst:AddTag("pocketwatchcaster")
			if inst.components.builder then
				inst.components.builder.freebuildmode = true
			end
		end)

		local debug_components = {
			timer = true,
			worldsettingstimer = true,
			deerclopsspawner = true,
		}
		AddPrefabPostInit("world", function(inst)
			local old_debug = inst.GetDebugString
			function inst:GetDebugString()
				local old_cmp = inst.components
				local new_cmp = {}
				for k,v in pairs(old_cmp)do
					if k:match("^dsa_") or debug_components[k] then
						new_cmp[k] = v
					end
				end

				inst.components = new_cmp
				local s = old_debug(self)
				inst.components = old_cmp
				return s
			end
		end)

		TUNING.NO_BOSS_TIME = 0

		function GLOBAL.dslot()
			for k,v in pairs(TheSim:GetSaveFiles())do if k > 10000 then print(k,TheSim:GetFolderForCloudSaveSlot(k)) end end 
		end

		-- AddPrefabPostInit("homesign", function(inst)
		-- 	inst:ListenForEvent("onbuilt", function()
		-- 		local x,y,z = inst.Transform:GetWorldPosition()
		-- 		inst:DoPeriodicTask(FRAME, function()
		-- 			inst.Transform:SetPosition(
		-- 				x+math.random(-4,4),
		-- 				0,
		-- 				z+math.random(-4,4))
		-- 		end)
		-- 	end)
		-- end)
	end
else
	DEBUG = false
end