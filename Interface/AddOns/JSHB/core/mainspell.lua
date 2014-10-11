--
-- JSHB - Returns the cost of the player's main spell, dependant on current spec.
--

local classSpells = {
	HUNTER 		= { 34026, 53209, 53301 }, -- Kill Command, Chimera Shot, Explosive Shot
	WARRIOR 	= { 12294, 23881, 2565 }, -- Mortal Strike, Blood Thirst, Shield Block
	ROGUE		= { 1329, 1752, 53 }, -- Mutilate, Sinister Strike, Backstab
	WARLOCK		= { 86121, 686, 29722 }, -- Soul Swap, Shadow Bolt, Incinerate -- prob better choices....
}

local lastCost = 0
local currentCost = 0

function JSHB.GetMainSpellCost()
	currentCost = select(4, GetSpellInfo(classSpells[select(2, UnitClass("player") )][GetSpecialization() or 1]) )
	if (currentCost ~= 0) then
		lastCost = currentCost
	end
	return lastCost
end
