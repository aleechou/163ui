--[=[
	Language Localization: deDE
	Translated by: paterbrown <paterbrown@silberhelme.de>
]=]

if GetLocale() ~= "deDE" then return end
local L = JPackLocale

L.TYPE_BAG="Behälter"
L.TYPE_FISHWEAPON="Angelruten"

JPACK_ORDER={"Ruhestein","##Reittiere","Spitzhacke","Kürschnermesser","Angelrute","##Angelruten",
"#Waffe","#Rüstung","#Waffe##Verschiedenes","#Rüstung##Verschiedenes","#Rezept",
"#Quest","##Elementar","##Metall & Stein","##Kräuter","#Edelstein","##Juwelenschleifen",
"#Verbrauchbar","##Stoff","#Handwerkswaren","##Fleisch","#","Fischöl","Seelenstein","#Verschiedenes"}
JPACK_DEPOSIT={"##Elementar","##Metall & Stein","##Kräuter","#Juwelenschleifen","#Behälter"}
JPACK_DRAW={"#Quest"}

L["HELP"] = 'Tippe "/jpack help" für Hilfe.'
L["COMPLETE"] = "Packen fertig..."
L["WARN"] = "Lege bitte den Gegenstand ab. Du kannst Gegenstände, Gold oder Fähigkeiten nicht halten oder anklicken beim packen."
L["Unknown command"] = "Unbekannter Befehl"

-- Help info
L["Slash command"] = "Chatbefehl"
L["Pack"] = "Packen"
L["Set sequence to ascend"] = "Setze aufsteigende Reihenfolge"
L["Set sequence to descend"] = "Setze absteigende Reihenfolge"
L["Save to the bank"] = "Sichere zur Bank"
L["Load from the bank"] = "Lade von der Bank"
L["Print help info"] = "Zeige Hilfe"

L["Sequence"] = "Reihenfolge"
L["asc"] = "Aufsteigend"
L["desc"] = "Absteigend"

L["Click"] = "Linksklick"
L["Pack"] = "Packen"

L["Shift + Left-Click"] = "SHIFT + Linksklick"
L["Ctrl + Left-Click"] = "CTRL + Linksklick"
L["Shift + Right-Click"] = "SHIFT + Rechtsklick"
L["Ctrl + Right-Click"] = "CTRL + Rechtsklick"
