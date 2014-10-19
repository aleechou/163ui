if GetLocale() ~= "deDE" then return end
local L

------------------------
-- White TIger Temple --
------------------------
L= DBM:GetModLocalization("d640")

L:SetMiscLocalization({
	Endless				= "Endlos",
	ReplyWhisper		= "<Deadly Boss Mods> %s ist in der Feuerprobe beschäftigt (Modus: %s Welle: %d)"
})
