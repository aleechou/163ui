-- $Id: MiniMap-LDB.lua 3768 2012-09-21 14:47:34Z lag123 $
--[[
Atlasloot Enhanced
Author Hegarol
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)
]]

--Invoke libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

--Make an LDB object
local MiniMapLDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("AtlasLoot", {
    type = "launcher",
	text = AL["AtlasLoot"],
    icon = "Interface\\Icons\\INV_Box_01",
	OnTooltipShow = function(tooltip)
		tooltip:AddLine("|cff00FF00"..AL["AtlasLoot"].."|r");
		tooltip:AddLine(AL["|cffFF0000Click: |cffFFFFFFOpen AtlasLoot\n|cffFF0000Shift+Click: |cffFFFFFFOpen AtlasLoot-Options "]);
	end
})

local MiniMapIcon = LibStub("LibDBIcon-1.0")

function MiniMapLDB:OnClick(button,down)
	AtlasLoot:LoadModule("AtlasLoot")
	if IsShiftKeyDown() then
		AtlasLoot:OptionsToggle()
	else
		AtlasLoot:ShowFrame_MiniMap()
	end
end

function AtlasLoot:MiniMapButtonInitialize()
	MiniMapIcon:Register("AtlasLoot", MiniMapLDB, AtlasLootLoaderDB.MiniMapButton)
end

function AtlasLoot:MiniMapButtonHideShow()
	AtlasLootLoaderDB.MiniMapButton.hide = not AtlasLootLoaderDB.MiniMapButton.hide
	if AtlasLootLoaderDB.MiniMapButton.hide then
		MiniMapIcon:Hide("AtlasLoot")
	else
		MiniMapIcon:Show("AtlasLoot")
	end

end

-- Overwrite this in ../AtlasLoot/Modules/DefaultFrame.lua
local loadedMiniMap = false
function AtlasLoot:ShowFrame_MiniMap()
	if not loadedMiniMap then
		loadedMiniMap = true
		AtlasLoot:LoadModule("AtlasLoot")
		AtlasLoot:ShowFrame_MiniMap()
	end
end
--[[
function MiniMapLDB:OnEnter(motion)
end

function MiniMapLDB:OnLeave()
end
]]--