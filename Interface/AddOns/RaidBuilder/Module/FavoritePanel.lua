
BuildEnv(...)

FavoritePanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'FavoritePanel', 'AceEvent-3.0')

local BROAD_HEADER = {
    {
        key = 'B-Tag',
        text = L['战网昵称'],
        width = 200,
        style = 'LEFT',
        showHandler = function(data)
            return data.btag
        end,
    },
    {
        key = 'Time',
        text = L['添加时间'],
        width = 200,
        style = 'LEFT',
        showHandler = function(data)
            return date('%Y-%m-%d %H:%M', data.recordDate)
        end,
    },
    {
        key = 'Reason',
        text = L['注释'],
        width = 408,
        style = 'LEFT',
        showHandler = function(data)
            return data.reason
        end,
    },
}

function FavoritePanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    OptionPanel:RegisterPanel(L['关注列表'], self, 0)

    self:ClearAllPoints()
    self:SetPoint('TOPLEFT', 0, -25)
    self:SetPoint('BOTTOMRIGHT')

    local DelButton = GUI:GetClass('ClearButton'):New(self)
    DelButton:SetScript('OnClick', function(DelButton)
        self:Del(DelButton.btag)
    end)
    GUI:SetTooltip(DelButton, 'ANCHOR_RIGHT', L['取消关注'])

    local FavoriteList = GUI:GetClass('DataGridView'):New(self)
    FavoriteList:SetPoint('TOPLEFT', 8, 0)
    FavoriteList:SetPoint('BOTTOMRIGHT', -8, 8)
    FavoriteList:SetItemHeight(30)
    FavoriteList:SetItemSpacing(3)
    FavoriteList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    FavoriteList:InitHeader(BROAD_HEADER)
    FavoriteList:SetHeaderPoint('BOTTOMLEFT', FavoriteList, 'TOPLEFT', 0, 0)
    FavoriteList:SetSortHandler(function(data)
        return - data.recordDate
    end)
    FavoriteList:SetCallback('OnGridEnter', function(_, grid, data)
        DelButton:Show()
        DelButton:ClearAllPoints()
        DelButton:SetParent(grid:GetParent())
        DelButton:SetPoint('RIGHT', grid:GetParent(), -10, 0)
        DelButton:SetFrameLevel(grid:GetFrameLevel() + 10)
        DelButton.btag = data.btag
    end)
    FavoriteList:SetCallback('OnGridLeave', function(_, grid, data)
        if not DelButton:IsMouseOver() then
           DelButton:Hide() 
        end
    end)

    local Tips = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    Tips:SetPoint('BOTTOMRIGHT', self:GetOwner():GetOwner(), -7, 7)
    Tips:SetText(L['|cffff0000注意：关注列表仅储存在本地配置中|r'])
    -- Tips:SetPoint('TOPRIGHT', -7, 45)

    self:RegisterMessage('RAIDBUILDER_FAVORITES_UPDATE', 'Refresh')
    self:SetScript('OnShow', self.Refresh)
    self.FavoriteList = FavoriteList
end

function FavoritePanel:Update()
    local list = {}
    local FavoriteList = self.FavoriteList

    for k, v in pairs(Profile:GetFavorites()) do
        tinsert(list, {btag = k, reason = v.reason, recordDate = v.recordDate})
    end

    FavoriteList:SetItemList(list)
    FavoriteList:Refresh()

    for i, v in ipairs(FavoriteList.sortButtons) do
        v:SetShown(not(#list == 0))
    end
end

function FavoritePanel:Add(btag, callback)
    if type(btag) ~= 'string' then
         return
    end

    if Profile:IsInFavorite(btag) then
        GUI:CallWarningDialog(L['|cffffd100%s|r 已经在关注列表。']:format(btag))
    else
        GUI:CallInputDialog(format(L['你确定将 |cffffd100%s|r 加入关注列表吗？'], btag), function(result, text)
            if result then
                Profile:AddFavorite(btag, text)
                Logic:SendServer('SFAV', btag, 1)
                if type(callback) == 'function' then
                    callback()
                end
            end
        end, nil, L['好团长'], 255)
    end
end

function FavoritePanel:Del(btag)
    if not btag or btag == '' then
        return
    end

    GUI:CallMessageDialog(format(L['你确定将 |cffffd100%s|r 移出关注列表吗？'], btag), function(result)
        if result then
            Profile:DeleteFavorite(btag)
            Logic:SendServer('SFAV', btag, 0)
        end
    end)
end
