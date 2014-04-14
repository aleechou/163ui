-- Learning Aid v1.11.2 by Jamash (Kil'jaeden-US)
-- LearningAid.lua

local addonName, private = ...

private.debug = 0
private.debugCount = 0
private.debugLimit = 5000 -- how many lines of log to keep before deleting earliest line
private.shadow = { }
private.wrappers = { }
private.debugFlags = { }
private.tokenCount = { }
private.noLog = { -- do not log calls to these functions even when call logging is enabled
  GetVisible = true,
  GetText = true,
  ListJoin = true,
  SpellInfo = true,
  SpellBookInfo = true,
  PLAYER_GUILD_UPDATE = true,
  UpdateGuild = true,
  COMPANION_UPDATE = true
}

local LA = { 
  version = "1.11.2",
  dataVersion = 1,
  name = addonName,
  titleHeight = 40, -- pixels
  frameWidth = 200, -- pixels
  framePadding = 10, -- pixels
  verticalSpacing = 5, -- pixels
  horizontalSpacing = 153, -- pixels
  buttonSize = 37, -- pixels
  width = 1, -- button columns
  height = 0, -- button rows
  visible = 0, -- buttons
  strings = { },
  FILTER_SHOW_ALL  = 0,
  FILTER_SUMMARIZE = 1, -- default
  FILTER_SHOW_NONE = 2,
  CONFIRM_TRAINER_BUY_ALL = 732297, -- magic number to prevent users from accidentally spending hundreds of gold at a trainer
  patterns = {
    learnAbility    = ERR_LEARN_ABILITY_S,
    learnSpell      = ERR_LEARN_SPELL_S,
    unlearnSpell    = ERR_SPELL_UNLEARNED_S,
    petLearnAbility = ERR_PET_LEARN_ABILITY_S,
    petLearnSpell   = ERR_PET_LEARN_SPELL_S,
    petUnlearnSpell = ERR_PET_SPELL_UNLEARNED_S
    -- add tradeskill learning stuff here
  },
  defaults = { -- default savedvariables contents
    macros = true,
    totem = false,
    enabled = true,
    restoreActions = true,
    filterSpam = 1, -- FILTER_SUMMARIZE
    debugFlags = { },
    ignore = {
	["profession"] = {
		[83967]=true, 
		[83958]=true, 
		[72429]=true, 
		[72423]=true,
		[83968]=true,
	},
	["WARLOCK"] = {
		[61610]=true,-- 恶魔变形
		[688]=true,-- 召唤小鬼
		[697]=true,-- 召唤虚空行者
		[712]=true,-- 召唤魅魔
		[691]=true,-- 召唤地狱猎犬
		[30146]=true,-- 召唤恶魔卫士
		[1122]=true,-- 地狱火
		[18540]=true,-- 末日仪式
	},
    },
  },
  menuHideDelay = 5, -- seconds
  pendingBuyCount = 0,
  inCombat = false,
  retalenting = false,
  untalenting = false,
  learning = false,
--  petLearning = false,
  activatePrimarySpec = 63645, -- global spellID
  activateSecondarySpec = 63644, -- global spellID
	racialSpell = 20549, -- War Stomp (Tauren)
	racialPassiveSpell = 20550, -- Endurance (Tauren)
	ridingSpells = {
		[33388] = true, -- apprentice (60% ground)
		[33391] = true, -- journeyman (100% ground)
		[34090] = true, -- expert (150% flying)
		[34091] = true, -- artisan (280% flying)
		[90265] = true, -- master (310% flying)
		[90267] = true, -- old world
		[54197] = true  -- northrend
	},
  origin = {
    profession = "profession",
    class = "class",
    guild = "guild",
    riding = "riding",
    race = "race"
  },
  numProfessions = 6,
  buttons = { },
  queue = { },
  availableServices = { },
  petLearned = { },
  petUnlearned = { },
  companionCache = {
    MOUNT = { },
    CRITTER = { }
  },
  ignore = { },
  spellBookCache = { },
  oldSpellBookCache = { },
  spellInfoCache = { },
  spellsLearned  = { },
  spellsUnlearned = { },
  flyoutCache = { },
  numSpells = 0,
  companionsReady = false,
  backdrop = {
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Gold-Border",
    tile = false, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
  }
}

private.LA = LA
_G[addonName] = LA

LibStub("AceConsole-3.0"):Embed(LA)

function private.onEvent(frame, event, ...)
  LA[event](LA, ...)
end

function private.onEventDebug(frame, event, ...)
  if LA.events[event] then
    LA[event](LA, ...)
  else
    LA:DebugPrint(event)
  end
end

LA.frame = CreateFrame("Frame", nil, UIParent)
LA.frame:SetScript("OnEvent", private.onEvent)
LA.frame:RegisterEvent("ADDON_LOADED")

for name, pattern in pairs(LA.patterns) do
  LA.patterns[name] = string.gsub(pattern, "%%s", "(.+)")
end

function LA:Init()
  --self:DebugPrint("Initialize()")
  self.localClass, self.enClass = UnitClass("player")
  self.tocVersion = select(4, GetBuildInfo())
  self.locale = GetLocale()
  self:SetDefaultSettings()

  -- set up main frame
  local frame = self.frame
  frame:Hide()
  frame:SetClampedToScreen(true)
  frame:SetWidth(self.frameWidth)
  frame:SetHeight(self.titleHeight)
  frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -200, -200)
  frame:SetMovable(true)
  frame:SetScript("OnShow", function () self:OnShow() end)
  frame:SetScript("OnHide", function () self:OnHide() end)
  frame:SetBackdrop(self.backdrop)

  -- create title bar
  local titleBar = CreateFrame("Frame", nil, frame)
  self.titleBar = titleBar
  titleBar:SetPoint("TOPLEFT")
  titleBar:SetPoint("TOPRIGHT")
  titleBar:SetHeight(self.titleHeight)
  titleBar:RegisterForDrag("LeftButton")
  titleBar:EnableMouse()
  titleBar.text = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  titleBar.text:SetText(self:GetText("title"))
  titleBar.text:SetPoint("CENTER", titleBar, "CENTER", 0, 0)

  -- create close button in the upper right corner of the frame
  local closeButton = CreateFrame("Button", nil, titleBar)
  self.closeButton = closeButton
  closeButton:SetWidth(32)
  closeButton:SetHeight(32)
  closeButton:SetPoint("RIGHT", titleBar, "RIGHT", -2, 0)
  closeButton:SetNormalTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Up")
  closeButton:SetPushedTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Down")
  closeButton:SetDisabledTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Disabled")
  closeButton:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
  closeButton:SetScript("OnClick", function () self:Hide() end)

  -- create lock button in the upper left corner of the frame
  local lockButton = CreateFrame("Button", nil, titleBar)
  self.lockButton = lockButton
  lockButton:SetWidth(20)
  lockButton:SetHeight(20)
  lockButton:SetPoint("LEFT", titleBar, "LEFT", 15, 0)
  lockButton:SetNormalTexture("Interface/LFGFrame/UI-LFG-ICON-LOCK")
  lockButton:SetScript("OnClick", function() if self.saved.locked then self:Unlock() else self:Lock() end end)
  
  -- initialize right-click menu
  self.menuTable = {
    { text = self:GetText("lockPosition"), 
      func = function () self:ToggleLock() end }--,
--    { text = self:GetText("close"),
--      func = function () self:Hide() end }
  }

  local menu = CreateFrame("Frame", "LearningAid_Menu", titleBar, "UIDropDownMenuTemplate")

  -- set drag and click handlers for the title bar
  titleBar:SetScript(
    "OnDragStart",
    function (bar, button)
      if not self.saved.locked then
        bar:GetParent():StartMoving()
      end
    end
  )

  titleBar:SetScript(
    "OnDragStop",
    function (bar)
      local parent = bar:GetParent()
      parent:StopMovingOrSizing()
      self.saved.x = parent:GetLeft()
      self.saved.y = parent:GetTop()
    end
  )

  titleBar:SetScript(
    "OnMouseUp",
    function (bar, button)
      if button == "MiddleButton" then
        self:Hide()
      elseif button == "RightButton" then
        EasyMenu(self.menuTable, menu, "cursor", 0, 8, "MENU", self.menuHideDelay)
      end
    end
  )

  self.options = {
    handler = self,
    type = "group",
    args = {
      lock = {
        name = self:GetText("lockWindow"),
        desc = self:GetText("lockWindowHelp"),
        type = "toggle",
        set = function(info, val) if val then self:Lock() else self:Unlock() end end,
        get = function(info) return self.saved.locked end,
        width = "full",
        order = 1
      },
      restoreactions = {
        name = self:GetText("restoreActions"),
        desc = self:GetText("restoreActionsHelp"),
        type = "toggle",
        set = function(info, val) self.saved.restoreActions = val end,
        get = function(info) return self.saved.restoreActions end,
        width = "full",
        order = 2
      },
      filter = {
        name = self:GetText("showLearnSpam"),
        desc = self:GetText("showLearnSpamHelp"),
        type = "select",
        values = {
          [self.FILTER_SHOW_ALL ] = self:GetText("showAll"),
          [self.FILTER_SUMMARIZE] = self:GetText("summarize"),
          [self.FILTER_SHOW_NONE] = self:GetText("showNone")
        },
        set = function(info, val)
          local old = self.saved.filterSpam
          if old ~= val then
            self.saved.filterSpam = val
            if val == self.FILTER_SHOW_ALL then
              self:DebugPrint("Removing chat filter for CHAT_MSG_SYSTEM")
              ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", private.spellSpamFilter)
            elseif old == self.FILTER_SHOW_ALL then
              self:DebugPrint("Adding chat filter for CHAT_MSG_SYSTEM")
              ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", private.spellSpamFilter)
            end
          end
        end,
        get = function(info) return self.saved.filterSpam end,
        order = 3
      },
      reset = {
        name = self:GetText("resetPosition"),
        desc = self:GetText("resetPositionHelp"),
        type = "execute",
        func = "ResetFramePosition",
        width = "full",
        order = 4
      },
      missing = {
        type = "group",
        inline = true,
        name = self:GetText("findMissingAbilities"),
        order = 10,
        args = {
          search = {
            name = self:GetText("searchMissing"),
            desc = self:GetText("searchMissingHelp"),
            type = "execute",
            func = "FindMissingActions",
            -- width = "full",
            order = 1
          },
          shapeshift = {
            name = self:GetText("findShapeshift"),
            desc = self:GetText("findShapeshiftHelp"),
            type = "toggle",
            set = function(info, val) self.saved.shapeshift = val end,
            get = function(info) return self.saved.shapeshift end,
            width = "full",
            order = 3
          },
          macros = {
            name = self:GetText("searchInsideMacros"),
            desc = self:GetText("searchInsideMacrosHelp"),
            type = "toggle",
            set = function(info, val) self.saved.macros = val end,
            get = function(info) return self.saved.macros end,
            width = "full",
            order = 4
          },
          ignore = {
            name = self:GetText("ignore"),
            desc = self:GetText("ignoreHelp"),
            type = "input",
            guiHidden = true,
            set = "ChatCommandIgnore"
          },
          unignore = {
            name = self:GetText("unignore"),
            desc = self:GetText("unignoreHelp"),
            type = "input",
            guiHidden = true,
            set = "ChatCommandUnignore"
          },
          unignoreall = {
            order = 5,
            name = self:GetText("unignoreAll"),
            desc = self:GetText("unignoreAllHelp"),
            type = "execute",
            -- width = "full",
            func = "UnignoreAll"
          }
        }
      },
      unlock = {
        name = self:GetText("unlockWindow"),
        desc = self:GetText("unlockWindowHelp"),
        type = "execute",
        guiHidden = true,
        func = "Unlock"
      },
      config = {
        name = self:GetText("configure"),
        desc = self:GetText("configureHelp"),
        type = "execute",
        func = function() InterfaceOptionsFrame_OpenToCategory(self.optionsFrame) end,
        guiHidden = true
      },
      advanced = {
        type = "group",
        name = self:GetText("advanced"),
        args = {
          framestrata = {
            name = self:GetText("frameStrata"),
            desc = self:GetText("frameStrataHelp"),
            type = "select",
            values = {
              -- PARENT = "Parent",
              BACKGROUND = "Background",
              LOW = "Low",
              MEDIUM = "Medium",
              HIGH = "High",
              DIALOG = "Dialog",
              FULLSCREEN = "Fullscreen",
              FULLSCREEN_DIALOG = "Fullscreen Dialog",
              TOOLTIP = "Tooltip"
            },
            set = function(info, val)
              self.saved.frameStrata = val
              self.frame:SetFrameStrata(val)
            end,
            get = function(info) return self.frame:GetFrameStrata() end,
            order = 1
          },
          debug = {
            name = self:GetText("debugOutput"),
            desc = self:GetText("debugOutputHelp"),
            values = { SET = "Assignment", GET = "Access", CALL = "Function Calls" },
            type = "multiselect",
            set = function(info, key, val) self:Debug(key, val) end,
            get = function(info, key) return self:Debug(key) end,
            width = "full",
            order = 99
          }
        }
      },
      test = {
        type = "group",
        name = "Test",
        desc = "Perform various tests with Learning Aid.",
        hidden = true,
        guiHidden = true,
        args = {
          add = {
            type = "group",
            name = "Add",
            desc = "Add a button to the Learning Aid window.",
            args = {
              spell = {
                type = "input",
                name = "Spell",
                pattern = "^%d+$",
                set = function(info, val)
                  self:AddButton(BOOKTYPE_SPELL, tonumber(val))
                end
              },
              mount = {
                type = "input",
                name = "Mount",
                pattern = "^%d+$",
                set = function(info, val)
                  self:AddButton("MOUNT", tonumber(val))
                end
              },
              critter = {
                type = "input",
                name = "Critter (Minipet)",
                pattern = "^%d+$",
                set = function(info, val)
                  self:AddButton("CRITTER", tonumber(val))
                end
              },
              all = {
                name = "All",
                desc = "The Kitchen Sink",
                type = "execute",
                func = function ()
                  local i = 1
                  local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL)
                  while spellName do
                    self:AddButton(BOOKTYPE_SPELL, i)
                    i = i + 1
                    spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL)
                  end
                end
              }
            }
          },
          remove = {
            type = "group",
            name = "Remove",
            desc = "Remove a button from the Learning Aid window.",
            args = {
              spell = {
                type = "input",
                name = "Spell",
                pattern = "^%d+$",
                set = function(info, val)
                  self:ClearButtonID(BOOKTYPE_SPELL, tonumber(val))
                end
              },
              mount = {
                type = "input",
                name = "Mount",
                pattern = "^%d+$",
                set = function(info, val)
                  self:ClearButtonID("MOUNT", tonumber(val))
                end
              },
              critter = {
                type = "input",
                name = "Critter (Minipet)",
                pattern = "^%d+$",
                set = function(info, val)
                  self:ClearButtonID("CRITTER", tonumber(val))
                end
              },
              button = {
                type = "input",
                name = "Button",
                pattern = "^%d+$",
                set = function(info, val)
                  self:ClearButtonIndex(tonumber(val))
                end
              }
            }
          }
        }
      }
    }
  }
  --[[
  if self.enClass == "SHAMAN" then
    self.options.args.missing.args.totem = {
      name = self:GetText("findTotem"),
      desc = self:GetText("findTotemHelp"),
      type = "toggle",
      set = function(info, val) self.saved.totem = val end,
      get = function(info) return self.saved.totem end,
      width = "full",
      order = 4
    }
  end
  ]]
  LibStub("AceConfig-3.0"):RegisterOptionsTable("LearningAidConfig", self.options, {"la", "learningaid"})
  self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LearningAidConfig", GetAddOnMetadata("LearningAid", "Title"))
  hooksecurefunc("ConfirmTalentWipe", function()
    self:DebugPrint("ConfirmTalentWipe")
    self:SaveActionBars()
    self.untalenting = true
    --self.spellsUnlearned = {}
    self:RegisterEvent("ACTIONBAR_SLOT_CHANGED", "OnEvent")
    self:RegisterEvent("PLAYER_TALENT_UPDATE", "OnEvent")
    self:RegisterEvent("UI_ERROR_MESSAGE", "OnEvent")
  end)
  hooksecurefunc("LearnTalents", function(pet)
    self:DebugPrint("LearnTalents", pet)
    if pet then
--      self.petLearning = true
    else
      self:RegisterEvent("PLAYER_TALENT_UPDATE", "OnEvent")
      --wipe(self.spellsLearned)
      --wipe(self.spellsUnlearned)
      self.learning = true
    end
  end)
  hooksecurefunc("SetCVar", function (cvar, value)
    if cvar == nil then cvar = "" end
    if value == nil then value = "" end
    cvarLower = string.lower(cvar)
    self:DebugPrint("SetCVar("..cvar..", "..value..")")
    if cvarLower == "uiscale" or cvarLower == "useuiscale" then
      self:AutoSetMaxHeight()
    end      
  end)
  self.LearnTalent = LearnTalent
  self.pendingTalents = {}
  self.pendingTalentCount = 0
  LearnTalent = function(tab, talent, pet, group, ...)
    self:DebugPrint("LearnTalent", tab, talent, pet, group, ...)
    local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq, unknown1, unknown2 = GetTalentInfo(tab, talent, false, pet, group)
    self:DebugPrint("GetTalentInfo", name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq, unknown1, unknown2)
    self.LearnTalent(tab, talent, pet, group, ...)
    if rank < maxRank and meetsPrereq and not pet then
      --wipe(self.spellsLearned)
      --self.learning = true
      if self.pendingTalentCount == 0 then wipe(self.pendingTalents) end
      self:RegisterEvent("PLAYER_TALENT_UPDATE")
      local id = (group or GetActiveSpecGroup()).."."..tab.."."..talent.."."..rank
      if not self.pendingTalents[id] then
        self.pendingTalents[id] = true
        self.pendingTalentCount = self.pendingTalentCount + 1
      end
      --self:DebugPrint(GetTalentInfo(tab, talent, false, pet, group))
    end
  end
  self:RegisterChatCommand("la", "AceSlashCommand")
  self:RegisterChatCommand("learningaid", "AceSlashCommand")
  --self:SetEnabledState(self.saved.enabled)
  --self.saved.enabled = true
  --self:DebugPrint("OnEnable()")
  local baseEvents = {
    "ADDON_LOADED",
    "CHAT_MSG_SYSTEM",
    "COMPANION_LEARNED",
    "COMPANION_UPDATE",
    "PET_TALENT_UPDATE",
    "PLAYER_LEAVING_WORLD",
    "PLAYER_LEVEL_UP",
    "PLAYER_LOGIN",
    "PLAYER_LOGOUT",
    "PLAYER_GUILD_UPDATE",
    "PLAYER_REGEN_DISABLED",
    "PLAYER_REGEN_ENABLED",
--    "SPELLS_CHANGED", -- wait until PLAYER_LOGIN
    "UNIT_SPELLCAST_START",
    "UPDATE_BINDINGS",
    "VARIABLES_LOADED"
--[[
    "CURRENT_SPELL_CAST_CHANGED",
    "SPELL_UPDATE_COOLDOWN",
    "TRADE_SKILL_CLOSE",
    "TRADE_SKILL_SHOW",
    "UNIT_SPELLCAST_SUCCEEDED"
--]]
  }
  for i, event in ipairs(baseEvents) do
    self:RegisterEvent(event, "OnEvent")
  end
  
  --self:UpdateSpellBook()
  self:UpdateCompanions()
  self:DiffActionBars()
  self:SaveActionBars()
  if self.saved.filterSpam ~= LA.FILTER_SHOW_ALL then
    self:DebugPrint("Initially adding chat filter for CHAT_MSG_SYSTEM")
    ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", private.spellSpamFilter)
  end
  if self.saved.locked then
    self.menuTable[1].text = self:GetText("unlockPosition")
  else
    self.saved.locked = false
  end
  if self.saved.frameStrata then
    self.frame:SetFrameStrata(self.saved.frameStrata)
  end
end

-- this is a function
function private.spellSpamFilter(...) return LA:spellSpamFilter(...) end

-- this is a method
function LA:spellSpamFilter(chatFrame, event, message, ...)
  local spell
  local patterns = self.patterns
  if (self.saved.filterSpam ~= self.FILTER_SHOW_ALL) and (
    (
      self.untalenting or
      self.retalenting or
     (self.pendingTalentCount > 0) or
     (self.saved.filterSpam == self.FILTER_SHOW_NONE) or
      self.learning or
--      self.petLearning or
      (self.pendingBuyCount > 0)
    ) and (
      string.match(message, patterns.learnSpell) or 
      string.match(message, patterns.learnAbility) or
      string.match(message, patterns.unlearnSpell)
--    )
  ) or
    string.match(message, patterns.petLearnAbility) or
    string.match(message, patterns.petLearnSpell) or
    string.match(message, patterns.petUnlearnSpell)
  ) then
    self:DebugPrint("Suppressing message")
    return true -- do not display the message
  else
    self:DebugPrint("Allowing message")
    return false, message, ... -- pass the message along
  end
end

function LA:GetText(id, ...)
  if not id then
    if self.DebugPrint then
      self:DebugPrint("Nil supplied to GetText()")
    end
    return "Nil"
  end
  local result = "Invalid String ID '" .. id .. "'"
  if self.strings[self.locale] and self.strings[self.locale][id] then
    result = self.strings[self.locale][id]
  elseif self.strings.enUS[id] then
    result = self.strings.enUS[id]
  else
    self:DebugPrint(result)
  end
  return format(result, ...)
end

function LA:SetDefaultSettings()
  LearningAid_Saved = LearningAid_Saved or {}
  LearningAid_Character = LearningAid_Character or {}
  self.saved = LearningAid_Saved
  self.character = LearningAid_Character
  self.saved.version = self.version
  self.character.version = self.version
  self.saved.dataVersion = self.dataVersion
  self.character.dataVersion = self.dataVersion

  for key, value in pairs(self.defaults) do
    if self.saved[key] == nil then
      self.saved[key] = value
    end
  end
  self.saved.ignore[self.enClass] = self.saved.ignore[self.enClass] or { }
  self.ignore.class = self.saved.ignore[self.enClass]
  self.saved.ignore.profession = self.saved.ignore.profession or { }
  self.ignore.profession = self.saved.ignore.profession
  self.saved.ignore.guild = self.saved.ignore.guild or { }
  self.ignore.guild = self.saved.ignore.guild
  -- update with new debug option format as of 1.11
  if self.saved.debug ~= nil then
    if self.saved.debug then
      self.saved.debugFlags = { SET = true, GET = true, CALL = true }
    end
    self.saved.debug = nil
  end
  for k, v in pairs(self.saved.debugFlags) do
    if v then
      self:Debug()
      break
    end
  end
end
function LA:RegisterEvent(event)
  self.frame:RegisterEvent(event)
--  self.events[event] = true -- EVENT DEBUGGING
end
function LA:UnregisterEvent(event)
  self.frame:UnregisterEvent(event)
--  self.events[event] = false -- EVENT DEBUGGING
end
function LA:UpgradeIgnoreList()
  local ignore = self.saved.ignore
  if ignore[self.localClass] then
    local oldIgnore = ignore[self.localClass]
    for spellLower, spellName in pairs(oldIgnore) do
      if type(spellLower) == "string" then -- old-style ignore list
        if self:ChatCommandIgnore(nil, spellName) then -- successfully converted format
          oldIgnore[spellLower] = nil
        end
      end
    end
    if self.localClass ~= self.enClass and not next(oldIgnore) then -- converted all old entries
      ignore[self.localClass] = nil
    end
  end
end
function LA:Ignore(globalID)
  local bookItem = self.spellBookCache[globalID]
  if bookItem and self.ignore[bookItem.origin] and not bookItem.info.passive then
    if bookItem.origin == self.origin.profession then
      self.ignore[bookItem.origin][bookItem.info.name] = true
    else
      self.ignore[bookItem.origin][globalID] = true
    end
    self:UpdateButtons()
    return true
  end
  return false
end
function LA:ChatCommandIgnore(info, str)
  str = strtrim(str)
  if #str == 0 then
    -- print ignore list to the chat frame
    for origin, t in pairs(self.ignore) do
      for globalID, v in pairs(t) do
        print(self:GetText("title")..": ".. self:GetText("listIgnored", GetSpellLink(globalID)))
      end
    end
  else
    local status, globalID = GetSpellBookItemInfo(str)
    globalID = globalID or select(2, self:UnlinkSpell(str))
    if globalID then
      return self:Ignore(globalID)
    end
  end
end
function LA:ChatCommandUnignore(info, str)
  local status, globalID = GetSpellBookItemInfo(str:trim())
  globalID = globalID or select(2, self:UnlinkSpell(str))
  if globalID then
    self:Unignore(globalID)
  end
end
function LA:Unignore(globalID)
  local bookItem = self.spellBookCache[globalID]
  if bookItem and self.ignore[bookItem.origin] then
    if bookItem.origin == self.origin.profession then
      self.ignore[bookItem.origin][bookItem.info.name] = nil
    elseif self.ignore[bookItem.origin][globalID] then
      self.ignore[bookItem.origin][globalID] = nil
    end
    self:UpdateButtons()
    return true
  end
  return false
end
function LA:IsIgnored(globalID)
  local bookItem = self.spellBookCache[globalID]
  if bookItem and self.ignore[bookItem.origin] then
    if bookItem.origin == self.origin.profession then
      return self.ignore[bookItem.origin][bookItem.info.name]
    else
      return self.ignore[bookItem.origin][globalID]
    end
  end
end
function LA:ToggleIgnore(globalID)
  if self:IsIgnored(globalID) then
    self:Unignore(globalID)
  else
    self:Ignore(globalID)
  end
end
function LA:UnignoreAll(info)
  for kind, list in pairs(self.ignore) do
    wipe(list)
  end
end
function LA:ResetFramePosition()
  local frame = self.frame
  frame:ClearAllPoints()
  frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -200, -200)
  self.saved.x = frame:GetLeft()
  self.saved.y = frame:GetTop()
end
function LA:AceSlashCommand(msg)
  LibStub("AceConfigCmd-3.0").HandleCommand(LearningAid, "la", "LearningAidConfig", msg)
end
function LA:SystemPrint(message)
  local systemInfo = ChatTypeInfo["SYSTEM"]
  DEFAULT_CHAT_FRAME:AddMessage(LA:GetText("title")..": "..message, systemInfo.r, systemInfo.g, systemInfo.b, systemInfo.id)
end

function LA:ProcessQueue()
  if self.inCombat then
    self:DebugPrint("ProcessQueue(): Cannot process action queue during combat.")
    return
  end
  local queue = self.queue
  for index = 1, #queue do
    local item = queue[index]
    if item.action == "SHOW" then
      self:AddButton(item.kind, item.id)
    elseif item.action == "CLEAR" then
      self:ClearButtonID(item.kind, item.id)
    elseif item.kind == BOOKTYPE_SPELL then
      if item.action == "LEARN" then
        self:AddSpell(item.id)
      elseif item.action == "FORGET" then
        self:RemoveSpell(item.id)
      else
        self:DebugPrint("ProcessQueue(): Invalid action type " .. item.action)
      end
    elseif item.kind == "CRITTER" or item.kind == "MOUNT" then
      if item.action == "LEARN" then
        self:AddCompanion(item.kind, item.id)
      else
        self:DebugPrint("ProcessQueue(): Invalid action type " .. item.action)
      end
    elseif item.kind == "HIDE" then
      self:Hide()
    else
      self:DebugPrint("ProcessQueue(): Invalid entry type " .. item.kind)
    end
  end
  self.queue = {}
end

function LA:FormatSpells(t)
  local infoCache = self.spellInfoCache
  local sortIndex = { }
  for globalID, change in pairs(t) do
    table.insert(sortIndex, globalID)
  end
  table.sort(sortIndex, function(a,b)
    --self:DebugPrint("a = "..a..", b = "..b)
    return infoCache[a].name < infoCache[b].name
  end)
  local str = ""
  for i, globalID in ipairs(sortIndex) do
    str = str .. infoCache[globalID].link .. ", "
  end
  if #sortIndex > 0 then
    return string.sub(str, 1, -3) -- trim off final ", "
  else
    return nil
  end
end

function LA:PrintPending()
  if self.saved.filterSpam == self.FILTER_SUMMARIZE then
    local learned = self:FormatSpells(self.spellsLearned)
    local unlearned = self:FormatSpells(self.spellsUnlearned)
    if unlearned then self:SystemPrint(self:GetText("youHaveUnlearned", unlearned)) end
    if learned then self:SystemPrint(self:GetText("youHaveLearned", learned)) end

    if #self.petUnlearned > 0 then
      table.sort(self.petUnlearned)
      self:SystemPrint(self:GetText("yourPetHasUnlearned", self:ListJoin(self.petUnlearned)))
    end
    if #self.petLearned > 0 then
      table.sort(self.petLearned)
      self:SystemPrint(self:GetText("yourPetHasLearned", self:ListJoin(self.petLearned)))
    end
  end
  wipe(self.petLearned)
  wipe(self.petUnlearned)
  wipe(self.spellsLearned)
  wipe(self.spellsUnlearned)
  wipe(self.pendingTalents)
end


function LA:OnShow()
  self:RegisterEvent("COMPANION_UPDATE", "OnEvent")
  self:RegisterEvent("TRADE_SKILL_SHOW", "OnEvent")
  self:RegisterEvent("TRADE_SKILL_CLOSE", "OnEvent")
  self:RegisterEvent("SPELL_UPDATE_COOLDOWN", "OnEvent")
  self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED", "OnEvent")
end
function LA:OnHide()
  self:UnregisterEvent("COMPANION_UPDATE")
  self:UnregisterEvent("TRADE_SKILL_SHOW")
  self:UnregisterEvent("TRADE_SKILL_CLOSE")
  self:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
  self:UnregisterEvent("CURRENT_SPELL_CAST_CHANGED")
end
function LA:Lock()
    self.saved.locked = true
    self.menuTable[1].text = self:GetText("unlockPosition")
end
function LA:Unlock()
    self.saved.locked = false
    self.menuTable[1].text = self:GetText("lockPosition")
end
function LA:ToggleLock()
  if self.saved.locked then
    self:Unlock()
  else
    self:Lock()
  end
end

function LA:PurgeConfig()
  wipe(self.saved)
  wipe(self.character)
  self:SetDefaultSettings()
end