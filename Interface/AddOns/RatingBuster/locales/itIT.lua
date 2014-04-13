--[[
Name: RatingBuster enUS locale
Revision: $Revision: 350 $
Translated by:
- Rikther (newiglif [at] gmail [dot] com)
]]

local L = LibStub("AceLocale-3.0"):NewLocale("RatingBuster", "itIT")
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
L["RatingBuster Options"] = "Opzioni RatingBuster"
L["Enabled"] = "Attiva"
L["Suspend/resume this addon"] = "Sospendi/Riattiva questo addon"
---------------------------
-- Slash Command Options --
---------------------------
L["Always"] = "Sempre"
L["ALT Key"] = "Tasto ALT"
L["CTRL Key"] = "Tasto CTRL"
L["SHIFT Key"] = "Tasto SHIFT"
L["Never"] = "Mai"
L["General Settings"] = "Settaggi generali"
L["Profiles"] = "Profili"
-- /rb win
L["Options Window"] = "Finestra Opzioni"
L["Shows the Options Window"] = "Mostra la finestra Opzioni"
-- /rb hidebzcomp
L["Hide Blizzard Item Comparisons"] = "Nascondi il confronto oggetti dell'interfaccia Blizzard"
L["Disable Blizzard stat change summary when using the built-in comparison tooltip"] = "Disabilita la sommatoria delle statistiche dell'interfaccia di base blizzard quando si sta usando la buit-in di RatingBuster per il confronto delle statistiche"
-- /rb statmod
L["Enable Stat Mods"] = "Abilita il riepilogo della variazione sulle statistiche"
L["Enable support for Stat Mods"] = "Abilita il supporto per il riepilogo della variazione sulle statistiche"
-- /rb subtract_equip
L["Enable Subtract Equipped Stats"] = "Abilita la sottrazione delle statistiche equipaggiate"
L["Enable for more accurate calculation of Mana Regen from Intellect and Spirit, and diminishing stats like Dodge, Parry, Resilience"] = "Abilita per un calcolo più accurato di rigenerazione mana da intelletto e spirito, diminuendo statistiche come Schivata, Parata, Resilienza" 
-- /rb enable_reforge_ui
L["Enable integration with Blizzard Reforging UI"] = "Abilità l'integrazione con l'interfaccia utente di Riforgiamento di Blizzard"
L["Add rating information to the Blizzard Reforging UI"] = "Aggiunge l'indice di informazioni sopra l'interfaccia utente di Riforgiamento di Blizzard"
-- /rb usereqlv
L["Use Required Level"] = "Utilizza il livello richiesto"
L["Calculate using the required level if you are below the required level"] = "Calcola usando il livello richiesto se ti trovi al di sotto di quest'ultimo"
-- /rb level
L["Set Level"] = "Imposta livello"
L["Set the level used in calculations (0 = your level)"] = "Imposta il livello utilizzato nel calcolo (0 = il tuo livello attuale)"
-- /rb ilvlid
L["Item Level and ID"] = "Livello e ID dell'oggetto"
L["Settings for Item Level and Item ID"] = "Impostazioni per il livello e l'ID dell'oggetto"
-- /rb ilvlid coloritemlevel
L["Colorize Item Level"] = "Colora il livello dell'oggetto"
L["Customize the color of the Item Level text"] = "Personalizza il colore del testo del livello oggetto"
-- /rb ilvlid itemlevelall
L["Show Item Level on all items"] = "Mostra il livello di tutti gli oggetti"
L["Display the Item Level on all items instead of just on equippable items"] = "Visualizza il livello di tutti gli oggetti esclusi quelli non equipagiabili"
-- /rb ilvlid itemid
L["Show Item ID"] = "Mostra l'ID"
L["Display the Item ID on all items"] = "Visualizza il numero ID su tutti gli oggetti"
---------------------------------------------------------------------------
-- /rb rating
L["Rating"] = "Indice Statistico"
L["Options for Rating display"] = "Opzioni per la visualizzazione dell'indice statistico"
-- /rb rating show
L["Show Rating Conversions"] = "Visualizza  la conversione dell'indice statistico"
L["Select when to show rating conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Imposta quando visualizzare la conversione dell'indice statistico nella finestra informazioni. Richiede la pressione del tasto assegnato per la visualizzazione"
-- /rb rating spell
L["Show Spell Hit/Haste"] = "Mostra percentuale d'impatto/celerità magica"
L["Show Spell Hit/Haste from Hit/Haste Rating"] = "Mostra percentuale d'impatto/celerità magica dall'indice statistico"
-- /rb rating physical
L["Show Physical Hit/Haste"] = "Mostra percentuale d'impatto/celerità degli attacchi in mischia"
L["Show Physical Hit/Haste from Hit/Haste Rating"] = "Mostra percentuale d'impatto/celerità degli attacchi in mischia dall'indice statistico"
-- /rb rating detail
L["Show Detailed Conversions Text"] = "Mostra in dettaglio il testo conversioni"
L["Show detailed text for Resilience and Expertise conversions"] = "Visualizza in modo dettagliato la conversione della Resilienza e della Perizia"
-- /rb rating exp
L["Expertise Breakdown"] = "Limite Perizia"
L["Convert Expertise into Dodge Neglect and Parry Neglect"] = "Converti la Perizia in schivata trascurabile e parata trascurabile"
---------------------------------------------------------------------------
-- /rb rating color
L["Change Text Color"] = "Cambia il colore del testo"
L["Changes the color of added text"] = "Cambia il colore del testo aggiunto"
-- /rb rating color pick
L["Pick Color"] = "Cattura Colore"
L["Pick a color"] = "Cattura un colore"
-- /rb rating color enable
L["Enable Color"] = "Abilita colore"
L["Enable colored text"] = "Abilita il testo colorato"
---------------------------------------------------------------------------
-- /rb stat
L["Stat Breakdown"] = "Limite statistico"
L["Changes the display of base stats"] = "Cambia la visualizzazione delle statistiche di base"
-- /rb stat show
L["Show Base Stat Conversions"] = "Visualizza la conversione delle statistiche di base"
L["Select when to show base stat conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Seleziona quando visualizzare la conversione delle statistiche di base nella finestra informazioni. Richiede la pressione del tasto assegnato per la visualizzazione" 
---------------------------------------------------------------------------
-- /rb stat str
L["Strength"] = "Forza"
L["Changes the display of Strength"] = "Cambia la Visualizzazione della forza"
-- /rb stat str ap
L["Show Attack Power"] = "Mostra potenza d'attacco"
L["Show Attack Power from Strength"] = "Mostra la potenza d'attacco ottenuta dalla forza"
-- /rb stat str block
L["Show Block Value"] = "Mostra probabilità di blocco"
L["Show Block Value from Strength"] = "Mostra la probabilità di blocco ottenuta dalla forza"
-- /rb stat str dmg
L["Show Spell Damage"] = "Mostra potenza magica"
L["Show Spell Damage from Strength"] = "Mostra la potenza magica ottenuta dalla forza"
-- /rb stat str heal
L["Show Healing"] = "Mostra Cure"
L["Show Healing from Strength"] = "Mostra le cure ottentute dalla forza"
-- /rb stat str parryrating
L["Show Parry Rating"] = "Mostra indice di parata"
L["Show Parry Rating from Strength"] = "Mostra l'indice di parata ottenuta dalla forza"
-- /rb stat str parry
L["Show Parry"] = "Mostra parata"
L["Show Parry from Strength"] = "Mostra l'indice parata ottenuta dalla forza"
---------------------------------------------------------------------------
-- /rb stat agi
L["Agility"] = "Agilità"
L["Changes the display of Agility"] = "Cambia la visualizzazione dell'agilità"
-- /rb stat agi crit
L["Show Crit"] = "Mostra critico"
L["Show Crit chance from Agility"] = "Mostra la probabilità di Critico ottenuta dall'agilità"
-- /rb stat agi dodge
L["Show Dodge"] = "Mostra schivata"
L["Show Dodge chance from Agility"] = "Mostra la probabilità di schivata ottenuta dall'agilità" 
-- /rb stat agi ap
L["Show Attack Power"] = "Mostra potenza d'attacco"
L["Show Attack Power from Agility"] = "Mostra la potenza d'attacco ottenuta dall'agilità"
-- /rb stat agi rap
L["Show Ranged Attack Power"] = "Mostra potenza d'attacco a distanza"
L["Show Ranged Attack Power from Agility"] = "Mostra la potenza d'attacco a distanza ottenuta dall'agilità"
-- /rb stat agi dmg
L["Show Spell Damage"] = "Mostra potenza magica"
L["Show Spell Damage from Agility"] = "Mostra potenza magica otetenuta dall'agilità"
-- /rb stat agi heal
L["Show Healing"] = "Mostra cure"
L["Show Healing from Agility"] = "Mostra cure ottentute dall'agilità"
---------------------------------------------------------------------------
-- /rb stat sta
L["Stamina"] = "Tempra"
L["Changes the display of Stamina"] = "Cambia la visualizzazione della Tempra"
-- /rb stat sta hp
L["Show Health"] = "Mostra punti vita"
L["Show Health from Stamina"] = "Mostra la vita ottenuta dalla Tempra"
-- /rb stat sta dmg
L["Show Spell Damage"] = "Mostra la potenza magica"
L["Show Spell Damage from Stamina"] = "Mostra la potenza magica ottenuta dalla tempra"
-- /rb stat sta heal
L["Show Healing"] = "Mostra cure"
L["Show Healing from Stamina"] = "Mostra le cure ottenute dalla Tempra"
-- /rb stat sta ap
L["Show Attack Power"] = "Mostra potenza d'attacco"
L["Show Attack Power from Stamina"] = "Mostra la potenza d'attacco ottenuta dalla tempra"
---------------------------------------------------------------------------
-- /rb stat int
L["Intellect"] = "Intelletto"
L["Changes the display of Intellect"] = "Cambia la visualizzazione dell'intelletto"
-- /rb stat int spellcrit
L["Show Spell Crit"] = "Mostra critico magico"
L["Show Spell Crit chance from Intellect"] = "Mostra la probabilità di critico magico ottenuto dall'intelletto"
-- /rb stat int mp
L["Show Mana"] = "Mostra mana"
L["Show Mana from Intellect"] = "Mostra il mana ottenuto dall'intelletto"
-- /rb stat int dmg
L["Show Spell Damage"] = "Mostra potenza magica"
L["Show Spell Damage from Intellect"] = "Mostra la potenza magica ottenuta dall'intelletto"
-- /rb stat int heal
L["Show Healing"] = "Mostra cure"
L["Show Healing from Intellect"] = "Mostra le cure ottenute dall'intelletto"
-- /rb stat int mp5
L["Show Combat Mana Regen"] = "Mostra il recupero del mana in combattimento"
L["Show Mana Regen while in combat from Intellect"] = "Mostra il recupero del mana durante il combattimento ottenuto dall'intelletto"
-- /rb stat int mp5oc
L["Show Normal Mana Regen"] = "Mostra il normale recupero del mana"
L["Show Mana Regen while not in combat from Intellect"] = "Mostra il normale recupero del mana quando NON ti trovi in combattimento, ottenuto dall'intelletto"
-- /rb stat int rap
L["Show Ranged Attack Power"] = "Mostra potenza d'attacco a distanza"
L["Show Ranged Attack Power from Intellect"] = "Mostra la potenza d'attacco a distanza ottenuta dall'intelletto"
-- /rb stat int ap
L["Show Attack Power"] = "Mosta potenza d'attacco"
L["Show Attack Power from Intellect"] = "Mostra la potenza d'attacco ottenuta dall'intelletto"
---------------------------------------------------------------------------
-- /rb stat spi
L["Spirit"] = "Spirito"
L["Changes the display of Spirit"] = "Cambia la visualizzazione dello spirito"
-- /rb stat spi mp5
L["Show Combat Mana Regen"] = "Mostra il recupero del mana in combattimento"
L["Show Mana Regen while in combat from Spirit"] = "Mostra il recupero del mana durante il combattimento ottenuto dallo spirito"
-- /rb stat spi mp5oc
L["Show Normal Mana Regen"] = "Mostra il normale recupero del mana"
L["Show Mana Regen while not in combat from Spirit"] = "Mostra il normale recupero del mana quando NON ti trovi in combattimento, ottenuto dallo spirito"
-- /rb stat spi hp5
L["Show Normal Health Regen"] = "Mostra il normale recupero di punti vita"
L["Show Health Regen while not in combat from Spirit"] = "Mostra il normale recupero dei punti vita quando NON ti trovi in combattimento, ottenuto dallo spirito"
-- /rb stat spi dmg
L["Show Spell Damage"] = "Mostra potenza magica"
L["Show Spell Damage from Spirit"] = "Mostra la potenza magica ottenuta dallo spirito"
-- /rb stat spi heal
L["Show Healing"] = "Mostra cure"
L["Show Healing from Spirit"] = "Mostra le cure ottenute dallo spirito"
-- /rb stat spi spellcrit
L["Show Spell Crit"] = "Mostra critico magico"
L["Show Spell Crit chance from Spirit"] = "mostra la probabilità di critico magico, ottenuta dallo spirito"
-- /rb stat spi spellhitrating
L["Show Spell Hit Rating"] = "Mostra indice d'impatto magico"
L["Show Spell Hit Rating from Spirit"] = "Mostra l'indice d'impatto magico ottenuto dallo spirito"
-- /rb stat spi spellhit
L["Show Spell Hit"] = "Mostra impatto magico"
L["Show Spell Hit from Spirit"] = "Mostra l'impatto magico ottenuto dallo spirito"
---------------------------------------------------------------------------
-- /rb stat armor
L["Armor"] = "Armatura"
L["Changes the display of Armor"] = "Cambia la visualizzazione dell'armatura"
-- /rb stat armor ap
L["Show Attack Power"] = "Mostra potenza d'attacco"
L["Show Attack Power from Armor"] = "Mostra potenza d'attacco ottenuta tramite l'armatura"
---------------------------------------------------------------------------
-- /rb sum
L["Stat Summary"] = "Riepilogo Statistico"
L["Options for stat summary"] = "Opzioni per il riepilogo statistico"
-- /rb sum show
L["Show Stat Summary"] = "Visualizza il riepilogo statistico"
L["Select when to show stat summary in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "Seleziona quando visualizzare il riepilogo statistico nella finestra informazioni. Richiede la pressione del tasto assegnato per la visualizzazione"
-- /rb sum ignore
L["Ignore Settings"] = "Ignora settaggi"
L["Ignore stuff when calculating the stat summary"] = "Ignora i potenziamenti durante il calcolo del riepilogo statistico"
-- /rb sum ignore unused
L["Ignore Undesirable Items"] = "Ignora gli oggetti indesiderati"
L["Hide stat summary for undesirable items"] = "Nascondi il riepilogo statistico per gli oggetti indesiderati"
-- /rb sum ignore quality
L["Minimum Item Quality"] = "Qualità minima del livello"
L["Show stat summary only for selected quality items and up"] = "Mostra il riepilogo statistico solo per gli oggetti con la qualità uguale o superiore a quella selezionata"
-- /rb sum ignore armor
L["Armor Types"] = "Tipi di armatura"
L["Select armor types you want to ignore"] = "Seleziona i tipi di armatura che vuoi ignorare"
-- /rb sum ignore armor cloth
L["Ignore Cloth"] = "Ignora Stoffa"
L["Hide stat summary for all cloth armor"] = "Nascondi il riepilogo statistico per tutte le armature in stoffa"
-- /rb sum ignore armor leather
L["Ignore Leather"] = "Ignora Cuoio"
L["Hide stat summary for all leather armor"] = "Nascondi il riepilogo statistico per tutte le armature in cuoio"
-- /rb sum ignore armor mail
L["Ignore Mail"] = "Ignora Maglia"
L["Hide stat summary for all mail armor"] = "Nascondi il riepilogo statistico per tutte le armature in Maglia"
-- /rb sum ignore armor plate
L["Ignore Plate"] = "Ignora Piastre"
L["Hide stat summary for all plate armor"] = "Nascondi il riepilogo statistico per tutte le armature in Piastre"
-- /rb sum ignore equipped
L["Ignore Equipped Items"] = "Ignora gli oggetti equipaggiati"
L["Hide stat summary for equipped items"] = "Ignora il riepilogo statistico per gli oggetti equipaggiati"
-- /rb sum ignore enchant
L["Ignore Enchants"] = "Ignora Incantamenti"
L["Ignore enchants on items when calculating the stat summary"] = "Ignora gli incantamenti sopra gli oggetti durante il calcolo del riepilogo statistico"
-- /rb sum ignore gem
L["Ignore Gems"] = "Ignora Gemme"
L["Ignore gems on items when calculating the stat summary"] = "Ignora le gemme sopra gli oggetti durante il calcolo del riepilogo statistico" 
-- /rb sum ignore prismaticSocket
L["Ignore Prismatic Sockets"] = "Ignora gli incavi prismatici"
L["Ignore gems in prismatic sockets when calculating the stat summary"] = "Ignora le gemme negli incavi prismatici durante il calcolo del riepilogo statistico"
-- /rb sum diffstyle
L["Display Style For Diff Value"] = "Visualizza lo stile per un differente valore"
L["Display diff values in the main tooltip or only in compare tooltips"] = "Visualizza valori differenti nella finestra informazioni primaria o solamente in quella comparativa"
-- /rb sum space
L["Add Empty Line"] = "Aggiungi una linea vuota"
L["Add a empty line before or after stat summary"] = "Aggiungi una linea vuota prima o dopo il riepilogo statistico"
-- /rb sum space before
L["Add Before Summary"] = "Aggiungi prima del riepilogo"
L["Add a empty line before stat summary"] = "Aggiunge una linea vuota prima del riepilogo statistico"
-- /rb sum space after
L["Add After Summary"] = "Aggiungi dopo del riepilogo"
L["Add a empty line after stat summary"] = "Aggiunge una linea vuota dopo il riepilogo statistico"
-- /rb sum icon
L["Show Icon"] = "Mostra icona"
L["Show the sigma icon before summary listing"] = "Mostra l'icona sigma prima del listato riepilogativo"
-- /rb sum title
L["Show Title Text"] = "Mostra il testo del titolo"
L["Show the title text before summary listing"] = "Mostra il testo del titolo prima del listato riepilogativo"
-- /rb sum showzerostat
L["Show Zero Value Stats"] = "Mostra il valore zero statistico"
L["Show zero value stats in summary for consistancy"] = "Mostra il valore zero statistico nel riepilogo per consistenza"
-- /rb sum calcsum
L["Calculate Stat Sum"] = "Calcola la somma statistica"
L["Calculate the total stats for the item"] = "Calcola il totale delle statistiche per l'oggetto"
-- /rb sum calcdiff
L["Calculate Stat Diff"] = "Calcola la differenza statistica"
L["Calculate the stat difference for the item and equipped items"] = "Calcola la differenza statistica fra l'oggetto selezionato e quelli equipaggiati"
-- /rb sum sort
L["Sort StatSummary Alphabetically"] = "Ordina il riepilogo statistico in ordine alfabetico"
L["Enable to sort StatSummary alphabetically, disable to sort according to stat type(basic, physical, spell, tank)"] = "Abilita il riordinamento del riepilogo statistico in ordine alfabetico, disabilitando l'ordine in base al tipo di stat (Base, Mischia, Magia, Difensore)" 
-- /rb sum avoidhasblock
L["Include Block Chance In Avoidance Summary"] = "include la probalilità di blocco nel riepilogo evasivo"
L["Enable to include block chance in Avoidance summary, Disable for only dodge, parry, miss"] = "Abilita l'inserimento della probalilità di blocco nel riepilogo Evasivo, disattivato solo per schivata, parata, mancato"
---------------------------------------------------------------------------
-- /rb sum basic
L["Stat - Basic"] = "Statistica Base"
L["Choose basic stats for summary"] = "Scegli le statistiche di base per il riepilogo"
-- /rb sum basic hp
L["Sum Health"] = "Somma la vita"
L["Health <- Health, Stamina"] = "Vita <- Vita, Tempra"
-- /rb sum basic mp
L["Sum Mana"] = "Somma il mana"
L["Mana <- Mana, Intellect"] = "Mana <- Mana, Intelletto"
-- /rb sum basic mp5
L["Sum Combat Mana Regen"] = "Somma il mana recuperato durante il combattimento"
L["Combat Mana Regen <- Mana Regen, Spirit"] = "Mana recuperato durante il combattimento <- Recupero mana, Spirito"
-- /rb sum basic mp5oc
L["Sum Normal Mana Regen"] = "Somma il normale recupero mana"
L["Normal Mana Regen <- Spirit"] = "normale recupero mana <- Spirito"
-- /rb sum basic hp5
L["Sum Combat Health Regen"] = "Somma la vita recuperata durante il combattimento"
L["Combat Health Regen <- Health Regen"] = "Vita recuperata durante il combattimento <- Recupero vita"
-- /rb sum basic hp5oc
L["Sum Normal Health Regen"] = "Somma il normale recupero vita"
L["Normal Health Regen <- Spirit"] = "normale recupero vita <- Spirito"
-- /rb sum basic str
L["Sum Strength"] = "Somma forza"
L["Strength Summary"] = "Riepilogo forza"
-- /rb sum basic agi
L["Sum Agility"] = "Somma agilità"
L["Agility Summary"] = "Riepilogo agilità"
-- /rb sum basic sta
L["Sum Stamina"] = "Somma Tempra"
L["Stamina Summary"] = "Riepilogo Tempra"
-- /rb sum basic int
L["Sum Intellect"] = "Somma Intelletto"
L["Intellect Summary"] = "Riepilogo Intelletto"
-- /rb sum basic spi
L["Sum Spirit"] = "Somma Spirito"
L["Spirit Summary"] = "Riepilogo spirito"
-- /rb sum basic mastery
L["Sum Mastery"] = "Somma Maestria"
L["Mastery Summary"] = "Riepilogo Maestria"
-- /rb sum basic masteryrating
L["Sum Mastery Rating"] = "Somma indice di Maestria"
L["Mastery Rating Summary"] = "Riepilogo indice di Maestria"
---------------------------------------------------------------------------
-- /rb sum physical
L["Stat - Physical"] = "Statistica da Mischia"
L["Choose physical damage stats for summary"] = "Scegli le statistiche da danno in mischia per il riepilogo"
-- /rb sum physical ap
L["Sum Attack Power"] = "Somma Potenza d'attacco"
L["Attack Power <- Attack Power, Strength, Agility"] = "Potenza d'attacco <- Potenza d'attacco, Forza, Agilità"
-- /rb sum physical rap
L["Sum Ranged Attack Power"] = "Somma Potenza d'attacco a distanza"
L["Ranged Attack Power <- Ranged Attack Power, Intellect, Attack Power, Strength, Agility"] = "Potenza d'attacco a distanza <- Potenza d'attacco a distanza, Intelletto, Potenza d'attacco, Forza, Agilità"
-- /rb sum physical hit
L["Sum Hit Chance"] = "Somma la Probabilità d'impatto"
L["Hit Chance <- Hit Rating"] = "Probabilità d'impatto <- Indice d'impatto"
-- /rb sum physical hitrating
L["Sum Hit Rating"] = "Somma Indice d'impatto"
L["Hit Rating Summary"] = "Riepilogo Indice d'impatto" 
-- /rb sum physical crit
L["Sum Crit Chance"] = "Somma Probabilità di Critico"
L["Crit Chance <- Crit Rating, Agility"] = "Probabilità di Critico <- Indice di Critico, Agilità"
-- /rb sum physical critrating
L["Sum Crit Rating"] = "Somma Indice di Critico"
L["Crit Rating Summary"] = "Riepilogo Indice di Critico"
-- /rb sum physical haste
L["Sum Haste"] = "Somma Celerità"
L["Haste <- Haste Rating"] = "Celerità <- Indice di Celerità"
-- /rb sum physical hasterating
L["Sum Haste Rating"] = "Somma Indice di Celerità"
L["Haste Rating Summary"] = "Riepilogo Indice di Celerità"
-- /rb sum physical rangedhit
L["Sum Ranged Hit Chance"] = "Somma Probabilità d'impatto a distanza"
L["Ranged Hit Chance <- Hit Rating, Ranged Hit Rating"] = "Probabilità d'impatto a distanza <- Indice d'impatto, Indice d'impatto a distanza"
-- /rb sum physical rangedhitrating
L["Sum Ranged Hit Rating"] = "Somma Indice d'impatto a distanza"
L["Ranged Hit Rating Summary"] = "Riepilogo Indice d'impatto a distanza"
-- /rb sum physical rangedcrit
L["Sum Ranged Crit Chance"] = "Somma Probabilità di Critico a distanza"
L["Ranged Crit Chance <- Crit Rating, Agility, Ranged Crit Rating"] = "Probabilità di Critico a distanza <- Indice di Critico, Agilità, Indice d'impatto a distanza" 
-- /rb sum physical rangedcritrating
L["Sum Ranged Crit Rating"] = "Somma Indice d'impatto a distanza" 
L["Ranged Crit Rating Summary"] = "Riepilogo Indice d'impatto a distanza"
-- /rb sum physical rangedhaste
L["Sum Ranged Haste"] = "Somma Celerità a distanza"
L["Ranged Haste <- Haste Rating, Ranged Haste Rating"] = "Celerità a distanza <- Indice di Celerità, Indice di Celerità a distanza"
-- /rb sum physical rangedhasterating
L["Sum Ranged Haste Rating"] = "Somma Indice di Celerità a distanza"
L["Ranged Haste Rating Summary"] = "Riepilogo Indice di Celerità a distanza"
-- /rb sum physical maxdamage
L["Sum Weapon Max Damage"] = "Somma il Danno Massimo da Arma"
L["Weapon Max Damage Summary"] = "Riepilogo Danno Massimo da Arma"
-- /rb sum physical weapondps
--L["Sum Weapon DPS"] = true
--L["Weapon DPS Summary"] = true
-- /rb sum physical wpn
L["Sum Weapon Skill"] = "Somma Skill Arma"
L["Weapon Skill <- Weapon Skill Rating"] = "Skill Arma <- Indice di Skill Arma"
-- /rb sum physical exp
L["Sum Expertise"] = "Somma Perizia"
L["Expertise <- Expertise Rating"] = "Perizia <- Indice di perizia"
-- /rb sum physical exprating
L["Sum Expertise Rating"] = "Somma Indice di perizia"
L["Expertise Rating Summary"] = "Riepilogo Indice di perizia"
---------------------------------------------------------------------------
-- /rb sum spell
L["Stat - Spell"] = "Statistica Magica"
L["Choose spell damage and healing stats for summary"] = "Scegli le statistiche da danno e cura magica per il riepilogo"
-- /rb sum spell power
L["Sum Spell Power"] = "Somma Potenza Magica"
L["Spell Power <- Spell Power, Intellect, Agility, Strength"] = "Potenza Magica <- Potenza Magica, Intelletto, Agilità, Forza"
-- /rb sum spell dmg
L["Sum Spell Damage"] = "Somma Potenza Magica"
L["Spell Damage <- Spell Damage, Intellect, Spirit, Stamina"] = "Potenza Magica <- Potenza Magica, Intelletto, Spirito, Tempra"
-- /rb sum spell dmgholy
L["Sum Holy Spell Damage"] = "Somma Potenza Magica della Luce"
L["Holy Spell Damage <- Holy Spell Damage, Spell Damage, Intellect, Spirit"] = "Potenza Magica della Luce <- Potenza Magica della Luce, Potenza Magica, Intelletto, Spirito"
-- /rb sum spell dmgarcane
L["Sum Arcane Spell Damage"] = "Somma Potenza Magica Arcana"
L["Arcane Spell Damage <- Arcane Spell Damage, Spell Damage, Intellect"] = "Potenza Magica Arcana <- Potenza Magica Arcana, Potenza Magica, Intelletto"
-- /rb sum spell dmgfire
L["Sum Fire Spell Damage"] = "Somma Potenza Magica del Fuoco"
L["Fire Spell Damage <- Fire Spell Damage, Spell Damage, Intellect, Stamina"] = "Potenza Magicadel Fuoco <- Potenza Magica del Fuoco, Potenza Magica, Intelletto, Tempra"
-- /rb sum spell dmgnature
L["Sum Nature Spell Damage"] = "Somma Potenza Magica della Natura"
L["Nature Spell Damage <- Nature Spell Damage, Spell Damage, Intellect"] = "Potenza Magica della Natura <- Potenza Magica della Natura, Potenza Magica, Intelletto"
-- /rb sum spell dmgfrost
L["Sum Frost Spell Damage"] = "Somma Potenza Magica del Gelo"
L["Frost Spell Damage <- Frost Spell Damage, Spell Damage, Intellect"] = "Potenza Magica del Gelo <- Potenza Magica del Gelo, Potenza Magica, Intelletto"
-- /rb sum spell dmgshadow
L["Sum Shadow Spell Damage"] = "Somma Potenza Magica D'Ombra"
L["Shadow Spell Damage <- Shadow Spell Damage, Spell Damage, Intellect, Spirit, Stamina"] = "Potenza Magica D'Ombra <- Potenza Magica D'Ombra, Potenza Magica, Intelletto, Spirito, Tempra"
-- /rb sum spell heal
L["Sum Healing"] = "Somma Cure"
L["Healing <- Healing, Intellect, Spirit, Agility, Strength"] = "Cure <- Cure, Intelletto, Spirito, Agilità, Forza"
-- /rb sum spell crit
L["Sum Spell Crit Chance"] = "Somma Probabilità di Critico Magico"
L["Spell Crit Chance <- Spell Crit Rating, Intellect"] = "Probabilità di critico Magico <- Indice di Critico Magico, Intelletto"
-- /rb sum spell hit
L["Sum Spell Hit Chance"] = "Somma Probabilità D'Impatto Magico"
L["Spell Hit Chance <- Spell Hit Rating"] = "Probabilità D'Impatto Magico <- Indice D'Impatto Magico"
-- /rb sum spell haste
L["Sum Spell Haste"] = "Somma Celerità Magica"
L["Spell Haste <- Spell Haste Rating"] = "Celerità Magica <- Indice di Celerità Magica"
-- /rb sum spell pen
L["Sum Penetration"] = "Somma Breccia Magica"
L["Spell Penetration Summary"] = "Riepilogo Breccia Magica"
-- /rb sum spell hitrating
L["Sum Spell Hit Rating"] = "Somma Indice d'Impatto Magico"
L["Spell Hit Rating Summary"] = "Riepilogo dell'Indice d'Impatto Magico"
-- /rb sum spell critrating
L["Sum Spell Crit Rating"] = "Somma Indice di Critico Magico"
L["Spell Crit Rating Summary"] = "Riepilogo dell'Indice di Critico"
-- /rb sum spell hasterating
L["Sum Spell Haste Rating"] = "Somma Indice di Celerità"
L["Spell Haste Rating Summary"] = "Riepilogo Indice di Celerità"
---------------------------------------------------------------------------
-- /rb sum tank
L["Stat - Tank"] = "Statista Difensore"
L["Choose tank stats for summary"] = "Scegli le statistiche da Difensore per il riepilogo"
-- /rb sum tank armor
L["Sum Armor"] = "Somma Armatura"
L["Armor <- Armor from items and bonuses"] = "Armatura <- Armatura da Oggetti e Bonus"
-- /rb sum tank dodge
L["Sum Dodge Chance"] = "Somma Probabilità di Schivata"
L["Dodge Chance <- Dodge Rating, Agility"] = "Probabilità di Schivata <- Indice di Schivata, Agilità"
-- /rb sum tank parry
L["Sum Parry Chance"] = "Somma Probabilità di Parata"
L["Parry Chance <- Parry Rating"] = "Probabilità di Parata <- Indice di Parata"
-- /rb sum tank block
L["Sum Block Chance"] = "Somma Probabilità di Blocco"
L["Block Chance <- Block Rating"] = "Probabilità di Blocco <- Indice di Blocco"
-- /rb sum tank neglectdodge
L["Sum Dodge Neglect"] = "Somma Trascuranza di Schivata"
L["Dodge Neglect <- Expertise"] = "Trascuranza di Schivata <- Perizia"
-- /rb sum tank neglectparry
L["Sum Parry Neglect"] = "Somma Trascuranza di Parata"
L["Parry Neglect <- Expertise"] = "Trascuranza di Parata <- Perizia"
-- /rb sum tank resarcane
L["Sum Arcane Resistance"] = "Somma Resistenza Arcana"
L["Arcane Resistance Summary"] = "Riepilogo Resistenza Arcana"
-- /rb sum tank resfire
L["Sum Fire Resistance"] = "Somma Resistenza al Fuoco"
L["Fire Resistance Summary"] = "Riepilogo Resistenza al Fuoco"
-- /rb sum tank resnature
L["Sum Nature Resistance"] = "Somma Resistenza Natura"
L["Nature Resistance Summary"] = "Riepilogo Resistenza Natura"
-- /rb sum tank resfrost
L["Sum Frost Resistance"] = "Somma Resistenza al Gelo"
L["Frost Resistance Summary"] = "Riepilogo Resistenza al Gelo"
-- /rb sum tank resshadow
L["Sum Shadow Resistance"] = "Somma Resistenza D'Ombra"	
L["Shadow Resistance Summary"] = "Riepilogo Resistenza D'Ombra"
-- /rb sum tank dodgerating
L["Sum Dodge Rating"] = "Somma Indice di Schivata"
L["Dodge Rating Summary"] = "Riepilogo Indice di Schivata"
-- /rb sum tank parryrating
L["Sum Parry Rating"] = "Somma Indice di Parata"
L["Parry Rating Summary"] = "Riepilogo Indice di Parata"
-- /rb sum tank blockrating
L["Sum Block Rating"] = "Somma Indice di Blocco"
L["Block Rating Summary"] = "Riepilogo Indice di Blocco"
-- /rb sum tank res
L["Sum Resilience"] = "Somma Resilienza"
L["Resilience Summary"] = "Riepilogo Resilienza"
-- /rb sum tank tp
L["Sum TankPoints"] = "Somma Punti Difensore"
L["TankPoints <- Health, Total Reduction"] = "Punti Difensore <- Vita, Riduzioni Totali"
-- /rb sum tank tr
L["Sum Total Reduction"] = "Somma Riduzioni Totali"
L["Total Reduction <- Armor, Dodge, Parry, Block, MobMiss, MobCrit, MobCrush, DamageTakenMods"] = "Riduzioni Totali <- Armatura, Schivata, Parata, Blocco, Colpo nemico a vuoto, Colpo nemico Critico"
-- /rb sum tank avoid
L["Sum Avoidance"] = "Somma Annullamento"
L["Avoidance <- Dodge, Parry, MobMiss, Block(Optional)"] = "Annullamento <- Schivata, Parata, Colpo nemico a vuoto, Blocco(Opzionale)"
---------------------------------------------------------------------------
-- /rb sum gemset
L["Gem Set"] = "Imposta Gemma"
L["Select a gem set to configure"] = "Seleziona una gemma da configurare"
L["Default Gem Set 1"] = "Imp. Pred. Gemma 1"
L["Default Gem Set 2"] = "Imp. Pred. Gemma 2"
L["Default Gem Set 3"] = "Imp. Pred. Gemma 3"
-- /rb sum gem
L["Auto fill empty gem slots"] = "Riempi Automaticamente gli incavi vuoti"
-- /rb sum gem red
L["Red Socket"] = EMPTY_SOCKET_RED
L["ItemID or Link of the gem you would like to auto fill"] = "Inserisci l'ID o il collegamento alla gemma che vuoi Autoincastonare"
L["<ItemID|Link>"] = "ID Oggetto|Collegamento"
L["|cffffff7f%s|r is now set to |cffffff7f[%s]|r"] = "|cffffff7f%s|r è ora impostato in |cffffff7f[%s]|r"
L["Invalid input: %s. ItemID or ItemLink required."] = "Informazione non valida: %s. ID o Collegamento all'oggetto richiesto."
L["Queried server for Gem: %s. Try again in 5 secs."] = "Server Interrogato per la Gemma: %s. Riprova in 5 sec."
-- /rb sum gem yellow
L["Yellow Socket"] = EMPTY_SOCKET_YELLOW
-- /rb sum gem blue
L["Blue Socket"] = EMPTY_SOCKET_BLUE
-- /rb sum gem meta
L["Meta Socket"] = EMPTY_SOCKET_META
-- /rb sum gem2
L["Second set of default gems which can be toggled with a modifier key"] = "L'impostazione predefinita Gemme 2 può essere modificato tramite apposito tasto"
L["Can't use the same modifier as Gem Set 3"] = "Non è possibile usare la stessa modifica per Impostazioni Predefinite Gemme 3"
-- /rb sum gem2 key
L["Toggle Key"] = "Attiva Tasto"
L["Use this key to toggle alternate gems"] = "Usa questo Tasto per alternare le Gemme"
-- /rb sum gem3
L["Third set of default gems which can be toggled with a modifier key"] = "L'impostazione predefinita Gemme 3 può essere modificato tramie apposito tasto"
L["Can't use the same modifier as Gem Set 2"] = "Non è possibile usare la stessa modifica per Impostazioni Predefinite Gemme 2"

-----------------------
-- Item Level and ID --
-----------------------
L["ItemLevel: "] = "Livello Oggetto: "
L["ItemID: "] = "ID Oggetto: "
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
	{pattern = " (.+) di (%d+)", addInfo = "AfterNumber", space = " ", },
	{pattern = "[%+%-](%d+%p?%d*) (.+)", addInfo = "AfterStat", space = " ", },
	--{pattern = "grant.-(%d+)", addInfo = "AfterNumber",}, -- for "grant you xx stat" type pattern, ex: Quel'Serrar ID:18348, Assassination Armor set
	--{pattern = "add.-(%d+)", addInfo = "AfterNumber",}, -- for "add xx stat" type pattern, ex: Adamantite Sharpening Stone ID:23529
	-- Added [^%%] so that it doesn't match strings like "Increases healing by up to 10% of your total Intellect." [Whitemend Pants] ID:24261
	-- Added [^|] so that it doesn't match enchant strings (JewelTips)
}
L["separators"] = {
	"/", " e ", ",", "%. ", " per ", "&", ":",
	-- Fix for [Mirror of Truth]
	-- Equip: Chance on melee and ranged critical strike to increase your attack power by 1000 for 10 secs.
	-- 1000 was falsely detected detected as ranged critical strike
	"aumenta ",
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
SPELL_STAT1_NAME = "Forza"
SPELL_STAT2_NAME = "Agilità"
SPELL_STAT3_NAME = "Tempra"
SPELL_STAT4_NAME = "Intelletto"
SPELL_STAT5_NAME = "Spirito"
--]]

-------------------------
-- Added info patterns --
-------------------------
-- $value will be replaced with the number
-- EX: "$value% Crit" -> "+1.34% Crit"
-- EX: "Crit $value%" -> "Crit +1.34%"
L["$value% Crit"] = "$value% Crit"
L["$value% Spell Crit"] = "$value% Crit Mag"
L["$value% Dodge"] = "$value% Schivata"
L["$value HP"] = "$value Vita"
L["$value MP"] = "$value Mana"
L["$value AP"] = "$value Pot. Att"
L["$value SP"] = "$value Pot. Mag"
L["$value RAP"] = "P.A. Dist"
L["$value Pwr"] = "$value Pot."
L["$value Heal"] = "$value Cure"
L["$value Armor"] = "$value Armatura"
L["$value Block"] = "$value Blocco"
L["$value MP5"] = true
L["$value MP5(OC)"] = true
L["$value HP5"] = true
L["$value to be Dodged/Parried"] = "$value di essere Schivato/Parato"
L["$value to be Crit"] = "$value ricevere colpo crit"
L["$value Crit Dmg Taken"] = "$value Danno Critico Preso"
L["$value DOT Dmg Taken"] = "$value Danno DOT Preso"
L["$value PVP Dmg Taken"] = "$value Danno PVP Preso"
L["$value Parry"] = "$value Parata"
-- for hit rating showing both physical and spell conversions
-- (+1.21%, S+0.98%)
-- (+1.21%, +0.98% S)
L["$value Spell"] = "$value Mag"
L["$value Spell Hit"] = "$value Impatto Mag"

------------------
-- Stat Summary --
------------------
L["Stat Summary"] = "Riepilogo Statistico"