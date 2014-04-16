-- SpellButton.lua

local addonName, private = ...
local LA = private.LA

function LA:CreateButton()
  local buttons = self.buttons
  local count = #buttons
  -- button global variable names start with "SpellButton" to work around an
  -- issue with the Blizzard Feedback Tool used in beta and on the PTR
  local name = "SpellButton_LearningAid_"..(count + 1)
  local button = CreateFrame("CheckButton", name, self.frame, "LearningAidSpellButtonTemplate")
  local background = _G[name.."Background"]
  background:Hide()
  local subSpellName = _G[name.."SubSpellName"]
  subSpellName:SetTextColor(NORMAL_FONT_COLOR.r - 0.1, NORMAL_FONT_COLOR.g - 0.1, NORMAL_FONT_COLOR.b - 0.1)
  buttons[count + 1] = button
  button.index = count + 1
  button:SetAttribute("type*", "spell")
  button:SetAttribute("type3", "hideButton")
  button:SetAttribute("alt-type*", "hideButton")
  button:SetAttribute("shift-type1", "linkSpell")
  button:SetAttribute("ctrl-type*", "toggleIgnore")
  button.hideButton = function(spellButton, mouseButton, down)
    if not self.inCombat then
      self:ClearButtonIndex(spellButton.index)
    end
  end
  button.linkSpell = function (...) self:SpellButton_OnModifiedClick(...) end
  button.toggleIgnore = function(spellButton, mouseButton, down)
    if spellButton.kind == BOOKTYPE_SPELL then
      self:ToggleIgnore(select(2, GetSpellBookItemInfo(spellButton:GetID(), BOOKTYPE_SPELL)))
      self:UpdateButton(spellButton)
    end
  end
  button.iconTexture = _G[name.."IconTexture"]
  button.cooldown = _G[name.."Cooldown"]
  button.spellName = _G[name.."SpellName"]
  button.subSpellName = _G[name.."SubSpellName"]
  return button
end
function LA:AddButton(kind, id)
  if kind == BOOKTYPE_SPELL then
    if id > self.numSpells or id < 1 then
      self:DebugPrint("AddButton(): Invalid spell ID", id)
      return
    end
  elseif kind == "MOUNT" or kind == "CRITTER" then
    if id < 1 or id > GetNumCompanions(kind) then
      self:DebugPrint("AddButton(): Invalid companion, type", kind, "ID", id)
      return
    end
  end
  local buttons = self.buttons
  local visible = self:GetVisible()
  for i = 1, visible do
    if buttons[i].kind == kind and buttons[i]:GetID() == id then
      return
    end
  end
  local button
  -- if bar is full
  if visible == #buttons then
    button = self:CreateButton()
    self:DebugPrint("Adding button id "..id.." index "..button.index)
  else
  -- if bar has free buttons
    button = buttons[self:GetVisible() + 1]
    self:DebugPrint("Changing button index "..(self:GetVisible() + 1).." from id "..button:GetID().." to "..id)
    button:Show()
  end

  button.kind = kind
  self:SetVisible(visible + 1)
  button:SetID(id)
  button:SetChecked(false)
  
  if kind == BOOKTYPE_SPELL then
    -- if id > 1 then
    --   local name, subName = GetSpellBookItemName(id, kind)
    --   local prevName, prevSubName = GetSpellBookItemName(id - 1, kind)
      -- CATA -- if name == prevName then
      --   self:DebugPrint("Found new rank of existing ability "..name.." "..prevRank)
      --   self:ClearButtonID(kind, id - 1)
      -- else
      --   self:DebugPrint(name.." ~= "..prevName)
      -- end
    -- end
    if IsSelectedSpellBookItem(id, kind) then
      button:SetChecked(true)
    end
  elseif kind == "MOUNT" or kind == "CRITTER" then
    -- button.Companion = name
    local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo(kind, id)
    if isSummoned then
      button:SetChecked(true)
    end
  else
    self:DebugPrint("AddButton(): Invalid button type "..kind)
  end
  self:UpdateButton(button)
  self:AutoSetMaxHeight()
  self.frame:Show()
end
function LA:ClearButtonID(kind, id)
  local buttons = self.buttons
  local i = 1
  -- not using a for loop because self.visible may change during the loop execution
  while i <= self:GetVisible() do
    if buttons[i].kind == kind and buttons[i]:GetID() == id then
      self:DebugPrint("Clearing button "..i.." with ID "..buttons[i]:GetID())
      self:ClearButtonIndex(i)
    else
      --self:DebugPrint("Button "..i.." has id "..buttons[i]:GetID().." which does not match "..id)
      i = i + 1
    end
  end
end
function LA:SetMaxHeight(newMaxHeight) -- in buttons, not pixels
  self.maxHeight = newMaxHeight
  self:ReshapeFrame()
end
function LA:GetMaxHeight()
  return self.maxHeight
end
function LA:AutoSetMaxHeight()
  local screenHeight = UIParent:GetHeight()
  self:DebugPrint("Screen Height = ".. screenHeight)
  local newMaxHeight = math.floor((UIParent:GetHeight()-self.titleHeight)/(self.buttonSize+self.verticalSpacing) - 3)
  self:DebugPrint("Setting MaxHeight to " .. newMaxHeight)
  self:SetMaxHeight(newMaxHeight)
  return newMaxHeight
end
function LA:ReshapeFrame()
  local newHeight
  local newWidth
  local maxHeight = self.maxHeight
  local visible = self:GetVisible()
  if visible > maxHeight then
    newHeight = maxHeight
    newWidth = math.ceil(visible / maxHeight)
  else
    newHeight = visible
    newWidth = 1
  end
  local frame = self.frame
  frame:SetHeight(self.titleHeight + self.framePadding + (self.buttonSize + self.verticalSpacing) * newHeight)
  frame:SetWidth(self.framePadding + (self.buttonSize + self.horizontalSpacing) * newWidth)
  self.height = newHeight
  self.width = newWidth
  self:ParentButtons()
end
function LA:ParentButtons()
  local buttons = self.buttons
  local visible = self:GetVisible()
  if visible >= 1 then
    buttons[1]:SetPoint("TOPLEFT", self.titleBar, "BOTTOMLEFT", 16, 0)
  end
  for i = 2, visible do
    if i <= self.height then
      buttons[i]:SetPoint("TOPLEFT", buttons[i-1], "BOTTOMLEFT", 0, -self.verticalSpacing)
    else
      buttons[i]:SetPoint("TOPLEFT", buttons[i-self.height], "TOPRIGHT", self.horizontalSpacing, 0)
    end
  end
end
function LA:ClearButtonIndex(index)
-- I have buttons 1 2 3 (4 5)
-- I remove button 2
-- I want 1 3 (3 4 5)
-- before, visible = 3
-- after, visible = 2
  local frame = self.frame
  local buttons = self.buttons
  local visible = self:GetVisible()
  for i = index, visible - 1 do
    local button = buttons[i]
    local nextButton = buttons[i + 1]
    button:SetID(nextButton:GetID())
    button:SetChecked(nextButton:GetChecked())
    button.kind = nextButton.kind
    button.iconTexture:SetVertexColor(nextButton.iconTexture:GetVertexColor())
    local cooldown = button.cooldown
    local nextCooldown = nextButton.cooldown
    cooldown.start = nextCooldown.start
    cooldown.duration = nextCooldown.duration
    cooldown.enable = nextCooldown.enable
    if cooldown.start and cooldown.duration and cooldown.enable then 
      CooldownFrame_SetTimer(cooldown, cooldown.start, cooldown.duration, cooldown.enable)
    else
      cooldown:Hide()
    end
    --if buttons[i]:IsShown() then
    self:UpdateButton(button)
    --end
  end
  buttons[visible]:Hide()
  self:SetVisible(visible - 1)
  self:ReshapeFrame()
end
function LA:SetVisible(visible)
  local frame = self.frame
  self.visible = visible
  local top, left = frame:GetTop(), frame:GetLeft()
  frame:SetHeight(self.titleHeight + 10 + (self.buttonSize + self.verticalSpacing) * visible)
  frame:ClearAllPoints()
  frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
  if visible == 0 then
    frame:Hide()
  end
end
function LA:GetVisible()
  return self.visible
end
function LA:Hide()
  local frame = self.frame
  if not self.inCombat then
    for i = 1, self:GetVisible() do
      self.buttons[i]:SetChecked(false)
      self.buttons[i]:Hide()
    end
    self:SetVisible(0)
  else
    table.insert(self.queue, { kind = "HIDE" })
  end
end

-- Adapted from SpellBookFrame.lua
function LA:UpdateButton(button)
  local id = button:GetID()

  local name = button:GetName()
  local iconTexture = _G[name.."IconTexture"]
  local spellString = _G[name.."SpellName"]
  local subSpellString = _G[name.."SubSpellName"]
  local cooldown = _G[name.."Cooldown"]
  local autoCastableTexture = _G[name.."AutoCastable"]
  local highlightTexture = _G[name.."Highlight"]
  -- CATA -- local normalTexture = _G[name.."NormalTexture"]
  if not self.inCombat then
    button:Enable()
  end

  if button.kind == BOOKTYPE_SPELL then

    local texture = GetSpellTexture(id, BOOKTYPE_SPELL);

    -- If no spell, hide everything and return
    if ( not texture or (strlen(texture) == 0) ) then
      iconTexture:Hide()
      spellString:Hide()
      subSpellString:Hide()
      cooldown:Hide()
      autoCastableTexture:Hide()
      SpellBook_ReleaseAutoCastShine(button.shine)
      button.shine = nil
      highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
      button:SetChecked(0)
      -- CATA -- normalTexture:SetVertexColor(1.0, 1.0, 1.0)
      return;
    end

    local start, duration, enable = GetSpellCooldown(id, BOOKTYPE_SPELL)
    CooldownFrame_SetTimer(cooldown, start, duration, enable)
    cooldown.start = start
    cooldown.duration = duration
    cooldown.enable = enable
    if ( enable == 1 ) then
      iconTexture:SetVertexColor(1.0, 1.0, 1.0)
    else
      iconTexture:SetVertexColor(0.4, 0.4, 0.4)
    end

    local spellName, subSpellName = GetSpellBookItemName(id, BOOKTYPE_SPELL)
    local globalID = select(2, GetSpellBookItemInfo(id, BOOKTYPE_SPELL))

    -- CATA -- normalTexture:SetVertexColor(1.0, 1.0, 1.0)
    highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
    spellString:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)

    -- Set Secure Action Button attribute
    if not self.inCombat then
      button:SetAttribute("spell*", spellName)
    end

    iconTexture:SetTexture(texture)
    spellString:SetText(spellName)
    subSpellString:SetText(subSpellName)
    if ( subSpellName ~= "" ) then
      spellString:SetPoint("LEFT", button, "RIGHT", 4, 4)
    else
      spellString:SetPoint("LEFT", button, "RIGHT", 4, 2)
    end
    if self:IsIgnored(globalID) then
      iconTexture:SetVertexColor(0.8, 0.1, 0.1) -- red color cribbed from Bartender4
    end
  elseif button.kind == "MOUNT" or button.kind == "CRITTER" then

    -- Some companions have two names, the display name and the spell name
    -- Make sure to use the spell name for casting
    local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo(button.kind, id)
    local spellName = GetSpellInfo(creatureSpellID)
    iconTexture:SetTexture(icon)
    spellString:SetText(creatureName)
    subSpellString:SetText("")
    if not self.inCombat then
      button:SetAttribute("spell*", spellName)
    end
  end
  iconTexture:Show()
  spellString:Show()
  subSpellString:Show()
  --SpellButton_UpdateSelection(self)
end
-- Adapted from SpellBookFrame.lua
function LA:SpellButton_OnDrag(button)
  local id = button:GetID()
  if button.kind == BOOKTYPE_SPELL then
    PickupSpellBookItem(id, button.kind)
  elseif button.kind == "MOUNT" or button.kind == "CRITTER" then
    PickupCompanion(button.kind, id)
  end
end
-- Adapted from SpellBookFrame.lua
function LA:SpellButton_OnEnter(button)
  --self:DebugPrint("Outer SpellButton_OnEnter")
  local id = button:GetID()
  local kind = button.kind
  GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
  if kind == BOOKTYPE_SPELL then
    if GameTooltip:SetSpellBookItem(id, BOOKTYPE_SPELL) then
      button.UpdateTooltip = function (...)
        --self:DebugPrint("Inner SpellButton_OnEnter")
        self:SpellButton_OnEnter(...)
      end
    else
      button.UpdateTooltip = nil
    end
    GameTooltip:AddLine("dummy")
    _G["GameTooltipTextLeft"..GameTooltip:NumLines()]:SetText(self:GetText("ctrlToIgnore"))
    GameTooltip:Show()
  elseif kind == "MOUNT" or kind == "CRITTER" then
    local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo(kind, id)
    if GameTooltip:SetHyperlink("spell:"..creatureSpellID) then
      button.UpdateTooltip = function (...) self:SpellButton_OnEnter(...) end
    else
      button.UpdateTooltip = nil
    end
  else
    self:DebugPrint("Invalid button type in LearningAid:SpellButton_OnEnter: "..button.kind)
  end
end
-- Adapted from SpellBookFrame.lua
function LA:SpellButton_UpdateSelection(button)
  if button.kind == BOOKTYPE_SPELL then
    local id = button:GetID()
    if IsSelectedSpellBookItem(id, BOOKTYPE_SPELL) then
      button:SetChecked("true")
    else
      button:SetChecked("false")
    end
  end
end
-- Adapted from SpellBookFrame.lua
function LA:SpellButton_OnModifiedClick(spellButton, mouseButton)
  local id = spellButton:GetID()
  local spellName, subSpellName
  if spellButton.kind == BOOKTYPE_SPELL then
    if ( id > MAX_SPELLS ) then
      return;
    end
    if ( IsModifiedClick("CHATLINK") ) then
      if ( MacroFrame and MacroFrame:IsShown() ) then
        spellName, subSpellName = GetSpellBookItemName(id, BOOKTYPE_SPELL)
          if ( spellName and not IsPassiveSpell(id, BOOKTYPE_SPELL) ) then
            if ( subSpellName and (strlen(subSpellName) > 0) ) then
              ChatEdit_InsertLink(spellName.."("..subSpellName..")")
            else
              ChatEdit_InsertLink(spellName)
            end
          end
        return;
      else
        local spellLink = GetSpellLink(id, BOOKTYPE_SPELL)
          if(spellLink) then
            ChatEdit_InsertLink(spellLink)
          end
        return;
      end
    end
    if ( IsModifiedClick("PICKUPACTION") ) then
      PickupSpell(id, BOOKTYPE_SPELL)
      return;
    end
  elseif spellButton.kind == "MOUNT" or spellButton.kind == "CRITTER" then
    local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo(spellButton.kind, id)
    if ( IsModifiedClick("CHATLINK") ) then
      if ( MacroFrame and MacroFrame:IsShown() ) then
        local spellName = GetSpellInfo(creatureSpellID)
        ChatEdit_InsertLink(spellName)
      else
        local spellLink = GetSpellLink(creatureSpellID)
        ChatEdit_InsertLink(spellLink)
      end
    elseif ( IsModifiedClick("PICKUPACTION") ) then
      self.SpellButton_OnDrag(spellButton)
    end
  end
end
function LA:SpellButton_OnHide(button)
  self:DebugPrint("Hiding button "..button.index)
  button:SetChecked(false)
  button.iconTexture:SetVertexColor(1, 1, 1)
  button.cooldown:Hide()
end
function LA:UpdateButtons()
  for i = 1, self:GetVisible() do
    self:UpdateButton(self.buttons[i])
  end
end