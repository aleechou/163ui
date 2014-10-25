--[[
	This file is part of 'Masque: LiteStep', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: LiteStep.lua
	* Revision.: 73
	* Author...: StormFX

	LiteStep Skins
]]

local MSQ = LibStub("Masque", true)
if not MSQ then return end

-- LiteStep
MSQ:AddSkin("LiteStep", {
	Author = "StormFX",
	Version = "6.0.0",
	Shape = "Square",
	Masque_Version = 60000,
	Backdrop = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Backdrop]],
	},
	Icon = {
		Width = 32,
		Height = 32,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Flash = {
		Width = 36,
		Height = 36,
		Color = {1, 0, 0, 0.3},
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Overlay]],
	},
	Cooldown = {
		Width = 32,
		Height = 32,
	},
	Pushed = {
		Width = 36,
		Height = 36,
		Color = {0, 0, 0, 0.5},
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Overlay]],
	},
	Normal = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Normal]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 36,
		Height = 36,
		BlendMode = "ADD",
		Color = {0, 0.8, 1, 0.8},
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Border]],
	},
	Border = {
		Width = 36,
		Height = 36,
		BlendMode = "ADD",
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Border]],
	},
	Gloss = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Gloss]],
	},
	AutoCastable = {
		Width = 64,
		Height = 64,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 36,
		Height = 36,
		BlendMode = "ADD",
		Color = {1, 1, 1, 0.5},
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Border]],
	},
	Name = {
		Width = 36,
		Height = 10,
		OffsetY = 3,
	},
	Count = {
		Width = 36,
		Height = 10,
		OffsetX = -1,
		OffsetY = 3,
	},
	HotKey = {
		Width = 36,
		Height = 10,
		OffsetX = -1,
		OffsetY = -5,
	},
	Duration = {
		Width = 36,
		Height = 10,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 32,
		Height = 32,
		OffsetX = 1,
		OffsetY = -1,
	},
}, true)

-- LiteStep XLT
MSQ:AddSkin("LiteStep XLT", {
	Template = "LiteStep",
	Normal = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_LiteStep\Textures\Lite]],
	},
}, true)
