TheInput=GLOBAL.TheInput
TheNet=GLOBAL.TheNet
TheFrontEnd=GLOBAL.TheFrontEnd

local K=GetModConfigData("KEY")
local IsDefault=(K=="DEFAULT" or K=="Ctrl" or K=="") --Для совместимости
local KEY=IsDefault and -1 or GLOBAL["KEY_"..K]

DragObjects={}

AddModRPCHandler(modname,"DRAG",function(player,down,entity,mx,mz)
    if TheNet:GetClientTableForUser(player.userid).admin then
        if down then
            local x,y,z=entity.Transform:GetWorldPosition()
            local offset={x=x-mx,z=z-mz}
            DragObjects[player.userid]={entity=entity,offset=offset}
        else
            DragObjects[player.userid]=nil
        end
    end
end)

AddModRPCHandler(modname,"MOVE",function(player,mx,mz)
    if TheNet:GetClientTableForUser(player.userid).admin and DragObjects[player.userid]~=nil then
        local entity=DragObjects[player.userid].entity
        if not entity:IsValid() then return end
        local offset=DragObjects[player.userid].offset
        local x,y,z=entity.Transform:GetWorldPosition()
        entity.Transform:SetPosition(mx+offset.x,y,mz+offset.z)
    end
end)

local function IsHUDScreen()
    --local screen=TheFrontEnd~=nil and TheFrontEnd:GetActiveScreen() or nil
	return true --screen and screen.name and type(screen.name) == "string" and screen.name == "HUD"
end

DragKeyHandler = Class(function(self)
    self.last_isdown=false
    self.mousemove_handler_active=false
    self.handler=TheInput:AddKeyHandler(function()
        local down=KEY==-1 and (TheInput:IsKeyDown(306) and TheInput:IsKeyDown(308)) or TheInput:IsKeyDown(KEY)
        if not (self.last_isdown and down) and IsHUDScreen() then
            self.last_isdown=down
            if down and not self.mousemove_handler_active then
                local ent=TheInput:GetWorldEntityUnderMouse()
                if ent~=nil and ent:IsValid() then
                    local pos=TheInput:GetWorldPosition()
                    self.mousemove_handler_active=true
                    SendModRPCToServer(MOD_RPC[modname]["DRAG"],down,ent,pos.x,pos.z)
                end
            elseif not down and self.mousemove_handler_active then
                self.mousemove_handler_active=false
                SendModRPCToServer(MOD_RPC[modname]["DRAG"],down)
            end
        end
    end)
    self.mousemove_handler=TheInput:AddMoveHandler(function()
        if self.mousemove_handler_active then
            local pos=TheInput:GetWorldPosition()
            SendModRPCToServer(MOD_RPC[modname]["MOVE"],pos.x,pos.z)
        end
    end)
end)

if TheNet:GetIsServerAdmin() and not TheNet:IsDedicated() then 
    DragKeyHandler()
end