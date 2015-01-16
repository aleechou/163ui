
local AddonName, HubData = ...;
local LocalVars = TidyPlatesHubDefaults


-- CachedUnitDescription, CachedUnitGuild, GetLevelDescription

------------------------------------------------------------------
-- References
------------------------------------------------------------------
local GetAggroCondition = TidyPlatesWidgets.GetThreatCondition
local IsFriend = TidyPlatesUtility.IsFriend
local IsGuildmate = TidyPlatesUtility.IsGuildmate
local IsTankedByAnotherTank = HubData.Functions.IsTankedByAnotherTank
local IsTankingAuraActive = HubData.Functions.IsTankingAuraActive
local InCombatLockdown = InCombatLockdown
local GetFriendlyClass = HubData.Functions.GetFriendlyClass
local GetEnemyClass = HubData.Functions.GetEnemyClass
local StyleDelegate = TidyPlatesHubFunctions.SetStyleNamed
local ColorFunctionByHealth = HubData.Functions.ColorFunctionByHealth
local CachedUnitDescription = TidyPlatesUtility.CachedUnitDescription
local CachedUnitGuild = TidyPlatesUtility.CachedUnitGuild
local CachedUnitClass = TidyPlatesUtility.CachedUnitClass

local AddHubFunction = TidyPlatesHubHelpers.AddHubFunction

local function DummyFunction() end

-- Colors
local White = {r = 1, g = 1, b = 1}
local WhiteColor = { r = 250/255, g = 250/255, b = 250/255, }


------------------------------------------------------------------------------
-- Optional/Health Text
------------------------------------------------------------------------------


local function GetLevelDescription(unit)
	local description = ""
	description = "Level "..unit.level
	if unit.isElite then description = description.." (Elite)" end
	return description
end


local arenaUnitIDs = {"arena1", "arena2", "arena3", "arena4", "arena5"}

local function GetArenaIndex(unitname)
	-- Kinda hackish.  would be faster to cache the arena names using event handler.  later!
	if IsActiveBattlefieldArena() then
		local unitid, name
		for i = 1, #arenaUnitIDs do
			unitid = arenaUnitIDs[i]
			name = UnitName(unitid)
			if name and (name == unitname) then return i end
		end
	end
end


local function ShortenNumber(number)
	if GetLocale() == "zhCN" then
		if number > 100000000 then
			return (ceil((number/10000))/10000).." 亿"
		elseif number > 1000 then
			return (ceil((number/100))/100).." 万"
		else
			return number
		end
	else
		if number > 1000000 then
			return (ceil((number/10000))/100).." M"
		elseif number > 1000 then
			return (ceil((number/10))/100).." k"
		else
			return number
		end
	end
end

local function SepThousands(n)
	local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)')
	return left..(num:reverse():gsub('(%d%d%d)', '%1,'):reverse())..right
end


local function TextFunctionMana(unit)
	if unit.isTarget then
		local power = ceil((UnitPower("target") / UnitPowerMax("target"))*100)
		--local r, g, b = UnitPowerType("target")
		--local powername = getglobal(select(2, UnitPowerType("target")))
		--if power and power > 0 then	return power.."% "..powername end
		local powertype = select(2,UnitPowerType("target"))
		local powercolor = PowerBarColor[powertype]
		local powername = getglobal(powertype)
		---print(power, powertype, powercolor, powercolor.r, powercolor.g, powercolor.b)
		if power and power > 0 then return power.."% "..powername, powercolor.r, powercolor.g, powercolor.b, 1 end
	end
end

-- None
local function HealthFunctionNone() return "" end

-- Percent
local function TextHealthPercentColored(unit)
	local color = ColorFunctionByHealth(unit)
	return ceil(100*(unit.health/unit.healthmax)).."%", color.r, color.g, color.b, .7
end

local function HealthFunctionPercent(unit)
	if unit.health < unit.healthmax then
		return TextHealthPercentColored(unit)
	else return "" end
end

-- Actual
local function HealthFunctionExact(unit)
	return SepThousands(unit.health)
end
-- Approximate
local function HealthFunctionApprox(unit)
	return ShortenNumber(unit.health)
end
-- Approximate
local function HealthFunctionApproxAndPercent(unit)
	local color = ColorFunctionByHealth(unit)
	return HealthFunctionApprox(unit).."  ("..ceil(100*(unit.health/unit.healthmax)).."%)", color.r, color.g, color.b, .7
end
--Deficit
local function HealthFunctionDeficit(unit)
	local health, healthmax = unit.health, unit.healthmax
	if health ~= healthmax then return "-"..SepThousands(healthmax - health) end
end
-- Total and Percent
local function HealthFunctionTotal(unit)
	local color = ColorFunctionByHealth(unit)
	--local color = White
	local health, healthmax = unit.health, unit.healthmax
	return ShortenNumber(health).."|cffffffff ("..ceil(100*(health/healthmax)).."%)", color.r, color.g, color.b
end
-- TargetOf
local function HealthFunctionTargetOf(unit)
	if unit.isTarget then return UnitName("targettarget")
	elseif unit.isMouseover then return UnitName("mouseovertarget")
	else return "" end
end
-- Level
local function HealthFunctionLevel(unit)
	local level = unit.level
	if unit.isElite then level = level.." (Elite)" end
	return level, unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .9
end

-- Level and Health
local function HealthFunctionLevelHealth(unit)
	local level = unit.level
	if unit.isElite then level = level.."E" end
	return "("..level..") |cffffffff"..HealthFunctionApprox(unit), unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .9
	--return "|cffffffff"..HealthFunctionApprox(unit).."  |r"..level, unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .9
end


-- Arena Vitals (ID, Mana, Health
local function HealthFunctionArenaID(unit)
	local localid
	local powercolor = White
	local powerstring = ""
	local arenastring = ""
	local arenaindex = GetArenaIndex(unit.rawName)

	--arenaindex = 2	-- Tester
	if unit.type == "PLAYER" then

		if arenaindex and arenaindex > 0 then
			arenastring = "|cffffcc00["..(tostring(arenaindex)).."]  |r"
		end


		if unit.isTarget then localid = "target"
		elseif unit.isMouseover then localid = "mouseover"
		end


		if localid then
			local power = ceil((UnitPower(localid) / UnitPowerMax(localid))*100)
			local powerindex, powertype = UnitPowerType(localid)

			--local powername = getglobal(powertype)

			if power and power > 0 then
				powerstring = "  "..power.."%"		--..powername
				powercolor = PowerBarColor[powerindex] or White
			end
		end
	end

	local healthstring = "|cffffffff"..tostring(ceil(unit.health/1000)).."k|cff0088ff"

--[[
-- Test Strings
	powerstring = "  ".."43".."%"
	--arenastring = "|cffffcc00["..(tostring(2)).."]  |r"
	arenastring = "|cffffcc00#"..(tostring(2)).."  |r"
	powercolor = PowerBarColor[2]
--]]

	--	return '4'.."|r"..(powerstring or "")
	return arenastring..healthstring..powerstring, powercolor.r, powercolor.g, powercolor.b, 1

	--[[
	Arena ID, HealthFraction, ManaPercent
	#1  65%  75%

	Arena ID, HealthK, ManaFraction
	#2  300k  75%

	--]]
end


local HealthTextModesCustom = {}


--[[
local hexChars = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
}


local function intToHex(num)
	--local sig, sep
	--sig = fmod(num, 16)
	sep = num - sig*16
	return hexChars[sig]..hexChars[sep]
end

--]]


-- Custom
local function HealthFunctionCustom(unit)

	local LeftText, RightText, CenterText = "", "", ""

	--HealthTextModesCustom[LocalVars.StatusTextLeft]


	return LeftText, RightText, CenterText
	--if LocalVars.CustomHealthFunction then return LocalVars.CustomHealthFunction(unit) end

	--HealthTextModesCustom(mode, addColor)

	--[[
	FriendlyStatusTextMode
	FriendlyStatusTextModeCenter
	FriendlyStatusTextModeRight

	EnemyStatusTextMode
	EnemyStatusTextModeCenter
	EnemyStatusTextModeRight
	--]]


	--[[
	StatusTextLeft = 8,
	StatusTextCenter = 5,
	StatusTextRight = 7,

	StatusTextLeftColor = true,
	StatusTextCenterColor = true,
	StatusTextRightColor = true,

	--]]
end

local HealthTextModeFunctions = {}


TidyPlatesHubDefaults.FriendlyStatusTextMode = "HealthFunctionNone"
TidyPlatesHubDefaults.EnemyStatusTextMode = "HealthFunctionNone"

AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionNone, "None", "HealthFunctionNone")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionPercent, "Percent Health", "HealthFunctionPercent")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionExact, "Exact Health", "HealthFunctionExact")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionApprox, "Approximate Health", "HealthFunctionApprox")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionDeficit, "Health Deficit", "HealthFunctionDeficit")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionTotal, "Health Total & Percent", "HealthFunctionTotal")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionTargetOf, "Target Of", "HealthFunctionTargetOf")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionLevel, "Level", "HealthFunctionLevel")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionLevelHealth, "Level and Approx Health", "HealthFunctionLevelHealth")
AddHubFunction(HealthTextModeFunctions, TidyPlatesHubMenus.TextModes, HealthFunctionArenaID, "Arena ID, Health, and Power", "HealthFunctionArenaID")


local function HealthTextDelegate(unit)

	local func
	local mode = 1
	local showText = not (LocalVars.TextShowOnlyOnTargets or LocalVars.TextShowOnlyOnActive)

	if unit.reaction == "FRIENDLY" then mode = LocalVars.FriendlyStatusTextMode
	else mode = LocalVars.EnemyStatusTextMode end

	func = HealthTextModeFunctions[mode] or DummyFunction

	if LocalVars.TextShowOnlyOnTargets then
		if (unit.isTarget or unit.isMouseover or unit.isMarked) then showText = true end
	end

	if LocalVars.TextShowOnlyOnActive then
		if (unit.isMarked) or (unit.threatValue > 0) or (unit.health < unit.healthmax) then showText = true end
	end

	if showText then return func(unit) end
end



------------------------------------------------------------------------------------
-- Binary/Headline Text Styles
------------------------------------------------------------------------------------
local function RoleOrGuildText(unit)
	if unit.type == "NPC" then
		return (CachedUnitDescription(unit.name) or GetLevelDescription(unit) or "") , 1, 1, 1, .70
	end
end

-- Role, Guild or Level
local function TextRoleGuildLevel(unit)
	local description
	local r, g, b = 1,1,1

	if unit.type == "NPC" then
		description = CachedUnitDescription(unit.name)

		if not description then --  and unit.reaction ~= "FRIENDLY" then
			description =  GetLevelDescription(unit)
			r, g, b = unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue
		end

	elseif unit.type == "PLAYER" then
		description = CachedUnitGuild(unit.name)
		r, g, b = .5, .5, .7
	end

	return description, r, g, b, .70
end

-- Role or Guild
local function TextRoleGuild(unit)
	local description
	local r, g, b = 1,1,1

	if unit.type == "NPC" then
		description = CachedUnitDescription(unit.name)

	elseif unit.type == "PLAYER" then
		description = CachedUnitGuild(unit.name)
		r, g, b = .5, .5, .7
	end

	return description, r, g, b, .70
end

-- NPC Role
local function TextNPCRole(unit)
	if unit.type == "NPC" then
		return CachedUnitDescription(unit.name)
	end
end

-- Level
local function TextLevelColored(unit)
	--return GetLevelDescription(unit) , 1, 1, 1, .70
	return GetLevelDescription(unit) , unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .70
end

-- Guild, Role, Level, Health
function TextAll(unit)
	-- local color = ColorFunctionByHealth(unit) --6.0
	local color = White
	if unit.health < unit.healthmax then
		return ceil(100*(unit.health/unit.healthmax)).."%", color.r, color.g, color.b, .7
	else
		--return GetLevelDescription(unit) , unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .7
		return TextRoleGuildLevel(unit)
	end
end


local EnemyNameSubtextFunctions = {}
TidyPlatesHubMenus.EnemyNameSubtextModes = {}
TidyPlatesHubDefaults.HeadlineEnemySubtext = "RoleGuildLevel"
TidyPlatesHubDefaults.HeadlineFriendlySubtext = "RoleGuildLevel"
AddHubFunction(EnemyNameSubtextFunctions, TidyPlatesHubMenus.EnemyNameSubtextModes, DummyFunction, "None", "None")
AddHubFunction(EnemyNameSubtextFunctions, TidyPlatesHubMenus.EnemyNameSubtextModes, TextHealthPercentColored, "Percent Health", "PercentHealth")
AddHubFunction(EnemyNameSubtextFunctions, TidyPlatesHubMenus.EnemyNameSubtextModes, TextRoleGuildLevel, "Role, Guild or Level", "RoleGuildLevel")
AddHubFunction(EnemyNameSubtextFunctions, TidyPlatesHubMenus.EnemyNameSubtextModes, TextRoleGuild, "Role or Guild", "RoleGuild")
AddHubFunction(EnemyNameSubtextFunctions, TidyPlatesHubMenus.EnemyNameSubtextModes, TextNPCRole, "NPC Role", "Role")
AddHubFunction(EnemyNameSubtextFunctions, TidyPlatesHubMenus.EnemyNameSubtextModes, TextLevelColored, "Level", "Level")
AddHubFunction(EnemyNameSubtextFunctions, TidyPlatesHubMenus.EnemyNameSubtextModes, TextAll, "Role, Guild, Level or Health Percent", "RoleGuildLevelHealth")

--[[
local FriendlyNameSubtextFunctions = {}
TidyPlatesHubMenus.FriendlyNameSubtextModes = {}
TidyPlatesHubDefaults.HeadlineFriendlySubtext = "None"
AddHubFunction(FriendlyNameSubtextFunctions, TidyPlatesHubMenus.FriendlyNameSubtextModes, DummyFunction, "None", "None")
AddHubFunction(FriendlyNameSubtextFunctions, TidyPlatesHubMenus.FriendlyNameSubtextModes, TextHealthPercentColored, "Percent Health", "PercentHealth")
AddHubFunction(FriendlyNameSubtextFunctions, TidyPlatesHubMenus.FriendlyNameSubtextModes, TextRoleGuildLevel, "Role, Guild or Level", "RoleGuildLevel")
AddHubFunction(FriendlyNameSubtextFunctions, TidyPlatesHubMenus.FriendlyNameSubtextModes, TextRoleGuild, "Role or Guild", "RoleGuild")
AddHubFunction(FriendlyNameSubtextFunctions, TidyPlatesHubMenus.FriendlyNameSubtextModes, TextNPCRole, "NPC Role", "Role")
AddHubFunction(FriendlyNameSubtextFunctions, TidyPlatesHubMenus.FriendlyNameSubtextModes, TextLevelColored, "Level", "Level")
AddHubFunction(FriendlyNameSubtextFunctions, TidyPlatesHubMenus.FriendlyNameSubtextModes, TextAll, "Role, Guild, Level or Health Percent", "RoleGuildLevelHealth")
--]]

local function CustomTextBinaryDelegate(unit)
	--if unit.style == "NameOnly" then

	if StyleDelegate(unit) == "NameOnly" then
		local func
		if unit.reaction == "FRIENDLY" then
			func = EnemyNameSubtextFunctions[LocalVars.HeadlineFriendlySubtext or 0] or DummyFunction
		else
			func = EnemyNameSubtextFunctions[LocalVars.HeadlineEnemySubtext or 0] or DummyFunction
		end

		return func(unit)
	end
	return HealthTextDelegate(unit)
end



------------------------------------------------------------------------------
-- Local Variable
------------------------------------------------------------------------------

local function OnVariableChange(vars) LocalVars = vars end
HubData.RegisterCallback(OnVariableChange)


------------------------------------------------------------------------------
-- Add References
------------------------------------------------------------------------------



TidyPlatesHubFunctions.SetCustomText = HealthTextDelegate
TidyPlatesHubFunctions.SetCustomTextBinary = CustomTextBinaryDelegate

