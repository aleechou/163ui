
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
            minimapPack = {
                type = 'toggle',
                name = L['允许小地图图标被整合'],
                width = 'full',
                order = 1,
            },
            minimap = {
                type = 'toggle',
                name = L['显示小地图图标'],
                width = 'full',
                order = 2,
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
            teamNotice = {
                type = 'toggle',
                name = L['开启团队通告'],
                width = 'full',
                order = 5,
            },

            socialEnabled = {
                type = 'toggle',
                name = function()
                    return RaidBuilder:IsSocialServerEnabled() and L['开启集合石聊天'] or L['集合石聊天模块服务器调试中']
                end,
                width = 'full',
                order = 6,
                disabled = function()
                    return not RaidBuilder:IsSocialServerEnabled()
                end
            },
            key = {
                type = 'keybinding',
                name = L['打开/关闭集合石组团按键设置'],
                width = 'full',
                order = 7,
                get = function()
                    return GetBindingKey('RAIDBUILDER_TOGGLE')
                end,
                set = function(info, key)
                    GetBindingAction(key)
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
    -- LibStub('AceConfigDialog-3.0'):Open('RaidBuilder', group)
    
    -- for k, v in pairs(group.children[1].children) do
    --     if v.type == 'Keybinding' then
    --         v.msgframe.msg:SetText(L['点击按键以绑定命令->集合石组团，点击ESC或者再次点击按钮取消设置。'])
    --     end
    -- end

    -- local SignInButton = BigButton:New(self)
    -- SignInButton:SetPoint('TOPRIGHT', -20, -20)
    -- SignInButton:SetText(Profile:IsSignIn() and L['今日已签到'] or L['签到'])
    -- SignInButton:SetEnabled(not Profile:IsSignIn())
    -- SignInButton:SetScript('OnClick', function(self)
    --     Logic:SignIn()
    --     self:Disable()
    --     self:SetText(L['今日已签到'])
    --     System:Message(L['今日签到成功'])
    -- end)
    -- SignInButton:Hide()

    local ReferenceButton = BigButton:New(self)
    -- ReferenceButton:SetPoint('TOPRIGHT', SignInButton, 'BOTTOMRIGHT', 0, -10)
    ReferenceButton:SetPoint('TOPRIGHT', -20, -20)
    ReferenceButton:SetText(Profile:GetReferenced() and L['已填写推荐'] or L['推荐人'])
    ReferenceButton:SetEnabled(not Profile:GetReferenced())
    ReferenceButton:SetScript('OnClick', function(self)
        GUI:CallInputDialog(format(L['请输入邀请人的角色名和服务器，格式如下：|cffffd100%s-%s|r'], UnitName('player'), GetRealmName()), function(result, text)
            if result then
                Logic:Referenced(text)
                self:Disable()
                self:SetText(L['已填写推荐'])
                System:Message(L['推荐人填写成功'])
            end
        end, nil, nil, 255)
    end)
    -- ReferenceButton:Hide()

    -- local RewardButton = BigButton:New(self)
    -- RewardButton:SetPoint('TOPRIGHT', ReferenceButton, 'BOTTOMRIGHT', 0, -30)
    -- RewardButton:SetText('领奖')
    -- RewardButton:SetScript('OnClick', function(self)
    --     GUI:CallInputDialog(L['请输入兑换码'], function(result, text)
    --         if result then
    --             Logic:Exchange(text)
    --         end
    --     end, 'NetEaseExchange')
    -- end)
end

