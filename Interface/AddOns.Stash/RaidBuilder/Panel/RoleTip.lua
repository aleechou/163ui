
BuildEnv(...)

RoleTip = CreateFrame('Frame', nil, UIParent)

function RoleTip:Load()
    self:SetFrameStrata('TOOLTIP')
    self:SetSize(100, 64)

    GUI:Embed(self, 'Refresh')

    local tLeft = self:CreateTexture(nil, 'BACKGROUND')
    tLeft:SetTexture([[Interface\AddOns\RaidBuilder\Media\RoleBg]])
    tLeft:SetTexCoord(0, 0.25, 0, 1)
    tLeft:SetPoint('TOPLEFT')
    tLeft:SetSize(64, 64)

    local tRight = self:CreateTexture(nil, 'BACKGROUND')
    tRight:SetTexture([[Interface\AddOns\RaidBuilder\Media\RoleBg]])
    tRight:SetTexCoord(0.6953125, 0.8203125, 0, 1)
    tRight:SetPoint('TOPRIGHT')
    tRight:SetSize(32, 64)

    local tMid = self:CreateTexture(nil, 'BACKGROUND')
    tMid:SetTexture([[Interface\AddOns\RaidBuilder\Media\RoleBg]])
    tMid:SetTexCoord(0.25, 0.6953125, 0, 1)
    tMid:SetPoint('TOPLEFT', tLeft, 'TOPRIGHT')
    tMid:SetPoint('BOTTOMRIGHT', tRight, 'BOTTOMLEFT')

    local function MakeRole(style)
        local icon, coords = GetRoleIconSmall(style)
        local Icon = self:CreateTexture(nil, 'ARTWORK')
        Icon:SetSize(20, 20)
        Icon:SetTexture(icon)
        Icon:SetTexCoord(unpack(coords))

        local Label = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
        Label:SetPoint('LEFT', Icon, 'RIGHT', 3, 0)

        return Icon, Label
    end

    self.Roles = {}
    for _, role in ipairs(RAID_ROLE_LIST) do
        local Icon, Label = MakeRole(role)
        self.Roles[role] = {
            Icon = Icon,
            Label = Label,
        }
    end

    -- local TotalIcon = self:CreateTexture(nil, 'ARTWORK')
    -- TotalIcon:SetTexture([[Interface\Addons\RaidBuilder\Media\DataBroker]])
    -- TotalIcon:SetTexCoord(0.5, 0.75, 0, 1)
    -- TotalIcon:SetSize(20, 20)

    -- local TotalLabel = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
    -- TotalLabel:SetPoint('LEFT', TotalIcon, 'RIGHT', 3, 0)

    -- self.TotalIcon = TotalIcon
    -- self.TotalLabel = TotalLabel
end

RoleTip:Load()

function RoleTip:Open(anchor, event)
    if not event then
        return
    end
    
    self:SetPoint('BOTTOMLEFT', anchor, 'TOPLEFT')
    self:Show()

    self.rightLabel = nil
    for _, role in ipairs(RAID_ROLE_LIST) do
        local Icon, Label = self.Roles[role].Icon, self.Roles[role].Label
        if event:GetRoleTotal(role) == 0 and event:GetRoleCurrent(role) == 0 then
            Icon:Hide()
            Label:Hide()
        else
            Icon:Show()
            Label:Show()
            Label:SetText(('%s%d/%d|r'):format(
                event:IsRoleFull(role) and RED_FONT_COLOR_CODE or HIGHLIGHT_FONT_COLOR_CODE,
                event:GetRoleCurrent(role),
                event:GetRoleTotal(role)))

            if not self.rightLabel then
                Icon:SetPoint('LEFT', 10, 10)
            else
                Icon:SetPoint('LEFT', self.rightLabel, 'RIGHT', 5, 0)
            end
            self.rightLabel = Label
        end
    end

    -- self.TotalLabel:SetText(format('%s%d/%d|r',
    --     event:IsMemberFull() and RED_FONT_COLOR_CODE or HIGHLIGHT_FONT_COLOR_CODE,
    --     event:GetRoleCurrentAll(),
    --     event:GetRoleTotalAll()))
    -- self.TotalIcon:SetPoint('LEFT', self.rightLabel, 'RIGHT', 5, 0)
    -- self.rightLabel = self.TotalLabel

    self:Refresh()
end

function RoleTip:Update()
    if not self.rightLabel then
        self:Hide()
    else
        local left = self:GetLeft()
        local right = self.rightLabel:GetRight()
        if not left or not right then
            self:Refresh()
        else
            self:SetWidth(right - left + 20)
        end
    end
end
