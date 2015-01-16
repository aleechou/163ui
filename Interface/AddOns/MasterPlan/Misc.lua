local _, T = ...
if T.Mark ~= 23 then return end
local L = T.L

do -- trait books tooltip warning
	local function OnItem(self)
		local _, link = self:GetItem()
		local id = link and link:match("item:(%d+)")
		if id == "118474" or id == "118475" then
			local nl = self:NumLines()
			local tl, tr = _G[self:GetName() .. "TextLeft" .. nl], _G[self:GetName() .. "TextRight" .. nl]
			if tr:IsShown() or nl > 5 then
				self:AddLine("|n" .. L"Using this item replaces a random trait.", 1, 0.40, 0, 1)
			else
				local t, r, g, b = tl:GetText(), tl:GetTextColor()
				tl:SetText(L"Using this item replaces a random trait.")
				tl:SetTextColor(1,0.40,0)
				self:AddLine(t, r, g, b, 1)
			end
			self:Show()
		end
	end
	GameTooltip:HookScript("OnTooltipSetItem", OnItem)
	ItemRefTooltip:HookScript("OnTooltipSetItem", OnItem)
end