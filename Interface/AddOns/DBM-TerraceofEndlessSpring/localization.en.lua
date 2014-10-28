local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Rotate In: Group %s",
	specWarnYourGroup	= "Your Group - Rotate In!",
	specWarnYourEnd		= "Your Group - Back!",
	specWarnDDL 	= "Next You Interrupt!",
	SpecWarnJSA		= "%s Health >>damage reduction<<"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Announce group rotation for $spell:118191\n(Currently only supports 25 man 5,2,2,2, etc... strat)",
	specWarnYourGroup	= "Show special warning when it's your group's turn for $spell:118191\n(25 man only)",
	specWarnYourEnd		= "Special Warning: Done adds this round",
	RangeFrame			= "Show range frame (8) for $spell:111850\n(Shows everyone if you have debuff, only players with debuff if not)",
	HudMAP 			= "HudMAP: $spell:111850",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436),
	SoundDW 			= "voice warning: $spell:117283 disperse",
	SoundSDQ			= "Voice Warning: Dispel $spell:117436",
	SoundWater			= "Voice Warning: $spell:117309, Pull boss away(Tank)",
	SoundWOP			= "voice warning: important skills",
	optDD4				= "4 man interrupt chain(loop first 3 if not selected)",
	opthelpDD			= "Voice Warning: When $spell:118077 warn you to help interrupt first $spell:118312",
	specWarnDDL 		= "Special Warning: Next your interrupt",
	optDD				= "Water Boss interrupt chain",
	nodd				= "No",
	DD1					= "Interrupt 1",
	DD2					= "Interrupt 2",
	DD3					= "Interrupt 3",
	DD4					= "Interrupt 4",
	optMob				= "Select your adds group",
	Mob1				= "Adds group 1",
	Mob2				= "Adds group 2",
	Mob3				= "Adds group 3",
	Mob4				= "Adds group 4",
	Mob5				= "Adds group 5",
	noMob				= "No",
	optMobSet			= "Adds strategy(Support 4 or 5 groups loop, if skip input 0)",
	warndr9				= "Defensive Warning: 3rd Phase Water Boss 90% health",
	warndr8				= "Defensive Warning: 3rd Phase Water Boss 80% health",
	warndr7				= "Defensive Warning: 3rd Phase Water Boss 70% health",
	warndr6				= "Defensive Warning: 3rd Phase Water Boss 60% health",
	warndr5				= "Defensive Warning: 3rd Phase Water Boss 50% health",
	warndr4				= "Defensive Warning: 3rd Phase Water Boss 40% health",
	warndr3				= "Defensive Warning: 3rd Phase Water Boss 30% health",
	warndr2				= "Defensive Warning: 3rd Phase Water Boss 20% health",
	warndr1				= "Defensive Warning: 3rd Phase Water Boss 10% health",
	SpecWarnJSA			= "Special Warning: Defensive Cooldowns",
	helpdispset			= "Input a special focus player for $spell:117398 dispel"
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetWarningLocalization({
	SpecWarnJSA				= "%d Mobs >>damage reduction<<"
})

L:SetOptionLocalization ({
	SoundWOP 	= "voice warning: important skills",
	SoundGH						= "Voice Warning: $journal:6551 refresh and count",
	SoundHX						= "Voice Warning: $spell:122752 count down",
	SoundMY						= "Voice Warning: $spell:122770 count down(If this is on, count down for $spell:122752 is recommend to be off)",
	WarnJK 						= "voice warning: $spell:123011 advance warning",
	SpecWarnJSA					= "Special Warning: Defensive",
	unseenjs1					= "Defensive Warning: $journal:6320 1",
	unseenjs2					= "Defensive Warning: $journal:6320 2",
	unseenjs3					= "Defensive Warning: $journal:6320 3",
	unseenjs4					= "Defensive Warning: $journal:6320 4",
	unseenjs5					= "Defensive Warning: $journal:6320 5",
	unseenjs6					= "Defensive Warning: $journal:6320 6",
	lod1						= "Light Of Day Warning: $journal:6551 1",
	lod2						= "Light Of Day Warning: $journal:6551 2",
	lod3						= "Light Of Day Warning: $journal:6551 3",
	lod4						= "Light Of Day Warning: $journal:6551 4",
	lod5						= "Light Of Day Warning: $journal:6551 5",
	lod6						= "Light Of Day Warning: $journal:6551 6",
	lod7						= "Light Of Day Warning: $journal:6551 7",
	lod8						= "Light Of Day Warning: $journal:6551 8",
	lod9						= "Light Of Day Warning: $journal:6551 9",
	lod10						= "Light Of Day Warning: $journal:6551 10",
	lod11						= "Light Of Day Warning: $journal:6551 11",
	HudMAP 						= "HudMAP:$spell:122770 (only 10N/10H Mode) ",
	optDS 						= "shadow of terror, how many stacks start warning",
	six 						= "6",
	nine 						= "9",
	twelve 						= "12",
	fifteen 					= "15",
	none 						= "Don't warning",
	optTS						= "Priest Angle notice",
	TS1							= "1st Sun Breath",
	TS2							= "2nd Sun Breath",
	TS3							= "3rd Sun Breath",
	noms						= "No"
})

L:SetMiscLocalization{
	Victory	= "I thank you, strangers. I have been freed."
}


-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s has ended",
	SpecWarnJSA				= ">>Damage reduction skill!<<",
	warnHideProgress		= "Hits: %s. Damage: %s. Time: %s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Special CD (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Show warning when $spell:123244 has ended",
	warnHideProgress		= "Show statistics for $spell:123244 when it ends",
	timerSpecialCD			= "Show timer for special ability CD",
	HudMAP					= "HUD MAP: Player with more than 5 stacks $spell:123705",
	InfoFrame				= "Info Frame: Boss's $spell:123712",
	SpecWarnJSA				= "Special Warning: Defensive",
	unseenjs1				= "Defensive Warning: Get Away 1",
	unseenjs2				= "Defensive Warning: Get Away 2",
	unseenjs3				= "Defensive Warning: Get Away 3",
	unseenjs4				= "Defensive Warning: Get Away 4",
	unseenjs5				= "Defensive Warning: Get Away 5",
	SoundWOP 				= "voice warning: important skills",
	SetIconOnGuardfix		= "Set icons on $journal:6224",
	RangeFrame				= "Show range frame (3) for $spell:123121\n(Shows everyone during Hide, otherwise, only shows tanks)",
	GWHealthFrame			= "Show remaining health frame for $spell:123461 fades\n(Requires boss health frame enabled)" -- maybe bad wording, needs review
})

L:SetMiscLocalization{
	Victory	= "I... ah... oh! Did I...? Was I...? It was... so... cloudy."--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	specWarnyinmo		= "Submerge >%d<",
	specWarnzyg			= "Light (From >%s<)",
	specWarnweisuo		= "Huddle in Terror >%d<",
	specWarningpreHud	= "Huddle in Terror SOON!",
	specWarnfuxian		= "Sons %d - %d",
	MoveWarningLeft		= "¡û ¡û Left",
	MoveWarningRight	= "Right ¡ú ¡ú",
	MoveWarningBack		= "¡ú ¡ú Back ¡û ¡û"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Next Special",
	timerSpoHudCD			= "Next Spo / Hud",
	timerSpoStrCD			= "Next Spo / Str",
	timerHudStrCD			= "Next Hud / Str"
})

L:SetOptionLocalization ({
	SoundDD = "voice warning: $spell:131996",
	SoundWOP = "voice warning: important skills",
	InfoFrameTankMode	= "Show boss attack count in Info Frame instead of $spell:120629",
	RangeFrame			= "Show range frame (2) for $spell:119519",
	pscount				= "Voice Warning: $spell:120047",
	HudMAP				= "HUD MAP: $spell:120519",
	InfoFrame			= "Info Frame: $spell:120629 and $journal:6107 count",
	timerSpecialCD		= "Timer: Next P2 Special",
	specWarnyinmo		= "Special Warning: $spell:120455",
	specWarnfuxian		= "Special Warning: $spell:120458",
	specWarnweisuo		= "Special Warning: $spell:120629",
	specWarnzyg			= "Special Warning: $spell:120268",
	specWarningpreHud	= "Special Warning: $spell:120629 incoming",
	MoveWarningLeft		= "Special Warning: Step left",
	MoveWarningRight	= "Special Warning: Step right",
	MoveWarningBack		= "Special Warning: Step back",
	ShaAssist			= "Special Function: Enable $spell:120047 direction map(Type /sha to adjust details)",
	ShaStarMode			= "Use <Star> strategy for $spell:120047 (Take one shot to decrease running needed)",
	timerSpoHudCD		= "Timer: Next $spell:120629 or $spell:120519",
	timerSpoStrCD		= "Timer: Next $spell:120519 or $spell:120672",
	timerHudStrCD		= "Timer: Next $spell:120629 or $spell:120672",
	SoundWSCOUNT		= "Voice Warning: Play 1-4 voice count loop for $spell:120629",
	unseenjs1			= "Defensive Warning: $spell:120629 1/4",
	unseenjs2			= "Defensive Warning: $spell:120629 2/4",
	unseenjs3			= "Defensive Warning: $spell:120629 3/4",
	unseenjs4			= "Defensive Warning: $spell:120629 4/4",
	SetIconOnWS			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(120629)
})

L:SetMiscLocalization({
	sanlian				= "Thrash",
	liulian				= "DreadThrash"
})