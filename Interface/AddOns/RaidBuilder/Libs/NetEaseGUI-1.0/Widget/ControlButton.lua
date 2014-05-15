
local WIDGET, VERSION = 'ControlButton', 1

local GUI = LibStub('NetEaseGUI-1.0')
local ControlButton = GUI:NewClass(WIDGET, 'Button', VERSION)
if not ControlButton then
    return
end

local STYLES = {
    CLOSE = {
        NormalTexture    = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Up]],
        PushedTexture    = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Down]],
        DisableTexture   = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Disabled]],
        HighlightTexture = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
    },
    MINIMIZE = {
        NormalTexture    = [[INTERFACE\BUTTONS\UI-Panel-HideButton-Up]],
        PushedTexture    = [[INTERFACE\BUTTONS\UI-Panel-HideButton-Down]],
        DisableTexture   = [[INTERFACE\BUTTONS\UI-Panel-HideButton-Disabled]],
        HighlightTexture = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
    },
    BIGGER = {
        NormalTexture    = [[INTERFACE\BUTTONS\UI-Panel-BiggerButton-Up]],
        PushedTexture    = [[INTERFACE\BUTTONS\UI-Panel-BiggerButton-Down]],
        DisableTexture   = [[INTERFACE\BUTTONS\UI-Panel-BiggerButton-Disabled]],
        HighlightTexture = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
    },
    SMALLER = {
        NormalTexture    = [[INTERFACE\BUTTONS\UI-Panel-SmallerButton-Up]],
        PushedTexture    = [[INTERFACE\BUTTONS\UI-Panel-SmallerButton-Down]],
        DisableTexture   = [[INTERFACE\BUTTONS\UI-Panel-SmallerButton-Disabled]],
        HighlightTexture = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
    },
    COLLAPSE = {
        NormalTexture    = [[INTERFACE\BUTTONS\UI-Panel-CollapseButton-Up]],
        PushedTexture    = [[INTERFACE\BUTTONS\UI-Panel-CollapseButton-Down]],
        DisableTexture   = [[INTERFACE\BUTTONS\UI-Panel-CollapseButton-Disabled]],
        HighlightTexture = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
    },
    EXPAND = {
        NormalTexture    = [[INTERFACE\BUTTONS\UI-Panel-ExpandButton-Up]],
        PushedTexture    = [[INTERFACE\BUTTONS\UI-Panel-ExpandButton-Down]],
        DisableTexture   = [[INTERFACE\BUTTONS\UI-Panel-ExpandButton-Disabled]],
        HighlightTexture = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
    },
}

function ControlButton:Constructor(parent, style)
    local data = STYLES[style:upper()]
    if not data then
        error(([[Cannot create button by style '%s']]):format(style), 3)
    end
    self:SetParent(parent)
    self:SetSize(20, 20)
    self:SetNormalTexture(data.NormalTexture)
    self:SetPushedTexture(data.PushedTexture)
    self:SetDisabledTexture(data.DisableTexture)
    self:SetHighlightTexture(data.HighlightTexture, 'ADD')

    for i, region in ipairs({self:GetRegions()}) do
        region:SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125)
    end
end

function ControlButton:SetStyle(style)
    local data = STYLES[style:upper()]
    if not data then
        error(([[Cannot set button style by '%s']]):format(style), 2)
    end
    
    self:SetNormalTexture(data.NormalTexture)
    self:SetPushedTexture(data.PushedTexture)
    self:SetDisabledTexture(data.DisableTexture)
    self:SetHighlightTexture(data.HighlightTexture, 'ADD')
end

function ControlButton:RegisterStyle(style, data)
    if STYLES[style:upper()] then
        return
    end
    STYLES[style:upper()] = data
end
