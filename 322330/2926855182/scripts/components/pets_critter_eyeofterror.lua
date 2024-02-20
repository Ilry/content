---
--- @author zsh in 2023/1/31 10:57
---

local API = require("pets_enhancement.API");

local CE = Class(function(self, inst)
    self.inst = inst;

    if TheWorld and TheWorld.components and TheWorld.components.pets_world_container
            and inst and inst:IsValid() then
        TheWorld.components.pets_world_container.chests[inst] = true;

        inst:ListenForEvent("onremove", function(inst, data)
            TheWorld.components.pets_world_container.chests[inst] = nil;
        end);
    end
end)

function CE:Lock()
    if not (TheWorld and TheWorld.components and TheWorld.components.pets_world_container) then
        return ;
    end

    TheWorld.components.pets_world_container.chestopened = true;

    local chests = TheWorld.components.pets_world_container.chests or {};

    for k, v in pairs(chests) do
        -- 上下地洞的话，k 还会不会存在？
        if k and k.entity and k.entity:IsValid() and v then
            if self.inst ~= k then
                k.components.container.canbeopened = nil;
                k.components.inspectable:SetDescription("你的小伙伴正在使用哦~");

                API.transferContainerAllItems(k, self.inst);
            end
        end
    end

end

function CE:Unlock()
    if not (TheWorld and TheWorld.components and TheWorld.components.pets_world_container) then
        return ;
    end

    TheWorld.components.pets_world_container.chestopened = false;

    local chests = TheWorld.components.pets_world_container.chests or {};

    for k, v in pairs(chests) do
        if v then
            k.components.container.canbeopened = true;
            k.components.inspectable:SetDescription(nil);
        end
    end

end


return CE;