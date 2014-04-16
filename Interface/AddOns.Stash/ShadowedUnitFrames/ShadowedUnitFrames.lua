--[[ 
	Shadowed Unit Frames, Shadow of Mal'Ganis (US) PvP
]]

ShadowUF = select(2, ...)

local L = ShadowUF.L
ShadowUF.dbRevision = 35
ShadowUF.playerUnit = "player"
ShadowUF.enabledUnits = {}
ShadowUF.modules = {}
ShadowUF.moduleOrder = {}
ShadowUF.unitList = {"player", "pet", "pettarget", "target", "targettarget", "targettargettarget", "focus", "focustarget", "party", "partypet", "partytarget", "raid", "raidpet", "boss", "bosstarget", "maintank", "maintanktarget", "mainassist", "mainassisttarget", "arena", "arenatarget", "arenapet", "battleground", "battlegroundtarget", "battlegroundpet"}
ShadowUF.fakeUnits = {["targettarget"] = true, ["targettargettarget"] = true, ["pettarget"] = true, ["arenatarget"] = true, ["focustarget"] = true, ["focustargettarget"] = true, ["partytarget"] = true, ["raidtarget"] = true, ["bosstarget"] = true, ["maintanktarget"] = true, ["mainassisttarget"] = true, ["battlegroundtarget"] = true}
L.units = {["raidpet"] = L["Raid pet"], ["PET"] = L["Pet"], ["VEHICLE"] = L["Vehicle"], ["arena"] = L["Arena"], ["arenapet"] = L["Arena Pet"], ["arenatarget"] = L["Arena Target"], ["boss"] = L["Boss"], ["bosstarget"] = L["Boss Target"], ["focus"] = L["Focus"], ["focustarget"] = L["Focus Target"], ["mainassist"] = L["Main Assist"], ["mainassisttarget"] = L["Main Assist Target"], ["maintank"] = L["Main Tank"], ["maintanktarget"] = L["Main Tank Target"], ["party"] = L["Party"], ["partypet"] = L["Party Pet"], ["partytarget"] = L["Party Target"], ["pet"] = L["Pet"], ["pettarget"] = L["Pet Target"], ["player"] = L["Player"],["raid"] = L["Raid"], ["target"] = L["Target"], ["targettarget"] = L["Target of Target"], ["targettargettarget"] = L["Target of Target of Target"], ["battleground"] = L["Battleground"], ["battlegroundpet"] = L["Battleground Pet"], ["battlegroundtarget"] = L["Battleground Target"]}
L.shortUnits = {["battleground"] = L["BG"], ["battlegroundtarget"] = L["BG Target"], ["battlegroundpet"] = L["BG Pet"]}

-- Cache the units so we don't have to concat every time it updates
ShadowUF.unitTarget = setmetatable({}, {__index = function(tbl, unit) rawset(tbl, unit, unit .. "target"); return unit .. "target" end})
ShadowUF.partyUnits, ShadowUF.raidUnits, ShadowUF.raidPetUnits, ShadowUF.bossUnits, ShadowUF.arenaUnits, ShadowUF.battlegroundUnits = {}, {}, {}, {}, {}, {}
ShadowUF.maintankUnits, ShadowUF.mainassistUnits, ShadowUF.raidpetUnits = ShadowUF.raidUnits, ShadowUF.raidUnits, ShadowUF.raidPetUnits
for i=1, MAX_PARTY_MEMBERS do ShadowUF.partyUnits[i] = "party" .. i end
for i=1, MAX_RAID_MEMBERS do ShadowUF.raidUnits[i] = "raid" .. i end
for i=1, MAX_RAID_MEMBERS do ShadowUF.raidPetUnits[i] = "raidpet" .. i end
for i=1, MAX_BOSS_FRAMES do ShadowUF.bossUnits[i] = "boss" .. i end
for i=1, 5 do ShadowUF.arenaUnits[i] = "arena" .. i end
for i=1, 4 do ShadowUF.battlegroundUnits[i] = "arena" .. i end

function ShadowUF:OnInitialize()
	self.defaults = {
		profile = {
			locked = false,
			advanced = false,
			tooltipCombat = false,
			omnicc = false,
			tags = {},
			units = {},
			positions = {},
			range = {},
			filters = {zonewhite = {}, zoneblack = {}, whitelists = {}, blacklists = {}},
			visibility = {arena = {}, pvp = {}, party = {}, raid = {}},
			hidden = {cast = false, playerPower = true, buffs = false, party = true, raid = false, player = true, pet = true, target = true, focus = true, boss = true, arena = true, playerAltPower = false},
		},
	}
	
	self:LoadUnitDefaults()
		
	-- Initialize DB
	self.db = LibStub:GetLibrary("AceDB-3.0"):New("ShadowedUFDB", self.defaults, true)
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfilesChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfilesChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfileReset")
		
	-- Setup tag cache
	self.tagFunc = setmetatable({}, {
		__index = function(tbl, index)
			if( not ShadowUF.Tags.defaultTags[index] and not ShadowUF.db.profile.tags[index] ) then
				tbl[index] = false
				return false
			end
			
			local func, msg = loadstring("return " .. (ShadowUF.Tags.defaultTags[index] or ShadowUF.db.profile.tags[index].func or ""))
			if( func ) then
				func = func()
			elseif( msg ) then
				error(msg, 3)
			end
			
			tbl[index] = func
			return tbl[index]
	end})
	
	if( not self.db.profile.loadedLayout ) then
		self:LoadDefaultLayout()
	else
		self:CheckUpgrade()
		self:CheckBuild()
	end

	self.db.profile.revision = self.dbRevision
	self:FireModuleEvent("OnInitialize")
	self:HideBlizzardFrames()
	self.Layout:LoadSML()
	self:LoadUnits()
	self.modules.movers:Update()
end

function ShadowUF:CheckBuild()
	local build = select(4, GetBuildInfo())
	if( self.db.profile.wowBuild == build ) then return end

	if( build == 50200 ) then
		self:Print("NOTE! As of 5.2.0, you can now use menus to perform secure actions such as Set/Clear Focus or reporting.")
		self:Print("SUF has been tested and confirmed to work with this setup. If menus do not show up, you may need to update Clique.")
		self:Print("If you still get action blocked issues, it is another addons fault and you should yell at that author for doing something bad.")
		self:Print("Raid dropdowns will still cause action blocked issues due to a bug with the toggle system unfortunately.")
	end

	self.db.profile.wowBuild = build
end


function ShadowUF:CheckUpgrade()
	local revision = self.db.profile.revision or self.dbRevision
	if( revision <= 34 ) then
		self.db.profile.units.player.staggerBar = {enabled = true, background = true, height = 0.30, order = 70}
		self.db.profile.powerColors.STAGGER_GREEN = {r = 0.52, g = 1.0, b = 0.52}
		self.db.profile.powerColors.STAGGER_YELLOW = {r = 1.0, g = 0.98, b = 0.72}
		self.db.profile.powerColors.STAGGER_RED = {r = 1.0, g = 0.42, b = 0.42}
	end

	if( revision <= 33 ) then
		for unit, config in pairs(self.db.profile.units) do
			if( not self.defaults.profile.units[unit].incHeal and config.incHeal ) then
				config.incHeal = nil
			end

			if( not self.defaults.profile.units[unit].incAbsorb and config.incAbsorb ) then
				config.incAbsorb = nil
			end

			if( config.incAbsorb ) then
				config.incAbsorb.cap = config.incAbsorb.cap or 1.30
			end

			if( config.incHeal ) then
				config.incHeal.cap = config.incHeal.cap or 1.30
			end
		end
	end

	if( revision <= 32 ) then
		for unit, config in pairs(self.db.profile.units) do
			if( config.incAbsorb and not config.incAbsorb.cap ) then
				config.incAbsorb.cap = 1.30
			end
		end
	end

	if( revision <= 31 ) then
		self.db.profile.healthColors.incAbsorb = {r = 0.93, g = 0.75, b = 0.09}

		for unit, config in pairs(self.db.profile.units) do
			if( config.incHeal ) then
				config.incHeal.enabled = config.incHeal.heals
				config.incHeal.heals = nil
				config.incAbsorb = {enabled = config.incHeal.enabled}
			end
		end
	end

	if( revision <= 30 ) then
		self.db.profile.powerColors.RUNEOFPOWER = {r = 0.35, g = 0.45, b = 0.60}
	end

	if( revision <= 29 ) then
		self.db.profile.units.player.totemBar.showAlways = true
	end

	if( revision <= 28 ) then
		self.db.profile.units.target.indicators.questBoss = {enabled = true, anchorPoint = "BR", size = 22, x = 9, y = 24, anchorTo = "$parent"}
		self.db.profile.units.focus.indicators.questBoss = {enabled = false, anchorPoint = "BR", size = 22, x = 7, y = 14, anchorTo = "$parent"}

		for unit, config in pairs(self.db.profile.units) do
			for key, module in pairs(ShadowUF.modules) do
				if( config[key] and ( module.moduleHasBar or module.isComboPoints or config[key].isBar or config[key].order ) ) then
					config[key].height = config[key].height or 0.40
				end
			end
		end
	end

	if( revision <= 27 ) then
		self.db.profile.healthColors.aggro = CopyTable(self.db.profile.healthColors.hostile)
	end

	if( revision <= 26 ) then
		for _, unit in pairs(self.unitList) do
			if( unit ~= "player" ) then
				for id, text in pairs(self.db.profile.units[unit].text) do
					if( text.anchorTo == "$demonicFuryBar" ) then
						self.db.profile.units[unit].text[id] = nil
					end
				end
			end
		end
	end

	if( revision <= 25 ) then
		table.insert(self.db.profile.units.player.text, {enabled = true, width = 1, name = L["Text"], text = "[druid:eclipse]", anchorTo = "$eclipseBar", anchorPoint = "CLI", size = -1, x = 0, y = 0})
	end

	if( revision <= 24 ) then
		self.db.profile.powerColors.AURAPOINTS = {r = 1.0, g = 0.80, b = 0}
		self.db.profile.units.player.auraPoints = {enabled = false, showAlways = true, anchorTo = "$parent", order = 60, anchorPoint = "BR", x = -3, y = 8, size = 14, spacing = -4, growth = "LEFT", isBar = true, height = 0.40}
	end

	if( revision <= 23 ) then
		self.db.profile.hidden.playerAltPower = false
		self.db.profile.powerColors.ALTERNATE = {r = 0.815, g = 0.941, b = 1}
	end

	if( revision <= 22 ) then
		self:LoadDefaultLayout(true)

		for _, unit in pairs(self.unitList) do
			if( ShadowUF.fakeUnits[unit] ) then
				self.db.profile.units[unit].altPowerBar.enabled = false
			end
		end
	end

	if( revision <= 21 ) then
		self.db.profile.powerColors["POWER_TYPE_FEL_ENERGY"] = {r = 0.878, g = 0.980, b = 0}
	end
	
	if( revision <= 20 ) then
		self.db.profile.powerColors["ALTERNATE"] = {r = 0.71, g = 0.0, b = 1.0}
		
		for _, unit in pairs(self.unitList) do
			self.db.profile.units[unit].altPowerBar.enabled = true
			self.db.profile.units[unit].altPowerBar.background = true
			self.db.profile.units[unit].altPowerBar.height = 0.40
			self.db.profile.units[unit].altPowerBar.order = 100
		end
	end
	
	if( revision <= 19 ) then
		self.db.profile.units.pet.altPowerBar.enabled = true
		table.insert(self.db.profile.units.player.text, {enabled = true, width = 1, name = L["Text"], text = "[warlock:demonic:curpp]", anchorTo = "$demonicFuryBar", anchorPoint = "C", size = -1, x = 0, y = 0})
	end

	if( revision <= 18 ) then
		self.db.profile.powerColors["MUSHROOMS"] = {r = 0.20, g = 0.90, b = 0.20}
		self.db.profile.powerColors["STATUE"] = {r = 0.35, g = 0.45, b = 0.60}
	end

	if( revision <= 17 ) then
		self.db.profile.units.target.indicators.petBattle = {enabled = true, anchorPoint = "BL", size = 18, x = -6, y = 14, anchorTo = "$parent"}
		self.db.profile.units.focus.indicators.petBattle = {enabled = false, anchorPoint = "BL", size = 18, x = -6, y = 12, anchorTo = "$parent"}
		self.db.profile.units.party.indicators.phase = {enabled = true}
	end

	if( revision <= 16 ) then
		self.db.profile.units.target.indicators.questBoss = {enabled = true, anchorPoint = "BR", size = 22, x = 9, y = 24, anchorTo = "$parent"}
		self.db.profile.units.focus.indicators.questBoss = {enabled = false, anchorPoint = "BR", size = 22, x = 7, y = 14, anchorTo = "$parent"}
	end

	if( revision <= 15 ) then
		self.db.profile.powerColors["DEMONICFURY"] = {r = 0.58, g = 0.51, b = 0.79}
		self.db.profile.powerColors["BURNINGEMBERS"] = {r = 0.58, g = 0.51, b = 0.79}
		self.db.profile.powerColors["FULLBURNINGEMBER"] = {r = 0.88, g = 0.09, b = 0.062}
		self.db.profile.powerColors["SHADOWORBS"] = {r = 0.58, g = 0.51, b = 0.79}

		self.db.profile.units.player.shadowOrbs = {anchorTo = "$parent", order = 60, height = 0.40, anchorPoint = "BR", x = -3, y = 6, size = 14, spacing = -4, growth = "LEFT", isBar = true, showAlways = true}
		self.db.profile.units.player.burningEmbersBar = {enabled = true, background = false, height = 0.40, order = 70}
		self.db.profile.units.player.demonicFuryBar = {enabled = true, background = false, height = 0.40, order = 70}
	end

	if( revision <= 14 ) then
		self.db.profile.powerColors["CHI"] = {r = 0.71, g = 1.0, b = 0.92}

		self.db.profile.units.player.chi = {anchorTo = "$parent", order = 60, height = 0.40, anchorPoint = "BR", x = -3, y = 6, size = 14, spacing = -4, growth = "LEFT", isBar = true, showAlways = true}
	end

	if( revision <= 13 ) then
		self.db.profile.powerColors["BANKEDHOLYPOWER"] = {r = 0.96, g = 0.61, b = 0.84}
	end

	if( revision <= 12 ) then
		self.db.profile.classColors["MONK"] = {r = 0.0, g = 1.00, b = 0.59}
	end

	if( revision <= 11 ) then
		for unit, config in pairs(self.db.profile.units) do
			if( config.powerBar ) then
				config.powerBar.colorType = "type"
			end
		end
	end

	if( revision <= 10 ) then
		for unit, config in pairs(self.db.profile.units) do
			if( config.healthBar ) then
				config.healthBar.predicted = nil
			end
		end

		for unit, config in pairs(self.db.profile.units) do
			if( unit ~= "party" and config.indicators and config.indicators.phase ) then
				config.indicators.phase = nil
			end
		end
	end

	if( revision <= 8 ) then
		for unit, config in pairs(self.db.profile.units) do
			if( config.incHeal ) then
				config.incHeal.heals = config.incHeal.enabled
			end
		end
	end

	if( revision <= 7 ) then
		self.db.profile.auraColors = {removable = {r = 1, g = 1, b = 1}}
	end

	if( revision <= 6 ) then
		for _, unit in pairs({"player", "focus", "target", "raid", "party", "mainassist", "maintank"}) do
			local db = self.db.profile.units[unit]
			if( not db.indicators.resurrect ) then
				if( unit == "target" ) then
					db.indicators.resurrect = {enabled = true, anchorPoint = "RC", size = 28, x = -39, y = -1, anchorTo = "$parent"}
				else
					db.indicators.resurrect = {enabled = true, anchorPoint = "LC", size = 28, x = 37, y = -1, anchorTo = "$parent"}
				end
			end
			
			if( unit == "party" and not db.indicators.phase ) then
			   db.indicators.phase = {enabled = false, anchorPoint = "BR", size = 23, x = 8, y = 36, anchorTo = "$parent"}
			end
		end
	end
end

function ShadowUF:LoadUnits()
	-- CanHearthAndResurrectFromArea() returns true for world pvp areas, according to BattlefieldFrame.lua
	local instanceType = CanHearthAndResurrectFromArea() and "pvp" or select(2, IsInInstance())
	if( instanceType == "scenario" ) then instanceType = "party" end

  	if( not instanceType ) then instanceType = "none" end
	
	for _, type in pairs(self.unitList) do
		local enabled = self.db.profile.units[type].enabled
		if( ShadowUF.Units.zoneUnits[type] and enabled ) then
			if( type == "boss" ) then
				enabled = (instanceType == "raid" or instanceType == "party")
			else
				enabled = ShadowUF.Units.zoneUnits[type] == instanceType
			end
		elseif( instanceType ~= "none" ) then
			if( self.db.profile.visibility[instanceType][type] == false ) then
				enabled = false
			elseif( self.db.profile.visibility[instanceType][type] == true ) then
				enabled = true
			end
		end
		
		self.enabledUnits[type] = enabled
		
		if( enabled ) then
			self.Units:InitializeFrame(type)
		else
			self.Units:UninitializeFrame(type)
		end
	end
end

function ShadowUF:LoadUnitDefaults()
	for _, unit in pairs(self.unitList) do
		self.defaults.profile.positions[unit] = {point = "", relativePoint = "", anchorPoint = "", anchorTo = "UIParent", x = 0, y = 0}
		
		-- The reason why the defaults are so sparse, is because the layout needs to specify most of this. The reason I set tables here is basically
		-- as an indication that hey, the unit wants this, if it doesn't that it won't want it.
		self.defaults.profile.units[unit] = {
			enabled = false, height = 0, width = 0, scale = 1.0,
			healthBar = {enabled = true},
			powerBar = {enabled = true},
			emptyBar = {enabled = false},
			portrait = {enabled = false},
			castBar = {enabled = false, name = {}, time = {}},
			text = {
				{enabled = true, name = L["Left text"], text = "[name]", anchorPoint = "C", anchorTo = "$healthBar", size = 0},
				{enabled = true, name = L["Right text"], text = "[curmaxhp]", anchorPoint = "C", anchorTo = "$healthBar", size = 0},
				{enabled = true, name = L["Left text"], text = "[level] [race]", anchorPoint = "C", anchorTo = "$powerBar", size = 0},
				{enabled = true, name = L["Right text"], text = "[curmaxpp]", anchorPoint = "C", anchorTo = "$powerBar", size = 0},
				{enabled = true, name = L["Text"], text = "", anchorTo = "$emptyBar", anchorPoint = "C", size = 0, x = 0, y = 0}
			},
			indicators = {raidTarget = {enabled = true, size = 0}}, 
			highlight = {},
			auras = {
				buffs = {enabled = false, perRow = 10, maxRows = 4, selfScale = 1.30, prioritize = true, enlargeSelf = false},
				debuffs = {enabled = false, perRow = 10, maxRows = 4, selfScale = 1.30, enlargeSelf = true},
			},
		}
		
		if( not self.fakeUnits[unit] ) then
			self.defaults.profile.units[unit].combatText = {enabled = true, anchorTo = "$parent", anchorPoint = "C", x = 0, y = 0}

			if( unit ~= "battleground" and unit ~= "battlegroundpet" and unit ~= "arena" and unit ~= "arenapet" and unit ~= "boss" ) then
				self.defaults.profile.units[unit].incHeal = {enabled = true, cap = 1.20}
				self.defaults.profile.units[unit].incAbsorb = {enabled = true, cap = 1.30}
			end
		end
		
		if( unit ~= "player" ) then
			self.defaults.profile.units[unit].range = {enabled = false, oorAlpha = 0.80, inAlpha = 1.0}

			if( not string.match(unit, "pet") ) then
				self.defaults.profile.units[unit].indicators.class = {enabled = false, size = 19}
			end
		end
			
		-- Want pvp/leader/ML enabled for these units
		if( unit == "player" or unit == "party" or unit == "target" or unit == "raid" or unit == "focus" ) then
			self.defaults.profile.units[unit].indicators.leader = {enabled = true, size = 0}
			self.defaults.profile.units[unit].indicators.masterLoot = {enabled = true, size = 0}
			self.defaults.profile.units[unit].indicators.pvp = {enabled = true, size = 0}
			self.defaults.profile.units[unit].indicators.role = {enabled = true, size = 0}
			self.defaults.profile.units[unit].indicators.status = {enabled = false, size = 19}
			
			if( unit ~= "focus" and unit ~= "target" ) then
				self.defaults.profile.units[unit].indicators.ready = {enabled = true, size = 0}
			end
		end

		if( unit == "battleground" ) then
			self.defaults.profile.units[unit].indicators.pvp = {enabled = true, size = 0}
		end

		self.defaults.profile.units[unit].altPowerBar = {enabled = not ShadowUF.fakeUnits[unit]}
	end
		
	-- PLAYER
	self.defaults.profile.units.player.enabled = true
	self.defaults.profile.units.player.healthBar.predicted = true
	self.defaults.profile.units.player.powerBar.predicted = true
	self.defaults.profile.units.player.indicators.status.enabled = true
	self.defaults.profile.units.player.runeBar = {enabled = false}
	self.defaults.profile.units.player.totemBar = {enabled = false}
	self.defaults.profile.units.player.druidBar = {enabled = false}
	self.defaults.profile.units.player.monkBar = {enabled = false}
	self.defaults.profile.units.player.xpBar = {enabled = false}
	self.defaults.profile.units.player.fader = {enabled = false}
	self.defaults.profile.units.player.soulShards = {enabled = true, isBar = true}
	self.defaults.profile.units.player.staggerBar = {enabled = true}
	self.defaults.profile.units.player.demonicFuryBar = {enabled = true}
	self.defaults.profile.units.player.burningEmbersBar = {enabled = true}
	self.defaults.profile.units.player.eclipseBar = {enabled = true}
	self.defaults.profile.units.player.holyPower = {enabled = true, isBar = true}
	self.defaults.profile.units.player.shadowOrbs = {enabled = true, isBar = true}
	self.defaults.profile.units.player.chi = {enabled = true, isBar = true}
	self.defaults.profile.units.player.indicators.lfdRole = {enabled = true, size = 0, x = 0, y = 0}
	self.defaults.profile.units.player.auraPoints = {enabled = false, isBar = true}
	table.insert(self.defaults.profile.units.player.text, {enabled = false, text = "", anchorTo = "", anchorPoint = "C", size = 0, x = 0, y = 0})
	table.insert(self.defaults.profile.units.player.text, {enabled = false, text = "", anchorTo = "", anchorPoint = "C", size = 0, x = 0, y = 0})

    -- PET
	self.defaults.profile.units.pet.enabled = true
	self.defaults.profile.units.pet.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	self.defaults.profile.units.pet.xpBar = {enabled = false}
    -- FOCUS
	self.defaults.profile.units.focus.enabled = true
	self.defaults.profile.units.focus.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	self.defaults.profile.units.focus.indicators.lfdRole = {enabled = false, size = 0, x = 0, y = 0}
	self.defaults.profile.units.focus.indicators.questBoss = {enabled = true, size = 0, x = 0, y = 0}
	-- FOCUSTARGET
	self.defaults.profile.units.focustarget.enabled = true
	self.defaults.profile.units.focustarget.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	-- TARGET
	self.defaults.profile.units.target.enabled = true
	self.defaults.profile.units.target.comboPoints = {enabled = true, isBar = true}
	self.defaults.profile.units.target.indicators.lfdRole = {enabled = false, size = 0, x = 0, y = 0}
	self.defaults.profile.units.target.indicators.questBoss = {enabled = true, size = 0, x = 0, y = 0}
	-- TARGETTARGET/TARGETTARGETTARGET
	self.defaults.profile.units.targettarget.enabled = true
	self.defaults.profile.units.targettargettarget.enabled = true
	-- PARTY
	self.defaults.profile.units.party.enabled = true
	self.defaults.profile.units.party.auras.debuffs.maxRows = 1
	self.defaults.profile.units.party.auras.buffs.maxRows = 1
	self.defaults.profile.units.party.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	self.defaults.profile.units.party.combatText.enabled = false
	self.defaults.profile.units.party.indicators.lfdRole = {enabled = true, size = 0, x = 0, y = 0}
	-- ARENA
	self.defaults.profile.units.arena.enabled = false
	self.defaults.profile.units.arena.attribPoint = "TOP"
	self.defaults.profile.units.arena.attribAnchorPoint = "LEFT"
	self.defaults.profile.units.arena.auras.debuffs.maxRows = 1
	self.defaults.profile.units.arena.auras.buffs.maxRows = 1
	self.defaults.profile.units.arena.offset = 0
	-- BATTLEGROUND
	self.defaults.profile.units.battleground.enabled = false
	self.defaults.profile.units.battleground.attribPoint = "TOP"
	self.defaults.profile.units.battleground.attribAnchorPoint = "LEFT"
	self.defaults.profile.units.battleground.auras.debuffs.maxRows = 1
	self.defaults.profile.units.battleground.auras.buffs.maxRows = 1
	self.defaults.profile.units.battleground.offset = 0
	-- BOSS
	self.defaults.profile.units.boss.enabled = false
	self.defaults.profile.units.boss.attribPoint = "TOP"
	self.defaults.profile.units.boss.attribAnchorPoint = "LEFT"
	self.defaults.profile.units.boss.auras.debuffs.maxRows = 1
	self.defaults.profile.units.boss.auras.buffs.maxRows = 1
	self.defaults.profile.units.boss.offset = 0
	self.defaults.profile.units.boss.altPowerBar.enabled = true
	-- RAID
	self.defaults.profile.units.raid.groupBy = "GROUP"
	self.defaults.profile.units.raid.sortOrder = "ASC"
	self.defaults.profile.units.raid.sortMethod = "INDEX"
	self.defaults.profile.units.raid.attribPoint = "TOP"
	self.defaults.profile.units.raid.attribAnchorPoint = "RIGHT"
	self.defaults.profile.units.raid.offset = 0
	self.defaults.profile.units.raid.filters = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
	self.defaults.profile.units.raid.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	self.defaults.profile.units.raid.combatText.enabled = false
	self.defaults.profile.units.raid.indicators.lfdRole = {enabled = true, size = 0, x = 0, y = 0}
	-- RAID PET
	self.defaults.profile.units.raidpet.groupBy = "GROUP"
	self.defaults.profile.units.raidpet.sortOrder = "ASC"
	self.defaults.profile.units.raidpet.sortMethod = "INDEX"
	self.defaults.profile.units.raidpet.attribPoint = "TOP"
	self.defaults.profile.units.raidpet.attribAnchorPoint = "RIGHT"
	self.defaults.profile.units.raidpet.offset = 0
	self.defaults.profile.units.raidpet.filters = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
	self.defaults.profile.units.raidpet.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	self.defaults.profile.units.raidpet.combatText.enabled = false
	-- MAINTANK
	self.defaults.profile.units.maintank.groupFilter = "MAINTANK"
	self.defaults.profile.units.maintank.groupBy = "GROUP"
	self.defaults.profile.units.maintank.sortOrder = "ASC"
	self.defaults.profile.units.maintank.sortMethod = "INDEX"
	self.defaults.profile.units.maintank.attribPoint = "TOP"
	self.defaults.profile.units.maintank.attribAnchorPoint = "RIGHT"
	self.defaults.profile.units.maintank.offset = 0
	self.defaults.profile.units.maintank.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	-- MAINASSIST
	self.defaults.profile.units.mainassist.groupFilter = "MAINASSIST"
	self.defaults.profile.units.mainassist.groupBy = "GROUP"
	self.defaults.profile.units.mainassist.sortOrder = "ASC"
	self.defaults.profile.units.mainassist.sortMethod = "INDEX"
	self.defaults.profile.units.mainassist.attribPoint = "TOP"
	self.defaults.profile.units.mainassist.attribAnchorPoint = "RIGHT"
	self.defaults.profile.units.mainassist.offset = 0
	self.defaults.profile.units.mainassist.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	-- PARTYPET
	self.defaults.profile.positions.partypet.anchorTo = "$parent"
	self.defaults.profile.positions.partypet.anchorPoint = "RB"
	self.defaults.profile.units.partypet.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
	-- PARTYTARGET
	self.defaults.profile.positions.partytarget.anchorTo = "$parent"
	self.defaults.profile.positions.partytarget.anchorPoint = "RT"
	self.defaults.profile.units.partytarget.fader = {enabled = false, combatAlpha = 1.0, inactiveAlpha = 0.60}
end

-- Module APIs
function ShadowUF:RegisterModule(module, key, name, isBar, class, spec, level)
	self.modules[key] = module

	module.moduleKey = key
	module.moduleHasBar = isBar
	module.moduleName = name
	module.moduleClass = class
	module.moduleLevel = level

	if( type(spec) == "number" ) then
		module.moduleSpec = {}
		module.moduleSpec[spec] = true
	elseif( type(spec) == "table" ) then
		module.moduleSpec = {}
		for _, id in pairs(spec) do
			module.moduleSpec[id] = true
		end
	end
	
	table.insert(self.moduleOrder, module)
end

function ShadowUF:FireModuleEvent(event, frame, unit)
	for _, module in pairs(self.moduleOrder) do
		if( module[event] ) then
			module[event](module, frame, unit)
		end
	end
end

-- Profiles changed
-- I really dislike this solution, but if we don't do it then there is setting issues
-- because when copying a profile, AceDB-3.0 fires OnProfileReset -> OnProfileCopied
-- SUF then sees that on the new reset profile has no profile, tries to load one in
-- ... followed by the profile copying happen and it doesn't copy everything correctly
-- due to variables being reset already.
local resetTimer
function ShadowUF:ProfileReset()
	if( not resetTimer ) then
		resetTimer = CreateFrame("Frame")
		resetTimer:SetScript("OnUpdate", function(self)
			ShadowUF:ProfilesChanged()
			self:Hide()
		end)
	end
	
	resetTimer:Show()
end

function ShadowUF:ProfilesChanged()
	if( self.layoutImporting ) then return end
	if( resetTimer ) then resetTimer:Hide() end
	
	self.db:RegisterDefaults(self.defaults)
	
	-- No active layout, register the default one
	if( not self.db.profile.loadedLayout ) then
		self:LoadDefaultLayout()
	else
		self:CheckUpgrade()
	end
	
	self:FireModuleEvent("OnProfileChange")
	self:LoadUnits()
	self:HideBlizzardFrames()
	self.Layout:CheckMedia()
	self.Units:ProfileChanged()
	self.modules.movers:Update()
end

ShadowUF.noop = function() end
ShadowUF.hiddenFrame = CreateFrame("Frame")
ShadowUF.hiddenFrame:Hide()

local rehideFrame = function(self)
	if( not InCombatLockdown() ) then
		self:Hide()
	end
end

local function hideBlizzardFrames(taint, ...)
	for i=1, select("#", ...) do
		local frame = select(i, ...)
		frame:UnregisterAllEvents()
		frame:Hide()

		if( frame.manabar ) then frame.manabar:UnregisterAllEvents() end
		if( frame.healthbar ) then frame.healthbar:UnregisterAllEvents() end
		if( frame.spellbar ) then frame.spellbar:UnregisterAllEvents() end
		if( frame.powerBarAlt ) then frame.powerBarAlt:UnregisterAllEvents() end

		if( taint ) then
			frame.Show = ShadowUF.noop
		else
			frame:SetParent(ShadowUF.hiddenFrame)
			frame:HookScript("OnShow", rehideFrame)
		end
	end
end

local active_hiddens = {}
function ShadowUF:HideBlizzardFrames()
	if( self.db.profile.hidden.cast and not active_hiddens.cast ) then
		hideBlizzardFrames(true, CastingBarFrame, PetCastingBarFrame)
	end

	if( self.db.profile.hidden.party and not active_hiddens.party ) then
		for i=1, MAX_PARTY_MEMBERS do
			local name = "PartyMemberFrame" .. i
			hideBlizzardFrames(true, _G[name], _G[name .. "HealthBar"], _G[name .. "ManaBar"])
		end
		
		-- This stops the compact party frame from being shown		
		UIParent:UnregisterEvent("GROUP_ROSTER_UPDATE")

		-- This just makes sure
		if( CompactPartyFrame ) then
			hideBlizzardFrames(false, CompactPartyFrame)
		end
	end

	if( CompactRaidFrameManager ) then
		if( self.db.profile.hidden.raid and not active_hiddens.raidTriggered ) then
			active_hiddens.raidTriggered = true

			local function hideRaid()
				CompactRaidFrameManager:UnregisterAllEvents()
				CompactRaidFrameContainer:UnregisterAllEvents()
				if( InCombatLockdown() ) then return end
	
				CompactRaidFrameManager:Hide()
				local shown = CompactRaidFrameManager_GetSetting("IsShown")
				if( shown and shown ~= "0" ) then
					CompactRaidFrameManager_SetSetting("IsShown", "0")
				end
			end
			
			hooksecurefunc("CompactRaidFrameManager_UpdateShown", function()
				if( self.db.profile.hidden.raid ) then
					hideRaid()
				end
			end)
			
			hideRaid()
			CompactRaidFrameContainer:HookScript("OnShow", hideRaid)
			CompactRaidFrameManager:HookScript("OnShow", hideRaid)

		 elseif( not self.db.profile.hidden.raid and not InCombatLockdown() ) then
			CompactRaidFrameManager:SetFrameStrata("DIALOG")
		end
	end

	if( self.db.profile.hidden.buffs and not active_hiddens.buffs ) then
		hideBlizzardFrames(false, BuffFrame, TemporaryEnchantFrame, ConsolidatedBuffs)
	end
	
	if( self.db.profile.hidden.player and not active_hiddens.player ) then
		hideBlizzardFrames(false, PlayerFrame, PlayerFrameAlternateManaBar)
			
		-- We keep these in case someone is still using the default auras, otherwise it messes up vehicle stuff
		PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		PlayerFrame:RegisterEvent("UNIT_ENTERING_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_EXITING_VEHICLE")
		PlayerFrame:RegisterEvent("UNIT_EXITED_VEHICLE")
		PlayerFrame:SetUserPlaced(true)
		PlayerFrame:SetDontSavePosition(true)
	end

	if( self.db.profile.hidden.playerPower and not active_hiddens.playerPower ) then
		hideBlizzardFrames(false, EclipseBarFrame, ShardBarFrame, RuneFrame, PaladinPowerBar, MonkHarmonyBar, WarlockPowerFrame)

		PriestBarFrame:UnregisterAllEvents()
		PriestBarFrame:HookScript("OnShow", rehideFrame)
		PriestBarFrame:Hide()
	end

	if( self.db.profile.hidden.pet and not active_hiddens.pet ) then
		hideBlizzardFrames(false, PetFrame)
	end
	
	if( self.db.profile.hidden.target and not active_hiddens.target ) then
		hideBlizzardFrames(false, TargetFrame, ComboFrame, TargetFrameToT)
	end
	
	if( self.db.profile.hidden.focus and not active_hiddens.focus ) then
		hideBlizzardFrames(false, FocusFrame, FocusFrameToT)
	end
		
	if( self.db.profile.hidden.boss and not active_hiddens.boss ) then
		for i=1, MAX_BOSS_FRAMES do
			local name = "Boss" .. i .. "TargetFrame"
			hideBlizzardFrames(false, _G[name], _G[name .. "HealthBar"], _G[name .. "ManaBar"])
		end
	end

	if( self.db.profile.hidden.arena and not active_hiddens.arenaTriggered and IsAddOnLoaded("Blizzard_ArenaUI") and not InCombatLockdown() ) then
		active_hiddens.arenaTriggered = true

		ArenaEnemyFrames:UnregisterAllEvents()
		ArenaEnemyFrames:SetParent(self.hiddenFrame)
		SetCVar("showArenaEnemyFrames", 0, "SHOW_ARENA_ENEMY_FRAMES_TEXT")
	end

	if( self.db.profile.hidden.playerAltPower and not active_hiddens.playerAltPower ) then
		hideBlizzardFrames(false, PlayerPowerBarAlt)
	end

	-- fix LFD Cooldown Frame
	-- this is technically not our problem, but due to having the frames on the same strata, it looks like this to the users
	-- and the fix is simple enough
	if( not active_hiddens.lfd ) then
		active_hiddens.lfd = true
		
		LFDQueueFrameCooldownFrame:SetFrameLevel(QueueStatusFrame:GetFrameLevel() + 20)
		LFDQueueFrameCooldownFrame:SetFrameStrata("TOOLTIP")
		
		QueueStatusFrame:SetFrameLevel(QueueStatusFrame:GetFrameLevel() + 20)
		QueueStatusFrame:SetFrameStrata("TOOLTIP")
	end

	-- As a reload is required to reset the hidden hooks, we can just set this to true if anything is true
	for type, flag in pairs(self.db.profile.hidden) do
		if( flag ) then
			active_hiddens[type] = true
		end
	end
end

function ShadowUF:Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99Shadow UF|r: " .. msg)
end

CONFIGMODE_CALLBACKS = CONFIGMODE_CALLBACKS or {}
CONFIGMODE_CALLBACKS["Shadowed Unit Frames"] = function(mode)
	if( mode == "ON" ) then
		ShadowUF.db.profile.locked = false
		ShadowUF.modules.movers.isConfigModeSpec = true
	elseif( mode == "OFF" ) then
		ShadowUF.db.profile.locked = true
	end
	
	ShadowUF.modules.movers:Update()
end

SLASH_SHADOWEDUF1 = "/suf"
SLASH_SHADOWEDUF2 = "/shadowuf"
SLASH_SHADOWEDUF3 = "/shadoweduf"
SLASH_SHADOWEDUF4 = "/shadowedunitframes"
SlashCmdList["SHADOWEDUF"] = function(msg)
	msg = msg and string.lower(msg)
	if( msg and string.match(msg, "^profile (.+)") ) then
		local profile = string.match(msg, "^profile (.+)")
		
		for id, name in pairs(ShadowUF.db:GetProfiles()) do
			if( string.lower(name) == profile ) then
				ShadowUF.db:SetProfile(name)
				ShadowUF:Print(string.format(L["Changed profile to %s."], name))
				return
			end
		end
		
		ShadowUF:Print(string.format(L["Cannot find any profiles named \"%s\"."], profile))
		return
	end
	
	local loaded, reason = LoadAddOn("ShadowedUF_Options")
	if( not ShadowUF.Config ) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(L["Failed to load ShadowedUF_Options, cannot open configuration. Error returned: %s"], reason and _G["ADDON_" .. reason] or ""))
		return
	end
	
	ShadowUF.Config:Open()
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if( event == "PLAYER_LOGIN" ) then
		ShadowUF:OnInitialize()
		self:UnregisterEvent("PLAYER_LOGIN")
	elseif( event == "ADDON_LOADED" and ( addon == "Blizzard_ArenaUI" or addon == "Blizzard_CompactRaidFrames" ) ) then
		ShadowUF:HideBlizzardFrames()
	end
end)
