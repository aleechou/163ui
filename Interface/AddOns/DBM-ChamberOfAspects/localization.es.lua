﻿if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})


---------------
--  Tenebron  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})


---------------
--  Vesperon  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})


---------------
--  Sartharion  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron viene",
	WarningShadron			= "Shadron viene",
	WarningVesperon			= "Vesperon viene",
	WarningFireWall			= "¡Muro de Fuego!",
	WarningVesperonPortal	= "¡Portal de Vesperon!",
	WarningTenebronPortal	= "¡Portal de Tenebron!",
	WarningShadronPortal	= "¡Portal de Shadron!"
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron viene",
	TimerShadron	= "Shadron  viene",
	TimerVesperon	= "Vesperon viene"
})

L:SetOptionLocalization({
	AnnounceFails		= "Spamear en la banda la gente que falle Muro de Fuego y Zona de Vacio (Requiere 'anunciar' habilitado y lider)",
	TimerTenebron		= "Mostrar tiempo para Tenebron",
	TimerShadron		= "Mostrar tiempo para Shadron",
	TimerVesperon		= "Mostrar tiempo para Vesperon",
	WarningFireWall		= "Mostrar aviso especial para \"Muro de Fuego\" ",
	WarningTenebron		= "Mostrar tiempo para que Tenebron venga",
	WarningShadron		= "Mostrar tiempo para que Shadron venga",
	WarningVesperon		= "Mostrar tiempo para que Vesperon venga",
	WarningTenebronPortal	= "Mostrar aviso especial para los portales de Tenebron",
	WarningShadronPortal	= "Mostrar aviso especial para los portales de Shadron",
	WarningVesperonPortal	= "Mostrar aviso especial para los portales de Vesperon"
})

L:SetMiscLocalization({
	Wall			= "¡La lava se arremolina alrededor de %s!",
	Portal			= "%s comienza a abrir un Portal Crepuscular",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Muro de Fuego: %s",
	VoidZoneOn		= "Zona de vacio: %s",
	VoidZones		= "Zona de vacio fallos (este intento): %s",
	FireWalls		= "Muro de Fuego fallos (esta intento): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus el Batallante"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Separación pronto"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Mostrar pre-aviso para Separación (54%)",
	RangeFrame			= "Mostrar distancia (12 yardas)"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Furia Ardiente"
})

L:SetOptionLocalization({
	RangeFrame				= "Mostrar distancia (10 yardas)"
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "Nuevos adds",
	warnCleaveArmor	= "%s en >%s< (%s)"
})

L:SetTimerLocalization({
	TimerAdds	= "Nuevos adds"
})

L:SetOptionLocalization({
	WarnAdds		= "Anunciar nuevos adds",
	TimerAdds		= "Mostrar tiempo para nuevos adds"
})

L:SetMiscLocalization({
	SummonMinions	= "¡Reducidlos a cenizas, esbirros!"
})


-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion el Destructor Crepuscular"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "Casteando Corte Crepuscular: 5 seg"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "Mostrar aviso cuando $spell:77844 se esté casteando",
	AnnounceAlternatePhase	= "Mostrar también avisos/tiempos de la fase en la que no estás",
	SetIconOnConsumption	= "Poner iconos en los objetivos de $spell:74562 y $spell:74792",
	WhisperOnConsumption	= "Enviar susurro a los objetivos de $spell:74562 o $spell:74792"
})

L:SetMiscLocalization({
	Halion					= "Halion",
	MeteorCast				= "¡Los cielos arden!",
	Phase2					= "En el reino del crepúsculo solo encontraréis sufrimiento. ¡Entrad si os atrevéis!",
	Phase3					= "¡Yo soy la luz y la oscuridad! ¡Temed, mortales, la llegada de Alamuerte!",
	twilightcutter			= "¡Las esferas que orbitan emiten energía oscura!",
	WhisperCombustion		= "¡Combustion en ti! ¡Corre a la pared!",
	WhisperConsumption		= "¡Consumo en ti! ¡Corre a la pared!",
	Kill					= "Disfrutad la victoria, mortales, porque será la última. ¡Este mundo arderá cuando vuelva el maestro!"
})