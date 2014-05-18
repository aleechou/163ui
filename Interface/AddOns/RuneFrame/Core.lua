local A = LibStub("AceAddon-3.0"):NewAddon("RuneFrame")
if not A then return end

A:SetDefaultModuleState(true)

-- 新手提示功能
function ShowNewbieTooltip(__title, ...)
	if not __title then return end
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(__title, 1.0, 1.0, 1.0);
	local args = {...};
	local i;
	for i = 1, table.maxn(args), 1 do
		GameTooltip:AddLine(args[i], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1.0, 1);
	end
	GameTooltip:Show();
end

function HideNewbieTooltip()
	GameTooltip:Hide();
end