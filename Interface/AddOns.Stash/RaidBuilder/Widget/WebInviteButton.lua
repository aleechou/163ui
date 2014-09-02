
BuildEnv(...)

WebInviteButton = RaidBuilder:NewClass('WebInviteButton', 'Button')

function WebInviteButton:Constructor(parent)
    if not parent then
        return
    end

    self:SetParent(parent)
    self:SetSize(16, 16)
    self:SetPoint('TOPRIGHT', -50, -6)
    self:SetNormalTexture([[Interface\AddOns\RaidBuilder\Media\Logo\400]])
    self:SetHighlightTexture([[Interface\AddOns\RaidBuilder\Media\Logo\400]], 'ADD')
    self:GetNormalTexture():SetAlpha(0.5)

    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', GameTooltip_Hide)

    local Message = self:CreateFontString(nil, 'ARTWORK', 'FriendsFont_Small')
    Message:SetPoint('TOPRIGHT', parent, 'TOPRIGHT', -20, -30)
    Message:SetText(L['集合石网站预约活动请求'])
end

function WebInviteButton:SetInfo(stamp, leaderName, selfName, eventId, eventSource)
    self.inviteTime = date('%Y/%m/%d %H:%S')
    self.leaderName = leaderName
    self.selfName = selfName
    self.eventId = eventId
    self.eventSource = eventSource
    self.isCurrentCharacter = UnitIsUnit('player', Ambiguate(selfName, 'none'))
end

function WebInviteButton:OnEnter()
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
    GameTooltip:SetText(L['集合石网站预约活动请求'], 1, 1, 1)
    GameTooltip:AddDoubleLine(L['邀请团长：'], self.leaderName)
    GameTooltip:AddDoubleLine(L['邀请角色：'], self.selfName .. (self.isCurrentCharacter and '' or L['|cffff0000(非当前角色)|r']))
    GameTooltip:AddDoubleLine(L['邀请时间：'], self.inviteTime)
    GameTooltip:AddLine(' ')
    if self.eventId and self.eventSource then
        GameTooltip:AddLine(L['点击验证活动详情'], 1, 0, 0)
    else
        GameTooltip:AddLine(L['请验证请求是否合法'], 1, 0, 0)
    end
    GameTooltip:Show()
end

function WebInviteButton:OnClick()
    if self.eventId and self.eventSource then
        GUI:CallUrlDialog(GetWebEventUrl(self.eventId, self.eventSource))
    end
end
