local AtlasLoot = _G.AtlasLoot
local AL = AtlasLoot.Locales

-- lua
local str_format = string.format
local StaticPopupDialogs = StaticPopupDialogs
local EMPTY_FUNCTION = function() end

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
	preferredIndex = 3,
	text = AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."],
	button1 = AL["Setup"],
	OnAccept = function()
		AtlasLoot:OptionsToggle()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

--Popup Box for an old version of Atlas
StaticPopupDialogs["ATLASLOOT_OLD_ATLAS"] = {
	preferredIndex = 3,
	text = str_format(AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for (%s/%s).  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."], "InstalAtlas", "CompAtlas"),
	button1 = AL["OK"],
	OnAccept = function()
		AtlasLoot:Print(AL["Incompatible Atlas Detected"])
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

-- /run StaticPopup_Show ("ATLASLOOT_COPY_BOX", "TITLE: test", nil, "editBoxContent")
StaticPopupDialogs["ATLASLOOT_COPY_BOX"] = {
	preferredIndex = 3,
	text = "%s",
    button2 = _G.TEXT(_G.ACCEPT),
    hasEditBox = 1,
    hasWideEditBox = 1,
	editBoxWidth = 350,
	OnShow = function(self, data)
		local editBox = self.editBox
		editBox:SetText(data)
		editBox:SetFocus()
		editBox:HighlightText(0)

		local button = self.button2
		button:ClearAllPoints()
		button:SetWidth(100)
		button:SetPoint("CENTER", editBox, "CENTER", 0, -30)
	end,
	OnHide = EMPTY_FUNCTION,
	OnAccept = EMPTY_FUNCTION,
	OnCancel = EMPTY_FUNCTION,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}