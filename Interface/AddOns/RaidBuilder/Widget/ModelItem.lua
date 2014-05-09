
BuildEnv(...)

local ModelItem = RaidBuilder:NewClass('ModelItem', GUI:GetClass('ItemButton'))

function ModelItem:Constructor(parent)
    if not parent then
        return
    end

    self:SetParent(parent)
    self:SetBackdrop{
        bgFile='Interface/Tooltips/UI-Tooltip-Background',
        edgeFile='Interface/Tooltips/UI-Tooltip-Border',
        insets = {left = 4, right = 4, top = 4, bottom = 4},
        tile=true, tileSize = 16, edgeSize = 16,
    }
    self:SetBackdropColor(0, 0, 0, 1)
    self:SetAlpha(1)

    local Model = CreateFrame('DressUpModel', nil, self)
    Model:SetPoint('TOPLEFT', 5, -5)
    Model:SetPoint('BOTTOMRIGHT', -5, 5)

    local Name = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    Name:SetPoint('TOP')
    Name:SetHeight(20)

    local RoleIcon = self:CreateTexture(nil, 'ARTWORK')
    RoleIcon:SetSize(20, 20)
    RoleIcon:SetPoint('BOTTOMLEFT', 5, 5)

    local RaidTargetIcon = self:CreateTexture(nil, 'ARTWORK')
    RaidTargetIcon:SetSize(20, 20)
    RaidTargetIcon:SetPoint('LEFT', RoleIcon, 'RIGHT')

    local UnitState = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    UnitState:SetSize(50, 20)
    UnitState:SetPoint('BOTTOMRIGHT', -5, 5)

    local YiXinButton = CreateFrame('Button', nil, self)
    YiXinButton:SetNormalTexture([[Interface\AddOns\RaidBuilder\Media\YiXinSmall]])
    YiXinButton:SetHighlightTexture([[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]], 'ADD')
    YiXinButton:GetNormalTexture():SetTexCoord(0, 19/32, 1/128, 20/32)
    YiXinButton:SetSize(20, 20)
    YiXinButton:SetPoint('BOTTOMLEFT', RoleIcon, 'TOPLEFT')
    local YiXinButtonText = YiXinButton:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallLeft')
    YiXinButtonText:SetPoint('LEFT', YiXinButton, 'RIGHT', 1, 0)
    YiXinButton:SetFontString(YiXinButtonText)
    YiXinButton:SetHighlightFontObject('GameFontNormalSmallLeft')
    YiXinButton:SetScript('OnClick', function()
        RaidBuilder:ShowModule('YixinSummary')
    end)

    local AssistantIcon = self:CreateTexture(nil, 'ARTWORK')
    AssistantIcon:SetPoint('TOPLEFT', 5, 0)
    AssistantIcon:SetSize(20, 20)

    self.Model = Model
    self.Name = Name
    self.RoleIcon = RoleIcon
    self.RaidTargetIcon = RaidTargetIcon
    self.UnitState = UnitState
    self.YiXinButton = YiXinButton
    self.AssistantIcon = AssistantIcon
end

function ModelItem:UpdateGroupAssistant()
    local unitId = self:GetUnitId()
    local AssistantIcon = self.AssistantIcon

    if UnitIsGroupLeader(unitId) then
        AssistantIcon:SetTexture([[INTERFACE\GROUPFRAME\UI-Group-LeaderIcon]])
    elseif UnitIsGroupAssistant(unitId) then
        AssistantIcon:SetTexture([[INTERFACE\GROUPFRAME\UI-GROUP-ASSISTANTICON]])
    elseif GetPartyAssignment('MAINASSIST', unitId) then
        AssistantIcon:SetTexture([[INTERFACE\GROUPFRAME\UI-GROUP-MAINASSISTICON]])
    elseif GetPartyAssignment('MAINTANK', unitId) then
        AssistantIcon:SetTexture([[INTERFACE\GROUPFRAME\UI-GROUP-MAINTANKICON]])
    else
        AssistantIcon:SetTexture('')
    end
end

function ModelItem:UpdateYiXinFans()
    local unitId = self:GetUnitId()
    local YiXinButton = self.YiXinButton

    if not UnitIsGroupLeader(unitId) and (UnitInRaid('player') or UnitInParty('player')) then
        self.YiXinButton:Hide()
        return
    end

    local member = GroupCache:GetUnitInfo(UnitName(unitId))
    local fans = UnitIsUnit(unitId, 'player') and Logic:GetPlayerFans() or member and member:GetFans() or 0
    
    local name, realm = _G.UnitFullName(unitId)
    if not name or not realm then
        self.YiXinButton:Hide()
        return
    end

    YiXinButton:Show()
    YiXinButton:SetText(fans)
    YiXinButton:SetHitRectInsets(0, -YiXinButton:GetTextWidth(), 0, 0)

    GUI:SetTooltip(YiXinButton,
        'ANCHOR_RIGHT',
        L['在|cff00ffff易信|r中关注Ta仅需两步：'],
        ' ',
        L['1.下载易信并关注公众号“|cffffd100友团插件|r”'],
        (L['2.向“|cffffd100友团插件|r”发送“|cffffd100关注%s@%s|r”即可']):format(name, realm),
        ' ',
        L['点击查看详细步骤'])
end

function ModelItem:UpdateRaidTargetIcon()
    local unitId = self:GetUnitId()
    if CanBeRaidTarget(unitId) then
        local id = GetRaidTargetIndex(unitId) or 0
        if GetRaidTargetIndex(unitId) ~= id then
            SetRaidTarget(unitId, id)
        end
        self.RaidTargetIcon:SetTexture(id == 0 and '' or
            [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_]] .. id)
    end
end

function ModelItem:UpdateRoleIcon()
    local role = self:GetUnitRole()

    local tex, coords = GetRoleIconSmall(role)
    local icon = self.RoleIcon
    icon:SetTexture(tex)
    icon:SetTexCoord(unpack(coords))
end

function ModelItem:UpdateUnitState()
    local unitId = self:GetUnitId()
    local isOnline = UnitIsConnected(unitId)
    if not isOnline then
        self:SetBackdropColor(0.5, 0.5, 0.5)
        return self.UnitState:SetText(L['离线'])
    end
    local isAFK = UnitIsAFK(unitId)
    if isAFK then
        return self.UnitState:SetText(L['暂离'])
    end
    local isDND = UnitIsDND(unitId)
    if isDND then
        return self.UnitState:SetText(L['忙碌'])
    end
    self.UnitState:SetText()
end

function ModelItem:GetUnitRole()
    local unit = self:GetUnitId()
    local name = UnitName(unit)

    local role = GroupCache:GetUnitRole(name)
    return role or UnitGroupRolesAssigned(unit) or 'NONE'
end

function ModelItem:Clear()
    self.Model:ClearModel()
    self.Name:SetText()
    self.RoleIcon:SetTexCoord(0, 0, 0, 0)
    self.RaidTargetIcon:SetTexture('')
    self:SetBackdropColor(0, 0, 0)
    self.UnitState:SetText()
    self.YiXinButton:Hide()
    self:Hide()
    self.UnitId = nil
end

function ModelItem:SetUnit(unitId, isShowModel)
    if not unitId or not UnitExists(unitId) then
        return self:Clear()
    end

    unitId = unitId or 'none'
    self.UnitId = unitId

    local name = UnitName(unitId)
    local Model = self.Model

    Model:SetShown(isShowModel)

    if isShowModel then
        if self:GetName() ~= name or Model:GetModel() == '' then
            if UnitIsVisible(unitId) then
                Model:SetUnit(unitId)
                self._name = name
            else
                Model:ClearModel()
            end
        end
    else
        Model:ClearModel()
    end

    self:UpdateClassColor()
    self:UpdateName()
    self:UpdateRoleIcon()
    self:UpdateRaidTargetIcon()
    self:UpdateUnitState()
    self:UpdateYiXinFans()
    self:UpdateGroupAssistant()
end

function ModelItem:GetUnitId()
    return self.UnitId
end

function ModelItem:UpdateClassColor()
    local className = select(2, UnitClass(self:GetUnitId()))
    if className then
        local color = RAID_CLASS_COLORS[strupper(className)]
        self:SetBackdropColor(color.r, color.g, color.b, 1)
    else
        self:SetBackdropColor(0, 0, 0, 1)
    end
end

function ModelItem:UpdateName()
    self.Name:SetText(GetUnitName(self:GetUnitId()))
end

function ModelItem:GetName()
    return self._name
end
