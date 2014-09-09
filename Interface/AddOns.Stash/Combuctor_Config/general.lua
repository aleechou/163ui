--[[
	General options panel
--]]

local ADDON, Addon = ...
local General = Addon:NewPanel('General')

local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')
local frame

local Managed = General:NewCheckButton(L.ActPanel, L.ActPanelTip)
Managed:SetPoint('TOPLEFT', 15, -120)
Managed:SetScript('OnClick', function()
    if frame.sets.position then
        frame:SavePosition(nil)
    else
        frame:SavePosition(frame:GetPoint())
    end
end)

local Reversed = General:NewCheckButton(L.LeftFilters, L.LeftFiltersTip)
Reversed:SetPoint('TOPLEFT', Managed, 'BOTTOMLEFT', 0, -5)
Reversed:SetScript('OnClick', function()
    frame:SetLeftSideFilter(not frame:IsSideFilterOnLeft())
end)

local anchor = Reversed
for _, name in ipairs {'ItemsByQuality', 'UnusableItems', 'SetItems', 'QuestItems'} do
    local button = General:NewCheckButton(L['Highlight' .. name])
    button:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, -5)
    button:SetChecked(not Combuctor:GetSetting('disable' .. name))
    button:SetScript('OnClick', function()
        Combuctor:ToggleSetting('disable' .. name)
        Combuctor:UpdateFrames()
    end)

    anchor = button
end

local TipCounts = General:NewCheckButton(L.TipCounts, L.TipCountsTip)
TipCounts:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, -5)
TipCounts:SetChecked(Combuctor:IsTipCountEnabled())
TipCounts:SetScript('OnClick', function()
    Combuctor:ToggleTipCounts()
end)

function General:OnFrameChanged()
    frame = Combuctor:GetFrame(Addon.frame)

    Managed:SetChecked(not frame.sets.position)
    Reversed:SetChecked(frame:IsSideFilterOnLeft())
end