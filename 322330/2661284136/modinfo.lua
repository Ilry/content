local L = locale == "zh" or locale == "zhr"
name = L and "启迪之冠增强" or "Alterguardian Hat Enhance"
description = L and "养老怎么舒服我怎么来" or "This is a mod to reduce the difficulty later in the game"
author = "三分热度"
version = "5.3"

forumthread = ""

api_version = 10
dst_compatible = true
client_only_mod = false
all_clients_require_mod = true
priority = -999

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"item",}


configuration_options =
{
  L and {
  name = "孢子掉落",
  label="掉落蘑菇孢子",
  hover = "每隔一段时间会随机掉落四种蘑菇孢子中的一种",
  options = {
    {description = "掉落",hover = "默认掉落月亮孢子",data = true},
    {description = "不掉落",hover = "不掉落月亮孢子",data = false},
 },default = false
  }or{
    name = "孢子掉落",
    label="Drops mushroom spores",
    hover = "Randomly drop one of four mushroom spores at regular intervals",
    options = {
      {description = "On",hover = "drop spores",data = true},
      {description = "Off",hover = "Does not drop spores",data = false},
   },default = true
  },
  L and {
  name = "冬暖夏凉",
  label="冬暖夏凉",
  hover = "冬天240保暖夏天240隔热,相当于你冬天戴着牛帽夏天戴着冰块",
  options = {
    {description = "不开启",hover = "不开启冬暖夏凉",data = false},
    {description = "开启",hover = "开启冬暖夏凉",data = true }},
  default = false
  }or{
    name = "冬暖夏凉",
    label="Warm in winter and cool in summer",
    hover = "The equivalent of wearing a beefalo hat in the winter and wearing an ice cube in the summer.",
    options = {
      {description = "Off",data = false},
      {description = "On",data = true }},
    default = false
  },
L and {
name = "饥饿速率",
label = "饥饿速率",
hover = "决定你饥饿的快慢，正常一天不吃饭掉75饥饿值",
options={
  {description = "1",hover = "饥饿速率正常",data = 1},
  {description="0.75",hover = "饥饿速率0.75",data = 0.75 },
  {description="0.5",hover="饥饿速率0.5",data = 0.5},
  {description="0.25",hover="饥饿速率0.25",data = 0.25},
},default = 1
}or{
  name = "饥饿速率",
  label = "starvation rate",
  hover = "Decide how fast you are hungry",
  options={
    {description = "1",hover = "normal starvation rate",data = 1},
    {description="0.75",data = 0.75 },
    {description="0.5",data = 0.5},
    {description="0.25",data = 0.25},
  },default = 1
},
L and {
name = "发光阈值",
label = "发光阈值",
hover = "启迪之冠在你理智值多少时会发光",
options={
  {description = "0.85（原版）",hover = "san达到85%时发光",data = 0.85},
  {description="0.50",hover = "san达到50%时发光",data = 0.50 },
  {description="永亮",hover="san无论多少都发光",data = 0.0},
},default = 0.85
}or{
  name = "发光阈值",
  label = "Luminous Threshold",
  hover = "The alterguardianhat glows when your sanity is high",
  options={
    {description = "0.85(default)",data = 0.85},
    {description="0.50",data = 0.50 },
    {description="permanent glow",data = 0.0},
  },default = 0.85
},
L and {
  name = "AOE伤害",
  label = "AOE伤害",
  hover = "开启后你的攻击会变成范围伤害",
    options={
      {description = "开启",hover = "开启aoe伤害",data = true},
      {description="不开启",hover = "不开启aoe伤害",data = false },
},default = false
}or{
  name = "AOE伤害",
  label = "area damage",
  hover = "your attack will become area damage",
    options={
      {description = "On",data = true},
      {description="Off",data = false },
},default = false
},L and {name = "AOE范围",
label = "AOE范围",
hover = "AOE范围(一个地皮距离是4)",
options = {{description = "1",data = 1},
{description = "2",data =2},
{description = "3",data = 3},
{description = "4",data = 4},
{description = "5",data = 5},
{description = "6",data = 6},
{description = "7",data = 7},
{description = "8",data = 8},
},default = 4
}or{
  name = "AOE范围",
  label = "AOE范围",
  hover = "AOE range (the distance of one land is 4)",
  options = {{description = "1",data = 1},
  {description = "2",data =2},
  {description = "3",data = 3},
  {description = "4",data = 4},
  {description = "5",data = 5},
  {description = "6",data = 6},
  {description = "7",data = 7},
  {description = "8",data = 8},
  },default = 4
},
L and {
  name = "防尘",
  label = "沙漠护目镜功能",
  hover = "在沙尘暴中不减速，视野正常",
   options={
    {description = "开启",hover = "开启",data = true},
    {description="不开启",hover = "不开启",data = false },
},default = false
}or{
  name = "防尘",
  label = "Desert Goggles Feature",
  hover = "Does not slow down during sandstorms and has normal vision",
   options={
    {description = "On",data = true},
    {description="Off",data = false },
},default = false
},
L and {name = "是否开启碰撞体积和水上行走",
  label = "无碰撞体积并且可以水上行走",
  hover = "开启后可以穿过任何物体并且可以水上行走",
   options={
    {description = "开启",hover = "开启开启碰撞体积和水上行走",data = true},
    {description="不开启",hover = "不开启开启碰撞体积和水上行走",data = false },
},default = false
}or{
  name = "是否开启碰撞体积和水上行走",
  label = "Has no collision volume and can walk on water",
   options={
    {description = "On",data = true},
    {description="Off",data = false },
},default = false
},
L and {name = "防御值",
  label = "防御值",
  hover = "设置护甲的高低",
  options = {{description = "防御力0",hover = "没有防御力",data = 0},
  {description = "防御力50%",hover = "防御力50%",data = 0.5},
  {description = "防御力70%",hover = "防御力70%",data = 0.7},
  {description = "防御力80%",hover = "防御力80%",data = 0.8},
  {description = "防御力90%",hover = "防御力90%",data = 0.9},
  {description = "防御力95%",hover = "防御力95%",data = 0.95},
  {description = "防御力99%",hover = "防御力99%",data = 0.99},
},default = 0.8
}or{name = "防御值",
label = "armor value",
hover = "Set the level of armor",
options = {{description = "防御力0",hover = "没有防御力",data = 0},
{description = "50%",data = 0.5},
{description = "70%",data = 0.7},
{description = "80%",data = 0.8},
{description = "90%",data = 0.9},
{description = "95%",data = 0.95},
{description = "99%",data = 0.99},
},default = 0.8
},
L and {name = "牛奶帽功能",
label = "牛奶帽功能",
hover = "佩戴时自动回复饥饿值",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{name = "牛奶帽功能",
label = "milkmade hat feature",
hover = "Automatically restore hunger when equip",
options = {{description = "On",data = true},
  {description = "Off",data = false},
},default = false
},
L and {name = "羽毛帽功能",
label = "羽毛帽功能",
hover = "吸引鸟类在你周围降落",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{name = "羽毛帽功能",
label = "feather hat feature",
hover = "Attract birds to land around you",
options = {{description = "On",data = true},
  {description = "Off",data = false},
},default = false
},
L and {name = "独奏乐器功能",
label = "独奏乐器功能",
hover = "吸引猪人或鱼人跟随你，照顾作物",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "独奏乐器功能",
  label = "one-man band feature",
  hover = "Attract pigs or murlocs to follow you and take care of crops",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},
L and {name = "保鲜功能",
  label = "保鲜功能",
  hover = "物品栏食物永久保鲜",
  options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "保鲜功能",
  label = "Freshness function",
  hover = "Inventory food is permanently fresh",
  options = {{description = "On",data = true},
  {description = "Off",data = false},
},default = false
},
L and {name = "移速",
label = "移速加成",
hover = "移速加成",
options = {{description = "1",hover = "没有移速加成",data = 1},
{description = "1.1",hover = "移速加成10%",data =1.1},
{description = "1.2",hover = "移速加成20%",data = 1.2},
{description = "1.3",hover = "移速加成30%",data = 1.3},
{description = "1.4",hover = "移速加成40%",data = 1.4},
{description = "1.5",hover = "移速加成50%",data = 1.5},
},default = 1
}or{
  name = "移速",
  label = "Movement speed bonus",
  hover = "Movement speed bonus",
  options = {{description = "1",data = 1},
  {description = "1.1",data =1.1},
  {description = "1.2",data = 1.2},
  {description = "1.3",data = 1.3},
  {description = "1.4",data = 1.4},
  {description = "1.5",data = 1.5},
},default = 1
},
L and {name = "无法选中",
label = "无法选中",
hover = "生物对你无仇恨,无法攻击你",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "无法选中",
  label = "cannot be targeted",
  hover = "Creatures won't attack you",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},
L and {name = "防水",
label = "防水",
hover = "和眼球伞一样的防水效果",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = true
}or{
  name = "防水",
  label = "water proof",
  hover = "The same waterproof effect as the eyebrella",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = true
},
L and {name = "受攻击冰冻敌人",
label = "受攻击冰冻敌人",
hover = "受攻击冰冻敌人",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "受攻击冰冻敌人",
  label = "Freeze enemies when attacked",
  hover = "Freeze enemies when attacked",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},
L and {name = "铥矿护盾",
label = "铥矿护盾",
hover = "开启后受到攻击时有铥矿皇冠的护盾效果",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "铥矿护盾",
  label = "Whether to open the shield",
  hover = "There will be a shield to protect you when you are attacked",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},L and {name = "鹦鹉帽",
label = "波莉·罗杰的帽子",
hover = "开启波莉·罗杰的帽子功能，会有波莉·罗杰捡东西给你",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "鹦鹉帽",
  label = "Polly Roger's Hat",
  hover = "Turn on Polly Roger's hat function, and Polly Roger will pick up things for you",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},L and {name = "船长帽",
label = "船长的三角帽",
hover = "开启船长的三角帽功能，降低一半船收到的伤害",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "船长帽",
  label = "Captain's Tricorn",
  hover = "Turn on Captain's Tricorn function, reduces damage taken by half of the ship",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},L and {name = "海盗",
label = "海盗头巾",
hover = "开启海盗头巾功能，增加航海工作效率",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "海盗",
  label = "Pirate's Bandana",
  hover = "Turn on the Pirate's Bandana function to increase the efficiency of sailing work",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},L and {name = "防击退",
label = "防击退",
hover = "防击退",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "防击退",
  label = "Anti-knockback",
  hover = "Prevent being knocked back",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},L and {name = "位面防御",
label = "位面防御",
hover = "位面防御",
options = {{description = "0",data = 0},
{description = "10",data =10},
{description = "20",data = 20},
{description = "30",data = 30},
{description = "50",data = 50},
{description = "100",data = 100},
{description = "200",data = 200},
{description = "999",data = 999},
},default = 0
}or{
  name = "位面防御",
  label = "Planar Defense",
  hover = "Planar Defense",
  options = {{description = "0",data = 0},
{description = "10",data =10},
{description = "20",data = 20},
{description = "30",data = 30},
{description = "50",data = 50},
{description = "100",data = 100},
{description = "200",data = 200},
{description = "999",data = 999},
},default = 0
},L and {name = "理智",
label = "每秒理智回复速度",
hover = "每秒理智回复速度",
options = {{description = "1/6",data = 1/6},
{description = "1/3",data =1/3},
{description = "1/2",data = 1/2},
{description = "1",data = 1},
{description = "2",data = 2},
{description = "5",data = 5},
{description = "10",data = 10},
{description = "20",data = 20},
{description = "30",data = 30},
},default = 1/6
}or{
  name = "理智",
  label = "Sanity recovery speed",
  hover = "Sanity recovery speed",
  options = {{description = "1/6",data = 1/6},
  {description = "1/3",data =1/3},
  {description = "1/2",data = 1/2},
  {description = "1",data = 1},
  {description = "2",data = 2},
  {description = "5",data = 5},
  {description = "10",data = 10},
  {description = "20",data = 20},
  {description = "30",data = 30},
  },default = 1/6
},L and {name = "位面加成",
label = "位面加成",
hover = "开启虚空风帽和亮茄头盔的位面伤害加成",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "位面加成",
  label = "Plane damage bonus",
  hover = "Plane damage bonus",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},L and {name = "兔子伪装",
label = "兔子伪装",
hover = "靠近兔子时不会引起兔子的恐慌逃离，并且可以直接拾取兔子",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "兔子伪装",
  label = "rabbit disguise",
  hover = "When you approach a rabbit, it will not panic and flee, and you can pick up the rabbit directly.",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},L and {name = "胡萝卜外套",
label = "胡萝卜外套",
hover = "在物品栏中携带肉类食物不会引起兔人的仇恨",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "胡萝卜外套",
  label = "Coat of Carrots",
  hover = "Carrying meat in the inventory does not cause hatred from the bunnies",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},L and {name = "攻击附带冰冻",
label = "攻击附带冰冻",
hover = "攻击附带冰冻",
options = {{description = "开启",hover = "开启",data = true},
  {description = "不开启",hover = "不开启",data = false},
},default = false
}or{
  name = "攻击附带冰冻",
  label = "Attack with freezing",
  hover = "Attack with freezing",
  options = {{description = "On",data = true},
    {description = "Off",data = false},
  },default = false
},
}