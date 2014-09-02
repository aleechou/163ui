--[[
    EditBox.lua
    Create a EditBox with a scroll bar
    ver     1.0.0
    author  Jai
    email   814683@qq.com
    edit    2013-10-16 12:26:15
    change    
]]--

local WIDGET, VERSION = 'EditBox', 4

local GUI = LibStub('NetEaseGUI-1.0')
local EditBox = GUI:NewClass(WIDGET, 'Frame', VERSION)
if not EditBox then
    return
end

local objects = {}

WorldFrame:HookScript('OnMouseDown', function()
    if next(objects) then
        for object in pairs(objects) do
            object:ClearFocus()
        end
    end
end)

function EditBox:Constructor(parent)
    if not parent then
        return
    end

    local tTopLeft = self:CreateTexture(nil, 'BACKGROUND')
    tTopLeft:SetTexture([[Interface\Common\Common-Input-Border-TL]])
    tTopLeft:SetSize(8, 8)
    tTopLeft:SetPoint('TOPLEFT')
    local tTopRight = self:CreateTexture(nil, 'BACKGROUND')
    tTopRight:SetTexture([[Interface\Common\Common-Input-Border-TR]])
    tTopRight:SetSize(8, 8)
    tTopRight:SetPoint('TOPRIGHT')
    local tTop = self:CreateTexture(nil, 'BACKGROUND')
    tTop:SetTexture([[Interface\Common\Common-Input-Border-T]])
    tTop:SetPoint('TOPLEFT', tTopLeft, 'TOPRIGHT')
    tTop:SetPoint('BOTTOMRIGHT', tTopRight, 'BOTTOMLEFT')
    local tBottomLeft = self:CreateTexture(nil, 'BACKGROUND')
    tBottomLeft:SetTexture([[Interface\Common\Common-Input-Border-BL]])
    tBottomLeft:SetSize(8, 8)
    tBottomLeft:SetPoint('BOTTOMLEFT')
    local tBottomLeft = self:CreateTexture(nil, 'BACKGROUND')
    tBottomLeft:SetTexture([[Interface\Common\Common-Input-Border-BL]])
    tBottomLeft:SetSize(8, 8)
    tBottomLeft:SetPoint('BOTTOMLEFT')
    local tBottomRight = self:CreateTexture(nil, 'BACKGROUND')
    tBottomRight:SetTexture([[Interface\Common\Common-Input-Border-BR]])
    tBottomRight:SetSize(8, 8)
    tBottomRight:SetPoint('BOTTOMRIGHT')
    local tBottom = self:CreateTexture(nil, 'BACKGROUND')
    tBottom:SetTexture([[Interface\Common\Common-Input-Border-B]])
    tBottom:SetPoint('TOPLEFT', tBottomLeft, 'TOPRIGHT')
    tBottom:SetPoint('BOTTOMRIGHT', tBottomRight, 'BOTTOMLEFT')
    local tLeft = self:CreateTexture(nil, 'BACKGROUND')
    tLeft:SetTexture([[Interface\Common\Common-Input-Border-L]])
    tLeft:SetPoint('TOPLEFT', tTopLeft, 'BOTTOMLEFT')
    tLeft:SetPoint('BOTTOMRIGHT', tBottomLeft, 'TOPRIGHT')
    local tRight = self:CreateTexture(nil, 'BACKGROUND')
    tRight:SetTexture([[Interface\Common\Common-Input-Border-R]])
    tRight:SetPoint('TOPLEFT', tTopRight, 'BOTTOMLEFT')
    tRight:SetPoint('BOTTOMRIGHT', tBottomRight, 'TOPRIGHT')
    local tMiddle = self:CreateTexture(nil, 'BACKGROUND')
    tMiddle:SetTexture([[Interface\Common\Common-Input-Border-M]])
    tMiddle:SetPoint('TOPLEFT', tLeft, 'TOPRIGHT')
    tMiddle:SetPoint('BOTTOMRIGHT', tRight, 'BOTTOMLEFT')

    local scrollFrame = CreateFrame('ScrollFrame', nil, self)
    scrollFrame:SetPoint('TOPLEFT', 6, -6)
    scrollFrame:SetPoint('BOTTOMRIGHT', -6, 6)

    local scrollBar = CreateFrame('Slider', nil, scrollFrame, 'UIPanelScrollBarTemplate')
    scrollBar:SetFrameLevel(self:GetFrameLevel() + 2)
    scrollBar:SetPoint('TOPRIGHT', self, 'TOPRIGHT', -3, -16)
    scrollBar:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -3, 14)
    scrollBar.ScrollDownButton:SetPoint('TOP', scrollBar, 'BOTTOM', 0, 4)
    scrollBar.ScrollUpButton:SetPoint('BOTTOM', scrollBar, 'TOP', 0, -4)
    scrollBar:SetMinMaxValues(0, 0)
    scrollBar:SetValue(0)
    scrollBar:SetScript('OnShow', function(self)
        scrollFrame:SetPoint('BOTTOMRIGHT', -(self:GetWidth() + 5), 6)
    end)
    scrollBar:SetScript('OnHide', function(self)
        scrollFrame:SetPoint('BOTTOMRIGHT', -6, 6)
    end)

    local editBox = CreateFrame('EditBox', nil, scrollFrame)
    editBox:SetAutoFocus(false)
    editBox:SetCountInvisibleLetters(true)
    editBox:SetMaxLetters(140)
    editBox:SetMultiLine(true)
    editBox:SetScript('OnTextChanged', self.OnTextChanged)
    editBox:SetScript('OnCursorChanged', function(self, x, y, w, h)
        self.cursorOffset = y
        self.cursorHeight = h
        self.handleCursorChange = true
    end)
    editBox:SetScript('OnTabPressed', editBox.SetFocus)
    editBox:SetScript('OnUpdate', self.OnEditUpdate)
    editBox:SetScript('OnEscapePressed', editBox.ClearFocus)
    editBox:SetFontObject('GameFontHighlightSmall')

    local prompt = editBox:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalSmallLeft')
    prompt:SetPoint('TOPLEFT', 3, 0)
    prompt:SetTextColor(0.35, 0.35, 0.35)
    prompt:SetJustifyV('TOP')
    prompt:Hide()

    local focusButton = CreateFrame('Button', nil, scrollFrame)
    focusButton:SetAllPoints(true)
    focusButton:SetScript('OnClick', function(self)
        if editBox:IsEnabled() then
            editBox:SetFocus()
        end
    end)
    focusButton:SetScript('OnDoubleClick', function(self, button)
        if not editBox:IsEnabled() and button == 'LeftButton' then
            local msg = editBox:GetText()
            if msg ~= '' then
                ChatEdit_ActivateChat(ChatEdit_GetLastActiveWindow())
                ChatEdit_InsertLink(editBox:GetText())
                ChatEdit_GetActiveWindow():HighlightText()
            end
        end
    end)

    scrollFrame:SetScrollChild(editBox)
    scrollFrame:SetScript('OnScrollRangeChanged', self.OnScrollRangeChanged)
    scrollFrame:SetScript('OnVerticalScroll', self.OnVerticalScroll)
    scrollFrame:SetScript('OnMouseWheel', self.OnMouseWheel)
    
    scrollFrame:SetScript('OnSizeChanged', function(self, width, height)
        editBox:SetSize(width, height)
        prompt:SetSize(width - 6, height)
    end)

    self.Prompt = prompt
    self.ScrollBar = scrollBar
    self.ScrollFrame = scrollFrame
    self.EditBox = editBox
    self.FocusButton = focusButton

    self:SetParent(parent)
    self:SetAutoHide(true)
    self:SetTop(true)

    objects[self] = true
end

function EditBox:SetPrompt(text)
    local prompt = self.Prompt
    if text then
        prompt:SetText(text)
        -- prompt:SetSize(prompt:GetTextWidth(), prompt:GetTextHeight())
        prompt:Show()
    else
        prompt:Hide()
    end
end

function EditBox:OnEditUpdate(elapsed)
    if self.handleCursorChange then
        local scrollFrame = self:GetParent()
        local height = scrollFrame:GetHeight()
        local range = scrollFrame:GetVerticalScrollRange()
        local scroll = scrollFrame:GetVerticalScroll()
        local size = height + range
        local cursorOffset = -self.cursorOffset or 0
        
        if math.floor(height) <= 0 or math.floor(range) <= 0 then
            return
        end

        while cursorOffset < scroll do
            scroll = scroll - (height / 2)
            if scroll < 0 then
                scroll = 0
            end
            scrollFrame:SetVerticalScroll(scroll)
        end

        while cursorOffset + self.cursorHeight > scroll + height and scroll < range do
            scroll = scroll + (height / 2)
            if scroll > range then
                scroll = range
            end
            scrollFrame:SetVerticalScroll(scroll)
        end
        
        self.handleCursorChange = false
    end
end

function EditBox:OnTextChanged(userinput)
    local parent = self:GetParent():GetParent()
    parent.OnEditUpdate(self)
    parent.Prompt:SetShown(not (self:GetText() ~= ''))

    if parent.ScrollFrame.isTop and not self:HasFocus() then
        parent.ScrollFrame:SetVerticalScroll(0)
    end

    if userinput then
        parent:Fire('OnTextChanged', self:GetText())
    end
end

function EditBox:SetAutoHide(auto)
    local scrollBar = self.ScrollBar
    scrollBar.scrollBarHideable = auto
    scrollBar.ScrollDownButton:Disable()
    scrollBar.ScrollUpButton:Disable()
    if auto then
        scrollBar:Hide()
    else
        scrollBar:Show()
    end
end

function EditBox:GetAutoHide()
    return self.ScrollBar.scrollBarHideable
end

function EditBox:OnScrollRangeChanged(xOffset, yOffset)
    local scrollBar = self:GetChildren()
    yOffset = yOffset or self:GetVerticalScrollRange()
    local value = self.isTop and 0 or scrollBar:GetValue() > yOffset and yOffset or scrollBar:GetValue()
    scrollBar:SetMinMaxValues(0, yOffset)
    scrollBar:SetValue(value)
    if floor(yOffset) == 0 then
        if self:GetParent():GetAutoHide() then
            scrollBar:Hide()
        else
            scrollBar:Show()
            scrollBar.ScrollDownButton:Disable()
            scrollBar.ScrollUpButton:Disable()
        end
    else
        scrollBar:Show()
        if yOffset - value > 0.005 then
            scrollBar.ScrollDownButton:Enable()
        else
            scrollBar.ScrollDownButton:Disable()
        end
    end
end

function EditBox:OnVerticalScroll(offset)
    local scrollBar = self:GetChildren()
    scrollBar:SetValue(offset)
    local min, max = scrollBar:GetMinMaxValues()

    if offset == 0 then
        scrollBar.ScrollUpButton:Disable()
    else
        scrollBar.ScrollUpButton:Enable()
    end

    if offset - max == 0 then
        scrollBar.ScrollDownButton:Disable()
    else
        scrollBar.ScrollDownButton:Enable()
    end
end

function EditBox:OnMouseWheel(delta)
    local scrollBar = self:GetChildren()
    local scrollStep = scrollBar.scrollStep or scrollBar:GetHeight() / 2
    scrollBar:SetValue(scrollBar:GetValue() - scrollStep * delta)
end

function EditBox:GetText()
    return self:GetEditBox():GetText()
end

function EditBox:SetText(text)
    self:GetEditBox():SetText(text or '')
end

function EditBox:SetReadOnly(readonly)
    local editBox = self.EditBox
    local focusButton = self.FocusButton
    editBox[readonly and 'Disable' or 'Enable'](editBox)
    focusButton:SetFrameLevel(editBox:GetFrameLevel() + (readonly and 2 or 0))
end

function EditBox:GetEditBox()
    return self.EditBox
end

function EditBox:SetTop(isTop)
    self.ScrollFrame.isTop = isTop
end

function EditBox:SetFocus(is)
    local editBox = self:GetEditBox()
    editBox[is and 'SetFocus' or 'ClearFocus'](editBox)
end

function EditBox:SetTabPressed(func)
    if type(func) == 'function' then
        self:GetEditBox():SetScript('OnTabPressed', function(self)
            func()
        end)
    end
end

function EditBox:ClearFocus()
    self:SetFocus()
end

function EditBox:ClearCopy()
    self.FocusButton:SetScript('OnDoubleClick', nil)
end

function EditBox:SetMaxLetters(maxLetters)
    self:GetEditBox():SetMaxLetters(maxLetters)
end

function EditBox:SetMaxBytes(maxBytes)
    self:GetEditBox():SetMaxBytes(maxBytes)
end
