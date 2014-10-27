--[=[ This addon provides options for all modules.
Options are preferrably defined as "BetterOptions" tables, which functionally resemble AceOptionsTables but are much more concise.

The point of this abstraction layer is that I (Xuerian) wanted to use AceDB/AceConfig to present a more standard configuration dialog to users. I am, however, not satisfied with the conventions and limitations of it, so this is a attempt to provide both a more concise format (BetterOptions), and a more featureful intermediate options format (Finalize(...)) to support it. 


Methods:
Finalize(module_data, option_table)
- Compiles a AceOptionTable with extra features to a validating AceOptionTable by migrating extra data/metadata into option_metadata[current_option_table] so AceConfig doesn't brit a shick.
> module_data expects a table where t.name == "ModuleName" and t.addon = AddonTable
> option_table expects a "BetterOptions" option table

BetterOptions.Compile(better_option_table)
- Compiles BetterOptions tables to intermediate option tables which must be provided
to either a supporting option system or Finalize() for use as a validating AceOptionsTable
> better_option_table expects a "BetterOptions" option table
Start by defining your module options here in addon:OnEnable below other module options with the call XLootOptions:RegisterOptions("ModuleName", table), inside a if XLoot:GetModule(ModuleName, true) block.

XLootOptions:RegisterOptions(module_data, better_option_table)
- Registers a BetterOptions table with XLootOptions
> module_data and better_option_table follow BetterOptions.Compile and Finalize()

XLootOptions:RegisterAceOptionTable("ModuleName", ace_option_table)
- Registers a "normal" ace option table with no additional steps.
- Must provide get and set methods at least in the root group(s), as default get and set rely on Finalize()


Features/Finalize:
- Fill missing localization from XLootOptions.L[module_data.name][key|key_desc]
- Generate .values from {{ "key", "value" }, ...} .item tables and set them appropriately
- Get/Set from db key/subkey instead of key via .subtable[, .subkey]
- Propagate .defaults to child nodes
- Default type "toggle"
- "alpha" and "scale" types with automatic localization
- .requires = key and .requires_inverse = key 

Features/BetterOptions:
- Nested tables with implied ordering and table values:
-- Basic structure: { "key", "type"[, arg1[, ...]] [, key = value[, ...]] }
-- Examples:
--  { "key", "toggle" }
--  { "key", option = "blah" }  ->  { "key", "toggle", option = "blah" }
--  { "key", "group", inline }  ->  key = { type = "group", inline = true }
--  { "key", "execute", func }  ->  key = { type = "execute", func = func }
--  { "key", "select", items }
--  { "key", "color", hasAlpha }
--  { "key", "range", min, max, step, softMin, softMax, bigStep }
-- Automatic types:
--  Entry is just a "key":  "toggle"
--   "key"
--  t[2] is unset:  "toggle"
--   { "key" }
--  t[2] is a table:  "select"
--   { "key", {k, v} }
Please note that inline and non-inline groups do not mix well for AceConfigDialog. -]=]

-- Create module
local addon, L = XLoot:NewModule("Options")

-- Global
_G.XLootOptions = addon

-- Locals
local print = print

local function trigger(target, method, ...)
	local func = target[method]
	if type(func) == 'function' then
		func(target, ...)
	end
end

local function sizeof(t)
	local i = 0
	for k,v in pairs(t) do
		i=i+1
	end
	return i
end

-- Provide throttled updates
local update_throttle, elapsed = CreateFrame("Frame"), 0
update_throttle:Hide()
update_throttle:SetScript("OnUpdate", function(self, delta)
	if elapsed > .1 then
		XLoot:ApplyOptions()
		elapsed = 0
		self:Hide()
	else
		elapsed = elapsed + delta
	end
end)

-------------------------------------------------------------------------------
-- Module init

function addon:OnEnable() -- Construct addon option tables here

	local option_metadata = {} -- Stores metadata for option entries outside of library-specific compiled option structure
	addon.option_metadata = option_metadata -- Until resulting AceOptionsTable can have .values upated, this is the only way to store a new .items table

	-------------------------------------------------------------------------------
	-- General config methods

	-- Find module options and requested key from AceConfigDialog info table
	-- Also return meta table for option
	local function path(info)
		local meta = option_metadata[info.option]
		local db = meta.module_data.addon.db.profile
		return meta.subtable and db[meta.subtable] or db, meta.subkey or info[#info], meta
	end

	-- Generic option getter
	local function get(info)
		local db, k, meta = path(info)
		if info.option.type == "color" then
			return unpack(db[k])
		elseif info.option.type == "select" and meta.items then
			for i,v in ipairs(meta.items) do
				if db[k] == v[1] then
					return i
				end
			end
		else
			return db[k]
		end
	end

	-- Generic option setter
	local function set(info, v, v2, v3, v4, ...)
		update_throttle:Show()
		local db, k, meta = path(info)
		if info.option.type == "color" then
			db[k][1] = v
			db[k][2] = v2
			db[k][3] = v3
			db[k][4] = v4
		elseif info.option.type == "select" and meta.items then
			db[k] = meta.items[v][1]
		else
			db[k] = v
		end
		if meta.module_data.OnChanged then
			meta.module_data.OnChanged(k, v, v2, v3, v4, ...)
		end
	end

	-- Anchor toggles
	local function set_anchor(...)
		set(...)
		local db, k, meta = path(...)
		trigger(meta.module_data.addon, "UpdateAnchors")
	end

	-- Select value generator
	local function values_from_items(info)
		local db, k, meta = path(info)
		local values = meta.values
		wipe(values)
		for i,v in ipairs(meta.items) do
			values[i] = v[2]
		end
		return values
	end

	-- Dependencies
	-- TODO: Recursive dependencies
	local function requires(info)
		local db, k, meta = path(info)
		return ((meta.requires and (not db[meta.requires]) or false)
				or (meta.requires_inverse and db[meta.requires_inverse] or false))
	end

	-------------------------------------------------------------------------------
	-- Streamlined options tables

	local BetterOptions = {}
	local table_remove = table.remove

	function BetterOptions.Compile(set)
		for i,v in ipairs(set) do
			local t, key = BetterOptions.any(v)
			t.order = i
			set[key] = t
			set[i] = nil
		end
		return set
	end

	local BetterOptionsTypes = {}
	function BetterOptions.any(t)
		-- Simple
		if type(t) == 'string' then
			t = { t }
		end

		-- Shift required elements
		local key = table_remove(t, 1)
		t.type = table_remove(t, 1)
		-- Infer toggle by default
		if not t.type then
			t.type = "toggle"
		-- Infer select from table
		elseif type(t.type) == "table" then
			t.items, t.type = t.type, "select"
		end

		-- Handle specific option types
		if BetterOptionsTypes[t.type] then
			BetterOptionsTypes[t.type](t)
		end

		-- Cleanup
		for i,v in ipairs(t) do
			t[i] = nil
		end

		return t, key
	end

	function BetterOptionsTypes.group(t)
		t.args = t.args or t[1]
		if t.inline == nil then
			t.inline = (t[2] ~= nil and t[2] or true)
		end

		if t.args then
			BetterOptions.Compile(t.args)
		end
	end

	function BetterOptionsTypes.select(t)
		t.items = t.items or t[1]
	end

	function BetterOptionsTypes.alpha(t)
		t.min = 0.0
		t.max = 1.0
		t.step = 0.1
		t.subtable = t.subtable or t[1]
		t.subkey = t.subkey or t[2]
	end

	function BetterOptionsTypes.scale(t)
		t.min = 0.1
		t.max = 2.0
		t.step = 0.1
		t.subtable = t.subtable or t[1]
		t.subkey = t.subkey or t[2]
	end

	function BetterOptionsTypes.color(t)
		t.hasAlpha = t.hasAlpha or t[1]
	end

	function BetterOptionsTypes.range(t)
		t.min = t.max or t[1]
		t.max = t.max or t[2]
		t.step = t.step or t[3]
		t.softMin = t.softMin or t[4]
		t.softMax = t.softMax or t[5]
		t.bigStep = t.bigStep or t[6]
	end

	function BetterOptionsTypes.execute(t)
		t.func = t.func or t[1]
	end

	function BetterOptionsTypes.description(t)
		t.width = t.width or "full"
		t.fontSize = t.fontSize or "medium"
	end

	addon.BetterOptions = BetterOptions
	addon.BetterOptionsTypes = BetterOptionsTypes

	-------------------------------------------------------------------------------
	-- AceOptionsTable extension

	-- Flesh out AceOptionsTables for a given module
	-- Add features not directly supported
	local function Finalize(module_data, opts, key)
		local meta = option_metadata[opts]
		if not meta then
			meta = { module_data = module_data }
			option_metadata[opts] = meta
		end
		-- First call
		if not key then
			for k,v in pairs(opts) do
				Finalize(module_data, v, k)
			end
		-- Recursion
		else
			-- Automatically localized selects
			if opts.type == "alpha" or opts.type == "scale" then
				opts.name = opts.name or L[module_data.name][key] or L[key] or L[opts.type]
				opts.type = "range"
			end

			-- Fill in localized name/description
			opts.name = opts.name or L[module_data.name][key] or L[key] or key
			opts.desc = opts.desc or L[module_data.name][key.."_desc"]

			meta.subtable, meta.subkey = opts.subtable, opts.subkey
			opts.subtable, opts.subkey = nil, nil

			-- Dependencies
			if opts.requires or opts.requires_inverse then
				meta.requires, meta.requires_inverse = opts.requires, opts.requires_inverse
				opts.disabled = requires
				opts.requires, opts.requires_inverse = nil, nil
			end

			-- Sorted select
			-- TODO: Set metatable on option table to update meta.items?
			if opts.type == "select" and opts.items then
				opts.values = values_from_items
				meta.values = {}
				meta.items = opts.items
				opts.items = nil
			end

			-- Traverse subgroup
			if opts.args then
				-- Apply subgroup defaults
				if opts.defaults then
					for argk, argv in pairs(opts.args) do
						for defk, defv in pairs(opts.defaults) do
							if argv[defk] == nil then
								argv[defk] = defv
							end
						end
					end
					opts.defaults = nil
				end
				-- Finalize subgroups
				for k,v in pairs(opts.args) do
					Finalize(module_data, v, k)
				end

			-- Default type "toggle"
			elseif not opts.type then
				opts.type = "toggle"
			end
		end
		return opts
	end

	-------------------------------------------------------------------------------
	-- Module config registration

	-- Global config header
	self.config = {
		type = "group",
		name = "XLoot",
		get = get,
		set = set,
		childGroups = "tab"
	}

	local function OnCoreChanged(k, v)
		if k == 'skin' then
			XLoot:ApplyOptions()
		end
	end

	local modules, skins = {}, {}
	local options = Finalize({ name = "Core", addon =  XLoot, OnChanged = OnCoreChanged }, BetterOptions.Compile({
		{ "details", "description" },
		{ "skin", "select", values = function()
			wipe(skins)
			for k,v in pairs(XLoot.Skin.skins) do
				skins[k] = v.name
			end
			return skins
		end},
		{ "skin_anchors", "toggle" },
		-- { "module_header", "header" },
	}))
	self.config.args = options

	function addon:RegisterAceOptionTable(module_name, option_table)
		-- Insert into options
		options[module_name] = {
			type = "group",
			name = L[module_name].panel_title,
			desc = L[module_name].panel_desc,
			args = option_table,
			order = sizeof(options) + 1,
			inline = false
		}
	end

	function addon:RegisterOptions(module_data, option_table)
		-- Have to finalize here because Finalize needs to know what module we're in
		-- There's probably a better way to do this.
		Finalize(module_data, BetterOptions.Compile(option_table))
		self:RegisterAceOptionTable(module_data.name, option_table)
	end

	-------------------------------------------------------------------------------
	-- Generic select values

	local item_qualities = {}
	do
		for i=0, #ITEM_QUALITY_COLORS do
			local hex = select(4, GetItemQualityColor(i))
			table.insert(item_qualities, { i, ("|c%s%s"):format(hex, _G["ITEM_QUALITY"..tostring(i).."_DESC"]) })
		end
	end 

	local directions = {
		{ "up", L.up },
		{ "down", L.down }
	}

	-- Shared Media
	local LSM = LibStub and LibStub("LibSharedMedia-3.0",1)

	local fonts
	if LSM then
		fonts = {}
		for name, ttf in pairs(LSM:HashTable("font")) do
			table.insert(fonts, {ttf, name})
		end
	else
		fonts = {
			{ STANDARD_TEXT_FONT, "Friz Quadrata TT" },
			{ "Fonts\MORPHEUS.ttf", "Morpheus" },
			{ "Fonts\ARIALN.ttf", "Arial Narrow" },
			{ "Fonts\SKURRI.ttf", "Skurri" },
		}
	end

	local font_flags = {
		{ "", "NONE" },
		{ "OUTLINE", "OUTLINE" },
		{ "THICKOUTLINE", "THICKOUTLINE" },
		{ "MONOCHROME", "MONOCHROME" }
	}

	-------------------------------------------------------------------------------
	-- Module configs

	-- XLoot Frame
	if XLoot:GetModule("Frame", true) then
		local when_group = {
			{ "never", L.when_never },
			{ "solo", L.when_solo },
			{ "always", L.when_always },
			{ "grouped", L.when_grouped }
		}

		local function OnChanged(k, v)
			if not XLootFrame.built then
				XLootFrame:BuildFrame()
			end
			XLootFrame:UpdateAppearance()
			XLootFrame:ParseAutolootList()
		end

 		addon:RegisterOptions({ name = "Frame", addon =  XLootFrame.addon, OnChanged = OnChanged }, {
			{ "frame_options", "group", {
				{ "frame_width_automatic", "toggle", width = "double" },
				{ "old_close_button", "toggle" },
				{ "frame_width", "range", 75, 300, 5, requires_inverse = "frame_width_automatic" },
				{ "frame_scale", "scale" },
				{ "frame_alpha", "alpha" },
				{ "frame_snap", "toggle" },
				{ "frame_snap_offset_x", "range", -2000, 2000, 1, -250, 250, 10, requires = "frame_snap" },
				{ "frame_snap_offset_y", "range", -2000, 2000, 1, -250, 250, 10, requires = "frame_snap" },
				{ "frame_draggable" },
				{ "frame_grow_upwards" },
			}},
			{ "slot_options", "group", {
				{ "loot_texts_info", "toggle", width = "double" },
				{ "loot_texts_bind", "toggle" },
				{ "loot_highlight", "toggle", width = "double", },
				{ "loot_collapse", "toggle" },
				{ "loot_texts_lock", "toggle", width = "double" },
				{ "loot_alpha", "alpha" },
				{ "loot_icon_size", "range", 16, 64, 1, name = L.icon_size },
				{ "loot_row_height", "range", 14, 64, 1 },
				--{ "loot_slot_padding", "range", }
			}},
			{ "link_button", "group", {
				{ "linkall_show", "select", when_group },
				{ "linkall_threshold", "select", item_qualities },
				{ "linkall_channel", "select", {
					{ "SAY", CHAT_MSG_SAY },
					{ "PARTY", CHAT_MSG_PARTY },
					{ "GUILD", CHAT_MSG_GUILD },
					{ "OFFICER", CHAT_MSG_OFFICER },
					{ "RAID", CHAT_MSG_RAID },
					{ "RAID_WARNING", RAID_WARNING }
				}}
			}},
			{ "autolooting", "group", {
				{ "autolooting_text", "description" },
				{ "autoloot_currency", "select", when_group, subtable = "autoloots", subkey = "currency" },
				{ "autoloot_quest", "select", when_group, subtable = "autoloots", subkey = "quest" },
				{ "autoloot_tradegoods", "select", when_group, subtable = "autoloots", subkey = "tradegoods" },
				{ "autoloot_all", "select", when_group, subtable = "autoloots", subkey = "all" },
				{ "autolooting_list", "description" },
				{ "autoloot_list", "select", when_group, subtable = "autoloots", subkey = "list" },
				{ "autoloot_item_list", "input", width = "double" },
				{ "autolooting_details", "description" },
			}},
			{ "font", "group", {
				{ "font", fonts },
				{ "font_flag", font_flags },
				{ "font_sizes", "header" },
				{ "font_size_loot", "range", 4, 26, 1 },
				{ "font_size_info", "range", 4, 26, 1 },
				{ "font_size_quantity", "range", 4, 26, 1 },
				{ "font_size_bottombuttons", "range", 4, 26, 1 },
			}},
			{ "colors", "group", {
				{ "quality_color_frame", "toggle", width = "full" },
				{ "quality_color_slot", "toggle", width = "full" },
				{ "frame_color_border", "color", width = "double", requires_inverse = "quality_color_frame" },
				{ "loot_color_border", "color", requires_inverse = "quality_color_slot" },
				{ "frame_color_backdrop", "color", true, width = "double" },
				{ "loot_color_backdrop", "color", true },
				{ "frame_color_gradient", "color", true, width = "double" },
				{ "loot_color_gradient", "color", true },
				{ "loot_color_info", "color", width = "full", requires = "loot_texts_info" }
			}}
		})
	end

	-- XLoot Group
	if XLoot:GetModule("Group", true) then
		addon:RegisterOptions({ name = "Group", addon =  XLootGroup }, {
			{ "anchors", "group", {
				{ "roll_anchor_visible", "toggle", subtable = "roll_anchor", subkey = "visible", set = set_anchor },
				{ "alert_anchor_visible", "toggle", subtable = "alert_anchor", subkey = "visible", set = set_anchor, width = "double" },
			}},
			{ "other_frames", "group", {
				"hook_bonus",
				{ "bonus_skin", requires = "hook_bonus", width = "double" },
				"hook_alert",
				{ "alert_skin", requires = "hook_alert", width = "double" },
			}},
			{ "rolls", "group", {
				{ "roll_direction", "select", directions, name = L.growth_direction, subtable = "roll_anchor", subkey = "direction" },
				{ "text_outline", "toggle" },
				{ "text_time", "toggle" },
				{ "roll_scale", "scale", "roll_anchor", "scale" },
				{ "roll_width", "range", 150, 700, 1, 150, 400, 10, name = L.width },
				{ "roll_button_size", "range", 16, 48, 1 },
			}},
			{ "extra_info", "group", {
				{ "equip_prefix", "toggle" },
				{ "prefix_equippable", "input" },
				{ "prefix_upgrade", "input" },
				{ "show_undecided", "toggle" },
				{ "role_icon", "toggle" },
				{ "win_icon", "toggle" },
			}},
			{ "roll_tracking", "group", {
				{ "track_all", "toggle", width = "double" },
				{ "track_player_roll", "toggle", requires_inverse = "track_all" },
				{ "track_by_threshold", "toggle", requires_inverse = "track_all", width = "double" },
				{ "track_threshold", "select", item_qualities, requires = "track_by_threshold", name = L.minimum_quality },
				{ "expiration", "header" },
				{ "expire_won", "range", 5, 30, 1 },
				{ "expire_lost", "range", 5, 30, 1 },
			}},
			{ "alerts", "group", {
					{ "alert_scale", "scale" },
					{ "alert_offset", "range", 0.1, 10.0, 0.1 },
					{ "alert_alpha", "alpha" },
					{ "alert_direction", "select", directions, subtable = "alert_anchor", subkey = "direction", name = L.growth_direction },
				},
				defaults = { requires = "hook_alert" }
			}
		})
	end

	-- XLoot Monitor
	if XLoot:GetModule("Monitor", true) then
		addon:RegisterOptions({ name = "Monitor", addon =  XLootMonitor.addon }, {
			{ "anchor", "group", {
				{ "visible", "toggle", set = set_anchor },
				{ "direction", "select", directions, name = L.growth_direction },
				{ "scale", "scale" }
			}, defaults = { subtable = "anchor" } },
			{ "thresholds", "group", {
				{ "threshold_own", "select", item_qualities, name = L.items_own },
				{ "threshold_other", "select", item_qualities, name = L.items_others },
			}},
			{ "filters", "group", {
				{ "show_coin", name = MONEY },
				{ "show_currency", name = CURRENCY },
				"show_crafted"
			}, name = FILTERS },
			{ "fading", "group", {
				{ "fade_own", "range", 1, 30, 1, name = L.items_own },
				{ "fade_other", "range", 1, 30, 1, name = L.items_others }
			}},
			{ "details", "group", {
				{ "show_totals", "toggle", width = "double" }
			}},
			{ "font", "group", {
				{ "font", fonts },
				{ "font_flags", font_flags },
				{ "font_sizes", "header" },
				{ "font_size_loot", "range", 4, 26, 1 },
				{ "font_size_quantity", "range", 4, 26, 1 },
			}},
		})
	end

	-- XLoot Master
	if XLoot:GetModule("Master", true) then
		-- Item quality dropdown generator
		local item_qualities = {}
		do
			for i, v in ipairs(UnitPopupMenus["LOOT_THRESHOLD"]) do -- we only care for the qualities available as ML filters
				local quality = tonumber(strmatch(v,"%d+"))
				if quality then
					local hex = select(4, GetItemQualityColor(quality))
					item_qualities[i] = { quality, ('|c%s%s'):format(hex, _G[v]) }
				end
			end
		end
		table.insert(item_qualities, 1, { -1, ALWAYS })
		table.insert(item_qualities, { 10, NEVER })
		local channels = {
				{ 'AUTO', L.desc_channel_auto },
				{ 'SAY', CHAT_MSG_SAY },
				{ 'PARTY', CHAT_MSG_PARTY },
				{ 'RAID', CHAT_MSG_RAID },
				{ 'INSTANCE_CHAT', INSTANCE_CHAT},
				{ 'RAID_WARNING', RAID_WARNING },
				{ 'OFFICER', CHAT_MSG_OFFICER },
				{ 'NONE', NONE },
		}
		addon:RegisterOptions({ name = "Master", addon =  XLootMaster }, {
			{ "confirm_qualitythreshold", "select", item_qualities },
			{ "specialrecipients", "group", {
				{ "menu_self", "toggle" },
				{ "menu_disenchant", "toggle" },
				{ "menu_disenchanters", "input", requires="menu_disenchant" },
				{ "menu_bank", "toggle" },
				{ "menu_bankers", "input", requires="menu_bank" },
			}},
			{ "raidroll", "group", {
				{ "menu_roll", "toggle" },
			}},
			{ "awardannounce", "group", {
				{ "award_qualitythreshold", "select", item_qualities },
				{ "award_channel", "select", channels },
				{ "award_guildannounce", "toggle" },
				{ "award_special", "toggle" },
			}},
		})
	end

--[=[ 	-- Generate reset staticpopup
	if not StaticPopupDialogs['XLOOT_RESETPROFILE'] then
		StaticPopupDialogs['XLOOT_RESETPROFILE'] = {
			preferredIndex = 3,
			text = L.confirm_reset_profile,
			button1 = ACCEPT,
			button2 = CANCEL,
			OnAccept = function() addon:ResetProfile() end,
			exclusive = true,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
	end--]=] 
end

function addon:OnInitialize()
	
end

-------------------------------------------------------------------------------
-- Panel methods

local function PanelDefault(self)
	-- StaticPopup_Show("XLOOT_RESETPROFILE")
	addon:ResetProfile()
end

local function PanelOkay(self)
end

local function PanelCancel(self)
	-- Restore old options?
end

function addon:ResetProfile()
	XLoot.db:ResetProfile()
	LibStub("AceConfigRegistry-3.0"):NotifyChange("XLoot")
end

local init
local AceConfigDialog, AceConfigRegistry = LibStub("AceConfigDialog-3.0"), LibStub("AceConfigRegistry-3.0")
function addon:OpenPanel(module)
	-- One-time init
	if not init then
		init = true
		-- Remove bootstrap
		for i,frame in ipairs(INTERFACEOPTIONS_ADDONCATEGORIES) do
			if frame.name == "XLoot" then
				table.remove(INTERFACEOPTIONS_ADDONCATEGORIES, i)
			end
		end
		-- Generate new panel
		AceConfigRegistry:RegisterOptionsTable("XLoot", self.config)
		local panel = AceConfigDialog:AddToBlizOptions("XLoot")
		XLoot.option_panel = panel
		panel.default = PanelDefault
		-- panel.okay = PanelOkay
		-- panel.cancel = PanelCancel

 		-- Create profile panel
		AceConfigRegistry:RegisterOptionsTable("XLootProfile", LibStub("AceDBOptions-3.0"):GetOptionsTable(XLoot.db))
		XLoot.profile_panel = AceConfigDialog:AddToBlizOptions("XLootProfile", L.profile, "XLoot")
		XLoot.profile_panel.default = PanelDefault
		-- Force list to expand
		InterfaceAddOnsList_Update()
	end
	-- Open panel
	InterfaceOptionsFrame_OpenToCategory(XLoot.option_panel)
end


