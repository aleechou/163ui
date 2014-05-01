-- Author      : s1172
-- Create Date : 2013/6/24 12:14:14

function NewbieAssistantNavigationFrame_OnShow(self)
	self:SetFrameLevel(self:GetParent():GetFrameLevel() + 10)
end

function NewbieAssistantNavigationFrame_OnLoad(self)
	self:RegisterEvent("QUEST_POI_UPDATE")
	self:RegisterEvent("WORLD_MAP_UPDATE")
end


local scanning
function NewbieAssistantNavigationFrame_OnEvent(self, event, ...)
	if scanning then
        return
    else
        scanning = true
    end
	NewbieAssistantNavigationApi:HideLine()
	if not WorldMapFrame:IsShown() then
		scanning = false
		return
	end
	local POIIsShown = WorldMapPOIFrame:IsShown()
	if not POIIsShown then
		scanning = false
        return
	end
    local px, py = GetPlayerMapPosition("player")
	if not px or not py or px <= 0 or py <= 0 then
		scanning = false
        return
    end
	px = NewbieAssistantNavigationApi:getIntPart(px * 100)
	py = NewbieAssistantNavigationApi:getIntPart(py * 100)
	local cvar = GetCVarBool("questPOI")
    SetCVar("questPOI", 1)
	QuestPOIUpdateIcons()
	local watchIndex = 1
    while true do
        local questIndex = GetQuestIndexForWatch(watchIndex)
        if not questIndex then
            break
        end
        local qid = select(9, GetQuestLogTitle(questIndex))
        local completed, x, y, objective = QuestPOIGetIconInfo(qid)
		if x and y then
			x = NewbieAssistantNavigationApi:getIntPart(x * 100)
			y = NewbieAssistantNavigationApi:getIntPart(y * 100)
			len = NewbieAssistantNavigationApi:Diagonal({px,py},{x,y})
			-- print(string.format("%s  %s,%s  %s,%s",qid,px,py,x,y))
			if len>3 then
				local mapName = GetCurrentMapAreaID()
				if NewbieAssistantNavigationFrame.CoordData[mapName] then
					NewbieAssistantNavigationApi:Draw(qid,{px,py},{x,y},NewbieAssistantNavigationFrame.CoordData[mapName])
					--NavigatorApi:WorldMapDrawLine(qid, px, py, x, y, Navigator_Script.CoordData[mapName])
				end
			end
        end
        watchIndex = watchIndex + 1
    end
	SetCVar("questPOI", cvar and 1 or 0)
	scanning = false
end