
local GUI = LibStub('NetEaseGUI-1.0')
local View = GUI:NewEmbed('Blocker', 1)
if not View then
    return
end

local function comp(a, b)
    return a:GetOrder() > b:GetOrder()
end

function View:NewBlocker(name, order, blockTabs)
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'NewBlocker' (string expected, got %s)]]):format(type(name)), 2)
    end
    if type(order) ~= 'number' then
        error(([[bad argument #2 to 'NewBlocker' (number expected, got %s)]]):format(type(order)), 2)
    end

    local Blocker = GUI:GetClass('PanelBlocker'):New(self) do
        Blocker:SetPoint('BOTTOMLEFT', 5, blockTabs and -30 or 5)
        Blocker:SetPoint('TOPRIGHT', -5, -25)
        Blocker:SetOrder(order)
        Blocker:SetBlockTabs(blockTabs)
        Blocker:SetScript('OnHide', function()
            self:UpdateBlockers()
        end)
    end

    self.blockers[name] = Blocker
    tinsert(self.blockers, Blocker)
    sort(self.blockers, comp)

    return Blocker
end

function View:UpdateBlockers()
    local prevBlocker = self
    for i, blocker in ipairs(self.blockers) do
        if blocker:IsShown() or blocker:Fire('OnCheck') then
            blocker:Show()
            blocker:SetFrameLevel(prevBlocker:GetFrameLevel() + 50)
            prevBlocker = blocker
        else
            blocker:Hide()
        end
    end

    if prevBlocker ~= self then
        if self.HideHelpButtons then
            self:HideHelpButtons()
        end
        self.portrait:SetParent(prevBlocker)
        self.portraitFrame:SetParent(prevBlocker)
    else
        if self.ShowHelpButtons then
            self:ShowHelpButtons()
        end
        self.portrait:SetParent(self)
        self.portraitFrame:SetParent(self)
    end
end

function View:ToggleBlocker(name)
    local blocker = self.blockers[name]
    if not blocker then
        return
    end
    blocker:SetShown(not blocker:IsShown())
    self:UpdateBlockers()
end

function View:Embed(target)
    target.blockers = target.blockers or {}
    target.NewBlocker = self.NewBlocker
    target.UpdateBlockers = self.UpdateBlockers
    target.ToggleBlocker = self.ToggleBlocker
end
