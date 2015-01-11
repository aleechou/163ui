if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

local optionWarning	= "Mostrar cuadno haga %s "
local optionPreWarning	= "Mostrar pre-aviso de %s "


----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization(581)

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization(580)

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization(582)

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization(584)

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization(583)

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization(585)

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization(586)

---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak H"
})


--------------------------------------
-- Caverns of Time - Old Stratholme --
--------------------------------------
-- Meathook --
--------------
L = DBM:GetModLocalization(611)

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization(612)

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization(613)

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization(614)

L:SetGeneralLocalization({
	name = "Mal'Ganis"
})

L:SetMiscLocalization({
	Outro	= "Tu viaje acaba de comenzar, joven Príncipe. Reúne a tus tropas y ven a verme en las árticas tierras de Rasganorte. Allí ajustaremos cuentas. Allí es donde se desvelará tu verdadero destino."
})

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Oleadas de CoT4"
})

L:SetWarningLocalization({
	WarningWaveNow		= "Oleada %d: %s empieza"
})

L:SetTimerLocalization({
	TimerWaveIn	= 	"Siguiente oleada (6)",
	TimerRoleplay	= "Diálogo"
})

L:SetOptionLocalization({
	WarningWaveNow		= optionWarning:format("Nueva oleada"),
	TimerWaveIn		= "Mostrar tiempo para próximas oleadas (despues del boss de la 5a oleada)",
	TimerRoleplay	= "Mostrar tiempo de diálogo inicial"
})


L:SetMiscLocalization({
	Devouring	= "Necrófago devorador",
	Enraged		= "Necrófago iracundo",
	Necro		= "Nigromante oscuro",
	Fiend		= "Maligno de cripta",
	Stalker		= "Acechador de tumbas",
	Abom		= "Ensamblaje de retazos",
	Acolyte		= "Acólito",
	Wave1		= "%d %s",
	Wave2		= "%d %s and %d %s",
	Wave3		= "%d %s, %d %s and %d %s",
	Wave4		= "%d %s, %d %s, %d %s and %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Oleada de la Plaga = (%d+)/10",
	Roleplay	= "Me alegra que lo consiguieras, Uther.",
	Roleplay2	= "Parece que todo el mundo está listo. Recordad, esta gente está infectada por la peste y pronto morirá. Debemos purgar Stratholme para proteger de la Plaga lo que queda de Lordaeron. Vamos."
})


----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
L = DBM:GetModLocalization(588)

------------------------
-- Novos the Summoner --
------------------------
L = DBM:GetModLocalization(589)

L:SetMiscLocalization({
	YellPull		= "¡El frío que sentís es el presagio de vuestro sino!",
	HandlerYell		= "¡Refuerza mis defensas! ¡Deprisa, maldito!!",
	Phase2			= "¡Seguro que ahora veis la inutilidad de todo ello!",
	YellKill		= "Vuestros esfuerzos... son en vano."
})

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization(590)

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization(591)

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization(592)

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization(594)

-------------------------
--  Drakkari Colossus  --		
-------------------------
L = DBM:GetModLocalization(593)

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization(596)

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization(595)

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization(597)

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization(599)

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization(598)

-------------
--  Loken  --
-------------
L = DBM:GetModLocalization(600)

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization(605)

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization(604)

------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization(607)

--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization(606)

L:SetWarningLocalization({
	WarningPhase	= "Fase %d"
})

L:SetTimerLocalization({
	timerEvent	= "Tiempo restante"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("Fase numero"),
	timerEvent		= "Mostrar tiempo restante del evento"
})

L:SetMiscLocalization({
	Pull	= "¡Atentos! Tendré esto listo en un par de...",
	Phase1	= "Incumplimiento del código de seguridad en progreso. Análisis de los archivos históricos relegado a la cola de menor prioridad. Contramedidas activadas.",
	Phase2	= "Límite de índice de amenaza superado. Archivo celestial cancelado. Nivel de seguridad aumentado.",
	Phase3	= "Índice de amenaza crítico. Análisis del vacío desviado. Iniciando protocolo de higienización.",
	Kill	= "Alerta: sistema de seguridad desactivado. Comenzando purga de memoria y..."
})

---------------
-- The Nexus --
---------------
-- Anomalus --
--------------
L = DBM:GetModLocalization(619)

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization(620)

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization(618)

L:SetMiscLocalization({
	SplitTrigger1 = "¡Tendréis más de lo que podéis soportar!",
	SplitTrigger2 = "¡Tendréis más de lo que podéis soportar!"
})

-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization(621)

---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Unknown"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Comandante Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Comandante Barbarrecia"
end

L:SetGeneralLocalization({
	name = commander
})


----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization(622)

L:SetOptionLocalization({
	MakeitCountTimer	= "Mostrar tiempo para 'Haz que cuente' (logro)"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Haz que cuente"
})


--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization(624)

L:SetMiscLocalization({
	CombatStart		= "¡Pobres necios ciegos!"
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization(623)

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization(625)

L:SetMiscLocalization({
	MakeitCountTimer	= "Haz que cuente"
})

------------------
-- Utgarde Keep --
---------------------
-- Prince Keleseth --
---------------------
L = DBM:GetModLocalization(638)

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization(639)

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization(640)

L:SetMiscLocalization({
	YellCombatEnd	= "¡No! Puedo hacerlo... ¡mejor! Puedo..."
})

----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization(643)

L:SetMiscLocalization({
	CombatStart		= "¿Qué chuchos son los que se atreven a irrumpir aquí? ¡Adelante, hermanos! ¡Un festín para quien me traiga sus cabezas!",
	Phase2			= "¡Bastardos malnacidos! ¡Vuestros cadáveres serán un buen bocado para mis nuevos dracos!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

L:SetTimerLocalization({
	timerRoleplay		= "Svala Sorrowgrave ataca"
})

L:SetOptionLocalization({
	timerRoleplay		= "Mostrar tiempo de diálogo antes de que Svala ataque"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "¡Mi señor! He hecho lo que pedisteis, ¡y ahora suplico vuestra bendición!"
})

---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization(642)

---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization(632)

L:SetMiscLocalization({
	CyanArrived	= "Una defensa valiente, pero esta ciudad debe ser arrasada. ¡Yo misma cumpliré los deseos de Malygos!"
})

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization(626)

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization(628)

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization(630)

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization(627)

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization(629)

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization(631)

-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Timpo de Portales"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Preparate para el portal",
	WarningPortalNow	= "Portal Nº%d abierto",
	WarningBossNow		= "Ahora toca boss"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal Nº%d en" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("Nuevo portal"),
	WarningPortalSoon		= optionPreWarning:format("Nuevo portal"),
	WarningBossNow			= optionWarning:format("Toca boss"),
	TimerPortalIn			= "Mostrar tiempo para siguiente portal (después de boss)",
	ShowAllPortalTimers		= "Mostrar tiempo para todos los portales (poco acurado)"
})


L:SetMiscLocalization({
	Sealbroken	= "¡Hemos atravesado la puerta de la prisión! ¡El camino hacia Dalaran está despejado! ¡Por fin hemos puesto punto y final a la guerra de El Nexo!",
	WavePortal		= "Portales abiertos: (%d+)/18"
})


---------------------
-- Trial of the Champion --
---------------------
-------------------
-- The Black Knight --
-------------------
L = DBM:GetModLocalization(637)

L:SetOptionLocalization({
	AchievementCheck		= "Anunciar fallo del logro 'Podría ser peor' al grupo"
})

L:SetMiscLocalization({
	Pull			= "Bien hecho. Hoy has demostrado algo...",
	AchievementFailed	= ">> LOGRO FALLADO: %s ha sido alcanzado por Explosión de necrófago <<",
	YellCombatEnd	= "¡No! No debo fallar... otra vez..."
})


-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization(634)

L:SetMiscLocalization({
	YellCombatEnd	= "¡Bien luchado! Vuestro próximo reto llega de entre las filas de la propia Cruzada. Se os pondrá a prueba contra su considerable destreza."
})


-------------------
-- Argent Confessor Paletress --
-------------------
L = DBM:GetModLocalization(636)

L:SetMiscLocalization({
	YellCombatEnd	= "¡Un trabajo excelente!"
})

-------------------
-- Eadric the Pure --
-------------------
L = DBM:GetModLocalization(635)

L:SetWarningLocalization({
	specwarnRadiance		= "Radiancia. Date la vuelta!"
})

L:SetOptionLocalization({
	specwarnRadiance		= "Mostrar aviso especial para $spell:66935"
})

L:SetMiscLocalization({
	YellCombatEnd	= "¡Me rindo! Lo admito. Un trabajo excelente. ¿Puedo escaparme ya?"
})

---------------------
-- Pit of Saron --
-------------------
--  Ick and Krick  --
-------------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	IckPursuit				= "¡%s te atrapa!",
	Barrage					= "¡%s comienza a invocar minas explosivas!"
})
-------------------
-- Forgemaster Garfrost --
-------------------
L = DBM:GetModLocalization(608)

L:SetOptionLocalization({
	AchievementCheck	= "Anunciar avisos del logro 'Solo once campanadas' en el chat de grupo"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "¡%s te lanza un pedrusco de saronita enorme!",
	AchievementWarning	= "Aviso: %s tiene %d marcas de Escarcha permanente",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d marcas de Escarcha permanente <<"
})

-------------------
-- Scourgelord Tyrannus --
-------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart					= "¡Ay! Valientes aventureros, vuestra intromisión ha llegado a su fin. ¿Oís el ruido de huesos y acero acercándose por ese túnel? Es el sonido de vuestra inminente muerte.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget				= "¡La vermis de escarcha Dientrefrío mira a (%S+) y prepara un helado ataque!",
	YellCombatEnd				= "Imposible... Dientefrío... Avisa..."
})

----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization(615)

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization(616)

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Tiempo de oleadas"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Nueva oleada pronto",
	WarnNewWave		= "%s viene"
})

L:SetTimerLocalization({
	TimerNextWave	= "Siguiente oleada"
})

L:SetOptionLocalization({
	WarnNewWave			= "Mostrar aviso cuando llega una oleada",
	WarnNewWaveSoon		= "Mostrar pre-aviso para nueva oleada(después del 1r boss)",
	ShowAllWaveWarnings	= "Mostrar pre-aviso para todas las oleadas",	--Is this a warning or a pre-warning?
	TimerNextWave		= "Mostrar tiempo para nuevo grupo de oleadas (después del 1r boss)",
	ShowAllWaveTimers	= "Mostrar tiempo para todas las oleadas (poco acurado)"
})

L:SetMiscLocalization({
	WaveCheck	= "Oleada de espiritus = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization(601)

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization(602)

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization(603)

L:SetWarningLocalization({
	WarnWave		= "%s"
})

L:SetTimerLocalization({
	achievementEscape	= "Tiempo para escapar"
})

L:SetOptionLocalization({
	WarnWave	= "Mostrar avisos para las oleadas que vienen"
})

L:SetMiscLocalization({
	ACombatStart	= "Es demasiado poderoso. ¡Debemos abandonar este lugar ahora mismo! Mi magia podrá inmovilizarlo brevemente. ¡Vamos rápido, héroes!",
	HCombatStart	= "He's... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can to hold him in place while we flee.",
	Wave1			= "¡No hay escapatoria!",
	Wave2			= "Sucumbid al frío de la tumba.",
	Wave3			= "Otro final sin salida.",
	Wave4			= "¿Cuánto vais a aguantar?",
	YellCombatEnd	= "¡FUEGO! ¡FUEGO!"
})