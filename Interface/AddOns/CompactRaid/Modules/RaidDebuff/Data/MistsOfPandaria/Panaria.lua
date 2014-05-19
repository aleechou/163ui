------------------------------------------------------------
-- Panaria.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2013/09/12
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 5 -- Mists of Panaria
local INSTANCE = 322 -- Panaria

module:RegisterDebuff(TIER, INSTANCE, 691, 119622) --Growing Anger
module:RegisterDebuff(TIER, INSTANCE, 691, 119626) --Aggressive Behavior
module:RegisterDebuff(TIER, INSTANCE, 691, 119601) --Bitter Thoughts
module:RegisterDebuff(TIER, INSTANCE, 691, 119610) --Bitter Thoughts
module:RegisterDebuff(TIER, INSTANCE, 691, 119487) --Seethe
module:RegisterDebuff(TIER, INSTANCE, 691, 119488) --Unleashed Wrath

module:RegisterDebuff(TIER, INSTANCE, 861, 144690, 5)
