_G = GLOBAL

--加载翻译贴图
print("[Chinses] 加载贴图翻译！")
Assets = {
	Asset("IMAGE", "images/customisation.tex"),
	Asset("ATLAS", "images/customisation.xml"),
	Asset("IMAGE", "images/frontscreen.tex"),
	Asset("ATLAS", "images/frontscreen.xml"),
	Asset("IMAGE", "images/lavaarena_frontend.tex"),
	Asset("ATLAS", "images/lavaarena_frontend.xml"),
	Asset("IMAGE", "images/names_gold_cn_wurt.tex"),
	Asset("ATLAS", "images/names_gold_cn_random.xml"),
	Asset("IMAGE", "images/quagmire_frontend.tex"),
	Asset("ATLAS", "images/quagmire_frontend.xml"),
	Asset("IMAGE", "images/skinsscreen.tex"),
	Asset("ATLAS", "images/skinsscreen.xml"),
	Asset("IMAGE", "images/tradescreen.tex"),
	Asset("ATLAS", "images/tradescreen.xml"),
	Asset("IMAGE", "images/tradescreen_overflow.tex"),
	Asset("ATLAS", "images/tradescreen_overflow.xml"),
}


ISPLAYINGNOW = ( _G.TheNet:GetIsClient() or _G.TheNet:GetIsServer() )
local LANG = GetModConfigData("LANG")
local SMALL_TEXTURES = GetModConfigData("SMALL_TEXTURES")
local langname = { "chs", "[Chinses] 所选语言不存在或无法加载，默认加载简体翻译成功！", }
local choose =
{
	["simplified"] = { "chs", "[Chinses] 加载简体翻译成功！", },
	["traditional"] = { "cht", "[Chinses] 載入繁體翻譯成功！", },
	["schinese"] = { "chs", "[Chinses] 据STEAM语言加载简体翻译成功！", },
	["tchinese"] = { "cht", "[Chinses] 據STEAM語言載入繁體翻譯成功！", },
}

if LANG ~= "auto" then
--主要功能
	langname = choose[LANG] or langname
else
	local steamlang = _G.TheNet:GetLanguageCode()
	langname = choose[steamlang] or langname
end

local pofilename = "DST_"..langname[1]..".po"
LoadPOFile(pofilename, langname[1])
print(langname[2])


if SMALL_TEXTURES and not ISPLAYINGNOW then
-- 自动关闭小贴图（By Skull）
	if _G.TheNet:GetIsServer() and _G.TheNet:GetServerIsDedicated() then
		print("[Chinese] 检测到当前程序为服务端，无需加载自动关闭小型纹理功能！")
		return
	else
		print("[Chinese] 检测到小型纹理功能！")
	end

	AddClassPostConstruct("widgets/widget", function(self, ...)
		if _G.TheFrontEnd and _G.TheFrontEnd:GetGraphicsOptions() and _G.TheFrontEnd:GetGraphicsOptions():IsSmallTexturesMode() then
			_G.TheFrontEnd:GetGraphicsOptions():SetSmallTexturesMode( false )
			print("[Chinese] 已自动关闭小型纹理!!")
		end
	end)

end


_G.TranslateStringTable( _G.STRINGS )


--[[
if _G.debug.getupvalue(string.match,1)==nil then
-- 修复因游戏原因无法正确匹配中文的bug（By EvenMr）
	local oldmatch=string.match
	function string.match(str, pattern, index)
		return oldmatch(str, pattern:gsub("%%w", "[%%w一-鿕]"), index)
	end
end
]]