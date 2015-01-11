if GetLocale() ~= "koKR" then return end
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
	TimerFirstSpecial	= "다음 증오/꼬챙이"
})

L:SetOptionLocalization({
	TimerFirstSpecial	= "$spell:105738 후 다음 특수 공격 바 보기<br/>(첫번째 특수 공격은 $spell:105067 와 $spell:104936 중 무작위로 결정됩니다.)"
})
