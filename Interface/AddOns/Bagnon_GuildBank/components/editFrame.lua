--[[
	itemFrame.lua
		An guild bank item slot container (by João Cardoso)
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local EditFrame = Bagnon:NewClass('EditFrame', 'ScrollFrame')


--[[ Constructor ]]--

function EditFrame:New(frameID, parent)
	local f = self:Bind(CreateFrame('ScrollFrame', parent:GetName() .. 'LogFrame', parent, 'UIPanelScrollFrameTemplate'))
	local bg = f.ScrollBar:CreateTexture()
	bg:SetTexture(0, 0, 0, .5)
	bg:SetAllPoints()
	
	local edit = CreateFrame('EditBox', nil, f)
	edit:SetScript('OnEscapePressed', edit.ClearFocus)
	edit:SetScript('OnEditFocusLost', self.OnEditFocusLost)
	edit:SetScript('OnCursorChanged', self.OnCursorChanged)
	edit:SetScript('OnTextChanged', self.OnTextChanged)
	edit:SetScript('OnMouseDown', self.OnMouseDown)
	edit:SetScript('OnUpdate', self.OnUpdate)
	
	edit:SetFontObject(GameFontHighlightSmall)
	edit:SetAutoFocus(false)
	edit:SetMaxLetters(500)
	edit:SetMultiLine(true)
	edit:SetPoint('TOPLEFT')
	edit:SetSize(300, 300)
	
	f:SetScript('OnEvent', function(f, event, ...) f[event](f, ...) end)
	f:SetScript('OnShow', f.OnShow)
	f:SetScript('OnHide', f.OnHide)
	f:SetScrollChild(edit)
	f:Hide()
	
	f:RegisterMessage('GUILD_BANK_CLOSED')
	f:RegisterEvent('GUILDBANK_UPDATE_TEXT')
	f:RegisterEvent('GUILDBANK_TEXT_CHANGED')
	f:RegisterEvent('PLAYER_LOGOUT')
	return f
end


--[[ Game Events ]]--

function EditFrame:GUILDBANK_UPDATE_TEXT (tab)
	if tab == GetCurrentGuildBankTab() then
		self:Update()
	end
end

function EditFrame:GUILDBANK_TEXT_CHANGED (tab)
	if tab == GetCurrentGuildBankTab() then
		QueryGuildBankText(tab)
	end
end

function EditFrame:PLAYER_LOGOUT ()
	self.OnEditFocusLost(self:GetScrollChild()) -- save on logout
end


--[[ Editbox Events ]]--

function EditFrame:OnUpdate(elapsed)
	ScrollingEdit_OnUpdate(self, elapsed, self:GetParent())
end

function EditFrame:OnCursorChanged(x, y, ...)
	ScrollingEdit_OnCursorChanged(self, x, y - 10, ...)
end

function EditFrame:OnTextChanged()
	ScrollingEdit_OnTextChanged(self, self:GetParent())
end

function EditFrame:OnMouseDown()
	if CanEditGuildTabInfo(GetCurrentGuildBankTab()) then
		self:SetFocus()
	end
end

function EditFrame:OnEditFocusLost()
	if self:GetText() ~= self.text then
		SetGuildBankText(GetCurrentGuildBankTab(), self:GetText())
	end
end


--[[ Frame Events ]]--

function EditFrame:OnShow()
	QueryGuildBankText(GetCurrentGuildBankTab())
	self:RegisterMessage('GUILD_BANK_TAB_CHANGE')
	self:Update()
end

function EditFrame:OnHide()
	self:UnregisterMessage('GUILD_BANK_TAB_CHANGE')
	self:GetScrollChild():ClearFocus()
end

function EditFrame:Update()
	local text = GetGuildBankText(GetCurrentGuildBankTab()) or ''
	local edit = self:GetScrollChild()

	edit.text = text
	edit:SetText(text)
end

EditFrame.GUILD_BANK_TAB_CHANGE = EditFrame.Update
EditFrame.GUILD_BANK_CLOSED = EditFrame.Hide