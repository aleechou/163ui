-- Ace3 init
local ChannelClean = LibStub("AceAddon-3.0"):NewAddon("ChannelClean", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
_G.ChannelClean = ChannelClean
local L = LibStub("AceLocale-3.0"):GetLocale("ChannelClean")
local config = LibStub("AceConfig-3.0")
local dialog = LibStub("AceConfigDialog-3.0")
local db

local debug = function() end
if(DEBUG_MODE) then
    local strjoin = string.join
    local debugf = tekDebug and tekDebug:GetFrame('ChannelClean')
    if(debugf) then
        debug = function(...) return debugf:AddMessage(strjoin(', ', tostringall(...))) end
    end

--     local f = CreateFrame'Frame'
--     f:RegisterEvent'CHAT_MSG_CHANNEL'
--     f:SetScript('OnEvent', function(...)
--         return debug(...)
--     end)
end

local defaults = {
	profile = {
		firstTime = true,
		bypassSelf = true,
		notice = false,
		noticeInterval = 20,
		cleanInterval = 300,

		triggerMode = "session",
		filter = {
			message = {},
			player = {},
			trigger = {},
		},
		filterMonitor = {
		},

		flushControl = true,
		flushMonitorSameMessageOnly = true,
		flushBanTime = 10,
		flushSimilar = false,
		flushSimilarScore = 75,
		flushMonitor = {
		}
	}
}

local chatMsgEvents = {
    CHAT_MSG_CHANNEL = true,
    CHAT_MSG_SAY = true,
    CHAT_MSG_WHISPER = true,
    CHAT_MSG_YELL = true,
    CHAT_MSG_GUILD = false,
    CHAT_MSG_PARTY = false,
    CHAT_MSG_RAID = false,
    CHAT_MSG_SYSTEM = false,
    -- CHAT_MSG_BATTLEGROUND = false,
    -- CHAT_MSG_BATTLEGROUND_LEADER = false,
    -- CHAT_MSG_RAID_LEADER = false
}

do
    for e, b in next, chatMsgEvents do
        defaults.profile.filterMonitor[e] = b
        defaults.profile.flushMonitor[e] = b
    end
    defaults.profile.flushMonitor.CHAT_MSG_WHISPER = false
end

local lastNotice = {}
local speaker = {}
local trigger_temp = {}

local player_name = UnitName'player'

local function trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end
local function get(info)
	local k = info[#info]
	return db[k]
end
local function set(info,value)
	local k = info[#info]
	db[k] = value
end

function ChannelClean:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("ChannelCleanDB", defaults, "Default")
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	db = self.db.profile

    db.filterMonitor.CHAT_MSG_BATTLEGROUND = nil
    db.filterMonitor.CHAT_MSG_BATTLEGROUND_LEADER = nil
    db.flushMonitor.CHAT_MSG_BATTLEGROUND = nil
    db.flushMonitor.CHAT_MSG_BATTLEGROUND_LEADER = nil

    self.friendsList = {}
    self.guildList = {}
    self.groupList = {}

	-- load default rules
	self:LoadDefaultRules()

	-- remove dupe rules
	for k,v in pairs(db.filter) do
		db.filter[k] = self:RemoveDupe(v)
	end
	local channelList = {
		"CHAT_MSG_CHANNEL",
		"CHAT_MSG_SAY",
		"CHAT_MSG_WHISPER",
		"CHAT_MSG_YELL",
		"CHAT_MSG_GUILD",
		"CHAT_MSG_PARTY",
		"CHAT_MSG_RAID",
		"CHAT_MSG_SYSTEM",
		-- "CHAT_MSG_BATTLEGROUND",
		-- "CHAT_MSG_BATTLEGROUND_LEADER",
		-- "CHAT_MSG_RAID_LEADER",
	}
	local channelLocalized = {}
	for _,v in ipairs(channelList) do
		channelLocalized[v] = L[v]
	end

	local options = {
		type = "group",
		name = "ChannelClean",
		args = {
			FlushControl = {
				type = "group",
				name = L["Flush Control"],
				args = {
					flushControl = {
						type = "toggle",
						name = L["Enable anti flush control"],
						desc = L["Enable anti flush control"],
						order = 10,
						get = get,
						set = set,
					},
					flushMonitorSameMessageOnly = {
						type = "toggle",
						name = L["Only anti same message"],
						desc = L["Only anti same message"],
						order = 20,
						get = get,
						set = set,
					},
					flushSimilar = {
						type = "toggle",
						name = L["Only anti similar message"],
						desc = L["Only anti similar message"],
						order = 30,
						get = get,
						set = set,
					},
					flushBanTime = {
						type = "range",
						name = L["Anti flush ban time"],
						desc = L["Anti flush ban time"],
						min = 1,
						max = 60,
						step = 1,
						order = 100,
						get = get,
						set = set,
					},
					flushSimilarScore = {
						type = "range",
						name = L["Message similar score (percent)"],
						desc = L["Message similar score (percent)"],
						min = 1,
						max = 99,
						step = 1,
						order = 110,
						get = get,
						set = set,
					},
					flushMonitor = {
						type = 'multiselect',
						name = L["Flush control monitor"],
						get = function(_, key)
							return db.flushMonitor[key]
						end,
						set = function(_, key, value)
							db.flushMonitor[key] = value
						end,
						values = channelLocalized,
						order = 200,
					}
				},
			},
			FilterAndNotice = {
				type = "group",
				name = L["Filter And Notice Options"],
				get = get,
				set = set,
				args = {
					notice = {
						type = "toggle",
						name = L["Enable notice"],
						desc = L["Enable notice"],
						order = 10,
					},
					noticeInterval = {
						type = "range",
						name = L["Notice interval"],
						desc = L["Notice interval"],
						min = 1,
						max = 60,
						step = 1,
						order = 20,
					},
					bypassSelf = {
						type = "toggle",
						name = L["Bypass self"],
						desc = L["Bypass self"],
						order = 30,
					},
					filterMonitor = {
						type = 'multiselect',
						name = L["Filter Monitor"],
						get = function(_, key)
							return db.filterMonitor[key]
						end,
						set = function(_, key, value)
							db.filterMonitor[key] = value
						end,
						values = channelLocalized,
						order = 100,
					}
				},
			},
			filterMessage = {
				type = "group",
				name = L["Message Filter"],
				args = {
					Add = {
						type = 'input',
						name = L["Add Rule"],
						get = function()
							return ""
						end,
						set = function(_, value)
							tinsert(db.filter.message, value)
						end,
						order = 10,
					},
					Remove = {
						type = 'multiselect',
						name = L['Delete Rule'],
						get = function()
							return false
						end,
						set = function(_, key)
							tremove(db.filter.message, key)
						end,
						values = function() return db.filter.message end,
						order = 20,
					}
				},
			},
			filterPlayer = {
				type = "group",
				name = L["Player Filter"],
				args = {
					Add = {
						type = 'input',
						name = L["Add Rule"],
						get = function()
							return ""
						end,
						set = function(_, value)
							tinsert(db.filter.player, value)
						end,
						order = 10,
					},
					Remove = {
						type = 'multiselect',
						name = L['Delete Rule'],
						get = function()
							return false
						end,
						set = function(_, key)
							tremove(db.filter.player, key)
						end,
						values = function() return db.filter.player end,
						order = 20,
					}
				},
			},
			filterTrigger = {
				type = "group",
				name = L["Trigger Filter"],
				desc = L["Trigger Filter Desc"],
				args = {
                    LoadDefault = {
                        width = 'full',
                        confirm = true,
                        type = 'execute',
                        name = L["Load Default Rules"],
                        desc = L["Load Default Rules Desc"],
                        order = 5,
                        func = function()
                            db.firstTime = true
                            return ChannelClean:LoadDefaultRules()
                        end,
                    },
					Add = {
						type = 'input',
						name = L["Add Rule"],
						get = function()
							return ""
						end,
						set = function(_, value)
							tinsert(db.filter.trigger, value)
						end,
						order = 10,
					},
					Remove = {
						type = 'multiselect',
						name = L['Delete Rule'],
						get = function()
							return false
						end,
						set = function(_, key)
							tremove(db.filter.trigger, key)
						end,
						values = function() return db.filter.trigger end,
						order = 20,
					}
				},
			},
		},
	}

	config:RegisterOptionsTable("ChannelClean", {
		name = "ChannelClean",
		type = "group",
		args = {
			resetdb = {
				type = "execute",
				confirm = true,
				confirmText = L["ResetDB_Confirm"],
				func = function()
					self.db:ResetDB("Default")
					--self:Print(L["All settings are reset to default value."])
				end,
				name = L["Reset to Default Profile"],
				order = 10,
			},
			Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db),
		},
	})
	--[[
	dialog:SetDefaultSize("ChannelClean", 600, 400)
	dialog:AddToBlizOptions("ChannelClean", L["ChannelClean"])

	config:RegisterOptionsTable("ChannelClean-FlushControl", options.args.FlushControl)
	dialog:AddToBlizOptions("ChannelClean-FlushControl", options.args.FlushControl.name, L["ChannelClean"])

	config:RegisterOptionsTable("ChannelClean-FilterAndNotice", options.args.FilterAndNotice)
	dialog:AddToBlizOptions("ChannelClean-FilterAndNotice", options.args.FilterAndNotice.name, L["ChannelClean"])

	config:RegisterOptionsTable("ChannelClean-filterMessage", options.args.filterMessage)
	dialog:AddToBlizOptions("ChannelClean-filterMessage", options.args.filterMessage.name, L["ChannelClean"])

	config:RegisterOptionsTable("ChannelClean-filterPlayer", options.args.filterPlayer)
	dialog:AddToBlizOptions("ChannelClean-filterPlayer", options.args.filterPlayer.name, L["ChannelClean"])

	config:RegisterOptionsTable("ChannelClean-filterTrigger", options.args.filterTrigger)
	dialog:AddToBlizOptions("ChannelClean-filterTrigger", options.args.filterTrigger.name, L["ChannelClean"])
	]]
	config:RegisterOptionsTable(L["ChannelClean"], options);
end

local cleanTempDBTimer
function ChannelClean:OnEnable()
	-- self:RawHook("ChatFrame_OnEvent", true)
	--add schedule to clean temp db
	cleanTempDBTimer = self:ScheduleRepeatingTimer("CleanTempDB", db.cleanInterval)

    self:BuildGroupList()
    self:BuildFriendList()
    self:BuildGuildList()
    self:RequestFriendGuild()

    self:RegisterEvent('GROUP_ROSTER_UPDATE', 'BuildGroupList')
    self:RegisterEvent('FRIENDLIST_UPDATE', 'BuildFriendList')
    self:RegisterEvent('GUILD_ROSTER_UPDATE', 'BuildGuildList')
    self:RegisterEvent('PLAYER_ENTERING_WORLD', 'RequestFriendGuild')

    for event in next, chatMsgEvents do
        ChatFrame_AddMessageEventFilter(event, self.ChatEventFilter)
    end
end

function ChannelClean:OnDisable()
	self:CleanTempDB()
    if(cleanTempDBTimer) then
        self:CancelTimer(cleanTempDBTimer)
    end

    self:UnregisterEvent('GROUP_ROSTER_UPDATE', 'BuildGroupList')
    self:UnregisterEvent('FRIENDLIST_UPDATE', 'BuildFriendList')
    self:UnregisterEvent('GUILD_ROSTER_UPDATE', 'BuildGuildList')
    self:UnregisterEvent('PLAYER_ENTERING_WORLD', 'RequestFriendGuild')

    for event in next, chatMsgEvents do
        ChatFrame_RemoveMessageEventFilter(event, self.ChatEventFilter)
    end
end

function ChannelClean:RequestFriendGuild()
    GuildRoster()
    ShowFriends()
end

function ChannelClean:OnProfileChanged(event, database, newProfileKey)
	db = database.profile
	self:LoadDefaultRules()
end

function ChannelClean:BuildFriendList()
    local list = self.friendsList
    wipe(list)
    local numFriends = GetNumFriends()
    local numBNFriends = BNGetNumFriends()

    for i = 1, numFriends do
        local name = GetFriendInfo(i)
        if(name) then
            list[name] = true
        end
    end

    for i = 1, numBNFriends do
        local id, name = BNGetFriendInfo(i)
        name = name and tostring(name) -- escape the |k string
        if(name) then
            list[name] = true
        end
    end
end

function ChannelClean:BuildGuildList()
    local list = self.guildList
    wipe(list)
    if(not IsInGuild()) then return end

    for i = 1, GetNumGuildMembers() do
        local name = GetGuildRosterInfo(i)
        list[name] = true
    end
end

do
    local function getName(unit)
        if(UnitExists(unit)) then
            local name, realm = UnitName(unit)
            if(realm and realm ~= '') then
                name = name..'-'..realm
            end
            if(name ~= player_name) then
                return name
            end
        end
    end

    function ChannelClean:BuildGroupList()
        local list = self.groupList
        wipe(list)

        if(IsInGroup()) then
            if(IsInRaid()) then
                for i = 1, GetNumGroupMembers() do
                    local name = getName('raid'..i)
                    if(name) then
                        list[name] = true
                    end
                end
            else
                for i = 1, GetNumSubgroupMembers() do
                    local name = getName('party'..i)
                    if(name) then
                        list[name] = true
                    end
                end
            end
        end
    end

end

function ChannelClean:IsFriend(name)
    return self.friendsList[name] or
    self.guildList[name] or self.groupList[name]
end

-- function ChannelClean:Toggle(switch)
-- 	if (switch) then
-- 		self.enable = true;
-- 		self:ScheduleRepeatingTimer("CleanTempDB", db.cleanInterval)
-- 	else
-- 		self.enable = false;
-- 		self:CleanTempDB();
-- 	end
-- end



do
    local realFilter = function(frame, event, msg, sender, language, channelString, target, flags, _, channelNumber, channelName, _, counter)
        local self = ChannelClean
        -- bypass self and friends/guild
        if (sender == player_name and db.bypassSelf) or self:IsFriend(sender) then
            return false
        end

        if db.filterMonitor[event] then
            local msg, player = msg:lower(), sender:lower()
            for k,v in ipairs(db.filter.message) do
                if msg:find(v) then
                    self:Notice("message", sender, k, msg)
                    return true
                end
            end

            for k,v in ipairs(db.filter.player) do
                if player:find(v) then
                    self:Notice("player", sender, k)
                    return true
                end
            end

            for _,v in ipairs(trigger_temp) do
                if player == v then
                    self:Notice("trigger_temp", sender)
                    return true
                end
            end

            for k,v in ipairs(db.filter.trigger) do
                if msg:find(v) then
                    -- add to trigger db
                    self:AddTrigger(player)
                    self:Notice("trigger", sender, k)
                    return true
                end
            end
        end

        if db.flushControl and db.flushMonitor[event] then
            -- local msg, player, frameName = trim(msg:lower()), sender:lower(), frame:GetName()
            -- local tableIndex = frameName.."-"..player
            local msg, player = trim(msg:lower()), sender:lower()
            local tableIndex = player

            if speaker[tableIndex] and speaker[tableIndex].t + db.flushBanTime > time() then

                if db.flushMonitorSameMessageOnly and speaker[tableIndex].m == msg then
                    speaker[tableIndex] = { t = time(), m = msg }
                    self:Notice("flush", sender)
                    return true
                end

                if db.flushSimilar and self:CheckSimilarMessage(speaker[tableIndex].m, msg) then
                    speaker[tableIndex] = { t = time(), m = msg }
                    self:Notice("flushSimilar", sender)
                    return true
                end

                if not db.flushMonitorSameMessageOnly and not db.flushSimilar then
                    speaker[tableIndex] = { t = time(), m = msg }
                    self:Notice("flush", sender)
                    return true
                end
            end

            speaker[tableIndex] = { t = time(), m = msg }
        end
        return false
    end

    local lastCounter,result 
    function ChannelClean.ChatEventFilter(frame, event, msg, sender, language, channelString, target, flags, _, channelNumber, channelName, _, counter)
        if(lastCounter == counter) then
            return result
        end
        lastCounter = counter
        result = realFilter(frame, event, msg, sender, language, channelString, target, flags, _, channelNumber, channelName, _, counter)
        if(result) then debug('FILTER: ', result, counter, sender, channelString, msg) end
        return result
    end
end

-- function ChannelClean:ChatFrame_OnEvent(frame, event, ...)
-- 	local arg1, arg2 = ...;
-- 	if (self.enable) then
-- 		--bypass self message
-- 		if (arg2 == player_name and db.bypassSelf) or self:IsFriend(arg2) then 
-- 			return self.hooks.ChatFrame_OnEvent(frame, event, ...) 
-- 		end

-- 		if db.filterMonitor[event] then
-- 			local msg, player = arg1:lower(), arg2:lower()
-- 			for k,v in ipairs(db.filter.message) do
-- 				if msg:find(v) then
-- 					return self:Notice("message", arg2, k, msg)
-- 				end
-- 			end
-- 			for k,v in ipairs(db.filter.player) do
-- 				if player:find(v) then
-- 					return self:Notice("player", arg2, k)
-- 				end
-- 			end
-- 			for _,v in ipairs(trigger_temp) do
-- 				if player == v then
-- 					return self:Notice("trigger_temp", arg2)
-- 				end
-- 			end
-- 			for k,v in ipairs(db.filter.trigger) do
-- 				if msg:find(v) then
-- 					-- add to trigger db
-- 					self:AddTrigger(player)
-- 					return self:Notice("trigger", arg2, k)
-- 				end
-- 			end
-- 		end

-- 		if db.flushControl and db.flushMonitor[event] then
-- 			local msg, player, frameName = trim(arg1:lower()), arg2:lower(), frame:GetName()
-- 			local tableIndex = frameName.."-"..player

-- 			if speaker[tableIndex] and speaker[tableIndex].t + db.flushBanTime > time() then

-- 				if db.flushMonitorSameMessageOnly and speaker[tableIndex].m == msg then
-- 					speaker[tableIndex] = { t = time(), m = msg }
-- 					return self:Notice("flush", arg2)
-- 				end

-- 				if db.flushSimilar and self:CheckSimilarMessage(speaker[tableIndex].m, msg) then
-- 					speaker[tableIndex] = { t = time(), m = msg }
-- 					return self:Notice("flushSimilar", arg2)
-- 				end

-- 				if not db.flushMonitorSameMessageOnly and not db.flushSimilar then
-- 					speaker[tableIndex] = { t = time(), m = msg }
-- 					return self:Notice("flush", arg2)
-- 				end
-- 			end

-- 			speaker[tableIndex] = { t = time(), m = msg }
-- 		end
-- 	end
-- 	return self.hooks.ChatFrame_OnEvent(frame, event, ...);
-- end

-- --return true是过滤掉
-- function ChannelClean:FilterForChannel(event, ...)
--     local arg1, arg2 = ...;
--     --print("ChannelClean:FilterForChannel", event, arg1, arg2)
--     if (ChannelClean.enable) then
--         --bypass self message
--         if arg2 == player_name and db.bypassSelf then
--             return
--         end

--         if db.filterMonitor[event] then
--             local msg, player = arg1:lower(), arg2:lower()
--             for k,v in ipairs(db.filter.message) do
--                 if msg:find(v) then
--                     --return self:Notice("message", arg2, k, msg)
--                     return true
--                 end
--             end
--             for k,v in ipairs(db.filter.player) do
--                 if player:find(v) then
--                     --return self:Notice("player", arg2, k)
--                     return true
--                 end
--             end
--             for _,v in ipairs(trigger_temp) do
--                 if player == v then
--                     --return self:Notice("trigger_temp", arg2)
--                     return true
--                 end
--             end
--             for k,v in ipairs(db.filter.trigger) do
--                 if msg:find(v) then
--                     -- add to trigger db
--                     self:AddTrigger(player)
--                     --return self:Notice("trigger", arg2, k)
--                     return true
--                 end
--             end
--         end
--     end
-- end
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChannelClean.FilterForChannel);

function ChannelClean:Notice(blocktype, blockplayer, blockrule, msg)
	-- if DEBUG_MODE and msg then self:Print("BLOCKED "..msg) end
	if not db.notice then
		return
	end

	-- don't fire too much notice
	if lastNotice[blockplayer] and time() - lastNotice[blockplayer] < db.noticeInterval then
		return
	end
	lastNotice[blockplayer] = time()

	local blockmsg = "NOTICE_"..blocktype
	self:Print(format(L[blockmsg], blockplayer, blockrule))
	-- if DEBUG_MODE and msg then self:Print(msg) end
end

function ChannelClean:AddTrigger(player)
	if db.triggerMode == "forever" then
		tinsert(db.filter.player, player)
	else
		tinsert(trigger_temp, player)
	end
	--ComplainChat(player)
end

function ChannelClean:RemoveDupe(blockrules)
	if type(blockrules)~="table" then
		return {}
	end
	local newrules = {}
	for _,check in ipairs(blockrules) do
		if check and not self:CheckExists(newrules, check) then
			tinsert(newrules, check)
		end
	end
	return newrules
end

function ChannelClean:CheckExists(rules, check)
	for _,vv in ipairs(rules) do
		if vv == check then
			return true
		end
	end
	return false
end

do
    local tmp = {}
    function ChannelClean:CleanTempDB()
        wipe(tmp)
        local now = time()
        for ent, ts in next, lastNotice do
            if(now - ts > db.cleanInterval) then
                tinsert(tmp, ent)
            end
        end
        for _, ent in next, tmp do
            lastNotice[ent] = nil
        end

        wipe(tmp)
        for ent, v in next, speaker do
            if(now - v.t > db.flushBanTime) then
                tinsert(tmp, ent)
            end
        end

        for _, ent in next, tmp do
            speaker[ent] = nil
        end
    end
end

function ChannelClean:LoadDefaultRules()
	if not db.firstTime then return end
	if L["DefaultRules"] and type(L["DefaultRules"]) == "table" then
		for k,v in pairs(L["DefaultRules"]) do
			if (k ~= "trigger" and k ~= "message" and k ~= "player") then return end
            local filter = db.filter[k]
            wipe(filter)
            for _, vv in ipairs(v) do
                tinsert(filter, vv)
            end
			-- if (#db.filter[k] == 0) then
			-- 	for _, vv in ipairs(v) do
			-- 		tinsert(db.filter[k], vv)
			-- 	end
			-- end
		end
	end
	db.firstTime = false
	--self:Print(L["Already loaded default rules."])
end

function ChannelClean:CheckSimilarMessage(msg1, msg2)
	local len1, len2 = msg1:len(), msg2:len()
	-- make len2 always not less than len1
	if len1 > len2 then
		msg1, msg2 = msg2, msg1
		len1, len2 = len2, len1
	end

	local match = 0
	for i = 1, len1 do
		if msg2:find(msg1:sub(i, i+1), 1, true) then
			match = match + 1
		end
	end

	local score =  match / len2 * 100
	if score >= db.flushSimilarScore then
		return true
	end

	return false
end
