
BuildEnv(...)

local MemberRoleGrid = RaidBuilder:NewClass('MemberRoleGrid', GUI:GetClass('DataGridViewGridItem'))

-- function MemberRoleGrid:Constructor()
--     local function MakeRole(style)
--         local icon, coords = GetRoleIconSmall(style)
--         local Icon = self:CreateTexture(nil, 'ARTWORK')
--         Icon:SetSize(16, 16)
--         Icon:SetTexture(icon)
--         Icon:SetTexCoord(unpack(coords))

--         local Label = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmallLeft')
--         Label:SetPoint('LEFT', Icon, 'RIGHT', 0, 0)
--         Label:SetWidth(20)

--         return Icon, Label
--     end

--     self.Roles = {}

--     for i, role in ipairs(RAID_ROLE_LIST) do
--         local Icon, Label = MakeRole(role)
--         self.Roles[role] = {
--             Icon = Icon,
--             Label = Label,
--         }
--         if i == 1 then
--             Icon:SetPoint('LEFT', 0, 0)
--         else
--             Icon:SetPoint('LEFT', self.Roles[RAID_ROLE_LIST[i-1]].Label, 'RIGHT', 2, 0)
--         end
--     end
-- end

-- function MemberRoleGrid:SetEvent(event)
--     for i, role in ipairs(RAID_ROLE_LIST) do
--         local Icon, Label = self.Roles[role].Icon, self.Roles[role].Label
--         if event:GetRoleTotal(role) == 0 and event:GetRoleCurrent(role) == 0 then
--             Icon:Hide()
--             Label:Hide()
--         else
--             Icon:Show()
--             Label:Show()
--             Label:SetText(('%s%s|r'):format(
--                 event:IsRoleFull(role) and RED_FONT_COLOR_CODE or HIGHLIGHT_FONT_COLOR_CODE,
--                 event:GetRoleCurrent(role)))
--         end
--     end
-- end

function MemberRoleGrid:Constructor()
    local Icon = self:CreateTexture(nil, 'ARTWORK')
    Icon:SetSize(20, 20)
    Icon:SetPoint('LEFT')
    Icon:SetTexture([[Interface\Addons\RaidBuilder\Media\DataBroker]])
    Icon:SetTexCoord(0.5, 0.75, 0, 1)

    local Text = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmallLeft')
    Text:SetPoint('LEFT', Icon, 'RIGHT', 2, 0)

    self.Text = Text

    local function MakeRole(style)
        local icon, coords = GetRoleIconSmall(style)
        local Icon = self:CreateTexture(nil, 'ARTWORK')
        Icon:SetSize(16, 16)
        Icon:SetTexture(icon)
        Icon:SetTexCoord(unpack(coords))

        return Icon
    end

    self.Roles = {}

    local prevIcon
    for i, role in ripairs(RAID_ROLE_LIST) do
        local Icon = MakeRole(role)

        if not prevIcon then
            Icon:SetPoint('RIGHT', -5, 0)
        else
            Icon:SetPoint('RIGHT', prevIcon, 'LEFT')
        end

        self.Roles[role] = Icon
        prevIcon = Icon
    end
end

function MemberRoleGrid:SetEvent(event)
    local color = event:IsMemberFull() and RED_FONT_COLOR or HIGHLIGHT_FONT_COLOR
    
    self.Text:SetText(event:GetRoleCurrentAll() .. '/' .. event:GetRoleTotalAll())
    self.Text:SetTextColor(color.r, color.g, color.b)

    for i, role in ipairs(RAID_ROLE_LIST) do
        self.Roles[role]:SetShown(event:GetRoleTotal(role) > event:GetRoleCurrent(role))
    end
end
