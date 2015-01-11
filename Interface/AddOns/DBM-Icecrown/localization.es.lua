if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Tuetano"
}

L:SetTimerLocalization{
	AchievementBoned	= "Tiempo para liberar"
}

L:SetOptionLocalization{
	AchievementBoned		= "Mostrar tiempo para el logro Deshuesado"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Susurramuerte"
}

L:SetTimerLocalization{
	TimerAdds				= "Nuevos Adds"
}

L:SetWarningLocalization{
	WarnReanimating					= "Resurreccion de Add",			-- Reanimating an adherent or fanatic
	WarnAddsSoon					= "Nuevos adds pronto"
}

L:SetOptionLocalization{
	WarnAddsSoon					= "Mostrar un pre-aviso cuando vengan nuevos adds ",
	WarnReanimating					= "Mostrar un aviso cuando un add sea resucitado",											-- Reanimated Adherent/Fanatic spawning
	TimerAdds						= "Mostrar tiempo para nuevos adds",
	ShieldHealthFrame				= "Mostrar barra de vida del boss con una barra de vida para $spell:70842"

}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "¡Álzate y goza de tu verdadera forma!",
	Fanatic1				= "Fanático del Culto",
	Fanatic2				= "Fanático deformado",
	Fanatic3				= "Fanático reanimado"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Batalla de naves de guerra"
}

L:SetWarningLocalization{
	WarnAddsSoon		= "Nuevos adds pronto"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "Mostrar pre-aviso para la salida de nuevos adds",
	TimerAdds			= "Mostrar tiempo para nuevos adds"
}

L:SetTimerLocalization{
	TimerAdds			= "Nuevos adds"
}

L:SetMiscLocalization{
	PullAlliance	= "¡Arrancad motores! ¡Tenemos una cita con el destino, muchachos!",
	KillAlliance	= "¡No digáis que no lo avisé, sinvergüenzas! Adelante, hermanos.",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy! LOK'TAR OGAR!!",--translate
	KillHorde		= "The Alliance falter. Onward to the Lich King!",--translate
	AddsAlliance	= "¡Atracadores, Sargentos, atacad!",
	AddsHorde		= "¡Atracadores, Marinos, atacad!",
	MageAlliance	= "Nos están dañando el casco, ¡traed un mago de batalla aquí para acabar con esos cañones!",
	MageHorde		= "Nos están dañando el casco, ¡traed un hechicero aquí para acabar con esos cañones!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Libramorte Colmillosauro"
}

L:SetOptionLocalization{
	RangeFrame				= "Mostrar distancia (12 yardas)",
	RunePowerFrame			= "Mostrar barra de vida + barra de $spell:72371",
	BeastIcons				= "Poner iconos en las Bestias de Sangre"
}

L:SetMiscLocalization{
	RunePower			= "Poder de sangre",
	PullAlliance		= "Por cada soldado de la Horda que matasteis... Por cada perro de la Alianza que cayó, el ejército del Rey Exánime creció. Ahora, hasta las Val'kyr alzan a los caídos para la Plaga.",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs! The Scourge have been..."--translate
}


-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Panzachancro"
}

L:SetOptionLocalization{
	RangeFrame			= "Mostrar distancia (8 yardas)",
	AnnounceSporeIcons	= "Anunciar los iconos de los objetivos de $spell:69279 en el chat de banda<br/>(Necesitas ser líder de banda)",
	AchievementCheck	= "Anunciar fallo del logro 'Sin vacunas' a la banda<br/>(requiere líder/ayudante)"
}

L:SetMiscLocalization{
	SporeSet	= "Icono {rt%d} de espora de gas en %s",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d marcas de Inoculado <<"
}


---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Caraputrea"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Sale moco pequeño",
	SpecWarnLittleOoze			= "¡Moco pequeño te ataca! ¡Corre!" --creatureid 36897
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "Mostrar aviso cuando salgan mocos pequeños",
	SpecWarnLittleOoze			= "Mostrar aviso especial cuando te ataque un Moco pequeño",--creatureid 36897
	RangeFrame					= "Mostrar distancia (8 yardas)",
	TankArrow					= "Mostrar flecha hacia el tanque del Moco grande (Experimental)"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "¡Buenas noticias, amigos! He arreglado las tuberías de babosas venenosas.",	-- Professor Putricide
	YellSlimePipes2	= "¡Grandes noticias, amigos! Las babosas vuelven a fluir."	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Putricidio"
}

L:SetOptionLocalization{
	MalleableGooIcon			= "Poner icono en el primero objetivo de $spell:72295",
	GooArrow					= "Mostrar flecha cuando $spell:72295 esté cerca de ti"
}

L:SetMiscLocalization{
	YellUnbound		= "¡Peste desatada en mi!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Concilio de los Príncipes de Sangre"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Cambiar objetivo a: %s",	
	WarnTargetSwitchSoon	= "Cambiar de objetivo pronto"
}

L:SetTimerLocalization{
	TimerTargetSwitch	= "Cambio de objetivo"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Mostrar aviso para cambiar de objetivos",
	WarnTargetSwitchSoon	= "Mostrar pre-aviso para cambiar de objetivos",
	TimerTargetSwitch		= "Mostrar tiempo para siguiente cambio de objetivo",
	ActivePrinceIcon		= "Poner un icono en el príncipe con Invocación (Cruz)",
	RangeFrame				= "Mostrar distancia (12 yardas)",
	VortexArrow				= "Mostrar flecha cuando $spell:72037 esté cerca de ti"
}

L:SetMiscLocalization{
	Keleseth	= "Príncipe Keleseth",
	Taldaram	= "Príncipe Taldaram",
	Valanar		= "Príncipe Valanar",
	EmpoweredFlames		= "¡Llamas potenciadas arremeten contra (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Reina de Sangre Lana'thel"
}

L:SetOptionLocalization{
	RangeFrame					= "Mostrar distancia (8 yardas)"
}

L:SetMiscLocalization{
	SwarmingShadows			= "¡Las sombras se acumulan alrededor de (%S+)!",
	YellFrenzy				= "¡Tengo hambre!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Caminasueños"
}

L:SetWarningLocalization{
	WarnPortalOpen	= "Se abren los portales"
}

L:SetTimerLocalization{
	TimerPortalsOpen	= "Se abren los portales",
	TimerBlazingSkeleton	= "Siguiente Esqueleto llameante",
	TimerAbom				= "Siguiente Abominación"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Poner icono en Esqueleto llameante (calavera)",
	WarnPortalOpen				= "Mostrar aviso cuando $spell:72483 se abren",
	TimerPortalsOpen			= "Mostrar tiempo para la apertura de Portal Pesadilla",
	TimerBlazingSkeleton			= "Mostrar tiempo para la próxima salida de Esqueleto llameante",
	TimerAbom					= "Mostrar tiempo para siguiente Abominación glotona (Experimental)"
}

L:SetMiscLocalization{
	YellPull		= "Han entrado intrusos en el Sagrario Interior. Apresuraos en acabar con el dragón verde. ¡Dejad solo huesos y tendones para la reanimación!",
	YellKill		= "¡ESTOY RENOVADA! Ysera, haz que estas asquerosas criaturas descansen.",
	YellPortals		= "He abierto un portal al Sueño. Vuestra salvación está dentro, héroes..."
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Siguiente fase aerea",
	TimerNextGroundphase	= "Siguiente fase en el suelo",
	AchievementMystic		= "Tiempo para limpiar Sacudida Mística"
}

L:SetWarningLocalization{
	WarnAirphase			= "Fase aerea",
	WarnGroundphaseSoon		= "Sindragosa aterriza pronto"
}

L:SetOptionLocalization{
	WarnAirphase			= "Anunciar fase aerea",
	WarnGroundphaseSoon		= "Mostrar pre-aviso para fase en el suelo",
	TimerNextAirphase		= "Mostrar tiempo para siguiente fase aerea",
	TimerNextGroundphase	= "Mostrar tiempo para siguiente fase en el suelo",
	AnnounceFrostBeaconIcons= "Anunciar los iconos de los objetivos de $spell:70126 en el chat de banda<br/>(Necesitas ser líder de banda)",
	ClearIconsOnAirphase	= "Eliminar todos los iconos antes de la fase aerea",
	AchievementCheck		= "Anunciar avisos del logro 'Sacúdete' a la banda<br/>(Requiere líder/ayudante)",
	RangeFrame				= "Mostrar distancia (10 normal, 20 heroico)<br/>(Solo mostrará los jugadores marcados)"
}

L:SetMiscLocalization{
	YellAirphase	= "¡Aquí termina vuestra incursión! ¡Nadie sobrevivirá!",
	YellPhase2		= "¡Ahora sentid el poder sin fin de mi maestro y desesperad!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--translate
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--translate
	BeaconIconSet	= "Señal de Escarcha, icono {rt%d} en %s",
	AchievementWarning	= "Aviso: %s tiene 5 marcas de Sacudida mística",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d marcas de Sacudida mística <<"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "El Rey Exánime"
}

L:SetWarningLocalization{
	ValkyrWarning			= "¡>%s< ha sido agarrado!",
	SpecWarnYouAreValkd		= "¡Te agarra una Valkyr!",
	WarnNecroticPlagueJump	= "Peste necrótica saltó a >%s<",
	SpecWarnValkyrLow		= "Valkyr con menos del 55%"
}

L:SetTimerLocalization{
	TimerRoleplay		= "Diálogo",
	PhaseTransition		= "Transición de fase",
	TimerNecroticPlagueCleanse = "Purgar Peste necrótica"
}

L:SetOptionLocalization{
	TimerRoleplay			= "Mostrar tiempo para Diálogo",
	WarnNecroticPlagueJump	= "Anunciar los objetivos donde $spell:73912 ha saltado",
	TimerNecroticPlagueCleanse	= "Mostrar tiempo para purgar Peste necrótica<br/>antes de la primera acumulación",
	PhaseTransition			= "Mostrar tiempo para las transiciones de fase",
	ValkyrWarning			= "Anunciar quien ha sido agarrado por las Valkyr",
	SpecWarnYouAreValkd		= "Mostrar aviso especial cuando seas agarrado por una Valkyr",
	ValkyrIcon				= "Poner iconos en las Valkyr",
	AnnounceValkGrabs		= "Aunciar el objetivo de Guardia de las Sombras Val'kyr en el chat de banda<br/>(necesita 'anunciar' activado y líder/ayudante)",
	SpecWarnValkyrLow		= "Mostrar aviso especial cuando la Valkyr está por debajo del 55%",
	AnnouncePlagueStack		= "Anunciar las marcas de $spell:73912 a la banda (10 marcas, cada 5 después)<br/>(requiere líder/ayudante)"
}

L:SetMiscLocalization{
	LKPull		= "¿Así que por fin ha llegado la elogiada justicia de la Luz? ¿Debería deponer la Agonía de Escarcha y confiar en tu piedad, Vadín?",
	LKRoleplay		= "¿Me pregunto si de verdad os mueve la... rectitud?",
	ValkGrabbedIcon	= "Val'kyr {rt%d} ha agarrado a %s",
	ValkGrabbed		= "Val'kyr ha agarrado a %s",
	PlagueStackWarning		= "Aviso: %s tiene %d marcas de Peste Necrótica",
	AchievementCompleted	= ">> LOGRO COMPLETADO: %s tiene %d marcas de Peste Necrótica <<"
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization{
	name = "Icecrown Trash"
}

L:SetWarningLocalization{
	SpecWarnTrapL		= "¡Trampa activada! ¡Sale un Depositario!",
	SpecWarnTrapP		= "¡Trampa activada! ¡Salen Siegacarnes vengativos!",
	SpecWarnGosaEvent	= "Mostrar aviso especial para el guantelete de Sindragosa"
}

L:SetOptionLocalization{
	SpecWarnTrapL		= "Mostrar aviso especial cuando se active trampa",
	SpecWarnTrapP		= "Mostrar aviso especial cuando se active trampa",
	SpecWarnGosaEvent	= "Mostrar aviso especial para el guantelete de Sindragosa"
}

L:SetMiscLocalization{
	WarderTrap1			= "¿Quién... anda ahí?",
	WarderTrap2			= "Estoy despierto...",
	WarderTrap3			= "El sagrario del maestro ha sido perturbado.",
	FleshreaperTrap1	= "Rápido, ¡atacaremos por la espalda!",
	FleshreaperTrap2	= "¡No... puedes escapar!",
	FleshreaperTrap3	= "¿Los vivos? ¿¡Aquí!?",
	SindragosaEvent		= "No debéis acercaros a la Reina de Escarcha. ¡Detenedlos, rápido!"
}
