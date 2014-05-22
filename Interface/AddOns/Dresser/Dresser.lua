local addonName, buttons = ...

local function InspectReady(button, event, guid)
  if button.guid == guid then
    local item
    for i = 0, 19 do
      if (not button.skip) or (button.skip and (not (i == 1 or i == 15 or i == 19))) then
        item = GetInventoryItemLink("target", i)
        if item then
          button.model:TryOn(item)
        end
      end
    end
    for i = 16, 17 do
      item = GetInventoryItemLink("target", i)
      if item then
        button.model:TryOn(item)
      end
    end
    button:UnregisterEvent(event)
  end
end

local function TargetExists(button, isPlayer)
  local unit
  if isPlayer then
    unit = UnitIsPlayer("target")
  else
    unit = UnitExists("target")
  end
  local enabled = button:IsEnabled()
  if unit and not enabled then
    button:Enable()
  elseif not unit and enabled then
    button:Disable()
  end
end

local function GetFreeSlot(parent, reset)
  for i = #buttons[parent], 1, -1 do
    return buttons[parent][i]
  end
  return reset
end

local function AddButton(parent, model, reset, meta)
  if not buttons[parent] then
    buttons[parent] = {}
  end
  local button = CreateFrame("Button", addonName.."Button"..(#buttons[parent] + 1), parent, "UIPanelButtonTemplate")
  button.parent = parent
  button.model = model
  button.reset = reset
  if meta.auctionhouse then
    button:SetPoint("TOP", GetFreeSlot(parent, reset), "BOTTOM", 0, 0)
  else
    button:SetPoint("RIGHT", GetFreeSlot(parent, reset), "LEFT", 0, 0)
  end
  button:SetFrameLevel(reset:GetFrameLevel())
  button:SetSize(unpack(meta.size or {42, 22}))
  button:SetText(meta.title)
  button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  button:SetScript("OnClick", type(meta.onclick) == "function" and meta.onclick or nil)
  button:SetScript("OnUpdate", type(meta.onupdate) == "function" and meta.onupdate or nil)
  if meta.tooltip then
    button.tooltipText = meta.tooltip
    button.newbieText = meta.newbietip
  end
  table.insert(buttons[parent], button)
end

local function AddTooltip(button, tooltip, newbietip)
  button.tooltipText = tooltip
  button.newbieText = newbietip
  button:HookScript("OnEnter", function(button)
    if button.tooltipText ~= nil then
      GameTooltip_AddNewbieTip(button, button.tooltipText, 1, 1, 1, button.newbieText)
    end
  end)
  button:HookScript("OnLeave", function(button)
    if button.tooltipText ~= nil then
      GameTooltip:Hide()
    end
  end)
end

local function Dresser(parent, model, reset, buttons, noResetTooltip)
  for i, button in ipairs(buttons) do
    AddButton(parent, model, reset, button)
  end
  if not noResetTooltip then
    AddTooltip(reset, "重置试穿")
  end
end

Dresser(DressUpFrame, DressUpModel, DressUpFrameResetButton, {
  {
    title = "我",
    tooltip = "用自己做模特",
    onclick = function(button)
      button.model:SetUnit("player")
      PlaySound("gsTitleOptionOK")
    end,
  },
  {
    title = "目模",
    tooltip = "用目标做模特",
    onupdate = function(button)
      TargetExists(button, false)
    end,
    onclick = function(button)
      if UnitIsPlayer("target") then
        button.model:SetUnit("target")
      elseif UnitExists("target") then
        local guid = UnitGUID("target")
        if (guid or ""):len() > 7 then
          button.model:SetCreature(tonumber(guid:sub(7, 10), 16))
        else
          button.model:SetUnit("target")
        end
      end
      PlaySound("gsTitleOptionOK")
    end,
  },
  {
    title = "目装",
    tooltip = "试穿目标装备",
    newbietip = "Target gear\n> Left-click to equip all items worn\n> Right-click to skip head, shirt and tabard",
    onupdate = function(button)
      TargetExists(button, true)
    end,
    onclick = function(button, mouse)
      button.model:Undress()
      button.skip = mouse == "RightButton"
      button.guid = UnitGUID("target")
      button:SetScript("OnEvent", InspectReady)
      button:RegisterEvent("INSPECT_READY")
      NotifyInspect("target")
      PlaySound("gsTitleOptionOK")
    end,
  },
  {
    title = "脱",
    tooltip = "脱光模特装备",
    onclick = function(button)
      button.model:Undress()
      PlaySound("gsTitleOptionOK")
    end,
  },
})

Dresser(SideDressUpFrame, SideDressUpModel, SideDressUpModelResetButton, {
  {
    auctionhouse = 1,
    size = {80, 22},
    title = "Undress",
    onclick = function(button)
      button.model:Undress()
      PlaySound("gsTitleOptionOK")
    end,
  },
}, 1)
