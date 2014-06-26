
BuildEnv(...)

RecentMemberPanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'RecentMemberPanel', 'AceEvent-3.0')

local BROAD_HEADER = {
    {
        key = 'name',
        text = L['角色名'],
        width = 113,
        style = 'LEFT',
        showHandler = function(data)
            local color = RAID_CLASS_COLORS[data.class]
            return color and format('|c%s%s|r', color.colorStr, data.name) or data.name
        end,
    },
    {
        key = 'realm',
        text = L['服务器'],
        width = 100,
        style = 'LEFT',
        showHandler = function(data)
            return data.realm
        end,
    },
    {
        key = 'race',
        text = L['种族'],
        width = 60,
        style = 'LEFT',
        showHandler = function(data)
            return data.race
        end,
    },
    {
        key = 'class',
        text = L['职业'],
        width = 60,
        style = 'ICON',
        showHandler = function(data)
            return nil, nil, nil, nil, [[Interface\TargetingFrame\UI-Classes-Circles]], unpack(CLASS_ICON_TCOORDS[data.class])
        end,
    },
    {
        key = 'level',
        text = L['等级'],
        width = 40,
        showHandler = function(data)
            return data.level
        end,
    },
    {
        key = 'battleTag',
        text = L['战网昵称'],
        width = 150,
        style = 'LEFT',
        showHandler = function(data)
            return data.battleTag
        end,
    },
    {
        key = 'from',
        text = L['来自'],
        width = 120,
        style = 'LEFT',
        showHandler = function(data)
            return data.from
        end,
    },
    {
        key = 'recordDate',
        text = L['组队日期'],
        width = 120,
        style = 'LEFT',
        showHandler = function(data)
            return date('%Y-%m-%d %H:%M', data.recordDate)
        end,
    },
    {
        key = 'Option',
        text = L['操作'],
        width = 50,
        class = RaidBuilder:GetClass('RecentOperationGrid'),
        formatHandler = function(grid, data)
            grid:SetStatus(not Invite:UnitIsFriend(data.name, data.realm, data.battleTag))
        end,
    }
}

function RecentMemberPanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    OptionPanel:RegisterPanel(L['最近组队'], self, 0)

    self:ClearAllPoints()
    self:SetPoint('TOPLEFT', 0, -25)
    self:SetPoint('BOTTOMRIGHT')

    local RecentList = GUI:GetClass('DataGridView'):New(self)
    RecentList:SetPoint('TOPLEFT', 8, 0)
    RecentList:SetPoint('BOTTOMRIGHT', -8, 8)
    RecentList:SetItemHeight(30)
    RecentList:SetItemSpacing(3)
    RecentList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    RecentList:InitHeader(BROAD_HEADER)
    RecentList:SetHeaderPoint('BOTTOMLEFT', RecentList, 'TOPLEFT', 0, 0)
    RecentList:SetSortHandler(function(data)
        return - data.recordDate
    end)
    RecentList:SetCallback('OnAddFriend', function(_, _, data)
        Invite:AddFriend(data.name, data.realm, data.battleTag)
    end)

    local Tips = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    Tips:SetPoint('BOTTOMRIGHT', self:GetOwner():GetOwner(), -7, 7)
    Tips:SetText(L['|cffff0000记录您最近参加的集合石活动人员名单（80名）|r'])

    self:RegisterMessage('RAIDBUILDER_RECENTLIST_UPDATE', 'Update')
    self:RegisterMessage('RAIDBUILDER_UNIT_INFO_UPDATE', 'Add')
    self:SetScript('OnShow', self.Refresh)
    self.RecentList = RecentList
end

function RecentMemberPanel:Update()
    local RecentList = self.RecentList
    local list = RecentList:GetItemList() or {}
    wipe(list)

    for k, v in ipairs(Profile:GetRecentList()) do
        tinsert(list, {
            name        = v.name,
            realm       = v.realm,
            race        = v.race,
            class       = v.class,
            level       = v.level,
            battleTag   = v.battleTag,
            from        = v.from,
            recordDate  = v.recordDate,
            })
    end

    if RecentList:GetItemList() ~= list then
        RecentList:SetItemList(list) 
    end

    RecentList:Refresh()

    for i, v in ipairs(RecentList.sortButtons) do
        v:SetShown(not(#list == 0))
    end
end

function RecentMemberPanel:Add(event, unitInfo)
    if not unitInfo then
        return
    end

    local fullName = unitInfo:GetName()

    if UnitIsUnit('player', fullName) then
        return
    end

    local eventName = GroupCache:GetCurrentEventName()

    if eventName == L['当前没有活动'] then
        return
    end

    local name, realm = ('-'):split(fullName)
    local race = UnitRace(fullName)
    Profile:AddRecentList(name, realm or GetRealmName(), race, unitInfo:GetClass(), unitInfo:GetLevel(), unitInfo:GetBattleTag(), eventName)
end
