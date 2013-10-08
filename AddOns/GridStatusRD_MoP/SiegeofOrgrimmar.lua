--local zone = "Siege of Orgrimmar"
local zoneid = 953

-- Check Compatibility
if GridStatusRD_MoP.rd_version < 502 then
	return
end

--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
--true, true is for stackable

--Trash

-- Immerseus
GridStatusRaidDebuff:BossNameId(zoneid, 10, "Immerseus")
GridStatusRaidDebuff:DebuffId(zoneid, 143297, 11, 5, 5) --Sha Splash
GridStatusRaidDebuff:DebuffId(zoneid, 143459, 12, 4, 4, true, true) --Sha Residue
GridStatusRaidDebuff:DebuffId(zoneid, 143524, 13, 4, 4, true, true) --Purified Residue
GridStatusRaidDebuff:DebuffId(zoneid, 143286, 14, 4, 4) --Seeping Sha
GridStatusRaidDebuff:DebuffId(zoneid, 143413, 15, 3, 3) --Swirl
GridStatusRaidDebuff:DebuffId(zoneid, 143411, 16, 3, 3) --Swirl
GridStatusRaidDebuff:DebuffId(zoneid, 143436, 17, 2, 2, true, true) --Corrosive Blast (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 143579, 18, 3, 3, true, true) --Sha Corruption (Heroic Only)

-- Fallen Protectors
GridStatusRaidDebuff:BossNameId(zoneid, 20, "Fallen Protectors")
GridStatusRaidDebuff:DebuffId(zoneid, 143239, 21, 4, 4) --Noxious Poison
GridStatusRaidDebuff:DebuffId(zoneid, 144176, 22, 2, 2, true, true) --Lingering Anguish
GridStatusRaidDebuff:DebuffId(zoneid, 143023, 23, 3, 3) --Corrupted Brew
GridStatusRaidDebuff:DebuffId(zoneid, 143301, 24, 2, 2) --Gouge
GridStatusRaidDebuff:DebuffId(zoneid, 143564, 25, 3, 3) --Meditative Field
GridStatusRaidDebuff:DebuffId(zoneid, 143010, 26, 3, 3) --Corruptive Kick
GridStatusRaidDebuff:DebuffId(zoneid, 143434, 27, 6, 6) --Shadow Word:Bane (Dispell)
GridStatusRaidDebuff:DebuffId(zoneid, 143840, 28, 6, 6) --Mark of Anguish
GridStatusRaidDebuff:DebuffId(zoneid, 143959, 29, 4, 4) --Defiled Ground
GridStatusRaidDebuff:DebuffId(zoneid, 143423, 30, 6, 6) --Sha Sear
GridStatusRaidDebuff:DebuffId(zoneid, 143292, 31, 5, 5) --Fixate
GridStatusRaidDebuff:DebuffId(zoneid, 144176, 32, 5, 5, true, true) --Shadow Weakness
GridStatusRaidDebuff:DebuffId(zoneid, 147383, 33, 4, 4) --Debilitation (Heroic Only)

-- Norushen
GridStatusRaidDebuff:BossNameId(zoneid, 40, "Norushen")
GridStatusRaidDebuff:DebuffId(zoneid, 146124, 41, 2, 2, true, true) --Self Doubt (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 146324, 42, 4, 4, true, true) --Jealousy
GridStatusRaidDebuff:DebuffId(zoneid, 144639, 43, 6, 6) --Corruption
GridStatusRaidDebuff:DebuffId(zoneid, 144850, 44, 5, 5) --Test of Reliance
GridStatusRaidDebuff:DebuffId(zoneid, 145861, 45, 6, 6) --Self-Absorbed (Dispell)
GridStatusRaidDebuff:DebuffId(zoneid, 144851, 46, 2, 2) --Test of Confiidence (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 146703, 47, 3, 3) --Bottomless Pit
GridStatusRaidDebuff:DebuffId(zoneid, 144514, 48, 6, 6) --Lingering Corruption
GridStatusRaidDebuff:DebuffId(zoneid, 144849, 49, 4, 4) --Test of Serenity

-- Sha of Pride
GridStatusRaidDebuff:BossNameId(zoneid, 50, "Sha of Pride")
GridStatusRaidDebuff:DebuffId(zoneid, 144358, 51, 2, 2) --Wounded Pride (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 144843, 52, 3, 3) --Overcome
GridStatusRaidDebuff:DebuffId(zoneid, 146594, 53, 4, 4) --Gift of the Titans
GridStatusRaidDebuff:DebuffId(zoneid, 144351, 54, 6, 6, true, true) --Mark of Arrogance
GridStatusRaidDebuff:DebuffId(zoneid, 144364, 55, 4, 4) --Power of the Titans
GridStatusRaidDebuff:DebuffId(zoneid, 146822, 56, 6, 6) --Projection
GridStatusRaidDebuff:DebuffId(zoneid, 146817, 57, 5, 5) --Aura of Pride
GridStatusRaidDebuff:DebuffId(zoneid, 144774, 58, 2, 2) --Reaching Attacks (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 144636, 59, 5, 5) --Corrupted Prison
GridStatusRaidDebuff:DebuffId(zoneid, 144574, 60, 6, 6) --Corrupted Prison
GridStatusRaidDebuff:DebuffId(zoneid, 145215, 61, 4, 4) --Banishment (Heroic)
GridStatusRaidDebuff:DebuffId(zoneid, 147207, 62, 4, 4) --Weakened Resolve (Heroic)
GridStatusRaidDebuff:DebuffId(zoneid, 144574, 60, 6, 6) --Corrupted Prison
GridStatusRaidDebuff:DebuffId(zoneid, 144574, 60, 6, 6) --Corrupted Prison


-- Galakras
GridStatusRaidDebuff:BossNameId(zoneid, 70, "Galakras")
GridStatusRaidDebuff:DebuffId(zoneid, 146765, 71, 5, 5) --Flame Arrows
GridStatusRaidDebuff:DebuffId(zoneid, 147705, 72, 5, 5) --Poison Cloud
GridStatusRaidDebuff:DebuffId(zoneid, 146902, 73, 2, 2) --Poison Tipped blades

-- Iron Juggernaut
GridStatusRaidDebuff:BossNameId(zoneid, 80, "Iron Juggernaut")
GridStatusRaidDebuff:DebuffId(zoneid, 144467, 81, 2, 2, true, true) --Ignite Armor
GridStatusRaidDebuff:DebuffId(zoneid, 144459, 82, 5, 5) --Laser Burn
GridStatusRaidDebuff:DebuffId(zoneid, 144498, 83, 5, 5) --Napalm Oil
GridStatusRaidDebuff:DebuffId(zoneid, 144918, 84, 5, 5) --Cutter Laser
GridStatusRaidDebuff:DebuffId(zoneid, 146325, 84, 6, 6) --Cutter Laser Target

-- Kor'kron Dark Shaman
GridStatusRaidDebuff:BossNameId(zoneid, 90, "Kor'kron Dark Shaman")
GridStatusRaidDebuff:DebuffId(zoneid, 144089, 91, 6, 6) --Toxic Mist
GridStatusRaidDebuff:DebuffId(zoneid, 144215, 92, 2, 2) --Froststorm Strike (Tank only)
GridStatusRaidDebuff:DebuffId(zoneid, 143990, 93, 2, 2) --Foul Geyser (Tank only)
GridStatusRaidDebuff:DebuffId(zoneid, 144304, 94, 2, 2) --Rend 
GridStatusRaidDebuff:DebuffId(zoneid, 144330, 95, 6, 6) --Iron Prison (Heroic)

-- General Nazgrim
GridStatusRaidDebuff:BossNameId(zoneid, 100, "General Nazgrim")
GridStatusRaidDebuff:DebuffId(zoneid, 143638, 101, 6, 6) --Bonecracker
GridStatusRaidDebuff:DebuffId(zoneid, 143480, 102, 5, 5) --Assassin's Mark
GridStatusRaidDebuff:DebuffId(zoneid, 143431, 103, 6, 6) --Magistrike (Dispell)
GridStatusRaidDebuff:DebuffId(zoneid, 143494, 104, 2, 2, true, true) --Sundering Blow (Tanks) 
GridStatusRaidDebuff:DebuffId(zoneid, 143882, 105, 5, 5) --Hunter's Mark

-- Malkorok
GridStatusRaidDebuff:BossNameId(zoneid, 110, "Malkorok")
GridStatusRaidDebuff:DebuffId(zoneid, 142990, 111, 2, 2, true, true) --Fatal Strike (Tank debuff)
GridStatusRaidDebuff:DebuffId(zoneid, 142913, 112, 6, 6) --Displaced Energy (Dispell)
GridStatusRaidDebuff:DebuffId(zoneid, 143919, 113, 5, 5) --Languish (Heroic)

-- Malkorok
GridStatusRaidDebuff:BossNameId(zoneid, 120, "Spoils of Pandaria")
GridStatusRaidDebuff:DebuffId(zoneid, 145685, 121, 2, 2) --Unstable Defensive System
GridStatusRaidDebuff:DebuffId(zoneid, 144853, 122, 3, 3, true, true) --Carnivorous Bite
GridStatusRaidDebuff:DebuffId(zoneid, 145987, 123, 5, 5) --Set to Blow
GridStatusRaidDebuff:DebuffId(zoneid, 145218, 124, 4, 4, true, true) --Harden Flesh
GridStatusRaidDebuff:DebuffId(zoneid, 145230, 125, 1, 1) --Forbidden Magic
GridStatusRaidDebuff:DebuffId(zoneid, 146217, 126, 4, 4) --Keg Toss
GridStatusRaidDebuff:DebuffId(zoneid, 146235, 127, 4, 4) --Breath of Fire
GridStatusRaidDebuff:DebuffId(zoneid, 145523, 128, 4, 4) --Animated Strike
GridStatusRaidDebuff:DebuffId(zoneid, 142983, 129, 6, 6) --Torment (the new Wrack)
GridStatusRaidDebuff:DebuffId(zoneid, 145715, 130, 3, 3) --Blazing Charge
GridStatusRaidDebuff:DebuffId(zoneid, 145747, 131, 5, 5) --Bubbling Amber
GridStatusRaidDebuff:DebuffId(zoneid, 146289, 132, 4, 4) --Mass Paralysis

-- Thok the Bloodthirsty
GridStatusRaidDebuff:BossNameId(zoneid, 140, "Thok the Bloodthirsty")
GridStatusRaidDebuff:DebuffId(zoneid, 143766, 141, 2, 2, true, true) --Panic (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 143773, 142, 2, 2, true, true) --Freezing Breath (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 143452, 143, 1, 1) --Bloodied
GridStatusRaidDebuff:DebuffId(zoneid, 146589, 144, 5, 5) --Skeleton Key (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 143445, 145, 6, 6) --Fixate
GridStatusRaidDebuff:DebuffId(zoneid, 143791, 146, 5, 5) --Corrosive Blood
GridStatusRaidDebuff:DebuffId(zoneid, 143777, 147, 3, 3) --Frozen Solid (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 143780, 148, 4, 4, true, true) --Acid Breath
GridStatusRaidDebuff:DebuffId(zoneid, 143800, 149, 5, 5, true, true) --Icy Blood
GridStatusRaidDebuff:DebuffId(zoneid, 143428, 150, 4, 4) --Tail Lash

-- Siegecrafter Blackfuse
GridStatusRaidDebuff:BossNameId(zoneid, 160, "Siegecrafter Blackfuse")
GridStatusRaidDebuff:DebuffId(zoneid, 144236, 161, 4, 4) --Pattern Recognition
GridStatusRaidDebuff:DebuffId(zoneid, 144466, 162, 5, 5) --Magnetic Crush
GridStatusRaidDebuff:DebuffId(zoneid, 143385, 163, 2, 2, true, true) --Electrostatic Charge (tank)
GridStatusRaidDebuff:DebuffId(zoneid, 143856, 164, 6, 6, true, true) --Superheated

-- Paragons of the Klaxxi
GridStatusRaidDebuff:BossNameId(zoneid, 170, "Paragons of the Klaxxi")
GridStatusRaidDebuff:DebuffId(zoneid, 143617, 171, 5, 5, true, true) --Blue Bomb
GridStatusRaidDebuff:DebuffId(zoneid, 143701, 172, 5, 5) --Whirling (stun)
GridStatusRaidDebuff:DebuffId(zoneid, 143702, 173, 5, 5) --Whirling
GridStatusRaidDebuff:DebuffId(zoneid, 142808, 174, 6, 6) --Fiery Edge
GridStatusRaidDebuff:DebuffId(zoneid, 143609, 175, 5, 5, true, true) --Yellow Sword
GridStatusRaidDebuff:DebuffId(zoneid, 143610, 176, 5, 5, true, true) --Red Drum
GridStatusRaidDebuff:DebuffId(zoneid, 142931, 177, 2, 2, true, true) --Exposed Veins
GridStatusRaidDebuff:DebuffId(zoneid, 143619, 178, 5, 5, true, true) --Yellow Bomb
GridStatusRaidDebuff:DebuffId(zoneid, 143735, 179, 6, 6) --Caustic Amber
GridStatusRaidDebuff:DebuffId(zoneid, 146452, 180, 5, 5) --Resonating Amber
GridStatusRaidDebuff:DebuffId(zoneid, 142929, 181, 2, 2, true, true) --Tenderizing Strikes
GridStatusRaidDebuff:DebuffId(zoneid, 142797, 182, 5, 5) --Noxious Vapors
GridStatusRaidDebuff:DebuffId(zoneid, 143939, 183, 5, 5) --Gouge
GridStatusRaidDebuff:DebuffId(zoneid, 143275, 184, 2, 2, true, true) --Hewn
GridStatusRaidDebuff:DebuffId(zoneid, 143768, 185, 2, 2) --Sonic Projection
GridStatusRaidDebuff:DebuffId(zoneid, 142532, 186, 6, 6) --Toxin: Blue
GridStatusRaidDebuff:DebuffId(zoneid, 142534, 187, 6, 6) --Toxin: Yellow
GridStatusRaidDebuff:DebuffId(zoneid, 143279, 188, 2, 2, true, true) --Genetic Alteration
GridStatusRaidDebuff:DebuffId(zoneid, 143339, 189, 6, 6, true, true) --Injection
GridStatusRaidDebuff:DebuffId(zoneid, 142649, 190, 4, 4) --Devour
GridStatusRaidDebuff:DebuffId(zoneid, 146556, 191, 6, 6) --Pierce
GridStatusRaidDebuff:DebuffId(zoneid, 142671, 192, 6, 6) --Mesmerize
GridStatusRaidDebuff:DebuffId(zoneid, 143979, 193, 2, 2, true, true) --Vicious Assault
GridStatusRaidDebuff:DebuffId(zoneid, 143607, 194, 5, 5, true, true) --Blue Sword
GridStatusRaidDebuff:DebuffId(zoneid, 143614, 195, 5, 5, true, true) --Yellow Drum
GridStatusRaidDebuff:DebuffId(zoneid, 143612, 196, 5, 5, true, true) --Blue Drum
GridStatusRaidDebuff:DebuffId(zoneid, 142533, 197, 6, 6) --Toxin: Red 
GridStatusRaidDebuff:DebuffId(zoneid, 143615, 198, 5, 5, true, true) --Red Bomb
GridStatusRaidDebuff:DebuffId(zoneid, 143974, 199, 2, 2) --Shield Bash (tanks)

-- Garrosh Hellscream
GridStatusRaidDebuff:BossNameId(zoneid, 210, "Garrosh Hellscream")
GridStatusRaidDebuff:DebuffId(zoneid, 144582, 211, 4, 4) --Hamstring
GridStatusRaidDebuff:DebuffId(zoneid, 144954, 212, 4, 4) --Realm of Y'Shaarj
GridStatusRaidDebuff:DebuffId(zoneid, 145183, 213, 2, 2, true, true) --Gripping Despair (tanks)
GridStatusRaidDebuff:DebuffId(zoneid, 144762, 214, 4, 4) --Desecrated
GridStatusRaidDebuff:DebuffId(zoneid, 145071, 215, 5, 5) --Touch of Y'Sharrj
GridStatusRaidDebuff:DebuffId(zoneid, 148718, 216, 4, 4) --Fire Pit
