--[[
	Localization submitted through CurseForge
	http://wow.curseforge.com/addons/broker_equipment/localization/
--]]

local _, ns = ...
ns.L = GetLocale() == 'deDE' and {
	['Ctrl-click'] = 'Strg + Linksklick, um Set zu l\195\182schen.',
	['Left-click'] = 'Linksklick, um Set zu wechseln.',
	['Right-click'] = 'Rechtsklick \195\182ffnet den Ausr\195\188stungsmanager',
	['Shift-click'] = 'Shift + Linksklick, um Set zu aktualisieren.',
} or GetLocale() == 'frFR' and {
	['Ctrl-click'] = 'Ctrl-clic pour supprimer le set',
	['Left-click'] = 'Clic-gauche pour changer de set',
	['Right-click'] = 'Clic-droit pour ouvrir le gestionnaire d\'\195\169quipement',
	['Shift-click'] = 'Shift-clic pour mettre \195\160 jour le set',
} or GetLocale() == 'zhCN' and {
	['Ctrl-click'] = 'Ctrl-click to delete set',
	['Left-click'] = 'Left-click to change your set',
	['Right-click'] = 'Right-click to open GearManager',
	['Shift-click'] = 'Shift-click to update set',
} or GetLocale() == 'zhTW' and {
	['Ctrl-click'] = 'Ctrl+\233\187\158\230\147\138\228\187\165\229\136\170\233\153\164\229\165\151\232\163\157',
	['Left-click'] = '\229\183\166\233\141\181\230\155\180\230\143\155\232\163\157\229\130\153',
	['Right-click'] = '\229\143\179\233\141\181\233\150\139\229\149\159\232\163\157\229\130\153\231\174\161\231\144\134\229\147\161',
	['Shift-click'] = 'Shift+\233\187\158\230\147\138\228\187\165\230\155\180\230\150\176\229\165\151\232\163\157',
} or GetLocale() == 'koKR' and {
	['Ctrl-click'] = 'Ctrl-\237\129\180\235\166\173 \236\132\184\237\138\184 \236\130\173\236\160\156',
	['Left-click'] = '\236\153\188\236\170\189-\237\129\180\235\166\173 \236\132\184\237\138\184 \235\179\128\234\178\189',
	['Right-click'] = '\236\152\164\235\165\184\236\170\189-\237\129\180\235\166\173\236\139\156 \236\186\144\235\166\173\237\132\176\236\176\189 \236\151\180\234\184\176',
	['Shift-click'] = 'Shift-\237\129\180\235\166\173 \236\132\184\237\138\184 \236\151\133\235\141\176\236\157\180\237\138\184',
} or GetLocale() == 'esES' and {
	['Ctrl-click'] = 'Ctrl-click para eliminar el conjunto',
	['Left-click'] = 'Click izquierdo para cambiar tu conjunto',
	['Right-click'] = 'Click derecho para abrir el Gestor de equipamiento',
	['Shift-click'] = 'Shift-click para actualizar el conjunto',
} or GetLocale() == 'esMX' and {
	['Ctrl-click'] = 'Ctrl+clic para eliminar este equipamiento',
	['Left-click'] = 'Clic izquierdo para cambiar el equipamiento',
	['Right-click'] = 'Clic derecho para abrir el Gestor de equipamiento',
	['Shift-click'] = 'May\195\186s+clic para modificar este equipamiento',
} or GetLocale() == 'ruRU' and {
	['Ctrl-click'] = 'Ctrl-клик, чтобы удалить комплект',
	['Left-click'] = 'Левая кнопка, чтобы переключить комплект',
	['Right-click'] = 'Правая кнопка, чтобы открыть управление экипировкой',
	['Shift-click'] = 'Shift-клик, чтобы обновить комплект',
} or {
	['Ctrl-click'] = 'Ctrl-click to delete set',
	['Left-click'] = 'Left-click to change your set',
	['Right-click'] = 'Right-click to open GearManager',
	['Shift-click'] = 'Shift-click to update set',
}
