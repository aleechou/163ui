if GetLocale() ~= "deDE" then return end
local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization(156)

L:SetOptionLocalization({
	ShowDrakeHealth		= "Zeige die Gesundheit befreiter Drachen (benötigt aktivierte Lebensanzeige)"
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization(157)

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "Warne auch bei aktivem $spell:86788 vor $spell:86369",
	TwilightBlastArrow		= "Zeige DBM-Pfeil, falls $spell:86369 in deiner Nähe ist",
	RangeFrame				= "Zeige Abstandsfenster (10m)",
	BlackoutShieldFrame		= "Zeige Lebensanzeige mit einem Balken für $spell:86788"
})

L:SetMiscLocalization({
	Trigger1				= "Tiefer Atem",
	BlackoutTarget			= "Blackout: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow			= "%s unter 30%% - nächste Phase bald!",
	SpecWarnGrounded		= "Hole Geerdet",
	SpecWarnSearingWinds	= "Hole Wirbelnde Winde"
})

L:SetTimerLocalization({
	timerTransition			= "Phasenübergang"
})

L:SetOptionLocalization({
	specWarnBossLow			= "Spezialwarnung, wenn Bosse unter 30% Lebenspunkten sind",
	SpecWarnGrounded		= "Spezialwarnung, falls dir der $spell:83581 Buff fehlt<br/>(~10 Sekunden vor dem Wirken von $spell:83067)",
	SpecWarnSearingWinds	= "Spezialwarnung, falls dir der $spell:83500 Buff fehlt<br/>(~10 Sekunden vor dem Wirken von $spell:83565)",
	timerTransition			= "Dauer des Phasenübergangs anzeigen",
	RangeFrame				= "Zeige Abstandsfenster automatisch bei Bedarf",
	yellScrewed				= "Schreie, wenn du gleichzeitig von $spell:83099 und $spell:92307 betroffen bist",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:83581 bzw. $spell:83500"
})

L:SetMiscLocalization({
	Quake			= "Der Boden unter Euch grollt unheilvoll...",
	Thundershock	= "Die Luft beginnt, vor Energie zu knistern...",
	Switch			= "Genug der Spielereien!",--"Wir kümmern uns um sie!" comes 3 seconds after this one
	Phase3			= "Beeindruckende Leistung…",--"SCHMECKT DIE VERDAMMNIS!" is about 13 seconds after; its indeed this special UTF-8 char at end, not "..." (logfiles 5.1.0.16309)
	Kill			= "Unmöglich…", -- its indeed this special UTF-8 char at end, not "..." (logfiles 5.1.0.16309)
	blizzHatesMe	= "Leuchtfeuer & Ableiter auf mir! Aus dem Weg!",
	WrongDebuff		= "Kein %s"
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization(167)

L:SetOptionLocalization({
	CorruptingCrashArrow	= "Zeige DBM-Pfeil, falls $spell:81685 nahe bei dir ist",
	InfoFrame				= "Zeige Infofenster für $journal:3165",
	RangeFrame				= "Zeige Abstandsfenster (5m) für $journal:3165",
	SetIconOnCreature		= "Setze Zeichen auf Verfinsterte Geschöpfe"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization(168)

L:SetWarningLocalization({
	WarnOrbSoon			= "Schattenkugeln in %d Sekunden!",
	SpecWarnOrbs		= "Schattenkugeln kommen! Aufpassen!",
	warnWrackJump		= "%s gesprungen auf >%s<",
	warnAggro			= "Spieler mit Aggro (Schattenkugeln-Kandidaten): >%s<",
	SpecWarnAggroOnYou	= "Du hast Aggro! Auf Schattenkugeln achten!"
})

L:SetTimerLocalization({
	TimerEggWeakening	= "Zwielichtpanzer zerfällt",   -- ( 4sec timer)
	TimerEggWeaken		= "Zwielichtpanzer Erneuerung", -- (30sec timer)
	TimerOrbs			= "Nächste Schattenkugeln"
})

L:SetOptionLocalization({
	WarnOrbSoon			= "Zeige Vorwarnung für Schattenkugeln (5s zuvor, sekündlich)<br/>(voraussichtlich, kann ungenau sein, kann spammen)",
	warnWrackJump		= "Verkünde Sprungziele von $spell:89421",
	warnAggro			= "Verkünde Spieler mit Aggro, wenn Schattenkugeln erscheinen<br/>(mögliches Ziel der Schattenkugeln)",
	SpecWarnAggroOnYou	= "Spezialwarnung, falls du Aggro hast, wenn Schattenkugeln erscheinen (mögliches Ziel der Schattenkugeln)",
	SpecWarnOrbs		= "Spezialwarnung, wenn Schattenkugeln erscheinen (voraussichtlich)",
	TimerEggWeakening	= "Zeige Timer, wenn $spell:87654 zerfällt",
	TimerEggWeaken		= "Dauer der Erneuerung des $spell:87654 anzeigen",
	TimerOrbs			= "Zeige Zeit bis nächste Schattenkugeln erscheinen<br/>(voraussichtlich, kann ungenau sein)",
	SetIconOnOrbs		= "Setze Zeichen auf Spieler mit Aggro, wenn Schattenkugeln erscheinen<br/>(mögliches Ziel der Schattenkugeln)",
	OrbsCountdown		= "Spiele akustischen Countdown für Schattenkugeln",
	InfoFrame			= "Zeige Infofenster für Spieler mit Aggro"
})

L:SetMiscLocalization({
	YellDragon			= "Fresst, Kinder! Nährt Euch an ihrem Fleisch!",
	YellEgg				= "Ihr denkt, ich sei schwach? Narren!",
	HasAggro			= "Hat Aggro"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"Trash der Bastion des Zwielichts"
})
