GLOBAL.setmetatable(env, {
  __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end
})
modimport("scripts/apis.lua")
local mod_prefix = "gallopweapon"
local script_prefix = mod_prefix .. "_"
function import(x, _env)
  local file = resolvefilepath_soft("scripts/" .. script_prefix .. x .. ".lua")
  if not file then
    print("error: no such file", x)
    return nil
  end
  local fn = kleiloadlua(file)
  if type(fn) == "function" then
    setfenv(fn, _env or env)
    print("loaded ", x)
    return fn()
  else
    print("error: invalid file", x)
    return nil
  end
end
function demand(x)
  local ret = package.loaded[script_prefix .. x] or import(x)
  package.loaded[script_prefix .. x] = ret
  return ret
end
PrefabFiles = {
  "gallop_breaker", "gallopweapon_fx", "gallop_whip", 
  "gallopweapon_reticule", "gallop_bloodaxe_fx", "gallop_laser","gallop_shadow_pillar"
}
currentlang="zh"
local r = require("register_inventoryimages")
r("images/gallopweapon_inventoryimages.xml")
Assets = {
  Asset("IMAGE", "images/gallopweapon_inventoryimages.tex"),
  Asset("ATLAS", "images/gallopweapon_inventoryimages.xml"),
  Asset("ATLAS_BUILD", "images/gallopweapon_inventoryimages.xml", 256)
}
import("recipes")
local TuningHack = {}
setmetatable(TuningHack, {
  __index = function(_, k)
    if k == nil then return nil end
    if type(k) == "string" and TUNING[string.upper(k)] then
      TuningHack[k] = TUNING[string.upper(k)]
      return TuningHack[k]
    else
      return env[k]
    end
  end
})
local tuning = import("tuning", TuningHack)
table.mergeinto(TUNING, tuning, true)
local function cpy(t)
    local r={}
    for k,v in pairs(t) do
        if type(v)=="table" then r[k]=cpy(v) end
    end
    return r
end
STRINGS.CHARACTERS.GALLOP=STRINGS.CHARACTERS.GALLOP or cpy(require("speech_wilson"))
--九头蛇、提亚马特相关
modimport("scripts/gallop_h_t.lua")
modimport("scripts/lol_heartsteel.lua")







STRINGS.NAMES.GALLOP_WHIP = "铁刺鞭"
STRINGS.RECIPE_DESC.GALLOP_WHIP = "用尖刺鞭打！"
STRINGS.ACTIONS.CASTAOE.GALLOP_BLOODAXE = "饥渴斩击"
STRINGS.NAMES.GALLOP_BLOODAXE = "渴血战斧"
STRINGS.RECIPE_DESC.GALLOP_BLOODAXE = "砍断！切开！剁碎！"
STRINGS.ACTIONS.CASTAOE.GALLOP_BREAKER = "跃浪击"
STRINGS.ACTIONS.GALLOP_BREAKER = "切换模式"
STRINGS.NAMES.GALLOP_BREAKER = "破舰者"
STRINGS.RECIPE_DESC.GALLOP_BREAKER = "这波不活了啊兄弟们！"
STRINGS.CHARACTERS.GENERIC.ANNOUNCE_BREAKER = "爆破！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GALLOP_BREAKER =
  "用它来砍树很有节奏感。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GALLOP_WHIP =
  "绑在链条上的十字镐。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GALLOP_BLOODAXE = "它在吸我的血！"

TUNING.GALLOPBREAKMUSIC_ENABLED = GetConfig("gallopbreakermusic")
-- shadow level
local levels = {gallop_dreadclub = 2, gallop_breaker = 1, gallop_bloodaxe = 2}
setmetatable(levels, {__index = function(_, k) return 0 end})
utils.prefabs(table.getkeys(levels), function(inst)
  -- shadowlevel (from shadowlevel component) added to pristine state for optimization
  inst:AddTag("shadowlevel")
  if not TheWorld.ismastersim then return end
  if not inst.components.shadowlevel then
    inst:AddComponent("shadowlevel")
    inst.components.shadowlevel:SetDefaultLevel(levels[inst.prefab])
  end
end)
-- gallop breaker min absorb
local Inventory = require("components/inventory")
local ApplyDamage = Inventory.ApplyDamage
local SpDamageUtil = require("components/spdamageutil")

function Inventory:ApplyDamage(damage, attacker, weapon, spdamage)
  local ApplyDamage = ApplyDamage
  local absorbers = {}
  local damagetypemult = 1
  for k, v in pairs(self.equipslots) do
    -- check resistance
    if v.components.resistance ~= nil and
      v.components.resistance:HasResistance(attacker, weapon) and
      v.components.resistance:ShouldResistDamage() then
      v.components.resistance:ResistDamage(damage)
      return 0, nil
    elseif v.components.armor ~= nil then
      absorbers[v.components.armor] = v.components.armor:GetAbsorption(attacker,
                                                                       weapon)
    end
    if v.components.damagetyperesist ~= nil then
      damagetypemult = damagetypemult *
                         v.components.damagetyperesist:GetResist(attacker,
                                                                 weapon)
    end
  end

  damage = damage * damagetypemult
  -- print("Incoming damage", damage)

  local absorbed_percent = self.gallop_breaker_absorb or 0
  local total_absorption = 0
  for armor, amt in pairs(absorbers) do
    -- print("\t", armor.inst, "absorbs", amt)
    absorbed_percent = math.max(amt, absorbed_percent)
    total_absorption = total_absorption + amt
  end

  local absorbed_damage = damage * absorbed_percent
  local leftover_damage = damage - absorbed_damage

  -- print("\tabsorbed%", absorbed_percent, "total_absorption", total_absorption, "absorbed_damage", absorbed_damage, "leftover_damage", leftover_damage)

  local armor_damage = {}
  if total_absorption > 0 then
    ProfileStatsAdd("armor_absorb", absorbed_damage)

    for armor, amt in pairs(absorbers) do
      armor_damage[armor] = absorbed_damage * amt / total_absorption +
                              armor:GetBonusDamage(attacker, weapon)
    end
  end

  -- Apply special damage
  if spdamage ~= nil then
    for sptype, dmg in pairs(spdamage) do
      dmg = dmg * damagetypemult
      local spdefenders = {}
      local count = 0
      for eslot, equip in pairs(self.equipslots) do
        local def = SpDamageUtil.GetSpDefenseForType(equip, sptype)
        if def > 0 then
          count = count + 1
          spdefenders[equip] = def
        end
      end
      while dmg > 0 and count > 0 do
        local splitdmg = dmg / count
        for k, v in pairs(spdefenders) do
          local defended
          if v > splitdmg then
            defended = splitdmg
            spdefenders[k] = v - splitdmg
          else
            defended = v
            spdefenders[k] = nil
            count = count - 1
          end
          dmg = dmg - defended
          local armor = k.components.armor
          if armor ~= nil then
            armor_damage[armor] = (armor_damage[armor] or 0) + defended
          end
        end
      end
      spdamage[sptype] = dmg > 0 and dmg or nil
    end
    if next(spdamage) == nil then spdamage = nil end
  end

  -- Apply armor durability loss
  for armor, dmg in pairs(armor_damage) do armor:TakeDamage(dmg) end

  return leftover_damage, spdamage
end
-- dreadclub upgrade
UPGRADETYPES.GALLOP_DREADCLUB = "gallop_dreadclub"
local function CompensateDreadClub()
  MapDict(Ents, function(guid, ent)
    local u = ent.components.upgradeable
    if u and ent.prefab == "gallop_dreadclub" then
      u.upgradetype = UPGRADETYPES.GALLOP_DREADCLUB
    end
  end)
end
local function CompensatePlayer(oldtype)
  MapDict(AllPlayers, function(i, ent)
    if ent:HasTag("gallop") then
      ent:RemoveTag(oldtype .. "_upgradeuser")
      ent:AddTag(UPGRADETYPES.GALLOP_DREADCLUB .. "_upgradeuser")
    end
  end)
end
if IsServer() then
  utils.prefab("shadowheart", function(inst)
    local upgrader = inst.components.upgrader or inst:AddComponent("upgrader")
    if upgrader then
      local type = upgrader.upgradetype
      if type and type ~= UPGRADETYPES.GALLOP_DREADCLUB then
        local oldtype = UPGRADETYPES.GALLOP_DREADCLUB
        UPGRADETYPES.GALLOP_DREADCLUB = type
        CompensateDreadClub()
        CompensatePlayer(oldtype)
      else
        upgrader.upgradetype = UPGRADETYPES.GALLOP_DREADCLUB
      end
    end
  end)
end
local AddLoot = require("common_addloot").AddLoot
utils.prefab("minotaur", AddLoot({{"gallop_breaker_blueprint", 1}}))
-- useitem str
local useitem_stroverridefn = ACTIONS.USEITEM.stroverridefn or function() end
ACTIONS.USEITEM.stroverridefn = useitem_stroverridefn and function(act)
  local obj = act.invobject
  if obj and obj.stroverridefn then
    local str = obj:stroverridefn(act)
    if str then return str end
  end
  return useitem_stroverridefn(act)
end
-- axe aoe
local CASTAOE_stroverridefn = ACTIONS.CASTAOE.stroverridefn or function() end
function ACTIONS.CASTAOE.stroverridefn(act, ...)
  local inv = act.invobject
  if inv and inv.stroverridefn then
    local ret = inv:stroverridefn(act)
    if ret then return ret end
  end
  return CASTAOE_stroverridefn(act, ...)
end
-- 旺达回血
utils.prefab("wanda", function(inst)
  if inst.components.oldager then
    inst.components.oldager:AddValidHealingCause("gallop_bloodaxe")
  end
end)
utils.sim(function()
  local _1, v, _ = UPVALUE.get(EntityScript.CollectActions, "COMPONENT_ACTIONS")
  if not v then
    _1, v, _ = UPVALUE.get(EntityScript.IsActionValid, "COMPONENT_ACTIONS")
  end
  if v then
    local SCENE = v.SCENE
    if SCENE then
      local SCENE_inventoryitem_fn = SCENE.inventoryitem
      SCENE.inventoryitem = function(inst, doer, actions, right)
        if doer:HasTag("rabbitfriendly") and inst.prefab == "rabbit" and
          doer.replica.inventory ~= nil and
          (doer.replica.inventory:GetNumSlots() > 0 or inst.replica.equippable ~=
            nil) and (right or not inst:HasTag("heavy")) then
          table.insert(actions, ACTIONS.PICKUP)
        end
        return SCENE_inventoryitem_fn(inst, doer, actions, right)
      end
    end
    local USEITEM = v.USEITEM
    if USEITEM then
      local USEITEM_repairer_fn = USEITEM.repairer
      if USEITEM_repairer_fn then
        USEITEM.repairer = function(inst, doer, target, actions, right, ...)
          if right then
            if doer.replica.rider ~= nil and doer.replica.rider:IsRiding() then
              if not (target.replica.inventoryitem ~= nil and
                target.replica.inventoryitem:IsGrandOwner(doer)) then
                return USEITEM_repairer_fn(inst, doer, target, actions, right,
                                           ...)
              end
            elseif doer.replica.inventory ~= nil and
              doer.replica.inventory:IsHeavyLifting() then
              return
                USEITEM_repairer_fn(inst, doer, target, actions, right, ...)
            end
            if target:HasTag("repairable_any") then
              for k, v2 in pairs(MATERIALS) do
                if inst:HasTag("work_" .. v2) or
                  inst:HasTag("finiteuses_" .. v2) or
                  inst:HasTag("health_" .. v2) or inst:HasTag("freshen_" .. v2) then
                  table.insert(actions, ACTIONS.REPAIR)
                end
              end
            end
          end
          return USEITEM_repairer_fn(inst, doer, target, actions, right, ...)
        end
      end
    end
  end
end)
utils.sg("wilson", function(sg)
  -- cast aoe hack
  local castaoehandler = sg.actionhandlers[ACTIONS.CASTAOE]
  if castaoehandler then
    local _castaoe_actionhandler = castaoehandler.deststate
    castaoehandler.deststate = function(inst, action, ...)
      if action.invobject ~= nil and
        (action.invobject:HasTag("aoeweapon_leap") and
          action.invobject:HasTag("gallopsuperjump")) and
        not action.invobject:HasTag("depleted") then
        return "gallop_superjump_pre"
      end
      if action.invobject ~= nil and action.invobject:HasTag("play_strum") and
        not action.invobject:HasTag("depleted") then return "play_strum" end
      if action.invobject ~= nil and
        action.invobject:HasTag("cast_like_pocketwatch") and
        not action.invobject:HasTag("depleted") then
        -- compensate for the specific sg
        -- action.invobject:PushEvent("willenternewstate",
        --                           {state = "dojostleaction"})
        return "dojostleaction"
      end
      return _castaoe_actionhandler(inst, action, ...)
    end
  end
end)
utils.sg("wilson_client", function(sg)
  -- cast aoe hack
  local castaoehandler = sg.actionhandlers[ACTIONS.CASTAOE]
  if castaoehandler then
    local _castaoe_actionhandler = castaoehandler.deststate
    castaoehandler.deststate = function(inst, action, ...)
      if action.invobject ~= nil and
        (action.invobject:HasTag("aoeweapon_leap") and
          action.invobject:HasTag("gallopsuperjump")) and
        not action.invobject:HasTag("depleted") then
        return "gallop_superjump_pre"
      end
      if action.invobject ~= nil and action.invobject:HasTag("play_strum") and
        not action.invobject:HasTag("depleted") then return "play_strum" end
      if action.invobject ~= nil and
        action.invobject:HasTag("cast_like_pocketwatch") and
        not action.invobject:HasTag("depleted") then
        -- compensate for the specific sg
        -- action.invobject:PushEvent("willenternewstate",
        --                           {state = "dojostleaction"})
        return "dojostleaction"
      end
      return _castaoe_actionhandler(inst, action, ...)
    end
  end
end)
-- crafting menu show character recipes
local shown_recipes={gallop_whip=true,gallop_bloodaxe=true,gallop_breaker=true,gallop_hydra=true,gallop_tiamat=true,lol_heartsteel=true}
local function IsCharacterRecipe(recipe)
  return shown_recipes[recipe.name or ""]
end
utils.require("widgets/redux/craftingmenu_hud", function(self)
  local RebuildRecipes = self.RebuildRecipes
  function self:RebuildRecipes()
    RebuildRecipes(self)
    if self.owner ~= nil and self.owner.replica.builder ~= nil then
      for k, recipe in pairs(AllRecipes) do
        if IsRecipeValid(recipe.name) then
          local should_hint_recipe = IsCharacterRecipe(recipe)
          if should_hint_recipe and self.valid_recipes[recipe.name] then
            local meta = self.valid_recipes[recipe.name].meta
            if meta.build_state == "hide" then
              meta.build_state = "hint"
            end
          end
        end
      end
    end
  end
end)
MATERIALS.FLINT = MATERIALS.FLINT or "flint"
utils.prefab("flint",function(inst)
  if not TheWorld.ismastersim then return false end
  if not inst.components.repairer then inst:AddComponent("repairer") end
  inst.components.repairer.repairmaterial = MATERIALS.FLINT
  inst.components.repairer.finiteusesrepairvalue = 1
end)