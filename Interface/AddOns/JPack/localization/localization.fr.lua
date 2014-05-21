--[=[
	Language Localization: frFR
	Translated by: name <email address>
]=]

if GetLocale() ~= "frFR" then return end
local L = JPackLocale

L.TYPE_BAG = "Bag"
L.TYPE_FISHWEAPON = "Canne \195\160 p\195\170che"
L.TYPE_MISC = "Divers" -- subType of [Mining Pick] id:2901

JPACK_ORDER={"Pierre de foyer","##Montures","Pioche de mineur","Couteau \195\160 d\195\169pacer","Couteau de l'arm\195\169e gnome",
"Canne \195\160 p\195\170che","#Canne \195\160 p\195\170che","#Arme","#Arme##Autre","#Armure","#Armure##Autre","#Artisanat##Appareils",
"#Artisanat##Explosifs","#Recette","#Consommable##Potions","#Consommable##Parchemins","#Consommable","##\195\169l\195\169mentaire",
"##M\195\169tal & pierre","##Herbes","#Gemme","##Joaillerie","#Artisanat##Tissu","#Artisanat","#","#Divers","Fragment d'\195\162me",
"#Qu\195\170te"}
JPACK_DEPOSIT={"##\195\169l\195\169mentaire","##M\195\169tal & pierre","##Herbes","#Joaillerie","##Tissu"}
JPACK_DRAW={"#Qu\195\170te"}

L["HELP"] = "Taper '/jpack help' pour l'aide."
L["COMPLETE"] = "Compression finie..."
L["WARN"] = "Veuillez d閜oser l'objet maintenu sous la souris. Ne pas maintenir un item, de l'agent, un skill pendant la compression."
L["Unknown command"] = "Commande inconnue"

-- Help info
L["Slash command"] = "Commande Slash"
L["Pack"] = "Compresse"
L["Set sequence to ascend"] = "Ranger les objets au d\195\169but des sacs"
L["Set sequence to descend"] = "Ranger les objets \195\160 la fin des sacs"
L["Save to the bank"] = "Remplir les stacks de la banque depuis les sacs"
L["Load from the bank"] = "Remplir les stacks des sacs depuis la banque"
L["Packup guildbank"] = 'Compresser la banque de guilde'
L["Print help info"] = "Affiche les infos de l'aide"
