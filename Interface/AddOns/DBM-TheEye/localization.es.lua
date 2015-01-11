if GetLocale() ~= "esES" then return end

local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization{
	name = "Al'ar"
}

L:SetTimerLocalization{
	NextPlatform	= "Next Platform"
}

L:SetOptionLocalization{
	NextPlatform	= "Show timer for when Al'ar changes platforms"
}

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization{
	name = "Atracador del vacío"
}

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization{
	name = "Gran astromante Solarian"
}

L:SetWarningLocalization{
	WarnSplit		= "*** Salen adds ***",
	WarnSplitSoon	= "*** División en 5 seg ***",
	WarnAgent		= "*** Salen Agentes ***",
	WarnPriest		= "*** Sacerdotes y Solarian salen ***"

}

L:SetTimerLocalization{
	TimerSplit		= "Salen",
	TimerAgent		= "Agentes",
	TimerPriest		= "Sacerdotes y Solarian"
}

L:SetOptionLocalization{--Translate
	WarnSplit		= "Show warning for Split",
	WarnSplitSoon	= "Show pre-warning for Split",
	WarnAgent		= "Show warning for Agents spawn",
	WarnPriest		= "Show warning for Priests and Solarian spawn",
	TimerSplit		= "Show timer for Split",
	TimerAgent		= "Show timer for Agents spawn",
	TimerPriest		= "Show timer for Priests and Solarian spawn",
	WrathWhisper	= "Enviar susurro a los objetivos de Cólera"
}

L:SetMiscLocalization{
	WrathWhisper	= "¡Cólera en tí!",
	YellSplit1		= "I will crush your delusions of grandeur!",--Translate
	YellSplit2		= "You are hopelessly outmatched!",--Translate
	YellPhase2		= "I become"--Translate
}

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization{
	name = "Kael'thas Caminante del Sol"
}

L:SetWarningLocalization{
	WarnGaze		= "*** Thaladred mira a >%s< ***",
	WarnMobDead		= "%s down",--Translate
	WarnEgg			= "*** Fénix muerto - salió huevo ***",
	SpecWarnGaze	= "¡Corre!",
	SpecWarnEgg		= "*** Fénix muerto - salió huevo ***"
}

L:SetTimerLocalization{--Translate
	TimerPhase		= "Next Phase",
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "New Gaze target",
	TimerRebirth	= "Phoenix Rebirth"
}

L:SetOptionLocalization{--Translate
	WarnGaze		= "Show warning for Thaladred's Gaze target",
	WarnMobDead		= "Show warning for Phase 2 mob down",
	WarnEgg			= "Show warning when Phoenix Egg spawn",
	SpecWarnGaze	= "Show special warning when Gaze on you",
	SpecWarnEgg		= "Show special warning when Phoenix Egg spawn",
	TimerPhase		= "Show time for next phase",
	TimerPhase1mob	= "Show time for Phase 1 mob active",
	TimerNextGaze	= "Show timer for Thaladred's Gaze target changes",
	TimerRebirth	= "Show timer for Phoenix Egg rebirth remaining",
	RangeFrame		= "Mostrar distancia",
	GazeWhisper		= "Enviar susurro al objetivo de Thaladred",
	GazeIcon		= "Poner icono en el objetivo de Thaladred"
}

L:SetMiscLocalization{
	YellPull1 	= "Energía. Poder. Mi gente es adicta a ellos... una dependencia que se puso de manifiesto cuando La Fuente del Sol fue destruida. Bienvenidos... al futuro. Es una pena que sea demasiado tarde para que os interpongáis. ¡Ya nadie me puede parar! ¡Selama ashal’anore!",
	YellPull2	= "Energía. Poder. Mi gente es adicta a ellos... una dependencia que se puso de manifiesto cuando La Fuente del Sol fue destruida. Bienvenidos al futuro. Es una pena que sea demasiado tarde para que os interpongáis. ¡Ya nadie me puede parar! ¡Selama ashal'anore!",
	YellPhase2	= "Como veis, dispongo de un amplio arsenal...",
	YellPhase3	= "Quizás os subestimé. Sería injusto que os enfrentarais a los cuatro consejeros al mismo tiempo, pero... nunca se le ha brindado un trato justo a mi gente. Así que os devuelvo el favor.",
	YellPhase4	= "Desafortunadamente hay veces en las que tienes que hacer las cosas con tus propias manos. ¡Balamore shanal!",
	YellPhase5	= "¡No he llegado hasta aquí para que me detengáis! ¡El futuro que he planeado no se pondrá en peligro! ¡Vais a probar el verdadero poder!",
	YellSang	= "Habéis sobrevivido a algunos de mis mejores consejeros... pero nadie puede resistir el poder del Martillo de Sangre. ¡He aquí Lord Sanguinar!",
	YellCaper	= "Capernian se encargará de que vuestra visita sea breve.",
	YellTelo	= "Bien hecho. Parecéis dignos de probar vuestras habilidades con mi maestro ingeniero Telonicus.",
	EmoteGaze	= "sets eyes on ([^%s]+)!",--Translate?
	GazeWhisper	= "¡Thaladred te mira! ¡Corre!",
	Thaladred	= "Thaladred el Ensombrecedor",
	Sanguinar	= "Lord Sanguinar",
	Capernian	= "Gran astromante Capernian",
	Telonicus	= "Maestro ingeniero Telonicus",
	Bow			= "Arco largo de fibra abisal",
	Axe			= "Devastación",
	Mace		= "Inyector cósmico",
	Dagger		= "Hoja de infinidad",
	Sword		= "Cercenador de distorsión",
	Shield		= "Baluarte de cambio de fase",
	Staff		= "Bastón de desintegración",
	Egg			= "Huevo de fénix"
}
