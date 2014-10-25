--[[
	This file is part of 'Masque: Entropy', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Entropy.lua
	* Revision.: 85
	* Author...: StormFX

	Entropy Skins
]]

local MSQ = LibStub("Masque", true)
if not MSQ then return end

-- Silver
MSQ:AddSkin("Entropy: Silver", {
	Author = "StormFX",
	Version = "6.0.0",
	Shape = "Square",
	Masque_Version = 60000,
	Backdrop = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Backdrop]],
	},
	Icon = {
		Width = 28,
		Height = 28,
	},
	Flash = {
		Width = 32,
		Height = 32,
		Color = {1, 0, 0, 0.5},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Overlay]],
	},
	Cooldown = {
		Width = 28,
		Height = 28,
	},
	Pushed = {
		Width = 32,
		Height = 32,
		Color = {0, 0, 0, 0.5},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Overlay]],
	},
	Normal = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 32,
		Height = 32,
		BlendMode = "ADD",
		Color = {0, 0.8, 1, 0.5},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Border]],
	},
	Border = {
		Width = 32,
		Height = 32,
		BlendMode = "ADD",
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Border]],
	},
	Gloss = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Gloss]],
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
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Highlight]],
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

-- Adamantite
MSQ:AddSkin("Entropy: Adamantite", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.7, 0.8, 0.9, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Bronze
MSQ:AddSkin("Entropy: Bronze", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {1, 0.8, 0, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Cobalt
MSQ:AddSkin("Entropy: Cobalt", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.3, 0.7, 0.9, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Copper
MSQ:AddSkin("Entropy: Copper", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.8, 0.5, 0, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Fel Iron
MSQ:AddSkin("Entropy: Fel Iron", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.8, 1, 0.8, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Gold
MSQ:AddSkin("Entropy: Gold", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.8, 0.8, 0, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Iron
MSQ:AddSkin("Entropy: Iron", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.5, 0.5, 0.5, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Khorium
MSQ:AddSkin("Entropy: Khorium", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {1, 0.8, 0.9, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Obsidium
MSQ:AddSkin("Entropy: Obsidium", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.3, 0.3, 0.3, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Saronite
MSQ:AddSkin("Entropy: Saronite", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {0.3, 0.9, 0.7, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)

-- Titanium
MSQ:AddSkin("Entropy: Titanium", {
	Template = "Entropy: Silver",
	Normal = {
		Width = 32,
		Height = 32,
		Color = {1, 1, 0.7, 1},
		Texture = [[Interface\AddOns\Masque_Entropy\Textures\Normal]],
	},
}, true)
