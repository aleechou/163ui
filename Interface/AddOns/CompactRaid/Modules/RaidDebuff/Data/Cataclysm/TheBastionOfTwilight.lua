------------------------------------------------------------
-- TheBastionOfTwilight.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2012/09/07
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 4 -- Cataclysm
local INSTANCE = 72 -- The Bastion of Twilight

-- Halfus Wyrmbreaker (156)
module:RegisterDebuff(TIER, INSTANCE, 156, 83710) --Furious Roar
module:RegisterDebuff(TIER, INSTANCE, 156, 83908) --Malevolent Strikes
module:RegisterDebuff(TIER, INSTANCE, 156, 83603) --Stone Touch

-- Valiona & Theralion (157)
module:RegisterDebuff(TIER, INSTANCE, 157, 86788) --Blackout
module:RegisterDebuff(TIER, INSTANCE, 157, 86622) --Engulfing Magic
module:RegisterDebuff(TIER, INSTANCE, 157, 86202, 5) --Twilight Shift
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 157, 86014) --Twilight Meteorite
module:RegisterDebuff(TIER, INSTANCE, 157, 92886, 5) --Twilight Zone

-- Twilight Ascendant Council (158)
module:RegisterDebuff(TIER, INSTANCE, 158, 82762) --Waterlogged
module:RegisterDebuff(TIER, INSTANCE, 158, 83099) --Lightning Rod
module:RegisterDebuff(TIER, INSTANCE, 158, 82285) --Elemental Stasis
module:RegisterDebuff(TIER, INSTANCE, 158, 82660) --Burning Blood
module:RegisterDebuff(TIER, INSTANCE, 158, 82665) --Heart of Ice
module:RegisterDebuff(TIER, INSTANCE, 158, 82772) --Frozen
module:RegisterDebuff(TIER, INSTANCE, 158, 84948) --Gravity Crush
module:RegisterDebuff(TIER, INSTANCE, 158, 83500) --Swirling Winds
module:RegisterDebuff(TIER, INSTANCE, 158, 83581) --Grounded
module:RegisterDebuff(TIER, INSTANCE, 158, 82285) --Elemental Stasis
--module:RegisterDebuff(TIER, INSTANCE, 158, 83587) --Magnetic Pull
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 158, 92307) --Frost Beacon
module:RegisterDebuff(TIER, INSTANCE, 158, 92467) --Static Overload
module:RegisterDebuff(TIER, INSTANCE, 158, 92538) --Gravity Core

-- Cho'gall (167)
module:RegisterDebuff(TIER, INSTANCE, 167, 81701, 5) --Corrupted Blood
module:RegisterDebuff(TIER, INSTANCE, 167, 81836) --Corruption: Accelerated
module:RegisterDebuff(TIER, INSTANCE, 167, 82125) --Corruption: Malformation
module:RegisterDebuff(TIER, INSTANCE, 167, 82170) --Corruption: Absolute
module:RegisterDebuff(TIER, INSTANCE, 167, 82523) --Gall's Blast
module:RegisterDebuff(TIER, INSTANCE, 167, 82518) --Cho's Blast
module:RegisterDebuff(TIER, INSTANCE, 167, 82411) --Debilitating Beam

-- Sinestra (168)
module:RegisterDebuff(TIER, INSTANCE, 168, 89299) --Twilight Spit
module:RegisterDebuff(TIER, INSTANCE, 168, 89435) --龙母
-- module:RegisterDebuff(TIER, INSTANCE, 168, 92955) --Wrack

-- Trash
--module:RegisterDebuff(TIER, INSTANCE, 0, 81114) --Magma
module:RegisterDebuff(TIER, INSTANCE, 0, 81118, 5) --Magma
module:RegisterDebuff(TIER, INSTANCE, 0, 87931) --Tremors
module:RegisterDebuff(TIER, INSTANCE, 0, 85799) --Phased Burn
module:RegisterDebuff(TIER, INSTANCE, 0, 88232) --Crimson Flames
module:RegisterDebuff(TIER, INSTANCE, 0, 84850) --Soul Blade
module:RegisterDebuff(TIER, INSTANCE, 0, 84853) --Dark Pool
module:RegisterDebuff(TIER, INSTANCE, 0, 88219) --Burning Twilight
module:RegisterDebuff(TIER, INSTANCE, 0, 88079) --Frostfire Bolt
module:RegisterDebuff(TIER, INSTANCE, 0, 76622, 5) --Sunder Armor
module:RegisterDebuff(TIER, INSTANCE, 0, 84832) --Dismantle
module:RegisterDebuff(TIER, INSTANCE, 0, 84856) --Hungering Shadows
module:RegisterDebuff(TIER, INSTANCE, 0, 88643) --Mind Sear
module:RegisterDebuff(TIER, INSTANCE, 0, 85564, 5) --Shifted Reality
module:RegisterDebuff(TIER, INSTANCE, 0, 93277, 5) --Rending Gale
module:RegisterDebuff(TIER, INSTANCE, 0, 93306) --Vaporize
module:RegisterDebuff(TIER, INSTANCE, 0, 93327, 5) --Entomb
module:RegisterDebuff(TIER, INSTANCE, 0, 93325) --Shockwave
module:RegisterDebuff(TIER, INSTANCE, 0, 85482, 5) --Shadow Volley
module:RegisterDebuff(TIER, INSTANCE, 0, 87629) --Gripping Shadows
--module:RegisterDebuff(TIER, INSTANCE, 0, 88178) --Stasis Strike
--module:RegisterDebuff(TIER, INSTANCE, 0, 87917) --Petrify Skin
--module:RegisterDebuff(TIER, INSTANCE, 0, 84838) --Twist Phase
--module:RegisterDebuff(TIER, INSTANCE, 0, 87629) --Gripping Shadows
