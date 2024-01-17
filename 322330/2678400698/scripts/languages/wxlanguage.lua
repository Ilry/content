require("translator")

local LanguageTranslator = GLOBAL.LanguageTranslator
local resolvefilepath_soft = GLOBAL.resolvefilepath_soft

local lang = LanguageTranslator and LanguageTranslator.defaultlang or nil
local fname = lang and "scripts/languages/"..lang.."_wx.po" or nil

if lang and fname and resolvefilepath_soft and resolvefilepath_soft(fname) then
    if LanguageTranslator.languages and LanguageTranslator.languages[lang] then
        local wxlang = lang.."_wx"
        LanguageTranslator.LoadPOFile(LanguageTranslator, fname, wxlang)
        for k, v in pairs(LanguageTranslator.languages[wxlang]) do
            LanguageTranslator.languages[lang][k] = v
        end
        LanguageTranslator.languages[wxlang] = nil
        LanguageTranslator.defaultlang = lang
    else
        LanguageTranslator.LoadPOFile(LanguageTranslator, fname, lang)
    end
end