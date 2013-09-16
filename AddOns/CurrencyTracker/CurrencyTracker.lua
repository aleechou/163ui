local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()

	local faction,text = UnitFactionGroup("player")

	if not CurrencyTrackerDB then CurrencyTrackerDB = {} end
	if not CurrencyTrackerDB[GetRealmName()] then CurrencyTrackerDB[GetRealmName()] = {} end
	if not CurrencyTrackerDB[GetRealmName()][UnitName("player")] then CurrencyTrackerDB[GetRealmName()][UnitName("player")] = {} end

	local function tooltip(wut)
		GameTooltip:SetOwner(wut, "ANCHOR_NONE")
		GameTooltip:SetPoint("TOPLEFT", wut, "BOTTOMLEFT")
		GameTooltip:ClearLines()
		GameTooltip:AddLine("Click to add/remove Currencies")
		for k,v in pairs(CurrencyTrackerDB[GetRealmName()]) do GameTooltip:AddDoubleLine(k..":",v) end
		GameTooltip:Show()
	end

	CurrencyTracker = LibStub("LibDataBroker-1.1"):NewDataObject("CurrencyTracker", { 
		type = "data source",
		text = "CurrencyTracker",
		OnClick = function() ToggleCharacter("TokenFrame") end,
		OnEnter = function(self) tooltip(self) end,
		OnLeave = function() GameTooltip:Hide()	end,
	})

	local function GetCurrencyTracking()
		text = ""
		if BackpackTokenFrame.shouldShow then
			CurrencyTrackerDB[GetRealmName()][UnitName("player")] = {}
			for i=1,GetNumWatchedTokens() do
				local name, count, icon = GetBackpackCurrencyInfo(i);
				if text == "" then text = count.." |T"..icon..":15:15:0:0|t" else text = text.." "..count.." |T"..icon..":15:15:0:0|t" end
			end
			CurrencyTrackerDB[GetRealmName()][UnitName("player")] = text
			CurrencyTracker.text = text
		else 
			CurrencyTrackerDB[GetRealmName()][UnitName("player")] = nil
			CurrencyTracker.text = "|TInterface\\Minimap\\Tracking\\None:15:15:0:0|tCurrencyTracker"
		end
	end

	hooksecurefunc("BackpackTokenFrame_Update", GetCurrencyTracking)
	GetCurrencyTracking()

	f:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)