local GetPrefab = require("mym_utils/getprefab")

local function onenable(self, enable)
    if enable then
        self.inst:AddTag("multithruster")
    else
        self.inst:RemoveTag("multithruster")
    end
end

local Multithruster = Class(function(self, inst)
    self.inst = inst

    self.enable = false    --是否启用

    self.disableTask = nil --时间约束
    self.count = 0         --次数约束
end, nil, {
    enable = onenable
})

function Multithruster:Disable()
    self.enable = false

    self.count = 0
    if self.disableTask then
        self.disableTask:Cancel()
        self.disableTask = nil
    end
end

local function Disable(inst, self)
    self:Disable()
end

function Multithruster:Start(time, count)
    self.enable = true

    if self.disableTask then
        self.disableTask:Cancel()
        self.disableTask = nil
    end
    if time then
        -- 时间约束
        self.disableTask = self.inst:DoTaskInTime(time, Disable, self)
    end
    if count then
        self.count = count
    end
end

local CANT_ATTACK_TAGS = { "invisible", "player", "companion" }

--- 攻击,target只是当前攻击对象，范围攻击需要手动实现
function Multithruster:DoThrust(doer, target)
    if not doer.components.combat then return end

    GetPrefab.DoArcAttack(doer, {
        arc = 80,
        CANT_TAGS = CANT_ATTACK_TAGS,
        validfn = GetPrefab.ForceTargetTest
    })
end

function Multithruster:StartThrusting(doer)
    if doer.components.bloomer then
        doer.components.bloomer:PushBloom("multithruster", "shaders/anim.ksh", -2)
    end
    if doer.components.colouradder then
        doer.components.colouradder:PushColour("multithruster", 1, 1, 0, 0)
    end
    return true
end

function Multithruster:StopThrusting(doer)
    if doer.components.colouradder then
        doer.components.colouradder:PopColour("multithruster")
    end
    if doer.components.bloomer then
        doer.components.bloomer:PopBloom("multithruster")
    end

    -- 次数约束
    if self.count > 0 then
        self.count = self.count - 1
        if self.count <= 0 then
            self:Disable()
        end
    end
end

function Multithruster:OnSave()
    return {
        enable = self.enable,
        disableTask = self.disableTask and GetTaskRemaining(self.disableTask) or nil
    }
end

function Multithruster:OnLoad(data)
    if not data then return end

    if data.enable then
        self.enable = true
        self.disableTask = data.disableTask and self.inst:DoTaskInTime(data.disableTask, Disable, self) or nil
        self.count = data.count or self.count
    end
end

return Multithruster
