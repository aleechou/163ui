NPCMark = LibStub('AceAddon-3.0'):NewAddon('NPCMark', 'AceEvent-3.0', 'AceConsole-3.0') 
local NPCMark_1e41ab854b6901e6397b4db24aacd161 = { 
[MAP_MARK_FLY1] = MAP_MARK_FLY, 
[MAP_MARK_FLY2] = MAP_MARK_FLY, 
[MAP_MARK_FLY3] = MAP_MARK_FLY, 
[MAP_MARK_FLY4] = MAP_MARK_FLY,
[MAP_MARK_FLY5] = MAP_MARK_FLY, 
[MAP_MARK_FLYING] = MAP_MARK_PROF_RIDING, 
[MAP_MARK_DAIBI1] = MAP_MARK_ZHENFU, 
[MAP_MARK_DAIBI2] = MAP_MARK_ZHENFU, 
[MAP_MARK_DAIBI3] = MAP_MARK_ZHENFU, 
[MAP_MARK_DAIBI4] = MAP_MARK_ZHENFU, 
[MAP_MARK_DAIBI5] = MAP_MARK_ZHENFU, 
[MAP_MARK_DAIBI6] = MAP_MARK_ZHENFU, 
[MAP_MARK_GLADIUS]= MAP_MARK_ZHENFU, 
} 
NPCMarkMappingDB = NPCMarkMappingDB or NPCMark_1e41ab854b6901e6397b4db24aacd161 
local MAP_MARK_TEXTURE = { 
[MAP_MARK_PROF_MAGE] = "Interface\\AddOns\\NPCMark\\icon\\26", 
[MAP_MARK_PROF_PRIEST] = "Interface\\AddOns\\NPCMark\\icon\\31", 
[MAP_MARK_PROF_WARLOCK] = "Interface\\AddOns\\NPCMark\\icon\\32", 
[MAP_MARK_PROF_ROGUE] = "Interface\\AddOns\\NPCMark\\icon\\27", 
[MAP_MARK_PROF_DRUID] = "Interface\\AddOns\\NPCMark\\icon\\28", 
[MAP_MARK_PROF_HUNTER] = "Interface\\AddOns\\NPCMark\\icon\\29", 
[MAP_MARK_PROF_SHAMAN] = "Interface\\AddOns\\NPCMark\\icon\\30", 
[MAP_MARK_PROF_WARRIOR] = "Interface\\AddOns\\NPCMark\\icon\\25", 
[MAP_MARK_PROF_PALADIN] = "Interface\\AddOns\\NPCMark\\icon\\33", 
[MAP_MARK_PROF_DEATHKNIGHT] = "Interface\\AddOns\\NPCMark\\icon\\34", 
[MAP_MARK_SKILL_ALCHE] = "Interface\\AddOns\\NPCMark\\icon\\2", 
[MAP_MARK_PROF_BLACKSMITH] = "Interface\\AddOns\\NPCMark\\icon\\17", 
[MAP_MARK_PROF_ENCHANTING] = "Interface\\AddOns\\NPCMark\\icon\\19", 
[MAP_MARK_PROF_ENGINEERING] = "Interface\\AddOns\\NPCMark\\icon\\18", 
[MAP_MARK_PROF_HERBALISM] = "Interface\\AddOns\\NPCMark\\icon\\21", 
[MAP_MARK_PROF_INSCRIPTION] = "Interface\\AddOns\\NPCMark\\icon\\9", 
[MAP_MARK_PROF_JEWEL] = "Interface\\AddOns\\NPCMark\\icon\\12", 
[MAP_MARK_PROF_LEATHERWORKING] = "Interface\\AddOns\\NPCMark\\icon\\22", 
[MAP_MARK_PROF_MINING] = "Interface\\AddOns\\NPCMark\\icon\\23", 
[MAP_MARK_PROF_SKINNING] = "Interface\\AddOns\\NPCMark\\icon\\13", 
[MAP_MARK_PROF_TAILORING] = "Interface\\AddOns\\NPCMark\\icon\\24", 
[MAP_MARK_PROF_ARCHAEOLOGY] = "Interface\\AddOns\\NPCMark\\icon\\36", 
[MAP_MARK_PROF_COOKING] = "Interface\\AddOns\\NPCMark\\icon\\11", 
[MAP_MARK_PROF_FIRSTAID] = "Interface\\AddOns\\NPCMark\\icon\\1", 
[MAP_MARK_PROF_FISHING] = "Interface\\AddOns\\NPCMark\\icon\\20", 
[MAP_MARK_PROF_RIDING] = "Interface\\AddOns\\NPCMark\\icon\\16", 
[MAP_MARK_INN] = "Interface\\AddOns\\NPCMark\\icon\\35", 
[MAP_MARK_FLY] = "Interface\\AddOns\\NPCMark\\icon\\3", 
[MAP_MARK_PORTAL] = "Interface\\AddOns\\NPCMark\\icon\\15", 
[MAP_MARK_AUCTION] = "Interface\\AddOns\\NPCMark\\icon\\7", 
[MAP_MARK_BANK] = "Interface\\AddOns\\NPCMark\\icon\\14", 
[MAP_MARK_BARBER] = "Interface\\AddOns\\NPCMark\\icon\\8", 
[MAP_MARK_MATERIAL] = "Interface\\AddOns\\NPCMark\\icon\\10", 
[MAP_MARK_STABLE] = "Interface\\AddOns\\NPCMark\\icon\\4", 
[MAP_MARK_REFORGE] = "Interface\\AddOns\\NPCMark\\icon\\40", 
[MAP_MARK_DUMMY] = "Interface\\AddOns\\NPCMark\\icon\\38", 
[MAP_MARK_ZHENFU] = "Interface\\AddOns\\NPCMark\\icon\\37", 
[MAP_MARK_HUANHUA] = "Interface\\AddOns\\NPCMark\\icon\\41", 
[MAP_MARK_XUKONGYINHANG] = "Interface\\AddOns\\NPCMark\\icon\\42", 
} 
local MAP_MARK_MAPPING = { 
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
} 
local MAP_MARK_MAPPING_TABLE = { 
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
MAP_MARK_INN, 
MAP_MARK_FLY, 
MAP_MARK_PORTAL, 
MAP_MARK_AUCTION, 
MAP_MARK_BANK, 
MAP_MARK_BARBER, 
MAP_MARK_MATERIAL, 
MAP_MARK_STABLE, 
MAP_MARK_REFORGE, 
MAP_MARK_DUMMY, 
MAP_MARK_ZHENFU, 
MAP_MARK_HUANHUA, 
MAP_MARK_XUKONGYINHANG, 
} 
local NPCMark_0ff1475236b21cc42bc579ef6b84a020,node_index,NPCMark_3657b630f9b53060aa76a1ee4510bd5f,NPCMark_9ca550a56becdad16e94feb95e9237b0 
local NPCMark_4b7e2bce87cb1e096550a2c098d5f6be = 20 
local NPCMark_Version = 1; 
local NPCMark_69dc0ff56f05b8a9c0dc97f0140b0336 = { 
["Orc"] = 1, 
["Tauren"] = 1, 
["Scourge"] = 1, 
["BloodElf"] = 1,
["Troll"] = 1, 
["Goblin"] = 1,
["Human"] = 2, 
["NightElf"] = 2, 
["Dwarf"] = 2, 
["Gnome"] = 2, 
["Draenei"] = 2, 
["Worgen"] = 2, 
} 
local function NPCMark_cecd484ed994ee493c136b4358a71f4f(NPCMark_eab765600dfa4f607423084a1db7c624) if NPCMark_eab765600dfa4f607423084a1db7c624 and NPCMark_69dc0ff56f05b8a9c0dc97f0140b0336[NPCMark_eab765600dfa4f607423084a1db7c624] then 
return NPCMark_69dc0ff56f05b8a9c0dc97f0140b0336[NPCMark_eab765600dfa4f607423084a1db7c624]; 
end 
end 

local function NPCMark_f6f8040d54edbe4fc64f71ead6dde464(NPCMark_6d5e7d83d8358745ae4dcf61d16bd1f3) 
if NPCMarkMappingDB[NPCMark_6d5e7d83d8358745ae4dcf61d16bd1f3] then 
return NPCMarkMappingDB[NPCMark_6d5e7d83d8358745ae4dcf61d16bd1f3] 
end 
for _,val in pairs(MAP_MARK_MAPPING_TABLE) do 
if string.find(NPCMark_6d5e7d83d8358745ae4dcf61d16bd1f3,val) or string.find(val,NPCMark_6d5e7d83d8358745ae4dcf61d16bd1f3) then 
NPCMarkMappingDB[NPCMark_6d5e7d83d8358745ae4dcf61d16bd1f3] = val 
return val 
end 
end 
return "" 
end 

local function NPCMark_9236e608897a51c47b0385bd340ee860() 
NPCMarkDB = {} 
NPCMarkDB.showMarks = true; 
NPCMarkDB.version = NPCMark_Version; 
_,localized = UnitClass("player"); 
if _G["MAP_MARK_PROF_"..localized] then 
NPCMarkDB[_G["MAP_MARK_PROF_"..localized]] = true 
end 
local professionList = {GetProfessions()} 
for _,_profIndex in pairs(professionList) do 
local skillName = GetProfessionInfo(_profIndex) 
local mapping = MAP_MARK_MAPPING[skillName] 
if mapping 
then NPCMarkDB[mapping] = true 
end 
end 
NPCMarkDB[MAP_MARK_ZHENFU] = true 
NPCMarkDB[MAP_MARK_DUMMY] = true 
NPCMarkDB[MAP_MARK_REFORGE] = true 
NPCMarkDB[MAP_MARK_PROF_RIDING] = true 
NPCMarkDB[MAP_MARK_INN] = true 
NPCMarkDB[MAP_MARK_FLY] = true 
NPCMarkDB[MAP_MARK_AUCTION] = true 
NPCMarkDB[MAP_MARK_BANK] = true 
NPCMarkDB[MAP_MARK_MATERIAL] = true 
NPCMarkDB[MAP_MARK_HUANHUA] = true 
NPCMarkDB[MAP_MARK_XUKONGYINHANG] = true 
end 

function NPCM_ToggleEnable(NPCMark_7739b813d90aed43ab9d0eb84ec1c1ae) 
if ( NPCMark_7739b813d90aed43ab9d0eb84ec1c1ae == 1 ) then 
NPCMark_3657b630f9b53060aa76a1ee4510bd5f = 1; 
if (not NPCMark_0ff1475236b21cc42bc579ef6b84a020) then 
WorldMapFrame:HookScript("OnUpdate", NPCMark_359af385f8090e4c5839f533807d0e06); NPCMark_0ff1475236b21cc42bc579ef6b84a020 = true; 
if (WorldMapFrame:HasScript("OnShow")) then 
WorldMapFrame:HookScript("OnShow", NPCMark_ae42389ca37ac306b6bc3f5dfc08ff0d); 
else 
WorldMapFrame:SetScript("OnShow", NPCMark_ae42389ca37ac306b6bc3f5dfc08ff0d); 
end 
if NPCMarkDB.showHDMarks ~= false then 
NPCMarkDB.showHDMarks = true 
end 
end 
else 
NPCMark_3657b630f9b53060aa76a1ee4510bd5f = nil; 
end 
end

 local MapMarkDDTable = { 
 [MAP_MARK_PROF] = { [MAP_MARK_PROF_MAGE] = {func = true}, 
 [MAP_MARK_PROF_PRIEST] = {func = true}, 
 [MAP_MARK_PROF_WARLOCK] = {func = true}, 
 [MAP_MARK_PROF_ROGUE] = {func = true}, 
 [MAP_MARK_PROF_DRUID] = {func = true}, 
 [MAP_MARK_PROF_HUNTER] = {func = true}, 
 [MAP_MARK_PROF_SHAMAN] = {func = true}, 
 [MAP_MARK_PROF_WARRIOR] = {func = true}, 
 [MAP_MARK_PROF_PALADIN] = {func = true}, 
 [MAP_MARK_PROF_DEATHKNIGHT] = {func = true}, }, 
 [MAP_MARK_SKILL] = { [MAP_MARK_SKILL_ALCHE] = {func = true}, 
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
 [MAP_MARK_PROF_FISHING] = {func = true}, }, 
 [MAP_MARK_ZHENFU] = { func = true }, 
 [MAP_MARK_DUMMY] = { func = true }, 
 [MAP_MARK_REFORGE] = { func = true }, 
 [MAP_MARK_PROF_RIDING] = { func = true }, 
 [MAP_MARK_INN] = { func = true }, 
 [MAP_MARK_FLY] = { func = true }, 
 [MAP_MARK_PORTAL] = { func = true }, 
 [MAP_MARK_AUCTION] = { func = true }, 
 [MAP_MARK_BANK] = { func = true }, 
 [MAP_MARK_BARBER] = { func = true }, 
 [MAP_MARK_MATERIAL] = { func = true }, 
 [MAP_MARK_STABLE] = { func = true }, 
 [MAP_MARK_HUANHUA] = { func = true }, 
 [MAP_MARK_XUKONGYINHANG] = { func = true }, 
 } 
 function MapMarkDDInit(self,level) level = level or 1; if (level == 1) then for key, subarray in pairs(MapMarkDDTable) do local info = UIDropDownMenu_CreateInfo(); info.text = key; if subarray.func then info.hasArrow = false; info.func = function() NPCMarkDB[key] = not NPCMarkDB[key] end info.checked = NPCMarkDB[key] else info.hasArrow = true; info.value = { ["Level1_Key"] = key; }; end UIDropDownMenu_AddButton(info, level); end end if (level == 2) then local Level1_Key = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"]; local subarray = MapMarkDDTable[Level1_Key]; for key, subsubarray in pairs(subarray) do local info = UIDropDownMenu_CreateInfo(); info.hasArrow = false; info.text = key info.func = function() NPCMarkDB[key] = not NPCMarkDB[key] end info.checked = NPCMarkDB[key] UIDropDownMenu_AddButton(info, level); end end end 
function NPCMark_ae42389ca37ac306b6bc3f5dfc08ff0d() if (not NPCMark_3657b630f9b53060aa76a1ee4510bd5f) then MapPlusDDList:Hide(); MapMarkCheckButton:Hide(); return; end if not NPCMarkDB or not NPCMarkDB.version or NPCMarkDB.version < NPCMark_Version then NPCMarkMappingDB = NPCMark_1e41ab854b6901e6397b4db24aacd161; NPCMark_9236e608897a51c47b0385bd340ee860(); end UIDropDownMenu_Initialize(MapPlusDDList,MapMarkDDInit) UIDropDownMenu_SetText(MapPlusDDList,MAPMARK_TITLE) MapPlusDDList:Show() MapMarkCheckButton:Show() end local function NPCMark_29d25e5d8154c1c2dadff565b8168746(type) if NPCMarkDB[NPCMark_f6f8040d54edbe4fc64f71ead6dde464(type)] then return true end return false end local function coord_transform(width,height,x,y) return x*width/100,-y*height/100 end local function showNodes(_type,name,...) local function NPCMark_61b0f31e4b21af9208673d48030ca9bd(name,_type,x,y) local texture = MAP_MARK_TEXTURE[NPCMark_f6f8040d54edbe4fc64f71ead6dde464(_type) ] local button = _G["MapMark"..node_index] if not button then button = CreateFrame("Button","MapMark"..node_index,WorldMapDetailFrame,"MapMarkTemplate") end button:SetPoint("CENTER",WorldMapDetailFrame,"TOPLEFT",coord_transform(WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight(),x,y)) _G[button:GetName().."Icon"]:SetTexture(texture); button.text2 = name button.text = _type node_index = node_index + 1 button:Show() end local _coord = ... NPCMark_61b0f31e4b21af9208673d48030ca9bd(name,_type,_coord[1],_coord[2]) end local function NPCMark_812d2af89b43bd82cf0624ad0b469cfb() local _i = 1 while _G["MapMark".._i] do _G["MapMark".._i]:Hide() _i = _i + 1 end end local function NPCMark_d818d134e9a84a0317a401c4f9b56394() local NPCMark_2d8ff25b2888f058a5d1486167a7958d = GetCurrentMapZone(); if NPCMark_2d8ff25b2888f058a5d1486167a7958d >0 then local NPCMark_a190c73192fb348b1958a964b277b50f = GetCurrentMapDungeonLevel(); if NPCMark_a190c73192fb348b1958a964b277b50f == 0 then NPCMark_a190c73192fb348b1958a964b277b50f = 1 end return select(NPCMark_2d8ff25b2888f058a5d1486167a7958d,GetMapZones(GetCurrentMapContinent())), NPCMark_a190c73192fb348b1958a964b277b50f; end end function NPCMark_359af385f8090e4c5839f533807d0e06(self) NPCMark_812d2af89b43bd82cf0624ad0b469cfb(); if not MapPlusNodeData then return end if not NPCMark_3657b630f9b53060aa76a1ee4510bd5f then return end if NPCMark_9ca550a56becdad16e94feb95e9237b0 then return end local NPCMark_adf50fa6c4713aee1862a5c0c23c11ca, NPCMark_a190c73192fb348b1958a964b277b50f = NPCMark_d818d134e9a84a0317a401c4f9b56394(); node_index = 1; if NPCMark_adf50fa6c4713aee1862a5c0c23c11ca and MapPlusNodeData[NPCMark_adf50fa6c4713aee1862a5c0c23c11ca] then local NPCMark_e3fa270ad54568d4711e0138168a0345 = MapPlusNodeData[NPCMark_adf50fa6c4713aee1862a5c0c23c11ca]; for _,NPCMark_a4ae8f1b50c7593a1bada9f62d1883fb in pairs(NPCMark_e3fa270ad54568d4711e0138168a0345) do if NPCMark_29d25e5d8154c1c2dadff565b8168746(NPCMark_a4ae8f1b50c7593a1bada9f62d1883fb[1]) and NPCMark_a4ae8f1b50c7593a1bada9f62d1883fb[4] and NPCMark_a4ae8f1b50c7593a1bada9f62d1883fb[4] == NPCMark_a190c73192fb348b1958a964b277b50f then showNodes(NPCMark_a4ae8f1b50c7593a1bada9f62d1883fb[1],NPCMark_a4ae8f1b50c7593a1bada9f62d1883fb[2],select(3,unpack(NPCMark_a4ae8f1b50c7593a1bada9f62d1883fb))) end end end end local function IsButtonsAdjacent(button1, button2) local NPCMark_bb09ff53f73097f772bbad85ab4789a3, NPCMark_8564354d3dfe092927e7594edd6b33ae = button1:GetCenter(); local NPCMark_05a093d743a51039be6b1ba936768e35, NPCMark_a42ee07c25fc8757c49710ea97cea40d = button2:GetCenter(); return ((NPCMark_bb09ff53f73097f772bbad85ab4789a3-NPCMark_05a093d743a51039be6b1ba936768e35)^2 + (NPCMark_8564354d3dfe092927e7594edd6b33ae-NPCMark_a42ee07c25fc8757c49710ea97cea40d)^2 <200) end function MapMarkPoint_OnEnter(self) local NPCMark_b254e387cf58e982ba24fcb3e8a63995, NPCMark_a0f453fd098c0b0fda780f69cda6ffbf = self:GetCenter(); local NPCMark_bef0afa8f0e35507e468dab3fd56505f = self:GetParent():GetCenter(); if ( NPCMark_b254e387cf58e982ba24fcb3e8a63995 > NPCMark_bef0afa8f0e35507e468dab3fd56505f ) then NPCMTooltip:SetOwner(self, "ANCHOR_LEFT"); else NPCMTooltip:SetOwner(self, "ANCHOR_RIGHT"); end NPCMTooltip:AddLine(self.text) local font = _G["NPCMTooltipTextLeft"..NPCMTooltip:NumLines()]:GetFontObject() NPCMTooltip:AddLine(self.text2) _G["NPCMTooltipTextLeft"..NPCMTooltip:NumLines()]:SetTextColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b) _i = 1 while _G["MapMark".._i] do local button = _G["MapMark".._i] if button:IsShown() and button ~= self and IsButtonsAdjacent(button,self) then NPCMTooltip:AddLine(" ") NPCMTooltip:AddLine(button.text) _G["NPCMTooltipTextLeft"..NPCMTooltip:NumLines()]:SetFontObject(font) NPCMTooltip:AddLine(button.text2) _G["NPCMTooltipTextLeft"..NPCMTooltip:NumLines()]:SetTextColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b) end _i = _i + 1 end NPCMTooltip:Show(); end function MapMarkPoint_OnLeave(self) NPCMTooltip:Hide(); end 
 function MapMarkToggleEnable(tog) if tog then NPCMark_9ca550a56becdad16e94feb95e9237b0 = false else NPCMark_9ca550a56becdad16e94feb95e9237b0 = true end end local function NPCMark_edfa68f7ef48f8ae29759b006ee71b34(NPCMark_be37ab0a08e250377f09b21f7f74a71e,NPCMark_d0864e7a52e7f3d322cf456b509d48bf) return (NPCMark_be37ab0a08e250377f09b21f7f74a71e[1]-NPCMark_d0864e7a52e7f3d322cf456b509d48bf[1])^2 + (NPCMark_be37ab0a08e250377f09b21f7f74a71e[2]-NPCMark_d0864e7a52e7f3d322cf456b509d48bf[2])^2 end local function NPCMark_1c45ec5041638b82e077003f76943218(NPCMark_c1b30b66a595a35d35ab304c8daa9664, NPCMark_209d9f753a029c679126b146ee03333d) if not NPCMark_c1b30b66a595a35d35ab304c8daa9664 or not NPCMark_c1b30b66a595a35d35ab304c8daa9664[NPCMark_f6f8040d54edbe4fc64f71ead6dde464(NPCMark_209d9f753a029c679126b146ee03333d[1])] then return false end for _,NPCMark_bb21ccee710d89f1dd77348af145dc7d in pairs(NPCMark_c1b30b66a595a35d35ab304c8daa9664[NPCMark_f6f8040d54edbe4fc64f71ead6dde464(NPCMark_209d9f753a029c679126b146ee03333d[1])]) do if NPCMark_edfa68f7ef48f8ae29759b006ee71b34(NPCMark_bb21ccee710d89f1dd77348af145dc7d,NPCMark_209d9f753a029c679126b146ee03333d[3]) < NPCMark_4b7e2bce87cb1e096550a2c098d5f6be then return true end end return false end 
 local function NPCMark_1067d4f42bf9e87dc11131765aa8e9d0(_table) if type(_table) ~= "table" then return end
local NPCMark_b5085455be65cc330a574cd792f9b28e = {} local NPCMark_06a53a26ccf4c2754a46f883c434b6f6 ={} for _,NPCMark_209d9f753a029c679126b146ee03333d in pairs(_table) do NPCMark_b5085455be65cc330a574cd792f9b28e[NPCMark_f6f8040d54edbe4fc64f71ead6dde464(NPCMark_209d9f753a029c679126b146ee03333d[1])] = NPCMark_b5085455be65cc330a574cd792f9b28e[NPCMark_f6f8040d54edbe4fc64f71ead6dde464(NPCMark_209d9f753a029c679126b146ee03333d[1])] or {} if not NPCMark_1c45ec5041638b82e077003f76943218(NPCMark_b5085455be65cc330a574cd792f9b28e,NPCMark_209d9f753a029c679126b146ee03333d) and (NPCMark_209d9f753a029c679126b146ee03333d[5] and NPCMark_209d9f753a029c679126b146ee03333d[5] ~= NPCMark_cecd484ed994ee493c136b4358a71f4f(select(2,UnitRace("player"))) or not NPCMark_209d9f753a029c679126b146ee03333d[5]) then tinsert(NPCMark_b5085455be65cc330a574cd792f9b28e[NPCMark_f6f8040d54edbe4fc64f71ead6dde464(NPCMark_209d9f753a029c679126b146ee03333d[1])],NPCMark_209d9f753a029c679126b146ee03333d[3]) tinsert(NPCMark_06a53a26ccf4c2754a46f883c434b6f6,NPCMark_209d9f753a029c679126b146ee03333d) end end return NPCMark_06a53a26ccf4c2754a46f883c434b6f6 end local function NPCMark_7b09dafd8709fb460af554a05f285f0e() for NPCMark_8983c60d66c8593ec7165ea9dbedb584,NPCMark_49ccc92cd1bef60d860c1c7f84aaab89 in pairs(MapPlusNodeData) do MapPlusNodeData[NPCMark_8983c60d66c8593ec7165ea9dbedb584] = NPCMark_1067d4f42bf9e87dc11131765aa8e9d0(NPCMark_49ccc92cd1bef60d860c1c7f84aaab89) end end 
 function NPCMark:OnInitialize() 
 NPCMark_7b09dafd8709fb460af554a05f285f0e() 
 end 
 
 function NPCMark:OnEnable() 
 NPCM_ToggleEnable(1) 
 end 
 
 function NPCMark:OnDisable() 
 NPCM_ToggleEnable(0) 
 end 
