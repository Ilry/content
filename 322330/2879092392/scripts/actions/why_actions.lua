local EYE_SWAP = Action({priority=3, rmb=true, instant=true, mount_valid=true})
EYE_SWAP.id = "EYE_SWAP"
EYE_SWAP.strfn = function(act)
    local item = (act.invobject ~= nil and act.invobject:IsValid()) and act.invobject or nil
    local equipped = (item ~= nil and act.doer.replica.inventory ~= nil) and act.doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or nil
    if equipped ~= nil and equipped.replica.container ~= nil and equipped.replica.container:IsHolding(item) then
        return "INMASK"
    end
    return "GENERIC"
end
EYE_SWAP.fn = function(act)
    print("enter swap fn")
    local equipped = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if act.invobject == nil or equipped == nil or equipped.components.container == nil then
        return false
    end

    if act.invobject.components.inventoryitem:IsHeldBy(equipped) then
        local item = equipped.components.container:RemoveItem(act.invobject, true, nil, true)

        if item ~= nil then
            item.prevcontainer = nil
            item.prevslot = nil

            act.doer.components.inventory:GiveItem(item, nil, equipped:GetPosition())
            return true
        end
    else
        local cur_item = equipped.components.container:GetItemInSlot(1)

        if cur_item == nil then
            print("enter 333")
            local item = act.invobject.components.inventoryitem:RemoveFromOwner(equipped.components.container.acceptsstacks)
            equipped.components.container:GiveItem(item, 1, nil, false)
            return true
        else
            print("enter 444")
            local item = act.invobject.components.inventoryitem:RemoveFromOwner(equipped.components.container.acceptsstacks)
            local old_item = equipped.components.container:RemoveItemBySlot(1)
            if not equipped.components.container:GiveItem(item, 1, nil, false) then
                act.doer.components.inventory:GiveItem(item, nil, equipped:GetPosition())--, nil, equipped:GetPosition())
            end
            if old_item ~= nil then
                if old_item.prefab == "why_nothingnessgem" then
                    if act.doer.components.debuffable then
                        local mindcontroller = act.doer.components.debuffable:AddDebuff("mindcontroller", "mindcontroller")
                        mindcontroller._level:set(125)
                    end
                end
                if item.prevcontainer ~= nil then
                    print("enter 555")
                    local containeritem = item.prevcontainer.inst.components.container:FindItem(function(i)
                        if i.prefab == old_item.prefab then
                            if i.components.stackable ~= nil and not i.components.stackable:IsFull() then
                                i.components.stackable:SetStackSize(i.components.stackable:StackSize() + 1)
                                print("here?")
                                print(i)
                                print(old_item)
                                old_item:Remove()
                            end
                            return i
                        end
                    end)
                    print(containeritem)
                    if containeritem == nil then
                        item.prevcontainer.inst.components.container:GiveItem(old_item, item.prevslot)
                    end
                else
                    print("enter 666")
                    local invitem = act.doer.components.inventory:FindItem(function(i)
                        if i.prefab == old_item.prefab then
                            if i.components.stackable ~= nil and not i.components.stackable:IsFull() then
                                i.components.stackable:SetStackSize(i.components.stackable:StackSize() + 1)
                                print("or here?")
                                print(old_item)
                                old_item:Remove()
                            end
                            return i
                        end
                    end)
                    print(invitem)
                    if invitem == nil then
                        act.doer.components.inventory:GiveItem(old_item, item.prevslot)
                    end
                end
            end
            return true
        end

        return true
    end
    return false
end

AddAction(EYE_SWAP)

local eye_put_on_name,eye_put_down_name
if TUNING.WHY_LANGUAGE == "spanish" then
    eye_put_on_name = "Equipar"
    eye_put_down_name = "Desequipar"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    eye_put_on_name = "佩戴"
    eye_put_down_name = "卸下"
else
    eye_put_on_name = "Socket"
    eye_put_down_name = "Unsocket"
end
STRINGS.ACTIONS.EYE_SWAP = {
    GENERIC = eye_put_on_name,
    INMASK = eye_put_down_name
}

AddComponentAction("INVENTORY","inventoryitem", function(inst, doer, actions, right)
    if doer.replica.inventory ~= nil then
        local equipped = doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if equipped ~= nil and equipped:HasTag("whyehat") and equipped.replica.container ~= nil then
            if equipped.replica.container:CanTakeItemInSlot(inst) then
                table.insert(actions, ACTIONS.EYE_SWAP)
            end
        end
    end
end)