local _G = _G
local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI
local SVF = {}
AtlasLoot.GUI.SetViewFrame = SVF
local AL = AtlasLoot.Locales

--lua
local type = type
local next, pairs = next, pairs
local wipe, tab_sort = table.wipe, table.sort

-- WOW
local CreateFrame = CreateFrame
local GetItemStats = GetItemStats

-- AtlasLoot
local ItemQuery = AtlasLoot.ItemQuery:Create()
local getFrame = AtlasLoot.GUI.GetFrameByType
local delFrame = AtlasLoot.GUI.FreeFrameByType
local GetTextFrameWithBackground = AtlasLoot.GUI.CreateTextWithBg

-- Saved variables
local db

-- //\\
local SVF_FRAME_NAME = "AtlasLoot-SetViewFrame"
local SVF_FRAME_WIDTH = 800
local SVF_FRAME_HEIGHT = 400
local BACKDROP_DATA = {bgFile = "Interface/Tooltips/UI-Tooltip-Background"}

local MODEL_FRAME_WIDTH = 220
local MODEL_FRAME_HEIGHT = 300

local CONTAINER_MAX_NUM_ITEMS = nil
local CONTAINER_FRAME_WIDTH = nil
local CONTAINER_FRAME_HEIGHT = nil
local CONTAINER_ITEM_PLACE_HEIGHT = nil

local CONTAINER_ITEM_TEXT_BG_COLOR = { r = 1, g = 1, b = 1, a = 1 }
local CONTAINER_ITEM_TEXT_COLOR = { r = 1, g = 0.82, b = 0, a = 1 }
local CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR = { r = 0, g = 0.86, b = 1, a = 1 }
local CONTAINER_TOP_BOTTOM_TEXT_COLOR = { r = 1, g = 1, b = 1, a = 1 }
local CONTAINER_ITEM_MIN_HEIGHT = 20
local CONTAINER_ITEM_MAX_HEIGHT = 35

-- "hide" 				= 	hide the stat
-- function(statValue)	= 	returns new value for this
local STATS_FILTER = {
	["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = "hide",
	["EMPTY_SOCKET"] = "hide",
	["EMPTY_SOCKET_BLUE"] = "hide",
	["EMPTY_SOCKET_COGWHEEL"] = "hide",
	["EMPTY_SOCKET_HYDRAULIC"] = "hide",
	["EMPTY_SOCKET_META"] = "hide",
	["EMPTY_SOCKET_NO_COLOR"] = "hide",
	["EMPTY_SOCKET_PRISMATIC"] = "hide",
	["EMPTY_SOCKET_RED"] = "hide",
	["EMPTY_SOCKET_YELLOW"] = "hide",
}

local CurrentData = {}

-- INIT
function SVF.Init()
	db = AtlasLoot.db.profile.SetViewFrame
	--AtlasLoot:Teest()
	AtlasLoot.SlashCommands:AddResetFunction(SVF.ResetFrames, "frames", "svf")
end
AtlasLoot:AddInitFunc(SVF.Init)

local function SetTextForFrame(textFrame, data)
	if type(data) == "table" then
		textFrame:SetText(data[1])
		textFrame:SetToolTip(data[2], data[3])
	else
		textFrame:SetText(data)
		textFrame:SetToolTip(nil)
	end
end

-- TEXT
-- content = { "hello1", "hello2", "hello3" }
-- content = { { title, tooltip_line_1, tooltip_line_2 }, { title2, tooltip_line_1, tooltip_line_2 } )
local function CreateTextColumn(content, parFrame, width, height, pointInParFrame, bgColor, textColor)
	if not content or not parFrame then return end
	bgColor = bgColor or CONTAINER_ITEM_TEXT_BG_COLOR
	textColor = textColor or CONTAINER_ITEM_TEXT_COLOR
	if type(content) == "table" then
		-- calc the size of the column
		local numFrames = #content
		local textHeight = height or parFrame:GetHeight()
		local textWidth = ( ( (width or parFrame:GetWidth()) ) / numFrames ) - 2
		-- print(width or parFrame:GetWidth(), numFrames, pointInParFrame and pointInParFrame[4] or 2, textWidth )
		-- create text frames
		local text
		for i = 1, #content do
			text = GetTextFrameWithBackground(parFrame,  textWidth, textHeight, bgColor, textColor)
			if i == 1 then
				if pointInParFrame then
					text:SetPoint(pointInParFrame[1], pointInParFrame[2], pointInParFrame[3], pointInParFrame[4], pointInParFrame[5])
				else
					text:SetPoint("LEFT", parFrame, "LEFT", 2, 0)
				end
			else
				text:SetPoint("LEFT", parFrame.content[i-1], "RIGHT", 2, 0)
			end
			SetTextForFrame(text, content[i])
			text:Show()
			parFrame.content[i] = text
		end
	else -- only 1 entry
		width = width or parFrame:GetWidth()
		local text = GetTextFrameWithBackground(parFrame, pointInParFrame and pointInParFrame[4] and width-pointInParFrame[4] or width-2, height or parFrame:GetHeight(), bgColor, textColor)
		if pointInParFrame then
			text:SetPoint(pointInParFrame[1], pointInParFrame[2], pointInParFrame[3], pointInParFrame[4], pointInParFrame[5])
		else
			text:SetPoint("LEFT", parFrame, "LEFT", 2, 0)
		end
		SetTextForFrame(text, content)
		text:Show()
	end
end

-- ITEM LINES
local function SetItemFrameHeight(self, height)
	self:SetHeight(height)
	self.itemButton:SetWidth(height)
end

local function SetItemFrameItem(self, itemID)
	self.itemID = itemID
	self:SetContentTable({ 0, itemID}, {"Item", "Item"}, true)
	--self.itemIcon:SetTexture(GetItemIcon(itemID))
end

local function GetNextItemFrame()
	local frame = getFrame("SVF-ItemFrame")
	if not frame then
		frame = CreateFrame("Frame")
		frame:SetParent(SVF.frame.containerFrame)
		frame:SetWidth(CONTAINER_FRAME_WIDTH-10)
		--frame:SetBackdrop(BACKDROP_DATA)
		--frame:SetBackdropColor(0,1,0,1)
		AtlasLoot.Button:CreateSecOnly(frame)	
		frame.itemButton = frame.secButton
		frame.itemButton:ClearAllPoints()
		frame.itemButton:SetParent(frame)
		frame.itemButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.itemButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
		frame.SetItemFrameHeight = SetItemFrameHeight
		frame.SetItem = SetItemFrameItem
		
		frame.content = {}
	end
	local frameNum = #SVF.frame.containerFrame.content
	frame:ClearAllPoints()
	if frameNum > 0 then
		frame:SetPoint("TOPLEFT", SVF.frame.containerFrame.content[frameNum], "BOTTOMLEFT", 0, -2)
	else
		frame:SetPoint("TOPLEFT", SVF.frame.containerFrame.subTopFrame, "BOTTOMLEFT", 0, -2)
	end
	frame:Show()
	
	--CreateTextColumn({ "test1", "test2", "test3"}, frame)
	
	SVF.frame.containerFrame.content[frameNum+1] = frame
	return frame
end

local function ClearItemFrames()
	for i = 1, #SVF.frame.containerFrame.content do
		local frame = SVF.frame.containerFrame.content[i]
		delFrame("SVF-ItemFrame", frame)
		frame.itemID = nil
		frame:Clear()
		for j = 1, #frame.content do
			frame.content[j]:Clear()
		end
		wipe(frame.content)
		frame:Hide()
	end

	wipe(SVF.frame.containerFrame.content)
end

local function ClearExtraList()
	for i = 1, #SVF.frame.containerFrame.subTopFrame.content do
		SVF.frame.containerFrame.subTopFrame.content[i]:Clear()
		SVF.frame.containerFrame.subTopFrame.content[i] = nil
	end
	for i = 1, #SVF.frame.containerFrame.bottomFrame.content do
		SVF.frame.containerFrame.bottomFrame.content[i]:Clear()
		SVF.frame.containerFrame.bottomFrame.content[i] = nil
	end
end

local LoadExtraList
local function RefreshExtraList()
	ClearExtraList()
	if CurrentData.currentContentType == "stats" then
		ItemQuery:AddItemStatsList(CurrentData.itemList, function() LoadExtraList(CurrentData.currentContentType) end)
	else
		LoadExtraList(CurrentData.currentContentType)
	end
end

function LoadExtraList(typ)
	if typ == "stats" then
		
		local list = {}			-- list of all existing stats for the items
		local itemStats = {}	-- item stats for single items
		local statSummary = {}	-- Saves a summary of all stats
		local listBottom = {}	-- the summary on the bottom
		local listTopTmp = {}	-- temporary used for the header
		local listTop = {}		-- used for the header
		local globalNames = {}	-- saves global names e.g. ( "Blue Socket" = "EMPTY_SOCKET_BLUE" )
		
		local globalTmp
		for i = 1, #SVF.frame.containerFrame.content do
			if SVF.frame.containerFrame.content[i].itemID then
				itemStats[i] = GetItemStats("item:"..SVF.frame.containerFrame.content[i].itemID)
				if not itemStats[i] then
					RefreshExtraList()
					return
				end
				for k,v in pairs(itemStats[i]) do
					globalTmp = _G[k]
					if STATS_FILTER[k] ~= "hide" then
						if not statSummary[globalTmp] then
							globalNames[globalTmp] = k
							list[ #list+1 ] = globalTmp
							statSummary[ globalTmp ] = v or 0
							listTopTmp[ globalTmp ] = { globalTmp, globalTmp }
						else
							statSummary[globalTmp] = statSummary[globalTmp] + v
						end
					end
				end
			end
		end
		tab_sort(list)
		
		-- Create Item stats and fill empty spots
		for i = 1, #SVF.frame.containerFrame.content do
			local itemStatsList = {}
			for j = 1, #list do
				local v = list[j]
				-- resort and create stats list on top
				if i == 1 then
					listTop[j] = listTopTmp[v]
					listBottom[j] = statSummary[v]
				end
				if STATS_FILTER[j] and type(STATS_FILTER[j]) == "function" then
					itemStatsList[j] = STATS_FILTER[j]( itemStats[i][ globalNames[v] ] or 0 )
				else
					itemStatsList[j] = itemStats[i][ globalNames[v] ] or 0
				end
			end
			CreateTextColumn(itemStatsList, SVF.frame.containerFrame.content[i], CurrentData.textColumnWidth, nil, {"LEFT", SVF.frame.containerFrame.content[i].itemButton, "RIGHT", 2, 0})
		end
		
		-- Create stats list on top
		CreateTextColumn(listTop, SVF.frame.containerFrame.subTopFrame, CurrentData.textColumnWidth, nil, {"LEFT", SVF.frame.containerFrame.subTopFrame, "LEFT", SVF.frame.containerFrame.subTopFrame:GetWidth()-CurrentData.textColumnWidth+2, 0}, CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR, CONTAINER_TOP_BOTTOM_TEXT_COLOR)

		-- Create summary on bottom and relocate
		SVF.frame.containerFrame.bottomFrame:SetPoint("TOPLEFT", SVF.frame.containerFrame.content[#SVF.frame.containerFrame.content], "BOTTOMLEFT", 0, -2)
		CreateTextColumn(listBottom, SVF.frame.containerFrame.bottomFrame, CurrentData.textColumnWidth, nil, {"LEFT", SVF.frame.containerFrame.bottomFrame, "LEFT", SVF.frame.containerFrame.bottomFrame:GetWidth()-CurrentData.textColumnWidth+2, 0}, CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR, CONTAINER_TOP_BOTTOM_TEXT_COLOR)
	--elseif typ == "droplocation" then
		-- curently not mutch here :(
	elseif typ ~= nil then
		-- we dont have any presets here so its only text ;)
		for i = 1, #SVF.frame.containerFrame.content do
			local itemFrame = SVF.frame.containerFrame.content[i]
			if itemFrame.itemID and CurrentData.contentTypesData[itemFrame.itemID] and CurrentData.contentTypesData[itemFrame.itemID][CurrentData.currentContentTypeID] then
				CreateTextColumn(CurrentData.contentTypesData[itemFrame.itemID][CurrentData.currentContentTypeID], itemFrame, CurrentData.textColumnWidth, nil, {"LEFT", itemFrame.itemButton, "RIGHT", 2, 0} )
			end
		end
	else
		error("Typ not defined.")
	end
	
	CurrentData.lastContent = typ
end

local function SetItemList(tab)
	local frame = SVF.frame
	
	-- dressup model \ load text
	frame.modelFrame:Undress()
	
	-- get height of the item frame
	local itemFrameHeight = ( CONTAINER_ITEM_PLACE_HEIGHT / #tab ) - 2
	if itemFrameHeight < CONTAINER_ITEM_MIN_HEIGHT then
		error("WARNING item limit is reached - "..#tab)
	elseif itemFrameHeight > CONTAINER_ITEM_MAX_HEIGHT then
		itemFrameHeight = CONTAINER_ITEM_MAX_HEIGHT
	end

	local itemFrame, textColumnWidth
	for i = 1, #tab do
		frame.modelFrame:TryOn(tab[i])
		
		itemFrame = GetNextItemFrame()
		itemFrame:SetItemFrameHeight(itemFrameHeight)
		itemFrame:SetItem(tab[i])
		
		if not textColumnWidth then
			textColumnWidth = itemFrame:GetWidth() - itemFrame:GetHeight() 
			CurrentData.textColumnWidth = textColumnWidth
		end

		--CreateTextColumn({ "test1", "test2", "test3"}, itemFrame, textColumnWidth, nil, {"LEFT", itemFrame.itemButton, "RIGHT", 2, 0})
	end
end

local function NewSet()
	SetItemList(CurrentData.itemList)
	RefreshExtraList()
end

function SVF:Clear()
	ClearItemFrames()
	ClearExtraList()
	wipe(CurrentData)
	
	self.frame:Hide()
end


function SVF:SetNewItemSet(setTable)
	if not self.frame then self:Create() end
	self:Clear()
	
	-- set set name
	CurrentData.name = setTable.name
	
	-- create content list
	CurrentData.contentTypes = {}
	if setTable.contentTypes then
		CurrentData.contentTypes = setTable.contentTypes
	else
		CurrentData.contentTypes = { "stats" }		-- no content given show only stats
	end
	CurrentData.currentContentType = CurrentData.contentTypes[1] or "stats"
	CurrentData.currentContentTypeID = 1
	
	-- create item list and item data
	CurrentData.itemList = {}
	CurrentData.contentTypesData = {}
	
	for i = 1, #setTable.data do
		local item = setTable.data[i]
		CurrentData.itemList[i] = item.itemID
		if item.content then
			CurrentData.contentTypesData[item.itemID] = item.content
		end
	end
	
	
	-- load all items into cache and after finish refresh the frame
	ItemQuery:AddItemInfoList(CurrentData.itemList, NewSet)
	
	self.frame:Show()
end

--function SVF:
local function FrameOnDragStart(self, arg1)
	if arg1 == "LeftButton" then
		self:StartMoving()
	end
end

local function FrameOnDragStop(self)
	self:StopMovingOrSizing()
	local a,b,c,d,e = self:GetPoint()
	db.point = { a, nil, c, d, e }
end

function SVF:Create()
	if self.frame then return end
	local frame = CreateFrame("Frame", SVF_FRAME_NAME)
	self.frame = frame
	frame:SetParent(UIParent)
	frame:SetSize(SVF_FRAME_WIDTH, SVF_FRAME_HEIGHT)
	frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	frame:SetBackdropColor(0,0,0,1)
	frame:SetPoint(db.point[1], db.point[2], db.point[3], db.point[4], db.point[5])
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:RegisterForDrag("LeftButton", "RightButton")
	frame:SetScript("OnMouseDown", FrameOnDragStart)
	frame:SetScript("OnMouseUp", FrameOnDragStop)
	--frame:SetScript("OnEvent", FrameOnEvent)
	--frame:SetScript("OnShow", FrameOnShow)
	--frame:SetScript("OnHide", FrameOnHide)
	--frame:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	
	frame.closeButton = CreateFrame("Button", SVF_FRAME_NAME.."-CloseButton", frame, "UIPanelCloseButton")
	frame.closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 3, 4)
	
	frame.title = GetTextFrameWithBackground(frame, 0, 0, {r=0, g=0.86, b=1}, {r=1, g=1, b=1})
	frame.title:SetPoint("TOPLEFT", frame, 5, -5)
	frame.title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -28, -20)
	frame.title.text:SetText(AL["AtlasLoot Set View"])
	
	frame.modelFrame = CreateFrame("DressUpModel", SVF_FRAME_NAME.."-ModelFrame", frame, "ModelWithControlsTemplate")
	frame.modelFrame:ClearAllPoints()
	frame.modelFrame:SetParent(frame)
	frame.modelFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -25)
	frame.modelFrame:SetSize(MODEL_FRAME_WIDTH, MODEL_FRAME_HEIGHT)
	frame.modelFrame:SetRotation(MODELFRAME_DEFAULT_ROTATION)
	frame.modelFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	frame.modelFrame:SetBackdropColor(1,1,1,1)
	frame.modelFrame:SetUnit("player")
	frame.modelFrame.minZoom = -0.3
	frame.modelFrame.maxZoom = 1.0
	frame.modelFrame.zoomLevel = frame.modelFrame.minZoom
	frame.modelFrame:SetPortraitZoom(frame.modelFrame.zoomLevel)
	
	frame.containerFrame = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame")
	frame.containerFrame:ClearAllPoints()
	frame.containerFrame:SetParent(frame)
	frame.containerFrame:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT", 0, -5)
	frame.containerFrame:SetPoint("TOPRIGHT", frame.modelFrame, "TOPLEFT", -5, 0)
	frame.containerFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 5, 5)
	--frame.containerFrame:SetHeight(200)
	--frame.containerFrame:SetBackdrop(BACKDROP_DATA)
	--frame.containerFrame:SetBackdropColor(0,0.86,1,1)
	frame.containerFrame.content = {}
	
	CONTAINER_FRAME_WIDTH = frame.containerFrame:GetWidth()
	CONTAINER_FRAME_HEIGHT = frame.containerFrame:GetHeight()
	
	frame.containerFrame.topFrame = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame-TopFrame")
	frame.containerFrame.topFrame:ClearAllPoints()
	frame.containerFrame.topFrame:SetParent(frame.containerFrame)
	frame.containerFrame.topFrame:SetPoint("TOPLEFT", frame.containerFrame, 5, -5)
	frame.containerFrame.topFrame:SetPoint("BOTTOMRIGHT", frame.containerFrame, "TOPRIGHT", -5, -25)
	frame.containerFrame.topFrame:SetBackdrop(BACKDROP_DATA)
	frame.containerFrame.topFrame:SetBackdropColor(1,0,0,1)
	
	frame.containerFrame.subTopFrame = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame-SubTopFrame")
	frame.containerFrame.subTopFrame:ClearAllPoints()
	frame.containerFrame.subTopFrame:SetParent(frame.containerFrame)
	frame.containerFrame.subTopFrame:SetPoint("TOPLEFT", frame.containerFrame.topFrame, "BOTTOMLEFT", 0, -2)
	frame.containerFrame.subTopFrame:SetPoint("BOTTOMRIGHT", frame.containerFrame.topFrame, "BOTTOMRIGHT", 0, -20)
	--frame.containerFrame.subTopFrame:SetBackdrop(BACKDROP_DATA)
	--frame.containerFrame.subTopFrame:SetBackdropColor(0,0,1,1)
	frame.containerFrame.subTopFrame.content = {}
	
	frame.containerFrame.bottomFrame = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame-BottomFrame")
	frame.containerFrame.bottomFrame:ClearAllPoints()
	frame.containerFrame.bottomFrame:SetParent(frame.containerFrame)
	frame.containerFrame.bottomFrame:SetPoint("BOTTOMLEFT", frame.containerFrame, 5, 5)
	frame.containerFrame.bottomFrame:SetPoint("TOPRIGHT", frame.containerFrame, "BOTTOMRIGHT", -5, 25)
	--frame.containerFrame.bottomFrame:SetBackdrop(BACKDROP_DATA)
	--frame.containerFrame.bottomFrame:SetBackdropColor(1,0,0,1)
	frame.containerFrame.bottomFrame.content = {}
	
	CONTAINER_ITEM_PLACE_HEIGHT = frame.containerFrame:GetHeight() - 16 - frame.containerFrame.topFrame:GetHeight() - frame.containerFrame.subTopFrame:GetHeight() - frame.containerFrame.bottomFrame:GetHeight()
	
	--frame:Hide()
end

function SVF.ResetFrames()
	db.point = { "CENTER" }
	if SVF.frame then
		SVF.frame:ClearAllPoints()
		SVF.frame:SetPoint(db.point[1])
	end
end

function AtlasLoot:Teest()
	SVF:Create()
		
	SVF:SetNewItemSet(AtlasLoot.Data.Sets:GetSet("Std", "testSet"))
end

--/run print('Shift click to link:', '\124cffb048f8\124Hitem:99416:0:0:0:0:0:0:0:0:0:491:1:351\124h[Blackhand\'s Faceguard]\124h\124r')
