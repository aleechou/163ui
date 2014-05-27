-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

local math = _G.math
local table = _G.table

local pairs = _G.pairs
local select = _G.select
local tonumber = _G.tonumber
local tostring = _G.tostring

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub

local ADDON_NAME, private = ...
local Archy = LibStub("AceAddon-3.0"):GetAddon("Archy")
local L = LibStub("AceLocale-3.0"):GetLocale("Archy", false)

local QTip = LibStub("LibQTip-1.0")

local LDB_object = LibStub("LibDataBroker-1.1"):NewDataObject("Archy", {
	type = "data source",
	icon = [[Interface\Icons\trade_archaeology]],
	iconCoords = { 0.075, 0.925, 0.075, 0.925 },
	text = "Archy",
})
private.LDB_object = LDB_object

local HasArchaeology = private.HasArchaeology
local IsTaintable = private.IsTaintable

-----------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------
local ARTIFACTS = private.artifacts_db
local MAX_ARCHAEOLOGY_RANK = private.MAX_ARCHAEOLOGY_RANK
local ZONE_DATA = private.ZONE_DATA

local TOOLTIP_MODES = {
"artifacts_digsites",
"overall_completion"
}

local COUNT_DESCRIPTORS = {
rare_counts = true,
common_counts = true,
total_counts = true
}

-----------------------------------------------------------------------
-- Variables
-----------------------------------------------------------------------
local current_tooltip_mode = 1
local race_data = private.race_data

-----------------------------------------------------------------------
-- Tooltip cell provider.
-----------------------------------------------------------------------
local Archy_cell_provider, Archy_cell_prototype = QTip:CreateCellProvider()

local function Archy_cell_script(_, what, button)
	if what == "mode" then -- header was clicked, cycle display mode
		local nextmode = current_tooltip_mode + 1
		current_tooltip_mode = TOOLTIP_MODES[nextmode] and nextmode or 1
	end
	local key, value = (":"):split(what)

	if key == "raceid" and value then -- race was clicked show/hide uncomplete artifacts lists
		for race_id, _ in pairs(race_data) do
			if tonumber(value) ~= race_id then
				race_data[race_id].expand = nil
			else
				race_data[race_id].expand = not race_data[race_id].expand
			end
		end
	end

	if key == "spellid" and value then -- project link was clicked
		Archy:Print((_G.GetSpellLink(tonumber(value))))
	end
	Archy:LDBTooltipShow()
end

function Archy_cell_prototype:InitializeCell()
	local bar = self:CreateTexture(nil, "OVERLAY", self)
	self.bar = bar
	bar:SetWidth(100)
	bar:SetHeight(12)
	bar:SetPoint("LEFT", self, "LEFT", 1, 0)

	local bg = self:CreateTexture(nil, "BACKGROUND")
	self.bg = bg
	bg:SetWidth(102)
	bg:SetHeight(14)
	bg:SetTexture(0, 0, 0, 0.5)
	bg:SetPoint("LEFT", self)

	local fs = self:CreateFontString(nil, "OVERLAY")
	self.fs = fs
	fs:SetAllPoints(self)
	fs:SetFontObject(_G.GameTooltipText)
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1, -1)
	self.r, self.g, self.b = 1, 1, 1
end

function Archy_cell_prototype:SetupCell(tooltip, data, justification, font, r, g, b)
	local barTexture = [[Interface\TargetingFrame\UI-StatusBar]]
	local bar = self.bar
	local fs = self.fs
	--[[    { -- artifacts
    1 artifact.fragments,
    2 artifact.keystone_adjustment,
    3 artifact.fragments_required,
    4 raceData[race_id].keystone.inventory,
    5 artifact.sockets,
    6 artifact.keystones_added,
    7 artifact.canSolve,
    8 artifact.canSolveStone,
    9 artifact.canSolveInventory,
   10 artifact.rare }
   				{ -- rares overall progress
   	1 progress[1], -- done
   	2 progress[2], -- total }
]]
	local perc
	if current_tooltip_mode == 1 then -- artifacts_digsites
		perc = math.min((data.fragments + data.keystone_adjustment) / data.fragments_required * 100, 100)
		local bar_colors = private.db.artifact.fragmentBarColors

		if data.canSolve then
			self.r, self.g, self.b = bar_colors["Solvable"].r, bar_colors["Solvable"].g, bar_colors["Solvable"].b
		elseif data.canSolveInventory then
			self.r, self.g, self.b = bar_colors["AttachToSolve"].r, bar_colors["AttachToSolve"].g, bar_colors["AttachToSolve"].b
		elseif data.rare then
			self.r, self.g, self.b = bar_colors["Rare"].r, bar_colors["Rare"].g, bar_colors["Rare"].b
		else
			self.r, self.g, self.b = bar_colors["Normal"].r, bar_colors["Normal"].g, bar_colors["Normal"].b
		end

		local adjust = ""
		if data.keystone_adjustment > 0 then
			adjust = "(+" .. tostring(data.keystone_adjustment) .. ")"
		end

		fs:SetFormattedText("%d%s / %d", data.fragments, adjust, data.fragments_required)
	elseif current_tooltip_mode == 2 then -- overall_completion
		perc = math.min((data[1] / data[2]) * 100, 100)
		local bar_colors = private.db.artifact.fragmentBarColors

		if data[1] > 0 and data[1] == data[2] then -- all done
			self.r, self.g, self.b = bar_colors["Solvable"].r, bar_colors["Solvable"].g, bar_colors["Solvable"].b
		elseif data[1] > 0 and data[1] < data[2] then
			self.r, self.g, self.b = bar_colors["AttachToSolve"].r, bar_colors["AttachToSolve"].g, bar_colors["AttachToSolve"].b
		else
			self.r, self.g, self.b = 0.0, 0.0, 0.0
		end

		fs:SetFormattedText("%d / %d", data[1], data[2])
	end
	if perc > 0 then
		bar:SetWidth(perc)
		bar:SetVertexColor(self.r, self.g, self.b)
		bar:SetTexture(barTexture)
		bar:Show()
	else
		bar:Hide()
	end
	fs:SetFontObject(font or tooltip:GetFont())
	fs:SetJustifyH("CENTER")
	fs:SetTextColor(1, 1, 1)
	fs:Show()

	return bar:GetWidth() + 2, bar:GetHeight() + 2
end

function Archy_cell_prototype:ReleaseCell()
	self.r, self.g, self.b = 1, 1, 1
end

function Archy_cell_prototype:getContentHeight()
	return self.bar:GetHeight() + 2
end

-----------------------------------------------------------------------
-- Helper functions.
-----------------------------------------------------------------------
local function GetAchievementProgress()
	local rare, common = _G.NONE, _G.NONE
	local rare_ach, common_ach = 4854, 5315 -- "I had it in my hand" (Title: Assistant Professor), "Digger"
	local completed

	-- local id, name, points, completed, month, day, year, description, flags, icon, rewardText = GetAchievementInfo(achID);
	if select(4, _G.GetAchievementInfo(rare_ach)) then -- completed
		rare = select(11, _G.GetAchievementInfo(rare_ach)) -- rewardText
		rare_ach, completed = _G.GetNextAchievement(rare_ach)
		while rare_ach and completed do
			rare = select(11, _G.GetAchievementInfo(rare_ach))
			rare_ach, completed = _G.GetNextAchievement(rare_ach)
		end
	end
	if select(4, _G.GetAchievementInfo(common_ach)) then -- completed
		common = select(2, _G.GetAchievementInfo(common_ach)) -- name
		common_ach, completed = _G.GetNextAchievement(common_ach)
		while common_ach and completed do
			common = select(2, _G.GetAchievementInfo(common_ach))
			common_ach, completed = _G.GetNextAchievement(common_ach)
		end
	end
	return rare:gsub("^.+:", ""):trim(), common
end

local function GetArtifactsDelta(race_id, missing_data)
	local rare_count, common_count, total_count = 0, 0, 0
	local rare_missing, common_missing, total_missing = 0, 0, 0

	table.wipe(missing_data)

	for artifact, info in pairs(ARTIFACTS) do
		if info.raceid == race_id then
			if info.rarity == 0 then
				common_count = common_count + 1
			else
				rare_count = rare_count + 1
			end
			total_count = total_count + 1
			missing_data[artifact] = info -- flag all race artifacts as missing
		end
	end

	-- then remove the ones we've already solved at least once so we have the actual missing.
	local artifact_index = 1
	local artifact, _, _, _, _, _, _, _, completionCount = _G.GetArtifactInfoByRace(race_id, artifact_index)

	if artifact and completionCount > 0 and missing_data[artifact] then -- TODO: Maybe display "in progress" but not yet obtained artifacts different?
		missing_data[artifact] = nil
		artifact_index = artifact_index + 1
	end

	while artifact do
		artifact, _, _, _, _, _, _, _, completionCount = _G.GetArtifactInfoByRace(race_id, artifact_index)
		if artifact and completionCount > 0 and missing_data[artifact] then
			missing_data[artifact] = nil
		end
		artifact_index = artifact_index + 1
	end

	for artifact, info in pairs(missing_data) do
		if info.rarity == 0 then
			common_missing = common_missing + 1
		else
			rare_missing = rare_missing + 1
		end
		total_missing = total_missing + 1
	end
	missing_data["rare_counts"] = { rare_count - rare_missing, rare_count }
	missing_data["common_counts"] = { common_count - common_missing, common_count }
	missing_data["total_counts"] = { total_count - total_missing, total_count }

	return rare_count - rare_missing, rare_count, common_count - common_missing, common_count, total_count - total_missing, total_count
end
local progress_data, missing_data = {}, {}

function Archy:LDBTooltipShow()
	local num_columns, column_index, line
	local tooltip = self.LDB_Tooltip

	if current_tooltip_mode == 1 then -- artifacts_digsites
		num_columns, column_index, line = 10, 0, 0
		tooltip = QTip:Acquire("ArchyTooltip", num_columns, "CENTER", "LEFT", "LEFT", "LEFT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT")
	elseif current_tooltip_mode == 2 then -- overall_completion
		num_columns, column_index, line = 6, 0, 0
		tooltip = QTip:Acquire("ArchyTooltip", num_columns, "CENTER", "LEFT", "LEFT", "LEFT", "RIGHT")
	end
	tooltip:Hide()
	tooltip:Clear()

	local line = tooltip:AddHeader(".")
	tooltip:SetCell(line, 1, ("%s%s%s"):format(_G.ORANGE_FONT_COLOR_CODE, "Archy", "|r") .. "*", "CENTER", num_columns)
	tooltip:SetCellScript(line, 1, "OnMouseDown", Archy_cell_script, "mode")

	if HasArchaeology() then
		if current_tooltip_mode == 1 then
			line = tooltip:AddLine(".")

			local rank, maxRank = private.GetArchaeologyRank()
			local skill = ("%d/%d"):format(rank, maxRank)

			if maxRank < MAX_ARCHAEOLOGY_RANK and (maxRank - rank) <= 25 then
				skill = ("%s - |cFFFF0000%s|r"):format(skill, L["Visit a trainer!"])
			elseif maxRank == MAX_ARCHAEOLOGY_RANK and rank == maxRank then
				skill = ("%s%s|r"):format(_G.GREEN_FONT_COLOR_CODE, "MAX")
			end
			tooltip:SetCell(line, 1, ("%s%s|r%s"):format(_G.NORMAL_FONT_COLOR_CODE, _G.SKILL .. ": ", skill), "CENTER", num_columns)
			if private.db.general.show then
				line = tooltip:AddLine(".")
				tooltip:SetCell(line, 1, ("%s%s|r"):format("|cFFFFFF00", L["Artifacts"]), "LEFT", num_columns)
				tooltip:AddSeparator()

				line = tooltip:AddLine(".")
				tooltip:SetCell(line, 1, " ", "LEFT", 1)
				tooltip:SetCell(line, 2, _G.NORMAL_FONT_COLOR_CODE .. _G.RACE .. "|r", "LEFT", 1)
				tooltip:SetCell(line, 3, " ", "LEFT", 1)
				tooltip:SetCell(line, 4, _G.NORMAL_FONT_COLOR_CODE .. L["Artifact"] .. "|r", "LEFT", 2)
				tooltip:SetCell(line, 6, _G.NORMAL_FONT_COLOR_CODE .. L["Progress"] .. "|r", "CENTER", 1)
				tooltip:SetCell(line, 7, _G.NORMAL_FONT_COLOR_CODE .. L["Keys"] .. "|r", "CENTER", 1)
				tooltip:SetCell(line, 8, _G.NORMAL_FONT_COLOR_CODE .. L["Sockets"] .. "|r", "CENTER", 1)
				tooltip:SetCell(line, 9, _G.NORMAL_FONT_COLOR_CODE .. L["Completed"] .. "|r", "CENTER", 2)

				for race_id, artifact in pairs(private.artifact_data) do
					if artifact.fragments_required > 0 then
						line = tooltip:AddLine(" ")
						tooltip:SetCell(line, 1, " " .. ("|T%s:18:18:0:1:128:128:4:60:4:60|t"):format(race_data[race_id].texture), "LEFT", 1)
						tooltip:SetCell(line, 2, race_data[race_id].name, "LEFT", 1)
						tooltip:SetCell(line, 3, " " .. ("|T%s:18:18|t"):format(artifact.icon), "LEFT", 1)

						local artifactName = artifact.name

						if artifact.rare then
							artifactName = ("%s%s|r"):format("|cFF0070DD", artifactName)
						end

						tooltip:SetCell(line, 4, artifactName, "LEFT", 2)

						progress_data.fragments = artifact.fragments
						progress_data.keystone_adjustment = artifact.keystone_adjustment
						progress_data.fragments_required = artifact.fragments_required
						progress_data.race_keystone_inventory = race_data[race_id].keystone.inventory
						progress_data.sockets = artifact.sockets
						progress_data.keystones_added = artifact.keystones_added
						progress_data.canSolve = artifact.canSolve
						progress_data.canSolveStone = artifact.canSolveStone
						progress_data.canSolveInventory = artifact.canSolveInventory
						progress_data.rare = artifact.rare

						tooltip:SetCell(line, 6, progress_data, Archy_cell_provider, 1, 0, 0)
						tooltip:SetCell(line, 7, (race_data[race_id].keystone.inventory > 0) and race_data[race_id].keystone.inventory or "", "CENTER", 1)
						tooltip:SetCell(line, 8, (artifact.sockets > 0) and artifact.sockets or "", "CENTER", 1)

						local _, _, completionCount = private.GetArtifactStats(race_id, artifact.name)
						tooltip:SetCell(line, 9, completionCount or _G.UNKNOWN, "CENTER", 2)
					end
				end
				local site_stats = Archy.db.char.digsites.stats

				line = tooltip:AddLine(" ")
				line = tooltip:AddLine(" ")
				tooltip:SetCell(line, 1, ("%s%s|r"):format("|cFFFFFF00", L["Dig Sites"]), "LEFT", num_columns)
				tooltip:AddSeparator()

				for continent_id, continent_sites in pairs(private.continent_digsites) do
					if #continent_sites > 0 and (not private.db.tooltip.filter_continent or continent_id == private.current_continent) then -- current_continent) then
						local continent_name
						for _, zone in pairs(ZONE_DATA) do
							if zone.continent == continent_id and zone.id == 0 then
								continent_name = zone.name
								break
							end
						end

						if continent_name then
							line = tooltip:AddLine(" ")
							tooltip:SetCell(line, 1, "  " .. _G.ORANGE_FONT_COLOR_CODE .. continent_name .. "|r", "LEFT", num_columns) -- Drii: ticket 384
						end
						line = tooltip:AddLine(" ")
						tooltip:SetCell(line, 1, " ", "LEFT", 1)
						tooltip:SetCell(line, 2, _G.NORMAL_FONT_COLOR_CODE .. L["Fragment"] .. "|r", "LEFT", 2)
						tooltip:SetCell(line, 4, _G.NORMAL_FONT_COLOR_CODE .. L["Dig Site"] .. "|r", "LEFT", 1)
						tooltip:SetCell(line, 5, _G.NORMAL_FONT_COLOR_CODE .. _G.ZONE .. "|r", "LEFT", 2)
						tooltip:SetCell(line, 7, _G.NORMAL_FONT_COLOR_CODE .. L["Surveys"] .. "|r", "CENTER", 1)
						tooltip:SetCell(line, 8, _G.NORMAL_FONT_COLOR_CODE .. L["Digs"] .. "|r", "CENTER", 1)
						tooltip:SetCell(line, 9, _G.NORMAL_FONT_COLOR_CODE .. _G.ARCHAEOLOGY_RUNE_STONES .. "|r", "CENTER", 1)
						tooltip:SetCell(line, 10, _G.NORMAL_FONT_COLOR_CODE .. L["Keys"] .. "|r", "CENTER", 1)

						for _, site in pairs(continent_sites) do
							line = tooltip:AddLine(" ")
							tooltip:SetCell(line, 1, " " .. ("|T%s:18:18:0:1:128:128:4:60:4:60|t"):format(race_data[site.raceId].texture), "LEFT", 1)
							tooltip:SetCell(line, 2, race_data[site.raceId].name, "LEFT", 2)
							tooltip:SetCell(line, 4, site.name, "LEFT", 1)
							tooltip:SetCell(line, 5, site.zoneName, "LEFT", 2)
							tooltip:SetCell(line, 7, site_stats[site.id].surveys, "CENTER", 1)
							tooltip:SetCell(line, 8, site_stats[site.id].looted, "CENTER", 1)
							tooltip:SetCell(line, 9, site_stats[site.id].fragments, "CENTER", 1)
							tooltip:SetCell(line, 10, site_stats[site.id].keystones, "CENTER", 1)
						end
						line = tooltip:AddLine(" ")
					end
				end
			end
		elseif current_tooltip_mode == 2 then
			line = tooltip:AddLine(".")
			local rare_achiev, common_achiev = GetAchievementProgress()
			local achiev = ("%s%s|r - %s%s|r"):format(_G.ITEM_QUALITY_COLORS[3].hex, rare_achiev, _G.ITEM_QUALITY_COLORS[1].hex, common_achiev)
			tooltip:SetCell(line, 1, ("%s%s|r%s"):format(_G.NORMAL_FONT_COLOR_CODE, _G.ACHIEVEMENTS .. ": ", achiev), "CENTER", num_columns)

			if private.db.general.show then
				line = tooltip:AddLine(".")
				tooltip:SetCell(line, 1, ("%s%s|r"):format("|cFFFFFF00", _G.ACHIEVEMENT_CATEGORY_PROGRESS), "LEFT", num_columns)
				tooltip:AddSeparator()

				line = tooltip:AddLine(".")
				tooltip:SetCell(line, 1, " ", "LEFT", 1)
				tooltip:SetCell(line, 2, _G.NORMAL_FONT_COLOR_CODE .. _G.RACE .. "|r", "LEFT", 1)
				tooltip:SetCell(line, 3, _G.NORMAL_FONT_COLOR_CODE .. _G.ITEM_QUALITY3_DESC .. "|r", "LEFT", 1)
				tooltip:SetCell(line, 5, _G.NORMAL_FONT_COLOR_CODE .. _G.ITEM_QUALITY1_DESC .. "|r", "LEFT", 1)
				tooltip:SetCell(line, 6, _G.NORMAL_FONT_COLOR_CODE .. L["Total"] .. "|r", "RIGHT", 1)

				local all_rare_done, all_rare_count, all_common_done, all_common_count, all_total_done, all_total_count = 0, 0, 0, 0, 0, 0
				for race_id, _ in pairs(private.artifact_data) do
					local rare_done, rare_count, common_done, common_count, total_done, total_count = GetArtifactsDelta(race_id, missing_data)
					if total_count > 0 then -- skip races that are not yet implemented
						line = tooltip:AddLine(" ")
						tooltip:SetCell(line, 1, " " .. ("|T%s:18:18:0:1:128:128:4:60:4:60|t"):format(race_data[race_id].texture), "LEFT", 1)
						tooltip:SetCell(line, 2, race_data[race_id].name .. "*", "LEFT", 1)
						tooltip:SetCellScript(line, 2, "OnMouseDown", Archy_cell_script, "raceid:" .. race_id)
						tooltip:SetCell(line, 3, missing_data.rare_counts, Archy_cell_provider, 1, 0, 0)
						tooltip:SetCell(line, 5, missing_data.common_counts, Archy_cell_provider, 1, 0, 0)
						tooltip:SetCell(line, 6, total_done .. "/" .. total_count, "RIGHT", 1)
						all_rare_done = all_rare_done + rare_done
						all_rare_count = all_rare_count + rare_count
						all_common_done = all_common_done + common_done
						all_common_count = all_common_count + common_count
						all_total_done = all_total_done + total_done
						all_total_count = all_total_count + total_count
					end
				end

				if all_rare_done > 0 or all_rare_count > 0 or all_common_done > 0 or all_common_count > 0 or all_total_done > 0 or all_total_count > 0 then
					tooltip:AddSeparator()
					line = tooltip:AddLine(" ")
					tooltip:SetCell(line, 1, " ", "LEFT", 1)
					tooltip:SetCell(line, 2, _G.NORMAL_FONT_COLOR_CODE .. L["Total"] .. "|r", "LEFT", 1)
					tooltip:SetCell(line, 3, all_rare_done .. "/" .. all_rare_count, "LEFT", 1)
					tooltip:SetCell(line, 5, all_common_done .. "/" .. all_common_count, "LEFT", 1)
					tooltip:SetCell(line, 6, all_total_done .. "/" .. all_total_count, "RIGHT", 1)
				end

				for race_id, _ in pairs(private.artifact_data) do
					if race_data[race_id].expand then
						line = tooltip:AddLine(" ")
						line = tooltip:AddLine(" ")
						tooltip:SetCell(line, 1, ("%s%s|r"):format("|cFFFFFF00", race_data[race_id].name), "LEFT", num_columns)

						tooltip:AddSeparator()

						line = tooltip:AddLine(" ")
						tooltip:SetCell(line, 1, " ", "LEFT", 1)
						tooltip:SetCell(line, 2, _G.NORMAL_FONT_COLOR_CODE .. _G.ITEM_MISSING:format(_G.ITEM_QUALITY3_DESC) .. "|r", "LEFT", 1)
						tooltip:SetCell(line, 3, _G.NORMAL_FONT_COLOR_CODE .. _G.ITEM_MISSING:format(_G.ITEM_QUALITY1_DESC) .. "|r", "LEFT", 2)

						GetArtifactsDelta(race_id, missing_data)

						local start_line, end_line

						for artifact, info in pairs(missing_data) do -- rares first
							if not COUNT_DESCRIPTORS[artifact] and info.rarity > 0 then
								line = tooltip:AddLine(" ")
								tooltip:SetCell(line, 1, " ", "LEFT", 1)
								tooltip:SetCell(line, 2, ("%s%s|r"):format(_G.ITEM_QUALITY_COLORS[3].hex, artifact) .. "*", "LEFT", 1)
								tooltip:SetCellScript(line, 2, "OnMouseDown", Archy_cell_script, "spellid:" .. info.spellid)
								if not start_line then start_line = line end
								end_line = line
							end
						end

						if end_line and end_line >= start_line then -- commons next (not exhaustive)
							local line, cell = start_line, 3

							for artifact, info in pairs(missing_data) do
								if not COUNT_DESCRIPTORS[artifact] and info.rarity == 0 then
									if line <= end_line and cell <= 5 then
										tooltip:SetCell(line, cell, ("%s%s|r"):format(_G.ITEM_QUALITY_COLORS[1].hex, artifact), "LEFT", 2)
										cell = cell + 2

										if cell > 5 then
											line = line + 1
											cell = 3
										end
									else
										break
									end
								end
							end
						end
						break
					end
				end
			end
		end
	else
		line = tooltip:AddLine(" ")
		tooltip:SetCell(line, 1, L["Learn Archaeology in your nearest major city!"], "CENTER", num_columns)
	end

	line = tooltip:AddLine(" ")
	line = tooltip:AddLine(" ") tooltip:SetCell(line, 1, "|cFF00FF00" .. L["*Interactive tooltip region(s)"] .. "|r", "LEFT", num_columns)
	line = tooltip:AddLine(" ") tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Left-Click to toggle Archy"] .. "|r", "LEFT", num_columns)
	line = tooltip:AddLine(" ") tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Shift Left-Click to toggle Archy's on-screen lists"] .. "|r", "LEFT", num_columns)
	line = tooltip:AddLine(" ") tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Ctrl Left-Click to open Archy's options"] .. "|r", "LEFT", num_columns)
	line = tooltip:AddLine(" ") tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Right-Click to lock/unlock Archy"] .. "|r", "LEFT", num_columns)
	line = tooltip:AddLine(" ") tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Middle-Click to display the Archaeology window"] .. "|r", "LEFT", num_columns)

	tooltip:Show()

	if (tooltip:GetPoint()) then
		tooltip:UpdateScrolling()
	end
end

-----------------------------------------------------------------------
-- LDB_object methods
-----------------------------------------------------------------------
function LDB_object:OnEnter()
	if private.IsTaintable() then
		return
	end
	local tooltip = QTip:Acquire("ArchyTooltip")
	tooltip:SetScale(private.db.tooltip.scale)
	tooltip:SetAutoHideDelay(0.25, self)
	tooltip:EnableMouse()
	tooltip:SmartAnchorTo(self)

	Archy.LDB_Tooltip = tooltip
	Archy:LDBTooltipShow()
end

function LDB_object:OnLeave()
	-- This empty function is required for LDB displays which refuse to call an OnEnter without an OnLeave.
end

function LDB_object:OnClick(button, down)
	if button == "LeftButton" then
		if _G.IsShiftKeyDown() then
			private.db.general.stealthMode = not private.db.general.stealthMode
			Archy:ConfigUpdated()
		elseif _G.IsControlKeyDown() then
			_G.InterfaceOptionsFrame_OpenToCategory(Archy.optionsFrame)
		else
			private.db.general.show = not private.db.general.show
			Archy:LDBTooltipShow()
			if private.db.general.show and private.db.general.stealthMode then
				if not private.stealthWarned then
					Archy:Print(L["In stealth mode. Shift-click the button or type /archy stealth if you wanted to show the Artifact and Digsite frames."]) -- we warn only once/session
					private.stealthWarned = true
				end
			end
			Archy:ConfigUpdated()
		end
	elseif button == "RightButton" then
		private.db.general.locked = not private.db.general.locked
		Archy:Print(private.db.general.locked and _G.LOCKED or _G.UNLOCK)
		Archy:ConfigUpdated()
	elseif button == "MiddleButton" then
		Archy:ShowArchaeology()
	end
end

