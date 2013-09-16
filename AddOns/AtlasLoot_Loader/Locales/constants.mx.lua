-- $Id: constants.mx.lua 4212 2013-05-20 12:27:56Z dynaletik $
--[[
constants.es.lua --- Traduction ES por maqjav
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.


]]




--Create the library instance
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

local AL = AceLocale:NewLocale("AtlasLoot", "esMX", false);

if AL then
	--Text strings for UI objects
	--AL["AtlasLoot"] = true,
	AL["No match found for"] = "No se ha encontrado ninguna coincidencia";
	AL["Search"] = "Buscar";
	AL["Clear"] = "Limpiar";
	AL["Select Loot Table"] = "Selecciona tabla";
	AL["Select Sub-Table"] = "Selecciona subtabla";
	AL["Drop Rate: "] = "Prob. de conseguirse: ";
	--AL["DKP"] = true,
	AL["Priority:"] = "Prioridad:";
	AL["Click boss name to view loot."] = "Haz click sobre el nombre del jefe para ver el botín.";
	AL["Various Locations"] = "Se obtiene en diferentes sitios";
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "Esto es tan solo un buscador de botines. Para ver el mapa instala el Atlas o Alphamap";
	AL["Toggle AL Panel"] = "Panel AtlasLoot";
	AL[" is safe."] = " es válido.";
	AL["Server queried for "] = "Preguntando al servidor por ";
	AL[".  Right click on any other item to refresh the loot page."] = ".  Haz click-dcho en otro objeto para refrescar la página.";
	AL["Back"] = "Atrás";
	AL["Level 60"] = "Nivel 60";
	AL["Level 70"] = "Nivel 70";
	AL["Level 80"] = "Nivel 80";
	AL["|cffff0000(unsafe)"] = " |cffff0000(no seguro)";
	AL["Misc"] = "Misc.";
	AL["Rewards"] = "Recompensas";
	AL["Heroic Mode"] = "Modo heróico";
	AL["Normal Mode"] = "Modo normal";
	AL["Hard Mode"] = "Modo dificil";
	AL["Show 10 Man Loot"] = "Muestra 10 Pers. Botín";
	AL["Show 25 Man Loot"] = "Muestra 25 Pers. Botín";
	AL["10 Man"] = "10 pers.";
	AL["25 Man"] = "25 pers.";	
	AL["Raid"] = "Banda";
	AL["Choose Table ..."] = "Elige una tabla...";
	AL["Unknown"] = "Desconocido";
	AL["Skill Required:"] = "Habilidad necesaria";
	AL["QuickLook"] = "VistaRápida";
	AL["Add to QuickLooks:"] = "Añade a VistaRápida";
	AL["Rating:"] = "Indice:";	--Shorthand for 'Required Rating' for the personal/team ratings in Arena S4 
	AL["Query Server"] = "Pregun. Servidor";
	--AL["Burning Crusade"] = true,
	AL["Entrance"] = "Entrada";
	AL["Reset Frames"] = "Restaurar marcos";
	AL["Reset Wishlist"] = "Res. ListaDeseada";
	AL["Reset Quicklooks"] = "Res. BotínRápido";
	AL["Select a Loot Table..."] = "Elige una tabla de Botín...";
	AL["OR"] = "O";
	--AL["Wrath of the Lich King"] = true,
	AL["FuBar Options"] = "Opciones FuBar";
	AL["Attach to Minimap"] = "Sujetar al minimapa";
	AL["Hide FuBar Plugin"] = "Esconder FuBar Plugin";
	AL["Show FuBar Plugin"] = "Mostrar FuBar Plugin"; 
	AL["Position:"] = "Posición:";
	AL["Left"] = "Izquierda";
	AL["Center"] = "Centro";
	AL["Right"] = "Derecha";
	AL["Hide Text"] = "Esconder Texto";
	AL["Hide Icon"] = "Esconder Icono";
	AL["Minimap Button Options"] = "Opciones botón minimapa";
	AL["Bonus Loot"] = "Bonus Botín";

	--Text for Options Panel
	AL["Atlasloot Options"] = "Opciones Atlasloot";
	AL["Safe Chat Links"] = "Enlaces seguros en el chat";
	AL["Default Tooltips"] = "Bocadillos texto predet.";
	AL["Lootlink Tooltips"] = "Bocadillos enlaces de botín";
	AL["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dBocadillos enlaces de botín";
	AL["ItemSync Tooltips"] = "Bocadillos sincronismo de objetos";
	AL["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dBocadillos de sincronismo de objetos";
	AL["Use EquipCompare"] = "Utilizar EquipCompare";
	AL["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9dUtilizar EquipCompare";
	AL["Show Comparison Tooltips"] = "Mostrar bocadillos de comparación";
	AL["Make Loot Table Opaque"] = "Hacer opaca tabla botines";
	AL["Show itemIDs at all times"] = "Mostrar el ID objetos";
	AL["Hide AtlasLoot Panel"] = "Esconder panel de AtlasLoot";
	AL["Show Basic Minimap Button"] = "Mostrar botón básico en el mini mapa";
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = "|cff9d9d9dMostrar botón de Minimapa básico|r";
	AL["Set Minimap Button Position"] = "Elegir la posición del botón del mini mapa";
	AL["Suppress Item Query Text"] = "Suprimir texto petición objetos";
	AL["Notify on LoD Module Load"] = "Notificar al cargar un módulo";
	AL["Load Loot Modules at Startup"] = "Cargar módulos al iniciar el juego";
	AL["Loot Browser Scale: "] = "Escala del buscador: ";
	AL["Button Position: "] = "Posición del botón";
	AL["Button Radius: "] = "Radio del botón";
	AL["Done"] = "Hecho";
	AL["FuBar Toggle"] = "Conmutar FuBar";
	AL["WishList"] = "Lista deseada";
	AL["Search Result: %s"] = "Buscar resultado: %s";
	AL["Last Result"] = "Último resulta.";
	AL["Search on"] = "Buscar en";
	AL["All modules"] = "Todos los módulos";
	AL["If checked, AtlasLoot will load and search across all the modules."] = "Si lo marcas, AtlasLoot lo cargará y buscará por todos los módulos.";
	AL["Search options"] = "Buscar opciones";
	AL["Partial matching"] = "Coincidencia parcial";
	AL["If checked, AtlasLoot search item names for a partial match."] = "Si lo marcas, AtlasLoot buscará el nombre de los objetos con una coincidencia parcial.";
	AL["You don't have any module selected to search on!"] = "¡No tienes marcado ningún módulo donde buscar!";
	--The next 4 lines are the tooltip for the Server Query Button
	--The translation doesn't have to be literal, just re-write the
	--sentences as you would naturally and break them up into 4 roughly
	--equal lines.
	AL["Queries the server for all items"] = "Pregunta al servidor por todos los objectos";
	AL["on this page. The items will be"] = "de esta página, Los objectos serán";
	AL["refreshed when you next mouse"] = "refrescados al pasar el ratón";
	AL["over them."] = "sobre ellos";
	AL["The Minimap Button is generated by the FuBar Plugin."] = "El botón del Minimapa es generado por el plugin FuBar.";
	AL["This is automatic, you do not need FuBar installed."] = "Esto es automático, no tienes que tener instalado FuBar.";

	--Slash commands
	AL["reset"] = "Reiniciar";
	AL["options"] = "Opciones";
	AL["Reset complete!"] = "¡Se ha reiniciado!";

	--Error Messages and warnings
	AL["AtlasLoot Error!"] = "¡AtlasLoot error!";
	AL["WishList Full!"] = "¡Lista de deseos llena'";
	AL[" added to the WishList."] = " añadido a la lista de deseos.";
	AL[" already in the WishList!"] = " ya esta en la lista de deseos";
	AL[" deleted from the WishList."] = " borrado de la lista de deseos";

	--Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = " no figura en el registro de botines, por favor informa sobre este mensaje en los foros de AtlasLoot http://www.atlasloot.net";

	--LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = " no está disponible, se necesita el siguiente módulo: ";

	--LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = "No se ha podido determinar el estado del siguiente módulo: ";

	--LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = " no se ha podido acceder, el siguiente módulo no debe estar actualizado: ";

	--LoD module not defined
	AL["Loot module returned as nil!"] = "¡El módulo de botín ha retornado null!";

	--LoD module loaded successfully
	AL["sucessfully loaded."] = "cargado satisfactoriamente.";

	--Need a big dataset for searching
	AL["Loading available tables for searching"] = "Cargando las tablas disponibles para búsquedas";

 	--All Available modules loaded
	AL["All Available Modules Loaded"] = "Se han cargado todos los módulos disponibles";

	--Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00Click-izdo|r Navegar por las tablas de botines";
	AL["|cffff0000Right-Click|r View Options"] = "|cffff0000Click-dcho|r Ver opciones";
	AL["|cffff0000Shift-Click|r View Options"] = "|cffff0000Shift-Click|r Ver opciones";
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffccccccClick-izdo + arrastrar|r Mueve el botón del mini mapa";
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = "|cffccccccClick-dcho + arrastrar|r Mueve el botón del mini mapa";

	--AtlasLoot Panel
	AL["Options"] = "Opciones";
	AL["Collections"] = "Colecciones";
	AL["Factions"] = "Facciones";
	AL["World Events"] = "Eventos mundo";
	AL["Load Modules"] = "Cargar módulos";
	AL["Crafting"] = "Fabricados";
	AL["Crafting Daily Quests"] = "Fabricados misiones diarias";

	--First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = "Bienvenido a AtlasLoot Enhanced. Por favor, tómate un momento para elegir tus preferencias.";
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = "Bienvenido a Atlasloot Enhanced. Por favor tómate un momento para elegir tus preferencias en cada bocadillo y enlaces de la ventana de chat.\n\n Puedes volver a abrir esta ventana de opciones escribiendo '/atlasloot'.";
	AL["Setup"] = "Configuración";

	--Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "Se ha detectado que tu versión de Atlas no coincide con la versión del AtlasLoot para la cual se ha hecho (";
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = ").  Dependiendo de algún cambio, puede haber algún error ocasional, con lo que por favor, visita http://www.atlasmod.com/ lo antes posible para posibles actualizaciones.";
	AL["OK"] = "Vale";
	AL["Incompatible Atlas Detected"] = "Se ha detectado un Atlas incompatible ";

	--Unsafe item tooltip
	AL["Unsafe Item"] = "Objeto no seguro";
	AL["Item Unavailable"] = "Objeto no disponible";
	AL["ItemID:"] = "ObjetoID:";
	AL["This item is not available on your server or your battlegroup yet."] = "Este objeto no está disponible en tu servidor o en tu grupo de batalla todavía";
	AL["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] =	"Este objeto no es seguro.\nPara verlo sin riesgo de ser desconectado, tienes que haberlo visto primero en el mundo del juego.\nEsto es una restricción forzada por Blizzard desde el Parche 1.10.";
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = "Puedes hacer Click-dcho para intentar consultar al servidor.\nPuedes ser desconectado.";

	--Misc Inventory related words
	AL["Scope"] = "Mira";
	AL["Darkmoon Faire Card"] = "Carta de la Feria de la Luna";
	AL["Banner"] = "Estandarte";
	AL["Set"] = "Conjunto";
	AL["Token"] = "Insignia";
	AL["Combat Pet"] = "Mascota de combate"; --Comprobar
	AL["Fireworks"] = "Fuegos artificiales";

	--Extra inventory stuff
	AL["Cloak"] = "Capa";
	AL["Weapons"] = "Armas";

	--Alchemy
	AL["Battle Elixirs"] = "Elixires de Batalla";
	AL["Guardian Elixirs"] = "Elixires de Guardián";
	AL["Potions"] = "Pociones";
	AL["Transmutes"] = "Transmutaciones";
	AL["Flasks"] = "Frascos";

	--Enchanting
	AL["Enchant Boots"] = "Encantamiento Botas";
	AL["Enchant Bracer"] = "Encantamiento Brazalete";
	AL["Enchant Chest"] = "Encantamiento Pecho";
	AL["Enchant Cloak"] = "Encantamiento Capa";
	AL["Enchant Gloves"] = "Encantamiento Guantes";
	AL["Enchant Ring"] = "Encantamiento Anillo";
	AL["Enchant Shield & Off-Hand"] = "Encantamiento Escudo";
	AL["Enchant 2H Weapon"] = "Encantamiento Arma 2 Manos";
	AL["Enchant Weapon"] = "Encantamiento Arma";

	--Inscription
	AL["Major Glyph"] = "Glifos Sublimes";
	AL["Minor Glyph"] = "Glifos Menores";
	AL["Scrolls"] = "Pergaminos";
	AL["Off-Hand Items"] = "Objetos de mano-izda";
	AL["Reagents"] = "Consumibles";
	AL["Book of Glyph Mastery"] = "Libro sobre maestría en glifos";

	--Leatherworking
	AL["Leather Armor"] = "Armaduras de cuero";
	AL["Mail Armor"] = "Armaduras de malla";
	AL["Cloaks"] = "Capas";
	AL["Item Enhancements"] = "Objetos de Mejora";
	AL["Quivers and Ammo Pouches"] = "Carcajs y bolsas de munición";
	AL["Drums, Bags and Misc."] = "Tambores, Bolsas y Misc.";

	--Tailoring
	AL["Shirts"] = "Camisas";
	AL["Bags"] = "Bolsas";

	--Labels for loot descriptions
	AL["Classes:"] = "Clases";
	AL["This Item Begins a Quest"] = "Este objeto empieza una misión";
	AL["Quest Item"] = "Objeto de misión";
	AL["Quest Reward"] = "Recompensa de misión";
	AL["Shared"] = "Compartido";
	AL["Right Half"] = "Parte derecha";
	AL["Left Half"] = "Parte izquierda";
	AL["(has random enchantment)"] = "(añade un encantamiento aleatorio)";
	AL["Currency"] = "Utiliza recompensas para comprarlo";
	AL["Card Game Item"] = "Juego de cartas";
	AL["Tier 1"] = "Conjunto T1";
	AL["Tier 2"] = "Conjunto T2";
	AL["Tier 3"] = "Conjunto T3";
	AL["Tier 4"] = "Conjunto T4";
	AL["Tier 5"] = "Conjunto T5";
	AL["Tier 6"] = "Conjunto T6";
	AL["Tier 7"] = "Conjunto T7";
	AL["Tier 8"] = "Conjunto T8";
	AL["10/25 Man"] = "10/25 Personas";
	AL["Level 80 PvP Sets"] = "Conjuntos Nivel 80 JcJ";
	AL["Arena Reward"] = "Recompensas de Arenas";
	AL["Used to summon boss"] = "Usado para invocar a un jefe";
	AL["Phase 1"] = "Fase 1";
	AL["Phase 2"] = "Fase 2";
	AL["Phase 3"] = "Fase 3";
	AL["Fire"] = "Fuego";
	AL["Water"] = "Agua";
	AL["Wind"] = "Aire";
	AL["Earth"] = "Tierra";
	AL["Master Angler"] = "Maestro pescador";
	AL["First Prize"] = "Primer precio";
	AL["Rare Fish Rewards"] = "Recompensas raras de pesca";
	AL["Rare Fish"] = "Pescados raros";
	AL["Tradable for sunmote + item above"] = "Comerciables";
	AL["Rare"] = "Raro";
	AL["Heroic"] = "Heróico";
	AL["Hard Mode"] = "Modo difícil";		
	AL["Summon"] = "Invocar";
	AL["Random"] = "Aleatorio";
	AL["Weapons"] = "Armas";
	AL["Achievement"] = "Logro";
	AL["Heirloom"] = "Reliquia";	

	-- Darkmoon Faire
	AL["Darkmoon Faire Rewards"] = "Recompensas Feria de la Luna Negra";
	AL["Low Level Decks"] = "Bajaras de bajo nivel";
	--AL["Level 60 & 70 Trinkets"] = true;
	--AL["Trinkets"] = true;

	--Argent Tournament
	AL["Argent Tournament"] = "Torneo Argenta";

	-- Daily Quest
--	AL["Jewelcrafting Daily"] = true;
--	AL["Cooking Daily"] = true;

	--Card Game Decks and descriptions
	AL["Loot Card Items"] = "Objetos (juegos de cartas)";
	AL["UDE Items"] = "Objetos (puntos UDE)";

	-- First set
	AL["Heroes of Azeroth"] = "Heroes de Azeroth";
	AL["Landro Longshot"] = "Landro Tirolargo";
	AL["Thunderhead Hippogryph"] = "Hipogrifo Tronatesta";
	AL["Saltwater Snapjaw"] = "Quijaforte marino";
	-- Second set	
	AL["Through The Dark Portal"] = "A través del Portal Oscuro";
	AL["King Mukla"] = "Rey Mukla";
	AL["Rest and Relaxation"] = "Descanso y relajación";
	AL["Fortune Telling"] = "La buena aventura"; --Comprobar
	-- Third set
	AL["Fires of Outland"] = "Fuegos de Terrallende";
	AL["Spectral Tiger"] = "Tigre espectral";
	AL["Gone Fishin'"] = "Se fué pescando"; --Comprobar
	AL["Goblin Gumbo"] = "Potaje goblin";
	-- Fourth set
	AL["March of the Legion"] = "Marca de la Legión";
	--AL["Kiting"] = true, FALTA
	--AL["Robotic Homing Chicken"] = true, FALTA
	AL["Paper Airplane"] = "Avión de papel"
	-- Fifth set	
	AL["Servants of the Betrayer"] = "Sirvientes del Traidor";
	AL["X-51 Nether-Rocket"] = "Cohete abisal X-51";
	AL["Personal Weather Machine"] = "Máquina del tiempo personal";
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = "Galleta de mascota retro de papá Hummel"
	-- Sixth set
	AL["Hunt for Illidan"] = "Caza de Illidan"; 
	AL["The Footsteps of Illidan"] = "Las huellas de Illidan"; 
	--AL["Disco Inferno!"] = true, FALTA
	AL["Ethereal Plunderer"] = "Desvalijador etéreo";
	-- Seventh set
	AL["Drums of War"] = "Tambores de guerra";
	--AL["The Red Bearon"] = "The Red Bearon"; --FALTA
	--AL["Owned!"] = true, --FALTA
	--AL["Slashdance"] = true, --FALTA
	-- Eighth set
	AL["Blood of Gladiators"] = "Sangre de Gladiadores";
	AL["Sandbox Tiger"] = "Tigre Balancín";
	AL["Center of Attention"] = "Centro de atención"; --Check
	AL["Foam Sword Rack"] = "Espada de gomaespuma";

	--Battleground Brackets
	AL["Misc. Rewards"] = "Recompensas varias";
	AL["Level 20-29 Rewards"] = "Recompensas de niveles 20-29";
	AL["Level 30-39 Rewards"] = "Recompensas de niveles 30-39";
	AL["Level 20-39 Rewards"] = "Recompensas de niveles 20-39";
	AL["Level 40-49 Rewards"] = "Recompensas de niveles 40-49";
	AL["Level 60 Rewards"] = "Recompensas de nivel 60";

	--Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = "El camino del conquistador";
	AL["Path of the Invoker"] = "El camino del invocador";
	AL["Path of the Protector"] = "El camino del protector";

	--Violet Eye Paths
	AL["Path of the Violet Protector"] = "El camino del protector violeta";
	AL["Path of the Violet Mage"] = "El camino del mago violeta";
	AL["Path of the Violet Assassin"] = "El camino del asesino violeta";
	AL["Path of the Violet Restorer"] = "El camino del restaurador violeta";

	--AQ Opening Event
	AL["Red Scepter Shard"] = "Fragmento de cetro rojo";
	AL["Blue Scepter Shard"] = "Fragmento de cetro azul";
	AL["Green Scepter Shard"] = "Fragmento de cetro verde";
	AL["Scepter of the Shifting Sands"] = "El cetro del Mar de Dunas";

	--World PvP
	AL["Hellfire Fortifications"] = "Fortificaciones de la Península de fuego";
	AL["Twin Spire Ruins"] = "Ruinas de las Agujas Gemelas";
	AL["Spirit Towers"] = "Torres de los espíritus";
	--AL["Halaa"] = true,
	AL["Venture Bay"] = "Bahía Aventura"; --Check

	--Karazhan Opera Event Headings
	AL["Wizard of Oz"] = "El mago de Oz";
	AL["Red Riding Hood"] = "Caperucita roja";

	--Karazhan Animal Boss Types
	AL["Spider"] = "Araña";
	AL["Darkhound"] = "Can oscuro";
	AL["Bat"] = "Murciélago";

	--AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = "Empuñadura Qiraji ornamentada";
	AL["Qiraji Martial Drape"] = "Mantón Qiraji marcial";
	AL["Qiraji Magisterial Ring"] = "Anillo Qiraji magistral";
	AL["Qiraji Ceremonial Ring"] = "Anillo ceremonial Qiraji";
	AL["Qiraji Regal Drape"] = "Mantón Qiraji real";
	AL["Qiraji Spiked Hilt"] = "Puño con pinchos Qiraji";

	--AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = "Ataduras de dominio Qiraji";
	AL["Qiraji Bindings of Command"] = "Ataduras de mando Qiraji";
	AL["Vek'nilash's Circlet"] = "Aro de Vek'nilash";
	AL["Vek'lor's Diadem"] = "Diadema de Vek'lor";
	AL["Ouro's Intact Hide"] = "Pellejo intacto de Ouro";
	AL["Skin of the Great Sandworm"] = "Piel del Gran gusano de arena";
	AL["Husk of the Old God"] = "Colmillo del dios antiguo";
	AL["Carapace of the Old God"] = "Caparazón del dios antiguo";

	-- Faction related strings
	-- AL["Neutral"] = true;
	AL["Friendly"] = "Amistoso";
	AL["Honored"] = "Honorable";
	AL["Revered"] = "Reverenciado";
	AL["Exalted"] = "Exaltado";
	-- AL["Best Friend"] = true;
	AL["Winterfin Retreat"] = "Retiro Aleta Invernal";

	--Recipe origin strings
	AL["Trainer"] = "Instructor";
	AL["Discovery"] = "Descubierto";
	AL["World Drop"] = "Botín del Mundo";
	AL["Drop"] = "Botín"; 
	AL["Vendor"] = "Vendedor";
	AL["Crafted"] = "Fabricado";

	--Set Labels
	AL["AQ40 Class Sets"] = "Conjuntos por Clase de AQ40";
	AL["AQ20 Class Sets"] = "Conjuntos por Clase de AQ20";
	AL["AQ Enchants"] = "Encantamientos AQ";
	AL["AQ Opening Quest Chain"] = "Apertura de la misión de la cadena AQ";
	AL["Misc Sets"] = "Conjuntos varios";
	AL["Scholomance Sets"] = "Conjuntos Scholomance";
	AL["Crafted Sets"] = "Conjuntos fabricados";
	AL["Crafted Epic Weapons"] = "Armas épicas fabricadas";
	AL["Dungeon Set 1"] = "Conjunto de Mazmorra 1";
	AL["Dungeon Set 2"] = "Conjunto de Mazmorra 2";
	AL["Dungeon Set 3"] = "Conjunto de Mazmorra 3";	
	AL["PvP Misc"] = "Diseños Joyería JcJ";
	AL["PvP Rewards"] = "Recompen. JcJ";
	AL["PvP Armor Sets"] = "Conjuntos de armaduras JcJ";
	AL["PvP Weapons"] = "Armas JcJ";
	AL["PvP Accessories"] = "Accesorios JcJ";
	AL["PvP Non-Set Epics"] = "Épicos JcJ No-Conjuntos";
	AL["PvP Reputation Sets"] = "Conjuntos JcJ por reputación";
	AL["Arathi Basin Sets"] = "Conjuntos de Cuenca de Arathi";
	AL["Tribute Run"] = "Homenaje de carrera";
	AL["Dire Maul Books"] = "Libros de La Masacre";
	AL["Random Boss Loot"] = "Botín de jefes aleatorios";
	AL["Epic Set"] = "Conjunto épico";
	AL["Rare Set"] = "Conjunto raro";
	AL["Legendary Items"] = "Objetos legendários";
	AL["Accessories"] = "Accesorios";
	AL["Fire Resistance Gear"] = "Equipamientos con resistencia al fuego";
	AL["Arcane Resistance Gear"] = "Equipamientos con resistencia a lo arcano";
	AL["Nature Resistance Gear"] = "Equipamientos con resistencia a la naturaleza";
	AL["Frost Resistance Gear"] = "Equipamientos con resistencia al hielo";
	AL["Shadow Resistance Gear"] = "Equipamientos con resistencia a las sombras";
	AL["BoE World Epics"] = "Épicos del mundo BoE";
	AL["Level 30-39"] = "Niveles 30-39";
	AL["Level 40-49"] = "Niveles 40-49";
	AL["Level 50-60"] = "Niveles 50-60";
	AL["Patterns/Plans"] = "Recetas/Planos";
	AL["Additional Heroic Loot"] = "Botin heróico adicional";

	--Pets
	AL["Pets"] = "Mascotas";
	--AL["Vanity Pets"] = "Mascotas No-Combate"; --changed

	--Mounts
	AL["Card Game Mounts"] = "Monturas Barajas";
	AL["Crafted Mounts"] = "Monturas fabricadas";
	AL["Event Mounts"] = "Monturas de eventos";
	AL["PvP Mounts"] = "JcJ Monturas";
	AL["Rare Mounts"] = "Monturas raras";

	--Specs
	AL["Balance"] = "Equilibrio";
	AL["Feral"] = "Combate Feral";
	AL["Restoration"] = "Restauración";
	AL["Holy"] = "Sagrado";
	AL["Protection"] = "Protección";
	AL["Retribution"] = "Reprensión";
	AL["Shadow"] = "Sombras";
	--AL["Elemental"] = true,
	AL["Enhancement"] = "Mejora";
	AL["Fury"] = "Furia";
	AL["Demonology"] = "Demonología";
	AL["Destruction"] = "Destrucción";
	AL["Tanking"] = "Tanque";
	--AL["DPS"] = true,
	--Naxx Zones
	AL["Construct Quarter"] = "El Arrabal de los Ensamblajes";
	AL["Arachnid Quarter"] = "El Arrabal Arácnido";
	AL["Military Quarter"] = "El Arrabal Militar";
	AL["Plague Quarter"] = "El Arrabal de la Peste";
	--AL["Frostwyrm Lair"] = "Frostwyrm Lair"; --FALTA

	--NPCs missing from BabbleBoss
	AL["Trash Mobs"] = "Bichos varios";
	AL["Dungeon Set 2 Summonable"] = "Invocación Conjunto de mazmorra 2";
	--AL["Theldren"] = true,
	AL["Sothos and Jarien"] = "Sothos y Jarien";
	AL["Druid of the Fang"] = "Druida del Colmillo";
	AL["Defias Strip Miner"] = "Cantero Defias";
	AL["Defias Overseer/Taskmaster"] = "Sobrestante/Capataz Defias";
	AL["Scarlet Trainee"] = "Practicante Escarlata";
	AL["Shadowforge Flame Keeper"] = "Vigilante de la Llama Forjatiniebla";
	AL["Avatar of the Martyred"] = "Avatar de los Martirizados";
	AL["Nexus Stalker"] = "Acechador nexo";
	AL["Auchenai Monk"] = "Monje Auchenai";
	AL["Cabal Fanatic"] = "Fanático de la Cábala";
	AL["Unchained Doombringer"] = "Fatídico desencadenado";
	AL["Crimson Sorcerer"] = "Hechicero Carmesí";
	AL["Thuzadin Shadowcaster"] = "Taumaturgo oscuro Thuzadin";
	AL["Crimson Inquisitor"] = "Inquisidor Carmesí";
	AL["Crimson Battle Mage"] = "Mago de batalla Carmesí";
	AL["Ghoul Ravener"] = "Cuervoso necrófago";
	AL["Spectral Citizen"] = "Ciudadano espectral";
	AL["Spectral Researcher"] = "Investigador espectral";
	AL["Scholomance Adept"] = "Adepto de Scholomance";
	AL["Scholomance Dark Summoner"] = "Invocador Oscuro de Scholomance";
	AL["Blackhand Elite"] = "Élite Puño Negro";
	AL["Firebrand Pyromancer"] = "Piromántico Pirotigma";
	AL["Firebrand Invoker"] = "Convocador Pirotigma";
	AL["Firebrand Grunt"] = "Bruto Pirotigma";
	AL["Firebrand Legionnaire"] = "Legionario Pirotigma";
	AL["Spirestone Warlord"] = "Señor de la Guerra Cumbrerroca";
	AL["Spirestone Mystic"] = "Místico Cumbrerroca";
	AL["Anvilrage Captain"] = "Capitán Yunque Colérico";
	AL["Anvilrage Marshal"] = "Alguacil de Yunque Colérico";
	AL["Doomforge Arcanasmith"] = "Arcanorrero de la Forja Maldita";
	AL["Weapon Technician"] = "Técnico de armas";
	AL["Doomforge Craftsman"] = "Artesano de la Forja Maldita";
	AL["Murk Worm"] = "Gusano de la oscuridad";
	AL["Raging Skeleton"] = "Esqueleto enfurecido";
	AL["Ethereal Priest"] = "Sacerdote etéreo";
	AL["Sethekk Ravenguard"] = "Guardia cuervo Sethekk";
	AL["Time-Lost Shadowmage"] = "Mago de las Sombras Tiempo Perdido";
	AL["Coilfang Sorceress"] = "Hechicera Colmillo Torcido";
	AL["Coilfang Oracle"] = "Oráculo Colmillo Torcido";
	AL["Shattered Hand Centurion"] = "Centurión Mano Destrozada";
	AL["Eredar Deathbringer"] = "Libramorte Eredar";
	AL["Arcatraz Sentinel"] = "Centinela de Arcatraz";
	AL["Gargantuan Abyssal"] = "Abissal inmenso";
	AL["Sunseeker Botanist"] = "Botánica Buscasol";
	AL["Sunseeker Astromage"] = "Astromago Buscasol";
	AL["Durnholde Rifleman"] = "Fusilero de Durnholde";
	AL["Rift Keeper/Rift Lord"] = "Vigilante/Señor de la falla";
	AL["Crimson Templar"] = "Templario Carmesí";
	AL["Azure Templar"] = "Templario azur";
	AL["Hoary Templar"] = "Templario vetusto";
	AL["Earthen Templar"] = "Templario de tierra";
	AL["The Duke of Cynders"] = "Duque de las Brasas";
	AL["The Duke of Fathoms"] = "Duque de las Profundidades";
	AL["The Duke of Zephyrs"] = "Duque de los Céfiros";
	AL["The Duke of Shards"] = "Duque de las Esquirlas";
	AL["Aether-tech Assistant"] = "Ayudante técnico aether";
	AL["Aether-tech Adept"] = "Aether-tech Adept"; --FALTA
	AL["Aether-tech Master"] = "Aether-tech Master"; --FALTA
	AL["Smokywood Pastures Vendor"] = "Vendedor de Pastos de Bosquehumeante";
	AL["Bash'ir Landing Stasis Chambers"] = "Cámaras de éxtasis del Alot Bash'ir";
	AL["Templars"] = "Templarios";
	AL["Dukes"] = "Duques";
	AL["High Council"] = "Consejero mayor";
	AL["Scarshield Quartermaster"] = "Intendente del Escudo del Estigma";
	AL["Father Flame"] = "Padre llama";
	--AL["Thomas Yance"] = true,
	AL["Knot Thimblejack"] = "Knot Thimblejack";
	AL["Shen'dralar Provisioner"] = "Proveedor Shen'dralar";
	AL["The Nameles Prophet"] = "El profeta sin nombre";
	AL["Rajaxx's Captains"] = "Capitanes de Rajaxx";
	AL["Razorfen Spearhide"] = "Lanceur de Tranchebauge";
	AL["Magregan Deepshadow"] = "Magregan Sombraprofunda";
	--AL["Don Carlos"] = true,
	AL["Aged Dalaran Wizard"] = "Zahorí de Dalaran envejecido";
	AL["Felsteed"] = "Corcel vil";
	AL["Shattered Hand Executioner"] = "Verdugo Mano Destrozada";	 

	-- Zone related strings
	-- AL["Azeroth"] = true;
	AL["Blackrock Mountain"] = "Montaña Roca Negra";
	AL["Caverns of Time"] = "Cavernas del Tiempo";
	AL["Darkmoon Island"] = "Isla Luna Negra";
	AL["East"] = "Este";
	AL["North"] = "Norte";
	AL["West"] = "Oeste";

	--Shortcuts for Bossname files
	--AL["Avatar"] = true,	

	--Chests, etc
	AL["The Secret Safe"] = "El secreto seguro";
	AL["The Vault"] = "La caja fuerte";
	AL["Ogre Tannin Basket"] = "Cesta de Ogro Tanino";
	AL["Unfinished Painting"] = "Pintura sin terminar"; --Comprobar
	AL["Felvine Shard"] = "Fragmento de gangrevid";
	AL["Gift of Adoration"] = "Ofrenda de adoración";
	AL["Treat Bag"] = "Bolsa de premios";
	AL["Timed Reward Chest"] = "Cofre de recompensa con tiempo"; --Comprobar
	AL["Timed Reward Chest 1"] = "Cofre de recompensa con tiempo 1";
	AL["Timed Reward Chest 2"] = "Cofre de recompensa con tiempo 2";
	AL["Timed Reward Chest 3"] = "Cofre de recompensa con tiempo 3";
	AL["The Talon King's Coffer"] = "El cofre del Rey Talon";
	AL["Krom Stoutarm's Chest"] = "Tesoro de Krom Rudebras";
	AL["Garrett Family Chest"] = "Tesoro de la familia Garrett";
	AL["Reinforced Fel Iron Chest"] = "Cofre reforzado de hierro vil";
	AL["DM North Tribute Chest"] = "Cofre del tributo de LM norte";
	AL["The Saga of Terokk"] = "La Saga de Terokk";
	AL["First Fragment Guardian"] = "Guardián del primer trozo";
	AL["Second Fragment Guardian"] = "Guardián del segundo trozo";
	AL["Third Fragment Guardian"] = "Guardián del tercer trozo";
	AL["Overcharged Manacell"] = "Célula de maná sobrecargada";

	--World Events
	AL["Abyssal Council"] = "Consejo abisal";
	AL["Bash'ir Landing Skyguard Raid"] = "Punto de anclaje de Bash'ir";
	AL["Brewfest"] = "Fiesta de la Cerveza";
	AL["Children's Week"] = "Semana de los niños";
	AL["Ethereum Prison"] = "Prisión de los Etereum";
	AL["Feast of Winter Veil"] = "Festival de Invierno";
	AL["Gurubashi Arena Booty Run"] = "El cofre pirata de Gurubashi";
	AL["Hallow's End"] = "Halloween";
	AL["Harvest Festival"] = "Festival de la Cosecha";
	AL["Love is in the Air"] = "Amor en el aire";
	AL["Lunar Festival"] = "Festival Lunar";
	AL["Midsummer Fire Festival"] = "Festival del Solsticio de Verano";
	AL["Noblegarden"] = "El jardín de los nobles";
	AL["Skettis"] = "Skettis";
	AL["Stranglethorn Fishing Extravaganza"] = "Concurso de Pesca";
--	AL["Argent Tournament"] = "Torneo Argenta"; -- duplicated

	--Help Frame
	AL["Help"] = "Ayuda";
	AL["AtlasLoot Help"] = "Ayuda Atlasloot";
	AL["For further help, see our website and forums: "] = "Para mas ayuda consulta nuestra web y foros: ";
	AL["How to open the standalone Loot Browser:"] = "Como abrir el buscador de botín estandar:";
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = "Si tienes AtlasLootFu activado, haz click en el botón del minimapa, o alternativamente en algún botón generado por otro addon como Titan o FuBar.  Finalmente, puedes escribir '/al' en la ventana del chat.";
	AL["How to view an 'unsafe' item:"] = "Como ver un objeto 'no seguro':";
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = "Los objetos no seguros tienen un borde rojo alrededor de su icono y son marcados porque no has visto dicho objeto en el juego desde el último parche o reinicio de servidor. Haz click-dcho en el objeto y después mueve el cursor por encima del icono o haz click en 'pregunta al servidor' en el pie de la ventana de botín.";
	AL["How to view an item in the Dressing Room:"] = "Como ver un objeto en la ventana del provador:";
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = "Simplemente haz click Ctrl+Izdo en el objeto.  Algunas veces la ventana del provador está escondida detrás de las ventanas del Atlas o del Atlasloot por lo que si ves que no pasa nada, mueve tu ventana del Atlas y del Atlasloot.";
	AL["How to link an item to someone else:"] = "Como enlazar un objeto a otra persona:";
	AL["Shift+Left Click the item like you would for any other in-game item"] = "Haz lick Shift+izdo en el objeto como harías con cualquier otro objeto del juego";
	AL["How to add an item to the wishlist:"] = "Como añadir un objeto a la lista deseada:";
	AL["Alt+Left Click any item to add it to the wishlist."] = "Haz click Alt+izdo en el objeto que quieres añadir a la lista.";
	AL["How to delete an item from the wishlist:"] = "Como eliminar un objeto de la lista deseada:";
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = "Mientras estás en la ventana de la lista deseada, solo tienes que hacer click Alt+izdo en el objeto a borrar.";
	AL["What else does the wishlist do?"] = "¿Que mas hace la lista deseada?";
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = "Si haces click izquierdo en un objeto de tu lista deseada, puedes saltar a la ventana de botín de donde proviene.  Del mismo modo, los objetos que se encuentran en tu lista aparecen marcados con una estrella amarilla.";
	AL["HELP!! I have broken the mod somehow!"] = "¡¡AYUDA!! De alguna manera he roto el addon";
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = "Utiliza los botones de reinicio disponibles en el menú de opciones o escribe '/al reset' en tu ventana de chat.";
end