local type = type
local pairs = pairs
local strfind = string.find
local UnitCastingInfo, UnitAura, UnitIsDeadOrGhost = UnitCastingInfo, UnitAura, UnitIsDeadOrGhost

Gladius = { }
Gladius.eventHandler = CreateFrame("Frame")
Gladius.eventHandler.events = { }

Gladius.eventHandler:RegisterEvent("PLAYER_LOGIN")
Gladius.eventHandler:RegisterEvent("ADDON_LOADED")
Gladius.eventHandler:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")

Gladius.eventHandler:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		Gladius:OnInitialize()
		Gladius:OnEnable()
		Gladius.eventHandler:UnregisterEvent("PLAYER_LOGIN")
	else
		local func = self.events[event]
		if type(Gladius[func]) == "function" then
			Gladius[func](Gladius, event, ...)
		end
	end
end)

Gladius.modules = { }
Gladius.defaults = { }

local L

function Gladius:Call(handler, func, ...)
	-- module disabled, return
	if not handler.IsEnabled then
		return
	end
	-- save module function call
	if type(handler[func]) == "function" then
		handler[func](handler, ...)
	end
end

function Gladius:Debug(...)
	print("|cff33ff99Gladius|r:", ...)
end

function Gladius:Print(...)
	print("|cff33ff99Gladius|r:", ...)
end

function Gladius:SendMessage(event, ...)
	for _, module in pairs(self.modules) do
		self:Call(module, module.messages[event], ...)
	end
end

function Gladius:RegisterEvent(event, func)
	self.eventHandler.events[event] = func or event
	self.eventHandler:RegisterEvent(event)
end

function Gladius:UnregisterEvent(event)
	self.eventHandler.events[event] = nil
	self.eventHandler:UnregisterEvent(event)
end

function Gladius:UnregisterAllEvents()
	self.eventHandler:UnregisterAllEvents()
end

function Gladius:NewModule(key, bar, attachTo, defaults, templates)
	local module = { }
	module.eventHandler = CreateFrame("Frame")
	-- event handling
	module.eventHandler.events = { }
	module.eventHandler.messages = { }
	module.eventHandler:SetScript("OnEvent", function(self, event, ...)
		local func = module.eventHandler.events[event]
		if type(module[func]) == "function" then
			module[func](module, event, ...)
		end
	end)
	module.RegisterEvent = function(self, event, func)
		self.eventHandler.events[event] = func or event
		self.eventHandler:RegisterEvent(event)
	end
	module.UnregisterEvent = function(self, event)
		self.eventHandler.events[event] = nil
		self.eventHandler:UnregisterEvent(event)
	end
	module.UnregisterAllEvents = function(self)
		self.eventHandler:UnregisterAllEvents()
	end
	-- module status
	module.Enable = function(self)
		if not self.enabled then
			self.enabled = true	
			if type(self.OnEnable) == "function" then
				self:OnEnable()
			end
		end
	end
	module.Disable = function(self)
		if (self.enabled) then
			self.enabled = false
			if type(self.OnDisable) == "function" then
				self:OnDisable()
			end
		end
	end
	module.IsEnabled = function(self)
		return self.enabled
	end
	-- message system
	module.RegisterMessage = function(self, event, func)
		self.eventHandler.messages[event] = func or self[event]
	end
	
	module.SendMessage = function(self, event, ...)
		for _, module in pairs(Gladius.modules) do
			self:Call(module, module.eventHandler.messages[event], ...)
		end
	end
	-- register module
	module.name = key
	module.isBarOption = bar
	--module.isBar = bar
	module.defaults = defaults
	module.attachTo = attachTo
	module.templates = templates
	module.messages = { }
	self.modules[key] = module
	-- set db defaults
	for k,v in pairs(defaults) do
		self.defaults.profile[k] = v
	end
	return module
end

function Gladius:GetParent(unit, module)
	-- get parent frame
	if module == "Frame" then
		return self.buttons[unit]
	else
		-- get parent module frame
		local m = self:GetModule(module, true)
		if m and type(m.GetFrame) == "function" then
			-- return frame as parent, if parent module is not enabled
			if not m:IsEnabled() then
				return self.buttons[unit]
			end
			-- update module, if frame doesn't exist
			local frame = m:GetFrame(unit)
			if not frame then
				self:Call(m, "Update", unit)
				frame = m:GetFrame(unit)
			end
				return frame
			end
		return nil
	end
end

function Gladius:EnableModule(name)
	self:Call(self.modules[name], "Enable")
end

function Gladius:DisableModule(name)
	self:Call(self.modules[name], "Disable")
end

function Gladius:GetModule(name)
	return self.modules[name]
end

function Gladius:GetModules(module)
	-- get module list for frame anchor
	local t = {["Frame"] = L["Frame"]}
	for moduleName, m in pairs(self.modules) do
		if moduleName ~= module and m:GetAttachTo() ~= module and m.attachTo and m:IsEnabled() then
			t[moduleName] = L[moduleName]
		end
	end
	return t
end

function Gladius:OnInitialize()
	-- setup db
	self.dbi = LibStub("AceDB-3.0"):New("Gladius2DB", self.defaults)
	self.dbi.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.dbi.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.dbi.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	local SML = LibStub:GetLibrary("LibSharedMedia-3.0")
	SML:Register(SML.MediaType.STATUSBAR, "Smooth", "Interface\\Addons\\Gladius\\Images\\Smooth")
	self.db = setmetatable(self.dbi.profile, {
		__newindex = function(t, index, value)
		if type(value) == "table" then
			rawset(self.defaults.profile, index, value)
		end
		rawset(t, index, value)
	end})
	-- option reset (increase number)
	--[[self.version = 2
	if self.db.version == nil or self.db.version < self.version then
		print("Gladius:", "Resetting options...") 
		self.dbi:ResetProfile()
	end
	self.db.version = self.version]]
	-- localization
	L = self.L
	-- libsharedmedia
	self.LSM = LibStub("LibSharedMedia-3.0")
	self.LSM:Register("statusbar", "minimalist", "Interface\\Addons\\Gladius\\Images\\Minimalist")
	-- test environment
	self.test = false
	self.testCount = 0
	self.testing = setmetatable({
		["arena1"] = { health = 400000, maxHealth = 400000, power = 300000, maxPower = 300000, powerType = 0, unitClass = "MAGE", unitRace = "Draenei", unitSpec = "Frost" },
		["arena2"] = { health = 380000, maxHealth = 400000, power = 100000, maxPower = 300000, powerType = 2, unitClass = "PRIEST", unitRace = "Night Elf", unitSpec = "Discipline" },
		["arena3"] = { health = 240000, maxHealth = 400000, power = 90, maxPower = 130, powerType = 3, unitClass = "ROGUE", unitRace = "Human", unitSpec = "Combat" },
		["arena4"] = { health = 200000, maxHealth = 400000, power = 80, maxPower = 100, powerType = 6, unitClass = "DEATHKNIGHT", unitRace = "Dwarf", unitSpec = "Unholy" },
		["arena5"] = { health = 150000, maxHealth = 400000, power = 30, maxPower = 100, powerType = 1, unitClass = "WARRIOR", unitRace = "Gnome", unitSpec = "Arms" },
	},
	{
		__index = function(t, k)
			return t["arena1"]
		end
	})
	-- spec detection
	self.specSpells = self:GetSpecList()
	-- buttons
	self.buttons = { }
end

function Gladius:OnEnable()
	-- register the appropriate events that fires when you enter an arena
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
	-- enable modules
	for moduleName, module in pairs(self.modules) do
		if self.db.modules[moduleName] then
			module:Enable()
		else
			module:Disable()
		end
	end
	-- display help message
	if not self.db.locked and not self.db.x["arena1"] and not self.db.y["arena1"] then
		SlashCmdList["GLADIUS"]("test 5")
		self:Print(L["Welcome to Gladius!"])
		self:Print(L["First run has been detected, displaying test frame."])
		self:Print(L["Valid slash commands are:"])
		self:Print(L["/gladius ui"])
		self:Print(L["/gladius test 2-5"])
		self:Print(L["/gladius hide"])
		self:Print(L["/gladius reset"])
		self:Print(L["If this is not your first run please lock or move the frame to prevent this from happening."])
	end
	-- clique
	if IsAddOnLoaded("Clique") then
		SlashCmdList["GLADIUS"]("test 5")
		SlashCmdList["GLADIUS"]("hide")	
		ClickCastFrames = ClickCastFrames or { }
		ClickCastFrames[self.buttons.arena1.secure] = true
		ClickCastFrames[self.buttons.arena2.secure] = true
		ClickCastFrames[self.buttons.arena3.secure] = true
		ClickCastFrames[self.buttons.arena4.secure] = true
		ClickCastFrames[self.buttons.arena5.secure] = true
	end
	-- see if we are already in arena
	if IsLoggedIn() then
		Gladius:ZONE_CHANGED_NEW_AREA()
	end
end

function Gladius:OnDisable()
	-- unregister events and disable modules
	self:UnregisterAllEvents()
	for _, module in pairs(self.modules) do
		module:Disable()
		self:Call(module, "OnDisable")
	end
end

function Gladius:OnProfileChanged(event, database, newProfileKey)
	-- update frame on profile change
	self:Call(self.modules["Tags"], OnProfileChanged)
	self:UpdateFrame()
end

function Gladius:ZONE_CHANGED_NEW_AREA()
	local type = select(2, IsInInstance())
	-- check if we are entering or leaving an arena 
	if type == "arena" then
		self:JoinedArena()
	elseif type ~= "arena" and self.instanceType == "arena" then
		self:LeftArena()
	end
	self.instanceType = type
end

function Gladius:JoinedArena()
	-- enemy events
	--self:RegisterEvent("UNIT_PET")
	-- special arena event
	self:RegisterEvent("UNIT_NAME_UPDATE")
	self:RegisterEvent("ARENA_OPPONENT_UPDATE") 
	self:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
	self:RegisterEvent("UNIT_HEALTH") 
	self:RegisterEvent("UNIT_MAXHEALTH", "UNIT_HEALTH")
	-- spec detection
	self:RegisterEvent("UNIT_AURA") 
	self:RegisterEvent("UNIT_SPELLCAST_START")
	-- reset test
	self.test = false
	self.testCount = 0
	-- create and update buttons on first launch
	local groupSize = max(GetNumGroupMembers())
	for i = 1, groupSize do
		self:UpdateUnit("arena"..i)
		self.buttons["arena"..i]:RegisterForDrag("LeftButton")
	end
	-- hide buttons
	self:HideFrame()
	-- background
	if self.db.groupButtons then
		self.background:SetAlpha(1)
		if not self.db.locked then
			self.anchor:SetAlpha(1)
			self.anchor:SetFrameStrata("LOW")
		end
	end
end

function Gladius:LeftArena()
	self:HideFrame()
	-- reset units
	for unit, _ in pairs(self.buttons) do
		Gladius.buttons[unit]:RegisterForDrag()
		Gladius.buttons[unit]:Hide()
		self:ResetUnit(unit)
	end
	-- unregister combat events
	self:UnregisterAllEvents()
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
end

function Gladius:UNIT_NAME_UPDATE(event, unit)
	if not IsActiveBattlefieldArena() then
		return
	end
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	if not self.buttons[unit] or self.buttons[unit]:GetAlpha() < 1 then
		self:ShowUnit(unit)
	end
end

function Gladius:ARENA_OPPONENT_UPDATE(event, unit, type)
	-- enemy seen
	if type == "seen" or type == "destroyed" then
		if not self.buttons[unit] or self.buttons[unit]:GetAlpha() < 1 then
			self:ShowUnit(unit)
		end
	-- enemy stealth
	elseif type == "unseen" then
		self:UpdateAlpha(unit, self.db.stealthAlpha)
	-- enemy left arena
	elseif type == "cleared" then
		--self:ResetUnit(unit)
	end
end

function Gladius:UpdateFrame()
	self.db = self.dbi.profile
	-- TODO: check why we need this
	self.buttons = self.buttons or { }
	for unit, _ in pairs(self.buttons) do
		local unitId = tonumber(string.match(unit, "^arena(.+)"))
		if self.testCount >= unitId then
			-- update frame will only be called in the test environment
			self:UpdateUnit(unit)
			if not self.buttons[unit] or self.buttons[unit]:GetAlpha() < 1 then
				self:ShowUnit(unit, true)
			end
			-- test environment
			if self.test then
				self:TestUnit(unit)
			end
		end
	end
end

function Gladius:HideFrame()
	-- hide units
	for unit, _ in pairs(self.buttons) do
		self:ResetUnit(unit)
	end
	-- hide background
	if self.background then
		self.background:SetAlpha(0)
		--self.background:Hide()
	end
	-- hide anchor
	if self.anchor then
		--self.anchor:SetAlpha(0)
		self.anchor:Hide()
	end
end

function Gladius:UpdateUnit(unit, module)
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	if InCombatLockdown() then
		return
	end
	-- create button 
	if not self.buttons[unit] then
		self:CreateButton(unit)
	end
	local height = 0
	local frameHeight = 0
	-- spec
	self.buttons[unit].spec = ""
	-- Update spec from API
	local numOpps = GetNumArenaOpponentSpecs()
	for i = 1, numOpps do
		local specID = GetArenaOpponentSpec(i)
		if specID > 0 then
			local _, spec, _, specIcon, _, _, class = GetSpecializationInfoByID(specID)
			if not(Gladius.buttons["arena"..i] == null) then
				Gladius.buttons["arena"..i].spec = spec
			end
		end
	end
	-- default height values
	self.buttons[unit].frameHeight = 1
	self.buttons[unit].height = 1
	-- reset hit rect
	self.buttons[unit]:SetHitRectInsets(0, 0, 0, 0) 
	self.buttons[unit].secure:SetHitRectInsets(0, 0, 0, 0)
	-- update modules (bars first, because we need the height)
	for _, m in pairs(self.modules) do
		if m:IsEnabled() then
			-- update and get bar height
			if m.isBarOption then
				if module == nil or (module and m.name == module) then
					self:Call(m, "Update", unit)
				end
				local attachTo = m:GetAttachTo()
				if attachTo == "Frame" or m.isBar then
					frameHeight = frameHeight + (m.frame[unit] and m.frame[unit]:GetHeight() or 0)
				else
					height = height + (m.frame[unit] and m.frame[unit]:GetHeight() or 0)
				end
			end
		end
	end
	self.buttons[unit].height = height + frameHeight
	self.buttons[unit].frameHeight = frameHeight
	-- update button 
	self.buttons[unit]:SetScale(self.db.frameScale)
	self.buttons[unit]:SetWidth(self.db.barWidth)
	self.buttons[unit]:SetHeight(frameHeight)
	-- update modules (indicator)
	local indicatorHeight = 0
	for _, m in pairs(self.modules) do
		if m:IsEnabled() and not m.isBarOption then
			self:Call(m, "Update", unit)
		end
	end
	-- set point
	self.buttons[unit]:ClearAllPoints()
	if unit == "arena1" or not self.db.groupButtons then
		if (not self.db.x and not self.db.y) or (not self.db.x[unit] and not self.db.y[unit]) then
			self.buttons[unit]:SetPoint("CENTER")
		else
			local scale = self.buttons[unit]:GetEffectiveScale()
			self.buttons[unit]:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.x[unit] / scale, self.db.y[unit] / scale)
		end
	else
	local parent = string.match(unit, "^arena(.+)") - 1
	local parentButton = self.buttons["arena"..parent]
	if parentButton then
		if self.db.growUp then
			self.buttons[unit]:SetPoint("BOTTOMLEFT", parentButton, "TOPLEFT", 0, self.db.bottomMargin + indicatorHeight)
			else
				self.buttons[unit]:SetPoint("TOPLEFT", parentButton, "BOTTOMLEFT", 0, - self.db.bottomMargin - indicatorHeight)
			end
			if self.db.growLeft then
				local left, right = self.buttons[unit]:GetHitRectInsets()
				self.buttons[unit]:SetPoint("TOPLEFT", parentButton, "TOPLEFT", - self.buttons[unit]:GetWidth() - self.db.backgroundPadding - abs(left), 0)
			end
			if self.db.growRight then
				local left, right = self.buttons[unit]:GetHitRectInsets()
				self.buttons[unit]:SetPoint("TOPLEFT", parentButton, "TOPLEFT", self.buttons[unit]:GetWidth() + self.db.backgroundPadding + abs(left), 0)
			end
		end
	end 
	-- show the button
	self.buttons[unit]:Show()
	self.buttons[unit]:SetAlpha(0)
	-- update secure frame
	self.buttons[unit].secure:SetWidth(self.buttons[unit]:GetWidth())
	self.buttons[unit].secure:SetHeight(self.buttons[unit]:GetHeight())
	self.buttons[unit].secure:ClearAllPoints()
	self.buttons[unit].secure:SetAllPoints(self.buttons[unit])
	-- show the secure frame
	self.buttons[unit].secure:Show()
	self.buttons[unit].secure:SetAlpha(1)
	self.buttons[unit]:SetFrameStrata("LOW")
	self.buttons[unit].secure:SetFrameStrata("MEDIUM")
	-- update background
	if unit == "arena1" then
		local left, right = self.buttons[unit]:GetHitRectInsets()
		-- background
		self.background:SetBackdropColor(self.db.backgroundColor.r, self.db.backgroundColor.g, self.db.backgroundColor.b, self.db.backgroundColor.a)
		self.background:SetWidth(self.buttons[unit]:GetWidth() + self.db.backgroundPadding * 2 + abs(right) + abs(left))
		self.background:ClearAllPoints()
		if self.db.growUp then
			self.background:SetPoint("BOTTOMLEFT", self.buttons["arena1"], "BOTTOMLEFT", - self.db.backgroundPadding + left, - self.db.backgroundPadding)
		else
			self.background:SetPoint("TOPLEFT", self.buttons["arena1"], "TOPLEFT", - self.db.backgroundPadding + left, self.db.backgroundPadding)
		end
		self.background:SetScale(self.db.frameScale)
		if self.db.groupButtons then
			self.background:Show()
			self.background:SetAlpha(0)
		else
			self.background:Hide()
		end
		-- anchor
		self.anchor:ClearAllPoints()
		if self.db.backgroundColor.a > 0 then
			self.anchor:SetWidth(self.buttons[unit]:GetWidth() + self.db.backgroundPadding * 2 + abs(right) + abs(left))
			if self.db.growUp then
				self.anchor:SetPoint("TOPLEFT", self.background, "BOTTOMLEFT")
			else
				self.anchor:SetPoint("BOTTOMLEFT", self.background, "TOPLEFT")
			end
		else
			self.anchor:SetWidth(self.buttons[unit]:GetWidth() + abs(right) + abs(left))
			if self.db.growUp then
				self.anchor:SetPoint("TOPLEFT", self.buttons["arena1"], "BOTTOMLEFT", left, 0)
			else
				self.anchor:SetPoint("BOTTOMLEFT", self.buttons["arena1"], "TOPLEFT", left, 0)
			end
		end
		self.anchor:SetHeight(20)
		self.anchor:SetScale(self.db.frameScale)
		self.anchor.text:SetPoint("CENTER", self.anchor, "CENTER")
		self.anchor.text:SetFont(self.LSM:Fetch(self.LSM.MediaType.FONT, Gladius.db.globalFont), (Gladius.db.useGlobalFontSize and Gladius.db.globalFontSize or 11))
		self.anchor.text:SetTextColor(1, 1, 1, 1)
		self.anchor.text:SetShadowOffset(1, - 1)
		self.anchor.text:SetShadowColor(0, 0, 0, 1)
		self.anchor.text:SetText(L["Gladius Anchor - click to move"])
		if self.db.groupButtons and not self.db.locked then
			self.anchor:Show()
			self.anchor:SetAlpha(0)
		else
			self.anchor:Hide()
		end
	end
end

function Gladius:ShowUnit(unit, testing, module)
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	if not self.buttons[unit] then
		return
	end
	-- disable test mode, when there are real arena opponents (happens when entering arena and using /gladius test)
	local testing = testing or false
	if not testing and self.test then 
		-- reset frame
		self:HideFrame()
		-- disable test mode
		self.test = false
	end
	self.buttons[unit]:SetAlpha(1)
	for _, m in pairs(self.modules) do
		if m:IsEnabled() then
			if module == nil or (module and m.name == module) then
				self:Call(m, "Show", unit)
			end
		end
	end
	-- background
	if self.db.groupButtons then
		self.background:SetAlpha(1)
		if not self.db.locked then
			self.anchor:SetAlpha(1)
			self.anchor:SetFrameStrata("LOW")
		end
	end
	local maxHeight = 0
	for u, button in pairs(self.buttons) do
		local unitId = tonumber(string.match(u, "^arena(.+)"))
		if button:GetAlpha() > 0 then
			maxHeight = math.max(maxHeight, unitId)
		end
	end
	-- Update spec from API
	local numOpps = GetNumArenaOpponentSpecs()
	for i = 1, numOpps do
		local specID = GetArenaOpponentSpec(i)
		if specID > 0 then
			local _, spec, _, specIcon, _, _, class = GetSpecializationInfoByID(specID)
			Gladius.buttons["arena"..i].spec = spec
		end
	end
	self.background:SetHeight(self.buttons[unit]:GetHeight() * maxHeight + self.db.bottomMargin * (maxHeight - 1) + self.db.backgroundPadding * 2)
end

function Gladius:TestUnit(unit, module)
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	-- test modules
	for _, m in pairs(self.modules) do
		if m:IsEnabled() then
			if module == nil or (module and m.name == module) then
				self:Call(m, "Test", unit)
			end
		end
	end
	-- disable secure frame in test mode so we can move the frame
	self.buttons[unit]:SetFrameStrata("LOW")
	self.buttons[unit].secure:SetFrameStrata("BACKGROUND")
end

function Gladius:ResetUnit(unit, module)
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	if not self.buttons[unit] then
		return
	end
	-- reset modules
	for _, m in pairs(self.modules) do
		if m:IsEnabled() then
			if module == nil or (module and m.name == module) then
				self:Call(m, "Reset", unit)
			end
		end
	end
	self.buttons[unit].spec = ""
	-- hide the button
	self.buttons[unit]:SetAlpha(0)
	-- hide the secure frame
	self.buttons[unit].secure:SetAlpha(0)
end

function Gladius:UpdateAlpha(unit, alpha)
	-- update button alpha
	alpha = alpha and alpha or 0.25
	if self.buttons[unit] then 
		self.buttons[unit]:SetAlpha(alpha)
	end
end

function Gladius:CreateButton(unit)
	local button = CreateFrame("Frame", "GladiusButtonFrame"..unit, UIParent)
	--[[button:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,})
	button:SetBackdropColor(0, 0, 0, 0.4)]]
	button:SetClampedToScreen(true)
	button:EnableMouse(true)
	button:SetMovable(true)
	button:RegisterForDrag("LeftButton")
	button:SetScript("OnDragStart", function(f)
		if not InCombatLockdown() and not self.db.locked then
			local f = self.db.groupButtons and self.buttons["arena1"] or f
			f:StartMoving()
		end
	end)
	button:SetScript("OnDragStop", function(f)
		if not InCombatLockdown() then
			local f = self.db.groupButtons and self.buttons["arena1"] or f
			local unit = self.db.groupButtons and "arena1" or unit
			f:StopMovingOrSizing()
			local scale = f:GetEffectiveScale()
			self.db.x[unit] = f:GetLeft() * scale
			self.db.y[unit] = f:GetTop() * scale
		end
	end)
	-- secure
	local secure = CreateFrame("Button", "GladiusButton"..unit, button, "SecureActionButtonTemplate")
	secure:RegisterForClicks("AnyUp")
	button.secure = secure
	self.buttons[unit] = button
	-- group background
	if unit == "arena1" then
		-- anchor
		local anchor = CreateFrame("Frame", "GladiusButtonAnchor", UIParent)
		anchor:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
		anchor:SetBackdropColor(0, 0, 0, 1)
		anchor:SetClampedToScreen(true)
		anchor:EnableMouse(true)
		anchor:SetMovable(true)
		anchor:RegisterForDrag("LeftButton")
		anchor:SetScript("OnDragStart", function(f)
			if not self.db.locked then
				local f = self.buttons["arena1"]
				f:StartMoving() 
			end
		end)
		anchor:SetScript("OnDragStop", function(f)
			local f = self.buttons["arena1"]
			f:StopMovingOrSizing()
			local scale = f:GetEffectiveScale()
			self.db.x[unit] = f:GetLeft() * scale
			self.db.y[unit] = f:GetTop() * scale
		end)
		anchor.text = anchor:CreateFontString("GladiusButtonAnchorText", "OVERLAY")
		self.anchor = anchor
		-- background
		local background = CreateFrame("Frame", "GladiusButtonBackground", UIParent)
		background:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
		background:SetBackdropColor(self.db.backgroundColor.r, self.db.backgroundColor.g, self.db.backgroundColor.b, self.db.backgroundColor.a)
		background:SetFrameStrata("BACKGROUND")
		self.background = background
	end
end

function Gladius:UNIT_AURA(event, unit)
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	if not self.buttons[unit] or self.buttons[unit]:GetAlpha() < 1 then
		self:ShowUnit(unit)
	end
	local index = 1
	while true do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, "HELPFUL")
		if not name then
			break
		end
		if self.specSpells[name] and self.buttons[unitCaster] and self.buttons[unitCaster].spec == "" then
			--self.buttons[unitCaster].spec = self.specSpells[name]
			self:SendMessage("GLADIUS_SPEC_UPDATE", unitCaster)
		end
		index = index + 1
		-- Update spec from API
		local numOpps = GetNumArenaOpponentSpecs()
		for i = 1, numOpps do
			local specID = GetArenaOpponentSpec(i)
			if specID > 0 then
				local _, spec, _, specIcon, _, _, class = GetSpecializationInfoByID(specID)
				Gladius.buttons["arena"..i].spec = spec
			end
		end
	end
end

function Gladius:UNIT_SPELLCAST_START(event, unit)
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	if not self.buttons[unit] or self.buttons[unit]:GetAlpha() < 1 then
		self:ShowUnit(unit)
	end
	local spell = UnitCastingInfo(unit)
	if self.specSpells[spell] and self.buttons[unit].spec == "" then
		--self.buttons[unit].spec = self.specSpells[spell]
		self:SendMessage("GLADIUS_SPEC_UPDATE", unit)
	end
	-- Update spec from API
	local numOpps = GetNumArenaOpponentSpecs()
	for i = 1, numOpps do
		local specID = GetArenaOpponentSpec(i)
		if specID > 0 then
			local _, spec, _, specIcon, _, _, class = GetSpecializationInfoByID(specID)
			Gladius.buttons["arena"..i].spec = spec
		end
	end
end

function Gladius:UNIT_HEALTH(event, unit)
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	-- update unit
	if not self.buttons[unit] or self.buttons[unit]:GetAlpha() < 1 then
		self:ShowUnit(unit)
	end
	if UnitIsDeadOrGhost(unit) then
		self:UpdateAlpha(unit, 0.5)
	end
	-- Update spec from API
	local numOpps = GetNumArenaOpponentSpecs()
	for i = 1, numOpps do
		local specID = GetArenaOpponentSpec(i)
		if specID > 0 then
			local _, spec, _, specIcon, _, _, class = GetSpecializationInfoByID(specID)
			Gladius.buttons["arena"..i].spec = spec
		end
	end
end