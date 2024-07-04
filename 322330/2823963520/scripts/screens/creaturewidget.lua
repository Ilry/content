local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local TEMPLATES = require "widgets/redux/templates"

local CreatureWidget = Class(Screen, function(self, owner)
    Screen._ctor(self, "CreatureWidget")
    self.owner = owner

    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self:SetMaxPropUpscale(MAX_HUD_SCALE)
    self:SetPosition(0, 0, 0)
    self:SetVAnchor(ANCHOR_MIDDLE)
    self:SetHAnchor(ANCHOR_LEFT)

    self.isopen = true
    self.scalingroot = self:AddChild(Widget("creaturewidgetscalingroot"))
    self.scalingroot:SetScale(TheFrontEnd:GetHUDScale())

    self.root = self.scalingroot:AddChild(TEMPLATES.ScreenRoot("root"))

    local base_size = 128
    local cell_size = 73
    local row_w = cell_size
    local row_h = cell_size;
    local reward_width = 80
    local row_spacing = 5

    self.panel = self.root:AddChild(TEMPLATES.RectangleWindow(400, 500, "Where you are?", {
        {text = "Close", cb = function() self:OnCancel() end, offset = nil},
    }))

    local function ScrollWidgetsCtor(context, index)
        local w = Widget("creature-cell-".. index)

        w.cell_root = w:AddChild(ImageButton("images/ui.xml", "portrait_bg.tex"))
		w.cell_root:SetFocusScale(cell_size/base_size + .05, cell_size/base_size + .05)
		w.cell_root:SetNormalScale(cell_size/base_size, cell_size/base_size)
        w.cell_root.ongainfocusfn = function() self.creaturepanel:OnWidgetFocus(w) end

        w.creature_root = w.cell_root:AddChild(UIAnim())

        w.cell_root:SetOnClick(function()
            SendModRPCToServer(MOD_RPC["creaturewidget"]["position"], w.data.ref or w.data.prefab, w.data.multiple or false)
            self:OnCancel()
		end)

		return w
    end

    local function ScrollWidgetSetData(context, widget, data, index)
		widget.data = data
		if data ~= nil then
			widget.creature_root:Show()
            widget.creature_root:GetAnimState():SetBank(data.bank)
            widget.creature_root:GetAnimState():SetBuild(data.build)
            widget.creature_root:GetAnimState():PlayAnimation(data.animation, data.loop)
            widget.creature_root:SetScale(data.scale)
            widget.creature_root:SetPosition(data.offset.x, data.offset.y)
			widget:Enable()
		else
			widget:Disable()
			widget.creature_root:Hide()
		end
    end

    self.creaturepanel = self.panel:AddChild(TEMPLATES.ScrollingGrid(
        {
            {prefab = "klaus_sack",                                 bank = "klaus_bag",         build = "klaus_bag",                animation = "idle",             scale = 0.13,   loop = false,   offset = {x = 0, y = -20}},
            {prefab = "moose_nesting_ground",   multiple = true,    bank = "goosemoose",        build = "goosemoose_build",         animation = "idle",             scale = 0.04,   loop = true,    offset = {x = 0, y = -27}},
            {prefab = "oasislake",                                  bank = "oasis_tile",        build = "oasis_tile",               animation = "idle",             scale = 0.04,   loop = true,    offset = {x = 0, y = 0}},
            {prefab = "antlion",                                    bank = "antlion",           build = "antlion_build",            animation = "idle",             scale = 0.06,   loop = true,    offset = {x = 0, y = -27}},
            {prefab = "bearger",                multiple = true,    bank = "bearger",           build = "bearger_build",            animation = "idle_loop",        scale = 0.04,   loop = true,    offset = {x = 0, y = -27}},
            {prefab = "deerclops",              multiple = true,    bank = "deerclops",         build = "deerclops_build",          animation = "idle_loop",        scale = 0.06,   loop = true,    offset = {x = 0, y = -30}},
            {prefab = "dragonfly",                                  bank = "dragonfly",         build = "dragonfly_build",          animation = "idle",             scale = 0.06,   loop = true,    offset = {x = 0, y = -27}, ref = "lava_pond",  },
            {prefab = "beequeenhive",                               bank = "bee_queen_hive",    build = "bee_queen_hive",           animation = "large",            scale = 0.11,   loop = false,   offset = {x = 0, y = -22}},
            {prefab = "crabking",                                   bank = "king_crab",         build = "crab_king_build",          animation = "inert",            scale = 0.03,   loop = true,    offset = {x = 0, y = -24}},
            {prefab = "sculpture_rookbody",                         bank = "rook",              build = "sculpture_rook",           animation = "full",             scale = 0.06,   loop = false,   offset = {x = -4, y = -20}},
            {prefab = "deer",                                       bank = "deer",              build = "deer_build",               animation = "idle_loop",        scale = 0.11,   loop = true,    offset = {x = 0, y = -27}},
            {prefab = "beefaloherd",            multiple = true,    bank = "beefalo",           build = "beefalo_build",            animation = "idle_loop",        scale = 0.08,   loop = true,    offset = {x = 0, y = -25}},
            {prefab = "lightninggoatherd",      multiple = true,    bank = "lightning_goat",    build = "lightning_goat_build",     animation = "idle_loop",        scale = 0.1,    loop = true,    offset = {x = 0, y = -30}},
            {prefab = "pigking",                                    bank = "Pig_King",          build = "Pig_King",                 animation = "idle",             scale = 0.07,   loop = true,    offset = {x = 0, y = -19}},
            {prefab = "walrus_camp",            multiple = true,    bank = "walrus_house",      build = "walrus_house",             animation = "idle",             scale = 0.06,   loop = false,   offset = {x = 0, y = -22}},
            {prefab = "hermitcrab",                                 bank = "wilson",            build = "hermitcrab_build",         animation = "idle_loop",        scale = 0.18,   loop = true,    offset = {x = 0, y = -27}},
            {prefab = "moon_fissure",                               bank = "moon_fissure",      build = "moon_fissure",             animation = "crack_idle",       scale = 0.17,   loop = true,    offset = {x = 0, y = 0}},
            {prefab = "moonbase",                                   bank = "moonbase",          build = "moonbase",                 animation = "med",              scale = 0.14,   loop = false,   offset = {x = 0, y = -8}},
            {prefab = "chester_eyebone",                            bank = "eyebone",           build = "chester_eyebone_build",    animation = "idle_loop",        scale = 0.23,   loop = true,    offset = {x = 0, y = -24}},
            {prefab = "rock_moon_shell",                            bank = "moonrock_shell",    build = "moonrock_shell",           animation = "full",             scale = 0.13,   loop = false,   offset = {x = 0, y = -18}},
            {prefab = "koalefant_winter",       multiple = true,    bank = "koalefant",         build = "koalefant_winter_build",   animation = "idle_loop",        scale = 0.09,   loop = true,    offset = {x = -5, y = -26}},
            {prefab = "koalefant_summer",       multiple = true,    bank = "koalefant",         build = "koalefant_summer_build",   animation = "idle_loop",        scale = 0.09,   loop = true,    offset = {x = -5, y = -26}},
            {prefab = "warg",                   multiple = true,    bank = "warg",              build = "warg_build",               animation = "idle_loop",        scale = 0.08,   loop = true,    offset = {x = 0, y = -26}},
            {prefab = "spat",                   multiple = true,    bank = "spat",              build = "spat_build",               animation = "idle_loop",        scale = 0.09,   loop = true,    offset = {x = -2, y = -26}},
            {prefab = "lureplant",              multiple = true,    bank = "eyeplant_trap",     build = "eyeplant_trap",            animation = "idle_hidden",      scale = 0.16,   loop = true,    offset = {x = 3, y = -24}},
            {prefab = "messagebottle",          multiple = true,    bank = "bottle",            build = "bottle",                   animation = "idle",             scale = 0.4,    loop = true,    offset = {x = 0, y = -24}},
            {prefab = "stagehand",              multiple = false,   bank = "stagehand",         build = "stagehand",                animation = "idle_loop_01",     scale = 0.13,   loop = true,    offset = {x = 0, y = -26}},
            {prefab = "oceanfish_shoalspawner", multiple = true,    bank = "oceanfish_medium",  build = "oceanfish_medium_2",       animation = "idle_loop",        scale = 0.24,   loop = true,    offset = {x = 2, y = -2}},
            {prefab = "terrariumchest",         multiple = false,   bank = "chest",             build = "treasurechest_terrarium",  animation = "closed",           scale = 0.23,   loop = true,    offset = {x = -2, y = -22}},
            {prefab = "terrarium",              multiple = false,   bank = "terrarium",         build = "terrarium",                animation = "activated_idle",   scale = 0.23,   loop = true,    offset = {x = 0, y = -32}},
            {prefab = "saltstack",              multiple = true,    bank = "salt_pillar2",      build = "salt_pillar2",             animation = "full",             scale = 0.07,   loop = true,    offset = {x = 0, y = -26}},
            {prefab = "watertree_pillar",       multiple = true,    bank = "oceantree_normal",  build = "oceantree_normal",         animation = "sway1_loop",       scale = 0.06,   loop = true,    offset = {x = 0, y = -25}},

            {prefab = "atrium_gate",                                bank = "atrium_gate",       build = "atrium_gate",              animation = "idle",             scale = 0.06,   loop = false,   offset = {x = 0, y = -24}},
            {prefab = "ancient_altar",                              bank = "crafting_table",    build = "crafting_table",           animation = "idle_full",        scale = 0.06,   loop = false,   offset = {x = 0, y = -26}},
            {prefab = "hutch_fishbowl",                             bank = "fishbowl",          build = "hutch_fishbowl",           animation = "idle_loop",        scale = 0.21,   loop = true,    offset = {x = 0, y = -17}},
            {prefab = "minotaur",                                   bank = "rook",              build = "rook_rhino",               animation = "idle",             scale = 0.07,   loop = true,    offset = {x = -5, y = -26}},
            {prefab = "toadstool",              multiple = true,    bank = "toadstool",         build = "toadstool_build",          animation = "idle",             scale = 0.04,   loop = true,    offset = {x = 0, y = -26}, ref = "toadstool_cap",},
            {prefab = "archive_cookpot",                            bank = "cook_pot",          build = "cookpot_archive",          animation = "idle_empty",       scale = 0.17,   loop = false,   offset = {x = 0, y = -24}},
            
            {prefab = "monkeyqueen",                                bank = "monkey_queen",      build = "monkey_queen",             animation = "idle",             scale = 0.02,   loop = true,    offset = {x = 0, y = -32}},
            
            {prefab = "lunarthrall_plant",      multiple = true,    bank = "lunarthrall_plant", build = "lunarthrall_plant_front",  animation = "idle_med",         scale = 0.08,   loop = true,    offset = {x = 0, y = -24}},
            {prefab = "lunarrift_portal",                           bank = "lunar_rift_portal", build = "lunar_rift_portal",        animation = "stage_3_loop",     scale = 0.05,   loop = true,    offset = {x = 0, y = -28}},
            {prefab = "shadowrift_portal",                          bank = "shadowrift_portal", build = "shadowrift_portal",        animation = "scrapbook",        scale = 0.08,   loop = false,   offset = {x = 0, y = -4}},
            {prefab = "wagstaff_machinery",                         bank = "wagstaff_setpieces",build = "wagstaff_setpieces",       animation = "idle1",            scale = 0.10,   loop = true,    offset = {x = 0, y = -22}},
            {prefab = "junk_pile_big",                              bank = "scrappile",         build = "scrappile",                animation = "big_idle",         scale = 0.07,   loop = true,    offset = {x = 0, y = -24}},
            {prefab = "daywalker",                                  bank = "daywalker",         build = "daywalker_build",          animation = "idle",             scale = 0.07,   loop = true,    offset = {x = 0, y = -28}},
        },
        {
            context = {},
            widget_width  = row_w+row_spacing,
            widget_height = row_h+row_spacing,
			force_peek    = true,
            num_visible_rows = 5,
            num_columns      = 5,
            item_ctor_fn = ScrollWidgetsCtor,
            apply_fn     = ScrollWidgetSetData,
            scrollbar_offset = 20,
            scrollbar_height_offset = -60
		}
    ))

    self.creaturepanel:Show()
end)

function CreatureWidget:OnCancel()
    if not self.isopen then return end
    self.owner.HUD:CloseCreatureWidget()
end

function CreatureWidget:OnControl(control, down)
    if CreatureWidget._base.OnControl(self, control, down) then return true end
    if not down then
        if control == CONTROL_OPEN_DEBUG_CONSOLE then
            return true
        elseif control == CONTROL_CANCEL then
            self:OnCancel()
        end
    end
end

function CreatureWidget:Close()
    if self.isopen then
        self.panel:Kill()
        self.isopen = false

        self.inst:DoTaskInTime(.2, function() TheFrontEnd:PopScreen(self) end)
    end
end

return CreatureWidget