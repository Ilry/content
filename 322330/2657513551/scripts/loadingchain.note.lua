-- 读档界面 ------------------------------------------------------------

1. ShardSaveIndex:IsSlotEmpty(slot)
--> scripts/widgets/redux/serversettingstab.lua(438)

2. ShardSaveIndex:GetSlotServerData(slot)
--> scripts/widgets/redux/serversettingstab.lua(457)

3. ShardSaveIndex:GetSlotEnabledServerMods(slot)
--> scripts/widgets/redux/serversaveslot.lua(234)

4. ShardSaveIndex:IsSlotEmpty(slot)
--> scripts/widgets/redux/serversaveslot.lua(192)

5. ShardSaveIndex:IsSlotEmpty(slot)
--> scripts/widgets/redux/worldsettings/worldsettingstab.lua(416)

6. ShardSaveIndex:GetSlotGenOptions(slot)
--> scripts/widgets/redux/worldsettings/worldsettingstab.lua(423)

7. ShardSaveIndex:IsSlotMultiLevel(slot)
--> scripts/widgets/redux/worldsettings/worldsettingstab.lua(426)

8. ShardSaveIndex:GetSlotServerData(slot)
--> scripts/widgets/redux/snapshottab.lua(277)

9. ShardSaveIndex:SetSlotEnabledServerMods(slot)
--> scripts/widgets/redux/modstab.lua(1411)

10. ShardSaveIndex:Save()
--> scripts/widgets/redux/modstab.lua(1412)

-- 点击读档按钮后 -------------------------------------------------------------------------

Lan Server Started on port: 10999

1. ShardSaveIndex:GetShardIndex(slot, shard, create_if_missing = true)
--> scripts/screens/redux/servercreationscreen.lua(355)
|
1.1. ShardIndex:SetServerShardData(customoptions = nil, serverdata, onsavedcb)
--> scripts/screens/redux/servercreationscreen.lua(359)
|
assert(ShardSaveGameIndex:GetShardIndex(slot, "Master"), "failed to save shardindex.")
--> onsavedcb

-- 启动新进程后 --------------------------------------------------------------------------

SaveIndex:
	_ctor()
	Init()
	GuaranteeMinNumSlots(5)

ShardSaveIndex:
	_ctor()

Profile:Load( function()
	SaveGameIndex:Load(function()
		ShardSaveGameIndex:Load(function()
			ShardGameIndex:Load( OnFilesLoaded )
		end)
	end)
end)
--> scripts/gamelogic.lua

-- 触发回调
if --[[...]] then
	--[[...]]
elseif Settings.reset_action == RESET_ACTION.LOAD_SLOT then
	--ShardGameIndex already contains the contextual slot from Settings.save_slot
	if ShardGameIndex:IsEmpty() then
		--print("Reset Action: LOAD_SLOT -- Re-generate world")
        ShardGameIndex:Delete(function()
            ShardGameIndex:SetServerShardData(
                ShardGameIndex:GetGenOptions(),
                ShardGameIndex:GetServerData(),
                function()
                    DoGenerateWorld()
                end)
        end, true)
	else
		--print("Reset Action: LOAD_SLOT -- current save")
		LoadSlot()
	end
elseif --[[...]] then
	--[[...]]
end
