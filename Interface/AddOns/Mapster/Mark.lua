NPCMark = LibStub('AceAddon-3.0'):NewAddon('NPCMark', 'AceEvent-3.0', 'AceConsole-3.0', 'AceTimer-3.0') 
MAP_ADJACENT_DISTANCE = 20 

local node_index;
local NPCMark_Loaded = false
local npc_name;
local _, engClass = UnitClass("player")
MAP_MARK_TEXTURE = {
	[MAP_MARK_PROF_MAGE] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\26",
	[MAP_MARK_PROF_PRIEST] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\31",
	[MAP_MARK_PROF_WARLOCK] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\32",
	[MAP_MARK_PROF_ROGUE] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\27",
	[MAP_MARK_PROF_DRUID] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\28",
	[MAP_MARK_PROF_HUNTER] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\29",
	[MAP_MARK_PROF_SHAMAN] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\30",
	[MAP_MARK_PROF_WARRIOR] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\25",
	[MAP_MARK_PROF_PALADIN] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\33",
	[MAP_MARK_PROF_DEATHKNIGHT] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\34",
	[MAP_MARK_PROF_MONK] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\27",
	[MAP_MARK_SKILL_ALCHE] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\2", --[[Interface\ICONS\Trade_Alchemy]]
	[MAP_MARK_PROF_BLACKSMITH] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\17", --[[Interface\ICONS\Trade_BlackSmithing]] --[[Interface\CURSOR\Repair]]
	[MAP_MARK_PROF_ENCHANTING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\19", --[[Interface\ICONS\Trade_Engraving]]
	[MAP_MARK_PROF_ENGINEERING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\18", --[[Interface\ICONS\Trade_Engineering]] --[[Interface\CURSOR\EngineerSkin]]
	[MAP_MARK_PROF_HERBALISM] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\21", --[[Interface\ICONS\Trade_Herbalism]] --[[Interface\CURSOR\GatherHerbs]]
	[MAP_MARK_PROF_INSCRIPTION] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\9", --[[Interface\ICONS\INV_Inscription_Tradeskill01]]
	[MAP_MARK_PROF_JEWEL] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\12",  --[[Interface\ICONS\INV_Misc_Gem_01]]
	[MAP_MARK_PROF_LEATHERWORKING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\22", --[[Interface\ICONS\Trade_LeatherWorking]]
	[MAP_MARK_PROF_MINING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\23", --[[Interface\ICONS\Trade_Mining]] --[[Interface\CURSOR\Mine]]
	[MAP_MARK_PROF_SKINNING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\13", --[[Interface\ICONS\INV_Misc_Pelt_Wolf_01]] --[[Interface\CURSOR\Skin]]
	[MAP_MARK_PROF_TAILORING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\24",  --[[Interface\ICONS\Trade_Tailoring]]
	[MAP_MARK_PROF_ARCHAEOLOGY] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\36",  --[[Interface\ICONS\Trade_Archaeology]] --[[Interface\Archeology\Arch-Icon-Marker]]
	[MAP_MARK_PROF_COOKING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\11",  --[[Interface\ICONS\INV_Misc_Food_15]]
	[MAP_MARK_PROF_FIRSTAID] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\1",   --[[Interface\ICONS\Spell_Holy_SealOfSacrifice]]
	[MAP_MARK_PROF_FISHING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\20",   --[[Interface\ICONS\Trade_Fishing]] --[[Interface\CURSOR\Fishing]]
	[MAP_MARK_PROF_RIDING] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\16",    --[[Interface\Minimap\Tracking\StableMaster]]
	[MAP_MARK_WEAPON] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\5",
	[MAP_MARK_INN] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\35",  --[[Interface\Minimap\Tracking\Innkeeper]]
	[MAP_MARK_GLADIUS] = [[Interface\Minimap\Tracking\BattleMaster]],
	[MAP_MARK_FLY] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\3",  --[[Interface\Minimap\Tracking\FlightMaster]]
	[MAP_MARK_PORTAL] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\15",  --[[Interface\ICONS\Spell_Arcane_PortalStormWind]]
	[MAP_MARK_AUCTION] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\7",  --[[Interface\Minimap\Tracking\Auctioneer]]
	[MAP_MARK_BANK] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\14",   --[[Interface\Minimap\Tracking\Banker]]
	[MAP_MARK_BARBER] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\8",   --[[Interface\ICONS\INV_Misc_Comb_02]]
	[MAP_MARK_MATERIAL] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\10",   --[[Interface\Minimap\Tracking\Reagents]]
	[MAP_MARK_STABLE] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\4",    --[[Interface\ICONS\Ability_Hunter_BeastTaming]]
	[MAP_MARK_REFORGE] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\40",   --[[Interface\Reforging\Reforge-Portrait]]
	[MAP_MARK_DUMMY] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\38",  --[[Interface\ICONS\INV_Misc_Food_59]]
	[MAP_MARK_DAIBI] = [[Interface\ICONS\Spell_Holy_ChampionsBond]],
	[MAP_MARK_ZHENFU] = [[Interface\PVPFrame\PVP-Currency-]]..UnitFactionGroup("player"),  --"Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\37"
	[MAP_MARK_THUNDERBOX] = "Interface\\Icons\\INV_Box_02",
	[MAP_MARK_HUANHUA] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\41", 
	[MAP_MARK_XUKONGYINHANG] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\42", 
 
	[MAP_MARK_BOSS] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\43", 
	[MAP_MARK_WEEKLY] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\44",
	[MAP_MARK_DAILY] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\45", 
	[MAP_MARK_EVENT] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\46", 
	[MAP_MARK_SURPRISE] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\47", 
	[MAP_MARK_SANLUOBAOXIANG] = "Interface\\AddOns\\!!!163UI!!!\\Textures\\icon\\48",
}

MAP_MARK_MAPPING = { 
	[NPCM_ALCHE] = MAP_MARK_SKILL_ALCHE,
	[NPCM_BLACKSMITH] = MAP_MARK_PROF_BLACKSMITH,
	[NPCM_ENCHANTING] = MAP_MARK_PROF_ENCHANTING,
	[NPCM_ENGINEERING] = MAP_MARK_PROF_ENGINEERING, 
	[NPCM_HERBALISM] = MAP_MARK_PROF_HERBALISM, 
	[NPCM_INSCRIPTION] = MAP_MARK_PROF_INSCRIPTION,
	[NPCM_JEWEL] = MAP_MARK_PROF_JEWEL,
	[NPCM_LEATHERWORKING] = MAP_MARK_PROF_LEATHERWORKING, 
	[NPCM_MINING] = MAP_MARK_PROF_MINING,
	[NPCM_SKINNING] = MAP_MARK_PROF_SKINNING, 
	[NPCM_TAILORING] = MAP_MARK_PROF_TAILORING, 
	[NPCM_ARCHAEOLOGY] = MAP_MARK_PROF_ARCHAEOLOGY,
	[NPCM_COOKING] = MAP_MARK_PROF_COOKING,
	[NPCM_FIRSTAID] = MAP_MARK_PROF_FIRSTAID,
	[NPCM_FISHING] = MAP_MARK_PROF_FISHING,
}

MAP_MARK_MAPPING_TABLE = {
	MAP_MARK_PROF_MAGE, 
	MAP_MARK_PROF_PRIEST, 
	MAP_MARK_PROF_WARLOCK,
	MAP_MARK_PROF_ROGUE,
	MAP_MARK_PROF_DRUID,
	MAP_MARK_PROF_HUNTER,
	MAP_MARK_PROF_SHAMAN, 
	MAP_MARK_PROF_WARRIOR, 
	MAP_MARK_PROF_PALADIN,
	MAP_MARK_PROF_DEATHKNIGHT, 
	MAP_MARK_PROF_MONK,
	MAP_MARK_SKILL_ALCHE, 
	MAP_MARK_PROF_BLACKSMITH, 
	MAP_MARK_PROF_ENCHANTING,
	MAP_MARK_PROF_ENGINEERING, 
	MAP_MARK_PROF_HERBALISM, 
	MAP_MARK_PROF_INSCRIPTION, 
	MAP_MARK_PROF_JEWEL,
	MAP_MARK_PROF_LEATHERWORKING, 
	MAP_MARK_PROF_MINING,
	MAP_MARK_PROF_SKINNING, 
	MAP_MARK_PROF_TAILORING,
	MAP_MARK_PROF_ARCHAEOLOGY,
	MAP_MARK_PROF_COOKING,
	MAP_MARK_PROF_FIRSTAID, 
	MAP_MARK_PROF_FISHING,
	MAP_MARK_PROF_RIDING, 
	MAP_MARK_WEAPON,
	MAP_MARK_INN,
	MAP_MARK_GLADIUS,
	MAP_MARK_FLY, 
	MAP_MARK_PORTAL, 
	MAP_MARK_AUCTION, 
	MAP_MARK_BANK, 
	MAP_MARK_BARBER,
	MAP_MARK_MATERIAL,
	MAP_MARK_STABLE, 
	MAP_MARK_DAIBI,
	MAP_MARK_ZHENFU,
	MAP_MARK_DUMMY,
	MAP_MARK_REFORGE,
	MAP_MARK_THUNDERBOX,
	
	MAP_MARK_BOSS, 
	MAP_MARK_WEEKLY, 
	MAP_MARK_DAILY, 
	MAP_MARK_EVENT, 
	MAP_MARK_SURPRISE, 
	MAP_MARK_SANLUOBAOXIANG,
}

NPCMarkMappingDB=NPCMarkMappingDB or {
	[MAP_MARK_FLY1] = MAP_MARK_FLY, 
	[MAP_MARK_FLY2] = MAP_MARK_FLY,
	[MAP_MARK_FLY3] = MAP_MARK_FLY, 
	[MAP_MARK_FLY4] = MAP_MARK_FLY, 
	[MAP_MARK_FLY5] = MAP_MARK_FLY, 
	[MAP_MARK_DAIBI1] = MAP_MARK_ZHENFU, 
	[MAP_MARK_DAIBI2] = MAP_MARK_ZHENFU, 
	[MAP_MARK_DAIBI3] = MAP_MARK_ZHENFU, 
	[MAP_MARK_DAIBI4] = MAP_MARK_ZHENFU, 
	[MAP_MARK_DAIBI5] = MAP_MARK_ZHENFU, 
	[MAP_MARK_DAIBI6] = MAP_MARK_ZHENFU, 
	[MAP_MARK_GLADIUS]= MAP_MARK_ZHENFU, 
} 

local function GetMappedType(_type) 
	if NPCMarkMappingDB[_type] then 
		return NPCMarkMappingDB[_type] 
	end
	for _,val in pairs(MAP_MARK_MAPPING_TABLE) do 
		if string.find(_type,val) then
			NPCMarkMappingDB[_type] =val 
			return val 
		end 
	end
	return "" 
end

local function InitConfig()
	NPCMarkDB = {}
	--local _,localized = UnitClass("player") 
	local _, engClass = UnitClass("player")
	if _G["MAP_MARK_PROF_"..engClass] then
		NPCMarkDB[_G["MAP_MARK_PROF_"..engClass]] = true
	end
	local skills = {GetProfessions()};
	for k, v in pairs(skills) do
		local skillName = GetProfessionInfo(v) 	
		local mapping = MAP_MARK_MAPPING[skillName]
		if mapping then 
			NPCMarkDB[mapping] = true 
		end
	end

	NPCMarkDB[MAP_MARK_INN] = true
	NPCMarkDB[MAP_MARK_FLY] = true
	NPCMarkDB[MAP_MARK_AUCTION] = true
	NPCMarkDB[MAP_MARK_BANK] = true 
	NPCMarkDB[MAP_MARK_MATERIAL] = true 
	NPCMarkDB[MAP_MARK_REFORGE] = true
	NPCMarkDB[MAP_MARK_THUNDERBOX] = true
	
	NPCMarkDB[MAP_MARK_BOSS] = true 
	NPCMarkDB[MAP_MARK_WEEKLY] = true 
	NPCMarkDB[MAP_MARK_DAILY] = true 
	NPCMarkDB[MAP_MARK_EVENT] = true 
	NPCMarkDB[MAP_MARK_SURPRISE] = true 
	NPCMarkDB[MAP_MARK_SANLUOBAOXIANG] = true
end 

function NPCM_ToggleEnable(switch) 
	if ( switch == 1 ) then 
		if (not NPCMark_Loaded) then
			WorldMapFrame:HookScript("OnUpdate", NPCMark_WorldMapFrameOnUpdate);
			NPCMark_Loaded = true;
			if (WorldMapFrame:HasScript("OnShow")) then 
				WorldMapFrame:HookScript("OnShow", NPCMark_WorldMapFrameOnShow); 
			else 
				WorldMapFrame:SetScript("OnShow", NPCMark_WorldMapFrameOnShow);
			end 
		end 
		
		NPCMark_Enable = 1; 
	else 
		NPCMark_Enable = nil; 
	end 
end 

local MapMarkDDTable = { 
	[MAP_MARK_PROF] = { 
		[MAP_MARK_PROF_MAGE] = {func = true}, 
		[MAP_MARK_PROF_PRIEST] = {func = true}, 
		[MAP_MARK_PROF_WARLOCK] = {func = true}, 
		[MAP_MARK_PROF_ROGUE] = {func = true},
		[MAP_MARK_PROF_DRUID] = {func = true},
		[MAP_MARK_PROF_HUNTER] = {func = true},
		[MAP_MARK_PROF_SHAMAN] = {func = true}, 
		[MAP_MARK_PROF_WARRIOR] = {func = true}, 
		[MAP_MARK_PROF_PALADIN] = {func = true}, 
		[MAP_MARK_PROF_DEATHKNIGHT] = {func = true},
		[MAP_MARK_PROF_MONK] = {func = true}, 
	}, 
	[MAP_MARK_SKILL] = {
		[MAP_MARK_SKILL_ALCHE] = {func = true}, 
		[MAP_MARK_PROF_BLACKSMITH] = {func = true}, 
		[MAP_MARK_PROF_ENCHANTING] = {func = true}, 
		[MAP_MARK_PROF_ENGINEERING] = {func = true}, 
		[MAP_MARK_PROF_HERBALISM] = {func = true},
		[MAP_MARK_PROF_INSCRIPTION] = {func = true}, 
		[MAP_MARK_PROF_JEWEL] = {func = trued}, 
		[MAP_MARK_PROF_LEATHERWORKING] = {func = true},
		[MAP_MARK_PROF_MINING] = {func = true}, 
		[MAP_MARK_PROF_SKINNING] = {func = true}, 
		[MAP_MARK_PROF_TAILORING] = {func = true}, 
		[MAP_MARK_PROF_ARCHAEOLOGY] = {func = true}, 
		[MAP_MARK_PROF_COOKING] = {func = true}, 
		[MAP_MARK_PROF_FIRSTAID] = {func = true}, 
		[MAP_MARK_PROF_FISHING] = {func = true},
	},
	[MAP_MARK_WEAPON] = {	func = true },
	[MAP_MARK_DAIBI] = { func = true },
	[MAP_MARK_INN] = { func = true },
	[MAP_MARK_GLADIUS] = { func = true }, 
	[MAP_MARK_FLY] = { func = true },
	[MAP_MARK_PORTAL] = { func = true }, 
	[MAP_MARK_AUCTION] = { func = true }, 
	[MAP_MARK_BANK] = { func = true }, 
	[MAP_MARK_BARBER] = { func = true }, 
	[MAP_MARK_MATERIAL] = { func = true },
	[MAP_MARK_STABLE] = { func = true }, 
	[MAP_MARK_ZHENFU] = {func = true },
	[MAP_MARK_DUMMY] = {func = true },
	[MAP_MARK_REFORGE] = {func = true },
	[MAP_MARK_THUNDERBOX] = {func = true },
	
	[MAP_MARK_BOSS] = { func = true }, 
	[MAP_MARK_WEEKLY] = { func = true }, 
	[MAP_MARK_DAILY] = { func = true }, 
	[MAP_MARK_EVENT] = { func = true }, 
	[MAP_MARK_SURPRISE] = { func = true }, 
	[MAP_MARK_SANLUOBAOXIANG] = { func = true },
}

function MapMarkDDInit(self,level)
	level = level or 1;
	if (level == 1) then
		for key, subarray in pairs(MapMarkDDTable) do 
			local info = UIDropDownMenu_CreateInfo(); 
			info.text = key; 
			if subarray.func then
				info.hasArrow = false; 
				info.func = function() 
					NPCMarkDB[key] = not NPCMarkDB[key] 
				end
				info.checked = NPCMarkDB[key] 
			else 
				info.hasArrow = true;
				info.value = { ["Level1_Key"] = key; }; 
			end 
			UIDropDownMenu_AddButton(info, level);
		end 
	end
	
	if (level == 2) then 
		local Level1_Key = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"]; 
		subarray = MapMarkDDTable[Level1_Key]; 
		for key, subsubarray in pairs(subarray) do
			local info = UIDropDownMenu_CreateInfo();
			info.hasArrow = false;
			info.text = key
			info.func = function()
				NPCMarkDB[key] = not NPCMarkDB[key] 
			end
			info.checked = NPCMarkDB[key] 
			UIDropDownMenu_AddButton(info, level);
		end
	end
end

function NPCMark_WorldMapFrameOnShow()
	if (not NPCMark_Enable) then 
		MapPlusDDList:Hide() 
		MapMarkCheckButton:Hide()
		return;
	end 
	
	if not NPCMarkDB then
		InitConfig() 
	end
	if NPCMarkDB[MAP_MARK_THUNDERBOX] == nil then
		NPCMarkDB[MAP_MARK_THUNDERBOX] = true
	end
	UIDropDownMenu_Initialize(MapPlusDDList,MapMarkDDInit)
	UIDropDownMenu_SetText(MapPlusDDList,MAPMARK_TITLE) 
	MapPlusDDList:Show() 
	MapMarkCheckButton:Show() 
end 

local function isSelected(type) 
	if NPCMarkDB[GetMappedType(type)] then
		return true
	end 
	
	return false 
end 

local function coord_transform(width,height,x,y) 
	return x*width/100, -y*height/100 
end

local function showNodes(_type,name,...)
	local function showNode(name,_type,x,y)
		local texture = MAP_MARK_TEXTURE[GetMappedType(_type) ] 
		local button = _G["MapMark"..node_index] 
		if not button then
			button = CreateFrame("Button","MapMark"..node_index,WorldMapDetailFrame,"MapMarkTemplate") 
		end
		button:SetPoint("CENTER",WorldMapDetailFrame,"TOPLEFT",coord_transform(WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight(),x,y))
		_G[button:GetName().."Icon"]:SetTexture(texture);
		
		button.text2 = name 
		button.text = _type 
		node_index = node_index + 1 
		button:Show() 
	end 
	local _coord = ... 
	showNode(name,_type,_coord[1],_coord[2]) 
end

local function hideNodes()
	local _i = 1 
	while _G["MapMark".._i] do 
		_G["MapMark".._i]:Hide() 
		_i = _i + 1 
	end 
end

local function getCurrentMapName() 
	local mapId = GetCurrentMapZone() 
	if mapId >0 then
		return select(mapId,GetMapZones(GetCurrentMapContinent())) 
	end
end 

function NPCMark_WorldMapFrameOnUpdate(self) 
	hideNodes() 
	if not NPCMark_Enable then 
		return 
	end
	if MapMarkHide then 
		return
	end
	local mapName = getCurrentMapName() 
	if not MapPlusNodeData then 
		return 
	end 
	node_index = 1
	if mapName and MapPlusNodeData[mapName] then
		local nodes = MapPlusNodeData[mapName] 
		for _,_node in pairs(nodes) do 
			if isSelected(_node[1]) then 
				showNodes(_node[1],_node[2],select(3,unpack(_node))) 
			end 
		end 
	end
end

function IsButtonsAdjacent(button1, button2) 
	local cx1, cy1 = button1:GetCenter(); 
	local cx2, cy2 = button2:GetCenter(); 
	return ((cx1-cx2)^2 + (cy1-cy2)^2 <200) 
end 

function MapMarkPoint_OnEnter(self) 
	local cx1, cy1 = self:GetCenter(); 
	local cx2 = self:GetParent():GetCenter();
	if ( cx1 > cx2 ) then
		NPCMTooltip:SetOwner(self, "ANCHOR_LEFT");
	else 
		NPCMTooltip:SetOwner(self, "ANCHOR_RIGHT"); 
	end 
	NPCMTooltip:AddLine(self.text) 
	local font = _G["NPCMTooltipTextLeft"..NPCMTooltip:NumLines()]:GetFontObject() 
	NPCMTooltip:AddLine(self.text2)
	_G["NPCMTooltipTextLeft"..NPCMTooltip:NumLines()]:SetTextColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b) 
	_i = 1 
	while _G["MapMark".._i] do
		local button = _G["MapMark".._i]
		if button:IsShown() and button ~= self and IsButtonsAdjacent(button,self) then 
			NPCMTooltip:AddLine(" ")
			NPCMTooltip:AddLine(button.text) 
			_G["NPCMTooltipTextLeft"..NPCMTooltip:NumLines()]:SetFontObject(font) 
			NPCMTooltip:AddLine(button.text2) 
			_G["NPCMTooltipTextLeft"..NPCMTooltip:NumLines()]:SetTextColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b) 
		end
		_i = _i + 1
	end 
	NPCMTooltip:Show();
end

function MapMarkPoint_OnLeave(self) 
	NPCMTooltip:Hide(); 
end

function MapMarkToggleEnable(tog)
	if tog then
		MapMarkHide = false
	else
		MapMarkHide = true 
	end 
end

function Distance(coord1,coord2)
	return (coord1[1]-coord2[1])^2 + (coord1[2]-coord2[2])^2 
end

function IsAdjacent(dbTable, entry)
	if not dbTable or not dbTable[GetMappedType(entry[1])] then 
		return false 
	end 

	for _,_coord in pairs(dbTable[GetMappedType(entry[1])]) do
		if Distance(_coord,entry[3]) < MAP_ADJACENT_DISTANCE then 
			return true 
		end 
	end 
	return false
end

function ReduceMap(_table) 
	local tempDB = {}
	local outPut ={}
	for _,_entry in pairs(_table) do
		tempDB[GetMappedType(_entry[1])] = tempDB[GetMappedType(_entry[1])] or {}
		if not IsAdjacent(tempDB, _entry) then 
			tinsert(tempDB[GetMappedType(_entry[1])], _entry[3])
			tinsert(outPut, _entry)
		end
	end
	return outPut
end

function NPCMark:ReduceData()
	for _name, _table in pairs(MapPlusNodeData) do
		MapPlusNodeData[_name]= ReduceMap(_table)
	end
end

function NPCMark:OnInitialize()
	self:ReduceData();
end 

function NPCMark:OnEnable() 
	NPCM_ToggleEnable(1)
end

function NPCMark:OnDisable() 
	NPCM_ToggleEnable(0) 
end 
