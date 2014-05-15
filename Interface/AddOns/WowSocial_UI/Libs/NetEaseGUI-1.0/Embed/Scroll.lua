
local GUI = LibStub('NetEaseGUI-1.0')
local View = GUI:NewEmbed('Scroll', 1)
if not View then
    return
end

local function scrollBarOnShownChanged(bar)
    bar:GetParent():UpdateLayout()
end

local function viewOnMouseWheel(self, delta)
    self.ScrollBar:SetValue(self.ScrollBar:GetValue() - delta * self:GetScrollStep())
end

function View:GetScrollBar()
    if not self.ScrollBar then
        local ScrollBar = GUI:GetClass('ScrollBar'):New(self)

        local left, right, top, bot = self:GetPadding()

        ScrollBar:SetPoint('TOPRIGHT', -right, -16-top)
        ScrollBar:SetPoint('BOTTOMRIGHT', -right, 16+bot)

        ScrollBar:SetScript('OnShow', scrollBarOnShownChanged)
        ScrollBar:SetScript('OnHide', scrollBarOnShownChanged)

        ScrollBar:SetScrollStep(self:GetScrollStep())
        ScrollBar.noScrollBarHidden = self.noScrollBarHidden

        self:SetScript('OnMouseWheel', viewOnMouseWheel)

        self.ScrollBar = ScrollBar
    end
    return self.ScrollBar
end

function View:IsScrollBarShown()
    return self.ScrollBar and self.ScrollBar:IsShown()
end

function View:SetScrollStep(scrollStep)
    self.scrollStep = scrollStep
    if self.ScrollBar then
        self.ScrollBar:SetScrollStep(scrollStep)
    end
end

function View:GetScrollStep()
    return self.scrollStep or 1
end

function View:AtTop()
    return not self.ScrollBar or self.ScrollBar:AtTop()
end

function View:AtBottom()
    return not self.ScrollBar or self.ScrollBar:AtBottom()
end

function View:SetOffset(offset)
    self.offset = floor(offset + 0.5)
    self:Refresh()
end

function View:GetOffset()
    return self.offset or 1
end

function View:UpdateScrollBar(position)
    if not self:GetItemList() then
        return
    end

    local itemCount = self:GetItemCount()
    local maxCount = self:GetMaxCount()
    local maxValue = itemCount <= maxCount and 1 or itemCount - maxCount + 1
    local value

    if position == 'TOP' then
        value = 1
    elseif position == 'BOTTOM' then
        value = maxValue
    elseif self:IsHoldTop() and self:AtTop() then
        value = 1
    elseif self:IsHoldBottom() and self:AtBottom() then
        value = maxValue
    elseif self.ScrollBar then
        value = self.ScrollBar:GetValue()
    elseif self.GetReverse and self:GetReverse() then
        value = maxValue
    else
        value = 1
    end

    if maxValue > 1 or self.ScrollBar then
        local ScrollBar = self:GetScrollBar()

        ScrollBar:SetMinMaxValues(1, maxValue)
        ScrollBar:SetValue(value)
    end
end

function View:ScrollToTop()
    self:UpdateScrollBar('TOP')
    self:Refresh()
end

function View:ScrollToBottom()
    self:UpdateScrollBar('BOTTOM')
    self:Refresh()
end

function View:EnableHoldBottom(flag)
    self.notHoldBottom = not flag or nil
end

function View:EnableHoldTop(flag)
    self.notHoldTop = not flag or nil
end

function View:IsHoldBottom()
    return not self.notHoldBottom
end

function View:IsHoldTop()
    return not self.notHoldTop
end
