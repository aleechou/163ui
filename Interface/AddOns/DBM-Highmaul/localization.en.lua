local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

L:SetTimerLocalization({
	timerSweeperCD			= DBM_CORE_AUTO_TIMER_TEXTS.next:format((GetSpellInfo(177776)))
})

L:SetOptionLocalization({
	timerSweeperCD			= DBM_CORE_AUTO_TIMER_OPTIONS.next:format(177776),
	countdownSweeper		= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(177776)
})

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "RISE, MOUNTAINS!"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "Play countdown sound for Phemos' cooldowns",
	PolSpecial		= "Play countdown sound for Pol's cooldowns",
	PhemosSpecialVoice	= "Play spoken alerts for Phemos' abilities using selected voice pack",
	PolSpecialVoice		= "Play spoken alerts for Pol's abilities using selected voice pack"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)

L:SetMiscLocalization({
	supressionTarget1	= "I will crush you!",
	supressionTarget2	= "Silence!",
	supressionTarget3	= "Quiet!",
	supressionTarget4	= "I will tear you in half!"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetOptionLocalization({
	--Auto generated, don't copy to non english files, not needed.
	warnBranded						= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack:format(156225),
	warnResonance					= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(156467),
	warnMarkOfChaos					= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(158605),
	warnForceNova					= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(157349),
	warnAberration					= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(156471)
	--Auto generated, don't copy to non english files, not needed.
})

L:SetMiscLocalization({
	BrandedYell			= "Branded (%s) on %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Highmaul Trash"
})
