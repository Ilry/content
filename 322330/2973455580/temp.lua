local isclient = TheNet:GetIsClient() or TUNING.DSA_ONE_PLAYER_MODE or (TheNet:GetServerIsClientHosted() and TheNet:GetIsServerAdmin())
local fastbtn = GetModConfigData("Container Sort") or GetModConfigData("Items collect")
if isclient and fastbtn then
    local TEMP_FILE = "mod_config_data/HappyPatchModData"
    local function LoadData(filepath)
        local data = nil
        TheSim:GetPersistentString(filepath, function(load_success, str)
            if load_success == true then
                local success, savedata = RunInSandboxSafe(str)
                if success and string.len(str) > 0 then
                    data = savedata
                else
                    print("[HAPPY PATCH] Could not load " .. filepath)
                end
            else
                print("[HAPPY PATCH] Can not find " .. filepath)
            end
        end)
        return data
    end
    TUNING.TEMP2HM = LoadData(TEMP_FILE) or {}
    TUNING.DATA2HM = TUNING.DATA2HM or {}
    function SaveTemp2hm() TheSim:SetPersistentString(TEMP_FILE, DataDumper(TUNING.TEMP2HM)) end

    local configloadtip = TUNING.isCh2hm and "[为爽而虐客户端专属配置已保存,下次进入游戏时生效]" or
                              "[Shadow World Mod Client Config Updated.Enter Game After Will Apply.]"
    local immediatelytip = TUNING.isCh2hm and "[为爽而虐客户端专属配置已保存,该选项可以直接生效]" or
                               "[Shadow World Mod Client Config Updated.It will immediately Apply.]"
    local Say = getmetatable(TheNet).__index["Say"]
    getmetatable(TheNet).__index["Say"] = function(self, chat_string, whisper, ...)
        if chat_string == "显示整理" or chat_string == "show sort" then
            TUNING.TEMP2HM.opensort = true
            TUNING.DATA2HM.opensort = true
            SaveTemp2hm()
            chat_string = chat_string .. immediatelytip
        elseif chat_string == "隐藏整理" or chat_string == "hide sort" then
            TUNING.TEMP2HM.opensort = false
            TUNING.DATA2HM.opensort = false
            SaveTemp2hm()
            chat_string = chat_string .. immediatelytip
        elseif chat_string == "默认整理" or chat_string == "default sort" then
            TUNING.TEMP2HM.opensort = nil
            SaveTemp2hm()
            chat_string = chat_string .. configloadtip
        end
        return Say(self, chat_string, whisper, ...)
    end
end
