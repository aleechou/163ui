
local GUI = LibStub('NetEaseGUI-1.0')
local View = GUI:NewEmbed('Refresh', 1)
if not View then
    return
end

local function Refresh(self)
    self:SetScript('OnUpdate', nil)
    self:Update()

    if type(self.Fire) == 'function' then
    	self:Fire('OnRefresh')
    end
end

function View:Refresh()
    if self.notRefreshOnShow and not self:IsVisible() then
        return
    end

    if type(self.Update) == 'function' then
        self:SetScript('OnUpdate', Refresh)
    end
end

function View:EnableRefreshOnShow(flag)
    self.notRefreshOnShow = not flag or nil
    self:SetScript('OnUpdate', nil)
end
