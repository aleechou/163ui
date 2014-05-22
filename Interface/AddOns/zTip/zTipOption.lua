local _, i
local _G = getfenv(0)

local zTipOption = CreateFrame("Frame","zTipOption",UIParent)
zTipOption:Hide()
tinsert(UISpecialFrames, "zTipOption")

function zTipOption:Init()
	-- localize
--	self:Localize()

	-- init frame
	self:SetWidth(300); self:SetHeight(490);
	self:SetPoint("CENTER")
	self:SetFrameStrata("HIGH")
	self:SetToplevel(true)
	self:SetMovable(true)
	self:SetClampedToScreen(true)

	-- background
	self:SetBackdrop( {
	  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
	  insets = { left = 5, right = 5, top = 5, bottom = 5 }
	});
	self:SetBackdropColor(0,0,0)

	-- drag
	self:EnableMouse(true)
	self:RegisterForDrag("LeftButton")
	self:SetScript("OnDragStart",function(self) self:StartMoving() end)
	self:SetScript("OnDragStop",function(self) self:StopMovingOrSizing() end)

	-- title
	--self:CreateFontString("zTipOptionTitle", "ARTWORK", "SystemFont")
	self:CreateFontString("zTipOptionTitle","ARTWORK","GameFontHighlight")
	zTipOptionTitle:SetPoint("TOP",0,-10)
	zTipOptionTitle:SetTextColor(0.8,0.5,1)
	zTipOptionTitle:SetText(self.locStr["zTip Options"])

	-- buttons
	zTipOption:InitButtons()

	-- sub titles
	--self:CreateFontString("zTipOptionPositionTitle","ARTWORK","SystemFont")
	self:CreateFontString("zTipOptionPositionTitle","ARTWORK","GameFontHighlight")
	zTipOptionPositionTitle:SetPoint("BOTTOMLEFT", "zTipOptionFollowCursor","TOPLEFT",-5,0)
	zTipOptionPositionTitle:SetText(self.locStr["Positions"])

	--self:CreateFontString("zTipOptionOffsetTitle","ARTWORK","SystemFont")
	self:CreateFontString("zTipOptionOffsetTitle","ARTWORK","GameFontHighlight")
	zTipOptionOffsetTitle:SetPoint("BOTTOMLEFT", "zTipOptionOffsetX","TOPLEFT",-5,0)
	zTipOptionOffsetTitle:SetText(self.locStr["Offsets"])

	--self:CreateFontString("zTipOptionOrigPosTitle","ARTWORK","SystemFont")
	self:CreateFontString("zTipOptionOrigPosTitle","ARTWORK","GameFontHighlight")
	zTipOptionOrigPosTitle:SetPoint("BOTTOMLEFT", "zTipOptionOrigPosX","TOPLEFT",-5,0)
	zTipOptionOrigPosTitle:SetText(self.locStr["Original Position Offsets"])

	-- read options
	zTipOption:LoadOptions()

	-- done
	self.ready = 1
end

function zTipOption:InitButtons()
	self.Buttons = {
		-- Click Butons
		{name="Close",type="Button",inherits="UIPanelCloseButton",
			point="TOPRIGHT",func=function() zTipOption:Hide() end,},
		{name="Reset",type="Button",inherits="UIPanelButtonTemplate",
			width=50, height=20, text = "Reset",
			point="TOPLEFT",x=5,y=-5,func=zTipOption.Reset},

		-- Check Buttons
		{name="Target",type="CheckButton",var="TargetOfMouse",
			point="TOPLEFT",x=20,y=-35},
		{name="Fade",type="CheckButton",var="Fade",
			point="LEFT",relative="Target",rpoint="RIGHT",x=100,},
		{name="PVPName",type="CheckButton",var="DisplayPvPRank",
			point="TOP",relative="Target",rpoint="BOTTOM",},
		{name="Reputation",type="CheckButton",var="DisplayFaction",
			point="LEFT",relative="PVPName",rpoint="RIGHT",x=100,},
		{name="RealmName",type="CheckButton",var="PlayerServer",
			point="TOP",relative="PVPName",rpoint="BOTTOM",},
		{name="IsPlayer",type="CheckButton",var="ShowIsPlayer",
			point="LEFT",relative="RealmName",rpoint="RIGHT",x=100,},
		{name="ClassIcon",type="CheckButton",var="ClassIcon",
			point="TOP",relative="RealmName",rpoint="BOTTOM",},
		{name="VividMask",type="CheckButton",var="VividMask",
			point="TOP",relative="IsPlayer",rpoint="BOTTOM",
			func = zTipOption.OnVividMaskClicked},

		{name="TalentIcon",type="CheckButton",var="TalentIcon",
			point="TOP",relative="ClassIcon",rpoint="BOTTOM",},

		{name="ShowTalent",type="CheckButton",var="ShowTalent",
			point="TOP",relative="TalentIcon",rpoint="BOTTOM",},
		{name="TargetedBy",type="CheckButton",var="TargetedBy",
			point="TOP",relative="VividMask",rpoint="BOTTOM",},
		{name="ManaBAR",type="CheckButton",var="ManaBAR",
			point="TOP",relative="ShowTalent",rpoint="BOTTOM",
			func = zTipOption.OnManaBARClicked},

		{name="ItemLevel",type="CheckButton",var="ItemLevel",
			point="TOP",relative="TargetedBy",rpoint="BOTTOM",},

		{name="NPCClass",type="CheckButton",var="NPCClass",
			point="TOP",relative="ItemLevel",rpoint="BOTTOM",},

		{name="CombatHide",type="CheckButton",var="CombatHide",
			point="TOP",relative="NPCClass",rpoint="BOTTOM",},


		-- Sliders
		{name="Scale",type="Slider",min=0.00,max=2.00,step=0.01,width=220,
			var = "Scale", func = zTipOption.OnScaleChanged,
			point="CENTER",relative="TargetedBy",rpoint="BOTTOMLEFT",y=-100},

		-- Check Buttons for AnchorType
		{name="FollowCursor",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="TOP",relative="ShowTalent",rpoint="BOTTOM",y=-110, anchor = 3 },
		{name="RootOnTop",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="LEFT",relative="FollowCursor",rpoint="RIGHT",x=100, anchor = 1 },

		{name="FollowCursorA",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="TOP",relative="FollowCursor",rpoint="BOTTOM", anchor = 0 },

		{name="OnCursorTop",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="TOP",relative="FollowCursorA",rpoint="BOTTOM", anchor = 2 },
		{name="RightBottom",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="LEFT",relative="OnCursorTop",rpoint="RIGHT",x=100},

		-- input box
		{name="OffsetX",type="EditBox",width=32,height=20,var="OffsetX",
			point="TOPLEFT",relative="OnCursorTop",rpoint="BOTTOMLEFT",y=-25},
		{name="OffsetY",type="EditBox",width=32,height=20,var="OffsetY",
			point="LEFT",relative="OffsetX",rpoint="RIGHT",x=105,},
		{name="OrigPosX",type="EditBox",width=32,height=20,var="OrigPosX",
			point="TOP",relative="OffsetX",rpoint="BOTTOM",y=-25,},
		{name="OrigPosY",type="EditBox",width=32,height=20,var="OrigPosY",
			point="LEFT",relative="OrigPosX",rpoint="RIGHT",x=105},
	}

	local button, text, name, value
	for key, value in ipairs(zTipOption.Buttons) do
		-- pre settings
		if value.type == "CheckButton" then
			value.inherits = "OptionsCheckButtonTemplate"
		elseif value.type == "Slider" then
			value.inherits = "OptionsSliderTemplate"
		elseif value.type == "EditBox" then
			value.inherits = "InputBoxTemplate"
		end

		-- creations
		button = CreateFrame(value.type, "zTipOption"..value.name, zTipOption, value.inherits)

		if value.type == "CheckButton" then
			text = button:CreateFontString(button:GetName().."Text","ARTWORK","GameFontNormal")
			text:SetPoint("LEFT",button,"RIGHT")
			button:SetFontString(text)
		elseif value.type == "EditBox" then
			text = button:CreateFontString(button:GetName().."Text","ARTWORK","GameFontNormal")
			text:SetPoint("LEFT",button,"RIGHT",5,0)
			button.text = text
		end

		-- setup
		button:SetID(key)
		if value.width then
			button:SetWidth(value.width)
		end
		if value.height then
			button:SetHeight(value.height)
		end
		if value.point then
			if value.relative then
				value.relative = "zTipOption"..value.relative
			end
			button:SetPoint(value.point, value.relative or zTipOption, value.rpoint or value.point, value.x or 0, value.y or 0)
		end
		if value.text then
			if button.text then
				button.text:SetText(value.text)
			else
				button:SetText(value.text)
			end
		end

		-- post settings
		if value.type == "Button" then
			if value.text then button:SetText(value.text) end
			if value.func then button:SetScript("OnClick",value.func) end
		elseif value.type == "CheckButton" then
			if not value.text then button:SetText(self.locStr[value.name]) end
			if value.func then
				button:SetScript("OnClick", value.func)
			else
				button:SetScript("OnClick", zTipOption.OnCheckButtonClicked)
			end
		elseif value.type == "Slider" then
			button.text = _G["zTipOption"..value.name.."Text"]
			if value.text then
				button.title = value.text
			else
				button.title = self.locStr[value.name]
			end
			button.text:SetText(button.title)
			_G["zTipOption"..value.name.."Low"]:SetText(value.min)
			_G["zTipOption"..value.name.."High"]:SetText(value.max)
			button:SetMinMaxValues(value.min, value.max)
			button:SetValueStep(value.step)
			if value.func then button:SetScript("OnValueChanged", value.func) end
		elseif value.type == "EditBox" then
			button:SetAutoFocus(false)
			if not value.text then button.text:SetText(self.locStr[value.name]) end
			if value.func then
				button:SetScript("OnEnterPressed", value.func)
			else
				button:SetScript("OnEnterPressed", zTipOption.OnEditBoxEnterPressed)
			end
			button:SetScript("OnEscapePressed", button.ClearFocus)
		end
	end
end

--[[
	functions
--]]
local value, isChecked
function zTipOption:Reset()
	zTipSaves = zTip:GetDefault()
	zTipOption:LoadOptions()
	GameTooltip:SetScale(zTipSaves.Scale)
	if zTipSaves.VividMask then zTip:GetVividMask():Show()
	else
		if GameTooltipMask then GameTooltipMask:Hide() end
	end
	if zTipSaves.ManaBAR then
		GameTooltipManaBar:SetHeight(GameTooltipStatusBar:GetHeight())
	else
		GameTooltipManaBar:SetHeight(0.1)
	end
	UnitFrameManaBar_Initialize("mouseover",GameTooltipManaBar)
end
function zTipOption:OnCheckButtonClicked()
	isChecked = self:GetChecked()
	if isChecked then
		PlaySound("igMainMenuOptionCheckBoxOn")
	else
		PlaySound("igMainMenuOptionCheckBoxOff")
	end
	value = zTipOption.Buttons[self:GetID()]
	if value.var then
		if isChecked then
			zTipSaves[value.var] = true
		else
			zTipSaves[value.var] = false
		end
	end
end
function zTipOption:OnVividMaskClicked()
	zTipOption.OnCheckButtonClicked(self)
	if self:GetChecked() then
		zTip:GetVividMask():Show()
	else
		if GameTooltipMask then GameTooltipMask:Hide() end
	end
end
function zTipOption:OnManaBARClicked()
	zTipOption.OnCheckButtonClicked(self)
	if self:GetChecked() then
		GameTooltipManaBar:SetHeight(GameTooltipStatusBar:GetHeight())
	else
		GameTooltipManaBar:SetHeight(0.1)
	end
	UnitFrameManaBar_Initialize("mouseover",GameTooltipManaBar)
end

function zTipOption:OnAnchorChanged()

	local i
	for i = 0, 4 do
		local data = zTipOption.Buttons[i + zTipOptionFollowCursor:GetID()]
		local button = _G["zTipOption"..data.name]
		if button == self then
			button:SetChecked(1)
			zTipSaves.Anchor = data.anchor
		else
			button:SetChecked(nil)
		end

	end

	-- The original code was, to be franky, way too ugly that I couldn't even convince myself to leave them commented out...

end

function zTipOption:OnScaleChanged()
	local scale = self:GetValue()
	if scale == 0 then scale = 0.01 end
	zTipSaves.Scale = scale
	GameTooltip:SetScale(scale)
	self.text:SetText(self.title.." : "..math.floor(scale*100).."%")
end
function zTipOption:OnEditBoxEnterPressed()
	local num = self:GetText()
	if not num then return end
	num = tonumber(num)
	if not num then return end
	value = zTipOption.Buttons[self:GetID()]
	zTipSaves[value.var] = num
end
--[[
	read options
--]]
function zTipOption:SetAnchor(followcursor, rootontop, oncursortop, rightbottom)
	zTipOptionFollowCursor:SetChecked(followcursor)
	zTipOptionRootOnTop:SetChecked(rootontop)
	zTipOptionOnCursorTop:SetChecked(oncursortop)
	zTipOptionRightBottom:SetChecked(rightbottom)
end
function zTipOption:LoadOptions()
	local button
	for key, value in ipairs(zTipOption.Buttons) do
		button = _G["zTipOption"..value.name]
		if value.type == "CheckButton" then
			if value.var then
				button:SetChecked(zTipSaves[value.var])
			end
		elseif value.type == "Slider" then
			button:SetValue(zTipSaves[value.var])
		elseif value.type == "EditBox" then
			button:SetText(zTipSaves[value.var])
		end
	end
	-- for anchor
	local anchor = zTipSaves["Anchor"]
	local result = {false,false,false,false}
	if anchor then
		if anchor > 2 then
			anchor = anchor - 3
		else
			result[4] = true
		end
		result[anchor+1] = true
	end
	self:SetAnchor(unpack(result))
end
