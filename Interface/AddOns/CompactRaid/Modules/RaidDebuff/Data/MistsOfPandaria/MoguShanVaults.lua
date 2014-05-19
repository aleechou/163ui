------------------------------------------------------------
-- MoguShanVaults.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2012/11/06
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 5 -- MOP
local INSTANCE = 317 -- Mogu'shan Vaults

--The Stone Guard 679
module:RegisterDebuff(TIER, INSTANCE, 679, 130404) --Jasper Chains
module:RegisterDebuff(TIER, INSTANCE, 679, 130774) --Amethyst Pool
module:RegisterDebuff(TIER, INSTANCE, 679, 116281) --Cobalt Mine Blast
module:RegisterDebuff(TIER, INSTANCE, 679, 125206) --Rend Flesh: Tank only
module:RegisterDebuff(TIER, INSTANCE, 679, 130395, 5) --Jasper Chains: Stacks
module:RegisterDebuff(TIER, INSTANCE, 679, 116038, 5) --Jasper Petrification: stacks
module:RegisterDebuff(TIER, INSTANCE, 679, 115861, 5) --Cobalt Petrification: stacks
module:RegisterDebuff(TIER, INSTANCE, 679, 116060, 5) --Amethyst Petrification: stacks
module:RegisterDebuff(TIER, INSTANCE, 679, 116008, 5) --Jade Petrification: stacks
module:RegisterDebuff(TIER, INSTANCE, 679, 116322)
module:RegisterDebuff(TIER, INSTANCE, 679, 116199)
module:RegisterDebuff(TIER, INSTANCE, 679, 116301)
module:RegisterDebuff(TIER, INSTANCE, 679, 116304)

--Feng The Accursed 689
module:RegisterDebuff(TIER, INSTANCE, 689, 116942, 4) --Flaming Spear
module:RegisterDebuff(TIER, INSTANCE, 689, 131790, 4) --Arcane Shock: Stack
module:RegisterDebuff(TIER, INSTANCE, 689, 116417, 5) --Arcane Resonance
module:RegisterDebuff(TIER, INSTANCE, 689, 131788, 5) --Lightning Lash
module:RegisterDebuff(TIER, INSTANCE, 689, 116040) --Epicenter
module:RegisterDebuff(TIER, INSTANCE, 689, 116784) --Wildfire Spark
module:RegisterDebuff(TIER, INSTANCE, 689, 102464) --Arcane Shock: AOE
module:RegisterDebuff(TIER, INSTANCE, 689, 116364) --Arcane Resonance
module:RegisterDebuff(TIER, INSTANCE, 689, 116374) --Lightning Charge: Stun effect
module:RegisterDebuff(TIER, INSTANCE, 689, 131792, 4) --Flaming Spear
module:RegisterDebuff(TIER, INSTANCE, 689, 116577, 5)

--Gara'jal the Spiritbinder 682
module:RegisterDebuff(TIER, INSTANCE, 682, 122151) --Voodoo Doll
module:RegisterDebuff(TIER, INSTANCE, 682, 117549) --Spiritual Innervation
module:RegisterDebuff(TIER, INSTANCE, 682, 116272) --Banishment
module:RegisterDebuff(TIER, INSTANCE, 682, 117723) --Frail Soul: HEROIC ONLY
module:RegisterDebuff(TIER, INSTANCE, 682, 116260) --Crossed Over
module:RegisterDebuff(TIER, INSTANCE, 682, 116278, 5) -- Soul Sever
module:RegisterDebuff(TIER, INSTANCE, 682, 96689)
module:RegisterDebuff(TIER, INSTANCE, 682, 116000)

--The Spirit Kings 687
module:RegisterDebuff(TIER, INSTANCE, 687, 117685) --Charged Shadows
module:RegisterDebuff(TIER, INSTANCE, 687, 117506) --Undying Shadows
module:RegisterDebuff(TIER, INSTANCE, 687, 118048) --Pillaged
module:RegisterDebuff(TIER, INSTANCE, 687, 118303) --Undying Shadows:Fixate
module:RegisterDebuff(TIER, INSTANCE, 687, 117708) --Maddening Shout
module:RegisterDebuff(TIER, INSTANCE, 687, 118135) --Pinned Down
module:RegisterDebuff(TIER, INSTANCE, 687, 118047) --Pillage
module:RegisterDebuff(TIER, INSTANCE, 687, 118162) --Sleight of Hand
module:RegisterDebuff(TIER, INSTANCE, 687, 118163) --Robbed Blind
module:RegisterDebuff(TIER, INSTANCE, 687, 118141)

--Elegon 726
module:RegisterDebuff(TIER, INSTANCE, 726, 117878, 5) --Overcharged
module:RegisterDebuff(TIER, INSTANCE, 726, 117949) --Closed circuit (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 726, 117945) --Arcing Energy
module:RegisterDebuff(TIER, INSTANCE, 726, 132222) --Arcing Energy
module:RegisterDebuff(TIER, INSTANCE, 726, 132226)

--Will of the Emperor 677
module:RegisterDebuff(TIER, INSTANCE, 677, 116525) --Focused Assault
module:RegisterDebuff(TIER, INSTANCE, 677, 116778) --Focused Defense
module:RegisterDebuff(TIER, INSTANCE, 677, 117485) --Impeding Thrust
module:RegisterDebuff(TIER, INSTANCE, 677, 116550) --Energizing Smash
module:RegisterDebuff(TIER, INSTANCE, 677, 116829) --Focused Energy
module:RegisterDebuff(TIER, INSTANCE, 677, 116835, 5) -- Devastating Arc
module:RegisterDebuff(TIER, INSTANCE, 677, 132425)


--Trash
module:RegisterDebuff(TIER, INSTANCE, 0, 125092, 5) --Petrification
module:RegisterDebuff(TIER, INSTANCE, 0, 116970, 5) --Sundering Bite
module:RegisterDebuff(TIER, INSTANCE, 0, 121087) --Ground Slam
module:RegisterDebuff(TIER, INSTANCE, 0, 121245) --Curse of Vitality (Curse)
module:RegisterDebuff(TIER, INSTANCE, 0, 121247) --Impale
module:RegisterDebuff(TIER, INSTANCE, 0, 116596) --Smoke Bomb
module:RegisterDebuff(TIER, INSTANCE, 0, 120670) --Pyroblast
module:RegisterDebuff(TIER, INSTANCE, 0, 116606) --Troll Rush
module:RegisterDebuff(TIER, INSTANCE, 0, 118552, 5) --Flesh to Stone (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 0, 118562) --Petrified