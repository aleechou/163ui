-- Part of ReforgeLite by d07.RiV (Iroared)
-- All rights reserved

local L = ReforgeLiteLocale
local MOP = (GetNumTalentTabs == nil)

----------------------------------------------------------------

local wrItems = {
  ["Head"] = 1,
  ["Neck"] = 2,
  ["Shoulders"] = 3,
  ["Back"] = 4,
  ["Chest"] = 5,
  ["Wrists"] = 6,
  ["Hands"] = 7,
  ["Waist"] = 8,
  ["Legs"] = 9,
  ["Feet"] = 10,
  ["Ring1"] = 11,
  ["Ring2"] = 12,
  ["Trinket1"] = 13,
  ["Trinket2"] = 14,
  ["MainHand"] = 15,
  ["OffHand"] = 16,
}
local wrStats = {
  ["Spirit"] = 1,
  ["DodgeRating"] = 2,
  ["ParryRating"] = 3,
  ["HitRating"] = 4,
  ["CritRating"] = 5,
  ["HasteRating"] = 6,
  ["ExpertiseRating"] = 7,
  ["MasteryRating"] = 8,
}

ReforgeLite.ParseWowReforge = function(text)
  local method = {items = {}}
  for itemRaw, srcRaw, dstRaw in string.gmatch(text, "([%a%d]+) : ([%a%d]+) %-> ([%a%d]+)") do
    if itemRaw and srcRaw and dstRaw and wrItems[itemRaw] and wrStats[srcRaw] and wrStats[dstRaw] then
      method.items[wrItems[itemRaw]] = {
        src = wrStats[srcRaw],
        dst = wrStats[dstRaw],
      }
    end
  end
  return method
end

----------------------------------------------------------------

local InputFrame = CreateFrame ("Frame", "ReforgeLiteInputFrame", UIParent)
InputFrame:Hide()
InputFrame:SetPoint("CENTER")
InputFrame:SetFrameStrata("TOOLTIP")
InputFrame:SetWidth(320)
InputFrame:SetHeight(400)
InputFrame:SetBackdrop({
  bgFile = "Interface\\Tooltips\\ChatBubble-Background",
  edgeFile = "Interface\\Tooltips\\ChatBubble-BackDrop",
  tile = true, tileSize = 32, edgeSize = 32,
  insets = {left = 32, right = 32, top = 32, bottom = 32}
})
InputFrame:SetBackdropColor(0, 0, 0, 1)
InputFrame:SetMovable(true)
InputFrame:SetClampedToScreen(true)
InputFrame:EnableMouse(true)
InputFrame:SetScript("OnMouseDown", function () InputFrame:StartMoving () end)
InputFrame:SetScript("OnMouseUp", function () InputFrame:StopMovingOrSizing () end)

InputFrame.ok = CreateFrame("Button", "ReforgeLiteInputFrameOk", InputFrame, "UIPanelButtonTemplate")
InputFrame.ok:SetSize(112, 22)
InputFrame.ok:SetText(ACCEPT)
InputFrame.ok:SetPoint("BOTTOMLEFT", 15, 10)
InputFrame.ok:SetScript("OnClick", function ()
  if InputFrame.func then
    InputFrame.func(InputFrame.text:GetText())
  end
  InputFrame:Hide ()
end)
InputFrame.cancel = CreateFrame("Button", "ReforgeLiteInputFrameOk", InputFrame, "UIPanelButtonTemplate")
InputFrame.cancel:SetSize(112, 22)
InputFrame.cancel:SetText(CANCEL)
InputFrame.cancel:SetPoint("BOTTOMRIGHT", -15, 10)
InputFrame.cancel:SetScript("OnClick", function ()
  InputFrame:Hide ()
end)
InputFrame.scroll = CreateFrame ("ScrollFrame", "ReforgeLiteInputFrameScroll", InputFrame, "UIPanelScrollFrameTemplate")
InputFrame.scroll:SetPoint ("TOPLEFT", 15, -15)
InputFrame.scroll:SetPoint ("TOPRIGHT", -31, -15)
InputFrame.scroll:SetPoint ("BOTTOM", InputFrame.ok, "TOP", 0, 10)
InputFrame.text = CreateFrame ("EditBox", "ReforgeLiteInputFrameText", InputFrame.scroll)
InputFrame.scroll:SetScrollChild (InputFrame.text)
InputFrame.text:SetWidth (274)
InputFrame.text:SetHeight (100)
InputFrame.text:SetMultiLine (true)
InputFrame.text:SetAutoFocus (true)
InputFrame.text:SetFontObject (GameFontHighlight)
InputFrame.text:SetScript ("OnEscapePressed", function () InputFrame:Hide () end)
--InputFrame.text
InputFrame.updateText = function ()
  InputFrame.scroll:UpdateScrollChildRect ()
end
InputFrame.text:SetScript ("OnTextChanged", InputFrame.updateText)
function InputFrame:Run(func)
  InputFrame.text:SetText("")
  InputFrame.func = func
  InputFrame.updateText()
  InputFrame:Show()
end

function ReforgeLite:RunImport(func)
  InputFrame:Run(function(text)
    local method = func(text)
    if method and self:IsMethodValid(method) then
      self:UpdateMethodStats(method)
      self.pdb.method = method
      self:UpdateMethodCategory()
    end
  end)
end
