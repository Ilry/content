ExposedMembers.GameEvents = GameEvents;

-- Build the item on top of the queue.
function OnBuildRequest(playerId, cityId, isBuilt, progress)
    local city = CityManager.GetCity(playerId, cityId);
    local cityBuildQueue = city:GetBuildQueue();
    if isBuilt then
        cityBuildQueue:FinishProgress();
    else
        cityBuildQueue:AddProgress(progress);
    end
    GameEvents.MD_BuildRequestFinished.Call();
end

function OnRemoveDistrict(playerId, cityId, districtIndex)
    local city = CityManager.GetCity(playerId, cityId);
    local cityDistricts = city:GetDistricts();
    cityDistricts:RemoveDistrict(districtIndex);
end

function OnChangeGold(playerId, delta)
    local player = Players[playerId];
    player:GetTreasury():ChangeGoldBalance(delta);
end

GameEvents.MD_BuildRequest.Add(OnBuildRequest);
GameEvents.MD_RemoveDistrict.Add(OnRemoveDistrict);
GameEvents.MD_ChangeGold.Add(OnChangeGold);