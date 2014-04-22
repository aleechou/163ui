
BuildEnv(...)

local CreatePanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'CreatePanel', 'AceEvent-3.0', 'AceTimer-3.0')

function CreatePanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    MainPanel:RegisterPanel(L['创建活动'], self, 8)

    local FilterLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    FilterLabel:SetPoint('TOPLEFT', self:GetOwner(), 'TOPLEFT', 80, -40)
    FilterLabel:SetText(L['活动类型'])

    local Filter = GUI:GetClass('Dropdown'):New(self)
    Filter:SetPoint('LEFT', FilterLabel, 'RIGHT', 10, 0)
    Filter:SetSize(200, 26)
    Filter:SetMenuTable(EVENT_CREATE_MENUTABLE)
    Filter:SetDefaultText(L['请选择活动类型'])

    local ModeLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    ModeLabel:SetPoint('LEFT', Filter, 'RIGHT', 10, 0)
    ModeLabel:SetText(L['活动形式'])

    local Mode = GUI:GetClass('Dropdown'):New(self)
    Mode:SetPoint('LEFT', ModeLabel, 'RIGHT', 10, 0)
    Mode:SetSize(200, 26)
    Mode:SetMenuTable(EVENT_MODE_MENUTABLE)
    Mode:SetDefaultText(L['请选择活动形式'])

    local YiXinButton = CreateFrame('Button', nil, self)
    YiXinButton:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -80, 20)
    YiXinButton:SetSize(36, 36)
    YiXinButton:SetHighlightTexture([[INTERFACE\BUTTONS\ButtonHilight-Square]], 'ADD')
    YiXinButton:SetBackdrop{
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
        tileSize = 16, edgeSize = 16, tile=true
    }
    YiXinButton:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.8)
    YiXinButton:SetMotionScriptsWhileDisabled(true)
    local YiXinButtonText = YiXinButton:CreateFontString(nil, 'OVERLAY')
    YiXinButtonText:SetPoint('LEFT', YiXinButton, 'RIGHT', 5, 0)
    YiXinButton:SetFontString(YiXinButtonText)
    YiXinButton:SetNormalFontObject('GameFontNormalSmallLeft')
    YiXinButton:SetHighlightFontObject('GameFontHighlightSmallLeft')
    YiXinButton:SetDisabledFontObject('GameFontDisableSmallLeft')
    YiXinButton:SetText(L['易信推送'])
    YiXinButton:SetHitRectInsets(0, - YiXinButtonText:GetWidth(), 0, 0)
    
    local texture = YiXinButton:CreateTexture(nil, 'BACKGROUND')
    texture:SetTexture([[Interface\AddOns\RaidBuilder\Media\YiXin]])
    texture:SetPoint('TOPLEFT', 3, -3)
    texture:SetPoint('BOTTOMRIGHT', -3, 3)

    GUI:SetTooltip(YiXinButton,
        L['易信通知'],
        L['你每天有3次机会向关注你的玩家发送活动通知。']
    )

    local function onStatusChanged()
        texture:SetDesaturated(not YiXinButton:IsEnabled())
    end
    YiXinButton:SetScript('OnEnable', onStatusChanged)
    YiXinButton:SetScript('OnDisable', onStatusChanged)
    YiXinButton:SetScript('OnClick', function()
        RaidBuilder:ShowModule('YixinConfirm', RaidBuilder:IsYiXinValid(), L['今日已达发送上限'])
    end)

    local RoleWidget = GUI:GetClass('TitleWidget'):New(self)
    RoleWidget:SetPoint('TOPLEFT')
    RoleWidget:SetPoint('TOPRIGHT')
    RoleWidget:SetHeight(135)
    RoleWidget:SetText(L['请确定每个职责的人数：'])

    local LevelWidget = GUI:GetClass('TitleWidget'):New(self)
    LevelWidget:SetPoint('TOPLEFT', RoleWidget, 'BOTTOMLEFT', 0, -5)
    LevelWidget:SetSize(200, 80)
    LevelWidget:SetText(L['等级范围'])

    local label = LevelWidget:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    label:SetPoint('CENTER', 0, -10)
    label:SetText('-')

    local ItemWidget = GUI:GetClass('TitleWidget'):New(self)
    ItemWidget:SetPoint('BOTTOMLEFT', LevelWidget, 'BOTTOMRIGHT', 5, 0)
    ItemWidget:SetPoint('TOPRIGHT', RoleWidget, 'BOTTOM', -2, -5)
    ItemWidget:SetText(L['装备等级'])

    local SummaryWidget = GUI:GetClass('TitleWidget'):New(self)
    SummaryWidget:SetPoint('TOPLEFT', LevelWidget, 'BOTTOMLEFT', 0, -5)
    SummaryWidget:SetPoint('BOTTOMLEFT')
    SummaryWidget:SetPoint('TOPRIGHT', ItemWidget, 'BOTTOMRIGHT', 0, -5)
    SummaryWidget:SetText(L['活动说明'])

    local PVPWidget = GUI:GetClass('TitleWidget'):New(self)
    PVPWidget:SetPoint('TOPLEFT', ItemWidget, 'TOPRIGHT', 5, 0)
    PVPWidget:SetPoint('BOTTOMLEFT', ItemWidget, 'BOTTOMRIGHT', 5, 0)
    PVPWidget:SetWidth(200)
    PVPWidget:SetText(L['PVP 等级'])

    local PwdWidget = GUI:GetClass('TitleWidget'):New(self)
    PwdWidget:SetPoint('BOTTOMLEFT', PVPWidget, 'BOTTOMRIGHT', 5, 0)
    PwdWidget:SetPoint('TOPRIGHT', RoleWidget, 'BOTTOMRIGHT', 0, -5)
    PwdWidget:SetText(L['申请密码'])

    local MiscWidget = GUI:GetClass('TitleWidget'):New(self)
    MiscWidget:SetPoint('BOTTOMLEFT', SummaryWidget, 'BOTTOMRIGHT', 5, 0)
    MiscWidget:SetPoint('TOPRIGHT', PwdWidget, 'BOTTOMRIGHT', 0, -5)

    local SummaryBox = GUI:GetClass('EditBox'):New(SummaryWidget)
    SummaryBox:SetPrompt(L['请在这里输入活动说明'])
    SummaryWidget:SetObject(SummaryBox)
    SummaryBox:GetEditBox():SetMaxBytes(46)

    local TankBox = RaidBuilder:GetClass('RoleInputBox'):New(RoleWidget)
    TankBox:SetPoint('BOTTOMLEFT', 40, 0)
    TankBox:SetStyle('TANK')

    local HealerBox = RaidBuilder:GetClass('RoleInputBox'):New(RoleWidget)
    HealerBox:SetPoint('LEFT', TankBox, 'RIGHT', 40, 0)
    HealerBox:SetStyle('HEALER')

    local DamagerBox = RaidBuilder:GetClass('RoleInputBox'):New(RoleWidget)
    DamagerBox:SetPoint('LEFT', HealerBox, 'RIGHT', 40, 0)
    DamagerBox:SetStyle('DAMAGER')

    local NoneBox = RaidBuilder:GetClass('RoleInputBox'):New(RoleWidget)
    NoneBox:SetPoint('LEFT', DamagerBox, 'RIGHT', 40, 0)
    NoneBox:SetStyle('NONE')

    local MinLevel = GUI:GetClass('InputBox2'):New(LevelWidget)
    MinLevel:SetPoint('BOTTOMLEFT', 10, 10)
    MinLevel:SetSize(80, 40)
    MinLevel:SetNumeric(true)
    MinLevel:SetMaxLetters(2)

    local MaxLevel = GUI:GetClass('InputBox2'):New(LevelWidget)
    MaxLevel:SetPoint('BOTTOMRIGHT', -10, 10)
    MaxLevel:SetSize(80, 40)
    MaxLevel:SetNumeric(true)
    MaxLevel:SetMaxLetters(2)

    local ItemLevel = GUI:GetClass('InputBox2'):New(ItemWidget)
    ItemLevel:SetPoint('BOTTOMLEFT', 20, 10)
    ItemLevel:SetPoint('BOTTOMRIGHT', -20, 10)
    ItemLevel:SetHeight(40)
    ItemLevel:SetNumeric(true)
    ItemLevel:SetMaxLetters(3)

    local PVPRating = GUI:GetClass('InputBox2'):New(PVPWidget)
    PVPRating:SetPoint('BOTTOMLEFT', 20, 10)
    PVPRating:SetPoint('BOTTOMRIGHT', -20, 10)
    PVPRating:SetHeight(40)
    PVPRating:SetNumeric(true)
    PVPRating:SetMaxLetters(4)

    local Password = GUI:GetClass('InputBox2'):New(PwdWidget)
    Password:SetPoint('BOTTOMLEFT', 20, 10)
    Password:SetPoint('BOTTOMRIGHT', -20, 10)
    Password:SetHeight(40)
    Password:SetNumeric(true)
    Password:SetMaxLetters(6)

    local CrossRealm = GUI:GetClass('CheckBox'):New(MiscWidget)
    CrossRealm:SetPoint('TOPLEFT', 20, -20)
    CrossRealm:SetSize(26, 26)
    CrossRealm:SetText(L['创建跨服活动'])

    local ForceVerify = GUI:GetClass('CheckBox'):New(MiscWidget)
    ForceVerify:SetPoint('TOPLEFT', CrossRealm, 'BOTTOMLEFT', 0, -10)
    ForceVerify:SetSize(26, 26)
    ForceVerify:SetText(L['必须符合要求'])

    self:RegisterInputBox(TankBox:GetInputBox())
    self:RegisterInputBox(HealerBox:GetInputBox())
    self:RegisterInputBox(DamagerBox:GetInputBox())
    self:RegisterInputBox(NoneBox:GetInputBox())
    self:RegisterInputBox(MinLevel)
    self:RegisterInputBox(MaxLevel)
    self:RegisterInputBox(ItemLevel)
    self:RegisterInputBox(PVPRating)
    self:RegisterInputBox(Password)
    self:RegisterInputBox(SummaryBox:GetEditBox())

    local CreateButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    CreateButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', 0, 4)
    CreateButton:SetSize(120, 22)
    CreateButton:SetText(L['创建活动'])
    CreateButton:Disable()

    local Blocker = CreateFrame('Frame', nil, self)
    Blocker:SetAllPoints(self)
    Blocker:SetToplevel(true)
    Blocker:EnableMouse(true)
    Blocker:EnableMouseWheel(true)
    Blocker:SetScript('OnMouseWheel', function() end)

    local bg = Blocker:CreateTexture(nil, 'OVERLAY')
    bg:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background]])
    bg:SetAllPoints(Blocker)

    local BlockerText = Blocker:CreateFontString(nil, 'OVERLAY', 'QuestFont_Super_Huge')
    BlockerText:SetPoint('CENTER')

    self.TankBox = TankBox
    self.HealerBox = HealerBox
    self.DamagerBox = DamagerBox
    self.NoneBox = NoneBox

    self.TankNumber = TankBox:GetInputBox()
    self.HealerNumber = HealerBox:GetInputBox()
    self.DamagerNumber = DamagerBox:GetInputBox()
    self.NoneNumber = NoneBox:GetInputBox()

    self.MinLevel = MinLevel
    self.MaxLevel = MaxLevel
    self.ItemLevel = ItemLevel
    self.PVPRating = PVPRating

    self.Filter = Filter
    self.Mode = Mode
    self.CrossRealm = CrossRealm
    self.ForceVerify = ForceVerify
    self.SummaryBox = SummaryBox
    self.Password = Password

    self.YiXinButton = YiXinButton
    self.Blocker = Blocker
    self.BlockerText = BlockerText
    self.CreateButton = CreateButton

    Filter:SetCallback('OnSelectChanged', function(_, data)
        self.Mode:SetMenuTable(GetEventModeMenuTable(data.value))
        self.Mode:SetValue(nil)
        self.CrossRealm:SetEnabled(GetEventAllowCrossRealm(data.value))
        self:SetEvent(Profile:GetEventProfile(data.value))
        self:Refresh()
    end)
    Mode:SetCallback('OnSelectChanged', function(_, data)
        self:Refresh()
    end)

    CreateButton:SetScript('OnClick', function()
        self:CreateEvent()
    end)

    self:SetScript('OnShow', self.OnShow)
end

function CreatePanel:OnShow()
    local event = EventCache:GetCurrentEvent()
    if event then
        self.Filter:SetValue(event:GetEventCode())
        self.Mode:SetValue(event:GetEventMode())
        self:SetEvent(event, false, false, false)

        self.CrossRealm:Disable()
        self.Filter:Disable()
        self.YiXinButton:Enable()
    else
        self.Filter:SetValue(nil)
        self.Mode:SetValue(nil)
        self:SetEvent(nil)

        self.CrossRealm:Enable()
        self.Filter:Enable()
        self.YiXinButton:Disable()
    end
    self:Refresh()
end

function CreatePanel:Update()
    local event = self.event
    local eventCode = event and event:GetEventCode() or self.Filter:GetValue()
    local tank, healer, damager, none = GetEventDefaultMemberRole(eventCode)
    if event then
        self.MinLevel:SetNumber(event:GetMinLevel() or GetEventMinLevel(eventCode))
        self.MaxLevel:SetNumber(event:GetMaxLevel() or MAX_PLAYER_LEVEL)
        self.ItemLevel:SetNumber(event:GetItemLevel() or 0)
        self.PVPRating:SetNumber(event:GetPVPRating() or 0)
        self.Password:SetText(event:GetPassword() or '')
        self.SummaryBox:SetText(event:GetSummary() or '')
        self.CrossRealm:SetChecked(event:GetCrossRealm())
        self.ForceVerify:SetChecked(event:GetForceVerify())

        self.TankNumber:SetNumber(event:GetRoleTotal('TANK') or tank)
        self.HealerNumber:SetNumber(event:GetRoleTotal('HEALER') or healer)
        self.DamagerNumber:SetNumber(event:GetRoleTotal('DAMAGER') or damager)
        self.NoneNumber:SetNumber(event:GetRoleTotal('NONE') or none)
    else
        self.MinLevel:SetNumber(GetEventMinLevel(eventCode))
        self.MaxLevel:SetNumber(MAX_PLAYER_LEVEL)
        self.ItemLevel:SetNumber(0)
        self.PVPRating:SetNumber(0)
        self.Password:SetText('')
        self.SummaryBox:SetText('')
        self.CrossRealm:SetChecked(false)
        self.ForceVerify:SetChecked(false)
        self.TankNumber:SetNumber(tank)
        self.HealerNumber:SetNumber(healer)
        self.DamagerNumber:SetNumber(damager)
        self.NoneNumber:SetNumber(none)
    end

    local isLeader = PlayerIsGroupLeader()
    local eventCode = self.Filter:GetValue()
    local nonBlock = isLeader and eventCode and self.Mode:GetValue()

    self.Blocker:SetShown(not nonBlock)
    self.CreateButton:SetEnabled(nonBlock)
    self.BlockerText:SetText(isLeader and L['请选择活动类型及活动形式'] or L['你不是队长，不能创建活动'])

    if eventCode then
        self.PVPRating:SetEnabled(bit.band(TYPE_MATCH, eventCode) >= EVENT_TYPE_BG)
    end
end

function CreatePanel:SetEvent(event)
    self.event = event
end

function CreatePanel:GetVisibleNumber(box)
    return box:IsVisible() and box:GetNumber() or 0
end

function CreatePanel:GetMemberRole(role)
    local tt = self:GetVisibleNumber(self.TankNumber)
    local th = self:GetVisibleNumber(self.HealerNumber)
    local td = self:GetVisibleNumber(self.DamagerNumber)
    local tn = self:GetVisibleNumber(self.NoneNumber)

    local ct = role == 'TANK' and 1 or 0
    local ch = role == 'HEALER' and 1 or 0
    local cd = role == 'DAMAGER' and 1 or 0
    local cn = role == 'NONE' and 1 or 0

    return PackMemberRole(ct, tt, ch, th, cd, td, cn, tn)
end

function CreatePanel:CheckMemberRole(maxMember)
    local tank   = self:GetVisibleNumber(self.TankNumber)
    local healer = self:GetVisibleNumber(self.HealerNumber)
    local damager= self:GetVisibleNumber(self.DamagerNumber)
    local none   = self:GetVisibleNumber(self.NoneNumber)

    local all = tank + healer + damager + none
    if all < 2 or all > maxMember then
        return
    end
    return true
end

function CreatePanel:CreateEvent()
    if AppliedCache:IsAnyApplied() then
        GUI:CallMessageDialog(L['你正在申请加入一些活动，是否取消申请以创建自己的活动？'],
            function(result)
                if result then
                    Logic:LeaveAllEvents()
                    self:ScheduleTimer('CreateEvent', 0.2)
                end
            end)
        return
    end

    local eventCode = self.Filter:GetValue()
    local _maxMember = GetEventMaxMember(eventCode)

    if not self:CheckMemberRole(_maxMember) then
        return System:Errorf(L['职责总人数不能小于2或大于%d'], _maxMember)
    end

    local minLevel = self.MinLevel:GetNumber()
    local maxLevel = self.MaxLevel:GetNumber()
    local _minLevel = GetEventMinLevel(eventCode)

    if maxLevel > MAX_PLAYER_LEVEL then
        return System:Errorf(L['等级最高不能超过%d'], MAX_PLAYER_LEVEL)
    end
    if minLevel < _minLevel then
        return System:Error(L['这个活动等级最低不能低于%d'], _minLevel)
    end
    if minLevel > maxLevel then
        return System:Error(L['最低等级不能超过最高等级'])
    end

    local eventMode = self.Mode:GetValue()
    local itemLevel = self.ItemLevel:GetNumber()
    local pvpRating = self.PVPRating:GetNumber()
    local summary = self.SummaryBox:GetText()
    local crossRealm = not not self.CrossRealm:GetChecked()
    local forceVerify = not not self.ForceVerify:GetChecked()
    local password = tonumber(self.Password:GetText())

    local event = Event:New()
    event:SetRoleTotal('TANK', self:GetVisibleNumber(self.TankNumber))
    event:SetRoleTotal('HEALER', self:GetVisibleNumber(self.HealerNumber))
    event:SetRoleTotal('DAMAGER', self:GetVisibleNumber(self.DamagerNumber))
    event:SetRoleTotal('NONE', self:GetVisibleNumber(self.NoneNumber))
    event:SetMinLevel(minLevel)
    event:SetMaxLevel(maxLevel)

    RaidBuilder:ShowModule('RolePanel', function(role)
        MemberCache:SetMemberRole(UnitName('player'), role)
        Logic:CreateEvent(
            eventCode,
            eventMode,
            minLevel,
            maxLevel,
            itemLevel,
            pvpRating,
            summary,
            crossRealm,
            forceVerify,
            password,
            self:GetMemberRole(role))

        self:OnShow()
    end, event)
end

function CreatePanel:QuickToggle(eventCode, eventMode)
    self.Filter:SetValue(eventCode)
    self.Mode:SetValue(eventMode)
end
