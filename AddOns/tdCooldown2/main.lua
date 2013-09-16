local format = format;
local tostring = tostring;
local tonumber = tonumber;
local CreateFrame = CreateFrame;
local CreateFont = CreateFont;
local __DEBUG = false;
local font;
if (GetLocale() == "zhCN") then
	font = "Fonts\\ARKai_T.TTF";
elseif (GetLocale() == "zhTW") then
	font = "Fonts\\bLEI00D.TTF";
else
	font = "Fonts\\ARIALN.TTF";
end

local version = GetAddOnMetadata("tdCooldown2", "Version");
local limit = "30300.1";
local L = TDCOOLDOWN2_LACALE;

tdCooldown2 = CreateFrame("Frame", false, UIParent);
tdCooldown2:Hide();

local tCD = tdCooldown2;
tCD.methods = {};

function tCD:GetDefault()
	return {
		ACTION = {
			config = true, hidecooldown = false, long = false, shine = true, alpha = 0.8, size = 24,
			scale = 4, style = 0, font = font, min = 2.99, 
		},
		BUFF = {
			config = true, hidecooldown = false, max = 0, long = false, alpha = 0.8, size = 30, point = "CENTER", font = font, x = -2, y = 2,
		},
		bar = {
			locked = true, hidden = false, sound = false, reverse = false, spacing = 5, config = false,
			height = 24, width = 100, alpha = 0.9, size = 15, min = 2.99, font = font;
			position = {p = "CENTER", r = "CENTER", x = 0, y = 0,},			
		},
		center = {
			config = true, text = true, mode = true, alpha = 1,
			width = 100, time = 1.2, size = 30, font = font,
			r = 0, g = 1, b = 1, style = 1,
			position = {p = "CENTER", r = "CENTER", x = 0, y = 0,},
		},
		days  = {r = 0.4, g = 0.4, b = 0.4, s = 0.6},
		hrs   = {r = 0.6, g = 0.4, b = 0.0, s = 0.6},
		mins  = {r = 0.8, g = 0.6, b = 0.0, s = 0.7},
		secs  = {r = 1.0, g = 0.8, b = 0.0, s = 1.0},
		short = {r = 1.0, g = 0.12, b = 0.12, s = 1.1},
		version = version,
        mine = true,
        ignoreCompactRaid = true,
		redout = false,
	}
end

-- unused loaded
function tCD:FormatVersion(value)
	value = value and tostring(value);
	if not value then
		return 0, 0;
	else
		local wow, ui = value:match("^(%d+).(%d+)$");
		return wow and tonumber(wow) or 0, ui and tonumber(ui) or 0;
	end
end

function tCD:UpdateSettings(oWow, oUi)
--[[
	if oWow < 30000 or oUi < 14 then
	end
]]	
end

function tCD:UpdateVersion()
	if not tCD2DB then
		tCD2DB = self:GetDefault();
		self:print(L.NewUser);
	else
		if tCD2DB.version ~= version then
			tCD2DB.version = version;
			self:UpdateSettings(oWow, oUi, nWow, nUi);
			self:print(format(L.Updated, version));
		end
	end
	self.db = tCD2DB;
end

function tCD:TestFont(file)
	if not self.testfontstring then
		self.testfontstring = CreateFont("tCDTestFontString");
	end
	if file and self.testfontstring:SetFont(file, 12) then
		return file;
	else
		self:print(format(L.ErrorFont, file or "", font), 1);
		return font;
	end
end

function tCD:print(msg, iserror)
	if (not __DEBUG) then
		return;
	end

	if msg and tostring(msg) and DEFAULT_CHAT_FRAME then
		if iserror then
			DEFAULT_CHAT_FRAME:AddMessage("|cff7fff7ftdCooldown2|r|cffffffff:|r "..tostring(msg), 1, 0, 0);
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff7fff7ftdCooldown2|r: "..tostring(msg));
		end
	end
end

function tCD:LoadOption()
		if LoadAddOn("tdCooldown2_Option") then
			self.option:SetScript('OnShow', false);
			self:print(L["Options loaded !"]);
		else
			self:print(L["options load failed!!"])
		end
end

local _ADDON = ...
function tCD:ADDON_LOADED(addon)	
	-- if (addon == "tdCooldown2") then
    if(addon == _ADDON) then
		self:UnregisterEvent("ADDON_LOADED");

		if (not self.db) then
			tCD:UpdateVersion();
		end
		self.db.ACTION.font = self:TestFont(self.db.ACTION.font);
		self.db.BUFF.font = self:TestFont(self.db.BUFF.font);
		self.db.center.font = self:TestFont(self.db.center.font);

		if self.methods.cdloaded then
			self:HookCooldown();
		end

		if self.methods.barloaded then
			self:EnableCenter();
		end

		if self.methods.addons then
			self:DoAddOns()
		end

        if self.methods.range then
            self:LoadRedRange()
        end

		--[[
		self.option = CreateFrame("Frame", false, InterfaceOptionsFrame);
		self.option:Hide();
		self.option:SetScript("OnShow", function() tCD:LoadOption() end);
		self.option.name = "tdCooldown2";
		InterfaceOptions_AddCategory(self.option);
		
		local title = self.option:CreateFontString(false, "ARTWORK", "GameFontNormalLarge");
		title:SetPoint("TOPLEFT", 16, -16);
		title:SetText(L.Title);

		local subtitle = self.option:CreateFontString(false, "ARTWORK", "GameFontHighlightSmall");
		subtitle:SetHeight(350);
		subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8);
		subtitle:SetPoint("RIGHT", self.option, -32, 0);
		subtitle:SetNonSpaceWrap(true);
		subtitle:SetJustifyH("LEFT");
		subtitle:SetJustifyV("TOP");
		subtitle:SetFormattedText(L.Subtitle, version);
		
		SlashCmdList["TDCOOLDOWN2"] = function(str)
			if not tCD.option.loaded then
				tCD:LoadOption();
			end
			InterfaceOptionsFrame_OpenToCategory(tCD.option.name);
		end
		SLASH_TDCOOLDOWN21 = "/tcd";
		SLASH_TDCOOLDOWN22 = "/tcd2";
		SLASH_TDCOOLDOWN23 = "/tdcooldown2";
		]]


        --[[
        self.UpdateSettings = false;
        self.FormatVersion = false;
        self.UpdateVersion = false;
        self.VARIABLES_LOADED = false;
        self.HookCooldown = false;
        self.EnableCenter = false;
        ]]

    end
end

tCD:SetScript("OnEvent", function(self, event, ...) if self[event] then self[event](self, ...) end end)
tCD:RegisterEvent("ADDON_LOADED");

---------------------
-- Added by dugu@bigfoot
function tCD:SetCurVal(key, subkey, value)
	if (not self.db) then
		tCD:UpdateVersion();
	end

	if (self.db[key] and (type(self.db[key]) == "table")) then
		self.db[key][subkey] = value;
	else
		self.db[key] = value;
	end
end

