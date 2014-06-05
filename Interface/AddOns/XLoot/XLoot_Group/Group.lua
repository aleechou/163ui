-- Create module
local addon, L = XLoot:NewModule("Group")
-- Prepare global
XLootGroup = addon
-- Grab locals
local opt, anchor, alert_anchor, mouse_focus, Skinner
local rolls = {}
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or _G.RAID_CLASS_COLORS
local GetLootRollItemInfo, GetLootRollItemLink, GetLootRollTimeLeft, RollOnLoot, UnitGroupRolesAssigned, print, string_format
	= GetLootRollItemInfo, GetLootRollItemLink, GetLootRollTimeLeft, RollOnLoot, UnitGroupRolesAssigned, print, string.format
local HistoryGetItem, HistoryGetPlayerInfo, HistoryGetNumItems
	= C_LootHistory.GetItem, C_LootHistory.GetPlayerInfo, C_LootHistory.GetNumItems
local CanEquipItem, IsItemUpgrade = XLoot.CanEquipItem, XLoot.IsItemUpgrade


-------------------------------------------------------------------------------
-- Settings

local defaults = {
	profile = {
		text_outline = true,
		text_time = false,
		role_icon = true,
		win_icon = false,
		show_decided = true,
		show_undecided = false,

		equip_prefix = true,
		prefix_equippable = "*",
		prefix_upgrade = "+",

		alert_skin = true,
		alert_alpha = 1,
		alert_scale = 1,
		alert_offset = 4,

		bonus_skin = true,

		roll_button_size = 28,
		roll_width = 325,

		roll_anchor = {
			direction = 'up',
			visible = true,
			scale = 1.0,
			x = UIParent:GetWidth() * .85,
			y = UIParent:GetHeight() * .6
		},

		alert_anchor = {
			visible = true,
			direction = 'up',
			scale = 1.0,
			x = AlertFrame:GetLeft(),
			y = AlertFrame:GetTop()
		},

		track_all = true,
		track_player_roll = false,
		track_by_threshold = false,
		track_threshold = 3,

		expire_won = 20,
		expire_lost = 10
	}
}

-------------------------------------------------------------------------------
-- Module init

local eframe = CreateFrame("Frame")
function addon:OnInitialize()
	self:InitializeModule(defaults, eframe)
	opt = self.db.profile
	XLootGroup.opt = opt
	-- Extra slash command
	XLoot:SetSlashCommand("xlg", self.SlashHandler)
end

function addon:OnEnable()
	-- Register events
	eframe:RegisterEvent('START_LOOT_ROLL')
	eframe:RegisterEvent('LOOT_HISTORY_ROLL_CHANGED')
	eframe:RegisterEvent('LOOT_HISTORY_ROLL_COMPLETE')
	eframe:RegisterEvent('LOOT_ROLLS_COMPLETE')
	eframe:RegisterEvent('MODIFIER_STATE_CHANGED')

	-- Disable default frame
	UIParent:UnregisterEvent("START_LOOT_ROLL")
	UIParent:UnregisterEvent("CANCEL_LOOT_ROLL")

	-- Set up skins
	Skinner = {}
	XLoot:MakeSkinner(Skinner, {
		anchor = { r = .4, g = .4, b = .4, a = .6, gradient = false },
		anchor_pretty = { r = .6, g = .6, b = .6, a = .8 },
		row = { gradient = false },
		item = { backdrop = false },
		alert = { gradient = false },
		alert_item = { gradient = false, backdrop = false },
		bonus = { }
	}, 'row')

	-- Create Roll anchor
	anchor = XLoot.Stack:CreateStaticStack(self.CreateRollFrame, L.anchor, opt.roll_anchor)
	anchor:SetFrameLevel(7)
	anchor:Scale(opt.roll_anchor.scale)
	addon.anchor = anchor

	-- Create alert anchor
	alert_anchor = XLoot.Stack:CreateAnchor(L.alert_anchor, opt.alert_anchor)
	alert_anchor:SetFrameLevel(7)
	addon.alert_anchor = alert_anchor

	-- Skin anchor
	Skinner:Skin(anchor, XLoot.opt.skin_anchors and 'anchor_pretty' or 'anchor')
	Skinner:Skin(alert_anchor, XLoot.opt.skin_anchors and 'anchor_pretty' or 'anchor')

	-- Row fader
	local fader = CreateFrame('Frame')
	local timer = 0
	fader:SetScript('OnUpdate', function(self, elapsed)
		if timer < 1 then
			timer = timer + elapsed
		else
			timer = 0
			local time = GetTime()
			-- Extend expiration for mouseovered frames
			if mouse_focus and mouse_focus.aexpire and (mouse_focus.aexpire - time) < 5 then
				mouse_focus.aexpire = time + 5
			end
			for i, frame in ipairs(anchor.expiring) do
				if frame.aexpire and time > frame.aexpire then
					anchor:Pop(frame)
					table.remove(anchor.expiring, i)
				end
			end
			if not next(anchor.expiring) then
				self:Hide()
			end
		end
	end)
	anchor.expiring = {}
	function anchor:Expire(frame, time)
		fader:Show()
		table.insert(self.expiring, frame)
		frame.aexpire = GetTime() + time
	end

	-- Find and show active rolls
	if IsInGroup() and (GetLootMethod() == 'group' or GetLootMethod() == 'needbeforegreed') then
		for i=1,300 do
			local time = GetLootRollTimeLeft(i)
			if time > 0 and time <  300000 then
				self:START_LOOT_ROLL(i, time, true)
			end
		end
	end

	-- Hook alert actions
	hooksecurefunc('LootWonAlertFrame_SetUp', self.AlertFrameHook)
	hooksecurefunc('AlertFrame_SetLootWonAnchors', self.AlertFrameAnchorHook)
	-- hooksecurefunc('BonusRollFrame_StartBonusRoll', self.BonusRollFrame_StartBonusRoll)
	-- hooksecurefunc('BonusRollFrame_FinishedFading', self.BonusRollFrame_Hide)
	-- BonusRollFrame._SetPoint, BonusRollFrame.SetPoint = BonusRollFrame.SetPoint, addon.BonusRollFrame_SetPoint
	hooksecurefunc(BonusRollFrame, 'SetPoint', addon.BonusRollFrame_SetPoint)
	hooksecurefunc(BonusRollFrame, 'Show', addon.BonusRollFrame_Show)
	hooksecurefunc(BonusRollFrame, 'Hide', addon.BonusRollFrame_Hide)
end

-------------------------------------------------------------------------------
-- Frame helpers

-- Tack role icon on to player name and return class colors
local white = { r = 1, g = 1, b = 1 }
local dimensions = {
	HEALER = '48:64',
	DAMAGER = '16:32',
	TANK = '32:48'
}
local function FancyPlayerName(name, class)
	local c = RAID_CLASS_COLORS[class] or white
	local role = UnitGroupRolesAssigned(name)
	if role ~= 'NONE' and opt.role_icon then
		name = string_format('\124TInterface\\LFGFRAME\\LFGROLE:12:12:-1:0:64:16:%s:0:16\124t%s', dimensions[role], name)
	end
	return name, c.r, c.g, c.b
end

local function SetOutline(fontstring)
	local f, s = fontstring:GetFont()
	fontstring:SetFont(f, s, opt.text_outline and 'OUTLINE' or nil)
end

-------------------------------------------------------------------------------
-- Event handlers

addon.bars = {}
local type_strings = {
	need = NEED,
	greed = GREED,
	disenchant = ROLL_DISENCHANT,
	pass = PASS
}
local rtypes = { [0] = 'pass', 'need', 'greed', 'disenchant' } -- Tekkub. Writing smaller addons than me since ever.

function addon:START_LOOT_ROLL(id, length, uid, ongoing)
	local icon, name, count, quality, bop, need, greed, de = GetLootRollItemInfo(id)
	local link = GetLootRollItemLink(id)
	local r, g, b = GetItemQualityColor(quality)

	local start = length
	if ongoing then
		if quality == 2 then
			length = 60000
		else
			length = 180000
		end
	end
	length, start = length/1000, start/1000

	local frame = anchor:Push()
	rolls[id] = frame

	frame.need:Show()
	frame.greed:Show()
	frame.disenchant:Show()
	frame.pass:Show()
	frame.text_status:Hide()
	frame.text_status:SetText()
	if opt.text_time then
		frame.text_time:Show()
	else
		frame.text_time:Hide()
	end

	if opt.equip_prefix then
		local canequip, isupgrade = CanEquipItem(link), IsItemUpgrade(link)
		if canequip or isupgrade then
			name = string_format("|cFF%s%s|r%s", isupgrade and "FF4422" or "BBBBBB", is_upgrade and opt.prefix_upgrade or opt.prefix_equippable, name)
		end
	end
	frame.need:Toggle(need)
	frame.greed:Toggle(greed)
	frame.disenchant:Toggle(de)

	frame.need:SetText()
	frame.greed:SetText()
	frame.pass:SetText()
	frame.disenchant:SetText()

	local bar = frame.bar
	bar.length = length
	bar.expires = GetTime() + start

	frame.link = link
	frame.rollid = id
	frame.rollended = nil
	frame.quality = quality
	frame.expires = bar.expires
	frame.over = nil
	frame.have_rolled = false
	frame.lead_type = 'pass'

	frame.text_bind:SetText(bop and '|cffff4422BoP' or '')
	frame.text_loot:SetText(name)

	frame.text_loot:SetVertexColor(r, g, b)
	frame.overlay:SetBorderColor(r, g, b)
	frame.icon_frame:SetBorderColor(r, g, b)
	bar:SetStatusBarColor(r, g, b, .7)
	frame.icon:SetTexture(icon)

	bar:SetMinMaxValues(0, length)
	bar:SetValue(start)


	return frame
end

local tidx = { [0] = 1, [3] = 2, [2] = 2, [1] = 3 }
function addon:LOOT_HISTORY_ROLL_COMPLETE()
	-- Locate history item
	local hid, frame, rollid, players, done, _ = 1
	while true do
		rollid, _, players, done = HistoryGetItem(hid)
		if not rollid or (rolls[rollid] and rolls[rollid].over) then
			return
		elseif done and rolls[rollid] then
			frame = rolls[rollid]
			break
		end
		hid = hid+1
	end

	-- Active frame found
	frame.over = true
	local top_type, top_roll, top_pid = 0, 0
	for j=1, players do
		local name, class, rtype, roll, is_winner, is_me = HistoryGetPlayerInfo(hid, j)
		-- roll = roll and roll or true
		if is_winner then
			top_pid = j
			break
		elseif rtype ~= 0 and tidx[rtype] >= tidx[top_type] and (not roll or roll > top_roll) then
			top_type = rtype
			top_roll = roll
			top_pid = j
		end
	end

	-- Winner or lead
	if top_pid then
		local name, class = HistoryGetPlayerInfo(hid, top_pid)
		local player, r, g, b = FancyPlayerName(name, class)
		if opt.win_icon then
			if rtype == 'need' then
				player = [[|TInterface\Buttons\UI-GroupLoot-Dice-Up:16:16:-1:-1|t]]..player
			elseif rtype == 'greed' then
				player = [[|TInterface\Buttons\UI-GroupLoot-Coin-Up:16:16:-1:-2|t]]..player
			elseif rtype == 'disenchant' then
				player = [[|TInterface\Buttons\UI-GroupLoot-DE-Up:16:16:-1:-1|t]]..player
			end
		end
		frame.text_status:SetText(player)
		frame.text_status:SetTextColor(r, g, b)
		frame.bar.expires = GetTime()
		anchor:Expire(frame, is_me and opt.expire_won or opt.expire_lost)
	else
	-- No winner/lead
		frame.text_status:SetText(string_format('%s: %s', PASS, ALL))
		frame.text_status:SetTextColor(.7, .7, .7)
		frame.bar.expires = GetTime()
		anchor:Expire(frame, opt.expire_lost)
	end
	-- Refresh tooltip
	if frame and mouse_focus == frame then
		frame:OnEnter()
	end
end
addon.LOOT_ROLLS_COMPLETE = addon.LOOT_HISTORY_ROLL_COMPLETE

local rweights = { need = 3, greed = 2, disenchant = 2, pass = 1 }
function addon:LOOT_HISTORY_ROLL_CHANGED(hid, pid)
	-- Acquire roll information and frame
	local rollid, link, players, done = HistoryGetItem(hid)
	local frame = rolls[rollid]
	if not frame or frame.rollid ~= rollid or not frame:IsShown() then
		return nil
	end
	
	-- Acquire player information
	local name, class, rtypeid, roll, winner, is_me = HistoryGetPlayerInfo(hid, pid)
	local rtype = rtypes[rtypeid]

	-- Transition or expire frame on player roll
	if is_me then
		if 	opt.track_all
			or (opt.track_player_roll and rtype ~= 'pass')
			or (opt.track_by_threshold and frame.quality >= opt.track_threshold) then
			frame.need:Hide()
			frame.greed:Hide()
			frame.disenchant:Hide()
			frame.pass:Hide()
			frame.text_status:Show()
			frame.have_rolled = true
		else
			anchor:Pop(frame)
			return
		end
	end

	-- Update post-player-roll status text
	if frame.have_rolled then
		local rtype = rtype == 'disenchant' and 'greed' or rtype
		-- Roll of leading type or higher
		if rweights[rtype] >= rweights[frame.lead_type] then
			frame.lead_type = rtype
			local bracket, mtype = 0, nil
			for i=1, players do
				local _, _, ptype, _, _, is_me = HistoryGetPlayerInfo(hid, i)
				local ptype = rtypes[ptype == 3 and 2 or ptype]
				if ptype == rtype then
					bracket = bracket + 1
				end
				if is_me then
					mtype = ptype
				end
			end

			local r, g, b = .7, .7, .7
			if mtype == rtype then
				r, g, b = .2, 1, .1
			elseif mtype and mtype ~= 0 then
				r, g, b = 1, .2, .1
			end
			frame.text_status:SetText(string_format('%s: %s', type_strings[rtype], bracket))
			frame.text_status:SetTextColor(r, g, b)
		end

	-- Update roll button counters
	else
		local bracket = 0
		for i=1, players do
			local _, _, thistype = HistoryGetPlayerInfo(hid, i)
			if thistype == rtypeid then
				bracket = bracket + 1
			end
		end
		frame[rtype]:SetText(bracket)
	end

	-- Refresh tooltip
	if frame and mouse_focus == frame then
		frame:OnEnter()
	end
end

function addon:MODIFIER_STATE_CHANGED(_, modifier, state)
	if mouse_focus and MouseIsOver(mouse_focus) and mouse_focus.OnEnter then
		mouse_focus:OnEnter()
	end
end

local alert_frames = {}
function addon.AlertFrameHook(alert, link)
	-- Reskin toast
	local elements = alert_frames[alert]
	if not elements then
		elements = {}
		if opt.alert_skin then
			alert.Background:Hide()
			alert.IconBorder:Hide()
			alert.ItemName:SetPoint('BOTTOMRIGHT', -25, 27)

			local overlay = CreateFrame('Frame', nil, alert)
			overlay:SetPoint('TOPLEFT', 11, -11)
			overlay:SetPoint('BOTTOMRIGHT', -11, 11)
			overlay:SetFrameLevel(alert:GetFrameLevel())
			elements.overlay = overlay
			Skinner:Skin(overlay, 'alert')
			-- overlay:SetGradientColor(.5, .5, .5, .4)

			local icon_frame = CreateFrame('Frame', nil, alert)
			icon_frame:SetPoint('CENTER', alert.Icon, 'CENTER', 0, 0)
			icon_frame:SetWidth(53)
			icon_frame:SetHeight(54)
			elements.icon_frame = icon_frame
			Skinner:Skin(icon_frame, 'alert_item')
			-- icon_frame:SetGradientColor(.5, .5, .5, .4)
		end

		alert:SetAlpha(opt.alert_alpha)
		alert:SetScale(opt.alert_scale)
		alert_frames[alert] = elements
	end

	-- Update toast
	if opt.alert_skin then
		local _, _, rarity = GetItemInfo(link)
		local c = ITEM_QUALITY_COLORS[rarity]
		if type(c) == "table" then -- Sanity check due to 5.4.1 reported error
			elements.overlay:SetBorderColor(c.r, c.g, c.b)
			elements.icon_frame:SetBorderColor(c.r, c.g, c.b)
		end
	end
end

function addon.AlertFrameAnchorHook()
	local anchor = alert_anchor
	local up, first, x, y = opt.alert_anchor.direction == 'up', true, 44, -10
	for i=1, #LOOT_WON_ALERT_FRAMES do
		local frame = LOOT_WON_ALERT_FRAMES[i]
		if frame:IsShown() then
			frame:ClearAllPoints()
			if up then
				frame:SetPoint("BOTTOM", anchor, "TOP", x, y)
			else
				frame:SetPoint("TOP", anchor, "BOTTOM", x, -y)
			end
			anchor = frame
			if first then
				first, x, y = false, 0, opt.alert_offset - 24
			end
		end
	end
end

-- function addon.BonusRollFrame_StartBonusRoll()
-- 	if BonusRollFrame:IsShown() then
-- 		addon.BonusRollFrame_Show()
-- 	end
-- end

function addon.BonusRollFrame_SetPoint(self, _, frame)
	if frame ~= anchor then
		self:ClearAllPoints()
	end
end

local bonus_elements
function addon.BonusRollFrame_Show()
	local frame = BonusRollFrame
	if not bonus_elements then
		bonus_elements = {}

		frame.active = true -- Prevent anchor from acquiring as child
		frame.scale_mod = 0.9 -- Anchor's scale modifier
		if opt.bonus_skin then
			frame.Background:Hide()
			local overlay = CreateFrame('Frame', nil, frame)
			overlay:SetAllPoints()
			overlay:SetFrameLevel(frame:GetFrameLevel()-1)
			Skinner:Skin(overlay, 'bonus')
			overlay:SetGradientColor(.5, .5, .5, .4)
			overlay:SetBorderColor(1, .8, .1)
			bonus_elements.overlay = overlay
		end
	end

	-- GroupLootContainer_RemoveFrame(GroupLootContainer, frame) -- Prevent GLC from restacking
	if anchor.children[1] ~= BonusRollFrame then
		table.insert(anchor.children, 1, frame) -- Force in first position
	end
	--frame:Show()
	anchor:Restack()
end

function addon.BonusRollFrame_Hide()
	if anchor.children[1] == BonusRollFrame then
		table.remove(anchor.children, 1)
		anchor:Restack()
	end
	--BonusRollFrame:Hide()
end

function addon.SlashHandler(msg)
	if msg == 'reset' then
		anchor:Position()
		alert_anchor:Position()
	elseif msg == 'opt' or msg == 'options' then
		addon.ShowOptions()
	else
		addon.ToggleAnchors()
	end
end

function addon:UpdateAnchors()
	if opt.roll_anchor.visible then
		anchor:Show()
	else
		anchor:Hide()
	end
	if opt.alert_anchor.visible then
		alert_anchor:Show()
	else
		alert_anchor:Hide()
	end
end

function addon.ToggleAnchors() 
	if anchor:IsShown() then
		anchor:Hide()
		alert_anchor:Hide()
	else
		anchor:Show()
		alert_anchor:Show()
	end
end

-------------------------------------------------------------------------------
-- Frame creation

do
	local sf = string.format
	-- Add a specific roll type to the tooltip
	local function RollLines(list, hid)
		for _,pid in pairs(list) do
			local name, class, rtype, roll, is_winner, is_me = HistoryGetPlayerInfo(hid, pid)
			if not name then return nil end
			local text, r, g, b, color = FancyPlayerName(name, class)
			if roll ~= nil then
				if is_winner then
					color = '44ff22'
				elseif is_me then
					color = 'ff2244'
				else
					color = 'CCCCCC'
				end
				GameTooltip:AddLine(sf('   |cff%s%s|r  %s', color, roll, text), r, g, b)
			else
				GameTooltip:AddLine('   '..text, r, g, b)
			end
		end
	end

	-- Add roll status or summary to tooltip
	local tneed, tgreed, tpass, trolls, tnone, ti, ts
		= {}, {}, {}, {}, {}, table.insert, table.sort
	local function rsort(a, b)
		a, b = trolls[a] or 0, trolls[b] or 0
		return a > b and true or false
	end

	local function AddTooltipLines(self, show_all, show)
		-- Locate history item
		local rollid, hid = self.rollid, 1
		local hrollid, link, players, done
		while true do
			hrollid, link, players, done = HistoryGetItem(hid)
			if not hrollid then
				return
			elseif hrollid == rollid then
				break
			end
			hid = hid+1
		end

		-- Generate player lists
		local tneed, tgreed, tpass, tnone, trolls
			= wipe(tneed), wipe(tgreed), wipe(tpass), wipe(tnone), wipe(trolls)
		for pid=1, players do
			local _, _, rtype = HistoryGetPlayerInfo(hid, pid)
			if rtype then
				if rtype == 0 then
					ti(tpass, pid)
				elseif rtype == 1 then
					ti(tneed, pid)
				elseif rtype == 2 or rtype == 3 then
					ti(tgreed, pid)
				end
				trolls[pid] = roll
			else
				ti(tnone, pid)
			end
		end

		ts(tneed, rsort)
		ts(tgreed, rsort)
		ts(tpass, rsort)

		-- Generate tooltip
		if show_all then
			GameTooltip:AddLine('.', 0, 0, 0)
		end
		if next(tneed) and (show_all or show == 1) then
			GameTooltip:AddLine(NEED, .2, 1, .1)
			RollLines(tneed, hid)
		end
		if next(tgreed) and (show_all or (show == 2 or show == 3)) then
			GameTooltip:AddLine(GREED, .1, .2, 1)
			RollLines(tgreed, hid)
		end
		if next(tpass) and (show_all or show == 0) then
			GameTooltip:AddLine(PASS, .7, .7, .7)
			RollLines(tpass, hid)
		end
		if show_all and opt.show_undecided then
			GameTooltip:AddLine(L.undecided, .7, .3, .2)
			RollLines(tnone, hid)
		end

		-- Force tooltip to refresh
		GameTooltip:Show()
		return true
	end

	---------------------------------------------------------------------------
	-- Roll buttons
	---------------------------------------------------------------------------
	local CreateRollButton
	do
		local function OnClick(self)
			RollOnLoot(self.parent.rollid, self.type)
		end
		
		local function Toggle(self, status)
			if status then
				self:Enable()
				self:SetAlpha(1)
			else
				self:Disable()
				self:SetAlpha(.6)
			end
			SetDesaturation(self:GetNormalTexture(), not status)
		end

		local function OnEnter(self)
			mouse_focus = self
			GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT')
			if not AddTooltipLines(self.parent, false, self.type) and self:IsEnabled() ~= 0 then
				GameTooltip:SetText(self.label)
				GameTooltip:Show()
			end
		end

		local function OnLeave(self)
			mouse_focus = nil
			GameTooltip:Hide()
		end

		local function SetText(self, text)
			if text and text > 0 then
				self.text:SetText(text)
			else
				self.text:SetText()
			end
		end

		local path = [[Interface\Buttons\UI-GroupLoot-%s-%s]]
		function CreateRollButton(parent, roll, label, tex, to, x, y)
			local b = CreateFrame('Button', nil, parent)
			b:SetPoint('LEFT', to, 'RIGHT', x, y)
			b:SetWidth(opt.roll_button_size)
			b:SetHeight(opt.roll_button_size)
			b:SetNormalTexture(path:format(tex, 'Up'))
			if tex ~= 'Pass' then
				b:SetHighlightTexture(path:format(tex, 'Highlight'))
				b:SetPushedTexture(path:format(tex, 'Down'))
			else
				b:SetHighlightTexture(path:format(tex, 'Up'))
				b:GetNormalTexture():SetVertexColor(0.8, 0.7, 0.7)
				b:GetHighlightTexture():SetAlpha(0.5)
			end
			b.parent = parent

			local text = b:CreateFontString(nil, 'OVERLAY')
			text:SetFont(STANDARD_TEXT_FONT, 12, 'THICKOUTLINE')
			text:SetPoint("CENTER", -x + 1, tex == 'DE' and -y +2 or -y)
			b.text = text

			b:SetScript('OnEnter', OnEnter)
			b:SetScript('OnLeave', OnLeave)
			b:SetScript('OnClick', OnClick)
			b:SetMotionScriptsWhileDisabled(true)
			b.OnEnter = OnEnter
			b.Toggle = Toggle
			b.type = roll
			b.label = label
			b.SetText = SetText

			return b
		end
	end

	---------------------------------------------------------------------------
	-- Roll frames
	---------------------------------------------------------------------------
	-- Events
	local function OnEnter(self)
		mouse_focus = self
		GameTooltip:SetOwner(self.icon_frame, 'ANCHOR_TOPLEFT', 28, 0)
		GameTooltip:SetHyperlink(self.link)
		if opt.show_decided or opt.show_undecided then
			AddTooltipLines(self, true)
		end
		if IsShiftKeyDown() then
			GameTooltip_ShowCompareItem()
		end
		if IsModifiedClick('DRESSUP') then
			ShowInspectCursor()
		else
			ResetCursor()
		end
	end

	local function OnLeave(self)
		mouse_focus = nil
		GameTooltip:Hide()
	end

	local function OnClick(self, button)
		if IsControlKeyDown() then
			DressUpItemLink(self.link)
		elseif IsShiftKeyDown() then
			ChatEdit_InsertLink(self.link)
		end
	end

	-- Status bar update
	local max = math.max
	local function BarUpdate(self)
		local parent = self.parent
		if parent.over then
			self.spark:Hide()
			self:SetValue(0)
			parent.text_time:SetText()
			return
		end
		local time = GetTime()
		-- TODO: Remove?
		if GetLootRollTimeLeft(parent.rollid) == 0 then
			local ended = parent.rollended
			if ended then
				if time - ended > 10 then
					anchor:Pop(parent)
				end
			else
				parent.rollended = time
			end
		end
		-- /TODO
		local remaining = self.expires - time
		if remaining < -4 then
			anchor:Pop(parent)
		else
			local now, length = max(remaining, -1), self.length
			self.spark:SetPoint('CENTER', self, 'LEFT', (now / length) * self:GetWidth(), 0)
			self:SetValue(now)
			self.spark:Show()
			if opt.text_time then
				if remaining >= 0 then
					parent.text_time:SetText(sf('%.0f', max(0, remaining)))
					parent.text_time:Show()
				else
					parent.text_time:Hide()
				end
			end
		end
	end

	local function Popped(self)
		rolls[self.rollid] = nil
	end

	-- Create roll frame
	function addon.CreateRollFrame()
		-- Base frame
		local frame = CreateFrame('Button', nil, UIParent)
		frame:SetFrameLevel(anchor:GetFrameLevel())
		frame:SetHeight(24)
		frame:SetWidth(opt.roll_width)
		frame:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
		frame:SetScript('OnEnter', OnEnter)
		frame:SetScript('OnLeave', OnLeave)
		frame:SetScript('OnClick', OnClick)
		frame.OnEnter = OnEnter
		frame.Start = Start
		frame.Popped = Popped
		
		-- Overlay (For skin border)
		local overlay = CreateFrame('frame', nil, frame)
		overlay:SetFrameLevel(frame:GetFrameLevel())
		overlay:SetAllPoints()
		local skin = Skinner:Skin(overlay, 'row')

		-- Item icon (For skin border)
		local icon_frame = CreateFrame('Frame', nil, frame)
		icon_frame:SetPoint('LEFT', 0, 0)
		icon_frame:SetWidth(28)
		icon_frame:SetHeight(28)
		Skinner:Skin(icon_frame, 'item')

		-- Item texture
		local icon = icon_frame:CreateTexture(nil, 'BACKGROUND')
		icon:SetPoint('TOPLEFT', 3, -3)
		icon:SetPoint('BOTTOMRIGHT', -3, 3)
		icon:SetTexCoord(.07,.93,.07,.93)
		
		-- Timer bar
		local bar = CreateFrame('StatusBar', nil, frame)
		bar:SetFrameLevel(frame:GetFrameLevel())
		local pad = skin.padding or 2
		bar:SetPoint('TOPRIGHT', -pad - 3, -pad - 3)
		bar:SetPoint('BOTTOMRIGHT', -pad - 3, pad + 3)
		bar:SetPoint('LEFT', icon_frame, 'RIGHT', -pad, 0)
		bar:SetStatusBarTexture(skin.bar_texture)
		bar:SetScript('OnUpdate', BarUpdate)
		bar.parent = frame
		-- Reference bar for quick re-skinning when XLoot skin changes
		table.insert(addon.bars, bar)
		
		local spark = bar:CreateTexture(nil, 'OVERLAY')
		spark:SetWidth(14)
		spark:SetHeight(38)
		spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
		spark:SetBlendMode('ADD')
		bar.spark = spark

		-- Bind text
		local bind = icon_frame:CreateFontString(nil, 'OVERLAY')
		bind:SetPoint('BOTTOM', 0, 1)
		bind:SetFont(STANDARD_TEXT_FONT, 8, 'THICKOUTLINE')

		-- Time text
		local time = icon_frame:CreateFontString(nil, 'OVERLAY')
		time:SetPoint('CENTER', 0, 2)
		time:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')

		-- Roll buttons
		local n = CreateRollButton(frame, 1, NEED, 'Dice', icon_frame, 3, -1)
		local g = CreateRollButton(frame, 2, GREED, 'Coin', n, 0, -2)
		local d = CreateRollButton(frame, 3, ROLL_DISENCHANT, 'DE', g, 0, 2)
		local p = CreateRollButton(frame, 0, PASS, 'Pass', d, 0, 2)

		-- Roll status text
		local status = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		status:SetHeight(16)
		status:SetJustifyH('LEFT')
		SetOutline(status)
		status:SetPoint('LEFT', icon_frame, 'RIGHT', 1, 0)
		status:SetPoint('RIGHT', p, 'RIGHT', 2, 0)

		-- Loot name/link
		local loot = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		loot:SetHeight(16)
		loot:SetJustifyH('LEFT')
		SetOutline(loot)
		loot:SetPoint('LEFT', p, 'RIGHT', 3, -1)
		loot:SetPoint('RIGHT', frame, 'RIGHT', -5, 0)

		-- Frame references
		frame.need, frame.greed, frame.disenchant, frame.pass = n, g, d, p
		frame.text_bind = bind
		frame.text_status = status
		frame.text_loot = loot
		frame.text_time = time
		frame.overlay = overlay
		frame.bar = bar
		frame.icon = icon
		frame.icon_frame = icon_frame
		frame.Update = UpdateRow

		return frame
	end
end

---------------------------------------------------------------------------
-- AddOn setup and events
---------------------------------------------------------------------------

-- Update skins when XLoot skin changes
function addon:SkinUpdate()
	local skin = Skinner:Reskin()
	local padding = skin.padding or 2
	local p, n = padding + 3, -padding - 3
	for _,bar in pairs(addon.bars) do
		bar:ClearAllPoints()
		bar:SetPoint('TOPRIGHT', n, n)
		bar:SetPoint('BOTTOMRIGHT', n, p)
		bar:SetPoint('LEFT', bar.parent.icon_frame, 'RIGHT', -padding, 0)
		bar:SetStatusBarTexture(skin.bar_texture)
		local link = bar.parent.link
		if link then
			local r, g, b = GetItemQualityColor(select(3, GetItemInfo(link)))
			bar.parent.overlay:SetBorderColor(r, g, b)
			bar.parent.icon_frame:SetBorderColor(r, g, b)
		end
	end

end

-- Move anchors when scale changes
function addon:ApplyOptions()
	opt = self.opt

	anchor:UpdateSVData(opt.roll_anchor)
	alert_anchor:UpdateSVData(opt.alert_anchor)

	self:SkinUpdate()

	anchor:Restack()
	for _,frame in pairs(anchor.children) do
		frame:SetWidth(opt.roll_width)
		frame.need:SetWidth(opt.roll_button_size)
		frame.need:SetHeight(opt.roll_button_size)
		frame.greed:SetWidth(opt.roll_button_size)
		frame.greed:SetHeight(opt.roll_button_size)
		frame.disenchant:SetWidth(opt.roll_button_size)
		frame.disenchant:SetHeight(opt.roll_button_size)
		frame.pass:SetWidth(opt.roll_button_size)
		frame.pass:SetHeight(opt.roll_button_size)
		SetOutline(frame.text_status)
		SetOutline(frame.text_loot)
		if not opt.text_time then
			frame.text_time:SetText()
		end
	end
end



