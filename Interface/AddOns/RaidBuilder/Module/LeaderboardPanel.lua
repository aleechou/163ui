
BuildEnv(...)

local LeaderboardPanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'LeaderboardPanel', 'AceEvent-3.0')

local ScoreGrid = RaidBuilder:NewClass('ScoreGrid', GUI:GetClass('DataGridViewGridItem'))

local BROAD_HEADER = {
    {
        key = 'Rank',
        text = L['排名'],
        width = 100,
        style = 'ICONTEXT',
        showHandler = function(data)
            if data.rank == 1 then
                return data.rank, nil, nil, nil, [[INTERFACE\Challenges\challenges-gold-sm]], 0.25, 0.75, 0.25, 0.75, 30
            elseif data.rank == 2 then
                return data.rank, nil, nil, nil, [[INTERFACE\Challenges\challenges-plat-sm]], 0.25, 0.75, 0.25, 0.75, 30
            elseif data.rank == 3 then
                return data.rank, nil, nil, nil, [[INTERFACE\Challenges\challenges-bronze-sm]], 0.25, 0.75, 0.25, 0.75, 30
            else
                return data.rank, nil, nil, nil, nil, nil, nil, nil, nil, 30
            end
        end,
    },
    {
        key = 'Name',
        text = L['玩家名称'],
        width = 200,
        style = 'LEFT',
        showHandler = function(data)
            return data.name
        end,
    },
    {
        key = 'Score',
        text = L['屠龙点数'],
        width = 250,
        class = ScoreGrid,
        showHandler = function(data)
            return data.score
        end,
        formatHandler = function(grid, data)
            grid:SetScore(data.score)
        end
    },
}

function ScoreGrid:Constructor()
    self.Text:ClearAllPoints()
    self.Text:SetPoint('LEFT', 10, 0)

    local StatusBar = CreateFrame('StatusBar', nil, self)
    StatusBar:SetPoint('LEFT', 60, 0)
    StatusBar:SetPoint('RIGHT', -30, 0)
    StatusBar:SetHeight(16)

    StatusBar:SetStatusBarTexture([[INTERFACE\PaperDollInfoFrame\UI-Character-Skills-Bar]])
    StatusBar:SetStatusBarColor(0, 1, 0)
    StatusBar:SetMinMaxValues(0, 100)

    self.StatusBar = StatusBar
end

function ScoreGrid:SetScore(score)
    local highScore = self:GetParent():GetParent():GetParent():GetItem(1).score or 2000

    self.Text:SetText(score)
    self.StatusBar:SetValue(score/highScore*100)
end

function LeaderboardPanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    MainPanel:RegisterPanel(L['排行榜'], self, 6)

    local scoreData = DataCache:NewObject('LeaderScore')
    scoreData:SetCallback('OnCacheChanged', function(self, cache)
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
    end)
    scoreData:SetCallback('OnDataChanged', function(_, data)
        MainPanel:EnablePanel(self)
        self.BroadList:SetItemList(data)
        self.BroadList:Refresh()
    end)

    MainPanel:DisablePanel(self)

    local TitleTex = self:CreateTexture(nil, 'ARTWORK')
    TitleTex:SetTexture([[INTERFACE\ARCHEOLOGY\Arch-Race-Mantid]])
    TitleTex:SetSize(64, 64)
    TitleTex:SetPoint('TOPLEFT', self:GetOwner(), 'TOPLEFT', 60, -30)

    local TitleLabel = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalHuge')
    TitleLabel:SetPoint('TOPLEFT', TitleTex, 'TOPRIGHT', -20, -10)
    TitleLabel:SetText(L['团长积分榜'])

    local url = GUI:GetClass('SummaryHtml'):New(self)
    url:SetSize(250, 20)
    url:SetPoint('TOPRIGHT', self:GetOwner(), -40, -40)
    url:SetText(L.LeaderboardUrl)

    local LeftTex = self:CreateTexture(nil, 'ARTWORK')
    LeftTex:SetTexture([[Interface\AddOns\RaidBuilder\Media\Leaderboard]])
    LeftTex:SetSize(256, 512)
    LeftTex:SetPoint('TOPLEFT', -2, 3)
    -- LeftTex:Hide()

    -- local LeftModel = CreateFrame('PlayerModel', nil, self)
    -- LeftModel:SetPoint('CENTER', LeftTex, 'CENTER', 0, 50)
    -- LeftModel:SetSize(300, 300)
    -- -- LeftModel:SetDisplayInfo(29514)
    -- -- LeftModel:SetFacing(math.pi/8)
    -- LeftModel:SetModel([[world\expansion02\doodads\generic\argentcrusade\banners\tournament_banner_human02.m2]])
    -- LeftModel:SetModelScale(0.5)
    -- LeftModel:SetPosition(0, 0, 2)

    -- _G.MO = LeftModel

    local BroadList = GUI:GetClass('DataGridView'):New(self)
    BroadList:SetPoint('TOPLEFT', LeftTex, 'TOPRIGHT', -5, 0)
    BroadList:SetPoint('BOTTOMRIGHT')
    BroadList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    BroadList:InitHeader(BROAD_HEADER)
    BroadList:SetHeaderPoint('BOTTOMLEFT', BroadList, 'TOPLEFT', -2, 2)
    BroadList:SetSortHandler(function(data)
        return data.rank
    end)
    BroadList:SetItemList(listdata)
    BroadList:SetItemHeight(30)
    BroadList:SetItemSpacing(3)

    self.BroadList = BroadList

    self:SetScript('OnShow', self.OnShow)
end

function LeaderboardPanel:OnShow()
    self.BroadList:Refresh()
end
