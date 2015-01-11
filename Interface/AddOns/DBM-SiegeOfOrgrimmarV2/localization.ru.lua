﻿if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory			= "У вас получилось! Теперь воды снова чисты."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
	warnCalamity		= "%s",
	specWarnCalamity	= "%s",
	specWarnMeasures	= "Скоро Крайние меры (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime			= "Хорошо, я создам поле для удерживания порчи."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Устанавливать метку на Оскверненный осколок"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen		= "Башня открылась",
	warnTowerGrunt		= "Рубака у башни"
})

L:SetTimerLocalization({
	timerTowerCD		= "След. башня",
	timerTowerGruntCD	= "След. Рубака у башни"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Объявлять когда башня открывается",
	warnTowerGrunt		= "Объявлять когда появляется новый Рубака у башни",
	timerTowerCD		= "Отсчет времени до следующего нападения на башню",
	timerTowerGruntCD	= "Отсчет времени до следующего Рубаки у башни"
})

L:SetMiscLocalization({
	wasteOfTime		= "Отлично! Десант, стройся! Пехота – впереди.",--Alliance Version
	wasteOfTime2	= "Отлично, первый отряд высадился.",--Horde Version
	Pull			= "Воины Драконьей Пасти! Отбейте пристань и сбросьте врага в море! Во имя Истинной Орды!",
	newForces1		= "Вот и они!",--Jaina's line, horde may not be same
	newForces1H		= "Сбейте ее скорее, не терпится взять ее за глотку.",--Sylva's line, horde
	newForces2		= "Драконья Пасть, вперед!",
	newForces3		= "За Гарроша!",
	newForces4		= "Следующий отряд!",
	tower			= "Дверь "--Дверь южной/северной башни разбита!
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "Тюрьма на %s спадает (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Оборонительная стойка через %d сек."
})

L:SetMiscLocalization({
	newForces1					= "Воины, бегом!",
	newForces2					= "Удерживайте врата!",
	newForces3					= "Сомкнуть ряды!",
	newForces4					= "Кор'крон, ко мне!",
	newForces5					= "Следующий отряд, вперед!",
	allForces					= "Кор'кронцы... все, кто со мной! Убейте их!",
	nextAdds					= "След. адды: "
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime		= "Эй, записываем? Хорошо. Запускаю гоблинско-титанский блок управления. Все назад.",
	Module1 		= "Первый модуль готов к перезагрузке системы.",
	Victory			= "Второй модуль готов к перезагрузке системы."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Показывать динамическое окно проверки дистанции (10)<br/>(Это умное окно проверки дистанции, которое появляется когда вы достигаете порога Бешенства)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "На сборочную линию начинает поступать незаконченное оружие.",
	newShredder	= "Приближается автоматический крошшер!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "Вы уязвимы к %s - Избегайте!",
	specWarnMoreParasites			= "Вам нужно больше паразитов - Не блокируйте!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Спец-предупреждение когда вы уязвимы к активирующимся идеалам",
	specWarnMoreParasites			= "Спец-предупреждение когда вам нужно больше паразитов"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "один",
	two					= "два",
	three				= "три",
	four				= "четыре",
	five				= "пять",
	hisekFlavor			= "Смотрите, кто теперь тихий",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor		= "Обычный рабочий день, уничтожаем рой",--http://ptr.wowhead.com/quest=31109
	XarilFlavor			= "Я вижу только темные небеса в твоем будущем",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor		= "Сойдёт на угощение куньчуну",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2		= "1 богомол убит, осталось 199",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor		= "Конец древней империи",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2		= "Забери свои гуртанские таблички и подавись ими",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor		= "Видишь возможности. Используй их!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor			= "Ты больше не будешь прыгать!",---Does not have quests, http://ptr.wowhead.com/npc=65303
	SkeerFlavor			= "Кровавое удовольствие!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor		= "Запрос образцов выполнен"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
	RangeFrame			= "Показывать динамическое окно проверки дистанции (8)<br/>(Это умное окно проверки дистанции, которое появляется когда вы достигаете порога $spell:147126)",
	InfoFrame			= "Информационное окно для игроков без снижения урона на переходной фазе",
	yellMaliceFading	= "Кричать когда $spell:147209 спадает"
})

L:SetMiscLocalization({
	NoReduce			= "Нет снижения урона",
	MaliceFadeYell		= "Злоба спадает с %s (%d)"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Осады Оргриммара"
})
