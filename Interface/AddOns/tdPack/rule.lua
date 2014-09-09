
local tdPack = tdCore(...)

local ipairs, sort, wipe = ipairs, sort, wipe

local Rule = tdPack:NewModule('Rule')

local compareStrings = {}

function Rule:New(tbl, default)
    local obj = {}
    
    obj.__unknownOrder = default
    for i, v in ipairs(tbl) do
        obj[v] = default and i or true
    end
    
    return obj
end

------ order

function Rule:GetJunkOrder(item)
    return item:GetItemQuality() == 0 and 1 or 0
end

function Rule:GetCustomOrder(item)
    return self.CustomOrder[item:GetItemID()] or self.CustomOrder[item:GetItemName()]
end

function Rule:GetTypeOrder(item)
    return  self.CustomOrder['#'  .. item:GetItemType() .. '##' .. item:GetItemSubType()] or
            self.CustomOrder['##' .. item:GetItemSubType()] or
            self.CustomOrder['#'  .. item:GetItemType()] or
            self.CustomOrder.__unknownOrder
end

function Rule:GetEquipLocOrder(item)
    return self.EquipLocOrder[item:GetItemEquipLoc()] or self.EquipLocOrder.__unknownOrder
end

function Rule:GetLevelOrder(item)
    return 9999 - item:GetItemLevel()
end

function Rule:GetQualityOrder(item)
    return 99 - item:GetItemQuality()
end

function Rule:GetCompareString(item)
    local itemID = item:GetItemID()
    if not compareStrings[itemID] then
        local idOrder = self:GetCustomOrder(item)
        
        compareStrings[itemID] = idOrder and ('0%03d'):format(idOrder) or ('%d%03d%02d%s%s%04d%02d%s'):format(
            self:GetJunkOrder(item),
            self:GetTypeOrder(item),
            self:GetEquipLocOrder(item),
            item:GetItemType(),
            self:GetQualityOrder(item),
            item:GetItemSubType(),
            self:GetLevelOrder(item),
            item:GetItemName()
        )
    end
    return compareStrings[itemID]
end

------ bank

function Rule:IsNeed(item, rule)
    if rule[item:GetItemID()] then
        return true
    end
    
    return  rule[item:GetItemName()] or
            rule['#' .. item:GetItemType() .. '##' .. item:GetItemSubType()] or
            rule['##' .. item:GetItemSubType()] or
            rule['#' .. item:GetItemType()]
end

function Rule:NeedSaveToBank(item)
    return Rule:IsNeed(item, self.SaveToBank)
end

function Rule:NeedLoadToBag(item)
    return Rule:IsNeed(item, self.LoadFromBank)
end

------ other

local function sortCompare(a, b)
    return Rule:GetCompareString(a) < Rule:GetCompareString(b)
end

function Rule:SortItems(items)
    sort(items, sortCompare)
end

function Rule:BuildRule()
    local profile = tdPack:GetProfile()
    
    self.CustomOrder   = Rule:New(profile.Orders.CustomOrder, 999)
    self.EquipLocOrder = Rule:New(profile.Orders.EquipLocOrder, 99)
    self.SaveToBank    = Rule:New(profile.SaveToBank)
    self.LoadFromBank  = Rule:New(profile.LoadFromBank)
end

function Rule:OnProfileUpdate()
    wipe(compareStrings)
    
    self:BuildRule()
end

function Rule:OnInit()
    self:BuildRule()
    self:SetHandle('OnProfileUpdate', self.OnProfileUpdate)
end
