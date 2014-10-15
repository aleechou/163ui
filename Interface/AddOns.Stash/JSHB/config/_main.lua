--
--	JSHB Options - main panel
--

local L = _G.JSHB.L

function JSHB.Options:Panel_Main(ord)
	local DB = _G.JSHB.Options.DB
	return {
		order = ord,
		type = "group",
		name = L["General Settings"],
		args = {
			intro = {
				order = 2,
				type = "description",
				fontSize = "medium",
				name = L["JSHBMAIN_DESC"].."\n\n"..L["Official Support:"].." "..L["SORENSITE"].."\n\n"..JSHB.myVersionRaw.."\n\n",
				fontSize = "large",
			},
			spacer6 = { order = 6, type = "description", name = " ", desc = "", width = "full"},
			spacer10 = { order = 10, type = "description", name = " ", desc = "", width = "double"},
			framelock = {
				type = "execute",
				order = 16,
				name = L["Move Frames"],
				func = function(info) JSHB.ToggleMoversLock() end,
			},
			spacer18 = { order = 18, type = "description", name = " ", desc = "", width = "full"},
			masteraudio = {
				type = "toggle",
				order = 20,
				name = L["Master audio"],
				desc = L["MASTERAUDIO_DESC"],
				get = function(info) return DB[info[#info] ] end,
				set = function(info, value) DB[info[#info] ] = value end,
			},
			minimapbutton = {
				type = "toggle",
				order = 24,
				name = L["MINIMAP_BUTTON_SHOW"],
				width = "full",
				get = function(info) return DB[info[#info] ] end,
				set = function(info, value) DB[info[#info] ] = value; JSHB.SetMinimapButton( (value == true) and true or false) end,
			},					
		},
	}
end
