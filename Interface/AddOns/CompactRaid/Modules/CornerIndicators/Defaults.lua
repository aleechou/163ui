------------------------------------------------------------
-- Defaults.lua
--
-- Abin
-- 2010/10/30
------------------------------------------------------------

local type = type
local pairs = pairs
local wipe = wipe
local strfind = strfind
local tonumber = tonumber
local GetSpellInfo = GetSpellInfo
local _

local module = CompactRaid:FindModule("CornerIndicators")
if not module then return end

module.DEFAULT_SPELLS = {
	PRIEST = {
		139, -- Renew
		17, -- Power Word: Shield
		33076, -- Prayer of Mending
		21562,-- Power Word: Fortitude
		6346, -- Fear Ward
	},

	DRUID = {
		774, -- Rejuvenation
		8936, -- Regrowth
		33763, -- Lifebloom
		48438, -- Wild Growth
		29166, -- Innervate
		1126, -- Mark of the Wild
	},

	SHAMAN = {
		974, -- Earth Shield
		61295, -- Riptide
	},

	PALADIN = {
		53563, -- Beacon of Light
		19740, -- Blessing of Might
		20217, -- Blessing of Kings
		1038, -- Hand of Salvation
		1044, -- Hand of Freedom
		1022, -- Hand of Protection
		6940, -- Hand of Sacrifice
	},

	WARRIOR = {
		114030, -- Vigilance
		6673, -- Battle Shout
		469, -- Commanding Shout
	},

	MAGE = {
		1459, -- Arcane Brilliance
	},

	WARLOCK = {
		80398, -- Dark Indent
		5697, -- Unending Breath
		20707, -- Soulstone Resurrection
	},

	DEATHKNIGHT = {
		57330, -- Horn of Winter
	},

	MONK = {
		115921, -- Legacy of the Emperor
		115151, -- Renewing Mist
		124682, -- Enveloping Mist
		116849, -- Life Cocoon
	},
}

local CLASS_DEFAULTS = {
	PRIEST = {
		TOPLEFT = { spell = 139, numeric = 1 }, -- Renew
		BOTTOMLEFT = { spell = 33076, other = 1 }, -- Prayer of Mending
		TOPRIGHT = { spell = 17, other = 1 }, -- Power Word: Shield
		BOTTOMRIGHT = { spell = 21562, other = 1, lacks = 1 }, -- Power Word: Fortitude
	},

	DRUID = {
		TOPLEFT = { spell = 774, numeric = 1 }, -- Rejuvenation
		BOTTOMLEFT = { spell = 33763, numeric = 1 }, -- Lifebloom
		TOPRIGHT = { spell = 48438, numeric = 1 }, -- Wild Growth
		BOTTOMRIGHT = { spell = 1126, other = 1, lacks = 1 }, -- Mark of the Wild
	},

	SHAMAN = {
		TOPLEFT = { spell = 974 }, -- Earth Shield
		TOPRIGHT = { spell = 61295, numeric = 1 }, -- Riptide
	},

	PALADIN = {
		TOPLEFT = { spell = 53563, numeric = 1 }, -- Beacon of Light
		TOPRIGHT = { spell = 20217, other = 1, lacks = 1 }, -- Blessing of Kings
		BOTTOMRIGHT = { spell = 19740, other = 1, lacks = 1 }, -- Blessing of Might
	},

	WARRIOR = {
		TOPLEFT = { spell = 469, other = 1 }, -- Commanding Shout
		TOPRIGHT = { spell = 6673, other = 1, ignoreMagical = 1 }, -- Battle Shout
		BOTTOMRIGHT = { spell = 50720, other = 1 }, -- Vigilance
	},

	MAGE = {
		TOPLEFT = { spell = 54646, other = 1, ignorePhysical = 1 }, -- Focus Magic
		BOTTOMRIGHT = { spell = 1459, other = 1, lacks = 1, ignorePhysical = 1 }, -- Arcane Brilliance
	},

	WARLOCK = {
		TOPLEFT = { spell = 80398, other = 1, ignorePhysical = 1 }, -- Dark Indent
		TOPRIGHT = { spell = 20707, other = 1 }, -- Soulstone Resurrection
	},

	DEATHKNIGHT = {
		TOPLEFT = { spell = 57330, other = 1, ignoreMagical = 1 }, -- Horn of Winter
	},

	MONK = {
		TOPLEFT = { spell = 115151, numeric = 1 }, -- Renewing Mist
		TOPRIGHT = { spell = 124682, numeric = 1 }, -- Enveloping Mist
		BOTTOMRIGHT = { spell = 115921, other = 1, lacks = 1 }, -- Legacy of the Emperor
	},
}

local DEFAULTS_INDICATOR = {
	style = 1,
	ignoreOutRanged = 1,
	r = 0, g = 1, b = 0,
	["1"] = { threshold = 50, r = 1, g = 1, b = 0, },
	["2"] = { threshold = 3, r = 1, g = 0, b = 0, },
}

local OPTION_KEYS = {
	aura = "string",
	style = 1,
	selfcast = "1/nil",
	showlacks = "1/nil",
	ignorePhysical = "1/nil",
	ignoreMagical = "1/nil",
	ignoreVehicle = "1/nil",
	scale = 100,
	xoffset = 0,
	yoffset = 0,
	r1 = 0,
	g1 = 1,
	b1 = 0,
	threshold2 = 50,
	r2 = 1,
	g2 = 1,
	b2 = 0,
	threshold3 = 5,
	r3 = 1,
	g3 = 0,
	b3 = 0,
}

function module:EncodeData(db)
	if type(db) ~= "table" or not db.aura or db.aura == "" then
		return
	end

	local key, def, text
	for key, def in pairs(OPTION_KEYS) do
		local value = db[key]
		if value and value ~= def then
			if text then
				text = text.."["..key.."]#"..value.."#"
			else
				text = "["..key.."]#"..value.."#"
			end
		end
	end

	return text
end

function module:DecodeData(text, db)
	if type(db) == "table" then
		wipe(db)
	else
		db = {}
	end

	if type(text) ~= "string" then
		text = ""
	end

	local key, def
	for key, def in pairs(OPTION_KEYS) do
		local _, _, value = strfind(text, "%["..key.."%]#("..(key == "aura" and ".-" or "%d+")..")#")
		if value then
			if key == "aura" then
				db[key] = value
			else
				db[key] = tonumber(value)
			end
		elseif type(def) == "number" then
			db[key] = def
		end
	end

	return db
end

local CLASS = select(2, UnitClass("player"))

function GetClassDefaults(corner)
	local data = CLASS_DEFAULTS[CLASS]
	data = data and data[corner]
	if data then
		return data.spell, data.numeric, data.other, data.lacks, data.ignorePhysical, data.ignoreMagical
	end
end

local defaultdb = {}

local key
for _, key in ipairs(module.INDICATOR_KEYS) do
	local data = {}
	module:CloneTable(DEFAULTS_INDICATOR, data)
	local spell, numeric, other, lacks, ignorePhysical, ignoreMagical = GetClassDefaults(key)
	if spell then
		data.aura = GetSpellInfo(spell)
		data.style = numeric and 2 or 1
		data.selfcast = not other and 1 or nil
		data.showlacks = lacks
		data.ignorePhysical = ignorePhysical
		data.ignoreMagical = ignoreMagical
		data.ignoreVehicle = other or lacks or ignorePhysical or ignoreMagical
	end

	defaultdb[key] = module:EncodeData(data)
end

function module:GetDefaultDB(key)
	if key == "talent" then
		return defaultdb
	end
end