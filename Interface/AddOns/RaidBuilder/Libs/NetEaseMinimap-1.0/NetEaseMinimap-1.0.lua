
local LDB = assert(LibStub('LibDataBroker-1.1', true), 'NetEaseMinimap-1.0 requests LibDataBroker-1.1')
local LibDBIcon = assert(LibStub('LibDBIcon-1.0', true), 'NetEaseMinimap-1.0 requests LibDBIcon-1.0')

local Minimap = LibStub:NewLibrary('NetEaseMinimap-1.0', 1)
if not Minimap then
    return
end

local function AnimParentOnShow(self) self.Anim:Play() end
local function AnimParentOnHide(self) self.Anim:Stop() end

Minimap.DataObjects = Minimap.DataObjects or {}
Minimap.MinimapKeyWidgets = Minimap.MinimapKeyWidgets or {}
Minimap.DataObjectsKeyDatas = Minimap.DataObjectsKeyDatas or {}
Minimap.KeyDatas = {
    flash = {
        MakeMinimap = function(button)
            local Flash = CreateFrame('Frame', nil, button)
            Flash:Hide()
            Flash:SetPoint('CENTER')
            Flash:SetSize(48, 48)
            Flash.bg = Flash:CreateTexture(nil, 'OVERLAY')
            Flash.bg:SetBlendMode('ADD')
            Flash.bg:SetPoint('CENTER')
            Flash.bg:SetSize(36, 36)
            Flash.bg:SetTexture([[INTERFACE\Calendar\EventNotificationGlow]])
            Flash.Anim = Flash:CreateAnimationGroup()
            Flash.Anim:SetLooping('BOUNCE')
            Flash.Alpha = Flash.Anim:CreateAnimation('Alpha')
            Flash.Alpha:SetDuration(0.75)
            Flash.Alpha:SetChange(-0.7)
            Flash:SetScript('OnShow', AnimParentOnShow)
            Flash:SetScript('OnHide', AnimParentOnHide)
            return Flash
        end,
        Set = function(widget, value)
            widget:SetShown(value)
        end,
        noCreateFalse = true,
    },
    loading = {
        MakeMinimap = function(button)
            local Loading = CreateFrame('Frame', nil, button, 'NetEaseLoadingTemplate')
            Loading:SetSize(48, 48)
            Loading:SetPoint('CENTER')
            Loading:Show()
            return Loading
        end,
        Set = function(widget, value)
            widget:SetShown(value)
        end,
        noCreateFalse = true,
    },
    count = {
        MakeMinimap = function(button)
            local Count = button:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
            Count:SetPoint('CENTER')
            return Count
        end,
        Set = function(widget, value)
            widget:SetText(value)
        end,
        ExtraKeys = 'countFontObject',
        noCreateFalse = true,
    },
    countFontObject = {
        MakeMinimap = function(button)
            local Count = button:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
            Count:SetPoint('CENTER')
            return Count
        end,
        Set = function(widget, value)
            widget:SetFontObject(value)
        end,
        ExtraKeys = 'count',
        noCreateFalse = true,
    }
}

function Minimap:RegisterKeyData(name, key, t)
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'RegisterKey' (string expected, got %s)]]):format(type(name)), 2)
    end
    if type(key) ~= 'string' then
        error(([[bad argument #2 to 'RegisterKey' (string expected, got %s)]]):format(type(key)), 2)
    end
    if type(t) ~= 'table' then
        error(([[bad argument #3 to 'RegisterKey' (table expected, got %s)]]):format(type(t)), 2)
    end
    if type(t.MakeMinimap) ~= 'function' then
        error(([[bad argument #3.MakeMinimap to 'RegisterKey' (function expected, got %s)]]):format(type(t.MakeMinimap)), 2)
    end
    if type(t.Set) ~= 'function' then
        error(([[bad argument #3.Set to 'RegisterKey' (function expected, got %s)]]):format(type(t.Set)), 2)
    end
    if not self.DataObjects[name] then
        error(name .. ' dataObject not exists', 2)
    end
    if self.DataObjectsKeyDatas[name][key] then
        error(key .. ' Already exists', 2)
    end

    self.DataObjectsKeyDatas[name][key] = t
end

function Minimap:Register(name)
    if self.DataObjects[name] then
        error(name .. ' Already exists.', 2)
    end
    local dataObject = LDB:GetDataObjectByName(name)
    if not dataObject then
        error('Not found data object ' .. name, 2)
    end
    self.DataObjects[name] = dataObject
    self.MinimapKeyWidgets[name] = {}
    self.DataObjectsKeyDatas[name] = {}

    for key in pairs(self.KeyDatas) do
        self.DataObjectsKeyDatas[name][key] = false
    end

    local button = LibDBIcon:GetMinimapButton(name)
    if not button then
        return
    end
    self:OnMinimapButtonCreated(nil, button, name)
end

function Minimap:GetMinimapKeyWidget(name, key, dataObject, button)
    local widgets = self.MinimapKeyWidgets[name]

    local widget = widgets[key]
    if not widget then
        local keyData = self:GetKeyData(name, key)

        widget = keyData.MakeMinimap(button)
        widgets[key] = widget

        keyData.Set(widget, dataObject[key])

        if type(keyData.ExtraKeys) == 'string' then
            for key in keyData.ExtraKeys:gmatch('[^%s]+') do

                self:GetKeyData(name, key).Set(widget, dataObject[key])
            end
        end
    end
    return widget
end

function Minimap:GetKeyData(name, key)
    return self.DataObjectsKeyDatas[name][key] or
    self.KeyDatas[key]
end

function Minimap:IterateKeys(name)
    return pairs(self.DataObjectsKeyDatas[name])
end

function Minimap:OnAttributeChanged(_, name, key, value)
    local dataObject = self.DataObjects[name]
    if not dataObject then
        return
    end
    local keyData = self:GetKeyData(name, key)
    if not keyData then
        return
    end
    local button = LibDBIcon:GetMinimapButton(name)
    if not button then
        return
    end
    local widget = self:GetMinimapKeyWidget(name, key, dataObject, button)
    if not widget then
        return
    end
    keyData.Set(widget, value)
end

function Minimap:OnMinimapButtonCreated(_, button, name)
    local dataObject = self.DataObjects[name]
    if not dataObject then
        return
    end

    for key in self:IterateKeys(name) do
        local value = dataObject[key]
        local keyData = self:GetKeyData(name, key)

        if value or not keyData.noCreateFalse then
            self:OnAttributeChanged(_, name, key, value)
        end
    end
end

LDB.UnregisterAllCallbacks(Minimap)
LibDBIcon.UnregisterAllCallbacks(Minimap)

LDB.RegisterCallback(Minimap, 'LibDataBroker_AttributeChanged', 'OnAttributeChanged')
LibDBIcon.RegisterCallback(Minimap, 'LibDBIcon_IconCreated', 'OnMinimapButtonCreated')
