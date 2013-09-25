--partial class definition
local DropDown = PetJournalEnhanced:NewModule("DropDown")
local Config = PetJournalEnhanced:GetModule("Config")
local Sorting = PetJournalEnhanced:GetModule("Sorting") 
local _
local ASCENDING =  1
local DESCENDING = 2
local breedInfo = LibStub("LibPetBreedInfo-1.0")
local ZoneFiltering = PetJournalEnhanced:GetModule("ZoneFiltering")
local L =  LibStub("AceLocale-3.0"):GetLocale("PetJournalEnhanced")

local FILTER_CURRENT_ZONE = L["Filter pets by current zone"]
local FILTER_BREED = L["Breed"]
local FILTER_SHOW_HIDDEN = L["Show player hidden pets"]
local FILTER_RESET_HIDDEN = L["Reset player hidden pets"]
local FILTER_SORTING = L["Sorting"]
local FILTER_RESET = L["Reset Filters"]
local FILTER_CAN_BATTLE = L["Can Battle"]
local FILTER_CANT_BATTLE = L["Can't Battle"]
local FILTER_CAN_TRADE = L["Can Trade"]
local FILTER_CANT_TRADE = L["Can't Trade"]
local FILTER_UNKNOWN_ZONE = L["Unknown Zone"]
local FILTER_SORT_FAVORITES = L["Sort favorites to the top"]
local FILTER_SORT_DIRECTION  = L["Sort Direction:"]
local FILTER_SORT_ASCENDING = L["Sort Ascending"]
local FILTER_SORT_DESCENDING = L["Sort Descending"]

local FILTER_SORT_ORDER = L["Sort Order:"]
local levelBrackets = {"1","2-10","11-20","21-24","25"};
local specializations = {
	L["Balanced"],
	FAST,
	L["Resilient"],
	L["Powerful"],
}
local sortTypes = {
	LEVEL,
	NAME,
	TYPE,
	RARITY,
	L["Highest Stat"],
	}--,["Added to Pet Journal"]=SORT_PETID}
local FILTER_MENU_NAMES = {
	MISCELLANEOUS,
	LEVEL,
	L["Ability Type"],
	L["Zones"],
	QUALITY,
	SPECIALIZATION,
	L["Quantity"],
}

local FILTER_MENU_VALUES = {10,11,12,3,6,4,8}


local function CreateDropdownMenu(self,level)
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
							Sorting:UpdatePets()
							
						end 
		info.checked = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_COLLECTED);
		info.isNotRadio = true;
		UIDropDownMenu_AddButton(info, level)
		
		info.text = FAVORITES_FILTER
		info.func = 	function(_, _, _, value)
							C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, value);
							Sorting:UpdatePets()
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
							Sorting:UpdatePets()
						end 
		info.checked = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED);
		info.isNotRadio = true;
		UIDropDownMenu_AddButton(info, level)
		
		info.leftPadding = 0;
		info.disabled = nil;

		
		
		info.text = FILTER_CURRENT_ZONE
		info.func = 	function(_, _, _, value)
					
					Sorting.filtering.currentZone = not Sorting.filtering.currentZone
					Sorting:UpdatePets()
				end 
		info.checked = function() return Sorting.filtering.currentZone end
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
		
		for i=1,#FILTER_MENU_NAMES do
			info.text = FILTER_MENU_NAMES[i]
			info.value = FILTER_MENU_VALUES[i];
			UIDropDownMenu_AddButton(info, level)		
		end
		
		if Config.display.breedInfo then
			info.text = FILTER_BREED
			info.value = 9;
			UIDropDownMenu_AddButton(info, level)
		end
		info.text = FILTER_SORTING
		info.value = 5
		UIDropDownMenu_AddButton(info, level)
		
		
		
		local info = UIDropDownMenu_CreateInfo();
		info.notCheckable = true
		info.text = FILTER_RESET
		info.value = 7
		info.func = function() Sorting:Reset() end
		UIDropDownMenu_AddButton(info, level)
	end

	if level == 2 then	
		local info = UIDropDownMenu_CreateInfo();
		info.keepShownOnClick = true;	
		
		if Config.display.breedInfo and UIDROPDOWNMENU_MENU_VALUE == 9 then --breed filter
			
			info.notCheckable = true;
			info.text = CHECK_ALL
			info.func = function()
					for i=1,#Sorting.filtering.breed do 
						Sorting.filtering.breed[i] = true
					end

					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					Sorting:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
					for i=1,#Sorting.filtering.breed	do 
						Sorting.filtering.breed[i] = false
					end

					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					Sorting:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			
			for i,breedName in breedInfo:IterateBreedNames() do
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = breedName
				info.func = function(_, _, _, value)
							Sorting.filtering.breed[i] = not Sorting.filtering.breed[i]
							Sorting:UpdatePets()
						end 
				info.checked = function() return Sorting.filtering.breed[i] end
				UIDropDownMenu_AddButton(info, level)
				
			end	
		elseif UIDROPDOWNMENU_MENU_VALUE == 11 then -- Level filter
			
			info.notCheckable = true;
			info.text = CHECK_ALL
			info.func = function()
					for i=1,#Sorting.filtering.level	do 
						Sorting.filtering.level[i] = true
					end
					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					Sorting:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for i=1,#Sorting.filtering.level	do 
								Sorting.filtering.level[i] = false
							end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			
			info.notCheckable = false;	
			info.keepShownOnClick = true
			info.checked = false
			info.isNotRadio = true
			
			
			for i=1,#levelBrackets do
				info.text = levelBrackets[i]
				info.func = 	function(_, _, _, value)
									Sorting.filtering.level[i] = not Sorting.filtering.level[i]
									Sorting:UpdatePets()
								end 
				info.checked = function() return Sorting.filtering.level[i] end;
				info.isNotRadio = true;
				UIDropDownMenu_AddButton(info, level)
			end
			
			
		
		elseif UIDROPDOWNMENU_MENU_VALUE == 10 then -- misc filter
			
			info.notCheckable = true;
			info.text = CHECK_ALL
			info.func = function()
					Sorting.filtering.canBattle = true
					Sorting.filtering.cantBattle = true
					Sorting.filtering.canTrade = true
					Sorting.filtering.cantTrade = true
					
					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					Sorting:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
					Sorting.filtering.canBattle = false
					Sorting.filtering.cantBattle = false
					Sorting.filtering.canTrade = false
					Sorting.filtering.cantTrade = false
					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					Sorting:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			info.notCheckable = false;	
			info.keepShownOnClick = true
			info.checked = false
			info.isNotRadio = true
			
			 
			
			info.text = FILTER_CAN_BATTLE
			info.func = 	function(_, _, _, value)
								Sorting.filtering.canBattle = not Sorting.filtering.canBattle
								Sorting:UpdatePets()
							end 
			info.checked = function() return Sorting.filtering.canBattle end;
			info.isNotRadio = true;
			UIDropDownMenu_AddButton(info, level)
			
			info.text = FILTER_CANT_BATTLE
			info.func = 	function(_, _, _, value)
								Sorting.filtering.cantBattle = not Sorting.filtering.cantBattle
								Sorting:UpdatePets()
							end 
			info.checked = function() return Sorting.filtering.cantBattle end;
			info.isNotRadio = true;
			UIDropDownMenu_AddButton(info, level)
			
			info.text = FILTER_CAN_TRADE
			info.func = 	function(_, _, _, value)
						
						Sorting.filtering.canTrade = not Sorting.filtering.canTrade
						Sorting:UpdatePets()
					end 
			info.checked = function() return Sorting.filtering.canTrade end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = FILTER_CANT_TRADE
			info.func = 	function(_, _, _, value)
						
						Sorting.filtering.cantTrade = not Sorting.filtering.cantTrade
						Sorting:UpdatePets()
					end 
			info.checked = function() return Sorting.filtering.cantTrade end
			UIDropDownMenu_AddButton(info, level)
			
			
			info.text = FILTER_SHOW_HIDDEN
			info.func = 	function(_, _, _, value)
						Sorting.filtering.hiddenSpecies = not Sorting.filtering.hiddenSpecies
						Sorting:UpdatePets()
					end 
			info.checked = function() return Sorting.filtering.hiddenSpecies end
			UIDropDownMenu_AddButton(info, level)
			
			info.notCheckable = true;
			info.text = FILTER_RESET_HIDDEN
			info.func = 	function(_, _, _, value)
						Sorting:ResetSpeciesHidden()
						Sorting:UpdatePets()
					end 
			UIDropDownMenu_AddButton(info, level)
			
		elseif UIDROPDOWNMENU_MENU_VALUE == 12 then -- ability type filter
			
			info.notCheckable = true;
			info.text = CHECK_ALL
			info.func = function()
					for i=1,#Sorting.filtering.abilityType	do 
						Sorting.filtering.abilityType[i] = true
					end
					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					Sorting:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for i=1,#Sorting.filtering.abilityType	do 
								Sorting.filtering.abilityType[i] = false
							end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			for i=1, C_PetJournal.GetNumPetTypes() do
				
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = _G["BATTLE_PET_NAME_"..i]
				info.func = function(_, _, _, value)
							Sorting.filtering.abilityType[i] = not Sorting.filtering.abilityType[i]
							Sorting:UpdatePets()
						end 
				info.checked = function() return Sorting.filtering.abilityType[i] end
				UIDropDownMenu_AddButton(info, level)
			end
			
		
		elseif UIDROPDOWNMENU_MENU_VALUE == 8 then --quantity
			info.notCheckable = true;
			info.text = CHECK_ALL
			info.func = function()
					for i=1,#Sorting.filtering.quantity	do 
						Sorting.filtering.quantity[i] = true
					end
					UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
					Sorting:UpdatePets()
				end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for i=1,#Sorting.filtering.quantity	do 
								Sorting.filtering.quantity[i] = false
							end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			
			for i=1,#Sorting.filtering.quantity do
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = i
				info.func = function(_, _, _, value)
							Sorting.filtering.quantity[i] = not Sorting.filtering.quantity[i]
							Sorting:UpdatePets()
						end 
				info.checked = function() return Sorting.filtering.quantity[i] end
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
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							C_PetJournal.ClearAllPetTypesFilter();
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 1, 2);
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
		
			info.notCheckable = false;
			local numTypes = C_PetJournal.GetNumPetTypes();
			for i=1,numTypes do
				info.text = _G["BATTLE_PET_NAME_"..i];
				info.func = function(_, _, _, value)
							C_PetJournal.SetPetTypeFilter(i, value);
							Sorting:UpdatePets()
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
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							C_PetJournal.ClearAllPetSourcesFilter();
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 2, 2);
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
		
			info.notCheckable = false;
			local numSources = C_PetJournal.GetNumPetSources();
			for i=1,numSources do
				info.text = _G["BATTLE_PET_SOURCE_"..i];
				info.func = function(_, _, _, value)
							C_PetJournal.SetPetSourceFilter(i, value);
							Sorting:UpdatePets()
						end
				info.checked = function() return not C_PetJournal.IsPetSourceFiltered(i) end;
				UIDropDownMenu_AddButton(info, level);
			end
		
		elseif UIDROPDOWNMENU_MENU_VALUE == 3 then --zone filter
			local info = UIDropDownMenu_CreateInfo()
			local zoneTree = ZoneFiltering:GetZoneGroupMapping()
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
			info.keepShownOnClick = true
			info.text = CHECK_ALL
			info.func = function()
							ZoneFiltering:SetAllFiltered(true)
							Sorting.filtering.unknownZone = true
							Sorting:UpdatePets()
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							ZoneFiltering:SetAllFiltered(false)
							Sorting.filtering.unknownZone = false
							Sorting:UpdatePets()
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						end
			UIDropDownMenu_AddButton(info, level)
			
			local info = UIDropDownMenu_CreateInfo()
			info.notCheckable = false;	
			info.keepShownOnClick = true
			info.checked = false
			info.isNotRadio = true
			info.text = FILTER_UNKNOWN_ZONE 
			info.func = 	function(_, _, _, value)
						Sorting.filtering.unknownZone = not Sorting.filtering.unknownZone
						UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						Sorting:UpdatePets()
					end 
			info.checked = function() return Sorting.filtering.unknownZone end
			UIDropDownMenu_AddButton(info, level)
			
			local ZoneGroupMap = ZoneFiltering:GetZoneGroupMapping()
			for i=1,ZoneFiltering:GetNumZoneGroups() do
				info.hasArrow = true;
				info.notCheckable = true;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = ZoneFiltering:GetZoneGroupNames(i)
				info.value = i
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
							for i=1,#Sorting.filtering.specialization do Sorting.filtering.specialization[i] = true end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for i=1,#Sorting.filtering.specialization do Sorting.filtering.specialization[i] = false end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			
			for i=1,4 do
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = specializations[i]
				info.func = 	function(_, _, _, value)
							Sorting.filtering.specialization[i] = not Sorting.filtering.specialization[i]
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
							
						end 
				info.checked = function() return Sorting.filtering.specialization[i] end
				UIDropDownMenu_AddButton(info, level)
			
			end
		
		elseif UIDROPDOWNMENU_MENU_VALUE == 5 then --sorting menu
			info.keepShownOnClick = true
			info.text = FILTER_SORT_FAVORITES
			info.func = 	function(_, _, _, value)
						Sorting.sorting.favoritesFirst = not Sorting.sorting.favoritesFirst
						UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						Sorting:UpdatePets()
					end 
			info.checked = function() return Sorting.sorting.favoritesFirst end
			info.isNotRadio = true
			info.notCheckable = false		
			
			UIDropDownMenu_AddButton(info, level)
			
			info.keepShownOnClick = true
			info.text = FILTER_SORT_ORDER
			info.func = nil;
			info.notCheckable = true		
			UIDropDownMenu_AddButton(info, level)
			
			info.notCheckable = false;	
			
			
			
			
			
			--create sort menu options
			for i=1,#sortTypes do 
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = false
				info.text = sortTypes[i]
				info.func = 	function(_, _, _, value)
							
							Sorting.sorting.selection = i
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end 
				info.checked = function() return Sorting.sorting.selection == i end
				UIDropDownMenu_AddButton(info, level)
			end
			
			if Config.display.breedInfo then
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = false
				info.text = FILTER_BREED
				info.func = 	function(_, _, _, value)
							
							Sorting.sorting.selection = #sortTypes + 1
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end 
				info.checked = function() return Sorting.sorting.selection == #sortTypes + 1 end
				UIDropDownMenu_AddButton(info, level)
			end	
			
			info.keepShownOnClick = true
			info.checked = false
			info.isNotRadio = false
			
			info.text = FILTER_SORT_DIRECTION
			info.func = nil;
			info.notCheckable = true		
			UIDropDownMenu_AddButton(info, level)
			
			info.notCheckable = false;	
			info.text = FILTER_SORT_ASCENDING
			info.func = 	function(_, _, _, value)
						
						Sorting.sorting.order = ASCENDING
						UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						Sorting:UpdatePets()
					end 
			info.checked = function() return Sorting.sorting.order ==  ASCENDING end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = FILTER_SORT_DESCENDING
			info.func = 	function(_, _, _, value)
						Sorting.sorting.order = DESCENDING
						UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
						Sorting:UpdatePets()
					end 
			info.checked = function() return  Sorting.sorting.order == DESCENDING end
			UIDropDownMenu_AddButton(info, level)
		elseif UIDROPDOWNMENU_MENU_VALUE == 6 then
			local info = UIDropDownMenu_CreateInfo()
		
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
			info.keepShownOnClick = true
			info.text = CHECK_ALL
			info.func = function()
							for i=1,#Sorting.filtering.rarity do Sorting.filtering.rarity[i] = true end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 1, 2);
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							for i=1,#Sorting.filtering.rarity do Sorting.filtering.rarity[i] = false end
							UIDropDownMenu_Refresh(PetJournalFilterDropDown, 1, 2);
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			for i=1,4 do
				local r,g,b,hex  = GetItemQualityColor(i-1)
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = string.format("|c%s%s|r",hex,_G["BATTLE_PET_BREED_QUALITY"..i])
				info.func = 	function(_, _, _, value)
							Sorting.filtering.rarity[i] = not Sorting.filtering.rarity[i]
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end 
				info.checked = function() return Sorting.filtering.rarity[i] end
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end

	if level == 3  then
		if UIDROPDOWNMENU_MENU_VALUE >= 1 and UIDROPDOWNMENU_MENU_VALUE <= ZoneFiltering:GetNumZoneGroups() then
			local info = UIDropDownMenu_CreateInfo()
		
			info.hasArrow = false;
			info.isNotRadio = true;
			info.notCheckable = true;
			info.keepShownOnClick = true
			info.text = CHECK_ALL
			info.func = function()
							ZoneFiltering:SetAllGroupFiltered(UIDROPDOWNMENU_MENU_VALUE,true)
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			info.text = UNCHECK_ALL
			info.func = function()
							ZoneFiltering:SetAllGroupFiltered(UIDROPDOWNMENU_MENU_VALUE,false)
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end
			UIDropDownMenu_AddButton(info, level)
			
			
			local zoneIDs = ZoneFiltering:GetZoneGroup(UIDROPDOWNMENU_MENU_VALUE)
			for i=1, #zoneIDs do
				local zoneID = zoneIDs[i]
				info.hasArrow = false;
				info.notCheckable = false;	
				info.keepShownOnClick = true
				info.checked = false
				info.isNotRadio = true
				info.text = GetMapNameByID(zoneID)
				info.value = zoneID
				info.func = 	function(_, _, _, value)
							local isEnabled = ZoneFiltering:GetFiltered(zoneID)
							ZoneFiltering:SetFiltered(zoneID,not isEnabled)
							UIDropDownMenu_Refresh(PetJournalFilterDropDown,1,2)
							Sorting:UpdatePets()
						end 
				info.checked = function() return ZoneFiltering:GetFiltered(zoneID) end
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end

local function PetOptionsMenu_Init(self, level)
	local pet = DropDown.petOptionsMenu.pet
	local info = UIDropDownMenu_CreateInfo();
	info.notCheckable = true;
	
	local isRevoked = pet and pet.petID and C_PetJournal.PetIsRevoked(pet.petID);
	local isLockedForConvert = pet and pet.petID and C_PetJournal.PetIsLockedForConvert(pet.petID);
	
	
	if (pet and pet.petID and not isRevoked and not isLockedForConvert) then
		info.text = BATTLE_PET_SUMMON;
		if (pet.petID and C_PetJournal.GetSummonedPetGUID() == pet.petID) then
			info.text = PET_DISMISS;
		end
		info.func = function() C_PetJournal.SummonPetByGUID(pet.petID); end
		if (pet.petID and not C_PetJournal.PetIsSummonable(pet.petID)) then
			info.disabled = true;
		end
		UIDropDownMenu_AddButton(info, level);
		info.disabled = nil;
	end
	
	if (pet and pet.petID and not isRevoked and not isLockedForConvert) then
		info.text = BATTLE_PET_RENAME
		info.func = 	function() StaticPopup_Show("BATTLE_PET_RENAME", nil, nil, pet.petID); end 
		info.disabled = not C_PetJournal.IsJournalUnlocked();
		UIDropDownMenu_AddButton(info, level);
		info.disabled = nil;
	end

	local isFavorite = pet and pet.petID and C_PetJournal.PetIsFavorite(pet.petID);
	if pet and pet.petID and (isFavorite or (not isRevoked and not isLockedForConvert)) then
		if (isFavorite) then
			info.text = BATTLE_PET_UNFAVORITE;
			info.func = function() 
				C_PetJournal.SetFavorite(pet.petID, 0); 
			end
		else
			info.text = BATTLE_PET_FAVORITE;
			info.func = function() 
				C_PetJournal.SetFavorite(pet.petID, 1); 
			end
		end
		info.disabled = not C_PetJournal.IsJournalUnlocked();
		UIDropDownMenu_AddButton(info, level);
		info.disabled = nil;
	end
	
	if(pet and pet.petID and C_PetJournal.PetCanBeReleased(pet.petID)) then
		info.text = BATTLE_PET_RELEASE;
		info.func = function() StaticPopup_Show("BATTLE_PET_RELEASE", PetJournalUtil_GetDisplayName(pet.petID), nil, pet.petID); end
		if (C_PetJournal.PetIsSlotted(pet.petID) or C_PetBattles.IsInBattle() or not C_PetJournal.IsJournalUnlocked()) then
			info.disabled = true;
		else
			info.disabled = nil; 
		end
		UIDropDownMenu_AddButton(info, level);
		info.disabled = nil; 
	end

	if(pet and pet.petID and pet.petID and C_PetJournal.PetIsTradable(pet.petID)) then
		info.text = BATTLE_PET_PUT_IN_CAGE;
		info.func = function() StaticPopup_Show("BATTLE_PET_PUT_IN_CAGE", nil, nil, pet.petID); end
		--only if it isn't in a battle slot and has full health
		info.disabled = nil;
		if (not info.disabled and C_PetJournal.PetIsSlotted(pet.petID)) then
			info.disabled = true;
			info.text = BATTLE_PET_PUT_IN_CAGE_SLOTTED;
		end
		if (not info.disabled and C_PetJournal.PetIsHurt(pet.petID)) then
			info.disabled = true;
			info.text = BATTLE_PET_PUT_IN_CAGE_HEALTH;
		end
		UIDropDownMenu_AddButton(info, level)
		info.disabled = nil;
	end
	
	if (pet and pet.speciesID) then
		
		local isSpciesHidden = Sorting:IsSpeciesHidden(pet.speciesID)
		local hideSpeciesName = isSpciesHidden and SHOW or HIDE
		info.text = hideSpeciesName;
		info.func = function()
			Sorting:SetSpeciesHidden(pet.speciesID, not isSpciesHidden)
			Sorting:UpdatePets()
		end
		info.disabled = nil;
		UIDropDownMenu_AddButton(info, level)
	end
	
	info.text = CANCEL
	info.func = nil
	UIDropDownMenu_AddButton(info, level)
end

function DropDown:OnInitialize()
	PetJournalFilterButton:Hide()
	
	self.menuFrame = CreateFrame("Frame","PetJournalEnhancedFilterDropDown",PetJournal,"UIDropDownMenuTemplate");
	self.petOptionsMenu = CreateFrame("Frame","PetJournalEnhancedPetMenu",PetJournal,"UIDropDownMenuTemplate");
	self.filterButton = CreateFrame("Button","PetJournalEnhancedFilterButton",PetJournal,"UIMenuButtonStretchTemplate");
	self.filterButton:SetText(FILTER)
	self.filterButton.rightArrow:Show();
	self.filterButton:SetAllPoints("PetJournalFilterButton")

	UIDropDownMenu_Initialize(self.menuFrame, CreateDropdownMenu , "MENU")
	UIDropDownMenu_Initialize(self.petOptionsMenu, PetOptionsMenu_Init , "MENU")
	self.filterButton:SetScript("OnClick",function() PlaySound("igMainMenuOptionCheckBoxOn"); ToggleDropDownMenu(1, nil, self.menuFrame, "PetJournalEnhancedFilterButton", 74, 15); end)
end	