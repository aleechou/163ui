
BuildEnv(...)

RemoteDataCache = RaidBuilder:NewModule(CreateFrame('Frame'), 'RemoteDataCache', 'AceEvent-3.0')

function RemoteDataCache:OnInitialize()
    local LogoData = DataCache:NewObject('LogoData')
    LogoData:SetCallback('OnCacheChanged', function(self, cache)
        self:SetData(cache)
    end)

    local MonthData = DataCache:NewObject('LeaderScore')
    MonthData:SetCallback('OnCacheChanged', self.FormatLeaderScore)
    MonthData:SetCallback('OnDataChanged', function(_, data)
        self:SendMessage('RAIDBUILDER_LEADERBOARD_MONTHDATA_CHANGED', data)
    end)

    local TotalData = DataCache:NewObject('LeaderScoreTotal')
    TotalData:SetCallback('OnCacheChanged', self.FormatLeaderScore)
    TotalData:SetCallback('OnDataChanged', function(_, data)
        self:SendMessage('RAIDBUILDER_LEADERBOARD_TOTALDATA_CHANGED', data)
    end)

    local RecommendData = DataCache:NewObject('RecommendData')
    RecommendData:SetCallback('OnCacheChanged', self.FormatRecommendData)
    RecommendData:SetCallback('OnDataChanged', function(_, data)
        self:SendMessage('RAIDBUILDER_RECOMMENDDATA_CHANGED', data)
    end)

    local FinderData = DataCache:NewObject('FinderData')
    FinderData:SetCallback('OnCacheChanged', function(self, cache)
        if type(cache) == 'table' then
            self:SetData(cache)
        end
    end)
    FinderData:SetCallback('OnDataChanged', function(_, data)
        self:SendMessage('RAIDBUILDER_FINDERDATA_CHANGED', data)
    end)

    DataCache:NewObject('AnnData'):SetCallback('OnCacheChanged', function(self, cache)
        Profile:AddAnnData(cache.title, cache.content)
    end)

    local MallData = DataCache:NewObject('MallData')
    MallData:SetCallback('OnCacheChanged', function(MallData, cache, isNew)
        self:FormatMallData(cache, isNew)
    end)
    MallData:SetCallback('OnDataChanged', function(MallData, data)
        self:SendMessage('RAIDBUILDER_MALL_PRODUCT_LIST_UPDATED', data, MallData.isNew)
    end)

    self.LogoData = LogoData
    self.MonthData = MonthData
    self.TotalData = TotalData
    self.RecommendData = RecommendData
    self.MallData = MallData
end

function RemoteDataCache:FormatRecommendData(cache)
    local control, eventName, level, maxMembers, roleNum = cache[1]:match('([@!]?)([^ !@]*)#(%d+)#(%d+)#(.*)%s*$')

    -- InsertMenuTable(L['本周悬赏'], eventName, 0x00200001, control, level, maxMembers, roleNum, true)

    self:SetData(eventName)
end

function RemoteDataCache:FormatLeaderScore(cache)
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

function RemoteDataCache:GetCurrentRecommend()
    return self.RecommendData:GetData()
end

function RemoteDataCache:IsCurrentRecommendNew()
    return self.RecommendData:IsNew()
end

function RemoteDataCache:ReadCurrentRecommend()
    self.RecommendData:SetIsNew(false)
    self:SendMessage('RAIDBUILDER_RECOMMENDDATA_CHANGED')
end

local function FormatMallGood(encode)
    local good = {(';'):split(encode, 7)}
    for i = 1, #good do
        if good[i] == '' then
            good[i] = nil
        end
    end
    return unpack(good)
end

function RemoteDataCache:FormatMallData(cache, isNew)
    if self.MallData:GetData() and not isNew then
        return
    end

    local productList = {}
    local pFaction = UnitFactionGroup('player') == 'Alliance' and '1' or '2'

    for k, v in pairs(cache) do
        local categoryText, categoryOrder, new = ('#'):split(k)
        categoryOrder = tonumber(categoryOrder)

        local goods = {('#'):split(v)}

        local category = {
            text = categoryText,
            coord = MALL_CATEGORY_ICON_LIST[categoryOrder % 7],
            new = new,
            item = {},
        }

        for i, item in ipairs(goods) do
            local id, price, itemId, model, faction, text, tip = FormatMallGood(item)
            if not faction or faction == pFaction then
                tinsert(category.item, {
                    id = id,
                    text = text,
                    price = price,
                    tip = tip and {('@'):split(tip)},
                    itemId = itemId,
                    model = model,
                    })
            end
        end

        productList[categoryOrder] = category
    end

    self.MallData.isNew = isNew
    self.MallData:SetData(productList)
end
