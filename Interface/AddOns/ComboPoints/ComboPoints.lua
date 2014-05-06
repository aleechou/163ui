local _, addon = ...

--Constants
local COMBOPOINTS_VERSION		= "1.5";
local CONSTANT_GLOBALUPDATER		= "ComboPoints_GlobalUpdater";
local CONSTANT_GLOBALPOINTS		= "ComboPoints_ComboBar";
local CONSTANT_BASEPOINTS		= CONSTANT_GLOBALPOINTS .. "_Combo_";
local MODE_COLORPICK			= 1001;
local MODE_MOVABLE			= 1002;
local MODE_NORMAL			= 1000;



-- Messages
local m_cbp = "Command Usage :: /ComboPoints or /cbp";
local m_report = "Report :: '/ComboPoints rep[ort]'";
local m_reset = "Reset :: '/ComboPoints res[et]'";
local m_lock = "Lock :: '/ComboPoints l[ock]'";
local m_unlocking = "UnLock :: '/ComboPoints u[nlock]' or '/ComboPoints m[ove]'";
local m_visibility = "Visibility :: '/ComboPoints v[isible] options'";
local m_visibility_0 = "              Options :: Hiding: 0/no/false";
local m_visibility_1 = "              Options :: Showing: 1/yes/true";
local m_hide = "Hide :: '/ComboPoints hi[de]'";
local m_show = "Show :: '/ComboPoints s[how]'";
local m_appear = "Appear :: '/ComboPoints a[ppear]' (to view where CBP is currently located)";
local m_color = "Color :: '/ComboPoints c[olor] dotnumber' (1 through 5 or 'inactive')";
local m_gap = "Gap :: '/ComboPoints g[ap] pixels' .. changes the distance between the dots.. -5 = no gap, 0 == standard gap, higher = bigger gap";
local m_size = "Size :: '/ComboPoints he[ight]/w[idth] [pixels]' .. changes the height or width of the dots. Omitting the argument reports the current values.";
local m_background = "Background :: '/ComboPoints b[ackground]' Toggles whether the background should always be visible or not";
local m_mode = "Mode :: '/ComboPoints m[ode] 1..9 (4 = right-to-left, 6 = left-to-right(default)))";




--Variables
local var = {
	realmName	=	'';
	playerName	=	'';
	loaded		=	false;
	load_time	=	0;
	full_init	=	false;
	is_moving	=	false;
	move_lock	=	false;
	show_lock	=	false;
	colorpick	=	false;
	show_mode	=	MODE_NORMAL;
	show_val	=	0;
};

ComboPoints_Saved = { };


local standardSettings = {
   ["visible"] = true,
   ["displaygap"] = 0,
   ["displaymode"] = "6",
   ["height"] = 14,
   ["width"] = 22,
   ["locked"] = false,
   ["color1"] = {
      ["r"] = 0,
      ["g"] = 1,
      ["b"] = 0,
      ["a"] = 1,
   },
   ["color2"] = {
      ["r"] = 0.5,
      ["g"] = 1,
      ["b"] = 0,
      ["a"] = 1,
   },
   ["color3"] = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 0,
      ["a"] = 1,
   },
   ["color4"] = {
      ["r"] = 1,
      ["g"] = 0.5,
      ["b"] = 0,
      ["a"] = 1,
   },
   ["color5"] = {
      ["r"] = 1,
      ["g"] = 0,
      ["b"] = 0,
      ["a"] = 1,
   },
   ["color6"] = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 1,
   },
};
local ComboPointsInfo = {};



--/Variables







--lang

local l_UIM				= "UIM";
local l_ComboPoints			= "ComboPoints";
local l_Loaded				= "Loaded :: ";
local l_Locked				= "Is locked";


local l_reset				= "恢复默认设置";

local l_nowlocked			= "锁定";
local l_nowunlocked			= "解锁";

local l_nowvisible			= "显示";
local l_nowinvisible			= "隐藏";

local l_appearshow			= "模拟显示";
local l_appearhide			= "模拟显示关闭";

local l_nowshowbg			= "now constantly showing the background";
local l_nownotshowbg			= "now not showing the background";

--/lang

	--Event Constants
		local UNIT_NAME_UPDATE		= "UNIT_NAME_UPDATE";
		local VARIABLES_LOADED		= "VARIABLES_LOADED";
		local UNIT_COMBO_POINTS		= "UNIT_COMBO_POINTS";
		local UNIT_DISPLAYPOWER		= "UNIT_DISPLAYPOWER";
		local PLAYER_TARGET_CHANGED	= "PLAYER_TARGET_CHANGED";


	--/Event Constants


--/Constants

--Functions

function SetSavedOption(name, value)
	if((var.realmName ~= nil) and (var.playerName ~= nil) and (name ~= nil) and (var.loaded == true)) then
		ComboPoints_Saved[var.realmName][var.playerName][name] = value;
	end
	if name=="locked" then
		for i=1, 5 do _G["ComboPoints_ComboBar_Combo_"..i]:EnableMouse(not value) end
	end
end

function deepcopy(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

function GetSavedOption(name)
	local default = standardSettings[name];
	local val = nil;
	local tab = GetPlayerTable();
	if (not tab) then
		if(not default) then
--			CBPprint("GetSavedOption returning default (nil) for "..name.." because there is no player table");
			return nil;
		else
--			CBPprint("GetSavedOption returning default ("..tostring(default)..") for "..name.." because there is no player table");
                   return deepcopy(default);
		end
	else
		val = tab[name];
		if(val == nil) then
			if(not default) then
--				CBPprint("GetSavedOption returning default (nil) for "..name);
				return nil;
			else
--				CBPprint("GetSavedOption returning default ("..tostring(default)..") for "..name);
                           return deepcopy(default);
			end
		else
--			CBPprint("GetSavedOption returning "..tostring(val).." for "..name);			
			return val;
		end
	end
end

function GetColourDot(number)
	--CBPprint("color"..number);
	return GetSavedOption("color"..number);
end

function SetColourDot(number, color)
	--CBPprint("color"..number);
	SetSavedOption("color"..number, color);
end



--/Functions



--Events

function ComboPoints_SetMode()
	local mode = GetSavedOption("displaymode");
	local gap = GetSavedOption("displaygap");
--	CBPprint("Mode :: " .. tostring(mode));
--	CBPprint("Gap :: " .. tostring(gap));
	if (type(mode) ~= "string") then
		ComboPoints_Print("Internal error. Bad data type \""..type(mode).."\" for display mode, value is "..tostring(mode));
		ComboPoints_Print("Resetting to string \"6\"");
		SetSavedOption("displaymode", "6");
		mode = "6";
	end
	--getglobal(CONSTANT_GLOBALPOINTS):ClearAllPoints();
	for i = 2, 5 do
		getglobal(CONSTANT_BASEPOINTS..i):ClearAllPoints();
	end
--	CONSTANT_BASEPOINTS
	if (mode == "1") then
		--getglobal(CONSTANT_BASEPOINTS.."1"):SetPoint("TOPRIGHT", CONSTANT_GLOBALPOINTS, "TOPRIGHT");
		for i = 2,5 do
			getglobal(CONSTANT_BASEPOINTS..i):SetPoint("TOPRIGHT", CONSTANT_BASEPOINTS..(i-1), "BOTTOMLEFT", -gap, -gap);
		end
	elseif (mode == "2") then
		--getglobal(CONSTANT_BASEPOINTS.."1"):SetPoint("TOP", CONSTANT_GLOBALPOINTS, "TOP");
		for i = 2,5 do
			getglobal(CONSTANT_BASEPOINTS..i):SetPoint("TOP", CONSTANT_BASEPOINTS..(i-1), "BOTTOM", 0, -gap);
		end
	elseif (mode == "3") then
		--getglobal(CONSTANT_BASEPOINTS.."1"):SetPoint("TOPLEFT", CONSTANT_GLOBALPOINTS, "TOPLEFT");
		for i = 2,5 do
			getglobal(CONSTANT_BASEPOINTS..i):SetPoint("TOPLEFT", CONSTANT_BASEPOINTS..(i-1), "BOTTOMRIGHT", gap, -gap);
		end
	elseif (mode == "4") then
		--getglobal(CONSTANT_BASEPOINTS.."1"):SetPoint("TOPRIGHT", CONSTANT_GLOBALPOINTS, "TOPRIGHT");
		for i = 2,5 do
			getglobal(CONSTANT_BASEPOINTS..i):SetPoint("TOPRIGHT", CONSTANT_BASEPOINTS..(i-1), "TOPLEFT", -gap, 0);
		end
	elseif (mode == "5" or mode == "6") then
		--getglobal(CONSTANT_BASEPOINTS.."1"):SetPoint("TOPLEFT", CONSTANT_GLOBALPOINTS, "TOPLEFT");
		for i = 2,5 do
			getglobal(CONSTANT_BASEPOINTS..i):SetPoint("TOPLEFT", CONSTANT_BASEPOINTS..(i-1), "TOPRIGHT", gap, 0);
		end
	elseif (mode == "7") then
		--getglobal(CONSTANT_BASEPOINTS.."1"):SetPoint("BOTTOMRIGHT", CONSTANT_GLOBALPOINTS, "BOTTOMRIGHT");
		for i = 2,5 do
			getglobal(CONSTANT_BASEPOINTS..i):SetPoint("BOTTOMRIGHT", CONSTANT_BASEPOINTS..(i-1), "TOPLEFT", -gap, gap);
		end
	elseif (mode == "8") then
		--getglobal(CONSTANT_BASEPOINTS.."1"):SetPoint("BOTTOM", CONSTANT_GLOBALPOINTS, "BOTTOM");
		for i = 2,5 do
			getglobal(CONSTANT_BASEPOINTS..i):SetPoint("BOTTOM", CONSTANT_BASEPOINTS..(i-1), "TOP", 0, gap);
		end
	elseif (mode == "9") then
		--getglobal(CONSTANT_BASEPOINTS.."1"):SetPoint("BOTTOMLEFT", CONSTANT_GLOBALPOINTS, "BOTTOMLEFT");
		for i = 2,5 do
			getglobal(CONSTANT_BASEPOINTS..i):SetPoint("BOTTOMLEFT", CONSTANT_BASEPOINTS..(i-1), "TOPRIGHT", gap, gap);
		end
	else
			ComboPoints_Print("Internal error. Bad value for display mode: "..tostring(mode));
	end
	for i = 1,5 do
		getglobal(CONSTANT_BASEPOINTS..i):SetWidth(GetSavedOption("width"));
		getglobal(CONSTANT_BASEPOINTS..i):SetHeight(GetSavedOption("height"));
	end

end


function ComboPoints_GlobalUpdater_Event(ev)
	if(ev == UNIT_NAME_UPDATE) then
		if((var.loaded ~= false) and (var.full_init ~= true)) then
			var.playerName = UnitName("player");
			var.realmName = GetCVar("realmName");
			var.full_init = true;
			ComboPoints_GlobalUpdater_FullInit();
		end
	elseif (ev == VARIABLES_LOADED) then
		var.loaded = true;
                ComboPoints_SetMode();
		SetSavedOption("locked", GetSavedOption("locked"))
                ComboPointsInfo:Display();
	end
end


function ComboPoints_GlobalUpdater_FullInit()
	local a = GetSavedOption("locked");
	local d;
	for i = 1, 6 do
                SetColourDot(i, GetColourDot(i));
	end
	
	local Visible = GetSavedOption("visible");
	ComboPoints_SetMode();
	if(Visible == true) then
		--ComboPoints_Print(colorhex("#00FF00")..l_Loaded..var.playerName);
	end
end

function ComboPoints_Slashhelp()
	ComboPoints_Print(m_cbp);
	ComboPoints_Print(m_report);
	ComboPoints_Print(m_reset);
	ComboPoints_Print(m_lock);
	ComboPoints_Print(m_unlocking);
	ComboPoints_Print(m_visibility);
	ComboPoints_Print(m_visibility_0);
	ComboPoints_Print(m_visibility_1);
	ComboPoints_Print(m_hide);
	ComboPoints_Print(m_show);
	ComboPoints_Print(m_appear);
	ComboPoints_Print(m_color);
	ComboPoints_Print(m_gap);
	ComboPoints_Print(m_size);
	ComboPoints_Print(m_background);
	ComboPoints_Print(m_mode);
end

function ComboPoints_ComboBar_OnLoad(this)
	addon:RegisterEvents(this)

	SlashCmdList["COMBOPOINTS"] = ComboPoints_SlashHandler;
	SLASH_COMBOPOINTS1 = "/combopoints";
	SLASH_COMBOPOINTS2 = "/cbp";

	--standardSettings["visible"] = IsRogueClass();

	--updateTextVisibility(combo);
	--update(combo);
	--DEFAULT_CHAT_FRAME:AddMessage(colorhex("#FF0000")..l_UIM.."|r:"..colorhex("#FF0000")..l_ComboPoints.."|r by Xaroth. Loaded version "..COMBOPOINTS_VERSION..", by Arture le Coiffeur.");
end

function ComboPoints_ComboBar_Event(event, ...)
	if addon:CheckEvent(event, ...) then
		ComboPointsInfo:Display();
	end
end

function ComboPoints_SlashHandler(text)
	local _,_,command,options = string.find(text,"([%w%p]+)%s*(.*)$");

	if (command) then
		command = string.lower(command);
	end

	if(command == nil or command == "") then ComboPoints_Slashhelp()
	elseif(command == "appear" or command == "a") then ComboPoints_SlashHandler_Appear();
	elseif(command == "background" or command == "b") then ComboPoints_SlashHandler_Background();
	elseif(command == "color" or command == "c") then ComboPoints_SlashHandler_Color(options);
	elseif(command == "gap" or command == "g") then ComboPoints_SlashHandler_Gap(options);
	elseif(command == "hide" or command == "hi") then ComboPoints_SlashHandler_Visible("0");
	elseif(command == "height" or command == "he") then ComboPoints_SlashHandler_Resize("height", options);
	elseif(command == "mode" or command == "m") then ComboPoints_SlashHandler_Mode(options);
	elseif(command == "lock" or command == "l") then ComboPoints_SlashHandler_Lock();
	elseif(command == "reset" or command == "res") then ComboPoints_SlashHandler_Reset();
	elseif(command == "report" or command == "rep") then ComboPoints_SlashHandler_Report();
	elseif(command == "show" or command == "s") then ComboPoints_SlashHandler_Visible("1");
	elseif(command == "unlock" or command == "u" or command == "m" or command == "move") then ComboPoints_SlashHandler_UnLock();
	elseif(command == "visible" or command == "v") then ComboPoints_SlashHandler_Visible(options);
	elseif(command == "width" or command == "w") then ComboPoints_SlashHandler_Resize("width", options);
	else
		ComboPoints_Slashhelp();
	end
end





ComboPoints_SlashHandler_Report_Items = {
   "visible",
   "displaygap",
   "displaymode",
   "height",
   "width",
   "locked",
};
function ComboPoints_SlashHandler_Report()
        ComboPoints_Print("Stored settings for ComboPoints:");
	for i=1, #ComboPoints_SlashHandler_Report_Items do
	        key = ComboPoints_SlashHandler_Report_Items[i]
		value = GetSavedOption(key);
                ComboPoints_Print(key.." = "..tostring(value));
	end
end
function ComboPoints_SlashHandler_Reset()
	for key, value in pairs(standardSettings) do
--		CBPprint("ComboPoints_SlashHandler_Reset: setting "..key.." to "..tostring(value));
		SetSavedOption(key, deepcopy(value));
	end
        ComboPoints_ComboBar:ClearAllPoints();
        ComboPoints_ComboBar:SetPoint("LEFT", "UIParent", "CENTER", -55, -100);
	ComboPoints_SetMode();
	ComboPoints_Print(l_reset);
	ComboPointsInfo:Display();
end
function ComboPoints_SlashHandler_Lock()
	SetSavedOption("locked", true);
	--var.show_lock = false;
	ComboPoints_Print(l_nowlocked);
	ComboPointsInfo:Display();
end
function ComboPoints_SlashHandler_UnLock()
	SetSavedOption("locked", false);
	--var.show_lock = true;
	ComboPoints_Print(l_nowunlocked);
	ComboPointsInfo:Display();
end
function ComboPoints_SlashHandler_Visible(options)
	if(options) then
		options = string.lower(options)
	end
	if (options == nil or options == "") then
		local visible = GetSavedOption("visible");
		if(visible == true) then
			SetSavedOption("visible", false);
			ComboPoints_Print(l_nowinvisible);
		else
			SetSavedOption("visible", true);
			ComboPoints_Print(l_nowvisible);
		end
	elseif (options == "1" or options == "yes" or options == "true") then
		SetSavedOption("visible", true);
		ComboPoints_Print(l_nowvisible);
	elseif (options == "0" or options == "no" or options == "false") then
		SetSavedOption("visible", false);
		ComboPoints_Print(l_nowinvisible);
	else
		ComboPoints_Print(m_visible);
    end
    ComboPointsInfo:Display();
end
function ComboPoints_SlashHandler_Appear(v)
    if v~=nil then var.show_lock = not v end
	if(var.show_lock == true) then
		var.show_lock = false;
		ComboPoints_Print(l_appearhide);
	else
		var.show_lock = true;
		ComboPoints_Print(l_appearshow);
	end
        ComboPoints_SetMode();
	ComboPointsInfo:Display();
end
function ComboPoints_SlashHandler_Background()
	local showlock = GetSavedOption("showlock");
	if(showlock) then
		SetSavedOption("showlock", false);
		ComboPoints_Print(l_nownotshowbg);
	else
		SetSavedOption("showlock", true);
		ComboPoints_Print(l_nowshowbg);
	end
	ComboPointsInfo:Display();
end
function ComboPoints_SlashHandler_Gap(options)
	if (gmatch(options, "-?%d+")) then
		gap = tonumber(options);
                if (gap < -5) then
                	ComboPoints_Print(m_gap);
                else
			SetSavedOption("displaygap", gap);
			ComboPoints_Print("Gap set to :: " .. options);
			ComboPoints_SetMode();
                end
	elseif (options == "") then
		ComboPoints_Print(m_gap);
		ComboPoints_Print("Current Gap :: " .. GetSavedOption("displaygap"));
	else
		ComboPoints_Print(m_gap);
	end
end
function ucfirst(str)
   local str1 = str:sub(1, 1);
   str = str:sub(2);
   return str1:upper()..str;
end
function ComboPoints_SlashHandler_Resize(command, options)
   if (options == "") then
      ComboPoints_Print(m_size);
      ComboPoints_Print("Current height :: " .. GetSavedOption("height"));
      ComboPoints_Print("Current width :: " .. GetSavedOption("width"));
   elseif (not gmatch(options, "^%d+$")) then
      ComboPoints_Print(m_size);
   else
      pixels = tonumber(options);
      if (pixels < 8) then
         ComboPoints_Print("Minimum "..command.." is 10");
      else
         SetSavedOption(command, pixels);
         ComboPointsInfo:Display();
         ComboPoints_Print(ucfirst(command).." set to :: "..tostring(pixels));
      end
   end
end
function ComboPoints_SlashHandler_Color(options)
	if(options) then
		options = string.lower(options)
	end
	if(options == "1") then
		ComboPoints_ShowColorPicker(1);
	elseif(options == "2") then
		ComboPoints_ShowColorPicker(2);
	elseif(options == "3") then
		ComboPoints_ShowColorPicker(3);
	elseif (options == "4") then
		ComboPoints_ShowColorPicker(4);
	elseif (options == "5") then
		ComboPoints_ShowColorPicker(5);
	elseif (options == "inactive") then
		ComboPoints_ShowColorPicker(6);
	else
		ComboPoints_Print(m_color);
	end
end
function ComboPoints_SlashHandler_Mode(options)
	if(options) then
		options = string.lower(options)
	else
		option = "5";
	end
	if (options == "1" or options == "2" or options == "3" or options == "4" or options == "5" or options == "6" or options == "7" or options == "8" or options == "9") then
		SetSavedOption("displaymode", options);
		ComboPoints_SetMode();
		ComboPoints_Print("模式设置为 " .. options);
	else
		ComboPoints_Print(m_mode);
	end
end





-- Colour picker, thank you CTMod for giving the idea (and thanks to Mondiga for giving the CTMod team that idea)
function ComboPoints_ShowColorPicker(colournumber)
	local frame = getglobal(CONSTANT_GLOBALUPDATER);
	local color = GetColourDot(colournumber);
	frame.r = color.r;
	frame.g = color.g;
	frame.b = color.b;
	frame.opacity = color.a;
	frame.previousr = color.r;
	frame.previousg = color.g;
	frame.previousb = color.b;
	frame.previousa = color.a;
	frame.currentnumber = colournumber;
	frame.opacityFunc = ComboPoints_ColorPicker_Opacity;
	frame.swatchFunc = ComboPoints_ColorPicker_Color;
	frame.hasOpacity = 1;
	frame.func = ComboPoints_ColorPicker_OK;
	frame.cancelFunc = ComboPoints_ColorPicker_CANCEL;
	UIDropDownMenuButton_OpenColorPicker(frame);
end
function ComboPoints_ColorPicker_OK()
	local frame = getglobal(CONSTANT_GLOBALUPDATER);
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local a = OpacitySliderFrame:GetValue();
	local color = GetColourDot(frame.currentnumber);
	color.r = r;
	color.g = g;
	color.b = b;
	color.a = a;
	var.colorpick = false;
	var.show_val = 0;
	SetColourDot(frame.currentnumber, color);
	ComboPointsInfo:Display(MODE_COLORPICK, frame.currentnumber);
end
function ComboPoints_ColorPicker_CANCEL(value)
	--CBPprint("Cancel");
	local frame = getglobal(CONSTANT_GLOBALUPDATER);
	if(value ~= nil) then
		color = GetColourDot(frame.currentnumber);
		color.r = frame.previousr;
		color.g = frame.previousg;
		color.b = frame.previousb;
		color.a = frame.previousa;
		SetColourDot(frame.currentnumber, color);
	end
	var.colorpick = false;
	var.show_val = 0;
	ComboPointsInfo:Display();
end
function ComboPoints_ColorPicker_Opacity()
	local a = OpacitySliderFrame:GetValue();
	local frame = getglobal(CONSTANT_GLOBALUPDATER);
	frame.opacity = a;

	local color = GetColourDot(frame.currentnumber);
	color.a = a;
	SetColourDot(frame.currentnumber, color);
	--var.colorpick = true;
	var.show_val = frame.currentnumber;
	ComboPointsInfo:Display(MODE_COLORPICK, frame.currentnumber);
end
function ComboPoints_ColorPicker_Color()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local frame = getglobal(CONSTANT_GLOBALUPDATER);
	frame.r = r;
	frame.g = g;
	frame.b = b;

	local color = GetColourDot(frame.currentnumber);
	color.r = r;
	color.g = g;
	color.b = b;
	--CBPprint("color"..frame.currentnumber);
	SetColourDot(frame.currentnumber, color);
	var.show_val = frame.currentnumber;
	--var.colorpick = true;
	ComboPointsInfo:Display(MODE_COLORPICK, frame.currentnumber);
end


function ComboPoints_Print(msg)
	--DEFAULT_CHAT_FRAME:AddMessage(colorhex("#FF0000").."连击点|r: "..msg);
end


function ComboPoints_ComboBar_StartMoving(index)
	if(not index) then
		index = 0;
	end

	if (not GetSavedOption("locked") and ((ComboPointsInfo:GetCurrent() >= index) or (var.show_lock == true) )) then
		ComboPoints_ComboBar:StartMoving();
		var.is_moving = true;
		ComboPointsInfo:Display();
	elseif(GetSavedOption("locked") == true and (ComboPointsInfo:GetCurrent() <= index and ComboPointsInfo:GetCurrent() ~= 0)) then
		ComboPoints_Print(colorhex("#0000AA")..l_Locked);
	end
end
function ComboPoints_ComboBar_StopMoving()
	ComboPoints_ComboBar:StopMovingOrSizing();
	var.is_moving = false;
	ComboPointsInfo:Display();
end




--	if event == 'VARIABLES_LOADED' then
--		variables_loaded = true;
--	end
--	if variables_loaded and UnitExists('player') then
--		local pn = UnitName('player');
--		if playerName ~= pn and pn ~= nil and pn ~= UNKNOWNBEING and pn ~= UKNOWNBEING and pn ~= UNKNOWNOBJECT then
--			playerName = pn;
--			load_time = GetTime() + 1;
--		end
--	end
--


--/Events


--			var.playerName = UnitName("player");
--			var.realmName = GetCVar("realmName");


-- Private Functions


function GetRealmTable()
	local tab = nil;
	if((var.realmName == '')) then
		if(GetCVar("realmName") ~= nil and GetCVar("realmName") ~= '' ) then
			var.realmName = GetCVar("realmName");
		end
	end
	if(var.playerName == '') then
		if(UnitName("player") ~= nil) then
			var.playerName = UnitName("player");
		end
	end
	if((var.realmName ~= '') ) then
		tab = ComboPoints_Saved[var.realmName];
		if(not tab) then
			ComboPoints_Saved[var.realmName] = { };
			tab = { };
		end
	else
		--CBPprint("no realm name");
	end
	return tab;
end

function GetPlayerTable()
	local tab = GetRealmTable();
	local val = nil;
	if(tab) then
		if(var.playerName ~= '') then
			tab = tab[var.playerName];
			if(not tab) then
				tab = standardSettings;
				ComboPoints_Saved[var.realmName][var.playerName] = standardSettings;
			end
		else
			return nil;
		end
	else
		return nil;
	end
	return tab;
end

function IsRogueClass()
	local playerClass, englishClass = UnitClass("player");
	if((englishClass ~= "ROGUE") and (englishClass ~= "DRUID")) then
		return false;
	else
		return true;
	end
end


function colorhex(hex)
	if(string.sub(hex, 1,1) == "#") then
		hex = string.sub(hex, 2);
	end
	local col = "|c00"..hex;
	return col;	
end


--/Private Functions

--CBP Functions
function ComboPointsInfo:GetCurrent()
	return addon:CalcPoints();
end

function ComboPointsInfo:SetMode()
	if (var.colorpick == true) then
		var.show_mode = MODE_COLORPICK;
	elseif (var.move_lock == true) then
		var.show_mode = MODE_MOVABLE;
	elseif (var.show_lock == true) then
		var.show_mode = MODE_MOVABLE;
	else
		var.show_mode = MODE_NORMAL;
	end
end
function ComboPointsInfo:Display(mode, modeval)
	local combos = self:GetCurrent();
	if (GetSavedOption("visible") == false) then
		self:ShowMain(1);
		return;
	else
		self:ShowMain();
	end
	if (not mode) then
		ComboPointsInfo:SetMode();
		mode = tonumber(var.show_mode);
		if(not mode) then mode = MODE_NORMAL; end
	end
	if (not modeval) then
		modeval = tonumber(var.show_val);
		if(not modeval) then modeval = 0; end
	end
--	CBPprint("Display :: " .. mode .. " :: " .. modeval);
	for i = 1, 5 do
		if (mode == MODE_COLORPICK) then
			if (modeval == i or modeval == 6) then
--				CBPprint("Dot: " .. i .. " == ColorPick this");
				self:ShowWindow(i, 1);
			else
--				CBPprint("Dot: " .. i .. " == ColorPick Other");
				self:ShowWindow(i, 1);
			end
		elseif (mode == MODE_MOVABLE) then
			if(var.is_moving) then
--				CBPprint("Dot: " .. i .. " == movable this");
				self:ShowWindow(i, 3);
			else
--				CBPprint("Dot: " .. i .. " == movable other");
				self:ShowWindow(i, 1);
			end
		elseif (mode == MODE_NORMAL) then
			if(i <= combos) then
--				CBPprint("Dot: " .. i .. " == normal this");
				self:ShowWindow(i, 1);
			elseif (GetSavedOption("showlock") == true) then
				self:ShowWindow(i, 3);
			else
--				CBPprint("Dot: " .. i .. " == normal other");
				self:ShowWindow(i, 2);
			end
		end
	end
end

function ComboPointsInfo:ShowWindow(combo, mode)
	if(GetSavedOption("visible") == false) then
		self:ShowMain(1);
		return;
	end
	mode = tonumber(mode);
	local frame = getglobal(CONSTANT_BASEPOINTS..combo);
	local bar = frame.bar;
	local color = GetColourDot(combo);
	if (mode == 1) then
		--CBPprint("R :: " .. color.r .. " G :: " .. color.g .. " B :: " .. color.b .. " A :: " .. color.a);
        	height = GetSavedOption("height")
		width = GetSavedOption("width")
		frame:SetHeight(height)
		frame:SetWidth(width)
		frame:Show();
		bar:Show();
		bar:SetValue(1);
		bar:SetStatusBarColor(color.r, color.g, color.b, color.a);
		frame:SetBackdropColor(0,0,0,1);
	elseif (mode == 2) then	
		frame:Hide();
		bar:Hide();
	elseif (mode == 3) then
		color = GetColourDot("6");
		--CBPprint("R :: " .. color.r .. " G :: " .. color.g .. " B :: " .. color.b .. " A :: " .. color.a);
        	height = GetSavedOption("height")
		width = GetSavedOption("width")
		frame:SetHeight(height)
		frame:SetWidth(width)
		frame:Show();
		bar:Show();
		bar:SetMinMaxValues(0,1);
		bar:SetValue(1);
		bar:SetStatusBarColor(color.r, color.g, color.b, color.a);
		frame:SetBackdropColor(0,0,0,0);
	end
end

-- Modes
--1 = normal
--2 = hide
--3 = move
function ComboPointsInfo:ShowMain(hide)
	local glob = getglobal("ComboPoints_ComboBar");
	if(not hide) then
		glob:Show();
	else
		glob:Hide();
	end
end



local function argsToString(arg, ...)
	if select("#", ...) > 0 then
		return tostring(arg), argsToString(...)
	else
		return tostring(arg)
	end
end

function CBPprint(...)
	local output = strjoin(", ", argsToString(...))
	DEFAULT_CHAT_FRAME:AddMessage("CBP: "..output)
end

--/CBP Functions
