-------------------------------------------------------------------------------------------
---[[声明]]
-------------------------------------------------------------------------------------------
-- [[该皮肤系统参考并80%源自风铃大佬的皮肤系统，感谢风铃的辛勤付出]]

-------------------------------------------------------------------------------------------
---[[格式]]
-------------------------------------------------------------------------------------------
--[[
物品皮肤格式
MakeItemSkin(base, skinname, data)
    base = string,
    skinname = string,
    data = { 打*的为必填项 
        *name = string or skinname      -- 皮肤的名称
        des = string or "",             -- 皮肤界面的描述

        rarity = string or "Loyal",     -- 珍惜度 官方不存在的珍惜度则直接覆盖字符串
        rarityorder = int or -1         -- 珍惜度的排序
        raritycorlor = {R,G,B,A}        -- 珍惜度的颜色

        atlas = string or nil,          -- 贴图xml
        image = string or nil,          -- 贴图tex
        bank    = string or nil,        -- 如果需要替换bank就传 不需要就不传
        build   = string or skinname,   -- 如果需要替换build就传 不需要就默认和皮肤同名
        anim    = string or nil,        -- 如果需要替换anim就传 不需要就不传

        basebank    = string or nil,    -- 如果替换了bank就传 不需要就不传
        basebuild   = string or prefab, -- 如果替换了build就传 不需要默认原prefab
        baseanim    = string or nil,    -- 如果替换了anim就传 不需要就不传

        checkfn = function or nil,      -- 检查是否拥有的 主要是客机自己执行 为空则默认拥有
        checkclientfn = function or nil,-- 检查客户端是否拥有的 主要是主机执行 
        init_fn = function or nil,   
        clear_fn = function or nil,

        skin_tags = {} or nil,           -- 皮肤的tag用于过滤
        assets = {} or nil,             -- 皮肤用到的资源 
    }

人物皮肤格式
MakeCharacterSkin(base, skinname, data)
    base = string,
    skinname = string,
    data = { 打*的为必填项 
        *name = string or skinname      -- 皮肤的名称
        des = string or "",             -- 皮肤界面的描述
        quotes = string or "",          -- 皮肤的语录

        rarity = string or "Loyal",     -- 珍惜度 官方不存在的珍惜度则直接覆盖字符串
        rarityorder = int or -1         -- 珍惜度的排序
        raritycolor = {R,G,B,A}         -- 珍惜度的颜色

        skins = {normal_skin = string, ghost_skin = string} -- 正常和幽灵皮肤的名称
        share_bigportrait_name = string or nil,  -- 立绘
        FrameSymbol = string or nil ,            -- 人物base皮肤的背景

        init_fn = function or nil,      -- 初始化函数
        clear_fn = function or nil,     -- 清理函数

        assets = {} or nil,             -- 皮肤用到的资源 
        skin_tags = {} or nil,          -- 皮肤的tag用于过滤
    }

设置默认皮肤的制作栏贴图
MakeItemSkinDefaultImage(base, atlas, image)    
]]

GLOBAL.AddCharacterSkin = AddCharacterSkin
GLOBAL.AddCharacterAssets = AddCharacterAssets
GLOBAL.AddCollection = AddCollection
GLOBAL.AddSkinnableCharacter = AddSkinnableCharacter
GLOBAL.AddItemSkin = AddItemSkin
GLOBAL.AddItemSkinDefaultImage = AddItemSkinDefaultImage

local CreatePrefabSkin
local recipe_help = true
local thank_help = true

-------------------------------------------------------------------------------------------
---[[人物皮肤]]
-------------------------------------------------------------------------------------------
local characterskins = {}
local FrameSymbol = {}
local skincharacters = {}
local default_release_group = -100
local default_display_order = -1000
local SKIN_AFFINITY_INFO = require("skin_affinity_info")

-- 添加人物皮肤
function AddCharacterSkin(base, skinname, data)
    default_release_group = default_release_group - 1
    default_display_order = default_display_order + 1
    data.type = nil

    -- 标记一下是拥有皮肤的人物
    if not skincharacters[base] then
        skincharacters[base] = true
    end
    characterskins[skinname] = data
    data.base_prefab = base
    data.ischaracterskins = true
    data.rarity = data.rarity or "Loyal"
    data.release_group = data.release_group or default_release_group
    data.display_order = data.display_order or default_display_order
    data.build_name_override = data.build_name_override or skinname
    -- 珍惜度
    if not STRINGS.UI.RARITY[data.rarity] then
        STRINGS.UI.RARITY[data.rarity] = data.rarity
        SKIN_RARITY_COLORS[data.rarity] = data.raritycolor or {0.635, 0.769, 0.435, 1}
        RARITY_ORDER[data.rarity] = data.rarityorder or -default_release_group
        if data.FrameSymbol then
            FrameSymbol[data.rarity] = data.FrameSymbol
        end
    end
    -- 注册到字符串
    if STRINGS.SKIN_NAMES[skinname] == nil then
        STRINGS.SKIN_NAMES[skinname] = data.name or skinname
    end
    if STRINGS.SKIN_DESCRIPTIONS[skinname] == nil then
        STRINGS.SKIN_DESCRIPTIONS[skinname] = data.des or ""
    end
    if STRINGS.SKIN_QUOTES[skinname] == nil then
        STRINGS.SKIN_QUOTES[skinname] = data.quotes or ""
    end
    -- 注册到皮肤列表
    if not PREFAB_SKINS[base] then
        PREFAB_SKINS[base] = {}
    end
    table.insert(PREFAB_SKINS[base], skinname)
    if not SKIN_AFFINITY_INFO[base] then
        SKIN_AFFINITY_INFO[base] = {}
    end
    table.insert(SKIN_AFFINITY_INFO[base], skinname)

    local prefab_skin = CreatePrefabSkin(skinname, data)
    if data.clear_fn then
        prefab_skin.clear_fn = data.clear_fn
    end

    if data.assets then
        for _, v in pairs(data.assets) do
            table.insert(Assets, v)
        end
    end

    prefab_skin.type = "base"
    RegisterPrefabs(prefab_skin)
    TheSim:LoadPrefabs({skinname})
    return prefab_skin
end

-- 添加人物皮肤资源
function AddCharacterAssets(skinname, onlybase)
    local assets = {
        Asset("ANIM", "anim/".. skinname .. ".zip"),
        Asset("ANIM", "anim/ghost_".. skinname .. "_build.zip"),
        Asset("IMAGE", "bigportraits/".. skinname .. ".tex"),
        Asset("ATLAS", "bigportraits/".. skinname .. ".xml"),
        Asset("IMAGE", "bigportraits/".. skinname .. "_none.tex"),
        Asset("ATLAS", "bigportraits/".. skinname .. "_none.xml"),
    }
    if not onlybase then
        table.insert(assets, Asset("IMAGE", "images/map_icons/".. skinname .. ".tex"))
        table.insert(assets, Asset("ATLAS", "images/map_icons/".. skinname .. ".xml"))
        table.insert(assets, Asset("IMAGE", "images/avatars/avatar_" .. skinname .. ".tex"))
        table.insert(assets, Asset("ATLAS", "images/avatars/avatar_" .. skinname .. ".xml"))
        table.insert(assets, Asset("IMAGE", "images/avatars/avatar_ghost_" .. skinname .. ".tex"))
        table.insert(assets, Asset("ATLAS", "images/avatars/avatar_ghost_" .. skinname .. ".xml"))
        table.insert(assets, Asset("IMAGE", "images/avatars/self_inspect_" .. skinname .. ".tex"))
        table.insert(assets, Asset("ATLAS", "images/avatars/self_inspect_" .. skinname .. ".xml"))
        table.insert(assets, Asset("IMAGE", "images/saveslot_portraits/".. skinname .. ".tex"))
        table.insert(assets, Asset("ATLAS", "images/saveslot_portraits/".. skinname .. ".xml"))
        table.insert(assets, Asset("IMAGE", "images/selectscreen_portraits/".. skinname .. ".tex"))
        table.insert(assets, Asset("ATLAS", "images/selectscreen_portraits/".. skinname .. ".xml"))
    end
    return assets
end

-- 添加系列
function AddCollection(collection, des)
    STRINGS.SKIN_TAG_CATEGORIES.COLLECTION[string.upper(collection)] = des or collection
end

-- 注册可用皮肤的角色
function AddSkinnableCharacter(prefab, data)
    -- 注册角色系列
    STRINGS.SKIN_TAG_CATEGORIES.CHARACTER[string.upper(prefab)] = data.character_name_override or STRINGS.CHARACTER_NAMES[prefab]
    -- 注册原皮
    AddCharacterSkin(prefab, prefab.."_base", {
        name = STRINGS.CHARACTER_NAMES[prefab],
        des = STRINGS.CHARACTER_DESCRIPTIONS[prefab],
        quotes = STRINGS.CHARACTER_QUOTES[prefab],

        rarity = data.rarity or "Loyal",
        rarityorder = data.rarityorder or 999999,
        raritycolor = data.raritycolor or {0.635, 0.769, 0.435, 1},
        FrameSymbol = data.FrameSymbol or "common",

        skins = {
            normal_skin = data.normal_skin or prefab,
            ghost_skin = data.ghost_skin or ("ghost_" .. prefab .. "_build")
        },
        share_bigportrait_name = data.share_bigportrait_name or prefab.."_none",
        build_name_override = data.build_name_override or prefab,

        assets = data.assets or AddCharacterAssets(data.assetsname or prefab),
        skin_tags = data.skin_tags,
    })
end

-------------------------------------------------------------------------------------------
---[[物品皮肤]]
-------------------------------------------------------------------------------------------
local itemskins = {}
local itembaseimage = {}

-- 添加物品基础图片
function AddItemSkinDefaultImage(base, atlas, image)
    itembaseimage[base] = {atlas, (image or base) .. ".tex", "default.tex"}
end

-- 添加物品皮肤
function AddItemSkin(base, skinname, data)
    default_release_group = default_release_group - 1
    default_display_order = default_display_order + 1
    data.type = nil
    itemskins[skinname] = data
    data.base_prefab = base
    data.isitemskins = true
    data.rarity = data.rarity or "Loyal"
    data.build_name_override = data.build_name_override or skinname
    data.release_group = data.release_group or default_release_group
    data.display_order = data.display_order or default_display_order
    -- 不存在的珍惜度 自动注册字符串
    if not STRINGS.UI.RARITY[data.rarity] then
        STRINGS.UI.RARITY[data.rarity] = data.rarity
        SKIN_RARITY_COLORS[data.rarity] = data.raritycolor or {0.635, 0.769, 0.435, 1}
        RARITY_ORDER[data.rarity] = data.rarityorder or -default_release_group
        if data.FrameSymbol then
            FrameSymbol[data.rarity] = data.FrameSymbol
        end
    end
    -- 注册到字符串
    if STRINGS.SKIN_NAMES[skinname] == nil then
        STRINGS.SKIN_NAMES[skinname] = data.name or skinname
    end
    if STRINGS.SKIN_DESCRIPTIONS[skinname] == nil then
        STRINGS.SKIN_DESCRIPTIONS[skinname] = data.des or ""
    end
    if data.atlas and data.image then
        RegisterInventoryItemAtlas(data.atlas, data.image .. ".tex")
    end
    -- 注册到皮肤列表
    if not PREFAB_SKINS[base] then
        PREFAB_SKINS[base] = {}
    end
    table.insert(PREFAB_SKINS[base], skinname)
    if not PREFAB_SKINS_IDS[base] then
        PREFAB_SKINS_IDS[base] = {}
    end
    local index = 1
    for k, v in pairs(PREFAB_SKINS_IDS[base]) do
        index = index + 1
    end
    PREFAB_SKINS_IDS[base][skinname] = index
    -- 创建皮肤预制物
    data.skininit_fn = data.init_fn or nil
    data.skinclear_fn = data.clear_fn or nil
    data.init_fn = function(i)
        basic_skininit_fn(i, skinname)
    end
    data.clear_fn = function(i)
        basic_skinclear_fn(i, skinname)
    end
    if data.skinpostfn then
        data.skinpostfn(data)
    end
    local prefab_skin = CreatePrefabSkin(skinname, data)
    if data.clear_fn then
        prefab_skin.clear_fn = data.clear_fn
    end
    if data.atlas and data.image then
        prefab_skin.atlas = data.atlas
        prefab_skin.image = data.image
        prefab_skin.imagename = data.image .. ".tex"
    end
    if data.assets then
        for _, v in pairs(data.assets) do
            table.insert(Assets, v)
        end
    end
    prefab_skin.type = "item"
    RegisterPrefabs(prefab_skin)
    TheSim:LoadPrefabs({skinname})
    return prefab_skin
end

local namemaps = {}

-- 获取皮肤的基础prefab
function GetSkinBase(name)
    return (itemskins[name] and itemskins[name].base_prefab) or (characterskins[name] and characterskins[name].base_prefab) or ""
end

-- 将skinname与base关联
function MakeSkinNameMap(base, skinname)
    namemaps[skinname] = base
end

-- 获取skinname的base
function GetSkinMap(skinname)
    return namemaps[skinname] or skinname
end

-- 获取base的所有skinname
function GetSkinMapByBase(base)
    local r = {
        [base] = 1
    }
    for k, v in pairs(namemaps) do
        if v == base then
            r[k] = 1
        end
    end
    return r
end

-------------------------------------------------------------------------------------------
---[[hook]]
-------------------------------------------------------------------------------------------
-- 是否拥有皮肤
local mt = getmetatable(TheInventory)
local oldTheInventoryCheckOwnership = TheInventory.CheckOwnership
mt.__index.CheckOwnership = function(i, name, ...)
    -- print(i,name,...)
    name = namemaps[name] or name
    if type(name) == "string" and (characterskins[name] or itemskins[name]) then
        if characterskins[name] and characterskins[name].checkfn then
            return characterskins[name].checkfn(i, name, ...)
        elseif itemskins[name] and itemskins[name].checkfn then
            return itemskins[name].checkfn(i, name, ...)
        else
            return true
        end
    else
        return oldTheInventoryCheckOwnership(i, name, ...)
    end
end

-- 是否拥有皮肤 最近时间（新加皮肤默认返回0）
local timelastest = 0
local oldTheInventoryCheckOwnershipGetLatest = TheInventory.CheckOwnershipGetLatest
mt.__index.CheckOwnershipGetLatest = function(i, name, ...)
    -- print(i,name,...)
    name = namemaps[name] or name
    if type(name) == "string" and (characterskins[name] or itemskins[name]) then
        if characterskins[name] and characterskins[name].checkfn then
            return characterskins[name].checkfn(i, name, ...), timelastest
        elseif itemskins[name] and itemskins[name].checkfn then
            return itemskins[name].checkfn(i, name, ...), timelastest
        else
            return true, timelastest
        end
    else
        return oldTheInventoryCheckOwnershipGetLatest(i, name, ...)
    end
end

-- 是否拥有客户端的皮肤
local oldTheInventoryCheckClientOwnership = TheInventory.CheckClientOwnership
mt.__index.CheckClientOwnership = function(i, userid, name, ...)
    name = namemaps[name] or name
    if type(name) == "string" and (characterskins[name] or itemskins[name]) then
        if characterskins[name] and characterskins[name].checkclientfn then
            return characterskins[name].checkclientfn(i, userid, name, ...)
        elseif itemskins[name] and itemskins[name].checkclientfn then
            return itemskins[name].checkclientfn(i, userid, name, ...)
        else
            return true
        end
    else
        return oldTheInventoryCheckClientOwnership(i, userid, name, ...)
    end
end

-- 将新皮肤插入到列表
local oldExceptionArrays = GLOBAL.ExceptionArrays
GLOBAL.ExceptionArrays = function(ta, tb, ...)
    local need
    for i = 1, 100, 1 do
        local data = debug.getinfo(i, "S")
        if data then
            if data.source and data.source:match("^scripts/networking.lua") then
                need = true
            end
        else
            break
        end
    end
    if need then
        local newt = oldExceptionArrays(ta, tb, ...)
        for k, v in pairs(skincharacters) do
            table.insert(newt, k) -- 偷渡
        end
        return newt
    else
        return oldExceptionArrays(ta, tb, ...)
    end
end

-- 判断是否是默认的皮肤，这里如果已经拥有则返回true
local oldIsDefaultCharacterSkin = IsDefaultCharacterSkin
GLOBAL.IsDefaultCharacterSkin = function(item, ...)
    item = item and namemaps[item] or item
    if item and characterskins[item] then
        if characterskins[item].checkfn then
            return characterskins[item].checkfn(nil, item)
        else
            return true
        end
    else
        return oldIsDefaultCharacterSkin(item, ...)
    end
end

-- 获取人物立绘名称
local oldGetPortraitNameForItem = GetPortraitNameForItem
GLOBAL.GetPortraitNameForItem = function(item)
    item = item and namemaps[item] or item
    if item and characterskins[item] and characterskins[item].share_bigportrait_name then
        return characterskins[item].share_bigportrait_name
    end
    return oldGetPortraitNameForItem(item)
end

-- 根据物品的稀有度（rarity）获取相应的框架符号
local oldGetFrameSymbolForRarity = GetFrameSymbolForRarity
GLOBAL.GetFrameSymbolForRarity = function(item)
    item = item and namemaps[item] or item
    return FrameSymbol[item] or oldGetFrameSymbolForRarity(item)
end

-- 骗过皮肤面板，让他以为我们是官方人物
AddClassPostConstruct("widgets/widget", function(self)
    if self.name == "LoadoutSelect" then
        for k, v in pairs(skincharacters) do
            if not table.contains(DST_CHARACTERLIST, k) then
                table.insert(DST_CHARACTERLIST, k)
            end
        end
    elseif self.name == "LoadoutRoot" then
        for k, v in pairs(skincharacters) do
            if table.contains(DST_CHARACTERLIST, k) then
                RemoveByValue(DST_CHARACTERLIST, k)
            end
        end
    end
end)

-- 强制更改为在线模式
AddSimPostInit(function()
    if not TheNet:IsOnlineMode() then
        local net = getmetatable(GLOBAL.TheNet)
        net.__index.IsOnlineMode = function(n, ...)
            return true
        end
    end
end)

-- 人物皮肤的init_fn 和 clear_fn
AddComponentPostInit("skinner", function(self)
    local oldfn = self.SetSkinName
    if oldfn then
        function self.SetSkinName(s, skinname, ...)
            local old = s.skin_name
            local new = skinname
            if characterskins[old] and characterskins[old].clear_fn then
                characterskins[old].clear_fn(s.inst, old)
            end
            if characterskins[new] and characterskins[new].init_fn then
                characterskins[new].init_fn(s.inst, new)
            end
            oldfn(s, skinname, ...)
        end
    end
end)

-- 制作栏添加物品皮肤
AddClassPostConstruct("widgets/recipepopup", function(self)
    local oldGetSkinOptions = self.GetSkinOptions
    function self:GetSkinOptions(s, ...)
        local ret = oldGetSkinOptions(s, ...)
        if ret then
            if ret[1] and ret[1].image then
                if s.recipe and s.recipe.product and itembaseimage[s.recipe.product] then -- 存在则覆盖
                    ret[1].image = itembaseimage[s.recipe.product]
                end
            end
            for k, v in pairs(s.skins_list) do
                if ret[k + 1] and ret[k + 1].image and v and v.item and itemskins[v.item] and
                    (itemskins[v.item].atlas or itemskins[v.item].image) then

                    local image = itemskins[v.item].image or v.item .. ".tex"
                    if image:sub(-4) ~= ".tex" then
                        image = image .. ".tex"
                    end
                    local atlas = itemskins[v.item].atlas or GetInventoryItemAtlas(image)
                    ret[k + 1].image = {atlas, image, "default.tex"}

                end
            end
        end
        return ret
    end
end)

-- 制作栏添加物品皮肤
local skinselector = require("widgets/redux/craftingmenu_skinselector")
function hookskinselector(self)
    local oldfn = self.GetSkinOptions
    function self.GetSkinOptions(s, ...)
        local ret = oldfn(s, ...)
        if ret then
            if ret[1] and ret[1].image then
                if s.recipe and s.recipe.product and itembaseimage[s.recipe.product] then -- 存在则覆盖
                    ret[1].image = itembaseimage[s.recipe.product]
                end
            end
            for k, v in pairs(s.skins_list) do
                if ret[k + 1] and ret[k + 1].image and v and v.item and itemskins[v.item] and
                    (itemskins[v.item].atlas or itemskins[v.item].image) then
                    local image = itemskins[v.item].image or v.item .. ".tex"
                    if image:sub(-4) ~= ".tex" then
                        image = image .. ".tex"
                    end
                    local atlas = itemskins[v.item].atlas or GetInventoryItemAtlas(image)
                    ret[k + 1].image = {atlas, image, "default.tex"}

                end
            end
        end
        return ret
    end
end
hookskinselector(skinselector)

-- 获取物品皮肤图标名称
local oldGetSkinInvIconName = GetSkinInvIconName
GLOBAL.GetSkinInvIconName = function(item, ...)
    if itemskins[item] and itemskins[item].image then
        local image = itemskins[item].image
        if image:sub(-4) == ".tex" then
            image = image:sub(1, -5)
        end
        return image
    end
    return oldGetSkinInvIconName(item, ...)
end

-- 这是全局函数 所以可以放后面 在执行前定义好就行
function basic_skininit_fn(inst, skinname)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end
    local data = itemskins[skinname]
    if not data then
        return
    end
    if data.bank then
        inst.AnimState:SetBank(data.bank)
    end
    inst.AnimState:SetBuild(data.build or skinname)
    if data.anim then
        inst.AnimState:PlayAnimation(data.anim,data.animloop or nil)
    end
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem.atlasname = data.atlas or ("images/inventoryimages/" .. skinname .. ".xml")
        inst.components.inventoryitem:ChangeImageName(data.image or skinname)
    end
    if data.skininit_fn then
        data.skininit_fn(inst, skinname)
    end
end

function basic_skinclear_fn(inst, skinname) -- 默认认为 build 和prefab同名 不对的话自己改
    local prefab = inst.prefab or ""
    local data = itemskins[skinname]
    if not data then
        return
    end
    if data.basebank then
        inst.AnimState:SetBank(data.basebank)
    end
    if data.baseanim then
        inst.AnimState:PlayAnimation(data.baseanim,data.baseanimloop or nil)
    end
    inst.AnimState:SetBuild(data.basebuild or prefab)
    if inst.components.inventoryitem ~= nil then
        if itembaseimage[prefab] then 
            inst.components.inventoryitem.atlasname = itembaseimage[prefab][1]
            local name = itembaseimage[prefab][2]:gsub("%.tex","")
            inst.components.inventoryitem:ChangeImageName(name)
        else
            inst.components.inventoryitem.atlasname = GetInventoryItemAtlas(prefab .. ".tex")
            inst.components.inventoryitem:ChangeImageName(prefab)
        end
    end
    if itemskins[skinname].skinclear_fn then
        itemskins[skinname].skinclear_fn(inst, skinname)
    end
end

local oldSpawnPrefab = SpawnPrefab
GLOBAL.SpawnPrefab = function(prefab, skin, skinid, userid, ...)
    if itemskins[skin] then
        skinid = 0
    end
    return oldSpawnPrefab(prefab, skin, skinid, userid, ...)
end

local oldReskinEntity = Sim.ReskinEntity
Sim.ReskinEntity = function(sim, guid, oldskin, newskin, skinid, userid, ...)
    local inst = Ents[guid]
    if oldskin and itemskins[oldskin] then
        itemskins[oldskin].clear_fn(inst) -- 清除旧皮肤的
    end
    local r = oldReskinEntity(sim, guid, oldskin, newskin, skinid, userid, ...)
    if newskin and itemskins[newskin] then

        itemskins[newskin].init_fn(inst)
        inst.skinname = newskin
        inst.skin_id = 0
    end
    return r
end

function GetSkin(name)
    return characterskins[name] or itemskins[name] or nil
end

function GetAllSkin()
    return characterskins, itemskins
end

if recipe_help then
    AddSimPostInit(function()
        for k, v in pairs(AllRecipes) do
            if v.product ~= v.name and PREFAB_SKINS[v.product] then
                PREFAB_SKINS[v.name] = PREFAB_SKINS[v.product]
                PREFAB_SKINS_IDS[v.name] = PREFAB_SKINS_IDS[v.product]
            end
        end
    end)
end

if thank_help then
    local ThankYouPopup = require "screens/thankyoupopup"
    local tohook = {
        OpenGift = 1,
        ChangeGift = 1
    }
    for k, v in pairs(tohook) do
        tohook[k] = ThankYouPopup[k]
        ThankYouPopup[k] = function(self, ...)

            local r = tohook[k](self, ...)

            local item = self.current_item and self.items and self.items[self.current_item] and
                                self.items[self.current_item].item
            if item then
                local skin = GetSkin(item)
                if skin and skin.swap_icon then
                    self.spawn_portal:GetAnimState():OverrideSkinSymbol("SWAP_ICON", skin.swap_icon.build,
                        skin.swap_icon.image)
                elseif skin and skin.image and skin.atlas then
                    self.spawn_portal:GetAnimState():OverrideSkinSymbol("SWAP_ICON", softresolvefilepath(skin.atlas),
                        skin.image .. ".tex")
                end
            end

            return r
        end
    end
end

local oldCreatePrefabSkin = GLOBAL.CreatePrefabSkin
local fninfo = debug.getinfo(oldCreatePrefabSkin)
if fninfo and fninfo.source and not fninfo.source:match("scripts/prefabskin%.lua") then
    function CreatePrefabSkin(name, info)
        local prefab_skin = Prefab(name, nil, info.assets, info.prefabs)
        prefab_skin.is_skin = true
        -- Hack to deal with mods with bad data. Type is now required, and who knows how many character mods are missing this field.
        if info.type == nil then
            info.type = "base"
        end
        prefab_skin.base_prefab = info.base_prefab
        prefab_skin.type = info.type
        prefab_skin.skin_tags = info.skin_tags
        prefab_skin.init_fn = info.init_fn
        prefab_skin.build_name_override = info.build_name_override
        prefab_skin.bigportrait = info.bigportrait
        prefab_skin.rarity = info.rarity
        prefab_skin.rarity_modifier = info.rarity_modifier
        prefab_skin.skins = info.skins
        prefab_skin.skin_sound = info.skin_sound
        prefab_skin.is_restricted = info.is_restricted
        prefab_skin.granted_items = info.granted_items
        prefab_skin.marketable = info.marketable
        prefab_skin.release_group = info.release_group or default_release_group
        prefab_skin.linked_beard = info.linked_beard
        prefab_skin.share_bigportrait_name = info.share_bigportrait_name
        if info.torso_tuck_builds ~= nil then
            for _, base_skin in pairs(info.torso_tuck_builds) do
                BASE_TORSO_TUCK[base_skin] = "full"
            end
        end
        if info.torso_untuck_builds ~= nil then
            for _, base_skin in pairs(info.torso_untuck_builds) do
                BASE_TORSO_TUCK[base_skin] = "untucked"
            end
        end
        if info.torso_untuck_wide_builds ~= nil then
            for _, base_skin in pairs(info.torso_untuck_wide_builds) do
                BASE_TORSO_TUCK[base_skin] = "untucked_wide"
            end
        end
        if info.has_alternate_for_body ~= nil then
            for _, base_skin in pairs(info.has_alternate_for_body) do
                BASE_ALTERNATE_FOR_BODY[base_skin] = true
            end
        end
        if info.has_alternate_for_skirt ~= nil then
            for _, base_skin in pairs(info.has_alternate_for_skirt) do
                BASE_ALTERNATE_FOR_SKIRT[base_skin] = true
            end
        end
        if info.one_piece_skirt_builds ~= nil then
            for _, base_skin in pairs(info.one_piece_skirt_builds) do
                ONE_PIECE_SKIRT[base_skin] = true
            end
        end
        if info.legs_cuff_size ~= nil then
            for base_skin, size in pairs(info.legs_cuff_size) do
                BASE_LEGS_SIZE[base_skin] = size
            end
        end
        if info.feet_cuff_size ~= nil then
            for base_skin, size in pairs(info.feet_cuff_size) do
                BASE_FEET_SIZE[base_skin] = size
            end
        end
        if info.skin_sound ~= nil then
            SKIN_SOUND_FX[name] = info.skin_sound
        end
        if info.fx_prefab ~= nil then
            SKIN_FX_PREFAB[name] = info.fx_prefab
        end
        if info.type ~= "base" then
            prefab_skin.clear_fn = _G[prefab_skin.base_prefab .. "_clear_fn"]
        end
        return prefab_skin
    end
else
    CreatePrefabSkin = oldCreatePrefabSkin
end