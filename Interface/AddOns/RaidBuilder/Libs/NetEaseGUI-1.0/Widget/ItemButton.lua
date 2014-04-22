
local WIDGET, VERSION = 'ItemButton', 1

local GUI = LibStub('NetEaseGUI-1.0')
local Class = LibStub('LibClass-1.0')
local ItemButton = GUI:NewClass(WIDGET, 'CheckButton', VERSION, 'Owner')
if not ItemButton then
    return
end

function ItemButton:Constructor(parent)
    if not parent then
        return
    end
    self:SetParent(parent)
    self:SetMotionScriptsWhileDisabled(true)

    self:RegisterForClicks('LeftButtonUp', 'RightButtonUp')

    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
    self:SetScript('OnDoubleClick', self.OnDoubleClick)
end

function ItemButton:FireHandler(name)
    local parent = self:GetOwner()
    if parent then
        parent:Fire(name, self, parent:GetItem(self:GetID()))
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
        else
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
    self:FireHandler('OnItemEnter')
end

function ItemButton:OnLeave()
    self:FireHandler('OnItemLeave')
end

function ItemButton:SetStatus()
end

function ItemButton:GetAutoWidth()
    return self:GetWidth()
end

function ItemButton:Refresh()
    self:FireHandler('OnItemFormatted')

    local object = GetMouseFocus()
    local script = Class:IsObject(object) and object:GetScript('OnEnter')
    if script then
        script(object)
    end
end
