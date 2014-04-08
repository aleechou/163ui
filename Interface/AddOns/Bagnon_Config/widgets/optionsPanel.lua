--[[
	optionsPanel.lua
		A bagnon options panel
--]]

local OptionsPanel = Bagnon:NewClass('OptionsPanel', 'Frame')

function OptionsPanel:New(name, parent, title, subtitle, icon)
	local f = self:Bind(CreateFrame('Frame', name))
	f:SetScript('OnHide', f.Update)
	f:SetScript('OnShow', f.Update)
	f.parent = parent
	f.name = title
	
	local text = f:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	text:SetPoint('TOPLEFT', 16, -16)
	if icon then
		text:SetFormattedText('|T%s:%d|t %s', icon, 32, title)
	else
		text:SetText(title)
	end

	local subtext = f:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
	subtext:SetHeight(32)
	subtext:SetPoint('TOPLEFT', text, 'BOTTOMLEFT', 0, -8)
	subtext:SetPoint('RIGHT', f, -32, 0)
	subtext:SetNonSpaceWrap(true)
	subtext:SetJustifyH('LEFT')
	subtext:SetJustifyV('TOP')
	subtext:SetText(subtitle)
	
	InterfaceOptions_AddCategory(f, 'Bagnon')
	return f
end

function OptionsPanel:Startup()
	self:OnStartup()
	self:Update()
end

function OptionsPanel:Update()
	if self:IsVisible() then
		self:OnActivate()
	else
		self:UnregisterAllMessages()
	end
end

function OptionsPanel:ShowFrame(frameID)
	self:SetFrameID(frameID)
	InterfaceOptionsFrame_OpenToCategory(self)
end

function OptionsPanel:SetFrameID(frameID)
	if self:GetFrameID() ~= frameID then
		self.frameID = frameID
		self:Update()
	end
end

function OptionsPanel:GetFrameID()
	return self.frameID
end

function OptionsPanel:GetSettings()
	return Bagnon.FrameSettings:Get(self:GetFrameID())
end


OptionsPanel.OnStartup = function() end
OptionsPanel.OnActivate = OptionsPanel.OnStartup