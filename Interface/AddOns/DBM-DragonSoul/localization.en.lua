local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCrystal = "Next Kohcrom $spell:103639",
	KohcromStomp = "Next Kohcrom $spell:103414"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	KohcromWarning	= "Show warnings for $journal:4262 mimicking abilities.",
	KohcromCrystal = "Show timer for $journal:4262's next $spell:103639",
	KohcromStomp = "Show timer for $journal:4262's next $spell:103414",
	OnlyMorchok		= "Show warnings and timers only for Morchok",
	OnlyKohcrom		= "Show warnings and timers only for Kohcrom",
	RangeFrame		= "Show range frame (5) for achievement."
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetTimerLocalization({
	timerPhaseTwo		= "Phase Two"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	timerPhaseTwo		= "Show warning for Phase Two(lfr25)",
	CustomRangeFrame	= "Range Frame options (Heroic only)",
	Never				= "Disabled",
	Normal				= "Normal Range Frame",
	DynamicPhase2		= "Phase2 Debuff Filtering",
	DynamicAlways		= "Always Debuff Filtering",
	DisruptingShadowsIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(103434)
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s absorbed %s"
})

L:SetTimerLocalization({
	timerOozesReach		= "Oozes Reach Boss"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	warnOozesHit		= "Announce what oozes hit the boss",
	timerOozesReach		= "Show timer for when Oozes reach Yor'sahj",
	RangeFrame			= "Show range frame (4) for $spell:104898",
	ColorPGDB				= "Purple-Green-Black-Blue Combination(Heroic)",
	ColorGRBD				= "Green-Red-Blue-Black Combination(Heroic)",
	ColorGYDR				= "Green-Yellow-Black-Red Combination(Heroic)",
	ColorBPGY				= "Blue-Purple-Green-Yellow Combination(Heroic)",
	ColorBDPY				= "Blue-Black-Purple-Yellow Combination(Heroic)",
	ColorPRYD				= "Purple-Red-Yellow-Black Combination(Heroic)",
	ColorPGB				= "Purple-Green-Blue Combination",
	ColorGRD				= "Green-Red-Black Combination",
	ColorGYR				= "Green-Yellow-Red Combination",
	ColorBPY				= "Blue-Purple-Yellow Combination",
	ColorBDY				= "Blue-Black-Yellow Combination",
	ColorPRD				= "Purple-Red-Black Combination",
	KGreen				= "Kill Green",
	KBlack				= "Kill Black",
	KBlue				= "Kill Blue",
	KYellow				= "Kill Yellow",
	KPurple				= "Kill Purple",
	oozesArrow		= "Show DBM arrow for the location of suggested ooze"
})

L:SetMiscLocalization({
	Black			= "|cFF424242black|r",
	Purple			= "|cFF9932CDpurple|r",
	Red				= "|cFFFF0404red|r",
	Green			= "|cFF088A08green|r",
	Blue			= "|cFF0080FFblue|r",
	Yellow			= "|cFFFFA901yellow|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: %d left",
	warnFrostTombCast		= "%s in 8 sec",
	specWarnLightningPhase		= "Lightning Phase",
	specWarnFrozenPhase		= "Frozen Phase"
})

L:SetTimerLocalization({
	TimerSpecial			= "First Special"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	WarnPillars				= "Announce how many $journal:3919 or $journal:4069 are left",
	TimerSpecial			= "Show timer for first special ability cast",
	RangeFrame				= "Show range frame (10) for Lightning Phase",
	AnnounceFrostTombIcons	= "Announce icons for $spell:104451 targets to raid chat\n(requires raid leader)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	specWarnLightningPhase		= "Show special warning for Lightning Phase",
	specWarnFrozenPhase		= "Show special warning for Frozen Phase",
	SetIconOnLance		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105316),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnShatteringIce		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105289),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	DispelYell        = "Yell after you were in the $spell:110317 with $spell:109325 affected",
	SetBubbles				= "Automatically disable chat bubbles when $spell:104451 available\n(restores them when combat ends)"
})

L:SetMiscLocalization({
	YellIceLance   = "Too High Debuff,HELP!!!",
	YellDispel   = "Dispel Me",
	TombIconSet				= "Frost Beacon icon {rt%d} set on %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d) in 5s"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion Active"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	holditHoT1 = "Play Extra Warning Sound when you want to face Hour of Twilight 1",
	holditHoT2 = "Play Extra Warning Sound when you want to face Hour of Twilight 2",
	holditHoT3 = "Play Extra Warning Sound when you want to face Hour of Twilight 3",
	holditHoT4 = "Play Extra Warning Sound when you want to face Hour of Twilight 4",
	holditHoT5 = "Play Extra Warning Sound when you want to face Hour of Twilight 5",
	holditHoT6 = "Play Extra Warning Sound when you want to face Hour of Twilight 6",
	holditHoT7 = "Play Extra Warning Sound when you want to face Hour of Twilight 7",
	SpecWarnHoTN		= "Special warn 5s before Hour of Twilight (3 set only)",
	Never				= "Disabled",
	One					= "1 (ie 1 4 7)",
	Two					= "2 (ie 2 5)",
	Three				= "3 (ie 3 6)",
	TimerCombatStart	= "Show timer for Ultraxion RP"
})

L:SetMiscLocalization({
	Pull				= "I sense a great disturbance in the balance approaching. The chaos of it burns my mind!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "Twilight Elites!"
})

L:SetTimerLocalization({
	TimerCombatStart	= "Combat starts",
	TimerAdd	= "Next Twilight Elites"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	SetIconOnConsumingShroud		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(110214),
	SetIconOnShockwave		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108046),
	TimerCombatStart	= "Show timer for start of combat",
	TimerAdd	= "Show timer for next Twilight Elites",
	SpecWarnElites		= "Show special warning for new Twilight Elites",
	SetTextures			= "Automatically disable projected textures in phase 1\n(returns it to enabled in phase 2)",
	holditslaught1 = "Play Extra Warning Sound when you want to face Twilight Onslaught 1",
	holditslaught2 = "Play Extra Warning Sound when you want to face Twilight Onslaught 2",
	holditslaught3 = "Play Extra Warning Sound when you want to face Twilight Onslaught 3",
	holditslaught4 = "Play Extra Warning Sound when you want to face Twilight Onslaught 4",
	holditslaught5 = "Play Extra Warning Sound when you want to face Twilight Onslaught 5"
})

L:SetMiscLocalization({
	SapperEmote			= "A drake swoops down to drop a Twilight Sapper onto the deck!",
	GorionaRetreat			= "screeches in pain and retreats into",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnAmaLowHP			= "Stop Attack! Amalgamation needs %d more blood!",
	SpecWarnTendril			= "Get Secured!"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	SpecWarnAmaLowHP			= "Show special warning when Amalgamation has low hp",
	SpecWarnTendril			= "Show special warning when you are missing $spell:105563 debuff",
	InfoFrame				= "Show info frame for current blood count",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105490),
	SetIconOnDeath		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(106199),
	SetIconOnEarth		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(106200),
	ShowShieldInfo			= "Show boss health with a health bar for $spell:105479"
})

L:SetMiscLocalization({
	Pull		= "The plates! He's coming apart! Tear up the plates and we've got a shot at bringing him down!",
	BloodCount	= "Blood Count",
	PlasmaTarget	= "Searing Plasma: %s",
	DRoll		= "about to roll left",
	DRollR		= "about to roll right",
	DLevels			= "levels out"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetTimerLocalization({
	TimerMutant  = "Next Mutated Corruption"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	TimerMutant  = "Show timer for next Mutated Corruption",
	RangeFrame			= "Show dynamic range frame based on player debuff status for\n$spell:108649 on Heroic difficulty",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649),
	SetIconOnCrush	= "Set Icon for the two $spell:106385 targets on each platform in 10-man raid"
})

L:SetMiscLocalization({
	Pull				= "You have done NOTHING. I will tear your world APART."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"Dragonsoul Trash"
})

L:SetWarningLocalization({
	DrakesLeft			= "Twilight Assaulter remaining: %d"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s"--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "Announce how many Twilight Assaulters remain",
	TimerDrakes			= "Show timer for when Twilight Assaulters $spell:109904"
})

L:SetMiscLocalization({
	EoEEvent			= "It is no use, the power of the Dragon Soul is too great",--Partial
	UltraxionTrash		= "It is good to see you again, Alexstrasza. I have been busy in my absence.",
	UltraxionTrashEnded = "Mere whelps, experiments, a means to a greater end. You will see what the research of my clutch has yielded."
})