-- Texture slicing code copied from Rabbit, who copied from !BeatyCase, who thanked Phanx.
-- Default texture from
local frame = CreateFrame("Frame", "XLootFrame", UIParent)
local _G, opt = _G

local padding_bottom = 30
-- Default options
local defaults = {
	frame_scale = 1.1,
	frame_alpha = 1.0,

	quality_color_frame = false,
	quality_color_loot = false,
	--quality_color_threshold = 2,

	loot_texts_info = true,
	loot_texts_bind  = true,

	font_size_loot = 12,
	font_size_info = 10,

	frame_snap = true,
	frame_snap_offset_x = 0,
	frame_snap_offset_y = 0,

	frame_position_x = GetScreenWidth()/2,
	frame_position_y = GetScreenHeight()/2,

	frame_draggable = true,

	linkall_threshold = 2, -- Quality from 0 - 6, Poor - Artifact
	linkall_channel = "RAID",

	colors = {
		frame_border = { .7, .7, .7 },
		frame_backdrop = { 0, 0, 0, .9 },
		frame_gradient = { .5, .5, .5, .6 },
		loot_border = { .5, .5, .5 },
		loot_backdrop = { 0, 0, 0, .9 },
		loot_gradient = { .5, .5, .5, .6 },
		info = { .5, .5, .5 }
	},

	skin = 'default'
}

-- Custom skinning:
-- skin_texture should be the path to a square texture that is a square border, like a ButtonFacade skin
---- In order to use your own skin, XLoot must be set to Blizzard in ButtonFacade - if it is being used
-- [optional] border_size is the desired border thickness
-- [optional] border_pad is the same as using all the pad_ options.
-- [optional] pad_icon is the amount of inner padding item icon borders should have
-- [optional] pad_item is the amount of inner padding item row borders should have
-- [optional] pad_frame is the amount of inner padding the loot border should have
-- [optional] pad_outside is the amount of space rows need between eachother (for large borders)
local skin = {}

local skins = {
	default = {
		texture = [[Interface\AddOns\XLoot\textures\svelte_square]],
		border_size = 16,
		pad_outside = 2,
		pad_icon = nil,
		pad_item = nil,
		pad_frame = nil
	}
}

local function tcopy(t)
	local out = {}
	for k, v in pairs(t) do
		if type(v) == 'table' then
			v = tcopy(t[k])
		end
		out[k] = v
	end
	return out
end

------------------------------------
-- Optionally supported libraries --
------------------------------------
local LBF_hacks

local print, wprint = print, print
local x_prefix = '|c2244dd22XLoot|r'
local function xprint(text) wprint(('%s: %s'):format(x_prefix, text)) end
local function xfprint(pattern, ...) xprint(pattern:format(...)) end

if LibStub then
	local AC, LBF
	-- Ace Console (Debug print)
	AC = LibStub('AceConsole-2.0', true)
	if AC then print = function(...) AC:PrintLiteral(...) end end

	-- ButtonFacade (Extra skins)
	LBF = LibStub('LibButtonFacade', true)
	if LBF then
		LBF_hacks = {
			['simpleSquare'] = { border_size = 12, pad_outside = 4 },
			['PixelSkin'] = { border_pad = 5 },
		}

		-- Add available skins
		-- Failsafe
		local LBF_Skins = LBF:GetSkins()
		if type(LBF_Skins) == 'table' then
			for k, v in pairs(LBF:GetSkins()) do
				if k ~= 'Blizzard' and v.Normal.Texture then
					skins[k] = LBF_hacks[k] and tcopy(LBF_hacks[k]) or {}
					skins[k].texture = v.Normal.Texture
					setmetatable(skins[k], { __index = skins.default})
				end
			end
		end
	end
end

-----------------------
-- Soulbind scanning --
-----------------------
local function GetBindOn(item)
	if not XLootTooltip then CreateFrame('GameTooltip', 'XLootTooltip', UIParent, 'GameTooltipTemplate') end
	local tt = XLootTooltip
	tt:SetOwner(UIParent, 'ANCHOR_NONE')
	tt:SetHyperlink(item)
	if XLootTooltip:NumLines() > 1 and XLootTooltipTextLeft2:GetText() then
		local t = XLootTooltipTextLeft2:GetText()
		tt:Hide()
		if t == ITEM_BIND_ON_PICKUP then
			return 'pickup'
		elseif t == ITEM_BIND_ON_EQUIP then
			return 'equip'
		elseif t == ITEM_BIND_ON_USE then
			return 'use'
		end
	end
	tt:Hide()
	return nil
end

local bop, boe, bou
local function BindText(bind, text)
	if not bop then
		bop = ('|cffff4cff%s|r '):format('BoP')
		boe = ('|cff4cff4c%s|r '):format('BoE')
		bou = ('|cff4c7fff%s|r '):format('BoU')
	end
	local out = bind == 'pickup' and bop or bind == 'equip' and boe or bind == 'use' and bou or ''
	text:SetText(out)
	return out
end


--------------
-- Skinning --
--------------
-- Helpers
local backdrop = {
	bgFile = [[Interface\ChatFrame\ChatFrameBackground]], tile = true, tileSize = 16,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
}

local backdrop_empty = {
	bgFile = ''
}

local function createBorder(self, size)
	local border = self:CreateTexture(nil, "ARTWORK")
	border:SetTexture(skin.texture)
	border:SetWidth(size)
	border:SetHeight(size)
	return border
end

local function ApplyBorders(self, padding)
	local borders = {}
	local borderSize = skin.border_size or 16
	padding = padding or 2
	for i = 1, 8 do
		local border = createBorder(self, borderSize)
		borders[i] = border
		if i == 1 then
			border:SetTexCoord(0, 1/3, 0, 1/3)
			border:SetPoint("TOPLEFT", -padding, padding)
		elseif i == 2 then
			border:SetTexCoord(2/3, 1, 0, 1/3)
			border:SetPoint("TOPRIGHT", padding, padding)
		elseif i == 3 then
			border:SetTexCoord(0, 1/3, 2/3, 1)
			border:SetPoint("BOTTOMLEFT", -padding, -padding)
		elseif i == 4 then
			border:SetTexCoord(2/3, 1, 2/3, 1)
			border:SetPoint("BOTTOMRIGHT", padding, -padding)
		elseif i == 5 then
			border:SetTexCoord(1/3, 2/3, 0, 1/3)
			border:SetPoint("TOPLEFT", borders[1], "TOPRIGHT")
			border:SetPoint("TOPRIGHT", borders[2], "TOPLEFT")
		elseif i == 6 then
			border:SetTexCoord(1/3, 2/3, 2/3, 1)
			border:SetPoint("BOTTOMLEFT", borders[3], "BOTTOMRIGHT")
			border:SetPoint("BOTTOMRIGHT", borders[4], "BOTTOMLEFT")
		elseif i == 7 then
			border:SetTexCoord(0, 1/3, 1/3, 2/3)
			border:SetPoint("TOPLEFT", borders[1], "BOTTOMLEFT")
			border:SetPoint("BOTTOMLEFT", borders[3], "TOPLEFT")
		elseif i == 8 then
			border:SetTexCoord(2/3, 1, 1/3, 2/3)
			border:SetPoint("TOPRIGHT", borders[2], "BOTTOMRIGHT")
			border:SetPoint("BOTTOMRIGHT", borders[4], "TOPRIGHT")
		end
	end
	self.borders = borders
	self.SetSkinColor = function(self, r, g, b)
		if not r then r, g, b = unpack(opt.colors.loot_border) end
		for i, x in pairs(self.borders) do
			x:SetVertexColor(r, g, b, 1)
		end
	end
end

local function SetGradientColor(self, r, g, b, a)
	local f = self.overlay or self
	f.gradient:SetGradientAlpha('VERTICAL', .1, .1, .1, 0, r, g, b, a)
end

local b_color = { 0, 0, 0, .9 }
local g_color = { .5, .5, .5, .6 }
local function skinframe(frame, padding, overlay)
	-- Overlay frame
	local skinned = frame
	if overlay then --overlay then
		local ov = CreateFrame('Frame', nil, frame)
		ov:SetPoint('TOPLEFT', -3, 3)
		ov:SetPoint('BOTTOMRIGHT', 3, -3)
		frame = ov
		skinned.overlay = ov
	end
	frame:SetBackdrop(overlay and backdrop_empty or backdrop)
	frame:SetBackdropColor(unpack(b_color))

	-- Backdrop gradient
	local g = frame:CreateTexture(nil, 'BORDER')
	frame.gradient = g
	g:SetTexture[[Interface\ChatFrame\ChatFrameBackground]]
	g:SetPoint('TOPLEFT', 3, -3)
	g:SetPoint('BOTTOMRIGHT', -3, 3)
	g:SetBlendMode'ADD'
	frame.gradient = g
	skinned.SetGradientColor = SetGradientColor
	skinned:SetGradientColor(unpack(g_color))
	g:Show()

	ApplyBorders(frame, padding)
end


--------------------
-- Frame creation --
--------------------
-- Fontstring shortcuts
local font = STANDARD_TEXT_FONT
local function smalltext(text, size, ext)
	text:SetFont(font, size or 10, ext or '')
	text:SetDrawLayer'OVERLAY'
	text:SetHeight(10)
	text:SetJustifyH'LEFT'
end

local function textpoints(text, item, row, x)
	text:SetPoint('LEFT', item, 'RIGHT', x, 0)
	text:SetPoint('RIGHT', row)
end

-- Row events
local function OnEnter(self)
	if self.slot and LootSlotHasItem(self.slot) then
		GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 32, 0)
		GameTooltip:SetLootItem(self.slot)
		if IsShiftKeyDown() then
			GameTooltip_ShowCompareItem()
		end
		CursorUpdate(self)
	end
end

local function OnLeave(self)
	GameTooltip:Hide()
	ResetCursor()
end

local function OnUpdate(self)
	CursorUpdate(self)
end
local function SnapFrame()
	local x, y = GetCursorPosition()
	local f = XLootFrame
	local s = f:GetEffectiveScale()

	if opt.frame_snap then
		-- Horizontal position
		if not f:IsShown() then
			x = (x / s) - 30
			local sWidth, fWidth, uWidth = GetScreenWidth(), f:GetWidth(), UIParent:GetWidth()
			if uWidth > sWidth then sWidth = uWidth end
			if x + fWidth > sWidth then x = sWidth - fWidth end
			if x < 0 then x = 0 end
			x = x + opt.frame_snap_offset_x
		else
			x = f:GetLeft() or x
		end

		-- Vertical position
		y = (y / s) + 30
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
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

local function OnDragStart()
	if opt.frame_draggable then
		XLootFrame:StartMoving()
	end
end

local function OnDragStop()
	XLootFrame:StopMovingOrSizing()
	opt.frame_position_x = XLootFrame:GetLeft()
	opt.frame_position_y = XLootFrame:GetTop()
end

local LinkLoot
local function ClickLinkLoot()
	LinkLoot(opt.linkall_channel)
end


-- Helpers
local function SetTexts(self, name, info, bind, quantity)
	self.text_name:SetText(name)
	self.text_info:SetText(info)
	self.text_bind:SetText(bind)
	self.text_quantity:SetText(quantity > 1 and quantity or nil)
end

local function SetTex(self, texture)
	self.texture_item:SetTexture(texture)
end

local function SetBorderColor(self, r, g, b, a)
	self:SetSkinColor(r, g, b, a or 1)
	self.frame_item.overlay:SetSkinColor(r, g, b, a or 1)
end

local function SetHighlights(self, r, g, b)
	self:SetHighlightColor(r, g, b)
	self.frame_item.overlay:SetHighlightColor(r, g, b)
end

local function OffsetText(self, text, y)
	text:SetPoint('TOP', self, 0, y)
end

-- Build individual loot row
local rows = { }
local row_height = nil
local function BuildRow(slot)
	-- Create frames
	local row = CreateFrame('Button', 'XLootButton'..slot, XLootFrame)
	local item = CreateFrame('Frame', nil, row)
	local tex = item:CreateTexture('XLootButton'..slot..'IconTexture')

	-- Create fontstrings
	local name = row:CreateFontString('XLootButton'..slot..'Text') -- Stupid, stuuupid blizzard
	local info = row:CreateFontString()
	local bind = item:CreateFontString()
	local quantity = item:CreateFontString()

	-- Setup fontstrings
	smalltext(name, opt.font_size_loot)
	smalltext(info, opt.font_size_info)
	smalltext(bind, 9, 'outline')
	smalltext(quantity, 11, 'outline')
	textpoints(name, item, row, 4)
	textpoints(info, item, row, 10)
	--bind:ClearAllPoints()
	bind:SetPoint('BOTTOMLEFT', 0, 2)
	quantity:SetPoint('BOTTOMRIGHT', -2, 2)
	info:SetTextColor(unpack(opt.colors.info))

	-- Align frames
	row:SetHeight(30)
	row:SetPoint('LEFT', 10, 0)
	row:SetPoint('RIGHT', -10, 0)

	item:SetPoint('LEFT', 3, 0)
	item:SetHeight(28)
	item:SetWidth(28)
	tex:SetAllPoints()
	tex:SetTexCoord(.07,.93,.07,.93)

	-- Skin row
	skinframe(row, skin.pad_item or skin.border_pad)
	skinframe(item, skin.pad_icon or skin.border_pad, true)
	row:SetBackdropColor(unpack(opt.colors.loot_backdrop))
	row:SetGradientColor(unpack(opt.colors.loot_gradient))
	item:SetGradientColor(unpack(opt.colors.loot_gradient))
	row_height = row:GetHeight() - skin.pad_outside

	-- Wire row
	row:RegisterForDrag('LeftButton')
    row:RegisterForClicks("AnyUp")
	row:SetScript('OnDragStart', OnDragStart)
	row:SetScript('OnDragStop', OnDragStop)
	row:SetScript('OnEnter', OnEnter)
	row:SetScript('OnLeave', OnLeave)
	row:SetScript('OnUpdate', OnUpdate)
	row:SetScript('OnClick', function(self, button)
			if IsModifiedClick() then
				HandleModifiedItemClick(GetLootSlotLink(self.slot))
			else
				LootButton_OnClick(self, button)
			end
		end) -- Don't break other addons

	-- Set references
	row.text_name = name
	row.text_info = info
	row.text_bind = bind
	row.text_quantity = quantity
	row.frame_item = item
	row.texture_item = tex

	-- Helpers
	row.SetTexts = SetTexts
	row.SetTex = SetTex
	row.OffsetText = OffsetText
	row.SetBorderColor = SetBorderColor
	row.SetHighlights = SetHighlights

	-- Color row
	row:SetBorderColor(unpack(opt.colors.loot_border))

    --row:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]], "ADD")
    --row:SetHighlightTexture([[Interface\BUTTONS\UI-Panel-Button-Glow]], "ADD")
    --row:GetHighlightTexture():SetTexCoord(0,.7,.11,.49)
    row:SetHighlightTexture([[Interface\QUESTFRAME\UI-QuestItemHighlight]], "ADD")
    row:GetHighlightTexture():SetAlpha(0.6)
    row:GetHighlightTexture():SetTexCoord(.18,.59,.11,.71)
    --/run XLootButton1:SetHighlightTexture([[Interface\WorldMap\UI-QuestPoi-IconGlow]], "ADD")XLootButton1:GetHighlightTexture():SetTexCoord(0,.9,0,1)

	return row
end

-- Build frame
local built = false
WW:Font("XLootFontNormal", ChatFontNormal, 12, 1, 1, 1, .5):un();
WW:Font("XLootFontHighlight", ChatFontNormal, 12, 1, .82, 0):un();
local function BottomButton(name, text, justify)
    local b = WW:Button(name, XLootFrame):SetButtonFont("XLootFontNormal"):SetHighlightFontObject("XLootFontHighlight"):SetText(text):SetWidth(80):GetButtonText():SetJustifyH(justify):ALL():up():un()
	b:SetFrameLevel(8)
	b:SetHeight(16)
	b:ClearAllPoints()
	b:SetPoint('BOTTOM', 0, 4)
	b:SetHitRectInsets(-4, -4, 3, -2)
	b:Show()
	return b
end
local function BuildFrame()
	-- Skin failsafe
	skin = skins[opt.skin] or skins.default

	skin.pad_outside = skin.pad_outside * -1

	built = true
	-- Setup frame
	local f = frame
	f:SetFrameStrata'HIGH'
	f:SetFrameLevel(5)
	f:SetMovable(1)
	f:EnableMouse(1)
	f:RegisterForDrag'LeftButton'

	-- Events
	f:SetScript('OnDragStart', OnDragStart)
	f:SetScript('OnDragStop', OnDragStop)

	-- Skin
	skinframe(f, skin.pad_frame or skin.border_pad)
	f:SetSkinColor(unpack(opt.colors.frame_border))
	f:SetBackdropColor(unpack(opt.colors.frame_backdrop))
	f:SetGradientColor(unpack(opt.colors.frame_gradient))

   	-- Link all button
	local lb = BottomButton('XLootLinkButton', '发送链接', 'LEFT')
	lb:SetPoint('LEFT', 6, 0)
	lb:SetScript('OnClick', ClickLinkLoot)

	-- Close button
	local cb = BottomButton('XLootCloseButton', '关闭', 'RIGHT')
	cb:SetPoint('RIGHT', -7, 0)
	cb:SetScript('OnClick', function() CloseLoot() end)

	f.close = cb
	f.link = lb
	f:Hide()
end

-- Default display
local slots = {}
local function Update()
	local numloot = GetNumLootItems()

	-- Build frame if it doesn't exist
	if not built then
		BuildFrame()
	end

	-- Add any needed rows
	while #rows < numloot do
		local new = #rows + 1
		rows[new] = BuildRow(new)
	end

	-- Update individual loot frames
	local maxquality, maxwidth, shiftslot, item = 0, 0, 0
	for slot=1, numloot do
		if GetLootSlotInfo(slot) then
			shiftslot = shiftslot + 1
			-- Fetch item, row, and locals
			local texture, itemname, quantity, quality, link, r, g, b, h = GetLootSlotInfo(slot)
			local row = rows[shiftslot]
			local tname, tinfo = row.text_name, row.text_info
			local newinfo, newname, newbind = '', '', ''
			local isitem = LootSlotHasItem(slot)
			slots[shiftslot] = row

			-- Attach row
			if slot == 1 then
				row:SetPoint('TOP', 0, -10)
			else
				row:SetPoint('TOP', slots[shiftslot-1], 'BOTTOM', 0, skin.pad_outside)
			end

			-- Set row as occupied
			row.item = link
			row.quality = quality

			-- Let blizzard handle onclick - This is just a loot frame mod.
			row.slot = slot
			row:SetID(slot)

			-- Build item information
			-- if isitem then
            -- xxx LootSlotHasItem() doesnot return nil for coins
            if(GetLootSlotLink(slot)) then
				-- Update locals
				link = GetLootSlotLink(slot)
				r, g, b, h = GetItemQualityColor(quality)
				-- Item name
				newname = ('|c%s%s|r'):format(h, itemname)
				-- Item information text
				if opt.loot_texts_info and link then
					local _, _, _, _, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(link)
					--print((itemType or "nil") .. (itemSubType or "nil") .. link)
					local equip = itemType == ENCHSLOT_WEAPON and ENCHSLOT_WEAPON or itemEquipLoc ~= '' and _G[itemEquipLoc] or ''
					local itemtype = (itemSubType == 'Junk' and quality > 0) and MISCELLANEOUS or itemSubType
					newinfo = ((type(equip) == 'string' and equip ~= '') and equip..', ' or '') .. (itemtype or "")
				end
				-- Icon bind text
				if opt.loot_texts_bind then
					newbind = BindText(GetBindOn(link), row.text_bind)
				end

			-- It's money
			else
				r, g, b = .4, .4, .4
				newname = itemname:gsub('\n', ', ')
			end

			-- Update row
			row:SetTexts(newname, newinfo, newbind, quantity)
			row:SetTex(texture)

			-- Update maximums
			if opt.quality_color_frame and isitem then
				maxquality = math.max(maxquality, quality)
			end
			maxwidth = math.max(maxwidth, tinfo:GetStringWidth(), tname:GetStringWidth())

			-- Re-align fontstrings layout
			local layout = (isitem and opt.loot_texts_info) and 'item' or 'coin'
			if row.layout ~= layout then
				row.layout = layout
				if layout == 'coin' then
					row:OffsetText(tname, -9)
				else
					row:OffsetText(tname, -5)
					row:OffsetText(tinfo, -15)
				end
			end

			-- Color borders
			if opt.quality_color_loot then
				row:SetBorderColor(r, g, b)
            else
                row:SetBorderColor(unpack(opt.colors.loot_border))
            end

			row:Show()
		end
	end

	-- Update frame appearance
	frame:SetWidth(maxwidth + 70)
	frame:SetHeight(padding_bottom + skin.pad_outside + #slots*row_height)
	frame:SetScale(opt.frame_scale)
	frame:SetAlpha(opt.frame_alpha)

	-- Color frame
	if opt.quality_color_frame then --and not frame:IsVisible() then
		frame:SetSkinColor(GetItemQualityColor(maxquality))
    else
        frame:SetSkinColor(unpack(opt.colors.frame_border))
    end

    frame:SetBackdropColor(unpack(opt.colors.frame_backdrop))
    frame:SetGradientColor(unpack(opt.colors.frame_gradient))

	-- Display Link All button
    --[[
	local vis = opt.linkall_channel
	if vis == 'SAY' or (vis == 'GUILD' and IsInGuild()) or (vis == 'RAID' and GetNumRaidMembers() > 0) or (vis == 'PARTY' and GetNumPartyMembers() > 0) then
		XLootLinkButton:Show()
	else
		XLootLinkButton:Hide()
	end
	]]

	-- Finish
	SnapFrame()
	frame:Show()
end

local function clear(slot)
	if not slot then return nil end
	slot.slot = nil
	slot.item = nil
	slot.quality = nil
	slot:Hide()
end

local function Closed()
	for _,slot in pairs(rows) do
		clear(slot)
	end
	for s in pairs(slots) do
		slots[s] = nil
	end
	frame:Hide()
	StaticPopup_Hide"LOOT_BIND"
end

local function Opened()
	if GetNumLootItems() > 0 then
		Update()
		if not XLootFrame:IsShown() and IsFishingLoot() then
			PlaySound"FISHING REEL IN"
		end
	else
		CloseLoot()
	end
end

local function Cleared(slot)
	for id, row in ipairs(slots) do
		-- Find the cleared slot
		if row.slot == slot then
			clear(row)
			-- Get neighbors
			local prev, next = slots[id - 1], slots[id + 1]
			-- Reattach neighbors
			if prev and next then
				next:SetPoint('TOP', prev, 'BOTTOM', nil, skin.row_offset)
			elseif next then
				next:SetPoint('TOP', 0, -10)
			end
			table.remove(slots, id)
			if row_height ~= nil then
				frame:SetHeight(padding_bottom + #slots*row_height)
			end
		end
	end
end

local function UpdateHeight(self)
	if self.row_height then
		self:SetHeight(((self.link:IsShown() or self.close:IsShown()) and 26 or 20) + #self.slots * self.row_height)
	end
end

local output = { }
LinkLoot = function(channel, isExtraChannel)
	local output, key, buffer = output, 1
	local sf = string.format

	if UnitExists"target" then
		output[1] = sf('%s:', UnitName"target")
	end

	local linkthreshold, thresholdreached = opt.linkall_threshold, false
	for i=1, GetNumLootItems() do
		if LootSlotHasItem(i) then
			local texture, item, quantity, rarity = GetLootSlotInfo(i)
			local link = GetLootSlotLink(i)
			if rarity >= linkthreshold then
				thresholdreached = true
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
	if not thresholdreached then
		return false
	end

    if channel == "RAID" and not IsInRaid() then channel = "PARTY" end
    if channel == "PARTY" and not IsInGroup() then channel = "SAY" end
    if channel == "GUILD" and not IsInGuild() then channel = "SAY" end
    if(channel == 'RAID' or channel == 'PARTY') and U1UseInstanceChat() then
        channel = 'INSTANCE_CHAT'
    end
	for k, v in pairs(output) do
		v  = string.gsub(v, "\n", " ", 1, true) -- DIE NEWLINES, DIE A HORRIBLE DEATH
		SendChatMessage(v, channel)
		output[k] = nil
	end

	return true
end

--------------------
-- Initialization --
--------------------

local profile
local function SetProfile(which)
	if not XLoot_Options.profiles[which] then
		XLoot_Options.profiles[which] = {}
	end
	opt = setmetatable(XLoot_Options.profiles[which], { __index = defaults })
	opt.colors = setmetatable(XLoot_Options.profiles[which].colors, { __index = defaults.colors })
	profile = which
end

local profile_key = ('%s - %s'):format(UnitName('player'), GetRealmName())
local characters, profiles
frame:SetScript("OnEvent", function(self, event) if event == "VARIABLES_LOADED" then
	-- Options init
	if not XLoot_Options or not XLoot_Options.profiles then
		XLoot_Options = {characters = {}, profiles = {}}
	end

	-- Profiles init
	local which_profile
	characters, profiles = XLoot_Options.characters, XLoot_Options.profiles
	if characters[profile_key] then
		which_profile = characters[profile_key]
		-- Invalid/removed profiles
		if type(profiles[which_profile]) == nil then
			characters[profile_key] = nil
			which_profile = nil
		end
	end
	which_profile = which_profile or 'default'
	SetProfile(which_profile)

	-- Event handling
	local events = {
		LOOT_OPENED = Opened,
		LOOT_SLOT_CLEARED = Cleared,
		LOOT_CLOSED = Closed
	}
	for e in pairs(events) do
		frame:RegisterEvent(e)
		LootFrame:UnregisterEvent(e)
	end
	frame:SetScript("OnEvent", function(_, e, ...) if events[e] then events[e](...) end end)

end end)
frame:RegisterEvent("VARIABLES_LOADED")


-------------
-- Options --
-------------
local opts_order = {'set', 'get', 'default', 'skin', 'color', 'center', 'profile', 'defaults'}
local L = {
	opts = {
		help = 'Provides help for a option. Topics exist for: set, profile, and color',
		set = 'Sets most options. Use [/xloot help set] for all options',
		get = 'Show the value of a given option. Use [/xloot get option]',
		default = 'Resets a given option to the default value. use [/xloot default option]',
		skin = 'Lists available (and current) skins. Use [/xloot skin name] to pick one',
		color = 'Pick the color for part of the loot frame',
		center = 'Reset the position of XLoot to the center of the screen',
		profile = 'Manages profiles',
		defaults = 'Restore all default options for the current profile'
	},
	help = {
		set = {
			'Use [/xloot set option value] to set options. Available options:',
			'frame_scale - default 1.0 - Scales frame',
			'frame_alpha - default 1.0 - Determines opacity',
			'quality_color_frame - default off - Colors frame border by highest quality item',
			'quality_color_loot - default off - Colors loot border by quality',
			'loot_texts_info - default on - Item type text',
			'loot_texts_bind - default on - Bind On X text',
			'frame_snap - default on - Snaps frame to mouse when looting',
			'frame_snap_offset_x/_y - default 0 - Determines how far to offset the frame when snapping',
			'frame_draggable - default on - Allows loot frame to be dragged',
			'linkall_threshold - default 2 - Minimum item quality to link, 0 being trash',
			'linkall_channel - default RAID - Channel to link to, and when frame shows up. Any of SAY, GUILD, RAID, or PARTY'
		},
		profile = {
			'Use [/xloot profile ___] to manipulate profiles.',
			'[/xloot profile set name] will change the current profile to "name", as well as creating it if missing',
			'[/xloot profile copy name] will copy the settings from profile "name" into the current profile.',
			'[/xloot profile remove name] will remove the profile "name"'
		},
		color = {
			'Use [/xloot color ___] to change colors.',
			'frame_border, frame_backdrop, and frame_gradient control the main frame colors.',
			'loot_border, loot_backdrop, and loot_gradient control loot row colors.',
			'info controls the color for info text.'
		}
	}
}

--XXX 163 update color immediately.
local function update_color(arg)
    if(arg=='frame_border' and not opt.quality_color_frame and frame:IsVisible()) then
        frame:SetSkinColor(unpack(opt.colors[arg]))
    elseif arg=='frame_backdrop' then
        frame:SetBackdropColor(unpack(opt.colors[arg]))
    end
end
local function option_handler(msg)
	--local what, arg, data = msg:match'^(%w+)%s?([A-Za-z\_]*)%s?(.*)$'
	local what, arg, data = string.split(' ', msg, 3)
	local reload = false

	if msg == 'center' then
		XLootFrame:Hide()
		opt.frame_position_x = GetScreenWidth()/2
		opt.frame_position_y = GetScreenHeight()/2
		SnapFrame()
		XLootFrame:Show()

	elseif msg == 'defaults' then
		wipe(opt)
		xprint('Defaults restored')

	elseif what == 'profile' then
		if arg == 'set' and data ~= '' then
			SetProfile(data)
			characters[profile_key] = data
			reload = true
		elseif arg == 'copy' then
			if profiles[data] then
				wipe(opt)
				profiles[characters[profile_key] or 'default'] = tcopy(profiles[data])
				reload = true
			else
				xprint(('Profile [%s] does not exist'):format(data))
			end
		elseif arg == 'remove' then
			if data == '' and profile ~= 'default' then
				data = profile
			end
			profiles[data] = nil
			if data == profile then
				SetProfile('default')
				characters[profile_key] = nil
				reload = true
			end
		end

	elseif what == 'color' then
		if defaults.colors[arg] then
			if data == 'default' then
				opt.colors[arg] = nil
			else
				opt.colors = opt.colors or tcopy(defaults.colors)
				local cpf = ColorPickerFrame
				cpf:Hide()
				cpf.hasOpacity = true
                cpf.opacity = 1 - (opt.colors[arg][4] or 1)
				cpf.previousValues = tcopy(opt.colors[arg])
				cpf.func = function() opt.colors[arg][1], opt.colors[arg][2], opt.colors[arg][3] = cpf:GetColorRGB() opt.colors[arg][4] = 1-OpacitySliderFrame:GetValue() update_color(arg) end
				cpf.cancelFunc = function(t) opt.colors[arg] = t update_color(arg) end
                cpf:SetColorRGB(unpack(opt.colors[arg])) --必须放到后面，不然会乱
				cpf:Show()
			end
			reload = true
		else
			xprint('Available color options:')
			for k, v in pairs(defaults.colors) do
				xprint(k)
			end
			xprint('Use [/xloot color ___] to change.')
		end
	elseif what == 'skin' then
		if not arg then
			xfprint('available skins: (Currently |c22dd4422%s|r)', opt.skin)
			for k, v in pairs(skins) do
				wprint(('|c2244ccdd%s|r: [%s]'):format(k, v.texture))
			end
		else
			local _, skin = string.split(' ', msg, 2)
			if skins[skin] then
				opt.skin = skin
				reload = true
			elseif arg ~= '' then
				xprint('Requested skin does not exist')
			end
		end

	elseif what == 'help' then
		if L.help[arg] then
			for k, v in ipairs(L.help[arg]) do
				wprint(v)
			end
		elseif arg then
			xprint('No help topic for: ' .. arg)
		else
			xprint('Use [/xloot help topic]')
			xprint('Topics: set, profile, color')
		end

	elseif defaults[arg] ~= nil then
		if what == 'set' then
			what_type = type(defaults[arg])
			if what_type == 'boolean' then
				data = (data == 'on' or data == '1' or data == 'yes' or data == 'true')
				reload = true
			elseif what_type == 'table' then
				return nil
			end
			opt[arg] = data
		elseif what == 'get' then
			print(opt[arg])
		elseif what == 'default' then
			opt[arg] = nil
			wprint('XLoot: Default restored for '..arg)
			reload = true
		end

	else
		if arg then
			xprint('Requested option does not exist: ' .. arg)
		else
			xprint('Available comands')
			for k, v in ipairs(opts_order) do
				wprint(('|c22ffcc22%s|r: %s'):format(v, L.opts[v]))
			end
		end
	end

	if reload then
		--wprint('You may need to reload your UI to see your changes. (/reloadui)')
	end
end
SLASH_XLOOT1 = '/xloot'
SlashCmdList['XLOOT'] = option_handler
