------------------------------------------------------------
-- Defaults.lua
--
-- Abin
-- 2010/10/30
------------------------------------------------------------

local module = CompactRaid:FindModule("ClickSets")
if not module then return end

local CLASS = select(2, UnitClass("player"))
local _

module.DEFAULT_SPELLS = {
	PRIEST = {
		2050, -- Heal
		2061, -- Flash Heal
		2060, -- Greater Heal
		139, -- Renew
		88684, -- Holy Word: Serenity
		17, -- Power Word: Shield
		62618, -- Power Word: Barrier
		32546, -- Binding Heal
		596, -- Prayer of Healing
		34861, -- Circle of Healing
		33076, -- Prayer of Mending
		2006, -- Resurrection
		527, -- Dispel Magic
		528, -- Cure Disease
		47540, -- Penance
		47788, -- Guardian Spirit
		6346, -- Fear Ward
		1706, -- Levitate
		73325, --Leap of Faith
		33206, -- Pain Suppression
		10060, -- Power Infusion
	},

	DRUID = {
		5185, -- Healing Touch
		50464, -- Nourish
		774, -- Rejuvenation
		8936, -- Regrowth
		33763, -- Lifebloom
		48438, -- Wild Growth
		18562, -- Swiftmend
		50769, -- Revive
		2782, -- Remove Corruption
		88423, -- Nature's Curse
		20484, -- Rebirth
		29166, -- Innervate
		467, -- Thorns
	},

	SHAMAN = {
		331, -- Healing Wave
		77472, -- Greater Healing Wave
		8004, -- Healing Surge
		1064, -- Chain Heal
		61295, -- Riptide
		974, -- Earth Shield
		2008, -- Ancestral Spirit
		51886, -- Cleanse Spirit
		546, -- Water Walking
		131, -- Water Breathing
	},

	PALADIN = {
		19750, -- Flash of Light
		635, -- Holy Light
		82326, -- Divine Light,
		85673, -- Word of Glory
		82327, -- Holy Radiance
		20473, -- Holy Shock
		633, -- Lay on Hands
		53563, -- Beacon of Light
		4987, -- Cleanse
		7328, -- Redemption
		1038, -- Hand of Salvation
		1044, -- Hand of Freedom
		1022, -- Hand of Protection
		6940, -- Hand of Sacrifice
	},

	WARRIOR = {
		50720, -- Vigilance
		3411, -- Intervene
	},

	MAGE = {
		475, -- Remove Curse
		54646, -- Focus Magic
		130, -- Slow Fall
	},

	WARLOCK = {
		80398, -- Dark Indent
		5697, -- Unending Breath
	},

	HUNTER = {
		34477, -- Misdirection
	},

	ROGUE = {
		57933, -- Tricks of the Trade
	},

	DEATHKNIGHT = {
		61999, -- Raise Ally
		47541, -- Death Coil
	},

	MONK = {
		115178, -- Resuscitate
		115450, -- Detox
		115175, -- Soothing Mist
		115151, -- Renewing Mist
		116694, -- Surging Mist
		124081, -- Zen Sphere
		124682, -- Enveloping Mist
		116849, -- Life Cocoon
		115460, -- Healing Sphere
	},
}

-- Entirely copied from Warbaby's GridClickSets...
local CLASS_DEFAULTS = {
	PRIEST = {
		["shift-1"]	= 2061, -- Flash Heal
		["ctrl-1"]	= 139, -- Renew
		["alt-1"]	= 2060, -- Greater Heal
		["ctrl-2"]	= 17, -- Power Word: Shield
		["alt-2"]	= 33076, -- Prayer of Mending
		["alt-ctrl-2"]	= 34863, -- Circle of Healing
		["shift-2"]	= 527, -- Dispel Magic
		["alt-ctrl-1"]	= 47788, -- Guardian Spirit
	},

	DRUID = {
		["shift-1"]	= 8936, -- Regrowth
		["ctrl-1"]	= 774, -- Rejuvenation
		["alt-1"]	= 50464, -- Nourish
		["alt-ctrl-2"]	= 48438, -- Wild Growth
		["alt-2"]	= 18562, -- Swiftmend
		["ctrl-2"]	= 33763, -- Lifebloom
		["shift-2"]	= 88423, -- Nature's Curse
		["alt-ctrl-1"]	= "emergent",
	},

	SHAMAN = {
		["alt-1"]	= 1064, -- Chain Heal
		["shift-1"]	= 331, -- Healing Wave
		["ctrl-1"]	= 974, -- Earth Shield
		["ctrl-2"]	= 61295, -- Riptide
		["shift-2"]	= 51886, -- Cleanse Spirit
		["alt-ctrl-1"]	= "emergent",
	},

	PALADIN = {
		["ctrl-1"]	= 85673, -- Word of Glory,
		["shift-1"]	= 639, -- Holy Light
		["alt-1"]	= 53563, -- Beacon of Light
		["ctrl-2"]	= 20473, -- Holy Shock
		["alt-2"]	= 82327, -- Holy Radiance
		["shift-2"]	= 4987, -- Cleanse
		["alt-ctrl-1"]	= 7328, -- Lay on Hands
	},

	WARRIOR = {
		["ctrl-1"]	= 50720, -- Vigilance
		["alt-1"]	= 3411, -- Intervene
	},

	MAGE = {
		["ctrl-1"]	= 54646, -- Focus Magic
		["alt-1"]	= 130, -- Slow Fall
		["shift-2"]	= 475, -- Remove Curse
	},

	WARLOCK = {
		["ctrl-1"]	= 80398, -- Dark Indent
		["alt-1"]	= 5697, -- Unending Breath
	},

	HUNTER = {
		["ctrl-1"]	= 34477, -- Misdirection
	},

	ROGUE = {
		["ctrl-1"]	= 57933, -- Tricks of the Trade
	},

	DEATHKNIGHT = {
		["ctrl-1"]	= 61999, -- Raise Ally
		["alt-1"]	= 47541, -- Death Coil
	},

	MONK = {
		["shift-1"]	= 115175, -- Soothing Mist
		["ctrl-1"]	= 115151, -- Renewing Mist
		["alt-1"]	= 116694, -- Surging Mist
		["ctrl-2"]	= 124682, -- Enveloping Mist
		["alt-2"]	= 115460, -- Healing Sphere
		["alt-ctrl-1"]	= 116849, -- Life Cocoon
	},
}

function module:GetSpecialMacro()
	return "/stopcasting\n/target mouseover\n/click ExtraActionButton1\n/targetlasttarget"
end

function module:GetCountdownMacro()
	return "/dbm pull 5"
end

local MACRO_FORMAT = "/stopcasting\n/cast %s\n/cast [@mouseover] %s"

local function MakeEmergentMacro(spell1, spell2)
	local name1, _, icon = GetSpellInfo(spell1)
	local name2 = GetSpellInfo(spell2)
	if name1 and name2 then
		return { macro = format(MACRO_FORMAT, name1, name2), icon = icon }
	end
end

local EMERGENT_MACROS = {
	DRUID = MakeEmergentMacro(132158, 5185),
	SHAMAN = MakeEmergentMacro(16188, 77472),
}

function module:GetEmergentMacro()
	local data = EMERGENT_MACROS[CLASS]
	if data then
		return data.macro, data.icon
	end
end

defaultdb = {}
local temp = CLASS_DEFAULTS[CLASS]
local key, value
for key, value in pairs(temp) do
	if value == "emergent" then
		defaultdb[key] = "buildin:emergent"
	else
		local spell = GetSpellInfo(value)
		if spell then
			defaultdb[key] = "buildin:"..spell
		end
	end
end

defaultdb["1"] = "action:target"
defaultdb["2"] = "action:togglemenu"

function module:GetDefaultDB(key)
	if key == "talent" then
		return defaultdb
	end
end