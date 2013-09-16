local UniquePets = PetJournalEnhanced:NewModule("UniquePets","AceEvent-3.0")
local LibPetJournal = LibStub("LibPetJournal-2.0")
local _
local L = LibStub("AceLocale-3.0"):GetLocale("PetJournalEnhanced")
--Call back handler for updating unique pet count
function UniquePets:ScanPets()
	local pets = {}
	local count = 0
	for i,petID in LibPetJournal:IteratePetIDs() do 
		local speciesID = C_PetJournal.GetPetInfoByPetID(petID)
        if(speciesID) then
            if not pets[speciesID] then
                count = count + 1
                pets[speciesID] = speciesID
            end
        end
	end
	UniquePets.frame.uniqueCount:SetText(count)
end

function UniquePets:Initialize(database)
	self.db = database.global
	self:RegisterMessage("PETJOURNAL_ENHANCED_OPTIONS_UPDATE")
	self.frame = CreateFrame("frame","PJEUniquePetCount",PetJournal,"InsetFrameTemplate3")
	
	--Create unique pet count UI elements
	local frame = self.frame;
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT",PetJournal,70,-42)
	frame:SetSize(130,18)
	frame.staticText = frame:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
	frame.uniqueCount = frame:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	
	frame.staticText:ClearAllPoints()
	frame.staticText:SetPoint("LEFT",frame,10,0)
	--frame.staticText:SetPoint("RIGHT",frame.uniqueCount,"LEFT",-3,0)
	frame.staticText:SetText(L["Unique Pets"])
	
	frame.uniqueCount:ClearAllPoints()
	frame.uniqueCount:SetPoint("RIGHT",frame,-10,0)
	frame.uniqueCount:SetText("0")
	
	
	--Inital ui state
	self:SetShown(self.db.display.uniquePetCount)
	
	
	LibPetJournal.RegisterCallback(self,"PetListUpdated", "ScanPets")
	self:ScanPets()
end

--Shows unique pet count if enabled is not false or nil
function UniquePets:SetShown(enabled)
	if enabled then
		self.frame:Show()
		PetJournal.PetCount:SetPoint("TopLeft",70,-22)
		PetJournal.PetCount:SetSize(130,18)
	else
		self.frame:Hide()
		PetJournal.PetCount:SetPoint("TopLeft",70,-35)
		PetJournal.PetCount:SetSize(130,20)
	end
end

function UniquePets:PETJOURNAL_ENHANCED_OPTIONS_UPDATE()
	self:SetShown(self.db.display.uniquePetCount)
end

