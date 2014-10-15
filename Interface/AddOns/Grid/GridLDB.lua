--[[--------------------------------------------------------------------
	Grid
	Compact party and raid unit frames.
	Copyright (c) 2006-2012 Kyle Smith (a.k.a. Pastamancer), A. Kinley (a.k.a. Phanx) <addons@phanx.net>
	All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info5747-Grid.html
	http://www.wowace.com/addons/grid/
	http://www.curse.com/addons/wow/grid
----------------------------------------------------------------------]]

local DataBroker = LibStub("LibDataBroker-1.1", true)
if not DataBroker then return end

local GRID, Grid = ...
local L = Grid.L

local GridLDB = DataBroker:NewDataObject("Grid", {
	type = "launcher",
	label = GetAddOnInfo("Grid", "Title"),
	icon = "Interface\\AddOns\\Grid\\icon",
	OnClick = function(self, button)
		if button == "RightButton" then
			local dialog = LibStub("AceConfigDialog-3.0")
			if dialog.OpenFrames["Grid"] then
				dialog:Close("Grid")
			else
				dialog:Open("Grid")
			end
		elseif not InCombatLockdown() then
			local GridLayout = Grid:GetModule("GridLayout")
			GridLayout.db.profile.FrameLock = not GridLayout.db.profile.FrameLock
			LibStub("AceConfigRegistry-3.0"):NotifyChange("Grid")
			GridLayout:UpdateTabVisibility()
		end
	end,
	OnTooltipShow = function(tooltip)
		tooltip:AddLine("Grid", 1, 1, 1)
		if InCombatLockdown() then
			tooltip:AddLine(L["Click to toggle the frame lock."], 0.5, 0.5, 0.5)
		else
			tooltip:AddLine(L["Click to toggle the frame lock."])
		end
		tooltip:AddLine(L["Right-Click for more options."])
	end,
})

local LDBIcon = LibStub("LibDBIcon-1.0", true)
if not LDBIcon then return end

hooksecurefunc(Grid, "OnInitialize", function(self)
	self.db.profile.minimap = self.db.profile.minimap or { }

	LDBIcon:Register("Grid", GridLDB, self.db.profile.minimap)

	self.options.args.minimap = {
		order = -3,
		name = L["Hide minimap icon"],
		desc = L["Hide minimap icon"],
		width = "double",
		type = "toggle",
		get = function()
			return self.db.profile.minimap.hide
		end,
		set = function(_, v)
			if self.db.profile.minimap.hide then
				LDBIcon:Show("Grid")
				self.db.profile.minimap.hide = nil
			else
				LDBIcon:Hide("Grid")
				self.db.profile.minimap.hide = true
			end
		end
	}

	if self.db.profile.minimap.hide then
		LDBIcon:Hide("Grid")
	else
		LDBIcon:Show("Grid")
	end
end)

hooksecurefunc(Grid, "OnProfileEnable", function(self)
	self.db.profile.minimap = self.db.profile.minimap or { }

	LDBIcon:Refresh("Grid", self.db.profile.minimap)

	if self.db.profile.minimap.hide then
		LDBIcon:Hide("Grid")
	else
		LDBIcon:Show("Grid")
	end
end)
