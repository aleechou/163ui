--[[
Name: RatingBuster deDE locale
Revision: $Revision: 339 $
Translated by:
- Kuja
]]

local L = LibStub("AceLocale-3.0"):NewLocale("RatingBuster", "deDE")
if not L then return end
-- This file is coded in UTF-8
-- If you don't have a editor that can save in UTF-8, I recommend Ultraedit
----
-- To translate AceLocale strings, replace true with the translation string
-- Before: L["Show Item ID"] = true,
-- After:  L["Show Item ID"] = "顯示物品編號",
---------------
-- Waterfall --
---------------
L["RatingBuster Options"] = "RatingBuster Optionen"
L["Enabled"] = "Aktiviert"
L["Suspend/resume this addon"] = "Stoppt/Aktiviert dieses Addon"
---------------------------
-- Slash Command Options --
---------------------------
L["Always"] = "Immer"
L["ALT Key"] = "Alt Taste"
L["CTRL Key"] = "Strg Taste"
L["SHIFT Key"] = "Shift Taste"
L["Never"] = "Nie"
L["General Settings"] = "Allgemeine Einstellungen"
L["Profiles"] = "Profile"
-- /rb win
L["Options Window"] = "Optionsfenster"
L["Shows the Options Window"] = "Zeigt das Optionsfenster"
-- /rb hidebzcomp
L["Hide Blizzard Item Comparisons"] = "Verstecke Blizzard Gegenstandsvergleich"
L["Disable Blizzard stat change summary when using the built-in comparison tooltip"] = "Deaktiviert den Gegenstandsvergleich von Blizzard, wenn der eingebaute Vergleichstooltip verwendet wird"
-- /rb statmod
L["Enable Stat Mods"] = "Aktiviere Stat Mods"
L["Enable support for Stat Mods"] = "Aktiviert die Unterstützung von Stat Mods"
-- /rb subtract_equip
L["Enable Subtract Equipped Stats"] = "Aktiviere Subtraktion von angelegten Stats"
L["Enable for more accurate calculation of Mana Regen from Intellect and Spirit, and diminishing stats like Dodge, Parry, Resilience"] = "Aktivieren, um eine genauere Berechnung der Manaregeneration und von Werten mit abnehmender Wirkung wie Ausweichen, Parieren und Abhärtung zu erhalten"
-- /rb enable_reforge_ui
L["Enable integration with Blizzard Reforging UI"] = "Aktiviere Integration mit dem Blizzard Umschmiedungs-UI"
L["Add rating information to the Blizzard Reforging UI"] = "Zeigt Wertungsinformationen im Blizzard Umschmiedungs-UI"
-- /rb usereqlv
L["Use Required Level"] = "Nutze benötigten Level"
L["Calculate using the required level if you are below the required level"] = "Berechne auf Basis des benötigten Levels, falls du unter diesem bist"
-- /rb level
L["Set Level"] = "Setze Level"
L["Set the level used in calculations (0 = your level)"] = "Legt den Level der zur Berechnung benutzt wird fest (0 = dein Level)"
-- /rb ilvlid
L["Item Level and ID"] = "Gegenstandsstufe und ID"
L["Settings for Item Level and Item ID"] = "Einstellungen für die Gegenstandsstufe und ID"
-- /rb ilvlid coloritemlevel
L["Colorize Item Level"] = "Gegenstandsstufe einfärben"
L["Customize the color of the Item Level text"] = "Ändere die Farbe des Gegenstandsstufe-Textes"
-- /rb ilvlid itemlevelall
L["Show Item Level on all items"] = "Zeige Gegenstandsstufe auf allen Gegenständen"
L["Display the Item Level on all items instead of just on equippable items"] = "Zeigt die Gegenstandsstufe auf allen Gegenständen, anstatt nur auf ausrüstbaren Gegenständen"
-- /rb ilvlid itemid
L["Show Item ID"] = "Zeige Item ID"
L["Display the Item ID on all items"] = "Zeige die Item ID auf allen Gegenständen"
---------------------------------------------------------------------------
-- /rb rating
L["Rating"] = "Wertung"
L["Options for Rating display"] = "Optionen für die Wertungsanzeige"
-- /rb rating show
L["Show Rating Conversions"] = "Zeige Wertungsumrechnung"
L["Select when to show rating conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Wähle, wann die Wertungsumrechnung in Tooltips angezeigt wird. Die Tasten müssen gedrückt werden, bevor die Tooltips sichtbar werden."
-- /rb rating spell
L["Show Spell Hit/Haste"] = "Zeige Zaubertempo/-trefferchance"
L["Show Spell Hit/Haste from Hit/Haste Rating"] = "Zeige Zaubertempo/-trefferchance von Tempo-/Trefferwertung"
-- /rb rating physical
L["Show Physical Hit/Haste"] = "Zeige physisches Tempo/Trefferchance"
L["Show Physical Hit/Haste from Hit/Haste Rating"] = "Zeige physisches Tempo/Trefferchance von Tempo-/Trefferwertung"
-- /rb rating detail
L["Show Detailed Conversions Text"] = "Zeige detaillierten Umrechnungtext"
L["Show detailed text for Resilience and Expertise conversions"] = "Zeige detaillierten Text für Abhärtungs- und Waffenkundeumrechnung"
-- /rb rating exp
L["Expertise Breakdown"] = "Waffenkundeanalyse"
L["Convert Expertise into Dodge Neglect and Parry Neglect"] = "Wandle Waffenkunde in Ausweich- und Pariermissachtung um"
---------------------------------------------------------------------------
-- /rb rating color
L["Change Text Color"] = "Ändere Textfarbe"
L["Changes the color of added text"] = "Ändert die Textfarbe des hinzugefügten Textes"
-- /rb rating color pick
L["Pick Color"] = "Wähle Farbe"
L["Pick a color"] = "Wähle eine Farbe"
-- /rb rating color enable
L["Enable Color"] = "Farbe aktivieren"
L["Enable colored text"] = "Aktiviert gefärbten Text"
---------------------------------------------------------------------------
-- /rb stat
L["Stat Breakdown"] = "Werteumrechnung"
L["Changes the display of base stats"] = "Ändert die Anzeige der Basiswerte"
-- /rb stat show
L["Show Base Stat Conversions"] = "Zeige Basiswertumrechnung"
L["Select when to show base stat conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Wähle, wann die Basiswertumrechnung in Tooltips angezeigt wird. Die Tasten müssen gedrückt werden, bevor die Tooltips sichtbar werden."
---------------------------------------------------------------------------
-- /rb stat str
L["Strength"] = "Stärke"
L["Changes the display of Strength"] = "Ändert die Anzeige von Stärke"
-- /rb stat str ap
L["Show Attack Power"] = "Zeige Angriffskraft"
L["Show Attack Power from Strength"] = "Zeige Angriffskraft, resultierend aus Stärke"
-- /rb stat str block
L["Show Block Value"] = "Zeige Blockwert"
L["Show Block Value from Strength"] = "Zeige Blockwert, resultierend aus Stärke"
-- /rb stat str dmg
L["Show Spell Damage"] = "Zeige Zauberschaden"
L["Show Spell Damage from Strength"] = "Zeige Zauberschaden, resultierend aus Stärke"
-- /rb stat str heal
L["Show Healing"] = "Zeige Heilung"
L["Show Healing from Strength"] = "Zeige Heilung, resultierend aus Stärke"
-- /rb stat str parryrating
L["Show Parry Rating"] = "Zeige Parierwertung"
L["Show Parry Rating from Strength"] = "Zeige Parierwertung, resultierend aus Stärke"
-- /rb stat str parry
L["Show Parry"] = "Zeige Parieren"
L["Show Parry from Strength"] = "Zeige Parieren, resultierend aus Stärke"
---------------------------------------------------------------------------
-- /rb stat agi
L["Agility"] = "Beweglichkeit"
L["Changes the display of Agility"] = "Ändert die Anzeige von Beweglichkeit"
-- /rb stat agi crit
L["Show Crit"] = "Zeige kritische Trefferchance"
L["Show Crit chance from Agility"] = "Zeige Chance auf kritische Treffer, resultierend aus Beweglichkeit"
-- /rb stat agi dodge
L["Show Dodge"] = "Zeige Ausweichen"
L["Show Dodge chance from Agility"] = "Zeige Ausweichchance, resultierend aus Beweglichkeit"
-- /rb stat agi ap
L["Show Attack Power"] = "Zeige Angriffskraft"
L["Show Attack Power from Agility"] = "Zeige Angriffskraft, resultierend aus Beweglichkeit"
-- /rb stat agi rap
L["Show Ranged Attack Power"] = "Zeige Distanzangriffskraft"
L["Show Ranged Attack Power from Agility"] = "Zeige Distanzangriffskraft, resultierend aus Beweglichkeit"
-- /rb stat agi dmg
L["Show Spell Damage"] = "Zeige Zauberschaden"
L["Show Spell Damage from Agility"] = "Zeige Zauberschaden, resultierend aus Beweglichkeit"
-- /rb stat agi heal
L["Show Healing"] = "Zeige Heilung"
L["Show Healing from Agility"] = "Zeige Heilung, resultierend aus Beweglichkeit"
---------------------------------------------------------------------------
-- /rb stat sta
L["Stamina"] = "Ausdauer"
L["Changes the display of Stamina"] = "Ändert die Anzeige von Ausdauer"
-- /rb stat sta hp
L["Show Health"] = "Zeige Leben"
L["Show Health from Stamina"] = "Zeige Leben, resultierend aus Ausdauer"
-- /rb stat sta dmg
L["Show Spell Damage"] = "Zeige Zauberschaden"
L["Show Spell Damage from Stamina"] = "Zeige Zauberschaden, resultierend aus Ausdauer"
-- /rb stat sta heal
L["Show Healing"] = "Zeige Heilung"
L["Show Healing from Stamina"] = "Zeige Heilung, resultierend aus Ausdauer"
-- /rb stat sta ap
L["Show Attack Power"] = "Zeige Angriffskraft"
L["Show Attack Power from Stamina"] = "Zeige Angriffskraft, resultierend aus Ausdauer"
---------------------------------------------------------------------------
-- /rb stat int
L["Intellect"] = "Intelligenz"
L["Changes the display of Intellect"] = "Ändert die Anzeige von Intelligenz"
-- /rb stat int spellcrit
L["Show Spell Crit"] = "Zeige kritische Zaubertrefferchance"
L["Show Spell Crit chance from Intellect"] = "Zeige Chance auf kritische Zaubertreffer, resultierend aus Intelligenz"
-- /rb stat int mp
L["Show Mana"] = "Zeige Mana"
L["Show Mana from Intellect"] = "Zeige Mana, resultierend aus Intelligenz"
-- /rb stat int dmg
L["Show Spell Damage"] = "Zeige Zauberschaden"
L["Show Spell Damage from Intellect"] = "Zeige Zauberschaden, resultierend aus Intelligenz"
-- /rb stat int heal
L["Show Healing"] = "Zeige Heilung"
L["Show Healing from Intellect"] = "Zeige Heilung, resultierend aus Intelligenz"
-- /rb stat int mp5
L["Show Combat Mana Regen"] = "Zeige Manaregeneration im Kampf"
L["Show Mana Regen while in combat from Intellect"] = "Zeige Manaregeneration im Kampf, resultierend aus Intelligenz"
-- /rb stat int mp5oc
L["Show Normal Mana Regen"] = "Zeige Manaregeneration"
L["Show Mana Regen while not in combat from Intellect"] = "Zeige Manaregeneration außerhalb eines Kampfes, resultierend aus Intelligenz"
-- /rb stat int rap
L["Show Ranged Attack Power"] = "Zeige Distanzangriffskraft"
L["Show Ranged Attack Power from Intellect"] = "Zeige Distanzangriffskraft, resultierend aus Intelligenz"
-- /rb stat int ap
L["Show Attack Power"] = "Zeige Angriffskraft"
L["Show Attack Power from Intellect"] = "Zeige Angriffskraft, resultierend aus Intelligenz"
---------------------------------------------------------------------------
-- /rb stat spi
L["Spirit"] = "Willenskraft"
L["Changes the display of Spirit"] = "Ändert die Anzeige von Willenskraft"
-- /rb stat spi mp5
L["Show Combat Mana Regen"] = "Zeige Manaregeneration im Kampf"
L["Show Mana Regen while in combat from Spirit"] = "Zeige Manaregeneration im Kampf, resultierend aus Willenskraft"
-- /rb stat spi mp5oc
L["Show Normal Mana Regen"] = "Zeige Manaregeneration"
L["Show Mana Regen while not in combat from Spirit"] = "Zeige Manaregeneration außerhalb eines Kampfes, resultierend aus Willenskraft"
-- /rb stat spi hp5
L["Show Normal Health Regen"] = "Zeige Lebensregeneration"
L["Show Health Regen while not in combat from Spirit"] = "Zeige Lebensregeneration außerhalb eines Kampfes, resultierend aus Willenskraft"
-- /rb stat spi dmg
L["Show Spell Damage"] = "Zeige Zauberschaden"
L["Show Spell Damage from Spirit"] = "Zeige Zauberschaden, resultierend aus Willenskraft"
-- /rb stat spi heal
L["Show Healing"] = "Zeige Heilung"
L["Show Healing from Spirit"] = "Zeige Heilung, resultierend aus Willenskraft"
-- /rb stat spi spellcrit
L["Show Spell Crit"] = "Zeige kritische Zaubertrefferchance"
L["Show Spell Crit chance from Spirit"] = "Zeige Chance auf kritische Zaubertreffer, resultierend aus Willenskraft"
-- /rb stat spi spellhitrating
L["Show Spell Hit Rating"] = "Zeige Zaubertrefferwertung"
L["Show Spell Hit Rating from Spirit"] = "Zeige Zaubertrefferwertung, resultierend aus Willenskraft"
-- /rb stat spi spellhit
L["Show Spell Hit"] = "Zeige Zaubertrefferchance"
L["Show Spell Hit from Spirit"] = "Zeige Zaubertrefferchance, resultierend aus Willenskraft"
---------------------------------------------------------------------------
-- /rb stat armor
L["Armor"] = "Rüstung"
L["Changes the display of Armor"] = "Ändert die Anzeige von Rüstung"
-- /rb stat armor ap
L["Show Attack Power"] = "Zeige Angriffskraft"
L["Show Attack Power from Armor"] = "Zeige Angriffskraft, resultierend aus Rüstung"
---------------------------------------------------------------------------
-- /rb sum
L["Stat Summary"] = "Werteübersicht"
L["Options for stat summary"] = "Optionen für die Werteübersicht"
-- /rb sum show
L["Show Stat Summary"] = "Zeige Werteübersicht"
L["Select when to show stat summary in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Wähle, wann die Werteübersicht in Tooltips angezeigt wird. Die Tasten müssen gedrückt werden, bevor die Tooltips sichtbar werden."
-- /rb sum ignore
L["Ignore Settings"] = "Ignoriereinstellungen"
L["Ignore stuff when calculating the stat summary"] = "Ignoriere Werte bei der Berechnung der Werteübersicht"
-- /rb sum ignore unused
L["Ignore Undesirable Items"] = "Ignoriere ungewünschte Gegenstände"
L["Hide stat summary for undesirable items"] = "Verstecke die Werteübersicht für ungewünschte Gegenstände"
-- /rb sum ignore quality
L["Minimum Item Quality"] = "Minimale Gegenstandsqualität"
L["Show stat summary only for selected quality items and up"] = "Zeige Werteübersicht nur für die ausgewählte Qualität und höher"
-- /rb sum ignore armor
L["Armor Types"] = "Rüstungsklasse"
L["Select armor types you want to ignore"] = "Wähle Rüstungsklassen, die ignoriert werden sollen"
-- /rb sum ignore armor cloth
L["Ignore Cloth"] = "Ignoriere Stoff"
L["Hide stat summary for all cloth armor"] = "Verstecke die Werteübersicht für alle Rüstungen aus Stoff"
-- /rb sum ignore armor leather
L["Ignore Leather"] = "Ignoriere Leder"
L["Hide stat summary for all leather armor"] = "Verstecke die Werteübersicht für alle Rüstungen aus Leder"
-- /rb sum ignore armor mail
L["Ignore Mail"] = "Ignoriere Kette"
L["Hide stat summary for all mail armor"] = "Verstecke die Werteübersicht für alle Rüstungen aus Kette"
-- /rb sum ignore armor plate
L["Ignore Plate"] = "Ignoriere Platte"
L["Hide stat summary for all plate armor"] = "Verstecke die Werteübersicht für alle Rüstungen aus Platte"
-- /rb sum ignore equipped
L["Ignore Equipped Items"] = "Ignoriere angelegte Gegenstände"
L["Hide stat summary for equipped items"] = "Verstecke Werteübersicht für angelegte Gegenstände"
-- /rb sum ignore enchant
L["Ignore Enchants"] = "Ignoriere Verzauberungen"
L["Ignore enchants on items when calculating the stat summary"] = "Ignoriere Verzauberungen auf Gegenständen für die Berechnung der Werteübersicht"
-- /rb sum ignore gem
L["Ignore Gems"] = "Ignoriere Edelsteine"
L["Ignore gems on items when calculating the stat summary"] = "Ignoriere Edelsteine auf gesockelten Gegenständen für die Berechnung der Werteübersicht"
-- /rb sum ignore prismaticSocket
L["Ignore Prismatic Sockets"] = "Ignoriere prismatische Sockel"
L["Ignore gems in prismatic sockets when calculating the stat summary"] = "Ignoriere Edelsteine in prismatischen Sockeln für die Berechnung der Werteübersicht"
-- /rb sum diffstyle
L["Display Style For Diff Value"] = "Anzeigestil für veränderte Werte"
L["Display diff values in the main tooltip or only in compare tooltips"] = "Zeige veränderte Werte im Haupttooltip oder nur in Vergleichstooltips"
-- /rb sum space
L["Add Empty Line"] = "Füge leere Zeile hinzu"
L["Add a empty line before or after stat summary"] = "Füge eine leere Zeile vor oder nach der Werteübersicht hinzu"
-- /rb sum space before
L["Add Before Summary"] = "Vor Berechnung hinzufügen"
L["Add a empty line before stat summary"] = "Füge eine leere Zeile vor der Werteübersicht hinzu"
-- /rb sum space after
L["Add After Summary"] = "Nach Berechnung hinzufügen"
L["Add a empty line after stat summary"] = "Füge eine leere Zeile nach der Werteübersicht hinzu"
-- /rb sum icon
L["Show Icon"] = "Zeige Symbol"
L["Show the sigma icon before summary listing"] = "Zeige das Sigma Symbol vor der Übersichtsliste an"
-- /rb sum title
L["Show Title Text"] = "Zeige Titeltext"
L["Show the title text before summary listing"] = "Zeige den Titeltext vor der Übersichtsliste an"
-- /rb sum showzerostat
L["Show Zero Value Stats"] = "Zeige Nullwerte"
L["Show zero value stats in summary for consistancy"] = "Zeige zur Konsistenz die Nullwerte in der Übersicht an"
-- /rb sum calcsum
L["Calculate Stat Sum"] = "Berechne Wertesummen"
L["Calculate the total stats for the item"] = "Berechne die Gesamtwerte der Items"
-- /rb sum calcdiff
L["Calculate Stat Diff"] = "Berechne Wertedifferenz"
L["Calculate the stat difference for the item and equipped items"] = "Berechne Wertedifferenz für das Item und angelegte Items"
-- /rb sum sort
L["Sort StatSummary Alphabetically"] = "Sortiere Werteübersicht alphabetisch"
L["Enable to sort StatSummary alphabetically, disable to sort according to stat type(basic, physical, spell, tank)"] = "Sortiere Werteübersicht alphabetisch, deaktivieren um nach Wertetyp zu sortieren (Basis, Physisch, Zauber, Tank)"
-- /rb sum avoidhasblock
L["Include Block Chance In Avoidance Summary"] = "Zeige Blockchance in Vermeidungsübersicht"
L["Enable to include block chance in Avoidance summary, Disable for only dodge, parry, miss"] = "Zeige Blockchance in Vermeidungsübersicht, deaktivieren um nur Ausweichen, Parieren und Verfehlen zu zeigen"
---------------------------------------------------------------------------
-- /rb sum basic
L["Stat - Basic"] = "Werte - Basis"
L["Choose basic stats for summary"] = "Wähle Basiswerte für die Übersicht"
-- /rb sum basic hp
L["Sum Health"] = "Leben zusammenrechnen"
L["Health <- Health, Stamina"] = "Leben <- Leben, Ausdauer"
-- /rb sum basic mp
L["Sum Mana"] = "Mana zusammenrechnen"
L["Mana <- Mana, Intellect"] = "Mana <- Mana, Intelligenz"
-- /rb sum basic mp5
L["Sum Combat Mana Regen"] = "Manaregeneration im Kampf zusammenrechnen"
L["Combat Mana Regen <- Mana Regen, Spirit"] = "Manaregeneration im Kampf <- Manaregeneration, Willenskraft"
-- /rb sum basic mp5oc
L["Sum Normal Mana Regen"] = "Manaregeneration außerhalb eines Kampfes zusammenrechnen"
L["Normal Mana Regen <- Spirit"] = "Manaregeneration außerhalb eines Kampfes <- Willenskraft"
-- /rb sum basic hp5
L["Sum Combat Health Regen"] = "Lebensregeneration im Kampf zusammenrechnen"
L["Combat Health Regen <- Health Regen"] = "Lebensregeneration im Kampf <- Lebensregeneration"
-- /rb sum basic hp5oc
L["Sum Normal Health Regen"] = "Lebensregeneration außerhalb eines Kampfes zusammenrechnen"
L["Normal Health Regen <- Spirit"] = "Lebensregeneration außerhalb eines Kampfes <- Willenskraft"
-- /rb sum basic str
L["Sum Strength"] = "Stärke zusammenrechnen"
L["Strength Summary"] = "Stärkeübersicht"
-- /rb sum basic agi
L["Sum Agility"] = "Beweglichkeit zusammenrechnen"
L["Agility Summary"] = "Beweglichkeitsübersicht"
-- /rb sum basic sta
L["Sum Stamina"] = "Ausdauer zusammenrechnen"
L["Stamina Summary"] = "Ausdauerübersicht"
-- /rb sum basic int
L["Sum Intellect"] = "Intelligenz zusammenrechnen"
L["Intellect Summary"] = "Intelligenzübersicht"
-- /rb sum basic spi
L["Sum Spirit"] = "Willenskraft zusammenrechnen"
L["Spirit Summary"] = "Willenkraftübersicht"
-- /rb sum basic mastery
L["Sum Mastery"] = "Meisterschaft zusammenrechnen"
L["Mastery Summary"] = "Meisterschaftsübersicht"
-- /rb sum basic masteryrating
L["Sum Mastery Rating"] = "Meisterschaftswertung zusammenrechnen"
L["Mastery Rating Summary"] = "Meisterschaftswertungsübersicht"
---------------------------------------------------------------------------
-- /rb sum physical
L["Stat - Physical"] = "Werte - Physisch"
L["Choose physical damage stats for summary"] = "Wähle physische Schadenswerte für die Übersicht"
-- /rb sum physical ap
L["Sum Attack Power"] = "Angriffskraft zusammenrechnen"
L["Attack Power <- Attack Power, Strength, Agility"] = "Angriffskraft <- Angriffskraft, Stärke, Beweglichkeit"
-- /rb sum physical rap
L["Sum Ranged Attack Power"] = "Distanzangriffskraft zusammenrechnen"
L["Ranged Attack Power <- Ranged Attack Power, Intellect, Attack Power, Strength, Agility"] = "Distanzangriffskraft <- Distanzangriffskraft, Intelligenz, Angriffskraft, Stärke, Beweglichkeit"
-- /rb sum physical hit
L["Sum Hit Chance"] = "Trefferchance zusammenrechnen"
L["Hit Chance <- Hit Rating"] = "Trefferchance <- Trefferwertung"
-- /rb sum physical hitrating
L["Sum Hit Rating"] = "Trefferwertung zusammenrechnen"
L["Hit Rating Summary"] = "Trefferwertungsübersicht"
-- /rb sum physical crit
L["Sum Crit Chance"] = "Kritische Trefferchance zusammenrechnen"
L["Crit Chance <- Crit Rating, Agility"] = "Kritische Trefferchance <- kritische Trefferwertung, Beweglichkeit"
-- /rb sum physical critrating
L["Sum Crit Rating"] = "Kritische Trefferwertung zusammenrechnen"
L["Crit Rating Summary"] = "Kritische Trefferwertungsübersicht"
-- /rb sum physical haste
L["Sum Haste"] = "Tempo zusammenrechnen"
L["Haste <- Haste Rating"] = "Tempo <- Tempowertung"
-- /rb sum physical hasterating
L["Sum Haste Rating"] = "Tempowertung zusammenrechnen"
L["Haste Rating Summary"] = "Tempowertungsübersicht"
-- /rb sum physical rangedhit
L["Sum Ranged Hit Chance"] = "Distanztrefferchance zusammenrechnen"
L["Ranged Hit Chance <- Hit Rating, Ranged Hit Rating"] = "Distanztrefferchance <- Trefferwertung, Distanztrefferwertung"
-- /rb sum physical rangedhitrating
L["Sum Ranged Hit Rating"] = "Distanztrefferwertung zusammenrechnen"
L["Ranged Hit Rating Summary"] = "Distanztrefferwertungsübersicht"
-- /rb sum physical rangedcrit
L["Sum Ranged Crit Chance"] = "Kritische Distanztrefferchance zusammenrechnen"
L["Ranged Crit Chance <- Crit Rating, Agility, Ranged Crit Rating"] = "Kritische Distanztrefferchance <- kritische Trefferwertung, Beweglichkeit, kritische Distanztrefferwertung"
-- /rb sum physical rangedcritrating
L["Sum Ranged Crit Rating"] = "Kritische Distanztrefferwertung zusammenrechnen"
L["Ranged Crit Rating Summary"] = "Kritische Distanztrefferwertungsübersicht"
-- /rb sum physical rangedhaste
L["Sum Ranged Haste"] = "Distanztempo zusammenrechnen"
L["Ranged Haste <- Haste Rating, Ranged Haste Rating"] = "Distanztempo <- Tempowertung, Distanztempowertung"
-- /rb sum physical rangedhasterating
L["Sum Ranged Haste Rating"] = "Distanztempowertung zusammenrechnen"
L["Ranged Haste Rating Summary"] = "Distanztempowertungsübersicht"
-- /rb sum physical maxdamage
L["Sum Weapon Max Damage"] = "Waffenmaximalschaden zusammenrechnen"
L["Weapon Max Damage Summary"] = "Waffenmaximalschadensübersicht"
-- /rb sum physical weapondps
--L["Sum Weapon DPS"] = true
--L["Weapon DPS Summary"] = true
-- /rb sum physical wpn
L["Sum Weapon Skill"] = "Waffenfertigkeit zusammenrechnen"
L["Weapon Skill <- Weapon Skill Rating"] = "Waffenfertigkeit <- Waffenfertigkeitswertung"
-- /rb sum physical exp
L["Sum Expertise"] = "Waffenkunde zusammenrechnen"
L["Expertise <- Expertise Rating"] = "Waffenkunde <- Waffenkundewertung"
-- /rb sum physical exprating
L["Sum Expertise Rating"] = "Waffenkundewertung zusammenrechnen"
L["Expertise Rating Summary"] = "Waffenkundewertungsübersicht"
---------------------------------------------------------------------------
-- /rb sum spell
L["Stat - Spell"] = "Werte - Zauber"
L["Choose spell damage and healing stats for summary"] = "Wähle Zauberschaden und Heilungswerte für die Übersicht"
-- /rb sum spell power
L["Sum Spell Power"] = "Zaubermacht zusammenrechnen"
L["Spell Power <- Spell Power, Intellect, Agility, Strength"] = "Zaubermacht <- Zaubermacht, Intelligenz, Beweglichkeit, Stärke"
-- /rb sum spell dmg
L["Sum Spell Damage"] = "Zauberschaden zusammenrechnen"
L["Spell Damage <- Spell Damage, Intellect, Spirit, Stamina"] = "Zauberschaden <- Zauberschaden, Intelligenz, Willenskraft, Ausdauer"
-- /rb sum spell dmgholy
L["Sum Holy Spell Damage"] = "Heiligzauberschaden zusammenrechnen"
L["Holy Spell Damage <- Holy Spell Damage, Spell Damage, Intellect, Spirit"] = "Heiligzauberschaden <- Heiligzauberschaden, Zauberschaden, Intelligenz, Willenskraft"
-- /rb sum spell dmgarcane
L["Sum Arcane Spell Damage"] = "Arkanzauberschaden zusammenrechnen"
L["Arcane Spell Damage <- Arcane Spell Damage, Spell Damage, Intellect"] = "Arkanzauberschaden <- Arkanzauberschaden, Zauberschaden, Intelligenz"
-- /rb sum spell dmgfire
L["Sum Fire Spell Damage"] = "Feuerzauberschaden zusammenrechnen"
L["Fire Spell Damage <- Fire Spell Damage, Spell Damage, Intellect, Stamina"] = "Feuerzauberschaden <- Feuerzauberschaden, Zauberschaden, Intelligenz, Ausdauer"
-- /rb sum spell dmgnature
L["Sum Nature Spell Damage"] = "Naturzauberschaden zusammenrechnen"
L["Nature Spell Damage <- Nature Spell Damage, Spell Damage, Intellect"] = "Naturzauberschaden <- Naturzauberschaden, Zauberschaden, Intelligenz"
-- /rb sum spell dmgfrost
L["Sum Frost Spell Damage"] = "Frostzauberschaden zusammenrechnen"
L["Frost Spell Damage <- Frost Spell Damage, Spell Damage, Intellect"] = "Frostzauberschaden <- Frostzauberschaden, Zauberschaden, Intelligenz"
-- /rb sum spell dmgshadow
L["Sum Shadow Spell Damage"] = "Schattenzauberschaden zusammenrechnen"
L["Shadow Spell Damage <- Shadow Spell Damage, Spell Damage, Intellect, Spirit, Stamina"] = "Schattenzauberschaden <- Schattenzauberschaden, Zauberschaden, Intelligenz, Willenskraft, Ausdauer"
-- /rb sum spell heal
L["Sum Healing"] = "Heilung zusammenrechnen"
L["Healing <- Healing, Intellect, Spirit, Agility, Strength"] = "Heilung <- Heilung, Intelligenz, Willenskraft, Beweglichkeit, Stärke"
-- /rb sum spell crit
L["Sum Spell Crit Chance"] = "Kritische Zaubertrefferchance zusammenrechnen"
L["Spell Crit Chance <- Spell Crit Rating, Intellect"] = "Kritische Zaubertrefferchance <- kritische Zaubertrefferwertung, Intelligenz"
-- /rb sum spell hit
L["Sum Spell Hit Chance"] = "Zaubertrefferchance zusammenrechnen"
L["Spell Hit Chance <- Spell Hit Rating"] = "Zaubertrefferchance <- Zaubertrefferwertung"
-- /rb sum spell haste
L["Sum Spell Haste"] = "Zaubertempo zusammenrechnen"
L["Spell Haste <- Spell Haste Rating"] = "Zaubertempo <- Zaubertempowertung"
-- /rb sum spell pen
L["Sum Penetration"] = "Zauberdurchschlag zusammenrechnen"
L["Spell Penetration Summary"] = "Zauberdurchschlagsübersicht"
-- /rb sum spell hitrating
L["Sum Spell Hit Rating"] = "Zaubertrefferwertung zusammenrechnen"
L["Spell Hit Rating Summary"] = "Zaubertrefferwertungsübersicht"
-- /rb sum spell critrating
L["Sum Spell Crit Rating"] = "Kritische Zaubertrefferwertung zusammenrechnen"
L["Spell Crit Rating Summary"] = "Kritische Zaubertrefferwertungsübersicht"
-- /rb sum spell hasterating
L["Sum Spell Haste Rating"] = "Zaubertempowertung zusammenrechnen"
L["Spell Haste Rating Summary"] = "Zaubertempowertungsübersicht"
---------------------------------------------------------------------------
-- /rb sum tank
L["Stat - Tank"] = "Werte - Verteidigung"
L["Choose tank stats for summary"] = "Wähle Verteidigungswerte für die Übersicht"
-- /rb sum tank armor
L["Sum Armor"] = "Rüstung zusammenrechnen"
L["Armor <- Armor from items and bonuses"] = "Rüstung <- Rüstung von Gegenständen und Boni"
-- /rb sum tank dodge
L["Sum Dodge Chance"] = "Ausweichchance zusammenrechnen"
L["Dodge Chance <- Dodge Rating, Agility"] = "Ausweichchance <- Ausweichwertung, Beweglichkeit"
-- /rb sum tank parry
L["Sum Parry Chance"] = "Parierchance zusammenrechnen"
L["Parry Chance <- Parry Rating"] = "Parierchance <- Parierwertung"
-- /rb sum tank block
L["Sum Block Chance"] = "Blockchance zusammenrechnen"
L["Block Chance <- Block Rating"] = " Blockchance <- Blockwertung"
-- /rb sum tank neglectdodge
L["Sum Dodge Neglect"] = "Ausweichmissachtung zusammenrechnen"
L["Dodge Neglect <- Expertise"] = "Ausweichmissachtung <- Waffenkunde"
-- /rb sum tank neglectparry
L["Sum Parry Neglect"] = "Pariermissachtung zusammenrechnen"
L["Parry Neglect <- Expertise"] = "Pariermissachtung <- Waffenkunde"
-- /rb sum tank resarcane
L["Sum Arcane Resistance"] = "Arkanwiderstand zusammenrechnen"
L["Arcane Resistance Summary"] = "Arkanwiderstandsübersicht"
-- /rb sum tank resfire
L["Sum Fire Resistance"] = "Feuerwiderstand zusammenrechnen"
L["Fire Resistance Summary"] = "Feuerwiderstandsübersicht"
-- /rb sum tank resnature
L["Sum Nature Resistance"] = "Naturwiderstand zusammenrechnen"
L["Nature Resistance Summary"] = "Naturwiderstandsübersicht"
-- /rb sum tank resfrost
L["Sum Frost Resistance"] = "Frostwiderstand zusammenrechnen"
L["Frost Resistance Summary"] = "Frostwiderstandsübersicht"
-- /rb sum tank resshadow
L["Sum Shadow Resistance"] = "Schattenwiderstand zusammenrechnen"
L["Shadow Resistance Summary"] = "Schattenwiderstandsübersicht"
-- /rb sum tank dodgerating
L["Sum Dodge Rating"] = "Ausweichwertung zusammenrechnen"
L["Dodge Rating Summary"] = "Ausweichwertungsübersicht"
-- /rb sum tank parryrating
L["Sum Parry Rating"] = "Parierwertung zusammenrechnen"
L["Parry Rating Summary"] = "Parierwertungsübersicht"
-- /rb sum tank blockrating
L["Sum Block Rating"] = "Blockwertung zusammenrechnen"
L["Block Rating Summary"] = "Blockwertungsübersicht"
-- /rb sum tank res
L["Sum Resilience"] = "Abhärtung zusammenrechnen"
L["Resilience Summary"] = "Abhärtungsübersicht"
-- /rb sum tank tp
L["Sum TankPoints"] = "TankPoints zusammenrechnen"
L["TankPoints <- Health, Total Reduction"] = "TankPoints <- Leben, Gesamtreduzierung"
-- /rb sum tank tr
L["Sum Total Reduction"] = "Gesamtreduzierung zusammenrechnen"
L["Total Reduction <- Armor, Dodge, Parry, Block, MobMiss, MobCrit, MobCrush, DamageTakenMods"] = "Gesamtreduzierung <- Rüstung, Ausweichen, Parieren, Blocken, Gegner-Verfehlen, Gegner-Kritisch, Gegner-Schmettern, Schadensmodifikatoren"
-- /rb sum tank avoid
L["Sum Avoidance"] = "Vermeidung zusammenrechnen"
L["Avoidance <- Dodge, Parry, MobMiss, Block(Optional)"] = "Vermeidung <- Ausweichen, Parieren, Gegner-Verfehlen, Blocken (optional)"
---------------------------------------------------------------------------
-- /rb sum gemset
L["Gem Set"] = "Edelsteinset"
L["Select a gem set to configure"] = "Wähle ein Edelsteinset zur Konfiguration"
L["Default Gem Set 1"] = "Standard Edelsteinset 1"
L["Default Gem Set 2"] = "Standard Edelsteinset 2"
L["Default Gem Set 3"] = "Standard Edelsteinset 3"
-- /rb sum gem
L["Auto fill empty gem slots"] = "Leere Edelsteinplätze automatisch füllen"
-- /rb sum gem red
L["Red Socket"] = EMPTY_SOCKET_RED
L["ItemID or Link of the gem you would like to auto fill"] = "ItemID oder Link des einzusetzenden Edelsteins"
L["<ItemID|Link>"] = true
L["|cffffff7f%s|r is now set to |cffffff7f[%s]|r"] = "|cffffff7f%s|r ist nun auf |cffffff7f[%s]|r gesetzt"
L["Invalid input: %s. ItemID or ItemLink required."] = "Ungültige Eingabe: %s. ItemID oder ItemLink benötigt."
L["Queried server for Gem: %s. Try again in 5 secs."] = "Frage den Server nach Edelstein: %s. Versuche es in 5 Sekunden noch einmal."
-- /rb sum gem yellow
L["Yellow Socket"] = EMPTY_SOCKET_YELLOW
-- /rb sum gem blue
L["Blue Socket"] = EMPTY_SOCKET_BLUE
-- /rb sum gem meta
L["Meta Socket"] = EMPTY_SOCKET_META
-- /rb sum gem2
L["Second set of default gems which can be toggled with a modifier key"] = "Zweites Set von Standardedelsteinen, das mit einer Umschalttaste angezeigt werden kann"
L["Can't use the same modifier as Gem Set 3"] = "Kann nicht die gleiche Umschalttaste wie das dritte Set benutzen"
-- /rb sum gem2 key
L["Toggle Key"] = "Umschalttaste"
L["Use this key to toggle alternate gems"] = "Benutze diese Taste um zu den alternativen Edelsteinen umzuschalten"
-- /rb sum gem3
L["Third set of default gems which can be toggled with a modifier key"] = "Drittes Set von Standardedelsteinen, das mit einer Umschalttaste angezeigt werden kann"
L["Can't use the same modifier as Gem Set 2"] = "Kann nicht die gleiche Umschalttaste wie das zweite Set benutzen"

-----------------------
-- Item Level and ID --
-----------------------
L["ItemLevel: "] = "Gegenstandsstufe: "
L["ItemID: "] = true
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
	{pattern = " (.+) um (%d+)", addInfo = "AfterNumber", space = " ", },
	{pattern = " ([%+%-]%d+)", addInfo = "AfterStat", space = " ", },
	{pattern = "verleiht.-(%d+)", addInfo = "AfterNumber", space = " ", }, -- for "grant you xx stat" type pattern, ex: Quel'Serrar, Assassination Armor set
	{pattern = "(%d+) erhöhen.", addInfo = "AfterNumber", space = " ", }, -- for "add xx stat" type pattern, ex: Adamantite Sharpening Stone
	-- Added [^%%] so that it doesn't match strings like "Increases healing by up to 10% of your total Intellect." [Whitemend Pants] ID: 24261
	-- Added [^|] so that it doesn't match enchant strings (JewelTips)
	{pattern = "([%+%-]%d+) (.+)", addInfo = "AfterStat", space = " ", }, -- [發光的暗影卓奈石] +6法術傷害及5耐力
}
L["separators"] = {
	"/", " und ", "%. ", " für ", "&", ":",
	-- Fix for [Mirror of Truth]
	-- Equip: Chance on melee and ranged critical strike to increase your attack power by 1000 for 10 secs.
	-- 1000 was falsely detected detected as ranged critical strike
	--"increase your",
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
SPELL_STAT1_NAME = "Stärke"
SPELL_STAT2_NAME = "Beweglichkeit"
SPELL_STAT3_NAME = "Ausdauer"
SPELL_STAT4_NAME = "Intelligenz"
SPELL_STAT5_NAME = "Willenskraft"
--]]

-------------------------
-- Added info patterns --
-------------------------
-- $value will be replaced with the number
-- EX: "$value% Crit" -> "+1.34% Crit"
-- EX: "Crit $value%" -> "Crit +1.34%"
L["$value% Crit"] = "$value% Krit."
L["$value% Spell Crit"] = "$value% Zauberkrit."
L["$value% Dodge"] = "$value% Ausweichen"
L["$value HP"] = true
L["$value MP"] = true
L["$value AP"] = true
L["$value SP"] = "$value ZM"
L["$value RAP"] = true
L["$value Pwr"] = "$value Schaden"
L["$value Heal"] = "$value Heilung"
L["$value Armor"] = "$value Rüstung"
L["$value Block"] = "$value Blocken"
L["$value MP5"] = true
L["$value MP5(OC)"] = true
L["$value HP5"] = true
L["$value to be Dodged/Parried"] = "$value wird Ausgewichen/Pariert"
L["$value to be Crit"] = "$value wird kritisch"
L["$value Crit Dmg Taken"] = "$value erlittener krit. Schaden"
L["$value DOT Dmg Taken"] = "$value erlittener Schaden durch DOTs"
L["$value PVP Dmg Taken"] = "$value erlittener Schaden im PVP"
L["$value Parry"] = "$value Parieren"
-- for hit rating showing both physical and spell conversions
-- (+1.21%, S+0.98%)
-- (+1.21%, +0.98% S)
L["$value Spell"] = "$value Zauber"
L["$value Spell Hit"] = "$value Zaubertrefferchance"

------------------
-- Stat Summary --
------------------
L["Stat Summary"] = "Werteübersicht"