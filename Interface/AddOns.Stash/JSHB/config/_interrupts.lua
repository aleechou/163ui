--
--	JSHB Options - interrupts panel
--

local L = _G.JSHB.L

function JSHB.Options:Panel_Interrupts(ord)
	local DB = _G.JSHB.Options.DB
	return {
		order = ord,
		type = "group",
		name = L["Interrupt Announce"],
		args = {
			spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full" },
			enable = {
				type = "toggle",
				order = 2,
				name = L["Enable"],
				width = "full",
				get = function(info) return DB.interrupts.enable end,
				set = function(info, value) JSHB.Options:CollapseAll(); DB.interrupts[info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupInterruptsModule) end,
			},
			spacer4 = { order = 4, type = "description", name = " ", desc = "", width = "full"--[[, hidden = function(info) return not DB.interrupts.enable end]] },
			solochan = {
				order = 6,
				type = "select",
				name = L["Solo"],
				desc = L["SOLOCHANNEL_DESC"],
				disabled = function(info) return not DB.interrupts.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.interrupts[info[#info] ]) end,
				set = function(info, value) DB.interrupts[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupInterruptsModule) end,
			},
			partychan = {
				order = 8,
				type = "select",
				name = L["In a party"],
				desc = L["PARTYCHANNEL_DESC"],
				disabled = function(info) return not DB.interrupts.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.interrupts[info[#info] ]) end,
				set = function(info, value) DB.interrupts[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupInterruptsModule) end,
			},
			raidchan = {
				order = 10,
				type = "select",
				name = L["In a raid"],
				desc = L["RAIDCHANNEL_DESC"],
				disabled = function(info) return not DB.interrupts.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.interrupts[info[#info] ]) end,
				set = function(info, value) DB.interrupts[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupInterruptsModule) end,
			},
			arenachan = {
				order = 12,
				type = "select",
				name = L["In an arena"],
				desc = L["ARENACHANNEL_DESC"],
				disabled = function(info) return not DB.interrupts.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.interrupts[info[#info] ]) end,
				set = function(info, value) DB.interrupts[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupInterruptsModule) end,
			},
			pvpchan = {
				order = 14,
				type = "select",
				name = L["In a PvP zone"],
				desc = L["PVPCHANNEL_DESC"],
				disabled = function(info) return not DB.interrupts.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.interrupts[info[#info] ]) end,
				set = function(info, value) DB.interrupts[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupInterruptsModule) end,
			},
		},
	}
end
