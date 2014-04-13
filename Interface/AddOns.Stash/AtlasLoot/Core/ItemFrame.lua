-- $Id: ItemFrame.lua 4248 2013-09-10 09:29:27Z lag123 $
local _
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")

--- Clears the itemtable
-- @usage AtlasLoot:ClearLootPage()
function AtlasLoot:ClearLootPageItems()
	if not self.ItemFrame then return end
	for i in ipairs(self.ItemFrame.ItemButtons) do
		self.ItemFrame.ItemButtons[i]:Clear()
	end
end

--- Clears the lootPage (BUTTONS)
-- this only hides all button. For hide all itemButtons use AtlasLoot:ClearLootPageItems()
-- @usage AtlasLoot:ClearLootPage()
function AtlasLoot:ClearLootPage()
	self:WipeItemInfoTempTable()
	self.ItemFrame.Next:Hide()
	self.ItemFrame.Prev:Hide()
	self.ItemFrame.Heroic:Hide()
	self.ItemFrame.RaidFinder:Hide()
	self.ItemFrame.Flexible:Hide()
	self.ItemFrame.Switch:Hide()
	self.ItemFrame.changePoint = nil
	self.ItemFrame.Back:Hide()
	self.ItemFrame.dataID = nil
	self.ItemFrame.lootTableType = nil
	self.ItemFrame.BossName:SetText("")
end

--- Refresh the itemtable
-- @usage AtlasLoot:RefreshItemTable()
function AtlasLoot:RefreshLootPage()
	if not self.ItemFrame then return end
	for i in ipairs(self.ItemFrame.ItemButtons) do
		self.ItemFrame.ItemButtons[i]:Refresh()
	end
	local bossName
	if self.ThunderforgeAviable then
		bossName = self:GetTableInfo(self.ItemFrame.dataID, false, true, true, self.db.profile.ShowThunderforged)
	else
		bossName = self:GetTableInfo(self.ItemFrame.dataID, false, true, true)
	end
	self.ItemFrame.BossName:SetText(bossName)
end

--- Sets a itemtable to the item frame
-- @param tab the item table
-- @usage AtlasLoot:SetItemTable(tab)
function AtlasLoot:SetItemTable(tab)
	self:ClearLootPageItems()
	self.ThunderforgeAviable = false 
	if not tab or type(tab) ~= "table" or not #tab then return end
	local cPoint = false
	local itemButtonNum, texture, num1, spellNumber
	for k,v in ipairs(tab) do
		if v and type(v) == "table" then
			itemButtonNum = v[1]
			if self.ItemFrame.ItemButtons[itemButtonNum] then
				texture = nil
				if v[3] == "?" then
					texture = "?"
				elseif type(v[3]) == "string" and v[3] ~= "" and not tonumber(v[3]) then
					if string.match(v[3], "Interface") then
						texture = v[3]
					else
						texture = "Interface\\Icons\\"..v[3]
					end
				elseif v[2] == "" and v[3] and v[3] ~= "" then
					v[2] = tonumber(v[3])
				end
					
				-- check if we have a price
				if v[6] and v[6] ~= "" and v[6] ~= "=ds=" then--and v[5] and v[5] ~= "" and v[5] ~= "=ds="  then
					cPoint = true
				end
				num1 = string.find(v[2], "s(%d+)")
				if v[2] == 0 or v[2] == "" then
					self.ItemFrame.ItemButtons[itemButtonNum]:SetDummy(v[4], v[5], texture)
				elseif type(v[2]) == "string" and num1 and num1 == 1 then--and string.find(v[2], "s(%d+)") then
					_,_,spellNumber = string.find(v[2], "s(%d+)")
					if self.db.profile.CraftingLink == 1 then
						self.ItemFrame.ItemButtons[itemButtonNum]:SetSpell(tonumber(spellNumber), tonumber(v[3]), v[4], v[5], texture, v[6])
					else
						self.ItemFrame.ItemButtons[itemButtonNum]:SetItem(tonumber(v[3]), v[4], v[5], texture, v[6], v[7], nil, v.tf)
					end
						self.ItemFrame.ItemButtons[itemButtonNum]:SetLink(v[2])
						self.ItemFrame.ItemButtons[itemButtonNum]:SetLink(v[3])
				elseif type(v[2]) == "string" and type(v[3]) == "string" then
					self.ItemFrame.ItemButtons[itemButtonNum]:SetMenu(v[2], v[4], v[5], texture, v.tableLinkFunc)
				else
					self.ItemFrame.ItemButtons[itemButtonNum]:SetItem(v[2], v[4], v[5], texture, v[6], v[7], nil, v.tf)
					self.ItemFrame.ItemButtons[itemButtonNum]:SetLink(v[2])
					self.ItemFrame.ItemButtons[itemButtonNum]:SetLink(v[3])
				end
				if v.type then self.ItemFrame.ItemButtons[itemButtonNum]:SetItemType(v.type) end
				if v.amount then self.ItemFrame.ItemButtons[itemButtonNum]:SetAmount(v.amount) end
				if v.tf then self.ThunderforgeAviable = true end
			end
		end
	end
	self.ItemFrame.Switch.changePoint = cPoint
	self.ItemFrame:Show()
end 

-----------------------------
-- Button functions
-----------------------------

-- AtlasLoot:ItemsFrameOnCloseButton:
-- Called when the close button on the item frame is clicked
function AtlasLoot:ItemsFrameOnCloseButton()
	--[[Set no loot table as currently selected
	AtlasLootItemsFrame.activeBoss = nil;
	--Fix the boss buttons so the correct icons are displayed
    if AtlasFrame and AtlasFrame:IsVisible() then
        if ATLAS_CUR_LINES then
            for i=1,ATLAS_CUR_LINES do
                if _G["AtlasBossLine"..i.."_Selected"] and _G["AtlasBossLine"..i.."_Selected"]:IsVisible() then
                   _G["AtlasBossLine"..i.."_Selected"]:Hide();
                    _G["AtlasBossLine"..i.."_Loot"]:Show();
                end
            end
        end
    end
	--Hide the item frame
	AtlasLoot:ClearLootPageItems()
	AtlasLoot:ClearLootPage()
	]]--
	AtlasLootItemsFrame:Hide();
end

function AtlasLoot:RefreshBossSelect(boss)
	local done 
	local dataID, page = AtlasLoot:FormatDataID(boss)
	if AtlasLoot.DefaultFrame_SetInstance and AtlasLootDefaultFrame and AtlasLootDefaultFrame:IsShown() and page == 1 then
		done = AtlasLoot:DefaultFrame_SetInstance(nil, nil, dataID)
	end
	if AtlasLoot.Atlas_SetBoss and AtlasFrame and AtlasFrame:IsShown() and page == 1 then
		done = AtlasLoot:Atlas_SetBoss(dataID)
	end
	
	if not done then
		AtlasLoot:ShowLootPage(boss)
	end
end
-- AtlasLoot:NavButton_OnClick:
-- Called when <-, -> or 'Back' are pressed and calls up the appropriate loot page
function AtlasLoot.NavButton_OnClick(self)
	if self.lootpage then
		AtlasLoot:RefreshBossSelect(self.lootpage)
	end
end

-- AtlasLoot:HeroicModeToggle:
-- Switches between the heroic and normal versions of a loot page
function AtlasLoot.HeroicModeToggle(self)
	local dataID = AtlasLoot.ItemFrame.dataID
	
	if AtlasLoot.db.profile.LootTableType == "Normal" then
		AtlasLoot:SetLootTableType("Heroic", dataID)
	elseif AtlasLoot.db.profile.LootTableType == "Heroic" then
		AtlasLoot:SetLootTableType("Normal", dataID)
	elseif AtlasLoot.db.profile.LootTableType == "25Man" then
		AtlasLoot:SetLootTableType("25ManHeroic", dataID)
	elseif AtlasLoot.db.profile.LootTableType == "25ManHeroic" then
		AtlasLoot:SetLootTableType("25Man", dataID)
	elseif AtlasLoot.db.profile.LootTableType == "RaidFinder" then
		AtlasLoot:SetLootTableType("Heroic", dataID)
	elseif AtlasLoot.db.profile.LootTableType == "Flexible" then
		AtlasLoot:SetLootTableType("Heroic", dataID)
	end
end

function AtlasLoot.RaidFinderToggle(self)
	local dataID = AtlasLoot.ItemFrame.dataID
	
	if AtlasLoot.db.profile.LootTableType ~= "RaidFinder" then
		AtlasLoot:SetLootTableType("RaidFinder", dataID)
	else
		AtlasLoot:SetLootTableType("Normal", dataID)
	end
end

function AtlasLoot.FlexibleToggle(self)
	local dataID = AtlasLoot.ItemFrame.dataID
	
	if AtlasLoot.db.profile.LootTableType ~= "Flexible" then
		AtlasLoot:SetLootTableType("Flexible", dataID)
	else
		AtlasLoot:SetLootTableType("Normal", dataID)
	end
end

function AtlasLoot.ThunderforgedToggle(self)
	AtlasLoot.db.profile.ShowThunderforged = not AtlasLoot.db.profile.ShowThunderforged  
	AtlasLoot:RefreshLootPage()
end

-- AtlasLoot:Toggle10Man25Man:
-- Switches between the heroic and normal versions of a loot page
function AtlasLoot.Toggle10Man25Man(self)
	local dataID = AtlasLoot.ItemFrame.dataID
	
	if self.changePoint then
		AtlasLoot.db.profile.ShowLootTablePrice = not AtlasLoot.db.profile.ShowLootTablePrice
		AtlasLoot:ShowLootPage(dataID)
	else
		if AtlasLoot.db.profile.LootTableType == "Normal" or AtlasLoot.db.profile.LootTableType == "RaidFinder" then
			AtlasLoot:SetLootTableType("25Man", dataID)
		elseif AtlasLoot.db.profile.LootTableType == "Heroic" then
			AtlasLoot:SetLootTableType("25ManHeroic", dataID)
		elseif AtlasLoot.db.profile.LootTableType == "25Man" then
			AtlasLoot:SetLootTableType("Normal", dataID)
		elseif AtlasLoot.db.profile.LootTableType == "25ManHeroic" then
			AtlasLoot:SetLootTableType("Heroic", dataID)
		end
	end
end

-- AtlasLoot:BackButton_OnClick()
-- Shows the last selectet Boss.
function AtlasLoot:BackButton_OnClick()
	if self.lootpage then
		AtlasLoot:ShowLootPage(self.lootpage)
	end
end

-----------------------------
-- Button list
-----------------------------
local ICON_LIST = {}

function AtlasLoot:ItemFrame_IconList_CreateIcon(name, parent, icon, scripts, addInList)
	assert(type(name) == "string", "<name> must be string")
	
	if addInList then
		button = CreateFrame("Button", "AtlasLootItemsFrame_"..name,  AtlasLoot.ItemFrame, "AtlasLoot_RoundButton")
	else
		button = CreateFrame("Button", name,  parent, "AtlasLoot_RoundButton")
	end
	button:SetWidth(30)
	button:SetHeight(30)
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	SetPortraitToTexture(button.icon, icon)
	if scripts then
		for k,v in pairs(scripts) do
			if k and v then
				button:SetScript(k, v)
			end
		end
	end
	
	if addInList then
		table.insert(ICON_LIST, button)
	end
	
	return button
end

function AtlasLoot:ItemFrame_IconList_Refresh()
	local last
	for k,v in ipairs(ICON_LIST) do
		if v then
			if v:IsShown() then
				if not last then
					if AtlasLoot.ItemFrame.CloseButton:IsShown() then
						v:SetPoint("RIGHT", AtlasLoot.ItemFrame.CloseButton, "LEFT", 0, 0)
					else
						v:SetPoint("TOPRIGHT", AtlasLoot.ItemFrame, "TOPRIGHT", -5, -5)
					end
				else
					AtlasLoot.ItemFrame.BonusRoll:SetPoint("RIGHT", last, "LEFT", 0, 0)
				end
				last = v
			end
		end
	end
end
-----------------------------
-- Query All function
-----------------------------
do 

	local queryAllTimerFrame = CreateFrame("Frame")
	local queryAllAnimationGroup = queryAllTimerFrame:CreateAnimationGroup()
	local queryAllAnimation = queryAllAnimationGroup:CreateAnimation("Animation")
	local queryAllScanTooltip = CreateFrame("GAMETOOLTIP","AtlasLootQueryAllScanTooltip",nil,"GameTooltipTemplate");
	local queryAllButtonIndex = 0
	local queryAllItemID = 0
	queryAllAnimation:SetDuration(7)
	queryAllAnimationGroup:SetLooping("NONE")
	queryAllScanTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	
	-- Querys the itemButton
	-- buttonIndex 
	local function QueryItem(buttonIndex)
		if not buttonIndex or buttonIndex > 30 then return end
		local queryitem 
		if AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex].info then
			queryitem = AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex].info[2]
		end
		if not queryitem then
			QueryNextItem()
			return
		elseif (queryitem) and (queryitem ~= nil) and (queryitem ~= "") and (queryitem ~= 0) and (string.sub(queryitem, 1, 1) ~= "s") then
			queryAllItemID = queryitem
			queryAllScanTooltip:SetHyperlink("item:"..queryitem..":0:0:0:0:0:0:0")
		end
	end

	local function QueryNextItem()
		if AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex] then AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex].Frame.QueryIcon:Hide() end
		queryAllButtonIndex = queryAllButtonIndex + 1
		if queryAllButtonIndex > 30 then
			AtlasLoot:StopQuery()
			AtlasLoot:RefreshLootPage()
		else
			local queryitem 
			if AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex].info then
				queryitem = AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex].info[2]
			end
			if not queryitem then
				QueryNextItem()
			elseif queryitem and queryitem == 0 or queryitem and GetItemInfo(queryitem) then
				QueryNextItem()
			else
				if AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex] then AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex].Frame.QueryIcon:Show() end
				QueryItem(queryAllButtonIndex)
			end
		end
	end

	local function OnTooltipSetItem()
		if not queryAllItemID then QueryNextItem() return end
		if GetItemInfo(queryAllItemID) then
			if queryAllAnimationGroup:IsPlaying() then
				queryAllAnimationGroup:Stop()
			end
			AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex]:Refresh()
			QueryNextItem()
		else
			queryAllAnimationGroup:Play()
		end
	end
	
	queryAllAnimationGroup:SetScript("OnFinished", QueryNextItem)
	queryAllScanTooltip:SetScript('OnTooltipSetItem', OnTooltipSetItem)
	
	--- Starts to Query the lootpage
	-- Querys all valid items on the current loot page.
	-- @usage AtlasLoot_QueryLootPage()
	function AtlasLoot:QueryLootPage()
		queryAllButtonIndex = 0
		QueryNextItem()
	end
	
	--- Stops the Query of all items
	-- @usage AtlasLoot:StopQuery()
	function AtlasLoot:StopQuery()
		if AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex] then AtlasLoot.ItemFrame.ItemButtons[queryAllButtonIndex].Frame.QueryIcon:Hide() end
		queryAllAnimationGroup:Stop()
	end	

end