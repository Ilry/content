if rawget(_G, "sq_stop") then return end
-- fix itemexplorer
local ItemExplorer = require("widgets/redux/itemexplorer")
local old__LaunchCommerce = ItemExplorer and ItemExplorer._LaunchCommerce
if old__LaunchCommerce then
  function ItemExplorer:_LaunchCommerce(...)
    if self.launched_commerce then
      print("Already launched commerce before?")
      self.launched_commerce = nil
    end
    return old__LaunchCommerce(self, ...)
  end
end
local strings = {}
local strings_en = {
  "Filter Marketable",
  "Skin Queue",
  " for ",
  " etr",
  "%) items",
  " for ",
  " next",
  "Buying ",
  "Selling ",
  "DupesPopup",
  " Duplicates",
  "Unravel All",
  "DuplicateItem",
  "doodad",
  "spool",
  "Duplicates",
  " Spools",
  " spools",
  "WARNING: THIS IS YOUR LAST ONE\n\n",
  "You have no ",
  " left to unravel.\n\nPlease wait for the queue to finish.",
  "Unravel All Duplicates",
  "ERROR: You don't own ",
  "ERROR: You don't have any ",
  "left to sell",
  "ERROR: You can't unravel ",
  "for any spools",
  "Queued ",
  " to be sold for ",
  "spools",
  "ERROR: You can't buy ",
  "Queued ",
  " to be bought for ",
  "Stopped queue",
  "Finished queue",
  "ERROR: Bartering away unowned item.",
  "SUCCESS: Sold ",
  "ERROR: Failed to sell ",
  "ERROR: Failed to contact the item server. status=",
  "SUCCESS: Bought ",
  "ERROR: Failed to buy ",
  "You don't have any dupes"
}
local strings_zh = {
  "过滤可交易物品",
  "皮肤队列",
  "换取",
  "后完成",
  "%)个物品",
  "换取",
  "下一个",
  "购买",
  "出售",
  "重复物品弹窗",
  "重复物品",
  "全部拆解",
  "重复的物品",
  "小装饰品/道具",
  "线轴",
  "重复物品项",
  "线轴",
  "线轴",
  "警告：这是你最后一个\n\n ",
  "你没有任何",
  "要拆解的了。\n\n请等待队列完成。",
  "全部拆解重复物品",
  "错误：你未拥有该物品",
  "错误：您没有任何",
  "出售",
  "错误：你不能拆解",
  "以拆解",
  "已排队出售",
  "以换取",
  "线轴",
  "错误：无法购买",
  "已排队购买",
  "以换取",
  "停止队列。",
  "完成队列。",
  "错误：交易未持有的物品。",
  "成功卖掉",
  "错误：无法卖掉",
  "错误：无法连接到服务器。状态码=",
  "成功购买",
  "错误：无法购买",
  "您没有任何重复物品"
}
local code = GetLanguageCode()
local stringlist = strings_en
if code == "zh" then stringlist = strings_zh end
for i, v in ipairs(strings_en) do strings[v] = stringlist[i] end
setmetatable(strings, {__index = function(t, k) return k end})
local verbose = GetModConfigData("verbose")
local minprice = GetModConfigData("minprice") or 30
local mincount = GetModConfigData("mincount") or 1
local function printd(...) return verbose and print(strings["Skin Queue"], ...) end
local HUD = {timetaken = 0}
local DupesPopup = {}
local Queuer = {queue = {}, itemQueueCount = {}, count = 1, timetaken = 0}
local DupeSeller = {}
local Text = require("widgets/text")
local Widget = require("widgets/widget")
local Screen = require("widgets/screen")
local ItemImage = require("widgets/redux/itemimage")
local UIAnim = require("widgets/uianim")
local BarterScreen = require("screens/redux/barterscreen")
local PlayerSummaryScreen = require("screens/redux/playersummaryscreen")
local PopupDialog = require("screens/redux/popupdialog")
local TEMPLATES = require("widgets/redux/templates")
local marketable_sell = false
HUD.create = function(parent)
  local self = Text(DEFAULTFONT, 20, nil, UICOLOURS.WHITE)
  self.inst:AddTag("NOCLICK")
  self.inst.persists = false
  parent:AddChild(self)
  self:MoveToFront()
  self:SetVAnchor(ANCHOR_TOP)
  self:SetHAnchor(ANCHOR_RIGHT)
  self:SetHAlign(ANCHOR_RIGHT)
  local SetString_Old = self.SetString or (function() end)
  self.SetString = function(self, ...)
    SetString_Old(self, ...)
    local w, h = self:GetRegionSize()
    self:SetPosition(-w / 2 - 5, -h / 2 - 5)
  end
  return self
end
HUD.onQueueUpdate = function(timetaken)
  if #Queuer.queue <= 0 then
    HUD.text:SetString("")
    HUD.timetaken = 0
    return
  end
  local lines = {}
  local current = Queuer.queue[Queuer.count]
  local nextkey = Queuer.queue[Queuer.count + 1] and Queuer.queue[Queuer.count + 1].key
  if current then
    lines[#lines + 1] = (current.buy and strings["Buying "] or strings["Selling "]) .. current.key .. strings[" for "]
                          .. current.val .. strings[" spools..."]
  end
  if nextkey then lines[#lines + 1] = nextkey .. strings[" next"] end
  lines[#lines + 1] = Queuer.count .. "/" .. #Queuer.queue .. " ("
                        .. math.floor(100 * (Queuer.count / #Queuer.queue) + 0.5) .. strings["%) items"]
  if timetaken then HUD.timetaken = timetaken end
  if HUD.timetaken > 0 then
    lines[#lines + 1] = HUD.getETR(HUD.timetaken * (#Queuer.queue - (Queuer.count - 1))) .. strings[" etr"]
  end
  HUD.text:SetString(table.concat(lines, "\n"))
end
HUD.getETR = function(x)
  local secs = math.max(0, math.ceil(x / 30))
  if secs >= 3600 then
    return os.date("!%X", secs)
  elseif secs > 86400 then
    return math.floor(secs / 3600) .. ":" .. os.date("!%M:%S", secs)
  end
  return os.date("!%M:%S", secs)
end
HUD.timerTask = scheduler:ExecutePeriodic(1 / 15,
  function() if TheFrontEnd ~= nil then HUD.onFindFrontEnd(TheFrontEnd) end end)
HUD.onFindFrontEnd = function(fe)
  if not fe then return end
  if HUD.timerTask ~= nil then
    HUD.timerTask:Cancel()
    HUD.timerTask = nil
  end
  HUD.text = HUD.create(TheFrontEnd.overlayroot)
end
DupesPopup.create = function(duplicates)
  local self = Screen(strings["DupesPopup"])
  self:SetVAnchor(ANCHOR_MIDDLE)
  self:SetHAnchor(ANCHOR_MIDDLE)
  self:SetScaleMode(SCALEMODE_PROPORTIONAL)
  self.dupes = duplicates or DupeSeller.getAllDupes()
  self.bg = self:AddChild(TEMPLATES.BackgroundTint())
  if not TheInput:ControllerAttached() then
    self.back_button = self:AddChild(TEMPLATES.BackButton(function() self:Close() end))
  end
  self.title = self:AddChild(Text(HEADERFONT, 28, #self.dupes .. strings[" Duplicates"], UICOLOURS.GOLD_SELECTED))
  self.title:SetPosition(0, 222)
  self.dialog = self:AddChild(TEMPLATES.RectangleWindow(736, 406))
  local r, g, b = unpack(UICOLOURS.BROWN_DARK)
  self.dialog:SetBackgroundTint(r, g, b, 0.8)
  self.dialog:SetPosition(0, -5)
  self.dialog.top:Hide()
  self.button = self:AddChild(TEMPLATES.StandardButton(function() self:Accept() end, strings["Unravel All"], {200, 60}))
  self.button2 = self:AddChild(TEMPLATES.StandardButton(function()
    marketable_sell = not marketable_sell
    self:Close()
  end, strings["Filter Marketable"], {200, 60}))
  self.button2:SetPosition(90, -240)
  self.button:SetPosition(290, -240)
  self.total = self:AddChild(Text(HEADERFONT, 28, nil, UICOLOURS.GOLD_SELECTED))
  self.total:SetString(TheInventory:GetCurrencyAmount() .. " + " .. DupeSeller.getDupesTotalWorth(self.dupes) .. " = "
                         .. TheInventory:GetCurrencyAmount() + DupeSeller.getDupesTotalWorth(self.dupes)
                         .. strings[" Spools"])
  local w, h = self.total:GetRegionSize()
  self.total:SetPosition(w / 2 - 380, -245)
  self.grid = self:AddChild(DupesPopup.buildGrid(self))
  self.grid:SetPosition(-10, -4.5)
  self.grid.end_offset = 1
  self.grid._GetScrollAmountPerRow = function(self) return 1 end
  self.grid:SetItemsData(self.dupes)
  self.default_focus = self.button
  self.button:SetFocusChangeDir(MOVE_UP, self.grid)
  self.grid:SetFocusChangeDir(MOVE_DOWN, self.button)
  self.grid:SetFocusChangeDir(MOVE_LEFT, self.button)
  self.grid:SetFocusChangeDir(MOVE_RIGHT, self.button)
  self.OnControl = function(self, control, down)
    if self._base.OnControl(self, control, down) then return true end
    if not down and control == CONTROL_CANCEL then
      self:Close()
      return true
    end
  end
  self.Accept = function(self)
    DupeSeller.sellAllDupes(self.dupes)
    self:Close()
  end
  self.Close = function(self) TheFrontEnd:PopScreen() end
  return self
end
DupesPopup.buildGrid = function(self)
  local function scrollWidgetCtorFn(context, index)
    local w = Widget(strings["DuplicateItem"])
    w.backing = w:AddChild(TEMPLATES.ListItemBackground(235, 120, function() end))
    w.backing:SetPosition(#self.dupes > 9 and -6 or 6, 0)
    w.backing.move_on_click = true
    w.item = w.backing:AddChild(ItemImage(context.user_profile, context.screen))
    w.item:Disable()
    w.item:SetPosition(-55, 0)
    w.item:ScaleToSize(90)
    w.item.warn_marker:Hide()
    w.name = w.backing:AddChild(Text(HEADERFONT, 20, nil, UICOLOURS.GOLD_SELECTED))
    w.doodad = w.backing:AddChild(Widget(strings["doodad"]))
    w.doodad:SetScale(0.2, 0.16)
    w.doodad:SetPosition(20, -24)
    w.doodad.shadow = w.doodad:AddChild(UIAnim())
    w.doodad.shadow.inst.AnimState:SetBank("spool")
    w.doodad.shadow.inst.AnimState:SetBuild("spool")
    w.doodad.shadow.inst.AnimState:PlayAnimation("idle", true)
    w.doodad.shadow.inst.AnimState:SetMultColour(0, 0, 0, 1)
    w.doodad.shadow:SetScale(1.05)
    w.doodad.front = w.doodad:AddChild(UIAnim())
    w.doodad.front.inst.AnimState:SetBank("spool")
    w.doodad.front.inst.AnimState:SetBuild("spool")
    w.doodad.front.inst.AnimState:PlayAnimation("idle", true)
    w.value = w.backing:AddChild(Text(CHATFONT_OUTLINE, 20, nil, UICOLOURS.WHITE))
    w.focus_forward = w.backing
    w.ongainfocusfn = function() self.grid:OnWidgetFocus(w) end
    return w
  end
  local function scrollWidgetApplyFn(context, widget, data, index)
    if not data then
      widget.backing:Hide()
      widget:Disable()
      return
    end
    widget.item:SetItem(GetTypeForItem(data), data)
    widget.name:SetMultilineTruncatedString(GetSkinName(data), 2, 110)
    widget.name:SetPosition(48, 18)
    widget.value:SetString("×" .. TheItems:GetBarterSellPrice(data))
    local w, h = widget.value:GetRegionSize()
    widget.value:SetPosition(38 + w / 2, -28)
    widget.backing:SetOnClick(function() DupesPopup.onClickWidget(self, data, widget) end)
    widget.backing:Show()
    widget:Enable()
  end
  return TEMPLATES.ScrollingGrid({}, {
    context = {},
    item_ctor_fn = scrollWidgetCtorFn,
    apply_fn = scrollWidgetApplyFn,
    widget_width = 245,
    widget_height = 130,
    num_visible_rows = 3,
    num_columns = 3,
    scrollbar_offset = 0,
    scrollbar_height_offset = -70,
    scroll_per_click = 0.5,
    scissor_pad = 16,
    peek_percent = 0,
    allow_bottom_empty_row = true
  })
end
DupesPopup.onClickWidget = function(self, key, widget)
  for i = 1, #self.dupes do
    if self.dupes[i] == key then
      table.remove(self.dupes, i)
      break
    end
  end
  self.grid:SetItemsData(self.dupes)
  self.title:SetString(#self.dupes .. strings[" Duplicates"])
  if #self.dupes <= 0 then
    self.total:SetString("")
    self.button:Disable()
  else
    self.total:SetString(TheInventory:GetCurrencyAmount() .. " + " .. DupeSeller.getDupesTotalWorth(self.dupes) .. " = "
                           .. TheInventory:GetCurrencyAmount() + DupeSeller.getDupesTotalWorth(self.dupes)
                           .. strings[" Spools"])
    local w, h = self.total:GetRegionSize()
    self.total:SetPosition(w / 2 - 380, -245)
  end
end
local BuildDialog_Old = BarterScreen._BuildDialog or (function() end)
BarterScreen._BuildDialog = function(self, ...)
  local currencyAmount = TheInventory:GetCurrencyAmount()
  local GetCurrencyAmount_Old = getmetatable(TheInventory).__index.GetCurrencyAmount
  getmetatable(TheInventory).__index.GetCurrencyAmount = function() return Queuer.getCurrencyAmount(currencyAmount) end
  local dialog = BuildDialog_Old(self, ...)
  getmetatable(TheInventory).__index.GetCurrencyAmount = GetCurrencyAmount_Old
  if self.is_buying then
    if self.doodad_net < 0 then return dialog end
    dialog.actions.items[1]:SetOnClick(function()
      TheFrontEnd:PopScreen()
      self.launched_commerce = nil -- self=itemexplorer, but I cannot get it here
      Queuer.addQueue(self.item_key, self.doodad_value, true)
    end)
    return dialog
  end
  if Queuer.getItemCount(self.item_key) == 1 then
    dialog.body:SetString(strings["WARNING: THIS IS YOUR LAST ONE\n\n"] .. dialog.body:GetString():match("^(.*)\n"))
  elseif Queuer.getItemCount(self.item_key) <= 0 then
    dialog.body:SetString(strings["You have no "] .. GetSkinName(self.item_key)
                            .. strings[" left to unravel.\n\nPlease wait for the queue to finish."])
    dialog.actions.items[1]:Disable()
  end
  dialog.actions.items[1]:SetOnClick(function()
    TheFrontEnd:PopScreen()
    self.launched_commerce = nil -- self=itemexplorer, but I cannot get it here
    Queuer.addQueue(self.item_key, self.doodad_value)
  end)
  return dialog
end
local BuildItemsSummary_Old = PlayerSummaryScreen._BuildItemsSummary or (function() end)
PlayerSummaryScreen._BuildItemsSummary = function(self, ...)
  local width = 300
  local root = BuildItemsSummary_Old(self, ...)
  local UpdateItems_Old = root.UpdateItems or (function() end)
  root.selldupes = root:AddChild(TEMPLATES.StandardButton(function()
    TheFrontEnd:PushScreen(DupesPopup.create(DupeSeller.getAllDupes()))
  end, strings["Unravel All Duplicates"], {200, 40}))
  root.selldupes:SetPosition(300, 10)
  root.________________UpdateItems = function(...)
    UpdateItems_Old(...)
    local dupes = DupeSeller.getAllDupes()
    if #dupes <= 0 then
      root.selldupes:OnDisable()
      return
    end
    root.selldupes:OnEnable()
  end
  return root
end
PlayerSummaryScreen._DoNewFocusHookups = function(self, new)
  self.menu:SetFocusChangeDir(MOVE_RIGHT, self.new_items.selldupes)
  self.new_items.selldupes:SetFocusChangeDir(MOVE_LEFT, self.menu)
  if self.festivals_badges ~= nil then
    self.new_items.selldupes:SetFocusChangeDir(MOVE_RIGHT, self.festivals_badges[1])
    for i, _ in pairs(self.festivals_badges) do
      self.festivals_badges[i]:SetFocusChangeDir(MOVE_UP, self.festivals_badges[i - 1])
      self.festivals_badges[i]:SetFocusChangeDir(MOVE_LEFT, self.new_items.selldupes)
      self.festivals_badges[i]:SetFocusChangeDir(MOVE_DOWN, self.festivals_badges[i + 1])
    end
  end
end
Queuer.getItemCount =
  function(key, n) return (n or GetOwnedItemCounts()[key] or 0) - (Queuer.itemQueueCount[key] or 0) end
Queuer.addQueue = function(key, value, buy)
  if buy then
    return Queuer.addBuyQueue(key, value)
  elseif (GetOwnedItemCounts()[key] or 0) <= 0 then
    printd(strings["ERROR: You don't own "] .. key)
    return
  elseif DupeSeller.GetCount(key) <= 0 then
    printd(strings["ERROR: You don't have any "] .. key .. strings[" left to sell"])
    return
  end
  val = value or TheItems:GetBarterSellPrice(key)
  if val <= 0 then
    printd(strings["ERROR: You can't unravel "] .. key .. strings[" for any spools"])
    return
  end
  Queuer.itemQueueCount[key] = (Queuer.itemQueueCount[key] or 0) + 1
  Queuer.queue[#Queuer.queue + 1] = {key = key, val = val}
  printd(strings["Queued "] .. key .. strings[" to be sold for "] .. val .. strings[" spools"])
  if #Queuer.queue == 1 then Queuer.startQueue() end
  HUD.onQueueUpdate()
end
Queuer.addBuyQueue = function(key, value)
  val = value or TheItems:GetBarterBuyPrice(key)
  if val <= 0 then
    printd(strings["ERROR: You can't buy "] .. key)
    return
  end
  Queuer.itemQueueCount[key] = (Queuer.itemQueueCount[key] or 0) - 1
  Queuer.queue[#Queuer.queue + 1] = {key = key, val = val, buy = true}
  printd(strings["Queued "] .. key .. strings[" to be bought for "] .. val .. strings[" spools"])
  if #Queuer.queue == 1 then Queuer.startQueue() end
  HUD.onQueueUpdate()
end
Queuer.startQueue = function()
  printd(strings["Starting queue..."])
  Queuer.doQueue()
  Queuer.timerTask = scheduler:ExecutePeriodic(1 / 30, function() Queuer.timetaken = Queuer.timetaken + 1 end)
end
Queuer.doQueue = function()
  local q = Queuer.queue[Queuer.count]
  if not q then
    Queuer.stopQueue()
    return
  elseif q.buy then
    Queuer.weaveFn(q.key, q.val)
  else
    Queuer.unravelFn(q.key, q.val)
  end
  HUD.onQueueUpdate(Queuer.timetaken)
end
Queuer.stopQueue = function(forced)
  Queuer.queue = {}
  Queuer.itemQueueCount = {}
  Queuer.count = 1
  Queuer.timetaken = 0
  if Queuer.timerTask ~= nil then
    Queuer.timerTask:Cancel()
    Queuer.timerTask = nil
  end
  if forced then
    printd(strings["Stopped queue"])
  else
    printd(strings["Finished queue"])
  end
  HUD.onQueueUpdate()
end
Queuer.unravelFn = function(key, val)
  local item_id = GetFirstOwnedItemId(key)
  if not item_id then
    local server_error = PopupDialog(STRINGS.UI.TRADESCREEN.SERVER_ERROR_TITLE,
      STRINGS.UI.TRADESCREEN.SERVER_ERROR_BODY, {
        {
          text = STRINGS.UI.TRADESCREEN.OK,
          cb = function()
            print(strings["ERROR: Bartering away unowned item."])
            SimReset()
          end
        }
      })
    scheduler:ExecuteInTime(0, function() TheFrontEnd:PushScreen(server_error) end)
    return
  end
  printd(strings["Selling "] .. key .. "...")
  TheItems:BarterLoseItem(item_id, val, function(success, status)
    scheduler:ExecuteInTime(0, function()
      Queuer.unravelComplete(success, status, {"dontstarve/HUD/Together_HUD/collectionscreen/unweave"}, key)
      Queuer.onUnravel(success, key, val)
    end)
  end)
end
Queuer.onUnravel = function(success, key, val)
  if success then
    printd(strings["SUCCESS: Sold "] .. key .. strings[" for "] .. val .. strings[" spools"])
  else
    printd(strings["ERROR: Failed to sell "] .. key)
  end
  Queuer.itemQueueCount[key] = Queuer.itemQueueCount[key] - 1
  Queuer.count = Queuer.count + 1
  Queuer.doQueue()
  Queuer.timetaken = 0
end
Queuer.unravelComplete = function(success, status, sounds, key)
  if not success then
    local server_error = PopupDialog(STRINGS.UI.BARTERSCREEN.FAILED_TITLE, STRINGS.UI.BARTERSCREEN.FAILED_BODY, {
      {
        text = STRINGS.UI.BARTERSCREEN.OK,
        cb = function()
          print(strings["ERROR: Failed to contact the item server. status="], status)
          SimReset()
        end
      }
    })
    scheduler:ExecuteInTime(0, function() TheFrontEnd:PushScreen(server_error) end)
    return
  end
  for _, v in ipairs(sounds) do TheFrontEnd.gameinterface.SoundEmitter:PlaySound(v) end
  local screen = Queuer.getScreen()
  if screen.RefreshInventory then
    Queuer.unravelRefresh(screen.subscreener.sub_screens[screen.subscreener.active_key], screen, key)
  elseif screen.doodad_count then
    screen.doodad_count:SetCount(TheInventory:GetCurrencyAmount(), true)
  end
end
Queuer.unravelRefresh = function(sub, screen, key)
  local self = sub.picker
  if not self then
    screen:RefreshInventory(true)
    return
  end
  local target = Queuer.findItem(self, key)
  if target and target.owned_count <= 1 then
    local data = Queuer.findItem(self, key)
    if self.scroll_list.context.selection_type then self:_SetItemActiveFlag(data, false) end
    for i, receiver in ipairs(self.scroll_list.context.input_receivers) do
      if receiver.OnClickedItem then receiver:OnClickedItem(data, false) end
    end
  end
  screen:RefreshInventory(true)
  self:RefreshItems()
end
Queuer.weaveFn = function(key, val)
  printd(strings["Buying "] .. key .. "...")
  TheItems:BarterGainItem(key, val, function(success, status)
    scheduler:ExecuteInTime(0, function()
      Queuer.weaveComplete(success, status, {
        "dontstarve/HUD/Together_HUD/collectionscreen/weave",
        "dontstarve/HUD/Together_HUD/collectionscreen/unlock"
      }, key)
      Queuer.onWeave(success, key, val)
    end)
  end)
end
Queuer.onWeave = function(success, key, val)
  if success then
    printd(strings["SUCCESS: Bought "] .. key .. strings[" for "] .. val .. strings[" spools"])
  else
    printd(strings["ERROR: Failed to buy "] .. key)
  end
  Queuer.itemQueueCount[key] = Queuer.itemQueueCount[key] + 1
  Queuer.count = Queuer.count + 1
  Queuer.doQueue()
  Queuer.timetaken = 0
end
Queuer.weaveComplete = function(success, status, sounds, key)
  if not success then
    local server_error = PopupDialog(STRINGS.UI.BARTERSCREEN.FAILED_TITLE, STRINGS.UI.BARTERSCREEN.FAILED_BODY, {
      {
        text = STRINGS.UI.BARTERSCREEN.OK,
        cb = function()
          print(strings["ERROR: Failed to contact the item server. status="], status)
          SimReset()
        end
      }
    })
    scheduler:ExecuteInTime(0, function() TheFrontEnd:PushScreen(server_error) end)
    return
  end
  for _, v in ipairs(sounds) do TheFrontEnd.gameinterface.SoundEmitter:PlaySound(v) end
  local screen = Queuer.getScreen()
  if screen.RefreshInventory then
    Queuer.weaveRefresh(screen.subscreener.sub_screens[screen.subscreener.active_key], screen, key)
  elseif screen.doodad_count then
    screen.doodad_count:SetCount(TheInventory:GetCurrencyAmount(), true)
  end
end
Queuer.weaveRefresh = function(sub, screen, key)
  local self = sub.picker
  if not self then
    screen:RefreshInventory(true)
    return
  end
  local data = Queuer.findItem(self, key)
  local purchased_widget = data and data.widget or nil
  screen:RefreshInventory(true)
  self:RefreshItems()
  if purchased_widget ~= nil and purchased_widget.data.is_owned and purchased_widget.PlayUnlock then
    purchased_widget:PlayUnlock()
  end
end
Queuer.findItem = function(self, key)
  if not self.scroll_list then return end
  local items = self.scroll_list.items
  for i = 1, #items do if items[i].item_key == key then return items[i] end end
end
Queuer.getScreen = function()
  if not (TheFrontEnd and TheFrontEnd.screenstack and #TheFrontEnd.screenstack > 0) then return {} end
  local stack = TheFrontEnd.screenstack
  for i = #stack, 1, -1 do
    if stack[i].doodad_count then
      return stack[i]
    elseif stack[i].panel and stack[i].panel.loadout and stack[i].panel.loadout.doodad_count then
      return stack[i].panel.loadout
    end
  end
  return {}
end
Queuer.getCurrencyAmount = function(amount)
  local doodads = amount or TheInventory:GetCurrencyAmount()
  if #Queuer.queue > 0 then
    for i = Queuer.count, #Queuer.queue do
      doodads = doodads + Queuer.queue[i].val * (Queuer.queue[i].buy and -1 or 1)
    end
  end
  return doodads
end
DupeSeller.sellAllDupes = function(duplicates)
  local dupes = duplicates or DupeSeller.getAllDupes()
  if #dupes <= 0 then
    printd(strings["You don't have any dupes"])
    return
  end
  for i = 1, #dupes do Queuer.addQueue(dupes[i], nil) end
end
DupeSeller.CanSell = function(k, v)
  local price = TheItems:GetBarterSellPrice(k)
  if price <= 0 then return false end
  local marketable = IsItemMarketable(k)
  if price >= minprice then return false end
  if marketable and not marketable_sell then return false end
  local count = Queuer.getItemCount(k, v)
  return count > mincount
end
DupeSeller.GetCount = function(k, v)
  local count = Queuer.getItemCount(k, v)
  return count
end
DupeSeller.getAllDupes = function()
  local dupes = {}
  for k, v in pairs(GetOwnedItemCounts()) do
    local c = DupeSeller.GetCount(k, v) - mincount
    if DupeSeller.CanSell(k, v) then for i = 1, c do dupes[#dupes + 1] = k end end
  end
  return dupes
end
DupeSeller.getDupesTotalWorth = function(duplicates)
  local dupes = duplicates or DupeSeller.getAllDupes()
  local total = 0
  for i = 1, #dupes do total = total + TheItems:GetBarterSellPrice(dupes[i]) end
  return total
end
