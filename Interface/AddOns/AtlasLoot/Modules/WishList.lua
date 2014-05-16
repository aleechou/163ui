-- $Id: WishList.lua 4206 2013-05-06 22:44:00Z lag123 $
--[[
Atlasloot Enhanced
Author Hegarol
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)
]]

local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local MODULENAME = "WishList"
WishList = AtlasLoot:NewModule(MODULENAME)

local WISHLIST_INFO_ALL = {}

local WishListCount = 0
local Wishlists_Info = {
	numWishlists = 1, 		-- number of aviable wishlists
	defaultWishlist = nil,	-- saves the ID of the default wishlist
	curWishlist = 0, 		-- saves the ID of the current wishlist
	IdSave = {},			-- Ids that already on the wishlist [ID] = { wishlist1, wishlist2, ... }
}
WishList.Info = Wishlists_Info

--StaticPopupDialogs
do
	--StaticPopup_Show ("ATLASLOOT_SEND_WISHLIST",AtlasLootWishList["Own"][tab2][tabname]["info"][1]);
	StaticPopupDialogs["ATLASLOOT_SEND_WISHLIST"] = {
		preferredIndex = 3,
		text = AL["Send Wishlist (%s) to"],
		button1 = AL["Send"],
		button2 = CANCEL,
		--OnShow = function()
		--	this:SetFrameStrata("TOOLTIP");
		--end,
		OnAccept = function(self)
			local name = _G[self:GetParent():GetName().."EditBox"]:GetText()
			if string.lower(name) == string.lower(playerName) then
				DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["You can't send Wishlists to yourself."]);
				curtabname = ""
				curplayername = ""
			elseif name == "" then

			else
				if SpamProtect(string.lower(name)) then
					AtlasLoot_SendWishList(AtlasLootWishList["Own"][curplayername][curtabname],name)
					curtabname = ""
					curplayername = ""
				else
					local _,_,timeleft = string.find( 10-(GetTime() - SpamFilter[string.lower(name)]), "(%d+)%.")
					DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["You must wait "]..WHITE..timeleft..RED..AL[" seconds before you can send a new Wishlist to "]..WHITE..name..RED..".");
				end
			end
		end,
		OnCancel = function ()
			curtabname = ""
			curplayername = ""
		end,
		hasEditBox = 1,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	};
end

local db
local dbDefaults = {
	global = {
		data = {
			['Normal'] = {
				-- Server
				['*'] = {
					-- Name
					['*'] = {
						-- wishlist
						['*'] = {
							[1] = {},
							info = {
								name = "",
								icon = "Interface\\Icons\\INV_Misc_QuestionMark",
								tableSort = {},
								default = false
							},
						},
						[1] = {
							[1] = {},
							info = {
								name = AL["Wishlist"],
								icon = "Interface\\Icons\\INV_Misc_QuestionMark",
								tableSort = {},
								default = true
							},
						},
					},
				},
			},
			['Shared'] = {
				-- Server
				['*'] = {
					-- Name
					['*'] = {
						-- wishlist
						['*'] = {
							[1] = {},
							info = {
								name = "",
								icon = "Interface\\Icons\\INV_Misc_QuestionMark",
								tableSort = {},
							},
						},
					},
				},
			},
		},
	},
	profile = {
		defaultWishlist = true,
		useCharDB = false,
		lastWishlistType = "OWN",
		wishListSelectDropDown = false,
	},
}

local getOptions
do
	local function resetWishlstDefault()
		for _,wishlist in ipairs(WishList.ownWishLists) do
			wishlist.info.default = false
		end
	end
	
	local function AddWishListOption(wlInfo, id)
		local retTab = {
			wlName = {
				type = "input",
				name = AL["Wishlist name:"],
				order = 10,
				get = function(info) 
					return wlInfo.name 
				end,
				set = function(info, value)
					wlInfo.name = value
				end,
			},
			wlIcon = {
				type = "execute",
				name = "",
				image = wlInfo.icon,
				order = 20,
				--desc = ,
				func = function() WishList:CreateIconSelect(wlInfo) end,
				--order = 3,
			},
			--[[
			wlShare = {
				type = "execute",
				name = AL["Share"],
				order = 40,
				--desc = ,
				func = function() WishList:CreateIconSelect(wlInfo) end,
				--order = 3,
			},
			]]
			wlDelete = {
				type = "execute",
				name = AL["Delete"],
				order = 50,
				confirm = true,
				confirmText = string.format(AL["Are you sure you want to delete Wishlist |cff1eff00%s|r?"], wlInfo.name),
				--desc = ,
				func = function() WishList:DeleteWishlist(wlInfo, id) end,
				--order = 3,
			},
		
		}
		
		return retTab
	end
	
	local function AddWishList()
		WishList.ownWishLists[#WishList.ownWishLists + 1] = {
			[1] = {},
			info = {
				name = AL["Wishlist"],
				icon = "Interface\\Icons\\INV_Misc_QuestionMark",
				tableSort = {},
				default = false
			},
		}
		WishList:Refresh()
	end
	
	local options
	function getOptions()
		if not options then
			options = {
				type = "group",
				name = MODULENAME,
				order = 600,
				--childGroups = "tab",
				args = {
					toggle = {
						type = "toggle",
						name = AL["Enable"],
						get = function()
							return AtlasLoot:GetModuleEnabled(MODULENAME)
						end,
						set = function(info, v)
							AtlasLoot:SetModuleEnabled(MODULENAME, v)
						end,
						order = 10,
						width = "full",
					},
					useCharDB = {
						type = "toggle",
						name = AL["Save wishlists at character DB"],
						desc = string.format(AL["Saves the wishlists only for |cff1eff00%s-%s|r.\n Other characters cant view the wishlists, but the memory usage is reduced."], WishList.char, WishList.realm),
						get = function()
							return db.useCharDB
						end,
						set = function(info, v)
							db.useCharDB = v
							WishList:SetupDb(true)
							return db.useCharDB 
						end,
						order = 20,
						width = "full",
					},
					nllockb = {
						type = "description",
						name = "",
						order = 30,
					},
					Own = {
						type = "group",
						name = AL["Own"],
						args = {},
						order = 40,
					},
					Other = {
						type = "group",
						name = AL["Other"],
						args = {},
						order = 50,
					},
					--[[
					Shared = {
						type = "group",
						name = AL["Shared"],
						args = {},
						order = 60,
					},
					]]
				},
			}
		
		end
		wipe(options.args.Own.args)
		options.args.Own.args.defaultWishlist = {
			type = "toggle",
			name = AL["Always use default Wishlist"],
			order = 10,
			--desc = ,
			get = function(info)
				return db.defaultWishlist
			end,
			set = function(info,value)
				db.defaultWishlist = value
				return db.defaultWishlist
			end,
			width = "full",
		}
		options.args.Own.args.addWishlist = {
			type = "execute",
			name = AL["Add Wishlist"],
			order = 20,
			--desc = ,
			func = AddWishList,
		}
		for k,v in ipairs(WishList.ownWishLists) do
			--v.info.name
			options.args.Own.args[tostring(k)] = {
				type = "group",
				name = v.info.name,
				icon = v.info.icon,
				args = AddWishListOption(v.info, k),
			}
			options.args.Own.args[tostring(k)].args.wlDefault = {
				type = "toggle",
				name = AL["default"],
				desc = AL["Use as default wishlist"],
				order = 9,
				get = function() return v.info.default end,
				set = function(info, value)
					resetWishlstDefault()
					v.info.default = value
					WishList:Refresh()
					return v.info.default
				end,
			}
			if v.info.default then
				options.args.Own.args[tostring(k)].name = v.info.name..AL[" |cff999999<default>"];
			end
		end
		
		for server,serverTab in pairs(WishList.allWishLists) do
			for charName,nameTab in pairs(serverTab) do
				if charName ~= WishList.char then
					for k,v in ipairs(nameTab) do
						--v.info.name
						options.args.Other.args[tostring(k)..charName..server] = {
							type = "group",
							name = v.info.name.." |cff999999("..charName.."-"..server..")",
							icon = v.info.icon,
							args = AddWishListOption(v.info, k),
						}
					end
				end
			end
		end
		--nameTab.info.name.." ("..charName.."-"..server..")",
		return options
	end
	
end
	
-- change later..	
local function wishlistButtonOnClick(self, button)
	if db.defaultWishlist and Wishlists_Info.defaultWishlist then
		WishList:ShowWishlist(Wishlists_Info.defaultWishlist)
	else
		if not db.wishListSelectDropDown then
			if not AtlasLoot.CompareFrame.Wishlist:IsShown() then
				AtlasLoot.CompareFrame:Show()
			end
			if AtlasLoot.CompareFrame.Wishlist:IsShown() then
				AtlasLoot.CompareFrame.Wishlist:Hide()
			else
				WishList:CompareFrame_WishlistSelect_UpdateList()
				AtlasLoot.CompareFrame.Wishlist:Show()
			end
		else
			
		end
	end
end

function WishList:OnInitialize()
	if not AtlasLoot.db then AtlasLoot:OnLoaderLoad() end
	self.db = AtlasLoot.db:RegisterNamespace(MODULENAME, dbDefaults)
	self.chardb = AtlasLoot.chardb:RegisterNamespace(MODULENAME, dbDefaults)
	db = self.db.profile
	--LootTableSort:SetConfigTable(db.tableSort)
	AtlasLoot:RegisterModuleOptions(MODULENAME, getOptions, AL["Wishlist"])
	self:SetEnabledState(AtlasLoot:GetModuleEnabled(MODULENAME))
	
	AtlasLoot:AddItemButtonTemplateFunc(WishList.ButtonTemp_AddItemToWishList, "AddItemToWishList")
	AtlasLoot:AddItemButtonTemplateFunc(WishList.ButtonTemp_DeleteItemFromWishList, "DeleteItemFromWishList")
	
	AtlasLoot.ItemFrame.WishListDropDownMenu = CreateFrame("Frame", "AtlasLootWishListDropDownMenu")
	AtlasLoot.ItemFrame.WishListDropDownMenu.displayMode = "MENU"
	AtlasLoot.ItemFrame.WishListDropDownMenu.initialize = self.WishList_DropDownInit
	
	AtlasLoot:RegisterSlashCommand("wishlist", WishList.SlashCommand)
	
	
	for i in ipairs(AtlasLoot.ItemFrame.ItemButtons) do
		if AtlasLoot.ItemFrame.ItemButtons[i] then
			AtlasLoot.ItemFrame.ItemButtons[i].Frame:HookScript("OnClick", WishList.ButtonOnClick)
		end
	end	
	for i in ipairs(AtlasLoot.CompareFrame.ItemButtons) do
		if AtlasLoot.CompareFrame.ItemButtons[i] then
			AtlasLoot.CompareFrame.ItemButtons[i].Frame:HookScript("OnClick", WishList.ButtonOnClick)
			AtlasLoot.CompareFrame.ItemButtons[i].itemButtonButton:HookScript("OnClick", WishList.ButtonOnClick)
		end
	end	
	
	AtlasLoot:PanelAddButton("Wishlist", {
		text = AL["Wishlist"],
		func = function() wishlistButtonOnClick() end,
		order = 60,
		disabled = true,
	})
	
	-- Saved Variables
	self.realm = GetRealmName()
	self.char = UnitName("player")
	
	
	--self.ownWishLists = self.db.global.data['Normal'][self.realm][self.char]
	self:SetupDb()
	self.allWishLists = self.db.global.data['Normal']--[self.realm][self.char]
	self.sharedWishLists = self.db.global.data['Shared'][self.realm][self.char]
	
	WishList:CreateCompareFrameWishListSelect()
end

function WishList:OnEnable()
	AtlasLoot:PanelSetButtonEnable("Wishlist", true)
	self:Refresh()
end

function WishList:OnDisable()
	AtlasLoot:PanelSetButtonEnable("Wishlist", false)

end

local function MoveTable(t, tt)
	tt = tt or {}
	local i, v = next(t, nil)
	while i do
		tt[i] = v
		t[i] = nil
		i, v = next(t, i)
	end
	return tt
end

function WishList:SetupDb(change)
	if db.useCharDB then
		if change then
			MoveTable(self.db.global.data['Normal'][self.realm][self.char], self.chardb.global.data['Normal'][self.realm][self.char])
		end
		self.ownWishLists = self.chardb.global.data['Normal'][self.realm][self.char]
	else
		if change then
			MoveTable(self.chardb.global.data['Normal'][self.realm][self.char], self.db.global.data['Normal'][self.realm][self.char])
		end
		self.ownWishLists = self.db.global.data['Normal'][self.realm][self.char]
	end
	if self.ownWishLists then
		local numLists = #self.ownWishLists
		if numLists and #self.ownWishLists > 0 then
			for i = 1, #self.ownWishLists do
				if self.ownWishLists[i] == nil then
					table.remove(self.ownWishLists, i)
				end
			end
		end
	end
end
-- Icon select
do
	local icon_row_height = 36
	local lastButton = 1
	local newIcon, selectedIcon = ""
	local curInfo
	local MACRO_ICON_FILENAMES = {}

	local function onVerticalScroll(self)
		local numMacroIcons = #MACRO_ICON_FILENAMES
		local wlIcon, wlButton
		local index
		local offset = FauxScrollFrame_GetOffset(AL_WishList_IconSelect)
		
		local texture
		for i=1, 20 do
			wlIcon = _G["AL_WishList_Button_"..i.."Icon"]
			wlButton = _G["AL_WishList_Button_"..i]
			index = (offset * 5) + i;
			--texture = GetMacroIconInfo(index);
			texture = "INTERFACE\\ICONS\\"..MACRO_ICON_FILENAMES[index]
			
			if ( index <= numMacroIcons ) then
				wlIcon:SetTexture(texture);
				wlButton:Show();
			else
				wlIcon:SetTexture("");
				wlButton:Hide();
			end
			
			if ( WishList.IconSelect.selectedIcon and (index == WishList.IconSelect.selectedIcon) ) then
				wlButton:SetChecked(1);
			elseif ( WishList.IconSelect.selectedIconTexture ==  texture ) then
				wlButton:SetChecked(1);
			else
				wlButton:SetChecked(nil);
			end
		end
		
		-- Scrollbar stuff
		FauxScrollFrame_Update(AL_WishList_IconSelect, ceil(numMacroIcons / 5) , 4, icon_row_height );
	end

	local function cancelButton_OnClick(self, button)
		WishList.IconSelect:Hide()
	end

	local function okayButton_OnClick(self, button)
		curInfo.icon = newIcon
		WishList.IconSelect:Hide()
	end

	local function SelectTexture(selectedIcon)
		newIcon = "INTERFACE\\ICONS\\"..MACRO_ICON_FILENAMES[selectedIcon]
		WishList.IconSelect.selectedIcon = selectedIcon
		WishList.IconSelect.selectedIconTexture = nil
		
		onVerticalScroll()
	end

	local function buttonOnClick(self, button)
		SelectTexture(self:GetID() + (FauxScrollFrame_GetOffset(AL_WishList_IconSelect) * 5))
	end

	local function createIconButton(frame)
		local button = CreateFrame("CheckButton", "AL_WishList_Button_"..#WishList.IconSelect.Icons + 1, frame, "WishListIconButtonTemplate")
			button:SetScript("OnClick", buttonOnClick)	
			
		return button	
	end

	function WishList:CreateIconSelect(info)
		if self.IconSelect then 
			self.IconSelect.Title:SetText(info.name)
			self.IconSelect.selectedIcon = nil
			self.IconSelect.selectedIconTexture = info.icon or "Interface\\Icons\\INV_Misc_QuestionMark"
			self.IconSelect.OkayButton.info = info
			self.IconSelect:Show() 
			return
		end
		
		self.IconSelect = CreateFrame("FRAME")
		
		local IconSelect = self.IconSelect
		IconSelect:ClearAllPoints()
		IconSelect:SetParent(UIParent)
		IconSelect:SetPoint("CENTER", UIParent, "CENTER")
		IconSelect:SetFrameStrata("TOOLTIP")
		IconSelect:SetWidth(297)
		IconSelect:SetHeight(298)
		
		IconSelect.Textures = {}
		
		IconSelect.Textures[1] = IconSelect:CreateTexture(nil, "ARTWORK")
		IconSelect.Textures[1]:SetPoint("TOPLEFT", IconSelect, "TOPLEFT")	
		IconSelect.Textures[1]:SetWidth(256)
		IconSelect.Textures[1]:SetHeight(256)
		IconSelect.Textures[1]:SetTexture("Interface\\MacroFrame\\MacroPopup-TopLeft")
		
		IconSelect.Textures[2] = IconSelect:CreateTexture(nil, "ARTWORK")
		IconSelect.Textures[2]:SetPoint("TOPLEFT", IconSelect, "TOPLEFT", 256, 0)	
		IconSelect.Textures[2]:SetWidth(64)
		IconSelect.Textures[2]:SetHeight(256)
		IconSelect.Textures[2]:SetTexture("Interface\\MacroFrame\\MacroPopup-TopRight")
		
		IconSelect.Textures[3] = IconSelect:CreateTexture(nil, "ARTWORK")
		IconSelect.Textures[3]:SetPoint("TOPLEFT", IconSelect, "TOPLEFT", 0, -256)	
		IconSelect.Textures[3]:SetWidth(256)
		IconSelect.Textures[3]:SetHeight(64)
		IconSelect.Textures[3]:SetTexture("Interface\\MacroFrame\\MacroPopup-BotLeft")
		
		IconSelect.Textures[3] = IconSelect:CreateTexture(nil, "ARTWORK")
		IconSelect.Textures[3]:SetPoint("TOPLEFT", IconSelect, "TOPLEFT", 256, -256)	
		IconSelect.Textures[3]:SetWidth(64)
		IconSelect.Textures[3]:SetHeight(64)
		IconSelect.Textures[3]:SetTexture("Interface\\MacroFrame\\MacroPopup-BotRight")
		
		IconSelect.Title = IconSelect:CreateFontString(nil,"OVERLAY","GameFontNormal")
		IconSelect.Title:SetPoint("CENTER", IconSelect, "TOP", 0, -25)
		IconSelect.Title:SetText(info.name)
		IconSelect.Title:SetWidth(272)
		
		IconSelect.SelectIcon = IconSelect:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
		IconSelect.SelectIcon:SetPoint("TOPLEFT", IconSelect, "TOPLEFT", 24, -69)
		IconSelect.SelectIcon:SetText(MACRO_POPUP_CHOOSE_ICON)
		
		IconSelect.ScrollFrame = CreateFrame("ScrollFrame", "AL_WishList_IconSelect", IconSelect, "ListScrollFrameTemplate")
		IconSelect.ScrollFrame:SetWidth(296)
		IconSelect.ScrollFrame:SetHeight(195)
		IconSelect.ScrollFrame:SetPoint("TOPRIGHT", IconSelect, "TOPRIGHT", -39, -67)
		IconSelect.ScrollFrame:SetScript("OnVerticalScroll", function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, icon_row_height, onVerticalScroll) end)
		
		IconSelect.Icons = {}
		for i = 1,4 do
			IconSelect.Icons[#IconSelect.Icons + 1] = createIconButton(IconSelect)
			if i == 1 then
				lastButton = 1
				IconSelect.Icons[#IconSelect.Icons]:SetPoint("TOPLEFT", IconSelect, "TOPLEFT", 24, -85)
				IconSelect.Icons[#IconSelect.Icons]:SetID(#IconSelect.Icons)
			else
				IconSelect.Icons[#IconSelect.Icons]:SetPoint("TOPLEFT", IconSelect.Icons[lastButton], "BOTTOMLEFT", 0, -8)
				IconSelect.Icons[#IconSelect.Icons]:SetID(#IconSelect.Icons)
				lastButton = lastButton + 5
			end
			for j = 1,4 do
				IconSelect.Icons[#IconSelect.Icons + 1] = createIconButton(IconSelect)
				IconSelect.Icons[#IconSelect.Icons]:SetID(#IconSelect.Icons)
				IconSelect.Icons[#IconSelect.Icons]:SetPoint("LEFT", IconSelect.Icons[#IconSelect.Icons - 1], "RIGHT", 10, 0)
			end
		end
		
		IconSelect.CancelButton = CreateFrame("Button", nil, IconSelect, "UIPanelButtonTemplate")
		IconSelect.CancelButton:SetWidth(78)
		IconSelect.CancelButton:SetHeight(22)
		IconSelect.CancelButton:SetPoint("BOTTOMRIGHT", IconSelect, "BOTTOMRIGHT", -11, 13)
		IconSelect.CancelButton:SetText(CANCEL)
		IconSelect.CancelButton:SetScript("OnClick", cancelButton_OnClick)
		
		IconSelect.OkayButton = CreateFrame("Button", nil, IconSelect, "UIPanelButtonTemplate")
		IconSelect.OkayButton:SetWidth(78)
		IconSelect.OkayButton:SetHeight(22)
		IconSelect.OkayButton:SetPoint("RIGHT", IconSelect.CancelButton, "LEFT", -2, 0)
		IconSelect.OkayButton:SetText(OKAY)	
		IconSelect.OkayButton.info = info
		IconSelect.OkayButton:SetScript("OnClick", function(self) 
			self.info.icon = newIcon
			WishList.IconSelect:Hide()
			AtlasLoot:RefreshModuleOptions()
		end)
		
		IconSelect:SetScript("OnShow", onVerticalScroll) 
		
		MACRO_ICON_FILENAMES[1] = "INV_MISC_QUESTIONMARK"
		GetMacroIcons( MACRO_ICON_FILENAMES );
  		GetMacroItemIcons( MACRO_ICON_FILENAMES );
  
		onVerticalScroll()

	end

end

-- onClick of a itemButton
function WishList:ButtonOnClick(arg1)
	if not self.par.tableLink and IsAltKeyDown() then
		self.par:AddItemToWishList()
	end
end

function WishList:CheckHeroic()
	local heroic
	local checkName = "|cffFF0000"..AL["Heroic Mode"]
	for itemNum,item in ipairs(AtlasLoot.ItemFrame.ItemButtons) do
		if item.Frame.Name:GetText() == checkName then
			heroic = itemNum
		end
	end
	return heroic
end

function WishList:ShowWishlist(wishlist)
	if wishlist and self.ownWishLists[wishlist] then
		AtlasLoot:CompareFrame_LoadWishList(self.ownWishLists[wishlist][1], wishlist, self.ownWishLists[wishlist].info.name)
	else
		if not AtlasLoot.CompareFrame:IsShown() then
			AtlasLoot.CompareFrame:Show()
		else
			AtlasLoot.CompareFrame:Hide()
			AtlasLoot.CompareFrame:Show()
		end
		if not AtlasLoot.CompareFrame.Wishlist:IsShown() then
			AtlasLoot.CompareFrame.Wishlist:Show()
			WishList:CompareFrame_WishlistSelect_UpdateList()
		end
	end
end

-- /al wishlist, /atlasloot wishlist
-- msg is allways "wishlist"
function WishList:SlashCommand(msg, ...)
	local wishlistName = ...
	if wishlistName then
		WishList:OpenWishlist(wishlistName)
	else
		WishList:ShowWishlist(nil)
	end
end

function WishList:DeleteWishlist(info, id)
	table.remove(self.ownWishLists, id)
	WishList:Refresh()
	collectgarbage("collect")
end
-- ###################################
-- Refresh functions
-- ###################################
function WishList:Refresh()
	AtlasLoot.CompareFrame.Wishlist:Hide()
	if self.ownWishLists then
		self.Info.numWishlists = #self.ownWishLists
		self:RefreshItemIdList()
		self:RefreshDefaultWishlist()
		self:RefreshCurWishlist()
	end
end

function WishList:RefreshItemIdList()
	local IdSave = self.Info.IdSave
	wipe(WISHLIST_INFO_ALL)
	AtlasLoot.CompareFrame.Wishlist:Hide()
	for server,serverTab in pairs(WishList.allWishLists) do
		for name,nameTab in pairs(serverTab) do
			for k,v in ipairs(nameTab) do
				table.insert(WISHLIST_INFO_ALL, {k, name, server, v.info.name, v.info.icon, #v[1]})
			end
		end
	end
	wipe(IdSave)
	for _,wishlist in ipairs(self.ownWishLists) do
		for itemNum,item in ipairs(wishlist[1]) do
			if item[2] then
				if not IdSave[item[2]] then IdSave[item[2]] = {} end
				IdSave[item[2]][#IdSave[item[2]] + 1] = wishlist.info.name
				if item[3] and item[3] ~= "" then
					if not IdSave["s"..item[3]] then IdSave["s"..item[3]] = {} end
					IdSave["s"..item[3]][#IdSave["s"..item[3]] + 1] = wishlist.info.name
				end
			else
				table.remove(self.ownWishLists, itemNum)
			end
		end
	end
end

function WishList:RefreshDefaultWishlist()
	for id,wishlist in ipairs(self.ownWishLists) do
		if wishlist.info.default then
			self.Info.defaultWishlist = id
			return
		end
	end
end

function WishList:RefreshCurWishlist(id)
	if db.defaultWishlist and self.Info.defaultWishlist then
		self.Info.curWishlist = self.Info.defaultWishlist
	elseif id then
		self.Info.curWishlist = tonumber(id)
	else
		if self.Info.defaultWishlist then
			self.Info.curWishlist = self.Info.defaultWishlist
		else
			self.Info.curWishlist = 1
		end
	end
end
-- ###################################
-- API
-- ###################################
function WishList:CheckWishlistForItemOrSpell(id, wishlist)
	local isListed
	if self.Info.curWishlist and self.Info.curWishlist ~= 0 then
		if id and self.Info.IdSave[id] then
			if wishlist then
				for k,v in ipairs(self.Info.IdSave[id]) do
					if v == wishlist then
						isListed = true
					end
				end
				if not isListed then
					isListed = false
				end
			else
				isListed = true
			end
		else
			isListed = false
		end
	end
	return isListed
end

function WishList:GetWishlistNameByID(id)
	if not id then return end
	return self.ownWishLists[id].info.name
end

function WishList:CheckWishlistForItemOrSpell(id, wishlist)
	local isListed
	if self.Info.curWishlist and self.Info.curWishlist ~= 0 then
		if id and self.Info.IdSave[id] then
			if wishlist then
				for k,v in ipairs(self.Info.IdSave[id]) do
					if v == wishlist then
						isListed = true
					end
				end
				if not isListed then
					isListed = false
				end
			else
				isListed = true
			end
		else
			isListed = false
		end
	end
	return isListed
end

function WishList:GetWishlistIDByName(name)
	if not name then return end
	for id,wishlist in ipairs(self.ownWishLists) do
		if wishlist.info.name == name then
			return id
		end
	end
	return nil
end

function WishList:GetWishListIcon(wishlist)
	if type(wishlist) == "string" then
		wishlist = self:GetWishlistIDByName(wishlist)
	elseif type(wishlist) == "number" then
		wishlist = wishlist
	else
		return nil
	end
	if self.ownWishLists[wishlist] then
		return self.ownWishLists[wishlist]["info"]["icon"] or "Interface\\Icons\\INV_Misc_QuestionMark"
	else
		return "Interface\\Icons\\INV_Misc_QuestionMark"
	end
end

function AtlasLoot:GetItemOnWishlistIconString(itemID)
	if not itemID then return end
	if WishList.Info.IdSave[itemID] then
		local retstring = ""
		local icon
		for k,v in ipairs(WishList.Info.IdSave[itemID]) do
			icon = WishList:GetWishListIcon(v)
			if icon then
				retstring = retstring.."|T"..icon..":0|t"
			end
		end
		retstring = retstring.." "
		return retstring
	end
	return nil
end

function AtlasLoot:Wishlist_GetWishlistName(id)
	return "TEST"--WishList:GetWishlistNameByID(id)
end

function AtlasLoot:Wishlist_GetItemListFromBoss(bossName)
	if bossName and type(bossName) == "string" and bossName ~= "" then
		
		
		
	end
end

-- Fix a wishlist with wrong/corrupt entrys
function AtlasLoot:Wishlist_FixWishlist(wishlist)
	if type(wishlist) == "string" then
		wishlist = self:GetWishlistIDByName(wishlist)
	elseif type(wishlist) == "number" then
		wishlist = wishlist
	else
		return nil
	end
	
	local errors = {}
	local dataID
	wishlist = WishList.ownWishLists[wishlist][1]
	if not wishlist then return end
	
	-- Nach defekten items in wishliste suchen
	for k,v in ipairs(wishlist) do
		if v[2] and v[6] then
			dataID = AtlasLoot:FormatDataID(v[6])
			if not dataID then
				errors[ v[2] ] = k
			end
		else
			errors[ v[2] ] = k
		end
	end
	
	-- AtlasLoot daten nach items durchsuchen
	for dataID, data in pairs(AtlasLoot_Data) do		
		for _,tableType in ipairs(AtlasLoot.lootTableTypes) do			
			if data[tableType] then
				for _,itemTable in ipairs(data[tableType]) do
					for itemNum,item in ipairs(itemTable) do
						if item[2] then
							if errors[ item[2] ] then
								errors[ item[2] ] = dataID.."#"..tableType
							end
						end
					end
				end
			end			
		end		
	end
	
	-- Wishliste aktuallisieren
	for k,v in ipairs(wishlist) do
		if v[2] and v[6] then
			if errors[ v[2] ] and type(errors[ v[2] ]) == "string" then
				wishlist[k][6] = errors[ v[2] ]
			end
		end
	end	
	
	-- Defekten items löschen
	for k,v in pairs(errors) do
		if v and type(v) == "number" then
			local tmpNum
			for i,j in ipairs(wishlist) do
				if j[2] == k then
					tmpNum = i
					break
				end
			end
			if tmpNum then
				table.remove(wishlist, tmpNum)
				tmpNum = nil
			end
		end
	end

end

--- Searchs a wishlist
-- @param name the wishlist name you want to search
function WishList:SearchWishlist(name)
	name = string.lower(name) or ""
	local found
	for k,v in ipairs(WishList.ownWishLists) do
		if string.lower(WishList.ownWishLists[k].info.name) == name or tonumber(name) == k then
			found = k
		end
	end
	return found
end

function WishList:OpenWishlist(nameOrId)
	if type(nameOrId) == "string" then
		nameOrId = self:SearchWishlist(nameOrId)
	end
		
	WishList:ShowWishlist(nameOrId)
	
end

AtlasLoot.OpenWishlist = WishList.OpenWishlist
-- ###################################
-- Add/delete Item
-- ###################################
local curItem 
--{server, name, wishlist, wishlistname}
local lastShownCompareFrame = nil
-- DropDown Menu
-- Add item
do
	local function AddItem(self, arg1, arg2, checked)
		if arg1 then
			WishList:RefreshCurWishlist(arg2)
			WishList:AddItemToWishList(unpack(arg1))
		end
	end
	
	local WishList_DropDownInfo = {}
	function WishList:WishList_DropDownInit(level)
		if not level then return end
		wipe(WishList_DropDownInfo)
		if level == 1 then
			for i,v in ipairs(WishList.ownWishLists) do
				WishList_DropDownInfo.text 			= v.info.name
				WishList_DropDownInfo.arg1			= curItem
				WishList_DropDownInfo.arg2			= i
				WishList_DropDownInfo.func			= AddItem
				WishList_DropDownInfo.checked     	= nil
				WishList_DropDownInfo.notCheckable	= 1
				UIDropDownMenu_AddButton(WishList_DropDownInfo, level)
			end
			WishList_DropDownInfo.text         = "|cffff0000"..CLOSE
			WishList_DropDownInfo.func         = function() CloseDropDownMenus() end
			WishList_DropDownInfo.checked      = nil
			WishList_DropDownInfo.notCheckable = 1
			UIDropDownMenu_AddButton(WishList_DropDownInfo, level)			
		end
	end
end

--- Adds a item to the Wishlist
-- @param spellID The spell ID
-- @param itemID The item ID from the crafted spell
-- @param itemName name of the item/spell
-- @param extraText The small text under the name.
-- @param dataID the name of the AtlasLootTable with lootTableType (dataID#lootTableType)
function WishList:AddItemToWishList(spellID, itemID, itemName, extraText, dataID, chatLink)
	spellID = spellID or ""
	local curID = self.Info.curWishlist
	local curName = self:GetWishlistNameByID(curID)
	if not self:CheckWishlistForItemOrSpell(itemID, curName) and not self:CheckWishlistForItemOrSpell("s"..spellID, curName) then
		table.insert(self.ownWishLists[curID][1], { 0, itemID, spellID, itemName, extraText, dataID } )
		print(chatLink..AL[" added to the WishList."])
	else
		print(chatLink..AL[" already in the WishList!"])
	end
	self:RefreshItemIdList()
	AtlasLoot:CompareFrame_UpdateItemListScrollFrame("SKIP")
	if lastShownCompareFrame then
		AtlasLoot:CompareFrame_LoadWishList(WishList.allWishLists[lastShownCompareFrame[1]][lastShownCompareFrame[2]][lastShownCompareFrame[3]][1], lastShownCompareFrame[3], lastShownCompareFrame[4], lastShownCompareFrame[3])
	end
end

-- Item on click function
function WishList:ButtonTemp_AddItemToWishList()
	if not self.info or not AtlasLoot:GetModuleEnabled(MODULENAME) then return end
	
	if self.type == "CompareFrameItemButton" then
		if self.itemType and self.itemType[1] == "wishlist" then--SetItemType({"wishlist", dataID, heroic,})
			self:DeleteItemFromWishList()
		elseif self.info and self.itemType and self.GetChatLink then
			if AtlasLoot.db.profile.ShowThunderforged and self.info[9] then
				curItem = { self.info[1], self.info[9], self.info[3], self.info[4], self.itemType[2].."#"..self.itemType[3], self:GetChatLink() }
			else
				curItem = { self.info[1], self.info[2], self.info[3], self.info[4], self.itemType[2].."#"..self.itemType[3], self:GetChatLink() }
			end
			if (db.defaultWishlist and Wishlists_Info.defaultWishlist) or #WishList.ownWishLists == 1 then
				if #WishList.ownWishLists == 1 then WishList:RefreshCurWishlist(1) end
				if self.info[2] == nil then 
					WishList:AddItemToWishList(self.info[1], self.info[5], self.info[3], self.info[4], self.itemType[2].."#"..self.itemType[3], self:GetChatLink())
				else
					if AtlasLoot.db.profile.ShowThunderforged and self.info[9] then
						WishList:AddItemToWishList(self.info[1], self.info[9], self.info[3], self.info[4], self.itemType[2].."#"..self.itemType[3], self:GetChatLink())
					else	
						WishList:AddItemToWishList(self.info[1], self.info[2], self.info[3], self.info[4], self.itemType[2].."#"..self.itemType[3], self:GetChatLink())
					end
				end
			else
				ToggleDropDownMenu(1, nil, AtlasLoot.ItemFrame.WishListDropDownMenu, self.Frame:GetName(), 0, 0)
			end
		end
	else
		local dataID, instancePage = AtlasLoot:FormatDataID(AtlasLoot.ItemFrame.dataID)
		local lootTableType
		local heroicCheckNumber = AtlasLoot:CheckHeroic()
		
		if heroicCheckNumber and heroicCheckNumber < self.buttonID then
			lootTableType = "Heroic"
		else
			lootTableType = AtlasLoot.ItemFrame.lootTableType
		end
		if AtlasLoot.db.profile.ShowThunderforged and self.info[9] then
			curItem = { self.info[1], self.info[9], self.info[3], self.info[4], dataID.."#"..lootTableType, self:GetChatLink() }
		else
			curItem = { self.info[1], self.info[2], self.info[3], self.info[4], dataID.."#"..lootTableType, self:GetChatLink() }
		end
		if (db.defaultWishlist and Wishlists_Info.defaultWishlist) or #WishList.ownWishLists == 1 then
			if #WishList.ownWishLists == 1 then WishList:RefreshCurWishlist(1) end
			if self.info[2] == nil then 
				WishList:AddItemToWishList(self.info[1], self.info[5], self.info[3], self.info[4], dataID.."#"..lootTableType, self:GetChatLink())
			else
				if AtlasLoot.db.profile.ShowThunderforged and self.info[9] then
					WishList:AddItemToWishList(self.info[1], self.info[9], self.info[3], self.info[4], dataID.."#"..lootTableType, self:GetChatLink())
				else	
					WishList:AddItemToWishList(self.info[1], self.info[2], self.info[3], self.info[4], dataID.."#"..lootTableType, self:GetChatLink())
				end
			end
		else
			ToggleDropDownMenu(1, nil, AtlasLoot.ItemFrame.WishListDropDownMenu, self.Frame:GetName(), 0, 0)
		end
	end
end

function WishList:DeleteItemFromWishList(wishlistIndex, spellID, itemID, chatLink)
	wishlistIndex = tonumber(wishlistIndex)
	for itemIndex,item in ipairs(self.ownWishLists[wishlistIndex][1]) do
		if item[2] == itemID or item[3] == spellID then
			table.remove(self.ownWishLists[wishlistIndex][1], itemIndex)
		end
	end
	print(chatLink..AL[" deleted from the WishList."])
	self:RefreshItemIdList()
	if spellID and spellID ~= "" then
		AtlasLoot:CompareFrame_RemoveItemFromList("s"..spellID, wishlistIndex)
	else
		AtlasLoot:CompareFrame_RemoveItemFromList(itemID, wishlistIndex)
	end
	--WishList:ShowWishlist(wishlistIndex)
	--AtlasLoot:CompareFrame_LoadWishList(itemTab, wishlistID, wishlistName, refresh)
end

-- Item on click function
function WishList:ButtonTemp_DeleteItemFromWishList()
	if not self.info or not AtlasLoot:GetModuleEnabled(MODULENAME) then return end
	if self.type == "CompareFrameItemButton" then
		WishList:DeleteItemFromWishList(self.itemType[4], self.info[1], self.info[2], self:GetChatLink())
	end
end

-- #####################################################
-- Compare Frame
--[[
local function showWishlistSelectDropDown_OnClick(self, arg1, arg2)

end

local WishlistSelectDropDownInfo = {}
function WishList:SelectWishlist_DropDownInit(level)
	if not level then return end
	wipe(WishlistSelectDropDownInfo)
	if level == 1 then
		WishlistSelectDropDownInfo.text 		 = AL["Own"]
		WishlistSelectDropDownInfo.hasArrow 	 = true
		WishlistSelectDropDownInfo.notCheckable  = true
		UIDropDownMenu_AddButton(WishlistSelectDropDownInfo, level)



AL["Own"] = true;
	AL["Other"] = true;

		WishlistSelectDropDownInfo.text         = "|cffff0000"..CLOSE
		WishlistSelectDropDownInfo.func         = function() CloseDropDownMenus() end
		WishlistSelectDropDownInfo.checked      = nil
		WishlistSelectDropDownInfo.notCheckable = 1
		UIDropDownMenu_AddButton(WishlistSelectDropDownInfo, level)
	end
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
]]--

local function onVerticalScrollWishlistFrame(self, offset)
	FauxScrollFrame_OnVerticalScroll(self, offset, 46, WishList.CompareFrame_WishlistSelect_UpdateList)
end

function WishList:CompareFrame_WishlistSelect_UpdateList()
	self = WishList
	local wishlistTab = {}
	local name, server
	local numWishLists = 0
	local button, index
	local createt = false
	local offset = FauxScrollFrame_GetOffset(AtlasLootCompareFrame_WishlistScrollFrame);
	
	if type(db.lastWishlistType) == "table" then
		name = db.lastWishlistType[1]
		server = db.lastWishlistType[2]
	end
	for i in ipairs(AtlasLoot.CompareFrame.Wishlist.ScrollFrame.Buttons) do
		AtlasLoot.CompareFrame.Wishlist.ScrollFrame.Buttons[i].playerTab = nil	--{ name, server }
		AtlasLoot.CompareFrame.Wishlist.ScrollFrame.Buttons[i].wishlist = nil
		AtlasLoot.CompareFrame.Wishlist.ScrollFrame.Buttons[i].wishlist = nil
		AtlasLoot.CompareFrame.Wishlist.ScrollFrame.Buttons[i]:Hide()
	end
	
	if db.lastWishlistType and db.lastWishlistType == "ALL" then
		numWishLists = #WISHLIST_INFO_ALL
		
		if numWishLists > 0 and not createt then
			for i=1,8 do
				button = AtlasLoot.CompareFrame.Wishlist.ScrollFrame.Buttons[i]
				index = offset + i
				
				if i <= numWishLists then
					button:Show()
					button.playerTab = { WISHLIST_INFO_ALL[index][2], WISHLIST_INFO_ALL[index][3] }
					button.wishlist = index
					
					button.name:SetText(WISHLIST_INFO_ALL[index][4])
					button.desc:SetText(string.format(AL["%d items"], WISHLIST_INFO_ALL[index][6]))
					button.type:SetText(WISHLIST_INFO_ALL[index][2].." - "..WISHLIST_INFO_ALL[index][3])
					
					button.icon:SetTexture(WISHLIST_INFO_ALL[index][5] or "Interface\\Icons\\INV_Misc_QuestionMark")
				
				else
					button:Hide()
				end
			end
		end
		
		createt = true
	elseif name and server and WishList.allWishLists[server] and WishList.allWishLists[server] and WishList.allWishLists[server] and WishList.allWishLists[server][name] then
		wishlistTab = WishList.allWishLists[server][name]
		numWishLists = #WishList.allWishLists[server][name]
	else
		if db.lastWishlistType and db.lastWishlistType == "SHARED" then
			--wishlistTab = WishList.ownWishLists
			--NUM_ITEMS_IN_WISHLIST = #WishList.ownWishLists
		else
			wishlistTab = WishList.ownWishLists
			numWishLists = #WishList.ownWishLists
			name = self.char
			server = self.realm 
		end
	end	

	if numWishLists > 0 and not createt then
		for i=1,8 do
			button = AtlasLoot.CompareFrame.Wishlist.ScrollFrame.Buttons[i]
			index = offset + i
			
			if index <= numWishLists then
				button:Show()
				button.playerTab = { name, server }
				button.wishlist = index
				button.wishlistName = wishlistTab[index].info.name
				
				button.name:SetText(wishlistTab[index].info.name)
				button.desc:SetText(string.format(AL["%d items"], #wishlistTab[index][1]))
				button.type:SetText(string.format("%s - %s", name or "?", server or "?"))
				button.icon:SetTexture(wishlistTab[index].info.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
			
			else
				button:Hide()
			end
		end
	else
	
	end
	
	FauxScrollFrame_Update(AtlasLootCompareFrame_WishlistScrollFrame, numWishLists, 8, 46, nil, nil, nil, nil, nil, nil, true);
end

function WishList.CompareFrame_Item_OnClick(self)
	AtlasLoot.CompareFrame.Wishlist:Hide()
	lastShownCompareFrame = { self.playerTab[2], self.playerTab[1], self.wishlist, self.wishlistName }
	if self.playerTab[2] and self.playerTab[2] == WishList.realm and self.playerTab[1] and self.playerTab[1] == WishList.char then
		AtlasLoot:CompareFrame_LoadWishList(WishList.ownWishLists[self.wishlist][1], self.wishlist, self.wishlistName)
	else
		AtlasLoot:CompareFrame_LoadWishList(WishList.allWishLists[self.playerTab[2]][self.playerTab[1]][self.wishlist][1], self.wishlist, self.wishlistName)
	end
end

function WishList:CompareFrame_DropDownRefresh()
	UIDropDownMenu_Initialize(_G["AtlasLootCompareFrame_WishlistDropDown"], WishList.CompareFrame_DropDownInitialize)
	UIDropDownMenu_SetSelectedValue(_G["AtlasLootCompareFrame_WishlistDropDown"], db.lastWishlistType)
	UIDropDownMenu_SetWidth(_G["AtlasLootCompareFrame_WishlistDropDown"], 150)
end
-- AtlasLootCompareFrameSearch_StatsListDropDown
function WishList.CompareFrame_DropDownInitialize(self)
	local info = self.info
	wipe(info)	
	
	if AtlasLoot.db.profile.CompareFrame.showBaseSort then
		info.text = AL["Show all wishlists"]
		info.value = "ALL"
		info.func = WishList.CompareFrame_DropDown_OnClick
		info.checked = nil
		UIDropDownMenu_AddButton(info)		
	end
	if AtlasLoot.db.profile.CompareFrame.showExtraSort then
		info.text = AL["Show own wishlists"]
		info.value = "OWN"
		info.func = WishList.CompareFrame_DropDown_OnClick
		info.checked = nil
		UIDropDownMenu_AddButton(info)
	end	
			
	info.text         = ""
	info.func         = nil
	info.checked      = nil
	info.notCheckable = 1
	info.notCheckable = true
	info.isTitle = true
	info.justifyH	  = "CENTER"
	UIDropDownMenu_AddButton(info)
	
	info.text         = "|cffff0000"..CLOSE
	info.func         = function() CloseDropDownMenus() end
	info.checked      = nil
	info.notCheckable = 1
	info.isTitle	  = false
	info.disabled	  = false
	info.justifyH	  = "CENTER"
	UIDropDownMenu_AddButton(info)
end

function WishList.CompareFrame_DropDown_OnClick(self)
	if not self.value then return end
    db.lastWishlistType = self.value
	WishList:CompareFrame_DropDownRefresh()
	WishList:CompareFrame_WishlistSelect_UpdateList()
end

function WishList:CreateCompareFrameWishListSelect()
	local Frame = AtlasLoot.CompareFrame
	if Frame.Wishlist then
		return
	end
	-- ###########################################
	-- Wishlist frame
	Frame.Wishlist = CreateFrame("Frame", "AtlasLootCompareFrame_Wishlist", Frame)
	Frame.Wishlist:SetPoint("BOTTOM", Frame, "BOTTOM", 0, 15)
	Frame.Wishlist:SetWidth(600)
	Frame.Wishlist:SetHeight(400)
	Frame.Wishlist:EnableMouse(true)
	
	Frame.Wishlist.Layers = {}
	
	Frame.Wishlist.Layers[1] = Frame.Wishlist:CreateTexture(nil, "BACKGROUND")
	Frame.Wishlist.Layers[1]:SetPoint("TOPLEFT", Frame.Wishlist, "TOPLEFT", 0, 0)
	Frame.Wishlist.Layers[1]:SetPoint("BOTTOMRIGHT", Frame.Wishlist, "BOTTOMRIGHT", 0, 0)
	Frame.Wishlist.Layers[1]:SetVertexColor(0.9, 0.8, 0.7, 1.0)
	Frame.Wishlist.Layers[1]:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock")
	
	Frame.Wishlist.Layers[2] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[2]:SetPoint("TOPLEFT", Frame.Wishlist, "TOPLEFT", -7, 4)
	Frame.Wishlist.Layers[2]:SetVertexColor(0.5, 0.5, 0.5, 1.0)
	Frame.Wishlist.Layers[2]:SetTexture("Interface\\FrameGeneral\\UI-Frame")
	Frame.Wishlist.Layers[2]:SetTexCoord(0.00781250, 0.11718750, 0.74218750, 0.63281250)
	Frame.Wishlist.Layers[2]:SetWidth(14)
	Frame.Wishlist.Layers[2]:SetHeight(14)
	--Frame.Wishlist.Layers[1]:SetTexture("UI-Frame-TopCornerLeft")

	Frame.Wishlist.Layers[3] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[3]:SetPoint("TOPRIGHT", Frame.Wishlist, "TOPRIGHT", 4, 4)
	Frame.Wishlist.Layers[3]:SetVertexColor(0.5, 0.5, 0.5, 1.0)	
	Frame.Wishlist.Layers[3]:SetTexture("Interface\\FrameGeneral\\UI-Frame")
	Frame.Wishlist.Layers[3]:SetTexCoord(0.13281250, 0.21875000, 0.98437500, 0.89843750)
	Frame.Wishlist.Layers[3]:SetWidth(11)
	Frame.Wishlist.Layers[3]:SetHeight(11)
						
	Frame.Wishlist.Layers[4] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[4]:SetPoint("TOPLEFT", Frame.Wishlist.Layers[2], "TOPRIGHT", 0, 0)
	Frame.Wishlist.Layers[4]:SetPoint("TOPRIGHT", Frame.Wishlist.Layers[3], "TOPLEFT", 0, 0)
	Frame.Wishlist.Layers[4]:SetVertexColor(0.5, 0.5, 0.5, 1.0)
	Frame.Wishlist.Layers[4]:SetTexture("Interface\\FrameGeneral\\_UI-Frame")
	Frame.Wishlist.Layers[4]:SetTexCoord(0.00000000, 1.00000000, 0.27343750, 0.20312500)	
	Frame.Wishlist.Layers[4]:SetWidth(256)
	Frame.Wishlist.Layers[4]:SetHeight(9)
	
	Frame.Wishlist.Layers[5] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[5]:SetPoint("BOTTOM", Frame.Wishlist, "BOTTOM", 0, 0)
	Frame.Wishlist.Layers[5]:SetPoint("TOPLEFT", Frame.Wishlist.Layers[2], "BOTTOMLEFT", 0, 0)
	Frame.Wishlist.Layers[5]:SetVertexColor(0.5, 0.5, 0.5, 1.0)
	Frame.Wishlist.Layers[5]:SetTexture("Interface\\FrameGeneral\\!UI-Frame")
	Frame.Wishlist.Layers[5]:SetTexCoord(0.35937500, 0.60937500, 0.00000000, 1.00000000)	
	Frame.Wishlist.Layers[5]:SetWidth(16)
	Frame.Wishlist.Layers[5]:SetHeight(256)
	
	Frame.Wishlist.Layers[6] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[6]:SetPoint("BOTTOM", Frame.Wishlist, "BOTTOM", 0, 0)
	Frame.Wishlist.Layers[6]:SetPoint("TOPRIGHT", Frame.Wishlist.Layers[3], "BOTTOMRIGHT", 1, 0)
	Frame.Wishlist.Layers[6]:SetVertexColor(0.5, 0.5, 0.5, 1.0)	
	Frame.Wishlist.Layers[6]:SetTexture("Interface\\FrameGeneral\\!UI-Frame")
	Frame.Wishlist.Layers[6]:SetTexCoord(0.17187500, 0.32812500, 0.00000000, 1.00000000)
	Frame.Wishlist.Layers[6]:SetWidth(10)
	Frame.Wishlist.Layers[6]:SetHeight(256)	
	
	Frame.Wishlist.Layers[7] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[7]:SetPoint("TOPLEFT", Frame.Wishlist, "TOPLEFT", 0, 0)
	Frame.Wishlist.Layers[7]:SetPoint("TOPRIGHT", Frame.Wishlist, "TOPRIGHT", 0, 0)
	Frame.Wishlist.Layers[7]:SetTexture("Interface\\FrameGeneral\\_UI-Frame")
	Frame.Wishlist.Layers[7]:SetTexCoord(0.00000000, 1.00000000, 0.67187500, 0.96093750)
	Frame.Wishlist.Layers[7]:SetWidth(256)
	Frame.Wishlist.Layers[7]:SetHeight(37)	
	
	Frame.Wishlist.Layers[8] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[8]:SetPoint("TOPLEFT", Frame.Wishlist, "TOPLEFT", -7, -20)
	Frame.Wishlist.Layers[8]:SetVertexColor(0.5, 0.5, 0.5, 1.0)	
	Frame.Wishlist.Layers[8]:SetTexture("Interface\\FrameGeneral\\UI-Frame")
	Frame.Wishlist.Layers[8]:SetTexCoord(0.00781250, 0.11718750, 0.74218750, 0.63281250)
	Frame.Wishlist.Layers[8]:SetWidth(14)
	Frame.Wishlist.Layers[8]:SetHeight(14)
	
	Frame.Wishlist.Layers[9] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[9]:SetPoint("TOPRIGHT", Frame.Wishlist, "TOPRIGHT", 4, -20)
	Frame.Wishlist.Layers[9]:SetVertexColor(0.5, 0.5, 0.5, 1.0)	
	Frame.Wishlist.Layers[9]:SetTexture("Interface\\FrameGeneral\\UI-Frame")
	Frame.Wishlist.Layers[9]:SetTexCoord(0.13281250, 0.21875000, 0.98437500, 0.89843750)
	Frame.Wishlist.Layers[9]:SetWidth(11)
	Frame.Wishlist.Layers[9]:SetHeight(11)
	
	Frame.Wishlist.Layers[10] = Frame.Wishlist:CreateTexture(nil, "BORDER")					
	Frame.Wishlist.Layers[10]:SetPoint("TOPLEFT", Frame.Wishlist.Layers[8], "TOPRIGHT", 0, 0)
	Frame.Wishlist.Layers[10]:SetPoint("TOPRIGHT", Frame.Wishlist.Layers[9], "TOPLEFT", 0, 0)
	Frame.Wishlist.Layers[10]:SetVertexColor(0.5, 0.5, 0.5, 1.0)	
	Frame.Wishlist.Layers[10]:SetTexture("Interface\\FrameGeneral\\_UI-Frame")
	Frame.Wishlist.Layers[10]:SetTexCoord(0.00000000, 1.00000000, 0.27343750, 0.20312500)
	Frame.Wishlist.Layers[10]:SetWidth(256)
	Frame.Wishlist.Layers[10]:SetHeight(9)	
	
	Frame.Wishlist.CloseButton = CreateFrame("Button", "AtlasLootCompareFrame_CloseButton_Wishlist", Frame.Wishlist, "UIPanelCloseButton")
	Frame.Wishlist.CloseButton:SetPoint("TOPRIGHT", Frame.Wishlist, "TOPRIGHT", 7, 2)
	
	Frame.Wishlist.ScrollFrame = CreateFrame("ScrollFrame", "AtlasLootCompareFrame_WishlistScrollFrame", Frame.Wishlist, "FauxScrollFrameTemplate")
	Frame.Wishlist.ScrollFrame:SetPoint("BOTTOM", Frame.Wishlist, "BOTTOM", -15, 0)	
	Frame.Wishlist.ScrollFrame:SetWidth(578)
	Frame.Wishlist.ScrollFrame:SetHeight(371)
	Frame.Wishlist.ScrollFrame:SetScript("OnVerticalScroll", onVerticalScrollWishlistFrame)
	
	Frame.Wishlist.ScrollFrame.Buttons = {}
	
	for i = 1,8 do
		Frame.Wishlist.ScrollFrame.Buttons[i] = CreateFrame("Button", "AtlasLootCompareFrame_WishlistScrollFrame_Button"..i, Frame.Wishlist.ScrollFrame)
		Frame.Wishlist.ScrollFrame.Buttons[i]:SetWidth(575)
		Frame.Wishlist.ScrollFrame.Buttons[i]:SetHeight(46)
		if i == 1 then
			Frame.Wishlist.ScrollFrame.Buttons[i]:SetPoint("TOPLEFT", Frame.Wishlist.ScrollFrame, "TOPLEFT", 0, 0)
		else
			Frame.Wishlist.ScrollFrame.Buttons[i]:SetPoint("TOPLEFT", Frame.Wishlist.ScrollFrame.Buttons[i-1], "BOTTOMLEFT", 0, 0)
		end
		
		Frame.Wishlist.ScrollFrame.Buttons[i].bg = Frame.Wishlist.ScrollFrame.Buttons[i]:CreateTexture(nil, "BACKGROUND")
		Frame.Wishlist.ScrollFrame.Buttons[i].bg:SetWidth(575)
		Frame.Wishlist.ScrollFrame.Buttons[i].bg:SetHeight(49)
		Frame.Wishlist.ScrollFrame.Buttons[i].bg:SetPoint("CENTER", Frame.Wishlist.ScrollFrame.Buttons[i], "CENTER", 4, 0)
		Frame.Wishlist.ScrollFrame.Buttons[i].bg:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures_Tile")
		Frame.Wishlist.ScrollFrame.Buttons[i].bg:SetTexCoord(0.00000000, 1.00000000, 0.74804688, 0.84375000)
		
		Frame.Wishlist.ScrollFrame.Buttons[i].bgicon = Frame.Wishlist.ScrollFrame.Buttons[i]:CreateTexture(nil, "OVERLAY")
		Frame.Wishlist.ScrollFrame.Buttons[i].bgicon:SetPoint("LEFT", Frame.Wishlist.ScrollFrame.Buttons[i], "LEFT", 3.5, 0)
		Frame.Wishlist.ScrollFrame.Buttons[i].bgicon:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
		Frame.Wishlist.ScrollFrame.Buttons[i].bgicon:SetHeight(35)
		Frame.Wishlist.ScrollFrame.Buttons[i].bgicon:SetWidth(35)
		Frame.Wishlist.ScrollFrame.Buttons[i].bgicon:SetTexCoord(0.89843750, 0.97265625, 0.21386719, 0.25097656)
		
		Frame.Wishlist.ScrollFrame.Buttons[i].icon = Frame.Wishlist.ScrollFrame.Buttons[i]:CreateTexture(nil, "OVERLAY")
		Frame.Wishlist.ScrollFrame.Buttons[i].icon:SetPoint("TOPLEFT", Frame.Wishlist.ScrollFrame.Buttons[i].bgicon, "TOPLEFT", 1, -2)
		Frame.Wishlist.ScrollFrame.Buttons[i].icon:SetPoint("BOTTOMRIGHT", Frame.Wishlist.ScrollFrame.Buttons[i].bgicon, "BOTTOMRIGHT", -1, 1)
		Frame.Wishlist.ScrollFrame.Buttons[i].icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		Frame.Wishlist.ScrollFrame.Buttons[i].icon:SetHeight(38)
		Frame.Wishlist.ScrollFrame.Buttons[i].icon:SetWidth(38)
		
		Frame.Wishlist.ScrollFrame.Buttons[i].name = Frame.Wishlist.ScrollFrame.Buttons[i]:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		Frame.Wishlist.ScrollFrame.Buttons[i].name:SetPoint("TOPLEFT", Frame.Wishlist.ScrollFrame.Buttons[i].icon, "TOPRIGHT", 10, 0)
		Frame.Wishlist.ScrollFrame.Buttons[i].name:SetJustifyH("LEFT")
		Frame.Wishlist.ScrollFrame.Buttons[i].name:SetText("NAME")
		Frame.Wishlist.ScrollFrame.Buttons[i].name:SetHeight(12)
		Frame.Wishlist.ScrollFrame.Buttons[i].name:SetWidth(460)
		Frame.Wishlist.ScrollFrame.Buttons[i].name:SetTextColor(0.96875, 0.8984375, 0.578125)
		
		Frame.Wishlist.ScrollFrame.Buttons[i].desc = Frame.Wishlist.ScrollFrame.Buttons[i]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		Frame.Wishlist.ScrollFrame.Buttons[i].desc:SetPoint("TOPLEFT", Frame.Wishlist.ScrollFrame.Buttons[i].name, "BOTTOMLEFT", 0, -7)
		Frame.Wishlist.ScrollFrame.Buttons[i].desc:SetJustifyH("LEFT")
		Frame.Wishlist.ScrollFrame.Buttons[i].desc:SetText("DESC")
		Frame.Wishlist.ScrollFrame.Buttons[i].desc:SetWidth(460)
		Frame.Wishlist.ScrollFrame.Buttons[i].desc:SetTextColor(0.66796875, 0.51171875, 0.3359375)
		
		Frame.Wishlist.ScrollFrame.Buttons[i].type = Frame.Wishlist.ScrollFrame.Buttons[i]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		Frame.Wishlist.ScrollFrame.Buttons[i].type:SetPoint("RIGHT", Frame.Wishlist.ScrollFrame.Buttons[i], "RIGHT", -14, 0)
		Frame.Wishlist.ScrollFrame.Buttons[i].type:SetJustifyH("RIGHT")
		Frame.Wishlist.ScrollFrame.Buttons[i].type:SetText("TYPE")
		Frame.Wishlist.ScrollFrame.Buttons[i].type:SetWidth(460)
		Frame.Wishlist.ScrollFrame.Buttons[i].type:SetTextColor(0.66796875, 0.51171875, 0.3359375)
		
		local normalTexture = Frame.Wishlist.ScrollFrame.Buttons[i]:CreateTexture(nil, "BACKGROUND")
		normalTexture:SetWidth(575)
		normalTexture:SetHeight(49)
		normalTexture:SetPoint("CENTER", Frame.Wishlist.ScrollFrame.Buttons[i], "CENTER", 4, 0)
		normalTexture:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures_Tile")
		normalTexture:SetTexCoord(0.00000000, 1.00000000, 0.74804688, 0.84375000)
		
		local highlightTexture = Frame.Wishlist.ScrollFrame.Buttons[i]:CreateTexture(nil, "BACKGROUND")
		highlightTexture:SetWidth(575)
		highlightTexture:SetHeight(47)
		highlightTexture:SetPoint("CENTER", Frame.Wishlist.ScrollFrame.Buttons[i], "CENTER", 0, 0)
		highlightTexture:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
		highlightTexture:SetTexCoord(0.00195313, 0.50195313, 0.74023438, 0.78613281)
		
		--Frame.Wishlist.ScrollFrame.Buttons[i]:SetTexture(normalTexture)
		Frame.Wishlist.ScrollFrame.Buttons[i]:SetNormalTexture(normalTexture)
		Frame.Wishlist.ScrollFrame.Buttons[i]:SetPushedTexture(normalTexture)
		Frame.Wishlist.ScrollFrame.Buttons[i]:SetHighlightTexture(highlightTexture)
		
		Frame.Wishlist.ScrollFrame.Buttons[i]:SetScript("OnClick", WishList.CompareFrame_Item_OnClick)
		
		Frame.Wishlist.ScrollFrame.Buttons[i]:Hide()
	end

	Frame.Wishlist.Layers[11] = Frame.Wishlist.ScrollFrame:CreateTexture(nil, "BACKGROUND")
	Frame.Wishlist.Layers[11]:SetPoint("TOPLEFT", Frame.Wishlist.ScrollFrame, "TOPRIGHT", 4, 5)	
	Frame.Wishlist.Layers[11]:SetWidth(20)
	Frame.Wishlist.Layers[11]:SetHeight(378)
	Frame.Wishlist.Layers[11]:SetTexture(0.0, 0.0, 0.0, 0.85)
	
	Frame.Wishlist.Layers[12] = Frame.Wishlist.ScrollFrame:CreateTexture(nil, "ARTWORK")
	Frame.Wishlist.Layers[12]:SetPoint("TOPLEFT", Frame.Wishlist.ScrollFrame, "TOPRIGHT", -2, 5)	
	Frame.Wishlist.Layers[12]:SetWidth(31)
	Frame.Wishlist.Layers[12]:SetHeight(266)
	Frame.Wishlist.Layers[12]:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	Frame.Wishlist.Layers[12]:SetTexCoord(0, 0.484375, 0, 1.0)
	
	Frame.Wishlist.Layers[13] = Frame.Wishlist.ScrollFrame:CreateTexture(nil, "ARTWORK")
	Frame.Wishlist.Layers[13]:SetPoint("BOTTOMLEFT", Frame.Wishlist.ScrollFrame, "BOTTOMRIGHT", -2, -2)	
	Frame.Wishlist.Layers[13]:SetWidth(31)
	Frame.Wishlist.Layers[13]:SetHeight(115)
	Frame.Wishlist.Layers[13]:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	Frame.Wishlist.Layers[13]:SetTexCoord(0.515625, 1.0, 0, 0.4140625)
	
	Frame.Wishlist:SetScript("OnShow", function(self)
		self:SetFrameLevel(self:GetFrameLevel()+10);
		
	end)
	Frame.Wishlist:Hide()
	
	Frame.Wishlist.DropDown = CreateFrame("Frame", "AtlasLootCompareFrame_WishlistDropDown", Frame.Wishlist, "UIDropDownMenuTemplate")
	Frame.Wishlist.DropDown:SetPoint("TOPLEFT", Frame.Wishlist, "TOPLEFT", -17, 0)
	Frame.Wishlist.DropDown.info = {}
	
	-- Wishlist frame
	-- ###########################################
	Frame.WishlistButton = CreateFrame("Button","AtlasLootCompareFrame_WishlistButton",Frame,"UIPanelButtonTemplate")
	Frame.WishlistButton:SetText(AL["Wishlist"])
	Frame.WishlistButton:SetWidth(160)
	Frame.WishlistButton:SetHeight(22)
	Frame.WishlistButton:SetPoint("RIGHT", Frame.Close2, "LEFT", 0, 0)
	Frame.WishlistButton:SetScript("OnClick", wishlistButtonOnClick)
	
	WishList:CompareFrame_DropDownRefresh()
end


-- Compare Frame
-- #####################################################
