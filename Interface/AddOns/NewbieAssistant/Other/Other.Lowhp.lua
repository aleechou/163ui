-- Author      : s1172
-- Create Date : 2013/6/11 13:28:58

local L = TutorialApi.Localization

local Lowhp = CreateFrame("Frame") 
Lowhp.breaked = nil
Lowhp.Lowestper = 30

function Lowhp:UNIT_HEALTH(unit) 
	if unit == "player" then 
		local health, max = UnitHealth(unit), UnitHealthMax(unit) 
		if health < (max / 100) * Lowhp.Lowestper and not Lowhp.breaked then 
			RaidNotice_AddMessage(RaidBossEmoteFrame, L["Low hp."], ChatTypeInfo["RAID_WARNING"])
			Lowhp.breaked = true
			NAApi:Sleep(10,function()
				Lowhp.breaked = nil
			end)
		end 
	end 
end 

NAApi:RegEvent(Lowhp,"UNIT_HEALTH",Lowhp["UNIT_HEALTH"])
