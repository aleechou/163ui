
BuildEnv(...)

BrowseParent = RaidBuilder:NewModule(CreateFrame('Frame', nil, MainPanel), 'BrowseParent')

function BrowseParent:OnInitialize()
    GUI:Embed(self, 'Owner', 'Refresh')

    MainPanel:RegisterPanel(L['查找活动'], self, 5, 90)

    self:SetScript('OnShow', self.Refresh)
end

function BrowseParent:Update()
    if BatchApply:IsWorking() then
        self:OpenBatchPanel()
    else
        self:OpenBrowsePanel()
    end
end

function BrowseParent:OpenBrowsePanel()
    BrowsePanel:Show()
    BatchPanel:Hide()
    MainPanel:SetTopHeight(90)
end

function BrowseParent:OpenBatchPanel()
    BrowsePanel:Hide()
    BatchPanel:Show()
    MainPanel:SetTopHeight(70)
end
