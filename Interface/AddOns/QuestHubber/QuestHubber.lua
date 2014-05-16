QuestHubber = LibStub("AceAddon-3.0"):NewAddon("QuestHubber", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0");
local core = QuestHubber;
local L = LibStub("AceLocale-3.0"):GetLocale("QuestHubber");
local G = LibStub:GetLibrary("LibGratuity-3.0");

-- upvalues for globals used often
local ipairs, pairs, tonumber, select, table, bit = ipairs, pairs, tonumber, select, table, bit
local GetCurrentMapAreaID, UnitLevel, GetNumQuestLogEntries, GetQuestLogTitle = GetCurrentMapAreaID, UnitLevel, GetNumQuestLogEntries, GetQuestLogTitle
local UIParent, WorldMapFrame, WorldMapDetailFrame = UIParent, WorldMapFrame, WorldMapDetailFrame

-- constants for clarity and order in selects
local SHOW_ALWAYS = 0
local SHOW_COND = 1
local SHOW_NEVER = 2

local options_setter = function(info, v) local t=core.db.profile for k=1,#info-1 do t=t[info[k]] end t[info[#info]]=v core:UpdatePins(true) end
local options_getter = function(info) local t=core.db.profile for k=1,#info-1 do t=t[info[k]] end return t[info[#info]] end
local options = {
	name = L["QuestHubber"],
	type = 'group',
	set = options_setter,
	get = options_getter,
	args = {
		displayMap = {
			name = L["World Map Display"],
			type = 'toggle',
			desc = L["Display a quick toggle and quest count in the corner of the world map"],
			order = 10,
			set = function(info, v) options_setter(info, v) core:SetMapModuleDisplay(v) end,
		},
		quests = {
			name = L["Normal Quests"],
			type = 'group',
			inline = true,
			order = 20,
			args = {
                display = {
					name = L["Display on map"],
					type = 'toggle',
					order = 10,
				},
				lowLevel = {
					name = L["Show Low Level Quests"],
					type = 'select',
					desc = L["Choose how to handle quests below your character's level range"],
					values = {
						[SHOW_ALWAYS] = L["Always"],
						[SHOW_COND] = L["When tracking"],
						[SHOW_NEVER] = L["Never"],
					},
					order = 20,
				},
				highLevel = {
					name = L["Show High Level Quests"],
					type = 'select',
					desc = L["Choose how to handle quests above your character's level range"],
					values = {
						[SHOW_ALWAYS] = L["Always"],
						[SHOW_NEVER] = L["Never"],
					},
					order = 30,
				},
				br = {
					name = '',
					type = 'description',
					order = 32,
					width = 'full',
				},
				hidePreBreadcrumb = {
					name = L["Hide Skipped Quests"],
					type = 'toggle',
					desc = ("|cffff0000%s|r\n%s\n\n|cff9999ff%s|r"):format(L["Warning: Experimental"], L["Do not show pins on the map for quests that were optional lead-ins to quests you have already completed."], L["Note: Because data on Wowhead is limited, the full quest chains are not always available, so this option may incorrectly show some unavailable quests"]),
					order = 35,
				},
				hideBreadcrumb = {
					name = L["Hide Unavailable Chain Quests"],
					type = 'toggle',
					desc = ("|cffff0000%s|r\n%s\n\n|cff9999ff%s|r"):format(L["Warning: Experimental"], L["Do not show pins on the map that require another quest to be completed."], L["Note: Because data on Wowhead is limited, the full quest chains are not always available, so this option may incorrectly show some unavailable or hide some available quests"]),
					order = 40,
					width = 'double',
				},
			},
		},
		daily = {
			name = L["Daily Quests"],
			type = 'group',
			inline = true,
			order = 30,
			args = {
				display = {
					name = L["Display on map"],
					type = 'toggle',
					order = 10,
				},
				range = {
					name = L["Use level filters"],
					type = 'toggle',
					desc = L["The filters set in the Normal Quests section for high and low level quests will apply to dailies as well"],
					order = 20,
				},
			},
		},
		grouping = {
			name = L["Quest Pin Grouping"],
			type = 'group',
			inline = true,
			hidden = true,
			args = {
				enable = {
					name = L["Enable"],
					type = 'toggle',
					desc = L["If enabled, pins within a certain range of each other will be grouped on your world map as a single pin"],
					order = 10,
				},
				group = {
					name = L["Radius"],
					type = 'range',
					desc = L["Group any pins within this many number of yards"],
					min = 0,
					max = 100,
					step = 1,
					order = 20,
				},
			},
			order = 40,
		},
		status = {
			name = '',
			type = 'description',
			order = 90,
		},
	},
};
local defaults = {
	profile = {
		debug = 0,
		display = true, -- Master switch shown on minimap; is not accounted for if displayMap=false

		displayMap = true,
		quests = {
			display = true,
			lowLevel = SHOW_COND,
			highLevel = SHOW_NEVER,
			hidePreBreadcrumb = true,
			hideBreadcrumb = false,
		},
		daily = {
			display = false,
			range = false,
		},
		grouping = {
			enable = true,
			group = 10,
		},
	},
};
local FACTION_MAP = {
	Alliance = 1,
	Horde = 2,
};
local IS_ENGLISH = (GetLocale()=="enUS" or GetLocale()=="enGB")
local RACE_ID = {
	["Human"] 		= 1,
	["Orc"] 		= 2,
	["Dwarf"] 		= 4,
	["Night Elf"]	= 8,
	["Scourge"]		= 16,
	["Tauren"]		= 32,
	["Gnome"]		= 64,
	["Troll"]		= 128,
	["Goblin"]		= 256,
	["Blood Elf"]	= 512,
	["Draenei"]		= 1024,
	["Worgen"]		= 2048,
}
local CLASS_ID = {
	["WARRIOR"] 	= 1,
	["PALADIN"] 	= 2,
	["HUNTER"] 		= 4,
	["ROGUE"] 		= 8,
	["PRIEST"] 		= 16,
	["DEATH KNIGHT"]= 32,
	["MAGE"] 		= 128,
	["SHAMAN"] 		= 64,
	["WARLOCK"] 	= 256,
	["DRUID"] 		= 1024,
}
local FLAG_STR = {
	[0x002] = "  |TInterface\\MINIMAP\\TRACKING\\Banker:0|t",
	[0x040] = L["Daily"],
	[0x080] = L["Escort"],
	[0x100] = L["Dungeon"],
	[0x200] = L["Raid"],
	[0x400] = L["PvP"],
}

core.failedQueries = 0
core.dataLoaded = false;		-- flag set after LoadStep() is done
core.currentZone = -1;			-- current World Map zone id
core.pinReg = {};				-- registry of all used pins
core.frameReg = {};				-- registry of all unused pin frmaes
core.playerQuests = {};			-- quests the player has completed, queried from server
core.questLink = {				-- table linking optional quests to the mandatory quests they lead to which take away the initial
	[25985] = 27874,
	[27727] = 27203,
};
core.questLog = {};				-- current quest log, used to see when quests are accepted or completed
core.questInit = false;			-- flag set after the quest log has been initially recorded
core.abandonQuest = -1;			-- when "Abandon" is clicked, sets the quest that was selected at the time; used after confirmation

core.cache = {
	quests = {},				-- [questid] = "Localized Name",
	npcs = {},					-- [npcid] = "Localized Name",
	invalid = {},				-- [npcid] = true, -- flag set so you don't get double debug warnings about a single npc
};
core.data = {
	zones = {},					-- each zone has a table of quests available
	npcs = {}, 					-- npcs that drop a quest item
};

-- LibDataBroker-1.1 support
local ldb = LibStub:GetLibrary("LibDataBroker-1.1");
local dataObj = ldb:NewDataObject("QuestHubber", {
	type = "data source",
	text = "0",
	value = "0",
	icon = "Interface\\AddOns\\!!!FishUI\\media\\QuestIcon.tga",
	OnClick = function(self, button)
		if button == "LeftButton" then
			if IsControlKeyDown() then
				core:ToggleTracking()
			else
				ToggleFrame(WorldMapFrame)
			end
		elseif button == "RightButton" then
			InterfaceOptionsFrame_OpenToCategory("QuestHubber")
		end
	end,
	OnTooltipShow = function(self)
		local shown, total = core.mapModule.shown, core.mapModule.total
		self:ClearLines()
		self:AddLine((L["QuestHubber - %s"]):format(GetRealZoneText()))
		self:AddLine(L["%d quests available in current zone"]:format(shown))
		self:AddLine(L["%d additional quests not shown due to filter restrictions"]:format(total-shown));
		self:AddLine(" ")  --fishuiedit
		self:AddLine(L["|cFFEDA55FClick|r to open the World Map"], 0.2, 1, 0.2, 1)
		self:AddLine(L["|cFFEDA55FRight-Click|r to open the QuestHubber options"], 0.2, 1, 0.2, 1)
		self:AddLine(L["|cFFEDA55FCtrl-Click|r to toggle low level quest tracking"], 0.2, 1, 0.2, 1)
	end,
})
function core:UpdateLDB(text)
	dataObj.text = text
end

	
function core:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("QuestHubberDB", defaults, "Default");
	self:RegisterChatCommand("qh", "SlashCommand")
	self:RegisterChatCommand("qhub", "SlashCommand")
	self:RegisterChatCommand("questhubber", "SlashCommand")
	
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("QuestHubber", options);
	local ACD = LibStub("AceConfigDialog-3.0");
	ACD:AddToBlizOptions("QuestHubber", "QuestHubber");
	
	self:SetupMapModule();
	self:SetupTooltip();

end

function core:SlashCommand()
	InterfaceOptionsFrame_OpenToCategory("QuestHubber")
end

function core:OnEnable()
	self:QueryQuestsCompleted();

	self:RegisterEvent("WORLD_MAP_UPDATE"); 			-- map change
	
	self:RegisterEvent("QUEST_LOG_UPDATE");				-- scan for quest completion/pickup
	
	self:RegisterEvent("MINIMAP_UPDATE_TRACKING"); 		-- for toggling Low Level Quests
	
	self:Hook("SetAbandonQuest", true);					-- hook for abandoned quests
	self:Hook("AbandonQuest", true);					-- hook for confirmation
	
	self.mapModule:Show();
end

function core:OnDisable()
	self.mapModule:Hide();	
end

function core:SlashHandle(message)

end

function core:QueryQuestsCompleted()
	-- We don't need to query anymore
	self.playerQuests = GetQuestsCompleted();
  -- Some people are having no result here, and I don't know why
  if not next(self.playerQuests) then
    -- self:Print("Failed to load quests, trying again...")
    self:ScheduleTimer(function()
      self:QueryQuestsCompleted()
    end, 1)
  else
    self:UpdatePins(true);
  end
end

local numScans = 0
local curScans = {}
function core:QuestScan(id)
	-- self:Debug("Scanning", id)
	if (id and id > 0) then
		-- check if we're scanning too many
		if (numScans < 100 or curScans[id]) then
			G:SetHyperlink(("quest:%d"):format(id));
			local text = G:GetText();
			if (text and text[1] and text[1][1]) then
				-- success, remove from scan list if it was queried
				if (curScans[id]) then
					curScans[id] = nil;
					numScans = numScans - 1;
					-- self:Debug("Removing a query", numScans);
				end
				self.cache.quests[id] = text[1][1];
				local mouse = GetMouseFocus()
				if (mouse and mouse.questHubberID == id) then
					self:ShowTooltip(mouse)
				end
				-- self:Debug(format("Quest id %d = %q", q, text[1][1]))
			else
				-- self:Debug("No name for quest "..id);
				-- no result, so the server has been queried
				if (not curScans[id]) then
					numScans = numScans + 1;
					curScans[id] = true;
					-- self:Debug("Adding another query", numScans);
				end
				self:ScheduleTimer(function()
					self:QuestScan(id)
				end, 2)
			end
		else
			-- self:Debug("NOT QUERYING, TOO HIGH")
			self:ScheduleTimer(function()
				self:QuestScan(id)
			end, 2.5)
		end
	end
end

function core:NPCScan(id)
	G:SetHyperlink(("unit:0xF53%05X00000000"):format(id));
	local text = G:GetText();
	if not text and not self.cache.invalid[id] then
		-- self:Debug("Invalid NPC id:", id, "- perhaps not cached?");
		self.cache.invalid[id] = true;
	end
	if (text and text[1] and text[1][1]) then
		self.cache.npcs[id] = text[1][1];
	end
end

function core:WORLD_MAP_UPDATE()
	if (self.dataLoaded) then
		self:UpdatePins();
	end
end

-----------------------------------------------
-- Pin management
-----------------------------------------------

function core:UpdatePins(force)
	local id = GetCurrentMapAreaID();
	local filtered, shown = 0, 0;
	if (id ~= self.currentZone or force) then
		-- update all pins
		self.currentZone = id;
		self:HideAllPins();
		if (self.data.zones[id]) then
			for q,v in pairs(self.data.zones[id]) do
				if (self:QuestAvailable(q, v)) then	-- if we're not on the quest or have completed it
					if (self:QuestUnfiltered(q, v)) then
						if (self.db.profile.display or not self.db.profile.displayMap) then -- don't want to restrict if we hid the map overlay
							self:ShowPin(q, v);
						end
						shown = shown + 1;
						-- self:Debug("Showing pin",q,"on map",id)
					else
						filtered = filtered + 1;
					end
				else
					-- self:Debug("Not showing pin",q,"on map",id)
				end
			end
			-- self:Debug("Showing",shown,"pins");
		end
		self.mapModule:SetCount(shown, shown+filtered);
	end
end

function core:ShowPin(id, data)
	local flags, class, race, level, minlevel, xcoord, ycoord, npc, name = self:GetQuestData(data);
	if (not flags or not tonumber(xcoord) or not tonumber(ycoord)) then
		-- self:Debug("Bad quest data:", id, data, ";;;", flags, level, xcoord, ycoord, npc, name)
		return
	end
	
	if (bit.band(flags, 0x02) > 0) then
		self.data.npcs[tonumber(npc)] = id;
	end
	
	-- check the cache for quest name; scan tooltip if not
	if (not self.cache.quests[id]) then
		self:QuestScan(id);
	end
	-- check the cache for npc name; scan tooltip if not (and id belongs to an npc and not an object)
	if (not self.cache.npcs[npc] and bit.band(flags, 0x010)>0) then
		self:NPCScan(npc);
	end

	-- check level and set pin type
	local texType, level, minlevel = nil, tonumber(level), tonumber(minlevel)
	if bit.band(flags, 0x040) > 0 then
		texType = "daily"
	elseif UnitLevel("player") < minlevel then
		texType = "high"
	elseif UnitLevel("player") > level + 10 then
		texType = "low"
	end
	
	local pin = self:GetPin();
	
	pin:SetType(texType);
	pin:ClearAllPoints();
	pin.questHubberID = id;
	-- pin:SetParent(WorldMapDetailFrame);
	pin:SetFrameLevel(WorldMapPOIFrame:GetFrameLevel()-1);
	pin:SetPoint("CENTER", WorldMapDetailFrame, "TOPLEFT", xcoord/10000*WorldMapDetailFrame:GetWidth(), -ycoord/10000*WorldMapDetailFrame:GetHeight());
	-- pin:SetFrameStrata("FULLSCREEN");
	pin:Show();
	
	self.pinReg[id] = pin;
end

function core:HidePin(id)
	if (self.pinReg[id]) then
		self.pinReg[id]:Hide();
		table.insert(self.frameReg, self.pinReg[id]);
		self.pinReg[id] = nil;
	end
end

function core:HideAllPins()
	for i,v in pairs(self.pinReg) do
		self:HidePin(i);
	end
end

-- tile sizes and coord starts for Interface\\MINIMAP\\ObjectIcons.blp
local tileX, tileY = 1/8, 1/8
local dailyX, dailyY = 3, 1
local questX, questY = 1, 1
function core:GetPin()
	if (#self.frameReg > 0) then
		return table.remove(self.frameReg);
	end
	
	-- create new
	local pin = CreateFrame("Frame", nil, WorldMapDetailFrame);
	pin:SetWidth(16);
	pin:SetHeight(16);
	pin:EnableMouse(true);
	pin:SetScript("OnEnter", function(pin)
		self:ShowTooltip(pin);
	end);
	pin:SetScript("OnLeave", function()
		self:HideTooltip();
	end);
	pin.SetType = function(self, texType)
		if self.texType == texType then return end -- don't need to make changes

		-- 256x64, 8x4
		self.texture:SetDesaturated(false);
		self.texture:SetVertexColor(1, 1, 1);
		if texType == "daily" then
            self.texture:SetTexCoord(dailyX*tileX, (dailyX+1)*tileX, dailyY*tileY, (dailyY+1)*tileY)
		elseif texType == "low" then
			-- I don't like this one, it's too hard to see.
			-- self.texture:SetTexCoord(4*0.125, 5*0.125, 3*0.250, 4*0.250);
            self.texture:SetTexCoord(questX*tileX, (questX+1)*tileX, questY*tileY, (questY+1)*tileY)
			self.texture:SetVertexColor(0.75, 0.75, 0.75);
		elseif texType == "high" then
			-- Note: not all systems can desaturate. If they don't, I don't really care.
            self.texture:SetTexCoord(questX*tileX, (questX+1)*tileX, questY*tileY, (questY+1)*tileY)
			self.texture:SetDesaturated(1);
		else
            self.texture:SetTexCoord(questX*tileX, (questX+1)*tileX, questY*tileY, (questY+1)*tileY)
		end

		self.texType = texType
	end

	pin.texture = pin:CreateTexture();
	pin.texture:SetTexture("Interface\\MINIMAP\\ObjectIcons.blp");
	pin.texture:SetAllPoints();
	pin:SetType("default")
	
	return pin;
end

-- QuestAvailable() returns whether or not the quest is available for pickup right now
function core:QuestAvailable(id, data)
	if data then
		local flags, class, race, _, _, _, _, _, _, pre, post, final = self:GetQuestData(data);
		class, race = tonumber(class), tonumber(race)
		
		-- check race
		local urace = RACE_ID[select(2, UnitRace("player"))]
		if (race > 0 and urace and bit.band(race, urace) == 0) then
			-- self:Debug("Hid", id, "because of race restriction")
			return false
		end			
		
		-- check class
		local uclass = CLASS_ID[select(2, UnitClass("player"))]
		if (class > 0 and uclass and bit.band(class, uclass) == 0) then
			-- self:Debug("Hid", id, "because of class restriction")
			return false
		end		

		-- check daily - we don't want it to add to total if we have it turned off
		if (bit.band(flags, 0x040) > 0 and not self.db.profile.daily.display) then
			return false
		end

		-- check if this is a pre-quest that cannot be completed
		if (self.db.profile.quests.hidePreBreadcrumb) then
			-- check post and final of this quest
			if (post ~= "0" and self:CompletedBreadcrumbs(post)) or (final ~= "0" and self:CompletedBreadcrumbs(final)) then
				return false
			end
		end

		-- check if this is a future quest that cannot be picked up yet
		if (self.db.profile.quests.hideBreadcrumb) then
			-- check pre of this quest
			if pre ~= "0" and not self:CompletedBreadcrumbs(pre) then
				return false
			end
		end
	end
	
	-- check based on chain - TODO: delete
	if (not self.questLog[id] and not self.playerQuests[id] and self.questLink[id]) then
		return not self.playerQuests[self.questLink[id]];
	end
	
	-- now only return true if its not in your logs or completed list
	return not self.questLog[id] and not self.playerQuests[id];
end

-- QuestUnfiltered() returns whether or not the quest is being filtered (i.e., level requirement)
-- add daily flag?
function core:QuestUnfiltered(id, data)
	local db = self.db.profile

	if data then
		local flags, _, _, level, minlevel = self:GetQuestData(data)
		level, minlevel = tonumber(level), tonumber(minlevel)

		-- check daily quest
		-- I am taking advantage of the fact that there are only two filters. This will need to change if I add more
		-- We definitely want to display if we have range off
		if (bit.band(flags, 0x040) > 0) then
			if db.daily.display and not db.daily.range then
				return true
			end
		else
			-- check if we're displaying normal quests
			if not db.quests.display then 
				return false 
			end
		end

		-- check level requirement
		if  (db.quests.lowLevel == SHOW_NEVER and UnitLevel("player") > level + 10) 							or
			(db.quests.lowLevel == SHOW_COND and UnitLevel("player") > level + 10 and not self:TrackingLow()) 	or
			(db.quests.highLevel == SHOW_NEVER and UnitLevel("player") < minlevel)    							then
			-- self:Debug("Hid", id, "because of level restriction")
			return false
		end
	end

	return true
end

-- checks whether the player is tracking low level quests
local trackIndex
local trackTexture = "Interface\\Minimap\\Tracking\\TrivialQuests"
function core:TrackingLow()
	if not trackIndex or select(2, GetTrackingInfo(trackIndex)) ~= trackTexture then
		trackIndex = nil -- if the second condition fired, let's discard the old value just in case
		for i=1,GetNumTrackingTypes() do
			local _, texture = GetTrackingInfo(i)
			if texture == trackTexture then
				trackIndex = i
				break
			end
		end
	end
	
	if trackIndex then
		return select(3, GetTrackingInfo(trackIndex))
	end
end

-- when minimap tracking changes, see if we need to fire a map update
local oldTrack = core:TrackingLow()
function core:MINIMAP_UPDATE_TRACKING()
	if self:TrackingLow() ~= oldTrack and self.db.profile.quests.lowLevel == SHOW_COND then
		self:UpdatePins(true)
		oldTrack = not oldTrack
	end
end

-- toggles the low level quest tracking
function core:ToggleTracking()
	-- force refresh to make sure our vars are correct
	local current = self:TrackingLow()

	if trackIndex then
		SetTracking(trackIndex, not current)
	end
end

-- CompletedBreadcrumbs() takes a quest id string joined with | (or) or & (and) and returns the result respectively
function core:CompletedBreadcrumbs(qidStr)
	local qid, delim, cdr = qidStr:match("(%d+)([|&]*)(%s*)")
	local completed = self.playerQuests[tonumber(qid) or 0]
	
	if delim == "" then
		return completed
	elseif delim == "|" then
		return completed or self:CompletedBreadcrumbs(cdr)
	elseif delim == "&" then
		return completed and self:CompletedBreadcrumbs(cdr)
	end
end

-----------------------------------------------
-- Tooltip management
-----------------------------------------------

function core:GetMousePosition()
	local left, top = WorldMapDetailFrame:GetLeft(), WorldMapDetailFrame:GetTop();
	local width, height = WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight();
	local scale = WorldMapDetailFrame:GetEffectiveScale();

	local x, y = GetCursorPosition();
	local cx = (x/scale - left) / width;
	local cy = (top - y/scale) / height;
	
	return math.min(math.max(cx, 0), 1), math.min(math.max(cy, 0), 1);
end

function core:Distance(x1, y1, x2, y2)
	-- gets distance in map units TODO: use yards?
	local distRatio = WorldMapDetailFrame:GetHeight() / WorldMapDetailFrame:GetWidth();
	
	return math.sqrt( (x1 - x2)^2 + ((y1 - y2)/distRatio)^2 );
end

local listedQuests = {} -- this will be wiped and filled with names that are added to the tooltip so there are no dupes
function core:ShowTooltip(pin)
	-- check to make sure the tooltip can be shown because of the parent
	if not UIParent:IsShown() then
		if self.tooltip:GetParent() == UIParent then
			self.tooltip:SetParent(WorldMapFrame);
			self.tooltip:SetFrameStrata("TOOLTIP");
		end
	elseif self.tooltip:GetParent() ~= UIParent then
		self.tooltip:SetParent(UIParent);
		self.tooltip:SetFrameStrata("TOOLTIP");
	end

	self.tooltip:SetOwner(pin, "ANCHOR_RIGHT");
	self.tooltip:ClearLines();
	
	-- find all quests in range of hover
	local mx, my = self:GetMousePosition();
	local npcList = {};
	local npcNames = {};
	for q,v in pairs(self.data.zones[self.currentZone]) do
		if (self:QuestAvailable(q, v) and self:QuestUnfiltered(q, v)) then
			local _, _, _, _, _, xcoord, ycoord, npc, npcname = self:GetQuestData(v);
			if (tonumber(xcoord) and tonumber(ycoord)) then
				local dist = self:Distance(mx, my, xcoord/10000, ycoord/10000);
				-- self:Print("d:",dist,v.begin.x,v.begin.y);
				if (dist <= 0.02) then
					if (not npcList[npc]) then
						npcList[npc] = {};
						npcNames[npc] = npcname;
					end
					table.insert(npcList[npc], q);
				end
			end
		end
	end
	
	local first = true;	
	local cZone = self.data.zones[self.currentZone];
	for npc,questList in pairs(npcList) do
		wipe(listedQuests)
		if (not first) then
			self.tooltip:AddLine(" ");
		else
			first = false;
		end
		table.sort(questList);
		for _,q in ipairs(questList) do
			local flags, class, race, level, minlevel, _, _, _, npcname = self:GetQuestData(cZone[q]);
			local questName = self.cache.quests[q]
			local leftStr = ("[%d] %s"):format(level, questName or "(Querying server...)")
			local rightStr = "";
			
			-- checking flags for rightStr text
			-- rightStr = "|TInterface\\CURSOR\\CURSORICONSNEW:16:16:0:0:128:256:32:63:128:159|t" -- -64:-96
			for flg, text in pairs(FLAG_STR) do
				if bit.band(flags, flg) > 0 then
					if text:match("%s.+") then
						leftStr = leftStr .. text
					else
						rightStr = text
					end
				end
			end

			-- check if already printed - this is for spam quests like the human starting area that haven't been labeled correctly
			if not questName or not listedQuests[questName] then
				self.tooltip:AddDoubleLine(leftStr, rightStr, 255/255, 210/255, 0/255, 255/255, 210/255, 0/255);
				-- self.tooltip:AddLine(leftStr .. rightStr, 255/255, 210/255, 0/255, 1);
				self.tooltip:SetLastFont(self.tooltip.large);
				self.tooltip:SetLastFont(self.tooltip.small, true);
				if questName then
					listedQuests[questName] = true
				end
			end
		end
		-- if the npc name is cached, display it (will be localized); if not, if we are on enUS or enGB, display the hard-coded name as it should be localized; if on a different locale, display the hard-coded name in parenthesis to denote that it has not been discovered yet
		self.tooltip:AddLine(self.cache.npcs[npc] or (IS_ENGLISH and npcNames[npc]) or ("(%s)"):format(npcNames[npc]), 1, 1, 1, 1);
		self.tooltip:SetLastFont(self.tooltip.small);
	end
	
	self.tooltip:Show();
end

function core:HideTooltip()
	self.tooltip:Hide();
end

-----------------------------------------------
-- Quest log management
-----------------------------------------------

function core:QUEST_LOG_UPDATE()
	-- get closed tabs
	local closed = {}
	for i=1,GetNumQuestLogEntries() do
		local title, _, _, _, isHeader, isCollapsed = GetQuestLogTitle(i);
		if (isCollapsed) then
			closed[title] = true
		end
	end
	ExpandQuestHeader(0)
	
	if (not self.questInit) then
		for i=1,GetNumQuestLogEntries() do
			local _, _, _, _, _, _, _, _, id = GetQuestLogTitle(i);
			if (id and id > 0) then
				self.questLog[id] = true;
			end
		end
		self:Debug("Quest Log snapshot saved");
		-- self:UnregisterEvent("QUEST_LOG_UPDATE");
		self.questInit = true;
	else
		-- self:Debug("QUEST_LOG_UPDATE");
		local tempLog = {};
		for i=1,GetNumQuestLogEntries() do
			local name, _, _, _, _, _, _, _, id = GetQuestLogTitle(i);
			-- self:Debug("   ", name, id);
			if (id and id > 0) then
				tempLog[id] = name;
			end
		end
		-- self:Debug("_END_");
		
		for i,v in pairs(self.questLog) do
			if (not tempLog[i]) then
				-- quest removed; hopefully completed
				self:Debug("Quest completed:",i);
				self.questLog[i] = nil;
				tempLog[i] = nil;
				self.playerQuests[i] = true;
				-- force a full update in case any optional pre-reqs should be turned off
				self:UpdatePins(true);
			end
		end
		
		-- merge added
		for i,v in pairs(tempLog) do
			if (not self.questLog[i]) then
				self:Debug("Quest accepted:", v);
				self.questLog[i] = true;
				self:HidePin(i);
			end
		end
	end
	
	-- restore closed tabs
	for i=1,GetNumQuestLogEntries() do
		local title, _, _, _, isHeader = GetQuestLogTitle(i);
		if closed[title] then
			CollapseQuestHeader(i)
		end
	end
end

function core:SetAbandonQuest()
	self.abandonQuest = GetQuestLogSelection();
end

function core:AbandonQuest()
	-- saved quest was abandoned
	-- self:Debug("AbandonQuest");
	local name, _, _, _, _, _, _, _, id = GetQuestLogTitle(self.abandonQuest);
	self:Debug("Quest abandoned:",name);
	self.questLog[id] = nil;
	self:UpdatePins(true)
end

function core:Debug(level, ...)
	if (type(level) ~= "number") then
		self:Debug(1, level, ...);
		return;
	end
	if self.db.profile.debug >= level then 
		self:Print(...);
	end
end

local loader  -- timer that runs UpdatePins after everything is loaded
function core:RegisterQuests(zones)
	for i,v in pairs(zones) do
		if (not self.data.zones[i]) then
			self.data.zones[i] = {};
		end
		
		for q,qv in pairs(v) do
			self.data.zones[i][q] = qv;
		end
	end
	self.dataLoaded = true;
	if (not loader) then
		loader = self:ScheduleTimer(function()
			self:UpdatePins(true);
			self:SecureHookScript(GameTooltip, "OnTooltipSetUnit", "CheckNPCTooltip"); -- used for adding notes to mobs' tooltips
		end, 1);
	end
end

-- returns flags, class, race, level, xcoord, ycoord, npc, npcname
function core:GetQuestData(questStr)
	return questStr:match("(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(.-)::([0-9|&]+):([0-9|&]+):([0-9|&]+)")
end

-- local oprint = print
-- local function print(...)
-- 	local toprint = {...}
-- 	core:ScheduleTimer(function()
-- 		oprint(unpack(toprint))
-- 	end, 1)
-- end

function core:SetupMapModule()
	-- frame contains checkbox and text label
	local frame = CreateFrame("Frame", nil, WorldMapDetailFrame);
	frame:SetSize(250, 20);
	frame:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", 5, -50); --fishuiedit
	frame:Hide();
	frame:EnableMouse(1);
	frame:SetFrameStrata("HIGH");
	frame:SetFrameLevel(5);
	frame:SetScript("OnEnter", function(self)
		core.tooltip:ClearLines();
		core.tooltip:SetOwner(self);
		core.tooltip:AddLine(L["%d quests available in current zone"]:format(self.shown))
		if self.total > self.shown then
			core.tooltip:AddLine(L["%d additional quests not shown due to filter restrictions"]:format(self.total-self.shown));
			core.tooltip:SetLastFont(core.tooltip.small);
		end
		core.tooltip:Show();
		core.tooltip:ClearAllPoints();
		core.tooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 20, 0);
	end);
	frame:SetScript("OnLeave", function(self)
		core.tooltip:Hide();
	end);
	
	frame.check = CreateFrame("CheckButton", nil, frame, "OptionsBaseCheckButtonTemplate");
	frame.check:SetSize(18, 18);
	frame.check:SetHitRectInsets(0, 0, 0, 0);
	frame.check:SetPoint("LEFT");
	frame.check:SetChecked(self.db.profile.display);
	frame.check:SetFrameLevel(6);
	frame.check:SetScript("OnClick", function(self)
		if (self:GetChecked()) then
			core.db.profile.display = true
		else
			core.db.profile.display = false
		end
		core:UpdatePins(true)
	end)
	frame.check:SetScript("OnEnter", function(self)
		-- core:Print("Enter");
		core.tooltip:ClearLines();
		core.tooltip:SetOwner(self, "ANCHOR_RIGHT");
		core.tooltip:AddLine(L["Show/Hide all pins"]);
		core.tooltip:Show();
	end);
	frame.check:SetScript("OnLeave", function(self)
		-- core:Print("Leave");
		core.tooltip:Hide();
	end);
	
	local font, size = GameTooltipHeader:GetFont();
	frame.text = frame:CreateFontString();
	frame.text:SetFont(font, size, "OUTLINE");
	frame.text:SetTextColor(255/255, 210/255, 0/255, 1);
	frame.text:SetText(L["QuestHubber"]);
	frame.text:SetPoint("LEFT", frame.check, "RIGHT");
	
	core.mapModule = frame;
	core.mapModule.SetCount = function(self, m, n)
		-- sets the text to QuestHubber (m/n) and shows a tooltip saying how many are hidden
		self.shown, self.total = m, n or m
		local suffix = ""
		if (m and (n or m)>0) then
			if not n or n <= m then
				suffix = ("(%d)"):format(m)
			else
				suffix = ("(%d/%d)"):format(m, n)
			end
		end
		self.text:SetText(L["QuestHubber"] .. suffix)

		-- also update our ldb object
		core:UpdateLDB(suffix=="" and 0 or suffix:sub(2, -2))
	end
end

function core:SetMapModuleDisplay(shown)
	if shown then
		core.mapModule:Show()
	else
		core.mapModule:Hide()
	end
end

	

function core:SetupTooltip()
	self.tooltip = CreateFrame("GameTooltip", "QuestHubberTooltip", UIParent, "GameTooltipTemplate");
	self.tooltip:SetFrameStrata("TOOLTIP");
	self.tooltip.large = QuestHubberTooltipTextLeft1:GetFontObject();
	self.tooltip.small = QuestHubberTooltipTextLeft2:GetFontObject();
	self.tooltip.SetLastFont = function(self, fontObj, rightText)
		local txt = "Left"
		if rightText then
			txt = "Right"
		end
		_G[("QuestHubberTooltipText%s%d"):format(txt, self:NumLines())]:SetFont(fontObj:GetFont());
		-- _G["QuestHubberTooltipTextRight"..self:NumLines()]:SetFont(fontObj:GetFont());
	end
	
	-- if the UI panel disappears (maximized WorldMapFrame) we need to change parents
	self:HookScript(UIParent, "OnHide", function()
		self.tooltip:SetParent(WorldMapFrame);
		self.tooltip:SetFrameStrata("TOOLTIP");
	end);
	self:HookScript(UIParent, "OnShow", function()
		self.tooltip:SetParent(UIParent);
		self.tooltip:SetFrameStrata("TOOLTIP");
	end);
end

function core:CheckNPCTooltip(tooltip)
	if (not UnitIsPlayer("mouseover") or true) then
		-- check if this npc drops a quest item
		local guid = UnitGUID("mouseover");
		if ( guid ) then
			local id = tonumber(guid:sub(7, 10), 16);
			local q = self.data.npcs[id];
			if (q and self:QuestAvailable(q) and self:QuestUnfiltered(q)) then
				local leftStr = ("|TInterface\\MINIMAP\\ObjectIcons:17:9:0:0:256:128:40:56:32:63|t %s"):format(L["Drops an item which starts [%s]"]:format(self.cache.quests[q] or ("(%s)"):format(L["Querying server..."])))
				tooltip:AddLine(leftStr);
				tooltip:Show();
			end
		end
	end
end

