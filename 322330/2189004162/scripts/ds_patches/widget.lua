local patcher_common = import("ds_patches/patcher_common")
local Widget = require("widgets/widget")

local patches = {}

rawset(_G, "MAX_HUD_SCALE", 1.25)

-- fonts_default.lua in DS, fonts.lua in DST
rawset(_G, "NEWFONT", UIFONT)
rawset(_G, "NEWFONT_OUTLINE", UIFONT)
rawset(_G, "HEADERFONT", UIFONT)
rawset(_G, "CHATFONT", UIFONT)

--[[
	DS Fonts
DEFAULTFONT = "opensans"
DIALOGFONT = "opensans"
TITLEFONT = "bp100"
UIFONT = "bp50"
BUTTONFONT="buttonfont"
NUMBERFONT = "stint-ucr"
TALKINGFONT = "talkingfont"
TALKINGFONT_WATHGRITHR = "talkingfont_wathgrithr"
TALKINGFONT_WORMWOOD = "talkingfont_wormwood"
SMALLNUMBERFONT = "stint-small"
BODYTEXTFONT = "stint-ucr"
]]

function patches:GetParentScreen()
    --check for a cached version
    if self.parent_screen then
        return self.parent_screen
    end

    local parent = self.parent
    while( not parent.is_screen )
    do
        parent = parent:GetParent()
    end
    self.parent_screen = parent
    return self.parent_screen
end

local oldKillAllChildren = Widget.KillAllChildren
function patches.KillAllChildren(self, ...)
	oldKillAllChildren(self, ...)
	self:ClearHoverText()
end

function patches.SetHoverText(self, text, params)
	if text and text ~= "" then
		if not self.hovertext then
			local ImageButton = require "widgets/imagebutton"
			local Text = require "widgets/text"

			if params == nil then
				params = {}
			end

			if params.attach_to_parent ~= nil then
				self.hovertext_root = params.attach_to_parent:AddChild(Widget("hovertext_root"))
			else
				self.hovertext_root = Widget("hovertext_root")
				self.hovertext_root.global_widget = true
				self.hovertext_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
			end
			self.hovertext_root:Hide()

			if params.bg ~= false then
				self.hovertext_bg = self.hovertext_root:AddChild(Image(params.bg_atlas or "images/dst/frontend.xml", params.bg_texture or "scribble_black.tex"))
				self.hovertext_bg:SetTint(1,1,1,.8)
				self.hovertext_bg:SetClickable(false)
			end

			self.hovertext = self.hovertext_root:AddChild(Text(params.font or NEWFONT_OUTLINE, params.font_size or 22, text))
			self.hovertext:SetClickable(false)
			self.hovertext:SetScale(1.1,1.1)

			if params.region_h ~= nil or params.region_w ~= nil then
				self.hovertext:SetRegionSize(params.region_w or 1000, params.region_h or 40)
			end

			if params.wordwrap ~= nil then
				--print("Enabling word wrap", params.wordwrap)
				self.hovertext:EnableWordWrap(params.wordwrap)
			end

			if params.colour then
				self.hovertext:SetColour(params.colour)
			end

			if params.bg == nil or params.bg == true then
				local w, h = self.hovertext:GetRegionSize()
				self.hovertext_bg:SetSize(w*1.5, h*2.0)
			end


			local hover_parent = self.text or self
			if hover_parent.GetString ~= nil and hover_parent:GetString() ~= "" then
				--Note(Peter): This block is here because Text widgets don't receive OnGainFocus calls.
				self.hover = hover_parent:AddChild(ImageButton("images/ui.xml", "blank.tex", "blank.tex", "blank.tex", nil, nil, {1,1}, {0,0}))
				self.hover.image:ScaleToSize(hover_parent:GetRegionSize())

				self.hover.OnGainFocus = function()
					local world_pos = self:GetWorldPosition()
					local x_pos = world_pos.x + (params.offset_x or 0)
					local y_pos = world_pos.y + (params.offset_y or 26)
					self.hovertext_root:SetPosition(x_pos, y_pos)
					self.hovertext_root:Show()
				end
				self.hover.OnLoseFocus = function()
					self.hovertext_root:Hide()
				end
			else
				self._OnGainFocus = self.OnGainFocus --save these fns so we can undo the hovertext on focus when clearing the text
				self._OnLoseFocus = self.OnLoseFocus

				self.OnGainFocus = function()
					if params.attach_to_parent ~= nil then
						local world_pos = self:GetWorldPosition() - params.attach_to_parent:GetWorldPosition()
						local parent_scale = params.attach_to_parent:GetScale()

						local x_pos = world_pos.x / parent_scale.x + (params.offset_x or 0)
						local y_pos = world_pos.y / parent_scale.y + (params.offset_y or 26)
						self.hovertext_root:SetPosition(x_pos, y_pos)

						self.hovertext_root:MoveToFront()
					else
						local world_pos = self:GetWorldPosition()
						local x_pos = world_pos.x + (params.offset_x or 0)
						local y_pos = world_pos.y + (params.offset_y or 26)
						self.hovertext_root:SetPosition(x_pos, y_pos)
					end
					self.hovertext_root:Show()

					self._OnGainFocus( self )
				end
				self.OnLoseFocus = function()
					self.hovertext_root:Hide()
					self._OnLoseFocus( self )
				end
			end
		else
			self.hovertext:SetString(text)
			if params and params.colour then
				self.hovertext:SetColour(params.colour)
			end
			if self.hovertext_bg then
				local w, h = self.hovertext:GetRegionSize()
				self.hovertext_bg:SetSize(w*1.5, h*2.0)
			end
		end
	end
end

function patches.ClearHoverText(self)
	if self.hovertext_root ~= nil then
		self.hovertext_root:Kill()
		self.hovertext_root = nil
		self.hovertext = nil
		self.hovertext_bg = nil

		if self._OnGainFocus then
			self.OnGainFocus = self._OnGainFocus
			self.OnLoseFocus = self._OnLoseFocus

			self._OnGainFocus = nil
			self._OnLoseFocus = nil
		end
	end
	if self.hover ~= nil then
		self.hover:Kill()
		self.hover = nil
	end
end

function patches.GetFocusChild(self)
	if self.focus then
		for k,v in pairs(self.children) do
			if v.focus then
				return v
			end
		end
	end
	return nil
end

function patches.SetOnGainFocus(self, fn)
	self.ongainfocusfn = fn
end

function patches.SetOnLoseFocus(self, fn)
	self.onlosefocusfn = fn
end

function patches:ClearFocus()
    if self.focus then
        self.focus = false
        if self.OnLoseFocus then
            self:OnLoseFocus()
        end
        if self.onlosefocusfn then
            self.onlosefocusfn()
        end
        for k,v in pairs(self.children) do
            if v.focus then
                v:ClearFocus()
            end
        end
    end
end

function patches:SetFocusFromChild(from_child)
	--[[
	if self.parent == nil and not self.is_screen then
		print("Warning: Widget:SetFocusFromChild is happening on a widget outside of the screen/widget hierachy. This will cause focus moves to fail. Is ", self.name, "not a screen?")
		print(debugstack())
	end
	--]]
	for k,v in pairs(self.children) do
		if v ~= from_child and v.focus then
			v:ClearFocus()
		end
	end

	if not self.focus then
		self.focus = true
		if self.OnGainFocus then
			self:OnGainFocus()
		end

		if self.ongainfocusfn then
			self.ongainfocusfn()
		end

		if self.parent then
			self.parent:SetFocusFromChild(self)
		end
	end
end

function patches:SetFocus()
  --  print ("SET FOCUS ", self)
	local focus_forward = FunctionOrValue(self.focus_forward)
	if focus_forward then
		focus_forward:SetFocus()
		return
	end

	if not self.focus then
		self.focus = true

		if self.OnGainFocus then
			self:OnGainFocus()
		end

		if self.ongainfocusfn then
			self.ongainfocusfn()
		end

		if self.parent then
			self.parent:SetFocusFromChild(self)
		end
	end

	for k,v in pairs(self.children) do
		v:ClearFocus()
	end
end


--[=[
local old = Widget.OnControl

function patches.OnControl(self, control, down)
	if down==false then return old(self, control, down) end
	mprint("oncontrol", self, control, down, "|", self.focus)

	if not self.focus then 
		mprint("\tI DON'T HAVE FOCUS")
		return false
	end

	for k,v in pairs(self.children) do
		if v.focus then
			mprint("\trunning onto:", v)
			local x = v:OnControl(control, down)
			if x then
				return true
			end
		else
			mprint("\tskipping:", v)
		end
		--[[
		-- original
		if v.focus and v:OnControl(control, down) then 
			return true 
		end
		--]]
	end 

	return false
end


function patches.SetFocusFromChild(self, from_child)
	--[[
	if self.parent == nil and not self.is_screen then
		print("Warning: Widget:SetFocusFromChild is happening on a widget outside of the screen/widget hierachy. This will cause focus moves to fail. Is ", self.name, "not a screen?")
		print(debugstack())
	end
	--]]
	
	local yes = true or self.name and self.name:lower():find("insight")
	if yes then
		mprint("SetFocusFromChild", "SELF:", self, "CHILD:", from_child)
	end

	for k,v in pairs(self.children) do
		if v ~= from_child and v.focus then
			mprint("\tRemoving focus from", v)
			v:ClearFocus()
		end
	end

	if not self.focus then
		if yes then mprint("\tAll Good here. PARENT:", self.parent) end
		self.focus = true
		if self.OnGainFocus then
			self:OnGainFocus()
		end

		if self.parent then
			self.parent:SetFocusFromChild(self)
		end
	end
end
--]=]

return {
	patches = patches,
	Init = function() patcher_common.PatchClass(Widget, patches) end,
}