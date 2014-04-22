-- Author      : s1172
-- Create Date : 2013/5/27 16:02:17

local function show(frame, this)
	local self = this
	if not self:IsShown() then
		self.relativeFrame = frame
		self:Show()
	else
		self:Hide()
	end
end

local cache = {}
function TutorialQuestObjPicFrame_Show(questId, texture)
	cache[questId] = cache[questId] or CreateFrame("Frame", nil, WorldMapPOIFrame, "TutorialQuestObjPicFrame")
	local frame = cache[questId]
	frame.texture = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Tutorial\\Objpic\\npc\\"..texture

	NAApi:SecureHook("WorldMapQuestPOI_OnClick",function(...)
		local poi = ...
		local frame = cache[poi.questId]
		if frame then
			for i, k in pairs(cache) do
				if k~=frame then
					k:Hide()
				end
			end
			show(poi, frame)
		else
			frame:Hide()
		end
	end)
end

function TutorialQuestObjPicFrame_OnShow(self)
	self:ClearAllPoints()

	if self.texture and self.relativeFrame then
		self:SetPoint("LEFT",self.relativeFrame,"RIGHT",50,0)
		self:SetFrameLevel(self.relativeFrame:GetFrameLevel()+10)
		self.Icon:SetTexture(self.texture)
	else
		self:Hide()
	end
end

function TutorialQuestObjPicFrame_OnEvent(self,event,...)
	if not self:IsVisible() and self:IsShown() then
		self:Hide()
	end
end