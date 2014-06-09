--[[
    This file is part of Decursive.
    
    Decursive (v 2.7.3.1) add-on for World of Warcraft UI
    Copyright (C) 2006-2007-2008-2009-2010-2011-2012 John Wellesz (archarodim AT
    teaser.fr) ( http://www.2072productions.com/to/decursive.php )

    Starting from 2009-10-31 and until said otherwise by its author, Decursive
    is no longer free software, all rights are reserved to its author (John
    Wellesz).

    The only official and allowed distribution means are
    www.2072productions.com, www.wowace.com and curse.com.
    To distribute Decursive through other means a special authorization is
    required.
    

    Decursive is inspired from the original "Decursive v1.9.4" by Patrick Bohnet (Quu).
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY.

    This file was last updated on 2012-11-13T01:32:04Z
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Spanish localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    preferredIndex = 3,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end
T._LoadedFiles["esES.lua"] = false;

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "esES");

if not L then
    T._LoadedFiles["esES.lua"] = "2.7.3.1";
    return;
end;

L["ABOLISH_CHECK"] = "Comprobar \"Abolido\" antes de curar" -- Needs review
L["ABSENT"] = "Falta (%s)" -- Needs review
L["AFFLICTEDBY"] = "%s Afectado" -- Needs review
L["ALT"] = "Alt" -- Needs review
L["AMOUNT_AFFLIC"] = "Cantidad de afectados a mostrar:" -- Needs review
L["ANCHOR"] = "Anclaje del Texto de Decursive" -- Needs review
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Mostrar u ocultar los micro-unit frames" -- Needs review
L["BINDING_NAME_DCRPRADD"] = "Añadir objetivo a la lista de prioridad" -- Needs review
L["BINDING_NAME_DCRPRCLEAR"] = "Limpiar la lista de prioridad" -- Needs review
L["BINDING_NAME_DCRPRLIST"] = "Imprimir la lista de prioridad" -- Needs review
L["BINDING_NAME_DCRPRSHOW"] = "Mostrar u ocultar la lista de prioridad" -- Needs review
L["BINDING_NAME_DCRSHOW"] = [=[Mostrar u ocultar la barra principal de Decursive
(live-list anchor)]=] -- Needs review
L["CLASS_HUNTER"] = "Cazador"
L["CURSE"] = "Maldición"
L["DEFAULT_MACROKEY"] = "NONE"
L["DISEASE"] = "Enfermedad"
L["MAGIC"] = "Magia"
L["OPT_UNITPERLINES_DESC"] = "Define el número máximo de micro-marcos de unidades a mostrar por línea" -- Needs review
L["OPT_XSPACING"] = "Espaciado horizontal"
L["OPT_YSPACING"] = "Espaciado vertical"
L["PLAY_SOUND"] = "Reproducir un sonido cuando hay alguien a quien curar"
L["POISON"] = "Veneno"
L["POPULATE"] = "p"
L["PRINT_CHATFRAME"] = "Mostrar mensajes en el chat predeterminado"
L["RANDOM_ORDER"] = "Curar en orden aleatorio"
L["SCAN_LENGTH"] = "Segundos entre escaneos en vivo :"
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Para mostrar la ventana de Decursive, escribe /dcrshow"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "¡%s hechizo encontrado!"
L["STR_CLOSE"] = "Cerrar"
L["STR_DCR_PRIO"] = "Prioridad decursive"
L["STR_DCR_SKIP"] = "No decursear"
L["STR_GROUP"] = "Grupo"
L["STR_OPTIONS"] = "Opciones"
L["STR_OTHER"] = "Otro"
L["TOOFAR"] = "Muy lejos"



T._LoadedFiles["esES.lua"] = "2.7.3.1";
