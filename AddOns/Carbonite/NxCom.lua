local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxCom - Communication code
-- Copyright 2007-2012 Carbon Based Creations, LLC
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Carbonite - Addon for World of Warcraft(tm)
-- Copyright 2007-2012 Carbon Based Creations, LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------------------------

-- Warning: "\" in send data can lead to invalid escape codes (ok, since only escaped if in literal string?)
-- Bytes 35 (#) + 57 == 92 (\)
--
-- Byte 124 == |. Must be |c or creates invalid escape code. Not in addon channel, only chat
-- Byte 128 or higher == invalid UTF-8 error. Not in addon channel, only chat

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Com

NxCOMOPTS_VERSION	= .01

NxComOpts = {
	Version = 0
}

NxComOptsDefaults = {
	Version = NxCOMOPTS_VERSION,
}

--------
-- Open and init com

function Nx.Com:Init()

--	if NxData.NXVerDebug then	-- Test!!!
--		Nx.Timer:Start ("ComShowVer", 2, self, self.ShowVerTimer)
--	end

	--

	if NxComOpts.Version < NxCOMOPTS_VERSION then

		if NxComOpts.Version ~= 0 then
			Nx.prt (L["Com options reset (%f, %f)"], NxComOpts.Version, NxComOptsDefaults.Version)
		end

		NxComOpts = NxComOptsDefaults
	end

	--

	self.Created = false
	self.Data = {}
	self.Data.Rcv = {}
	self.Data.Send = {}
	self.Name = "Crb"
	self.ChanALetter = Nx.Free and "Y" or Nx.Ads and "M" or "B"		-- Global letter. Z is used by zone channel

	self.SendRate = 1

	self.SendQNames = { ["Chan"] = 1, ["Guild"] = 2, ["Friend"] = 3, ["Zone"] = 4 }

	local sq = {}
	self.SendQ = sq
	sq[1] = {}						-- Channel
	sq[2] = {}						-- Guild
	sq[3] = {}						-- Friends
	sq[4] = {}						-- Zone
	self.SendQMode = 1

	self.PalsInfo = {}			-- Friends and guildy info (position)
	self.PalsSendQ = {}
	self.PalNames = {}

	self.MemberNames = {}		-- Names in party or raid

	self.Friends = {}
	self.Punks = {}

	self.ZPInfo = {}				-- Zone player info (position)
	self.ZStatus = {}				-- Zones status. Indexed with map id
	self.ZMonitor = {}			-- Zones to monitor

	self.VerPlayers = {}			-- Version messages from players (for debug)

	self.SendChanQ = {}

	self.PosSendNext = -2
	self.SendZSkip = 1

	self.TypeColors = { "|cff80ff80", "|cffff4040", "|cffffff40", "|cffffffe0", "|cffc0c0ff" }

	self.ClassNames = {
		[0] = "?",
		"Druid", "Hunter", "Mage", "Paladin", "Priest",
		"Rogue", "Shaman", "Warlock", "Warrior", "Deathknight", "Monk"
	}
	for k, v in ipairs (self.ClassNames) do
		self.ClassNames[v] = k
		self.ClassNames[strupper (v)] = k	-- All caps version
	end

	self.Created = true	-- Used???

	self.List.Opened = false
	self.List.Sorted = {}

--	self.List:Open()

--[[
	for n = 1, 25 do
		Nx.Timer:Start ("ComTest"..n, 1 + n * .1, self, self.OnTestTimer)
	end
--]]

	self.SentBytes = 0			-- Debugging
	self.SentBytesSec = 0
	self.SentBytesTime = GetTime()
	Nx.Timer:Start ("ComBytesSec", 1, self, self.OnBytesSecTimer)

--	Nx.Timer:Start ("ComVerTest", 3, self, function() self:ShowVersionMsg() end)

	hooksecurefunc ("SendChatMessage", self.SendChatHook)

end

--------

function Nx.Com:Test (a1, a2)

	self:SendSecG ("? }a", "")		-- Ask for it

--[[
	local start = tonumber (a1) or 1
	local num = tonumber (a2) or 8

	local s = ""

	for n = start, start+19 do
		Nx.prt ("%d", n)
		s = format ("%d |d%c", n, n)
		self:SendChatMessageFixed (s, "CHANNEL", num)
		self:SendChatMessageFixed (s, "PARTY")
--		SendAddonMessage (self.Name, format ("%d |%c \%c", n, n, n), "PARTY")
	end
--]]
end

--------
--

function Nx.Com:OnTestTimer (name)

	self:SendPals ("!"..name)

	if random() < .5 then
--		local i = random (1, 80)
--		self:OnPlayer_level_up (i)
	end

	return .1 + random() * 5 --15
end

--------
--

function Nx.Com:OnBytesSecTimer (name)

	local tm = GetTime()

	self.SentBytesSec = self.SentBytes / (tm - self.SentBytesTime)

	self.SentBytes = 0
	self.SentBytesTime = tm

	return 1
end

--------
-- On com event

function Nx.Com:OnEvent (event)

	local self = Nx.Com

--	Nx.prt ("Com Event: %s", event)

	if event == "PLAYER_LOGIN" then

		RegisterAddonMessagePrefix (self.Name)		-- 4.1 must register for guild messages

		self.PlyrName = UnitName ("player")
		self.PlyrMapId = Nx.Map:GetRealMapId()
		self.PlyrX = 0
		self.PlyrY = 0

		local _, tCls = UnitClass ("player")		-- Non localized uppercase version
		self.PlyrClassI = self.ClassNames[tCls] or 0

		self.List:AddInfo ("", "PLAYER_LOGIN")

		self.SendTime = GetTime()
		self.SendPosTime = GetTime()
		self.SendChanTime = GetTime()

		self:LeaveChan ("A")
		self:LeaveChan ("Z")
		Nx.Timer:Start ("ComLogin", 3 + random() * 1, self, self.OnLoginTimer)

--		Nx.prt ("Com PLAYER_LOGIN")

		if IsInGuild() then
			GuildRoster()
		end
		ShowFriends()

	elseif event == "ZONE_CHANGED_NEW_AREA" then

		self.List:AddInfo ("", "ZONE_CHANGED_NEW_AREA")

		if not Nx.Timer:IsActive ("ComLogin") then
			self:UpdateChannels()
		end

	elseif event == "PLAYER_LEAVINGWORLD" then

		self:LeaveChan ("A")
		self:LeaveChan ("Z")
	end

	self.List:Update()
end

function Nx.Com:OnLoginTimer()

	if UnitOnTaxi ("player") then		-- Detect login on taxi, which will not join channels until you land

		local id = GetChannelName (1)		-- Detect if reload
		if id ~= 1 then
			self.WasOnTaxi = true
			return .5
		end
	end

	if self.WasOnTaxi then
		self.WasOnTaxi = nil
		return 3
	end

	local opts = Nx:GetGlobalOpts()

	if IsControlKeyDown() and IsAltKeyDown() then
		Nx.prt ("Disabling com functions!")
		opts["ComNoGlobal"] = true
		opts["ComNoZone"] = true
	end

	local need = 2
	if opts["ComNoGlobal"] then
		need = 1
	end
	if opts["ComNoZone"] then
		need = need - 1
	end

	local free = max (10 - self:GetChanCount(), 0)

	if need > free then
		Nx.prt (L["|cffff9f5fNeed %d chat channel(s)!"], need - free)
		Nx.prt (L["|cffff9f5fThis will disable some communication features"])
		Nx.prt (L["|cffff9f5fYou may free channels using the chat tab"])
	end

	-- Should not find any since we left all zone channels a few seconds ago
	self:ScanChans()
	self:UpdateChannels()

	self:JoinChan ("A")		-- Addon
--	self:JoinChan ("Z")		-- Zone

--	self:SendA (format ("TEST"))
end

function Nx.Com:OnVersionTimer()

--	Nx.prt ("Com Test")
--	self:SendSecG ("? 0123 ABCD abcd [\]^_'", "")

	self:SendSecG ("V ", self:MakeVersionMsg())

	if IsInGuild() then
		GuildRoster()		-- Force update
	end

--	if Nx.Free then
--		Nx.Timer:Start ("ComLeaveA", 60 * 60, self, self.OnLeaveATimer)
--	end

	self:LeaveChans ("A")	-- Old
end

function Nx.Com:MakeVersionMsg()

--	local r, c = Nx.Sec:GetRCMsg()
	local r = ""
	local dt = date ("%y%m%d", time())

	local qCnt = Nx.Quest:CaptureGetCount()
	local lvl = UnitLevel ("player")

	return format ("%f^%s^^%s^%f^%d^%x^%x", Nx.VERSION, r, dt, NxData.NXVer1, qCnt, lvl, self.PlyrMapId)
end

function Nx.Com:OnLeaveATimer()
--	Nx.prt ("Com OnLeaveATimer")
	self:LeaveChan ("A")
end

--------
-- We leveled

function Nx.Com:OnPlayer_level_up (event, arg1)

	if arg1 >= 1 then		-- Level #
		self:SendPals (format ("L%s", strchar (35 + arg1)))
	end
end

--------
-- Friends list changed. Build list of connected non guild friends

function Nx.Com:OnFriendguild_update()

	local self = Nx.Com

--	Nx.prt ("OnFriendguild_update")

	local gNames = {}
	local gNum = GetNumGuildMembers()

	for n = 1, gNum do
		local name, _, _, _, _, _, _, _, online = GetGuildRosterInfo (n)
		if online then
			gNames [name] = true
		end
	end

	self.Friends = {}
	local i = 1

	for n = 1, GetNumFriends() do

		local name, lvl, class, area, con, status = GetFriendInfo (n)
		if con then

			if not gNames[name] then

--				Nx.prt ("Add friend %s", name)

				self.Friends[i] = name
				i = i + 1
			end
		end
	end

	for k, v in ipairs (self.Friends) do
		gNames[v] = false
	end
	self.PalNames = gNames
end

--------
-- On com event

function Nx.Com:OnChatEvent (event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

	local self = Nx.Com

--	Nx.prt ("ComChatEvent: %s %s", event, arg9)

	if strsub (arg9, 1, 3) == self.Name then

		if event == "CHAT_MSG_CHANNEL_JOIN" then

			self.List:AddInfo ("CJ:"..arg9, format ("%s", arg2))

		elseif event == "CHAT_MSG_CHANNEL_NOTICE" then

			self.List:AddInfo ("CN:"..arg9, format ("%s", arg1))

			local nameRoot = strsplit ("I", arg9)	-- Drop I and #

			if arg1 == "YOU_JOINED" then

				local typ = strupper (strsub (arg9, 4, 4))

				if typ == self.ChanALetter then
					self.ChanAName = arg9

--					Nx.prt ("Join %s", arg9)
					Nx.Timer:Stop ("ComA")

					Nx.Timer:Start ("ComVerSend", 3, self, self.OnVersionTimer)

				elseif typ == "Z" then

					local mapId = tonumber (strsub (nameRoot, 5))
					if mapId then
						local zs = self.ZStatus[mapId] or {}
						zs.ChanName = arg9
						self.ZStatus[mapId] = zs

						Nx.Timer:Stop ("ComZ" .. mapId)

						self:UpdateChannels()
					end

--					Nx.prt ("Join %s", arg9)
				end

			elseif arg1 == "YOU_LEFT" then

				local typ = strupper (strsub (arg9, 4, 4))

				if typ == "Z" then

					local mapId = tonumber (strsub (nameRoot, 5))
					if mapId then
						local zs = self.ZStatus[mapId] or {}
						zs.ChanName = nil
						self.ZStatus[mapId] = zs
					end
				end
			end

		elseif event == "CHAT_MSG_CHANNEL_LEAVE" then

			self.List:AddInfo ("CL:"..arg9, format ("%s", arg2))
		end

		self.List:Update()
	end
end

--------
-- On channel message event

function Nx.Com:OnChat_msg_channel (event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

	local self = Nx.Com

	if strsub (arg9, 1, 3) == self.Name then

		local name = arg2

		if name ~= self.PlyrName then

			local msg = self:RestoreChars (arg1)

--			self.List:AddInfo ("C:"..arg9, format ("(%s) %s", name, msg))
--			self.List:Update()

			local id = strbyte (msg)

			if id == 83 then		-- S (status) Check 1st for performance

				if not self.PalsInfo[name] then	-- Not a pal we have?
					if #msg >= 16 then

						local pl = self.ZPInfo[name]

						if not pl then
							pl = {}
							self.ZPInfo[name] = pl
						end

						self:ParsePlyrStatus (name, pl, msg)
					end
				end

			elseif id == 86 then	-- V (Version and registered name)

				self:OnMsgVersion (name, msg, arg2, arg9)
			end
		end
	end
end

--------
-- On addon message event

function Nx.Com:OnChat_msg_addon (event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

	local self = Nx.Com

--	Nx.prt ("ComChatAddonEvent: %s %s %s", event, arg1, arg4)

	if strsub (arg1, 1, 3) == self.Name then

		local name = arg4

--		if 1 then
		if name ~= self.PlyrName then		-- Ignore myself

--			self.List:AddInfo ("A:"..arg1, format ("(%s %s) %s", name, arg3, arg2))

			local data = { strsplit ("\t", arg2) }

			for k, msg in ipairs (data) do

				local id = strbyte (msg)

				if id == 83 then	-- S (status) Check 1st for performance

					if self.PalNames[name] ~= nil then
						if #msg >= 16 then

							local pal = self.PalsInfo[name]

							if not pal then
								pal = {}
								self.PalsInfo[name] = pal
							end

							self:ParsePlyrStatus (name, pal, msg)
						end
					end

				elseif id == 76 then	-- L (Level)

					local opts = Nx:GetGlobalOpts()

					if opts["InfoLvlUpShow"] then
						local s = format (L["%s reached level %d!"], name, strbyte (msg, 2) - 35)
						Nx.prt (s)
						Nx.UEvents:AddInfo (s)
					end

				elseif id == 81 then	-- Q (Quest)

					Nx.Quest:OnMsgQuest (name, msg)

				elseif id == 86 then	-- V (Version and registered name)

					self:OnMsgVersion (name, msg, arg2, arg9)
				end
			end
		end

--		self.List:Update()

	elseif arg1 == "LGP" then		-- Cartographer LibGuildPositions

--		Nx.prt ("ComChatAddonEvent: %s %s %s", event, arg1, arg4)
--		Nx.prt (" %s", arg2)
--		Nx.prtStrHex ("Pos", arg2)

		local name = arg4

		if name ~= self.PlyrName then

			if self.PalNames[name] ~= nil then
				self:ParseLGP (name, arg2)
			end
		end
	end
end

--------
-- Parse a player status message

function Nx.Com:ParsePlyrStatus (name, info, msg)

	-- Flags
	-- 1 combat
	-- 2 target data
	-- 4 quest data
	-- 8 punks data

	local flags = strbyte (msg, 2) - 35
	info.F = flags

	info.Quest = nil

	-- Player info

	local mapId = tonumber (strsub (msg, 3, 6), 16)	-- Map id

	local winfo = Nx.Map.MapWorldInfo[mapId]
	if not winfo then
		info.T = 0			-- Cause it to die
--		Nx.prt ("Die %s", mapId)
		return
	end

	info.T = GetTime()
	info.MId = mapId
	info.EntryMId = mapId

	if winfo.EntryMId then
		info.EntryMId = winfo.EntryMId
	end

	info.X = tonumber (strsub (msg, 7, 9), 16) / 0xfff * 100
	info.Y = (tonumber (strsub (msg, 10, 13), 16) or 0) / 0xfff * 100		-- Includes dungeon level offset (dzzz)
	info.Health = (strbyte (msg, 14) - 48) / 20 * 100
	info.Lvl = strbyte (msg, 15) - 35
	info.Cls = self.ClassNames[strbyte (msg, 16) - 35] or "?"

--	Nx.prt ("%s %d %d", name, info.X, info.Y)

--	if not self.ClassNames[strbyte (msg, 16) - 35] then
--		Nx.prt ("com cls? %s", strbyte (msg, 16) - 35)
--	end

	info.Tip = format ("%s %s%%\n  %s %s", name, info.Health, info.Lvl, _TRANS(info.Cls))

--	Nx.prtVar ("Cominfo", info)


	local off = 17

	-- Target data

	if bit.band (flags, 2) > 0 then

		-- Type, level, class, health, name len, name

		info.TType = strbyte (msg, 17) - 35
		local col = self.TypeColors[info.TType] or ""		-- User had a nil

		info.TLvl = strbyte (msg, 18) - 35
		info.TCls = self.ClassNames[strbyte (msg, 19) - 35] or "?"

--		if not self.ClassNames[strbyte (msg, 19) - 35] then
--			Nx.prt ("com tcls? %s", strbyte (msg, 19) - 35)
--		end

		info.TH = (strbyte (msg, 20) - 35) / 20 * 100
		local len = strbyte (msg, 21) - 35
		info.TName = strsub (msg, 22, 22 + len - 1)

		local lvl = info.TLvl
		if lvl < 0 then
			lvl = "??"
		end

		info.TStr = format ("\n%s%s %s %s %d%%", col, info.TName, lvl, _TRANS(info.TCls), info.TH)

		off = 22 + len

	else
		info.TType = nil
		info.TStr = nil
	end

	-- Quest tracking data

	if bit.band (flags, 4) > 0 then

		local len = Nx.Quest:DecodeComRcv (info, strsub (msg, off))
		if not len then	-- Error?
			return
		end
		off = off + len

	else
		info.QStr = nil
	end

	-- Punks data

	if bit.band (flags, 8) > 0 then
		-- First byte is string length. Skip
		Nx.Social:DecodeComRcvPunks (name, info, strsub (msg, off + 1))
	end
end

--------
-- Parse Cartographer LibGuildPositions

function Nx.Com:ParseLGP (name, msg)

	if strbyte (msg) == 0x50 then	-- P (position)

		local x, x2, y, y2, len = strbyte (msg, 2, 6)

		if len and len > 1 then

			x = ((x - 1) * 255 + x2 - 1) / (255 ^ 2) * 100
			y = ((y - 1) * 255 + y2 - 1) / (255 ^ 2) * 100
			local zoneName = strsub (msg, 7, 5 + len)	-- Len is +1 real length
--			Nx.prt ("%s %s %s", zoneName, x, y)

			local mapId = Nx.MapOverlayToMapId[strlower (zoneName)]
--			Nx.prt ("mapId %s", mapId or "nil")

			if mapId then

				local info = self.PalsInfo[name]

				if not info then
					info = {}
					self.PalsInfo[name] = info
				end

				info.T = GetTime()
				info.MId = mapId
				info.EntryMId = mapId
				info.X = x
				info.Y = y
				info.F = 0
				info.Tip = name
			end
		end
	end
end

--------
-- Update channels

function Nx.Com:UpdateChannels()

	Nx.Timer:Start ("ComUC", 0, self, self.UpdateChannelsTimer)
end

function Nx.Com:UpdateChannelsTimer()

	if Nx.Timer:IsActive ("ComLogin") then
		return 0
	end

	local opts = Nx:GetGlobalOpts()
	local curMapId = Nx.Map:GetRealMapId()

	if UnitIsAFK ("player") or opts["ComNoZone"] then		-- No current zone channel?
		curMapId = nil

	else
		if Nx.Map:IsNormalMap (curMapId) then
			local zs = self.ZStatus[curMapId] or {}
			zs.Join = true
			self.ZStatus[curMapId] = zs
		end
	end

	-- Monitor

	for mapId, mode in pairs (self.ZMonitor) do

		if mode == 0 then

			self.ZMonitor[mapId] = 1

			local zs = self.ZStatus[mapId] or {}
			zs.Join = true
			self.ZStatus[mapId] = zs

		elseif mode == -1 then

			self.ZMonitor[mapId] = nil
		end
	end

	-- Update status (join or leave channels)

	for mapId, status in pairs (self.ZStatus) do

		if status.ChanName then
			if curMapId ~= mapId and not self.ZMonitor[mapId] then
				status.Leave = true
			end
		end

		if status.Leave then
			status.Leave = false

			Nx.Timer:Stop ("ComZ" .. mapId)

			if status.ChanName then
				LeaveChannelByName (status.ChanName)
			end
		end

		if status.Join then
			status.Join = false

			if not status.ChanName then

				local timerName = "ComZ" .. mapId

				if not Nx.Timer:IsActive (timerName) then

--					Nx.prt ("Com Status Join %s", mapId)

					local timer = Nx.Timer:Start (timerName, 2, self, self.OnJoinChanZTimer)
					timer.UMapId = mapId
					timer.UTryCnt = 0
				end
			end
		end
	end
end

--------
-- Join a channel

function Nx.Com:JoinChan (chanId)

	local opts = Nx:GetGlobalOpts()

--	if self:InChan (chanId) then		-- Already in?
--		return
--	end

--	local chanCnt = self:GetChanCount()
--	Nx.prt ("JoinChan %s (%s)", chanId, chanCnt)

	if chanId == "A" then	-- Addon channel (global)

		if not opts["ComNoGlobal"] then

			self.ChanAName = nil
			self.TryA = 0
			Nx.Timer:Start ("ComA", 0, self, self.OnJoinChanATimer)
		end

	elseif chanId == "Z" then	-- Our zone

		if not opts["ComNoZone"] then

			local mapId = Nx.Map:GetRealMapId()
			if Nx.Map:IsNormalMap (mapId) then

				local timer = Nx.Timer:Start ("ComZ", 0, self, self.OnJoinChanZTimer)
				timer.UMapId = mapId
				timer.UTryCnt = 0
			end
		end
	else
		Nx.prt (L["JoinChan Err %s"], chanId)

	end
end

function Nx.Com:OnJoinChanATimer()

	self.List:AddInfo ("", "OnJoinChanATimer")

	if self:GetChanCount() >= 10 then
		return 10
	end

--	if self.TryA > 0 then
--		Nx.prt ("Trying A%d", self.TryA + 1)
--	end

	self.TryA = self.TryA + 1

	JoinChannelByName (self.Name .. self.ChanALetter .. self.TryA)

	return 3
end

function Nx.Com:OnJoinChanZTimer (name, timer)

	self.List:AddInfo ("", "OnJoinChanZTimer " .. name)

	if self:GetChanCount() >= 10 then
		return 5
	end

--	if self.TryZ > 0 then
--		Nx.prt ("Trying Z%d", self.TryZ + 1)
--	end

	timer.UTryCnt = timer.UTryCnt + 1

	local name = format ("%sZ%dI%d", self.Name, timer.UMapId, timer.UTryCnt)
	if self:InChan (name) then
		return
	end

	JoinChannelByName (name)

	return 3
end

--------
-- Count channels being used

function Nx.Com:GetChanCount()

	local chanCnt = 0

	for n = 1, GetNumDisplayChannels() do
		local chname, header, collapsed, chanNumber, plCnt, active, category, voiceEnabled, voiceActive = GetChannelDisplayInfo (n)
		if not header then
			chanCnt = chanCnt + 1
		end
	end

	return chanCnt
end

--------
-- Leave a channel

function Nx.Com:LeaveChan (chanId)

	if chanId == "A" then

		self.ChanAName = nil
		self:LeaveChans (self.ChanALetter)

	elseif chanId == "Z" then

		self:LeaveChans (chanId)
	end
end

--------
-- Leave a type of channel

function Nx.Com:LeaveChans (typeName)

	for n = 1, 10 do

		local id, name = GetChannelName (n)
		if id > 0 and name then

--			Nx.prt ("Leave Chan N %d %s", id, name)

			local name3 = strsub (name, 1, 3)
			if name3 == self.Name then

				local typ = strupper (strsub (name, 4, 4))
				if typ == typeName then

					if typ == "Z" then

						local nameRoot = strsplit ("I", name)	-- Drop I and #
						local id = tonumber (strsub (nameRoot, 5))
--						Nx.prtVar ("Com leave id", id)

						if not self.ZMonitor[id] then		-- Not monitored?
							LeaveChannelByName (name)
						end

					else
						LeaveChannelByName (name)
					end
				end
			end
		end
	end
end

--------
-- Scan channels and add missing to status

function Nx.Com:ScanChans()

--	Nx.prt ("Com scan")

	local baseName = self.Name .. "Z"

	for n = 1, 10 do

		local id, name = GetChannelName (n)
		if id > 0 and name then

--			Nx.prt ("Com scan %s", name)

			local name4 = strsub (name, 1, 4)
			if name4 == baseName then

				local nameRoot = strsplit ("I", name)	-- Drop I and #
				local mapId = tonumber (strsub (nameRoot, 5))

				if mapId then
					local zs = self.ZStatus[mapId] or {}
					zs.ChanName = name
					self.ZStatus[mapId] = zs
				end
			end
		end
	end
end

--------
-- Check if in a type of channel

function Nx.Com:InChanType (typeName)

	for n = 1, 10 do

		local _, name = GetChannelName (n)
		if name then

			local name3 = strsub (name, 1, 3)
			if name3 == self.Name then

				local typ = strsub (name, 4, 4)
				if typ == typeName then

					return true
				end
			end
		end
	end
end

--------
-- Check if in a named channel

function Nx.Com:InChan (chanName)

	for n = 1, 10 do

		local _, name = GetChannelName (n)
		if chanName == name then
			return true
		end
	end
end

--------
-- Set send pals mask. Called by options init. Don't do stuff needing com init

function Nx.Com:SetSendPalsMask (mask)
	self.SendPMask = mask
end

--------
-- Send message to pals

function Nx.Com:SendPals (msg)

	assert (msg)

	self.PalsSendQ[#self.PalsSendQ + 1] = msg
end

--------
-- Send a secure message to the global addon named channel

function Nx.Com:SendSecG (pre, msg)

--	Nx.prt ("Send G")

	if self.ChanAName then		-- Should always be set, but was nil once

		local num = GetChannelName (self.ChanAName)
		if num ~= 0 then

			local cs = self:Chksum (msg)
			local str = self:Encode (format ("%s%c%c%s", pre, floor (cs / 16) + 65, bit.band (cs, 15) + 65, msg))

			self:SendChan (num, str)
		else
			Nx.prt (L["SendSecG Error: %s"], pre)
		end
	end
end

--------
-- Send a secure message to player using addon whisper

function Nx.Com:SendSecW (pre, msg, plName)

	local cs = self:Chksum (msg)
	local str = self:Encode (format ("%s%c%c%s", pre, floor (cs / 16) + 65, bit.band (cs, 15) + 65, msg))

	self.SentBytes = self.SentBytes + #str + 54 + 20	-- Packet overhead + some WOW overhead

	SendAddonMessage (self.Name, str, "WHISPER", plName)
end

--------
-- Send a message to a named channel

function Nx.Com:Send (chanId, msg, plName)

	assert (msg)

	if chanId == "Z" then	-- Zone chat channel

		local mapId = Nx.Map:GetRealMapId()
		local chanName = self.ZStatus[mapId] and self.ZStatus[mapId].ChanName

		if chanName then

			local num = GetChannelName (chanName)
			if num ~= 0 then
				self:SendChan (num, msg)
			end
		end

	else

		self.SentBytes = self.SentBytes + #msg + 54 + 20	-- Packet overhead + some WOW overhead

		if chanId == "g" then	-- Addon guild

			if IsInGuild() then
				SendAddonMessage (self.Name, msg, "GUILD")
			end

		elseif chanId == "p" then	-- Addon party
			if (IsPartyLFG()) then
				SendAddonMessage (self.Name, msg, "INSTANCE_CHAT")
			else
				SendAddonMessage (self.Name, msg, "PARTY")
			end
		elseif chanId == "W" then	-- Addon whisper

--			Nx.prt ("Send W %s", plName)
			SendAddonMessage (self.Name, msg, "WHISPER", plName)

		elseif chanId == "P" then	-- Party channel
			if GetNumSubgroupMembers() > 0 then
				if (IsPartyLFG()) then
					self:SendChatMessageFixed (msg, "INSTANCE_CHAT")
				else
					self:SendChatMessageFixed (msg, "PARTY")
				end
			end

		else
			assert (false)

		end
	end
end

--------
-- Send a message to a numbered chat channel using a buffer

function Nx.Com:SendChan (num, msg)

	local data = {}
	data.ChanNum = num
	data.Msg = msg
	tinsert (self.SendChanQ, data)
end

--------
-- Send chat hook

function Nx.Com.SendChatHook (msg, chanName)

	if chanName == "CHANNEL" then
--		Nx.prt ("SendChat CHANNEL %s", msg)

		Nx.Com.SendChanTime = GetTime()		-- Reset time
	end
end

--------
-- Calc a message checksum

function Nx.Com:Chksum (msg)

	local v = 0
	local xor = bit.bxor

	for n = 1, #msg do
		 v = xor (v, strbyte (msg, n))
	end

	return v
end

function Nx.Com:IsChksumOK (msg)

--	Nx.prt ("Com chksum rcv %s", #msg)

	if #msg >= 4 then

		-- skip 2 bytes at head

		local ck = (strbyte (msg, 3) - 65) * 16 + (strbyte (msg, 4) - 65)

		local v = 0
		local xor = bit.bxor

		for n = 5, #msg do
			 v = xor (v, strbyte (msg, n))
		end

		return ck == v
	end
end

--------
-- Encode a message

function Nx.Com:Encode (msg)

	local s = {}

	s[1] = strsub (msg, 1, 2)

	for n = 3, #msg do
		 s[n - 1] = strchar (strbyte (msg, n) - 1)
	end

--	Nx.prt (table.concat (s))

	return table.concat (s)
end

--------
-- Decode a message

function Nx.Com:Decode (msg)

	local s = {}

	s[1] = strsub (msg, 1, 2)

	for n = 3, #msg do
		 s[n - 1] = strchar (strbyte (msg, n) + 1)
	end

	return table.concat (s)
end

function Nx.Com:SendChatMessageFixed (msg, typ, num)

	-- Fix invalid chat characters

	local s1 = strfind (msg, "|")
	if s1 then
		if strbyte (msg, s1 + 1) ~= 99 then		-- not c
--			Nx.prt ("chat OR in %s (%s)", strsub (msg, 1, 2), strsub (msg, s1, s1 + 5))
			msg = gsub (msg, "|", "\1")
		end
	end

--  p  i  i  i  i  x  x  x  y  y  y  h  f qi qi qi qi ob  f lb  c to
-- 70 20 37 64 63 39 66 38 38 32 63 44 2b 31 37 30 64 23 25 24 25 87   << 100 termites. overflow
--        7  d  c  9  f  8  8  2  c  D  8  1  7  0  d        1  0 100

-- 70 20 62 62 62 62 36 63 63 36 66 44 4b 24 83 2c 37 2b 4b 69
--        b  b  b  b  f  8  8  2  c  D 28  $ ??  ,  7  +

-- "p%4x%3x%3x%c%c%s%s%s", self.PlyrMapId, x, y, hper+48, flgs+35, tStr, qStr, enStr))

--                                        typ lvl cls he 13  O  a  s  i  s     S  n  a  p  j  a  w
-- 70 20 33 66 62 38 65 35 36 66 39 44 43 26  32  2c  d9 30 4f 61 73 69 73 20 53 6e 61 70 6a 61 77
--                                     20

	local ok = pcall (SendChatMessage, msg, typ, nil, num)
	if not ok then
		Nx.prtStrHex (typ .. " SendChat failed", msg)
	end
end

--------
-- Restore invalid chat characters

function Nx.Com:RestoreChars (msg)

	local s1 = strfind (msg, "\1")
	if s1 then
--		Nx.prt ("Com restored char")
		return gsub (msg, "\1", "|")
	end

	return msg
end

--------
-- Monitor a zone

function Nx.Com:MonitorZone (mapId, enable)

	local i = self.ZMonitor[mapId]

	if enable then
		if not i or i < 0 then

			if self:GetChanCount() >= 10 then
				Nx.prt (L["|cffff4040Monitor Error: All 10 chat channels are in use"])
			else
				Nx.prt (L["|cff40ff40Monitored:"])
			end

			self.ZMonitor[mapId] = 0

			for mapId, mode in pairs (self.ZMonitor) do
				if mode >= 0 then
					local zs = self.ZStatus[mapId]
					if zs and zs.ChanName then
						Nx.prt (" %s", Nx.MapIdToName[mapId])
					else
						Nx.prt (L[" %s (pending)"], Nx.MapIdToName[mapId])
					end
				end
			end
		end
	else
		if i and i >= 0 then
			self.ZMonitor[mapId] = -1
		end
	end

	self:UpdateChannels()
end

function Nx.Com:IsZoneMonitored (mapId)
	local i = self.ZMonitor[mapId]
	return i and i >= 0
end

--------
-- Capture punk names from combat events

function Nx.Com:OnCombat_log_event_unfiltered (event, ...)

	local sName, sFlags, sFlags2, dId, dName, dFlags = select (5, ...)

--	Nx.prt ("Com:Combat %s %x, %s %x", sName or "nil", sFlags, dName or "nil", dFlags)

--	local COMBATLOG_OBJECT_REACTION_HOSTILE = 0x40
--	local COMBATLOG_OBJECT_TYPE_PLAYER = 0x400

	if sName and bit.band (sFlags, 0x440) == 0x440 then
--		Nx.prt ("punk-s %s", sName)

		local near
		if dName and bit.band (dFlags, 0x440) == 0x400 then
			near = dName
		end

		Nx.Social:AddLocalPunk (sName, near)

		if not Nx.InBG then
			Nx.Com.Punks[sName] = 0
		end
	end

	if dName and dName ~= sName and bit.band (dFlags, 0x440) == 0x440 then
--		Nx.prt ("punk-d %s", dName)

		local near
		if sName and bit.band (sFlags, 0x440) == 0x400 then
			near = sName
		end

		Nx.Social:AddLocalPunk (dName, near)

		if not Nx.InBG then
			Nx.Com.Punks[dName] = 0
		end
	end
end

--------
-- Frame update. Called by main addon frame

function Nx.Com:OnUpdate (elapsed)

	local Nx = Nx
	local bgmap = Nx.InBG

	local targetName = UnitName ("target")

	-- Punk targets

	if UnitIsPlayer ("target") and UnitIsEnemy ("player", "target") then

		local lvl = UnitLevel ("target") or 0
		if not bgmap then
			self.Punks[targetName] = lvl
		end
		Nx.Social:AddLocalPunk (targetName, nil, lvl, UnitClass ("target"))
	end

	if UnitIsPlayer ("mouseover") and UnitIsEnemy ("player", "mouseover") then

		local moName = UnitName ("mouseover")
		if moName ~= targetName then

			local lvl = UnitLevel ("mouseover") or 0
			if not bgmap then
				self.Punks[moName] = lvl
			end
			Nx.Social:AddLocalPunk (moName, nil, lvl, UnitClass ("mouseover"))
		end
	end

	--

	local tm = GetTime()
	local tdiff = tm - self.SendTime

	if tdiff < .2 then	-- Never go faster than this
		return
	end

	-- Handle AFK

	if UnitIsAFK ("player") then
		if not self.AFK then
			self:UpdateChannels()
		end
		self.AFK = true

	else
		if self.AFK then
			self:UpdateChannels()
		end
		self.AFK = nil
	end

	-- Position send

	local map = Nx.Map:GetMap (1)

	local delay = 10

	if self.PlyrChange then
		if not UnitOnTaxi ("player") then
			delay = 3.1
		end
	end

	if Nx.InCombat then
		delay = map.InstanceId and 4.5 or 2.2
	end

	delay = delay * self.SendRate

	if bgmap then
		delay = 25
	end

	if self.AFK then
		delay = 120
	end

	if next (self.Punks) then	-- Have a punk? Override all times
		delay = min (6, delay)
	end

--	Nx.prt ("send delay %s", delay)

	if tm - self.SendPosTime >= delay then

		self.SendPosTime = tm
		self.PlyrChange = false		-- Reset

		local flgs = 0

		-- Player info

		if Nx.InCombat then
			flgs = 1
		end

		local x, y = GetPlayerMapPosition ("player")

		if x ~= 0 or y ~= 0 then
			self.PlyrMapId = map:GetCurrentMapId()
			self.PlyrX = x
			self.PlyrY = y + max (GetCurrentMapDungeonLevel(), 1) - 1		-- 0 to 1 + dlvl
		else
			if map.InstanceId then
				self.PlyrMapId = map.InstanceId
				if not Nx.Map.InstanceInfo[self.PlyrMapId] then
					self.PlyrX = 0
					self.PlyrY = 0
				end
			end
		end

		x = max (min (self.PlyrX,  .999), 0) * 0xfff
		y = max (min (self.PlyrY, 9.999), 0) * 0xfff

		local h = UnitHealth ("player")
		if UnitIsDeadOrGhost ("player") then
			h = 0
		end
		local hm = UnitHealthMax ("player")
		local hper = h / hm * 20
		if hper > 0 then
			hper = max (hper, 1)
		end
		hper = floor (hper + .5)

		local plyrLvl = min (UnitLevel ("player"), 90)	-- 93 or above makes 0x80+ illegal chat char

		-- Target info

		local tStr = ""
		if targetName then

			flgs = flgs + 2	-- Have target

			local tType = 5
			if UnitIsFriend ("player", "target") then
				tType = 1
			else
				if UnitIsPlayer ("target") then
					tType = 2
				elseif UnitIsEnemy ("player", "target") then
					tType = 3
					if Nx:UnitIsPlusMob ("target") then
						tType = 4
					end
				end
			end

			local tLvl = min (UnitLevel ("target"), 90)	-- 93 or above makes 0x80+ illegal chat char
--			Nx.prt ("%s", tLvl)
			local _, tCls = UnitClass ("target")	-- Non localized uppercase version
			tCls = self.ClassNames[tCls] or 0

			local h = UnitHealth ("target")
			if UnitIsDeadOrGhost ("target") then
				h = 0
			end
			local hm = max (UnitHealthMax ("target"), 1)
			local hper = h / hm * 20
			if hper > 0 then			-- Alive?
				hper = max (hper, 1)
			end
			hper = min (floor (hper + .5), 20)

--			Nx.prt ("THealth %s", hper)

			-- tLvl will cause a "\" at lvl 57 which could form a bad escape char with tCls

			tStr = format ("%c%c%c%c%c%s", tType+35, tLvl+35, tCls+35, hper+35, #targetName+35, targetName)
		end

		local qStr, qFlg = Nx.Quest:BuildComSend()
		flgs = flgs + qFlg	-- 0 or 4

		-- Punks info

		local enStr = ""

		if next (self.Punks) then

			for name, lvl in pairs (self.Punks) do

--				enStr = enStr .. format ("%2x%s!", lvl, name)	-- Old, sends 0xffffffff for -1 level
				enStr = enStr .. format ("%2x%s!", lvl >= 0 and lvl or 0, name)
				if #enStr > 50 then
					break
				end
			end

			self.Punks = {}
			self.SendZSkip = 1	-- So we get sent to zone for sure

			flgs = flgs + 8

			enStr = strchar (#enStr - 1 + 35) .. strsub (enStr, 1, -2)

--			Nx.prt ("En: %s", enStr)
		end
--[[
		Nx.prt ("tStr '%s'", tStr)
		Nx.prt ("qStr '%s'", qStr)
		Nx.prt ("enStr '%s'", enStr)
--]]
		-- Send

		self:SendPals (format ("S%c%4x%3x%4x%c%c%c%s%s%s",
			  flgs+35, self.PlyrMapId, x, y, hper+48, plyrLvl+35, self.PlyrClassI+35, tStr, qStr, enStr))
	end

	-- Check for pals message

	if not self.PalsSendMsg then

		if #self.PalsSendQ > 0 then

			self.PalsSendMsg = self.PalsSendQ[1]
			self.PalsSendQ[1] = nil

			for n = 2, #self.PalsSendQ do
				self.PalsSendMsg = self.PalsSendMsg .. "\t" .. self.PalsSendQ[n]
				self.PalsSendQ[n] = nil
--				table.remove (self.PalsSendQ, 1)
			end

			self.PosSendNext = -2
		end
	end

	-- Send pals the next message

	if tdiff >= .25 then

		local msg = self.PalsSendMsg

		if msg then

			self.PosSendNext = self.PosSendNext + 1

			if self.PosSendNext > #self.Friends then

				-- Reset now that guild and all friends are sent

				self.PosSendNext = -2
				self.PalsSendMsg = nil

			else
				if self.PosSendNext == -1 then

					if bit.band (self.SendPMask, 2) > 0 then
						self:Send ("g", msg)
					end

				elseif self.PosSendNext == 0 then

					if self.SendChanQ[1] == nil and not bgmap and not Nx:FindActiveChatFrameEditBox() then
--					if self.SendChanQ[1] == nil and not bgmap and not ChatFrameEditBox:IsVisible() then

						if bit.band (self.SendPMask, 4) > 0 then

							local sk = self.SendZSkip - 1		-- Zone skipped to reduce rate

							if sk < 1 then
								sk = 4
								self:Send ("Z", msg)

								Nx.Quest.QLastChanged = nil	-- Now that zone has it kill it
							end

							self.SendZSkip = sk
						end
					end

				else

					if bit.band (self.SendPMask, 1) > 0 then
						self:Send ("W", msg, self.Friends[self.PosSendNext])
					end
				end

				self.SendTime = tm
			end
		end
	end

	-- Send numbered channel queue

	if Nx:FindActiveChatFrameEditBox() then

		Nx.Com.SendChanTime = tm		-- Reset time

	else
		if tm - self.SendChanTime >= .5 then

			if self.SendChanQ[1] then

				local data = self.SendChanQ[1]
				tremove (self.SendChanQ, 1)

				self.SentBytes = self.SentBytes + #data.Msg + 54 + 20	-- Packet overhead + some WOW overhead

				self:SendChatMessageFixed (data.Msg, "CHANNEL", data.ChanNum)

				self.SendChanTime = tm
			end
		end
	end

--[[
	for n = 1, #self.SendQ do

		local q = self.SendQ[n]

		self.SendTime = tm
	end
--]]
end

--------
-- Update map icons (called by map)

function Nx.Com:UpdateIcons (map)

	if Nx.Tick % 20 == 1 then

		local memberNames = {}
		self.MemberNames = memberNames

		local members = MAX_PARTY_MEMBERS
		local unitName = "party"

		if IsInRaid() then
			members = MAX_RAID_MEMBERS
			unitName = "raid"
		end

		local mapId = map.MapId
		local palsInfo = self.PalsInfo

		for n = 1, members do

			local unit = unitName .. n
			local name = UnitName (unit)
			if name then

				local x, y = GetPlayerMapPosition (unit)
				if x ~= 0 or y ~= 0 then
					memberNames[name] = 1

				else
					local info = palsInfo[name]
					if info and info.EntryMId == mapId then
						memberNames[name] = 1
					end
				end
			end
		end
	end

	--

	local alt = IsAltKeyDown()
	if alt then
		map.Level = map.Level + 3
	end

	local opts = Nx:GetGlobalOpts()

	self.TrackX = nil

	if map:GetWorldZone (map.RMapId).City then

		if opts["MapShowOthersInCities"] then
			self:UpdatePlyrIcons (self.ZPInfo, map, "IconPlyrZ")
		end

		if opts["MapShowPalsInCities"] then
			self:UpdatePlyrIcons (self.PalsInfo, map, "IconPlyrG")
		end

	else
		if opts["MapShowOthersInZ"] then
			self:UpdatePlyrIcons (self.ZPInfo, map, "IconPlyrZ")
		end
		self:UpdatePlyrIcons (self.PalsInfo, map, "IconPlyrG")
	end

	if alt then
		map.Level = map.Level - 3
	end

	return self.TrackName, self.TrackX, self.TrackY
end

--------
-- Update icons

function Nx.Com:UpdatePlyrIcons (info, map, iconName)

	local memberNames = self.MemberNames
	local idToName = Nx.MapIdToName
	local alt = IsAltKeyDown()
	local redGlow = abs (GetTime() * 400 % 200 - 100) / 200 + .5
	local inBG = Nx.InBG

	local t = GetTime()
	local showTargetText = not Nx.Free

	for name, pl in pairs (info) do

--		Nx.prt ("%s", name)

		if t - pl.T > 35 then
			info[name] = nil
--			Nx.prt ("Com del plyr %s", name)

		elseif not memberNames[name] and (not inBG or map.MapId ~= pl.MId) and pl.Y then		-- Y can be nil somehow

			local mapId = pl.MId
			local wx, wy = map:GetWorldPos (mapId, pl.X, pl.Y)

--			Nx.prt ("%f %f", wx, wy)

			local sz = 14 * map.DotZoneScale

			if self.PalNames[name] ~= nil then
				sz = 17 * map.DotPalScale
			end

			if map.TrackPlyrs[name] then
				sz = 22 * map.DotPalScale
				self.TrackName = name
				self.TrackX, self.TrackY = wx, wy
			end

			local f = map:GetIcon()

			if map:ClipFrameW (f, wx, wy, sz, sz, 0) then

				f.NXType = 1000
				f.NXData2 = name

				local mapName = idToName[mapId] or "?"
				local tStr = pl.TStr or ""
				local qStr = pl.QStr or ""
				f.NxTip = format ("%s\n  %s (%d,%d)%s%s", pl.Tip, mapName, pl.X, pl.Y, tStr, qStr)

				local txName = iconName

				if self.PalNames[name] == false then
					txName = "IconPlyrF"
				end

				if bit.band (pl.F, 1) > 0 then	-- In combat?
					txName = txName .. "C"
				end

				f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\"..txName)

				if alt then
					-- tStr has \n
					local s = pl.TType == 2 and showTargetText and (name .. tStr) or name
					local txt = map:GetText (s)
					map:MoveTextToIcon (txt, f, 15, 1)
				end
			end

			-- Show health
--PAIDS!
			if pl.Health then		-- No health if from Cartographer

				f = map:GetIconNI (1)
				local per = pl.Health / 100

				if per >= .33 then

					local sc = map.ScaleDraw
					map:ClipFrameTL (f, wx - 8 / sc, wy - 8 / sc, 14 * per / sc, 1 / sc)
					f.texture:SetTexture (1, 1, 1, 1)

				else
					map:ClipFrameW (f, wx, wy, 8, 8, 0)

					if per > 0 then
						f.texture:SetTexture (1, .1, .1, 1 - per * 2)
					else
						f.texture:SetTexture (0, 0, 0, .5)
					end
				end

				local tt = pl.TType

				if tt then		-- Target?

					local per = pl.TH / 100

					local f = map:GetIconNI (1)
					local sc = map.ScaleDraw

					if tt == 1 then
						-- Horizontal green bar
						map:ClipFrameTL (f, wx - 8 / sc, wy - 2 / sc, 14 * per / sc, 1 / sc)
						f.texture:SetTexture (0, 1, 0, 1)

					else	-- Vertical bar

						map:ClipFrameTL (f, wx - 8 / sc, wy - 7 / sc, 1 / sc, 13 * per / sc)

						if tt == 2 then
							f.texture:SetTexture (redGlow, .1, 0, 1)
						elseif tt == 3 then
							f.texture:SetTexture (1, 1, 0, 1)
						elseif tt == 4 then
							f.texture:SetTexture (1, .4, 1, 1)
						else
							f.texture:SetTexture (.7, .7, 1, 1)
						end
					end
				end
			end
--PAIDE!
		end
	end
end

function Nx.Com:GetPlyrQStr (name)

	local info = self.PalsInfo[name] or self.ZPInfo[name]
	return info and info.QStr
end

--------
-- Show newer version message

function Nx.Com:ShowVersionMsg()
--[[
	local pop = StaticPopupDialogs["NxVerMsg"]

	if not pop then

		pop = {
		  ["button1"] = "OK",
		  ["timeout"] = 0,
		  ["whileDead"] = 1,
		  ["hideOnEscape"] = 1
		}

		StaticPopupDialogs["NxVerMsg"] = pop
	end

	pop["text"] = format ("A newer CARBONITE version has been detected.")

	StaticPopup_Show ("NxVerMsg")
--]]    
	local verstemp, verstemp2 = math.modf(Nx.NEWVER * 10)
	verstemp = verstemp / 10
	verstemp2 = verstemp2 * 100
	local s1 = format (L["version %s.%s of %s is available"], verstemp, verstemp2, NXTITLEFULL)
	local s2 = format (L["Visit %s%s|cffffffff for an update"], Nx.TXTBLUE, Nx.WebSite)
	UIErrorsFrame:AddMessage (s2, 1, 1, 1, 1)	-- Flip order so it show correctly
	UIErrorsFrame:AddMessage (s1, 1, 1, 0, 1)
	Nx.prt (s1)
	Nx.prt (s2)	
end

--------
-- Show version data from player

function Nx.Com:ShowPlyrVersion (name)

	self:SendSecW ("V?", "", name)		-- Ask for it
end

--------
-- Handle version messages

function Nx.Com:OnMsgVersion (name, enmsg, arg2, arg9)

	-- Header is VxCC

	local msg = self:Decode (enmsg)

--	Nx.prt ("Ver %s", msg)

	if self:IsChksumOK (msg) then

		local subType = strsub (msg, 2, 2)

		if subType == " " then	-- Global version?

			local ver, r, c, dt, ver1, qCnt = strsplit ("^", msg)

			ver = tonumber (strsub (ver, 5))
			if ver then

				if Nx.VERMINOR <= 0 then	-- Not test?

					local vermajor = floor (ver * 1000) / 1000
					local verminor = ver - vermajor

--					if verminor > 0 then		-- Is test?
--						return					-- Ignore
--					end
				end

--				ver = ver + 9	-- Test the message				
				if ver - .0000001 > Nx.VERSION and not self.NewVerMsg then
					Nx.NEWVER = ver
					self.NewVerMsg = true
					Nx.Timer:Start ("ComShowVer", 60, self, self.ShowVerTimer)

--					local s = format ("%s Ver %f > %f", arg2, ver, Nx.VERSION)
--					Nx.prt (s)
				end

				-- Is arg2 always correct?? Look at the 2 callers??

				self.List:AddInfo ("C:"..arg9, format ("(%s) ver %s", arg2, ver))

				self:RcvVersion (name, msg)
			end

		elseif subType == "?" then		-- Request?

			local str = self:MakeVersionMsg()
			self:SendSecW ("V!", str, name)		-- Reply

		elseif subType == "!" then		-- Reply?

			self:RcvVersion (name, msg)
		end

	else

		if NxData.DebugCom then
			Nx.prt (L["Ver chksum fail %s"], msg)
		end
	end
end

--------
-- 

function Nx.Com:RcvVersion (name, msg)

	if NxData.NXVerDebug then

		local ver, r, c, dt, ver1, qCnt, lvl, mapId = strsplit ("^", msg)
		ver = tonumber (strsub (ver, 5))
		lvl = tonumber (lvl or 0, 16)
		mapId = tonumber (mapId or 0, 16)

		Nx.prt (L["Ver %s %s (%s) %s %s %s Q%s L%s %s"], name, ver, ver1 or "", r, c, dt, qCnt or "", lvl, mapId)

		if ver >= 1.6 then

			self.VerPlayers[name] = msg
			Nx.Social.List:Update()
		end
	end
end

--------
-- Bug user with update

function Nx.Com:ShowVerTimer()

	if UnitAffectingCombat ("player") or UnitIsAFK ("player") then
--		Nx.prt ("ShowVerTimer delay")
		return 5
	end

	local lasttm = NxData.NXVerT
	local tm = time()

--	Nx.prt ("ShowVerTimer %s %s = %s", lasttm or 0, tm, difftime (tm, lasttm or 0))

	if not lasttm or difftime (tm, lasttm) > 4 * 3600 then	-- Hours since last message?

		local map = Nx.Map:GetMap (1)
		if map.InstanceId then
--			Nx.prt ("ShowVerTimer Instance")
			return 60
		end

		NxData.NXVerT = tm
		self:ShowVersionMsg()
	end

	return 60
end

--------

function Nx.Com:GetUserVer()

	self.VerPlayers = {}
	Nx.Timer:Start ("ComGetUserVer", 0, self, self.GetUserVerTimer)
end

--------

function Nx.Com:GetUserVerTimer()

	for n = 1, GetNumDisplayChannels() do

		local chname, header, collapsed, chanNumber, plCnt, active, category, voiceEnabled, voiceActive = GetChannelDisplayInfo (n)

		if not header then

			if chname == "General" then
				SetSelectedDisplayChannel (n)	-- Force roster update
			end

--			Nx.prt ("Chan %s (%s) Cnt %s", chname or "nil", n, plCnt or "nil")

			local s1 = strfind (strlower (chname), "^crbb")
			if s1 then
				SetSelectedDisplayChannel (n)
				self.GettingVersion = true
				return
			end
		end
	end

	local s = "crbb1"
	Nx.prt (L["Joining %s"], s)
	JoinChannelByName (s)

	return 2
end

function Nx.Com:OnChannel_roster_update (event, arg1, arg2)

	local self = Nx.Com

	if not self.GettingVersion then
		return
	end

	Nx.prt ("OnChannel_roster_update %s, %s", arg1, arg2 or "nil")

	local n = arg1
	local chname, header, collapsed, chanNumber, plCnt, active, category, voiceEnabled, voiceActive = GetChannelDisplayInfo (n)

	if not header then

		Nx.prt (L["Chan %s (%s) Cnt %s"], chname or "nil", n, plCnt or "nil")

		local s1 = strfind (strlower (chname), "^crbb")
		if s1 then

			if plCnt then

				self.GettingVersion = false

				Nx.prt (L["Found %s %s (%s)"], chname, plCnt, n)

				local names = {}

				for n2 = 1, plCnt do
					local plName, owner, moderator, muted, active, enabled = GetChannelRosterInfo (n, n2)
					if plName ~= UnitName ("player") then
						tinsert (names, plName)
					end
				end

				self.GetUserVerNames = names
				self.GetUserVerI = 1

				Nx.Timer:Start ("GetUserVer", 0, self, self.OnGetUserVerTimer)
			end
		end
	end
end

function Nx.Com:OnGetUserVerTimer()

	local i = self.GetUserVerI

	if i <= #self.GetUserVerNames then

		local plName = self.GetUserVerNames[i]
--		Nx.prt (" %s", plName)

		self:SendSecW ("V?", "", plName)		-- Ask for it

		self.GetUserVerI = i + 1

		return .1
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Com message list

--------
-- Open and init or toggle Com frame

function Nx.Com.List:Open()
end

------
-- Add info to list

function Nx.Com.List:AddInfo (type, name)
end

--------
-- Update list

function Nx.Com.List:Update()

	if not self.Opened then
		return
	end

	-- Title

	self.Win:SetTitle (format (L["Com %d Bytes sec %d"], #self.Sorted, Nx.Com.SentBytesSec or 0))

	-- List

	local list = self.List

	local isLast = list:IsShowLast()

	list:Empty()

	for k, v in pairs (self.Sorted) do

		list:ItemAdd()
		list:ItemSet (1, date ("%d %H:%M:%S", v.Time))
		list:ItemSet (2, v.Type)
		list:ItemSet (3, v.Name)
	end

	list:Update (isLast)
end

--------
-- Sort compare

function Nx.Com.List.SortCmp (v1, v2)
	return v1.Time < v2.Time
end

--------

function Nx.Com.List:Sort()

	local rcv = Nx.Com.Data.Rcv

	self.Sorted = {}

	local t = self.Sorted
	local i = 1
	for k, v in pairs (rcv) do
		t[i] = v
		i = i + 1
	end

	sort (self.Sorted, self.SortCmp)
end

-------------------------------------------------------------------------------
--EOF

















