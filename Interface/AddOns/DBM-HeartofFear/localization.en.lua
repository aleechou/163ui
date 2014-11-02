local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetOptionLocalization({
	specwarnPlatform	= "Show special warning when boss changes platforms",
	ArrowOnAttenuation	= "Show DBM Arrow during $spell:127834 to indicate which direction to move",
	specwarnAttenuationL	= "Show special warning when left Attenuation",
	specwarnAttenuationR	= "Show special warning when right Attenuation",
	specwarnExhale		= "Show special warning for $spell:122761",
	specwarnExhaleB		= "Show special warning for pre $spell:122761",
	specwarnDR			= "Show special warning for Damage reduction skills",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740),
	SoundWOP			= "Voice warning: important skills",
	HudMAP				= "HudMAP: $spell:122761 targeting",
	HudMAP2				= "HudMAP: $spell:122740",
	optarrowRTI			= "showing arrow pointing to the following tag game player when Set zone appears",
	none				= "none",
	arrow1				= "Star",
	arrow2				= "Circle",
	arrow3				= "Diamond",
	arrow4				= "Triangle",
	arrow5				= "moon",
	arrow6				= "Square",
	arrow7				= "Fork",
	optDR				= "P1 Damage reduction skills",
	noDR				= "none",
	DR1					= "P1 first",
	DR2					= "P1 second",
	DR3					= "P1 third",
	DR4					= "P1 fourth",
	DR5					= "P1 fifth",
	optDRT				= "P2 Damage reduction skills",
	noDRT				= "none",
	DRT1				= "P2 first",
	DRT2				= "P2 second",
	DRT3				= "P2 third",
	DRT4				= "P2 fourth",
	DRT5				= "P2 fifth"
})

L:SetMiscLocalization({
	Platform			= "flies to one of his platforms!",
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."
})

L:SetWarningLocalization({
	specwarnPlatform	= "Combat zone changed",
	specwarnAttenuationL	= "LEFT!",
	specwarnAttenuationR	= "RIGHT!",
	specwarnExhale		= "Exhale[%d] : %s",
	specwarnDR			= ">>Damage reduction skill!<<",
	specwarnExhaleB		= "Next: >>%d<< Exhale"
})

------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetWarningLocalization({
	SpecWarnOverwhelmingAssaultOther 		= "%s - (%d)",
	SpecWarnJSA								= ">>Damage reduction skill!<<"
})

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Show DBM Arrow when someone is affected by $spell:122949",
	RangeFrame			= "Show range frame (8) for $spell:123175",
	InfoFrame			= "InfoFrame:$spell:123474",
	SpecWarnOverwhelmingAssaultOther = "Special warning: $spell:123474",
	HudMAP				= "HUDMAP:$spell:122949",
	SoundWOP			= "Voice warning: important skills",
	SpecWarnJSA			= "Special Warning: Defensive Cooldowns",
	unseenjs1			= "Defensive Warning: Unseen Strike1",
	unseenjs2			= "Defensive Warning: Unseen Strike2",
	unseenjs3			= "Defensive Warning: Unseen Strike3",
	unseenjs4			= "Defensive Warning: Unseen Strike4",
	unseenjs5			= "Defensive Warning: Unseen Strike5",
	unseenjs6			= "Defensive Warning: Unseen Strike6",
	unseenjs7			= "Defensive Warning: Unseen Strike7",
	unseenjs8			= "Defensive Warning: Unseen Strike8",
	unseenjs9			= "Defensive Warning: Unseen Strike9"
})

-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "Move out of purple ring!",
	specWarnPungencyOtherFix 		= "%s - (%d)",
	specwarnCrushH	= "Crush (%d)",
	SpecWarnJSA		= "Crush in 5 >>Defensive<<",
	specWarnFLM		= ">%s< Pheromones, Get ready to take over!"
})

L:SetOptionLocalization({
	specwarnUnder	= "Show special warning when you are under boss",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835),
	InfoFrame			= "InfoFrame:$spell:123081",
	optTankMode			= "Special warning:how to change tank",
	specwarnCrushH		= "Special Warning: No. of Crush",
	two					= "2 tanks (30 stacks)",
	three				= "3 tanks (20 stacks)",
	SoundWOP			= "Voice warning: important skills",
	SoundZN				= "Voice Warning: Crush count down(Heroic only)",
	specWarnPungencyOtherFix = "Special warning: $spell:123081",
	HudMAP				= "HUDMAP: $spell:122835",
	SoundFS				= "Countdown: $spell:122735",
	SpecWarnJSA			= "Special Warning: Defensive",
	specWarnFLM			= "Special Warning: Get ready to take over Pheromones",
	optFLM				= "Pheromones Notice: Type in the player name ahead of you",
	unseenjs1			= "Defensive Warning: Crush1",
	unseenjs2			= "Defensive Warning: Crush2",
	unseenjs3			= "Defensive Warning: Crush3",
	unseenjs4			= "Defensive Warning: Crush4",
	unseenjs5			= "Defensive Warning: Crush5",
	unseenjs6			= "Defensive Warning: Crush6",
	unseenjs7			= "Defensive Warning: Crush7",
	unseenjs8			= "Defensive Warning: Crush8",
	unseenjs9			= "Defensive Warning: Crush9"
})

L:SetMiscLocalization({
	UnderHim	= "under him",
	Heroicrush	= "his opponents",
	Ptwostart	= "armor plating begins to crack"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetWarningLocalization({
	specWarnQuickeningX = "%s - Dispel!",
	specWarnBH			= "Protect: >> %s <<"
})

L:SetOptionLocalization({
	SoundWOP			= "voice warning: important skills",
	SoundDS				= "voice warning: $spell:122149 spread",
	InfoFrame			= "Info Frame: $spell:122149 stacks monitor",
	optQS				= "Dispel Chain for $spell:122149",
	noQS				= "No",
	QS1					= "No. 1",
	QS2					= "No. 2",
	QS3					= "No. 3",
	allQS				= "Always",
	specWarnBH			= "Special Warning: Kor'thik Strike protection",
	optBH				= "Kor'thik Strike protection chain",
	noBH				= "No",
	BH1					= "No. 1",
	BH2					= "No. 2",
	BH3					= "No. 3",
	BH4					= "No. 4",
	allBH				= "Always",
	SoundJR				= "voice warning: Help others",
	APArrow				= "DBM arrow: $spell:121881",
	NearAP				= "voice warning: only warn within 20 yards of $spell:121881",
	ReapetAP			= "special warning: if your $spell:121881 without breaking in 5 seconds then keeping yell",
	HudMAP				= "HUDMAP:$spell:121885",
	optHud				= "HUDMAP:Windbomb",
	auto				= "auto",
	always				= "always",
	none				= "none",
	RangeFrame			= "RangeFrame(3):$spell:121881",
	specWarnQuickeningX	= "Special Warning: When need dispel/steal $spell:122149",
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Helpme				= ">_<",
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s on >%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1: Interrupt/debuff target, 2: Interrupt yourself, 3: Regen Health/Willpower, 4: Escape Vehicle",
	warnAmberExplosion			= ">%s< is casting %s",
	warnInterruptsAvailable		= "Interupts available for %s: >%s<",
	specwarnHupo				= "Construct(%d): %s",
	warnWillPower				= "Current Will Power: %s",
	specwarnOOYou				= ">>OOZES Taget You<<",
	specwarnOOYouD				= ">>OOZES DIED!<<",
	specwarnWillPower			= "Low Will Power! - 5s remaining",
	specwarnAmberExplosionYou	= "Interrupt YOUR %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrupt %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrupt %s!"--Amber Montrosity
})

L:SetTimerLocalization({
	timerAmberExplosionAMCD		= "%s CD: Monstrosity"
})

L:SetOptionLocalization({
	SoundWOP					= "voice warning: important skills",
	SoundADD					= "Voice Warning: Living Ambers on you",
	warnReshapeLife				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(122784, GetSpellInfo(122784)),
	warnReshapeLifeTutor		= "Display ability purpose rundown of Mutated Construct abilities",
	warnAmberExplosion			= "Show warning (with source) when $spell:122398 is cast",
	warnInterruptsAvailable		= "Announce who has Amber Strike interrupts available for\n $spell:122402",
	warnWillPower				= "Announce current will power at 75, 50, 25, 10, and 5.",
	specwarnHupo				= "Special Warning: Reshape Life",
	specwarnOOYou				= "Special Warning: Living Amber on you",
	specwarnOOYouD				= "Special Warning: Your Living Amber is dead",
	specwarnWillPower			= "Show special warning when will power is low in construct",
	specwarnAmberExplosionYou	= "Show special warning to interrupt your own $spell:122398",
	specwarnAmberExplosionAM	= "Show special warning to interrupt Amber Montrosity's\n $spell:122402",
	specwarnAmberExplosionOther	= "Show special warning to interrupt loose Mutated Construct's\n $spell:122398",
	timerAmberExplosionAMCD		= "Show timer for Amber Monstrosity's next $spell:122402",
	AdvInfoFrame				= "Show info frame for players will power and boss $spell:123059",
	FixNameplates				= "Automatically disable interfering nameplates while a construct\n(restores settings upon leaving combat)",
	optInfoFrame				= "<Power and Destabilize> Monitor",
	noIF						= "No",
	IF1							= "Watch power mainly(DPS)",
	IF2							= "Watch Destabilize mainly(TANK)"
})

L:SetMiscLocalization({
	WillPower					= "Will Power"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "Amber Trap progress: (%d/5)",
	warnDr				= "%s: %s (%d/s)",
	specWarnjs			= ">>DR:%s<<",
	specWarnTT			= "Thriller Totem <%d> <%d.s>"
})

L:SetOptionLocalization({
	warnAmberTrap		= "Show warning (with progress) when $spell:125826 is making", -- maybe bad translation.
	InfoFrame		= "Show info frame for players affected by $spell:125390",
	RangeFrame		= "Show range frame (5) for $spell:123735",
	SoundWOP		= "voice warning: important skills",
	SoundYB				= "Voice Warning: Count down for Dissonance Field",
	HudMAP			= "HUDMAP: $spell:124863",
	HudMAPOther			= "HUD MAP: Others' $spell:124863",
	HudMAP2				= "HUD MAP: $spell:124821 position",
	RangeFrame			= "Range Frame(5 yards): $spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097),
	specWarnTT			= "Special Warning: Prepare Tremor Totem",
	SendPos				= "Admin: Assign $spell:124863 positioning(RL only)",
	AcceptPos			= "Client: Receive and show $spell:124863 positioning(Need RL turn on Admin function)",
	optDR				= "Tremor Totem(123311231223-loop)",
	DR1					= "Shaman A",
	DR2					= "Shaman B",
	DR3					= "Shaman C",
	noDR				= "No",
	warnDr				= "Warning: Defensive",
	specWarnjs			= "Special Warning: Defensive",
	optjs				= "Special defensive module",
	optjs2				= "Special defensive module(- -)",
	non					= "No",
	non2				= "No",
	shaman1				= "Shaman A",
	shaman2				= "Shaman B",
	pal1				= "Pally A",
	pal2				= "Pally B",
	pal3				= "Pally C",
	dk					= "DK",
	warrior1			= "Warrior A",
	warrior2			= "Warrior B",
	druid				= "Druid",
	priest1				= "Priest A",
	priest2				= "Priest B",
	priest3				= "Priest C",
	priest4				= "Priest D"
})

L:SetMiscLocalization({
	PlayerDebuffs		= "Fixated",
	YellPhase3			= "No more excuses, Empress! Eliminate these cretins or I will kill you myself!"
})



-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name =	"Heart of Fear Trash"
})

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Show DBM Arrow when someone is affected by $spell:122949"
})
