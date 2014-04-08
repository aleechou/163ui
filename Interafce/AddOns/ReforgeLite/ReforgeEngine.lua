-- Part of ReforgeLite by d07.RiV (Iroared)
-- All rights reserved

local REFORGE_COEFF = 0.4

local _, playerClass = UnitClass ("player")
local _, playerRace = UnitRace ("player")
playerRace = string.upper(playerRace)
local missChance = (playerRace == "NIGHTELF" and 7 or 5)
local foodFactor = (playerRace == "PANDAREN" and 2 or 1)

local function DeepCopy (t, cache)
  if type (t) ~= "table" then
    return t
  end
  local copy = {}
  for i, v in pairs (t) do
    if type (v) ~= "table" then
      copy[i] = v
    else
      cache = cache or {}
      cache[t] = copy
      if cache[v] then
        copy[i] = cache[v]
      else
        copy[i] = DeepCopy (v, cache)
      end
    end
  end
  return copy
end

local L = ReforgeLiteLocale

---------------------------------------------------------------------------------------

function ReforgeLite:GetConversion()
  local _, class = UnitClass ("player")
  local level = UnitLevel("player")
  local spec = GetSpecialization() or 0
  local result = {}
  if class == "PRIEST" then
    result[self.STATS.EXP] = {[self.STATS.HIT] = 1}
    if spec == 3 and level >= 20 then
      result[self.STATS.SPIRIT] = {[self.STATS.HIT] = 1}
    end
  elseif class == "MAGE" then
   result[self.STATS.EXP] = {[self.STATS.HIT] = 1}
  elseif class == "WARLOCK" then
    result[self.STATS.EXP] = {[self.STATS.HIT] = 1}
  elseif class == "DRUID" then
    if spec == 1 then
      if level >= 64 then
        result[self.STATS.SPIRIT] = {[self.STATS.HIT] = 1}
      end
      result[self.STATS.EXP] = {[self.STATS.HIT] = 1}
    elseif spec == 4 then
      result[self.STATS.EXP] = {[self.STATS.HIT] = 1}
    end
  elseif class == "SHAMAN" then
    if spec == 1 then
      result[self.STATS.SPIRIT] = {[self.STATS.HIT] = 1}
      result[self.STATS.EXP] = {[self.STATS.HIT] = 1}
    elseif spec == 3 then
      result[self.STATS.EXP] = {[self.STATS.HIT] = 1}
    end
  elseif class == "MONK" then
    if spec == 2 then
      result[self.STATS.SPIRIT] = {[self.STATS.HIT] = 0.5, [self.STATS.EXP] = 0.5}
    end
  elseif class == "PALADIN" then
    if spec == 1 then
      result[self.STATS.EXP] = {[self.STATS.HIT] = 1}
    end
  end
  return result
end
local AmplificationItems = {
  [104976] = 528, -- Prismatic Prison of Pride, Raid Finder
  [104727] = 540, -- Prismatic Prison of Pride, Flexible
  [102299] = 553, -- Prismatic Prison of Pride
  [105225] = 559, -- Prismatic Prison of Pride, Warforged
  [104478] = 566, -- Prismatic Prison of Pride, Heroic
  [105474] = 572, -- Prismatic Prison of Pride, Heroic Warforged

  [104924] = 528, -- Purified Bindings of Immerseus, Raid Finder
  [104675] = 540, -- Purified Bindings of Immerseus, Flexible
  [102293] = 553, -- Purified Bindings of Immerseus
  [105173] = 559, -- Purified Bindings of Immerseus, Warforged
  [104426] = 566, -- Purified Bindings of Immerseus, Heroic
  [105422] = 572, -- Purified Bindings of Immerseus, Heroic Warforged

  [105111] = 528, -- Thok's Tail Tip, Raid Finder
  [104862] = 540, -- Thok's Tail Tip, Flexible
  [102305] = 553, -- Thok's Tail Tip
  [105360] = 559, -- Thok's Tail Tip, Warforged
  [104613] = 566, -- Thok's Tail Tip, Heroic
  [105609] = 572, -- Thok's Tail Tip, Heroic Warforged
}
function ReforgeLite:GetStatMultipliers()
  local result = {}
  if playerRace == "Human" then
    result[self.STATS.SPIRIT] = (result[self.STATS.SPIRIT] or 1) * 1.03
  end
  for i, v in ipairs (self.itemData) do
    local item = GetInventoryItemLink("player", v.slotId)
    if item then
      local id, iLvl = GetItemInfoUp(item)
      if id and AmplificationItems[id] then
        local factor = 1 + 0.01 * math.floor(GetRandPropPoints(iLvl, 2) / 420 + 0.5)
        result[self.STATS.HASTE] = (result[self.STATS.HASTE] or 1) * factor
        result[self.STATS.MASTERY] = (result[self.STATS.MASTERY] or 1) * factor
        result[self.STATS.SPIRIT] = (result[self.STATS.SPIRIT] or 1) * factor
      end
    end
  end
  return result
end

function ReforgeLite:GetMethodScore (method)
  local score = 0
  for i = 1, #self.itemStats do
    score = score + self:GetStatScore (i, method.stats[i])
  end
  return score
end
function ReforgeLite:GetMethodPenalty(method)
  for i = 1, #method.items do
    if self:IsItemLocked(i) then
      local link = GetInventoryItemLink("player", self.itemData[i].slotId)
      local src, dst = nil, nil
      if link then
        local reforge = self:GetReforgeID (link)
        if reforge then
          src = self.reforgeTable[reforge][1]
          dst = self.reforgeTable[reforge][2]
        end
      end
      if method.items[i].src ~= src or method.items[i].dst ~= dst then
        return 200000
      end
    end
  end
  if self.pdb.caps[1] and self.pdb.caps[1].stat ~= 0 and not self:CapAllows(self.pdb.caps[1], method.stats[self.pdb.caps[1].stat]) then
    return 100000
  end
  if self.pdb.caps[2] and self.pdb.caps[2].stat ~= 0 and not self:CapAllows(self.pdb.caps[2], method.stats[self.pdb.caps[2].stat]) then
    return 100000
  end
  return 0
end

function ReforgeLite:IsMethodValid(method)
  if not method.items then
    return true
  end
  for i = 1, #self.itemData do
    local item = GetInventoryItemLink ("player", self.itemData[i].slotId)
    local stats = (item and GetItemStatsUp(item, self.pdb.ilvlCap) or {})
    if method.items[i] and method.items[i].src and method.items[i].dst then
      if (stats[self.itemStats[method.items[i].src].name] or 0) == 0 then
        return false
      end
      if (stats[self.itemStats[method.items[i].dst].name] or 0) ~= 0 then
        return false
      end
    end
  end
  return true
end

function ReforgeLite:UpdateMethodStats (method)
  local conv = self:GetConversion()
  local mult = self:GetStatMultipliers()
  local oldstats = {}
  method.stats = {}
  for i = 1, #self.itemStats do
    oldstats[i] = self.itemStats[i].getter ()
    method.stats[i] = oldstats[i] / (mult[i] or 1)
  end
  method.items = method.items or {}
  for i = 1, #self.itemData do
    local item = GetInventoryItemLink ("player", self.itemData[i].slotId)
    local orgstats = (item and GetItemStatsUp(item) or {})
    local stats = (item and GetItemStatsUp(item, self.pdb.ilvlCap) or {})
    local reforge = (item and self:GetReforgeID(item))

    method.items[i] = method.items[i] or {}

    method.items[i].stats = nil
    method.items[i].reforge = nil
    method.items[i].amount = nil

    for s, v in ipairs(self.itemStats) do
      method.stats[s] = method.stats[s] - (orgstats[v.name] or 0) + (stats[v.name] or 0)
    end
    if reforge then
      local src, dst = self.reforgeTable[reforge][1], self.reforgeTable[reforge][2]
      local amount = math.floor ((orgstats[self.itemStats[src].name] or 0) * REFORGE_COEFF)
      method.stats[src] = method.stats[src] + amount
      method.stats[dst] = method.stats[dst] - amount
    end
    if method.items[i].src and method.items[i].dst then
      for j = 1, #self.reforgeTable do
        if self.reforgeTable[j][1] == method.items[i].src and self.reforgeTable[j][2] == method.items[i].dst then
          method.items[i].reforge = j
          break
        end
      end
      method.items[i].amount = math.floor ((stats[self.itemStats[method.items[i].src].name] or 0) * REFORGE_COEFF)
      method.stats[method.items[i].src] = method.stats[method.items[i].src] - method.items[i].amount
      method.stats[method.items[i].dst] = method.stats[method.items[i].dst] + method.items[i].amount
    end
  end
  for s, f in pairs(mult) do
    method.stats[s] = math.floor(method.stats[s] * f + 0.5)
  end
  -- assume we don't have 2 conversions
  for src, c in pairs(conv) do
    for dst, f in pairs(c) do
      method.stats[dst] = method.stats[dst] + math.floor((method.stats[src] - oldstats[src]) * f + 0.5)
    end
  end
end
function ReforgeLite:FinalizeReforge (data)
  self:UpdateMethodStats(data.method)
end
function ReforgeLite:ResetMethod ()
  local method = {}
  method.items = {}
  for i = 1, #self.itemData do
    method.items[i] = {}
    local item = GetInventoryItemLink ("player", self.itemData[i].slotId)
    local stats = (item and GetItemStatsUp(item, self.pdb.ilvlCap) or {})
    local reforge = (item and self:GetReforgeID(item))
    if reforge then
      method.items[i].reforge = reforge
      method.items[i].src = self.reforgeTable[reforge][1]
      method.items[i].dst = self.reforgeTable[reforge][2]
    end
  end
  self:UpdateMethodStats(method)
  self.pdb.method = method
  self:UpdateMethodCategory()
end

function ReforgeLite:CapAllows(cap, value)
  for i = 1, #cap.points do
    if cap.points[i].method == 1 and value < cap.points[i].value then
      return false
    elseif cap.points[i].method == 2 and value > cap.points[i].value then
      return false
    end
  end
  return true
end

function ReforgeLite:IsItemLocked(slot)
  if self.pdb.itemsLocked[slot] then return true end
  local item = GetInventoryItemLink ("player", self.itemData[slot].slotId)
  if not item then return true end
  local ilvl = select (4, GetItemInfo (item)) or 0
  return ilvl < 200
end

------------------------------------- CLASSIC REFORGE ------------------------------

function ReforgeLite:MakeReforgeOption(item, data, src, dst)
  local delta1, delta2, dscore = 0, 0, 0
  if src and dst then
    local amountRaw = math.floor(item.stats[src] * REFORGE_COEFF)
    local amount = math.floor(amountRaw * (data.mult[src] or 1) + math.random())
    if src == data.caps[1].stat then
      delta1 = delta1 - amount
    elseif src == data.caps[2].stat then
      delta2 = delta2 - amount
    else
      dscore = dscore - data.weights[src] * amount
    end
    if data.conv[src] then
      for to, factor in pairs(data.conv[src]) do
        local conv = math.floor(amount * factor + math.random())
        if data.caps[1].stat == to then
          delta1 = delta1 - conv
        elseif data.caps[2].stat == to then
          delta2 = delta2 - conv
        else
          dscore = dscore - data.weights[to] * conv
        end
      end
    end
    amount = math.floor(amountRaw * (data.mult[dst] or 1) + math.random())
    if dst == data.caps[1].stat then
      delta1 = delta1 + amount
    elseif dst == data.caps[2].stat then
      delta2 = delta2 + amount
    else
      dscore = dscore + data.weights[dst] * amount
    end
    if data.conv[dst] then
      for to, factor in pairs(data.conv[dst]) do
        local conv = math.floor(amount * factor + math.random())
        if data.caps[1].stat == to then
          delta1 = delta1 + conv
        elseif data.caps[2].stat == to then
          delta2 = delta2 + conv
        else
          dscore = dscore + data.weights[to] * conv
        end
      end
    end
  end
  return {d1 = delta1, d2 = delta2, ["src"] = src, ["dst"] = dst, score = dscore}
end
function ReforgeLite:GetItemReforgeOptions (item, data, slot)
  if self:IsItemLocked (slot) then
    local link = GetInventoryItemLink ("player", self.itemData[slot].slotId)
    local src, dst = nil, nil
    if link then
      local reforge = self:GetReforgeID (link)
      if reforge then
        src = self.reforgeTable[reforge][1]
        dst = self.reforgeTable[reforge][2]
      end
    end
    return { self:MakeReforgeOption (item, data, src, dst) }
  end
  local aopt = {}
  aopt[0] = self:MakeReforgeOption (item, data)
  for src = 1, #self.itemStats do
    if item.stats[src] > 0 then
      for dst = 1, #self.itemStats do
        if item.stats[dst] == 0 then
          local o = self:MakeReforgeOption (item, data, src, dst)
          local pos = o.d1 + o.d2 * 10000
          if not aopt[pos] or aopt[pos].score < o.score then
            aopt[pos] = o
          end
        end
      end
    end
  end
  local opt = {}
  for _, v in pairs (aopt) do
    table.insert (opt, v)
  end
  return opt
end
function ReforgeLite:InitReforgeClassic ()
  local method = {}
  method.items = {}
  local orgitems = {}
  local statsSum = 0
  for i = 1, #self.itemData do
    method.items[i] = {}
    method.items[i].stats = {}
    orgitems[i] = {}
    local item = GetInventoryItemLink ("player", self.itemData[i].slotId)
    local stats = (item and GetItemStatsUp(item, self.pdb.ilvlCap) or {})
    local orgstats = (item and GetItemStatsUp(item) or {})
    for j, v in ipairs(self.itemStats) do
      method.items[i].stats[j] = (stats[v.name] or 0)
      orgitems[i][j] = (orgstats[v.name] or 0)
      statsSum = statsSum + method.items[i].stats[j]
    end
  end

  if self.pdb.prio then
    self:PrioToWeights(self.pdb)
  end
  local data = {}
  data.method = method
  data.weights = DeepCopy (self.pdb.weights)
  data.caps = DeepCopy (self.pdb.caps)
  data.caps[1].init = 0
  data.caps[2].init = 0
  data.initial = {}

  data.mult = self:GetStatMultipliers()
  data.conv = self:GetConversion()

  for i = 1, 2 do
    for point = 1, #data.caps[i].points do
      local preset = data.caps[i].points[point].preset
      if self.capPresets[preset] == nil then
        preset = 1
      end
      if self.capPresets[preset].getter then
        data.caps[i].points[point].value = math.ceil(self.capPresets[preset].getter())
      end
    end
  end

  data.cheat = math.ceil(statsSum / 1000)
  if data.cheat < 1 then
    data.cheat = 1
  end

  for i = 1, #self.itemStats do
    data.initial[i] = self.itemStats[i].getter() / (data.mult[i] or 1)
    for j = 1, #orgitems do
      data.initial[i] = data.initial[i] - orgitems[j][i]
    end
  end
  local reforged = {}
  for i = 1, #self.itemStats do
    reforged[i] = 0
  end
  for i = 1, #data.method.items do
    local item = GetInventoryItemLink ("player", self.itemData[i].slotId)
    local reforge = (item and self:GetReforgeID (item))
    if reforge then
      local src, dst = self.reforgeTable[reforge][1], self.reforgeTable[reforge][2]
      local amount = math.floor(orgitems[i][src] * REFORGE_COEFF)
      data.initial[src] = data.initial[src] + amount
      data.initial[dst] = data.initial[dst] - amount
      reforged[src] = reforged[src] - amount
      reforged[dst] = reforged[dst] + amount
    end
  end
  for src, c in pairs(data.conv) do
    for dst, f in pairs(c) do
      data.initial[dst] = data.initial[dst] - math.floor(reforged[src] * (data.mult[src] or 1) * f + 0.5)
    end
  end
  if data.caps[1].stat > 0 then
    data.caps[1].init = data.initial[data.caps[1].stat]
    for i = 1, #data.method.items do
      data.caps[1].init = data.caps[1].init + data.method.items[i].stats[data.caps[1].stat]
    end
  end
  if data.caps[2].stat > 0 then
    data.caps[2].init = data.initial[data.caps[2].stat]
    for i = 1, #data.method.items do
      data.caps[2].init = data.caps[2].init + data.method.items[i].stats[data.caps[2].stat]
    end
  end
  if data.caps[1].stat == 0 then
    data.caps[1], data.caps[2] = data.caps[2], data.caps[1]
  end
  if data.caps[2].stat == data.caps[1].stat then
    data.caps[2].stat = 0
    data.caps[2].init = 0
  end
  if data.caps[2].stat == 0 then
    data.cheat = 1
  end

  for src, conv in pairs(data.conv) do
    if data.weights[src] == 0 then
      if (data.caps[1].stat and conv[data.caps[1].stat]) or (data.caps[2].stat and conv[data.caps[2].stat]) then
        if src == self.STATS.EXP then
          data.weights[src] = -1
        else
          data.weights[src] = 1
        end
      end
    end
  end

  return data
end

function ReforgeLite:ChooseReforgeClassic (data, reforgeOptions, scores, codes)
  local bestCode = {nil, nil, nil, nil}
  local bestScore = {0, 0, 0, 0}
  for k, score in pairs (scores) do
    local s1 = data.caps[1].init
    local s2 = data.caps[2].init
    local code = codes[k]
    for i = 1, #code do
      local b = code:byte (i)
      s1 = s1 + reforgeOptions[i][b].d1
      s2 = s2 + reforgeOptions[i][b].d2
    end
    local a1, a2 = true, true
    if data.caps[1].stat > 0 then
      a1 = a1 and self:CapAllows (data.caps[1], s1)
      score = score + self:GetCapScore (data.caps[1], s1)
    end
    if data.caps[2].stat > 0 then
      a2 = a2 and self:CapAllows (data.caps[2], s2)
      score = score + self:GetCapScore (data.caps[2], s2)
    end
    local allow = a1 and (a2 and 1 or 2) or (a2 and 3 or 4)
    if bestCode[allow] == nil or score > bestScore[allow] then
      bestCode[allow] = code
      bestScore[allow] = score
    end
  end
  return bestCode[1] or bestCode[2] or bestCode[3] or bestCode[4]
end

local function FormatValue (value, prefix)
  if type (value) == "table" then
    local result = "{\n"
    prefix = prefix or ""
    local newprefix = prefix .. "  "
    for k, v in pairs (value) do
      result = result .. newprefix .. tostring (k) .. " = " .. FormatValue (v, newprefix) .. "\n"
    end
    return result .. prefix .. "}"
  else
    return tostring (value)
  end
end

StaticPopupDialogs["REFORGELITE_COMPUTEERROR"] = {
  preferredIndex = STATICPOPUP_NUMDIALOGS,
  text = L["ReforgeLite failed to compute your optimal reforge. Try increasing the speed by moving the speed slider.\nError message: %s"],
  button1 = OKAY,
  button2 = nil,
  OnAccept = function ()
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
}

function ReforgeLite:ComputeReforgeCore (data, reforgeOptions)
  local TABLE_SIZE = 10000
  local scores, codes = {}, {}
  local mfloor = math.floor
  local mrandom = math.random
  local schar = string.char
  local linit = mfloor(data.caps[1].init / data.cheat + mrandom()) + mfloor(data.caps[2].init / data.cheat + mrandom()) * TABLE_SIZE
  scores[linit] = 0
  codes[linit] = ""
  for i = 1, #self.itemData do
    local newscores, newcodes = {}, {}
    local opt = reforgeOptions[i]
    local count = 0
    for k, score in pairs(scores) do
      local code = codes[k]
      local s1 = k % TABLE_SIZE
      local s2 = mfloor(k / TABLE_SIZE)
      for j = 1, #opt do
        local o = opt[j]
        local nscore = score + o.score
        local nk = s1 + mfloor(o.d1 / data.cheat + mrandom()) + (s2 + mfloor(o.d2 / data.cheat + mrandom())) * TABLE_SIZE
        if newscores[nk] == nil or nscore > newscores[nk] then
          if newscores[nk] == nil then
            count = count + 1
          end
          newscores[nk] = nscore
          newcodes[nk] = code .. schar(j)
        end
      end
    end
    scores, codes = newscores, newcodes
  end
  return scores, codes
end
function ReforgeLite:ComputeReforge (initFunc, optionFunc, chooseFunc)
  local data = self[initFunc] (self)
  local reforgeOptions = {}
  for i = 1, #self.itemData do
    reforgeOptions[i] = self[optionFunc] (self, data.method.items[i], data, i)
  end

  local success, scores, codes = pcall (self.ComputeReforgeCore, self, data, reforgeOptions)

  self.methodDebug = "<no data>" 
  if success then
    local code = self[chooseFunc] (self, data, reforgeOptions, scores, codes)
    scores, codes = nil, nil
    collectgarbage ("collect")
    self.methodDebug = "version = 1.32\n\n"
    self.methodDebug = self.methodDebug .. "data = " .. FormatValue (data) .. "\n\n"
    for i = 1, #data.method.items do
      local opt = reforgeOptions[i][code:byte (i)]
      if data.conv[self.STATS.SPIRIT] and data.conv[self.STATS.SPIRIT][self.STATS.HIT] == 1 then
        if opt.dst == self.STATS.HIT and data.method.items[i].stats[self.STATS.SPIRIT] == 0 then
          opt.dst = self.STATS.SPIRIT
        end
      end
      data.method.items[i].src = opt.src
      data.method.items[i].dst = opt.dst
    end
    self:FinalizeReforge (data)
    self.methodDebug = self.methodDebug .. "method = " .. FormatValue (data.method)
    return data.method
  else
    self.methodDebug = "data = " .. FormatValue (data)
    StaticPopup_Show ("REFORGELITE_COMPUTEERROR", scores)
    return nil
  end
end

function ReforgeLite:Compute ()
  return self:ComputeReforge ("InitReforgeClassic", "GetItemReforgeOptions", "ChooseReforgeClassic")
end

local ErrorFrame = CreateFrame ("Frame", "ReforgeLiteErrorFrame", UIParent)
ErrorFrame:Hide ()
ErrorFrame:SetPoint ("CENTER")
ErrorFrame:SetFrameStrata ("TOOLTIP")
ErrorFrame:SetWidth (320)
ErrorFrame:SetHeight (400)
ErrorFrame:SetBackdrop ({
  bgFile = "Interface\\Tooltips\\ChatBubble-Background",
  edgeFile = "Interface\\Tooltips\\ChatBubble-BackDrop",
  tile = true, tileSize = 32, edgeSize = 32,
  insets = {left = 32, right = 32, top = 32, bottom = 32}
})
ErrorFrame:SetBackdropColor (0, 0, 0, 1)
ErrorFrame:SetMovable (true)
ErrorFrame:SetClampedToScreen (true)
ErrorFrame:EnableMouse (true)
ErrorFrame:SetScript ("OnMouseDown", function () ErrorFrame:StartMoving () end)
ErrorFrame:SetScript ("OnMouseUp", function () ErrorFrame:StopMovingOrSizing () end)

ErrorFrame.ok = CreateFrame ("Button", "ReforgeLiteErrorFrameOk", ErrorFrame, "UIPanelButtonTemplate")
ErrorFrame.ok:SetSize (112, 22)
ErrorFrame.ok:SetText (ACCEPT)
ErrorFrame.ok:SetPoint ("BOTTOM", 0, 10)
ErrorFrame.ok:SetScript ("OnClick", function () ErrorFrame:Hide () end)
ErrorFrame.message = ErrorFrame:CreateFontString (nil, "OVERLAY", "GameFontNormal")
ErrorFrame.message:SetPoint ("TOPLEFT", 15, -15)
ErrorFrame.message:SetPoint ("TOPRIGHT", -15, -15)
ErrorFrame.message:SetJustifyH ("LEFT")
ErrorFrame.message:SetTextColor (1, 1, 1)
ErrorFrame.message:SetText ("")
ErrorFrame.scroll = CreateFrame ("ScrollFrame", "ReforgeLiteErrorFrameScroll", ErrorFrame, "UIPanelScrollFrameTemplate")
ErrorFrame.scroll:SetPoint ("TOPLEFT", ErrorFrame.message, "BOTTOMLEFT", 0, -10)
ErrorFrame.scroll:SetPoint ("TOPRIGHT", ErrorFrame.message, "BOTTOMRIGHT", -16, -10)
ErrorFrame.scroll:SetPoint ("BOTTOM", ErrorFrame.ok, "TOP", 0, 10)
ErrorFrame.text = CreateFrame ("EditBox", "ReforgeLiteErrorFrameText", ErrorFrame.scroll)
ErrorFrame.scroll:SetScrollChild (ErrorFrame.text)
ErrorFrame.text:SetWidth (274)
ErrorFrame.text:SetHeight (100)
ErrorFrame.text:SetMultiLine (true)
ErrorFrame.text:SetAutoFocus (false)
ErrorFrame.text:SetFontObject (GameFontHighlight)
ErrorFrame.text:SetScript ("OnEscapePressed", function () ErrorFrame:Hide () end)
ErrorFrame.updateText = function ()
  ErrorFrame.text:SetText (ErrorFrame.err)
  ErrorFrame.scroll:UpdateScrollChildRect ()
  ErrorFrame.text:ClearFocus ()
end
ErrorFrame.text:SetScript ("OnTextChanged", ErrorFrame.updateText)
ErrorFrame.text:SetScript ("OnEditFocusGained", function ()
  ErrorFrame.text:HighlightText ()
end)
function ErrorFrame:DisplayError (message, err)
  ErrorFrame.message:SetText (message)
  ErrorFrame.err = err
  ErrorFrame.updateText ()
  ErrorFrame:Show ()
end

function ReforgeLite:DebugMethod ()
  ErrorFrame:DisplayError ("E-mail: d07.riv@gmail.com", self.methodDebug or "<no data>")
end
