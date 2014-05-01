
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

    self.AcceptButton = AcceptButton
    self.RefuseButton = RefuseButton
end
