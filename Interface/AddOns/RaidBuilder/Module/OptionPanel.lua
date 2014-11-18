
BuildEnv(...)

OptionPanel = RaidBuilder:NewModule(GUI:GetClass('InTabPanel'):New(MainPanel), 'OptionPanel')

function OptionPanel:OnInitialize()
    GUI:Embed(self, 'Owner')
    self.TabFrame:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 60, 0)

    MainPanel:RegisterPanel(L['设置'], self, 0, 70)

end

SettingPanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, OptionPanel), 'SettingPanel', 'AceEvent-3.0')

function SettingPanel:OnInitialize()
    GUI:Embed(self, 'Owner')
    OptionPanel:RegisterPanel(L['设置'], self, 0)

    self.db = Profile:GetCharacterDB()

    local options = {
        type = 'group',
        name = L['设置'],
        get = function(item)
            return self.db.profile.settings[item[#item]]
        end,
        set = function(item, value)
            local key = item[#item]
            self.db.profile.settings[key] = value
            self:SendMessage('RAIDBUILDER_SETTING_CHANGED', key, value, true)
        end,
        args = {
            minimap = {
                type = 'toggle',
                name = L['显示小地图图标'],
                width = 'full',
                order = 2,
                get = function()
                    return not self.db.profile.minimap.hide
                end,
                set = function(_, value)
                    self.db.profile.minimap.hide = not value
                    if value then
                        LibStub('LibDBIcon-1.0'):Show('RaidBuilder')
                    else
                        LibStub('LibDBIcon-1.0'):Hide('RaidBuilder')
                    end
                end
            },
            panel = {
                type = 'toggle',
                name = L['显示悬浮窗'],
                width = 'full',
                order = 3,
            },
            panelLock = {
                type = 'toggle',
                name = L['锁定悬浮窗'],
                width = 'full',
                order = 4,
                disabled = function()
                    return not self.db.profile.settings.panel
                end
            },
            eventPusher = {
                type = 'toggle',
                name = L['开启活动推送'],
                width = 'full',
                order = 5,
                disabled = function()
                    return not self.db.profile.settings.panel
                end
            },
            teamNotice = {
                type = 'toggle',
                name = L['开启团队通告'],
                width = 'full',
                order = 6,
            },
            -- socialEnabled = {
            --     type = 'toggle',
            --     name = function()
            --         return RaidBuilder:IsSocialServerEnabled() and L['开启集合石聊天'] or L['集合石聊天模块服务器调试中']
            --     end,
            --     width = 'full',
            --     order = 7,
            --     disabled = function()
            --         return not RaidBuilder:IsSocialServerEnabled()
            --     end
            -- },
            key = {
                type = 'keybinding',
                name = L['打开/关闭集合石组团按键设置'],
                width = 'full',
                order = 8,
                get = function()
                    return GetBindingKey('RAIDBUILDER_TOGGLE')
                end,
                set = function(info, key)
                    -- GetBindingAction(key)
                    for _, key in ipairs({GetBindingKey('RAIDBUILDER_TOGGLE')}) do
                        SetBinding(key, nil)
                    end
                    SetBinding(key, 'RAIDBUILDER_TOGGLE')
                    SaveBindings(GetCurrentBindingSet())
                end,
                confirm = function(info, key)
                    local action = GetBindingAction(key)
                    if action ~= '' and action ~= 'RAIDBUILDER_TOGGLE' then
                        return L['按键已绑定到|cffffd100%s|r，你确定要覆盖吗？']:format(_G['BINDING_NAME_' .. action] or action)
                    end
                end
            },
            clearbnet = {
                type = 'execute',
                name = L['清理集合石自动添加的战网昵称好友'],
                width = 'full',
                order = 9,
                confirm = function()
                    return L['你确定要清理战网昵称好友吗？']
                end,
                func = function()
                    Invite:ClearRaidBuilderFriend()
                end
            }
        }
    }

    local group = LibStub('AceGUI-3.0'):Create('BlizOptionsGroup')
    group.frame:ClearAllPoints()
    group.frame:SetParent(self)
    group.frame:SetPoint('TOPLEFT', 20, -20)
    group.frame:SetSize(400, 300)
    group.frame:Show()
    group:SetCallback('OnShow', function()
        LibStub('AceConfigDialog-3.0'):Open('RaidBuilder', group)
    end)
    group:SetCallback('OnHide', function()
        group:ReleaseChildren()
    end)

    LibStub('AceConfigRegistry-3.0'):RegisterOptionsTable('RaidBuilder', options)
end

