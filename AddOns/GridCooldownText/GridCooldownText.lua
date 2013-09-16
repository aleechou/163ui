--------------------------------------------------------------------------------------------
-- GridCooldownText module setup
--------------------------------------------------------------------------------------------
local L = GridCooldownTextLocale
local Grid = Grid
local GridFrame = Grid:GetModule("GridFrame")
GridCooldownText = GridFrame:NewModule("GridCooldownText", "AceEvent-3.0")
local media = LibStub("LibSharedMedia-3.0", true)
local hasMediaWidgets = media and LibStub("AceGUISharedMediaWidgets-1.0", true)

GridCooldownText.defaultDB = {
	FontSize = 10,
	Font = "Arial Narrow",
  Alpha = 1,
}
GridCooldownText.options = {
  type = "group", --inline = true,
  name = L["Cooldown Text"],
  desc = L["Cooldown Text options."],
  order = 1000,
  args = {
    ["fontsize"] = {
      type = "range", width = "double", 
      name = L["Cooldown Text Font Size"],
      desc = L["Adjust the font size for Cooldown Text."],
      --order = 111,
      disabled = function() return not GridFrame.db.profile.enableIconCooldown end,
      min = 6,
      max = 24,
      step = 1,
      get = function ()
        return GridCooldownText.db.profile.FontSize
      end,
      set = function(_, v)
        GridCooldownText.db.profile.FontSize = v
        local font = media and media:Fetch('font', GridCooldownText.db.profile.Font) or STANDARD_TEXT_FONT
        GridFrame:UpdateAllFrames()
        GridFrame:WithAllFrames(function (f) f.IconCD.Text:SetFont(font, v, "OUTLINE") end)
      end,
    },
    ["alpha"] = {
      type = "range", width = "double",
      name = L["Cooldown Alpha"],
      desc = L["Adjust the opacity of the Cooldown."],
      --order = 111,
      disabled = function() return not GridFrame.db.profile.enableIconCooldown end,
      min = 0,
      max = 1,
      step = 0.1,
      get = function ()
        return GridCooldownText.db.profile.Alpha
      end,
      set = function(_, v)
        GridCooldownText.db.profile.Alpha = v
        GridFrame:UpdateAllFrames()
        GridFrame:WithAllFrames(function (f) f.IconCD:SetAlpha(v) end)
      end,
    },
  }
}

if media then
  GridCooldownText.options.args["font"] = {
    type = "select", width = "double", 
    name = L["Cooldown Text Font"],
    desc = L["Adjust the font setting for Cooldown Text."],
    -- order = 112,
    disabled = function() return not GridFrame.db.profile.enableIconCooldown end,
    values = media:HashTable("font"),
    dialogControl = hasMediaWidgets and "LSM30_Font",
    get = function ()
      return GridCooldownText.db.profile.Font
    end,
    set = function(_, v)
      GridCooldownText.db.profile.Font = v
      local font = media:Fetch("font", v)
      local fontsize = GridCooldownText.db.profile.FontSize
      GridFrame:WithAllFrames(function (f) f.IconCD.Text:SetFont(font, fontsize, "OUTLINE") end)
    end,
  }
end

function GridCooldownText:OnInitialize()
	GridFrame:RegisterModule(self.moduleName, self)
	hooksecurefunc(GridFrame, "InitializeFrame", GridCooldownText.CreateFrames)
	if IsLoggedIn() then
		GridFrame:WithAllFrames(function(f) GridCooldownText.CreateFrames(nil, f) end)
	end
end

function GridCooldownText:OnEnable()
end

function GridCooldownText:OnDisable()
end

function GridCooldownText:Reset() -- this empty methods are needed or error when called in GridCore
end

--------------------------------------------------------------------------------------------
-- utility functions
--------------------------------------------------------------------------------------------
local function getTimeText(time)
	local text
	local minutes = math.floor(time / 60)
	local seconds = math.ceil(time % 60)
	if minutes > 89 then
		text = format("%dh", math.ceil(time / 3600))
	elseif minutes > 0 then
		text = format("%dm", minutes)
	else
		text = seconds
	end
	return text
end

--------------------------------------------------------------------------------------------
-- FontString Update code
--------------------------------------------------------------------------------------------
local updatePeriod = 0.1
local activeCooldowns = {}

-- Frame to run the OnUpdate script that will update the FontStrings
local onUpdateFrame = CreateFrame("Frame")
local lastUpdate = 0
onUpdateFrame:SetScript("OnUpdate", function(self, elapsed) GridCooldownText_UpdateStrings(self, elapsed) end)

-- variable to store the current time, updated each update Period
local currentTime = GetTime()

function GridCooldownText_UpdateStrings(self, elapsed)
	lastUpdate = lastUpdate + elapsed
	if lastUpdate > updatePeriod then
		lastUpdate = 0
		currentTime = GetTime()
		local activeString = false
		for modelFrame, text in pairs(activeCooldowns) do
			local hideText = true
			if modelFrame:IsShown() then
				if text.start < currentTime then
					local timeLeft = text.endTime - currentTime
					if timeLeft > updatePeriod then
						text:SetText(getTimeText(timeLeft))
						activeString = true
						hideText = false
					end
				else
					hideText = false
				end
			end
			if hideText then
				text:Hide()
				activeCooldowns[modelFrame] = nil
			end
		end
		if not activeString then
			self:Hide()
		end
	end
end

local function hookSetCooldown(self, start, duration)
    self.SetCooldownOld(self, start, duration)
    local text = self.Text
    if start > 0 and duration >= 2 then
        text.start = start
        text.endTime = start + duration
        if GetTime() > start then
            duration = text.endTime - GetTime()
        end
        text:SetText(getTimeText(duration))
        text:Show()
        activeCooldowns[self] = text
        onUpdateFrame:Show()
    end
end

function GridCooldownText.CreateFrames(gridFrameObj, f)
	-- set media based on shared media
	local font = media and media:Fetch("font", GridCooldownText.db.profile.Font) or STANDARD_TEXT_FONT
	local size = GridCooldownText.db.profile.FontSize or 10
  
	f.IconCD:SetAlpha(GridCooldownText.db.profile.Alpha or 1)
	-- create cooldown icon text
	f.IconCD.Text = f.IconCD:CreateFontString(nil, "OVERLAY")
	f.IconCD.Text:SetAllPoints(f.IconBG)
	f.IconCD.Text:SetFontObject(NumberFontNormalYellow)
	f.IconCD.Text:SetFont(font, size, "OUTLINE")
	f.IconCD.Text:SetJustifyH("CENTER")
	f.IconCD.Text:SetJustifyV("CENTER")
	
	f.IconCD.noCooldownCount = true --avoid OmniCC duplicated text
	
	f.IconCD.SetCooldownOld = f.IconCD.SetCooldown
	f.IconCD.SetCooldown = hookSetCooldown
end
