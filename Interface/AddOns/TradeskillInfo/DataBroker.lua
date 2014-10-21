
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillInfo")
local LDB = LibStub("LibDataBroker-1.1", true)

if LDB then
	local object = LDB:NewDataObject("TradeSkillInfo")

	object.type = "launcher"
	object.text = "TradeSkillInfo"
	object.icon = "Interface\\Icons\\INV_Elemental_SpiritOfHarmony_2"

	object.OnClick = function(_, button)
		if button == "LeftButton" then
			TradeskillInfo:UI_Toggle()
		elseif button == "RightButton" then
			TradeskillInfo:ConfigToggle()
		end
	end

	object.OnTooltipShow = function(tooltip)
		tooltip:AddLine("TradeSkillInfo")
		tooltip:AddLine(L["Left Click"] .. ": " .. L["Open main window"] .. ".", 0, 1, 0)
		tooltip:AddLine(L["Right Click"] .. ": " .. L["Open configuration window"] .. ".", 0, 1, 0)
	end
end
