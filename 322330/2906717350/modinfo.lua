local isCh = locale == "zh" or locale == "zhr"
name = isCh and "45格物品栏(扩宽装备栏UI)" or "45 Inventory Slots [EquipSlot UI expand]"

description = isCh and [[
扩宽45格道具栏中间的装备栏UI，使其适配各种增加装备栏的mod，让UI不会被遮挡

若和能力勋章mod一起使用时，请打开能力勋章mod设置界面，把＂勋章栏自动贴边＂关闭，以保证融合勋章可正常打开
]] or "Widen the UI of the equipment bar in the middle of the 45-grid item bar to adapt to various mods that increase the equipment bar, so that the UI will not be blocked"

author = "dayoumingqi"
version = "1.2"

icon_atlas = "Icon.xml"
icon = "Icon.tex"

api_version = 10

dst_compatible = true
all_clients_require_mod = true
client_only_mod = false

configuration_options = isCh and
{
  {
    name = "ENABLEBACKPACK",
    label = "允许背包存储在物品栏中",
    hover = "允许背包存储在物品栏中",
    options = {
        {description = "Yes", data = true},
        {description = "No", data = false},
      },
    default = false,
  },
  {
    name = "INVENTORYSIZE",
    label = "改变物品栏数量",
    hover = "物品栏数量设置",
    options = {
        {description = "15", data = 15},
        {description = "25", data = 25},
        {description = "45", data = 45},
      },
    default = 45,
  },
  {
    name = "MOREEQUIPSLOTS",
    label = "启用更多额外装备栏",
    hover = "启用更多额外装备栏(增加背包栏和护符), 若使用其他增加装备栏mod请关闭此选项",
    options = {
        {description = "None", data = false, hover="Off"},
        {description = "背包 & 护符栏", data = true, hover="Add dedicated slots for a backpack and an amulet"},
      },
    default = false,
  },
} or
{
  {
    name = "ENABLEBACKPACK",
    label = "Allow backpacks to be stored in your inventory",
    hover = "Backpack inception. Allows backpacks to be stored as an item in your inventory",
    options = {
        {description = "Yes", data = true},
        {description = "No", data = false},
      },
    default = false,
  },
  {
    name = "INVENTORYSIZE",
    label = "Change the size of your inventory",
    hover = "Increase the size of your inventory, up to 45 slots",
    options = {
        {description = "15", data = 15},
        {description = "25", data = 25},
        {description = "45", data = 45},
      },
    default = 45,
  },
  {
    name = "MOREEQUIPSLOTS",
    label = "Enable extra equipment slots",
    hover = "Enable more extra equipment slots (increase backpack slots and amulets), please turn off this option if you use other mods that increase equipment slots",
    options = {
        {description = "None", data = false, hover="Off"},
        {description = "Backpack & Amulets", data = true, hover="Add dedicated slots for a backpack and an amulet"},
      },
    default = false,
  },
}
