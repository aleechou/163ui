﻿if GetLocale() ~= "deDE" then return end
local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "Hurrikan/Zephyr/Graupelsturm aktiv",
	specWarnSpecial		= "Spezialfähigkeiten aktiv!",
	warnSpecialSoon		= "Spezialfähigkeiten in 10 Sekunden!"
})

L:SetTimerLocalization({
	timerSpecial		= "Spezialfähigkeiten CD",
	timerSpecialActive	= "Spezialfähigkeiten aktiv"
})

L:SetOptionLocalization({
	warnSpecial			= "Zeige Warnung, wenn Hurrikan/Zephyr/Graupelsturm gewirkt werden",
	specWarnSpecial		= "Spezialwarnung, wenn Spezialfähigkeiten gewirkt werden",
	timerSpecial		= "Zeige Abklingzeit für Spezialfähigkeiten",
	timerSpecialActive	= "Dauer der Spezialfähigkeiten anzeigen",
	warnSpecialSoon		= "Zeige Vorwarnung 10 Sekunden vor den Spezialfähigkeiten",
	OnlyWarnforMyTarget	= "Zeige Warnungen und Timer nur für aktuelles Ziel und Fokusziel<br/>(Versteckt den Rest. Dies beinhaltet den PULL!)"
})

L:SetMiscLocalization({
	gatherstrength	= "%s beinnt von den verbliebenen Windlords Stärke zu beziehen!" --yes the typo is from the logfiles (4.06a) "<356.9> RAID_BOSS_EMOTE#%s beinnt von den verbliebenen Windlords Stärke zu beziehen!#Rohash#####0#0##0#1616##0#false#false", -- [6]
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetTimerLocalization({
	TimerFeedback 	= "Rückkopplung (%d)"
})

L:SetOptionLocalization({
	TimerFeedback	= "Dauer von $spell:87904 anzeigen",
	RangeFrame		= "Zeige Abstandsfenster (20m), wenn du von $spell:89668 betroffen bist"
})
