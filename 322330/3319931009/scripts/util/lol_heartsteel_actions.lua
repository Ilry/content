
local function TouchFn(item)
	if item.components and item.components.lol_heartsteel_num then
		item.components.lol_heartsteel_num:TouchSound()
	end
end

local actions = {
	{
		id = "ACTION_LOL_HEARTSTEEL_TOUCH_ININV",
		str = STRINGS.LOL_HEARTSTEEL.ACTIONS.ACTION_LOL_HEARTSTEEL_TOUCH,
		fn = function(act)
			if act.doer ~= nil and act.invobject ~= nil then
                TouchFn(act.invobject)
                return true
            else
				return false
			end
		end,
		state = "give",
		actiondata = {
			priority = 99,
			mount_valid = true,
		},
	},
	{
		id = "ACTION_LOL_HEARTSTEEL_TOUCH_ONGROUND",
		str = STRINGS.LOL_HEARTSTEEL.ACTIONS.ACTION_LOL_HEARTSTEEL_TOUCH,
		fn = function(act)
			if act.doer ~= nil and act.target ~= nil then
                TouchFn(act.target)
                return true
            else
				return false
			end
		end,
		state = "give",
		actiondata = {
			priority = 99,
			mount_valid = true,
		},
	},
}

local component_actions = {
	{
		type = "INVENTORY",
		component = "inventoryitem",
		tests = {
			{
				action = "ACTION_LOL_HEARTSTEEL_TOUCH_ININV",
				testfn = function(inst,doer,actions,right)
					return doer:HasTag("player") and inst.prefab == 'lol_heartsteel' 
				end,
			},
		},
	},
	{
		type = "SCENE",
		component = "inventoryitem",
		tests = {
			{
				action = "ACTION_LOL_HEARTSTEEL_TOUCH_ONGROUND",
				testfn = function(inst,doer,actions,right)
					return right and doer:HasTag("player") and inst.prefab == 'lol_heartsteel'
				end,
			},
		},
	},
}

for _,act in pairs(actions) do
    local addaction = AddAction(act.id,act.str,act.fn)
    if act.actiondata then
        for k,v in pairs(act.actiondata) do
            addaction[k] = v
        end
    end

    AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(addaction, act.state))
    AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(addaction,act.state))
end

for _,v in pairs(component_actions) do
    local testfn = function(...)
        local actions = GLOBAL.select(v.type=="POINT" and -3 or -2,...)
        for _,data in pairs(v.tests) do
            if data and data.testfn and data.testfn(...) then
                data.action = string.upper(data.action)
                table.insert(actions,GLOBAL.ACTIONS[data.action])
            end
        end
    end
    AddComponentAction(v.type, v.component, testfn)
end