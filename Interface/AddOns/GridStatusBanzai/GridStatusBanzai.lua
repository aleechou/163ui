local L = setmetatable({}, {__index = function(t, k) t[k] = k return k end})

if GetLocale()=="zhCN" then
	L["Banzai alert"] = "怪物目标"
	L["Banzai incoming spell"] = "怪物施法目标"
end
if GetLocale()=="zhTW" then
	L["Banzai alert"] = "怪物目標"
	L["Banzai incoming spell"] = "怪物施法目標"
end
if GetLocale()=="ruRU" then
	L["Banzai alert"] = "Цель врага"
	L["Banzai incoming spell"] = "Цель заклинания"
end

local GridRoster = Grid:GetModule("GridRoster")

GridStatusBanzai = Grid:GetModule("GridStatus"):NewModule("GridStatusBanzai", "AceTimer-3.0")
GridStatusBanzai.menuName = L["Banzai alert"]

--{{{ AceDB defaults


GridStatusBanzai.defaultDB = {
	interval = 0.1,
	debug = false,
	alert_banzai = {
		text =  "!!",
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1 },
		priority = 98,
		range = false,
	},
	alert_banzai_incoming = {
		text =  "->",
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1 },
		priority = 98,
		range = false,
	},
}

--}}}

GridStatusBanzai.options = false

function GridStatusBanzai:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("alert_banzai", L["Banzai alert"], nil, true)
	self:RegisterStatus("alert_banzai_incoming", L["Banzai incoming spell"], nil, true)
end

local spellstarts = {}      --save spell casting event, [CastingNpcGUID] -> { spellnames, channeling }.
local incomings =   {}      --save incomings on raid members, [RosterGUID] -> { t = timeLeft, m = CastingNpcGUID }
local castings =    {}      --revert map of incomings, always match, [CastingNpcGUID] -> RosterGUID

function GridStatusBanzai:IsHostileNpcUnit(guid, flag)
	--return true
	--flag == 0x1248
	--local bit3 = string.byte(guid, 5) if( bit3==51 or bit3==66 ) then return true end
	return not GridRoster:IsGUIDInRaid(guid)
end

function GridStatusBanzai:COMBAT_LOG_EVENT_UNFILTERED(b, timestamp, event, hideCaster, sid, sname, sflag, srflag, tid, tname, tflag, trflag, spellid)
	if event=="SPELL_CAST_START" or event=="SPELL_CAST_SUCCESS" then
		if self:IsHostileNpcUnit(sid, sflag) then
			spellstarts[sid] = { GetSpellInfo(spellid), event=="SPELL_CAST_SUCCESS" } --save spell name for next checking target of the caster GUID
		end
	elseif event=="SPELL_INTERRUPT" then
		self:TryToStop(tid)
	elseif event=="UNIT_DIED" then
		self:TryToStop(tid)
	end
end

function GridStatusBanzai:TryToStop(npcguid)
	if(castings[npcguid]) then
		GridStatusBanzai.core:SendStatusLost(castings[npcguid],"alert_banzai_incoming")
		incomings[castings[npcguid]] = nil
		castings[npcguid]=nil
	end
end

function GridStatusBanzai:UnitCastStop(unitid, name, rank)
	self:TryToStop(UnitGUID(unitid))
end

function GridStatusBanzai:ResetVariables()
	spellstarts = {}
	for guid, v in pairs(castings) do
		self:TryToStop(guid)
	end
end


function GridStatusBanzai:OnStatusEnable(status)
	--thanks onyxmaster for finding a way to make alert_banzai_incoming independent.
	if (status=="alert_banzai_incoming" or status=="alert_banzai") then
		if not GridStatusBanzai.timer then 
			GridStatusBanzai.timer = self:ScheduleRepeatingTimer("OnUpdate", GridStatusBanzai.db.profile.interval);
		end

		if (status=="alert_banzai_incoming") then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UnitCastStop") --caster stop manually, only for players.
			self:RegisterEvent("UNIT_SPELLCAST_STOP", "UnitCastStop")
			self:RegisterEvent("PLAYER_REGEN_DISABLED", "ResetVariables");
			self:RegisterEvent("PLAYER_REGEN_ENABLED", "ResetVariables");
		end
	end
end

function GridStatusBanzai:OnStatusDisable(status)

	if (status=="alert_banzai" or status=="alert_banzai_incoming") then
		if not GridStatusBanzai.db.profile["alert_banzai"].enable and not GridStatusBanzai.db.profile["alert_banzai_incoming"].enable then
			if GridStatusBanzai.timer then 
				self:CancelTimer(GridStatusBanzai.timer) 
				GridStatusBanzai.timer = nil;
			end
		end

		if (status=="alert_banzai_incoming") then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP") --caster stop manually, only for players.
			self:UnregisterEvent("UNIT_SPELLCAST_STOP")
			self:UnregisterEvent("PLAYER_REGEN_DISABLED");
			self:UnregisterEvent("PLAYER_REGEN_ENABLED");
		end
	end
end

local newcount = {}

--cache for string concat, learn from LibBanzai
local targets = setmetatable({}, {__index = function(self, key) self[key] = key .. "target" return self[key] end})

function GridStatusBanzai:OnUpdate()
	for guid, v in pairs(incomings) do
		v.time = v.time-GridStatusBanzai.db.profile.interval
		if(v.time<=0)then
			GridStatusBanzai.core:SendStatusLost(guid,"alert_banzai_incoming")
			castings[incomings[guid].npc]=nil
			incomings[guid]=nil
		end
	end

	table.wipe(newcount)

	self:UpdateUnit("focus")
	self:UpdateUnit("mouseover")
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit(targets[unitid])
	end

	if (GridStatusBanzai.db.profile["alert_banzai"].enable) then
		for guid, unitid in GridRoster:IterateRoster() do
			if(newcount[guid]) then
				local settings = GridStatusBanzai.db.profile.alert_banzai
				GridStatusBanzai.core:SendStatusGained(
					guid,
					"alert_banzai",
					settings.priority,
					(settings.range and 40),
					settings.color,
					settings.text,
					nil,
					nil,
					settings.icon
				)
			else
				GridStatusBanzai.core:SendStatusLost(guid, "alert_banzai")
			end
		end
	end
end

local invest = GetSpellInfo(70541)
local _, _, invest_icon = GetSpellInfo(528)

function GridStatusBanzai:UpdateUnit(npcunit)
	local spell, _, _, icon, startTime, endTime
	local npcguid = UnitGUID(npcunit)
	if( npcguid and self:IsHostileNpcUnit(npcguid) ) then
		local guid = UnitGUID(targets[npcunit])
		if guid and GridRoster:IsGUIDInRaid(guid) then
			newcount[guid]=true

			local starts = spellstarts[npcguid]
			if(starts) then
				spellstarts[npcguid]=nil
				if(starts[2]) then
					spell, _, _, icon, startTime, endTime = UnitChannelInfo(npcunit)
				else
					spell, _, _, icon, startTime, endTime = UnitCastingInfo(npcunit)
				end
				if(spell and spell==starts[1]) then
					if(spell==invest) then icon = invest_icon end
					incomings[guid]={ 
						time = endTime/1000-GetTime(), 
						npc = npcguid 
					}
					castings[npcguid] = guid

					local settings = GridStatusBanzai.db.profile.alert_banzai_incoming
					GridStatusBanzai.core:SendStatusGained(
						guid,
						"alert_banzai_incoming",
						settings.priority,
						(settings.range and 40),
						settings.color,
						settings.text,
						nil,
						nil,
						icon,
						startTime/1000,
						(endTime-startTime)/1000
					)
				end
			end
		end
	end
end