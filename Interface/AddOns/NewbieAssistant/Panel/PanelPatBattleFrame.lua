-- Author      : s1172
-- Create Date : 2013/5/1 15:30:14

function NewbieAssistantPanelPetBattleFrameButton_OnClick(frame)
	local frames = {"SkillFrame","MoreFrame","BattleModeFrame","AttrFrame"}
	for	i,k in pairs(frames) do
		NewbieAssistantPanelPetBattleFrame[k]:Hide()
	end
	NewbieAssistantPanelPetBattleFrame[frame]:Show()
end