--[[
	ResizeButton.lua
	Resize Parent`s Size
	ver     1.0.0
    author  Jai
    email   814683@qq.com
	edit	2013-10-15 13:41:16
	change	
]]--

local WIDGET, VERSION = 'ResizeButton', 1

local GUI = LibStub('NetEaseGUI-1.0')
local ResizeButton = GUI:NewClass(WIDGET, 'Button', VERSION)
if not ResizeButton then
	return
end

function ResizeButton:Constructor(parent)
	if not parent then
		return
	end
	self:SetParent(parent)

	self:SetNormalTexture([[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Up]])
	self:SetHighlightTexture([[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Highlight]])
	self:SetPushedTexture([[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Down]])
	self:SetPoint('BOTTOMRIGHT')
	self:SetSize(16, 16)

	self:RegisterForClicks('LeftButtonUp')
	self:SetScript('OnMouseDown', self.OnMouseDown)
	self:SetScript('OnMouseUp', self.OnMouseUp)
end

function ResizeButton:SetCorner(...)
	local corner = ...
	if corner == 'TOPLEFT' then
		self:GetNormalTexture():SetTexCoord(1, 0, 1, 0)
		self:GetHighlightTexture():SetTexCoord(1, 0, 1, 0)
		self:GetPushedTexture():SetTexCoord(1, 0, 1, 0)
	elseif corner == 'TOPRIGHT' then
		self:GetNormalTexture():SetTexCoord(0, 1, 1, 0)
		self:GetHighlightTexture():SetTexCoord(0, 1, 1, 0)
		self:GetPushedTexture():SetTexCoord(0, 1, 1, 0)
	elseif corner == 'BOTTOMLEFT' then
		self:GetNormalTexture():SetTexCoord(1, 0, 0, 1)
		self:GetHighlightTexture():SetTexCoord(1, 0, 0, 1)
		self:GetPushedTexture():SetTexCoord(1, 0, 0, 1)
	elseif corner == 'BOTTOMRIGHT' then
		self:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
		self:GetHighlightTexture():SetTexCoord(0, 1, 0, 1)
		self:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
	else
		return
	end

	self:ClearAllPoints()
	self:SetPoint(...)
end

function ResizeButton:OnMouseDown()
	self:SetButtonState('PUSHED', true)
	self:GetHighlightTexture():Hide()

	local direction = self:GetPoint()
	local parent = self:GetParent()
	parent:SetMaxResize(parent:GetParent():GetSize())
	parent:SetResizable(true)
	parent:StartSizing(direction)

	self:Fire('OnResizing', true)
end

function ResizeButton:OnMouseUp()
	self:SetButtonState('NORMAL', false)
	self:GetHighlightTexture():Show()

	local parent = self:GetParent()
	parent:StopMovingOrSizing()
	parent:SetResizable(false)

	self:Fire('OnResizing', false)
end
