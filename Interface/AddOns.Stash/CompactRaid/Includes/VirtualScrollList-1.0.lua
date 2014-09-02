-----------------------------------------------------------
-- VirtualScrollList-1.0.lua
-----------------------------------------------------------
-- A virtual scroll list is a scroll list frame that is capable of displaying infinite
-- amount of user data with a fixed number of list buttons. Blizzard's FauxScrollFrame
-- does basically the same thing, though this one is far more powerful and convenient to use.
--
-- Abin (2010-1-27)

-----------------------------------------------------------
-- API Documentation:
-----------------------------------------------------------

-- frame = UICreateVirtualScrollList("name", parent, maxButtons [, selectable [, checkable [, "listType" [, "buttonTemplate"]]]) -- Create a virtual scroll list frame, if "listType" is specified "ITEM", "SPELL", "SPELL_ITEM", "ITEM_SPELL", the list will automatically display icons, names and tooltips for spell/item info

-- frame:CreateBorder(hasBkgnd) -- Decorate the list frame with a tooltip border and an optional background
-- frame:EnableDrag(enable) -- Enable drag-drop
-- frame:IsDragEnabled(enable) -- Return whether drag-drop is enabled
-- frame:GetScrollOffset() -- Return current scroll offset (0-N)
-- frame:SetScrollOffset(offset) -- Scroll the list
-- frame:CheckVisible([position]) -- Check whether a position is visible in the list (nil-invalid, 0-visible, other-invisible), "position" defaults to current selection
-- frame:EnsureVisible([position]) -- Ensure a position being visible, scroll the list if needed, "position" defaults to current selection
-- frame:RefreshContents() -- Refresh the entire list, call only when necessary!
-- frame:ScheduleRefresh() -- Schedule a contents refreshing on next "OnUpdate" call

-- frame:SetSelection(position) -- Select a data
-- frame:GetSelection() -- Get current selection

-- frame:BindDataList(table) -- Bind a numeric-indexed data table to the list
-- frame:GetDataCount() -- Return number of data in the list
-- frame:GetData(position) -- Retrieve a particular data
-- frame:SetData(position, data) -- Modify an existing data
-- frame:FindData(data [, compareFunc]) == Search for the first match of a particular data
-- frame:InsertData(data [, position]) -- Insert a new data to the list, by default the data is inserted at the end of list
-- frame:RemoveData(position) -- Remove an existing data, by default it removes the last data from the list
-- frame:ShiftData(position1, position2) -- Shift a data from position1 to position2
-- frame:SwapData(position1, position2) -- Swap 2 data in the list
-- frame:MoveData(position, "direction") -- Move a data towards the specified direction ("UP", "DOWN", "TOP", "BOTTOM")
-- frame:UpdateData(position) -- Call frame:OnButtonUpdate(button, data) if the list button reflects to position is visible at the moment
-- frame:Clear() -- Clear the list, all data are deleted

-----------------------------------------------------------
-- Callback Methods:
-----------------------------------------------------------

-- frame:OnReceiveDrag(dataType, data, subType, subData) --  Called when the list or a list button receives a drag-drop or a click with something at cursor
-- frame:OnButtonCreated(button) -- Called when a new list button is created
-- frame:OnButtonUpdate(button, data) -- Called when a list button needs to be re-painted
-- frame:OnButtonTooltip(button, data, tooltip) -- Called when the mouse hovers a list button, you only need to populate texts into tooltip(GameTooltip)
-- frame:OnButtonEnter(button, data, motion) -- Called when the mouse hovers a list button
-- frame:OnButtonLeave(button, data, motion) -- Called when the mouse leaves a list button
-- frame:OnSelectionChanged(position, data) -- Called when the selection changed
-- frame:OnButtonClick(button, data, flag, down) -- Called when a list button is clicked
-- frame:OnButtonDoubleClick(button, data) -- Called when a list button is double-clicked
-- frame:OnButtonCheckBox(button, data, checkbox, checked) -- Called when a list button checkbox is checked or unchecked

-----------------------------------------------------------

local type = type
local CreateFrame = CreateFrame
local tinsert = tinsert
local tremove = tremove
local min = min
local max = max
local floor = floor
local ipairs = ipairs
local wipe = wipe
local error = error
local format = format
local strupper = strupper
local hooksecurefunc = hooksecurefunc
local GetCursorInfo = GetCursorInfo
local ClearCursor = ClearCursor
local GetSpellInfo = GetSpellInfo
local GetSpellLink = GetSpellLink
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local pcall = pcall
local HandleModifiedItemClick = HandleModifiedItemClick
local GameTooltip = GameTooltip

local NIL = "!2BFF-1B787839!"

local MAJOR_VERSION = 1
local MINOR_VERSION = 36

-- To prevent older libraries from over-riding newer ones...
if type(UICreateVirtualScrollList_IsNewerVersion) == "function" and not UICreateVirtualScrollList_IsNewerVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local function EncodeData(data)
	return (data == nil) and NIL or data -- Must be nil, not false
end

local function DecodeData(data)
	return (data ~= NIL) and data or nil
end

local function SafeCall(func, ...)
	if type(func) == "function" then
		return func(...)
	end
end

-- Apply or remove a texture(highlight/checked) to/from a particular list button
local function Frame_TextureButton(self, textureName, button)
	local texture = self[textureName]
	if texture then
		if button then
			if texture.button ~= button then
				texture.button = button
				texture:SetParent(button)
				texture:ClearAllPoints()
				texture:SetPoint("TOPLEFT", 0, -1)
				texture:SetPoint("BOTTOMRIGHT")
				texture:Show()
			end
		else
			texture.button = nil
			texture:Hide()
		end
	end
end

local SPELL_COLOR_R, SPELL_COLOR_G, SPELL_COLOR_B, SPELL_COLOR_CODE = 0x71 / 0xff, 0xd5 / 0xff, 1

local function GetSpellData(id)
	local name, _, icon = GetSpellInfo(id)
	local link = GetSpellLink(id)
	return name, icon, link, SPELL_COLOR_R, SPELL_COLOR_G, SPELL_COLOR_B
end

local function GetItemData(id)
	local name, link, quality, _, _, _, _, _, _, icon = GetItemInfo(id)
	local r, g, b = GetItemQualityColor(quality)
	return name, icon, link, r, g, b
end

local function GetDataInfo(listType, id)
	if type(id) == "table" and listType == "TABLE" then
		return id.name, id.icon, id.link, id.r, id.g, id.b
	end

	if type(id) == "number" and id > 0 then
		if listType == "SPELL" then
			return GetSpellData(id)
		elseif listType == "ITEM" then
			return GetItemData(id)
		end
	end
end

local function Frame_UpdateButton(self, button, data)
	if self.listType then
		button._dataLink = nil
		local name, icon, link, r, g, b = GetDataInfo(self.listType, data)
		button._dataLink = link
		button.icon:SetTexture(icon)
		button.text:SetText(name)
		if r then
			button.text:SetTextColor(r, g, b)
		end
	end
	SafeCall(self.OnButtonUpdate, self, button, data)
end

local function Frame_OnButtonTooltip(self, button, data)
	GameTooltip:SetOwner(button, "ANCHOR_LEFT")
	GameTooltip:ClearLines()

	if button._dataLink then
		pcall(GameTooltip.SetHyperlink, GameTooltip, button._dataLink)
	end

	if type(self.OnButtonTooltip) == "function" then
		self:OnButtonTooltip(button, data, GameTooltip)
	end

	GameTooltip:Show()
end

-- Schedule a frame refresh
local function Frame_ScheduleRefresh(self)
	self._updateElapsed = 0
	self.needRefresh = 1
end

local function Frame_GetScrollOffset(self)
	return self.scrollBar:GetValue()
end

local function Frame_SetScrollOffset(self, offset)
	if type(offset) == "number" then
		self.scrollBar:SetValue(offset)
		return Frame_GetScrollOffset(self)
	end
end

local function Frame_ProcessOnReceiveDrag(self)
	if not self:IsDragEnabled() then
		return
	end

	local dataType, data, subType, subData = GetCursorInfo()
	if dataType then
		if SafeCall(self.OnReceiveDrag, self, dataType, data, subType, subData) then
			ClearCursor()
		end
		return dataType
	end
end

local function Frame_OnSelectionChanged(self)
	local selection = self.selection
	local data = self:GetData(selection)
	self:RefreshContents()
	self:EnsureVisible(selection)
	SafeCall(self.OnSelectionChanged, self, selection, data)
end

local function ListButton_OnEnter(self, motion)
	local parent = self:GetParent()
	if not parent.selectable or parent.checkedTexture:GetParent() ~= self then
		Frame_TextureButton(parent, "highlightTexture", self)
	end
	SafeCall(parent.OnButtonEnter, parent, self, self.data, motion)
	Frame_OnButtonTooltip(parent, self, self.data)
end

local function ListButton_OnLeave(self, motion)
	local parent = self:GetParent()
	Frame_TextureButton(parent, "highlightTexture")
	GameTooltip:Hide()
	SafeCall(parent.OnButtonLeave, parent, self, self.data, motion)
end

local function ListButton_OnClick(self, flag, down)
	local parent = self:GetParent()
	if flag == "LeftButton" then
		if Frame_ProcessOnReceiveDrag(parent) then
			return
		end

		if parent.selectable then
			local dataIndex = self:GetID() + Frame_GetScrollOffset(parent)
			if parent.selection ~= dataIndex then
				Frame_TextureButton(self:GetParent(), "checkedTexture", self)
				Frame_TextureButton(self:GetParent(), "highlightTexture")
				parent.selection = dataIndex
				Frame_OnSelectionChanged(parent)
			end
		end
	end

	if self._dataLink then
		HandleModifiedItemClick(self._dataLink)
	end

	SafeCall(parent.OnButtonClick, parent, self, self.data, flag, down)
end

local function ListButton_OnDoubleClick(self, flag)
	if flag == "LeftButton" then
		local parent = self:GetParent()
		SafeCall(parent.OnButtonDoubleClick, parent, self, self.data)
	end
end

local function ListButton_OnReceiveDrag(self)
	Frame_ProcessOnReceiveDrag(self:GetParent())
end

-- Get the list button which is currently displaying the given data
local function Frame_PositionToButton(self, position)
	return self.listButtons[position - Frame_GetScrollOffset(self)]
end

local function Frame_UpdateButtonData(self, position)
	local button = Frame_PositionToButton(self, position)
	if button then
		button.data = DecodeData(self.listData[position])
		Frame_UpdateButton(self, button, button.data)
	end
end

local function CheckBox_OnClick(self)
	local button = self:GetParent()
	local parent = button:GetParent()
	SafeCall(parent.OnButtonCheckBox, parent, button, button.data, self, self:GetChecked() and 1 or nil)
end

-- Create a list button
local function Frame_CreateListButton(self, id)
	local button = CreateFrame("Button", self:GetName().."Button"..id, self, self.buttonTemplate)
	button:SetID(id)

	if type(self.buttonHeight) == "number" then
		button:SetHeight(self.buttonHeight)
	else
		button:SetHeight(20)
	end

	local prev = self.listButtons[id - 1]
	if prev then
		button:SetPoint("TOPLEFT", prev, "BOTTOMLEFT")
		button:SetPoint("TOPRIGHT", prev, "BOTTOMRIGHT")
	else
		button:SetPoint("TOPLEFT")
		button:SetPoint("TOPRIGHT", self.scrollBar, "TOPLEFT")
	end

	tinsert(self.listButtons, button)

	if self.checkbox then
		button.check = CreateFrame("CheckButton", button:GetName().."Check", button, "InterfaceOptionsCheckButtonTemplate")
		button.check:SetHitRectInsets(0, 0, 0, 0)
		button.check:SetPoint("LEFT", 4, 0)
		button.check:SetScript("OnClick", CheckBox_OnClick)
	end

	if self.listType then
		button.icon = button:CreateTexture(button:GetName().."Icon", "BORDER")
		button.icon:SetSize(16, 16)
		button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		if button.check then
			button.icon:SetPoint("LEFT", button.check, "RIGHT", 4, 0)
		else
			button.icon:SetPoint("LEFT", 4, 0)
		end
		button.text = button:CreateFontString(button:GetName().."Text", "BORDER", "GameFontHighlightLeft")
		button.text:SetPoint("LEFT", button.icon, "RIGHT", 4, 0)
	end

	SafeCall(self.OnButtonCreated, self, button, id)

	button:HookScript("OnEnter", ListButton_OnEnter)
	button:HookScript("OnLeave", ListButton_OnLeave)
	button:HookScript("OnClick", ListButton_OnClick)
	button:HookScript("OnDoubleClick", ListButton_OnDoubleClick)
	button:HookScript("OnReceiveDrag", ListButton_OnReceiveDrag)

	return button
end

local function Frame_CheckVisible(self, position)
	if not position then
		position = self.selection
	end

	if type(position) ~= "number" or not self.listData[position] then
		return
	end

	local low = Frame_GetScrollOffset(self) + 1
	local high = low + self.maxButtons - 1

	if position < low then
		return position - low
	elseif position > high then
		return position - high
	else
		return 0
	end
end

local function Frame_EnsureVisible(self, position)
	local visible = Frame_CheckVisible(self, position)
	if visible then
		if visible ~= 0 then
			Frame_SetScrollOffset(self, Frame_GetScrollOffset(self) + visible)
		end
		return 1
	end
end

-- Update list buttons' contents, gives the user a chance to re-paint buttons
local function Frame_UpdateList(self)
	local offset = self.scrollBar:GetValue()
	local i, checkedButton
	for i = 1, self.maxButtons do
		local button = self.listButtons[i]
		local dataIndex = i + offset
		local data = self.listData[dataIndex]
		if data ~= nil then
			if not button then
				button = Frame_CreateListButton(self, i)
			end

			if not checkedButton and self.selection == dataIndex then
				checkedButton = button
			end

			button.data = DecodeData(data)
			Frame_UpdateButton(self, button, button.data)
			button:Hide()
			button:Show()
		elseif button then
			button.data = nil
			button:Hide()
		end
	end
	Frame_TextureButton(self, "checkedTexture", checkedButton)
end

-- Refresh list contents including scroll bar stats after the list frame is resized or data are inserted/removed
local function Frame_RefreshContents(self)
	self.needRefresh = nil
	local scrollBar = self.scrollBar
	local maxButtons = self.maxButtons
	local dataCount = #(self.listData)
	local range = max(0, dataCount - maxButtons)

	if range > 0 then
		scrollBar:SetWidth(16)
		scrollBar:Show()
	else
		scrollBar:Hide()
		scrollBar:SetWidth(1)
	end

	scrollBar:SetMinMaxValues(0, range)
	if scrollBar:GetValue() > range then
		scrollBar:SetValue(range)
	else
		Frame_UpdateList(self)
	end
end

local function ScrollBar_OnValueChanged(self, value)
	Frame_UpdateList(self:GetParent())
end

local function Frame_GetDataCount(self)
	return #(self.listData)
end

local function Frame_FindData(self, data, compareFunc)
	compareFunc = type(compareFunc) == "function" and compareFunc
	local i, stored
	for i, stored in ipairs(self.listData) do
		local d = DecodeData(stored)
		if compareFunc then
			if compareFunc(d, data) then
				return i
			end
		else
			if d == data then
				return i
			end
		end
	end
end

local function Frame_GetData(self, position)
	if not position then
		position = self.selection
	end

	return DecodeData(self.listData[position])
end

local function Frame_SetData(self, position, data)
	if not position then
		position = self.selection
	end

	if self.listData[position] then
		self.listData[position] = EncodeData(data)
		Frame_UpdateButtonData(self, position)
		return 1
	end
end

local function Frame_InsertData(self, data, position)
	local limit = #(self.listData) + 1
	position = type(position) == "number" and min(limit, max(1, floor(position))) or limit
	tinsert(self.listData, position, EncodeData(data))

	if self.selection and position < self.selection then
		self.selection = position
		Frame_OnSelectionChanged(self)
	end

	Frame_ScheduleRefresh(self)
	return position
end

local function Frame_RemoveData(self, position)
	if not position then
		position = self.selection
	end

	local data
	if type(position) == "number" then
		data = tremove(self.listData, position)
	else
		position = #(self.listData)
		data = tremove(self.listData)
	end

	if not data then
		return
	end

	local selection = self.selection
	if selection and not self:SetSelection(selection) then
		self:SetSelection(selection - 1)
		Frame_OnSelectionChanged(self)
	end

	Frame_ScheduleRefresh(self)
	return DecodeData(data)
end

local function Frame_ShiftData(self, position1, position2)
	if not position1 then
		position1 = self.selection
	end

	if type(position1) ~= "number" or type(position2) ~= "number" or position1 == position2 then
		return
	end

	if not self.listData[position1] or not self.listData[position2] then
		return
	end

	tinsert(self.listData, position2, tremove(self.listData, position1))

	if self.selection then
		local selection = self.selection
		if selection == position1 then
			selection = position2
		elseif position1 < position2 then
			if selection > position1 and selection <= position2 then
				selection = selection - 1
			end
		elseif position1 > position2 then
			if selection >= position2 and selection < position1 then
				selection = selection + 1
			end
		end

		if self.selection ~= selection then
			self.selection = selection
			Frame_OnSelectionChanged(self)
			return position2
		end
	end

	Frame_UpdateList(self)
	return 1
end

local function Frame_UpdateData(self, position)
	if not position then
		position = self.selection
	end

	local data = self.listData[position]
	if not data then
		return
	end

	local low = Frame_GetScrollOffset(self) + 1
	local high = low + self.maxButtons - 1
	if position < low or position > high then
		return
	end

	local button = Frame_PositionToButton(self, position)
	if button then
		Frame_UpdateButton(self, button, DecodeData(data))
		return 1
	end
end

local function Frame_Clear(self)
	wipe(self.listData)
	Frame_SetScrollOffset(self, 0)
	if self.selection then
		self.selection = nil
		Frame_OnSelectionChanged(self)
	end
	Frame_RefreshContents(self)
end

local function Frame_GetSelection(self)
	if self.selection then
		local data = self.listData[self.selection]
		return self.selection, DecodeData(data)
	end
end

local function Frame_SetSelection(self, position)
	if not self.selectable then
		return
	end

	if type(position) ~= "number" or not self.listData[position] then
		position = 0
	end

	if self.selection ~= position then
		self.selection = position
		Frame_TextureButton(self, "checkedTexture", Frame_PositionToButton(self, position))
		Frame_OnSelectionChanged(self)
	end
	return 1
end

local function Frame_SwapData(self, position1, position2)
	if not position1 then
		position1 = self.selection
	end

	if type(position1) ~= "number" or type(position2) ~= "number" or position1 == position2 then
		return
	end

	local data1 = self.listData[position1]
	local data2 = self.listData[position2]
	if data1 and data2 then
		self.listData[position1] = data2
		self.listData[position2] = data1

		Frame_UpdateButtonData(self, position1)
		Frame_UpdateButtonData(self, position2)

		if self.selection == position1 then
			Frame_SetSelection(self, position2)
		elseif self.selection == position2 then
			Frame_SetSelection(self, position1)
		end

		return position2
	end
end

local function Frame_MoveData(self, position, direction)
	if not position then
		position = self.selection
	end

	if type(direction) == "string" then
		direction = strupper(direction)

		if direction == "UP" then
			return Frame_SwapData(self, position, position - 1)
		elseif direction == "DOWN" then
			return Frame_SwapData(self, position, position + 1)
		elseif direction == "TOP" then
			return Frame_ShiftData(self, position, 1)
		elseif direction == "BOTTOM" then
			return Frame_ShiftData(self, position, Frame_GetDataCount(self))
		end
	end
end

local function Frame_OnMouseWheel(self, value)
	local scrollBar = self.scrollBar
	local _, range = scrollBar:GetMinMaxValues()
	if range > 0 then
		scrollBar:SetValue(scrollBar:GetValue() - max(1, range / 10) * value)
	end
end

local function Frame_OnUpdate(self, elapsed)
	self._updateElapsed = (self._updateElapsed or 0) + elapsed
	if self._updateElapsed > 0.2 then
		self._updateElapsed = 0
		if self.needRefresh then
			Frame_RefreshContents(self)
		end
	end
end

local function Frame_OnReceiveDrag(self)
	Frame_ProcessOnReceiveDrag(self)
end

local function Frame_OnMouseDown(self, flag)
	Frame_ProcessOnReceiveDrag(self)
end

local function Frame_EnableDrag(self, enable)
	self.enableDrag = enable
	self:EnableMouse(enable)
	if enable then
		self:SetScript("OnMouseDown", Frame_OnMouseDown)
		self:SetScript("OnReceiveDrag", Frame_OnReceiveDrag)
	else
		self:SetScript("OnMouseDown", nil)
		self:SetScript("OnReceiveDrag", nil)
	end
end

local function Frame_IsDragEnabled(self)
	return self.enableDrag
end

local function Frame_BindDataList(self, list)
	if type(list) == "table" then
		self.listData = list
		Frame_UpdateList(self)
	else
		Frame_Clear(self)
	end

	Frame_SetSelection(self, 0)
end

local function Frame_CreateBorder(self, hasBkgnd)
	local frame = self.borderFrame
	if frame then
		return frame
	end

	frame = CreateFrame("Frame", nil, self)
	self.borderFrame = frame

	frame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, insets = {left = 5, right = 5, top = 5, bottom = 5 } })
	frame:SetBackdropBorderColor(0.75, 0.75, 0.75, 0.75)
	frame:SetPoint("TOPLEFT", -4, 5)
	frame:SetPoint("BOTTOMRIGHT", 4, -4)

	if not hasBkgnd then
		frame:SetBackdropColor(0, 0, 0, 0)
	end

	return frame
end

local function ItemEventFrame_OnShow(self)
	self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
end

local function ItemEventFrame_OnEvent(self)
	Frame_ScheduleRefresh(self:GetParent())
end

-- Create the scroll list frame
function UICreateVirtualScrollList(name, parent, maxButtons, selectable, checkbox, listType, buttonTemplate)
	if type(name) ~= "string" then
		error(format("bad argument #1 to 'UICreateVirtualScrollList' (string expected, got %s)", type(name)))
		return
	end

	local frame = CreateFrame("Frame", name, parent)
	if not frame then
		error("'UICreateVirtualScrollList' frame creation failed, check name and parent")
		return
	end

	frame:EnableMouseWheel(true)
	frame.maxButtons = type(maxButtons) == "number" and max(1, floor(maxButtons)) or 1
	frame.selectable = selectable
	frame.checkbox = checkbox
	frame.listButtons = {}
	frame.listData = {}

	if type(listType) == "string" then
		frame.listType = listType
	end

	if type(buttonTemplate) == "string" then
		frame.buttonTemplate = buttonTemplate
	elseif type(buttonTemplate) == "number" and buttonTemplate > 1 then
		frame.buttonHeight = buttonTemplate
	end

	if listType == "ITEM" then
		local ief = CreateFrame("Frame", nil, frame)
		ief:SetScript("OnShow", ItemEventFrame_OnShow)
		ief:SetScript("OnHide", itemEventFrame.UnregisterAllEvents)
		ief:SetScript("OnEvent", ItemEventFrame_OnEvent)
	end

	local scrollBar = CreateFrame("Slider", frame:GetName().."ScrollBar", frame, "UIPanelScrollBarTemplate")
	frame.scrollBar = scrollBar
	scrollBar:SetScript("OnValueChanged", ScrollBar_OnValueChanged)
	scrollBar:SetPoint("TOPRIGHT", 0, -16)
	scrollBar:SetPoint("BOTTOMRIGHT", 0, 16)
	scrollBar:Hide()
	scrollBar:SetWidth(1)
	scrollBar:SetValueStep(1)
	scrollBar:SetMinMaxValues(0, 0)
	scrollBar:SetValue(0)

	frame.highlightTexture = frame:CreateTexture(name.."HighlightTexture", "BORDER")
	frame.highlightTexture:Hide()
	frame.highlightTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
	frame.highlightTexture:SetBlendMode("ADD")
	frame.highlightTexture:SetVertexColor(0.196, 0.388, 0.8, 0.8)

	if selectable then
		frame.checkedTexture = frame:CreateTexture(name.."CheckedTexture", "BORDER")
		frame.checkedTexture:Hide()
		frame.checkedTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		frame.checkedTexture:SetBlendMode("ADD")
		frame.checkedTexture:SetVertexColor(1, 1, 1, 0.8)
	end

	frame:SetScript("OnShow", Frame_ScheduleRefresh)
	frame:SetScript("OnSizeChanged", Frame_ScheduleRefresh)
	frame:SetScript("OnMouseWheel", Frame_OnMouseWheel)
	frame:SetScript("OnUpdate", Frame_OnUpdate)
	frame:SetScript("OnReceiveDrag", Frame_OnReceiveDrag)
	frame.needRefresh = 1

	-- Public API
	frame.CreateBorder = Frame_CreateBorder
	frame.GetSelection = Frame_GetSelection
	frame.SetSelection = Frame_SetSelection
	frame.GetScrollOffset = Frame_GetScrollOffset
	frame.SetScrollOffset = Frame_SetScrollOffset
	frame.CheckVisible = Frame_CheckVisible
	frame.EnsureVisible = Frame_EnsureVisible
	frame.GetDataCount = Frame_GetDataCount
	frame.GetData = Frame_GetData
	frame.SetData = Frame_SetData
	frame.FindData = Frame_FindData
	frame.InsertData = Frame_InsertData
	frame.RemoveData = Frame_RemoveData
	frame.ShiftData = Frame_ShiftData
	frame.SwapData = Frame_SwapData
	frame.UpdateData = Frame_UpdateData
	frame.Clear = Frame_Clear
	frame.RefreshContents = Frame_RefreshContents
	frame.EnableDrag = Frame_EnableDrag
	frame.IsDragEnabled = Frame_IsDragEnabled
	frame.BindDataList = Frame_BindDataList
	frame.MoveData = Frame_MoveData
	frame.ScheduleRefresh = Frame_ScheduleRefresh
	return frame
end

-- Provides version check
function UICreateVirtualScrollList_IsNewerVersion(major, minor)
	if type(major) ~= "number" or type(minor) ~= "number" then
		return false
	end

	if major > MAJOR_VERSION then
		return true
	elseif major < MAJOR_VERSION then
		return false
	else -- major equal, check minor
		return minor > MINOR_VERSION
	end
end