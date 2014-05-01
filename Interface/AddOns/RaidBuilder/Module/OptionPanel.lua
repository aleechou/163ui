
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

    self.db = RaidBuilder:GetDB()

    self.minimapPack = self.db.profile.settings.minimapPack

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
            key = {
                type = 'keybinding',
                name = L['打开/关闭友团组团按键设置'],
                width = 'full',
                order = 6,
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
end
