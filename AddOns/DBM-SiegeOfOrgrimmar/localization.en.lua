local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundPZ					= "Voice Warning: When $spell:117878 stacks more than 3 warn you to stop attack",
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
	dr						= "Defensive Warning[4 seconds before the strike]",
	dr1						= "$spell:143973 1/6",
	dr2						= "$spell:143973 2/6",
	dr3						= "$spell:143973 3/6",
	dr4						= "$spell:143973 4/6",
	dr5						= "$spell:143973 5/6",
	dr6						= "$spell:143973 6/6",
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
	SoundTT					= "Voice Warning: Kill $spell:143474",
	InfoFrame				= "Info Frame: Rage Monitor",	
	warnDefensiveStanceSoon			= "Pre-warning: $spell:143593 (5 seconds before)"
})

L:SetMiscLocalization({
	newForces1				= "Warriors, on the double!",
	newForces2				= "Defend the gate!",
	newForces3				= "Rally the forces!",
	newForces4				= "Kor'kron, at my side!",
	newForces5				= "Next squad, to the front!",
	allForces				= "All Kor'kron... under my command... kill them... NOW!"
})


-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	HudMAP					= "HUD MAP: $spell:142913",
})

L:SetMiscLocalization({
	bloodRageEnds	= "subsides!"
})

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	RangeFrame	= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 145987),
	Filterarea				= "Other: Use stricter way to tell the area"
})

L:SetMiscLocalization({
	Module1 = "Module 1's all prepared for system reset.",
	Victory	= "Module 2's all prepared for system reset"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetWarningLocalization({
	specWarnDevotion		= "%s used Devotion Aura"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundPX					= "Countdown: $spell:143343",
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
})

L:SetOptionLocalization({
	SoundWOP				= "Voice Warning: Critical Ability",
	SoundFMD				= "Voice Warning: Before $spell:144208 warn to attack Shredder",
	InfoFrame				= "Info Frame: $journal:8202",
	optCS					= "Conveyor belt warning",
	CSA						= "Conveyor belt 1",
	CSB						= "Conveyor belt 2",
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
	killdl					= "Mine",
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
	InfoFrame				= "Info Frame: Next Klaxxi Paragon",
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
	nodd					= "None"
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
