-- $Id: QuickLooks.lua 4201 2013-05-05 16:05:37Z lag123 $
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local ATLASLOOT_MAX_QUICKLOOKS = 10

local getOptions
do
 	local function getOpt(info)
		return AtlasLoot.db.profile[info[#info]]
	end
	
	local function setOpt(info, value)
		AtlasLoot.db.profile[info[#info]] = value
		return AtlasLoot.db.profile[info[#info]]
	end
	
	local function addQuickLook(num)
		local retTab = {
			curLootPage = {
				type = "description",
				name = "",
				order = 10,
			},
			lock = {
				type = "toggle",
				name = AL["Lock"],
				desc = "",
				get = function(info)
					return AtlasLoot.db.profile.QuickLooks[num].locked
				end,
				set = function(info, value)
					AtlasLoot.db.profile.QuickLooks[num].locked = value
					return AtlasLoot.db.profile.QuickLooks[num].locked
				end,
				order = 20,
			},
			qlName = {
				type = "input",
				name = AL["QuickLook name:"],
				desc = format("Replace 'QuickLook %d' with a new name.", num),
				order = 30,
				get = function(info)
					return AtlasLoot.db.profile.QuickLooks[num].customName
				end,
				set = function(info, value)
					if value:trim() == "" then
						AtlasLoot.db.profile.QuickLooks[num].customName = nil
					else
						AtlasLoot.db.profile.QuickLooks[num].customName = value
					end
					AtlasLoot:RefreshAtlasLootPanel()
					return AtlasLoot.db.profile.QuickLooks[num].customName
				end,
			},
			qlNameBoss = {
				type = "toggle",
				name = AL["Use Boss name"],
				desc = "",
				get = function(info)
					return AtlasLoot.db.profile.QuickLooks[num].useBossName
				end,
				set = function(info, value)
					AtlasLoot.db.profile.QuickLooks[num].useBossName = value
					AtlasLoot:RefreshAtlasLootPanel()
					return AtlasLoot.db.profile.QuickLooks[num].useBossName
				end,
				order = 40,
			},
			qlNameInstance = {
				type = "toggle",
				name = AL["Use Instance name"],
				desc = "",
				get = function(info)
					return AtlasLoot.db.profile.QuickLooks[num].useInstanceName
				end,
				set = function(info, value)
					AtlasLoot.db.profile.QuickLooks[num].useInstanceName = value
					AtlasLoot:RefreshAtlasLootPanel()
					return AtlasLoot.db.profile.QuickLooks[num].useInstanceName
				end,
				order = 50,
			},
			
			delete = {
				type = "execute",
				name = AL["Delete"],
				order = 60,
				--desc = ,
				func = function() 
					AtlasLoot.db.profile.QuickLooks[num].lootPage = nil
					AtlasLoot:RefreshAtlasLootPanel()
				end,
			},
		}
		
		if AtlasLoot.db.profile.QuickLooks[num].lootPage then
			retTab.curLootPage.name = "|cff0070dd"..AtlasLoot:GetQuickLookName(num, true)
		else
			retTab.curLootPage.name = "|cffff0000"..AL["unused"]
		end
		return retTab
	end
	
	local options
	function getOptions()
		if not options then
			options = {
				type = "group",
				name = "QuickLook",
				order = 600,
				--childGroups = "tab",
				args = {
					toggle = {
						type = "toggle",
						name = AL["Enable"],
						get = AtlasLoot.GetEnableQuickLook,
						set = function(info, v)
							AtlasLoot:SetEnableQuickLook(v)
						end,
						order = 10,
						width = "full",
					},
					ShowUnusedQuickLooks = {
						type = "toggle",
						name = AL["Show unused QuickLooks in the Panel"],
						desc = AL["Shows unused QuickLooks as grey buttons in the AtlasLoot Panel"],
						get = getOpt,
						set = function(info, v)
							setOpt(info, v)
							AtlasLoot:RefreshAtlasLootPanel()
						end,
						order = 20,
						width = "full",
					},
					NumQuickLooks = {
						type = "range",
						name = AL["Number of QuickLooks:"],
						--desc = ,
						min = 1, max = ATLASLOOT_MAX_QUICKLOOKS, bigStep = 1,
						get = getOpt,
						set = function(info, v) 
							setOpt(info, v)
							if AtlasLoot.db.profile.ShowUnusedQuickLooks then
								AtlasLoot:RefreshAtlasLootPanel()
							end
						end,
						order = 30,
					},
					Options = {
						type = "group",
						name = AL["QuickLooks"],
						args = {
							toggle = {
								type = "toggle",
								name = AL["Lock"],
								get = AtlasLoot.GetEnableQuickLook,
								set = function(info, v)
									AtlasLoot:SetEnableQuickLook(v)
								end,
								order = 10,
								width = "full",
							},
						},
						order = 30,
					},

				},
			}
		
		end
		wipe(options.args.Options.args)
		for i = 1,ATLASLOOT_MAX_QUICKLOOKS do
			options.args.Options.args[tostring(i)] = {
				type = "group",
				name = AtlasLoot:GetQuickLookName(i),
				desc = AtlasLoot:GetQuickLookName(i, true),
				order = i,
				args = addQuickLook(i),
			}
		end
		
		return options
	end
	
end


function AtlasLoot:QuickLookInitialize()
	AtlasLoot:RegisterModuleOptions("QuickLook", getOptions, AL["QuickLook"])
	AtlasLoot:SetEnableQuickLook(AtlasLoot:GetEnableQuickLook())
	
	for k,v in ipairs(AtlasLoot.db.profile.QuickLooks) do
		if type(v) == "string" then
			AtlasLoot.db.profile.QuickLooks[k] = nil
		end
	end
end

--- Sets enable state
-- Shows/Hides the QuickLook fontstring and button from the itemframe
function AtlasLoot:SetEnableQuickLook(value)
	AtlasLoot.db.profile.EnableQuickLook = value
	if AtlasLoot.db.profile.EnableQuickLook then
		AtlasLoot.ItemFrame.QuickLooks:Show()
		AtlasLoot.ItemFrame.QuickLooksName:Show()
	else
		AtlasLoot.ItemFrame.QuickLooks:Hide()
		AtlasLoot.ItemFrame.QuickLooksName:Hide()
	end
	AtlasLoot:RefreshAtlasLootPanel()
	AtlasLoot:RefreshModuleOptions()
end

function AtlasLoot:GetEnableQuickLook()
	return AtlasLoot.db.profile.EnableQuickLook
end

function AtlasLoot:SetQuickLook(num)
	if AtlasLoot.IgnoreList[AtlasLoot.ItemFrame.dataID] then return end
	AtlasLoot.db.profile.QuickLooks[num].lootPage = AtlasLoot.ItemFrame.dataID
	AtlasLoot.db.profile.QuickLooks[num].lootPageType = AtlasLoot.db.profile.LootTableType
	AtlasLoot.db.profile.QuickLooks[num].savedName = AtlasLoot:GetQuickLookName(num)
	if AtlasLoot_Data[ AtlasLoot.ItemFrame.dataID ] then
		AtlasLoot.db.profile.QuickLooks[num].module = AtlasLoot_Data[ AtlasLoot.ItemFrame.dataID ].info.module
	else
		AtlasLoot.db.profile.QuickLooks[num].module = nil
	end
	
	AtlasLoot:RefreshAtlasLootPanel()
end

do
	-- AtlasLoot:QuickLooks_DropDownInit(level)
	-- Initialize the dropdown menu
	local QuickLooks_DropDownInfo = {}
	function AtlasLoot:QuickLooks_DropDownInit(level)
		if not level then return end
		wipe(QuickLooks_DropDownInfo)
		if level == 1 then
			for i = 1,AtlasLoot.db.profile.NumQuickLooks do
				if not AtlasLoot.db.profile.QuickLooks[i].locked then
					QuickLooks_DropDownInfo.text 		 = AtlasLoot:GetQuickLookName(i)
					QuickLooks_DropDownInfo.arg1 		 = i
					QuickLooks_DropDownInfo.func 		 = AtlasLoot.SetQuickLook
					QuickLooks_DropDownInfo.checked		 = nil
					QuickLooks_DropDownInfo.notCheckable = 1
					UIDropDownMenu_AddButton(QuickLooks_DropDownInfo, level)
				end
			end
			QuickLooks_DropDownInfo.text         = "|cffff0000"..CLOSE
			QuickLooks_DropDownInfo.func         = function() CloseDropDownMenus() end
			QuickLooks_DropDownInfo.checked      = nil
			QuickLooks_DropDownInfo.notCheckable = 1
			UIDropDownMenu_AddButton(QuickLooks_DropDownInfo, level)
		end

	end
end

-- AtlasLoot:ShowQuickLooks()
-- Shows the DropDown for setting Quicklooks
function AtlasLoot:ShowQuickLooks()
	ToggleDropDownMenu(1, nil, AtlasLoot.ItemFrame.QuickLooksDropDownMenu, self:GetName(), 0, 0)
end

-- Gets the name of an QuickLook
function AtlasLoot:GetQuickLookName(num, getLootPageName)
	if not num then return end
	local retName, bossName, iniName
	
	if not AtlasLoot_Data[ AtlasLoot.db.profile.QuickLooks[num].lootPage ] then
		retName = AtlasLoot.db.profile.QuickLooks[num].savedName or AL["QuickLook"].." "..num
	else
		if (AtlasLoot.db.profile.QuickLooks[num].useBossName and AtlasLoot.db.profile.QuickLooks[num].useInstanceName) or getLootPageName then
			bossName, iniName = AtlasLoot:GetTableInfo(AtlasLoot.db.profile.QuickLooks[num].lootPage)
		elseif AtlasLoot.db.profile.QuickLooks[num].useBossName then
			bossName = AtlasLoot:GetTableInfo(AtlasLoot.db.profile.QuickLooks[num].lootPage)
		elseif AtlasLoot.db.profile.QuickLooks[num].useInstanceName then
			bossName, iniName = AtlasLoot:GetTableInfo(AtlasLoot.db.profile.QuickLooks[num].lootPage)
			bossName = nil
		elseif AtlasLoot.db.profile.QuickLooks[num].customName then
			bossName = AtlasLoot.db.profile.QuickLooks[num].customName
		end

	
		if bossName and iniName and iniName ~= _G["UNKNOWN"] then
			retName = bossName.." ("..iniName..")"
		elseif bossName then
			retName = bossName
		elseif iniName and iniName ~= _G["UNKNOWN"] then
			retName = iniName
		else
			retName = AL["QuickLook"].." "..num
		end
	end
	return retName
end

-- AtlasLoot_RefreshQuickLookButtons()
-- Enables/disables the quicklook buttons depending on what is assigned
function AtlasLoot:RefreshQuickLookButtons()
	for i = 1,4 do
		if _G["AtlasLootPanel_Preset"..i] then
			if not AtlasLoot.db.profile.QuickLooks[i] then
				_G["AtlasLootPanel_Preset"..i]:Disable()
			else
				_G["AtlasLootPanel_Preset"..i]:Enable()
			end
		end
	end
end