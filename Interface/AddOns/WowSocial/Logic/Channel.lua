
BuildEnv(...)

Channel = Cloud:NewModule('Channel', 'AceEvent-3.0', 'NetEaseBroad-1.0', 'AceTimer-3.0')

local Base64 = LibStub('LibBase64-1.0')
local AceSerializer = LibStub('AceSerializer-3.0')

local function UnpackUnvisible(msg, key)
    return AceSerializer:Deserialize(Base64:DeCode(msg, key))
end

function Channel:OnInitialize()
    -- self:RegisterMessage('NE_LOGIC_CHANNEL_UPDATE')

    self:RegisterBroad('BROAD_CONNECTED', 'StartHeartBeat')
    self:RegisterBroad('BROAD_DISCONNECTED', 'Connect')

    self:RegisterBroad('GM', 'NEBROAD_GROUP_MSG')
    self:RegisterBroad('UB', 'NEBROAD_USER_BASEINFO')

    self:Connect()
end

function Channel:StartHeartBeat()
    local info = GetUserInfo(PLAYER_NAME)
    if info then
        self:SendBroadMessage('UB', UnitLevel('player'), info.Avatar)
    end
    self.heartBeatTimer = self:ScheduleTimer('StartHeartBeat', 180)
end

-- function Channel:NE_LOGIC_CHANNEL_UPDATE(event, name, pwd)
--     self:ConnectBroad('CHANNEL', name, pwd)
-- end

function Channel:Connect()
    self:ConnectBroad('CHANNEL', '友团聊天通信')
end

function Channel:NEBROAD_USER_BASEINFO(cmd, sender, level, avatar)
    local info = UserCache:GetUserInfo(sender)
    if info then
        info.Avatar = avatar or info.avatar
        info.Level = level or info.level
    end
end

function Channel:NEBROAD_GROUP_MSG(cmd, sender, gid, data)
    local group = Cloud:GetModule('ChatGroupCache'):GetChatGroup(gid)
    if not group then
        return
    end
    if not group:UserIsMember(PLAYER_NAME) then
        return
    end
    local ok, msg = UnpackUnvisible(data, group:GetKey())
    if not ok then
        return
    end
    self:SendMessage('NECLOUD_GROUP_MSG', group:GetChatGroupId(), msg, sender)
end

function Channel:SendGroupMessage(gid, msg)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end
    
    self:SendBroadMessage('GM', gid, Base64:EnCode(AceSerializer:Serialize(msg), group:GetKey()))
end
