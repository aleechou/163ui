------------------------------------------------------------
-- BaradinHold.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2012/09/07
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 4 -- Cataclysm
local INSTANCE = 75 -- Baradin Hold

-- Argaloth (139)
module:RegisterDebuff(TIER, INSTANCE, 139, 88942) --Meteor Slash
module:RegisterDebuff(TIER, INSTANCE, 139, 88954, 5) --Consuming Darkness

-- Occu'thar (140)
module:RegisterDebuff(TIER, INSTANCE, 140, 96884) --Focused Fire
module:RegisterDebuff(TIER, INSTANCE, 140, 96913, 5) --Searing Shadows
module:RegisterDebuff(TIER, INSTANCE, 140, 97028) --Gaze of Occu'thar

-- Alizabal (339)
module:RegisterDebuff(TIER, INSTANCE, 339, 104936, 5)
module:RegisterDebuff(TIER, INSTANCE, 339, 108094)
module:RegisterDebuff(TIER, INSTANCE, 339, 105067) --Seething Hate

-- Trash
module:RegisterDebuff(TIER, INSTANCE, 0, 89354) --Arcane Amplifier
module:RegisterDebuff(TIER, INSTANCE, 0, 105859) --Run Through