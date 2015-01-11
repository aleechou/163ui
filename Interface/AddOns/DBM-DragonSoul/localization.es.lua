﻿if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom imita %s"
})

L:SetOptionLocalization({
	KohcromWarning	= "Mostrar avisos para las habilidades que Kohcrom imita.",
	KohcromCD		= "Mostrar tiempos para las siguientes habilidades imitadas de Kohcrom.",
	RangeFrame		= "Mostrar distancia (5) para logro."
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
	ShadowYell			= "Gritar cuando te afecte $spell:104600<br/>(Solo dificultad Heroica)",
	CustomRangeFrame	= "Opciones de marco de distancia",
	Never				= "Deshabilitado",
	Normal				= "Distancia normal",
	DynamicPhase2		= "Filtrar por debuff en Fase 2",
	DynamicAlways		= "Siempre filtrar por debuff"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s absorbió %s"
})

L:SetTimerLocalization({
	timerOozesActive	= "Mocos atacables",
	timerOozesReach		= "Mocos llegan al boss"
})

L:SetOptionLocalization({
	warnOozesHit		= "Anunciar los mocos que absorbió el Boss",
	timerOozesActive	= "Mostrar tiempo para que los mocos se pueden atacar",
	timerOozesReach		= "Mostrar tiempo para que los mocos lleguen a Yor'sahj",
	RangeFrame			= "Mostrar distancia (4) para $spell:104898<br/>(Dificultad normal o superior)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242negra|r",
	Purple			= "|cFF9932CDmorada|r",
	Red				= "|cFFFF0404roja|r",
	Green			= "|cFF088A08verde|r",
	Blue			= "|cFF0080FFazul|r",
	Yellow			= "|cFFFFA901amarilla|r"
})


-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: %d restantes",
	warnFrostTombCast		= "%s en 8 seg"
})

L:SetTimerLocalization({
	TimerSpecial			= "Primer especial"
})

L:SetOptionLocalization({
	WarnPillars				= "Anunciar cuantas $journal:3919 o $journal:4069 quedan",
	TimerSpecial			= "Mostrar tiempo para casteo de la primera habilidad especial",
	RangeFrame				= "Mostrar distancia (3) para $spell:105269, (10) para $journal:4327",
	AnnounceFrostTombIcons	= "Anunciar iconos de los objetivos de $spell:104451 a la banda<br/>(requiere líder)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	SpecialCount			= "Reproducir sonido de cuenta atrás para $spell:105256 o $spell:105465",
	SetBubbles				= "Desactivar los bocadillos de chat automaticamente cuando haya $spell:104451<br/>(se restauran una vez el combate termina)"
})


L:SetMiscLocalization({
	TombIconSet				= "Icono de tumba de hielo {rt%d} en %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d) en 5s"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion activo"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate",
	ResetHoTCounter		= "Reiniciar contador de Hora del crepusculo",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "Nunca",
	ResetDynamic		= "En series de 3/2 (heroico/normal)",
	Reset3Always		= "Siempre reiniciar en series de 3",
	SpecWarnHoTN		= "Mostrar aviso especial 5s antes de Hora del Crepusculo (solo en series de 3)",
	One					= "1 (ej: 1 4 7)",
	Two					= "2 (ej: 2 5)",
	Three				= "3 (ej: 3 6)"
})

L:SetMiscLocalization({
	Pull				= "Percibo que se avecina una gran alteración del equilibrio. ¡Su caos inunda mi mente!"
})


-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "¡Élites Crepusculares!"
})

L:SetTimerLocalization({
	TimerCombatStart	= "Empieza el combate",
	TimerAdd			= "Siguientes Élites"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate",
	TimerAdd			= "Mostrar tiempo para que salgan los siguientes Élites Crepusculares",
	SpecWarnElites		= "Mostrar un aviso especial cuando salgan nuevos Élites Crepusculares",
	SetTextures			= "Deshabilitar automaticamente texturas proyectadas en la fase 1 (Se vuelven a activar en fase 2)"
})

L:SetMiscLocalization({
	SapperEmote			= "¡Un draco desciende para dejar a un zapador Crepuscular en la cubierta!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095",
	GorionaRetreat			= "grita de dolor y se retira al remolino de nubes."
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "¡Ponte a salvo!"
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Mostrar un aviso especial cuando no tengas el debuff de $spell:105563",
	InfoFrame				= "Mostrar información de jugadores sin $spell:105563",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105490),
	ShowShieldInfo			= "Mostrar barra de vida del boss con una barra para $spell:105479"
})

L:SetMiscLocalization({
	Pull		= "¡Las placas! ¡Se está deshaciendo! ¡Destrozad las placas y tendremos una oportunidad de derribarlo!",
	NoDebuff	= "Sin %s",
	PlasmaTarget	= "Plasma ardiente: %s",
	DRoll		= "¡Está a punto de girar",
	DLevels			= "se estabiliza."
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetOptionLocalization({
	RangeFrame			= "Mostrar distancia dinamica basada en el estado del debuff<br/>$spell:108649 en dificultad Heroica",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "No habéis hecho nada. Destruiré vuestro mundo."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"Pulls de Alma del Dragón"
})

L:SetWarningLocalization({
	DrakesLeft			= "Acometedores Crepusculares restantes: %d"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s",--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "Anunciar cuantos Acometedores Crepusculares quedan",
	TimerDrakes			= "Mostrar tiempo para Fuga Crepuscular	de los Asaltantes Crepusculares"
})

L:SetMiscLocalization({
	EoEEvent			= "No sirve de nada, el Alma es demasiado poderosa. No puedo empuñarla de forma segura; la ira que encierra podría ser nuestra perdición.",
	UltraxionTrash		= "Me alegra volver a verte, Alexstrasza. He estado ocupado en mi ausencia.",
	UltraxionTrashEnded	= "Simples crías, experimentos, un medio para un fin mayor. Verás el resultado de las investigaciones de mi nidada."
})