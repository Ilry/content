
local ImageButton = require("widgets/imagebutton")

-- local UpValue = {}
-- UpValue.Get = function(self, fn, key)
	-- local i=1
	-- repeat
		-- local name, value = debug.getupvalue(fn, i)
		-- if name then
			-- if name == key then
				-- return value
			-- end
			-- i = i+1
		-- end
	-- until not name
-- end

-- UpValue.Set = function(self, fn, key, new_value)
	-- local i=1
	-- repeat
		-- local name, value = debug.getupvalue(fn, i)
		-- if name then
			-- if name == key then
				-- debug.setupvalue(fn, i, new_value)
			-- end
			-- i = i+1
		-- end
	-- until not name
-- end

AddClassPostConstruct("widgets/containerwidget", function(self)
	-- local RefreshButton = UpValue:Get(self.OnItemGet, "RefreshButton")
	-- if RefreshButton then
		-- print("按钮 RefreshButton", RefreshButton or "nil")
		-- local NewRefreshButton = function(inst, self)
			-- RefreshButton(inst, self)
			
			-- if self.isopen then
				-- local widget = self.container.replica.container:GetWidget()
				-- if widget ~= nil and widget.buttoninfo_iai_rubbishbox ~= nil and widget.buttoninfo_iai_rubbishbox.validfn ~= nil then
					-- if widget.buttoninfo_iai_rubbishbox.validfn(self.container) then
						-- self.button_iai_rubbishbox:Enable()
					-- else
						-- self.button_iai_rubbishbox:Disable()
					-- end
				-- end
			-- end
		-- end
		-- UpValue:Set(self.OnItemGet, "RefreshButton", NewRefreshButton)
	-- end
	
	local old = self.Open
	self.Open = function(self, container, doer, ...)
		old(self, container, doer, ...)
		
		local widget = container.replica.container:GetWidget()
		if widget.buttoninfo_iai_rubbishbox ~= nil then
			self.button_iai_rubbishbox = self:AddChild(ImageButton("images/ui.xml", "button_small.tex", "button_small_over.tex", "button_small_disabled.tex", nil, nil, {1,1}, {0,0}))
			self.button_iai_rubbishbox.image:SetScale(1.07)
			self.button_iai_rubbishbox.text:SetPosition(2,-2)
			self.button_iai_rubbishbox:SetPosition(widget.buttoninfo_iai_rubbishbox.position)
			self.button_iai_rubbishbox:SetText(widget.buttoninfo_iai_rubbishbox.text)
			if widget.buttoninfo_iai_rubbishbox.fn ~= nil then
				self.button_iai_rubbishbox:SetOnClick(function()
					if doer ~= nil then
						if doer:HasTag("busy") then
							--Ignore button click when doer is busy
							return
						elseif doer.components.playercontroller ~= nil then
							local iscontrolsenabled, ishudblocking = doer.components.playercontroller:IsEnabled()
							if not (iscontrolsenabled or ishudblocking) then
								--Ignore button click when controls are disabled
								--but not just because of the HUD blocking input
								return
							end
						end
					end
					widget.buttoninfo_iai_rubbishbox.fn(container, doer)
				end)
			end
			self.button_iai_rubbishbox:SetFont(BUTTONFONT)
			self.button_iai_rubbishbox:SetDisabledFont(BUTTONFONT)
			self.button_iai_rubbishbox:SetTextSize(33)
			self.button_iai_rubbishbox.text:SetVAlign(ANCHOR_MIDDLE)
			self.button_iai_rubbishbox.text:SetColour(0,0,0,1)
			
			-- if widget.buttoninfo_iai_rubbishbox.validfn ~= nil then
				-- if widget.buttoninfo_iai_rubbishbox.validfn(container) then
					-- self.button_iai_rubbishbox:Enable()
				-- else
					-- self.button_iai_rubbishbox:Disable()
				-- end
			-- end
			
			if TheInput:ControllerAttached() then
				self.button_iai_rubbishbox:Hide()
			end
			
			self.button_iai_rubbishbox.inst:ListenForEvent("continuefrompause", function()
				if TheInput:ControllerAttached() then
					self.button_iai_rubbishbox:Hide()
				else
					self.button_iai_rubbishbox:Show()
				end
			end, TheWorld)
			
			self:Refresh()
		end
	end
	
	local old = self.Close
	self.Close = function(self)
		if self.isopen then
			if self.button_iai_rubbishbox then
				self.button_iai_rubbishbox:Kill()
				self.button_iai_rubbishbox = nil
			end
		end
		
		old(self)
	end
end)
