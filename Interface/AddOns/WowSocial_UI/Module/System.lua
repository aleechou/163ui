
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local System = CloudUI:NewModule('System', 'AceEvent-3.0')

function System:OnInitialize()
    self:RegisterMessage('NECLOUD_GROUP_CREATE_SUCCESS')
    self:RegisterMessage('NECLOUD_GROUP_CREATE_FAILED')

    self:RegisterMessage('NECLOUD_GROUP_DISBAND')
    self:RegisterMessage('NECLOUD_GROUP_INVITE')
    self:RegisterMessage('NECLOUD_GROUP_LEAVE')
    self:RegisterMessage('NECLOUD_GROUP_KICK')
    self:RegisterMessage('NECLOUD_GROUP_JOIN')

    self:RegisterMessage('NECLOUD_GROUP_INVITE_FAILED')
    self:RegisterMessage('NECLOUD_GROUP_JOIN_FAILED')

    self:RegisterMessage('NECLOUD_GROUP_JOIN_SUCCESS')

    self:RegisterMessage('NECLOUD_GROUP_MANAGER')

    self:RegisterMessage('NECLOUD_NEWVERSION')
    self:RegisterMessage('NECLOUD_MSG')

    self:RegisterMessage('NECLOUD_GROUP_INFO_SAVED')
end

function System:NECLOUD_GROUP_INFO_SAVED(event, gid)
    self:Printf(L['群组信息保存成功'])
end

function System:NECLOUD_NEWVERSION(event, version, url, isCompat)
    self:Printf(L['%s：发现新版本 %s，请及时下载更新\n%s'], ADDON_NAME, version, url)
end

function System:NECLOUD_GROUP_CREATE_SUCCESS(event, name, gid)
    self:Printf(L['创建群组%s成功。'], name)
end

function System:NECLOUD_GROUP_CREATE_FAILED(event, name, gid, reason)
    self:Printf(L['创建群组%s失败，%s。'], name, L[reason])
end

function System:NECLOUD_GROUP_DISBAND(event, name)
    self:Printf(L['群组%s已解散。'], name)
end

function System:NECLOUD_GROUP_INVITE(event, name, gid, inviter, avatar)
    self:Printf(L['%s邀请你加入群组%s。'], inviter, name)
end

function System:NECLOUD_GROUP_JOIN(event, name, gid, target)
    self:Printf(L['%s加入群组%s。'], target or L.You, name)
end

function System:NECLOUD_GROUP_INVITE_FAILED(event, name, gid, reason, target)
    self:Printf(L['邀请%s加入群组%s失败，%s。'], target, name, L[reason])
end

function System:NECLOUD_GROUP_LEAVE(event, name, gid, target)
    self:Printf(L['%s已退出群组%s。'], target or L.You, name)
end

function System:NECLOUD_GROUP_KICK(event, name, gid, target, oper)
    self:Printf(L['%s被%s踢出群组%s。'], target or L.You, oper, name)
end

function System:NECLOUD_GROUP_JOIN_FAILED(event, name, gid, reason)
    self:Printf(L['加入群组%s失败，%s。'], name, L[reason])
end

function System:NECLOUD_GROUP_JOIN_SUCCESS(event, name)
    self:Printf(L['已发送加入群组%s请求。'], name)
end

function System:NECLOUD_MSG(event, msg)
    self:Print(msg)
end

function System:NECLOUD_GROUP_MANAGER(event, name, gid, target, oper, flag)
    if flag then
        self:Printf(L['%s将%s提升为群组%s的管理员。'], oper, target, name)
    else
        self:Printf(L['%s将%s降职为群组%s的普通成员。'], oper, target, name)
    end
end

local frames = CHAT_FRAMES
function System:Print(msg)
    for i, v in ipairs(frames) do
        local frame = _G[v]
        local OnEvent = frame:GetScript('OnEvent')
        if OnEvent then
            OnEvent(frame, 'CHAT_MSG_SYSTEM', msg, '', '', '')
        end
    end
end

function System:Printf(formatter, ...)
    self:Print(formatter:format(...))
end
