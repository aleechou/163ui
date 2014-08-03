-----------------------------------------------------------------------
-- ChatFilter
-----------------------------------------------------------------------
local _, cf = ...
local Config = cf.Config
local L = cf.L
local _G = _G
local AddFriend = AddFriend
local RemoveFriend = RemoveFriend

local ChatFilter, ChatFilterLv, FriendsFrame, ChatFrames = CreateFrame("Frame"), CreateFrame("Frame"), FriendsFrame
local AddonLoading, prevLineId, orgmsg, adding, addedtime, addedplayer, Latency, craftQuantity, craftItemID, prevCraft
local CacheTable, ShieldTable, _ShieldTable, LevelTable, _LevelTable, ServerTable, AddedTable = {}, {}, {}, {}, {}, {}, {}
local achievements, alreadySent, spellList, totalCreated, resetTimer, craftList = {}, {}, {}, {}, {}, {}
local spamCategories, specialFilters = {[95] = true, [155] = true, [168] = true, [14807] = true, [15165] = true}, {[456] = true, [1400] = true, [1402] = true, [2186] = true, [2187] = true, [2903] = true, [2904] = true, [3004] = true, [3005] = true, [3117] = true, [3259] = true, [3316] = true, [3808] = true, [3809] = true, [3810] = true, [3817] = true, [3818] = true, [3819] = true, [4078] = true, [4079] = true, [4080] = true, [4156] = true, [4576] = true, [4626] = true, [5313] = true, [6954] = true, [7485] = true, [7486] = true, [7487] = true, [8089] = true, [8238] = true, [8246] = true, [8248] = true, [8249] = true, [8260] = true, [8306] = true, [8307] = true, [8398] = true, [8399] = true, [8400] = true, [8401] = true, [8430] = true, [8431] = true, [8432] = true, [8433] = true, [8434] = true, [8435] = true, [8436] = true, [8437] = true, [8438] = true, [8439] = true}

local function deformat(text)
	text = gsub(text, "%.", "%%.")
	text = gsub(text, "%%%d$s", "(.+)")
	text = gsub(text, "%%s", "(.+)")
	text = gsub(text, "%%d", "(%%d+)")
	text = "^"..text.."$"
	return text
end

local createmsg = deformat(LOOT_ITEM_CREATED_SELF)
local createmultimsg = deformat(LOOT_ITEM_CREATED_SELF_MULTIPLE)
local learnpassivemsg = deformat(ERR_LEARN_PASSIVE_S)
local learnspellmsg = deformat(ERR_LEARN_SPELL_S)
local learnabilitymsg = deformat(ERR_LEARN_ABILITY_S)
local unlearnspellmsg = deformat(ERR_SPELL_UNLEARNED_S)
local petlearnspellmsg = deformat(ERR_PET_LEARN_SPELL_S)
local petlearnabilitymsg = deformat(ERR_PET_LEARN_ABILITY_S)
local petunlearnspellmsg = deformat(ERR_PET_SPELL_UNLEARNED_S)
local auctionstartedmsg = deformat(ERR_AUCTION_STARTED)
local auctionremovedmsg = deformat(ERR_AUCTION_REMOVED)
local duelwinmsg = deformat(DUEL_WINNER_KNOCKOUT)
local duellosemsg = deformat(DUEL_WINNER_RETREAT)
local friendaddedmsg = deformat(ERR_FRIEND_ADDED_S)
local friendalreadymsg = deformat(ERR_FRIEND_ALREADY_S)
local friendnotfoundmsg = deformat(ERR_FRIEND_NOT_FOUND)
local friendlistfullmsg = deformat(ERR_FRIEND_LIST_FULL)
local ignorelistfullmsg = deformat(ERR_IGNORE_FULL)
local drunkmsg = {
	deformat(DRUNK_MESSAGE_ITEM_OTHER1),
	deformat(DRUNK_MESSAGE_ITEM_OTHER2),
	deformat(DRUNK_MESSAGE_ITEM_OTHER3),
	deformat(DRUNK_MESSAGE_ITEM_OTHER4),
	deformat(DRUNK_MESSAGE_OTHER1),
	deformat(DRUNK_MESSAGE_OTHER2),
	deformat(DRUNK_MESSAGE_OTHER3),
	deformat(DRUNK_MESSAGE_OTHER4),}

local function SendMessage(event, msg, r, g, b)
	local info = ChatTypeInfo[strsub(event, 10)]
	for i = 1, NUM_CHAT_WINDOWS do
		ChatFrames = _G["ChatFrame"..i]
		if (ChatFrames and ChatFrames:IsEventRegistered(event)) then
			ChatFrames:AddMessage(msg, info.r, info.g, info.b)
		end
	end
end

local function SendAchievement(event, achievementID, players)
	if (not players) then return end
	for k in pairs(alreadySent) do alreadySent[k] = nil end
	for i = getn(players), 1, -1 do
		if (alreadySent[players[i].name]) then
			tremove(players, i)
		else
			alreadySent[players[i].name] = true
		end
	end
	if (getn(players) > 1) then
		sort(players, function(a, b) return a.name < b.name end)
	end
	for i = 1, getn(players) do
		local class, color, r, g, b
		if (players[i].guid and tonumber(players[i].guid)) then
			class = select(2, GetPlayerInfoByGUID(players[i].guid))
			color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		end
		if (not color) then
			local info = ChatTypeInfo[strsub(event, 10)]
			r, g, b = info.r, info.g, info.b
		else
			r, g, b = color.r, color.g, color.b
		end
		players[i] = format("|cff%02x%02x%02x|Hplayer:%s|h%s|h|r", r*255, g*255, b*255, players[i].name, players[i].name)
	end
	SendMessage(event, format(L["Achievement"], table.concat(players, L["Space"]), GetAchievementLink(achievementID)))
end

local function achievementReady(id, achievement)
	if (achievement.area and achievement.guild) then
		local playerGuild = GetGuildInfo("player")
		for i = getn(achievement.area), 1, -1 do
			local player = achievement.area[i].name
			if (UnitExists(player) and playerGuild and playerGuild == GetGuildInfo(player)) then
				tinsert(achievement.guild, tremove(achievement.area, i))
			end
		end
	end
	if (achievement.area and getn(achievement.area) > 0) then
		SendAchievement("CHAT_MSG_ACHIEVEMENT", id, achievement.area)
	end
	if (achievement.guild and getn(achievement.guild) > 0) then
		SendAchievement("CHAT_MSG_GUILD_ACHIEVEMENT", id, achievement.guild)
	end
end

local function talentspecReady(attribute, spells)
	if (not spells) then return end
	for k in pairs(alreadySent) do alreadySent[k] = nil end
	for i = getn(spells), 1, -1 do
		if (alreadySent[spells[i]]) then
			tremove(spells, i)
		else
			alreadySent[spells[i]] = true
		end
	end
	if (getn(spells) > 1) then
		sort(spells, function(a, b) return a < b end)
	end
	for i = 1, getn(spells) do
		spells[i] = GetSpellLink(spells[i])
	end
	if (attribute == "Learn") then
		SendMessage("CHAT_MSG_SYSTEM", format(L["LearnSpell"], table.concat(spells, "")))
	end
	if (attribute == "Unlearn") then
		SendMessage("CHAT_MSG_SYSTEM", format(L["UnlearnSpell"], table.concat(spells, "")))
	end
end

local function ChatFrames_OnUpdate(self, elapsed)
	local found
	for id, resetAt in pairs(resetTimer) do
		if (resetAt <= GetTime()) then
			SendMessage("CHAT_MSG_LOOT", format(LOOT_ITEM_CREATED_SELF_MULTIPLE, (select(2, GetItemInfo(id))), totalCreated[id]))
			totalCreated[id] = nil
			resetTimer[id] = nil
		end
		found = true
	end
	for id, spell in pairs(spellList) do
		if (spell.timeout <= GetTime()) then
			talentspecReady(id, spell)
			spellList[id] = nil
		end
		found = true
	end
	for id, achievement in pairs(achievements) do
		if (achievement.timeout <= GetTime()) then
			achievementReady(id, achievement)
			achievements[id] = nil
		end
		found = true
	end
	if (not found) then
		self:SetScript("OnUpdate", nil)
	end
end

local function queueCraftMessage(craft, itemID, itemQuantity)
	if (prevCraft and prevCraft ~= craft) then return end
	prevCraft = craft
	local Delay
	if (select(3, GetNetStats()) > select(4, GetNetStats())) then
		Delay = select(3, GetNetStats()) / 250 + 0.5
	else
		Delay = select(4, GetNetStats()) / 250 + 0.5
	end
	if (Delay > 3) then Delay = 3 end
	totalCreated[itemID] = (totalCreated[itemID] or 0) + (itemQuantity or 1)
	resetTimer[itemID] = GetTime() + craftList[itemID] + Delay
	ChatFilter:SetScript("OnUpdate", ChatFrames_OnUpdate)
end

local function queueTalentSpecSpam(attribute, spellID)
	spellList[attribute] = spellList[attribute] or {timeout = GetTime() + 0.5}
	tinsert(spellList[attribute], spellID)
	ChatFilter:SetScript("OnUpdate", ChatFrames_OnUpdate)
end

local function queueAchievementSpam(event, achievementID, playerdata)
	achievements[achievementID] = achievements[achievementID] or {timeout = GetTime() + 0.5}
	achievements[achievementID][event] = achievements[achievementID][event] or {}
	tinsert(achievements[achievementID][event], playerdata)
	ChatFilter:SetScript("OnUpdate", ChatFrames_OnUpdate)
end

local function ignoreMore(player)
	if (not player) then return end
	local ignore = nil
	if GetNumIgnores() >= 50 then
		for i = 1, GetNumIgnores() do
			local name = GetIgnoreName(i)
			if (player == name) then
				ignore = true
				break
			end
		end
		if (not ignore) then
			_ShieldTable[player] = true
			SendMessage("CHAT_MSG_SYSTEM", format(ERR_IGNORE_ADDED_S, player))
		end
	end
end

if (Config.IgnoreMore) then
	hooksecurefunc("AddIgnore", ignoreMore)
	hooksecurefunc("AddOrDelIgnore", ignoreMore)
end
if (Config.MergeManufacturing) then
	hooksecurefunc("DoTradeSkill", function(index, quantity)
			local itemID = strmatch(GetTradeSkillItemLink(index), "item:(%d+)")
			if (itemID) then
				craftQuantity = quantity
				craftItemID = tonumber(itemID)
				prevCraft = nil
			end
	end)
	ChatFilter:RegisterEvent("TRADE_SKILL_UPDATE")
end

ChatFilter:RegisterEvent("ADDON_LOADED")
ChatFilter:RegisterEvent("PLAYER_ENTERING_WORLD")
ChatFilter:RegisterEvent("VARIABLES_LOADED")

ChatFilter:SetScript("OnEvent", function(self, event)
	if (not Config.Enabled) then return end
	if (event == "ADDON_LOADED") then
		if (Config.noprofanityFilter) then
			SetCVar("profanityFilter", 0)
		end
		if (Config.nowhisperSticky) then
			ChatTypeInfo.WHISPER.sticky = 0
			ChatTypeInfo.BN_WHISPER.sticky = 0
		end
		if (Config.nojoinleaveChannel) then
			for i = 1, NUM_CHAT_WINDOWS do
				ChatFrames = _G["ChatFrame"..i]
				ChatFrame_RemoveMessageGroup(ChatFrames, "CHANNEL")
			end
		end
		if (Config.noaltArrowkey) then
			for i = 1, NUM_CHAT_WINDOWS do
				ChatFrames = _G["ChatFrame"..i.."EditBox"]
				ChatFrames:SetAltArrowKeyMode(false)
			end
		end
		if (Config.noprofanityFilter) then
			SetCVar("profanityFilter", 0)
		end
		AddonLoading = true
	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (Config.FilterByLevel) then
			for k, v in pairs(Config.ShieldPlayers) do
				_ShieldTable[v] = true
			end
			local AddonLoadedTime = GetTime()
			ChatFilterLv:SetScript("OnUpdate", function(self, elapsed)
				if (GetTime() - AddonLoadedTime > 3) then
					AddonLoading = nil
					if (not (AddonLoading or adding)) then
						self:SetScript("OnUpdate", nil)
					end
				end
			end)
		end
	elseif (event == "TRADE_SKILL_UPDATE") then
		if (GetTradeSkillLine() and not IsTradeSkillLinked()) then
			for i = 1, GetNumTradeSkills() do
				if (GetTradeSkillItemLink(i) and GetTradeSkillRecipeLink(i)) then
					local itemID = strmatch(GetTradeSkillItemLink(i), "item:(%d+)")
					local enchantID = strmatch(GetTradeSkillRecipeLink(i), "enchant:(%d+)")
					if (itemID and enchantID) then
						craftList[tonumber(itemID)] = select(7, GetSpellInfo(enchantID)) / 1000
					end
				end
			end
		end
	elseif (event == "VARIABLES_LOADED") then
		if not ChatFilter_AddedFriendsTable then 
			ChatFilter_AddedFriendsTable = {}
		end

		-- 清理 ChatFilter_AddedFriendsTable 里残留的临时好友
		for k in pairs(ChatFilter_AddedFriendsTable) do
			print(GetTime(), "清理残留的临时好友",k)
			RemoveFriend(k)
			ChatFilter_AddedFriendsTable[k] = nil
		end

		ChatFilter_AddedFriendsTable = AddedTable
	end
end)

local function ChatFilter_Rubbish(self, event, msg, player, _, _, _, flag, _, _, channel, _, lineId, guid)
	if (not Config.Enabled) then return end
	if (not (guid or player)) then return end
	if (not Config.ScanOurself and UnitIsUnit(player,"player")) then return end
	if (lineId ~= prevLineId) then
		if (flag == "GM" or flag == "DEV") then return end
		if (event == "CHAT_MSG_WHISPER") then
			if (IsAddOnLoaded("WIM") or IsAddOnLoaded("Cellular")) then
				local f = self:GetName() or "?"
				if (f == "WIM_workerFrame" or f == "WIM3_HistoryChatFrame" or f == "Cellular") then
					return
				end
			end
			if (Config.FilterRaidAlert and msg:find(L["RaidAlert"])) then return true end
			if (GetFriendInfo(player)) then return end
			for i = 1, select(2, BNGetNumFriends()) do
				local toon = BNGetNumFriendToons(i)
				for j = 1, toon do
					local _, rName, rGame = BNGetFriendToonInfo(i, j)
					if (rName == player and rGame == "WoW") then return end
				end
			end
		end
		local Time, Name, Server = GetTime()
		if (guid and tonumber(guid)) then
			if (tonumber(guid:sub(-12, -9), 16) > 0) then return end
			Name = select(6, GetPlayerInfoByGUID(guid))
			Server = select(7, GetPlayerInfoByGUID(guid))
			player = Name
			if (Server and strlen(Server) > 0) then
				player = Name.."-"..Server
			end
		end
		if (ShieldTable[1] and Time - ShieldTable[1].Time  > Config.IgnoreAdTimes * 60) then
			_ShieldTable[ShieldTable[1].Name] = nil
			tremove(ShieldTable, 1)
		end
		if (LevelTable[1] and Time - LevelTable[1].Time > 30 * 60) then
			_LevelTable[LevelTable[1].Name] = nil
			tremove(LevelTable, 1)
		end
		if (_ShieldTable[player]) then
			if (Config.Debug and event == Config.Debug) then
				if (_ShieldTable[player] > 0) then
					print("|cFF33FF99ChatFilter:|r [[''"..player.."'']]的发言被过滤，过滤原因：屏蔽小号，玩家等级：".._ShieldTable[player])
				else
					print("|cFF33FF99ChatFilter:|r [[''"..player.."'']]的发言被过滤，过滤原因：发广告被屏蔽。")
				end
			end
			return true
		end
		if (Config.FilterRepeat or Config.FilterAdvertising) then
			orgmsg = msg
			msg = msg:lower()
			local Symbols = {"%s","%p","，","。","、","？","！","：","；","’","‘","“","”","【","】","《","》","（","）","—","…"}
			for i = 1, getn(Symbols) do
				msg = gsub(msg, Symbols[i], "")
			end
		end
		for i = 1, getn(Config.WhiteList) do
			if (msg:find(Config.WhiteList[i]) or orgmsg:find(Config.WhiteList[i])) then
				return
			end
		end
		for i = 1, getn(Config.BlackList) do
			if (msg:find(Config.BlackList[i]) or orgmsg:find(Config.BlackList[i])) then
				if (Config.Debug and event == Config.Debug) then
					print("|cFF33FF99ChatFilter:|r [[''"..player.."'']]的发言被过滤，过滤原因：消息中有黑名单词汇。")
				end
				return true
			end
		end
		local Msg_Data = {Name = player, Msg = msg, Time = Time}
		local Player_Data = {Name = player, Time = Time}
		local matchs = 0
		if (Config.FilterRepeat or Config.FilterMultiLine) then
			local lines, AllowLines, RepeatInterval, RepeatAlike = 1, 10, 10, 95
			if (event == "CHAT_MSG_CHANNEL") then
				RepeatInterval, RepeatAlike, AllowLines = Config.RepeatInterval, Config.RepeatAlike, Config.AllowLines
			end
			for i = getn(CacheTable), 1, -1 do
				local cache = CacheTable[i]
				local interval = Time - cache.Time
				if (interval > Config.RepeatInterval) then
					tremove(CacheTable, i)
				else
					if (Config.FilterMultiLine and cache.Name == player) then
						if (interval < 0.400) then
							lines = lines + 1
						end
						if (lines >= AllowLines) then
							if (Config.Debug and event == Config.Debug) then
								print("|cFF33FF99ChatFilter:|r [[''"..player.."'']]的发言被过滤，过滤原因：多行刷屏，数量："..lines.."行，本次消息为："..msg)
							end
							return true
						end
					end
					if (Config.FilterRepeat and interval < RepeatInterval and (cache.Name == player or (event == "CHAT_MSG_CHANNEL" and strlen(msg) > 20))) then
						if (cache.Msg == msg) then
							if (Config.Debug and event == Config.Debug) then
								print("|cFF33FF99ChatFilter:|r [[''"..player.."'']]的发言被过滤，过滤原因：重复消息刷屏，两次信息间隔："..interval.."秒，本次消息为："..msg.."，上次消息为："..cache.Msg)
							end
							return true
						end
						if (Config.RepeatAlike and Config.RepeatAlike < 100) then
							local count, bigs, smalls = 0
							if (strlen(msg) > strlen(cache.Msg)) then
								bigs = msg
								smalls = cache.Msg
							else
								bigs = cache.Msg
								smalls = msg
							end
							for i = 1, strlen(smalls) do
								if (strfind(bigs, strsub(smalls, i, i + 1), 1, true)) then
									count = count + 1
								end
							end
							if (count / strlen(bigs) * 100 > RepeatAlike) then
								if (Config.Debug and event == Config.Debug) then
									print("|cFF33FF99ChatFilter:|r [[''"..player.."'']]的发言被过滤，过滤原因：重复消息刷屏，两次信息间隔："..interval.."秒，本次消息为："..msg.."，上次消息为："..cache.Msg)
								end
								return true
							end
						end
					end
				end
			end
		end
		if (Config.FilterAdvertising) then
			for i = 1, getn(Config.SafeWords) do
				if (msg:find(Config.SafeWords[i])) then
					matchs = matchs - 1
				end
			end
			for i = 1, getn(Config.DangerWords) do
				local _, Pos = _, 0
				if (strfind(msg, Config.DangerWords[i], Pos + 1)) then
					matchs = matchs + 1
					_, Pos = strfind(msg, Config.DangerWords[i], Pos +1)
					if (strfind(msg, Config.DangerWords[i], Pos + 1)) then
						matchs = matchs + 1
						_, Pos = strfind(msg, Config.DangerWords[i], Pos +1)
						if (strfind(msg, Config.DangerWords[i], Pos + 1)) then
							matchs = matchs + 1
						end
					end
				end
			end
			if (Config.AllowMatchs < 3 and (not CanComplainChat(lineId) or UnitIsInMyGuild(player))) then
				matchs = matchs - 1
			end
			if (matchs > Config.AllowMatchs) then
				if (Config.Debug and event == Config.Debug) then
					print("|cFF33FF99ChatFilter:|r [[''"..player.."'']]的发言被过滤，过滤原因：消息中含有广告，广告数量："..matchs.."个，本次消息为："..msg)
				end
				tinsert(ShieldTable, Player_Data)
				_ShieldTable[player] = 0
				return true
			end
		end
		if (Config.FilterByLevel and (event == "CHAT_MSG_WHISPER" or (not Config.OnlyOnWhisper and event ~= "CHAT_MSG_WHISPER"))) then
			local AllowLevel, added = Config.AllowLevel, nil
			if (Server and strlen(Server) > 0) then
				if (event == "CHAT_MSG_GUILD" or channel == L["Channel"]) then
					ServerTable[Server] = true
				else
					if (not ServerTable[Server]) then
						added = true
					end
				end
			end
			if (guid and tonumber(guid) and select(2, GetPlayerInfoByGUID(guid)) == DEATHKNIGHT) then
				if (Config.AllowLevel <= 10) then
					AllowLevel = 55 + Config.AllowLevel / 2
				elseif (Config.AllowLevel <= 60) then
					AllowLevel = 60
				end
			end
			if (_LevelTable[player]) then
				added = true
				if (_LevelTable[player] <= 80) then
					matchs = matchs + 1
				end
			end
			if (matchs > Config.AllowMatchs) then
				if (Config.Debug and event == Config.Debug) then
					print("|cFF33FF99ChatFilter:|r [[''"..player.."'']]的发言被过滤，过滤原因：消息中含有广告且不是满级，广告数量："..(matchs - 1).."个，玩家等级：".._LevelTable[player].."级，本次消息为："..msg)
				end
				tinsert(ShieldTable, Player_Data)
				_ShieldTable[player] = 0
				return true
			end
			--[[
			if (CanComplainChat(lineId) and not (added or adding or UnitIsInMyGuild(player))) then
				if (not addedtime or Time - addedtime > Latency) then
					--adding = true
					--addedplayer = player
					--AddFriend(addedplayer)
					--AddedTable[addedplayer] = true
					--ChatFilterLv:RegisterEvent("FRIENDLIST_UPDATE")
					--FriendsFrame:UnregisterEvent("FRIENDLIST_UPDATE")
					--if (IsAddOnLoaded("Tukui")) then
					--	TukuiStatFriends:UnregisterEvent("FRIENDLIST_UPDATE")
					--end
				end
				ChatFilterLv:SetScript("OnEvent", function(self, event)
					if (event == "FRIENDLIST_UPDATE") then
						if (not GetFriendInfo(addedplayer)) then
							ShowFriends()
						else
							addedtime = GetTime()
							Latency = addedtime - Time
							local _, playerlevel = GetFriendInfo(addedplayer)
							if (playerlevel >= AllowLevel) then
								tinsert(LevelTable, {Name = addedplayer, Time = addedtime})
								_LevelTable[addedplayer] = playerlevel
							elseif (playerlevel > 0) then
								tinsert(ShieldTable, {Name = addedplayer, Time = addedtime})
								_ShieldTable[addedplayer] = playerlevel
							end
							for k in pairs(AddedTable) do
								RemoveFriend(k)
								AddedTable[k] = nil
							end
							adding = nil
						end
						if (not adding) then
							if (IsAddOnLoaded("Tukui")) then
								TukuiStatFriends:RegisterEvent("FRIENDLIST_UPDATE")
							end
							FriendsFrame:RegisterEvent("FRIENDLIST_UPDATE")
							ChatFilterLv:UnregisterEvent("FRIENDLIST_UPDATE")
						end
					end
				end)
			end
			]]
		end
		tinsert(CacheTable, Msg_Data)
		prevLineId = lineId
	end
end

local function ChatFilter_Achievement(self, event, msg, player, _, _, _, _, _, _, _, _, _, guid)
	if (not Config.Enabled) then return end
	if (Config.MergeAchievement) then
		local achievementID = strmatch(msg, "achievement:(%d+)")
		if (not achievementID) then return end
		achievementID = tonumber(achievementID)
		local playerdata = {name = player, guid = guid}
		local categoryID = GetAchievementCategory(achievementID)
		if (spamCategories[categoryID] or spamCategories[select(2, GetCategoryInfo(categoryID))] or specialFilters[achievementID]) then
			queueAchievementSpam((event == "CHAT_MSG_GUILD_ACHIEVEMENT" and "guild" or "area"), achievementID, playerdata)
			return true
		end
	end
end

local function ChatFilter_SystemMSG(self, event, msg)
	if (not Config.Enabled) then return end
	if (Config.MergeTalentSpec) then
		local learnID = strmatch(msg, learnspellmsg) or strmatch(msg, learnabilitymsg) or strmatch(msg, learnpassivemsg)
		local unlearnID = strmatch(msg, unlearnspellmsg)
		if (learnID) then
			learnID = tonumber(strmatch(learnID, "spell:(%d+)"))
			queueTalentSpecSpam("Learn", learnID)
			return true
		elseif (unlearnID) then
			unlearnID = tonumber(strmatch(unlearnID, "spell:(%d+)"))
			queueTalentSpecSpam("Unlearn", unlearnID)
			return true
		end
		if (Config.FilterPetTalentSpec and (msg:find(petlearnspellmsg) or msg:find(petlearnabilitymsg) or msg:find(petunlearnspellmsg))) then
			return true
		end
	end
	if (Config.FilterDrunkMSG and not msg:find(L["You"])) then
		for i = 1, getn(drunkmsg) do
			if (msg:find(drunkmsg[i])) then return true end
		end
	end
	if (Config.FilterDuelMSG and (not msg:find(GetUnitName("player"))) and (msg:find(duelwinmsg) or msg:find(duellosemsg))) then return true end
	if (Config.FilterAuctionMSG and (msg:find(auctionstartedmsg) or msg:find(auctionremovedmsg))) then return true end
	if (Config.IgnoreMore and msg:find(ignorelistfullmsg)) then return true end
	if (Config.FilterByLevel) then
		if (AddonLoading) then
			if (msg:find(friendaddedmsg)) then
				local name = gsub(msg, gsub(friendaddedmsg, "%p", ""), "")
				AddedTable[name] = true
				return true
			end
			if (msg:find(friendnotfoundmsg)) then return true end
		end
		if (adding and msg:find(friendnotfoundmsg)) then
			ChatFilterLv:SetScript("OnUpdate", function(self, elapsed)
				adding = nil
				if (not (AddonLoading or adding)) then
					self:SetScript("OnUpdate", nil)
				end
			end)
			return true
		end
		if (msg:find(friendlistfullmsg)) then
			Config.FilterByLevel = nil
			print("|cFF33FF99ChatFilter:|r", L["FriendlistFull"])
		end
		if (not addedplayer) then return end
		msg = gsub(msg, "%-", "")
		addedplayer = gsub(addedplayer, "%-", "")
		if (msg:find(addedplayer) and (msg:find(friendaddedmsg) or msg:find(friendalreadymsg))) then return true end
	end
end

local function ChatFilter_CreateMSG(self, event, msg)
	if (not Config.Enabled) then return end
	if (Config.MergeManufacturing) then
		local craft = self
		local itemID, itemQuantity = strmatch(msg, createmultimsg)
		if (not itemID and not itemQuantity) then
			itemID = strmatch(msg, createmsg)
		end
		if (not itemID) then return end
		itemID = tonumber(strmatch(itemID, "item:(%d+)"))
		itemQuantity = tonumber(itemQuantity)
		if (itemID and craftList[itemID] and craftItemID == itemID and craftQuantity > 1) then
			queueCraftMessage(craft, itemID, itemQuantity)
			return true
		end
	end
end

local function ChatFilter_ReportMSG(self, event, msg)
	if (not Config.Enabled) then return end
	if (Config.FilterRaidAlert and msg:find(L["RaidAlert"])) then return true end
	if (Config.FilterQuestReport and msg:find(L["QuestReport"])) then return true end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChatFilter_Rubbish)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChatFilter_Rubbish)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChatFilter_Rubbish)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChatFilter_Rubbish)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChatFilter_Rubbish)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", ChatFilter_Rubbish)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatFilter_ReportMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilter_ReportMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChatFilter_ReportMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilter_ReportMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", ChatFilter_ReportMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChatFilter_ReportMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChatFilter_ReportMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", ChatFilter_CreateMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ChatFilter_SystemMSG)
ChatFrame_AddMessageEventFilter("CHAT_MSG_ACHIEVEMENT", ChatFilter_Achievement)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", ChatFilter_Achievement)
-----------------------------------------------------------------------
-- SlashCommand
-----------------------------------------------------------------------
SLASH_CHATFILTER1 = "/chatfilter"
SLASH_CHATFILTER2 = "/cf"

SlashCmdList["CHATFILTER"] = function(msg)
	local cmd = msg:lower()
	if (cmd == "on") then
		Config.Enabled = true
		print("ChatFilter has been enabled.")
	elseif (cmd == "off") then
		Config.Enabled = nil
		print("ChatFilter has been disabled.")
	elseif (cmd == "me") then
		if (Config.ScanOurself) then
			Config.ScanOurself = nil
			print("ScanOurself has been disabled.")
		else
			Config.ScanOurself = true
			print("ScanOurself has been enabled.")
		end
	elseif (cmd == "ad") then
		if (Config.FilterAdvertising) then
			Config.FilterAdvertising = nil
			print("FilterAdvertising has been disabled.")
		else
			Config.FilterAdvertising = true
			print("FilterAdvertising has been enabled.")
		end
	elseif (cmd == "mult") then
		if (Config.FilterMultiLine) then
			Config.FilterMultiLine = nil
			print("FilterMultiLine has been disabled.")
		else
			Config.FilterMultiLine = true
			print("FilterMultiLine has been enabled.")
		end
	elseif (cmd == "repeat") then
		if (Config.FilterRepeat) then
			Config.FilterRepeat = nil
			print("FilterRepeat has been disabled.")
		else
			Config.FilterRepeat = true
			print("FilterRepeat has been enabled.")
		end
	elseif (cmd == "level") then
		if (Config.FilterByLevel) then
			Config.FilterByLevel = nil
			print("FilterByLevel has been disabled.")
		else
			Config.FilterByLevel = true
			print("FilterByLevel has been enabled.")
		end
	elseif (cmd == "achieve") then
		if (Config.MergeAchievement) then
			Config.MergeAchievement = nil
			print("MergeAchievement has been disabled.")
		else
			Config.MergeAchievement = true
			print("MergeAchievement has been enabled.")
		end
	elseif (cmd == "talent") then
		if (Config.MergeTalentSpec) then
			Config.MergeTalentSpec = nil
			print("MergeTalentSpec has been disabled.")
		else
			Config.MergeTalentSpec = true
			print("MergeTalentSpec has been enabled.")
		end
	elseif (cmd == "creat") then
		if (Config.MergeManufacturing) then
			Config.MergeManufacturing = nil
			print("MergeManufacturing has been disabled.")
		else
			Config.MergeManufacturing = true
			print("MergeManufacturing has been enabled.")
		end
	elseif (cmd == "auction") then
		if (Config.FilterAuctionMSG) then
			Config.FilterAuctionMSG = nil
			print("FilterAuctionMSG has been disabled.")
		else
			Config.FilterAuctionMSG = true
			print("FilterAuctionMSG has been enabled.")
		end
	elseif (cmd == "duel") then
		if (Config.FilterDuelMSG) then
			Config.FilterDuelMSG = nil
			print("FilterDuelMSG has been disabled.")
		else
			Config.FilterDuelMSG = true
			print("FilterDuelMSG has been enabled.")
		end
	elseif (cmd == "drunk") then
		if (Config.FilterDrunkMSG) then
			Config.FilterDrunkMSG = nil
			print("FilterDrunkMSG has been disabled.")
		else
			Config.FilterDrunkMSG = true
			print("FilterDrunkMSG has been enabled.")
		end
	elseif cmd == "raidalert" then
		if (Config.FilterRaidAlert) then
			Config.FilterRaidAlert = nil
			print("FilterRaidAlert has been disabled.")
		else
			Config.FilterRaidAlert = true
			print("FilterRaidAlert has been enabled.")
		end
	elseif cmd == "questreport" then
		if (Config.FilterQuestReport) then
			Config.FilterQuestReport = nil
			print("FilterRaidAlert has been disabled.")
		else
			Config.FilterQuestReport = true
			print("FilterQuestReport has been enabled.")
		end
	elseif (cmd == "cache") then
		print("缓存信息："..getn(CacheTable).."条 -- 缓存等级："..getn(LevelTable).."个 -- 屏蔽人物："..getn(Config.ShieldPlayers) + getn(ShieldTable).."个")
	elseif (strfind(cmd, "unignore") == 1) then
		local player = gsub(cmd, "unignore", "")
		player = gsub(player, "%s", "")
		if (_ShieldTable[player]) then
			_ShieldTable[player] = nil
			SendMessage("CHAT_MSG_SYSTEM", format(ERR_IGNORE_REMOVED_S, player))
		else
			SendMessage("CHAT_MSG_SYSTEM", ERR_IGNORE_NOT_FOUND)
		end
	else
		print("/cf [ on/off | ad | mult | repeat | level | achieve | talent | creat ]")
		print("/cf [ raidalert | questreport | duel | drunk | auction | unignore ]")
	end
end