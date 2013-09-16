-- $Id: constants.fr.lua 4224 2013-06-24 09:13:28Z trasher $
--[[
constants.fr.lua --- Traduction frFR par TrAsHeR. Merci à KKram pour les premières traductions & Pettigrow pour ses quelques traductions.
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.

The AL["text"] = true; shortcut can ONLY be used for English (the root translation).

Before adding a new string, check first if it can be acquired from GetItemInfo, GetSpellInfo or GetAchievementCriteriaInfo.
Also check if it should be added instead to one of the Babble libraries we use.
]]





--Create the library instance
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

local AL = AceLocale:NewLocale("AtlasLoot", "frFR", false);

--Register translations
if AL then

	-- #########
	-- UI things
	-- #########
	-- compare frame
	AL["Compare Frame"] = "Frame comparative";
	AL["Show in Compare Frame"] = "Afficher dans la frame comparative";
	AL["Name"] = "Nom";
	AL["ItemLvl"] = "Niveau d'objet";
	--AL["Normal"] = true;
	AL["%d items"] = "%d objets";
	AL["All"] = "Tous";
	--AL["Stats"] = true;
	AL["Show \"Base Stats list\""] = "Afficher les statistiques de bases";
	AL["Show \"Extra Stats list\""] = "Afficher les statistiques avancées";
	AL["Base Stats list"] = "Liste des statistiques de bases";
	AL["Extra Stats list"] = "Liste des statistiques avancées";
	AL["Add Stats list"] = "Ajouter une liste de statistiques";
	AL["Are you sure you want to delete Sort list |cff1eff00%s|r?"] = "Êtes-vous sûr de vouloir supprimer la liste |cff1eff00%s|r ?";
	AL["Delete Stats list"] = "Supprimer la liste de statistiques";
	AL["Stats color"] = "Couleur des statistiques";
	AL["Stats list name:"] = "Nom de la liste de statistiques :";
	AL["Select Stats list"] = "Sélectionnez la liste de statistiques";
	AL["You cant set more then %d item stats."] = "Vous ne pouvez pas définir plus de %d statistiques différentes.";
	--AL["Slot"] = true;
	AL["AtlasLoot has detected some corrupted items on your Wishlist. You can now run an automatic check to fix it. Please be aware that this could take a few moments."] = "AtlasLoot a détecté certains objets corrompus dans votre liste de souhaits. Vous pouvez lancer une vérification automatique pour tenter de réparer. Cela pourrait prendre un petit moment.";
	AL["BonusRoll:"] = "Bonus du jet de dés :";
	AL["|cffFF0000Shift+Click: |cffFFFFFFOpen filter configuration"] = "|cffFF0000Maj+Clic : |cffFFFFFFOuvrez la configuration du filtre";

	-- Stats short
	--AL["iLvl"] = true;	-- Item lvl
	AL["str"] = "résist";	-- Strength
	--AL["agi"] = true;	-- Agility
	AL["sta"] = "endu";	-- Stamina
	AL["int"] = "intel";	-- Intellect
	AL["spi"] = "esp";	-- Spirit
	--AL["Crit"] = true;	-- Crit Rating
	AL["Dodge"] = "Esquive";	-- Dodge Rating
	--AL["Exp"] = true;	-- Expertise Rating
	AL["Hit"] = "Toucher";	-- Hit Rating
	AL["Haste"] = "Hâte";	-- Haste Rating
	AL["Parry"] = "Parade";	-- Parry Rating
	AL["Spell"] = "Sort";	-- Spell Power
	AL["Resi"] = "Rési";	-- Resilience Rating
	AL["Mast"] = "Maîtrise";	-- Mastery

	-- Stats
	AL["Resilience Rating"] = "Score de résilience";
	AL["Base Stats"] = "Statistiques de bases";
	AL["Extra Stats"] = "Statistiques avancées";

	-- Loader
	AL["Load AtlasLoot"] = "Charger AtlasLoot";
	AL["Module \"%s\" is disabled."] = "Le module \"%s\" est désactivé.";
	AL["Module \"%s\" is missing."] = "Le module \"%s\" est manquant.";

	-- MiniMap-Button
	AL["|cffFF0000Click: |cffFFFFFFOpen AtlasLoot\n|cffFF0000Shift+Click: |cffFFFFFFOpen AtlasLoot-Options "] = "|cffFF0000Clic : |cffFFFFFFOuvrir AtlasLoot\n|cffFF0000Maj+Clic : |cffFFFFFFOuvrir les options d'AtlasLoot";

	-- AtlasLootFu 
	AL["AtlasLootFu is no longer in use.\nDelete it from your AddOns folder"] = "AtlasLootFu n'est plus utilisé.\nVeuillez le supprimer de votre dossier AddOns.";

	-- Options
	--AL["Options"] = true;
	AL["Load Loot Modules at Startup"] = "Charger les modules de loot au démarrage";
	AL["Toggle Minimap Button"] = "Afficher / masquer le bouton de la mini-carte";
	AL["Toggles the display of the minimap icon"] = "Permet d'afficher ou non le bouton sur la mini-carte";
	AL["Show itemIDs"] = "Afficher les IDs des objets";
	AL["Show Droprates"] = "Afficher les pourcentages de drop";
	AL["Safe Chat Links"] = "Liens valides, sur le canal";
	AL["Comparison Tooltips"] = "Infobulles comparatives";
	AL["Show Boss Tooltip"] = "Afficher les infosbulles des boss";
	AL["Show Comparison Tooltips"] = "Afficher les infobulles comparatives";
	--AL["Opaque"] = true;
	AL["Make Loot Table Opaque"] = "Fond de liste opaque";
	AL["Treat Crafted Items:"] = "Traiter les objets fabriqués :";
	AL["As Crafting Spells"] = "comme des sorts";
	AL["As Items"] = "comme des objets";
	AL["Reset"] = "Réinitialiser";
	AL["Reset Frames"] = "Réinitialiser les frames";
	--AL["Profiles"] = true;
	--AL["Item Buttons"] = true; -- à traduire
	AL["Loot Table"] = "Table de loot";
	AL["Enable mouse on item descriptions"] = "Activer la souris sur la description de l'objet";
	AL["Upgrade Level:"] = "Niveau d'amélioration :";
	AL["Show BonusRoll info"] = "Afficher le bonus du jet de dés";
	AL["Shows if a item is available with bonus roll or raid finder loot."] = "Indique si un objet est dispobile via le bonus du jet de dés ou via l'outil Raids.";

	-- Default Frame
	AL["Default Frame"] = "Frame par défaut";
	AL["Scale:"] = "Échelle :";
	AL["Alpha:"] = "Transparence :";
	AL["Only change alpha on leave frame"] = "Changer la transparence uniquement si on quitte une frame";

	-- Bindings
	AL["Toggle AtlasLoot"] = "Afficher / Masquer AtlasLoot";

	-- Help
	AL["Help"] = "Aide";
	AL["AtlasLoot Help"] = "Aide AtlasLoot";
	AL["For further help, see our website and forums: "] = "Pour de l'aide complémentaire, visitez notre site web et nos forums : ";
	AL["How to open the standalone Loot Browser:"] = "Comment ouvrir le navigateur de butin indépendamment :";
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = "Si AtlasLootFu est présent et installé, cliquez sur le bouton de la mini-carte ou alors sur le bouton généré par des addons tels que Titan ou Fubar. Vous pouvez également taper la commande '/al' dans la saisie de la fenêtre de discussion.";
	AL["How to view an 'unsafe' item:"] = "Comment voir un objet 'invalide' :";
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = "Les objets invalides ont une bordure rouge autour d'une icône d'un point d'interrogation car vous n'avez pas vu l'objet depuis le dernier patch ou le dernier redémarrage du serveur. Faites un Clic-Droit sur l'objet, puis survolez à nouveau l'objet avec votre souris, ou cliquez sur le bouton 'Requête serveur' en bas de la page du butin.";
	AL["How to view an item in the Dressing Room:"] = "Comment voir un objet dans la cabine d'essayage :";
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = "Faites simplement la combinaison Ctrl-Clic gauche sur l'objet. Il se peut parfois que la fenêtre de la cabine d'essayage se retrouve cachée derrière la fenêtre d'Atlas ou d'AtlasLoot : si jamais rien ne semble se produire, déplacez la fenêtre d'Atlas et/ou d'AtlasLoot au cas où quelque chose soit caché derrière.";
	AL["How to link an item to someone else:"] = "Comment faire le lien d'un objet pour le montrer à quelqu'un d'autre :";
	AL["Shift+Left Click the item like you would for any other in-game item"] = "Faites la combinaison Maj+Clic-Gauche sur l'objet, exactement comme tous les autres objets du jeu.";
	AL["How to add an item to the wishlist:"] = "Comment ajouter un objet à ma liste de souhaits :";
	AL["Alt+Left Click any item to add it to the wishlist."] = "Faites la combinaison Alt+Clic-Gauche sur l'objet en question pour l'ajouter à votre liste de souhaits.";
	AL["How to delete an item from the wishlist:"] = "Comment supprimer un objet de ma liste de souhaits :";
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = "Une fois sur l'écran de votre liste de souhaits, faites simplement la combinaison Alt+Clic-Gauche sur l'objet à supprimer.";
	AL["What else does the wishlist do?"] = "Qu'est-ce que la liste de souhaits peut faire de plus ?";
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = "Si vous faites un clic gauche sur un objet de la liste de souhaits, vous serez directement conduit sur la page du butin qui correspond. De plus, tout objet se trouvant dans votre liste sera marqué par une étoile jaune sur les pages du butin.";
	AL["HELP!! I have broken the mod somehow!"] = "AU SECOURS ! Le mod ne fonctionne plus !";
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = "Utilisez les boutons réinitialiser présents sur le menu des options, ou tapez '/al reset' dans la saisie de votre fenêtre de discussion.";

	-- LootButtons
	-- Tooltips
	AL["ItemID:"] = "ObjetID :";
	AL["Drop Rate: "] = "Chance de tomber : ";
	--AL["DKP"] = true;
	AL["Priority:"] = "Priorité :";
	AL["Show price and slot if possible"] = "Afficher le prix et le slot, si possible";
	AL["Show wishlist items in bosses tooltip"] = "Afficher les objets de la liste de souhaits dans les infosbulles des boss";
	AL["Use GameTooltip"] = "Utiliser l'infobulle du jeu";
	AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"] = "Utiliser l'infobulle standard du jeu au lieu de celle personnalisée d'AtlasLoot";
	AL["%d / %d ( Bank: %d )"] = "%d / %d ( Banque : %d)";
	-- Unsafe Item
	AL["Item Unavailable"] = "Objet indisponible";
	AL["|cff0070ddItemID: %d |r\nThis item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world.\n\nYou can right-click to attempt to query the server.  You may be disconnected."] = "|cff0070ddID de l'objet : %d |r\nCet objet n'est pas valide. Pour regarder cet objet sans risque de déconnection, vous devez déjà l'avoir vu au moins une fois dans le jeu.\n\nVous pouvez faire un Clic-Droit pour tenter d'interroger le serveur.  Vous pouvez être déconnecté.";
	-- Heriloom Config Window
	AL["Heirloom preview"] = "Aperçu des objets d'héritage";
	AL["Change level:"] = "Changer le niveau :";
	AL["Shift + Right Click to select character level"] = "Maj+Clic-Droit pour sélectionnez le niveau d'un personnage";	

	-- LootTableSort
	AL["Sort by Instance"] = "Trier par instance";
	AL["Sort loottable by Instance"] = "Trier la table de loot par instance";
	AL["Sort by Boss"] = "Trier par boss";
	AL["Sort loottable by Boss"] = "Trier la table de loot par boss";
	AL["Item Name"] = "Nom de l'objet";
	AL["Item Slot"] = "Slot de l'objet";
	AL["Item Quality"] = "Qualité de l'objet";

	-- Wishlist
	AL["Wishlist"] = "Liste de souhaits";
	AL["Wishlists"] = "Listes de souhaits";
	AL["Own"] = "Les miennes";
	AL["Other"] = "Autre";
	AL["Shared"] = "Partagée";
	AL["Wishlist name:"] = "Nom de la liste de souhaits :";
	AL["Delete"] = "Supprimer";
	AL["Share"] = "Partager";
	AL["Send Wishlist (%s) to"] = "Envoyer la liste de souhaits (%s) à";
	AL["Send"] = "Evnoyer";
	AL[" added to the WishList."] = " ajouté à la liste de souhaits";
	AL[" already in the WishList!"] = " est déjà dans la liste de souhaits !";
	AL[" deleted from the WishList."] = " à été supprimer de la liste de souhaits";
	AL["Are you sure you want to delete Wishlist |cff1eff00%s|r?"] = "Êtes-vous sûr de vouloir supprimer la liste de souhaits |cff1eff00%s|r?";
	AL["default"] = "par défaut";
	AL[" |cff999999<default>"] = " |cff999999<par défaut>";
	AL["Use as default wishlist"] = "Utiliser cette liste de souhaits par défaut";
	AL["Add Wishlist"] = "Ajouter une liste de souhaits";
	AL["Always use default Wishlist"] = "Toujours utiliser cette liste de souhaits par défaut";
	AL["Save wishlists at character DB"] = "Sauvegarder la liste de souhaits pour le personnage actuel";
	AL["Saves the wishlists only for |cff1eff00%s-%s|r.\n Other characters cant view the wishlists, but the memory usage is reduced."] = "Sauvegarder la liste de souhaits seulement pour |cff1eff00%s-%s|r.\n Les autres personnages ne peuvent pas voir la liste de souhaits, mais la charge de mémoire est réduite.";
	AL["Table Sort"] = "Tri des tables";
	AL["Table Sort:"] = "Tri des tables :";
	AL["Item Sort:"] = "Tri des objets :";
	AL["Show own wishlists"] = "Afficher mes listes de souhaits";
	AL["Show all wishlists"] = "Afficher toutes les listes de souhaits";

	-- Filter
	AL["Filter"] = "Filtre";
	AL["Select All Loot"] = "Sélectionner tous les filtres";
	AL["Apply Filter:"]= "Appliquer le filtre :";
	AL["Melee weapons"] = "Armes de mêlée";
	AL["Ranged weapons"] = "Armes à distance";
	AL["Other"] = "Autre";
	AL["Itemslot"] = "Slot de l'objet";
	AL["Shift + Click on the Filter button opens the config page."] = "Maj+Clic sur le bouton filtre ouvre la page de configuration.";

	-- Panel
	AL["Hide Panel"] = "Masquer le panneau";
	AL["Toggle AL Panel"] = "Afficher / Masquer le panneau d'AtlasLoot";
	AL["Buttons"] = "Boutons";

	-- Buttons
	--AL["Collections"] = true;
	AL["Crafting"] = "Artisanat";
	--AL["Factions"] = true;
	AL["Load Modules"] = "Charger les modules";
	AL["PvP Rewards"] = "Récompenses JcJ";
	--AL["World Events"] = true;

	-- QuickLooks
	--AL["QuickLook"] = true;
	--AL["QuickLooks"] = true;
	AL["Number of QuickLooks:"] = "Nombre de QuickLook :";
	AL["Add to QuickLooks:"] = "Ajouter à QuickLook :";
	AL["Reset Quicklooks"] = "Réinitialiser QuickLook";
	AL["Assign this loot table\n to QuickLook"] = "Assigner cette table de loot\n à QuickLook";
	AL["Show unused QuickLooks in the Panel"] = "Afficher les QuickLooks inutilisé sur le panneau";
	AL["Shows unused QuickLooks as grey buttons in the AtlasLoot Panel"] = "Afficher les QuiLooks inutilisés sous forme de bouton gris sur le panneau d'AtlasLoot";
	-- Single options
	AL["unused"] = "inutilisé";
	AL["QuickLook name:"] = "Nom du QuickLook :";
	AL["Use Boss name"] = "Utiliser le nom du boss";
	AL["Use Instance name"] = "Utiliser le nom de l'instance";
	AL["Delete"] = "Supprimer";
	AL["Lock"] = "Bloquer";
	AL["Enable"] = "Activer";

	-- Query Server / Query all
	AL["Query Server"] = "Interroger le serveur";
	AL["Queries the server for all items \non this page. The items will be \nrefreshed when you next mouse \nover them."] = "Interroger le serveur pour tous les objets \nse trouvant sur cette page. Ils seront rafraichis \nquand vous passerez votre souris dessus.";

	-- Atlas
	AL["Click boss name to view loot."] = "Cliquer sur le nom du boss pour afficher ses loots";

	-- LootTable
	-- title
	AL["Heroic"] = "Héroïque";
	AL["25 Man"] = "25 joueurs";
	AL["25 Man Heroic"] = "25 joueurs héroïque";
	-- buttons
	AL["Show 10 Man Loot"] = "Afficher les loots Raid 10";
	AL["Show 25 Man Loot"] = "Afficher les loots Raid 25";
	AL["Show Slot"] = "Afficher le slot";
	AL["Show Price"] = "Afficher le prix";
	AL["Skill"] = "Talent";
	AL["Location"] = "Lieu";

	-- #######################################
	-- UI things END
	-- #######################################

	-- Text strings for UI objects
	--AL["AtlasLoot"] = true,
	AL["Select Loot Table"] = "Choisir une liste";
	AL["Select Sub-Table"] = "Choisir une sous-liste";
	AL["Various Locations"] = "Endroits divers";
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "Ceci est un navigateur de loot. Pour afficher les cartes, veuillez installer Atlas ou Alphamap.";
	AL["Back"] = "Retour";
	AL["Level 60"] = "Niveau 60";
	AL["Level 70"] = "Niveau 70";
	AL["Level 80"] = "Niveau 80";
	AL["Level 85"] = "Niveau 85";
	AL["Level 90"] = "Niveau 90";
	AL["|cffff0000(unsafe)"] = "|cffff0000(invalide)";
	AL["Misc"] = "Divers";
	AL["Rewards"] = "Récompenses";
	AL["Choose Table ..."] = "Choisir une liste...";
	AL["Unknown"] = "Inconnu";
	AL["Reset Wishlist"] = "Réinitialiser la liste de souhaits";
	AL["Select a Loot Table..."] = "Sélectionner une table de loot...";
	AL["OR"] = "OU";
	AL["FuBar Options"] = "Options de FuBar";
	AL["Attach to Minimap"] = "Joindre à la mini-carte";
	AL["Hide FuBar Plugin"] = "Masquer le plugin FuBar";
	AL["Show FuBar Plugin"] = "Afficher le plugin FuBar";
	AL["Position:"] = "Position :";
	AL["Left"] = "Gauche";
	AL["Center"] = "Centre";
	AL["Right"] = "Droite";
	AL["Hide Text"] = "Masquer le texte";
	AL["Hide Icon"] = "Masquer l'icône";
	AL["Minimap Button Options"] = "Options du bouton de la mini-carte";

	-- Text for Options Panel
	AL["Atlasloot Options"] = "Options d'AtlasLoot";
	AL["Default Tooltips"] = "Infobulles par défault";
	AL["Lootlink Tooltips"] = "Infobulles de Lootlink";
	AL["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dInfobulles de Lootlink";
	AL["ItemSync Tooltips"] = "Infobulles d'ItemSync";
	AL["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dInfobulles d'ItemSync";
	AL["Use EquipCompare"] = "Utiliser EquipCompare";
	AL["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9dUtiliser EquipCompare";
	AL["Show itemIDs at all times"] = "Toujours afficher l'ID d'un objet";
	AL["Hide AtlasLoot Panel"] = "Masquer le panneau d'AtlasLoot";
	AL["Show Basic Minimap Button"] = "Afficher le bouton sur la mini-carte";
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = "|cff9d9d9dAfficher le bouton sur la mini-carte|r";
	AL["Set Minimap Button Position"] = "Position du bouton sur la mini-carte";
	AL["Notify on LoD Module Load"] = "M'informer quand un module est chargé";
	AL["Loot Browser Scale: "] = "Échelle du navigateur de loot : ";
	AL["Button Position: "] = "Position du bouton :";
	AL["Button Radius: "] = "Rayon du bouton";
	AL["Done"] = "Fait";
	AL["FuBar Toggle"] = "Activer ou non FuBar";
	AL["Search Result: %s"] = "Résultat(s) de la recherche : %s";
	AL["Search on"] = "Recherche activée";
	AL["All modules"] = "Tous les modules";
	AL["If checked, AtlasLoot will load and search across all the modules."] = "Si coché, AtlasLoot chargera et recherchera dans tous les modules.";
	AL["Search options"] = "Options de la recherche";
	AL["Partial matching"] = "Correspondance partielle";
	AL["If checked, AtlasLoot search item names for a partial match."] = "Si coché, AtlasLoot recherche le nom d'un objet avec une correspondance partielle.";
	AL["You don't have any module selected to search on!"] = "Vous n'avez pas sélectionné de module pour la recherche !";
	AL["Panel"] = "Panneau";

	-- Slash commands
	AL["reset"] = "Réinitialiser";
	--AL["options"] = true,
	AL["Reset complete!"] = "Réinitialisation effectuée !";

	-- AtlasLoot Panel - Search
	AL["Clear"] = "Effacer";
	AL["Last Result"] = "Dernier(s) résultat(s)";
	AL["Search"] = "Recherche";

	-- Crafting Menu
	AL["Crafting Daily Quests"] = "Artisanat des quêtes journalières";
	AL["Cooking Daily"] = "Recs. journa. de cuisine";
	AL["Fishing Daily"] = "Recs. journa. de pêche";
	AL["Jewelcrafting Daily"] = "Recs. journa. de joaillerie";
	AL["Crafted Sets"] = "Sets d'artisanat";
	AL["Crafted Epic Weapons"] = "Armes d'artisanat épiques";
	AL["Dragon's Eye"] = "Oeil de dragon";
	AL["Chimera's Eye"] = "Oeil de chimère";
	AL["Serpent's Eye"] = "Oeil de serpent";

	-- Sets/Collections Menu
	--AL["Sets"] = true;
	--AL["Set"] = true;
	AL["Justice Points"] = "Point de justice";
	AL["Valor Points"] = "Point de vaillance";
	AL["BoE World Epics"] = "LqÉ Épiques mondial";
	AL["Legendary Items"] = "Objets légendaires";
	AL["Misc Sets"] = "Sets divers";
	AL["Tier Sets"] = "Sets de palier";
	--AL["Tier 1/2 Set"] = true;
	--AL["Tier 1/2/3 Set"] = true;
	--AL["Tier 3 Set"] = true;
	--AL["Tier 4/5/6 Set"] = true;
	--AL["Tier 7/8 Set"] = true;
	--AL["Tier 9 Set"] = true;
	--AL["Tier 10 Set"] = true;
	--AL["Tier 11/12 Set"] = true;
	--AL["Tier 13 Set"] = true;
	--AL["Tier 14 Set"] = true;
	--AL["Tier 15 Set"] = true;
	--AL["Tier 16 Set"] = true;
	AL["TCG Items"] = "Objets des cartes à jouer"; -- Trading Card Game Items
	AL["Rare Mobs"] = "Monstres rares";
	AL["Grand Marshal"] = "Connétable";
	AL["Gladiator"] = "Gladiateur";
	AL["Vengeful"] = "Vengeur";
	AL["Merciless"] = "Impitoyable";
	AL["Brutal"] = "Brutale";
	AL["Wrathful"] = "Courroucé";
	AL["Cataclysmic"] = "Cataclysmique";
	--AL["ilvl %d"] = true; -- usage: string.format(AL["ilvl %d"], 522)

	-- PvP Menu
	AL["Arathi Basin Sets"] = "Sets du Bassin d'Arathi";
	AL["PvP Accessories"] = "Accessoires JcJ";
	AL["PvP Armor Sets"] = "Sets d'armures JcJ";
	AL["PvP Weapons"] = "Armes JcJ";
	AL["PvP Non-Set Epics"] = "Hors sets épiques JcJ";
	AL["PvP Reputation Sets"] = "Sets réputation JcJ";
	AL["PvP Misc"] = "Objets divers JcJ";
	AL["PVP Gems/Enchants/Jewelcrafting Designs"] = "Gemmes / Enchantements / Dessins de Joaillerie JcJ";
	AL["PvP Trinkets"] = "Bijoux JcJ";

	-- World Events
	AL["Abyssal Council"] = "Conseil abyssal";
	AL["Argent Tournament"] = "Tournoi d'Argent";
	AL["Bash'ir Landing Skyguard Raid"] = "Point d'ancrage de Bash'ir";
	AL["Brewfest"] = "La fête des Brasseurs";
	AL["Children's Week"] = "La Semaine des enfants";
	AL["Day of the Dead"] = "Jour des morts";
	AL["Ethereum Prison"] = "Prison de l'Ethereum";
	AL["Feast of Winter Veil"] = "La fête du Voile d'hiver";
	AL["Gurubashi Arena Booty Run"] = "Le coffre pirate de Gurubashi";
	AL["Hallow's End"] = "La Sanssaint";
	AL["Harvest Festival"] = "La Fête des moissons";
	AL["Love is in the Air"] = "De l'amour dans l'air";
	AL["Lunar Festival"] = "La fête lunaire";
	AL["Midsummer Fire Festival"] = "Solstice d'été : la fête du Feu";
	AL["Noblegarden"] = "Le jardin des nobles";
	AL["Pilgrim's Bounty"] = "Bienfaits du pèlerin";
	--AL["Skettis"] = true,
	AL["Stranglethorn Fishing Extravaganza"] = "Concours de pêche de Strangleronce";
	AL["Kalu'ak Fishing Derby"] = "Tournoi de pêche kalu'ak";
	AL["Fishing Contests"] = "Concours de pêche";

	-- World Events	Menu Names
	AL["Special Rewards"] = "Récompenses spéciales"; 				-- Brewfest, Feast of Winter Veil
	AL["Brew of the Month Club"] = "Le club de la Bière du mois";	-- Brewfest
	AL["Food and Drinks"] = "Nourritures et boissons";			-- Brewfest
	AL["Gifts & Presents"] = "Cadeaux";						-- Feast of Winter Veil
	AL["Playable Race Masks"] = "Masques de race jouable";			-- Hallow's End
	AL["Non-Playable Race Masks"] = "Masques de race non-jouable";	-- Hallow's End
	AL["Schematics & Patterns"] = "Schémas et patrons";			-- Lunar Festival
	AL["Toys"] = "Jouets"; 									-- Darkmoon Faire

	-- Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00Clic-Gauche|r Parcourir les tables de butin";
	AL["|cffff0000Right-Click|r View Options"] = "|cffff0000Clic-Droit|r Afficher les options";
	AL["|cffff0000Shift-Click|r View Options"] = "|cffff0000Maj+Clic|r Afficher les options";
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffccccccClic-Gauche + Maintenir|r Déplace le bouton sur la mini-carte";
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = "|cffccccccClic-Droit + Maintenir|r Déplace le bouton sur la mini-carte";

	-- Default Frame
	AL["Select Module"] = "Sélectionner un module";
	AL["Select Instance"] = "Sélectionner une instance";

	-- Wishlist
	AL["Close"] = "Fermer";
	AL["Own Wishlists"] = "Vos propres listes de souhaits";
	AL["Other Wishlists"] = "Autres listes de souhaits";
	AL["Shared Wishlists"] = "Listes de souhaits partagés";
	AL["Mark items in loot tables"] = "Marquer les objets dans les tables de butin";
	AL["Mark items from own Wishlist"] = "Marquer les objets de vos propres listes de souhaits";
	AL["Mark items from all Wishlists"] = "Marquer les objets de toutes les listes de souhaits";
	AL["Enable Wishlist Sharing"] = "Autoriser le partage des listes de souhaits";
	AL["Auto reject in combat"] = "Rejeter auto. en combat";
	AL["Edit Wishlist"] = "Modifier une liste de souhaits"
	AL["Show More Icons"] = "Afficher plus d'icône";
	AL["Edit"] = "Modifier";
	AL["Show all Wishlists"] = "Afficher toutes les listes de souhaits";
	AL["Show own Wishlists"] = "Afficher vos propres listes de souhaits";
	AL["Show shared Wishlists"] = "Afficher les listes de souhaits partagés";
	AL["You must wait "] = "Vous devez attendre";
	AL[" seconds before you can send a new Wishlist to "] = " secondes avant de pouvoir envoyer une nouvelle liste de souhaits à ";
	AL["Cancel"] = "Annuler";
	AL["Delete Wishlist %s?"] = "Supprimer la liste de souhaits %s ?";
	AL["%s sends you a Wishlist. Accept?"] = "%s souhaite vous envoyer une liste de souhaits. Acceptez-vous ?";
	AL[" tried to send you a Wishlist. Rejected because you are in combat."] = "a tenté de vous envoyer une liste de souhaits qui a été rejetée car vous êtes en combat.";
	AL[" rejects your Wishlist."] = " a rejeté votre liste de souhaits.";
	AL["You can't send Wishlists to yourself"] = "Vous ne pouvez pas envoyer de liste de souhaits à vous-même.";
	AL["Please set a default Wishlist."] = "Veuillez définir une liste de souhaits par défaut."
	AL["Set as default Wishlist"] = "Définir en tant que liste de souhaits par défaut";

	-- Misc Inventory related words
	AL["Scope"] = "Lunette de visée";
	AL["Darkmoon Faire Card"] = "Carte de la foire de Sombrelune";
	AL["Banner"] = "Etendard";
	--AL["Set"] = true,
	AL["Token"] = "Insigne";
	AL["Combat Pet"] = "Animal de compagnie de combat";
	AL["Fireworks"] = "Feux d'artifice";
	AL["Transformation Item"] = "Objet de transformation";
	AL["Keys"] = "Clés";

	-- Extra inventory stuff
	AL["Cloak"] = "Cape";

	-- Alchemy
	AL["Battle Elixirs"] = "Elixirs de bataille";
	AL["Cauldron"] = "Chaudron";
	AL["Cauldrons"] = "Chaudrons";
	AL["Guardian Elixirs"] = "Elixirs du Gardien";
	AL["Oils"] = "Huiles";
	AL["Other Elixirs"] = "Autres élixirs";
	--AL["Potions"] = true;
	AL["Transmutes"] = "Transmutations";
	AL["Flasks"] = "Flacons";

	-- Blacksmithing
	AL["Armor Enhancements"] = "Améliorations d'armure";
	AL["Weapon Enhancements"] = "Améliorations d'arme";
	AL["Cataclysm Vendor Sold Plans"] = "Vendeur de plans à Cataclysme"
	AL["Mists of Pandaria Vendor Sold Plans"] = "Vendeur de plans à Mist of Pandoria";
	--AL["Training Projects"] = true; -- à traduire

	-- Cooking
	AL["Banquets/Feasts"] = "Banquets / Festins";

	-- Enchanting
	AL["Enchant Boots"] = "Enchantement Bottes";
	AL["Enchant Bracer"] = "Enchantement Bracelets";
	AL["Enchant Chest"] = "Enchantement Torse";
	AL["Enchant Cloak"] = "Enchantement Cape";
	AL["Enchant Gloves"] = "Enchantement Gants";
	AL["Enchant Ring"] = "Enchantement Anneau";
	AL["Enchant Shield & Off-Hand"] = "Enchantement Bouclier & Main gauche";
	AL["Enchant 2H Weapon"] = "Enchantement Arme à deux mains";
	AL["Enchant Weapon"] = "Enchantement Arme";
	AL["Cataclysm Vendor Sold Formulas"] = "Vendeur de formules à Cataclysme";

	-- Engineering
	AL["Tinker"] = "Objets bricolés";

	-- Fishing
	AL["Fish Weapons"] = "Armes en poisson";
	AL["Fishing Gear"] = "Équipements de pêche";
	AL["Fishing Lines"] = "Ligne de pêche";

	-- Inscription
	AL["Major Glyph"] = "Glyphe majeur";
	AL["Minor Glyph"] = "Glyphe mineur";
	AL["Runescrolls"] = "Parchemins";
	AL["Recall"] = "Rappel";
	AL["Scrolls"] = "Parchemins";
	AL["Off-Hand Items"] = "Objets tenu en main gauche";
	AL["Shoulder Enchants"] = "Enchantements d'épaule";
	AL["Reagents"] = "Réactifs";

	-- Leatherworking
	AL["Leather Armor"] = "Armure en cuir";
	AL["Mail Armor"] = "Armure en maille";
	AL["Cloaks"] = "Capes";
	AL["Item Enhancements"] = "Améliorations d'objet";
	AL["Drums, Bags and Misc."] = "Tambours, sacs et objets divers";

	-- Tailoring
	AL["Shirts"] = "Chemises";
	AL["Bags"] = "Sacs";
	AL["Cataclysm Vendor Sold Patterns"] = "Vendeur de patrons à Cataclysme";
	AL["Mists of Pandaria Vendor Sold Patterns"] = "Vendeur de patrons à Mist of Pandoria";

	-- Labels for loot descriptions
	AL["Classes:"] = "Classes :";
	AL["This Item Begins a Quest"] = "Cet objet permet de lancer une quête.";
	AL["Quest Item"] = "Objet de quête";
	AL["Old Quest Item"] = "Ancien objet de quête";
	AL["Quest Reward"] = "Récompense de quête";
	AL["Old Quest Reward"] = "Ancienne récompense de quête";
	AL["Shared"] = "Partagé";
	AL["Right Half"] = "Moitié droite";
	AL["Left Half"] = "Moitié gauche";
	AL["Currency"] = "Monnaie";
	AL["Used to summon boss"] = "Utilisé pour invoquer un boss";
	AL["Tradable for sunmote + item above"] = "Echangeable contre une Granule de soleil + l'objet du dessus";
	AL["Card Game Item"] = "Objet du jeu de carte";
	AL["Skill Required:"] = "Compétence requise :";
	AL["Rating:"] = "Côte :"; -- Shorthand for 'Required Rating' for the personal/team ratings
	AL["Random Heroic Reward"] = "Récompense héroique aléatoire";
	AL["Fishing Daily Reward"] = "Réc. journa. de pêche";
	AL["Collector's Edition"] = "Edition Collector";
	AL["Daily Reward"] = "Récompense journalière";
	AL["No Longer Available"] = "N'est plus disponible";
	AL["Shared Boss Loot"] = "Objets de boss partagés";
	AL["Shared Zone Loot"] = "Objets de zone partagés";
	AL["Black Market Auction House"] = "Hôtel des ventes au marché noir";

	-- Minor Labels for loot table descriptions
	AL["Classic WoW"] = "WoW classique";
	--AL["Burning Crusade"] = true;
	--AL["Wrath of the Lich King"] = true;
	AL["Cataclysm"] = "Cataclysme";
	--AL["Mists of Pandaria"] = true;
	AL["Entrance"] = "Entrée";
	AL["Dungeon Set 1"] = "Set de donjon 1";
	AL["Dungeon Set 2"] = "Set de donjon 2";
	AL["Dungeon Set 1/2"] = "Set de donion 1/2";
	AL["Replica"] = "Réplique";
	AL["Dungeon Set 3"]  = "Set de donjon 3";
	AL["Dungeon Set 4"] = "Set de donjon 4";
	--AL["Tier %d"] = true; -- usage: string.format(AL["Tier %d"], 1)
	AL["Challenge Mode Armor Sets"] = "Sets d'armure du mode défi";
	AL["10 Man"] = "10 Joueurs";
	AL["10/25 Man"] = "10 / 25 Joueurs";
	AL["Epic Set"] = "Set épique";
	AL["Rare Set"] = "Set rare";
	AL["Season %d"] = "Saison %d"; -- usage: string.format(AL["Season %d"], 6)
	AL["Fire"] = "Feu";
	AL["Water"] = "Eau";
	AL["Wind"] = "Vent";
	AL["Earth"] = "Terre";
	AL["Master Angler"] = "Meilleur pêcheur";
	AL["Fire Resistance Gear"] = "Équipements de Résistance au Feu";
	AL["Arcane Resistance Gear"] = "Équipements de Résistance aux Arcanes";
	AL["Nature Resistance Gear"] = "Équipements de Résistance à la Nature";
	AL["Frost Resistance Gear"] = "Équipements de Résistance au Froid";
	AL["Shadow Resistance Gear"] = "Équipements de Résistance à l'Ombre";

	-- Labels for loot table sections
	AL["Additional Heroic Loot"] = "Loot héroïque additionnel";
	AL["Heroic Mode"] = "Mode héroïque";
	AL["Normal Mode"] = "Mode normal";
	AL["Hard Mode"] = "Mode difficile";
	AL["Bonus Loot"] = "Bonus de loot";
	AL["Arena Reward"] = "Récompense d'arène";
	AL["Achievement Reward"] = "Récompenses des hauts faits";
	--AL["Phase 1"] = true;
	--AL["Phase 2"] = true;
	--AL["Phase 3"] = true;
	AL["First Prize"] = "1er prix";
	AL["Rare Fish Rewards"] = "Récompenses des poissons rares";
	AL["Rare Fish"] = "Poissons rares";
	AL["Weapons"] = "Armes";
	AL["Accessories"] = "Accessoires";
	--AL["Rare"] = true;
	AL["Specializations"] = "Spécialisations";
	--AL["Flexible"] = true;
	AL["Raid Finder"] = "Recherche de raid";
	AL["Thunderforged"] = "Foudroyant";
	AL["Pandaria World Bosses"] = "World Boss de Pandarie";
	--AL["Elite"] = true;
	AL["Vegetables"] = "Légumes";

	-- Loot Table Names
	AL["Level %s"] = "Niveau %s"; -- usage: string.format(AL["Level %s"], "85-89")
	AL["Summon"] = "Invocation";
	AL["Random"] = "Aléatoire";

	-- Profession descriptions
	--AL["Buff"] = true;
	AL["Agility"] = "Agilité";
	AL["Attributes"] = "Attributs";
	AL["Intellect"] = "Intelligence";
	AL["Strength"] = "Force";
	AL["Spirit"] = "Esprit";
	AL["Stamina"] = "Endurance";
	AL["Spell Power"] = "Puissance des sorts";
	AL["Attack Power"] = "Puissance d'attaque";
	AL["Spell/Attack Power"] = "Puissance des sorts / d'attaque";
	AL["Hit Rating"] = "Score de toucher";
	AL["Crit Rating"] = "Score de critique";
	AL["Haste Rating"] = "Score de hâte";
	AL["Dodge Rating"] = "Score d'esquive";
	AL["Expertise Rating"] = "Score d'expertise";
	AL["Mastery Rating"] = "Score de maîtrise";
	AL["Parry Rating"] = "Score de parade";
	AL["Other Ratings"] = "Autres scores";
	AL["Ratings"] = "Scores";
	AL["Damage Absorption"] = "Absorption des dégâts";
	AL["Health / Second"] = "Vie / seconde"
	AL["Mana / Second"] = "Mana / seconde";
	AL["Tracking"] = "Pistage";
	AL["Emotions"] = "Emotion";
	AL["Alcohol"] = "Alcool";
	AL["Health"] = "Vie";
	--AL["Mana"] = true;
	AL["Health and Mana"] = "Vie et mana";
	AL["Other Buffs"] = "Autres buffs";
	AL["Other"] = "Autre";
	AL["Standard Buffs"] = "Buffs standards";
	AL["Food without Buffs"] = "Nourritures sans buff";
	AL["Special"] = "Spécial";
	AL["Feasts"] = "Festins";
	AL["Speed"] = "Vitesse";
	AL["Oil"] = "Huile";-- Used in categorizing Enchating Misc, ex: Superior Wizard Oil, Wizard Oil
	--AL["Culture"] = true;
	--AL["Description"] = true;
	AL["Draenei"] = "Draeneï";
	AL["Dwarf"] = "Nain";
	AL["Fossil"] = "Fossile";
	AL["Mantid"] = "Mantide";
	--AL["Mogu"] = true;
	AL["Nerubian"] = "Nérubien";
	AL["Night Elf"] = "Elfe de la nuit";
	--AL["Orc"] = true;
	--AL["Pandaren"] = true;
	--AL["Tol'vir"] = true;
	--AL["Troll"] = true;
	--AL["Vrykul"] = true;
	--AL["Stats"] = true;
	AL["Resilience"] = "Résilience";
	--AL["Professions"] = true;
	AL["Damage"] = "Dommage";
	--AL["Proc"] = true;

	-- Extra Text in Boss lists
	AL["AQ20 Class Sets"] = "Sets de classe AQ20";
	AL["AQ Enchants"] = "Enchantements AQ";
	AL["AQ40 Class Sets"] = "Sets de classe AQ40";
	AL["AQ Opening Quest Chain"] = "Quêtes d'ouverture d'AQ";
	AL["Tribute Run"] = "Tribut du Roi";
	AL["Dire Maul Books"] = "Livres de Hache Tripes";
	AL["Random Boss Loot"] = "Objets aléatoires des boss";
	AL["Formula/Patterns/Plans"] = "Formules / Patrons / Plans";
	AL["BRD Blacksmithing Plans"] = "Plans de forge de BRD";
	AL["Patterns/Plans"] = "Plans / Patrons";

	-- General titles
	AL["Achievement"] = "Haut fait";
	AL["Dungeon"] = "Donjon";
	AL["Outdoor"] = "Plein air";
	AL["Promotional"] = "Promotionnel";
	AL["PvP"] = "JcJ";
	--AL["Raid"] = true;

	-- Companions
	AL["Achievement Companions"] = "Mascottes des hauts faits";
	AL["Faction Companions"] = "Mascottes des factions";
	AL["Card Game Companions"] = "Mascottes du jeu de cartes";
	AL["Companion Accessories"] = "Accessoires pour mascottes";
	AL["Blizzard Store"] = "Boutique Blizzard";
	AL["Crafted Companions"] = "Mascottes de l'artisanat";
	AL["Dungeon/Raid"] = "Donjon / Raid";
	--AL["Faction"] = true;
	AL["Merchant Sold Companions"] = "Mascottes des marchands";
	AL["Pets"] = "Animaux de compagnie";
	AL["Promotional Companions"] = "Mascottes promotionnelles";
	AL["Quest Reward Companions"] = "Mascottes des récompenses de quêtes";
	AL["Rare Companions"] = "Mascottes rares";
	AL["Unobtainable Companions"] = "Mascottes impossibles à obtenir";
	AL["New Companions"] = "Nouvelles mascottes";
	--- Drop Locations
	AL["Bogflare Needler"] = "Piqueur Tourbembrase";
	AL["Deviate Ravager/Deviate Guardian"] = "Ravageur déviant/Gardien déviant";
	AL["Gundrak Raptor"] = "Raptor de Gundrak";
	AL["Noxious Whelp"] = "Dragonnet nocif";

	-- Mounts
	AL["Alliance Mounts"] = "Montures de l'Alliance";
	AL["Horde Mounts"] = "Montures de la Horde";
	AL["Flying Mounts"] = "Montures volantes";
	AL["Card Game Mounts"] = "Montures du jeu de cartes";
	AL["Crafted Mounts"] = "Montures frabiquées";
	AL["Event Mounts"] = "Montures d'événements";
	AL["Neutral Faction Mounts"] = "Montures des factions neutres";
	AL["PvP Mounts"] = "Montures JcJ";
	AL["Alliance PvP Mounts"] = "Montures JcJ de l'Alliance";
	AL["Horde PvP Mounts"] = "Montures JcJ de la Horde";
	AL["Halaa PvP Mounts"] = "Montures JcJ de Halaa";
	AL["Promotional Mounts"] = "Montures promotionnelles";
	AL["Rare Mounts"] = "Montures rares";
	AL["Unobtainable Mounts"] = "Montures impossibles à obtenir";
	AL["New Mounts"] = "Nouvelles montures";
	AL["Mount Collecting"] = "Collection de monture";

	-- Tabards
	AL["Achievement & Quest Reward Tabards"] = "Tabards des hauts faits & récompenses de quêtes";
	AL["Alliance Tabards"] = "Tabards de l'Alliance";
	AL["Card Game Tabards"] = "Tabards du jeu de cartes";
	AL["Horde Tabards"] = "Tabards de la Horde";
	AL["Neutral Faction Tabards"] = "Tabards des factions neutres";
	AL["PvP Tabards"] = "Tabards JcJ";
	AL["Unobtainable Tabards"] = "Tabards impossibles à obtenir";

	-- Transformation Items
	AL["Transformation Items"] = "Objets de transformation";
	AL["Additional Effects Transformation Items"] = "Effets supplémentaires pour les objets de transformation";
	AL["Consumable Transformation Items"] = "Objets consommables de transformation";
	AL["Non-consumed Transformation Items"] = "Objets non-consommables de transformation";

	-- Heirloom and BoA Items
	AL["Heirloom"] = "Héritage";
	AL["PvP Heirlooms"] = "Héritages JcJ";
	AL["Bind on Account"] = "Lié au compte";
	AL["Bind on Account Armor"] = "Armures liées au compte";
	AL["Bind on Account Weapons"] = "Armes liées au compte";

	-- Darkmoon Faire
	AL["Darkmoon Faire Rewards"] = "Récompenses Foire de Sombrelune";
	AL["Low Level Decks"] = "Cartes bas level";
	AL["Level 60 & 70 Trinkets"] = "Bijoux niveau 60 & 70";
	AL["Trinkets"] = "Bijoux";

	-- Card Game Decks and descriptions
	AL["Loot Card Items"] = "Objets du jeu de cartes";
	AL["UDE Items"] = "Objets (points UDE)";

	-- First set
	AL["Heroes of Azeroth"] = "Héros d'Azeroth";
	AL["Landro Longshot"] = "Landro Tirauloin";
	AL["Thunderhead Hippogryph"] = "Hippogryffe Tête-Tonnerre";
	AL["Saltwater Snapjaw"] = "Gueule d'acier des mers";

	-- Second set
	AL["Through The Dark Portal"] = "A Travers la Porte des Ténèbres";
	AL["King Mukla"] = "Roi Mukla";
	AL["Rest and Relaxation"] = "Repos et relaxation";
	AL["Fortune Telling"] = "La Bonne Aventure";

	-- Third set
	AL["Fires of Outland"] = "Les Feux de l'Outreterre";
	AL["Spectral Tiger"] = "Tigre Spectral";
	AL["Gone Fishin'"] = "Parti Pêcher";
	AL["Goblin Gumbo"] = "Gumbo Gobelin";

	-- Fourth set
	AL["March of the Legion"] = "Marche de la Légion";
	--AL["Kiting"] = true;
	AL["Robotic Homing Chicken"] = "Poulet Robot Guidé";
	AL["Paper Airplane"] = "Machine volante en papier";

	-- Fifth set
	AL["Servants of the Betrayer"] = "Les Serviteurs du Traître";
	AL["X-51 Nether-Rocket"] = "Fusée-de-néant X-51";
	AL["Personal Weather Machine"] = "Machine météorologique gobeline";
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = "Biscuit pour familier à l'ancienne de papa Humme";

	-- Sixth set
	AL["Hunt for Illidan"] = "La Traque d'Illidan";
	--AL["The Footsteps of Illidan"] = true;
	--AL["Disco Inferno!"] = true;
	AL["Ethereal Plunderer"] = "Pilleur éthérien";

	-- Seventh set
	AL["Drums of War"] = "Tambours de Guerre";
	--AL["The Red Bearon"] = true;
	--AL["Owned!"] = true;
	--AL["Slashdance"] = true;

	-- Eighth set
	AL["Blood of Gladiators"] = "Le Sang des Gladiateurs";
	AL["Sandbox Tiger"] = "Tigre de bac à sable";
	AL["Center of Attention"] = "Chemise violette épique";
	AL["Foam Sword Rack"] = "Râtelier d'épées en mousse";

	-- Ninth set
	--AL["Fields of Honor"] = true;
	--AL["Path of Cenarius"] = true;
	--AL["Pinata"] = true;
	--AL["El Pollo Grande"] = true;

	-- Tenth set
	--AL["Scourgewar"] = true;
	--AL["Tiny"] = true;
	--AL["Tuskarr Kite"] = true;
	--AL["Spectral Kitten"] = true;

	-- Eleventh set
	--AL["Wrathgate"] = true;
	--AL["Statue Generator"] = true;
	AL["Landro's Gift"] = "Cadeau de Landro";
	AL["Blazing Hippogryph"] = "Hippogriffe flamboyant";

	-- Twelvth set
	AL["Icecrown"] = "La Couronne de glace";
	AL["Wooly White Rhino"] = "Rhinocéros laineux blanc";
	AL["Ethereal Portal"] = "Portail éthérien";
	AL["Paint Bomb"] = "Bombe de peinture";

	-- Thirtheenth set
	AL["Worldbreaker"] = "Brise-monde";
	AL["Mottled Drake"] = "Drake tacheté";
	AL["Grim Campfire"] = "Feu de camp sinistre";
	AL["Landro's Lil' XT"] = "Mini XT de Landro";

	-- Fourteenth set
	AL["War of the Elements"] = "Gardien des éléments";

	-- Fifteenth set
	--AL["Twilight of the Dragons"] = true;

	-- Seventeenth set
	--AL["Crown of Heaven"] = true;

	-- Eighteenth set
	--AL["Tomb of the Forgotten"] = true;

	-- Nineteenth set
	--AL["War of the Ancients"] = true;

	-- Twentieth set
	--AL["Betrayal of the Guardian"] = true;

	-- Battleground Brackets
	AL["Old PvP Rewards"] = "Anciennes récompenses JcJ";
	AL["BG/Open PvP Rewards"] = "CdB / Récompenses JcJ mondial";
	AL["Misc. Rewards"] = "Récompenses diverses";
	AL["Level %s Rewards"] = "Récompenses niveau %s"; -- usage: string.format(AL["Level %s Rewards"], "60")

	-- Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = "La voie du conquérant";
	AL["Path of the Invoker"] = "La voie de l'invocateur";
	AL["Path of the Protector"] = "La voie du protecteur";

	-- Violet Eye Paths
	AL["Path of the Violet Protector"] = "La voie du protecteur pourpre";
	AL["Path of the Violet Mage"] = "La voie du mage pourpre";
	AL["Path of the Violet Assassin"] = "La voie de l'assassin pourpre";
	AL["Path of the Violet Restorer"] = "La voie du guérisseur pourpre";

	-- Ashen Verdict Paths
	AL["Path of Courage"] = "La voie du courage";
	AL["Path of Destruction"] = "La voie de la destruction";
	AL["Path of Vengeance"] = "La voie de la vengeance";
	AL["Path of Wisdom"] = "La voie de la sagesse";

	-- AQ Opening Event
	AL["Red Scepter Shard"] = "Fragment de sceptre rouge";
	AL["Blue Scepter Shard"] = "Fragment de sceptre bleu";
	AL["Green Scepter Shard"] = "Fragment de sceptre vert";
	AL["Scepter of the Shifting Sands"] = "Le Sceptre des Sables changeants";

	-- World PvP
	AL["Hellfire Fortifications"] = "Fortifications des flammes infernales";
	AL["Twin Spire Ruins"] = "Ruines des flèches jumelles";
	AL["Spirit Towers"] = "Tour des esprits";
	--AL["Halaa"] = true,
	AL["Venture Bay"] = "Baie de la KapitalRisk";

	-- Karazhan Opera Event Headings
	AL["Wizard of Oz"] = "Le Magicien d'Oz";
	AL["Red Riding Hood"] = "Petit Chaperon Rouge";

	-- Karazhan Animal Boss Types
	AL["Spider"] = "Araignée";
	AL["Darkhound"] = "Sombredogue";
	AL["Bat"] = "Chauve-souris";

	-- AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = "Manche orné qiraji";
	AL["Qiraji Martial Drape"] = "Drapé martial qiraji";
	AL["Qiraji Magisterial Ring"] = "Anneau de magistrat qiraji";
	AL["Qiraji Ceremonial Ring"] = "Anneau de cérémonie qiraji";
	AL["Qiraji Regal Drape"] = "Drapé royal qiraji";
	AL["Qiraji Spiked Hilt"] = "Manche à pointes qiraji";

	-- AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = "Manchettes de domination qiraji";
	AL["Qiraji Bindings of Command"] = "Diadème de Vek'nilash";
	AL["Vek'nilash's Circlet"] = "Peau intacte d'Ouro";
	AL["Vek'lor's Diadem"] = "Carcasse du Dieu très ancien";
	AL["Ouro's Intact Hide"] = "Manchettes de commandement qiraji";
	AL["Skin of the Great Sandworm"] = "Diadème de Vek'lor";
	AL["Husk of the Old God"] = "Peau du Grand ver des sables";
	AL["Carapace of the Old God"] = "Carapace du Dieu très ancien";

	-- Faction related strings
	AL["Neutral"] = "Neutre";
	AL["Friendly"] = "Amical";
	AL["Honored"] = "Honoré";
	AL["Revered"] = "Révéré";
	AL["Exalted"] = "Exalté";
	AL["Best Friend"] = "Meilleur ami";
	AL["Rank %d"] = "Rang %d";
	AL["Winterfin Retreat"] = "Retraite des Ailerons-d'hiver";

	-- Recipe origin strings
	AL["Crafted"] = "Fabriqué";
	AL["Discovery"] = "Découverte";
	--AL["Drop"] = true;
	AL["Fished From"] = "Pêché de";
	AL["Trainer"] = "Entraineur";
	AL["Vendor"] = "Vendeur";	
	AL["World Drop"] = "Drop mondial";

	-- Specs
	--AL["Tanking"] = true;
	--AL["DPS"] = true;

	-- NPCs missing from BabbleBoss
	--AL["Trash Mobs"] = true,
	--- Classic WoW
	AL["Dungeon Set 2 Summonable"] = "Invocation Set Donjon 2";
	--AL["Theldren"] = true,
	AL["Sothos and Jarien"] = "Sothos et Jarien";
	AL["Druid of the Fang"] = "Druide du Croc";
	AL["Defias Strip Miner"] = "Carrier défias";
	AL["Defias Overseer/Taskmaster"] = "Sous-chef/Surveillant défias";
	AL["Scarlet Trainee"] = "Jeune recrue écarlate"; --- mob removed from game
	AL["Shadowforge Flame Keeper"] = "Gardien des flammes Ombreforge";
	AL["Crimson Sorcerer"] = "Ensorceleur cramoisi";--- mob removed from game. Formula: Enchant 2H Weapon - Major Intellect drops now from Risen Sorcerer
	AL["Thuzadin Shadowcaster"] = "Exhalombre Thuzadin";
	AL["Crimson Inquisitor"] = "Inquisiteur cramoisi"; --- mob removed from game. Schematic: Voice Amplification Modulator and Schematic: Ultra-Flash Shadow Reflector drops now from Risen Inquisitor
	AL["Crimson Battle Mage"] = "Mage de bataille cramoisi"; --- mob removed from game?
	AL["Ghoul Ravener"] = "Goule vorace";
	AL["Spectral Citizen"] = "Citoyen spectral";
	AL["Scholomance Adept"] = "Adepte de la Scholomance"; --- Drops Formula: Enchant 2H Weapon - Major Spirit along with Scholomance Acolyte and needs to be added back to trash loot of Scholomance.
	AL["Scholomance Dark Summoner"] = "Invocateur des ténèbres de la Scholomance"; --- mob might have been removed. No idea where we used this.
	AL["Blackhand Elite"] = "Elite Main-noire";
	AL["Firebrand Pyromancer"] = "Pyromancien de Brandefeu";
	AL["Firebrand Invoker"] = "Invocateur de Brandefeu";
	AL["Firebrand Grunt"] = "Grunt de Brandefeu";
	AL["Firebrand Legionnaire"] = "Légionnaire de Brandefeu";
	AL["Spirestone Warlord"] = "Chef de guerre Pierre-du-pic";
	AL["Spirestone Mystic"] = "Mystique Pierre-du-pic";
	AL["Anvilrage Captain"] = "Capitaine Ragenclume";
	AL["Anvilrage Marshal"] = "Maréchal Ragenclume";
	AL["Doomforge Arcanasmith"] = "Forgeron des arcanes Forge-ruine";
	AL["Weapon Technician"] = "Ingénieur de siège";
	AL["Doomforge Craftsman"] = "Artisan Forge-ruine";
	AL["Murk Worm"] = "Ver des boues";  --- mob removed from game
	AL["Scarshield Quartermaster"] = "Intendant du Bouclier balafré";
	AL["Knot Thimblejack"] = "Noué Dédodevie"; --- Might not give any items anymore, needs to be checked.
	AL["Shen'dralar Provisioner"] = "Approvisionneur Shen'dralar";
	AL["The Nameles Prophet"] = "Le Prophète sans nom";
	AL["Rajaxx's Captains"] = "Les Capitaines de Rajaxx";
	AL["Razorfen Spearhide"] = "Lanceur de Tranchebauge";
	AL["Felsteed"] = "Palefroi corrompu"; --- NPC name is Fel Steed. Drops Eerie Stable Lantern in SFK.
	AL["Master Elemental Shaper Krixix"] = "Maître élémentaire Krixix le Sculpteur"; --- Needs to be added to BabbleBoss
	AL["Rotted One"] = "Pourri";
	AL["Tex Vortacoil"] = "Tex Vortabobine";
	AL["Sprinkle Noggenfogger"] = "Saupoudr Brouillecaboche";
	--- Burning Crusade
	AL["Avatar of the Martyred"] = "Avatar des martyrs"; --- Needs to be moved to BabbleBoss
	AL["Nexus Stalker"] = "Traqueur du nexus";
	AL["Auchenai Monk"] = "Moine auchenaï";
	AL["Cabal Fanatic"] = "Fanatique de la Cabale";
	AL["Unchained Doombringer"] = "Porte-destin sans chaîne";
	AL["Aether-tech Assistant"] = "Techno-éther assistant";
	AL["Aether-tech Adept"] = "Techno-éther adepte";
	AL["Aether-tech Master"] = "Techno-éther apprenti";
	--AL["Thomas Yance"] = true,
	AL["Raging Skeleton"] = "Squelette déchaîné";
	AL["Ethereal Priest"] = "Prêtre éthérien";
	AL["Sethekk Ravenguard"] = "Garde-corbeau Sethekk";
	AL["Time-Lost Shadowmage"] = "Ombremage du Temps-perdu";
	AL["Coilfang Sorceress"] = "Sorcière de Glissecroc";
	AL["Coilfang Oracle"] = "Oracle de Glissecroc";
	AL["Shattered Hand Centurion"] = "Centurion de la Main brisée";
	AL["Eredar Deathbringer"] = "Porte-mort érédar";
	AL["Arcatraz Sentinel"] = "Sentinelle de l'Arcatraz";
	AL["Gargantuan Abyssal"] = "Abyssal gargantuesque";
	AL["Sunseeker Botanist"] = "Botaniste Cherche-soleil";
	AL["Sunseeker Astromage"] = "Astromage Cherche-soleil";
	AL["Durnholde Rifleman"] = "Fusilier de Fort-de-Durn";
	AL["Rift Keeper/Rift Lord"] = "Gardien des failles/Seigneur des failles";
	--AL["Don Carlos"] = true, --- Needs to be moved to BabbleBoss
	AL["Aged Dalaran Wizard"] = "Sorcier de Dalaran âgé";
	AL["Shattered Hand Executioner"] = "Bourreau de la Main brisée";
	AL["Servant's Quarter Animal Bosses"] = "Quartiers des serviteurs (Boss animal)";
	AL["Wyrmcult Provisioner"] = "Approvisionneur du culte du Ver";
	--- Wrath of the Lich King
	--AL["Olut Alegut"] = true;
	AL["Rork Sharpchin"] = "Rork Menton-pointu";
	--- Cataclysm
	--AL["Zen'Vorka"] = true;
	AL["Ayla Shadowstorm"] = "Ayla Ombretempête";
	AL["Damek Bloombeard"] = "Damek Barbe-en-Fleur";
	AL["Varlan Highbough"] = "Varlan Hautebranche";
	AL["Firestone Vendor"] = "Vendeur des Terres de Feu";
	AL["Baradin Fox"] = "Renard de Baradin";
	--- Mists of Pandaria
	AL["Uncle Bigpocket"] = "Oncle Poche Profonde";
	AL["Auntie Stormstout"] = "Tatie Brune d’Orage";
	--AL["Luo Luo"] = true;
	--AL["Meng Meng"] = true;
	AL["Ongrom Black Tooth"] = "Ongrom Dent-Noire";
	AL["Proveditor Grantley"] = "Provéditeur Grantley";
	--- World Events
	AL["Crimson Templar"] = "Templier cramoisi";  --- mob removed from game?
	AL["Azure Templar"] = "Templier d'azur";  --- mob removed from game?
	AL["Hoary Templar"] = "Templier chenu";  --- mob removed from game?
	AL["Earthen Templar"] = "Templier terrestre";  --- mob removed from game?
	AL["The Duke of Cynders"] = "Le duc des Cendres";  --- mob removed from game?
	AL["The Duke of Fathoms"] = "Le duc des Profondeurs";  --- mob removed from game?
	AL["The Duke of Zephyrs"] = "Le duc des Zéphyrs";  --- mob removed from game?
	AL["The Duke of Shards"] = "Le duc des Eclats";  --- mob removed from game?
	AL["Templars"] = "Templiers";  --- mob removed from game?
	AL["Dukes"] = "Ducs";  --- mob removed from game?
	AL["High Council"] = "Princes";  --- mob removed from game?
	AL["Smokywood Pastures Vendor"] = "Vendeurs de Gourmandises Fumebois";
	AL["Bash'ir Landing Stasis Chambers"] = "Chambre de stase alpha du point d'ancrage de Bash'ir";
	AL["Battle Pet Trainer"] = "Dresseur de mascottes de combat";

	-- Zone related strings
	-- AL["Azeroth"] = true;
	AL["Blackrock Mountain"] = "Mont Rochenoire";
	AL["Caverns of Time"] = "Grottes du temps";
	AL["Crusader's Square"] = "Place des Croisés";
	AL["Darkmoon Island"] = "Île de Sombrelune";
	AL["East"] = "Est";
	AL["Halfhill Farm"] = "Marché de Micolline";
	AL["North"] = "Nord";
	AL["The Gauntlet"] = "Le Défi";
	AL["Trial of the Grand Crusader"] = "L'épreuve du grand croisé";
	AL["West"] = "Ouest";

	-- Shortcuts for Bossname files
	--AL["Avatar"] = true; -- Avatar of the Martyred

	-- Chests, etc
	AL["Father Flame"] = "Père des flammes"; --- If still in game, should be used in IngameLocales
	AL["The Grim Guzzler"] = "Le Sinistre écluseur";
	AL["The Secret Safe"] = "Coffre à relique";
	AL["The Vault"] = "La Chambre forte";
	AL["Ogre Tannin Basket"] = "Panier Ogre de tannin";
	AL["Unfinished Painting"] = "Toile inachevée";
	AL["Felvine Shard"] = "Fragment de la Gangrevigne"; --- If still in game, should be used in IngameLocales
	AL["Gift of Adoration"] = "Cadeau d'adoration"; --- If still in game, should be used in IngameLocales
	AL["Treat Bag"] = "Sac de friandises"; --- If still in game, should be used in IngameLocales
	AL["The Cache of Madness"] = "L'antre de la Folie";
	AL["Timed Reward Chest"] = "Coffre du parcours rapide";
	AL["Timed Reward Chest 1"] = "Coffre du parcours rapide 1";
	AL["Timed Reward Chest 2"] = "Coffre du parcours rapide 2";
	AL["Timed Reward Chest 3"] = "Coffre du parcours rapide 3";
	AL["The Talon King's Coffer"] = "Le coffre du roi-serre";
	AL["Krom Stoutarm's Chest"] = "Coffre de Krom Rudebras";
	AL["Garrett Family Chest"] = "Coffre de la famille Garrett";
	AL["Reinforced Fel Iron Chest"] = "Coffre en gangrefer renforcé";
	AL["DM North Tribute Chest"] = "Coffre du Roi (HT Nord)";
	AL["The Saga of Terokk"] = "La Saga de Terokk"; --- If still in game, should be used in IngameLocales
	AL["First Fragment Guardian"] = "Gardien du premier fragment";
	AL["Second Fragment Guardian"] = "Gardien du second fragment";
	AL["Third Fragment Guardian"] = "Gardien du troisième fragment";
	AL["Overcharged Manacell"] = "Cellule de mana surchargée"; --- If still in game, should be used in IngameLocales
	AL["Shellfish Trap"] = "Casier à crustacés";
	AL["Fishing Pools"] = "Bancs de poissons";

	-- Blizzard Promotions
	AL["Annual Pass"] = "Pass annuel";
	AL["Scroll of Resurrection"] = "Sort de résurrection";
	AL["Recruit-A-Friend"] = "Parrainer un ami";

	-- Error Messages and warnings
	AL["AtlasLoot Error!"] = "Erreur AtlasLoot !";
	AL["WishList Full!"] = "Liste de souhaits complète !";
    	AL["No match found for"] = "Aucun résultat trouvé pour";
	AL[" is safe."] = " est valide.";
	AL["Server queried for "] = "Interrogation du serveur pour ";
	AL[".  Right click on any other item to refresh the loot page."] = ".  Clic-Droit sur un autre objet permet de rafraîchir la page.";

	-- Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = " non répertorié dans la table des objets enregistrés, merci de transmettre ce message sur les forums d'AtlasLoot sur http://www.atlasloot.net";

	-- LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = " est indisponible, le module suivant (chargé à la demande) est requis : ";

	-- LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = "Le status du module suivant n'a pu être déterminé : ";

	-- LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = " n'a pas pu être consulté, le module suivant peut être dépassé : ";

	-- LoD module not defined
	AL["Loot module returned as nil!"] = "Le module de loot a retourné une erreur !";

	-- LoD module loaded successfully
	AL["sucessfully loaded."] = "chargement réussi.";

	-- Need a big dataset for searching
	AL["Loading available tables for searching"] = "Chargement des tables disponibles pour la recherche";

	-- All Available modules loaded
	AL["All Available Modules Loaded"] = "Tous les modules disponibles sont chargés.";

	-- First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = "Bienvenue dans AtlasLoot Enhanced. Veuillez prendre un moment pour définir vos préférences.";
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = "Bienvenue dans AtlasLoot Enhaced. S'il vous plaît, prenez un moment pour définir vos préférences pour les infobulles et les liens dans la fenêtre de chat.\n\nLes options peuvent être activées à tout moment en tapant '/atlasloot'.";
	AL["Setup"] = "Installation";

	-- Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "Il a été détecté que votre version d'Atlas n'est pas adapté à la version d'AtlasLoot, laquelle est étudiée pour (";
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = "). Suivant les changements, des erreurs peuvent survenir, vous pouvez consulter le site http://www.atlasmod.com/ pour les futures mises à jour.";
	--AL["OK"] = true,
	AL["Incompatible Atlas Detected"] = "Incompatibilité d'Atlas détectée";

	-- Unsafe item tooltip
	AL["Unsafe Item"] = "Objet invalide";
	AL["This item is not available on your server or your battlegroup yet."] = "Cet objet n'est pas encore disponible sur votre serveur ou sur votre champ de bataille";
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = "Un Clic-Droit permet de tenter d'interroger le serveur.\nVous pouvez être déconnecté.";
end