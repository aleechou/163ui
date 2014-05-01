
local WIDGET, VERSION = 'Panel', 3

local GUI = LibStub('NetEaseGUI-1.0')
local Panel = GUI:NewClass(WIDGET, 'Frame.NetEasePanelTemplate', VERSION)
if not Panel then
    return
end

function Panel:Constructor(parent)
    if not parent then
        return
    end
    self:SetParent(parent)
    self:EnableMouse(true)
    self:SetToplevel(true)
    self:SetSize(338, 424)

    self.PanelList = {}

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
end

function Panel:OnShow()
    PlaySound('igCharacterInfoOpen')
    self:UpdateTab()
end

function Panel:OnHide()
    PlaySound('igCharacterInfoClose')
end

Panel.ShowPortrait = ButtonFrameTemplate_ShowPortrait
Panel.HidePortrait = ButtonFrameTemplate_HidePortrait

function Panel:SetTopHeight(height)
    self.topHeight = height
    self.Inset:SetPoint('TOPLEFT', 4, -height)
end

function Panel:SetBottomHeight(height)
    self.bottomHeight = height
    self.Inset:SetPoint('BOTTOMRIGHT', -6, height)
end

function Panel:GetTopHeight()
    return self.topHeight or 60
end

function Panel:GetBottomHeight()
    return self.bottomHeight or 26
end

function Panel:SetIcon(texture, left, right, top, bottom)
    if texture == 'player' or texture == 'target' or texture == 'focus' or type(texture) == 'table' then
        SetPortraitTexture(self.portrait, type(texture) == 'table' and texture[1] or texture)
    elseif left then
        self.portrait:SetTexture(texture)
        self.portrait:SetTexCoord(left, right, top, bottom)
    else
        SetPortraitToTexture(self.portrait, texture)
        self.portrait:SetTexCoord(0, 1, 0, 1)
    end
end

function Panel:SetText(text)
    self.TitleText:SetText(text)
end

function Panel:GetText()
    return self.TitleText:GetText()
end

function Panel:SetArguments(...)
    self.args = {...}
end

function Panel:GetArguments()
    if self.args then
        return unpack(self.args)
    end
end

function Panel:EnableUIPanel(flag)
    self:SetPoint('CENTER')

    HideUIPanel(self)

    if flag then
        self:SetAttribute('UIPanelLayout-defined', true)
        self:SetAttribute('UIPanelLayout-enabled', true)
        self:SetAttribute('UIPanelLayout-whileDead', true)
        self:SetAttribute('UIPanelLayout-area', 'left')
        self:SetAttribute('UIPanelLayout-pushable', 1)
    else
        self:SetAttribute('UIPanelLayout-defined', false)
        self:SetAttribute('UIPanelLayout-enabled', false)
        self:SetAttribute('UIPanelLayout-whileDead', false)
        self:SetAttribute('UIPanelLayout-area', nil)
        self:SetAttribute('UIPanelLayout-pushable', nil)
    end
end

function Panel:EnableTabFrame(flag)
    self.noTab = not flag or nil
    if self.TabFrame then
        self.TabFrame:Hide()
    end
end

function Panel:Open(name, icon, ...)
    self:SetArguments(...)
    self:SetText(name)
    self:SetIcon(icon)

    ShowUIPanel(self)
end

function Panel:Refresh()
    for i, v in ipairs(self.PanelList) do
        v.panel:Refresh()
    end
    if self.TabFrame then
        self.TabFrame:Refresh()
    end
end

function Panel:SetTabStyle(style)
    self.tabStyle = style
end

function Panel:GetTabFrame()
    if self.noTab then
        return
    end
    if self.TabFrame then
        return self.TabFrame
    end
    if not self.tabStyle or self.tabStyle == 'IN' then
        local TabFrame = GUI:GetClass('TabView'):New(self)
        TabFrame:SetSize(1, 22)
        TabFrame:SetPoint('BOTTOMLEFT', self.Inset, 'TOPLEFT', 55, 0)
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
        return TabFrame
    elseif self.tabStyle == 'BOTTOM' then
        local TabFrame = GUI:GetClass('TabView'):New(self)
        TabFrame:SetSize(1, 22)
        TabFrame:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 10, -8)
        TabFrame:EnableMenu(nil)
        TabFrame:SetItemClass(GUI:GetClass('BottomTabButton'))
        TabFrame:SetItemList(self.PanelList)
        TabFrame:SetCallback('OnItemFormatted', function(tabframe, button, data)
            button:SetText(data.name)
        end)
        TabFrame:SetCallback('OnSelectChanged', function(tabframe, index, data)
            for i, data in ipairs(self.PanelList) do
                if i == index then
                    data.panel:Show()
                    self:SetTopHeight(data.topHeight)
                    self:SetBottomHeight(data.bottomHeight)
                else
                    data.panel:Hide()
                end
            end
        end)
        self.TabFrame = TabFrame
        return TabFrame
    end
end

function Panel:UpdateTab()
    if not self.noTab then
        self:GetTabFrame():SetSelected(self.selectTab or 1)
        self.selectTab = nil
    else
        if self.PanelList[1] then
            self.PanelList[1].panel:Show()
        end
    end
end

local function OnShow(panel)
    if type(panel.Load) == 'function' then
        panel:Load()
        panel.Load = nil
    end
    local newOnShow = panel:GetScript('OnShow')
    if not newOnShow then
        return
    end
    if newOnShow == OnShow then
        panel:SetScript('OnShow', nil)
    else
        newOnShow(panel)
    end
end

function Panel:RegisterPanel(name, panel, padding, topHeight, bottomHeight)
    if self.noTab then
        if #self.PanelList > 0 then
            error([[Can register only one panel into notab container.]], 2)
        end
    end
    if self:IsPanelRegistered(name) then
        error([[Cannot register panel (same name)]], 2)
    end

    tinsert(self.PanelList, {
        name = name,
        panel = panel,
        topHeight = topHeight or self:GetTopHeight(),
        bottomHeight = bottomHeight or self:GetBottomHeight(),
    })

    padding = padding or 10

    panel:Hide()
    panel:SetOwner(self)
    panel:SetParent(self.Inset)
    panel:ClearAllPoints()
    panel:SetPoint('TOPLEFT', padding, -padding)
    panel:SetPoint('BOTTOMRIGHT', -padding, padding)
    panel:SetScript('OnShow', OnShow)
end

function Panel:UnregisterPanel(name)
    local i, v = self:IsPanelRegistered(name)
    if i then
        tremove(self.PanelList, i)

        v.panel:Hide()
        v.panel:ClearAllPoints()
        v.panel:SetParent(nil)
    end
end

function Panel:IsPanelRegistered(name)
    for i, v in ipairs(self.PanelList) do
        if v.name == name then
            return i, v
        end
    end
end

function Panel:UnregisterAllPanels()
    for i, v in ipairs(self.PanelList) do
        v.panel:Hide()
        v.panel:ClearAllPoints()
        v.panel:SetParent(nil)
    end
    wipe(self.PanelList)
end

function Panel:EnableTab(index)
    local tabframe = self:GetTabFrame()
    if tabframe then
        tabframe:EnableTab(index)
    end
end

function Panel:DisableTab(index)
    local tabframe = self:GetTabFrame()
    if tabframe then
        tabframe:DisableTab(index)
    end
end

function Panel:SetTabEnabled(index, flag)
    local tabframe = self:GetTabFrame()
    if tabframe then
        tabframe:SetTabEnabled(index, flag)
    end
end

function Panel:SelectTab(index)
    self.selectTab = index
    local tabframe = self:GetTabFrame()
    if tabframe then
        tabframe:SetSelected(index)
    end
end

function Panel:SetTabText(index, text)
    local tabframe = self:GetTabFrame()
    if not tabframe then
        return
    end
    if self.PanelList and self.PanelList[index] then
        self.PanelList[index].name = text
    end
    tabframe:Refresh()
end

function Panel:GetPanelIndex(panel)
    for i, v in ipairs(self.PanelList) do
        if v.panel == panel then
            return i
        end
    end
end

function Panel:SelectPanel(panel)
    local index = self:GetPanelIndex(panel)
    if index then
        self:SelectTab(index)
    end
end

function Panel:EnablePanel(panel)
    local index = self:GetPanelIndex(panel)
    if index then
        self:EnableTab(index)
    end
end

function Panel:DisablePanel(panel)
    local index = self:GetPanelIndex(panel)
    if index then
        self:DisableTab(index)
    end
end

function Panel:SetPanelEnabled(panel, flag)
    local index = self:GetPanelIndex(panel)
    if index then
        self:SetTabEnabled(index, flag)
    end
end

function Panel:SetPanelText(panel, text)
    local index = self:GetPanelIndex(panel)
    if index then
        self:SetTabText(index, text)
    end
end

function Panel:GetSelectedTab()
    local tabframe = self:GetTabFrame()
    if tabframe then
        return tabframe:GetSelected()
    end
end

function Panel:GetSelectedPanel()
    local index = self:GetSelectedTab()
    return self.PanelList[index] and self.PanelList[index].panel
end

local function unpack(t, ...)
    if type(t) == 'table' then
        return _G.unpack(t, ...)
    else
        return t, ...
    end
end

function Panel:CreateTitleButton(t)
    self.titleButtons = self.titleButtons or {}

    local button = GUI:GetClass('TitleButton'):New(self)
    button:SetScript('OnClick', t.callback or t.onClick)
    button:SetTexture(t.texture, unpack(t.coords))
    button:SetTooltip(t.title or t.text, unpack(t.notes))

    if #self.titleButtons == 0 then
        button:SetPoint('TOPRIGHT', -30, -3)
    else
        button:SetPoint('RIGHT', self.titleButtons[#self.titleButtons], 'LEFT', -1, 0)
    end

    tinsert(self.titleButtons, button)
    return button
end
