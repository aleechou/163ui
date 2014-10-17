TidyPlatesHubLocalization = TidyPlatesHubLocalization or {}


----------------------------------------------------------------------
-- Localization
----------------------------------------------------------------------

--[[  Example of Localization LUA...

TidyPlatesHubLocalizedFont = "FONTS/ARIALN.TTF"

if GetLocale() == "enUS" then
	TidyPlatesHubLocalization["Style"] = "Translation of STYLE"
	TidyPlatesHubLocalization["Headline Mode"] = "No-Bars Mode"
end
--]]

function TidyPlatesHub_GetLocalizedString(str)
	if str then return TidyPlatesHubLocalization[str] or str
	else return "" end
end

local L = TidyPlatesHub_GetLocalizedString



	--[[
		Color Guide:
		|cffffdd00		for Yellow
		|cffff6906		for Orange
		|cff999999		for Grey
		|cffffaa33		for Brownish Orange
	--]]

	-- For making tooltips....
	-- .tooltipTitle = "Default", tooltipText = "Health bars always visible.", tooltipOnButton = true,

	--[[ 6.7 Testing
	TidyPlatesHubModes.ArtStyles = {{ text = "Blizzard", notCheckable = 1 } ,}

	TidyPlatesHubModes.ArtModes = {
		{ text = "By Elite", notCheckable = 1 } ,
		{ text = "By Enemy", notCheckable = 1 } ,
		{ text = "By NPC", notCheckable = 1 } ,
	}

	--]]

----------------------------------------------------------------------
-- Dropdown menu choices (corresponds to functions)
----------------------------------------------------------------------

TidyPlatesHubModes = {}

TidyPlatesHubModes.StyleModes = {
				{ text = L("Default Bars"), notCheckable = 1, } ,
				{ text = L("|cffffaa33Headline Always (No Health Bar)"),	notCheckable = 1, } ,
				{ text = L("|cffffaa33Headline while idle;|r Health Bars during Combat"), notCheckable = 1, } ,
				{ text = L("|cffffaa33Headline on other units;|r Health Bars on Active/Damaged/Marked Units"),	notCheckable = 1, } ,
				{ text = L("|cffffaa33Headline on Normal units;|r Health Bars on Elite units"), notCheckable = 1 } ,
				{ text = L("|cffffaa33Headline on Unmarked Units;|r Health Bars on Marked Units"), notCheckable = 1 } ,
				{ text = L("|cffffaa33Headline on NPCs;|r Health Bars on Players"), notCheckable = 1 } ,
				{ text = L("|cffffaa33Headline on other units;|r Health Bar on Current Target"), notCheckable = 1 } ,
				{ text = L("|cffffaa33Headline on other units;|r Health Bars on Low Threat/Party Aggro (Tank Mode)"), notCheckable = 1 } ,
			}

TidyPlatesHubModes.TextModes = {
				{ text = L("None"), notCheckable = 1 },
				{ text = L("Percent Health"), notCheckable = 1 } ,
				{ text = L("Exact health"), notCheckable = 1 } ,
				{ text = L("Health Deficit"), notCheckable = 1 } ,
				{ text = L("Health Total & Percent"), notCheckable = 1 } ,
				{ text = L("Target Of"), notCheckable = 1 } ,
				{ text = L("Approximate Health"), notCheckable = 1 } ,
				{ text = L("Level"), notCheckable = 1 } ,
				{ text = L("Level and Health"), notCheckable = 1 } ,
				{ text = L("Arena ID, Health, and Power"), notCheckable = 1 } ,
			}

			--[[
			-- Status Text Ingredients
			-- Text Builder

			TidyPlatesHubModes.TextModes = {
				{ text = L("None"), notCheckable = 1 },
				{ text = L("Health"), notCheckable = 1 } ,
				{ text = L("Target Of"), notCheckable = 1 } ,
				{ text = L("Approximate Health"), notCheckable = 1 } ,
				{ text = L("Level"), notCheckable = 1 } ,
				{ text = L("Level and Health"), notCheckable = 1 } ,
				{ text = L("Arena ID, Health, and Power"), notCheckable = 1 } ,
			}

			TidyPlatesHubModes.TextIngredientList = {
				{ text = L("None"), notCheckable = 1 },
				{ text = L("Percent Health"), notCheckable = 1 } ,
				{ text = L("Approximate Health"), notCheckable = 1 } ,
				{ text = L("Exact health"), notCheckable = 1 } ,

				{ text = L("Health Deficit"), notCheckable = 1 } ,

				{ text = L("Target Of"), notCheckable = 1 } ,

				{ text = L("Level"), notCheckable = 1 } ,
				{ text = L("Health"), notCheckable = 1 } ,
				{ text = L("Arena ID"), notCheckable = 1 } ,
				{ text = L("Power"), notCheckable = 1 } ,
			}

			--]]

TidyPlatesHubModes.RangeModes = {
				{ text = L("9 yards")} ,
				{ text = L("15 yards") } ,
				{ text = L("28 yards") } ,
				{ text = L("40 yards") } ,
			}

TidyPlatesHubModes.DebuffStyles = {
				{ text = L("Wide"), notCheckable = 1 } ,
				{ text = L("Compact (May require UI reload to take effect)"), notCheckable = 1 } ,
			}

TidyPlatesHubModes.DebuffModes = {
				{ text = L("Show All"), notCheckable = 1 } ,
				{ text = L("Show These... "), notCheckable = 1 } ,
				{ text = L("Show All Mine "), notCheckable = 1 } ,
				{ text = L("Show My... "), notCheckable = 1 } ,
				{ text = L("By Prefix..."), notCheckable = 1 } ,

				--[[

				--]]
			}

TidyPlatesHubModes.AuraWidgetModes = {
				{ text = L("Show My Debuffs"), notCheckable = 1 } ,
				{ text = L("Show My Buffs "), notCheckable = 1 } ,
				{ text = L("Specific Auras..."), notCheckable = 1 } ,
			}

TidyPlatesHubModes.ScaleModes = {
				{ text = L("None"), notCheckable = 1 } ,
				{ text = L("On Elite Units"), notCheckable = 1 } ,
				{ text = L("On Target"), notCheckable = 1 } ,
				{ text = L("By Threat"), notCheckable = 1 } ,
				{ text = L("On Active Auras"), notCheckable = 1 } ,
				{ text = L("On Enemy Units"), notCheckable = 1 } ,
				{ text = L("On NPCs"), notCheckable = 1 } ,
				{ text = L("On Raid Targets"), notCheckable = 1 } ,
				{ text = L("On Enemy Healers"), notCheckable = 1 } ,
				{ text = L("On Low-Health Units"), notCheckable = 1 } ,
				{ text = L("On Bosses"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.OpacityModes = {
				{ text = L("None"), notCheckable = 1 } ,
				{ text = L("By Threat"), notCheckable = 1 } ,
				{ text = L("On Active Auras"), notCheckable = 1 } ,
				{ text = L("On Enemy Units"), notCheckable = 1 } ,
				{ text = L("On NPCs"), notCheckable = 1 } ,
				{ text = L("On Raid Targets"), notCheckable = 1 } ,
				{ text = L("On Active/Damaged Units"), notCheckable = 1 } ,
				{ text = L("On Enemy Healers"), notCheckable = 1 } ,
				{ text = L("On Low-Health Units"), notCheckable = 1 } ,
				}

--[[
	Friendly Unit Bar Coloring					Enemy Unit Bar Coloring
		- Reaction								- Threat
		- Health								- Reaction
		- Class									- Health
												- Raid Icon * Remove * Add to a checkbox
												- Class
--]]

TidyPlatesHubModes.FriendlyBarModes = {
				{ text = L("By Reaction"), notCheckable = 1 } ,
				{ text = L("By Class"), notCheckable = 1 } ,
				{ text = L("By Health"), notCheckable = 1 } ,
				--{ text = L("By Raid Icon"), notCheckable = 1 } ,
				{ text = L("Pass-through"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.EnemyBarModes = {
				{ text = L("By Threat"), notCheckable = 1 } ,
				{ text = L("By Reaction"), notCheckable = 1 } ,
				{ text = L("By Class"), notCheckable = 1 } ,
				{ text = L("By Health"), notCheckable = 1 } ,
				--{ text = L("By Raid Icon"), notCheckable = 1 } ,
				{ text = L("Pass-through"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.NameColorModes = {
				{ text = L("Default"), notCheckable = 1 } ,
				{ text = L("By Class"), notCheckable = 1 } ,
				{ text = L("By Threat"), notCheckable = 1 } ,
				{ text = L("By Reaction"), notCheckable = 1 } ,
				{ text = L("By Health"), notCheckable = 1 } ,
				{ text = L("By Level Color"), notCheckable = 1 } ,
				{ text = L("By Normal/Elite/Boss"), notCheckable = 1 } ,
				}

-----
--[[
TidyPlatesHubModes.HealthColorModes = {
				{ text = L("Default"), notCheckable = 1 } ,
				{ text = L("By Enemy Class"), notCheckable = 1 } ,
				{ text = L("By Threat"), notCheckable = 1 } ,
				{ text = L("By Reaction"), notCheckable = 1 } ,
				{ text = L("By Level Color"), notCheckable = 1 } ,
				{ text = L("By Raid Icon"), notCheckable = 1 } ,
				{ text = L("By Health"), notCheckable = 1 } ,
				{ text = L("By Friendly Class"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.NameColorModes = {
				{ text = L("Default"), notCheckable = 1 } ,
				{ text = L("By Enemy Class"), notCheckable = 1 } ,
				{ text = L("By Threat"), notCheckable = 1 } ,
				{ text = L("By Reaction"), notCheckable = 1 } ,
				{ text = L("By Level Color"), notCheckable = 1 } ,
				{ text = L("By Health"), notCheckable = 1 } ,
				{ text = L("By Normal/Elite/Boss"), notCheckable = 1 } ,
				{ text = L("By Friendly Class"), notCheckable = 1 } ,
				}

--]]
TidyPlatesHubModes.WarningGlowModes = {
				{ text = L("None"), notCheckable = 1 } ,
				{ text = L("By Threat"), notCheckable = 1 } ,
				{ text = L("On Enemy Healers"), notCheckable = 1 } ,
				}

				--[[
				By Threat
				By Low Health
				By Healers

				[] Use Class Color for healers
				[] Healer Color
				--]]


TidyPlatesHubModes.TextPlateFieldModes = {
				{ text = L("None"), notCheckable = 1 } ,
				{ text = L("Percent Health"), notCheckable = 1 } ,		--
				{ text = L("Role, Guild or Level"), notCheckable = 1 } ,
				{ text = L("Role or Guild"), notCheckable = 1 } ,
				{ text = L("NPC Role"), notCheckable = 1 } ,
				{ text = L("Level"), notCheckable = 1 } ,
				{ text = L("Role, Guild, Level or Health Percent"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.ThreatWidgetModes = {
					{ text = L("Tug-o-Threat"), notCheckable = 1 } ,
					{ text = L("Threat Wheel"), notCheckable = 1 } ,
					}

TidyPlatesHubModes.ThreatModes = {
					{ text = L("Auto (Color Swap)"), notCheckable = 1 } ,
					{ text = L("Tank"), notCheckable = 1 } ,
					{ text = L("DPS/Healer"), notCheckable = 1 } ,
					}