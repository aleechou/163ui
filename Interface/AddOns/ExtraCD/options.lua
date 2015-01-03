local mod = ExtraCD
local L = LibStub("AceLocale-3.0"):GetLocale("ExtraCD")
local LSM = LibStub("LibSharedMedia-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local function setOption(info, value)
	local name = info[#info]
	mod.db[name] = value
	mod:ResetAllIcons()
end

local function getOption(info)
	local name = info[#info]
	return mod.db[name]
end

local function newSpellTable(data)
	local t = {}
	if type(data) == "table" then 
		for k, v in pairs(data) do
			t[k] = v
		end
	else
		t.type = "custom"
	end
	t.enable = true
	return t
end

local function newProcTable()
	local t = {
		enable = true,
		samples = 0,
		data = {},
		avgInterval = 0,
		combatTime = 0,
	}
	return t
end

function mod:AddSubOption(name, keyName)
	return AceConfigDialog:AddToBlizOptions("ExtraCD", name, "ExtraCD", keyName)
end

function mod:AddDataOption(spellId)
	if not spellId then 
		return
	end
	local name, _, icon = GetSpellInfo(spellId)
	local dbKey = tostring(spellId)
	local db = self.db.spells[dbKey]
	if not name then 
		mod:log(L["spell not exists, id:"] .. spellId)
		self.db.spells[dbKey] = nil
		return 
	end	
	local isOriginal = ( db.type ~= "custom" ) and true or false
	local op = self.options.args.advance.args.data.args
	op[dbKey] = {
		type = "group",
		name = function() local s = name if db.type == "custom" then s = " * " .. name end if not db.enable then s = "|cffDD1133" .. s .. "|r" end return s end,
		icon = icon,
		args = {
			enable = {
				type = "toggle",
				desc = function() GameTooltip:SetHyperlink(GetSpellLink(spellId)) end,
				descStyle = "custom",
				name = function() if not db.desc or db.desc == "" then return "\124T"..icon..":24\124t" .. name else return  "\124T" .. icon .. ":24\124t" .. name ..  " (" .. (db.desc).. ")"  end end,
				set = function(info, value) db.enable = value self:ResetAllIcons() self:ResetActiveOrders() end,
				get = function() return db.enable end,
				width = "full",
				order = 1,
			},
			header = {
				type = "header",
				name = "",
				order = 2,
			},
			--[[class = {					
				name = L["Class"],
				type = "select",
				values = mod.CLASS,
				disabled = function() return self.db.dataLock end,
				get = function() return db.class end,
				set = function(info, value) db.class = value end,
			},]]
			--[[type = {
				name = L["Type"],
				type = "select",
				values = mod.CD_TYPE,
				disabled = function() return self.db.dataLock end,
				get = function() return db.type end,
				set = function(info, value) db.type = value end,
			},]]
			cd = {
				name = L["CD"],
				type = "input",
				disabled = function() return self.db.dataLock and isOriginal end,
				get = function() return tostring(db.cd or 0) end,
				set = function(info, value) db.cd = tonumber(value) self:ResetAllIcons() end,
				pattern = "^%d+$",
			},
			duration = {
				name = L["Duration"],
				type = "input",
				disabled = function() return self.db.dataLock and isOriginal end,
				get = function() return tostring(db.duration or 0) end,
				set = function(info, value) db.duration = tonumber(value) self:ResetAllIcons() end,
				pattern = "^%d+$",
			},
			rppm = {
				name = L["RPPM"],
				type = "input",
				disabled = function() return self.db.dataLock and isOriginal end,
				get = function() 
					if not db.ppm then return "0" end
					local _, class = UnitClass("player")
					local spec = GetSpecialization("player")
					local specppm
					if type(db.ppm) == "table" then
						if db.ppm[class] then 
							specppm = db.ppm[class][spec] * db.ppm.BASE
						else
							specppm = db.ppm.OTHER * db.ppm.BASE
						end
					else 
						specppm = db.ppm
					end
					return tostring(specppm)
				end,
				set = function(info, value) db.ppm = tonumber(value) self:ResetAllIcons() end,
				pattern = "^%d+$",
			},
			refreshable = {
				type = "toggle",
				name = L["Refreshable"],
				desc = L["Check this if the buff is refreshable up to 130% normal duration."],
				get = function() return db.refreshable end,
				set = function(info, value) db.refreshable = value self:ResetAllIcons() end,
			},
			spellId = {
				name = L["Spell ID"],
				type = "input",
				disabled = true,
				get = function() return dbKey end,
				pattern = "^%d+$",
			},
			delete = {
				name = L["DELETE"],
				type = "execute",
				disabled = isOriginal,
				confirm = true,
				confirmText = L["Are you sure to delete the data?"],
				func = function() self.db.spells[dbKey] = nil op[dbKey] = nil self:ResetAllIcons() self:ResetActiveOrders() end,
				order = -1,
			},
		},
	}
end

function mod:RemoveDataOptions()
	local t = self.options.args.advance.args.proc.args
	for k in pairs(t) do
		if tonumber(k) then	t[k] = nil end
	end
	t = self.options.args.advance.args.data.args
	for k in pairs(t) do
		if tonumber(k) then	t[k] = nil end
	end
	t = self.options.args.advance.args.sorting.args
	for k in pairs(t) do
		if tonumber(k) then	t[k] = nil end
	end
end

function mod:AddProcOption(spellId)
	if not spellId then 
		return
	end
	local name, _, icon = GetSpellInfo(spellId)
	local dbKey = tostring(spellId)
	local db = self.db.procs[dbKey]
	if not name then 
		mod:log(L["spell not exists, id:"] .. spellId)
		self.db.procs[dbKey] = nil
		return 
	end	
	local op = self.options.args.advance.args.proc.args
	op[dbKey] = {
		type = "group",
		name = name,
		icon = icon,
		args = {
			enable = {
				type = "toggle",
				desc = function() GameTooltip:SetHyperlink(GetSpellLink(spellId)) end,
				descStyle = "custom",
				name = "\124T" .. icon .. ":24\124t" .. name,
				set = function(info, value) db.enable = value end,
				get = function() return db.enable end,
				width = "full",
				order = 1,
			},
			header = {
				type = "header",
				name = "",
				order = 2,
			},
			minimumInterval = {
				name = function() return (L["Minimum interval: "] .. "%.3f"):format(db.minInterval or 0) end,
				type = "description",
				order = 10,
			},
			maximumInterval = {
				name = function() return (L["Maximum interval: "] .. "%.3f"):format(db.maxInterval or 0) end,
				type = "description",
				order = 20,
			},
			averageInterval = {
				name = function() return (L["Average interval: "] .. "%.3f"):format(db.avgInterval or 0) end,
				type = "description",
				order = 30,
			},
			estimatedCD = {
				name = function() return L["Estimated CD: "] .. (db.minInterval and math.floor(db.minInterval + 0.1) or "N/A") end,
				type = "description",
				order = 40,
				width = "normal",
			},
			samples = {
				name = function() return L["Total number of test samples: "] .. db.samples end,
				type = "description",
				order = 8,
			},
			
			refresh = {
				order = 42,
				name = L["Refresh"],
				type = "execute",
				func = function() end,				
			},
			
			header2 = {
				type = "header",
				name = "",
				order = 45,
			},
			
			duration = {
				name = L["Buff duration"],
				type = "input",
				get = function() return tostring(db.duration or 0) end,
				set = function(info, value) db.duration = math.max(value, 0) end,
				pattern = "^%d+$",
				order = 50,
			},
			combatTime = {
				name = L["Combat time"],
				desc = L["Set this field 0 to calculate the average coverage in infinite time, otherwise calculate the coverage in the specified time"],
				type = "input",
				get = function() return tostring(db.combatTime or 0) end,
				set = function(info, value) db.combatTime = math.max(value, 0) end,
				pattern = "^%d+$",
				order = 60,
			},
			exactCD = {
				name = L["Exact CD"],
				desc = L["In general, no need to set this field. If the exact cd of this spell is already known and does not equal to the estimated cd, add it here to calculate more accurately."],
				type = "input",
				get = function() return tostring(db.exactCD or "N/A") end,
				set = function(info, value) db.exactCD = math.max(value, 0) end,
				pattern = "^%d+$",
				order = 65,
			},
			calculate = {
				name = L["Calculate"],
				type = "execute",
				disabled = function() if db.minInterval and db.combatTime then return false else return true end end,
				func = function()
					local effectTime = math.min(db.combatTime - db.avgInterval + (db.exactCD or math.floor(db.minInterval + 0.1)), db.combatTime)
					if effectTime < 0 then
						db.procTimes = 0
						db.tDuration = 0
					else
						db.procTimes = math.floor(effectTime / db.avgInterval) + 1
						db.tDuration = (db.procTimes  - 1) * (db.duration or 0) + math.min(effectTime - (db.procTimes - 1) * db.avgInterval, (db.duration or 0))
					end
					if db.combatTime == 0 then 
						db.coverage = math.min(1, (db.duration or 0) / db.avgInterval)
					else
						db.coverage = math.min(1, db.tDuration / db.combatTime)
					end
				end,
				order = 70,
			},
			
			procTimes = {
				name = function() return L["Number of times: "] .. (db.procTimes or 0) end,
				type = "description",	
				order = 80,
			},
			totalProcDuration = {
				name = function() return (L["Total proc duration: "] .. "%.3f"):format(db.tDuration or 0) end,
				type = "description",
				order = 90,
			},
			coverage = {
				name = function() return (L["Average coverage: "] .. "%.2f%%"):format((db.coverage or 0.00001) * 100) end,
				type = "description",
				order = 100,
			},
			spellId = {
				name = L["Spell ID"],
				type = "input",
				disabled = true,
				get = function() return dbKey end,
				pattern = "^%d+$",
				order = 110,
			},
			delete = {
				name = L["DELETE"],
				type = "execute",
				confirm = true,
				confirmText = L["Are you sure to delete the data?"],
				func = function() self.db.procs[dbKey] = nil op[dbKey] = nil end,
				order = -1,
			},
		},
	}
end

function mod:AddSortingOption(order, spellId, enable)
	if not spellId then 
		return
	end
	local name, _, icon = GetSpellInfo(spellId)
	local dbKey = tostring(spellId)
	if not name then 
		mod:log(L["spell not exists, id:"] .. spellId)
		self.db.sortingData[dbKey] = nil
		return 
	end	
	if not self.db.sortingData[dbKey] then 
		self.db.sortingData[dbKey] = {}
	end
	local db = self.db.sortingData[dbKey]
	db.enable = enable
	local active = self.bar.active
	if enable then
		db.order = order
	else
		db.order = db.order or 100
	end
	local op = self.options.args.advance.args.sorting.args
	op[dbKey] = {
		type = "group",
		name = name,
		icon = icon,
		order = function() return enable and db.order or order end,
		disabled = function() return not db.enable end,
		args = {
			moveUp = {
				order = 42,
				name = L["Move up"],
				type = "execute",
				func = function()
					if order > 1 then 
						--active[order], active[order-1] = active[order-1], active[order]
						db.order = order - 1
						self.db.sortingData[tostring(active[order-1].id)].order = order
						self:ResetAllIcons()
						self:ResetActiveOrders()
					end
				end,	
				disabled = function() return not self.db.sorting end,
			},
			moveDown = {
				order = 44,
				name = L["Move down"],
				type = "execute",
				func = function() 
					if active[order+1] then
						--active[order], active[order+1] = active[order+1], active[order]
						db.order = order + 1
						self.db.sortingData[tostring(active[order+1].id)].order = order
						self:ResetAllIcons()
						self:ResetActiveOrders()
					end
				end,
				disabled = function() return not self.db.sorting end,
			},
		},
	}
end

function mod:OnOptionCreate()
	
	self.db = self.db1.profile
	local newSpellId, newDataName, newProcId
	self.options = {
		type = "group",
		name = GetAddOnMetadata("ExtraCD", "Title"),
		args = {
			general = {
				type = "group",
				name = "General",
				get = getOption,
				set = setOption,
				order = 1,
				args = {
					ecddesc1 = {
						type = "description",
						order = 0,
						name = GetAddOnMetadata("ExtraCD", "Notes"),
					},
					ecdheader1 = {
						type = "header",
						order = 1,
						name = "",
					},
					autoload = {
						type = "group",
						order = 2,
						inline = true,
						name = L["Automatically scan and load icds of the types below"],
						args = {
							talent = {
								name = L["talent"],
								desc = L["Scan and show internal cooldown of player's talent."],
								type = "toggle",
								order = 100,
							},
							enchant = {
								name = L["enchant"],
								desc = L["Scan and show internal cooldown of player's enchant."],
								type = "toggle",
								order = 110,
							},
							item = {
								name = L["item"],
								desc = L["Scan and show internal cooldown of player's trinket and special weapons."],
								type = "toggle",
								order = 130,
							},
							itemset = {
								name = L["item set"],
								desc = L["Scan and show internal cooldown of player's item set."],
								type = "toggle",
								order = 140,
							},
							spec = {
								name = L["spec"],
								desc = L["Scan and show internal cooldown of player's specializations."],
								type = "toggle",
								order = 150,
							},
							gem = {
								name = L["gem"],
								desc = L["Scan and show player's special(legendary) gems"],
								type = "toggle",
								order = 160,
							},
						},
					},					
					rppm = {
						type = "group",
						order = 3,
						inline = true,
						name = L["RPPM Options"],
						args = {
							showRPPM = {
								name = L["Show icons for RPPM"],
								desc = L["Show icons for enchants or items with RPPM"],
								type = "toggle",
								order = 1,
							},
							showMultiples = {
								name = L["Modified rppm"],
								desc = L["Show rppm modified by player stat and time since last proc(the number is capped by 6 out of combat)"],
								type = "toggle",
								order = 2,
							},
						},
					},
					ecdheader3 = {
						type = "header",
						order = 160,
						name = ""
					},			
					ecdheader2 = {
						type = "header",
						order = 304,
						name = ""
					},
					lock = {
						name = L["Lock frame"],
						desc = L["Set the frame locked."],
						type = "toggle",
						order = 305,
						set = function(info, value) self.bar:SetMovable(not value) self.db.lock = value end,
					},
					combat = {
						name = L["Combat only"],
						desc = L["Show the icon only in combat."],
						type = "toggle",
						order = 306,
					},
					tip = {
						name = L["Show tooltip"],
						desc = L["Show tooltip for the icons."],
						type = "toggle",
						order = 310,
					},
					showcd = {
						name = L["Show cooldown"],
						desc = L["Show cooldown upon the icons."],
						type = "toggle",
						order = 311,
					},
					showglow = {
						name = L["Show glow"],
						desc = L["Show glow for the icons."],
						type = "toggle",
						order = 312,
					},
					showtext = {
						name = L["Show cooldonw text"],
						desc = L["Show cooldown text for the procs."],
						type = "toggle",
						order = 313,
					},
					rowmax = {
						name = L["Icons each row"],
						desc = L["Set the icons in each row"],
						type = "range",
						max = 20,
						min = 1,
						step = 1,
						order = 333,
					},
					textOpacity = {
						name = L["Text opacity"],
						type = "range",
						order = 315,
						max = 1,
						min = 0,
						step = 0.1,
						set = function (info, value) self.db.textOpacity = value end,
					},
					glowOpacity = {
						type = "range",
						order = 316,
						name = L["Glow opacity"],
						max = 1,
						min = 0,
						step = 0.1,
					},
					textsize = {
						name = L["Text size"],
						desc = L["Set the cooldown text size"],
						type = "range",
						max = 30,
						min = 10,
						step = 1,
						order = 320,				
					},
					textfont = {
						name = L["Text font"],
						desc = L["Set the font of the text"],
						type = "select",
						dialogControl = 'LSM30_Font',
						values = LSM:HashTable("font"),
						order = 321,
					},
					iconinterval = {
						name = L["Icon interval"],
						desc = L["Set the interval size between icons"],
						type ="range",
						max = 20,
						min = 0,
						step = 1,
						order = 323,
					},
					iconsize = {
						name = L["Icon size"],
						desc = L["Set the icon size"],
						type = "range",
						max = 60,
						min = 24,
						step = 1,
						order = 330,					
					},
					ecdheader4 = {
						type = "header",
						name = "",
						order = 348,
					},
					ecddesc2 = {
						type = "description",
						name = L["When you crtl+right click at the icon, it will be disabled. If you want to show it again, enable the spell in the list in advance option. The disabled spells will be at the end of the spell list."],
						order = 349,
					},
					iconborder = {
						name = L["Icon border"],
						desc = L["Set the icon border"],
						type = "select",
						dialogControl = 'LSM30_Border',
						values = LSM:HashTable("border"),
						order = 340,
					},
				},
			},	
			advance = {
				type = "group",
				name = "Advance",
				childGroups = "tab",
				args = {
					data = {
						type = "group",
						name = L["Data"],
						args = {
							ecddesc4 = {
								type = "description",
								name = L["Data options provide more customized options for adding new cds and modifying the original cds"],
								order = 1,
							},
							ecddesc3 = {
								type = "description",
								name = L["Add a new custom cd(no limit of being an icd), and manage it by yourself.(marked with '*')"],
								order = 5
							},
							ecdheader5 = {
								type = "header",
								name = "",
								order = 2,
							},
							--[[name = {
								name = L["Name"],
								type = "input",
								set = function(info, value) newDataName = value end,
								get = function() return newDataName end,
								pattern = "%w+$",
								order = 9,
							},]]
							spellId = {
								name = L["Spell ID"],
								type = "input",
								set = function(info, value) newSpellId = value end,
								get = function() return newSpellId end,
								pattern = "^%d+$",
								order = 8,
							},
							addCustom = {
								type = "execute",
								name = L["Add New CD"],
								func = function()
									if not newSpellId then return end
									if not self.db.spells[newSpellId] then
										self.db.spells[newSpellId] = newSpellTable()
										self:AddDataOption(tonumber(newSpellId))
										self:ResetAllIcons()
										self:ResetActiveOrders()
									else
										self:log("Id '" .. newSpellId .. "' " .. L["already exists."])
									end
								end,
								order = 10,
							},
							ecdheader6 = {
								type = "header",
								name = "",
								order = 40,
							},
							dataReset = {
								type = "execute",
								name = L["Reset Original Data"],
								desc = L["To reset all addon original data, your custom data and proc test data will not be changed"],
								confirm = true,
								confirmText = L["Are you sure to reset all addon original data?"],
								order = 100,
								func = function()
									local data = self:GetSpellData()
									local db = self.db.spells
									local op = self.options.args.advance.args.data.args
									for k, v in pairs(db) do
										if v.type ~= "custom" then
											db[k] = nil
											op[k] = nil
										end
									end
									for k, v in pairs(data) do
										k = tostring(k)
										db[k] = newSpellTable(v)
									end
									for k, v in pairs(db) do
										self:AddDataOption(tonumber(k))
									end
									self:ResetAllIcons()
									self:ResetActiveOrders()
								end,
							},
							dataDelete = {
								type = "execute",
								name = L["Delete Custom Data"],
								desc = L["To delete all custom data, the addon original data and proc test data will not be changed"],
								confirm = true,
								confirmText = L["Are you sure to delete all custom data?"],
								order = 120,
								func = function()
									local op = self.options.args.advance.args.data.args
									local data = self:GetSpellData()
									local db = self.db.spells
									for k, v in pairs(db) do
										if v.type == "custom" then
											db[k] = nil
											op[k] = nil
										end
									end
									self:ResetAllIcons()
									self:ResetActiveOrders()
								end,
							},
							dataLock = {
								type = "execute",
								set = setOption,
								get = getOption,
								desc = L["To unlock or lock the original data. It's suggested that you should not modify the addon original data, some advance users may need this feature."],
								name = function() if self.db.dataLock then return L["Unlock Original Data"] else return L["Lock Original Data"] end end,
								func = function() self.db.dataLock = not self.db.dataLock end,
								order = 140,
							},
							ecdheader9 = {
								type = "header",
								order = 380,
								name = "",
							},
						}
					},
					proc = {
						type = "group",
						name = L["Proc Test"],
						get = getOption,
						set = setOption,
						args = {
							ecddesc8 = {
								type = "description",
								name = L["Proc test provides the feature of testing coverage of proc and estimating the real icds of the unknown"],
								order = 1,
							},
							ecdheader9 = {
								type = "header",
								order = 2,
								name = "",
							},
							spellId = {
								name = L["Spell ID"],
								type = "input",
								set = function(info, value) newProcId = value end,
								get = function() return newProcId end,
								pattern = "^%d+$",
								order = 8,
							},
							ecddesc = {
								type = "description",
								name = L["Add a new proc test(no limit of being a proc), and manage it by yourself."],
								order = 5
							},
							addProc = {
								type = "execute",
								name = L["Add New Proc Test"],
								order = 10,
								func = function()
									if not newProcId then return end
									if not self.db.procs[newProcId] then
										self.db.procs[newProcId] = newProcTable()
										self:AddProcOption(tonumber(newProcId))
									else
										self:log("Id '" .. newProcId .. "' " .. L["already exists."])
									end
								end,
							},
							ecdheader10 = {
								type = "header",
								order = 20,
								name = "",
							},
						}
					},
					sorting = {
						type = "group",
						name = L["Sorting"],
						get = getOption,
						set = setOption,
						args = {
							ecddesc8 = {
								type = "description",
								name = L["Sorting options provide the feature to sort the order of icons by yourself."],
								order = 1,
							},
							ecdheader11 = {
								type = "header",
								order = 2,
								name = "",
							},
							sorting = {
								type = "toggle",
								name = L["Enable custom sorting"],
								order = 10,
							},
							ecdheader9 = {
								type = "header",
								order = 20,
								name = "",
							},
							
						}
					}
				},
			},			
		}
	}
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db1)
	self.options.args.profiles.order = -1
	LibStub("AceConfig-3.0"):RegisterOptionsTable("ExtraCD", ExtraCD.options)
	
	self:AddDataToOptions()
	
	self.optionFrames = {}
	self.optionFrames.general = AceConfigDialog:AddToBlizOptions("ExtraCD", "ExtraCD" , nil, "general")	
	self.optionFrames.advance = self:AddSubOption(L["Advance"], "advance")
	self.optionFrames.profiles = self:AddSubOption(L["Profiles"], "profiles")
end

function mod:AddDataToOptions()
	local db = self.db.spells
	-- add options
	for k, v in pairs(db) do
		self:AddDataOption(tonumber(k))
	end		
	-- add proc data
	db = self.db.procs
	for k, v in pairs(db) do
		self:AddProcOption(tonumber(k))
	end
	-- add sorting data
	for k, v in pairs(self.bar.active) do
		self:AddSortingOption(k, v.id, true)
	end
	for k, v in pairs(self.db.sortingData) do
		if not v.enable then
			self:AddSortingOption(#(self.bar.active) + v.order, k, false)
		end
	end
end

function mod:InitDB()
	-- add addon data
	self.db = self.db1.profile
	do
		local data = self:GetSpellData()
		local db = self.db.spells
				
		-- initialize db
		local dVersion = self:GetDataVersion()
		if self.db.dataVersion < dVersion then
			for k, v in pairs(db) do
				if v.type ~= "custom" then
					db[k] = nil
				end
			end
			self.db.dataVersion = dVersion
			for k, v in pairs(data) do
				k = tostring(k)
				db[k] = newSpellTable(v)
			end
		end		
	end	
end