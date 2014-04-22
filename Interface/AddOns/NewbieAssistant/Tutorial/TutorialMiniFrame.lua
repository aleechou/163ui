-- Author      : s1172
-- Create Date : 2013/5/10 15:10:43


function TutorialMiniFrame_OnShow(self)

	local playAnim = self.levelFrame.levelUp

	self:SetPoint("TOP", 0, -190)

	self.gLine:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)
	self.gLine2:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

	self.gLine:SetVertexColor(1, 1, 1)
	self.gLine2:SetVertexColor(1, 1, 1)

	self.levelFrame.levelText:SetTextColor(1.0, 0.82, 0)
	
	playAnim:Play()

	self.levelFrame.levelText:SetPoint("BOTTOM",self,"BOTTOM",0,15)
end

-- 显示彩色框
function TutorialMiniFrame_Show(title, content, showType, noHide)
	if title and content and type(showType) == "string" then
		local self = TutorialMiniFrame
		local playAnim = self.levelFrame.levelUp
		local hideAnim = self.levelFrame.hideAnim

		local texture = format("Interface\\Addons\\NewbieAssistant\\Media\\Textures\\Tutorial\\Mini\\%s", showType)

		self.levelFrame.Icon:SetTexture(texture)
		self.levelFrame.reachedText:SetText(title)

		self.levelFrame.levelText:SetText(content)
		--font, _, fonttype = self.levelFrame.levelText:GetFont()
		--self.levelFrame.levelText:SetFont(font,18,fonttype)

		--if self:IsShown() then
		--	TutorialMiniFrameLevelFrameLevel:SetPoint("BOTTOM",TutorialMiniFrame,"BOTTOM",0,-15)
		--else
		self:Show()
		--end

		hideAnim:Stop()

		if noHide and type(noHide) ~= "number" then
			playAnim:SetScript("OnFinished",function(self)self:GetParent():SetAlpha(1)end)
		else
			if noHide and type(noHide) == "number" then
				hideAnim.h:SetStartDelay(noHide)
			else
				hideAnim.h:SetStartDelay(5)
			end
			playAnim:SetScript("OnFinished",function(self)
				self:GetParent():SetAlpha(1)
				self:GetParent().hideAnim:Play()
			end)
		end
	end
end

function TutorialMiniFrame_Hide()
	local self = TutorialMiniFrame
	if self:IsShown() then
		self.levelFrame.hideAnim:Stop()
		self.levelFrame.hideAnim.h:SetStartDelay(0)
		self.levelFrame.hideAnim:Play()
	end
end