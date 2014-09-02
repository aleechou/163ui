------------------------------------------------------------
-- HeartOfFear.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2012/11/06
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 5 -- MOP
local INSTANCE = 330 -- Heart of Fear

--Imperial Vizier Zor'lok 745
module:RegisterDebuff(TIER, INSTANCE, 745, 122760) --Exhale
module:RegisterDebuff(TIER, INSTANCE, 745, 123812) --Pheromones of Zeal
module:RegisterDebuff(TIER, INSTANCE, 745, 122740, 5) --Convert
module:RegisterDebuff(TIER, INSTANCE, 745, 122706) --Noise Cancelling
module:RegisterDebuff(TIER, INSTANCE, 745, 122761)

--Blade Lord Ta'yak 744
module:RegisterDebuff(TIER, INSTANCE, 744, 122949) --Unseen Strike
module:RegisterDebuff(TIER, INSTANCE, 744, 123474, 5) --Overwhelming Assault
module:RegisterDebuff(TIER, INSTANCE, 744, 124783) --Storm Unleashed
module:RegisterDebuff(TIER, INSTANCE, 744, 123600) --Storm Unleashed?
module:RegisterDebuff(TIER, INSTANCE, 744, 123180) --Windstep

--Garalon 713
module:RegisterDebuff(TIER, INSTANCE, 713, 122835) --Pheromones
module:RegisterDebuff(TIER, INSTANCE, 713, 123081, 5) --Pungency
module:RegisterDebuff(TIER, INSTANCE, 713, 122774) --Crush (knocked down)
module:RegisterDebuff(TIER, INSTANCE, 713, 123423) --Weak Points (damage increase)
module:RegisterDebuff(TIER, INSTANCE, 713, 123120) --Pheromone Trail
module:RegisterDebuff(TIER, INSTANCE, 713, 129815)

--Wind Lord Mel'jarak 741
module:RegisterDebuff(TIER, INSTANCE, 741, 121881) --Amber Prison
module:RegisterDebuff(TIER, INSTANCE, 741, 122055) --Residue
module:RegisterDebuff(TIER, INSTANCE, 741, 122064, 5) --Corrosive Resin
module:RegisterDebuff(TIER, INSTANCE, 741, 122409)

--Amber-Shaper Un'sok 737
module:RegisterDebuff(TIER, INSTANCE, 737, 122064, 5) --Corrosive Resin
module:RegisterDebuff(TIER, INSTANCE, 737, 121949) --Parasitic Growth
module:RegisterDebuff(TIER, INSTANCE, 737, 122784) --Reshape Life
module:RegisterDebuff(TIER, INSTANCE, 737, 122504) --Burning Amber
module:RegisterDebuff(TIER, INSTANCE, 737, 122370, 5)
module:RegisterDebuff(TIER, INSTANCE, 737, 122389)
module:RegisterDebuff(TIER, INSTANCE, 737, 122413)

--Grand Empress Shek'zeer 743
module:RegisterDebuff(TIER, INSTANCE, 743, 123707, 5) --Eyes of the Empress
module:RegisterDebuff(TIER, INSTANCE, 743, 125390) --Fixate
module:RegisterDebuff(TIER, INSTANCE, 743, 123788) --Cry of Terror
module:RegisterDebuff(TIER, INSTANCE, 743, 124097) --Sticky Resin
module:RegisterDebuff(TIER, INSTANCE, 743, 123184) --Dissonance Field (unhealable)
module:RegisterDebuff(TIER, INSTANCE, 743, 125824) --Trapped!
module:RegisterDebuff(TIER, INSTANCE, 743, 124777) --Poison Bomb
module:RegisterDebuff(TIER, INSTANCE, 743, 124821) --Poison-Drenched Armor
module:RegisterDebuff(TIER, INSTANCE, 743, 124827) --Poison Fumes
module:RegisterDebuff(TIER, INSTANCE, 743, 124849) --Consuming Terror
module:RegisterDebuff(TIER, INSTANCE, 743, 124863) --Visions of Demise
module:RegisterDebuff(TIER, INSTANCE, 743, 124862) --Visions of Demise: Target
module:RegisterDebuff(TIER, INSTANCE, 743, 123845) --Heart of Fear: Chosen
module:RegisterDebuff(TIER, INSTANCE, 743, 123846) --Heart of Fear: Lure
module:RegisterDebuff(TIER, INSTANCE, 743, 125283) --Sha Corruption
module:RegisterDebuff(TIER, INSTANCE, 743, 123713)
module:RegisterDebuff(TIER, INSTANCE, 743, 123735)
module:RegisterDebuff(TIER, INSTANCE, 743, 125638)

module:RegisterDebuff(TIER, INSTANCE, 0, 123417, 5) --Dismantled Armor (armor)
module:RegisterDebuff(TIER, INSTANCE, 0, 123422) -- Arterial Bleeding (dot)
module:RegisterDebuff(TIER, INSTANCE, 0, 123434) -- Gouge Throat (silence)
module:RegisterDebuff(TIER, INSTANCE, 0, 123436) -- Riposte (disarm)
module:RegisterDebuff(TIER, INSTANCE, 0, 123497) -- Gale Force Winds (slows casting)
module:RegisterDebuff(TIER, INSTANCE, 0, 123180) --Wind Step (dot)
module:RegisterDebuff(TIER, INSTANCE, 0, 123420) --Stunning Strike (stun)
module:RegisterDebuff(TIER, INSTANCE, 0, 125081) --Slam (stun)
module:RegisterDebuff(TIER, INSTANCE, 0, 125490) --Burning Sting (dot)
module:RegisterDebuff(TIER, INSTANCE, 0, 126901, 5) --Mortal Rend (tank, stackable healing debuff)
module:RegisterDebuff(TIER, INSTANCE, 0, 126912) --Grievous Whirl (dot removed when target healed to 90%)
module:RegisterDebuff(TIER, INSTANCE, 0, 125907) --Cry Havoc
