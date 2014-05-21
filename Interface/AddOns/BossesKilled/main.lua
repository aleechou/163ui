--[[
	The look of the buttons/numbers/arrow can be altered by adding this addon to the
	OptionalDeps of an external addon which then overrides the functions marked below.
]]


local _, addon = ...

BossesKilled = addon

function addon:PLAYER_LOGIN()
	-- Hook flex frame's onshow
	local function myFlexRaidFrame_OnShow(frame)
		self:CreateButtons(frame, GetNumFlexRaidDungeons, GetFlexRaidDungeonInfo, FlexRaidFrame_SetRaid)
		self:UpdateButtonsAndTooltips(frame)
		self.UpdateArrow()
	end
	FlexRaidFrame:HookScript("OnShow", myFlexRaidFrame_OnShow)

	-- Hook raid finder frame's onshow
	local function myRaidFinderFrame_OnShow(frame)
		self:CreateButtons(frame, GetNumRFDungeons, GetRFDungeonInfo, RaidFinderQueueFrame_SetRaid)
		self:UpdateButtonsAndTooltips(frame)
		self:UpdateQueueStatuses()
		self.UpdateArrow()
		self:RegisterEvent("LFG_UPDATE")
	end
	RaidFinderQueueFrame:HookScript("OnShow", myRaidFinderFrame_OnShow)

	-- Hook raid finder frame's onhide
	local function myRaidFinderFrame_OnHide(frame)
		self:UnregisterEvent("LFG_UPDATE")
	end
	RaidFinderQueueFrame:HookScript("OnHide", myRaidFinderFrame_OnHide)

	hooksecurefunc("FlexRaidFrame_SetRaid", self.UpdateArrow)
	hooksecurefunc("RaidFinderQueueFrame_SetRaid", self.UpdateArrow)

	-- Our event dispatcher calls functions like addon[eventName](...), so point it to the right update function
	self.LFG_UPDATE = self.UpdateQueueStatuses
end
addon:RegisterEvent("PLAYER_LOGIN")

-- Creates the buttons. LFR and Flex use different functions and dropdown menus so take them as arguments
function addon:CreateButtons(parentFrame, DungeonAmountFunc, DungeonInfoFunc, SetDropdownMenuFunc)
	local scale = self:GetButtonScale(DungeonAmountFunc())

	if not parentFrame.BossesKilledButtons then
		parentFrame.BossesKilledButtons = {}
	end
	local buttons = parentFrame.BossesKilledButtons

	for i = 1, DungeonAmountFunc() do
		local id, name = DungeonInfoFunc(i)
		local isAvailable, isAvailableToPlayer = IsLFGDungeonJoinable(id)

		 -- Only make a button if there's data for it, and it hasn't been already made. This gets called multiple times so it updates correctly when you open up more raids
		if isAvailable and isAvailableToPlayer and not buttons[id] and self.raidData[id] then
			local button = self:CreateButton(parentFrame, scale)
			button.dungeonID = id
			button.dungeonName = name

			buttons[id] = button
			parentFrame.lastButton = button

			-- I just realised a CheckButton might already have it's own FontString, but uh... whatever.
			button.number = self:CreateNumber(button)

			button:SetScript("OnEnter", function(this)
				if this.tooltip then
					self:ShowTooltip(this)
				end
			end)

			button:SetScript("OnClick", function(this)
				SetDropdownMenuFunc(this.dungeonID)
				self.UpdateArrow()

				-- This is to override the automatic highlighting when you click the button, while we want to use that to show queue status instead.
				-- I've no idea why simply overriding this OnClick and not doing a SetChecked doesn't disable the behavior.
				-- I probably shouldn't be using a CheckButton at all, but the SpellBookSkillLineTabTemplate looks pretty nice for the job.
				this:SetChecked(this.checked)
			end)
			button.checked = false
		end
	end
end

---------------------------------------- Overridables ----------------------------------------

-- Must return a CheckButton, or implement :SetChecked() and support OnClick scripts. Not 100% right now if anything else
function addon:CreateButton(parent, scale)
	local button = CreateFrame("CheckButton", parent:GetName().."BossesKilledButton"..tostring(id), parent, "SpellBookSkillLineTabTemplate")
	button:Show()

	if parent.lastButton then
		button:SetPoint("TOPLEFT", parent.lastButton, "BOTTOMLEFT", 0, -15)
	else
		-- I don't like this fix for SocialTabs. It looks ugly, but it's good enough until (if) I figure out a more aesthetically pleasing solution
		button:SetPoint("TOPLEFT", parent, "TOPRIGHT", (3 + (IsAddOnLoaded("SocialTabs") and ceil(32/scale) or 0)), -50)
	end

	button:SetScale(scale)
	button:SetWidth(32 + 16) -- Original width is 32

	-- Need to find the button's texture in the regions so we can resize it. I don't like this part, but I can't think of a better way in case it's not the first region returned. (Is it ever not?)
	for _, region in ipairs({button:GetRegions()}) do
		if type(region) ~= "userdata" and region.GetTexture and region:GetTexture() == "Interface\\SpellBook\\SpellBook-SkillLineTab" then
			region:SetWidth(64 + 24) -- Original width is 64
			break
		end
	end

	return button
end

function addon:GetButtonScale(numDungeons)
	-- Ok, I still don't understand anything about the positioning and sizing of stuff in WoW, but the target frame is about 280'ish tall and buttons 32 and who gives a shit about margins and aaargh I'm going crazy /headexplode
	-- Magic numbers! There's really no method to the madness, these numbers just happen to look ok
	return min(300 / (numDungeons * 32), 1)
end

-- Must return a fontstring
function addon:CreateNumber(button)
	local number = button:CreateFontString(button:GetName().."Number", "OVERLAY", "SystemFont_Shadow_Huge3")
	number:SetPoint("TOPLEFT", -4, 4)
	number:SetPoint("BOTTOMRIGHT", 5, -5)
	return number
end

-- Called from :UpateArrow()
function addon:CreateArrow()
	local arrow = GroupFinderFrame:CreateTexture("BossesKilledArrow", "ARTWORK")
	arrow:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
	arrow:SetTexCoord(1, 0, 0, 1) -- This somehow turns the arrow other way around. Magic. /shrug
	arrow:SetSize(32, 32) -- Originally 16, 16
	arrow:Hide()
	return arrow
end

--------------------------------------- Update functions -------------------------------------

function addon:UpdateButtonsAndTooltips(parentFrame)
	local buttons = parentFrame.BossesKilledButtons

	for id, button in pairs(buttons) do
		local numKilled = 0

		-- GetLFGDungeonNumEncounters returns the full set of bosses for the whole raid, while LFR and Flex raids
		-- are split into several separate raids, so get the amount of bosses and where to start from from our data file
		local index = self.raidData[id].startFrom
		local numEncounters = self.raidData[id].numEncounters

		local tooltip = {{text = button.dungeonName}} -- Set up tooltip data with the dungeon name
		for i = index, numEncounters + index - 1 do
			local bossName, _, isKilled = GetLFGDungeonEncounterInfo(id, i)

			if isKilled then
				if ENABLE_COLORBLIND_MODE == "1" then
					table.insert(tooltip, {text = "Dead - "..bossName})
				else
					table.insert(tooltip, {text = bossName, color = {RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b}})
				end
				numKilled = numKilled + 1
			else
				if ENABLE_COLORBLIND_MODE == "1" then
					table.insert(tooltip, {text = "Alive - "..bossName})
				else
					table.insert(tooltip, {text = bossName, color = {GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b}})
				end
			end
		end
		button.tooltip = tooltip

		local statusString = numKilled.."/"..numEncounters
		if ENABLE_COLORBLIND_MODE == "1" then
			button.number:SetFormattedText("|c00ffffff%s|r", statusString)
		else
			button.number:SetFormattedText(self.textColorTable[statusString], statusString)
		end
	end
end

function addon:UpdateQueueStatuses()
	for id, button in pairs(RaidFinderQueueFrame.BossesKilledButtons) do
		local mode = GetLFGMode(LE_LFG_CATEGORY_RF, id);
		if mode == "queued" or mode == "listed" or mode == "rolecheck" or mode == "suspended" then
			button:SetChecked(true)
			button.checked = true -- This is for the PostClick script earlier
		else
			button:SetChecked(false)
			button.checked = false
		end
	end
end

-- Not a method 'cos it's used as callback for hooksecurefuncs so it would get the wrong "self"
function addon.UpdateArrow()
	local arrow
	if not addon.arrow then
		arrow = addon:CreateArrow()
		addon.arrow = arrow
	else
		arrow = addon.arrow
	end

	local parent
	if FlexRaidFrame:IsVisible() then
		parent = FlexRaidFrame
	elseif RaidFinderQueueFrame:IsVisible() then
		parent = RaidFinderQueueFrame
	else
		arrow:Hide()
		return
	end

	if parent.raid and parent.BossesKilledButtons[parent.raid] then
		local button = parent.BossesKilledButtons[parent.raid]
		arrow:SetParent(button) -- Re-set the parent so we inherit the scale, so our smaller LFR buttons get a smaller arrow
		arrow:SetPoint("LEFT", button, "RIGHT")
		arrow:Show()
	end
end

--------------------------------- Tooltip and colorization stuff -----------------------------

function addon:ShowTooltip(button)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	for i = 1, #button.tooltip do
		tooltip = button.tooltip[i]
		if tooltip.color then
			GameTooltip:AddLine(tooltip.text, unpack(tooltip.color))
		else
			GameTooltip:AddLine(tooltip.text)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("<点击选择此副本>")
	GameTooltip:AddLine(" ")
	if ENABLE_COLORBLIND_MODE == "1" then
		GameTooltip:AddLine("(Button lights up if you're queued for this raid)")
	else
		GameTooltip:AddLine("[ |c00ff0000红色|r 表示本周已击杀该 BOSS]")
		GameTooltip:AddLine("[ |c0000ff00绿色|r 表示本周未击杀该 BOSS]")
		GameTooltip:AddLine("[ |c00FFFF00高亮|r 表示您已加入该副本队列]")
	end
	GameTooltip:Show()
end

local select, modf, format, strmatch = select, math.modf, format, strmatch
-- gets passed a "x/y" STRING. No sanity checks so make sure the calling function feeds it the expected format.
-- the vararg gets passed color triples, eg. 0.0,1.0,0.0,  1.0,0.0,0.0 (green to red)
function addon:TextColorGradient(str_percent, ...)
	local num = select("#", ...)
	local low, high = strmatch(str_percent, "(%d+)/(%d+)")
	local percent = (low + 0) / (high + 0) -- implicit cast to number, cheaper than tonumber
	local r, g, b

	if percent >= 1 then
		r, g, b = select(num - 2, ...), select(num - 1, ...), select(num, ...)
		return format("|cff%02x%02x%02x%%s|r", r * 255, g * 255, b * 255)
	elseif percent <= 0 then
		r, g, b = ...
		return format("|cff%02x%02x%02x%%s|r", r * 255, g * 255, b * 255)
	end

	local segment, relperc = modf(percent * (num / 3 - 1))
	local r1, g1, b1, r2, g2, b2
	r1, g1, b1 = select((segment * 3) + 1, ...), select((segment * 3) + 2, ...), select((segment * 3) + 3, ...)
	r2, g2, b2 = select((segment * 3) + 4, ...), select((segment * 3) + 5, ...), select((segment * 3) + 6, ...)

	if not r2 or not g2 or not b2 then
		r, g, b = r1, g1, b1
	else
		r, g, b = r1 + (r2 - r1) * relperc,
		          g1 + (g2 - g1) * relperc,
		          b1 + (b2 - b1) * relperc
	end
	return format("|cff%02x%02x%02x%%s|r", r * 255, g * 255, b * 255)
end

-- Use a memoization table so each x/y colorstring is only computed once and then does a simple lookup
addon.textColorTable = setmetatable({}, {__index = function(t, k)
	local colorStr = addon:TextColorGradient(k, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, -- "From" color
	                                            RED_FONT_COLOR.r,   RED_FONT_COLOR.g,   RED_FONT_COLOR.b)   -- "To" color
	rawset(t, k, colorStr)
	return colorStr
end})
