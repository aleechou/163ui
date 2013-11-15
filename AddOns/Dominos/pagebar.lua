
local PageBar = Dominos:CreateClass('Frame', Dominos.Frame)
Dominos.PageBar = PageBar

local L = LibStub('AceLocale-3.0'):GetLocale('Dominos')
local buttons = {ActionBarUpButton, ActionBarDownButton}

function PageBar:New()
	local f = self.super.New(self, 'page')
	f:LoadButtons()
	f:Layout()
	return f
end

function PageBar:GetDefaults()
	return {
		point = 'CENTER',
		x = 0,
		y = 0,
        columns = 1,
	}
end

function PageBar:NumButtons()
    return #buttons
end

function PageBar:AddButton(i)
	local b = buttons[i]
	b:SetParent(self.header)
	b:Show()

	self.buttons[i] = b
end

function PageBar:RemoveButton(i)
	local b = self.buttons[i]
	b:SetParent(nil)
	b:Hide()

	self.buttons[i] = nil
end

function PageBar:GetShowStates()
	return '[novehicleui]show;hide'
end

local PageBarController = Dominos:NewModule('PageBar')

function PageBarController:Load()
	self.frame = PageBar:New()
end

function PageBarController:Unload()
	if self.frame then
		self.frame:Free()
		self.frame = nil
	end
end
