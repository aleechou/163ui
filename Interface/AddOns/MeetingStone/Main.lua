
BuildEnv(...)

Addon = LibStub('AceAddon-3.0'):NewAddon('MeetingStone', 'AceEvent-3.0', 'LibModule-1.0', 'LibClass-1.0', 'AceHook-3.0')

GUI = LibStub('NetEaseGUI-1.0')

function Addon:OnInitialize()
    self:RawHook('LFGListUtil_OpenBestWindow', 'Toggle', true)

    self:RegisterEvent('LFG_LIST_AVAILABILITY_UPDATE', 'MakeSortOrder')
    self:RegisterMessage('MEETINGSTONE_NEW_VERSION')
end

function Addon:OnEnable()
    if not IsAddOnLoaded('RaidBuilder') then
        return
    end

    DisableAddOn('RaidBuilder')
    GUI:CallWarningDialog(L.FoundRaidBuilder, true, nil, ReloadUI)
end

function Addon:MakeSortOrder()
    wipe(ACTIVITY_ORDER)
    local order = 0

    for _, categoryId in ipairs(C_LFGList.GetAvailableCategories(baseFilter)) do
        for _, activityId in ipairs(C_LFGList.GetAvailableActivities(categoryId)) do
            ACTIVITY_ORDER[activityId] = order

            order = order + 1
        end
    end
end

function Addon:MEETINGSTONE_NEW_VERSION(_, verion, url, isSupport, changeLog)
    version = format('%.02f', tonumber(version) or 0)
    if not isSupport then
        self.url = url
        self.changeLog = changeLog

        self:ShowNewVersion(url, changeLog)
    end

    if changeLog then
        System:Logf(L.NewVersionWithChangeLog, version, url, changeLog)
    else
        System:Logf(L.NewVersion, version, url)
    end
end

function Addon:Toggle()
    if Logic:IsSupport() then
        Addon:ToggleModule('MainPanel')
        MainPanel:SelectPanel(C_LFGList.GetActiveEntryInfo() and ManagerPanel or BrowsePanel)
    else
        self:ShowNewVersion(self.url, self.changeLog)
    end
end

function Addon:ShowNewVersion(url, changeLog)
    if changeLog then
        GUI:CallUrlDialog(url, format(L.NotSupportVersionWithChangeLog, changeLog), 1)
    else
        GUI:CallUrlDialog(url, L.NotSupportVersion, 1)
    end
end
