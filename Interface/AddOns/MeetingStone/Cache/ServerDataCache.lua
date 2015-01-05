
BuildEnv(...)

local ServerDataCache = Addon:NewModule('ServerDataCache', 'AceEvent-3.0')

function ServerDataCache:OnInitialize()
    local AnnData = DataCache:NewObject('AnnData') do
        AnnData:SetCallback('OnCacheChanged', AnnData.SetData)
        -- AnnData:SetCallback('OnDataChanged', function(AnnData, data)
        --     self:SendMessage('MEETINGSTONE_ANN_UPDATE', data, AnnData:IsNew())
        -- end)
    end

    local MallData = DataCache:NewObject('MallData') do
        MallData:SetCallback('OnCacheChanged', function(MallData, cache, isNew)
            self:FormatMallData(cache, isNew)
        end)
        MallData:SetCallback('OnDataChanged', function(MallData, data)
            self:SendMessage('MEETINGSTONE_MALL_LIST_UPDATED', data, MallData:IsNew())
            MallData:SetIsNew(false)
        end)
    end

    self.MallData = MallData
end

local function FormatMallGood(encode)
    local good = {strsplit(';', encode)}
    for i = 1, #good do
        if good[i] == '' then
            good[i] = nil
        end
    end
    return unpack(good)
end

function ServerDataCache:FormatMallData(cache, isNew)
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
            local id, priceInfo, itemId, model, faction, text, tip = FormatMallGood(item)
            local price, discount = strsplit(',', priceInfo)

            if not faction or faction == pFaction then
                tinsert(category.item, {
                    id = id,
                    text = text,
                    price = price,
                    tip = tip and {strsplit('@', tip)},
                    itemId = itemId,
                    model = model,
                    })
            end
        end

        productList[categoryOrder] = category
    end

    self.MallData:SetData(productList)
end
