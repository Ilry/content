local ACTIONS = GLOBAL.ACTIONS
local ActionHandler = GLOBAL.ActionHandler
local id = "UPGRADECONTAINER" --必须大写，动作会被加入到ACTIONS表中，key就是id。
local name = "upgrade" --随意，会在游戏中能执行动作时，显示出动作的名字
local function getstatus(inst, viewer)
	return inst._chestupgrade_stacksize and "UPGRADED_STACKSIZE" or nil
end
local fn = function(act) -- 动作触发的函数。传入的是一个BufferedAction对象。可以通过它直接调用动作的执行者，目标，具体的动作内容等等，详情请查看bufferedaction.lua文件，也可以参考actions.lua里各个action的fn。
	local target = act.target
	if target.components.container ~= nil then
		target.components.container:Close()
		target.components.container:EnableInfiniteStackSize(true)
		target:RemoveTag("upgradecontainer")
		target.components.inspectable.getstatus = getstatus
	end
	local x, y, z = target.Transform:GetWorldPosition()
    local fx = SpawnPrefab("chestupgrade_stacksize_taller_fx")
    fx.Transform:SetPosition(x, y, z)
    return true
end
local UPGRADECONTAINER=AddAction(id,name,fn)
GLOBAL.ACTIONS.UPGRADECONTAINER.priority = 1
UPGRADECONTAINER.rmb = true
UPGRADECONTAINER.canqueuer = "allclick"
--动作兼容行为排队论
--UPGRADECONTAINER.canforce=true
--UPGRADECONTAINER.instant = true
local type = "USEITEM" -- 设置动作绑定的类型
local component = "upgrader" -- 设置动作绑定的组件
local testfn = function(inst, doer, target, actions, right) -- 设置动作的检测函数，如果满足条件，就向人物的动作可执行表中加入某个动作。right表示是否是右键动作。
	if target:HasTag("upgradecontainer")
	and inst:HasTag(UPGRADETYPES.CHEST.."_upgrader")
	then
		table.insert(actions, ACTIONS.UPGRADECONTAINER)
		return
	end
end
AddComponentAction(type, component, testfn)
local state = "doshortaction" -- 设定要绑定的state dostandingaction,doshortaction,dolongaction，dojostleaction
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.UPGRADECONTAINER, state))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.UPGRADECONTAINER,state))
