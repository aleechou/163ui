local huanhuadata = LibStub("LibItemData-1.0")
local _G = getfenv(0)
huanhua = LibStub("AceAddon-3.0"):NewAddon("huanhua", "AceHook-3.0", "AceEvent-3.0") 
local huanhua = huanhua 
local GetItemCount = _G.GetItemCount
local GetItemInfo = _G.GetItemInfo
local pairs = _G.pairs 
local showHuahuaSet = true
local showsetdressup = true

function huanhua:OnEnable() 
  self:SecureHookScript(GameTooltip, "OnTooltipSetItem")
  self:SecureHookScript(GameTooltip, "OnTooltipCleared")
  self:SecureHookScript(ItemRefTooltip, "OnTooltipSetItem")
  self:SecureHookScript(ItemRefTooltip, "OnTooltipCleared")
  self:SecureHookScript(ShoppingTooltip1, "OnTooltipSetItem")
  self:SecureHookScript(ShoppingTooltip1, "OnTooltipCleared")
  self:SecureHookScript(ShoppingTooltip2, "OnTooltipSetItem")
  self:SecureHookScript(ShoppingTooltip2, "OnTooltipCleared")
  self:SecureHookScript(ShoppingTooltip3, "OnTooltipSetItem")
  self:SecureHookScript(ShoppingTooltip3, "OnTooltipCleared")
  self:SecureHook("DressUpItemLink");
end



function huanhua:DressUpItemLink(link) 
  if IsAltKeyDown() then
    local itemID = strmatch(link, "item:(%d+)");
    local iType, subType, setName, setsdata = huanhuadata:FindItem(itemID);
    if (not iType) then return; end
    local model = DressUpModel;
    if ( SideDressUpFrame.parentFrame and SideDressUpFrame.parentFrame:IsShown() ) then
      model = SideDressUpModel;
    end
    model:Undress();
    for _, id in ipairs(setsdata) do
      if (IsDressableItem(id)) then
        model:TryOn(id);
      end
    end
  end
end 

function huanhua:GetSetItemCount(sets)
  local count = 0;
  for i, itemID in ipairs(sets) do
    local c = GetItemCount(itemID);
    if (c > 0) then
      count = count + 1;
    end
  end
  return count, #sets;
end


function huanhua:OnTooltipSetItem(tooltip, ...)
  local item = select(2, tooltip:GetItem())
  if tooltip.huanhua_data_added or not item or not GetItemInfo(item) then return end
  local quality,iLevel,_,_,_,stack = select(3, GetItemInfo(item))
  local itemID = string.match(item, "item:(%d+)")






  if showHuahuaSet then
    local iType, subType, setName, setsdata = huanhuadata:FindItem(itemID);
    if (iType) then
      local curCount, totalCount = huanhua:GetSetItemCount(setsdata);
      local text = "\n[幻化] ";
      text = text .. setName .. (" (%d/%d)"):format(curCount, totalCount);
      tooltip:AddLine(text, 0.97, 0.51, 0.97);
      for i, id in ipairs(setsdata) do
        local name = GetItemInfo(id);
        local c = GetItemCount(id);
        if (c > 0) then
          tooltip:AddLine(name, 1, 1, 1);
        else
          tooltip:AddLine(name, 0.62, 0.62, 0.62);
        end
      end
      tooltip:AddLine("幻化分类" .. iType .. "-" .. subType, 0.9, 0.9, 0.9);
      if showsetdressup then
        tooltip:AddLine("\nCtrl + Alt +鼠标左键可试穿套装", 0, 0.6, 0.8);
      end
    end
  end
  tooltip.Huahua_data_added = true
end

function huanhua:OnTooltipCleared(tooltip, ...)
  tooltip.Huahua_data_added = nil
end