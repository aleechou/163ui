
BuildEnv(...)

MallPanel = RaidBuilder:NewModule(GUI:GetClass('InTabPanel'):New(MainPanel), 'MallPanel')

function MallPanel:OnInitialize()
    GUI:Embed(self, 'Owner')
    self.TabFrame:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 60, 0)

    MainPanel:RegisterPanel(L['兑换平台'], self, 0, 70)
end

