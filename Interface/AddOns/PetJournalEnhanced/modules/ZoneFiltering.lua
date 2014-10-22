local ZoneFiltering = PetJournalEnhanced:NewModule("ZoneFiltering")
local zoneIDs = PetJournalEnhanced:GetModule("ZoneIDs")
local L =  LibStub("AceLocale-3.0"):GetLocale("PetJournalEnhanced")
local CONTINUED = L["Continued"]
local INSTANCES = L["Instances"]

function ZoneFiltering:OnInitialize()
	
	--self:FindNewPets()
	self.ZoneGroupNames= {}	
	local continentsP6 = { GetMapContinents() };
	local index = 0;
	for i = 2, #continentsP6, 2 do
	 index = index + 1;
	 self.ZoneGroupNames[index] = continentsP6[i];
	end
	--self.ZoneGroupNames = {GetMapContinents()}
	table.insert(self.ZoneGroupNames,INSTANCES)
	
	local ZoneToSpecies = {}
	
	
	--create temporary mapping between zones and species to figure out which zones contain pets
	local SpeciesToZoneId = zoneIDs.SpeciesToZoneId
	for speciesID,zones in pairs(SpeciesToZoneId) do
		for zoneID,_ in pairs(zones) do
			if not ZoneToSpecies[zoneID] then ZoneToSpecies[zoneID] = true end
		end
	end
	

	--remove empty zones from zone groups
	local zoneGroups = zoneIDs.continents
	for i=1, #zoneGroups do
		for j=#zoneGroups[i], 1,-1  do
			local zoneID = zoneGroups[i][j]
			if not ZoneToSpecies[zoneID] then
				table.remove(zoneGroups[i],j)
			end
		end
	end
	
	
	--create a way to store which zones are being filtered
	self.zoneFilter = {}
	
	for zoneGroup = 1, #zoneGroups do
		for zoneIndex = 1, #zoneGroups[zoneGroup] do
			local zoneID = zoneGroups[zoneGroup][zoneIndex]
			self.zoneFilter[zoneID] = true
		end
	end
	
	for i= 1 ,#self.ZoneGroupNames do
		if #zoneIDs.continents[i] > 16 then
			table.insert(self.ZoneGroupNames,i+1,self.ZoneGroupNames[i].." "..CONTINUED);
			table.insert(zoneIDs.continents,i+1,{});
			for j = math.ceil(#zoneIDs.continents[i]/2), #zoneIDs.continents[i] do
				table.insert(zoneIDs.continents[i+1],zoneIDs.continents[i][j]);
			end
			for j = #zoneIDs.continents[i], math.ceil(#zoneIDs.continents[i]/2), -1 do
				table.remove(zoneIDs.continents[i],j)
			end
		end
	end
	
end

function ZoneFiltering:GetNumZoneGroups()
	return #self.ZoneGroupNames
end

function ZoneFiltering:GetZoneGroupNames(groupID)
	assert(type(groupID) == "number")
	return self.ZoneGroupNames[groupID]
end

function ZoneFiltering:GetZoneGroupMapping()
	return zoneIDs.continents
end

function ZoneFiltering:GetZoneGroup(groupID)
	return zoneIDs.continents[groupID]
end

function ZoneFiltering:GetZonesBySpeciesID(speciesID)
	return zoneIDs.SpeciesToZoneId[speciesID] 
end

function ZoneFiltering:SetFiltered(zoneID,enabled)
	self.zoneFilter[zoneID] = enabled
end

function ZoneFiltering:GetFiltered(zoneID)
	return self.zoneFilter[zoneID]
end

function ZoneFiltering:SetAllFiltered(enabled)
	for k,_ in pairs(self.zoneFilter) do
		self.zoneFilter[k]= enabled
	end
end

function ZoneFiltering:SetAllGroupFiltered(groupID,enabled)
	local zones = zoneIDs.continents[groupID]
	if not zones then return end
	
	for i=1, #zones do
		local zoneID = zones[i]
		self.zoneFilter[zoneID]= enabled
	end
end



function ZoneFiltering:IsEveryZoneEnabled()
	for k,v in pairs(self.zoneFilter) do
		if not v then 
			return false 
		end
	end
	return true;
end


--/run FindNewPets()
function ZoneFiltering:FindNewPets()
	--zoneIDs.SpeciesToZoneId = {}
	--MacroFrameText:SetMaxLetters(0)
	self.newPets = ""
	
	local numPets = C_PetJournal.GetNumPets()
	
	zoneMap = {
		["stormwind"]=301,
		["shattrath"]=481,
		["brawl'gar arena"] = 321,
		["the barrens"] = 11,
		["terokkar forest (fishing nodes)"] = 478,
		["booty bay"] = 673,
		["lower blackrock spire"] = 721,
		["lor'danel"] = 42,
		["occasionally appears alongside other creatures during battles on darkmoon island."] = 823,
		["jade forest"] = 806,
		["caverns of time"]= 161,
		["valley of four winds"] = 807,
		["coldarra"] = 486,
	}
	
	for i=1, #zoneIDs.continents do
		for j = 1, #zoneIDs.continents[i] do
			zoneMap[string.lower(GetMapNameByID(zoneIDs.continents[i][j]))] = zoneIDs.continents[i][j]
		end
	end
	
	local keywords = {"cost","difficulty","faction","weather","season","time","event"}
	
	for i=1, numPets do
		local _, speciesID, _, _, _, _, _, name, _, _, _, sourceText = C_PetJournal.GetPetInfoByIndex(i)
	
		if zoneIDs.SpeciesToZoneId[speciesID] == nil and (string.find(sourceText,"Pet Battle:",1,true) or string.find(sourceText,"Zone:",1,true) or string.find(sourceText,"Raid:",1,true) ) then
			sourceText = string.lower(sourceText)
			sourceText = string.gsub(sourceText,"|[rn]","")
			sourceText = string.gsub(sourceText,"|c%x%x%x%x%x%x%x%x","")
			local zoneText = string.match(sourceText,"zone:(.*)") or string.match(sourceText,"raid:(.*)") or string.match(sourceText,"drop:(.*)") or string.match(sourceText,"pet battle:(.*)")
			if zoneText then
				for x = 1, #keywords do
					zoneText = string.gsub(zoneText,keywords[x]..":.*","") 
				end
			end
		
			if zoneText then
			
				local zones = {string.split(",",zoneText)}
				
				local entry = "["..speciesID.."]={"
				for j=1, #zones do
					local zone = strtrim(zones[j])
					local zoneID = zoneMap[zone]
					local entryText = (zoneID or zone or "error")
						entry = entry .. "["..entryText.."]="..entryText..","
				end
				entry = entry .. "},--"..name.."|n"
				entry= entry.gsub(entry,",}","}")
				if not string.find(self.newPets,entry,1,true) then
					self.newPets = self.newPets .. entry
				end
			end
		end
	end
end

--/run InsertNewPets()
function InsertNewPets()
	MacroFrameText:SetMaxLetters(0)
	MacroFrameText:Insert(ZoneFiltering.newPets)
end


