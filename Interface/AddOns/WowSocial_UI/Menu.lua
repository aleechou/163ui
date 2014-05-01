
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

function CloudUI:ToggleUnitMenu(owner, chatType, target)
    if chatType == 'GROUP' then
        self:ToggleGroupMenu(owner, chatType, target)
    elseif chatType == 'WHISPER' then
        self:ToggleUserMenu(owner, chatType, target)
    end
end

function CloudUI:ToggleUserMenu(owner, chatType, target)
    local name = GetChatName(chatType, target)

    local menuTable = {
        {
            text = name,
            isTitle = true,
        },
        {
            text = L['打开'],
            func = function()
                self:ShowModule('ChatPanel', chatType, target)
            end
        },
        {
            text = L['查看资料'],
            func = function()
                CloudUI:ShowModule('UserPanel', target)
            end
        }
    }

    self:ToggleMenu(owner, menuTable)
end

function CloudUI:ToggleGroupMenu(owner, chatType, target)
    local isManager = UserIsChatGroupManager(target, PLAYER_NAME)
    local isOwner = UserIsChatGroupOwner(target, PLAYER_NAME)
    local isMember = UserIsChatGroupMember(target, PLAYER_NAME)
    local isPublic = IsChatGroupPublic(target)
    local name = GetChatGroupName(target)

    local menuTable = {
        {
            text = name,
            isTitle = true,
        },
        {
            text = L['打开'],
            hidden = not isMember,
            func = function()
                self:ShowModule('ChatPanel', chatType, target)
            end
        },
        {
            text = L['加入'],
            hidden = isMember,
            func = function()
                JoinChatGroup(target)
            end
        },
        {
            text = L['邀请'],
            hidden = not isManager,
            confirm = L['请输入想要邀请入群的玩家名字\n或者在聊天窗口中\n按住Shift点击该玩家的名字：'],
            confirmInput = true,
            confirmDefault = not UnitIsUnit('player', 'target') and UnitIsFriend('player', 'target') and UnitName('target'),
            confirmKey = 'WowSocialInvite',
            func = function(result, text)
                if text == '' then
                    self:SendMessage('NECLOUD_MSG', L['角色名错误，请重试。'])
                elseif result then
                    InviteChatGroup(target, text)
                end
            end,
        },
        {
            text = L['查看资料'],
            hidden = isPublic,
            func = function()
                self:ShowModule('ManagePanel', target)
            end
        },
        {
            text = L['退出群组'],
            hidden = isOwner or not isMember,
            confirm = L['你确定要退出群组%s吗？']:format(name),
            func = function(result)
                if result then
                    LeaveChatGroup(target)
                end
            end
        },
    }

    self:ToggleMenu(owner, menuTable)
end

function CloudUI:ToggleMemberMenu(owner, gid, target)
    local isManager = UserIsChatGroupManager(gid, PLAYER_NAME)
    local isOwner = UserIsChatGroupOwner(gid, PLAYER_NAME)
    local isSelf = PLAYER_NAME == target
    local targetIsManager = UserIsChatGroupManager(gid, target)
    local targetIsOwner = UserIsChatGroupManager(gid, target)
    local targetIsMember = UserIsChatGroupMember(gid, target)
    local chatGroupName = GetChatGroupName(gid)

    local menuTable = {
        {
            text = GetUserColoredName(target),
            isTitle = true,
        },
        {
            text = L['查看资料'],
            hidden = isSelf,
            func = function()
                self:ShowModule('UserPanel', target)
            end
        },
        {
            text = L['个人设置'],
            hidden = not isSelf,
            func = function()
                self:ShowModule('UserPanel')
            end
        },
        {
            text = L['加为好友'],
            hidden = isSelf,
            func = function()
                AddFriend(target)
            end
        },
        {
            text = L['屏蔽'],
            hidden = isSelf,
            func = function()
                AddOrDelIgnore(target)
            end,
        },
        {
            text = L['悄悄话'],
            hidden = isSelf,
            func = function()
                ChatFrame_SendTell((target:gsub('%s','')))
            end,
        },
        {
            text = L['邀请组队'],
            hidden = isSelf,
            func = function()
                InviteToGroup((target:gsub('%s','')))
            end,
        },
        {
            text = L['设为管理员'],
            hidden = isSelf or not isOwner or targetIsManager or not targetIsMember,
            func = function()
                SetChatGroupManager(gid, target, true)
            end
        },
        {
            text = L['取消管理员'],
            hidden = isSelf or not isOwner or not targetIsManager or not targetIsMember,
            func = function()
                SetChatGroupManager(gid, target, false)
            end
        },
        {
            text = L['踢出群组'],
            hidden = isSelf or not isManager or (not isOwner and targetIsManager) or not targetIsMember,
            confirm = L['确定要将 %s 踢出群组 %s 吗？']:format(target, chatGroupName),
            func = function(result)
                if result then
                    KickUnitFromChatGroup(gid, target)
                end
            end
        },
        {
            text = L['退出群组'],
            hidden = not isSelf or isOwner,
            confirm = L['你确定要退出群组%s吗？']:format(chatGroupName),
            func = function(result)
                if result then
                    LeaveChatGroup(gid)
                end
            end,
        },
    }
    self:ToggleMenu(owner, menuTable)
end

function CloudUI:ToggleMainMenu(owner)
    local menuTable = {
        {
            text = L['个人设置'],
            func = function()
                self:ShowModule('UserPanel')
            end
        },
        {
            text = L['勿扰模式'],
            hasArrow = true,
            menuTable = {
                {
                    text = ENABLE,
                    checkable = true,
                    checked = function()
                        return self:IsSlientMode()
                    end,
                    func = function()
                        self:SetSlientMode(true)
                    end
                },
                {
                    text = DISABLE,
                    checkable = true,
                    checked = function()
                        return not self:IsSlientMode()
                    end,
                    func = function()
                        self:SetSlientMode(nil)
                    end
                },
            }
        },
        {
            text = L['创建群组'],
            confirm = L['请输入群组名称：'],
            confirmInput = true,
            confirmMaxBytes = 22,
            func = function(result, name)
                if result and name and name ~= '' then
                    CreateChatGroup(name)
                end
            end
        },
        {
            text = L['查找群组'],
            func = function()
                self:ShowModule('SearchPanel')
            end
        },
        {
            text = L['意见建议'],
            func = function()
                CloudUI.Feedback:Open('WowSocial_UI', GetAddOnMetadata('WowSocial', 'Version'))
            end
        },
        -- {
        --     text = L['使用指南'],
        --     func = function()
        --         CloudUI:OpenHelper(2513)
        --     end
        -- },
        {
            text = L['关于'],
            func = function()
                self:ShowModule('AboutPanel')
            end
        }
    }
    self:ToggleMenu(owner, menuTable)
end
