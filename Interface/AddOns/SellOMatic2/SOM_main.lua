SellOMatic = LibStub("AceAddon-3.0"):NewAddon("SellOMatic", "AceEvent-3.0", "AceConsole-3.0")
local SellOMatic = _G.SellOMatic
local L = LibStub("AceLocale-3.0"):GetLocale("SellOMatic")

local function getOption(info)
	return (info.arg and SellOMatic.db.profile[info.arg] or SellOMatic.db.profile[info[#info]])
end

local function setOption(info, value)
	local key = info.arg or info[#info]
	SellOMatic.db.profile[key] = value
end

local options = {
	name = "Sell-O-Matic",
	handler = SellOMatic,
	type = "group",
	args = {
		general = {
			type = "group",
			name = L["General Options"],
			guiInline = true,
			args = {
				autoSell = {
					name = L["Auto sell"],
					desc = L["Toggles ON/OFF automatic mode"],
					order = 1,
					type = "toggle",
					get = getOption,
					set = setOption,
				},
				showFullInfo = {
					name = L["Information type"],
					desc = L["Choose the amount of information displayed"],
					order = 2,
					type = "select",
					values = {
						["1-FULL"] = L["FULL"],
						["2-LITE"] = L["LITE"],
					},
					style = "dropdown",
					get = getOption,
					set = setOption,
				},
				preview = {
					name = L["Preview"],
					desc = L["Toggles ON/OFF preview before sell"],
					order = 3,
					type = "toggle",
					get = getOption,
					set = setOption,
				},
				preview_space = {
					name = L["Preview CR"],
					desc = L["Toggles ON/OFF the carriage return at the end of the list"],
					order = 4,
					type = "toggle",
					get = getOption,
					set = setOption,
				},
			},
		},
		showlist = {
			name = "showlist",
			hidden = true,
			type = "execute",
			func = "ShowSOMList",
		},
		destroy = {
			name = "destroy",
			hidden = true,
			type = "input",
			set = "CallDestroyJunk",
			get = false,
		},
		dump = {
			name = "dump",
			hidden = true,
			type = "execute",
			func = "DumpVars",
		},
		addItem = {
			name = "addItem",
			hidden = true,
			type = "execute",
			func = "CallAddItem",
		},
		delItem = {
			name = "delItem",
			hidden = true,
			type = "execute",
			func = "CallDelItem",
		},
		resetlist = {
			name = "resetList",
			hidden = true,
			type = "execute",
			func = "CallResetList",
		},
		help = {
			name = "help",
			hidden = true,
			type = "execute",
			func = "ShowHelp",
		},
--[===[@debug@
		run = {
			name = "run",
			hidden = true,
			type = "execute",
			func = "RunDebugFunction",
		},
--@end-debug@]===]
	},
}

local defaults = {
	profile = {
		-- CORE
		autoSell = true,
		preview = false,
		preview_space = true,
		showFullInfo = "2-LITE",
		-- ITEM
		item_allowWhite = false,
		item_allowGreen = false,
		item_allowBlue = false,
		item_allowEpic = false,
		item_allowBoP = false,
		item_allowBoE = false,
		item_iLevelValue = 1,
		item_useILevel = false,
		-- LIST
		sellList = {},
		saveList = {},
		caseSensitiveList = false,
		list_allowBoP = false,
		list_allowBoE = false,
		list_allowWhite = false,
		list_allowGreen = false,
		list_allowBlue = false,
		list_allowEpic = false,
		list_useILevel = false,
		list_iLevelValue = 1,
		-- DESTROY
		destroy_warning = true,
		-- CLASS
		class_filter_strict = false,
	},
}

local command_list = {
	name = L["Command List"],
	type = "group",
	args = {
		command_header = {
			name = "Sell-O-Matic Command List",
			type = "header",
			order = 1,
		},
		command_description = {
			name = "|cffffd700/som|r".." "..L["display the addon options"]..".".."|n"..
					"|cffffd700/som help|r".." "..L["display these commands"]..".".."|n"..
					"|cffffd700/som showlist|r".." "..L["display the contents of the sell and save lists"]..".".."|n"..
					"|cffffd700/som additem|r".." "..L["add items to the sell/save lists"]..".".."|n"..
					"|cffffd700/som delitem|r".." "..L["delete items from the sell/save lists"]..".".."|n"..
					"|cffffd700/som resetlist|r".." "..L["resets the save/sell list"]..".".."|n"..
					"|cffffd700/som destroy|r".." "..L["destroy all junk items in your backpack"]..".".."|n"..
					"|cffffd700/som destroy x|r".. " "..L["destroy x junk items, where x is the number of items to destroy"]..".",
			type = "description",
			fontSize = "medium",
			order = 2,
		},
	},
}

local modules = { destroy = 1, list = 1, item = 1 , class = 1 }
-- item_container: Name, Link, Rarity, Level, Price
local shopping_list, SOMNone, SOMPreview, duplicates, check_preview, cash_flow, init_cash, merchant
local _, bag, slot, name, itemName, itemLink, itemRarity, itemSellPrice, itemStackCount, itemLevel

function SellOMatic:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SellOMatic2DB", defaults, "Default")
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SellOMatic", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SellOMatic", "Sell-O-Matic")
	local SOM_List = LoadAddOn("SellOMatic2_List")
	if not SOM_List then modules.list = 0 end
	local SOM_Item = LoadAddOn("SellOMatic2_Item")
	if not SOM_Item then modules.item = 0 end
	local SOM_Destroy = LoadAddOn("SellOMatic2_Destroy")
	if not SOM_Destroy then modules.destroy = 0 end
--	local SOM_Class = LoadAddOn("SellOMatic2_Class")
	if not SOM_Class then modules.class = 0 end
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SellOMatic_Command", command_list)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SellOMatic_Command", L["Command List"], "Sell-O-Matic")
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(L["Profile Options"], profiles)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["Profile Options"], L["Profile Options"], "Sell-O-Matic")
	self:RegisterChatCommand("sellomatic", "ChatCommand")
	self:RegisterChatCommand("som", "ChatCommand")
	SellOMatic:Create_SOMNone()
	SellOMatic:CreatePreviewFrame()
end

function SellOMatic:OnEnable()
	self:RegisterEvent("MERCHANT_SHOW")
	self:RegisterEvent("MERCHANT_CLOSED")
	SellButton:Hide()
	shopping_list = {}
	merchant = false
	if MerchantFrame:IsShown() then SellOMatic:MERCHANT_SHOW() end
end

function SellOMatic:ChatCommand(input)
	if not input or input:trim() == "" then
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(SellOMatic, "sellomatic", "SellOMatic", input)
	end
end

function SellOMatic:MERCHANT_SHOW()
	merchant = true
	SellButton:Show()
	if modules.list == 1 then SellOMatic:ShowButtonFrame() end
	if modules.class == 1 then SellOMatic:CheckVariables() end
	SellOMatic:Scan()
	if #shopping_list == 0 then SOMNone:Show() end
	init_cash = GetMoney()
	if SellOMatic.db.profile.autoSell then
		if SellOMatic.db.profile.showFullInfo == "1-FULL" then SellOMatic:Print("-- "..L["Autoselling"].." --") end
		SellOMatic:Sell()
	end
end

function SellOMatic:MERCHANT_CLOSED()
	if merchant == true then
		merchant = false
		SellButton:Hide()
		if modules.list == 1 then SellOMatic:HideButtonFrame() end
		check_preview = 0
		SOMNone:Hide()
		SellOMatic:Clean_Shopping_List()
	end
end

function SellOMatic:Sell()
	if #shopping_list ~= 0 then
		if SellOMatic.db.profile.preview and check_preview ~= 1 then
			SellOMatic:Print_Shopping_List()
			SOMPreview:Show()
		else
			SellOMatic:Sell_Shopping_List()
			SOMNone:Show()
			SellOMatic:Clean_Shopping_List()
		end
	end
end

function SellOMatic:Scan()
	SellOMatic:Scan_Junk()
	if modules.item == 1 then SellOMatic:Scan_Item() end
	if modules.class == 1 then SellOMatic:Scan_Class() end
	if modules.list == 1 then SellOMatic:Scan_List() end
	SellOMatic:Check_Shopping_List()
end

function SellOMatic:Scan_Junk()
	for bag = 0,NUM_BAG_SLOTS,1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			name = GetContainerItemLink(bag,slot)
			if name ~= nil then
				itemName, itemLink, itemRarity, itemLevel, _, _, _, itemStackCount, _, _, itemSellPrice = GetItemInfo(name)
				if itemRarity == 0 then
					if itemStackCount > 1 then
						itemSellPrice = itemSellPrice * GetItemCount(itemName)
					end
					SellOMatic:Add_Shopping_List(itemName,itemLink,itemRarity,itemLevel,itemSellPrice)
				end
			end
		end
	end
end

function SellOMatic:Sell_Shopping_List()
	local i
	local num = 0
	local profit = SellOMatic:ShowProfit()
	if SellOMatic:CheckMerchant() then
		for bag = 0,NUM_BAG_SLOTS,1 do
			for slot = 1, GetContainerNumSlots(bag), 1 do
				name = GetContainerItemLink(bag,slot)
				if name ~= nil then
					itemName, itemLink, itemRarity = GetItemInfo(name)
					for i = 1, #shopping_list, 1 do
						if shopping_list[i][1] == itemName and shopping_list[i][3] == itemRarity then
							if not CursorHasItem() then
								-- Sell item
								UseContainerItem(bag,slot)
								if self.db.profile.showFullInfo == "1-FULL" then SellOMatic:Print(L["Selling"]..": "..itemLink) end
								num = num + 1
							end
						end
					end
				end
			end
		end
		if self.db.profile.showFullInfo == "1-FULL" then
			SellOMatic:Print(num.." "..L["item(s) sold"])
			cash_flow = GetMoney() - init_cash
			if cash_flow > profit then
				profit = cash_flow
			end
			SellOMatic:Print(L["You've earned"]..": "..GetCoinText(profit," "))
		else
			SellOMatic:Print(num.." "..L["item(s) sold for"].." "..GetCoinTextureString(profit))
		end
	end
end

function SellOMatic:Add_Shopping_List(name,link,rarity,level,price)
	shopping_list[#shopping_list+1] = { name,link,rarity,level,price }
end

function SellOMatic:Del_Shopping_List(index)
	table.remove(shopping_list, index)
end

function SellOMatic:Get_Shopping_List()
	return shopping_list
end

function SellOMatic:Print_Shopping_List()
	local x
	SellOMatic:Print("# "..L["List of items to sell"].." #")
	for x=1, #shopping_list, 1 do
		print(shopping_list[x][2])
	end
	if self.db.profile.preview_space then print(" ") end
end

function SellOMatic:Check_Shopping_List()
	SellOMatic:RemoveClones()
	SellOMatic:RemoveZeros()
end

function SellOMatic:RemoveClones()
	local x,found
	for x=1, #shopping_list-1, 1 do
		found = SellOMatic:CheckClones()
		if found ~= 0 then
			SellOMatic:Del_Shopping_List(found)
		end
	end
end

function SellOMatic:CheckClones()
	local x,y
	local found = 0
	for x=1, #shopping_list-1, 1 do
		for y=x+1, #shopping_list, 1 do
			if shopping_list[x][1] == shopping_list[y][1] then
				found = y
			end
		end
	end
	return found
end

function SellOMatic:RemoveZeros()
	local x
	local count = 0
	local list = SellOMatic:Get_Shopping_List()
	local items = {}
	for x=1, #list, 1 do
		table.insert(items,list[x][5])
	end
	for x=1, #items, 1 do
		if items[x] == 0 then
			SellOMatic:Del_Shopping_List(x-count)
			count = count + 1
		end
	end
end

function SellOMatic:ShowProfit()
	local profit = 0
	local x
	for x=1, #shopping_list, 1 do
		profit = profit + shopping_list[x][5]
	end
	return profit
end

function SellOMatic:Clean_Shopping_List()
	shopping_list = {}
end

function SellOMatic:CheckMerchant()
	local items = GetMerchantNumItems()
	if merchant and items > 0 then
		return true
	else
		return false
	end
end

function SellOMatic:Create_SOMNone()
	SOMNone = CreateFrame("Frame","SOMNone",SellButton)
	SOMNone:ClearAllPoints()
	SOMNone:SetPoint("TOPRIGHT",SellButton,"TOPRIGHT",0,0)
	SOMNone:SetHeight(30)
	SOMNone:SetWidth(30)
	SOMNone.texture = SOMNone:CreateTexture()
	SOMNone.texture:SetAllPoints(SOMNone)
	SOMNone.texture:SetTexture(0.3,0.3,0.3,0.7)
	SOMNone:Hide()
end

function SellOMatic:SOMButtonTooltip_Show()
	GameTooltip_SetDefaultAnchor(GameTooltip,SellButton)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPLEFT",SellButton,"TOPRIGHT",-30,40)
	GameTooltip:SetText(GetCoinTextureString(SellOMatic:ShowProfit()),1,1,1)
	GameTooltip:Show()
end

function SellOMatic:SOMButtonTooltip_Hide()
	GameTooltip:Hide()
end

function SellOMatic:CreatePreviewFrame()
	SOMPreview = CreateFrame("Frame","SOMPreview",UIParent)
	SOMPreview:ClearAllPoints()
	SOMPreview:SetPoint("CENTER",UIParent,"TOP",0,-200)
	SOMPreview:SetHeight(90)
	SOMPreview:SetWidth(400)
	SOMPreview:SetFrameStrata("FULLSCREEN_DIALOG")
	SOMPreview:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true,
		insets = { left = 10, right = 10, top = 10, bottom = 10 }
	})
	SOMPreview:SetBackdropBorderColor(1.0,1.0,1.0)
	SOMPreview:SetBackdropColor(0.1,0.1,0.1)
	SOMPreview.Text = SOMPreview:CreateFontString(nil,"OVERLAY","GameFontNormal")
	SOMPreview.Text:SetPoint("CENTER",SOMPreview,"TOP",0,-30)
	SOMPreview.Text:SetText(L["Do you want to sell the item(s) showed in the chat frame?"])
	SOMPreview.YesButton = CreateFrame("Button",nil,SOMPreview,"OptionsButtonTemplate")
	SOMPreview.YesButton:SetPoint("CENTER",SOMPreview,"BOTTOM",-50,30)
	SOMPreview.YesButton:SetScript("OnClick", function()
		check_preview = 1
		SellOMatic:Sell()
		SOMPreview:Hide()
	end)
	SOMPreview.YesButton:SetText(L["Yes"])
	SOMPreview.NoButton = CreateFrame("Button",nil,SOMPreview,"OptionsButtonTemplate")
	SOMPreview.NoButton:SetPoint("CENTER",SOMPreview,"BOTTOM",50,30)
	SOMPreview.NoButton:SetScript("OnClick", function()
		SOMPreview:Hide()
	end)
	SOMPreview.NoButton:SetText(L["No"])
	SOMPreview:Hide()
end

function SellOMatic:CallDestroyJunk(x,arg1)
	if modules.destroy == 1 then
		if arg1 ~= nil and arg1 ~= "" then
			SellOMatic:ScanXJunk(arg1)
		else
			SellOMatic:DestroyJunk()
		end
	end
end

function SellOMatic:ShowSOMList()
	if modules.list == 1 then
		SellOMatic:ShowList()
	end
end

function SellOMatic:CallAddItem()
	if modules.list == 1 then
		SellOMatic:AddItem()
	end
end

function SellOMatic:CallDelItem()
	if modules.list == 1 then
		SellOMatic:DelItem()
	end
end

function SellOMatic:CallResetList()
	if modules.list == 1 then
		SellOMatic:ResetList()
	end
end

function SellOMatic:EmptyList(list)
	if list == "sell" then
		SellOMatic.db.profile.sellList = {}
		SellOMatic:Print(L["Sell List"].." "..L["has been reset"]..".")
	end
	if list == "save" then
		SellOMatic.db.profile.saveList = {}
		SellOMatic:Print(L["Save List"].." "..L["has been reset"]..".")
	end
end

function SellOMatic:ShowHelp()
	SellOMatic:Print(L["Command List"])
	print("|cffffd700/som|r".." "..L["display the addon options"])
	print("|cffffd700/som help|r".." "..L["display these commands"])
	print("|cffffd700/som showlist|r".." "..L["display the contents of the sell and save lists"])
	print("|cffffd700/som additem|r".." "..L["add items to the sell/save lists"])
	print("|cffffd700/som delitem|r".." "..L["delete items from the sell/save lists"])
	print("|cffffd700/som resetlist|r".." "..L["resets the save/sell list"])
	print("|cffffd700/som destroy|r".." "..L["destroy all junk items in your backpack"])
	print("|cffffd700/som destroy x|r".. " "..L["destroy x junk items, where x is the number of items to destroy"])
end

-- Debug functions
--[===[@debug@
function SellOMatic:DumpVars()
	SlashCmdList["DUMP"]("SellOMatic.db.profile")
end

function SellOMatic:Show_Shopping_List()
	local i
	for i=1,#shopping_list,1 do
		self:Print("["..i.."] "..shopping_list[i][2].." "..shopping_list[i][5])
	end
end

function SellOMatic:RunDebugFunction()
	SellOMatic:Print("## Run Debug Function ##")
	-- Load_Equipment()
	-- if next(equipment_items) ~= nil then
		-- for i = 1,#equipment_items,1 do
			-- SellOMatic:Print("["..i.."] "..equipment_items[i])
		-- end
	-- end
	SellOMatic:Print(GetMerchantNumItems())
	SellOMatic:Print("")
end
--@end-debug@]===]