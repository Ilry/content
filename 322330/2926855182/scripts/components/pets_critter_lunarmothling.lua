---
--- @author zsh in 2023/2/27 21:05
---

-- 2023-02-28-00:56：说明一下，其实我的类的作用和 require 差别不大。。。
-- 因为我并没有降低耦合，各种逻辑并不是全写在类中。。。这样其实问题很大。。。

local Lunarmothling = Class(function(self, inst)
    self.inst = inst;

    self.ori_sanity = nil;

    self.state = false; -- 是否生效过
    self.moonisland = false; -- 是否一直在月岛
end);


function Lunarmothling:TakeEffect()
    if self.state then
        -- DoNothing
        return;
    end
    local inst = self.inst;
    self.ori_sanity = inst.components.sanity.current;
    inst.components.sanity.current = 1;
    self.state = true;
end

function Lunarmothling:TakeEffectReset()
    local inst = self.inst;
    --self.ori_sanity = inst.components.sanity.current;
    inst.components.sanity.current = 1;
    self.state = true;
end

function Lunarmothling:RemoveEffect()
    if not self.state then
        -- DoNothing
        return ;
    end
    local inst = self.inst;
    if self.ori_sanity == nil then
        print("ChangError: self.ori_sanity == nil???");
        return ;
    end
    inst.components.sanity.current = self.ori_sanity;
    self.state = false;
end

function Lunarmothling:OnSave()
    return {
        ori_sanity = self.ori_sanity;
        state = self.state;
    }
end

function Lunarmothling:OnLoad(data)
    if data then
        if data.ori_sanity then
            self.ori_sanity = data.ori_sanity;
        end

        -- ~= nil 可以避免 bool 型导致的问题！
        if data.state ~= nil then
            self.state = data.state;
        end
    end
end

return Lunarmothling;