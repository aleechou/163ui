if IsAddOnLoaded("Malkorok") then return end

DBM.MalHelperEnabled = false

local MSG_PREFIX = "MHADD"

local tmr = 0
local ExRTmods = {}
local ExRT_Optpanel = {}

ExRTmods.defFont = STANDARD_TEXT_FONT

-----------------------------------------
-- functions
-----------------------------------------

function ExRTmods:SendExMsg(prefix, msg, tochat, touser)
	local n = GetNumGroupMembers() or 0 if tochat == nil and touser ==nil and n <=1 then tochat = "WHISPER" touser = UnitName("player") end
	if msg == nil then msg = "" end
	if tochat ~= nil and touser == nil then
		SendAddonMessage(MSG_PREFIX, prefix .. "\t" .. msg, tochat)
	elseif tochat ~= nil and touser ~= nil then
		SendAddonMessage(MSG_PREFIX, prefix .. "\t" .. msg, tochat,touser)
	else
		local inraid = IsInRaid()
		if inraid == false then inraid = "PARTY" else inraid = "RAID" end
		SendAddonMessage(MSG_PREFIX, prefix .. "\t" .. msg, inraid)
	end
end



-----------------------------------------
-- Malkorok
-----------------------------------------
local malkorok_mainframe = nil
local malkorok_mainframe_pie = {}
local malkorok_mainframe_aoecd = nil
local malkorok_mainframe_lock = nil
local malkorok_tmr = 0
local malkorok_main_coord_top_x = 0.36427
local malkorok_main_coord_top_y = 0.34581
local malkorok_main_coord_bot_x = 0.46707
local malkorok_main_coord_bot_y = 0.50000

local malkorok_width = 200
local malkorok_height = 200
local malkorok_playericonsize = 32

local malkorok_backdrop = {}

local malkorok_iconshow = 0
local malkorok_dangershow = 0

local malkorok_spell = "142842"
local malkorok_spell_baoe = "142861"

local malkorok_baoe_num = 0

local malkorok_raid_marks_e = false
local malkorok_raid_marks = {}

local malkorok_rotate = false

local malkorok_center = 84
local malkorok_pie_coord = {
{{84,84},{82,-15},{-10,27}},	--1
{{84,84},{-10,27},{-10,138}},	--2
{{84,84},{-10,138},{82,185}},	--3
{{84,84},{82,185},{177,135}},	--4
{{84,84},{177,135},{177,27}},	--5
{{84,84},{177,27},{82,-15}},	--6
}

local malkorok_pie_status = {0,0,0,0,0,0,0,0}

local function MalkorokDanger(u)
	if u == 1 then
		malkorok_mainframe.Danger:Show() 
		malkorok_dangershow = 1
		malkorok_mainframe:SetBackdropColor(0.5,0,0,0.7);
		malkorok_mainframe:SetBackdropBorderColor(1,0.2,0.2,0.9);
	else
		malkorok_mainframe.Danger:Hide() 
		malkorok_dangershow = 0
		malkorok_mainframe:SetBackdropColor(0,0,0,0.5);
		malkorok_mainframe:SetBackdropBorderColor(0.2,0.2,0.2,0.4);
	end
end

local function MalkorokPShow()
	malkorok_raid_marks_e = not malkorok_raid_marks_e

	if malkorok_raid_marks[1]==nil then
		for i=1,40 do
			malkorok_raid_marks[i] = CreateFrame("Frame",nil,malkorok_mainframe);
			malkorok_raid_marks[i]:SetHeight(16);
			malkorok_raid_marks[i]:SetWidth(16);
			malkorok_raid_marks[i]:SetPoint("TOPLEFT",malkorok_mainframe, "TOPLEFT", 0, 0);
			malkorok_raid_marks[i]:SetBackdrop({bgFile = "Interface\\AddOns\\DBM-SiegeOfOrgrimmar\\Textures\\blip.tga",tile = true,tileSize = 16});
			malkorok_raid_marks[i]:SetBackdropColor(0,1,0,0.8);
			malkorok_raid_marks[i]:SetFrameStrata("HIGH")
			malkorok_raid_marks[i]:Hide()
		end
	end
end

local function MalkorokCursor()
	local x,y = GetCursorPosition()

	local x1, y1 = malkorok_mainframe:GetCenter()
	local x2, y2 = malkorok_mainframe:GetSize()

	local malkorok_mainframe_scale = malkorok_mainframe:GetScale()
	local uiparent_scale = UIParent:GetScale()
	x1 = x1 * malkorok_mainframe_scale*uiparent_scale
	y1 = y1 * malkorok_mainframe_scale*uiparent_scale

	x2 = x2 * malkorok_mainframe_scale*uiparent_scale
	y2 = y2 * malkorok_mainframe_scale*uiparent_scale

	x1 = x1-x2/2;
	y1 = y1+y2/2;

	x = x - x1
	y = -(y - y1)

	x = x / malkorok_mainframe:GetScale()
	y = y / malkorok_mainframe:GetScale()

	return x,y
end

local Malkorok_rotate_coords={	tl={x=0,y=0},
				bl={x=0,y=180/256},
				tr={x=180/256,y=0},
				br={x=180/256,y=180/256}}
local Malkorok_rotate_origin={x=90/256,y=90/256}
local Malkorok_rotate_aspect=1
local Malkorok_rotate_angle = 0

local function Malkorok_RotateCoordPair (x,y,ox,oy,a,asp)
	y=y/asp
	oy=oy/asp
	if a == nil then return x,y end
	return ox + (x-ox)*math.cos(a) - (y-oy)*math.sin(a),
		(oy + (y-oy)*math.cos(a) + (x-ox)*math.sin(a))*asp
end

local Malkorok_def_angle = (3.14159/180)*8

do
	if Malkorok_def_angle~=0 then
		for i=1,6 do for j=2,3 do
			malkorok_pie_coord[i][j][1],malkorok_pie_coord[i][j][2] = Malkorok_RotateCoordPair(malkorok_pie_coord[i][j][1],malkorok_pie_coord[i][j][2],malkorok_pie_coord[i][1][1],malkorok_pie_coord[i][1][2],-Malkorok_def_angle,1)
		end end
	end
end

local function Malkorok_def_angle_rotate()
	local g1,g2 = Malkorok_RotateCoordPair(Malkorok_rotate_coords.tl.x,Malkorok_rotate_coords.tl.y,Malkorok_rotate_origin.x,Malkorok_rotate_origin.y,Malkorok_def_angle,Malkorok_rotate_aspect)
	local g3,g4 = Malkorok_RotateCoordPair(Malkorok_rotate_coords.bl.x,Malkorok_rotate_coords.bl.y,Malkorok_rotate_origin.x,Malkorok_rotate_origin.y,Malkorok_def_angle,Malkorok_rotate_aspect)
	local g5,g6 = Malkorok_RotateCoordPair(Malkorok_rotate_coords.tr.x,Malkorok_rotate_coords.tr.y,Malkorok_rotate_origin.x,Malkorok_rotate_origin.y,Malkorok_def_angle,Malkorok_rotate_aspect)
	local g7,g8 = Malkorok_RotateCoordPair(Malkorok_rotate_coords.br.x,Malkorok_rotate_coords.br.y,Malkorok_rotate_origin.x,Malkorok_rotate_origin.y,Malkorok_def_angle,Malkorok_rotate_aspect)

	for i=1,6 do		
		malkorok_mainframe_pie[i].tex:SetTexCoord(g1,g2,g3,g4,g5,g6,g7,g8)
	end
end

local function Malkorokfindpie(px1,py1,pxy)
	for i=1,6 do

		local g11,g12 = malkorok_pie_coord[i][1][1],malkorok_pie_coord[i][1][2]
		local g21,g22 = malkorok_pie_coord[i][2][1],malkorok_pie_coord[i][2][2]
		local g31,g32 = malkorok_pie_coord[i][3][1],malkorok_pie_coord[i][3][2]
		if malkorok_rotate == true and pxy == 1 then
			g21,g22= Malkorok_RotateCoordPair(g21,g22,malkorok_center,malkorok_center,-Malkorok_rotate_angle+Malkorok_def_angle,1)
			g31,g32= Malkorok_RotateCoordPair(g31,g32,malkorok_center,malkorok_center,-Malkorok_rotate_angle+Malkorok_def_angle,1)
		end

		local d1 = sqrt( (g11-px1)^2 + (g12-py1)^2 )
		local d2 = sqrt( (g21-px1)^2 + (g22-py1)^2 )
		local d3 = sqrt( (g31-px1)^2 + (g32-py1)^2 )

		local o1 = sqrt( (g11-g21)^2 + (g12-g22)^2 )
		local o2 = sqrt( (g21-g31)^2 + (g22-g32)^2 )
		local o3 = sqrt( (g31-g11)^2 + (g32-g12)^2 )

		if d1 == 0 or d2 == 0 or d3 == 0 then return 0 end
		local r1 = (o1*o1-d1*d1-d2*d2)/(2*d1*d2)
		local r2 = (o2*o2-d2*d2-d3*d3)/(2*d2*d3)
		local r3 = (o3*o3-d3*d3-d1*d1)/(2*d3*d1)

		local cos1 = acos(r1)+acos(r2)+acos(r3)

		if cos1 > 179 and cos1 < 181 then return i end
	end
	return 0
end

local function Malkoroktimerfunc(self,elapsed)
	malkorok_tmr = malkorok_tmr + elapsed
	if malkorok_tmr > 0.05 then
		local px, py = GetPlayerMapPosition("player")
		if ( px == 0 and py == 0 and malkorok_raid_marks_e~=true) then return end
		if px >= malkorok_main_coord_top_x and px<=malkorok_main_coord_bot_x and py>=malkorok_main_coord_top_y and py<=malkorok_main_coord_bot_y then
			if malkorok_iconshow == 0 then malkorok_iconshow = 1 malkorok_mainframe.PlayerIcon:Show() end
			local px1 = (px-malkorok_main_coord_top_x)/(malkorok_main_coord_bot_x-malkorok_main_coord_top_x)*(malkorok_width-20)+10-(malkorok_playericonsize/2)
			local py1 = (py-malkorok_main_coord_top_y)/(malkorok_main_coord_bot_y-malkorok_main_coord_top_y)*(malkorok_height-20)+10-(malkorok_playericonsize/2)

			local numpie = Malkorokfindpie(px1,py1)

			if malkorok_rotate ~= true then
				malkorok_mainframe.PlayerIcon:SetPoint("TOPLEFT",malkorok_mainframe, "TOPLEFT", px1, -py1);
				malkorok_mainframe.Player.Texture:SetRotation(GetPlayerFacing())
			end

			if numpie>0 and malkorok_pie_status[numpie] == 1 and malkorok_dangershow == 0 then 
				MalkorokDanger(1)
			elseif malkorok_dangershow == 1 and (numpie==0 or malkorok_pie_status[numpie] == 0) then
				MalkorokDanger()
			end

			if malkorok_rotate == true then
				local h1,h2,h3 = sqrt( (malkorok_center-px1)^2 + (200-py1)^2 ),sqrt( (malkorok_center-malkorok_center)^2 + (200-84)^2 ),sqrt( (malkorok_center-px1)^2 + (malkorok_center-py1)^2 )
				local h4 = (h2^2+h3^2-h1^2)/(2*h2*h3)
				h4 = acos(h4)
				if px1<malkorok_center then h4=360-h4 end
				h4 = -h4
				Malkorok_rotate_angle=3.14159/180*h4 + Malkorok_def_angle

				malkorok_mainframe.Player.Texture:SetRotation(Malkorok_rotate_angle+GetPlayerFacing()-Malkorok_def_angle)
				malkorok_mainframe.PlayerIcon:SetPoint("TOPLEFT",malkorok_mainframe, "TOPLEFT", malkorok_center, -malkorok_center-h3);

				local g1,g2 = Malkorok_RotateCoordPair(Malkorok_rotate_coords.tl.x,Malkorok_rotate_coords.tl.y,Malkorok_rotate_origin.x,Malkorok_rotate_origin.y,Malkorok_rotate_angle,Malkorok_rotate_aspect)
				local g3,g4 = Malkorok_RotateCoordPair(Malkorok_rotate_coords.bl.x,Malkorok_rotate_coords.bl.y,Malkorok_rotate_origin.x,Malkorok_rotate_origin.y,Malkorok_rotate_angle,Malkorok_rotate_aspect)
				local g5,g6 = Malkorok_RotateCoordPair(Malkorok_rotate_coords.tr.x,Malkorok_rotate_coords.tr.y,Malkorok_rotate_origin.x,Malkorok_rotate_origin.y,Malkorok_rotate_angle,Malkorok_rotate_aspect)
				local g7,g8 = Malkorok_RotateCoordPair(Malkorok_rotate_coords.br.x,Malkorok_rotate_coords.br.y,Malkorok_rotate_origin.x,Malkorok_rotate_origin.y,Malkorok_rotate_angle,Malkorok_rotate_aspect)

				for i=1,6 do		
					malkorok_mainframe_pie[i].tex:SetTexCoord(g1,g2,g3,g4,g5,g6,g7,g8)
				end
			end
		else
			if malkorok_iconshow == 1 then malkorok_iconshow = 0 malkorok_mainframe.PlayerIcon:Hide() end
			if malkorok_rotate == true then
				for i=1,6 do
					malkorok_mainframe_pie[i].tex:SetTexCoord(0,180/256,0,180/256)
				end	
				Malkorok_rotate_angle = 0
				if Malkorok_def_angle~=0 then Malkorok_def_angle_rotate() end
			end		
		end
		malkorok_tmr = 0

		local n = GetNumGroupMembers() or 0
		if n > 0 and malkorok_raid_marks_e == true then
			for j=1,n do
				local name, _,subgroup,_,_,class = GetRaidRosterInfo(j)
				if name ~= nil and subgroup <= 5 and UnitIsDeadOrGhost(name)~=1 then
					local px, py = GetPlayerMapPosition(name)
					if px == 0 and py == 0 then
						SetMapToCurrentZone()
						px, py = GetPlayerMapPosition(name)
					end
					if px >= malkorok_main_coord_top_x and px<=malkorok_main_coord_bot_x and py>=malkorok_main_coord_top_y and py<=malkorok_main_coord_bot_y then
						local px1 = (px-malkorok_main_coord_top_x)/(malkorok_main_coord_bot_x-malkorok_main_coord_top_x)*(malkorok_width-20)+10-(16/2)
						local py1 = (py-malkorok_main_coord_top_y)/(malkorok_main_coord_bot_y-malkorok_main_coord_top_y)*(malkorok_height-20)+10-(16/2)

						if malkorok_rotate == true then
							px1,py1 = Malkorok_RotateCoordPair(px1,py1,malkorok_center,malkorok_center,-Malkorok_rotate_angle+Malkorok_def_angle,1)
						end
			
						local color
						if class~= nil then color = RAID_CLASS_COLORS[class] end
						if color == nil then color = {r=1,g=0.5,b=0.5} end
						malkorok_raid_marks[j]:SetBackdropColor(color.r, color.g, color.b,1)
						malkorok_raid_marks[j]:SetPoint("TOPLEFT",malkorok_mainframe, "TOPLEFT", px1, -py1);
						malkorok_raid_marks[j]:Show();
					end
				else
					if malkorok_raid_marks[j]~=nil then malkorok_raid_marks[j]:Hide(); end
				end
			end
		end
	end
end

local function MalkorokEventHandler(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, event_n, _, _, _, _, _, _, _, _, _, spellId,spellName = ...
		if event_n == "SPELL_CAST_SUCCESS" and tostring(spellId) == malkorok_spell then
			for i=1,6 do  
				malkorok_pie_status[i]=0
				malkorok_mainframe_pie[i].tex:SetVertexColor(0,1,0,0.8);
			end
			if malkorok_baoe_num == 0 then 
				malkorok_mainframe_aoecd.cooldown:SetCooldown(GetTime(), 60)
				malkorok_baoe_num = 1
			else
				malkorok_baoe_num = 0
			end
		elseif event_n == "SPELL_CAST_SUCCESS" and tostring(spellId) == malkorok_spell_baoe then
			malkorok_baoe_num = 0
			malkorok_mainframe_aoecd.cooldown:SetCooldown(GetTime(), 64)
			for i=1,6 do  
				malkorok_pie_status[i]=0
				malkorok_mainframe_pie[i].tex:SetVertexColor(0,1,0,0.8);
			end
		end

	elseif event == "ZONE_CHANGED_NEW_AREA" then
		SetMapToCurrentZone()
		if GetCurrentMapAreaID() == 811 then
			malkorok_main_coord_top_x = 0.4284
			malkorok_main_coord_top_y = 0.4285
			malkorok_main_coord_bot_x = 0.4426
			malkorok_main_coord_bot_y = 0.4478
		elseif malkorok_main_coord_top_x ~= 0.36427 then
			malkorok_main_coord_top_x = 0.36427
			malkorok_main_coord_top_y = 0.34581
			malkorok_main_coord_bot_x = 0.46707
			malkorok_main_coord_bot_y = 0.50000
		end
	end
end

function ExRTmods:ExBossmodsGetExMsg(sender, prefix, ...)
	if malkorok_mainframe == nil then return end 
	if prefix == "malkorok" then
		local pienum,piecol = ...
		if tonumber(pienum)==nil or tonumber(pienum) == 0 then return end 
		pienum = tonumber(pienum)
		if pienum > 6 then return end
		if malkorok_pie_status[pienum] == 0 and piecol == "R" then
			malkorok_pie_status[pienum]=1
			malkorok_mainframe_pie[pienum].tex:SetVertexColor(1,0,0,0.8);
--			print(sender.." Set "..pienum.."to Danger")
		elseif malkorok_pie_status[pienum] == 1 and piecol == "G" then
			malkorok_pie_status[pienum]=0
			malkorok_mainframe_pie[pienum].tex:SetVertexColor(0,1,0,0.8);
--			print(sender.." Set "..pienum.."to Safe")
		end
	end
end

local function MalkorokLoad()
	if malkorok_mainframe ~= nil then return end
	malkorok_mainframe = CreateFrame("Frame","MHmalkorok_mainframe",UIParent);
	malkorok_mainframe:SetHeight(malkorok_width);
	malkorok_mainframe:SetWidth(malkorok_height);
	malkorok_mainframe:SetPoint("TOPLEFT",UIParent, "CENTER", 0, 0);
	if ExRT["Bossmods"]~=nil and ExRT["Bossmods"]["MalkorokLeft"]~= nil and ExRT["Bossmods"]["MalkorokTop"]~= nil then
		malkorok_mainframe:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",ExRT["Bossmods"]["MalkorokLeft"],ExRT["Bossmods"]["MalkorokTop"]);
	end
	malkorok_mainframe:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",edgeFile = "Interface\\AddOns\\DBM-SiegeOfOrgrimmar\\Textures\\border.tga",tile = false,edgeSize = 8});
	malkorok_mainframe:SetBackdropColor(0,0,0,0.5);
	malkorok_mainframe:SetBackdropBorderColor(0.2,0.2,0.2,0.4);
	malkorok_mainframe:EnableMouse(true);
	malkorok_mainframe:SetMovable(true);
	--malkorok_mainframe:SetClampedToScreen(true)
	malkorok_mainframe:RegisterForDrag("LeftButton");
	malkorok_mainframe:SetScript("OnDragStart", function(self)
		if self:IsMovable() then
			self:StartMoving()
		end
	end)
	malkorok_mainframe:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local x, y = self:GetCenter()
		local width_, height_ = self:GetSize()
		if ExRT["Bossmods"] == nil then ExRT["Bossmods"] = {} end
		ExRT["Bossmods"]["MalkorokLeft"] = x-width_/2;
		ExRT["Bossmods"]["MalkorokTop"] = y+height_/2;
	end)
	if ExRT["Bossmods"]["Alpha"] ~= nil then malkorok_mainframe:SetAlpha(ExRT["Bossmods"]["Alpha"]/100) end
	if ExRT["Bossmods"]["Scale"] ~= nil then malkorok_mainframe:SetScale(ExRT["Bossmods"]["Scale"]/100) end

	for i=1,6 do 
		malkorok_mainframe_pie[i] = CreateFrame("Frame","MHmalkorok_mainframe_pie_"..tostring(i),malkorok_mainframe);
		malkorok_mainframe_pie[i]:SetHeight(180);
		malkorok_mainframe_pie[i]:SetWidth(180);
		malkorok_mainframe_pie[i]:SetPoint("TOPLEFT",malkorok_mainframe, "TOPLEFT", 10, -10);

		malkorok_mainframe_pie[i].tex = malkorok_mainframe_pie[i]:CreateTexture(nil, "BACKGROUND")
		malkorok_mainframe_pie[i].tex:SetTexture("Interface\\AddOns\\DBM-SiegeOfOrgrimmar\\Textures\\Pie"..tostring(i)..".tga", true)
		malkorok_mainframe_pie[i].tex:SetPoint("TOPLEFT",malkorok_mainframe_pie[i], "TOPLEFT", 0, 0);
		malkorok_mainframe_pie[i].tex:SetTexCoord(0,180/256,0,180/256)
		malkorok_mainframe_pie[i].tex:SetHeight(180);
		malkorok_mainframe_pie[i].tex:SetWidth(180);

		malkorok_mainframe_pie[i].tex:SetVertexColor(0,1,0,0.8)
		malkorok_pie_status[i]=0
	end

	malkorok_mainframe:SetScript("OnMouseDown", function(self,button)
		local j1,j2 = MalkorokCursor()
		
		local j1o = j1-(malkorok_playericonsize/2)
		local j2o = j2-(malkorok_playericonsize/2)

		if j1o < 0 and j2o < 0 then
			if malkorok_mainframe_lock == nil then
				malkorok_mainframe_lock = true
				malkorok_mainframe.Lock.Texture:SetTexture("Interface\\AddOns\\DBM-SiegeOfOrgrimmar\\Textures\\lock.tga", false)
				malkorok_mainframe:SetMovable(false)
				ExRT["Bossmods"]["MalkorokLock"] = true
			else
				malkorok_mainframe_lock = nil
				malkorok_mainframe.Lock.Texture:SetTexture("Interface\\AddOns\\DBM-SiegeOfOrgrimmar\\Textures\\un_lock.tga", false)
				malkorok_mainframe:SetMovable(true)
				ExRT["Bossmods"]["MalkorokLock"] = nil
			end
		elseif j1o < 16 and j2o < 0 then
			if malkorok_rotate == true then
				ExRT["Bossmods"]["MalkorokRotate"] = false
				malkorok_rotate = false
				for i=1,6 do
					malkorok_mainframe_pie[i].tex:SetTexCoord(0,180/256,0,180/256)
				end
				Malkorok_rotate_angle = 0
				if Malkorok_def_angle~=0 then Malkorok_def_angle_rotate() end
				malkorok_mainframe.Rotate.Texture:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady", false)
			else
				ExRT["Bossmods"]["MalkorokRotate"] = true
				malkorok_rotate = true
				malkorok_mainframe.Rotate.Texture:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready", false)
			end
		end	

		local numpie = Malkorokfindpie(j1,j2,1)
		if (numpie > 0) and DBM.MalHelperEnabled then
			if malkorok_pie_status[numpie] == 0 and button == "LeftButton" then
				malkorok_pie_status[numpie]=1
				malkorok_mainframe_pie[numpie].tex:SetVertexColor(1,0,0,0.8);
			elseif malkorok_pie_status[numpie] == 1 and button == "RightButton" then
				malkorok_pie_status[numpie]=0
				malkorok_mainframe_pie[numpie].tex:SetVertexColor(0,1,0,0.8);
			end
			local col = "R"
			if button == "RightButton" then col = "G" end
			ExRTmods:SendExMsg("malkorok",tostring(numpie).."\t"..col)
		end
	end)

	malkorok_mainframe.PlayerIcon = CreateFrame("Frame",nil,malkorok_mainframe);
	malkorok_mainframe.PlayerIcon:SetHeight(malkorok_playericonsize);
	malkorok_mainframe.PlayerIcon:SetWidth(malkorok_playericonsize);
	--malkorok_mainframe.PlayerIcon:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"});
	--malkorok_mainframe.PlayerIcon:SetBackdropColor(1,0,0,0.5);

	malkorok_mainframe.Player = CreateFrame("Frame","MPIcon",malkorok_mainframe.PlayerIcon);
	malkorok_mainframe.Player:SetHeight(malkorok_playericonsize*1.5);
	malkorok_mainframe.Player:SetWidth(malkorok_playericonsize*1.5);
	malkorok_mainframe.Player:SetPoint("TOPLEFT",malkorok_mainframe.PlayerIcon, "TOPLEFT", -(malkorok_playericonsize/4), (malkorok_playericonsize/4));
	malkorok_mainframe.Player.Texture =malkorok_mainframe.Player:CreateTexture(nil, "ARTWORK")
	malkorok_mainframe.Player.Texture:SetAllPoints()
	malkorok_mainframe.Player.Texture:SetTexture("Interface\\MINIMAP\\MinimapArrow", false)

	malkorok_mainframe.Danger = CreateFrame("SimpleHTML", nil,malkorok_mainframe);
	malkorok_mainframe.Danger:SetText(MHExRTL.panelbossmodsmalkorokdanger)
	malkorok_mainframe.Danger:SetFont(ExRTmods.defFont, 18,"OUTLINE");
	malkorok_mainframe.Danger:SetHeight(12);
	malkorok_mainframe.Danger:SetWidth(80);
	malkorok_mainframe.Danger:SetPoint("CENTER", malkorok_mainframe,"TOP", 0,12);
	malkorok_mainframe.Danger:SetTextColor(1, 0.2, 0.2, 1)
	malkorok_mainframe.Danger:Hide()

	malkorok_mainframe.Lock = CreateFrame("Frame",nil,malkorok_mainframe);
	malkorok_mainframe.Lock:SetHeight(16);
	malkorok_mainframe.Lock:SetWidth(16);
	malkorok_mainframe.Lock:SetPoint("TOPLEFT",malkorok_mainframe, "TOPLEFT", 0, 0);
	malkorok_mainframe.Lock.Texture =malkorok_mainframe.Lock:CreateTexture(nil, "ARTWORK")
	--malkorok_mainframe.Lock.Texture:SetAllPoints()
	malkorok_mainframe.Lock.Texture:SetPoint("TOPLEFT",malkorok_mainframe.Lock, "TOPLEFT", 1, -1);
	malkorok_mainframe.Lock.Texture:SetSize(16,16)
	malkorok_mainframe.Lock.Texture:SetTexture("Interface\\AddOns\\DBM-SiegeOfOrgrimmar\\Textures\\un_lock.tga", false)
	if ExRT["Bossmods"]["MalkorokLock"] ~= nil then 
		malkorok_mainframe.Lock.Texture:SetTexture("Interface\\AddOns\\DBM-SiegeOfOrgrimmar\\Textures\\lock.tga", false)
		malkorok_mainframe_lock = true
		malkorok_mainframe:SetMovable(false)
	end

	malkorok_mainframe.Rotate = CreateFrame("Frame",nil,malkorok_mainframe);
	malkorok_mainframe.Rotate:SetHeight(16);
	malkorok_mainframe.Rotate:SetWidth(16);
	malkorok_mainframe.Rotate:SetPoint("TOPLEFT",malkorok_mainframe, "TOPLEFT", 16, 0);
	malkorok_mainframe.Rotate.Texture =malkorok_mainframe.Rotate:CreateTexture(nil, "ARTWORK")
	--malkorok_mainframe.Rotate.Texture:SetAllPoints()
	malkorok_mainframe.Rotate.Texture:SetPoint("TOPLEFT",malkorok_mainframe.Rotate, "TOPLEFT", 1, -1);
	malkorok_mainframe.Rotate.Texture:SetSize(15,15)
	malkorok_mainframe.Rotate.Texture:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady", false)
	if ExRT["Bossmods"]["MalkorokRotate"] == true then 
		malkorok_rotate = true
		malkorok_mainframe.Rotate.Texture:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready", false)
	else
		if Malkorok_def_angle~=0 then Malkorok_def_angle_rotate() end
	end

	if malkorok_raid_marks_e == true then
		for i=1,40 do
			malkorok_raid_marks[i] = CreateFrame("Frame",nil,malkorok_mainframe);
			malkorok_raid_marks[i]:SetHeight(16);
			malkorok_raid_marks[i]:SetWidth(16);
			malkorok_raid_marks[i]:SetPoint("TOPLEFT",malkorok_mainframe, "TOPLEFT", 0, 0);
			malkorok_raid_marks[i]:SetBackdrop({bgFile = "Interface\\AddOns\\DBM-SiegeOfOrgrimmar\\Textures\\blip.tga",tile = true,tileSize = 16});
			malkorok_raid_marks[i]:SetBackdropColor(0,1,0,0.8);
			malkorok_raid_marks[i]:SetFrameStrata("HIGH")
			malkorok_raid_marks[i]:Hide()
		end
	end

	malkorok_mainframe_aoecd = CreateFrame("Frame",nil,malkorok_mainframe)
	malkorok_mainframe_aoecd:SetHeight(32);
	malkorok_mainframe_aoecd:SetWidth(32);
	malkorok_mainframe_aoecd:SetPoint("TOPLEFT",malkorok_mainframe, "BOTTOMLEFT", 2, 34);
	malkorok_mainframe_aoecd:SetAlpha(1)
	malkorok_mainframe_aoecd.tex = malkorok_mainframe_aoecd:CreateTexture(nil, "BACKGROUND")
	local _,_,tx = GetSpellInfo(117745) if tx == nil then tx = "Interface\\Icons\\INV_MISC_QUESTIONMARK" end
	malkorok_mainframe_aoecd.tex:SetTexture(tx, true)
	malkorok_mainframe_aoecd.tex:SetAllPoints()
	malkorok_mainframe_aoecd.cooldown = CreateFrame("Cooldown", malkorok_mainframe_aoecd.cooldown, malkorok_mainframe_aoecd);
	malkorok_mainframe_aoecd.cooldown:SetAllPoints();

	malkorok_mainframe:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") 
	malkorok_mainframe:RegisterEvent("ZONE_CHANGED_NEW_AREA") 
	malkorok_mainframe:SetScript("OnUpdate", Malkoroktimerfunc)
	malkorok_mainframe:SetScript("OnEvent", MalkorokEventHandler)

	if GetCurrentMapAreaID() == 811 then
		malkorok_main_coord_top_x = 0.4284
		malkorok_main_coord_top_y = 0.4285
		malkorok_main_coord_bot_x = 0.4426
		malkorok_main_coord_bot_y = 0.4478
	end
end

-----------------------------------------
-- Malkorok AI
-----------------------------------------
local malkorok_ai_mainframe = nil
local malkorok_ai_pie = {0,0,0,0,0,0}
local malkorok_ai_pie_raid = {}
local malkorok_ai_pie_yellow = 0
local malkorok_ai_tmr = 0
local malkorok_ai_tmr2 = 0
local malkorok_ai_spell_aoe = "143805"
--local malkorok_ai_spell_aoe = "20473"

local function MalkorokAItimerfunc2(self,elapsed)
	malkorok_ai_tmr2 = malkorok_ai_tmr2 + elapsed
	if malkorok_ai_tmr2 > 5 then
		if malkorok_pie_status[malkorok_ai_pie_yellow]==1 then
			malkorok_mainframe_pie[malkorok_ai_pie_yellow].tex:SetVertexColor(1,0,0,0.8);
		end
		malkorok_ai_mainframe:SetScript("OnUpdate", nil)
		malkorok_ai_tmr2 = 0
	end
end

local function MalkorokAItimerfunc(self,elapsed)
	malkorok_ai_tmr = malkorok_ai_tmr + elapsed
	if malkorok_ai_tmr > 1 then
		malkorok_mainframe_pie[malkorok_ai_pie_yellow].tex:SetVertexColor(1,0.8,0,0.8);
		malkorok_ai_mainframe:SetScript("OnUpdate", MalkorokAItimerfunc2)
		malkorok_ai_tmr = 0
	end
end

local malkorok_ai_mainframe_2 = nil
local malkorok_ai_tmr_do = 0
local function MalkorokAItimerfunc_do(self,elapsed)
	if not malkorok_ai_mainframe then return end
	malkorok_ai_tmr_do = malkorok_ai_tmr_do + elapsed
	if malkorok_ai_tmr_do > 4.5 then
		local n = GetNumGroupMembers() or 0
		if n > 0 then
			local j2 = 0
			for i=1,6 do malkorok_ai_pie_raid[i]=0 end
			for j=1,n do
				local name, _,subgroup = GetRaidRosterInfo(j)
				if name ~= nil and subgroup <= 5 and UnitIsDeadOrGhost(name)~=1 then
					local px, py = GetPlayerMapPosition(name)
					if px == 0 and py == 0 then
						SetMapToCurrentZone()
						px, py = GetPlayerMapPosition(name)
					end
					if px >= malkorok_main_coord_top_x and px<=malkorok_main_coord_bot_x and py>=malkorok_main_coord_top_y and py<=malkorok_main_coord_bot_y then
						local px1 = (px-malkorok_main_coord_top_x)/(malkorok_main_coord_bot_x-malkorok_main_coord_top_x)*(malkorok_width-20)+10-(malkorok_playericonsize/2)
						local py1 = (py-malkorok_main_coord_top_y)/(malkorok_main_coord_bot_y-malkorok_main_coord_top_y)*(malkorok_height-20)+10-(malkorok_playericonsize/2)
				
						local numpie = Malkorokfindpie(px1,py1)
				
						if numpie>0 and malkorok_ai_pie[numpie] == 0 then 
							malkorok_ai_pie_raid[numpie] = malkorok_ai_pie_raid[numpie] + 1
						end

						j2 = j2 + 1
					end
				end
			end
			if j2 <= 6 then 
				malkorok_ai_mainframe.text:SetTextColor(1, 0.5, 0.5, 1)
				--return 
			else
				malkorok_ai_mainframe.text:SetTextColor(1, 1, 1, 1)
			end
			local minpie = 0
			local minpieam = 40
			for i=1,6 do 
				if malkorok_ai_pie[i]==0 then
					minpie = i
					minpieam = malkorok_ai_pie_raid[i]
					break
				end					
			end
			for i=1,6 do 
				if malkorok_ai_pie[i]==0 then
					if malkorok_ai_pie_raid[i]<minpieam then
						minpie = i
						minpieam = malkorok_ai_pie_raid[i]
					end
				end
			end
			if minpie == 0 then return end
			--malkorok_ai_pie[minpie] = 1
			--if RaidRank()>0 then ExRTmods:SendExMsg("malkorok",tostring(minpie).."\tR") end
			malkorok_ai_pie_yellow = minpie
			malkorok_ai_mainframe:SetScript("OnUpdate", MalkorokAItimerfunc)
		end
		malkorok_ai_mainframe_2:SetScript("OnUpdate", nil)
		malkorok_ai_tmr_do = 0
	end
end

local function MalkorokAIEventHandler(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, event_n, _, _, _, _, _, _, _, _, _, spellId,spellName = ...
		if event_n == "SPELL_CAST_SUCCESS" and (tostring(spellId) == malkorok_ai_spell_aoe) then
			malkorok_ai_tmr_do = 0
			malkorok_ai_mainframe_2:SetScript("OnUpdate", MalkorokAItimerfunc_do)
		elseif event_n == "SPELL_CAST_SUCCESS" and (tostring(spellId) == malkorok_spell or tostring(spellId) == malkorok_spell_baoe) then
			for i=1,6 do malkorok_ai_pie[i]=0 end
		end
	end
end

local function MalkorokAILoad()
	MalkorokLoad()
	if malkorok_mainframe == nil then return end
	if malkorok_ai_mainframe ~= nil then return end
	
	malkorok_ai_mainframe = CreateFrame("Frame","MHmalkorok_ai_mainframe",nil);
	if malkorok_ai_mainframe_2==nil then malkorok_ai_mainframe_2 = CreateFrame("Frame") end

	malkorok_ai_mainframe:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") 
	malkorok_ai_mainframe:SetScript("OnEvent", MalkorokAIEventHandler)

	malkorok_ai_mainframe.text = CreateFrame("SimpleHTML", nil,malkorok_mainframe);
	malkorok_ai_mainframe.text:SetText("AI")
	malkorok_ai_mainframe.text:SetFont(ExRTmods.defFont, 16,"OUTLINE");
	malkorok_ai_mainframe.text:SetHeight(12);
	malkorok_ai_mainframe.text:SetWidth(12);
	malkorok_ai_mainframe.text:SetPoint("CENTER", malkorok_mainframe,"BOTTOMRIGHT", -12,12);
	malkorok_ai_mainframe.text:SetTextColor(1, 1, 1, 1)
end

-----------------------------------------
-- Options
-----------------------------------------

function ExRTmods:ExBossmodsCloseAll()
	if malkorok_ai_mainframe ~= nil then
		malkorok_ai_mainframe:Hide()
		malkorok_ai_mainframe:UnregisterAllEvents() 
		malkorok_ai_mainframe:SetScript("OnUpdate", nil)
		malkorok_ai_mainframe:SetScript("OnEvent", nil)
		malkorok_ai_mainframe = nil
	end
	if malkorok_mainframe ~= nil then
		malkorok_mainframe:Hide()
		malkorok_mainframe:UnregisterAllEvents()
		malkorok_mainframe:SetScript("OnUpdate", nil)
		malkorok_mainframe:SetScript("OnEvent", nil)
		malkorok_mainframe = nil
	end
end

local function BossmodseventHandler(self, event, ...)
	if event == "ADDON_LOADED" then
		if (...) == "DBM-SiegeOfOrgrimmar" then
			if ExRT == nil then
				ExRT = {}
			end
			if ExRT["Bossmods"] == nil then
				ExRT["Bossmods"] = {}
			end
			ExRT["Bossmods"]["Scale"] = 70
			function ExRT:MalkorokAILoad()
				MalkorokAILoad()
			end
			function ExRT:MalkorokLoad()
				MalkorokLoad()
			end
			function ExRT:ExBossmodsCloseAll()
				ExRTmods:ExBossmodsCloseAll()
			end
			RegisterAddonMessagePrefix(MSG_PREFIX)
		end
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, message, channel, sender = ...
		if prefix == MSG_PREFIX and (channel=="RAID" or channel=="GUILD" or (channel=="WHISPER" and (UnitIsInMyGuild(sender)==1 or sender == UnitName("player")))) then
			ExRTmods:ExBossmodsGetExMsg(sender, strsplit("\t", message))
		end 
	end
end

local function ExrtanounceM(arg)
	if malkorok_mainframe ~= nil or malkorok_ai_mainframe ~= nil then
		ExRTmods:ExBossmodsCloseAll()
	else
		MalkorokAILoad()
	end
end



SlashCmdList["ExrtanounceM"] = ExrtanounceM; 
SLASH_ExrtanounceM1 = "/malkorok";
SLASH_ExrtanounceM2 = "/mal";

local bm = CreateFrame("frame")
bm:RegisterEvent("ADDON_LOADED") 
bm:RegisterEvent("CHAT_MSG_ADDON")
bm:SetScript("OnEvent", BossmodseventHandler)