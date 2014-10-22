local COMPANION_BUTTON_HEIGHT = 46;
local MAX_ACTIVE_PETS = 3
local MAX_BALANCED = 1
local MAX_SPEED = 2
local MAX_STAMINA = 3
local MAX_ATTACK = 4
local _
local PetList = PetJournalEnhanced:NewModule("PetList","AceEvent-3.0")
local Config =  PetJournalEnhanced:GetModule("Config")
local Sorting = PetJournalEnhanced:GetModule("Sorting")
local DropDown = PetJournalEnhanced:GetModule("DropDown")

local breedInfo = LibStub("LibPetBreedInfo-1.0")

local L =  LibStub("AceLocale-3.0"):GetLocale("PetJournalEnhanced")

local rarityFormat = "|c%s%s|r"
local AVAILABLE = "|n|cffffcc00"..L["Available"]..":"


local function GetColor(confidence)
	local color = "|cffffcc00"
	if confidence < 2.5 then
		color = "|cff888888"
	end
	return color
end



function PetList:Update()
	self.PetJournal_FindPetCardIndex();
	self.PetJournal_UpdatePetList();
	PetJournal_UpdatePetLoadOut();
	self.PetJournal_UpdatePetCard(PetJournalPetCard);
	self.PetJournal_HidePetDropdown();
end

function PetList.PetJournal_HidePetDropdown()
	if (UIDropDownMenu_GetCurrentDropDown() == DropDown.petMenuFrame) then
		HideDropDownMenu(1);
	end
end


function PetList.PetJournalListItem_OnClick(self, button)
	if ( IsModifiedClick("CHATLINK") ) then
		local id = self.petID;
		if ( id and MacroFrame and MacroFrame:IsShown() ) then
			-- Macros are not yet supported
		elseif (id) then
			local petLink = C_PetJournal.GetBattlePetLink(id);
			ChatEdit_InsertLink(petLink);
		end
	elseif button == "RightButton" then
		--if self.owned then
			PetList.PetJournal_ShowPetDropdown(self.index, self, 80, 20);
		--end
	else
		local type, petID = GetCursorInfo();
		if type == "battlepet" then
			PetList.PetJournal_UpdatePetLoadOut();
			ClearCursor();
		else
			PetList.PetJournal_ShowPetCard(self.index);
		end
	end
	PetList:Update()
end


function PetList.PetJournalDragButton_OnClick(self, button)
	if ( IsModifiedClick("CHATLINK") ) then
		local id = self:GetParent().petID;
		if ( id and MacroFrame and MacroFrame:IsShown() ) then
			-- Macros are not yet supported
		elseif (id) then
			local petLink = C_PetJournal.GetBattlePetLink(id);
			ChatEdit_InsertLink(petLink);
		end
	elseif ( button == "RightButton" ) then
		local parent = self:GetParent();
		if ( parent.owned ) then
			PetList.PetJournal_ShowPetDropdown(parent.index, self, 0, 0);
		end
	else
		local type, petID = GetCursorInfo();
		if type == "battlepet" then
			PetList.PetJournal_UpdatePetLoadOut();
			ClearCursor();
		else
			PetJournalDragButton_OnDragStart(self);
		end
	end
end

function PetList:SetHighStatShown(enabled)
	for i=1,#self.listScroll.buttons do
		button = self.listScroll.buttons[i] 
		button.highStatIcon:SetShown(enabled)
		button.name:ClearAllPoints()
		
		local buttonAnchor = "PetJournalEnhancedListScrollFrameButton"..i
		if enabled then
			button.name:SetPoint("TOPLEFT",button.name:GetParent(),"TOPLEFT",5+button.highStatIcon:GetWidth(),-2)
		else
			button.name:SetPoint("TOPLEFT",buttonAnchor,"TOPLEFT",12,-2)
		end
	end
end

function PetList:PETJOURNAL_ENHANCED_OPTIONS_UPDATE()
	self:SetHighStatShown(Config.display.maxStatIcon)
	self:Update()
end

function PetList:PLAYER_REGEN_DISABLED()
	PetJournalSummonButton:Disable()
end

function PetList:PLAYER_REGEN_ENABLED()
	PetJournalSummonButton:Enable()
end

function PetList:OnInitialize()
	Sorting.RegisterCallback(self,"PETS_SORTED","Update")
	Config.RegisterCallback(self,"PETJOURNAL_ENHANCED_OPTIONS_UPDATE")
	
	--PetJournal:UnregisterAllEvents()
	PetJournalListScrollFrame:Hide()
	self.listScroll = CreateFrame("ScrollFrame","PetJournalEnhancedListScrollFrame",PetJournal,"HybridScrollFrameTemplate")
	self.listScroll:SetPoint("TOPLEFT",PetJournal.LeftInset,3,-36);
	self.listScroll:SetPoint("BOTTOMRIGHT",PetJournal.LeftInset,-2,5);
	
	self:RegisterEvent("PET_JOURNAL_LIST_UPDATE","Update")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	
	
	self.listScroll.scrollBar = CreateFrame("Slider","PetJournalEnhancedListScrollFrameScrollBar",self.listScroll,"HybridScrollBarTrimTemplate")
	self.listScroll.scrollBar:SetPoint("TOPLEFT",self.listScroll.scrollBar:GetParent(),"TOPRIGHT",4,20)
	self.listScroll.scrollBar:SetPoint("BOTTOMLEFT",self.listScroll.scrollBar:GetParent(),"BOTTOMRIGHT",4,11)
	self.listScroll.scrollBar.trackBG:Show();
	self.listScroll.scrollBar.trackBG:SetVertexColor(0, 0, 0, 0.75);
	
	self.listScroll.update = PetList.PetJournal_UpdatePetList
	self.listScroll.scrollBar.doNotHide = true;
	
	HybridScrollFrame_CreateButtons(self.listScroll, "CompanionListButtonTemplate", 44, 0);
	
	
	PetJournalPetCardPetInfo:SetScript("OnClick",nil)
	
	for i=1,#self.listScroll.buttons do
		local button = self.listScroll.buttons[i] 
		local dragButton = button.dragButton
		
		button:SetScript("OnClick",PetList.PetJournalListItem_OnClick)
		dragButton:SetScript("OnClick",PetList.PetJournalDragButton_OnClick)
		
		button.highStatIcon = button:CreateTexture(nil,"OVERLAY")
		button.highStatIcon:SetTexture("Interface\\PetBattles\\PetBattle-StatIcons")
		button.highStatIcon:SetTexCoord(0.0,0.5,0.0,0.5)
		button.highStatIcon:SetSize(12,12)
		button.highStatIcon:SetPoint("RIGHT",button.name,"LEFT",0,0)
		button.highStatIcon:SetParent(button)
		button.highStatIcon:SetDrawLayer("OVERLAY",7)
		button.highStatIcon:Show()
	
		dragButton.IsHidden = dragButton:CreateTexture(nil,"OVERLAY")
		dragButton.IsHidden:SetTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up")
		dragButton.IsHidden:SetSize(36,36)
		dragButton.IsHidden:SetPoint("CENTER",dragButton,"CENTER",0,0)
		dragButton.IsHidden:SetDrawLayer("OVERLAY",1)
	end
	
	self:SetHighStatShown(Config.display.maxStatIcon)
	
	hooksecurefunc("PetJournal_UpdatePetCard", PetList.PetJournal_UpdatePetCard)
	hooksecurefunc("PetJournal_ShowPetCard", PetList.PetJournal_ShowPetCard)
	hooksecurefunc("PetJournal_FindPetCardIndex", PetList.PetJournal_FindPetCardIndex)
	hooksecurefunc("PetJournal_SelectSpecies", PetList.PetJournal_SelectSpecies)
	hooksecurefunc("PetJournal_SelectPet", PetList.PetJournal_SelectPet)
	hooksecurefunc("PetJournal_UpdatePetLoadOut", PetList.PetJournal_UpdatePetLoadOut)
	
	
	
	
	
	
	
end


function PetList.PetJournal_UpdatePetCard(self)
	local speciesID, customName, level , name, canBattle,breedIndex,confidence
	if PetJournalPetCard.petID then 
		local petID = PetJournalPetCard.petID
		speciesID, customName, level , _, _, _, _, name,_, _, _, _, _, _, canBattle, _, _ = C_PetJournal.GetPetInfoByPetID(petID);
		if canBattle then
			local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID);
		
			if rarity then
				breedIndex, confidence = breedInfo:GetBreedByPetID(petID)
				if breedIndex and confidence then
					
					local pHealth, pPower, pSpeed  = breedInfo:GetPetPredictedStats(speciesID,breedIndex,rarity,25)
					local color = GetColor(confidence)
					
					--update breed info in pet cache
					local pjePet = Sorting:GetPet(petID)
					if pjePet then 
						pjePet.breed = breedIndex
						pjePet.breedConfidence = confidence
					end
				
					if Config.display.Extrapolate and level and level < 25  then
						local predictionFormat = "%s %s(%s)|r"
						self.HealthFrame.health:SetText(string.format(predictionFormat,maxHealth,color,pHealth))
						self.PowerFrame.power:SetText(string.format(predictionFormat,power,color,pPower))
						self.SpeedFrame.speed:SetText(string.format(predictionFormat,speed,color,pSpeed))
					end
				end

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
	
	if  Config.display.breedInfo then
		local availableBreeds = breedInfo:GetAvailableBreeds(speciesID)
		if availableBreeds then
			
			local stringBuilder = {}
			for _,v in ipairs(availableBreeds) do tinsert(stringBuilder,breedInfo:GetBreedName(v)) end
			local availableBreedsText = table.concat(stringBuilder,", ")
			wipe(stringBuilder)
			tinsert(stringBuilder,name)

			if breedIndex then
				local breedName = string.format("%s%s|r", GetColor(confidence),breedInfo:GetBreedName(breedIndex))
				tinsert(stringBuilder,breedName)
			end
			
			tinsert(stringBuilder,AVAILABLE)
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

function PetList.PetJournal_ShowPetDropdown(index, anchorTo, offsetX, offsetY)
	if (not index) then
		return;
	end
	
	DropDown.petOptionsMenu.pet = Sorting:GetPetByIndex(index)
	index = Sorting:GetPetByIndex(index).index;
	PetJournal.menuPetIndex = index
	PetJournal.menuPetID = C_PetJournal.GetPetInfoByIndex(index);
	
	ToggleDropDownMenu(1, nil, DropDown.petOptionsMenu, anchorTo, offsetX, offsetY);
end



function PetList.PetJournal_ShowPetCard(index)
	PetList.PetJournal_HidePetDropdown();
	PetJournalPetCard.petIndex = index;
	local owned;
	local pet = Sorting:GetPetByIndex(index)
	if pet then
		PetJournalPetCard.petID, PetJournalPetCard.speciesID, owned = C_PetJournal.GetPetInfoByIndex(pet.index, PetJournal.isWild);	
		if ( not owned ) then
			PetJournalPetCard.petID = nil;
			PetJournal_ShowPetCardBySpeciesID(PetJournalPetCard.speciesID);
			return;
		end
		PetJournal_UpdatePetCard(PetJournalPetCard);
		PetJournal_UpdatePetList();
		PetJournal_UpdateSummonButtonState();
	end
end



function PetList.PetJournal_SelectSpecies(self, targetSpeciesID)
	local petIndex = nil;
	local numPets = Sorting:GetNumPets()
	for i = 1,numPets do
		local pet = Sorting:GetPetByIndex(i)
		local petID, speciesID, owned = C_PetJournal.GetPetInfoByIndex(pet.index, isWild);
		if (speciesID == targetSpeciesID) then
			petIndex = i;
			break;
		end
	end
	if ( petIndex ) then
		PetJournalPetList_UpdateScrollPos(PetList.listScroll, petIndex);
	end
	PetJournal_ShowPetCardBySpeciesID(targetSpeciesID);
end




function PetList.PetJournal_UpdatePetList()
	
	local scrollFrame = PetList.listScroll;
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
		if index <= Sorting:GetNumPets() then
			
			local mappedPet = Sorting:GetPetByIndex(index)
			
			local petID, speciesID, isOwned, customName, level, favorite, isRevoked, name, icon, petType, creatureID, sourceText, description, isWildPet, canBattle = C_PetJournal.GetPetInfoByIndex(mappedPet.index, isWild);

			pet.icon:SetTexture(icon);
			pet.petTypeIcon:SetTexture(GetPetTypeTexture(petType));
			
			
			pet.dragButton.favorite:SetShown(favorite)
			
			local isHidden = Sorting:IsSpeciesHidden(speciesID)
			pet.dragButton.IsHidden:SetShown(isHidden)
			
			pet.highStatIcon:Hide()
			if isOwned then
				local health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats(petID);
				
				--enable borders for non wild pets
				
				
				--compute and display max stat icon
				if Config.display.maxStatIcon then	
					pet.highStatIcon:Hide()
					if canBattle then
						local maxStat = mappedPet.maxStat
						--texture is the same, were just setting what part were rendering
						--todo: move to a table of textures with precomputed texcoords
						if maxStat == MAX_BALANCED then
							
						else
							if maxStat == MAX_ATTACK then
								pet.highStatIcon:SetTexCoord(0.0,0.5,0.0,0.5)
							elseif maxStat == MAX_STAMINA then
								pet.highStatIcon:SetTexCoord(0.5,1.0,0.5,1.0)
							elseif maxStat == MAX_SPEED then
								pet.highStatIcon:SetTexCoord(0.0,0.5,0.5,1)
							end
							
							local h,w = pet.highStatIcon:GetSize()
							
							--pet.highStat:SetSize(18,18)
							pet.highStatIcon:Show()
						end
					end
				else
					pet.highStatIcon:Hide()
				end
				
				
				
				
				
				
				--color the names by their rarity
				if Config.display.coloredNames and canBattle and rarity then
					local r, g, b,hex  = GetItemQualityColor(rarity-1)
					
					name = string.format(rarityFormat,hex,name)
					if customName then
						string.format(rarityFormat,hex,customName)
					end
				end
				
				

				pet.dragButton.levelBG:SetShown(canBattle);
				pet.dragButton.level:SetShown(canBattle);
				pet.dragButton.level:SetText(level);
				
				pet.icon:SetDesaturated(false);
				pet.name:SetFontObject("GameFontNormal");
				pet.petTypeIcon:SetShown(canBattle);
				pet.petTypeIcon:SetDesaturated(false);
				pet.dragButton:Enable();
				
				if (isWildPet) then
					pet.iconBorder:Show();
					pet.iconBorder:SetVertexColor(ITEM_QUALITY_COLORS[rarity-1].r, ITEM_QUALITY_COLORS[rarity-1].g, ITEM_QUALITY_COLORS[rarity-1].b);
				elseif rarity and Config.display.coloredBorders and canBattle then
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
					pet.icon:SetDesaturated(true);
					pet.petTypeIcon:SetDesaturated(true);
					pet.dragButton:Disable();
				end
			else
				pet.dragButton.levelBG:Hide();
				pet.dragButton.level:Hide();
				pet.icon:SetDesaturated(true);
				pet.iconBorder:Hide();
				pet.name:SetFontObject("GameFontDisable");
				pet.petTypeIcon:SetShown(canBattle);
				pet.petTypeIcon:SetDesaturated(true);
				pet.dragButton:Disable();
				pet.isDead:Hide();
			end
			
			
			
			local pjePet =  Sorting:GetPet(petID)
			local breed = ""
			if Config.display.breedInfo and pjePet and pjePet.breed and pjePet.breed > 0 and pjePet.breedConfidence then
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
	
	local totalHeight = Sorting:GetNumPets() * COMPANION_BUTTON_HEIGHT;
	HybridScrollFrame_Update(scrollFrame, totalHeight, scrollFrame:GetHeight());
end



function PetList.PetJournal_FindPetCardIndex()
	PetJournalPetCard.petIndex = nil;
	local numPets = Sorting:GetNumPets()
	for i = 1, numPets do
		local pet = Sorting:GetPetByIndex(i);
		local petID, speciesID, owned = C_PetJournal.GetPetInfoByIndex(pet.index,false);
		if (owned and petID == PetJournalPetCard.petID) or
			(not owned and speciesID == PetJournalPetCard.speciesID)  then
				PetJournalPetCard.petIndex = i;
				break;
		end
	end
end







function PetList.PetJournal_SelectPet(self, targetPetID) 
	local pet, index
	for i =1 , Sorting:GetNumPets() do
		pet = Sorting:GetPetByIndex(i)
		if pet.petID == targetPetID then
			pet = pet
			index = i
			break
		end
	end
	
	if pet then
		if ( index ) then --might be filtered out and have no index.
			PetJournalPetList_UpdateScrollPos(PetList.listScroll, index);
		end
		PetJournal_ShowPetCardByID(targetPetID);
	end
end



function PetList.PetJournal_UpdatePetLoadOut() 
	if Config.display.coloredNames then
		for i=1, MAX_ACTIVE_PETS do
			local Pet = PetJournal.Loadout["Pet"..i]; 
			local petID, _, _, _, locked =  C_PetJournal.GetPetLoadOutInfo(i)
			if not locked and petID then
				local _, customName, _, _, _, _, _,name = C_PetJournal.GetPetInfoByPetID(petID)
				local rarity = select(5,C_PetJournal.GetPetStats(petID))
				local hex  = select(4,GetItemQualityColor(rarity-1))
				local breedIndex, confidence = breedInfo:GetBreedByPetID(petID)
				
				local breedName =  (breedIndex and confidence --[[and PetList.db.display.breedInfo]]) and string.format("%s%s|r", GetColor(confidence),breedInfo:GetBreedName(breedIndex)) or ""
				
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