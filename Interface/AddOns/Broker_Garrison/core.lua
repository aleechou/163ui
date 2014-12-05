local ADDON_NAME, _ = ...
local _G = getfenv(0)

local LibStub = _G.LibStub

local BrokerGarrison = LibStub('AceAddon-3.0'):NewAddon(ADDON_NAME, 'AceConsole-3.0', "AceHook-3.0", 'AceEvent-3.0', 'AceTimer-3.0', "LibSink-2.0")
local Garrison = BrokerGarrison

Garrison.versionString = GetAddOnMetadata(ADDON_NAME, "Version");
Garrison.cleanName = "Broker Garrison"

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local L = LibStub:GetLibrary( "AceLocale-3.0" ):GetLocale(ADDON_NAME)
local LibQTip = LibStub('LibQTip-1.0')
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local Toast, ToastVersion = LibStub("LibToast-1.0")
local LSM = LibStub:GetLibrary("LibSharedMedia-3.0")

-- LUA
local math, string, table, print, pairs, ipairs, unpack = _G.math, _G.string, _G.table, _G.print, _G.pairs, _G.ipairs, _G.unpack
local tonumber, strupper, select, time = _G.tonumber, _G.strupper, _G.select, _G.time
-- Blizzard
local BreakUpLargeNumbers, C_Garrison, GetCurrencyInfo = _G.BreakUpLargeNumbers, _G.C_Garrison, _G.GetCurrencyInfo
-- UI Elements
local InterfaceOptionsFrameAddOns, UIParentLoadAddOn, GarrisonLandingPage = _G.InterfaceOptionsFrameAddOns, _G.UIParentLoadAddOn, _G.GarrisonLandingPage
local GarrisonMissionFrame, GarrisonLandingPageMinimapButton = _G.GarrisonMissionFrame ,_G.GarrisonLandingPageMinimapButton
-- UI Functions
local ShowUIPanel, HideUIPanel, CreateFont, PlaySoundFile = _G.ShowUIPanel, _G.HideUIPanel, _G.CreateFont, _G.PlaySoundFile
-- UI Hooks
local OptionsListButtonToggle_OnClick = _G.OptionsListButtonToggle_OnClick

local garrisonDb, configDb, globalDb, DEFAULT_FONT, colors

-- Constants
local TYPE_BUILDING = "building"
local TYPE_MISSION = "mission"
local TYPE_SHIPMENT = "shipment"

Garrison.TYPE_BUILDING = TYPE_BUILDING
Garrison.TYPE_MISSION = TYPE_MISSION
Garrison.TYPE_SHIPMENT = TYPE_SHIPMENT

local addonInitialized = false
local delayedInit = false
local dependencyLoaded = false
local CONFIG_VERSION = 2

local timers = {}
Garrison.timers = timers
local atlas = {}
Garrison.atlas = atlas
local iconCache = {}
Garrison.iconCache = iconCache

local patternCache = {}
Garrison.patternCache = patternCache

-- Garrison Functions
local debugPrint, pairsByKeys, formatRealmPlayer, tableSize, getColoredString, getColoredUnitName, formattedSeconds, getIconString


local TOAST_MISSION_COMPLETE = "BrokerGarrisonMissionComplete"
local TOAST_BUILDING_COMPLETE = "BrokerGarrisonBuildingComplete"
local TOAST_SHIPMENT_COMPLETE = "BrokerGarrisonShipmentComplete"

local DB_DEFAULTS = {
	profile = {
		general = {
			mission = {
				ldbTemplate = "M1",
				hideCharactersWithoutMissions = true,
				ldbLabelText = L["Garrison: Missions"],
				showOnlyCurrentRealm = false,
				collapseOtherCharsOnLogin = false,
				compactTooltip = false,
				showFollowers = false,
			},
			building = {
				hideBuildingWithoutShipments = false,
				hideHeader = false,
				ldbTemplate = "B1",
				ldbLabelText = L["Garrison: Buildings"],
				showOnlyCurrentRealm = false,
				collapseOtherCharsOnLogin = false,
				compactTooltip = false,
			},			
			hideGarrisonMinimapButton = false,
			highAccuracy = true,
			showSeconds = true,
		},
		tooltip = {
			building = {
				sort = {
					[1] = {
						value = "b.canActivate",
						ascending = true,
					},
					[2] = {
						value = "b.isBuilding",
						ascending = false,
					},
					[3] = {
						value = "b.shipmentsReady",
						ascending = false,
					},
					[4] = {
						value = "b.shipmentCapacity",
						ascending = false,
					},
					[5] = {
						value = "b.name",
						ascending = true,
					},
					['*'] = {
						value = "-",
						ascending = false,
					},
				},
				group = {
					[1] = {
						value = "b.size",
						ascending = true,
					},
				},
			},
			mission = {
				sort = {
					[1] = {
						value = "m.timeLeft",
						ascending = true,
					},
					[2] = {
						value = "m.level",
						ascending = false,
					},
					[3] = {
						value = "m.name",
						ascending = true,
					},					
					['*'] = {
						value = "-",
						ascending = false,
					},					
				},
				group = {
					[1] = {
						value = "m.missionState",
						ascending = true,
					},
				},				
			},
		},
		notification = {
			sink = {},
			general = {
				disableInParty = true,
				disableInRaid = true,
				disableInPvP = true,
			},
			mission = {
				enabled = true,
				repeatOnLoad = false,
				toastEnabled = true,
				toastPersistent = false,
				hideBlizzardNotification = true,
				hideMinimapPulse = false,
				compactToast = false,
			},
			building = {
				enabled = true,
				repeatOnLoad = false,
				toastEnabled = true,
				toastPersistent = false,
				hideBlizzardNotification = true,
				hideMinimapPulse = false,
				compactToast = false,
			},
			shipment = {
				enabled = true,
				repeatOnLoad = false,
				toastEnabled = true,
				toastPersistent = false,
				hideBlizzardNotification = true,
				hideMinimapPulse = false,
				compactToast = false,
			},			
		},
		display = {
			scale = 1,
			autoHideDelay = 0.25,
			iconSize = 16,
			fontSize = 12,
			showIcon = true,
			backgroundAlpha = 255,
		},
		debugPrint = false,
	},
	global = {
		data = {}
	}
}

-- Player info
local charInfo = {
	playerName = UnitName("player"),
	playerClass = select(2, UnitClass("player")),
	playerFaction = UnitFactionGroup("player"),
	realmName = GetRealmName(),
}
Garrison.charInfo = charInfo

local location = {
	garrisonMapName = _G.GetMapNameByID(976),
	zoneName = nil,
	inGarrison = nil,
}
Garrison.location = location

-- LDB init
local ldb_object_mission = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(ADDON_NAME.."Mission",
  { type = "data source",
   label = L["Garrison: Missions"],
	icon = "Interface\\Icons\\Inv_Garrison_Resource",
	text = L["Garrison: Missions"],
   })

local ldb_object_building = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(ADDON_NAME.."Building",
  { type = "data source",
   label = L["Garrison: Buildings"],
	icon = "Interface\\Icons\\Inv_Garrison_Resource",
	text = L["Garrison: Buildings"],
   })


function Garrison:OnDependencyLoaded()
	if not dependencyLoaded then
		dependencyLoaded = true
	
		GarrisonLandingPage = _G.GarrisonLandingPage
		GarrisonMissionFrame = _G.GarrisonMissionFrame

		debugPrint("DependencyLoaded")

		Garrison:ScheduleTimer("RegisterEvents", 5)

		self:Hook("GarrisonCapacitiveDisplayFrame_Update", true)
	end
end

function Garrison:RegisterEvents()
	debugPrint("RegisterEvents")

	local fullUpdateRet = Garrison:FullUpdateBuilding(TYPE_BUILDING)	

	timers.ldb_update = Garrison:ScheduleRepeatingTimer("LDBUpdate", 1)
	timers.notify_update = Garrison:ScheduleRepeatingTimer("QuickUpdate", 5)
	timers.icon_update = Garrison:ScheduleRepeatingTimer("SlowUpdate", 30)	

	self:RegisterEvent("GARRISON_BUILDING_PLACED", "BuildingUpdate")
	self:RegisterEvent("GARRISON_BUILDING_REMOVED", "BuildingUpdate")
	self:RegisterEvent("GARRISON_BUILDING_UPDATE", "BuildingUpdate")
	self:RegisterEvent("GARRISON_BUILDING_ACTIVATED", "BuildingUpdate")
	self:RegisterEvent("GARRISON_UPDATE", "BuildingUpdate")
	self:RegisterEvent("SHIPMENT_UPDATE", "ShipmentStatusUpdate")

end

function Garrison:LoadDependencies()
	if not GarrisonMissionFrame or not GarrisonLandingPage then
		debugPrint("Loading Blizzard_GarrisonUI...")
		if UIParentLoadAddOn("Blizzard_GarrisonUI") then
			Garrison:OnDependencyLoaded()
		end
	end

	if not dependencyLoaded and _G.IsAddOnLoaded("Blizzard_GarrisonUI") then
		Garrison:OnDependencyLoaded()
	end
end
-- Helper Functions

local function toastCallback (callbackType, mouseButton, buttonDown, payload)

	local missionData = payload[1]

	if callbackType == "primary" then
		debugPrint("OK: "..payload[1].id.." ("..payload[1].name..")")
	end
	if callbackType == "secondary" then
		debugPrint("Dismiss: "..payload[1].id.." ("..payload[1].name..")")
		missionData.notification = 2 -- Mission dismissed, never show again
		missionData.notificationDismissed = true
	end
end

local function toastMissionComplete (toast, text, missionData)
	if configDb.notification.mission.toastPersistent then
		toast:MakePersistent()
	end
	toast:SetTitle(L["Mission complete"])
	toast:SetFormattedText(getColoredString(text, colors.green))

	if ToastVersion >= 8 and missionData.typeAtlas then
		toast:SetIconAtlas(missionData.typeAtlas)
	else
		toast:SetIconTexture([[Interface\Icons\Inv_Garrison_Resource]])
	end

	if configDb.notification.mission.extendedToast then
		toast:SetPrimaryCallback(_G.OKAY, toastCallback)
		toast:SetSecondaryCallback(L["Dismiss"], toastCallback)
		toast:SetPayload(missionData)
	end
end

local function toastBuildingComplete (toast, text, buildingData)
	if configDb.notification.building.toastPersistent then
		toast:MakePersistent()
	end
	toast:SetTitle(L["Building complete"])
	toast:SetFormattedText(getColoredString(text, colors.green))
	toast:SetIconTexture(Garrison.GetIconPath(buildingData.icon))
	if configDb.notification.building.extendedToast then
		toast:SetPrimaryCallback(_G.OKAY, toastCallback)
		toast:SetSecondaryCallback(L["Dismiss"], toastCallback)
		toast:SetPayload(buildingData)
	end
end

local function toastShipmentComplete (toast, text, shipmentData)
	if configDb.notification.shipment.toastPersistent then
		toast:MakePersistent()
	end
	toast:SetTitle(L["Garrison: Shipment complete"])
	toast:SetFormattedText(getColoredString(text, colors.green))
	toast:SetIconTexture(Garrison.GetIconPath(shipmentData.texture))
	if configDb.notification.shipment.extendedToast then
		toast:SetPrimaryCallback(_G.OKAY, toastCallback)
		toast:SetSecondaryCallback(L["Dismiss"], toastCallback)
		toast:SetPayload(shipmentData)
	end
end


function Garrison:SendNotification(paramCharInfo, data, notificationType)

	local retVal = false

	local playerNotificationEnabled = globalDb.data[paramCharInfo.realmName][paramCharInfo.playerName].notificationEnabled

	if delayedInit then
		if configDb.notification[notificationType].enabled and (playerNotificationEnabled == nil or playerNotificationEnabled) then
			if  (not data.notification or
				(data.notification == 0) or
				(not addonInitialized and configDb.notification[notificationType].repeatOnLoad and not data.notificationDismissed) or
				(notificationType == TYPE_SHIPMENT and (not data.notificationValue or data.shipmentsReadyEstimate > data.notificationValue))
			) then

				if not Garrison:DisableInInstance() then

					local notificationText, toastName, toastText, soundName, toastEnabled, playSound

					if configDb.notification[notificationType].compactToast then
						toastText = ("%s\n%s"):format(formatRealmPlayer(paramCharInfo, true), data.name)
					else
						toastText = ("%s\n\n%s"):format(formatRealmPlayer(paramCharInfo, true), data.name)
					end

					toastEnabled = configDb.notification[notificationType].toastEnabled
					playSound = configDb.notification[notificationType].PlaySound
					soundName = configDb.notification[notificationType].SoundName or "None"

					if (notificationType == TYPE_MISSION) then
						notificationText = (L["Mission complete (%s): %s"]):format(formatRealmPlayer(paramCharInfo, false), data.name)
						toastName = TOAST_MISSION_COMPLETE
					elseif (notificationType == TYPE_BUILDING) then
						notificationText = (L["Building complete (%s): %s"]):format(formatRealmPlayer(paramCharInfo, false), data.name)
						toastName = TOAST_BUILDING_COMPLETE
					elseif (notificationType == TYPE_SHIPMENT) then

						if configDb.notification[notificationType].compactToast then
							toastText = ("%s\n%s (%s / %s)"):format(formatRealmPlayer(paramCharInfo, true), data.name, data.shipmentsReadyEstimate, data.shipmentsTotal)
						else
							toastText = ("%s\n\n%s (%s / %s)"):format(formatRealmPlayer(paramCharInfo, true), data.name, data.shipmentsReadyEstimate, data.shipmentsTotal)						
						end
						
						notificationText = (L["Shipment complete (%s): %s (%s / %s)"]):format(formatRealmPlayer(paramCharInfo, false), data.name, data.shipmentsReadyEstimate, data.shipmentsTotal)
						toastName = TOAST_SHIPMENT_COMPLETE

						data.notificationValue = data.shipmentsReadyEstimate
					end

					debugPrint(notificationText)

					self:Pour(notificationText, colors.green.r, colors.green.g, colors.green.b)

					if toastEnabled then
						Toast:Spawn(toastName, toastText, data)
					end

					if playSound then
						PlaySoundFile(LSM:Fetch("sound", soundName))
					end

					data.notification = 1

					retVal = true
				else
					debugPrint(("Notifaction (%s) hidden (%s)"):format(data.name, notificationType))
				end
			end
		end
	end

	return retVal
end

function Garrison:GetPlayerMissionCount(paramCharInfo, missionCount, missions)
	local now = time()

	local numMissionsPlayer = tableSize(missions)

	if numMissionsPlayer > 0 then
		missionCount.total = missionCount.total + numMissionsPlayer

		for missionID, missionData in pairs(missions) do
			local timeLeft = missionData.duration - (now - missionData.start)

			-- Do mission handling while we are at it
			if  (timeLeft < 0 and missionData.start == -1) then
				-- Detect completed mission


				-- Deprecated - should be detected on finished event
				local parsedTimeLeft = string.match(missionData.timeLeft, Garrison.COMPLETED_PATTERN)
				if (parsedTimeLeft == "0") then
					-- 1 * 0 found in string -> assuming mission complete
					missionData.start = 0
				end
			end

			-- Count
			if missionData.start > 0 then
				if (timeLeft <= 0) then
					missionCount.complete = missionCount.complete + 1
					missionData.statusComplete = true
				else
					if missionCount.nextTime == -1 or timeLeft < missionCount.nextTime then
						missionCount.nextTime = timeLeft
						missionCount.nextData = missionData
						missionCount.nextChar = paramCharInfo
					end					

					missionCount.inProgress = missionCount.inProgress + 1
				end
			else
				if missionData.start == 0 then
					missionCount.complete = missionCount.complete + 1
					missionData.statusComplete = true
				else
					missionCount.inProgress = missionCount.inProgress + 1
				end
			end

			missionData.missionState = missionData.statusComplete and Garrison.STATE_MISSION_COMPLETE or Garrison.STATE_MISSION_INPROGRESS

			missionData.timeLeftCalc = math.max(0, timeLeft)

			if (timeLeft < 0 and missionData.start >= 0) then
				Garrison:SendNotification(paramCharInfo, missionData, TYPE_MISSION)
			end
		end

	end
end


function Garrison:DoShipmentMagic(shipmentData, paramCharInfo)
	local now = time()

	local shipmentsReady, shipmentsInProgress, shipmentsAvailable
	local timeLeftNext = 0
	local timeLeftTotal = 0
	local shipmentsAvailable = shipmentData.shipmentCapacity

	if shipmentData and shipmentData.shipmentsTotal then
		local timeDiff = (now - shipmentData.creationTime)
		local shipmentsReadyByTime = 0
		if shipmentData.duration and shipmentData.duration > 0 then
			shipmentsReadyByTime = math.floor(timeDiff / shipmentData.duration)
		end

		--if isCurrentChar(paramCharInfo) then
		--	shipmentsReady = shipmentData.shipmentsReady
		--else
			-- Only for other chars
			shipmentsReady = math.min(shipmentData.shipmentsReady + shipmentsReadyByTime, shipmentData.shipmentsTotal)
		--end
		shipmentsInProgress = shipmentData.shipmentsTotal - shipmentsReady
		shipmentsAvailable = math.max(0, shipmentData.shipmentCapacity - shipmentData.shipmentsTotal) -- thanks blizzard, api returns total > capacity sometimes.

		timeLeftNext = shipmentData.duration - timeDiff

		if shipmentsInProgress == 0 then
			timeLeftNext = 0
		else
			timeLeftNext = timeLeftNext + (shipmentData.duration * shipmentsReadyByTime)
			timeLeftTotal = timeLeftNext + (shipmentData.duration * (shipmentsInProgress - 1))
		end

		return shipmentsReady, shipmentsInProgress, shipmentsAvailable, timeLeftNext, timeLeftTotal
	else
		return 0, 0, shipmentsAvailable, 0, 0
	end
end

function Garrison:GetPlayerBuildingCount(paramCharInfo, buildingCount, buildings)
	local now = time()

	local numBuildingsPlayer = tableSize(buildings)

	if numBuildingsPlayer > 0 then
		buildingCount.building.total = buildingCount.building.total + numBuildingsPlayer

		for plotID, buildingData in pairs(buildings) do

			if buildingData.isBuilding or buildingData.canActivate then
				-- Check for building complete
				local timeLeft = buildingData.buildTime - (now - buildingData.timeStart)

				if buildingData.canActivate or timeLeft < 0 then
					Garrison:SendNotification(paramCharInfo, buildingData, TYPE_BUILDING)
					buildingCount.building.complete = buildingCount.building.complete + 1
					buildingData.canActivate = true
					buildingData.buildingState = Garrison.STATE_BUILDING_COMPLETE
				else
					buildingCount.building.building = buildingCount.building.building + 1
					buildingData.buildingState = Garrison.STATE_BUILDING_BUILDING
				end	
			else
				buildingCount.building.active = buildingCount.building.active + 1
				buildingData.buildingState = Garrison.STATE_BUILDING_ACTIVE

				local shipmentData = buildingData.shipment

				-- Check for work orders
				if shipmentData and shipmentData.name and shipmentData.shipmentsTotal then

					local shipmentsReady, shipmentsInProgress, shipmentsAvailable, timeLeftNext = Garrison:DoShipmentMagic(shipmentData, paramCharInfo)

					shipmentData.shipmentsReadyEstimate = shipmentsReady
					shipmentData.shipmentsInProgress = shipmentsInProgress
					shipmentData.shipmentsAvailable = shipmentsAvailable

					if shipmentData.shipmentsReadyEstimate > 0 then						
						Garrison:SendNotification(paramCharInfo, shipmentData, TYPE_SHIPMENT)
					end

					if shipmentData.notificationValue and shipmentData.shipmentsReadyEstimate < shipmentData.notificationValue then
							shipmentData.notificationValue = shipmentData.shipmentsReadyEstimate
					end

					buildingCount.shipment.inProgress = buildingCount.shipment.inProgress + shipmentsInProgress
					buildingCount.shipment.ready = buildingCount.shipment.ready + shipmentsReady
					buildingCount.shipment.total = buildingCount.shipment.total + shipmentData.shipmentsTotal
					buildingCount.shipment.available = buildingCount.shipment.available + shipmentsAvailable

					if timeLeftNext > 0 and (buildingCount.shipment.nextTime == -1 or timeLeftNext < buildingCount.shipment.nextTime) then
						--debugPrint(("Update %s (%s)"):format(timeLeftNext, paramCharInfo.playerName))

						buildingCount.shipment.nextTime = timeLeftNext
						buildingCount.shipment.nextData = shipmentData
						buildingCount.shipment.nextChar = paramCharInfo
					end	
				elseif shipmentData and shipmentData.name then
					buildingCount.shipment.available = buildingCount.shipment.available + shipmentData.shipmentCapacity
				end
			end
		end
	end
end


function Garrison:GetMissionCount(paramCharInfo)
	local missionCount = {
		total = 0,
		inProgress = 0,
		complete = 0,
		nextTime = -1,
		nextName = nil,
		nextChar = nil,
	}
	local missionCountCurrent = nil

	if paramCharInfo then
		Garrison:GetPlayerMissionCount(paramCharInfo, missionCount, globalDb.data[paramCharInfo.realmName][paramCharInfo.playerName].missions)
		--missionCountCurrent = missionCount
	else
		Garrison:GetPlayerMissionCount(charInfo, missionCount, globalDb.data[charInfo.realmName][charInfo.playerName].missions)

		missionCountCurrent = Garrison.deepcopy(missionCount, nil)
		
		for realmName, realmData in pairs(globalDb.data) do
			for playerName, playerData in pairs(realmData) do
				if not Garrison.isCurrentChar(playerData.info) then
					Garrison:GetPlayerMissionCount(playerData.info, missionCount, playerData.missions)
				end
			end
		end
	end

	return missionCount, missionCountCurrent
end

function Garrison:GetBuildingCount(paramCharInfo)
	local buildingCount = {
		building = {
			total = 0,
			building = 0,
			complete = 0,
			active = 0,
		},		
		shipment = {
			inProgress = 0,
			ready = 0,
			total = 0,
			available = 0,
			nextTime = -1,
			nextName = nil,
			nextChar = nil,
		}	
	}
	local buildingCountCurrent


	if paramCharInfo then
		Garrison:GetPlayerBuildingCount(paramCharInfo, buildingCount, globalDb.data[paramCharInfo.realmName][paramCharInfo.playerName].buildings)		
		--buildingCountCurrent = buildingCount
	else
		Garrison:GetPlayerBuildingCount(charInfo, buildingCount, globalDb.data[charInfo.realmName][charInfo.playerName].buildings)		

		buildingCountCurrent = Garrison.deepcopy(buildingCount, nil)

		for realmName, realmData in pairs(globalDb.data) do
			for playerName, playerData in pairs(realmData) do
				if not Garrison.isCurrentChar(playerData.info) then
					Garrison:GetPlayerBuildingCount(playerData.info, buildingCount, playerData.buildings)
				end
			end
		end
	end

	return buildingCount, buildingCountCurrent
end


function Garrison:UpdateConfig()
	if GarrisonLandingPageMinimapButton then
		if GarrisonLandingPageMinimapButton:IsShown() then
			if configDb.general.hideGarrisonMinimapButton then
				GarrisonLandingPageMinimapButton:Hide()
			end
		else
			if not configDb.general.hideGarrisonMinimapButton then
				GarrisonLandingPageMinimapButton:Show()
			end
		end
	end
end

local updater

local DrawTooltip
do
	local NUM_TOOLTIP_COLUMNS = 5
	local tooltipRegistry = {}	
	local LDB_anchor
	local tooltipType
	local tooltip
	local locked = false
	local tooltipTypeNew

    local last_update = 0

    updater = _G.CreateFrame("Frame", nil, _G.UIParent)

	updater:SetScript("OnUpdate",
        function(self, elapsed)
            last_update = last_update + elapsed

            if last_update < 0.1 then
                return
            end

            --tooltipRegistry[TYPE_BUILDING].tooltip
           
            if tooltip and tooltipType then            	
            	--debugPrint("onupdate tooltip: "..tooltipType)
                if tooltip:IsMouseOver() or (LDB_anchor and LDB_anchor:IsMouseOver()) then                                   	
                	--debugPrint("mouseover")
                	self.elapsed = (self.elapsed or 0) + last_update

                    if (configDb.general.highAccuracy and self.elapsed >= 1) or self.elapsed > 30 then
                    	--debugPrint("redraw")
                    	self.elapsed = 0
                    	DrawTooltip(LDB_anchor, tooltipType)
                    end
                end
            end

            last_update = 0
        end)	

	local function ExpandButton_OnMouseUp(tooltip_cell, param, button)
		local realm_and_character, paramType = unpack(param)

		local realm, character_name = (":"):split(realm_and_character, 2)

		--debugPrint(LDB_anchor)

		if paramType == TYPE_MISSION then
			globalDb.data[realm][character_name].missionsExpanded = not globalDb.data[realm][character_name].missionsExpanded
		else
			globalDb.data[realm][character_name].buildingsExpanded = not globalDb.data[realm][character_name].buildingsExpanded
		end

		DrawTooltip(tooltipRegistry[paramType].anchor, paramType)
	end

	local function ExpandButton_OnMouseDown(tooltip_cell, param, button)
		--local is_expanded, paramType = unpack(param)

		--local line, column = tooltip_cell:GetPosition()
		--tooltip:SetCell(line, column, is_expanded and Garrison.ICON_CLOSE_DOWN or Garrison.ICON_OPEN_DOWN)
	end

	local function Tooltip_OnRelease_Mission(arg)
		tooltipRegistry[TYPE_MISSION].tooltip = nil
		tooltipRegistry[TYPE_MISSION].anchor = nil

		if tooltipType and tooltipType == TYPE_MISSION then
			LDB_anchor = nil
			tooltipType = nil
		elseif tooltipType and tooltipType == TYPE_BUILDING then
			debugPrint("OnReleaseDraw: "..tooltipType)
			DrawTooltip(LDB_anchor, tooltipType)
		end
	end

	local function Tooltip_OnRelease_Building(arg)
		tooltipRegistry[TYPE_BUILDING].tooltip = nil
		tooltipRegistry[TYPE_BUILDING].anchor = nil

		if tooltipType and tooltipType == TYPE_BUILDING then
			LDB_anchor = nil
			tooltipType = nil		
		elseif tooltipType and tooltipType == TYPE_MISSION then
			debugPrint("OnReleaseDraw: "..tooltipType)
			DrawTooltip(LDB_anchor, tooltipType)
		end
	end


	local function AddSeparator(tooltip)
		tooltip:AddSeparator(1, colors.lineGrey.r, colors.lineGrey.g, colors.lineGrey.b, colors.lineGrey.a)
	end

	local function AddRow(tooltip, ...)
		local color = ...
		local row = tooltip:AddLine(" ")
		if color then
			tooltip:SetLineColor(row, color.r, color.g, color.b, 1)
		end

		return row
	end

	local function AddEmptyRow(tooltip, ...)
		if not tooltipType or not configDb.general[tooltipType].compactTooltip then
			AddRow(tooltip, ...)
		end
	end

	function DrawTooltip(anchor_frame, paramTooltipType)
		if not anchor_frame then
			return
		end
		LDB_anchor = anchor_frame		

		if tooltipType ~= paramTooltipType then
			-- mission <> building switch
			debugPrint("Switched tooltip")
			tooltipTypeNew = paramTooltipType
		end

		tooltipType = paramTooltipType
		if not tooltipRegistry[tooltipType] then
			tooltipRegistry[tooltipType] = {}
		end

		tooltip	= tooltipRegistry[tooltipType].tooltip
		tooltipRegistry[tooltipType].anchor = LDB_anchor
		--LDB_anchor = tooltipRegistry[tooltipType].tooltip

		locked = true

		if not tooltip then
			tooltipRegistry[tooltipType].tooltip = LibQTip:Acquire("BrokerGarrisonTooltip-"..paramTooltipType, NUM_TOOLTIP_COLUMNS, "LEFT", "LEFT", "LEFT", "LEFT", "LEFT")
			tooltip = tooltipRegistry[tooltipType].tooltip

			if tooltipType == TYPE_MISSION then
				tooltip.OnRelease = Tooltip_OnRelease_Mission
			elseif tooltipType == TYPE_BUILDING then
				tooltip.OnRelease = Tooltip_OnRelease_Building
			end
			tooltip:EnableMouse(true)
			tooltip:SmartAnchorTo(anchor_frame)
			tooltip:SetAutoHideDelay(configDb.display.autoHideDelay or 0.25, LDB_anchor)
			tooltip:SetScale(configDb.display.scale or 1)
			tooltip:SetHighlightTexture(nil)
			local font = LSM:Fetch("font", configDb.display.fontName or DEFAULT_FONT)
			local fontSize = configDb.display.fontSize or 12
			local headerFontSize = fontSize + 2

			local tmpFont = CreateFont("BrokerGarrisonTooltipFont")
			tmpFont:SetFont(font, fontSize)

			local tmpHeaderFont = CreateFont("BrokerGarrisonTooltipHeaderFont")
			tmpHeaderFont:SetFont(font, headerFontSize)

			tooltip:SetFont(tmpFont)
			tooltip:SetHeaderFont(tmpHeaderFont)
		end

		local now = time()
		local name, row, realmName, realmData, playerName, playerData, missionID, missionData

		tooltip:Clear()
		tooltip:SetCellMarginH(0)

		tooltip:SetCellMarginV(0)

		local realmNum = 0

		if tooltipType == TYPE_MISSION then
			local sortOptions, groupBy = Garrison.getSortOptions(Garrison.TYPE_MISSION, "name")

			for realmName, realmData in pairsByKeys(globalDb.data) do
				realmNum = realmNum + 1

				-- Preview building/player count
				local playerCount = 0
				local missionCountTable = {}

				for playerName, playerData in pairsByKeys(realmData) do
					missionCountTable[playerName] = Garrison:GetMissionCount(playerData.info)

					if (playerData.tooltipEnabled == nil or playerData.tooltipEnabled) and (missionCountTable[playerName].total > 0 or (not configDb.general.mission.hideCharactersWithoutMissions)) then
						playerCount = playerCount + 1
					end
				end	

				if playerCount > 0 and not (configDb.general.mission.showOnlyCurrentRealm and realmName ~= charInfo.realmName) then

					row = tooltip:AddHeader()
					tooltip:SetCell(row, 1, ("%s"):format(getColoredString(("%s"):format(realmName), colors.lightGray)), nil, "LEFT", 3)

					AddEmptyRow(tooltip)
					AddSeparator(tooltip)

					for playerName, playerData in pairsByKeys(realmData) do
						--local missionCount = Garrison:GetMissionCount(playerData.info)
						local missionCount = missionCountTable[playerName]

						if playerData.tooltipEnabled == nil or playerData.tooltipEnabled 
							and (missionCount.total > 0 or (not configDb.general.mission.hideCharactersWithoutMissions)) then
							
							AddEmptyRow(tooltip)
							row = AddRow(tooltip)

							tooltip:SetCell(row, 1, playerData.missionsExpanded and Garrison.ICON_CLOSE or Garrison.ICON_OPEN)
							tooltip:SetCell(row, 2, ("%s"):format(getColoredUnitName(playerData.info.playerName, playerData.info.playerClass)))
							--tooltip:SetCell(row, 3, ("%s %s %s %s"):format(Garrison.ICON_CURRENCY, BreakUpLargeNumbers(playerData.currencyAmount or 0), Garrison.ICON_CURRENCY_APEXIS, BreakUpLargeNumbers(playerData.currencyApexisAmount or 0)))
							
								
							tooltip:SetCell(row, 3, getColoredString((L["In Progress: %s | Complete: %s | Total: %s"]):format(missionCount.inProgress, missionCount.complete, missionCount.total), colors.lightGray), nil, "RIGHT", 2)

						--	tooltip:SetCell(row, 4, getColoredString((L["Total: %s"]):format(missionCount.total), colors.lightGray))
							--tooltip:SetCell(row, 5, getColoredString((L["In Progress: %s"]):format(missionCount.inProgress), colors.lightGray))
							--tooltip:SetCell(row, 6, getColoredString((L["Complete: %s"]):format(missionCount.complete), colors.lightGray))

							tooltip:SetCellScript(row, 1, "OnMouseUp", ExpandButton_OnMouseUp, {("%s:%s"):format(realmName, playerName), Garrison.TYPE_MISSION})
							--tooltip:SetCellScript(row, 1, "OnMouseDown", ExpandButton_OnMouseDown, {playerData.missionsExpanded, Garrison.TYPE_MISSION})
							tooltip:SetCellScript(row, 2, "OnMouseUp", ExpandButton_OnMouseUp, {("%s:%s"):format(realmName, playerName), Garrison.TYPE_MISSION})
							--tooltip:SetCellScript(row, 2, "OnMouseDown", ExpandButton_OnMouseDown, {playerData.missionsExpanded, Garrison.TYPE_MISSION})

							AddEmptyRow(tooltip)
							AddSeparator(tooltip)

							if playerData.missionsExpanded and missionCount.total > 0 then

								AddEmptyRow(tooltip, colors.darkGray)

								--debugPrint(groupBy)
								local sortedMissionTable = Garrison.sort(playerData.missions, unpack(sortOptions))
								local lastGroupValue = nil

								for missionID, missionData in sortedMissionTable do

									if groupBy and #groupBy > 0 then
										local groupByValue = Garrison.getTableValue(missionData, unpack(groupBy))
										if lastGroupValue == nil then
											lastGroupValue = groupByValue
										else
											if lastGroupValue == groupByValue then
												-- OK
											else 
												AddEmptyRow(tooltip, colors.darkGray)
												AddSeparator(tooltip)
												AddEmptyRow(tooltip, colors.darkGray)

												lastGroupValue = groupByValue
											end
										end
									end


									--debugPrint(("%s: %s => %s"):format(missionData.name, groupByValue or '-', _G.tostring(isGrouped)))

									local timeLeft = missionData.duration - (now - missionData.start)

									row = AddRow(tooltip, colors.darkGray)

									if configDb.display.showIcon then
										tooltip:SetCell(row, 1, getIconString(missionData.typeAtlas, configDb.display.iconSize, true), nil, "LEFT", 1)
									end
									tooltip:SetCell(row, 2, missionData.name, nil, "LEFT", 2)

									if (missionData.start == -1) then
										local formattedTime = ("~%s %s"):format(
											missionData.timeLeft,
											getColoredString("("..formattedSeconds(missionData.duration)..")", colors.lightGray)
										)
										tooltip:SetCell(row, 4, formattedTime, nil, "RIGHT", 1)
									elseif (missionData.start == 0 or timeLeft < 0) then
										tooltip:SetCell(row, 4, getColoredString(L["Complete!"], colors.green), nil, "RIGHT", 1)
									else
										local formattedTime = ("%s %s"):format(
											formattedSeconds(timeLeft),
											getColoredString("("..formattedSeconds(missionData.duration)..")", colors.lightGray)
										)

										tooltip:SetCell(row, 4, formattedTime, nil, "RIGHT", 1)
									end

									if configDb.general.mission.showFollowers and missionData.followers and #missionData.followers > 0 then
										row = AddRow(tooltip, colors.darkGray)
										local followerString = ""
										for followerNum = 1, #missionData.followers do
											local followerData = missionData.followers[followerNum]

											followerString = followerString..("%s %s  "):format(Garrison.GetTextureForID(followerData.iconId, configDb.display.iconSize), followerData.name)
										end

										tooltip:SetCell(row, 2, getColoredString(followerString, colors.lightGray), nil, "LEFT", 3)
									end
								end

								AddEmptyRow(tooltip, colors.darkGray)

								AddSeparator(tooltip)
							end
						else
							debugPrint("Hide "..playerData.info.playerName)	
						end
					end
				else 
					debugPrint(("[%s]: No players for realm - hiding"):format(realmName))
				end
				AddEmptyRow(tooltip)
			end
		elseif tooltipType == TYPE_BUILDING then
			local sortOptions, groupBy = Garrison.getSortOptions(Garrison.TYPE_BUILDING, "name")			
			
			for realmName, realmData in pairsByKeys(globalDb.data) do
				realmNum = realmNum + 1

				local playerCount = 0

				-- Preview building/player count
				local buildingCountTable = {}

				for playerName, playerData in pairsByKeys(realmData) do
					buildingCountTable[playerName] = Garrison:GetBuildingCount(playerData.info)

					if playerData.tooltipEnabled == nil or playerData.tooltipEnabled and (buildingCountTable[playerName].building.total > 0) then
						playerCount = playerCount + 1
					end
				end

				if playerCount > 0 and not (configDb.general.building.showOnlyCurrentRealm and realmName ~= charInfo.realmName) then

					if realmNum > 1 then
						AddEmptyRow(tooltip)
					end

					row = tooltip:AddHeader()
					tooltip:SetCell(row, 1, ("%s"):format(getColoredString(("%s"):format(realmName), colors.lightGray)), nil, "LEFT", 4)

					AddEmptyRow(tooltip)
					AddSeparator(tooltip)

					for playerName, playerData in pairsByKeys(realmData) do

						--local buildingCount = Garrison:GetBuildingCount(playerData.info)
						local buildingCount = buildingCountTable[playerName]

						if playerData.tooltipEnabled == nil or playerData.tooltipEnabled and (buildingCount.building.total > 0) then
							playerCount = playerCount + 1 

							AddEmptyRow(tooltip)
							row = AddRow(tooltip)

							local estimatedCacheResourceAmount = ""

							local tmpResources = Garrison.getResourceFromTimestamp(playerData.garrisonCacheLastLooted, now)
							if tmpResources ~= nil and tmpResources >= 5 then
								local resourceColor = colors.lightGray

								if tmpResources >= 400 then
									resourceColor = colors.red
								end
								estimatedCacheResourceAmount = getColoredString((" (%s)"):format(math.min(500, tmpResources)), resourceColor)
							end

							tooltip:SetCell(row, 1, playerData.buildingsExpanded and Garrison.ICON_CLOSE or Garrison.ICON_OPEN, nil, "LEFT", 1, nil, 0, 0, 20, 20)
							tooltip:SetCell(row, 2, ("%s"):format(getColoredUnitName(playerData.info.playerName, playerData.info.playerClass)), nil, "LEFT", 3)
							tooltip:SetCell(row, 5, ("%s %s%s %s %s"):format(Garrison.ICON_CURRENCY_TOOLTIP, BreakUpLargeNumbers(playerData.currencyAmount or 0), estimatedCacheResourceAmount, Garrison.ICON_CURRENCY_APEXIS_TOOLTIP, BreakUpLargeNumbers(playerData.currencyApexisAmount or 0)), nil, "RIGHT", 1)

							tooltip:SetCellScript(row, 1, "OnMouseUp", ExpandButton_OnMouseUp, {("%s:%s"):format(realmName, playerName), Garrison.TYPE_BUILDING})
							--tooltip:SetCellScript(row, 1, "OnMouseDown", ExpandButton_OnMouseDown, {playerData.buildingsExpanded, Garrison.TYPE_BUILDING})
							tooltip:SetCellScript(row, 2, "OnMouseUp", ExpandButton_OnMouseUp, {("%s:%s"):format(realmName, playerName), Garrison.TYPE_BUILDING})
							--tooltip:SetCellScript(row, 2, "OnMouseDown", ExpandButton_OnMouseDown, {playerData.buildingsExpanded, Garrison.TYPE_BUILDING})							

							AddEmptyRow(tooltip)
							AddSeparator(tooltip)

							if not (playerData.buildingsExpanded) then
								

								local playerBuildingUpgrade = ("%s"):format(getColoredUnitName(playerData.info.playerName, playerData.info.playerClass))

								local formattedShipment = ""

								if (buildingCount.building.complete > 0 or buildingCount.building.building > 0) then
									local isBuildingIcon = ""
									local displayCount = 0
									if buildingCount.building.complete > 0 then
										isBuildingIcon = Garrison.ICON_ARROW_UP
										displayCount = "("..buildingCount.building.complete..")"
									else
										isBuildingIcon = Garrison.ICON_ARROW_UP_WAITING
										displayCount = "("..buildingCount.building.building..")"
									end

									--formattedShipment = formattedShipment..isBuildingIcon
									--tooltip:SetCell(row, 3, ("%s %s"):format(isBuildingIcon, getColoredString(displayCount, colors.lightGray)), nil, "LEFT", 1)
									playerBuildingUpgrade = playerBuildingUpgrade..("%s"):format(isBuildingIcon)
								end

								if (buildingCount.shipment.inProgress > 0 or buildingCount.shipment.ready > 0) then
									formattedShipment = formattedShipment..("%s/%s"):format(
										buildingCount.shipment.inProgress,
										getColoredString(buildingCount.shipment.ready, colors.green)

									)							
								end	

								tooltip:SetCell(row, 2, playerBuildingUpgrade, nil, "LEFT", 2)
								tooltip:SetCell(row, 4, formattedShipment, nil, "LEFT", 1)

							elseif playerData.buildingsExpanded and buildingCount.building.total > 0 then
								AddEmptyRow(tooltip, colors.darkGray)
								
								if not configDb.general.building.hideHeader then
									row = AddRow(tooltip, colors.darkGray)
									tooltip:SetCell(row, 4, getColoredString(L["SHIPMENT"], colors.lightGray), nil, "CENTER", 1)
									tooltip:SetCell(row, 5, getColoredString(L["TIME"], colors.lightGray), nil, "CENTER", 1)
									AddEmptyRow(tooltip, colors.darkGray)
								end

								local sortedBuildingTable = Garrison.sort(playerData.buildings, unpack(sortOptions))
								local lastGroupValue = nil
								--local sortedBuildingTable = Garrison.sort(playerData.buildings, "name,a")

								for plotID, buildingData in sortedBuildingTable do

									if not configDb.general.building.hideBuildingWithoutShipments or 
										(buildingData.isBuilding or buildingData.canActivate) or
										(buildingData.shipment and buildingData.shipment.shipmentCapacity) then 							

										if groupBy and #groupBy > 0 then
											local groupByValue = Garrison.getTableValue(buildingData, unpack(groupBy))
											

											if lastGroupValue == nil then
												lastGroupValue = groupByValue
											else
												if lastGroupValue == groupByValue then
													-- OK
												else 
													AddEmptyRow(tooltip, colors.darkGray)
													AddSeparator(tooltip)
													AddEmptyRow(tooltip, colors.darkGray)
													
													if not configDb.general.building.hideHeader then
														row = AddRow(tooltip, colors.darkGray)
														tooltip:SetCell(row, 4, getColoredString(L["SHIPMENT"], colors.lightGray), nil, "CENTER", 1)
														tooltip:SetCell(row, 5, getColoredString(L["TIME"], colors.lightGray), nil, "CENTER", 1)
														AddEmptyRow(tooltip, colors.darkGray)
													end

													lastGroupValue = groupByValue
												end
											end

											--debugPrint("groupBy: "..tostring(unpack(groupBy)))
											--debugPrint(("%s: %s => %s"):format(buildingData.name, groupByValue or '-', tostring(isGrouped)))
										end

										
										-- Display building and Workorder data								
										row = AddRow(tooltip, colors.darkGray)

										local timeLeftBuilding = 0
										if buildingData.isBuilding then
											timeLeftBuilding = buildingData.buildTime - (now - buildingData.timeStart)
										end

										local rank, buildingInfoIcon = "", ""
										if buildingData.isBuilding or buildingData.canActivate then									

											if (buildingData.isBuilding and timeLeftBuilding > 0) then
												buildingInfoIcon = Garrison.ICON_ARROW_UP_WAITING
											else
												buildingInfoIcon = Garrison.ICON_ARROW_UP
											end

											--debugPrint(("[%s] isBuilding: %s, timeLeftBuilding: %s"):format(buildingData.name, _G.tostring(buildingData.isBuilding), _G.tostring(timeLeftBuilding)))

											if buildingData.rank > 1 then
												rank = getColoredString("("..(buildingData.rank - 1)..")", colors.lightGray)
											else
												rank = ""
											end
										else
											rank = getColoredString("("..buildingData.rank..")", colors.lightGray)
										end

										buildingInfoIcon = buildingInfoIcon..Garrison:GetLootInfoForBuilding(playerData.lootedToday, buildingData.id)

										if configDb.display.showIcon then
											--tooltip:SetCell(row, 1, getIconString(, configDb.display.iconSize, false, false), nil, "LEFT", 1)

											tooltip:SetCell(row, 2, "", nil, "LEFT", 1, Garrison.iconProvider, 0, 0, nil, nil, Garrison.GetIconPath(buildingData.icon), configDb.display.iconSize)
										end

										tooltip:SetCell(row, 3, ("%s %s %s"):format(buildingData.name, rank, buildingInfoIcon), nil, "LEFT", 1)

										--tooltip:SetCell(row, 3, isBuildingIcon, nil, "LEFT", 1) 

										
										if buildingData.hasFollowerSlot then
											local followerTexture, iconSize									
											if buildingData.follower and buildingData.follower.followerName then
												followerTexture = buildingData.follower.portraitIconID
												iconSize = configDb.display.iconSize - 2
											else
												followerTexture = Garrison.ICON_PATH_FOLLOWER_NO_PORTRAIT
												iconSize = configDb.display.iconSize
											end

											tooltip:SetCell(row, 1, "", nil, "LEFT", 1, Garrison.iconProvider, 0, 0, nil, nil, followerTexture, iconSize)
										end

										if ((buildingData.isBuilding and timeLeftBuilding <= 0) or buildingData.canActivate) then
											tooltip:SetCell(row, 5, getColoredString(L["Can be activated"], colors.green), nil, "LEFT", 1)
										elseif buildingData.isBuilding then

											local formattedTime = ("%s %s"):format(
												formattedSeconds(timeLeftBuilding),
												getColoredString("("..formattedSeconds(buildingData.buildTime)..")", colors.lightGray)
											)

											tooltip:SetCell(row, 5, formattedTime, nil, "LEFT", 1)

										elseif buildingData.shipment and buildingData.shipment.name then
											local shipmentData = buildingData.shipment

											local shipmentsReady, shipmentsInProgress, shipmentsAvailable, timeLeftNext, timeLeftTotal = Garrison:DoShipmentMagic(shipmentData, playerData.info)

											if shipmentData.shipmentCapacity then											
												if shipmentsInProgress <= math.ceil(shipmentData.shipmentCapacity * 0.15) then
													shipmentsInProgress = getColoredString(shipmentsInProgress, colors.red)
												elseif shipmentsInProgress <= math.ceil(shipmentData.shipmentCapacity * 0.3) then
													shipmentsInProgress = getColoredString(shipmentsInProgress, colors.yellow)
												end
											end

											local formattedShipment = ("%s/%s %s"):format(
												shipmentsInProgress,
												getColoredString(shipmentsReady, shipmentsReady == 0 and colors.white or colors.green),
												getColoredString("("..shipmentsAvailable..")", colors.lightGray)
												)


											tooltip:SetCell(row, 4, formattedShipment, nil, "LEFT", 1)

											if timeLeftNext > 0 and timeLeftTotal > 0 then
												local formattedTime = ("%s %s"):format(
													formattedSeconds(timeLeftNext),
													getColoredString("("..formattedSeconds(timeLeftTotal)..")", colors.lightGray)
												)

												tooltip:SetCell(row, 5, formattedTime, nil, "LEFT", 1)
											end


										else
											tooltip:SetCell(row, 4, "-", nil, "LEFT", 1)
										end

									end					
								end
							
								AddEmptyRow(tooltip, colors.darkGray)
								AddSeparator(tooltip)
							end
						else
							debugPrint("Hide "..playerData.info.playerName)
						end
					end
				else --playerCount <= 0
					debugPrint(("[%s]: No players for realm - hiding"):format(realmName))
				end 
			end
			AddEmptyRow(tooltip)
		end

		--debugPrint(("r: %s, g: %s, b: %s, a: %s"):format(configDb.display.backgroundColor.r, configDb.display.backgroundColor.g, configDb.display.backgroundColor.b, configDb.display.backgroundColor.a))

	  	tooltip:SetBackdropColor(0, 0, 0, 255 / configDb.display.backgroundAlpha)
	  	tooltip:Show()

	  	tooltip:UpdateScrolling()

	  	locked = false
	end

	function ldb_object_building:OnEnter()
		DrawTooltip(self, TYPE_BUILDING)
	end

	function ldb_object_building:OnLeave()
		--updater.elapsed = 0
	end

	function ldb_object_mission:OnEnter()
		DrawTooltip(self, TYPE_MISSION)
	end

	local function onclick(button)
		if button == "LeftButton" then
			Garrison:LoadDependencies()

			if GarrisonLandingPage then
				if (not GarrisonLandingPage:IsShown()) then
					ShowUIPanel(GarrisonLandingPage)
				else
					HideUIPanel(GarrisonLandingPage)
				end
			end
		else
			for i, button in ipairs(InterfaceOptionsFrameAddOns.buttons) do
				if button.element and button.element.name == ADDON_NAME and button.element.collapsed then
					OptionsListButtonToggle_OnClick(button.toggle)
				end
			end
			if AceConfigDialog.OpenFrames[ADDON_NAME] then
				AceConfigDialog:Close(ADDON_NAME)
			else
				AceConfigDialog:Open(ADDON_NAME)
			end
		end
	end

	function ldb_object_mission:OnClick(button)
		onclick(button)
	end

	function ldb_object_building:OnClick(button)
		onclick(button)
	end
end


function Garrison:UpdateUnknownMissions(missionsLoaded)
	local activeMissions = {}

	for key,garrisonMission in pairs(C_Garrison.GetInProgressMissions()) do
		activeMissions[garrisonMission.missionID] = true
		-- Mission not found in Database
		if not globalDb.data[charInfo.realmName][charInfo.playerName].missions[garrisonMission.missionID]
			or globalDb.data[charInfo.realmName][charInfo.playerName].missions[garrisonMission.missionID].start == -1 then
			local mission = {
				id = garrisonMission.missionID,
				name = garrisonMission.name,
				start = -1,
				duration = garrisonMission.durationSeconds,
				notification = 0,
				timeLeft = garrisonMission.timeLeft,
				type = garrisonMission.type,
				typeAtlas = garrisonMission.typeAtlas,
				level = garrisonMission.level,
			}
			globalDb.data[charInfo.realmName][charInfo.playerName].missions[garrisonMission.missionID] = mission

			-- debugPrint("Update untracked Mission: "..garrisonMission.missionID)
		end
	end

	if missionsLoaded then
		-- cleanup unknown missions
		local missionID
		for missionID, _ in pairs(globalDb.data[charInfo.realmName][charInfo.playerName].missions) do
			if not activeMissions[missionID] then
				globalDb.data[charInfo.realmName][charInfo.playerName].missions[missionID] = nil
				debugPrint("Removed unknown Mission: "..missionID)
			end
		end
	end

	for key,garrisonMission in pairs(C_Garrison.GetCompleteMissions()) do
		if (globalDb.data[charInfo.realmName][charInfo.playerName].missions[garrisonMission.missionID]) then
			if globalDb.data[charInfo.realmName][charInfo.playerName].missions[garrisonMission.missionID].start ~= 0 then
				debugPrint("Finished Mission (Loop): "..garrisonMission.missionID)
				globalDb.data[charInfo.realmName][charInfo.playerName].missions[garrisonMission.missionID].start = 0
			end
		else
			debugPrint("Unknown Mission (Loop): "..garrisonMission.missionID)
		end
	end

end


function Garrison:Update()
	Garrison:FullUpdateBuilding(TYPE_SHIPMENT)

	Garrison:UpdateUnknownMissions(false)

	Garrison:UpdateLDB()

	-- First update
	if delayedInit then
		addonInitialized = true
	end
end

function Garrison:UpdateLDB()
	-- LDB Text
	local missionCount, missionCountCurrent = Garrison:GetMissionCount(nil)
	local buildingCount, buildingCountCurrent = Garrison:GetBuildingCount(nil)	

	local currencyTotal, currencyAmount = 0, 0
	local currencyApexisAmount, currencyApexisTotal = 0, 0

	local resourceCacheAmount, resourceCacheAmountMax = 0, 0
	local resourceCacheAmountMaxChar = nil

	local now = time()

	for realmName, realmData in pairs(globalDb.data) do
		for playerName, playerData in pairs(realmData) do
			local tmpResourceCacheAmount = Garrison.getResourceFromTimestamp(playerData.garrisonCacheLastLooted, now)

			if Garrison.isCurrentChar(playerData.info) then
				currencyAmount = (playerData.currencyAmount or 0)
				currencyApexisAmount = playerData.currencyApexisAmount or 0
				
				resourceCacheAmount = tmpResourceCacheAmount or 0
			end
			currencyTotal = currencyTotal + (playerData.currencyAmount or 0)
			currencyApexisTotal = currencyApexisTotal + (playerData.currencyApexisAmount or 0)

			
			if tmpResourceCacheAmount then
				if tmpResourceCacheAmount > resourceCacheAmountMax then
					resourceCacheAmountMax = tmpResourceCacheAmount
					resourceCacheAmountMaxChar = playerData.info
				end
				--resourceCacheAmountMax = math.max(resourceCacheAmountMax, tmpResourceCacheAmount)

			end
		end
	end

	local data = {
		missionCount = missionCount,
		buildingCount = buildingCount,
		missionCountCurrent = missionCountCurrent,
		buildingCountCurrent = buildingCountCurrent,		
		currencyAmount = currencyAmount,
		currencyApexisAmount = currencyApexisAmount,
		currencyApexisTotal = currencyApexisTotal,
		currencyTotal = currencyTotal,
		currencyIcon = Garrison.ICON_CURRENCY,
		currencyApexisIcon = Garrison.ICON_CURRENCY_APEXIS,

		resourceCacheAmountMax = resourceCacheAmountMax,
		resourceCacheAmountMaxChar = resourceCacheAmountMaxChar,
		resourceCacheAmount = resourceCacheAmount,
	}


	ldb_object_mission.text = Garrison.replaceVariables(Garrison:GetLDBText(Garrison.TYPE_MISSION), data)
	ldb_object_mission.label = configDb.general.mission.ldbLabelText

	ldb_object_building.text = Garrison.replaceVariables(Garrison:GetLDBText(Garrison.TYPE_BUILDING), data)
	ldb_object_building.label = configDb.general.building.ldbLabelText

end


function Garrison:OnInitialize()
	garrisonDb = LibStub("AceDB-3.0"):New(ADDON_NAME .. "DB", DB_DEFAULTS, true)
	globalDb = garrisonDb.global
	configDb = garrisonDb.profile

	self.DB = garrisonDb

	-- Data migration
	if _G.Broker_GarrisonDB.data then
		globalDb.data = _G.Broker_GarrisonDB.data
		_G.Broker_GarrisonDB.data = nil
	end

	-- DB
	if not globalDb.data[charInfo.realmName] then
		globalDb.data[charInfo.realmName] = {}
	end

	if (not globalDb.data[charInfo.realmName][charInfo.playerName]) then
		globalDb.data[charInfo.realmName][charInfo.playerName] = {
			missions = {},
			buildings = {},
			missionsExpanded = true,
			buildingsExpanded = true,
			info = charInfo,
			currencyAmount = 0,
			tooltipEnabled = true,
			notificationEnabled = true,
		}
	end

	if (not globalDb.data[charInfo.realmName][charInfo.playerName]["missions"]) then
		globalDb.data[charInfo.realmName][charInfo.playerName]["missions"] = {}
	end
	if (not globalDb.data[charInfo.realmName][charInfo.playerName]["buildings"]) then
		globalDb.data[charInfo.realmName][charInfo.playerName]["buildings"] = {}
	end

	-- Upgrade Code, 1 => 2
	if not globalDb.data[charInfo.realmName][charInfo.playerName].configVersion then
		globalDb.data[charInfo.realmName][charInfo.playerName].configVersion = CONFIG_VERSION

		globalDb.data[charInfo.realmName][charInfo.playerName].tooltipEnabled = true
		globalDb.data[charInfo.realmName][charInfo.playerName].notificationEnabled = true
	end

	self:InitHelper()
	self:InitEvent()

	-- Assign functions
	debugPrint, pairsByKeys, formatRealmPlayer, tableSize = Garrison.debugPrint, Garrison.pairsByKeys, Garrison.formatRealmPlayer, Garrison.tableSize
	getColoredString, getColoredUnitName, formattedSeconds  = Garrison.getColoredString, Garrison.getColoredUnitName, Garrison.formattedSeconds
	getIconString = Garrison.getIconString

	colors = Garrison.colors

	self:SetupOptions()

	Garrison:SetSinkStorage(configDb.notification.sink)

	Toast:Register(TOAST_MISSION_COMPLETE, toastMissionComplete)
	Toast:Register(TOAST_BUILDING_COMPLETE, toastBuildingComplete)
	Toast:Register(TOAST_SHIPMENT_COMPLETE, toastShipmentComplete)

	Garrison:UpdateConfig()

	self:RegisterEvent("GARRISON_MISSION_STARTED", "GARRISON_MISSION_STARTED")
	self:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE", "GARRISON_MISSION_COMPLETE_RESPONSE")
	self:RegisterEvent("GARRISON_MISSION_FINISHED", "GARRISON_MISSION_FINISHED")

	self:RegisterEvent("GARRISON_SHOW_LANDING_PAGE", "GARRISON_SHOW_LANDING_PAGE")
	self:RegisterEvent("GARRISON_MISSION_NPC_OPENED", "GARRISON_MISSION_NPC_OPENED")

	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneUpdate")
	self:RegisterEvent("ZONE_CHANGED", "ZoneUpdate")

	self:RegisterEvent("ADDON_LOADED", "CheckAddonLoaded")
	--self:RegisterEvent("VIGNETTE_REMOVED", "VignetteEvent")
	--self:RegisterEvent("VIGNETTE_ADDED", "VignetteEvent")	
	self:RegisterEvent("SHOW_LOOT_TOAST", "LootToastEvent")
	self:RegisterEvent("CHAT_MSG_LOOT", "ChatLootEvent")

	self:RawHook("GarrisonMissionAlertFrame_ShowAlert", true)
	self:RawHook("GarrisonBuildingAlertFrame_ShowAlert", true)

	self:RawHook("GarrisonMinimapBuilding_ShowPulse", true)
	self:RawHook("GarrisonMinimapShipmentCreated_ShowPulse", true)
	self:RawHook("GarrisonMinimapMission_ShowPulse", true)			

	timers.init_update = Garrison:ScheduleTimer("DelayedUpdate", 5)	

	ldb_object_mission.icon = Garrison.ICON_PATH_MISSION
	ldb_object_building.icon = Garrison.ICON_PATH_BUILDING

	-- collapse other characters (if option is enabled)
	for realmName, realmData in pairs(globalDb.data) do
		for playerName, playerData in pairs(realmData) do
			local isCurrentChar = Garrison.isCurrentChar(playerData.info)
			if configDb.general.building.collapseOtherCharsOnLogin then
				playerData.buildingsExpanded = isCurrentChar
			end
			if configDb.general.mission.collapseOtherCharsOnLogin then
				playerData.missionsExpanded = isCurrentChar
			end
		end
	end	

end

function Garrison:DelayedUpdate()
	Garrison:LoadDependencies()

	delayedInit = true
	Garrison:UpdateCurrency()	
	Garrison:UpdateLocation()

	--self:RegisterEvent("SHIPMENT_CRAFTER_CLOSED", "ShipmentUpdate")
	self:RegisterEvent("CURRENCY_DISPLAY_UPDATE", "UpdateCurrency")

end
