
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

function CloudUI:GetAnchorType(anchor)
    if anchor:GetLeft() > GetScreenWidth() / 2 then
        return 'ANCHOR_LEFT'
    else
        return 'ANCHOR_RIGHT'
    end
end

function CloudUI:OpenTooltip(anchor, text, ...)
    local count = select('#', ...)

    GameTooltip:SetOwner(anchor, self:GetAnchorType(anchor))
    if count > 0 then
        GameTooltip:SetText(text, 1, 1, 1, true)
    else
        GameTooltip:SetText(text, nil, nil, nil, true)
    end
    for i = 1, count do
        GameTooltip:AddLine(select(i, ...), nil, nil, nil, true)
    end
    GameTooltip:Show()
end

function CloudUI:OpenChatTooltip(anchor, chatType, target)
    GameTooltip:SetOwner(anchor, self:GetAnchorType(anchor))
    GameTooltip:SetText(GetChatName(chatType, target), 1, 1, 1, true)
    GameTooltip:AddDoubleLine(L['未读消息'], GetChatUnread(chatType, target))
    GameTooltip:Show()
end

function CloudUI:OpenSearchGroupTooltip(anchor, data)
    GameTooltip:SetOwner(anchor, self:GetAnchorType(anchor))
    GameTooltip:SetText(data.text, 1, 1, 1)
    GameTooltip:AddLine(L['群组兴趣'])

    local cache = GetInterestTable(data.interest)
    for i, v in ipairs(cache) do
        GameTooltip:AddLine('- ' .. v, 1, 1, 1)
    end

    GameTooltip:AddLine(L['活动时间'])

    local cache = GetOnlineTimeTable(data.onlineTime)
    for i, v in ipairs(cache) do
        GameTooltip:AddLine('- ' .. v, 1, 1, 1)
    end
    
    local summary = data.summary and data.summary ~= '' and data.summary or L['暂无']

    GameTooltip:AddLine(L['群组说明'])
    GameTooltip:AddLine(summary, 1, 1, 1, true)
    GameTooltip:Show()
end
