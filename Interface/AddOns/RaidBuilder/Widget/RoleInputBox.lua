
BuildEnv(...)

local RoleInputBox = RaidBuilder:NewClass('RoleInputBox', 'Frame')

function RoleInputBox:Constructor(parent)
    self:SetParent(parent)
    self:SetSize(130, 80)

    local Icon = self:CreateTexture(nil, 'OVERLAY')
    Icon:SetSize(48, 48)
    Icon:SetPoint('TOPLEFT')

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
    Text:SetPoint('TOP', Icon, 'BOTTOM', 0, -1)

    local InputBox = GUI:GetClass('InputBox2'):New(self)
    InputBox:SetPoint('TOPLEFT', Icon, 'TOPRIGHT', 2, -5)
    InputBox:SetPoint('TOPRIGHT', 0, -5)
    InputBox:SetHeight(40)
    InputBox:SetMaxLetters(2)
    InputBox:SetNumeric(true)

    self.InputBox = InputBox
    self.Icon = Icon
    self.Text = Text
end

function RoleInputBox:SetStyle(style)
    local icon, coords = GetRoleIconLarge(style)
    local text = GetRoleInfo(style)
    self.Icon:SetTexture(icon)
    self.Icon:SetTexCoord(unpack(coords))
    self.Text:SetText(text)
end

function RoleInputBox:GetInputBox()
    return self.InputBox
end

function RoleInputBox:GetText()
    return self.InputBox:GetText()
end

function RoleInputBox:GetNumber()
    return self.InputBox:GetNumber()
end
