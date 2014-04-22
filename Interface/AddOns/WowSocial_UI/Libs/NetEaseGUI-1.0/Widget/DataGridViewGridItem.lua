
local WIDGET, VERSION = 'DataGridViewGridItem', 2

local GUI = LibStub('NetEaseGUI-1.0')
local DataGridViewGridItem = GUI:NewClass(WIDGET, 'Button', VERSION)
if not DataGridViewGridItem then
    return
end

local STYLES = {
    LEFT = function(self)
        self.Icon:Hide()
        self:SetNormalFontObject('GameFontHighlightSmallLeft')
    end,
    RIGHT = function(self)
        self.Icon:Hide()
        self:SetNormalFontObject('GameFontHighlightSmallRight')
    end,
    NORMAL = function(self)
        self.Icon:Hide()
        self:SetNormalFontObject('GameFontHighlightSmall')
    end,
    ICON = function(self)
        self.Text:Hide()
        self.Icon:SetPoint('CENTER')
    end,
    ICONTEXT = function(self)
        self.Icon:SetPoint('LEFT')
        self.Text:ClearAllPoints()
        self.Text:SetPoint('LEFT', self.Icon, 'RIGHT', 5, 0)
        self.Text:SetPoint('TOPRIGHT')
        self.Text:SetPoint('BOTTOMRIGHT')
        self:SetNormalFontObject('GameFontHighlightSmallLeft')
    end,
}

function DataGridViewGridItem:Constructor(parent, style)
    if not parent then
        return
    end
    self:SetParent(parent)

    local Text = self:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('LEFT')
    Text:SetPoint('RIGHT')
    self:SetFontString(Text)

    local Icon = self:CreateTexture(nil, 'OVERLAY')
    Icon:SetSize(16, 16)

    self.Text = Text
    self.Icon = Icon

    STYLES[(style or 'NORMAL'):upper()](self)
    
    self:SetScript('OnSizeChanged', self.OnSizeChanged)
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
end

function DataGridViewGridItem:OnClick()
    self:GetParent():Click()
end

function DataGridViewGridItem:OnEnter()
    local parent = self:GetParent()
    local view = parent:GetOwner()

    if parent:GetChecked() then
        parent:UnlockHighlight()
    else
        parent:LockHighlight()
    end
    parent:OnEnter()
    view:Fire('OnGridEnter', self, view:GetItem(parent:GetID()), self.key)
end

function DataGridViewGridItem:OnLeave()
    local parent = self:GetParent()
    local view = parent:GetOwner()

    parent:UnlockHighlight()
    parent:OnLeave()
    view:Fire('OnGridLeave', self, view:GetItem(parent:GetID()), self.key)
end

function DataGridViewGridItem:SetIcon(icon, left, right, top, bottom, width, height)
    if not self.Icon then
        return
    end
    self.Icon:SetTexture(icon)
    if left then
        if type(left) == 'table' then
            local coords = left
            self.Icon:SetTexCoord(
                coords.left or coords[1],
                coords.right or coords[2],
                coords.top or coords[3],
                coords.bottom or coords.bot or coords[4])
        elseif type(left) == 'number' then
            self.Icon:SetTexCoord(left, right, top, bottom)
        end
    else
        self.Icon:SetTexCoord(0, 1, 0, 1)
    end

    width = width or 16
    height = height or width or 16

    self.Icon:SetSize(width, height)
end
