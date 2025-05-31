local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local function OnEffigyDeactivated(inst)
    if inst.AnimState:IsCurrentAnimation("effigy_deactivate") then
        inst.widget:Hide()
    end
end

local ExtraEnduranceAnimPercentTable = {0.89 ,0.78, 0.67, 0.56, 0.45, 0.34, 0.23, 0.12, 0}

local EnduranceBadge = Class(Badge, function(self, owner, art)
    Badge._ctor(self, art, owner, nil, --{ 174 / 255, 21 / 255, 21 / 255, 1 }, -- 颜色
            "status_endurance", nil, nil, true)
    --owner._net_endurance_bonus = owner._net_endurance_bonus or net_smallbyte(owner.GUID, "_net_endurance_bonus")
    --owner._net_current_endurance_bonus = owner._net_endurance_bonus or net_smallbyte(owner.GUID, "_net_current_endurance_bonus")

    self.brokenextraendurancespikes = self.underNumber:AddChild(UIAnim())
    self.brokenextraendurancespikes:GetAnimState():SetBank("xs_endurance") -- 一级目录名
    self.brokenextraendurancespikes:GetAnimState():SetBuild("xs_endurance") -- scml名
    self.brokenextraendurancespikes:GetAnimState():PlayAnimation("empty_xs") -- 二级动画名
    self.brokenextraendurancespikes:GetAnimState():AnimateWhilePaused(false)
    self.brokenextraendurancespikes:GetAnimState():SetPercent("empty_xs", 1)

    self.extraendurancespikes = self.underNumber:AddChild(UIAnim())
    self.extraendurancespikes:GetAnimState():SetBank("xs_endurance")
    self.extraendurancespikes:GetAnimState():SetBuild("xs_endurance")
    self.extraendurancespikes:GetAnimState():PlayAnimation("full_xs")
    self.extraendurancespikes:GetAnimState():AnimateWhilePaused(false)
    self.extraendurancespikes:GetAnimState():SetPercent("full_xs", 1)

    self.anim:GetAnimState():SetBank("status_endurance")
    self.anim:GetAnimState():SetBuild("status_endurance")
    self.anim:GetAnimState():PlayAnimation("anim")
    self.anim:SetScale(.5, .5, 1)
    self.anim:GetAnimState():SetPercent("anim", 1)

    if self.circleframe ~= nil then
        self.circleframe:GetAnimState():Hide("frame")
    else
        self.anim:GetAnimState():Hide("frame")
    end

    self.circleframe2 = self.underNumber:AddChild(UIAnim())
    self.circleframe2:GetAnimState():SetBank("status_meter_endurance")
    self.circleframe2:GetAnimState():SetBuild("status_meter_endurance")
    self.circleframe2:GetAnimState():PlayAnimation("frame_eyeup")
    self.circleframe2:GetAnimState():AnimateWhilePaused(false)



    self.sanityarrow = self.underNumber:AddChild(UIAnim())
    self.sanityarrow:GetAnimState():SetBank("sanity_arrow")
    self.sanityarrow:GetAnimState():SetBuild("sanity_arrow")
    self.sanityarrow:GetAnimState():PlayAnimation("neutral")
    self.sanityarrow:SetClickable(false)
    self.sanityarrow:GetAnimState():AnimateWhilePaused(false)

    self.effigyanim = self.underNumber:AddChild(UIAnim())
    self.effigyanim:GetAnimState():SetBank("status_health")
    self.effigyanim:GetAnimState():SetBuild("status_health")
    self.effigyanim:GetAnimState():PlayAnimation("effigy_deactivate")
    self.effigyanim:Hide()
    self.effigyanim:SetClickable(false)
    self.effigyanim:GetAnimState():AnimateWhilePaused(false)
    self.effigyanim.inst:ListenForEvent("animover", OnEffigyDeactivated)
    self.effigy = false
    self.effigybreaksound = nil

    self.bufficon = self.underNumber:AddChild(UIAnim())
    self.bufficon:GetAnimState():SetBank("status_abigail")
    self.bufficon:GetAnimState():SetBuild("status_abigail")
    self.bufficon:GetAnimState():PlayAnimation("buff_none")
    self.bufficon:GetAnimState():AnimateWhilePaused(false)
    self.bufficon:SetClickable(false)
    self.bufficon:SetScale(-1,1,1)
    self.buffsymbol = 0

    self.corrosives = {}
    self._onremovecorrosive = function(debuff)
        self.corrosives[debuff] = nil
    end
    self.inst:ListenForEvent("startcorrosivedebuff", function(owner, debuff)
        if self.corrosives[debuff] == nil then
            self.corrosives[debuff] = true
            self.inst:ListenForEvent("onremove", self._onremovecorrosive, debuff)
        end
    end, owner)

    self.hots = {}
    self._onremovehots = function(debuff)
        self.hots[debuff] = nil
    end
    self.inst:ListenForEvent("starthealthregen", function(owner, debuff)
        if self.hots[debuff] == nil then
            self.hots[debuff] = true
            self.inst:ListenForEvent("onremove", self._onremovehots, debuff)
        end
    end, owner)

    self.small_hots = {}
    self._onremovesmallhots = function(debuff)
        self.small_hots[debuff] = nil
    end
    self.inst:ListenForEvent("startsmallhealthregen", function(owner, debuff)
        if self.small_hots[debuff] == nil then
            self.small_hots[debuff] = true
            self.inst:ListenForEvent("onremove", self._onremovesmallhots, debuff)
        end
    end, owner)
    self.inst:ListenForEvent("stopsmallhealthregen", function(owner, debuff)
        if self.small_hots[debuff] ~= nil then
            self._onremovesmallhots(debuff)
            self.inst:RemoveEventCallback("onremove", self._onremovesmallhots, debuff)
        end
    end, owner)

    self:StartUpdating()
end)

function EnduranceBadge:ShowBuff(symbol)
    if symbol == 0 then
        if self.buffsymbol ~= 0 then
            self.bufficon:GetAnimState():PlayAnimation("buff_deactivate")
            self.bufficon:GetAnimState():PushAnimation("buff_none", false)
        end
    elseif symbol ~= self.buffsymbol then
        self.bufficon:GetAnimState():OverrideSymbol("buff_icon", self.OVERRIDE_SYMBOL_BUILD[symbol] or self.default_symbol_build, symbol)

        self.bufficon:GetAnimState():PlayAnimation("buff_activate")
        self.bufficon:GetAnimState():PushAnimation("buff_idle", false)
    end

    self.buffsymbol = symbol
end

function EnduranceBadge:UpdateBuff(symbol)
    self:ShowBuff(symbol)
end

function EnduranceBadge:ShowEffigy()
    if not self.effigy then
        self.effigy = true
        self.effigyanim:GetAnimState():PlayAnimation("effigy_activate")
        self.effigyanim:GetAnimState():PushAnimation("effigy_idle", false)
        self.effigyanim:Show()
    end
end

local function PlayEffigyBreakSound(inst, self)
    inst.task = nil
    if self:IsVisible() and inst.AnimState:IsCurrentAnimation("effigy_deactivate") then
        --Don't use FE sound since it's not a 2D sfx
        TheFocalPoint.SoundEmitter:PlaySound(self.effigybreaksound)
    end
end

function EnduranceBadge:HideEffigy()
    if self.effigy then
        self.effigy = false
        self.effigyanim:GetAnimState():PlayAnimation("effigy_deactivate")
        if self.effigyanim.inst.task ~= nil then
            self.effigyanim.inst.task:Cancel()
        end
        self.effigyanim.inst.task = self.effigyanim.inst:DoTaskInTime(7 * FRAMES, PlayEffigyBreakSound, self)
    end
end

function EnduranceBadge:SetPercent(val, max, penaltypercent)
    --if TUNING.WHY_DIFFICULTY == "-1" then       -- easy
    --    self.circleframe2:GetAnimState():PlayAnimation("frame_eyeup")
    --elseif TUNING.WHY_DIFFICULTY == "0" then    -- default
    --    if val < .65 then
    --        self.circleframe2:GetAnimState():PlayAnimation("frame")
    --    else
    --        self.circleframe2:GetAnimState():PlayAnimation("frame_eyeup")
    --    end
    --else                                        -- hard
    --    if val < 1 then
    --        self.circleframe2:GetAnimState():PlayAnimation("frame")
    --    else
    --        self.circleframe2:GetAnimState():PlayAnimation("frame_eyeup")
    --    end
    --end
    if self.owner.replica.why_endurance then
        if self.owner.replica.health:GetCurrent() >= 4 then
            self.circleframe2:GetAnimState():PlayAnimation("frame_eyeup")
        else
            self.circleframe2:GetAnimState():PlayAnimation("frame")
        end
    end

    Badge.SetPercent(self, val, max)
end

function EnduranceBadge:OnUpdateExtraEndurance()
    local endurance_bonus = self.owner._net_endurance_bonus:value() + 1
    local current_endurance_bonus = self.owner._net_current_endurance_bonus:value() + 1
    self.brokenextraendurancespikes:GetAnimState():SetPercent("empty_xs", ExtraEnduranceAnimPercentTable[endurance_bonus])
    self.extraendurancespikes:GetAnimState():SetPercent("full_xs", ExtraEnduranceAnimPercentTable[current_endurance_bonus])
end

function EnduranceBadge:OnUpdate(dt)
    if TheNet:IsServerPaused() then
        return
    end

    self:OnUpdateExtraEndurance()

    local down
    if (self.owner.IsFreezing ~= nil and self.owner:IsFreezing()) or
            (self.owner.replica.health ~= nil and self.owner.replica.health:IsTakingFireDamageFull()) or
            (self.owner.replica.hunger ~= nil and self.owner.replica.hunger:IsStarving()) or
            next(self.corrosives) ~= nil then
        down = "_most"
    elseif self.owner.IsOverheating ~= nil and self.owner:IsOverheating() then
        down = self.owner:HasTag("heatresistant") and "_more" or "_most"
    end

    -- Show the up-arrow when we're sleeping (but not in a straw roll: that doesn't heal us)
    local up = down == nil and
            (
                    ((self.owner.player_classified ~= nil and self.owner.player_classified.issleephealing:value()) or
                            next(self.hots) ~= nil or next(self.small_hots) ~= nil or
                            (self.owner.replica.inventory ~= nil and self.owner.replica.inventory:EquipHasTag("regen"))
                    ) or
                            (self.owner:HasDebuff("wintersfeastbuff"))
            ) and
            self.owner.replica.health ~= nil and self.owner.replica.health:IsHurt()

    local anim = (down ~= nil and ("arrow_loop_decrease" .. down)) or
            (not up and "neutral") or
            (next(self.hots) ~= nil and "arrow_loop_increase_most") or
            "arrow_loop_increase"

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.sanityarrow:GetAnimState():PlayAnimation(anim, true)
    end
end

return EnduranceBadge
