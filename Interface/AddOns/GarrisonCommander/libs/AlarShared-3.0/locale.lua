local MAJOR_VERSION = "AlarShared-3.0.localization"
local MINOR_VERSION = 1000
local lib,old=LibStub:NewLibrary(MAJOR_VERSION,MINOR_VERSION)
if not lib then return end
local me = "AlarShared"
local l=LibStub("AceLocale-3.0")
local L=l:NewLocale(me,"enUS",true,true)
L["Configuration"] = true
L["Description"] = true
L["Double Click to shrink"] = true
L["Libraries"] = true
L["Release Notes"] = true
L["Right Click to rescale"] = true
L["Toggles"] = true

L=l:NewLocale(me,"ptBR")
if (L) then
L["Configuration"] = "configura\195\167\195\163o"
L["Description"] = "Descri\195\167\195\163o"
L["Double Click to shrink"] = "Clique duas vezes para diminuir"
L["Libraries"] = "bibliotecas"
L["Release Notes"] = "Notas de Lan\195\167amento"
L["Right Click to rescale"] = "Clique direito para redimensionar"
L["Toggles"] = "Alterna"
return
end
L=l:NewLocale(me,"frFR")
if (L) then
L["Configuration"] = "configuration"
L["Description"] = "description"
L["Double Click to shrink"] = "Double Cliquez pour diminuer"
L["Libraries"] = "biblioth\195\168ques"
L["Release Notes"] = "notes de version"
L["Right Click to rescale"] = "Clic droit pour redimensionner"
L["Toggles"] = "Bascule"
return
end
L=l:NewLocale(me,"deDE")
if (L) then
L["Configuration"] = "Konfiguration"
L["Description"] = "Beschreibung"
L["Double Click to shrink"] = "Klicken Sie doppelt auf zu schrumpfen"
L["Libraries"] = "Bibliotheken"
L["Release Notes"] = "Release Notes"
L["Right Click to rescale"] = "Mit Rechtsklick neu skalieren"
L["Toggles"] = "Schaltet"
return
end
L=l:NewLocale(me,"koKR")
if (L) then
L["Configuration"] = "\234\181\172\236\132\177"
L["Description"] = "\236\132\164\235\170\133"
L["Double Click to shrink"] = "\235\141\148\235\184\148 \236\182\149\236\134\140 \237\129\180\235\166\173"
L["Libraries"] = "\235\157\188\236\157\180\235\184\140\235\159\172\235\166\172"
L["Release Notes"] = "\235\166\180\235\166\172\236\138\164 \235\133\184\237\138\184"
L["Right Click to rescale"] = "\236\152\164\235\165\184\236\170\189 \236\158\172\236\161\176\236\160\149 \237\129\180\235\166\173"
L["Toggles"] = "\236\160\132\237\153\152"
return
end
L=l:NewLocale(me,"esMX")
if (L) then
L["Configuration"] = "Configuraci\195\179n"
L["Description"] = "Descripci\195\179n"
L["Double Click to shrink"] = "Doble clic para encoger"
L["Libraries"] = "Bibliotecas"
L["Release Notes"] = "Notas de la versi\195\179n"
L["Right Click to rescale"] = "Haz clic derecho para cambiar la escala de"
L["Toggles"] = "Alterna"
return
end
L=l:NewLocale(me,"ruRU")
if (L) then
L["Configuration"] = "\208\154\208\190\208\189\209\132\208\184\208\179\209\131\209\128\208\176\209\134\208\184\209\143"
L["Description"] = "\208\158\208\191\208\184\209\129\208\176\208\189\208\184\208\181"
L["Double Click to shrink"] = "\208\148\208\178\208\190\208\185\208\189\208\190\208\185 \209\137\208\181\208\187\209\135\208\190\208\186 \209\129\208\190\208\186\209\128\208\176\209\137\208\176\209\130\209\140\209\129\209\143"
L["Libraries"] = "\208\145\208\184\208\177\208\187\208\184\208\190\209\130\208\181\208\186\208\184"
L["Release Notes"] = "\208\159\209\128\208\184\208\188\208\181\209\135\208\176\208\189\208\184\209\143 \208\186 \208\178\209\139\208\191\209\131\209\129\208\186\209\131"
L["Right Click to rescale"] = "\208\169\208\181\208\187\208\186\208\189\208\184\209\130\208\181 \208\191\209\128\208\176\208\178\208\190\208\185 \208\186\208\189\208\190\208\191\208\186\208\190\208\185 \208\188\209\139\209\136\208\184 \208\180\208\187\209\143 \208\184\208\183\208\188\208\181\208\189\208\181\208\189\208\184\209\143 \208\188\208\176\209\129\209\136\209\130\208\176\208\177\208\176"
L["Toggles"] = "\208\159\208\181\209\128\208\181\208\186\208\187\209\142\209\135\208\181\208\189\208\184\208\181"
end
L=l:NewLocale(me,"zhCN")
if (L) then
L["Configuration"] = "\233\133\141\231\189\174"
L["Description"] = "\232\175\180\230\152\142"
L["Double Click to shrink"] = "\229\143\140\229\135\187\232\144\142\231\188\169"
L["Libraries"] = "\229\155\190\228\185\166\233\166\134"
L["Release Notes"] = "\229\143\145\232\161\140\232\175\180\230\152\142"
L["Right Click to rescale"] = "\229\143\179\233\148\174\229\141\149\229\135\187\232\166\129\233\135\141\230\150\176\232\176\131\230\149\180"
L["Toggles"] = "\229\136\135\230\141\162"
return
end
L=l:NewLocale(me,"esES")
if (L) then
L["Configuration"] = "Configuraci\195\179n"
L["Description"] = "Descripci\195\179n"
L["Double Click to shrink"] = "Doble clic para encoger"
L["Libraries"] = "Bibliotecas"
L["Release Notes"] = "Notas de la versi\195\179n"
L["Right Click to rescale"] = "Haz clic derecho para cambiar la escala de"
L["Toggles"] = "Alterna"
return
end
L=l:NewLocale(me,"zhTW")
if (L) then
L["Configuration"] = "\233\133\141\231\189\174"
L["Description"] = "\232\175\180\230\152\142"
L["Double Click to shrink"] = "\229\143\140\229\135\187\232\144\142\231\188\169"
L["Libraries"] = "\229\155\190\228\185\166\233\166\134"
L["Release Notes"] = "\229\143\145\232\161\140\232\175\180\230\152\142"
L["Right Click to rescale"] = "\229\143\179\233\148\174\229\141\149\229\135\187\232\166\129\233\135\141\230\150\176\232\176\131\230\149\180"
L["Toggles"] = "\229\136\135\230\141\162"
return
end
L=l:NewLocale(me,"itIT")
if (L) then
L["Configuration"] = "Configurazione"
L["Description"] = "Descrizione"
L["Double Click to shrink"] = "Doppio click per rimpicciolire"
L["Libraries"] = "Librerie"
L["Release Notes"] = "Note di rilascio"
L["Right Click to rescale"] = "Click destro per cambiare la scala"
L["Toggles"] = "Interruttori"
end