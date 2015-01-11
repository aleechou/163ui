if GetLocale() ~= "deDE" then return end
local L


----------------
--  Argaloth  --
----------------
L= DBM:GetModLocalization(139)

-----------------
--  Occu'thar  --
-----------------
L= DBM:GetModLocalization(140)

----------------------------------
--  Alizabal, Mistress of Hate  --
----------------------------------
L= DBM:GetModLocalization(339)

L:SetTimerLocalization({
	TimerFirstSpecial		= "Erste Spezialfähigkeit"
})

L:SetOptionLocalization({
	TimerFirstSpecial		= "Zeige Zeit bis erste Spezialfähigkeit nach $spell:105738 (erste Spezialfähigkeit ist zufällig, entweder $spell:105067 oder $spell:104936)"
})
