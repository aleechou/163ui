local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s soon!", -- prepare survival ablility or move boss. need more specific message.
	specWarnMySD 				= "you pull the BOSS point of the group of petrochemical",
	specWarnBreakJasperChains	= "Break Jasper Chains!"
})

L:SetOptionLocalization({
	SoundWOP				= "Voice warning: important skills",
	SpecWarnOverloadSoon		= "Show special warning before overload",
	specWarnMySD		= "Show special warning when you pull the BOSS point of the group of petrochemical",
	specWarnBreakJasperChains	= "Show special warning when it is safe to break $spell:130395",
	ArrowOnJasperChains			= "Show DBM Arrow when you are affected by $spell:130395 ",
	InfoFrame					= "Show info frame for active petrification",
	AInfoFrame					= "Show simple info frame for active petrification"
})

L:SetMiscLocalization({
	Overload	= "%s is about to Overload!",
	SDNOT		= "[NO Petrification]",
	SDBLUE		= "[|cFFFFA500Petrification|r:|cFF0080FFCobalt|r]",
	SDGREEN		= "[|cFFFFA500Petrification|r:|cFF088A08Jade|r]",
	SDRED		= "[|cFFFFA500Petrification|r:|cFFFF0404Jasper|r]",
	SDPURPLE	= "[|cFFFFA500Petrification|r:|cFF9932CDAmethyst|r]",
	NEXTR		= "|cFFFFA500Next Overload|r:|cFFFF0404Jasper|r",
	NEXTG		= "|cFFFFA500Next Overload|r:|cFF088A08Jade|r",
	NEXTB		= "|cFFFFA500Next Overload|r:|cFF0080FFCobalt|r",
	NEXTP		= "|cFFFFA500Next Overload|r:|cFF9932CDAmethyst|r"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase					= "Phase %d",
	specWarnDrawFlame			= "Draw Flame > %d <",
	specWarnArcaneVelocity 		= "Arcane Velocity > %d <",
	specWarnEpicenter 			= "Epicenter > %d <",
	specWarnSiphoningShield 	= "Siphoning Shield > %d <"
})

L:SetOptionLocalization({
	SoundWOP			= "Voice warning: important skills",
	InfoFrame			= "InfoFrame: Tank Debuff($spell:131788 $spell:116942 $spell:131790)",
	HudMAP				= "HUDMAP: $spell:116784",
	HudMAP2				= "HUDMAP: $spell:116417",
	HudMAP3				= "HUDMAP：$spell:115817",
	WarnPhase	= "Announce Phase transition",
	specWarnDrawFlame 	= "Voice warning: $spell:116711",
	specWarnArcaneVelocity 	= "Voice warning: $spell:116364",
	specWarnEpicenter 	= "Voice warning: $spell:116018",
	specWarnSiphoningShield = "Voice warning: $spell:117203",
	RangeFrame	= "Show range frame (6) during arcane phase",
	SetIconOnWS	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116784),
	SetIconOnAR	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116417)
})

L:SetMiscLocalization({
	Fire		= "Oh exalted one! Through me you shall melt flesh from bone!",
	Arcane		= "Oh sage of the ages! Instill to me your arcane wisdom!",
	Nature		= "Oh great spirit! Grant me the power of the earth!",--I did not log this one, text is probably not right
	Shadow		= "Great soul of champions past! Bear to me your shield!"
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetWarningLocalization({
	specWarninTT 	= ">> Go To Totem <<",
	SpecWarnjs		= "<%s> → %s"
})

L:SetOptionLocalization({
	SoundWOP			= "Voice warning: important skills",
	SoundTT				= "Voice warning: $spell:116174",
	countTT				= "\"TOTEM\" Count",
	countnone			= "None",
	count3				= "1~3",
	count4				= "1~4",
	specWarninTT		= "warning:display text warning When you need to enter totem",
	specWarnTotemEx		= "warning:Display grouping and counting totem warning",
	specWarnTotemE1		= "warning:counting totem(147)",
	specWarnTotemE2		= "warning:counting totem(258)",
	specWarnTotemE3		= "warning:counting totem(369)",
	soundTotemEx		= "warning:counting totem voice (1~3)",
	SpecWarnjs			= "warning:Damage reduction",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151),
	InfoFrame			= "infoframe:$spell:116161",
	optjs				= "Damage reduction Mod",
	non					= "none",
	druid				= "druid",
	priest				= "priest",
	paltank				= "paltank",
	palheal				= "palheal",
	warrior1			= "warrior1",
	warrior2			= "warrior2",
	monktank			= "monktank",
	paldps1				= "paldps1",
	paldps2				= "paldps2"
})

L:SetMiscLocalization({
	Pull		= "It be dyin' time, now!"
})


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	specWarnDDL 	= ">> Next:You Interrupt<<",
	specWarnQBH		= "Next: Annihilate!",
	specWarnQBHT	= "Next: Annihilate!",
	specWarnDSoon	= "3s: >> Shield! <<",
	DarknessSoon		= "Shield of Darkness in %ds"
})

L:SetOptionLocalization({
	RangeFrame			= "Show range frame (8)",
	SoundWOP			= "Voice warning: important skills",
	SoundDS				= "Voice warning: Dispel $spell:117697 and $spell:117961",
	DarknessSoon		= "Show pre-warning countdown for $spell:117697 (5s before)",
	InfoFrame			= "InfoFrame: $spell:118303",
	HudMAP				= "HudMAP: $spell:118047",
	HudMAP2				= "HudMAP：$spell:118303",
	SoundCT				= "Voice warning: Kick $spell:117833"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "Watch your step!",
	specWarnCharge				= "Charge [%d]",
	specwarnYB					= "Annihilation >>YOU MUST TARGET<<",
	specWarnProtector			= "Protector [%d]"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "Watch your step!"
})

L:SetOptionLocalization({
	SoundWOP					= "Voice warning: important skills",
	SoundCC						= "Voice warning: Dispel $spell:117949",
	SoundDD						= "Voice warning: when you Disappear $spell:117878",
	optDBPull					= "Voice warning: warning $spell:117960 for tank who is pulling $journal:6178",
	specWarnDespawnFloor		= "Show special warning before floor vanishes",
	specWarnCharge				= "Show special warning: Charges",
	specWarnProtector			= "Show special warning: $journal:6178",
	timerDespawnFloor			= "show timer for when floor vanishes",
	SetIconOnDestabilized	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(132226),
	InfoFrame					= "InfoFrame: $spell:117878 Stacks",
	optOC						= "How many \"OverLoad\" Stacks，Beginning warning",
	six							= "6 Stacks",
	nine						= "9 Stacks",
	twelve						= "12 Stacks",
	fifteen						= "15 Stacks",
	none						= "Don't warning",
	optPos 						= "DBM arrow: highest Core (Anti-clockwise Starting at the entrance)",
	nonepos 					= "Don't arrow",
	posA 						= "number 1",
	posB 						= "number 2",
	posC						= "number 3",
	posD 						= "number 4",
	posE 						= "number 5",
	posF 						= "number 6",
	optYB						= "First Annihilation Target",
	noYB						= "NO",
	YB1							= "first",
	YB2							= "second",
	YB3							= "third",
	YB4							= "fourth",
	YB5							= "fifth",
	optYBT						= "Second Annihilation Target",
	noYBT						= "NO",
	YBT1						= "first",
	YBT2						= "second",
	YBT3						= "third",
	YBT4						= "fourth",
	YBT5						= "fifth"
})

L:SetMiscLocalization({
	Floor						= "Energy vortex energy is reduced!"
})
------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetWarningLocalization({
	specWarnBomb				= ">> Bomb(%d) <<",
	specWarnKZ					= ">> Control(%d) <<",
})

L:SetOptionLocalization({
	InfoFrame			= "Show info frame for players affected by $spell:116525",
	ArrowOnCombo	= "Show DBM Arrow during $journal:5673\nNOTE: This assumes tank is in front of boss and anyone else is behind.",
	SoundWOP			= "Voice warning: important skills",
	SoundADD1A			= "Voice warning:$spell:ej5678 (5s before)",
	SoundADD1			= "Voice warning:$spell:ej5678",
	SoundADD2A			= "Voice warning:$spell:ej5676 (8s before)",
	SoundADD2			= "Voice warning:$spell:ej5676",
	SoundADD3A			= "Voice warning:$spell:ej5677 (8s before)",
	SoundADD3			= "Voice warning:$spell:ej5677",
	optBY 				= "Voice warning: only the tips of this boss's special attack ",
	tarfoc 				= "target and focus of special attacks ",
	Janxi 				= "Jan Xi special attack (on the left side) ",
	Qinxi 				= "Qin Xi special attack (on the right side) ",
	none 				= "Don't warning"
})

L:SetMiscLocalization({
	Pull		= "The machine hums to life!  Get to the lower level!",--Emote
	Rage		= "The Emperor's Rage echoes through the hills.",--Yell
	Strength	= "The Emperor's Strength appears in the alcoves!",--Emote
	Courage		= "The Emperor's Courage appears in the alcoves!",--Emote
	Boss		= "Two titanic constructs appear in the large alcoves!"--Emote
})