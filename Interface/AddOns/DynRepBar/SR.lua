local SR_REP_MSG = "%s: %+d (%d/%d)";
local rep = {};

local function SR_Update(self)
	local numFactions = GetNumFactions();
	
	for i = 1, numFactions, 1 do
		local name, _, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(i);
		if (not isHeader) or (hasRep) then
			if not rep[name] then
				rep[name] = barValue;
			end
			
			local change = barValue - rep[name];
			if (change > 0) then
				rep[name] = barValue;
				local msg = string.format(SR_REP_MSG, name, change, barValue - barMin, barMax - barMin);
				
				local info = ChatTypeInfo["COMBAT_FACTION_CHANGE"];
				for j = 1, 4, 1 do
					local chatfrm = getglobal("ChatFrame"..j);
					for k,v in pairs(chatfrm.messageTypeList) do
						if v == "COMBAT_FACTION_CHANGE" then
							chatfrm:AddMessage(msg, info.r, info.g, info.b, info.id);
							break;
						end
					end
				end
			end
		end
	end
end

local frame = CreateFrame("Frame");
frame:RegisterEvent("UPDATE_FACTION");
frame:SetScript("OnEvent", SR_Update);
ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_FACTION_CHANGE", function() return true; end);