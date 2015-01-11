if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "Su majestad Maulgar"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "Gruul el Asesino de Dragones"
}

L:SetWarningLocalization{
	WarnGrowth	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnGrowth	= "Mostrar aviso para $spell:36300"
}


-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Magtheridon"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerP2	= "Phase 2"
}

L:SetOptionLocalization{
	timerP2	= "Mostrar tiempo para el inicio de Fase 2"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "¡Las cuerdas de %s empiezan a aflojarse!",
	DBM_MAG_YELL_PHASE2		= "¡He... sido... liberado!",
	DBM_MAG_YELL_PHASE3		= "¡No me dejaré encerrar tan fácilmente! ¡Que tiemblen las paredes de esta prisión... y se derrumben!"
}

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "Señor de fatalidad Kazzak"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SetIconOnMark		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(32960)
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s becomes enraged!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "Caminante del Destino"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s becomes enraged!"--Probalby won't be used, at least not long. Once spellid replaces it
}