-- 消除画面黑白
--if GetModConfigData("color") then
--    AddPrefabPostInit("forest", function(inst)
--        inst:RemoveComponent("colourcube")
--        inst:AddComponent("colourcube2")
--    end)
--    AddPrefabPostInit("cave", function(inst)
--        inst:RemoveComponent("colourcube")
--        inst:AddComponent("colourcube2")
--    end)
--end


--除雪
local allowance = 0
AddPrefabPostInit("world",
    function(self)
        local map = self.Map
        if map then
            local mt = GLOBAL.getmetatable(map)
            if mt and mt.__index then
                local mt_index = mt.__index
                local SetOverlayLerp_old = mt_index.SetOverlayLerp
                if SetOverlayLerp_old then
                    mt_index.SetOverlayLerp = function(somemap, level, ...)
                        return SetOverlayLerp_old(somemap, 0, ...)
                    end
                end
            end
        end
    end
)

--清爽画质  去除低san黑白画面
if GetModConfigData("Dark_filter") == 1 then
  AddGamePostInit(
    function()
        local PostProcessor = GLOBAL.PostProcessor
        local PostProcessor_metatable = GLOBAL.getmetatable(PostProcessor)
        if PostProcessor_metatable
        then
            local NullFunction = function() end
            local PostProcessor_metatableindex = PostProcessor_metatable.__index or {}
            local CheckForMore = {
                SetDistortionFactor = true,
                SetDistortionRadii = true,
                SetColourModifier = true,
                SetColourCubeLerp = true,
                SetColourCubeData = true,
                SetEffectTime = true,
            }
            for k,_ in pairs(PostProcessor_metatableindex)
            do
                if CheckForMore[k] == nil
                then
                    GLOBAL.print("WARN: PostProcessor function", k, "is not being disabled!")
                end
            end
            for k,_ in pairs(CheckForMore)
            do
                if PostProcessor_metatableindex[k] == nil
                then
                    GLOBAL.print("WARN: PostProcessor function", k, "is no longer defined!")
                    PostProcessor_metatableindex[k] = NullFunction
                end
            end
            
            PostProcessor_metatableindex.SetDistortionFactor(PostProcessor, 0)--失真系数
            PostProcessor_metatableindex.SetDistortionRadii(PostProcessor, 0.5, 0.685)--失真半径
            PostProcessor_metatableindex.SetColourModifier(PostProcessor, 1.4)--对比度
            PostProcessor_metatableindex.SetColourCubeLerp(PostProcessor, 0, 100)--颜色立方体
            PostProcessor_metatableindex.SetColourCubeLerp(PostProcessor, 1, 0)
            local IDENTITY_COLOURCUBE = "images/colour_cubes/identity_colourcube.tex"
            PostProcessor_metatableindex.SetColourCubeData(PostProcessor, 0, IDENTITY_COLOURCUBE, IDENTITY_COLOURCUBE)
            PostProcessor_metatableindex.SetColourCubeData(PostProcessor, 1, IDENTITY_COLOURCUBE, IDENTITY_COLOURCUBE)
            PostProcessor_metatableindex.SetEffectTime(PostProcessor, 0)
            
            PostProcessor_metatableindex.SetDistortionFactor = NullFunction
            PostProcessor_metatableindex.SetDistortionRadii = NullFunction
            PostProcessor_metatableindex.SetColourModifier = NullFunction
            PostProcessor_metatableindex.SetColourCubeLerp = NullFunction
            PostProcessor_metatableindex.SetColourCubeData = NullFunction
            PostProcessor_metatableindex.SetEffectTime = NullFunction
        end
    end
  )
end


--过滤风沙
local function StealthHide(self)
    if self.shown
    then
        self.inst.entity:Hide(false)
    end
end

local function Hooker_Specific_Sand_Disable(self, owner)
    local OnUpdate_old = self.OnUpdate
	self.OnUpdate = function(self, ...)
        OnUpdate_old(self, ...)
        --去除效果
        StealthHide(self.dust)
        StealthHide(self) --只有自己看不到到
	end
end
local function Hooker_Specific_Goggles_Disable(self, owner)
    local ToggleGoggles_old = self.ToggleGoggles
	self.ToggleGoggles = function(self, show, ...)
        ToggleGoggles_old(self, show, ...)
        --去除效果
        StealthHide(self)
	end
end

if(CurrentRelease.GreaterOrEqualTo(ReleaseID.R06_ANR_AGAINSTTHEGRAIN))
then
    if(GetModConfigData("Sand storm")==1)
    then
        AddClassPostConstruct("widgets/sandover", Hooker_Specific_Sand_Disable)
    end
end
