-- Events.lua

local addonName, private = ...
local LA = private.LA

function LA:ADDON_LOADED(addon)
  if addon == addonName then
    self:Init()
  elseif addon == "Blizzard_TrainerUI" then
    self:CreateTrainAllButton()
    --self:UnregisterEvent("ADDON_LOADED")
  end
end
function LA:ACTIONBAR_SLOT_CHANGED(slot)
-- actionbar1 = ["spell" 2354] ["macro" 5] [nil]
-- then after untalenting actionbar1 = [nil] ["macro" 5] [nil]
-- self.character.actions[spec][1][2354] = true
  
  if self.untalenting then
    -- something something on (slot)
    local spec = GetActiveSpecGroup()
    local actionType, actionID, actionSubType, globalID = GetActionInfo(slot)
    local oldID = self.character.actions[spec][slot]
    self:DebugPrint("Action Slot "..slot.." changed:",
      (actionType or "")..",",
      (actionID or "")..",",
      (actionSubType or "")..",",
      (globalID or "")..",",
      (oldID or "")
    )
    if oldID and (actionType ~= BOOKTYPE_SPELL or globalID ~= oldID) then
      if not self.character.unlearned then self.character.unlearned = {} end
      if not self.character.unlearned[spec] then self.character.unlearned[spec] = {} end
      if not self.character.unlearned[spec][slot] then self.character.unlearned[spec][slot] = {} end
      self.character.unlearned[spec][slot][oldID] = true
    end
  end
end

function LA:CHAT_MSG_SYSTEM(message)
  -- note: pet spells, when learned, do not come as links
  -- player spells do come as links
  --local rank
  local spell
  local t
  local str = string.match(message, self.patterns.learnSpell) or string.match(message, self.patterns.learnAbility)
  if str then
    t = self.spellsLearned
  else
    str = string.match(message, self.patterns.unlearnSpell) 
    if str then
      t = self.spellsUnlearned
    end
  end
  if t then
    local name, globalID = self:UnlinkSpell(str)
    self:DebugPrint("Matched "..name, globalID)
    t[globalID] = true
    self:SpellInfo(globalID, name, str)
    --t.link[globalID] = str
  else
    str = string.match(message, self.patterns.petLearnAbility) or string.match(message, self.patterns.petLearnSpell)
    if str then
      t = self.petLearned
    else
      str = string.match(message, self.patterns.petUnlearnSpell)
      if str then
        t = self.petUnlearned
      end
    end
    if t then
      --spell, rank = unRankSpell(str)
      self:DebugPrint("Matched "..str)
      table.insert(t, str)
    end
  end
end
function LA:COMPANION_LEARNED()
  self.companionsReady = true
  self:DiffCompanions()
end
function LA:COMPANION_UPDATE()
  if self.companionsReady then
    local frame = self.frame
    local buttons = self.buttons
    for i = 1, self:GetVisible() do
      local button = buttons[i]
      local kind = button.kind
      if kind == "MOUNT" or kind == "CRITTER" then
        local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo(kind, button:GetID())
        if isSummoned then
          button:SetChecked(true)
        else
          button:SetChecked(false)
        end
      end
    end
--  else
--    self:UpdateCompanions()
  end
end
function LA:CURRENT_SPELL_CAST_CHANGED()
  local frame = self.frame
  local buttons = self.buttons
  for i = 1, self:GetVisible() do
    local button = buttons[i]
    if button.kind == BOOKTYPE_SPELL then
      self:SpellButton_UpdateSelection(button)
    end
  end
end
function LA:PET_TALENT_UPDATE()
  self:PrintPending()
--  self.petLearning = false
end
function LA:PLAYER_ENTERING_WORLD()
  self:RegisterEvent("SPELLS_CHANGED")
end
function LA:PLAYER_GUILD_UPDATE()
  self:UpdateGuild()
end
-- when transitioning continents, instances, etc the spellbook may be in flux
-- between PLAYER_LEAVING_WORLD and PLAYER_ENTERING_WORLD
function LA:PLAYER_LEAVING_WORLD() 
  self:UnregisterEvent("SPELLS_CHANGED")
  self:RegisterEvent("PLAYER_ENTERING_WORLD")
end
function LA:PLAYER_LEVEL_UP()
  self:PrintPending()
end
function LA:PLAYER_LOGIN()
  self:UpdateSpellBook()
  self:RegisterEvent("SPELLS_CHANGED")
end
function LA:PLAYER_LOGOUT()
  self:SaveActionBars()
end
function LA:PLAYER_REGEN_DISABLED()
  self.inCombat = true
  self.closeButton:Disable()
end
function LA:PLAYER_REGEN_ENABLED()
  self.inCombat = false
  self.closeButton:Enable()
  self:ProcessQueue()
end
function LA:PLAYER_TALENT_UPDATE()
  if self.untalenting then
    self.untalenting = false
    self:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
    self:UnregisterEvent("PLAYER_TALENT_UPDATE")
    self:UnregisterEvent("UI_ERROR_MESSAGE")
    self:PrintPending()
  elseif self.pendingTalentCount > 0 then
    self.pendingTalentCount = self.pendingTalentCount - 1
    if self.pendingTalentCount <= 0 then
      self:PrintPending()
      self:UnregisterEvent("PLAYER_TALENT_UPDATE")
    end
  elseif self.learning then
    self.learning = false
    self:UnregisterEvent("PLAYER_TALENT_UPDATE")
    self:PrintPending()
  end
end
function LA:SPELLS_CHANGED()
  self:UpgradeIgnoreList()
  if not self.companionsReady then
    self:UpdateCompanions()
  end
  if self.numSpells > 0 then
    if self:DiffSpellBook() > 0 then
      if self.pendingBuyCount > 0 then
        self.pendingBuyCount = self.pendingBuyCount - 1
        if self.pendingBuyCount <= 0 then
          self:PrintPending()
        end
      end
    end
  end
end
function LA:SPELL_UPDATE_COOLDOWN()
  local frame = self.frame
  local buttons = self.buttons
  for i = 1, self:GetVisible() do
    local button = buttons[i]
    if button.kind == BOOKTYPE_SPELL then
      self:UpdateButton(button)
    elseif button.kind == "MOUNT" or button.kind == "CRITTER" then
      local start, duration, enable = GetSpellCooldown(button.kind, button:GetID())
      CooldownFrame_SetTimer(button.cooldown, start, duration, enable);
    end
  end
end
function LA:TRADE_SKILL_SHOW()
  local frame = self.frame
  local buttons = self.buttons
  for i = 1, self:GetVisible() do
    local button = buttons[i]
    if button.kind == BOOKTYPE_SPELL then
      if IsSelectedSpellBookItem(button:GetID(), button.kind) then
        button:SetChecked(true)
      else
        button:SetChecked(false)
      end
    end
  end
end
LA.TRADE_SKILL_CLOSE = LA.TRADE_SKILL_SHOW

function LA:UNIT_SPELLCAST_START(unit, spellName, deprecated, counter, globalID)
  if unit == "player" and
    (globalID == self.activatePrimarySpec or globalID == self.activateSecondarySpec) and
    not self.retalenting
  then
    self:DebugPrint("Talent swap initiated")
    self.retalenting = counter
    --self:RegisterEvent("PLAYER_TALENT_UPDATE", "OnEvent")
    self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "OnEvent")
    self:RegisterEvent("UNIT_SPELLCAST_STOP", "OnEvent")
    self:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET", "OnEvent")
  end
end
function LA:UNIT_SPELLCAST_INTERRUPTED(unit, spellName, deprecated, counter, globalID)
  if unit == "player" and
    (globalID == self.activatePrimarySpec or globalID == self.activateSecondarySpec) and
    counter == self.retalenting
  then
    self:DebugPrint("Talent swap canceled")
    self.retalenting = false
    self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    self:UnregisterEvent("UNIT_SPELLCAST_STOP")
    self:UnregisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
  end
end
LA.UNIT_SPELLCAST_FAILED_QUIET = LA.UNIT_SPELLCAST_INTERRUPTED

function LA:UNIT_SPELLCAST_STOP(unit, spellName, deprecated, counter, globalID)
  if unit == "player" and
    (globalID == self.activatePrimarySpec or globalID == self.activateSecondarySpec) and
    counter == self.retalenting
  then
    self:DebugPrint("Talent swap completed")
    self.retalenting = false
    self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    self:UnregisterEvent("UNIT_SPELLCAST_STOP")
    self:UnregisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
    --[[
    if self.saved.filterSpam == LA.FILTER_SUMMARIZE then
      local spamCache = self.spellSpamCache
      -- don't print spells that are unlearned then immediately relearned
      for id, name in pairs(unlearned.name) do
        if learned.name[id] then
          learned.name[id] = nil
          learned.link[id] = nil
          unlearned.name[id] = nil
          unlearned.link[id] = nil
        end
      end
    end
    ]]
    self:PrintPending()
  end
end
function LA:UI_ERROR_MESSAGE()
  if self.untalenting then
    self:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
    self:UnregisterEvent("UI_ERROR_MESSAGE")
    self:UnregisterEvent("PLAYER_TALENT_UPDATE")
    self.untalenting = false
  end
end
function LA:UPDATE_BINDINGS()
  self:UpdateCompanions()
  self:UnregisterEvent("UPDATE_BINDINGS")
end
function LA:VARIABLES_LOADED()
  if self.saved.x and self.saved.y then
    self.frame:ClearAllPoints()
    self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.saved.x, self.saved.y)
  end
end
