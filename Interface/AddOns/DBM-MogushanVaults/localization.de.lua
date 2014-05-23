﻿if GetLocale() ~= "deDE" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s bald!",
	specWarnBreakJasperChains	= "Sprenge Jaspisketten!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Spezialwarnung bevor eine Überladung gewirkt werden kann",
	specWarnBreakJasperChains	= "Spezialwarnung, wenn es sicher ist die $spell:130395 zu sprengen",
	ArrowOnJasperChains			= "Zeige DBM-Pfeil, wenn du von $spell:130395 betroffen bist",
	InfoFrame					= "Zeige Infofenster für Bossenergie, Spielerversteinerung und welcher Boss Versteinerung wirkt"
})

L:SetMiscLocalization({
	Overload	= "%s überlädt sich gleich!"
})

------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	specWarnBarrierNow	= "JETZT Nullifikationsbarriere benutzen!"
})

L:SetOptionLocalization({
	WarnPhase			= "Verkünde Phasenwechsel",
	specWarnBarrierNow	= "Spezialwarnung, wenn von dir erwartet wird $spell:115817 zu benutzen (nur bei Schlachtzugsbrowserkämpfen)",
	RangeFrame	= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. " während Arkanphase"
})

L:SetMiscLocalization({
	Fire		= "Oh, Erhabener! Durch mich sollt Ihr das Fleisch von den Knochen schmelzen!",
	Arcane		= "Oh, Weiser der Zeitalter! Vertraut mir Euer arkanes Wissen an!",
	Nature		= "Oh, großer Geist! Gewährt mir die Macht der Erde!",
	Shadow		= "Große Seele vergangener Helden! Gewährt mir Euren Schild!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull		= "Jetzt is' Sterbenszeit!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "Schild der Dunkelheit in %d Sekunden"
})

L:SetTimerLocalization({
	timerUSRevive		= "Unsterblicher Schatten Neuformung",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "Zeige Vorwarnungscountdown für $spell:117697 (5s zuvor)",
	timerUSRevive		= "Zeige Zeit bis sich $spell:117506 neu formen"
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Der Boden verschwindet in 6 Sekunden!"
})

L:SetTimerLocalization({
	timerDespawnFloor		= "Boden verschwindet"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Spezialwarnung bevor der Boden (Energievortex) verschwindet",
	timerDespawnFloor		= "Zeige Zeit bis der Boden (Energievortex) verschwindet"
})

------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Zeige Infofenster für Spieler, welche von $spell:116525 betroffen sind",
	CountOutCombo	= "Zähle akustisch die Anzahl der $journal:5673 Wirkungen<br/>HINWEIS: Dafür ist derzeit nur die weibliche Stimme verfügbar.",
	ArrowOnCombo	= "Zeige DBM-Pfeil während $journal:5673  HINWEIS: Nimmt an,<br/>dass sich der Tank vor dem Boss befindet und alle anderen dahinter."
})

L:SetMiscLocalization({
	Pull		= "Die Maschine brummt und erwacht zu Leben! Geht zur unteren Ebene!",
	Rage		= "Der Zorn des Kaisers schallt durch die Berge.",
	Strength	= "Die Stärke des Kaisers erscheint in den Erkern!",
	Courage		= "Der Mut des Kaisers erscheint in den Erkern!",
	Boss		= "In den riesigen Erkern erscheinen zwei Titanenkonstrukte!"
})
