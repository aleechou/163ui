local cfg = TipTac_Config;
local modName = "TipTac";
local ignoreConfigUpdate;

-- DropDown Lists
local DROPDOWN_FONTFLAGS = {
	["|cffffa0a0None"] = "",
	["Outline"] = "OUTLINE",
	["Thick Outline"] = "THICKOUTLINE",
};
local DROPDOWN_ANCHORTYPE = {
	["Normal Anchor"] = "normal",
	["Mouse Anchor"] = "mouse",
	["Parent Anchor"] = "parent",
};

local DROPDOWN_ANCHORPOS = {
	["Top"] = "TOP",
	["Top Left"] = "TOPLEFT",
	["Top Right"] = "TOPRIGHT",
	["Bottom"] = "BOTTOM",
	["Bottom Left"] = "BOTTOMLEFT",
	["Bottom Right"] = "BOTTOMRIGHT",
	["Left"] = "LEFT",
	["Right"] = "RIGHT",
	["Center"] = "CENTER",
};

local DROPDOWN_BARTEXTFORMAT = {
	["|cffffa0a0None"] = "none",
	["Percentage"] = "percent",
	["Current Only"] = "current",
	["Values"] = "value",
	["Values & Percent"] = "full",
	["Deficit"] = "deficit",
};

-- Options -- The "y" value of a category subtable, will further increase the vertical position of the *next* item
local activePage = 1;
local frames = {};
local options = {
	-- General
	{
		[0] = "General",
		{ type = "Check", var = "showUnitTip", label = "Enable TipTac Unit Tip Appearance", tip = "Will change the appearance of how unit tips look. Many options in TipTac only work with this setting enabled.\nNOTE: Using this options with a non English client may cause issues!", y = 8 },
		{ type = "Check", var = "showStatus", label = "Show DC, AFK and DND Status", tip = "Will show the <DC>, <AFK> and <DND> status after the player name" },
		{ type = "Check", var = "showGuildRank", label = "Show Player Guild Rank Title", tip = "In addition to the guild name, with this option on, you will also see their guild rank by title" },
		{ type = "Check", var = "showTargetedBy", label = "Show Who Targets the Unit", tip = "When in a raid or party, the tip will show who from your group is targeting the unit" },
		{ type = "Check", var = "showPlayerGender", label = "Show Player Gender", tip = "This will show the gender of the player. E.g. \"85 Female Blood Elf Paladin\".", y = 16 },
		{ type = "DropDown", var = "nameType", label = "Name Type", list = { ["Name only"] = "normal", ["Use player titles"] = "title", ["Copy from original tip"] = "original", ["Mary Sue Protocol"] = "marysueprot" } },
		{ type = "DropDown", var = "showRealm", label = "Show Unit Realm", list = { ["Do not show realm"] = "none", ["Show realm"] = "show", ["Show (*) instead"] = "asterisk" } },
		{ type = "DropDown", var = "showTarget", label = "Show Unit Target", list = { ["Do not show target"] = "none", ["First line"] = "first", ["Second line"] = "second", ["Last line"] = "last" }, y = 16 },
		{ type = "Text", var = "targetYouText", label = "Targeting You Text" },
	},
	-- Special
	{
		[0] = "Special",
		{ type = "Slider", var = "gttScale", label = "Tooltip Scale", min = 0.2, max = 4, step = 0.05 },
		{ type = "Slider", var = "updateFreq", label = "Tip Update Frequency", min = 0, max = 5, step = 0.05, y = 24 },
		{ type = "Check", var = "enableChatHoverTips", label = "Enable ChatFrame Hover Hyperlinks", tip = "When hovering the mouse over a link in the chatframe, show the tooltip without having to click on it" },
		{ type = "Check", var = "hideFactionText", label = "Hide Faction Text", tip = "Strips the Alliance or Horde faction text from the tooltip" },
		{ type = "Check", var = "hideRealmText", label = "Hide Coalesced Realm Text", tip = "Strips the Coalesced Realm text from the tooltip" },
 	},
	-- Colors
	{
		[0] = "Colors",
		{ type = "Check", var = "colorGuildByReaction", label = "Color Guild by Reaction", tip = "Guild color will have the same color as the reacion", y = 8 },
		{ type = "Color", subType = 2, var = "colGuild", label = "Guild Color", tip = "Color of the guild name, when not using the option to make it the same as reaction color" },
		{ type = "Color", subType = 2, var = "colSameGuild", label = "Same Guild Color", tip = "To better recognise players from your guild, you can configure the color of your guild name individually", y = 16 },
		{ type = "Color", subType = 2, var = "colRace", label = "Race & Creature Type Color", tip = "The color of the race and creature type text" },
		{ type = "Color", subType = 2, var = "colLevel", label = "Neutral Level Color", tip = "Units you cannot attack will have their level text shown in this color", y = 12 },
		{ type = "Check", var = "colorNameByClass", label = "Color Player Names by Class Color", tip = "With this option on, player names are colored by their class color, otherwise they will be colored by reaction" },
		{ type = "Check", var = "classColoredBorder", label = "Color Tip Border by Class Color", tip = "For players, the border color will be colored to match the color of their class" },
	},
	-- Reactions
	{
		[0] = "Reactions",
		{ type = "Check", var = "reactText", label = "Show the unit's reaction as text", tip = "With this option on, the reaction of the unit will be shown as text on the last line", y = 42 },
		{ type = "Color", subType = 2, var = "colReactText1", label = "Tapped Color" },
		{ type = "Color", subType = 2, var = "colReactText2", label = "Hostile Color" },
		{ type = "Color", subType = 2, var = "colReactText3", label = "Caution Color" },
		{ type = "Color", subType = 2, var = "colReactText4", label = "Neutral Color" },
		{ type = "Color", subType = 2, var = "colReactText5", label = "Friendly NPC or PvP Player Color" },
		{ type = "Color", subType = 2, var = "colReactText6", label = "Friendly Player Color" },
		{ type = "Color", subType = 2, var = "colReactText7", label = "Dead Color" },
	},
	-- BG Color
	{
		[0] = "BG Color",
		{ type = "Check", var = "reactColoredBackdrop", label = "Color backdrop based on the unit's reaction", tip = "If you want the tip's background color to be determined by the unit's reaction towards you, enable this. With the option off, the background color will be the one selected on the 'Backdrop' page" },
		{ type = "Check", var = "reactColoredBorder", label = "Color border based on the unit's reaction", tip = "Same as the above option, just for the border\nNOTE: This option overrides class colored border", y = 20 },
		{ type = "Color", var = "colReactBack1", label = "Tapped Color" },
		{ type = "Color", var = "colReactBack2", label = "Hostile Color" },
		{ type = "Color", var = "colReactBack3", label = "Caution Color" },
		{ type = "Color", var = "colReactBack4", label = "Neutral Color" },
		{ type = "Color", var = "colReactBack5", label = "Friendly NPC or PvP Player Color" },
		{ type = "Color", var = "colReactBack6", label = "Friendly Player Color" },
		{ type = "Color", var = "colReactBack7", label = "Dead Color" },
	},
	-- Backdrop
	{
		[0] = "Backdrop",
		{ type = "DropDown", var = "tipBackdropBG", label = "Background Texture", media = "background" },
		{ type = "DropDown", var = "tipBackdropEdge", label = "Border Texture", media = "border", y = 8 },
		{ type = "Slider", var = "backdropEdgeSize", label = "Backdrop Edge Size", min = 0, max = 64, step = 0.5 },
		{ type = "Slider", var = "backdropInsets", label = "Backdrop Insets", min = -20, max = 20, step = 0.5, y = 18 },
		{ type = "Color", var = "tipColor", label = "Tip Background Color" },
		{ type = "Color", var = "tipBorderColor", label = "Tip Border Color", y = 10 },
		{ type = "Check", var = "gradientTip", label = "Show Gradient Tooltips", tip = "Display a small gradient area at the top of the tip to add a minor 3D effect to it. If you have an addon like Skinner, you may wish to disable this to avoid conflicts", y = 6 },
		{ type = "Color", var = "gradientColor", label = "Gradient Color", tip = "Select the base color for the gradient" },
	},
	-- Font
	{
		[0] = "Font",
		{ type = "Check", var = "modifyFonts", label = "Modify the GameTooltip Font Templates", tip = "For TipTac to change the GameTooltip font templates, and thus all tooltips in the User Interface, you have to enable this option.\nNOTE: If you have an addon such as ClearFont, it might conflict with this option.", y = 12 },
		{ type = "DropDown", var = "fontFace", label = "Font Face", media = "font" },
		{ type = "DropDown", var = "fontFlags", label = "Font Flags", list = DROPDOWN_FONTFLAGS },
		{ type = "Slider", var = "fontSize", label = "Font Size", min = 6, max = 29, step = 1, y = 12 },
		{ type = "Slider", var = "fontSizeDelta", label = "Font Size Delta", min = 0, max = 10, step = 1 },
	},
	-- Classify
	{
		[0] = "Classify",
		{ type = "Text", var = "classification_minus", label = "Minus" },
		{ type = "Text", var = "classification_trivial", label = "Trivial" },
		{ type = "Text", var = "classification_normal", label = "Normal" },
		{ type = "Text", var = "classification_elite", label = "Elite" },
		{ type = "Text", var = "classification_worldboss", label = "Boss" },
		{ type = "Text", var = "classification_rare", label = "Rare" },
		{ type = "Text", var = "classification_rareelite", label = "Rare Elite" },
	},
	-- Fading
	{
		[0] = "Fading",
		{ type = "Check", var = "overrideFade", label = "Override Default GameTooltip Fade", tip = "Overrides the default fadeout function of the GameTooltip. If you are seeing problems regarding fadeout, please disable.", y = 16 },
		{ type = "Slider", var = "preFadeTime", label = "Prefade Time", min = 0, max = 5, step = 0.05 },
		{ type = "Slider", var = "fadeTime", label = "Fadeout Time", min = 0, max = 5, step = 0.05, y = 16 },
		{ type = "Check", var = "hideWorldTips", label = "Instantly Hide World Frame Tips", tip = "This option will make tips which appear from objects in the world disappear instantly when you take the mouse off the object. Examples such as mailboxes, herbs or chests.\nNOTE: Does not work for all world objects." },
	},
	-- Bars
	{
		[0] = "Bars",
		{ type = "DropDown", var = "barFontFace", label = "Font Face", media = "font" },
		{ type = "DropDown", var = "barFontFlags", label = "Font Flags", list = DROPDOWN_FONTFLAGS },
		{ type = "Slider", var = "barFontSize", label = "Font Size", min = 6, max = 29, step = 1, y = 36 },
		{ type = "DropDown", var = "barTexture", label = "Bar Texture", media = "statusbar" },
		{ type = "Slider", var = "barHeight", label = "Bar Height", min = 1, max = 50, step = 1 },
	},
	-- Bar Types
	{
		[0] = "Bar Types",
		{ type = "Check", var = "hideDefaultBar", label = "Hide the Default Health Bar", tip = "Check this to hide the default health bar" },
		{ type = "Check", var = "barsCondenseValues", label = "Show Condensed Bar Values", tip = "You can enable this option to condense values shown on the bars. It does this by showing 57254 as 57.3k as an example" },
		{ type = "Check", var = "healthBar", label = "Show Health Bar", tip = "Will show a health bar of the unit." },
		{ type = "DropDown", var = "healthBarText", label = "Health Bar Text", list = DROPDOWN_BARTEXTFORMAT, y = -2 },
		{ type = "Check", var = "healthBarClassColor", label = "Class Colored Health Bar", tip = "This options colors the health bar in the same color as the player class", y = 6 },
		{ type = "Color", var = "healthBarColor", label = "Health Bar Color", tip = "The color of the health bar. Has no effect for players with the option above enabled", y = 10 },
		{ type = "Check", var = "manaBar", label = "Show Mana Bar", tip = "If the unit has mana, a mana bar will be shown." },
		{ type = "DropDown", var = "manaBarText", label = "Mana Bar Text", list = DROPDOWN_BARTEXTFORMAT },
		{ type = "Color", var = "manaBarColor", label = "Mana Bar Color", tip = "The color of the mana bar", y = 10 },
		{ type = "Check", var = "powerBar", label = "Show Energy, Rage, Runic Power or Focus Bar", tip = "If the unit uses either energy, rage, runic power or focus, a bar for that will be shown." },
		{ type = "DropDown", var = "powerBarText", label = "Power Bar Text", list = DROPDOWN_BARTEXTFORMAT },
	},
	-- Auras
	{
		[0] = "Auras",
		{ type = "Check", var = "aurasAtBottom", label = "Put Aura Icons at the Bottom Instead of Top", tip = "Puts the aura icons at the bottom of the tip instead of the default top", y = 12 },
		{ type = "Check", var = "showBuffs", label = "Show Unit Buffs", tip = "Show buffs of the unit" },
		{ type = "Check", var = "showDebuffs", label = "Show Unit Debuffs", tip = "Show debuffs of the unit", y = 12 },
		{ type = "Check", var = "selfAurasOnly", label = "Only Show Auras Coming from You", tip = "This will filter out and only display auras you cast yourself", y = 12 },
		{ type = "Slider", var = "auraSize", label = "Aura Icon Dimension", min = 8, max = 60, step = 1 },
		{ type = "Slider", var = "auraMaxRows", label = "Max Aura Rows", min = 1, max = 8, step = 1, y = 8 },
		{ type = "Check", var = "showAuraCooldown", label = "Show Cooldown Models", tip = "With this option on, you will see a visual progress of the time left on the buff" },
		{ type = "Check", var = "noCooldownCount", label = "No Cooldown Count Text", tip = "Tells cooldown enhancement addons, such as OmniCC, not to display cooldown text" },
	},
	-- Icon
	{
		[0] = "Icon",
		{ type = "Check", var = "iconRaid", label = "Show Raid Icon", tip = "Shows the raid icon next to the tip" },
		{ type = "Check", var = "iconFaction", label = "Show Faction Icon", tip = "Shows the faction icon next to the tip" },
		{ type = "Check", var = "iconCombat", label = "Show Combat Icon", tip = "Shows a combat icon next to the tip, if the unit is in combat", y = 12 },
		{ type = "DropDown", var = "iconAnchor", label = "Icon Anchor", list = DROPDOWN_ANCHORPOS },
		{ type = "Slider", var = "iconSize", label = "Icon Dimension", min = 8, max = 60, step = 1 },
	},
	-- Anchors
	{
		[0] = "Anchors",
		{ type = "DropDown", var = "anchorWorldUnitType", label = "World Unit Type", list = DROPDOWN_ANCHORTYPE },
		{ type = "DropDown", var = "anchorWorldUnitPoint", label = "World Unit Point", list = DROPDOWN_ANCHORPOS, y = 14 },
		{ type = "DropDown", var = "anchorWorldTipType", label = "World Tip Type", list = DROPDOWN_ANCHORTYPE },
		{ type = "DropDown", var = "anchorWorldTipPoint", label = "World Tip Point", list = DROPDOWN_ANCHORPOS, y = 14 },
		{ type = "DropDown", var = "anchorFrameUnitType", label = "Frame Unit Type", list = DROPDOWN_ANCHORTYPE },
		{ type = "DropDown", var = "anchorFrameUnitPoint", label = "Frame Unit Point", list = DROPDOWN_ANCHORPOS, y = 14 },
		{ type = "DropDown", var = "anchorFrameTipType", label = "Frame Tip Type", list = DROPDOWN_ANCHORTYPE },
		{ type = "DropDown", var = "anchorFrameTipPoint", label = "Frame Tip Point", list = DROPDOWN_ANCHORPOS, y = 14 },
	},
	-- Mouse
	{
		[0] = "Mouse",
		{ type = "Slider", var = "mouseOffsetX", label = "Mouse Anchor X Offset", min = -200, max = 200, step = 1 },
		{ type = "Slider", var = "mouseOffsetY", label = "Mouse Anchor Y Offset", min = -200, max = 200, step = 1 },
	},
	-- Combat
	{
		[0] = "Combat",
		{ type = "Check", var = "hideAllTipsInCombat", label = "Hide All Unit Tips in Combat", tip = "In combat, this option will prevent any unit tips from showing" },
		{ type = "Check", var = "hideUFTipsInCombat", label = "Hide Unit Tips for Unit Frames in Combat", tip = "When you are in combat, this option will prevent tips from showing when you have the mouse over a unit frame", y = 8 },
		{ type = "Check", var = "showHiddenTipsOnShift", label = "Still Show Hidden Tips when Holding Shift", tip = "When you have this option checked, and one of the above options, you can still force the tip to show, by holding down shift" },
--		{ type = "DropDown", var = "hideCombatTip", label = "Hide Tips in Combat For", list = { ["Unit Frames"] = "uf", ["All Tips"] = "all", ["No Tips"] = "none" } },
	},
	-- Layouts
	{
		[0] = "Layouts",
		{ type = "DropDown", label = "Layout Template", init = TipTacDropDowns.LoadLayout_Init, y = 20 },
--		{ type = "Text", label = "Save Layout", func = nil },
--		{ type = "DropDown", label = "Delete Layout", init = TipTacDropDowns.DeleteLayout_Init },
	},
};

-- TipTacTalents Support
if (TipTacTalents) then
	options[#options + 1] = {
		[0] = "Talents",
		{ type = "Check", var = "showTalents", label = "Enable TipTacTalents", tip = "This option makes the tip show the talent specialization of other players" },
		{ type = "Check", var = "talentOnlyInParty", label = "Only Show Talents for Players in Party or Raid", tip = "When you enable this, only talents of players in your party or raid will be requested and shown", y = 12 },
--		{ type = "DropDown", var = "talentFormat", label = "Talent Format", list = { ["Elemental (57/14/00)"] = 1, ["Elemental"] = 2, ["57/14/00"] = 3,}, y = 8 },	-- not supported with MoP changes
		{ type = "Slider", var = "talentCacheSize", label = "Talent Cache Size", min = 0, max = 50, step = 1 },
	};
end

-- TipTacItemRef Support -- Az: this category page is full
if (TipTacItemRef) then
	options[#options + 1] = {
		[0] = "ItemRef",
		{ type = "Check", var = "if_enable", label = "Enable ItemRefTooltip Modifications", tip = "Turns on or off all features of the TipTacItemRef addon", y = 8 },
		{ type = "Color", var = "if_infoColor", label = "Information Color", tip = "The color of the various tooltip lines added by these options" },
		{ type = "Check", var = "if_itemQualityBorder", label = "Show Item Tips with Quality Colored Border", tip = "When enabled and the tip is showing an item, the tip border will have the color of the item's quality" },
		{ type = "Check", var = "if_showAuraCaster", label = "Show Aura Tooltip Caster", tip = "When showing buff and debuff tooltips, it will add an extra line, showing who cast the specific aura" },
		{ type = "Check", var = "if_showItemLevelAndId", label = "Show Item Level & ID", tip = "For item tooltips, show their itemLevel and itemID" },
		{ type = "Check", var = "if_showSpellIdAndRank", label = "Show Spell ID & Rank", tip = "For spell tooltips, show their spellID and spellRank" },
--		{ type = "Check", var = "if_showCurrencyId", label = "Show Currency ID", tip = "Currency items will now show their ID" },
--		{ type = "Check", var = "if_showAchievementIdAndCategory", label = "Show Achievement ID & Category", tip = "On achievement tooltips, the achievement ID as well as the category will be shown" },
		{ type = "Check", var = "if_showQuestLevelAndId", label = "Show Quest Level & ID", tip = "For quest tooltips, show their questLevel and questID" },
		{ type = "Check", var = "if_modifyAchievementTips", label = "Modify Achievement Tooltips", tip = "Changes the achievement tooltips to show a bit more information\nWarning: Might conflict with other achievement addons" },
		{ type = "Check", var = "if_showIcon", label = "Show Icon Texture and Count (when available)", tip = "Shows an icon next to the tooltip" },
		{ type = "Check", var = "if_smartIcons", label = "Smart Icon Appearance", tip = "When enabled, TipTacItemRef will determine if an icon is needed, based on where the tip is shown. It will not be shown on actionbars or bag slots for example, as they already show an icon" },
		{ type = "Check", var = "if_borderlessIcons", label = "Borderless Icons", tip = "Turn off the border on icons" },
		{ type = "Slider", var = "if_iconSize", label = "Icon Size", min = 16, max = 128, step = 1 },
	};
end

--------------------------------------------------------------------------------------------------------
--                                          Initialize Frame                                          --
--------------------------------------------------------------------------------------------------------

local f = CreateFrame("Frame",modName.."Options",UIParent);

f.options = options;

f:SetWidth(424);
f:SetHeight(378);	-- "18" per category entry
f:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 16, edgeSize = 16, insets = { left = 3, right = 3, top = 3, bottom = 3 } });
f:SetBackdropColor(0.1,0.22,0.35,1);
f:SetBackdropBorderColor(0.1,0.1,0.1,1);
f:EnableMouse(1);
f:SetMovable(1);
f:SetFrameStrata("DIALOG");
f:SetToplevel(1);
f:SetClampedToScreen(1);
f:SetScript("OnShow",function() f:BuildCategoryPage(); end);
f:Hide();

f.outline = CreateFrame("Frame",nil,f);
f.outline:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } });
f.outline:SetBackdropColor(0.1,0.1,0.2,1);
f.outline:SetBackdropBorderColor(0.8,0.8,0.9,0.4);
f.outline:SetPoint("TOPLEFT",12,-12);
f.outline:SetPoint("BOTTOMLEFT",12,12);
f.outline:SetWidth(84);

f:SetScript("OnMouseDown",function() f:StartMoving() end);
f:SetScript("OnMouseUp",function() f:StopMovingOrSizing(); cfg.optionsLeft = f:GetLeft(); cfg.optionsBottom = f:GetBottom(); end);

if (cfg.optionsLeft) and (cfg.optionsBottom) then
	f:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",cfg.optionsLeft,cfg.optionsBottom);
else
	f:SetPoint("CENTER");
end

f.header = f:CreateFontString(nil,"ARTWORK","GameFontHighlight");
f.header:SetFont(GameFontNormal:GetFont(),22,"THICKOUTLINE");
f.header:SetPoint("TOPLEFT",f.outline,"TOPRIGHT",10,-4);
f.header:SetText(modName.." Options");

f.vers = f:CreateFontString(nil,"ARTWORK","GameFontNormal");
f.vers:SetPoint("TOPRIGHT",-20,-20);
f.vers:SetText(GetAddOnMetadata(modName,"Version"));
f.vers:SetTextColor(1,1,0.5);

local function Reset_OnClick(self)
	for index, tbl in ipairs(options[activePage]) do
		if (tbl.var) then
			cfg[tbl.var] = nil;
		end
	end
	TipTac:ApplySettings();
	f:BuildCategoryPage();
end

f.btnAnchor = CreateFrame("Button",nil,f,"UIPanelButtonTemplate");
f.btnAnchor:SetWidth(75);
f.btnAnchor:SetHeight(24);
f.btnAnchor:SetPoint("BOTTOMLEFT",f.outline,"BOTTOMRIGHT",10,3);
f.btnAnchor:SetScript("OnClick",function() if (TipTac:IsVisible()) then TipTac:Hide(); else TipTac:Show(); end end);
f.btnAnchor:SetText("Anchor");

f.btnReset = CreateFrame("Button",nil,f,"UIPanelButtonTemplate");
f.btnReset:SetWidth(75);
f.btnReset:SetHeight(24);
f.btnReset:SetPoint("LEFT",f.btnAnchor,"RIGHT",38,0);
f.btnReset:SetScript("OnClick",Reset_OnClick);
f.btnReset:SetText("Defaults");

f.btnClose = CreateFrame("Button",nil,f,"UIPanelButtonTemplate");
f.btnClose:SetWidth(75);
f.btnClose:SetHeight(24);
f.btnClose:SetPoint("BOTTOMRIGHT",-15,15);
f.btnClose:SetScript("OnClick",function() f:Hide(); end);
f.btnClose:SetText("Close");

UISpecialFrames[#UISpecialFrames + 1] = f:GetName();

--------------------------------------------------------------------------------------------------------
--                                        Options Category List                                       --
--------------------------------------------------------------------------------------------------------

local listButtons = {};

local function List_OnClick(self,button)
	listButtons[activePage].text:SetTextColor(1,0.82,0);
	listButtons[activePage]:UnlockHighlight();
	activePage = self.index;
	self.text:SetTextColor(1,1,1);
	self:LockHighlight();
	PlaySound("igMainMenuOptionCheckBoxOn");
	f:BuildCategoryPage();
end

local buttonWidth = (f.outline:GetWidth() - 8);
local function MakeListEntry()
	local b = CreateFrame("Button",nil,f.outline);
	b:SetWidth(buttonWidth);
	b:SetHeight(18);
	b:SetScript("OnClick",List_OnClick);
	b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	b:GetHighlightTexture():SetAlpha(0.7);
	b.text = b:CreateFontString(nil,"ARTWORK","GameFontNormal");
	b.text:SetPoint("LEFT",3,0);
	listButtons[#listButtons + 1] = b;
	return b;
end

local button;
for index, table in ipairs(options) do
	button = listButtons[index] or MakeListEntry();
	button.text:SetText(table[0]);
	button.index = index;
	if (index == 1) then
		button:LockHighlight();
		button.text:SetTextColor(1,1,1);
		button:SetPoint("TOPLEFT",f.outline,"TOPLEFT",5,-6);
	else
		button:SetPoint("TOPLEFT",listButtons[index - 1],"BOTTOMLEFT");
	end
end

--------------------------------------------------------------------------------------------------------
--                                        Build Option Category                                       --
--------------------------------------------------------------------------------------------------------

local function ChangeSettingFunc(self,var,value)
	if (not ignoreConfigUpdate) then
		cfg[var] = value;
		TipTac:ApplySettings();
	end
end

local factory = AzOptionsFactory:New(f,nil,ChangeSettingFunc);

-- Build Page
function f:BuildCategoryPage()
	AzDropDown:HideMenu();
	factory:ResetObjectUse();
	local frame;
	local yOffset = -38;
	-- Loop Through Options
	ignoreConfigUpdate = 1;
	for index, option in ipairs(options[activePage]) do
		-- Init & Setup the Frame
		frame = factory:GetObject(option.type);
		frame.option = option;
		frame.text:SetText(option.label);
		-- slider
		if (option.type == "Slider") then
			frame.slider:SetMinMaxValues(option.min,option.max);
			frame.slider:SetValueStep(option.step);
			frame.slider:SetValue(cfg[option.var]);
			frame.edit:SetNumber(cfg[option.var]);
			frame.low:SetText(option.min);
			frame.high:SetText(option.max);
		-- check
		elseif (option.type == "Check") then
			frame:SetHitRectInsets(0,frame.text:GetWidth() * -1,0,0);
			frame:SetChecked(cfg[option.var]);
		-- color
		elseif (option.type == "Color") then
			frame:SetHitRectInsets(0,frame.text:GetWidth() * -1,0,0);
			if (option.subType == 2) then
				frame.color[1], frame.color[2], frame.color[3], frame.color[4] = factory:HexStringToRGBA(cfg[option.var]);
			else
				frame.color[1], frame.color[2], frame.color[3], frame.color[4] = unpack(cfg[option.var]);
			end
			frame.texture:SetVertexColor(frame.color[1],frame.color[2],frame.color[3],frame.color[4] or 1);
		-- dropdown
		elseif (option.type == "DropDown") then
			frame.InitFunc = (option.init or option.media and TipTacDropDowns.SharedMediaLib_Init or TipTacDropDowns.Default_Init);
			frame:InitSelectedItem(cfg[option.var]);
		-- text
		elseif (option.type == "Text") then
			frame:SetText(cfg[option.var]:gsub("|","||"));
		end
		-- Anchor the Frame
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT",f.outline,"TOPRIGHT",factory.objectOffsetX[option.type] + (option.x or 0),yOffset);
		yOffset = (yOffset - frame:GetHeight() - factory.objectOffsetY[option.type] - (option.y or 0));
		-- Show
		frame:Show();
	end
	-- End Update
	ignoreConfigUpdate = nil;
end