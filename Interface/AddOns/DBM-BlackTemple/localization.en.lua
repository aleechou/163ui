local L

-----------------
--  Najentus  --
-----------------
L = DBM:GetModLocalization("Najentus")

L:SetGeneralLocalization{
	name = "High Warlord Naj'entus"
}

L:SetOptionLocalization{
	InfoFrame	= "Show info frame for health (<8.8k hp)",
	RangeFrame	= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format(8),
	SpineIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(39837)
}

L:SetMiscLocalization{
	HealthInfo	= "Health Info"
}

----------------
-- Supremus --
----------------
L = DBM:GetModLocalization("Supremus")

L:SetGeneralLocalization{
	name = "Supremus"
}

L:SetWarningLocalization{
	WarnPhase		= "%s Phase",
	WarnKite		= "Gaze on >%s<"
}

L:SetTimerLocalization{
	TimerPhase		= "Next %s phase"
}

L:SetOptionLocalization{
	WarnPhase		= "Show warning for next phase",
	WarnKite		= "Announce Kite targets",
	TimerPhase		= "Show time for next phase",
	KiteIcon		= "Set icon on Kite target"
}

L:SetMiscLocalization{
	PhaseKite		= "punches the ground in anger!",
	PhaseTank		= "The ground begins to crack open!",
	ChangeTarget	= "acquires a new target",
	Kite			= "Kite",
	Tank			= "Tank"
}

-------------------------
--  Shape of Akama  --
-------------------------
L = DBM:GetModLocalization("Akama")

L:SetGeneralLocalization{
	name = "Shade of Akama"
}

-------------------------
--  Teron Gorefiend  --
-------------------------
L = DBM:GetModLocalization("TeronGorefiend")

L:SetGeneralLocalization{
	name = "Teron Gorefiend"
}

L:SetTimerLocalization{
	TimerVengefulSpirit		= "Ghost : %s"
}

L:SetOptionLocalization{
	TimerVengefulSpirit		= "Show timer for Ghost durations",
	CrushIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(40243)
}

----------------------------
--  Gurtogg Bloodboil  --
----------------------------
L = DBM:GetModLocalization("Bloodboil")

L:SetGeneralLocalization{
	name = "Gurtogg Bloodboil"
}

--------------------------
--  Essence Of Souls  --
--------------------------
L = DBM:GetModLocalization("Souls")

L:SetGeneralLocalization{
	name = "Essence of Souls"
}

L:SetWarningLocalization{
	WarnMana		= "Zero Mana in 30 sec"
}

L:SetTimerLocalization{
	TimerMana		= "Mana 0"
}

L:SetOptionLocalization{
	WarnMana		= "Show warning from zero mana in Phase 2",
	TimerMana		= "Show timer for zero mana in Phase 2",
	DrainIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(41303),
	SpiteIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(41376)
}

L:SetMiscLocalization{
	Pull			= "Pain and suffering are all that await you!",
	Suffering		= "Essence of Suffering",
	Desire			= "Essence of Desire",
	Anger			= "Essence of Anger"
}

-----------------------
--  Mother Shahraz --
-----------------------
L = DBM:GetModLocalization("Shahraz")

L:SetGeneralLocalization{
	name = "Mother Shahraz"
}

L:SetTimerLocalization{
	timerAura	= "%s"
}

L:SetOptionLocalization{
	timerAura	= "Show timer for Prismatic Aura",
	FAIcons		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(41001)
}

----------------------
--  Illidari Council  --
----------------------
L = DBM:GetModLocalization("Council")

L:SetGeneralLocalization{
	name = "Illidari Council"
}

L:SetWarningLocalization{
	Immune			= "Malande - %s immune for 15 sec"
}

L:SetOptionLocalization{
	Immune			= "Show warning when Manalde becomes spell or melee immune",
	PoisonIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(41485)
}

L:SetMiscLocalization{
	Gathios			= "Gathios the Shatterer",
	Malande			= "Lady Malande",
	Zerevor			= "High Nethermancer Zerevor",
	Veras			= "Veras Darkshadow",
	Melee			= "Melee",
	Spell			= "Spell"
}

-------------------------
--  Illidan Stormrage --
-------------------------
L = DBM:GetModLocalization("Illidan")

L:SetGeneralLocalization{
	name = "Illidan Stormrage"
}

L:SetWarningLocalization{
	WarnHuman		= "Human Phase",
	WarnDemon		= "Demon Phase"
}

L:SetTimerLocalization{
	TimerNextHuman		= "Next Human Phase",
	TimerNextDemon		= "Next Demon Phase",
	TimerPhase4			= "Phase transition"
}

L:SetOptionLocalization{
	WarnHuman		= "Show warning for Human Phase",
	WarnDemon		= "Show warning for Demon Phase",
	TimerNextHuman	= "Show time for Next Human Phase",
	TimerNextDemon	= "Show time for Demon Human Phase",
	TimerPhase4		= "Show time for Phase 4 transition",
	RangeFrame		= "Show range frame (10 yards) in Phase 3 and 4",
	ParasiteIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(41917)
}

L:SetMiscLocalization{
	Pull			= "Akama. Your duplicity is hardly surprising. I should have slaughtered you and your malformed brethren long ago.",
	Eyebeam			= "Stare into the eyes of the Betrayer!",
	Demon			= "Behold the power... of the demon within!",
	Phase4			= "Is this it, mortals? Is this all the fury you can muster?"
}
