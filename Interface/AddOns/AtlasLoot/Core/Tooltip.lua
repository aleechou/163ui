local _G = _G
local AtlasLoot = _G.AtlasLoot
local Tooltip = {}
AtlasLoot.Tooltip = Tooltip
local AL = AtlasLoot.Locales

local STANDART_TOOLTIP = "AtlasLootTooltip"

_G["AtlasLootTooltip"].shoppingTooltips = {ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3}

local TooltipList = {
	"GameTooltip",
	"AtlasLootTooltip",
}
--[[
local EventFrame = CreateFrame("FRAME")
EventFrame:RegisterEvent("MODIFIER_STATE_CHANGED")
local function OnEvent(frame, event, arg1, arg2)
	
end
EventFrame:SetScript("OnEvent", OnEvent)
]]--
function Tooltip.GetTooltip()
	return _G[AtlasLoot.db.Tooltip.tooltip or STANDART_TOOLTIP] or _G[STANDART_TOOLTIP]
end

function Tooltip:AddTooltipSource(src)
	TooltipList[#TooltipList+1] = src
end


