
local L = LibStub("AceLocale-3.0"):NewLocale("TellMeWhen", "esES", false)
if not L then return end


L["ABSORBAMT"] = "Cantidad de escudos de absorción"
L["ABSORBAMT_DESC"] = "Comprueba la cantidad total de escudos de absorción que tiene la unidad.  "
L["ACTIVE"] = "%d Activo"
L["AIR"] = "Aire"
L["ALLOWCOMM"] = "Permitir compartir en el juego"
L["ALLOWCOMM_DESC"] = "Permitir a otros usuarios de TellMeWhen enviarle datos. "
L["ALLOWVERSIONWARN"] = "Notificar de nueva versión"
L["ALPHA"] = "Alfa"
L["ALWAYSSUBLINKS"] = "Siempre Sustituir Enlaces"
L["ALWAYSSUBLINKS_DESC"] = "Por defecto, los enlaces de hechizo/objeto sólo serán sustituidos en las salidas de eventos de texto. Marque este ajuste para provocar que los enlaces sean sustituidos en cualquier sitio, incluyendo texto de enlace/etiqueta de icono."
L["ANCHORTO"] = "Anclar a"
L["ANIM_ACTVTNGLOW"] = "Icono: Borde de Activación"
L["ANIM_ACTVTNGLOW_DESC"] = "Muestra el borde de activación de hechizo de Blizzard en el icono. "
L["ANIM_ALPHASTANDALONE"] = "Alfa"
L["ANIM_ALPHASTANDALONE_DESC"] = "Establece la opacidad máxima de la animación."
L["ANIM_ANCHOR_NOT_FOUND"] = "No se encontró el marco llamado %q para anclar la animación. ¿Quizá este marco no se usa por la vista actual del icono?"
L["ANIM_ANIMSETTINGS"] = "Ajustes"
L["ANIM_ANIMTOUSE"] = "Animación A Usar"
L["ANIM_COLOR"] = "Color/Opacidad"
L["ANIM_COLOR_DESC"] = "Configurar el color y la opacidad del destello."
L["ANIM_DURATION"] = "Duración de Animación"
L["ANIM_DURATION_DESC"] = "Establece cuánto debería durar la animación tras ser activada. "
L["ANIM_FADE"] = "Desvanecer Destellos"
L["ANIM_FADE_DESC"] = "Marque para que haya un desvanecimiento suave entre cada destello. Desmarque para destellar instantáneamente."
L["ANIM_ICONALPHAFLASH"] = "Icono: Destello Alfa"
L["ANIM_ICONALPHAFLASH_DESC"] = "Destella el propio icono cambiando su opacidad. "
L["ANIM_ICONBORDER"] = "Icono: Borde"
L["ANIM_ICONBORDER_DESC"] = "Superpone un borde coloreado al icono. "
L["ANIM_ICONCLEAR"] = "Icono: Detener Animacions"
L["ANIM_ICONCLEAR_DESC"] = "Detiene todas las animaciones que se están reproduciendo en el icono actual. "
L["ANIM_ICONFADE"] = "Icono: Desvanecerse/Aparecer "
L["ANIM_ICONFADE_DESC"] = "Aplica suavemente cualquier cambio de opacidad sucedido con el evento seleccionado. "
L["ANIM_ICONFLASH"] = "Icono: Destello de Color"
L["ANIM_ICONFLASH_DESC"] = "Hace pasar una transparencia coloreada a través del icono."
L["ANIM_ICONOVERLAYIMG"] = "Icono: Superponer Imagen"
L["ANIM_ICONOVERLAYIMG_DESC"] = "Superpone una imagen personalizada sobre el icono."
L["ANIM_ICONSHAKE"] = "Icono: Agitar"
L["ANIM_ICONSHAKE_DESC"] = "Agita el icono cuando se activa. "
L["ANIM_INFINITE"] = "Reproducir Indefinidamente"
L["ANIM_INFINITE_DESC"] = "Marque para hacer que la animación se reproduzca hasta que sea sobrescrita por otra animación en el icono del mismo tipo, o hasta que la animación %q sea reproducida. "
L["ANIM_MAGNITUDE"] = "Magnitud de Agitado"
L["ANIM_MAGNITUDE_DESC"] = "Establece cuán violento debería ser el agitado."
L["ANIM_PERIOD"] = "Período de Destello"
L["ANIM_PERIOD_DESC"] = [=[Establece cuánto tiempo dura cada destello - el tiempo durante el cual el destello es mostrado o fundido.

Establezca a 0 si no quiere que haya destellos o fundidos. ]=]
L["ANIM_PIXELS"] = "%s Píxels"
L["ANIM_SCREENFLASH"] = "Pantalla: Destello"
L["ANIM_SCREENFLASH_DESC"] = "Pasa rápidamente una transparencia coloreada a través de la pantalla."
L["ANIM_SCREENSHAKE"] = "Pantalla: Agitar"
L["ANIM_SCREENSHAKE_DESC"] = [=[Agita la pantalla entera cuando se activa. 

NOTA: Esto sólo funcionará si está o bien fuera de combate o bien si las placas de nombre no se han activado en absoluto desde que se conectó. ]=]
L["ANIM_SECONDS"] = "%s Segundos"
L["ANIM_SIZE_ANIM"] = "Tamaño Inicial de Borde"
L["ANIM_SIZE_ANIM_DESC"] = "Establece cuánto de grande debería ser el borde entero. "
L["ANIM_SIZEX"] = "Ancho de Imagen"
L["ANIM_SIZEX_DESC"] = "Establece cuánto de ancha debería ser la imagen."
L["ANIM_SIZEY"] = "Altura de Imagen"
L["ANIM_SIZEY_DESC"] = "Establece cuándo de alta debería ser la imagen."
L["ANIM_TAB"] = "Animación"
L["ANIM_TEX"] = "Textura"
L["ANIM_TEX_DESC"] = [=[Escoja la textura que debería ser superpuesta. 

Puede introducir el Nombre o ID de un hechizo que tiene la textura que quiere utilizar, o puede introducir una ruta de textura, como 'Interface/Icons/spell_nature_healingtouch', o simplemente 'spell_nature_healingtouch' si la ruta es 'Interface/Icons'

También puede utilizar sus propias texturas siempre que estén situadas en el directorio de WoW (establezca este campo a la tura de la textura relativa a la carpeta raíz de WoW), sean formato .tga o .blp, y tengan dimensiones que sean potencias de 2 (32, 64, 128, etc)]=]
L["ANIM_THICKNESS"] = "Grosor del Borde"
L["ANIM_THICKNESS_DESC"] = "Establece el grosor del borde."
L["ANN_CHANTOUSE"] = "Canal a Usar"
L["ANN_EDITBOX"] = "Texto para dirigir a salida"
L["ANN_EDITBOX_DESC"] = "Escriba el texto que quiera que pase a la salida cuando se active el evento"
L["ANN_EDITBOX_WARN"] = "Escriba aquí el texto que quiera que pase a la salida"
L["ANN_EVENT_GLOBALDESC"] = "Los eventos se comprueban de arriba abajo en esta lista. Si se activa un evento que tiene texto para dirigir a salida, ningún evento por debajo de éste dirigirá a salida texto alguno. "
L["ANN_FCT_DESC"] = "Dirige la salida a la característica de Blizzard Texto Flotante de Combate. DEBE estar habilitada en sus opciones de interfaz para que el texto sea dirigido a ella."
L["ANN_NOTEXT"] = "<Sin Texto>"
L["ANN_SHOWICON"] = "Mostrar textura de icono"
L["ANN_SHOWICON_DESC"] = "Algunos destinos de texto pueden mostrar una textura junto con el texto. Marque esto para activar esta característica. "
L["ANN_STICKY"] = "Adhesivo"
L["ANN_SUB_CHANNEL"] = "Sub sección"
L["ANN_TAB"] = "Texto"
L["ANN_WHISPERTARGET"] = "Susurrar al objetivo"
L["ANN_WHISPERTARGET_DESC"] = [=[Introduzca el nombre del jugador al que le gustaría susurrar. 

Se aplican los requisitos normales de servidor/facción.]=]
L["ASCENDING"] = "Ascendiendo"
L["ASPECT"] = "Aspecto"
L["AURA"] = "Aura"
L["BACK_IE"] = "Atrás"
L["BACK_IE_DESC"] = "Carga el último icono que fue editado (%s |T%s:0|t)." -- Needs review
L["Bleeding"] = "Sangrando"
L["BonusStamina"] = "Aguante Aumentado"
L["BOTTOM"] = "Abajo"
L["BOTTOMLEFT"] = "Abajo Izquierda"
L["BOTTOMRIGHT"] = "Abajo Derecha"
L["BUFFCNDT_DESC"] = "Sólo el primer hechizo será comprobado, todos los demás serán ignorados. "
L["BUFFTOCHECK"] = "Ventaja a Comprobar"
L["BUFFTOCOMP1"] = "Primera Ventaja a Comparar"
L["BUFFTOCOMP2"] = "Segunda Ventaja a Comparar"
L["BURNING_EMBERS_FRAGMENTS"] = "\"Fragmentos\" de Ascuas ardientes"
L["BURNING_EMBERS_FRAGMENTS_DESC"] = [=[Cada Ascua ardiente completa consiste en 10 fragmentos. 

Si tiene 1 ascua entera y otra media ascua, por ejemplo, entonces tiene 15 fragmentos.]=]
L["BurstManaRegen"] = "Regeneración Explosiva de Maná"
L["CACHING"] = [=[TellMeWhen está almacenando y filtrando todos los hechizos del juego. Sólo es necesario hacer esto una vez por parche de WoW. Puede acelerar o ralentizar este proceso usando la barra deslizante inferior. 

No tiene que esperar a que se complete este proceso para usar TellMeWhen. Sólo la lista de sugerencias depende de la finalización del almacenamiento de los hechizos. ]=]
L["CACHINGSPEED"] = "Hechizos por marco:"
L["CASTERFORM"] = "Forma de Lanzador de Hechizos"
L["CENTER"] = "Centro"
L["CHAT_FRAME"] = "Marco de Chat"
L["CHAT_MSG_CHANNEL"] = "Canal de Chat"
L["CHAT_MSG_CHANNEL_DESC"] = "Dirigirá la salida a un canal de chat, como Comercio, o a un canal personalizado al que se ha unido."
L["CHAT_MSG_SMART"] = "Canal Inteligente"
L["CHAT_MSG_SMART_DESC"] = "Dirigirá la salida al canal Campo de Batalla, Banda, Grupo o Decir - lo que sea apropiado. "
L["CHECKORDER"] = "Actualizar Orden"
L["CHECKORDER_GROUPDESC"] = "Establece el orden en que los grupos serán actualizados. Esto sólo es de importancia si está usando la característica de meta iconos para comprobar sub-metas. "
L["CHECKORDER_ICONDESC"] = "Establece el orden en que los iconos dentro de este grupo serán actualizados. Esto sólo es de importancia si está usando la característica de meta iconos para comprobar sub-metas. "
L["CHOOSEICON"] = "Eliga un icono a comprobar"
L["CHOOSEICON_DESC"] = [=[|cff7fffffClick|r para elegir un icono/grupo.
|cff7fffffClick-Izquierdo y arrastrar|r para reordenar.
|cff7fffffClick-Derecho y arrastrar|r para intercambiar.]=]
L["CHOOSENAME_DIALOG"] = [=[Introduzca el Nombre o ID de lo que quiera que vigile este icono. Puede añadir múltiples entradas (cualquier combinación de nombres, IDs y equivalentes) separándolas con punto y coma (;)

Haga |cff7fffffShift-click|r en hechizos/objetos/enlaces de chat o arrastre hechizos/objetos para insertarlos en esta caja de texto.]=]
L["CHOOSENAME_DIALOG_DDDEFAULT"] = "Conjuntos de Hechizos/Tipos de Disipación Predefinidos"
L["CHOOSENAME_DIALOG_MSCD"] = "Introduzca el Nombre o ID de lo que quiere que este icono compruebe. Sólo el primer hechizo/objeto será comprobado - Las listas delimitadas por punto y coma no son válidas para este tipo de icono. "
L["CHOOSENAME_DIALOG_PETABILITIES"] = "Se deben usar IDs de hechizo para las |cFFFF5959HABILIDADES DE MASCOTA|r "
L["CLEU_"] = "Cualquier evento"
L["CLEU_CAT_AURA"] = "Ventajas/Desventajas"
L["CLEU_CAT_CAST"] = "Lanzamientos"
L["CLEU_CAT_MISC"] = "Varios"
L["CLEU_CAT_SPELL"] = "Hechizos"
L["CLEU_CAT_SWING"] = "Cuerpo a Cuerpo/A Distancia"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MASK"] = "Relación de Controlador"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MINE"] = "Relación de Controlador: Jugador (Usted)"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MINE_DESC"] = "Marque para excluir unidades que están controladas por usted"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_OUTSIDER"] = "Relación de Controlador: Forasteros"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_OUTSIDER_DESC"] = "Marque para excluir unidades que son controladas por alguien que no está en su grupo"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_PARTY"] = "Relación de Controlador: Miembros del Grupo"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_PARTY_DESC"] = "Marque para excluir unidades que son controladas por un miembro de su grupo"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_RAID"] = "Relaciones de Controlador: Miembros de la Banda"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_RAID_DESC"] = "Marque para excluir unidades controladas por alguien que está en su grupo de banda. "
L["CLEU_COMBATLOG_OBJECT_CONTROL_MASK"] = "Controlador"
L["CLEU_COMBATLOG_OBJECT_CONTROL_NPC"] = "Controlador: Servidor"
L["CLEU_COMBATLOG_OBJECT_CONTROL_NPC_DESC"] = "Marque para excluir unidades que son controladas por el servidor, incluyendo sus mascotas y guardianes. "
L["CLEU_COMBATLOG_OBJECT_CONTROL_PLAYER"] = "Controlador: Humano"
L["CLEU_COMBATLOG_OBJECT_CONTROL_PLAYER_DESC"] = "Marque para excluir unidades controladas por seres humanos, incluyendo sus mascotas y guardianes. "
L["CLEU_COMBATLOG_OBJECT_FOCUS"] = "Varios: Su Foco"
L["CLEU_COMBATLOG_OBJECT_FOCUS_DESC"] = "Marque para excluir la unidad que tiene establecida como su foco"
L["CLEU_COMBATLOG_OBJECT_MAINASSIST"] = "Varios: Asistente Principal"
L["CLEU_COMBATLOG_OBJECT_MAINASSIST_DESC"] = "Marque para excluir unidades marcadas como asistentes principales en su banda"
L["CLEU_COMBATLOG_OBJECT_MAINTANK"] = "Varios: Tanque Principal"
L["CLEU_COMBATLOG_OBJECT_MAINTANK_DESC"] = "Marque para excluir unidades marcadas como tanques principales en su banda"
L["CLEU_COMBATLOG_OBJECT_NONE"] = "Varios: Unidad Desconocida"
L["CLEU_COMBATLOG_OBJECT_NONE_DESC"] = "Marque para excluir unidades que son completamente desconocidas al cliente de WoW. Esto sucede muy raras veces, y puede en general dejarse desmarcado. "
L["CLEU_COMBATLOG_OBJECT_REACTION_FRIENDLY"] = "Reacción de Unidad: Amistosa"
L["CLEU_COMBATLOG_OBJECT_REACTION_FRIENDLY_DESC"] = "Marque para excluir unidades que son amistosas hacia usted."
L["CLEU_COMBATLOG_OBJECT_REACTION_HOSTILE"] = "Reacción de Unidad: Hostil"
L["CLEU_COMBATLOG_OBJECT_REACTION_HOSTILE_DESC"] = "Marque para excluir unidades que son hostiles hacia usted. "
L["CLEU_COMBATLOG_OBJECT_REACTION_MASK"] = "Reacción de Unidad"
L["CLEU_COMBATLOG_OBJECT_REACTION_NEUTRAL"] = "Reacción de Unidad: Neutral"
L["CLEU_COMBATLOG_OBJECT_REACTION_NEUTRAL_DESC"] = "Marque para excluir unidades que son neutrales hacia usted. "
L["CLEU_COMBATLOG_OBJECT_TARGET"] = "Varios: Su objetivo"
L["CLEU_COMBATLOG_OBJECT_TARGET_DESC"] = "Marque para excluir a la unidad a la que está apuntando. "
L["CLEU_COMBATLOG_OBJECT_TYPE_GUARDIAN"] = "Tipo de Unidad: Guardián"
L["CLEU_COMBATLOG_OBJECT_TYPE_GUARDIAN_DESC"] = "Marque para excluir Guardianes. Los Guardianes son unidades que defienden a su controlador pero no pueden ser controladas directamente. "
L["CLEU_COMBATLOG_OBJECT_TYPE_MASK"] = "Tipo de Unidad"
L["CLEU_COMBATLOG_OBJECT_TYPE_NPC"] = "Tipo de Unidad: PNJ"
L["CLEU_COMBATLOG_OBJECT_TYPE_NPC_DESC"] = "Marque para excluir personajes no jugadores. "
L["CLEU_COMBATLOG_OBJECT_TYPE_OBJECT"] = "Tipo de Unidad: Objeto"
L["CLEU_COMBATLOG_OBJECT_TYPE_OBJECT_DESC"] = "Marque para excluir unidades como trampas, corchos de pesca, o cualquier otra cosa que no entre en las otras categorías de \"Tipo de Unidad\""
L["CLEU_COMBATLOG_OBJECT_TYPE_PET"] = "Tipo de Unidad: Mascota"
L["CLEU_COMBATLOG_OBJECT_TYPE_PET_DESC"] = "Marque para excluir Mascotas. Las Mascotas son unidades que defienden a su controlador y pueden ser controladas directamente. "
L["CLEU_COMBATLOG_OBJECT_TYPE_PLAYER"] = "Tipo de Unidad: Personaje Jugador"
L["CLEU_COMBATLOG_OBJECT_TYPE_PLAYER_DESC"] = "Marque para excluir personajes jugadores. "
L["CLEU_DAMAGE_SHIELD"] = "Escudo de daño"
L["CLEU_DAMAGE_SHIELD_DESC"] = "Sucede cuando un escudo de daño (%s, %s, etc., pero no %s) daña una unidad"
L["CLEU_DAMAGE_SHIELD_MISSED"] = "Escudo de Daño Falló"
L["CLEU_DAMAGE_SHIELD_MISSED_DESC"] = "Sucede cuando un escudo de daño (%s, %s, etc., pero no %s), no consigue dañar a una unidad."
L["CLEU_DAMAGE_SPLIT"] = "Daño Dividido"
L["CLEU_DAMAGE_SPLIT_DESC"] = "Sucede cuando se divide el daño entre dos o más objetivos. "
L["CLEU_DESTUNITS"] = "Unidad(es) destino a comprobar"
L["CLEU_DESTUNITS_DESC"] = "Elija las unidades destino a las que quiere que reaccione el icono, |cff7fffffO|r deje esto en blanco para permitir al icono reaccionar a cualquier destino de evento. "
L["CLEU_DIED"] = "Muerte"
L["CLEU_ENCHANT_APPLIED"] = "Encantamiento Aplicado"
L["CLEU_ENCHANT_APPLIED_DESC"] = "Cubre encantamientos temporales de arma como los venenos de pícaro y los imbuir de chamán. "
L["CLEU_ENCHANT_REMOVED"] = "Encantamiento Eliminado"
L["CLEU_ENCHANT_REMOVED_DESC"] = "Cubre encantamientos temporales de arma como los venenos de pícaro y los imbuir de chamán. "
L["CLEU_ENVIRONMENTAL_DAMAGE"] = "Daño Ambiental"
L["CLEU_ENVIRONMENTAL_DAMAGE_DESC"] = "Incluye daño de lava, fatiga, ahogamiento y caídas. "
L["CLEU_EVENTS"] = "Eventos a comprobar"
L["CLEU_EVENTS_ALL"] = "Todo"
L["CLEU_EVENTS_DESC"] = "Elija los eventos de combate a los que quiere que reaccione el icono"
L["CLEU_FLAGS_DESC"] = "Contiene una lista de atributos que pueden ser usados para que ciertas unidades no activen el icono. Si una exclusión está marcada, y una unidad tiene ese atributo, el icono no procesará el evento del que la unidad formaba parte. "
L["CLEU_FLAGS_DEST"] = "Exclusiones"
L["CLEU_FLAGS_SOURCE"] = "Exclusiones"
L["CLEU_HEADER"] = "Filtros de Eventos de Combate"
L["CLEU_NOFILTERS"] = "El icono %s en %s no tiene ningún filtro definido. No funcionará hasta que defina al menos un filtro. "
L["CLEU_PARTY_KILL"] = "Muerte de Grupo"
L["CLEU_PARTY_KILL_DESC"] = "Sucede cuando alguien en su grupo mata algo."
L["CLEU_RANGE_DAMAGE"] = "Daño a Distancia"
L["CLEU_RANGE_MISSED"] = "Fallo a Distancia"
L["CLEU_SOURCEUNITS"] = "Unidad(es) fuente a comprobar"
L["CLEU_SOURCEUNITS_DESC"] = "Elija las unidades fuente a las que le gustaría que este icono reaccionase,  |cff7fffffO|r deje esto en blanco para permitir al icono reaccionar a cualquier fuente de eventos. "
L["CLEU_SPELL_AURA_APPLIED"] = "Aura Aplicada"
L["CLEU_SPELL_AURA_APPLIED_DOSE"] = "Acumulación de Aura Aplicada"
L["CLEU_SPELL_AURA_BROKEN"] = "Aura Rota"
L["CLEU_SPELL_AURA_BROKEN_SPELL"] = "Aura Rota por Hechizo"
L["CLEU_SPELL_AURA_BROKEN_SPELL_DESC"] = [=[Sucede cuando un aura, habitualmente alguna forma de control de masas, se rompe por daño de un hechizo. 

El icono filtra por el aura que se rompió; el hechizo que la rompió puede accederse con la sustitución [Extra] en los displays de texto. ]=]
L["CLEU_SPELL_AURA_REFRESH"] = "Aura Renovada"
L["CLEU_SPELL_AURA_REMOVED"] = "Aura Eliminada"
L["CLEU_SPELL_AURA_REMOVED_DOSE"] = "Acumulación de Aura Eliminada"
L["CLEU_SPELL_CAST_FAILED"] = "Lanzamiento de Hechizo Fallido"
L["CLEU_SPELL_CAST_START"] = "Comienzo de Lanzamiento de Hechizo"
L["CLEU_SPELL_CAST_START_DESC"] = [=[Sucede cuando un hechizo se comienza a lanzar. 

NOTA: Para prevenir abusos potenciales, Blizzard ha excluido la unidad destino de este evento, de modo que no puede filtrar por ella. ]=]
L["CLEU_SPELL_CAST_SUCCESS"] = "Éxito en Lanzamiento de Hechizo"
L["CLEU_SPELL_CAST_SUCCESS_DESC"] = "Sucede cuando se lanza un hechizo. "
L["CLEU_SPELL_CREATE"] = "Hechizo Crea"
L["CLEU_SPELL_CREATE_DESC"] = "Sucede cuando un objeto, tal como una trampa de cazador o un portal de mago, es creado."
L["CLEU_SPELL_DAMAGE"] = "Daño de Hechizo"
L["CLEU_SPELL_DAMAGE_CRIT"] = "Crítico de Hechizo"
L["CLEU_SPELL_DAMAGE_CRIT_DESC"] = "Sucede cuando cualquier hechizo hace daño crítico. Esto puede suceder al mismo tiempo que el evento %q."
L["CLEU_SPELL_DAMAGE_DESC"] = "Sucede cuando cualquier hechizo hace cualquier daño. "
L["CLEU_SPELL_DISPEL"] = "Disipar"
L["CLEU_SPELL_DISPEL_DESC"] = [=[Sucede cuando un aura es disipada. 

El icono filtra por el aura que fue disipada; el hechizo que la disipó puede accederse con la sustitución [Extra] en los displays de texto. ]=]
L["CLEU_SPELL_DISPEL_FAILED"] = "Disipar Fallido"
L["CLEU_SPELL_DISPEL_FAILED_DESC"] = [=[Sucede cuando un aura no se pudo dispersar. 

El icono filtra por el aura que se intentó dispersar; el hechizo que lo intentó puede accederse con la sustitución [Extra] en los displays de texto. ]=]
L["CLEU_SPELL_DRAIN"] = "Recurso Drenado"
L["CLEU_SPELL_DRAIN_DESC"] = "Sucede cuando se eliminan recursos (salud/maná/ira/energía/etc) de una unidad. "
L["CLEU_SPELL_ENERGIZE"] = "Recurso Ganado"
L["CLEU_SPELL_ENERGIZE_DESC"] = "Sucede cuando se una unidad gana recursos (salud/maná/ira/energía/etc) "
L["CLEU_SPELL_EXTRA_ATTACKS"] = "Ataques Extra Ganados"
L["CLEU_SPELL_EXTRA_ATTACKS_DESC"] = "Sucede cuando un proc concede ataques extra cuerpo a cuerpo."
L["CLEU_SPELL_HEAL"] = "Sanar"
L["CLEU_SPELL_INSTAKILL"] = "Muerte Instantánea"
L["CLEU_SPELL_INTERRUPT"] = "Interrupción - Hechizo Interrumpido"
L["CLEU_SPELL_INTERRUPT_DESC"] = [=[Ocurre cuando se interrumpe el lanzamiento de un hechizo. 

El icono se puede filtrar por el hechizo que fue interrumpido. El hechizo de interrupción que lo interrupció puede ser accedido con la sustitución [Extra] en los displays de texto. 

Tome nota de la diferencia entre los dos eventos de interrupción - ambos sucederán siempre cuando un hechizo sea interrumpido, pero cada uno filtra los hechizos involucrados de forma diferente. ]=]
L["CLEU_SPELL_INTERRUPT_SPELL"] = "Interrupción - Hechizo de Interrupción Usado"
L["CLEU_SPELL_INTERRUPT_SPELL_DESC"] = [=[Sucede cuando un lanzamiento de hechizo es interrumpido. 

El icono se puede filtrar por el hechizo que causó la interrupción. El hechizo que fue interrumpido puede accederse con la sustitución [Extra] en los displays de texto. 

Tenga en cuenta la diferencia entre los dos eventos de interrupción - ambos sucederán siempre cuando se interrumpa un hechizo, pero cada uno filtra los hechizos involucrados de forma diferente. ]=]
L["CLEU_SPELL_LEECH"] = "Parasitación de Recursos. "
L["CLEU_SPELL_LEECH_DESC"] = "Sucede cuando recursos (salud/maná/ira/energía/etc) son eliminados de una unidad y simultáneamente otorgados a otra."
L["CLEU_SPELL_MISSED"] = "Fallo de Hechizo"
L["CLEU_SPELL_PERIODIC_DAMAGE"] = "Daño Periódico"
L["CLEU_SPELL_PERIODIC_DRAIN"] = "Drenaje de Recurso Periódico"
L["CLEU_SPELL_PERIODIC_ENERGIZE"] = "Ganancia de Recurso Periódica"
L["CLEU_SPELL_PERIODIC_HEAL"] = "Sanación Periódica"
L["CLEU_SPELL_PERIODIC_LEECH"] = "Parasitación Periódica"
L["CLEU_SPELL_PERIODIC_MISSED"] = "Fallo periódico"
L["CLEU_SPELL_REFLECT"] = "Reflejo de Hechizos"
L["CLEU_SPELL_REFLECT_DESC"] = [=[Sucede cuando se refleja un hechizo de vuelta a su lanzador. 

La unidad origen es quienquiera que lo reflejó, la unidad destino es a quienquiera que fuera reflejado de vuelta. ]=]
L["CLEU_SPELL_RESURRECT"] = "Resurrección"
L["CLEU_SPELL_RESURRECT_DESC"] = "Sucede cuando una unidad es resucitada de la muerte. "
L["CLEU_SPELL_STOLEN"] = "Aura Robada"
L["CLEU_SPELL_STOLEN_DESC"] = [=[Sucede cuando una ventaja es robada, probablemente por %s.

El icono se puede filtrar por el hechizo que fue robado. ]=]
L["CLEU_SPELL_SUMMON"] = "Hechizo Invoca"
L["CLEU_SPELL_SUMMON_DESC"] = "Sucede cuando un PNJ, como una mascota o un tótem, es invocado o aparece."
L["CLEU_SWING_DAMAGE"] = "Daño de Golpe"
L["CLEU_SWING_MISSED"] = "Fallo de Golpe"
L["CLEU_TIMER"] = "Temporizador a establecer en el evento"
L["CLEU_TIMER_DESC"] = [=[Duración en segundos del temporizador a establecer en el icono cuando sucede un evento. 

También puede establecer duraciones utilizando la sintaxis "Hechizo: Duración" en el cuadro de edición %q para usar cada vez que un evento es manejado utilizando un hechizo que ha establecido como filtro. 

Si no se define duración para un hechizo, o no tiene ningún filtro de hechizo establecido (el cuadro de edición está en blanco) se usará esta duración. ]=]
L["CLEU_UNIT_DESTROYED"] = "Unidad Destruida"
L["CLEU_UNIT_DESTROYED_DESC"] = "Ocurre cuando una unidad como un tótem es destruida. "
L["CLEU_UNIT_DIED"] = "Unidad Murió"
L["CLEU_WHOLECATEGORYEXCLUDED"] = [=[Ha excluido todas las partes de la categoría %q, lo que provocará que este icono no procese ningún evento. 

Desmarque al menos una para una funcionalidad adecuada. ]=]
L["CMD_DISABLE"] = "deshabilitar"
L["CMD_ENABLE"] = "habilitar"
L["CMD_OPTIONS"] = "Opciones"
L["CMD_PROFILE"] = "perfil"
L["CMD_PROFILE_INVALIDPROFILE"] = "No existe el perfil llamado %q!"
L["CMD_PROFILE_INVALIDPROFILE_SPACES"] = "Consejo: Si el nombre de perfil contiene espacios, escríbalo entre comillas "
L["CMD_TOGGLE"] = "alternar"
L["CNDTCAT_ARCHFRAGS"] = "Fragmentos de Arqueología"
L["CNDTCAT_ATTRIBUTES_PLAYER"] = "Atributos de Jugador"
L["CNDTCAT_ATTRIBUTES_UNIT"] = "Atributos de Unidad"
L["CNDTCAT_BUFFSDEBUFFS"] = "Ventajas/Desventajas"
L["CNDTCAT_CURRENCIES"] = "Monedas"
L["CNDTCAT_FREQUENTLYUSED"] = "Usado Frecuentemente"
L["CNDTCAT_MISC"] = "Varios"
L["CNDTCAT_RESOURCES"] = "Recursos"
L["CNDTCAT_SPELLSABILITIES"] = "Hechizos/Objetos"
L["CNDTCAT_STATS"] = "Estadísticas de Combate"
L["CNDT_ONLYFIRST"] = "Sólo el primer hechizo/objeto será comprobado - listas delimitadas por punto y coma no son válidas para este tipo de condición. "
L["CNDT_SLIDER_DESC_CLICKSWAP_TOMANUAL"] = "|cff7fffffClick-Derecho|r para cambiar a entrada manual. "
L["CNDT_SLIDER_DESC_CLICKSWAP_TOSLIDER"] = "|cff7fffffClick-Derecho|r para cambiar a entrada de deslizador. "
L["CNDT_SLIDER_DESC_CLICKSWAP_TOSLIDER_DISALLOWED"] = "Sólo se permite entrada manual para valores por encima de %s (Los deslizadores de Blizzard pueden comportarse de manera extraña con valores muy grandes.)"
L["CNDT_TOTEMNAME"] = "Nombre(s) de Tótem(s)"
L["CNDT_TOTEMNAME_DESC"] = [=[Deje en blanco para seguir cualquier tótem del tipo seleccionado. 

Introduzca un nombre de tótem, o una lista de nombres separados por punto y coma, para sólo comprobar ciertos tótems. ]=]
L["CODESNIPPET_ADD"] = "Crear nuevo Snippet"
L["CODESNIPPET_CODE"] = "Código Lua a Ejecutar"
L["CODESNIPPET_CODE_DESC"] = "Establece el código Lua que será ejecutado por este snippet cuandeo TellMeWhen se inicialice. "
L["CODESNIPPET_DELETE"] = "Borrar Snippet"
L["CODESNIPPET_DELETE_CONFIRM"] = "¿Está seguro de que quiere borrar el snippet de código %q?"
L["CODESNIPPET_DELETE_DESC"] = [=[Pulse para borrar este snippet de código. 

Mantenga pulsado |cff7fffffCtrl|r para saltar la confirmación. ]=]
L["CODESNIPPET_GLOBAL"] = "Snippets Globales"
L["CODESNIPPET_ORDER"] = "Orden de Ejecución"
L["CODESNIPPET_ORDER_DESC"] = [=[Establece el ordene en que se debería ejecutar este snippet en relación a otros snippets. 

%s y %s se mezclarán basados en este valor cuando sean ejecutados. 

Se admiten cantidades fraccionarias. No se garantiza un orden consistente si dos snippets comparten el mismo orden. ]=]
L["CODESNIPPET_PROFILE"] = "Snippets de Perfil"
L["CODESNIPPET_RENAME"] = "Nombre de Snippet de Código"
L["CODESNIPPET_RENAME_DESC"] = [=[Elija un nombre para este snippet de modo que pueda identificarlo fácilmente. 

Los nombres no tienen que ser únicos. ]=]
L["CODESNIPPET_RUNNOW"] = "Ejecutar Snippet Ahora"
L["CODESNIPPET_RUNNOW_CONFIRM"] = [=[¿Está seguro de que quiere ejecutar el snippet %s de nuevo?

(Ya ha sido ejecutado al menos una vez en esta sesión)

Puede mantener pulsado |cff7fffffCtrl|r mientras pulsa el botón %s para saltar esta confirmación. ]=]
L["CODESNIPPET_RUNNOW_DESC"] = [=[Pulse para ejecutar este snippet de código. 

Mantenga pulsado |cff7fffffCtrl|r para saltar la confirmación si el snippet ya ha sido ejecutado. ]=]
L["CODESNIPPETS"] = "Snippets de Código Lua"
L["CODESNIPPETS_DEFAULTNAME"] = "Nuevo Snippet"
L["CODESNIPPETS_DESC"] = [=[Esta funcionalidad le permite escribir fragmentos de código Lua que serán ejecutados cuando TellMeWhen se esté inicializando. 

Es una funcionalidad avanzapara para aquellos que tienen experiencia con Lua (o para quienes han recibido un snippet por otro usuario de TellMeWhen)

Los usos posibles incluyen escribir funciones personalizadas para usar en condiciones Lua (asegúrese de definir estas en TMW.CNDT.Env).

Los snippets se pueden definir por perfil o globalmente (ejecutarán en todos los perfiles). ]=] -- Needs review
L["CODESNIPPETS_IMPORT_GLOBAL"] = "Nuevo Snippet Global"
L["CODESNIPPETS_IMPORT_GLOBAL_DESC"] = "Importa el snippet como un snippet global."
L["CODESNIPPETS_IMPORT_PROFILE"] = "Nuevo Snippet de Perfil"
L["CODESNIPPETS_IMPORT_PROFILE_DESC"] = "Importa el snippet como un snippet específico de perfil. "
L["CODESNIPPETS_TITLE"] = "Snippets Lua (Avanzado)"
L["CODETOEXE"] = "Código a Ejecutar"
L["COLOR_CBC"] = "Barra de tiempo de reutilización - Completa"
L["COLOR_CBC_DESC"] = "Color de la barra superpuesta de tiempo de reutilización/duración cuando el tiempo de reutilización/duración se ha completado. "
L["COLOR_CBS"] = "Barra de tiempo de reutilización - Inicio"
L["COLOR_CBS_DESC"] = "Color de la barra superpuesta de tiempo de reutilización/duración cuando el tiempo de reutilización/duración acaba de empezar"
L["COLOR_COA"] = "Contando, Temporizador Oculto, Mostrar Siempre"
L["COLOR_COA_DESC"] = [=[Color del icono cuando: 

El temporizador está activo (inutilizable/presente),
%q está deshabilitado, 
Ambos ajustes %q están marcados]=]
L["COLOR_COLOR"] = "Color"
L["COLOR_COS"] = "Contando, Temporizador Oculto, Mostrar A Veces"
L["COLOR_COS_DESC"] = [=[Color del icono cuando: 

El temporizador está activo (inutilizable/presente),
%q está deshabilitado, 
Ambos ajustes %q no están marcados]=] -- Needs review
L["COLOR_CTA"] = "Contando, Temporizador Mostrado, Mostrar Siempre"
L["COLOR_CTA_DESC"] = [=[Color del icono cuando: 

El temporizador está activo (inutilizable/presente),
%q está habilitado, 
Ambos ajustes %q están marcados]=]
L["COLOR_CTS"] = "Contando, Temporizador Mostrado, Mostrar A Veces"
L["COLOR_CTS_DESC"] = [=[Color del icono cuando: 

El temporizador está activo (inutilizable/presente),
%q está habilitado, 
Ambos ajustes %q no están marcados]=] -- Needs review
L["COLOR_DEFAULT"] = "*Colores Globales*"
L["COLOR_DESATURATE"] = "Gris"
L["COLOR_DESATURATE_DESC"] = "Marcar para desaturar  el icono cuando se use este color, eliminando todo el color y dejando el icono en escala de grises. "
L["COLOR_HEADER"] = [=[Estos colores se usarán para iconos %s si sus ajustes %q están marcados. 

Blanco sólido no produce cambios en la textura. Negro sólido hará que la textura sea negro sólido. Cualquier gris o color entre medias teñirá el icono. ]=]
L["COLOR_HEADER_DEFAULT"] = [=[Estos colores se usarán para cualquier tipo de icono que no los sobreescriba en sus ajustes de color de tipo. 

Blanco sólido no produce cambios en la textura. Negro sólido hará que la textura sea negro sólido. Cualquier gris o color entre medias teñirá el icono. ]=]
L["COLOR_IGNORE_GCD"] = "Los colores ignoran el GCD"
L["COLOR_IGNORE_GCD_DESC"] = "Marcar esto evitará que los colores de los iconos cambien simplemente por el tiempo de reutilización global. "
L["COLOR_MSQ_COLOR"] = "Colorear borde Masque"
L["COLOR_MSQ_COLOR_DESC"] = "Marcar esto hará que el borde de una piel de Masque (si la piel que está usando tiene un borde) sea coloreado."
L["COLOR_MSQ_ONLY"] = "Sólo colorear borde de Masque"
L["COLOR_MSQ_ONLY_DESC"] = "Marcar esto hará que SOLO el borde de una piel de Masque (si la piel que está usando tiene un borde) sea coloreado. Los iconos NO serán coloreados"
L["COLOR_NA"] = "Terminado, Mostrar Siempre"
L["COLOR_NA_DESC"] = [=[Color del icono cuando: 

El temporizador ha finalizado (utilizable/ausente),
Ambos ajustes %q están marcados]=]
L["COLORNAMES"] = "Nombres Coloreados por Clase"
L["COLORNAMES_DESC"] = "Marque para intentar colorear los nombres de las unidades en displays de texto y manejadores de eventos de icono de texto."
L["COLOR_NS"] = "Finalizado, Mostrar A Veces"
L["COLOR_NS_DESC"] = [=[Color del icono cuando: 

El temporizador está finalizado (utilizable/ausente),
Ambos ajustes %q no están marcados]=] -- Needs review
L["COLOR_OOM"] = "Sin Maná"
L["COLOR_OOM_DESC"] = "Color del icono cuando carezca de poder para usar una habilidad. "
L["COLOR_OOR"] = "Fuera de Alcance"
L["COLOR_OOR_DESC"] = "Color del icono cuando no está dentro del alcance para usar una habilidad. "
L["COLOR_OORM"] = "Fuera de Alcance y Sin Maná"
L["COLOR_OORM_DESC"] = "Color del icono cuando carezca de poder y no esté dentro del alcance para usar una habilidad."
L["COLOR_OVERRIDEDEFAULT"] = "Usar"
L["COLOR_OVERRIDEDEFAULT_DESC"] = "Marque esto para sobreescribir el ajuste *Colores Globales\" y usar éste en su lugar"
L["COLOR_RESET_DESC"] = "Restablecer este ajuste a sus valores por defecto"
L["COMPARISON"] = "Comparación"
L["CONDITIONALPHA"] = "Condiciones/requisitos no cumplidos."
L["CONDITIONALPHA_CONDITIONICON"] = "Duración No Cumplida"
L["CONDITIONALPHA_CONDITIONICON_DESC"] = "Esto será usado cuando los requisitos de duración no se cumplan. Este ajuste será ignorado si el icono ya está escondido por los otros dos ajustes de opacidad."
L["CONDITIONALPHA_DESC"] = "Esto será usado cuando no se cumplan condiciones, o si la duración o requisitos de acumulación no se cumplen. Este ajuste será ignorado si el icono ya está oculto por los otros dos ajustes de opacidad. "
L["CONDITIONALPHA_METAICON"] = "Condiciones No Cumplidas"
L["CONDITIONALPHA_METAICON_DESC"] = [=[Esta opacidad se usará cuando las condiciones no se cumplan. 

Las condiciones se pueden configurar en la pestaña %q.]=]
L["CONDITIONORMETA_CHECKINGINVALID"] = "Advertencia! Grupo %d, Icono %d está comprobando un icono inválido (Grupo %d, Icono %d)"
L["CONDITIONORMETA_CHECKINGINVALID_GROUP"] = "Advertencia! Grupo %d está comprobando un icono inválido (Grupo %d, Icono %d)"
L["CONDITIONPANEL_ABSOLUTE"] = "Absoluto"
L["CONDITIONPANEL_ADD"] = "Añadir una condición"
L["CONDITIONPANEL_ADD2"] = "Pulse para añadir una condición"
L["CONDITIONPANEL_ALIVE"] = "Unidad está Viva"
L["CONDITIONPANEL_ALIVE_DESC"] = "La condición se pasará si la unidad especificada está viva."
L["CONDITIONPANEL_ALTPOWER"] = "Poder Alt."
L["CONDITIONPANEL_ALTPOWER_DESC"] = "Este es el poder específico del encuentro usado en varios encuentros en Cataclismo, incluyendo Cho'gall y Atramedes"
L["CONDITIONPANEL_AND"] = "Y"
L["CONDITIONPANEL_ANDOR"] = "Y / O"
L["CONDITIONPANEL_ANDOR_DESC"] = "|cff7fffffClick|r para alternar entre operadores lógicos AND y OR"
L["CONDITIONPANEL_AUTOCAST"] = "Autolanzamiento de hechizos de mascota"
L["CONDITIONPANEL_BLIZZEQUIPSET"] = "Conjunto de equipamiento equipado"
L["CONDITIONPANEL_BLIZZEQUIPSET_DESC"] = "Comprueba si tiene o no equipado un conjunto de equipamiento específico del gestor de equipamiento de Blizzard."
L["CONDITIONPANEL_BLIZZEQUIPSET_INPUT"] = "Nombre del conjunto de equipamiento"
L["CONDITIONPANEL_BLIZZEQUIPSET_INPUT_DESC"] = [=[Introduzca el nombre del conjunto de equipamiento de Blizzard que desea comprobar. 

Sólo se puede introducir un conjunto de equipamiento, y |cFFFF5959DISTINGUE MAYÚSCULAS DE MINÚSCULAS|r]=]
L["CONDITIONPANEL_CASTCOUNT"] = "Cuenta de Lanzamiento de Hechizo"
L["CONDITIONPANEL_CASTCOUNT_DESC"] = "Comprueba el número de veces que una unidad ha lanzado un cierto hechizo. "
L["CONDITIONPANEL_CASTTOMATCH"] = "Hechizo a Comparar"
L["CONDITIONPANEL_CASTTOMATCH_DESC"] = [=[Introduzca un nombre de hechizo aquí para hacer que la condición se cumpla sólo si el hechizo lanzado concuerda exactamente con él.

Puede dejar esto en blanco para comprobar cualquier lanzamiento de hechizo/canalización]=]
L["CONDITIONPANEL_CLASS"] = "Clase de Unidad"
L["CONDITIONPANEL_CLASSIFICATION"] = "Clasificación de Unidades"
L["CONDITIONPANEL_COMBAT"] = "Unidad en Combate"
L["CONDITIONPANEL_COMBO"] = "Puntos de Combo"
L["CONDITIONPANEL_CREATURETYPE"] = "Tipo de Criatura Unidad"
L["CONDITIONPANEL_CREATURETYPE_DESC"] = [=[Puede introducir múltiples tipos de criatura para comparar separándolos con punto y coma (;).

Los tipos de criatura deben ser escritos exactamente como aparecen en el tooltip de la criatura. 

La condición se cumplirá si coincide algún tipo.]=]
L["CONDITIONPANEL_CREATURETYPE_LABEL"] = "Tipo(s) de Criatura"
L["CONDITIONPANEL_DEFAULT"] = "Elija un tipo..."
L["CONDITIONPANEL_ECLIPSE_DESC"] = "Eclipse tiene un rango desde -100 (eclipse lunar) a 100 (eclipse solar). Introduzca -80 si quiere que el icono funcione con un valor de poder lunar 80. "
L["CONDITIONPANEL_EQUALS"] = "Iguales"
L["CONDITIONPANEL_EXISTS"] = "Unidad Existe"
L["CONDITIONPANEL_GREATER"] = "Mayor Que"
L["CONDITIONPANEL_GREATEREQUAL"] = "Mayor o Igual a"
L["CONDITIONPANEL_GROUPTYPE"] = "Tipo de Grupo"
L["CONDITIONPANEL_ICON"] = "Icono Mostrado"
L["CONDITIONPANEL_ICON_DESC"] = [=[La condición comprueba si el icono especificado está mostrado u oculto

Si no quiere mostrar los iconos que se están comprobando, marque %q en el editor de iconos de ese icono.

El grupo del icono que se está comprobando debe mostrarse para comprobar el icono, incluso si la condición se establece como falsa.]=]
L["CONDITIONPANEL_ICON_HIDDEN"] = "Oculto"
L["CONDITIONPANEL_ICONHIDDENTIME"] = "Tiempo Icono Oculto"
L["CONDITIONPANEL_ICONHIDDENTIME_DESC"] = [=[La condición comprueba durante cuánto tiempo ha estado oculto el icono especificado. 

Si no quiere mostrar el icono que se está comprobando, marque %q en el editor de iconos de ese icono. 

El grupo del icono siendo comprobado debe mostrarse para comprobar el icono. ]=]
L["CONDITIONPANEL_ICON_SHOWN"] = "Mostrado"
L["CONDITIONPANEL_ICONSHOWNTIME"] = "Tiempo Icono Mostrado"
L["CONDITIONPANEL_ICONSHOWNTIME_DESC"] = [=[La condición comprueba durante cuánto tiempo ha estado mostrándose el icono especificado. 

Si no quiere mostrar el icono que se está comprobando, marque %q en el editor de iconos de ese icono. 

El grupo del icono siendo comprobado debe mostrarse para comprobar el icono. ]=]
L["CONDITIONPANEL_INPETBATTLE"] = "En batalla de mascotas"
L["CONDITIONPANEL_INSTANCETYPE"] = "Tipo de Instancia"
L["CONDITIONPANEL_INTERRUPTIBLE"] = "Interrumpible"
L["CONDITIONPANEL_ITEMRANGE"] = "Objeto al alcance de la unidad"
L["CONDITIONPANEL_LESS"] = "Menor Que"
L["CONDITIONPANEL_LESSEQUAL"] = "Menor o Igual a"
L["CONDITIONPANEL_LEVEL"] = "Nivel de la Unidad"
L["CONDITIONPANEL_MANAUSABLE"] = "Hechizo Utilizable (Maná/Energía/etc.)"
L["CONDITIONPANEL_MAX"] = "Max"
L["CONDITIONPANEL_MOUNTED"] = "Montado"
L["CONDITIONPANEL_NAME"] = "Nombre de la Unidad"
L["CONDITIONPANEL_NAMETOMATCH"] = "Nombre a Comparar"
L["CONDITIONPANEL_NAMETOOLTIP"] = "Puede introducir múltiples nombres para comparar separándolos con punto y coma (;). La condición pasará si cualquiera de los nombres coincide. "
L["CONDITIONPANEL_NOTEQUAL"] = "No es Igual a"
L["CONDITIONPANEL_NPCID"] = "ID de Unidad PNJ"
L["CONDITIONPANEL_NPCID_DESC"] = [=[Comprueba si una unidad tiene un ID de PNJ especificado

El ID de PNJ es el número que se encuentra en la URL al mirar la página de Wowhead del PNJ (P.ej. http://www.wowhead.com/npc=62943)

Los jugadores y otras unidades sin ID de PNJ serán tratadas por esta condición como si tuvieran un ID de 0]=]
L["CONDITIONPANEL_NPCIDTOMATCH"] = "ID a Emparejar"
L["CONDITIONPANEL_NPCIDTOOLTIP"] = "Puede introducir múltiples IDs de PNJs para emparejar separándolas con punto y coma (;). La condición se cumplirá si se empareja cualquier ID. "
L["CONDITIONPANEL_OPERATOR"] = "Operador"
L["CONDITIONPANEL_OR"] = "O"
L["CONDITIONPANEL_PERCENT"] = "Porcentaje"
L["CONDITIONPANEL_PETMODE"] = "Modo de ataque de la mascota"
L["CONDITIONPANEL_PETSPEC"] = "Especialización de mascota"
L["CONDITIONPANEL_PETTREE"] = "Árbol de talentos de mascota"
L["CONDITIONPANEL_POWER"] = "Recurso Primario"
L["CONDITIONPANEL_POWER_DESC"] = "Comprobará energía si la unidad es un druida en forma de gato, ira si la unidad es un guerrero, etc"
L["CONDITIONPANEL_PVPFLAG"] = "Unidad está Marcada JcJ"
L["CONDITIONPANEL_RAIDICON"] = "Icono de Banda de Unidad"
L["CONDITIONPANEL_REMOVE"] = "Eliminar esta condición"
L["CONDITIONPANEL_RESTING"] = "Descansando"
L["CONDITIONPANEL_ROLE"] = "Rol de la Unidad"
L["CONDITIONPANEL_RUNES_CHECK"] = "Fuerza las runas de la fila superior a encajar sólo con las que no sean runas de muerte"
L["CONDITIONPANEL_RUNES_CHECK_DESC"] = [=[Normalmente, las runas de la fila superior para esta condición les permitía emparejarse con una runa normal o con una runa de muerte en esa ranura. 

Active esta opción para forzar a las runas de la fila superior a que sólo se emparejen con runas que no sean runas de muerte. ]=]
L["CONDITIONPANEL_RUNES_DESC"] = [=[Use este tipo de condición para mostrar el icono sólo cuando las runas seleccionadas están disponibles. 

Cada runa es un botón de comprobación. Una marca de comprobación requerirá que la runa sea usable, una "X" requerirá que la runa sea inusable, ninguna marca ignorará la runa. 

Las runas de la segunda fila son la versión runa de muerte de cada runa superior.]=]
L["CONDITIONPANEL_SPELLRANGE"] = "Hechizo al alcance de la unidad"
L["CONDITIONPANEL_SWIMMING"] = "Nadando"
L["CONDITIONPANEL_THREAT_RAW"] = "Amenaza de la Unidad - Base"
L["CONDITIONPANEL_THREAT_RAW_DESC"] = [=[Esta condición comprueba su porcentaje de amenaza base en una unidad. 

Los jugadores a distancia de cuerpo a cuerpo son atacados al 110%
Los jugadores a distancia son atacados al 130%
Los jugadores con agro (siendo atacados) tienen un porcentaje base de amenaza del 255%]=]
L["CONDITIONPANEL_THREAT_SCALED"] = "Amenaza de Unidad - Escalado"
L["CONDITIONPANEL_THREAT_SCALED_DESC"] = [=[Esta condición comprueba su porcentaje de amenaza escalado en una unidad. 

100% indica que está tanqueando la unidad. ]=]
L["CONDITIONPANEL_TRACKING"] = "Seguimiento activo"
L["CONDITIONPANEL_TYPE"] = "Tipo"
L["CONDITIONPANEL_UNIT"] = "Unidad"
L["CONDITIONPANEL_UNITISUNIT"] = "Unidad es Unidad"
L["CONDITIONPANEL_UNITISUNIT_DESC"] = "Esta condición se cumplirá si las unidades en el primer cuadro de edición y en el segundo son la misma entidad. "
L["CONDITIONPANEL_UNITISUNIT_EBDESC"] = "Introduzca una unidad en este cuadro de edición para compararla con la primera unidad. "
L["CONDITIONPANEL_VALUEN"] = "Valor"
L["CONDITIONPANEL_VEHICLE"] = "Unidad Controla Vehículo"
L["CONDITION_QUESTCOMPLETE"] = "Misión Completa"
L["CONDITION_QUESTCOMPLETE_DESC"] = "Comprueba si una misión está completa. "
L["CONDITION_QUESTCOMPLETE_EB_DESC"] = [=[Introduzca el ID de misión de la misión que quiera comprobar. 

Los IDs de misión se pueden obtener de la URL al mirar la misión en un sitio de base de datos como Wowhead. 

p. Ej. el ID de misión de http://www.wowhead.com/quest=28716/heros-call-twilight-highlands es 28716]=]
L["CONDITIONS"] = "Condiciones"
L["CONDITION_TIMEOFDAY"] = "Hora del Día"
L["CONDITION_TIMEOFDAY_DESC"] = [=[Esta condición comprueba la hora actual del día. 

La hora comprobada es su hora local, basada en el reloj de su ordenador. No comprueba la hora del servidor. ]=]
L["CONDITION_TIMERS_FAIL_DESC"] = "Duración del temporizador a establecer en el icono cuando las condiciones empiezan a no cumplirse"
L["CONDITION_TIMERS_HEADER"] = "Temporizadores"
L["CONDITION_TIMERS_SUCCEED_DESC"] = "Duración del temporizador a establecer en el icono cuando las condiciones empiezan a cumplirse"
L["CONDITION_WEEKDAY"] = "Día de la semana"
L["CONDITION_WEEKDAY_DESC"] = [=[Comprueba el día de la semana actual. 

La hora comprobada es su hora local, basada en el reloj de su ordenador. No comprueba la hora del servidor. ]=]
L["CONFIGMODE"] = "TellMeWhen está en modo de configuración. Los iconos no funcionarán hasta que salga del modo de configuración. Escriba '/tellmewhen' o '/tmw' para activar o desactivar el modo de configuración. "
L["CONFIGMODE_EXIT"] = "Salir del modo de configuración"
L["CONFIGMODE_NEVERSHOW"] = "No mostrar de nuevo"
L["CONFIGPANEL_CBAR_HEADER"] = "Barra de Temporizador Superpuesta"
L["CONFIGPANEL_CLEU_HEADER"] = "Eventos de Combate"
L["CONFIGPANEL_CNDTTIMERS_HEADER"] = "Temporizadores de Condición"
L["CONFIGPANEL_PBAR_HEADER"] = "Barra de Poder Superpuesta"
L["CONFIGPANEL_TIMERBAR_BARDISPLAY_HEADER"] = "Barra de temporizador"
L["CONFIGPANEL_TIMER_HEADER"] = "Barrido de Temporizador"
L["COPYGROUP"] = "Copiar Grupo"
L["COPYPOSSCALE"] = "Copiar posición/escala"
L["CREATURETYPE_1"] = "Bestia"
L["CREATURETYPE_10"] = "Sin especificar"
L["CREATURETYPE_11"] = "Tótem"
L["CREATURETYPE_12"] = "Mascota mansa"
L["CREATURETYPE_13"] = "Nube de gas"
L["CREATURETYPE_14"] = "Mascota salvaje"
L["CREATURETYPE_2"] = "Dragonante"
L["CREATURETYPE_3"] = "Demonio"
L["CREATURETYPE_4"] = "Elemental"
L["CREATURETYPE_5"] = "Gigante"
L["CREATURETYPE_6"] = "No-muerto"
L["CREATURETYPE_7"] = "Humanoide"
L["CREATURETYPE_8"] = "Alimaña"
L["CREATURETYPE_9"] = "Mecánico"
L["CrowdControl"] = "Control de Masas"
L["Curse"] = "Maldición"
L["DamageBuffs"] = "Ventajas de Daño"
L["DAMAGER"] = "Daño"
L["DamageShield"] = "Escudo de Daño"
L["DEBUFFTOCHECK"] = "Desventaja a Comprobar"
L["DEBUFFTOCOMP1"] = "Primera Desventaja a Comparar"
L["DEBUFFTOCOMP2"] = "Segunda Desventaja a Comparar"
L["DEFAULT"] = "Por defecto"
L["DefensiveBuffs"] = "Ventajas Defensivas"
L["DESCENDING"] = "Descendiendo"
L["DISABLED"] = "Deshabilitado"
L["Disarmed"] = "Desarmado"
L["Disease"] = "Enfermedad"
L["Disoriented"] = "Desorientado"
L["DontMelee"] = "No Cuerpo a Cuerpo"
L["DR-Banish"] = "Desterrar"
L["DR-BindElemental"] = "Atar elemental"
L["DR-Charge"] = "Cargar"
L["DR-ControlledRoot"] = "Inmovilizaciones controladas"
L["DR-ControlledStun"] = "Aturdimientos controlados"
L["DR-Cyclone"] = "Ciclón"
L["DR-Disarm"] = "Desarmes"
L["DR-Disorient"] = "Desorientaciones"
L["DR-DragonsBreath"] = "Aliento de dragón"
L["DR-Entrapment"] = "Atrapamientos"
L["DR-Fear"] = "Miedos"
L["DR-Horrify"] = "Horrores"
L["DR-IceWard"] = "Resguardo de hielo"
L["DR-MindControl"] = "Control Mental"
L["DR-RandomRoot"] = "Inmovilizaciones aleatorias"
L["DR-RandomStun"] = "Aturdimientos aleatorios"
L["DR-Scatter"] = "Disparo de dispersión"
L["DR-Silence"] = "Silencios"
L["DR-Taunt"] = "Provocaciones"
L["DT_DOC_Destination"] = "Devuelve la unidad de destino o nombre del último Evento de Combate que el icono procesó. Uso recomendado en conjunción con la etiqueta [Name] (Esta etiqueta sólo debería usarse con iconos de tipo %s)"
L["DT_DOC_Duration"] = "Devuelve la duración restante actualmente en el icono. Se recomienda que dé formato a esto con [TMWFormatDuration]"
L["DT_DOC_Extra"] = "Devuelve el hechizo extra del último Evento de Combate que procesó el icono. (Esta etiqueta sólo debería usarse con iconos de tipo %s)"
L["DT_DOC_IsShown"] = "Devuelve si un icono es mostrado o no."
L["DT_DOC_LocType"] = "Devuelve el tipo del efecto de pérdida de control para el que el icono se está mostrando (esta etiqueta sólo debería usarse con iconos de tipo %s)"
L["DT_DOC_Name"] = "Devuelve el nombre de la unidad. Esta es una versión mejorada de la etiqueta [Name] por defecto proporcionada por DogTag. "
L["DT_DOC_Opacity"] = "Devuelve la opacidad de un icono. El valor de retorno está entre 0 y 1."
L["DT_DOC_PreviousUnit"] = "Devuelve la unidad o el nombre de la unidad que el icono ha comprobado antes de la actual unidad. Recomendado usar junto con la etiqueta [Name]."
L["DT_DOC_Source"] = "Devuelve la unidad fuente o el nombre del último Evento de Combate que el icono procesó. Recomendado usar junto con la etiqueta [Name]. (Esta etiqueta sólo debería usarse con iconos de tipo %s)"
L["DT_DOC_Spell"] = "Devuelve el hechizo u objeto para el que el icono está mostrando datos. "
L["DT_DOC_Stacks"] = "Devuelve las acumulaciones actuales del icono"
L["DT_DOC_TMWFormatDuration"] = "Devuelve una cadena formateada por el formato de tiempo de TellMeWhen. Alternativa a [FormatDuration]."
L["DT_DOC_Unit"] = "Devuelve la unidad o el nombre de la unidad que el icono está comprobando. Recomendado usarlo junto con la etiqueta [Name]."
L["DURATION"] = "Duración"
L["DURATIONALPHA_DESC"] = "Establece el nivel de opacidad con que el icono debería mostrarse cuando estos requisitos de duración no se cumplan."
L["DURATIONPANEL_TITLE2"] = "Requisitos de Duración"
L["DURATIONPERC"] = "Porcentaje de duración"
L["EARTH"] = "Tierra"
L["ECLIPSE_DIRECTION"] = "Dirección de Eclipse"
L["elite"] = "Élite"
L["ENABLINGOPT"] = "TellMeWhen_Options está deshabilitado. Habilitando..."
L["Enraged"] = "Enfurecer"
L["EQUIPSETTOCHECK"] = "Conjunto de equipamiento a comprobar (|cFFFF5959DISTINGUE MAYÚSCULAS DE MINÚSCULAS|r)"
L["ERROR_ACTION_DENIED_IN_LOCKDOWN"] = "No puede hacer esto en combate si la opción %q no está activada (escriba '/tmw options')."
L["ERROR_ANCHORSELF"] = "%s estaba intentando anclarse a sí mismo, así que TellMeWhen restableció su anclaje al centro de la pantalla para prevenir un fallo catastrófico. "
L["ERROR_MISSINGFILE"] = [=[Se requiere un reinicio completo de WoW para usar TellMeWhen %s:

No se encontró %s.

Desea reiniciar WoW ahora?]=]
L["ERROR_MISSINGFILE_NOREQ"] = [=[Para usar correctamente TellMeWhen %s podría requerirse un reinicio completo de WoW:

No se encontró %s.

Desea reiniciar WoW ahora?]=]
L["ERROR_MISSINGFILE_REQFILE"] = "Un fichero requerido"
L["ERROR_MISSINGLAYOUT"] = "No se pudo encontrar el diseño de texto para %s. Volviendo al diseño por defecto. "
L["ERROR_NO_LOCKTOGGLE_IN_LOCKDOWN"] = "No se puede desbloquear TellMeWhen estando en combate si la opción %q no está activada (escriba '/tmw options')."
L["ERROR_NOTINITIALIZED_INTERFACEPANEL_EXPLANATION"] = [=[Parece que TellMeWhen no ha conseguido inicializarse

Debido a esto, TellMeWhen no podrá funcionar, y usted no podrá configurar ninguno de sus ajustes. 

Si vio un mensaje al conectarse que decía que se necesitaba un reinicio completo de WoW para usar TMW, por favor hágalo.

Si no vio ese mensaje, por favor permita errores de Lua (%s > %s > %s) si no lo ha hecho ya, recargue su UI, e informe de cualquier error que reciba en un ticket en http://wow.curseforge.com/addons/tellmewhen/create-ticket/

Disculpe las molestias, pero este es un caso inusual, y cualquier información sobre ello que pueda proporcionar ayudará a que se corrija cuanto antes!

Gracias por utilizar TellMeWhen!]=]
L["ERROR_NOTINITIALIZED_NO_ACTION"] = "TellMeWhen no puede ejecutar esa acción si el addon no pudo inicializarse!"
L["ERROR_NOTINITIALIZED_NO_LOAD"] = "TellmeWhen_Opciones no se puede cargar si TellMeWhen no se pudo inicializar!"
L["ERROR_NOTLOADED_ERROR"] = "TellMeWhen no se pudo cargar! ¿Le falta alguna librería requerida? "
L["ERRORS_FRAME"] = "Marco de Errores"
L["ERRORS_FRAME_DESC"] = "Dirige la salida al marco estándar de errores que normalmente muestra mensajes como %q"
L["EVENTCONDITIONS"] = "Condiciones de evento"
L["EVENTCONDITIONS_DESC"] = "Pulse para configurar un conjunto de condiciones que activarán este evento cuando se empiecen a cumplir. "
L["EVENTCONDITIONS_TAB_DESC"] = "Configura un conjunto de condiciones que activarán un evento cuando se empiecen a cumplir."
L["EVENTHANDLER_LUA_CODE"] = "Código Lua a Ejecutar"
L["EVENTHANDLER_LUA_CODE_DESC"] = "Escriba aquí el código Lua que debería ejecutarse cuando se active el evento,"
L["EVENTHANDLER_LUA_LUA"] = "Lua"
L["EVENTHANDLER_LUA_TAB"] = "Lua (Avanzado)"
L["EVENTS_HANDLERS_ADD"] = "Añadir Manejador de Evento..."
L["EVENTS_HANDLERS_ADD_DESC"] = "|cff7fffffClick|r para elegir un manejador de evento para añadir a este icono. "
L["EVENTS_HANDLERS_GLOBAL_DESC"] = [=[|cff7fffffClick|r para opciones del manejador de eventos
|cff7fffffClick-Derecho|r para cambiar evento
|cff7fffffClick-y-Arrastrar|r para reordenar]=]
L["EVENTS_HANDLERS_HEADER"] = "Manejadores de Evento del Icono"
L["EVENTS_HANDLERS_PLAY"] = "Probar Evento"
L["EVENTS_HANDLERS_PLAY_DESC"] = "|cff7fffffClick|r para probar el manejador de evento"
L["EVENTS_INSTRUCTIONS"] = [=[En esta pestaña puede configurar funciones extra para este icono con efectos como sonidos, animaciones, y salidas de texto. 

Todos estos efectos son activados por un evento de su elección. La mayoría de los eventos se activan en respuesta a un cambio en el estado del icono, pero también hay otros eventos. 

Para empezar a configurar estos efectos, pinche el botón de la izquierda y elija la combinación de evento y efecto que desearía. 

Los ajustes para el evento y el efecto aparecerán entonces, y podrá configurarlos como desee. ]=]
L["EVENTS_SETTINGS_CNDTJUSTPASSED"] = "Y acaba de empezar a cumplirse"
L["EVENTS_SETTINGS_CNDTJUSTPASSED_DESC"] = "Evita que el evento sea manejado a menos que la condición configurada más arriba acabe de empezar a cumplirse. "
L["EVENTS_SETTINGS_HEADER"] = "Ajustes de Eventos"
L["EVENTS_SETTINGS_ONLYSHOWN"] = "Sólo manejar si se muestra el icono"
L["EVENTS_SETTINGS_ONLYSHOWN_DESC"] = "Evita que el evento sea manejado si el icono no se muestra"
L["EVENTS_SETTINGS_PASSINGCNDT"] = "Sólo manejar si se está cumpliendo la condición:"
L["EVENTS_SETTINGS_PASSINGCNDT_DESC"] = "Evita que el evento sea manejado a menos que la condición configurada más abajo tenga éxito. "
L["EVENTS_SETTINGS_PASSTHROUGH"] = "Continuar a eventos inferiores"
L["EVENTS_SETTINGS_PASSTHROUGH_DESC"] = [=[Marque para permitir que otro evento sea manejado después de este. 
Si se deja desmarcado, el icono no procesará más eventos después de este evento si procesa con éxito y muestra/dirige a salida alguna cosa. 

Pueden aplicarse excepciones, vea las descripciones individuales de eventos para más detalles. ]=]
L["EVENTS_TAB"] = "Eventos"
L["EVENTS_TAB_DESC"] = "Configura disparadores para sonidos, salidas de texto y animaciones. "
L["EXPORT_f"] = "Exportar %s"
L["EXPORT_HEADING"] = "Exportar"
L["EXPORT_SPECIALDESC2"] = "Otros usuarios de TellMeWhen sólo pueden importar estos datos si tienen la versión %s"
L["EXPORT_TOCOMM"] = "A Jugador"
L["EXPORT_TOCOMM_DESC"] = [=[Escriba el nombre de un jugador en el cuadro de edición y elija esta opción para enviarle los datos. Debe ser alguien a quien pueda susurrar (misma facción, servidor, online), y debe tener TellMeWhen v4.0.0+

También puede escribir "GUILD" o "RAID" (diferencia mayúsculas y minúsculas) para enviar a toda su hermandad o grupo de banda. ]=]
L["EXPORT_TOGUILD"] = "A Hermandad"
L["EXPORT_TORAID"] = "A Banda"
L["EXPORT_TOSTRING"] = "A Cadena"
L["EXPORT_TOSTRING_DESC"] = "Una cadena conteniendo los datos necesarios será pegada en el cuadro de edición. Pulse Ctrl+C para copiarla, y luego péguela donde quiera compartirla. "
L["FALSE"] = "Falso"
L["fCODESNIPPET"] = "Snippet de código: %s"
L["Feared"] = "Miedo"
L["fGROUP"] = "Grupo: %s"
L["fICON"] = "Icono: %s"
L["FIRE"] = "Fuego"
L["FONTCOLOR"] = "Color de Fuente"
L["FONTSIZE"] = "Tamaño de Fuente"
L["FORWARDS_IE"] = "Adelante"
L["FORWARDS_IE_DESC"] = "Carga el último icono que fue editado (%s |T%s:0|t)." -- Needs review
L["fPROFILE"] = "Perfil: %s"
L["FROMNEWERVERSION"] = "Está importando datos que fueron creados por una versión de TellMeWhen más reciente que la suya. Algunos ajustes podrían no funcionar hasta que se actualice a la última versión. "
L["fTEXTLAYOUT"] = "Diseño de Texto: %s"
L["GCD"] = "Tiempo de Reutilización Global"
L["GCD_ACTIVE"] = "GCD activo"
L["GENERIC_NUMREQ_CHECK_DESC"] = "Marque para habilitar y configurar el %s"
L["GENERICTOTEM"] = "Tótem %d"
L["GLYPHTOCHECK"] = "Glifo a Comprobar"
L["GROUPADDONSETTINGS"] = "Ajustes de Grupo"
L["GROUPADDONSETTINGS_DESC"] = "Configura ajustes para este grupo, otros grupos, y todos los otros ajustes generales de accesorio. "
L["GROUPCONDITIONS"] = "Condiciones de Grupo"
L["GROUPCONDITIONS_DESC"] = "Configura condiciones que le permiten ajustes finos sobre cuándo se muestra este grupo. "
L["GROUPICON"] = "Grupo: %s, Icono: %s"
L["HEALER"] = "Sanación"
L["Heals"] = "Sanaciones de Jugador"
L["HELP_ANN_LINK_INSERTED"] = [=[El enlace que acaba de insertar puede parecer extraño, pero así es como debe ser formateado con DogTag.

Cambiar el código de color si está dirigiendo la salida a un canal de Blizzard romperá el enlace.]=]
L["HELP_CNDT_ANDOR_FIRSTSEE"] = [=[Puede elegir si se deben cumplir ambas condiciones o sólo se necesita que se cumpla una. 

|cff7fffffPinche|r este ajuste entre sus condiciones para cambiar este comportamiento si desea hacerlo. ]=]
L["HELP_CNDT_PARENTHESES_FIRSTSEE"] = [=[Puede agrupar conjuntos de condiciones entre sí para comprobaciones complejas, especialmente cuando se combina con el ajuste %q. 
|cff7fffffPinche|r los paréntesis entre sus condiciones para agruparlas entre sí si desea hacerlo. ]=]
L["HELP_EXPORT_DOCOPY_MAC"] = "Pulse |cff7fffffCMD+C|r para copiar"
L["HELP_EXPORT_DOCOPY_WIN"] = "Pulse |cff7fffffCTRL+C|r para copiar"
L["HELP_FIRSTUCD"] = [=[Ha usado por primera vez un tipo de icono que usa la sintaxis especial de duración!. Los hechizos que se añaden al cuadro de edición %q para ciertos tipos de iconos deben definir una duración inmediatamente tras cada hechizo usando la siguiente sintaxis: 

Hechizo: Duración

Por ejemplo: 

"%s: 120"
"%s: 10; %s: 24"
"%s: 180"
"%s: 3:00"
"62618: 3:00"

Insertar desde la lista de sugerencias añade automáticamente la duración desde el tooltip.]=]
L["HELP_IE_TIMERTEXTHANDLER_MISSING"] = [=[TellMeWhen no puede encontrar ningún addon instalado capaz de manejar este ajuste. 

Si ha activado este ajuste pero no ve ningún texto de temporizador, por favor instale el addon "OmniCC" desde Curse.com o WoWInterface.com]=]
L["HELP_IMPORT_CURRENTPROFILE"] = [=[Intentando mover o copiar un icono desde este perfil a otra ranura de icono?

Puede hacerlo fácilmente haciendo |cff7fffffClick-Derecho y arrastrando|r el icono (mantenga pulsado el botón del ratón) a otra ranura. Cuando libere el botón del ratón, aparecerá un menú con muchas opciones. 

Intente arrastrar un icono a un meta icono, otro grupo, u otro marco en su pantalla para otras opciones. ]=]
L["HELP_MISSINGDURS"] = [=[A los siguientes hechizos les falta duración: 

%s

Para añadir duraciones, utilice la siguiente sintaxis: 

Nombre del Hechizo: Duración

P.Ej. "%s: 10"

Insertar desde la lista de sugerencias añade automáticamente la duración desde el tooltip.]=]
L["HELP_MS_NOFOUND"] = [=[La habilidad %q no se pudo encontrar en sus barras de acción. 

Asegúrese de que la habilidad está en sus barras de acción, en su estado por defecto, y que no es sólo una macro que está poniendo el hechizo en sus barras de acción. De otro modo, este icono no funcionará adecuadamente. ]=]
L["HELP_NOUNIT"] = "Debe introducir una unidad!"
L["HELP_NOUNITS"] = "Debe introducir al menos una unidad!"
L["HELP_POCKETWATCH"] = [=[|TInterface\Icons\INV_Misc_PocketWatch_01:20|t -- La textura del reloj de bolsillo.
Se está usando esta textura porque el primer hechizo válido a comprobar se introdujo por nombre y no está en su libro de hechizos. 

La textura correcta se usará una vez que haya visto el hechizo durante el juego. 

Para ver la textura correcta ahora, cambie el primer hechizo a comprobar a una ID de hechizo. Puede hacer esto fácilmente pinchando en la entrada en el cuadro de edición y haciendo click derecho en la entrada correspondiente correcta en la lista de sugerencias. ]=]
L["ICON"] = "Icono"
L["ICONALPHAPANEL_FAKEHIDDEN"] = "Ocultar Siempre"
L["ICONALPHAPANEL_FAKEHIDDEN_DESC"] = [=[Obliga al icono a estar continuamente oculto permitiendo funcionalidad normal:

|cff7fffff-|r Condiciones de otros iconos aún pueden comprobar este icono
|cff7fffff-|r Los Meta iconos pueden mostrar este icono
|cff7fffff-|r Los eventos de este icono serán procesados]=]
L["ICONCONDITIONS_DESC"] = "Configura condiciones que le permiten ajustes finos sobre cuándo se muestra este icono. "
L["ICONGROUP"] = "Icono: %s (Grupo: %s)"
L["ICONMENU_ABSENT"] = "Ausente"
L["ICONMENU_ABSENTONANY"] = "Ausente en Cualquier Unidad" -- Needs review
L["ICONMENU_ABSENTONANY_DESC"] = "Establece el nivel de opacidad al que el icono debería mostrarse cuando cualquier unidad siendo comprobada carezca de todas las ventajas/desventajas siendo comprobadas. " -- Needs review
L["ICONMENU_ADDMETA"] = "Añadir a Meta Icono"
L["ICONMENU_ALLOWGCD"] = "Permitir Tiempo de Reutilización Global"
L["ICONMENU_ALLOWGCD_DESC"] = "Marque esta opción para permitir al temporizador reaccionar a y mostrar el tiempo de reutilización global en vez de simplemente ignorarlo. "
L["ICONMENU_ALPHA"] = "Alfa"
L["ICONMENU_ANCHORTO"] = "Anclar a %s"
L["ICONMENU_ANCHORTO_DESC"] = [=[Ancla %s a %s, de modo que cuando %s se mueva, %s se moverá con ello. 

En las opciones de grupo tiene disponibles ajustes avanzados de anclajes. ]=]
L["ICONMENU_ANCHORTO_UIPARENT"] = "Restablecer anclaje"
L["ICONMENU_ANCHORTO_UIPARENT_DESC"] = [=[Restablecer anclaje de %s de vuelta a su pantalla (UIParent). Está actualmente anclado a %s.

En las opciones de grupo tiene disponibles ajustes avanzados de anclajes. ]=]
L["ICONMENU_APPENDCONDT"] = "Añadir como condición \"Icono Mostrado\""
L["ICONMENU_BAROFFS"] = [=[Esta cantidad se añadirá a la barra con el fin de compensarla. 

Útil para indicadores personalizados de cuándo debería comenzar a lanzar un hechizo para evitar que termine una ventaja, o para indicar el poder requerido para lanzar un hechizo y aún tener suficiente para una interrupción. ]=]
L["ICONMENU_BINDTEXT_DESC"] = "Cualquier texto en este cuadro de edición se mostrará en el icono donde el keybind se mostraría normalmente en una barra de acción. Esto NO asigna un keybind a este icono de TellMeWhen. Es simplemente un recordatorio visual que será mostrado en el icono. El texto puede ser configurado en los ajustes de este grupo. "
L["ICONMENU_BOTH"] = "Cualquiera"
L["ICONMENU_BUFF"] = "Ventaja"
L["ICONMENU_BUFFCHECK"] = "Comprobación de Ventaja/Desventaja"
L["ICONMENU_BUFFCHECK_DESC"] = [=[Comprueba si una ventaja está ausente de cualquier unidad que esté comprobando. 

Use este tipo de icono para comprobar ventajas de raid faltantes. 

Casi todas las demás situaciones deberían usar el tipo de icono %q.]=]
L["ICONMENU_BUFFDEBUFF"] = "Ventaja/Desventaja"
L["ICONMENU_BUFFDEBUFF_DESC"] = "Sigue ventajas y/o desventajas"
L["ICONMENU_BUFFTYPE"] = "Ventaja o Desventaja"
L["ICONMENU_CAST"] = "Lanzamiento de Hechizo"
L["ICONMENU_CAST_DESC"] = "Controla lanzamientos y canalizaciones de hechizos."
L["ICONMENU_CASTS"] = "Lanzamientos de Hechizo"
L["ICONMENU_CASTSHOWWHEN"] = "Muestra cuando un lanzamiento es"
L["ICONMENU_CHECKNEXT"] = "Expandir sub-metas"
L["ICONMENU_CHECKNEXT_DESC"] = [=[Marcar esta casilla provocará que este icono expanda todos los iconos en cualquier meta icono que pueda estar comprobando en cualquier nivel en vez de sólo comprobar sub-meta iconos como si fueran cualquier otro icono normal. 

Adicionalmente, este icono no mostrará ningún icono que ya haya sido mostrado por otro meta icono que se actualice antes que éste. El orden de actualización se puede cambiar en las opciones principales y de grupo. ]=]
L["ICONMENU_CHECKREFRESH"] = "Atender a refrescos"
L["ICONMENU_CHECKREFRESH_DESC"] = [=[El registro de combate de Blizzard es muy imperfecto por lo que se refiere a refrescos de hechizo y miedo (u otros hechizos que se rompen tras cierta cantidad de daño). El registro de combate dirá que el hechizo se refrescó cuando el daño es aplicado, incluso si técnicamente no fue así. Desmarque esta casilla para deshabilitar la escucha de refrescos de hechizo, pero tenga en cuenta que los refrescos legítimos serán ignorados también. 

Se recomienda dejarlo marcado si los rendimientos decrecientes que está buscando no se rompen tras cierta cantidad de daño. ]=]
L["ICONMENU_CHOOSENAME2"] = "Elija hechizo(s) a comprobar"
L["ICONMENU_CHOOSENAME_ITEMSLOT2"] = "Elija objeto(s) a comprobar"
L["ICONMENU_CHOOSENAME_ITEMSLOT_DESC"] = [=[Introduzca el Nombre, ID, o ranura de equipamiento que quiere que compruebe este icono. Puede añadir múltiples entradas (cualquier combinación de nombres, IDs y ranuras de equipamiento) separándolas con punto y coma (;). 

Las ranuras de equipamiento son índices numéricos que corresponden con un objeto equipado. Si cambia el objeto equipado en esa ranura, el icono reflejará esto. 

Pulse |cff7fffffMayus-click|r en objetos y enlaces de chat o arrastre objetos para insertarlos en este cuadro de edición. ]=]
L["ICONMENU_CHOOSENAME_MULTISTATE"] = "Elija hechizo a comprobar"
L["ICONMENU_CHOOSENAME_ORBLANK"] = "|cff7fffffO|r deje en blanco para comprobarlo todo"
L["ICONMENU_CHOOSENAME_WPNENCH"] = "Elija encantamiento(s) a comprobar"
L["ICONMENU_CHOOSENAME_WPNENCH_DESC"] = [=[Introduzca los nombres de los encantamientos de arma que quiere que vigile este icono. Puede añadir múltiples entradas separándolas con punto y coma (;).

|cFFFF5959IMPORTANTE|r: Los nombres de encantamientos deben introducirse exactamente como aparecen en el tooltip del arma mientras el encantamiento está activo (p.ej "%s", no "%s")]=]
L["ICONMENU_CHOSEICONTOEDIT"] = "Elija un icono a editar:"
L["ICONMENU_CLEU"] = "Evento de Combate"
L["ICONMENU_CLEU_DESC"] = [=[Sigue eventos de combate. 

Ejemplos incluyen reflejos de hechizo, fallos, lanzamientos instantáneos y muertes, pero el icono puede seguir virtualmente cualquier cosa. ]=]
L["ICONMENU_CLEU_NOREFRESH"] = "No Refrescar"
L["ICONMENU_CLEU_NOREFRESH_DESC"] = "Marque para hacer que el icono ignore los eventos que sucedan mientras el temporizador del icono está activo. "
L["ICONMENU_CNDTIC"] = "Icono de Condición"
L["ICONMENU_CNDTIC_DESC"] = "Sigue el estado de condiciones. "
L["ICONMENU_CNDTIC_ICONMENUTOOLTIP"] = "(%d |4Condición:Condiciones;)"
L["ICONMENU_CNDTSHOWWHEN"] = "Mostrar cuando condiciones"
L["ICONMENU_COMPONENTICONS"] = "Iconos y Grupos Componentes"
L["ICONMENU_COOLDOWNCHECK"] = "Comprobación de tiempo de reutilización"
L["ICONMENU_COOLDOWNCHECK_DESC"] = "Marque esto para hacer que el icono se considere inusable si está en tiempo de reutilización"
L["ICONMENU_COPYHERE"] = "Copiar aquí"
L["ICONMENU_COUNTING"] = "Temporizador corriendo"
L["ICONMENU_COUNTING_DESC"] = "Muestra el icono cuando el temporizador del icono está activo"
L["ICONMENU_CUSTOMTEX"] = "Textura Personalizada"
L["ICONMENU_CUSTOMTEX_DESC"] = [=[Si quiere sobrescribir la textura mostrada por este icono, introduzca el Nombre o ID del hechizo que tiene la textura que quiere usar. 

También puede introducir una ruta de textura, como 'Interface/Icons/spell_nature_healingtouch', o simplemente 'spell_nature_healingtouch' si la ruta es 'Interface/Icons'

Puede ver una lista de texturas dinámicas escribiendo "$" (símbolo de dólar, ALT.-36) en esta casilla.

Puede usar sus propias texturas también mientras estén situadas en el directorio de WoW (establezca este campo a la ruta de la textura relativa a la carpeta raíz de WoW), sean formato .tga o .blp, y tengan dimensiones que sean potencias de 2 (32, 64, 128, etc)]=]
L["ICONMENU_CUSTOMTEX_MOPAPPEND_DESC"] = "Si esta textura se muestra como verde sólido, y su textura personalizada está en la carpeta raíz de WoW, por favor muévala a un subdirectorio de la raíz de WoW y actualice el ajuste aquí adecuadamente para que funcione correctamente. Si la textura personalizada está asignada a un hechizo, y es un nombre de hechizo o un hechizo que ya no existe, debería intender cambiarla al ID de hechizo de un hechizo que exista. "
L["ICONMENU_DEBUFF"] = "Desventaja"
L["ICONMENU_DISPEL"] = "Tipo de Disipación"
L["ICONMENU_DONTREFRESH"] = "No Refrescar"
L["ICONMENU_DONTREFRESH_DESC"] = "Marque para forzar que el tiempo de reutilización no se restablezca si la activación sucede mientras aún está en cuenta atrás. "
L["ICONMENU_DR"] = "Rendimiento Decreciente"
L["ICONMENU_DRABSENT"] = "No afectado por Rendimiento Decreciente"
L["ICONMENU_DR_DESC"] = "Sigue la duración y extensión del rendimiento decreciente. "
L["ICONMENU_DRPRESENT"] = "Afectado por Rendimiento Decreciente"
L["ICONMENU_DRS"] = "Rendimientos Decrecientes"
L["ICONMENU_DURATION_MAX_DESC"] = "Duración máxima permitida para mostrar el icono, en segundos"
L["ICONMENU_DURATION_MIN_DESC"] = "Duración mínima requerida para mostrar el icono, en segundos"
L["ICONMENU_ENABLE"] = "Habilitado"
L["ICONMENU_ENABLE_DESC"] = "Los iconos sólo funcionarán cuando estén habilitados. "
L["ICONMENU_FAIL2"] = "No se cumplen las condiciones"
L["ICONMENU_FAKEMAX"] = "Máximo artificial"
L["ICONMENU_FAKEMAX_DESC"] = [=[Establece un valor máximo artificial para el temporizador. 

Puede usar este ajuste para hacer que un grupo de iconos al completo decaiga al mismo ratio, lo que puede proporcional una indicación visual de qué temporizadores terminarán primero. 

Establezca esto a 0 para deshabilitar este ajuste. ]=]
L["ICONMENU_FOCUS"] = "Foco"
L["ICONMENU_FOCUSTARGET"] = "Objetivo del foco"
L["ICONMENU_FRIEND"] = "Unidades Amigas"
L["ICONMENU_GHOUL"] = "Necrófago sin %s"
L["ICONMENU_GHOUL_DESC"] = "Sigue a su necrófago si no dispone del talento %s."
L["ICONMENU_HIDENOUNITS"] = "Ocultar si no hay unidades"
L["ICONMENU_HIDENOUNITS_DESC"] = "Marque esto para hacer que el icono se oculte si todas las unidades que este icono está comprobando han sido invalidadas por condiciones de unidad y/o por no existir las unidades."
L["ICONMENU_HIDEUNEQUIPPED"] = "Ocultar cuando la ranura carezca de arma"
L["ICONMENU_HIDEUNEQUIPPED_DESC"] = "Marque esto para forzar al icono a ocultarse si la ranura de arma siendo comprobada no tiene un arma en ella, o si esa ranura tiene un escudo o un adorno de mano izquierda. "
L["ICONMENU_HOSTILE"] = "Unidades Hostiles"
L["ICONMENU_ICD"] = "Tiempo de Reutilización Interno"
L["ICONMENU_ICDAURA_DESC"] = [=[Seleccione esta opción si el tiempo de reutilización interno comienza cuando: 

|cff7fffff1)|r Una ventaja o desventaja es aplicada por usted mismo (incluye procs), ó
|cff7fffff2)|r Se causa daño, ó 
|cff7fffff3)|r Usted es energizado con mana/ira/etc.
|cff7fffff4)|r Usted invoca o crea un objeto o PNJ. 

Debe introducir, en la caja de edición %q, el nombre de hechizo/ID de: 

|cff7fffff1)|r La ventaja/desventaja que usted gana cuando el tiempo de reutilización interno es activado, ó
|cff7fffff2)|r El hechizo que hace daño (compruebe su registro de combate), ó
|cff7fffff3)|r El efecto energizador (compruebe su registro de combate), ó
|cff7fffff3)|r El hechizo que activó la invocación (compruebe su registro de combate).]=]
L["ICONMENU_ICDBDE"] = "Ventaja/Desventaja/Daño/Energización/Invocación"
L["ICONMENU_ICD_DESC"] = [=[Sigue el tiempo de reutilización de un proc o un efecto similar. 

|cFFFF5959IMPORTANTE|r: Vea los tooltips bajo las configuraciones %q para saber cómo seguir cada tipo de tiempo de reutilización interno.]=]
L["ICONMENU_ICDTYPE"] = "Tiempo de reutilización comienza en..."
L["ICONMENU_IGNORENOMANA"] = "Ignorar falta de poder"
L["ICONMENU_IGNORENOMANA_DESC"] = "Marque esto para hacer que la habilidad no sea tratada como inutilizable si únicamente falta poder para usarla. "
L["ICONMENU_IGNORERUNES"] = "Ignorar Runas"
L["ICONMENU_IGNORERUNES_DESC"] = "Marque esto para tratar el tiempo de reutilización como usable si la única cosa impidiéndolo es un tiempo de reutilización de runa (o un tiempo de reutilización global)"
L["ICONMENU_IGNORERUNES_DESC_DISABLED"] = "Debe habilidad el ajuste \"Comprobación de Tiempo de Reutilización\" para habilitar el ajuste \"Ignorar Runas\"."
L["ICONMENU_INVERTBARDISPLAYBAR_DESC"] = "Marque esta opción para hacer que la barra se llene hasta cubrir la totalidad de su ancho cuando la duración llegue a cero. "
L["ICONMENU_INVERTBARS"] = "Rellenar barra"
L["ICONMENU_INVERTCBAR_DESC"] = "Marque esta opción para hacer que la barra superpuesta se llene hasta cubrir la anchura completa del icono conforme la duración alcanza cero. "
L["ICONMENU_INVERTPBAR_DESC"] = "Marque esta opción para hacer que la barra superpuesta se llene hasta cubrir la anchura completa del icono conforme el poder llega a ser suficiente. "
L["ICONMENU_ISPLAYER"] = "Unidad Es Jugador"
L["ICONMENU_ITEMCOOLDOWN"] = "Tiempo de reutilización de Objeto"
L["ICONMENU_ITEMCOOLDOWN_DESC"] = "Sigue los tiempos de reutilización de objetos con efectos de Uso."
L["ICONMENU_LIGHTWELL_DESC"] = "Sigue la duración y cargas de su %s"
L["ICONMENU_MANACHECK"] = "Comprobación de poder"
L["ICONMENU_MANACHECK_DESC"] = "Marque esto para permitir cambiar el color del icono cuando usted esté sin mana/ira/poder rúnico/etc."
L["ICONMENU_META"] = "Meta Icono"
L["ICONMENU_META_DESC"] = [=[Combina múltiples iconos en uno.

Los iconos que tengan %q marcado aún se mostrarán en un meta icono si fuesen a ser mostrados por otro motivo.]=]
L["ICONMENU_META_ICONMENUTOOLTIP"] = "(%d |4Icono:Iconos;)"
L["ICONMENU_MOUSEOVER"] = "Bajo el ratón"
L["ICONMENU_MOUSEOVERTARGET"] = "Objetivo de unidad bajo el ratón"
L["ICONMENU_MOVEHERE"] = "Mover aquí"
L["ICONMENU_MULTISTATECD"] = "Habilidad Multi-estado"
L["ICONMENU_MULTISTATECD_DESC"] = [=[Controla una habilidad con múltiples estados. 

Esto debería usarse cuando quiera controlar los múltiples estados y texturas de un tiempo de reutilización como %s o %s]=]
L["ICONMENU_MUSHROOMS"] = "%s"
L["ICONMENU_MUSHROOMS_DESC"] = "Sigue un %s."
L["ICONMENU_NOTCOUNTING"] = "Temporizador no corriendo"
L["ICONMENU_NOTCOUNTING_DESC"] = "Muestra el icono cuando el temporizador del icono no está activo"
L["ICONMENU_OFFS"] = "Desplazamiento"
L["ICONMENU_ONFAIL"] = "Al Incumplir"
L["ICONMENU_ONLYBAGS"] = "Sólo si en bolsas"
L["ICONMENU_ONLYBAGS_DESC"] = "Marque esto para hacer que el icono se muestre sólo si el objeto está en sus bolsas (o equipado). Si \"Sólo si equipado\" está activado, esta opción se activa forzosamente. "
L["ICONMENU_ONLYEQPPD"] = "Sólo si equipado"
L["ICONMENU_ONLYEQPPD_DESC"] = "Marque esto para hacer que el icono se muestre sólo si el objeto está equipado."
L["ICONMENU_ONLYIFCOUNTING"] = "Sólo mostrar si el temporizador está activo"
L["ICONMENU_ONLYIFCOUNTING_DESC"] = "Marque esto para hacer que el icono se muestre sólo si hay actualmente un temporizador activo corriendo en el icono con una duración mayor que 0."
L["ICONMENU_ONLYIFNOTCOUNTING"] = "Sólo mostrar si el temporizador no está activo"
L["ICONMENU_ONLYIFNOTCOUNTING_DESC"] = "Marque esto para hacer que el icono se muestre sólo si no NO hay un temporizador activo corriendo en el icono con una duración mayor que 0."
L["ICONMENU_ONLYINTERRUPTIBLE"] = "Sólo Interrumpible"
L["ICONMENU_ONLYINTERRUPTIBLE_DESC"] = "Marque esta casilla para mostrar sólo lanzamientos de hechizos que son interrumpibles"
L["ICONMENU_ONLYMINE"] = "Sólo comprobar los míos"
L["ICONMENU_ONLYMINE_DESC"] = "Marque esta opción para hacer que este icono sólo compruebe ventajas/desventajas que usted lanzó"
L["ICONMENU_ONLYSEEN"] = "Sólo si visto"
L["ICONMENU_ONLYSEEN_DESC"] = "Marque esto para hacer que el icono sólo muestre un tiempo de reutilización si la unidad lo ha lanzado al menos una vez. Debería marcar esto si está comprobando hechizos de diferentes clases en un solo icono. "
L["ICONMENU_ONSUCCEED"] = "Al Cumplir"
L["ICONMENU_PETTARGET"] = "Objetivo de la mascota"
L["ICONMENU_PRESENT"] = "Presente"
L["ICONMENU_PRESENTONALL"] = "Presente en Todas las Unidades" -- Needs review
L["ICONMENU_PRESENTONALL_DESC"] = "Establece el nivel de opacidad al que el icono debería mostrarse cuando todas las unidades siendo comprobadas tengan al menos una de las ventajas/desventajas siendo comprobadas. " -- Needs review
L["ICONMENU_RANGECHECK"] = "Comprobación de alcance"
L["ICONMENU_RANGECHECK_DESC"] = "Marque esto para permitir cambiar el color del icono cuando usted esté fuera de alcance. "
L["ICONMENU_REACT"] = "Reacción de Unidad"
L["ICONMENU_REACTIVE"] = "Habilidad Reactiva"
L["ICONMENU_REACTIVE_DESC"] = [=[Sigue la usabilidad de habilidades reactivas. 

Habilidades reactivas son cosas como %s, %s y %s - habilidades que sólo se pueden usar cuando se cumplen ciertas condiciones. ]=]
L["ICONMENU_RUNEOFPOWER_DESC"] = "Sigue las runas del talento %s."
L["ICONMENU_RUNES"] = "Tiempo de Reutilización de Runa"
L["ICONMENU_RUNES_CHARGES"] = "Runas inutilizables como cargas"
L["ICONMENU_RUNES_CHARGES_DESC"] = "Active este ajusta para hacer que el icono trate cualquier runa que está en tiempo de reutilización como una carga extra (mostrado en el deslizador de tiempo de reutilización) cuando el icono esté mostrando una runa utilizable. "
L["ICONMENU_RUNES_DESC"] = "Sigue tiempos de reutilización de runas"
L["ICONMENU_SHOWCBAR_DESC"] = "Muestra una barra que se superpone sobre la mitad inferior del icono que indicará el tiempo de reutilización/duración restante (o el tiempo transcurrido si \"Llenar barras\" está marcado)"
L["ICONMENU_SHOWPBAR_DESC"] = "Muestra una barra que se superpone sobre la mitad superior del icono que indicará el poder faltante para lanzar el hechizo (o el poder que ya tienes cuando \"Llenar barras\" está marcado)"
L["ICONMENU_SHOWSTACKS"] = "Mostrar montones. "
L["ICONMENU_SHOWSTACKS_DESC"] = "Marque esto para mostrar el número de montones del objeto que tiene. "
L["ICONMENU_SHOWTIMER"] = "Mostrar reloj"
L["ICONMENU_SHOWTIMER_DESC"] = "Marque esta opción para mostrar la animación estándar de barrido de tiempo de reutilización en el icono. "
L["ICONMENU_SHOWTIMERTEXT"] = "Mostrar texto de temporizador"
L["ICONMENU_SHOWTIMERTEXT_DESC"] = [=[Marque esta opción para que se muestre en texto la duración/tiempo de reutilización restante en el icono. 

Esto sólo es aplicable si OmniCC (o similar) está instalado. ]=]
L["ICONMENU_SHOWTIMERTEXT_NOOCC"] = "Mostrar texto de temporizador ElvUI"
L["ICONMENU_SHOWTIMERTEXT_NOOCC_DESC"] = [=[Marque esta opción para mostrar el display de texto de ElvUI del tiempo restante de duración/tiempo de reutilización del icono. 

Este ajuste sólo afecta al temporizador de ElvUI. Si tiene otro addon que provea temporizadores (como OmniCC), puede controlar esos temporizadores con el ajuste %q. No se recomienda tener ambos ajustes activados al tiempo. ]=]
L["ICONMENU_SHOWTTTEXT"] = "Mostrar texto variable"
L["ICONMENU_SHOWTTTEXT_DESC"] = [=[Marque esto para mostrar la primera variable asociada con el aura que está siendo mostrada. Usos prácticos incluyen seguir las cantidades de daño de escudo. 

Este valor será mostrado en el lugar del contador de acumulación del icono. 

Los números son proporcionados por la API de Blizzard y no coinciden necesariamente con los números mostrados en el tooltip del aura. Para la mayor parte de casos prácticos, sin embargo, se mostrará el número correcto. ]=]
L["ICONMENU_SHOWWHEN"] = "Mostrar Estados y Opacidad"
L["ICONMENU_SHOWWHENNONE"] = "Mostrar si no hay resultado"
L["ICONMENU_SHOWWHENNONE_DESC"] = "Marque esto para permitir que el icono se muestre como No Afectado por Rendimiento Decreciente cuando no se detectan rendimientos decrecientes en ninguna unidad. "
L["ICONMENU_SHOWWHEN_OPACITY_GENERIC_DESC"] = "Establece el nivel de opacidad que debería mostrar el icono en este estado de icono. "
L["ICONMENU_SHOWWHEN_OPACITYWHEN_WRAP"] = "Opacidad cuando %s|r"
L["ICONMENU_SHOWWHEN_SHOW_GENERIC_DESC"] = "Establece si este icono debería mostrarse para este estado de icono. "
L["ICONMENU_SHOWWHEN_SHOWWHEN_WRAP"] = "Mostrar cuando %s|r"
L["ICONMENU_SORTASC"] = "Duración baja"
L["ICONMENU_SORTASC_DESC"] = "Marque esta casilla para priorizar y mostrar hechizos con la menor duración."
L["ICONMENU_SORTASC_META_DESC"] = "Marque esta casilla para priorizar y mostrar iconos con la duración más baja. "
L["ICONMENU_SORTDESC"] = "Duración alta"
L["ICONMENU_SORTDESC_DESC"] = "Marque esta casilla para priorizar y mostrar hechizos con la mayor duración."
L["ICONMENU_SORTDESC_META_DESC"] = "Marque esta casilla para priorizar y mostrar iconos con la duración más alta."
L["ICONMENU_SPELLCAST_COMPLETE"] = "Lanzamiento de Hechizo Completo/Lanzamiento Instantáneo"
L["ICONMENU_SPELLCAST_COMPLETE_DESC"] = [=[Seleccione esta opción si el tiempo de reutilización interno comienza cuando: 

|cff7fffff1)|r Termina de lanzar un hechizo, ó
|cff7fffff2)|r Lanza un hechizo instantáneo.

Debe introducir el nombre/ID del lanzamiento de hechizo que activa el tiempo de reutilización interno en el cuadro de edición %q]=]
L["ICONMENU_SPELLCAST_START"] = "Lanzamiento de Hechizo Comenzado"
L["ICONMENU_SPELLCAST_START_DESC"] = [=[Seleccione esta opción si el tiempo de reutilización interno comienza cuando: 

|cff7fffff1)|r Comienza a lanzar un hechizo.

Debe introducir el nombre/ID del lanzamiento de hechizo que activa el tiempo de reutilización interno en el cuadro de edición %q]=]
L["ICONMENU_SPELLCOOLDOWN"] = "Tiempo de reutilización de Hechizo"
L["ICONMENU_SPELLCOOLDOWN_DESC"] = "Sigue el tiempo de reutilización de hechizos de su libro de hechizos."
L["ICONMENU_SPLIT"] = "Separar a un grupo nuevo"
L["ICONMENU_SPLIT_DESC"] = "Crear un grupo nuevo y mover este icono a él. Muchos ajustes de grupo se mantendrán en el nuevo grupo. "
L["ICONMENU_STACKS_MAX_DESC"] = "Número máximo de acumulaciones permitidas para mostrar el icono"
L["ICONMENU_STACKS_MIN_DESC"] = "Número mínimo de acumulaciones necesarias para mostrar el icono"
L["ICONMENU_STEALABLE"] = "Sólo robable"
L["ICONMENU_STEALABLE_DESC"] = "Marque esto para mostrar sólo ventajas con las que se pueda usar Robar hechizo. Recomendable usar cuando se está comprobando el tipo de disipación \"Magia\""
L["ICONMENU_SUCCEED2"] = "Condiciones Se Cumplen"
L["ICONMENU_SWAPWITH"] = "Intercambiar con"
L["ICONMENU_SWINGTIMER"] = "Temporizador de golpe"
L["ICONMENU_SWINGTIMER_DESC"] = "Sigue los temporizadores de golpe de sus armas de mano principal y de mano izquierda."
L["ICONMENU_SWINGTIMER_NOTSWINGING"] = "No golpeando"
L["ICONMENU_SWINGTIMER_SWINGING"] = "Golpeando"
L["ICONMENU_TARGETTARGET"] = "El objetivo del objetivo"
L["ICONMENU_TOTEM"] = "Tótem"
L["ICONMENU_TOTEM_DESC"] = "Sigue sus tótems"
L["ICONMENU_TYPE"] = "Tipo de icono"
L["ICONMENU_UNITCOOLDOWN"] = "Tiempo de reutilización de Unidad"
L["ICONMENU_UNITCOOLDOWN_DESC"] = [=[Sigue los tiempos de reutilización de otro.

Se puede comprobar %s usando %q como nombre.]=]
L["ICONMENU_UNIT_DESC"] = [=[Introduce las unidades a vigilar en este cuadro. Las unidades pueden insertarse desde la lista de sugerencias a la derecha. Los usuarios avanzados pueden escribir sus propias unidades. 

Las unidades estándar (p.ej. jugador) y/o los nombres de los jugadores que están en tu grupo (p.ej. %s) pueden ser usados como unidades. 

Separa múltiples unidades con punto y coma (;).

Para más información sobre unidades, consulta http://www.wowpedia.org/UnitId]=]
L["ICONMENU_UNIT_DESC_CONDITIONUNIT"] = [=[Introduzca la unidad a observar en este cuadro. La unidad puede insertarse desde la lista de sugerencias a la derecha, o usuarios avanzados pueden escribir su propia unidad. 


Unidades estándar (p.ej. jugador) y/o los nombres de los jugadores en su grupo (p.ej. %s) pueden ser usadas. 

Para más información sobre unidades, vaya a http://www.wowpedia.org/UnitId]=]
L["ICONMENU_UNIT_DESC_UNITCONDITIONUNIT"] = [=[Introduzca la unidad a observar en este cuadro. La unidad puede insertarse desde la lista de sugerencias a la derecha. 

"unidad" es un alias para cada unidad que el icono está comprobando.]=]
L["ICONMENU_UNITS"] = "Unidades"
L["ICONMENU_UNITSTOWATCH"] = "Unidad(es) a vigilar"
L["ICONMENU_UNUSABLE"] = "Inutilizable"
L["ICONMENU_USABLE"] = "Utilizable"
L["ICONMENU_USEACTIVATIONOVERLAY"] = "Comprobar borde de activación"
L["ICONMENU_USEACTIVATIONOVERLAY_DESC"] = "Marque esto para hacer que la presencia del borde amarillo chispeante alrededor de una acción obligue al icono a actuar como utilizable."
L["ICONMENU_VEHICLE"] = "Vehículo"
L["ICONMENU_WPNENCHANT"] = "Encantamiento de Arma"
L["ICONMENU_WPNENCHANT_DESC"] = "Sigue encantamientos de arma temporales. "
L["ICONMENU_WPNENCHANTTYPE"] = "Ranura de arma a controlar"
L["IconModule_CooldownSweepCooldown"] = "Barrido de Tiempo de Reutilización"
L["IconModule_IconContainer_MasqueIconContainer"] = "Contenedor de Iconos"
L["IconModule_IconContainer_MasqueIconContainer_DESC"] = "Contiene las partes principales del icono, como la textura"
L["IconModule_PowerBar_OverlayPowerBar"] = "Barra de Poder Superpuesta"
L["IconModule_SelfIcon"] = "Icono"
L["IconModule_Texture_ColoredTexture"] = "Textura de icono"
L["IconModule_TimerBar_BarDisplayTimerBar"] = "Barra de Temporizador (display de barra)"
L["IconModule_TimerBar_OverlayTimerBar"] = "Barra de Temporizador Superpuesta"
L["ICONTOCHECK"] = "Icono a comprobar"
L["ICON_TOOLTIP2NEW"] = [=[|cff7fffffClick-Derecho|r para opciones del icono.
|cff7fffffClick-Derecho y arrastrar|r a otro icono para mover/copiar.
|cff7fffffArrastrar|r hechizos y objetos al icono para configuración rápida.]=]
L["ICON_TOOLTIP2NEWSHORT"] = "|cff7fffffClick-derecho|r para opciones del icono. "
L["ICONTYPE_DEFAULT_HEADER"] = "Instrucciones"
L["ICONTYPE_DEFAULT_INSTRUCTIONS"] = [=[Para empezar a configurar este icono, seleccione un tipo de icono del menú desplegable %q más arriba.

Asegúrese de también marcar el ajuste %q de modo que este icono funcione. 

Recuerde que los iconos sólo funcionan cuando TellMeWhen está en su estado bloqueado, así que que escriba '/tmw' cuando termine esta configuración. 

Mientras configura TellMeWhen, asegúrese de leer los tooltips para cada ajuste. Estos tooltips a menudo contienen información importante sobre cómo funciona el ajuste!]=] -- Needs review
L["ICONTYPE_SWINGTIMER_TIP"] = [=[Intentando seguir el temporizador de su %s? El tipo de icono %q tiene la funcionalidad que desea. Simplemente establezca un %s para seguir %q (ID de hechizo %d)!

También puede pulsar el botón de abajo para aplicar automáticamente los ajustes adecuados. ]=]
L["ICONTYPE_SWINGTIMER_TIP_APPLYSETTINGS"] = "Aplicar Ajustes %s"
L["ImmuneToMagicCC"] = "Inmune al Control de Masas mágico"
L["ImmuneToStun"] = "Inmune al Aturdimiento"
L["IMPORTERROR_FAILEDPARSE"] = "Hubo un error procesando la cadena. Asegúrese de que ha copiado la cadena entera desde la fuente. "
L["IMPORTERROR_INVALIDTYPE"] = "Intentó importar datos de un tipo desconocido. Compruebe si tiene la última versión de TellMeWhen instalada. "
L["IMPORT_EXPORT"] = "Importar/Exporar/Restaurar"
L["IMPORT_EXPORT_BUTTON_DESC"] = "Pulse este botón para importar y exportar iconos, grupos y perfiles."
L["IMPORT_EXPORT_DESC"] = [=[Pulse el botón a la derecha para importar y exportar iconos, grupos y perfiles. 

Importar a o desde una cadena, o exportar a otro jugador, requerirá el uso de este cuadro de edición. Vea los tooltips en el menú desplegable para más detalles. ]=]
L["IMPORT_EXPORT_DESC_INLINE"] = "Importar y Exportar perfiles, grupos, iconos a o de cadenas, otros jugadores, otros perfiles, o un backup de sus ajustes. "
L["IMPORT_FROMBACKUP"] = "Desde Backup"
L["IMPORT_FROMBACKUP_DESC"] = "Los ajustes restaurados desde este menú quedarán como estaban a las: %s"
L["IMPORT_FROMBACKUP_WARNING"] = "AJUSTES DE BACKUP: %s"
L["IMPORT_FROMCOMM"] = "Desde Jugador"
L["IMPORT_FROMCOMM_DESC"] = "Si otro usuario de TellMeWhen le manda datos de configuración, podrá importarlos desde este submenú. "
L["IMPORT_FROMLOCAL"] = "Desde Perfil"
L["IMPORT_FROMSTRING"] = "Desde Cadena"
L["IMPORT_FROMSTRING_DESC"] = [=[Las cadenas le permiten transferir datos de configuración de TellMeWhen fuera del juego. 

Para importar desde una cadena, pulse CTRL+V para pegar la cadena en el cuadro de edición tras copiarla al portapapeles, y entonces navegue de vuelta a este submenú. ]=]
L["IMPORT_HEADING"] = "Importar"
L["IMPORT_ICON_DISABLED_DESC"] = "Debe estar editando un icono para ser capaz de importar un icono. "
L["IMPORT_PROFILE"] = "Copiar Perfil"
L["IMPORT_PROFILE_NEW"] = "|cff59ff59Crear|r Nuevo Perfil"
L["IMPORT_PROFILE_OVERWRITE"] = "|cFFFF5959Sobreescribir|r %s"
L["IMPORT_SUCCESSFUL"] = "Importado con éxito!"
L["Incapacitated"] = "Incapacitado"
L["INCHEALS"] = "Sanaciones entrantes de la unidad"
L["INCHEALS_DESC"] = [=[Comprueba la cantidad total de sanación que está entrando a la unidad (tanto sanaciones en el tiempo como lanzamientos en marcha)

Sólo funciona para unidades amigas. Las unidades hostiles informarán siempre que tienen 0 sanaciones entrantes. ]=]
L["IncreasedAP"] = "Poder de Ataque aumentado"
L["IncreasedCrit"] = "Probabilidad de Crítico Aumentada"
L["IncreasedMastery"] = "Maestría Incrementada"
L["IncreasedPhysHaste"] = "Celeridad Física Aumentada"
L["IncreasedSP"] = "Poder con hechizos incrementado"
L["IncreasedSpellHaste"] = "Celeridad con Hechizos Aumentada"
L["IncreasedSPsix"] = "Poder con Hechizos Aumentado (6%)"
L["IncreasedSPten"] = "Poder con Hechizos Aumentado (10%)"
L["IncreasedStats"] = "Estadísticas Aumentadas"
L["INRANGE"] = "Al alcance"
L["ITEMCOOLDOWN"] = "Tiempo de reutilización de objeto"
L["ITEMEQUIPPED"] = "Objeto está equipado"
L["ITEMINBAGS"] = "Cuenta de objetos (incluye cargas)"
L["ITEMTOCHECK"] = "Objeto a Comprobar"
L["ITEMTOCOMP1"] = "Primer Objeto a Comparar"
L["ITEMTOCOMP2"] = "Segundo Objeto a Comparar"
L["LAYOUTDIRECTION"] = "Dirección de Disposición"
L["LAYOUTDIRECTION_1"] = "Derecha y luego Abajo"
L["LAYOUTDIRECTION_2"] = "Izquierda y luego Abajo"
L["LAYOUTDIRECTION_3"] = "Izquierda y luego Arriba"
L["LAYOUTDIRECTION_4"] = "Derecha y luego Arriba"
L["LAYOUTDIRECTION_5"] = "Abajo y luego Derecha"
L["LAYOUTDIRECTION_6"] = "Abajo luego Izquierda"
L["LAYOUTDIRECTION_7"] = "Arriba luego Izquierda"
L["LAYOUTDIRECTION_8"] = "Arriba luego Derecha"
L["LAYOUTDIRECTION_DESC"] = "Establece la dirección en la que los iconos se dispondrán en el grupo."
L["LDB_TOOLTIP1"] = "|cff7fffffClick-Izquierdo|r para activar/desactivar los bloqueos de grupo"
L["LDB_TOOLTIP2"] = "|cff7fffffClick-Derecho|r para mostrar las opciones principales de TMW"
L["LEFT"] = "Izquierda"
L["LOADERROR"] = "No se pudo cargar TellMeWhen_Options:"
L["LOADINGOPT"] = "Cargando TellMeWhen_Options."
L["LOCKED"] = "Bloqueado"
L["LOSECONTROL_CONTROLLOST"] = "Pérdida de control"
L["LOSECONTROL_DROPDOWNLABEL"] = "Tipos de pérdida de control"
L["LOSECONTROL_DROPDOWNLABEL_DESC"] = "Elija los tipos de pérdida de control a los que desea que este icono reaccione. "
L["LOSECONTROL_ICONTYPE"] = "Pérdida de Control"
L["LOSECONTROL_ICONTYPE_DESC"] = "Controla efectos que causan la pérdida de control de su personaje. "
L["LOSECONTROL_INCONTROL"] = "Controlando"
L["LOSECONTROL_TYPE_ALL"] = "Todos los tipos"
L["LOSECONTROL_TYPE_ALL_DESC"] = "Hace que el icono muestre información sobre todos los tipos de efectos"
L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"] = "NOTA: No se sabe si este tipo de pérdida de control se está usando o no. "
L["LOSECONTROL_TYPE_MAGICAL_IMMUNITY"] = "Inmunidad mágica"
L["LOSECONTROL_TYPE_SCHOOLLOCK"] = "Escuela de hechizo bloqueada"
L["LUACONDITION"] = "Lua (Avanzado)"
L["LUACONDITION_DESC"] = [=[Este tipo de condición permite evaluar código Lua para determinar el estado de una condición. 

La entrada no es una sentencia "if .. then", ni es un cierre de función. Es una sentencia normal que será evaluada, p.ej. "a y b o c". Si se requiere una funcionalidad compleja, use una llamada a función, p.ej. 'CompruebaCosas()', que se defina externamente. 

Si se requiere más ayuda (que no sea sobre cómo escribir código Lua), abra un ticket en CurseForge. Para ayuda sobre cómo escribir Lua, vaya a Internet. ]=] -- Needs review
L["MACROCONDITION"] = "Condición de Macro"
L["MACROCONDITION_DESC"] = [=[Esta condición evaluará una condición de macro, y será cumplirá si ésta se cumple. Todas las condiciones de macro pueden ser prefijadas con "no" para invertir lo que comprueban. 

Ejemplos: 
    "[nomodifier:alt]" - no se está manteniendo pulsando la tecla Alt
    "[@target, help][mod:ctrl]" - el objetivo es amistoso O se está manteniendo pulsado Ctrl
    "[@focus, harm, nomod:shift]" - el foco es hostil Y no se está manteniendo pulsado Shift

Para más ayuda, vaya a http://www.wowpedia.org/Making_a_macro]=]
L["MACROCONDITION_EB_DESC"] = "Si se usa una condición simple, las llaves de apertura y cierre son opcionales. Las llaves son necesarias si se están usando condicionales múltiples. "
L["MACROTOEVAL"] = "Condicional(es) de Macro a Evaluar"
L["Magic"] = "Magia"
L["MAIN"] = "Principal"
L["!!Main Addon Description"] = "Proporciona notificaciones visuales, auditivas y textuales sobre tiempos de reutilización, ventajas y básicamente cualquier otra cosa. "
L["MAINASSIST"] = "Asistente Principal"
L["MAIN_DESC"] = "Contiene las opciones principales para este icono. "
L["MAINTANK"] = "Tanque Principal"
L["MAKENEWGROUP"] = "|cff59ff59Crear|r Nuevo Grupo"
L["MELEECRIT"] = "Crítico Cuerpo a Cuerpo"
L["MELEEHASTE"] = "Celeridad Cuerpo a Cuerpo"
L["MESSAGERECIEVE"] = "%s te ha mandado datos de TellMeWhen! Puedes importar estos datos en TellMeWhen usando el botón %q, ubicado en la parte baja del editor de iconos. "
L["MESSAGERECIEVE_SHORT"] = "%s te ha mandado datos de TellMeWhen!"
L["META_ADDICON"] = "Añadir Icono"
L["META_ADDICON_DESC"] = "Pulse para añadir otro icono a incluir en este meta icono. "
L["META_GROUP_INVALID_VIEW_DIFFERENT"] = [=[Los iconos de este grupo no pueden ser comprobados por este meta icono porque usan métodos de visualización diferentes. 

Este grupo: %s
Grupo objetivo: %s]=]
L["METAPANEL_DOWN"] = "Mover abajo"
L["METAPANEL_REMOVE"] = "Eliminar icono"
L["METAPANEL_REMOVE_DESC"] = "Click para eliminar este icono de la lista que el metaicono comprobará. "
L["METAPANEL_UP"] = "Mover arriba"
L["MISCELLANEOUS"] = "Varios"
L["MiscHelpfulBuffs"] = "Ventajas Útiles Varias "
L["MOON"] = "Luna"
L["MOUSEOVERCONDITION"] = "Ratón está Encima"
L["MOUSEOVERCONDITION_DESC"] = "Esta condición comprueba si su ratón está sobre el icono o grupo al que está adjunta la condición. "
L["MOUSEOVER_TOKEN_NOT_FOUND"] = "<Nada bajo el ratón>"
L["MovementSlowed"] = "Movimiento Ralentizado"
L["MP5"] = "%d MP5"
L["MUSHROOM"] = "Champiñón %d"
L["MUSHROOMS"] = "Champiñones a comprobar"
L["NEWVERSION"] = "Hay una nueva versión de TellMeWhen disponible: %s"
L["NONE"] = "Ninguno de estos"
L["normal"] = "Normal"
L["NOTINRANGE"] = "Fuera de alcance"
L["NOTYPE"] = "<Sin Tipo de Icono>"
L["NUMAURAS"] = "Número de"
L["NUMAURAS_DESC"] = "Esta condición comprueba el número de un aura activa - no confundir con el número de acumulaciones de un aura. Esto es para comprobar cosas como si tienes ambos procs de los encantamientos de arma activos al mismo tiempo. Usar moderadamente, ya que el proceso usado para contar los números consume bastante CPU."
L["ONLYCHECKMINE"] = "Sólo Comprobar Míos"
L["ONLYCHECKMINE_DESC"] = "Marque esto para que esta condición sólo compruebe las ventajas/desventajas que usted lanzó"
L["OUTLINE_MONOCHORME"] = "Monocromo"
L["OUTLINE_NO"] = "Sin Contorno"
L["OUTLINE_THICK"] = "Contorno Grueso"
L["OUTLINE_THIN"] = "Contorno Fino"
L["OVERWRITEGROUP"] = "|cFFFF5959Sobreescribir|r Grupo: %s"
L["PARENTHESIS_TYPE_("] = "de apertura"
L["PARENTHESIS_TYPE_)"] = "de cierre"
L["PARENTHESIS_WARNING1"] = [=[El número de paréntesis de apertura y cierre no encaja!

Se necesitan %d paréntesis %s más.]=]
L["PARENTHESIS_WARNING2"] = [=[Algunos paréntesis de cierre carecen de apertura!

Hacen falta %d más paréntesis de apertura. ]=]
L["PERCENTAGE"] = "Porcentaje"
L["PET_TYPE_CUNNING"] = "Astucia"
L["PET_TYPE_FEROCITY"] = "Ferocidad"
L["PET_TYPE_TENACITY"] = "Tenacidad"
L["PhysicalDmgTaken"] = "Daño Físico Recibido"
L["PLAYER_DESC"] = "(Usted)"
L["Poison"] = "Veneno"
L["PRESENCE"] = "Presencia"
L["PROFILE_LOADED"] = "Perfil cargado: %s"
L["PvPSpells"] = "Control de Masas JcJ, etc."
L["QUESTIDTOCHECK"] = "ID de misión a Comprobar"
L["RAID_WARNING_FAKE"] = "Alerta de Banda (Falsa)"
L["RAID_WARNING_FAKE_DESC"] = "Saca un mensaje como una alerta de banda, pero nadie más lo verá, y no tiene que estar en una banda o tener privilegios de alerta de banda"
L["RaidWarningFrame"] = "Marco de Advertencia de Banda"
L["RANGEDCRIT"] = "Crítico a Distancia"
L["RANGEDHASTE"] = "Celeridad a Distancia"
L["rare"] = "Raro"
L["rareelite"] = "Élite Raro"
L["REACTIVECNDT_DESC"] = "Esta condición sólo comprueba el estado reactivo de la habilidad, no el tiempo de reutilización de la misma. "
L["REDO_ICON"] = "Rehacer"
L["REDO_ICON_DESC"] = "Rehacer el último cambio hecho a la configuración de este icono."
L["ReducedArmor"] = "Armadura Reducida"
L["ReducedCastingSpeed"] = "Velocidad de Lanzamiento Reducida"
L["ReducedHealing"] = "Sanación Reducida"
L["ReducedPhysicalDone"] = "Daño Físico Reducido"
L["REQFAILED_ALPHA"] = "Opacidad cuando no se cumpla"
L["RESET_ICON"] = "Restablecer"
L["RESIZE"] = "Cambiar tamaño"
L["RESIZE_TOOLTIP"] = "|cff7fffffPinchar y arrastrar|r para cambiar el tamaño"
L["RESIZE_TOOLTIP_SCALEXY"] = [=[|cff7fffffClick-y-arrastrar|r para cambiar el tamaño
|cff7fffffMantener pulsado Control|r para invertir el eje de escala]=]
L["RESIZE_TOOLTIP_SCALEY_SIZEX"] = "|cff7fffffClick-y-arrastrar|r para cambiar el tamaño"
L["RIGHT"] = "Derecha"
L["Rooted"] = "Inmovilizado"
L["RUNEOFPOWER"] = "Runa %d"
L["RUNES"] = "Runa(s) a comprobar"
L["RUNESOFPOWER"] = "Runas a comprobar"
L["RUNSPEED"] = "Velocidad de Carrera de la Unidad"
L["SAFESETUP_COMPLETE"] = "Instalación lenta y segura completada. "
L["SAFESETUP_FAILED"] = "Instalación lenta y segura FALLADA: %s"
L["SAFESETUP_TRIGGERED"] = "Ejecutando instalación lenta y segura..."
L["SEAL"] = "Sello"
L["SENDSUCCESSFUL"] = "Enviado con éxito"
L["SHAPESHIFT"] = "Cambio de forma"
L["Shatterable"] = "Destrozable"
L["Silenced"] = "Silenciado"
L["Slowed"] = "Ralentizado"
L["SORTBY"] = "Priorizar"
L["SORTBYNONE"] = "Normalmente"
L["SORTBYNONE_DESC"] = "Si esta marcado, los hechizos serán comprobados y aparecerán en el orden en que fueron introducidos en el cuadro de edición \"%s\". Si este icono es un icono de ventaja/desventaja y el número de auras siendo comprobadas excede el ajuste de umbral de eficiencia, las auras serán comprobadas en el orden en que normalmente aparecerían en la marco de unidad de la unidad." -- Needs review
L["SORTBYNONE_META_DESC"] = "Si está marcado, los iconos serán comprobados en el orden que se configuró más arriba. "
L["SOUND_CHANNEL"] = "Canal de Sonido"
L["SOUND_CHANNEL_DESC"] = [=[Elija el canal de sonido y ajuste de volumen que desearía usar para reproducir sonidos. 

Seleccionar %q permitirá que se reproduzcan sonidos incluso cuando los sonidos están apagados. ]=]
L["SOUND_CHANNEL_MASTER"] = "Maestro"
L["SOUND_CUSTOM"] = "Fichero de sonido personalizado"
L["SOUND_CUSTOM_DESC"] = [=[Inserte la ruta a un sonido personalizado a reproducir. Aquí hay algunos ejemplos, donde "fichero" es en el nombre de su sonido, y "ext" es la extensión del fichero (sólo ogg o mp3!):

- "CustomSounds\fichero.ext": Un fichero situado en una nueva carpeta llamada "CustomSounds" en el directorio raíz de WoW (la misma ubicación que Wow.exe, las carpetas Interface y WTF, etc)

- "Interface\AddOns\fichero.ext": Un fichero suelto en la carpeta AddOns

- "Fichero.ext": un fichero suelto en el directorio raíz de WoW

NOTA: Se debe reiniciar WoW para que reconozca ficheros que no existían cuando fue iniciado. ]=]
L["SOUNDERROR1"] = "El fichero debe tener una extensión!"
L["SOUNDERROR2"] = [=[Los ficheros WAV personalizados no están soportados por WoW 4.0+

(Los sonidos integrados en WoW funcionan, sin embargo)]=]
L["SOUNDERROR3"] = "Sólo soporta ficheros OGG y MP3!"
L["SOUND_EVENT_DISABLEDFORTYPE"] = "No disponible"
L["SOUND_EVENT_DISABLEDFORTYPE_DESC2"] = [=[Este evento no está disponible para la configuración actual del icono.

Esto es probablemente debido a que este evento no esté disponible para el tipo de icono actual (%s).

cff7fffffClick-Derecho|r para cambiar el evento.]=]
L["SOUND_EVENT_GLOBALDESC"] = "Los eventos se comprueban de arriba abajo en esta lista. Si se activa un evento que reproduce un sonido, ningún evento por debajo de éste reproducirá sonidos. "
L["SOUND_EVENT_ONALPHADEC"] = "Al Reducir Alfa"
L["SOUND_EVENT_ONALPHADEC_DESC"] = [=[Este evento se activa cuando la opacidad de un icono se reduce. 

NOTA: Este evento no se activará al reducir hasta 0% Opacidad (Al Ocultarse)]=]
L["SOUND_EVENT_ONALPHAINC"] = "En Incremento Alfa"
L["SOUND_EVENT_ONALPHAINC_DESC"] = [=[Este evento se activa cuando la opacidad de un icono aumenta.

NOTA: Este evento no se activará al aumentar desde 0% Opacidad (Al Mostrar)]=]
L["SOUND_EVENT_ONCLEU"] = "En Evento de Combate"
L["SOUND_EVENT_ONCLEU_DESC"] = "Este evento se activa cuando sucede un evento de combate que debería ser procesado por el icono."
L["SOUND_EVENT_ONCONDITION"] = "Al cumplirse conjunto de condiciones"
L["SOUND_EVENT_ONCONDITION_DESC"] = "Este evento se activa cuando un conjunto de condiciones que puede configurar para este evento se empiezan a cumplir. "
L["SOUND_EVENT_ONDURATION"] = "Al Cambiar Duración"
L["SOUND_EVENT_ONDURATION_DESC"] = [=[Este evento se activa cuando la duración del temporizador del icono cambia. 

Ya que este evento sucede cada vez que se actualiza el icono cuando un temporizador está corriendo, debe establecer una condición, y el evento sólo sucederá cuando el estado de esta condición cambie. ]=]
L["SOUND_EVENT_ONEVENTSRESTORED"] = "Al establecer el icono"
L["SOUND_EVENT_ONEVENTSRESTORED_DESC"] = [=[Este evento se activa inmediatamente después de que se ha establecido el icono. 

Esto sucede principalmente cuando deja el modo de configuración, pero también sucede cuando se entra/sale de una zona, entre varias otras cosas. 

También se puede pensar en esto como en un "reseteo suave" del icono. 

Este evento puede ser útil para crear un estado de animación por defecto para el icono. ]=]
L["SOUND_EVENT_ONFINISH"] = "Al Terminar"
L["SOUND_EVENT_ONFINISH_DESC"] = "Este evento se activa cuando el tiempo de reutilización se vuelve utilizable, la ventaja/desventaja termina, etc."
L["SOUND_EVENT_ONHIDE"] = "Al Ocultar"
L["SOUND_EVENT_ONHIDE_DESC"] = "Este evento se activa cuando el icono es ocultado (incluso si %q está marcado)."
L["SOUND_EVENT_ONICONHIDE"] = "Al Ocultarse Otro Icono"
L["SOUND_EVENT_ONICONHIDE_DESC"] = [=[Este evento se activa cuando otro icono (no este icono) es ocultado.

Configure el icono que debería ser observado usando los ajustes de evento más abajo.]=]
L["SOUND_EVENT_ONICONSHOW"] = "Al Mostrarse Otro Icono"
L["SOUND_EVENT_ONICONSHOW_DESC"] = [=[Este evento se activa cuando otro icono (no este icono) es mostrado.

Configure el icono que debería ser observado usando los ajustes de evento más abajo.]=]
L["SOUND_EVENT_ONLEFTCLICK"] = "En Click Izquierdo"
L["SOUND_EVENT_ONLEFTCLICK_DESC"] = "Este evento se activa cuando hace |cff7fffffClick-Izquierdo|r en el icono mientras los iconos están bloqueados. "
L["SOUND_EVENT_ONRIGHTCLICK"] = "Al hacer Click Derecho"
L["SOUND_EVENT_ONRIGHTCLICK_DESC"] = "Este evento se activa cuando hace |cff7fffffClick-Derecho|r en el icono mientras los iconos están bloqueados. "
L["SOUND_EVENT_ONSHOW"] = "Al Mostrar"
L["SOUND_EVENT_ONSHOW_DESC"] = "Este evento se activa cuando el icono pasa a mostrarse (incluso si %q está marcado)"
L["SOUND_EVENT_ONSPELL"] = "Al Cambiar de Hechizo"
L["SOUND_EVENT_ONSPELL_DESC"] = "Este evento se activa cuando el hechizo/objeto/etc. para el que el icono está mostrando información ha cambiado."
L["SOUND_EVENT_ONSTACK"] = "Al Cambiar Acumulación"
L["SOUND_EVENT_ONSTACK_DESC"] = [=[Este evento se activa cuando cambia la acumulación de lo que sea que el objeto está siguiendo. 

Esto incluye la cantidad de decrecimiento de eficiencia para iconos %s. ]=]
L["SOUND_EVENT_ONSTART"] = "Al Empezar"
L["SOUND_EVENT_ONSTART_DESC"] = "Ese evento se activa cuando el tiempo de reutilización se vuelve inutilizable, se aplica la ventaja/desventaja, etc."
L["SOUND_EVENT_ONUNIT"] = "Al Cambiar Unidad"
L["SOUND_EVENT_ONUNIT_DESC"] = "Este evento se activa cuando la unidad para la que el icono está mostrando información ha cambiado."
L["SOUND_SOUNDTOPLAY"] = "Sonido a Reproducir"
L["SOUND_TAB"] = "Sonido"
L["SPEED"] = "Velocidad de la Unidad"
L["SPEED_DESC"] = "Esto se refiere a la velocidad de movimiento actual de la unidad. Si la unidad no se está moviendo, es cero. Si desea seguir la velocidad máxima de carrera de la unidad, use la condición \"Velocidad de Carrera de la Unidad\""
L["SPELLCHARGES"] = "Cargas de hechizo"
L["SPELLCHARGES_DESC"] = "Sigue las cargas de un hechizo como %s o %s."
L["SPELLCHARGES_FULLYCHARGED"] = "Completamente cargado"
L["SPELLCHARGETIME"] = "Tiempo de carga de hechizo"
L["SPELLCHARGETIME_DESC"] = "Sigue el tiempo restante hasta que un hechizo como %s o %s regenere una carga. "
L["SPELLCOOLDOWN"] = "Tiempo de reutilización de hechizo"
L["SPELLCRIT"] = "Crítico de Hechizo"
L["SpellDamageTaken"] = "Daño de Hechizo Recibido Aumentado"
L["SPELLHASTE"] = "Celeridad de Hechizo"
L["SPELLREACTIVITY"] = "Reactividad del Hechizo"
L["SPELLTOCHECK"] = "Hechizo a Comprobar"
L["SPELLTOCOMP1"] = "Primer Hechizo a Comparar"
L["SPELLTOCOMP2"] = "Segundo Hechizo a Comparar"
L["STACKALPHA_DESC"] = "Establece el nivel de opacidad al que el icono debería mostrarse cuando no se cumplan estos requisitos de acumulación."
L["STACKS"] = "Acumulaciones"
L["STACKSPANEL_TITLE2"] = "Requisitos de Acumulación"
L["STANCE"] = "Actitud"
L["STANCE_DESC"] = [=[Puede introducir múltiples actitudes a comparar separándolas con punto y coma (;).

La condición se cumplirá si cualquier actitud encaja. ]=]
L["STANCE_LABEL"] = "Actitud(es)"
L["STRATA_BACKGROUND"] = "Fondo"
L["STRATA_DIALOG"] = "Diálogo"
L["STRATA_FULLSCREEN"] = "Pantalla completa"
L["STRATA_FULLSCREEN_DIALOG"] = "Diálogo a Pantalla Completa"
L["STRATA_HIGH"] = "Alto"
L["STRATA_LOW"] = "Bajo"
L["STRATA_MEDIUM"] = "Medio"
L["STRATA_TOOLTIP"] = "Tooltip"
L["Stunned"] = "Aturdido"
L["SUG_ATBEGINING"] = "Sugeridor: Comparar principio"
L["SUG_ATBEGINING_DESC"] = "Si está marcado, la lista de sugerencias sólo mostrará hechizos que empiecen con el mismo nombre que el hechizo que está siendo introducido. De otro modo, buscará coincidencias con cualquier parte del hechizo. "
L["SUG_BUFFEQUIVS"] = "Equivalencias de Ventajas"
L["SUG_CLASSSPELLS"] = "Hechizos de mascota/PJ conocidos"
L["SUG_DEBUFFEQUIVS"] = "Equivalencias de Desventajas"
L["SUG_DISPELTYPES"] = "Tipos de Disipación"
L["SUG_FINISHHIM"] = "Terminar el Almacenado Ahora"
L["SUG_FINISHHIM_DESC"] = "|cff7fffffClick|r para terminar inmediatamente el proceso de almacenamiento/filtrado. Tenga en cuenta que su ordenador podría detenerse durante algunos segundos. "
L["SUGGESTIONS"] = "Sugerencias:"
L["SUGGESTIONS_DOGTAGS"] = "DogTags:"
L["SUG_INSERT_ANY"] = "|cff7fffffClick|r"
L["SUG_INSERTEQUIV"] = "%s para insertar equivalencia"
L["SUG_INSERTID"] = "%s para insertar como ID"
L["SUG_INSERTITEMSLOT"] = "%s para intertar como ID de ranura de objeto"
L["SUG_INSERT_LEFT"] = "|cff7fffffClick-Izquierdo|r"
L["SUG_INSERTNAME"] = "%s para insertar como nombre"
L["SUG_INSERT_RIGHT"] = "|cff7fffffClick-Derecho|r"
L["SUG_INSERT_TAB"] = " o |cff7fffffTab|r"
L["SUG_INSERTTEXTSUB"] = "%s para insertar etiqueta"
L["SUG_MATCH_WPNENCH_ENCH"] = "Arma ?d?e? (.*)"
L["SUG_MISC"] = "Varios"
L["SUG_MSCDONBARS"] = "Tiempos de reutilización multiestado validos"
L["SUG_NPCAURAS"] = "Ventajas/Desventajas de PNJs conocidas"
L["SUG_OTHEREQUIVS"] = "Otras Equivalencias"
L["SUG_PATTERNMATCH_FISHINGLURE"] = "Cebo de pesca %(%+%d+ habilidad para pescar%)"
L["SUG_PATTERNMATCH_SHARPENINGSTONE"] = "Afilado %(%+%d+ daño%)"
L["SUG_PATTERNMATCH_WEIGHTSTONE"] = "Pesado %(%+%d+ daño%)"
L["SUG_PLAYERAURAS"] = "Ventajas/Desventajas de mascota/PJ conocidas"
L["SUG_PLAYERSPELLS"] = "Sus hechizos"
L["SUG_SUBSTITUTION_d"] = "Duración Restante"
L["SUG_SUBSTITUTION_d_DESC"] = "La duración restante en el temporizador del icono"
L["SUG_SUBSTITUTION_e"] = "Unidad Destino"
L["SUG_SUBSTITUTION_e_DESC"] = "La unidad que recibió la acción en el último evento de combate que el icono manejó. "
L["SUG_SUBSTITUTION_f"] = "Nombre del Foco"
L["SUG_SUBSTITUTION_f_DESC"] = "Nombre de la unidad actualmente enfocada"
L["SUG_SUBSTITUTION_k"] = "Acumulaciones Actuales"
L["SUG_SUBSTITUTION_k_DESC"] = "Lo que se está mostrando actualmente como texto de acumulación del icono"
L["SUG_SUBSTITUTION_m"] = "Nombre al Pasar el Ratón"
L["SUG_SUBSTITUTION_m_DESC"] = "Nombre de la unidad sobre la que está pasando el ratón actualmente"
L["SUG_SUBSTITUTION_o"] = "Unidad Fuente"
L["SUG_SUBSTITUTION_o_DESC"] = "La unidad que causó la acción en el último evento de combate que el icono manejó. "
L["SUG_SUBSTITUTION_p"] = "Unidad Previa"
L["SUG_SUBSTITUTION_p_DESC"] = "Nombre de la unidad que fue comprobada antes de la unidad actual"
L["SUG_SUBSTITUTION_s"] = "Hechizo/Objeto/Etc Actual"
L["SUG_SUBSTITUTION_s_DESC"] = "Nombre del hechizo/objeto/etc siendo comprobado actualmente"
L["SUG_SUBSTITUTION_t"] = "Nombre del Objetivo"
L["SUG_SUBSTITUTION_t_DESC"] = "Nombre de la unidad que tiene actualmente como objetivo"
L["SUG_SUBSTITUTION_u"] = "Unidad Actual"
L["SUG_SUBSTITUTION_u_DESC"] = "Nombre de la unidad actual siendo comprobada"
L["SUG_SUBSTITUTION_x"] = "Hechizo Extra"
L["SUG_SUBSTITUTION_x_DESC"] = "Eventos de combate como disipaciones, interrupciones y rupturas de aura tienen datos adicionales sobre qué hechizo causó el evento. Esto sustituirá ese hechizo desde el último evento de registro de combate. "
L["SUG_TOOLTIPTITLE"] = [=[Mientras escribe, TellMeWhen revisará su caché y determinará los hechizos que más probablemente estaba buscando. 

Los hechizos están categorizados y coloreados según la lista inferior. Note que las categorías con la palabra "conocido" no serán pobladas con hechizos hasta que se hayan visto mientras juega o se conecta con diferentes Clases. 

Haga click en una entrada para insertarla en el cuadro de edición. ]=]
L["SUG_TOOLTIPTITLE_TEXTSUBS"] = [=[Las siguientes son etiquetas que puede querer usar en este display de texto. Usar una sustitución provocará que sea reemplazada por los datos apropiados cuando quiera que sea mostrada. 

Para más información sobre estas etiquetas, y para más etiquetas, pulse este botón. 

Pulsar en una entrada la insertará en el cuadro de edición.]=]
L["SUN"] = "Sol"
L["SWINGTIMER"] = "Temporizador de Golpe"
L["TANK"] = "Tanque"
L["TEXTLAYOUTS"] = "Diseños de Texto"
L["TEXTLAYOUTS_ADDANCHOR"] = "Añadir anclaje"
L["TEXTLAYOUTS_ADDANCHOR_DESC"] = "Pulse para añadir otro anclaje de texto. "
L["TEXTLAYOUTS_ADDLAYOUT"] = "Crear Nuevo Diseño"
L["TEXTLAYOUTS_ADDLAYOUT_DESC"] = "Crear un nuevo diseño de texto que puede configurar y aplicar a sus iconos."
L["TEXTLAYOUTS_ADDSTRING"] = "Añadir Display de Texto"
L["TEXTLAYOUTS_ADDSTRING_DESC"] = "Añade un nuevo display de texto a este diseño de texto."
L["TEXTLAYOUTS_BLANK"] = "(En Blanco)"
L["TEXTLAYOUTS_CHOOSELAYOUT"] = "Elija Diseño..."
L["TEXTLAYOUTS_CHOOSELAYOUT_DESC"] = "Seleccione el diseño de texto a usar para este icono."
L["TEXTLAYOUTS_CLONELAYOUT"] = "Clonar diseño"
L["TEXTLAYOUTS_CLONELAYOUT_DESC"] = "Click para crear una copia de este diseño que puede editar por separado. "
L["TEXTLAYOUTS_DEFAULTS_BAR1"] = "Diseño de Barra 1"
L["TEXTLAYOUTS_DEFAULTS_BINDINGLABEL"] = "Enlace/Etiqueta"
L["TEXTLAYOUTS_DEFAULTS_CENTERNUMBER"] = "Centrar número"
L["TEXTLAYOUTS_DEFAULTS_DURATION"] = "Duración"
L["TEXTLAYOUTS_DEFAULTS_ICON1"] = "Diseño de Icono 1"
L["TEXTLAYOUTS_DEFAULTS_NOLAYOUT"] = "<Sin Diseño>"
L["TEXTLAYOUTS_DEFAULTS_NUMBER"] = "Número"
L["TEXTLAYOUTS_DEFAULTS_SPELL"] = "Hechizo"
L["TEXTLAYOUTS_DEFAULTS_STACKS"] = "Acumulaciones "
L["TEXTLAYOUTS_DEFAULTS_WRAPPER"] = "Por defecto: %s"
L["TEXTLAYOUTS_DEFAULTTEXT"] = "Texto Por Defecto"
L["TEXTLAYOUTS_DEFAULTTEXT_DESC"] = "Edita el texto por defecto que será usado cuando este diseño de texto se establezca para un icono."
L["TEXTLAYOUTS_DELANCHOR"] = "Borrar anclaje"
L["TEXTLAYOUTS_DELANCHOR_DESC"] = "Pulse para borrar este anclaje de texto. "
L["TEXTLAYOUTS_DELETELAYOUT"] = "Borrar Diseño"
L["TEXTLAYOUTS_DELETELAYOUT_CONFIRM_BASE"] = "Está seguro de que quiere borrar el diseño %q?"
L["TEXTLAYOUTS_DELETELAYOUT_CONFIRM_NUM"] = "|cFFFF5959Los %d iconos que dependen de él volverán a usar diseños de texto por defecto.|r"
L["TEXTLAYOUTS_DELETELAYOUT_DESC"] = [=[Pulse para borrar este diseño de texto.

Mantenga pulsado |cff7fffffCtrl|r para saltarse la confirmación.]=]
L["TEXTLAYOUTS_DELETESTRING"] = "Borrar Display de Texto"
L["TEXTLAYOUTS_DELETESTRING_DESC"] = [=[Borra este display de texto de este diseño de texto.

Mantenga pulsado |cff7fffffCtrl|r para saltarse la confirmación.]=]
L["TEXTLAYOUTS_DISABLEDBYSKIN"] = "Este ajuste no se puede cambiar si tiene una piel de Masque establecida para este display de texto."
L["TEXTLAYOUTS_ERROR_FALLBACK"] = [=[El diseño de texto para este icono no se encontró. Se usará un  diseño por defecto hasta que se encuentre el diseño pretendido, o hasta que se seleccione otro. 

(Borró el diseño? O importó este icono sin importar el diseño que usaba?)]=]
L["TEXTLAYOUTS_fLAYOUT"] = "Diseño de Texto: %s"
L["TEXTLAYOUTS_FONTSETTINGS"] = "Ajustes de Fuente"
L["TEXTLAYOUTS_fSTRING"] = "Mostrar %s"
L["TEXTLAYOUTS_fSTRING2"] = "Mostrar %d: %s"
L["TEXTLAYOUTS_fSTRING3"] = "Display de Texto: %s"
L["TEXTLAYOUTS_HEADER_LAYOUT"] = "Diseño de Texto"
L["TEXTLAYOUTS_IMPORT"] = "Importar Diseño de Texto"
L["TEXTLAYOUTS_IMPORT_CREATENEW"] = "|cff59ff59Crear|r Nuevo"
L["TEXTLAYOUTS_IMPORT_CREATENEW_DESC"] = [=[Ya existe un diseño de texto con el mismo identificador único que éste. 

Elija esta opción para generar un nuevo identificador único e importar el diseño. ]=]
L["TEXTLAYOUTS_IMPORT_NORMAL_DESC"] = "Click para importar el diseño de texto. "
L["TEXTLAYOUTS_IMPORT_OVERWRITE"] = "|cFFFF5959Reemplazar|r Existente"
L["TEXTLAYOUTS_IMPORT_OVERWRITE_DESC"] = [=[Ya existe un diseño de texto con el mismo identificador único que éste. 

Elija esta opción para sobrescribir el diseño de texto existente con este diseño. Todos los iconos que usen el diseño existente serán actualizados acorde a esto.]=]
L["TEXTLAYOUTS_IMPORT_OVERWRITE_DISABLED_DESC"] = "No puede sobrescribir un diseño de texto por defecto."
L["TEXTLAYOUTS_LAYOUTDISPLAYS"] = [=[Muestra:
%s]=]
L["TEXTLAYOUTS_LAYOUT_SETDEFAULTS"] = "Restaurar Valores por Defecto"
L["TEXTLAYOUTS_LAYOUT_SETDEFAULTS_DESC"] = "Restaura todos los textos de display a sus textos por defecto, establecidos en los ajustes del diseño de texto actual. "
L["TEXTLAYOUTS_LAYOUTSETTINGS"] = "Ajustes de Diseño"
L["TEXTLAYOUTS_LAYOUTSETTINGS_DESC"] = "Pulse para configurar el diseño de texto %q."
L["TEXTLAYOUTS_NOEDIT_DESC"] = [=[Este diseño de texto es un diseño por defecto que viene estándar con TellMeWhen y no puede ser modificado. 

Si desea modificarlo, por favor clónelo. ]=]
L["TEXTLAYOUTS_POINT_DESC"] = "El punto del display de texto que será anclado al icono. "
L["TEXTLAYOUTS_POSITIONSETTINGS"] = "Ajustes de Posición"
L["TEXTLAYOUTS_RELATIVEPOINT_DESC"] = "El punto del objeto que será anclado a"
L["TEXTLAYOUTS_RELATIVETO_DESC"] = "El objeto al que el texto será anclado"
L["TEXTLAYOUTS_RENAME"] = "Renombrar Diseño"
L["TEXTLAYOUTS_RENAME_DESC"] = "Renombre este diseño a un nombre que describa su función para que pueda identificarlo fácilmente."
L["TEXTLAYOUTS_RENAMESTRING"] = "Renombrar Display"
L["TEXTLAYOUTS_RENAMESTRING_DESC"] = "Ponga a este display un nombre adecuado a su propósito de modo que pueda identificarlo fácilmente."
L["TEXTLAYOUTS_RESETSKINAS"] = "El ajuste %q se ha restaurado para la cadena de fuente %q para evitar conflictos con el nuevo ajuste para la cadena de fuente %q."
L["TEXTLAYOUTS_SETGROUPLAYOUT"] = "Diseño de Texto"
L["TEXTLAYOUTS_SETGROUPLAYOUT_DDVALUE"] = "Seleccione diseño..."
L["TEXTLAYOUTS_SETGROUPLAYOUT_DESC"] = [=[Establece el diseño de texto que usarán todos los iconos de este grupo. 

El diseño de texto puede ser establecido individualmente por icono en los ajustes de cada icono. ]=]
L["TEXTLAYOUTS_SETTEXT"] = "Establecer Texto"
L["TEXTLAYOUTS_SETTEXT_DESC"] = [=[Establece el texto que será usado en este display de texto. 

Se puede dar formato al texto con etiquetas DogTag, permitiendo mostrar información dinámicamente. Escriba '/dogtag' o '/dt' para obtener ayuda sobre cómo usar estas etiquetas.  ]=]
L["TEXTLAYOUTS_SKINAS"] = "Poner Piel Como"
L["TEXTLAYOUTS_SKINAS_COUNT"] = "Texto de Acumulación"
L["TEXTLAYOUTS_SKINAS_DESC"] = "Elija el elemento Masque con el que desea poner piel a este texto. "
L["TEXTLAYOUTS_SKINAS_HOTKEY"] = "Texto Enlazante"
L["TEXTLAYOUTS_SKINAS_NONE"] = "Ninguno"
L["TEXTLAYOUTS_STRING_COPYMENU"] = "Copiar"
L["TEXTLAYOUTS_STRING_COPYMENU_DESC"] = "Click para abrir una lista de todos los textos que se usan en este perfil que puede copiar a este display de texto. "
L["TEXTLAYOUTS_STRING_SETDEFAULT"] = "Restablecer a Por Defecto"
L["TEXTLAYOUTS_STRING_SETDEFAULT_DESC"] = [=[Restablece el texto de este display al siguiente texto por defecto, establecido en los ajustes de diseño de texto actual: 

%s]=]
L["TEXTLAYOUTS_STRINGUSEDBY"] = "Usado %d |4vez:veces;."
L["TEXTLAYOUTS_TAB"] = "Displays de Texto"
L["TEXTLAYOUTS_UNNAMED"] = "<sin nombre>"
L["TEXTMANIP"] = "Manipulación de texto"
L["Tier11Interrupts"] = "Tier 11 Interrumpibles"
L["Tier12Interrupts"] = "Tier 12 Interrumpibles"
L["TOOLTIPSCAN"] = "Variable de Aura"
L["TOOLTIPSCAN_DESC"] = "Este tipo de condición le permite comprobar la primera variable asociada con un aura. Los números los provee la API de Blizzard y no necesariamente concuerdan con los números del tooltip del aura. Tampoco hay garantía de que se obtendrá un número para un aura. Para la mayor parte de los casos prácticos, sin embargo, se comprobará el número correcto. "
L["TOP"] = "Arriba"
L["TOPLEFT"] = "Arriba Izquierda"
L["TOPRIGHT"] = "Arriba Derecha"
L["TOTEMS"] = "Tótems a comprobar"
L["TRUE"] = "Verdadero"
L["UIPANEL_ADDGROUP"] = "+ Añadir Otro Grupo +"
L["UIPANEL_ADDGROUP_DESC"] = "El nuevo grupo será asignado al próximo ID de grupo disponible"
L["UIPANEL_ALLRESET"] = "Restablecer todo"
L["UIPANEL_ANCHORNUM"] = "Ancla %d"
L["UIPANEL_BARIGNOREGCD"] = "Las barras ignoran el GCD"
L["UIPANEL_BARIGNOREGCD_DESC"] = "Si está marcado, las barras de tiempo de reutilización no cambiarán de valor si el tiempo de reutilización activado es un tiempo de reutilización global"
L["UIPANEL_BARTEXTURE"] = "Textura de barra"
L["UIPANEL_CLOCKIGNOREGCD"] = "Los Temporizadores Ignoran GCD"
L["UIPANEL_CLOCKIGNOREGCD_DESC"] = "Si está marcado, los temporizadores y el reloj de tiempo de reutilización no serán activados por un tiempo de reutilización global"
L["UIPANEL_COLORS"] = "Colores"
L["UIPANEL_COLORS_DESC"] = "Ajustes que controlan el coloreado/tintado de los iconos basándose en sus atributos."
L["UIPANEL_COLUMNS"] = "Columnas"
L["UIPANEL_COMBATCONFIG"] = "Permitir configurar en combate"
L["UIPANEL_COMBATCONFIG_DESC"] = [=[Active esto para permitir la configuración de TellMeWhen estando en combate. 

Tenga en cuenta que esto obligará al módulo de opciones a estar cargado constantemente, resultando en un mayor uso de memoria y tiempos de carga ligeramente mayores. 


Esta opción afecta a toda la cuenta: todos sus perfiles compartirán este ajuste. 

|cffff5959Los cambios sólo se aplicarán después de que |cff7fffffrecargue su UI|cffff5959.|r]=]
L["UIPANEL_DELGROUP"] = "Borrar este Grupo"
L["UIPANEL_DELGROUP_DESC"] = [=[Los IDs de cualesquiera grupos tras este grupo serán reducidos en uno, y cualquier icono que esté comprobando iconos en los grupos que serán modificados será actualizado automáticamente.

Mantenga pulsado |cff7fffffControl|r para saltar la confirmación.]=]
L["UIPANEL_DRAWEDGE"] = "Resaltar borde temporizador"
L["UIPANEL_DRAWEDGE_DESC"] = "Destaca el borde del temporizador de tiempo de reutilización (la animación del reloj) para aumentar la visibilidad"
L["UIPANEL_EFFTHRESHOLD"] = "Umbral de Eficiencia de Ventaja"
L["UIPANEL_EFFTHRESHOLD_DESC"] = "Establece el número mínimo de ventajas/desventajas para cambiar a un modo más eficiente de comprobarlas cuando haya un gran número. Considere que una vez que el número de auras comprobadas excede este número, las auras más antiguas serán priorizadas en vez de prioridad basada en el orden en que fueron introducidas. "
L["UIPANEL_ENABLEGROUP"] = "Habilitar el Grupo"
L["UIPANEL_FONT_CONSTRAINWIDTH"] = "Limitar Anchura"
L["UIPANEL_FONT_CONSTRAINWIDTH_DESC"] = [=[Marque esto para forzar al texto a encajar en la anchura del icono si se posiciona adecuadamente. 

Desmarque para permitir al texto extenderse más ancho que el icono. ]=]
L["UIPANEL_FONT_DESC"] = "Elija la fuente a usar por el texto de acumulación en los iconos"
L["UIPANEL_FONTFACE"] = "Tipografía"
L["UIPANEL_FONT_JUSTIFY"] = "Justificado"
L["UIPANEL_FONT_JUSTIFY_DESC"] = "Establece el justificado (Izquierda/Centrado/Derecha) para este display de texto. "
L["UIPANEL_FONT_OUTLINE"] = "Contorno de Fuente"
L["UIPANEL_FONT_OUTLINE_DESC"] = "Establece el estilo de contorno para el texto de acumulación en los iconos"
L["UIPANEL_FONT_SHADOW"] = "Desplazamiento de Sombra"
L["UIPANEL_FONT_SHADOW_DESC"] = "Cambia la cantidad de desplazamiento de la sombra tras el texto. Establezca a cero para desactivar la sombra. "
L["UIPANEL_FONT_SIZE"] = "Tamaño de Fuente"
L["UIPANEL_FONT_SIZE_DESC"] = "Cambia el tamaño de la fuente usada para el texto de acumulación en los iconos. Si se usa Masque y la piel establecida ya tiene definido un tamaño de fuente, este valor será ignorado. "
L["UIPANEL_FONT_XOFFS"] = "Desplazamiento X"
L["UIPANEL_FONT_XOFFS_DESC"] = "El desplazamiento del eje x del ancla"
L["UIPANEL_FONT_YOFFS"] = "Desplazamiento Y"
L["UIPANEL_FONT_YOFFS_DESC"] = "El desplazamiento de eje-y del ancha"
L["UIPANEL_GLYPH"] = "Glifo activo"
L["UIPANEL_GLYPH_DESC"] = "Comprueba si tiene activo un glifo en concreto"
L["UIPANEL_GROUPALPHA"] = "Opacidad de grupo"
L["UIPANEL_GROUPALPHA_DESC"] = [=[Establece el nivel de opacidad del grupo entero. 

Este ajuste no tiene efecto en la funcionalidad de los propios iconos. Sólo cambia la apariencia del grupo y sus iconos. 

Establezca este ajuste a 0 si quiere ocultar el grupo entero permitiéndole permanecer completamente funcional (semejante al ajuste %q para iconos).]=]
L["UIPANEL_GROUPMOVEDOWN"] = "Bajar"
L["UIPANEL_GROUPMOVEDOWN_DESC"] = "Desplaza el ID de grupo de este grupo uno abajo. "
L["UIPANEL_GROUPMOVEUP"] = "Subir"
L["UIPANEL_GROUPMOVEUP_DESC"] = "Desplaza el ID de grupo de este grupo uno arriba."
L["UIPANEL_GROUPNAME"] = "Renombrar Grupo"
L["UIPANEL_GROUPRESET"] = "Restablecer Posición"
L["UIPANEL_GROUPS"] = "Grupos"
L["UIPANEL_GROUPS_DESC"] = "Ajustes para cada grupo en este perfil de TellMeWhen"
L["UIPANEL_GROUPSORT"] = "Ordenación de Iconos"
L["UIPANEL_GROUPSORT_alpha"] = "Opacidad (Ignora %s)"
L["UIPANEL_GROUPSORT_alpha_DESC"] = "Ordena el grupo por la opacidad de sus iconos, ignorando si los iconos son ocultados o no por el ajuste %s."
L["UIPANEL_GROUPSORT_DESC"] = "Contiene ajustes para ordenar y posicionar iconos dentro de un grupo basándose en sus atributos. "
L["UIPANEL_GROUPSORT_duration"] = "Duración"
L["UIPANEL_GROUPSORT_duration_DESC"] = "Ordena el grupo por la duración restante de sus iconos. "
L["UIPANEL_GROUPSORT_id"] = "ID de Icono"
L["UIPANEL_GROUPSORT_id_DESC"] = "Ordena el grupo por los números de ID de sus iconos. "
L["UIPANEL_GROUPSORT_METHODDISABLED_DESC"] = "|TInterface\\AddOns\\TellMeWhen\\Textures\\Alert:0:2|tEste método de ordenación está deshabilitado porque un método más arriba está ordenando por ID de icono, así que nunca se llegará a usar este método en la ordenación."
L["UIPANEL_GROUPSORT_METHODNAME"] = "Prioridad de Ordenación de Icono %d"
L["UIPANEL_GROUPSORT_METHODNAME_DESC"] = "Esto será usado como la prioridad número %d al ordenar iconos para posicionarlos dentro de un grupo. "
L["UIPANEL_GROUPSORT_shown"] = "Mostrado (Ignora %s)"
L["UIPANEL_GROUPSORT_shown_DESC"] = "Ordena el grupo según si el icono es mostrado o no, ignorando si los iconos son ocultados o no por el ajuste %s."
L["UIPANEL_GROUPSORT_SORTASCENDING"] = "Ascendente"
L["UIPANEL_GROUPSORT_SORTASCENDING_DESC"] = "Marque para ordenar este atributo de menor a mayor valor. "
L["UIPANEL_GROUPSORT_SORTDESCENDING"] = "Descendente"
L["UIPANEL_GROUPSORT_SORTDESCENDING_DESC"] = "Marque para ordenar este atributo de mayor a menor valor. "
L["UIPANEL_GROUPSORT_stacks"] = "Acumulaciones"
L["UIPANEL_GROUPSORT_stacks_DESC"] = "Ordena el grupo por las acumulaciones de cada icono. "
L["UIPANEL_GROUPSORT_visiblealpha"] = "Opacidad (Respeta %s)"
L["UIPANEL_GROUPSORT_visiblealpha_DESC"] = "Ordena el grupo por la opacidad de sus iconos, usando la opacidad con la que el icono es visible realmente. "
L["UIPANEL_GROUPSORT_visibleshown"] = "Mostrado (Respeta %s)"
L["UIPANEL_GROUPSORT_visibleshown_DESC"] = "Ordena el grupo por si un icono es o no visible para usted. "
L["UIPANEL_GROUPTYPE"] = "Método de visualización de grupo"
L["UIPANEL_GROUPTYPE_BAR"] = "Barra"
L["UIPANEL_GROUPTYPE_BAR_DESC"] = "Muestra los iconos del grupo con barras de progreso adjuntas a los mismos. "
L["UIPANEL_GROUPTYPE_DESC"] = "Elija cómo desea que se muestren los iconos dentro de este grupo. "
L["UIPANEL_GROUPTYPE_ICON"] = "Icono"
L["UIPANEL_GROUPTYPE_ICON_DESC"] = "Muestra los iconos en el grupo usando la visualización tradicional de iconos de TellMeWhen"
L["UIPANEL_ICONS"] = "Iconos"
L["UIPANEL_ICONSPACING_DESC"] = "Distancia de separación entre iconos dentro de un grupo"
L["UIPANEL_ICONSPACINGX"] = "Espaciado Horizontal de Icono"
L["UIPANEL_ICONSPACINGY"] = "Espaciado Vertical de Icono"
L["UIPANEL_LEVEL"] = "Nivel de Marco"
L["UIPANEL_LOCK"] = "Bloquear Posición"
L["UIPANEL_LOCK_DESC"] = "Bloquear este grupo, evitando moverlo o cambiarle el tamaño al arrastrar el grupo o la ficha de escala"
L["UIPANEL_LOCKUNLOCK"] = "Bloquear / Desbloquear AddOn"
L["UIPANEL_MAIN_DESC"] = "Contiene los ajustes principales para el grupo. "
L["UIPANEL_MAINOPT"] = "Opciones Principales"
L["UIPANEL_ONLYINCOMBAT"] = "Mostrar sólo en combate"
L["UIPANEL_POINT"] = "Punto"
L["UIPANEL_POINT_DESC"] = "El punto del grupo que será anclado"
L["UIPANEL_POSITION"] = "Posición"
L["UIPANEL_POSITION_DESC"] = "Contiene ajustes que controlan la posición del grupo en su pantalla. "
L["UIPANEL_PRIMARYSPEC"] = "Especialización primaria"
L["UIPANEL_PTSINTAL"] = "Puntos en talento"
L["UIPANEL_RELATIVEPOINT"] = "Punto Relativo"
L["UIPANEL_RELATIVEPOINT_DESC"] = "El punto al que el grupo será anclado. "
L["UIPANEL_RELATIVETO"] = "Relativo A"
L["UIPANEL_RELATIVETO_DESC"] = "Escriba /framestack para activar/desactivar un tooltip que contiene una lista de todos los marcos sobre los que está el ratón, y sus nombres, para ponerlos en este diálogo. "
L["UIPANEL_ROWS"] = "Filas"
L["UIPANEL_SCALE"] = "Escala"
L["UIPANEL_SECONDARYSPEC"] = "Especialización Secundaria"
L["UIPANEL_SPEC"] = "Doble especialización"
L["UIPANEL_SPECIALIZATION"] = "Especialización de Talentos"
L["UIPANEL_STRATA"] = "Capa de Marco"
L["UIPANEL_SUBTEXT2"] = [=[Los iconos sólo funcionan cuando están bloqueados. 

Cuando están desbloqueados, puede mover/cambiar el tamaño de grupos de iconos y hacer click derecho en iconos individuales para configurarlos. 

También puede escribir /tellmewhen o /tmw para bloquear/desbloquear]=]
L["UIPANEL_TALENTLEARNED"] = "Talento aprendido"
L["UIPANEL_TOOLTIP_ALLRESET"] = "Restablecer TODOS LOS AJUSTES de TODOS LOS ICONOS Y GRUPOS, así como cualquier otro ajuste."
L["UIPANEL_TOOLTIP_COLUMNS"] = "Establecer el número de columnas en este grupo"
L["UIPANEL_TOOLTIP_ENABLEGROUP"] = "Mostrar y habilitar este grupo"
L["UIPANEL_TOOLTIP_GROUPRESET"] = "Restablecer la posición y escala de este grupo"
L["UIPANEL_TOOLTIP_ONLYINCOMBAT"] = "Marcar para que este grupo sólo se muestre en combate"
L["UIPANEL_TOOLTIP_PRIMARYSPEC"] = "Marcar para mostrar este grupo mientras esté activa su especialización primaria"
L["UIPANEL_TOOLTIP_ROWS"] = "Establecer el número de filas de este grupo"
L["UIPANEL_TOOLTIP_SECONDARYSPEC"] = "Marcar para mostrar este grupo mientras esté activa su especialización secundaria"
L["UIPANEL_TOOLTIP_UPDATEINTERVAL"] = [=[Establece cuán a menudo (en segundos) son comprobados los iconos para mostrar/ocultar, alfa, condiciones, etc

Cero es tan rápido como sea posible. Valores más bajos pueden tener un impacto significativo en la tasa de fotogramas para ordenadores de gama baja.]=]
L["UIPANEL_TREE"] = "Árbol de Talentos"
L["UIPANEL_TREE_DESC"] = "Marque para permitir que este grupo se muestre cuando este árbol de talentos esté activo, o desmárquelo para que se oculte cuando no está activo. "
L["UIPANEL_UPDATEINTERVAL"] = "Intervalo de actualización"
L["UIPANEL_WARNINVALIDS"] = "Avisar sobre iconos inválidos"
L["UNDO_ICON"] = "Deshacer"
L["UNDO_ICON_DESC"] = "Deshacer el último cambio hecho a la configuración de este icono."
L["UNITCONDITIONS"] = "Condiciones de Unidad"
L["UNITCONDITIONS_DESC"] = "Click para configurar un conjunto de condiciones que cada unidad tendrá que cumplir para ser comprobada."
L["UNITCONDITIONS_STATICUNIT"] = "<Unidad de Icono>"
L["UNITCONDITIONS_STATICUNIT_DESC"] = "Hace que la condición compruebe cada unidad que el icono está comprobando."
L["UNITCONDITIONS_STATICUNIT_TARGET"] = "Objetivo de <Unidad de Icono>"
L["UNITCONDITIONS_STATICUNIT_TARGET_DESC"] = "Hace que la condición compruebe el objetivo de cada unidad que el icono está comprobando. "
L["UNITCONDITIONS_TAB_DESC"] = "Configura condiciones que cada unidad tendrá que cumplir para ser comprobada. "
L["UNITTWO"] = "Segunda Unidad"
L["UNNAMED"] = "((Sin nombre))"
L["WARN_DRMISMATCH"] = [=[Advertencia! Está comprobando rendimientos decrecientes en hechizos de dos categorías conocidas diferentes. 

Todos los hechizos deben ser de la misma categoría de rendimiento decreciente para que el icono funcione correctamente. Se detectaron las siguientes categorías y hechizos:]=]
L["WATER"] = "Agua"
L["worldboss"] = "Jefe del Mundo"
