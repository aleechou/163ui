
------------------------------------------------------------------------------------
-- Tidy Plates Hub
------------------------------------------------------------------------------------

--[[

Index:
	Colors
	Helper Functions
	Style
	Health Bar Color
	Warning Border Color
	Cast Bar Color
	Name Text Color
	Optional/Health Text
	Headline/Binary Text Styles

	Filter
	Scale
	Alpha

	Aura Widget
	Widget Creation
	Widget Activation
	Customization
	Function List
	Slash Commands


--]]

TidyPlatesHubFunctions = {}
local LocalVars = TidyPlatesHubDefaults
local InCombatLockdown = InCombatLockdown

local WidgetLib = TidyPlatesWidgets
local valueToString = TidyPlatesUtility.abbrevNumber
local EnableTankWatch = TidyPlatesWidgets.EnableTankWatch
local DisableTankWatch = TidyPlatesWidgets.DisableTankWatch
local EnableAggroWatch = TidyPlatesWidgets.EnableAggroWatch
local DisableAggroWatch = TidyPlatesWidgets.DisableAggroWatch

local GetAggroCondition = TidyPlatesWidgets.GetThreatCondition
local IsTotem = TidyPlatesUtility.IsTotem
local IsAuraShown = TidyPlatesWidgets.IsAuraShown
local IsHealer = TidyPlatesUtility.IsHealer
local InstanceStatus = TidyPlatesUtility.InstanceStatus

local CachedUnitDescription = TidyPlatesUtility.CachedUnitDescription
local CachedUnitGuild = TidyPlatesUtility.CachedUnitGuild
local CachedUnitClass = TidyPlatesUtility.CachedUnitClass
local IsFriend = TidyPlatesUtility.IsFriend
local IsGuildmate = TidyPlatesUtility.IsGuildmate

local isTanked = TidyPlatesWidgets.IsTankedByAnotherTank
local function IsTankedByAnotherTank(...)
	if LocalVars.ColorEnableOffTank and isTanked(...) then return true end
end

local CreateThreatLineWidget = WidgetLib.CreateThreatLineWidget
local CreateAuraWidget = WidgetLib.CreateAuraWidget
local CreateClassWidget = WidgetLib.CreateClassWidget
local CreateRangeWidget = WidgetLib.CreateRangeWidget
local CreateComboPointWidget = WidgetLib.CreateComboPointWidget
local CreateTotemIconWidget = WidgetLib.CreateTotemIconWidget

local function DummyFunction() return end

local MiniMobScale = .7

local ReactionColors = {
	["FRIENDLY"] = {
		["PLAYER"] = {r = 0, g = 0, b = 1,},
		["NPC"] = {r = 0, g = 1, b = 0,},
	},
	["HOSTILE"] = {
		["PLAYER"] = {r = 1, g = 0, b = 0,},
		["NPC"] = {r = 1, g = 0, b = 0,},
	},
	["NEUTRAL"] = {
		["NPC"] = {r = 1, g = 1, b = 0,},
	},
	["TAPPED"] = {
		--["NPC"] = {r = .53, g = .53, b = 1,},
		["NPC"] = {r = .45, g = .45, b = .45,},
	},
}

local NameReactionColors = {
	["FRIENDLY"] = {
		["PLAYER"] = {r = 60/255, g = 168/255, b = 255/255,},
		["NPC"] = {r = 96/255, g = 224/255, b = 37/255,},
	},
	["HOSTILE"] = {
		["PLAYER"] = {r = 255/255, g = 51/255, b = 32/255,},
		["NPC"] = {r = 255/255, g = 51/255, b = 32/255,},
	},
	["NEUTRAL"] = {
		["NPC"] = {r = 252/255, g = 180/255, b = 27/255,},
	},
	["TAPPED"] = {
		--["NPC"] = {r = .8, g = .8, b = 1,},
		["NPC"] = {r = .7, g = .7, b = .7,},
	},


}

local THREATMODE_AUTO = 1
local THREATMODE_TANK = 2
local THREATMODE_DPS  = 3

--local NormalGrey = {r = .5, g = .5, b = .5, a = .3}
--local EliteGrey = {r = .8, g = .7, b = .4, a = .5}
--local BossGrey = {r = .8, g = .6, b = .1, a = 1}

local NormalGrey = {r = .65, g = .65, b = .65, a = .4}
local EliteGrey = {r = .9, g = .7, b = .3, a = .5}
local BossGrey = {r = 1, g = .85, b = .1, a = .8}

-- Colors
local BlueColor = {r = 60/255, g =  168/255, b = 255/255, }
local GreenColor = { r = 96/255, g = 224/255, b = 37/255, }
local RedColor = { r = 255/255, g = 51/255, b = 32/255, }
local YellowColor = { r = 252/255, g = 220/255, b = 27/255, }
local GoldColor = { r = 252/255, g = 140/255, b = 0, }
local OrangeColor = { r = 255/255, g = 64/255, b = 0, }
local WhiteColor = { r = 250/255, g = 250/255, b = 250/255, }

local White = {r = 1, g = 1, b = 1}
local Black = {r = 0, g = 0, b = 0}

local RaidIconColors = {
	["STAR"] = {r = 251/255, g = 240/255, b = 85/255,},
	["MOON"] = {r = 100/255, g = 180/255, b = 255/255,},
	["CIRCLE"] = {r = 230/255, g = 116/255, b = 11/255,},
	["SQUARE"] = {r = 0, g = 174/255, b = 1,},
	["DIAMOND"] = {r = 207/255, g = 49/255, b = 225/255,},
	--["CROSS"] = {r = 195/255, g = 38/255, b = 23/255,},
	["CROSS"] = {r = 255/255, g = 130/255, b = 100/255,},
	["TRIANGLE"] = {r = 31/255, g = 194/255, b = 27/255,},
	["SKULL"] = {r = 244/255, g = 242/255, b = 240/255,},
}

--"By Reaction"
--local SkyBlue = {r = 0, g = .5, b = 1,}
--local BrightBlue = {r = 0, g = 120/255, b = 200/255,}
local BrightBlue =  {r = 0, g = 70/255, b = 240/255,} -- {r = 0, g = 75/255, b = 240/255,}
local BrightBlueText = {r = 112/255, g = 219/255, b = 255/255,}
local PaleBlue = {r = 0, g = 130/255, b = 225/255,}
local PaleBlueText = {r = 194/255, g = 253/255, b = 1,}
local DarkRed = {r = .9, g = 0.08, b = .08,}



local RaidClassColors = RAID_CLASS_COLORS

------------------------------------------------------------------------------------
-- Helper Functions
------------------------------------------------------------------------------------
local function GetCurrentSpec()
	if TidyPlatesUtility.GetSpec(false, false) == 2 then return "secondary"
	else return "primary" end
end

local function ShortenNumber(number)
	if number > 1000000 then
		return (ceil((number/10000))/100).." M"
	elseif number > 1000 then
		return (ceil((number/10))/100).." k"
	else
		return number
	end
end

local function GetLevelDescription(unit)
	local description = ""
	description = "Level "..unit.level
	if unit.isElite then description = description.." (Elite)" end
	return description
end

local function SepThousands(n)
	local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)')
	return left..(num:reverse():gsub('(%d%d%d)', '%1,'):reverse())..right
end

local function GetFriendlyClass(name)
	local class = TidyPlatesUtility.GroupMembers.Class[name]

	if (not IsInInstance()) and (not class) and LocalVars.AdvancedEnableUnitCache then
		class = CachedUnitClass(name) end
	return class
end

local function GetEnemyClass(name)
	if LocalVars.AdvancedEnableUnitCache then
			return CachedUnitClass(name) end
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

------------------------------------------------------------------------------------
-- Style
------------------------------------------------------------------------------------

local BARMODE, HEADLINEMODE = 1, 2

local StyleModeFunctions = {
	--	Full Bars and Widgets
	function(unit)
		return BARMODE
	end,
	-- NameOnly
	function(unit)
		return HEADLINEMODE
	end,
	-- Bars during combat
	function(unit)
		if InCombatLockdown() then
			return BARMODE
		else return HEADLINEMODE end
	end,
	-- Bars when unit is active or damaged
	function(unit)
		if (unit.health < unit.healthmax) or (unit.threatValue > 1) or unit.isInCombat or unit.isMarked then
			return BARMODE
		end
		return HEADLINEMODE
	end,
	-- elite units
	function(unit)
		if unit.isElite then
			return BARMODE
		else return HEADLINEMODE end
	end,
	-- marked
	function(unit)
		if unit.isMarked then
			return BARMODE
		else return HEADLINEMODE end
	end,
		-- player chars
	function(unit)

		if unit.type == "PLAYER" then
			return BARMODE
		else return HEADLINEMODE end
	end,

	--[[
		if TidyPlatesWidgets.IsTankingAuraActive then return AlphaFunctionByThreatLow(unit)	-- tank mode
	else return AlphaFunctionByThreatHigh(unit) end

	-- By Threat (High)
local function AlphaFunctionByThreatHigh (unit)
	if InCombatLockdown() and unit.reaction == "HOSTILE" then
		if unit.threatValue > 1 and unit.health > 0 then return LocalVars.OpacitySpotlight end
	elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then return LocalVars.OpacitySpotlight end
	end
end

-- Tank Mode
local function AlphaFunctionByThreatLow (unit)
	if InCombatLockdown() and unit.reaction == "HOSTILE" then
		if IsTankedByAnotherTank(unit) then return end
		if unit.threatValue < 2 and unit.health > 0 then return LocalVars.OpacitySpotlight end
	elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then return LocalVars.OpacitySpotlight end
	end
end
	--]]
	-- Current Target
	function(unit)
		if unit.isTarget == true then
			return BARMODE
		else return HEADLINEMODE end
	end,
	-- low threat
	function(unit)
		if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
			if IsTankedByAnotherTank(unit) then return HEADLINEMODE end
			if unit.threatValue < 2 and unit.health > 0 then return BARMODE end
		elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
			if GetAggroCondition(unit.rawName) == true then return BARMODE end
		end
		return HEADLINEMODE
	end,
}

local function StyleDelegate(unit)
	local func

	if unit.reaction == "FRIENDLY" then func = StyleModeFunctions[LocalVars.StyleFriendlyMode]
	else func = StyleModeFunctions[LocalVars.StyleEnemyMode] end

	return func(unit)
end


------------------------------------------------------------------------------------
-- Binary Plate Styles
------------------------------------------------------------------------------------

local function SetStyleBinaryDelegate(unit)
	if StyleDelegate(unit) == 2 then return "NameOnly"
	else return "Default" end
end







------------------------------------------------------------------------------
-- Health Bar Color
------------------------------------------------------------------------------
local tempColor = {}

-- By Low Health
local function ColorFunctionByHealth(unit)
	local health = unit.health/unit.healthmax
	if health > LocalVars.HighHealthThreshold then return LocalVars.ColorHighHealth
	elseif health > LocalVars.LowHealthThreshold then return LocalVars.ColorMediumHealth
	else return LocalVars.ColorLowHealth end
end

--"By Class"
local function ColorFunctionByClassEnemy(unit)
	local class

	if unit.type == "PLAYER" then
		-- Determine Unit Class
		if unit.reaction ~= "FRIENDLY" then class = unit.class or GetEnemyClass(unit.name) end

		-- Return Color
		if class and RaidClassColors[class] then
			return RaidClassColors[class] end
	end

	-- For unit types with no Class info available, the function returns nil (meaning, default reaction color)
end

local function ColorFunctionByClassFriendly(unit)
	local class

	if unit.type == "PLAYER" then
		-- Determine Unit Class
		if unit.reaction == "FRIENDLY" then class = GetFriendlyClass(unit.name)	end

		-- Return Color
		if class and RaidClassColors[class] then
			return RaidClassColors[class]
		end
	end

	-- For unit types with no Class info available, the function returns nil (meaning, default reaction color)
end

local function ColorFunctionBlack()
	return Black
end

--[[
unit.threatValue
	0 - Unit has less than 100% raw threat (default UI shows no indicator)
	1 - Unit has 100% or higher raw threat but isn't mobUnit's primary target (default UI shows yellow indicator)
	2 - Unit is mobUnit's primary target, and another unit has 100% or higher raw threat (default UI shows orange indicator)
	3 - Unit is mobUnit's primary target, and no other unit has 100% or higher raw threat (default UI shows red indicator)

	ColorAttackingMe		Warning
	ColorAggroTransition	Transition
	ColorAttackingOthers	Safe
--]]

local function ColorFunctionByReaction(unit)
	if unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
		if IsGuildmate(unit.name) then return LocalVars.ColorGuildMember
		elseif IsFriend(unit.name) then return LocalVars.ColorGuildMember end
	end

	return ReactionColors[unit.reaction][unit.type]
end

local function ColorFunctionDamage(unit)
	if unit.threatValue > 1 then return LocalVars.ColorAttackingMe				-- When player is unit's target		-- Warning
	elseif unit.threatValue == 1 then return LocalVars.ColorAggroTransition											-- Transition
	else return LocalVars.ColorAttackingOthers end																	-- Safe
end

local function ColorFunctionRawTank(unit)

	if unit.threatValue > 2 then
		return LocalVars.ColorAttackingMe							-- When player is solid target, ie. Safe
	else
		--if IsTankedByAnotherTank(unit) then return LocalVars.ColorAttackingOtherTank		-- When unit is tanked by another
		if unit.threatValue == 2 then return LocalVars.ColorAggroTransition				-- Transition
		else return LocalVars.ColorAttackingOthers end										-- Warning
	end
end

local function ColorFunctionTankSwapColors(unit)

	if unit.threatValue > 2 then
		return LocalVars.ColorAttackingOthers				-- When player is solid target		-- Safe
	else
		--if IsTankedByAnotherTank(unit) then return LocalVars.ColorAttackingOtherTank			-- When unit is tanked by another
		if unit.threatValue == 2 then return LocalVars.ColorAggroTransition					-- Transition
		else return LocalVars.ColorAttackingMe end												-- Warning
	end
end


local function ColorFunctionByThreat(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then

		if IsTankedByAnotherTank(unit) then return LocalVars.ColorAttackingOtherTank end

		if LocalVars.ThreatMode == THREATMODE_AUTO and TidyPlatesWidgets.IsTankingAuraActive then
			return ColorFunctionTankSwapColors(unit)
		elseif LocalVars.ThreatMode == THREATMODE_TANK then
			return ColorFunctionRawTank(unit)
		else return ColorFunctionDamage(unit) end

	else
		return RaidClassColors[unit.class or ""] or ReactionColors[unit.reaction][unit.type]
		--return ReactionColors[unit.reaction][unit.type]
	end

end


-- By Raid Icon
local function ColorFunctionByRaidIcon(unit)
	return RaidIconColors[unit.raidIcon]
end

-- By Level Color
local function ColorFunctionByLevelColor(unit)
	tempColor.r, tempColor.g, tempColor.b = unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue
	return tempColor
end

local FriendlyBarFunctions = {ColorFunctionByReaction, ColorFunctionByClassFriendly,
								ColorFunctionByHealth, DummyFunction}

local EnemyBarFunctions = {ColorFunctionByThreat, ColorFunctionByReaction,
								ColorFunctionByClassEnemy, ColorFunctionByHealth,
								DummyFunction}

local function HealthColorDelegate(unit)
	local color, class

	-- Group Member Aggro Coloring
	if unit.reaction == "FRIENDLY"  then
		if LocalVars.ColorShowPartyAggro and LocalVars.ColorPartyAggroBar then
			if GetAggroCondition(unit.rawName) then color = LocalVars.ColorPartyAggro end
		end
	end

	-- Color Mode / Color Spotlight
	if not color then
		local mode = 1
		local func

		if unit.reaction == "FRIENDLY" then
			func = FriendlyBarFunctions[LocalVars.ColorFriendlyBarMode] or DummyFunction
		else
			func = EnemyBarFunctions[LocalVars.ColorEnemyBarMode] or DummyFunction
		end

		--local func = ColorFunctions[mode] or DummyFunction
		color = func(unit)
	end

	if LocalVars.UnitSpotlightBarEnable and LocalVars.UnitSpotlightLookup[unit.name] then
		color = LocalVars.UnitSpotlightColor
	end

	if color then
		return color.r, color.g, color.b, 1	--, color.r/4, color.g/4, color.b/4, 1
	else return unit.red, unit.green, unit.blue end
end

------------------------------------------------------------------------------
-- Warning Border Color
------------------------------------------------------------------------------
local WarningColor = {}

-- Player Health (na)
local function WarningBorderFunctionByPlayerHealth(unit)
	local healthPct = UnitHealth("player")/UnitHealthMax("player")
	if healthPct < .3 then return DarkRed end
end

-- By Enemy Healer
local function WarningBorderFunctionByEnemyHealer(unit)
	if unit.reaction == "HOSTILE" and unit.type == "PLAYER" then
		--if TidyPlatesCache and TidyPlatesCache.HealerListByName[unit.rawName] then

		if IsHealer(unit.rawName) then
			return RaidClassColors[unit.class or ""] or ReactionColors[unit.reaction][unit.type]
		end
	end
end

-- "By Threat (High) Damage"
local function WarningBorderFunctionByThreatDamage(unit)
	if InCombatLockdown and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
		if unit.threatValue > 0 then
			return ColorFunctionDamage(unit)
		end
	end
end

-- "By Threat (Low) Tank"
local function WarningBorderFunctionByThreatTank(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
		if unit.threatValue < 3 then
			if IsTankedByAnotherTank(unit) then return else	return ColorFunctionRawTank(unit) end
		end
	end
end


-- Warning Glow (Auto Detect)
local function WarningBorderFunctionByThreat(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
		if (LocalVars.ThreatMode == THREATMODE_AUTO and TidyPlatesWidgets.IsTankingAuraActive)
			or LocalVars.ThreatMode == THREATMODE_TANK then
				if IsTankedByAnotherTank(unit) then return
				elseif unit.threatValue == 2 then return LocalVars.ColorAggroTransition
				elseif unit.threatValue < 2 then return LocalVars.ColorAttackingMe	end
		elseif unit.threatValue > 0 then return ColorFunctionDamage(unit) end
	else
		-- Add healer tracking
		return WarningBorderFunctionByEnemyHealer(unit)

	end
end


local WarningBorderFunctionsUniversal = { DummyFunction, WarningBorderFunctionByThreat,
			WarningBorderFunctionByEnemyHealer }

local function ThreatColorDelegate(unit)
	local color

	--LocalVars.ThreatGlowEnable

	-- Friendly Unit Aggro
	if LocalVars.ColorShowPartyAggro and LocalVars.ColorPartyAggroGlow and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then color = LocalVars.ColorPartyAggro end

	-- Enemy Units
	else

		-- NPCs
		if LocalVars.ThreatGlowEnable then
			color = WarningBorderFunctionByThreat(unit)
		end

		-- Players
		-- Check for Healer?  By Threat already does this.
	end

	if LocalVars.UnitSpotlightGlowEnable and LocalVars.UnitSpotlightLookup[unit.name] then
		color = LocalVars.UnitSpotlightColor
	end

	if color then return color.r, color.g, color.b, 1
	else return 0, 0, 0, 0 end
end


------------------------------------------------------------------------------
-- Cast Bar Color
------------------------------------------------------------------------------
local function CastBarDelegate(unit)
	local color, alpha
	if unit.spellInterruptible then
		color = LocalVars.ColorNormalSpellCast
	else color = LocalVars.ColorUnIntpellCast end


	if unit.reaction == "FRIENDLY" and (not LocalVars.SpellCastEnableFriendly) then
		alpha = 0
	else alpha = 1 end

	--[[
	if unit.reaction ~= "FRIENDLY" or LocalVars.SpellCastEnableFriendly then alpha = 1
	else alpha = 0 end
	--]]


	return color.r, color.g, color.b, alpha
end



------------------------------------------------------------------------------
-- Name Text Color
------------------------------------------------------------------------------

-- By Reaction
local function NameColorByReaction(unit)
	if IsGuildmate(unit.name) then return LocalVars.TextColorGuildMember
	elseif IsFriend(unit.name) then return LocalVars.TextColorGuildMember end

	return NameReactionColors[unit.reaction][unit.type]
end

-- By Significance
local function NameColorBySignificance(unit)
	-- [[
	if unit.reaction ~= "FRIENDLY" then
		if unit.isTarget then return White
		elseif unit.isBoss or unit.isMarked then return BossGrey
		elseif unit.isElite or (unit.levelcolorRed > .9 and unit.levelcolorGreen < .9) then return EliteGrey
		else return NormalGrey end
	else
		return NameColorByReaction(unit)
	end
	--]]
	--[[
	if unit.reaction == "FRIENDLY" then return White
	elseif unit.isBoss or unit.isMarked then return BossGrey
	elseif unit.isElite or (unit.levelcolorRed > .9 and unit.levelcolorGreen < .9) then return EliteGrey
	else return NormalGrey end
	--]]
end

local function NameColorByClass(unit)
	local class, color

	if unit.type == "PLAYER" then
		-- Determine Unit Class
		if unit.reaction == "FRIENDLY" then class = GetFriendlyClass(unit.name)
		else class = unit.class or GetEnemyClass(unit.name); end

		-- Return color
		if class and RaidClassColors[class] then
			return RaidClassColors[class] end
	end

	-- For unit types with no Class info available, return reaction color
	return NameReactionColors[unit.reaction][unit.type]
end


local function NameColorByFriendlyClass(unit)
	local class, color

	if unit.type == "PLAYER" and unit.reaction == "FRIENDLY" then
		-- Determine Unit Class
		class = GetFriendlyClass(unit.name)
		--print(unit.name, class)

		-- Return color
		if class and RaidClassColors[class] then
			return RaidClassColors[class] end
	end

	-- For unit types with no Class info available, return reaction color
	return NameReactionColors[unit.reaction][unit.type]
end



local function NameColorByEnemyClass(unit)
	local class, color

	if unit.type == "PLAYER" and unit.reaction == "HOSTILE" then
		class = unit.class or GetEnemyClass(unit.name)

		-- Return color
		if class and RaidClassColors[class] then
			return RaidClassColors[class] end
	end

	-- For unit types with no Class info available, return reaction color
	return NameReactionColors[unit.reaction][unit.type]
end

local function NameColorByClass(unit)
	if unit.reaction == "HOSTILE" then
		return NameColorByEnemyClass(unit)
	else
		return NameColorByFriendlyClass(unit)
	end
end

local function NameColorByThreat(unit)
	if InCombatLockdown() then return ColorFunctionByThreat(unit)
	else return RaidClassColors[unit.class or ""] or NameReactionColors[unit.reaction][unit.type] end
end

local SemiWhite = {r=1, g=1, b=1, a=.8}
local SemiWhiter = {r=1, g=1, b=1, a=.9}
local SemiYellow = {r=1, g=1, b=.8, a=1}
-- GoldColor, YellowColor
local function NameColorDefault(unit)
	if unit.isTarget then return White
	elseif unit.isMouseover then return SemiWhiter
	else return SemiWhite end
end

local NameColorFunctions = {
	-- Default
	NameColorDefault,
	-- By Class
	NameColorByClass,
	--NameColorByClass,
	-- By Threat
	NameColorByThreat,
	-- By Reaction
	NameColorByReaction,
	-- By Health
	ColorFunctionByHealth,
	-- By Level Color
	ColorFunctionByLevelColor,
	-- By Significance
	NameColorBySignificance,
}

local function SetNameColorDelegate(unit)
	local color, colorMode

	if unit.reaction == "FRIENDLY" then
		-- Party Aggro Coloring -- Overrides the normal coloring
		if LocalVars.ColorShowPartyAggro and LocalVars.ColorPartyAggroText then
			if GetAggroCondition(unit.rawName) then color = LocalVars.ColorPartyAggro end
		end
	end

	if not color then
		if StyleDelegate(unit) == 2 then

			if unit.reaction == "FRIENDLY" then
				colorMode = tonumber(LocalVars.HeadlineFriendlyColor)
			else
				colorMode = tonumber(LocalVars.HeadlineEnemyColor)
			end

		else
			--colorMode = tonumber(LocalVars.TextNameColorMode)
			if unit.reaction == "FRIENDLY" then colorMode = LocalVars.ColorFriendlyNameMode
			else colorMode = LocalVars.ColorEnemyNameMode
			end

		end

		local func = NameColorFunctions[colorMode or 1] or DummyFunction
		color = func(unit)
	end

	if color then
		--if unit.guid == nil then return (color.r+.1)/2, (color.g+.1)/2, (color.b+.1)/2, (color.a or 1) end
		return color.r, color.g, color.b , (color.a or 1)
	else return .2, .2, .2, 1 end
end

------------------------------------------------------------------------------
-- Optional/Health Text
------------------------------------------------------------------------------

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
-- Custom
local function HealthFunctionCustom(unit)
	if LocalVars.CustomHealthFunction then return LocalVars.CustomHealthFunction(unit) end
end
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
--Deficit
local function HealthFunctionDeficit(unit)
	local health, healthmax = unit.health, unit.healthmax
	if health ~= healthmax then return "-"..SepThousands(healthmax - health) end
end
-- Total and Percent
local function HealthFunctionTotal(unit)
	local color = ColorFunctionByHealth(unit)
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
	return level, unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .70
end

-- Level and Health
local function HealthFunctionLevelHealth(unit)
	local level = unit.level
	if unit.isElite then level = level.."E" end
	return level.."  |cffffffff"..HealthFunctionApprox(unit), unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .70
end

-- Arena Vitals (ID, Mana, Health
local function HealthFunctionArenaID(unit)
	local localid
	local powercolor = WhiteColor
	local powerstring = ""
	local arenastring = ""
	local arenaindex = GetArenaIndex(unit.rawName)

	--arenaindex = 2	-- Tester
	if unit.type == "PLAYER" then
		if arenaindex and arenaindex > 0 then
			arenastring = "|cffffcc00["..(tostring(arenaindex)).."]  |r"
		end


		if unit.isTarget then localid = "target"
		elseif unit.isMouseover then localid = "mouseover" end


		if localid then
			local power = ceil((UnitPower(localid) / UnitPowerMax(localid))*100)
			local powerindex, powertype = UnitPowerType(localid)

			--local powername = getglobal(powertype)


			if power and power > 0 then
				powerstring = "  "..power.."%"		--..powername
				powercolor = PowerBarColor[powerindex] or WhiteColor
			end
		end
	end

	local healthstring = "|cffffffff"..tostring(ceil(unit.health/1000)).."k|cff0088ff"

	--	return '4'.."|r"..(powerstring or "")
	return arenastring..healthstring..powerstring, powercolor.r, powercolor.g, powercolor.b, 1

	--[[
	Arena ID, HealthFraction, ManaPercent
	#1  65%  75%

	Arena ID, HealthK, ManaFraction
	#2  300k  75%

	--]]
end



local HealthTextModeFunctions = {
	HealthFunctionNone,
	HealthFunctionPercent,
	HealthFunctionExact,
	HealthFunctionDeficit,
	HealthFunctionTotal,
	HealthFunctionTargetOf,
	HealthFunctionApprox,
	HealthFunctionLevel,
	HealthFunctionLevelHealth,
	-- -- TextFunctionMana,
	HealthFunctionArenaID,
	--HealthFunctionCustom,
}

local function HealthTextDelegate(unit)

	local mode = 1
	if unit.reaction == "FRIENDLY" then mode = LocalVars.ColorFriendlyStatusTextMode
	else mode = LocalVars.ColorEnemyStatusTextMode end

	local func = HealthTextModeFunctions[mode] or DummyFunction
	if LocalVars.TextShowOnlyOnTargets and not (unit.isTarget or unit.isMouseover) then return end -- or unit.isMouseover
	return func(unit)
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

		if not description and unit.reaction ~= "FRIENDLY" then
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
	local color = ColorFunctionByHealth(unit)
	if unit.health < unit.healthmax then
		return ceil(100*(unit.health/unit.healthmax)).."%", color.r, color.g, color.b, .7
	else
		--return GetLevelDescription(unit) , unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue, .7
		return TextRoleGuildLevel(unit)
	end
end



local TextPlateFieldFunctions = {
	-- None
	DummyFunction,
	-- Health Text
	TextHealthPercentColored,
	-- Role, Guild or Level
	TextRoleGuildLevel,
	-- Role or Guild
	TextRoleGuild,
	-- NPC Role
	TextNPCRole,
	-- Level
	TextLevelColored,
	-- Level or Health
	TextAll,
}


local function CustomTextBinaryDelegate(unit)
	--if unit.style == "NameOnly" then
	if StyleDelegate(unit) == 2 then
		local func = TextPlateFieldFunctions[LocalVars.TextPlateFieldMode] or DummyFunction
		return func(unit)
	end
	return HealthTextDelegate(unit)
end

------------------------------------------------------------------------------
-- Filter
------------------------------------------------------------------------------
local function UnitFilter(unit)
	if LocalVars.OpacityFilterLookup[unit.name] then return true
	elseif LocalVars.OpacityFilterNeutralUnits and unit.reaction == "NEUTRAL" then return true
	elseif LocalVars.OpacityFilterFriendlyNPC and unit.type == "NPC" and unit.reaction == "FRIENDLY" then return true
	elseif LocalVars.OpacityFilterNPC and unit.type == "NPC" then return true
	elseif LocalVars.OpacityFilterPlayers and unit.type == "PLAYER" then return true
	elseif LocalVars.OpacityFilterMini and unit.isTrivial then return true

	elseif LocalVars.OpacityFilterNonElite and (not unit.isElite) then return true
	elseif LocalVars.OpacityFilterInactive then
		if unit.reaction ~= "FRIENDLY" and not (unit.isMarked or unit.isInCombat or unit.threatValue > 0 or unit.health < unit.healthmax) then return true end
	end
end

------------------------------------------------------------------------------
-- Scale
------------------------------------------------------------------------------

-- By Low Health
local function ScaleFunctionByLowHealth(unit)
	if unit.health/unit.healthmax < LocalVars.LowHealthThreshold then return LocalVars.ScaleSpotlight end
end

-- By Elite
local function ScaleFunctionByElite(unit)
	if unit.isElite then return LocalVars.ScaleSpotlight end
end

-- By Target
local function ScaleFunctionByTarget(unit)
	if unit.isTarget then return LocalVars.ScaleSpotlight end
end

-- By Threat (High) DPS Mode
local function ScaleFunctionByThreatHigh(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
		if unit.type == "NPC" and unit.threatValue > 1 and unit.health > 2 then return LocalVars.ScaleSpotlight end
	elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then return LocalVars.ScaleSpotlight end
	end
end

-- By Threat (Low) Tank Mode
local function ScaleFunctionByThreatLow(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
		if  IsTankedByAnotherTank(unit) then return end
		if unit.type == "NPC" and unit.health > 2 and unit.threatValue < 2 then return LocalVars.ScaleSpotlight end
	elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then return LocalVars.ScaleSpotlight end
	end
end

-- By Debuff Widget
local function ScaleFunctionByActiveDebuffs(unit, frame)
	local widget = unit.frame.widgets.DebuffWidget
	--local widget = TidyPlatesWidgets.GetAuraWidgetByGUID(unit.guid)
	if IsAuraShown(widget) then return LocalVars.ScaleSpotlight end
end

-- By Enemy
local function ScaleFunctionByEnemy(unit)
	if unit.reaction ~= "FRIENDLY" then return LocalVars.ScaleSpotlight end
end

-- By NPC
local function ScaleFunctionByNPC(unit)
	if unit.type == "NPC" then return LocalVars.ScaleSpotlight end
end

-- By Raid Icon
local function ScaleFunctionByRaidIcon(unit)
	if unit.isMarked then return LocalVars.ScaleSpotlight end
end

-- By Enemy Healer
local function ScaleFunctionByEnemyHealer(unit)
	if unit.reaction == "HOSTILE" and unit.type == "PLAYER" then
		--if TidyPlatesCache and TidyPlatesCache.HealerListByName[unit.rawName] then
		if IsHealer(unit.rawName) then
			return LocalVars.ScaleSpotlight
		end
	end
end

-- By Boss
local function ScaleFunctionByBoss(unit)
	if unit.isBoss and unit.isElite then return LocalVars.ScaleSpotlight end
end

-- By Threat (Auto Detect)
local function ScaleFunctionByThreat(unit)
		if (LocalVars.ThreatMode == THREATMODE_AUTO and TidyPlatesWidgets.IsTankingAuraActive)
			or LocalVars.ThreatMode == THREATMODE_TANK then
				return ScaleFunctionByThreatLow(unit)	-- tank mode
		else return ScaleFunctionByThreatHigh(unit) end

end

-- Function List
--local ScaleFunctionsDamage = { DummyFunction, ScaleFunctionByElite, ScaleFunctionByTarget, ScaleFunctionByThreatHigh, ScaleFunctionByActiveDebuffs, ScaleFunctionByEnemy,ScaleFunctionByNPC, ScaleFunctionByRaidIcon, ScaleFunctionByEnemyHealer, ScaleFunctionByThreatAutoDetect}

--local ScaleFunctionsTank = { DummyFunction, ScaleFunctionByElite, ScaleFunctionByTarget, ScaleFunctionByThreatLow, ScaleFunctionByActiveDebuffs, ScaleFunctionByEnemy, ScaleFunctionByNPC, ScaleFunctionByRaidIcon, ScaleFunctionByThreatAutoDetect}

local ScaleFunctionsUniversal = { DummyFunction, ScaleFunctionByElite, ScaleFunctionByTarget,
		ScaleFunctionByThreat,
		ScaleFunctionByActiveDebuffs, ScaleFunctionByEnemy,ScaleFunctionByNPC, ScaleFunctionByRaidIcon,
		ScaleFunctionByEnemyHealer, ScaleFunctionByLowHealth, ScaleFunctionByBoss}


-- Scale Functions Listed by Role order: Damage, Tank, Heal
-- local ScaleFunctions = {ScaleFunctionsDamage, ScaleFunctionsTank}

local function ScaleDelegate(...)
	local unit = ...
	local scale

	if LocalVars.UnitSpotlightScaleEnable and LocalVars.UnitSpotlightLookup[unit.name] then
		return LocalVars.UnitSpotlightScale
	end

	if LocalVars.ScaleIgnoreNonEliteUnits and (not unit.isElite) then
	elseif LocalVars.ScaleIgnoreNeutralUnits and unit.reaction == "NEUTRAL" then
	elseif LocalVars.ScaleIgnoreInactive and not (unit.reaction == "FRIENDLY" and (unit.isInCombat or (unit.threatValue > 0) or (unit.health < unit.healthmax))) then
	elseif LocalVars.ScaleCastingSpotlight and unit.isCasting then scale = LocalVars.ScaleSpotlight
	elseif LocalVars.ScaleMiniMobs and unit.isMini then
		scale = MiniMobScale
	else
		-- Filter
		if (LocalVars.FilterScaleLock or (not unit.isTarget)) and UnitFilter(unit) then scale = LocalVars.ScaleFiltered
		else
			local func = ScaleFunctionsUniversal[LocalVars.ScaleSpotlightMode] or DummyFunction
			scale = func(...)
		end
	end

	return scale or LocalVars.ScaleStandard
end


------------------------------------------------------------------------------
-- Opacity / Alpha
------------------------------------------------------------------------------

-- By Low Health
local function AlphaFunctionByLowHealth(unit)
	if unit.health/unit.healthmax < LocalVars.LowHealthThreshold then return LocalVars.OpacitySpotlight end
end

-- By Threat (High)
local function AlphaFunctionByThreatHigh (unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
		if unit.threatValue > 1 and unit.health > 0 then return LocalVars.OpacitySpotlight end
	elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then return LocalVars.OpacitySpotlight end
	end
end

-- Tank Mode
local function AlphaFunctionByThreatLow (unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
		if  IsTankedByAnotherTank(unit) then return end
		if unit.threatValue < 2 and unit.health > 0 then return LocalVars.OpacitySpotlight end
	elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then return LocalVars.OpacitySpotlight end
	end
end

local function AlphaFunctionByMouseover(unit)
	if unit.isMouseover then return LocalVars.OpacitySpotlight end
end

local function AlphaFunctionByEnemy(unit)
	if unit.reaction ~= "FRIENDLY" then return LocalVars.OpacitySpotlight end
end

local function AlphaFunctionByNPC(unit)
	if unit.type == "NPC" then return LocalVars.OpacitySpotlight end
end

local function AlphaFunctionByRaidIcon(unit)
	if unit.isMarked then return LocalVars.OpacitySpotlight end
end

local function AlphaFunctionByActive(unit)
	if (unit.health < unit.healthmax) or (unit.threatValue > 1) or unit.isInCombat or unit.isMarked then return LocalVars.OpacitySpotlight end
end

local function AlphaFunctionByActiveDebuffs(unit)
	local widget = unit.frame.widgets.DebuffWidget
	--local widget = TidyPlatesWidgets.GetAuraWidgetByGUID(unit.guid)
	if IsAuraShown(widget) then return LocalVars.OpacitySpotlight end
end

-- By Enemy Healer
local function AlphaFunctionByEnemyHealer(unit)
	if unit.reaction == "HOSTILE" and unit.type == "PLAYER" then
		--if TidyPlatesCache and TidyPlatesCache.HealerListByName[unit.rawName] then
		if IsHealer(unit.rawName) then
			return LocalVars.OpacitySpotlight
		end
	end
end

-- By Threat (Auto Detect)
local function AlphaFunctionByThreat(unit)
		if (LocalVars.ThreatMode == THREATMODE_AUTO and TidyPlatesWidgets.IsTankingAuraActive)
			or LocalVars.ThreatMode == THREATMODE_TANK then
				return AlphaFunctionByThreatLow(unit)	-- tank mode
		else return AlphaFunctionByThreatHigh(unit) end
end

local AlphaFunctionsUniversal = { DummyFunction, AlphaFunctionByThreat, AlphaFunctionByActiveDebuffs,
	AlphaFunctionByEnemy, AlphaFunctionByNPC, AlphaFunctionByRaidIcon, AlphaFunctionByActive,
	AlphaFunctionByEnemyHealer, AlphaFunctionByLowHealth}

-- Alpha Functions Listed by Role order: Damage, Tank, Heal
local AlphaFunctions = {AlphaFunctionsDamage, AlphaFunctionsTank}

local function Diminish(num)
	if num == 1 then return 1
	elseif num < .3 then return num*.60
	elseif num < .6 then return num*.70
	else return num * .80 end
end

local function AlphaDelegate(...)
	local unit = ...
	local alpha

	if LocalVars.UnitSpotlightOpacityEnable and LocalVars.UnitSpotlightLookup[unit.name] then
		return LocalVars.UnitSpotlightOpacity
	end

	if unit.isTarget then return Diminish(LocalVars.OpacityTarget)
	elseif unit.isCasting and LocalVars.OpacityFullSpell then return Diminish(LocalVars.OpacityTarget)
	elseif unit.isMouseover and LocalVars.OpacityFullMouseover then return Diminish(LocalVars.OpacityTarget)
	else
		-- Filter
		if UnitFilter(unit) then alpha = LocalVars.OpacityFiltered
		-- Spotlight
		else
			local func = AlphaFunctionsUniversal[LocalVars.OpacitySpotlightMode] or DummyFunction
			alpha = func(...)
		end
	end


	if alpha then return Diminish(alpha)
	else
		if (not UnitExists("target")) and LocalVars.OpacityFullNoTarget then return Diminish(LocalVars.OpacityTarget)
		else return Diminish(LocalVars.OpacityNonTarget) end
	end
end

------------------------------------------------------------------
-- Experimental Style Delegate
------------------------------------------------------------------

local function IsThereText(unit)
	local text = CustomTextBinaryDelegate(unit)
	if text and text ~= "" then return true end
end

local function SetStyleTrinaryDelegate(unit)
	local style = StyleDelegate(unit)
	local widget = unit.frame.widgets.DebuffWidget

	if style == 2 then
		if IsThereText(unit) then
			return "NameOnly"
		else
			return "NameOnly-NoDescription"
		end
	elseif IsAuraShown(widget) then
		return "Default"
	else
		return "Default-NoAura"
	end
end


------------------------------------------------------------------------------
-- Aura Widget
------------------------------------------------------------------------------
TidyPlatesHubPrefixList = {
	-- ALL
	["ALL"] = 1,
	["All"] = 1,
	["all"] = 1,

	-- MY
	["MY"] = 2,
	["My"] = 2,
	["my"] = 2,

	-- OTHER
	["OTHER"] = 3,
	["Other"] = 3,
	["other"] = 3,

	-- CC
	["CC"] = 4,
	["cc"] = 4,
	["Cc"] = 4,
}

--[[
* Debuffs are color coded, with poison debuffs having a green border,
magic debuffs a blue border, physical debuffs a red border, diseases a
brown border, and curses a purple border

Information from Widget:
aura.spellid, aura.name, aura.expiration, aura.stacks,
aura.caster, aura.duration, aura.texture,
aura.type, aura.reaction
--]]

local AURA_TYPE_DEBUFF = 6
local AURA_TYPE_BUFF = 1

local AURA_TARGET_HOSTILE = 1
local AURA_TARGET_FRIENDLY = 2

local AURA_TYPE = { "Buff", "Curse", "Disease", "Magic", "Poison", "Debuff", }
local AURA_TYPE_COLORS = { nil, {1,0,1}, {.5, .2, 0}, {0,.4,1}, {0,1,0}, nil, }

--[[
local AURA_TYPE_ALTS = {
	{"BUFF", "Buff", "Buffs"},
	{"CURSE", "Curse", },
	{"DISEASE", "Disease", },
	{"MAGIC", "Magic",},
	{"POISON", "Poison",},
	{"DEBUFF", "Debuff", "Debuffs"},
}

local function PrefixLookupByType(auratype)
	local names = AURA_TYPE_ALTS[auratype]
	local prefix
	for i = 1, #names do
		prefix = LocalVars.WidgetsDebuffLookup[ (names[i]) ]
		if prefix then return prefix end
	end
end


local function PriorityLookupByType(auratype)
	return LocalVars.WidgetsDebuffPriority[ (AURA_TYPE[auratype]) ] or LocalVars.WidgetsDebuffPriority[ (AURA_TYPE_CAPS[auratype]) ]
end
--]]

local function GetPrefixPriority(aura)
	local spellid = tostring(aura.spellid)
	local name = aura.name
	-- Lookup using the Prefix & Priority Lists
	local prefix = LocalVars.WidgetsDebuffLookup[spellid] or LocalVars.WidgetsDebuffLookup[name]
	local priority = LocalVars.WidgetsDebuffPriority[spellid] or LocalVars.WidgetsDebuffPriority[name]

	return prefix, priority
end

local function GetAuraColor(aura)
	local color = AURA_TYPE_COLORS[aura.type]
	if color then return unpack(color) end
end

local DebuffPrefixModes = {
	-- All
	function(aura)
		return true
	end,
	-- My
	function(aura)
		if aura.caster == UnitGUID("player") then return true end
	end,
	-- Other
	function(aura)
		if aura.caster ~= UnitGUID("player") then return true end
	end,
	-- CC
	function(aura)
		--return true, .5, .4, 0
		return true, 1, 1, 0
	end,
}

local DebuffFilterModes = {
	-- My Debuffs
	function(aura)
		if aura.caster == UnitGUID("player") and aura.type ~= AURA_TYPE_BUFF then return true, 20 end
	end,
	-- My Buffs
	function(aura)
		if aura.caster == UnitGUID("player") and aura.type == AURA_TYPE_BUFF and aura.duration < 120 then return true, 20 end
	end,
	-- By Prefix
	function(aura)
		local prefix, priority = GetPrefixPriority(aura)
		if prefix then
			local show, r, g, b = DebuffPrefixModes[prefix](aura)
			return show, priority + 20, r, g, b
		end

	end,
}

--[[
Auras 3.0

	My Debuffs
	My Buffs
	Smart Search
	Custom

	Smart Search

	My Debuffs + Any buffs added to the list, or blacklisted
	My Buffs + Any debuffs added to the list, or blacklisted
	Smart Search = Debuffs on Enemies, Buffs on Friendlies, + List


Auras 4.0

	CC Database
	Cooldown Counter
	Ability Counter







--]]


local DispelTypeHandlers = {
	-- Curse
	["Curse"] = function()
		return LocalVars.WidgetAuraTrackCurse
	end,
	-- Disease
	["Disease"] = function()
		return LocalVars.WidgetAuraTrackDisease
	end,
	-- Magic
	["Magic"] = function()
		return LocalVars.WidgetAuraTrackMagic
	end,
	-- Poison
	["Poison"] = function()
		return LocalVars.WidgetAuraTrackPoison
	end,
	}

local function TrackDispelType(auratype)
	if auratype then
		local handlerfunction = DispelTypeHandlers[auratype]
		if handlerfunction then return handlerfunction() end
	end
end

local function DebuffFilter(aura)
	if LocalVars.WidgetAuraTrackDispelFriendly and aura.reaction == AURA_TARGET_FRIENDLY then
		--if (aura.type ~= 1)  then print("Debuff Filter", aura.name, aura.type) end
		if TrackDispelType(AURA_TYPE[aura.type]) then
		local r, g, b = GetAuraColor(aura)
		return true, 10, r, g, b end
	end

	-- Filter Mode
	local func = DebuffFilterModes[LocalVars.WidgetsAuraMode] or DummyFunction
	return func(aura)
end



local function Prefilter(spellid, spellname, auratype, auratargetreaction)
	-- Store debuffs on friendly units.
	if (auratargetreaction == AURA_TARGET_FRIENDLY) and (AURA_TYPE[auratype] ~= AURA_TYPE_BUFF) then return true end
	-- Store auras marked in lookup
	return ((LocalVars.WidgetsDebuffLookup[tostring(spellid)] or LocalVars.WidgetsDebuffLookup[spellname]) ~= nil)
end



---------------------------------------------------------------------------------------------------------
-- Widget Initializers
---------------------------------------------------------------------------------------------------------


local function AddClassIcon(plate, enable, config)
	if enable then
		if not plate.widgets.ClassIcon then
			local widget
			widget = CreateClassWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) -- 0, 3)
			--widget:SetScale(1.2)
			plate.widgets.ClassIcon = widget
		end
	elseif plate.widgets.ClassIcon then
		plate.widgets.ClassIcon:Hide()
		plate.widgets.ClassIcon = nil
	end
end

local function AddTotemIcon(plate, enable, config)
	if enable then
		if not plate.widgets.TotemIcon then
			local widget
			widget = CreateTotemIconWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) --0, 3)
			--widget:SetScale(1.2)
			plate.widgets.TotemIcon = widget
		end
	elseif plate.widgets.TotemIcon then
		plate.widgets.TotemIcon:Hide()
		plate.widgets.TotemIcon = nil
	end
end

local function AddComboPoints(plate, enable, config)
	if enable then
		if not plate.widgets.ComboWidget then
			local widget
			widget = CreateComboPointWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) --0, 10)
			widget:SetFrameLevel(plate:GetFrameLevel()+2)
			plate.widgets.ComboWidget = widget
		end
	elseif plate.widgets.ComboWidget then
		plate.widgets.ComboWidget:Hide()
		plate.widgets.ComboWidget = nil
	end
end

local function AddThreatLineWidget(plate, enable, config)
	if enable then
		if not plate.widgets.ThreatLineWidget then
			local widget
			widget = CreateThreatLineWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0)
			widget:SetFrameLevel(plate:GetFrameLevel()+3)
			--widget._LowColor = LocalVars.TugWidgetLooseColor
			--widget._HighColor = LocalVars.TugWidgetAggroColor
			--widget._TankedColor = LocalVars.TugWidgetSafeColor
			plate.widgets.ThreatLineWidget = widget
		end
	elseif plate.widgets.ThreatLineWidget then
		plate.widgets.ThreatLineWidget:Hide()
		plate.widgets.ThreatLineWidget = nil
	end
end

local function AddThreatWheelWidget(plate, enable, config)
	if enable then
		if not plate.widgets.ThreatWheelWidget then
			local widget
			widget = WidgetLib.CreateThreatWheelWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0)
			widget:SetFrameLevel(plate:GetFrameLevel()+3)
			plate.widgets.ThreatWheelWidget = widget
		end
	elseif plate.widgets.ThreatWheelWidget then
		plate.widgets.ThreatWheelWidget:Hide()
		plate.widgets.ThreatWheelWidget = nil
	end
end

local RangeModeRef = { 9, 15, 28, 40 }
local function AddRangeWidget(plate, enable, config)
	if enable then
		if not plate.widgets.RangeWidget then
			local widget
			widget = CreateRangeWidget(plate)
			widget:SetPoint(config.anchor or "CENTER", config.x or 0, config.y or 0) --0, 0)
			plate.widgets.RangeWidget = widget
		end
	elseif plate.widgets.RangeWidget then
		plate.widgets.RangeWidget:Hide()
		plate.widgets.RangeWidget = nil
	end
end

local function AddDebuffWidget(plate, enable, config)
	if enable then
		if not plate.widgets.DebuffWidget then
			local widget
			widget =  CreateAuraWidget(plate)
			widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) --15, 20)
			widget:SetFrameLevel(plate:GetFrameLevel()+1)
			--widget.Filter = DebuffFilter		-- this method of defining the filter function will be deprecated in 6.9
			plate.widgets.DebuffWidget = widget
		end
	elseif plate.widgets.DebuffWidget then
		plate.widgets.DebuffWidget:Hide()
		plate.widgets.DebuffWidget = nil
	 end
end

local function MoveDebuffWidget(plate, config)
	local widget = plate.widgets.DebuffWidget
	if widget then
		widget:SetPoint(config.anchor or "TOP", plate, config.x or 0, config.y or 0) --15, 20)
	end
end

------------------------------------------------------------------------------
-- Widget Activation
------------------------------------------------------------------------------


-- testing HealerWidget
--CreateHealerWidget = TidyPlatesWidgets.CreateHealerWidget

local function OnInitializeWidgets(plate, configTable)
	AddClassIcon(plate, ((LocalVars.ClassEnemyIcon or LocalVars.ClassPartyIcon)) , configTable.ClassIcon)
	AddTotemIcon(plate,  LocalVars.WidgetsTotemIcon, configTable.TotemIcon)
	AddThreatWheelWidget(plate, LocalVars.WidgetsThreatIndicator and (LocalVars.WidgetsThreatIndicatorMode == 2), configTable.ThreatWheelWidget)
	AddThreatLineWidget(plate, LocalVars.WidgetsThreatIndicator and (LocalVars.WidgetsThreatIndicatorMode == 1), configTable.ThreatLineWidget)
	AddComboPoints(plate, LocalVars.WidgetsComboPoints, configTable.ComboWidget )
	AddRangeWidget(plate, LocalVars.WidgetsRangeIndicator, configTable.RangeWidget )
	if LocalVars.WidgetsComboPoints and configTable.DebuffWidgetPlus then -- If the combo widget is active, it often overlaps the debuff widget "DebuffWidgetPlus" will provide an alternative
		AddDebuffWidget(plate, LocalVars.WidgetsDebuff, configTable.DebuffWidgetPlus )
	else AddDebuffWidget(plate, LocalVars.WidgetsDebuff, configTable.DebuffWidget ) end

	--testing HealerWidget
	--plate.widgets.HealerWidget = CreateHealerWidget(plate)
	--plate.widgets.HealerWidget:SetPoint("CENTER", -50, 2) --0, 0)

	if LocalVars.WidgetsEnableExternal and TidyPlatesGlobal_OnInitialize then TidyPlatesGlobal_OnInitialize(plate) end
end

local function OnContextUpdateDelegate(plate, unit)
	local Widgets = plate.widgets
	if LocalVars.WidgetsComboPoints then Widgets.ComboWidget:UpdateContext(unit) end
	if (LocalVars.WidgetsThreatIndicatorMode == 1) and LocalVars.WidgetsThreatIndicator then Widgets.ThreatLineWidget:UpdateContext(unit) end		-- Tug-O-Threat
	if LocalVars.WidgetsDebuff then Widgets.DebuffWidget:UpdateContext(unit) end

	if LocalVars.WidgetsEnableExternal and TidyPlatesGlobal_OnContextUpdate then TidyPlatesGlobal_OnContextUpdate(plate, unit) end
end

local function OnUpdateDelegate(plate, unit)
	local Widgets = plate.widgets
	if LocalVars.WidgetsRangeIndicator then Widgets.RangeWidget:Update(unit,RangeModeRef[LocalVars.RangeMode])  end
	if (LocalVars.ClassEnemyIcon and unit.reaction ~= "FRIENDLY") or (LocalVars.ClassPartyIcon and unit.reaction == "FRIENDLY") then Widgets.ClassIcon:Update(unit, LocalVars.ClassPartyIcon) end
	if LocalVars.WidgetsTotemIcon then Widgets.TotemIcon:Update(unit)  end
	if (LocalVars.WidgetsThreatIndicatorMode == 2) and LocalVars.WidgetsThreatIndicator then plate.widgets.ThreatWheelWidget:Update(unit) end 		-- Threat Wheel

	if LocalVars.WidgetsEnableExternal and TidyPlatesGlobal_OnUpdate then TidyPlatesGlobal_OnUpdate(plate, unit) end
end

-- Threat Functions List
local ThreatFunctionList = {
	[ScaleFunctionByThreat] = true,
	[AlphaFunctionByThreat] = true,
	[ColorFunctionByThreat] = true,
	[NameColorByThreat] = true,
	[WarningBorderFunctionByThreat] = true,
}

local function EnableWatchers()
	if LocalVars.WidgetsDebuffStyle == 2 then TidyPlatesWidgets.UseSquareDebuffIcon() else TidyPlatesWidgets.UseWideDebuffIcon()end
	TidyPlatesUtility:EnableGroupWatcher()
	if LocalVars.AdvancedEnableUnitCache then TidyPlatesUtility:EnableUnitCache() else TidyPlatesUtility:DisableUnitCache() end

	-- Healer Tracker
	if (ScaleFunctionsUniversal[LocalVars.ScaleSpotlightMode] == ScaleFunctionByEnemyHealer) or
		AlphaFunctionsUniversal[LocalVars.OpacitySpotlightMode] == AlphaFunctionByEnemyHealer or
		WarningBorderFunctionsUniversal[LocalVars.ColorDangerGlowMode] ~= DummyFunction then
			TidyPlatesUtility:EnableHealerTrack()
	else
		TidyPlatesUtility:DisableHealerTrack()
	end

	-- Testing HealerWidget
	--TidyPlatesUtility:EnableHealerTrack()		-- Force enable

	-- Aggro/Threat
	-- Checks to see if the player is using any of the By Threat modes
	-- FriendlyBarFunctions
	if	ThreatFunctionList[EnemyBarFunctions[LocalVars.ColorEnemyBarMode]] or
		ThreatFunctionList[NameColorFunctions[LocalVars.ColorEnemyNameMode]] or
		ThreatFunctionList[FriendlyBarFunctions[LocalVars.ColorFriendlyBarMode]] or
		ThreatFunctionList[NameColorFunctions[LocalVars.ColorFriendlyNameMode]] or
		ThreatFunctionList[AlphaFunctionsUniversal[LocalVars.OpacitySpotlightMode]] or
		ThreatFunctionList[ScaleFunctionsUniversal[LocalVars.ScaleSpotlightMode]] or
		ThreatFunctionList[NameColorFunctions[LocalVars.HeadlineEnemyColor]] or
		ThreatFunctionList[NameColorFunctions[LocalVars.HeadlineFriendlyColor]]
		or LocalVars.ThreatGlowEnable then

			SetCVar("threatWarning", 3)
	end

	--if LocalVars.ColorEnableOffTank then
			TidyPlatesWidgets:EnableTankWatch()	-- Off-Tank support		-- Lots of shtuff depends on this.
	--else TidyPlatesWidgets:DisableTankWatch() end

	if LocalVars.ColorShowPartyAggro then TidyPlatesWidgets:EnableAggroWatch()	-- Group aggro holders
	else TidyPlatesWidgets:DisableAggroWatch() end

	--SetCVar("threatWarning", 3)		-- Required for threat/aggro detection

	if LocalVars.WidgetsDebuff then
		TidyPlatesWidgets:EnableAuraWatcher()
		TidyPlatesWidgets.SetAuraFilter(DebuffFilter)
	else TidyPlatesWidgets:DisableAuraWatcher() end

	if LocalVars.WidgetsAuraMode == 3 then
		TidyPlatesWidgets.SetAuraPrefilter(Prefilter)
	else TidyPlatesWidgets.SetAuraPrefilter(nil) end
end

local CreateVariableSet = TidyPlatesHubRapidPanel.CreateVariableSet

-- [[
-- TidyPlatesHubSettings["HubPanelSettingsDamage"]
local function UseDamageVariables()
	local objectName = "HubPanelSettingsDamage"
	LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)
	--EnableWatchers()
	return LocalVars
end

local function UseTankVariables()
	local objectName = "HubPanelSettingsTank"
	LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)
	--EnableWatchers()
	return LocalVars
end
--]]

local function UseVariables(suffix)
	if suffix then
		local objectName = "HubPanelSettings"..suffix
			LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)
			--EnableWatchers()
			return LocalVars
	end
end

---------------
-- Apply customization
---------------
--local blizzfont =				NAMEPLATE_FONT
local blizzfont =				STANDARD_TEXT_FONT;
--local blizz_sansserif =					"FONTS\\ARIALN.TTF"
--local blizz_serif =					"FONTS\\FRIZQT__.TTF"
--local default_font =					NAMEPLATE_FONT

local function ApplyFontCustomization(style)
	if not style then return end
	if LocalVars.TextUseBlizzardFont then
		style.oldfont = style.name.typeface
		style.name.typeface = blizzfont
		style.level.typeface = blizzfont
		style.customtext.typeface = blizzfont
		style.spelltext.typeface = blizzfont
	else
		local typeface = style.oldfont or style.name.typeface
		style.name.typeface =  typeface
		style.level.typeface =  typeface
		style.customtext.typeface =  typeface
		style.spelltext.typeface =  typeface
	end
	style.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)-16
end

local function ApplyStyleCustomization(style)
	if not style then return end
	style.level.show = (LocalVars.TextShowLevel == true)
	style.target.show = (LocalVars.WidgetTargetHighlight == true)
	style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
	ApplyFontCustomization(style)
end


local function ApplyThemeCustomization(theme)
	ReactionColors.FRIENDLY.NPC = LocalVars.ColorFriendlyNPC
	ReactionColors.FRIENDLY.PLAYER = LocalVars.ColorFriendlyPlayer
	ReactionColors.HOSTILE.NPC = LocalVars.ColorHostileNPC
	ReactionColors.HOSTILE.PLAYER = LocalVars.ColorHostilePlayer
	ReactionColors.NEUTRAL.NPC = LocalVars.ColorNeutral

	NameReactionColors.FRIENDLY.NPC = LocalVars.TextColorFriendlyNPC
	NameReactionColors.FRIENDLY.PLAYER = LocalVars.TextColorFriendlyPlayer
	NameReactionColors.HOSTILE.NPC = LocalVars.TextColorHostileNPC
	NameReactionColors.HOSTILE.PLAYER = LocalVars.TextColorHostilePlayer
	NameReactionColors.NEUTRAL.NPC = LocalVars.TextColorNeutral

	EnableWatchers()
	ApplyStyleCustomization(theme["Default"])
	ApplyFontCustomization(theme["NameOnly"])
	TidyPlates:ForceUpdate()
	RaidClassColors = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
end

---------------------------------------------
-- Function List
---------------------------------------------
TidyPlatesHubFunctions.SetScale = ScaleDelegate
TidyPlatesHubFunctions.SetNameColor = SetNameColorDelegate
TidyPlatesHubFunctions.SetAlpha = AlphaDelegate
TidyPlatesHubFunctions.SetCustomText = HealthTextDelegate
TidyPlatesHubFunctions.OnUpdate = OnUpdateDelegate
TidyPlatesHubFunctions.OnInitializeWidgets = OnInitializeWidgets
TidyPlatesHubFunctions.OnContextUpdate = OnContextUpdateDelegate
TidyPlatesHubFunctions.SetHealthbarColor = HealthColorDelegate
TidyPlatesHubFunctions.SetThreatColor = ThreatColorDelegate
TidyPlatesHubFunctions.SetCastbarColor = CastBarDelegate
TidyPlatesHubFunctions.UseDamageVariables = UseDamageVariables
TidyPlatesHubFunctions.UseTankVariables = UseTankVariables
TidyPlatesHubFunctions.UseVariables = UseVariables
TidyPlatesHubFunctions.EnableWatchers = EnableWatchers
TidyPlatesHubFunctions._WidgetDebuffFilter = DebuffFilter
TidyPlatesHubFunctions.ApplyFontCustomization = ApplyFontCustomization
TidyPlatesHubFunctions.ApplyStyleCustomization = ApplyStyleCustomization
TidyPlatesHubFunctions.ApplyThemeCustomization = ApplyThemeCustomization
TidyPlatesHubFunctions.SetMultistyle = StyleDelegate
TidyPlatesHubFunctions.SetStyleBinary = SetStyleBinaryDelegate
TidyPlatesHubFunctions.SetStyleTrinary = SetStyleTrinaryDelegate
TidyPlatesHubFunctions.SetCustomTextBinary = CustomTextBinaryDelegate

---------------------------------------------
-- Slash Commands
---------------------------------------------
local function ShowCurrentHubPanel()
	local theme = TidyPlatesThemeList[TidyPlatesOptions[GetCurrentSpec()]]
	if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == 'function' then theme.ShowConfigPanel() end
end

SLASH_HUB1 = '/hub'
SlashCmdList['HUB'] = ShowCurrentHubPanel
