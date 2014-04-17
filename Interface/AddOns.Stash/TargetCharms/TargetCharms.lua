TARGETCHARMS_VERSION = GetAddOnMetadata("TargetCharms", "Version");
TARGETCHARMS_DB_VERSION = "1.5.3 (11/22/2010)";

local Defaults =
{
	["Version"] = TARGETCHARMS_VERSION,
	["FlareCharms"] = {
		["show"] = 2,
		["barscale"] = 0.75,
		["draggable"] = 1,
		["alphaVal"] = 0.75,
		["Xspacing"] = 0,
		["Yspacing"] = 0,
		["showicons"] = 0,
		["buttonSetup"] = ">B>G>P>R>Y>X",
	},	
};
local frameNames = {"TargetCharms","TopCharm","ReadyCharm","TopReady","FlareCharms","TopFlare","TargetCharmsSetup"};
local buttonCharm = {["TargetCharms"]={},["FlareCharms"]={}};
local texturePaths = {
    "interface\\targetingframe\\UI-RaidTargetingIcons.blp",
    "interface\\buttons\\UI-Quickslot.blp",
    "interface\\buttons\\UI-GroupLoot-Pass-Up.blp",
    "interface\\icons\\ability_hunter_snipershot.blp"
};

function TargetCharms_msg(text)
	DEFAULT_CHAT_FRAME:AddMessage(TARGETCHARMS_MSG_TAG..text);
end

function TargetCharms_Reset()
    TargetCharms_Options = Defaults;
    FlareCharms:SetScale(TargetCharms_Options["FlareCharms"]["barscale"]);
    FlareCharms:ClearAllPoints()
    FlareCharms:SetPoint("TOPLEFT", _G["UIParent"],"TOP", 100,0);
    FlareCharms:SetAlpha(TargetCharms_Options["FlareCharms"]["alphaVal"]);
    if (TargetCharmsSetup) then
        TargetCharmsSetup:ClearAllPoints();
        TargetCharmsSetup:SetPoint("CENTER", offset, 0);
    end
    TargetCharms_msg("已恢复默认设置");
	CheckFlareFrameViewState();
end

function TargetCharms_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PARTY_LEADER_CHANGED");
	self:RegisterEvent("GROUP_ROSTER_UPDATE");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	SetTargetHideShow();
end

--Code by Grayhoof (SCT)
function CloneTable(t)				-- return a copy of the table t
	local new = {};					-- create a new table
	local i, v = next(t, nil);		-- i is an index of t, v = t[i]
	while i do
		if type(v)=="table" then 
			v=CloneTable(v);
		end 
		new[i] = v;
		i, v = next(t, i);			-- get next index
	end
	return new;
end

function CopyOldValues(t,f)	
	if(f~=nil) then
		for i=1,5,2 do
			if ( f[frameNames[i]]~=nil) then
				for key,value in pairs(f[frameNames[i]]) do 
					t[frameNames[i]][key]=value ;
				end
			end	
		end 
	end
	return t;
end

function CheckFlareFrameViewState()
    if InCombatLockdown() then FlareCharms:RegisterEvent("PLAYER_REGEN_ENABLED") return end
	local charmBar = _G["FlareCharms"];

    --[[
    if TargetCharms_Options["FlareCharms"]["show"] == 2 then
        if (charmBar:IsShown()~=1) then
            charmBar:Show();
        end
    elseif TargetCharms_Options["FlareCharms"]["show"] == 3 then
        if(charmBar:IsShown()==1) then
            charmBar:Hide();
        end
    else
    end
    --]]

    local shouldShow = false
    if(IsInGroup()) then
        if(IsInRaid()) then
            if(UnitIsGroupAssistant'player' or UnitIsGroupLeader'player') then
                shouldShow = true
            end
        else
            shouldShow = true
        end
    end

    local isshown = charmBar:IsShown()
    if(shouldShow) then
        if (not isshown) then
            charmBar:Show();
        end
    else
        if(isshown) then
            charmBar:Hide();
        end               
    end
end

function SetHideShow(frame)
 local charmBar = _G[frame];
 if (TargetCharms_Options[frameNames[1]]["showontarget"] == 1) then
	
	if UnitExists("target") then
		if (charmBar:IsShown()~=1) then
			charmBar:Show();
		end
	else
		if (charmBar:IsShown()==1) then
			charmBar:Hide();
		end
	end
 else	
	if (charmBar:IsShown()~=1) then
		charmBar:Show();
	end	
 end
end

function SetTargetHideShow()
	RegisterUnitWatch(_G[frameNames[2]], true) 
end

function TargetCharms_OnEvent(self, event)
	if event=="ADDON_LOADED" then
        self:UnregisterEvent(event)
		if TargetCharms_Options == nil or TARGETCHARMS_DB_VERSION ~= TargetCharms_Options["Version"] then
            TargetCharms_Options = Defaults
		end
		FlareCharms:SetScale(TargetCharms_Options["FlareCharms"]["barscale"]);
		FlareCharms:SetAlpha(TargetCharms_Options["FlareCharms"]["alphaVal"]);
		SetupButtons("FlareCharms","FlareCharms");	
	end
	if event~= "PLAYER_TARGET_CHANGED" then
		CheckFlareFrameViewState();
		if event=="PLAYER_REGEN_ENABLED" then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED");
		end
	end
	
end

function MakeButton(frame, buttonNum, isMacro)
	local button = _G[frame.."Charm"..buttonNum];
	if button == nil then
		button = CreateFrame("Button", frame.."Charm"..buttonNum, _G[frame], "SecureCharmTemplate")
		button:RegisterForClicks("AnyUp");
		button:SetID(buttonNum);
		button:SetHeight(24);
		button:SetWidth(24);
		local texture = button:CreateTexture(button:GetName().."CharmTex");
        button:SetAttribute("type", "worldmarker")
        button:SetAttribute("action1", buttonNum<6 and "set" or "clear")
        button:SetAttribute("action2", "clear")
        button:SetAttribute("shift-type1", "")
        button:SetAttribute("marker", tostring(buttonNum))
        local textureColor = button:CreateTexture(button:GetName().."TextureColor");
        textureColor:SetPoint("TOPLEFT", button,"TOPLEFT", 4, -4);
        textureColor:SetPoint("BOTTOMRIGHT", button,"BOTTOMRIGHT", -4.5, 4.5);
        local textureIcon = button:CreateTexture(button:GetName().."TextureIcon");
        textureColor:SetPoint("TOPLEFT", button,"TOPLEFT", 4, -4)
        textureColor:SetPoint("BOTTOMRIGHT", button,"BOTTOMRIGHT", -4.5, 4.5)
	end
	return button;
end

function SetupButtons(frameInfo,frameTarget)
	local buttonString = TargetCharms_Options[frameInfo]["buttonSetup"];
	local maxlen = strlen(buttonString);
	if mod(maxlen,2) == 1 then
		maxlen=maxlen-1
	end
	local buttonNum=1;
	if maxlen > 40 then
		maxlen = 40;
	end
	
	local t
	for t=1,maxlen,2 do
		MakeButton(frameTarget, buttonNum, (frameInfo=="FlareCharms"));
		FormatButton(frameTarget, buttonNum, strsub(buttonString,t,t), strsub(buttonString,t+1,t+1),TargetCharms_Options[frameInfo]["Xspacing"],TargetCharms_Options[frameInfo]["Yspacing"]);
		buttonNum=buttonNum+1;
	end

	for t=buttonNum,20 do
		local button = _G[frameTarget.."Charm"..buttonNum];
		if button ~= nil then 
			button:Hide();
		end
	end
end 

local data = {
	[TARGETCHARMS_BLUEFLARE] = {1, 0,.5,1},
	[TARGETCHARMS_GREENFLARE] = {2, 0,1,.2},
	[TARGETCHARMS_PURPLEFLARE] = {3, .5,0,1},
	[TARGETCHARMS_REDFLARE] = {4, 1,0,0},
	[TARGETCHARMS_YELLOWFLARE] = {5, 1,1,0},
	[TARGETCHARMS_CLEARFLARE] = {6, 0,0,0},
}
function FormatButton(frame, buttonNum ,posChar, typeNum, xSpacing, ySpacing)
	local button = _G[frame.."Charm"..buttonNum];
	button:ClearAllPoints();
	if strlower(posChar) == TARGETCHARMS_POSITION_DOWN then
		button:SetPoint("TOPLEFT", _G[frame.."Charm"..tostring(buttonNum-1)],"BOTTOMLEFT",0,0-ySpacing);
	elseif posChar == TARGETCHARMS_POSITION_UP then
		button:SetPoint("BOTTOMLEFT", _G[frame.."Charm"..tostring(buttonNum-1)],"TOPLEFT",0,0+ySpacing);
	elseif posChar == TARGETCHARMS_POSITION_RIGHT then
		button:SetPoint("TOPLEFT", _G[frame.."Charm"..tostring(buttonNum-1)],"TOPRIGHT",0+xSpacing,0);
	elseif posChar == TARGETCHARMS_POSITION_LEFT then
		button:SetPoint("TOPRIGHT", _G[frame.."Charm"..tostring(buttonNum-1)],"TOPLEFT",0-xSpacing,0);
	else
		--ERROR--
		button:SetPoint("TOPLEFT", _G[frame.."Charm"..tostring(buttonNum-1)],"TOPRIGHT",0,0-ySpacing);
		buttonCharm[frame][buttonNum] = 0;
        	button:Hide();
		print(TARGETCHARMS_ERROR_INVALIDCHAR); 
		return false;
	end

	local d = data[typeNum]
	if d then
		MakeCharm(frame,button,buttonNum,d[1],2,0.15,0.85,0.15,0.85,0,0,24,24);
		local textureColor = _G[button:GetName().."TextureColor"];
		textureColor:SetTexture(d[2], d[3], d[4]);
		if typeNum == TARGETCHARMS_CLEARFLARE then
			SetTexture(button, _G[button:GetName().."TextureIcon"],3,0,1,0,1,0,0,24,24);
			_G[button:GetName().."TextureColor"]:Hide()
            _G[button:GetName().."CharmTex"]:Hide()
		end
	else
		button:Hide();
		return false;
	end
	button:Show();
	return true;
end

function MakeCharm(frame, button, buttonNum, id, textureID, o1,o2,o3,o4,a1,a2,w,h)
	buttonCharm[frame][buttonNum] = id;
	local texture = _G[button:GetName().."CharmTex"];
	SetTexture(button, texture, textureID, o1,o2,o3,o4,a1,a2,w,h);
end

function SetTexture(button, texture, textureID, o1,o2,o3,o4,a1,a2,w,h)
	texture:SetPoint("TOPLEFT", button,"TOPLEFT",a1,a2);
	texture:SetWidth(w);
	texture:SetHeight(h);
	texture:SetTexture(texturePaths[textureID]);
	texture:SetTexCoord(o1,o2,o3,o4)
end

function SelectTarget(frameId, targetId)
	local charmId = buttonCharm[frameNames[frameId]][tonumber(targetId)];
	if (TargetCharms_Options[frameNames[1]]["toggleicon"]~=1) then
		if (GetRaidTargetIndex("target")~=charmId) then
			SetRaidTarget("target", charmId)
		end
	else
		SetRaidTargetIcon("target", charmId)
	end
end

function SetFrameScale(scale,id)
	local tmpFrame = _G[frameNames[id]];
	tmpFrame:SetScale(scale);
end
