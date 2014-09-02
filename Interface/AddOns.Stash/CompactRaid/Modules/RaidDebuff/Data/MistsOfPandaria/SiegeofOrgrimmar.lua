------------------------------------------------------------
-- SiegeOfOrgrimmar.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2013/09/12
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 5 -- Mists of Pandaria

-- Immerseus
module:RegisterDebuff(TIER, 369, 852, 143437, 5)
module:RegisterDebuff(TIER, 369, 852, 143297) --Sha Splash
module:RegisterDebuff(TIER, 369, 852, 143459, 5) --Sha Residue
module:RegisterDebuff(TIER, 369, 852, 143524, 5) --Purified Residue
module:RegisterDebuff(TIER, 369, 852, 143286) --Seeping Sha
module:RegisterDebuff(TIER, 369, 852, 143413) --Swirl
module:RegisterDebuff(TIER, 369, 852, 143411) --Swirl
module:RegisterDebuff(TIER, 369, 852, 143436) --Corrosive Blast (tanks)
module:RegisterDebuff(TIER, 369, 852, 143579) --Sha Corruption (Heroic Only)

-- Fallen Protectors
module:RegisterDebuff(TIER, 369, 849, 143962)
module:RegisterDebuff(TIER, 369, 849, 144396)
module:RegisterDebuff(TIER, 369, 849, 143009)
module:RegisterDebuff(TIER, 369, 849, 143198, 5)
module:RegisterDebuff(TIER, 369, 849, 143879)
module:RegisterDebuff(TIER, 369, 849, 143239) --Noxious Poison
module:RegisterDebuff(TIER, 369, 849, 144176, 5) --Lingering Anguish
module:RegisterDebuff(TIER, 369, 849, 143023) --Corrupted Brew
module:RegisterDebuff(TIER, 369, 849, 143301) --Gouge
module:RegisterDebuff(TIER, 369, 849, 143564) --Meditative Field
module:RegisterDebuff(TIER, 369, 849, 143010) --Corruptive Kick
module:RegisterDebuff(TIER, 369, 849, 143434) --Shadow Word:Bane (Dispell)
module:RegisterDebuff(TIER, 369, 849, 143840, 5) --Mark of Anguish
module:RegisterDebuff(TIER, 369, 849, 143959) --Defiled Ground
module:RegisterDebuff(TIER, 369, 849, 143423) --Sha Sear
module:RegisterDebuff(TIER, 369, 849, 143292) --Fixate
module:RegisterDebuff(TIER, 369, 849, 144176, 5) --Shadow Weakness
module:RegisterDebuff(TIER, 369, 849, 147383, 1) --Debilitation (Heroic Only)

-- Norushen
module:RegisterDebuff(TIER, 369, 866, 146124, 5) --Self Doubt (tanks)
module:RegisterDebuff(TIER, 369, 866, 146324, 5) --Jealousy
module:RegisterDebuff(TIER, 369, 866, 144639) --Corruption
module:RegisterDebuff(TIER, 369, 866, 144850) --Test of Reliance
module:RegisterDebuff(TIER, 369, 866, 145861) --Self-Absorbed (Dispell)
module:RegisterDebuff(TIER, 369, 866, 144851) --Test of Confiidence (tanks)
module:RegisterDebuff(TIER, 369, 866, 146703) --Bottomless Pit
module:RegisterDebuff(TIER, 369, 866, 144514) --Lingering Corruption
module:RegisterDebuff(TIER, 369, 866, 144849) --Test of Serenity

-- Sha of Pride
module:RegisterDebuff(TIER, 369, 867, 146595, 5)
module:RegisterDebuff(TIER, 369, 867, 144684)
module:RegisterDebuff(TIER, 369, 867, 144358) --Wounded Pride (tanks)
module:RegisterDebuff(TIER, 369, 867, 144843) --Overcome
module:RegisterDebuff(TIER, 369, 867, 146594) --Gift of the Titans
module:RegisterDebuff(TIER, 369, 867, 144351, 5) --Mark of Arrogance
module:RegisterDebuff(TIER, 369, 867, 144364) --Power of the Titans
module:RegisterDebuff(TIER, 369, 867, 146822) --Projection
module:RegisterDebuff(TIER, 369, 867, 146817, 5) --Aura of Pride
module:RegisterDebuff(TIER, 369, 867, 144774) --Reaching Attacks (tanks)
module:RegisterDebuff(TIER, 369, 867, 144636) --Corrupted Prison
module:RegisterDebuff(TIER, 369, 867, 144574) --Corrupted Prison
module:RegisterDebuff(TIER, 369, 867, 145215) --Banishment (Heroic)
module:RegisterDebuff(TIER, 369, 867, 147207) --Weakened Resolve (Heroic)
module:RegisterDebuff(TIER, 369, 867, 144574) --Corrupted Prison
module:RegisterDebuff(TIER, 369, 867, 144574) --Corrupted Prison
module:RegisterDebuff(TIER, 369, 867, 147028)


-- Galakras
module:RegisterDebuff(TIER, 369, 881, 146764, 5)
module:RegisterDebuff(TIER, 369, 881, 147068, 5)
module:RegisterDebuff(TIER, 369, 881, 147042)
module:RegisterDebuff(TIER, 369, 881, 146765) --Flame Arrows
module:RegisterDebuff(TIER, 369, 881, 147705) --Poison Cloud
module:RegisterDebuff(TIER, 369, 881, 146902) --Poison Tipped blades

-- Iron Juggernaut
module:RegisterDebuff(TIER, 369, 864, 144467, 5) --Ignite Armor
module:RegisterDebuff(TIER, 369, 864, 144459) --Laser Burn
module:RegisterDebuff(TIER, 369, 864, 144498) --Napalm Oil
module:RegisterDebuff(TIER, 369, 864, 144918) --Cutter Laser
module:RegisterDebuff(TIER, 369, 864, 146325) --Cutter Laser Target

-- Kor'kron Dark Shaman
module:RegisterDebuff(TIER, 369, 856, 144107, 5)
module:RegisterDebuff(TIER, 369, 856, 144089) --Toxic Mist
module:RegisterDebuff(TIER, 369, 856, 144215) --Froststorm Strike (Tank only)
module:RegisterDebuff(TIER, 369, 856, 143990) --Foul Geyser (Tank only)
module:RegisterDebuff(TIER, 369, 856, 144304) --Rend 
module:RegisterDebuff(TIER, 369, 856, 144330) --Iron Prison (Heroic)
module:RegisterDebuff(TIER, 369, 856, 144331, 5)

-- General Nazgrim
module:RegisterDebuff(TIER, 369, 850, 143638) --Bonecracker
module:RegisterDebuff(TIER, 369, 850, 143480) --Assassin's Mark
module:RegisterDebuff(TIER, 369, 850, 143431) --Magistrike (Dispell)
module:RegisterDebuff(TIER, 369, 850, 143494, 5) --Sundering Blow (Tanks) 
module:RegisterDebuff(TIER, 369, 850, 143882) --Hunter's Mark

-- Malkorok
module:RegisterDebuff(TIER, 369, 846, 142863)
module:RegisterDebuff(TIER, 369, 846, 142864, 5)
module:RegisterDebuff(TIER, 369, 846, 142865)
module:RegisterDebuff(TIER, 369, 846, 142990, 5) --Fatal Strike (Tank debuff)
module:RegisterDebuff(TIER, 369, 846, 142913, 5) --Displaced Energy (Dispell)
module:RegisterDebuff(TIER, 369, 846, 143919) --Languish (Heroic)

-- Spoils of Pandaria
module:RegisterDebuff(TIER, 369, 870, 122962)
module:RegisterDebuff(TIER, 369, 870, 145685) --Unstable Defensive System
module:RegisterDebuff(TIER, 369, 870, 144853, 5) --Carnivorous Bite
module:RegisterDebuff(TIER, 369, 870, 145987) --Set to Blow
module:RegisterDebuff(TIER, 369, 870, 145218, 5) --Harden Flesh
module:RegisterDebuff(TIER, 369, 870, 145230) --Forbidden Magic
module:RegisterDebuff(TIER, 369, 870, 146217) --Keg Toss
module:RegisterDebuff(TIER, 369, 870, 146235) --Breath of Fire
module:RegisterDebuff(TIER, 369, 870, 145523) --Animated Strike
module:RegisterDebuff(TIER, 369, 870, 142983) --Torment (the new Wrack)
module:RegisterDebuff(TIER, 369, 870, 145715) --Blazing Charge
module:RegisterDebuff(TIER, 369, 870, 145747) --Bubbling Amber
module:RegisterDebuff(TIER, 369, 870, 146289) --Mass Paralysis

-- Thok the Bloodthirsty
module:RegisterDebuff(TIER, 369, 851, 143426)
module:RegisterDebuff(TIER, 369, 851, 146540)
module:RegisterDebuff(TIER, 369, 851, 133636)
module:RegisterDebuff(TIER, 369, 851, 143767)
module:RegisterDebuff(TIER, 369, 851, 143766, 5) --Panic (tanks)
module:RegisterDebuff(TIER, 369, 851, 143773, 5) --Freezing Breath (tanks)
module:RegisterDebuff(TIER, 369, 851, 143452) --Bloodied
module:RegisterDebuff(TIER, 369, 851, 146589) --Skeleton Key (tanks)
module:RegisterDebuff(TIER, 369, 851, 143445) --Fixate
module:RegisterDebuff(TIER, 369, 851, 143791) --Corrosive Blood
module:RegisterDebuff(TIER, 369, 851, 143777, 5) --Frozen Solid (tanks)
module:RegisterDebuff(TIER, 369, 851, 143780, 5) --Acid Breath
module:RegisterDebuff(TIER, 369, 851, 143800, 5) --Icy Blood
module:RegisterDebuff(TIER, 369, 851, 143428) --Tail Lash

-- Siegecrafter Blackfuse
module:RegisterDebuff(TIER, 369, 865, 144236) --Pattern Recognition
module:RegisterDebuff(TIER, 369, 865, 144466) --Magnetic Crush
module:RegisterDebuff(TIER, 369, 865, 143385, 5) --Electrostatic Charge (tank)
module:RegisterDebuff(TIER, 369, 865, 143856, 5) --Superheated

-- Paragons of the Klaxxi
module:RegisterDebuff(TIER, 369, 853, 142315)
module:RegisterDebuff(TIER, 369, 853, 142877)
module:RegisterDebuff(TIER, 369, 853, 142668)
module:RegisterDebuff(TIER, 369, 853, 143617, 5) --Blue Bomb
module:RegisterDebuff(TIER, 369, 853, 143701) --Whirling (stun)
module:RegisterDebuff(TIER, 369, 853, 143702, 5) --Whirling
module:RegisterDebuff(TIER, 369, 853, 142808) --Fiery Edge
module:RegisterDebuff(TIER, 369, 853, 143609, 5) --Yellow Sword
module:RegisterDebuff(TIER, 369, 853, 143610, 5) --Red Drum
module:RegisterDebuff(TIER, 369, 853, 142931, 5) --Exposed Veins
module:RegisterDebuff(TIER, 369, 853, 143619, 5) --Yellow Bomb
module:RegisterDebuff(TIER, 369, 853, 143735) --Caustic Amber
module:RegisterDebuff(TIER, 369, 853, 146452) --Resonating Amber
module:RegisterDebuff(TIER, 369, 853, 142929, 5) --Tenderizing Strikes
module:RegisterDebuff(TIER, 369, 853, 142797) --Noxious Vapors
module:RegisterDebuff(TIER, 369, 853, 143939) --Gouge
module:RegisterDebuff(TIER, 369, 853, 143275, 5) --Hewn
module:RegisterDebuff(TIER, 369, 853, 143768) --Sonic Projection
module:RegisterDebuff(TIER, 369, 853, 142532) --Toxin: Blue
module:RegisterDebuff(TIER, 369, 853, 142534) --Toxin: Yellow
module:RegisterDebuff(TIER, 369, 853, 143279, 5) --Genetic Alteration
module:RegisterDebuff(TIER, 369, 853, 143339, 5) --Injection
module:RegisterDebuff(TIER, 369, 853, 142649) --Devour
module:RegisterDebuff(TIER, 369, 853, 146556) --Pierce
module:RegisterDebuff(TIER, 369, 853, 142671) --Mesmerize
module:RegisterDebuff(TIER, 369, 853, 143979, 5) --Vicious Assault
module:RegisterDebuff(TIER, 369, 853, 143607, 5) --Blue Sword
module:RegisterDebuff(TIER, 369, 853, 143614, 5) --Yellow Drum
module:RegisterDebuff(TIER, 369, 853, 143612, 5) --Blue Drum
module:RegisterDebuff(TIER, 369, 853, 142533) --Toxin: Red 
module:RegisterDebuff(TIER, 369, 853, 143615, 5) --Red Bomb
module:RegisterDebuff(TIER, 369, 853, 143974) --Shield Bash (tanks)
module:RegisterDebuff(TIER, 369, 853, 142948, 4)

-- Garrosh Hellscream
module:RegisterDebuff(TIER, 369, 869, 144582) --Hamstring
module:RegisterDebuff(TIER, 369, 869, 144954) --Realm of Y'Shaarj
module:RegisterDebuff(TIER, 369, 869, 145183, 5) --Gripping Despair (tanks)
module:RegisterDebuff(TIER, 369, 869, 144762) --Desecrated
module:RegisterDebuff(TIER, 369, 869, 145071) --Touch of Y'Sharrj
module:RegisterDebuff(TIER, 369, 869, 148718) --Fire Pit
module:RegisterDebuff(TIER, 369, 869, 145999)

-- Common
module:RegisterDebuff(TIER, 369, 0, 145553, 5)
module:RegisterDebuff(TIER, 369, 0, 25195)
