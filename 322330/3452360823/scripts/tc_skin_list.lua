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
        skin_tags = {} or nil,          -- 皮肤的tag,用于区分系列
    }

设置默认皮肤的制作栏贴图
MakeItemSkinDefaultImage(base, atlas, image)    
]]

-------------------------------------------------------------------------------------------
---[[物品]]
-------------------------------------------------------------------------------------------
-- 黑色铜钱面罩
AddItemSkinDefaultImage("tc_chest", "images/inventoryimages/tc_chest.xml", "tc_chest")
AddItemSkin("tc_chest", "tc_chest_moon", {
    name = "月亮",
    des = "",

    rarity = "月亮",
    rarityorder = 1,
    raritycolor = {1, 228/255, 196/255, 1},

    atlas = "images/inventoryimages/tc_chest_moon.xml",
    image = "tc_chest_moon",
    build = "tc_chest_moon",
    bank = "tc_chest_moon",

    basebuild = "tc_chest",
    basebank = "tc_chest",

    skintags = {"chest"},
    assets = {
        Asset("ANIM", "anim/tc_chest_moon.zip"),
        Asset("ANIM", "anim/tc_chest_moon_yellow.zip"),
        Asset("ATLAS", "images/inventoryimages/tc_chest_moon.xml"),
        Asset("IMAGE", "images/inventoryimages/tc_chest_moon.tex"),
    }
})