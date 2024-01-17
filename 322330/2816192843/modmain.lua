GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})
modimport("scripts/apis.lua")
utils.mod("skinqueue")
local MYMODNAME = "SEESPOOLS"
if RegisterMod(MYMODNAME) then
  print("duplicate spool mod detected")
  return
end
local spinner = nil
local spinner2 = nil
local enableprint = GetConfig("enableprint") == "true"
local translation = {
  chinese = {
    "金额",
    "线轴",
    "拆线性价比",
    "线轴价值比",
    "发布时间",
    "线轴",
    "线轴价值比",
    "金额"
  },
  english = {
    "Currency",
    "Spools",
    "Unravelled Per Unit",
    "Spools Per Unit",
    "Release",
    "Spools",
    "Spools Per Unit",
    "Currency"
  }
}
local opt = {}
local opt2 = {}
local translate = translation.english
local see = "See:"
local sort = "Sort:"
local lang = GetLanguageName()
if lang == "chinese" then
  see = "看:"
  sort = "排序:"
  translate = translation.chinese
end
for i, v in ipairs(translate) do
  if i <= 4 then
    opt[i] = {text = v, data = i - 1}
  else
    opt2[i - 4] = {text = v, data = i - 4 - 1}
  end
end
--[[
PurchaseWidget
	K: 	IsFullyInView	 V: 	function: 00000000172C07B0
	K: 	OnGainFocus	 V: 	function: 000000002AF96770
	K: 	button	 V: 	Buy Now
	K: 	callbacks	 V: 	table: 000000002AF8CE00
	K: 	can_fade_alpha	 V: 	true
	K: 	children	 V: 	table: 000000002AF8DAD0
	K: 	collection	 V: 	Text - Rose Collection
	K: 	enabled	 V: 	true
	K: 	expire_txt	 V: 	Text - Offer expires in 3 days!
	K: 	focus	 V: 	false
	K: 	focus_flow	 V: 	table: 0000000031C2B6E0
	K: 	focus_flow_args	 V: 	table: 0000000031C2BFA0
	K: 	focus_forward	 V: 	Buy Now
	K: 	focus_target	 V: 	false
	K: 	frame	 V: 	Image - images/fepanels_redux.xml:shop_panel.tex
	K: 	iap_def	 V: 	table: 0000000036CDC8C0
	K: 	icon_anim	 V: 	UIAnim
	K: 	icon_glow	 V: 	Image - images/global_redux.xml:shop_glow.tex
	K: 	icon_glow2	 V: 	Image - images/global_redux.xml:shop_glow.tex
	K: 	icon_image	 V: 	Image - bigportraits/wx78_rose.xml:wx78_rose_oval.tex
	K: 	icon_root	 V: 	icon_root
	K: 	info_button	 V: 	?
	K: 	inst	 V: 	101044 -
	K: 	name	 V: 	PurchaseWidget
	K: 	next_in_tab_order	 V: 	PurchaseWidget
	K: 	oldprice	 V: 	Text - CNY 6
	K: 	oldprice_line	 V: 	Image - images/global_redux.xml:shop_crossed_price.tex
	K: 	parent	 V: 	GRID
	K: 	price	 V: 	Text - CNY 6
	K: 	purchased	 V: 	Image - images/global_redux.xml:shop_checkmark.tex
	K: 	root	 V: 	purchase_dialog_root
	K: 	sale_frame	 V: 	Image - images/global_redux.xml:shop_sale_tag.tex
	K: 	sale_percent	 V: 	0
	K: 	sale_txt	 V: 	Text - -33% Sale!
	K: 	savings	 V: 	Text - -81%
	K: 	savings_frame	 V: 	Image - images/global_redux.xml:shop_discount.tex
	K: 	screen_self	 V: 	PurchasePackScreen
	K: 	shown	 V: 	true
	K: 	text	 V: 	Text - Includes 2 Wardrobe skins!
	K: 	text_root	 V: 	text_root
	K: 	title	 V: 	Text - WX-78 Roseate Chest
]]
--[[
pack_hallowed_wormwood =
{
    type = "purchase",
    skin_tags = { },
    display_order = 114,
    build_name_override = "wormwood_pumpkin",
    display_atlas = "bigportraits/wormwood_pumpkin.xml",
    display_tex = "wormwood_pumpkin_oval.tex",
    box_build = "box_shop_hallowed",
    display_items = {  "wormwood_pumpkin", "body_wormwood_pumpkin", "hand_wormwood_pumpkin", "legs_wormwood_pumpkin", },
    output_items = {  "wormwood_pumpkin", "body_wormwood_pumpkin", "hand_wormwood_pumpkin", "legs_wormwood_pumpkin", },
    release_group = 106,
},
]]
local function GetSpoolPrice(name)
  if not MISC_ITEMS[name] then
    CONSOLE.err(name, "is not a misc item")
    return 0
  end
  if MISC_ITEMS[name].type ~= "purchase" then
    CONSOLE.err(name, "is not a purchasable misc item")
    return 0
  end
  local items = MISC_ITEMS[name].output_items
  local spools = 0
  for i, v in ipairs(items) do
    local data = GetSkinData(v)
    if data then
      -- if table.has({"Woven", "CharacterModifier"}, data.rarity_modifier) then
      local thisspool = TheItems:GetBarterSellPrice(v)
      if enableprint then CONSOLE.log(v, "worths", thisspool, "spools") end
      spools = spools + thisspool
      -- end
    end
  end
  return spools
end
local function GetPerSpool(price, spools) return math.floor(spools / price) end
local OldBuildPriceStr = BuildPriceStr
local function NewBuildPrice(value, iap_def, sale_active, ...)
  local ret = OldBuildPriceStr(value, iap_def, sale_active, ...)
  if spinner then
    local data = spinner:GetSelectedData()
    if type(value) ~= "number" then value = iap_def.value or GetPriceFromIAPDef(value, sale_active) end
    value = value / 100
    local spools = iap_def.spools or GetSpoolPrice(iap_def.item_type)
    local per_spool = GetPerSpool(value, spools)
    if enableprint then
      CONSOLE.log(iap_def.item_type, " spools: " .. spools .. " per_spool: " .. per_spool .. " value: " .. value)
    end
    local str_per = string.format("PER %d", per_spool)
    local str_ravel = string.format("PER %d", per_spool * 3) -- assume 3x
    local str_spool = string.format("SP %d", spools * 3) -- again assume 3x
    if data == 0 then
      return ret
    elseif data == 1 then
      return str_spool
    elseif data == 2 then
      return str_per
    elseif data == 3 then
      return str_ravel
    end
  end
  return ret
end
GLOBAL.BuildPriceStr = NewBuildPrice
local function ModifyItem(self)
  if self.price and "SPOOL " ~= string.sub(self.price:GetString(), 1, 6) then
    local price = string.gmatch(self.price:GetString(), "%d+")()
    if price then price = tonumber(price) end
    local spools = GetSpoolPrice(self.iap_def.item_type) or ""
    local perspool = ""
    if type(spools) == "number" then perspool = GetPerSpool(price, spools) end
    CONSOLE.log(string.format("%s: %s (%s)", self.iap_def.item_type, price, perspool))
    self.price:SetString("SPOOL " .. spools .. "/" .. perspool)
  end
end
local pc = nil
local sortfns = {
  function(a, b)
    if MISC_ITEMS[a.item_type].release_group == MISC_ITEMS[b.item_type].release_group then
      return MISC_ITEMS[a.item_type].display_order < MISC_ITEMS[b.item_type].display_order
    else
      return MISC_ITEMS[a.item_type].release_group > MISC_ITEMS[b.item_type].release_group
    end
  end,
  function(a, b) return a.spools > b.spools end,
  function(a, b)
    if a.value == 0 then return false end
    if b.value == 0 then return true end
    return a.spools / a.value > b.spools / b.value
  end,
  function(a, b) return a.value > b.value end
}
local NewSortFn = function(mode)
  if mode == nil then
    if spinner2 then
      mode = spinner2:GetSelectedData()
    else
      mode = 0
    end
  end
  return sortfns[mode + 1]
end
local OldGetIAPDEF = nil
local function NewGetIAPDEF(...)
  local iap_defs = OldGetIAPDEF(...)
  for k, v in pairs(iap_defs) do
    if not v.value then v.value = GetPriceFromIAPDef(v, IsSaleActive(v)) end
    if not v.spools then v.spools = GetSpoolPrice(v.item_type) end
  end
  table.sort(iap_defs, NewSortFn())
  return iap_defs
end
local HackSortFn = function(self)
  if not self then self = pc end
  if not self then return end
  if not OldGetIAPDEF then OldGetIAPDEF = self.GetIAPDefs end
  self.GetIAPDefs = NewGetIAPDEF
end
local function fn(self)
  pc = self
  if not self.filters then return end
  if #self.filters == 0 then return end
  self.filters[#self.filters + 1] = self:_CreateSpinnerFilter("SEE", see, opt)
  local sp = self.filters[#self.filters]
  spinner = sp.spinner
  local _1, height = UPVALUE.fetch(self._BuildPurchasePanel, "height")
  height = height or 30
  local _2, spacing = UPVALUE.fetch(self._BuildPurchasePanel, "spacing")
  spacing = spacing or 3
  sp:SetPosition(0, (#self.filters) * -(height + spacing), 0)
  self.filters[#self.filters + 1] = self:_CreateSpinnerFilter("SORT", sort, opt2)
  local st = self.filters[#self.filters]
  spinner2 = st.spinner
  st:SetPosition(0, (#self.filters) * -(height + spacing), 0)
  -- spinner:SetOnChangedFn()
  if self.sales_btn then
    local pos = self.sales_btn:GetPosition()
    local x, y, z = pos.x, pos.y, pos.z
    local delta = (height + spacing) * 2
    self.sales_btn:SetPosition(x, y - delta, z)
  end
  HackSortFn(self)
end
utils.class("screens/redux/purchasepackscreen", fn)
if GetConfig("showhidden") == "true" then
  function GLOBAL.ShouldDisplayItemInCollection(item_type)
    if ITEM_DISPLAY_BLACKLIST[item_type] then return false end
    --[[
    local rarity = safeget(_G, "rarity")
    if rarity then
      rarity = rarity:upper()
      local rarity2 = GetRarityForItem(item_type):upper()
      return rarity == rarity2
    end
    ]]
    --[[
        local rarity = GetRarityForItem(item_type)
        if rarity == "Event" or rarity == "ProofOfPurchase" or rarity == "Loyal" or rarity == "Timeless" then
            return TheInventory:CheckOwnership(item_type)
        end
        ]]
    return true
  end
end
if GetConfig("showall") == "true" then function GLOBAL.IsDefaultSkinOwned() return true end end
if GetConfig("showhidden") == "true" then MapDict(MISC_ITEMS, function(k, v) v.display_items = v.output_items end) end
utils.class("screens/redux/itemboxopenerpopup", function(self)
  function self:CanExit() return true end
  if not self.back_button then
    local TEMPLATES = require "widgets/redux/templates"
    self.back_button = self.center_root:AddChild(TEMPLATES.BackButton(function() self:_TryClose() end))
  end
end)
