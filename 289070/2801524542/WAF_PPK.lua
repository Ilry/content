

function PKRevealALL(PlayerID)
    local ObserverID = Game.GetLocalObserver()
    
    if ObserverID == PlayerID then
        PlayerManager.SetLocalObserverTo(PlayerTypes.OBSERVER)    -- 将视角设为观众视角
    else
        PlayerManager.SetLocalObserverTo(PlayerID)    --将视角设为所选玩家
    end
end

ExposedMembers.XPPK = ExposedMembers.XPPK or {}
ExposedMembers.XPPK.PKRevealALL = PKRevealALL
