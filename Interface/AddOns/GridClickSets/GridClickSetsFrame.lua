﻿local i
local queue = false
local function makeMovable(frame)
	local mover = _G[frame:GetName() .. "Mover"] or CreateFrame("Frame", frame:GetName() .. "Mover", frame)
	mover:EnableMouse(true)
	mover:SetPoint("TOP", frame, "TOP", 0, 10)
	mover:SetWidth(160)
	mover:SetHeight(40)
	mover:SetScript("OnMouseDown", function(self)
		self:GetParent():StartMoving()
	end)
	mover:SetScript("OnMouseUp", function(self)
		self:GetParent():StopMovingOrSizing()
	end)
	-- mover:SetClampedToScreen(true)		-- doesn't work?
	frame:SetMovable(true)
end

function GridClickSetsFrame_OnLoad(self)
	self:RegisterEvent("PLAYER_REGEN_ENABLED");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
	self:RegisterEvent("PLAYER_ALIVE");
	makeMovable(self)
	PanelTemplates_SetNumTabs(self, GRID_CLICK_SETS_BUTTONS + 2);
	self.selectedTab = 1;
	PanelTemplates_UpdateTabs(self);

	for i = 1, 8 do
		getglobal("GridClickSetButton"..i.."Title"):SetText(GridClickSets_Titles[i])
	end

	--GridClickSetsFrame_TabOnClick();
	table.insert(UISpecialFrames, self:GetName())
end

function GridClickSetsFrame_OnEvent(self, event)
	if(event=="PLAYER_REGEN_ENABLED") then
		if(queue) then
			GridClickSetsFrame_UpdateAll()
			queue = false
		end
	elseif(event=="VARIABLES_LOADED") then
		if not U1 then
			if(GetLocale()=="zhCN") then 
				DEFAULT_CHAT_FRAME:AddMessage("GridClickSets - |cffff3333网易有爱|r (w.163.com/163ui)") 
			elseif(GetLocale()=="zhTW") then
				DEFAULT_CHAT_FRAME:AddMessage("GridClickSets - |cff3399FF三月十二|r@聖光之願|cffFF00FF<冰封十字軍>|r.")
			end
		end
	end

	if(event=="VARIABLES_LOADED" or event=="ACTIVE_TALENT_GROUP_CHANGED" or event=="PLAYER_ALIVE") then
		GridClickSetsFrame_UpdateAll(1);
	end
end

function GridClickSetsFrame_TypeUpdate(id)
	local argF = getglobal("GridClickSetButton"..id.."Arg")
	local typeDD = getglobal("GridClickSetButton"..id.."Type")
	local value = UIDropDownMenu_GetSelectedValue(typeDD)
	if (not value) then value = "NONE" end

	if( value=="spell" or value=="macro" ) then
		argF:Show();
	else
		argF:Hide();
	end

	local below = getglobal("GridClickSetButton"..(id+1))
	if(below) then
		below:ClearAllPoints();
		if argF:IsVisible() then
			below:SetPoint("TOPLEFT", argF, "BOTTOMLEFT", -50, 0);
		else
			below:SetPoint("TOPLEFT", getglobal("GridClickSetButton"..id), "BOTTOMLEFT", 0, -5);
		end
	end
end

function GridClickSetsFrame_Resize()
	local k=0;
	local id
	for id=1, 8 do
		local argF = getglobal("GridClickSetButton"..id.."Arg")
		if(argF:IsVisible()) then
			k = k + argF:GetHeight() + 1;
		end
	end
	local height = 340 + k;
	if(height > 450) then
		GridClickSetsFrame:SetHeight(height);
	else
		GridClickSetsFrame:SetHeight(450);
	end
end

function GridClickSetsFrame_TypeUpdateAll()
	for i=1,8 do
		GridClickSetsFrame_TypeUpdate(i)
	end
	GridClickSetsFrame_Resize();
end

function GridClickSets_Type_OnClick(self)
	UIDropDownMenu_SetSelectedValue(self.owner, self.value);
	local id=self.owner:GetParent():GetID()
	GridClickSetsFrame_TypeUpdate(id)
	GridClickSetsFrame_Resize()
end

local function ddname(str)
	return " = "..str.." = ";
end

function GridClickSetButton_TypeDropDown_Initialize(self)
	local info;

	local _, c = UnitClass("player")
	local list = GridClickSets_SpellList[c];
	if(list) then
		for i=1, #list do
			info = {};
			info.text = SKILL.." - "..(GetSpellInfo(list[i]) or list[i])
			info.owner = self;
			info.func = GridClickSets_Type_OnClick;
			info.value = "spellId:"..list[i]
			UIDropDownMenu_AddButton(info);
		end
	end

	info = {};
	info.text = ddname(TARGET);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "target"
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = ddname(BINDING_NAME_ASSISTTARGET);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "assist"
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ddname(SKILL..NAME);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "spell"
	UIDropDownMenu_AddButton(info);

--	info = {};
--	info.text = ddname(SOCIAL_LABEL);
--	info.owner = self;
--	info.func = GridClickSets_Type_OnClick;
--	info.value = "menu"
--	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ddname(MACRO);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "macro"
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = NONE; --ddname(NONE);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "NONE"
	UIDropDownMenu_AddButton(info);
end

function GridClickSetsFrame_GetTabSet(btn)
    local set = GridClickSetsFrame_GetCurrentSet()
    return set[tostring(btn)]
end

function GridClickSetsFrame_LoadSet(set)
	for i = 1, 8 do
		local dd = getglobal("GridClickSetButton"..i.."Type")
		local atts = set and set[GridClickSets_Modifiers[i]] or {}
		UIDropDownMenu_Initialize(dd, GridClickSetButton_TypeDropDown_Initialize);
		UIDropDownMenu_SetSelectedValue(dd, atts.type or "NONE")
		if(atts.arg) then
			getglobal("GridClickSetButton"..i.."Arg"):SetText(atts.arg)
		else
			getglobal("GridClickSetButton"..i.."Arg"):SetText("")
		end
	end

	GridClickSetsFrame_TypeUpdateAll();
end

function GridClickSetsFrame_TabOnClick()
	GridClickSetsFrame_LoadSet( GridClickSetsFrame_GetTabSet(GridClickSetsFrame.selectedTab) );
	if ( false and GridClickSetsFrame.selectedTab == 1 ) then
		UIDropDownMenu_SetSelectedValue(GridClickSetButton1Type, "target");
		UIDropDownMenu_DisableDropDown(GridClickSetButton1Type)
	else
		UIDropDownMenu_EnableDropDown(GridClickSetButton1Type)
	end
end

function GridClickSetsFrame_DefaultsOnClick()
	GridClickSetsFrame_LoadSet(GridClickSets_GetBtnDefaultSet(GridClickSetsFrame.selectedTab))
end

function GridClickSetsFrame_SaveOnClick()
    local set = GridClickSetsFrame_GetCurrentSet()
	for i=1,8 do
		set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]] = {
			type = UIDropDownMenu_GetSelectedValue( getglobal("GridClickSetButton"..i.."Type") ),
			arg = getglobal("GridClickSetButton"..i.."Arg"):GetText()
		}

		if set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]].arg == "" then
			set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]].arg = nil
		end

		if set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]].type == "NONE" then
			set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]] = nil
		end
	end
end

function GridClickSetsFrame_CancelOnClick()
	GridClickSetsFrame_LoadSet( GridClickSetsFrame_GetTabSet(GridClickSetsFrame.selectedTab) );
end

function GridClickSetsFrame_ApplyOnClick()
	GridClickSetsFrame_SaveOnClick()
	GridClickSetsFrame_UpdateAll()
	--GridClickSetsFrame:Hide()
end

GridClickSetsForTalents={}
GridClickSetsFrame_Updates = {} --for other module insert

function GridClickSetsFrame_GetCurrentSet()
	local talent = GetSpecialization() or 0;
	if GridClickSetsFrame:IsVisible() then
		GridClickSetsFrameTalentText:SetFormattedText("%s: %s", TALENTS, select(2, GetSpecializationInfo(talent)) or UNKNOWN)
	end
	if GridClickSetsForTalents[talent]==nil then
		GridClickSetsForTalents[talent]=GridClickSets_GetDefault();
	end
	local set = GridClickSetsForTalents[talent]
	for i=1, GRID_CLICK_SETS_BUTTONS+2 do set[tostring(i)] = set[tostring(i)] or {} end
	return set
end

function GridClickSetsFrame_UpdateAll(silent)
	local set = GridClickSetsFrame_GetCurrentSet()
	if GridClickSetsFrame:IsVisible() then GridClickSetsFrame_TabOnClick() end
	if(InCombatLockdown()) then
		queue = true
		if not silent then DEFAULT_CHAT_FRAME:AddMessage(GRIDCLICKSETS_LOCKWARNING, 1, 0, 0) end
	else
		for _, v in pairs(GridClickSetsFrame_Updates) do
			v(set)
		end

		if not silent then DEFAULT_CHAT_FRAME:AddMessage(GRIDCLICKSETS_SET, 1, 1, 0) end
	end
end

SLASH_CLICKSET1 = "/clickset";
SLASH_CLICKSET2 = "/cs";
SlashCmdList["CLICKSET"] = function(msg)
	if GridClickSetsFrame:IsVisible() then GridClickSetsFrame:Hide() else GridClickSetsFrame:Show() end
end
