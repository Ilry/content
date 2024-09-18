
		
		STRINGS.NAMES.CHARM_BEE = "工作蜜蜂"
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.CHARM_BEE = "为主人收集散落各处的物品"	
		
		local charm_bee_hunt = Action()  
charm_bee_hunt.id = "CHARM_BEE_HUNT"
charm_bee_hunt.str = "CHARM_BEE_HUNT"
charm_bee_hunt.fn = function(act)



	if act.doer and act.target then
		if act.doer.components.follower.leader and act.doer.components.follower.leader.components.inventory then
            if act.target.components.inventoryitem  and
            act.target.components.inventoryitem.canbepickedup and
            act.target.components.inventoryitem.cangoincontainer and
            not act.target.components.inventoryitem:IsHeld()  then
				act.target.ischarm_bee_hunt=false
				act.doer.components.follower.leader.components.inventory:GiveItem(act.target)
				return true
            end
			
		else
		
		act.doer.components.talker:Say("什么鬼？")
		end
		return false
	end
end
AddAction(charm_bee_hunt)