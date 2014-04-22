-- Author      : s1172
-- Create Date : 2013/5/9 13:11:34

function PanelKeyboardFrame_OnHide(self)
	if ToolTip_Logic.MouseShow then
		ToolTip_Logic.MouseShow=nil
		ToolTip_Logic:TutorialStart()
	end
end