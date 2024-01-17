local MINSIZE = 1
local MAXWIDTH, MAXHEIGHT = TheWorld.Map:GetSize()

local AStarPathfinding = Class(function(self, inst)
    self.inst = inst
    self.iscalculating = false
    self.map = {}
    self.openlist = {}
    self.closedlist = {}
end)

function AStarPathfinding:GetNode(tile_x, tile_y)
    if self.map[tile_x] == nil then
        self.map[tile_x] = {}
    end
    if self.map[tile_x][tile_y] == nil then
        self.map[tile_x][tile_y] = {
            list = nil,
            F = nil,
            G = nil,
            H = nil,
            precedent = nil,
            x = tile_x,
            y = tile_y,
        }
    end
    return self.map[tile_x][tile_y]
end

function AStarPathfinding:AddAdjacencyToOpen(current_x, current_y, dest_x, dest_y)
    for i = -1, 1 do
        for j = -1, 1 do
            if MINSIZE <= current_x + i and current_x + i <= MAXWIDTH and
                MINSIZE <= current_y + j and current_y + j <= MAXHEIGHT then
                local node = self:GetNode(current_x + i, current_y + j)
                local tile = TheWorld.Map:GetTile(current_x + i, current_y + j)
                if tile ~= GROUND.IMPASSABLE and tile ~= GROUND.INVALID and
                    not (tile >= GROUND.OCEAN_START and tile <= GROUND.OCEAN_END) and
                    --TheWorld.Map:IsPassableAtPoint(x, y, z, allow_water, exclude_boats) and
                    not (i == 0 and j == 0) then
                    -- Node is not in openlist and closedlist
                    if node.list == nil then
                        -- Define precedent
                        node.precedent = self:GetNode(current_x, current_y)
                        -- G value
                        if math.abs(i) + math.abs(j) == 1 then
                            node.G = node.precedent.G + 10
                        elseif math.abs(i) + math.abs(j) == 2 then
                            node.G = node.precedent.G + 14
                        end
                        -- H value
                        node.H = math.min(math.abs(current_x + i - dest_x), math.abs(current_y + j - dest_y)) * 4 +
                            math.max(math.abs(current_x + i - dest_x), math.abs(current_y + j - dest_y)) * 10
                        -- F value
                        node.F = node.G + node.H
                        -- Add current node to the ascending openlist
                        for index, value in pairs(self.openlist) do
                            local opennode = self:GetNode(value.x, value.y)
                            if node.F <= opennode.F then
                                local coordinate = {x = current_x + i, y = current_y + j}
                                table.insert(self.openlist, index, coordinate)
                                node.list = "open"
                                break
                            end
                        end
                        if node.list == nil then
                            local coordinate = {x = current_x + i, y = current_y + j}
                            table.insert(self.openlist, coordinate)
                            node.list = "open"
                        end
                    -- Node is in openlist
                    elseif node.list == "open" then
                        -- Define precedent
                        local precedent = self:GetNode(current_x, current_y)
                        -- G value
                        local G = node.G
                        if math.abs(i) + math.abs(j) == 1 then
                            G = precedent.G + 10
                        elseif math.abs(i) + math.abs(j) == 2 then
                            G = precedent.G + 14
                        end
                        -- H value
                        local H = node.H
                        -- F value
                        local F = G + H
                        -- Replace previous record with current node, and sort
                        if F < node.F then
                            node.F = F
                            node.precedent = precedent
                            for index, value in pairs(self.openlist) do
                                if node == self:GetNode(value.x, value.y) then
                                    table.remove(self.openlist, index)
                                    for _index, _value in pairs(self.openlist) do
                                        if node.F < self:GetNode(_value.x, _value.y).F then
                                            local coordinate = {x = current_x + i, y = current_y + j}
                                            table.insert(self.openlist, _index, coordinate)
                                            break
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function AStarPathfinding:AddSeaAdjacencyToOpen(current_x, current_y, dest_x, dest_y)
    for i = -1, 1 do
        for j = -1, 1 do
            if MINSIZE <= current_x + i and current_x + i <= MAXWIDTH and
                MINSIZE <= current_y + j and current_y + j <= MAXHEIGHT then
                local node = self:GetNode(current_x + i, current_y + j)
                local tile = TheWorld.Map:GetTile(current_x + i, current_y + j)
                if IsWaterTile(tile) and
                    not (i == 0 and j == 0) then
                    -- Node is not in openlist and closedlist
                    if node.list == nil then
                        -- Define precedent
                        node.precedent = self:GetNode(current_x, current_y)
                        -- G value
                        if math.abs(i) + math.abs(j) == 1 then
                            node.G = node.precedent.G + 10
                        elseif math.abs(i) + math.abs(j) == 2 then
                            node.G = node.precedent.G + 14
                        end
                        -- H value
                        node.H = math.min(math.abs(current_x + i - dest_x), math.abs(current_y + j - dest_y)) * 4 +
                            math.max(math.abs(current_x + i - dest_x), math.abs(current_y + j - dest_y)) * 10
                        -- F value
                        node.F = node.G + node.H
                        -- Add current node to the ascending openlist
                        for index, value in pairs(self.openlist) do
                            local opennode = self:GetNode(value.x, value.y)
                            if node.F <= opennode.F then
                                local coordinate = {x = current_x + i, y = current_y + j}
                                table.insert(self.openlist, index, coordinate)
                                node.list = "open"
                                break
                            end
                        end
                        if node.list == nil then
                            local coordinate = {x = current_x + i, y = current_y + j}
                            table.insert(self.openlist, coordinate)
                            node.list = "open"
                        end
                    -- Node is in openlist
                    elseif node.list == "open" then
                        -- Define precedent
                        local precedent = self:GetNode(current_x, current_y)
                        -- G value
                        local G = node.G
                        if math.abs(i) + math.abs(j) == 1 then
                            G = precedent.G + 10
                        elseif math.abs(i) + math.abs(j) == 2 then
                            G = precedent.G + 14
                        end
                        -- H value
                        local H = node.H
                        -- F value
                        local F = G + H
                        -- Replace previous record with current node, and sort
                        if F < node.F then
                            node.F = F
                            node.precedent = precedent
                            for index, value in pairs(self.openlist) do
                                if node == self:GetNode(value.x, value.y) then
                                    table.remove(self.openlist, index)
                                    for _index, _value in pairs(self.openlist) do
                                        if node.F < self:GetNode(_value.x, _value.y).F then
                                            local coordinate = {x = current_x + i, y = current_y + j}
                                            table.insert(self.openlist, _index, coordinate)
                                            break
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function AStarPathfinding:AddLeastOpenToClosed()
    -- The first node should be the node with the least F.
    local coordinate = table.remove(self.openlist, 1)
    table.insert(self.closedlist, coordinate)
    local node = self:GetNode(coordinate.x, coordinate.y)
    node.list = "closed"
    -- Reach destination
    if node.H == 0 then
        return nil
    end
    return coordinate.x, coordinate.y
end

function AStarPathfinding:GetPath(start_x, start_y, dest_x, dest_y)
    self.iscalculating = true
    -- Starting node
    local startnode = self:GetNode(start_x, start_y)
    startnode.G = 0
    startnode.H = math.min(math.abs(start_x - dest_x), math.abs(start_y - dest_y)) * 4 +
        math.max(math.abs(start_x - dest_x), math.abs(start_y - dest_y)) * 10
    startnode.F = startnode.H

    local coordinate = {x = start_x, y = start_y}
    table.insert(self.openlist, coordinate)

    -- Alter while-do with DoPeriodicTask to smooth the CPU overhead.
    if self.inst.pathfinding_task == nil then
        self.inst.pathfinding_task = self.inst:DoPeriodicTask(FRAMES * TUNING.WXAUTOMATION.PATHFINDING_TIME_STEP, function(inst)
            if next(self.openlist) ~= nil then
                -- Add the node with the least F to the closed list.
                local current_x, current_y = self:AddLeastOpenToClosed()
                if current_x ~= nil and current_y ~= nil then
                    -- Add adjacent nodes to the open list.
                    self:AddAdjacencyToOpen(current_x, current_y, dest_x, dest_y)
                else
                    self.iscalculating = false
                end
            else
                self.iscalculating = false
            end

            if not self.iscalculating then
                local node = self:GetNode(dest_x, dest_y)
                local pointqueue = {}
                if node.precedent ~= nil then
                    while node ~= nil do
                        table.insert(pointqueue, node)
                        node = node.precedent
                    end

                    self.map = {}
                    self.openlist = {}
                    self.closedlist = {}

                    self.inst.components.wxnavigation.pointqueue = pointqueue
                end

                if inst.pathfinding_task ~= nil then
                    inst.pathfinding_task:Cancel()
                    inst.pathfinding_task = nil
                end
            end
        end)
    end
end

function AStarPathfinding:GetSeaPath(start_x, start_y, dest_x, dest_y)
    self.iscalculating = true
    -- Starting node
    local startnode = self:GetNode(start_x, start_y)
    startnode.G = 0
    startnode.H = math.min(math.abs(start_x - dest_x), math.abs(start_y - dest_y)) * 4 +
        math.max(math.abs(start_x - dest_x), math.abs(start_y - dest_y)) * 10
    startnode.F = startnode.H

    local coordinate = {x = start_x, y = start_y}
    table.insert(self.openlist, coordinate)

    -- Alter while do with DoPeriodicTask to smooth the CPU overhead.
    if self.inst.pathfinding_task == nil then
        self.inst.pathfinding_task = self.inst:DoPeriodicTask(FRAMES * TUNING.WXAUTOMATION.PATHFINDING_TIME_STEP, function(inst)
            if next(self.openlist) ~= nil then
                -- Add the node with the least F to the closed list.
                local current_x, current_y = self:AddLeastOpenToClosed()
                if current_x ~= nil and current_y ~= nil then
                    -- Add adjacent nodes to the open list.
                    self:AddSeaAdjacencyToOpen(current_x, current_y, dest_x, dest_y)
                else
                    self.iscalculating = false
                end
            else
                self.iscalculating = false
            end

            if not self.iscalculating then
                local pointqueue = {}
                local node = self:GetNode(dest_x, dest_y)
                if node.precedent ~= nil then
                    while node ~= nil do
                        table.insert(pointqueue, node)
                        node = node.precedent
                    end

                    self.map = {}
                    self.openlist = {}
                    self.closedlist = {}

                    self.inst.components.wxnavigation.pointqueue = pointqueue
                end

                if inst.pathfinding_task ~= nil then
                    inst.pathfinding_task:Cancel()
                    inst.pathfinding_task = nil
                end
            end
        end)
    end
end

--[[for k, v in pairs(pointqueue) do self.inst.components.astarpathfinding:PrintNode(v.x, v.y) end]]
function AStarPathfinding:PrintNode(tile_x, tile_y)
    local node = self:GetNode(tile_x, tile_y)
    if node.G ~= nil and node.H ~= nil and node.F ~= nil then
        print(string.format("Node(%d, %d): List:%s, G:%d, H:%d, F:%d", tile_x, tile_y, node.list, node.G, node.H, node.F))
    else
        print(string.format("Node(%d, %d) has nil value.", tile_x, tile_y))
    end
end

return AStarPathfinding