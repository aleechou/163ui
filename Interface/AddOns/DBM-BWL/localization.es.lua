if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Sangrevaja el Indomable"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Salen adds"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Mostrar tiempo para que salgan los primeros adds"
}
L:SetMiscLocalization{
	Phase2Emote	= "Orbe de dominación pierde potencia y se apaga.",
	YellPull = "¡Los invasores han penetrado en El Criadero! ¡Activad la alarma! ¡Hay que proteger los huevos a toda costa!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name = "Vaelastrasz el Corrupto"
}
L:SetTimerLocalization{
	TimerCombatStart	= "Empieza el combate"
}

L:SetOptionLocalization{
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate"
}

L:SetMiscLocalization{
	Event				= "¡Demasiado tarde, amigos! Ahora estoy poseído por la corrupción de Nefarius... No puedo... controlarme."
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name = "Señor de linaje Capazote"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Faucefogo"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Ebanorroca"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Flamagor"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Chromaggus"
}
L:SetWarningLocalization{
	WarnBreathSoon	= "Aliento pronto",
	WarnBreath		= "%s",
	WarnPhase2Soon	= "Fase 2 pronto"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s CD"
}
L:SetOptionLocalization{
	WarnBreathSoon	= "Mostrar pre-aviso para los Alientos",
	WarnBreath		= "Mostrar aviso cuando castea Aliento",
	TimerBreathCD	= "Mostrar tiempo para siguiente Aliento",
	WarnPhase2Soon	= "Mostrar pre-aviso para la fase 2"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "Nefarian"
}
L:SetWarningLocalization{
	WarnClassCallSoon	= "Debuff de clase pronto",
	WarnClassCall		= "Debuff de %s",
	WarnPhaseSoon		= "Fase %s pronto",
	WarnPhase			= "Fase %s"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s Debuff de clase"
}
L:SetOptionLocalization{
	TimerClassCall		= "Mostrar duración de debuff de clase",
	WarnClassCallSoon	= "Mostrar pre-aviso para debuff de clase",
	WarnClassCall		= "Mostrar aviso para debuff de clase",
	WarnPhaseSoon		= "Mostrar pre-aviso para cambio de fase",
	WarnPhase			= "Mostrar aviso al cambiar de fase"
}
L:SetMiscLocalization{
	YellPull	= "¡Que comiencen los juegos!",
	YellP2		= "Bien hecho, mis esbirros. El coraje de los mortales empieza a mermar. ¡Veamos ahora cómo se enfrentan al verdadero Señor de la Cubre de Roca Negra!",
	YellP3		= "¡Imposible! ¡Erguíos, mis esbirros! ¡Servid a vuestro maestro una vez más!",
	YellShaman	= "¡Chamanes, mostradme lo que pueden hacer vuestros tótems!",
	YellPaladin	= "Paladines... He oído que tenéis muchas vidas. Demostrádmelo.",
	YellDruid	= "Los druidas y vuestro estúpido poder de cambiar de forma. ¡Veámoslo en acción!",
	YellPriest	= "¡Sacerdotes! Si vais a seguir curando de esa forma, ¡podíamos hacerlo más interesante!",
	YellWarrior	= "¡Vamos guerreros, sé que podéis golpear más fuerte que eso! ¡Veámoslo!",
	YellRogue	= "Rogues? Stop hiding and face me!",--translate
	YellWarlock	= "Warlocks, you shouldn't be playing with magic you don't understand. See what happens?",--translate
	YellHunter	= "Hunters and your annoying pea-shooters!",--translate
	YellMage	= "¿Magos también? Deberíais tener más cuidado cuando jugáis con la magia...",
	YellDK		= "Caballero de la muerte"--translate
}