-- Part of ReforgeLite by d07.RiV (Iroared)
-- All rights reserved

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
local GUI = ReforgeLiteGUI

local MOP = (GetNumTalentTabs == nil)

function ReforgeLite:AddCapPoint(i, loading)
  local point = (loading or #self.pdb.caps[i].points + 1)
  self.task.caps[i]:AddRow(point)

  if not loading then
    table.insert(self.pdb.caps[i].points, 1, {value = 0, method = 1, after = 0, preset = 1})
  end

  local rem = GUI:CreateImageButton(self.task.caps[i], 20, 20, "Interface\\PaperDollInfoFrame\\UI-GearManager-LeaveItem-Transparent",
    "Interface\\PaperDollInfoFrame\\UI-GearManager-LeaveItem-Transparent", nil, function()
    self:RemoveCapPoint(i, point)
  end)
  local methodList = {{value = 1, name = L["At least"]}, {value = 2, name = L["At most"]}, {value = 3, name = ""}}
  local method = GUI:CreateDropdown (self.task.caps[i], methodList, 1,
    function (val) self.pdb.caps[i].points[point].method = val end, 80)
  local preset = GUI:CreateDropdown(self.task.caps[i], self.capPresets, 1, function(val)
    self.pdb.caps[i].points[point].preset = val
    self:UpdateCapPoints(i)
    self:RefreshMethodStats()
  end, 80)
  local value = GUI:CreateEditBox(self.task.caps[i], 40, 30, 0, function(val)
    self.pdb.caps[i].points[point].value = val
    self:UpdateCapPoints(i)
    self:RefreshMethodStats()
  end)
  local after = GUI:CreateEditBox(self.task.caps[i], 40, 30, 0, function(val)
    self.pdb.caps[i].points[point].after = val
    self:RefreshMethodStats()
  end)

  GUI:SetTooltip(rem, L["Remove line"])
  GUI:SetTooltip(value, L["Cap value"])
  GUI:SetTooltip(after, L["Weight after cap"])

  self.task.caps[i]:SetCell(point, 0, rem)
  self.task.caps[i]:SetCell(point, 1, method, "CENTER", 0, -10)
  self.task.caps[i]:SetCell(point, 2, preset, "CENTER", 0, -10)
  self.task.caps[i]:SetCell(point, 3, value)
  self.task.caps[i]:SetCell(point, 4, after)

  UIDropDownMenu_SetWidth (self.task.caps[i].cells[point][2], self.task.caps[i]:GetColumnWidth (2) - 20)

  if not loading then
    self:UpdateCapPoints(i)
    self:UpdateContentSize()
  end
end
function ReforgeLite:RemoveCapPoint(i, point, loading)
  local row = #self.pdb.caps[1].points
  self.task.caps[i]:DeleteRow(row)
  if not loading then
    table.remove(self.pdb.caps[i].points, point)
    self:UpdateCapPoints(i)
    self:UpdateContentSize()
  end
end
function ReforgeLite:ReorderCapPoint(i, point)
  if point > 1 and self.pdb.caps[i].points[point - 1].value > self.pdb.caps[i].points[point].value then
    self:UpdateCapPoints(i)
  elseif point < #self.pdb.caps[i].points and self.pdb.caps[i].points[point + 1].value < self.pdb.caps[i].points[point].value then
    self:UpdateCapPoints(i)
  end
end
function ReforgeLite:UpdateCapPreset(i, point)
  local preset = self.pdb.caps[i].points[point].preset
  if self.capPresets[preset] and self.capPresets[preset].getter then
    self.task.caps[i].cells[point][3]:SetTextColor(0.5, 0.5, 0.5)
    self.task.caps[i].cells[point][3]:EnableMouse(false)
    self.task.caps[i].cells[point][3]:ClearFocus()
  else
    self.task.caps[i].cells[point][3]:SetTextColor(1, 1, 1)
    self.task.caps[i].cells[point][3]:EnableMouse(true)
  end
  self.task.caps[i].cells[point][3]:SetText(self.pdb.caps[i].points[point].value)
end
function ReforgeLite:UpdateCapPoints(i)
  while self.task.caps[i].rows < #self.pdb.caps[i].points do
    self:AddCapPoint(i, self.task.caps[i].rows + 1)
  end
  while self.task.caps[i].rows > #self.pdb.caps[i].points do
    self:RemoveCapPoint(i, self.task.caps[i].rows, true)
  end
  for point = 1, #self.pdb.caps[i].points do
    local preset = self.pdb.caps[i].points[point].preset
    if self.capPresets[preset] == nil then
      preset = 1
      self.pdb.caps[i].points[point].preset = 1
    end
    if self.capPresets[preset].getter then
      self.pdb.caps[i].points[point].value = math.ceil(self.capPresets[preset].getter())
    end
  end
  table.sort(self.pdb.caps[i].points, function(a, b) return a.value < b.value end)
  for point = 1, #self.pdb.caps[i].points do
    self.task.caps[i].cells[point][1]:SetValue(self.pdb.caps[i].points[point].method)
    self.task.caps[i].cells[point][2]:SetValue(self.pdb.caps[i].points[point].preset)
    self:UpdateCapPreset(i, point)
    self.task.caps[i].cells[point][4]:SetText(self.pdb.caps[i].points[point].after)
  end
end
function ReforgeLite:CapUpdater ()
  self.task.caps[1].stat:SetValue(self.pdb.caps[1].stat)
  self.task.caps[2].stat:SetValue(self.pdb.caps[2].stat)
  self:UpdateCapPoints(1)
  self:UpdateCapPoints(2)
end
function ReforgeLite:UpdateStatWeightList()
  local rows = 0
  for i, v in pairs(self.itemStats) do
    rows = rows + 1
  end
  self.task.weights:ClearCells ()
  self.task.weights.inputs = {}
  rows = math.ceil (rows / 2)
  while self.task.weights.rows > rows do
    self.task.weights:DeleteRow (1)
  end
  if self.task.weights.rows < rows then
    self.task.weights:AddRow (1, rows - self.task.weights.rows)
  end
  local pos = 0
  for i, v in pairs(self.itemStats) do
    pos = pos + 1
    local col = math.floor ((pos - 1) / self.task.weights.rows)
    local row = pos - col * self.task.weights.rows
    col = 1 + 2 * col

    self.task.weights:SetCellText (row, col, v.long, "LEFT")
    self.task.weights.inputs[i] = GUI:CreateEditBox (self.task.weights, 60, self.db.itemSize, self.pdb.weights[i], function (val)
      self.pdb.weights[i] = val
      self:RefreshMethodStats ()
    end)
    self.task.weights:SetCell (row, col + 1, self.task.weights.inputs[i])
  end
  
  self:UpdateContentSize ()
end

----------------------------------------------------------

function ReforgeLite:AddPriorityItem(loading)
  local row = (loading or #self.pdb.prio + 1)
  self.task.prio:AddRow(row)
  if not loading then
    self.pdb.prio[row] = {stat = 0, capped = false, preset = 1, value = 0}
  end

  local rem = GUI:CreateImageButton(self.task.prio, 20, 20, "Interface\\PaperDollInfoFrame\\UI-GearManager-LeaveItem-Transparent",
    "Interface\\PaperDollInfoFrame\\UI-GearManager-LeaveItem-Transparent", nil, function()
    self:RemovePriorityItem(row)
  end)
  local mup = GUI:CreateImageButton(self.task.prio, 24, 24, "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
    "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Down", "Interface\\Buttons\\UI-Common-MouseHilight", function ()
    self:MovePriorityItem(row, -1)
  end)
  local mdown = GUI:CreateImageButton(self.task.prio, 24, 24, "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
    "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down", "Interface\\Buttons\\UI-Common-MouseHilight", function ()
    self:MovePriorityItem(row, 1)
  end)
  local capped = GUI:CreateCheckButton(self.task.prio, L["to"], self.pdb.prio[row].capped, function(val)
    self.pdb.prio[row].capped = val
    self:UpdatePriorities()
    self:PrioToWeights(self.pdb)
    self:RefreshMethodStats()
  end)
  local statList = {{value = 0, name = L["None"]}}
  for i, v in ipairs (self.itemStats) do
    table.insert (statList, {value = i, name = v.long})
  end
  local stat = GUI:CreateDropdown(self.task.prio, statList, self.pdb.prio[row].stat, function(val)
    self.pdb.prio[row].stat = val
    self:UpdatePriorities()
    self:PrioToWeights(self.pdb)
    self:RefreshMethodStats()
  end, 110)
  local preset = GUI:CreateDropdown(self.task.prio, self.capPresets, self.pdb.prio[row].preset, function(val)
    self.pdb.prio[row].preset = val
    self:UpdatePriorityPreset(row)
    self:PrioToWeights(self.pdb)
    self:RefreshMethodStats()
  end, 80)
  local value = GUI:CreateEditBox(self.task.prio, 40, 30, self.pdb.prio[row].value, function(val)
    self.pdb.prio[row].value = val
    self:PrioToWeights(self.pdb)
    self:RefreshMethodStats()
  end)

  GUI:SetTooltip(rem, L["Remove line"])
  GUI:SetTooltip(mup, L["Move up"])
  GUI:SetTooltip(mdown, L["Move down"])
  GUI:SetTooltip(value, L["Cap value"])

  self.task.prio:SetCell(row, 1, rem)
  self.task.prio:SetCell(row, 2, mup)
  self.task.prio:SetCell(row, 3, mdown)
  self.task.prio:SetCell(row, 4, stat, "CENTER", 0, -10)
  self.task.prio:SetCell(row, 5, capped, "CENTER", -5, 0)
  self.task.prio:SetCell(row, 6, preset, "CENTER", 0, -10)
  self.task.prio:SetCell(row, 7, value)

  UIDropDownMenu_SetWidth (self.task.prio.cells[row][6], self.task.prio:GetColumnWidth (6) - 20)

  if not loading then
    self:UpdatePriorities()
    self:UpdateContentSize()
  end

  self:PrioToWeights(self.pdb)
end
function ReforgeLite:RemovePriorityItem(row, loading)
  self.task.prio:DeleteRow(#self.pdb.prio)
  if not loading then
    table.remove(self.pdb.prio, row)
    self:UpdatePriorities()
    self:UpdateContentSize()

    self:PrioToWeights(self.pdb)
  end  
end
function ReforgeLite:MovePriorityItem(row, delta)
  local swap = row + delta
  if swap >= 1 and swap <= #self.pdb.prio then
    local temp = self.pdb.prio[row]
    self.pdb.prio[row] = self.pdb.prio[swap]
    self.pdb.prio[swap] = temp
    self:UpdatePriorityItem(row)
    self:UpdatePriorityItem(swap)

    self:PrioToWeights(self.pdb)
  end
end
function ReforgeLite:UpdatePriorityPreset(row)
  local preset = self.pdb.prio[row].preset
  if self.capPresets[preset] == nil then
    preset = 1
  end
  if self.capPresets[preset].getter then
    self.task.prio.cells[row][7]:SetTextColor(0.5, 0.5, 0.5)
    self.task.prio.cells[row][7]:EnableMouse(false)
    self.task.prio.cells[row][7]:ClearFocus()
    self.pdb.prio[row].value = math.ceil(self.capPresets[preset].getter())
  else
    self.task.prio.cells[row][7]:SetTextColor(1, 1, 1)
    self.task.prio.cells[row][7]:EnableMouse(true)
  end
  self.task.prio.cells[row][7]:SetText(self.pdb.prio[row].value)
end
function ReforgeLite:UpdatePriorityItem(row)
  local ccount = 0
  local scaps = {}
  for r = 1, #self.pdb.prio do
    if self.pdb.prio[r].capped and not scaps[self.pdb.prio[r].stat] then
      if ccount >= 2 then
        self.pdb.prio[r].capped = false
      else
        scaps[self.pdb.prio[r].stat] = true
        ccount = ccount + 1
      end
    end
  end
  if row == 1 then
    self.task.prio.cells[row][2]:Hide()
  else
    self.task.prio.cells[row][2]:Show()
  end
  if row == #self.pdb.prio then
    self.task.prio.cells[row][3]:Hide()
  else
    self.task.prio.cells[row][3]:Show()
  end
  self.task.prio.cells[row][4]:SetValue(self.pdb.prio[row].stat)
  if self.pdb.prio[row].capped then
    self.task.prio.cells[row][5]:SetChecked(true)
    self.task.prio.cells[row][6]:Show()
    self.task.prio.cells[row][6]:SetValue(self.pdb.prio[row].preset)
    self.task.prio.cells[row][7]:Show()
    self:UpdatePriorityPreset(row)
  else
    self.task.prio.cells[row][5]:SetChecked(false)
    if ccount >= 2 and not scaps[self.pdb.prio[row].stat] then
      self.task.prio.cells[row][5]:Hide()
    else
      self.task.prio.cells[row][5]:Show()
    end
    self.task.prio.cells[row][6]:Hide()
    self.task.prio.cells[row][7]:Hide()
  end
end
function ReforgeLite:UpdatePriorities()
  while self.task.prio.rows < #self.pdb.prio + 1 do
    self:AddPriorityItem(self.task.prio.rows)
  end
  while self.task.prio.rows > #self.pdb.prio + 1 do
    self:RemovePriorityItem(self.task.prio.rows - 1, true)
  end
  for i = 1, #self.pdb.prio do
    self:UpdatePriorityItem(i)
  end
  self.task.prio:SetCell(#self.pdb.prio + 1, 4, self.task.prio.add)
end

----------------------------------------------------------

function ReforgeLite:UpdateTask()
  self.isWeights:SetChecked(not self.pdb.prio)
  if not self.pdb.prio then
    self.task.weights:Show()
    self.task.caps[1]:Show()
    self.task.caps[2]:Show()
    self.task.prio:Hide()

    self:UpdateStatWeightList()
    self:CapUpdater()
    if self.computeButton then
      self:SetAnchor(self.computeButton, "TOPLEFT", self.task.caps[2], "BOTTOMLEFT", 0, -10)
    end
  else
    self.task.weights:Hide()
    self.task.caps[1]:Hide()
    self.task.caps[2]:Hide()
    self.task.prio:Show()

    self:UpdatePriorities()
    if self.computeButton then
      self:SetAnchor(self.computeButton, "TOPLEFT", self.task.prio, "BOTTOMLEFT", 0, -10)
    end
  end

  self:UpdateContentSize ()
end
function ReforgeLite:SetStatWeights(weights, caps, prio)
  if prio then
    self.pdb.prio = DeepCopy(prio)
    for i = 1, #self.pdb.prio do
      self.pdb.prio[i].capped = (self.pdb.prio[i].preset ~= nil) or (self.pdb.prio[i].value ~= nil)
      self.pdb.prio[i].preset = self.pdb.prio[i].preset or 1
      self.pdb.prio[i].value = self.pdb.prio[i].value or 0
    end
    self:PrioToWeights(self.pdb)
  else
    if weights then
      self.pdb.weights = DeepCopy(weights)
    else
      self.pdb.weights = {0, 0, 0, 0, 0, 0, 0, 0}
    end
    if caps then
      for i = 1, 2 do
        if caps[i] then
          self.pdb.caps[i] = DeepCopy(caps[i])
          self.pdb.caps[i].stat = self.pdb.caps[i].stat or 0
          if #self.pdb.caps[i].points == 0 then
            self.pdb.caps[i].points[1] = {method = 1, preset = 1, after = 0, value = 0}
          end
          for p = 1, #self.pdb.caps[i].points do
            self.pdb.caps[i].points[p].method = self.pdb.caps[i].points[p].method or 3
            self.pdb.caps[i].points[p].after = self.pdb.caps[i].points[p].after or 0
            self.pdb.caps[i].points[p].value = self.pdb.caps[i].points[p].value or 0
            self.pdb.caps[i].points[p].preset = self.pdb.caps[i].points[p].preset or 1
          end
        else
          self.pdb.caps[i] = {
            stat = 0,
            points = {
              {
                method = 1,
                value = 0,
                after = 0,
                preset = 1
              }
            }
          }
        end
      end
    end
  end
  self:UpdateTask()
end

function ReforgeLite:CreateTaskUI()
  self.statWeightsCategory = self:CreateCategory (L["Stat weights"])
  self:SetAnchor (self.statWeightsCategory, "TOPLEFT", self.content, "TOPLEFT", 2, -2)

  self.presetsButton = GUI:CreateImageButton (self.content, 24, 24, "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
    "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down", "Interface\\Buttons\\UI-Common-MouseHilight", function ()
    ToggleDropDownMenu (1, nil, self.presetMenu, self.presetsButton:GetName (), 0, 0)
  end)
  self.statWeightsCategory:AddFrame (self.presetsButton)
  self:SetAnchor (self.presetsButton, "TOPLEFT", self.statWeightsCategory, "BOTTOMLEFT", 0, -5)
  self.presetsButton.tip = self.presetsButton:CreateFontString (nil, "OVERLAY", "GameFontNormal")
  self.presetsButton.tip:SetPoint ("LEFT", self.presetsButton, "RIGHT", 5, 0)
  self.presetsButton.tip:SetText (L["Presets"])

  self.savePresetButton = CreateFrame ("Button", "ReforgeLiteSavePresetButton", self.content, "UIPanelButtonTemplate")
  self.statWeightsCategory:AddFrame (self.savePresetButton)
  self.savePresetButton:SetWidth (114)
  self.savePresetButton:SetHeight (22)
  self.savePresetButton:SetText (L["Save"])
  self.savePresetButton:SetScript ("OnClick", function (self)
    StaticPopup_Show ("REFORGE_LITE_SAVE_PRESET")
  end)
  self:SetAnchor (self.savePresetButton, "LEFT", self.presetsButton.tip, "RIGHT", 8, 0)

  self.deletePresetButton = CreateFrame ("Button", "ReforgeLiteDeletePresetButton", self.content, "UIPanelButtonTemplate")
  self.statWeightsCategory:AddFrame (self.deletePresetButton)
  self.deletePresetButton:SetWidth (114)
  self.deletePresetButton:SetHeight (22)
  self.deletePresetButton:SetText (L["Delete"])
  self.deletePresetButton:SetScript ("OnClick", function ()
    if next (self.db.customPresets) then
      ToggleDropDownMenu (1, nil, self.presetDelMenu, self.deletePresetButton:GetName (), 0, 0)
    end
  end)
  self:SetAnchor (self.deletePresetButton, "LEFT", self.savePresetButton, "RIGHT", 5, 0)
  if next (self.db.customPresets) == nil then
    self.deletePresetButton:Disable ()
  end

  ------------------------

  self.pawnButton = CreateFrame ("Button", "ReforgeLiteImportButton", self.content, "UIPanelButtonTemplate")
  self.statWeightsCategory:AddFrame (self.pawnButton)
  self.pawnButton:SetWidth (114)
  self.pawnButton:SetHeight (22)
  self.pawnButton:SetText (L["Import"] .. " Pawn")
  self.pawnButton:SetScript ("OnClick", function (self)
    StaticPopup_Show ("REFORGE_LITE_PARSE_PAWN")
  end)
  self:SetAnchor (self.pawnButton, "TOPLEFT", self.presetsButton, "BOTTOMLEFT", 0, -5)

  ------------------------

  self.convertSpirit = CreateFrame ("Frame", nil, self.content)
  self.statWeightsCategory:AddFrame (self.convertSpirit)
  self.convertSpirit.text = self.convertSpirit:CreateFontString (nil, "OVERLAY", "GameFontNormal")
  self.convertSpirit.text:SetPoint ("LEFT", self.pawnButton, "RIGHT", 8, 0)
  self.convertSpirit.text:SetText (L["Spirit to hit"] .. ": 0%")
  self.convertSpirit.text:Hide ()
  
  local levelList = {{value = 0, name = L["PvP (+0)"]}, {value = 2, name = L["Heroic dungeons (+2)"]}, {value = 3, name = L["Raids (+3)"]}}
  self.targetLevel = GUI:CreateDropdown(self.content, levelList, self.pdb.targetLevel,
    function(val) self.pdb.targetLevel = val self:UpdateItems() end, 150)
  self.targetLevel.tip = CreateFrame("Frame", nil, self.content)
  self.statWeightsCategory:AddFrame(self.targetLevel)
  self.statWeightsCategory:AddFrame(self.targetLevel.tip)
  self.targetLevel.text = self.targetLevel.tip:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  self.targetLevel.text:SetText(L["Target level"])
  self:SetAnchor(self.targetLevel.text, "TOPLEFT", self.pawnButton, "BOTTOMLEFT", 0, -8)
  self.targetLevel:SetPoint("BOTTOMLEFT", self.targetLevel.text, "BOTTOMLEFT", 150, -20)

  local ilvlCapList = {{value = 0, name = L["None"]}, {value = 496, name = L["PvP (496)"]}}
  self.ilvlCap = GUI:CreateDropdown(self.content, ilvlCapList, self.pdb.ilvlCap,
    function(val) self.pdb.ilvlCap = val self:UpdateItems() end, 150)
  self.ilvlCap.tip = CreateFrame("Frame", nil, self.content)
  self.statWeightsCategory:AddFrame(self.ilvlCap)
  self.statWeightsCategory:AddFrame(self.ilvlCap.tip)
  self.ilvlCap.text = self.ilvlCap.tip:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  self.ilvlCap.text:SetText(L["Item level cap"])
  self:SetAnchor(self.ilvlCap.text, "TOPLEFT", self.targetLevel.text, "BOTTOMLEFT", 0, -8)
  self.ilvlCap:SetPoint("BOTTOMLEFT", self.ilvlCap.text, "BOTTOMLEFT", 150, -20)

  ------------------------

  self.isWeights = GUI:CreateCheckButton(self.content, L["Advanced mode"],
      not self.pdb.prio, function (val)
    if val then
      self:PrioToWeights(self.pdb)
      self.pdb.prio = nil
    else
      self:WeightsToPrio(self.pdb)
      self:PrioToWeights(self.pdb)
    end
    self:UpdateTask()
    self:RefreshMethodStats()
  end)
  self.statWeightsCategory:AddFrame (self.isWeights)
  self:SetAnchor (self.isWeights, "TOPLEFT", self.ilvlCap.text, "BOTTOMLEFT", 0, -8)

  self.task = {}

  self.task.weights = GUI:CreateTable (math.ceil (#self.itemStats / 2), 4)
  self:SetAnchor (self.task.weights, "TOPLEFT", self.isWeights, "BOTTOMLEFT", 0, -4)
  self.task.weights:SetPoint ("RIGHT", self.content, "RIGHT", -5, 0)
  self.statWeightsCategory:AddFrame (self.task.weights)
  self.task.weights:SetRowHeight (self.db.itemSize + 2)
  self.task.weights.inputs = {}
  for i, v in ipairs(self.itemStats) do
    local col = math.floor ((i - 1) / self.task.weights.rows)
    local row = i - col * self.task.weights.rows
    col = 1 + 2 * col

    self.task.weights:SetCellText(row, col, v.long, "LEFT")
    self.task.weights.inputs[i] = GUI:CreateEditBox(self.task.weights, 60, self.db.itemSize, 0, function (val)
      if self.pdb.weights then
        self.pdb.weights[i] = val
        self:RefreshMethodStats()
      end
    end)
    self.task.weights:SetCell(row, col + 1, self.task.weights.inputs[i])
  end

  self.task.caps = {}
  local statList = {{value = 0, name = L["None"]}}
  for i, v in ipairs (self.itemStats) do
    table.insert (statList, {value = i, name = v.long})
  end
  for i = 1, 2 do
    self.task.caps[i] = GUI:CreateTable (0, 4, self.db.itemSize + 2, self.db.itemSize + 2)
    self.statWeightsCategory:AddFrame (self.task.caps[i])
    self.task.caps[i]:SetPoint ("RIGHT", self.content, "RIGHT", -5, 0)
    self.task.caps[i]:SetRowHeight (self.db.itemSize + 2)
    self.task.caps[i]:SetColumnWidth (1, 100)
    self.task.caps[i]:SetColumnWidth (3, 50)
    self.task.caps[i]:SetColumnWidth (4, 50)

    self.task.caps[i].stat = GUI:CreateDropdown (self.task.caps[i], statList, 0, function (val)
      if self.pdb.caps then
        self.pdb.caps[i].stat = val
        self:RefreshMethodStats()
      end
    end, 110)
    self.task.caps[i].add = GUI:CreateImageButton (self.task.caps[i], 20, 20, "Interface\\Buttons\\UI-PlusButton-Up",
      "Interface\\Buttons\\UI-PlusButton-Down", "Interface\\Buttons\\UI-PlusButton-Hilight", function ()
      self:AddCapPoint (i)
    end)
    GUI:SetTooltip(self.task.caps[i].add, L["Add cap"])
    self.task.caps[i]:SetCell (0, 0, self.task.caps[i].stat, "LEFT", -20, -10)
    self.task.caps[i]:SetCell (0, 2, self.task.caps[i].add, "LEFT")

    self.task.caps[i].onUpdate = function()
      for row = 1, self.task.caps[i].rows do
        if self.task.caps[i].cells[row][2] and self.task.caps[i].cells[row][2].values then
          UIDropDownMenu_SetWidth (self.task.caps[i].cells[row][2], self.task.caps[i]:GetColumnWidth (2) - 20)
        end
      end
    end
  end
  self:SetAnchor (self.task.caps[1], "TOPLEFT", self.task.weights, "BOTTOMLEFT", 0, -10)
  self:SetAnchor (self.task.caps[2], "TOPLEFT", self.task.caps[1], "BOTTOMLEFT", 0, -10)
--  for i = 1, 2 do
--    for point = 1, #self.pdb.caps[i].points do
--      self:AddCapPoint (i, point)
--    end
--    self:UpdateCapPoints (i)
--  end

  self.task.prio = GUI:CreateTable(1, 7)
  self:SetAnchor(self.task.prio, "TOPLEFT", self.isWeights, "BOTTOMLEFT", 0, -4)
  self.task.prio:SetPoint ("RIGHT", self.content, "RIGHT", -5, 0)
  self.statWeightsCategory:AddFrame(self.task.prio)
  self.task.prio:SetRowHeight(self.db.itemSize + 2)
  self.task.prio:SetColumnWidth(1, self.db.itemSize + 2)
  self.task.prio:SetColumnWidth(2, self.db.itemSize + 2)
  self.task.prio:SetColumnWidth(3, self.db.itemSize + 2)
  self.task.prio:SetColumnWidth(4, 130)
  self.task.prio:SetColumnWidth(5, 50)
  self.task.prio:SetColumnWidth(7, 50)
  self.task.prio.onUpdate = function()
    for row = 1, self.task.prio.rows - 1 do
      if self.task.prio.cells[row][6] and self.task.prio.cells[row][6].values then
        UIDropDownMenu_SetWidth (self.task.prio.cells[row][6], self.task.prio:GetColumnWidth (6) - 20)
      end
    end
  end
  self.task.prio.add = CreateFrame("Button", "ReforgeLitePrioAddButton", self.task.prio, "UIPanelButtonTemplate")
  self.task.prio.add:SetWidth (114)
  self.task.prio.add:SetHeight (22)
  self.task.prio.add:SetText (L["Add stat"])
  self.task.prio.add:SetScript ("OnClick", function()
    self:AddPriorityItem()
  end)
  self.task.prio:SetCell(1, 4, self.task.prio.add)

  self:UpdateTask()

  self.presetsButton:SetScript("OnUpdate", function ()
    self.presetsButton:SetScript("OnUpdate", nil)
    self:CapUpdater()
  end)
end

function ReforgeLite:PrioToWeights(pdb)
  pdb.weights = {0, 0, 0, 0, 0, 0, 0, 0}
  pdb.caps = {
    {
      stat = 0,
      points = {
      }
    },
    {
      stat = 0,
      points = {
      }
    }
  }
  local limits = {0, 0, 0, 0, 0, 0, 0, 0}
  local value = #pdb.prio * 20 + 100
  local defMethod = 1
  for i = 1, #pdb.prio do
    local limit = 1000000
    if pdb.prio[i].stat ~= 0 then
      if pdb.prio[i].capped then
        local preset = pdb.prio[i].preset
        if preset and self.capPresets[preset] and self.capPresets[preset].getter then
          limit = self.capPresets[preset].getter()
        else
          limit = pdb.prio[i].value or 0
        end
      end
      if limit > limits[pdb.prio[i].stat] then
        if pdb.caps[1].stat == pdb.prio[i].stat or pdb.caps[2].stat == pdb.prio[i].stat then
          local t = (pdb.caps[1].stat == pdb.prio[i].stat and 1 or 2)
          local n = #pdb.caps[t].points
          pdb.caps[t].points[n].after = value
          if pdb.prio[i].capped then
            pdb.caps[t].points[n + 1] = {
              method = 3,
              preset = pdb.prio[i].preset,
              value = pdb.prio[i].value,
              after = 0
            }
          end
        elseif pdb.prio[i].capped and (pdb.caps[1].stat == 0 or pdb.caps[2].stat == 0) then
          local t = (pdb.caps[1].stat == 0 and 1 or 2)
          pdb.weights[pdb.prio[i].stat] = value
          pdb.caps[t].stat = pdb.prio[i].stat
          pdb.caps[t].points = {
            {
              method = defMethod,
              preset = pdb.prio[i].preset,
              value = pdb.prio[i].value,
              after = 0
            }
          }
        else
          defMethod = 3
          pdb.weights[pdb.prio[i].stat] = value
          limit = 1000000
        end
        limits[pdb.prio[i].stat] = limit
      end
    end
    value = value - 20
  end
  for i = 1, 2 do
    if #pdb.caps[i].points == 0 then
      pdb.caps[i].points[1] = {method = 1, preset = 1, value = 0, after = 0}
    end
  end
end
function ReforgeLite:WeightsToPrio(pdb)
  pdb.prio = {}
  local list = {}
  for s = 1, #self.itemStats do
    local prev = pdb.weights[s]
    if pdb.caps[1].stat == s or pdb.caps[2].stat == s then
      local t = (pdb.caps[1].stat == s and 1 or 2)
      for i = 1, #pdb.caps[t].points do
        if prev > 0 then
          list[#list + 1] = {
            weight = prev,
            prio = {
              stat = s,
              capped = true,
              preset = pdb.caps[t].points[i].preset,
              value = pdb.caps[t].points[i].value
            }
          }
        end
        prev = pdb.caps[t].points[i].after
      end
    end
    if prev > 0 then
      list[#list + 1] = {
        weight = prev,
        prio = {
          stat = s,
          capped = false,
          preset = 1,
          value = 0
        }
      }
    end
  end
  table.sort(list, function(a, b) return a.weight > b.weight end)
  for i = 1, #list do
    pdb.prio[i] = list[i].prio
  end
end
