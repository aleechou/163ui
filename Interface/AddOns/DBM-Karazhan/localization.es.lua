if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "Attumen el Montero"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_ATH_YELL_1		= "¡Ven, Medianoche, vamos a dispersar a estos pusilánimes!",
	KillAttumen			= "Siempre lo supe... algún día sería yo la presa."
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "Moroes"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "Desvanecerse finalizado"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Mostrar aviso para final de Desvanecerse"
}

L:SetMiscLocalization{
	DBM_MOROES_YELL_START	= "Mm, visita inesperada. Hay que hacer los preparativos..."
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "Doncella de la Virtud"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	RangeFrame			= "Mostrar distancia (10 yardas)"
}

L:SetMiscLocalization{
}


-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization{
	name = "Romulo y Julianne"
}

L:SetWarningLocalization{
	warningPosion	= "%s en >%s< (%d)",		-- Mortal Wound on >args.destName< (args.amount)
}

L:SetTimerLocalization{
	TimerCombatStart	= "Empieza el combate"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Mostrar tiempo para inicio del combate",
	warningPosion	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(30830)
}

L:SetMiscLocalization{
	Event				= "Tonight... we explore a tale of forbidden love!",--translate
	RJ_Pull				= "What devil art thou, that dost torment me thus?",--translate
	DBM_RJ_PHASE2_YELL	= "Come, gentle night; and give me back my Romulo!",--translate
	Romulo				= "Romulo",
	Julianne			= "Julianne"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "El Lobo Feroz"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	RRHIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(30753)
}

L:SetMiscLocalization{
	DBM_BBW_YELL_1			= "The better to own you with!"--translate
}


-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization{
	name = "Curator"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	RangeFrame			= "Mostrar distancia (10 yardas)"
}

L:SetMiscLocalization{
	DBM_CURA_YELL_PULL		= "La Galeria es solo para los invitados.",--translate
	DBM_CURA_YELL_OOM		= "No se puede procesar tu solicitud."--translate
}


-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "Terestian Pezuña Enferma"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_TI_YELL_PULL		= "Ah, you're just in time. The rituals are about to begin!",--translate
	Kilrek					= "Kil'rek",--translate
	DChains					= "Demon Chains"--translate
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "Sombra de Aran"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "¡No te muevas!"
}

L:SetTimerLocalization{
	timerSpecial			= "CD de habilidad especial"
}

L:SetOptionLocalization{
	timerSpecial			= "Mostrar tiempo de cooldown de habilidad especial",
	DBM_ARAN_DO_NOT_MOVE	= "Mostrar aviso especial para $spell:30004",
	ElementalIcons			= "Poner iconos en $spell:37053",
	WreathIcons				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(29946)
}

L:SetMiscLocalization{
}


--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization{
	name = "Rencor abisal"
}

L:SetWarningLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "Fase de portal en 5 seg",
	DBM_NS_WARN_BANISH_SOON	= "Fase Desterrar en 5 seg",
	warningPortal			= "Fase de portal",
	warningBanish			= "Fase de desterrar"
}

L:SetTimerLocalization{
	timerPortalPhase	= "Fase de portal",
	timerBanishPhase	= "Fase de desterrar"
}

L:SetOptionLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "Mostrar pre-aviso para Fase de portal",
	DBM_NS_WARN_BANISH_SOON	= "Mostrar pre-aviso para Fase de desterrar",
	warningPortal			= "Mostrar aviso para Fase de portal",
	warningBanish			= "Mostrar aviso para Fase de desterrar",
	timerPortalPhase		= "Mostrar tiempo de duración de Fase de portal",
	timerBanishPhase		= "Mostrar tiempo de duración de Fase de desterrar"
}

L:SetMiscLocalization{
	DBM_NS_EMOTE_PHASE_2	= "%s goes into a nether-fed rage!",--translate
	DBM_NS_EMOTE_PHASE_1	= "%s cries out in withdrawal, opening gates to the nether."--translate
}


--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization{
	name = "Príncipe Malchezaar"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_PRINCE_YELL_PULL	= "Madness has brought you here to me. I shall be your undoing!",--translate
	DBM_PRINCE_YELL_P2		= "Simple fools! Time is the fire in which you'll burn!",--translate
	DBM_PRINCE_YELL_P3		= "How can you hope to stand against such overwhelming power?",--translate
	DBM_PRINCE_YELL_INF1	= "All realities, all dimensions are open to me!",--translate
	DBM_PRINCE_YELL_INF2	= "You face not Malchezaar alone, but the legions I command!"--translate
}


-- Nightbane
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization{
	name = "Nocturno"
}

L:SetWarningLocalization{
	DBM_NB_DOWN_WARN 		= "Aterriza en 15 seg",
	DBM_NB_DOWN_WARN2 		= "Aterriza en 5 seg",
	DBM_NB_AIR_WARN			= "Fase aerea"
}

L:SetTimerLocalization{
	timerNightbane			= "Nocturno viene",
	timerAirPhase			= "Fase aerea"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Mostrar aviso para fase aerea",
	PrewarnGroundPhase		= "Mostrar pre-aviso para fase terrestre",
	timerNightbane			= "Mostrar tiempo de invocación de Nocturno",
	timerAirPhase			= "Mostrar tiempo de duración de fase aerea"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL		= "An ancient being awakens in the distance...",--translate
	DBM_NB_YELL_PULL		= "What fools! I shall bring a quick end to your suffering!",--translate
	DBM_NB_YELL_AIR			= "Miserable vermin. I shall exterminate you from the air!",--translate
	DBM_NB_YELL_GROUND		= "Enough! I shall land and crush you myself!",--translate
	DBM_NB_YELL_GROUND2		= "Insects! Let me show you my strength up close!"--translate
}


-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "Mago de Oz"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	AnnounceBosses			= "Mostrar aviso cuando salgan los bosses",
	ShowBossTimers			= "Mostrar tiempo para que salgan los bosses",
	DBM_OZ_OPTION_1			= "Mostrar distancia en fase 2"
}

L:SetMiscLocalization{
	DBM_OZ_WARN_TITO		= "Tito",
	DBM_OZ_WARN_ROAR		= "Rugido",
	DBM_OZ_WARN_STRAWMAN	= "Espantapájaros",
	DBM_OZ_WARN_TINHEAD		= "Cabezalata",
	DBM_OZ_WARN_CRONE		= "La Vieja Bruja",
	DBM_OZ_YELL_DOROTHEE	= "¡Oh, Tito, solo tenemos que buscar la manera de volver a casa! ¡El viejo zahorí puede ser nuestra única esperanza! Espantapájaros, Rugido, Cabezalata, podeis -esperad... ¡Oh, caray, mirad tenemos visita!",
	DBM_OZ_YELL_ROAR		= "¡No os tengo miedo! ¿Queréis pelea? ¿Eh? ¡Vamos, con las garras a la espalda os reto!",
	DBM_OZ_YELL_STRAWMAN	= "¿Ahora que tengo que hacer contigo? No me puedo decidir.",
	DBM_OZ_YELL_TINHEAD		= "¿Me vendría bien un corazón? Digamos, ¿el tuyo?",
	DBM_OZ_YELL_CRONE		= "¡Pronto acabará todo!"
}


-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "Shadikith el Planeador"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "Hyakiss el Rondador"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "Rokad el Devastador"
}
