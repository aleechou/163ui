if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	WarnWhelpsSoon	= "Pronto saldran crias"
}

L:SetTimerLocalization{
	TimerWhelps = "Crías de Onyxia"
}

L:SetOptionLocalization{
	TimerWhelps		= "Mostrar tiempo para las crias",
	WarnWhelpsSoon	= "Mostrar pre-aviso para las crias",
	SoundWTF				= "Reproducir sonidos divertidos de una banda legendaria de Onyxia classico"
}

L:SetMiscLocalization{
	YellP2 = "Este ejercicio sin sentido me aburre. ¡Os inceneraré a todos desde arriba!",
	YellP3 = "¡Parece ser que vais a necesitar otra lección, mortales!"
}
