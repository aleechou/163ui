NPCMark = LibStub('AceAddon-3.0'):NewAddon('NPCMark', 'AceEvent-3.0', 'AceConsole-3.0', 'AceTimer-3.0')
MAP_ADJACENT_DISTANCE = 20 

local node_index;
local NPCMark_Loaded = false
local npc_name;
local _, engClass = UnitClass("player")
MAP_MARK_TEXTURE = {
	[MAP_MARK_PROF_MAGE] = "^CLASS^MAGE",
	[MAP_MARK_PROF_PRIEST] = "^CLASS^PRIEST",
	[MAP_MARK_PROF_WARLOCK] = "^CLASS^WARLOCK",
	[MAP_MARK_PROF_ROGUE] = "^CLASS^ROGUE",
	[MAP_MARK_PROF_DRUID] = "^CLASS^DRUID",
	[MAP_MARK_PROF_HUNTER] = "^CLASS^HUNTER",
	[MAP_MARK_PROF_SHAMAN] = "^CLASS^SHAMAN",
	[MAP_MARK_PROF_WARRIOR] = "^CLASS^WARRIOR",
	[MAP_MARK_PROF_PALADIN] = "^CLASS^PALADIN",
	[MAP_MARK_PROF_DEATHKNIGHT] = "^CLASS^DEATHKNIGHT",
	[MAP_MARK_SKILL_ALCHE] = [[Interface\ICONS\Trade_Alchemy]],
	[MAP_MARK_PROF_BLACKSMITH] = [[Interface\ICONS\Trade_BlackSmithing]], --[[Interface\CURSOR\Repair]]
	[MAP_MARK_PROF_ENCHANTING] = [[Interface\ICONS\Trade_Engraving]],
	[MAP_MARK_PROF_ENGINEERING] = [[Interface\ICONS\Trade_Engineering]], --[[Interface\CURSOR\EngineerSkin]]
	[MAP_MARK_PROF_HERBALISM] = [[Interface\ICONS\Trade_Herbalism]], --[[Interface\CURSOR\GatherHerbs]]
	[MAP_MARK_PROF_INSCRIPTION] = [[Interface\ICONS\INV_Inscription_Tradeskill01]],
	[MAP_MARK_PROF_JEWEL] = [[Interface\ICONS\INV_Misc_Gem_01]],
	[MAP_MARK_PROF_LEATHERWORKING]= [[Interface\ICONS\Trade_LeatherWorking]],
	[MAP_MARK_PROF_MINING] = [[Interface\ICONS\Trade_Mining]], --[[Interface\CURSOR\Mine]]
	[MAP_MARK_PROF_SKINNING] = [[Interface\ICONS\INV_Misc_Pelt_Wolf_01]], --[[Interface\CURSOR\Skin]]
	[MAP_MARK_PROF_TAILORING] = [[Interface\ICONS\Trade_Tailoring]],
	[MAP_MARK_PROF_ARCHAEOLOGY] = [[Interface\ICONS\Trade_Archaeology]], --[[Interface\Archeology\Arch-Icon-Marker]]
	[MAP_MARK_PROF_COOKING] = [[Interface\ICONS\INV_Misc_Food_15]],
	[MAP_MARK_PROF_FIRSTAID] = [[Interface\ICONS\Spell_Holy_SealOfSacrifice]],
	[MAP_MARK_PROF_FISHING] = [[Interface\ICONS\Trade_Fishing]], --[[Interface\CURSOR\Fishing]]
	[MAP_MARK_PROF_RIDING] = [[Interface\Minimap\Tracking\StableMaster]],
	--[MAP_MARK_WEAPON] = "Interface\\AddOns\\NPCMark\\icon\\5",
	[MAP_MARK_INN] = [[Interface\Minimap\Tracking\Innkeeper]],
	[MAP_MARK_GLADIUS] = [[Interface\Minimap\Tracking\BattleMaster]],
	--[MAP_MARK_FLY] = [[Interface\Minimap\Tracking\FlightMaster]],
	[MAP_MARK_PORTAL] = [[Interface\ICONS\Spell_Arcane_PortalStormWind]],
	[MAP_MARK_AUCTION] = [[Interface\Minimap\Tracking\Auctioneer]],
	[MAP_MARK_BANK] = [[Interface\Minimap\Tracking\Banker]],
	[MAP_MARK_BARBER] = [[Interface\ICONS\INV_Misc_Comb_02]],
	[MAP_MARK_MATERIAL] = [[Interface\Minimap\Tracking\Reagents]],
	[MAP_MARK_STABLE] = [[Interface\ICONS\Ability_Hunter_BeastTaming]],
	[MAP_MARK_REFORGE] = [[Interface\Reforging\Reforge-Portrait]],
	[MAP_MARK_DUMMY] = [[Interface\ICONS\INV_Misc_Food_59]],
	[MAP_MARK_DAIBI] = [[Interface\ICONS\Spell_Holy_ChampionsBond]],
	[MAP_MARK_ZHENFU] = [[Interface\PVPFrame\PVP-Currency-]]..UnitFactionGroup("player"),
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
	--MAP_MARK_WEAPON,
	MAP_MARK_INN, 
	MAP_MARK_GLADIUS,
	--MAP_MARK_FLY,
	MAP_MARK_PORTAL, 
	MAP_MARK_AUCTION, 
	MAP_MARK_BANK, 
	MAP_MARK_BARBER,
	MAP_MARK_MATERIAL,
	MAP_MARK_STABLE, 
	MAP_MARK_REFORGE,
	MAP_MARK_DUMMY,
	MAP_MARK_DAIBI,
	MAP_MARK_ZHENFU,
}

NPCMARKMAPPINGDB = {
	[MAP_MARK_FLYING] = MAP_MARK_PROF_RIDING,

	[MAP_MARK_DAIBI1] = MAP_MARK_DAIBI,
	[MAP_MARK_DAIBI2] = MAP_MARK_DAIBI,
	[MAP_MARK_DAIBI3] = MAP_MARK_DAIBI,
} 

local function GetMappedType(_type) 
	if NPCMARKMAPPINGDB[_type] then 
		return NPCMARKMAPPINGDB[_type] 
	end
	if (engClass == "ROGUE") then
		NPCMARKMAPPINGDB[MAP_MARK_POSION] = MAP_MARK_MATERIAL;
	end
	for _,val in pairs(MAP_MARK_MAPPING_TABLE) do 
		if string.find(_type,val) then
			NPCMARKMAPPINGDB[_type] =val
			return val 
		end 
	end
	return "" 
end

local function InitConfig()
	NPCMarkDB = {}
	-- 職業訓練師
	if _G["MAP_MARK_PROF_"..engClass] then
		NPCMarkDB[_G["MAP_MARK_PROF_"..engClass]] = true
	end
	-- 專業訓練師
	local skills = {GetProfessions()};
	for k, v in pairs(skills) do
		local skillName = GetProfessionInfo(v) 	
		local mapping = MAP_MARK_MAPPING[skillName]
		if mapping then 
			NPCMarkDB[mapping] = true 
		end
	end
	NPCMarkDB[MAP_MARK_DAIBI] = true
	NPCMarkDB[MAP_MARK_ZHENFU] = true
	NPCMarkDB[MAP_MARK_DUMMY] = true
	NPCMarkDB[MAP_MARK_REFORGE] = true
	NPCMarkDB[MAP_MARK_PROF_RIDING] = true
	NPCMarkDB[MAP_MARK_INN] = true
	--NPCMarkDB[MAP_MARK_FLY] = true
	NPCMarkDB[MAP_MARK_AUCTION] = true
	NPCMarkDB[MAP_MARK_BANK] = true 
	NPCMarkDB[MAP_MARK_MATERIAL] = true 
end 

function NPCM_ToggleEnable(switch) 
	if ( switch == 1 ) then 
		if (not NPCMark_Loaded) then
            hooksecurefunc("WorldMapFrame_UpdateMap", NPCMark_WorldMapFrameOnUpdate);
			--WorldMapFrame:HookScript("OnUpdate", NPCMark_WorldMapFrameOnUpdate);
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
    NPCMark_WorldMapFrameOnUpdate()
end 

local MapMarkDDTable = { 
	-- 職業訓練師
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
	}, 
	-- 技能训练师
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
	--[MAP_MARK_WEAPON] = {	func = true },
	[MAP_MARK_DAIBI] = { func = true },
	[MAP_MARK_ZHENFU] = { func = true },
	[MAP_MARK_DUMMY] = { func = true },
	[MAP_MARK_REFORGE] = { func = true },
	[MAP_MARK_PROF_RIDING] = { func = true },
	[MAP_MARK_INN] = { func = true }, 
	[MAP_MARK_GLADIUS] = { func = true }, 
	--[MAP_MARK_FLY] = { func = true },
	[MAP_MARK_PORTAL] = { func = true }, 
	[MAP_MARK_AUCTION] = { func = true }, 
	[MAP_MARK_BANK] = { func = true }, 
	[MAP_MARK_BARBER] = { func = true }, 
	[MAP_MARK_MATERIAL] = { func = true },
	[MAP_MARK_STABLE] = { func = true }, 
}

local function menuClick(self, key)
    NPCMarkDB[key] = not NPCMarkDB[key]
    NPCMark_WorldMapFrameOnUpdate()
end
local function clearAll()
    table.wipe(NPCMarkDB)
    NPCMark_WorldMapFrameOnUpdate()
end
local function menuChecked(button)
    return button.arg1 and NPCMarkDB[button.arg1]
end
function MapMarkDDInit(self,level)
	level = level or 1;
	if (level == 1) then
        local info = UIDropDownMenu_CreateInfo()
        info.text = "全部取消"
        info.keepShownOnClick = false
        info.func = clearAll
        UIDropDownMenu_AddButton(info, level)
        
		for key, subarray in pairs(MapMarkDDTable) do 
			local info = UIDropDownMenu_CreateInfo();
            info.keepShownOnClick = true
            info.isNotRadio = true
            info.arg1 = key
            info.icon = MAP_MARK_TEXTURE[GetMappedType(key)]
			if (MAP_MARK_ZHENFU == key) then
				info.text = "PvP" .. key;
			else
				info.text = key;
			end
			if subarray.func then
				info.hasArrow = false;
				info.func = menuClick
				info.checked = menuChecked
			else 
				info.hasArrow = true;
                info.checked = NPCMarkDB[key]
                info.func = function(self, key)
                    NPCMarkDB[key] = not NPCMarkDB[key]
                    local subarray = MapMarkDDTable[key];
                    for key, subsubarray in pairs(subarray) do NPCMarkDB[key] = nil end
                    if self.checked then
                        if key == MAP_MARK_PROF then
                            NPCMarkDB[_G["MAP_MARK_PROF_"..engClass]] = true
                        elseif key == MAP_MARK_SKILL then
                            local skills = {GetProfessions()};
                            for k, v in pairs(skills) do
                                local skillName = GetProfessionInfo(v)
                                local mapping = MAP_MARK_MAPPING[skillName]
                                if mapping then
                                    NPCMarkDB[mapping] = true
                                end
                            end
                        end
                    end
                    UIDropDownMenu_Refresh(MapPlusDDList)
                    UIDropDownMenu_SetText(MapPlusDDList,MAPMARK_TITLE)
                    NPCMark_WorldMapFrameOnUpdate()
                end
				info.value = { ["Level1_Key"] = key; }; 
			end 
			UIDropDownMenu_AddButton(info, level);
		end 
	end
	
	if (level == 2) then 
		local Level1_Key = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"];
		local subarray = MapMarkDDTable[Level1_Key];
		for key, subsubarray in pairs(subarray) do
			local info = UIDropDownMenu_CreateInfo();
            info.keepShownOnClick = true
            info.isNotRadio = true
            info.arg1 = key
            local texture = MAP_MARK_TEXTURE[GetMappedType(key)]
            if texture:sub(1, 7) == "^CLASS^" then
                info.tCoordLeft, info.tCoordRight, info.tCoordTop, info.tCoordBottom = unpack(CLASS_ICON_TCOORDS[texture:sub(8)])
                texture = "Interface\\TARGETINGFRAME\\UI-Classes-Circles"
            end
            info.icon = texture;
			info.hasArrow = false;
			info.text = key
			info.func = menuClick
			info.checked = menuChecked
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
        local coL, coR, coT, coB = 0, 1, 0, 1
        local blendMode = "BLEND"
        if texture:sub(1, 7) == "^CLASS^" then
            coL, coR, coT, coB = unpack(CLASS_ICON_TCOORDS[texture:sub(8)])
            texture = "Interface\\TARGETINGFRAME\\UI-Classes-Circles"
        end
        _G[button:GetName().."Icon"]:SetBlendMode(blendMode)
        if texture:find("\\ICONS\\") then
            SetPortraitToTexture(_G[button:GetName().."Icon"], texture)
        else
		    _G[button:GetName().."Icon"]:SetTexture(texture);
        end
        _G[button:GetName().."Icon"]:SetTexCoord(coL, coR, coT, coB);

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
		local currLevel = GetCurrentMapDungeonLevel();
		return select(mapId,GetMapZones(GetCurrentMapContinent())), currLevel; 
	end
end 

local function checkLevel(nodes, curLevel)
	for _, node in pairs(nodes) do
		if (node[4] and node[4] == curLevel) then
			return true;
		end
	end

	return false;	
end

function NPCMark_WorldMapFrameOnUpdate(self)
    if not NPCMarkDB then InitConfig() end
    if not WorldMapFrame:IsVisible() then return end
	hideNodes() 
	if not NPCMark_Enable then 
		return 
	end
	if MapMarkHide then 
		return
	end
	local mapName, currLevel = getCurrentMapName() 
	if not MapPlusNodeData then 
		return 
	end 
	node_index = 1
	if mapName and MapPlusNodeData[mapName] then
		local nodes = MapPlusNodeData[mapName] 
		local bHasLvl = checkLevel(nodes, currLevel);
		for _,_node in pairs(nodes) do 
			if isSelected(_node[1]) and ((not bHasLvl and not _node[3]) or  (_node[3] and _node[3] == currLevel)) then
				showNodes(_node[1],"",select(2,unpack(_node)))
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
	local _i = 1
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
    NPCMark_WorldMapFrameOnUpdate()
end

-- 求距離
function Distance(coord1,coord2)
	return (coord1[1]-coord2[1])^2 + (coord1[2]-coord2[2])^2 
end

-- 判斷是否相鄰
function IsAdjacent(dbTable, entry)
	if not dbTable or not dbTable[GetMappedType(entry[1])] then 
		return false 
	end 

	for _,_coord in pairs(dbTable[GetMappedType(entry[1])]) do
		if Distance(_coord,entry[2]) < MAP_ADJACENT_DISTANCE then
			return true 
		end 
	end 
	return false
end

-- 縮小地圖標記數據
function ReduceMap(_table) 
	local tempDB = {}
	local outPut ={}
	for _,_entry in pairs(_table) do
		tempDB[GetMappedType(_entry[1])] = tempDB[GetMappedType(_entry[1])] or {}
		if not IsAdjacent(tempDB, _entry) then 
			tinsert(tempDB[GetMappedType(_entry[1])], _entry[2])
			tinsert(outPut, _entry)
		end
	end
	return outPut
end

function NPCMark:ReduceData()
    if not MapPlusNodeData then return end
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