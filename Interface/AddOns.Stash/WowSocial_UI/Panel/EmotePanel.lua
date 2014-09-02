--[[
	EmotePanel.lua
	send smile icon
	ver     1.0.0
    author  Jai
    email   814683@qq.com
	edit	2013-10-14 15:02:26
	change	
]]--

BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local EmotePanel = GUI:GetClass('GridView'):New(UIParent)

CloudUI.EmotePanel = EmotePanel

function EmotePanel:Load()
	self:Hide()
    self:SetFrameStrata('DIALOG')
    self:SetSize(1, 1)
    self:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Gold-Background]],
    }

    self:SetAutoSize(true)
    self:SetItemClass(CloudUI:GetClass('AvatarButton'))
    self:SetItemList(EmoteData)
    self:SetItemHeight(24)
    self:SetItemWidth(24)
    self:SetColumnCount(10)
    self:SetRowCount(6)
    self:SetItemSpacing(2)
    self:SetCallback('OnItemFormatted', function(self, button, data)
        button:SetIcon(data.Icon)
    end)
    self:SetCallback('OnItemClick', function(self, button, data)
        self:Hide()
        local inputbox = self.inputbox
        if inputbox then
        	inputbox:SetFocus(false)
        	inputbox:Insert(format('{%s}', data.Name))
        end
    end)
    self:SetScript('OnHide', self.Hide)
    self:Refresh()

    GUI:Embed(self, 'Menu')
end

function EmotePanel:Open(relative, inputbox)
    self:SetOwner(relative)
	self:SetShown(not self:IsShown())
	self:ClearAllPoints()
	self:SetPoint('BOTTOMLEFT', relative, 'TOPRIGHT')
	self.inputbox = inputbox or relative
end

EmotePanel:Load()
