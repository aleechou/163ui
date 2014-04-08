-- Broker_Group : A Data Broker port of "GroupFu" (Rabbit)
-- Special thanks to sayclub for Korean localization
-- Embed & stuff, create DO etc...
local BRGroup = CreateFrame("Frame", "Broker_Group")
local Deformat = LibStub("LibDeformat-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Broker_Group", true)
BRGroup.obj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Broker Group", {type = "data source", label = "组队与掷骰", icon = "Interface\\Buttons\\UI-GroupLoot-Dice-Up", text = "|cff9d9d9d" .. L["Solo"].."|r"})
LibStub("AceTimer-3.0"):Embed(BRGroup)

BRGroup:RegisterEvent("ADDON_LOADED")
BRGroup:RegisterEvent("PLAYER_ENTERING_WORLD")
BRGroup:RegisterEvent("PLAYER_LOGIN")
BRGroup:RegisterEvent("CHAT_MSG_SYSTEM")
BRGroup:RegisterEvent("GROUP_ROSTER_UPDATE")
BRGroup:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")

BRGroup:SetScript("OnEvent", function(_, event, ...)
	BRGroup[event](BRGroup, ...)
end)

-- local variables go here

local _G = getfenv(0)

local hexColors = { WTF = "|cffa0a0a0" }
for k, v in pairs(_G["RAID_CLASS_COLORS"]) do
	hexColors[k] = "|cff" .. string.format("%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
end
local coloredName = setmetatable({}, {__index =
	function(self, key)
		if type(key) == "nil" then return nil end
		local class = select(2, UnitClass(key)) or "WTF"
		self[key] = hexColors[class]  .. key .. "|r"
		return self[key]
	end
})

local shortdifftable = {
[_G["DUNGEON_DIFFICULTY1"]] = L["5 N"],
[_G["DUNGEON_DIFFICULTY2"]] = L["5 H"],
[_G["RAID_DIFFICULTY1"]] = L["10 N"],
[_G["RAID_DIFFICULTY2"]] = L["25 N"],
[_G["RAID_DIFFICULTY3"]] = L["10 H"],
[_G["RAID_DIFFICULTY4"]] = L["25 H"]
}

local rollers = nil
local lastAnnouncement = nil

local currentMin = 0
local currentMax = 0
local BRAnnounce = nil
local BRTimeout = nil

-- Ace config table

local options = {
	name = "Broker Group",
	type = "group",
	args = {
	confdesc = {
			order = 1,
			type = "description",
			name = L["Minimalistic LDB plugin to track down rolls and perform basic loot functions."].."\n",
			cmdHidden = true
		},
		optoutofloot = {
			order = 12, type = "toggle",
			name = L["Pass on random loot"],
			desc = L["Enable this setting to auto-pass on random loot."],
			get = function() return GetOptOutOfLoot() end,
			set = function(_,v) SetOptOutOfLoot(v) end,
			disabled = function()
                local inParty = 0;
                if(IsInGroup() and not IsInRaid()) then
                    inParty = 1
                end
				-- if (UnitExists("party1") or GetNumRaidMembers() > 0) then
				-- 	inParty = 1;
				-- end
				if inParty == 0 or ( inParty == 1 and GetLootMethod() == "freeforall" ) then
					return true
				end
			 return false
			end,
		},
		standard = {
			order = 13, type = "toggle", width = "full",
			name = L["Only accept 1-100"],
			desc = L["Accept standard (1-100) rolls only."],
			get = function() return Broker_GroupConfig.StandardRollsOnly end,
			set = function(_,v) Broker_GroupConfig.StandardRollsOnly = v end,
		},
		click = {
			order = 14, type = "toggle", width = "full",
			name = L["Perform roll when clicked"],
			desc = L["Perform a standard 1-100 roll when the plugin is clicked."],
			get = function() return Broker_GroupConfig.RollOnClick end,
			set = function(_,v) Broker_GroupConfig.RollOnClick = v end,			
		},
		announcelocation = {
			order = 2, type = "select",
			name = L["Announce"],
			desc = L["Where to output roll results."],
			get = function() return Broker_GroupConfig.OutputChannel end,
			set = function(_,v) Broker_GroupConfig.OutputChannel = v end,
			values = {
				["AUTO"] = L["Auto (based on group)"],
				["LOCAL"] = L["Local"],
				["SAY"] = L["Say"],
				["PARTY"] = L["Party"],
				["RAID"] = L["Raid"],
				["GUILD"] = L["Guild"],
				["OFF"] = L["Don't announce"],
			}
		},
		rollclearing = {
			order = 3, type = "select",
			name = L["Roll clearing"],
			desc = L["When to clear the rolls."],
			get = function() return Broker_GroupConfig.ClearTimer end,
			set = function(_,v) Broker_GroupConfig.ClearTimer = v end,
			values = {
				["0"] = L["Never"],
				["10"] = L["10 seconds"],
				["15"] = L["15 seconds"],
				["30"] = L["30 seconds"],
				["45"] = L["45 seconds"],
				["60"] = L["60 seconds"]
			},
		},
		loottype = {
			order = 4, type = "select",
			name = L["Loot method"],
			desc = L["Set the loot type."],			
			get = function() return Broker_GroupConfig.LootMethod end,
			set = function(_,v)
			  Broker_GroupConfig.LootMethod = v
				if v == "master" then
					SetLootMethod(v, UnitName("player"))
				else
					SetLootMethod(v)
				end				
			end,
			values = {
				["group"] = L["group"],
				["master"] = L["master"],
				["freeforall"] = L["freeforall"],
				["roundrobin"] = L["roundrobin"],
				["needbeforegreed"] = L["needbeforegreed"],
			},
			disabled = function()
                if(IsInGroup() and (UnitIsGroupAssistant'player' or UnitIsGroupLeader'player')) then
                    return false
                else
                    return true
                end
				-- if (UnitExists("party1") or GetNumRaidMembers() > 0) and (IsPartyLeader() or IsRaidLeader()) then
				-- 	return false
				-- end
				-- return true
			end,
		},
		lootthreshold = {
			order = 5, type = "select",
			name = L["Loot threshold"],
			desc = L["Set the loot threshold."],			
			get = function() return Broker_GroupConfig.LootThreshold end,
			set = function(_,v)
			  Broker_GroupConfig.LootThreshold = v
				SetLootThreshold(tonumber(v))				
			end,
			values = {
				["2"] = "|c"..select(4, GetItemQualityColor(2)).._G["ITEM_QUALITY2_DESC"].."|r",
				["3"] = "|c"..select(4, GetItemQualityColor(3)).._G["ITEM_QUALITY3_DESC"].."|r",
				["4"] = "|c"..select(4, GetItemQualityColor(4)).._G["ITEM_QUALITY4_DESC"].."|r",
				["5"] = "|c"..select(4, GetItemQualityColor(5)).._G["ITEM_QUALITY5_DESC"].."|r",
				["6"] = "|c"..select(4, GetItemQualityColor(6)).._G["ITEM_QUALITY6_DESC"].."|r",
			},
			disabled = function()
                if(IsInGroup() and (UnitIsGroupAssistant'player' or UnitIsGroupLeader'player')) then
                    return false
                else
                    return true
                end
				-- if (UnitExists("party1") or GetNumRaidMembers() > 0) and (IsPartyLeader() or IsRaidLeader()) then
				-- 	return false
				-- end
				-- return true
			end,
		},
		setdungeondiff = {
			order = 6, type = "select",
			name = L["Dungeon Difficulty"],
			desc = L["Set the dungeon difficulty for instances."],
			get = function() return tostring(GetDungeonDifficultyID()) end,
			set = function(_,v)
				SetDungeonDifficulty(tonumber(v))
			end,
			values = {
				["1"] = _G["GREEN_FONT_COLOR_CODE"].._G["DUNGEON_DIFFICULTY1"].."|r",
				["2"] = _G["RED_FONT_COLOR_CODE"].._G["DUNGEON_DIFFICULTY2"].."|r",
			},				
			disabled = function()
                local inParty, isLeader
                inParty = IsInGroup() and not IsInRaid()
                isLeader = UnitIsGroupLeader'player' or UnitIsGroupAssistant'player'
				-- local inParty = 0;
				-- if (UnitExists("party1") or GetNumRaidMembers() > 0) then
				-- 	inParty = 1;
				-- end
				-- local isLeader = 0;
				-- if (IsPartyLeader() or IsRaidLeader()) then
				-- 	isLeader = 1;
				-- end
				if IsInInstance() or (inParty and not isLeader) or (UnitLevel("player") < 65 and GetDungeonDifficultyID() == 1) then
					return true
				end
				return false
			end,
		},
		setraiddiff = {
			order = 7, type = "select",
			name = L["Raid Difficulty"],
			desc = L["Set the raid difficulty for instances."],
			get = function() return tostring(GetRaidDifficultyID()) end,
			set = function(_,v)
				SetRaidDifficultyID(tonumber(v))
			end,
			values = {
				["1"] = _G["GREEN_FONT_COLOR_CODE"].._G["RAID_DIFFICULTY1"].."|r",
				["2"] = _G["GREEN_FONT_COLOR_CODE"].._G["RAID_DIFFICULTY2"].."|r",
				["3"] = _G["RED_FONT_COLOR_CODE"].._G["RAID_DIFFICULTY3"].."|r",
				["4"] = _G["RED_FONT_COLOR_CODE"].._G["RAID_DIFFICULTY4"].."|r",
			},				
			disabled = function()
				-- local inParty = 0;
				-- if (UnitExists("party1") or GetNumRaidMembers() > 0) then
				-- 	inParty = 1;
				-- end
				-- local isLeader = 0;
				-- if (IsPartyLeader() or IsRaidLeader()) then
				-- 	isLeader = 1;
				-- end

                local ingroup = IsInGroup()
                local isleader = false
                if(ingroup) then
                    if(UnitIsGroupAssistant'player' or UnitIsGroupLeader'player') then
                        isLeader = true
                    end
                end
				if IsInInstance() or (ingroup and not isLeader) or (UnitLevel("player") < 65 and GetRaidDifficultyID() == 3) then
					return true
				end
				return false
			end,
		},
		showinstancediff = {
			order = 8, type = "toggle",
			name = L["Show instance difficulty"],
			desc = L["Toggles instance difficulty display on the button/block."],
			get = function() return Broker_GroupConfig.DisplayDungeonDiff end,
			set = function(_,v) Broker_GroupConfig.DisplayDungeonDiff = v BRGroup:Update() end,
			disabled = function() return not Broker_GroupConfig.DisplayLootTypeButton end,
		},
		setdifftype = {
			order = 9, type = "select",
			name = L["Difficulty type"],
			desc = L["Set the difficulty type text shown on the button/block. 'Auto' means the difficulty will only be shown if you are grouped and will reflect your group type."],
			get = function() return Broker_GroupConfig.DungeonDiffType end,
			set = function(_,v)
				Broker_GroupConfig.DungeonDiffType = v
				BRGroup:Update()
			end,
			values = {
				["DUNGEON"] = _G["LFG_TYPE_DUNGEON"],
				["RAID"] = _G["LFG_TYPE_RAID"],
				["AUTO"] = L["Auto (based on group)"],
			},			
		},
		showdiffshort = {
			order = 10, type = "toggle", width = "full",
			name = L["Short text for instance difficulty"],
			desc = L["Trims the instance difficulty text label. For example 25 player Heroic difficulty will display as '25 H'."],
			get = function() return Broker_GroupConfig.DungeonDiffShortText end,
			set = function(_,v) Broker_GroupConfig.DungeonDiffShortText = v BRGroup:Update() end,
		},
		showloottype = {
			order = 11, type = "toggle",
			name = L["Show loot method"],
			desc = L["Toggles loot method display on the button/block."],
			get = function() return Broker_GroupConfig.DisplayLootTypeButton end,
			set = function(_,v) Broker_GroupConfig.DisplayLootTypeButton = v BRGroup:Update() end,
			disabled = function() return not Broker_GroupConfig.DisplayDungeonDiff end,
		},
		leaveparty = {
			order = 15, type = "execute",
			name = L["Leave Party"],
			desc = L["Leave your current party or raid."],
			disabled = function()
                local inInstance, instanceType = IsInInstance()
                if(instanceType == 'arena' or instanceType == 'pvp') then
                    return true
                end
                if(IsInRaid()) then
                    return true
                end
                return false
				-- if UnitExists("party1") or GetNumRaidMembers() > 0 then
				-- 	if instanceType == "arena" or instanceType == "pvp" then
				-- 		return true
				-- 	end
				-- 	return false
				-- end
				-- return true
			end,
			func = LeaveParty,
		},
		resetinstance = {
			order = 16, type = "execute",
			name = L["Reset Instances"],
			desc = L["Reset all available instance the group leader has active."],
			func = function() StaticPopup_Show("CONFIRM_RESET_INSTANCES") end,
		},
	}
}

-- Add config to Blizzard menu
LibStub("AceConfig-3.0"):RegisterOptionsTable("Broker Group", options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Broker Group")


function BRGroup:ADDON_LOADED(addon)
	if addon == "Broker_Group" then		
		if not Broker_GroupConfig then 
  	-- initialize default configuration
    	Broker_GroupConfig = { 
			RollOnClick = true,
			OutputChannel = "LOCAL",
			DungeonDiffType = "AUTO",
			ClearTimer = "30",
			StandardRollsOnly = true,
			LootThreshold = 2,
			LootMethod = "group",
			DisplayLootTypeButton = true,
			DungeonDiffShortText = false
      }
  	end
  	-- added config options for 2.2
  	if not Broker_GroupConfig.DungeonDiffShortText then Broker_GroupConfig.DungeonDiffShortText = false end
  	-- added config options for 2.1
  	if Broker_GroupConfig.DisplayLootTypeButton == nil then Broker_GroupConfig.DisplayLootTypeButton = true end
  	if Broker_GroupConfig.DungeonDiffType == nil then Broker_GroupConfig.DungeonDiffType = "AUTO" end
  	-- added config options for 1.6
  	if not Broker_GroupConfig.DisplayDungeonDiff then Broker_GroupConfig.DisplayDungeonDiff = false end  	
  self:UnregisterEvent("ADDON_LOADED")
  self.ADDON_LOADED = nil
  end
end

function BRGroup:ModifyClassColors()
	for k, v in pairs(_G["CUSTOM_CLASS_COLORS"] or _G["RAID_CLASS_COLORS"]) do
		hexColors[k] = "|cff" .. string.format("%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
	end
	coloredName = setmetatable({}, {__index =
		function(self, key)
			if type(key) == "nil" then return nil end
			local class = select(2, UnitClass(key)) or "WTF"
			self[key] = hexColors[class]  .. key .. "|r"
			return self[key]
		end
	})
end


function BRGroup:GetHighestRoller()
	local highestPlayer = nil
	for i, v in ipairs(rollers) do
		if not highestPlayer and not v.pass then
			highestPlayer = i
		else
			if not v.pass and v.roll > rollers[highestPlayer].roll then
				highestPlayer = i
			end
		end
	end
	return highestPlayer
end


function BRGroup:Update()
    Broker_GroupConfig.LootMethod = GetLootMethod()
    Broker_GroupConfig.LootThreshold = tostring(GetLootThreshold())
    if rollers then
        -- local num = UnitInRaid("player") and GetNumRaidMembers() or GetNumPartyMembers() + 1
        local num = GetNumGroupMembers()
        local highest = self:GetHighestRoller()
        if highest ~= nil then
            local playerText = string.format(L["%s [%s]"], rollers[highest].player, "|cffff8c00"..rollers[highest].roll.."|r")
            self.obj.text = string.format(L["%s (%d/%d)"], playerText, #rollers, num)
            return
        end
    end

    if Broker_GroupConfig.DisplayDungeonDiff then
        local pluginlabel, separator, withpar = "", "", nil
        if Broker_GroupConfig.DisplayLootTypeButton then pluginlabel = self:GetLootTypeText() separator = " " withpar = true end
        if Broker_GroupConfig.DungeonDiffType == "DUNGEON" then
            -- Dungeon
            pluginlabel = pluginlabel..separator..self:GetDungeonDifficultyText(false, withpar, Broker_GroupConfig.DungeonDiffShortText)
        elseif Broker_GroupConfig.DungeonDiffType == "RAID" then
            -- Raid
            pluginlabel = pluginlabel..separator..self:GetDungeonDifficultyText(true, withpar, Broker_GroupConfig.DungeonDiffShortText)
        elseif Broker_GroupConfig.DungeonDiffType == "AUTO" then
            -- Auto
            if UnitExists("party1") and (not GetNumGroupMembers() > 0) then pluginlabel = pluginlabel..separator..self:GetDungeonDifficultyText(false, withpar, Broker_GroupConfig.DungeonDiffShortText) end
            if GetNumGroupMembers() > 0 then pluginlabel = pluginlabel..separator..self:GetDungeonDifficultyText(true, withpar, Broker_GroupConfig.DungeonDiffShortText) end
        end
        self.obj.text = pluginlabel
    else
        if Broker_GroupConfig.DisplayLootTypeButton then		
            self.obj.text = self:GetLootTypeText()
        else
            self.obj.text = ""
        end
    end

end

local function RollSorter(a, b)
	if a.pass then return false
	elseif b.pass then return true
	else return a.roll > b.roll end
end


function BRGroup.obj.OnTooltipShow(tooltip)
	tooltip:AddLine(_G["HIGHLIGHT_FONT_COLOR_CODE"].."组队与掷骰 - Broker Group")
	local inRaid = UnitInRaid("player")
	tooltip:AddDoubleLine(L["Dungeon Difficulty"], BRGroup:GetDungeonDifficultyText())
	tooltip:AddDoubleLine(L["Raid Difficulty"], BRGroup:GetDungeonDifficultyText(true))
	tooltip:AddDoubleLine(L["Loot method"], BRGroup:GetLootTypeText())
	if inRaid then		
		local officers = {}
		local ML = nil
		local leader = nil
		for i = 1, GetNumGroupMembers() do
			local name, rank, _, _, _, _, _, _, _, _, isML = GetRaidRosterInfo(i)
			if rank == 1 then
				table.insert(officers, coloredName[name])				
			elseif rank == 2 then
				leader = name
			elseif isML then
				ML = name
			end
		end		
		if ML then
			tooltip:AddDoubleLine(L["Master looter"], coloredName[ML])
		end
		if leader then
			tooltip:AddDoubleLine(L["Leader"], coloredName[leader])
		end
										
		local officersSize = table.getn(officers)
		-- we break officer names into rows with a maximum of 5 names per row
		-- in order to avoid tooltip stretching horizontally in case of too many officers
		if officersSize and officersSize > 0 then
			table.sort(officers, function (a,b) return string.len(a) < string.len(b) end)			
			local rows = ceil(officersSize / 5)
			local j = 1
			local k
			if officersSize > 5 then k = 5 else k = officersSize end
			
			for i = 1, rows do
				if j == 1 then
					tooltip:AddDoubleLine(L["Officers"], table.concat(officers, ", ", j, k))
				else
					tooltip:AddDoubleLine("       ", table.concat(officers, ", ", j, k))
				end
			j = k + 1
			k = k + 5
			if k > officersSize then k = officersSize end
			end
		end
		
	end

	if rollers and #rollers > 0 then
		tooltip:AddLine(" ")
		tooltip:AddDoubleLine(L["Player"], L["Roll"])
		table.sort(rollers, RollSorter)
		for i, v in ipairs(rollers) do
			if v.pass then
				tooltip:AddDoubleLine(
					string.format("%s (%d %s)", coloredName[v.player], v.level, v.class),
					"|cff696969" .. L["Pass"] .. "|r"
				)
			else
				tooltip:AddDoubleLine(
					string.format("%s (%d %s)", coloredName[v.player], v.level, v.class),
					_G["GREEN_FONT_COLOR_CODE"]..v.roll.."|r"
				)
			end
		end
		-- local num = inRaid and GetNumRaidMembers() or GetNumPartyMembers() + 1
        local num = GetNumGroupMembers()
		tooltip:AddLine(" ")
		tooltip:AddLine(string.format(L["%d of expected %d rolls recorded."], #rollers, num))
	end
	tooltip:AddLine(" ")
	if Broker_GroupConfig.RollOnClick then
		tooltip:AddLine(L["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."], 0.2, 1, 0.2, 1)
	else
		tooltip:AddLine(L["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."], 0.2, 1, 0.2, 1)
	end
end


function BRGroup:Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end


function BRGroup.obj.OnClick(self, button)
	if IsControlKeyDown() and button == "LeftButton" then
		BRGroup:AnnounceWinner()
	elseif IsShiftKeyDown() and button == "LeftButton" then
		BRGroup:ClearRolls(true)
	elseif Broker_GroupConfig.RollOnClick and button == "LeftButton" then
		RandomRoll("1", "100")
	elseif button == "RightButton" then		
		InterfaceOptionsFrame_OpenToCategory("Broker Group")		
	end
end

function BRGroup:CHAT_MSG_SYSTEM(msg)
  -- Match difficulty system message to alert addon for possible update
  -- dungeons
  local strm1 = format( _G["ERR_DUNGEON_DIFFICULTY_CHANGED_S"], _G["DUNGEON_DIFFICULTY1"])
  local strm2 = format( _G["ERR_DUNGEON_DIFFICULTY_CHANGED_S"], _G["DUNGEON_DIFFICULTY2"])
  local strm3 = format( _G["ERR_DUNGEON_DIFFICULTY_CHANGED_S"], _G["DUNGEON_DIFFICULTY3"])
  -- raids
  local strm4 = format( _G["ERR_RAID_DIFFICULTY_CHANGED_S"], _G["RAID_DIFFICULTY1"])
  local strm5 = format( _G["ERR_RAID_DIFFICULTY_CHANGED_S"], _G["RAID_DIFFICULTY2"])
  local strm6 = format( _G["ERR_RAID_DIFFICULTY_CHANGED_S"], _G["RAID_DIFFICULTY3"])
  local strm7 = format( _G["ERR_RAID_DIFFICULTY_CHANGED_S"], _G["RAID_DIFFICULTY4"])
  
  if (msg == strm1 or msg == strm2 or msg == strm3 or msg == strm4 or msg == strm5 or msg == strm6 or msg == strm7) and Broker_GroupConfig.DisplayDungeonDiff then
  	self:Update()
  	return
	end
  
	-- Trap rolls
	local player, roll, minRoll, maxRoll = Deformat(msg, RANDOM_ROLL_RESULT)
	if player then
		
		roll = tonumber(roll)
		minRoll = tonumber(minRoll)
		maxRoll = tonumber(maxRoll)

		if not roll or not minRoll or not maxRoll
		or Broker_GroupConfig.StandardRollsOnly and (minRoll ~= 1 or maxRoll ~= 100) then
			return
		elseif not Broker_GroupConfig.StandardRollsOnly and rollers then
			-- If someone else has already rolled, and we accept rolls other
			-- than 1-100, assume that everyone should roll on the same premises
			-- and only accept rolls that have the same range as the first roll.
			if maxRoll ~= currentMax or minRoll ~= currentMin then
				return
			end
		end

		if not rollers then
			currentMin = minRoll
			currentMax = maxRoll
			rollers = {}

			self:RegisterEvent("CHAT_MSG_PARTY")
			self:RegisterEvent("CHAT_MSG_RAID")
		end

		-- Ignore duplicate rolls.
		for i, v in ipairs(rollers) do
			if v.player == player then return end
		end

		if player == UnitName("player") then
			table.insert(rollers, {
				player = player,
				roll = roll,
				class = UnitClass("player") or _G["UNKNOWN"],
				level = UnitLevel("player") or -1,
			})
		else
			table.insert(rollers, {
				player = player,
				roll = roll,
				class = UnitClass(player) or _G["UNKNOWN"],
				level = UnitLevel(player) or -1,
			})
		end

		self:CheckForWinner()
		self:Update()
	end
end

function BRGroup:CheckForWinner()
	if Broker_GroupConfig.OutputChannel ~= "OFF" or tonumber(Broker_GroupConfig.ClearTimer) > 0 then
        local num = GetNumGroupMembers()
		-- local num = UnitInRaid("player") and GetNumRaidMembers() or GetNumPartyMembers() + 1
		-- If everyone has rolled, just output the winner.
		if num == #rollers and Broker_GroupConfig.OutputChannel ~= "OFF" then			
			self:CancelAllTimers()
			self:AnnounceWinner()			
		else			
			self:CancelAllTimers()
			BRTimeout = self:ScheduleTimer(self.RollTimeout, tonumber(Broker_GroupConfig.ClearTimer) - 5 or 5, self)
		end
	end
end

function BRGroup:CheckForPassers(msg, author)
	if type(msg) ~= "string" then return end
	if type(rollers) ~= "table" then return end

	if msg:lower():find(string.lower(L["Pass"])) then
		local found = nil
		for i, v in ipairs(rollers) do
			if v.player == author then
				v.pass = true
				v.roll = nil
				found = true
				break
			end
		end
		if not found then
			table.insert(rollers, {
				player = author,
				class = UnitClass(author) or _G["UNKNOWN"],
				level = UnitLevel(author) or -1,
				pass = true,
			})
		end
		self:CheckForWinner()
		self:Update()
	end
end


function BRGroup:ClearRolls(override)	
	  self:CancelAllTimers()

	if self:IsEventRegistered("CHAT_MSG_PARTY") then
		self:UnregisterEvent("CHAT_MSG_PARTY")
		self:UnregisterEvent("CHAT_MSG_RAID")
	end

	if tonumber(Broker_GroupConfig.ClearTimer) > 0 or override then
		if type(rollers) == "table" then
			for i, v in ipairs(rollers) do
				for k in pairs(v) do
					v[k] = nil
				end
				rollers[i] = nil
			end
		end
		rollers = nil
	end
	self:Update()
end


function BRGroup:GetLootTypeText()
	-- if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
    if(IsInGroup()) then
		return _G["ITEM_QUALITY_COLORS"][GetLootThreshold()].hex .. L[GetLootMethod()]
	else
		return "|cff9d9d9d" .. L["Solo"]
	end
end


function BRGroup:GetDungeonDifficultyText(isRaid, withpar, shortText)
 	local par1, par2 = "", ""
 	if withpar then par1, par2 = "(", ")" end
 	local diffstr = "|cffffff9a"..par1.._G["UNKNOWN"]..par2.."|r"
	if isRaid then
	-- raids
 	local diff = GetRaidDifficultyID()
	if not diff then return diffstr end
	-- remove () chars from difficulty

    local gstmpstr = _G['RAID_DIFFICULTY'..diff]
    local tmpstr = gstmpstr
    if(not tmpstr) then return diffstr end
    tmpstr = string.gsub(tmpstr, "%(", "")
	tmpstr = string.gsub(tmpstr, "%)", "")
		if shortText and shortdifftable[gstmpstr] then tmpstr = shortdifftable[gstmpstr] end -- account for shortText label
		if diff == 3 or diff == 4 then
			diffstr = _G["RED_FONT_COLOR_CODE"]..par1..tmpstr..par2.."|r"
		else
			diffstr = _G["GREEN_FONT_COLOR_CODE"]..par1..tmpstr..par2.."|r"
		end
	else
	-- dungeons
	local diff = GetDungeonDifficultyID()
	if not diff then return diffstr end
	-- remove () chars from difficulty
    local gstmpstr = _G["DUNGEON_DIFFICULTY"..tostring(diff)] 
    local tmpstr = gstmpstr
    if(not tmpstr) then return diffstr end
    tmpstr = string.gsub(tmpstr, "%(", "")
	tmpstr = string.gsub(tmpstr, "%)", "")
		if shortText and shortdifftable[gstmpstr] then tmpstr = shortdifftable[gstmpstr] end -- account for shortText label
		if diff == 2 then
			diffstr = _G["RED_FONT_COLOR_CODE"]..par1..tmpstr..par2.."|r"
		else
			diffstr = _G["GREEN_FONT_COLOR_CODE"]..par1..tmpstr..par2.."|r"
		end
	end
	return diffstr
end

function BRGroup:RollTimeout()
	if not rollers then return end

	if Broker_GroupConfig.OutputChannel ~= "OFF" then
		-- local num = UnitInRaid("player") and GetNumRaidMembers() or GetNumPartyMembers() + 1
        local num = GetNumGroupMembers()
		self:AnnounceOutput(string.format(L["Roll ending in 5 seconds, recorded %d of %d rolls."], #rollers, num))
	end
	BRAnnounce = self:ScheduleTimer(self.AnnounceWinner, 5, self)
end


function BRGroup:AnnounceWinner()
	if Broker_GroupConfig.OutputChannel ~= "OFF" then
		if rollers then
			local highest = self:GetHighestRoller()
			if highest then
				local tiedRollers = nil
				for i, v in ipairs(rollers) do
					if not v.pass and i ~= highest and v.roll == rollers[highest].roll then
						if not tiedRollers then tiedRollers = {} end
						table.insert(tiedRollers, i)
					end
				end
				if tiedRollers then
					table.insert(tiedRollers, highest)
					local playerNames = ""
					for i, v in ipairs(tiedRollers) do
						if playerNames == "" then
							playerNames = rollers[v].player
						else
							playerNames = playerNames .. L[", "] .. rollers[v].player
						end
					end
					lastAnnouncement = string.format(L["Tie: %s are tied at %d."], playerNames, rollers[highest].roll)
				else
					lastAnnouncement = string.format(L["Winner: %s."], string.format(L["%s [%s]"], rollers[highest].player, rollers[highest].roll))
				end
			else
				lastAnnouncement = L["Everyone passed."]
			end
		end
		if lastAnnouncement then
			self:AnnounceOutput(lastAnnouncement)
		end
	end
	self:ClearRolls()
end


function BRGroup:AnnounceOutput(msg)
	if Broker_GroupConfig.OutputChannel == "LOCAL" then
		self:Print(msg)
	elseif Broker_GroupConfig.OutputChannel == "AUTO" then
        if(IsInGroup()) then
            if(U1UseInstanceChat()) then
                SendChatMessage(msg, "INSTANCE_CHAT")
            elseif(IsInRaid()) then
                SendChatMessage(msg, "RAID")
            else
                SendChatMessage(msg, "PARTY")
            end
		-- if GetNumRaidMembers() > 0 then
		-- 	SendChatMessage(msg, "RAID")
		-- elseif GetNumPartyMembers() > 0 then
		-- 	SendChatMessage(msg, "PARTY")
		else
			self:Print(msg)
		end
	else
		SendChatMessage(msg, Broker_GroupConfig.OutputChannel)
	end
end


function BRGroup:PLAYER_LOGIN()
-- support for CUSTOM_CLASS_COLORS
	if _G["CUSTOM_CLASS_COLORS"] then
		self:ModifyClassColors()
		_G["CUSTOM_CLASS_COLORS"]:RegisterCallback(function() BRGroup:ModifyClassColors() end)
	end
	self:UnregisterEvent("PLAYER_LOGIN")
  self.PLAYER_LOGIN = nil
end

function BRGroup:GROUP_ROSTER_UPDATE()
	self:Update()
end

function BRGroup:PARTY_LOOT_METHOD_CHANGED()
	self:Update()
end

function BRGroup:PLAYER_ENTERING_WORLD()
	self:Update()
end

function BRGroup:CHAT_MSG_PARTY(msg, author, lang)
	self:CheckForPassers(msg, author)
end

function BRGroup:CHAT_MSG_RAID(msg, author, lang)
	self:CheckForPassers(msg, author)
end
