
local GUI = LibStub:NewLibrary('NetEaseGUI-1.0', 4)
if not GUI then
    return
end

local Class = LibStub('LibClass-1.0')

local classes = {}
local cversions = {}
local embeds = {}
local eversions = {}

function GUI:Embed(target, ...)
    if type(target) == 'string' then
        error('', 2)
    end
    if not target then
        return
    end
    for i = 1, select('#', ...) do
        local embed = GUI:GetEmbed(select(i, ...))
        if embed then
            if type(embed.Embed) == 'function' then
                embed:Embed(target)
            else
                for k, v in pairs(embed) do
                    target[k] = v
                end
            end
        end
    end
end

function GUI:NewClass(name, super, version, ...)
    local class = classes[name]
    local oldversion = cversions[name]

    if not class or not oldversion or (version and oldversion < version) then
        class = Class:New(name, super)

        classes[name] = class
        cversions[name] = version

        self:Embed(class, ...)
        return class
    end
end

function GUI:GetClass(name)
    return classes[name]
end

function GUI:NewEmbed(name, version)
    local embed = embeds[name]
    local oldversion = eversions[name]

    if not embed or not oldversion or oldversion < version then
        embeds[name] = {}
        eversions[name] = version

        return embeds[name]
    end
end

function GUI:GetEmbed(name)
    return embeds[name]
end

local UISpecialFrames = {}
local orig_CloseSpecialWindows = _G.CloseSpecialWindows

function _G.CloseSpecialWindows()
    local found = orig_CloseSpecialWindows()
    for frame in pairs(UISpecialFrames) do
        if frame:IsShown() then
            frame:Hide()
            found = 1
        end
    end
    return found
end

function GUI:RegisterUIPanel(frame)
    if not Class:IsWidget(frame) then
        return
    end
    UISpecialFrames[frame] = true
end

function GUI:UnregisterUIPanel(frame)
    if not Class:IsWidget(frame) then
        return
    end
    UISpecialFrames[frame] = nil
end

GUI.RegisterUIMenu = GUI.RegisterUIPanel
GUI.UnregisterUIMenu = GUI.UnregisterUIPanel

StaticPopupDialogs['NECLOUD_CONFIRM_DIALOG'] = {}

function GUI:CallWarningDialog(text, showAlert)
    local t = wipe(StaticPopupDialogs['NECLOUD_CONFIRM_DIALOG'])

    t.text = text
    t.whileDead = 1
    t.hideOnEscape = 1
    t.button1 = OKAY
    t.showAlert = showAlert

    return StaticPopup_Show('NECLOUD_CONFIRM_DIALOG')
end

function GUI:CallMessageDialog(text, callback, key, ...)
    local t = wipe(StaticPopupDialogs['NECLOUD_CONFIRM_DIALOG'])

    t.text = text
    t.whileDead = 1
    t.hideOnEscape = 1
    t.button1 = OKAY
    t.button2 = CANCEL

    local args = {...}

    if type(callback) == 'function' then
        t.OnAccept = function()
            callback(true, nil, unpack(args))
        end
        t.OnCancel = function()
            callback(false, nil, unpack(args))
        end
    end

    return StaticPopup_Show('NECLOUD_CONFIRM_DIALOG', nil, nil, key)
end

function GUI:CallInputDialog(text, callback, key, default, maxBytes, ...)
    local t = wipe(StaticPopupDialogs['NECLOUD_CONFIRM_DIALOG'])

    t.text = text
    t.whileDead = 1
    t.hideOnEscape = 1
    t.button1 = OKAY
    t.button2 = CANCEL
    t.hasEditBox = true
    t.maxLetters = 32
    t.maxBytes = maxBytes or 255

    local args = {...}

    if type(callback) == 'function' then
        t.OnAccept = function(self)
            callback(true, self.editBox:GetText(), unpack(args))
        end
        t.EditBoxOnEnterPressed = function(self)
            callback(true, self:GetText(), unpack(args))
            self:GetParent():Hide()
        end
        t.EditBoxOnEscapePressed = function(self)
            callback(false, nil, unpack(args))
            self:GetParent():Hide()
        end
        t.OnCancel = function()
            callback(false, nil, unpack(args))
        end
    end

    local dialog = StaticPopup_Show('NECLOUD_CONFIRM_DIALOG', nil, nil, key)
    if dialog and default and default ~= '' then
        dialog.editBox:SetText(default)
        dialog.editBox:HighlightText(0, #default)
    end
    return dialog
end

function GUI:IsDialogVisible(key)
    for i = 1, STATICPOPUP_NUMDIALOGS, 1 do
        local frame = _G['StaticPopup'..i]
        if frame:IsShown() and frame.which == 'NECLOUD_CONFIRM_DIALOG' and frame.data == key then
            return frame
        end
    end
    return nil
end

function GUI:CloseDialog(key)
    StaticPopup_Hide('NECLOUD_CONFIRM_DIALOG', key)
end

local tooltips = {}

local function OnEnter(self)
    local anchor = tooltips[self].anchor
    if anchor then
        GameTooltip:SetOwner(self, anchor)
    else
        GameTooltip_SetDefaultAnchor(GameTooltip, self)
    end
    GameTooltip:SetText(tooltips[self].text)
    for i, v in ipairs(tooltips[self]) do
        GameTooltip:AddLine(v, 1, 1, 1, true)
    end
    GameTooltip:Show()
end

local function OnLeave(self)
    GameTooltip:Hide()
end

function GUI:SetTooltip(object, anchor, text, ...)
    if not Class:IsWidget(object) then
        error([[bad argument #1 to 'SetTooltip' (widget expected)]], 2)
    end
    if type(anchor) ~= 'string' then
        error([[Usage: GUI:SetTooltip(widget, [anchor], ...)]], 2)
    end

    if not tooltips[object] then
        object:HookScript('OnEnter', OnEnter)
        object:HookScript('OnLeave', OnLeave)
    end

    if anchor:match('^ANCHOR') then
        tooltips[object] = {...}
        tooltips[object].text = text
        tooltips[object].anchor = anchor
    else
        tooltips[object] = {text, ...}
        tooltips[object].text = anchor
        tooltips[object].anchor = nil
    end
end
