local L

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	SetIconOnFixate   = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99559),
	RangeFrame			= "Show range frame (10)"
})

L:SetMiscLocalization({
	EmoteSpinners 	= "Cinderweb Spinners dangle from above!",
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound"
})

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	WarnNewInitiate		= "Blazing Talon Initiate (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Phase %d",
	TimerHatchEggs		= "Next Eggs",
	timerNextInitiate	= "Next Initiate (%s)",
	TimerCombatStart	= "Combat starts"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	TimerCombatStart	= "Show timer for start of combat",
	WarnPhase			= "Show a warning for each phase change",
	WarnNewInitiate		= "Show a warning for new Blazing Talon Initiate",
	timerNextInitiate	= "Show a timer for next Blazing Talon Initiate",
	TimerPhaseChange	= "Show a timer till next phase",
	TimerHatchEggs		= "Show a timer till next eggs are hatched",
	InfoFrame			= "Show info frame for $spell:98734"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",
	YellPhase2		= "These skies are MINE!",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "Fiery Lava Worms erupt from the ground!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	East			= "East",
	West			= "West",
	Both			= "Both"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	InfoFrame			= "Show info frame for spell:99937 stacks",
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99947),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
	warnStrike	= "%s (%d)",
	SpecWarnHealerTouched	= "Healer %s Tormented! Need help and skills!"
})

L:SetTimerLocalization({
	timerStrike			= "Next %s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Next blade"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	SpecWarnHealerTouched	= "Show special warning when healer was tormented",
	ResetShardsinThrees	= "Restart $spell:99259 count in sets of 3s(25m)/2s(10m)",
	warnStrike			= "Show warnings for Decimation/Inferno Strike",
	timerStrike			= "Show timer for next Decimation/Inferno Strike",
	TimerBladeActive	= "Show a duration timer for the active Blade",
	TimerBladeNext		= "Show a next timer for Decimation/Inferno Blade",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99256),
	ArrowOnCountdown	= "Show DBM Arrow when you are affected by $spell:99516 ",
	InfoFrame			= "Show info frame for Vital Spark(healer)/Tormented(others) stacks",
	RangeFrame			= "Show range frame (5) for $spell:99257"
})

L:SetMiscLocalization({
	VitalSpark		= GetSpellInfo(99262).." stacks"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetTimerLocalization({
	timerNextSpecial	= "Next %s (%d)"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	timerNextSpecial			= "Show timer for next special ability",
	RangeFrameSeeds				= "Show range frame (12) for $spell:98450",
	RangeFrameCat				= "Show range frame (10) for $spell:98374",
	LeapArrow					= "Show DBM arrow when $spell:98476 is near you",
	InfoFrame			= "Show info frame for burning orbs stacks",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(98476)
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnRageRagnarosSoon	= "%s on %s in 5 sec",--Spellname on targetname
	warnSplittingBlow		= "%s in %s",--Spellname in Location
	warnEngulfingFlame		= "%s in %s",--Spellname in Location
	warnEmpoweredSulf		= "%s in 5 sec"--The spell has a 5 second channel, but tooltip doesn't reflect it so cannot auto localize
})

L:SetTimerLocalization({
	timerRageRagnaros		= "%s on %s",--Spellname on targetname
	TimerPhaseSons			= "Transition ends"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	SoundBB = "Play Extra Warning Sound for Bubble Carrier",
	warnRageRagnarosSoon		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn:format(101109, GetSpellInfo(101109)),
	warnSplittingBlow	= "Show location warning for $spell:98951",
	warnEngulfingFlame	= "Show warning for $spell:99171",
	warnEmpoweredSulf			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(100604, GetSpellInfo(100604)),
	timerRageRagnaros			= DBM_CORE_AUTO_TIMER_OPTIONS.cast:format(101109, GetSpellInfo(101109)),
	TimerPhaseSons		= "Show a duration timer for the \"Sons of Flame phase\"",
	RangeFrame			= "Show range frame",
	InfoHealthFrame		= "Show info frame for health (<100k hp)",
	MeteorFrame			= "Show info frame for $spell:99849 targets",
	AggroFrame			= "Show info frame for players who have no aggro during $journal:2647",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100460)
})

L:SetMiscLocalization({
	East				= "East",
	West				= "West",
	Middle				= "Middle",
	North				= "Melee",
	South				= "Back",
	HealthInfo			= "Under 100k HP",
	HasNoAggro			= "No Aggro",
	MeteorTargets		= "ZOMG Meteors!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "Enough! I will finish this.",--More reliable then adds method.
	TransitionEnded2	= "Sulfuras will be your end.",
	TransitionEnded3	= "Fall to your knees, mortals!  This ends now.",
	Defeat				= "Too soon! ... You have come too soon...",
	Phase4				= "Too soon..."
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Firelands Trash"
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "Volcanus"
})

L:SetWarningLocalization({
	warnRootsDispel		=	 "Smouldering Roots!Dispel after stomp!"
})

L:SetTimerLocalization({
	timerStaffTransition	= "Transition ends"
})

L:SetOptionLocalization({
	warnRootsDispel		=	 "Show warning for $spell:100146",
	timerStaffTransition	= "Show a timer for the phase transition"
})

L:SetMiscLocalization({
	StaffEvent			= "The Branch of Nordrassil reacts violently to %S+ touch!",--Reg expression pull match
	StaffTrees			= "Burning Treants erupt from the ground to aid the Protector!",--Might add a spec warning for this later.
	StaffTransition		= "The fires consuming the Tormented Protector wink out!"
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "Thyrinar"
})
