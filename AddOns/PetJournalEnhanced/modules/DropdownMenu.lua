--partial class definition
local Hooked = PetJournalEnhanced:GetModule("Hooked")
local _
local ASCENDING =  1
local DESCENDING = 2
local L = LibStub("AceLocale-3.0"):GetLocale("PetJournalEnhanced")

local function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

local function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
        return key, t[key]
    end
    -- fetch the next value
    key = nil
    for i = 1,table.getn(t.__orderedIndex) do
        if t.__orderedIndex[i] == state then
            key = t.__orderedIndex[i+1]
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

local function orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end



function Hooked:CreateDropdownMenu(level)
	if level == 1 then
		--create check boxes
		local info = UIDropDownMenu_CreateInfo();
		info.keepShownOnClick = true;	
		info.text = COLLECTED
		info.func = 	function(_, _, _, value)
							C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, value);
							
							if (value) then
								UIDropDownMenu_EnableButton(1,2);
							else
								UIDropDownMenu_DisableButton(1,2);
							end;
							PetJournalEnhanced:UpdatePets()
							
						end 
		info.checked = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_COLLECTED);
		info.isNotRadio = true;
		UIDropDownMenu_AddButton(info, level)
		
		info.text = FAVORITES_FILTER
		info.func = 	function(_, _, _, value)
							C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, value);
							PetJournalEnhanced:UpdatePets()
						end 
		info.disabled = not info.checked or info.checked ~= true;
		info.checked = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_FAVORITES);
		info.isNotRadio = true;
		info.leftPadding = 16;
		UIDropDownMenu_AddButton(info, level)
		
		info.leftPadding = 0;
		info.disabled = nil;

		info.text = NOT_COLLECTED
		info.func = 	function(_, _, _, value)
							C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, value);
							PetJournalEnhanced:UpdatePets()
						end 
		info.checked = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED);
		info.isNotRadio = true;
		UIDropDownMenu_AddButton(info, level)
		
		info.leftPadding = 0;
		info.disabled = nil;

		info.text = L["Can Battle"]
		info.func = 	function(_, _, _, value)
							self.db.filtering.canBattle = not self.db.filtering.canBattle
							PetJournalEnhanced:UpdatePets()
						end 
		info.checked = function() return self.db.filtering.canBattle end;
		info.isNotRadio = true;
		UIDropDownMenu_AddButton(info, level)
		
		info.text = L["Can't Battle"]
		info.func = 	function(_, _, _, value)
							self.db.filtering.cantBattle = not self.db.filtering.cantBattle
							PetJournalEnhanced:UpdatePets()
						end 
		info.checked = function() return self.db.filtering.cantBattle end;
		info.isNotRadio = true;
		UIDropDownMenu_AddButton(info, level)
		
		info.text = L["Can Trade"]
		info.func = 	function(_, _, _, value)
					
					self.db.filtering.canTrade = not self.db.filtering.canTrade
					PetJournalEnhanced:UpdatePets()
				end 
		info.checked = function() return self.db.filtering.canTrade end
		UIDropDownMenu_AddButton(info, level)
		
		info.text = L["Can't Trade"]
		info.func = 	function(_, _, _, value)
					
					self.db.filtering.cantTrade = not self.db.filtering.cantTrade
					PetJournalEnhanced:UpdatePets()
				end 
		info.checked = function() return self.db.filtering.cantTrade end
		UIDropDownMenu_AddButton(info, level)
		
		info.text = L["Filter pets by current zone"]
		info.func = 	function(_, _, _, value)
					
					self.db.filtering.currentZone = not self.db.filtering.currentZone
					PetJournalEnhanced:UpdatePets()
				end 
		info.checked = function() return self.db.filtering.currentZone end
		UIDropDownMenu_AddButton(info, level)
		
		--create sub menu headers
		info.checked = 	nil;
		info.isNotRadio = nil;
		info.func =  nil;
		info.hasArrow = true;
		info.notCheckable = true;
	
		info.text = PET_FAMILIES
		info.value = 1;
		UIDropDownMenu_AddButton(info, level)
		
		info.text = SOURCES
		info.value = 2;
		UIDropDownMenu_AddButton(info, level)
		
		info.text = L["Zones"]
		info.value = 3;
		UIDropDownMenu_AddButton(info, level)		
		
		info.text = L["Quality"]
		info.value = 6;
		UIDropDownMenu_AddButton(info, level)
		
		info.text = L["Specialization"]
		info.value = 4;
		UIDropDownMenu_AddButton(info, level)
		
		info.text = L["Quantity"]
		info.value = 8;
		UIDropDownMenu_AddButton(info, level)
		
		if Hooked.db.display.BreedInfo then
			info.text = L["Breed"]
			info.value = 9;
			UIDropDownMenu_AddButton(info, level)
		end
		info.text = L["Sorting"]
		info.value = 5
		UIDropDownMenu_AddButton(info, level)
		
		
		
		local info = UIDropDownMenu_CreateInfo();
		info.notCheckable = true
		info.text = L["Reset Filters"]
		info.value = 7
		info.func = function() PetJournalEnhanced:Reset() end
		UIDropDownMenu_AddButton(info, level)
	end

	if level == 2 then	
		local info = UIDropDownMenu_CreateInfo();
		info.keepShownOnClick = true;	
		
		if Hooked.db.display.BreedInfo and UIDROPDOWNMENU_MENU_VALUE == 9 then
			local BreedData = PetJournalEnhanced:GetModule("BreedData")
			
			info.notCheckable = true;
			info.text = CHECK_ALL
			info.func = function()
					for i=1,#self.db.filtering.breed do 
						self.db.filtering.breed[i] = true
					end

					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					PetJournalEnhanced:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
					for i=1,#self.db.filtering.breed	do 
						self.db.filtering.breed[i] = false
					end

					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					PetJournalEnhanced:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			for i=1,#BreedData.breeds do
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = BreedData.breeds[i][4]
				info.func = function(_, _, _, value)
							self.db.filtering.breed[i] = not self.db.filtering.breed[i]
							PetJournalEnhanced:UpdatePets()
						end 
				info.checked = function() return self.db.filtering.breed[i] end
				UIDropDownMenu_AddButton(info, level)
				
			end	
		elseif UIDROPDOWNMENU_MENU_VALUE == 8 then
			info.notCheckable = true;
			info.text = CHECK_ALL
			info.func = function()
					for i=1,#self.db.filtering.quantity	do 
						self.db.filtering.quantity[i] = true
					end
					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					PetJournalEnhanced:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for i=1,#self.db.filtering.quantity	do 
								self.db.filtering.quantity[i] = false
							end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			
			for i=1,#self.db.filtering.quantity do
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = i
				info.func = function(_, _, _, value)
							self.db.filtering.quantity[i] = not self.db.filtering.quantity[i]
							PetJournalEnhanced:UpdatePets()
						end 
				info.checked = function() return self.db.filtering.quantity[i] end
				UIDropDownMenu_AddButton(info, level)
			
			end
		
		elseif UIDROPDOWNMENU_MENU_VALUE == 1 then --blizzard pet families
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
				
		
			info.text = CHECK_ALL
			info.func = function()
							C_PetJournal.AddAllPetTypesFilter();
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 1, 2);
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							C_PetJournal.ClearAllPetTypesFilter();
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 1, 2);
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
		
			info.notCheckable = false;
			local numTypes = C_PetJournal.GetNumPetTypes();
			for i=1,numTypes do
				info.text = _G["BATTLE_PET_NAME_"..i];
				info.func = function(_, _, _, value)
							C_PetJournal.SetPetTypeFilter(i, value);
							PetJournalEnhanced:UpdatePets()
						end
				info.checked = function() return not C_PetJournal.IsPetTypeFiltered(i) end;
				UIDropDownMenu_AddButton(info, level);
			end
		elseif UIDROPDOWNMENU_MENU_VALUE == 2 then --blizzard pet sources
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
				
		
			info.text = CHECK_ALL
			info.func = function()
							C_PetJournal.AddAllPetSourcesFilter();
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 2, 2);
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							C_PetJournal.ClearAllPetSourcesFilter();
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 2, 2);
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
		
			info.notCheckable = false;
			local numSources = C_PetJournal.GetNumPetSources();
			for i=1,numSources do
				info.text = _G["BATTLE_PET_SOURCE_"..i];
				info.func = function(_, _, _, value)
							C_PetJournal.SetPetSourceFilter(i, value);
							PetJournalEnhanced:UpdatePets()
						end
				info.checked = function() return not C_PetJournal.IsPetSourceFiltered(i) end;
				UIDropDownMenu_AddButton(info, level);
			end
		elseif UIDROPDOWNMENU_MENU_VALUE == 3 then --zone filter
			local info = UIDropDownMenu_CreateInfo()
			local zoneTree = ZoneFiltering:GetZoneTree()
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
			info.keepShownOnClick = true
			info.text = CHECK_ALL
			info.func = function()
							for continent,v in pairs(zoneTree) do
								for zone,_ in pairs(v) do
									zoneTree[continent][zone] = true
								end
							end	
							self.db.filtering.unknownZone = true
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							PetJournalEnhanced:SetZoneFilter()
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for continent,v in pairs(zoneTree) do
								for zone,_ in pairs(v) do
									zoneTree[continent][zone] = false
								end
							end	
								self.db.filtering.unknownZone = false
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							PetJournalEnhanced:SetZoneFilter()
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			local info = UIDropDownMenu_CreateInfo()
			info.notCheckable = false;	
			info.keepShownOnClick = true
			info.checked = false
			info.isNotRadio = true
			info.text = L["Unknown Zone"]
			info.func = 	function(_, _, _, value)
						self.db.filtering.unknownZone = not self.db.filtering.unknownZone
						UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						PetJournalEnhanced:SetZoneFilter()
						PetJournalEnhanced:UpdatePets()
					end 
			info.checked = function() return self.db.filtering.unknownZone end
			UIDropDownMenu_AddButton(info, level)
			
			
			
			for k,_ in orderedPairs(zoneTree) do
				info.hasArrow = true;
				info.notCheckable = true;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = k
				info.value = k
				info.func = 	nil
				info.checked = nil
				UIDropDownMenu_AddButton(info, level)
			end
			
			
		elseif UIDROPDOWNMENU_MENU_VALUE == 4 then --pet specialization
			local info = UIDropDownMenu_CreateInfo()
			
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
			info.keepShownOnClick = true
			info.text = CHECK_ALL
			info.func = function()
							for i=1,#self.db.filtering.specialization do self.db.filtering.specialization[i] = true end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for i=1,#self.db.filtering.specialization do self.db.filtering.specialization[i] = false end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			local specializations = {L["Balanced"],L["Fast"],L["Resilient"],L["Powerful"]}
			for i=1,4 do
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = specializations[i]
				info.func = 	function(_, _, _, value)
							self.db.filtering.specialization[i] = not self.db.filtering.specialization[i]
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							PetJournalEnhanced:UpdatePets()
							
						end 
				info.checked = function() return self.db.filtering.specialization[i] end
				UIDropDownMenu_AddButton(info, level)
			
			end
		
		elseif UIDROPDOWNMENU_MENU_VALUE == 5 then --sorting menu
			info.keepShownOnClick = true
			info.text = L["Sort favorites to the top"]
			info.func = 	function(_, _, _, value)
						self.db.sorting.favoritesFirst = not self.db.sorting.favoritesFirst
						PetJournalEnhanced.SortFunctions = PetJournalEnhanced:GetSortFunctions()
						UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						PetJournalEnhanced:UpdatePets()
					end 
			info.checked = function() return self.db.sorting.favoritesFirst end
			info.isNotRadio = true
			info.notCheckable = false		
			UIDropDownMenu_AddButton(info, level)
			
			info.keepShownOnClick = true
			info.text = L["Sort Order:"]
			info.func = nil;
			info.notCheckable = true		
			UIDropDownMenu_AddButton(info, level)
			
			info.notCheckable = false;	
			

			local sortTypes = {L["Level"],L["Alphabetical"],L["Pet Type"],L["Rarity"],L["Pet Highest Stat"]}--,["Added to Pet Journal"]=SORT_PETID}
			
			if Hooked.db.display.BreedInfo then
				table.insert(sortTypes,"Breed")
			end	
			
			--create sort menu options
			for i=1,#sortTypes do 
			
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = false
				info.text = sortTypes[i]
				info.func = 	function(_, _, _, value)
							
							self.db.sorting.selection = i
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							PetJournalEnhanced:UpdatePets()
						end 
				info.checked = function() return self.db.sorting.selection == i end
				UIDropDownMenu_AddButton(info, level)
			
			end
			
			info.keepShownOnClick = true
			info.checked = false
			info.isNotRadio = false
			
			
			info.text = L["Sort Direction:"]
			info.func = nil;
			info.notCheckable = true		
			UIDropDownMenu_AddButton(info, level)
			
			info.notCheckable = false;	
			info.text = L["Sort Ascending"]
			info.func = 	function(_, _, _, value)
						
						self.db.sorting.order = ASCENDING
						UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						PetJournalEnhanced:UpdatePets()
					end 
			info.checked = function() return self.db.sorting.order ==  ASCENDING end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = L["Sort Descending"]
			info.func = 	function(_, _, _, value)
						self.db.sorting.order = DESCENDING
						UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						PetJournalEnhanced:UpdatePets()
					end 
			info.checked = function() return  self.db.sorting.order == DESCENDING end
			UIDropDownMenu_AddButton(info, level)
		elseif UIDROPDOWNMENU_MENU_VALUE == 6 then
			local info = UIDropDownMenu_CreateInfo()
		
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
			info.keepShownOnClick = true
			info.text = CHECK_ALL
			info.func = function()
							for i=1,#self.db.filtering.rarity do self.db.filtering.rarity[i] = true end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 1, 2);
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for i=1,#self.db.filtering.rarity do self.db.filtering.rarity[i] = false end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 1, 2);
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			for i=1,4 do
				local r,g,b,hex  = GetItemQualityColor(i-1)
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = "|c"..hex.._G["BATTLE_PET_BREED_QUALITY"..i].."|r"
				info.func = 	function(_, _, _, value)
							self.db.filtering.rarity[i] = not self.db.filtering.rarity[i]
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							PetJournalEnhanced:UpdatePets()
							
						end 
				info.checked = function() return self.db.filtering.rarity[i] end
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end

	if level == 3  then
		local zoneTree = self.zoneTree
		if zoneTree[UIDROPDOWNMENU_MENU_VALUE] then
			local info = UIDropDownMenu_CreateInfo()
		
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
			info.keepShownOnClick = true
			info.text = CHECK_ALL
			info.func = function()
							for k,_ in pairs(zoneTree[UIDROPDOWNMENU_MENU_VALUE]) do
								zoneTree[UIDROPDOWNMENU_MENU_VALUE][k] = true
							end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,3)
							PetJournalEnhanced:SetZoneFilter()
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for k,_ in pairs(zoneTree[UIDROPDOWNMENU_MENU_VALUE]) do
								zoneTree[UIDROPDOWNMENU_MENU_VALUE][k] = false
							end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,3)
							PetJournalEnhanced:SetZoneFilter()
							PetJournalEnhanced:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			for k,_ in orderedPairs(zoneTree[UIDROPDOWNMENU_MENU_VALUE]) do
				info.hasArrow = false;
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = k
				info.value = k
				info.func = 	function(_, _, _, value)
							zoneTree[UIDROPDOWNMENU_MENU_VALUE][k] = not zoneTree[UIDROPDOWNMENU_MENU_VALUE][k]
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,3)
							PetJournalEnhanced:SetZoneFilter()
							PetJournalEnhanced:UpdatePets()
							
						end 
				info.checked = function() return zoneTree[UIDROPDOWNMENU_MENU_VALUE][k] end
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end

function Hooked.PetJournalFilterDropDown(self, level)
	Hooked:CreateDropdownMenu(level)
end
