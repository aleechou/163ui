--[[
	This file is part of 'Masque: Gears', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Gears.lua
	* Revision.: 76
	* Author...: StormFX

	Gear Skins
]]

local MSQ = LibStub("Masque", true)
if not MSQ then return end

-- Gears
MSQ:AddSkin("Gears", {
	Author = "StormFX, Unknown",
	Version = "6.0.0",
	Shape = "Circle",
	Masque_Version = 60000,
	Backdrop = {
		Width = 40,
		Height = 40,
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Backdrop]],
	},
	Icon = {
		Width = 24,
		Height = 24,
	},
	Flash = {
		Width = 40,
		Height = 40,
		Color = {1, 0, 0, 0.8},
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Overlay]],
	},
	Cooldown = {
		Width = 24,
		Height = 24,
	},
	Pushed = {
		Width = 40,
		Height = 40,
		Color = {0, 0, 0, 0.8},
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Overlay]],
	},
	Normal = {
		Width = 40,
		Height = 40,
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Normal]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Color = {0, 0.8, 1, 0.5},
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Border]],
	},
	Border = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Border]],
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Color = {1, 1, 1, 0.8},
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Highlight]],
	},
	Name = {
		Width = 40,
		Height = 10,
		OffsetY = 2,
	},
	Count = {
		Width = 40,
		Height = 10,
		OffsetY = 4,
	},
	HotKey = {
		Width = 40,
		Height = 10,
		JustifyH = "CENTER",
	},
	Duration = {
		Width = 40,
		Height = 10,
	},
	AutoCast = {
		Width = 16,
		Height = 16,
	},
}, true)

-- Gears: Black
MSQ:AddSkin("Gears: Black", {
	Template = "Gears",
	Normal = {
		Width = 40,
		Height = 40,
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Black]],
	},
}, true)

-- Gears: Spark
MSQ:AddSkin("Gears: Spark", {
	Template = "Gears",
	Normal = {
		Width = 40,
		Height = 40,
		Texture = [[Interface\AddOns\Masque_Gears\Textures\Spark]],
	},
}, true)
