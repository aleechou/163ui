-- English by Iceoven(iceoven@jjw.in)
-- Last update: 11/6/2013

local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	SpecWarnJSA			= ">>> Defensive <<<"
})

L:SetOptionLocalization({
	SoundWOP			= "Voice Warning: Important Skills",
	SpecWarnJSA			= "Special Warning: Defensive",
	SoundWOPIonM		= "Voice Warning: $spell:138732 at the 7th second( replace the warning before it ends)",
	dr1					= "Defensive Warning: $spell:137313 1/3-1 [at the beginning]",
	dr2					= "Defensive Warning: $spell:137313 1/3-2 [at the 5th second]",
	dr3					= "Defensive Warning: $spell:137313 2/4-1",
	dr4					= "Defensive Warning: $spell:137313 2/4-2",
	RangeFrame			= "Range Frame"
})


--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds		= "%s",
	SpecWarnJSA		= ">>> Defensive <<<",
	warnOrbofControl		= "Orb of Control",
	specWarnOrbofControl		= ">>Orb of Control<<"
})

L:SetTimerLocalization({
	timerDoor		= "Next door open",
	timerAdds		= "Next %s"
})

L:SetOptionLocalization({
	warnAdds			= "Warning: Adds down",
	warnOrbofControl		= "Warning: $journal:7092 dropped",
	specWarnOrbofControl		= "Special Warning: $journal:7092 dropped",
	SoundWOP			= "Voice Warning: Important Skills",
	SpecWarnJSA			= "Special Warning: Defensive",
	InfoFrame			= "Info: $spell:137458 Count",	
	ccsoon				= "Voice Warning: $spell:136767 soon(ignore when targeting boss)",
	ddyls				= "Voice Warning: Interrupt $spell:136797",
	dr1					= "Defensive Warning: $spell:136817 1",
	dr2					= "Defensive Warning: $spell:136817 2",
	dr3					= "Defensive Warning: $spell:136817 3",
	dr4					= "Defensive Warning: $spell:136817 4",
	SoundDB				= "Voice Warning: $spell:136741",
	SoundOrb			= "Voice Warning: $journal:7092",
	optQS				= "DEBUFF dispel chain",
	noQS				= "No warning",
	QS1					= "No.1",
	QS2					= "No.2",
	QS3					= "No.3",
	allQS				= "Always warn",
	RangeFrame			= "Range Frame: Bear door 5 yards",
	SoundWSP			= "Voice Warning: $journal:7866 within 20 yards (Please set focus on your soul)",
	dispsetHex			= "Warn you to dispel people you set when they got Hex of Confusion",
	timerDoor			= "Timer: Next door open",
	timerAdds			= "Timer: Next adds",

})

L:SetMiscLocalization({
	newForces				= "forces pour from the",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget			= "stamps his tail!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnDDL 	= ">> You are next to interrupt <<",
	specWarnPossessed		= "%s %s - Switch Target!"
})

L:SetOptionLocalization({
	SoundWOP		= "Voice Warning: Important Skills",
	helpcold		= "Monitor the temperature on this one: Warn 3 seconds before it's gone",
	InfoFrame		= "Info Frame: $spell:136442 info",
	SoundLs			= "Countdown: $spell:136521",	
	SoundHs			= "Voice Warning: $spell:136990",
	Soundspirit		= "Countdown: Spirit",
	HudMAP			= "HUD MAP: $spell:136992",
	HudMAP2			= "HUD MAP: $spell:136922",
	optDD			= "Sand boss interrupt chain",
	nodd			= "Don't interrupt",
	DD1				= "Interrupt 1",
	DD2				= "Interrupt 2",
	DD3				= "Interrupt 3",
	dr1				= "Defensive Warning: $spell:137166 1",
	dr2				= "Defensive Warning: $spell:137166 2",
	dr3				= "Defensive Warning: $spell:137166 3",
	optOC			= "How many stacks of Shadowed Soul do you want to be warned",
	five			= "5 stacks",
	ten				= "10 stacks",
	none			= "Never",
	specWarnDDL 	= "Special Warning: You are next to interrupt",
	warnPossessed		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	warnSandBolt		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	PHealthFrame		= "Show remaining health frame for $spell:136442 fades\n(Requires boss health frame enabled)",
	RangeFrame			= "Show Range Frame",
	SetIconOnBitingCold	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136992),
	SetIconOnFrostBite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136922)
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s is kicked by >%s< (%d remaining)",
	specWarnCrystalShell	= "Get >%s<"
})

L:SetOptionLocalization({
	warnKickShell			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	SoundWOP				= "Voice Warning: Important Skills",
	SoundAE					= "Countdown: $spell:133939",
	SoundXG					= "Voice Warning: $journal:7129 out",
	dr1						= "Defensive Warning: $spell:134920 1/4",
	dr2						= "Defensive Warning: $spell:134920 2/4",
	dr3						= "Defensive Warning: $spell:134920 3/4",
	dr4						= "Defensive Warning: $spell:134920 4/4",
	specWarnCrystalShell	= "Special Warning: Missing $spell:137633",
	InfoFrame				= "Info Frame: Missing $spell:137633",
	warnsj					= "Special Function: Crystal Shell intelligent warning",
	ClearIconOnTurtles		= "Clear Mark for $journal:7129",
	SetIconOnTurtles		= "Makr $journal:7129 (not reliable if more than 1 assistant)",
})

L:SetMiscLocalization({
	WrongDebuff		= "No %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD			= "Next Breath"
})

L:SetWarningLocalization({
	SpecWarnJSA			= ">>> Defensive <<<"
})

L:SetOptionLocalization({
	SoundWOP		= "Voice Warning: Important Skills",
	timerBreaths			= "Timer: Next Breath",
	SoundXL			= "Voice Warning: $spell:140138",
	HudMAP			= "HUD MAP: $spell:139822",
	HudMAP2			= "HUD MAP: $spell:139889",
	dr1				= "Defensive Warning: $spell:139458 1",
	dr2				= "Defensive Warning: $spell:139458 2",
	dr3				= "Defensive Warning: $spell:139458 3",
	dr4				= "Defensive Warning: $spell:139458 4",
	dr5				= "Defensive Warning: $spell:139458 5",
	dr6				= "Defensive Warning: $spell:139458 6",
	dr7				= "Defensive Warning: $spell:139458 7",
	dr8				= "Defensive Warning: $spell:139458 8",
	InfoFrame		= "Info Frame: $journal:7006",
	SpecWarnJSA			= "Special Warning: Defensive",
	SetIconOnCinders		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(139822),
	SetIconOnTorrentofIce	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(139889)
})

L:SetMiscLocalization({
	rampageEnds	= "Megaera's rage subsides.",
	Behind			= "Behind fog: "
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%s %s (%s)",
	specWarnFlock	= "%s %s (%s)"
})

L:SetTimerLocalization({
	timerFlockCD	= "Wave %d: %s"
})

L:SetOptionLocalization({
	SoundWOP		= "Voice Warning: Important Skills",
	HudMAP			= "HUD MAP: Mark possible drop point for $spell:138923(exclude yours)",
	HudMAPMe		= "ALso mark $spell:138923 targets you(Not recommended)",
	warnFlock		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	timerFlockCD	= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	add1			= "1st $journal:7348(down)",
	add2			= "2nd $journal:7348(down)",
	add3			= "3rd $journal:7348(down)",
	add4			= "4th $journal:7348(up)",
	add5			= "4th $journal:7348(down)",
	add6			= "5th $journal:7348(up)",
	add7			= "5th $journal:7348(down)",
	add8			= "6th $journal:7348(up)",
	add9			= "7th $journal:7348(up)",
	add10			= "7th $journal:7348(down)",
	add11			= "8th $journal:7348(up)",
	add12			= "8th $journal:7348(down)",
	add13			= "9th $journal:7348(up)",
	add14			= "9th $journal:7348(down)",
	add15			= "10th $journal:7348(up)",
	add16			= "10th $journal:7348(down)",
	add17			= "11th $journal:7348(up)",
	add18			= "11th $journal:7348(down)",
	add19			= "12th $journal:7348(up)",
	add20			= "12th $journal:7348(down)",
	add21			= "13th $journal:7348(up)",
	add22			= "13th $journal:7348(down)",
	add23			= "14th $journal:7348(up)",
	add24			= "14th $journal:7348(down)",
	add25			= "15th $journal:7348(up)",
	add26			= "15th $journal:7348(down)",
	add27			= "16th $journal:7348(up)",
	add28			= "16th $journal:7348(down)",
	add29			= "17th $journal:7348(up)",
	add30			= "17th $journal:7348(down)",
	add31			= "18th $journal:7348(up)",
	add32			= "18th $journal:7348(down)",
	add33			= "19th $journal:7348(up)",
	add34			= "19th $journal:7348(down)",
	add35			= "20th $journal:7348(up)",
	add36			= "20th $journal:7348(down)",
	dr1				= "Defensive Warning: $spell:134380 1",
	dr2				= "Defensive Warning: $spell:134380 2",
	dr3				= "Defensive Warning: $spell:134380 3",
	dr4				= "Defensive Warning: $spell:134380 4",
	dr5				= "Defensive Warning: $spell:134380 5",
	dr6				= "Defensive Warning: $spell:134380 6",
	dr7				= "Defensive Warning: $spell:134380 7",
	RangeFrame		= "Range Frame(8 yards): $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "The eggs in one of the lower nests begin to hatch!",
	eggsHatchU		= "The eggs in one of the upper nests begin to hatch!",
	Upper			= "Upper",
	Lower			= "Lower",
	UpperAndLower	= "Upper & Lower",
	TrippleD		= "Tripple (2xDwn)",
	TrippleU		= "Tripple (2xUp)"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Beam - |cffff0000Red|r : >%s<, |cff0000ffBlue|r : >%s<",
	warnBeamHeroic				= "Beam - |cffff0000Red|r : >%s<, |cff0000ffBlue|r : >%s<, |cffffff00Yellow|r : >%s<",
	specWarnBlueBeam			= "BLUE beam on you - DO NOT MOVE!!!!",
	warnAddsLeft				= "Fogs left: %d",
	specWarnFogRevealed			= "%s revealed!",
	specWarnHold				= "Dark Parasite(%d sec)--Self Defensive",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	SoundWOP					= "Voice Warning: Important Skills",
	specWarnBlueBeam			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(139202),
	warnBeam					= "Warn beam target",
	optDD						= "Auto assign beam team",
	DXsound						= "HUD MAP: $spell:133795",
	InfoFrame					= "Info Frame: $spell:133597 (If also monitor $spell:133795 then show $spell:133795 stacks first)",
	InfoFrameLife				= "Info Frame: $spell:133795 stacks",
	Sayam						= "Special Function: When being life drained call out stacks(message can be customized below)",
	nodd						= "Float",
	DD1							= "A:Red-Yellow-Blue",
	DD2							= "B:Yellow-Blue-Red",
	DD3							= "C:Blue-Red-Yellow",
	HDD1						= "H-A:Red Red Red",
	HDD2						= "H-B:Blue Blue Yellow",
	HDD3						= "H-C:Yellow Yellow Blue",
	HudMAP						= "HUD MAP: Beam Assignment",
	warnAddsLeft				= "Warning: Adds left",
	specWarnFogRevealed			= "Special Warning: Fog Revealed",
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam					= "DBM Arrow: $journal:6882 moving direction",
	soundhold					= "How many seconds after you got Dark Parasite do you want to be warned(30 - dispel cd - self defensive duration)",
	sounddisp					= "How many seconds before Dark Parasite ends do you want to be warned to help dispel(Healer)",
	specWarnHold				= "Special Warning: Dark Parasite Self Defensive",
	xx1							= "Message for Life Drain stack 1",
	xx2							= "Message for Life Drain stack 2",
	xx3							= "Message for Life Drain stack 3(DBM will show stack numbers afterwards)",
	lifeA						= "Wisper this player to help life drain when you got 2 stacks",
	lifeB						= "Wisper this player to help life drain when you got 2 stacks",
	SetIconRays					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej6891"),
	SetIconLifeDrain			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(133795),
	SetIconOnParasite			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(133597),
	SetParticle					= "Automatically set particle density to low on pull\n(Restores previous setting on combat end)"


})

L:SetMiscLocalization({
	Eye		= "Eye",
	xx1noset = "11111111 Life Drain on me!!!",
	xx2noset = "22222 Life Drain Help!!! Help!!!",
	xx3noset = "I'm gonna be sucked to death---------",
	dx		= "HELP LIFE DRAIN HERE!!"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "Too many mutations: %d/5 good & %d bad",
})

L:SetOptionLocalization({
	SoundWOP		= "Voice Warning: Important Skills",
	HudMAPF			= "HUD MAP: $spell:136248",
	warnDebuffCount		= "Warning: when you got debuff",
	InfoFrame		= "Info Frame: Boss current $journal:6949 skill",
	RangeFrame		= "Show Range Frame(2 yards / 5 yards)",
	SetIconOnBigOoze	= "Auto mark $journal:6969"
})

L:SetMiscLocalization({
	BossSpellInfo 	= "Boss Spell Info",
	AE1				= "Continuous AE",
	AE2				= "Stack Share Damage (15s)",
	tar5			= "5 yards range (3s)",
	tar1			= "Pathogen Glands (30s)",
	speed			= "Speed up 50%",
	tar2			= "2 yards range (10s)",
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< >%s< Swap",
	SpecWarnJSA			= ">>> Defensive <<<"
})

L:SetOptionLocalization({
	SoundWOP			= "Voice Warning: Important Skills",
	SoundCQ				= "Voice Warning: Warn you to help $spell:136954",
	Mob					= "----Tactical Warning:Kill Adds----",
	dr					= "----Defensive Warning:$spell:139867----",
	dr1					= "Defensive Warning: $spell:139867 1",
	dr2					= "Defensive Warning: $spell:139867 2",
	dr3					= "Defensive Warning: $spell:139867 3",
	dr4					= "Defensive Warning: $spell:139867 4",
	dr5					= "Defensive Warning: $spell:139867 5",
	dr6					= "Defensive Warning: $spell:139867 6",
	dr7					= "Defensive Warning: $spell:139867 7",
	dr8					= "Defensive Warning: $spell:139867 8",
	dr9					= "Defensive Warning: $spell:139867 9",
	dr10				= "Defensive Warning: $spell:139867 10",
	MobA				= "1st Wave Adds",
	MobB				= "2nd Wave Adds",
	MobC				= "3rd Wave Adds",
	SpecWarnJSA			= "Special Warning: Defensive",
	RangeFrame			= "Show Range Frame(8 yards)",
	warnMatterSwapped	= "Warning: $spell:138618 target",
	SetIconOnFont           = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(138707),
})

L:SetMiscLocalization({
	Pull		= "The orb explodes!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s / %s ",
	SpecWarnJSA			= ">>> Defensive <<<"
})

L:SetOptionLocalization({
	warnDeadZone	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	SetIconOnLightningStorm	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136192),
	SoundWOP		= "Voice Warning: Important Skills",
	SoundARAT		= "Voice Warning: Call out $spell:137231 direction",
	SpecWarnJSA		= "Special Warning: Defensive",
	ReapetAP		= "Special Function: If you got $spell:136192 call for help continuously",
	HudMAP			= "HUD MAP: $spell:136192",
	HudLight		= "HUD MAP: Mark $spell:136193 carrier after lightning phase",
	dr1			= "Defensive Warning: $spell:136146 1",
	dr2			= "Defensive Warning: $spell:136146 2",
	dr3			= "Defensive Warning: $spell:136146 3",
	dr4			= "Defensive Warning: $spell:136146 4",
	dr5			= "Defensive Warning: $spell:136146 5",
	dr6			= "Defensive Warning: $spell:136146 6",
	dr7			= "Defensive Warning: $spell:136146 7",
	dispsetLight		= "Warn you if the following players get Arcing Lightning[If set warnings for other players will be ignored]",
	dispsetLight1		= "Player A",
	dispsetLight2		= "Player B",		
	RangeFrame		= "Show Range Frame( will show automatically when too many people around)",
	InfoFrame		= "Info Frame: $spell:136193"
})

L:SetMiscLocalization({
	Helpme			= "Help! Help! CLICK ME ~~~"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight		= "Night Phase",
	warnDay			= "Day Phase",
	warnDusk		= "Dusk Phase"
})

L:SetTimerLocalization({
	timerDayCD		= "Day Phase",
	timerDuskCD		= "Dusk Phase",
})

L:SetOptionLocalization({
	SoundWOP			= "Voice Warning: Important Skills",
	HudMAP				= "HUD MAP: $journal:7651 assist line",
	InfoFrame			= "Info Frame: Next Celestials time(input yourself)",
	drAchoose			= "----Defensive Warning: Night Phase----",
	drA1				= "$spell:136752 1",
	drA2				= "$spell:136752 2",
	drA3				= "$spell:136752 3",
	drA4				= "$spell:136752 4",
	drA5				= "$spell:136752 5",
	drA6				= "$spell:136752 6",
	drA7				= "$spell:136752 7",
	drA8				= "$spell:136752 8",
	drBchoose			= "----Defensive Warning: Day Phase----",
	drC1				= "$spell:137491 1",
	drC2				= "$spell:137491 2",
	drC3				= "$spell:137491 3",
	drCchoose			= "----Defensive Warning: Dusk Phase----",
	drB1				= "$spell:136752 1",
	drB2				= "$spell:136752 2",
	drB3				= "$spell:136752 3",
	drD1				= "$spell:137491 1",
	drD2				= "$spell:137491 2",
	drE1				= "$spell:137531 1",
	drE2				= "$spell:137531 2",
	XNA					= "First Niuzao time(sec)",
	QLA					= "First Yu'lon time(sec)",
	BHA					= "First Xuen time(sec)",
	HHA					= "First Chi-ji time(sec)",
	XNB					= "Second Niuzao time(sec)",
	QLB					= "Second Yu'lon time(sec)",
	BHB					= "Second Xuen time(sec)",
	HHB					= "Second Chi-ji time(sec)",
	warnNight			= "Warning: Night Phase",
	warnDay				= "Warning: Day Phase",
	warnDusk			= "Warning: Dusk Phase",
	timerDayCD			= "Timer: Day Phase",
	timerDuskCD			= "Timer: Dusk Phase",
	RangeFrame			= "Range Frame(8 yards)"
})

L:SetMiscLocalization({
	DuskPhase		= "Lu'lin! Lend me your strength!",
	XN1				= "Niuzao(1)",
	QL1				= "Yu'lon(1)",
	BH1				= "Xuen(1)",
	HH1				= "Chi-ji(1)",
	XN2				= "Niuzao(2)",
	QL2				= "Yu'lon(2)",
	BH2				= "Xuen(2)",
	HH2				= "Chi-ji(2)",
	NextTT			= "Next Celestial",
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Transition Phase Coming",
	warnDiffusionChainSpread	= "%s spread on >%s<"
})

L:SetOptionLocalization({
	SoundWOP		= "Voice Warning: Important Skills",
	specWarnIntermissionSoon	= "Special Warning: Transition Phase Coming",
	RangeFrameLB	= "Range Frame: When lightning ball exists switch to 3 yards(H Mode)",
	cancelhud		= "Cancel HUD when players call out(/say) to not share the damage with them(Input keywords, for example: taking by myself)",
	drpendp2		= "----Defensive: Phase 2----",
	drpend1			= "$spell:135695 1",
	drpend2			= "$spell:135695 2",
	drpend3			= "$spell:135695 3",
	drpend4			= "$spell:135695 4",
	drpend5			= "$spell:135695 5",
	drpendp3		= "----Defensive: Phase 3 Wind----",
	drend1			= "$spell:136869 1",
	drend2			= "$spell:136869 2",
	drend3			= "$spell:136869 3",
	drend4			= "$spell:136869 4",
	drend5			= "$spell:136869 5",
	drend6			= "$spell:136869 6",
	drpendp3b		= "----Defensive: Phase 3 Thunder----",
	drendb1			= "$spell:135095 1",
	drendb2			= "$spell:135095 2",
	drendb3			= "$spell:135095 3",
	drendb4			= "$spell:135095 4",
	drendb5			= "$spell:135095 5",
	drendb6			= "$spell:135095 6",
	optDD			= "Reflection shield warning[ignore p1 and transition phase]",
	nodd			= "I don't use",
	DD1			= "Reflection shield A (odd)",
	DD2			= "Reflection shield B (even)",
	HudMAP			= "HUD MAP: $spell:135695",
	HudMAP2			= "HUD MAP: $spell:136295",
	RangeFrame		= "Range Frame",--For two different spells
	warnDiffusionChainSpread	= "Announce $spell:135991 spread targets",
	StaticShockArrow	= "DBM Arrow: $spell:135695",
	OverchargeArrow		= "DBM Arrow: $spell:136295",
	SetIconOnOvercharge	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136295),
	SetIconOnStaticShock= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(135695)
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

L:SetTimerLocalization({
	timerAnima		= "Next Anima",
	specWarnVitarun	= "Vitarun Coming"
})

L:SetOptionLocalization({
	SoundWOP		= "Voice Warning: Important Skill",
	SoundStrike		= "3 Seconds count down for $spell:138295",
	specWarnVitarun	= "Special Warning: Vita Run",
	optDD			= "Vita Run tactics",
	nodd			= "Normal rotation players(set number below)",
	DD1			= "Substitute 1",
	DD2			= "Substitute 2",
	DD3			= "Substitute 3",
	DD4			= "Substitute 4",
	DD5			= "Substitute 5",
	lightnumber		= "Normal rotation players number(0 will be ignored)",
	lastnumber		= "How many normal rotation players was assigned?[Required!Very Important!!]",
	HudMAPAnima		= "HUD MAP: $spell:138295",
	HudMAP			= "HUD MAP: $spell:138297",
	timerAnima		= "Timer: Next $spell:138295",
	SetIconOnUnstableVita	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(138297),
	SetIconOnUnstableAnima	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(138288)
})

L:SetMiscLocalization({
	Defeat			= "Wait! I am... I am not your enemy."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name =	"TOT Adds"
})

L:SetOptionLocalization({
	SoundWOP		= "Voice Warning: Important Skills",
	HudMAP			= "HUD MAP: $spell:139322/$spell:139900",
	RangeFrame		= "Range Frame(10 yards)"--For 3 different spells
})
