-- $Id: AtlasIntegration.lua 4213 2013-05-22 11:24:37Z lag123 $
--[[
self file contains all the Atlas specific functions
]]
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
--Establish number of boss lines in the Atlas frame for scrolling
local ATLAS_LOOT_BOSS_LINES	= 24;

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffcc3333";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

StaticPopupDialogs["ATLASLOOT_INCOMPATIBLE_ATLAS"] = {
	text = "Please note that AtlasLoot v6.05.01 is only compatible with Atlas 1.21.0. AtlasLoot detected that you have an older Atlas version installed and thus Atlas integration was disabled.",
	button1 = AL["OK"],
	OnAccept = function()
		
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

-- This function sets up the Atlas specific XML objects
function AtlasLoot:SetupForAtlas()
	if not AtlasFrame then return end
	--Anchor the loot table to the Atlas frame
	AtlasLoot:SetItemInfoFrame("Atlas");
	AtlasLootItemsFrame:Hide();
	AtlasLoot_AnchorFrame = AtlasFrame;	
	AtlasLoot.AtlasLootPanel:SetParent(AtlasFrame)
	AtlasLoot.AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, 9)
	AtlasLoot.AtlasInfoFrame:SetParent(AtlasFrame)
	AtlasLoot.AtlasInfoFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 535, -37)
	AtlasLoot.AtlasInfoFrame:Show()
end

function AtlasLoot:AtlasInitialize()
	local curAtlas = string.gsub(ATLAS_VERSION or "0", "%.", "")
	curAtlas = tonumber(curAtlas)
	ATLASLOOT_MIN_ATLAS = string.gsub(ATLASLOOT_MIN_ATLAS or "0", "%.", "")
	ATLASLOOT_MIN_ATLAS = tonumber(ATLASLOOT_MIN_ATLAS)
	if ATLASLOOT_MIN_ATLAS <= curAtlas then
		if (ATLASLOOT_DEBUGMESSAGES) then
			print(ATLASLOOT_MIN_ATLAS, ", ", curAtlas)
		end
		local AtlasCheck = false;
		--Figure out if it is a compatible Atlas version
		for i=1,#ATLASLOOT_CURRENT_ATLAS do
			if ATLAS_VERSION == ATLASLOOT_CURRENT_ATLAS[i] then
				AtlasCheck = true;
				AtlasLoot.db.profile.AtlasType = "Release"
			end
		end
		for i=1,#ATLASLOOT_PREVIEW_ATLAS do
			if ATLAS_VERSION == ATLASLOOT_PREVIEW_ATLAS[i] then
				AtlasCheck = true;
				AtlasLoot.db.profile.AtlasType = "Preview"
				AtlasLoot:LootTableRegister_Merge()
			end
		end
		if AtlasCheck == false then
			AtlasLoot.db.profile.AtlasType = "Unknown"
		end
		
		--Legacy code for those using the ultimately failed attempt at making Atlas load on demand
		if AtlasButton_LoadAtlas then
			AtlasButton_LoadAtlas()
		end
		
		AtlasLoot:RegisterPFrame("Atlas", { "TOPLEFT", "AtlasFrame", "TOPLEFT", "18", "-84" })

		--Hook the necessary Atlas functions
		Hooked_Atlas_Refresh = Atlas_Refresh
		Atlas_Refresh = AtlasLoot.AtlasRefreshHook
		Hooked_Atlas_OnShow = Atlas_OnShow
		Atlas_OnShow = AtlasLoot.Atlas_OnShow
		
		--Instead of hooking, replace the scrollbar driver function 
		Hooked_AtlasScrollBar_Update = AtlasScrollBar_Update
		AtlasScrollBar_Update = AtlasLoot.AtlasScrollBar_Update
		
	else
		if ATLAS_VERSION and ATLASLOOT_MIN_ATLAS ~= AtlasLoot.db.profile.LastMinAtlasVersion then
			AtlasLoot.db.profile.LastMinAtlasVersion = ATLASLOOT_MIN_ATLAS
			StaticPopup_Show("ATLASLOOT_INCOMPATIBLE_ATLAS")			
		end
		AtlasLoot.AtlasRefreshHook = nil
		AtlasLoot.Atlas_OnShow = nil
		AtlasLoot.AtlasScrollBar_Update = nil
		AtlasLoot.SetupForAtlas = nil
		AtlasLoot.Atlas_SetBoss = nil
		AtlasLoot.Boss_OnClick = nil
		AtlasLoot.AtlasInitialize = nil
	end
end

-- Hooks Atlas_OnShow() to add extra setup routines that AtlasLoot needs for
-- integration purposes.
function AtlasLoot:Atlas_OnShow()
	Atlas_Refresh();
	
	--We don't want Atlas and the Loot Browser open at the same time, so the Loot Browser is close
	if AtlasLootDefaultFrame then
		AtlasLootDefaultFrame:Hide();
		AtlasLoot:SetupForAtlas();
	end
	--Call the Atlas function
	Hooked_Atlas_OnShow();
	--If we were looking at a loot table earlier in the session, it is still
	--saved on the item frame, so restore it in Atlas
	if AtlasLootItemsFrame.activeBoss ~= nil then
		AtlasLootItemsFrame:Show();
	else
		--If no loot table is selected, set up icons next to boss names
		for i=1,ATLAS_CUR_LINES do
			if (_G["AtlasEntry"..i.."_Selected"] and _G["AtlasEntry"..i.."_Selected"]:IsVisible()) then
				_G["AtlasEntry"..i.."_Loot"]:Show();
				_G["AtlasEntry"..i.."_Selected"]:Hide();
			end
		end
	end
	--Consult the saved variable table to see whether to show the bottom panel
	if AtlasLoot.db.profile.HidePanel == true then
		AtlasLootPanel:Hide();
	else
		AtlasLootPanel:Show();
	end 
	
	pFrame = AtlasFrame;
end


-- Replacement for Atlas_Refresh, required as the template for the boss buttons in Atlas is insufficient
-- Called whenever the state of Atlas changes
function AtlasLoot:AtlasRefreshHook()
	--Reset which loot page is 'current'
	AtlasLootItemsFrame.activeBoss = nil;

	--Get map selection info from Atlas
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local data = AtlasMaps;
	local Atlastextbase = {};
	
	--Get boss name information
	for k,v in pairs(data[zoneID]) do
		Atlastextbase[k] = v;
	end
	
	Atlas_MapRefresh();

	-- Check Tables
	local contentTable = "Instances"
	for k,v in pairs(AtlasLoot_LootTableRegister) do
		if AtlasLoot_LootTableRegister[k][zoneID] then
			contentTable = k
			break
		end
	end

	-- Allow AtlasLoot to append any extra 'boss' entries needed to a map
	if AtlasLoot_LootTableRegister[contentTable][zoneID] ~= nil then
		local numContent = #Atlastextbase
		local LootTable = AtlasLoot:GetBossTableZoneID(zoneID)
		for k,v in ipairs(LootTable) do
			if v[1] and type(v[1]) == "string" and AtlasLoot:FormatDataID(v[1]) then
				local bossname = AtlasLoot:GetTableInfo(v[1])
				if v[2] and type(v[2]) == "number" then 
					if v[2] and not Atlastextbase[v[2]] then
						local missLines = v[2] - numContent + 1
							
						if not Atlastextbase[v[2]] or Atlastextbase[v[2]] == "" then
							-- Fills missed Lines with empty lines
							if missLines > 0 then
								for _ = 1,missLines do
									numContent = numContent + 1
									if not Atlastextbase[numContent] then
										Atlastextbase[numContent]={"", nil, nil}
									end
								end
							end
							-- Sets the Text
							Atlastextbase[v[2]]={WHITE..ATLASLOOT_INDENT..bossname, nil, nil}
						end
					elseif v[2] and Atlastextbase[v[2]][1] == "" then
						Atlastextbase[v[2]]={WHITE..ATLASLOOT_INDENT..bossname, nil, nil}
					end
				elseif v[2] and type(v[2]) == "table" then
					for k2,v2 in ipairs(v[2]) do
						if v2 and not Atlastextbase[v2] then
							local missLines = v2 - numContent + 1						
								
							if not Atlastextbase[v2] or Atlastextbase[v2] == "" then
								-- Fills missed Lines with empty lines
								if missLines > 0 then
									for _ = 1,missLines do
										numContent = numContent + 1
										if not Atlastextbase[numContent] then
											Atlastextbase[numContent]={"", nil, nil}
										end
									end
								end
								-- Sets the Text
								Atlastextbase[v2]={WHITE..ATLASLOOT_INDENT..v[1], nil, nil}
							end
						elseif v2 and Atlastextbase[v2][1] == "" then
							Atlastextbase[v2]={WHITE..ATLASLOOT_INDENT..v[1], nil, nil}
						end
					end
				end
			end
		end
		Atlastextbase[numContent+1]={"", nil, nil};
	end
	
	--Hide any Atlas objects lurking around that have now been replaced
	for i=1,ATLAS_CUR_LINES do
		if ( _G["AtlasEntry"..i] ) then
			_G["AtlasEntry"..i]:Hide();
		end
	end
	
	ATLAS_DATA = Atlastextbase;
	ATLAS_SEARCH_METHOD = data.Search;
	--Deal with Atlas's search function
	if ( data.Search == nil ) then
		ATLAS_SEARCH_METHOD = AtlasSimpleSearch;
	end
	
	if ( data.Search ~= false ) then
		AtlasSearchEditBox:Show();
		AtlasNoSearch:Hide();
	else
		AtlasSearchEditBox:Hide();
		AtlasNoSearch:Show();
		ATLAS_SEARCH_METHOD = nil;
	end

	--populate the scroll frame entries list, the update func will do the rest
	--Atlas_Search("");
	--AtlasSearchEditBox:SetText("");
	--AtlasSearchEditBox:ClearFocus();
	
	--create and align any new entry buttons that we need
	if not AtlasLoot.AtlasLines then AtlasLoot.AtlasLines = {} end
	for i=1,#ATLAS_DATA do
		if not AtlasLoot.AtlasLines[i] then
			if i==1 then
				AtlasLoot.AtlasLines[i] = AtlasLoot:CreateSelectBossLineButton(AtlasFrame, {"TOPLEFT", "AtlasScrollBar", "TOPLEFT", 16, -3}, "AtlasBossLine"..i)
			else
				AtlasLoot.AtlasLines[i] = AtlasLoot:CreateSelectBossLineButton(AtlasFrame, {"TOPLEFT", "AtlasBossLine"..(i-1), "BOTTOMLEFT"}, "AtlasBossLine"..i)
			end
			AtlasLoot.AtlasLines[i]:SetScript("OnClick", AtlasLoot.Boss_OnClick)
			-- added by arith on June 27, 2011
			-- the Control key with mouse hover to each bose line need to be added back
			AtlasLoot.AtlasLines[i]:SetScript("OnUpdate", AtlasEntryTemplate_OnUpdate)
			AtlasLoot.AtlasLines[i]:SetScript("OnLeave", GameTooltip_Hide)
		else
			AtlasLoot.AtlasLines[i].Loot:Hide()
			AtlasLoot.AtlasLines[i].Selected:Hide()
		end
	end

	--Hide the loot frame now that a pristine Atlas instance is created
	AtlasLootItemsFrame:Hide();
	Atlas_Search("");
	--Make sure the scroll bar is correctly offset
	AtlasLoot:AtlasScrollBar_Update()
	
	--see if we should display the entrance/instance button or not, and decide what it should say
	local matchFound = {nil};
	local sayEntrance = nil;
	for k,v in pairs(Atlas_EntToInstMatches) do
		if ( k == zoneID ) then
			matchFound = v;
			sayEntrance = false;
		end
	end
	if ( not matchFound[1] ) then
		for k,v in pairs(Atlas_InstToEntMatches) do
			if ( k == zoneID ) then
				matchFound = v;
				sayEntrance = true;
			end
		end
	end
	
	--set the button's text, populate the dropdown menu, and show or hide the button
	if ( matchFound[1] ~= nil ) then
		ATLAS_INST_ENT_DROPDOWN = {};
		for k,v in pairs(matchFound) do
			table.insert(ATLAS_INST_ENT_DROPDOWN, v);
		end
		table.sort(ATLAS_INST_ENT_DROPDOWN, AtlasSwitchDD_Sort);
		if ( sayEntrance ) then
			AtlasSwitchButton:SetText(ATLAS_ENTRANCE_BUTTON);
		else
			AtlasSwitchButton:SetText(ATLAS_INSTANCE_BUTTON);
		end
		AtlasSwitchButton:Show();
		UIDropDownMenu_Initialize(AtlasSwitchDD, AtlasSwitchDD_OnLoad);
	else
		AtlasSwitchButton:Hide();
	end
	
	if ( TitanPanelButton_UpdateButton ) then
		TitanPanelButton_UpdateButton("Atlas");
	end
end

-- Hooks the Atlas scroll frame.  
-- Required as the Atlas function cannot deal with the AtlasLoot button template or the added Atlasloot entries
function AtlasLoot:AtlasScrollBar_Update()
	local line, lineplusoffset;
	if (_G["AtlasBossLine1_Text"] ~= nil) then
		local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
		--Update the contents of the Atlas scroll frame
		FauxScrollFrame_Update(AtlasScrollBar,ATLAS_CUR_LINES,ATLAS_LOOT_BOSS_LINES,15);
		-- Check Tables
		local contentTable = "Instances"
		for k,v in pairs(AtlasLoot_LootTableRegister) do
			if AtlasLoot_LootTableRegister[k][zoneID] then
				contentTable = k
				break
			end
		end

		--Make note of how far in the scroll frame we are
		for line=1,ATLAS_NUM_LINES do
			lineplusoffset = line + FauxScrollFrame_GetOffset(AtlasScrollBar);
			if ( lineplusoffset <= ATLAS_CUR_LINES ) then
				AtlasLoot.AtlasLines[line].Text:SetText(ATLAS_SCROLL_LIST[lineplusoffset]);
				AtlasLoot.AtlasLines[line].Loot:Hide();
				AtlasLoot.AtlasLines[line].Selected:Hide();
				AtlasLoot.AtlasLines[line].Boss = nil
				if AtlasLootItemsFrame.activeBoss == lineplusoffset then
					AtlasLoot.AtlasLines[line].Loot:Hide();
					AtlasLoot.AtlasLines[line].Selected:Show();
				else
					local LootTable = AtlasLoot:GetBossTableZoneID(zoneID)
					--if AtlasLoot_LootTableRegister[contentTable][zoneID] and AtlasLoot_LootTableRegister[contentTable][zoneID]["Bosses"] then
					if LootTable then
						for k,v in ipairs(LootTable) do
							if v[2] and type(v[2]) == "number" then
								if v[2] == lineplusoffset then
									AtlasLoot.AtlasLines[line].Loot:Show()
									AtlasLoot.AtlasLines[line].Selected:Hide()
									AtlasLoot.AtlasLines[line].Boss = v[1]
									break
								end
							elseif v[2] and type(v[2]) == "table" then
								for k2,v2 in ipairs(v[2]) do
									if v2 == lineplusoffset then
										AtlasLoot.AtlasLines[line].Loot:Show()
										AtlasLoot.AtlasLines[line].Selected:Hide()
										AtlasLoot.AtlasLines[line].Boss = v[1]
										break
									end
								end
							end
						end
					end
				end
				AtlasLoot.AtlasLines[line].idnum = lineplusoffset;
				AtlasLoot.AtlasLines[line]:Show();
			elseif AtlasLoot.AtlasLines[line] then
				--Hide lines that are not needed
				AtlasLoot.AtlasLines[line]:Hide();
			end
		end
	else
		Hooked_AtlasScrollBar_Update();
	end
end

function AtlasLoot:Atlas_SetBoss(boss)
	for k,v in ipairs(AtlasLoot.AtlasLines) do
		if v.Boss == boss then
			AtlasLoot.Boss_OnClick(v)
			return
		end
	end
end
-- Invoked whenever a boss line in Atlas is clicked
-- Shows a loot page if one is associated with the button
function AtlasLoot:Boss_OnClick()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone]
	local id = self.idnum
	
	-- Check Tables
	local contentTable = "Instances"
	for k,v in pairs(AtlasLoot_LootTableRegister) do
		if AtlasLoot_LootTableRegister[k][zoneID] then
			contentTable = k
			break
		end
	end
	
	--If the loot table was already shown and boss clicked again, hide the loot table and fix boss list icons
	if self.Selected:IsVisible() then
		self.Selected:Hide()
		--AtlasMap_Text:Show()
		self.Loot:Show()
		AtlasLootItemsFrame:Hide()
		AtlasLootItemsFrame.activeBoss = nil
	else	
--[[		if ( AtlasMap_Text:IsShown() ) then
			AtlasMap_Text:Hide()
		end]]
		--If an loot table is associated with the button, show it.  Note multiple tables need to be checked due to the database structure
		--if AtlasLoot_LootTableRegister[contentTable][zoneID] and AtlasLoot_LootTableRegister[contentTable][zoneID]["Bosses"] then
		local LootTable, InfoTable = AtlasLoot:GetBossTableZoneID(zoneID)
		if LootTable then
			for k,v in ipairs(LootTable) do
				if v[2] and type(v[2]) == "number" then
					if v[2] == id then
						self.Selected:Show()
						self.Loot:Hide()
						local _,_,boss = string.find(self.Text:GetText() or "", "|c%x%x%x%x%x%x%x%x%s*[%dX']*[%) ]*(.*[^%,])[%,]?$")
						AtlasLoot:ShowLootPage(v[1])
						AtlasLootItemsFrame.activeBoss = id
						AtlasLoot:AtlasScrollBar_Update()
						break
					end
				elseif v[2] and type(v[2]) == "table" then
					for k2,v2 in ipairs(v[2]) do
						if v2 == id then
							self.Selected:Show()
							self.Loot:Hide()
							local _,_,boss = string.find(self.Text:GetText(), "|c%x%x%x%x%x%x%x%x%s*[%dX']*[%) ]*(.*[^%,])[%,]?$")
							AtlasLoot:ShowLootPage(v[1])
							AtlasLootItemsFrame.activeBoss = id
							AtlasLoot:AtlasScrollBar_Update()
							break
						end
					end
				end
			end
		end
	end
	
	--self has been invoked from Atlas, so we remove any claim external mods have on the loot table
	AtlasLootItemsFrame.externalBoss = nil;
	
	--Hide the AtlasQuest frame if present so that the AtlasLoot items frame is not stuck under it
	if (AtlasQuestInsideFrame) then
		HideUIPanel(AtlasQuestInsideFrame);
	end
	
end