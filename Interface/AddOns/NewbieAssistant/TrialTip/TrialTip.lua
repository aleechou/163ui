-- Author      : s1172
-- Create Date : 2013/2/28 13:04:13

-- 延迟函数
local TrialTipFrame_CallOut_Interval_Frame=CreateFrame("frame")
local function TrialTipFrame_CallOut_Interval(relativeFrame,intervalTime,flickerTimes)
	TrialTipFrame_CallOut_Interval_Frame:SetScript("OnUpdate",nil)
	TrialTipFrame_CallOut:Hide()
	OverTime = GetTime()
	i=1
	TrialTipFrame_CallOut_Interval_Frame:SetScript("OnUpdate",function()
		if i<=flickerTimes and GetTime()-OverTime>=intervalTime then
			if relativeFrame:IsShown() then
				if TrialTipFrame_CallOut:IsShown() then
					TrialTipFrame_CallOut:Hide()
				else
					TrialTipFrame_CallOut:Show()
				end
				i = i+1
				OverTime = GetTime()
			else
				TrialTipFrame_CallOut_Interval_Frame:SetScript("OnUpdate",nil)
			end
		elseif i>flickerTimes then
			TrialTipFrame_CallOut_Interval_Frame:SetScript("OnUpdate",nil)
		end
	end)
end

-- 边框闪光
function TrialTipFrame_CallOut_Show(relativeFrame)
	local width, height = relativeFrame:GetSize()
	TrialTipFrame_CallOut:SetParent(relativeFrame)
	TrialTipFrame_CallOut:SetSize(width+20,height+16)
	TrialTipFrame_CallOut:SetPoint("TOP",relativeFrame,"TOP",0,7)
	TrialTipFrame_CallOut_Interval(relativeFrame,1,6)
end

-- 显示提示框
function TrialTipFrame_Show(Arrow,Parent,point,relativeFrame,relativePoint,ofsx,ofsy,content,fontSize)
	frame=TrialTipFrame
	-- 初始化
	TrialTipFrame_Hide()
	-- 设置父窗口
	frame:SetParent(Parent)
	-- 设置内容
	--frame.Text:SetFont(frame.Text:GetFont(), fontSize, "NORMAL")
	frame.Text:SetText(content)
	-- 调整高度
	frame:SetHeight(frame.Text:GetHeight()+30)
	-- 显示箭头
	if Arrow=="UP" then
		frame.ArrowDOWN:Show()
		frame.ArrowGlowDOWN:Show()
	elseif Arrow=="DOWN" then
		frame.ArrowUP:Show()
		frame.ArrowGlowUP:Show()
	elseif Arrow=="RIGHT" then
		frame.ArrowLEFT:Show()
		frame.ArrowGlowLEFT:Show()
	elseif Arrow=="LEFT" then
		frame.ArrowRIGHT:Show()
		frame.ArrowGlowRIGHT:Show()
	end
	-- 设置位置
	frame:SetPoint(point,relativeFrame,relativePoint,ofsx,ofsy)
	frame:Show()
	-- 闪光
	TrialTipFrame_CallOut_Show(frame)
end

-- 隐藏提示框
function TrialTipFrame_Hide()
	frame=TrialTipFrame
	frame.ArrowUP:Hide()
	frame.ArrowGlowUP:Hide()
	frame.ArrowDOWN:Hide()
	frame.ArrowGlowDOWN:Hide()
	frame.ArrowLEFT:Hide()
	frame.ArrowGlowLEFT:Hide()
	frame.ArrowRIGHT:Hide()
	frame.ArrowGlowRIGHT:Hide()
	frame:ClearAllPoints()
	frame:Hide()
end

