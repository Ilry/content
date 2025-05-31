local ACTIONS = GLOBAL.ACTIONS
local ActionHandler = GLOBAL.ActionHandler
local id = "COMBINEFRESH" --必须大写，动作会被加入到ACTIONS表中，key就是id。
local name = STRINGS.RANDCSTRINGS[2] --随意，会在游戏中能执行动作时，显示出动作的名字
local fn = function(act) -- 动作触发的函数。传入的是一个BufferedAction对象。可以通过它直接调用动作的执行者，目标，具体的动作内容等等，详情请查看bufferedaction.lua文件，也可以参考actions.lua里各个action的fn。
	local target = act.target
	local inst = act.invobject
	local recipe = AllRecipes[target.prefab]--绕开食谱
	--local amount = 0
	if recipe == nil or FunctionOrValue(recipe.no_deconstruction, target) then
        return
    end
	if target.components.perishable ~= nil and inst.components.perishable ~= nil then
		target.components.perishable:SetPercent(math.min(1,target.components.perishable:GetPercent()+inst.components.perishable:GetPercent()))
		--target:PushEvent("percentusedchange", { percent = target.components.perishable:GetPercent() })
		if TUNING.RANGCCOFINITEUSES ~= 0 then
			target.components.perishable.combinetime = inst.components.perishable.combinetime + target.components.perishable.combinetime
			if target.components.perishable.combinetime >= TUNING.RANGCCOFINITEUSES then
				target:AddTag("hide_percentage")
				target.components.perishable:StopPerishing()
				target:RemoveTag("show_spoilage")
			end
		end
	end
	inst:Remove()
    return true
end
local COMBINEFRESH=AddAction(id,name,fn)
if TUNING.RANGCHIGHPRIOR then
COMBINEFRESH.priority = 11
end
COMBINEFRESH.rmb = true
--COMBINEFRESH.canforce=true
--COMBINEFRESH.instant = true
local type = "USEITEM" -- 设置动作绑定的类型
local component = "perishable" -- 设置动作绑定的组件
local testfn = function(inst, doer, target, actions, right) -- 设置动作的检测函数，如果满足条件，就向人物的动作可执行表中加入某个动作。right表示是否是右键动作。
	if 
	target.prefab == inst.prefab
	then
		table.insert(actions, ACTIONS.COMBINEFRESH)
	end
end
AddComponentAction(type, component, testfn)
local state = "dolongaction" -- 设定要绑定的state dostandingaction,doshortaction,dolongaction，dojostleaction
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.COMBINEFRESH, state))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.COMBINEFRESH,state))

--[[referance
local ACTIONS = GLOBAL.ACTIONS
local ActionHandler = GLOBAL.ActionHandler
local id = "PUNCHTREE" --必须大写，动作会被加入到ACTIONS表中，key就是id。
local name = "徒手砍树" --随意，会在游戏中能执行动作时，显示出动作的名字
local fn = function(act) -- 动作触发的函数。传入的是一个BufferedAction对象。可以通过它直接调用动作的执行者，目标，具体的动作内容等等，详情请查看bufferedaction.lua文件，也可以参考actions.lua里各个action的fn。
    if act.target.components.workable ~= nil and
        act.target.components.workable:CanBeWorked() and
        act.target.components.workable.action == ACTIONS.CHOP then
        act.target.components.workable:WorkedBy(act.doer,1)
        return true
    end
end
AddAction(id,name,fn) -- 将上面编写的内容传入MOD API,添加动作
local type = "SCENE" -- 设置动作绑定的类型
    SCENE：参数inst, doer, actions, right。这一场景指的是在游戏主界面上对着实体的操作。比如右键点击收获浆果。
	USEITEM：参数inst, doer, target, actions, right。这一场景是选取一件物品，再点击地图上的东西或装备栏的物品，比如给篝火添加燃料
	POINT：参数inst, doer, pos, actions, right。这一场景指的是对地图上任意一点执行的操作，比如装备传送法杖后，你可以右键点击地板，传送过去。
	EQUIPPED：参数inst, doer, target, actions, right。这一场景指的是装备了一件物品后，可以实施的操作，比如装备斧头后可以砍树。INVENTORY：参数inst, doer, actions, right。这一场景是点击物品栏执行的操作。比如右键点击物品栏里的木甲，就会自动装备到身上。
	ISVALID：参数inst, action, right。这个不是定义的场景，是用于检测动作是否合法的，我们可以忽略它。
local component = "workable" -- 设置动作绑定的组件
local testfn = function(inst, doer, actions, right) -- 设置动作的检测函数，如果满足条件，就向人物的动作可执行表中加入某个动作。right表示是否是右键动作。
    if inst:HasTag("CHOP_workable") and doer:HasTag("player") then
        table.insert(actions, ACTIONS.PUNCHTREE)
    end
end
AddComponentAction(type, component, testfn)
local state = "dojostleaction" -- 设定要绑定的state
AddStategraphActionHandler("wilson",ActionHandler(ACTIONS.PUNCHTREE, state))
AddStategraphActionHandler("wilson_client",ActionHandler(ACTIONS.PUNCHTREE,state))
]]--