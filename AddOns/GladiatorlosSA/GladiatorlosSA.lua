GladiatorlosSA = LibStub("AceAddon-3.0"):NewAddon("GladiatorlosSA", "AceEvent-3.0","AceConsole-3.0","AceTimer-3.0")

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GladiatorlosSA")
local LSM = LibStub("LibSharedMedia-3.0")
local self, GSA = GladiatorlosSA, GladiatorlosSA
local GSA_TEXT = "GladiatorlosSA"
local GSA_VERSION = " v2.0.5"
local GSA_AUTHOR = " updated by superk"

local GSA_LOCALEPATH = {
	enUS = "GladiatorlosSA\\Voice_enUS",
	zhTW = "GladiatorlosSA\\Voice",
	zhCN = "GladiatorlosSA\\Voice"
}
self.GSA_LOCALEPATH = GSA_LOCALEPATH
local GSA_LANGUAGE = {
	["GladiatorlosSA\\Voice"] = L["Chinese(female)"],
--	["GladiatorlosSA\\Voice_enUS"] = L["English(female)"],
}
self.GSA_LANGUAGE = GSA_LANGUAGE
local GSA_EVENT = {
	SPELL_CAST_SUCCESS = L["Spell cast success"],
	SPELL_CAST_START = L["Spell cast start"],
	SPELL_AURA_APPLIED = L["Spell aura applied"],
	SPELL_AURA_REMOVED = L["Spell aura removed"],
	SPELL_INTERRUPT = L["Spell interrupt"],
	SPELL_SUMMON = L["Spell summon"]
	--UNIT_AURA = "Unit aura changed",
}
self.GSA_EVENT = GSA_EVENT
local GSA_UNIT = {
	any = L["Any"],
	player = L["Player"],
	target = L["Target"],
	focus = L["Focus"],
	mouseover = L["Mouseover"],
	--party = L["Party"],
	--raid = L["Raid"],
	--arena = L["Arena"],
	--boss = L["Boss"],
	custom = L["Custom"], 
}
self.GSA_UNIT = GSA_UNIT
local GSA_TYPE = {
	[COMBATLOG_FILTER_EVERYTHING] = L["Any"],
	[COMBATLOG_FILTER_FRIENDLY_UNITS] = L["Friendly"],
	[COMBATLOG_FILTER_HOSTILE_PLAYERS] = L["Hostile player"],
	[COMBATLOG_FILTER_HOSTILE_UNITS] = L["Hostile unit"],
	[COMBATLOG_FILTER_NEUTRAL_UNITS] = L["Neutral"],
	[COMBATLOG_FILTER_ME] = L["Myself"],
	[COMBATLOG_FILTER_MINE] = L["Mine"],
	[COMBATLOG_FILTER_MY_PET] = L["My pet"],
}
self.GSA_TYPE = GSA_TYPE
local sourcetype,sourceuid,desttype,destuid = {},{},{},{}
local gsadb
local PlaySoundFile = PlaySoundFile
local dbDefaults = {
	profile = {
		all = false,
		arena = true,
		battleground = false,
		field = false,
		path = GSA_LOCALEPATH[GetLocale()] or "GladiatorlosSA\\Voice",
--		path = "GladiatorlosSA\\Voice",
		throttle = 0,
		smartDisable = true,
		
		
		aruaApplied = false,
		aruaRemoved = false,
		castStart = false,
		castSuccess = false,
		interrupt = false,
		
		aonlyTF = false,
		conlyTF= false,
		sonlyTF = false,
		ronlyTF = false,
		drinking = true,
		class = false,

		archangel = false,
		--vendetta = false,
		--desperatePrayer = false,
		--redirect = false,
		freezingTrap = false,
		battlestance = false,
		defensestance = false,
		chakraChastise = false,
		chakraSanctuary = false,
		chakraSerenity = false,
		berserkerstance = false,
		entanglingRoots = false,
		sMassDispell = false,
		massDispell = false,
		sEntanglingRoots = false,
		waterShield = false,
		lichborneDown = false,
		iceboundFortitudeDown = false,
		skullBanner = false,
		mockingBanner = false,
		demoralizingBanner = false,
		totemicProjection = false,
		wildCharge = false,
		bindElemental = false,
		rushingJadeWind = false,
		paralysis = false,
		manaTea = false,
		sBarkskin = false,
		custom = {},
	}	
}

GSA.log = function(msg) DEFAULT_CHAT_FRAME:AddMessage("|cFF33FF22GladiatorlosSA|r: "..msg) end

function GladiatorlosSA:OnInitialize()
	if not self.spellList then
		self.spellList = self:GetSpellList()
	end
	for _,v in pairs(self.spellList) do
		for _,spell in pairs(v) do
			if dbDefaults.profile[spell] == nil then dbDefaults.profile[spell] = true end
		end
	end
	
	self.db1 = LibStub("AceDB-3.0"):New("GladiatorlosSADB",dbDefaults, "Default");
	--DEFAULT_CHAT_FRAME:AddMessage(GSA_TEXT .. GSA_VERSION .. GSA_AUTHOR .."  - /gsa ");
	--LibStub("AceConfig-3.0"):RegisterOptionsTable("GladiatorlosSA", GladiatorlosSA.Options, {"GladiatorlosSA", "SS"})
	self:RegisterChatCommand("GladiatorlosSA", "ShowConfig")
	self:RegisterChatCommand("gsa", "ShowConfig")
	self.db1.RegisterCallback(self, "OnProfileChanged", "ChangeProfile")
	self.db1.RegisterCallback(self, "OnProfileCopied", "ChangeProfile")
	self.db1.RegisterCallback(self, "OnProfileReset", "ChangeProfile")
	gsadb = self.db1.profile
	local options = {
		name = "GladiatorlosSA",
		desc = L["PVP Voice Alert"],
		type = 'group',
		args = {},
	}
	local bliz_options = CopyTable(options)
	bliz_options.args.load = {
		name = L["Load Configuration"],
		desc = L["Load Configuration Options"],
		type = 'execute',
		func = function()
			self:OnOptionCreate()
			bliz_options.args.load.disabled = true
			GameTooltip:Hide()
			--fix for in 5.3 BLZOptionsFrame can't refresh on load
			InterfaceOptionsFrame:Hide()
			InterfaceOptionsFrame:Show()
		end,
		handler = GladiatorlosSA,
	}
	LibStub("AceConfig-3.0"):RegisterOptionsTable("GladiatorlosSA_bliz", bliz_options)
	AceConfigDialog:AddToBlizOptions("GladiatorlosSA_bliz", "GladiatorlosSA")
end
function GladiatorlosSA:OnEnable()
	GladiatorlosSA:RegisterEvent("PLAYER_ENTERING_WORLD")
	GladiatorlosSA:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	GladiatorlosSA:RegisterEvent("UNIT_AURA")
	if not GSA_LANGUAGE[gsadb.path] then gsadb.path = GSA_LOCALEPATH[GetLocale()] end
	self.throttled = {}
	self.smarter = 0
end

function GladiatorlosSA:OnDisable()

end

-- play sound by file name
function GSA:PlaySound(fileName, extend)
	PlaySoundFile("Interface\\Addons\\"..gsadb.path.."\\"..fileName .. "." .. (extend or "ogg"), "Master")
end

function GladiatorlosSA:ArenaClass(id)
	for i = 1 , 5 do
		if id == UnitGUID("arena"..i) then
			return select(2, UnitClass ("arena"..i))
		end
	end
end

function GladiatorlosSA:PLAYER_ENTERING_WORLD()
	--CombatLogClearEntries()
end

-- play sound by spell id and spell type
function GladiatorlosSA:PlaySpell(listName, spellID, ...)
	local list = self.spellList[listName]
	if not list[spellID] then return end
	if not gsadb[list[spellID]] then return	end
	if gsadb.throttle ~= 0 and self:Throttle("playspell",gsadb.throttle) then return end
	if gsadb.smartDisable then
		if (GetNumGroupMembers() or 0) > 20 then return end
		if self:Throttle("smarter",20) then
			self.smarter = self.smarter + 1
			if self.smarter > 30 then return end
		else 
			self.smarter = 0
		end
	end
	self:PlaySound(list[spellID]);
end
function GladiatorlosSA:COMBAT_LOG_EVENT_UNFILTERED(event , ...)
	local _,currentZoneType = IsInInstance()
	if (not ((currentZoneType == "none" and gsadb.field) or (currentZoneType == "pvp" and gsadb.battleground) or (currentZoneType == "arena" and gsadb.arena) or gsadb.all)) then
		return
	end
	local timestamp,event,hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellID,spellName= select ( 1 , ... );
	if not GSA_EVENT[event] then return end
	--print(sourceName,destName,destFlags,event,spellName,spellID)
	if (destFlags) then
		for k in pairs(GSA_TYPE) do
			desttype[k] = CombatLog_Object_IsA(destFlags,k)
			--log("desttype:"..k.."="..(desttype[k] or "nil"))
		end
	else
		for k in pairs(GSA_TYPE) do
			desttype[k] = nil
		end
	end
	if (destGUID) then
		for k in pairs(GSA_UNIT) do
			destuid[k] = (UnitGUID(k) == destGUID)
			--log("destuid:"..k.."="..(destuid[k] and "true" or "false"))
		end
	else
		for k in pairs(GSA_UNIT) do
			destuid[k] = nil
			--log("destuid:"..k.."="..(destuid[k] and "true" or "false"))
		end
	end
	destuid.any = true
	if (sourceFlags) then
		for k in pairs(GSA_TYPE) do
			sourcetype[k] = CombatLog_Object_IsA(sourceFlags,k)
			--log("sourcetype:"..k.."="..(sourcetype[k] or "nil"))
		end
	else
		for k in pairs(GSA_TYPE) do
			sourcetype[k] = nil
			--log("sourcetype:"..k.."="..(sourcetype[k] or "nil"))
		end
	end
	if (sourceGUID) then
		for k in pairs(GSA_UNIT) do
			sourceuid[k] = (UnitGUID(k) == sourceGUID)
			--log("sourceuid:"..k.."="..(sourceuid[k] and "true" or "false"))
		end
	else
		for k in pairs(GSA_UNIT) do
			sourceuid[k] = nil
			--log("sourceuid:"..k.."="..(sourceuid[k] and "true" or "false"))
		end
	end
	sourceuid.any = true
	--print (destuid.target,sourceName,destName)
	--[[debug
	if (spellID == 80964 or spellID == 80965 or spellID == 85285) then 
		print (sourceName,destName,event,spellName,spellID)
	end
	enddebug]]--
	if (event == "SPELL_AURA_APPLIED" and desttype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and (not gsadb.aonlyTF or destuid.target or destuid.focus) and not gsadb.aruaApplied) then
		self:PlaySpell("auraApplied", spellID)
	elseif (event == "SPELL_AURA_REMOVED" and desttype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and (not gsadb.ronlyTF or destuid.target or destuid.focus) and not gsadb.auraRemoved) then
		self:PlaySpell("auraRemoved", spellID)
	elseif (event == "SPELL_CAST_START" and sourcetype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and (not gsadb.conlyTF or sourceuid.target or sourceuid.focus) and not gsadb.castStart) then
		self:PlaySpell("castStart", spellID)
	elseif ((event == "SPELL_CAST_SUCCESS" or event == "SPELL_SUMMON") and sourcetype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and (not gsadb.sonlyTF or sourceuid.target or sourceuid.focus) and not gsadb.castSuccess) then
		if self:Throttle(tostring(spellID).."default", 0.05) then return end
		if (spellID == 42292 or spellID == 59752) and gsadb.class and currentZoneType == "arena" then
			local c = self:ArenaClass(sourceGUID)
			if c then 
				self:PlaySound(c);
			end
		else	
			self:PlaySpell("castSuccess", spellID)
		end
	elseif (event == "SPELL_INTERRUPT" and desttype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and not gsadb.interrupt) then 
		self:PlaySpell ("friendlyInterrupt", spellID)
	end
	
	-- play custom spells
	for k, css in pairs (gsadb.custom) do
		if css.destuidfilter == "custom" and destName == css.destcustomname then 
			destuid.custom = true  
		else 
			destuid.custom = false 
		end
		if css.sourceuidfilter == "custom" and sourceName == css.sourcecustomname then
			sourceuid.custom = true  
		else
			sourceuid.custom = false 
		end
		if css.eventtype[event] and destuid[css.destuidfilter] and desttype[css.desttypefilter] and sourceuid[css.sourceuidfilter] and sourcetype[css.sourcetypefilter] and spellID == tonumber(css.spellid) then
			if self:Throttle(tostring(spellID)..css.name, 0.1) then return end
			PlaySoundFile(css.soundfilepath, "Master")
		end
	end
end

-- play drinking in arena
local DRINK_SPELL = GetSpellInfo(104270)
function GladiatorlosSA:UNIT_AURA(event,uid)
	if uid:find("arena") and gsadb.drinking then
		if UnitAura (uid,DRINK_SPELL) then
			if self:Throttle(tostring(104270) .. uid, 3) then return end
			self:PlaySound("drinking")
		end
	end
end

function GladiatorlosSA:Throttle(key,throttle)
	if (not self.throttled) then
		self.throttled = {}
	end
	-- Throttling of Playing
	if (not self.throttled[key]) then
		self.throttled[key] = GetTime()+throttle
		return false
	elseif (self.throttled[key] < GetTime()) then
		self.throttled[key] = GetTime()+throttle
		return false
	else
		return true
	end
end 