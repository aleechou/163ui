
-- Table

--[[

Includes

Tabber (CTab) class to switch between tabs
Table Header (CTableHeader) class to handle table columns' data.  Headers store scripting functions
ScrollBar (CScrollBar) class to navigate the table list
Table Body (CTable) class to hold the data, headers, rows, cells, scroll bar, etc.  Bodies store the view and data indices,which is important for retrieving the correct data row

]]
CTableVersion = "3-23-2011"


CTab = CreateFrame("Frame")
CTab_metatable = {__index = CTab}
function CTab:Create(parent)
	local new_CTab = {}
	new_CTab = CreateFrame("Frame",nil, parent)
	new_CTab.activeTab = nil
	new_CTab.buttons = {}
	new_CTab.colors = {}
	new_CTab.tabs = {}
	setmetatable(new_CTab, CTab_metatable)
	return new_CTab
end

function CTab:UpdateTab(id, text)
	self.buttons[id].text2:SetText(text)
end
function CTab:ActivateTab(id)
	for k,v in pairs(self.tabs) do
		if k == id then
			v:Show()
			self.buttons[k]:SetBackdropColor(self.colors[k][1] or 0,self.colors[k][2] or 0,self.colors[k][3] or 0)
			self.buttons[k].text:SetTextColor(1,1,1)
		else
			v:Hide()
			self.buttons[k]:SetBackdropColor(0,0,0)
			self.buttons[k].text:SetTextColor(self.colors[k][1] or 0,self.colors[k][2] or 0,self.colors[k][3] or 0)
		end
	end
end

function CTab:AddTab(name, baseframe, color)

	-- add button with name
	local button = CreateFrame("Button",nil, self)
	button.text = button:CreateFontString()
	button.text:SetFontObject(GameFontNormalSmall)
	button.text:SetTextColor(0,0,0)
	button.text:SetText(name)
	button.text:SetPoint("RIGHT",button,"CENTER")
	button.text2 = button:CreateFontString()
	button.text2:SetFontObject(GameFontNormalSmall)
	button.text2:SetTextColor(1,1,1)
	button.text2:SetText("(test)")
	button.text2:SetPoint("LEFT",button,"CENTER",2,0)
	button:SetWidth(200)
	button:SetHeight(20)
	button.color = color
	--button:SetNormalTexture("Interface/Buttons/WHITE8X8.blp")
	button:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8.blp",tile=false})

	if #self.buttons > 0 then
		button:SetPoint("LEFT",self.buttons[#self.buttons], "RIGHT" )
	else
		button:SetPoint("LEFT",self, "LEFT" )
	end
	table.insert(self.colors,color)
	table.insert(self.buttons,button)
	button.id = #self.buttons
	button:SetScript("OnClick",function(self) self:GetParent():ActivateTab(self.id) end)

	table.insert(self.tabs,baseframe)
	if activeTab == nil then
		activeTab = name
	end
end

CTableHeader = {}
CTableHeader_metatable = {__index = CTableHeader}
function CTableHeader:Create(text, column_index, width, update_func, creation_func, onclick_func, onenter_func, onleave_func)
	local new_CTableHeader = {}

	new_CTableHeader.width = width
	new_CTableHeader.text = text
	new_CTableHeader.update_func = update_func
	new_CTableHeader.column_index = column_index
	new_CTableHeader.creation_func = creation_func
	new_CTableHeader.onclick_func = onclick_func
	new_CTableHeader.onenter_func = onenter_func
	new_CTableHeader.onleave_func = onleave_func


	setmetatable(new_CTableHeader, CTableHeader_metatable)
	return new_CTableHeader
end
function CTableHeader:EditHeader(newtext,newcolumn_index)
	self.text = newtext
	self.column_index = newcolumn_index
end

function CTableHeader:GetText()
	return self.text
end
function CTableHeader:GetWidth()
	return self.width
end
function CTableHeader:GetDataIndex()
	return self.column_index
end
function CTableHeader:UpdateObjectData(objecttoupdate, data)
	if self.update_func then
		self.update_func(objecttoupdate,data)
	else
		objecttoupdate:SetText(data)
	end
end
function CTableHeader:CreateObject(parent)
	local object
	if self.creation_func then
		object = self.creation_func(parent)
	else
		object = parent:CreateFontString()
		object:SetFontObject(GameFontNormalSmall)
		object:SetText("?")

	end

	object.header_ref = self

	if self.onclick_func and object.HasScript and object:HasScript("OnClick") then
		object:EnableMouse(true)
		object:SetScript("OnClick",function(self)
			self.header_ref.onclick_func(self,
					self:GetParent():GetParent():GetParent():GetDataRowIndex(self:GetParent().row) )
		end)
	end
	if self.onenter_func and object.HasScript and object:HasScript("OnEnter") then

		object:EnableMouse(true)
		object:SetScript("OnEnter",function(self)
			self.header_ref.onenter_func(self,
					self:GetParent():GetParent():GetParent():GetDataRowIndex(self:GetParent().row) )
		end)
	end
	if self.onleave_func and object.HasScript and object:HasScript("OnLeave") then
		object:EnableMouse(true)
		object:SetScript("OnLeave",function(self)
			self.header_ref.onleave_func(self,
					self:GetParent():GetParent():GetParent():GetDataRowIndex(self:GetParent().row) )

		end)
	end
	return object
end



CScrollBar = CreateFrame("Frame")
CScrollBar_metatable = {__index = CScrollBar}

function CScrollBar:Create(parent)
	local new_CScrollBar = {}
	new_CScrollBar = CreateFrame("Frame",nil, parent)
	new_CScrollBar:SetHeight(parent:GetHeight())
	new_CScrollBar:SetWidth(16)

	new_CScrollBar:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8.blp",tile=false})
	new_CScrollBar:SetBackdropColor(0,0,0,.5)

	--new_CScrollBar.currentposition = 1
	new_CScrollBar.maxsize = 0
	new_CScrollBar.stepsize = 1
	new_CScrollBar.viewsize = 0

	new_CScrollBar.object = nil
	new_CScrollBar.object_function =nil

	-- up arrow box
	new_CScrollBar.up = CreateFrame("Button",nil, new_CScrollBar)
	new_CScrollBar.up:SetWidth(16)
	new_CScrollBar.up:SetHeight(16)
	new_CScrollBar.up:SetPoint("TOP",new_CScrollBar,"TOP")
	new_CScrollBar.up:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\uparrow.tga")
	new_CScrollBar.up:SetScript("OnClick",function(self) self:GetParent():StepUp() end)

	-- down arro box
	new_CScrollBar.down = CreateFrame("Button",nil, new_CScrollBar)
	new_CScrollBar.down:SetWidth(16)
	new_CScrollBar.down:SetHeight(16)
	new_CScrollBar.down:SetPoint("BOTTOM",new_CScrollBar,"BOTTOM")
	new_CScrollBar.down:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\downarrow.tga")
	new_CScrollBar.down:SetScript("OnClick",function(self) self:GetParent():StepDown() end)

	-- middle tab scroller
	new_CScrollBar.tab = CreateFrame("Frame",nil, new_CScrollBar)
	new_CScrollBar.tab:SetWidth(16)
	new_CScrollBar.tab:SetHeight(32)
	new_CScrollBar.tab:SetPoint("TOP",new_CScrollBar,"TOP",0,-16)
	new_CScrollBar.tab:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8.blp",tile=false})
	new_CScrollBar.tab:SetBackdropColor(1,1,1)
	new_CScrollBar.tab:EnableMouse("true")
	new_CScrollBar.tab:SetScript("OnMouseDown",function(self) self:GetParent():StartMouseTracking() end)
	new_CScrollBar.tab:SetScript("OnMouseUp",function(self) self:GetParent():StopMouseTracking() end)


	setmetatable(new_CScrollBar, CScrollBar_metatable)
	return new_CScrollBar
end

function CScrollBar:SetStepScroll(object,objects_function)
	self.object = object
	self.object_unitscrollfunction = objects_function
end
function CScrollBar:SetPercentScroll(object,objects_function)
	self.object = object
	self.object_percentscrollfunction = objects_function
end

function CScrollBar:SetViewSize(size)
	self.viewsize = math.floor(size)
	if self.viewsize <0 then
		self.viewsize = 0
	end
end

function CScrollBar:SetStepSize(size)
	self.stepsize = math.floor(size)
	if self.stepsize <=0 then
		self.stepsize = 1
	end
end

function CScrollBar:SetDataSize(size)
	self.maxsize = size
end

function CScrollBar:UpdateTabPosition(view_position)
	if self.viewsize-self.maxsize ~= 0 then
		self.tab:SetPoint("TOP",self,"TOP",0,-16 -((view_position-1)/(self.maxsize-self.viewsize)) * (self:GetHeight()-16-16-self.tab:GetHeight()))
	else
		self.tab:SetPoint("TOP",self,"TOP",0,-16)
	end
end

function CScrollBar:StepUp()
	self.object_unitscrollfunction(self.object,-self.stepsize)
end
function CScrollBar:StepDown()
	self.object_unitscrollfunction(self.object,self.stepsize)
end


function CScrollBar:StartMouseTracking()
	self:SetScript("OnUpdate",function(self)
		self.mousex, self.mousey = GetCursorPosition()
		self.mousey = self.mousey/UIParent:GetEffectiveScale()

		self.tab:SetPoint("TOP",self,"TOP",0,self.mousey-self:GetTop()+self.tab:GetHeight()/2)
		if self.tab:GetBottom() < self:GetBottom() + 16 then
			self.tab:SetPoint("TOP",self,"TOP",0,-self:GetHeight()+16+self.tab:GetHeight())
		end
		if self.tab:GetTop() > self:GetTop() - 16 then
			self.tab:SetPoint("TOP",self,"TOP",0,-16)
		end

		self.object_percentscrollfunction(self.object,1-(self.tab:GetBottom() - (self:GetBottom()+16))/(self:GetHeight()-32-self.tab:GetHeight()))
	end)
end
function CScrollBar:StopMouseTracking()
	self:SetScript("OnUpdate",nil)
	self.object_percentscrollfunction(self.object,1-(self.tab:GetBottom() - (self:GetBottom()+16))/(self:GetHeight()-32-self.tab:GetHeight()))
end




















CTable = CreateFrame("Frame")
CTable_metatable = {__index = CTable}

function CTable:Create(parent, header_list, view_size, data, color)
	local new_CTable = CreateFrame("Frame",nil, parent)
	setmetatable(new_CTable, CTable_metatable)

	new_CTable:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8.blp",tile=false})
	--new_CTable:SetBackdropColor(.4,.4,.6,.5)

	if type(color) == "table" then
		new_CTable:SetBackdropColor(color[1] or .5,color[2] or .5,color[3] or .5)
	end


	new_CTable.headerlist = header_list
	new_CTable.data_count = 0
	new_CTable.viewtop_position = 1
	new_CTable.view_size = view_size or 20

	new_CTable.data = data

	new_CTable:SetHeight(20*21)
	new_CTable:SetWidth(16)

	-- UI portion

	-- Vertical Scroll bar
	new_CTable.scrollbar = CScrollBar:Create(new_CTable)
	new_CTable.scrollbar:SetStepScroll(new_CTable,CTable.ScrollByUnit)
	new_CTable.scrollbar:SetPercentScroll(new_CTable,CTable.ScrollToPercent)
	new_CTable.scrollbar:SetViewSize(new_CTable.view_size)
	new_CTable.scrollbar:SetPoint("TOPRIGHT",new_CTable,"TOPRIGHT")

	-- Headers and their buttons
	new_CTable.Headers = {}
	new_CTable.headerbg = CreateFrame("Frame",nil, new_CTable)
	new_CTable.headerbg:SetPoint("TOPLEFT",new_CTable,"TOPLEFT")
	new_CTable.headerbg:SetPoint("TOPRIGHT",new_CTable,"TOPRIGHT")
	new_CTable.headerbg:SetHeight(20)

	for k,header in pairs(header_list) do
		new_CTable:SetWidth(new_CTable:GetWidth() + header:GetWidth())

		new_CTable.Headers[k] = CreateFrame("Button",nil,new_CTable.headerbg)

		new_CTable.Headers[k].text = new_CTable.Headers[k]:CreateFontString()
		new_CTable.Headers[k].text:SetAllPoints(new_CTable.Headers[k])
		new_CTable.Headers[k].text:SetFontObject(GameFontNormalSmall)
		new_CTable.Headers[k].text:SetText(header:GetText())
		--new_CTable.Headers[k]:SetFont("FRIZQT__.TTF",12)
		new_CTable.Headers[k]:SetHeight(16)
		new_CTable.Headers[k]:SetWidth(header:GetWidth())
		new_CTable.Headers[k]:SetPoint("TOP",new_CTable.headerbg,"TOP")
		new_CTable.Headers[k]:SetPoint("BOTTOM",new_CTable.headerbg,"BOTTOM")



		--Print("header: "..header:GetText())
		--Print("index: "..k)
		--Print("width: "..header:GetWidth())
		if new_CTable.Headers[k-1] then
			new_CTable.Headers[k]:SetPoint("LEFT",new_CTable.Headers[k-1],"RIGHT")
		else
			new_CTable.Headers[k]:SetPoint("LEFT",new_CTable.headerbg,"LEFT")
		end

		new_CTable.Headers[k].columnindex = k

		new_CTable.Headers[k]:SetScript("OnClick",function(self) CTable.SortByColumn(self:GetParent():GetParent(),self.columnindex) CTable.UpdateView(self:GetParent():GetParent()) end)
	end

	-- Visible data rows
	new_CTable.Rows = {}
	new_CTable.rowbg = CreateFrame("Frame",nil, new_CTable)
	new_CTable.rowbg:SetPoint("BOTTOMLEFT",new_CTable,"BOTTOMLEFT")
	new_CTable.rowbg:SetPoint("TOPRIGHT",new_CTable.headerbg,"BOTTOMRIGHT")

	new_CTable.rowbg.highlightrow = new_CTable.rowbg:CreateTexture()
	--new_CTable.rowbg.highlightrow:SetTexture("Interface\\AddOns\\AddonManager\\highlightbox.tga")
	new_CTable.rowbg.highlightrow:SetTexture(0,0,0,.5)

	for i=1,new_CTable.view_size do
		new_CTable.Rows[i] = CreateFrame("Frame",nil, new_CTable.rowbg)
		new_CTable.Rows[i]:SetHeight(20)
		new_CTable.Rows[i]:SetPoint("TOPLEFT",new_CTable.rowbg,"TOPLEFT",0,-(i-1)*20)
		new_CTable.Rows[i]:SetPoint("RIGHT",new_CTable.rowbg,"RIGHT")
		new_CTable.Rows[i].row = i;

		new_CTable.Rows[i]:EnableMouse(true)
		new_CTable.Rows[i]:SetScript("OnEnter",function(self)
			self:GetParent().highlightrow:SetAllPoints(self)
			self:GetParent().highlightrow:Show()
		end)

		new_CTable.Rows[i]:SetScript("OnLeave",function(self)
			self:GetParent().highlightrow:Hide()
		end)

		for k,header in pairs(header_list) do
			new_CTable.Rows[i][k] = header:CreateObject(new_CTable.Rows[i])
			new_CTable.Rows[i][k]:SetWidth(header:GetWidth())
			new_CTable.Rows[i][k]:SetHeight(20)
			--new_CTable.Rows[i][k]:SetPoint("TOPLEFT",new_CTable.Rows[i][k-1] or new_CTable.Rows[i],"TOPLEFT")

			if new_CTable.Rows[i][k-1] then
				new_CTable.Rows[i][k]:SetPoint("TOPLEFT",new_CTable.Rows[i][k-1],"TOPRIGHT")
			else
				new_CTable.Rows[i][k]:SetPoint("TOPLEFT",new_CTable.Rows[i],"TOPLEFT")
			end
		end
	end

	return new_CTable
end

function CTable:UpdateHeaderText()
	for k,header in pairs(self.headerlist) do
		self.Headers[k].text:SetText(header:GetText())
	end
end

function CTable:GetDataRowIndex(visible_row_index)
	return (self.viewtop_position + visible_row_index - 1)
end

do
	-- temporary variables
	local view_pos, data_pos
	function CTable:UpdateView()
		-- step through each visible row
		view_pos = 1
		data_pos = self.viewtop_position

		--Print("Updating")
		while view_pos <= self.view_size do

			--Print("View position '"..view_pos.."' updating real data at position '"..data_pos.."''")
			if self.data[data_pos] then
				--Print("Data exists, updating columns")
				self.Rows[view_pos]:Show()
				for k,header in pairs(self.headerlist) do
					--Print("index "..header:GetDataIndex().."   data "..self.data[data_pos][header:GetDataIndex()])
					header:UpdateObjectData(self.Rows[view_pos][k], self.data[data_pos][header:GetDataIndex()])
				end
			else
				self.Rows[view_pos]:Hide()
			end
			view_pos = view_pos + 1
			data_pos = data_pos + 1
		end

		self.scrollbar:SetDataSize(table.maxn(self.data))
		self.scrollbar:SetDataSize(table.maxn(self.data))
		self.scrollbar:UpdateTabPosition(self.viewtop_position)
	end
end

-- for use by scroll bar
function CTable:ScrollToPercent(percentage)

	-- Our working percentage area is the data - viewarea

	--Print(percentage)
	self.viewtop_position = math.floor((table.maxn(self.data) - self.view_size+1)*percentage+.5)

	-- call scorll by unit (with 0 change) to run sanity checks and update
	self:ScrollByUnit(0)
end

function CTable:ScrollByUnit(unit)

	--scroll by "unit" positions

	-- if data size < viewsize, default to 1
	if table.maxn(self.data) <= self.view_size then
		self.viewtop_position = 1
		-- don't bother updating view!  no scrolling happened
		return
	end

	self.viewtop_position = self.viewtop_position + unit

	-- for scroll up (negative), just check that we aren't going pass zero
	if self.viewtop_position < 1 then
		self.viewtop_position = 1
	end

	-- for scroll down, check that that is actual data to scroll to
	if self.viewtop_position > table.maxn(self.data) - self.view_size then
		self.viewtop_position = table.maxn(self.data) - self.view_size + 1
	end

	-- update view
	self:UpdateView()
end

local function insertsort(A, func)
	local key,i
	for j=2, #A do
		key = A[j]
		i = j - 1
		while i > 0 and func(A[i],key) do
			A[i+1] = A[i]
			i = i - 1
		end
		A[i+1]=key
	end
end

function CTable:SortByColumn(column_index)

	if column_index == nil and self.lastsort then
		column_index = self.lastsort
	end

	if column_index then

		local sorting_index = self.headerlist[column_index]:GetDataIndex()

		if type(self.data[1][sorting_index]) == "string" then
			--[[if self.lastsort == column_index then
				self.lastsort = nil
				insertsort(self.data, function(a,b) return string.lower(a[sorting_index])<string.lower(b[sorting_index]) end)
			else]]
				self.lastsort = column_index
				insertsort(self.data, function(a,b) return string.lower(a[sorting_index])>string.lower(b[sorting_index]) end)
			--end
		else
			--[[if self.lastsort == column_index then
				self.lastsort = nil
				insertsort(self.data, function(a,b) return a[sorting_index]>b[sorting_index] end)
			else]]
				self.lastsort = column_index
				insertsort(self.data, function(a,b) return a[sorting_index]<b[sorting_index] end)
			--end
		end

		self.lastsort = column_index
	end

	-- update view
	--self:UpdateView()
end

