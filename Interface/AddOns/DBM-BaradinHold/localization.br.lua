﻿if GetLocale() ~= "ptBR" then return end

local L

----------------
--  Argaloth  --
----------------
L= DBM:GetModLocalization(139)

L:SetOptionLocalization({
	SetIconOnConsuming		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88954)
})

-----------------
--  Occu'thar  --
-----------------
L= DBM:GetModLocalization(140)

----------------------------------
--  Alizabal, Mistress of Hate  --
----------------------------------
L= DBM:GetModLocalization(339)

L:SetTimerLocalization({
	TimerFirstSpecial		= "Primeiro especial"
})

L:SetOptionLocalization({
	TimerFirstSpecial		= "Mostrar cronógrafo para o primeiro especial após $spell:105738<br/>(O primeiro especial é aleatório. Ou $spell:105067 ou $spell:104936)"
})
