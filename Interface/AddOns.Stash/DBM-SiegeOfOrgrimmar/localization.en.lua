local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundPZD				= "Voice Warning: When $spell:143579 stacks more than 3 warn you to stop attack",
	InfoFrame				= "Info Frame: Track how many puddles have been killed or purified",
	dr						= "Defensive warning[Warning will be showed at $spell:143020, but you should use your defensive cooldowns before contact]",
	dr1						= "$spell:143020 1",
	dr2						= "$spell:143020 2",
	dr3						= "$spell:143020 3",
	dr4						= "$spell:143020 4",
	dr5						= "$spell:143020 5",
	dr6						= "$spell:143020 6",
	dr7						= "$spell:143020 7",
	dr8						= "$spell:143020 8"
})

L:SetMiscLocalization({
	kill					= "Killed",
	clean					= "Purified",
	Victory			= "Ah, you have done it! The waters are pure once more."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	InfoFrame				= "Info Frame: Boss Health Monitor",
	SoundBD					= "Voice Warning: Dispel $spell:143434",
	dr1						= "Defensive warning: $spell:143491 1/4",
	dr2						= "Defensive warning: $spell:143491 2/4",
	dr3						= "Defensive warning: $spell:143491 3/4",
	dr4						= "Defensive warning: $spell:143491 4/4",
	BaneGridCount			= "Grid: Number $spell:143434 (Position need to be set on Grid. The spreaded $spell:143434 will not be numbered)",
	optOC					= "How many stacks of Mark of Anguish do you want to be warned to pass it",
	imm						= "Immediately",
	five					= "5",
	ten						= "10",
	fift					= "15",
	twty					= "20",
	none					= "Never",
	optDD					= "Embodied Gloom Interrupt Warning",
	alldd					= "Always (If he's your target or focus)",
	DD1						= "Interrupt 1",
	DD2						= "Interrupt 2",
	DD3						= "Interrupt 3",
	nodd					= "None",
	SetIconOnStrike			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(143962),
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(5, 143423)--For heroic. Need to chage smart range frame?
})

L:SetMiscLocalization({
	DBM_GridBaneCount		= "DBM number - Shadow Word: Bane",
	BaneRaidFrameCount		= "Use Blizzard raid frame number order",
	optBaneGridCount		= "Flash number:",
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetWarningLocalization({
	specWarnTestIn			= "Player in: %s",
	specWarnTestOut			= "Player out: %s"
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	InfoFrame			= "Show info frame for $journal:8252",
	InfoFrame2				= "Info frame: Players under $spell:144452",
	specWarnTestIn			= "Special Warning: The player you monitor is in",
	specWarnTestOut			= "Special Warning: The player you monitor is out",
	prevplayer				= "Type in a player's name and you will be warned when he/she is in or out"
})

L:SetMiscLocalization({
	nameset				= "Norushen Test Realm Monitor",
	wasteOfTime				= "Very well, I will create a field to keep your corruption quarantined."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundQS					= "Extra dispel warning: When you got $spell:144359 warn you as soon as dispel cd",
	HudMAPBP				= "HUD MAP: $spell:144911",
	HudMAPCP				= "HUD MAP: $spell:144574",
	HudMAPAoP				= "HUD MAP: $spell:146817",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(5, 146817),
	SetIconOnMark		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144351),
	InfoFrame			= "Show info frame for $journal:8255",
	dr1						= "Defensive Warning: $spell:144400 1/3",
	dr2						= "Defensive Warning: $spell:144400 2/3",
	dr3						= "Defensive Warning: $spell:144400 3/3",
})

L:SetMiscLocalization({
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
	timerAddsCD		= "Next Adds",
	timerTowerCD	= "Next Tower & Adds"
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundZQ					= "Voice Warning: $spell:147328",
	SoundTT					= "Voice Warning: $spell:146753",
	timerAddsCD				= "Show timer for next adds wave",
	timerTowerCD			= "Show timer for next tower assault",
	FixateIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(147068),
	InfoFrame				= "Info frame: Next $journal:8427",
	flamecount				= "Defensive Warning: 2nd phase, which Pulsing Flames do you want to be warned."
})

L:SetMiscLocalization({
	nameset		= "Galakras",
	Pull		= "Dragonmaw clan, retake the docks and push them into the sea!  In the name of Hellscream and the True Horde!",
	newForces1	= "Here they come!",--Jaina's line, alliance
	newForces1H	= "Bring her down quick so i can wrap my fingers around her neck.",--Sylva's line, horde
	newForces2	= "Dragonmaw, advance!",
	newForces3	= "For Hellscream!",
	newForces4	= "Next squad, push forward!",
	tower		= "The door barring the"--The door barring the South/North Tower has been breached!
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	timerAssaultModeCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej8177"),
	timerSiegeModeCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej8178"),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(6, 144154),
	dr						= "Defensive Warning: $spell:144485 [reset each siege mode]",
	dr1						= "$spell:144485 1",
	dr2						= "$spell:144485 2",
	dr3						= "$spell:144485 3",
	dr4						= "$spell:144485 4",
	dr5						= "$spell:144485 5",
	dr6						= "$spell:144485 6"
})

L:SetMiscLocalization({
})

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundTL					= "Voice Warning: 10 sec pre-warning for $spell:144330 (Will warn even if it's not your $spell:144330, useful for healers)",
	dr						= "Defensive Warning[4 seconds before the strike]",
	dr1						= "$spell:143973 1/6",
	dr2						= "$spell:143973 2/6",
	dr3						= "$spell:143973 3/6",
	dr4						= "$spell:143973 4/6",
	dr5						= "$spell:143973 5/6",
	dr6						= "$spell:143973 6/6",
	SoundEle				= "Special: Enable Wavebinder Kardris ability warnings",
	SoundEnh				= "Special: Enable Earthbreaker Haromm ability warnings",
	SetIconOnToxicMists		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144089),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(4, 143990)
})

L:SetMiscLocalization({
	PrisonYell		= "Prison on %s fades (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Defensive Stance in %ds"
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundDS					= "Voice Warning: Dispel $spell:143475",
	SoundIFS				= "Voice Warning: Interrupt $journal:7923",
	SoundISM				= "Voice Warning: Interrupt $journal:7925",
	InfoFrame				= "Info Frame: Rage Monitor",	
	SetIconOnAdds			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej7920"),
	warnDefensiveStanceSoon			= "Pre-warning: $spell:143593 (5 seconds before)"
})

L:SetMiscLocalization({
	newForces1				= "Warriors, on the double!",
	newForces2				= "Defend the gate!",
	newForces3				= "Rally the forces!",
	newForces4				= "Kor'kron, at my side!",
	newForces5				= "Next squad, to the front!",
	allForces				= "All Kor'kron... under my command... kill them... NOW!",
	Handslipped1			= "Sorry, my fingers slipped and hit the boss",
	Handslipped2			= "ouch, slipped again",
	Handslipped3			= "I guess my fingers are made with soap?",
	Handslipped4			= "Please cut my evil fingers off! I forgot to stop dps at all!"
})


-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	Malhelper				= "===Special: Enable $spell:142842 graph assist (/mal)===",
	MalhelperSend			= "===Assist Graph: Enable manual adjust mode===",
	LTshow					= "Long Term Special Warning: Show shield absorbing amount=",
	dr						= "Defensive Warning: $spell:142986 (before explode)",
	dr1						= "$spell:142986 1",
	dr2						= "$spell:142986 2",
	dr3						= "$spell:142986 3",
	dr4						= "$spell:142986 4",
	dr5						= "$spell:142986 5",
	dr6						= "$spell:142986 6",
	dr7						= "$spell:142986 7",
	dr8						= "$spell:142986 8",
	dr9						= "$spell:142986 9",
	dr10					= "$spell:142986 10",
	dr11					= "$spell:142986 11",
	dr12					= "$spell:142986 12",
	HudMAP					= "HUD MAP: $spell:142913",
	SetIconOnDisplacedEnergy= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(142913),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("8/5")
})

MHExRTL = {}
MHExRTL.panelbossmodsmalkorokdanger ="! Danger !"
MHExRTL.sendnote ="Open manually modify the map, left click to select, right to cancel, your changes will be synchronized to the whole group, please use caution!"

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	LTZD					= "Long Term Special Warning: $spell:145987 on you",
	RangeFrame	= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 145987),
	Filterarea				= "Other: Use stricter way to tell the area"
})

L:SetMiscLocalization({
	wasteOfTime		= "Hey, we recording?  Yeah?  Okay.  Goblin-Titan control module starting up, please stand back.",
	Module1 		= "Module 1's all prepared for system reset.",
	Victory			= "Module 2's all prepared for system reset."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetWarningLocalization({
	specWarnDevotion		= "%s used Devotion Aura"
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundPX					= "Countdown: $spell:143343",
	LTRange					= "Long Term Special Warning: P1 $spell:143343 stacks/P2 Boss Range",
	optDD					= "$spell:143791 dispel chain",
	DD1						= "Dispel 1",
	DD2						= "Dispel 2",
	DD3						= "Dispel 3",
	nodd					= "No Dispel",
	dr						= "Defensive Warning: $spell:143343 (reset each transition)",
	dr1						= "$spell:143343 1",
	dr2						= "$spell:143343 2",
	dr3						= "$spell:143343 3",
	dr4						= "$spell:143343 4",
	dr5						= "$spell:143343 5",
	dr6						= "$spell:143343 6",
	dr7						= "$spell:143343 7",
	dr8						= "$spell:143343 8",
	dr9						= "$spell:143343 9",
	dr10					= "$spell:143343 10",
	dr11					= "$spell:143343 11",
	dr12					= "$spell:143343 12",
	dr13					= "$spell:143343 13",
	dr14					= "$spell:143343 14",
	dr15					= "$spell:143343 15",
	dr16					= "$spell:143343 16",
	dr17					= "$spell:143343 17",
	dr18					= "$spell:143343 18",
	dr19					= "$spell:143343 19",
	dr20					= "$spell:143343 20",
	dr21					= "$spell:143343 21",
	dr22					= "$spell:143343 22",
	dr23					= "$spell:143343 23",
	dr24					= "$spell:143343 24",
	dr25					= "$spell:143343 25",
	dr26					= "$spell:143343 26",
	dr27					= "$spell:143343 27",
	dr28					= "$spell:143343 28",
	dr29					= "$spell:143343 29",
	dr30					= "$spell:143343 30",
	specWarnDevotion		= "Special Warning: $spell:31821",
	RangeFrame	= "Show dynamic range frame (10 yards)",
	FixateIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(143445)
})

L:SetMiscLocalization({
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetWarningLocalization({
	warnCC					= "%s's [%s] has broken %s's %s(First CC broken)"
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundFMD				= "Voice Warning: Before $spell:144208 warn to attack Shredder",
	SoundDL					= "Voice Warning: Mine sweeping",
	LTFD					= "Long Term Special Warning: $spell:143266 and $spell:143828",
	LTHX					= "Long Term Special Warning: Show fire beam timer",
	HudMAP					= "HUD MAP: $spell:143828",
	SoundCZ					= "Voice Warning: Shredders' $spell:145444 AOE pre-warning",
	SoundCZ4				= "Defensive Warning: Shredder 4th $spell:145444 (3 stacks buff)",
	SoundCZ5				= "Defensive Warning: Shredder 5th $spell:145444 (4 stacks buff)",
	SoundCS1				= "Voice Warning: conveyor belt group one 10 sec pre-warning",
	SoundCS2				= "Voice Warning: conveyor belt group two 10 sec pre-warning",
	ShowDps					= "Show your current group's dps on conveyor belt",
	warnCC					= "Warning: Show Crawler Mines' CC broken info(only 1st per round)",
	InfoFrame				= "Info Frame: $journal:8202",
	optCS					= "Conveyor belt warning",
	CSA						= "Conveyor belt 1",
	CSB						= "Conveyor belt 2",
	CSALL					= "Always",
	none					= "None",
	optCSKILL1				= "Kill Warning: 1st round",
	optCSKILL2				= "2nd round",
	optCSKILL3				= "3rd round",
	optCSKILL4				= "4th round",
	optCSKILL5				= "5th round",
	optCSKILL6				= "6th round",
	optCSKILL7				= "7th round",
	optCSKILL8				= "8th round",
	optCSKILL9				= "9th round",
	optCSKILL10				= "10th round",
	optCSKILL11				= "11th round",
	optCSKILL12				= "12th round",
	optCSKILL13				= "13th round",
	optCSKILL14				= "14th round",
	optCSKILL15				= "15th round",
	killdl					= "Crawler Mines",
	killfd					= "Missile",
	killjg					= "Laser",
	killdc					= "Magnet",
	killnone				= "None"
})

L:SetMiscLocalization({
	newWeapons	= "Unfinished weapons begin to roll out on the assembly line.",
	newShredder	= "An Automated Shredder draws near!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "You are vulnerable to %s - Avoid!",
	specWarnCriteriaLinked			= "You are linked to %s!"
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	LTchong					= "Graphic Cooldown Warning: $spell:143339",
	LTIP					= "Icon Vibrate on Warning: Critical Ability",
	dr						= "Defensive Warning: $spell:142416",
	dr1						= "$spell:144095 1/6",
	dr2						= "$spell:144095 2/6",
	dr3						= "$spell:144095 3/6",
	dr4						= "$spell:144095 4/6",
	dr5						= "$spell:144095 5/6",
	dr6						= "$spell:144095 6/6",
	InfoFrame				= "Info Frame: Next Klaxxi Paragon",
	HudMAPDF				= "HUD MAP: $spell:142232",
	HudMAP					= "HUD MAP: $spell:142726 / $spell:142727",
	HudMAPMZ				= "HUD MAP: $journal:8073",
	warnToxicCatalyst				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej8036"),
	specWarnToxicInjection			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(142528),
	specWarnToxicCatalyst			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format("ej8036"),
	specWarnActivatedVulnerable		= "Show special warning when you are vulnerable to activating paragons",
	specWarnCriteriaLinked			= "Show special warning when you are linked to $spell:144095",
	SetIconOnAim					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(142948),
	yellToxicCatalyst				= DBM_CORE_AUTO_YELL_OPTION_TEXT:format("ej8036"),
	RangeFrame						= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("6/5")
})

L:SetMiscLocalization({
	one					= "One",
	two					= "Two",
	three				= "Three",
	four				= "Four",
	five				= "Five",
	BossSpellInfo		= "Boss Spell Info",
	LF					= "Kil'ruk the Wind-Reaver",
	LFspell				= "Gouge/Reave",
	DX					= "Xaril the Poisoned-Mind",
	DXspell				= "Toxic Spells",
	CZ					= "Kaz'tik the Manipulator",
	CZspell				= "Hungry Kunchongs",
	ZZ					= "Korven the Prime",
	ZZspell				= "Shield Bash/Amber",
	MC					= "Iyyokuk the Lucid",
	MCspell				= "lines of fire",
	BS					= "Ka'roz the Locust",
	BSspell				= "Pool of Caustic Amber/Flash",
	MX					= "Skeer the Bloodseeker",
	MXspell				= "Blood creatures",
	QG					= "Rik'kal the Dissector",
	QGspell				= "Parasite/Scorpion",
	CQ					= "Hisek the Swarmkeeper",
	CQspell				= "Share Aim",
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundGC					= "Voice Warning: $journal:8298 related",
	optDD					= "Ancestral Chain Heal interrupt warnings",
	alldd					= "Always (If he's your target or focus)",
	DD1						= "Odd number",
	DD2						= "Even number",
	DD1H					= "Interrupt 1(Heroic Mode, including chain lightning)",
	DD2H					= "Interrupt 2(Heroic Mode, including chain lightning)",
	DD3H					= "Interrupt 3(Heroic Mode, including chain lightning)",
	DD4H					= "Interrupt 4(Heroic Mode, including chain lightning)",
	nodd					= "None",
	SetIconOnShaman			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej8294"),
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"Siege of Orgrimmar Trash"
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
})
