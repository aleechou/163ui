--[[---------------------------------------
	Loot button click hook
	- row: Loot row
	- button: Mouse button
	- handled: True if any previous caller acted on event

	Hook like this:
	local XLootButtonOnClick_Orig = XLootButtonOnClick
	function XLootButtonOnClick(row, button, handled)
		if not handled and thing_i_want_to_check then
			handled = true
			dostuff()
		end
		XLootButtonOnClick(row, button, handled)
	end
--]]---------------------------------------

-- Include QDKP2 compatibility by request
function XLootButtonOnClick(row, button, handled)
	if not handled 
		and QDKP2_IsManagingSession
		and IsAltKeyDown()
		and button == 'LeftButton'
		and GetLootSlotLink(row.slot)
		and QDKP2_IsManagingSession()
		and row.quality > GetLootThreshold()
		and (not QDKP2_BidM_isBidding())
	then
		pcall(QDKP2_BidM_StartBid, row.item)
		if QDKP2GUI_Roster then
			QDKP2GUI_Roster:ChangeList('bid')
			QDKP2GUI_Roster:Show()
		end
		return true
	end
	return handled
end

-- Create module
local addon, L = XLoot:NewModule("Frame")
-- Prepare frame/global
local XLootFrame = CreateFrame("Frame", "XLootFrame", UIParent)
XLootFrame.addon = addon
-- Grab locals
local print, mouse_focus, opt = print
local GetItemBindType = XLoot.GetItemBindType

-------------------------------------------------------------------------------
-- Settings

local defaults = {
	profile = {
		frame_scale = 1.0,
		frame_alpha = 1.0,

		quality_color_frame = false,
		quality_color_slot = true,

		loot_texts_info = true,
		loot_texts_bind  = true,
		loot_texts_lock = true,

		font = STANDARD_TEXT_FONT,
		font_size_loot = 12,
		font_size_info = 10,
		font_size_quantity = 10,
		font_size_bottombuttons = 10,
		font_flag = "OUTLINE",

		loot_icon_size = 34,
		loot_row_height = 30,

		loot_highlight = true,
		 
		loot_alpha = 1.0,
		loot_collapse = false,
		
		frame_snap = true,
		frame_snap_offset_x = 0,
		frame_snap_offset_y = 0,
		frame_grow_upwards = false, -- Actually means "Snap to bottom item"
		
		frame_width_automatic = true,
		frame_width = 150,

		frame_position_x = GetScreenWidth()/2,
		frame_position_y = GetScreenHeight()/2,

		autoloots = {
			currency = 'never',
			tradegoods = 'never',
			quest = 'never',
			list = 'solo',
			all = 'never',
		},

		autoloot_item_list = '',
		
		frame_draggable = true,

		linkall_threshold = 2, -- Quality from 0 - 6, Poor - Artifact
		linkall_channel = 'RAID',
		linkall_show = 'grouped',

		old_close_button = false,

		frame_color_border = { .5, .5, .5 },
		frame_color_backdrop = { 0, 0, 0, .7 },
		frame_color_gradient = { .5, .5, .5, .3 },
		loot_color_border = { .5, .5, .5 },
		loot_color_backdrop = { 0, 0, 0, .9 },
		loot_color_gradient = { .5, .5, .5, .4 },
		loot_color_info = { .5, .5, .5 },
	}
}

-------------------------------------------------------------------------------
-- Module init

function addon:OnInitialize()
	self:InitializeModule(defaults, XLootFrame)
	opt = self.db.profile
	XLootFrame.opt = opt
end

function addon:OnEnable()
	-- Register events
	XLootFrame:RegisterEvent("LOOT_OPENED")
	XLootFrame:RegisterEvent("LOOT_CLOSED")
	XLootFrame:RegisterEvent("LOOT_SLOT_CLEARED")
	XLootFrame:RegisterEvent("MODIFIER_STATE_CHANGED")

	-- Disable default frame
	LootFrame:UnregisterEvent("LOOT_OPENED")
	LootFrame:UnregisterEvent("LOOT_CLOSED")
	LootFrame:UnregisterEvent("LOOT_SLOT_CLEARED")

	-- Register for escape close
	table.insert(UISpecialFrames, "XLootFrame")
	
	-- Reattach master looter frame
	MasterLooterFrame:SetScript('OnShow', 
	function(self)
		if XLootFrame:IsVisible() then 
			MasterLooterFrame:SetFrameLevel(XLootFrame:GetFrameLevel()+2)
			MasterLooterFrame:ClearAllPoints()
			MasterLooterFrame:SetPoint("BOTTOM",XLootFrame,"TOP")
		end
	end)
end

function addon:ApplyOptions()
	opt, XLootFrame.opt = self.opt, self.opt
	if XLootFrame.built then
		XLootFrame:UpdateAppearance()
		XLootFrame:Update(true)
	end
	XLootFrame:ParseAutolootList()
end

-- CLI output
local print, wprint = print, print
local function xprint(text) wprint(('%s: %s'):format('|c2244dd22XLoot|r', text)) end

-------------------------------------------------------------------------------
-- Link All

local LinkLoot, LinkDropdown
do
	local output = { }
	function LinkLoot(channel, isExtraChannel)
		local output, key, buffer = output, 1
		local sf = string.format

		if UnitExists('target') then
			output[1] = sf('%s:', UnitName('target'))
		end

		local linkthreshold, reached = opt.linkall_threshold
		for i=1, GetNumLootItems() do
			if GetLootSlotType(i) == LOOT_SLOT_ITEM then 
				local texture, item, quantity, rarity = GetLootSlotInfo(i)
				local link = GetLootSlotLink(i)
				if rarity >= linkthreshold then
					reached = true
					buffer = sf('%s%s%s', (output[key] and output[key].." " or ""), (quantity > 1 and quantity.."x" or ""), link)
					if strlen(buffer) > 255 then
						key = key + 1
						output[key] = (quantity > 1 and quantity.."x" or "")..link
					else
						output[key] = buffer
					end
				end
			end
		end

		if not reached then
			xprint(L.linkall_threshold_missed)
			return false
		end

		for k, v in pairs(output) do
			v  = string.gsub(v, "\n", " ", 1, true) -- DIE NEWLINES, DIE A HORRIBLE DEATH
			SendChatMessage(v, channel)
			output[k] = nil
		end

		return true
	end

	
	local function Click(dropdown, channel)
		LinkLoot(channel)
	end
	
	LinkDropdown = CreateFrame('Frame', 'XLootLinkDropdown')
	LinkDropdown.displayMode = 'MENU'
	local channels = {
		{ 'SAY', CHAT_MSG_SAY },
		{ 'PARTY', CHAT_MSG_PARTY },
		{ 'RAID', CHAT_MSG_RAID },
		{ 'RAID_WARNING', CHAT_MSG_RAID_WARNING },
		{ 'GUILD', CHAT_MSG_GUILD },
		{ 'OFFICER', CHAT_MSG_OFFICER },
	}
	local info = { }
	LinkDropdown.initialize = function(self, level)
		for i, c in ipairs(channels) do
			wipe(info)
			info.text = c[2]
			info.arg1 = c[1]
			info.func = Click
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, 1)
		end
	end
end

-------------------------------------------------------------------------------
-- Frame creation
--  Helpers
--  >Rows
--  >Loot frame

-- Universal events
local function OnDragStart()
	if opt.frame_draggable then
		XLootFrame:StartMoving()
	end
end

local function OnDragStop()
	XLootFrame:StopMovingOrSizing()
	opt.frame_position_x = XLootFrame:GetLeft()
	opt.frame_position_y = opt.frame_grow_upwards and XLootFrame:GetBottom() or XLootFrame:GetTop()
end

-- Fontstring sizes
local function AdjustFontstringSize(self)
	local text = self:GetText()
	self:SetHeight(self:GetStringHeight())
	self:SetText(text)
end

-- Colors
local function Darken(mult, ...)
	local r, g, b, a = ...
	if type(r) == 'table' then
		r, g, b, a = unpack(r)
	end
	return r * mult, g * mult, b * mult, a or 1
end

local function GetColor(self, key, mult)
	local skin, raw, default, t = self.skin, rawget(self.opt, key), defaults.profile[key]
	-- Use options if different from defaults
	if raw and (raw[1] ~= default[1] or raw[2] ~= default[2] or raw[3] ~= default[3] or raw[4] ~= default[4]) then
		t = raw
	-- Use skin if options are defaults
	elseif skin[key] then
		t = skin[key]
	-- Use defaults
	else
		t = default
	end
	-- Darken
	if mult then
		return Darken(mult, t)
	end
	return unpack(t)
end

-- Build individual loot row
local mouse_focus
local BuildRow
do
	local RowPrototype = XLoot.NewPrototype()
	-- Text helpers
	local function smalltext(text)
		text:SetDrawLayer'OVERLAY'
		text:SetHeight(10)
		text:SetJustifyH'LEFT'
		text.ext = ext
	end

	local function textpoints(text, item, row, x)
		text:SetPoint('LEFT', item, 'RIGHT', x, 0)
		text:SetPoint('RIGHT', row, 'RIGHT', -4, 0)
	end

	function RowPrototype:OffsetText(text, y)
		text:SetPoint('TOP', self, 0, y)
	end
	
	-- Color overrides
	function RowPrototype:SetBorderColor(r, g, b, a)
		self:_SetBorderColor(r, g, b, a or 1)
		self.frame_item:SetBorderColor(r, g, b, a or 1)
	end

	function RowPrototype:SetHighlightColor(r, g, b)
		self:SetHighlightColor(r, g, b)
		self.frame_item:SetHighlightColor(r, g, b)
	end

	-- Frame events
	do
		local function Row_ShowTooltip_Inner(self)
			local f
			local type = GetLootSlotType(self.slot)
			if type == LOOT_SLOT_ITEM then
				f = GameTooltip.SetLootItem
			elseif type == LOOT_SLOT_CURRENCY then
				f = GameTooltip.SetLootCurrency
			else
				return nil
			end
			GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 32, 0)
			f(GameTooltip, self.slot)
			CursorUpdate(self)
		end
		
		function RowPrototype:ShowTooltip()
			pcall(Row_ShowTooltip_Inner, self)
		end
	end		
	
	function RowPrototype:HighlightEnter()
		if self._highlights then
			self.frame_item:ShowHighlight()
		end
	end
	
	function RowPrototype:HighlightLeave()
		if self._highlights then
			self.frame_item:HideHighlight()
		end
	end
	
	function RowPrototype:OnEnter()
		self:HighlightEnter(self)
		mouse_focus = self
		self:ShowTooltip()
	end

	function RowPrototype:OnLeave()
		mouse_focus = nil
		self:HighlightLeave(self)
		GameTooltip:Hide()
		ResetCursor()
	end

	function RowPrototype:OnClick(button)
		if not XLootButtonOnClick(self, button) then
			if IsModifiedClick() then
				HandleModifiedItemClick(GetLootSlotLink(self.slot))
			else
	 			LootButton_OnClick(self, button)
			end
		end
	end
	
	-- Appearance/skin updates
	function RowPrototype:UpdateAppearance()
		local owner, opt = self.owner, self.owner.opt
		-- Colors
		self:SetBorderColor(owner:GetColor('loot_color_border'))
		self:SetBackdropColor(owner:GetColor('loot_color_backdrop', 0.7))
		self:SetGradientColor(owner:GetColor('loot_color_gradient'))
		self.frame_item:SetGradientColor(owner:GetColor('loot_color_gradient'))
		self.text_info:SetTextColor(owner:GetColor('loot_color_info'))
		self:SetAlpha(opt.loot_alpha)

		
		-- Text
		self.text_name:SetFont(opt.font, opt.font_size_loot)
		self.text_info:SetFont(opt.font, opt.font_size_info)
		self.text_quantity:SetFont(opt.font, opt.font_size_quantity, opt.font_flag)
		self.text_bind:SetFont(opt.font, 8, opt.font_flag)
		self.text_locked:SetFont(opt.font, 9, opt.font_flag)
		self.text_locked:SetText(LOCKED) -- Can't set text until font is set

		-- Resize fontstrings
		AdjustFontstringSize(self.text_name)
		AdjustFontstringSize(self.text_info)

		-- Dimensions
		self.frame_item:SetWidth(opt.loot_icon_size)
		self.frame_item:SetHeight(opt.loot_icon_size)
		self:SetHeight(opt.loot_row_height)
		
		-- Calculated row height
		owner.row_height = self:GetHeight() + owner.skin.row_spacing

		-- Highlight textures
		if opt.loot_highlight then
			if not self._highlights then
				owner:Highlight(self, 'row_highlight')
				owner:Highlight(self.frame_item, 'item_highlight')
			end
			self:SetHighlightColor(.8, .8, .8, .8)
			self.frame_item:SetHighlightColor(.8, .8, .8, .8)
		elseif self._highlights then
			self:SetHighlightColor(0, 0, 0, 0)
			self.frame_item:SetHighlightColor(0, 0, 0, 0)
		end

		-- Clear layout cache
		self.layout = nil
	end

	-- Bind texts
	local binds = {
		pickup = ('|cffff4422%s|r '):format(L.bind_on_pickup_short),
		equip = ('|cff44ff44%s|r '):format(L.bind_on_equip_short),
		use = ('|cff2244ff%s|r '):format(L.bind_on_use_short),
		account = 'BoA'
	}

	-- Update slot with loot
	function RowPrototype:Update(is_item, icon, name, link, quantity, quality, locked, isQuestItem, questId, isActive)
		local r, g, b, hex
		local owner = self:GetParent()
		local opt = owner.opt
		local text_info, text_name, text_bind = '', '', ''
		
		-- Items
		local layout = 'simple'
		if is_item then
			r, g, b, hex = GetItemQualityColor(quality)
			
			text_name = ('|c%s%s|r'):format(hex, name)
			
			if opt.loot_texts_info then -- This is a bit gnarly
				local _, _, _, _, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(link)
				local equip = itemType == ENCHSLOT_WEAPON and ENCHSLOT_WEAPON or itemEquipLoc ~= '' and _G[itemEquipLoc] or ''
				local itemtype = (itemSubType == 'Junk' and quality > 0) and MISCELLANEOUS or itemSubType
				text_info = ((type(equip) == 'string' and equip ~= '') and equip..', ' or '') .. itemtype
				layout = 'detailed'
			end
			
			if opt.loot_texts_bind then
				text_bind = binds[GetItemBindType(link)] or ''
			end
			
		-- Currency
		else
			r, g, b = .4, .4, .4
			text_name = name:gsub('\n', ', ')
		end
		
		-- Strings
		self.text_name:SetText(text_name)
		self.text_info:SetText(text_info)
		self.text_bind:SetText(text_bind)
		self.text_quantity:SetText(quantity > 1 and quantity or nil)
		if questId or isQuestItem then
			self.text_info:SetTextColor(1, .8, .1)
		else
			self.text_info:SetTextColor(owner:GetColor('loot_color_info'))
		end

		-- Icon
		self.texture_item:SetTexture(icon)
		if locked and opt.loot_texts_lock then
			self.text_locked:Show()
		else
			self.text_locked:Hide()
		end
		
		-- Layout
		if self.layout ~= layout then
			self.layout = layout
			if layout == 'simple' then
				self.text_name:SetPoint('LEFT', self.frame_item, 'RIGHT', 2, 0)
			else
				self.text_name:SetPoint('LEFT', self.frame_item, 'RIGHT', 2, (self.text_info:GetHeight()/2))
			end
		end

		-- Quality coloring
		if opt.quality_color_slot then
			self:SetBorderColor(Darken(owner.skin.color_mod, r, g, b))
		end
		
		-- Quest icon
		if questId then
			self.texture_bang:Show()
		else
			self.texture_bang:Hide()
		end
		
		-- Attach
		if self.i == 1 then
			self:SetPoint('TOP', 0, -10)
		else
			self:SetPoint('TOP', owner.rows[self.i-1], 'BOTTOM', 0, owner.skin.row_offset)
		end
		
		self:Show()
		
		return max(self.text_info:GetStringWidth() + 2, self.text_name:GetStringWidth())
	end

	-- Factory
	function BuildRow(frame, i)
		local frame_name, opt, fake = frame:GetName()..'Button'..i, frame.opt, frame.fake
		-- Create frames
		local row = CreateFrame('Button', fake and nil or frame_name, frame)
		local item = CreateFrame('Frame', nil, row)
		local tex = item:CreateTexture(fake and nil or frame_name..'IconTexture', 'BACKGROUND')
		local bang = item:CreateTexture(nil, 'OVERLAY')
		row.owner = frame
		row.frame_item = item
		row.texture_item = tex
		row.texture_bang = bang
		row.i = i

		-- Skin row
		frame:Skin(row)
		frame:Skin(item, 'item')

		-- Apply prototype after skin to override method
		RowPrototype:New(row)

		-- Create fontstrings
		local name = row:CreateFontString(fake and nil or frame_name..'Text')
		local info = row:CreateFontString()
		local bind = item:CreateFontString()
		local quantity = item:CreateFontString()
		local locked = item:CreateFontString()
		row.text_name = name
		row.text_info = info
		row.text_bind = bind
		row.text_locked = locked
		row.text_quantity = quantity

		-- Setup fontstrings
		smalltext(name)
		smalltext(info)
		smalltext(bind)
		smalltext(locked)
		smalltext(quantity)
		name:SetPoint('RIGHT', row, 'RIGHT', -4, 0)
		info:SetPoint('TOPLEFT', name, 'BOTTOMLEFT', 8, 0)
		info:SetPoint('TOPRIGHT', name, 'BOTTOMRIGHT')
		textpoints(name, item, row, 2)
		textpoints(info, item, row, 8)
		info:SetPoint('TOP', name, 'BOTTOM')
		bind:SetPoint('BOTTOMLEFT', 2, 2)
		quantity:SetPoint('BOTTOMRIGHT', -2, 2)
		quantity:SetJustifyH('RIGHT')
		locked:SetPoint('CENTER')
		locked:SetTextColor(1, .2, .1)

		-- Align frames (Dimensions set in UpdateAppearance)
		row:SetPoint('LEFT', 10, 0)
		row:SetPoint('RIGHT', -10, 0)

		item:SetPoint('LEFT', 0, 0)
		tex:SetPoint('TOPLEFT', 3, -3)
		tex:SetPoint('BOTTOMRIGHT', -3, 3)
		tex:SetTexCoord(.07,.93,.07,.93)
		bang:SetPoint('BOTTOMRIGHT')
		bang:SetWidth(16)
		bang:SetHeight(16)
		bang:SetTexture([[Interface\Minimap\ObjectIcons.blp]])
		bang:SetTexCoord(1/8, 2/8, 1/8, 2/8)

		-- Supplimental events for a configuration instance
		if fake then
			row:RegisterForClicks()
			row:SetScript('OnEnter', row.HighlightEnter)
			row:SetScript('OnLeave', row.HighlightLeave)
		-- Events for actual loot frame
		else
			row:RegisterForDrag('LeftButton')
			row:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
			row:SetScript('OnDragStart', OnDragStart)
			row:SetScript('OnDragStop', OnDragStop)
			row:SetScript('OnClick', row.OnClick)
			row:SetScript('OnEnter', row.OnEnter)
			row:SetScript('OnLeave', row.OnLeave)
		end

		-- Apply appearance
		row:UpdateAppearance()
		
		return row
	end
end

-- Build frame
do
	local FramePrototype = XLoot.NewPrototype()
	-- Frame snapping
	function FramePrototype:SnapToCursor()
		local x, y = GetCursorPosition()
		local f = self
		local s = f:GetEffectiveScale()

		if opt.frame_snap then
			-- Horizontal position
			if not f:IsShown() then
				x = (x / s) - 25
				local sWidth, fWidth, uWidth = GetScreenWidth(), f:GetWidth(), UIParent:GetWidth()
				if uWidth > sWidth then sWidth = uWidth end
				if x + fWidth > sWidth then x = sWidth - fWidth end
				if x < 0 then x = 0 end
				x = x + opt.frame_snap_offset_x
			else
				x = f:GetLeft() or x
			end
   
			-- Vertical position
			y = (y / s) + 25 * (opt.frame_grow_upwards and -1 or 1)
			local sHeight, fHeight, uHeight = GetScreenHeight(), f:GetHeight(), UIParent:GetHeight()
			if uHeight > sHeight then sHeight = uHeight end
			if y > sHeight then y = sHeight end
			if y - fHeight < 0 then y = fHeight end
			y = y + opt.frame_snap_offset_y
		else
			x = opt.frame_position_x or x
			y = opt.frame_position_y or y
		end
   
		-- Apply
		f:ClearAllPoints()
		f:SetPoint((opt.frame_grow_upwards and "BOTTOMLEFT" or "TOPLEFT"), UIParent, "BOTTOMLEFT", x, y)
	end

	-- function FramePrototype:SetAlpha(alpha)
	-- 	self.backdrop:SetAlpha(alpha)
	-- end

	
	-- Link loot menu
	function FramePrototype:LinkClick(button)
		if button == 'RightButton' then
			ToggleDropDownMenu(1, nil, LinkDropdown, self)--, GetCursorPosition())
		else
			LinkLoot(self:GetParent().opt.linkall_channel)
		end
	end

	function FramePrototype:OnHide()
		pcall(LootFrame_OnHide)
		for i,v in ipairs(self.rows) do
			v:Hide()
		end
		-- CloseLoot()
	end
	
	-- Bottom buttons
	local function BottomButton(frame, name, text, justify)
		local b = CreateFrame('Button', name, frame)
		b.text = b:CreateFontString(name..'Text', 'DIALOG')--, 'GameFontNormalSmall')
		b.text:SetFont(frame.opt.font, frame.opt.font_size_bottombuttons)
		b.text:SetText('|c22AAAAAA'..text)
		b.text:SetJustifyH(justify)
		b.text:SetAllPoints(b)
		b:SetFrameLevel(8)
		b:SetHeight(16)
		b:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]])
		b:ClearAllPoints()
		b:SetPoint('BOTTOM', 0, 3)
		b:SetHitRectInsets(-4, -4, 3, -2)
		b:Show()
		return b
	end

	function FramePrototype:UpdateHeight()
		if self.row_height then
			self:SetHeight(((self.link:IsShown() or self.close:IsShown()) and 26 or 20) + #self.slots * self.row_height)
		end
	end

	function FramePrototype:UpdateWidth(width_max)
		local width = self.opt.frame_width_automatic and (width_max + 70) or (self.opt.frame_width + 50)
		self:SetWidth(width)
		width = width * 0.5 - 10
		self.link:SetWidth(width)
		self.close:SetWidth(width)
	end

	function FramePrototype:UpdateLinkButton()
		local target, show, now = self.opt.linkall_channel, self.opt.linkall_show, false
		if show == 'auto' then
			if target == 'SAY' or
				((target == 'GUILD' or target == 'OFFICER') and IsInGuild()) or
				((target == 'RAID' or target == 'RAID_WARNING') and IsInRaid()) or
				(target == 'PARTY' and IsInGroup())
			then
				now = true
			end
		elseif show == 'always' 
				or (show == 'solo' and not IsInGroup()) 
				or (show == 'grouped' and IsInGroup()) then
			now = true
		end
		if now then
			self.link:Show()
		else
			self.link:Hide()
		end
	end
	
	function FramePrototype:SizeAndColor(max_width, max_quality)
		-- Update frame
		self:UpdateLinkButton()
		self:UpdateHeight()
		self:UpdateWidth(max_width)
		
		-- Color frame
		if self.opt.quality_color_frame then
			self.overlay:SetBorderColor(GetItemQualityColor(max_quality))
		end
	end
	
	-- Update skin/appearance
	function FramePrototype:UpdateAppearance()
		self.skin = self:Reskin()
		self.skin.row_offset = self.skin.row_spacing * -1

		-- Update colors/other
		self:SetScale(self.opt.frame_scale)
		self.overlay:SetAlpha(self.opt.frame_alpha)
		self.overlay:SetBorderColor(self:GetColor('frame_color_border'))
		self.overlay:SetGradientColor(self:GetColor('frame_color_gradient'))
		self.overlay:SetBackdropColor(self:GetColor('frame_color_backdrop', 0.7))
		
		-- Update loot frames
		for i, row in ipairs(self.rows) do
			row:UpdateAppearance()
		end
		
		-- Resize frame
		if #self.slots > 0 and self.opt.frame_width_automatic then
			local max_width, max = 0, math.max
			for i, slot in ipairs(self.slots) do
				max_width = max(max_width, slot.text_name:GetStringWidth(), slot.text_info:GetStringWidth())
			end
			self:UpdateWidth(max_width)
		end

		-- Show close buttons
		if opt.old_close_button then
			self.close:Hide()
			self.old_close:Show()
		else
			self.close:Show()
			self.old_close:Hide()
		end

		-- Text
		self.close.text:SetFont(opt.font, opt.font_size_bottombuttons)
		self.link.text:SetFont(opt.font, opt.font_size_bottombuttons)
	end

	-- Factory
	function XLootFrame.BuildFrame(f)
		local name = f:GetName()
		-- Setup frame
		FramePrototype:New(f)
		f:SetFrameStrata('DIALOG')
		f:SetFrameLevel(5)
		f:EnableMouse(1)
		
		-- Set up frame skins
		XLoot:MakeSkinner(f, {
			item = {
				backdrop = false
			},
			row_highlight = {
				type = 'highlight'
			},
			item_highlight = {
				type = 'highlight',
				layer = 'OVERLAY'
			}
		})

		
		-- Use a secondary frame for backdrop/border to allow the "frame" opacity to be changed
		local overlay = CreateFrame('Frame', nil, f)
		overlay:SetFrameLevel(5)
		overlay:SetAllPoints()
		f:Skin(overlay)
		f.overlay = overlay

		-- Link all button
		local link = BottomButton(f, name..'Link', L.button_link, 'MIDDLE')
		link:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
		link:SetPoint('LEFT', 6, 0)
		f.link = link

		-- Close button
		local close = BottomButton(f, name..'Close', L.button_close, 'MIDDLE')
		close:SetPoint('RIGHT', -6, 0)
		f.close = close

		-- Legacy close button
		local x = CreateFrame("Button", nil, f)
		x:SetWidth(30)
		x:SetHeight(30)
		local xtex = [[Interface\Buttons\UI-Panel-MinimizeButton-]]
		x:SetNormalTexture(xtex..'Up')
		x:SetPushedTexture(xtex..'Down')
		x:SetHighlightTexture(xtex..'Highlight')
		x:SetPoint('TOPRIGHT', 3, 3)
		x:SetHitRectInsets(3, 3, 3, 3)
		x:SetFrameLevel(f:GetFrameLevel()+2)
		-- f:Skin(x)
		-- x:SetBorderColor(.7, .7, .7)
		f.old_close = x


		-- Events
		if not f.fake then
			f:SetMovable(1)
			f:RegisterForDrag('LeftButton')
			f:SetScript('OnDragStart', OnDragStart)
			f:SetScript('OnDragStop', OnDragStop)
			f:SetScript('OnHide', f.OnHide)
			link:SetScript('OnClick', f.LinkClick)

			-- WoW now shows an error if any parameter is passed, and OnClick passes one
			local function CloseLoot_Nil()
				CloseLoot()
			end

			close:SetScript('OnClick', CloseLoot_Nil)
			x:SetScript('OnClick', CloseLoot_Nil)
		end

		f.GetColor = GetColor

		f.rows = setmetatable({}, { __index = function(t, k)
			local row = BuildRow(f, k)
			t[k] = row
			return row
		end })

		f.slots_index = {}
		f.slots = {}

		f:UpdateAppearance()
		f.built = true
	end
end

-- Main loot handler
local auto, auto_items = {}, {}
function XLootFrame:ParseAutolootList()
	wipe(auto_items)
	for item in opt.autoloot_item_list:gmatch("%s*([^,]+)%s*") do
		auto_items[item] = true
	end
end

local _bag_slots = {}
function XLootFrame:Update(in_options)
	local numloot = GetNumLootItems()
	if numloot == 0 then return nil end
	local max = math.max

	-- Construct frame
	if not self.built then
		self:BuildFrame()
		XLootFrame:ParseAutolootList()
	end

	-- References
	local rows, slots, slots_index = self.rows, wipe(self.slots), wipe(self.slots_index)
	
	-- Autolooting options
	local party = IsInGroup()
	local auto, auto_items, bag_slots = auto, auto_items 
	for k,v in pairs(opt.autoloots) do
		auto[k] = v == 'always' or (v == 'solo' and not party)
	end
	-- Update rows
	local max_quality, max_width, our_slot, slot = 0, 0, 0
	for slot = 1, numloot do
		local _, icon, name, quantity, quality, locked, isQuestItem, questId, isActive = pcall(GetLootSlotInfo, slot)
		-- local texture, item, quantity, quality, locked, isQuestItem, questId, isActive = GetLootSlotInfo(slot)
		if icon then -- Occasionally WoW will open loot with empty or invalid slots
			local looted = false
			-- Row data
			local is_item, link = (GetLootSlotType(slot) == LOOT_SLOT_ITEM)
			if is_item then
				link = GetLootSlotLink(slot)
			end

			-- Autolooting currency
			local type = GetLootSlotType(slot)
			if (auto.all or auto.currency) and (type == LOOT_SLOT_MONEY or type == LOOT_SLOT_CURRENCY) then
				LootSlot(slot)
				looted = true
				
			-- Autolooting items
			else
				-- TODO: Pass on to row update
				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(link or name)
				if auto.all or (auto.quest and isQuestItem) or (auto.list and auto_items[name]) or (auto.tradegoods and itemType == 'Trade Goods') then

					-- Cache available space
					--  Specific bag types make this a bit more annoying
					if not bag_slots then
						bag_slots = wipe(_bag_slots)
						for i = 0, NUM_BAG_SLOTS do
							local open, family = GetContainerNumFreeSlots(i)
							if family then
								bag_slots[family] = bag_slots[family] and bag_slots[family] + open or open
							end
						end
					end

					-- Simple quest item
					local family = GetItemFamily(link)
					if not family and isQuestItem then
						LootSlot(slot)
						looted = true
					else
						-- We have room
						family = (family and family <= 4096) and family or 0
						if bag_slots[0] > 0 or (bag_slots[family] and bag_slots[family] > 0) then
							LootSlot(slot)
							looted = true
							-- Update remaining space
							family = bag_slots[family] and family or 0 
							bag_slots[family] = bag_slots[family] - 1

						-- Fits with existing items?
						else
							local cur = GetItemCount(link)
							if cur > 0 then
								-- local stack = select(8, GetItemInfo(name))
								local partial = cur % itemStackCount
								if partial + quantity <= itemStackCount then
									LootSlot(slot)
									looted = true
								end
							end
						end
					end
				end
			end
				
			-- Initialize slot
			if not looted then
				our_slot = our_slot + 1 -- Incriment visible slots
				local row = rows[our_slot] -- Acquire row
				slots[our_slot] = row -- Place in active list
				
				--local icon, name, quantity, quality, locked, isQuestItem, questId, isActive = GetLootSlotInfo(slot)
				
				-- Default UI and tooltip data
				row.item = link
				row.quality = quality
				row.slot = slot
				row.frame_slot = our_slot
				row:SetID(slot)
				
				-- Update row
				local width = row:Update(is_item, icon, name, link, quantity, quality, locked, isQuestItem, questId, isActive)
				
				max_width = max(width, max_width)
				max_quality = max(quality, max_quality)
			end
		end
	end
	
	-- Exit if we autolooted everything
	if our_slot == 0 then
		CloseLoot()
		return nil
	end
	
	self:SizeAndColor(max_width, max_quality)

	-- Show
	if not in_options then
		self:SnapToCursor()
	end
	self:Show()
end

local function clear(slot)
	if not slot then return nil end
	slot.slot = nil
	slot.item = nil
	slot.quality = nil
	slot:Hide()
end

function addon:LOOT_CLOSED()
	if type(XLootFrame.rows) == 'table' then
		for i, row in pairs(XLootFrame.rows) do
			clear(row)
		end
		wipe(XLootFrame.slots)
	end
	XLootFrame:Hide()
	StaticPopup_Hide('LOOT_BIND')
	if UIDropDownMenu_GetCurrentDropDown() == LinkDropdown then
		CloseDropDownMenus()
	end
end

function addon:LOOT_OPENED()
	if GetNumLootItems() > 0 then
		if not XLootFrame:IsShown() and IsFishingLoot() then
			PlaySound('FISHING REEL IN')
		end
		XLootFrame:Update()
	else
		CloseLoot()
	end
end

function addon:LOOT_SLOT_CLEARED(slot)
	local slots = XLootFrame.slots
	-- Apparently auto-looting addons like EasyLoot will cause strange issues
	if slots == nil then
		return
	end
	for id, row in ipairs(slots) do
		if row.slot == slot then
			clear(row)
			if XLootFrame.opt.loot_collapse then
				local prev, next = slots[id-1], slots[id+1]
				if prev and next then
					next:SetPoint('TOP', prev, 'BOTTOM', nil, XLootFrame.skin.row_offset)
				elseif next then
					next:SetPoint('TOP', 0, -10)
				end
				table.remove(slots, id)
				XLootFrame:UpdateHeight()
			end
		end
	end
end

-- Show compare tooltip when shift pressed
-- Without using OnUpdate for all frames
function addon:MODIFIER_STATE_CHANGED(self, modifier, state)
	if (GetNumLootItems() ~= 0) and mouse_focus and MouseIsOver(mouse_focus) then
		mouse_focus:ShowTooltip()
	end
end

local function option_handler(msg)
	if not addon:SlashHandler(msg) then
		addon:ShowOptions()
	end
	--local what, arg, data = string.split(' ', msg, 3)
	--local what, arg, data = msg:match'^(%w+)%s?([A-Za-z\_]*)%s?(.*)$'
end
-- SLASH_XLOOT1 = '/xloot'
-- SlashCmdList['XLOOT'] = option_handler


--[[
Notes:
LootSlotHasItem() -- MoP generic 'check if slot has any loot', meaning item/coin/currency etc
LootSlotIsCoin(slot) etc are replaced by GetLootSlotType(slot) == LOOT_SLOT_* checks
]]



