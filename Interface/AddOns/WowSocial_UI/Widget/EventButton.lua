
local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local EventButton = CloudUI:NewClass('EventButton', GUI:GetClass('ItemButton'))

local CALENDAR_EVENTCOLOR_MODERATOR = {r=0.54, g=0.75, b=1.0}

local CALENDAR_INVITESTATUS_INFO = {
    ['UNKNOWN'] = {
        name        = UNKNOWN,
        color       = NORMAL_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_CONFIRMED] = {
        name        = CALENDAR_STATUS_CONFIRMED,
        color       = GREEN_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_ACCEPTED] = {
        name        = CALENDAR_STATUS_ACCEPTED,
        color       = GREEN_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_DECLINED] = {
        name        = CALENDAR_STATUS_DECLINED,
        color       = RED_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_OUT] = {
        name        = CALENDAR_STATUS_OUT,
        color       = RED_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_STANDBY] = {
        name        = CALENDAR_STATUS_STANDBY,
        color       = ORANGE_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_INVITED] = {
        name        = CALENDAR_STATUS_INVITED,
        color       = NORMAL_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_SIGNEDUP] = {
        name        = CALENDAR_STATUS_SIGNEDUP,
        color       = GREEN_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_NOT_SIGNEDUP] = {
        name        = CALENDAR_STATUS_NOT_SIGNEDUP,
        color       = NORMAL_FONT_COLOR,
    },
    [CALENDAR_INVITESTATUS_TENTATIVE] = {
        name        = CALENDAR_STATUS_TENTATIVE,
        color       = ORANGE_FONT_COLOR,
    },
}

local CALENDAR_EVENTTYPE_TEXTURE_PATHS = {
    [CALENDAR_EVENTTYPE_RAID]       = [[Interface\LFGFrame\LFGIcon-]],
    [CALENDAR_EVENTTYPE_DUNGEON]    = [[Interface\LFGFrame\LFGIcon-]],
    [CALENDAR_EVENTTYPE_HEROIC_DUNGEON] = [[Interface\LFGFrame\LFGIcon-]],
}

local CALENDAR_EVENTTYPE_TEXTURES = {
    [CALENDAR_EVENTTYPE_RAID]       = [[Interface\LFGFrame\LFGIcon-Raid]],
    [CALENDAR_EVENTTYPE_DUNGEON]    = [[Interface\LFGFrame\LFGIcon-Dungeon]],
    [CALENDAR_EVENTTYPE_PVP]        = [[Interface\Calendar\UI-Calendar-Event-PVP]],
    [CALENDAR_EVENTTYPE_MEETING]    = [[Interface\Calendar\MeetingIcon]],
    [CALENDAR_EVENTTYPE_OTHER]      = [[Interface\Calendar\UI-Calendar-Event-Other]],
    [CALENDAR_EVENTTYPE_HEROIC_DUNGEON] = [[Interface\LFGFrame\LFGIcon-Dungeon]],
}

local function GetEventStatusInfo(inviteStatus)
    return CALENDAR_INVITESTATUS_INFO[inviteStatus] or CALENDAR_INVITESTATUS_INFO['UNKNOWN']
end

local function GetTextureFile(textureName, eventType)
    local texture
    if ( textureName and textureName ~= '' ) then
        if ( CALENDAR_EVENTTYPE_TEXTURE_PATHS[eventType] ) then
            texture = CALENDAR_EVENTTYPE_TEXTURE_PATHS[eventType]..textureName
        elseif ( CALENDAR_EVENTTYPE_TEXTURES[eventType] ) then
            texture = CALENDAR_EVENTTYPE_TEXTURES[eventType]
        end
    elseif ( CALENDAR_EVENTTYPE_TEXTURES[eventType] ) then
        texture = CALENDAR_EVENTTYPE_TEXTURES[eventType]
    end
    return texture
end

function EventButton:Constructor(parent)
    local Icon = self:CreateTexture(nil, 'ARTWORK')
    Icon:SetPoint('LEFT')

    local Time = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmallLeft')
    Time:SetPoint('BOTTOMLEFT', Icon, 'BOTTOMRIGHT', 5, 0)

    local Status = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmallRight')
    Status:SetPoint('TOPRIGHT')    

    local Name = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmallLeft')
    Name:SetPoint('TOPLEFT', Icon, 'TOPRIGHT', 5, 0)
    Name:SetPoint('RIGHT', Status, 'LEFT', -2, 0)

    self:SetHighlightTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar-Blue]], 'ADD')

    self.Name = Name
    self.Time = Time
    self.Status = Status
    self.Icon = Icon

    self:SetScript('OnSizeChanged', self.OnSizeChanged)
end

function EventButton:OnSizeChanged(width, height)
    self.Icon:SetSize(height, height)
end

function EventButton:SetData(d)
    self.Name:SetText(d.text)
    self.Time:SetText(('%d/%d %02d:%02d'):format(d.month, d.day, d.hour, d.minute))
    self.Icon:SetTexture(GetTextureFile(d.texture, d.eventType))
    
    local info = GetEventStatusInfo(d.inviteStatus)

    self.Status:SetText(info.name)
    self.Status:SetTextColor(info.color.r, info.color.g, info.color.b)
end
