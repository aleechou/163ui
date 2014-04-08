-- ActionBar.lua

local addonName, private = ...
local LA = private.LA

LA.castSlashCommands = {
  [SLASH_USE1] = true,
  [SLASH_USE2] = true,
  [SLASH_USERANDOM1] = true,
  [SLASH_USERANDOM2] = true,
  [SLASH_CAST1] = true,
  [SLASH_CAST2] = true,
  [SLASH_CAST3] = true,
  [SLASH_CAST4] = true,
  [SLASH_CASTRANDOM1] = true,
  [SLASH_CASTRANDOM2] = true,
  [SLASH_CASTSEQUENCE1] = true,
  [SLASH_CASTSEQUENCE2] = true
}
function LA:MacroSpells(macroText)
  macroText = string.lower(macroText)
  local spells = {}
  local first, last, line
  first, last, line = macroText:find("([^\n]+)[\n]?")
  while first ~= nil do
    self:DebugPrint("Line",line)
    local lineFirst, lineLast, slash = line:find("^(/%S+)%s+")
    if lineFirst ~= nil then
      self:DebugPrint('Slash "'..slash..'"')
      if self.castSlashCommands[slash] then
        --self:DebugPrint("found slash command")
        local token
        local linePos = lineLast
        local found = true
        while found do
          while found do
            found = false
            -- ignore reset=
            lineFirst, lineLast = line:find("^reset=%S+%s*", linePos + 1)
            if lineLast ~= nil then linePos = lineLast; found = true end
            -- ignore macro options
            lineFirst, lineLast = line:find("^%[[^%]]*]", linePos + 1)
            if lineLast ~= nil then linePos = lineLast; found = true end
            -- ignore whitespace and punctuation
            lineFirst, lineLast = line:find("^[%s,;]+", linePos + 1)
            if lineLast ~= nil then linePos = lineLast; found = true end
            -- ignore ranks
            -- CATA -- lineFirst, lineLast = line:find("^%([^%)]+%)", linePos + 1)
            -- CATA -- if lineLast ~= nil then linePos = lineLast; found = true end
          end
          found = false
          lineFirst, lineLast, token = line:find("^([^%[,;]+)", linePos + 1)
          if lineLast ~= nil then
            token = strtrim(token)
            linePos = lineLast
            found = true
            self:DebugPrint('Token: "'..token..'"')
            spells[token] = true
            local status, globalID = GetSpellBookItemInfo(token)
            if globalID then 
              spells[globalID] = true
            end
          end
        end
      end
    end
    first, last, line = macroText:find("([^\n]+)\n?", last + 1)
  end
  return spells
end
function LA:DiffActionBars()
  local spec = GetActiveSpecGroup()
  for slot = 1, 120 do
    local actionType = GetActionInfo(slot)
    -- local actionType, actionID, actionSubType, globalID = GetActionInfo(slot)
    if self.character.actions and 
       self.character.actions[spec] and
       self.character.actions[spec][slot] and
       not actionType
    then
      if not self.character.unlearned then self.character.unlearned = {} end
      if not self.character.unlearned[spec] then self.character.unlearned[spec] = {} end
      if not self.character.unlearned[spec][slot] then self.character.unlearned[spec][slot] = {} end
      self.character.unlearned[spec][slot][self.character.actions[spec][slot]] = true
    end
  end
end
function LA:SaveActionBars()
  local spec = GetActiveSpecGroup()
  if self.character.actions == nil then self.character.actions = {} end
  if self.character.actions[spec] then
    wipe(self.character.actions[spec])
  else
    self.character.actions[spec] = {}
  end
  local savedActions = self.character.actions[spec]
  for actionSlot = 1, 120 do
    local actionType, actionID, actionSubType, globalID = GetActionInfo(actionSlot)
    if actionType == "spell" then
      savedActions[actionSlot] = globalID
    end
  end
end
function LA:FindMissingActions()
  if self.inCombat then
    print(self:GetText("title")..": "..self:GetText("errorInCombat"))
    return
  end
  local actions = {}
  local types = {}
  local subTypes = {}
  local tracking = {}
  local shapeshift = {}
  local totem = {}
  local results = {}
  local macroSpells = {}
  local flyouts = {}
  local numTrackingTypes = GetNumTrackingTypes()
  local bookCache = self.spellBookCache
  local infoCache = self.spellInfoCache

  --[[
  if not self.saved.tracking then
    for trackingType = 1, numTrackingTypes do
      local name, texture, active, category = GetTrackingInfo(trackingType)
      if category == BOOKTYPE_SPELL then
        tracking[name] = true
      end
    end
  end
  ]]
  if (not self.saved.totem) and self.enClass == "SHAMAN" then
    self:DebugPrint("Searching for totems")
    for totemType = 1, MAX_TOTEMS do
      local totemSpells = {GetMultiCastTotemSpells(totemType)}
      for index, globalID in ipairs(totemSpells) do
        -- name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spell)
        --local totemName = GetSpellInfo(globalID)
        totem[globalID] = true
        --self:DebugPrint("Found totem "..totemName)
      end
    end
  end
  for slot = 1, 120 do
    local actionType, actionID, actionSubType = GetActionInfo(slot)
    if actionSubType == nil then
      actionSubType = ""
    end
    if actionType == nil then
      actionType = ""
    end
    -- development info
    if not types[actionType] then
      self:DebugPrint("Type "..actionType)
      types[actionType] = true
    end
    if not subTypes[actionSubType] then
      self:DebugPrint("Subtype "..actionSubType)
      subTypes[actionSubType] = true
    end
    if actionType == "spell" then
      actions[actionID] = true
    elseif actionType == "flyout" then
      -- flyoutID = actionID
      local name, description, size, flyoutKnown = GetFlyoutInfo(actionID)
      if flyoutKnown then
        flyouts[actionID] = true
        for flyoutSlot = 1, size do
          local globalID, known = GetFlyoutSlotInfo(actionID, flyoutSlot)
          if known then
            -- local spellBookID = FindSpellBookSlotBySpellID(globalID)
            actions[globalID] = true
          end
        end
      end
    elseif actionType == "macro" and actionID ~= 0 and self.saved.macros then
      self:DebugPrint("Macro in slot "..slot.." with ID "..actionID)
      local body = GetMacroBody(actionID)
      local spells = self:MacroSpells(body)
      for spell in pairs(spells) do
        macroSpells[spell] = true
      end
    end
  end
  -- Macaroon support code
  if self.saved.macros and Macaroon and Macaroon.Buttons then
    for index, button in ipairs(Macaroon.Buttons) do
      local buttonType = button[1].config.type
      local macroText = button[1].config.macro
      local storage = button[2]
      if (buttonType == "macro") and (storage == 0) then
        self:DebugPrint("Macaroon macro in slot", index)
        local spells = self:MacroSpells(macroText)
        for spell in pairs(spells) do
          macroSpells[spell] = true
        end
      end
    end
  end
  -- End Macaroon code
  if not self.saved.shapeshift then
    local numForms = GetNumShapeshiftForms()
    for form = 1, numForms do
      local formTexture, formName, formIsCastable, formIsActive = GetShapeshiftFormInfo(form)
      local status, globalID = GetSpellBookItemInfo(formName)
      assert(globalID)
      shapeshift[globalID] = true
    end
  end
  for globalID, spell in pairs(bookCache) do
    local spellName = spell.info.name
    spellNameLower = string.lower(spellName)
    if spell.known and
      (not self:IsIgnored(globalID)) and
      (not actions[globalID]) and -- spell is not on any action bar
      (not spell.info.passive) and -- spell is not passive
      -- spell is not a tracking spell, or displaying tracking spells has been enabled
      --(not tracking[spellName]) and
      (not shapeshift[globalID]) and
      (not totem[globalID]) and
      (not macroSpells[spellNameLower]) and
      (not macroSpells[globalID])
    then
      -- CATA -- self:DebugPrint("Spell "..info.name.." Rank "..info.rank.." is not on any action bar.")
      self:DebugPrint("Spell "..spellName.." is not on any action bar.")
      --if macroSpells[spellNameLower] then self:DebugPrint("Found spell in macro") end
      table.insert(results, spell)
    elseif spell.status == "FLYOUT" and not flyouts[globalID] then
      -- ?
    end
  end
  table.sort(results, function (a, b) return a.bookID < b.bookID end)
  for result = 1, #results do
    self:AddButton(BOOKTYPE_SPELL, results[result].bookID)
  end
end

function LA:RestoreAction(globalID)
  -- self.character.actions[spec][slot] = globalID
  local spec = GetActiveSpecGroup()
  if self.character.actions and self.character.actions[spec] then -- and self.character.actions[spec][globalID]
    for actionSlot, id in pairs(self.character.actions[spec]) do
      if id == globalID then
        self:DebugPrint("RestoreAction("..globalID.."): Found action at action slot "..actionSlot)
        --local actionType, actionID, actionSubType, slotGlobalID = GetActionInfo(actionSlot)
        local actionType = GetActionInfo(actionSlot)
        if actionType == nil then
          local bookID
          if self.spellBookCache[globalID] then
            bookID = self.spellBookCache[globalID].bookID
            self:DebugPrint("RestoreAction("..globalID.."): Found action at Spellbook ID "..bookID)
            PickupSpell(bookID, BOOKTYPE_SPELL)
            PlaceAction(actionSlot)
          end
        end
      end
    end
  end
end
local actionBarAliases = {
  default = 1,
  lowerleft = 1,
  alternate = 2,
  farright = RIGHT_ACTIONBAR_PAGE, -- 3
  nearright = LEFT_ACTIONBAR_PAGE, -- 4
  bottomright = BOTTOMRIGHT_ACTIONBAR_PAGE, -- 5
  left = BOTTOMLEFT_ACTIONBAR_PAGE, -- 6
  bottomleft = BOTTOMLEFT_ACTIONBAR_PAGE,
  cat = 7,
  stealth = 7,
  battle = 7,
  shadowform = 7,
  shadow = 7,
  defensive = 8,
  bear = 9,
  berserker = 9,
  moonkin = 10
}
function LA:CopyActionBar(barID)
  if not self.barClipboard then
    self.barClipboard = {}
  else
    wipe(self.barClipboard)
  end
  if type(barID) == "number" then
    barID = math.floor(barID)
    assert(barID >= 1 and barID <= 10)
  elseif type(barID) == "string" and actionBarAliases[barID] then
    barID = actionBarAliases[barID]
  end
  local barOffset = (barID - 1) * NUM_ACTIONBAR_BUTTONS
  for i = 1, NUM_ACTIONBAR_BUTTONS do
    local id = i + barOffset
    if HasAction(id) then
      local slot = {}
      slot.type, slot.globalID, slot.subType = GetActionInfo(id)
      self.barClipboard[i] = slot
    end
  end
end
function LA:PasteActionBar(barID)
  if self.barClipboard then
    if type(barID) == "string" then
      barID = actionBarAliases[barID]
    end
    local barOffset = (barID - 1) * NUM_ACTIONBAR_BUTTONS
    for i = 1, NUM_ACTIONBAR_BUTTONS do
      local slot = self.barClipboard[i]
      if slot then
        if slot.type == "spell" then
          PickupSpell(slot.globalID)
        elseif slot.type == "companion" then
          PickupCompanion(slot.subType, self.companionCache[slot.subType][slot.globalID].index)
        elseif slot.type == "macro" then
          PickupMacro(slot.globalID)
        elseif slot.type == "equipmentset" then
          PickupEquipmentSetByName(slot.globalID)
        elseif slot.type == "item" then
          PickupItem(slot.globalID)
        end
        PlaceAction(i + barOffset)
      else
        PickupAction(i + barOffset)
      end
      ClearCursor()
    end
  end
end
