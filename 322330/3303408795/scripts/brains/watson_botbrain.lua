require "behaviours/doaction"
require "behaviours/faceentity"
require "behaviours/leash"
require "behaviours/wander"


-----------------------------------------------------------------------------------------

local WatsonBotBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

-----------------------------------------------------------------------------------------

local function GetLeaderPosition(inst)
    local leader = inst.components.follower.leader
    local owner = leader ~= nil and leader.components.inventoryitem ~= nil and leader.components.inventoryitem:GetGrandOwner() or nil
    if owner ~= nil and owner:HasTag("pocketdimension_container") then
        return nil
    end
    return leader ~= nil and leader:GetPosition() or nil
end

-----------------------------------------------------------------------------------------

function WatsonBotBrain:OnStart()
    local root = PriorityNode({
        WhileNode(function() return not self.inst.sg:HasStateTag("scanned") end, "While Not Finished",
            PriorityNode({
                Leash(self.inst, GetLeaderPosition, 0.5, 1), -- (self, inst, homelocation, max_dist, inner_return_dist, running)
                StandStill(self.inst),
            }, 1)
        )
    }, 1)

    self.bt = BT(self.inst, root)
end

return WatsonBotBrain