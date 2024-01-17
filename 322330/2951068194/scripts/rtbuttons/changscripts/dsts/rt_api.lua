---
--- @author zsh in 2023/3/8 15:33
---

local API = {};

API.Button = {
    DragButton = {
        init_fn = function(self, persistent_id)
            -- 初始化的时候重设坐标点
            TheSim:GetPersistentString(persistent_id, function(load_success, str)
                if load_success == true and str ~= nil then
                    -- 此处是最简单的办法，klei有封装相关函数，诸如 DataDumper，可以研究一下如何使用。
                    local pt = string.split(str, ",")
                    self.r_button:SetPosition(Vector3(tonumber(pt[1]), tonumber(pt[2]), 0));
                end
            end)
        end,
        GetDragPosition = function(self, x, y, button_str)
            local mouse_pt = TheInput:GetScreenPosition()
            local widget_pt = self[button_str]:GetPosition()
            local widget_scale = self[button_str]:GetScale()
            -- 鼠标和按钮总是不能固定在一个位置，通过设置 offset 勉强让它们之间的偏移不至于过大！
            -- 不知道为什么会有偏移，但是通过测试发现 0.75 这个值挺好的。反正 0.6 和 1 绝对不行！
            local offset = 0.75;
            return widget_pt + (Vector3(x, y, 0) - mouse_pt) / (widget_scale.x / offset);
        end,
        SaveDragPosition = function(self, persistent_id, button_pt_str)
            if self[button_pt_str] then
                TheSim:SetPersistentString(persistent_id, tostring(self[button_pt_str].x) .. "," .. tostring(self[button_pt_str].y))
            end
        end
    }
}

return API;