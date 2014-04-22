-- Author      : s1172
-- Create Date : 2013/5/27 13:18:08

local TutorialTinyMsgFrame_Collection_Data = {}
local TutorialTinyMsgFrame_FirtIndex = 1

function TutorialTinyMsgFrame_Show(Arrow,point,relativeFrame,relativePoint,ofsx,ofsy,content,parent)
	local frame = CreateFrame("frame", "TutorialTinyMsgFrame_"..TutorialTinyMsgFrame_FirtIndex, relativeFrame, "TutorialTinyMsgFrameTemplate")
	TutorialTinyMsgFrame_FirtIndex = TutorialTinyMsgFrame_FirtIndex + 1
	if parent then
		frame:SetParent(parent)
	end
	frame.Text:SetText(content)
	if Arrow == "BOTTOMLEFT" then
		frame.Texture:SetTexCoord(0.734375,0,0,0.6328125)
	elseif Arrow == "TOPLEFT" then
		frame.Texture:SetTexCoord(0.734375,0,0.6328125,0)
		frame.Text:SetPoint("TOPLEFT",frame,"TOPLEFT",10,-27)
	elseif Arrow == "TOPRIGHT" then
		frame.Texture:SetTexCoord(0,0.734375,0.6328125,0)
		frame.Text:SetPoint("TOPLEFT",frame,"TOPLEFT",8,-25)
	end

	frame:SetPoint(point,relativeFrame,relativePoint,ofsx,ofsy)
	frame:SetFrameLevel(relativeFrame:GetFrameLevel()+10)
	frame:Show()

	tinsert(TutorialTinyMsgFrame_Collection_Data, frame)

	return TutorialTinyMsgFrame_FirtIndex - 1
end

function TutorialTinyMsgFrame_Hide(index)
	if not index then return end
	if index == -1 then
		for	i,k in pairs(TutorialTinyMsgFrame_Collection_Data) do
			k:Hide()
			k=nil
		end
		TutorialTinyMsgFrame_Collection_Data = {}
	else
		_G["TutorialTinyMsgFrame_"..index]:Hide()
	end
end