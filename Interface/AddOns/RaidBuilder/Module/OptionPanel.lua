
BuildEnv(...)

OptionPanel = RaidBuilder:NewModule(GUI:GetClass('InTabPanel'):New(MainPanel), 'OptionPanel')

function OptionPanel:OnInitialize()
    GUI:Embed(self, 'Owner')
    self.TabFrame:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 60, 0)

    MainPanel:RegisterPanel(L['设置'], self, 0, 70)
end
