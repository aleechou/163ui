--[[
    This file is part of Decursive.
    
    Decursive (v 2.7.3.5) add-on for World of Warcraft UI
    Copyright (C) 2006-2014 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/to/decursive.php )

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

    This file was last updated on 2014-10-13T09:20:46Z
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Brazilian Portuguese localization
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

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "ptBR");

if not L then 
    T._LoadedFiles["ptBR.lua"] = "2.7.3.5";
    return;
end

L["ABOLISH_CHECK"] = "Verifique se há \"Abolir\" antes de curar"
L["ABOUT_LICENSE"] = "Licensa" -- Needs review
L["ABOUT_OFFICIALWEBSITE"] = "WEBSITE OFFICIAL" -- Needs review
L["ABSENT"] = "Faltando (%s)"
L["AFFLICTEDBY"] = "%s Afligido" -- Needs review
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "A quantidade afligida para exibir" -- Needs review
L["ANCHOR"] = "Âncora de texto do Decursive" -- Needs review
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Mostrar ou esconder os micro quadros de unidades." -- Needs review
L["BINDING_NAME_DCRPRADD"] = "Adicionar alvo na lista de prioridades"
L["BINDING_NAME_DCRPRCLEAR"] = "Limpar a lista de prioridades"
L["BINDING_NAME_DCRPRLIST"] = "Imprimir a lista de prioridades"
L["BINDING_NAME_DCRPRSHOW"] = "Mostrar ou esconder a lista de prioridade" -- Needs review
L["BINDING_NAME_DCRSHOW"] = [=[Mostrar ou esconder a Barra Principal do Decursive
(âncora de lista ao vivo)]=] -- Needs review
L["BINDING_NAME_DCRSHOWOPTION"] = "Mostrar opção de painel estático" -- Needs review
L["BINDING_NAME_DCRSKADD"] = "Adiciona alvo à lista de passe" -- Needs review
L["BINDING_NAME_DCRSKCLEAR"] = "Limpar a lista de passe" -- Needs review
L["BINDING_NAME_DCRSKLIST"] = "Mostrar a lista de passe" -- Needs review
L["BINDING_NAME_DCRSKSHOW"] = "Mostra ou oculta a lista de passe" -- Needs review
L["BLACK_LENGTH"] = "Segundos na lista negra" -- Needs review
L["BLACKLISTED"] = "Lista negra" -- Needs review
L["CHARM"] = "Encantar" -- Needs review
L["CLASS_HUNTER"] = "Caçador"
L["COLORCHRONOS"] = "Cronometros" -- Needs review
L["CTRL"] = "Ctrl" -- Needs review
L["CURSE"] = "Maldição" -- Needs review
L["GLOR1"] = "Em memoria de Glorfindal" -- Needs review
L["GLOR2"] = [=[Decursive é dedicado a memoria de Bertrand que nós deixou muito cedo.
Ele sempre sera lembrado.]=] -- Needs review
L["GLOR3"] = [=[Em memoria de Bertrand Sense
1969-2007]=] -- Needs review
L["HIDESHOW_BUTTONS"] = "Mostrar/Esconder Buttoes" -- Needs review
L["OPT_NOSTARTMESSAGES"] = "Desativar mensagens de iniciar" -- Needs review
L["SHIFT"] = "Shift" -- Needs review
L["SHOW_MSG"] = "Para amostrar a janela do Decursive, escreve /dcrshow" -- Needs review
L["SKIP_SHOW"] = "S" -- Needs review
L["SPELL_FOUND"] = "%s feitiço nao foi encontrado" -- Needs review
L["STR_CLOSE"] = "Fechar" -- Needs review
L["STR_DCR_PRIO"] = "Prioridade do Decursive" -- Needs review



T._LoadedFiles["ptBR.lua"] = "2.7.3.5";

