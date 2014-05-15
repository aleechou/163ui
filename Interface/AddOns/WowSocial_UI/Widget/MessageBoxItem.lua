
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local MessageBoxItem = CloudUI:NewClass('MessageBoxItem', GUI:GetClass('ItemButton'))

function MessageBoxItem:Constructor()
    local Count = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
    Count:SetPoint('RIGHT')

    local Text = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmallLeft')
    Text:SetPoint('LEFT')

    self:SetHighlightTexture([[INTERFACE\QUESTFRAME\UI-QuestTitleHighlight]], 'ADD')

    self.Count = Count
    self.Text = Text
end

function MessageBoxItem:SetText(text)
    self.Text:SetText(text)
end

function MessageBoxItem:SetCount(count)
    self.Count:SetText(count)
end

function MessageBoxItem:GetAutoWidth()
    return self.Text:GetStringWidth() + self.Count:GetStringWidth() + 20
end
