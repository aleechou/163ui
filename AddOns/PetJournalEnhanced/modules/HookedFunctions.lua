local COMPANION_BUTTON_HEIGHT = 46;
local MAX_ACTIVE_PETS = 3
local MAX_BALANCED = 1
local MAX_SPEED = 2
local MAX_STAMINA = 3
local MAX_ATTACK = 4
local _
local Hooked = PetJournalEnhanced:NewModule("Hooked")
local breedInfo = LibStub("LibPetBreedInfo-1.0")
local rarityFormat = "|c%s%s|r"

local function GetColor(confidence)
	local color = "|cffffcc00"
	if confidence < 2.5 then
		color = "|cff888888"
	end
	return color
end


function Hooked:SetHighStatShown(enabled)
	for i=1,#PetJournal.listScroll.buttons do
		button = PetJournal.listScroll.buttons[i] 
		self.highStatIcons[i]:Hide()
		button.name:ClearAllPoints()
		
		local buttonAnchor = "PetJournalListScrollFrameButton"..i
		if enabled then
			button.name:SetPoint("TOPLEFT",buttonAnchor,"TOPLEFT",10+self.highStatIcons[i]:GetWidth(),-2)
		else
			
			button.name:SetPoint("TOPLEFT",buttonAnchor,"TOPLEFT",12,-2)
		end
	end
end

function Hooked:Initialize(database)
	if not self.initialized then
		self.db = database.global
		
		self.highStatIcons = {}
		for i=1,#PetJournal.listScroll.buttons do
			button = PetJournal.listScroll.buttons[i] 
			local highStatIcon = button:CreateTexture(nil,"OVERLAY")
			
			highStatIcon:SetTexture("Interface\\PetBattles\\PetBattle-StatIcons")
			highStatIcon:SetTexCoord(0.0,0.5,0.0,0.5)
			highStatIcon:SetSize(12,12)
			
			highStatIcon:SetPoint("RIGHT",button.name,"LEFT",0,0)
			
			highStatIcon:SetDrawLayer("OVERLAY", 7)
			highStatIcon:Hide()
			
			self.highStatIcons[i] = highStatIcon
		end
	
		self:SetHighStatShown(self.db.display.maxStatIcon)
		
		local ZoneFiltering = PetJournalEnhanced:GetModule("ZoneFiltering")
		self.zoneTree = ZoneFiltering:GetZoneTree()
		UIDropDownMenu_Initialize(PetJournalFilterDropDown, self.PetJournalFilterDropDown , "MENU")
		
		--self:RegisterMessage("PETJOURNAL_ENHANCED_UPDATE")
		hooksecurefunc("PetJournal_UpdatePetCard", Hooked.PetJournal_UpdatePetCard)
		hooksecurefunc("PetJournal_UpdatePetLoadOut", Hooked.PetJournal_UpdatePetLoadOut)
		
		--PetJournal_UpdatePetCard = Hooked.PetJournal_UpdatePetCard
		--PetJournal_UpdatePetLoadOut = Hooked.PetJournal_UpdatePetLoadOut
		PetJournal_UpdatePetList = Hooked.PetJournal_UpdatePetList
		PetJournal.listScroll.update = Hooked.PetJournal_UpdatePetList
		PetJournal_ShowPetCard = Hooked.PetJournal_ShowPetCard
		PetJournal_FindPetCardIndex = Hooked.PetJournal_FindPetCardIndex
		PetJournal_SelectSpecies = Hooked.PetJournal_SelectSpecies
		PetJournal_SelectPet = Hooked.PetJournal_SelectPet
		PetJournal_ShowPetDropdown = Hooked.PetJournal_ShowPetDropdown
		
		--[[hooksecurefunc(PetJournal.listScroll,"update", Hooked.PetJournal_UpdatePetList)
		hooksecurefunc("PetJournal_ShowPetCard", Hooked.PetJournal_ShowPetCard)
		hooksecurefunc("PetJournal_FindPetCardIndex", Hooked.PetJournal_FindPetCardIndex)
		hooksecurefunc("PetJournal_SelectSpecies", Hooked.PetJournal_SelectSpecies)
		hooksecurefunc("PetJournal_SelectPet", Hooked.PetJournal_SelectPet)
		hooksecurefunc("PetJournal_UpdatePetList" , Hooked.PetJournal_UpdatePetList)
		hooksecurefunc("PetJournal_ShowPetDropdown" , Hooked.PetJournal_ShowPetDropdown)]]
		
		hooksecurefunc(C_PetJournal,"SetFavorite",Hooked.C_PetJournal_SetFavorite)
		PetJournalSearchBox:HookScript("OnTextChanged",function()  PetJournalEnhanced:UpdatePets() end)
		
		self.initialized = true
	end
end


function Hooked:Update()
	if PetJournal:IsShown() then
		self.PetJournal_FindPetCardIndex()
		self.PetJournal_UpdatePetList()
	end
end

function Hooked.PetJournal_UpdatePetCard(self)
	
	
	
	local speciesID, customName, level , name, canBattle,breedIndex,confidence
	
	if PetJournalPetCard.petID then 
		local petID = PetJournalPetCard.petID
		speciesID, customName, level , _, _, _, _, name,_, _, _, _, _, _, canBattle, _, _ = C_PetJournal.GetPetInfoByPetID(petID);
		if canBattle then
			local _, _, _, _, rarity = C_PetJournal.GetPetStats(petID);
			breedIndex, confidence = breedInfo:GetBreedByPetID(petID)
			
			if breedIndex and confidence then
				local health, power, speed  = breedInfo:GetPetPredictedStats(speciesID,breedIndex,rarity,25)
				local color = GetColor(confidence)
				
				--update breed info in pet cache
				local pjePet = PetJournalEnhanced:RetreivePet(petID)
				if pjePet then 
					pjePet.breed = breedIndex
					pjePet.breedConfidence = confidence
				end
			
				if Hooked.db.display.Extrapolate and level and level < 25 then
					local predictionFormat = "%s %s(%s)|r"
					
					local HealthText = self.HealthFrame.health:GetText()
					self.HealthFrame.health:SetText(string.format(predictionFormat,HealthText,color,health))
					
					local powerText = self.PowerFrame.power:GetText()
					self.PowerFrame.power:SetText(string.format(predictionFormat,powerText,color,power))
					
					local speedText = self.SpeedFrame.speed:GetText()
					self.SpeedFrame.speed:SetText(string.format(predictionFormat,speedText,color,speed))
				end
			end

			if rarity then
				local r, g, b,hex  = GetItemQualityColor(rarity-1)
				
				
				name = string.format(rarityFormat,hex,name)
				
				if customName then
					customName = string.format(rarityFormat,hex,customName)
				end
			end
			
			
		end
	elseif  PetJournalPetCard.speciesID then
		speciesID =  PetJournalPetCard.speciesID
		name, _, _, _, _, _, _, canBattle = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
	end
	
	if Hooked.db.display.breedInfo then
		local availableBreeds = breedInfo:GetAvailableBreeds(speciesID)
		if availableBreeds then
			
			local stringBuilder = {}
			for _,v in ipairs(availableBreeds) do tinsert(stringBuilder,breedInfo:GetBreedName(v)) end
			availableBreedsText = table.concat(stringBuilder,", ")
			wipe(stringBuilder)
			tinsert(stringBuilder,name)

			if breedIndex then
				local breedName = string.format("%s%s|r", GetColor(confidence),breedInfo:GetBreedName(breedIndex))
				tinsert(stringBuilder,breedName)
			end
			
			tinsert(stringBuilder,"|n|cffffcc00Available:")
			tinsert(stringBuilder,availableBreedsText)
			
			
			
			name = table.concat(stringBuilder," ")
		end
	end
	
	if customName then
		self.PetInfo.name:SetText(customName);
		self.PetInfo.name:SetHeight(24);
		self.PetInfo.subName:Show();
		self.PetInfo.subName:SetText(name);
	else
		self.PetInfo.name:SetWidth(225)
		self.PetInfo.name:SetText(name);
		self.PetInfo.name:SetHeight(32);
		self.PetInfo.subName:Hide();
	end
	
	if self.PetInfo.name:IsTruncated() then
		self.PetInfo.name:SetWidth(300)
		self.TypeInfo.type:SetText("")
	end
	
	
end

function Hooked.PetJournal_ShowPetDropdown(index, anchorTo, offsetX, offsetY)
	if not PetJournal:IsShown() then return end
	--print("PetJournal_ShowPetDropdown")
	if (not index) then
		return;
	end
	
	--modified original function here to use the pet mapping
	PetJournal.menuPetIndex = index --PetJournalEnhanced:GetPet(index)
	PetJournal.menuPetID = C_PetJournal.GetPetInfoByIndex(PetJournalEnhanced:GetPet(index));
	--print(C_PetJournal.GetPetInfoByIndex(PetJournalEnhanced:GetPet(index)))
	PetJournal_HidePetDropdown()
	ToggleDropDownMenu(1, nil, PetJournal.petOptionsMenu, anchorTo, offsetX, offsetY);
end

function Hooked.C_PetJournal_SetFavorite()
	PetJournalEnhanced:UpdatePets()
end

function Hooked.PetJournal_ShowPetCard(index)
	if not PetJournal:IsShown() then return end
	--print("PetJournal_ShowPetCard")
	PetJournal_HidePetDropdown();
	PetJournalPetCard.petIndex = index; --original mapping since wow uses this number for caging
	local owned;
	
	--modified original function here to use the pet mapping instead
	local pjeIndex = PetJournalEnhanced:GetPet(index)
	if pjeIndex then
		PetJournalPetCard.petID, PetJournalPetCard.speciesID, owned = C_PetJournal.GetPetInfoByIndex(pjeIndex, PetJournal.isWild);	
		if ( not owned ) then
			PetJournalPetCard.petID = nil;
		end
		PetJournal_UpdatePetCard(PetJournalPetCard);
		PetJournal_UpdatePetList();
		PetJournal_UpdateSummonButtonState();
	end
end

function Hooked.PetJournal_FindPetCardIndex()
	if not PetJournal:IsShown() then return end
	
	--local description = debugstack()
	--print("PetJournal_FindPetCardIndex")
	--print(description)
	
	PetJournalPetCard.petIndex = nil;
    --modified original function here to use the pet mapping instead
	local numPets = PetJournalEnhanced:GetNumPets()
	for i = 1, numPets do
		local petID, speciesID, owned = C_PetJournal.GetPetInfoByIndex(PetJournalEnhanced:GetPet(i),false);
		if (owned and petID == PetJournalPetCard.petID) or
			(not owned and speciesID == PetJournalPetCard.speciesID)  then
				PetJournalPetCard.petIndex = i;
				break;
		end
	end
	--
end

function Hooked.PetJournal_SelectSpecies(self, targetSpeciesID)
	if not PetJournal:IsShown() then return end
	--print("PetJournal_SelectSpecies")
	
	local petIndex = nil;
	 --modified original function here to use the pet mapping instead
	local numPets = PetJournalEnhanced:GetNumPets()
	for i = 1,numPets do
		local petID, speciesID, owned = C_PetJournal.GetPetInfoByIndex(PetJournalEnhanced:GetPet(i), isWild);
		if (speciesID == targetSpeciesID) then
			petIndex = i;
			break;
		end
	end
	--
	
	if ( petIndex ) then --might be filtered out and have no index.
		PetJournalPetList_UpdateScrollPos(self.listScroll, petIndex);
	end
	PetJournal_ShowPetCardBySpeciesID(targetSpeciesID);
end

local function IDtoString(id)
	if id and type(id)~="string" then
		id = format("%x",id)
		id = "0x"..string.rep("0",16-#id)..id
	end
	return id
end

function Hooked.PetJournal_SelectPet(self, targetPetID)
	if not PetJournal:IsShown() then return end
	--print("PetJournal_SelectPet")
	
	local petIndex = nil;
	 --modified original function here to use the pet mapping instead
	local numPets = PetJournalEnhanced:GetNumPets()
	for i = 1,numPets do
		local petID, speciesID, owned = C_PetJournal.GetPetInfoByIndex(PetJournalEnhanced:GetPet(i), isWild);
		if (petID == targetPetID) then
			petIndex = i;
			break;
		end
	end
	--
	
	if ( petIndex ) then --might be filtered out and have no index.
		PetJournalPetList_UpdateScrollPos(self.listScroll, petIndex);
	end
	PetJournal_ShowPetCardByID(IDtoString(targetPetID));
end

function Hooked.PetJournal_UpdatePetList()
	if not PetJournal:IsShown() then return end
	
	local scrollFrame = PetJournal.listScroll;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local petButtons = scrollFrame.buttons;
	local pet, index;
	
	local isWild = PetJournal.isWild;
	
	local numPets, numOwned = C_PetJournal.GetNumPets(isWild);
	PetJournal.PetCount.Count:SetText(numOwned);
	
	local summonedPetID = C_PetJournal.GetSummonedPetGUID();
	
	for i = 1,#petButtons do
		pet = petButtons[i];
		
		index = offset + i;
		if index <= #PetJournalEnhanced.petMapping then
			local petID, speciesID, isOwned, customName, level, favorite, isRevoked, name, icon, petType, creatureID, sourceText, description, isWildPet, canBattle = C_PetJournal.GetPetInfoByIndex(PetJournalEnhanced:GetPet(index), isWild);

			pet.icon:SetTexture(icon);
			pet.petTypeIcon:SetTexture(GetPetTypeTexture(petType));
			
			if (favorite) then
				pet.dragButton.favorite:Show();
			else
				pet.dragButton.favorite:Hide();
			end
			
			Hooked.highStatIcons[i]:Hide()
			
			if isOwned then
				local health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats(petID);
				
				--enable borders for non wild pets
				
				
				--compute and display max stat icon
				if Hooked.db.display.maxStatIcon then	
					if canBattle then
						local maxStat = PetJournalEnhanced.GetMaxStat(maxHealth,attack,speed)
						--texture is the same, were just setting what part were rendering
						--todo: move to a table of textures with precomputed texcoords
						if maxStat == MAX_BALANCED then
							Hooked.highStatIcons[i]:Hide()
						else
							if maxStat == MAX_ATTACK then
								Hooked.highStatIcons[i]:SetTexCoord(0.0,0.5,0.0,0.5)
							elseif maxStat == MAX_STAMINA then
								Hooked.highStatIcons[i]:SetTexCoord(0.5,1.0,0.5,1.0)
							elseif maxStat == MAX_SPEED then
								Hooked.highStatIcons[i]:SetTexCoord(0.0,0.5,0.5,1)
							end
							
							local h,w = Hooked.highStatIcons[i]:GetSize()
							
							--pet.highStat:SetSize(18,18)
							Hooked.highStatIcons[i]:Show()
						end
					end
				else
					Hooked.highStatIcons[i]:Hide()
				end
				
				
				
				
				
				
				--color the names by their rarity
				if Hooked.db.display.coloredNames and canBattle and rarity then
					local r, g, b,hex  = GetItemQualityColor(rarity-1)
					
					name = string.format(rarityFormat,hex,name)
					if customName then
						string.format(rarityFormat,hex,customName)
					end
				end
				
				

				pet.dragButton.levelBG:SetShown(canBattle);
				pet.dragButton.level:SetShown(canBattle);
				pet.dragButton.level:SetText(level);
				
				pet.icon:SetDesaturated(0);
				pet.name:SetFontObject("GameFontNormal");
				pet.petTypeIcon:SetShown(canBattle);
				pet.petTypeIcon:SetDesaturated(0);
				pet.dragButton:Enable();
				
				if (isWildPet) then
					pet.iconBorder:Show();
					pet.iconBorder:SetVertexColor(ITEM_QUALITY_COLORS[rarity-1].r, ITEM_QUALITY_COLORS[rarity-1].g, ITEM_QUALITY_COLORS[rarity-1].b);
				elseif rarity and Hooked.db.display.coloredBorders and canBattle then
					pet.iconBorder:SetVertexColor(ITEM_QUALITY_COLORS[rarity-1].r, ITEM_QUALITY_COLORS[rarity-1].g, ITEM_QUALITY_COLORS[rarity-1].b)
					pet.iconBorder:Show()
				else
					pet.iconBorder:Hide()
				end
				
				if (health and health <= 0) then
					pet.isDead:Show();
				else
					pet.isDead:Hide();
				end
				if(isRevoked == true) then
					pet.dragButton.levelBG:Hide();
					pet.dragButton.level:Hide();
					pet.iconBorder:Hide();
					pet.icon:SetDesaturated(1);
					pet.petTypeIcon:SetDesaturated(1);
					pet.dragButton:Disable();
				end
			else
				pet.dragButton.levelBG:Hide();
				pet.dragButton.level:Hide();
				pet.icon:SetDesaturated(1);
				pet.iconBorder:Hide();
				pet.name:SetFontObject("GameFontDisable");
				pet.petTypeIcon:SetShown(canBattle);
				pet.petTypeIcon:SetDesaturated(1);
				pet.dragButton:Disable();
				pet.isDead:Hide();
			end
			
			
			
			local pjePet =  PetJournalEnhanced:RetreivePet(petID)
			local breed = ""
			if Hooked.db.display.breedInfo and pjePet and pjePet.breed and pjePet.breed > 0 and pjePet.breedConfidence then
				breed = string.format("%s%s|r", GetColor(pjePet.breedConfidence),breedInfo:GetBreedName(pjePet.breed))
			end
			
			if customName then
				pet.name:SetText(string.format("%s %s",customName,breed))
				pet.name:SetHeight(12);
				pet.subName:Show();
				pet.subName:SetText(name);
			elseif name then
				pet.name:SetText(string.format("%s %s",name,breed))
				pet.name:SetHeight(30);
				pet.subName:Hide();
			else
				pet.name:SetText(nil)
				pet.name:SetHeight(30);
				pet.subName:Hide();
			end

			if ( petID and petID == summonedPetID ) then
				pet.dragButton.ActiveTexture:Show();
			else
				pet.dragButton.ActiveTexture:Hide();
			end

			pet.petID = petID;
			pet.speciesID = speciesID;
			pet.index = index;
			pet.owned = isOwned;
			pet:Show();
			
			--Update Petcard Button
			if PetJournalPetCard.petIndex == index then
				pet.selected = true;
				pet.selectedTexture:Show();
			else
				pet.selected = false;
				pet.selectedTexture:Hide()
			end
			
			
			
			
		else
			pet:Hide();
		end
	end
	
	local totalHeight = PetJournalEnhanced:GetNumPets() * COMPANION_BUTTON_HEIGHT;
	HybridScrollFrame_Update(scrollFrame, totalHeight, scrollFrame:GetHeight());
	
	
end

--color names of the active team of pets
function Hooked.PetJournal_UpdatePetLoadOut()
	if Hooked.db.display.coloredNames then
		for i=1, MAX_ACTIVE_PETS do
			local Pet = PetJournal.Loadout["Pet"..i]; 
			local petID, _, _, _, locked =  C_PetJournal.GetPetLoadOutInfo(i)
			if not locked and petID then
				local _, customName, _, _, _, _, _,name = C_PetJournal.GetPetInfoByPetID(petID)
				local rarity = select(5,C_PetJournal.GetPetStats(petID))
				local hex  = select(4,GetItemQualityColor(rarity-1))
				local breedIndex, confidence = breedInfo:GetBreedByPetID(petID)
				local breedName = Hooked.db.display.breedInfo and string.format("%s%s|r", GetColor(confidence),breedInfo:GetBreedName(breedIndex)) or ""

				if customName then
					Pet.subName:SetText(string.format(rarityFormat,hex,customName))
					Pet.name:SetText(string.format("|c%s%s|r%s",hex,name,breedName));
				else
					Pet.name:SetText(string.format("|c%s%s|r %s",hex,name,breedName));
				end
			end
		end
	end
end
