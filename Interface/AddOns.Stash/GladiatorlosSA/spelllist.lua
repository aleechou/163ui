function GladiatorlosSA:GetSpellList ()
	return {
		auraApplied ={					-- aura applied [spellid] = ".mp3 file name",
			--general
			--druid
				-- OLD
			[61336] = "survivalInstincts", -- 求生本能
			[29166] = "innervate", -- 啟動
			[22812] = "barkskin", -- 樹皮術
			[132158] = "naturesSwiftness", -- 自然迅捷
			[16689] = "naturesGrasp", -- 自然之握
			[22842] = "frenziedRegeneration", -- 狂暴恢復
			[5229] = "enrage", -- 狂怒
			[1850] = "dash", -- 疾奔
			[50334] = "berserk", -- 狂暴
			[69369] = "predatorSwiftness", -- PredatorSwiftness 猛獸迅捷
			
				-- Mist of Pandaria
			[124974] = "natureVigil", --
			[106922] = "mightOfUrsoc", --
			[112071] = "celestialAlignment", --
			[102342] = "ironBark",
			[110575] = "sIcebound", -- symbiosis
			[110570] = "sAntiMagicShell", --symbiosis
			[110617] = "sDeterrance", --symbiosis
			[110696] = "sIceBlock", --symbiosis
			[110700] = "sDivineShield", --symbiosis
			[110717] = "sFearWard", --symbiosis
			[110806] = "sSpiritWalkersGrace", --symbiosis
			[122291] = "sUnendingResolve", --symbiosis
			[110715] = "sDispersion", --symbiosis
			[110788] = "sCloakOfShadows", --symbiosis
			[126456] = "sFortifyingBrew", --symbiosis
			--[126453] = "sElusiveBrew", --symbiosis
			--paladin
				-- OLD
			[1022] = "handOfProtection", -- 保護
			[1044] = "handOfFreedom", -- 自由
			[642] = "divineShield", -- 無敵
			[6940] = "sacrifice", -- 犧牲祝福
			[54428] = "divinePlea", -- 神性祈求
			--[85696] = "zealotry", -- 狂熱精神 rimosso/removed
			[31884] = "avengingWrath",
			[31842] = "divineFavor",
				-- Mist of pandaria
						--[114163] = "eternalFlame", --
			--[20925] = "sacredShield", --
			[114039] = "handOfPurity", --
			[105809] = "holyAvenger",--
			[114917] = "healingExecution", 
			[113075] = "sBarkskin", -- symbiosis
			--rogue
				-- OLD
			[51713] = "shadowDance", -- 暗影之舞
			[2983] = "sprint", -- 疾跑
			[31224] = "cloakOfShadows", -- 斗篷
			[13750] = "adrenalineRush", -- 衝動
			[5277] = "evasion", -- 閃避
			[74001] = "combatReadiness", -- 戰鬥就緒
				-- Mist of pandaria
			[114018] = "shroudOfConcealment",
			--warrior
				-- OLD
			[55694] = "enragedRegeneration", -- 狂怒恢復
			[871] = "shieldWall", --盾墻
			[18499] = "berserkerRage", -- 狂暴之怒
			-- [20230] = "retaliation", -- 反擊風暴 rimosso/removed
			[23920] = "spellReflection", -- 盾反
			[12328] = "sweepingStrikes", -- 橫掃攻擊
			[46924] = "bladestorm", -- 劍刃風暴
			-- [85730] = "deadlyCalm", -- 沉著殺機 --removed in 5.2
			[1719] = "recklessness", -- 魯莽
				-- Mist of pandaria
			[114029] = "safeguard",
			[114030] = "vigilance",
			[107574] = "avatar",
			[12292] = "bloodbath", -- old death wish
			--[112048] = "shieldBarrier",

			--preist
				-- OLD
			[33206] = "painSuppression", -- 痛苦壓制
			--[37274] = "powerInfusion", -- 能量灌注
			[6346] = "fearWard", -- 反恐
			[47585] = "dispersion", -- 消散
			[89485] = "innerFocus", -- 心靈專注
			--[87153] = "darkArchangel", rimosso/reomved
			--[81700] = "archangel",
			[47788] = "guardianSpirit",
				-- Mist of pandaria
			[10060] = "powerInfusion",
			--[109964] = "spiritShell",
			--shaman
				-- OLD
			[52127] = "waterShield", -- 水盾
			[30823] = "shamanisticRage", -- 薩滿之怒
			[974] = "earthShield", -- 大地之盾
			[16188] = "ancestralSwiftness", -- 自然迅捷
			[79206] = "spiritwalkersGrace",
			[16166] = "elementalMastery",
				-- Mist of pandaria
			[114050] = "ascendance",
			[114051] = "ascendance",
			[114052] = "ascendance",
			--mage
				-- OLD
			[45438] = "iceBlock", -- 寒冰屏障
			[12042] = "arcanePower", -- 秘法強化
			[12472] = "icyVeins", --冰脈
				-- Mist of pandaria
			[12043] = "presenceOfMind",
			[108839] = "iceFloes",
			[110909] = "alterTime",
			--dk
				-- OLD
			[49039] = "lichborne", -- 巫妖之軀
			[48792] = "iceboundFortitude", -- 冰固
			[55233] = "vampiricBlood", -- 血族之裔
			[49016] = "unholyFrenzy", -- 邪惡狂熱
			[51271] = "pillarofFrost",
			[48707] = "antiMagicShell",
				-- Mist of pandaria
			[115989] = "unholyBlight",
			[113072] = "sUrsoc",
			--hunter
				-- OLD
			[34471] = "theBeastWithin", -- 獸心
			[19263] = "deterrence", -- 威懾
			[3045] = "rapidFire",
			[54216] = "mastersCall",
				-- Mist of pandaria
			[113073] = "sDash", --symbiosis
			--lock
				-- Mist of pandaria
			[108416] = "sacrificialPact",
			[108503] = "grimoireOfSacrifice",
			-- [119049] = "kjCunning", -- removed in 5.2
			[113858] = "darkSoul",
			[113861] = "darkSoul",
			[113860] = "darkSoul",
			[104773] = "unendingResolve",
			--monk
				-- Mist of pandaria
			[122278] = "dampenHarm",
			[122783] = "diffuseMagic",
			[120954] = "fortifyingBrew",
			[115176] = "zenMeditation",
			--[115213] = "avertHarm",
			[116849] = "lifeCocoon",
			[113306] = "sSurvivalInstinct",
		},
		auraRemoved = {					-- aura removed [spellid] = ".mp3 file name",
				-- OLD
			[642] = "bubbleDown", -- 無敵結束
			[47585] = "dispersionDown", -- 消散結束
			[1022] = "protectionDown", -- 保護結束
			[31224] = "cloakDown", -- 斗篷結束
			[74001] = "combatReadinessDown", -- 戰鬥就緒結束
			[871] = "shieldWallDown", -- 盾墻結束
			[33206] = "PSDown", -- 壓制結束
			[5277] = "evasionDown", -- 閃避結束
			[45438] = "iceBlockDown", -- 冰箱結束
			[49039] = "lichborneDown", -- 巫妖之軀結束
			[48792] = "iceboundFortitudeDown", -- 冰固結束
			--[34471] = "theBeastWithinDown", -- 獸心結束
			[19263] = "deterrenceDown", -- 威懾結束
				-- Mist of pandaria
			--[106922] = "mightOfUrsocDown", --
			--[103827] = "doubleTimeDown", --
			--[114030] = "vigilanceDown",
			--[112048] = "shieldBarrierDown",
			[108271] = "astralShiftDown",
			--[109964] = "spiritShellDown",
			[120954] = "fortifyingBrewDown",
			[115176] = "zenMeditationDown",
			--[115213] = "avertHarmDown",
			--[118350] = "empowerDown",
			--[118347] = "reinforceDown",
			--[113072] = "sUrsocDown", --symbiosis
			[110617] = "sDeterranceDown", --symbiosis
			[110696] = "sIceBlockDown", --symbiosis
			[110700] = "sDivineShieldDown", --symbiosis
			[110788] = "sCloakOfShadowsDown", --symbiosis
			[110715] = "sDispersionDown", --symbiosis
			[126456] = "sFortifyingBrewDown", --symbiosis
			--[126453] = "sElusiveBrewDown", --symbiosis
		},
		castStart = {					-- cast start [spellid] = ".mp3 file name",
			--general
			[2060] = "bigHeal",
			[82326] = "bigHeal",
			[77472] = "bigHeal",
			[5185] = "bigHeal", -- 強效治療術 神光術 強效治療波 治療之觸
			[115178] = "bigHeal", -- MONK
			[2006] = "resurrection",
			[7328] = "resurrection",
			[2008] = "resurrection",
			[50769] = "resurrection", -- 復活術 救贖 先祖之魂 復活
			[115310] = "resurrection", -- MONK
			--druid
				-- OLD
			[2637] = "hibernate", -- 休眠
			[33786] = "cyclone", -- 吹風
				-- Mist of pandaria
			[339] = "entanglingRoots", --
			[110707] = "sMassDispell", --symbiosis
			--paladin
				-- Mist of pandaria
			[20066] = "repentance", -- 懺悔
			[115750] = "blindingLight", -- 盲目之光
			--rogue
			--warrior
			--preist
				-- OLD
			--[8129] = "manaBurn", -- 法力燃燒 NYI in Game
			[9484] = "shackleUndead", -- 束縛亡靈
			[605] = "dominateMind", -- 精神控制
				-- Mist of pandaria
			[113506] = "sCyclone",
			[32375] = "massDispell",
			--shaman
			[51514] = "hex", -- 妖術
			[76780] = "bindElemental", -- 元素束縛
			--mage
				-- OLD
			[118] = "polymorph",
			[28272] = "polymorph",
			[61305] = "polymorph",
			[61721] = "polymorph",
			[61025] = "polymorph",
			[61780] = "polymorph",
			[28271] = "polymorph", -- 變形術 羊豬貓兔蛇雞龜
				-- Mist of pandaria
			[102051] = "frostjaw",
			[113074] = "sBigHeal", -- symbiosis
			--dk
			--[49203] = "hungeringCold", -- 噬溫酷寒 rimosso/removed
			--hunter
			[982] = "revivePet", -- 復活寵物
			[1513] = "scareBeast", -- 恐嚇野獸
			--warlock
				-- OLD
			[710] = "banish", -- 放逐術
			[5782] = "fear", -- 恐懼
			[691] = "summonDemon",
			[712] = "summonDemon",
			[697] = "summonDemon",
			[688] = "summonDemon",
				-- Mist of pandaria
			[112866] = "summonDemon", -- Fel Imp
			[112867] = "summonDemon", -- Void Lord
			[112870] = "summonDemon", -- Wrathguard
			[112868] = "summonDemon", -- Shivarra
			[112869] = "summonDemon", -- Observer
			-- monk
				-- Mist of pandaria
			[113275] = "sEntanglingRoots",
		},
		castSuccess = {					--cast success [spellid] = ".mp3 file name",
			--general
			[58984] = "shadowmeld", -- 影遁
			[20594] = "stoneform", -- 石像形態
			[7744] = "willOfTheForsaken", -- 亡靈意志
			[42292] = "trinket",
			[59752] = "trinket", -- 徽章
			--druid
				-- OLD
			[80964] = "skullBash",
			[80965] = "skullBash", -- 碎顱猛擊
			[740] = "tranquility",
			[78675] = "solarBeam", -- 太陽光束
				-- Mist of pandaria
			[102280] = "displacerBeast", --
			[108238] = "renewal", --
			[102359] = "massEntanglement", --
			[33831] = "fNatureRoot", --
			[102703] = "fNatureStun", --
			[102693] = "fNatureHealing", --
			[102706] = "fNatureProtect", --
			[99] = "disorientingRoar", --
			[5211] = "mightyBash", --
			--[102795] = "bearHug", --
			[102560] = "incarnationElune", --
			[102543] = "incarnationKitty", --
			[102558] = "incarnationUrsoc", --
			[33891] = "incarnationTree",
			[102417] = "wildCharge",
			[102383] = "wildCharge",
			[49376] = "wildCharge",
			[16979] = "wildCharge",
			[102416] = "wildCharge",
			[102401] = "wildCharge",
			[110698] = "sHammerOfJustice", --symbiosis
			[110730] = "sRedirect", --symbiosis
			[113002] = "sSpellReflection", --symbiosis
			[113004] = "sIntimidatingShout", --symbiosis
			[122292] = "sIntervene", --symbiosis
			[112970] = "sTeleport", --symbiosis
			[128844] = "sClash", --symbiosis
			[126458] = "sGrappleWeapon", --symbiosis
			--paladin
				-- OLD
			[96231] = "rebuke", -- 責難
			[853] = "hammerofjustice", -- 制裁			
			[31821] = "auraMastery", -- 光環精通
				-- Mist of pandaria
			[105593] = "fistOfJustice", --
			--[114158] = "lightsHammer", -- removed
			[85499] = "speedOfLight",
			--rogue
				-- OLD
			[51722] = "disarm2", -- 拆卸
			[2094] = "blind", -- 致盲
			[1766] = "kick", -- 腳踢
			[14185] = "preparation", -- 準備就緒
			[1856] = "vanish", -- 消失
			[76577] = "smokeBomb", -- 煙霧彈
			--[14177] = "coldblood", -- 冷血 rimosso/removed
			[73981] = "redirect",
			[79140] = "vendetta",
			[121471] = "shadowBlades",
			--warrior
				-- OLD
			--[23694] = "ImprovedHamstring", --強斷
			[97462] = "rallyingCry", -- 集結怒吼
			[676] = "disarm", -- 繳械
			[5246] = "fear3", -- 破膽怒吼
			[6552] = "pummel", -- 拳擊
			[107566] = "staggeringShout", --
			[2457] = "battlestance", -- 戰鬥姿態
			[71] = "defensestance", -- 防禦姿態
			[2458] = "berserkerstance", -- 狂暴姿態
				-- Mist of pandaria				
			[114028] = "massSpellReflection",
			[102060] = "disruptingShout",
			[46968] = "shockwave",
			[118000] = "dragonRoar",
			[107570] = "stormBolt",
			[114207] = "skullBanner",
			[114192] = "mockingBanner",
			[114203] = "demoralizingBanner",
			--priest
				-- old
			[8122] = "fear4", -- 心靈尖嘯
			[34433] = "shadowFiend", -- 暗影惡魔
			[64044] = "disarm3", -- 心靈驚駭
			[15487] = "silence", -- 沉默
			[64843] = "divineHymn",
			[19236] = "desperatePrayer",
			[113277] = "sTranquility",
				-- Mist of pandaria
			
			[112833] = "spectralGuise",
			[108920] = "voidTendrils",
			[108921] = "psyfiend",
			[123040] = "mindbender",
			[121135] = "cascade",
			[108968] = "voidShift",			
			
			[81209] = "chakraChastise",
			[81206] = "chakraSanctuary",
			[81208] = "chakraSerenity",
			--shaman
				-- old
			[8177] = "grounding", -- 根基圖騰
			[16190] = "manaTide", -- 法力之潮
			[8143] = "tremorTotem", -- 戰慄圖騰
			[98008] = "spiritlinktotem", -- 靈魂鏈接圖騰
				-- Mist of pandaria
			[108270] = "stoneBulwark",
			[51485] = "earthgrab",
			[108273] = "windwalk",
			[108285] = "callOfTheElements",
			[108287] = "totemicProjection",
			[108280] = "healingTide",
			[108281] = "ancestralGuidance",
			[118350] = "empower",
			[118347] = "reinforce",
			[118345] = "pulverize",
			[2894] = "fireElemental",
			[2062] = "earthElemental",
			[108269] = "capacitor",
			[120668] = "stormlash",
			[108271] = "astralShift",
			[57994] = "windShear",
			[113287] = "sSolarBeam", --symbiosis
			--mage
				-- old
			[11129] = "Combustion", -- 燃火
			[11958] = "coldSnap", -- 急速冷卻
			[44572] = "deepFreeze", -- 深結
			[2139] = "counterspell", -- 法術反制
			[66] = "invisibility", -- 隐形术
			[113724] = "ringOfFrost", -- 霜之環
			[12051] = "evocation",
				-- Mist of pandaria
			[110959] = "greaterInvisibility",
			--dk
				-- old
			[47528] = "mindFreeze", -- 心智冰封
			[47476] = "strangulate", -- 絞殺
			[47568] = "runeWeapon", -- 強力符文武器
			[49206] = "gargoyle", -- 召喚石像鬼
			[77606] = "darkSimulacrum", -- 黑暗幻象
			[51052] = "antiMagicZone",
				-- Mist of pandaria
			[108194] = "asphyxiate",
			[108199] = "gorefiendGrasp",
			[108201] = "desacratedGround",
			[108200] = "remorselessWinter",
			--hunter
				-- old
			[19386] = "wyvernSting", -- 翼龍釘刺
			-- [23989] = "readiness", -- 準備就緒 removed
			-- [51755] = "camouflage", -- 偽裝
			[19503] = "scattershot", -- 驅散射擊
			[34490] = "silencingshot", -- 沉默射擊
			[147362] = "counterShot", -- 反制射击 
			[1499] = "freezingTrap",
			[60192] = "freezingTrap2",
				-- Mist of pandaria
			[109248] = "bindingShot",
			[109304] = "Exhilaration",
			[131894] = "murderOfCrows",
			[126216] = "direBeast",
			[126215] = "direBeast",
			[126214] = "direBeast",
			[126213] = "direBeast",
			[122811] = "direBeast",
			[122809] = "direBeast",
			[122807] = "direBeast",
			[122806] = "direBeast",
			[122804] = "direBeast",
			[122802] = "direBeast",
			[121118] = "direBeast",
			[120697] = "lynxRush",
			[121818] = "stampede",
			--warlock
				-- old
			[6789] = "mortalCoil", -- aka Death Coil 死亡纏繞
			[5484] = "fear2", -- 恐懼嚎叫 Howl of Terror
			[19647] = "spellLock", -- 法術封鎖
			[48020] = "demonicCircleTeleport", -- 惡魔法陣:傳送
			[30283] = "shadowfury",
				-- Mist of pandaria
			[108359] = "darkRegeneration",
			[111397] = "bloodFear",
			[108482] = "unboundWill",
			[108505] = "archimondesVengeance",
			[124539] = "demonDisarm",
			[104316] = "impSwarm",
			[110913] = "darkBargain",
			[111859] = "grimoireOfService",
			[111895] = "grimoireOfService",
			[111896] = "grimoireOfService",
			[111897] = "grimoireOfService",
			[111898] = "grimoireOfService",
			-- monk
				-- Mist of pandaria
			[116841] = "tigersLust",
			[115399] = "chiBrew",
			[119392] = "chargingOxWave",
			[119381] = "legSweep",
			[116847] = "rushingJadeWind",
			[123904] = "invokeXuen",
			[115078] = "paralysis",
			[122057] = "clash",
			[115315] = "oxStatue",
			[115313] = "serpentStatue",
			[122470] = "touchOfKarma",
			[117368] = "grappleWeapon",
			[116705] = "spearStrike",
			[123761] = "manatea",
			[119996] = "transfer",
		},
		friendlyInterrupt = {			--friendly interrupt [spellid] = ".mp3 file name",
			[19647] = "lockout", -- Spell Lock
			[2139] = "lockout", -- Counter Spell
			[1766] = "lockout", -- Kick
			[6552] = "lockout", -- Pummel
			[47528] = "lockout", -- Mind Freeze
			[96231] = "lockout", -- Rebuke
			[93985] = "lockout", -- Skull Bash
			[97547] = "lockout", -- Solar Beam
			[57994] = "lockout", -- Wind Shear
			[116705] = "lockout", -- Spear Hand Strike
			[113287] = "lockout", -- Symbiosis Solar Beam
			[147362] = "lockout", -- Counter Shot
			[34490] = "lockout", -- Silencing Shot
		},
	}
end

