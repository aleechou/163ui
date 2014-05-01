-- Author      : s1172
-- Create Date : 2013/5/1 15:37:45


function NewbieAssistantPanelQuestFrame_OnShow(self)
	local data = self.data

	if not data then 
		self:Hide() 
		return 
	end
	
	self.NpcModel:SetDisplayInfo(data.Model)
	self.NpcName:SetText(data.ModelName)
	self.QuestTitle:SetText(data.Title)
	self.startloc:SetText(data.StartLoc)
	self.questdesc:SetText(data.Detial)
end
