
BuildEnv(...)

SharePanel = RaidBuilder:NewModule(GUI:GetClass('TitlePanel'):New(UIParent), 'SharePanel')

local CheckBox = RaidBuilder:NewClass('CheckBox', GUI:GetClass('ItemButton'))

function CheckBox:Constructor(parent)
    local normal = self:CreateTexture(nil, 'ARTWORK')
    normal:SetTexture([[INTERFACE\BUTTONS\UI-RADIOBUTTON]])
    normal:SetTexCoord(0, 0.25, 0, 1)
    normal:SetSize(16, 16)
    normal:SetPoint('LEFT', 2, 0)

    local highlight = self:CreateTexture(nil, 'ARTWORK')
    highlight:SetTexture([[INTERFACE\BUTTONS\UI-RADIOBUTTON]])
    highlight:SetTexCoord(0.5, 0.75, 0, 1)
    highlight:SetSize(16, 16)
    highlight:SetPoint('LEFT', 2, 0)
    highlight:SetBlendMode('ADD')

    local checked = self:CreateTexture(nil, 'ARTWORK')
    checked:SetTexture([[INTERFACE\BUTTONS\UI-RADIOBUTTON]])
    checked:SetTexCoord(0.25, 0.5, 0, 1)
    checked:SetSize(16, 16)
    checked:SetPoint('LEFT', 2, 0)

    local disabled = self:CreateTexture(nil, 'ARTWORK')
    disabled:SetTexture([[INTERFACE\BUTTONS\UI-RADIOBUTTON]])
    disabled:SetTexCoord(0.75, 1, 0, 1)
    disabled:SetSize(16, 16)
    disabled:SetPoint('LEFT', 2, 0)

    local text = self:CreateFontString(nil, 'ARTWORK')
    text:SetPoint('LEFT', normal, 'RIGHT', 5, 0)
    self:SetFontString(text)

    self:SetNormalTexture(normal)
    self:SetHighlightTexture(highlight)
    self:SetCheckedTexture(checked)
    self:SetDisabledTexture(disabled)

    self:SetNormalFontObject('GameFontNormalSmallLeft')
    self:SetHighlightFontObject('GameFontHighlightSmallLeft')
    self:SetDisabledFontObject('GameFontDisableSmallLeft')
end

function SharePanel:OnInitialize()
    self:SetSize(400, 250)
    self:SetPoint('CENTER')
    self:SetFrameStrata('DIALOG')
    self:Hide()

    local ShareList = GUI:GetClass('GridView'):New(self)
    ShareList:SetPoint('TOPLEFT', 40, -30)
    ShareList:SetPoint('TOPRIGHT', -40, -30)
    ShareList:SetHeight(105)
    ShareList:SetColumnCount(2)
    ShareList:SetItemHeight(20)
    ShareList:SetItemClass(CheckBox)
    ShareList:SetSelectMode('RADIO')
    ShareList:SetCallback('OnItemFormatted', function(_, button, data)
        local color = ChatTypeInfo[data.value] or NORMAL_FONT_COLOR
        button:SetText(data.text)
        button:GetFontString():SetTextColor(color.r, color.g, color.b)
    end)
    ShareList:SetCallback('OnSelectChanged', function(_, button)
        self.ShareButton:Enable()
    end)

    local ShareContent = GUI:GetClass('EditBox'):New(self)
    ShareContent:SetPoint('TOPLEFT', ShareList, 'BOTTOMLEFT', 0, -10)
    ShareContent:SetPoint('TOPRIGHT', ShareList, 'BOTTOMRIGHT', 0, -10)
    ShareContent:SetHeight(50)
    ShareContent:SetMaxBytes(255)

    local ShareButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    ShareButton:SetPoint('BOTTOMRIGHT', self, 'BOTTOM', 0, 20)
    ShareButton:SetSize(100, 22)
    ShareButton:SetText(L['发送'])
    ShareButton:SetScript('OnClick', function()
        self:Share()
    end)

    local CancelButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    CancelButton:SetPoint('BOTTOMLEFT', self, 'BOTTOM', 0, 20)
    CancelButton:SetSize(100, 22)
    CancelButton:SetText(CANCEL)
    CancelButton:SetScript('OnClick', HideParentPanel)

    self:SetScript('OnHide', StaticPopupSpecial_Hide)

    self.ShareButton = ShareButton
    self.ShareList = ShareList
    self.ShareContent = ShareContent
end

function SharePanel:Share()
    self:Hide()

    local content = self.ShareContent:GetText()
    local item = self.ShareList:GetItem(self.ShareList:GetSelected())

    if not content:match(ADDON_TITLE) then
        content = '<' .. ADDON_TITLE .. '>' .. content
    end

    if item.value == 'YIXIN' then
        RaidBuilder:ShowModule('YixinConfirm', RaidBuilder:IsYiXinValid(), L['今日已达发送上限'])
    elseif item.value == 'BN_INLINE_TOAST_BROADCAST' then
        BNSetCustomMessage(content)
    else
        SendChatMessage(content, item.value, nil, item.id)
    end
end

function SharePanel:SetArguments(titel, content)
    local list = {}

    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        tinsert(list, { text = INSTANCE_CHAT, value = 'INSTANCE_CHAT' })
    end
    if IsInRaid(LE_PARTY_CATEGORY_HOME) then
        tinsert(list, { text = CHAT_MSG_RAID, value = 'RAID', })
    end
    if IsInGroup(LE_PARTY_CATEGORY_HOME) then
        tinsert(list, { text = CHAT_MSG_PARTY, value = 'PARTY', })
    end
    if GetGuildInfo('player') then
        tinsert(list, { text = CHAT_MSG_GUILD, value = 'GUILD' })
    end
    if select(2, BNGetInfo()) then
        tinsert(list, { text = L['战网通告'], value = 'BN_INLINE_TOAST_BROADCAST' })
    end

    tinsert(list, { text = CHAT_MSG_SAY,  value = 'SAY'})
    tinsert(list, { text = CHAT_MSG_YELL, value = 'YELL', })

    local channels = {GetChannelList()}

    for i = 1, #channels, 2 do
        local id, name = channels[i], channels[i+1]
        if not name:find('友团') then
            tinsert(list, { text = name, value = 'CHANNEL', id = id })
        end
    end

    self:SetText(titel)

    self.ShareList:SetItemList(list)
    self.ShareList:SetSelected(nil)
    self.ShareList:Refresh()

    self.ShareButton:Disable()

    self.ShareContent:SetText(content)
    StaticPopupSpecial_Show(self)
end
