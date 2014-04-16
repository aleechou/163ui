local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)
local media = LibStub("LibSharedMedia-3.0")

Skada.resetoptions = {[1] = L["No"], [2] = L["Yes"], [3] = L["Ask"]}

Skada.windowdefaults = {
	name = "Skada",

	barspacing=0,
	bartexture="BantoBar",
	barfont="Accidental Presidency",
	barfontflags="",
	barfontsize=11,
	barheight=15,
	barwidth=240,
	barorientation=1,
	barcolor = {r = 0.3, g = 0.3, b = 0.8, a=1},
	barbgcolor = {r = 0.3, g = 0.3, b = 0.3, a = 0.6},
	barslocked=false,
	clickthrough=false,

	classcolorbars = true,
	classcolortext = false,
	classicons = true,

	buttons = {menu = true, reset = true, report = true, mode = true, segment = true},

	title = {height = 15, font="Accidental Presidency", fontsize=11,margin=0, texture="Aluminium", bordertexture="None", borderthickness=2, color = {r=0.1,g=0.1,b=0.3,a=0.8}, fontflags = ""},
	background = {margin=0, height=200, texture="Solid", bordertexture="None", borderthickness=0, color = {r=0,g=0,b=0.5,a=0.2}},

	reversegrowth=false,
	modeincombat="",
	returnaftercombat=false,
	wipemode="",

	hidden = false,
	enabletitle = true,

	set = "current",
	mode = nil,

	display = "bar",
	snapto = true,
	scale = 1
}

local windefaultscopy = {}
Skada:tcopy(windefaultscopy, Skada.windowdefaults)

Skada.defaults = {
	profile = {
		version=1,
		reset={instance=1, join=3, leave=1},
		icon = {hide = false, radius = 80, minimapPos = 195},
		numberformat=1,
		showranks=true,
		setstokeep=10,
		tooltips=true,
		tooltippos="default",
		tooltiprows=3,
		informativetooltips=true,
		onlykeepbosses=false,
		tentativecombatstart=false,
		hidesolo=false,
		hidepvp=false,
		hidedisables=true,
		hidecombat=false,
		mergepets=true,
		feed = "",
		showtotals = false,

		modules = {},
		columns = {},
		report = {mode = "Damage", set = "current", channel = "Say", chantype = "preset", number = 10},

		windows = {windefaultscopy},
	}
}

-- Adds column configuration options for a mode.
function Skada:AddColumnOptions(mod)
	local db = self.db.profile.columns

	if mod.metadata and mod.metadata.columns then
		local cols = {
       			type = "group",
       			name = mod:GetName(),
       			order=0,
       			inline=true,
				args = {}
		}

		for colname, value in pairs(mod.metadata.columns) do
			local c = mod:GetName().."_"..colname

			-- Set initial value from db if available, otherwise use mod default value.
			if db[c] ~= nil then
				mod.metadata.columns[colname] = db[c]
			end

			-- Add column option.
			local col = {
			        type="toggle",
			        name=L[colname] or colname,
			        get=function() return mod.metadata.columns[colname] end,
			        set=function()
			        			mod.metadata.columns[colname] = not mod.metadata.columns[colname]
			        			db[c] = mod.metadata.columns[colname]
			        			Skada:UpdateDisplay(true)
			        		end,
			}
			cols.args[c] = col
		end

		Skada.options.args.columns.args[mod:GetName()] = cols
	end

end

local deletewindow = nil
local newdisplay = "bar"
Skada.options = {
	        type="group",
			name="Skada",
			plugins = {},
	        args={
	        		d = {
	        			type="description",
						name=L["A damage meter."],
						order=0,
	        		},

	        		windows = {
	        			type = "group",
	        			name = L["Windows"],
	        			order=1,
						args = {

							create = {
								type="input",
								name=L["Create window"],
								desc=L["Enter the name for the new window."],
								set=function(self, val) if val and val ~= "" then Skada:CreateWindow(val, nil, newdisplay) end end,
								order=1,
							},

							display = {
								type="select",
								name=L["Display system"],
								desc=L["Choose the system to be used for displaying data in this window."],
								values=	function()
											local list = {}
											for name, display in pairs(Skada.displays) do
												list[name] = display.name
											end
											return list
										end,
								get=function() return newdisplay end,
								set=function(i, display) newdisplay = display end,
								order=2,
							},

						},
	        		},

	        		resetoptions = {
	        			type = "group",
	        			name = L["Data resets"],
	        			order=2,
						args = {

							resetinstance = {
								type="select",
								name=L["Reset on entering instance"],
								desc=L["Controls if data is reset when you enter an instance."],
								values=	function() return Skada.resetoptions end,
								get=function() return Skada.db.profile.reset.instance end,
								set=function(self, opt) Skada.db.profile.reset.instance = opt end,
								order=30,
							},

							resetjoin = {
								type="select",
								name=L["Reset on joining a group"],
								desc=L["Controls if data is reset when you join a group."],
								values=	function() return Skada.resetoptions end,
								get=function() return Skada.db.profile.reset.join end,
								set=function(self, opt) Skada.db.profile.reset.join = opt end,
								order=31,
							},

							resetleave = {
								type="select",
								name=L["Reset on leaving a group"],
								desc=L["Controls if data is reset when you leave a group."],
								values=	function() return Skada.resetoptions end,
								get=function() return Skada.db.profile.reset.leave end,
								set=function(self, opt) Skada.db.profile.reset.leave = opt end,
								order=32,
							},

				        }

	        		},

					tooltips = {
	        			type = "group",
	        			name = L["Tooltips"],
	        			order=4,
						args = {
							tooltips = {
							        type="toggle",
							        name=L["Show tooltips"],
							        desc=L["Shows tooltips with extra information in some modes."],
							        order=1,
							        get=function() return Skada.db.profile.tooltips end,
							        set=function() Skada.db.profile.tooltips = not Skada.db.profile.tooltips end,
							},

							informative = {
							        type="toggle",
							        name=L["Informative tooltips"],
							        desc=L["Shows subview summaries in the tooltips."],
							        order=2,
							        get=function() return Skada.db.profile.informativetooltips end,
							        set=function() Skada.db.profile.informativetooltips = not Skada.db.profile.informativetooltips end,
							},

							rows = {
								type="range",
								name=L["Subview rows"],
								desc=L["The number of rows from each subview to show when using informative tooltips."],
								min=1,
								max=10,
								step=1,
								get=function() return Skada.db.profile.tooltiprows end,
								set=function(self, val) Skada.db.profile.tooltiprows = val end,
								order=3,
							},

							tooltippos = {
								type="select",
								name=L["Tooltip position"],
								desc=L["Position of the tooltips."],
								values=	{["default"] = L["Default"], ["topright"] = L["Top right"], ["topleft"] = L["Top left"]},
								get=function() return Skada.db.profile.tooltippos end,
								set=function(self, opt) Skada.db.profile.tooltippos = opt end,
								order=4,
							},
						}
					},

	        		generaloptions = {
	        			type = "group",
	        			name = L["General options"],
	        			order=3,
						args = {

							mmbutton = {
							        type="toggle",
							        name=L["Show minimap button"],
							        desc=L["Toggles showing the minimap button."],
							        order=1,
							        get=function() return not Skada.db.profile.icon.hide end,
							        set=function()
							    			Skada.db.profile.icon.hide = not Skada.db.profile.icon.hide
											Skada:RefreshMMButton()
							        	end,
							},

							mergepets = {
							        type="toggle",
							        name=L["Merge pets"],
							        desc=L["Merges pets with their owners. Changing this only affects new data."],
							        order=2,
							        get=function() return Skada.db.profile.mergepets end,
							        set=function() Skada.db.profile.mergepets = not Skada.db.profile.mergepets end,
							},

							showtotals = {
							        type="toggle",
							        name=L["Show totals"],
							        desc=L["Shows a extra row with a summary in certain modes."],
							        order=3,
							        get=function() return Skada.db.profile.showtotals end,
							        set=function() Skada.db.profile.showtotals = not Skada.db.profile.showtotals end,
							},

							onlykeepbosses = {
							        type="toggle",
							        name=L["Only keep boss fighs"],
							        desc=L["Boss fights will be kept with this on, and non-boss fights are discarded."],
							        order=4,
							        get=function() return Skada.db.profile.onlykeepbosses end,
							        set=function() Skada.db.profile.onlykeepbosses = not Skada.db.profile.onlykeepbosses end,
							},

							hidesolo = {
							        type="toggle",
							        name=L["Hide when solo"],
							        desc=L["Hides Skada's window when not in a party or raid."],
							        order=5,
							        get=function() return Skada.db.profile.hidesolo end,
							        set=function()
							        			Skada.db.profile.hidesolo = not Skada.db.profile.hidesolo
							        			Skada:ApplySettings()
							        		end,
							},

							hidepvp = {
							        type="toggle",
							        name=L["Hide in PvP"],
							        desc=L["Hides Skada's window when in Battlegrounds/Arenas."],
							        order=6,
							        get=function() return Skada.db.profile.hidepvp end,
							        set=function()
							        			Skada.db.profile.hidepvp = not Skada.db.profile.hidepvp
							        			Skada:ApplySettings()
							        		end,
							},

							hidecombat = {
							        type="toggle",
							        name=L["Hide in combat"],
							        desc=L["Hides Skada's window when in combat."],
							        order=7,
							        get=function() return Skada.db.profile.hidecombat end,
							        set=function()
							        			Skada.db.profile.hidecombat = not Skada.db.profile.hidecombat
							        			Skada:ApplySettings()
							        		end,
							},

							disablewhenhidden = {
							        type="toggle",
							        name=L["Disable while hidden"],
							        desc=L["Skada will not collect any data when automatically hidden."],
							        order=8,
							        get=function() return Skada.db.profile.hidedisables end,
							        set=function()
							        			Skada.db.profile.hidedisables = not Skada.db.profile.hidedisables
							        			Skada:ApplySettings()
							        		end,
							},

							numberformat = {
								type="select",
								name=L["Number format"],
								desc=L["Controls the way large numbers are displayed."],
								values=	function() return {[1] = L["Condensed"], [2] = L["Detailed"]} end,
								get=function() return Skada.db.profile.numberformat end,
								set=function(self, opt) Skada.db.profile.numberformat = opt end,
								order=11,
							},

							showranks = {
							        type="toggle",
							        name=L["Show rank numbers"],
							        desc=L["Shows numbers for relative ranks for modes where it is applicable."],
							        order=9,
							        get=function() return Skada.db.profile.showranks end,
							        set=function()
							        			Skada.db.profile.showranks = not Skada.db.profile.showranks
							        			Skada:ApplySettings()
							        		end,
							},

							datafeed = {
								type="select",
								name=L["Data feed"],
								desc=L["Choose which data feed to show in the DataBroker view. This requires an LDB display addon, such as Titan Panel."],
								values=	function()
											local feeds = {}
											feeds[""] = L["None"]
											for name, func in pairs(Skada:GetFeeds()) do feeds[name] = name end
											return feeds
										end,
								get=function() return Skada.db.profile.feed end,
								set=function(self, feed)
											Skada.db.profile.feed = feed
											if feed ~= "" then Skada:SetFeed(Skada:GetFeeds()[feed]) end
										end,
								order=12,
							},

							setstokeep = {
								type="range",
								name=L["Data segments to keep"],
								desc=L["The number of fight segments to keep. Persistent segments are not included in this."],
								min=0,
								max=30,
								step=1,
								get=function() return Skada.db.profile.setstokeep end,
								set=function(self, val) Skada.db.profile.setstokeep = val end,
								order=13,
							},

							tenativecombatstart = {
							        type="toggle",
							        name=L["Aggressive combat detection"],
							        desc=L["Skada usually uses a very conservative (simple) combat detection scheme that works best in raids. With this option Skada attempts to emulate other damage meters. Useful for running dungeons. Meaningless on boss encounters."],
							        order=10,
							        get=function() return Skada.db.profile.tentativecombatstart end,
							        set=function() Skada.db.profile.tentativecombatstart = not Skada.db.profile.tentativecombatstart end,
							},

						}
	        		},

	        		columns = {
	        			type = "group",
	        			name = L["Columns"],
	        			order=4,
						args = {},
	        		}


	        }

}

