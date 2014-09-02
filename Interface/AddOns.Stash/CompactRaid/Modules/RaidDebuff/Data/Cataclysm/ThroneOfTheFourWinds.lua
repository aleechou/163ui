------------------------------------------------------------
-- ThroneOfTheFourWinds.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2012/09/07
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 4 -- Cataclysm
local INSTANCE = 74 -- Throne of The Four Winds

-- Conclave of Wind (154)
module:RegisterDebuff(TIER, INSTANCE, 154, 84645, 5) --Wind Chill
module:RegisterDebuff(TIER, INSTANCE, 154, 86111, 5) --Ice Patch
module:RegisterDebuff(TIER, INSTANCE, 154, 86082) --Permafrost
module:RegisterDebuff(TIER, INSTANCE, 154, 86481) --Hurricane
module:RegisterDebuff(TIER, INSTANCE, 154, 86282, 5) --Toxic Spores
module:RegisterDebuff(TIER, INSTANCE, 154, 85573) --Deafening Winds
module:RegisterDebuff(TIER, INSTANCE, 154, 85576) --Withering Winds
-- Heroic
module:RegisterDebuff(TIER, INSTANCE, 154, 93057, 5) --Slicing Gale

-- Al'Akir (155)
module:RegisterDebuff(TIER, INSTANCE, 155, 88301) --Acid Rain
module:RegisterDebuff(TIER, INSTANCE, 155, 87873) --Static Shock
module:RegisterDebuff(TIER, INSTANCE, 155, 88427) --Electrocute
module:RegisterDebuff(TIER, INSTANCE, 155, 89666) --Lightning Rod
module:RegisterDebuff(TIER, INSTANCE, 155, 89668) --Lightning Rod
module:RegisterDebuff(TIER, INSTANCE, 155, 87856) --Squall Line