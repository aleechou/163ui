
local GUI = LibStub('NetEaseGUI-1.0')
local View = GUI:NewEmbed('Filter', 2)
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

function View:SetFilterText(filterText, ...)
    if not filterText or filterText == '' or filterText == SEARCH then
        filterText = nil
    end
    self.filterText = filterText

    for i = 1, 20 do
        self['filterArg' .. i] = select(i, ...)
    end

    self:UpdateFilter()
    self:Refresh()
end

function View:GetFilterText()
    return self.filterText
end

function View:GetFilterArgs()
    return  self.filterArg1,
            self.filterArg2,
            self.filterArg3,
            self.filterArg4,
            self.filterArg5,
            self.filterArg6,
            self.filterArg7,
            self.filterArg8,
            self.filterArg9,
            self.filterArg10,
            self.filterArg11,
            self.filterArg12,
            self.filterArg13,
            self.filterArg14,
            self.filterArg15,
            self.filterArg16,
            self.filterArg17,
            self.filterArg18,
            self.filterArg19,
            self.filterArg20
end

function View:HasFilterArgs()
    if self.filterText then
        return true
    end
    for i = 1, 20 do
        if self['filterArg' .. i] then
            return true
        end
    end
end

function View:UpdateFilter()
    local filter = self.filter
    if not filter or not self:HasFilterArgs() then
        self.filterList = nil
    else
        self.filterList = wipe(self.filterList or {})

        for i = 1 + self:GetExcludeCount(), #self.itemList do
            if filter(self.itemList[i], self:GetFilterText(), self:GetFilterArgs()) then
                tinsert(self.filterList, self.itemList[i])
            end
        end
    end
end
