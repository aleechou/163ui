
local WIDGET, VERSION = 'ItemButton', 5

local GUI = LibStub('NetEaseGUI-1.0')
local Class = LibStub('LibClass-1.0')
local ItemButton = GUI:NewClass(WIDGET, 'CheckButton', VERSION, 'Owner')
if not ItemButton then
    return
end

function ItemButton:Constructor(parent, highlightWithoutChecked)
    if not parent then
        return
    end

    self.highlightWithoutChecked = highlightWithoutChecked

    self:SetParent(parent)
    self:SetMotionScriptsWhileDisabled(true)

    self:RegisterForClicks('LeftButtonUp', 'RightButtonUp')

    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
    self:SetScript('OnDoubleClick', self.OnDoubleClick)
end

function ItemButton:FireHandler(name, ...)
    local parent = self:GetOwner()
    if parent then
        parent:Fire(name, self, parent:GetItem(self:GetID()), ...)
    end
end

function ItemButton:OnClick(button)
    PlaySound('igMainMenuOptionCheckBoxOn')
    if not self:GetOwner() then
        return
    end

    self:SetChecked(not self:GetChecked())

    if button == 'LeftButton' then
        if self:GetID() == 0 then
            self:GetOwner():ToggleMenu(self)
        elseif not self.noSelectable then
            self:GetOwner():SetSelected(self:GetID())
        end
        self:FireHandler('OnItemClick')
    elseif button == 'RightButton' then
        self:FireHandler('OnItemMenu')
    end
end

function ItemButton:OnDoubleClick(button)
    if button == 'LeftButton' then
        self:FireHandler('OnItemDoubleClick')
    end
end

function ItemButton:OnEnter()
    if self.highlightWithoutChecked and self:GetHighlightTexture() then
        self:GetHighlightTexture():SetShown(not self:GetChecked())
    end
    self.isEntered = true
    self:FireHandler('OnItemEnter')
end

function ItemButton:OnLeave()
    self.isEntered = nil
    self:FireHandler('OnItemLeave')
end

function ItemButton:SetStatus()
end

function ItemButton:GetAutoWidth()
    return self:GetWidth()
end

function ItemButton:Refresh()
    self:FireHandler('OnItemFormatted')

    if self.isEntered then
        self:FireHandler('OnItemEnter')
    end
end

function ItemButton:SetSelectable(flag)
    self.noSelectable = not flag or nil
end

function ItemButton:Group(...)
    self:FireHandler('OnItemGrouped', ...)
end
