
local GUI = LibStub('NetEaseGUI-1.0')
local Menu = GUI:NewEmbed('Menu', 2)
if not Menu then
    return
end

local MenuFrame = GUI:NewClass('MenuFrame', 'Frame')
LibStub('AceTimer-3.0'):Embed(MenuFrame)

function MenuFrame:Constructor(parent)
    self:SetParent(parent)
    self:SetScript('OnUpdate', self.OnUpdate)
    self:SetScript('OnHide', self.OnTimer)
end

function MenuFrame:GetOwner()
    return self:GetParent():GetOwner()
end

function MenuFrame:IsOwnerVisible()
    return self:GetOwner() and self:GetOwner():IsVisible()
end

function MenuFrame:IsOwnerOver()
    return self:GetOwner() and self:GetOwner():IsMouseOver()
end

function MenuFrame:IsMenuOver()
    return self:GetParent():IsMouseOver()
end

function MenuFrame:OnUpdate(elapsed)
    if not self:IsOwnerVisible() then
        return self:OnTimer()
    end

    self.updater = (self.updater or 0) - elapsed
    if self.updater > 0 then
        return
    end
    self.updater = 0.5

    if self:IsOwnerOver() or self:IsMenuOver() then
        self:CancelAllTimers()
        self.timer = nil
    elseif not self.timer then
        self.timer = self:ScheduleTimer('OnTimer', 1.5)
    end
end

function MenuFrame:OnTimer()
    self:GetParent():Hide()
    self:CancelAllTimers()
    self.timer = nil
end

local _MenuFrames = {}

function Menu:GetMenuFrame()
    return _MenuFrames[self]
end

function Menu:Embed(target)
    local frame = _MenuFrames[target] or MenuFrame:New(target)
    _MenuFrames[target] = frame

    GUI:RegisterUIPanel(target)

    target.GetMenuFrame = self.GetMenuFrame
end
