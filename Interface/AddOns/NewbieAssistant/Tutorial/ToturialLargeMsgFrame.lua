-- Author      : s1172
-- Create Date : 2013/5/10 11:32:00

function NewbieAssistantTutorialLargeMsgFrame_OnShow(self)
	if self.PlaySoundButton.url then
		self.PlaySoundButton:Show()
	else
		self.PlaySoundButton:Hide()
	end
end

function NewbieAssistantTutorialLargeMsgFrame_OnHide(self)
	if self.url then
		StopMusic()
	end
	if self.hideAnim:IsPlaying() then
		self.hideAnim:Stop()
	end
	if not self.CloseButton:IsShown() then
		self.CloseButton:Show()
	end
end

function NewbieAssistantTutorialLargeMsgFramePlaySoundButton_OnClick(self)
	if self.url then
		if self:GetChecked() then
			PlayMusic(self.url)
		else
			StopMusic()
		end
	end
end

function NewbieAssistantTutorialLargeMsgFrame_Show(content,url,second,notClose)
	if content then
		local self = NewbieAssistantTutorialLargeMsgFrame
		self:Hide()
		self.Description:SetText(content)
		self.PlaySoundButton.url = url
		self:Show()

		if notClose then
			self.CloseButton:Hide()
			return
		end

		if second then
			local alpha = self.hideAnim:GetAnimations()
			alpha:SetStartDelay(second)
			self.hideAnim:Play()
		end
	end
end