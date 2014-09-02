------------------------------------------------------------
-- ThroneofThunder.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2013/03/14
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 5 -- MOP
local INSTANCE = 362 -- Terrace of Endless Spring

-- Jin'rokh the Breaker
module:RegisterDebuff(TIER, INSTANCE, 827, 138002)
module:RegisterDebuff(TIER, INSTANCE, 827, 138349)
module:RegisterDebuff(TIER, INSTANCE, 827, 138006)
module:RegisterDebuff(TIER, INSTANCE, 827, 137399)
module:RegisterDebuff(TIER, INSTANCE, 827, 137423, 5)
module:RegisterDebuff(TIER, INSTANCE, 827, 138732)
module:RegisterDebuff(TIER, INSTANCE, 827, 137371)

--Horridon
module:RegisterDebuff(TIER, INSTANCE, 819, 136767, 5)
module:RegisterDebuff(TIER, INSTANCE, 819, 136587, 5)
module:RegisterDebuff(TIER, INSTANCE, 819, 136710, 5)
module:RegisterDebuff(TIER, INSTANCE, 819, 136708)
module:RegisterDebuff(TIER, INSTANCE, 819, 136719)
module:RegisterDebuff(TIER, INSTANCE, 819, 136653)
module:RegisterDebuff(TIER, INSTANCE, 819, 136710)
module:RegisterDebuff(TIER, INSTANCE, 819, 136670)
module:RegisterDebuff(TIER, INSTANCE, 819, 136513)
module:RegisterDebuff(TIER, INSTANCE, 819, 136817)
module:RegisterDebuff(TIER, INSTANCE, 819, 136769)
module:RegisterDebuff(TIER, INSTANCE, 819, 136723)
module:RegisterDebuff(TIER, INSTANCE, 819, 136573)
module:RegisterDebuff(TIER, INSTANCE, 819, 136512)
module:RegisterDebuff(TIER, INSTANCE, 819, 136654)
module:RegisterDebuff(TIER, INSTANCE, 819, 140946)

--Council of Elders
module:RegisterDebuff(TIER, INSTANCE, 816, 136922, 5)
module:RegisterDebuff(TIER, INSTANCE, 816, 136878, 5)
module:RegisterDebuff(TIER, INSTANCE, 816, 137084, 5)
module:RegisterDebuff(TIER, INSTANCE, 816, 137650, 5)
module:RegisterDebuff(TIER, INSTANCE, 816, 136903)
module:RegisterDebuff(TIER, INSTANCE, 816, 136917)
module:RegisterDebuff(TIER, INSTANCE, 816, 136857)
module:RegisterDebuff(TIER, INSTANCE, 816, 137641)
module:RegisterDebuff(TIER, INSTANCE, 816, 137359)
module:RegisterDebuff(TIER, INSTANCE, 816, 137972)
module:RegisterDebuff(TIER, INSTANCE, 816, 136860)

--Tortos
module:RegisterDebuff(TIER, INSTANCE, 825, 134091)
module:RegisterDebuff(TIER, INSTANCE, 825, 134030)
module:RegisterDebuff(TIER, INSTANCE, 825, 134920)
module:RegisterDebuff(TIER, INSTANCE, 825, 136751)
module:RegisterDebuff(TIER, INSTANCE, 825, 136753)
module:RegisterDebuff(TIER, INSTANCE, 825, 137633)

--Megaera
module:RegisterDebuff(TIER, INSTANCE, 821, 137731, 5)
module:RegisterDebuff(TIER, INSTANCE, 821, 139909)
module:RegisterDebuff(TIER, INSTANCE, 821, 139841)
module:RegisterDebuff(TIER, INSTANCE, 821, 139839)
module:RegisterDebuff(TIER, INSTANCE, 821, 139822)
module:RegisterDebuff(TIER, INSTANCE, 821, 134396)
module:RegisterDebuff(TIER, INSTANCE, 821, 136892)
module:RegisterDebuff(TIER, INSTANCE, 821, 137746)
module:RegisterDebuff(TIER, INSTANCE, 821, 139993)
module:RegisterDebuff(TIER, INSTANCE, 821, 139843)
module:RegisterDebuff(TIER, INSTANCE, 821, 139840)
module:RegisterDebuff(TIER, INSTANCE, 821, 140179)


--Ji-Kun
module:RegisterDebuff(TIER, INSTANCE, 828, 138309, 4)
module:RegisterDebuff(TIER, INSTANCE, 828, 138319)
module:RegisterDebuff(TIER, INSTANCE, 828, 140571)
module:RegisterDebuff(TIER, INSTANCE, 828, 134372)
module:RegisterDebuff(TIER, INSTANCE, 828, 140092)
module:RegisterDebuff(TIER, INSTANCE, 828, 134256)
module:RegisterDebuff(TIER, INSTANCE, 828, 134366, 5)

--Durumu the Forgotten
module:RegisterDebuff(TIER, INSTANCE, 818, 133768, 5)
module:RegisterDebuff(TIER, INSTANCE, 818, 133767, 5)
module:RegisterDebuff(TIER, INSTANCE, 818, 133732, 5)
module:RegisterDebuff(TIER, INSTANCE, 818, 133677, 5)
module:RegisterDebuff(TIER, INSTANCE, 818, 133738, 5)
module:RegisterDebuff(TIER, INSTANCE, 818, 133767)
module:RegisterDebuff(TIER, INSTANCE, 818, 133795)
module:RegisterDebuff(TIER, INSTANCE, 818, 136932)
module:RegisterDebuff(TIER, INSTANCE, 818, 134122)
module:RegisterDebuff(TIER, INSTANCE, 818, 134123)
module:RegisterDebuff(TIER, INSTANCE, 818, 134124)
module:RegisterDebuff(TIER, INSTANCE, 818, 133597)
module:RegisterDebuff(TIER, INSTANCE, 818, 133598)
module:RegisterDebuff(TIER, INSTANCE, 818, 133737)
module:RegisterDebuff(TIER, INSTANCE, 818, 133675)
module:RegisterDebuff(TIER, INSTANCE, 818, 134626)

--Primordius
module:RegisterDebuff(TIER, INSTANCE, 820, 136050, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136180, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136181, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136182, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136183, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136184, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136185, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136186, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136187, 5)
module:RegisterDebuff(TIER, INSTANCE, 820, 136185)
module:RegisterDebuff(TIER, INSTANCE, 820, 136187)
module:RegisterDebuff(TIER, INSTANCE, 820, 136183)
module:RegisterDebuff(TIER, INSTANCE, 820, 136181)
module:RegisterDebuff(TIER, INSTANCE, 820, 140546)
module:RegisterDebuff(TIER, INSTANCE, 820, 136228)

--Dark Animus
module:RegisterDebuff(TIER, INSTANCE, 824, 138480)
module:RegisterDebuff(TIER, INSTANCE, 824, 138618)
module:RegisterDebuff(TIER, INSTANCE, 824, 138569)
module:RegisterDebuff(TIER, INSTANCE, 824, 138659, 4)
module:RegisterDebuff(TIER, INSTANCE, 824, 136954)
module:RegisterDebuff(TIER, INSTANCE, 824, 138609)
module:RegisterDebuff(TIER, INSTANCE, 824, 138691)
module:RegisterDebuff(TIER, INSTANCE, 824, 136962)

--Iron Qon
module:RegisterDebuff(TIER, INSTANCE, 817, 134691, 4)
module:RegisterDebuff(TIER, INSTANCE, 817, 134647, 5)
module:RegisterDebuff(TIER, INSTANCE, 817, 136520, 5)
module:RegisterDebuff(TIER, INSTANCE, 817, 137668, 5)
module:RegisterDebuff(TIER, INSTANCE, 817, 136193)
module:RegisterDebuff(TIER, INSTANCE, 817, 137669)
module:RegisterDebuff(TIER, INSTANCE, 817, 136892)
module:RegisterDebuff(TIER, INSTANCE, 817, 135147)
module:RegisterDebuff(TIER, INSTANCE, 817, 135145)
module:RegisterDebuff(TIER, INSTANCE, 817, 137654)
module:RegisterDebuff(TIER, INSTANCE, 817, 136577)
module:RegisterDebuff(TIER, INSTANCE, 817, 136192)
module:RegisterDebuff(TIER, INSTANCE, 817, 136615)

--Twin Consorts
module:RegisterDebuff(TIER, INSTANCE, 829, 137341)
module:RegisterDebuff(TIER, INSTANCE, 829, 137360, 4)
module:RegisterDebuff(TIER, INSTANCE, 829, 137440)
module:RegisterDebuff(TIER, INSTANCE, 829, 137417)
module:RegisterDebuff(TIER, INSTANCE, 829, 138306)
module:RegisterDebuff(TIER, INSTANCE, 829, 137408)
module:RegisterDebuff(TIER, INSTANCE, 829, 137375)
module:RegisterDebuff(TIER, INSTANCE, 829, 136722)

--Lei Shen
module:RegisterDebuff(TIER, INSTANCE, 832, 134912, 5)
module:RegisterDebuff(TIER, INSTANCE, 832, 135695)
module:RegisterDebuff(TIER, INSTANCE, 832, 136478)
module:RegisterDebuff(TIER, INSTANCE, 832, 136295)
module:RegisterDebuff(TIER, INSTANCE, 832, 135000)
module:RegisterDebuff(TIER, INSTANCE, 832, 394514)
module:RegisterDebuff(TIER, INSTANCE, 832, 136543)
module:RegisterDebuff(TIER, INSTANCE, 832, 134821)
module:RegisterDebuff(TIER, INSTANCE, 832, 136326)
module:RegisterDebuff(TIER, INSTANCE, 832, 137176)
module:RegisterDebuff(TIER, INSTANCE, 832, 136853)
module:RegisterDebuff(TIER, INSTANCE, 832, 135153)
module:RegisterDebuff(TIER, INSTANCE, 832, 136914)
module:RegisterDebuff(TIER, INSTANCE, 832, 135001)

-- Common
module:RegisterDebuff(TIER, INSTANCE, 0, 139550, 5)
module:RegisterDebuff(TIER, INSTANCE, 0, 139888, 5)
module:RegisterDebuff(TIER, INSTANCE, 0, 136753, 5)
module:RegisterDebuff(TIER, INSTANCE, 0, 140049)
module:RegisterDebuff(TIER, INSTANCE, 0, 139900)
module:RegisterDebuff(TIER, INSTANCE, 0, 136751)
module:RegisterDebuff(TIER, INSTANCE, 0, 140686)
module:RegisterDebuff(TIER, INSTANCE, 0, 140682)
module:RegisterDebuff(TIER, INSTANCE, 0, 140616)
module:RegisterDebuff(TIER, INSTANCE, 0, 139356)
