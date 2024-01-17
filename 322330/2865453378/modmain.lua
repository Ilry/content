-- env为modmain中的环境
-- 将GLOBAL中的所有变量插入env
-- GLOBAL无法在代码补全中正常显示，使用该方法方便开发
GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

local charger_number_local = GetModConfigData("charger_number", true)

-- 载入ui
local UIAnim = require "widgets/uianim"
-- 设定插槽上限
TUNING.WX78_MAXELECTRICCHARGE = charger_number_local
-- 设定递增速度 偷了懒 但是问题不大
for i = 5, TUNING.WX78_MAXELECTRICCHARGE, 1 do
    TUNING.WX78_MOVESPEED_CHIPBOOSTS[i] = TUNING.WX78_MOVESPEED_CHIPBOOSTS[i - 1] + 0.1
end

-- 从科雷代码复制出来的 略作修改
local OnUpgradeModulesListDirty = function(inst)
    if inst._parent ~= nil then
        local modules = {}
        for i = 1, TUNING.WX78_MAXELECTRICCHARGE, 1 do
            modules[i] = inst.upgrademodules[i]:value()
        end

        for i = 1, TUNING.WX78_MAXELECTRICCHARGE + 1, 1 do
            -- 只有不为0的情况
            if modules[i] ~= 0 then
                inst._parent:PushEvent("upgrademodulesdirty", modules)
                break
            end
            -- modules全为0的情况
            if i == TUNING.WX78_MAXELECTRICCHARGE + 1 then
                inst._parent:PushEvent("upgrademoduleowner_popallmodules")
            end
        end
    end
end

-- 在player_classified初始化后执行
AddPrefabPostInit("player_classified", function(inst)
    for i = 7, TUNING.WX78_MAXELECTRICCHARGE, 1 do
        table.insert(inst.upgrademodules,
            net_smallbyte(inst.GUID, "upgrademodules.mods" .. i, "upgrademoduleslistdirty"))
    end

    if not TheWorld.ismastersim then
        inst.event_listeners["upgrademoduleslistdirty"] = {}
        inst.event_listening["upgrademoduleslistdirty"] = {}
        inst:ListenForEvent("upgrademoduleslistdirty", OnUpgradeModulesListDirty)
    end
end)

-- 
AddClassPostConstruct("widgets/upgrademodulesdisplay", function(self, ...)
    for i = 1, TUNING.WX78_MAXELECTRICCHARGE-6, 1 do
        local chip_object = self:AddChild(UIAnim())
        chip_object:GetAnimState():SetBank("status_wx")
        chip_object:GetAnimState():SetBuild("status_wx")
        chip_object:GetAnimState():AnimateWhilePaused(false)

        chip_object:GetAnimState():Hide("plug_on")
        chip_object._power_hidden = true

        chip_object:MoveToBack()
        chip_object:Hide()

        table.insert(self.chip_objectpool, chip_object)
    end

    for i, v in ipairs(self.chip_objectpool) do
        v:SetPosition(0, 0)
    end

    self.battery_frame:SetPosition(0, 0)
end)

AddClassPostConstruct("widgets/secondarystatusdisplays", function(self, ...)
    if self.upgrademodulesdisplay then
        self.upgrademodulesdisplay:SetPosition(self.column1, -550)
    end
end)

local function OnAllUpgradeModulesRemoved(inst)
    SpawnPrefab("wx78_big_spark"):AlignToTarget(inst)

    inst:PushEvent("upgrademoduleowner_popallmodules")

    if inst.player_classified ~= nil then
        for i = 1, TUNING.WX78_MAXELECTRICCHARGE, 1 do
            inst.player_classified.upgrademodules[i]:set(0)
        end
    end
end

AddPrefabPostInit("wx78", function(inst)
    if TheWorld.ismastersim then
        inst:DoTaskInTime(.1, function()
            inst.components.upgrademoduleowner.onallmodulespopped = OnAllUpgradeModulesRemoved
        end)
    end
end)
