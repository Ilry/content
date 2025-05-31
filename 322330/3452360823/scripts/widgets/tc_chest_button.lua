local Widget = require "widgets/widget"
local ImageButton = require "widgets/imagebutton"

local IMAGE_SIZE = {80, 50}
local TEXT_SIZE = 40

local PARAMS = {
    font = CHATFONT,
    font_size = 20,
    bg = true,
    -- bg_atlas = "images/global_redux.xml",
    -- bg_texture = "button_carny_long_normal.tex",
    offset_x = 0,
    offset_y = 200,
    -- region_w = 200,
    -- region_h =200,
    wordwrap = true,
}

local OFFSET_X, OFFSET_Y = 50, -50

local TCChestButton = Class(Widget, function(self, owner)
    Widget._ctor(self, "TCChestButton")

    self.owner = owner
    self.chest = nil

    -- 收集按钮
    self.collectbutton = self:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
    self.collectbutton:ForceImageSize(unpack(IMAGE_SIZE))
    self.collectbutton:SetPosition(560 + OFFSET_X, 45 + OFFSET_Y)
    self.collectbutton:SetFont(CHATFONT)
    self.collectbutton.text:SetColour(0, 0, 0, 1)
    self.collectbutton.text:SetSize(TEXT_SIZE)
    self.collectbutton:SetText(STRINGS.TC_CHEST_COLLECT_BUTTON)
    self.collectbutton:SetScale(1)
    self.collectbutton:SetHoverText("收集箱子中存放的同类物品", PARAMS)
    self.collectbutton.onclick = function()
        if self.chest ~= nil then
            SendModRPCToServer(MOD_RPC["TC"]["chest_collect"], self.chest)
        end
    end

    -- 控制按钮
    self.controlbutton = self:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
    self.controlbutton:ForceImageSize(unpack(IMAGE_SIZE))
    self.controlbutton:SetPosition(560 + OFFSET_X, 0 + OFFSET_Y)
    self.controlbutton:SetFont(CHATFONT)
    self.controlbutton.text:SetColour(0, 0, 0, 1)
    self.controlbutton.text:SetSize(TEXT_SIZE)
    self.controlbutton:SetText(STRINGS.TC_CHEST_CONTROL_BUTTON)
    self.controlbutton:SetScale(1)
    self.controlbutton.onclick = function()
        if self.chest ~= nil then
            SendModRPCToServer(MOD_RPC["TC"]["chest_control"], self.chest)
            self.owner:DoTaskInTime(0.1, function() self:UpdateTips() end)
        end
    end

    -- 开关按钮
    self.switchbutton = self:AddChild(ImageButton("images/global_redux.xml", "button_carny_long_normal.tex", "button_carny_long_hover.tex", "button_carny_long_disabled.tex", "button_carny_long_down.tex"))
    self.switchbutton:ForceImageSize(unpack(IMAGE_SIZE))
    self.switchbutton:SetPosition(560 + OFFSET_X, -45 + OFFSET_Y)
    self.switchbutton:SetFont(CHATFONT)
    self.switchbutton.text:SetColour(0, 0, 0, 1)
    self.switchbutton.text:SetSize(TEXT_SIZE)
    self.switchbutton:SetText(STRINGS.TC_CHEST_SWITCH_BUTTON)
    self.switchbutton:SetScale(1)
    self.switchbutton.onclick = function()
        if self.chest ~= nil then
            SendModRPCToServer(MOD_RPC["TC"]["chest_switch"], self.chest)
            self.owner:DoTaskInTime(0.1, function() self:UpdateTips() end)
        end
    end

    self.owner:DoTaskInTime(0.1, function() self:UpdateTips() end)
end)

function TCChestButton:SetContainer(chest)
    self.chest = chest
end

function TCChestButton:UpdateTips()
    if self.chest == nil then
        return
    end
    self.chest:DoTaskInTime(0.1, function()
        if self.chest._control:value() then
            self.controlbutton:SetHoverText("当前控制状态: 打开\n"..STRINGS.TC_CHEST_CONTROL_BUTTON_TIPS, PARAMS)
        else
            self.controlbutton:SetHoverText("当前控制状态：关闭\n"..STRINGS.TC_CHEST_CONTROL_BUTTON_TIPS, PARAMS)
        end
        if self.chest._switch:value() then
            self.switchbutton:SetHoverText("当前开关状态: 打开\n"..STRINGS.TC_CHEST_SWITCH_BUTTON_TIPS, PARAMS)
        else
            self.switchbutton:SetHoverText("当前开关状态：关闭\n"..STRINGS.TC_CHEST_SWITCH_BUTTON_TIPS, PARAMS)
        end
    end)
end

-- fronted.lua中调用了，不写会报错
function TCChestButton:OnUpdate()
end

return TCChestButton