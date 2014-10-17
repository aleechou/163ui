--
-- JSHB - Returns the cost of the player's main spell, dependant on current spec.
--


local lastCost = 0
local currentCost = 0
local currentSpec = 0

function JSHB.GetMainSpellCost()
	--currentCost = select(4, GetSpellInfo(classSpells[select(2, UnitClass("player") )][GetSpecialization() or 1]) )
	
	currentSpec = GetSpecialization()
	
	if (currentSpec == 1) then
		if UnitAura("player", "Bestial Wrath") then
			currentCost = 20
		else
			currentCost = 40
		end
	end
	
	if (currentSpec == 2) then
		currentCost = 35
	end
	
	if (currentSpec == 3) then
		currentCost = 15
	end
	
	
	--currentCost = 20
	
	if (currentCost ~= 0) then
		lastCost = currentCost
	end
	return lastCost
end
