--[[
	Sets options panel
--]]

local ADDON, Addon = ...
local Panel = Addon:NewPanel('Sets')

local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')
local Sets = Combuctor('Sets')

local selected, items = {}, {}
local frame

local MAX_ITEMS = 14
local HEIGHT = 26

local sendMessage = function(msg, ...)
	Sets:Send(msg, Addon.frame, ...)
end

local getInfo = function()
  return Combuctor:GetProfile()[Addon.frame]
end

local function AddSet(name)
	local info = getInfo()
	local sets = info.sets

	for i, set in pairs(sets) do
		if set.name == name then
			return
		end
	end
	
	tinsert(sets, name)
	sendMessage('COMBUCTOR_CONFIG_SET_ADD', name)
end

local function RemoveSet(name)
	local info = getInfo()
	local sets = info.sets

	for i,set in pairs(sets) do
		if set == name then
			tremove(sets, i)
			sendMessage('COMBUCTOR_CONFIG_SET_REMOVE', name)
			break
		end
	end
end

local function AddSubSet(name, parent)
	local info = getInfo()
	local exclude = info.exclude[parent]

	if exclude then
		for i,set in pairs(exclude) do
			if set == name then
				tremove(exclude, i)
				if #exclude < 1 then
					info.exclude[parent] = nil
				end

				sendMessage('COMBUCTOR_CONFIG_SUBSET_ADD', name, parent)
				break
			end
		end
	end
end

local function RemoveSubSet(name, parent)
	local info = getInfo()
	local exclude = info.exclude[parent]

	if exclude then
		for i,set in pairs(exclude) do
			if set == name then
				return
			end
		end
		tinsert(exclude, name)
	else
		info.exclude[parent] = {name}
	end
	sendMessage('COMBUCTOR_CONFIG_SUBSET_REMOVE', name, parent)
end

local function HasSet(name)
	local info = getInfo()
 
	for i,setName in pairs(info.sets) do
		if setName == name then
			return true
		end
	end
	return false
end

local function HasSubSet(name, parent)
	local info = getInfo()
	local exclude = info.exclude[parent]

	if exclude then
		for j,child in pairs(exclude) do
			if child == name then
				return false
			end
		end
	end
	return true
end

--list button
local function ListButtonCheck_OnClick(self)
	local set = self:GetParent().set
	if set.parent then
		if self:GetChecked() then
			AddSubSet(set.name, set.parent)
		else
			RemoveSubSet(set.name, set.parent)
		end
	else
		if self:GetChecked() then
			AddSet(set.name)
		else
			RemoveSet(set.name)
		end
	end
end

local function ListButtonToggle_OnClick(self)
	local set = self:GetParent().set

	selected[set.name] = not selected[set.name]
	self:GetParent():GetParent():UpdateList()
end

local function ListButton_Set(self, set)
	self.set = set

	if set.icon then
		_G[self.check:GetName() .. 'Text']:SetFormattedText('|T%s:%d|t %s', set.icon, 26, set.name)
	else
		_G[self.check:GetName() .. 'Text']:SetText(set.name)
	end

	if set.parent then
		self.toggle:Hide()
	else
		self.toggle:Show()

		if selected[set.name] then
			self.toggle:SetNormalTexture('Interface\\Buttons\\UI-MinusButton-UP')
			self.toggle:SetPushedTexture('Interface\\Buttons\\UI-MinusButton-DOWN')
		else
			self.toggle:SetNormalTexture('Interface\\Buttons\\UI-PlusButton-UP')
			self.toggle:SetPushedTexture('Interface\\Buttons\\UI-PlusButton-DOWN')
		end
	end

	if set.parent then
		self.check:SetChecked(HasSubSet(set.name, set.parent))
	else
		self.check:SetChecked(HasSet(set.name))
	end
end

local function ListButton_Create(id, parent)
	local name = format('%sButton%d', parent:GetName(), id)
	local b = CreateFrame('Frame', name, parent)
	b:SetWidth(200)
	b:SetHeight(24)
	b.Set = ListButton_Set

	local toggle = CreateFrame('Button', nil, b)
	toggle:SetPoint('LEFT', b)
	toggle:SetWidth(14)
	toggle:SetHeight(14)
	toggle:SetNormalTexture('Interface\\Buttons\\UI-PlusButton-UP')
	toggle:SetPushedTexture('Interface\\Buttons\\UI-PlusButton-DOWN')
	toggle:SetHighlightTexture('Interface\\Buttons\\UI-PlusButton-Hilight')
	toggle:SetScript('OnClick', ListButtonToggle_OnClick)
	b.toggle = toggle

	local check = CreateFrame('CheckButton', name .. 'Check', b, 'InterfaceOptionsCheckButtonTemplate')
	check:SetScript('OnClick', ListButtonCheck_OnClick)
	check:SetPoint('LEFT', toggle, 'RIGHT', 4, 0)
	b.check = check

	return b
end


--[[ Panel Functions ]]--

local function Panel_UpdateList(self)
	local items = {}

	for _,parentSet in Sets:GetParentSets() do
		tinsert(items, parentSet)
		if selected[parentSet.name] then
			for _,childSet in Sets:GetChildSets(parentSet.name) do
				tinsert(items, childSet)
			end
		end
	end

	local scrollFrame = self.scrollFrame
	local offset = FauxScrollFrame_GetOffset(scrollFrame)
	local i = 1

	while i <= MAX_ITEMS and items[i + offset] do
		local button = self.buttons[i]
		button:Set(items[i + offset])

		local offLeft = button.set.parent and 24 or 0
		button:SetPoint('TOPLEFT', 14 + offLeft, -(100 + 30 * i))
		button:Show()

		i = i + 1
	end

	for j = i, #self.buttons do
		self.buttons[j]:Hide()
	end

	FauxScrollFrame_Update(scrollFrame, #items, MAX_ITEMS, self.buttons[1]:GetHeight())
end

do
	Panel.UpdateList = Panel_UpdateList
  Panel.OnFrameChanged = Panel_UpdateList
	Panel:SetScript('OnHide', function(self) selected = {} end)

	local scroll = CreateFrame('ScrollFrame', '$parentScrollFrame', Panel, 'FauxScrollFrameTemplate')
  scroll:SetPoint('TOPLEFT', 6, -120)
  scroll:SetPoint('BOTTOMRIGHT', -32, 8)

	scroll:SetScript('OnVerticalScroll', function(self, arg1)
		FauxScrollFrame_OnVerticalScroll(self, arg1, HEIGHT, function()
			Panel:UpdateList()
		end)
	end)

  local bg = scroll.ScrollBar:CreateTexture()
  bg:SetTexture(0, 0, 0, .3)
  bg:SetAllPoints()

	Panel.scrollFrame = scroll
	Panel.buttons = setmetatable({}, {__index = function(t, k)
		t[k] = ListButton_Create(k, Panel)
		return t[k]
	end})
end