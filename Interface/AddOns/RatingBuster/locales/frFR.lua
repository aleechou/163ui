--[[
Name: RatingBuster frFR locale (incomplete)
Revision: $Revision: 339 $
Translated by:
- Tixu@Curse, Silaor and renchap
]]

local L = LibStub("AceLocale-3.0"):NewLocale("RatingBuster", "frFR")
if not L then return end
-- This file is coded in UTF-8
-- If you don't have a editor that can save in UTF-8, I recommend NotePad++ or Ultraedit
----
-- To translate AceLocale strings, replace true with the translation string
-- Before: L["Show Item ID"] = true,
-- After:  L["Show Item ID"] = "顯示物品編號",
---------------
-- Waterfall --
---------------
-- Waterfall --
---------------
L["RatingBuster Options"] = "Options de RatingBuster"
L["Enabled"] = "Activé"
L["Suspend/resume this addon"] = "Active ou non cet addon."
---------------------------
-- Slash Command Options --
---------------------------
L["Always"] = "Toujours"
L["ALT Key"] = "Touche ALT"
L["CTRL Key"] = "Touche CTRL"
L["SHIFT Key"] = "Touche MAJ"
L["Never"] = "Jamais"
L["General Settings"] = "Paramètres généraux"
L["Profiles"] = "Profils"
-- /rb win
L["Options Window"] = "Options"
L["Shows the Options Window"] = "Affiche la fenêtre des options"
-- /rb hidebzcomp
L["Hide Blizzard Item Comparisons"] = "Masquer le sommaire de Blizzard"
L["Disable Blizzard stat change summary when using the built-in comparison tooltip"] = "Ne pas afficher le sommaire de statistisques par défaut dans les infobulles"
-- /rb statmod
L["Enable Stat Mods"] = "Activer Stat Mods"
L["Enable support for Stat Mods"] = "Activer le support pour Stat Mods"
-- /rb subtract_equip
--L["Enable Subtract Equipped Stats"] = ""
--L["Enable for more accurate calculation of Mana Regen from Intellect and Spirit, and diminishing stats like Dodge, Parry, Resilience"] = ""
-- /rb usereqlv
L["Use Required Level"] = "Utiliser le niveau requis"
L["Calculate using the required level if you are below the required level"] = "Effectue les calculs des conversions en utilisant le niveau requis par l'objet s'il n'est pas atteint par le joueur."
-- /rb level
L["Set Level"] = "Définir le niveau"
L["Set the level used in calculations (0 = your level)"] = "Définir le niveau du personnage utilisé pour l'évaluation des statistiques (0 = votre niveau)."
-- /rb ilvlid
--L["Item Level and ID"] = ""
--L["Settings for Item Level and Item ID"] = ""
-- /rb ilvlid coloritemlevel
--L["Colorize Item Level"] = ""
--L["Customize the color of the Item Level text"] = ""
-- /rb ilvlid itemlevelall
--L["Show Item Level on all items"] = ""
--L["Display the Item Level on all items instead of just on equippable items"] = ""
-- /rb ilvlid itemid
--L["Show Item ID"] = ""
--L["Display the Item ID on all items"] = ""
---------------------------------------------------------------------------
-- /rb rating
L["Rating"] = "Score"
L["Options for Rating display"] = "Options pour l'affichage des scores"
-- /rb rating show
L["Show Rating Conversions"] = "Afficher les conversions de score"
L["Select when to show rating conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Définir si conversions de scores sont affichées en fonction d'un raccourcis clavier" 
-- /rb rating spell
L["Show Spell Hit/Haste"] = "Voir les conversions +Hâte/+Toucher pour les sorts"
L["Show Spell Hit/Haste from Hit/Haste Rating"] = "Voir les conversions +Hâte/+Toucher pour les sorts"
-- /rb rating physical
L["Show Physical Hit/Haste"] = "Voir les conversions +Hâte/+Toucher pour la mélée"
L["Show Physical Hit/Haste from Hit/Haste Rating"] = "Voir les conversions +Hâte/+Toucher pour la mélée"
-- /rb rating detail
L["Show Detailed Conversions Text"] = "Expertise/Résilience détaillées"
L["Show detailed text for Resilience and Expertise conversions"] = "Utiliser les conversions détaillées pour l'expertise et la résilience"
-- /rb rating exp
L["Expertise Breakdown"] = "Expertise avancée"
L["Convert Expertise into Dodge Neglect and Parry Neglect"] = "Pour l'expertise, afficher plutôt l'effet sur l'esquive et la parade adverse"
---------------------------------------------------------------------------
-- /rb rating color
L["Change Text Color"] = "Modifier la couleur"
L["Changes the color of added text"] = "Modifier la couleur des conversions"
-- /rb rating color pick
L["Pick Color"] = "Sélectionner une couleur"
L["Pick a color"] = "Sélectionner une couleur"
-- /rb rating color enable
L["Enable Color"] = "Activer couleur"
L["Enable colored text"] = "Activer la coloration des conversions"
---------------------------------------------------------------------------

-- /rb stat
L["Stat Breakdown"] = "Conversion de caractéristiques"
L["Changes the display of base stats"] = "Indiquer l'effet des caracteristiques principales sur les statistiques secondaires"
-- /rb stat show
L["Show Base Stat Conversions"] = "Montrer conversion de caractéristiques"
L["Select when to show base stat conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Définir si conversions de caracteristiques sont affichées en fonction d'un raccourcis clavier"
---------------------------------------------------------------------------
-- /rb stat str
L["Strength"] = "Force"
L["Changes the display of Strength"] = "Modifie l'affichage de la force."
-- /rb stat str ap
L["Show Attack Power"] = "Puissance d'attaque"
L["Show Attack Power from Strength"] = "Affiche la puissance d'attaque produite par la force."
-- /rb stat str block
L["Show Block Value"] = "Blocage"
L["Show Block Value from Strength"] = "Affiche la valeur de blocage produite par la force."
-- /rb stat str dmg
L["Show Spell Damage"] = "Dégats des sorts"
L["Show Spell Damage from Strength"] = "Affiche le bonus de dégats des sorts produit par la force."
-- /rb stat str heal
L["Show Healing"] = "Soins"
L["Show Healing from Strength"] = "Affiche le bonus aux soins aproduit par la force."
-- /rb stat str parry
L["Show Parry"] = "Parade"
L["Show Parry from Strength"] = "Affiche le bonus de parade produit par la force."
---------------------------------------------------------------------------
-- /rb stat agi
L["Agility"] = "Agilité"
L["Changes the display of Agility"] = "Modifie l'affichage de l'agilité"
-- /rb stat agi crit
L["Show Crit"] = "Coups critiques"
L["Show Crit chance from Agility"] = "Affiche le bonus aux coups critiques produit par l'agilité."
-- /rb stat agi dodge
L["Show Dodge"] = "Esquive"
L["Show Dodge chance from Agility"] = "Affiche le pourcentage d'esquive produit par l'agilité."
-- /rb stat agi ap
L["Show Attack Power"] = "Puissance d'attaque"
L["Show Attack Power from Agility"] = "Affiche la puissance d'attaque produite par l'agilité."
-- /rb stat agi rap
L["Show Ranged Attack Power"] = "Puissance d'attaque à distance"
L["Show Ranged Attack Power from Agility"] = "Affiche la puissance d'attaque à distance produite par l'agilité."
-- /rb stat agi heal
L["Show Healing"] = "Soins"
L["Show Healing from Agility"] = "Affiche le bonus aux soins produit par l'agilité."
---------------------------------------------------------------------------
-- /rb stat sta
L["Stamina"] = "Endurance"
L["Changes the display of Stamina"] = "Modifie l'affichage de l'endurance"
-- /rb stat sta hp
L["Show Health"] = "Points de vie"
L["Show Health from Stamina"] = "Affiche les points de vies produits par l'endurance."
-- /rb stat sta dmg
L["Show Spell Damage"] = "Dégats des sorts"
L["Show Spell Damage from Stamina"] = "Affiche le bonus aux dégats des sorts produit par l'endurance."
-- /rb stat sta heal
L["Show Healing"] = "Soins"
L["Show Healing from Stamina"] = "Affiche le bonus aux soins produit par l'endurance."
-- /rb stat sta ap
L["Show Attack Power"] = "Puissance d'attaque"
L["Show Attack Power from Stamina"] = "Affiche la puissance d'attaque produite par l'endurance."
---------------------------------------------------------------------------
-- /rb stat int
L["Intellect"] = "Intelligence"
L["Changes the display of Intellect"] = "Modifie l'affichage de l'intelligence"
-- /rb stat int spellcrit
L["Show Spell Crit"] = "Critique des sorts"
L["Show Spell Crit chance from Intellect"] = "Affiche le bonus aux critiques des sorts produit par l'intelligence."
-- /rb stat int mp
L["Show Mana"] = "Mana"
L["Show Mana from Intellect"] = "Affiche la mana produite par l'intelligence."
-- /rb stat int dmg
L["Show Spell Damage"] = "Dégats des sorts"
L["Show Spell Damage from Intellect"] = "Affiche le bonus aux dégats des sorts produit par l'intelligence."
-- /rb stat int heal
L["Show Healing"] = "Soins"
L["Show Healing from Intellect"] = "Affiche le bonus aux soins produit par l'intelligence."
-- /rb stat int mp5
L["Show Combat Mana Regen"] = "Mp5 (combat)"
L["Show Mana Regen while in combat from Intellect"] = "Affiche la regénération de mana/5sec produite par l'intelligence, en combat."
 --/rb stat int mp5oc
L["Show Normal Mana Regen"] = "Mp5"
L["Show Mana Regen while not in combat from Intellect"] = "Affiche la regénération de mana/5sec produite par l'intelligence, hors combat."
-- /rb stat int rap
L["Show Ranged Attack Power"] = "Puissance d'attaque à distance"
L["Show Ranged Attack Power from Intellect"] = "Affiche la puissance d'attaque à distance produite par l'intelligence."
-- /rb stat int ap
L["Show Attack Power"] = "Puissance d'attaque"
L["Show Attack Power from Intellect"] = "Affiche la puissance d'attaque produite par l'intelligence."
---------------------------------------------------------------------------
L["Spirit"] = "Esprit"
L["Changes the display of Spirit"] = "Modifie l'affichage de l'esprit"
-- /rb stat spi mp5
L["Show Combat Mana Regen"] =  "Mp5 (combat)"
L["Show Mana Regen while in combat from Spirit"] = "Affiche la regénération de mana/5sec produite par l'esprit, en combat."
-- /rb stat spi mp5oc
L["Show Normal Mana Regen"] = "Mp5 (hors combat)"
L["Show Mana Regen while not in combat from Spirit"] = "Affiche la regénération de mana/5sec produite par l'esprit, hors combat."
-- /rb stat spi hp5
L["Show Normal Health Regen"] = "Vie regen"
L["Show Health Regen while not in combat from Spirit"] = "Affiche la regénération de vie/5sec produite par l'esprit, hors combat."
-- /rb stat spi dmg
L["Show Spell Damage"] = "Dégats des sorts"
L["Show Spell Damage from Spirit"] = "Affiche le bonus aux dégats des sorts produit par l'esprit"
-- /rb stat spi heal
L["Show Healing"] = "Soins"
L["Show Healing from Spirit"] = "Affiche le bonus aux soins produit par l'esprit"
-- /rb stat spi spellcrit
L["Show Spell Crit"] = "Critique des sorts"
L["Show Spell Crit chance from Spirit"] = "Affiche le bonus aux critiques des sorts produit par l'esprit."
-- /rb stat spi spellhitrating
L["Show Spell Hit Rating"] = "Toucher des sorts (score)"
L["Show Spell Hit Rating from Spirit"] = "Affiche le bonus au toucher des sorts produit par l'esprit (score)."
-- /rb stat spi spellhit
L["Show Spell Hit"] = "Toucher des sorts (%)"
L["Show Spell Hit from Spirit"] = "Affiche le bonus au toucher des sorts produit par l'esprit (en %)."

---------------------------------------------------------------------------
-- /rb stat armor
L["Armor"] = "Armure"
L["Changes the display of Armor"] = "Modifie l'affichage de l'armure"
-- /rb stat armor ap
L["Show Attack Power"] = "Puissance d'attaque"
L["Show Attack Power from Armor"] = "Affiche la puissance d'attaque produite par l'armure"
---------------------------------------------------------------------------
-- /rb sum
L["Stat Summary"] = true
L["Options for stat summary"] = "Option du compte rendu global des statitstiques de l'objet."
-- /rb sum show
L["Show Stat Summary"] = "Voir le compte rendu"
L["Select when to show stat summary in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Définir si le compte rendu de statistiques est affiché en fonction d'un raccourcis clavier" 
-- /rb sum ignore
L["Ignore Settings"] = "Restrictions"
L["Ignore stuff when calculating the stat summary"] = "Indiquer les restrictions souhaitées"
-- /rb sum ignore unused
L["Ignore Undesirable Items"] = "Paramètres d'objets"
L["Hide stat summary for undesirable items"] = "Ne pas afficher le compte rendu selon certains critères d'objets"
-- /rb sum ignore quality
L["Minimum Item Quality"] = "Qualité minimale"
L["Show stat summary only for selected quality items and up"] = "Afficher le compte rendu pour les objets ayant une qualité minimale"
-- /rb sum ignore armor
L["Armor Types"] = "Type d'armure"
L["Select armor types you want to ignore"] = "Restreindre les objets en fonction de leur type d'armure "
-- /rb sum ignore armor cloth
L["Ignore Cloth"] = "Ignorer Tissu"
L["Hide stat summary for all cloth armor"] = "Ne pas afficher de compte rendu pour les armures en Tissu"
-- /rb sum ignore armor leather
L["Ignore Leather"] = "Ignorer Cuir"
L["Hide stat summary for all leather armor"] = "Ne pas afficher de compte rendu pour les armures en Cuir"
-- /rb sum ignore armor mail
L["Ignore Mail"] = "Ignorer Maille"
L["Hide stat summary for all mail armor"] = "Ne pas afficher de compte rendu pour les armures de Maille"
-- /rb sum ignore armor plate
L["Ignore Plate"] = "Ignorer Plaque"
L["Hide stat summary for all plate armor"] = "Ne pas afficher de compte rendu pour les armures de Plaque"
-- /rb sum ignore equipped
L["Ignore Equipped Items"] = "Ignorer les objets équipés"
L["Hide stat summary for equipped items"] = "Ne pas afficher de compte rendu pour les objets équipés"
-- /rb sum ignore enchant
L["Ignore Enchants"] = "Ignorer les enchantements"
L["Ignore enchants on items when calculating the stat summary"] = "Ne pas tenir compte des enchantements"
-- /rb sum ignore gem
L["Ignore Gems"] = "Ignorer les gemmes"
L["Ignore gems on items when calculating the stat summary"] = "Ne pas tenir compte des gemmes"
-- /rb sum ignore prismaticSocket
L["Ignore Prismatic Sockets"] = "Ignorer les gemmes prismatiques"
L["Ignore gems in prismatic sockets when calculating the stat summary"] = "Ne pas tenir compte des gemmes prismatiques"
-- /rb sum diffstyle
L["Display Style For Diff Value"] = "Style des comparaisons"
L["Display diff values in the main tooltip or only in compare tooltips"] = "Options de style des comparaisons"
-- /rb sum space
L["Add Empty Line"] = "Saut de ligne"
L["Add a empty line before or after stat summary"] = "Ajouter une ligne vide apres ou après le compte rendu"
-- /rb sum space before
L["Add Before Summary"] = "Saut de ligne (avant)"
L["Add a empty line before stat summary"] = "Ajouter une ligne vide avant le compte rendu"
-- /rb sum space after
L["Add After Summary"] = "Saut de ligne (après)"
L["Add a empty line after stat summary"] = "Ajouter une ligne vide après le compte rendu"
-- /rb sum icon
L["Show Icon"] = "Afficher l'icone"
L["Show the sigma icon before summary listing"] = "Afficher l'icone de compte rendu (Epsilon)"
-- /rb sum title
L["Show Title Text"] = "Afficher le titre"
L["Show the title text before summary listing"] = "Afficher le titre du compte rendu"
-- /rb sum showzerostat
L["Show Zero Value Stats"] = "Lister les valeurs nulles (0)"
L["Show zero value stats in summary for consistancy"] = "Lister les valeurs nulles (0) dans le compte rendu"
-- /rb sum calcsum
L["Calculate Stat Sum"] = "Etablir un compte rendu"
L["Calculate the total stats for the item"] = "Etablir un compte rendu de statistiques de l'objet"
-- /rb sum calcdiff
L["Calculate Stat Diff"] = "Comparer avec l'objet equipé"
L["Calculate the stat difference for the item and equipped items"] = "Comparer cet objet avec l'objet actuellement equipé"
-- /rb sum sort
L["Sort StatSummary Alphabetically"] = "Classer le compte rendu par ordre alphabétique"
L["Enable to sort StatSummary alphabetically, disable to sort according to stat type(basic, physical, spell, tank)"] = "Classer le compte rendu par ordre alphabétique"
-- /rb sum avoidhasblock
L["Include Block Chance In Avoidance Summary"] = "Inclure le blocage"
L["Enable to include block chance in Avoidance summary, Disable for only dodge, parry, miss"] = "Inclure le blocage dans le total d'evitement. Desactiver pour ne prendre en compte que l'esquive et la parade"
---------------------------------------------------------------------------



---------------------------------------------------------------------------
-- /rb sum basic
L["Stat - Basic"] = "Statistiques - Caracteristiques"
L["Choose basic stats for summary"] = "Choisir les statistiques de base à afficher"
-- /rb sum basic hp
L["Sum Health"] = "Cumul point de vie"
L["Health <- Health, Stamina"] = "Points de vie <- Endurance, point de vie"
-- /rb sum basic mp
L["Sum Mana"] = "Cumul mana"
L["Mana <- Mana, Intellect"] = "Cumul mana <- Mana, Intell."
-- /rb sum basic mp5
L["Sum Combat Mana Regen"] = "Cumul MP5 (combat)"
L["Combat Mana Regen <- Mana Regen, Spirit"] = "Cumul MP5 (combat) <- Esprit, Mana regen"
-- /rb sum basic mp5oc
L["Sum Normal Mana Regen"] = "Cumul MP5 (hors combat)"
L["Normal Mana Regen <- Spirit"] = "Cumul MP5 (hors combat) <- Esprit"
-- /rb sum basic hp5
L["Sum Combat Health Regen"] = "Cumul HP5 (combat)"
L["Combat Health Regen <- Health Regen"] = "Cumul HP5 (combat) <- Vie regen"
-- /rb sum basic hp5oc
L["Sum Normal Health Regen"] = "Cumul HP5 (hors combat)"
L["Normal Health Regen <- Spirit"] = "Cumul HP5 (hors combat) <- Esprit"
-- /rb sum basic str
L["Sum Strength"] = "Cumul Force"
L["Strength Summary"] = "Cumul Force"
-- /rb sum basic agi
L["Sum Agility"] = "Cumul Agilité"
L["Agility Summary"] = "Cumul Agilité"
-- /rb sum basic sta
L["Sum Stamina"] = "Cumul Endurance"
L["Stamina Summary"] = "Cumul Endurance"
-- /rb sum basic int
L["Sum Intellect"] = "Cumul Intelligence"
L["Intellect Summary"] = "Cumul Intelligence"
-- /rb sum basic spi
L["Sum Spirit"] = "Cumul Esprit"
L["Spirit Summary"] = "Cumul Esprit"
-- /rb sum basic mastery
L["Sum Mastery"] = "Cumul ratio Maîtrise"
L["Mastery Summary"] = "Cumul ratio Maîtrise"
-- /rb sum basic masteryrating
L["Sum Mastery Rating"] = "Cumul Maîtrise"
L["Mastery Rating Summary"] = "Cumul Maîtrise"

---------------------------------------------------------------------------
-- /rb sum physical
L["Stat - Physical"] = "Statistiques - Mélée/Distance"
L["Choose physical damage stats for summary"] = true
-- /rb sum physical ap
L["Sum Attack Power"] = "Cumul Puissance d'attaque"
L["Attack Power <- Attack Power, Strength, Agility"] = true
-- /rb sum physical rap
L["Sum Ranged Attack Power"] = "Cumul Puissance d'attaque (Dist)"
L["Ranged Attack Power <- Ranged Attack Power, Intellect, Attack Power, Strength, Agility"] = true
-- /rb sum physical hit
L["Sum Hit Chance"] = "Cumul %Toucher"
L["Hit Chance <- Hit Rating"] = true
-- /rb sum physical hitrating
L["Sum Hit Rating"] = "Cumul Toucher"
L["Hit Rating Summary"] = true
-- /rb sum physical crit
L["Sum Crit Chance"] = "Cumul %Crit."
L["Crit Chance <- Crit Rating, Agility"] = true
-- /rb sum physical critrating
L["Sum Crit Rating"] = "Cumul Crit."
L["Crit Rating Summary"] = true
-- /rb sum physical haste
L["Sum Haste"] = "Cumul %Hâte"
L["Haste <- Haste Rating"] = true
-- /rb sum physical hasterating
L["Sum Haste Rating"] = "Cumul Hâte"
L["Haste Rating Summary"] = true
-- /rb sum physical rangedhit
L["Sum Ranged Hit Chance"] = "Cumul %Toucher (dist)"
L["Ranged Hit Chance <- Hit Rating, Ranged Hit Rating"] = true
-- /rb sum physical rangedhitrating
L["Sum Ranged Hit Rating"] = "Cumul Toucher (dist)"
L["Ranged Hit Rating Summary"] = true
-- /rb sum physical rangedcrit
L["Sum Ranged Crit Chance"] = "Cumul %Crit. (dist)"
L["Ranged Crit Chance <- Crit Rating, Agility, Ranged Crit Rating"] = true
-- /rb sum physical rangedcritrating
L["Sum Ranged Crit Rating"] = "Cumul Crit. (dist)"
L["Ranged Crit Rating Summary"] = true
-- /rb sum physical rangedhaste
L["Sum Ranged Haste"] = "Cumul %Hâte (dist)"
L["Ranged Haste <- Haste Rating, Ranged Haste Rating"] = true
-- /rb sum physical rangedhasterating
L["Sum Ranged Haste Rating"] = "Cumul Hâte (dist)"
L["Ranged Haste Rating Summary"] = true
-- /rb sum physical maxdamage
L["Sum Weapon Max Damage"] = "Cumul Domages max."
L["Weapon Max Damage Summary"] = true
-- /rb sum physical exp
L["Sum Expertise"] = "Cumul ratio Expertise"
L["Expertise <- Expertise Rating"] = "Cumul ratio Expertise"
-- /rb sum physical exprating
L["Sum Expertise Rating"] = "Cumul Expertise"
L["Expertise Rating Summary"] = true
---------------------------------------------------------------------------
-- /rb sum spell
L["Stat - Spell"] = "Statistiques - Sorts"
L["Choose spell damage and healing stats for summary"] = true
-- /rb sum spell power
L["Sum Spell Power"] = "Cumul Puissance des sorts"
L["Spell Power <- Spell Power, Intellect, Agility, Strength"] = "Cumul Puissance des sorts <- Puissance des sorts, Intell"

-- /rb sum spell crit
L["Sum Spell Crit Chance"] = "Cumul %Crit.sorts"
L["Spell Crit Chance <- Spell Crit Rating, Intellect"] = true
-- /rb sum spell hit
L["Sum Spell Hit Chance"] =  "Cumul %Toucher sorts"
L["Spell Hit Chance <- Spell Hit Rating"] = true
-- /rb sum spell haste
L["Sum Spell Haste"] =  "Cumul %Hâte.sorts"
L["Spell Haste <- Spell Haste Rating"] = true
-- /rb sum spell pen
L["Sum Penetration"] = "Cumul Pénétration"
L["Spell Penetration Summary"] = true
-- /rb sum spell hitrating
L["Sum Spell Hit Rating"] = "Cumul Toucher sorts"
L["Spell Hit Rating Summary"] = true
-- /rb sum spell critrating
L["Sum Spell Crit Rating"] = "Cumul Crit.sorts"
L["Spell Crit Rating Summary"] = true
-- /rb sum spell hasterating
L["Sum Spell Haste Rating"] = "Cumul Hâte.sorts"
L["Spell Haste Rating Summary"] = true
--------------------------------------------------------------------------


-- /rb sum tank
L["Stat - Tank"] = "Statistiques - Tanks"
L["Choose tank stats for summary"] = true

-- /rb sum tank armor
L["Sum Armor"] = "Cumul Armure"
L["Armor <- Armor from items and bonuses"] = true
-- /rb sum tank dodge
L["Sum Dodge Chance"] = "Cumul %Esquive"
L["Dodge Chance <- Dodge Rating, Agility"] = true
-- /rb sum tank parry
L["Sum Parry Chance"] = "Cumul %Parade"
L["Parry Chance <- Parry Rating"] = true
-- /rb sum tank block
L["Sum Block Chance"] = "Cumul %Bloc"
L["Block Chance <- Block Rating"] = "Cumul %Bloc"
-- /rb sum tank neglectdodge
L["Sum Dodge Neglect"] = "Cumul %Esquive ignorée"
L["Dodge Neglect <- Expertise"] = "Cumul %Esquive ignorée <- Expertise"
-- /rb sum tank neglectparry
L["Sum Parry Neglect"] = "Cumul %Parade ignorée"
L["Parry Neglect <- Expertise"] = "Cumul %Parade ignorée <- Expertise"
-- /rb sum tank resarcane
L["Sum Arcane Resistance"] = "Cumul resist Arcane"
L["Arcane Resistance Summary"] = true
-- /rb sum tank resfire
L["Sum Fire Resistance"] = "Cumul resist Feu"
L["Fire Resistance Summary"] = true
-- /rb sum tank resnature
L["Sum Nature Resistance"] = "Cumul resist Nature"
L["Nature Resistance Summary"] = true
-- /rb sum tank resfrost
L["Sum Frost Resistance"] = "Cumul resist Givre"
L["Frost Resistance Summary"] = true
-- /rb sum tank resshadow
L["Sum Shadow Resistance"] = "Cumul resist Ombre"
L["Shadow Resistance Summary"] = true
-- /rb sum tank dodgerating
L["Sum Dodge Rating"] = "Cumul Esquive"
L["Dodge Rating Summary"] = true
-- /rb sum tank parryrating
L["Sum Parry Rating"] = "Cumul Parade"
L["Parry Rating Summary"] = true
-- /rb sum tank blockrating
L["Sum Block Rating"] = "Cumul Bloc"
L["Block Rating Summary"] = true
-- /rb sum tank res
L["Sum Resilience"] = "Cumul Résilience"
L["Resilience Summary"] = true
-- /rb sum tank tp
L["Sum TankPoints"] = "Cumul Tankpoint"
L["TankPoints <- Health, Total Reduction"] = true
-- /rb sum tank tr
L["Sum Total Reduction"] = "Cumul Mitigation"
L["Total Reduction <- Armor, Dodge, Parry, Block, MobMiss, MobCrit, MobCrush, DamageTakenMods"] = true
-- /rb sum tank avoid
L["Sum Avoidance"] = "Cumul Evitement"
L["Avoidance <- Dodge, Parry, MobMiss, Block(Optional)"] = true

---------------------------------------------------------------------------
-- /rb sum gemset
L["Gem Set"] = "Gemmes prédefinies"
L["Select a gem set to configure"] = "Prédéfinir des ensembles de gemmes"
L["Default Gem Set 1"] = "Gemmes prédefinies - 1"
L["Default Gem Set 2"] = "Gemmes prédefinies - 2"
L["Default Gem Set 3"] = "Gemmes prédefinies - 3"
-- /rb sum gem
L["Auto fill empty gem slots"] = "Inclure les gemmes predefinies dans les chasses vides"
-- /rb sum gem red
L["Red Socket"] = EMPTY_SOCKET_RED
L["ItemID or Link of the gem you would like to auto fill"] = "Entrez l'id, ou le lien de la gemme prédéfinie"
L["<ItemID|Link>"] = "<ItemID|Lien>"
L["|cffffff7f%s|r is now set to |cffffff7f[%s]|r"] = "La |cffffff7f%s|r est maintenant réglée sur |cffffff7f[%s]|r"
L["Invalid input: %s. ItemID or ItemLink required."] = "Lien ou ID de gemme invalide"
L["Queried server for Gem: %s. Try again in 5 secs."] = "Requête serveur pour: %s. Tentative suivante dans 5secs."
-- /rb sum gem yellow
L["Yellow Socket"] = EMPTY_SOCKET_YELLOW
-- /rb sum gem blue
L["Blue Socket"] = EMPTY_SOCKET_BLUE
-- /rb sum gem meta
L["Meta Socket"] = EMPTY_SOCKET_META
-- /rb sum gem2
L["Second set of default gems which can be toggled with a modifier key"] = "L'utilisation de l'ensemble 2 peut etre assigné à un raccourcis clavier"
L["Can't use the same modifier as Gem Set 3"] = "Impossible d'utiliser le même raccourcis que l'ensemble 3"
-- /rb sum gem2 key
L["Toggle Key"] = "Raccourcis clavier"
L["Use this key to toggle alternate gems"] = "Utiliser ce raccourcis pour alterner l'utilisation des sets de gemmes"
-- /rb sum gem3
L["Third set of default gems which can be toggled with a modifier key"] = "L'utilisation de l'ensemble 3 peut etre assigné à un raccourcis clavier"
L["Can't use the same modifier as Gem Set 2"] = "Impossible d'utiliser le même raccourcis que l'ensemble 2"

-----------------------
-- Item Level and ID --
-----------------------
L["ItemLevel: "] = "Niveau d'objet :"
L["ItemID: "] = "ID de l'objet :"
-----------------------
-- Matching Patterns --
-----------------------
-- Items to check --
--------------------
-- [Potent Ornate Topaz]
-- +6 Spell Damage, +5 Spell Crit Rating
--------------------
-- ZG enchant
-- +10 Defense Rating/+10 Stamina/+15 Block Value
--------------------
-- [Glinting Flam Spessarite]
-- +3 Hit Rating and +3 Agility
--------------------
-- ItemID: 22589
-- [Atiesh, Greatstaff of the Guardian] warlock version
-- Equip: Increases the spell critical strike rating of all party members within 30 yards by 28.
--------------------
-- [Brilliant Wizard Oil]
-- Use: While applied to target weapon it increases spell damage by up to 36 and increases spell critical strike rating by 14 . Lasts for 30 minutes.
----------------------------------------------------------------------------------------------------
-- I redesigned the tooltip scanner using a more locale friendly, 2 pass matching matching algorithm.
--
-- The first pass searches for the rating number, the patterns are read from L["numberPatterns"] here,
-- " by (%d+)" will match strings like: "Increases defense rating by 16."
-- "%+(%d+)" will match strings like: "+10 Defense Rating"
-- You can add additional patterns if needed, its not limited to 2 patterns.
-- The separators are a table of strings used to break up a line into multiple lines what will be parsed seperately.
-- For example "+3 Hit Rating, +5 Spell Crit Rating" will be split into "+3 Hit Rating" and " +5 Spell Crit Rating"
--
-- The second pass searches for the rating name, the names are read from L["statList"] here,
-- It will look through the table in order, so you can put common strings at the begining to speed up the search,
-- and longer strings should be listed first, like "spell critical strike" should be listed before "critical strike",
-- this way "spell critical strike" does get matched by "critical strike".
-- Strings need to be in lower case letters, because string.lower is called on lookup
--
-- IMPORTANT: there may not exist a one-to-one correspondence, meaning you can't just translate this file,
-- but will need to go in game and find out what needs to be put in here.
-- For example, in english I found 3 different strings that maps to CR_CRIT_MELEE: "critical strike", "critical hit" and "crit".
-- You will need to find out every string that represents CR_CRIT_MELEE, and so on.
-- In other languages there may be 5 different strings that should all map to CR_CRIT_MELEE.
-- so please check in game that you have all strings, and not translate directly off this table.
--
-- Tip1: When doing localizations, I recommend you set debugging to true in RatingBuster.lua
-- Find RatingBuster:SetDebugging(false) and change it to RatingBuster:SetDebugging(true)
-- or you can type /rb debug to enable it in game
--
-- Tip2: The strings are passed into string.find, so you should escape the magic characters ^$()%.[]*+-? with a %
L["numberPatterns"] = {
	{pattern = "de (%d+)", addInfo = "AfterNumber", space = " ", },
	{pattern = "([%+%-]%d+)[^%%]", addInfo = "AfterStat", space = " ", },
	{pattern = "(%d+)([^%d%%|]+)", addInfo = "AfterStat", space = " ", }, 
}
L["separators"] = {
	"/", " et ", "%. ", " pour ", "&", ":",
	"augmente",
}
--[[ Rating ID
CR_WEAPON_SKILL = 1;
CR_DEFENSE_SKILL = 2;
CR_DODGE = 3;
CR_PARRY = 4;
CR_BLOCK = 5;
CR_HIT_MELEE = 6;
CR_HIT_RANGED = 7;
CR_HIT_SPELL = 8;
CR_CRIT_MELEE = 9;
CR_CRIT_RANGED = 10;
CR_CRIT_SPELL = 11;
CR_HIT_TAKEN_MELEE = 12;
CR_HIT_TAKEN_RANGED = 13;
CR_HIT_TAKEN_SPELL = 14;
COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15;
COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16;
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
--
SPELL_STAT1_NAME = "Strength"
SPELL_STAT2_NAME = "Agility"
SPELL_STAT3_NAME = "Stamina"
SPELL_STAT4_NAME = "Intellect"
SPELL_STAT5_NAME = "Spirit"
--]]

-- TODO: Find a way to insert the two crit entries without copying the whole table from enUS.
L["statList"] = {
	{pattern = "score de critique", id = CR_CRIT_MELEE}, --Crit
	{pattern = "score de coup critique", id = CR_CRIT_MELEE}, --Crit
	
--Stats
	{pattern = string.lower(ARMOR), id = ARMOR},
	{pattern = string.lower(SPELL_STAT1_NAME), id = SPELL_STAT1_NAME}, -- Strength
	{pattern = string.lower(SPELL_STAT2_NAME), id = SPELL_STAT2_NAME}, -- Agility
	{pattern = string.lower(SPELL_STAT3_NAME), id = SPELL_STAT3_NAME}, -- Stamina
	{pattern = string.lower(SPELL_STAT4_NAME), id = SPELL_STAT4_NAME}, -- Intellect
	{pattern = string.lower(SPELL_STAT5_NAME), id = SPELL_STAT5_NAME}, -- Spirit

	{pattern = string.lower(ITEM_MOD_STRENGTH_SHORT), id = SPELL_STAT1_NAME}, -- Strength
	{pattern = string.lower(ITEM_MOD_AGILITY_SHORT), id = SPELL_STAT2_NAME}, -- Agility
	{pattern = string.lower(ITEM_MOD_STAMINA_SHORT), id = SPELL_STAT3_NAME}, -- Stamina
	{pattern = string.lower(ITEM_MOD_INTELLECT_SHORT), id = SPELL_STAT4_NAME}, -- Intellect
	{pattern = string.lower(ITEM_MOD_SPIRIT_SHORT), id = SPELL_STAT5_NAME}, -- Spirit
--Dodge
	{pattern = string.lower(STAT_DODGE), id = CR_DODGE},
	{pattern = string.lower(ITEM_MOD_DODGE_RATING_SHORT), id = CR_DODGE},
	{pattern = string.lower(gsub(ITEM_MOD_DODGE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_DODGE}, 
--Parry
	{pattern = string.lower(STAT_PARRY), id = CR_PARRY},
	{pattern = string.lower(ITEM_MOD_PARRY_RATING_SHORT), id = CR_PARRY},
	{pattern = string.lower(gsub(ITEM_MOD_PARRY_RATING,"%s[%+%-]?%%.%.?","")), id = CR_PARRY},
--Block
	{pattern = string.lower(STAT_BLOCK), id = CR_BLOCK}, -- block enchant: "+10 Shield Block"
	{pattern = string.lower(ITEM_MOD_BLOCK_VALUE_SHORT), id = CR_BLOCK}, -- block enchant: "+10 Shield Block"
	{pattern = string.lower(gsub(ITEM_MOD_BLOCK_VALUE,"%s[%+%-]?%%.%.?","")), id = CR_BLOCK}, 
--Hit
	{pattern = string.lower(ITEM_MOD_HIT_RATING_SHORT), id = CR_HIT_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_MELEE}, 
	
	{pattern = string.lower(ITEM_MOD_HIT_MELEE_RATING_SHORT), id = CR_HIT_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_MELEE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_MELEE}, 
	
	{pattern = string.lower(ITEM_MOD_HIT_RANGED_RATING_SHORT), id = CR_HIT_RANGED},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_RANGED_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_RANGED}, 
	
	{pattern = string.lower(ITEM_MOD_HIT_SPELL_RATING_SHORT), id = CR_HIT_SPELL},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_SPELL_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_SPELL}, 
--Crit
	{pattern = string.lower(ITEM_MOD_CRIT_RATING_SHORT), id = CR_CRIT_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_CRIT_RATING,"%s[%+%-]?%%.%.?","")), id = CR_CRIT_MELEE},
	
	{pattern = string.lower(ITEM_MOD_CRIT_MELEE_RATING_SHORT), id = CR_CRIT_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_CRIT_MELEE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_CRIT_MELEE},
	
	{pattern = string.lower(ITEM_MOD_CRIT_RANGED_RATING_SHORT), id = CR_CRIT_RANGED},
	{pattern = string.lower(gsub(ITEM_MOD_CRIT_RANGED_RATING,"%s[%+%-]?%%.%.?","")), id = CR_CRIT_RANGED},
	
	{pattern = string.lower(ITEM_MOD_CRIT_SPELL_RATING_SHORT), id = CR_CRIT_SPELL},
	{pattern = string.lower(gsub(ITEM_MOD_CRIT_SPELL_RATING,"%s[%+%-]?%%.%.?","")), id = CR_CRIT_SPELL},
--Haste
	{pattern = string.lower(ITEM_MOD_HASTE_RATING_SHORT), id = CR_HASTE_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HASTE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HASTE_MELEE},

	{pattern = string.lower(ITEM_MOD_HASTE_MELEE_RATING_SHORT), id = CR_HASTE_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HASTE_MELEE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HASTE_MELEE},
	
	{pattern = string.lower(ITEM_MOD_HASTE_RANGED_RATING_SHORT), id = CR_HASTE_RANGED},
	{pattern = string.lower(gsub(ITEM_MOD_HASTE_RANGED_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HASTE_RANGED},
	
	{pattern = string.lower(ITEM_MOD_HASTE_SPELL_RATING_SHORT), id = CR_HASTE_SPELL},
	{pattern = string.lower(gsub(ITEM_MOD_HASTE_SPELL_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HASTE_SPELL}, 
--Expertise
	{pattern = string.lower(ITEM_MOD_EXPERTISE_RATING_SHORT), id = CR_EXPERTISE},
	{pattern = string.lower(gsub(ITEM_MOD_EXPERTISE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_EXPERTISE},
--Mastery
	{pattern = string.lower(ITEM_MOD_MASTERY_RATING_SHORT), id = CR_MASTERY},
	{pattern = string.lower(gsub(ITEM_MOD_MASTERY_RATING,"%s[%+%-]?%%.%.?","")), id = CR_MASTERY},
--Spell Power
	{pattern = string.lower(ITEM_MOD_SPELL_POWER_SHORT), id = SPELL_POWER},
	{pattern = string.lower(gsub(ITEM_MOD_SPELL_POWER,"%s[%+%-]?%%.%.?","")), id = SPELL_POWER}, 

	{pattern = string.lower(ITEM_MOD_SPELL_DAMAGE_DONE_SHORT), id = SPELL_DMG},
	{pattern = string.lower(gsub(ITEM_MOD_SPELL_DAMAGE_DONE,"%s[%+%-]?%%.%.?","")), id = SPELL_DMG}, 
--PVP Power
	{pattern = string.lower(ITEM_MOD_PVP_POWER_SHORT), id = CR_PVP_POWER}, 
	{pattern = string.lower(gsub(ITEM_MOD_PVP_POWER,"%s[%+%-]?%%.%.?","")), id = CR_PVP_POWER},
--PVP Resil
	{pattern = string.lower(ITEM_MOD_RESILIENCE_RATING_SHORT), id = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN},
	{pattern = string.lower(gsub(ITEM_MOD_RESILIENCE_RATING,"%s[%+%-]?%%.%.?","")), id = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN},
--Hit Taken
	{pattern = string.lower(ITEM_MOD_HIT_TAKEN_RATING_SHORT), id = CR_HIT_TAKEN_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_TAKEN_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_TAKEN_MELEE},
	
	{pattern = string.lower(ITEM_MOD_HIT_TAKEN_MELEE_RATING_SHORT), id = CR_HIT_TAKEN_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_TAKEN_MELEE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_TAKEN_MELEE},
	
	{pattern = string.lower(ITEM_MOD_HIT_TAKEN_RANGED_RATING_SHORT), id = CR_HIT_TAKEN_RANGED},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_TAKEN_RANGED_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_TAKEN_RANGED},
	
	{pattern = string.lower(ITEM_MOD_HIT_TAKEN_SPELL_RATING_SHORT), id = CR_HIT_TAKEN_SPELL},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_TAKEN_SPELL_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_TAKEN_SPELL},
--Misc
	{pattern = string.lower(STAT_CATEGORY_DEFENSE), id = CR_DEFENSE_SKILL},
	{pattern = string.lower(SKILL), id = CR_WEAPON_SKILL},
	{pattern = string.lower(ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT), id = CR_ARMOR_PENETRATION},
}

-------------------------
-- Added info patterns --
-------------------------
-- $value will be replaced with the number
-- EX: "$value% Crit" -> "+1.34% Crit"
-- EX: "Crit $value%" -> "Crit +1.34%"
--L["$value% Crit"] = true
L["$value% Spell Crit"] = "$value% Crit.sort"
L["$value% Dodge"] = "$value% Esq."
L["$value HP"] = "$value PV"
L["$value MP"] = "$value PM"
L["$value AP"] = "$value PA"
L["$value SP"] = "$value Puis.sort"
L["$value RAP"] = "$value PA dist"
L["$value Pwr"] = "$value Dégats"
L["$value Heal"] = "$value Soins"
L["$value Armor"] = "$value Af"
L["$value Block"] = "$value Bloc"
L["$value MP5"] = "$value Mp5"
L["$value MP5(OC)"] = "$value Mp5(oC)"
L["$value HP5"] = "$value Hp5"
L["$value to be Dodged/Parried"] = "$value Esq/Par"
L["$value to be Crit"] = "$value Crit"
L["$value Crit Dmg Taken"] = "$value <-Crit"
L["$value DOT Dmg Taken"] = "$value <-DOT "
L["$value Parry"] = "$value Par."
-- for hit rating showing both physical and spell conversions
-- (+1.21%, S+0.98%)
-- (+1.21%, +0.98% S)
L["$value Spell"] = "$value(Sort) "
L["$value Spell Hit"] = "$value(Sort)"

------------------
-- Stat Summary --
------------------
L["Stat Summary"] = "Compte-rendu"