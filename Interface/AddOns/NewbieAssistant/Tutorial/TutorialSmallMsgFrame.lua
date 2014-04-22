-- Author      : s1172
-- Create Date : 2013/5/13 10:59:33

local TutorialSmallMsgFrame_Collection_Data = {}
local TutorialSmallMsgFrame_FirtIndex = 1

function TutorialSmallMsgFrame_Show(Arrow,point,relativeFrame,relativePoint,ofsx,ofsy,content,IsBlink,parentFrame)
	local frame = CreateFrame("frame", "TutorialSmallMsgFrame_"..TutorialSmallMsgFrame_FirtIndex, relativeFrame, "TutorialSmallMsgFrameTemplate")
	TutorialSmallMsgFrame_FirtIndex = TutorialSmallMsgFrame_FirtIndex + 1
	-- 设置内容
	if parentFrame then
		if type(parentFrame) == "table" then
			frame:SetParent(parentFrame)
		elseif type(parentFrame) == "number" then
			frame:SetWidth(parentFrame)
			frame.Text:SetWidth(parentFrame-20)
		end
	end
	--frame.Text:SetFont(frame.Text:GetFont(), 15, "NORMAL")
	frame.Text:SetText(content)
	-- 调整高度
	frame:SetHeight(frame.Text:GetHeight()+30)
	-- 显示箭头
	if Arrow == "UP" then
		frame.ArrowDOWN:Show()
		frame.ArrowGlowDOWN:Show()
	elseif Arrow == "DOWN" then
		frame.ArrowUP:Show()
		frame.ArrowGlowUP:Show()
	elseif Arrow == "RIGHT" then
		frame.ArrowLEFT:Show()
		frame.ArrowGlowLEFT:Show()
	elseif Arrow == "LEFT" then
		frame.ArrowRIGHT:Show()
		frame.ArrowGlowRIGHT:Show()
	end
	-- 设置位置
	-- frame:ClearAllPoints()
	frame:SetPoint(point,relativeFrame,relativePoint,ofsx,ofsy)

	frame:Show()
	-- 边框闪光
	if IsBlink then
		frame.CallOutFrame:Show()
	end
	-- 保存
	tinsert(TutorialSmallMsgFrame_Collection_Data, frame)

	return TutorialSmallMsgFrame_FirtIndex - 1
end

function TutorialSmallMsgFrame_Hide(frameIndex)
	if not frameIndex then return end
	if frameIndex == -1 then
		for	i,k in pairs(TutorialSmallMsgFrame_Collection_Data) do
			k:Hide()
			k=nil
		end
		TutorialSmallMsgFrame_Collection_Data={}
	else
		_G["TutorialSmallMsgFrame_"..frameIndex]:Hide()
		--tremove(TutorialSmallMsgFrame_Collection_Data,frameIndex)
	end
end