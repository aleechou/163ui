-- **********************************************************
-- **             Deadly Boss Mods - AutoInvite            **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
-- 
-- The localizations are written by:
--    * enGB/enUS: Nitram/Tandanu        http://www.deadlybossmods.com		
--    * deDE: Nitram/Tandanu             http://www.deadlybossmods.com
--    * zhCN: yleaf(yaroot@gmail.com)
--    * zhTW: readjust by yleaf(yaroot@gmail.com)/Juha
--    * koKR: BlueNyx(bluenyx@gmail.com)/nBlueWiz(everfinale@gmail.com)
--    * (add your names here!)
--
-- 
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share  to copy, distribute, display, and perform the work
--    * to Remix  to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--

local L = DBM_AutoInvite_Translations

local default_settings = {
	enabled = true,
	keywords = {'invite', 'inv'},
	guildmates = true,
	friends = true,
	other = false,
	lastaoerank = 0,

	promote_all = false,
	promote_rank = 0,
	promote_names = {}
}


DBM_AutoInvite_Settings = {}
local settings = default_settings


local settings = DBM_AutoInvite_Options
local mainframe = CreateFrame("Frame", "DBM_AutoInvite", UIParent)

-- functions for local scope
local UpdateGuildList
local IsGuildMember
local AOE_Ginvite
local GetGuildRank
local UpdateFriendList
local IsFriend
local DoInvite
local slashfunction
local FormatPlayerName
local addDefaultOptions

function slashfunction()
	if GetNumGroupMembers() == 0 then
		DBM:AddMsg(L.WarnMsg_NoRaid)
	elseif not (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
		DBM:AddMsg(L.WarnMsg_NotLead)
	else
		SendChatMessage(L.WarnMsg_InviteIncoming, "GUILD")
		GuildRoster()
		DBM:Schedule(10, AOE_Ginvite)
	end
end

do 
	local function toboolean(var) 
		if var then return true else return false end
	end

	-- some functions required to filter out some bad input from the user
	local function donameformat(part)
		part = FormatPlayerName( strtrim(part:lower()) )
		if part:len() > 0 then
			return part
		else 
			return nil
		end
	end
	local function concat(mytable, split, bykey)
		if not split then split = " " end
		if type(mytable) ~= "table" then return "" end
		local text = split
		for k,v in pairs(mytable) do
			if bykey then
				text = text..k..split
			else
				text = text..v..split
			end
		end
		return strtrim(text)
	end
	local function explode(div,str)
		if not div or div=='' then return false end
		local	pos,arr = 0,{}
		for st,sp in function() return string.find(str, div, pos, true) end do
			table.insert(arr, string.sub(str,pos,st-1)) 	-- Attach chars left of current divider
			pos = sp + 1 									-- Jump past current divider
		end
		table.insert(arr, string.sub(str,pos)) 				-- Attach chars right of last divider
		return arr
	end
	local function filternames(input) 
		local mytable = {}
		local cleaned
		input = string.gsub(input, ",", " ")	-- remove comma
		input = string.gsub(input, ";", " ")	-- remove semicolons
		input = string.gsub(input, "%d", "")	-- remove numeric inputs
		for _,match in pairs(explode(" ", input)) do
			cleaned = donameformat(match)
			if cleaned then
				table.insert(mytable, cleaned)
			end
		end
		return mytable
	end

	local function creategui()
		local panel = DBM_RaidLeadPanel:CreateNewPanel(L.TabCategory_AutoInvite, "option")
		do
			local area = panel:CreateArea(L.AreaGeneral, nil, 200, true)

			local enabled = area:CreateCheckButton(L.Activate, true)
			local guildmates = area:CreateCheckButton(L.AllowGuildMates, true)		
			local friends = area:CreateCheckButton(L.AllowFriends, true)		
			local other = area:CreateCheckButton(L.AllowOthers, true)		
			local keyword = area:CreateEditBox(L.KeyWord, '', 200)		
			keyword:SetPoint('TOPLEFT', other, "BOTTOMLEFT", 15, -15)

			local Ranks = {}
			for i=1, GuildControlGetNumRanks(), 1 do
				table.insert(Ranks, { text=i..". "..GuildControlGetRankName(i),value=i })
			end
			local AOEbyGuildRank = area:CreateDropdown(L.AOEbyGuildRank, Ranks, settings.lastaoerank, function(value) settings.lastaoerank = tonumber(value) end, 200)
			AOEbyGuildRank:SetScript("OnShow", function(self) 
				table.wipe(Ranks)
				for i=1, GuildControlGetNumRanks(), 1 do
					table.insert(Ranks, { text=i..". "..GuildControlGetRankName(i),value=i })
				end
			end)
			AOEbyGuildRank:SetPoint("TOPLEFT", area.frame, "TOPLEFT", -3, -160)


			local aoeinv = area:CreateButton(L.Button_AOE_Invite, 150)
			aoeinv:SetPoint("TOPLEFT", AOEbyGuildRank, "TOPRIGHT", 15, -5)
			aoeinv:SetScript("OnClick", slashfunction)
	
			enabled:SetScript("OnClick", 		function(self) settings.enabled = toboolean(self:GetChecked()) end)
			enabled:SetScript("OnShow", 		function(self) self:SetChecked(settings.enabled) end)
			guildmates:SetScript("OnClick", 	function(self) settings.guildmates = toboolean(self:GetChecked()) end)
			guildmates:SetScript("OnShow", 		function(self) self:SetChecked(settings.guildmates) end)
			friends:SetScript("OnClick", 		function(self) settings.friends = toboolean(self:GetChecked()) end)
			friends:SetScript("OnShow", 		function(self) self:SetChecked(settings.friends) end)
			other:SetScript("OnClick",			function(self) settings.other = toboolean(self:GetChecked()) end)
			other:SetScript("OnShow", 			function(self) self:SetChecked(settings.other) end)
--			keyword:SetScript("OnTextChanged", 	function(self) settings.keyword = self:GetText():lower() end)
--			keyword:SetScript("OnShow", 		function(self) self:SetText(settings.keyword) end)
			keyword:SetScript("OnShow", 		function(self) self:SetText( concat(settings.keywords, " ") ) end)
			keyword:SetScript("OnTextChanged",  function(self) 
				table.wipe(settings.keywords)
				for k,v in ipairs( explode(" ", self:GetText()) ) do
					table.insert(settings.keywords, v)
				end
			end)

		end
		do
			local area = panel:CreateArea(L.AreaRaidOptions, nil, 130, true)

			local PromoteEveryone = area:CreateCheckButton(L.PromoteEveryone, true)
			PromoteEveryone:SetScript("OnShow", function(self) self:GetChecked(settings.promote_all) end)
			PromoteEveryone:SetScript("OnClick", function(self) settings.promote_all = not not self:GetChecked() end)
			
			local Ranks = {}
			table.insert(Ranks, { text=L.DontPromoteAnyRank, value=0 })
			for i=1, GuildControlGetNumRanks(), 1 do
				table.insert(Ranks, { text=i..". "..GuildControlGetRankName(i), value=i })
			end			

			local PromoteGuildRank = area:CreateDropdown(L.PromoteGuildRank, Ranks, settings.promote_rank, function(value) settings.promote_rank = value end, 200)
			PromoteGuildRank:SetScript("OnShow", function(self) 
				table.wipe(Ranks)
				table.insert(Ranks, { text=L.DontPromoteAnyRank, value=0 })
				for i=1, GuildControlGetNumRanks(), 1 do
					table.insert(Ranks, { text=i..". "..GuildControlGetRankName(i), value=i })
				end
			end)
			PromoteGuildRank:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 0, -50)

			local PromoteByNameList = area:CreateEditBox(L.PromoteByNameList, '', 350)	
			PromoteByNameList:SetScript("OnTextChanged", function(self) 
				table.wipe(settings.promote_names)
				for k,v in pairs(filternames(self:GetText())) do 
					settings.promote_names[v] = true
				end
			end)
			PromoteByNameList:SetScript("OnShow", function(self) self:SetText( concat(settings.promote_names, " ", true) ) end)
			PromoteByNameList:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 27, -90)


			local resettool = area:CreateButton(L.Button_ResetSettings, 100, 16)
			resettool:SetPoint('BOTTOMRIGHT', area.frame, "TOPRIGHT", 0, 0)
			resettool:SetNormalFontObject(GameFontNormalSmall)
			resettool:SetHighlightFontObject(GameFontNormalSmall)
			resettool:SetScript("OnClick", function(self) 
				table.wipe(DBM_AutoInvite_Settings)
				addDefaultOptions(settings, default_settings)

				DBM_GUI_OptionsFrame:Hide()
				DBM_GUI_OptionsFrame:Show()				
			end)
			
		end
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 15)
end

function FormatPlayerName(name)
	if name:len() > 0 then 
		-- check for UTF start
		if bit.band(name:sub(0, 1):byte(), 128) == 128 then
			name = name:sub(0, 2):upper()..name:sub(3):lower()
		else
			name = name:sub(0, 1):upper()..name:sub(2):lower()
		end
		return name
	else 
		return ""
	end
end

function addDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" then
			addDefaultOptions(v, t2[i])
		end
	end
end

do
	local GuildMates = {}
	local GuildRank = {}
	function UpdateGuildList()
		table.wipe(GuildMates)
		table.wipe(GuildRank)
		for i=1, GetNumGuildMembers(), 1 do
			local name, _, rankIndex = GetGuildRosterInfo(i)
			if name then
				table.insert(GuildMates, name)
				GuildRank[name] = rankIndex + 1
			end
		end
	end
	function IsGuildMember(name)
		for _,v in pairs(GuildMates) do
			if v == name then
				return true
			end
		end
		return false
	end
	function GetGuildRank(name)	
		return GuildRank and GuildRank[name] or 99		-- high value because we don't want to invite errors (we invite Rank or highter)
	end
	function AOE_Ginvite()
		for _,v in pairs(GuildMates) do
			if settings.lastaoerank > 0 and GuildRank[v] <= settings.lastaoerank then 
				DoInvite(v)
			end
		end		
	end
end

do
	local waitinginvites = {}
	local function IsFriend(name)
		for i=1, GetNumFriends(), 1 do
			if GetFriendInfo(i) == name then
				return true
			end
		end
		return false
	end

	DBM:RegisterCallback("raidJoin", function(event, name)
		if settings.enabled and name and DBM:GetRaidRank() > 0 then
			if (IsGuildMember(name) and GetGuildRank(name, true) <= settings.promote_rank)
			or settings.promote_names[name] or settings.promote_all then
				PromoteToAssistant(name)
			end
		end
	end)

	function DoInvite(name)
		pplcount = GetNumGroupMembers();
		if not IsInRaid() then
			pplcount = GetNumSubgroupMembers() or 0
			if pplcount > 0 and not UnitIsGroupLeader("player") then
				DBM:AddMsg( L.InviteFailed:format(name) )
			else
				if pplcount < 4 then
					InviteUnit(name)

				elseif pplcount == 4 then
					DBM:AddMsg( L.ConvertRaid )
					ConvertToRaid()
					InviteUnit(name)
				end
			end

		elseif DBM:GetRaidRank() > 0 and pplcount < 40 then 
			InviteUnit(name)

		elseif DBM:GetRaidRank() == 0 then
			SendChatMessage("<DBM> "..L.WhisperMsg_NotLeader, "WHISPER", nil, name)

		elseif pplcount >=40 then
			SendChatMessage("<DBM> "..L.WhisperMsg_RaidIsFull, "WHISPER", nil, name)
		end
	end

	local function is_keyword(msg)
		for _,v in pairs(settings.keywords) do
			if v == msg then
				return true
			end
		end
		return false
	end
	local function OnMsgRecived(msg, name)
		if settings.enabled and is_keyword(msg:lower()) then
			local doautoinvite = false
	
			if settings.friends and IsFriend(name) then
				doautoinvite = true

			elseif settings.other then
				doautoinvite = true

			elseif settings.guildmates then	
				table.insert(waitinginvites, name)
				GuildRoster()
			end
			if doautoinvite then DoInvite(name) end
		end
	end

	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			-- Update settings of this Addon
			settings = DBM_AutoInvite_Settings
			addDefaultOptions(settings, default_settings)

			self:RegisterEvent("CHAT_MSG_WHISPER")
			self:RegisterEvent("GUILD_ROSTER_UPDATE")

			-- on addon loaded, we call the guildroster to get all required informations
			GuildRoster()

		elseif event == "CHAT_MSG_WHISPER" then
			OnMsgRecived(select(1, ...), select(2, ...))

		elseif event == "GUILD_ROSTER_UPDATE" then
			UpdateGuildList()
			for i=#waitinginvites, 1, -1 do
				if IsGuildMember(waitinginvites[i]) then
					DoInvite(waitinginvites[i])
				end
				waitinginvites[i] = nil
			end
		end
	end)
	
	-- lets register the Events
	mainframe:RegisterEvent("ADDON_LOADED")
end


SLASH_DBMAUTOINVITE1 = "/inviteguild"
SlashCmdList["DBMAUTOINVITE"] = slashfunction 






