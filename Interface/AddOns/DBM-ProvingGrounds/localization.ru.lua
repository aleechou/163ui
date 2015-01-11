if GetLocale() ~= "ruRU" then return end
local L

------------------------
-- White TIger Temple --
------------------------
L= DBM:GetModLocalization("d640")

L:SetMiscLocalization({
	Endless				= "Бесконечный",--Could not find a global for this one.
	ReplyWhisper		= "<Deadly Boss Mods> %s занят на арене испытаний (Режим: %s Волна: %d)"
})
