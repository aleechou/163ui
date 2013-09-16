--[[
Copyright (c) 2009-2012, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.
]]

local Mapster = LibStub("AceAddon-3.0"):GetAddon("Mapster")
local L = LibStub("AceLocale-3.0"):GetLocale("Mapster")

local MODNAME = "InstanceMaps"
local Maps = Mapster:NewModule(MODNAME, "AceHook-3.0")

local wowMoP
do
	local _, _, _, interface = GetBuildInfo()
	wowMoP = (interface >= 50000)
end

-- Data mostly from http://www.wowwiki.com/API_SetMapByID
local data = {
	-- Northrend Instances
	instances = {
		classic = {
			["Ragefire Chasm"] = 680,
			["Zul'Farrak"] = 686,
			["The Temple of Atal'Hakkar"] = 687,
			["Blackfathom Deeps"] = 688,
			["The Stockade"] = 690,
			["Gnomeregan"] = 691,
			["Uldaman"] = 692,
			["Dire Maul"] = 699,
			["Blackrock Depths"] = 704,
			["Blackrock Spire"] = 721,
			["Wailing Caverns"] = 749,
			["Maraudon"] = 750,
			["The Deadmines"] = 756,
			["Razorfen Downs"] = 760,
			["Razorfen Kraul"] = 761,
			["Scarlet Halls"] = 871,
			["Scarlet Monastery"] = 874,
			["Scholomance"] = 898,
			["Shadowfang Keep"] = 764,
			["Stratholme"] = 765,
		},
		bc = {
			["The Shattered Halls"] = 710,
			["Auchenai Crypts"] = 722,
			["Sethekk Halls"] = 723,
			["Shadow Labyrinth"] = 724,
			["The Blood Furnace"] = 725,
			["The Underbog"] = 726,
			["The Steamvault"] = 727,
			["The Slave Pens"] = 728,
			["The Botanica"] = 729,
			["The Mechanar"] = 730,
			["The Arcatraz"] = 731,
			["Mana-Tombs"] = 732,
			["The Black Morass"] = 733,
			["Old Hillsbrad Foothills"] = 734,
			["Hellfire Ramparts"] = 797,
			["Magisters' Terrace"] = 798,
		},
		wrath = {
			["The Nexus"] = 520,
			["The Culling of Stratholme"] = 521,
			["Ahn'kahet: The Old Kingdom"] = 522,
			["Utgarde Keep"] = 523,
			["Utgarde Pinnacle"] = 524,
			["Halls of Lightning"] = 525,
			["Halls of Stone"] = 526,
			["The Oculus"] = 528,
			["Gundrak"] = 530,
			["Azjol-Nerub"] = 533,
			["Drak'Tharon Keep"] = 534,
			["The Violet Hold"] = 536,
			["Trial of the Champion"] = 542,
			["The Forge of Souls"] = 601,
			["Pit of Saron"] = 602,
			["Halls of Reflection"] = 603,
		},
		cataclysm = {
			["Lost City of the Tol'vir"] = 747,
			["Blackrock Caverns"] = 753,
			["The Deadmines"] = 756,
			["Grim Batol"] = 757,
			["Halls of Origination"] = 759,
			["Shadowfang Keep"] = 764,
			["Throne of the Tides"] = 767,
			["The Stonecore"] = 768,
			["The Vortex Pinnacle"] = 769,
			["Zul'Aman"] = 781,
			["Zul'Gurub"] = 793,
			["Well of Eternity"] = 816,
			["Hour of Twilight"] = 819,
			["End Time"] = 820,
		},
		pandaria = {
			["Temple of the Jade Serpent"] = 867,
			["Stormstout Brewery"] = 876,
			["Mogu'Shan Palace"] = 885,
			["Shado-pan Monastery"] = 877,
			["Gate of the Setting Sun"] = 875,
			["Siege of Niuzao Temple"] = 887,
			["Scarlet Halls"] = 871,
			["Scarlet Monastery"] = 874,
			["Scholomance"] = 898,
		},
	},
	-- Northrend Raids
	raids = {
		classic = {
			["Molten Core"] = 696,
			["Blackwing Lair"] = 755,
			["Ruins of Ahn'Qiraj"] = 717,
			["Ahn'Qiraj"] = 766,
		},
		bc = {
			["Hyjal Summit"] = 775,
			["Gruul's Lair"] = 776,
			["Magtheridon's Lair"] = 779,
			["Serpentshrine Cavern"] = 780,
			["The Eye"] = 782,
			["Sunwell Plateau"] = 789,
			["Black Temple"] = 796,
			["Karazhan"] = 799,
		},
		wrath = {
			["The Eye of Eternity"] = 527,
			["Ulduar"] = 529,
			["The Obsidian Sanctum"] = 531,
			["Vault of Archavon"] = 532,
			["Naxxramas"] = 535,
			["Trial of the Crusader"] = 543,
			["Icecrown Citadel"] = 604,
			["The Ruby Sanctum"] = 609,
			["Onyxia's Lair"] = 718,
		},
		cataclysm = {
			["Baradin Hold"] = 752,
			["Blackwing Descent"] = 754,
			["The Bastion of Twilight"] = 758,
			["Throne of the Four Winds"] = 773,
			["Firelands"] = 800,
			["Dragon Soul"] = 824,
		},
		pandaria = {
			["Terrace of Endless Spring"] = 886,
			["Mogu'shan Vaults"] = 896,
			["Heart of Fear"] = 897,
			["Throne of Thunder"] = 930,
		},
	},
	bgs = {
		all = {
			["Alterac Valley"] = 401,
			["Warsong Gulch"] = 443,
			["Arathi Basin"] = 461,
			["Eye of the Storm"] = 482,
			["Strand of the Ancients"] = 512,
			["Isle of Conquest"] = 540,
			["Twin Peaks"] = 626,
			["The Battle for Gilneas"] = 736,
			["Temple of Kotmogu"] = 856,
			["Silvershard Mines"] = 860,
		},
	}
}

--[[
local db
local defaults = {
	profile = {
	}
}
]]

local options
local function getOptions()
	if not options then
		options = {
			type = "group",
			name = L["Instance Maps"],
			arg = MODNAME,
			args = {
				intro = {
					order = 1,
					type = "description",
					name = L["The Instance Maps module allows you to view the Instance and Battleground Maps provided by the game without being in the instance yourself."],
				},
				enabled = {
					order = 2,
					type = "toggle",
					name = L["Enable Instance Maps"],
					get = function() return Mapster:GetModuleEnabled(MODNAME) end,
					set = function(info, value) Mapster:SetModuleEnabled(MODNAME, value) end,
				},
			},
		}
	end

	return options
end

local zoomOverride

function Maps:OnInitialize()
	--[[
	self.db = Mapster.db:RegisterNamespace(MODNAME, defaults)
	db = self.db.profile
	]]

	self:SetEnabledState(Mapster:GetModuleEnabled(MODNAME))
	Mapster:RegisterModuleOptions(MODNAME, getOptions, L["Instance Maps"])

	self.zone_names = {}
	self.zone_data = {}

	for category, catdata in pairs(data) do
		for subcat, subdata in pairs(catdata) do
			local name_data = {}
			local key = format("%s|%s", category, subcat)
			self.zone_names[key], self.zone_data[key] = {}, {}
			for name, id in pairs(subdata) do
				local zonename = GetMapNameByID(id)
				if not zonename then
					zonename = name .. "*" -- mark them, so they can be found and fixed!
				end
				tinsert(self.zone_names[key], zonename)
				name_data[zonename] = id
			end
			table.sort(self.zone_names[key])
			for index, name in pairs(self.zone_names[key]) do
				self.zone_data[key][index] = name_data[name]
			end
		end
	end

	data = nil
end

function Maps:OnEnable()
	self:SecureHook("WorldMapContinentsDropDown_Update")
	self:SecureHook("WorldMapFrame_LoadContinents")

	self:SecureHook("WorldMapZoneDropDown_Update")
	self:RawHook("WorldMapZoneDropDown_Initialize", true)
	
	self:SecureHook("SetMapZoom")
	self:SecureHook("SetMapToCurrentZone", "SetMapZoom")
end

function Maps:OnDisable()
	self:UnhookAll()
	self.mapCont, self.mapContId, self.mapZone = nil, nil, nil
	WorldMapContinentsDropDown_Update()
	WorldMapZoneDropDown_Update()
end

function Maps:GetZoneData()
	return self.zone_data[self.mapCont][self.mapZone]
end

function Maps:WorldMapContinentsDropDown_Update()
	if self.mapCont then
		UIDropDownMenu_SetSelectedID(WorldMapContinentDropDown, self.mapContId)
	end
end

local function MapsterContinentButton_OnClick(frame)
	UIDropDownMenu_SetSelectedID(WorldMapContinentDropDown, frame:GetID())
	Maps.mapCont = frame.arg1
	Maps.mapContId = frame:GetID()
	zoomOverride = true
	SetMapZoom(-1)
	zoomOverride = nil
end

function Maps:WorldMapFrame_LoadContinents()
	local info = UIDropDownMenu_CreateInfo()
	info.text =  L["Classic Instances"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "instances|classic"
	UIDropDownMenu_AddButton(info)

	info.text =  L["Classic Raids"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "raids|classic"
	UIDropDownMenu_AddButton(info)

	info.text =  L["Burning Crusade Instances"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "instances|bc"
	UIDropDownMenu_AddButton(info)

	info.text =  L["Burning Crusade Raids"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "raids|bc"
	UIDropDownMenu_AddButton(info)

	info.text =  L["Wrath Instances"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "instances|wrath"
	UIDropDownMenu_AddButton(info)

	info.text =  L["Wrath Raids"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "raids|wrath"
	UIDropDownMenu_AddButton(info)

	info.text =  L["Cataclysm Instances"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "instances|cataclysm"
	UIDropDownMenu_AddButton(info)

	info.text =  L["Cataclysm Raids"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "raids|cataclysm"
	UIDropDownMenu_AddButton(info)

if wowMoP then
	info.text =  L["Pandaria Instances"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "instances|pandaria"
	UIDropDownMenu_AddButton(info)

	info.text =  L["Pandaria Raids"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "raids|pandaria"
	UIDropDownMenu_AddButton(info)
end

	info.text =  L["Battlegrounds"]
	info.func = MapsterContinentButton_OnClick
	info.checked = nil
	info.arg1 = "bgs|all"
	UIDropDownMenu_AddButton(info)
end

function Maps:WorldMapZoneDropDown_Update()
	if self.mapZone then
		UIDropDownMenu_SetSelectedID(WorldMapZoneDropDown, self.mapZone)
	end
end

local function MapsterZoneButton_OnClick(frame)
	UIDropDownMenu_SetSelectedID(WorldMapZoneDropDown, frame:GetID())
	Maps.mapZone = frame:GetID()
	SetMapByID(Maps:GetZoneData())
end

do
	local function Mapster_LoadCustomZones(data)
		local info = UIDropDownMenu_CreateInfo()
		for i=1, #data, 1 do
			info.text = data[i]
			info.func = MapsterZoneButton_OnClick
			info.checked = nil
			UIDropDownMenu_AddButton(info)
		end
	end

	local function Mapster_LoadDefaultZones(data)
		local info = UIDropDownMenu_CreateInfo()
		for i=1, #data, 1 do
			info.text = data[i]
			info.func = WorldMapZoneButton_OnClick
			info.checked = nil
			UIDropDownMenu_AddButton(info)
		end
	end

	local defaultZoneCache = setmetatable({}, {__index = function(t, k)
		rawset(t, k, {GetMapZones(k)})
		return t[k]
	end})

	function Maps:WorldMapZoneDropDown_Initialize()
		if self.mapCont then
			Mapster_LoadCustomZones(self.zone_names[self.mapCont])
		else
			Mapster_LoadDefaultZones(defaultZoneCache[GetCurrentMapContinent()])
		end
	end
end

function Maps:SetMapZoom()
	if not zoomOverride then
		self.mapCont, self.mapContId, self.mapZone = nil, nil, nil
	end
end
