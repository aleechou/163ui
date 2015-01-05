
local GUI = assert(LibStub('NetEaseGUI-1.0'), 'NetEaseGUI-DropMenu-1.0 requests NetEaseGUI')

local WIDGET, VERSION = 'DropMenuItem', 1
local DropMenuItem = GUI:NewClass('DropMenuItem', GUI:GetClass('ItemButton'))
if not DropMenuItem then
    return
end

local CHECK_COORDS = {
    MULTI_NORMAL  = {0.5, 1,   0,   0.5},
    MULTI_CHECKED = {0,   0.5, 0,   0.5},
    RADIO_NORMAL  = {0.5, 1,   0.5, 1  },
    RADIO_CHECKED = {0,   0.5, 0.5, 1  },
}

function DropMenuItem:Constructor()
    local CheckBox = self:CreateTexture(nil, 'OVERLAY')
    CheckBox:SetTexture([[INTERFACE\COMMON\UI-DropDownRadioChecks]])
    CheckBox:SetSize(16, 16)
    CheckBox:SetPoint('LEFT')

    local Arrow = self:CreateTexture(nil, 'OVERLAY')
    Arrow:SetTexture([[Interface\ChatFrame\ChatFrameExpandArrow]])
    Arrow:SetSize(16, 16)
    Arrow:SetPoint('RIGHT')

    local Text = self:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('LEFT', CheckBox, 'RIGHT', 2, 0)

    self:SetFontString(Text)
    self:SetNormalFontObject('GameFontHighlightSmallLeft')
    self:SetDisabledFontObject('GameFontNormalSmallLeft')

    self:SetHighlightTexture([[INTERFACE\QUESTFRAME\UI-QuestTitleHighlight]], 'ADD')

    self.CheckBox = CheckBox
    self.Text = Text
    self.Arrow = Arrow
end

function DropMenuItem:SetCheckStatus(checkable, isNotRadio, checked)
    if checkable then
        if isNotRadio then
            self.CheckBox:SetTexCoord(unpack(CHECK_COORDS[checked and 'MULTI_CHECKED' or 'MULTI_NORMAL']))
        else
            self.CheckBox:SetTexCoord(unpack(CHECK_COORDS[checked and 'RADIO_CHECKED' or 'RADIO_NORMAL']))
        end
        self.Text:SetPoint('LEFT', self.CheckBox, 'RIGHT', 2, 0)
        self.CheckBox:Show()
    else
        self.Text:SetPoint('LEFT')
        self.CheckBox:Hide()
    end
end

function DropMenuItem:SetHasArrow(hasArrow)
    self.Arrow:SetShown(hasArrow)
end

function DropMenuItem:GetAutoWidth()
    return self.Text:GetStringWidth() + 
        (self.Arrow:IsShown() and 18 or 0) +
        (self.CheckBox:IsShown() and 18 or 0)
end
