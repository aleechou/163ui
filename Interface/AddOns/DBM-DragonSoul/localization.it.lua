if GetLocale() ~= "itIT" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom copia %s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "Visualizza Avvertimenti per le abilita' che $journal:4262 copia.",
	KohcromCD		= "Visualizza un Timer per la prossima copia di abilita' di $journal:4262.",
	RangeFrame		= "Visualizza il Radar di Prossimita' a 5Mt per l'Impresa."
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
	ShadowYell			= "Urla quando sei afflitto da $spell:103434<br/>(Solo in Eroico)",
	CustomRangeFrame	= "Opzioni del Radar di Prossimita' (Solo Eroico)",
	Never				= "Disabilitato",
	Normal				= "Radar di Prossimita' Normale",
	DynamicPhase2		= "Filtra le Penalita' di FASE2",
	DynamicAlways		= "Filtra Sempre le Penalita'"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s ha assorbito %s"
})

L:SetTimerLocalization({
	timerOozesActive	= "Globuli Attaccabili!",
	timerOozesReach		= "Globuli vicini al Boss!"
})

L:SetOptionLocalization({
	warnOozesHit		= "Annuncia quale Globulo colpisce il boss",
	timerOozesActive	= "Visualizza un timer per quando i Globuli diventano Attaccabili",
	timerOozesReach		= "Visualizza un timer per quando i Globuli raggiungeranno Yor'sahj",
	RangeFrame			= "Visualizza il Radar di prossimita'(4mt) per $spell:104898<br/>(difficolta' eroica)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242Nero|r",
	Purple			= "|cFF9932CDViola|r",
	Red				= "|cFFFF0404Rosso|r",
	Green			= "|cFF088A08Verder|r",
	Blue			= "|cFF0080FFBlu|r",
	Yellow			= "|cFFFFA901Giallo|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: %d Rimasto",
	warnFrostTombCast		= "%s tra 8 sec"
})

L:SetTimerLocalization({
	TimerSpecial			= "Prima Abilita' Speciale"
})

L:SetOptionLocalization({
	WarnPillars				= "Annuncia quanti $journal:3919 o $journal:4069 sono rimasti",
	TimerSpecial			= "Visualizza un Timer per il lancio della prima abilita' speciale",
	RangeFrame				= "Visualizza Radar di Prossimita'(3mt) per $spell:105269, (10) per $journal:4327",
	AnnounceFrostTombIcons	= "Elenca in Chat le Icone per i bersagli di $spell:104451 <br/>(Richiede CapoIncursione)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	SpecialCount			= "Fai Conto alla Rovescia per $spell:105256 o $spell:105465",
	SetBubbles				= "Disabilita le vignette della chat automaticamente quando e' disponibile $spell:104451 <br/>(Ripristinale alla fine del combattimento)"
})

L:SetMiscLocalization({
	TombIconSet				= "Tomba di Ghiaccio - Icona {rt%d} su %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d) tra 5s"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion Attivo"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Visualizza Timer per l'ingaggio di Ultraxion",
	ResetHoTCounter		= "Riavvia il contatore per Ora del Crepuscolo",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "Mai",
	ResetDynamic		= "Riavvia ogni 3/2 (Eroico/Normale)",
	Reset3Always		= "Riavvia sempre ogni 3",
	SpecWarnHoTN		= "Messaggio Speciale 5 sec prima di Ora del Crepuscolo. Se il contatore e' impostasto su MAI, segue la regola del riavvio ogni 3",
	One					= "1 (ie 1 4 7)",
	Two					= "2 (ie 2 5)",
	Three				= "3 (ie 3 6)"
})

L:SetMiscLocalization({
	Pull				= "Sento che si sta avvicinando un grande disturbo nell'Equilibrio. Il caos brucia la mia mente!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "CavalcaDraghi!"
})

L:SetTimerLocalization({
	TimerCombatStart	= "Il Combattimento Inizia",
	TimerAdd			= "Prossimi Cavalcadraghi"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Timer per l'inizio del Combattimento",
	TimerAdd			= "Timer per i prossimi CavalcaDraghi",
	SpecWarnElites		= "Avviso Speciale per i nuovi CavalcaDraghi",
	SetTextures			= "Disabilita la Proiezione delle texture automaticamente in Fase1<br/>(riabilitale in Fase2)"
})

L:SetMiscLocalization({
	SapperEmote			= "Un Drago lascia cadere un Geniere sul ponte!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095",
	GorionaRetreat			= "Urla di Dolore e si rivolta nelle nuvole tempestose"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "Arpionati!"
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Visualizza un messaggio speciale quando non hai $spell:105563",
	InfoFrame				= "Visualizza Finestra Informazioni per i giocatori che non hanno $spell:105563",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105490),
	ShowShieldInfo			= "Usa la Finestra della Vita dei Boss per chi ha $spell:105479"
})

L:SetMiscLocalization({
	Pull			= "Le Placche! Sta Arrivando! Se distrigguiamo le placche avremo una possibilita' di Ucciderlo!",
	NoDebuff		= "No %s",
	PlasmaTarget	= "Plasma Rovente: %s",
	DRoll			= "Sta per effettuare un avvitamento",
	DLevels			= "Fermatelo!!!"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetOptionLocalization({
	RangeFrame			= "Visualizza il radar di prossimita' per i giocatori afflitti da<br/>$spell:108649 in Eroico",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "Non avete NULLA. Spazzero' via il vostro Mondo."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"Dragonsoul Trash"
})

L:SetWarningLocalization({
	DrakesLeft			= "Assaltatori Rimasti: %d"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s"--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "Annuncia quanti Assaltatori rimangono",
	TimerDrakes			= "Visualizza un Timer per $spell:109904 degli Assaltatori"
})

L:SetMiscLocalization({
	EoEEvent			= "Non serve a nulla, il potere dell'Anima del Drago e' troppo grande",--Partial
	UltraxionTrash		= "E' bello rivederti, Alexstrasza. Sono stato occupato in tua assenza.",
	UltraxionTrashEnded = "Inutili Draghi, esperimenti ... Vedrete a cosa mi hanno portato le mie ricerche!"
})