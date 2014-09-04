--[[ Darion skin for Masque ]]

local MSQ = LibStub("Masque", true)
if not MSQ then return end

-- Darion
MSQ:AddSkin("Darion", {
	Author = "Darsain",
	Version = "4.1.2",
	Shape = "Square",
	Masque_Version = 40200,
	Backdrop = {
		Width = 40,
		Height = 40,
		Color = {0.3, 0.3, 0.3, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Backdrop]],
	},
	Icon = {
		Width = 34,
		Height = 34,
	},
	Flash = {
		Width = 40,
		Height = 40,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Overlay]],
	},
	Cooldown = {
		Width = 34,
		Height = 34,
	},
	Pushed = {
		Width = 40,
		Height = 40,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Overlay]],
	},
	Normal = {
		Width = 40,
		Height = 40,
		Color = {0, 0, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Normal]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Highlight]],
	},
	Border = {
		Width = 40,
		Height = 40,
		BlendMode = "BLEND",
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Border]],
	},
	Gloss = {
		Width = 40,
		Height = 40,
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Gloss]],
	},
	AutoCastable = {
		Width = 34,
		Height = 34,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Highlight]],
	},
	Name = {
		Width = 32,
		Height = 10,
		OffsetX = 0,
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
		OffsetX = 4,
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

-- Darion Clean (old version)
MSQ:AddSkin("Darion Clean", {
	Author = "Darsain",
	Version = "4.1.2",
	Shape = "Square",
	Masque_Version = 40200,
	Backdrop = {
		Width = 40,
		Height = 40,
		Color = {0.3, 0.3, 0.3, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Backdrop]],
	},
	Icon = {
		Width = 34,
		Height = 34,
	},
	Flash = {
		Width = 40,
		Height = 40,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Overlay]],
	},
	Cooldown = {
		Width = 34,
		Height = 34,
	},
	Pushed = {
		Width = 40,
		Height = 40,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Overlay]],
	},
	Normal = {
		Width = 40,
		Height = 40,
		Color = {0.2, 0.2, 0.2, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Normal_clean]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Highlight]],
	},
	Border = {
		Width = 40,
		Height = 40,
		BlendMode = "BLEND",
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Border]],
	},
	Gloss = {
		Width = 40,
		Height = 40,
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Gloss_clean]],
	},
	AutoCastable = {
		Width = 34,
		Height = 34,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Texture = [[Interface\AddOns\ButtonFacade\Masque_Darion\Textures\Highlight]],
	},
	Name = {
		Width = 32,
		Height = 10,
		OffsetX = 0,
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
		OffsetX = 4,
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