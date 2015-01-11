if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Bestias de Rasganorte"
}

L:SetMiscLocalization{
	--¡%s mira a (%S+) y emite un bramido!
	Charge			= "¡Aullahielo mira a (%S+) y emite un bramido!",
	CombatStart		= "Desde las cavernas más oscuras y profundas de Las Cumbres Tormentosas: ¡Gormok el Empalador! ¡A luchar, héroes!",
	Phase2			= "Preparaos, héroes, para los temibles gemelos: ¡Fauceácida y Aterraescama! ¡A la arena!",
	Phase3			= "El propio aire se congela al presentar a nuestro siguiente combatiente: ¡Aullahielo! ¡Matad o morid, campeones!",
	Gormok			= "Gormok el Empalador",
	Acidmaw			= "Fauceácida",
	Dreadscale		= "Aterraescama",
	Icehowl			= "Aullahielo"
}

L:SetOptionLocalization{
	WarningSnobold				= "Mostrar aviso cuando salen Vasallos snóbold",
	PingCharge					= "Pulsar en el Minimapa si Aullahielo va a por Ti",
	ClearIconsOnIceHowl			= "Limpiar iconos despues de cargar",
	TimerNextBoss				= "Mostrar tiempo para el proximo boss",
	TimerEmerge					= "Mostrar tiempo para emerger",
	TimerSubmerge				= "Mostrar tiempo para sumergir",
	IcehowlArrow				= "Mostrar flecha cuando Aullahielo está a punto de cargar cerca de ti"
}

L:SetTimerLocalization{
	TimerNextBoss				= "Proximo boss en",
	TimerEmerge					= "Emergen",
	TimerSubmerge				= "Se sumergen"

}

L:SetWarningLocalization{
	WarningSnobold				= "Sale Vasallo snóbold"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetOptionLocalization{
	IncinerateShieldFrame	= "Mostrar la vida del boss con la barra de incinerar carne"
}

L:SetMiscLocalization{
	IncinerateTarget		= "Incinerar carne en: %s",
	FirstPull	= "El gran brujo Wilfred Chispobang invocará al siguiente contrincante. Esperad a que aparezca."
}

-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Campeones de Facción"
}

L:SetMiscLocalization{
	AllianceVictory    = "¡GLORIA A LA ALIANZA!",
	HordeVictory       = "That was just a taste of what the future brings. FOR THE HORDE!",--translate
	YellKill	= "Una victoria trágica y fútil. Hoy somos menos por las pérdidas que hemos sufrido. ¿Quién podría beneficiarse de tal insensatez además del Rey Exánime? Grandes guerreros han perdido la vida. ¿Y para qué? La verdad"
}

------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Gemelas Val’kyrs"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Siguiente Habilidad especial"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon	= "Habilidad especial pronto!",
	SpecWarnSpecial		= "Cambia color!",
	SpecWarnSwitchTarget		= "Cambio!",
	SpecWarnKickNow				= "Cortar ahora!",
	WarningTouchDebuff			= "Debuff en >%s<",
	WarningPoweroftheTwins		= "Pacto de las Gemelas - curar mas a >%s<",
	SpecWarnPoweroftheTwins		= "Pacto de las Gemelas!"
}

L:SetMiscLocalization{
	Fjola 		= "Fjola Penívea",
	Eydis		= "Eydis Penalumbra"
}

L:SetOptionLocalization{
	TimerSpecialSpell	= "Mostrar tiempo para la siguiente habilidad especial",
	WarnSpecialSpellSoon	= "Pre-aviso para la siguiente habilidad especial",
	SpecWarnSpecial		= "Mostrar aviso especial si tienes que cambiar de color",
	SpecWarnSwitchTarget		= "Mostrar aviso especial si hay que ir al otro boss",
	SpecWarnKickNow				= "Mostrar aviso especial cuando tienes que cortar el hechizo",
	SpecialWarnOnDebuff			= "Mostrar aviso especial cuando tienes que cambiar de debuff",
	SetIconOnDebuffTarget		= "Poner iconos a los objetivos con debuff ( solo heroico )",
	WarningTouchDebuff			= "Anunciar objetivos del debuff de Toque de Luz/Oscuridad",
	WarningPoweroftheTwins		= "Anunciar objetivo de Pacto de las Gemelas",
	SpecWarnPoweroftheTwins		= "Mostrar aviso especial si eres el tank y estas en una gemela con el pacto de las gemelas"
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Emerger en",
	TimerSubmerge			= "Sumersion en",
	timerAdds				= "Nuevos adds"
}

L:SetWarningLocalization{
	WarnEmerge				= "Anub'arak emerge",
	WarnEmergeSoon			= "Emerger en 10 seg",
	WarnSubmerge			= "Anub'arak se sumerge",
	WarnSubmergeSoon		= "Sumersion en 10 seg",
	specWarnSubmergeSoon	= "Sumersion en 10 segundos!",
	warnAdds				= "Nuevos adds"
}

L:SetMiscLocalization{
	Emerge					= "emerge",
	Burrow					= "entierra",
	PcoldIconSet			= "Icono FrioP {rt%d} puesto en %s",
	PcoldIconRemoved		= "Icono FrioP eliminado de %s"
}

L:SetOptionLocalization{
	WarnEmerge				= "Mostrar aviso para Emerger",
	WarnEmergeSoon			= "Mostrar pre-aviso para Emerger",
	WarnSubmerge			= "Mostrar aviso para Sumersion",
	WarnSubmergeSoon		= "Mostrar pre-aviso para Sumersion",
	specWarnSubmergeSoon	= "Mostrar pre-aviso especial Sumersion",
	warnAdds				= "Mostrar aviso para nuevos adds",
	timerAdds				= "Mostrar tiempo para nuevos adds",
	TimerEmerge				= "Mostrar tiempo para Emerger",
	TimerSubmerge			= "Mostrar tiempo para Sumerger",
	AnnouncePColdIcons		= "Anunciar iconos para los ojetivos de $spell:68510 en el chat de banda<br/>(Requiere líder de banda)",
	AnnouncePColdIconsRemoved	= "También anunciar cuando se eliminen los iconos de los objetivos $spell:68510<br/>(Necesita la opción anterior)"
}
