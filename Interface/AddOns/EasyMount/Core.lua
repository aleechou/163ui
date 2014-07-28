------------------------------------------------------------
-- Core.lua
--
-- Abin
-- 2011/2/20
------------------------------------------------------------

local band = bit.band
local GetSpellInfo = GetSpellInfo
local IsSpellKnown = IsSpellKnown
local GetItemCount = GetItemCount
local _

local addonName, addon = ...
_G[addonName] = addon
local L = addon.L
addon.CLASS = select(2, UnitClass("player"))
addon.RACE = select(2, UnitRace("player"))
addon.MOUNT_KEYS = { ground = 1, fly = 1, vendors = 1, swim = 1, taq = 1 } -- Mount categories
addon.mountList = {}

function addon:IsBlackListed(category, id)
	local db = addon.db and addon.db[category]
	return db and db[id]
end

local function InitMountList()
	local key
	for key in pairs(addon.MOUNT_KEYS) do
		if addon.mountList[key] then
			wipe(addon.mountList[key])
		else
			addon.mountList[key] = {}
		end
	end
end

InitMountList()

local function AddMountSpell(category, data, noVerify)
	local result
	if type(data) == "number" then
		local name, _, icon = GetSpellInfo(data)
		if name and (noVerify or IsSpellKnown(data)) then
			result = { id = data, name = name, icon = icon }
		end
	else
		result = data
	end

	if type(result) == "table" then
		tinsert(addon.mountList[category], result)
		return result
	end
end

local function AddSpecialSpell(key, id)
	local name, _, icon = GetSpellInfo(id)
	if name and IsSpellKnown(id) then
		addon[key] = name
	else
		addon[key] = nil
	end
end

local function HasFlag(num, flag)
	return band(num, flag) == flag
end

local VENDOR_MOUNTS = { [61425] = 1, [61447] = 1, [122708] = 1, [122729]=1,}
local TAQ_BETTLES = { [25953] = 1, [26054] = 1, [26055] = 1, [26056] = 1, }

function BuildMountList()
	InitMountList()

	if addon.hasBroom then
		AddMountSpell("fly", 47977, 1)
		AddMountSpell("ground", 47977, 1)
	end

	if addon.CLASS == "DRUID" then
		if not AddMountSpell("fly", 40120) then -- Swift flight form
			AddMountSpell("fly", 33943) -- Flight form
		end

		AddMountSpell("swim", 1066) -- Aquatic form
		AddSpecialSpell("aquaticForm", 1066)
		AddSpecialSpell("combatForm", 783) -- Travel form

	elseif addon.CLASS == "SHAMAN" then
		AddSpecialSpell("combatForm", 2645) -- Wolf form
	elseif addon.RACE == "Worgen" then
		AddMountSpell("ground", 87840) -- Running Wild
	elseif addon.CLASS == "MONK" then
		AddMountSpell("fly", 125883) -- Zen Flight
	end

	local i
	for i = 1, GetNumCompanions("MOUNT") do
		local _, name, id, icon, _, flag = GetCompanionInfo("MOUNT", i)

        name = GetSpellInfo(id)

		if name and flag then
			local data = { id = id, name = name, icon = icon }
			if TAQ_BETTLES[id] then
				AddMountSpell("taq", data)
			elseif flag == 31 then -- should be `0b10101` or `0b00101`
				AddMountSpell("fly", data)
				AddMountSpell("ground", data)
			elseif HasFlag(flag, 0x02) then
				AddMountSpell("fly", data)
			elseif HasFlag(flag, 0x08) and not HasFlag(flag, 0x10) then
				AddMountSpell("swim", data)
			else
				AddMountSpell("ground", data)
			end

			if VENDOR_MOUNTS[id] then
				AddMountSpell("vendors", data)
			end
		end
	end

	addon:UpdateActions()
end

local WATCHED_SPELLS = {
	DRUID = { [33943] = 0, [40120] = 1, [1066] = 0, [783] = 0 },
	MONK = { [125883] = 1 },
	SHAMAN = { [2645] = 1 },
	Worgen = { [87840] = 1 },
}

local function NeedLearnSpells()
	local data = WATCHED_SPELLS[addon.CLASS] or WATCHED_SPELLS[addon.RACE]
	if data then
		local id, value
		for id, value in pairs(data) do
			if value == 1 and not IsSpellKnown(id) then
				return id
			end
		end
	end
end

local function IsMountSpell(id)
	local data = WATCHED_SPELLS[addon.CLASS]
	if data and data[id] then
		return id
	end

	data = WATCHED_SPELLS[addon.RACE]
	if data and data[id] then
		return id
	end
end

local function CheckMagicBroom()
	local broom = GetItemCount(37011) > 0 -- Magic Broom
	if not addon.hasBroom ~= not broom then
		addon.hasBroom = broom
		return 1
	end
end

local SEA_LEGS = GetSpellInfo(73701) -- The buff which determines whether the player is located in Vashj'ir

local vashjirBuff
local function CheckVashjirAura(self)
	local buff = UnitBuff("player", SEA_LEGS)
	if vashjirBuff ~= buff then
		vashjirBuff = buff
		if buff then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		else
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg1, ...)
    --if event == "ADDON_LOADED" and arg1 == addonName then
    if event == "ADDON_LOADED" then
        if arg1 == addonName then
            if type(EasyMountDB) ~= "table" then
                EasyMountDB = {}
            end

            addon.db = EasyMountDB

            local key
            for key in pairs(addon.MOUNT_KEYS) do
                if type(addon.db[key]) ~= "table" then
                    addon.db[key] = {}
                end
            end

            self:RegisterEvent("PLAYER_ENTERING_WORLD")
            self:RegisterEvent("COMPANION_UPDATE")
            self:RegisterEvent("UNIT_AURA")
            self:RegisterEvent("BAG_UPDATE")
            self._loaded_self = true
        end

        local hasLiteBuff = select(2, GetAddOnInfo'LiteBuff')
        if(not hasLiteBuff) then
            return self:UnregisterEvent'ADDON_LOADED'
        end

        if  (not self._loaded_self) or
            (self._called_litebuff) or
            (not IsAddOnLoaded'LiteBuff') then return end

        self._called_litebuff = true
        addon:LiteBuff()
        self:UnregisterEvent'ADDON_LOADED'

	elseif event == "COMPANION_UPDATE" then
		BuildMountList()

	elseif event == "PLAYER_ENTERING_WORLD" then
		CheckVashjirAura(self)
		CheckMagicBroom()
		BuildMountList()
		if NeedLearnSpells() then
			self:RegisterEvent("LEARNED_SPELL_IN_TAB")
		end

	elseif event == "LEARNED_SPELL_IN_TAB" then
		if IsMountSpell(arg1) then
			BuildMountList()
			if not NeedLearnSpells() then
				self:UnregisterEvent(event)
			end
		end

	elseif event == "UNIT_AURA" and arg1 == "player" then
		CheckVashjirAura(self)

	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local flag, _, guid, _, _, _, _, _, _, _, id = ...
		if id == 75966 and (flag == "SPELL_AURA_APPLIED" or flag == "SPELL_AURA_REMOVED") and guid == UnitGUID("player") then
			local aura
			if flag == "SPELL_AURA_APPLIED" then
				aura = 1
			elseif flag == "SPELL_AURA_REMOVED" then
				aura = nil
			end

			if addon.vashjir ~= aura then
				addon.vashjir = aura
				addon:UpdateActions()
			end
		end

	elseif event == "BAG_UPDATE" then
		if CheckMagicBroom() then
			BuildMountList()
		end
	end
end)

