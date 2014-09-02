--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Skins\Zoomed.lua
	* Revision.: 396
	* Author...: JJSheets, StormFX

	'Zoomed' skin for Masque.
]]

local _, Core = ...

Core:AddSkin("Zoomed", {
	Author = "JJSheets, StormFX",
	Version = "5.4.396",
	Masque_Version = 40300,
	Shape = "Square",
	Backdrop = {
		Hide = true,
	},
	Icon = {
		Width = 36,
		Height = 36,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Flash = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
	Cooldown = {
		Width = 36,
		Height = 36,
	},
	Pushed = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
	},
	Normal = {
		Hide = true,
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 38,
		Height = 38,
		BlendMode = "ADD",
		Texture = [[Interface\Buttons\CheckButtonHilight]],
	},
	Border = {
		Width = 66,
		Height = 66,
		OffsetX = 0.5,
		OffsetY = 0.5,
		BlendMode = "ADD",
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = 66,
		Height = 66,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 36,
		Height = 36,
		BlendMode = "ADD",
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
	},
	Name = {
		Width = 36,
		Height = 10,
		OffsetY = 1,
	},
	Count = {
		Width = 36,
		Height = 10,
		OffsetX = 1,
		OffsetY = 1,
	},
	HotKey = {
		Width = 36,
		Height = 10,
		OffsetY = -1,
	},
	Duration = {
		Width = 36,
		Height = 10,
		OffsetY = -3,
	},
	AutoCast = {
		Width = 34,
		Height = 34,
		OffsetX = 0.5,
		OffsetY = -0.5
	},
})
