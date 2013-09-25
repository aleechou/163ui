--GAME_LOCALE = "deDE"
--GAME_LOCALE = "esMX"
--GAME_LOCALE = "zhCN"
--GAME_LOCALE = "frFR"
--GAME_LOCALE = "ruRU"
--GAME_LOCALE = "zhTW"
PetJournalEnhanced = LibStub("AceAddon-3.0"):NewAddon("PetJournalEnhanced","AceEvent-3.0")

--[[
function PetJournalEnhanced:OnInitialize()
end
--due to a bug with curse.com client not cleanly uninstalling old versions
--notify user if old version is found
--function PetJournalEnhanced:ADDON_LOADED(event,arg1)
	if arg1 == "PetTheory" then end
end

function PetJournalEnhanced:PetTheoryWarning()
	if IsAddOnLoaded("PetTheory") then
		StaticPopup_Show("PJE_PET_THEORY_WARNING")
	end
end

StaticPopupDialogs["PJE_PET_THEORY_WARNING"] = {
	preferredIndex = STATICPOPUP_NUMDIALOGS,
	text = L["PET_THEORY_WARNING"],
	button1 = OKAY,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1,
}
]]





