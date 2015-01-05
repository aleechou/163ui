
BuildEnv(...)

Logic = Addon:NewModule('Logic', 'AceEvent-3.0', 'NetEaseSocket-2.0')

function Logic:OnInitialize()
    if not ADDON_REGIONSUPPORT then
        return
    end

    self:ListenSocket('NERB', 'S1' .. UnitFactionGroup('player'))

    self:RegisterServer('SDV', 'SOCKET_DATA_VALUE')
    self:RegisterServer('SSM', 'SOCKET_SYSTEM_MESSAGE')
    self:RegisterServer('SVERSION', 'SOCKET_VERSION')

    self:RegisterServer('SERVER_CONNECTED')
    self:RegisterServer('SERVER_DISCONNECTED', 'ServerConnect')
    self:RegisterServer('CHANNEL_DISCONNECTED', 'ConnectChannel')

    self:RegisterServerEvent('EXCHANGE_RESULT', 'MEETINGSTONE_REWARD_RESULT')
    self:RegisterServerEvent('MALLPURCHASE_RESULT', 'MEETINGSTONE_MALLPURCHASE_RESULT')
    self:RegisterServerEvent('MALLQUERY_RESULT', 'MEETINGSTONE_MALLQUERY_RESULT')

    self:ServerConnect()
end

function Logic:RegisterServerEvent(cmd, event)
    self:RegisterServer(cmd, function(_, ...)
        self:SendMessage(event, ...)
    end)
end

function Logic:ServerConnect()
    if self:IsCanConnect() then
        self:ConnectServer()
    end
    self:SendMessage('MEETINGSTONE_SERVER_STATUS_UPDATED', false)
end

function Logic:IsCanConnect()
    return not IsTrialAccount() and not self.notSupport
end

function Logic:IsSupport()
    return not self.notSupport
end

function Logic:SOCKET_DATA_VALUE(_, key, data)
    DataCache:SaveCache(key, data)
end

function Logic:SOCKET_SYSTEM_MESSAGE(_, msg)
    SendSystemMessage(msg)
end

function Logic:SOCKET_VERSION(_, ...)
    self.notSupport = not select(3, ...)
    self:SendMessage('MEETINGSTONE_NEW_VERSION', ...)
end

function Logic:SERVER_CONNECTED()
    self:SendServer('SLOGIN', ADDON_VERSION, UnitGUID('player'), self:GetAddonSource(), select(2, BNGetInfo()))
    self:SendMessage('MEETINGSTONE_SERVER_STATUS_UPDATED', true)
end

function Logic:GetAddonSource(mark)
    for line in gmatch('\033\033\033\049\054\051\085\073\033\033\033\058\050\058\049\010\066\105\103\070\111\111\116\058\051\058\049\010\068\117\111\119\097\110\058\052\058\048\010\069\108\118\085\073\058\053\058\049', '[^\r\n]+') do
        local n, v, c = line:match('^(.+):(%d+):(%d+)$')
        if IsAddOnLoaded(n) and (not mark or c == '1') then
            return tonumber(v)
        end
    end
end

---- Mall API

function Logic:MallQueryPoint()
    self:SendServer('MALLQUERY', UnitGUID('player'), ADDON_VERSION_SHORT)
end

function Logic:MallPurchase(id, ok)
    if not id then
        return
    end
    self:SendServer('MALLPURCHASE', id, UnitGUID('player'), ADDON_VERSION_SHORT, ok)
end

function Logic:Exchange(text)
    if not text or text == '' then
        return
    end
    self:SendServer('EXCHANGE', text, UnitGUID('player'), ADDON_VERSION_SHORT)
end

function Logic:SEI(activity)
    if not activity then
        return
    end

    self:SendServer('SEI',
        UnitGUID('player'),
        GetPlayerBattleTag(),
        ADDON_VERSION,
        activity:GetActivityID(),
        activity:GetActivityType(),
        activity:GetActivityMode(),
        activity:GetActivityLoot(),
        activity:GetActivitySummary())
end

function Logic:SEJ(activity, comment, tank, healer, damager)
    if not activity then
        return
    end

    self:SendServer('SEJ',
        UnitGUID('player'),
        GetPlayerBattleTag(),
        ADDON_VERSION,
        activity:GetLeader(),
        activity:IsMeetingStone(),
        activity:GetActivityID(),
        activity:GetCustomID(),
        comment,
        tank,
        healer,
        dammager)
end
