---
--- @author zsh in 2023/1/31 11:02
---


local Container = Class(function(self, inst)
    self.inst = inst;

    self.chests = {};

    -- 不能这样，这样问题就大了。因为地上地下是两个进程！
    --self.inst:DoTaskInTime(0, function(inst)
    --    self.chests.proxy = SpawnPrefab("critter_eyeofterror"); -- 按道理一个普通容器预制物就行了
    --end)

    self.chestopened = nil;

end)

return Container;