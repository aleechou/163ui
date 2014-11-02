local Sorting = PetJournalEnhanced:NewModule("Sorting","AceEvent-3.0")
local BreedInfo  = LibStub("LibPetBreedInfo-1.0")
local BREED_HIGH_CONFIDENCE = 2
local MAX_BALANCED = 1
local MAX_SPEED = 2
local MAX_STAMINA = 3
local MAX_ATTACK = 4
local _
local ASCENDING =  1
local DESCENDING = 2
local USER = nil


petMapping = {}

local SetPet, GetPet
do
	local petStore = {}
	function SetPet(pet)
		if pet.isOwned then
			petStore[pet.petID] = pet
		else
			petStore[pet.speciesID] = pet
		end
	end

	function Sorting:GetPet(petID)
		return petStore[petID]
	end
end

local GetSortFunctions
do 

	local function GetCompareFunc(var,func,direction)
		return function(a,b)
			local order = Sorting.db.global.sorting.order
			local avar = a[var] 
			local bvar = b[var]
			if type(avar) == "boolean" then 
				avar = avar and 1 or 0
				bvar = bvar and 1 or 0 
			end
			
			if avar == bvar and func then 
				return func(a,b)
			end
			
			if direction then
				if direction == ASCENDING then
					return avar < bvar
				elseif  direction == DESCENDING then
					return avar > bvar
				end
			elseif  order == ASCENDING then
				return avar < bvar
			elseif order == DESCENDING then
				--if not avar or not bvar then print(avar,bvar,var) print(a.name,b.name) end
				return avar > bvar
			end
		end
	end

	local function ComposeSortFunction(...)
		local args = {...}
		local func = nil
		for i=#args,1,-2 do
			local name = args[i-1];
			local direction = args[i]
			func = GetCompareFunc(name,func,direction)
		end
		return func
	end

	local sortFunctions =  {
			ComposeSortFunction("isOwned",DESCENDING,"level",  USER,"name", ASCENDING),--level
			ComposeSortFunction("isOwned",DESCENDING,"name",   USER,"level",DESCENDING),--alpha
			ComposeSortFunction("isOwned",DESCENDING,"petType",USER,"level",DESCENDING,"name",ASCENDING),--pet type
			ComposeSortFunction("isOwned",DESCENDING,"rarity", USER,"level",DESCENDING,"name",ASCENDING),--rarity
			ComposeSortFunction("isOwned",DESCENDING,"maxStat",USER,"level",DESCENDING,"name",ASCENDING),--specialization
			ComposeSortFunction("isOwned",DESCENDING,"breed",USER,"level",DESCENDING,"name",ASCENDING),--specialization
		}
		
	local sortFunctionsFavoritesFirst =  {}
	for i=1,#sortFunctions do
		sortFunctionsFavoritesFirst[i] = GetCompareFunc("favorite",   sortFunctions[i],  DESCENDING)
	end
	
	function GetSortFunctions()
		if Sorting.sorting.favoritesFirst then
			return sortFunctionsFavoritesFirst
		else
			return sortFunctions
		end
	end
end



function Sorting:OnInitialize()
	self.ZoneFiltering = PetJournalEnhanced:GetModule("ZoneFiltering")
	self.callbacks = LibStub("CallbackHandler-1.0"):New(self)
	
	local defaults = {
		global = {
			filtering = {
				rarity = {[1]=true,[2]=true,[3]=true,[4]=true},
				breed = {[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true,[11]=true,[12]=true,},
				specialization = {[1]=true,[2]=true,[3]=true,[4]=true},
				level = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true},
				quantity = {[1]=true,[2]=true,[3]=true},
				currentZone = false,
				canBattle =true,
				cantBattle = true,
				unknownZone = true,
				cantTrade = true,
				canTrade = true,
				abilityType = {[1]=true,[2]=true,[3]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true},
				hiddenSpecies = false,
				favroitesOnly = false,
			},
			sorting = {
				selection = 1,
				order = ASCENDING,
				favoritesFirst = false,
			},
			hiddenSpecies = {},
		}
	}
	local db = LibStub("AceDB-3.0"):New("PetJournalEnhancedDB", {} , true)
	local name = self:GetName()
	self.db = db:RegisterNamespace(name, defaults)
	self.db.global.filtering.unknownZone = true --always reset to true
	self.filtering = self.db.global.filtering
	self.sorting = self.db.global.sorting
	
	--self:RegisterEvent("ZONE_CHANGED");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PET_JOURNAL_PET_DELETED")

	local LibPetJournal = LibStub("LibPetJournal-2.0")
	LibPetJournal.RegisterCallback(self,"PostPetListUpdated", "ScanPets")
	
	PetJournalSearchBox:HookScript("OnTextChanged",function()  Sorting:SortPets() end)
	hooksecurefunc(C_PetJournal,"SetFavorite",function() Sorting:UpdatePets() end)
end


function Sorting:IsSpeciesHidden(speciesID)
	--print(speciesID)
	if self.db.global.hiddenSpecies[speciesID] then
		return true
	end
end

function Sorting:SetSpeciesHidden(speciesID, hidden)
	self.db.global.hiddenSpecies[speciesID] = hidden
end

function Sorting:ResetSpeciesHidden()
	self.db.global.hiddenSpecies = {}
end

function Sorting:GetPetByIndex(index)
	return petMapping[index]
end

function Sorting:GetNumPets()
	return #petMapping
end

function Sorting:Reset()
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true)
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true);
	C_PetJournal.AddAllPetTypesFilter();
	C_PetJournal.AddAllPetSourcesFilter();
	
	self.ZoneFiltering:SetAllFiltered(true)
	
	local filtering = self.db.global.filtering
	local sorting = self.db.global.sorting
	
	for i=1,#filtering.rarity do
		filtering.rarity[i] = true
	end
	
	for i=1,#filtering.abilityType do
		filtering.abilityType[i] = true
	end
	
	for i=1,#filtering.level do
		filtering.level[i] = true
	end
	
	for i=1,#filtering.specialization do
		filtering.specialization[i] = true
	end
	
	for i=1,#filtering.quantity do
		filtering.quantity[i] = true
	end
	
	for i=1,#filtering.breed do
		filtering.breed[i] = true
	end
	
	filtering.currentZone = false
	filtering.canBattle = true
	filtering.cantBattle = true
	filtering.unknownZone = true
	filtering.canTrade = true
	filtering.cantTrade = true
	filtering.favoritesOnly = false;

	sorting.selection = 2
	sorting.order = ASCENDING
	sorting.favoritesFirst = false
	
	self:SortPets()
end

function Sorting:ScanPets()
	self:SortPets()
end

function Sorting:ZONE_CHANGED_NEW_AREA()
	
	if self.filtering.currentZone then
		self:SortPets()
	end
end

--[[function Sorting:ZONE_CHANGED()
	print("zone changed")
	if self.filtering.currentZone then
		self:SortPets()
	end
end]]

function Sorting:PETJOURNAL_ENHANCED_OPTIONS_UPDATE()
	self:SortPets()
end

function Sorting:PET_JOURNAL_PET_DELETED()
	self:SortPets()
end

do
	--Return highest stat for a pet. Check constants for return values.
	local function GetMaxStat(maxHealth,attack,speed)
		
		local maxHealth = tonumber(maxHealth)
		local stamina = tonumber(math.floor((maxHealth -100)/5))
		local attack = tonumber(attack)
		local speed = tonumber(speed)
		
		if attack > speed and attack > stamina then 
			return MAX_ATTACK 
		elseif speed > attack and speed > stamina  then 
			return MAX_SPEED 
		elseif stamina > attack and stamina > speed  then 
			return MAX_STAMINA 
		end
		return MAX_BALANCED
	end
	
	local function CreatePet(petID,speciesID,isOwned,name,petType,canBattle,tradable,rarity,level,sourceText,maxHealth, attack, speed)
		pet = {}
		pet.speciesID = speciesID
		pet.petID = petID 
		pet.isOwned = isOwned
		pet.name = name
		pet.petType = petType
		pet.canBattle = canBattle
		pet.tradable = tradable
		pet.rarity = rarity or 0				
		pet.maxStat = 0
		pet.abilityFilter = 0
		pet.breed = 0
		pet.breedConfidence = 0
		pet.level = level or 0
		pet.sourceText = sourceText
		
		if isOwned and canBattle and maxHealth and attack and speed then
			pet.maxStat = GetMaxStat(maxHealth,attack,speed)
			local breed, breedConfidence = BreedInfo:GetBreedByPetID(petID)
			if breed then
				pet.breed, pet.breedConfidence = breed, breedConfidence
			end
		end
		
		if canBattle then
			local abilityIDs = C_PetJournal.GetPetAbilityList(pet.speciesID);
			for j=1, #abilityIDs do
				local _,_,abilityType = C_PetJournal.GetPetAbilityInfo(abilityIDs[j]);
				pet.abilityFilter = bit.bor(pet.abilityFilter,2^abilityType);
			end
		else
			pet.level = 0
			pet.rarity = 0
			pet.petType = 0
		end
		return pet
	end
			
	local function UpdatePet(pet, level, favorite, index,rarity)
		pet.owned = C_PetJournal.GetNumCollectedInfo(pet.speciesID)
		pet.favorite = favorite
		pet.index = index
				
		
		if pet.canBattle and pet.isOwned then
			if pet.breedConfidence < BREED_HIGH_CONFIDENCE and level > pet.level then
				local breed, breedConfidence = BreedInfo:GetBreedByPetID(petID)
				if breed then
					pet.breed, pet.breedConfidence = breed, breedConfidence
				end
			end
			pet.level = level
			pet.rarity = rarity
		end
	end

	function Sorting:SortPets()
		--local start =  debugprofilestop()
		
		local numPets = C_PetJournal.GetNumPets(PetJournal.isWild)
		
		local ZoneFiltering = self.ZoneFiltering
		
		wipe(petMapping)

		local activeFilters = self:GetActiveFilters()
		
		for i=1,numPets do
			local petID, speciesID, isOwned, _, level, favorite, _, name, _, petType, _, sourceText, _, _, canBattle, tradable, _ = C_PetJournal.GetPetInfoByIndex(i, PetJournal.isWild)
			local health, maxHealth, attack, speed, rarity
			if petID then
				 health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats(petID)
			end
			
			
			local id = nil
			if isOwned then id = petID else id = speciesID end 
			local pet = self:GetPet(id)
			
			if not pet then
				
				
				pet = CreatePet(petID,speciesID,isOwned,name,petType,canBattle,tradable,rarity,level,sourceText,maxHealth, attack, speed)
				
				SetPet(pet)
			end
			
			UpdatePet(pet,level,favorite,i,rarity)
			
			--filter pet
			local exclude = false
			for i=1, #activeFilters do
				exclude = activeFilters[i]:exclude(pet) 
				if exclude then break end
			end

			if not exclude then
				table.insert(petMapping,pet)
			end
		end
		
		local sortFuncs =  GetSortFunctions()
		local sortFunc = sortFuncs[self.sorting.selection]
		table.sort(petMapping,sortFunc)
		self.callbacks:Fire("PETS_SORTED")
		
		--local stop =  debugprofilestop() - start
		--print(stop)
	end
	Sorting.UpdatePets = Sorting.SortPets
end
	
	
do 	
	local function BitwiseAndTable(tbl)
		local truth = true;
		for k,v in pairs(tbl) do
			truth = truth and v
		end
		return truth
	end
	
	local function InitializeFilters()

		local filtering = Sorting.filtering
		local sorting = Sorting.sorting
		local ZoneFiltering = Sorting.ZoneFiltering


		Sorting.filters = {
			--[[
			{
				initialize = function(self)  end,
				enabled = function(self) return false end,
				exclude = function(self,pet) return false end
			},
			]]
			{--can battle
				name = "can battle",
				enabled = function() return  not filtering.canBattle end,
				exclude = function(self,pet) return pet.canBattle end
			},
			{--can battle
				name = "favorites only",
				enabled = function() return  filtering.favoritesOnly end,
				exclude = function(self,pet) return not pet.favorite end
			},
			{--cant battle
				name = "cant battle",
				enabled = function() return not filtering.cantBattle end,
				exclude = function(self,pet)  return not pet.canBattle  end
			},
			{--can trade
				name = "can trade",
				enabled = function() return not filtering.canTrade end,
				exclude = function(self,pet)  return pet.tradable  end
			},
			{--cant trade
				name = "cant trade",
				enabled = function() return not filtering.cantTrade end,
				exclude = function(self,pet)  return not pet.tradable  end
			},
			{--rarity
				name = "rarity",
				enabled = function() return not BitwiseAndTable(filtering.rarity) end,
				exclude = function(self,pet)  return pet.rarity and pet.rarity > 0 and not filtering.rarity[pet.rarity] end
			},
			{--quantity
				name = "quantity",
				enabled = function() return not BitwiseAndTable(filtering.quantity) end,
				exclude = function(self,pet)  return pet.owned > 0 and not filtering.quantity[pet.owned] end
			},
			{--pet spec
				name = "pet spec",
				enabled = function() return not BitwiseAndTable(filtering.specialization) end,
				exclude = function(self,pet)  return pet.maxStat > 0 and  not filtering.specialization[pet.maxStat] end
			},
			{--current zone
				name = "current zone",
				initialize = function(self) self.currentZoneId =  GetCurrentMapAreaID() end,
				enabled = function() return filtering.currentZone end,
				exclude = function(self,pet) 
					local zones = ZoneFiltering:GetZonesBySpeciesID(pet.speciesID)
					return (zones == nil or not zones[self.currentZoneId]) 
				end
			},
			{--unknown zone
				name = "unknown zone",
				enabled = function() return not filtering.unknownZone end,
				exclude = function(self,pet)  return ZoneFiltering:GetZonesBySpeciesID(pet.speciesID) == nil end
			},
			{--breed
				name = "breed",
				enabled = function() return not BitwiseAndTable(filtering.breed) end,
				exclude = function(self,pet)  return pet.breed > 0 and  not filtering.breed[pet.breed] end
			},
			--[[{--level-1
				name = "level",
				enabled = function() return not BitwiseAndTable(filtering.level) end,
				exclude = function(self,pet) 
					return pet.level and
					(not filtering.level[1] and pet.level == 1) 					 or 
					(not filtering.level[2] and pet.level <= 10 and pet.level >=  2) or
					(not filtering.level[3] and pet.level <= 20 and pet.level >= 11) or
					(not filtering.level[4] and pet.level <= 24 and pet.level >= 20) or
					(not filtering.level[5] and pet.level == 25) 
				 end
			},]]
			
			{--ability filter
				name = "ability",
				abilityFilter = 0,
				initialize = function(self)  
					self.abilityFilter = 0
					for i=1,#filtering.abilityType do
						if filtering.abilityType[i] then
							self.abilityFilter = bit.bor(self.abilityFilter,2^i);
						end
					end 
				end,
				enabled = function() return not BitwiseAndTable(filtering.abilityType) end,
				exclude = function(self,pet)  return  pet.canBattle and bit.band(self.abilityFilter,pet.abilityFilter) == 0  end
			},
			{ --zone filtering
				name = "zone selection",
				enabled = function() return not ZoneFiltering:IsEveryZoneEnabled() end,
				exclude = function(self,pet) 
					local zones = ZoneFiltering:GetZonesBySpeciesID(pet.speciesID)
					if zones then
						local filtered = false
						for k,v in pairs(zones) do
							filtered = filtered or ZoneFiltering:GetFiltered(k)
						end
						return not filtered
					end
					return false
				end
			},
			{
				name = "hidden species",
				enabled = function() return not filtering.hiddenSpecies end,
				exclude = function(self,pet) 
					return Sorting:IsSpeciesHidden(pet.speciesID)
				end
			},
			
		}
		
		local levelRanges = {{1,1},{2,10},{11,20},{21,24},{25,25}}
		for i=1,#levelRanges do
			local filter = {
				name = "level "..levelRanges[i][1].."-"..levelRanges[i][2],
				enabled = function() return not filtering.level[i] end,
				exclude = function(self,pet) 
					return pet.level and pet.level >= levelRanges[i][1] and pet.level <=  levelRanges[i][2]
				 end
			}
			table.insert(Sorting.filters,filter)
		end
		
		
	end

	function Sorting:GetActiveFilters()
		if not self.filters then InitializeFilters() end
		local activeFilters = {}
		for i=1, #self.filters do
			if self.filters[i].initialize then self.filters[i]:initialize() end
			
			if self.filters[i].enabled() then 
				--print(self.filters[i].name or "Error: no filter name") 
				table.insert(activeFilters,self.filters[i])	
			end
		end
		return activeFilters
	end

end





