--
--	JSHB Options - timer sets
--

local L = _G.JSHB.L

function JSHB.Options:CreateTimerSet(setNum)
	local DB = _G.JSHB.Options.DB
	local timersetstable = {
		enabled = {
			type = "toggle",
			order = 1,
			name = L["Enable"],
			get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
			set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
		},
		spacer2 = { order = 2, type = "description", name = " ", desc = "", width = "half" },
		spacer3 = { order = 3, type = "description", name = " ", desc = "", width = "half" },
		wizard = {
			type = "execute",
			order = 4,
			name = L["WIZARD"],
			func = function(info) JSHB.Wizard_TimerBars(setNum) end,
		},
		maintab = {
			order = 1,
			type = "group",
			name = L["Timers"],
			args = {
				headerstuff = {
					order = 2,
					type = "group",
					name = " ",
					guiInline = true,
					args = {
						timercount = {
							order = 4,
							type = "description",
							fontSize = "large",
							width = "double",
							name = "  "..(#DB.timers["timerbar"..setNum].timers).." "..L["TIMERCOUNTFORSET"],
						},
						newtimer = {
							order = 6,
							type = "execute",
							name = L["Add new timer"],
							hidden = function(info) return (not DB.timers["timerbar"..setNum].enabled) end,
							confirm = function() return(L["ADDTIMER_CONFIRM"]) end,
							func = function(info)
									DB.timers["timerbar"..setNum].timers[#DB.timers["timerbar"..setNum].timers + 1] = JSHB.DeepCopy(JSHB.newTimerDefaults)
									DB.timers["timerbar"..setNum].timers[#DB.timers["timerbar"..setNum].timers][19] = #DB.timers["timerbar"..setNum].timers
									JSHB.Options:SortTimerList(setNum)
									LibStub("AceConfigRegistry-3.0"):NotifyChange("JSHB")
									JSHB.Options:LockDown(JSHB.SetupTimersModule)
								end,
						},
					},
				},
			},
		},
		barsettings = {
			order = 4,
			type = "group",
			name = L["Bar settings"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
				width = {
					type = "range", 
					order = 6,
					name = L["Bar width"],
					min = 6, softMax = 600, max = 1000, step = 1,
					disabled = function(info) return(DB.timers["timerbar"..setNum].stationary) end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, size) DB.timers["timerbar"..setNum][info[#info] ] = (size);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				height = {
					type = "range", 
					order = 8,
					name = L["Bar height"],
					min = 6, softMax = 600, max = 1000, step = 1,
					disabled = function(info) return(DB.timers["timerbar"..setNum].stationary) end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, size) DB.timers["timerbar"..setNum][info[#info] ] = (size);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				layout = {
					order = 10,
					type = "select",
					name = L["Layout"],
					desc = L["TIMERORIENTATION_DESC"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					style = "dropdown",
					values = function() 
							local t = {	["horizontal"] = L["Horizontal"], ["vertical"] = L["Vertical"], }
							return(t)
						end,
					get = function(info) return(DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				stationary = {
					type = "toggle",
					order = 12,
					name = L["Stationary icons"],
					desc = L["STATIONARYDESC_ENABLE"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value)
							DB.timers["timerbar"..setNum][info[#info] ] = value
							-- Resort the list on a change!
							JSHB.Options:SortTimerList(setNum)
							LibStub("AceConfigRegistry-3.0"):NotifyChange("JSHB")
							JSHB.Options:LockDown(JSHB.SetupTimersModule)
						end,
				},
				prioritize = {
					type = "toggle",
					order = 14,
					name = L["Reorder with priority"],
					desc = L["PRIORITIZEDESC_ENABLE"],
					disabled = function(info) return ( (not DB.timers["timerbar"..setNum]["enabled"]) or (not DB.timers["timerbar"..setNum].stationary) ) end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value; JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				reverse = {
					type = "toggle",
					order = 16,
					name = (DB.timers["timerbar"..setNum].stationary ~= true) and L["Reverse movement"] or L["Reverse fill"],
					desc = L["REVERSEDESC_ENABLE"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				stationaryanchorpoint = {
					order = 17,
					type = "select",
					name = L["Build point"],
					desc = L["BUILDPOINT_DESC"],
					hidden = function(info) return(not DB.timers["timerbar"..setNum].stationary) end,
					style = "dropdown",
					values = JSHB.stationaryTimerAnchors,
					get = function(info) return( (DB.timers["timerbar"..setNum][info[#info] ] == nil) and "CENTER" or DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				logarithmic = {
					type = "toggle",
					order = 18,
					name = L["Logarithmic"],
					desc = L["LOGARITHMIC_DESC"],
					hidden = function(info) return (not DB.timers["timerbar"..setNum].showsettings) or (DB.timers["timerbar"..setNum].stationary) end,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value; JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
			},
		},
		baralpha = {
			order = 6,
			type = "group",
			name = L["Bar alpha"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
				activealpha = {
					type = "range",
					order = 20,
					name = L["Active alpha"],
					desc = L["ACTIVEALPHA_DESC"],
					min = 0, max = 1, step = .1,
					isPercent = true,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				inactivealpha = {
					type = "range",
					order = 22,
					name = L["Inactive alpha"],
					desc = L["INACTIVEALPHA_DESC"],
					min = 0, max = 1, step = .1,
					isPercent = true,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer24 = { order = 24, type = "description", name = " ", desc = "" },
				oocoverride = {
					type = "toggle",
					order = 26,
					name = L["OOC override"],
					desc = L["ENABLEOOCOVERRIDE_DESC"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				oocoverridealpha = {
					type = "range",
					order = 28,
					name = L["OOC alpha"],
					min = 0, max = 1, step = .1,
					isPercent = true,
					disabled = function(info) 
						if not DB.timers["timerbar"..setNum]["oocoverride"] then return true end
						if not DB.timers["timerbar"..setNum]["enabled"] then return true end
						return false end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer30 = { order = 30, type = "description", name = " ", desc = "" },
				mountoverride = {
					type = "toggle",
					order = 32,
					name = L["Mounted override"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				mountoverridealpha = {
					type = "range",
					order = 34,
					name = L["Mounted alpha"],
					min = 0, max = 1, step = .1,
					isPercent = true,
					disabled = function(info) 
						if not DB.timers["timerbar"..setNum]["mountoverride"] then return true end
						if not DB.timers["timerbar"..setNum]["enabled"] then return true end
						return false end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer36 = { order = 36, type = "description", name = " ", desc = "" },
				deadoverride = {
					type = "toggle",
					order = 38,
					name = L["Dead override"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabled"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				deadoverridealpha = {
					type = "range",
					order = 40,
					name = L["Dead alpha"],
					desc = L["DEADALPHA_DESC"],
					min = 0, max = 1, step = .1,
					isPercent = true,
					disabled = function(info) 
						if not DB.timers["timerbar"..setNum]["deadoverride"] then return true end
						if not DB.timers["timerbar"..setNum]["enabled"] then return true end
						return false end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
			},
		},
		backdrop = {
			type = "group",
			order = 8,
			name = L["Bar backdrop"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
				enablebackdrop = {
					type = "toggle",
					order = 4,
					name = L["Enable"],
					width = "double",
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				backdroptexture = {
					type = "select",
					dialogControl = 'LSM30_Background_JS',
					order = 12,
					name = L["Backdrop texture"],
					values = AceGUIWidgetLSMlists.background,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				colorbackdrop = {
					type = "toggle",
					order = 14,
					name = L["Color the backdrop"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				backdropcolor = {
					type = "color",
					order = 16,
					name = L["Backdrop color"],
					hasAlpha = true,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
					hidden = function(info) return not DB.timers["timerbar"..setNum].colorbackdrop end,
					get = function(info) return unpack(DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, r, g, b, a) DB.timers["timerbar"..setNum][info[#info] ] = {r, g, b, a};JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer18 = { order = 18, type = "description", name = " ", desc = "", width = "half", hidden = function(info) return not DB.timers["timerbar"..setNum].colorbackdrop end },
				tile = {
					type = "toggle",
					order = 20,
					name = L["Tile the backdrop"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				tilesize = {
					type = "range",
					order = 22,
					name = L["Tile size"],
					min = -100, softMin = -30, softMax = 30, max = 100, step = 1,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
					hidden = function(info) return not DB.timers["timerbar"..setNum].tile end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer24 = { order = 24, type = "description", name = "", desc = "", width = "full"},
				backdropoffsets = {
					type = "group",
					order = 28,
					name = L["Offsets"],
					guiInline = true,
					args = {
						offsetX1 = {
							type = "range",
							order = 1,
							name = L["Top-left X"],
							min = -50, softMin = -10, softMax = 0, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][1]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][1] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						offsetY1 = {
							type = "range", 
							order = 2,
							name = L["Top-left Y"],
							min = -50, softMin = 0, softMax = 10, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][2]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][2] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						spacer8 = { order = 8, type = "description", name = "", desc = "", width = "full"},
						offsetX2 = {
							type = "range", 
							order = 13,
							name = L["Bottom-right X"],
							min = -50, softMin = 0, softMax = 10, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][3]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][3] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						offsetY2 = {
							type = "range", 
							order = 14,
							name = L["Bottom-right Y"],
							min = -50, softMin = -10, softMax = 0, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["enablebackdrop"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][4]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][4] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},										
					},
				},
			},
		},
		border = {
			type = "group",
			order = 12,
			name = L["Bar border"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
				enableborder = {
					type = "toggle",
					order = 1,
					name = L["Enable"],
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				bordercolor = {
					type = "color",
					order = 2,
					name = L["Border color"],
					hasAlpha = true,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enableborder"] end,
					get = function(info) return unpack(DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, r, g, b, a) DB.timers["timerbar"..setNum][info[#info] ] = {r, g, b, a};JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				bordertexture = {
					type = "select",
					dialogControl = 'LSM30_Border_JS',
					order = 3,
					name = L["Border texture"],
					values = AceGUIWidgetLSMlists.border,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enableborder"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				edgesize = {
					type = "range",
					order = 4,
					name = L["Edge size"],
					min = -100, softMin = -16, softMax = 16, max = 100, step = 1,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enableborder"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer7 = { order = 7, type = "description", name = "", desc = "", width = "full"},
				backdropinsets = {
					type = "group",
					order = 10,
					name = L["Insets"],
					guiInline = true,
					args = {
						left = {
							type = "range",
							order = 1,
							name = L["Left"],
							min = -50, softMin = -16, softMax = 16, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["enableborder"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][1]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][1] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						right = {
							type = "range", 
							order = 2,
							name = L["Right"],
							min = -50, softMin = -16, softMax = 16, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["enableborder"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][2]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][2] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						spacer8 = { order = 8, type = "description", name = "", desc = "", width = "full"},
						top = {
							type = "range", 
							order = 13,
							name = L["Top"],
							min = -50, softMin = -16, softMax = 16, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["enableborder"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][3]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][3] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						bottom = {
							type = "range", 
							order = 18,
							name = L["Bottom"],
							min = -50, softMin = -16, softMax = 16, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["enableborder"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][4]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][4] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},										
					},
				},
			},
		},
		timersize = {
			type = "group",
			order = 14,
			name = L["Timer size"],
			--hidden = function(info) return(not DB.timers["timerbar"..setNum].stationary) end,
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full" },
				iconsize = {
					type = "range", 
					order = 2,
					name = L["Size"],
					min = 10, max = 100, step = 1,
					--disabled = function(info) return(not DB.timers["timerbar"..setNum].stationary) end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, size) DB.timers["timerbar"..setNum][info[#info] ] = (size);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
			},
		},
		timefont = {
			type = "group",
			order = 18,
			name = L["Timer font"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full" },
				font = {
					type = "select", 
					dialogControl = 'LSM30_Font_JS',
					order = 2,
					name = L["Font face"],
					values = AceGUIWidgetLSMlists.font,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info-1] ][1] end,
					set = function(info, font) DB.timers["timerbar"..setNum][info[#info-1] ][1] = font;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer4 = { order = 4, type = "description", name = " ", desc = "", width = "half" },
				size = {
					type = "range", 
					order = 6,
					name = L["Font size"],
					min = 6, max = 40, step = 1,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][2]) end,
					set = function(info, size) DB.timers["timerbar"..setNum][info[#info-1] ][2] = (size);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timerfontcolorstatic = {
					type = "toggle",
					order = 10,
					name = L["Static time color"],
					desc = L["STATICTIMERCOLOR_DESC"],
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timerfontcolor = {
					type = "color",
					order = 12,
					name = L["Static color"],
					desc = L["Color used for the time font if set to static"],
					hasAlpha = false,
					disabled = function(info) return not DB.timers["timerbar"..setNum].timerfontcolorstatic end,
					get = function(info) return unpack(DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, r, g, b, a) DB.timers["timerbar"..setNum][info[#info] ] = {r, g, b, a};JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer14 = { order = 14, type = "description", name = " ", desc = "", width = "half" },
				showtimewithoneletter = {
					type = "toggle",
					order = 15,
					name = L["Show d/h/m/s for time"],
					width = "double",
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer16 = { order = 16, type = "description", name = " ", desc = "", width = "full" },
				flags = {
					type = "multiselect", 
					order = 17,
					name = L["Font flags"],
					values = JSHB.Options.fontFlagTable,
					get = function(info, key) return(tContains({strsplit(",", DB.timers["timerbar"..setNum][info[#info-1] ][3])}, key) and true or false) end,
					set = function(info, keyname, state) JSHB.Options:SetupFontFlags(DB.timers["timerbar"..setNum][info[#info-1] ], keyname, state);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timefont = {
					type = "group",
					order = 18,
					name = L["Font shadow"],
					guiInline = true,
					hidden = function(info) return (not DB.timers["timerbar"..setNum].showsettings2) end,
					args = {
						enabletimershadow = {
							type = "toggle",
							order = 20,
							name = L["Enable"],
							width = "double",
							get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
							set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						timershadowcolor = {
							type = "color",
							order = 22,
							name = L["Color"],
							hasAlpha = true,
							disabled = function(info) return not DB.timers["timerbar"..setNum].enabletimershadow end,
							get = function(info) return unpack(DB.timers["timerbar"..setNum][info[#info] ]) end,
							set = function(info, r, g, b, a) DB.timers["timerbar"..setNum][info[#info] ] = {r, g, b, a};JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						offsetX = {
							type = "input", 
							order = 24,
							name = L["X offset"],
							width = "half",
							pattern = "%d",
							usage = L["Only valid numeric offsets are allowed."],
							disabled = function(info) return not DB.timers["timerbar"..setNum].enabletimershadow end,
							get = function(info) return tostring(DB.timers["timerbar"..setNum].timershadowoffset[1]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum].timershadowoffset[1] = tonumber(offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						offsetY = {
							type = "input", 
							order = 26,
							name = L["Y offset"],
							width = "half",
							pattern = "%d",
							usage = L["Only valid numeric offsets are allowed."],
							disabled = function(info) return not DB.timers["timerbar"..setNum].enabletimershadow end,
							get = function(info) return tostring(DB.timers["timerbar"..setNum].timershadowoffset[2]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum].timershadowoffset[2] = tonumber(offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
					},
				},
			},
		},
		stackfont = {
			type = "group",
			order = 22,
			name = L["Stacks font"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
				font = {
					type = "select", 
					dialogControl = 'LSM30_Font_JS',
					order = 2,
					name = L["Font face"],
					values = AceGUIWidgetLSMlists.font,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info-1] ][1] end,
					set = function(info, font) DB.timers["timerbar"..setNum][info[#info-1] ][1] = font;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				size = {
					type = "range", 
					order = 4,
					name = L["Font size"],
					min = 6, max = 40, step = 1,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][2]) end,
					set = function(info, size) DB.timers["timerbar"..setNum][info[#info-1] ][2] = (size);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				stackfontcolor = {
					type = "color",
					order = 6,
					name = L["Stacks font color"],
					hasAlpha = false,
					get = function(info) return unpack(DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, r, g, b, a) DB.timers["timerbar"..setNum][info[#info] ] = {r, g, b, a};JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				flags = {
					type = "multiselect", 
					order = 8,
					name = L["Font flags"],
					values = JSHB.Options.fontFlagTable,
					get = function(info, key) return(tContains({ strsplit(",", DB.timers["timerbar"..setNum][info[#info-1] ][3]) }, key) and true or false) end,
					set = function(info, keyname, state) JSHB.Options:SetupFontFlags(DB.timers["timerbar"..setNum][info[#info-1] ], keyname, state);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
			},
		},
		texcoords = {
			type = "group",
			order = 30,
			name = L["Timer texture coords"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
				enabletexcoords = {
					type = "toggle",
					order = 5,
					name = L["Enable"],
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer6 = { order = 6, type = "description", name = " ", desc = "", width = "full" },
				left = {
					type = "range",
					order = 10,
					name = L["Left"],
					min = 0, max = 1, step = .01,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabletexcoords"] end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][1]) end,
					set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][1] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				right = {
					type = "range", 
					order = 12,
					name = L["Right"],
					min = 0, max = 1, step = .01,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabletexcoords"] end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][2]) end,
					set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][2] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer14 = { order = 14, type = "description", name = " ", desc = "", width = "half" },
				top = {
					type = "range", 
					order = 16,
					name = L["Top"],
					min = 0, max = 1, step = .01,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabletexcoords"] end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][3]) end,
					set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][3] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				bottom = {
					type = "range", 
					order = 18,
					name = L["Bottom"],
					min = 0, max = 1, step = .01,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["enabletexcoords"] end,
					get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][4]) end,
					set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][4] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
			},
		},
		timerbackdrop = {
			type = "group",
			order = 32,
			name = L["Timer backdrop"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
				timerenablebackdrop = {
					type = "toggle",
					order = 1,
					name = L["Enable"],
					width = "double",
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timerbackdroptexture = {
					type = "select",
					dialogControl = 'LSM30_Background_JS',
					order = 2,
					name = L["Backdrop texture"],
					values = AceGUIWidgetLSMlists.background,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timercolorbackdrop = {
					type = "toggle",
					order = 3,
					name = L["Color the backdrop"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timerbackdropcolor = {
					type = "color",
					order = 4,
					name = L["Backdrop color"],
					width = "double",
					hasAlpha = true,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
					hidden = function(info) return not DB.timers["timerbar"..setNum].timercolorbackdrop end,
					get = function(info) return unpack(DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, r, g, b, a) DB.timers["timerbar"..setNum][info[#info] ] = {r, g, b, a};JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timertile = {
					type = "toggle",
					order = 5,
					name = L["Tile the backdrop"],
					disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timertilesize = {
					type = "range",
					order = 6,
					name = L["Tile size"],
					min = -100, softMin = -30, softMax = 30, max = 100, step = 1,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
					hidden = function(info) return not DB.timers["timerbar"..setNum].timertile end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer7 = { order = 7, type = "description", name = "", desc = "", width = "full"},
				timerbackdropoffsets = {
					type = "group",
					order = 8,
					name = L["Offsets"],
					guiInline = true,
					args = {
						offsetX1 = {
							type = "range",
							order = 2,
							name = L["Top-left X"],
							min = -50, softMin = -10, softMax = 0, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][1]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][1] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						offsetY1 = {
							type = "range", 
							order = 4,
							name = L["Top-left Y"],
							min = -50, softMin = 0, softMax = 10, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][2]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][2] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						spacer6 = { order = 6, type = "description", name = "", desc = "", width = "half"},
						offsetX2 = {
							type = "range", 
							order = 8,
							name = L["Bottom-right X"],
							min = -50, softMin = 0, softMax = 10, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][3]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][3] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						offsetY2 = {
							type = "range", 
							order = 10,
							name = L["Bottom-right Y"],
							min = -50, softMin = -10, softMax = 0, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenablebackdrop"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][4]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][4] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},										
					},
				},
			},
		},
		timerborder = {
			type = "group",
			order = 34,
			name = L["Timer border"],
			args = {
				spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
				timerenableborder = {
					type = "toggle",
					order = 6,
					name = L["Enable"],
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timerbordercolor = {
					type = "color",
					order = 8,
					name = L["Border color"],
					hasAlpha = true,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenableborder"] end,
					get = function(info) return unpack(DB.timers["timerbar"..setNum][info[#info] ]) end,
					set = function(info, r, g, b, a) DB.timers["timerbar"..setNum][info[#info] ] = {r, g, b, a};JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timerbordertexture = {
					type = "select",
					dialogControl = 'LSM30_Border_JS',
					order = 10,
					name = L["Border texture"],
					values = AceGUIWidgetLSMlists.border,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenableborder"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				timeredgesize = {
					type = "range",
					order = 14,
					name = L["Edge size"],
					min = -100, softMin = -16, softMax = 16, max = 100, step = 1,
					disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenableborder"] end,
					get = function(info) return DB.timers["timerbar"..setNum][info[#info] ] end,
					set = function(info, value) DB.timers["timerbar"..setNum][info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
				},
				spacer16 = { order = 16, type = "description", name = "", desc = "", width = "full"},
				timerbackdropinsets = {
					type = "group",
					order = 20,
					name = L["Insets"],
					guiInline = true,
					args = {
						left = {
							type = "range",
							order = 2,
							name = L["Left"],
							min = -50, softMin = -16, softMax = 16, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenableborder"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][1]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][1] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						right = {
							type = "range", 
							order = 4,
							name = L["Right"],
							min = -50, softMin = -16, softMax = 16, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenableborder"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][2]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][2] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						spacer6 = { order = 6, type = "description", name = "", desc = "", width = "half"},
						top = {
							type = "range", 
							order = 8,
							name = L["Top"],
							min = -50, softMin = -16, softMax = 16, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenableborder"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][3]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][3] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},
						bottom = {
							type = "range", 
							order = 10,
							name = L["Bottom"],
							min = -50, softMin = -16, softMax = 16, max = 50, step = 1,
							disabled = function(info) return not DB.timers["timerbar"..setNum]["timerenableborder"] end,
							get = function(info) return (DB.timers["timerbar"..setNum][info[#info-1] ][4]) end,
							set = function(info, offset) DB.timers["timerbar"..setNum][info[#info-1] ][4] = (offset);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
						},										
					},
				},
			},
		},
	}

	-- Add the timers for this bar below the general bar settings
	local ord2 = 100
	for i=1,#DB.timers["timerbar"..setNum].timers do
		if DB.timers["timerbar"..setNum].timers[i][21] then -- Expanded view
			timersetstable.maintab.args["timer" .. i] = {
				order = ord2,
				type = "group",
				name = function(info)
						local t
						if DB.timers["timerbar"..setNum].timers[i][2] == nil then
							t = DB.timers["timerbar"..setNum].timers[i][1]
							if tonumber(t) then
								return strupper(select(1, GetSpellInfo(tonumber(t) ) ) or t)
							end
							return strupper(t)
						end
						
						t = DB.timers["timerbar"..setNum].timers[i][2]							
						if tonumber(t) then
							return strupper(select(1, GetItemInfo(tonumber(t) ) ) or t)
						end
						return strupper(t)
					end,
				guiInline = true,
				hidden = function(info) return (not DB.timers["timerbar"..setNum].enabled) end,
				args = {
					spellicon = {
						order = 1,
						type = "execute",
						name = function(info)
								local t
								if DB.timers["timerbar"..setNum].timers[i][2] == nil then
									t = DB.timers["timerbar"..setNum].timers[i][1]
									if tonumber(t) then
										return(select(1, GetSpellInfo(tonumber(t) )) or t)
									end
									return(t)
								end
								
								t = DB.timers["timerbar"..setNum].timers[i][2]							
								if tonumber(t) then
									return(select(1, GetItemInfo(tonumber(t) )) or t)
								end
								return(t)
							end,
						desc = L["SPELLLICON_DESC"],
						func = function() return end,
						image = function(info)
								local t
								local q = "Interface\\ICONS\\INV_Misc_QuestionMark"
								if DB.timers["timerbar"..setNum].timers[i][2] == nil then
									t = DB.timers["timerbar"..setNum].timers[i][1]
									if tonumber(t) then
										return(select(3, GetSpellInfo(tonumber(t) )) or q)
									end
									if GetSpellInfo(t) then
										return(select(3, GetSpellInfo(t) ) or q)
									end
									return(q)
								end
								
								t = DB.timers["timerbar"..setNum].timers[i][2]							
								if tonumber(t) then
									return(select(10, GetItemInfo(tonumber(t) )) or q)
								end
								if GetItemInfo(t) then
									return(select(10, GetItemInfo(t) ) or q)
								end
								return(q)
							end,
					},
					a = { -- Spell name or ID.
						order = 2,
						type = "input",
						name = L["Enter a Spell Name or ID..."],
						desc = L["SPELL_DESC"],
						confirm = function(info)
								if DB.timers["timerbar"..setNum].timers[i][2] ~= nil then
									return(L["CHANGETOSPELL_CONFIRM"])
								end							
								return(false)
							end,
						validate = function(info, val)
								if GetSpellInfo(tonumber(val) and tonumber(val) or val) then return(true) end
								if tonumber(val) then -- If it's a Spell ID number we CAN verify it.
									print(JSHB.L["JSHB_PRE"].."|cffff0000"..L["TIMERSPELL_INVALID"].."|r")
									return(false) 
								end
								-- If it's not a Spell ID number we can only verify it if the player HAS that spell in his book.
								if not (GetSpellInfo(val) ) then -- Try to verify, if it does then we don't need to show the unverified warning.
									print(JSHB.L["JSHB_PRE"].."|cffff0000"..L["TIMERSPELL_UNVERIFIED"].."|r")
								end
								return(true)
							end,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][1] ~= nil and 
								tostring(DB.timers["timerbar"..setNum].timers[i][1]) or "") end,
						set = function(info, val)
								DB.timers["timerbar"..setNum].timers[i][2] = nil
								DB.timers["timerbar"..setNum].timers[i][1] = (tonumber(val) and tonumber(val) or val)
								JSHB.Options:SortTimerList(setNum)
								LibStub("AceConfigRegistry-3.0"):NotifyChange("JSHB")
								collectgarbage("collect")
								JSHB.Options:LockDown(JSHB.SetupTimersModule)
							end,
					},
					b = { -- Item name or ID.
						order = 3,
						type = "input",
						name = L["...or an Item Name or ID"],
						desc = L["ITEM_DESC"],
						confirm = function(info)
								if DB.timers["timerbar"..setNum].timers[i][1] ~= nil then
									return(L["CHANGETOITEM_CONFIRM"])
								end							
								return(false)
							end,
						validate = function(info, val)
								if GetItemInfo(tonumber(val) and tonumber(val) or val) then return(true) end
								if tonumber(val) then -- If it's an Item ID number we CAN verify it.
									print(JSHB.L["JSHB_PRE"].."|cffff0000"..JSHB.L["TIMERITEM_INVALID"].."|r")
									return(false) 
								end
								-- If it's not an Item ID number we can only verify it if the player HAS that item.
								if not (GetItemInfo(val) ) then -- Try to verify, if it does then we don't need to show the unverified warning.
									print(JSHB.L["JSHB_PRE"].."|cffff0000"..JSHB.L["TIMERITEM_UNVERIFIED"].."|r")
								end
								return(true)
							end,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][2] ~= nil and
								tostring(DB.timers["timerbar"..setNum].timers[i][2]) or "") end,
						set = function(info, val)
								DB.timers["timerbar"..setNum].timers[i][1] = nil
								DB.timers["timerbar"..setNum].timers[i][2] = (tonumber(val) and tonumber(val) or val)
								JSHB.Options:SortTimerList(setNum)
								LibStub("AceConfigRegistry-3.0"):NotifyChange("JSHB")
								collectgarbage("collect")
								JSHB.Options:LockDown(JSHB.SetupTimersModule)
							end,
					},
					c = { -- Target to check for the spell.
						order = 4,
						type = "select",
						name = L["Check target"],
						desc = L["CHECKTARGET_DESC"],
						hidden = function(info) return( (DB.timers["timerbar"..setNum].timers[i][2] ~= nil) and true or false) end,
						style = "dropdown",
						values = function() return JSHB.targets end,
						get = function(info) return DB.timers["timerbar"..setNum].timers[i][3] end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][3] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					d = { -- Duration, cooldown or internal cooldown
						order = 5,
						type = "select",
						name = L["Check type"],
						desc = L["CHECKTYPE_DESC"],
						hidden = function(info) return( (DB.timers["timerbar"..setNum].timers[i][2] ~= nil) and true or false) end,
						style = "dropdown",
						values = function() 
								local t = {	["DURATION"] = L["Duration"], ["COOLDOWN"] = L["Cooldown"], ["ICOOLDOWN"] = L["Internal cooldown"], }
								return(t)
							end,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][4]) end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][4] = (value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					e = { -- Owner
						order = 6,
						type = "select",
						name = L["Owner of spell"],
						desc = L["SPELLOWNER_DESC"],
						hidden = function(info) return( (DB.timers["timerbar"..setNum].timers[i][2] ~= nil) and true or false) end,
						style = "dropdown",
						values = function() return JSHB.timerOwners end,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][5]) end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][5] = (value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					whattalentspec = { -- Spec
						order = 7,
						type = "select",
						name = L["Talent spec"],
						desc = L["TALENTSPEC_DESC"],
						style = "dropdown",
						values = function()
								local t = {
									["0"] = L["Any Spec"],
									["1"] = select(2, GetSpecializationInfo(1) ),
									["2"] = select(2, GetSpecializationInfo(2) ),
									["3"] = select(2, GetSpecializationInfo(3) ),
								}
								return(t)
							end,
						get = function(info) return(tostring(DB.timers["timerbar"..setNum].timers[i][6]) ) end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][6] = tonumber(value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					timertextpos = { -- Timer text position
						order = 8,
						type = "select",
						name = L["Positon of timer text"],
						style = "dropdown",
						values = function()
								local t = JSHB.DeepCopy(JSHB.timerPositions)
								t["NONE"] = L["NONE"]
								return(t) 
							end,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][7]) end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][7] = (value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					icdnumval = { -- Internal Cooldown (code originally added by Hugus in Serenity)
						order = 9,
						type = "input",
						name = L["Internal cooldown"],
						desc = L["ICOOLDOWN_DESC"],
						hidden = function(info) return ( (DB.timers["timerbar"..setNum].timers[i][4] == nil) or (DB.timers["timerbar"..setNum].timers[i][4] ~= "ICOOLDOWN") ) end,
						validate = function(info, val)
								if tonumber(val) then return(true) end
								print(JSHB.L["JSHB_PRE"].."|cffff0000"..L2["TIMERTEXT_INVALID"].."|r")
								return(false) 
							end,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][16] ~= nil and
								tostring(DB.timers["timerbar"..setNum].timers[i][16]) or "") end,
						set = function(info, val)
								if (not tonumber(val) ) then return end
								DB.timers["timerbar"..setNum].timers[i][16] = tonumber(val)
								LibStub("AceConfigRegistry-3.0"):NotifyChange("JSHB")
								collectgarbage("collect")
								JSHB.Options:LockDown(JSHB.SetupTimersModule)
							end,
					},
					spacer10 = { order = 10, type = "description", name = "", desc = "", hidden = function(info) return (not ( (DB.timers["timerbar"..setNum].timers[i][4] == nil) or (DB.timers["timerbar"..setNum].timers[i][4] ~= "ICOOLDOWN") ) ) end },
					when = { -- When should this icon be shown if we are using stationary timers
						order = 12,
						type = "select",
						name = L["Show when:"],
						hidden = function(info) return(not DB.timers["timerbar"..setNum].stationary) end,
						style = "dropdown",
						values = function() return JSHB.whenToShow end,
						get = function(info) return( (DB.timers["timerbar"..setNum].timers[i][18] == nil) and 0 or DB.timers["timerbar"..setNum].timers[i][18]) end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][18] = ( (value == nil) and 0 or value);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					staalpha = { -- Stationary Icons alpha when always on bar and inactive
						type = "range", 
						order = 14,
						name = L["Inactive alpha"],
						desc = L["INACTIVEALPHASTA_DESC"],
						isPercent = true,
						min = 0, max = 1, step = .1,
						hidden = function(info) return(not DB.timers["timerbar"..setNum].stationary) end,
						get = function(info) return (DB.timers["timerbar"..setNum].timers[i][20] ~= nil and DB.timers["timerbar"..setNum].timers[i][20] or 0.4) end,
						set = function(info, size) DB.timers["timerbar"..setNum].timers[i][20] = (size);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					shoulditflash = { -- Flash
						type = "toggle",
						order = 16,
						name = L["Flash when expiring"],
						width = DB.timers["timerbar"..setNum].stationary and "double" or "full",
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][8]) end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][8] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					pos = { -- Position
						type = "select",
						order = 18,
						name = L["Position"],
						values = function()
							local t = {}
							for j=1,#DB.timers["timerbar"..setNum].timers do t[j] = j end 
							return(t)
						end,
						hidden = function(info) return(not DB.timers["timerbar"..setNum].stationary) end,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][19]) end,
						set = function(info, newPos)
							JSHB.Options:CheckTimerListOrder19(setNum) -- Need to be sure we have numerics properly set!
							local oldPos = DB.timers["timerbar"..setNum].timers[i][19]
							DB.timers["timerbar"..setNum].timers[i][19] = newPos
							
							if newPos > oldPos then
								for index=oldPos,newPos do
									if index ~= i then
										DB.timers["timerbar"..setNum].timers[index][19] = DB.timers["timerbar"..setNum].timers[index][19] - 1
									end
								end
							else
								for index=newPos,oldPos do
									if index ~= i then
										DB.timers["timerbar"..setNum].timers[index][19] = DB.timers["timerbar"..setNum].timers[index][19] + 1
									end
								end
							end
							
							JSHB.Options:SortTimerList(setNum)
							LibStub("AceConfigRegistry-3.0"):NotifyChange("JSHB")
							JSHB.Options:LockDown(JSHB.SetupTimersModule)
						end,
					},
					alpha_change = { -- Alpha Change
						type = "toggle",
						order = 19,
						name = L["Alpha change"],
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][13]) end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][13] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					alpha_change_start = { -- Alpha Change - Start
						type = "range", 
						order = 20,
						name = L["Alpha start %"],
						desc = L["ALPHASTART_DESC"],
						hidden = function(info) return(not DB.timers["timerbar"..setNum].timers[i][13]) end,
						isPercent = true,
						min = 0, max = 1, step = .1,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][14]) end,
						set = function(info, size) DB.timers["timerbar"..setNum].timers[i][14] = (size);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					alpha_change_end = { -- Alpha Change - End
						type = "range", 
						order = 21,
						name = L["Alpha end %"],
						desc = L["ALPHAEND_DESC"],
						hidden = function(info) return(not DB.timers["timerbar"..setNum].timers[i][13]) end,
						isPercent = true,
						min = 0, max = 1, step = .1,
						get = function(info) return(DB.timers["timerbar"..setNum].timers[i][15]) end,
						set = function(info, size) DB.timers["timerbar"..setNum].timers[i][15] = (size);JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					onlyifknown = { -- Only if known
						type = "toggle", 
						order = 22,
						name = L["Only if known"],
						desc = L["ONLYIFKNOWN_DESC"],
						get = function(info)
								if (tonumber(DB.timers["timerbar"..setNum].timers[i][9]) ) then -- Fix for old options values (old value could be numeric, this should be false!)
									return nil
								end
								return(DB.timers["timerbar"..setNum].timers[i][9])
							end,
						set = function(info, value) DB.timers["timerbar"..setNum].timers[i][9] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					spacer50 = { order = 50, type = "description", name = " ", desc = "", width = "full" },
					delete = {
						order = 52,
						type = "execute",
						name = L["Delete timer"],
						confirm = function(info) return(L["DELETETIMER_CONFIRM"]) end,
						func = function(info)
								tremove(DB.timers["timerbar"..setNum].timers, tonumber(strsub(info[#info-1],6) ) )
								JSHB.Options:SortTimerList(setNum)
								LibStub("AceConfigRegistry-3.0"):NotifyChange("JSHB")
								JSHB.Options:LockDown(JSHB.SetupTimersModule)
							end,							
					},
					spacer54 = { order = 54, type = "description", name = "", width = "half" },
					spacer56 = { order = 56, type = "description", name = "", width = "half" },
					hidesettings = {
						type = "execute",
						order = 58,
						name = L["Collapse"],
						func = function(info) JSHB.Options:CollapseAll()	end,
					},
				},					
			}
		else -- Collapsed view
			timersetstable.maintab.args["timer" .. i] = {
				order = ord2,
				type = "group",
				name = L["Timer"].." "..i,
				guiInline = true,
				inline = true,
				hidden = function(info) return (not DB.timers["timerbar"..setNum].enabled) end,
				args = {
					spellicon = {
						order = 1,
						type = "description",
						name = function(info)
							local t
							if DB.timers["timerbar"..setNum].timers[i][2] == nil then
								t = DB.timers["timerbar"..setNum].timers[i][1]
								if tonumber(t) then
									return(select(1, GetSpellInfo(tonumber(t) ) ) or t)
								end
								return(t)
							end
							
							t = DB.timers["timerbar"..setNum].timers[i][2]							
							if tonumber(t) then
								return(select(1, GetItemInfo(tonumber(t) ) ) or t)
							end
							return(t)
						end,
						width = "double",
						fontSize = "medium",
						func = function() return end,
						image = function(info)
								local t
								local q = "Interface\\ICONS\\INV_Misc_QuestionMark"
								if DB.timers["timerbar"..setNum].timers[i][2] == nil then
									t = DB.timers["timerbar"..setNum].timers[i][1]
									if tonumber(t) then
										return(select(3, GetSpellInfo(tonumber(t) )) or q)
									end
									if GetSpellInfo(t) then
										return(select(3, GetSpellInfo(t) ) or q)
									end
									return(q)
								end
								
								t = DB.timers["timerbar"..setNum].timers[i][2]							
								if tonumber(t) then
									return(select(10, GetItemInfo(tonumber(t) )) or q)
								end
								if GetItemInfo(t) then
									return(select(10, GetItemInfo(t) ) or q)
								end
								return(q)
							end,
					},
					delete2 = {
						order = 4,
						type = "execute",
						name = L["Delete"],
						width = "half",
						confirm = function(info) return(L["DELETETIMER_CONFIRM"]) end,
						func = function(info)
								tremove(DB.timers["timerbar"..setNum].timers, tonumber(strsub(info[#info-1],6) ) )
								JSHB.Options:SortTimerList(setNum)
								LibStub("AceConfigRegistry-3.0"):NotifyChange("JSHB")
								JSHB.Options:LockDown(JSHB.SetupTimersModule)
							end,							
					},
					showsettings = {
						type = "execute",
						order = 10,
						width = "half",
						name = L["Expand"],
						func = function(info) JSHB.Options:CollapseAll(); DB.timers["timerbar"..setNum].timers[i][21] = true;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
				},
			}
		end
		ord2 = ord2 + 1
	end

	return timersetstable
end
