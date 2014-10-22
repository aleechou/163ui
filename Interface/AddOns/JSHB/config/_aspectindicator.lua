--
--	JSHB Options - Aspect/Stance indicator panel
--

if not tContains({ "HUNTER", "WARRIOR", "ROGUE" }, select(2, UnitClass("player") ) ) then return end

local L = _G.JSHB.L

local function MODULE_NAME(pc)
	if (pc == "HUNTER") then return L["Aspect Indicator"] end
	if (pc == "ROGUE") then return L["Poison Indicator"] end
	if (pc == "WARRIOR") then return L["Stance Indicator"] end
	return nil -- causes an error, like I want.
end

function JSHB.Options:Panel_AspectIndicator(ord)
	local DB = _G.JSHB.Options.DB
	return {
		order = ord,
		type = "group",
		name = MODULE_NAME(select(2, UnitClass("player") ) ),
		childGroups = "tab",
		args = {
			maintab = {
				type = "group",
				order = 1,
				name = MODULE_NAME(select(2, UnitClass("player") ) ),
				args = {
					aspect_enable = {
						type = "toggle",
						order = 2,
						name = L["Enable"],
						desc = "Ignore this. Use a WeakAura or something",
						width = "double",
						--get = function(info) return DB.indicators[info[#info] ] end,
						--set = function(info, value) DB.indicators[info[#info] ] = value;JSHB.Options:LockDown(JSHB.SetupAspectIndicatorModule) end,
						get = function(info) return false end,
						set = function(info, value) DB.indicators[info[#info] ] = false end,
						
					},
				
				},
			},
		},
	}
end
