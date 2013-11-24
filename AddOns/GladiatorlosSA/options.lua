local GSA = GladiatorlosSA
local gsadb
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GladiatorlosSA")
local LSM = LibStub("LibSharedMedia-3.0")


function GSA:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(GetAddOnMetadata("GladiatorlosSA", "Title"))
end

function GSA:ChangeProfile()
	gsadb = self.db1.profile
	for k,v in GladiatorlosSA:IterateModules() do
		if type(v.ChangeProfile) == 'function' then
			v:ChangeProfile()
		end
	end
end

function GSA:AddOption(name, keyName)
	return AceConfigDialog:AddToBlizOptions("GladiatorlosSA", name, "GladiatorlosSA", keyName)
end

local function setOption(info, value)
	local name = info[#info]
	gsadb[name] = value
	if value then 
		PlaySoundFile("Interface\\Addons\\"..gsadb.path.."\\"..name..".ogg","Master");
	end
end
local function getOption(info)
	local name = info[#info]
	return gsadb[name]
end
local function spellOption(order, spellID, ...)
	local spellname, _, icon = GetSpellInfo(spellID)				
	if (spellname ~= nil) then
		return {
			type = 'toggle',
			name = "\124T" .. icon .. ":24\124t" .. spellname,							
			desc = function () 
				GameTooltip:SetHyperlink(GetSpellLink(spellID));
				--GameTooltip:Show();
			end,
			descStyle = "custom",
					order = order,
		}
	else

		GSA.log("spell id: " .. spellID .. " is invalid")
		return {
			type = 'toggle',
			name = "unknown spell, id:" .. spellID,	
			order = order,
		}
	end
end

local function listOption(spellList, listType, ...)
	local args = {}
	for k, v in pairs(spellList) do
		if GSA.spellList[listType][v] then
			rawset (args, GSA.spellList[listType][v] ,spellOption(k, v))
		else 
		--[[debug
			print (v)
		]]
		end
	end
	return args
end

function GSA:MakeCustomOption(key)

	local options = self.options.args.custom.args
	local db = gsadb.custom
	options[key] = {
		type = 'group',
		name = function() return db[key].name end,
		set = function(info, value) local name = info[#info] db[key][name] = value end,
		get = function(info) local name = info[#info] return db[key][name] end,
		order = db[key].order,
		args = {
			name = {
				name = L["name"],
				type = 'input',
				set = function(info, value)
					if db[value] then GSA.log(L["same name already exists"]) return end
					db[value] = db[key]
					db[value].name = value

					db[value].order = #db + 1
					db[value].soundfilepath = "Interface\\GSASound\\"..value..".ogg"


					db[key] = nil
					--makeoption(value)

					options[value] = options[key]
					options[key] = nil
					key = value
				end,
				order = 10,
			},
			spellid = {
				name = L["spellid"],
				type = 'input',
				order = 20,
				pattern = "%d+$",
			},
			remove = {
				type = 'execute',
				order = 25,
				name = L["Remove"],
				confirm = true,
				confirmText = L["Are you sure?"],
				func = function() 


					db[key] = nil
					options[key] = nil
				end,
			},
			test = {
				type = 'execute',
				order = 28,
				name = L["Test"],
				func = function() PlaySoundFile(db[key].soundfilepath, "Master") end,
			},
			existingsound = {
				name = L["Use existing sound"],
				type = 'toggle',
				order = 30,
			},
			existinglist = {
				name = L["choose a sound"],
				type = 'select',
				dialogControl = 'LSM30_Sound',
				values =  LSM:HashTable("sound"),
				disabled = function() return not db[key].existingsound end,
				order = 40,
			},
			NewLine3 = {
				type= 'description',
				order = 45,
				name= '',
			},
			soundfilepath = {
				name = L["file path"],
				type = 'input',
				width = 'double',
				order = 27,
				disabled = function() return db[key].existingsound end,
			},
			eventtype = {
				type = 'multiselect',
				order = 50,
				name = L["event type"],
				values = self.GSA_EVENT,
				get = function(info, k) return db[key].eventtype[k] end,
				set = function(info, k, v) db[key].eventtype[k] = v end,
			},
			sourceuidfilter = {
				type = 'select',
				order = 61,
				name = L["Source unit"],
				values = self.GSA_UNIT,
			},
			sourcetypefilter = {
				type = 'select',
				order = 59,
				name = L["Source type"],
				values = self.GSA_TYPE,
			},
			sourcecustomname = {
				type= 'input',
				order = 62,
				name= L["Custom unit name"],
				disabled = function() return not (db[key].sourceuidfilter == "custom") end,
			},
			destuidfilter = {
				type = 'select',
				order = 65,
				name = L["Dest unit"],
				values = self.GSA_UNIT,
			},
			desttypefilter = {
				type = 'select',
				order = 60,
				name = L["Dest type"],
				values = self.GSA_TYPE,
			},
			destcustomname = {
				type= 'input',
				order = 68,
				name = L["Custom unit name"],
				disabled = function() return not (db[key].destuidfilter == "custom") end,
			},
			--[[NewLine5 = {
				type = 'header',
				order = 69,
				name = "",
			},]]
		}
	}
end
	

function GSA:OnOptionCreate()
	gsadb = self.db1.profile
	
	self.options = {
		type = "group",
		name = GetAddOnMetadata("GladiatorlosSA", "Title"),
		args = {
			general = {
				type = 'group',
				name = L["General"],
				desc = L["General options"],
				set = setOption,
				get = getOption,
				order = 1,
				args = {
					enableArea = {
						type = 'group',
						inline = true,
						name = L["Enable area"],
						order = 1,
						args = {
							all = {
								type = 'toggle',
								name = L["Anywhere"],
								desc = L["Alert works anywhere"],
								order = 1,
							},
							arena = {
								type = 'toggle',
								name = L["Arena"],
								desc = L["Alert only works in arena"],
								disabled = function() return gsadb.all end,
								order = 2,
							},
							NewLine1 = {
								type= 'description',
								order = 3,
								name= '',
							},
							battleground = {
								type = 'toggle',
								name = L["Battleground"],
								desc = L["Alert only works in BG"],
								disabled = function() return gsadb.all end,
								order = 4,
							},
							field = {
								type = 'toggle',
								name = L["World"],
								desc = L["Alert works anywhere else then anena, BG, dungeon instance"],
								disabled = function() return gsadb.all end,
								order = 5,
							}
						},
					},
					voice = {
						type = 'group',
						inline = true,
						name = L["Voice config"],
						order = 2,
						args = {
							path = {
								type = 'select',
								name = L["Voice language"],
								desc = L["Select language of the alert"],
								values = self.GSA_LANGUAGE,
								order = 1,
							},
							volumn = {
								type = 'range',
								max = 1,
								min = 0,
								step = 0.1,
								name = L["Volume"],
								desc = L["adjusting the voice volume(the same as adjusting the system master sound volume)"],
								set = function (info, value) SetCVar ("Sound_MasterVolume",tostring (value)) end,
								get = function () return tonumber (GetCVar ("Sound_MasterVolume")) end,
								order = 2,
							},
						},
					},
					advance = {
						type = 'group',
						inline = true,
						name = L["Advance options"],
						order = 3,
						args = {
							smartDisable = {
								type = 'toggle',
								name = L["Smart disable"],
								desc = L["Disable addon for a moment while too many alerts comes"],
								order = 1,
							},
							throttle = {
								type = 'range',
								max = 5,
								min = 0,
								step = 0.1,
								name = L["Throttle"],
								desc = L["The minimum interval of each alert"],
								order = 2,
							},
						},
					},
				},
			},
			spells = {
				type = 'group',
				name = L["Abilities"],
				desc = L["Abilities options"],
				set = setOption,
				get = getOption,
				childGroups = "tab",
				order = 2,
				args = {
					spellGeneral = {
						type = 'group',
						name = L["Disable options"],
						desc = L["Disable abilities by type"],
						inline = true,
						order = -1,
						args = {
							aruaApplied = {
								type = 'toggle',
								name = L["Disable Buff Applied"],
								desc = L["Check this will disable alert for buff applied to hostile targets"],
								order = 1,
							},
							aruaRemoved = {
								type = 'toggle',
								name = L["Disable Buff Down"],
								desc = L["Check this will disable alert for buff removed from hostile targets"],
								order = 2,
							},
							castStart = {
								type = 'toggle',
								name = L["Disable Spell Casting"],
								desc = L["Chech this will disable alert for spell being casted to friendly targets"],
								order = 3,
							},
							castSuccess = {
								type = 'toggle',
								name = L["Disable special abilities"],
								desc = L["Check this will disable alert for instant-cast important abilities"],
								order = 4,
							},
							interrupt = {
								type = 'toggle',
								name = L["Disable friendly interrupt"],
								desc = L["Check this will disable alert for successfully-landed friendly interrupting abilities"],
								order = 5,
							}
						},
					},
					spellAuraApplied = {
						type = 'group',
						--inline = true,
						name = L["Buff Applied"],
						disabled = function() return gsadb.aruaApplied end,
						order = 1,
						args = {
							aonlyTF = {
								type = 'toggle',
								name = L["Target and Focus Only"],
								desc = L["Alert works only when your current target or focus gains the buff effect or use the ability"],
								order = 1,
							},
							drinking = { 
								type = 'toggle',
								name = L["Alert Drinking"],
								desc = L["In arena, alert when enemy is drinking"],
								order = 3,
							},
								--[[general = {
								type = 'group',
								inline = true,
								name = L["General Abilities"],
								order = 4,
								args = listOption({42292,20594,7744},"auraApplied"),
							},]]
							dk	= {
								type = 'group',
								inline = true,
								name = L["|cffC41F3BDeath Knight|r"],
								order = 5,
								args = listOption({49039,48792,55233,49016,51271,48707,115989,113072},"auraApplied"),
							},
							druid = {
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 6,
								args = listOption({61336,29166,22812,132158,16689,22842,5229,1850,50334,69369,124974,106922,112071,102342,110575,110570,110617,110696,110700,110717,122291,110806,110717,110715,110788,126456,126453},"auraApplied"),	
							},
							hunter = {
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 7,
								args = listOption({34471,19263,3045,54216,113073},"auraApplied"),
							},
							mage = {
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 8,
								args = listOption({45438,12042,12472,12043,108839,110909},"auraApplied"),
							},
							monk = {
								type = 'group',
								inline = true,
								name = L["|cFF558A84Monk|r"],
								order = 9,
								args = listOption({120954,122278,122783,115213,115176,116849,115294,113306},"auraApplied"),
							},
							paladin = {
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 10,
								args = listOption({1022,1044,642,6940,54428,31884,114917,114163,20925,114039,105809,31842,113075},"auraApplied"),
							},
							preist	= {
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 11,
								args = listOption({10060,33206,37274,6346,47585,89485,81700,47788,112833,109964},"auraApplied"),
							},
							rogue = {
								type = 'group',
								inline = true,
								name = L["|cffFFF569Rogue|r"],
								order = 12,
								args = listOption({51713,2983,31224,13750,5277,74001,114018},"auraApplied"),
							},
							shaman	= {
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 13,
								args = listOption({30823,974,16188,79206,16166,114050,114051,114052,52127},"auraApplied"),
							},
							warlock	= {
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 14,
								args = listOption({108416,108503,113858,113861,113860,104773},"auraApplied"),
							},
							warrior	= {
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 15,
								args = listOption({55694,871,18499,23920,12328,46924,12292,1719,114028,107574,114029,114030},"auraApplied"),	
							},
						},
					},
					spellAuraRemoved = {
						type = 'group',
						--inline = true,
						name = L["Buff Down"],
						disabled = function() return gsadb.aruaRemoved end,
						order = 2,
						args = {
							ronlyTF = {
								type = 'toggle',
								name = L["Target and Focus Only"],
								desc = L["Alert works only when your current target or focus gains the buff effect or use the ability"],
								order = 1,
							},
							dk = {
								type = 'group',
								inline = true,
								name = L["|cffC41F3BDeath Knight|r"],
								order = 4,
								args = listOption({48792,49039,113072},"auraRemoved"),
							},
							druid = {
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 5,
								args = listOption({106922,110617,110696,110700,110715,110788,126456,126453},"auraRemoved"),
							},
							hunter = {
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 6,
								args = listOption({19263},"auraRemoved"),
							},
							mage = {
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 7,
								args = listOption({45438},"auraRemoved"),
							},
							monk = {
								type = 'group',
								inline = true,
								name = L["|cFF558A84Monk|r"],
								order = 9,
								args = listOption({120954,115213,115176},"auraRemoved"),	
							},
							paladin = {
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 10,
								args = listOption({1022,642},"auraRemoved"),
							},
							preist	= {
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 11,
								args = listOption({33206,47585,109964},"auraRemoved"),
							},
							rogue = {
								type = 'group',
								inline = true,
								name = L["|cffFFF569Rogue|r"],
								order = 12,
								args = listOption({31224,5277,74001},"auraRemoved"),
							},
							shaman	= {
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 13,
								args = listOption({108271,118350,118347},"auraRemoved"),
							},
							warrior	= {
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 14,
								args = listOption({871,103827,114030},"auraRemoved"),
							},
						},
					},
					spellCastStart = {
						type = 'group',
						--inline = true,
						name = L["Spell Casting"],
						disabled = function() return gsadb.castStart end,
						order = 2,
						args = {
							conlyTF = {
								type = 'toggle',
								name = L["Target and Focus Only"],
								desc = L["Alert works only when your current target or focus gains the buff effect or use the ability"],
								order = 1,
							},
							general = {
								type = 'group',
								inline = true,
								name = L["General Abilities"],
								order = 3,
								args = {
									bigHeal = {
										type = 'toggle',
										name = L["Big Heals"],
										desc = L["Greater Heal, Divine Light, Greater Healing Wave, Healing Touch, Enveloping Mist"],
										order = 1,
									},
									resurrection = {
										type = 'toggle',
										name = L["Resurrection"],
										desc = L["Resurrection, Redemption, Ancestral Spirit, Revive, Resuscitate"],
										order = 2,
									},
								}
							},
							druid = {
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 4,
								args = listOption({2637,33786,339,110707},"castStart"),
							},
							hunter = {
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 5,
								args = listOption({982,1513,120360},"castStart"),
							},
							mage = {
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 6,
								args = listOption({118,102051,113074},"castStart"),
							},
							monk = {
								type = 'group',
								inline = true,
								name = L["|cFF558A84Monk|r"],
								order = 7,
								args = listOption({113275},"castStart"),	
							},
							paladin = {
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 8,
								args = listOption({20066,115750},"castStart"),
							},
							preist	= {
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 9,
								args = listOption({9484,605,32375,113277,113506},"castStart"),
							},
							shaman	= {
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 10,
								args = listOption({51514,76780},"castStart"),
							},
							warlock	= {
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 11,
								args = listOption({5782,710,691,112869,112870,112867,112866},"castStart"),
							},
							--dk	= {
								--type = 'group',
								--inline = true,
								--name = L["|cffC41F3BDeath Knight|r"],
								--order = 9,
								--args = listOption({49203},"castStart"),
							--},			
						},
					},
					spellCastSuccess = {
						type = 'group',
						--inline = true,
						name = L["Special Abilities"],
						disabled = function() return gsadb.castSuccess end,
						order = 3,
						args = {
							sonlyTF = {
								type = 'toggle',
								name = L["Target and Focus Only"],
								desc = L["Alert works only when your current target or focus gains the buff effect or use the ability"],
								order = 1,
							},
							class = {
								type = 'toggle',
								name = L["PvP Trinketed Class"],
								desc = L["Also announce class name with trinket alert when hostile targets use PvP trinket in arena"],
								disabled = function() return not gsadb.trinket end,
								order = 3,
							},
							general = {
								type = 'group',
								inline = true,
								name = L["General Abilities"],
								order = 4,
								args = listOption({58984,20594,7744,42292},"castSuccess"),
							},
							dk	= {
								type = 'group',
								inline = true,
								name = L["|cffC41F3BDeath Knight|r"],
								order = 5,
								args = listOption({47528,47476,47568,49206,77606,108194,108199,108201,108200},"castSuccess"),
							},
							druid = {
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 6,
								args = listOption({102280,80964,740,78675,108238,102693,102703,102706,99,5211,102795,102560,102543,102558,33891,102359,33831,102417,102383,49376,16979,102416,102401,110698,110730,113002,113004,122292,112970,128844,126458},"castSuccess"),
							},
							hunter = {
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 7,
								args = listOption({19386,19503,34490,147362,60192,1499,109248,109304,131894,120697,109259,126216,126215,126214,126213,122811,122809,122807,122806,122804,122802,121118,121818},"castSuccess"),
							},
							mage = {
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 8,
								args = listOption({11129,11958,44572,2139,66,12051,113724,110959},"castSuccess"),
							},
							monk = {
								type = 'group',
								inline = true,
								name = L["|cFF558A84Monk|r"],
								order = 9,
								args = listOption({116841,115399,119392,119381,116847,123904,115078,122057,115315,115313,117368,122470,116705,123761,119996},"castSuccess"),
							},
							paladin = {
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 10,
								args = listOption({31821,96231,853,105593,85499},"castSuccess"),
							},
							preist	= {
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 110,
								args = listOption({113277,112833,8122,34433,64044,15487,64843,19236,108920,108921,123040,121135,108968,81209,81206,81208},"castSuccess"),
							},
							rogue = {
								type = 'group',
								inline = true,
								name = L["|cffFFF569Rogue|r"],
								order = 111,
								args = listOption({121471,51722,2094,1766,14185,1856,76577,73981,79140},"castSuccess"),
							},
							shaman	= {
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 112,
								args = listOption({108271,8177,16190,8143,98008,108270,51485,108273,108285,108287,108280,108281,118345,2894,2062,108269,120668,118350,118347,57994,113287},"castSuccess"),
							},
							warlock = {
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 113,
								args = listOption({108359,6789,5484,19647,48020,30283,111397,108482,108505,124539,104316,110913,111859,111895,111896,111897,111898},"castSuccess"),
							},
							warrior	= {
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 114,
								args = listOption({97462,676,5246,6552,2457,71,2458,107566,102060,46968,118000,107570,114207,114192,114203,114028},"castSuccess"),	
							},
						},
					},
					spellInterrupt = {
						type = 'group',
						--inline = true,
						name = L["Friendly Interrupt"],
						disabled = function() return gsadb.interrupt end,
						order = 4,
						args = {
							lockout = {
								type = 'toggle',
								name = L["Friendly Interrupt"],
								desc = L["Spell Lock, Counterspell, Kick, Pummel, Mind Freeze, Skull Bash, Rebuke, Solar Beam, Spear Hand Strike, Wind Shear"],
								order = 1,
							},
						}
					},
				},
			},
			custom = {
				type = 'group',
				name = L["Custom"],
				--name = L["自定義"],
				desc = L["Custom Spell"],
				--set = function(info, value) local name = info[#info] gsadb.custom[name] = value end,
				--get = function(info) local name = info[#info]	return gsadb.custom[name] end,
				order = 4,
				args = {
					newalert = {
						type = 'execute',
						name = L["New Sound Alert"],
						--name = L["添加自定義技能"],
						order = -1,
						--[[args = {
							newname = {
								type = 'input',
								name = "name",
								set = function(info, value) local name = info[#info] if gsadb.custom[vlaue] then log("name already exists") return end gsadb.custom[vlaue]={} end,			
							}]]
						func = function()
							gsadb.custom[L["New Sound Alert"]] = {
								name = L["New Sound Alert"],
								soundfilepath = "Interface\\GSASound\\"..L["New Sound Alert"]..".ogg",
								sourceuidfilter = "any",
								destuidfilter = "any",
								eventtype = {
									SPELL_CAST_SUCCESS = true,
									SPELL_CAST_START = false,
									SPELL_AURA_APPLIED = false,
									SPELL_AURA_REMOVED = false,
									SPELL_INTERRUPT = false,
								},
								sourcetypefilter = COMBATLOG_FILTER_EVERYTHING,
								desttypefilter = COMBATLOG_FILTER_EVERYTHING,
								order = 0,
							}
							self:MakeCustomOption(L["New Sound Alert"])
						end,
						disabled = function()
							if gsadb.custom[L["New Sound Alert"]] then
								return true
							else
								return false
							end
						end,
					}
				}
			}
		}
	}
	for k, v in pairs(gsadb.custom) do
		self:MakeCustomOption(k)
	end	
	AceConfig:RegisterOptionsTable("GladiatorlosSA", self.options)
	self:AddOption(L["General"], "general")
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db1)
	self.options.args.profiles.order = -1
	
	self:AddOption(L["Abilities"], "spells")
	self:AddOption(L["Custom"], "custom")
	self:AddOption(L["Profiles"], "profiles")
end