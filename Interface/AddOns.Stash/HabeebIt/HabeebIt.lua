local _, ns = ...

local currentEncounterID
local itemButtons = {}

local BACKDROP = {
	bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=], tile = true, tileSize = 16,
	edgeFile = [=[Interface\Tooltips\UI-Tooltip-Border]=], edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4}
}

local AL = LibStub:GetLibrary("AceLocale-3.0")
local LGIST = LibStub:GetLibrary("LibGroupInSpecT-1.0")

local Container = CreateFrame('Frame', 'HabeebItContainer', BonusRollFrame)
local Handle = CreateFrame('Button', 'HabeebItHandle', BonusRollFrame)

local Hotspot = CreateFrame('Frame', nil, BonusRollFrame)
local Buttons = CreateFrame('Frame', 'HabeebItSpecButtons', Hotspot)

local function SpecButtonClick(self)
	SetLootSpecialization(self.specID)
	Buttons:Hide()
	BonusRollFrame.SpecIcon:SetDesaturated(false)
end

local function SpecButtonEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_TOPRIGHT')
	GameTooltip:AddLine(self.name, 1, 1, 1)
	GameTooltip:Show()
end

local specButtons
local function HotspotEnter()
	if(not Buttons:IsShown()) then
		if(not specButtons) then
			local numSpecs = GetNumSpecializations()
			for index = 1, numSpecs do
				local specID, name, _, texture = GetSpecializationInfo(index)

				local SpecButton = CreateFrame('Button', nil, Buttons)
				SpecButton:SetPoint('LEFT', index * 28, 0)
				SpecButton:SetSize(22, 22)
				SpecButton:SetScript('OnClick', SpecButtonClick)
				SpecButton:SetScript('OnEnter', SpecButtonEnter)
				SpecButton:SetScript('OnLeave', GameTooltip_Hide)

				SpecButton.specID = specID
				SpecButton.name = name

				local Icon = SpecButton:CreateTexture(nil, 'OVERLAY', nil, 1)
				Icon:SetAllPoints()
				Icon:SetTexture(texture)

				local Ring = SpecButton:CreateTexture(nil, 'OVERLAY', nil, 2)
				Ring:SetPoint('TOPLEFT', -6, 6)
				Ring:SetSize(58, 58)
				Ring:SetTexture([=[Interface\Minimap\Minimap-TrackingBorder]=])
			end

			Buttons:SetSize(numSpecs * 28 + 34, 38)

			specButtons = true
		end

		BonusRollFrame.SpecIcon:SetDesaturated(true)
		Buttons:Show()
	end
end

local function HotspotLeave()
	if(not Buttons:IsMouseOver()) then
		BonusRollFrame.SpecIcon:SetDesaturated(false)
		Buttons:Hide()
	end
end

local function ButtonsLeave(self)
	local parent = GetMouseFocus():GetParent()
	if(not Hotspot:IsMouseOver() and not (parent and parent == self)) then
		BonusRollFrame.SpecIcon:SetDesaturated(false)
		self:Hide()
	end
end

local collapsed = true
local function HandleClick()
	Handle:ClearAllPoints()

	if(collapsed) then
		if(HabeebItDB.position == 'BOTTOM') then
			Handle.Arrow:SetTexCoord(1/2, 1, 1, 1, 1/2, 0, 1, 0)
			Handle:SetPoint('BOTTOM', Container, 0, -14)
		else
			Handle.Arrow:SetTexCoord(1, 0, 1/2, 0, 1, 1, 1/2, 1)
			Handle:SetPoint('TOP', Container, 0, 14)
		end

		Container:Show()
	else
		if(HabeebItDB.position == 'BOTTOM') then
			Handle.Arrow:SetTexCoord(0, 0, 1/2, 0, 0, 1, 1/2, 1)
			Handle:SetPoint('TOP', BonusRollFrame, 'BOTTOM', 0, 2)
		else
			Handle.Arrow:SetTexCoord(1/2, 1, 0, 1, 1/2, 0, 0, 0)
			Handle:SetPoint('BOTTOM', BonusRollFrame, 'TOP', 0, -2)
		end

		Container:Hide()
	end

	collapsed = not collapsed
end

function Container:HandleUpdate()
	self:ClearAllPoints()

	if(HabeebItDB.position == 'BOTTOM') then
		self:SetPoint('TOP', BonusRollFrame, 'BOTTOM')

		Handle.Arrow:SetTexCoord(0, 0, 1/2, 0, 0, 1, 1/2, 1)
		Handle.TopCenter:Hide()
		Handle.TopRight:Hide()
		Handle.TopLeft:Hide()
		Handle.BottomCenter:Show()
		Handle.BottomRight:Show()
		Handle.BottomLeft:Show()
	else
		self:SetPoint('BOTTOM', BonusRollFrame, 'TOP')

		Handle.Arrow:SetTexCoord(1/2, 1, 0, 1, 1/2, 0, 0, 0)
		Handle.TopCenter:Show()
		Handle.TopRight:Show()
		Handle.TopLeft:Show()
		Handle.BottomCenter:Hide()
		Handle.BottomRight:Hide()
		Handle.BottomLeft:Hide()
	end

	self:Hide()
	collapsed = true
end

local function HookStartRoll()
	local specID = GetLootSpecialization()
	if(not specID or specID == 0) then
		SetLootSpecialization(GetSpecializationInfo(GetSpecialization()))
	end
end

local function ItemButtonUpdate(self, elapsed)
	if(IsModifiedClick('COMPAREITEMS') or (GetCVarBool('alwaysCompareItems') and not IsEquippedItem(self.itemID))) then
		GameTooltip_ShowCompareItem()
	else
		ShoppingTooltip1:Hide()
		ShoppingTooltip2:Hide()
		ShoppingTooltip3:Hide()
	end

	if(IsModifiedClick('DRESSUP')) then
		ShowInspectCursor()
	else
		ResetCursor()
	end
end

local function ItemButtonClick(self)
	HandleModifiedItemClick(self.itemLink)
end

local function ItemButtonEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT')
	GameTooltip:SetItemByID(self.itemID)

	self:SetScript('OnUpdate', ItemButtonUpdate)
end

local function ItemButtonLeave(self)
	GameTooltip:Hide()

	self:SetScript('OnUpdate', nil)
end

local function GetItemLine(index)
	local ItemButton = itemButtons[index]
	if(not ItemButton) then
		ItemButton = CreateFrame('Button', nil, Container)
		ItemButton:SetSize(276, 38)

		local Icon = ItemButton:CreateTexture(nil, 'BACKGROUND')
		Icon:SetPoint('TOPLEFT', 1, -1)
		Icon:SetSize(36, 36)
		ItemButton.Icon = Icon

		local Background = ItemButton:CreateTexture(nil, 'BORDER')
		Background:SetAllPoints()
		Background:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures]])
		Background:SetTexCoord(0.00195313, 0.62890625, 0.61816406, 0.66210938)
		Background:SetDesaturated(true)

		local Name = ItemButton:CreateFontString(nil, 'ARTWORK', 'GameFontNormalMed3')
		Name:SetPoint('TOPLEFT', Icon, 'TOPRIGHT', 7, -4)
		Name:SetPoint('TOPRIGHT', -6, -4)
		Name:SetHeight(12)
		Name:SetJustifyH('LEFT')
		ItemButton.Name = Name

		local Class = ItemButton:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
		Class:SetPoint('BOTTOMRIGHT', Name, 'TOPLEFT', 224, -28)
		Class:SetSize(0, 12)
		Class:SetJustifyH('RIGHT')
		ItemButton.Class = Class

		local Slot = ItemButton:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
		Slot:SetPoint('BOTTOMLEFT', Icon, 'BOTTOMRIGHT', 7, 4)
		Slot:SetPoint('BOTTOMRIGHT', Class, 'BOTTOMLEFT', -15, 0)
		Slot:SetSize(0, 12)
		Slot:SetJustifyH('LEFT')
		ItemButton.Slot = Slot

		ItemButton:SetScript('OnClick', ItemButtonClick)
		ItemButton:SetScript('OnEnter', ItemButtonEnter)
		ItemButton:SetScript('OnLeave', ItemButtonLeave)

		itemButtons[index] = ItemButton
	end

	return ItemButton
end

function Container:Populate()
	local numItems = 0
	for index = 1, EJ_GetNumLoot() do
		local name, texture, slot, itemClass, itemID, itemLink, encounterID = EJ_GetLootInfoByIndex(index)
		if(encounterID == currentEncounterID) then
			numItems = numItems + 1

			local ItemButton = GetItemLine(numItems)
			ItemButton.Icon:SetTexture(texture)
			ItemButton.Name:SetText(name)
			ItemButton.Slot:SetText(slot)
			ItemButton.Class:SetText(itemClass)

			ItemButton.itemID = itemID
			ItemButton.itemLink = itemLink

			if(HabeebItDB.position == 'BOTTOM') then
				ItemButton:SetPoint('TOP', 0, (6 + ((numItems - 1) * 40)) * -1)
			else
				ItemButton:SetPoint('BOTTOM', 0, 6 + ((numItems - 1) * 40))
			end

			ItemButton:Show()
		end
	end

	self:SetHeight(math.max(50, 10 + (numItems * 40)))

	if(numItems > 0) then
		self.Empty:Hide()
	else
		self.Empty:Show()
	end

	if(EncounterJournal) then
		EncounterJournal:RegisterEvent('EJ_LOOT_DATA_RECIEVED')
		EncounterJournal:RegisterEvent('EJ_DIFFICULTY_UPDATE')
	end
end

function Container:Update()
	if(EncounterJournal) then
		EncounterJournal:UnregisterEvent('EJ_DIFFICULTY_UPDATE')
	end

	for index, button in pairs(itemButtons) do
		button:Hide()
	end

	local _, _, difficulty = GetInstanceInfo()
	EJ_SetDifficulty(difficulty > 0 and difficulty or 4)

	local currentInstance = EJ_GetCurrentInstance()
	EJ_SelectInstance(currentInstance > 0 and currentInstance or 322)
	EJ_SelectEncounter(currentEncounterID)

	local _, _, classID = UnitClass('player')
	EJ_SetLootFilter(classID, GetLootSpecialization() or GetSpecializationInfo(GetSpecialization() or 0) or 0)

	self:Populate()
end

function Container:Initialize()
	collapsed = false
	HandleClick()

	Container:Update()
end

function Container:EJ_LOOT_DATA_RECIEVED(event)
	if(EncounterJournal) then
		EncounterJournal:UnregisterEvent(event)
	end

	self:Populate()
end

function Container:PLAYER_LOOT_SPEC_UPDATED(event)
	self:Update()
end

function Container:SPELL_CONFIRMATION_PROMPT(event, spellID, confirmType)
	if(confirmType == CONFIRMATION_PROMPT_BONUS_ROLL) then
		currentEncounterID = ns.GetEncounterID(spellID)

		if(currentEncounterID) then
			self:RegisterEvent('EJ_LOOT_DATA_RECIEVED')
			self:RegisterEvent('PLAYER_LOOT_SPEC_UPDATED')

			self:Initialize()
		else
			print(HABEEBIT_INFO4)
		end
	end
end

function Container:SPELL_CONFIRMATION_TIMEOUT()
	currentEncounterID = nil

	self:UnregisterEvent('EJ_LOOT_DATA_RECIEVED')
	self:UnregisterEvent('PLAYER_LOOT_SPEC_UPDATED')
end

function Container:PLAYER_LOGIN()
	if(HabeebItDB.position == 'BOTTOM') then
		self:SetPoint('TOP', BonusRollFrame, 'BOTTOM')
		Handle:SetPoint('TOP', BonusRollFrame, 'BOTTOM', 0, 2)
	else
		self:SetPoint('BOTTOM', BonusRollFrame, 'TOP')
		Handle:SetPoint('BOTTOM', BonusRollFrame, 'TOP', 0, -2)
	end

	self:SetWidth(286)
	self:SetFrameLevel(self:GetParent():GetFrameLevel() - 2)
	self:SetBackdrop(BACKDROP)
	self:SetBackdropColor(0, 0, 0, 0.8)
	self:SetBackdropBorderColor(2/3, 2/3, 2/3)

	self:RegisterEvent('SPELL_CONFIRMATION_PROMPT')
	self:RegisterEvent('SPELL_CONFIRMATION_TIMEOUT')

	local Empty = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	Empty:SetPoint('CENTER')
	Empty:SetText(HABEEBIT_INFO3)
	self.Empty = Empty

	Handle:SetSize(64, 16)
	Handle:SetNormalTexture([=[Interface\RaidFrame\RaidPanel-Toggle]=])
	Handle:SetScript('OnClick', HandleClick)
	Handle.Arrow = Handle:GetNormalTexture()

	local HandleBackground = Handle:CreateTexture(nil, 'BACKGROUND')
	HandleBackground:SetAllPoints()
	HandleBackground:SetTexture(0, 0, 0, 0.8)

	local TopCenter = Handle:CreateTexture(nil, 'BORDER')
	TopCenter:SetPoint('TOP', 0, 4.5)
	TopCenter:SetSize(24, 12)
	TopCenter:SetTexture([=[Interface\RaidFrame\RaidPanel-UpperMiddle]=])
	Handle.TopCenter = TopCenter

	local TopRight = Handle:CreateTexture(nil, 'BORDER')
	TopRight:SetPoint('TOPRIGHT', 4, 4)
	TopRight:SetSize(24, 20)
	TopRight:SetTexture([=[Interface\RaidFrame\RaidPanel-UpperRight]=])
	TopRight:SetTexCoord(0, 1, 0, 0.8)
	Handle.TopRight = TopRight

	local TopLeft = Handle:CreateTexture(nil, 'BORDER')
	TopLeft:SetPoint('TOPLEFT', -4, 4)
	TopLeft:SetSize(24, 20)
	TopLeft:SetTexture([=[Interface\RaidFrame\RaidPanel-UpperLeft]=])
	TopLeft:SetTexCoord(0, 1, 0, 0.8)
	Handle.TopLeft = TopLeft

	local BottomCenter = Handle:CreateTexture(nil, 'BORDER')
	BottomCenter:SetPoint('BOTTOM', 0, -9)
	BottomCenter:SetSize(24, 12)
	BottomCenter:SetTexture([=[Interface\RaidFrame\RaidPanel-BottomMiddle]=])
	Handle.BottomCenter = BottomCenter

	local BottomRight = Handle:CreateTexture(nil, 'BORDER')
	BottomRight:SetPoint('BOTTOMRIGHT', 4, -6)
	BottomRight:SetSize(24, 22)
	BottomRight:SetTexture([=[Interface\RaidFrame\RaidPanel-BottomRight]=])
	BottomRight:SetTexCoord(0, 1, 0.1, 1)
	Handle.BottomRight = BottomRight

	local BottomLeft = Handle:CreateTexture(nil, 'BORDER')
	BottomLeft:SetPoint('BOTTOMLEFT', -4, -6)
	BottomLeft:SetSize(24, 22)
	BottomLeft:SetTexture([=[Interface\RaidFrame\RaidPanel-BottomLeft]=])
	BottomLeft:SetTexCoord(0, 1, 0.1, 1)
	Handle.BottomLeft = BottomLeft

	self:HandleUpdate()

	Hotspot:SetAllPoints(BonusRollFrame.SpecIcon)
	Hotspot:SetScript('OnEnter', HotspotEnter)
	Hotspot:SetScript('OnLeave', HotspotLeave)

	Buttons:SetPoint('LEFT', 4, 4)
	Buttons:SetScript('OnLeave', ButtonsLeave)

	hooksecurefunc('BonusRollFrame_StartBonusRoll', HookStartRoll)
end

Container:SetScript('OnEvent', function(self, event, ...) self[event](self, event, ...) end)
