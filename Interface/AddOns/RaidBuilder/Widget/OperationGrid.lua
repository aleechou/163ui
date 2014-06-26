
BuildEnv(...)

local OperationGrid = RaidBuilder:NewClass('OperationGrid', GUI:GetClass('DataGridViewGridItem'))

local function ButtonOnClick(self)
    self:GetParent():GetParent():FireHandler(self.Handler)
end

function OperationGrid:Constructor()
    local AcceptButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    AcceptButton:SetSize(60, 22)
    AcceptButton:SetPoint('LEFT', 5, 0)
    AcceptButton:SetText(L['邀请'])
    AcceptButton:SetScript('OnClick', ButtonOnClick)
    AcceptButton.Handler = 'OnItemAccept'

    local RefuseButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    RefuseButton:SetSize(60, 22)
    RefuseButton:SetPoint('LEFT', AcceptButton, 'RIGHT', 5, 0)
    RefuseButton:SetText(L['拒绝'])
    RefuseButton:SetScript('OnClick', ButtonOnClick)
    RefuseButton.Handler = 'OnItemRefuse'

    local BanButton = GUI:GetClass('ClearButton'):New(self)
    BanButton:SetPoint('LEFT', RefuseButton, 'RIGHT', 5, 0)
    GUI:SetTooltip(BanButton, 'ANCHOR_RIGHT', L['加入到黑名单'])
    BanButton:SetScript('OnClick', ButtonOnClick)
    BanButton.Handler = 'OnItemBan'

    local StatusText = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    StatusText:SetPoint('LEFT', AcceptButton, 'LEFT')

    self.AcceptButton = AcceptButton
    self.RefuseButton = RefuseButton
    self.BanButton = BanButton
    self.StatusText = StatusText
end

function OperationGrid:SetMember(member)
    local status = Invite:GetMemberStatus(member:GetName())

    if status == INVITE_STATUS_UNKNOWN then
        self.AcceptButton:Show()
        self.RefuseButton:Show()
        self.BanButton:Show()
        self.StatusText:Hide()
        self.AcceptButton:SetEnabled(PlayerIsGroupLeader())
    else
        self.AcceptButton:Hide()
        self.RefuseButton:Hide()
        self.BanButton:Hide()
        self.StatusText:Show()

        self.StatusText:SetText(INVITE_STATUS_NAMES[status])
    end
end

local WebOperationGrid = RaidBuilder:NewClass('WebOperationGrid', GUI:GetClass('DataGridViewGridItem'))

function WebOperationGrid:Constructor()
    local GotoButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    GotoButton:SetSize(60, 22)
    GotoButton:SetPoint('LEFT', 5, 0)
    GotoButton:SetText(L['转到'])
    GotoButton:SetScript('OnClick', ButtonOnClick)
    GotoButton.Handler = 'OnItemGoto'
end

local RecentOperationGrid = RaidBuilder:NewClass('RecentOperationGrid', GUI:GetClass('DataGridViewGridItem'))

function RecentOperationGrid:Constructor()
    local AddFriendButton = CreateFrame('Button', nil, self)
    AddFriendButton:SetSize(16, 16)
    AddFriendButton:SetPoint('LEFT', 15, 0)
    AddFriendButton:SetNormalTexture([[INTERFACE\BUTTONS\UI-PlusButton-Up]])
    AddFriendButton:SetPushedTexture([[INTERFACE\BUTTONS\UI-PlusButton-Down]])
    AddFriendButton:SetDisabledTexture([[INTERFACE\BUTTONS\UI-PlusButton-Disabled]])
    AddFriendButton:SetHighlightTexture([[INTERFACE\BUTTONS\UI-PlusButton-Hilight]], 'ADD')
    AddFriendButton:SetScript('OnClick', ButtonOnClick)
    AddFriendButton.Handler = 'OnAddFriend'

    GUI:SetTooltip(AddFriendButton, 'ANCHOR_RIGHT', ADD_FRIEND)
end

function RecentOperationGrid:SetStatus(status)
    self:SetShown(status)
end
