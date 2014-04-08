-- ReforgeLite v1.37 by d07.RiV (Iroared)
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

ReforgeLite = CreateFrame ("Frame", nil, UIParent)
ReforgeLite:Hide ()
ReforgeLite.initialized = false
ReforgeLiteDB = nil
local AddonPath = "Interface\\AddOns\\ReforgeLite\\"
local DefaultDB = {
  itemSize = 24,
  windowWidth = 800,
  windowHeight = 564,

  reforgeCheat = 5,

  openOnReforge = true,
--  updateTooltip = true,

  activeWindowTitle = {0.8, 0, 0},
  inactiveWindowTitle = {0.5, 0.5, 0.5},

  customPresets = {
  },
  profiles = {
  },
}
local DefaultDBProfile = {
  targetLevel = 3,
  ilvlCap = 0,

  buffs = {
  },
  weights = {0, 0, 0, 0, 0, 0, 0, 0},
  caps = {
    {
      stat = 0,
      points = {
        {
          method = 1,
          value = 0,
          after = 0,
          preset = 1
        }
      }
    },
    {
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
  },
  itemsLocked = {},
  customMethodPresets = {
  },
}
local function MergeTables (dst, src)
  for k, v in pairs (src) do
    if type (v) ~= "table" then
      if dst[k] == nil then
        dst[k] = v
      end
    else
      if type (dst[k]) ~= "table" then
        dst[k] = {}
      end
      MergeTables (dst[k], v)
    end
  end
end

ReforgeLite.dbkey = UnitName ("player") .. " - " .. GetRealmName ()
local _, playerClass = UnitClass ("player")
local _, playerRace = UnitRace ("player")
playerRace = string.upper(playerRace)
local missChance = (playerRace == "NIGHTELF" and 7 or 5)

function ReforgeLite:UpgradeDBCaps (caps)
  for i = 1, #caps do
    if caps[i].points == nil or caps[i].value or caps[i].method or caps[i].after then
      caps[i].points = {}
      caps[i].points[1] = {
        method = caps[i].method or 1,
        value = caps[i].value or 0,
        after = caps[i].after or 0
      }
      for j = 1, #caps[i].points do
        if not caps[i].points[j].preset then
          caps[i].points[j].preset = 1
        end
      end
      caps[i].method = nil
      caps[i].value = nil
      caps[i].after = nil
    end
  end
end
function ReforgeLite:UpgradeDB ()
  if not ReforgeLiteDB then
    ReforgeLiteDB = DefaultDB
  else
    MergeTables (ReforgeLiteDB, DefaultDB)
  end
  local db = ReforgeLiteDB
  if db.profiles[self.dbkey] == nil then
    db.profiles[self.dbkey] = DefaultDBProfile
  else
    MergeTables (db.profiles[self.dbkey], DefaultDBProfile)
  end
  local pdb = db.profiles[self.dbkey]
  if pdb.method and pdb.method.items then
    pdb.method.items[17] = nil
  end
  pdb.storedMethod = nil
  for k, v in pairs (pdb) do
    if db[k] ~= nil then
      pdb[k] = db[k]
      db[k] = nil
    end
  end
  if db.statCaps then
    pdb.caps = db.statCaps
    db.statCaps = nil
  end
  if db.statWeights then
    pdb.weights = db.statWeights
    db.statWeights = nil
  end
  self:UpgradeDBCaps (pdb.caps)
  db.convertSpirit = nil
  if pdb.method then
    pdb.method.caps = nil
    pdb.method.weights = nil
  end
  if pdb.prio then
    for i = 1, #pdb.prio do
      if pdb.prio[i] then
        pdb.prio[i].preset = pdb.prio[i].preset or 1
        pdb.prio[i].value = pdb.prio[i].value or 0
      else
        pdb.prio[i] = {stat = 0, capped = false, preset = 1, value = 0}
      end
    end
  end
end

-----------------------------------------------------------------

StaticPopupDialogs["REFORGE_LITE_SAVE_PRESET"] = {
  preferredIndex = STATICPOPUP_NUMDIALOGS,
  text = L["Enter the preset name"],
  button1 = ACCEPT,
  button2 = CANCEL,
  hasEditBox = true,
  maxLetters = 31,
  OnAccept = function (self)
    local name = self.editBox:GetText ()
    ReforgeLite.db.customPresets[name] = {
      caps = DeepCopy (ReforgeLite.pdb.caps),
      weights = DeepCopy (ReforgeLite.pdb.weights),
      prio = DeepCopy(ReforgeLite.pdb.prio)
    }
    ReforgeLite.deletePresetButton:Enable ()
  end,
  EditBoxOnEnterPressed = function (self)
    local name = self:GetParent ().editBox:GetText ()
    if name ~= "" then
      ReforgeLite.db.customPresets[name] = {
        caps = DeepCopy (ReforgeLite.pdb.caps),
        weights = DeepCopy (ReforgeLite.pdb.weights),
        prio = DeepCopy(ReforgeLite.pdb.prio)
      }
      ReforgeLite.deletePresetButton:Enable ()
      self:GetParent ():Hide ()
    end
  end,
  EditBoxOnTextChanged = function (self, data)
    if data ~= "" then
      self:GetParent ().button1:Enable ()
    else
      self:GetParent ().button1:Disable ()
    end
  end,
  EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide();
    end,
  OnShow = function (self)
    self.editBox:SetText ("")
    self.button1:Disable ()
    self.editBox:SetFocus ()
  end,
  OnHide = function (self)
    ChatEdit_FocusActiveWindow ()
    self.editBox:SetText ("")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true
}

StaticPopupDialogs["REFORGE_LITE_SAVE_METHOD_PRESET"] = {
  preferredIndex = STATICPOPUP_NUMDIALOGS,
  text = L["Enter the preset name"],
  button1 = ACCEPT,
  button2 = CANCEL,
  hasEditBox = true,
  maxLetters = 31,
  OnAccept = function (self)
    local name = self.editBox:GetText ()
    ReforgeLite.pdb.customMethodPresets[name] = DeepCopy(ReforgeLite.pdb.method)
    ReforgeLite.methodPresetsButton:Enable ()
    ReforgeLite.deleteMethodPresetButton:Enable ()
  end,
  EditBoxOnEnterPressed = function (self)
    local name = self:GetParent ().editBox:GetText ()
    if name ~= "" then
      ReforgeLite.pdb.customMethodPresets[name] = DeepCopy(ReforgeLite.pdb.method)
      ReforgeLite.methodPresetsButton:Enable ()
      ReforgeLite.deleteMethodPresetButton:Enable ()
      self:GetParent ():Hide ()
    end
  end,
  EditBoxOnTextChanged = function (self, data)
    if data ~= "" then
      self:GetParent ().button1:Enable ()
    else
      self:GetParent ().button1:Disable ()
    end
  end,
  EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide();
    end,
  OnShow = function (self)
    self.editBox:SetText ("")
    self.button1:Disable ()
    self.editBox:SetFocus ()
  end,
  OnHide = function (self)
    ChatEdit_FocusActiveWindow ()
    self.editBox:SetText ("")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true
}

if MOP then
  ReforgeLite.itemSlots = {
    "HeadSlot",
    "NeckSlot",
    "ShoulderSlot",
    "BackSlot",
    "ChestSlot",
    "WristSlot",
    "HandsSlot",
    "WaistSlot",
    "LegsSlot",
    "FeetSlot",
    "Finger0Slot",
    "Finger1Slot",
    "Trinket0Slot",
    "Trinket1Slot",
    "MainHandSlot",
    "SecondaryHandSlot"
  }
else
  ReforgeLite.itemSlots = {
    "HeadSlot",
    "NeckSlot",
    "ShoulderSlot",
    "BackSlot",
    "ChestSlot",
    "WristSlot",
    "HandsSlot",
    "WaistSlot",
    "LegsSlot",
    "FeetSlot",
    "Finger0Slot",
    "Finger1Slot",
    "Trinket0Slot",
    "Trinket1Slot",
    "MainHandSlot",
    "SecondaryHandSlot",
    "RangedSlot"
  }
end

local function RatingStat (i, name_, tip_, id_, hid_)
  if hid_ then
    local _, class = UnitClass ("player")
    if class == "HUNTER" then
      id_ = hid_
    end
  end
  return {
    name = name_,
    tip = L[tip_],
    long = L[tip_ .. "Long"],
    getter = function ()
      return (GetCombatRating (id_))
    end,
    mgetter = function (method, orig)
      return (orig and method.orig_stats and method.orig_stats[i]) or method.stats[i]
    end
  }
end
ReforgeLite.itemStats = {
  {
    name = "ITEM_MOD_SPIRIT_SHORT",
    tip = L["Spirit"],
    long = L["SpiritLong"],
    getter = function ()
      return (select (2, UnitStat ("player", 5)))
    end,
    mgetter = function (method, orig)
      return (orig and method.orig_stats and method.orig_stats[1]) or method.stats[1]
    end
  },
  RatingStat (2, "ITEM_MOD_DODGE_RATING_SHORT", "Dodge", CR_DODGE),
  RatingStat (3, "ITEM_MOD_PARRY_RATING_SHORT", "Parry", CR_PARRY),
  {
    name = "ITEM_MOD_HIT_RATING_SHORT",
    tip = L["Hit"],
    long = L["HitLong"],
    getter = function()
      local result = GetCombatRating(class == "HUNTER" and CR_HIT_RANGED or CR_HIT_SPELL)
      local conv = ReforgeLite:GetConversion()
      if conv[ReforgeLite.STATS.EXP] and conv[ReforgeLite.STATS.EXP][ReforgeLite.STATS.HIT] then
        result = result + math.floor(GetCombatRating(CR_EXPERTISE) * conv[ReforgeLite.STATS.EXP][ReforgeLite.STATS.HIT])
      end
      return result
    end,
    mgetter = function (method, orig)
      return (orig and method.orig_stats and method.orig_stats[4]) or method.stats[4]
    end
  },
  RatingStat (5, "ITEM_MOD_CRIT_RATING_SHORT", "Crit", CR_CRIT_SPELL, CR_CRIT_RANGED),
  {
    name = "ITEM_MOD_HASTE_RATING_SHORT",
    tip = L["Haste"],
    long = L["HasteLong"],
    getter = function()
      local result = GetCombatRating(class == "HUNTER" and CR_HASTE_RANGED or CR_HASTE_SPELL)
      if class == "MONK" and GetShapeshiftFormID() == 20 then
        result = math.floor(result / 1.5 + 0.5)
      end
      return result
    end,
    mgetter = function (method, orig)
      return (orig and method.orig_stats and method.orig_stats[6]) or method.stats[6]
    end
  },
  RatingStat (7, "ITEM_MOD_EXPERTISE_RATING_SHORT", "Exp", CR_EXPERTISE),
  RatingStat (8, "ITEM_MOD_MASTERY_RATING_SHORT", "Mastery", CR_MASTERY)
}
ReforgeLite.STATS = {
  SPIRIT = 1, DODGE = 2, PARRY = 3, HIT = 4, CRIT = 5, HASTE = 6, EXP = 7, MASTERY = 8, SPELLHIT = 9, BLOCK = 10, CRITBLOCK = 11
}

ReforgeLite.REFORGE_TABLE_BASE = 112
ReforgeLite.reforgeTable = {
  {1, 2}, {1, 3}, {1, 4}, {1, 5}, {1, 6}, {1, 7}, {1, 8},
  {2, 1}, {2, 3}, {2, 4}, {2, 5}, {2, 6}, {2, 7}, {2, 8},
  {3, 1}, {3, 2}, {3, 4}, {3, 5}, {3, 6}, {3, 7}, {3, 8},
  {4, 1}, {4, 2}, {4, 3}, {4, 5}, {4, 6}, {4, 7}, {4, 8},
  {5, 1}, {5, 2}, {5, 3}, {5, 4}, {5, 6}, {5, 7}, {5, 8},
  {6, 1}, {6, 2}, {6, 3}, {6, 4}, {6, 5}, {6, 7}, {6, 8},
  {7, 1}, {7, 2}, {7, 3}, {7, 4}, {7, 5}, {7, 6}, {7, 8},
  {8, 1}, {8, 2}, {8, 3}, {8, 4}, {8, 5}, {8, 6}, {8, 7},
}

local REFORGE_COEFF = 0.4

function ReforgeLite:UpdateWindowSize ()
  self.db.windowWidth = self:GetWidth ()
  self.db.windowHeight = self:GetHeight ()
end

function ReforgeLite:GetCapScore (cap, value)
  local score = 0
  for i = #cap.points, 1, -1 do
    if value > cap.points[i].value then
      score = score + cap.points[i].after * (value - cap.points[i].value)
      value = cap.points[i].value
    end
  end
  score = score + self.pdb.weights[cap.stat] * value
  return score
end
function ReforgeLite:GetStatScore (stat, value)
  if stat == self.pdb.caps[1].stat then
    return self:GetCapScore (self.pdb.caps[1], value)
  elseif stat == self.pdb.caps[2].stat then
    return self:GetCapScore (self.pdb.caps[2], value)
  else
    return self.pdb.weights[stat] * value
  end
end

function ReforgeLite:ParsePawnString (pawn)
  local pos, _, version, name, values = strfind (pawn, "^%s*%(%s*Pawn%s*:%s*v(%d+)%s*:%s*\"([^\"]+)\"%s*:%s*(.+)%s*%)%s*$")
  version = tonumber (version)
  if not (pos and version and name and values) or name == "" or values == "" or version > 1 then
    return
  end

  local raw = {}
  local average = 0
  local total = 0
  gsub (values .. ",", "[^,]*,", function (pair)
    local pos, _, stat, value = strfind (pair, "^%s*([%a%d]+)%s*=%s*(%-?[%d%.]+)%s*,$")
    value = tonumber (value)
    if pos and stat and stat ~= "" and value then
      raw[stat] = value
      average = average + value
      total = total + 1
    end
  end)
  local factor = 1
  if average / total < 10 then
    factor = 100
  end
  for k, v in pairs (raw) do
    raw[k] = math.floor (v * factor + 0.5)
  end

  local weights = {}
  weights[self.STATS.SPIRIT] = raw["Spirit"] or 0
  weights[self.STATS.DODGE] = raw["DodgeRating"] or 0
  weights[self.STATS.PARRY] = raw["ParryRating"] or 0
  weights[self.STATS.HIT] = raw["HitRating"] or 0
  weights[self.STATS.CRIT] = raw["CritRating"] or 0
  weights[self.STATS.HASTE] = raw["HasteRating"] or 0
  weights[self.STATS.EXP] = raw["ExpertiseRating"] or 0
  weights[self.STATS.MASTERY] = raw["MasteryRating"] or 0

  self:SetStatWeights (weights)
end

StaticPopupDialogs["REFORGE_LITE_PARSE_PAWN"] = {
  preferredIndex = STATICPOPUP_NUMDIALOGS,
  text = L["Enter pawn string"],
  button1 = ACCEPT,
  button2 = CANCEL,
  hasEditBox = true,
  editBoxWidth = 350,
  maxLetters = 1024,
  OnAccept = function (self)
    local pawn = self.editBox:GetText ()
    ReforgeLite:ParsePawnString (pawn)
  end,
  EditBoxOnEnterPressed = function (self)
    local pawn = self:GetParent ().editBox:GetText ()
    if pawn ~= "" then
      ReforgeLite:ParsePawnString (pawn)
      self:GetParent ():Hide ()
    end
  end,
  EditBoxOnTextChanged = function (self, data)
    if data ~= "" then
      self:GetParent ().button1:Enable ()
    else
      self:GetParent ().button1:Disable ()
    end
  end,
  EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide();
    end,
  OnShow = function (self)
    self.editBox:SetText ("")
    self.button1:Disable ()
    self.editBox:SetFocus ()
  end,
  OnHide = function (self)
    ChatEdit_FocusActiveWindow ()
    self.editBox:SetText ("")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true
}

------------------------------------------------------------------------

function ReforgeLite:CreateCategory (name)
  local c = CreateFrame ("Frame", nil, self.content)
  c:ClearAllPoints ()
  c:SetWidth (16)
  c:SetHeight (16)
  c.expanded = true

  c.name = c:CreateFontString (nil, "OVERLAY", "GameFontNormal")
  c.catname = c.name
  c.name:SetPoint ("TOPLEFT", c, "TOPLEFT", 18, -1)
  c.name:SetTextColor (1, 1, 1)
  c.name:SetText (name)

  c.button = CreateFrame ("Button", nil, c)
  c.button:ClearAllPoints ()
  c.button:SetWidth (14)
  c.button:SetHeight (14)
  c.button:SetPoint ("TOPLEFT", c, "TOPLEFT", 0, 0)
  c.button:SetHighlightTexture ("Interface\\Buttons\\UI-PlusButton-Hilight")
  c.button.UpdateTexture = function (self)
    if self:GetParent ().expanded then
      self:SetNormalTexture ("Interface\\Buttons\\UI-MinusButton-Up")
      self:SetPushedTexture ("Interface\\Buttons\\UI-MinusButton-Down")
    else
      self:SetNormalTexture ("Interface\\Buttons\\UI-PlusButton-Up")
      self:SetPushedTexture ("Interface\\Buttons\\UI-PlusButton-Down")
    end
  end
  c.button:UpdateTexture ()
  c.button:SetScript ("OnClick", function (self)
    self:GetParent ():Toggle ()
  end)
  c.button.anchor = {point = "TOPLEFT", rel = c, relPoint = "TOPLEFT", x = 0, y = 0}

  c.frames = {}
  c.anchors = {}
  c.AddFrame = function (self, frame)
    table.insert (self.frames, frame)
    frame.Show2 = function (self)
      if self.category.expanded then
        self:Show ()
      end
      self.chidden = nil
    end
    frame.Hide2 = function (self)
      self:Hide ()
      self.chidden = true
    end
    frame.category = self
  end

  c.Toggle = function (self)
    self.expanded = not self.expanded
    if c.expanded then
      for k, v in pairs (self.frames) do
        if not v.chidden then
          v:Show ()
        end
      end
      for k, v in pairs (self.anchors) do
        v.frame:SetPoint (v.point, v.rel, v.relPoint, v.x, v.y)
      end
    else
      for k, v in pairs (self.frames) do
        v:Hide ()
      end
      for k, v in pairs (self.anchors) do
        v.frame:SetPoint (v.point, self.button, v.relPoint, v.x, v.y)
      end
    end
    self.button:UpdateTexture ()
    ReforgeLite:UpdateContentSize ()
  end

  return c
end

function ReforgeLite:SetAnchor (frame_, point_, rel_, relPoint_, offsX, offsY)
  if rel_ and rel_.catname and rel_.button then
    rel_ = rel_.button
  end
  if rel_.category then
    table.insert (rel_.category.anchors, {frame = frame_, point = point_, rel = rel_, relPoint = relPoint_, x = offsX, y = offsY})
    if rel_.category.expanded then
      frame_:SetPoint (point_, rel_, relPoint_, offsX, offsY)
    else
      frame_:SetPoint (point_, rel_.category.button, relPoint_, offsX, offsY)
    end
  else
    frame_:SetPoint (point_, rel_, relPoint_, offsX, offsY)
  end
  frame_.anchor = {point = point_, rel = rel_, relPoint = relPoint_, x = offsX, y = offsY}
end
function ReforgeLite:GetFrameY (frame)
  local cur = frame
  local offs = 0
  while cur and cur ~= self.content do
    if cur.anchor == nil then
      return offs
    end
    if cur.anchor.point:find ("BOTTOM") then
      offs = offs + cur:GetHeight ()
    end
    local rel = cur.anchor.rel
    if rel.category and not rel.category.expanded then
      rel = rel.category.button
    end
    if cur.anchor.relPoint:find ("BOTTOM") then
      offs = offs - rel:GetHeight ()
    end
    offs = offs + cur.anchor.y
    cur = rel
  end
  return offs
end

local function SetTextDelta (text, value, cur, override, percent)
  override = override or (value - cur)
  if override == 0 then
    text:SetTextColor (0.7, 0.7, 0.7)
  elseif override > 0 then
    text:SetTextColor (0.6, 1, 0.6)
  else
    text:SetTextColor (1, 0.4, 0.4)
  end
  if percent then
    text:SetText (string.format ("%+.2f%%", value - cur))
  else
    text:SetText (string.format ("%+d", value - cur))
  end
end

------------------------------------------------------------------------

function ReforgeLite:SetScroll (value)
  local viewheight = self.scrollFrame:GetHeight ()
  local height = self.content:GetHeight ()
  local offset

  if viewheight > height then
    offset = 0
  else
    offset = math.floor ((height - viewheight) / 1000 * value)
  end
  self.content:ClearAllPoints ()
  self.content:SetPoint ("TOPLEFT", 0, offset)
  self.content:SetPoint ("TOPRIGHT", 0, offset)
  self.scrollOffset = offset
  self.scrollValue = value
end
function ReforgeLite:MoveScroll (value)
  local viewheight = self.scrollFrame:GetHeight ()
  local height = self.content:GetHeight ()
  if self.scrollBarShown then
    local diff = height - viewheight
    local delta = (value > 0 and -1 or 1)
    self.scrollBar:SetValue (min (max (self.scrollValue + delta * (1000 / (diff / 45)), 0), 1000))
  end
end
function ReforgeLite:FixScroll ()
  self:SetScript ("OnUpdate", nil)

  local offset = self.scrollOffset
  local viewheight = self.scrollFrame:GetHeight ()
  local height = self.content:GetHeight ()
  if height < viewheight + 2 then
    if self.scrollBarShown then
      self.scrollBarShown = false
      self.scrollBar:Hide ()
      self.scrollBar:SetValue (0)
    end
  else
    if not self.scrollBarShown then
      self.scrollBarShown = true
      self.scrollBar:Show ()
    end
    local value = (offset / (height - viewheight) * 1000)
    if value > 1000 then value = 1000 end
    self.scrollBar:SetValue (value)
    self:SetScroll (value)
    if value < 1000 then
      self.content:ClearAllPoints ()
      self.content:SetPoint ("TOPLEFT", 0, offset)
      self.content:SetPoint ("TOPRIGHT", 0, offset)
    end
  end
end

function ReforgeLite:CreateFrame (title, width, height)
  self.initialized = true
  local title = "Reforge Lite"
  self:SetFrameStrata ("DIALOG")
  self:ClearAllPoints ()
  self:SetWidth (self.db.windowWidth)
  self:SetHeight (self.db.windowHeight)
  self:SetMinResize (780, 500)
  self:SetMaxResize (1000, 800)
  if self.db.windowX and self.db.windowY then
    self:SetPoint ("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.windowX, self.db.windowY)
  else
    self:SetPoint ("CENTER")
  end
  self:SetBackdrop ({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
    edgeFile = AddonPath .. "textures\\frameborder", edgeSize = 32,
    insets = {left = 1, right = 1, top = 20, bottom = 1}
  })
  self:SetBackdropBorderColor (unpack (self.db.activeWindowTitle))
  self:SetBackdropColor (0.1, 0.1, 0.1)

  self:EnableMouse (true)
  self:SetMovable (true)
  self:SetResizable (true)
  self:SetScript ("OnMouseDown", function (self, arg)
    if self.methodWindow and self:GetFrameLevel () < self.methodWindow:GetFrameLevel () then
      self:SetFrameLevel (self.methodWindow:GetFrameLevel () + 10)
      self:SetBackdropBorderColor (unpack (self.db.activeWindowTitle))
      self.methodWindow:SetBackdropBorderColor (unpack (self.db.inactiveWindowTitle))
    end
    if arg == "LeftButton" then
      self:StartMoving ()
      self.moving = true
    end
  end)
  self:SetScript ("OnMouseUp", function (self)
    if self.moving then
      self:StopMovingOrSizing ()
      self.moving = false
      self.db.windowX = self:GetLeft ()
      self.db.windowY = self:GetTop ()
    end
  end)

  self.title = self:CreateFontString (nil, "OVERLAY", "GameFontNormal")
  self.title:SetPoint ("TOPLEFT", self, "TOPLEFT", 6, -15)
  self.title:SetTextColor (1, 1, 1)
  self.title:SetText (title)

  self.close = CreateFrame ("Button", nil, self)
  self.close:SetNormalTexture ("Interface\\Buttons\\UI-Panel-MinimizeButton-Up.blp")
  self.close:SetPushedTexture ("Interface\\Buttons\\UI-Panel-MinimizeButton-Down.blp")
  self.close:SetHighlightTexture ("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
  self.close:SetWidth (20)
  self.close:SetHeight (20)
  self.close:SetPoint ("TOPRIGHT", self, "TOPRIGHT", -4, -12)
  self.close:SetScript ("OnClick", function (self)
    self:GetParent ():Hide ()
  end)

  self.leftGrip = CreateFrame ("Button", nil, self)
  self.leftGrip:SetNormalTexture (AddonPath .. "textures\\leftgrip")
  self.leftGrip:SetHighlightTexture (AddonPath .. "textures\\leftgrip")
  self.leftGrip:SetWidth (20)
  self.leftGrip:SetHeight (20)
  self.leftGrip:SetPoint ("BOTTOMLEFT", self, "BOTTOMLEFT", -4, -4)
  self.leftGrip:SetScript ("OnMouseDown", function (self, arg)
    if arg == "LeftButton" then
      self:GetParent ():StartSizing ("BOTTOMLEFT")
      self:GetParent ().sizing = true
    end
  end)
  self.leftGrip:SetScript ("OnMouseUp", function (self)
    if self:GetParent ().sizing then
      self:GetParent ():StopMovingOrSizing ()
      self:GetParent ().sizing = false
      self:GetParent ():UpdateWindowSize ()
    end
  end)

  self.rightGrip = CreateFrame ("Button", nil, self)
  self.rightGrip:SetNormalTexture (AddonPath .. "textures\\rightGrip")
  self.rightGrip:SetHighlightTexture (AddonPath .. "textures\\rightGrip")
  self.rightGrip:SetWidth (20)
  self.rightGrip:SetHeight (20)
  self.rightGrip:SetPoint ("BOTTOMRIGHT", self, "BOTTOMRIGHT", 4, -4)
  self.rightGrip:SetScript ("OnMouseDown", function (self, arg)
    if arg == "LeftButton" then
      self:GetParent ():StartSizing ("BOTTOMRIGHT")
      self:GetParent ().sizing = true
    end
  end)
  self.rightGrip:SetScript ("OnMouseUp", function (self)
    if self:GetParent ().sizing then
      self:GetParent ():StopMovingOrSizing ()
      self:GetParent ().sizing = false
      self:GetParent ():UpdateWindowSize ()
    end
  end)

  self:CreateItemTable ()

  self.scrollValue = 0
  self.scrollOffset = 0
  self.scrollBarShown = false

  self.scrollFrame = CreateFrame ("ScrollFrame", nil, self)
  self.scrollFrame:ClearAllPoints ()
  self.scrollFrame:SetPoint ("LEFT", self.itemTable, "RIGHT", 10, 0)
  self.scrollFrame:SetPoint ("TOP", self, "TOP", 0, -40)
  self.scrollFrame:SetPoint ("BOTTOMRIGHT", self, "BOTTOMRIGHT", -22, 15)
  self.scrollFrame:EnableMouseWheel (true)
  self.scrollFrame:SetScript ("OnMouseWheel", function (self, value)
    ReforgeLite:MoveScroll (value)
  end)
  self.scrollFrame:SetScript ("OnSizeChanged", function (self)
    ReforgeLite:SetScript ("OnUpdate", ReforgeLite.FixScroll)
  end)

  self.scrollBar = CreateFrame ("Slider", "ReforgeLiteScrollBar", self.scrollFrame, "UIPanelScrollBarTemplate")
  self.scrollBar:SetPoint ("TOPLEFT", self.scrollFrame, "TOPRIGHT", 4, -16)
  self.scrollBar:SetPoint ("BOTTOMLEFT", self.scrollFrame, "BOTTOMRIGHT", 4, 16)
  self.scrollBar:SetMinMaxValues (0, 1000)
  self.scrollBar:SetValueStep (1)
  self.scrollBar:SetValue (0)
  self.scrollBar:SetWidth (16)
  self.scrollBar:SetScript ("OnValueChanged", function (self, value)
    ReforgeLite:SetScroll (value)
  end)
  self.scrollBar:Hide ()

  self.scrollBg = self.scrollBar:CreateTexture (nil, "BACKGROUND")
  self.scrollBg:SetAllPoints (self.scrollBar)
  self.scrollBg:SetTexture (0, 0, 0, 0.4)

  self.content = CreateFrame ("Frame", nil, self.scrollFrame)
  self.scrollFrame:SetScrollChild (self.content)
  self.content:ClearAllPoints ()
  self.content:SetPoint ("TOPLEFT")
  self.content:SetPoint ("TOPRIGHT")
  self.content:SetHeight (1000)

  GUI.defaultParent = self.content

  self:CreateOptionList ()

  self:SetScript ("OnUpdate", self.FixScroll)
end

function ReforgeLite:CreateItemTable ()
  local lockTip = self:CreateFontString (nil, "OVERLAY", "GameFontNormal")
  lockTip:SetPoint ("TOPLEFT", self, "TOPLEFT", 12, -40)
  lockTip:SetTextColor (1, 1, 1)
  lockTip:SetText (L["Click an item to lock it"])

  self.itemTable = GUI:CreateTable (#self.itemSlots + 1, #self.itemStats, self.db.itemSize, self.db.itemSize + 4, {0.5, 0.5, 0.5, 1}, self)
  self.itemTable:SetPoint ("TOPLEFT", lockTip, "BOTTOMLEFT", 0, -10)
  self.itemTable:SetPoint ("BOTTOM", self, "BOTTOM", 0, 10)
  self.itemTable:SetWidth (400)


  for i, v in ipairs (self.itemStats) do
    self.itemTable:SetCellText (0, i, v.tip)
  end
  self.itemData = {}
  for i, v in ipairs (self.itemSlots) do
    self.itemData[i] = CreateFrame ("Frame", nil, self.itemTable)
    self.itemData[i].slot = v
    self.itemData[i]:ClearAllPoints ()
    self.itemData[i]:SetWidth (self.db.itemSize)
    self.itemData[i]:SetHeight (self.db.itemSize)
    self.itemTable:SetCell (i, 0, self.itemData[i])
    self.itemData[i]:EnableMouse (true)
    self.itemData[i]:SetScript ("OnEnter", function (self)
      GameTooltip:SetOwner (self, "ANCHORLEFT")
      local hasItem, hasCooldown, repairCost = GameTooltip:SetInventoryItem ("player", self.slotId)
      if not hasItem then
        local text = _G[strupper (self.slot)]
        if self.checkRelic then
          text = _G["RELICSLOT"]
        end
        GameTooltip:SetText (text)
      end
      GameTooltip:Show ()
    end)
    self.itemData[i]:SetScript ("OnLeave", function (self)
      GameTooltip:Hide ()
    end)
    self.itemData[i]:SetScript ("OnMouseDown", function ()
      self.pdb.itemsLocked[i] = not self.pdb.itemsLocked[i]
      if self.pdb.itemsLocked[i] then
        self.itemData[i].locked:Show ()
      else
        self.itemData[i].locked:Hide ()
      end
    end)
    self.itemData[i].slotId, self.itemData[i].slotTexture, self.itemData[i].checkRelic = GetInventorySlotInfo (v)
    self.itemData[i].checkRelic = self.itemData[i].checkRelic and UnitHasRelicSlot ("player")
    if self.itemData[i].checkRelic then
      self.itemData[i].slotTexture = "Interface\\Paperdoll\\UI-PaperDoll-Slot-Relic.blp"
    end
    self.itemData[i].texture = self.itemData[i]:CreateTexture (nil, "ARTWORK")
    self.itemData[i].texture:SetAllPoints (self.itemData[i])
    self.itemData[i].texture:SetTexture (self.itemData[i].slotTexture)
    self.itemData[i].locked = self.itemData[i]:CreateTexture (nil, "OVERLAY")
    self.itemData[i].locked:SetAllPoints (self.itemData[i])
    self.itemData[i].locked:SetTexture ("Interface\\PaperDollInfoFrame\\UI-GearManager-LeaveItem-Transparent")
    if not self.pdb.itemsLocked[i] then
      self.itemData[i].locked:Hide ()
    end

    self.itemData[i].stats = {}
    for j, s in ipairs (self.itemStats) do
      self.itemData[i].stats[j] = self.itemTable:CreateFontString (nil, "OVERLAY", "GameFontNormalSmall")
      self.itemTable:SetCell (i, j, self.itemData[i].stats[j])
      self.itemData[i].stats[j]:SetTextColor (0.8, 0.8, 0.8)
      self.itemData[i].stats[j]:SetText ("-")
    end
  end
  self.statTotals = {}
  self.itemTable:SetCellText (#self.itemSlots + 1, 0, L["Sum"], "CENTER", {1, 0.8, 0})
  for i, v in ipairs (self.itemStats) do
    self.statTotals[i] = self.itemTable:CreateFontString (nil, "OVERLAY", "GameFontNormalSmall")
    self.itemTable:SetCell (#self.itemSlots + 1, i, self.statTotals[i])
    self.statTotals[i]:SetTextColor (1, 0.8, 0)
    self.statTotals[i]:SetText ("0")
  end
end

function ReforgeLite:CreateOptionList ()
  self:CreateTaskUI()

  self.computeButton = CreateFrame ("Button", "ReforgeLiteConfirmButton", self.content, "UIPanelButtonTemplate")
  self.computeButton:SetWidth (114)
  self.computeButton:SetHeight (22)
  self.computeButton:SetText (L["Compute"])
  self.computeButton:SetScript ("OnClick", function ()
    local method = self:Compute ()
    local curScore = (method and (self:GetMethodScore(method) - self:GetMethodPenalty(method)) or -500000)
    local oldScore = (self.pdb.method and (self:GetMethodScore(self.pdb.method) - self:GetMethodPenalty(self.pdb.method)) or -500000)
    if self.pdb.method and not self:IsMethodValid(self.pdb.method) then
      oldScore = -1000000
    end
    if curScore > oldScore then
      self.pdb.method = method
      self:UpdateMethodCategory()
      self.methodOverride = {}
      for i = 1, #self.itemSlots do
        self.methodOverride[i] = 0
      end
      self:UpdateMethodChecks()
    end
  end)

  self:UpdateTask ()

  self.quality = CreateFrame ("Slider", nil, self.content)
  self:SetAnchor (self.quality, "LEFT", self.computeButton, "RIGHT", 15, 0)
  self.quality:SetOrientation ("HORIZONTAL")
  self.quality:SetWidth (150)
  self.quality:SetHeight (15)
  self.quality:SetHitRectInsets (0, 0, -10, 0)
  self.quality:SetBackdrop ({bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
    edgeFile = "Interface\\Buttons\\UI-SliderBar-Border", tile = true, tileSize = 8, edgeSize = 8,
    insets = {left = 3, right = 3, top = 6, bottom = 6}
  })
  self.quality:SetThumbTexture ("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
  self.quality:SetMinMaxValues (1, 20)
  self.quality:SetValueStep (1)
  self.quality:SetValue (self.db.reforgeCheat)
  self.quality:EnableMouseWheel (false)
  self.quality:SetScript ("OnValueChanged", function (self)
    ReforgeLite.db.reforgeCheat = self:GetValue ()
  end)

  self.quality.label = self.quality:CreateFontString (nil, "OVERLAY", "GameFontNormal")
  self.quality.label:SetPoint ("BOTTOM", self.quality, "TOP", 0, 0)
  self.quality.label:SetTextColor (1, 1, 1)
  self.quality.label:SetText (L["Speed"])
  self.quality.lowtext = self.quality:CreateFontString (nil, "ARTWORK", "GameFontHighlightSmall")
  self.quality.lowtext:SetPoint ("TOPLEFT", self.quality, "BOTTOMLEFT", 2, 3)
  self.quality.lowtext:SetText ("1")
  self.quality.hightext = self.quality:CreateFontString (nil, "ARTWORK", "GameFontHighlightSmall")
  self.quality.hightext:SetPoint ("TOPRIGHT", self.quality, "BOTTOMRIGHT", -2, 3)
  self.quality.hightext:SetText ("20")

  self.quality:Hide()

  self.settingsCategory = self:CreateCategory (L["Settings"])
  self:SetAnchor (self.settingsCategory, "TOPLEFT", self.computeButton, "BOTTOMLEFT", 0, -10)
  self.settings = GUI:CreateTable (4, 1, nil, 200)
  self.settingsCategory:AddFrame (self.settings)
  self:SetAnchor (self.settings, "TOPLEFT", self.settingsCategory, "BOTTOMLEFT", 0, -5)
  self.settings:SetPoint ("RIGHT", self.content, "RIGHT", -10, 0)
  self.settings:SetRowHeight (self.db.itemSize + 2)

  self:FillSettings ()
  self.settingsCategory:Toggle ()

  self.lastElement = CreateFrame ("Frame", nil, self.content)
  self.lastElement:ClearAllPoints ()
  self.lastElement:SetWidth (0)
  self.lastElement:SetHeight (0)
  self:SetAnchor (self.lastElement, "TOPLEFT", self.settings, "BOTTOMLEFT", 0, -10)
  self:UpdateContentSize ()

  if not self.pdb.method then
    ReforgeLite:ResetMethod()
  end
  if self.pdb.method then
    ReforgeLite:UpdateMethodCategory ()
  end
end
function ReforgeLite:FillSettings ()
  self.settings:SetCell (1, 0, GUI:CreateCheckButton (self.settings, L["Open window when reforging"],
    self.db.openOnReforge, function (val) self.db.openOnReforge = val or false end), "LEFT")
--  self.settings:SetCell (2, 0, GUI:CreateCheckButton (self.settings, L["Show reforged stats in item tooltips"],
--    self.db.updateTooltip, function (val) self.db.updateTooltip = val or false end), "LEFT")

  self.settings:SetCellText (2, 0, L["Active window color"], "LEFT", nil, "GameFontNormal")
  self.settings:SetCell (2, 1, GUI:CreateColorPicker (self.settings, 20, 20, self.db.activeWindowTitle, function ()
    if self.methodWindow and self.methodWindow:IsShown () and self.methodWindow:GetFrameLevel () > self:GetFrameLevel () then
      self.methodWindow:SetBackdropBorderColor (unpack (self.db.activeWindowTitle))
    else
      self:SetBackdropBorderColor (unpack (self.db.activeWindowTitle))
    end
  end), "LEFT")

  self.settings:SetCellText (3, 0, L["Inactive window color"], "LEFT", nil, "GameFontNormal")
  self.settings:SetCell (3, 1, GUI:CreateColorPicker (self.settings, 20, 20, self.db.inactiveWindowTitle, function ()
    if self.methodWindow and self.methodWindow:IsShown () and self.methodWindow:GetFrameLevel () > self:GetFrameLevel () then
      self:SetBackdropBorderColor (unpack (self.db.inactiveWindowTitle))
    elseif self.methodWindow then
      self.methodWindow:SetBackdropBorderColor (unpack (self.db.inactiveWindowTitle))
    end
  end), "LEFT")

  self.debugButton = CreateFrame ("Button", "ReforgeLiteDebugButton", self.settings, "UIPanelButtonTemplate")
  self.debugButton:SetWidth (114)
  self.debugButton:SetHeight (22)
  self.debugButton:SetText (L["Debug"])
  self.debugButton:SetScript ("OnClick", function (self)
    ReforgeLite:DebugMethod ()
  end)
  self.settings:SetCell (4, 0, self.debugButton, "LEFT")
end
function ReforgeLite:GetCurrentScore ()
  local score = 0
  for i = 1, #self.itemStats do
    score = score + self:GetStatScore (i, self.itemStats[i].getter ())
  end
  return score
end
function ReforgeLite:UpdateMethodCategory ()
  if self.methodCategory == nil then
    self.methodCategory = self:CreateCategory (L["Result"])
    self:SetAnchor (self.methodCategory, "TOPLEFT", self.computeButton, "BOTTOMLEFT", 0, -10)

    self.methodPresetsButton = GUI:CreateImageButton (self.content, 24, 24, "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
      "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down", "Interface\\Buttons\\UI-Common-MouseHilight", function ()
      if next(self.pdb.customMethodPresets) then
        ToggleDropDownMenu (1, nil, self.methodPresetMenu, self.methodPresetsButton:GetName (), 0, 0)
      end
    end)
    self.methodCategory:AddFrame(self.methodPresetsButton)
    self:SetAnchor (self.methodPresetsButton, "TOPLEFT", self.methodCategory, "BOTTOMLEFT", 0, -5)
    self.methodPresetsButton.tip = self.methodPresetsButton:CreateFontString (nil, "OVERLAY", "GameFontNormal")
    self.methodPresetsButton.tip:SetPoint ("LEFT", self.methodPresetsButton, "RIGHT", 5, 0)
    self.methodPresetsButton.tip:SetText (L["Presets"])
    if next(self.pdb.customMethodPresets) == nil then
      self.methodPresetsButton:Disable()
    end

    self.saveMethodPresetButton = CreateFrame ("Button", "ReforgeLiteSaveMethodPresetButton", self.content, "UIPanelButtonTemplate")
    self.methodCategory:AddFrame (self.saveMethodPresetButton)
    self.saveMethodPresetButton:SetWidth (114)
    self.saveMethodPresetButton:SetHeight (22)
    self.saveMethodPresetButton:SetText (L["Save"])
    self.saveMethodPresetButton:SetScript ("OnClick", function (self)
      StaticPopup_Show ("REFORGE_LITE_SAVE_METHOD_PRESET")
    end)
    self:SetAnchor (self.saveMethodPresetButton, "LEFT", self.methodPresetsButton.tip, "RIGHT", 8, 0)

    self.deleteMethodPresetButton = CreateFrame ("Button", "ReforgeLiteDeleteMethodPresetButton", self.content, "UIPanelButtonTemplate")
    self.methodCategory:AddFrame (self.deleteMethodPresetButton)
    self.deleteMethodPresetButton:SetWidth (114)
    self.deleteMethodPresetButton:SetHeight (22)
    self.deleteMethodPresetButton:SetText (L["Delete"])
    self.deleteMethodPresetButton:SetScript ("OnClick", function ()
      if next (self.pdb.customMethodPresets) then
        ToggleDropDownMenu (1, nil, self.methodPresetDelMenu, self.deleteMethodPresetButton:GetName (), 0, 0)
      end
    end)
    self:SetAnchor (self.deleteMethodPresetButton, "LEFT", self.saveMethodPresetButton, "RIGHT", 5, 0)
    if next (self.pdb.customMethodPresets) == nil then
      self.deleteMethodPresetButton:Disable ()
    end

    self.methodImportButton = CreateFrame ("Button", "ReforgeLiteImportMethodButton", self.content, "UIPanelButtonTemplate")
    self.methodCategory:AddFrame(self.methodImportButton)
    self.methodImportButton:SetWidth(114)
    self.methodImportButton:SetHeight(22)
    self.methodImportButton:SetText(L["Import"])
    self.methodImportButton:SetScript("OnClick", function ()
--      ToggleDropDownMenu(1, nil, self.methodImportMenu, self.methodImportButton:GetName(), 0, 0)
      self:RunImport(self.ParseWowReforge)
    end)
    self:SetAnchor(self.methodImportButton, "TOPLEFT", self.methodPresetsButton, "BOTTOMLEFT", 0, -5)

    self.methodStats = GUI:CreateTable (#self.itemStats, 2, self.db.itemSize, 60, {0.5, 0.5, 0.5, 1})
    self.methodCategory:AddFrame (self.methodStats)
    self:SetAnchor (self.methodStats, "TOPLEFT", self.methodImportButton, "BOTTOMLEFT", 0, -5)
    self.methodStats:SetRowHeight (self.db.itemSize + 2)
    self.methodStats:SetColumnWidth (60)

    self.methodStats:SetCellText (0, 0, L["Score"], "LEFT", {1, 0.8, 0})
    self.methodStats.score = self.methodStats:CreateFontString (nil, "OVERLAY", "GameFontNormalSmall")
    self.methodStats:SetCell (0, 1, self.methodStats.score)
    self.methodStats.score:SetTextColor (1, 0.8, 0)
    self.methodStats.score:SetText ("0")
    self.methodStats.scoreDelta = self.methodStats:CreateFontString (nil, "OVERLAY", "GameFontNormalSmall")
    self.methodStats:SetCell (0, 2, self.methodStats.scoreDelta)
    self.methodStats.scoreDelta:SetTextColor (0.7, 0.7, 0.7)
    self.methodStats.scoreDelta:SetText ("+0")

    for i, v in ipairs (self.itemStats) do
      self.methodStats:SetCellText (i, 0, v.tip, "LEFT")

      self.methodStats[i] = {}

      self.methodStats[i].value = self.methodStats:CreateFontString (nil, "OVERLAY", "GameFontNormalSmall")
      self.methodStats:SetCell (i, 1, self.methodStats[i].value)
      self.methodStats[i].value:SetTextColor (1, 1, 1)
      self.methodStats[i].value:SetText ("0")

      self.methodStats[i].delta = self.methodStats:CreateFontString (nil, "OVERLAY", "GameFontNormalSmall")
      self.methodStats:SetCell (i, 2, self.methodStats[i].delta)
      self.methodStats[i].delta:SetTextColor (0.7, 0.7, 0.7)
      self.methodStats[i].delta:SetText ("+0")
    end

    self.methodShow = CreateFrame ("Button", "ReforgeLiteMethodShowButton", self.content, "UIPanelButtonTemplate")
    self.methodShow:SetWidth (114)
    self.methodShow:SetHeight (22)
    self.methodShow:SetText (L["Show"])
    self.methodShow:SetScript ("OnClick", function (self)
      ReforgeLite:ShowMethodWindow ()
    end)
    self.methodCategory:AddFrame (self.methodShow)
    self:SetAnchor (self.methodShow, "TOPLEFT", self.methodStats, "BOTTOMLEFT", 0, -5)

    self.methodReset = CreateFrame ("Button", "ReforgeLiteMethodResetButton", self.content, "UIPanelButtonTemplate")
    self.methodReset:SetWidth (114)
    self.methodReset:SetHeight (22)
    self.methodReset:SetText (L["Reset"])
    self.methodReset:SetScript ("OnClick", function (self)
      ReforgeLite:ResetMethod ()
    end)
    self.methodCategory:AddFrame (self.methodReset)
    self:SetAnchor (self.methodReset, "BOTTOMLEFT", self.methodShow, "BOTTOMRIGHT", 8, 0)

    self:SetAnchor (self.settingsCategory, "TOPLEFT", self.methodShow, "BOTTOMLEFT", 0, -10)    
  end

  self:RefreshMethodStats (true)

  self:UpdateContentSize ()
end
function ReforgeLite:RefreshMethodStats (relax)
  local score = 0
  if self.pdb.method then
    self:UpdateMethodStats (self.pdb.method)
    score = self:GetMethodScore (self.pdb.method)
  end
  if self.pdb.method then
    if self.methodStats then
      local stats = self.itemStats

      self.methodStats.score:SetText (math.floor (score + 0.5))
      SetTextDelta (self.methodStats.scoreDelta, score, self:GetCurrentScore ())
      for i, v in ipairs (stats) do

        local mvalue = v.mgetter (self.pdb.method)
        if v.percent then
          self.methodStats[i].value:SetText (string.format ("%.2f%%", mvalue))
        else
          self.methodStats[i].value:SetText (string.format ("%d", mvalue))
        end
        local override = nil
        mvalue = v.mgetter (self.pdb.method, true)
        local value = v.getter ()
        if self:GetStatScore (i, mvalue) == self:GetStatScore (i, value) then
          override = 0
        end
        SetTextDelta (self.methodStats[i].delta, mvalue, value, override, percent)
      end
    end
  end
end
function ReforgeLite:UpdateContentSize ()
  self.content:SetHeight (-self:GetFrameY (self.lastElement))
  self:SetScript ("OnUpdate", self.FixScroll)
end

function ReforgeLite:GetReforgeID (item)
  local id = tonumber (item:match ("item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+:%d+:(%d+)"))
  return (id and id ~= 0 and (id - self.REFORGE_TABLE_BASE) or nil)
end

function ReforgeLite:UpdateItems ()
  for i, v in ipairs (self.itemData) do
    local item = GetInventoryItemLink ("player", v.slotId)
    local texture = GetInventoryItemTexture ("player", v.slotId)
    local stats = {}
    local reforgeSrc, reforgeDst = nil, nil
    if item and texture then
      v.item = item
      v.texture:SetTexture (texture)
      stats = GetItemStatsUp(item, self.pdb.ilvlCap) or {}
      local reforge = self:GetReforgeID (item)
      if reforge then
        reforgeSrc, reforgeDst = self.itemStats[self.reforgeTable[reforge][1]].name, self.itemStats[self.reforgeTable[reforge][2]].name
        local amount = math.floor ((stats[reforgeSrc] or 0) * 0.4)
        stats[reforgeSrc] = (stats[reforgeSrc] or 0) - amount
        stats[reforgeDst] = (stats[reforgeDst] or 0) + amount
      end
    else
      v.item = nil
      v.texture:SetTexture (v.slotTexture)
    end
    for j, s in ipairs (self.itemStats) do
      if stats[s.name] and stats[s.name] ~= 0 then
        self.itemData[i].stats[j]:SetText (stats[s.name])
        if s.name == reforgeSrc then
          self.itemData[i].stats[j]:SetTextColor (1, 0.4, 0.4)
        elseif s.name == reforgeDst then
          self.itemData[i].stats[j]:SetTextColor (0.6, 1, 0.6)
        else
          self.itemData[i].stats[j]:SetTextColor (1, 1, 1)
        end
      else
        self.itemData[i].stats[j]:SetText ("-")
        self.itemData[i].stats[j]:SetTextColor (0.8, 0.8, 0.8)
      end
    end
  end
  for i, v in ipairs (self.itemStats) do
    self.statTotals[i]:SetText (v.getter ())
  end
  self:UpdateTask()

  self:RefreshMethodStats ()
end
function ReforgeLite:QueueUpdate ()
  if not self.initialized then
    return
  end
  self:SetScript ("OnUpdate", function (self)
    self:SetScript ("OnUpdate", nil)
    self:UpdateItems ()
  end)
  if self.methodWindow then
    self.methodWindow:SetScript ("OnUpdate", function (self)
      self:SetScript ("OnUpdate", nil)
      ReforgeLite:UpdateMethodChecks ()
    end)
  end
end

--------------------------------------------------------------------------

function ReforgeLite:ShowMethodWindow ()
  if self.methodWindow == nil then
    self.methodWindow = CreateFrame ("Frame", nil, UIParent)
    self.methodWindow:SetFrameStrata ("DIALOG")
    self.methodWindow:SetFrameLevel (ReforgeLite:GetFrameLevel () + 10)
    self.methodWindow:ClearAllPoints ()
    self.methodWindow:SetWidth (300)
    self.methodWindow:SetHeight (495)
    if self.db.methodWindowX and self.db.methodWindowY then
      self.methodWindow:SetPoint ("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.methodWindowX, self.db.methodWindowY)
    else
      self.methodWindow:SetPoint ("CENTER")
    end
    self.methodWindow:SetBackdrop ({
      bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
      edgeFile = AddonPath .. "textures\\frameborder", edgeSize = 32,
      insets = {left = 1, right = 1, top = 20, bottom = 1}
    })
    self.methodWindow:SetBackdropBorderColor (unpack (self.db.activeWindowTitle))
    self.methodWindow:SetBackdropColor (0.1, 0.1, 0.1)

    self.methodWindow:EnableMouse (true)
    self.methodWindow:SetMovable (true)
    self.methodWindow:SetScript ("OnMouseDown", function (self, arg)
      if self:GetFrameLevel () < ReforgeLite:GetFrameLevel () then
        self:SetFrameLevel (ReforgeLite:GetFrameLevel () + 10)
        self:SetBackdropBorderColor (unpack (ReforgeLite.db.activeWindowTitle))
        ReforgeLite:SetBackdropBorderColor (unpack (ReforgeLite.db.inactiveWindowTitle))
      end
      if arg == "LeftButton" then
        self:StartMoving ()
        self.moving = true
      end
    end)
    self.methodWindow:SetScript ("OnMouseUp", function (self)
      if self.moving then
        self:StopMovingOrSizing ()
        self.moving = false
        ReforgeLite.db.methodWindowX = self:GetLeft ()
        ReforgeLite.db.methodWindowY = self:GetTop ()
      end
    end)

    self.methodWindow.title = self.methodWindow:CreateFontString (nil, "OVERLAY", "GameFontNormal")
    self.methodWindow.title:SetPoint ("TOPLEFT", self.methodWindow, "TOPLEFT", 6, -15)
    self.methodWindow.title:SetTextColor (1, 1, 1)
    self.methodWindow.title:SetText ("ReforgeLite Output")

    self.methodWindow.close = CreateFrame ("Button", nil, self.methodWindow)
    self.methodWindow.close:SetNormalTexture ("Interface\\Buttons\\UI-Panel-MinimizeButton-Up.blp")
    self.methodWindow.close:SetPushedTexture ("Interface\\Buttons\\UI-Panel-MinimizeButton-Down.blp")
    self.methodWindow.close:SetHighlightTexture ("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
    self.methodWindow.close:SetWidth (20)
    self.methodWindow.close:SetHeight (20)
    self.methodWindow.close:SetPoint ("TOPRIGHT", self.methodWindow, "TOPRIGHT", -4, -12)
    self.methodWindow.close:SetScript ("OnClick", function (self)
      self:GetParent ():Hide ()
      ReforgeLite:SetBackdropBorderColor (unpack (ReforgeLite.db.activeWindowTitle))
    end)

    self.methodWindow.itemTable = GUI:CreateTable (#self.itemSlots + 1, 3, 0, 0, nil, self.methodWindow)
    self.methodWindow:ClearAllPoints ()
    self.methodWindow.itemTable:SetPoint ("TOPLEFT", self.methodWindow, "TOPLEFT", 12, -40)
    self.methodWindow.itemTable:SetRowHeight (26)
    self.methodWindow.itemTable:SetColumnWidth (1, self.db.itemSize)
    self.methodWindow.itemTable:SetColumnWidth (2, self.db.itemSize + 2)
    self.methodWindow.itemTable:SetColumnWidth (3, 274 - self.db.itemSize * 2)

    self.methodOverride = {}
    for i = 1, #self.itemSlots do
      self.methodOverride[i] = 0
    end

    self.methodWindow.items = {}
    for i, v in ipairs (self.itemSlots) do
      self.methodWindow.items[i] = CreateFrame ("Frame", nil, self.methodWindow.itemTable)
      self.methodWindow.items[i].slot = v
      self.methodWindow.items[i]:ClearAllPoints ()
      self.methodWindow.items[i]:SetWidth (self.db.itemSize)
      self.methodWindow.items[i]:SetHeight (self.db.itemSize)
      self.methodWindow.itemTable:SetCell (i, 2, self.methodWindow.items[i])
      self.methodWindow.items[i]:EnableMouse (true)
      self.methodWindow.items[i]:SetScript ("OnEnter", function (self)
        GameTooltip:SetOwner (self, "ANCHORLEFT")
        if self.item then
          GameTooltip:SetHyperlink (self.item)
        else
          local text = _G[strupper (self.slot)]
          if self.checkRelic then
            text = _G["RELICSLOT"]
          end
          GameTooltip:SetText (text)
        end
        GameTooltip:Show ()
      end)
      self.methodWindow.items[i]:SetScript ("OnLeave", function (self)
        GameTooltip:Hide ()
      end)
      self.methodWindow.items[i].slotId, self.methodWindow.items[i].slotTexture, self.methodWindow.items[i].checkRelic = GetInventorySlotInfo (v)
      self.methodWindow.items[i].checkRelic = self.methodWindow.items[i].checkRelic and UnitHasRelicSlot ("player")
      if self.methodWindow.items[i].checkRelic then
        self.methodWindow.items[i].slotTexture = "Interface\\Paperdoll\\UI-PaperDoll-Slot-Relic.blp"
      end
      self.methodWindow.items[i].texture = self.methodWindow.items[i]:CreateTexture (nil, "OVERLAY")
      self.methodWindow.items[i].texture:SetAllPoints (self.methodWindow.items[i])
      self.methodWindow.items[i].texture:SetTexture (self.methodWindow.items[i].slotTexture)

      self.methodWindow.items[i].reforge = self.methodWindow.itemTable:CreateFontString (nil, "OVERLAY", "GameFontNormal")
      self.methodWindow.itemTable:SetCell (i, 3, self.methodWindow.items[i].reforge, "LEFT")
      self.methodWindow.items[i].reforge:SetTextColor (1, 1, 1)
      self.methodWindow.items[i].reforge:SetText ("")

      self.methodWindow.items[i].check = GUI:CreateCheckButton (self.methodWindow.itemTable, "", false,
        function (val) self.methodOverride[i] = (val and 1 or -1) self:UpdateMethodChecks () end)
--      self.methodWindow.items[i].check = self.methodWindow.itemTable:CreateTexture (nil, "OVERLAY")
--      self.methodWindow.items[i].check:SetWidth (self.db.itemSize)
--      self.methodWindow.items[i].check:SetHeight (self.db.itemSize)
      self.methodWindow.itemTable:SetCell (i, 1, self.methodWindow.items[i].check)
--      self.methodWindow.items[i].check:SetTexture ("Interface\\Buttons\\UI-CheckBox-Check")
--      self.methodWindow.items[i].check:Hide ()
    end
    self.methodWindow.reforge = CreateFrame ("Button", "ReforgeLiteReforgeButton", self.methodWindow, "UIPanelButtonTemplate")
    self.methodWindow.reforge:SetWidth (114)
    self.methodWindow.reforge:SetHeight (22)
    self.methodWindow.reforge:SetPoint ("BOTTOMLEFT", self.methodWindow, "BOTTOMLEFT", 12, 12)
    self.methodWindow.reforge:SetText (L["Reforge"])
    self.methodWindow.reforge:SetScript ("OnClick", function (self)
      ReforgeLite:DoReforge ()
    end)
    self.methodWindow.reforgeTip = CreateFrame ("Frame", nil, self.methodWindow)
    self.methodWindow.reforgeTip:SetAllPoints (self.methodWindow.reforge)
    self.methodWindow.reforgeTip:EnableMouse (true)
    GUI:SetTooltip (self.methodWindow.reforgeTip, L["Reforging window must be open"])
    self.methodWindow.reforgeTip:SetFrameLevel (self.methodWindow.reforge:GetFrameLevel () + 5)
    self.methodWindow.reforgeTip:Hide ()

    self.methodWindow.costTip = self.methodWindow:CreateFontString (nil, "OVERLAY", "GameFontNormal")
    self.methodWindow.costTip:SetPoint ("LEFT", self.methodWindow.reforge, "RIGHT", 8, 0)
    self.methodWindow.costTip:SetTextColor (1, 1, 1)
    self.methodWindow.costTip:SetText (L["Cost"] .. ":")
    self.methodWindow.cost = CreateFrame ("Frame", "ReforgeLiteReforgeCost", self.methodWindow, "SmallMoneyFrameTemplate")
    MoneyFrame_SetType (self.methodWindow.cost, "STATIC")
    self.methodWindow.cost:SetPoint ("BOTTOMLEFT", self.methodWindow.costTip, "BOTTOMRIGHT", 5, 0)
  end

  for i = 1, #self.itemSlots do
    self.methodOverride[i] = 0
  end

  self.methodWindow:SetFrameLevel (ReforgeLite:GetFrameLevel () + 10)
  self.methodWindow:SetBackdropBorderColor (unpack (self.db.activeWindowTitle))
  self:SetBackdropBorderColor (unpack (self.db.inactiveWindowTitle))

  for i, v in ipairs (self.methodWindow.items) do
    local item = GetInventoryItemLink ("player", v.slotId)
    local texture = GetInventoryItemTexture ("player", v.slotId)
    if texture then
      v.item = item
      v.texture:SetTexture (texture)
    else
      v.item = nil
      v.texture:SetTexture (v.slotTexture)
    end
    if self.pdb.method.items[i].reforge then
      v.reforge:SetText (string.format ("%d %s > %s", self.pdb.method.items[i].amount,
        self.itemStats[self.pdb.method.items[i].src].long, self.itemStats[self.pdb.method.items[i].dst].long))
      v.reforge:SetTextColor (1, 1, 1)
    else
      v.reforge:SetText (L["No reforge"])
      v.reforge:SetTextColor (0.7, 0.7, 0.7)
    end
  end
  self:UpdateMethodChecks ()
  self.methodWindow:Show ()
end
function ReforgeLite:IsReforgeMatching (item, reforge, override)
  if override == 1 then
    return true
  end

  local oreforge = self:GetReforgeID (item)

  if override == -1 then
    return reforge == oreforge
  end

  local stats = GetItemStatsUp(item, self.pdb.ilvlCap)

  local deltas = {}
  for i = 1, #self.itemStats do
    deltas[i] = 0
  end

  if oreforge then
    local osrc = self.reforgeTable[oreforge][1]
    local odst = self.reforgeTable[oreforge][2]
    local oamount = math.floor ((stats[self.itemStats[osrc].name] or 0) * REFORGE_COEFF)
    deltas[osrc] = deltas[osrc] + oamount
    deltas[odst] = deltas[odst] - oamount
  end

  if reforge then
    local src = self.reforgeTable[reforge][1]
    local dst = self.reforgeTable[reforge][2]
    local amount = math.floor ((stats[self.itemStats[src].name] or 0) * REFORGE_COEFF)
    deltas[src] = deltas[src] - amount
    deltas[dst] = deltas[dst] + amount
  end

  local conv = self:GetConversion()
  local mult = self:GetStatMultipliers()
  for i = 1, #self.itemStats do
    deltas[i] = math.floor(deltas[i] * (mult[i] or 1) + 0.5)
  end
  for src, c in pairs(conv) do
    for dst, factor in pairs(c) do
      deltas[dst] = deltas[dst] + math.floor(deltas[src] * factor + 0.5)
    end
  end

  for i = 1, #self.itemStats do
    if self:GetStatScore (i, self.pdb.method.stats[i]) ~= self:GetStatScore (i, self.pdb.method.stats[i] - deltas[i]) then
      return false
    end
  end
  return true
end
function ReforgeLite:UpdateMethodChecks ()
  if self.methodWindow and self.pdb.method then
    local cost = 0
    local anyDiffer = false
    for i, v in ipairs (self.methodWindow.items) do
      local item = GetInventoryItemLink ("player", v.slotId)
      v.item = item
      local texture = GetInventoryItemTexture ("player", v.slotId)
      v.texture:SetTexture (texture or v.slotTexture)
      if item == nil or self:IsReforgeMatching (item, self.pdb.method.items[i].reforge, self.methodOverride[i]) then
        v.check:SetChecked (true)
      else
        if item then
          anyDiffer = true
        end
        v.check:SetChecked (false)
        if self.pdb.method.items[i].reforge then
          cost = cost + (item and select (11, GetItemInfo (item)) or 0)
        end
      end
    end
    if anyDiffer then
      if ReforgingFrame and ReforgingFrame:IsShown () and self:IsMethodValid(self.pdb.method) then
        self.methodWindow.reforge:Enable ()
        self.methodWindow.reforgeTip:Hide ()
      else
        self.methodWindow.reforge:Disable ()
        self.methodWindow.reforgeTip:Show ()
        if self:IsMethodValid(self.pdb.method) then
          GUI:SetTooltip (self.methodWindow.reforgeTip, L["Reforging window must be open"])
        else
          GUI:SetTooltip (self.methodWindow.reforgeTip, L["Please press Compute button to update the reforge."])
        end
      end
      self.methodWindow.costTip:Show ()
      self.methodWindow.cost:Show ()
    else
      self.methodWindow.reforge:Disable ()
      self.methodWindow.reforgeTip:Hide ()
      self.methodWindow.costTip:Hide ()
      self.methodWindow.cost:Hide ()
    end
    MoneyFrame_Update (self.methodWindow.cost, cost)
  end
end

--------------------------------------------------------------------------

function ReforgeLite:DoReforgeUpdate ()
  if self.curReforgeItem and self.pdb.method and self.methodWindow.reforge:IsShown () and ReforgingFrame and ReforgingFrame:IsShown () and self:IsMethodValid(self.pdb.method) then
    while self.curReforgeItem <= #self.methodWindow.items do
      local i = self.curReforgeItem
      if i ~= 0 then
        local slot = self.methodWindow.items[i].slotId
        local item = GetInventoryItemLink ("player", slot)
        if item and not self:IsReforgeMatching (item, self.pdb.method.items[i].reforge, self.methodOverride[i]) then
          if self.reforgingNow ~= i then
            PickupInventoryItem (slot)
            SetReforgeFromCursorItem ()
            self.reforgingNow = i
          end
          if self:GetReforgeID (item) then
            ReforgeItem (0)
          elseif self.pdb.method.items[i].reforge then
            local id = 0
            local stats = GetItemStatsUp(item, self.pdb.ilvlCap)
            for s = 1, #self.reforgeTable do
              if (stats[self.itemStats[self.reforgeTable[s][1]].name] or 0) ~= 0 and (stats[self.itemStats[self.reforgeTable[s][2]].name] or 0) == 0 then
                id = id + 1
              end
              if self.reforgeTable[s][1] == self.pdb.method.items[i].src and self.reforgeTable[s][2] == self.pdb.method.items[i].dst then
                ReforgeItem (id)
                return
              end
            end
            self.curReforgeItem = nil
            self.methodWindow.reforge:SetScript ("OnUpdate", nil)
            self.methodWindow.reforge:SetText (L["Reforge"])
          end
          return
        end
      end
      self.curReforgeItem = i + 1
    end
  end
  self.curReforgeItem = nil
  self.methodWindow.reforge:SetScript ("OnUpdate", nil)
  self.methodWindow.reforge:SetText (L["Reforge"])
end
function ReforgeLite:DoReforge ()
  if self.pdb.method and self.methodWindow and ReforgingFrame and ReforgingFrame:IsShown () then
    if self.curReforgeItem then
      self.curReforgeItem = nil
      ClearCursor ()
      SetReforgeFromCursorItem ()
      ClearCursor ()
      self.reforgingNow = nil
      self.methodWindow.reforge:SetScript ("OnUpdate", nil)
      self.methodWindow.reforge:SetText (L["Reforge"])
    else
      self.curReforgeItem = 0
      self.methodWindow.reforge:SetScript ("OnUpdate", function (self) ReforgeLite:DoReforgeUpdate () end)
      self.methodWindow.reforge:SetText (L["Cancel"])
    end
  end
end

--------------------------------------------------------------------------
--[=[ OBSOLETE
function ReforgeLite.OnTooltipSetItem (tip)
  if not ReforgeLite.db.updateTooltip then return end
  local _, item = tip:GetItem ()
  if item and GetItemInfo (item) then
    local reforge = ReforgeLite:GetReforgeID (item)
    if reforge then
      local regions = {tip:GetRegions ()}
      for _, region in pairs (regions) do
        if region:GetObjectType () == "FontString" then
          if region:GetText () == REFORGED then
            local src = ReforgeLite.itemStats[ReforgeLite.reforgeTable[reforge][1]].long
            local dst = ReforgeLite.itemStats[ReforgeLite.reforgeTable[reforge][2]].long
            region:SetText (string.format ("%s (%s > %s)", REFORGED, src, dst))
          end
        end
      end
    end
  end
end
function ReforgeLite:SetUpHooks ()
  GameTooltip:HookScript ("OnTooltipSetItem", self.OnTooltipSetItem)
  ItemRefTooltip:HookScript ("OnTooltipSetItem", self.OnTooltipSetItem)
  hooksecurefunc (ShoppingTooltip1, "SetHyperlinkCompareItem", self.OnTooltipSetItem)
  hooksecurefunc (ShoppingTooltip2, "SetHyperlinkCompareItem", self.OnTooltipSetItem)
  hooksecurefunc (ShoppingTooltip3, "SetHyperlinkCompareItem", self.OnTooltipSetItem)
  hooksecurefunc (ItemRefShoppingTooltip1, "SetHyperlinkCompareItem", self.OnTooltipSetItem)
  hooksecurefunc (ItemRefShoppingTooltip2, "SetHyperlinkCompareItem", self.OnTooltipSetItem)
  hooksecurefunc (ItemRefShoppingTooltip3, "SetHyperlinkCompareItem", self.OnTooltipSetItem)
end
]=]
--------------------------------------------------------------------------

function ReforgeLite:OnEvent (event, ...)
  if self[event] then
    self[event] (self, ...)
  end
  if event == "UNIT_STATS" or event == "COMBAT_RATING_UPDATE" or event == "MASTERY_UPDATE" or event == "PLAYER_EQUIPMENT_CHANGED" then
    self:QueueUpdate ()
  end
  if event == "FORGE_MASTER_OPENED" and self.db.openOnReforge and (self.methodWindow == nil or not self.methodWindow:IsShown ()) then
    if not self.initialized then
      self:CreateFrame()
    end
    self:UpdateItems ()
    self:Show ()
  end
  if event == "FORGE_MASTER_CLOSED" and self.db.openOnReforge then
    self:Hide ()
    if self.methodWindow then
      self.methodWindow:Hide ()
    end
  end
  if event == "FORGE_MASTER_OPENED" or event == "FORGE_MASTER_CLOSED" then
    self:QueueUpdate ()
  end
end
--[[
local ReforgeLiteTimer = CreateFrame ("Frame")
function ReforgeLiteTimer:OnUpdate (epsilon)
  self.elapsed = (self.elapsed or 0) + epsilon
  if self.elapsed > 3 then
    self:SetScript ("OnUpdate", nil)
    self:Hide ()
--    ReforgeLite:SetUpHooks ()
  end
end
]]
function ReforgeLite:ADDON_LOADED (addon)
  if addon == "ReforgeLite" then
    self:UpgradeDB ()
    self.db = ReforgeLiteDB
    self.pdb = ReforgeLiteDB.profiles[self.dbkey]

    self:InitPresets ()

    self:RegisterEvent ("UNIT_STATS")
    self:RegisterEvent ("COMBAT_RATING_UPDATE")
    self:RegisterEvent ("MASTERY_UPDATE")
    self:RegisterEvent ("PLAYER_EQUIPMENT_CHANGED")
    self:RegisterEvent ("FORGE_MASTER_OPENED")
    self:RegisterEvent ("FORGE_MASTER_CLOSED")
    
    --ReforgeLiteTimer:SetScript ("OnUpdate", ReforgeLiteTimer.OnUpdate)

    SlashCmdList["ReforgeLite"] = function (cmd) ReforgeLite:OnCommand (cmd) end
    SLASH_ReforgeLite1 = "/reforge"
  end
end

ReforgeLite:SetScript ("OnEvent", ReforgeLite.OnEvent)
ReforgeLite:RegisterEvent ("ADDON_LOADED")

function ReforgeLite:OnCommand (cmd)
  if not self.initialized then
    self:CreateFrame()
  end
  self:UpdateItems ()
  self:Show ()
end
