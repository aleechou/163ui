-- $Id: constants.de.lua 4247 2013-09-10 09:12:37Z Dynaletik $
--[[
constants.de.lua
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.

The AL["text"] = true; shortcut can ONLY be used for English (the root translation).
]]

	-- Table holding all loot tables is initialised here as it loads early
	--AtlasLoot_Data = {};
	--AtlasLoot_TableNames = {};

	-- Create the library instance
	local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

	local AL = AceLocale:NewLocale("AtlasLoot", "deDE", false);

-- Register translations
if AL then

	-- #########
	-- UI things
	-- #########
	-- compare frame
	AL["Compare Frame"] = "Vergleichsfenster";
	AL["Show in Compare Frame"] = "Im Vergleichsfenster anzeigen";
	-- AL["Name"] = true;
	AL["ItemLvl"] = "Gegenstandsstufe";
	-- AL["Normal"] = true;
	AL["%d items"] = "%d Gegenstände";
	AL["All"] = "Alle";
	AL["Stats"] = "Werte";
	AL["Show \"Base Stats list\""] = "\"Liste der Grundwerte\" anzeigen";
	AL["Show \"Extra Stats list\""] = "\"Liste der weiteren Werte\" anzeigen";
	AL["Base Stats list"] = "Liste der Grundwerte";
	AL["Extra Stats list"] = "Liste der weiteren Werte";
	AL["Add Stats list"] = "Werteliste hinzufügen";
	AL["Are you sure you want to delete Sort list |cff1eff00%s|r?"] = "Möchten Sie die Sortierliste |cff1eff00%s|r wirklich löschen?";
	AL["Delete Stats list"] = "Werteliste löschen";
	AL["Stats color"] = "Wertefarbe";
	AL["Stats list name:"] = "Wertelistenname";
	AL["Select Stats list"] = "Werteliste auswählen";
	AL["You cant set more then %d item stats."] = "Sie können nicht mehr als %d Gegenstandswerte festlegen.";
	-- AL["Slot"] = true;
	AL["AtlasLoot has detected some corrupted items on your Wishlist. You can now run an automatic check to fix it. Please be aware that this could take a few moments."] = "AtlasLoot hat einige beschädigte Einträge auf Ihrem Wunschzettel gefunden. Sie können jetzt eine automatische Überprüfung zur Behebung des Problems ausführen. Dies kann einige Zeit in Anspruch nehmen.";
	AL["BonusRoll:"] = "Bonusbeute:";
	AL["|cffFF0000Shift+Click: |cffFFFFFFOpen filter configuration"] = "|cffFF0000Shift+Klick: |cffFFFFFFFilterkonfiguration öffnen";

	-- Stats short
	-- AL["iLvl"] = true;	-- Item lvl
	-- AL["str"] = true;	-- Strength
	-- AL["agi"] = true;	-- Agility
	-- AL["sta"] = true;	-- Stamina
	-- AL["int"] = true;	-- Intellect
	-- AL["spi"] = true;	-- Spirit
	-- AL["Crit"] = true;	-- Crit Rating
	-- AL["Dodge"] = true;	-- Dodge Rating
	-- AL["Exp"] = true;	-- Expertise Rating
	-- AL["Hit"] = true;	-- Hit Rating
	-- AL["Haste"] = true;	-- Haste Rating
	-- AL["Parry"] = true;	-- Parry Rating
	-- AL["Spell"] = true;	-- Spell Power
	-- AL["Resi"] = true;	-- Resilience Rating
	-- AL["Mast"] = true;	-- Mastery

	-- Stats
	AL["Resilience Rating"] = "Abhärtungswertung";
	AL["Base Stats"] = "Grundwerte";
	AL["Extra Stats"] = "Weitere Werte";

	-- Loader
	AL["Load AtlasLoot"] = "AtlasLoot laden";
	AL["Module \"%s\" is disabled."] = "Modul \"%s\" ist deaktiviert.";
	AL["Module \"%s\" is missing."] = "Modul \"%s\" fehlt.";

	-- MiniMap-Button
	AL["|cffFF0000Click: |cffFFFFFFOpen AtlasLoot\n|cffFF0000Shift+Click: |cffFFFFFFOpen AtlasLoot-Options "] = "|cffFF0000Klicken: |cffFFFFFFAtlasLoot öffnen\n|cffFF0000Shift+Klicken: |cffFFFFFFAtlasLoot-Optionen öffnen";

	-- AtlasLootFu 
	AL["AtlasLootFu is no longer in use.\nDelete it from your AddOns folder"] = "AtlasLootFu wird nicht mehr verwendet.\nLöschen Sie es aus Ihrem AddOns-Verzeichnis";

	-- Options
	AL["Options"] = "Optionen";
	AL["Load Loot Modules at Startup"] = "Module beim Start laden";
	AL["Toggle Minimap Button"] = "Minimap Button an/aus";
	AL["Toggles the display of the minimap icon"] = "Schaltet den Button an der Minimap an/aus";
	AL["Show itemIDs"] = "Item-IDs anzeigen";
	AL["Show Droprates"] = "Dropraten anzeigen";
	AL["Safe Chat Links"] = "Sichere Chatlinks";
	AL["Comparison Tooltips"] = "Vergleiche Item";
	AL["Show Boss Tooltip"] = "Boss ToolTip anzeigen";
	AL["Show Comparison Tooltips"] = "Zeige eigenes Item zum Vergleich";
	AL["Opaque"] = "Undurchsichtig";
	AL["Make Loot Table Opaque"] = "Schwarzer Hintergrund";
	AL["Treat Crafted Items:"] = "Herstellbare Gegenstände behandeln";
	AL["As Crafting Spells"] = "als Zauber";
	AL["As Items"] = "als Gegenstände";
	AL["Reset"] = "Zurücksetzen";
	AL["Reset Frames"] = "Fenster zurücksetzen";
	AL["Profiles"] = "Profile";
	-- AL["Item Buttons"] = true;
	AL["Loot Table"] = "Beuteverzeichnis";
	AL["Enable mouse on item descriptions"] = "Beschreibungstooltips beim Hovern am Mauszeiger einblenden";
	AL["Upgrade Level:"] = "Aufwertungsgrad:";
	AL["Show BonusRoll info"] = "Info zu Bonusbeute anzeigen";
	AL["Shows if a item is available with bonus roll or raid finder loot."] = "Zeigt, ob ein Gegenstand via Bonusbeute oder im Schlachtzugsbrowser verfügbar ist.";

	-- Default Frame
	AL["Default Frame"] = "Hauptfenster";
	AL["Scale:"] = "Skalierung";
	-- AL["Alpha:"] = true;
	AL["Only change alpha on leave frame"] = "Alpha nur beim Schließen des Fensters ändern";

	-- Bindings
	AL["Toggle AtlasLoot"] = "AtlasLoot ein-/ausblenden";

	-- Help
	AL["Help"] = "Hilfe";
	AL["AtlasLoot Help"] = "AtlasLoot Hilfe";
	AL["For further help, see our website and forums: "] = "Bitte besuchen Sie für weitere Hilfe die Webseite und das Forum: ";
	AL["How to open the standalone Loot Browser:"] = "Eigenständigen Beute-Browser öffnen";
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = "Sollte AtlasLootFu aktiviert sein, klicken Sie einfach den Minimap Button oder den Button in einem installierten Mod wie Titan oder FuBar. Andernfalls können Sie auch einfach '/al' im Chatfenster eingeben.";
	AL["How to view an 'unsafe' item:"] = "'Unsicheren' Gegenstand ansehen:";
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = "Die Symbole unsicherer Gegenstände sind rot umrandet und gekennzeichnet, da sie seit dem letzten Patch oder Serverneustart nicht gesehen wurden. Rechtsklicken Sie den Gegenstand und bewegen dann die Maus wieder über selbigen oder nutzen Sie den 'Serverabfrage' Button am unteren Ende der Beute-Seite.";
	AL["How to view an item in the Dressing Room:"] = "Einen Gegenstand in der Anprobe anzeigen";
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = "Strg+Linksklick auf den Gegenstand. Teilweise wird die Anprobe durch die Atlas oder AtlasLoot Fenster verdeckt. Wenn also nichts passiert, bewegen Sie diese Fenster an einen anderen Platz.";
	AL["How to link an item to someone else:"] = "Einen Gegenstand an jemand anderen verlinken";
	AL["Shift+Left Click the item like you would for any other in-game item"] = "Shift+Linksklick auf den zu verlinkenden Gegenstand";
	AL["How to add an item to the wishlist:"] = "Einen Gegenstand zum Wunschzettel hinzufügen";
	AL["Alt+Left Click any item to add it to the wishlist."] = "Alt+Linksklick auf einen Gegenstand fügt ihn zum Wunschzettel hinzu.";
	AL["How to delete an item from the wishlist:"] = "Einen Gegenstand vom Wunschzettel entfernen";
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = "Zum Entfernen eines Gegenstandes müssen Sie diesen einfach im Wunschzettel Alt+Linksklicken.";
	AL["What else does the wishlist do?"] = "Wofür ist der Wunschzettel sonst noch da?";
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = "Mit einem Linksklick auf einen Gegenstand auf dem Wunschzettel gelangen Sie zu dem Beuteverzeichnis aus dem der Gegenstand stammt. Des Weiteren wird jeder bereits auf dem Wunschzettel befindliche Gegenstand in den Verzeichnissen mit einem zuvor vergebenen Symbol vermerkt.";
	AL["HELP!! I have broken the mod somehow!"] = "HILFE!!! Das Addon läuft nicht mehr!";
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = "Nutzen Sie den Zurücksetzen Button im Optionsmenü oder geben Sie '/al reset' im Chatfenster ein.";

	-- LootButtons
	-- Tooltips
	-- AL["ItemID:"] = true;
	AL["Drop Rate: "] = "Droprate: ";
	-- AL["DKP"] = true;
	AL["Priority:"] = "Priorität:";
	AL["Show price and slot if possible"] = "Preis und Slot anzeigen wenn möglich";
	AL["Show wishlist items in bosses tooltip"] = "Gegenstände des Wunschzettels im ToolTip des Bosses anzeigen";
	AL["Use GameTooltip"] = "Spiel-ToolTip verwenden";
	AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"] = "Statt dem angepassten AtlasLoot-ToolTip den normalen Spiel-ToolTip verwenden";
	-- AL["%d / %d ( Bank: %d )"] = true;
	-- Unsafe Item
	AL["Item Unavailable"] = "Item nicht verfügbar";
	AL["|cff0070ddItemID: %d |r\nThis item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world.\n\nYou can right-click to attempt to query the server.  You may be disconnected."] = "|cff0070ddItemID: %d |r\nDieses Item ist unsicher.  Sobald Sie dieses Item im Spiel gesehen haben, besteht nicht mehr die Gefahr eines Verbindungsabbruchs.\n\nSie können die Abfrage mit einem Rechtsklick erzwingen.  Dies kann zu einem Verbindungsabbruch führen.";
	-- Heriloom Config Window
	AL["Heirloom preview"] = "Erbstückvorschau";
	AL["Change level:"] = "Stufe verändern";
	AL["Shift + Right Click to select character level"] = "Shift + Rechtsklick um Charakterstufe auszuwählen";

	-- LootTableSort
	AL["Sort by Instance"] = "Nach Instanz sortieren";
	AL["Sort loottable by Instance"] = "Lootverzeichnis nach Instanz sortieren";
	AL["Sort by Boss"] = "Nach Boss sortieren";
	AL["Sort loottable by Boss"] = "Lootverzeichnis nach Boss sortieren";
	AL["Item Name"] = "Itemname";
	AL["Item Slot"] = "Itemslot";
	AL["Item Quality"] = "Itemqualität";

	-- Wishlist
	AL["Wishlist"] = "Wunschzettel";
	AL["Wishlists"] = "Wunschzettel";
	AL["Own"] = "Eigene";
	AL["Other"] = "Andere";
	AL["Shared"] = "Geteilte";
	AL["Wishlist name:"] = "Wunschzettelname:";
	AL["Delete"] = "Löschen";
	AL["Share"] = "Teilen";
	AL["Send Wishlist (%s) to"] = "Wunschzettel (%s) senden an";
	AL["Send"] = "Senden";
	AL[" added to the WishList."] = " zum Wunschzettel hinzugefügt";
	AL[" already in the WishList!"] = " bereits auf dem Wunschzettel!";
	AL[" deleted from the WishList."] = " vom Wunschzettel gelöscht";
	AL["Are you sure you want to delete Wishlist |cff1eff00%s|r?"] = "Soll der Wunschzettel |cff1eff00%s|r wirklich gelöscht werden?";
	AL["default"] = "Standard";
	AL[" |cff999999<default>"] = " |cff999999<Standard>";
	AL["Use as default wishlist"] = "Als Standard-Wunschzettel verwenden";
	AL["Add Wishlist"] = "Wunschzettel hinzufügen";
	AL["Always use default Wishlist"] = "Immer Standard-Wunschzettel verwenden";
	AL["Save wishlists at character DB"] = "Wunschzettel in Charakter-DB speichern";
	AL["Saves the wishlists only for |cff1eff00%s-%s|r.\n Other characters cant view the wishlists, but the memory usage is reduced."] = "Speichert die Wunschzettel nur für |cff1eff00%s-%s|r.\n Andere Charaktere können die Wunschzettel nicht einsehen, allerdings wird der Speicherbedarf verringert.";
	AL["Table Sort"] = "Beute sortieren";
	AL["Table Sort:"] = "Beute sortieren:";
	AL["Item Sort:"] = "Items sortieren:";
	AL["Show own wishlists"] = "Eigene Wunschzettel anzeigen";
	AL["Show all wishlists"] = "Alle Wunschzettel anzeigen";

	-- Filter
	-- AL["Filter"] = true;
	AL["Select All Loot"] = "Komplette Beute auswählen";
	AL["Apply Filter:"] = "Filter anwenden:";
	AL["Melee weapons"] = "Nahkampfwaffen:";
	AL["Ranged weapons"] = "Fernkampfwaffen:";
	AL["Other"] = "Andere";
	-- AL["Itemslot"] = true;
	AL["Shift + Click on the Filter button opens the config page."] = "Shift + Klick auf den Filterbutton öffnet die Konfiguration.";

	-- Panel
	AL["Hide Panel"] = "Leiste verstecken";
	AL["Toggle AL Panel"] = "AtlasLoot-Leiste ein/aus";
	-- AL["Buttons"] = true;

	-- Buttons
	AL["Collections"] = "Sammlungen";
	AL["Crafting"] = "Berufe";
	AL["Factions"] = "Fraktionen";
	AL["Load Modules"] = "Module laden";
	AL["PvP Rewards"] = "PvP Belohnungen";
	AL["World Events"] = "Weltereignisse";

	-- QuickLooks
	AL["QuickLook"] = "Lesezeichen";
	AL["QuickLooks"] = "Lesezeichen";
	AL["Number of QuickLooks:"] = "Anzahl der Lesezeichen:";
	AL["Add to QuickLooks:"] = "Lesezeichen hinzufügen";
	AL["Reset Quicklooks"] = "Lesezeichen zurücksetzen";
	AL["Assign this loot table\n to QuickLook"] = "Dieses Beuteverzeichnis dem\n Lesezeichen hinzufügen";
	AL["Show unused QuickLooks in the Panel"] = "Ungenutzte Lesezeichen in der Leiste anzeigen";
	AL["Shows unused QuickLooks as grey buttons in the AtlasLoot Panel"] = "Zeigt ungenutzte Lesezeichen in der AtlasLoot-Leiste ausgegraut an";
	-- Single options
	AL["unused"] = "ungenutzt";
	AL["QuickLook name:"] = "Lesezeichenname";
	AL["Use Boss name"] = "Bossnamen verwenden";
	AL["Use Instance name"] = "Instanznamen verwenden";
	AL["Delete"] = "Löschen";
	AL["Lock"] = "Sperren";
	AL["Enable"] = "Aktivieren";

	-- Query Server / Query all
	AL["Query Server"] = "Serverabfrage";
	AL["Queries the server for all items \non this page. The items will be \nrefreshed when you next mouse \nover them."] = "Fragt den Server nach allen Items \nauf dieser Seite. Die Items werden \ngeladen, sobald Ihr das nächste Mal \nmit der Maus drüber fahrt.";

	-- Atlas
	AL["Click boss name to view loot."] = "Boss klicken um Beute zu sehen.";

	-- LootTable
	-- title
	AL["Heroic"] = "Heroisch";
	AL["25 Man"] = "25 Spieler";
	AL["25 Man Heroic"] = "25 Spieler Heroisch";
	-- buttons
	AL["Show 10 Man Loot"] = "Beute (10 Spieler)";
	AL["Show 25 Man Loot"] = "Beute (25 Spieler)";
	AL["Show Slot"] = "Slot anzeigen";
	AL["Show Price"] = "Preis anzeigen";
	AL["Skill"] = "Fertigkeit";
	AL["Location"] = "Quelle";

	-- #######################################
	-- UI things END
	-- #######################################

	-- Text strings for UI objects
	AL["AtlasLoot"] = "AtlasLoot";
	AL["Select Loot Table"] = "Beuteverzeichnis";
	AL["Select Sub-Table"] = "Unterverzeichnis";
	AL["Various Locations"] = "Verschiedene Orte";
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "Atlasloot zeigt nur Loot an. Falls Sie Karten wünschen, installieren Sie 'Atlas' oder 'Alphamap'.";
	AL["Back"] = "Zurück";
	AL["Level 60"] = "Stufe 60";
	AL["Level 70"] = "Stufe 70";
	AL["Level 80"] = "Stufe 80";
	AL["Level 85"] = "Stufe 85";
	AL["Level 90"] = "Stufe 90";
	AL["|cffff0000(unsafe)"] = " |cffff0000(unsicher)";
	AL["Misc"] = "Sonstiges";
	AL["Rewards"] = "Belohnungen";
	AL["Choose Table ..."] = "Verzeichnis wählen ...";
	AL["Unknown"] = "Unbekannt";
	AL["Reset Wishlist"] = "Wunschzettel zurücksetzen";
	AL["Select a Loot Table..."] = "Wähle ein Beuteverzeichnis ...";
	AL["OR"] = "ODER";
	AL["FuBar Options"] = "FuBar-Optionen";
	AL["Attach to Minimap"] = "An der Minimap anbringen";
	AL["Hide FuBar Plugin"] = "FuBar Plugin verstecken";
	AL["Show FuBar Plugin"] = "FuBar Plugin anzeigen";
	-- AL["Position:"] = true;
	AL["Left"] = "Links";
	AL["Center"] = "Mitte";
	AL["Right"] = "Rechts";
	AL["Hide Text"] = "Text verstecken";
	AL["Hide Icon"] = "Icon verstecken";
	AL["Minimap Button Options"] = "Minimap-Button Optionen";

	-- Text for Options Panel
	AL["Atlasloot Options"] = "AtlasLoot Optionen";
	AL["Default Tooltips"] = "Standard-Tooltips";
	AL["Lootlink Tooltips"] = "Lootlink-Tooltips";
	AL["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dLootlink-Tooltips|r";
	AL["ItemSync Tooltips"] = "ItemSync-Tooltpis";
	AL["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dItemSync-Tooltips|r";
	AL["Use EquipCompare"] = "EquipCompare verwenden";
	AL["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9dBenutze EquipCompare|r";
	AL["Show itemIDs at all times"] = "Item-IDs immer anzeigen";
	AL["Hide AtlasLoot Panel"] = "AtlasLoot-Leiste ausblenden";
	AL["Show Basic Minimap Button"] = "Minimap-Button anzeigen";
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = "|cff9d9d9dMinimap-Button anzeigen|r";
	AL["Set Minimap Button Position"] = "Position des Buttons an der Minimap festlegen";
	AL["Notify on LoD Module Load"] = "Meldung beim automatischen Laden der Module";
	AL["Loot Browser Scale: "] = "AtlasLoot Skalierung";
	AL["Button Position: "] = "Position des Buttons";
	AL["Button Radius: "] = "Radius des Buttons";
	AL["Done"] = "Fertig";
	AL["FuBar Toggle"] = "FuBar ein/aus";
	AL["Search Result: %s"] = "Suchergebnis: %s";
	AL["Search on"] = "Suchen in";
	AL["All modules"] = "Alle Module";
	AL["If checked, AtlasLoot will load and search across all the modules."] = "Lässt AtlasLoot in allen Modulen suchen.";
	AL["Search options"] = "Suchoptionen";
	AL["Partial matching"] = "Teilweise Übereinstimmung";
	AL["If checked, AtlasLoot search item names for a partial match."] = "Lässt AtlasLoot die Itemnamen mit teilweisen Übereinstimmungen durchsuchen.";
	AL["You don't have any module selected to search on!"] = "Du hast kein Modul zur Suche ausgewählt";
	AL["Panel"] = "AtlasLoot-Leiste";

	-- Slash commands
	-- AL["reset"] = true;
	-- AL["options"] = true;
	AL["Reset complete!"] = "AtlasLoot wurde erfolgreich zurückgesetzt!";

	-- AtlasLoot Panel - Search
	AL["Clear"] = "Löschen";
	AL["Last Result"] = "Letzte Suche";
	AL["Search"] = "Suchen";

	-- Crafting Menu
	AL["Crafting Daily Quests"] = "Tägliche Quests der Berufe";
	AL["Cooking Daily"] = "Tägliche Kochquest";
	AL["Fishing Daily"] = "Tägliche Angelquest";
	AL["Jewelcrafting Daily"] = "Tägliche Juwelierquest";
	AL["Crafted Sets"] = "Herstellbare Sets";
	AL["Crafted Epic Weapons"] = "Herstellbare epische Waffen";
	AL["Dragon's Eye"] = "Drachenauge";
	AL["Chimera's Eye"] = "Schimärenauge";
	AL["Serpent's Eye"] = "Serpentin";

	-- Sets/Collections Menu
	-- AL["Sets"] = true;
	-- AL["Set"] = true;
	AL["Justice Points"] = "Gerechtigkeitspunkte";
	AL["Valor Points"] = "Tapferkeitspunkte";
	AL["BoE World Epics"] = "Epische Weltdrops (BoE)";
	AL["Legendary Items"] = "Legendäre Gegenstände";
	AL["Misc Sets"] = "Sets (Sonstige)";
	-- AL["Tier Sets"] = true;
	-- AL["Tier 1/2 Set"] = true;
	-- AL["Tier 1/2/3 Set"] = true;
	-- AL["Tier 3 Set"] = true;
	-- AL["Tier 4/5/6 Set"] = true;
	-- AL["Tier 7/8 Set"] = true;
	-- AL["Tier 9 Set"] = true;
	-- AL["Tier 10 Set"] = true;
	-- AL["Tier 11/12 Set"] = true;
	-- AL["Tier 13 Set"] = true;
	-- AL["Tier 14 Set"] = true;
	-- AL["Tier 15 Set"] = true;
	-- AL["Tier 16 Set"] = true;
	AL["TCG Items"] = "TCG Gegenstände";
	AL["Rare Mobs"] = "Rare-Mobs";
	AL["Grand Marshal"] = "Großmarschall";
	-- AL["Gladiator"] = true;
	AL["Vengeful"] = "Rachsüchtig";
	AL["Merciless"] = "Erbarmungslos";
	-- AL["Brutal"] = true;
	AL["Wrathful"] = "Zornerfüllt";
	AL["Cataclysmic"] = "Kataklysmisch";
	--AL["ilvl %d"] = true;

	-- PvP Menu
	AL["Arathi Basin Sets"] = "Arathibecken (Sets)";
	AL["PvP Accessories"] = "PvP-Zubehör";
	AL["PvP Armor Sets"] = "PvP-Rüstungssets";
	AL["PvP Weapons"] = "PvP-Waffen";
	AL["PvP Non-Set Epics"] = "PvP Nicht-Set Epics";
	AL["PvP Reputation Sets"] = "PvP-Rufbelohnungen";
	AL["PvP Misc"] = "PvP (Sonstiges)";
	AL["PVP Gems/Enchants/Jewelcrafting Designs"] = "PvP Edelsteine/Verzauberungen/Rezepte";
	AL["PvP Trinkets"] = "PvP Schmuckstücke";

	-- World Events
	AL["Abyssal Council"] = "Abyssischer Rat";
	AL["Argent Tournament"] = "Argentumturnier";
	AL["Bash'ir Landing Skyguard Raid"] = "Landeplatz von Bash'ir Himmelswache Raid";
	AL["Brewfest"] = "Braufest";
	AL["Children's Week"] = "Kinderwoche";
	AL["Day of the Dead"] = "Tag der Toten";
	AL["Ethereum Prison"] = "Gefängnis des Astraleums";
	AL["Feast of Winter Veil"] = "Winterhauchfest";
	AL["Gurubashi Arena Booty Run"] = "Gurubashiarena";
	AL["Hallow's End"] = "Schlotternächte";
	AL["Harvest Festival"] = "Erntedankfest";
	AL["Love is in the Air"] = "Liebe liegt in der Luft";
	AL["Lunar Festival"] = "Mondfest";
	AL["Midsummer Fire Festival"] = "Sonnenwendfest";
	AL["Noblegarden"] = "Nobelgarten";
	AL["Pilgrim's Bounty"] = "Pilgerfreuden";
	-- AL["Skettis"] = true;
	AL["Stranglethorn Fishing Extravaganza"] = "Anglerwettbewerb im Schlingendorntal";
	AL["Kalu'ak Fishing Derby"] = "Angelwettstreit der Kalu'ak";
	AL["Fishing Contests"] = "Angelwettbewerbe";

	-- World Events	Menu Names
	AL["Special Rewards"] = "Spezielle Belohnungen";
	AL["Brew of the Month Club"] = "Bier des Monats e.V.";
	AL["Food and Drinks"] = "Speisen und Getränke";
	AL["Gifts & Presents"] = "Geschenke";
	AL["Playable Race Masks"] = "Masken spielbarer Völker";
	AL["Non-Playable Race Masks"] = "Masken nicht spielbarer Völker";
	AL["Schematics & Patterns"] = "Baupläne & Muster";
	AL["Toys"] = "Spielzeuge";

	-- Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00Linksklick|r Beuteverzeichnis durchsuchen";
	AL["|cffff0000Right-Click|r View Options"] = "|cff1eff00Rechtsklick|r Optionen anzeigen";
	AL["|cffff0000Shift-Click|r View Options"] = "|cffff0000Shiftklick|r Optionen anzeigen";
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffccccccLinksklick + Ziehen|r Minimap Button bewegen";
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = "|cffccccccRechtsklick + Ziehen|r Minimap Button bewegen";

	-- Default Frame
	AL["Select Module"] = "Modul wählen";
	AL["Select Instance"] = "Instanz wählen";

	-- Wishlist
	AL["Close"] = "Schließen";
	AL["Own Wishlists"] = "Eigene Wunschzettel";
	AL["Other Wishlists"] = "Andere Wunschzettel";
	AL["Shared Wishlists"] = "Geteilte Wunschzettel";
	AL["Mark items in loot tables"] = "Items im Verzeichnis hervorheben";
	AL["Mark items from own Wishlist"] = "Items eigener Wunschzettel hervorheben";
	AL["Mark items from all Wishlists"] = "Items aller Wunschzettel hervorheben";
	AL["Enable Wishlist Sharing"] = "Teilen von Wunschzetteln aktivieren";
	AL["Auto reject in combat"] = "Automatisches Ablehnen im Kampf";
	AL["Edit Wishlist"] = "Wunschzettel bearbeiten";
	AL["Show More Icons"] = "Weitere Icons anzeigen";
	AL["Edit"] = "Bearbeiten";
	AL["Show all Wishlists"] = "Alle Wunschzettel zeigen";
	AL["Show own Wishlists"] = "Eigene Wunschzettel zeigen";
	AL["Show shared Wishlists"] = "Geteilte Wunschzettel zeigen";
	AL["You must wait "] = "Sie müssen ";
	AL[" seconds before you can send a new Wishlist to "] = " Sekunden warten bis Sie einen neuen Wunschzettel schicken können an ";
	AL["Cancel"] = "Abbrechen";
	AL["Delete Wishlist %s?"] = "Wunschzettel %s löschen?";
	AL["%s sends you a Wishlist. Accept?"] = "%s sendet einen Wunschzettel. Annehmen?";
	AL[" tried to send you a Wishlist. Rejected because you are in combat."] = " hat versucht einen Wunschzettel zu senden. Wegen Kampf abgelehnt.";
	AL[" rejects your Wishlist."] = " lehnt den Wunschzettel ab.";
	AL["You can't send Wishlists to yourself"] = "Sie können siche selber keinen Wunschzettel senden";
	AL["Please set a default Wishlist."] = "Bitte Standard-Wunschzettel festlegen.";
	AL["Set as default Wishlist"] = "Zum Standard-Wunschzettel machen";

	-- Misc Inventory related words
	AL["Scope"] = "Zielfernrohr";
	AL["Darkmoon Faire Card"] = "Dunkelmond-Karte";
	-- AL["Banner"] = true;
	-- AL["Set"] = true;
	AL["Token"] = "Gutschein";
	AL["Combat Pet"] = "Haustier (Kampf)";
	AL["Fireworks"] = "Feuerwerk";
	AL["Transformation Item"] = "Verwandlungsitem";
	AL["Keys"] = "Schlüssel";

	-- Extra inventory stuff
	AL["Cloak"] = "Umhang";

	-- Alchemy
	AL["Battle Elixirs"] = "Kampfelixiere";
	AL["Cauldron"] = "Kessel";
	AL["Cauldrons"] = "Kessel";
	AL["Guardian Elixirs"] = "Wächterelixiere";
	AL["Oils"] = "Öle";
	AL["Other Elixirs"] = "Andere Elixiere";
	AL["Potions"] = "Tränke";
	AL["Transmutes"] = "Transmutieren";
	AL["Flasks"] = "Fläschchen";

	-- Blacksmithing
	AL["Armor Enhancements"] = "Rüstungsverbesserungen";
	AL["Weapon Enhancements"] = "Waffenverbesserungen";
	AL["Cataclysm Vendor Sold Plans"] = "Cataclysm - Vom Händler verkaufte Pläne";
	AL["Mists of Pandaria Vendor Sold Plans"] = "MoP - Vom Händler verkaufte Pläne";
	AL["Training Projects"] = "Übungsprojekte";

	-- Cooking
	AL["Banquets/Feasts"] = "Bankette/Festmähler";

	-- Enchanting
	AL["Enchant Boots"] = "Stiefel verzaubern";
	AL["Enchant Bracer"] = "Armschienen verzaubern";
	AL["Enchant Chest"] = "Brust verzaubern";
	AL["Enchant Cloak"] = "Umhang verzaubern";
	AL["Enchant Gloves"] = "Handschuhe verzaubern";
	AL["Enchant Ring"] = "Ring verzaubern";
	AL["Enchant Shield & Off-Hand"] = "Schild & Nebenhand verzaubern";
	AL["Enchant 2H Weapon"] = "2H Waffe verzaubern";
	AL["Enchant Weapon"] = "Waffe verzaubern";
	AL["Cataclysm Vendor Sold Formulas"] = "Cataclysm - Vom Händler verkaufte Formeln";

	-- Engineering
	AL["Tinker"] = "Basteln";

	-- Fishing
	AL["Fish Weapons"] = "Fisch-Waffen";
	AL["Fishing Gear"] = "Angelausrüstung";
	AL["Fishing Lines"] = "Angelschnüre";

	-- Inscription
	AL["Major Glyph"] = "Erhebliche Glyphe";
	AL["Minor Glyph"] = "Geringe Glyphe";
	AL["Runescrolls"] = "Runenschriftrollen";
	AL["Recall"] = "Rückruf";
	AL["Scrolls"] = "Rollen";
	AL["Off-Hand Items"] = "Nebenhand-Gegenstände";
	AL["Shoulder Enchants"] = "Schulterverzauberungen";
	AL["Reagents"] = "Reagenzien";

	-- Leatherworking
	AL["Leather Armor"] = "Lederrüstungen";
	AL["Mail Armor"] = "Kettenrüstungen";
	AL["Cloaks"] = "Umhänge";
	AL["Item Enhancements"] = "Gegenstandsverbesserungen";
	AL["Drums, Bags and Misc."] = "Trommeln, Taschen, usw.";

	-- Tailoring
	AL["Shirts"] = "Hemden";
	AL["Bags"] = "Taschen";
	AL["Cataclysm Vendor Sold Patterns"] = "Cataclysm - Vom Händler verkaufte Muster";
	AL["Mists of Pandaria Vendor Sold Patterns"] = "MoP - Vom Händler verkaufte Muster";

	-- Labels for loot descriptions
	AL["Classes:"] = "Klassen:";
	AL["This Item Begins a Quest"] = "Dieser Gegenstand startet eine Quest";
	AL["Quest Item"] = "Questgegenstand";
	AL["Old Quest Item"] = "Alter Questgegenstand";
	AL["Quest Reward"] = "Questbelohnung";
	AL["Old Quest Reward"] = "Alte Questbelohnung";
	AL["Shared"] = "geteilter Loot";
	AL["Right Half"] = "Rechte Hälfte";
	AL["Left Half"] = "Linke Hälfte";
	AL["Currency"] = "Zum Kaufen von Belohnungen";
	AL["Used to summon boss"] = "Zur Beschwörung benötigt (Boss)";
	AL["Tradable against sunmote + item above"] = "Tausch:obiges Item + Sonnenpartikel";
	AL["Card Game Item"] = "Kartenspiel Item";
	AL["Skill Required:"] = "Benötigte Fertigkeit:";
	AL["Rating:"] = "Wertung"; -- Shorthand for 'Required Rating' for the personal/team ratings
	AL["Random Heroic Reward"] = "Zufällige heroische Belohnung";
	AL["Fishing Daily Reward"] = "Tägliche Angelquest-Belohnung";
	-- AL["Collector's Edition"] = true;
	AL["Daily Reward"] = "Tägliche Belohnung";
	AL["No Longer Available"] = "Nicht mehr erhältlich";
	AL["Shared Boss Loot"] = "Geteilter Bossloot";
	AL["Shared Zone Loot"] = "Geteilter Gebietsloot";
	AL["Black Market Auction House"] = "Schwarzmarktauktionshaus";

	-- Minor Labels for loot table descriptions
	AL["Classic WoW"] = "Klassisch";
	-- AL["Burning Crusade"] = true;
	-- AL["Wrath of the Lich King"] = true;
	-- AL["Cataclysm"] = true;
	-- AL["Mists of Pandaria"] = true;
	AL["Entrance"] = "Eingang";
	-- AL["Dungeon Set 1"] = true;
	-- AL["Dungeon Set 2"] = true;
	-- AL["Dungeon Set 1/2"] = true;
	AL["Replica"] = "Nachbildungen";
	-- AL["Dungeon Set 3"] = true;
	-- AL["Dungeon Set 4"] = true;
	-- AL["Tier %d"] = true;
	AL["Challenge Mode Armor Sets"] = "Herausforderungsmodus Rüstungssets";
	AL["10 Man"] = "10 Spieler";
	AL["10/25 Man"] = "10/25 Spieler";
	AL["Epic Set"] = "Episches Set";
	AL["Rare Set"] = "Seltenes Set";
	AL["Season %d"] = "Saison %d";
	AL["Fire"] = "Feuer";
	AL["Water"] = "Wasser";
	AL["Wind"] = "Wind";
	AL["Earth"] = "Erde";
	AL["Master Angler"] = "Anglermeister";	
	AL["Fire Resistance Gear"] = "Feuerresistenz";
	AL["Arcane Resistance Gear"] = "Arkanresistenz";	
	AL["Nature Resistance Gear"] = "Naturresistenz";
	AL["Frost Resistance Gear"] = "Frostresistenz";
	AL["Shadow Resistance Gear"] = "Schattenresistenz";

	-- Labels for loot table sections
	AL["Additional Heroic Loot"] = "Zusätzliche heroische Beute";
	AL["Heroic Mode"] = "Heroisch";
	AL["Normal Mode"] = "Normal";
	-- AL["Hard Mode"] = true;
	AL["Bonus Loot"] = "Zusatzbeute";
	AL["Arena Reward"] = "Arena Belohnung";
	AL["Achievement Reward"] = "Erfolgsbelohnung";
	-- AL["Phase 1"] = true;
	-- AL["Phase 2"] = true;
	-- AL["Phase 3"] = true;
	AL["First Prize"] = "Hauptpreis";
	AL["Rare Fish Rewards"] = "Besonderer Fisch - Belohnungen";
	AL["Rare Fish"] = "Besondere Fische";
	AL["Weapons"] = "Waffen";
	AL["Accessories"] = "Zubehör";
	AL["Rare"] = "Selten";
	AL["Specializations"] = "Spezialisierungen";
	AL["Flexible"] = "Flexibel";
	AL["Raid Finder"] = "Schlachtzugsbrowser";
	AL["Thunderforged"] = "Donnergeschmiedet";
	AL["Warforged"] = "Kriegsgeschmiedet";
	AL["Pandaria World Bosses"] = "Pandaria Weltbosse";
	-- AL["Elite"] = true;
	AL["Vegetables"] = "Gemüse";

	-- Loot Table Names
	AL["Level %s"] = "Stufe %s";
	AL["Summon"] = "Beschwörbar";
	AL["Random"] = "Zufällig";

	-- Profession descriptions
	-- AL["Buff"] = true;
	AL["Agility"] = "Beweglichkeit";
	AL["Attributes"] = "Attribute";
	AL["Intellect"] = "Intelligenz";
	AL["Strength"] = "Stärke";
	AL["Spirit"] = "Willenskraft";
	AL["Stamina"] = "Ausdauer";
	AL["Spell Power"] = "Zaubermacht";
	AL["Attack Power"] = "Angriffskraft";
	AL["Spell/Attack Power"] = "Zaubermacht/Angriffskraft";
	AL["Hit Rating"] = "Trefferwertung";
	AL["Crit Rating"] = "Kritische Trefferwertung";
	AL["Haste Rating"] = "Tempowertung";
	AL["Dodge Rating"] = "Ausweichwertung";
	AL["Expertise Rating"] = "Waffenkundewertung";
	AL["Mastery Rating"] = "Meisterschaftswertung";
	AL["Parry Rating"] = "Parierwertung";
	AL["Other Ratings"] = "Andere Wertungen";
	AL["Ratings"] = "Wertungen";
	AL["Damage Absorption"] = "Schadenssbsorption";
	AL["Health / Second"] = "Gesundheit / Sekunde";
	AL["Mana / Second"] = "Mana / Sekunde";
	AL["Tracking"] = "Aufspürung";
	AL["Emotions"] = "Emotionen";
	AL["Alcohol"] = "Alkohol";
	AL["Health"] = "Gesundheit";
	-- AL["Mana"] = true;
	AL["Health and Mana"] = "Gesundheit und Mana";
	AL["Other Buffs"] = "Andere Buffs";
	AL["Other"] = "Andere";
	AL["Standard Buffs"] = "Standard-Buffs";
	AL["Food without Buffs"] = "Speisen ohne Buff";
	AL["Special"] = "Speziell";
	AL["Feasts"] = "Festmähler";
	AL["Speed"] = "Tempo";
	AL["Oil"] = "Öl";
	AL["Culture"] = "Volk";
	AL["Description"] = "Beschreibung";
	-- AL["Draenei"] = true;
	AL["Dwarf"] = "Zwerge";
	AL["Fossil"] = "Fossilien";
	AL["Mantid"] = "Mantis";
	-- AL["Mogu"] = true;
	AL["Nerubian"] = "Neruber";
	AL["Night Elf"] = "Nachtelfen";
	AL["Orc"] = "Orcs";
	-- AL["Pandaren"] = true;
	-- AL["Tol'vir"] = true;
	AL["Troll"] = "Trolle";
	-- AL["Vrykul"] = true;
	AL["Stats"] = "Werte";
	AL["Resilience"] = "Abhärtung";
	AL["Professions"] = "Berufe";
	AL["Damage"] = "Schaden";
	-- AL["Proc"] = true;

	-- Extra Text in Boss lists
	AL["AQ20 Class Sets"] = "AQ20-Klassen-Sets";
	AL["AQ Enchants"] = "AQ-Verzauberungen";
	AL["AQ40 Class Sets"] = "AQ40-Klassen-Sets";
	AL["AQ Opening Quest Chain"] = "AQ-Öffnungsquestreihe";
	AL["Tribute Run"] = "Tribut Run";
	AL["Dire Maul Books"] = "Düsterbruch Bücher";
	AL["Random Boss Loot"] = "Zufälliger Boss Loot";
	AL["Formula/Patterns/Plans"] = "Formeln/Muster/Pläne";
	AL["BRD Blacksmithing Plans"] = "Schwarzfelstiefen Schmiedepläne";
	AL["Patterns/Plans"] = "Muster/Pläne";

	-- General titles
	AL["Achievement"] = "Erfolg";
	-- AL["Dungeon"] = true;
	AL["Outdoor"] = "Außenwelt";
	AL["Promotional"] = "Promotion";
	-- AL["PvP"] = true;
	AL["Raid"] = "Schlachtzug";

	-- Companions
	AL["Achievement Companions"] = "Erfolgs-Haustiere";
	AL["Faction Companions"] = "Fraktions-Haustiere";
	AL["Card Game Companions"] = "Kartenspiel-Haustiere";
	AL["Companion Accessories"] = "Haustierzubehör";
	AL["Blizzard Store"] = "Blizzard Shop";
	AL["Crafted Companions"] = "Hergestellte Haustiere";
	AL["Dungeon/Raid"] = "Instanz/Schlachtzug";
	AL["Faction"] = "Fraktion";
	AL["Merchant Sold Companions"] = "Vom Händler verkauft";
	AL["Pets"] = "Haustiere";
	AL["Promotional Companions"] = "Promotions-Haustiere";
	AL["Quest Reward Companions"] = "Questbelohnungs-Haustiere";
	AL["Rare Companions"] = "Seltene Haustiere";
	AL["Unobtainable Companions"] = "Nicht mehr erhältlich";
	AL["New Companions"] = "Neue Haustiere";
	--- Drop Locations
	AL["Bogflare Needler"] = "Sumpflichtschwärmer";
	AL["Deviate Ravager/Deviate Guardian"] = "Deviatverheerer/Deviatwächter";
	AL["Gundrak Raptor"] = "Raptor von Gundrak";
	AL["Noxious Whelp"] = "Giftiger Welpe";

	-- Mounts
	AL["Alliance Mounts"] = "Allianz Reittiere";
	AL["Horde Mounts"] = "Horde Reittiere";
	AL["Flying Mounts"] = "Flugreittiere";
	AL["Card Game Mounts"] = "Kartenspielreittiere";
	AL["Crafted Mounts"] = "Herstellbar";
	AL["Event Mounts"] = "Eventreittiere";
	AL["Neutral Faction Mounts"] = "Fraktionsneutrale Reittiere";
	AL["PvP Mounts"] = "PvP Reittiere";
	AL["Alliance PvP Mounts"] = "Allianz PvP Reittiere";
	AL["Horde PvP Mounts"] = "Horde PvP Reittiere";
	AL["Halaa PvP Mounts"] = "Halaa PvP Reittiere";
	AL["Promotional Mounts"] = "Promotions-Reittiere";
	AL["Rare Mounts"] = "Seltene Reittiere";
	AL["Unobtainable Mounts"] = "Nicht mehr erhältlich";
	AL["New Mounts"] = "Neue Reittiere";
	AL["Mount Collecting"] = "Sammeln von Reittieren";

	-- Tabards
	AL["Achievement & Quest Reward Tabards"] = "Erfolgs & Questbelohnungen";
	AL["Alliance Tabards"] = "Allianz Wappenröcke";
	AL["Card Game Tabards"] = "Kartenspiel Wappenröcke";
	AL["Horde Tabards"] = "Horde Wappenröcke";
	AL["Neutral Faction Tabards"] = "Wappenröcke neutraler Fraktionen";
	AL["PvP Tabards"] = "PvP Wappenröcke";
	AL["Unobtainable Tabards"] = "Nicht mehr erhältlich";

	-- Transformation Items
	AL["Transformation Items"] = "Transformations-Gegenstände";
	AL["Additional Effects Transformation Items"] = "Mit zusätzlichen Effekten";
	AL["Consumable Transformation Items"] = "Verbrauchbar";
	AL["Non-consumed Transformation Items"] = "Nicht verbrauchbar";

	-- Heirloom and BoA Items
	AL["Heirloom"] = "Erbstücke";
	AL["PvP Heirlooms"] = "PvP Erbstücke";
	AL["Bind on Account"] = "Accountgebunden";
	AL["Bind on Account Armor"] = "Accountgebundene Rüstungen";
	AL["Bind on Account Weapons"] = "Accountgebundene Waffen";

	-- Darkmoon Faire
	AL["Darkmoon Faire Rewards"] = "Dunkelmond-Jahrmarkt Belohnungen";
	AL["Low Level Decks"] = "Niedrigstufige Decks";
	AL["Level 60 & 70 Trinkets"] = "Stufe 60 & 70 Schmuckstücke";
	AL["Trinkets"] = "Schmuckstücke";

	-- Card Game Decks and descriptions
	AL["Loot Card Items"] = "Beutekarten Gegenstände";
	AL["UDE Items"] = "UDE Gegenstände";

	-- First set
	AL["Heroes of Azeroth"] = "Helden von Azeroth";
	AL["Landro Longshot"] = "Landro Fernblick";
	AL["Thunderhead Hippogryph"] = "Donnerkopfhippogryph";
	AL["Saltwater Snapjaw"] = "Salzwasserschnappkiefer";

	-- Second set
	AL["Through The Dark Portal"] = "Durch das Dunkle Portal";
	AL["King Mukla"] = "König Mukla";
	AL["Rest and Relaxation"] = "Ruhe und Entspannung";
	AL["Fortune Telling"] = "Wahrsagen";

	-- Third set
	AL["Fires of Outland"] = "Feuer der Scherbenwelt";
	AL["Spectral Tiger"] = "Spektraltiger";
	AL["Gone Fishin'"] = "Bin Angeln'";
	AL["Goblin Gumbo"] = "Goblineintopf";

	-- Fourth set
	AL["March of the Legion"] = "Marsch der Legion";
	AL["Kiting"] = "Papierdrachen";
	AL["Robotic Homing Chicken"] = "Raketenhühnchen";
	AL["Paper Airplane"] = "Papierflugmaschine";

	-- Fifth set
	AL["Servants of the Betrayer"] = "Diener des Verräters";
	AL["X-51 Nether-Rocket"] = "X-51 Netherrakete";
	AL["Personal Weather Machine"] = "Persönlicher Wettermacher";
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = "Papa Hummels altmodischer Tierkuchen";

	-- Sixth set
	AL["Hunt for Illidan"] = "Jagd nach Illidan";
	AL["The Footsteps of Illidan"] = "Die Fußspuren von Illidan";
	AL["Disco Inferno!"] = "Disko-Inferno";
	AL["Ethereal Plunderer"] = "Astraler Brandschatzer";

	-- Seventh set
	AL["Drums of War"] = "Trommeln des Krieges";
	AL["The Red Bearon"] = "Der rote Bäron";
	AL["Owned!"] = "pWn3d!";
	-- AL["Slashdance"] = true;

	-- Eighth set
	AL["Blood of Gladiators"] = "Blut der Gladiatoren";
	AL["Sandbox Tiger"] = "Sandkastentiger";
	AL["Center of Attention"] = "Mittelpunkt der Aufmerksamkeit";
	AL["Foam Sword Rack"] = "Schaumstoffschwertständer";

	-- Ninth set
	AL["Fields of Honor"] = "Felder der Ehre";
	AL["Path of Cenarius"] = "Pfad des Cenarius";
	-- AL["Pinata"] = true;
	-- AL["El Pollo Grande"] = true;

	-- Tenth set
	AL["Scourgewar"] = "Krieg der Geißel";
	AL["Tiny"] = "Winzling";
	AL["Tuskarr Kite"] = "Tuskarrdrachen";
	AL["Spectral Kitten"] = "Spektralkätzchen";

	-- Eleventh set
	AL["Wrathgate"] = "Pforte des Zorns";
	AL["Statue Generator"] = "Instantstatue";
	AL["Landro's Gift"] = "Landros Geschenkkiste";
	AL["Blazing Hippogryph"] = "Flammender Hippogryph";

	-- Twelvth set
	AL["Icecrown"] = "Eiskrone";
	AL["Wooly White Rhino"] = "Wolliges weißes Rhino";
	AL["Ethereal Portal"] = "Etherportal";
	AL["Paint Bomb"] = "Farbbombe";

	-- Thirtheenth set
	AL["Worldbreaker"] = "Weltenbrecher";
	AL["Mottled Drake"] = "Scheckiger Drache";
	AL["Grim Campfire"] = "Finsteres Lagerfeuer";
	AL["Landro's Lil' XT"] = "Landros XT der Kleine";

	-- Fourteenth set
	AL["War of the Elements"] = "Krieg der Elemente";

	-- Fifteenth set
	AL["Twilight of the Dragons"] = "Drachendämmerung";

	-- Seventeenth set
	AL["Crown of Heaven"] = "Krone des Himmels";

	-- Eighteenth set
	AL["Tomb of the Forgotten"] = "Gruft der Vergessenen";

	-- Nineteenth set
	AL["War of the Ancients"] = "Zeitwandler: Der Krieg der Ahnen";

	-- Twentieth set
	-- AL["Betrayal of the Guardian"] = true;

	-- Battleground Brackets
	AL["Old PvP Rewards"] = "Alte PvP Belohnungen";
	AL["BG/Open PvP Rewards"] = "BG/Open PvP Belohnungen";
	AL["Misc. Rewards"] = "Diverses";
	AL["Level %s Rewards"] = "Belohnungen (Stufe %s)";

	-- Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = "Der Pfad des Eroberers";
	AL["Path of the Invoker"] = "Der Pfad des Herbeirufers";
	AL["Path of the Protector"] = "Der Pfad des Beschützers";

	-- Violet Eye Paths
	AL["Path of the Violet Protector"] = "Violetter Beschützer";
	AL["Path of the Violet Mage"] = "Violetter Magier";
	AL["Path of the Violet Assassin"] = "Violetter Auftragsmörder";
	AL["Path of the Violet Restorer"] = "Violetter Bewahrer";

	-- Ashen Verdict Paths
	AL["Path of Courage"] = "Weg des Mutes";
	AL["Path of Destruction"] = "Weg der Zerstörung";
	AL["Path of Vengeance"] = "Weg der Vergeltung";
	AL["Path of Wisdom"] = "Weg der Weisheit";

	-- AQ Opening Event
	AL["Red Scepter Shard"] = "Roter Szeptersplitter";
	AL["Blue Scepter Shard"] = "Blauer Szeptersplitter";
	AL["Green Scepter Shard"] = "Grüner Szeptersplitter";
	AL["Scepter of the Shifting Sands"] = "Das Szepter der Sandstürme";

	-- World PvP
	AL["Hellfire Fortifications"] = "Befestigung des Höllenfeuers";
	AL["Twin Spire Ruins"] = "Ruinen der Zwillingsspitze";
	AL["Spirit Towers"] = "Geistertürme";
	-- AL["Halaa"] = true;
	AL["Venture Bay"] = "Venturebucht";

	-- Karazhan Opera Event Headings
	AL["Wizard of Oz"] = "Zauberer von Oz";
	AL["Red Riding Hood"] = "Rotkäppchen";

	-- Karazhan Animal Boss Types
	AL["Spider"] = "Spinne";
	AL["Darkhound"] = "Schattenhund";
	AL["Bat"] = "Fledermaus";

	-- AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = "Verschnörkelter Griff";
	AL["Qiraji Martial Drape"] = "Kampftuch";
	AL["Qiraji Magisterial Ring"] = "Gebieterring";
	AL["Qiraji Ceremonial Ring"] = "Zeremonienring";
	AL["Qiraji Regal Drape"] = "Hoheitstuch";
	AL["Qiraji Spiked Hilt"] = "Stachelgriff";

	-- AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = "Dominanzbindungen";
	AL["Qiraji Bindings of Command"] = "Befehlsbindungen";
	AL["Vek'nilash's Circlet"] = "Vek'nilashs Reif";
	AL["Vek'lor's Diadem"] = "Vek'lors Diadem";
	AL["Ouro's Intact Hide"] = "Ouros intakte Haut";
	AL["Skin of the Great Sandworm"] = "Haut des Sandwurms";
	AL["Husk of the Old God"] = "Hülle des Gottes";
	AL["Carapace of the Old God"] = "Knochenpanzer des Gottes";

	-- Faction related strings
	-- AL["Neutral"] = true;
	AL["Friendly"] = "Freundlich";
	AL["Honored"] = "Wohlwollend";
	AL["Revered"] = "Respektvoll";
	AL["Exalted"] = "Ehrfürchtig";
	AL["Best Friend"] = "Bester Freund";
	AL["Rank %d"] = "Rang %d";
	AL["Winterfin Retreat"] = "Zuflucht der Winterflossen";

	-- Recipe origin strings
	AL["Crafted"] = "Hergestellt";
	AL["Discovery"] = "Entdeckung";
	-- AL["Drop"] = true;
	AL["Fished From"] = "Geangelt aus";
	AL["Trainer"] = "Lehrer";
	AL["Vendor"] = "Händler";
	AL["World Drop"] = "Weltdrop";

	-- Specs
	AL["Tanking"] = "Schutz";
	AL["DPS"] = "Schaden";

	-- NPCs missing from BabbleBoss
	-- AL["Trash Mobs"] = true;
	--- Classic WoW
	AL["Dungeon Set 2 Summonable"] = "Beschworener Boss (DS2)";
	-- AL["Theldren"] = true;
	AL["Sothos and Jarien"] = "Sothos und Jarien";
	AL["Druid of the Fang"] = "Druiden des Giftzahns";
	AL["Defias Strip Miner"] = "Akkordminenarbeiter der Defias";
	AL["Defias Overseer/Taskmaster"] = "Vorarbeiter/Zuchtmeister der Defias";
	AL["Scarlet Trainee"] = "Scharlachroter Lehrling";
	AL["Shadowforge Flame Keeper"] = "Flammenbewahrer der Schattenschmiede";
	AL["Crimson Sorcerer"] = "Purpurroter Zauberhexer";
	AL["Thuzadin Shadowcaster"] = "Thuzadinschattenzauberer";
	AL["Crimson Inquisitor"] = "Purpurroter Inquisitor";
	AL["Crimson Battle Mage"] = "Purpurroter Kampfmagier";
	AL["Ghoul Ravener"] = "Tobsüchtiger Ghul";
	AL["Spectral Citizen"] = "Spektraler Bürger";
	AL["Scholomance Adept"] = "Adept aus Scholomance";
	AL["Scholomance Dark Summoner"] = "Dunkler Beschwörer aus Scholomance";
	AL["Blackhand Elite"] = "Elitesoldat der Schwarzfaustlegion";
	AL["Firebrand Pyromancer"] = "Pyromant der Feuerbrand";
	AL["Firebrand Invoker"] = "Herbeirufer der Feuerbrand";
	AL["Firebrand Grunt"] = "Grunzer der Feuerbrand";
	AL["Firebrand Legionnaire"] = "Legionär der Feuerbrand";
	AL["Spirestone Warlord"] = "Kriegsherr der Felsspitzoger";
	AL["Spirestone Mystic"] = "Mystiker der Felsspitzoger";
	AL["Anvilrage Captain"] = "Hauptmann der Zorneshämmer";
	AL["Anvilrage Marshal"] = "Marschall der Zorneshämmer";
	AL["Doomforge Arcanasmith"] = "Schicksalsträchtiger Arkanaschmied";
	AL["Weapon Technician"] = "Waffentechniker";
	AL["Doomforge Craftsman"] = "Schicksalsträchtiger Handwerker";
	AL["Murk Worm"] = "Düsterwurm";
	AL["Scarshield Quartermaster"] = "Rüstmeister der Schmetterschilde";
	AL["Knot Thimblejack"] = "Knot Zwingschraub";
	AL["Shen'dralar Provisioner"] = "Versorger der Shen'dralar";
	AL["The Nameles Prophet"] = "The Nameles Prophet";
	AL["Rajaxx's Captains"] = "Rajaxx's Captains";
	AL["Razorfen Spearhide"] = "Speerträger der Klingenhauer";
	AL["Felsteed"] = "Teufelsross";
	AL["Master Elemental Shaper Krixix"] = "Meisterelementarformer Krixix";
	AL["Rotted One"] = "Verfaulter";
	AL["Tex Vortacoil"] = "Tex Vortaspul";
	AL["Sprinkle Noggenfogger"] = "Sprinkel Noggenfogger";
	--- Burning Crusade
	AL["Avatar of the Martyred"] = "Avatar des Gemarterten";
	AL["Nexus Stalker"] = "Nexuswandler";
	AL["Auchenai Monk"] = "Mönch der Auchenai";
	AL["Cabal Fanatic"] = "Fanatiker der Kabale";
	AL["Unchained Doombringer"] = "Entfesselter Verdammnisbringer";
	AL["Aether-tech Assistant"] = "Äthertechnikerassistent";
	AL["Aether-tech Adept"] = "Äthertechnikeradept";
	AL["Aether-tech Master"] = "Meisteräthertechniker";
	AL["Thomas Yance"] = "Thomas Yance";
	AL["Raging Skeleton"] = "Tobendes Skelett";
	AL["Ethereal Priest"] = "Astraler Priester";
	AL["Sethekk Ravenguard"] = "Rabenwächter der Sethekk";
	AL["Time-Lost Shadowmage"] = "Zeitverlorener Schattenmagier";
	AL["Coilfang Sorceress"] = "Zauberhexerin des Echsenkessels";
	AL["Coilfang Oracle"] = "Orakel des Echsenkessels";
	AL["Shattered Hand Centurion"] = "Zenturio der Zerschmetterten Hand";
	AL["Eredar Deathbringer"] = "Todesbringer der Eredar";
	AL["Arcatraz Sentinel"] = "Schildwache der Arkatraz";
	AL["Gargantuan Abyssal"] = "Riesengroßer Abyss";
	AL["Sunseeker Botanist"] = "Botaniker der Sonnensucher";
	AL["Sunseeker Astromage"] = "Astromagier der Sonnensucher";
	AL["Durnholde Rifleman"] = "Scharfschütze von Durnholde";
	AL["Rift Keeper/Rift Lord"] = "Bewahrerin/Fürst der Zeitenrisse";
	-- AL["Don Carlos"] = true;
	AL["Aged Dalaran Wizard"] = "Gealterter Hexer von Dalaran";
	AL["Shattered Hand Executioner"] = "Henker der Zerschmetterten Hand";
	AL["Servant's Quarter Animal Bosses"] = "Bosse im Quartier der Diener";
	AL["Wyrmcult Provisioner"] = "Versorger des Wyrmkults";
	--- Wrath of the Lich King
	AL["Olut Alegut"] = "Olut Bierbauch";
	AL["Rork Sharpchin"] = "Rork Spitzkinn";
	--- Cataclysm
	-- AL["Zen'Vorka"] = true;
	AL["Ayla Shadowstorm"] = "Ayla Schattensturm";
	AL["Damek Bloombeard"] = "Damek Blühbart";
	AL["Varlan Highbough"] = "Varlan Hochblatt";
	AL["Firestone Vendor"] = "Händler für Feuersteine";
	AL["Baradin Fox"] = "Baradinfuchs";
	--- Mists of Pandaria
	AL["Uncle Bigpocket"] = "Onkel Dickehose";
	AL["Auntie Stormstout"] = "Tantchen Sturmbräu";
	-- AL["Luo Luo"] = true;
	-- AL["Meng Meng"] = true;
	AL["Moonfang"] = "Mondfang";
	AL["Ongrom Black Tooth"] = "Ongrom Schwarzzahn";
	AL["Proveditor Grantley"] = "Administrator Grantley";
	AL["Scary Sprite"] = "Schauriger Geist";
	--- World Events
	AL["Crimson Templar"] = "Purpurroter Templer";
	AL["Azure Templar"] = "Azurblauer Templer";
	AL["Hoary Templar"] = "Weißgrauer Templer";
	AL["Earthen Templar"] = "Irdener Templer";
	AL["The Duke of Cynders"] = "Der Fürst der Asche";
	AL["The Duke of Fathoms"] = "Der Fürst der Tiefen";
	AL["The Duke of Zephyrs"] = "Der Fürst der Stürme";
	AL["The Duke of Shards"] = "Der Fürst der Splitter";
	AL["Templars"] = "Templer";
	AL["Dukes"] = "Fürsten";
	-- AL["High Council"] = true;
	AL["Smokywood Pastures Vendor"] = "Kokelwälder Händler";
	AL["Bash'ir Landing Stasis Chambers"] = "Stasiskammer des Landeplatz von Bash'ir";
	AL["Battle Pet Trainer"] = "Kampfhaustiertrainer";

	-- Zone related strings
	-- AL["Azeroth"] = true;
	AL["Blackrock Mountain"] = "Der Schwarzfels";
	AL["Caverns of Time"] = "Höhlen der Zeit";
	AL["Crusader's Square"] = "Kreuzzüglerpass";
	AL["Darkmoon Island"] = "Dunkelmondinsel";
	AL["East"] = "Ost";
	AL["Halfhill Farm"] = "Halbhügel Farm";
	AL["North"] = "Nord";
	AL["The Gauntlet"] = "Der Spießrutenlauf";
	AL["Trial of the Grand Crusader"] = "Prüfung des Obersten Kreuzfahrers";
	AL["West"] = "West";

	-- Shortcuts for Bossname files
	-- AL["Avatar"] = true; -- Avatar of the Martyred

	-- Chests, etc
	AL["Father Flame"] = "Vater Flamme";
	AL["The Grim Guzzler"] = "Zum Grimmigen Säufer";
	AL["The Secret Safe"] = "Geheimsafe";
	AL["The Vault"] = "Der Tresor";
	AL["Ogre Tannin Basket"] = "Gerbekorb der Oger";
	AL["Unfinished Painting"] = "Unvollendetes Gemälde";
	AL["Felvine Shard"] = "Teufelsrankensplitter";
	AL["Gift of Adoration"] = "Geschenke der Verehrung";
	AL["Treat Bag"] = "Schlotterbeutel";
	AL["The Cache of Madness"] = "Der Hort des Wahnsinns";
	-- AL["Timed Reward Chest"] = true;
	-- AL["Timed Reward Chest 1"] = true;
	-- AL["Timed Reward Chest 2"] = true;
	-- AL["Timed Reward Chest 3"] = true;
	AL["The Talon King's Coffer"] = "Der Kasten des Klauenkönigs";
	AL["Krom Stoutarm's Chest"] = "Krom Starkarms Truhe";
	AL["Garrett Family Chest"] = "Familientruhe der Garretts";
	AL["Reinforced Fel Iron Chest"] = "Verstärkte Teufelseisentruhe";
	AL["DM North Tribute Chest"] = "DM Nord Tributtruhe";
	AL["The Saga of Terokk"] = "Die Sage von Terokk";
	AL["First Fragment Guardian"] = "Wächter des ersten Teils";
	AL["Second Fragment Guardian"] = "Wächter des zweiten Teils";
	AL["Third Fragment Guardian"] = "Wächter des dritten Teils";
	AL["Overcharged Manacell"] = "Überladene Manazelle";
	AL["Shellfish Trap"] = "Schalentierfalle";
	AL["Fishing Pools"] = "Fischschwärme";
	AL["Timeless Chest"] = "Zeitlose Truhe";

	-- Blizzard Promotions
	AL["Annual Pass"] = "Jahrespass";
	AL["Scroll of Resurrection"] = "Rolle der Auferstehung";
	AL["Recruit-A-Friend"] = "Werbt einen Freund";

	-- Error Messages and warnings
	AL["AtlasLoot Error!"] = "AtlasLoot Fehler!";
	AL["WishList Full!"] = "Wunschzettel voll!";
	AL["No match found for"] = "Keine Übereinstimmung gefunden für";
	AL[" is safe."] = " ist sicher.";
	AL["Server queried for "] = "Frage Server nach ";
	AL[".  Right click on any other item to refresh the loot page."] = ".  Rechtsklicken Sie ein anderes Item um die Seite zu aktualisieren.";

	-- Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = " nicht im Loot-Tabellen Register gelistet, bitte melde diese Nachricht im AtlasLoot Forum unter http://www.atlasloot.net";

	-- LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = " ist nicht verfügbar, das folgende Modul wird benötigt: ";

	-- LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = "Status von folgendem Modul konnte nicht festgestellt werden: ";

	-- LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = " konnte nicht erreicht werden, das folgende Modul könnte veraltet sein: ";

	-- LoD module not defined
	AL["Loot module returned as nil!"] = "Lootmodul nicht definiert!";

	-- LoD module loaded successfully
	AL["sucessfully loaded."] = "erfogreich geladen.";

	-- Need a big dataset for searching
	AL["Loading available tables for searching"] = "Lade verfügbare Module zum Suchen";

	-- All Available modules loaded
	AL["All Available Modules Loaded"] = "Alle verfügbaren Module geladen";

	-- First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = "Willkommen zu Atlasloot Enhanced!  Bitte nimm Dir einen Moment Zeit, um die Einstellungen festzulegen";
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = "Willkommen zu Atlasloot Enhanced!  Bitte nimm dir einen Moment Zeit, um die Einstellungen für Tooltips und Chatlinks festzulegen.\nWenn du später etwas ändern willst, kannst du den Optionsbildschirm mit /atlasloot aufrufen.";
	AL["Setup"] = "Optionen";

	-- Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "Atlasloot hat festgestellt, dass die Version von Atlas, die du benutzt, nicht der Version entspricht für die Atlasloot konzipiert ist(";
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = "). Dadurch können (schwere) Fehler auftreten! Bitte besuch so schnell wie möglich http://www.atlasmod.com und lad dir die neuste Atlas Version runter.";
	-- AL["OK"] = "OK";
	AL["Incompatible Atlas Detected"] = "Nicht kompatibles Atlas gefunden";

	-- Unsafe item tooltip
	AL["Unsafe Item"] = "Unsicheres Item";
	AL["This item is not available on your server or your battlegroup yet."] = "Dieses Item ist auf deinem Server bzw. deinem Realmpool nicht verfügbar";
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = "Mit einem Rechtsklick wird der\nServer nach dem Item abgefragt, dabei\nkönnte die Verbindung unterbrochen werden.";

end