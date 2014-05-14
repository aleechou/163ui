--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Core\Locales.lua
	* Revision.: 360
	* Author...: StormFX

	Localization

	[ Notes ]

	The contents of this file are automatically generated. Please use the localization application on WoWAce.com
	to submit translations. http://www.wowace.com/projects/masque/localization/
]]

local _, Core = ...

-- Locales Table
local L = {}

-- Thanks, Tekkub/Rabbit.
Core.Locale = setmetatable(L, {
	__index = function(self, k)
		self[k] = k
		return k
	end
})

--[[ enUS/enGB: For reference only.
L = {
	["Addons"] = "Addons",
	["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings.",
	["Adjust the skin of all buttons registered to %s: %s."] = "Adjust the skin of all buttons registered to %s: %s.",
	["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "Adjust the skin of all registered buttons. This will overwrite any per-add-on settings.",
	["Backdrop Settings"] = "Backdrop Settings",
	["Causes Masque to preload its options instead of having them loaded on demand."] = "Causes Masque to preload its options instead of having them loaded on demand.",
	["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin.",
	["Checked"] = "Checked",
	["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "Click this button to load Masque's options. You can also use the %s or %s chat command.",
	["Click to open Masque's options window."] = "Click to open Masque's options window.",
	["Color"] = "Color",
	["Colors"] = "Colors",
	["Debug Mode"] = "Debug Mode",
	["Disable"] = "Disable",
	["Disable the skinning of this group."] = "Disable the skinning of this group.",
	["Disabled"] = "Disabled",
	["Enable"] = "Enable",
	["Enable fonts provided by skins."] = "Enable fonts provided by skins.",
	["Enable the backdrop texture."] = "Enable the backdrop texture.",
	["Enable the minimap icon."] = "Enable the minimap icon.",
	["Flash"] = "Flash",
	["Global"] = "Global",
	["Gloss Settings"] = "Gloss Settings",
	["Highlight"] = "Highlight",
	["Load Masque Options"] = "Load Masque Options",
	["Loading Masque Options..."] = "Loading Masque Options...",
	["Masque debug mode disabled."] = "Masque debug mode disabled.",
	["Masque debug mode enabled."] = "Masque debug mode enabled.",
	["Masque is a dynamic button skinning add-on."] = "Masque is a dynamic button skinning add-on.",
	["Minimap Icon"] = "Minimap Icon",
	["Normal"] = "Normal",
	["Opacity"] = "Opacity",
	["Preload Options"] = "Preload Options",
	["Profiles"] = "Profiles",
	["Pushed"] = "Pushed",
	["Reset Skin"] = "Reset Skin",
	["Reset all skin options to the defaults."] = "Reset all skin options to the defaults.",
	["Set the color of the backdrop texture."] = "Set the color of the backdrop texture.",
	["Set the color of the checked texture."] = "Set the color of the checked texture.",
	["Set the color of the disabled texture."] = "Set the color of the disabled texture.",
	["Set the color of the flash texture."] = "Set the color of the flash texture.",
	["Set the color of the gloss texture."] = "Set the color of the gloss texture.",
	["Set the color of the highlight texture."] = "Set the color of the highlight texture.",
	["Set the color of the normal texture."] = "Set the color of the normal texture.",
	["Set the color of the pushed texture."] = "Set the color of the pushed texture.",
	["Set the intensity of the gloss color."] = "Set the intensity of the gloss color.",
	["Set the skin for this group."] = "Set the skin for this group.",
	["Skin"] = "Skin",
	["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque.",
}
]]

do
	local LOC = GetLocale()
	if LOC == "deDE" then
L["Addons"] = "Addons"
-- L["Adjust the skin of all buttons registered to %s: %s."] = ""
-- L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = ""
-- L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = ""
L["Backdrop Settings"] = "Hintergrund Einstellungen"
-- L["Causes Masque to preload its options instead of having them loaded on demand."] = ""
-- L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = ""
L["Checked"] = "Ausgewählt"
-- L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = ""
-- L["Click to open Masque's options window."] = ""
L["Color"] = "Farbe"
L["Colors"] = "Farben"
-- L["Debug Mode"] = ""
L["Disable"] = "Deaktivieren"
L["Disabled"] = "Deaktiviert"
-- L["Disable the skinning of this group."] = ""
L["Enable"] = "Aktivieren"
-- L["Enable fonts provided by skins."] = ""
L["Enable the backdrop texture."] = "Die Hintergrundtextur aktivieren."
L["Enable the minimap icon."] = "Das Minimap-Symbol aktivieren"
L["Flash"] = "Leuchten"
L["Global"] = "Global"
L["Gloss Settings"] = "Glanz Einstellung"
L["Highlight"] = "Hervorheben"
L["Loading Masque Options..."] = "Lädt Masque-Optionen..."
L["Load Masque Options"] = "Masque-Optionen laden"
-- L["Masque debug mode disabled."] = ""
-- L["Masque debug mode enabled."] = ""
-- L["Masque is a dynamic button skinning add-on."] = ""
L["Minimap Icon"] = "Minimap-Symbol"
L["Normal"] = "Normal"
L["Opacity"] = "Transparenz"
-- L["Preload Options"] = ""
L["Profiles"] = "Profile"
L["Pushed"] = "Gedrückt"
L["Reset all skin options to the defaults."] = "Alle Farben auf Standard zurücksetzen."
L["Reset Skin"] = "Alle Farben zurücksetzen"
-- L["Set the color of the backdrop texture."] = ""
L["Set the color of the checked texture."] = "Tooltip-Farbe - Markiert"
L["Set the color of the disabled texture."] = "Tooltip-Farbe - Ausgeschaltet"
L["Set the color of the flash texture."] = "Tooltip-Farbe - Leuchten"
L["Set the color of the gloss texture."] = "Farbe der glänzenden Textur einstellen"
L["Set the color of the highlight texture."] = "Farbe der Textur zum Hervorheben einstellen"
L["Set the color of the normal texture."] = "Farbe der normalen Textur einstellen"
L["Set the color of the pushed texture."] = "Tooltip-Farbe - Gedrückt"
-- L["Set the intensity of the gloss color."] = ""
-- L["Set the skin for this group."] = ""
L["Skin"] = "Skin"
-- L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = ""
-- L["ToC/A dynamic button skinning add-on."] = ""

	elseif LOC == "esES" then
L["Addons"] = "Botones" -- Needs review
L["Adjust the skin of all buttons registered to %s: %s."] = "Ajusta la apariencia de todos los botones registrados a %s: %s." -- Needs review
L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "Ajusta la apariencia de todos los botones registrados a %s. Esto sobreescribirá la configuracion de los grupos." -- Needs review
L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "Ajusta la apariencia de todos los botones registrados. Esto sobreescribirá la configuración de los grupos." -- Needs review
L["Backdrop Settings"] = "Opciones de Fondo" -- Needs review
-- L["Causes Masque to preload its options instead of having them loaded on demand."] = ""
-- L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = ""
L["Checked"] = "Activado" -- Needs review
L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "Haz click en este botón para cargar las opciones de Masque. Puedes también utilizar los comandos de chat %s o %s." -- Needs review
-- L["Click to open Masque's options window."] = ""
L["Color"] = "Color"
L["Colors"] = "Colores" -- Needs review
-- L["Debug Mode"] = ""
L["Disable"] = "Desactivado" -- Needs review
L["Disabled"] = "Desactivado" -- Needs review
L["Disable the skinning of this group."] = "Deshabilitar las texturas para este grupo." -- Needs review
L["Enable"] = "Activado"
-- L["Enable fonts provided by skins."] = ""
L["Enable the backdrop texture."] = "Habilitar la textura de fondo." -- Needs review
-- L["Enable the minimap icon."] = ""
L["Flash"] = "Destello" -- Needs review
L["Global"] = "Global" -- Needs review
L["Gloss Settings"] = "Opciones de Brillo" -- Needs review
L["Highlight"] = "Resaltado" -- Needs review
L["Loading Masque Options..."] = "Cargando las opciones de Masque" -- Needs review
L["Load Masque Options"] = "Cargar las opciones de Masque" -- Needs review
-- L["Masque debug mode disabled."] = ""
-- L["Masque debug mode enabled."] = ""
-- L["Masque is a dynamic button skinning add-on."] = ""
-- L["Minimap Icon"] = ""
L["Normal"] = "Normal" -- Needs review
L["Opacity"] = "Opacidad"
-- L["Preload Options"] = ""
L["Profiles"] = "Perfiles"
L["Pushed"] = "Pulsado" -- Needs review
L["Reset all skin options to the defaults."] = "Reestablece todos los colores a los predefinidos" -- Needs review
L["Reset Skin"] = "Restablecer Colores" -- Needs review
-- L["Set the color of the backdrop texture."] = ""
L["Set the color of the checked texture."] = "Establece el color de la textura activada" -- Needs review
L["Set the color of the disabled texture."] = "Establece el color de la textura desactivada" -- Needs review
L["Set the color of the flash texture."] = "Establece el color del textura destelleando" -- Needs review
L["Set the color of the gloss texture."] = "Establece el color de la textura brillando" -- Needs review
L["Set the color of the highlight texture."] = "Establece el color de la textura resaltada" -- Needs review
L["Set the color of the normal texture."] = "Establece el color de la textura normal" -- Needs review
L["Set the color of the pushed texture."] = "Establece el color de la textura pulsada" -- Needs review
-- L["Set the intensity of the gloss color."] = ""
-- L["Set the skin for this group."] = ""
L["Skin"] = "Textura"
-- L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = ""
-- L["ToC/A dynamic button skinning add-on."] = ""

	elseif LOC == "esMX" then
-- L["Addons"] = ""
-- L["Adjust the skin of all buttons registered to %s: %s."] = ""
-- L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = ""
-- L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = ""
-- L["Backdrop Settings"] = ""
-- L["Causes Masque to preload its options instead of having them loaded on demand."] = ""
-- L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = ""
L["Checked"] = "Marcado"
-- L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = ""
-- L["Click to open Masque's options window."] = ""
-- L["Color"] = ""
-- L["Colors"] = ""
-- L["Debug Mode"] = ""
-- L["Disable"] = ""
L["Disabled"] = "Borde Desactivado"
-- L["Disable the skinning of this group."] = ""
-- L["Enable"] = ""
-- L["Enable fonts provided by skins."] = ""
-- L["Enable the backdrop texture."] = ""
-- L["Enable the minimap icon."] = ""
L["Flash"] = "Destello"
-- L["Global"] = ""
-- L["Gloss Settings"] = ""
L["Highlight"] = "Resaltado"
-- L["Loading Masque Options..."] = ""
-- L["Load Masque Options"] = ""
-- L["Masque debug mode disabled."] = ""
-- L["Masque debug mode enabled."] = ""
-- L["Masque is a dynamic button skinning add-on."] = ""
-- L["Minimap Icon"] = ""
L["Normal"] = "Borde Normal"
-- L["Opacity"] = ""
-- L["Preload Options"] = ""
L["Profiles"] = "Perfiles"
L["Pushed"] = "Borde Pulsado"
-- L["Reset all skin options to the defaults."] = ""
L["Reset Skin"] = "Restablecer Colores"
-- L["Set the color of the backdrop texture."] = ""
-- L["Set the color of the checked texture."] = ""
-- L["Set the color of the disabled texture."] = ""
-- L["Set the color of the flash texture."] = ""
-- L["Set the color of the gloss texture."] = ""
-- L["Set the color of the highlight texture."] = ""
-- L["Set the color of the normal texture."] = ""
-- L["Set the color of the pushed texture."] = ""
-- L["Set the intensity of the gloss color."] = ""
-- L["Set the skin for this group."] = ""
L["Skin"] = "Textura"
-- L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = ""
-- L["ToC/A dynamic button skinning add-on."] = ""

	elseif LOC == "frFR" then
L["Addons"] = "Boutons"
L["Adjust the skin of all buttons registered to %s: %s."] = "Ajuster le skin (style) de tous les boutons enregistrés sous %s: %s."
L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "Ajuster le skin (style) de tous les boutons enregistrés sous %s. Ceci va écraser les réglages \"par groupe\"."
L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "Ajuster le skin (style) de tous les boutons enregistrés. Ceci va écraser les réglages des autres addons."
L["Backdrop Settings"] = "Paramètres du fond"
L["Causes Masque to preload its options instead of having them loaded on demand."] = "Masque pré-chargera ses options au lieu de les charger sur demande."
L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Masque ignorera les erreurs Lua lorsqu'il rencontre un problème avec un add-on ou un skin (style)."
L["Checked"] = "Coché"
L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "Appuyez sur ce bouton pour charger les options de Masque. Vous pouvez aussi utiliser les commandes %s ou %s dans le chat (fenêtre de discussion)."
L["Click to open Masque's options window."] = "Cliquez pour ouvrir la fenêtre des options de Masque."
L["Color"] = "Couleur"
L["Colors"] = "Couleurs"
L["Debug Mode"] = "Mode débogage"
L["Disable"] = "Désactiver"
L["Disabled"] = "Désactivé"
L["Disable the skinning of this group."] = "Désactiver le skin (style) de ce groupe."
L["Enable"] = "Activer"
L["Enable fonts provided by skins."] = "Active les polices d'écriture fournies par les skins."
L["Enable the backdrop texture."] = "Activer la texture de fond."
L["Enable the minimap icon."] = "Active l'icône de la minicarte."
L["Flash"] = "Flash"
L["Global"] = "Global"
L["Gloss Settings"] = "Paramètres du vernis"
L["Highlight"] = "Surbrillance"
L["Loading Masque Options..."] = "Chargement des options de Masque..."
L["Load Masque Options"] = "Charger les options de Masque"
L["Masque debug mode disabled."] = "Débogage de Masque désactivé."
L["Masque debug mode enabled."] = "Débogage de Masque activé."
L["Masque is a dynamic button skinning add-on."] = "Masque est un add-on modulaire destiné au skin (style)."
L["Minimap Icon"] = "Icône de la minicarte"
L["Normal"] = "Normal"
L["Opacity"] = "Opacité"
L["Preload Options"] = "Précharger les options."
L["Profiles"] = "Profils"
L["Pushed"] = "Enfoncé"
L["Reset all skin options to the defaults."] = "Restaure les couleurs par défauts."
L["Reset Skin"] = "Réinit. toutes les couleurs"
L["Set the color of the backdrop texture."] = "Définir la couleur de la texture de fond."
L["Set the color of the checked texture."] = "Définir la couleur de la texture cochée."
L["Set the color of the disabled texture."] = "Définir la couleur de la texture désactivée."
L["Set the color of the flash texture."] = "Définir la couleur de la texture clignotante."
L["Set the color of the gloss texture."] = "Définir la couleur de la texture du vernis. "
L["Set the color of the highlight texture."] = "Définir la couleur de la surbrillance."
L["Set the color of the normal texture."] = "Définir la couleur de la texture normale."
L["Set the color of the pushed texture."] = "Définir la couleur de la texture appuyée."
L["Set the intensity of the gloss color."] = "Définir l’intensité de la couleur du vernis."
L["Set the skin for this group."] = "Définir le skin (style) pour ce groupe."
L["Skin"] = "Skin"
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Cette section vous permet de définir le skin (style) des boutons des add-ons et des groupes d'add-ons enregistrés avec Masque."
L["ToC/A dynamic button skinning add-on."] = "Un add-on de skinnage dynamique des boutons."

	elseif LOC == "koKR" then
L["Addons"] = "애드온"
L["Adjust the skin of all buttons registered to %s: %s."] = "%s: %s|1으로;로; 등록된 모든 버튼의 스킨을 조절합니다."
L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "%s|1으로;로; 등록된 모든 버튼의 스킨을 조절합니다. 이 옵션은 그룹당 설정은 어떤 것이던지 덧씌우게 됩니다."
L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "등록된 모든 버튼의 스킨을 조절합니다. 이 옵션은 애드온당 설정은 어떤 것이던지 덧씌우게 됩니다."
L["Backdrop Settings"] = "바탕 설정"
L["Causes Masque to preload its options instead of having them loaded on demand."] = "Masque가 그것의 옵션을 요청시 불러들이는 대신에 미리 불러들이도록 합니다.  "
L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Masque가 애드온 혹은 스킨과의 문제에 부닥칠 때마다 언제든지 Lua 오류화하도록 합니다. "
L["Checked"] = "선택된 버튼"
L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "Masque 옵션을 불러들이려면 이 버튼을 클릭하세요. %s 혹은 %s 대화 명령어 또한 사용할 수 있습니다."
L["Click to open Masque's options window."] = "Masque의 옵션창을 열려면 클릭하세요."
L["Color"] = "색상"
L["Colors"] = "색상"
L["Debug Mode"] = "디버그 모드"
L["Disable"] = "비활성화"
L["Disabled"] = "비활성화된 버튼"
L["Disable the skinning of this group."] = "이 그룹의 스킨 씌우기를 비활성화합니다."
L["Enable"] = "활성화"
L["Enable fonts provided by skins."] = "스킨에 의해 제공되는 글꼴을 활성화 합니다."
L["Enable the backdrop texture."] = "바탕 텍스쳐를 활성화합니다."
L["Enable the minimap icon."] = "미니맵 아이콘을 활성화 합니다."
L["Flash"] = "번쩍임"
L["Global"] = "공통 옵션"
L["Gloss Settings"] = "광택 효과 설정"
L["Highlight"] = "강조된 버튼"
L["Loading Masque Options..."] = "Masque 옵션을 불려 오는 중..."
L["Load Masque Options"] = "Masque 옵션 불러들이기"
L["Masque debug mode disabled."] = "Masque 디버그 모드를 비활성화합니다."
L["Masque debug mode enabled."] = "Masque 디버그 모드를 활성화합니다."
L["Masque is a dynamic button skinning add-on."] = "Masque는 동적인 버튼 스킨 입히기 애드온 입니다."
L["Minimap Icon"] = "미니맵 아이콘"
L["Normal"] = "평상 시 버튼"
L["Opacity"] = "불투명도"
L["Preload Options"] = "미리 불러들이기 옵션"
L["Profiles"] = "프로필"
L["Pushed"] = "눌려진 버튼"
L["Reset all skin options to the defaults."] = "모든 색상을 기본값으로 초기화 합니다."
L["Reset Skin"] = "스킨 초기화"
L["Set the color of the backdrop texture."] = "바탕 텍스쳐의 색상을 설정합니다."
L["Set the color of the checked texture."] = "선택된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the disabled texture."] = "비활성화된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the flash texture."] = "번쩍임 텍스처의 색상을 변경합니다."
L["Set the color of the gloss texture."] = "광택 효과 텍스처의 색상을 변경합니다."
L["Set the color of the highlight texture."] = "강조된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the normal texture."] = "평상 시 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the pushed texture."] = "눌려진 버튼 텍스처의 색상을 변경합니다."
L["Set the intensity of the gloss color."] = "번들거림 색상의 농도를 설정합니다."
L["Set the skin for this group."] = "이 그룹을 위한 스킨을 설정합니다."
L["Skin"] = "스킨"
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "이 항목은 Masque와 함께 등록된 애드온과 애드온 그룹의 버튼의 스킨을 씌울 수 있도록 합니다."
L["ToC/A dynamic button skinning add-on."] = "동적인 버튼 스킨 입히기 애드온 입니다."

	elseif LOC == "ruRU" then
L["Addons"] = "Кнопки" -- Needs review
-- L["Adjust the skin of all buttons registered to %s: %s."] = ""
-- L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = ""
-- L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = ""
L["Backdrop Settings"] = "Настройки фона" -- Needs review
-- L["Causes Masque to preload its options instead of having them loaded on demand."] = ""
-- L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = ""
L["Checked"] = "Проверенный" -- Needs review
-- L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = ""
-- L["Click to open Masque's options window."] = ""
L["Color"] = "Цвет"
L["Colors"] = "Цвета" -- Needs review
L["Debug Mode"] = "Режим Отладки" -- Needs review
L["Disable"] = "Отключить" -- Needs review
L["Disabled"] = "Отключить края" -- Needs review
-- L["Disable the skinning of this group."] = ""
L["Enable"] = "Включить"
-- L["Enable fonts provided by skins."] = ""
-- L["Enable the backdrop texture."] = ""
-- L["Enable the minimap icon."] = ""
L["Flash"] = "Сверкание" -- Needs review
-- L["Global"] = ""
L["Gloss Settings"] = "Настройки глянеца" -- Needs review
L["Highlight"] = "Выделение" -- Needs review
-- L["Loading Masque Options..."] = ""
L["Load Masque Options"] = "Загрузить настройки Masque" -- Needs review
-- L["Masque debug mode disabled."] = ""
-- L["Masque debug mode enabled."] = ""
-- L["Masque is a dynamic button skinning add-on."] = ""
L["Minimap Icon"] = "Иконка Миникарты" -- Needs review
L["Normal"] = "Нормальные края" -- Needs review
L["Opacity"] = "Прозрачность"
-- L["Preload Options"] = ""
L["Profiles"] = "Профили"
L["Pushed"] = "Вдавленные края" -- Needs review
L["Reset all skin options to the defaults."] = "Сбросить все цвета на значения по умолчанию." -- Needs review
L["Reset Skin"] = "Сбросить цвета" -- Needs review
-- L["Set the color of the backdrop texture."] = ""
L["Set the color of the checked texture."] = "Установить цвет отмеченной текстуры." -- Needs review
L["Set the color of the disabled texture."] = "Установить цвет отключенной текстуры." -- Needs review
L["Set the color of the flash texture."] = "Установить цвет подсвеченной текстуры." -- Needs review
L["Set the color of the gloss texture."] = "Задать цвет для глянецых текстур." -- Needs review
L["Set the color of the highlight texture."] = "Установить цвет выделенной текстуры." -- Needs review
L["Set the color of the normal texture."] = "Установить цвет нормальной текстуры." -- Needs review
L["Set the color of the pushed texture."] = "Установить цвет нажатой текстуры." -- Needs review
-- L["Set the intensity of the gloss color."] = ""
-- L["Set the skin for this group."] = ""
L["Skin"] = "Шкурки"
-- L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = ""
-- L["ToC/A dynamic button skinning add-on."] = ""

	elseif LOC == "zhCN" then
L["Addons"] = "插件"
L["Adjust the skin of all buttons registered to %s: %s."] = "将皮肤应用到所有已注册到%s：%s的按钮上。"
L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "将皮肤应用到所有已注册到%s的按钮上。这会覆盖所有群组的设定。"
L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "将皮肤应用到所有已注册的按钮上。这会覆盖所有插件的设定。"
L["Backdrop Settings"] = "背景设置"
L["Causes Masque to preload its options instead of having them loaded on demand."] = "让 Masque 预载入其选项，而不是需要的时候才载入。"
L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "无论何时 Masque 遇到了一个插件问题或者皮肤问题，都让其屏蔽 Lua 错误。"
L["Checked"] = "已选中"
L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "单击这个按钮来载入 Masque 的选项。你也可以使用%s或%s命令来实现。"
L["Click to open Masque's options window."] = "点击打开 Masque 选项窗口。"
L["Color"] = "颜色"
L["Colors"] = "颜色"
L["Debug Mode"] = "调试模式"
L["Disable"] = "禁用"
L["Disabled"] = "已禁用"
L["Disable the skinning of this group."] = "禁用此群组换肤。"
L["Enable"] = "启用"
L["Enable fonts provided by skins."] = "启用皮肤提供的字体。"
L["Enable the backdrop texture."] = "启用背景材质。"
L["Enable the minimap icon."] = "启用小地图图标。"
L["Flash"] = "闪光"
L["Global"] = "全局"
L["Gloss Settings"] = "光泽设置"
L["Highlight"] = "高亮"
L["Loading Masque Options..."] = "Masque 选项载入中……"
L["Load Masque Options"] = "载入 Masque 选项"
L["Masque debug mode disabled."] = "Masque 调试模式禁用。"
L["Masque debug mode enabled."] = "Masque 调试模式启用。"
L["Masque is a dynamic button skinning add-on."] = "Masque 是一款模块化插件换肤引擎。"
L["Minimap Icon"] = "小地图图标"
L["Normal"] = "正常"
L["Opacity"] = "不透明度"
L["Preload Options"] = "预载入选项"
L["Profiles"] = "配置文件"
L["Pushed"] = "加粗"
L["Reset all skin options to the defaults."] = "重置所有皮肤选项为默认。"
L["Reset Skin"] = "重置皮肤"
L["Set the color of the backdrop texture."] = "设置背景材质颜色"
L["Set the color of the checked texture."] = "设置已选中材质颜色。"
L["Set the color of the disabled texture."] = "设置已禁用材质颜色。"
L["Set the color of the flash texture."] = "设置闪光材质颜色。"
L["Set the color of the gloss texture."] = "设置光泽材质颜色。"
L["Set the color of the highlight texture."] = "设置高亮材质颜色。"
L["Set the color of the normal texture."] = "设置一般材质颜色。"
L["Set the color of the pushed texture."] = "设置加粗材质颜色。"
L["Set the intensity of the gloss color."] = "设置光泽颜色亮度。"
L["Set the skin for this group."] = "为此群组设置皮肤。"
L["Skin"] = "皮肤"
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "这个部分将允许你将使用 Masque 注册的插件与插件群组的按钮进行换肤。"
L["ToC/A dynamic button skinning add-on."] = "一个动态按钮皮肤插件。"





L["Blizzard"] = "暴雪默认"
L["Caith"] = "粗边框"
L["Darion"] = "焦黑"
L["Darion Clean"] = "焦黑（粗边）"
L["Dream"] = "无边框"
L["Zoomed"] = "无边框放大"
L["HelloKitty"] = "凯蒂猫"
L["HelloKitty Christmas"] = "圣诞凯蒂猫"
L["Entropy: Silver"] = "质感(银)"
L["Entropy: Adamantite"] = "质感(精金)"
L["Entropy: Bronze"] = "质感(青铜)"
L["Entropy: Cobalt"] = "质感(钴)"
L["Entropy: Copper"] = "质感(铜)"
L["Entropy: Fel Iron"] = "质感(魔铁)"
L["Entropy: Gold"] = "质感(金)"
L["Entropy: Iron"] = "质感(铁)"
L["Entropy: Khorium"] = "质感(氪金)"
L["Entropy: Obsidium"] = "质感(黑曜石)"
L["Entropy: Saronite"] = "质感(萨隆邪铁)"
L["Entropy: Titanium"] = "质感(泰坦神铁)"
L["Serenity"] = "圆形白边框"
L["Serenity Redux"] = "圆形白边框"
L["Serenity: Square"] = "方形白边框"
L["Serenity: Square Redux"] = "方形白边框"




	elseif LOC == "zhTW" then
L["Addons"] = "插件"
L["Adjust the skin of all buttons registered to %s: %s."] = "將所有按鈕的佈景主題套用到%s：%s。"
L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "將所有按鈕的佈景主題套用到%s。這會覆蓋所有群組的設定。"
L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "將佈景主題套用到所有按鈕。這會覆蓋所有的插件設定。"
L["Backdrop Settings"] = "背景設定"
L["Causes Masque to preload its options instead of having them loaded on demand."] = "讓Masque預先載入設定，而不是需要的時候才載入。"
L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "每當遭遇插件或是佈景問題都會讓Masque丟出Lua錯誤。"
L["Checked"] = "已勾選"
L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "點擊按鈕載入Masque的設定。你也可以使用%s或是%s聊天指令。"
L["Click to open Masque's options window."] = "點擊開啟Masque的設定視窗。"
L["Color"] = "顏色"
L["Colors"] = "顏色"
L["Debug Mode"] = "除錯模式"
L["Disable"] = "禁用"
L["Disabled"] = "已禁用"
L["Disable the skinning of this group."] = "禁止佈景主題套用在此群組。"
L["Enable"] = "啟用"
L["Enable fonts provided by skins."] = "啟用由佈景主題提供的字型。"
L["Enable the backdrop texture."] = "啟用背景材質。"
L["Enable the minimap icon."] = "啟用小地圖圖示。"
L["Flash"] = "閃光"
L["Global"] = "全域"
L["Gloss Settings"] = "光澤設定"
L["Highlight"] = "高亮"
L["Loading Masque Options..."] = "正在載入Masque設定中..."
L["Load Masque Options"] = "載入Masque設定"
L["Masque debug mode disabled."] = "Masque除錯模式已禁用。"
L["Masque debug mode enabled."] = "Masque除錯模式已啟用。"
L["Masque is a dynamic button skinning add-on."] = "Masque 為可動態變換按鈕佈景主題的插件。"
L["Minimap Icon"] = "小地圖圖示"
L["Normal"] = "一般"
L["Opacity"] = "不透明度"
L["Preload Options"] = "預載設定"
L["Profiles"] = "設定檔"
L["Pushed"] = "按下"
L["Reset all skin options to the defaults."] = "重置所有佈景主題為預設值。"
L["Reset Skin"] = "重置佈景主題"
L["Set the color of the backdrop texture."] = "設定背景材質顏色。"
L["Set the color of the checked texture."] = "設定已勾選材質顏色。"
L["Set the color of the disabled texture."] = "設定已禁用材質顏色。"
L["Set the color of the flash texture."] = "設定閃光材質顏色。"
L["Set the color of the gloss texture."] = "設定光澤材質顏色。"
L["Set the color of the highlight texture."] = "設定高亮材質顏色。"
L["Set the color of the normal texture."] = "設定一般材質顏色。"
L["Set the color of the pushed texture."] = "設定按下材質顏色。"
L["Set the intensity of the gloss color."] = "設定光澤顏色亮度。"
L["Set the skin for this group."] = "設定佈景主題套用在此群組。"
L["Skin"] = "佈景主題"
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "此區塊允許使用者將註冊在Masque底下的插件按鈕套用佈景主題。"
L["ToC/A dynamic button skinning add-on."] = "動態套用按鈕佈景主題的插件。"

	end
end
