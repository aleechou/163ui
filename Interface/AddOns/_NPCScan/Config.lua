-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs

-- Libraries
local table = _G.table


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local L = private.L
local panel = _G.CreateFrame("Frame")
private.Config = panel

local Toast = _G.LibStub("LibToast-1.0")

-------------------------------------------------------------------------------
-- Config UI.
-------------------------------------------------------------------------------
panel.name = L.CONFIG_TITLE
panel:Hide()


local panel_title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
panel_title:SetPoint("TOPLEFT", 16, -16)
panel_title:SetText(L.CONFIG_TITLE)


local panel_subtext = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
panel_subtext:SetPoint("TOPLEFT", panel_title, "BOTTOMLEFT", 0, -8)
panel_subtext:SetPoint("RIGHT", -32, 0)
panel_subtext:SetHeight(32)
panel_subtext:SetJustifyH("LEFT")
panel_subtext:SetJustifyV("TOP")
panel_subtext:SetText(L.CONFIG_DESC)


local cache_warnings_checkbox = _G.CreateFrame("CheckButton", "_NPCScanConfigCacheWarningsCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
cache_warnings_checkbox:SetPoint("TOPLEFT", panel_subtext, "BOTTOMLEFT", -2, -8)
_G[cache_warnings_checkbox:GetName() .. "Text"]:SetText(L.CONFIG_CACHEWARNINGS)
cache_warnings_checkbox.tooltipText = L.CONFIG_CACHEWARNINGS_DESC

panel.cache_warnings_checkbox = cache_warnings_checkbox

function cache_warnings_checkbox.setFunc(is_enabled)
	private.SetCacheWarnings(is_enabled == "1")
end


local print_time_checkbox = _G.CreateFrame("CheckButton", "_NPCScanConfigPrintTimeCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
print_time_checkbox:SetPoint("TOPLEFT", panel.cache_warnings_checkbox, "BOTTOMLEFT", 0, -8)
_G[print_time_checkbox:GetName() .. "Text"]:SetText(L.CONFIG_PRINTTIME)
print_time_checkbox.tooltipText = L.CONFIG_PRINTTIME_DESC

panel.print_time_checkbox = print_time_checkbox

function print_time_checkbox.setFunc(is_enabled)
	private.SetPrintTime(is_enabled == "1")
end

local alert_icon_dropdown = _G.CreateFrame("Frame", "_NPCScanConfigIconDropdown", panel, "UIDropDownMenuTemplate")
alert_icon_dropdown:SetPoint("TOPLEFT", panel.print_time_checkbox, "BOTTOMLEFT", -10, -20)
alert_icon_dropdown:SetPoint("RIGHT", -12, 0)
alert_icon_dropdown:EnableMouse(true)
alert_icon_dropdown.tooltipText = L.CONFIG_ALERT_SOUND_DESC

_G.UIDropDownMenu_JustifyText(alert_icon_dropdown, "LEFT")

panel.alert_icon_dropdown = alert_icon_dropdown
do
	local function Icon_Entry_OnSelect(info_table, icon)
		private.SetTargetIcon(icon)
	end


	function alert_icon_dropdown:initialize(level)
		if not level or level ~= 1 then
			return
		end

		local current_icon = private.OptionsCharacter.TargetIcon
		local info = _G.UIDropDownMenu_CreateInfo()

		info.func = Icon_Entry_OnSelect

		for index = 1, private.NUM_RAID_ICONS do
			local icon_info = _G.UnitPopupButtons["RAID_TARGET_" .. index]
			info.text = icon_info.text
			info.arg1 = index
			info.checked = current_icon == index
			info.icon = [[Interface\TargetingFrame\UI-RaidTargetingIcon_]] .. index
			info.colorCode = ("|cFF%02x%02x%02x"):format(icon_info.color.r * 255, icon_info.color.g * 255, icon_info.color.b * 255)

			_G.UIDropDownMenu_AddButton(info, level)
		end
	end
end -- do-block

local alert_icon_label = alert_icon_dropdown:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
alert_icon_label:SetPoint("BOTTOMLEFT", alert_icon_dropdown, "TOPLEFT", 16, 3)
alert_icon_label:SetText(_G.RAID_TARGET_ICON)


local alert_options_panel = _G.CreateFrame("Frame", "_NPCScanConfigAlert", panel, "OptionsBoxTemplate")
alert_options_panel:SetPoint("TOPLEFT", alert_icon_dropdown, "BOTTOMLEFT", 0, -16)
alert_options_panel:SetPoint("BOTTOMRIGHT", -14, 16)
_G[alert_options_panel:GetName() .. "Title"]:SetText(L.CONFIG_ALERT)


local test_button = _G.CreateFrame("Button", "_NPCScanTest", alert_options_panel, "UIPanelButtonTemplate")
test_button:SetSize(144, 21)
test_button:SetPoint("TOPLEFT", 16, -16)
test_button:SetText(L.CONFIG_TEST)
test_button.tooltipText = L.CONFIG_TEST_DESC
test_button:SetScript("OnEnter", panel.ControlOnEnter)
test_button:SetScript("OnLeave", _G.GameTooltip_Hide)
test_button:SetScript("OnClick", function(self)

	private.Print(L.FOUND_FORMAT:format(L.CONFIG_TEST_NAME), _G.GREEN_FONT_COLOR)
	private.Print(L.CONFIG_TEST_HELP_FORMAT:format("CTRL"))

	local alert_text = L.FOUND_FORMAT:format(L.CONFIG_TEST_NAME)

	if private.Options.ShowAlertAsToast then
		Toast:Spawn("_NPCScanAlertToast", alert_text)
	else
		private.Print(alert_text, _G.GREEN_FONT_COLOR)
	end
	private.Print(L.CONFIG_TEST_HELP_FORMAT:format(_G.GetModifiedClick("_NPCSCAN_BUTTONDRAG")))


	private.Button:SetNPC("player", L.CONFIG_TEST_NAME, L.CONFIG_TEST)
end)

panel.test_button = test_button


local show_as_toast_checkbox = _G.CreateFrame("CheckButton", "_NPCScanConfigShowAsToastCheckbox", alert_options_panel, "InterfaceOptionsCheckButtonTemplate")
show_as_toast_checkbox:SetPoint("TOPLEFT", test_button, "BOTTOMLEFT", -2, -16)
_G[show_as_toast_checkbox:GetName() .. "Text"]:SetText(L.CONFIG_ALERT_SHOW_AS_TOAST)
show_as_toast_checkbox.tooltipText = L.CONFIG_ALERT_SHOW_AS_TOAST_DESC

panel.show_as_toast_checkbox = show_as_toast_checkbox

function show_as_toast_checkbox.setFunc(is_enabled)
	private.SetShowAsToast(is_enabled == "1")
end


local persistent_toast_checkbox = _G.CreateFrame("CheckButton", "_NPCScanConfigPersistentToastCheckbox", alert_options_panel, "InterfaceOptionsCheckButtonTemplate")
persistent_toast_checkbox:SetPoint("TOPLEFT", show_as_toast_checkbox, "TOPRIGHT", ( _G[show_as_toast_checkbox:GetName() .. "Text"]:GetStringWidth())+15, 0)
_G[persistent_toast_checkbox:GetName() .. "Text"]:SetText(L.CONFIG_ALERT_PERSISTENT_TOAST)
persistent_toast_checkbox.tooltipText = L.CONFIG_ALERT_PERSISTENT_TOAST_DESC

panel.persistent_toast_checkbox = persistent_toast_checkbox

function persistent_toast_checkbox.setFunc(is_enabled)
	private.SetPersistentToast(is_enabled == "1")
end

local alert_unmute_checkbox = _G.CreateFrame("CheckButton", "_NPCScanConfigUnmuteCheckbox", alert_options_panel, "InterfaceOptionsCheckButtonTemplate")
alert_unmute_checkbox:SetPoint("TOPLEFT", show_as_toast_checkbox, "BOTTOMLEFT", 0, -8)
_G[alert_unmute_checkbox:GetName() .. "Text"]:SetText(L.CONFIG_ALERT_UNMUTE)
alert_unmute_checkbox.tooltipText = L.CONFIG_ALERT_UNMUTE_DESC

panel.alert_unmute_checkbox = alert_unmute_checkbox

function alert_unmute_checkbox.setFunc(is_enabled)
	private.SetAlertSoundUnmute(is_enabled == "1")
end

local screen_edge_flash_checkbox = _G.CreateFrame("CheckButton", "_NPCScanConfigScreenFlashCheckbox", alert_options_panel, "InterfaceOptionsCheckButtonTemplate")
screen_edge_flash_checkbox:SetPoint("TOPLEFT", alert_unmute_checkbox, "BOTTOMLEFT", 0, -8)
_G[screen_edge_flash_checkbox:GetName() .. "Text"]:SetText(L.CONFIG_ALERT_SCREEN_EDGE_FLASH)
screen_edge_flash_checkbox.tooltipText = L.CONFIG_ALERT_SCREEN_EDGE_FLASH_DESC

panel.screen_edge_flash_checkbox = screen_edge_flash_checkbox

function screen_edge_flash_checkbox.setFunc(is_enabled)
	private.SetAlertScreenEdgeFlash(is_enabled == "1")
end

local viginette_scan_checkbox = _G.CreateFrame("CheckButton", "_NPCScanVignetteScanCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
viginette_scan_checkbox:SetPoint("TOPLEFT", screen_edge_flash_checkbox, "BOTTOMLEFT", 0, -8)
viginette_scan_checkbox.tooltipText = L.VIGNETTE_SCAN_DESC

panel.viginette_scan_checkbox = viginette_scan_checkbox

local viginette_scan_label = _G[viginette_scan_checkbox:GetName() .. "Text"]
viginette_scan_label:SetText(L.VIGNETTE_SCAN)
viginette_scan_checkbox:SetHitRectInsets(4, 4 - viginette_scan_label:GetStringWidth(), 4, 4)

function viginette_scan_checkbox.setFunc(is_enabled)
	private.SetVignetteScan(is_enabled == "1")
end

local mouseover_scan_checkbox = _G.CreateFrame("CheckButton", "_NPCScanMouseoverScanCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
mouseover_scan_checkbox:SetPoint("TOPLEFT", viginette_scan_checkbox, "BOTTOMLEFT", 0, -8)
mouseover_scan_checkbox.tooltipText = L.MOUSEOVER_SCAN_DESC

panel.mouseover_scan_checkbox = mouseover_scan_checkbox

local mouseover_scan_label = _G[mouseover_scan_checkbox:GetName() .. "Text"]
mouseover_scan_label:SetText(L.MOUSEOVER_SCAN)
mouseover_scan_checkbox:SetHitRectInsets(4, 4 - mouseover_scan_label:GetStringWidth(), 4, 4)

function mouseover_scan_checkbox.setFunc(is_enabled)
	private.SetMouseoverScan(is_enabled == "1")
end


local block_flight_scan_checkbox = _G.CreateFrame("CheckButton", "_NPCScanBlockFlightScanCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
block_flight_scan_checkbox:SetPoint("TOPLEFT", mouseover_scan_checkbox, "BOTTOMLEFT", 0, -8)
block_flight_scan_checkbox.tooltipText = L.BLOCKFLIGHTSCAN_DESC

panel.block_flight_scan_checkbox = block_flight_scan_checkbox

local block_flight_scan_label = _G[block_flight_scan_checkbox:GetName() .. "Text"]
block_flight_scan_label:SetText(L.BLOCKFLIGHTSCAN)
block_flight_scan_checkbox:SetHitRectInsets(4, 4 - block_flight_scan_label:GetStringWidth(), 4, 4)

function block_flight_scan_checkbox.setFunc(is_enabled)
	private.SetBlockFlightScan(is_enabled == "1")
end

local alert_sound_dropdown = _G.CreateFrame("Frame", "_NPCScanConfigSoundDropdown", alert_options_panel, "UIDropDownMenuTemplate")
alert_sound_dropdown:SetPoint("TOPLEFT", block_flight_scan_checkbox, "BOTTOMLEFT", -12, -18)
alert_sound_dropdown:SetPoint("RIGHT", -12, 0)
alert_sound_dropdown:EnableMouse(true)
alert_sound_dropdown.tooltipText = L.CONFIG_ALERT_SOUND_DESC

alert_sound_dropdown:SetScript("OnEnter", panel.ControlOnEnter)
alert_sound_dropdown:SetScript("OnLeave", _G.GameTooltip_Hide)

_G.UIDropDownMenu_SetText(alert_sound_dropdown, L.CONFIG_ALERT_SOUND_DEFAULT)
_G.UIDropDownMenu_JustifyText(alert_sound_dropdown, "LEFT")


local alert_sound_dropdown_button = _G[alert_sound_dropdown:GetName() .. "Button"]
_G.UIDropDownMenu_SetAnchor(alert_sound_dropdown, 0, 0, "TOPLEFT", alert_sound_dropdown_button, "TOPRIGHT")

_G[alert_sound_dropdown:GetName() .. "Middle"]:SetPoint("RIGHT", -16, 0)

panel.alert_sound_dropdown = alert_sound_dropdown

do
	local function Entry_OnSelect(info_table, sound)
		private.Button.PlaySound(sound)
		private.SetAlertSound(sound)
	end


	local SORTED_GROUPS = { "A_E", "F_J", "K_O", "P_T", "U_Z", }
	local GROUPS = {}
	local DISPLAY_TO_GROUP_MAP = {}
	for index = 1, #SORTED_GROUPS do
		local group_key = SORTED_GROUPS[index]
		GROUPS[group_key] = {}
		DISPLAY_TO_GROUP_MAP[group_key:gsub("_", "-")] = group_key
	end


	local GROUPINGS = {
		a = GROUPS.A_E,
		b = GROUPS.A_E,
		c = GROUPS.A_E,
		d = GROUPS.A_E,
		e = GROUPS.A_E,
		f = GROUPS.F_J,
		g = GROUPS.F_J,
		h = GROUPS.F_J,
		i = GROUPS.F_J,
		j = GROUPS.F_J,
		k = GROUPS.K_O,
		l = GROUPS.K_O,
		m = GROUPS.K_O,
		n = GROUPS.K_O,
		o = GROUPS.K_O,
		p = GROUPS.P_T,
		q = GROUPS.P_T,
		r = GROUPS.P_T,
		s = GROUPS.P_T,
		t = GROUPS.P_T,
		u = GROUPS.U_Z,
		v = GROUPS.U_Z,
		w = GROUPS.U_Z,
		x = GROUPS.U_Z,
		y = GROUPS.U_Z,
		z = GROUPS.U_Z,
	}


	function alert_sound_dropdown:initialize(level)
		if not level then
			return
		end
		local current_sound = private.Options.AlertSound
		local info = _G.UIDropDownMenu_CreateInfo()

		if level == 1 then
			info.func = Entry_OnSelect
			info.text = L.CONFIG_ALERT_SOUND_DEFAULT
			info.checked = current_sound == nil
			_G.UIDropDownMenu_AddButton(info, level)

			info.text = L.CONFIG_ALERT_SOUND_CLASSIC
			info.arg1 = L.CONFIG_ALERT_SOUND_CLASSIC
			info.checked = current_sound == L.CONFIG_ALERT_SOUND_CLASSIC

			_G.UIDropDownMenu_AddButton(info, level)

			info.text = _G.MUTE
			info.arg1 = _G.MUTE
			info.checked = current_sound == _G.MUTE
			_G.UIDropDownMenu_AddButton(info, level)




			for group, data in pairs(GROUPS) do
				table.wipe(data)
			end

			local LSM = _G.LibStub("LibSharedMedia-3.0")
			local media_list = LSM:List(LSM.MediaType.SOUND)
			for index = 1, #media_list do
				local key = media_list[index]
				local grouping = GROUPINGS[key:sub(1, 1):lower()]

				if grouping then
					grouping[#grouping + 1] = key
				else
					info.text = key
					info.arg1 = key
					info.checked = current_sound == key
					_G.UIDropDownMenu_AddButton(info, level)
				end
			end
			info.func = nil

			for index = 1, #SORTED_GROUPS do
				info.text = SORTED_GROUPS[index]:gsub("_", "-")
				info.hasArrow = true
				info.notCheckable = true
				_G.UIDropDownMenu_AddButton(info, level)
			end
		else
			local group = GROUPS[DISPLAY_TO_GROUP_MAP[_G.UIDROPDOWNMENU_MENU_VALUE]]
			info.func = Entry_OnSelect

			for index = 1, #group do
				local key = group[index]
				info.text = key
				info.arg1 = key
				info.checked = current_sound == key
				_G.UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end -- do-block


local alert_sound_label = alert_sound_dropdown:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
alert_sound_label:SetPoint("BOTTOMLEFT", alert_sound_dropdown, "TOPLEFT", 16, 3)
alert_sound_label:SetText(L.CONFIG_ALERT_SOUND)


-------------------------------------------------------------------------------
-- Panel methods.
-------------------------------------------------------------------------------
function panel:ControlOnEnter()
	_G.GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
	_G.GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1)
end


-- Reverts to default options.
function panel:default()
	private.Synchronize() -- Resets all
end



_G.InterfaceOptions_AddCategory(panel)


-- Add stub panel to load tools UI
local _, _, _, tools_enabled = _G.GetAddOnInfo("_NPCScan.Tools")

if tools_enabled then
	local tools_panel = _G.CreateFrame("Frame")
	tools_panel.name = L.TOOLS_TITLE
	tools_panel.parent = panel.name
	tools_panel:Hide()
	tools_panel:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		_G.UIParentLoadAddOn("_NPCScan.Tools")
	end)

	private.ToolsPanel = tools_panel
	_G.InterfaceOptions_AddCategory(tools_panel)
end
