--[[
	This file is part of 'Masque: Apathy', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Apathy.lua
	* Revision.: 111
	* Author...: StormFX

	Apathy Skin
]]

local MSQ = LibStub("Masque", true)
if not MSQ then return end

-- Apathy
MSQ:AddSkin("Apathy", {
	Author = "StormFX",
	Version = "6.0.0",
	Shape = "Square",
	Masque_Version = 60000,
	Backdrop = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Backdrop]],
	},
	Icon = {
		Width = 28,
		Height = 28,
	},
	Flash = {
		Width = 32,
		Height = 32,
		Color = {1, 0, 0, 0.3},
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Overlay]],
	},
	Cooldown = {
		Width = 28,
		Height = 28,
	},
	Pushed = {
		Width = 32,
		Height = 32,
		Color = {0, 0, 0, 0.5},
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Overlay]],
	},
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.3, 0.3, 0.3, 1},
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Normal]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 32,
		Height = 32,
		BlendMode = "ADD",
		Color = {0, 0.8, 1, 0.5},
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Border]],
	},
	Border = {
		Width = 32,
		Height = 32,
		BlendMode = "ADD",
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Border]],
	},
	Gloss = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Gloss]],
	},
	AutoCastable = {
		Width = 54,
		Height = 54,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 32,
		Height = 32,
		BlendMode = "ADD",
		Color = {1, 1, 1, 0.5},
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Highlight]],
	},
	Name = {
		Width = 32,
		Height = 10,
		OffsetX = 2,
		OffsetY = 5,
	},
	Count = {
		Width = 32,
		Height = 10,
		OffsetX = -4,
		OffsetY = 5,
	},
	HotKey = {
		Width = 32,
		Height = 10,
		OffsetX = 1,
		OffsetY = -6,
	},
	Duration = {
		Width = 32,
		Height = 10,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 26,
		Height = 26,
		OffsetX = 1,
		OffsetY = -1,
	},
}, true)

-- No Shadow
MSQ:AddSkin("Apathy: No Shadow", {
	Template = "Apathy",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.3, 0.3, 0.3, 1},
		Texture = [[Interface\AddOns\Masque_Apathy\Textures\Normal_NS]],
	},
}, true)
