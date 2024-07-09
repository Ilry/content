local Widget = require "widgets/widget"
local ImageButton = require "widgets/imagebutton"
local MateUtils = require("mym_mateutils")

local function InitButton(btn)
    btn:SetFont(BUTTONFONT)
    btn:SetDisabledFont(BUTTONFONT)
    btn:SetTextSize(26)
    btn.text:SetVAlign(ANCHOR_MIDDLE)
    btn.text:SetColour(0, 0, 0, 1)
    btn.text:SetPosition(2, 0)
end

local function GetCommandRange()
    return ThePlayer.mym_commandrange and ThePlayer.mym_commandrange:value() or 0
end

local MateCommand = Class(Widget, function(self, owner)
    Widget._ctor(self, "MateCommand")
    self.owner = owner

    self.isSpread = false --是否已经展开

    self.button = self:AddChild(ImageButton(resolvefilepath("images/crafting_menu_icons.xml"), "filter_health.tex"))
    self.button:SetOnClick(function() self:Switch(not self.isSpread) end)
    self.button:SetScale(0.3, 0.3) --图太大了

    --指令按钮
    self.commands = {}
    local baseX = 0
    local baseY = 202
    for _, k in ipairs(MateUtils.COMMANDS_LIST) do
        local d = MateUtils.COMMANDS[k]
        if d.uiClick then
            local btn = self:AddChild(ImageButton("images/ui.xml", "button_small.tex", "button_small_over.tex",
                "button_small_disabled.tex", nil, nil, { 1.2, 0.8 }))

            InitButton(btn)
            btn:SetText(STRINGS.MYM_MATES[string.upper(k)])
            btn:SetPosition(Vector3(baseX, baseY, 0))

            if ThePlayer.replica.mym_mate and not d.notoggle then
                local enable = ThePlayer.replica.mym_mate.sets[k]:value()
                btn:SetImageNormalColour(enable and 0 or 1, enable and 1 or 0, 0, 1)
            end

            btn:SetOnClick(function()
                if ThePlayer.replica.mym_mate then
                    local enable = ThePlayer.replica.mym_mate.sets[k]:value()

                    if not d.notoggle then
                        btn:SetImageNormalColour(enable and 1 or 0, enable and 0 or 1, 0, 1)
                    end

                    SendModRPCToServer(MOD_RPC["MyMate"]["SetMateSet"], ThePlayer,
                        json.encode({ [k] = { enable = not enable, isSkill = false } }))
                end
            end)
            table.insert(self.commands, btn)

            baseY = baseY - 28
            if baseY < 42 then
                baseY = 202
                baseX = baseX - 106
            end
        end
    end

    self.rangeButton = self:AddChild(ImageButton("images/ui.xml", "button_small.tex", "button_small_over.tex",
        "button_small_disabled.tex"))
    InitButton(self.rangeButton)
    local range = GetCommandRange()
    self.rangeButton:SetText("范围：" .. (range == 0 and "无限" or (range * 8)))
    self.rangeButton:SetPosition(Vector3(-106, 0, 0))
    self.rangeButton:SetOnClick(function()
        range = (GetCommandRange() + 1) % 5
        self.rangeButton:SetText("范围：" .. (range == 0 and "无限" or (range * 8)))
        if ThePlayer.mym_commandRange then
            ThePlayer.mym_commandRange.AnimState:SetScale(range * 8 / 6, range * 8 / 6)
        end

        SendModRPCToServer(MOD_RPC["MyMate"]["CommandRangeAdd"])
    end)

    self:Switch(false)
end)

local function CreateHelperRing(range)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst:AddTag("CLASSIFIED")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("firefighter_placement")
    inst.AnimState:SetBuild("firefighter_placement")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetAddColour(0, .2, .5, 0)
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
    inst.AnimState:SetScale(range / 6, range / 6)

    return inst
end

function MateCommand:Switch(isSpread)
    self.isSpread = isSpread
    if isSpread then
        -- 展开
        for _, btn in ipairs(self.commands) do
            btn:Show()
        end
        self.rangeButton:Show()

        -- 生成玩家脚下范围指示器
        if not ThePlayer.mym_commandRange or not ThePlayer.mym_commandRange:IsValid() then
            ThePlayer.mym_commandRange = CreateHelperRing(GetCommandRange() * 8)
            ThePlayer.mym_commandRange.entity:SetParent(ThePlayer.entity)
        end
    else
        for _, btn in ipairs(self.commands) do
            btn:Hide()
        end
        self.rangeButton:Hide()

        if ThePlayer.mym_commandRange then
            ThePlayer.mym_commandRange:Remove()
            ThePlayer.mym_commandRange = nil
        end
    end
end

----------------------------------------------------------------------------------------------------
function MateCommand:OnControl(control, down)
    Widget.OnControl(self, control, down)

    if control == CONTROL_ACCEPT then
        if down then
            self:StartDrag()
        else
            self:EndDrag()
        end
    end
end

function MateCommand:SetDragPosition(x, y, z)
    local pos
    if type(x) == "number" then
        pos = Vector3(x, y, 0)
    else
        pos = x
    end
    self:SetPosition(pos + self.dragPosDiff)
end

function MateCommand:StartDrag()
    if not self.followhandler then
        local mousepos = TheInput:GetScreenPosition()
        self.dragPosDiff = (self:GetPosition() - mousepos)
        self.followhandler = TheInput:AddMoveHandler(function(x, y)
            self:SetDragPosition(x, y)
        end)
        self:SetDragPosition(mousepos)
    end
end

function MateCommand:EndDrag()
    if self.followhandler then
        self.followhandler:Remove()
    end
    self.followhandler = nil
    self.dragPosDiff = nil
end

return MateCommand
