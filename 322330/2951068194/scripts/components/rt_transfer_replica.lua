---
--- @author zsh in 2023/3/9 9:49
---

local json = require("json")

local function ontransfer_items_need_updatedirty(self, inst)
    --print("客机监听到_transfer_items/_need_update发生了变化");
    local transfer_items = inst.replica.rt_transfer._transfer_items:value();
    --local tmp_test = transfer_items or "";
    --print(string.sub(tmp_test,1,100));
    --print(tostring(tmp_test));
    self.transfer_items = json.decode(transfer_items); -- 解析获得的值
    --print("#self.transfer_items: "..tostring(#self.transfer_items));
    self.need_update = inst.replica.rt_transfer._need_update:value();
end

local Transfer = Class(function(self, inst)
    self.inst = inst;

    self.transfer_items = nil;
    self.need_update = nil;

    self._transfer_items = net_string(inst.GUID, "rt_transfer._transfer_items", "transfer_items_need_updatedirty")
    self._need_update = net_bool(inst.GUID, "rt_transfer._need_update", "transfer_items_need_updatedirty")

    -- 客机设置一个事件监听，用于数据同步
    if not TheWorld.ismastersim then
        inst:ListenForEvent("transfer_items_need_updatedirty", function(inst, data)
            ontransfer_items_need_updatedirty(self, inst);
        end)
    end
end)

---主机组件调用函数，用于主机数据和客机同步
function Transfer:SetData(transfer_items, need_update)
    if TheWorld.ismastersim then
        self._transfer_items:set(transfer_items);
        self._need_update:set(need_update);
    end
end

function Transfer:GetTransferItemsData()
    return self.transfer_items, self.need_update;
end

return Transfer;