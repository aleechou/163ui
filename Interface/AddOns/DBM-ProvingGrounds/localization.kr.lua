if GetLocale() ~= "koKR" then return end
local L

------------------------
-- White TIger Temple --
------------------------
L= DBM:GetModLocalization("d640")

L:SetMiscLocalization({
	Endless				= "무한",
	ReplyWhisper		= "<Deadly Boss Mods> %s 님은 현재 바쁩니다. 수련의 장을 진행중입니다. (모드: %s, 단계: %d)"
})
