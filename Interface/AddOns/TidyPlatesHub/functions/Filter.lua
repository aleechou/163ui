
local AddonName, HubData = ...;
local LocalVars = TidyPlatesHubDefaults

------------------------------------------------------------------------------
-- Unit Filter
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
-- Local Variable
------------------------------------------------------------------------------

local function OnVariableChange(vars) LocalVars = vars end
HubData.RegisterCallback(OnVariableChange)


------------------------------------------------------------------------------
-- Add References
------------------------------------------------------------------------------
TidyPlatesHubFunctions.UnitFilter = UnitFilter

