------------------------------------------------------------
-- DragonSoul.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2012/09/07
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 4 -- Cataclysm
local INSTANCE = 187 -- Dragon Soul

-- Morchok (311)
module:RegisterDebuff(TIER, INSTANCE, 311, 103687, 5) --Crush Armor
module:RegisterDebuff(TIER, INSTANCE, 311, 103821) --Earthen Vortex
module:RegisterDebuff(TIER, INSTANCE, 311, 103785) --Black Blood of the Earth
module:RegisterDebuff(TIER, INSTANCE, 311, 103534) --Danger (Red)
module:RegisterDebuff(TIER, INSTANCE, 311, 103536) --Warning (Yellow)
module:RegisterDebuff(TIER, INSTANCE, 311, 103541) --Safe (Blue)
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 311, 109033) --Stomp

-- Warlord Zon'ozz (324)
module:RegisterDebuff(TIER, INSTANCE, 324, 104378) --Black Blood of Go'rath
module:RegisterDebuff(TIER, INSTANCE, 324, 103434, 5) --Disrupting Shadows (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 324, 108799) --Black Blood Erruption

-- Yor'sahj the Unsleeping (325)
module:RegisterDebuff(TIER, INSTANCE, 325, 104849) --Void Bolt
module:RegisterDebuff(TIER, INSTANCE, 325, 105171, 5) --Deep Corruption

-- Hagara the Stormbinder (317)
module:RegisterDebuff(TIER, INSTANCE, 317, 105465) --Lightning Storm
module:RegisterDebuff(TIER, INSTANCE, 317, 105369) --Lightning Conduit
module:RegisterDebuff(TIER, INSTANCE, 317, 105289) --Shattered Ice (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 317, 105285) --Target (next Ice Lance)
module:RegisterDebuff(TIER, INSTANCE, 317, 105314) --Ice Wave
module:RegisterDebuff(TIER, INSTANCE, 317, 105297, 4) -- Ice Lance
module:RegisterDebuff(TIER, INSTANCE, 317, 105316, 5) --Ice Lance
module:RegisterDebuff(TIER, INSTANCE, 317, 104451, 5) --Ice Tomb
module:RegisterDebuff(TIER, INSTANCE, 317, 109423)
module:RegisterDebuff(TIER, INSTANCE, 317, 109333)
module:RegisterDebuff(TIER, INSTANCE, 317, 110317) --Watery Entrenchment
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 317, 109325, 4)

-- Ultraxion (331)
module:RegisterDebuff(TIER, INSTANCE, 331, 105925, 5) --Fading Light
module:RegisterDebuff(TIER, INSTANCE, 331, 106108) --Heroic Will
module:RegisterDebuff(TIER, INSTANCE, 331, 105984) --Timeloop
module:RegisterDebuff(TIER, INSTANCE, 331, 105927) --Faded Into Twilight
module:RegisterDebuff(TIER, INSTANCE, 331, 106415, 5) --Twilight Burst
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 331, 106498) --Looming Darkness

-- Warmaster Blackhorn (332)
module:RegisterDebuff(TIER, INSTANCE, 332, 108043, 5) --Sunder Armor
module:RegisterDebuff(TIER, INSTANCE, 332, 107558, 5) --Degeneration
module:RegisterDebuff(TIER, INSTANCE, 332, 107567) --Brutal Strike
module:RegisterDebuff(TIER, INSTANCE, 332, 108046) --Shockwave
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 332, 109204) -- Twilight Barrage
module:RegisterDebuff(TIER, INSTANCE, 332, 110214, 4) -- Consuming Shroud

-- Spine of Deathwing (318)
module:RegisterDebuff(TIER, INSTANCE, 318, 105563) --Grasping Tendrils
module:RegisterDebuff(TIER, INSTANCE, 318, 105479, 3) --Searing Plasma
module:RegisterDebuff(TIER, INSTANCE, 318, 105490, 5) --Fiery Grip
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 318, 106005, 5) --Degradation (disabled)
module:RegisterDebuff(TIER, INSTANCE, 318, 106199, 4)
module:RegisterDebuff(TIER, INSTANCE, 318, 106200, 4)

-- Madness of Deathwing (333)
module:RegisterDebuff(TIER, INSTANCE, 333, 105445) --Blistering Heat
module:RegisterDebuff(TIER, INSTANCE, 333, 105841) --Degenerative Bite
module:RegisterDebuff(TIER, INSTANCE, 333, 106385) --Crush
module:RegisterDebuff(TIER, INSTANCE, 333, 106730, 5) --Tetanus
module:RegisterDebuff(TIER, INSTANCE, 333, 106444, 5) --Impale
module:RegisterDebuff(TIER, INSTANCE, 333, 106794, 5) --Shrapnel (target)
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 333, 108649, 5)

-- Trash
module:RegisterDebuff(TIER, INSTANCE, 0, 109442) --Tornado
module:RegisterDebuff(TIER, INSTANCE, 0, 109331, 5) --Shatter
module:RegisterDebuff(TIER, INSTANCE, 0, 109333) --Frost Corruption (magic)
module:RegisterDebuff(TIER, INSTANCE, 0, 107801) --Drenched
module:RegisterDebuff(TIER, INSTANCE, 0, 107797) --Flood
module:RegisterDebuff(TIER, INSTANCE, 0, 107770, 5) --Pure Water
module:RegisterDebuff(TIER, INSTANCE, 0, 107677, 5) --Dust Storm
module:RegisterDebuff(TIER, INSTANCE, 0, 107629) --Boulder Smash (magic)
module:RegisterDebuff(TIER, INSTANCE, 0, 109368, 5) --Spark
module:RegisterDebuff(TIER, INSTANCE, 0, 109423) --Shackles of Ice (magic)
module:RegisterDebuff(TIER, INSTANCE, 0, 108183) --Twilight Submission (magic)