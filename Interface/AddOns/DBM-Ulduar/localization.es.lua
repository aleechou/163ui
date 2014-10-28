﻿if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Leviatán de llamas"
}

L:SetTimerLocalization{
}
	
L:SetMiscLocalization{
	YellPull	= "Entidades hostiles detectadas. Protocolo de evaluación de amenaza activado. Objetivo principal fijado. Tiempo restante para re-evaluación: 30 segundos.",
	Emote		= "%%s persigue a (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn	    = "Persigue a >%s<!",
	warnNextPursueSoon	    = "Cambiara de objetivo en 5 seg",
	SpecialPursueWarnYou	= "¡Te persigue a ti!",
	warnWardofLife			= "Sale un Guarda de Vida"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "Mostrar aviso especial cuando seas $spell:62374.",
	PursueWarn				= "Anunciar los objetivos de $spell:62374",
	warnNextPursueSoon		= "Mostrar cuando va cambiar de objetivo $spell:62374.",
	warnWardofLife			= "Mostrar aviso cuando salga un Guarda de Vida"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis el Maestro de la Caldera"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Tajoescama"
}

L:SetWarningLocalization{	
	warnTurretsReadySoon		= "La torreta estara lista en 20 segundos",
	warnTurretsReady		    = "La torreta esta LISTA"
}
L:SetTimerLocalization{
	timerTurret1			    = "Torreta 1",
	timerTurret2			    = "Torreta 2",
	timerTurret3			    = "Torreta 3",
	timerTurret4			    = "Torreta 4",
	timerGrounded		    = "En el suelo"
}
L:SetOptionLocalization{
	warnTurretsReadySoon		= "Mostrar aviso antes de que las torretas esten listas",
	warnTurretsReady		    = "Mostrar aviso si estan listas las torretas.",
	timerTurret1			    = "Mostrar aviso para Torreta 1",
	timerTurret2			    = "Mostrar aviso para Torreta 2",
	timerTurret3			    = "Mostrar aviso para Torreta 3 ( solo en banda 25 ).",
	timerTurret4			    = "Mostrar aviso para Torreta 4 ( solo en banda 25 ).",
	timerGrounded		    = "Mostrar cuanto durara en el suelo."
}

L:SetMiscLocalization{
	YellAir				        = "Danos un momento para que nos preparemos para construir las torretas.",
	YellAir2			        = "Listos para salir, ¡impedid que esos enanos se peguen a nuestra espalda!!",
	YellGround			    = "¡Moveros! ¡No seguira mucho mas en el suelo!",
	EmotePhase2			        = "¡%%s ha aterrizado permanentemente!",
	FlamecastUnknown		    = DBM_CORE_UNKNOWN
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Desarmador XA-002"
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "La Asamblea de Hierro"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	AlwaysWarnOnOverload			= "Siempre avisar de $spell:63481 (Sino solo se avisara cuando sea objetivo)"
}

L:SetMiscLocalization{
	Steelbreaker		= "Rompeacero",
	RunemasterMolgeim	= "Maestro de runas Molgeim",
	StormcallerBrundir 	= "Clamatormentas Brundir"
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon el Observador"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Siguiente Estrella en colapso",
	TimerCombatStart		= "Empieza el combate"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Cambiar de fase en >%s< - Stack %d",
	WarnPhase2Soon			= "Fase 2 pronto",
	warnStarLow				= "Estrella en colapso a punto de morir"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "Anunciar objetivos de Cambiar de fase",
	NextCollapsingStar		= "Mostrar tiempo para siguiente Estrella en colapso",
	TimerCombatStart		= "Mostrar tiempo para el inicio del combate",
	WarnPhase2Soon			= "Mostrar pre-aviso para Fase 2 (al ~23%)",
	warnStarLow				= "Mostrar aviso especial cuando una Estrella en colapso esté a punto de morir (al ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Vuestros actos carecen de lógica. Se ha calculado cualquier posible resultado de este encuentro. El Panteón recibirá el mensaje del Observador sean cuales sean las consecuencias.",
	YellKill				= "He visto mundos hundirse en las llamas de los Creadores, como se desvanecían sus habitantes sin apenas un gemido. He visto sistemas planetarios enteros crearse y ser arrasados en lo que vuestros mortales corazones laten una sola vez. Y mi corazón permaneció desprovisto de emoción... de empatía. Yo... no... sentí... nada. Millones de vidas malgastadas ¿Acaso compartían vuestra tenacidad? ¿Amaban la vida como vosotros?",
	Emote_CollapsingStar	= "¡%s comienza a invocar estrellas en colapso!",
	Phase2					= "¡Observad las herramientas de la creación!",
	FirstPull				= "Mirad vuestro mundo a través de mis ojos: un universo tan vasto que es inconmensurable, incompresible incluso para vuestras grandes mentes.",
	PullCheck				= "Tiempo hasta que Algalon transmita la señal de auxilio= (%d+) min."
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerLeftArm			= "Reaparición del brazo izquierdo",
	timerRightArm			= "Reaparición del brazo derecho",
	achievementDisarmed		= "Tiempo para desarmar"
}

L:SetOptionLocalization{
	timerLeftArm			= "Mostrar tiempo para Brazo izquierdo",
	timerRightArm			= "Mostrar tiempo para Brazo derecho",
	achievementDisarmed		= "Mostrar tiempo para el logro Desarmar",
	YellOnBeam				= "Gritar cuando tengas $spell:63346"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "¡No es más que un arañazo!",
	Yell_Trigger_arm_right	= "¡No es más que un arañazo!",
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Brazo derecho",
	Health_Left_Arm			= "Brazo izquierdo",
	FocusedEyebeam			= "sus ojos en ti",
	YellBeam				= "¡Haz ocular enfocado en mi!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Defensor feral (%d)",
	YellPull = "¡Es mejor dejar ciertas cosas tal como están!"
}

L:SetTimerLocalization{
	timerDefender	= "Se activa Defensor feral"
}

L:SetWarningLocalization{
	SpecWarnBlast		= "Explosión de centinela - Interrumpe!",
	WarnCatDied 		= "Defensor feral muerto (Le quedan %d vidas)",
	WarnCatDiedOne 		= "Defensor feral muerto (Le queda 1 vida)"
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Mostrar aviso especial para Explosión de centinela",
	WarnCatDied			= "Mostrar aviso cuando Defensor Feral muere",
	WarnCatDiedOne		= "Mostrar aviso cuando Defensor Feral muere",
	timerDefender		= "Mostrar tiempo para activación de Defensor feral"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	YellOnStormCloud		= "Gritar cuando tengas $spell:65133",
	SetIconOnStormCloud		= "Poner iconos en los objetivos de $spell:65133"
}

L:SetMiscLocalization{
	YellKill	= "Estoy... estoy libre de sus garras... al fin.",
	YellCloud	= "Nube tormentosa en mi!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerHardmode	= "Modo heroico"
}

L:SetOptionLocalization{
	TimerHardmode	= "Mostrar tiempo para modo heroico",
	RangeFrame		= "Mostrar distancia",
	AnnounceFails	= "Anunciar los fallos de $spell:62017 en el chat de banda<br/>(require 'anunciar' habilitado y líder o ayudante de banda)"
}

L:SetMiscLocalization{
	YellPhase1	= "¡Intrusos! Vosotros, mortales que osáis interferir en mi diversión, pagareis... Un momento...",
	YellPhase2	= "Gusanos impertinentes, ¿cómo osáis desafiarme en mi pedestal? ¡Os machacaré con mis propias manos!",
	YellKill	= "¡Guardad las armas! ¡Me rindo!",
	ChargeOn	= "Cargar relámpago: %s",
	Charge		= "Fallos de Cargar relámpago (este try): %s" 
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell	= "¡Hijos, ayudadme!",
	WaterSpirit	= "Espíritu de agua antiguo",
	Snaplasher	= "Quiebrazotador",
	StormLasher	= "Azotador de tormenta",
	YellKill	= "Su control sobre mí se disipa. Vuelvo a ver con claridad. Gracias, héroes.",
	TrashRespawnTimer	= "Reaparicion de Adds de Freya"
}

L:SetWarningLocalization{
	WarnSimulKill	= "Primer add muerto - Resurrección en ~12 seg"
}

L:SetTimerLocalization{
	TimerSimulKill		= "Resurrección"
}

L:SetOptionLocalization{
	WarnSimulKill		= "Anunciar primer mob muerto",
	TimerSimulKill		= "Mostrar resureccion de los mobs"
}

----------------------
--  Freya's Elders  --
----------------------

L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Ancestros de Freya"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Reaparicion de Adds de Freya"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	TrashRespawnTimer	= "Mostrar tiempo para reaparición de adds"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	MagneticCore		= ">%s< tiene Núcleo magnético",
	WarningShockBlast	= "¡Explosión de choque! ¡Muévete!",
	WarnBombSpawn		= "Robot bum sale"
}

L:SetTimerLocalization{
	TimerHardmode		= "Modo Difícil - Autodestrucción",
	TimeToPhase2		= "Fase 2",
	TimeToPhase3		= "Fase 3",
	TimeToPhase4		= "Fase 4"
}

L:SetOptionLocalization{
	TimeToPhase2			= "Mostrar tiempo para Fase 2",
	TimeToPhase3			= "Mostrar tiempo para Fase 3",
	TimeToPhase4			= "Mostrar tiempo para Fase 4",
	MagneticCore			= "Anunciar quen lootea Núcleo magnético",
	HealthFramePhase4		= "Mostrar barra de vida en la fase 4",
	AutoChangeLootToFFA		= "Canviar el loot a Botín Libre en la fase 3",
	WarnBombSpawn			= "Mostrar aviso para Robot bum",
	TimerHardmode			= "Mostrar tiempo para Modo Difícil",
	ShockBlastWarningInP1	= "Mostrar aviso especial para $spell:63631 en Fase 1",
	ShockBlastWarningInP4	= "Mostrar aviso especial para $spell:63631 en Fase 4",
	RangeFrame				= "Mostrar distancia en Fase 1 (6 yardas)"
}

L:SetMiscLocalization{
	MobPhase1		= "Mk II de leviatán",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unidad de mando aérea",
	YellPull		= "¡No tenemos mucho tiempo, amigos! Vais a ayudarme a probar mi última y mayor creación. Ahora, antes de que cambiéis de parecer, recordad que en cierta forma, me lo debéis después del desastre que causasteis con el XA-002.",
	YellHardPull	= "Secuencia de autodestrucción iniciada",
	YellPhase2		= "¡Contemplad el cañón de asalto antipersonal VX-001! Puede que queráis poneros a cubierto.",
	YellPhase3		= "¡Gracias amigos! ¡Vuestros esfuerzos me han proporcionado unos datos fantásticos! Veamos, ¿dónde puse?...ah, ahí está.",
	YellPhase4		= "Fase de prueba preliminar completada. ¡Ahora comienza la verdadera prueba!",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Animus de saronita sale"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "¡Fragor de sombra en ti! ¡Muévete!",
	SpecialWarningShadowCrashNear	= "Fragor de sombra cerca de ti!",
	SpecialWarningLLNear			= "Drenar vida en %s cerca de ti"
}

L:SetOptionLocalization{
	SetIconOnShadowCrash			= "Poner iconos en los objetivos de $spell:62660 (calavera)",
	SetIconOnLifeLeach				= "Poner iconos en los objetivos de $spell:63276 (cruz)",
	SpecialWarningShadowCrash		= "Mostrar aviso especial para $spell:62660/n(Tiene que ser el objetivo o el foco de al menos un personaje de la banda)",
	SpecialWarningShadowCrashNear	= "Mostrar aviso especial para $spell:62660 cerca de ti",
	SpecialWarningLLNear			= "Mostrar aviso especial para $spell:63276 cerca de ti",
	YellOnLifeLeech					= "Gritar si tienes $spell:63276",
	YellOnShadowCrash				= "Gritar si eres objetivo de $spell:62660",
	hardmodeSpawn					= "Mostrar tiempo para salida de Animus de saronita (Modo Difícil)",
	CrashArrow						= "Mostrar una flecha cuando $spell:62660 va a caer cerca de ti",
	BypassLatencyCheck				= "No usar la comprobación de sincronización basada en latencia para $spell:62660<br/>(sólo usar esta opción si tienes problemas de otro modo)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "¡Cerca se forma una nube de vapores de saronita!",
	YellLeech			= "¡Drenar vida en mi!",
	YellCrash			= "¡Fragor de sombra en mi!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "¡Pronto llegará la hora de golpear la cabeza del monstruo! ¡Centrad vuestra ira y odio en sus esbirros!",
	YellPhase2	 		= "Soy un sueño lúcido.",
	Sara 				= "Sara",
	WarningYellSqueeze	= "¡Exprimir en mi! ¡Ayudadme!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardián %d sale",
	WarningCrusherTentacleSpawned	= "Tentáculo triturador sale",
	WarningSanity 					= "%d Cordura restante",
	SpecWarnSanity 					= "%d Cordura restante",
	SpecWarnGuardianLow				= "Deja de atacar a este Guardián",
	SpecWarnMadnessOutNow			= "Inducir a la locura terminando. Muévete!",
	WarnBrainPortalSoon				= "Portal cerebral en 3 segundos",
	SpecWarnFervor					= "Fervor de Sara en ti",
	SpecWarnFervorCast				= "Fervor de Sara esta siendo casteado en ti",
	specWarnBrainPortalSoon			= "Portal cerebral pronto"
}

L:SetTimerLocalization{
	NextPortal	= "Portal cerebral"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Mostrar aviso cuando salga Guardián",
	WarningCrusherTentacleSpawned	= "Mostrar aviso cuando salga Tentáculo triturador",
	WarningSanity					= "Mostrar aviso cuando tengas poca $spell:63050",
	SpecWarnSanity					= "Mostrar aviso especial cuando tengas muy poca $spell:63050",
	SpecWarnGuardianLow				= "Mostrar aviso especial cuando el Guardián esté a punto de morir (Fase 1)",
	WarnBrainPortalSoon				= "Mostrar pre-aviso para Portal cerebral",
	SpecWarnMadnessOutNow			= "Mostrar aviso especial poco antes de que $spell:64059 termine",
	SetIconOnFearTarget				= "Poner iconos en los objetivos de $spell:63881",
	SpecWarnFervorCast				= "Mostrar aviso especial cuando $spell:63138 esté siendo casteado en ti/n(Tiene que ser el objetivo o el foco de al menos un personaje de la banda)",
	specWarnBrainPortalSoon			= "Mostrar aviso especial para siguiente Portal cerebral",
	WarningSqueeze					= "Gritar si te afecta Exprimir",
	NextPortal						= "Mostrar tiempo para siguiente Portal cerebral",
	SetIconOnFervorTarget			= "Poner iconos en los objetivos de $spell:63138",
	ShowSaraHealth					= "Mostrar barra de vida de Sara en Fase 1",
	SetIconOnBrainLinkTarget		= "Poner iconos en los objetivos de $spell:63802",
	MaladyArrow						= "Mostrar flecha cuando $spell:63881 está cerca de ti"
}

