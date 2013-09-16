--[[ Credit for these translations goes to:
	StingerSoft
	Alphabot
	zuko3d
	Ivlin
	Ant1dotE
	KizEY
--]]
local L = LibStub("AceLocale-3.0"):NewLocale("TellMeWhen", "ruRU", false)
if not L then return end


L["ACTIVE"] = "% активно" -- Needs review
L["AIR"] = "Воздух"
L["ALLOWCOMM"] = "Разрешает поделиться в игре" -- Needs review
L["ALLOWVERSIONWARN"] = "Сообщать о новой версии"
L["ALPHA"] = "Альфа" -- Needs review
L["ANIM_ACTVTNGLOW"] = "Иконка: Активация рамки" -- Needs review
L["ANIM_ACTVTNGLOW_DESC"] = "Показывает на иконке границу активации близзардовского заклинания." -- Needs review
L["ANIM_COLOR"] = "Цвет/Прозрачность" -- Needs review
L["ANIM_COLOR_DESC"] = "Сконфигурируйте цвет и непрозрачность мигания." -- Needs review
L["ANIM_FADE"] = "Мигание при неудаче" -- Needs review
L["ANIM_FADE_DESC"] = "С галочкой для гладкого перехода между миганиями. Без галочки для немедленной вспышки." -- Needs review
L["ANIM_ICONALPHAFLASH"] = "Иконка: Альфа мигание" -- Needs review
L["ANIM_ICONALPHAFLASH_DESC"] = "Непосредственно подсвечивает иконку изменением ее непрозрачности." -- Needs review
L["ANIM_ICONCLEAR"] = "Иконка: Прекращение анимации" -- Needs review
L["ANIM_ICONCLEAR_DESC"] = "Прекратить всю анимацию на данной иконке." -- Needs review
L["ANIM_ICONFADE"] = "Иконка: Постепенное проявление Вкл/Выкл" -- Needs review
L["ANIM_ICONFADE_DESC"] = "Постепенно применяет любые изменения непрозрачности, которые происходили с отобранным событием." -- Needs review
L["ANIM_ICONFLASH"] = "Иконка: Цветное мигание" -- Needs review
L["ANIM_ICONFLASH_DESC"] = "Иконка подсвечивается мигающим цветом" -- Needs review
L["ANIM_ICONSHAKE_DESC"] = "Трясет иконку при срабатывании." -- Needs review
L["ANIM_INFINITE"] = "Играть неопределенно" -- Needs review
L["ANIM_INFINITE_DESC"] = "С галочкой, чтобы заставить мультипликацию играть, пока она не перепишется другой мультипликацией на иконке такого же типа, или пока играет %q мультипликация." -- Needs review
L["ANIM_PERIOD"] = "Период Вспышки" -- Needs review
L["ANIM_PERIOD_DESC"] = [=[Устанавливает, сколько времени каждое мигание должно длиться - время, когда мигание показывается или усиливается.

Установите 0, если Вам не нужно постепенное проявление или мигание.]=] -- Needs review
L["ANIM_SCREENFLASH"] = "Экран: Мигает" -- Needs review
L["ANIM_SCREENFLASH_DESC"] = "Мигает наложенным на экран цветом" -- Needs review
L["ANIM_SCREENSHAKE_DESC"] = [=[При срабатывании трясет весь экран.

ВАЖНО: Это сработает если Вы будете или вне боя или если имена персонажей не были включены во время загрузки.]=] -- Needs review
L["ANN_CHANTOUSE"] = "Исп. канал" -- Needs review
L["ANN_EDITBOX"] = "Выводимый текст" -- Needs review
L["ANN_EDITBOX_DESC"] = "Введите текст, который будет выводиться при определенном событии. Могут быть использованы стандартные замещения: \"%t\" для вашей цели и \"%f\" для вашего фокуса." -- Needs review
L["ANN_EDITBOX_WARN"] = "Наберите текст для отображения в этом месте" -- Needs review
L["ANN_SHOWICON"] = "Показать текстуру значка" -- Needs review
L["ANN_SHOWICON_DESC"] = "Некоторые текстовые поля могут отображать помимо текста текстуры. Установите эту опцию для включения данной особенности." -- Needs review
L["ANN_STICKY"] = "Прилипание" -- Needs review
L["ANN_SUB_CHANNEL"] = "Подраздел" -- Needs review
L["ANN_TAB"] = "Извещения" -- Needs review
L["ANN_WHISPERTARGET"] = "Шепнуть цели"
L["ANN_WHISPERTARGET_DESC"] = [=[Введите имя игрока которому вы хотите шепнуть. 
Игрок должен быть с вашего сервера и одной фракции с вами.]=] -- Needs review
L["ASCENDING"] = "Восходящий"
L["ASPECT"] = "Аспект"
L["AURA"] = "Аура" -- Needs review
L["BACK_IE"] = "назад"
L["BACK_IE_DESC"] = "Загрузить последнюю отредактированную иконку (%s |T%s:0|t)." -- Needs review
L["Bleeding"] = "Кровотечение"
L["BonusStamina"] = "+ к выносливости"
L["BOTTOM"] = "Внизу"
L["BOTTOMLEFT"] = "Внизу слева"
L["BOTTOMRIGHT"] = "Внизу справа"
L["BUFFTOCHECK"] = "Бафф для проврки" -- Needs review
L["BurstManaRegen"] = "+ к резкому восполнению маны"
L["CASTERFORM"] = "Может произносить заклинания"
L["CENTER"] = "В центре"
L["CHAT_FRAME"] = "Область чата" -- Needs review
L["CHAT_MSG_CHANNEL"] = "Канал чата" -- Needs review
L["CHAT_MSG_CHANNEL_DESC"] = "Отображает в виде сообщения в канале чата (например Торговля или любой другой к которому вы присоединены)" -- Needs review
L["CHAT_MSG_SMART"] = "Умный чат" -- Needs review
L["CHAT_MSG_SMART_DESC"] = "Сообщение отображается в наиболее подходящем канале чата: Рейд, Группа, Поле сражения или Сказать." -- Needs review
L["CHECKORDER"] = "Порядок обновления" -- Needs review
L["CHOOSENAME_DIALOG"] = [=[Введите название или ID того, что Вы хотите отслеживать на этой иконке. Можно добавить несколько названий (любые комбинации имен, ID или эквивалентов), разделяя их ';'.
Shift+ЛКМ введет заклинания/предметы/текст  или  перетащите мышью заклинания/предметы для ввода их в это поле.]=] -- Needs review
L["CHOOSENAME_DIALOG_DDDEFAULT"] = "Предопределенные наборы заклинаний"
L["CHOOSENAME_DIALOG_PETABILITIES"] = "|cFFFF5959Способности питомцев|r нужно указывать в виде идентификаторов (SpellID)."
L["CLEU_"] = "Любое событие" -- Needs review
L["CLEU_CAT_AURA"] = "Баф/Дебаф" -- Needs review
L["CLEU_CAT_CAST"] = "Заклинания" -- Needs review
L["CLEU_CAT_MISC"] = "Разное"
L["CLEU_CAT_SPELL"] = "Заклинания" -- Needs review
L["CLEU_CAT_SWING"] = "мили/рендж"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MASK"] = "Контроль взаимосвязями (отношениями)" -- Needs review
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MINE_DESC"] = "Отметьте для исключения юнитов, подконтрольных вам." -- Needs review
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_PARTY"] = "Управление группой: Члены группы" -- Needs review
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_RAID"] = "Управление группой: Члены рейда" -- Needs review
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_RAID_DESC"] = "Проверка для исключения объектов, контролируемых кем-либо еще в Вашей рейдовой группе" -- Needs review
L["CLEU_COMBATLOG_OBJECT_CONTROL_MASK"] = "Контроллер" -- Needs review
L["CLEU_COMBATLOG_OBJECT_CONTROL_NPC"] = "Контроллер:Сервер" -- Needs review
L["CLEU_COMBATLOG_OBJECT_NONE_DESC"] = "С галочкой, чтобы исключить объекты, которые абсолютно неизвестны клиенту WoW. Это происходит очень редко и может вообще быть оставлено без проверки." -- Needs review
L["CLEU_COMBATLOG_OBJECT_TYPE_GUARDIAN_DESC"] = "С галочкой исключить Охрану. Охрана - объекты, которые защищают свой контроллер, но не могут управляться непосредственно." -- Needs review
L["CLEU_DAMAGE_SHIELD"] = "Щит от урона" -- Needs review
L["CLEU_DAMAGE_SHIELD_DESC"] = "Возникает, если вредоносный щит (%s, %s, итд., но не %s) повреждает объект." -- Needs review
L["CLEU_DAMAGE_SHIELD_MISSED_DESC"] = "Происходит, когда щит от урона (%s, %s, и т.д., но не %s) не в состоянии повредить цель." -- Needs review
L["CLEU_DAMAGE_SPLIT_DESC"] = "Возникает, когда урон разделяется между двумя или более целями" -- Needs review
L["CLEU_DIED"] = "Смерть"
L["CLEU_ENCHANT_APPLIED"] = "Зачарование Нанесено" -- Needs review
L["CLEU_ENCHANT_APPLIED_DESC"] = "Покрывает временные энчанты оружия типа яда роги или шаманских улучшений" -- Needs review
L["CLEU_ENCHANT_REMOVED"] = "Зачарование Удалено" -- Needs review
L["CLEU_ENCHANT_REMOVED_DESC"] = "Покрывает временные энчанты оружия типа яда роги или шаманских улучшений" -- Needs review
L["CLEU_ENVIRONMENTAL_DAMAGE_DESC"] = "Включает урон от лавы, усталости, нехватки дыхания и падения" -- Needs review
L["CLEU_EVENTS"] = "События для проверки" -- Needs review
L["CLEU_EVENTS_ALL"] = "Все"
L["CLEU_EVENTS_DESC"] = "Выберите на какие события боя вы хотите, чтобы реагировала иконка." -- Needs review
L["CLEU_FLAGS_DEST"] = "Исключения" -- Needs review
L["CLEU_FLAGS_SOURCE"] = "Исключения" -- Needs review
L["CLEU_HEADER"] = "Фильтры события боя" -- Needs review
L["CLEU_PARTY_KILL"] = "Кил партии" -- Needs review
L["CLEU_RANGE_DAMAGE"] = "Урон на растоянии (дальний)" -- Needs review
L["CLEU_SOURCEUNITS_DESC"] = "Выберите цель, на которую вы хотите, чтобы реагировала иконка, |cff7fffffOR|r оставьте пустым, чтобы иконка реагировла на любое событие." -- Needs review
L["CLEU_SPELL_AURA_APPLIED"] = "Аура наложена" -- Needs review
L["CLEU_SPELL_AURA_BROKEN_SPELL_DESC"] = [=[Срабатывает если аура, обычно некоторая форма контроля, снимается уроном от заклинания.

Снятая аура это то, на что сработала иконка; снявшее заклинание можно вывести с помощью подстановки [Extra] в тестовых подсказках.]=] -- Needs review
L["CLEU_SPELL_AURA_REFRESH"] = "Аура обновлена" -- Needs review
L["CLEU_SPELL_AURA_REMOVED"] = "аура удалена"
L["CLEU_SPELL_CAST_FAILED"] = "Неудачный каст" -- Needs review
L["CLEU_SPELL_CAST_START"] = "Начало каста" -- Needs review
L["CLEU_SPELL_CAST_START_DESC"] = [=[Происходит, когда начинают произносить заклинание.

ВАЖНО: Чтобы предотвратить потенциальные злоупотребления, Blizzard исключил из этого события объект назначения, таким образом, Вы не можете это выбрать.]=] -- Needs review
L["CLEU_SPELL_DAMAGE"] = "Урон от заклинания" -- Needs review
L["CLEU_SPELL_DISPEL"] = "Рассеивание залинания" -- Needs review
L["CLEU_SPELL_DISPEL_DESC"] = [=[Срабатывает если аура снимается рассеиванием.

Иконка может зависеть от рассеянной ауры. Рассеевшее заклинание можно вывести с помощью подстановки [Extra] в тестовых подсказках.]=] -- Needs review
L["CLEU_SPELL_DISPEL_FAILED"] = "Рассеивание не удалось" -- Needs review
L["CLEU_SPELL_DISPEL_FAILED_DESC"] = [=[Срабатывает если ауру не удается снять рассеиванием.

Иконка может зависеть от ауры, которую пытались рассеять. Неудавшееся рассеивающее заклинание можно вывести с помощью подстановки [Extra] в тестовых подсказках.
]=] -- Needs review
L["CLEU_SPELL_DRAIN_DESC"] = "Срабатывает если параметры (здоровье/мана/ярость/энергия/итд) потеряны объектом." -- Needs review
L["CLEU_SPELL_ENERGIZE_DESC"] = "Срабатывает если параметры (здоровье/мана/ярость/энергия/итд) получены объектом." -- Needs review
L["CLEU_SPELL_EXTRA_ATTACKS"] = "Получен дополнительный урон" -- Needs review
L["CLEU_SPELL_EXTRA_ATTACKS_DESC"] = "Срабатывает если прок дал дополнительный удар в ближнем бою." -- Needs review
L["CLEU_SPELL_HEAL"] = "Лечение"
L["CLEU_SPELL_INSTAKILL"] = "Мгновенное убийство"
L["CLEU_SPELL_INTERRUPT"] = "Прерывание - Заклинание прервано"
L["CLEU_SPELL_INTERRUPT_DESC"] = [=[Срабатывает если заклинание прерывается.

Иконка может зависеть от прерванного заклинания. Прерывающее заклинание можно вывести с помощью подстановки [Extra] в тестовых подсказках.

Понимайте разницу между двумя различными событиями прерывания - оба всегда будут срабатывать, если заклинание прервано, но каждый отбирает использованные заклинания отдельно.
]=] -- Needs review
L["CLEU_SPELL_INTERRUPT_SPELL"] = "Прерывание - прерывание используемого заклинания" -- Needs review
L["CLEU_SPELL_INTERRUPT_SPELL_DESC"] = [=[Происходит, если произнесение заклинания прервано.

Иконка может быть отфильтрована заклинанием, которое вызвало прерывание. К заклинанию, которое было прервано, можно получить доступ с подстановкой [Extra] в текстовых подсказках.

Отметьте различие между двумя событиями прерывания - оба всегда будут происходить, если заклинание будет прервано, но каждое выбирает свои заклинания по-разному.]=] -- Needs review
L["CLEU_SPELL_LEECH"] = "Уменьшение значений параметров" -- Needs review
L["CLEU_SPELL_LEECH_DESC"] = "Срабатывает если параметры (здоровье/мана/ярость/энергия/итд) потеряны одним объектом и, одновременно, получены другим." -- Needs review
L["CLEU_SPELL_MISSED"] = "Промах заклинания"
L["CLEU_SPELL_PERIODIC_DAMAGE"] = "Периодический урон"
L["CLEU_SPELL_PERIODIC_HEAL"] = "Периодическое исцеление" -- Needs review
L["CLEU_SPELL_REFLECT"] = "Отражение заклинания"
L["CLEU_SPELL_REFLECT_DESC"] = [=[Срабатывает если вы отразили заклинание обратно на кастера.

Исходящий объект - это любой отразивший, объект назначения - это любой, кто отразил обратно]=] -- Needs review
L["CLEU_SPELL_STOLEN_DESC"] = [=[Происходит если баф украден, возможно посредством %s.

Иконка может быть выбрана заклинанием, которое было украдено.]=] -- Needs review
L["CLEU_TIMER"] = "Таймер для настройки на события" -- Needs review
L["CLEU_TIMER_DESC"] = [=[Продолжительность таймера в секундах, выводится на иконке когда событие имеет место.

Вы можете также установить время действия используя формат "Заклинание: Продолжительность" в строке ввода %q, которая будет использоваться всякий раз при обработке события, использующего заклинание, которое Вы установили как фильтр.

Если  продолжительность заклинания никак не определена, или у Вас нет никаких предустановок фильтра заклинания (строка ввода чиста), то будет использоваться эта продолжительность.]=] -- Needs review
L["CLEU_UNIT_DESTROYED"] = "Объект Унечтожен" -- Needs review
L["CLEU_UNIT_DESTROYED_DESC"] = "Срабатывает если объект, такой как тотем, уничтожен." -- Needs review
L["CLEU_UNIT_DIED"] = "Объект Мертв" -- Needs review
L["CMD_OPTIONS"] = "Параметры"
L["CMD_PROFILE_INVALIDPROFILE_SPACES"] = "Подсказка: если в названии профиля есть пробелы, возьмите название в кавычки" -- Needs review
L["CNDTCAT_ATTRIBUTES_PLAYER"] = "Свойства игрока"
L["CNDTCAT_ATTRIBUTES_UNIT"] = "Свойства объекта"
L["CNDTCAT_BUFFSDEBUFFS"] = "Баффы/Дебаффы" -- Needs review
L["CNDTCAT_CURRENCIES"] = "Деньги" -- Needs review
L["CNDTCAT_FREQUENTLYUSED"] = "Часто используемый"
L["CNDTCAT_RESOURCES"] = "Ресурсы" -- Needs review
L["CNDTCAT_SPELLSABILITIES"] = "Заклинания/Предметы" -- Needs review
L["CNDTCAT_STATS"] = "Характеристики" -- Needs review
L["COLOR_COLOR"] = "Цвет" -- Needs review
L["COLOR_OVERRIDEDEFAULT"] = "Переопределить" -- Needs review
L["COMPARISON"] = "Сравнение"
L["CONDITIONALPHA"] = "Усл./треб. не соблюдено"
L["CONDITIONALPHA_DESC"] = "Эта установка будет использоваться когда условия или требования для значка не соблюдены. Эта установка игнорируется если значок уже скрыт другими установками прозрачности." -- Needs review
L["CONDITIONALPHA_METAICON"] = "Неудачные сосотояния" -- Needs review
L["CONDITIONALPHA_METAICON_DESC"] = "Эта непрозрачность будет применяться когда спадут условия." -- Needs review
L["CONDITIONORMETA_CHECKINGINVALID"] = "Внимание! Группа %d, Иконка %d проверяет неправильную иконку (Группа %d, Иконка %d)" -- Needs review
L["CONDITIONORMETA_CHECKINGINVALID_GROUP"] = "Внимание! В группе %d проверяется неправильный значок (группа %d, значок %d)" -- Needs review
L["CONDITIONPANEL_ADD"] = "Добавить условие" -- Needs review
L["CONDITIONPANEL_ALIVE"] = "Цель жива"
L["CONDITIONPANEL_ALIVE_DESC"] = "Это условие исполняется если указанная цель жива."
L["CONDITIONPANEL_ALTPOWER"] = "Альтернативный ресурс" -- Needs review
L["CONDITIONPANEL_AND"] = "и"
L["CONDITIONPANEL_ANDOR"] = "и/или"
L["CONDITIONPANEL_ANDOR_DESC"] = "Нажмите для переключения между операторами И/ИЛИ"
L["CONDITIONPANEL_BLIZZEQUIPSET"] = "Набор вещей надет" -- Needs review
L["CONDITIONPANEL_BLIZZEQUIPSET_INPUT"] = "Наименование набора вещей" -- Needs review
L["CONDITIONPANEL_CLASS"] = "Класс объекта"
L["CONDITIONPANEL_CLASSIFICATION"] = "Тип объекта"
L["CONDITIONPANEL_COMBAT"] = "Объект в бою"
L["CONDITIONPANEL_COMBO"] = "Длина серии приемов"
L["CONDITIONPANEL_DEFAULT"] = "Выберите тип ..."
L["CONDITIONPANEL_ECLIPSE_DESC"] = [=[Затмение друида имеет диапазон от -100 (лунное затмение) до 100 (солнечное затмение).
Введите -80 если вы хотите чтобы значок сработал  при значении лунной силы равной 80.]=]
L["CONDITIONPANEL_EQUALS"] = "равно"
L["CONDITIONPANEL_EXISTS"] = "Цель существует"
L["CONDITIONPANEL_GREATER"] = "Больше"
L["CONDITIONPANEL_GREATEREQUAL"] = "Больше или равно"
L["CONDITIONPANEL_GROUPTYPE"] = "Тип группы" -- Needs review
L["CONDITIONPANEL_ICON"] = "Показать значок"
L["CONDITIONPANEL_ICON_DESC"] = [=[Проверка условий работает только если прозрачность иконки больше 0. 
Если необходимо скрыть значок, но при этом вести проверку условий, установите параметр %q в настройках прозрачности значка.
Для проверки условий значка группа в которой он находится также должна отбражаться.]=] -- Needs review
L["CONDITIONPANEL_ICON_HIDDEN"] = "Скрыт" -- Needs review
L["CONDITIONPANEL_ICONHIDDENTIME"] = "Иконка невидимого времени" -- Needs review
L["CONDITIONPANEL_ICON_SHOWN"] = "Отображается"
L["CONDITIONPANEL_ICONSHOWNTIME"] = "Иконка отображаемого времени" -- Needs review
L["CONDITIONPANEL_INSTANCETYPE"] = "Тип подземелья"
L["CONDITIONPANEL_INTERRUPTIBLE"] = "Можно прервать" -- Needs review
L["CONDITIONPANEL_LESS"] = "Меньше"
L["CONDITIONPANEL_LESSEQUAL"] = "Меньше или равно"
L["CONDITIONPANEL_LEVEL"] = "Уровень объекта"
L["CONDITIONPANEL_MOUNTED"] = "На транспорте"
L["CONDITIONPANEL_NAME"] = "Название объекта"
L["CONDITIONPANEL_NAMETOMATCH"] = "Имя равно" -- Needs review
L["CONDITIONPANEL_NAMETOOLTIP"] = "Вы можете указать несколько имен для проверки разделив их точкой с запятой (;). Условие считается выполненным если совпало хотя одно имя." -- Needs review
L["CONDITIONPANEL_NOTEQUAL"] = "Не равно"
L["CONDITIONPANEL_OPERATOR"] = "Оператор"
L["CONDITIONPANEL_OR"] = "Или"
L["CONDITIONPANEL_PETSPEC"] = "специализация питомца" -- Needs review
L["CONDITIONPANEL_PETTREE"] = "Дерево талантов питомца" -- Needs review
L["CONDITIONPANEL_POWER"] = "Основной ресурс"
L["CONDITIONPANEL_POWER_DESC"] = [=[Будет проверять энергию, если цель - друид в форме кошки, 
ярость - если цель воин, и т.д.]=]
L["CONDITIONPANEL_PVPFLAG"] = "Объект с меткой PvP"
L["CONDITIONPANEL_REMOVE"] = "Удалить это условие"
L["CONDITIONPANEL_RESTING"] = "Отдыхает" -- Needs review
L["CONDITIONPANEL_ROLE"] = "Роль игорка" -- Needs review
L["CONDITIONPANEL_SWIMMING"] = "Плавание"
L["CONDITIONPANEL_TYPE"] = "Тип"
L["CONDITIONPANEL_UNIT"] = "Объект" -- Needs review
L["CONDITIONPANEL_UNITISUNIT"] = "Объект равен" -- Needs review
L["CONDITIONPANEL_UNITISUNIT_DESC"] = "Это условие выполнено если объект в первом поле ввода совпадает с объектом во втором поле ввода." -- Needs review
L["CONDITIONPANEL_UNITISUNIT_EBDESC"] = "Введите объект для сравнения с объектом в первом поле ввода." -- Needs review
L["CONDITIONPANEL_VALUEN"] = "Значение"
L["CONDITIONPANEL_VEHICLE"] = "Объект на сред. передвижения"
L["CONDITIONS"] = "Условия" -- Needs review
L["CONDITION_TIMERS_HEADER"] = "Таймеры"
L["CONFIGMODE"] = "TellMeWhen в режиме настройки. Значки не будут работать до выхода из режима настройки. Наберите /tmw для включения/выключения режима настройки." -- Needs review
L["CONFIGMODE_EXIT"] = "Выйти из режима настройки"
L["CONFIGMODE_NEVERSHOW"] = "Больше не показывать"
L["CONFIGPANEL_CLEU_HEADER"] = "Боевые события" -- Needs review
L["COPYGROUP"] = "Копировать всю группу"
L["COPYPOSSCALE"] = "Копировать расположение/масштаб"
L["CREATURETYPE_1"] = "Животное"
L["CREATURETYPE_10"] = "Не указано"
L["CREATURETYPE_11"] = "Тотем"
L["CREATURETYPE_12"] = "Спутник"
L["CREATURETYPE_13"] = "Облако газа"
L["CREATURETYPE_14"] = "Дикий питомец"
L["CREATURETYPE_2"] = "Дракон"
L["CREATURETYPE_3"] = "Демон"
L["CREATURETYPE_4"] = "Элементаль"
L["CREATURETYPE_5"] = "Великан"
L["CREATURETYPE_6"] = "Нежить"
L["CREATURETYPE_7"] = "Гуманоид"
L["CREATURETYPE_8"] = "Существо"
L["CREATURETYPE_9"] = "Механизм"
L["CrowdControl"] = "Контроль"
L["Curse"] = "Проклятье"
L["DamageBuffs"] = "Наносящие урон баффы" -- Needs review
L["DAMAGER"] = "Урон" -- Needs review
L["DEBUFFTOCHECK"] = "Дебафф для проверки" -- Needs review
L["DEFAULT"] = "По умолчанию" -- Needs review
L["DefensiveBuffs"] = "Защитные баффы" -- Needs review
L["DESCENDING"] = "Нисходящий" -- Needs review
L["DISABLED"] = "Отключено"
L["Disarmed"] = "Обезоружен"
L["Disease"] = "Болезнь"
L["Disoriented"] = "Дезориентация"
L["DR-Banish"] = "Изгнание" -- Needs review
L["DR-Cyclone"] = "Смерч" -- Needs review
L["DR-Disarm"] = "Обезоруживание" -- Needs review
L["DR-Disorient"] = "Ослепление" -- Needs review
L["DR-DragonsBreath"] = "Дыхание дракона" -- Needs review
L["DR-Entrapment"] = "На изготовку!" -- Needs review
L["DR-MindControl"] = "Контроль над разумом" -- Needs review
L["DT_DOC_Opacity"] = "Возвращает непрозрачность значка. Возвращаемое значение между 0 и 1." -- Needs review
L["DURATION"] = "Продолжительность" -- Needs review
L["DURATIONPERC"] = "Длительность процента" -- Needs review
L["EARTH"] = "Земля" -- Needs review
L["ECLIPSE_DIRECTION"] = "Направление затмения"
L["elite"] = "Элитный" -- Needs review
L["ENABLINGOPT"] = "Дополнение TellMeWhen_Options отключено. Включаю ..."
L["Enraged"] = "Энрейдж" -- Needs review
L["ERROR_MISSINGFILE"] = "Для использования TellMeWhen %s необходима перезагрузка WoW (%s не найден). Перезагрузить WoW сейчас?" -- Needs review
L["ERROR_MISSINGFILE_NOREQ"] = [=[Может понадобиться полный перезапуск игры, чтобы использовать TellMeWhen %s:

%s не найден.

Хотите перезапустить WoW сейчас?]=] -- Needs review
L["ERROR_NOTLOADED_ERROR"] = "TellMeWhen не удалось загрузить! Не нашлись необходимые библиотеки?" -- Needs review
L["EVENTS_INSTRUCTIONS"] = [=[В этой закладке вы можете настроить дополнительный функционал иконки: звуки, анимация, текст.

Все эти эффекты включаются событием, которые вы выбираете.Большинство событий включаются изменением статуса иконки, но также есть и другие возможные события.

Для начала настройки этих эффектов нажмите на кнопку слева и выберите комбинацию события и эффекта.

Затем появятся настройки события и эффекта для дальнейшей конфигурации.]=] -- Needs review
L["EVENTS_SETTINGS_CNDTJUSTPASSED"] = "И это только что начало происходить" -- Needs review
L["EVENTS_SETTINGS_CNDTJUSTPASSED_DESC"] = "Препятствует тому, чтобы событие было обработано, если состояние, сформулированное выше, только что не начало происходить." -- Needs review
L["EVENTS_SETTINGS_HEADER"] = "Настройки события"
L["EVENTS_SETTINGS_ONLYSHOWN"] = "Обрабатывать только если значок отображается"
L["EVENTS_SETTINGS_ONLYSHOWN_DESC"] = "Препятствует обработке события если иконка не показана" -- Needs review
L["EVENTS_SETTINGS_PASSINGCNDT"] = "Обрабатывается только если условие проходит" -- Needs review
L["EVENTS_SETTINGS_PASSINGCNDT_DESC"] = "Предотвращает обработку события пока нижележащее условие не будет выполнено" -- Needs review
L["EVENTS_SETTINGS_PASSTHROUGH"] = "Продолжайте для нижележащих событий" -- Needs review
L["EXPORT_f"] = "Экспорт %s"
L["EXPORT_HEADING"] = "Экспорт"
L["EXPORT_TOCOMM"] = "Игроку"
L["EXPORT_TOCOMM_DESC"] = [=[Введите имя игрока в поле и выберите эту опцию чтобы переслать ему настройки. Игрок должен быть доступен для команды /whisper (та же фракция и сервер что и вы, быть в онлайне) и обладать TellMeWhen версии 4.0.0 и выше.
Также Вы можете ввести "GUILD" или "RAID" (внимание на регистр) для посылке всей сваей гильдии или рейду.]=] -- Needs review
L["EXPORT_TOGUILD"] = "в Гильдию"
L["EXPORT_TORAID"] = "в рейд"
L["EXPORT_TOSTRING"] = "В строку"
L["EXPORT_TOSTRING_DESC"] = "Строка, содержащая настройки, которые впоследствии можно будет ввести в поле ввода. Чтобы ее скопировать нажмите Ctrl+C, после чего строку можно вставить туда, куда пожелаете." -- Needs review
L["FALSE"] = "Неверно"
L["Feared"] = "Страх"
L["fGROUP"] = "Группа: %s"
L["fICON"] = "Значок: %s"
L["FIRE"] = "Огонь" -- Needs review
L["FONTCOLOR"] = "Цвет шрифта" -- Needs review
L["FONTSIZE"] = "Размер шрифта" -- Needs review
L["FORWARDS_IE"] = "вперед"
L["FORWARDS_IE_DESC"] = "Загрузить следующую иконку, которая была отредактирована (%s |T%s:0|t)." -- Needs review
L["fPROFILE"] = "Профиль: %s" -- Needs review
L["FROMNEWERVERSION"] = "Вы импортируете данные созданные в более новой версии TellMeWhen. Некоторые установки не будут работать пока вы не обновите TellMeWhen до последней версии." -- Needs review
L["fTEXTLAYOUT"] = "Расположение текста: %s" -- Needs review
L["GCD"] = "Глобальная перезарядка" -- Needs review
L["GCD_ACTIVE"] = "GCD активен" -- Needs review
L["GENERIC_NUMREQ_CHECK_DESC"] = "Установите эту опцию чтобы включить и настроить %s" -- Needs review
L["GENERICTOTEM"] = "тотем %d" -- Needs review
L["GROUPADDONSETTINGS"] = "Настройки группы/модификации"
L["GROUPCONDITIONS"] = "Усл. группы"
L["GROUPICON"] = "Группа: %s, значок: %d"
L["HEALER"] = "Лекарь" -- Needs review
L["Heals"] = "Исцеления игрока"
L["HELP_EXPORT_DOCOPY_MAC"] = "Нажми |cff7fffffCMD+C|r , чтобы скопировать" -- Needs review
L["HELP_EXPORT_DOCOPY_WIN"] = "Нажми |cff7fffffCTRL+C|r , чтобы скопировать" -- Needs review
L["HELP_MS_NOFOUND"] = [=[Способность %q не найдена на вашей панели управления.
Убедитесь, что эта способность находится на вашей панели управления по умолчанию, и что она не является макросом, который помещает заклинание на панель управления. В противном случае, этот значок не будет работать корректно.  ]=] -- Needs review
L["HELP_NOUNIT"] = "Добавьте объект!"
L["HELP_NOUNITS"] = "Нужно добавить хотя бы один объект!"
L["HELP_POCKETWATCH"] = [=[|TInterface\Icons\INV_Misc_PocketWatch_01:20|t - Значок часов.
Этот значок отображается когда заклинание проверяемое по имени отсутствует в вашей книге заклинаний.
Для отображения правильного значка измените имя заклинания на Spell ID (нажмите ЛКМ на имени в поле ввода, выберите правильное заклинание в списке подсказок и нажмите на нем ПКМ)
]=] -- Needs review
L["ICON"] = "Значок"
L["ICONALPHAPANEL_FAKEHIDDEN"] = "Всегда скрывать"
L["ICONALPHAPANEL_FAKEHIDDEN_DESC"] = "Скрывает значок, оставляя его активным, что позволяет условиям других значков использовать его." -- Needs review
L["ICONGROUP"] = "Значок: %s (группа: %s)"
L["ICONMENU_ABSENT"] = "Отсутствует"
L["ICONMENU_ADDMETA"] = "Добавить к мета-значку" -- Needs review
L["ICONMENU_ALPHA"] = "Непрозрачность" -- Needs review
L["ICONMENU_BOTH"] = "Любой"
L["ICONMENU_BUFF"] = "Баф"
L["ICONMENU_BUFFDEBUFF"] = "Баф/Дебаф"
L["ICONMENU_BUFFDEBUFF_DESC"] = "Отслеживает баффы и/или дебаффы." -- Needs review
L["ICONMENU_BUFFTYPE"] = "Баф или дебаф?" -- Needs review
L["ICONMENU_CAST"] = "Применение"
L["ICONMENU_CAST_DESC"] = "Отслеживает касты и поддержания заклинаний." -- Needs review
L["ICONMENU_CASTS"] = "Применение заклинаний"
L["ICONMENU_CASTSHOWWHEN"] = "Показать когда каст" -- Needs review
L["ICONMENU_CHOOSENAME_ITEMSLOT_DESC"] = [=[Введите название, ID или ячейку снаряжения того, что Вы хотите отслеживать на этой иконке. Можно добавить несколько названий (любые комбинации имен, ID или ячеек снаряжения), разделяя их ';'.
Ячейки снаряжения - это номера соответствующие предметам надетым на персонаже (голова, шея и т.д.). При изменении предмета в ячейке снаряжения соответствующее изменение произойдет и в значке.
Shift+ЛКМ введет предметы и текст  или  перетащите их мышью для ввода их в это поле.]=] -- Needs review
L["ICONMENU_CHOOSENAME_MULTISTATE"] = "Выберите заклинание для проверки" -- Needs review
L["ICONMENU_CHOOSENAME_ORBLANK"] = "или оставьте пустым чтобы отслеживать всё" -- Needs review
L["ICONMENU_CHOOSENAME_WPNENCH"] = "Выберите улучшение для проверки" -- Needs review
L["ICONMENU_CHOOSENAME_WPNENCH_DESC"] = [=[Введите название(я) оружейных энчантов для отслеживания их этой иконкой. Можете добавить несколько названий отделяя их (;).
|cFFFF5959ВАЖНО|r: название энчанта должно быть введено точно так, как оно всплывает в подсказке вашего оружия когда энчант активирован (т.е. "%s", а не "%s").
]=] -- Needs review
L["ICONMENU_CHOSEICONTOEDIT"] = "Выберите иконку для редактирования:" -- Needs review
L["ICONMENU_CLEU"] = "Боевое событие"
L["ICONMENU_CLEU_DESC"] = [=[Отслеживает события боя.

Примеры включают промахи спеллов, инстант касты, смерти, но иконка может отслеживать почти что угодно.]=] -- Needs review
L["ICONMENU_CNDTIC"] = "Значок-условие" -- Needs review
L["ICONMENU_CNDTIC_DESC"] = "Отслеживает состояние условий."
L["ICONMENU_COMPONENTICONS"] = "Составные значки" -- Needs review
L["ICONMENU_COOLDOWNCHECK"] = "Проверять восстановление?"
L["ICONMENU_COOLDOWNCHECK_DESC"] = "Включить изменение цвета иконки, когда контратакующая способность на восстановлении"
L["ICONMENU_COPYHERE"] = "Копировать сюда"
L["ICONMENU_COUNTING"] = "Таймер работает" -- Needs review
L["ICONMENU_COUNTING_DESC"] = "Показывать иконки, когда её таймер активен." -- Needs review
L["ICONMENU_CUSTOMTEX"] = "Пользовательская текстура"
L["ICONMENU_CUSTOMTEX_DESC"] = [=[Если Вы хотите заменить текстуру этой иконки, введите Название или ID заклинания, которое имеет нужную текстуру.
Вы можете ввести путь по которому находится ваша текстура, пример: "Interface/Icons/123.tga", где "123.tga" - имя файла с текстурой, "Interface/Icons/" - путь к ней.
Вы можете просмотреть список динамических текстур, введя "$" (dollar sign; ALT-36).
Вы можете использовать свои текстуры до тех пор, пока они находятся в каталоге в WoW, имеют формат .TGA и .BLP, имеют размер степени числа 2 (32, 64, 128, etc).]=] -- Needs review
L["ICONMENU_DEBUFF"] = "Дебаф"
L["ICONMENU_DISPEL"] = "Тип развеивания"
L["ICONMENU_DONTREFRESH"] = "Не обновлять" -- Needs review
L["ICONMENU_DURATION_MAX_DESC"] = "Максимальный срок действия для отображения иконки"
L["ICONMENU_DURATION_MIN_DESC"] = "Минимальная срок действия для отображения иконки"
L["ICONMENU_ENABLE"] = "Включено"
L["ICONMENU_FAKEMAX_DESC"] = [=[Эта настройка используется для того, чтобы вся группа иконок затухала с одинаковой скоростью, что даёт визуальную индикацию, какие таймеры истекают первыми.

Установите в 0 для отключения.]=] -- Needs review
L["ICONMENU_FOCUS"] = [=[Фокус
]=]
L["ICONMENU_FOCUSTARGET"] = "Цель фокуса"
L["ICONMENU_FRIEND"] = "Дружественный"
L["ICONMENU_GHOUL"] = "Не-ПВ вурдалак" -- Needs review
L["ICONMENU_GHOUL_DESC"] = "Отслеживает вашего вурдалака если у вас нет таланта %s." -- Needs review
L["ICONMENU_HIDEUNEQUIPPED"] = "Спрятать, когда слот свободен"
L["ICONMENU_HIDEUNEQUIPPED_DESC"] = "При установке этой опции значок будет скрыт если проверяемый слот оружия пуст" -- Needs review
L["ICONMENU_HOSTILE"] = "Враждебный"
L["ICONMENU_ICD"] = "Внутренний кулдаун"
L["ICONMENU_ICDBDE"] = "Баф/Дебаф/Урон/Энергия/Призыв" -- Needs review
L["ICONMENU_ICD_DESC"] = "Отслеживает время восстановления проков или др. подобных эффектов" -- Needs review
L["ICONMENU_ICDTYPE"] = "Срабатывает от" -- Needs review
L["ICONMENU_IGNORENOMANA"] = "Игнорировать нехватку энергии" -- Needs review
L["ICONMENU_IGNORERUNES"] = "Игнорирование рун"
L["ICONMENU_IGNORERUNES_DESC"] = "Отметьте для того, чтобы считать КД готовым, если единственное, что его блокирует - КД на руну или ГКД." -- Needs review
L["ICONMENU_IGNORERUNES_DESC_DISABLED"] = "Для включения опции \"Игнорировать руны\" необходимо включить опцию \"Проверять восстановление\"" -- Needs review
L["ICONMENU_INVERTBARDISPLAYBAR_DESC"] = "Отметьте для того, чтобы полоска заполнялась полностью по истечении времени." -- Needs review
L["ICONMENU_INVERTBARS"] = "Заполнение полосок вверх"
L["ICONMENU_ITEMCOOLDOWN"] = "Кулдаун предмета" -- Needs review
L["ICONMENU_ITEMCOOLDOWN_DESC"] = "Отслеживает восстановление предметов."
L["ICONMENU_MANACHECK"] = "Проверять энергию?"
L["ICONMENU_MANACHECK_DESC"] = "Включить изменение цвета иконки при недостатке маны/ярости/рунической силы/и т.д."
L["ICONMENU_META"] = "Мета-значок"
L["ICONMENU_META_DESC"] = [=[Объединяет несколько значков в один.
Значки у которых установлено %q будут отображаться в мета-значке так же, как если бы они отображались самостоятельно.]=]
L["ICONMENU_MOUSEOVER"] = "Курсор мыши над"
L["ICONMENU_MOUSEOVERTARGET"] = "Цель под курсором мыши"
L["ICONMENU_MOVEHERE"] = "Переместить сюда"
L["ICONMENU_MULTISTATECD"] = "Умение с несколькими состояниями" -- Needs review
L["ICONMENU_MULTISTATECD_DESC"] = [=[Отслеживает абилку со множеством условий.

 Используется для отслеживания множества условий и характеров таких кулдаунов как %s или %s.]=] -- Needs review
L["ICONMENU_MUSHROOMS_DESC"] = "Отслеживает %s." -- Needs review
L["ICONMENU_NOTCOUNTING"] = "Таймер не запущен" -- Needs review
L["ICONMENU_NOTCOUNTING_DESC"] = "Показывать иконки, когда её таймер неактивен." -- Needs review
L["ICONMENU_OFFS"] = "Отступ" -- Needs review
L["ICONMENU_ONLYBAGS"] = "Только если в сумках" -- Needs review
L["ICONMENU_ONLYEQPPD"] = "Только если одето"
L["ICONMENU_ONLYEQPPD_DESC"] = "Установите эту опцию для отображения значка только если предмет надет на персонаже."
L["ICONMENU_ONLYIFCOUNTING"] = "Показывать только если таймер активен" -- Needs review
L["ICONMENU_ONLYINTERRUPTIBLE"] = "Только прерываемое"
L["ICONMENU_ONLYINTERRUPTIBLE_DESC"] = "Установите эту опцию для показа только прерываемых заклинаний." -- Needs review
L["ICONMENU_ONLYMINE"] = "Проверять только мое" -- Needs review
L["ICONMENU_ONLYMINE_DESC"] = "При установке этой опции значок будет проверять только ваши собственные баффы/дебаффы" -- Needs review
L["ICONMENU_PETTARGET"] = "Цель питомца"
L["ICONMENU_PRESENT"] = "Присутствует"
L["ICONMENU_RANGECHECK"] = "Проверять расстояние до объекта?"
L["ICONMENU_RANGECHECK_DESC"] = "Включить изменение цвета иконки, когда вы вне зоны досягаемости"
L["ICONMENU_REACT"] = "Реакция цели"
L["ICONMENU_REACTIVE"] = "Контратакующее заклинание или способность" -- Needs review
L["ICONMENU_RUNES"] = "Восстановление руны" -- Needs review
L["ICONMENU_RUNES_DESC"] = "Отслеживает восстановление рун."
L["ICONMENU_SHOWTIMER"] = "Показывать таймер"
L["ICONMENU_SHOWTIMER_DESC"] = "При установке этой опции на значке будет отображаться стандартная круговая анимация восстановления" -- Needs review
L["ICONMENU_SHOWTIMERTEXT"] = "Показывать значение таймера"
L["ICONMENU_SHOWTIMERTEXT_DESC"] = [=[Проверка этого параметра выводит цифровое значение остающегося кулдауна/продолжительности на ионке.
Применимо только если выбран параметр 'Показывать таймер' и установлен OmniCC (или аналог).]=] -- Needs review
L["ICONMENU_SHOWTTTEXT"] = "Показать текст переменной" -- Needs review
L["ICONMENU_SHOWWHEN"] = "Показать условия и нерозрачность" -- Needs review
L["ICONMENU_SHOWWHEN_SHOW_GENERIC_DESC"] = "Должна ли иконка показываться в данном состоянии." -- Needs review
L["ICONMENU_SHOWWHEN_SHOWWHEN_WRAP"] = "Показывать когда %s|r" -- Needs review
L["ICONMENU_SPELLCOOLDOWN"] = "Кулдаун заклинания" -- Needs review
L["ICONMENU_SPELLCOOLDOWN_DESC"] = "Отслеживает восстановление заклинаний." -- Needs review
L["ICONMENU_STACKS_MAX_DESC"] = "Максимальное количество стаков, необходимое для отображения значка" -- Needs review
L["ICONMENU_STACKS_MIN_DESC"] = "Минимальное количество стаков, необходимое для отображения значка" -- Needs review
L["ICONMENU_SWAPWITH"] = "Обменять с" -- Needs review
L["ICONMENU_TARGETTARGET"] = "Цель цели"
L["ICONMENU_TOTEM"] = "Тотем" -- Needs review
L["ICONMENU_TOTEM_DESC"] = "Отслеживает ваши тотемы." -- Needs review
L["ICONMENU_TYPE"] = "Тип иконки"
L["ICONMENU_UNITCOOLDOWN"] = "Восстановление объекта"
L["ICONMENU_UNITCOOLDOWN_DESC"] = [=[Отслеживает время восстановления заклинания, предмета и т.д. у другого объекта.
%s можно отслеживать используя %q в качестве имени.]=] -- Needs review
L["ICONMENU_UNIT_DESC"] = [=[Введите название объекта для отслеживания. Объекты могут быть выбраны из выпадающего списка справа или добавлены вручную. Могут быть использованы стандартные имена (например, player) или имена дружественных объектов (например, %s). Множественные имена объектов должны быть разделены точкой с запятой (;).
Для большей информации о объектах посетите http://www.wowpedia.org/UnitId]=] -- Needs review
L["ICONMENU_UNITS"] = "Объекты"
L["ICONMENU_UNITSTOWATCH"] = "Наблюдаемый объект"
L["ICONMENU_UNUSABLE"] = "Недоступно"
L["ICONMENU_USABLE"] = "Доступно"
L["ICONMENU_VEHICLE"] = "Средство передвижения"
L["ICONMENU_WPNENCHANT"] = "Чары на оружии" -- Needs review
L["ICONMENU_WPNENCHANT_DESC"] = "Отслеживает временные улучшения на оружии" -- Needs review
L["ICONMENU_WPNENCHANTTYPE"] = " Для отслеживания слота оружия" -- Needs review
L["IconModule_SelfIcon"] = "Иконка" -- Needs review
L["IconModule_Texture_ColoredTexture"] = "текстура" -- Needs review
L["ICONTOCHECK"] = "Значок для проверки"
L["ICON_TOOLTIP2NEW"] = [=[|cff7fffffПКМ|r для свойств значка.
|cff7fffffПКМ и тащите|r на другой значок для перемещения/копирования.
|cff7fffffТащите|r заклинание или предмет на значок для быстрого назначения свойств.]=] -- Needs review
L["ICON_TOOLTIP2NEWSHORT"] = "|cff7fffffПКМ|r для выбора опций иконки" -- Needs review
L["ImmuneToMagicCC"] = "Невосприимчивость к контролю"
L["ImmuneToStun"] = "Невосприимчивость к эффектам оглушения"
L["IMPORTERROR_FAILEDPARSE"] = "При обработке строки произошла ошибка. Убедитесь что вы полностью скопировали строку из источника." -- Needs review
L["IMPORT_EXPORT"] = "Импорт/Экспорт/Восстановление" -- Needs review
L["IMPORT_EXPORT_BUTTON_DESC"] = "Нажмите на этот список для импорта/экспорта значков, групп и профилей." -- Needs review
L["IMPORT_EXPORT_DESC"] = [=[Нажмите на стрелку выпадающего меню справа от поля ввода чтобы импортировать/экспортировать значки, группы и профили.
Импорт в или из строки, или экспорт другому игроку потребует использование этой сторки ввода. Для детального понимания просмотрите подсказку из выпадающего меню. ]=] -- Needs review
L["IMPORT_EXPORT_DESC_INLINE"] = "Импорт/экспорт профилей, групп и значков в или из строк, других игроков, других профилей или из сохраненных настроек." -- Needs review
L["IMPORT_FROMBACKUP"] = "Из архива"
L["IMPORT_FROMBACKUP_DESC"] = "Настройки, восстановленные из этого меню будут таими, какими были на: %s" -- Needs review
L["IMPORT_FROMBACKUP_WARNING"] = "Архив настроек: %s"
L["IMPORT_FROMCOMM"] = "От игрока"
L["IMPORT_FROMCOMM_DESC"] = "Если другой пользователь поделится с вами своими настройками, вы сможете импортировать их в этом меню."
L["IMPORT_FROMLOCAL"] = "Из профиля"
L["IMPORT_FROMSTRING"] = "Из строки"
L["IMPORT_FROMSTRING_DESC"] = [=[Строки позволяют пользователям обмениваться настройками TellMeWhen.
Для импорта настроек из строки скопируйте ее в буфер обмена (Ctrl+C), нажмите Ctrl+V находясь в поле ввода, после чего вернитесь в это меню. ]=]
L["IMPORT_HEADING"] = "Импорт настроек"
L["IMPORT_PROFILE"] = "Копировать профиль"
L["IMPORT_PROFILE_NEW"] = "Создать новый профиль"
L["IMPORT_PROFILE_OVERWRITE"] = "Переписать %s"
L["Incapacitated"] = "Обездвижен"
L["IncreasedAP"] = "+ к сила атаки"
L["IncreasedCrit"] = "+ к вероятности нанесения критического урона"
L["IncreasedPhysHaste"] = "+ к скорости ближнего и дальнего боя"
L["IncreasedSpellHaste"] = "+ к скорости произнесения заклинаний"
L["IncreasedSPsix"] = "+ к силе заклинаний (6%)"
L["IncreasedSPten"] = "+ к силе заклинаний (10%)"
L["IncreasedStats"] = "+ к характеристикам"
L["ITEMCOOLDOWN"] = "Восстановление предмета" -- Needs review
L["ITEMEQUIPPED"] = "Предмет надет" -- Needs review
L["ITEMTOCHECK"] = "Предмет для проверки" -- Needs review
L["LAYOUTDIRECTION"] = "Установка Направления" -- Needs review
L["LAYOUTDIRECTION_1"] = "Вправо потом вниз" -- Needs review
L["LAYOUTDIRECTION_2"] = "Влево потом вниз" -- Needs review
L["LAYOUTDIRECTION_3"] = "Влево потом вверх" -- Needs review
L["LAYOUTDIRECTION_4"] = "Вправо потом вверх" -- Needs review
L["LAYOUTDIRECTION_5"] = "Вниз потом вправо" -- Needs review
L["LAYOUTDIRECTION_6"] = "Вниз потом влево" -- Needs review
L["LAYOUTDIRECTION_7"] = "Вверх потом влево" -- Needs review
L["LAYOUTDIRECTION_8"] = "Вверх потом вправо" -- Needs review
L["LAYOUTDIRECTION_DESC"] = "Установка направления, по которому иконки будут расположены в группе" -- Needs review
L["LDB_TOOLTIP1"] = "|cff7fffffЩелкните мышью|r для переключения блокировки групп"
L["LDB_TOOLTIP2"] = "|cff7fffffЩелкните ПКМ|r для того чтобы показать/скрыть указанные группы"
L["LEFT"] = "Влево"
L["LOADERROR"] = "Дополнение TellMeWhen_Options не может быть загружено:" -- Needs review
L["LOCKED"] = "Закреплено"
L["Magic"] = "Магия"
L["MAIN"] = "Основное"
L["!!Main Addon Description"] = "Визуальные, звуковые и текстовые оповещения о готовности заклинаний, способностей, наличии баффов/дебаффов и многого другого." -- Needs review
L["MAINASSIST"] = "Главный помощник" -- Needs review
L["MAINTANK"] = "Осн. танк" -- Needs review
L["MAKENEWGROUP"] = "Создать новую группу"
L["MELEECRIT"] = "Крит в ближнем бою" -- Needs review
L["MELEEHASTE"] = "Скорость ближнего боя" -- Needs review
L["MESSAGERECIEVE"] = "%s прислал(а) вам строку данных TellMeWhen. Вы можете импортировать эти данные в TellMeWhen используя выпадающий список %q в редакторе значков." -- Needs review
L["MESSAGERECIEVE_SHORT"] = "%s прислал(а) вам строку данных TellMeWhen!" -- Needs review
L["META_ADDICON"] = "добавить иконку" -- Needs review
L["METAPANEL_DOWN"] = "Сместить вниз"
L["METAPANEL_REMOVE"] = "Удалить эту иконку"
L["METAPANEL_UP"] = "Сместить вверх"
L["MISCELLANEOUS"] = "Разное" -- Needs review
L["MiscHelpfulBuffs"] = "Разные полезные баффы" -- Needs review
L["MOON"] = "Луна"
L["MP5"] = "%d MP5" -- Needs review
L["MUSHROOM"] = "Гриб %d" -- Needs review
L["MUSHROOMS"] = "Гриб для проверки" -- Needs review
L["NEWVERSION"] = "Доступна новая версия TellMeWhen: %s" -- Needs review
L["NONE"] = "Ничего из нижеперечисленного"
L["normal"] = "Обычный" -- Needs review
L["ONLYCHECKMINE"] = "Проверять только мои" -- Needs review
L["ONLYCHECKMINE_DESC"] = "Установите эту опцию для проверки только своих бафов/дебафов" -- Needs review
L["OUTLINE_MONOCHORME"] = "Черно-белый"
L["OUTLINE_NO"] = "Без контура"
L["OUTLINE_THICK"] = "Толстый контур"
L["OUTLINE_THIN"] = "Тонкий контур"
L["OVERWRITEGROUP"] = "Перезаписать группу: %s"
L["PARENTHESIS_TYPE_("] = "открывающая" -- Needs review
L["PARENTHESIS_TYPE_)"] = "закрывающая" -- Needs review
L["PARENTHESIS_WARNING1"] = [=[Число открывающих и закрывающих скобок не совпадает.
Необходимо еще %d %s |4скобка:скобок;]=] -- Needs review
L["PARENTHESIS_WARNING2"] = [=[Недостаточно открывающих скобок!
Необходимо на %d больше открывающих скобок]=] -- Needs review
L["PERCENTAGE"] = "Процент" -- Needs review
L["PET_TYPE_CUNNING"] = "Хитрость" -- Needs review
L["PET_TYPE_FEROCITY"] = "Свирепость" -- Needs review
L["PET_TYPE_TENACITY"] = "Упорство" -- Needs review
L["PhysicalDmgTaken"] = "Увеличивает получаемый физический урон"
L["PLAYER_DESC"] = "(Вы)"
L["Poison"] = "Яд"
L["PRESENCE"] = "Власть" -- Needs review
L["PvPSpells"] = "Масс контроль в PvP, и т.д." -- Needs review
L["RANGEDCRIT"] = "Крит дальнего боя" -- Needs review
L["RANGEDHASTE"] = "Скорость дальнего боя" -- Needs review
L["rare"] = "Редкий" -- Needs review
L["rareelite"] = "Редкий Элитный" -- Needs review
L["REDO_ICON"] = "Повторить" -- Needs review
L["REDO_ICON_DESC"] = "Повторить последнее изменение установок для этого значка. " -- Needs review
L["ReducedArmor"] = "Снижение показателя брони"
L["ReducedCastingSpeed"] = "Снижение скорости произнесения заклинаний"
L["ReducedHealing"] = "Снижение эффективности исцеления"
L["ReducedPhysicalDone"] = "Снижение наносимого физического урона"
L["RESET_ICON"] = "Сброс" -- Needs review
L["RESIZE"] = "Изменить размер"
L["RESIZE_TOOLTIP"] = "Чтобы изменить размер, нажмите и тащите "
L["RIGHT"] = "Вправа"
L["Rooted"] = "Корни"
L["RUNES"] = "Проверить руны" -- Needs review
L["RUNSPEED"] = "Скорость бега объекта" -- Needs review
L["SENDSUCCESSFUL"] = "Отправлено успешно" -- Needs review
L["SHAPESHIFT"] = "Изменение облика" -- Needs review
L["Shatterable"] = "Разбиваемо"
L["Silenced"] = "Немота"
L["Slowed"] = "Замедлен"
L["SOUND_CUSTOM"] = "Пользовательский звуковой файл"
L["SOUND_CUSTOM_DESC"] = [=[Укажите путь к пользовательскому звуковому файлу. Приведем несколько примеров (здесь "file' - это имя звукового файла, "ext" - его расширение (поддерживаются только ogg и mp3)):
- "CustomSounds\file.ext" - файл находится в папке CustomSounds которая размещена в корневой папке WoW (папке в которой находятся файл WoW.exe, папки WTF и Interface и т.д.)
- "Interface\AddOns\file.ext": - файл находится в папке AddOns
- "file.ext": - файл находится в в корневой папке WoW
ВАЖНО: необходимо перезапустить WoW для распознавания файлов которых до запуска не было.]=] -- Needs review
L["SOUNDERROR1"] = "Файл должен иметь расширение!" -- Needs review
L["SOUNDERROR2"] = "Файлы в формате WAV не поддерживаются WoW 4.0+" -- Needs review
L["SOUNDERROR3"] = "Поддерживаются только файлы в формате OGG и MP3." -- Needs review
L["SOUND_EVENT_DISABLEDFORTYPE"] = "Недоступно" -- Needs review
L["SOUND_EVENT_ONCLEU_DESC"] = "Это событие срабатывает, когда событие боя, отслеживаемое иконкой случается." -- Needs review
L["SOUND_EVENT_ONDURATION"] = "При изменении длительности" -- Needs review
L["SOUND_EVENT_ONDURATION_DESC"] = [=[Это событие возникает когда изменяется продолжительность таймера иконки.

Поскольку это событие имеет место каждый раз, когда иконка обновляется во время работы таймера, то следует установить условие, а событие будет  иметь место только когда состояние того условия изменится.]=] -- Needs review
L["SOUND_EVENT_ONFINISH"] = "При окончании"
L["SOUND_EVENT_ONFINISH_DESC"] = [=[Это событие будет запущено по окончании времени восстановления заклинания/предмета, спадении баффа и т.п.
Внимание: обработчик этого события не исполняется после событий "При отображении" или "При сокрытии"]=] -- Needs review
L["SOUND_EVENT_ONHIDE"] = "При скрытии"
L["SOUND_EVENT_ONHIDE_DESC"] = "Это событие происходит при скрытии значка (даже если установлена опция %q)" -- Needs review
L["SOUND_EVENT_ONSHOW"] = "При отображении"
L["SOUND_EVENT_ONSHOW_DESC"] = "Это событие происходит при отображении значка (даже если установлена опция %q)" -- Needs review
L["SOUND_EVENT_ONSPELL"] = "При изменении заклинания" -- Needs review
L["SOUND_EVENT_ONSPELL_DESC"] = "Это событие происходит при смене заклинания/предмета/и т.п., информация о котором отображается на этом значке." -- Needs review
L["SOUND_EVENT_ONSTACK_DESC"] = [=[Это событие включается когда отслеживаемые стаки или предмет изменяют состояние.

Это включает число уменьшения для %s иконок]=] -- Needs review
L["SOUND_EVENT_ONUNIT"] = "При изменении объекта"
L["SOUND_EVENT_ONUNIT_DESC"] = "Это событие происходит при изменении состояния объекта, отображаемого на этом значке." -- Needs review
L["SOUND_SOUNDTOPLAY"] = "Звук для воспроизведения" -- Needs review
L["SOUND_TAB"] = "Звук" -- Needs review
L["SPEED"] = "Скорость объекта" -- Needs review
L["SPELLCOOLDOWN"] = "Кулдаун заклинания" -- Needs review
L["SPELLCRIT"] = "Крит заклинания" -- Needs review
L["SpellDamageTaken"] = "Увеличение получаемого магического урона"
L["SPELLHASTE"] = "Скорость заклинания" -- Needs review
L["SPELLTOCHECK"] = "Заклинание для проверки"
L["STACKS"] = "Стаки" -- Needs review
L["STANCE"] = "Стойка" -- Needs review
L["STRATA_BACKGROUND"] = "Фон"
L["STRATA_DIALOG"] = "Окно настроек"
L["STRATA_FULLSCREEN"] = "Полный экран"
L["STRATA_FULLSCREEN_DIALOG"] = "Полноэкранное окно настроек" -- Needs review
L["STRATA_HIGH"] = "Высокая"
L["STRATA_LOW"] = "Низкая"
L["STRATA_MEDIUM"] = "Средняя"
L["STRATA_TOOLTIP"] = "Подсказка"
L["Stunned"] = "Оглушен"
L["SUG_ATBEGINING"] = "Советчик: Начало матча" -- Needs review
L["SUG_ATBEGINING_DESC"] = "С галочкой список предложения покажет только заклинания, которые начинаются с тех же букв, что и заклинание которое впечатывается. Если без, то список будет соответствовать любой части заклинания." -- Needs review
L["SUG_BUFFEQUIVS"] = "Эквиваленты бафов" -- Needs review
L["SUG_CLASSSPELLS"] = "Известные заклинания игрока/питомца" -- Needs review
L["SUG_DEBUFFEQUIVS"] = "Эквиваленты дебафов" -- Needs review
L["SUG_DISPELTYPES"] = "Типы рассеивания заклинаний" -- Needs review
L["SUGGESTIONS"] = "Предложения:" -- Needs review
L["SUG_INSERT_ANY"] = "|cff7fffffНажмите|r"
L["SUG_INSERTEQUIV"] = "%s вставить эквивалентность" -- Needs review
L["SUG_INSERTID"] = "%s чтобы добавить по ID"
L["SUG_INSERTITEMSLOT"] = "%s чтобы добавить как ID ячейки снаряжения" -- Needs review
L["SUG_INSERT_LEFT"] = "|cff7fffffНажмите ЛКМ|r"
L["SUG_INSERTNAME"] = "%s чтобы добавить по имени" -- Needs review
L["SUG_INSERT_RIGHT"] = "|cff7fffffНажмите ПКМ|r"
L["SUG_INSERTTEXTSUB"] = "%s для ввода признака" -- Needs review
L["SUG_MATCH_WPNENCH_ENCH"] = "Оружие (........)"
L["SUG_MISC"] = "Смешанный" -- Needs review
L["SUG_NPCAURAS"] = "Известные баффы/дебаффы НПЦ" -- Needs review
L["SUG_PATTERNMATCH_FISHINGLURE"] = "Приманка %(рыбная ловля %+%d+%)"
L["SUG_PATTERNMATCH_SHARPENINGSTONE"] = "Оружие заточено %(%+%d+ к урону)"
L["SUG_PATTERNMATCH_WEIGHTSTONE"] = "Оружие утяжелено %(%+%d+ к урону)"
L["SUG_PLAYERAURAS"] = "Известные баффы/дебаффы игроков/питомцев" -- Needs review
L["SUG_PLAYERSPELLS"] = "Ваши заклинания" -- Needs review
L["SUG_SUBSTITUTION_d"] = "Оставшаяся продолжительность" -- Needs review
L["SUG_SUBSTITUTION_d_DESC"] = "Продолжительность, остающаяся на таймере иконки" -- Needs review
L["SUG_SUBSTITUTION_e"] = "Объект назначения" -- Needs review
L["SUG_SUBSTITUTION_f"] = "Фокус Имя" -- Needs review
L["SUG_SUBSTITUTION_f_DESC"] = "Имя объета  на котором вы сфокусированы" -- Needs review
L["SUG_SUBSTITUTION_k"] = "Текущие стаки" -- Needs review
L["SUG_SUBSTITUTION_k_DESC"] = "Независимо от того, что в настоящее время показывается как текст стака иконки" -- Needs review
L["SUG_SUBSTITUTION_m"] = "Имя под курсором мыши" -- Needs review
L["SUG_SUBSTITUTION_m_DESC"] = "Имя объекта под курсором мыши" -- Needs review
L["SUG_SUBSTITUTION_o"] = "Объект-источник" -- Needs review
L["SUG_SUBSTITUTION_o_DESC"] = "Безотносительно того, что объект вызвал действие в последнем бою, которое обработала иконка." -- Needs review
L["SUG_SUBSTITUTION_p"] = "Предыдущий объект" -- Needs review
L["SUG_SUBSTITUTION_p_DESC"] = "Название объекта, которое было отмечено до текущего объекта" -- Needs review
L["SUG_SUBSTITUTION_s"] = "Текущее залинание/предмет/итд" -- Needs review
L["SUG_SUBSTITUTION_s_DESC"] = "Название текущего отмеченного заклинания/предмета/итд   " -- Needs review
L["SUG_SUBSTITUTION_t"] = "Имя цели" -- Needs review
L["SUG_SUBSTITUTION_t_DESC"] = "Название объекта, который вы в настоящее время отмечаете" -- Needs review
L["SUG_SUBSTITUTION_u"] = "Текущий объет" -- Needs review
L["SUG_SUBSTITUTION_u_DESC"] = "Название текущего отмеченного объекта" -- Needs review
L["SUG_SUBSTITUTION_x"] = "Дополнительное заклинание" -- Needs review
L["SUG_SUBSTITUTION_x_DESC"] = "Боевые события пробные рассеиваниям, прерываниям и разрушениям аур имеют дополнительный параметр о вызвавшем событии заклинании. Данное займет место этого заклинания как последнее событие боевого журнала." -- Needs review
L["SUG_TOOLTIPTITLE_TEXTSUBS"] = [=[Следующее - это признаки, которые Вы можете захотеть использовать в этой текстовой подсказке. Использование подстановки заставит заменить их соответствующими данными везде, где они отражаются.

Для дополнительной информации об этих признаках, и большего их количества, щелкните по этой кнопке.

Нажатие на ввход вставит его в строку ввода.]=] -- Needs review
L["SUN"] = "Солнце"
L["TANK"] = "Танк"
L["TEXTLAYOUTS_DEFAULTS_BINDINGLABEL"] = "Привязка/Ярлык" -- Needs review
L["TEXTLAYOUTS_DEFAULTS_ICON1"] = "Расположение иконки 1" -- Needs review
L["TEXTLAYOUTS_DEFAULTS_STACKS"] = "Стаки" -- Needs review
L["TEXTLAYOUTS_DEFAULTTEXT"] = "Текст по умолчанию" -- Needs review
L["TEXTLAYOUTS_DEFAULTTEXT_DESC"] = "Отредактируйте текст по умолчанию, который будет использоваться на иконке" -- Needs review
L["TEXTLAYOUTS_DELETELAYOUT"] = "Удалить Расположение" -- Needs review
L["TEXTLAYOUTS_DELETELAYOUT_CONFIRM_BASE"] = "Вы уверены в желании удалить расположение %q?" -- Needs review
L["TEXTLAYOUTS_fLAYOUT"] = "Расположение текста: %s" -- Needs review
L["TEXTLAYOUTS_SKINAS_NONE"] = "Нет" -- Needs review
L["TEXTLAYOUTS_STRING_COPYMENU"] = "Скопировать" -- Needs review
L["TEXTLAYOUTS_STRING_SETDEFAULT"] = "По умолчанию" -- Needs review
L["TEXTLAYOUTS_UNNAMED"] = "<без имени>" -- Needs review
L["Tier11Interrupts"] = "Прерывания Тира 11" -- Needs review
L["TOP"] = "Вверху"
L["TOPLEFT"] = "Вверху слева"
L["TOPRIGHT"] = "Вверху справа"
L["TOTEMS"] = "Тотемы для проверки" -- Needs review
L["TRUE"] = "Верно"
L["UIPANEL_ADDGROUP"] = "Добавить другую группу"
L["UIPANEL_ADDGROUP_DESC"] = "Новой группе будет присвоен следующий доступный ID группы"
L["UIPANEL_ALLRESET"] = "Сбросить всё"
L["UIPANEL_BARIGNOREGCD"] = "Полосы не учитывают глобальный кулдаун" -- Needs review
L["UIPANEL_BARIGNOREGCD_DESC"] = "При этом выборе полосы кулдаунов не изменят значений если кулдаун инициирован как глобальный" -- Needs review
L["UIPANEL_BARTEXTURE"] = "Текстура полосы"
L["UIPANEL_CLOCKIGNOREGCD"] = "Таймеры не учитывают глобальную перезарядку"
L["UIPANEL_CLOCKIGNOREGCD_DESC"] = "Если выбрана, таймеры и часы восстановления не учитывают глобальное восстановление"
L["UIPANEL_COLORS"] = "Цвета"
L["UIPANEL_COLORS_DESC"] = "Параметры настройки управления окраской/расцветкой иконок, основанного на их признаках." -- Needs review
L["UIPANEL_COLUMNS"] = "Столбцы"
L["UIPANEL_DELGROUP"] = "Удалить эту группу"
L["UIPANEL_DELGROUP_DESC"] = [=[Любые ID групп после этой группы будут смещены вверх, и любые проверяемые иконки в группах, которые будут смещены, обновят автоматически свои настройки.
Нажмите |cff7fffffCtrl|r для обхода подтверждения.]=] -- Needs review
L["UIPANEL_DRAWEDGE"] = "Подсвечивать рамку таймера"
L["UIPANEL_DRAWEDGE_DESC"] = "Подсвечивать рамку таймера восстановления для улучшения видимости"
L["UIPANEL_EFFTHRESHOLD"] = "Порог эффективности защитных заклинаний (бафов)" -- Needs review
L["UIPANEL_EFFTHRESHOLD_DESC"] = "Определяет минимальное количество бафов/дебафов для переключения на более эффективный способ их проверки при наличии большого их количества. Не забудьте, что как только количество проверяемых аур превышает это число, более старые ауры будут расположены по приоритетам вместо порядка, основанного на последовательности их получения." -- Needs review
L["UIPANEL_ENABLEGROUP"] = "Включить группу"
L["UIPANEL_FONT_CONSTRAINWIDTH"] = "Ограничить ширину"
L["UIPANEL_FONT_CONSTRAINWIDTH_DESC"] = [=[При установке этой опции ширина текста будет ограничена шириной значка. 
Если эта опция не выбрана текст может быть шире чем значок.]=] -- Needs review
L["UIPANEL_FONT_DESC"] = "Шрифт для отображения значения суммирования эффекта на иконке."
L["UIPANEL_FONTFACE"] = "Шрифт" -- Needs review
L["UIPANEL_FONT_OUTLINE"] = "Контур шрифта"
L["UIPANEL_FONT_OUTLINE_DESC"] = "Вид контура шрифта используемого для отображения значения суммирования эффекта на иконке."
L["UIPANEL_FONT_SIZE"] = "Размер шрифта"
L["UIPANEL_FONT_SIZE_DESC"] = "Устанавливает размер шрифта для отображения числа стаков эффета на значке. Если установлен аддон Masque и для него используется собственный размер шрифта, это значение игнорируется." -- Needs review
L["UIPANEL_FONT_XOFFS"] = "Смещение по X"
L["UIPANEL_FONT_YOFFS"] = "Смещение по Y"
L["UIPANEL_GLYPH"] = "Символ" -- Needs review
L["UIPANEL_GROUPNAME"] = "Переименовать группу"
L["UIPANEL_GROUPRESET"] = "Сбросить расположение"
L["UIPANEL_GROUPS"] = "Группы"
L["UIPANEL_GROUPSORT"] = "Сортировка иконок" -- Needs review
L["UIPANEL_GROUPSORT_alpha"] = "Нерозрачность (игнорировать %s)" -- Needs review
L["UIPANEL_GROUPSORT_alpha_DESC"] = "Сортировать группу по непрозрачности ее иконок, игнорируя иконки со значением параметра %s " -- Needs review
L["UIPANEL_GROUPSORT_DESC"] = "Содержит параметры настройки для сортировки позиционирования иконок в группе на иснове их атрибутов." -- Needs review
L["UIPANEL_GROUPSORT_duration"] = "Продолжительность" -- Needs review
L["UIPANEL_GROUPSORT_duration_DESC"] = "Сортирует группу по продолжительности, оставшейся на этих иконках" -- Needs review
L["UIPANEL_GROUPSORT_id"] = "ID иконки" -- Needs review
L["UIPANEL_GROUPSORT_id_DESC"] = "Сортирует группу по ID номерам ее иконок" -- Needs review
L["UIPANEL_GROUPSORT_METHODDISABLED_DESC"] = "|TInterface\\AddOns\\TellMeWhen\\Textures\\Alert:0:2|t Этот метод сортировки отключен по причине того, что новый метод сортирует иконки по ID, поэтому старый никогда не будет использован при сортировке" -- Needs review
L["UIPANEL_GROUPSORT_METHODNAME"] = "Приоритет сортировки иконки %d" -- Needs review
L["UIPANEL_GROUPSORT_METHODNAME_DESC"] = "Используется в качестве номера %d приоритета при сортировке иконок, которые должны быть позиционированы в пределах группы." -- Needs review
L["UIPANEL_GROUPSORT_shown"] = "Показанная (игнорировать %s)" -- Needs review
L["UIPANEL_GROUPSORT_shown_DESC"] = "Сортирует группу по показавщимся иконкам, игнорируя иконки со значением параметра %s " -- Needs review
L["UIPANEL_GROUPSORT_SORTASCENDING"] = "Нижнее значение" -- Needs review
L["UIPANEL_GROUPSORT_SORTASCENDING_DESC"] = "Проверка сортирует этот атрибут от нижних до верхних значений." -- Needs review
L["UIPANEL_GROUPSORT_SORTDESCENDING"] = "Верхнее значение" -- Needs review
L["UIPANEL_GROUPSORT_SORTDESCENDING_DESC"] = "Проверка сортирует этот атрибут от верхних до нижних значений" -- Needs review
L["UIPANEL_ICONS"] = "Значки" -- Needs review
L["UIPANEL_ICONSPACING_DESC"] = "Расстояние на котором значки расположены друг от друга в группе"
L["UIPANEL_LEVEL"] = "Уровень фрейма" -- Needs review
L["UIPANEL_LOCK"] = "Заблокировать группу"
L["UIPANEL_LOCK_DESC"] = "Заблокировать возможность перемещения или изменения размера группы."
L["UIPANEL_LOCKUNLOCK"] = "Заблокировать/разблокировать аддон"
L["UIPANEL_MAINOPT"] = "Основные параметры"
L["UIPANEL_ONLYINCOMBAT"] = "Показывать только в бою"
L["UIPANEL_POINT"] = "Точка" -- Needs review
L["UIPANEL_POSITION"] = "Расположение"
L["UIPANEL_PRIMARYSPEC"] = "Первый набор талантов"
L["UIPANEL_PTSINTAL"] = "Очков в таланте"
L["UIPANEL_RELATIVEPOINT"] = "Относительная точка" -- Needs review
L["UIPANEL_RELATIVETO"] = "Относительно" -- Needs review
L["UIPANEL_RELATIVETO_DESC"] = "Введите '/framestack' для переключения с заголовка, содержащего список всех фреймов которые Вы закончили с помощью мыши, и их имен, на вставку этого диалога." -- Needs review
L["UIPANEL_ROWS"] = "Строки"
L["UIPANEL_SCALE"] = "Масштаб"
L["UIPANEL_SECONDARYSPEC"] = "Второй набор талантов"
L["UIPANEL_SPEC"] = "Набор талантов"
L["UIPANEL_STRATA"] = "Экранная глубина" -- Needs review
L["UIPANEL_SUBTEXT2"] = [=[Значки работают когда они заблокированы.

Когда разблокированы, вы можете перемещать группы значков и изменять их размер, а так же настраивать отдельные значки правым щелчком мыши.

Для блокировки/разблокировки аддона наберите /tellmewhen or /tmw.]=] -- Needs review
L["UIPANEL_TOOLTIP_ALLRESET"] = "Сброс данных и расположение всех иконок и групп, а также любые другие параметры."
L["UIPANEL_TOOLTIP_COLUMNS"] = "Установить число столбцов в этой группе"
L["UIPANEL_TOOLTIP_ENABLEGROUP"] = "Показать и включить эту группу значков"
L["UIPANEL_TOOLTIP_GROUPRESET"] = "Сбросить расположение и масштаб этой группы"
L["UIPANEL_TOOLTIP_ONLYINCOMBAT"] = "Показывать эту группу только в бою"
L["UIPANEL_TOOLTIP_PRIMARYSPEC"] = "Показывать эту группу только тогда, когда задействован ваш первый набор талантов"
L["UIPANEL_TOOLTIP_ROWS"] = "Установить число строк в этой группе"
L["UIPANEL_TOOLTIP_SECONDARYSPEC"] = "Показывать эту группу только тогда, когда задействован ваш второй набор талантов"
L["UIPANEL_TOOLTIP_UPDATEINTERVAL"] = "Частота (в секундах) проверки параметров и условий значков. Значение 0 означает максимально быструю проверку. Внимание: маленькие значения могут сильно снизить частоту кадров на слабых компьютерах."
L["UIPANEL_TREE"] = "Дерево талантов" -- Needs review
L["UIPANEL_TREE_DESC"] = "Проверка позволяет показать эту группу, когда это дерево талантов активно, или, без проверки, чтобы заставить ее исчезнуть, когда оно не активно." -- Needs review
L["UIPANEL_UPDATEINTERVAL"] = "Интервал обновления"
L["UIPANEL_WARNINVALIDS"] = "Предупреждать о недействительных иконках"
L["UNDO_ICON"] = "Отменить" -- Needs review
L["UNDO_ICON_DESC"] = "Отменить последнее изменение установок для этого значка. " -- Needs review
L["UNITTWO"] = "Второй объект"
L["UNNAMED"] = "((Без названия))" -- Needs review
L["WARN_DRMISMATCH"] = [=[Внимание! Вы проверяете убывающую эффективность залинаний из двух различных известных категорий.
Все заклинания обязаны быть из одной убывающей категории чтобы иконка фунционировала должным образом. Были обнаружены следующие категории и заклинания :]=] -- Needs review
L["WATER"] = "Вода" -- Needs review
L["worldboss"] = "Ворлд Босс" -- Needs review
