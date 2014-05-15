
BuildEnv(..., 'WowSocial')

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local CloudUI = LibStub('AceAddon-3.0'):NewAddon('WowSocial_UI',
    'AceEvent-3.0',
    'LibClass-1.0',
    'LibModule-1.0',
    'AceHook-3.0',
    'NetEaseGUI-DropMenu-1.0')

local GUI = LibStub('NetEaseGUI-1.0')

function CloudUI:OnInitialize()
    local db = {
        profile = {
            minimap = {
                hide = false,
                minimapPos = 342,
            }
        }
    }

    self.db = LibStub('AceDB-3.0'):New('WOWSOCIAL_DB_UI', db)

    self:SetSlientMode(false)

    self:RegisterMessage('NECLOUD_GROUP_CREATE_SUCCESS')

    self:RawHook('SetItemRef', true)
end

function CloudUI:SetItemRef(link, text, button, chatFrame)
    local linkType, name = strsplit(':', link)
    if linkType == 'player' then
        local staticPopup = GUI:IsDialogVisible('WowSocialInvite')
        if staticPopup then
            staticPopup.editBox:SetText(name)
            return
        end
    end
    return self.hooks.SetItemRef(link, text, button, chatFrame)
end

function CloudUI:NECLOUD_GROUP_CREATE_SUCCESS(event, name, gid)
    self:ShowModule('ManagePanel', gid)
end

function CloudUI:SetSlientMode(flag)
    self.db.profile.slient = flag

    self:SendMessage('NECLOUD_CONFIG_SLIENTMODE')
end

function CloudUI:IsSlientMode()
    return self.db.profile.slient
end

-- function CloudUI:OpenHelper(id)
--     HideUIPanel(HelpFrame)

--     StaticPopup_Hide('HELP_TICKET')
--     StaticPopup_Hide('HELP_TICKET_ABANDON_CONFIRM')
--     StaticPopup_Hide('GM_RESPONSE_NEED_MORE_HELP')
--     StaticPopup_Hide('GM_RESPONSE_RESOLVE_CONFIRM')
--     StaticPopup_Hide('GM_RESPONSE_MUST_RESOLVE_RESPONSE')
--     HelpFrame_ShowFrame()

--     if not self.HelpTip then
--         local Frame = CreateFrame('Frame', nil, HelpFrame, 'GlowBoxTemplate')
--         Frame:SetSize(160, 50)
--         Frame:SetPoint('BOTTOMRIGHT', HelpFrame, 'TOPRIGHT', -80, -20)
--         Frame:Hide()

--         local Arrow = CreateFrame('Frame', nil, Frame, 'GlowBoxArrowTemplate')
--         Arrow:SetPoint('TOP', Frame, 'BOTTOM')

--         local Text = Frame:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
--         Text:SetPoint('TOPLEFT', 10, -10)
--         Text:SetPoint('BOTTOMRIGHT', -10, -10)
--         Text:SetJustifyV('TOP')

--         LibStub('AceTimer-3.0'):Embed(Frame)

--         Frame:SetScript('OnHide', function(self)
--             self:CancelAllTimers()
--             self:Hide()
--         end)
--         Frame:SetScript('OnShow', function(self)
--             self:ScheduleTimer('Hide', 10)
--         end)

--         Frame.Text = Text
--         self.HelpTip = Frame
--     end

--     self.HelpTip.Text:SetText(L['请搜索“|cff00ff00%d|r”打开插件使用指南']:format(id))
--     self.HelpTip:Show()
-- end
