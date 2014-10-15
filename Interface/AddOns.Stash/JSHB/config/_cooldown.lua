--
--	JSHB Options - cooldown panel
--

local L = _G.JSHB.L

function JSHB.Options:Panel_Cooldown(ord)
	local DB = _G.JSHB.Options.DB
	return {
		order = ord,
		type = "group",
		name = L["Cooldown Text"],
		args = {
			spacer1 = { order = 1, type = "description", name = " ", desc = "", width = "full"},
			font = {
				type = "select", 
				dialogControl = 'LSM30_Font_JS',
				order = 4,
				name = L["Font face"],
				values = AceGUIWidgetLSMlists.font,
				get = function(info) return DB.cooldowns.font[1] end,
				set = function(info, font) DB.cooldowns.font[1] = font end,
			},
			size = {
				type = "range", 
				order = 6,
				name = L["Font size"],
				min = 6, max = 40, step = 1,
				get = function(info) return (DB.cooldowns.font[2]) end,
				set = function(info, size) DB.cooldowns.font[2] = (size) end,
			},
			minfortenths = {
				type = "range", 
				order = 8,
				name = L["Timer decimals"],
				desc = L["MINFORTENTHS_DESC"],
				min = 1, max = 9, step = 1,
				get = function(info) return (DB[info[#info] ]) end,
				set = function(info, val) DB[info[#info] ] = (val) end,
			},
			flags = {
				type = "multiselect", 
				order = 10,
				name = L["Font flags"],
				values = JSHB.Options.fontFlagTable,
				get = function(info, key) return(tContains({strsplit(",", DB.cooldowns.font[3])}, key) and true or false) end,
				set = function(info, keyname, state) JSHB.Options:SetupFontFlags(DB.cooldowns.font, keyname, state) end,
			},
			fontshadowoffset = {
				type = "group",
				order = 12,
				name = L["Font shadow"],
				guiInline = true,
				args = {
					enableshadow = {
						type = "toggle",
						order = 2,
						name = L["Enable"],
						get = function(info) return DB.cooldowns[info[#info] ] end,
						set = function(info, value) DB.cooldowns[info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupTimersModule) end,
					},
					shadowcolor = {
						type = "color",
						order = 4,
						name = L["Color"],
						hasAlpha = true,
						disabled = function(info) return not DB.cooldowns.enableshadow end,
						get = function(info) return unpack(DB.cooldowns[info[#info] ]) end,
						set = function(info, r, g, b, a) DB.cooldowns[info[#info] ] = {r, g, b, a} end,
					},
					offsetX = {
						type = "input", 
						order = 6,
						name = L["X offset"],
						width = "half",
						pattern = "%d",
						usage = L["Only valid numeric offsets are allowed."],
						disabled = function(info) return not DB.cooldowns.enableshadow end,
						get = function(info) return tostring(DB.cooldowns.fontshadowoffset[1]) end,
						set = function(info, offset) DB.cooldowns.fontshadowoffset[1] = tonumber(offset) end,
					},
					offsetY = {
						type = "input", 
						order = 8,
						name = L["Y offset"],
						width = "half",
						pattern = "%d",
						usage = L["Only valid numeric offsets are allowed."],
						disabled = function(info) return not DB.cooldowns.enableshadow end,
						get = function(info) return tostring(DB.cooldowns.fontshadowoffset[2]) end,
						set = function(info, offset) DB.cooldowns.fontshadowoffset[2] = tonumber(offset) end,
					},
				},
			},
			colors = {
				type = "group",
				order = 16,
				name = L["Colors"],
				guiInline = true,
				get = function(info) return unpack(DB.cooldowns[info[#info] ]) end,
				set = function(info, r, g, b, a) DB.cooldowns[info[#info] ] = {r, g, b, a} end,
				args = {
					dayscolor = {
						type = "color",
						order = 1,
						name = L["Days"],
						hasAlpha = false,
					},
					hourscolor = {
						type = "color",
						order = 2,
						name = L["Hours"],
						hasAlpha = false,
					},
					minutescolor = {
						type = "color",
						order = 3,
						name = L["Minutes"],
						hasAlpha = false,
					},
					secondscolor = {
						type = "color",
						order = 4,
						name = L["Seconds"],
						hasAlpha = false,
					},
					expiringcolor = {
						type = "color",
						order = 5,
						name = L["Expiring"],
						hasAlpha = false,
					},
				},
			},
		},
	}
end
