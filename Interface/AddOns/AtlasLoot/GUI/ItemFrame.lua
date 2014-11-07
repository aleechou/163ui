local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI
local ItemDB = AtlasLoot.ItemDB
local ItemFrame = {}
AtlasLoot.GUI.ItemFrame = ItemFrame
local AL = AtlasLoot.Locales

-- lua
local type, tostring = type, tostring
local floor = math.floor
local format = string.format

-- WoW
local GetTime = GetTime

local LastRefresh = GetTime()
local PAGE_NAME_DIFF = "%s (%s)"
local PAGE_NAME_DIFF_PAGE = "%s (%s) [%d/%d]"

function ItemFrame:Create()
	if self.frame then return self.frame end
	local frameName = "AtlasLoot_GUI-ItemFrame"
	
	self.frame = CreateFrame("FRAME", frameName, GUI.frame)
	local frame = self.frame 
	frame:ClearAllPoints()
	frame:SetParent(GUI.frame)
	frame:SetPoint("TOPLEFT", GUI.frame.contentFrame.itemBG)
	frame:SetWidth(560)
	frame:SetHeight(450)
	--frame:Hide()
	-- create all item buttons
	frame.Refresh = ItemFrame.Refresh
	frame.Clear = ItemFrame.Clear
	frame.OnClassFilterUpdate = ItemFrame.OnClassFilterUpdate
	
	frame.ItemButtons = {}
	for i=1,30 do
		frame.ItemButtons[i] = AtlasLoot.Button:Create()
		frame.ItemButtons[i]:ClearAllPoints()
		frame.ItemButtons[i]:SetParent(frame)
		if i == 1 then
			frame.ItemButtons[i]:SetPoint("TOPLEFT", frame, "TOPLEFT", 5)
		elseif i == 16 then
			frame.ItemButtons[i]:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
		else
			frame.ItemButtons[i]:SetPoint("TOPLEFT", frame.ItemButtons[i-1], "BOTTOMLEFT", 0, -2)
		end
	end
	return self.frame
end

function ItemFrame:Show(noRefresh)
	if not ItemFrame.frame:IsShown() or GUI.frame.contentFrame.shownFrame ~= ItemFrame.frame then
		GUI:HideContentFrame()
		ItemFrame.frame:Show()
		GUI.frame.contentFrame.shownFrame = ItemFrame.frame
		if not noRefresh then
			ItemFrame:Refresh()
		end
	end
end

function ItemFrame:ClearItems()
	for i=1,30 do
		self.frame.ItemButtons[i]:Clear()
		self.frame.ItemButtons[i]:Hide()
	end
	AtlasLoot.EncounterJournal:ClearLootQuery()
end

function ItemFrame.OnClassFilterUpdate(filterTab)
	if AtlasLoot.db.profile.GUI.classFilter and GUI.__EJData then
		if not filterTab then
			AtlasLoot.EncounterJournal:SetLootQuery(GUI.__EJData[1], GUI.__EJData[2], ItemFrame.CurDiff, ItemFrame.CurTier, nil, GUI.frame.contentFrame.clasFilterButton.selectedPlayerSpecID, ItemFrame.OnClassFilterUpdate )
		else
			local button
			for i = 1,30 do
				button = ItemFrame.frame.ItemButtons[i]
				if button and button.__atlaslootinfo and not button.__atlaslootinfo.filterIgnore and button.__atlaslootinfo.type and button.__atlaslootinfo.type[1] == "Item" then
					if button.ItemID and filterTab[button.ItemID] then
						button:SetAlpha(1)
					else
						button:SetAlpha(0.33)
					end
				else
					button:SetAlpha(1)
				end
			end
		end
	else
		for i=1,30 do
			ItemFrame.frame.ItemButtons[i]:SetAlpha(1)
		end
	end
end

function ItemFrame:Refresh(skipProtect)
	-- small spam protection
	if not skipProtect and GetTime() - LastRefresh < 0.1 then return end
	LastRefresh = GetTime()
	
	ItemFrame:ClearItems()
	AtlasLoot.db.profile.GUI.selected[5] = AtlasLoot.db.profile.GUI.selected[5] or 0
	ItemFrame.nextPage = nil
	local page = AtlasLoot.db.profile.GUI.selected[5] * 100 -- Page number for first items on a page are <1, 101, 201, 301, 401, ...>
	local items, tableType, diffData = ItemDB:GetItemTable(AtlasLoot.db.profile.GUI.selected[1], AtlasLoot.db.profile.GUI.selected[2], AtlasLoot.db.profile.GUI.selected[3], AtlasLoot.db.profile.GUI.selected[4])

	if items then
		ItemFrame.CurDiff = diffData.difficultyID or 1
		ItemFrame.CurTier = diffData.tierID or 1
		
		-- refresh title with diff and add pagenumber if there 
		if #items and items[#items] and items[#items][1] > 100 then
			GUI.frame.contentFrame.title:SetText(format(PAGE_NAME_DIFF_PAGE, GUI.frame.contentFrame.title.txt, diffData.name, AtlasLoot.db.profile.GUI.selected[5]+1, floor(items[#items][1]/100)+1))
		else
			GUI.frame.contentFrame.title:SetText(format(PAGE_NAME_DIFF, GUI.frame.contentFrame.title.txt, diffData.name))
		end
		if type(items) == "string" then
			AtlasLoot.Loader:LoadModule(items, function() ItemFrame:Refresh(true) end, true)
			return
		end
		local fixItemNum = 0
		local setn,item = nil
		for i = 1,#items do
			item = items[i]
			fixItemNum = item[1] - page
			if ItemFrame.frame.ItemButtons[fixItemNum] then
				ItemFrame.frame.ItemButtons[fixItemNum]:SetPreSet(diffData.preset)
				ItemFrame.frame.ItemButtons[fixItemNum]:SetContentTable(item, tableType)
				--ItemFrame.frame.ItemButtons[fixItemNum]:SetAlpha(1)
				setn = true
			elseif fixItemNum > 100 then
				GUI.frame.contentFrame.nextPageButton.info = tostring(AtlasLoot.db.profile.GUI.selected[5] + 1)
				--break
			end
		end
		-- page not found set it to first page and reset
		if not setn and AtlasLoot.db.profile.GUI.selected[5] ~= 0 then
			AtlasLoot.db.profile.GUI.selected[5] = 0
			self:Refresh(true)
			return
		end
	end
	-- calc prev page
	if AtlasLoot.db.profile.GUI.selected[5] - 1 >= 0 then
		GUI.frame.contentFrame.prevPageButton.info = tostring(AtlasLoot.db.profile.GUI.selected[5] - 1)
	else
		if AtlasLoot.db.profile.GUI.selected[3] - 1 > 0 then
			items, tableType = ItemDB:GetItemTable(AtlasLoot.db.profile.GUI.selected[1], AtlasLoot.db.profile.GUI.selected[2], AtlasLoot.db.profile.GUI.selected[3]-1, AtlasLoot.db.profile.GUI.selected[4])
			if items and #items > 0 and floor(items[#items][1]/100) > 0 then
				GUI.frame.contentFrame.prevPageButton.info = { AtlasLoot.db.profile.GUI.selected[3]-1, floor(items[#items][1]/100) }
			end
		end
	end
	ItemFrame.OnClassFilterUpdate()
end

function ItemFrame.Clear()
	ItemFrame:ClearItems()
end