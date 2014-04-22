
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local InvitePanel = CloudUI:NewModule(
    CreateFrame('Frame', nil, UIParent, 'TranslucentFrameTemplate'),
    'InvitePanel',
    'AceEvent-3.0', 'AceTimer-3.0')

function InvitePanel:OnInitialize()
    self:Hide()
    self:SetSize(310, 188)
    self:SetPoint('CENTER')
    self:SetFrameStrata('DIALOG')

    LibStub('NetEaseGUI-1.0'):RegisterUIPanel(self)

    local bg = self:CreateTexture(nil, 'BACKGROUND')
    bg:SetSize(287, 116)
    bg:SetPoint('TOP', 0, -12)
    bg:SetTexture([[Interface\GuildFrame\GuildExtra]])
    bg:SetTexCoord(0.00195313, 0.56250000, 0.00781250, 0.91406250)

    local tabardBg = self:CreateTexture(nil, 'BORDER')
    tabardBg:SetSize(62, 62)
    tabardBg:SetPoint('BOTTOM', bg, 'BOTTOM', -1, -4)
    tabardBg:SetTexture([[Interface\GuildFrame\GuildFrame]])
    tabardBg:SetTexCoord(0.63183594, 0.69238281, 0.61914063, 0.74023438)

    local tabardEmblem = self:CreateTexture(nil, 'ARTWORK')
    tabardEmblem:SetSize(64, 64)
    tabardEmblem:SetPoint('CENTER', tabardBg, 'CENTER')

    local tabardRing = self:CreateTexture(nil, 'OVERLAY')
    tabardRing:SetSize(118, 76)
    tabardRing:SetPoint('BOTTOM', bg, 'BOTTOM', 0, -12)
    tabardRing:SetTexture([[Interface\GuildFrame\GuildExtra]])
    tabardRing:SetTexCoord(0.56640625, 0.79687500, 0.00781250, 0.60156250)

    local InviterName = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    InviterName:SetPoint('TOP', 0, -20)

    local inviteLabel = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
    inviteLabel:SetPoint('TOP', InviterName, 'TOP', 0, -14)
    inviteLabel:SetText(L['邀请你加入群组：'])

    local GroupName = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
    GroupName:SetPoint('TOP', inviteLabel, 'TOP', 0, -14)

    local AcceptButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    AcceptButton:SetPoint('BOTTOMLEFT', 24, 24)
    AcceptButton:SetSize(125, 22)
    AcceptButton:SetText(L['加入群组'])
    AcceptButton:SetScript('OnClick', function()
        self.accept = true
        self:Hide()
    end)

    local CancelButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    CancelButton:SetPoint('BOTTOMRIGHT', -24, 24)
    CancelButton:SetSize(125, 22)
    CancelButton:SetText(L['拒绝邀请'])
    CancelButton:SetScript('OnClick', function()
        self.accept = nil
        self:Hide()
    end)

    self.InviterName = InviterName
    self.GroupName = GroupName
    self.Icon = tabardEmblem

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    self:RegisterMessage('NECLOUD_GROUP_INVITE')
end

function InvitePanel:NECLOUD_GROUP_INVITE(event, name, gid, inviter, avatar)
    self.gid = gid

    self.InviterName:SetText(inviter)
    self.GroupName:SetText(name)
    SetPortraitToTexture(self.Icon, GetIconPath(avatar))

    StaticPopupSpecial_Show(self)
end

function InvitePanel:OnShow()
    self.accept = nil
    self:CancelAllTimers()
    self:ScheduleTimer('Hide', 60)
end

function InvitePanel:OnHide()
    self:CancelAllTimers()
    if self.accept then
        InviteChatGroupAccept(self.gid)
    else
        InviteChatGroupCancel(self.gid)
    end
    self.gid = nil
    self.accept = nil
    StaticPopupSpecial_Hide(self)
end
