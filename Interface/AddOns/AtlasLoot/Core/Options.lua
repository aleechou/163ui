-- $Id: Options.lua 4262 2013-09-16 15:58:35Z arith $
local AtlasLoot = _G.AtlasLoot
--Invoke libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

local options, moduleOptions = nil, {}
local getOptions

do
 	local function getOpt(info)
		return AtlasLoot.db.profile[info[#info]]
	end
	
	local function setOpt(info, value)
		AtlasLoot.db.profile[info[#info]] = value
		return AtlasLoot.db.profile[info[#info]]
	end
	
	local function resetButton(info)
		AtlasLoot:Reset(info[#info])
	end

	function getOptions()
		if not options then
			options = {
				type = "group",
				args = {
					general = {
						type = "group",
						inline = true,
						name = "",
						args = {
							all = {
								type = "group",
								inline = true,
								name = "",
								order = 10,
								args = {
									--[[LoadAllLoDStartup = {
										type = "toggle",
										name = AL["Load Loot Modules at Startup"],
										--desc = ,
										order = 10,
										get = getOpt,
										set = setOpt,
										width = "full",
									},]]
									HideMiniMapButton = {
										type = "toggle",
										name = AL["Toggle Minimap Button"],
										desc = AL["Toggles the display of the minimap icon"],
										order = 20,
										get = function() return not AtlasLootLoaderDB.MiniMapButton.hide end,
										set = AtlasLoot.MiniMapButtonHideShow,
										width = "full",
									},
									
								},
							},
							itemButton = {						
								type = "group",
								inline = true,
								name = AL["Item Buttons"],
								order = 30,
								args = {
									ItemIDs = {
										type = "toggle",
										name = AL["Show itemIDs"],
										desc = AL["Show itemIDs at all times"],
										order = 10,
										get = getOpt,
										set = setOpt,
									},
									DropRate = {
										type = "toggle",
										name = AL["Show Droprates"],
										--desc = ,
										order = 20,
										get = getOpt,
										set = setOpt,
									},
									EquipCompare = {
										type = "toggle",
										name = AL["Comparison Tooltips"],
										desc = AL["Show Comparison Tooltips"],
										order = 30,
										get = getOpt,
										set = AtlasLoot.OptionsComparisonTT,
									},
									UseGameTooltip = {
										type = "toggle",
										name = AL["Use GameTooltip"],
										desc = AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"],
										order = 40,
										get = getOpt,
										set = function(info, value)
											setOpt(info, value)
											AtlasLoot:SetupTooltip()
											return value
										end,
									},
									ShowBossTooltip = {
										type = "toggle",
										name = AL["Show Boss Tooltip"],
										desc = AL["Show wishlist items in bosses tooltip"],
										order = 45,
										get = getOpt,
										set = setOpt,
									},
									ShowBonusRollInfoInTT = {
										type = "toggle",
										name = AL["Show BonusRoll info"],
										desc = AL["Shows if a item is available with bonus roll or raid finder loot."],
										order = 46,
										get = getOpt,
										set = setOpt,
									},
									ShowPriceAndDesc = {
										type = "toggle",
										name = AL["Show price and slot if possible"],
										--desc = ,
										order = 50,
										get = getOpt,
										set = setOpt,
										width = "full",
									},
									EnableMouseOverDesc = {
										type = "toggle",
										name = AL["Enable mouse on item descriptions"],
										--desc = ,
										order = 60,
										get = getOpt,
										set = setOpt,
										width = "full",
									},
									CurrentUpgradeLvl = {
										type = "range",
										name = AL["Upgrade Level:"],
										--desc = ,
										min = 0, max = 2, bigStep = 1,
										get = getOpt,
										set = function(info, value)
											setOpt(info, value)
											if AtlasLoot.RefreshLootPage then AtlasLoot:RefreshLootPage() end
										end,
										order = 70,
										width = "full",
									},
								},
							},
							
							lootTable = {						
								type = "group",
								inline = true,
								name = AL["Loot Table"],
								order = 30,
								args = {
									--[[
									Opaque = {
										type = "toggle",
										name = AL["Opaque"],
										desc = AL["Make Loot Table Opaque"],
										order = 10,
										get = getOpt,
										set = setOpt,
									},
									]]
									CraftingLink = {
										type = "select",
										name = AL["Treat Crafted Items:"],
										--desc = ,
										values = { AL["As Crafting Spells"], AL["As Items"] },
										order = 20,
										get = getOpt,
										set = setOpt,
									},
								},
							},


							defaultFrameScale = {
								type = "group",
								inline = true,
								name = AL["Default Frame"],
								order = 40,
								args = {
									LootBrowserScale = {
										type = "range",
										name = AL["Scale:"],
										--desc = ,
										min = 0.50, max = 1.5, bigStep = 0.01,
										get = getOpt,
										set = function(info, value)
											setOpt(info, value)
											if AtlasLoot.DefaultFrame_RefreshScale then AtlasLoot:DefaultFrame_RefreshScale() end
										end,
										order = 1,
										width = "full",
									},
									LootBrowserAlpha = {
										type = "range",
										name = AL["Alpha:"],
										--desc = ,
										min = 0.25, max = 1, bigStep = 0.01,
										get = getOpt,
										set = function(info, value)
											setOpt(info, value)
											if AtlasLoot.DefaultFrame_RefreshAlpha then AtlasLoot:DefaultFrame_RefreshAlpha() end
										end,
										order = 2,
										width = "full",
									},
									--[[
									LootBrowserAlphaOnLeave = {
										type = "toggle",
										name = AL["Only change alpha on leave frame"],
										--desc = ,
										order = 3,
										get = getOpt,
										set = setOpt,
										width = "full",
									},
									]]--
								},
							},

							resetButtons = {
								type = "group",
								inline = true,
								name = "",
								order = 100,
								args = {
									--[[wishlist = {
										type = "execute",
										name = AL["Reset Wishlist"],
										--desc = ,
										func = resetButton,
										order = 1,
									},]]
									frames = {
										type = "execute",
										name = AL["Reset Frames"],
										--desc = ,
										func = resetButton,
										order = 2,
									},
									quicklooks = {
										type = "execute",
										name = AL["Reset Quicklooks"],
										--desc = ,
										func = resetButton,
										order = 3,
									},
								},
							},
						},
					},	
					
					Help = {
						type = "group",
						name = AL["Help"],
						order = 600,
						childGroups = "tab",
						args = {
							websiteLink = {
								type = "description",
								name = GREY..AL["For further help, see our website and forums: "]..GREEN.."http://www.atlasloot.net",
								order = 500,
							},
						},
					},	
				},

			}
			-- Create help
			for k,v in ipairs(AtlasLoot.AddonInfo.help) do
				options.args.Help.args[tostring(k)] = {
					type = "description",
					name = string.format("%s%s\n%s%s", ORANGE, v[1] or "?", WHITE, v[2] or "?"),
					order = k,
				}
			end
			AtlasLoot.AddonInfo.help = nil
		end
		for k,v in pairs(moduleOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
		return options

	end

end

--[[
-> AtlasLoot:OptionsInitialize()
]]
function AtlasLoot:ReplaceOptions()
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("AtlasLoot", getOptions)

	self:RegisterModuleOptions("Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db), AL["Profiles"])
	self.optFrames.Help = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AtlasLoot", AL["Help"], "AtlasLoot", "Help")
end

--- Adds a OptionsSubCat 
-- @param name the name of the option
-- @param optFunc the funtion that returns the options table
-- @param displayName the displayed options name
-- @usage AtlasLoot:RegisterModuleOptions(name, optFunc, displayName)
function AtlasLoot:RegisterModuleOptions(name, optFunc, displayName)
	if not self.optFrames then self:OptionsInitialize() end
	if moduleOptions[name] then self:RefreshModuleOptions() return end
	moduleOptions[name] = optFunc
	self.optFrames[name] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AtlasLoot", displayName or name, "AtlasLoot", name)
end

--
function AtlasLoot:OptionsComparisonTT()
	if(AtlasLoot.db.profile.EquipCompare) then
		AtlasLoot.db.profile.EquipCompare = false;
		if (EquipCompare_UnregisterTooltip) then
			EquipCompare_UnregisterTooltip(AtlasLootTooltip);
		end
	else
		AtlasLoot.db.profile.EquipCompare = true;
		if (EquipCompare_RegisterTooltip) then
			EquipCompare_RegisterTooltip(AtlasLootTooltip);
		end
	end
end

--- Shows the AtlasLoot Options
function AtlasLoot:OptionsToggle()
	InterfaceOptionsFrame_OpenToCategory("AtlasLoot")
	InterfaceOptionsFrame_OpenToCategory("AtlasLoot") -- Silly fix. Call it twice to force the expected category to be opened.
end
-- Hides the AtlasLoot Panel
function AtlasLoot:OptionsHidePanel()
	if AtlasLoot.db.profile.HidePanel then
		AtlasLoot.db.profile.HidePanel = false;
		AtlasLootPanel:Show()
	else
		AtlasLoot.db.profile.HidePanel = true;
		AtlasLootPanel:Hide()
	end
end
