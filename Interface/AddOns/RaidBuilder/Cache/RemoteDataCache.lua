
BuildEnv(...)

RemoteDataCache = RaidBuilder:NewModule(CreateFrame('Frame'), 'RemoteDataCache', 'AceEvent-3.0')

function RemoteDataCache:OnInitialize()
    local LogoData = DataCache:NewObject('LogoData')
    LogoData:SetCallback('OnCacheChanged', function(self, cache)
        self:SetData(cache)
    end)

    local MonthData = DataCache:NewObject('LeaderScore')
    MonthData:SetCallback('OnCacheChanged', function(self, cache)
        local data = {}
        for k, v in pairs(cache) do
            tinsert(data, {
                name = k,
                score = v,
            })
        end
        sort(data, function(a, b)
            return a.score > b.score
        end)
        for i, v in ipairs(data) do
            v.rank = i
        end
        self:SetData(data)
        self:SetCache(cache)
    end)
    MonthData:SetCallback('OnDataChanged', function(_, data)
        self:SendMessage('RAIDBUILDER_LEADERBOARD_MONTHDATA_CHANGED', data)
    end)

    local TotalData = DataCache:NewObject('LeaderScoreTotal')
    TotalData:SetCallback('OnCacheChanged', function(self, cache)
        local data = {}
        for k, v in pairs(cache) do
            tinsert(data, {
                name = k,
                score = v,
            })
        end
        sort(data, function(a, b)
            return a.score > b.score
        end)
        for i, v in ipairs(data) do
            v.rank = i
        end
        self:SetData(data)
        self:SetCache(cache)
    end)
    TotalData:SetCallback('OnDataChanged', function(_, data)
        self:SendMessage('RAIDBUILDER_LEADERBOARD_TOTALDATA_CHANGED', data)
    end)

    self.LogoData = LogoData
    self.MonthData = MonthData
    self.TotalData = TotalData
end

function RemoteDataCache:GetLogoIndex(name, btag)
    local data = self.LogoData:GetData()
    
    if not data then
        return
    end

    return data[name] or data[btag]
end

function RemoteDataCache:GetLeaderBoardIndex(name)
    if self.TotalData:GetCache()[name] then
        return UNIT_LOGO_TOTAL
    end
    if self.MonthData:GetCache()[name] then
        return UNIT_LOGO_MONTH
    end
end
