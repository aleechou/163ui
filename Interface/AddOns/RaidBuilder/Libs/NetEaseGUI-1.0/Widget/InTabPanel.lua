
local WIDGET, VERSION = 'InTabPanel', 1

local GUI = LibStub('NetEaseGUI-1.0')
local InTabPanel = GUI:NewClass(WIDGET, 'Frame', VERSION)
if not InTabPanel then
    return
end

local Panel = GUI:GetClass('Panel')

function InTabPanel:Constructor(...)
    self.PanelList = {}

    local TabFrame = GUI:GetClass('TabView'):New(self)
    TabFrame:SetSize(1, 22)
    TabFrame:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 10, 0)
    TabFrame:EnableMenu(nil)
    TabFrame:SetItemClass(GUI:GetClass('InTabButton'))
    TabFrame:SetItemList(self.PanelList)
    TabFrame:SetCallback('OnItemFormatted', function(tabframe, button, data)
        button:SetText(data.name)
    end)
    TabFrame:SetCallback('OnSelectChanged', function(tabframe, index, data)
        for i, data in ipairs(self.PanelList) do
            data.panel:SetShown(i == index)
        end
    end)

    self.TabFrame = TabFrame
    self.Inset = self

    self:SetScript('OnShow', self.UpdateTab)
end

InTabPanel.UpdateTab = Panel.UpdateTab
InTabPanel.RegisterPanel = Panel.RegisterPanel
InTabPanel.UnregisterPanel = Panel.UnregisterPanel
InTabPanel.IsPanelRegistered = Panel.IsPanelRegistered
InTabPanel.UnregisterAllPanels = Panel.UnregisterAllPanels
InTabPanel.EnableTab = Panel.EnableTab
InTabPanel.DisableTab = Panel.DisableTab
InTabPanel.SetTabEnabled = Panel.SetTabEnabled
InTabPanel.SelectTab = Panel.SelectTab
InTabPanel.SetTabText = Panel.SetTabText
InTabPanel.GetPanelIndex = Panel.GetPanelIndex
InTabPanel.SelectPanel = Panel.SelectPanel
InTabPanel.EnablePanel = Panel.EnablePanel
InTabPanel.DisablePanel = Panel.DisablePanel
InTabPanel.SetPanelEnabled = Panel.SetPanelEnabled
InTabPanel.SetPanelText = Panel.SetPanelText
InTabPanel.GetSelectedTab = Panel.GetSelectedTab
InTabPanel.GetSelectedPanel = Panel.GetSelectedPanel

function InTabPanel:GetTabFrame()
    return self.TabFrame
end

function InTabPanel:GetTopHeight()
    return 0
end

InTabPanel.GetBottomHeight = InTabPanel.GetTopHeight
