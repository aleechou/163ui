------------------------------------------------------------
-- Statues.lua
--
-- Abin
-- 2013/7/22
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "MONK" then return end

local _, addon = ...

local button = addon:CreateActionButton("MonkOxStatue", 115315, nil, 900)
button:SetSpell(115315)
button:SetAttribute("spell", button.spell)
button:RequireSpell(115315)
button:SetFlyProtect()

function button:OnUpdateTimer()
	local haveTotem, name, startTime, duration = GetTotemInfo(1)
	if haveTotem and (startTime or 0 ) > 0 and (duration or 0) > 0 then
		return 1, startTime + duration
	end
end