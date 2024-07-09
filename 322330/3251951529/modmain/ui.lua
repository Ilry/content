local Utils = require("mym_utils/utils")
local MateUtils = require("mym_mateutils")
local ImageButton = require "widgets/imagebutton"

local function AddButton(self, container, text, pos, t, isSkill)
    local button = self:AddChild(ImageButton("images/ui.xml", "button_small.tex", "button_small_over.tex",
        "button_small_disabled.tex", nil, nil, { 1.6, 1.2 }))
    button:SetFont(BUTTONFONT)
    button:SetDisabledFont(BUTTONFONT)
    button:SetTextSize(33)
    button.text:SetVAlign(ANCHOR_MIDDLE)
    button.text:SetColour(0, 0, 0, 1)
    button:Enable()

    local mate = container.mate and container.mate:value()
    local tabKey = isSkill and "skills" or "sets"

    local d = MateUtils.GetData(mate.prefab, t, isSkill) or {}
    local notoggle = d.notoggle
    local ageDay = mate.mym_ageday and mate.mym_ageday:value() or 0
    if not TUNING.MYM_UNLOCK_ALL_SKILLS and ageDay < (d.need or 0) then --未解锁
        button:Disable()
    end

    if not notoggle then
        local enable = mate.replica.mym_mate[tabKey][t]:value()
        button:SetImageNormalColour(enable and 0 or 1, enable and 1 or 0, 0, 1)
    end

    button.text:SetPosition(2, -2)
    button:SetText(text)
    button:SetPosition(pos)

    button:SetOnClick(function()
        if inst ~= nil then
            if inst:HasTag("busy") then
                --Ignore button click when doer is busy
                return
            elseif inst.components.playercontroller ~= nil then
                local iscontrolsenabled, ishudblocking = inst.components.playercontroller:IsEnabled()
                if not (iscontrolsenabled or ishudblocking) then
                    --Ignore button click when controls are disabled
                    --but not just because of the HUD blocking input
                    return
                end
            end
        end

        -- 省事点，这里直接改客机
        local enable = mate.replica.mym_mate[tabKey][t]:value()
        if not notoggle then
            button:SetImageNormalColour(enable and 1 or 0, enable and 0 or 1, 0, 1)
        end

        SendModRPCToServer(MOD_RPC["MyMate"]["SetMateSet"], mate,
            json.encode({ [t] = { enable = not enable, isSkill = isSkill } }))
    end)

    if TheInput:ControllerAttached() then
        button:Hide()
    end

    button.inst:ListenForEvent("continuefrompause", function()
        if TheInput:ControllerAttached() then
            button:Hide()
        else
            button:Show()
        end
    end, TheWorld)

    return button
end

AddClassPostConstruct("widgets/containerwidget", function(self)
    -- 队友的控制面板
    Utils.FnDecorator(self, "Open", nil, function(retTab, self, container, doer)
        local mate = container.mate and container.mate:value()
        if not mate or not mate:IsValid() or not mate.replica.mym_mate then return end

        if doer ~= nil and doer.components.playeractionpicker ~= nil then
            doer.components.playeractionpicker:RegisterContainer(container)
        end

        self.mym_buttons = {}
        -- 左侧按钮
        local baseX = -200
        local baseY = 100
        for _, key in ipairs(MateUtils.COMMANDS_LIST) do
            table.insert(self.mym_buttons,
                AddButton(self, container, STRINGS.MYM_MATES[string.upper(key)], Vector3(baseX, baseY, 0), key))
            baseY = baseY - 40
            if baseY < -100 then
                baseY = 100
                baseX = baseX - 140
            end
        end


        -- 右侧按钮
        local buttons = MateUtils.GetButtons(mate.prefab)
        if #buttons > 0 then
            baseX = 200
            baseY = 100
            local upperName = string.upper(mate.prefab)
            for _, v in ipairs(buttons) do
                local str = STRINGS["MYM_MATE_SKILLS_" .. upperName] or STRINGS.MYM_MATE_SKILLS[upperName]
                str = str and str[string.upper(v)] or v
                table.insert(self.mym_buttons,
                    AddButton(self, container, str, Vector3(baseX, baseY, 0), v, true))
                baseY = baseY - 40
                if baseY < -100 then
                    baseY = 100
                    baseX = baseX + 140
                end
            end
        end
    end)


    Utils.FnDecorator(self, "Close", nil, function(retTab, self)
        if self.isopen and self.mym_buttons then
            for _, btn in ipairs(self.mym_buttons) do
                btn:Kill()
            end
            self.mym_buttons = nil
        end
    end)
end)

----------------------------------------------------------------------------------------------------
local MateCommand = require("widgets/mym_mate_command")
AddClassPostConstruct("widgets/controls", function(self)
    self.inst:DoTaskInTime(1, function() --等组件副件加载一下
        self.mym_mateCommand = self:AddChild(MateCommand(self.owner))
        self.mym_mateCommand:SetVAnchor(ANCHOR_BOTTOM)
        self.mym_mateCommand:SetHAnchor(ANCHOR_RIGHT)
        self.mym_mateCommand:SetPosition(-260, 150)
    end)
end)
