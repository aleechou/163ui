local LL = {} local function L(key) return LL[key] or key end
if GetLocale():find'^zh' then
    LL["Tanking cooldowns"] = "坦克救命技能"
    LL["Show text as"] = "文字指示器显示内容："
    LL["Text to show when assigned to an indicator capable of displaying text"] = "如果指示器支持文字显示，则会显示所选的文字。"
    LL["Caster name"] = "施法者名字"
    LL["Spell name"] = "技能名称"
    LL["Check the spells that you want GridStatusTankCooldown to keep track of. Their position on the list defines their priority in the case that a unit has more than one of them."] = "选择要提示的坦克救命技能，如果开启的救命技能多于一个，则排在前面的会优先显示。"
    LL["Options"] = "选项"
    LL["Spells"] = "选择要提示的技能"
end
------------------------------------------------------------------------------
-- GridStatusTankCooldown by Slaren
------------------------------------------------------------------------------
GridStatusTankCooldown = Grid:GetModule("GridStatus"):NewModule("GridStatusTankCooldown")
GridStatusTankCooldown.menuName = L"Tanking cooldowns"

local tankingbuffs = {
	["DEATHKNIGHT"] = {
		48707, -- Anti-Magic Shell
		50461, -- Anti-Magic Zone
		42650, -- Army of the Dead
		77535, -- Blood Shield		
		49222, -- Bone Shield
		49028, -- Dancing Rune Weapon
		48792, -- Icebound Fortitude
		55233, -- Vampiric Blood
		105588, -- Vampiric Brood (tier bonus)
	},
	["DRUID"] = {
		22812,  -- Barkskin
		124769, -- Glyph of Frenzied Regeneration
		102342, -- Ironbark
		105737, -- Mass Regeneration (tier bonus)
		106922, -- Might of Ursoc
		132402, -- Savage Defense
		61336,  -- Survival Instincts
	},
	["HUNTER"] = {
		19263,  -- Deterrence
	},
	["MAGE"] = {
		45438,  -- Ice Block
		11426,  -- Ice Barrier
		1463,   -- Incanter's Ward
		115610, -- Temporal Shield
	},
	["MONK"] = {
		115213, -- Avert Harm
		122278, -- Dampen Harm
		122783, -- Diffuse Magic
		115308, -- Elusive Brew
		115203, -- Fortifying Brew
		115295, -- Guard
		116849, -- Life Cocoon
		115176, -- Zen Meditation
	},
	["PALADIN"] = {
		31850,  -- Ardent Defender
		31821,  -- Devotion Aura
		498,    -- Divine Protection
		642,    -- Divine Shield
		86659,  -- Guardian of Ancient Kings
		1022,   -- Hand of Protection
		114039, -- Hand of Purity
		6940,   -- Hand of Sacrifice
		20925,  -- Holy Shield
		132403, -- Shield of the Righteous
	},
	["PRIEST"] = {
		47585,  -- Dispersion
		47788,  -- Guardian Spirit
		33206,  -- Pain Suppression
		81782,  -- Power Word: Barrier
	},
	["ROGUE"] = {
		31224,  -- Cloak of Shadows
		5277,   -- Evasion
		1966,   -- Feint
		76577,  -- Smoke Bomb
	},
	["SHAMAN"] = {
		108271, -- Astral Shift
		30823,  -- Shamanistic Rage
		98008,  -- Spirit Link Totem
		114893, -- Stone Bulwark Totem
	},
	["WARLOCK"] = {
		110913, -- Dark Bargain        
		108359, -- Dark Regeneration
		91711,  -- Nether Ward
		108416, -- Sacrificial Pact
		6229,   -- Shadow Ward
		104773, -- Unending Resolve
	},
	["WARRIOR"] = {
		118038, -- Die by the Sword
		12975,  -- Last Stand
		97463,  -- Rallying Cry
		46947,  -- Safeguard
		112048, -- Shield Barrier		
		2565,   -- Shield Block
		105914, -- Shield Fortress (tier bonus)
		871,    -- Shield Wall
		114030, -- Vigilance
	}
}

GridStatusTankCooldown.tankingbuffs = tankingbuffs

-- locals
local GridRoster = Grid:GetModule("GridRoster")
local GetSpellInfo = GetSpellInfo
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local UnitGUID = UnitGUID

local settings
local spellnames = {}

GridStatusTankCooldown.defaultDB = {
	debug = false,
	alert_tankcd = {
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1 },
		priority = 99,
		range = false,
		showtextas = "spell",
        showlatest = false,
		active_spellids = { -- default spells
			31850,	-- Ardent Defender
			86659,	-- Guardian of Ancient Kings
			47788,	-- Guardian Spirit
			6940, 	-- Hand of Sacrifice
			48792, 	-- Icebound Fortitude
			33206,	-- Pain Suppression
			871,	-- Shield Wall
			61336,	-- Survival Instincts
			115203, -- Fortifying Brew
			98008,  -- Spirit Link Totem
			31821,  -- Devotion Aura
			81782,  -- Power Word: Barrier
			106922, -- Might of Ursoc
			116849, -- Life Cocoon
		},
		inactive_spellids = { -- used to remember priority of disabled spells
		}
	}
}

local myoptions = {
	["gstcd_header_1"] = {
		type = "header",
		order = 200,
		name = L"Options",
	},
	["showtextas"] = {
		order = 201,
		type = "select",
		name = L"Show text as",
		desc = L"Text to show when assigned to an indicator capable of displaying text",
		values = { ["caster"] = L"Caster name", ["spell"] = L"Spell name" },
		style = "radio",
		get = function() return GridStatusTankCooldown.db.profile.alert_tankcd.showtextas end,
		set = function(_, v) GridStatusTankCooldown.db.profile.alert_tankcd.showtextas = v end,
	},
    ["showlatest"] = {
        order = 202,
        type = "toggle",
        name = L"显示最后释放的技能",
        width = "full",
        desc = L"始终显示最后释放的技能，而不是按照优先级顺序显示。",
        get = function() return GridStatusTankCooldown.db.profile.alert_tankcd.showlatest end,
        set = function(_, v) GridStatusTankCooldown.db.profile.alert_tankcd.showlatest = v end,
    },
	["gstcd_header_2"] = {
		type = "header",
		order = 203,
		name = L"Spells",
	},
	["spells_description"] = {
		type = "description",
		order = 204,
		name = L"Check the spells that you want GridStatusTankCooldown to keep track of. Their position on the list defines their priority in the case that a unit has more than one of them.",
	},
	["spells"] = {
		type = "input",
		order = 205,
		name = "Spells",
		control = "GSTCD-SpellsConfig",
	},
}

function GridStatusTankCooldown:OnInitialize()
	self.super.OnInitialize(self)
	
	for class, buffs in pairs(tankingbuffs) do
		for _, spellid in pairs(buffs) do
			local sname = GetSpellInfo(spellid)
			spellnames[spellid] = sname
		end
	end
	
	self:RegisterStatus("alert_tankcd", L"Tanking cooldowns", myoptions, true)

	settings = self.db.profile.alert_tankcd

	-- delete old format settings
	if settings.spellids then
		settings.spellids = nil
	end
	
	-- remove old spellids
	for p, aspellid in ipairs(settings.active_spellids) do
		local found = false
		for class, buffs in pairs(tankingbuffs) do
			for _, spellid in pairs(buffs) do
				if spellid == aspellid then
					found = true
					break
				end				
			end
		end
		
		if not found then
			table.remove(settings.active_spellids, p)
		end
		
		-- remove duplicates
		for i = #settings.active_spellids, p + 1, -1 do
			if settings.active_spellids[i] == aspellid then
				table.remove(settings.active_spellids, i)
			end
		end
	end
end

function GridStatusTankCooldown:OnStatusEnable(status)
	if status == "alert_tankcd" then
		self:RegisterEvent("UNIT_AURA", "ScanUnit")
		self:RegisterEvent("Grid_UnitJoined")
		-- self:ScheduleRepeatingEvent("GridStatusTankCooldown:UpdateAllUnits", self.UpdateAllUnits, 0.5, self)
		self:UpdateAllUnits()
	end
end

function GridStatusTankCooldown:OnStatusDisable(status)
	if status == "alert_tankcd" then
		self:UnregisterEvent("UNIT_AURA")
		self:UnregisterEvent("Grid_UnitJoined")
        
		--self:CancelScheduledEvent("GridStatusTankCooldown:UpdateAllUnits")
		self.core:SendStatusLostAllUnits("alert_tankcd")
	end
end

function GridStatusTankCooldown:Grid_UnitJoined(guid, unitid)
	self:ScanUnit("Grid_UnitJoined", unitid, guid)
end

function GridStatusTankCooldown:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:ScanUnit("UpdateAllUnits", unitid, guid)
	end
end

function GridStatusTankCooldown:ScanUnit(event, unitid, unitguid)
	unitguid = unitguid or UnitGUID(unitid)
	if not GridRoster:IsGUIDInRaid(unitguid) then
		return
	end

    local l_starttime, l_text, l_icon, l_count, l_duration, l_expirationTime;

	for _, spellid in ipairs(settings.active_spellids) do
		local name, _, icon, count, _, duration, expirationTime, caster;
        if(spellnames[spellid])then
            name, _, icon, count, _, duration, expirationTime, caster = UnitBuff(unitid, spellnames[spellid])
        end
		
		-- Used to check for debuffs when Argent Defender was a debuff - it is not necessary anymore
		--[[
		if not name then
			name, _, icon, count, _, duration, expirationTime, caster = UnitDebuff(unitid, spellnames[spellid])
		end
		]]

		if name then
			local text
			if settings.showtextas == "caster" then
				if caster then
					text = UnitName(caster)
				end
			else
				text = name
            end

            local starttime = expirationTime - duration

            if not l_starttime or l_starttime < starttime then
                l_starttime = starttime
                l_text = text
                l_count = count
                l_duration = duration
                l_expirationTime = expirationTime
                l_icon = icon
            end

            if not settings.showlatest then break end
		end
    end

    if l_starttime then
        self.core:SendStatusGained(unitguid,
            "alert_tankcd",
            settings.priority,
            (settings.range and 40),
            settings.color,
            l_text,
            0,							-- value
            nil,						-- maxValue
            l_icon,						-- icon
            l_starttime,	-- start
            l_duration,					-- duration
            l_count)						-- stack
        return
    end

	self.core:SendStatusLost(unitguid, "alert_tankcd")
end
