GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
TUNING.MONITOR_CHESTS = TUNING.MONITOR_CHESTS or {}
TUNING.MONITOR_CHESTS.hclr_supermu1 = true
TUNING.MONITOR_CHESTS.hclr_supermu2 = true
TUNING.MONITOR_CHESTS.hclr_superice1 = true
TUNING.MONITOR_CHESTS.hclr_superice2 = true

for k,mod in pairs(ModManager.mods) do      --遍历已开启的mod
    if mod and mod.SHOWME_STRINGS then      --因为showme的modmain的全局变量里有 SHOWME_STRINGS 所以有这个变量的应该就是showme
        if mod.postinitfns and mod.postinitfns.PrefabPostInit and mod.postinitfns.PrefabPostInit.treasurechest then     --是的 箱子的寻物已经加上去了
            mod.postinitfns.PrefabPostInit.hclr_supermu1 =  mod.postinitfns.PrefabPostInit.treasurechest
            mod.postinitfns.PrefabPostInit.hclr_supermu2 =  mod.postinitfns.PrefabPostInit.treasurechest
            mod.postinitfns.PrefabPostInit.hclr_superice1 =  mod.postinitfns.PrefabPostInit.treasurechest
            mod.postinitfns.PrefabPostInit.hclr_superice2 =  mod.postinitfns.PrefabPostInit.treasurechest
        end
    end
end
PrefabFiles = {
	"hclr_cheche",
	"hclr_items",
	"hclr_cxc",
	"hclr_hcds",
	"hclr_xdhd",
    "hclr_pzgz",
    "hclr_mdlpzs",
    "hclr_yskc",
    "hclr_newgengxin",
    "hclr_superice",
    "hclr_supermu",
}

Assets = {
	Asset( "ATLAS", "images/hud/hclr.xml" ),
	Asset( "IMAGE", "images/hud/hclr.tex" ),
}
--================ STRINGS
local items = {

	{"hclr_meatballs","懒人肉丸车" ,"它能源源不断地生产肉丸"},
	{"hclr_trailmix","懒人坚果杂烩车" ,"它能源源不断地生产坚果杂烩"},
	{"hclr_perogies","懒人饺子车" ,"它能源源不断地生产饺子"},
	{"hclr_dragonpie","懒人火龙果派车" ,"它能源源不断地生产火龙果派"},
	
	{"hclr_dragonpie_item","火龙果派车改装" ,"将懒人坚果杂烩车改造成懒人火龙果车","将懒人坚果杂烩车改造成\n懒人火龙果车"},
	{"hclr_perogies_item","饺子改装" ,"将懒人肉丸车改造成懒人饺子车","将懒人肉丸车改造成\n懒人饺子车"},
	{"hclr_trailmix_item","坚果杂烩改装" ,"将烹饪锅改造为懒人坚果杂烩","将烹饪锅改造为\n懒人坚果杂烩"},
	{"hclr_meatballs_item","肉丸车改装" ,"将烹饪锅改造为懒人肉丸车","将烹饪锅改造为\n懒人肉丸车"},
	{"hclr_thc_item","怠惰拓荒场改装" ,"将柴薪场改造成拓荒场","将柴薪场改造成\n拓荒场"},
	{"hclr_hcds_item","混吃等死套件" ,"将帐篷改造成混吃等死小屋","将帐篷改造成\n混吃等死小屋"},
	{"hclr_xdhd_item","怠惰火堆改装" ,"将火堆改造成怠惰火堆","将火堆改造成\n怠惰火堆"},
	
	{"hclr_xdhd","怠惰火堆" ,"你连火都懒得加"},
	{"hclr_hcds","混吃等死小屋" ,"物如其名"},
	{"hclr_cxc","怠惰柴薪场" ,"为你的伍迪队友（划掉）工具人减少一分压力","为你队友减少压力"},
	{"hclr_thc","怠惰拓荒场" ,"进一步为成为薪手减少心理负担"},

	{"hclr_pzgz","曼德拉泡脚水改装" ,"进一步为成为薪手减少心理负担"},
	{"hclr_mdlpzs","曼德拉泡脚水" ,"天呐 它好大!"},
	{"hclr_yskc","鼹鼠矿场" ,"鼹鼠会打洞 你会吗？","好多矿石呀"},

    {"hclr_icelevel1","冰箱2改造" ,"将冰箱改造为3倍空间","将冰箱改造为3倍空间"},
    {"hclr_icelevel2","冰箱3改造" ,"将冰箱改造为10倍空间","将冰箱改造为10倍空间"},

    {"hclr_mulevel1","木箱2改造" ,"将木箱改造为3倍空间","将木箱改造为3倍空间"},
    {"hclr_mulevel2","木箱3改造" ,"将木箱改造为10倍空间","将木箱改造为10倍空间"},

    {"hclr_supermu1","木箱2" ,"超大容量"},
    {"hclr_supermu2","木箱3" ,"超大容量"},

    {"hclr_superice1","冰箱2" ,"超大容量"},
    {"hclr_superice2","冰箱3" ,"超大容量"},

    {"hclr_kjk","锟斤拷" ,"耐久是什么","烫烫烫烫烫烫烫"},

	{"dug_berrybush_lr1",STRINGS.NAMES.DUG_BERRYBUSH ,"","转成普通浆果丛"},
	{"dug_berrybush_lr2",STRINGS.NAMES.DUG_BERRYBUSH ,"","转成普通浆果丛"},

	{"dug_twigs_lr1",STRINGS.NAMES.DUG_SAPLING ,"","转成普通树苗"},
	{"dug_twigs_lr2",STRINGS.NAMES.DUG_SAPLING ,"","转成普通树苗"},

}

local old_treasurechest_clear_fn  = GLOBAL.treasurechest_clear_fn
GLOBAL.treasurechest_clear_fn = function(inst, def_build)
	if inst.prefab == "hclr_supermu1"  or inst.prefab == "hclr_supermu2" then
		inst.AnimState:SetBuild("treasure_chest")
	else
		return old_treasurechest_clear_fn(inst, def_build)
	end
end

AddClassPostConstruct("widgets/itemtile",function(self)
    local old_SetPercent = self.SetPercent
    function self:SetPercent(percent)
        if self.item:HasTag("hide_percentage") and self.percent then
            self.percent:Hide()
        end
        old_SetPercent(self,percent)
    end
end)

local old_icebox_clear_fn  = GLOBAL.icebox_clear_fn
GLOBAL.icebox_clear_fn = function(inst, def_build)
	if inst.prefab == "hclr_superice1"  or inst.prefab == "hclr_superice2" then
		inst.AnimState:SetBuild("ice_box")
	else
		return old_icebox_clear_fn(inst, def_build)
	end
end

PREFAB_SKINS.hclr_supermu1 = PREFAB_SKINS.treasurechest
PREFAB_SKINS_IDS.hclr_supermu1 = PREFAB_SKINS_IDS.treasurechest
PREFAB_SKINS.hclr_supermu2 = PREFAB_SKINS.treasurechest
PREFAB_SKINS_IDS.hclr_supermu2 = PREFAB_SKINS_IDS.treasurechest

PREFAB_SKINS.hclr_superice1 = PREFAB_SKINS.icebox
PREFAB_SKINS_IDS.hclr_superice1 = PREFAB_SKINS_IDS.icebox
PREFAB_SKINS.hclr_superice2 = PREFAB_SKINS.icebox
PREFAB_SKINS_IDS.hclr_superice2 = PREFAB_SKINS_IDS.icebox

for _, v in ipairs(items) do
	STRINGS.NAMES[string.upper(v[1])] = v[2]
	STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(v[1])] = v[3]
	if v[4] ~=nil then
		STRINGS.RECIPE_DESC[string.upper(v[1])] = v[4]
	end
end

--================ actions
local HCLR_GAIZAO = GLOBAL.Action({priority=10})
HCLR_GAIZAO.id = "HCLR_GAIZAO"
HCLR_GAIZAO.str = "改造"
HCLR_GAIZAO.fn = function(act)
	if act.invobject and act.invobject.components.hclr_gaizao and act.target  then
		return act.invobject.components.hclr_gaizao:GaiZao(act.target)
	end	
end

local HCLR_WXNJ = GLOBAL.Action({priority=10})
HCLR_WXNJ.id = "HCLR_WXNJ"
HCLR_WXNJ.str = "使用"
HCLR_WXNJ.fn = function(act)
	if act.invobject and act.target and act.target.components.lrhc_wxnj then
		return act.target.components.lrhc_wxnj:SetWNJ(act.invobject)
	end	
end
AddAction(HCLR_GAIZAO)
AddAction(HCLR_WXNJ)

local gaizaoliebiao ={
	hclr_dragonpie_item = "hclr_trailmix",
	hclr_meatballs_item = "cookpot",
	hclr_perogies_item = "hclr_meatballs",
	hclr_trailmix_item = "cookpot",
	hclr_xdhd_item = "firepit",
	hclr_hcds_item = "tent",
	hclr_thc_item = "hclr_cxc",
    hclr_pzgz = "hclr_hcds",
	hclr_icelevel1 = "icebox",
    hclr_icelevel2 = "hclr_superice1",
	hclr_mulevel1 = "treasurechest",
    hclr_mulevel2 = "hclr_supermu1",
}

AddComponentAction("USEITEM", "hclr_gaizao" , function(inst, doer, target, actions) 
	if  target and target.prefab and  target.prefab == gaizaoliebiao[inst.prefab]  then
        -- 如果不是火堆 则烧焦的物品不能改造
        if target.prefab == "firepit" or  not target:HasTag("burnt") then
             table.insert(actions, ACTIONS.HCLR_GAIZAO)
        end
	end
end)

AddComponentAction("USEITEM", "lrhc_wxnj_use" , function(inst, doer, target, actions) 
	if  target and target:HasTag("can_hclr_wxnj") then
		table.insert(actions, ACTIONS.HCLR_WXNJ)
	end
end)

AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(ACTIONS.HCLR_GAIZAO, "dolongaction"))
AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(ACTIONS.HCLR_GAIZAO, "dolongaction"))
AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(ACTIONS.HCLR_WXNJ, "dolongaction"))
AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(ACTIONS.HCLR_WXNJ, "dolongaction"))

AddComponentPostInit("fueled", function(self) 
    if self.inst then 
        self.inst:AddComponent('lrhc_wxnj') 
    end 
end)

AddComponentPostInit("finiteuses", function(self) 
    if self.inst then 
        self.inst:AddComponent('lrhc_wxnj') 
    end 
end)

AddComponentPostInit("armor", function(self) 
    if self.inst then 
        self.inst:AddComponent('lrhc_wxnj') 
    end 
end)

--================ containers
local cooking = require("cooking")
local containers = require "containers"
local params = containers.params
params.hclr_cxc =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.hclr_cxc.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end
function params.hclr_cxc.itemtestfn(container, item, slot)
    return item.prefab == "log"
end

params.hclr_thc =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_hclr_thc_3x9",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.hclr_thc.widget.slotpos, Vector3(80 * x - 80 * 2-80*3.3 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end
for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.hclr_thc.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end
for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.hclr_thc.widget.slotpos, Vector3(80 * x - 80 * 2+80*3.3 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

local tsetitems = {}
for k = 1,9 do
	tsetitems[k] = "log"
end
for k = 10,18 do
	tsetitems[k] = "twigs"
end
for k = 19,27 do
	tsetitems[k] = "cutgrass"
end
function params.hclr_thc.itemtestfn(container, item, slot)
    return item.prefab == tsetitems[slot]
end

params.hclr_yskc =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_hclr_thc_3x9",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.hclr_yskc.widget.slotpos, Vector3(80 * x - 80 * 2-80*3.3 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end
for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.hclr_yskc.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end
for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.hclr_yskc.widget.slotpos, Vector3(80 * x - 80 * 2+80*3.3 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

local tsetitems1 = {}
for k = 1,9 do
	tsetitems1[k] = "nitre"
end
for k = 10,18 do
	tsetitems1[k] = "flint"
end
for k = 19,27 do
	tsetitems1[k] = "rocks"
end
function params.hclr_yskc.itemtestfn(container, item, slot)
    return item.prefab == tsetitems1[slot]
end

params.hclr_superice1 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_hclr_thc_3x9",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

local function getx1(x)
    if x > 5 then 
        return 48
    elseif x > 2 then 
        return 24
    end
    return 0
end
for y = 2, 0, -1 do
    for x = 0, 8 do
        table.insert(params.hclr_superice1.widget.slotpos, Vector3(80 * x - 80 * 2-80*3.3 + 80 + getx1(x), 80 * y - 80 * 2 + 80, 0))
    end
end

function params.hclr_superice1.itemtestfn(container, item, slot)
    if item:HasTag("icebox_valid") then
        return true
    end
    if not (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled")) then
        return false
    end

	if item:HasTag("smallcreature") then
		return false
	end

    for k, v in pairs(FOODTYPE) do
        if item:HasTag("edible_"..v) then
            return true
        end
    end

    return false
end


params.hclr_superice2 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_hclr_thc_90",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

local jg = 10
local gaodu = 130
local function getjg(x)
    if x < -3 then
        return -2*jg
    elseif x < 0  then
        return -jg
    elseif x > 5  then
        return 2*jg
    elseif x > 2  then
        return jg    
    end   
    return 0 
end

for y = 2, 0, -1 do
    for x = -6, 8 do
        table.insert(params.hclr_superice2.widget.slotpos, Vector3(80 * x - 80 * 2 + 80+ getjg(x), 80 * y - 80 * 2 + 80 -jg+gaodu, 0))
    end
end

for y = -1, -3, -1 do
    for x = -6, 8 do
        table.insert(params.hclr_superice2.widget.slotpos, Vector3(80 * x - 80 * 2 + 80+ getjg(x), 80 * y - 80 * 2 + 80 -2*jg+gaodu, 0))
    end
end

params.hclr_superice2.itemtestfn = params.hclr_superice1.itemtestfn


params.hclr_supermu1 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_hclr_thc_3x9",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 2, 0, -1 do
    for x = 0, 8 do
        table.insert(params.hclr_supermu1.widget.slotpos, Vector3(80 * x - 80 * 2-80*3.3 + 80 + getx1(x), 80 * y - 80 * 2 + 80, 0))
    end
end


params.hclr_supermu2 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_hclr_thc_90",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 2, 0, -1 do
    for x = -6, 8 do
        table.insert(params.hclr_supermu2.widget.slotpos, Vector3(80 * x - 80 * 2 + 80+ getjg(x), 80 * y - 80 * 2 + 80 -jg+gaodu, 0))
    end
end

for y = -1, -3, -1 do
    for x = -6, 8 do
        table.insert(params.hclr_supermu2.widget.slotpos, Vector3(80 * x - 80 * 2 + 80+ getjg(x), 80 * y - 80 * 2 + 80 -2*jg+gaodu, 0))
    end
end

for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

--Stategraph
local function SetSleeperSleepState(inst)
    if inst.components.grue ~= nil then
        inst.components.grue:AddImmunity("sleeping")
    end
    if inst.components.talker ~= nil then
        inst.components.talker:IgnoreAll("sleeping")
    end
    if inst.components.firebug ~= nil then
        inst.components.firebug:Disable()
    end
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:EnableMapControls(false)
        inst.components.playercontroller:Enable(false)
    end
    inst:OnSleepIn()
    inst.components.inventory:Hide()
    inst:PushEvent("ms_closepopups")
    inst:ShowActions(false)
end
local function SetSleeperAwakeState(inst)
    if inst.components.grue ~= nil then
        inst.components.grue:RemoveImmunity("sleeping")
    end
    if inst.components.talker ~= nil then
        inst.components.talker:StopIgnoringAll("sleeping")
    end
    if inst.components.firebug ~= nil then
        inst.components.firebug:Enable()
    end
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:EnableMapControls(true)
        inst.components.playercontroller:Enable(true)
    end
    inst:OnWakeUp()
    inst.components.inventory:Show()
    inst:ShowActions(true)
end
local DANGER_ONEOF_TAGS = { "monster", "pig", "_combat" }
local DANGER_NOPIG_ONEOF_TAGS = { "monster", "_combat" }
local function IsNearDanger(inst)
    local hounded = TheWorld.components.hounded
    if hounded ~= nil and (hounded:GetWarning() or hounded:GetAttacking()) then
        return true
    end
    local burnable = inst.components.burnable
    if burnable ~= nil and (burnable:IsBurning() or burnable:IsSmoldering()) then
        return true
    end
    local nospiderdanger = inst:HasTag("spiderwhisperer") or inst:HasTag("spiderdisguise")
    local nopigdanger = not inst:HasTag("monster")
    return FindEntity(inst, 10,
        function(target)
            return (target.components.combat ~= nil and target.components.combat.target == inst)
                or ((target:HasTag("monster") or (not nopigdanger and target:HasTag("pig"))) and
                    not target:HasTag("player") and
                    not (nospiderdanger and target:HasTag("spider")) and
                    not (inst.components.sanity:IsSane() and target:HasTag("shadowcreature")))
        end,
        nil, nil, nopigdanger and DANGER_NOPIG_ONEOF_TAGS or DANGER_ONEOF_TAGS) ~= nil
end
AddStategraphState("wilson",
	State {
        name = "hcds_tent",
        tags = { "tent", "busy", "silentmorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()

            local target = inst:GetBufferedAction().target
            local failreason =
                (target.components.burnable ~= nil and
                    target.components.burnable:IsBurning() and
                    "ANNOUNCE_NOSLEEPONFIRE")
                or (IsNearDanger(inst) and "ANNOUNCE_NODANGERSLEEP")
                or nil

            if failreason ~= nil then
                inst:PushEvent("performaction", { action = inst.bufferedaction })
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle")
                if inst.components.talker ~= nil then
                    inst.components.talker:Say(GetString(inst, failreason))
                end
                return
            end

            inst.AnimState:PlayAnimation("pickup")
            inst.sg:SetTimeout(6 * FRAMES)

            SetSleeperSleepState(inst)
        end,

        ontimeout = function(inst)
            local bufferedaction = inst:GetBufferedAction()
            if bufferedaction == nil then
                inst.AnimState:PlayAnimation("pickup_pst")
                inst.sg:GoToState("idle", true)
                return
            end
            local tent = bufferedaction.target
            if tent == nil or
                not tent:HasTag("tent") or
                tent:HasTag("hassleeper") or
                (tent.components.burnable ~= nil and tent.components.burnable:IsBurning()) then
                inst:PushEvent("performaction", { action = inst.bufferedaction })
                inst:ClearBufferedAction()
                inst.AnimState:PlayAnimation("pickup_pst")
                inst.sg:GoToState("idle", true)
            else
                inst:PerformBufferedAction()
                inst.components.health:SetInvincible(true)
                inst:Hide()
                if inst.Physics ~= nil then
                    inst.Physics:Teleport(inst.Transform:GetWorldPosition())
                end
                if inst.DynamicShadow ~= nil then
                    inst.DynamicShadow:Enable(false)
                end
                inst.sg:AddStateTag("sleeping")
                inst.sg:RemoveStateTag("busy")
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(true)
                end
            end
        end,

        onexit = function(inst)
            inst.components.health:SetInvincible(false)
            inst:Show()
            if inst.DynamicShadow ~= nil then
                inst.DynamicShadow:Enable(true)
            end
            if inst.sleepingbag ~= nil then
                inst.sleepingbag.components.sleepingbag:DoWakeUp(true)
                inst.sleepingbag = nil
                SetSleeperAwakeState(inst)
            elseif not inst.sg.statemem.iswaking then
                SetSleeperAwakeState(inst)
            end
        end,
	}
)
local function hcds_tent(sg)
    local old_sleep = sg.actionhandlers[ACTIONS.SLEEPIN].deststate
    sg.actionhandlers[ACTIONS.SLEEPIN].deststate = function(inst, action)
        if action.target ~= nil and action.target:HasTag("hcds_tent") then
			return "hcds_tent"
        end
        return old_sleep(inst, action)
    end
end
AddStategraphPostInit("wilson", hcds_tent)

AddPrefabPostInit("firesuppressor", function(inst)
	if inst.components.wateryprotection then
		inst.components.wateryprotection:AddIgnoreTag("hclr_xdhd")
	end
end)
modimport "scripts/hc_newtree.lua"

local hclr = AddRecipeTab( "懒人科技", 897, "images/hud/hclr.xml", "hclr.tex")

local function MyAddRecipe(name, ingredients, tab, level, placer_or_more_data, min_spacing, nounlock, numtogive, builder_tag, atlas, image, testfn, product, build_mode, build_distance,filters)
    if AddRecipe2 then
        local  result = AddRecipe2(name, ingredients,level, {placer = placer_or_more_data , min_spacing = min_spacing ,
                                             nounlock = nounlock , numtogive = numtogive , builder_tag = builder_tag ,
                                             atlas = atlas, image = image, testfn = testfn, product = product,
                                             build_mode = build_mode, build_distance},filters)
        if image and atlas then
            RegisterInventoryItemAtlas(atlas , image)
        end
        return result
    else
        return AddRecipe(name, ingredients, tab, level, placer_or_more_data, min_spacing, nounlock, numtogive, builder_tag, atlas, image, testfn, product, build_mode, build_distance)
    end
end


MyAddRecipe("hclr_cxc", {Ingredient("pinecone", 40),Ingredient("nightmarefuel",4),Ingredient("axe",1)}, hclr, TECH.HCLR_TECHTREE_TWO,
        "hclr_cxc_placer", 2, false, nil, nil,"images/inventoryimages/hclr_cxc.xml", "hclr_cxc.tex",nil,nil,nil,nil,{"STRUCTURES"})
MyAddRecipe("hclr_yskc", {Ingredient("mole", 4),Ingredient("nightmarefuel",4),Ingredient("shovel",1)}, hclr, TECH.HCLR_TECHTREE_TWO,
        "hclr_yskc_placer", 2, false, nil, nil,"images/inventoryimages/hclr_yskc.xml", "hclr_yskc.tex",nil,nil,nil,nil,{"STRUCTURES"})

MyAddRecipe("hclr_xdhd_item", {Ingredient("nightmarefuel", 9),Ingredient("purplegem", 3)}, RECIPETABS.SCIENCE, TECH.SCIENCE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_xdhd_item.xml", "hclr_xdhd_item.tex",nil,nil,nil,nil,{"PROTOTYPERS","LIGHT","COOKING","STRUCTURES"})

MyAddRecipe("hclr_thc_item", {Ingredient("dug_sapling", 36),Ingredient("dug_grass", 36),Ingredient("guano", 9)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_thc_item.xml", "hclr_thc_item.tex",nil,nil,nil,nil,{"STRUCTURES"})

local dug_berrybush_lr1 = MyAddRecipe("dug_berrybush_lr1", {Ingredient("dug_berrybush_juicy", 1)}, hclr, TECH.HCLR_TECHTREE_TWO,
        nil, nil, true, 2, nil,"images/inventoryimages1.xml", "dug_berrybush.tex",nil,"dug_berrybush",nil,nil,{"REFINE"})
dug_berrybush_lr1.no_deconstruction = true
local dug_berrybush_lr2 = MyAddRecipe("dug_berrybush_lr2", {Ingredient("dug_berrybush2", 1)}, hclr, TECH.HCLR_TECHTREE_TWO,
        nil, nil, true, 1, nil,"images/inventoryimages1.xml", "dug_berrybush.tex",nil,"dug_berrybush",nil,nil,{"REFINE"})
dug_berrybush_lr2.no_deconstruction = true

local dug_twigs_lr1 = MyAddRecipe("dug_twigs_lr1", {Ingredient("twiggy_nut", 4)}, hclr, TECH.HCLR_TECHTREE_TWO,
        nil, nil, true, 1, nil,"images/inventoryimages1.xml", "dug_sapling.tex",nil,"dug_sapling",nil,nil,{"REFINE"})
dug_twigs_lr1.no_deconstruction = true

local dug_twigs_lr2 = MyAddRecipe("dug_twigs_lr2", {Ingredient("dug_marsh_bush", 1)}, hclr, TECH.HCLR_TECHTREE_TWO,
        nil, nil, true, 1, nil,"images/inventoryimages1.xml", "dug_sapling.tex",nil,"dug_sapling",nil,nil,{"REFINE"})
dug_twigs_lr2.no_deconstruction = true

MyAddRecipe("hclr_hcds_item", {Ingredient("meatballs", 66),Ingredient("bonestew", 20),Ingredient("boards", 10)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_hcds_item.xml", "hclr_hcds_item.tex",nil,nil,nil,nil,{"STRUCTURES","WINTER","RESTORATION"})
MyAddRecipe("hclr_meatballs_item", {Ingredient("spidereggsack", 1),Ingredient("dug_berrybush", 9),Ingredient("boards", 6)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_meatballs_item.xml", "hclr_meatballs_item.tex",nil,nil,nil,nil,{"STRUCTURES","GARDENING","COOKING"})
MyAddRecipe("hclr_trailmix_item", {Ingredient("acorn", 24),Ingredient("dug_berrybush", 9),Ingredient("boards", 6)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_trailmix_item.xml", "hclr_trailmix_item.tex",nil,nil,nil,nil,{"STRUCTURES","GARDENING","COOKING"})
MyAddRecipe("hclr_perogies_item", {Ingredient("dug_rock_avocado_bush", 6),Ingredient("papyrus", 8),Ingredient("goldnugget", 24)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_perogies_item.xml", "hclr_perogies_item.tex",nil,nil,nil,nil,{"STRUCTURES","GARDENING","COOKING"})
MyAddRecipe("hclr_dragonpie_item", {Ingredient("dragonfruit_seeds", 9),Ingredient("dug_sapling", 9)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_dragonpie_item.xml", "hclr_dragonpie_item.tex",nil,nil,nil,nil,{"STRUCTURES","GARDENING","COOKING"})
MyAddRecipe("hclr_pzgz", {Ingredient("mandrake", 1),Ingredient("poop", 6),Ingredient("livinglog", 6)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_pzgz.xml", "hclr_pzgz.tex",nil,nil,nil,nil,{"STRUCTURES","WINTER","SUMMER","RESTORATION"})

MyAddRecipe("hclr_icelevel1", {Ingredient("gears", 3),Ingredient("cutstone", 3),Ingredient("goldnugget", 6)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_icelevel1.xml", "hclr_icelevel1.tex",nil,nil,nil,nil,{"STRUCTURES","CONTAINERS","COOKING"})
MyAddRecipe("hclr_icelevel2", {Ingredient("gears", 10),Ingredient("cutstone", 10),Ingredient("goldnugget", 20)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_icelevel2.xml", "hclr_icelevel2.tex",nil,nil,nil,nil,{"STRUCTURES","CONTAINERS","COOKING"})

MyAddRecipe("hclr_mulevel1", {Ingredient("boards", 9)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_mulevel1.xml", "hclr_mulevel1.tex",nil,nil,nil,nil,{"STRUCTURES","CONTAINERS"})
MyAddRecipe("hclr_mulevel2", {Ingredient("boards", 30)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_mulevel2.xml", "hclr_mulevel2.tex",nil,nil,nil,nil,{"STRUCTURES","CONTAINERS"})

MyAddRecipe("hclr_kjk", {Ingredient("greengem", 1),Ingredient("beardhair", 3),Ingredient("dug_trap_starfish", 1)}, hclr, TECH.HCLR_TECHTREE_TWO,
nil, nil, true, nil, nil,"images/inventoryimages/hclr_kjk.xml", "hclr_kjk.tex",nil,nil,nil,nil,{"TOOLS","CLOTHING"})



