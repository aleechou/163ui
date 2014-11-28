-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

local math = _G.math
local table = _G.table

local ipairs = _G.ipairs
local next = _G.next
local pairs = _G.pairs
local select = _G.select
local setmetatable = _G.setmetatable
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type
local unpack = _G.unpack

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub

local ADDON_NAME, private = ...
local Archy = LibStub("AceAddon-3.0"):NewAddon("Archy", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceBucket-3.0", "AceTimer-3.0", "LibSink-2.0", "LibToast-1.0")
Archy.version = _G.GetAddOnMetadata(ADDON_NAME, "Version")
_G["Archy"] = Archy


local Astrolabe = _G.DongleStub("Astrolabe-1.0")
local Dialog = LibStub("LibDialog-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Archy", false)
local LDBI = LibStub("LibDBIcon-1.0")
local LSM = LibStub("LibSharedMedia-3.0")
local Toast = LibStub("LibToast-1.0")

if not LSM then
	_G.LoadAddOn("LibSharedMedia-3.0")
	LSM = LibStub("LibSharedMedia-3.0", true)
end

if LSM then
	local DEFAULT_LSM_FONT = "Arial Narrow"

	if not LSM:IsValid("font", DEFAULT_LSM_FONT) then
		DEFAULT_LSM_FONT = LSM:GetDefault("font")
	end
end

-----------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------
local DIG_SITES = private.dig_sites
local MAX_PROFESSION_RANK = _G.GetExpansionLevel() + 4 -- Skip the 4 ranks of vanilla
local MAX_ARCHAEOLOGY_RANK = _G.PROFESSION_RANKS[MAX_PROFESSION_RANK][1]
private.MAX_ARCHAEOLOGY_RANK = MAX_ARCHAEOLOGY_RANK

local MAP_FILENAME_TO_MAP_ID = {} -- Popupated in OnInitialize()
local MAP_ID_TO_CONTINENT_ID = {} -- Popupated in OnInitialize()
local MAP_ID_TO_ZONE_ID = {} -- Popupated in OnInitialize()
local MAP_ID_TO_ZONE_NAME = {} -- Popupated in OnInitialize()

local MINIMAP_SIZES = {
	indoor = {
		[0] = 300,
		[1] = 240,
		[2] = 180,
		[3] = 120,
		[4] = 80,
		[5] = 50,
	},
	outdoor = {
		[0] = 466 + 2 / 3,
		[1] = 400,
		[2] = 333 + 1 / 3,
		[3] = 266 + 2 / 6,
		[4] = 200,
		[5] = 133 + 1 / 3,
	},
	indoor_scale = {
		[0] = 1,
		[1] = 1.25,
		[2] = 5 / 3,
		[3] = 2.5,
		[4] = 3.75,
		[5] = 6,
	},
	outdoor_scale = {
		[0] = 1,
		[1] = 7 / 6,
		[2] = 1.4,
		[3] = 1.75,
		[4] = 7 / 3,
		[5] = 3.5,
	},
}

local PROFILE_DEFAULTS = {
	profile = {
		general = {
			enabled = true,
			show = true,
			stealthMode = false,
			combathide = false,
			icon = {
				hide = false
			},
			locked = false,
			confirmSolve = true,
			showSkillBar = true,
			sinkOptions = {
				sink20OutputSink = "LibToast-1.0",
			},
			easyCast = false,
			autoLoot = true,
			theme = "Graphical",
			manualTrack = false,
		},
		artifact = {
			show = true,
			position = {
				"TOPRIGHT",
				"TOPRIGHT",
				-200,
				-425
			},
			anchor = "TOPRIGHT",
			positionX = 100,
			positionY = -300,
			scale = 0.75,
			alpha = 1,
			filter = true,
			announce = true,
			keystoneAnnounce = true,
			ping = true,
			keystonePing = true,
			blacklist = {},
			autofill = {},
			style = "Compact",
			borderAlpha = 1,
			bgAlpha = 0.5,
			font = {
				name = "Friz Quadrata TT",
				size = 14,
				shadow = true,
				outline = "",
				color = {
					r = 1,
					g = 1,
					b = 1,
					a = 1
				}
			},
			fragmentFont = {
				name = "Friz Quadrata TT",
				size = 14,
				shadow = true,
				outline = "",
				color = {
					r = 1,
					g = 1,
					b = 1,
					a = 1
				}
			},
			keystoneFont = {
				name = "Friz Quadrata TT",
				size = 12,
				shadow = true,
				outline = "",
				color = {
					r = 1,
					g = 1,
					b = 1,
					a = 1
				}
			},
			fragmentBarColors = {
				["Normal"] = {
					r = 1,
					g = 0.5,
					b = 0
				},
				["Solvable"] = {
					r = 0,
					g = 1,
					b = 0
				},
				["Rare"] = {
					r = 0,
					g = 0.4,
					b = 0.8
				},
				["AttachToSolve"] = {
					r = 1,
					g = 1,
					b = 0
				},
				["FirstTime"] = {
					r = 1,
					g = 1,
					b = 1
				},
			},
			fragmentBarTexture = "Blizzard Parchment",
			borderTexture = "Blizzard Dialog Gold",
			backgroundTexture = "Blizzard Parchment",
		},
		digsite = {
			show = true,
			position = {
				"TOPRIGHT", "TOPRIGHT", -200, -200
			},
			anchor = "TOPRIGHT",
			positionX = 400,
			positionY = -300,
			scale = 0.75,
			alpha = 1,
			style = "Extended",
			sortByDistance = true,
			announceNearest = true,
			distanceIndicator = {
				enabled = true,
				green = 40,
				yellow = 80,
				position = {
					"CENTER",
					"CENTER",
					0,
					0
				},
				anchor = "TOPLEFT",
				undocked = false,
				showSurveyButton = true,
				showCrateButton = true,
				showLorItemButton = true,
				font = {
					name = "Friz Quadrata TT",
					size = 16,
					shadow = false,
					outline = "OUTLINE",
					color = {
						r = 1,
						g = 1,
						b = 1,
						a = 1
					}
				},
			},
			borderAlpha = 1,
			bgAlpha = 0.5,
			font = {
				name = "Friz Quadrata TT",
				size = 18,
				shadow = true,
				outline = "",
				color = {
					r = 1,
					g = 1,
					b = 1,
					a = 1
				}
			},
			zoneFont = {
				name = "Friz Quadrata TT",
				size = 14,
				shadow = true,
				outline = "",
				color = {
					r = 1,
					g = 0.82,
					b = 0,
					a = 1
				}
			},
			minimal = {
				showDistance = false,
				showZone = false,
				showDigCounter = true,
			},
			borderTexture = "Blizzard Dialog Gold",
			backgroundTexture = "Blizzard Parchment",
		},
		minimap = {
			show = true,
			nearest = true,
			fragmentNodes = true,
			fragmentIcon = "CyanDot",
			fragmentColorBySurveyDistance = true,
			useBlobDistance = true,
		},
		tooltip = {
			filter_continent = false,
			scale = 1,
		},
		tomtom = {
			enabled = true,
			distance = 125,
			ping = true,
		},
	},
}

local GLOBAL_COOLDOWN_TIME = 1.5
local SECURE_ACTION_BUTTON -- Populated in OnInitialize()
local SITES_PER_CONTINENT = 4
local SURVEYS_PER_DIGSITE = 6
local SURVEY_SPELL_ID = 80451
local CRATE_SPELL_ID = 126935
local CRATE_SPELL_NAME = (_G.GetSpellInfo(CRATE_SPELL_ID))
local CRATE_USE_STRING -- Populate in HasArchaeology()

local ZONE_DATA = {}
private.ZONE_DATA = ZONE_DATA

local ZONE_ID_TO_NAME = {} -- Popupated in OnInitialize()
local MAP_CONTINENTS = {} -- Popupated in CacheMapData()

local LOREWALKER_ITEMS = {
	MAP = { id = 87549, spell = 126957 },
	LODESTONE = { id = 87548, spell = 126956 },
}
local QUEST_ITEM_IDS = {
	[79049] = true
}
local CRATE_OF_FRAGMENTS = {
	-- all pre-MoP races at Mists of Pandaria expansion
	[87533] = true, -- Dwarven
	[87534] = true, -- Draenei
	[87535] = true, -- Fossil
	[87536] = true, -- Night Elf
	[87537] = true, -- Nerubian
	[87538] = true, -- Orc
	[87539] = true, -- Tol'vir
	[87540] = true, -- Troll
	[87541] = true, -- Vrykul
}

_G.BINDING_HEADER_ARCHY = "Archy"
_G.BINDING_NAME_OPTIONSARCHY = L["BINDING_NAME_OPTIONS"]
_G.BINDING_NAME_TOGGLEARCHY = L["BINDING_NAME_TOGGLE"]
_G.BINDING_NAME_SOLVEARCHY = L["BINDING_NAME_SOLVE"]
_G.BINDING_NAME_SOLVE_WITH_KEYSTONESARCHY = L["BINDING_NAME_SOLVESTONE"]
_G.BINDING_NAME_ARTIFACTSARCHY = L["BINDING_NAME_ARTIFACTS"]
_G.BINDING_NAME_DIGSITESARCHY = L["BINDING_NAME_DIGSITES"]

-----------------------------------------------------------------------
-- Variables
-----------------------------------------------------------------------
local artifactSolved = {
	raceId = 0,
	name = ""
}

local continent_digsites = {}
private.continent_digsites = continent_digsites

local distanceIndicatorActive = false
local keystoneIDToRaceID = {}
local keystoneLootRaceID -- this is to force a refresh after the BAG_UPDATE event
local digsitesTrackingID -- set in HasArchaeology()
local lastSite = {}
local nearestSite
local player_position = {
	map = 0,
	level = 0,
	x = 0,
	y = 0
}

local survey_location = {
	map = 0,
	level = 0,
	x = 0,
	y = 0
}

local has_announced, has_pinged = {}, {}

local tomtomPoint, tomtomActive, tomtomFrame, tomtomSite

local prevTheme

-----------------------------------------------------------------------
-- Function upvalues
-----------------------------------------------------------------------
local Blizzard_SolveArtifact
local ClearTomTomPoint, UpdateTomTomPoint, RefreshTomTom
local UpdateMinimapPOIs
local UpdateAllSites

-----------------------------------------------------------------------
-- Metatables.
-----------------------------------------------------------------------
local race_data, race_data_uncached = {}, {}

setmetatable(race_data, {
	__index = function(t, k)
		if _G.GetNumArchaeologyRaces() == 0 then
			return
		end
		local raceName, raceTexture, itemID, currencyAmount = _G.GetArchaeologyRaceInfo(k)
		local itemName, _, _, _, _, _, _, _, _, itemTexture, _ = _G.GetItemInfo(itemID)

		t[k] = {
			name = raceName,
			currency = currencyAmount,
			texture = raceTexture,
			keystone = {
				id = itemID,
				name = itemName,
				texture = itemTexture,
				inventory = 0
			}
		}
		if itemID and itemID > 0 and (not itemName or itemName == "") then
			race_data_uncached[k] = itemID
			Archy:RegisterEvent("GET_ITEM_INFO_RECEIVED") -- Drii: ticket 391, fill in missing data when the keystone gets cached
		end
		return t[k]
	end
})
private.race_data = race_data

local artifact_data = {}
setmetatable(artifact_data, {
	__index = function(t, k)
		if k then
			t[k] = {
				name = "",
				tooltip = "",
				icon = "",
				sockets = 0,
				keystones_added = 0,
				fragments = 0,
				keystone_adjustment = 0,
				fragments_required = 0,
			}
			return t[k]
		end
	end
})
private.artifact_data = artifact_data

local function POI_OnEnter(self)
	if not self.tooltip then
		return
	end
	_G.GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
	_G.GameTooltip:SetText(self.tooltip, _G.NORMAL_FONT_COLOR[1], _G.NORMAL_FONT_COLOR[2], _G.NORMAL_FONT_COLOR[3], 1) --, true)
end

local function POI_OnLeave(self)
	_G.GameTooltip:Hide()
end

local ARROW_UPDATE_THRESHOLD = 0.1

local function Arrow_OnUpdate(self, elapsed)
	self.t = self.t + elapsed

	if self.t < ARROW_UPDATE_THRESHOLD then
		return
	end
	local square_half = math.sqrt(0.5)
	local rad_135 = math.rad(135)
	self.t = 0

	if _G.IsInInstance() then
		self:Hide()
		return
	end

	if not self.active then
		return
	end

	local edge = Astrolabe:IsIconOnEdge(self)

	if self.type == "site" then
		if edge then
			if self.icon:IsShown() then self.icon:Hide()
			end
			if not self.arrow:IsShown() then self.arrow:Show()
			end

			-- Rotate the icon, as required
			local angle = Astrolabe:GetDirectionToIcon(self)
			angle = angle + rad_135

			if _G.GetCVar("rotateMinimap") == "1" then
				local cring = _G.GetPlayerFacing()
				angle = angle - cring
			end

			local sin, cos = math.sin(angle) * square_half, math.cos(angle) * square_half
			self.arrow:SetTexCoord(0.5 - sin, 0.5 + cos, 0.5 + cos, 0.5 + sin, 0.5 - cos, 0.5 - sin, 0.5 + sin, 0.5 - cos)
		else
			if not self.icon:IsShown() then self.icon:Show()
			end
			if self.arrow:IsShown() then self.arrow:Hide()
			end
		end
	elseif edge then
		if self.icon:IsShown() then self.icon:Hide()
		end
	else
		if not self.icon:IsShown() then self.icon:Show()
		end
	end
end

local pois = setmetatable({}, {
	__index = function(t, k)
		local poi = _G.CreateFrame("Frame", "ArchyMinimap_POI" .. k, _G.Minimap)
		poi:SetWidth(10)
		poi:SetHeight(10)
		poi:SetScript("OnEnter", POI_OnEnter)
		poi:SetScript("OnLeave", POI_OnLeave)

		local arrow = _G.CreateFrame("Frame", nil, poi)
		arrow:SetPoint("CENTER", poi)
		arrow:SetScript("OnUpdate", Arrow_OnUpdate)
		arrow:SetWidth(32)
		arrow:SetHeight(32)

		local arrowtexture = arrow:CreateTexture(nil, "OVERLAY")
		arrowtexture:SetTexture([[Interface\Minimap\ROTATING-MINIMAPGUIDEARROW]]) -- [[Interface\Archeology\Arch-Icon-Marker]])
		arrowtexture:SetAllPoints(arrow)
		arrow.texture = arrowtexture
		arrow.t = 0
		arrow.poi = poi
		arrow:Hide()
		poi.useArrow = false
		poi.arrow = arrow
		poi:Hide()
		return poi
	end
})

-----------------------------------------------------------------------
-- Local helper functions
-----------------------------------------------------------------------
local function IsFishingPoleEquipped()
	-- 1 = "Weapon" class which contains the "Fishing Poles" subclasscheck with GetAuctionItemClasses() for index of "Weapons" if this stops working
	-- We were using the much simpler IsUsableSpell(FISHING_SPELL_NAME) until WoW 5.0.4 but this function changed behavior and reports true for fishing even without pole
	local pole_type_name = (select(select("#", _G.GetAuctionItemSubClasses(1)), _G.GetAuctionItemSubClasses(1))) -- "Fishing Poles" is the last return

	if pole_type_name then
		return _G.IsEquippedItemType(pole_type_name)
	end
end

local SuspendClickToMove
do
	local click_to_move

	function SuspendClickToMove()
		-- we're not using easy cast, no need to mess with click to move
		if not private.db.general.easyCast or IsFishingPoleEquipped() then
			return
		end

		if private.db.general.show then -- Archy enabled
			if _G.GetCVarBool("autointeract") then -- and click to move 'on'
				_G.SetCVar("autointeract", "0") -- suspend it
				click_to_move = "1" -- and store previous state
			end
		else -- archy disabled
			if click_to_move and click_to_move == "1" then -- did we suspend click to move previously?
				_G.SetCVar("autointeract", "1") -- restore it
				click_to_move = nil
			end
		end
	end
end -- do-block

local function AnnounceNearestSite()
	if not nearestSite or not nearestSite.distance or nearestSite.distance == 999999 then
		return
	end
	local site_name = ("%s%s|r"):format(_G.GREEN_FONT_COLOR_CODE, nearestSite.name)
	local site_zone = ("%s%s|r"):format(_G.GREEN_FONT_COLOR_CODE, nearestSite.zoneName)

	Archy:Pour(L["Nearest Dig Site is: %s in %s (%.1f yards away)"]:format(site_name, site_zone, nearestSite.distance), 1, 1, 1)
end

-- returns the rank and max rank for the players archaeology skill
local function GetArchaeologyRank()
	local _, _, archaeology_index = _G.GetProfessions()

	if not archaeology_index then
		return
	end
	local _, _, rank, maxRank = _G.GetProfessionInfo(archaeology_index)
	return rank, maxRank
end

private.GetArchaeologyRank = GetArchaeologyRank

local function GetArtifactStats(race_id, name)
	local num_artifacts = _G.GetNumArtifactsByRace(race_id)

	if not num_artifacts then
		return
	end

	for artifact_index = 1, num_artifacts do
		local artifact_name, _, _, _, _, _, _, firstCompletionTime, completionCount = _G.GetArtifactInfoByRace(race_id, artifact_index)
		if name == artifact_name then
			return artifact_index, firstCompletionTime, completionCount
		end
	end
end

private.GetArtifactStats = GetArtifactStats

local function GetCrateUseString(spellID)
	local spell_text
	local line_num = 1

	private.scantip:ClearLines()
	private.scantip:SetSpellByID(spellID)

	while (_G["ArchyScanTipTextLeft" .. line_num]:GetText()) do
		-- overwrite until we get the contents of bottom fontstring on the left
		spell_text = (_G["ArchyScanTipTextLeft" .. line_num]:GetText())
		line_num = line_num + 1
	end

	if spell_text then
		return _G.ITEM_SPELL_TRIGGER_ONUSE .. " " .. spell_text
	end
end

-- Returns true if the player has the archaeology secondary skill
local function HasArchaeology()
	local _, _, arch = _G.GetProfessions()
	if arch then
		private.scantip = private.scantip or _G.CreateFrame("GameTooltip", "ArchyScanTip", nil, "GameTooltipTemplate")
		private.scantip:SetOwner(_G.UIParent, "ANCHOR_NONE")
		CRATE_USE_STRING = CRATE_USE_STRING or GetCrateUseString(CRATE_SPELL_ID)

		for i = 1, _G.GetNumTrackingTypes() do
			if (_G.GetTrackingInfo(i)) == _G.MINIMAP_TRACKING_DIGSITES then
				digsitesTrackingID = i
				break
			end
		end
	end
	return arch
end

private.HasArchaeology = HasArchaeology

local function IsTaintable()
	return (private.in_combat or _G.InCombatLockdown() or (_G.UnitAffectingCombat("player") or _G.UnitAffectingCombat("pet")))
end

private.IsTaintable = IsTaintable

function private:ResetPositions()
	self.db.digsite.distanceIndicator.position = { unpack(PROFILE_DEFAULTS.profile.digsite.distanceIndicator.position) }
	self.db.digsite.distanceIndicator.anchor = PROFILE_DEFAULTS.profile.digsite.distanceIndicator.anchor
	self.db.digsite.distanceIndicator.undocked = PROFILE_DEFAULTS.profile.digsite.distanceIndicator.undocked
	self.db.digsite.position = { unpack(PROFILE_DEFAULTS.profile.digsite.position) }
	self.db.digsite.anchor = PROFILE_DEFAULTS.profile.digsite.anchor
	self.db.artifact.position = { unpack(PROFILE_DEFAULTS.profile.artifact.position) }
	self.db.artifact.anchor = PROFILE_DEFAULTS.profile.artifact.anchor
	Archy:ConfigUpdated()
	Archy:UpdateFramePositions()
end

local function ShouldBeHidden()
	return (not private.db.general.show or not private.current_continent or _G.UnitIsGhost("player") or _G.IsInInstance() or _G.C_PetBattles.IsInBattle() or not HasArchaeology())
end

local function UpdateRaceArtifact(race_id)
	local race = race_data[race_id]

	if not race then
		-- @??? Maybe use a wipe statement here
		artifact_data[race_id] = nil
		return
	end
	race_data[race_id].keystone.inventory = _G.GetItemCount(race_data[race_id].keystone.id) or 0

	if _G.GetNumArtifactsByRace(race_id) == 0 then
		return
	end

	if _G.ArchaeologyFrame and _G.ArchaeologyFrame:IsVisible() then
		_G.ArchaeologyFrame_ShowArtifact(race_id)
	end
	_G.SetSelectedArtifact(race_id)

	local name, _, rarity, icon, spellDescription, numSockets = _G.GetSelectedArtifactInfo()
	local base, adjust, total = _G.GetArtifactProgress()
	local artifact = artifact_data[race_id]

	artifact.canSolve = _G.CanSolveArtifact()
	artifact.fragments = base
	artifact.fragments_required = total
	artifact.sockets = numSockets
	artifact.icon = icon
	artifact.tooltip = spellDescription
	artifact.rare = (rarity ~= 0)
	artifact.name = name
	artifact.canSolveStone = nil -- Drii: stores whether we can actually solve with current user selection
	artifact.canSolveInventory = nil -- Drii: stores whether we would be able to solve if using all inventory stones
	artifact.keystone_adjustment = 0
	artifact.completionCount = 0

	local prevAdded = math.min(artifact.keystones_added, race_data[race_id].keystone.inventory, numSockets)

	if private.db.artifact.autofill[race_id] then
		prevAdded = math.min(race_data[race_id].keystone.inventory, numSockets)
	end
	artifact.keystones_added = math.min(race_data[race_id].keystone.inventory, numSockets) -- Drii: sets it to keystones in inventory
	-- Drii: this whole section looks like a needlessly convoluted way of doing things but hey 'if it's not broken don't fix it'
	-- cosmetic changes only; don't fancy wading through 10 tail calls if I break something :P
	if artifact.keystones_added > 0 and numSockets > 0 then
		for i = 1, math.min(artifact.keystones_added, numSockets) do -- Drii: adds any available keystones regardless of autofill settings
			_G.SocketItemToArtifact()
			if not _G.ItemAddedToArtifact(i) then
				break
			end
			if i == prevAdded then
				_, adjust = _G.GetArtifactProgress()
				artifact.keystone_adjustment = adjust -- Drii: set adjustment to actual user selection and move along
				artifact.canSolveStone = _G.CanSolveArtifact()
			end
		end
		artifact.canSolveInventory = _G.CanSolveArtifact()

		if prevAdded > 0 and artifact.keystone_adjustment <= 0 then -- Drii: keep our user value if there's one
			_, adjust = _G.GetArtifactProgress() -- Drii: or get the current fill if not
			artifact.keystone_adjustment = adjust
			artifact.canSolveStone = _G.CanSolveArtifact()
		end
	end
	artifact.keystones_added = prevAdded -- Drii: and here it sets it back to what the user chose by clicking Archy socket and relies on the overridden SolveArtifact to remove the extra keystones back out when solving.

	_G.RequestArtifactCompletionHistory()

	if not private.db.general.show or private.db.artifact.blacklist[race_id] then
		return
	end

	if not has_announced[artifact.name] and ((private.db.artifact.announce and artifact.canSolve) or (private.db.artifact.keystoneAnnounce and artifact.canSolveInventory)) then
		has_announced[artifact.name] = true
		Archy:Pour(L["You can solve %s Artifact - %s (Fragments: %d of %d)"]:format("|cFFFFFF00" .. race_data[race_id].name .. "|r", "|cFFFFFF00" .. artifact.name .. "|r", artifact.fragments + artifact.keystone_adjustment, artifact.fragments_required), 1, 1, 1)
	end

	if not has_pinged[artifact.name] and ((private.db.artifact.ping and artifact.canSolve) or (private.db.artifact.keystonePing and artifact.canSolveInventory)) then
		has_pinged[artifact.name] = true
		_G.PlaySoundFile([[Interface\AddOns\Archy\Media\dingding.mp3]])
	end
end

local function SolveRaceArtifact(race_id, use_stones)
	-- The check for race_id exists because its absence means we're calling this function from the default UI and should NOT perform any of the actions within the block.
	if race_id then
		local artifact = artifact_data[race_id]

		_G.SetSelectedArtifact(race_id)
		artifactSolved.raceId = race_id
		artifactSolved.name = _G.GetSelectedArtifactInfo()
		artifact.name = artifactSolved.name
		keystoneLootRaceID = race_id

		if _G.type(use_stones) == "boolean" then
			if use_stones then
				artifact.keystones_added = math.min(race_data[race_id].keystone.inventory, artifact.sockets)
			else
				artifact.keystones_added = 0
			end
		end

		if artifact.keystones_added > 0 then
			for index = 1, artifact.keystones_added do
				_G.SocketItemToArtifact()

				if not _G.ItemAddedToArtifact(index) then
					break
				end
			end
		elseif artifact.sockets > 0 then
			for index = 1, artifact.sockets do
				_G.RemoveItemFromArtifact()
			end
		end
	end
	Blizzard_SolveArtifact()
end

local function ToggleDistanceIndicator()
	if IsTaintable() then
		private.regen_toggle_distance = true
		return
	end

	if not private.db.digsite.distanceIndicator.enabled or ShouldBeHidden() then
		private.distance_indicator_frame:Hide()
		return
	end
	private.distance_indicator_frame:Show()

	if distanceIndicatorActive then
		private.distance_indicator_frame.circle:SetAlpha(1)
	else
		private.distance_indicator_frame.circle.distance:SetText("0")
		if private.db.digsite.distanceIndicator.undocked and not private.db.general.locked and (private.db.digsite.distanceIndicator.showSurveyButton or private.db.digsite.distanceIndicator.showCrateButton or private.db.digsite.distanceIndicator.showLorItemButton) then
			private.distance_indicator_frame.circle:SetAlpha(0.25) -- Drii: allow the distance indicator to show at reduced alpha for dragging when undocked
		else
			private.distance_indicator_frame.circle:SetAlpha(0)
		end
	end

	if private.db.digsite.distanceIndicator.showSurveyButton then
		private.distance_indicator_frame.surveyButton:Show()
		private.distance_indicator_frame:SetWidth(52 + private.distance_indicator_frame.surveyButton:GetWidth())
	else
		private.distance_indicator_frame.surveyButton:Hide()
		private.distance_indicator_frame:SetWidth(42)
	end

	if private.db.digsite.distanceIndicator.showCrateButton then
		private.distance_indicator_frame.crateButton:Show()
		local w = private.distance_indicator_frame:GetWidth()
		private.distance_indicator_frame:SetWidth(w + 10 + private.distance_indicator_frame.crateButton:GetWidth())
	else
		private.distance_indicator_frame.crateButton:Hide()
	end

	if private.db.digsite.distanceIndicator.showLorItemButton then
		private.distance_indicator_frame.loritemButton:Show()
		local w = private.distance_indicator_frame:GetWidth()
		private.distance_indicator_frame:SetWidth(w + 10 + private.distance_indicator_frame.loritemButton:GetWidth())
	else
		private.distance_indicator_frame.loritemButton:Hide()
	end
end

Dialog:Register("ArchyConfirmSolve", {
	text = "",
	on_show = function(self, data)
		self.text:SetFormattedText(L["Your Archaeology skill is at %d of %d.  Are you sure you would like to solve this artifact before visiting a trainer?"], data.rank, data.max_rank)
	end,
	buttons = {
		{
			text = _G.YES,
			on_click = function(self, data)
				if data.race_index then
					SolveRaceArtifact(data.race_index, data.use_stones)
				else
					Blizzard_SolveArtifact()
				end
			end,
		},
		{
			text = _G.NO,
		},
	},
	sound = "levelup2",
	show_while_dead = false,
	hide_on_escape = true,
})

-- Drii: temporary workaround for ticket 384
Dialog:Register("ArchyTomTomError", {
	text = "",
	on_show = function(self, data)
		self.text:SetFormattedText("%s%s|r\nIncompatible TomTom setting detected. \"%s%s|r\".\nDo you want to reset it?", "|cFFFFCC00", ADDON_NAME, "|cFFFFCC00", _G.TomTomLocals and _G.TomTomLocals["Enable automatic quest objective waypoints"] or "")
	end,
	buttons = {
		{
			text = _G.YES .. " (reloads UI)",
			on_click = function(self, data)
				_G.TomTom.profile.poi.setClosest = false
				_G.TomTom:EnableDisablePOIIntegration()
				_G.ReloadUI()
			end,
		},
		{
			text = _G.NO,
		},
		{
			text = _G.IGNORE,
			on_click = function(self, data)
				private.db.tomtom.noerrorwarn = Archy.version -- Drii: don't warn again for this version
			end,
		},
	},
	show_while_dead = true,
	hide_on_escape = true,
})

-----------------------------------------------------------------------
-- AddOn methods
-----------------------------------------------------------------------
function Archy:ShowArchaeology()
	if _G.IsAddOnLoaded("Blizzard_ArchaeologyUI") then
		if _G.ArchaeologyFrame:IsShown() then
			_G.HideUIPanel(_G.ArchaeologyFrame)
		else
			_G.ShowUIPanel(_G.ArchaeologyFrame)
		end
		return true
	end
	local loaded, reason = _G.LoadAddOn("Blizzard_ArchaeologyUI")

	if loaded then
		if _G.ArchaeologyFrame:IsShown() then
			_G.HideUIPanel(_G.ArchaeologyFrame)
		else
			_G.ShowUIPanel(_G.ArchaeologyFrame)
		end
		return true
	else
		Archy:Print(L["ArchaeologyUI not loaded: %s Try opening manually."]:format(_G["ADDON_" .. reason]))
		return false
	end
end

-- extract the itemid from the itemlink
local function GetIDFromLink(link)
	if not link then
		return
	end
	local found, _, str = link:find("^|c%x+|H(.+)|h%[.+%]")

	if not found then
		return
	end

	local _, id = (":"):split(str)
	return tonumber(id)
end

-- deformat substitute
local function MatchFormat(msg, pattern)
	return msg:match(pattern:gsub("(%%s)", "(.+)"):gsub("(%%d)", "(.+)"))
end


-- return the player, itemlink and quantity of the item in the chat_msg_loot
local function ParseLootMessage(msg)
	local player = _G.UnitName("player")
	local item, quantity = MatchFormat(msg, _G.LOOT_ITEM_SELF_MULTIPLE)

	if item and quantity then
		return player, item, tonumber(quantity)
	end
	quantity = 1
	item = MatchFormat(msg, _G.LOOT_ITEM_SELF)

	if item then
		return player, item, tonumber(quantity)
	end
	player, item, quantity = MatchFormat(msg, _G.LOOT_ITEM_MULTIPLE)

	if player and item and quantity then
		return player, item, tonumber(quantity)
	end
	quantity = 1
	player, item = MatchFormat(msg, _G.LOOT_ITEM)

	return player, item, tonumber(quantity)
end

local CONFIG_UPDATE_FUNCTIONS = {
	artifact = function(option)
		if option == "autofill" then
			for race_id = 1, _G.GetNumArchaeologyRaces() do
				UpdateRaceArtifact(race_id)
			end
		elseif option == "color" then
			Archy:RefreshRacesDisplay()
		else
			Archy:UpdateRacesFrame()
			Archy:RefreshRacesDisplay()
			Archy:SetFramePosition(private.races_frame)
		end
	end,
	digsite = function(option)
		if option == "tooltip" then
			UpdateAllSites()
		end
		Archy:UpdateSiteDistances()
		Archy:UpdateDigSiteFrame()

		if option == "font" then
			Archy:ResizeDigSiteDisplay()
		else
			Archy:RefreshDigSiteDisplay()
		end
		Archy:SetFramePosition(private.digsite_frame)
		Archy:SetFramePosition(private.distance_indicator_frame)
		ToggleDistanceIndicator()
	end,
	minimap = function(option)
		UpdateMinimapPOIs(true)
	end,
	tomtom = function(option)
		local db = private.db

		if db.tomtom.enabled and private.tomtomExists then
			if _G.TomTom.profile then
				_G.TomTom.profile.arrow.arrival = db.tomtom.distance
				_G.TomTom.profile.arrow.enablePing = db.tomtom.ping
			end
		end
		RefreshTomTom()
	end,
}

function Archy:ConfigUpdated(namespace, option)
	if namespace then
		CONFIG_UPDATE_FUNCTIONS[namespace](option)
	else
		self:UpdateRacesFrame()
		self:RefreshRacesDisplay()
		self:UpdateDigSiteFrame()
		self:RefreshDigSiteDisplay()
		self:UpdateTracking()
		ToggleDistanceIndicator()
		UpdateMinimapPOIs(true)
		RefreshTomTom()
		SuspendClickToMove()
	end
end


function Archy:SolveAnyArtifact(use_stones)
	local found = false
	for race_id, artifact in pairs(artifact_data) do
		if not private.db.artifact.blacklist[race_id] and (artifact.canSolve or (use_stones and artifact.canSolveInventory)) then
			SolveRaceArtifact(race_id, use_stones)
			found = true
			break
		end
	end

	if not found then
		self:Print(L["No artifacts were solvable"])
	end
end

function Archy:SocketClicked(keystone_button, mouse_button, down)
	local race_id = keystone_button:GetParent():GetParent():GetID()

	if mouse_button == "LeftButton" then
		if artifact_data[race_id].keystones_added < artifact_data[race_id].sockets and artifact_data[race_id].keystones_added < race_data[race_id].keystone.inventory then
			artifact_data[race_id].keystones_added = artifact_data[race_id].keystones_added + 1
		end
	else
		if artifact_data[race_id].keystones_added > 0 then
			artifact_data[race_id].keystones_added = artifact_data[race_id].keystones_added - 1
		end
	end
	UpdateRaceArtifact(race_id)
	Archy:RefreshRacesDisplay()
end

--[[ Dig Site List Functions ]] --
local function IncrementDigCounter(id)
	local site_stats = Archy.db.char.digsites.stats
	site_stats[id].counter = (site_stats[id].counter or 0) + 1
end

local function CompareAndResetDigCounters(a, b)
	if not a or not b or (#a == 0) or (#b == 0) then
		return
	end

	for _, siteA in pairs(a) do
		local exists = false
		for _, siteB in pairs(b) do
			if siteA.id == siteB.id then
				exists = true
				break
			end
		end

		if not exists then
			--			print(("CompareAndResetDigCounters: Resetting counter for %s"):format(siteA.id))
			Archy.db.char.digsites.stats[siteA.id].counter = 0
		end
	end
end

local DIG_LOCATION_TEXTURE = 177
local function GetContinentSites(continent_id)
	local new_sites = {}
	-- Drii: and this solves the mystery of "location of the digsite is gone missing" ticket 351;
	-- function fails to populate continent_digsites if showing digsites on the worldmap has been toggled off by the user.
	-- So make sure we enable and show blobs and restore the setting at the end.
	local showDig = _G.GetCVarBool("digSites")

	if not showDig then
		_G.SetCVar("digSites", "1")
		_G.WorldMapArchaeologyDigSites:Show()
		_G.RefreshWorldMap()
		showDig = "0"
	end

	for index = 1, _G.GetNumMapLandmarks() do
		local name, description, texture_index, px, py = _G.GetMapLandmarkInfo(index)

		if texture_index == DIG_LOCATION_TEXTURE then
			local zone_name, map_file, texPctX, texPctY, texX, texY, scrollX, scrollY = _G.UpdateMapHighlight(px, py)
			local site = DIG_SITES[name]
			local mc, fc, mz, fz, zoneID = 0, 0, 0, 0, 0
			mc, fc = Astrolabe:GetMapID(continent_id, 0)
			mz = site.map
			zoneID = MAP_ID_TO_ZONE_ID[mz]

			if site and site.race then -- Drii: fail silently for missing data while we complete MoP info
				local x, y = Astrolabe:TranslateWorldMapPosition(mc, fc, px, py, mz, fz)
				local raceName, raceCrestTexture = _G.GetArchaeologyRaceInfo(site.race)

				table.insert(new_sites, {
					continent = mc,
					zoneId = zoneID,
					zoneName = MAP_ID_TO_ZONE_NAME[mz] or _G.UNKNOWN,
					mapFile = map_file,
					map = mz,
					level = fz,
					x = x,
					y = y,
					name = name,
					raceId = site.race,
					id = site.blob_id,
					distance = 999999,
				})
			end
		end
	end

	if showDig == "0" then -- restore initial setting
		_G.SetCVar("digSites", showDig)
		_G.WorldMapArchaeologyDigSites:Hide()
		_G.RefreshWorldMap()
	end
	return new_sites
end

local function CacheMapData()
	if not next(MAP_CONTINENTS) then
		local continent_data = { _G.GetMapContinents() }

		for continent_data_index = 1, #continent_data do
			-- Odd indices are IDs, even are names.
			if continent_data_index % 2 == 0 then
				local continent_id = continent_data_index / 2
				local continent_name = continent_data[continent_data_index]

				_G.SetMapZoom(continent_id)

				local map_id = _G.GetCurrentMapAreaID()
				local map_file_name = _G.GetMapInfo()

				MAP_CONTINENTS[continent_id] = continent_name
				MAP_FILENAME_TO_MAP_ID[map_file_name] = map_id
				MAP_ID_TO_CONTINENT_ID[map_id] = continent_id
				MAP_ID_TO_ZONE_NAME[map_id] = continent_name

				ZONE_DATA[map_id] = {
					continent = continent_id,
					id = 0,
					level = 0,
					map = map_id,
					mapFile = map_file_name,
					name = continent_name
				}

				local zone_data = { _G.GetMapZones(continent_id) }
				for zone_data_index = 1, #zone_data do
					-- Odd indices are IDs, even are names.
					if zone_data_index % 2 == 0 then
						_G.SetMapByID(map_id)

						local map_file_name = _G.GetMapInfo()
						local zone_id = _G.GetCurrentMapZone()
						local zone_name = zone_data[zone_data_index]

						MAP_FILENAME_TO_MAP_ID[map_file_name] = map_id
						MAP_ID_TO_ZONE_ID[map_id] = zone_id
						MAP_ID_TO_ZONE_NAME[map_id] = zone_name
						ZONE_ID_TO_NAME[zone_id] = zone_name
						ZONE_DATA[map_id] = {
							continent = continent_id,
							id = zone_id,
							level = _G.GetCurrentMapDungeonLevel(),
							map = map_id,
							mapFile = map_file_name,
							name = zone_name
						}
					else
						map_id = zone_data[zone_data_index]
					end
				end
			end
		end
	end

	if next(ZONE_DATA) then
		CacheMapData = nil
	end
end

local function UpdateSite(continent_id)
	_G.SetMapZoom(continent_id)

	local sites = GetContinentSites(continent_id)

	if #sites > 0 then
		if continent_digsites[continent_id] then
			CompareAndResetDigCounters(continent_digsites[continent_id], sites)
			CompareAndResetDigCounters(sites, continent_digsites[continent_id])
		end
		continent_digsites[continent_id] = sites
	end
end

UpdateAllSites = function()
-- Set this for restoration at the end of the loop since it's changed when UpdateSite() is called.
	local original_map_id = _G.GetCurrentMapAreaID()

	-- Drii: runs only until ZONE_DATA is populated
	if CacheMapData then
		CacheMapData()
	end

	if next(MAP_CONTINENTS) then
		for continent_id, continent_name in pairs(MAP_CONTINENTS) do
			UpdateSite(continent_id)
		end
	end
	_G.SetMapByID(original_map_id)
end

function Archy:IsSiteBlacklisted(name)
	return self.db.char.digsites.blacklist[name]
end

function Archy:ToggleSiteBlacklist(name)
	self.db.char.digsites.blacklist[name] = not self.db.char.digsites.blacklist[name]
end

local function SortSitesByDistance(a, b)
	if Archy:IsSiteBlacklisted(a.name) and not Archy:IsSiteBlacklisted(b.name) then
		return 1 < 0
	elseif not Archy:IsSiteBlacklisted(a.name) and Archy:IsSiteBlacklisted(b.name) then
		return 0 < 1
	end

	if (a.distance == -1 and b.distance == -1) or (not a.distance and not b.distance) then
		return a.zoneName .. ":" .. a.name < b.zoneName .. ":" .. b.name
	else
		return (a.distance or 0) < (b.distance or 0)
	end
end

local function SortSitesByName(a, b)
	return a.zoneName .. ":" .. a.name < b.zoneName .. ":" .. b.name
end

function Archy:UpdateSiteDistances()
	if not continent_digsites[private.current_continent] or (#continent_digsites[private.current_continent] == 0) then
		nearestSite = nil
		return
	end
	local distance, nearest

	for index = 1, #continent_digsites[private.current_continent] do
		local site = continent_digsites[private.current_continent][index]

		if site.poi then
			site.distance = Astrolabe:GetDistanceToIcon(site.poi)
		else
			site.distance = Astrolabe:ComputeDistance(player_position.map, player_position.level, player_position.x, player_position.y, site.map, site.level, site.x, site.y)
		end

		if site.x then
		if not Archy:IsSiteBlacklisted(site.name) then
			if not distance or site.distance < distance then
				distance = site.distance
				nearest = site
			end
		end
		end
	end

	if nearest and (not nearestSite or nearestSite.id ~= nearest.id) then
		-- nearest dig site has changed
		nearestSite = nearest
		tomtomActive = true
		RefreshTomTom()
		UpdateMinimapPOIs()

		if private.db.digsite.announceNearest and private.db.general.show then
			AnnounceNearestSite()
		end
	end

	-- Sort sites
	local sites = continent_digsites[private.current_continent]

	if private.db.digsite.sortByDistance then
		table.sort(sites, SortSitesByDistance)
	else -- sort by zone then name
		table.sort(sites, SortSitesByName)
	end
end

function Archy:ImportOldStatsDB()
	local site_stats = self.db.char.digsites.stats

	for key, st in pairs(self.db.char.digsites) do
		if type(key) == "string" and key ~= "blacklist" and key ~= "stats" and key ~= "counter" and key ~= "" then
			if DIG_SITES[key] then -- Drii: DIG_SITES has a custom metatable so this would add ANY key passed and set it to the EMPTY_DIGSITE table; was this corrupting the SV? ticket 380
				local site = DIG_SITES[key]
				if type(site.blob_id) == "number" and site.blob_id > 0 then -- Drii: make sure we're not puting whatever trash was passed into the stats SV.
					site_stats[site.blob_id].surveys = (site_stats[site.blob_id].surveys or 0) + (st.surveys or 0)
					site_stats[site.blob_id].fragments = (site_stats[site.blob_id].fragments or 0) + (st.fragments or 0)
					site_stats[site.blob_id].looted = (site_stats[site.blob_id].looted or 0) + (st.looted or 0)
					site_stats[site.blob_id].keystones = (site_stats[site.blob_id].keystones or 0) + (st.keystones or 0)
					self.db.char.digsites[key] = nil
				end
			end
		end
	end

	-- Drii: let's also try to fix whatever crap was put in the SV by the old version of this function so users don't have to delete their variables.
	if next(site_stats) then
		for blobid, _ in pairs(site_stats) do
			if type(blobid) == "number" and blobid > 0 then
			else
				site_stats[blobid] = nil
			end
		end
	end
end

--[[ Survey Functions ]] --
local function AddSurveyNode(siteId, map, level, x, y)
	local newNode = {
		m = map,
		f = level,
		x = x,
		y = y
	}
	local exists = false

	if not Archy.db.global.surveyNodes then
		Archy.db.global.surveyNodes = {}
	end

	if not Archy.db.global.surveyNodes[siteId] then
		Archy.db.global.surveyNodes[siteId] = {}
	end

	for _, node in pairs(Archy.db.global.surveyNodes[siteId]) do
		local distance = Astrolabe:ComputeDistance(newNode.m, newNode.f, newNode.x, newNode.y, node.m, node.f, node.x, node.y)

		if not distance or _G.IsInInstance() then
			distance = 0
		end

		if distance <= 10 then
			exists = true
			break
		end
	end
	if not exists then
		table.insert(Archy.db.global.surveyNodes[siteId], newNode)
	end
end

local DISTANCE_COLOR_TEXCOORDS = {
	green = {
		0, 0.24609375, 0, 1
	},
	yellow = {
		0.24609375, 0.5, 0, 1
	},
	red = {
		0.5, 0.75, 0, 1
	},
}
local function SetDistanceIndicatorColor(color)
	private.distance_indicator_frame.circle.texture:SetTexCoord(unpack(DISTANCE_COLOR_TEXCOORDS[color]))
	private.distance_indicator_frame.circle:SetAlpha(1)
	ToggleDistanceIndicator()
end

local function UpdateDistanceIndicator()
	if survey_location.x == 0 and survey_location.y == 0 or _G.IsInInstance() then
		return
	end
	local distance = Astrolabe:ComputeDistance(player_position.map, player_position.level, player_position.x, player_position.y, survey_location.map, survey_location.level, survey_location.x, survey_location.y)

	if not distance then
		distance = 0
	end
	local greenMin, greenMax = 0, private.db.digsite.distanceIndicator.green
	local yellowMin, yellowMax = greenMax, private.db.digsite.distanceIndicator.yellow
	local redMin, redMax = yellowMax, 500

	if distance >= greenMin and distance <= greenMax then
		SetDistanceIndicatorColor("green")
	elseif distance >= yellowMin and distance <= yellowMax then
		SetDistanceIndicatorColor("yellow")
	elseif distance >= redMin and distance <= redMax then
		SetDistanceIndicatorColor("red")
	else
		ToggleDistanceIndicator()
		return
	end
	private.distance_indicator_frame.circle.distance:SetFormattedText("%1.f", distance)
end


--[[ Minimap Functions ]] --
local sitePool = {}
local surveyPool = {}
local allPois = {}
local sitePoiCount, surveyPoiCount = 0, 0

local function GetSitePOI(siteId, map, level, x, y, tooltip)
	local poi = table.remove(sitePool)

	if not poi then
		sitePoiCount = sitePoiCount + 1
		poi = _G.CreateFrame("Frame", "ArchyMinimap_SitePOI" .. sitePoiCount, _G.Minimap)
		poi.index = sitePoiCount
		poi:SetWidth(10)
		poi:SetHeight(10)

		table.insert(allPois, poi)

		poi.icon = poi:CreateTexture("BACKGROUND")
		poi.icon:SetTexture([[Interface\Archeology\Arch-Icon-Marker.blp]])
		poi.icon:SetPoint("CENTER", 0, 0)
		poi.icon:SetHeight(14)
		poi.icon:SetWidth(14)
		poi.icon:Hide()

		poi.arrow = poi:CreateTexture("BACKGROUND")
		poi.arrow:SetTexture([[Interface\Minimap\ROTATING-MINIMAPGUIDEARROW.tga]])
		poi.arrow:SetPoint("CENTER", 0, 0)
		poi.arrow:SetWidth(32)
		poi.arrow:SetHeight(32)
		poi.arrow:Hide()
		poi:Hide()
	end
	poi:SetScript("OnEnter", POI_OnEnter)
	poi:SetScript("OnLeave", POI_OnLeave)
	poi:SetScript("OnUpdate", Arrow_OnUpdate)
	poi.type = "site"
	poi.tooltip = tooltip
	poi.location = {
		map = map,
		level = level,
		x = x,
		y = y,
	}
	poi.active = true
	poi.siteId = siteId
	poi.t = 0
	return poi
end

local function ClearSitePOI(poi)
	if not poi then
		return
	end
	Astrolabe:RemoveIconFromMinimap(poi)
	poi.icon:Hide()
	poi.arrow:Hide()
	poi:Hide()
	poi.active = false
	poi.tooltip = nil
	poi.location = nil
	poi.siteId = nil
	poi:SetScript("OnEnter", nil)
	poi:SetScript("OnLeave", nil)
	poi:SetScript("OnUpdate", nil)
	table.insert(sitePool, poi)
end

local function GetSurveyPOI(siteId, map, level, x, y, tooltip)
	local poi = table.remove(surveyPool)

	if not poi then
		surveyPoiCount = surveyPoiCount + 1
		poi = _G.CreateFrame("Frame", "ArchyMinimap_SurveyPOI" .. surveyPoiCount, _G.Minimap)
		poi.index = surveyPoiCount
		poi:SetWidth(8)
		poi:SetHeight(8)

		table.insert(allPois, poi)

		poi.icon = poi:CreateTexture("BACKGROUND")
		poi.icon:SetTexture([[Interface\AddOns\Archy\Media\Nodes]])

		if private.db.minimap.fragmentIcon == "Cross" then
			poi.icon:SetTexCoord(0, 0.46875, 0, 0.453125)
		else
			poi.icon:SetTexCoord(0, 0.234375, 0.5, 0.734375)
		end
		poi.icon:SetPoint("CENTER", 0, 0)
		poi.icon:SetHeight(8)
		poi.icon:SetWidth(8)
		poi.icon:Hide()

		poi:Hide()
	end
	poi:SetScript("OnEnter", POI_OnEnter)
	poi:SetScript("OnLeave", POI_OnLeave)
	poi:SetScript("OnUpdate", Arrow_OnUpdate)
	poi.type = "survey"
	poi.tooltip = tooltip
	poi.location = {
		map = map,
		level = level,
		x = x,
		y = y,
	}
	poi.active = true
	poi.siteId = siteId
	poi.t = 0
	return poi
end

local function ClearSurveyPOI(poi)
	if not poi then
		return
	end
	Astrolabe:RemoveIconFromMinimap(poi)
	poi.icon:Hide()
	poi:Hide()
	poi.active = nil
	poi.tooltip = nil
	poi.siteId = nil
	poi.location = nil
	poi:SetScript("OnEnter", nil)
	poi:SetScript("OnLeave", nil)
	poi:SetScript("OnUpdate", nil)
	table.insert(surveyPool, poi)
end

-- TODO: Figure out if this should be used somewhere - it currently is not, and should maybe be removed.
local function CreateMinimapPOI(index, type, loc, title, siteId)
	local poi = pois[index]
	local poiButton = _G.CreateFrame("Frame", nil, poi)
	poiButton.texture = poiButton:CreateTexture(nil, "OVERLAY")

	if type == "site" then
		poi.useArrow = true
		poiButton.texture:SetTexture([[Interface\Archeology\Arch-Icon-Marker.blp]])
		poiButton:SetWidth(14)
		poiButton:SetHeight(14)
	else
		poi.useArrow = false
		poiButton.texture:SetTexture([[Interface\AddOns\Archy\Media\Nodes]])
		if private.db.minimap.fragmentIcon == "Cross" then
			poiButton.texture:SetTexCoord(0, 0.46875, 0, 0.453125)
		else
			poiButton.texture:SetTexCoord(0, 0.234375, 0.5, 0.734375)
		end
		poiButton:SetWidth(8)
		poiButton:SetHeight(8)
	end
	poiButton.texture:SetAllPoints(poiButton)
	poiButton:SetPoint("CENTER", poi)
	poiButton:SetScale(1)
	poiButton:SetParent(poi)
	poiButton:EnableMouse(false)
	poi.poiButton = poiButton
	poi.index = index
	poi.type = type
	poi.title = title
	poi.location = loc
	poi.active = true
	poi.siteId = siteId
	pois[index] = poi
	return poi
end

-- TODO: Figure out if this should be used somewhere - it currently is not, and should maybe be removed.
local function UpdateMinimapEdges()
	for id, poi in pairs(allPois) do
		if poi.active then
			local edge = Astrolabe:IsIconOnEdge(poi)
			if poi.type == "site" then
				if edge then
					poi.icon:Hide()
					poi.arrow:Show()
				else
					poi.icon:Show()
					poi.arrow:Hide()
				end
			else
				if edge then
					poi.icon:Hide()
					poi:Hide()
				else
					poi.icon:Show()
					poi:Show()
				end
			end
		end
	end
end

local lastNearestSite

local function GetContinentSiteIDs()
	local validSiteIDs = {}

	if private.db.general.show and private.db.minimap.show then
		return validSiteIDs
	end

	if continent_digsites[private.current_continent] then
		for _, site in pairs(continent_digsites[private.current_continent]) do
			table.insert(validSiteIDs, site.id)
		end
	end
	return validSiteIDs
end

local function ClearAllPOIs()
	for idx, poi in ipairs(allPois) do
		if poi.type == "site" then
			ClearSitePOI(poi)
		elseif poi.type == "survey" then
			ClearSurveyPOI(poi)
		end
	end
end

local function ClearInvalidPOIs()
	local validSiteIDs = GetContinentSiteIDs()

	for idx, poi in ipairs(allPois) do
		if not validSiteIDs[poi.siteId] then
			if poi.type == "site" then
				ClearSitePOI(poi)
			else
				ClearSurveyPOI(poi)
			end
		elseif poi.type == "survey" and lastNearestSite.id ~= nearestSite.id and lastNearestSite.id == poi.siteId then
			ClearSurveyPOI(poi)
		end
	end
end

function UpdateMinimapPOIs(force)
	if _G.WorldMapButton:IsVisible() then
		return
	end

	if lastNearestSite == nearestSite and not force then
		return
	end
	lastNearestSite = nearestSite

	local sites = continent_digsites[private.current_continent]

	if not sites or #sites == 0 or _G.IsInInstance() then
		ClearAllPOIs()
		return
	end
	ClearInvalidPOIs()

	if not player_position.x and not player_position.y then
		return
	end
	local i = 1

	for _, site in pairs(sites) do
		site.poi = GetSitePOI(site.id, site.map, site.level, site.x, site.y, ("%s\n(%s)"):format(site.name, site.zoneName))
		site.poi.active = true

		if site.map > 0 then
			Astrolabe:PlaceIconOnMinimap(site.poi, site.map, site.level, site.x, site.y)
		end

		if (not private.db.minimap.nearest or (nearestSite and nearestSite.id == site.id)) and private.db.general.show and private.db.minimap.show then
			site.poi:Show()
			site.poi.icon:Show()
		else
			site.poi:Hide()
			site.poi.icon:Hide()
		end

		if nearestSite and nearestSite.id == site.id then
			if not site.surveyPOIs then
				site.surveyPOIs = {}
			end

			if Archy.db.global.surveyNodes[site.id] and private.db.minimap.fragmentNodes then
				for index, node in pairs(Archy.db.global.surveyNodes[site.id]) do
					site.surveyPOIs[index] = GetSurveyPOI(site.id, node.m, node.f, node.x, node.y, ("%s #%d\n%s\n(%s)"):format(L["Survey"], index, site.name, site.zoneName))

					local POI = site.surveyPOIs[index]
					POI.active = true

					Astrolabe:PlaceIconOnMinimap(POI, node.m, node.f, node.x, node.y)

					if private.db.general.show then
						POI:Show()
						POI.icon:Show()
					else
						POI:Hide()
						POI.icon:Hide()
					end
					Arrow_OnUpdate(POI, 5)
				end
			end
		end

		Arrow_OnUpdate(site.poi, 5)
	end
	--UpdateMinimapEdges()
	if private.db.minimap.fragmentColorBySurveyDistance and private.db.minimap.fragmentIcon ~= "CyanDot" then
		for id, poi in pairs(allPois) do
			if poi.active and poi.type == "survey" then
				poi.icon:SetTexCoord(0, 0.234375, 0.5, 0.734375)
			end
		end
	end
end

--[[ TomTom Functions ]] --
-- clear the waypoint we gave tomtom
function ClearTomTomPoint()
	if not tomtomPoint then
		return
	end
	tomtomPoint = _G.TomTom:RemoveWaypoint(tomtomPoint)
end

function UpdateTomTomPoint()
	if not tomtomSite and not nearestSite then
		-- we have no information to pass tomtom
		ClearTomTomPoint()
		return
	end

	if nearestSite then
		tomtomSite = nearestSite
	else
		nearestSite = tomtomSite
	end

	if not tomtomFrame then
		tomtomFrame = _G.CreateFrame("Frame")
	end

	if not tomtomFrame:IsShown() then
		tomtomFrame:Show()
	end
	local waypointExists

	if _G.TomTom.WaypointExists then -- do we have the legit TomTom?
		waypointExists = _G.TomTom:WaypointExists(MAP_ID_TO_CONTINENT_ID[tomtomSite.continent], tomtomSite.zoneId, tomtomSite.x * 100, tomtomSite.y * 100, tomtomSite.name .. "\n" .. tomtomSite.zoneName)
	end

	if not waypointExists then -- waypoint doesn't exist or we have a TomTom emulator
		ClearTomTomPoint()
		tomtomPoint = _G.TomTom:AddMFWaypoint(tomtomSite.map, nil, tomtomSite.x, tomtomSite.y, { title = tomtomSite.name .. "\n" .. tomtomSite.zoneName })
--		tomtomPoint = _G.TomTom:AddZWaypoint(MAP_ID_TO_CONTINENT_ID[tomtomSite.continent], tomtomSite.zoneId, tomtomSite.x * 100, tomtomSite.y * 100, tomtomSite.name .. "\n" .. tomtomSite.zoneName, false, false, false, false, false, true)
	end
end

function RefreshTomTom()
	if private.db.general.show and private.db.tomtom.enabled and private.tomtomExists and tomtomActive then
		UpdateTomTomPoint()
	else
		if private.db.tomtom.enabled and not private.tomtomExists then
			-- TomTom (or emulator) was disabled, disabling TomTom support
			private.db.tomtom.enabled = false
			Archy:Print("TomTom doesn't exist... disabling it")
		end

		if tomtomPoint then
			ClearTomTomPoint()
			tomtomPoint = nil
		end

		if tomtomFrame then
			if tomtomFrame:IsShown() then
				tomtomFrame:Hide()
			end
			tomtomFrame = nil
		end
	end
end

--[[ Slash command handler ]] --
local function SlashHandler(msg, editbox)
	local command = msg:lower()

	if command == L["config"]:lower() then
		_G.InterfaceOptionsFrame_OpenToCategory(Archy.optionsFrame)
	elseif command == L["stealth"]:lower() then
		private.db.general.stealthMode = not private.db.general.stealthMode
		Archy:ConfigUpdated()
	elseif command == L["dig sites"]:lower() then
		private.db.digsite.show = not private.db.digsite.show
		Archy:ConfigUpdated('digsite')
	elseif command == L["artifacts"]:lower() then
		private.db.artifact.show = not private.db.artifact.show
		Archy:ConfigUpdated('artifact')
	elseif command == _G.SOLVE:lower() then
		Archy:SolveAnyArtifact()
	elseif command == L["solve stone"]:lower() then
		Archy:SolveAnyArtifact(true)
	elseif command == L["nearest"]:lower() or command == L["closest"]:lower() then
		AnnounceNearestSite()
	elseif command == L["reset"]:lower() then
		private:ResetPositions()
	elseif command == ("TomTom"):lower() then
		private.db.tomtom.enabled = not private.db.tomtom.enabled
		RefreshTomTom()
	elseif command == _G.MINIMAP_LABEL:lower() then
		private.db.minimap.show = not private.db.minimap.show
		Archy:ConfigUpdated('minimap')
	elseif command == "test" then
		private.races_frame:SetBackdropBorderColor(1, 1, 1, 0.5)
	else
		Archy:Print(L["Available commands are:"])
		Archy:Print("|cFF00FF00" .. L["config"] .. "|r - " .. L["Shows the Options"])
		Archy:Print("|cFF00FF00" .. L["stealth"] .. "|r - " .. L["Toggles the display of the Artifacts and Dig Sites lists"])
		Archy:Print("|cFF00FF00" .. L["dig sites"] .. "|r - " .. L["Toggles the display of the Dig Sites list"])
		Archy:Print("|cFF00FF00" .. L["artifacts"] .. "|r - " .. L["Toggles the display of the Artifacts list"])
		Archy:Print("|cFF00FF00" .. _G.SOLVE .. "|r - " .. L["Solves the first artifact it finds that it can solve"])
		Archy:Print("|cFF00FF00" .. L["solve stone"] .. "|r - " .. L["Solves the first artifact it finds that it can solve (including key stones)"])
		Archy:Print("|cFF00FF00" .. L["nearest"] .. "|r or |cFF00FF00" .. L["closest"] .. "|r - " .. L["Announces the nearest dig site to you"])
		Archy:Print("|cFF00FF00" .. L["reset"] .. "|r - " .. L["Reset the window positions to defaults"])
		Archy:Print("|cFF00FF00" .. "TomTom" .. "|r - " .. L["Toggles TomTom Integration"])
		Archy:Print("|cFF00FF00" .. _G.MINIMAP_LABEL .. "|r - " .. L["Toggles the dig site icons on the minimap"])
	end
end

function Archy:OnInitialize() -- @ADDON_LOADED (1)
	self.db = LibStub("AceDB-3.0"):New("ArchyDB", PROFILE_DEFAULTS, 'Default')
	self.db.RegisterCallback(self, "OnNewProfile", "OnProfileUpdate")
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileUpdate")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileUpdate")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileUpdate")

	local about_panel = LibStub:GetLibrary("LibAboutPanel", true)

	if about_panel then
		self.optionsFrame = about_panel.new(nil, "Archy")
	end
	self:DefineSinkToast(ADDON_NAME, [[Interface\Archeology\Arch-Icon-Marker]])
	self:SetSinkStorage(Archy.db.profile.general.sinkOptions)
	self:SetupOptions()

	if not self.db.global.surveyNodes then
		self.db.global.surveyNodes = {}
	end

	if not self.db.char.digsites then
		self.db.char.digsites = {
			stats = {},
			blacklist = {}
		}
	end

	if not self.db.char.digsites.stats then self.db.char.digsites.stats = {} end -- Drii: ticket 362,363 old Archy SV that had self.db.char.digsites but no stats, blacklist tables?
	setmetatable(self.db.char.digsites.stats, {
		__index = function(t, k)
			if k then
				t[k] = {
					surveys = 0,
					fragments = 0,
					looted = 0,
					keystones = 0,
					counter = 0
				}
				return t[k]
			end
		end
	})

	if not self.db.char.digsites.blacklist then self.db.char.digsites.blacklist = {} end -- Drii: ticket 362,363
	setmetatable(self.db.char.digsites.blacklist, {
		__index = function(t, k)
			if k then
				t[k] = false
				return t[k]
			end
		end
	})
	private.db = self.db.profile
	prevTheme = private.db and private.db.general and private.db.general.theme or PROFILE_DEFAULTS.profile.general.theme

	if not private.db.data then
		private.db.data = {}
	end
	private.db.data.imported = false

	LDBI:Register("Archy", private.LDB_object, private.db.general.icon)

	if not SECURE_ACTION_BUTTON then
		local button_name = "Archy_SurveyButton"
		local button = _G.CreateFrame("Button", button_name, _G.UIParent, "SecureActionButtonTemplate")
		button:SetPoint("LEFT", _G.UIParent, "RIGHT", 10000, 0)
		button:Hide()
		button:SetFrameStrata("LOW")
		button:EnableMouse(true)
		button:RegisterForClicks("RightButtonUp")
		button.name = button_name
		button:SetAttribute("type", "spell")
		button:SetAttribute("spell", SURVEY_SPELL_ID)
		button:SetAttribute("action", nil)

		button:SetScript("PostClick", function(self, mouse_button, is_down)
			if private.override_binding_on and not IsTaintable() then
				_G.ClearOverrideBindings(self)
				private.override_binding_on = nil
			else
				private.regen_clear_override = true
			end
		end)

		SECURE_ACTION_BUTTON = button
	end

	do
		local clicked_time
		local ACTION_DOUBLE_WAIT = 0.4
		local MIN_ACTION_DOUBLECLICK = 0.05

		_G.WorldFrame:HookScript("OnMouseDown", function(frame, button, down)
			if button == "RightButton" and private.db.general.easyCast and _G.ArchaeologyMapUpdateAll() > 0 and not IsTaintable() and not ShouldBeHidden() and not IsFishingPoleEquipped() then
				local perform_survey = false
				local num_loot_items = _G.GetNumLootItems()

				if (num_loot_items == 0 or not num_loot_items) and clicked_time then
					local pressTime = _G.GetTime()
					local doubleTime = pressTime - clicked_time

					if doubleTime < ACTION_DOUBLE_WAIT and doubleTime > MIN_ACTION_DOUBLECLICK then
						clicked_time = nil
						perform_survey = true
					end
				end
				clicked_time = _G.GetTime()

				if perform_survey and not IsTaintable() then
					-- We're stealing the mouse-up event, make sure we exit MouseLook
					if _G.IsMouselooking() then
						_G.MouselookStop()
					end
					_G.SetOverrideBindingClick(SECURE_ACTION_BUTTON, true, "BUTTON2", SECURE_ACTION_BUTTON.name)
					private.override_binding_on = true
				end
			end
		end)
	end
	self:ImportOldStatsDB()
end

function Archy:UpdateFramePositions()
	self:SetFramePosition(private.distance_indicator_frame)
	self:SetFramePosition(private.digsite_frame)
	self:SetFramePosition(private.races_frame)
end

local function InitializeFrames()
	if IsTaintable() then
		private.regen_create_frames = true
		return
	end
	private.digsite_frame = _G.CreateFrame("Frame", "ArchyDigSiteFrame", _G.UIParent, (private.db.general.theme == "Graphical" and "ArchyDigSiteContainer" or "ArchyMinDigSiteContainer"))
	private.digsite_frame.children = setmetatable({}, {
		__index = function(t, k)
			if k then
				local f = _G.CreateFrame("Frame", "ArchyDigSiteChildFrame" .. k, private.digsite_frame, (private.db.general.theme == "Graphical" and "ArchyDigSiteRowTemplate" or "ArchyMinDigSiteRowTemplate"))
				f:Show()
				t[k] = f
				return f
			end
		end
	})
	private.races_frame = _G.CreateFrame("Frame", "ArchyArtifactFrame", _G.UIParent, (private.db.general.theme == "Graphical" and "ArchyArtifactContainer" or "ArchyMinArtifactContainer"))
	private.races_frame.children = setmetatable({}, {
		__index = function(t, k)
			if k then
				local f = _G.CreateFrame("Frame", "ArchyArtifactChildFrame" .. k, private.races_frame, (private.db.general.theme == "Graphical" and "ArchyArtifactRowTemplate" or "ArchyMinArtifactRowTemplate"))
				f:Show()
				t[k] = f
				return f
			end
		end
	})

	private.distance_indicator_frame = _G.CreateFrame("Frame", "ArchyDistanceIndicatorFrame", _G.UIParent, "ArchyDistanceIndicator")
	private.distance_indicator_frame.circle:SetScale(0.65)

	if private.db.general.combathide then private.regen_update_visibility = true end

	private.frames_init_done = true

	Archy:UpdateFramePositions()
	Archy:UpdateDigSiteFrame()
	Archy:UpdateRacesFrame()
end

local timer_handle

function Archy:OnEnable() -- @PLAYER_LOGIN (2)
	_G["SLASH_ARCHY1"] = "/archy"
	_G.SlashCmdList["ARCHY"] = SlashHandler

	--    self:RegisterEvent("ARTIFACT_UPDATE", "ArtifactUpdated")
	self:RegisterEvent("ARTIFACT_COMPLETE")
	self:RegisterEvent("ARTIFACT_DIG_SITE_UPDATED")
	self:RegisterEvent("CHAT_MSG_LOOT", "LootReceived")
	self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	self:RegisterEvent("LOOT_OPENED", "OnPlayerLooting")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("SKILL_LINES_CHANGED", "UpdateSkillBar")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_STOP", "UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_SENT")
	self:RegisterEvent("QUEST_LOG_UPDATE") -- Drii: delay loading Blizzard_ArchaeologyUI until QUEST_LOG_UPDATE so races main page doesn't bug.
	self:RegisterEvent("BAG_UPDATE_DELAYED") -- Drii: new MoP event
	self:RegisterEvent("PET_BATTLE_OPENING_START")
	self:RegisterEvent("PET_BATTLE_CLOSE")

	self:RegisterBucketEvent("ARTIFACT_HISTORY_READY", 0.2)

	-- 	private.db.general.locked = false

	InitializeFrames()
	self:UpdateTracking()
	tomtomActive = true
	private.tomtomExists = (_G.TomTom and _G.TomTom.AddZWaypoint and _G.TomTom.RemoveWaypoint) and true or false
	-- Drii: workaround for TomTom bug ticket 384
	private.tomtomPoiIntegration = private.tomtomExists and (_G.TomTom.profile and _G.TomTom.profile.poi and _G.TomTom.EnableDisablePOIIntegration) and true or false
end

function Archy:OnDisable()
	self:CancelTimer(timer_handle)
end

function Archy:OnProfileUpdate(event, database, ProfileKey)
	local newTheme
	if database then
		if event == "OnProfileChanged" or event == "OnProfileCopied" then
			newTheme = database.profile and database.profile.general and database.profile.general.theme or PROFILE_DEFAULTS.profile.general.theme
		elseif event == "OnProfileReset" or event == "OnNewProfile" then
			newTheme = database.defaults and database.defaults.profile and database.defaults.profile.general and database.defaults.profile.general.theme
		end
	end
	private.db = database and database.profile or self.db.profile

	if newTheme and prevTheme and (newTheme ~= prevTheme) then -- Drii: fix for ticket 406?
		_G.ReloadUI()
	end

	if private.frames_init_done then -- Drii: ticket 394 'OnNewProfile' fires for fresh installations too it seems.
		self:ConfigUpdated()
		self:UpdateFramePositions()
	end
end

-----------------------------------------------------------------------
-- Event handlers.
-----------------------------------------------------------------------
function Archy:ADDON_LOADED(event, addon)
	if addon == "Blizzard_BattlefieldMinimap" then
		if not private.battlefield_hooked then
			_G.BattlefieldMinimap:HookScript("OnShow", Archy.UpdateTracking)
			private.battlefield_hooked = true
		end
		Archy:UnregisterEvent("ADDON_LOADED")
	end
end

function Archy:GET_ITEM_INFO_RECEIVED(event)
	for k, itemID in next, race_data_uncached, nil do
		local itemName, _, _, _, _, _, _, _, _, itemTexture, _ = _G.GetItemInfo(itemID)
		if itemName and itemTexture then
			race_data_uncached[k] = nil
			race_data[k].keystone.name = itemName
			race_data[k].keystone.texture = itemTexture
		end
	end

	if not next(race_data_uncached) then
		Archy:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
	end
end

do
	local function UpdateAndRefresh(race_id)
		UpdateRaceArtifact(race_id)
		Archy:RefreshRacesDisplay()
	end

	function Archy:ARTIFACT_COMPLETE(event, name)
		for race_id, artifact in pairs(artifact_data) do
			if artifact.name == name then
				-- Drii: see if this helps with ticket 377
				if has_pinged[name] then
					has_pinged[name] = nil
				end

				-- alerts not working if the same common artifact pops up after solving it
				if has_announced[name] then
					has_announced[name] = nil
				end
				-- this is still the artifact that was just solved when the event fires
				UpdateRaceArtifact(race_id)
				self:ScheduleTimer(UpdateAndRefresh, 2, race_id)
				break
			end
		end
	end
end

function Archy:ARTIFACT_HISTORY_READY()
	for race_id, artifact in pairs(artifact_data) do
		local _, _, completionCount = GetArtifactStats(race_id, artifact.name)
		if completionCount then
			artifact.completionCount = completionCount
		end
	end
	self:RefreshRacesDisplay()
end

function Archy:ArtifactUpdated()
	-- ignore this event for now as it's can break other Archaeology UIs
	-- Would have been nice if Blizzard passed the race index or artifact name with the event
end

function Archy:ARTIFACT_DIG_SITE_UPDATED()
	if not private.current_continent then
		return
	end
	UpdateAllSites()
	self:UpdateSiteDistances()
	self:RefreshDigSiteDisplay()
end

local function FindCrateable(bag, slot)
	if not HasArchaeology() then
		return
	end

	if IsTaintable() then
		private.regen_scan_bags = true
		return
	end
	local item_id = _G.GetContainerItemID(bag, slot)

	if item_id then
		if CRATE_OF_FRAGMENTS[item_id] then -- 86068,73410 for debug or any book-type item
			private.crate_item_id = item_id
			return true
		end
		private.scantip:SetBagItem(bag, slot)

		for line_num = 1, private.scantip:NumLines() do
			local linetext = (_G["ArchyScanTipTextLeft" .. line_num]:GetText())

			if linetext == CRATE_USE_STRING then
				private.crate_item_id = item_id
				return true
			end
		end
	end
	return false
end

function Archy:ScanBags()
	if IsTaintable() then
		private.regen_scan_bags = true
		return
	end
	private.crate_bag_id, private.crate_bag_slot_id, private.crate_item_id = nil, nil, nil

	for bag = _G.BACKPACK_CONTAINER, _G.NUM_BAG_SLOTS, 1 do
		for slot = 1, _G.GetContainerNumSlots(bag), 1 do
			if not private.crate_bag_id and FindCrateable(bag, slot) then
				private.crate_bag_id = bag
				private.crate_bag_slot_id = slot
				break
			end
		end

		if private.crate_bag_id then
			break
		end
	end

	if private.crate_bag_id then
		private.distance_indicator_frame.crateButton:SetAttribute("type1", "macro")
		private.distance_indicator_frame.crateButton:SetAttribute("macrotext1", "/run _G.ClearCursor() if _G.MerchantFrame:IsShown() then HideUIPanel(_G.MerchantFrame) end\n/use " .. private.crate_bag_id .. " " .. private.crate_bag_slot_id)
		private.distance_indicator_frame.crateButton:Enable()
		private.distance_indicator_frame.crateButton.icon:SetDesaturated(0)
		private.distance_indicator_frame.crateButton.tooltip = private.crate_item_id
		private.distance_indicator_frame.crateButton.shine:Show()
		_G.AutoCastShine_AutoCastStart(private.distance_indicator_frame.crateButton.shine)
		private.distance_indicator_frame.crateButton.shining = true
	else
		private.distance_indicator_frame.crateButton:Disable()
		private.distance_indicator_frame.crateButton.icon:SetDesaturated(1)
		private.distance_indicator_frame.crateButton.tooltip = _G.BROWSE_NO_RESULTS
		private.distance_indicator_frame.crateButton.shine:Hide()
		if private.distance_indicator_frame.crateButton.shining then
			_G.AutoCastShine_AutoCastStop(private.distance_indicator_frame.crateButton.shine)
			private.distance_indicator_frame.crateButton.shining = nil
		end
	end

	local lorewalker_map_count = _G.GetItemCount(LOREWALKER_ITEMS.MAP.id, false, false)
	local lorewalker_lode_count = _G.GetItemCount(LOREWALKER_ITEMS.LODESTONE.id, false, false)
	if lorewalker_map_count > 0 then -- prioritize map since it affects Archy's lists. (randomize digsites)
		local item_name = (_G.GetItemInfo(LOREWALKER_ITEMS.MAP.id))
		private.distance_indicator_frame.loritemButton:SetAttribute("type1", "item")
		private.distance_indicator_frame.loritemButton:SetAttribute("item1", item_name)
		private.distance_indicator_frame.loritemButton:Enable()
		private.distance_indicator_frame.loritemButton.icon:SetDesaturated(0)
		private.distance_indicator_frame.loritemButton.tooltip = LOREWALKER_ITEMS.MAP.id
		local start, duration, enable = _G.GetItemCooldown(LOREWALKER_ITEMS.MAP.id)
		if start > 0 and duration > 0 then
			_G.CooldownFrame_SetTimer(private.distance_indicator_frame.loritemButton.cooldown, start, duration, enable)
		end
	end
	if lorewalker_lode_count > 0 then
		local item_name = (_G.GetItemInfo(LOREWALKER_ITEMS.LODESTONE.id))
		private.distance_indicator_frame.loritemButton:SetAttribute("type2", "item")
		private.distance_indicator_frame.loritemButton:SetAttribute("item2", item_name)
		private.distance_indicator_frame.loritemButton:Enable()
		private.distance_indicator_frame.loritemButton.icon:SetDesaturated(0)
		if lorewalker_map_count > 0 then
			private.distance_indicator_frame.loritemButton.tooltip = { LOREWALKER_ITEMS.MAP.id, item_name }
		else
			private.distance_indicator_frame.loritemButton.tooltip = { LOREWALKER_ITEMS.LODESTONE.id, _G.USE }
		end
	end
	if lorewalker_map_count == 0 and lorewalker_lode_count == 0 then
		private.distance_indicator_frame.loritemButton:Disable()
		private.distance_indicator_frame.loritemButton.icon:SetDesaturated(1)
		private.distance_indicator_frame.loritemButton.tooltip = _G.BROWSE_NO_RESULTS
	end
end

function Archy:BAG_UPDATE_DELAYED()
	Archy:ScanBags()

	if not private.current_continent or not keystoneLootRaceID then
		return
	end
	UpdateRaceArtifact(keystoneLootRaceID)
	self:RefreshRacesDisplay()
	keystoneLootRaceID = nil
end

function Archy:CURRENCY_DISPLAY_UPDATE()
	local num_races = _G.GetNumArchaeologyRaces()

	if not private.current_continent or num_races == 0 then
		return
	end

	for race_id = 1, num_races do
		local _, _, _, currency_amount = _G.GetArchaeologyRaceInfo(race_id)
		local diff = currency_amount - (race_data[race_id].currency or 0)

		race_data[race_id].currency = currency_amount

		-- update the artifact info
		UpdateRaceArtifact(race_id)

		if diff < 0 then
			-- we've spent fragments, aka. Solved an artifact
			artifact_data[race_id].keystones_added = 0

			if artifactSolved.raceId > 0 then
				local _, _, completionCount = GetArtifactStats(race_id, artifactSolved.name)
				self:Pour(L["You have solved |cFFFFFF00%s|r Artifact - |cFFFFFF00%s|r (Times completed: %d)"]:format(race_data[race_id].name, artifactSolved.name, completionCount or 0), 1, 1, 1)

				artifactSolved.raceId = 0
				artifactSolved.name = ""
			end

		elseif diff > 0 then
			local site_stats = self.db.char.digsites.stats
			-- we've gained fragments, aka. Successfully dug at a dig site

			distanceIndicatorActive = false
			ToggleDistanceIndicator()

			if type(lastSite.id) == "number" and lastSite.id > 0 then -- Drii: for now let's just avoid the error
				if private.has_dug then -- only increment once for each dig else fragments looted from 'ancient haunt' throw counter off (bonus fix: ticket 469)
					IncrementDigCounter(lastSite.id)
					private.has_dug = nil
				end
				site_stats[lastSite.id].looted = (site_stats[lastSite.id].looted or 0) + 1
				site_stats[lastSite.id].fragments = site_stats[lastSite.id].fragments + diff

				AddSurveyNode(lastSite.id, player_position.map, player_position.level, player_position.x, player_position.y)
			end
			survey_location.map = 0
			survey_location.level = 0
			survey_location.x = 0
			survey_location.y = 0

			UpdateMinimapPOIs(true)
			self:RefreshDigSiteDisplay()
		end
	end
	self:RefreshRacesDisplay()
end

function Archy:LootReceived(event, msg)
	local _, itemLink, amount = ParseLootMessage(msg)

	if not itemLink then
		return
	end
	local itemID = GetIDFromLink(itemLink)
	local race_id = keystoneIDToRaceID[itemID]

	if race_id then
		if lastSite.id then -- Drii: we can get solves without digging now from crates
			self.db.char.digsites.stats[lastSite.id].keystones = self.db.char.digsites.stats[lastSite.id].keystones + 1
		end
		keystoneLootRaceID = race_id
	end
end

function Archy:QUEST_LOG_UPDATE() -- (4)
	-- Hook and overwrite the default SolveArtifact function to provide confirmations when nearing cap
	if not Blizzard_SolveArtifact then
		if not _G.IsAddOnLoaded("Blizzard_ArchaeologyUI") then
			local loaded, reason = _G.LoadAddOn("Blizzard_ArchaeologyUI")
			if not loaded then
				Archy:Print(L["ArchaeologyUI not loaded: %s SolveArtifact hook not installed."]:format(_G["ADDON_" .. reason]))
			end
		end
		Blizzard_SolveArtifact = _G.SolveArtifact
		function _G.SolveArtifact(race_index, use_stones)
			local rank, max_rank = GetArchaeologyRank()
			if private.db.general.confirmSolve and max_rank < MAX_ARCHAEOLOGY_RANK and (rank + 25) >= max_rank then
				Dialog:Spawn("ArchyConfirmSolve", {
					race_index = race_index,
					use_stones = use_stones,
					rank = rank,
					max_rank = max_rank
				})
			else
				return SolveRaceArtifact(race_index, use_stones)
			end
		end
	end

	if private.frames_init_done then
		Archy:ConfigUpdated()
	end
	self:UnregisterEvent("QUEST_LOG_UPDATE")
	self.QUEST_LOG_UPDATE = nil
end

function Archy:PLAYER_ENTERING_WORLD() -- (3)
	_G.SetMapToCurrentZone()
	-- Two timers are needed here: If we force a call to UpdatePlayerPosition() too soon, the site distances will not update properly and the notifications may vanish just as the player is able to see them.
	if not timer_handle then
		self:ScheduleTimer(function()
			if private.frames_init_done then
				self:UpdateDigSiteFrame()
				self:UpdateRacesFrame()
			end
			timer_handle = self:ScheduleRepeatingTimer("UpdatePlayerPosition", 0.2)
		end, 1)
	end
	self:ScheduleTimer("UpdatePlayerPosition", 2, true)

	if private.db.tomtom.noerrorwarn and (private.db.tomtom.noerrorwarn == Archy.version) then
		--
	elseif private.tomtomPoiIntegration and _G.TomTom.profile.poi.setClosest and not private.tomtomWarned then
		private.tomtomWarned = true
		Dialog:Spawn("ArchyTomTomError")
	end -- Drii: temporary workaround for ticket 384
	-- 	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	-- 	self.PLAYER_ENTERING_WORLD = nil
end

function Archy:PLAYER_REGEN_DISABLED()
	private.in_combat = true

	if self.LDB_Tooltip and self.LDB_Tooltip:IsShown() then
		self.LDB_Tooltip:Hide()
	end

	if private.db.general.combathide and private.digsite_frame:IsVisible() then
		RegisterStateDriver(private.digsite_frame, "visibility", "[combat]hide;show")
	end
	if private.db.general.combathide and private.races_frame:IsVisible() then
		private.races_frame:Hide()
	end
end

function Archy:PLAYER_REGEN_ENABLED()
	private.in_combat = nil

	if private.regen_create_frames then
		private.regen_create_frames = nil
		InitializeFrames()
	end

	if private.regen_toggle_distance then
		private.regen_toggle_distance = nil
		ToggleDistanceIndicator()
	end

	if private.regen_update_tracking then
		private.regen_update_tracking = nil
		self:UpdateTracking()
	end

	if private.regen_clear_override then
		_G.ClearOverrideBindings(SECURE_ACTION_BUTTON)
		private.override_binding_on = nil
		private.regen_clear_override = nil
	end

	if private.regen_update_digsites then
		private.regen_update_digsites = nil
		self:UpdateDigSiteFrame()
	end

	if private.regen_update_races then
		private.regen_update_races = nil
		self:UpdateRacesFrame()
	end

	if private.regen_scan_bags then
		private.regen_scan_bags = nil
		self:ScanBags()
	end

	if private.regen_update_visibility then
		UnregisterStateDriver(private.digsite_frame, "visibility")
		self:ConfigUpdated()
	end
end

local function SetSurveyCooldown(time)
	_G.CooldownFrame_SetTimer(private.distance_indicator_frame.surveyButton.cooldown, _G.GetSpellCooldown(SURVEY_SPELL_ID))
end

local function SetLoreItemCooldown(time)
	_G.CooldownFrame_SetTimer(private.distance_indicator_frame.loritemButton.cooldown, _G.GetItemCooldown(LOREWALKER_ITEMS.MAP.id))
end

function Archy:UNIT_SPELLCAST_SENT(event, unit, spell, rank, target)
	if unit == "player" and spell == CRATE_SPELL_NAME then
		private.busy_crating = true
	end
end

function Archy:UNIT_SPELLCAST_SUCCEEDED(event, unit, spell, rank, line_id, spell_id)
	if unit ~= "player" then
		return
	end

	if spell_id == LOREWALKER_ITEMS.MAP.spell and event == "UNIT_SPELLCAST_SUCCEEDED" then
		if private.distance_indicator_frame.loritemButton and private.distance_indicator_frame.loritemButton:IsShown() then
			self:ScheduleTimer(SetLoreItemCooldown, 0.2)
		end
	end

	if spell_id == CRATE_SPELL_ID then
		if private.busy_crating then
			private.busy_crating = nil
			self:ScheduleTimer("ScanBags", 1)
		end
	end

	if spell_id == SURVEY_SPELL_ID and event == "UNIT_SPELLCAST_SUCCEEDED" then
		private.has_dug = true
		if not player_position or not nearestSite then
			survey_location.map = 0
			survey_location.level = 0
			survey_location.x = 0
			survey_location.y = 0
			return
		end
		survey_location.x = player_position.x
		survey_location.y = player_position.y
		survey_location.map = player_position.map
		survey_location.level = player_position.level

		distanceIndicatorActive = true
		lastSite = nearestSite
		self.db.char.digsites.stats[lastSite.id].surveys = self.db.char.digsites.stats[lastSite.id].surveys + 1

		ToggleDistanceIndicator()
		UpdateDistanceIndicator()

		if private.distance_indicator_frame.surveyButton and private.distance_indicator_frame.surveyButton:IsShown() then
			local now = _G.GetTime()
			local start, duration, enable = _G.GetSpellCooldown(SURVEY_SPELL_ID)

			if start > 0 and duration > 0 and now < (start + duration) then
				if duration <= GLOBAL_COOLDOWN_TIME then
					self:ScheduleTimer(SetSurveyCooldown, (start + duration) - now)
				elseif duration > GLOBAL_COOLDOWN_TIME then -- in case they ever take it off the gcd
					_G.CooldownFrame_SetTimer(private.distance_indicator_frame.surveyButton.cooldown, start, duration, enable)
				end
			end
		end

		if private.db.minimap.fragmentColorBySurveyDistance then
			local min_green, max_green = 0, private.db.digsite.distanceIndicator.green or 0
			local min_yellow, max_yellow = max_green, private.db.digsite.distanceIndicator.yellow or 0
			local min_red, max_red = max_yellow, 500

			for id, poi in pairs(allPois) do
				if poi.active and poi.type == "survey" then
					local distance = Astrolabe:GetDistanceToIcon(poi)

					if distance >= min_green and distance <= max_green then
						poi.icon:SetTexCoord(0.75, 1, 0.5, 0.734375)
					elseif distance >= min_yellow and distance <= max_yellow then
						poi.icon:SetTexCoord(0.5, 0.734375, 0.5, 0.734375)
					elseif distance >= min_red and distance <= max_red then
						poi.icon:SetTexCoord(0.25, 0.484375, 0.5, 0.734375)
					end
				end
			end
		end
		tomtomActive = false
		RefreshTomTom()
		self:RefreshDigSiteDisplay()
	end
end

function Archy:PET_BATTLE_OPENING_START()
	if not private.db.general.show or private.db.general.stealthMode then -- already hidden
		return
	else
		private.pet_battle_shown = true -- store our visible state to restore after pet battle
		private.db.general.show = false
		self:ConfigUpdated()
	end
end

function Archy:PET_BATTLE_CLOSE()
	if private.pet_battle_shown then
		private.pet_battle_shown = nil
		private.db.general.show = true
		if _G.C_PetBattles.IsInBattle() then -- API doesn't return correct values in this event
			self:ScheduleTimer("ConfigUpdated", 1.5) -- so let's schedule our re-show in a sec
		else
			self:ConfigUpdated()
		end
	end
end

function Archy:UpdateSkillBar()
	if not private.current_continent or not HasArchaeology() then
		return
	end
	local races_frame = private.races_frame

	if not races_frame or not races_frame.skillBar then
		return
	end
	local rank, maxRank = GetArchaeologyRank()

	races_frame.skillBar:SetMinMaxValues(0, maxRank)
	races_frame.skillBar:SetValue(rank)
	races_frame.skillBar.text:SetFormattedText("%s : %d/%d", _G.GetArchaeologyInfo(), rank, maxRank)
end

--[[ Positional functions ]] --
function Archy:UpdatePlayerPosition(force)
	if not private.db.general.show and not force then
		return
	end

	if not HasArchaeology() or _G.IsInInstance() or _G.UnitIsGhost("player") then
		return
	end

	if force then
		_G.RequestArtifactCompletionHistory()
	end

	if not private.frames_init_done then
		return
	end

	if _G.GetCurrentMapAreaID() == -1 then
		self:UpdateSiteDistances()
		self:UpdateDigSiteFrame()
		self:RefreshDigSiteDisplay()
		return
	end
	local map, level, x, y = Astrolabe:GetCurrentPlayerPosition()

	if not map or not level or (x == 0 and y == 0) then
		return
	end

	if player_position.x ~= x or player_position.y ~= y or player_position.map ~= map or player_position.level ~= level or force then
		player_position.x, player_position.y, player_position.map, player_position.level = x, y, map, level

		self:RefreshAll()
	end
	local continent = _G.GetCurrentMapContinent()

	if private.current_continent == continent then
		if force and private.current_continent then
			UpdateAllSites()
			ToggleDistanceIndicator()
		elseif force and not continent then
			self:ScheduleTimer("UpdatePlayerPosition", 1, true) -- Drii: get the edge case where continent and private.current_continent are both nil (nil==nil is true)
		end
		return
	end
	private.current_continent = continent

	if force then
		ToggleDistanceIndicator()
	end

	if #race_data == 0 then
		for race_id = 1, _G.GetNumArchaeologyRaces() do
			local race = race_data[race_id] -- metatable should load the data

			if race then
				keystoneIDToRaceID[race.keystone.id] = race_id
			end
		end
		_G.RequestArtifactCompletionHistory()
	end
	ClearTomTomPoint()
	RefreshTomTom()
	UpdateAllSites()

	if _G.GetNumArchaeologyRaces() > 0 then
		for race_id = 1, _G.GetNumArchaeologyRaces() do
			UpdateRaceArtifact(race_id)
		end
		self:UpdateRacesFrame()
		self:RefreshRacesDisplay()
	end

	if force then
		self:UpdateSiteDistances()
	end
	self:UpdateDigSiteFrame()
	self:RefreshDigSiteDisplay()
	self:UpdateFramePositions()
end

function Archy:RefreshAll()
	if not _G.IsInInstance() then
		self:UpdateSiteDistances()
		UpdateDistanceIndicator()
		UpdateMinimapPOIs()
	end
	self:RefreshDigSiteDisplay()
end


--[[ UI functions ]] --
local function FontString_SetShadow(fs, hasShadow)
	if hasShadow then
		fs:SetShadowColor(0, 0, 0, 1)
		fs:SetShadowOffset(1, -1)
	else
		fs:SetShadowColor(0, 0, 0, 0)
		fs:SetShadowOffset(0, 0)
	end
end

local function BattlefieldDigsites_OnUpdate(self, elapsed)
	if private.battlefield_digsites.lastUpdate > _G.TOOLTIP_UPDATE_TIME then
		private.battlefield_digsites:DrawNone();

		local num_entries = _G.ArchaeologyMapUpdateAll()

		for index = 1, num_entries do
			private.battlefield_digsites:DrawBlob(_G.ArcheologyGetVisibleBlobID(index), true)
		end
		private.battlefield_digsites.lastUpdate = 0
	else
		private.battlefield_digsites.lastUpdate = private.battlefield_digsites.lastUpdate + elapsed
	end
end

local function BattleFieldMinimap_Digsites(show)
	if not _G.BattlefieldMinimap then
		Archy:RegisterEvent("ADDON_LOADED")
		return
	end

	if not _G.BattlefieldMinimap:IsShown() then
		if not private.battlefield_hooked then
			_G.BattlefieldMinimap:HookScript("OnShow", Archy.UpdateTracking)
			private.battlefield_hooked = true
		end
		return
	end

	if show then
		if not private.battlefield_digsites then
			private.battlefield_digsites = _G.CreateFrame("ArchaeologyDigSiteFrame", "ArchyBattleFieldDigsites", _G.BattlefieldMinimap)
			private.battlefield_digsites:SetSize(225, 150)
			private.battlefield_digsites:SetPoint("TOPLEFT", _G.BattlefieldMinimap)
			private.battlefield_digsites:SetPoint("BOTTOMRIGHT", _G.BattlefieldMinimap)

			local tex = private.battlefield_digsites:CreateTexture("ArchyBattleFieldDigsitesTexture", "OVERLAY")
			tex:SetAllPoints()
			private.battlefield_digsites:SetFillAlpha(128)
			private.battlefield_digsites:SetFillTexture("Interface\\WorldMap\\UI-ArchaeologyBlob-Inside")
			private.battlefield_digsites:SetBorderTexture("Interface\\WorldMap\\UI-ArchaeologyBlob-Outside")
			private.battlefield_digsites:EnableSmoothing(true)
			private.battlefield_digsites:SetBorderScalar(0.1)
			private.battlefield_digsites.lastUpdate = 0

			private.battlefield_digsites:SetScript("OnUpdate", BattlefieldDigsites_OnUpdate)
		end
		private.battlefield_digsites:Show()
	else
		if private.battlefield_digsites then
			private.battlefield_digsites:Hide()
		end
	end
end

function Archy:UpdateTracking()
	-- do nothing if user has selected to manually configure tracking and blobs.
	if not HasArchaeology() or private.db.general.manualTrack then
		return
	end

	if IsTaintable() then -- Drii: need the check for battlefield blobs, if we don't provide those it can be removed
		private.regen_update_tracking = true
		return
	end

	-- manage minimap tracking
	if digsitesTrackingID then
		_G.SetTracking(digsitesTrackingID, private.db.general.show)
	end
	-- manage worldmap and battlefield map digsites display
	_G.SetCVar("digSites", private.db.general.show and "1" or "0")
	local showDig = _G.GetCVarBool("digSites")

	if showDig then
		_G.WorldMapArchaeologyDigSites:Show()
		BattleFieldMinimap_Digsites(true)
	else
		_G.WorldMapArchaeologyDigSites:Hide()
		BattleFieldMinimap_Digsites(false)
	end
	_G.RefreshWorldMap()
end

function Archy:UpdateRacesFrame()
	if IsTaintable() then
		private.regen_update_races = true
		return
	end
	local races_frame = private.races_frame

	races_frame:SetScale(private.db.artifact.scale)
	races_frame:SetAlpha(private.db.artifact.alpha)

	local is_movable = not private.db.general.locked
	races_frame:SetMovable(is_movable)
	races_frame:EnableMouse(is_movable)

	if is_movable then
		races_frame:RegisterForDrag("LeftButton")
	else
		races_frame:RegisterForDrag()
	end

	local artifact_font_data = private.db.artifact.font
	local artifact_fragment_font_data = private.db.artifact.fragmentFont

	local font = LSM:Fetch("font", artifact_font_data.name)
	local fragment_font = LSM:Fetch("font", artifact_fragment_font_data.name)
	local keystone_font = LSM:Fetch("font", private.db.artifact.keystoneFont.name)

	for _, child in pairs(races_frame.children) do
		if private.db.general.theme == "Graphical" then
			child.fragmentBar.artifact:SetFont(font, artifact_font_data.size, artifact_font_data.outline)
			child.fragmentBar.artifact:SetTextColor(artifact_font_data.color.r, artifact_font_data.color.g, artifact_font_data.color.b, artifact_font_data.color.a)

			child.fragmentBar.fragments:SetFont(fragment_font, artifact_fragment_font_data.size, artifact_fragment_font_data.outline)
			child.fragmentBar.fragments:SetTextColor(artifact_fragment_font_data.color.r, artifact_fragment_font_data.color.g, artifact_fragment_font_data.color.b, artifact_fragment_font_data.color.a)

			child.fragmentBar.keystones.count:SetFont(keystone_font, private.db.artifact.keystoneFont.size, private.db.artifact.keystoneFont.outline)
			child.fragmentBar.keystones.count:SetTextColor(private.db.artifact.keystoneFont.color.r, private.db.artifact.keystoneFont.color.g, private.db.artifact.keystoneFont.color.b, private.db.artifact.keystoneFont.color.a)

			FontString_SetShadow(child.fragmentBar.artifact, artifact_font_data.shadow)
			FontString_SetShadow(child.fragmentBar.fragments, artifact_fragment_font_data.shadow)
			FontString_SetShadow(child.fragmentBar.keystones.count, private.db.artifact.keystoneFont.shadow)
		else
			child.fragments.text:SetFont(font, artifact_font_data.size, artifact_font_data.outline)
			child.fragments.text:SetTextColor(artifact_font_data.color.r, artifact_font_data.color.g, artifact_font_data.color.b, artifact_font_data.color.a)

			child.sockets.text:SetFont(font, artifact_font_data.size, artifact_font_data.outline)
			child.sockets.text:SetTextColor(artifact_font_data.color.r, artifact_font_data.color.g, artifact_font_data.color.b, artifact_font_data.color.a)

			child.artifact.text:SetFont(font, artifact_font_data.size, artifact_font_data.outline)
			child.artifact.text:SetTextColor(artifact_font_data.color.r, artifact_font_data.color.g, artifact_font_data.color.b, artifact_font_data.color.a)

			FontString_SetShadow(child.fragments.text, artifact_font_data.shadow)
			FontString_SetShadow(child.sockets.text, artifact_font_data.shadow)
			FontString_SetShadow(child.artifact.text, artifact_font_data.shadow)
		end
	end
	local borderTexture = LSM:Fetch('border', private.db.artifact.borderTexture)
	local backgroundTexture = LSM:Fetch('background', private.db.artifact.backgroundTexture)

	races_frame:SetBackdrop({
		bgFile = backgroundTexture,
		edgeFile = borderTexture,
		tile = false,
		edgeSize = 8,
		tileSize = 8,
		insets = {
			left = 2,
			top = 2,
			right = 2,
			bottom = 2
		}
	})
	races_frame:SetBackdropColor(1, 1, 1, private.db.artifact.bgAlpha)
	races_frame:SetBackdropBorderColor(1, 1, 1, private.db.artifact.borderAlpha)


	if not IsTaintable() then
		local height = races_frame.container:GetHeight() + ((private.db.general.theme == "Graphical") and 15 or 25)
		if private.db.general.showSkillBar and private.db.general.theme == "Graphical" then
			height = height + 30
		end
		races_frame:SetHeight(height)
		races_frame:SetWidth(races_frame.container:GetWidth() + ((private.db.general.theme == "Graphical") and 45 or 0))
	end

	if races_frame:IsVisible() then
		if private.db.general.stealthMode or not private.db.artifact.show or ShouldBeHidden() then
			races_frame:Hide()
		end
	else
		if not private.db.general.stealthMode and private.db.artifact.show and not ShouldBeHidden() then
			races_frame:Show()
		end
	end
end

-- returns a list of race ids for the continent map id
local function ContinentRaces(continent_id)
	local races = {}
	for _, site in pairs(DIG_SITES) do
		if site.continent == continent_id and not _G.tContains(races, site.race) then
			table.insert(races, site.race)
		end
	end
	return races
end

function Archy:RefreshRacesDisplay()
	if ShouldBeHidden() or _G.GetNumArchaeologyRaces() == 0 then
		return
	end
	local maxWidth, maxHeight = 0, 0
	self:UpdateSkillBar()

	local races_frame = private.races_frame
	local topFrame = races_frame.container
	local hiddenAnchor = races_frame
	local count = 0

	if private.db.general.theme == "Minimal" then
		races_frame.title.text:SetText(L["Artifacts"])
	end

	for _, child in pairs(races_frame.children) do
		child:Hide()
	end

	for race_id, race in pairs(race_data) do
		local child = races_frame.children[race_id]
		local artifact = artifact_data[race_id]
		local _, _, completionCount = GetArtifactStats(race_id, artifact.name)
		child:SetID(race_id)

		if private.db.general.theme == "Graphical" then
			child.solveButton:SetText(_G.SOLVE)
			child.solveButton:SetWidth(child.solveButton:GetTextWidth() + 20)
			child.solveButton.tooltip = _G.SOLVE

			if child.style ~= private.db.artifact.style then
				if private.db.artifact.style == "Compact" then
					child.crest:ClearAllPoints()
					child.crest:SetPoint("TOPLEFT", child, "TOPLEFT", 0, 0)

					child.icon:ClearAllPoints()
					child.icon:SetPoint("LEFT", child.crest, "RIGHT", 0, 0)
					child.icon:SetWidth(32)
					child.icon:SetHeight(32)
					child.icon.texture:SetWidth(32)
					child.icon.texture:SetHeight(32)

					child.crest.text:Hide()
					child.crest:SetWidth(36)
					child.crest:SetHeight(36)
					child.solveButton:SetText("")
					child.solveButton:SetWidth(34)
					child.solveButton:SetHeight(34)
					child.solveButton:SetNormalTexture([[Interface\ICONS\TRADE_ARCHAEOLOGY_AQIR_ARTIFACTFRAGMENT]])
					child.solveButton:SetDisabledTexture([[Interface\ICONS\TRADE_ARCHAEOLOGY_AQIR_ARTIFACTFRAGMENT]])
					child.solveButton:GetDisabledTexture():SetBlendMode("MOD")

					child.solveButton:ClearAllPoints()
					child.solveButton:SetPoint("LEFT", child.fragmentBar, "RIGHT", 5, 0)
					child.fragmentBar.fragments:ClearAllPoints()
					child.fragmentBar.fragments:SetPoint("RIGHT", child.fragmentBar.keystones, "LEFT", -7, 2)
					child.fragmentBar.keystone1:Hide()
					child.fragmentBar.keystone2:Hide()
					child.fragmentBar.keystone3:Hide()
					child.fragmentBar.keystone4:Hide()
					child.fragmentBar.artifact:SetWidth(160)

					child:SetWidth(315 + child.solveButton:GetWidth())
					child:SetHeight(36)
				else
					child.icon:ClearAllPoints()
					child.icon:SetPoint("TOPLEFT", child, "TOPLEFT", 0, 0)
					child.icon:SetWidth(36)
					child.icon:SetHeight(36)
					child.icon.texture:SetWidth(36)
					child.icon.texture:SetHeight(36)

					child.icon:Show()
					child.crest.text:Show()
					child.crest:SetWidth(24)
					child.crest:SetHeight(24)
					child.crest:ClearAllPoints()
					child.crest:SetPoint("TOPLEFT", child.icon, "BOTTOMLEFT", 0, 0)
					child.solveButton:SetHeight(24)
					child.solveButton:SetNormalTexture(nil)
					child.solveButton:SetDisabledTexture(nil)
					child.solveButton:ClearAllPoints()
					child.solveButton:SetPoint("TOPRIGHT", child.fragmentBar, "BOTTOMRIGHT", 0, -3)
					child.fragmentBar.fragments:ClearAllPoints()
					child.fragmentBar.fragments:SetPoint("RIGHT", child.fragmentBar, "RIGHT", -5, 2)
					child.fragmentBar.keystones:Hide()
					child.fragmentBar.artifact:SetWidth(200)

					child:SetWidth(295)
					child:SetHeight(70)
				end
			end

			child.crest.texture:SetTexture(race.texture)
			child.crest.tooltip = race.name .. "\n" .. _G.NORMAL_FONT_COLOR_CODE .. L["Key Stones:"] .. "|r " .. race.keystone.inventory
			child.crest.text:SetText(race.name)
			child.icon.texture:SetTexture(artifact.icon)
			child.icon.tooltip = _G.HIGHLIGHT_FONT_COLOR_CODE .. artifact.name .. "|r\n" .. _G.NORMAL_FONT_COLOR_CODE .. artifact.tooltip .. "\n\n" .. _G.HIGHLIGHT_FONT_COLOR_CODE .. L["Solved Count: %s"]:format(_G.NORMAL_FONT_COLOR_CODE .. (completionCount or "0") .. "|r") .. "\n\n" .. _G.GREEN_FONT_COLOR_CODE .. L["Left-Click to open artifact in default Archaeology UI"] .. "|r"

			-- setup the bar texture here
			local barTexture = (LSM and LSM:Fetch('statusbar', private.db.artifact.fragmentBarTexture)) or _G.DEFAULT_STATUSBAR_TEXTURE
			child.fragmentBar.barTexture:SetTexture(barTexture)
			child.fragmentBar.barTexture:SetHorizTile(false)
			--            if db.artifact.fragmentBarTexture == "Archy" then
			--                child.fragmentBar.barTexture:SetTexCoord(0, 0.810546875, 0.40625, 0.5625)            -- can solve with keystones if they were attached
			--            else
			--                child.fragmentBar.barTexture:SetTexCoord(0, 0, 0.77525001764297, 0.810546875)
			--            end


			local barColor
			if artifact.rare then
				barColor = private.db.artifact.fragmentBarColors["Rare"]
				child.fragmentBar.barBackground:SetTexCoord(0, 0.72265625, 0.3671875, 0.7890625) -- rare
			else
				if completionCount == 0 then
					barColor = private.db.artifact.fragmentBarColors["FirstTime"]
				else
					barColor = private.db.artifact.fragmentBarColors["Normal"]
				end
				child.fragmentBar.barBackground:SetTexCoord(0, 0.72265625, 0, 0.411875) -- bg
			end
			child.fragmentBar:SetMinMaxValues(0, artifact.fragments_required)
			child.fragmentBar:SetValue(math.min(artifact.fragments + artifact.keystone_adjustment, artifact.fragments_required))

			local adjust = (artifact.keystone_adjustment > 0) and (" (|cFF00FF00+%d|r)"):format(artifact.keystone_adjustment) or ""
			child.fragmentBar.fragments:SetFormattedText("%d%s / %d", artifact.fragments, adjust, artifact.fragments_required)
			child.fragmentBar.artifact:SetText(artifact.name)
			child.fragmentBar.artifact:SetWordWrap(true)

			local endFound = false
			local artifactNameSize = child.fragmentBar:GetWidth() - 10

			if private.db.artifact.style == "Compact" then
				artifactNameSize = artifactNameSize - 40

				if artifact.sockets > 0 then
					child.fragmentBar.keystones.tooltip = L["%d Key stone sockets available"]:format(artifact.sockets) .. "\n" .. L["%d %ss in your inventory"]:format(race.keystone.inventory or 0, race.keystone.name or L["Key stone"])
					child.fragmentBar.keystones:Show()

					if child.fragmentBar.keystones and child.fragmentBar.keystones.count then
						child.fragmentBar.keystones.count:SetFormattedText("%d/%d", artifact.keystones_added, artifact.sockets)
					end

					if artifact.keystones_added > 0 then
						child.fragmentBar.keystones.icon:SetTexture(race.keystone.texture)
					else
						child.fragmentBar.keystones.icon:SetTexture(nil)
					end
				else
					child.fragmentBar.keystones:Hide()
				end
			else
				for keystone_index = 1, (_G.ARCHAEOLOGY_MAX_STONES or 4) do
					local field = "keystone" .. keystone_index

					if keystone_index > artifact.sockets or not race.keystone.name then
						child.fragmentBar[field]:Hide()
					else
						child.fragmentBar[field].icon:SetTexture(race.keystone.texture)

						if keystone_index <= artifact.keystones_added then
							child.fragmentBar[field].icon:Show()
							child.fragmentBar[field].tooltip = _G.ARCHAEOLOGY_KEYSTONE_REMOVE_TOOLTIP:format(race.keystone.name)
							child.fragmentBar[field]:Enable()
						else
							child.fragmentBar[field].icon:Hide()
							child.fragmentBar[field].tooltip = _G.ARCHAEOLOGY_KEYSTONE_ADD_TOOLTIP:format(race.keystone.name)
							child.fragmentBar[field]:Enable()

							if endFound then
								child.fragmentBar[field]:Disable()
							end
							endFound = true
						end
						child.fragmentBar[field]:Show()
					end
				end
			end

			if artifact.canSolve or (artifact.keystones_added > 0 and artifact.canSolveStone) then -- Drii: actual user-filled sockets enough to solve so enable the manual solve button
				child.solveButton:Enable()
				barColor = private.db.artifact.fragmentBarColors["Solvable"]
			else
				if artifact.canSolveInventory then -- Drii: solve available with stones from inventory but not enough socketed
					barColor = private.db.artifact.fragmentBarColors["AttachToSolve"]
				end
				child.solveButton:Disable()
			end

			child.fragmentBar.barTexture:SetVertexColor(barColor.r, barColor.g, barColor.b, 1)

			artifactNameSize = artifactNameSize - child.fragmentBar.fragments:GetStringWidth()
			child.fragmentBar.artifact:SetWidth(artifactNameSize)

		else
			local fragmentColor = (artifact.canSolve and "|cFF00FF00" or (artifact.canSolveStone and "|cFFFFFF00" or ""))
			local nameColor = (artifact.rare and "|cFF0070DD" or ((completionCount and completionCount > 0) and _G.GRAY_FONT_COLOR_CODE or ""))
			child.fragments.text:SetFormattedText("%s%d/%d", fragmentColor, artifact.fragments, artifact.fragments_required)

			if race_data[race_id].keystone.inventory > 0 or artifact.sockets > 0 then
				child.sockets.text:SetFormattedText("%d/%d", race_data[race_id].keystone.inventory, artifact.sockets)
				child.sockets.tooltip = L["%d Key stone sockets available"]:format(artifact.sockets) .. "\n" .. L["%d %ss in your inventory"]:format(race.keystone.inventory or 0, race.keystone.name or L["Key stone"])
			else
				child.sockets.text:SetText("")
				child.sockets.tooltip = nil
			end
			child.crest:SetNormalTexture(race_data[race_id].texture)
			child.crest:SetHighlightTexture(race_data[race_id].texture)
			child.crest.tooltip = artifact.name .. "\n" .. _G.NORMAL_FONT_COLOR_CODE .. _G.RACE .. " - " .. "|r" .. _G.HIGHLIGHT_FONT_COLOR_CODE .. race_data[race_id].name .. "\n\n" .. _G.GREEN_FONT_COLOR_CODE .. L["Left-Click to solve without key stones"] .. "\n" .. L["Right-Click to solve with key stones"]

			child.artifact.text:SetFormattedText("%s%s", nameColor, artifact.name)
			child.artifact.tooltip = _G.HIGHLIGHT_FONT_COLOR_CODE .. artifact.name .. "|r\n" .. _G.NORMAL_FONT_COLOR_CODE .. artifact.tooltip .. "\n\n" .. _G.HIGHLIGHT_FONT_COLOR_CODE .. L["Solved Count: %s"]:format(_G.NORMAL_FONT_COLOR_CODE .. (completionCount or "0") .. "|r") .. "\n\n" .. _G.GREEN_FONT_COLOR_CODE .. L["Left-Click to open artifact in default Archaeology UI"] .. "|r"

			child.artifact:SetWidth(child.artifact.text:GetStringWidth())
			child.artifact:SetHeight(child.artifact.text:GetStringHeight())
			child:SetWidth(child.fragments:GetWidth() + child.sockets:GetWidth() + child.crest:GetWidth() + child.artifact:GetWidth() + 30)
		end

		if not private.db.artifact.blacklist[race_id] and artifact.fragments_required > 0 and (not private.db.artifact.filter or _G.tContains(ContinentRaces(private.current_continent), race_id)) then
			child:ClearAllPoints()

			if topFrame == races_frame.container then
				child:SetPoint("TOPLEFT", topFrame, "TOPLEFT", 0, 0)
			else
				child:SetPoint("TOPLEFT", topFrame, "BOTTOMLEFT", 0, -5)
			end
			topFrame = child
			child:Show()
			maxHeight = maxHeight + child:GetHeight() + 5
			maxWidth = (maxWidth > child:GetWidth()) and maxWidth or child:GetWidth()
			count = count + 1
		else
			child:Hide()
		end
	end
	local containerXofs = 0

	if private.db.general.theme == "Graphical" and private.db.artifact.style == "Compact" then
		maxHeight = maxHeight + 10
		containerXofs = -10
	end

	races_frame.container:SetHeight(maxHeight)
	races_frame.container:SetWidth(maxWidth)

	if races_frame.skillBar then
		races_frame.skillBar:SetWidth(maxWidth)
		races_frame.skillBar.border:SetWidth(maxWidth + 9)

		if private.db.general.showSkillBar then
			races_frame.skillBar:Show()
			races_frame.container:ClearAllPoints()
			races_frame.container:SetPoint("TOP", races_frame.skillBar, "BOTTOM", containerXofs, -10)
			maxHeight = maxHeight + 30
		else
			races_frame.skillBar:Hide()
			races_frame.container:ClearAllPoints()
			races_frame.container:SetPoint("TOP", races_frame, "TOP", containerXofs, -20)
			maxHeight = maxHeight + 10
		end
	else
		races_frame.container:ClearAllPoints()
		races_frame.container:SetPoint("TOP", races_frame, "TOP", containerXofs, -20)
		maxHeight = maxHeight + 10
	end

	if not IsTaintable() then
		if count == 0 then
			races_frame:Hide()
		end
		races_frame:SetHeight(maxHeight + ((private.db.general.theme == "Graphical") and 15 or 25))
		races_frame:SetWidth(maxWidth + ((private.db.general.theme == "Graphical") and 45 or 0))
	end
end

function Archy:UpdateDigSiteFrame()
	if IsTaintable() then
		private.regen_update_digsites = true
		return
	end
	private.digsite_frame:SetScale(private.db.digsite.scale)
	private.digsite_frame:SetAlpha(private.db.digsite.alpha)

	local borderTexture = LSM:Fetch('border', private.db.digsite.borderTexture)
	local backgroundTexture = LSM:Fetch('background', private.db.digsite.backgroundTexture)
	private.digsite_frame:SetBackdrop({ bgFile = backgroundTexture, edgeFile = borderTexture, tile = false, edgeSize = 8, tileSize = 8, insets = { left = 2, top = 2, right = 2, bottom = 2 } })
	private.digsite_frame:SetBackdropColor(1, 1, 1, private.db.digsite.bgAlpha)
	private.digsite_frame:SetBackdropBorderColor(1, 1, 1, private.db.digsite.borderAlpha)

	local font = LSM:Fetch("font", private.db.digsite.font.name)
	local zoneFont = LSM:Fetch("font", private.db.digsite.zoneFont.name)
	local digsite_font = private.db.digsite.font

	for _, siteFrame in pairs(private.digsite_frame.children) do
		siteFrame.site.name:SetFont(font, digsite_font.size, digsite_font.outline)
		siteFrame.digCounter.value:SetFont(font, digsite_font.size, digsite_font.outline)
		siteFrame.site.name:SetTextColor(digsite_font.color.r, digsite_font.color.g, digsite_font.color.b, digsite_font.color.a)
		siteFrame.digCounter.value:SetTextColor(digsite_font.color.r, digsite_font.color.g, digsite_font.color.b, digsite_font.color.a)
		FontString_SetShadow(siteFrame.site.name, digsite_font.shadow)
		FontString_SetShadow(siteFrame.digCounter.value, digsite_font.shadow)

		if private.db.general.theme == "Graphical" then
			local zone_font = private.db.digsite.zoneFont

			siteFrame.zone.name:SetFont(zoneFont, zone_font.size, zone_font.outline)
			siteFrame.distance.value:SetFont(zoneFont, zone_font.size, zone_font.outline)
			siteFrame.zone.name:SetTextColor(zone_font.color.r, zone_font.color.g, zone_font.color.b, zone_font.color.a)
			siteFrame.distance.value:SetTextColor(zone_font.color.r, zone_font.color.g, zone_font.color.b, zone_font.color.a)
			FontString_SetShadow(siteFrame.zone.name, zone_font.shadow)
			FontString_SetShadow(siteFrame.distance.value, zone_font.shadow)
		else
			siteFrame.zone.name:SetFont(font, digsite_font.size, digsite_font.outline)
			siteFrame.distance.value:SetFont(font, digsite_font.size, digsite_font.outline)
			siteFrame.zone.name:SetTextColor(digsite_font.color.r, digsite_font.color.g, digsite_font.color.b, digsite_font.color.a)
			siteFrame.distance.value:SetTextColor(digsite_font.color.r, digsite_font.color.g, digsite_font.color.b, digsite_font.color.a)
			FontString_SetShadow(siteFrame.zone.name, digsite_font.shadow)
			FontString_SetShadow(siteFrame.distance.value, digsite_font.shadow)
		end
	end

	local continent_id = private.current_continent

	if private.digsite_frame:IsVisible() then
		if private.db.general.stealthMode or not private.db.digsite.show or ShouldBeHidden() or not continent_digsites[continent_id] or #continent_digsites[continent_id] == 0 then
			private.digsite_frame:Hide()
		end
	else
		if not private.db.general.stealthMode and private.db.digsite.show and not ShouldBeHidden() and continent_digsites[continent_id] and #continent_digsites[continent_id] > 0 then
			private.digsite_frame:Show()
		end
	end
end

function Archy:ShowDigSiteTooltip(digsite)
	local site_id = digsite:GetParent():GetID()
	local normal_font = _G.NORMAL_FONT_COLOR_CODE
	local highlight_font = _G.HIGHLIGHT_FONT_COLOR_CODE
	local site_stats = self.db.char.digsites.stats

	digsite.tooltip = digsite.name:GetText()
	digsite.tooltip = digsite.tooltip .. ("\n%s%s%s%s|r"):format(normal_font, _G.ZONE .. ": ", highlight_font, digsite:GetParent().zone.name:GetText())
	digsite.tooltip = digsite.tooltip .. ("\n\n%s%s %s%s|r"):format(normal_font, L["Surveys:"], highlight_font, site_stats[site_id].surveys or 0)
	digsite.tooltip = digsite.tooltip .. ("\n%s%s %s%s|r"):format(normal_font, L["Digs"] .. ": ", highlight_font, site_stats[site_id].looted or 0)
	digsite.tooltip = digsite.tooltip .. ("\n%s%s %s%s|r"):format(normal_font, _G.ARCHAEOLOGY_RUNE_STONES .. ": ", highlight_font, site_stats[site_id].fragments or 0)
	digsite.tooltip = digsite.tooltip .. ("\n%s%s %s%s|r"):format(normal_font, L["Key Stones:"], highlight_font, site_stats[site_id].keystones or 0)
	digsite.tooltip = digsite.tooltip .. "\n\n" .. _G.GREEN_FONT_COLOR_CODE .. L["Left-Click to view the zone map"]

	if self:IsSiteBlacklisted(digsite.siteName) then
		digsite.tooltip = digsite.tooltip .. "\n" .. L["Right-Click to remove from blacklist"]
	else
		digsite.tooltip = digsite.tooltip .. "\n" .. L["Right-Click to blacklist"]
	end
	_G.GameTooltip:SetOwner(digsite, "ANCHOR_BOTTOMRIGHT")
	_G.GameTooltip:SetText(digsite.tooltip, _G.NORMAL_FONT_COLOR[1], _G.NORMAL_FONT_COLOR[2], _G.NORMAL_FONT_COLOR[3], 1, true)
end

function Archy:ResizeDigSiteDisplay()
	if private.db.general.theme == "Graphical" then
		self:ResizeGraphicalDigSiteDisplay()
	else
		self:ResizeMinimalDigSiteDisplay()
	end
end

function Archy:ResizeMinimalDigSiteDisplay()
	local maxWidth, maxHeight = 0, 0
	local topFrame = private.digsite_frame.container
	local siteIndex = 0
	local maxNameWidth, maxZoneWidth, maxDistWidth, maxDigCounterWidth = 0, 0, 70, 20

	for _, siteFrame in pairs(private.digsite_frame.children) do
		siteIndex = siteIndex + 1
		siteFrame.zone:SetWidth(siteFrame.zone.name:GetStringWidth())
		siteFrame.distance:SetWidth(siteFrame.distance.value:GetStringWidth())
		siteFrame.site:SetWidth(siteFrame.site.name:GetStringWidth())
		local width
		local nameWidth = siteFrame.site:GetWidth()
		local zoneWidth = siteFrame.zone:GetWidth()
		if maxNameWidth < nameWidth then maxNameWidth = nameWidth
		end
		if maxZoneWidth < zoneWidth then maxZoneWidth = zoneWidth
		end
		if maxDistWidth < siteFrame.distance:GetWidth() then maxDistWidth = siteFrame.distance:GetWidth()
		end
		maxHeight = maxHeight + siteFrame:GetHeight() + 5

		siteFrame:ClearAllPoints()
		if siteIndex == 1 then siteFrame:SetPoint("TOP", topFrame, "TOP", 0, 0) else siteFrame:SetPoint("TOP", topFrame, "BOTTOM", 0, -5)
		end
		topFrame = siteFrame
	end

	if not private.db.digsite.minimal.showDistance then
		maxDistWidth = 0
	end

	if not private.db.digsite.minimal.showZone then
		maxZoneWidth = 0
	end

	if not private.db.digsite.minimal.showDigCounter then
		maxDigCounterWidth = 0
	end
	maxWidth = 57 + maxDigCounterWidth + maxNameWidth + maxZoneWidth + maxDistWidth

	for _, siteFrame in pairs(private.digsite_frame.children) do
		siteFrame.zone:SetWidth(maxZoneWidth == 0 and 1 or maxZoneWidth)
		siteFrame.site:SetWidth(maxNameWidth)
		siteFrame.distance:SetWidth(maxDistWidth == 0 and 1 or maxDistWidth)
		siteFrame:SetWidth(maxWidth)
		siteFrame.distance:SetAlpha(private.db.digsite.minimal.showDistance and 1 or 0)
		siteFrame.zone:SetAlpha(private.db.digsite.minimal.showZone and 1 or 0)
	end
	private.digsite_frame.container:SetWidth(maxWidth)
	private.digsite_frame.container:SetHeight(maxHeight)

	if not IsTaintable() then
		local cpoint, crelTo, crelPoint, cxOfs, cyOfs = private.digsite_frame.container:GetPoint()

		-- private.digsite_frame:SetHeight(private.digsite_frame.container:GetHeight() + cyOfs + 40)
		private.digsite_frame:SetHeight(maxHeight + cyOfs + 40)
		private.digsite_frame:SetWidth(maxWidth + cxOfs + 30)
	end
end

function Archy:ResizeGraphicalDigSiteDisplay()
	local maxWidth, maxHeight = 0, 0
	local topFrame = private.digsite_frame.container
	local siteIndex = 0

	for _, siteFrame in pairs(private.digsite_frame.children) do
		siteIndex = siteIndex + 1
		siteFrame.zone:SetWidth(siteFrame.zone.name:GetStringWidth())
		siteFrame.distance:SetWidth(siteFrame.distance.value:GetStringWidth())
		siteFrame.site:SetWidth(siteFrame.site.name:GetStringWidth())

		local width
		local nameWidth = siteFrame.site:GetWidth()
		local zoneWidth = siteFrame.zone:GetWidth() + 10

		if nameWidth > zoneWidth then
			width = siteFrame.crest:GetWidth() + nameWidth + siteFrame.digCounter:GetWidth() + 6
		else
			width = siteFrame.crest:GetWidth() + zoneWidth + siteFrame.distance:GetWidth() + 6
		end

		if width > maxWidth then
			maxWidth = width
		end
		maxHeight = maxHeight + siteFrame:GetHeight() + 5

		siteFrame:ClearAllPoints()

		if siteIndex == 1 then
			siteFrame:SetPoint("TOP", topFrame, "TOP", 0, 0)
		else
			siteFrame:SetPoint("TOP", topFrame, "BOTTOM", 0, -5)
		end
		topFrame = siteFrame
	end

	for _, siteFrame in pairs(private.digsite_frame.children) do
		siteFrame:SetWidth(maxWidth)
	end
	private.digsite_frame.container:SetWidth(maxWidth)
	private.digsite_frame.container:SetHeight(maxHeight)

	if not IsTaintable() then
		local cpoint, crelTo, crelPoint, cxOfs, cyOfs = private.digsite_frame.container:GetPoint()
		-- private.digsite_frame:SetHeight(private.digsite_frame.container:GetHeight() + cyOfs + 40) -- masahikatao on wowinterface
		private.digsite_frame:SetHeight(maxHeight + cyOfs + 40)
		private.digsite_frame:SetWidth(maxWidth + cxOfs + 30)
	end
end

function Archy:RefreshDigSiteDisplay()
	if ShouldBeHidden() then
		return
	end
	local continent_id = private.current_continent

	if not continent_id or not continent_digsites[continent_id] or #continent_digsites[continent_id] == 0 then
		return
	end

	for _, site_frame in pairs(private.digsite_frame.children) do
		site_frame:Hide()
	end

	for _, site in pairs(continent_digsites[continent_id]) do
		if not site.distance then
			return
		end
	end

	for site_index, site in pairs(continent_digsites[continent_id]) do
		local site_frame = private.digsite_frame.children[site_index]
		local count = self.db.char.digsites.stats[site.id].counter

		if private.db.general.theme == "Graphical" then
			if site_frame.style ~= private.db.digsite.style then
				if private.db.digsite.style == "Compact" then
					site_frame.crest:SetWidth(20)
					site_frame.crest:SetHeight(20)
					site_frame.crest.icon:SetWidth(20)
					site_frame.crest.icon:SetHeight(20)
					site_frame.zone:Hide()
					site_frame.distance:Hide()
					site_frame:SetHeight(24)
				else
					site_frame.crest:SetWidth(40)
					site_frame.crest:SetHeight(40)
					site_frame.crest.icon:SetWidth(40)
					site_frame.crest.icon:SetHeight(40)
					site_frame.zone:Show()
					site_frame.distance:Show()
					site_frame:SetHeight(40)
				end
			end
			site_frame.digCounter.value:SetText(count or "")
		else
			site_frame.digCounter.value:SetFormattedText("%d/%d", count or 0, SURVEYS_PER_DIGSITE)
		end

		site_frame.distance.value:SetFormattedText(L["%d yards"], site.distance)

		if self:IsSiteBlacklisted(site.name) then
			site_frame.site.name:SetFormattedText("|cFFFF0000%s", site.name)
		else
			site_frame.site.name:SetText(site.name)
		end

		if site_frame.site.siteName ~= site.name then
			site_frame.crest.icon:SetTexture(race_data[site.raceId].texture)
			site_frame.crest.tooltip = race_data[site.raceId].name
			site_frame.zone.name:SetText(site.zoneName)
			site_frame.site.siteName = site.name
			site_frame.site.zoneId = site.zoneId
			site_frame:SetID(site.id)
		end
		site_frame:Show()
	end
	self:ResizeDigSiteDisplay()
end

function Archy:SetFramePosition(frame)
	if frame.isMoving or (frame:IsProtected() and IsTaintable()) then
		return
	end
	local bPoint, bRelativePoint, bXofs, bYofs
	local bRelativeTo = _G.UIParent

	if frame == private.digsite_frame then
		bPoint, bRelativePoint, bXofs, bYofs = unpack(private.db.digsite.position)
	elseif frame == private.races_frame then
		bPoint, bRelativePoint, bXofs, bYofs = unpack(private.db.artifact.position)
	elseif frame == private.distance_indicator_frame then
		if not private.db.digsite.distanceIndicator.undocked then
			bRelativeTo = private.digsite_frame
			bPoint, bRelativePoint, bXofs, bYofs = "CENTER", "TOPLEFT", 50, -5
			frame:SetParent(private.digsite_frame)
		else
			frame:SetParent(_G.UIParent)
			bPoint, bRelativePoint, bXofs, bYofs = unpack(private.db.digsite.distanceIndicator.position)
		end
	end
	frame:ClearAllPoints()
	frame:SetPoint(bPoint, bRelativeTo, bRelativePoint, bXofs, bYofs)
	frame:SetFrameLevel(2)

	if frame:GetParent() == _G.UIParent and not IsTaintable() and not private.db.general.locked then -- Drii: ticket 390
		frame:SetUserPlaced(false)
	end
end

function Archy:SaveFramePosition(frame)
	local bPoint, bRelativeTo, bRelativePoint, bXofs, bYofs = frame:GetPoint()
	local width, height
	local anchor, position

	if frame == private.digsite_frame then
		anchor = Archy.db.profile.digsite.anchor
		position = Archy.db.profile.digsite.position
	elseif frame == private.races_frame then
		anchor = Archy.db.profile.artifact.anchor
		position = Archy.db.profile.artifact.position
	elseif frame == private.distance_indicator_frame then
		anchor = Archy.db.profile.digsite.distanceIndicator.anchor
		position = Archy.db.profile.digsite.distanceIndicator.position
	end

	if not anchor or not position then
		return
	end

	if anchor == bPoint then
		position = { bPoint, bRelativePoint, bXofs, bYofs }
	else
		width = frame:GetWidth()
		height = frame:GetHeight()

		if bPoint == "TOP" then
			bXofs = bXofs - (width / 2)
		elseif bPoint == "LEFT" then
			bYofs = bYofs + (height / 2)
		elseif bPoint == "BOTTOMLEFT" then
			bYofs = bYofs + height
		elseif bPoint == "TOPRIGHT" then
			bXofs = bXofs - width
		elseif bPoint == "RIGHT" then
			bYofs = bYofs + (height / 2)
			bXofs = bXofs - width
		elseif bPoint == "BOTTOM" then
			bYofs = bYofs + height
			bXofs = bXofs - (width / 2)
		elseif bPoint == "BOTTOMRIGHT" then
			bYofs = bYofs + height
			bXofs = bXofs - width
		elseif bPoint == "CENTER" then
			bYofs = bYofs + (height / 2)
			bXofs = bXofs - (width / 2)
		end

		if anchor == "TOPRIGHT" then
			bXofs = bXofs + width
		elseif anchor == "BOTTOMRIGHT" then
			bYofs = bYofs - height
			bXofs = bXofs + width
		elseif anchor == "BOTTOMLEFT" then
			bYofs = bYofs - height
		end

		position = {
			anchor,
			bRelativePoint,
			bXofs,
			bYofs
		}
	end

	if frame == private.digsite_frame then
		private.db.digsite.position = position
	elseif frame == private.races_frame then
		private.db.artifact.position = position
	elseif frame == private.distance_indicator_frame then
		private.db.digsite.distanceIndicator.position = position
	end
end

function Archy:OnPlayerLooting(event, ...)
	local auto_loot_enabled = ...

	if not private.db.general.autoLoot or auto_loot_enabled == 1 then
		return
	end

	for slot_id = 1, _G.GetNumLootItems() do
		local slot_type = _G.GetLootSlotType(slot_id)

		if slot_type == _G.LOOT_SLOT_CURRENCY then
			_G.LootSlot(slot_id)
		elseif slot_type == _G.LOOT_SLOT_ITEM then
			local link = _G.GetLootSlotLink(slot_id)

			if link then
				local item_id = GetIDFromLink(link)

				if item_id and (keystoneIDToRaceID[item_id] or QUEST_ITEM_IDS[item_id]) then
					_G.LootSlot(slot_id)
				end
			end
		end
	end
end
