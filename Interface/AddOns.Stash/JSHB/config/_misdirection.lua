--
--	JSHB Options - misdirection panel
--

if not tContains({ "HUNTER", "ROGUE" }, select(2, UnitClass("player") ) ) then return end

local L = _G.JSHB.L

function JSHB.Options:Panel_Misdirection(ord)
	local DB = _G.JSHB.Options.DB
	return {
		order = ord,
		type = "group",
		name = (select(2, UnitClass("player") ) == "HUNTER") and L["Misdirection"] or L["Tricks of the Trade"],
		args = {
			spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full" },
			enable = {
				type = "toggle",
				order = 2,
				name = L["Enable"],
				width = "full",
				get = function(info) return DB.misdirectionannounce.enable end,
				set = function(info, value) JSHB.Options:CollapseAll(); DB.misdirectionannounce.enable = value;JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			enablemdcastannounce = {
				order = 6,
				type = "toggle",
				name = L["Announce the cast"],
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			enablemdtransferannounce = {
				order = 8,
				type = "toggle",
				name = L["Whisper target when transferring"],
				width = "double",
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			enablemdoverannounce = {
				order = 10,
				type = "toggle",
				name = L["Announce expiration"],
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			enablemdmountwarn = {
				order = 12,
				type = "toggle",
				name = L["Whisper target if mounted"],
				width = "double",
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			spacer14 = { order = 14, type = "description", name = " ", desc = "", width = "full"--[[, hidden = function(info) return not DB.misdirectionannounce.enable end]] },
			solochan = {
				order = 16,
				type = "select",
				name = L["Solo"],
				desc = L["SOLOCHANNEL_DESC"],
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			partychan = {
				order = 18,
				type = "select",
				name = L["In a party"],
				desc = L["PARTYCHANNEL_DESC"],
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			raidchan = {
				order = 20,
				type = "select",
				name = L["In a raid"],
				desc = L["RAIDCHANNEL_DESC"],
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			arenachan = {
				order = 22,
				type = "select",
				name = L["In an arena"],
				desc = L["ARENACHANNEL_DESC"],
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
			pvpchan = {
				order = 24,
				type = "select",
				name = L["In a PvP zone"],
				desc = L["PVPCHANNEL_DESC"],
				disabled = function(info) return not DB.misdirectionannounce.enable end,
				style = "dropdown",
				values = function() return(JSHB.chatChannels) end,
				get = function(info) return(DB.misdirectionannounce[info[#info] ]) end,
				set = function(info, value) DB.misdirectionannounce[info[#info] ] = (value);JSHB.Options:LockDown(JSHB.SetupMisdirectionAnnounceModule) end,
			},
		},
	}
end
