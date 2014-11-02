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
	HudMAP3				= "HUDMAP: $spell:115817",
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
	GoTotemAdmin		= "Admin: Assign Totem(Heroic only, Raid leader only)",
	GoTotemClient		= "Client: Recieve Totem warnings(Heroic only, need Admin)",
	optAdminTT			= "Admin Option: How many DPS go Totem(exclude healer, 1 healer will be assigned everytime)",
	send1				= "1",
	send2				= "2(recommended for 10 man)",
	send3				= "3(recommended for 25 man)",
	send4				= "4",
	IgnoreTT1			= "Admin Option: Ignore Totem 1",
	IgnoreTT2			= "Admin Option: Ignore Totem 2",
	IgnoreTT3			= "Admin Option: Ignore Totem 3",
	IgnoreTT4			= "Admin Option: Ignore Totem 4",
	IgnoreTT5			= "Admin Option: Ignore Totem 5",
	IgnoreTT6			= "Admin Option: Ignore Totem 6",
	IgnoreTT7			= "Admin Option: Ignore Totem 7",
	IgnoreTT8			= "Admin Option: Ignore Totem 8",
	IgnoreTT9			= "Admin Option: Ignore Totem 9",
	IgnoreTT10			= "Admin Option: Ignore Totem 10",
	IgnoreTT11			= "Admin Option: Ignore Totem 11",
	IgnoreTT12			= "Admin Option: Ignore Totem 12",
	IgnoreTT13			= "Admin Option: Ignore Totem 13",
	IgnoreTT14			= "Admin Option: Ignore Totem 14",
	IgnoreTT15			= "Admin Option: Ignore Totem 15",
	IgnoreTT16			= "Admin Option: Ignore Totem 16",
	IgnoreTT17			= "Admin Option: Ignore Totem 17",
	SpecWarnjs			= "Special Warning: defensive cooldown chain",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151),
	InfoFrame			= "Info Frame: $spell:116161 Player (Mark \"healer\", need role selection)",
	optjs				= "Defensive cooldown special warning",
	non					= "No",
	druid				= "Druid",
	priest				= "Priest",
	paltank				= "Pally tank",
	palheal				= "Pally healer",
	warrior1			= "Warrior A",
	warrior2			= "Warrior B",
	monktank			= "Monk tank",
	paldps1				= "Pally dps A",
	paldps2				= "Pally dps B",
	optindex			= "Client Option: DPS go Totem sequence(Not for healer, always assign the healer with lowest mana)",
	noidex				= "No",
	index1				= "No. 1(Highest)",
	index2				= "No. 2",
	index3				= "No. 3",
	index4				= "No. 4",
	index5				= "No. 5",
	index6				= "No. 6",
	index7				= "No. 7",
	index8				= "No. 8",
	index9				= "No. 9"
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
	SoundDSA			= "Voice warning: Dispel $spell:117697 and $spell:117961",
	InfoFrame			= "InfoFrame: $spell:118303",
	HudMAP				= "HudMAP: $spell:118047",
	HudMAP2				= "HudMAP: $spell:118303",
	SoundCT				= "Voice warning: Kick $spell:117833",
	DarknessSoon		= "Show pre-warning countdown for $spell:117697 (5s before)",
	optDD				= "Interrupt chain",
	nodd				= "No",
	DD1					= "Interrupt 1",
	DD2					= "Interrupt 2",
	DD3					= "Interrupt 3",
	DD4					= "Interrupt 4",
	optKZ				= "Subetai the Swift Stun Chain",
	noKZ				= "No",
	KZ1					= "Stun 1",
	KZ2					= "Stun 2",
	specWarnDDL 		= "Special Warning: You're next to interrupt",
	specWarnQBH			= "Special Warning: $spell:117920 incoming next",
	specWarnQBHT		= "Special Warning: $spell:117920 incoming next(Tank)",
	specWarnDSoon		= "Special Warning: Shield fading soon"
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
	specwarnYB					= "Show special warning: Take $spell: 129711",
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
	Floor						= "The Energy Vortex is powering down!"
})
------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetWarningLocalization({
	specWarnBomb				= ">> Bomb(%d) <<",
	specWarnKZ					= ">> Control(%d) <<"
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
	ragebomb1			= "Heroic: Rage Bomb 3",
	ragebomb2			= "Heroic: Rage Bomb 6",
	ragebomb3			= "Heroic: Rage Bomb 9",
	ragebomb4			= "Heroic: Rage Bomb 12",
	ragebomb5			= "Heroic: Rage Bomb 15",
	specWarnBomb		= "Special Warning: Bomb this round",
	specWarnKZ			= "Special Warning: Control this round",
	optKZ				= "Rage Control Chain",
	kza					= "Control A",
	kzb					= "Control B",
	kzc					= "Control C",
	nokz				= "No",
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

