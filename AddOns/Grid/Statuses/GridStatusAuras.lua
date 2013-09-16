local n2s,f2s,floor,pairs,type=n2s,f2s,floor,pairs,type
--[[--------------------------------------------------------------------
	Grid
	Compact party and raid unit frames.
	Copyright (c) 2006-2012 Kyle Smith (a.k.a. Pastamancer), A. Kinley (a.k.a. Phanx) <addons@phanx.net>
	All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info5747-Grid.html
	http://www.wowace.com/addons/grid/
	http://www.curse.com/addons/wow/grid
------------------------------------------------------------------------
	GridStatusAuras.lua
	GridStatus module for tracking buffs/debuffs.
----------------------------------------------------------------------]]

local _, Grid = ...
local L = Grid.L

local GridFrame = Grid:GetModule("GridFrame")
local GridRoster = Grid:GetModule("GridRoster")
local hasAuraEditBox = type(LibStub("AceGUI-3.0").WidgetVersions["Aura_EditBox"]) == "number"

local GridStatusAuras = Grid:NewStatusModule("GridStatusAuras", "AceTimer-3.0")
GridStatusAuras.menuName = L["Auras"]

local BS = {
-- All
	["Ghost"] = GetSpellInfo(8326),
	["Mortal Strike"] = GetSpellInfo(12294),
-- Druids
	["Lifebloom"] = GetSpellInfo(33763),
	["Regrowth"] = GetSpellInfo(8936),
	["Rejuvenation"] = GetSpellInfo(774),
-- Paladins
	["Beacon of Light"] = GetSpellInfo(53563),
	["Forbearance"] = GetSpellInfo(25771),
-- Priests
	["Power Word: Shield"] = GetSpellInfo(17),
	["Renew"] = GetSpellInfo(139),
	["Weakened Soul"] = GetSpellInfo(6788),
-- Shamans
	["Earth Shield"] = GetSpellInfo(974),
	["Riptide"] = GetSpellInfo(61295),
}

-- data used by aura scanning
local buff_names = {}
local player_buff_names = {}
local debuff_names = {}

local debuff_types = {
	["Curse"] = true,
	["Disease"] = true,
	["Magic"] = true,
	["Poison"] = true,
}

function GridStatusAuras.StatusForSpell(spell, isBuff)
	local prefix = isBuff and "buff_" or "debuff_"
	return prefix .. string.gsub(spell, " ", "")
end

local statusDefaultDB = {
	enable = true,
	priority = 90,
	range = false,
	missing = false,
	duration = false,
	color = { r = .5, g = .5, b = .5, a = 1 },
	statusText = "name",
	statusColor = "present",
	refresh = 0.5,
	durationTenths = false,
	durationColorLow = { r = .15, g = .15, b = .15, a = 1 },
	durationColorMiddle = { r = .35, g = .35, b = .35, a = 1 },
	durationColorHigh = { r = .5, g = .5, b = .5, a = 1 },
	durationLow = 2,
	durationHigh = 4,
	countColorLow = { r = 1, g = 0, b = 0, a = 1 },
	countColorMiddle = { r = 1, g = 1, b = 0, a = 1 },
	countColorHigh = { r = 0, g = 1, b = 0, a = 1 },
	countLow = 1,
	countHigh = 2,
}

-- Perform a deep copy of defaultDB into the given settings table except into the slots
-- where the value is non-nil (non-default setting).
function GridStatusAuras:CopyDefaults(settings, defaults)
	if type(defaults) ~= "table" then return { } end
	if type(settings) ~= "table" then settings = { } end
	for k, v in pairs(defaults) do
		if type(v) == "table" then
			settings[k] = self:CopyDefaults(settings[k], v)
		elseif type(v) ~= type(settings[k]) then
			settings[k] = v
		end
	end
	return settings
	--[[
	for name, value in pairs(defaultDB) do
		if type(value) == "table" then
			if not settings[name] then settings[name] = {} end
			self:CopyDefaults(settings[name], value)
		else
			if not settings[name] then settings[name] = value end
		end
	end
	]]
end

GridStatusAuras.defaultDB = {
	advancedOptions = false,
	["debuff_curse"] = {
		desc = string.format(L["Debuff type: %s"], L["Curse"]),
		text = L["Curse"],
		color = { r = .6, g =  0, b =  1, a = 1 },
		durationColorLow = { r = .18, g =  0, b =  .3, a = 1 },
		durationColorMiddle = { r = .42, g =  0, b =  .7, a = 1 },
		durationColorHigh = { r = .6, g =  0, b =  1, a = 1 },
		order = 25,
	},
	["debuff_disease"] = {
		desc = string.format(L["Debuff type: %s"], L["Disease"]),
		text = L["Disease"],
		color = { r = .6, g = .4, b =  0, a = 1 },
		durationColorLow = { r = .18, g = .12, b =  0, a = 1 },
		durationColorMiddle = { r = .42, g = .28, b =  0, a = 1 },
		durationColorHigh = { r = .6, g = .4, b =  0, a = 1 },
		order = 25,
	},
	["debuff_magic"] = {
		desc = string.format(L["Debuff type: %s"], L["Magic"]),
		text = L["Magic"],
		color = { r = .2, g = .6, b =  1, a = 1 },
		durationColorLow = { r = .06, g = .18, b =  .3, a = 1 },
		durationColorMiddle = { r = .14, g = .42, b =  .7, a = 1 },
		durationColorHigh = { r = .2, g = .6, b =  1, a = 1 },
		order = 25,
	},
	["debuff_poison"] = {
		desc = string.format(L["Debuff type: %s"], L["Poison"]),
		text = L["Poison"],
		color = { r =  0, g = .6, b =  0, a = 1 },
		durationColorLow = { r = 0, g = .18, b = 0, a = 1 },
		durationColorMiddle = { r = 0, g = .42, b = 0, a = 1 },
		durationColorHigh = { r = 0, g = .6, b = 0, a = 1 },
		order = 25,
	},
	[GridStatusAuras.StatusForSpell(BS["Ghost"])] = {
		desc = string.format(L["Debuff: %s"], BS["Ghost"]),
		text = BS["Ghost"],
		color = { r = .5, g = .5, b = .5, a = 1 },
		durationColorLow = { r = .15, g = .15, b = .15, a = 1 },
		durationColorMiddle = { r = .35, g = .35, b = .35, a = 1 },
		durationColorHigh = { r = .5, g = .5, b = .5, a = 1 },
	},
	[GridStatusAuras.StatusForSpell(BS["Mortal Strike"])] = {
		desc = string.format(L["Debuff: %s"], BS["Mortal Strike"]),
		text = BS["Mortal Strike"],
		color = { r = .8, g = .2, b = .2, a = 1 },
		durationColorLow = { r = .24, g = .06, b = .06, a = 1 },
		durationColorMiddle = { r = .56, g = .14, b = .14, a = 1 },
		durationColorHigh = { r = .8, g = .2, b = .2, a = 1 },
	},
	[GridStatusAuras.StatusForSpell(BS["Forbearance"])] = {
		desc = string.format(L["Debuff: %s"], BS["Forbearance"]),
		text = BS["Forbearance"],
		color = { r = .5, g = .5, b = .5, a = 1 },
		durationColorLow = { r = .15, g = .15, b = .15, a = 1 },
		durationColorMiddle = { r = .35, g = .35, b = .35, a = 1 },
		durationColorHigh = { r = .5, g = .5, b = .5, a = 1 },
	},
	[GridStatusAuras.StatusForSpell(BS["Weakened Soul"])] = {
		desc = string.format(L["Debuff: %s"], BS["Weakened Soul"]),
		text = BS["Weakened Soul"],
		color = { r = .5, g = .5, b = .5, a = 1 },
		durationColorLow = { r = .15, g = .15, b = .15, a = 1 },
		durationColorMiddle = { r = .35, g = .35, b = .35, a = 1 },
		durationColorHigh = { r = .5, g = .5, b = .5, a = 1 },
	},
	[GridStatusAuras.StatusForSpell(BS["Beacon of Light"], true)] = {
		desc = string.format(L["Buff: %s"], BS["Beacon of Light"]),
		text = BS["Beacon of Light"],
		color = { r = .5, g = 0.7, b = 0.3, a = 1 },
		durationColorLow = { r = 1, g = 0, b = 0, a = 1 },
		durationColorMiddle = { r = .49, g = .49, b = 0, a = 1 },
		durationColorHigh = { r = .7, g = .7, b = 0, a = 1 },
		durationLow = 5,
		durationHigh = 10,
	},
	[GridStatusAuras.StatusForSpell(BS["Power Word: Shield"], true)] = {
		desc = string.format(L["Buff: %s"], BS["Power Word: Shield"]),
		text = BS["Power Word: Shield"],
		color = { r = .8, g = .8, b =  0, a = 1 },
		durationColorLow = { r = 1, g = 0, b = 0, a = 1 },
		durationColorMiddle = { r = .56, g = .56, b =  0, a = 1 },
		durationColorHigh = { r = .8, g = .8, b =  0, a = 1 },
	},
	[GridStatusAuras.StatusForSpell(BS["Renew"], true)] = {
		desc = string.format(L["Buff: %s"], BS["Renew"]),
		text = BS["Renew"],
		color = { r =  0, g = .7, b = .3, a = 1 },
		durationColorLow = { r = 1, g = 0, b = 0, a = 1 },
		durationColorMiddle = { r =  0, g = .49, b = .21, a = 1 },
		durationColorHigh = { r =  0, g = .7, b = .3, a = 1 },
	},
	[GridStatusAuras.StatusForSpell(BS["Lifebloom"], true)] = {
		desc = string.format(L["Buff: %s"], BS["Lifebloom"]),
		text = BS["Lifebloom"],
		color = { r =  .3, g = .7, b = 0, a = 1 },
		durationColorLow = { r = 1, g = 0, b = 0, a = 1 },
		durationColorMiddle = { r =  .21, g = .49, b = 0, a = 1 },
		durationColorHigh = { r =  .3, g = .7, b = 0, a = 1 },
		countColorLow = { r = 1, g = 0, b = 0, a = 1 },
		countColorMiddle = { r = 1, g = 1, b = 0, a = 1 },
		countColorHigh = { r = 0, g = 1, b = 0, a = 1 },
		countLow = 1,
		countHigh = 2,
	},
	[GridStatusAuras.StatusForSpell(BS["Regrowth"], true)] = {
		desc = string.format(L["Buff: %s"], BS["Regrowth"]),
		text = BS["Regrowth"],
		color = { r =  1, g = .7, b = .1, a = 1 },
		durationColorLow = { r = 1, g = 0, b = 0, a = 1 },
		durationColorMiddle = { r =  .7, g = .49, b = .07, a = 1 },
		durationColorHigh = { r =  1, g = .7, b = .1, a = 1 },
	},
	[GridStatusAuras.StatusForSpell(BS["Rejuvenation"], true)] = {
		desc = string.format(L["Buff: %s"], BS["Rejuvenation"]),
		text = BS["Rejuvenation"],
		color = { r =  0, g = .3, b = .7, a = 1 },
		durationColorLow = { r = 1, g = 0, b = 0, a = 1 },
		durationColorMiddle = { r =  0, g = .21, b = .49, a = 1 },
		durationColorHigh = { r =  0, g = .3, b = .7, a = 1 },
	},
	[GridStatusAuras.StatusForSpell(BS["Earth Shield"], true)] = {
		desc = string.format(L["Buff: %s"], BS["Earth Shield"]),
		text = BS["Earth Shield"],
		statusText = "count",
		statusColor = "count",
		color = { r = .5, g = 0.7, b = 0.3, a = 1 },
		durationColorLow = { r = 1, g = 0, b = 0, a = 1 },
		durationColorMiddle = { r = .35, g = .49, b = .21, a = 1 },
		durationColorHigh = { r = .5, g = 0.7, b = 0.3, a = 1 },
		countColorLow = { r = 1, g = 0, b = 0, a = 1 },
		countColorMiddle = { r = .35, g = .49, b = .21, a = 1 },
		countColorHigh = { r = .5, g = .7, b = .3, a = 1 },
		countLow = 1,
		countHigh = 4,
	},
	[GridStatusAuras.StatusForSpell(BS["Riptide"], true)] = {
		desc = string.format(L["Buff: %s"], BS["Riptide"]),
		text = BS["Riptide"],
		color = { r = .4, g = 0, b = .8, a = 1 },
		durationColorLow = { r = 1, g = 0, b = 0, a = 1 },
		durationColorMiddle = { r = .28, g = 0, b = .56, a = 1 },
		durationColorHigh = { r = .4, g = 0, b = .8, a = 1 },
	},
	[GridStatusAuras.StatusForSpell("103628")] = {
		desc = string.format(L["Debuff: %s"], format("103628(%s)", (GetSpellInfo(103628)))),
		text = format("103628(%s)", (GetSpellInfo(103628))),
		priority = 99,
		statusText = "count",
		statusColor = "count",
		color = { r = .5, g = 0.7, b = 0.3, a = 1 },
		countColorHigh = { r = 1, g = 0, b = 0, a = 1 },
		countColorMiddle = { r = .35, g = .49, b = .21, a = 1 },
		countColorLow = { r = .5, g = .7, b = .3, a = 1 },
		countLow = 1,
		countHigh = 3,
	},
}

local defaultDebuffs = { }
do
	for status, settings in pairs(GridStatusAuras.defaultDB) do
		if type(settings) == "table" and settings.text then
			GridStatusAuras:CopyDefaults(settings, statusDefaultDB)
			defaultDebuffs[status] = true
		end
	end
end

GridStatusAuras.extraOptions = {
}

function GridStatusAuras:PostInitialize()
	self:RegisterStatuses()

	self.options.args["add_buff"] = {
		name = L["Add new Buff"],
		desc = L["Adds a new buff to the status module"],
		order = 11,
		width = "double",
		type = "input", usage = L["<buff name>"], dialogControl = hasAuraEditBox and "Aura_EditBox" or nil,
		get = false,
		set = function(_, v)
				self:AddAura(v, true)
			end,
	}
	self.options.args["add_debuff"] = {
		name = L["Add new Debuff"],
		desc = L["Adds a new debuff to the status module"],
		order = 31,
		width = "double",
		type = "input", usage = L["<debuff name>"], dialogControl = hasAuraEditBox and "Aura_EditBox" or nil,
		get = false,
		set = function(_, v)
				self:AddAura(v, false)
			end,
	}
	self.options.args["delete_debuff"] = {
		name = L["Delete (De)buff"],
		desc = L["Deletes an existing debuff from the status module"],
		order = -2,
		type = "group", dialogInline = true,
		args = {},
	}
	self.options.args["advancedOptions"] = {
		name = L["Show advanced options"],
		desc = L["Show advanced options for buff and debuff statuses.\n\nBeginning users may wish to leave this disabled until you are more familiar with Grid, to avoid being overwhelmed by complicated options menus."],
		order = -1,
		width = "full",
		type = "toggle",
		get = function()
				return self.db.profile.advancedOptions
			end,
		set = function(_, v)
				self.db.profile.advancedOptions = v
			end,
	}
end

function GridStatusAuras:PostEnable()
	self:CreateRemoveOptions()
end

function GridStatusAuras:PostReset()
	self:UnregisterStatuses()
	self:RegisterStatuses()
	self:CreateRemoveOptions()
	self:ResetDurationStatuses()
	self:UpdateAuraScanList()
end

function GridStatusAuras:EnabledStatusCount()
	local enable_count = 0

	for status, settings in pairs(self.db.profile) do
		if type(settings) == "table" and settings.enable then
			enable_count = enable_count + 1
		end
	end

	return enable_count
end

function GridStatusAuras:OnStatusEnable(status)
	self:RegisterMessage("Grid_UnitJoined")
	self:RegisterEvent("UNIT_AURA", "ScanUnitAuras")

	self:DeleteDurationStatus(status)
	self:UpdateAuraScanList()
	self:UpdateAllUnitAuras()
end

function GridStatusAuras:OnStatusDisable(status)
	self.core:SendStatusLostAllUnits(status)
	self:DeleteDurationStatus(status)
	self:UpdateAuraScanList()

	if self:EnabledStatusCount() == 0 then
		self:UnregisterMessage("Grid_UnitJoined")
		self:UnregisterEvent("UNIT_AURA")
	end
end

function GridStatusAuras:RegisterStatuses()
	for status, settings in pairs(self.db.profile) do
		if type(settings) == "table" and settings.text then
			local name = settings.text
			local desc = settings.desc or name
			local isBuff = GridStatusAuras.StatusForSpell(name, true) == status
			local order = settings.order or (isBuff and 15 or 35)

			self:Debug("registering", status, desc)
			if not self.defaultDB[status] then
				self.defaultDB[status] = { }
				self:CopyDefaults(self.defaultDB[status], statusDefaultDB)
			end
			self:CopyDefaults(settings, self.defaultDB[status])
			self:RegisterStatus(status, desc, self:OptionsForStatus(status, isBuff), false, order)
		end
	end
	self.db:RegisterDefaults({ profile = self.defaultDB or { } })
end

function GridStatusAuras:UnregisterStatuses()
	for status, moduleName, desc in self.core:RegisteredStatusIterator() do
		if moduleName == self.name then
			self:UnregisterStatus(status)
			self.options.args[status] = nil
		end
	end
end

local classes = { }
do
	local t = { }
	FillLocalizedClassList(t, false)
	for token, name in pairs(t) do
		classes[token:lower()] = name
	end
end

function GridStatusAuras:OptionsForStatus(status, isBuff)
	local auraOptions = {
		class = {
			name = L["Class Filter"],
			desc = L["Show status for the selected classes."],
			order = 200,
			type = "group", dialogInline = true,
			hidden = function()
					return not self.db.profile.advancedOptions
				end,
			args = {
				pet = {
					name = L["Pet"],
					desc = L["Show on pets and vehicles."],
					order = -1,
					width = "double",
					type = "toggle",
					get = function()
							return GridStatusAuras.db.profile[status].pet ~= false
						end,
					set = function(_, v)
							GridStatusAuras.db.profile[status].pet = v
							GridStatusAuras:UpdateAllUnitAuras()
						end,
				},
			},
		},
		statusInfo = {
			name = L["Status Information"],
			desc = L["Change what information is displayed using the status color and text."],
			order = 300,
			type = "group", dialogInline = true,
			hidden = function()
					return not self.db.profile.advancedOptions
				end,
			args = {
				colorInfo = {
					name = L["Color Shows:"],
					desc = L["Change which information is shown by the status color."],
					order = 310,
					width = "double",
					type = "select",
					values = {
						["present"] = L["Present or missing"],
						["duration"] = L["Time left"],
						["count"] = L["Stack count"],
					},
					get = function()
							return self.db.profile[status].statusColor
						end,
					set = function(_, v)
							self.db.profile[status].statusColor = v
							self:UpdateAllUnitAuras()
						end,
				},
				textInfo = {
					name = L["Text Shows:"],
					desc = L["Change which information is shown by the status text."],
					order = 305,
					width = "double",
					type = "select",
					values = {
						["name"] = L["(De)buff name"],
						["duration"] = L["Time left"],
						["count"] = L["Stack count"],
					},
					get = function()
							return self.db.profile[status].statusText
						end,
					set = function(_, v)
							self.db.profile[status].statusText = v
							self:UpdateAllUnitAuras()
						end,
					hidden = function()
							return not self.db.profile.advancedOptions
						end,
				},
				durationTenths = {
					name = L["Show time left to tenths"],
					desc = L["Show the time left to tenths of a second, instead of only whole seconds."],
					order = 308,
					width = "double",
					type = "toggle",
					get = function()
							return self.db.profile[status].durationTenths
						end,
					set = function(_, v)
							self.db.profile[status].durationTenths = v
							self:UpdateAllUnitAuras()
						end,
					hidden = function()
							return not self.db.profile.advancedOptions or self.db.profile[status].statusText ~= "duration"
						end,
				},
				countSettings = {
					name = string.format(L["%s colors"], L["Stack count"]),
					desc = string.format(L["%s colors and threshold values."], L["Stack count"]),
					order = 350,
					type = "group", dialogInline = true,
					get = function(info)
							local optionName = info[#info]
							if (info.type == "color") then
								local color = self.db.profile[status][optionName]
								return color.r, color.g, color.b, color.a
							elseif (info.type == "range") then
								return self.db.profile[status][optionName]
							end
						end,
					set = function(info, r, g, b, a)
							local optionName = info[#info]
							if (info.type == "color") then
								local color = self.db.profile[status][optionName]
								color.r = r
								color.g = g
								color.b = b
								color.a = a or 1
							elseif (info.type == "range") then
								self.db.profile[status][optionName] = r
							end
							self:UpdateAllUnitAuras()
						end,
					hidden = function()
							return not self.db.profile.advancedOptions or self.db.profile[status].statusColor ~= "count"
						end,
					args = {
						countColorLow = {
							name = L["Low color"],
							desc = string.format(L["Color when %s is below the low threshold value."], L["Stack count"]),
							order = 351,
							type = "color",
						},
						countLow = {
							name = L["Low threshold"],
							desc = string.format(L["%s is low below this value."], L["Stack count"]),
							order = 352,
							type = "range",
							min = 0, softMin = 0, max = 99, softMax = 10, step = 1,
						},
						countColorMiddle = {
							name = L["Middle color"],
							desc = string.format(L["Color when %s is between the low and high threshold values."], L["Stack count"]),
							order = 353,
							width = "full",
							type = "color",
						},
						countColorHigh = {
							name = L["High color"],
							desc = string.format(L["Color when %s is above the high threshold value."], L["Stack count"]),
							order = 354,
							type = "color",
						},
						countHigh = {
							name = L["High threshold"],
							desc = string.format(L["%s is high above this value."], L["Stack count"]),
							order = 355,
							type = "range",
							min = 0, softMin = 0, max = 99, softMax = 10, step = 1,
						},
					},
				},
				durationSettings = {
					name = string.format(L["%s colors"], L["Duration"]),
					desc = string.format(L["%s colors and threshold values."], L["Duration"]),
					order = 360,
					type = "group",
					get = function(info)
							local optionName = info[#info]
							if (info.type == "color") then
								local color = self.db.profile[status][optionName]
								return color.r, color.g, color.b, color.a
							elseif (info.type == "range") then
								return self.db.profile[status][optionName]
							end
						end,
					set = function(info, r, g, b, a)
							local optionName = info[#info]
							if (info.type == "color") then
								local color = self.db.profile[status][optionName]
								color.r = r
								color.g = g
								color.b = b
								color.a = a or 1
							elseif (info.type == "range") then
								self.db.profile[status][optionName] = r
							end
							self:UpdateAllUnitAuras()
						end,
					hidden = function()
							return not self.db.profile.advancedOptions or self.db.profile[status].statusColor ~= "duration"
						end,
					args = {
						durationColorLow = {
							name = L["Low color"],
							desc = string.format(L["Color when %s is below the low threshold value."], L["Duration"]),
							order = 361,
							type = "color",
						},
						durationLow = {
							name = L["Low threshold"],
							desc = string.format(L["%s is low below this value."], L["Duration"]),
							order = 362,
							type = "range",
							min = 0, softMin = 0, max = 99, softMax = 10, step = 1,
						},
						durationColorMiddle = {
							name = L["Middle color"],
							desc = string.format(L["Color when %s is between the low and high threshold values."], L["Duration"]),
							order = 363,
							width = "full",
							type = "color",
						},
						durationColorHigh = {
							name = L["High color"],
							desc = string.format(L["Color when %s is above the high threshold value."], L["Duration"]),
							order = 364,
							type = "color",
						},
						durationHigh = {
							name = L["High threshold"],
							desc = string.format(L["%s is high above this value."], L["Duration"]),
							order = 365,
							type = "range",
							min = 0, softMin = 0, max = 99, softMax = 10, step = 1,
						},
					},
				},
				refresh = {
					name = L["Refresh interval"],
					desc = L["Time in seconds between each refresh of the duration status."],
					order = 302,
					width = "double",
					type = "range", min = 0.1, max = 0.5, step = 0.1,
					get = function()
							return self.db.profile[status].refresh
						end,
					set = function(_, v)
							self.db.profile[status].refresh = v
							self:UpdateAllUnitAuras()
						end,
					hidden = function()
							return not self.db.profile.advancedOptions or (self.db.profile[status].statusColor ~= "duration" and self.db.profile[status].statusText ~= "duration")
						end,
				},
			},
		},
	}

	for class, name in pairs(classes) do
		local class, name = class, name
		auraOptions.class.args[class] = {
			name = name,
			desc = string.format(L["Show on %s players."], name),
			type = "toggle",
			get = function()
					return GridStatusAuras.db.profile[status][class] ~= false
				end,
			set = function(_, v)
					GridStatusAuras.db.profile[status][class] = v
					GridStatusAuras:UpdateAllUnitAuras()
				end,
		}
	end

	if isBuff then
		auraOptions.mine = {
			name = L["Show if mine"],
			desc = L["Display status only if the buff was cast by you."],
			order = 60,
			width = "double",
			type = "toggle",
			get = function()
					return GridStatusAuras.db.profile[status].mine
				end,
			set = function(_, v)
					GridStatusAuras.db.profile[status].mine = v
					GridStatusAuras:DeleteDurationStatus(status)
					GridStatusAuras:UpdateAuraScanList()
					GridStatusAuras:UpdateAllUnitAuras()
				end,
		}
		auraOptions.missing = {
			name = L["Show if missing"],
			desc = L["Display status only if the buff is not active."],
			order = 70,
			width = "double",
			type = "toggle",
			get = function()
					return GridStatusAuras.db.profile[status].missing
				end,
			set = function(_, v)
					GridStatusAuras.db.profile[status].missing = v
					GridStatusAuras:UpdateAllUnitAuras()
				end,
		}
	end

	return auraOptions
end

function GridStatusAuras:CreateRemoveOptions()
	for status, settings in pairs(self.db.profile) do
		local status = status
		if type(settings) == "table" and settings.text and not defaultDebuffs[status] then
			local debuffName = settings.desc or settings.text
			self.options.args["delete_debuff"].args[status] = {
				name = debuffName,
				desc = string.format(L["Remove %s from the menu"], debuffName),
				width = "double",
				type = "execute",
				func = function() return self:DeleteAura(status) end,
			}
		end
	end
end

function GridStatusAuras:AddAura(name, isBuff)
	local status = GridStatusAuras.StatusForSpell(name, isBuff)

	-- status already exists
	if self.db.profile[status] then
		self:Debug("AddAura failed, status exists!", name, status)
		return
	end

	local originName = name
	name = name:find("^[0-9]+$") and format("%s(%s)", name, (GetSpellInfo(name))) or name
	local desc = isBuff and string.format(L["Buff: %s"], name) or string.format(L["Debuff: %s"], name)

	if not self.defaultDB[status] then
		self.defaultDB[status] = { }
		self:CopyDefaults(self.defaultDB[status], statusDefaultDB)
		self.db:RegisterDefaults({ profile = self.defaultDB or { } })
	end

	self.db.profile[status] = { text = originName, desc = desc }
	self:CopyDefaults(self.db.profile[status], self.defaultDB[status])

	self.options.args["delete_debuff"].args[status] = {
		name = desc or name,
		desc = string.format(L["Remove %s from the menu"], desc or name),
		width = "double",
		type = "execute",
		func = function()
			return self:DeleteAura(status)
		end,
	}

	local order = isBuff and 15 or 35

	self:RegisterStatus(status, desc, self:OptionsForStatus(status, isBuff), false, order)
	self:OnStatusEnable(status)
end

function GridStatusAuras:DeleteAura(status)
	self:UnregisterStatus(status)
	self.options.args[status] = nil
	self.options.args["delete_debuff"].args[status] = nil
	self.db.profile[status] = nil
	for indicator, indicatorTbl in pairs(GridFrame.db.profile.statusmap) do
		indicatorTbl[status] = nil
	end
	self:DeleteDurationStatus(status)
	self:UpdateAuraScanList()
end

function GridStatusAuras:UpdateAllUnitAuras()
	for guid, unitid in GridRoster:IterateRoster() do
		self:ScanUnitAuras("UpdateAllUnitAuras", unitid)
	end
end

function GridStatusAuras:Grid_UnitJoined(event, guid, unitid)
	self:ScanUnitAuras(event, unitid)
end

-- Unit Aura Driver
--
-- Primary Requirements:
-- * Identify the presence of known buffs by name.
-- * Identify the presence of known buffs by name that are cast by the player.
-- * Identify the presence of known debuffs by name.
-- * Identify the presence of unknown debuffs by dispel type.
--
-- * The ability to filter all of the above by class.
--
-- Optional/Secondary Requirements:
-- * Identify the absence of known buffs by name.
-- * Identify the absence of known buffs by name that are cast by the player.

-- Proposal:
-- * Iterate over known buff names and call UnitAura(unit, name, "HELPFUL") for
--   each one.  It is likely that the list of buff names is shorter than the
--   number of buffs on the unit.
-- * Iterate over known buff names that are cast by the player and call
--   UnitAura(unit, name, "HELPFUL|PLAYER") for each one.  It is likely that the
--   combined list of buff names and buff names that are cast by the player is
--   shorter than the number of buffs on the unit.
-- * Iterate over all debuffs on the unit by calling
--   UnitAura(unit, index, "HARMFUL").  It is likely that the list of debuffs is
--   longer than the number of debuffs on the unit.  While scanning the debuffs
--   keep track of each debuff type seen and information about the last debuff
--   of that type seen.

-- durationAuras[status][guid] = { <aura properties> }
GridStatusAuras.durationAuras = {}
GridStatusAuras.durationTimer = {
	timer = nil,
	refresh = nil,
	minRefresh = nil,
}

local GetTime = GetTime
local now = GetTime()

local texCoords = { left = 0.06, right = 0.94, top = 0.06, bottom = 0.94 }

-- Simple resource pool implemented as a singly-linked list.
local Pool = {
	pool = nil,
	new = function(self, obj) -- create new Pool object
		obj = obj or {}
		setmetatable(obj, self)
		self.__index = self
		return obj
	end,
	get = function(self) -- get a cleaned item from the pool
		if not self.pool then self.pool = { nextPoolItem = self.pool } end
		local item = self.pool
		self.pool = self.pool.nextPoolItem
		item.nextPoolItem = nil
		if self.clean then
			self:clean(item)
		end
		return item
	end,
	put = function(self, item) -- put an item back into the pool; caller shall remove references to item
		item.nextPoolItem = self.pool
		self.pool = item
	end,
	clean = nil, -- called in Pool:new() to return a "cleaned" pool item
	empty = function(self) -- empty the pool
		while self.pool do
			local l = self.pool
			self.pool = self.pool.nextPoolItem
			l = nil
		end
	end,
}

-- durationAuraPool is a Pool of tables used by durationAuras[status][guid]
local durationAuraPool = Pool:new(
	{
		clean = function(self, item)
			item.duration = nil
			item.expirationTime = nil
		end
	}
)

function GridStatusAuras:UnitGainedDurationStatus(status, guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
	local timer = self.durationTimer
	local settings = self.db.profile[status]
	if not settings then return end

	if settings.enable and (settings.statusText == "duration" or settings.statusColor == "duration") then
		if not self.durationAuras[status] then
			self.durationAuras[status] = {}
		end
		if not self.durationAuras[status][guid] then
			self.durationAuras[status][guid] = durationAuraPool:get()
		end
		self.durationAuras[status][guid] = {
			class = class,
			rank = rank,
			count = count,
			debuffType = debuffType,
			duration = duration,
			expirationTime = expirationTime,
			caster = caster,
			isStealable = isStealable,
		}
		if not timer.minRefresh or settings.refresh < timer.minRefresh then
			timer.minRefresh = settings.refresh
		end
	else
		self:UnitLostDurationStatus(status, guid, class, name)
	end
end

function GridStatusAuras:UnitLostDurationStatus(status, guid, class, name)
	local auras = self.durationAuras[status]
	if auras and auras[guid] then
		durationAuraPool:put(auras[guid])
		auras[guid] = nil
	end
end

function GridStatusAuras:DeleteDurationStatus(status)
	local auras = self.durationAuras[status]
	if not auras then return end
	for guid in auras do
		durationAuraPool:put(auras[guid])
		auras[guid] = nil
	end
	self.durationAuras[status] = nil
end

function GridStatusAuras:ResetDurationStatuses()
	for status in pairs(self.durationAuras) do
		self:DeleteDurationStatus(status)
	end
	durationAuraPool:empty()
end

function GridStatusAuras:HasActiveDurations()
	for status, auras in pairs(self.durationAuras) do
		for guid in pairs(auras) do
			return true
		end
	end
	return false
end

function GridStatusAuras:ResetDurationTimer(hasActiveDurations)
	local timer = self.durationTimer
	if hasActiveDurations then
		if timer.timer and timer.refresh and timer.minRefresh ~= timer.refresh then
			self:Debug("ResetDurationTimer: cancel timer", timer.minRefresh, timer.refresh)
			self:CancelTimer(timer.timer, true)
		end
		timer.refresh = timer.minRefresh
		if not timer.timer then
			self:Debug("ResetDurationTimer: set timer", timer.refresh)
			timer.timer = self:ScheduleRepeatingTimer("RefreshActiveDurations", timer.refresh)
		end
	else
		if timer.timer then
			self:Debug("ResetDurationTimer: cancel timer")
			self:CancelTimer(timer.timer, true)
		end
		timer.timer = nil
		timer.refresh = nil
	end
end

function GridStatusAuras:StatusTextColor(settings, count, timeLeft)
	local text, color

	count = count or 0
	timeLeft = timeLeft or 0

	if settings.statusText == "name" then
		text = settings.text
	elseif settings.statusText == "duration" then
		if settings.durationTenths then
			text = f2s(timeLeft, 1) --string.format("%.1f", tostring(timeLeft))
		else
			text = n2s(floor(timeLeft+.5)) --string.format("%d", tostring(timeLeft))
		end
	elseif settings.statusText == "count" then
		text = n2s(count)
	end 

	if settings.missing or settings.statusColor == "present" then
		color = settings.color
	elseif settings.statusColor == "duration" then
		if timeLeft <= settings.durationLow then
			color = settings.durationColorLow
		elseif timeLeft <= settings.durationHigh then
			color = settings.durationColorMiddle
		else
			color = settings.durationColorHigh
		end
	elseif settings.statusColor == "count" then
		if count <= settings.countLow then
			color = settings.countColorLow
		elseif count <= settings.countHigh then
			color = settings.countColorMiddle
		else
			color = settings.countColorHigh
		end
	end

	return text, color
end

function GridStatusAuras:RefreshActiveDurations()
	now = GetTime()

	self:Debug("RefreshActiveDurations", now)

	for status, auras in pairs(self.durationAuras) do
		local settings = self.db.profile[status]
		if settings and settings.enable and not settings.missing and settings[class] ~= false then
			for guid, aura in pairs(auras) do
				local count, duration, expirationTime, icon = aura.count, aura.duration, aura.expirationTime, aura.icon
				local start = expirationTime and (expirationTime - duration)
				local timeLeft = expirationTime and expirationTime > now and (expirationTime - now) or 0
				local text, color = self:StatusTextColor(settings, count, timeLeft)
				self.core:SendStatusGained(guid,
					status,
					settings.priority,
					(settings.range and 40),
					color,
					text,
					count,
					nil,
					icon,
					start,
					duration,
					count,
					texCoords)
			end
		else
			self.core:SendStatusLost(guid, status)
		end
	end
end

function GridStatusAuras:UnitGainedBuff(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
	self:Debug("UnitGainedBuff", guid, class, name)

	local status = GridStatusAuras.StatusForSpell(name, true)
	local settings = self.db.profile[status]
	if not settings then return end

	settings.icon = icon

	if settings.enable and not settings.missing and settings[class] ~= false then
		local start = expirationTime and settings.statusText ~= "count" and (expirationTime - duration)
		local timeLeft = expirationTime and expirationTime > now and (expirationTime - now) or 0
		local text, color = self:StatusTextColor(settings, count, timeLeft)
		if duration and expirationTime and duration > 0 and expirationTime > 0 then
			self:UnitGainedDurationStatus(status, guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
		end
		self.core:SendStatusGained(guid,
			status,
			settings.priority,
			(settings.range and 40),
			color,
			text,
			count,
			nil,
			icon,
			start,
			duration,
			count,
			texCoords)
	else
		self.core:SendStatusLost(guid, status)
	end
end

function GridStatusAuras:UnitLostBuff(guid, class, name)
	self:Debug("UnitLostBuff", guid, class, name)

	local status = GridStatusAuras.StatusForSpell(name, true)
	local settings = self.db.profile[status]
	if not settings then return end

	if settings.enable and settings.missing and settings[class] ~= false then
		local text, color = self:StatusTextColor(settings, 0, 0)
		self:UnitLostDurationStatus(status, guid, class, name)
		self.core:SendStatusGained(guid,
			status,
			settings.priority,
			(settings.range and 40),
			color,
			text,
			nil,
			nil,
			settings.icon)
	else
		self.core:SendStatusLost(guid, status)
	end
end

function GridStatusAuras:UnitGainedPlayerBuff(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
	self:Debug("UnitGainedPlayerBuff", guid, name)

	local status = GridStatusAuras.StatusForSpell(name, true)
	local settings = self.db.profile[status]
	if not settings then return end

	settings.icon = icon

	if settings.enable and not settings.missing and settings[class] ~= false then
		local start = expirationTime and (expirationTime - duration)
		local timeLeft = expirationTime and expirationTime > now and (expirationTime - now) or 0
		local text, color = self:StatusTextColor(settings, count, timeLeft)
		if duration and expirationTime and duration > 0 and expirationTime > 0 then
			self:UnitGainedDurationStatus(status, guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
		end
		self.core:SendStatusGained(guid,
			status,
			settings.priority,
			(settings.range and 40),
			color,
			text,
			count,
			nil,
			icon,
			start,
			duration,
			count,
			texCoords)
	else
		self.core:SendStatusLost(guid, status)
	end
end

function GridStatusAuras:UnitLostPlayerBuff(guid, class, name)
	self:Debug("UnitLostPlayerBuff", guid, name)

	local status = GridStatusAuras.StatusForSpell(name, true)
	local settings = self.db.profile[status]
	if not settings then return end

	if settings.enable and settings.missing and settings[class] ~= false then
		local text, color = self:StatusTextColor(settings, 0, 0)
		self:UnitLostDurationStatus(status, guid, class, name)
		self.core:SendStatusGained(guid,
			status,
			settings.priority,
			(settings.range and 40),
			color,
			text,
			nil,
			nil,
			settings.icon)
	else
		self.core:SendStatusLost(guid, status)
	end
end

function GridStatusAuras:UnitGainedDebuff(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
	self:Debug("UnitGainedDebuff", guid, class, name)

	local status = GridStatusAuras.StatusForSpell(name, false)
	local settings = self.db.profile[status]
	if not settings then return end

	if settings.enable and settings[class] ~= false then
		local start = expirationTime and (expirationTime - duration)
		local timeLeft = expirationTime and expirationTime > now and (expirationTime - now) or 0
		local text, color = self:StatusTextColor(settings, count, timeLeft)
		if duration and expirationTime and duration > 0 and expirationTime > 0 then
			self:UnitGainedDurationStatus(status, guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
		end
		self.core:SendStatusGained(guid,
			status,
			settings.priority,
			(settings.range and 40),
			color,
			text,
			count,
			nil,
			icon,
			start,
			duration,
			count,
			texCoords)
	else
		self.core:SendStatusLost(guid, status)
	end
end

function GridStatusAuras:UnitLostDebuff(guid, class, name)
	self:Debug("UnitLostDebuff", guid, class, name)
	local status = GridStatusAuras.StatusForSpell(name, false)
	local settings = self.db.profile[status]
	if not settings then return end

	self:UnitLostDurationStatus(status, guid, class, name)
	self.core:SendStatusLost(guid, status)
end

function GridStatusAuras:UnitGainedDebuffType(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
	self:Debug("UnitGainedDebuffType", guid, class, debuffType)

	local status = debuffType and "debuff_" .. strlower(debuffType)
	local settings = self.db.profile[status]
	if not settings then return end

	if settings.enable and settings[class] ~= false then
		local start = expirationTime and (expirationTime - duration)
		local timeLeft = expirationTime and expirationTime > now and (expirationTime - now) or 0
		local text, color = self:StatusTextColor(settings, count, timeLeft)
		if duration and expirationTime and duration > 0 and expirationTime > 0 then
			self:UnitGainedDurationStatus(status, guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
		end
		self.core:SendStatusGained(guid,
			status,
			settings.priority,
			(settings.range and 40),
			color,
			text,
			count,
			nil,
			icon,
			start,
			duration,
			count,
			texCoords)
	else
		self.core:SendStatusLost(guid, status)
	end
end

function GridStatusAuras:UnitLostDebuffType(guid, class, debuffType)
	self:Debug("UnitLostDebuffType", guid, class, debuffType)

	local status = debuffType and "debuff_" .. strlower(debuffType)
	local settings = self.db.profile[status]
	if not settings then return end

	self:UnitLostDurationStatus(status, guid, class, name)
	self.core:SendStatusLost(guid, status)
end

function GridStatusAuras:UpdateAuraScanList()
	for name in pairs(buff_names) do
		buff_names[name] = nil
	end

	for name in pairs(player_buff_names) do
		player_buff_names[name] = nil
	end

	for name in pairs(debuff_names) do
		debuff_names[name] = nil
	end

	for status, settings in pairs(self.db.profile) do
		if type(settings) == "table" and settings.enable then
			local name = settings.text

			if name and not debuff_types[name] then
				local isBuff = GridStatusAuras.StatusForSpell(name, true) == status

				if isBuff then
					if settings.mine then
						player_buff_names[name] = true
					else
						buff_names[name] = true
					end
				else
					debuff_names[name] = true
				end
			end
		end
	end
end

-- temp tables
local buff_names_seen = {}
local player_buff_names_seen = {}
local debuff_names_seen = {}
local debuff_types_seen = {}

function GridStatusAuras:ScanUnitAuras(event, unit)
	local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID

	local guid = UnitGUID(unit)
	if not GridRoster:IsGUIDInRaid(guid) then
		return
	end

	local _, class
	if UnitIsPlayer(unit) then
		_, class = UnitClass(unit)
		if class then
			class = class:lower()
		end
	else
		class = "pet" -- should catch pets, vehicles, and anything else
	end

	self:Debug("UNIT_AURA", unit, guid)

	now = GetTime()

	for status, auras in pairs(self.durationAuras) do
		if auras[guid] then
			durationAuraPool:put(auras[guid])
			auras[guid] = nil
		end
	end

	-- scan for buffs
	for buff_name in pairs(buff_names) do
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura(unit, buff_name, nil, "HELPFUL")

		if name then
			buff_names_seen[name] = true
			self:UnitGainedBuff(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
		end
	end

	if UnitIsVisible(unit) then
		for buff_name in pairs(player_buff_names) do
			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura(unit, buff_name, nil, "HELPFUL|PLAYER")

			if name then
				player_buff_names_seen[name] = true
				self:UnitGainedPlayerBuff(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
			end
		end
	end

	-- scan for debuffs
	local index = 1
	while true do
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID = UnitAura(unit, index, "HARMFUL")

		if not name then
			break
		end
		if debuff_names[name] then
			debuff_names_seen[name] = true
			self:UnitGainedDebuff(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
		elseif debuff_types[debuffType] then
			-- elseif so that a named debuff doesn't trigger the type status
			debuff_types_seen[debuffType] = true
			self:UnitGainedDebuffType(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
		end
		name = format("%d", spellID)
		if debuff_names[name] then
				debuff_names_seen[name] = true
				self:UnitGainedDebuff(guid, class, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable)
		end

		index = index + 1
	end

	-- handle lost buffs
	for name in pairs(buff_names) do
		if not buff_names_seen[name] then
			self:UnitLostBuff(guid, class, name)
		else
			buff_names_seen[name] = nil
		end
	end

	for name in pairs(player_buff_names) do
		if not player_buff_names_seen[name] then
			self:UnitLostPlayerBuff(guid, class, name)
		else
			player_buff_names_seen[name] = nil
		end
	end

	-- handle lost debuffs
	for name in pairs(debuff_names) do
		if not debuff_names_seen[name] then
			self:UnitLostDebuff(guid, class, name)
		else
			debuff_names_seen[name] = nil
		end
	end

	for debuffType in pairs(debuff_types) do
		if not debuff_types_seen[debuffType] then
			self:UnitLostDebuffType(guid, class, debuffType)
		else
			debuff_types_seen[debuffType] = nil
		end
	end

	self:ResetDurationTimer(self:HasActiveDurations())
end
