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
	RangeFrame			= "Show range frame (8) for $spell:111850\n(Shows everyone if you have debuff, only players with debuff if not)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436),
	HudMAP 				= "HudMAP: $spell:111850",
	SoundDW 			= "voice warning: $spell:117283 disperse",
	SoundWOP			= "voice warning: important skills"
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
	WarnJK 	= "voice warning: $spell:123011 advance warning",
	HudMAP 		= "HudMAP:$spell:122770 (only 10N/10H Mode) ",
	optDS 		= "shadow of terror, how many stacks start warning",
	six 		= "6",
	nine 		= "9",
	twelve 		= "12",
	fifteen 	= "15",
	none 		= "Don't warning"
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
	RangeFrame			= "Show range frame (2) for $spell:119519",
	SoundDD = "voice warning: $spell:131996",
	SoundWOP = "voice warning: important skills"
})

L:SetMiscLocalization({
	sanlian				= "Thrash",
	liulian				= "DreadThrash"
})