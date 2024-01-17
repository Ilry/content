local Widget = require "widgets/widget"
local TEMPLATES = require "widgets/redux/templates" --UI控件库
local Text = require "widgets/text"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"


local NamePresetScreen = require "screens/namepresetscreen" --命名预设屏幕
local PopupDialogScreen = require "screens/redux/popupdialog" --弹出对话框屏幕
--------------------------------------------------------------------------
--[[ Member variables ]] --成员变量
--------------------------------------------------------------------------
-- local window_width = 400
-- local window_height = 550

local widget_width = 340
local widget_height = 90
local NUM_ROWS = 5

local padded_width = widget_width + 10
local padded_height = widget_height + 10

    -- {settings_desc="1",text="标题1",data = {}},
--------------------------------------------------------------------------
--[[ TaskListing ]] --显示任务列表类
--------------------------------------------------------------------------
local normal_list_item_bg_tint = {1, 1, 1, 0.4}
local focus_list_item_bg_tint  = {1, 1, 1, 0.6}
local current_list_item_bg_tint = {1, 1, 1, 0.8}
local focus_current_list_item_bg_tint  = {1, 1, 1, 1}

local hover_config = {
    offset_x = 0,
    offset_y = 48,
}
local preset_settingsdata = {}

local TaskListing = Class(Widget, function(self, context, data, index)
    Widget._ctor(self, "TaskListing")
    self:SetOnGainFocus(function() context.type_list:OnWidgetFocus(self) end)
    --初始化
    self:DoInit(context, data, index)
end)
function TaskListing:DoInit(context, data, index)
    --背景
    self.backing = self:AddChild(TEMPLATES.ListItemBackground(340, 90, function() context:OnPresetButton(self.data) end))
    self.backing.move_on_click = true

    self.name = self.backing:AddChild(Text(HEADERFONT, 26))
    self.name:SetHAlign(ANCHOR_LEFT)
    self.name:SetRegionSize(padded_width - 40, 30)
    self.name:SetPosition(0, padded_height/2 - 22.5)
    --描述
    self.desc = self.backing:AddChild(Text(CHATFONT, 16))
    self.desc:SetVAlign(ANCHOR_MIDDLE)
    self.desc:SetHAlign(ANCHOR_LEFT)
    self.desc:SetPosition(0, padded_height/2 -(20 + 26 + 10))
    --编辑按钮
    self.edit = self.backing:AddChild(TEMPLATES.IconButton("images/button_icons.xml", "mods.tex", STRINGS.UI.CUSTOMIZATIONSCREEN.EDITPRESET, false, false, function() context:Editself(self.data) end, hover_config))
    self.edit:SetScale(0.5)
    self.edit:SetPosition(100, padded_height/2 - 22.5)
    --删除按钮
    self.delete = self.backing:AddChild(TEMPLATES.IconButton("images/button_icons.xml", "delete.tex", STRINGS.UI.CUSTOMIZATIONSCREEN.DELETEPRESET, false, false, function() print("删除预设",self.data.id) context:Deleteself(self.data) end, hover_config))
    self.delete:SetScale(0.5)
    self.delete:SetPosition(135, padded_height/2 - 22.5)

    local _OnControl = self.backing.OnControl
    self.backing.OnControl = function(_, control, down)
        if self.edit.focus and self.edit:OnControl(control, down) then return true end
        if self.delete.focus and self.delete:OnControl(control, down) then return true end

        --正常按钮逻辑
        if _OnControl(_, control, down) then return true end

        if not down and self.data then
            if control == CONTROL_MENU_MISC_1 then
                if self.data then
                    -- context:Editself(self.data)
                    TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
                    return true
                end
            elseif control == CONTROL_MENU_MISC_2 then
                if self.data then
                    -- context:Deleteself(self.data)
                    TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
                    return true
                end
            end
            context:Refresh()
        end
    end

    self.focus_forward = self.backing
end
local function UpdateTaskListing(context, self, data, index) 
    if not data then
        self.backing:Hide()
        self.data = nil
        return
    end

    if context.selectedpresetid == data.id then
        self.backing:Select()
        self.name:SetColour(UICOLOURS.GOLD_SELECTED)
    else
        self.backing:Unselect()
        self.name:SetColour(UICOLOURS.GOLD_CLICKABLE)
    end

    if self.data ~= data then
        self.data = data
        self.backing:Show()

        self.name:SetString(data.text)
        self.desc:SetMultilineTruncatedString(data.settings_desc, 3, padded_width - 40, nil, "...")

        if data.data == context.originalpreset then
            self.backing:SetImageNormalColour(unpack(current_list_item_bg_tint))
            self.backing:SetImageFocusColour(unpack(focus_current_list_item_bg_tint))
            self.backing:SetImageSelectedColour(unpack(current_list_item_bg_tint))
            self.backing:SetImageDisabledColour(unpack(current_list_item_bg_tint))
        else
            self.backing:SetImageNormalColour(unpack(normal_list_item_bg_tint))
            self.backing:SetImageFocusColour(unpack(focus_list_item_bg_tint))
            self.backing:SetImageSelectedColour(unpack(normal_list_item_bg_tint))
            self.backing:SetImageDisabledColour(unpack(normal_list_item_bg_tint))
        end
    end
end

--------------------------------------------------------------------------
--[[ ZDYMODSPresetPanel ]] 
--------------------------------------------------------------------------
local ZDYMODSPresetPanel = Class(Widget, function(self, owner)
    Widget._ctor(self, "ZDYMODSPresetPanel")
    self.owner = owner --是ServerCreationScreen

    self.root = self:AddChild(Widget("root"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)


    self.add_button = self.root:AddChild(TEMPLATES.StandardButton(function() self:Add() end,"添加预设",{100, 45}))
    self.app_button = self.root:AddChild(TEMPLATES.StandardButton(function() self:App() end,"应用预设",{100, 45}))
    self.dam_button = self.root:AddChild(TEMPLATES.StandardButton(function() KnownModIndex:DisableAllServerMod() end,"关闭全部启用的服务器mod",{150, 45}))
    self.new_button = self.root:AddChild(TEMPLATES.StandardButton(function() self:Export() end,"导出预设",{100, 45}))

    self.add_button:SetPosition(-250, 233.75)
    self.app_button:SetPosition(-100, 233.75)
    self.dam_button:SetPosition(250, 233.75)
    self.new_button:SetPosition(50, 233.75)

    self:BuildTypeList(self:GetTypeData()) 
    -- self:BuildModList(self:GetModData()) 

    self.default_focus = self.owner
end)

function ZDYMODSPresetPanel:Export(filename)
    if self.selectedpresetid == nil then
        TheFrontEnd:PushScreen(
            PopupDialogScreen("未选择模组预设", "请选择模组预设",
            {
                {
                    text = STRINGS.UI.CUSTOMIZATIONSCREEN.OKAY,
                    cb = function()
                        TheFrontEnd:PopScreen()
                    end,
                },
            })
        )
        return 
    end
    local filename = filename or "modoverrides.lua"

    local file, msg = io.open(filename, "w")
    if file == nil then
        print("创建文件失败", msg)
        return
    end
    local preset = KnownModIndex:GetPresetsModsData(self.selectedpresetid)
    local t = {}
    for modname, data in pairs(preset.data or {}) do
        t[modname] = {}
        t[modname].configuration_options = {}
        for k,v in ipairs(data or {}) do
            t[modname].configuration_options[v.name] = v.current
        end
        t[modname].enabled=true
    end
    local str = DataDumper(t, nil, false)
    file:write(str)
    file:close()
    TheFrontEnd:PushScreen(
        PopupDialogScreen("导出成功", "导出到了Steam\\steamapps\\common\\Don't Starve Together\\data文件夹下的modoverrides.lua",
        {
            {
                text = STRINGS.UI.CUSTOMIZATIONSCREEN.OKAY,
                cb = function()
                    TheFrontEnd:PopScreen()
                end,
            },
        })
    )
end
function ZDYMODSPresetPanel:Add()
    print("添加预设")
    TheFrontEnd:PushScreen(
        NamePresetScreen(
            "新增预设",
            "确定",
            function(newid, name, description)
                local savedata = KnownModIndex:GetEnabledServerModData() --当前已启用的服务器mods及其mod配置
                TheSim:SetPersistentString(newid, DataDumper(savedata, nil, false), false,
                    function(success) 
                        if success then
                            local data = {
                                id = newid,
                                text = name,
                                settings_desc = description,
                                data = savedata,
                            }
                            table.insert(self:GetTypeData(), data) --添加的列表中    
                            KnownModIndex:SaveMyData() --存预设列表
                            self:Refresh() --更新列表                        
                        end
                    end
                ) --保存为本地文件
            end
        )
    )
end
function ZDYMODSPresetPanel:App()
    local questionable = KnownModIndex:ApplyPreset(self.selectedpresetid)
    if #questionable > 0 then
        TheFrontEnd:PushScreen(
            PopupDialogScreen("预设的mod设置数据有误", "对数据有误mod启用但未其设置参数，请自行前往确认一下。",
            {
                {
                    text = STRINGS.UI.CUSTOMIZATIONSCREEN.OKAY,
                    cb = function()
                        TheFrontEnd:PopScreen()
                    end,
                },
            })
        )
    end
end

function ZDYMODSPresetPanel:Editself(data)
    if data.id then
        local preset, idx = KnownModIndex:GetPresetsModsData(data.id)
        TheFrontEnd:PushScreen(
            NamePresetScreen(
                "编辑预设",
                "更新",
                function(newid, name, description)
                    local old_id = data.id
                    local savedata = KnownModIndex:GetEnabledServerModData() --当前已启用的服务器mods及其mod配置
                    TheSim:SetPersistentString(newid, DataDumper(savedata, nil, false), false, --保存为本地文件
                        function(success) 
                            if success then
                                --暂时搞不懂 但是注释部分不会更新列表
                                table.remove(self:GetTypeData(), idx)
                                local data = {
                                    id = newid,
                                    text = name,
                                    settings_desc = description,
                                    data = savedata,
                                }
                                table.insert(self:GetTypeData(), idx, data)

                                -- 换成data也没有用 明明都是指向一个表啊。如果知道的可以向我联系告知万分感谢。
                                -- preset.id = newid
                                -- preset.text = name
                                -- preset.settings_desc = description
                                -- preset.data = savedata
                                -- print(preset, data, self:GetTypeData()[idx])--都指向了同一个地址

                                if old_id ~= newid then --前后名字不一样的时候
                                    TheSim:ErasePersistentString(old_id) --删除改名前的文件
                                end
                                KnownModIndex:SaveMyData() --存预设列表
                                self:Refresh() --更新列表
                            end
                        end
                    ) 
                end,
                data.id,
                preset.text,
                preset.settings_desc
            )
        )        
    end
end
function ZDYMODSPresetPanel:Deleteself(data)
    if data.id then
        local preset, idx = KnownModIndex:GetPresetsModsData(data.id)
        local id = preset.id
        TheFrontEnd:PushScreen(
            PopupDialogScreen("是否删除预设 - "..preset.text, STRINGS.UI.CUSTOMIZATIONSCREEN.DELETEPRESET_BODY,
            {
                {
                    text = STRINGS.UI.CUSTOMIZATIONSCREEN.CANCEL,
                    cb = function()
                        TheFrontEnd:PopScreen()
                    end,
                },
                {
                    text = STRINGS.UI.CUSTOMIZATIONSCREEN.DELETE,
                    cb = function()
                        TheSim:ErasePersistentString(id, function(success) 
                            if not success then
                                print("删除失败，可能文件已经被删除")          
                            end
                            for k,v in ipairs(self.type_list.items) do
                                if v.id == id then
                                    table.remove(self.type_list.items, k)
                                    break
                                end
                            end
                            KnownModIndex:ErasePresetsModsData(id) --列表中删除
                            KnownModIndex:SaveMyData() --存预设列表到文件
                            self:Refresh() --更新列表   
                            TheFrontEnd:PopScreen()
                        end)
                    end,
                },
            })
        )
    end 
end
--选择了列表项目执行
function ZDYMODSPresetPanel:OnPresetButton(data)
    self:OnSelectPreset(data)
    self:Refresh() --刷新一下
end
function ZDYMODSPresetPanel:OnSelectPreset(data)
    self.selectedpresetid = data.id --记录下是modslist中的那一个项
end

function ZDYMODSPresetPanel:GetTypeData()
    return KnownModIndex.presets
end
function ZDYMODSPresetPanel:GetModData()
    return KnownModIndex:GetPresetsModsNames(self.selectedpresetid)
end
--创建预设列表
function ZDYMODSPresetPanel:BuildTypeList(typedatas)
    if typedatas then
        if not self.type_list then--滚动列表
            local function ScrollWidgetsCtor(context, index) --滚动小部件Ctor
                local w = TaskListing(context, typedatas[index] or {}, index)
                w.ongainfocusfn = function()
                    self.type_list:OnWidgetFocus(w) --聚焦时
                end
                return w
            end

            self.type_list = self.root:AddChild(TEMPLATES.ScrollingGrid(
                    typedatas,
                    {
                        scroll_context = self,--{ grouplist = self},
                        widget_width  = widget_width, --子项宽
                        widget_height = widget_height, --子项高
                        num_visible_rows = NUM_ROWS, -- 滚动条内最多显示多少行
                        num_columns      = 1, --多少列
                        item_ctor_fn = ScrollWidgetsCtor, --生成列表
                        apply_fn = UpdateTaskListing, --更新列表
                        scrollbar_offset = 10,
                        scrollbar_height_offset = -60,
                        peek_percent = 0.5,
                        -- allow_bottom_empty_row = true, --允许底部空行
                    }
                ))
            self.type_list:SetPosition(-200, -43.75)
        else
            self.type_list:SetItemsData(typedatas)
            self.type_list:RefreshView()
        end    
    end
end
--创建预设内容列表
function ZDYMODSPresetPanel:BuildModList(typedatas)
    if typedatas then
        if not self.mods_list then--滚动列表
            local function ScrollWidgetsCtor(context, index) --滚动小部件Ctor
                local modname = typedatas[index] and typedatas[index].modname or nil
                local modinfo = KnownModIndex:GetModInfo(modname)

                local opt = TEMPLATES.ModListItem(
                    function()
                        -- print("显示mod信息")
                    end,
                    function() 
                        -- print("启用mod")
                    end,
                    function()
                        -- print("收藏mod")
                    end
                )
                opt.idx = index
                opt:Hide()
                return opt
            end
            local function ApplyDataToWidget(context, opt, data, index)
                opt:Hide()
                if data then
                    local modname = data.modname
                    local modinfo = KnownModIndex:GetModInfo(modname)
                    opt:SetModReadOnly(true) --没有复选框和收藏
                    opt:SetMod(modname, modinfo, data.same and "WORKING_NORMALLY" or "DISABLED_ERROR", false, false)
                    opt.status:SetString(data.same and "" or "存储mod设置失效")
                    opt.status:Show()
                    opt:Show()
                end
            end

            self.mods_list = self.root:AddChild(TEMPLATES.ScrollingGrid(
                    typedatas,
                    {
                        scroll_context = self,--{ grouplist = self},
                        widget_width  = widget_width, --子项宽
                        widget_height = widget_height, --子项高
                        num_visible_rows = NUM_ROWS, -- 滚动条内最多显示多少行
                        num_columns      = 1, --多少列
                        item_ctor_fn = ScrollWidgetsCtor, --生成列表
                        apply_fn = ApplyDataToWidget, --更新列表
                        scrollbar_offset = 10,
                        scrollbar_height_offset = -60,
                        peek_percent = 0.5,
                        -- allow_bottom_empty_row = true, --允许底部空行
                    }
                ))
            self.mods_list:SetPosition(300, -43.75)
            self.number = self.mods_list:AddChild(Text(UIFONT, 30))
            self.number:SetPosition(50, 280)
            self.number:SetString(tostring(#typedatas))
        else
            self.mods_list:SetItemsData(typedatas)
            self.mods_list:RefreshView()
            self.number:SetString(tostring(#typedatas))
        end    
    end
end

function ZDYMODSPresetPanel:Refresh()
    self:BuildTypeList(self:GetTypeData()) 
    self:BuildModList(self:GetModData())
end


function ZDYMODSPresetPanel:Close()

end

return ZDYMODSPresetPanel