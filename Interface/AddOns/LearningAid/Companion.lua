-- Companion.lua

local addonName, private = ...
local LA = private.LA

function LA:UpdateCompanions()
  if not self.companionCache then self.companionCache = {} end
  local mount = self:UpdateCompanionType("MOUNT")
  local critter = self:UpdateCompanionType("CRITTER")
  if (mount > 0) or (critter > 0) and not self.companionsReady then
    self.companionsReady = true
  end
  return self.companionsReady
end
function LA:UpdateCompanionType(kind)
  if self.companionCache[kind] then
    wipe(self.companionCache[kind])
  else
    self.companionCache[kind] = {}
  end
  local cache = self.companionCache[kind]
  local count = GetNumCompanions(kind)
  for i = 1, count do
    local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo(kind, i)
    if creatureName then
      cache[creatureSpellID] = { name = creatureName, index = i, npc = creatureID, icon = icon }
    else
      self:DebugPrint("Bad companion, kind = "..kind..", index = "..i)
      count = -1
      break
    end
  end
  if count > 0 then
    self:DebugPrint("Updated companion type "..kind..", "..count.." companions found.")
  end
  return count
end
function LA:DiffCompanions()
  self:DiffCompanionType("MOUNT")
  self:DiffCompanionType("CRITTER")
end
function LA:AddCompanion(kind, id)
  if self.inCombat then
    table.insert(self.queue, { action = "LEARN", id = id, kind = kind})
  else
    self:LearnSpell(kind, id)
    self:AddButton(kind, id)
  end
end
function LA:DiffCompanionType(kind)
  local count = GetNumCompanions(kind)
  local cache = self.companionCache[kind]
  local updated = 0
  for i = 1, count do
    local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo(kind, i)
    if not cache[creatureSpellID] then
      self:DebugPrint("Found new companion, type "..kind..", index "..i)
      cache[creatureSpellID] = { name = creatureName, index = i, npc = creatureID, icon = icon }
      self:AddCompanion(kind, i)
      updated = updated + 1
    end
  end
  if updated > 0 then
    return updated
  else
    return false
  end
end
