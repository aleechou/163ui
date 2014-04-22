
local GUI = LibStub('NetEaseGUI-1.0')
local View = GUI:NewEmbed('Filter', 1)
if not View then
    return
end

function View:RegisterFilter(method)
    if type(method) == 'function' then
        self.filter = method
    end
end

function View:UnregisterFilter()
    self.filter = nil
end

function View:SetFilterText(filterText)
    if not filterText or filterText == '' or filterText == SEARCH then
        filterText = nil
    end
    self.filterText = filterText
    self:UpdateFilter()
    self:Refresh()
end

function View:GetFilterText()
    return self.filterText
end

function View:UpdateFilter()
    local filter = self.filter
    local filterText = self:GetFilterText()
    if not filter or not filterText then
        self.filterList = nil
    else
        self.filterList = wipe(self.filterList or {})

        for i = 1 + self:GetExcludeCount(), #self.itemList do
            if filter(self.itemList[i], filterText) then
                tinsert(self.filterList, self.itemList[i])
            end
        end
    end
end
