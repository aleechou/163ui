SellOMatic_List = LibStub("AceAddon-3.0"):NewAddon("SellOMatic_List", "AceEvent-3.0", "AceConsole-3.0");
local SellOMatic = _G.SellOMatic
local item_tooltip = LibStub("LibGratuity-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("SellOMatic");

local function getOption(info)
	return (info.arg and SellOMatic.db.profile[info.arg] or SellOMatic.db.profile[info[#info]]);
end;

local function setOption(info, value)
	local key = info.arg or info[#info];
	SellOMatic.db.profile[key] = value;
end;

local list_options = {
	type = "group",
	name = L["List Options"],
	args = {
		list_allowBoP = {
			name = L["Sell BoP"],
			desc = L["Toggles ON/OFF selling soulbound items"],
			order = 1,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		list_allowBoE = {
			name = L["Sell BoE"],
			desc = L["Toggles ON/OFF selling bind on equip items"],
			order = 2,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		list_allowWhite = {
			name = L["Sell white"],
			desc = L["Toggles ON/OFF selling white quality items"],
			order = 3,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		list_allowGreen = {
			name = L["Sell green"],
			desc = L["Toggles ON/OFF selling green quality items"],
			order = 4,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		list_allowBlue = {
			name = L["Sell blue"],
			desc = L["Toggles ON/OFF selling blue quality items"],
			order = 5,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		list_allowEpic = {
			name = L["Sell epic"],
			desc = L["Toggles ON/OFF selling epic quality items"],
			order = 6,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		list_useILevel = {
			name = L["Use iLevel"],
			desc = L["Toggles ON/OFF selling items by iLevel"],
			order = 7,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		list_iLevelValue = {
			name = L["iLevel value"],
			desc = L["Items below the iLevel value set will be sold"],
			order = 8,
			type = "range",
			min = 1,
			max = 353,
			step = 1,
			get = getOption,
			set = setOption,
		},
		exactMatch = {
			name = L["Exact match"],
			desc = L["Toggles ON/OFF exact match comparing list"],
			order = 9,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		list_header = {
			name = L["List Commands"],
			type = "header",
			order = 10,
		},
		list_commands = {
			name = "|cffffd700/som showlist|r".." "..L["display the contents of the sell and save lists"]..".".."|n"..
					"|cffffd700/som additem|r".." "..L["add items to the sell/save lists"]..".".."|n"..
					"|cffffd700/som delitem|r".." "..L["delete items from the sell/save lists"]..".".."|n"..
					"|cffffd700/som resetlist|r".." "..L["resets the save/sell list"]..".",
			type = "description",
			fontSize = "medium",
			order = 11,
		},
	},
}

local frame_type;

function SellOMatic_List:OnInitialize()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SellOMatic_List", list_options);
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SellOMatic_List", L["List Options"], "Sell-O-Matic");
end;

function SellOMatic:Scan_List()
	SellOMatic_List:Check_SellList();
	SellOMatic_List:Check_SaveList();
end;

function SellOMatic_List:Check_SellList()
	local bag, slot, name, itemName, itemLink, itemRarity, itemLevel, itemSellPrice, itemStackCount, add, _
	for bag = 0,NUM_BAG_SLOTS,1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			add = 0;
			name = GetContainerItemLink(bag,slot);
			if name ~= nil and string.find(name, "Hitem") ~= nil then
				itemName, itemLink, itemRarity, itemLevel, _, _, _, itemStackCount, _, _, itemSellPrice = GetItemInfo(name);
				item_tooltip:SetBagItem(bag,slot);
				if itemRarity == 1 and SellOMatic.db.profile.list_allowWhite then
					if SellOMatic_List:Check_Item(SellOMatic.db.profile.sellList,itemName) == 1 then
						add = 1;
					end;
				elseif itemRarity > 1 and item_tooltip:Find(ITEM_BIND_ON_EQUIP,1,3) and SellOMatic.db.profile.list_allowBoE or item_tooltip:Find(ITEM_SOULBOUND,1,3) and SellOMatic.db.profile.list_allowBoP then
					if itemRarity == 2 and SellOMatic.db.profile.list_allowGreen then
						if SellOMatic_List:Check_Item(SellOMatic.db.profile.sellList,itemName) == 1 then add = 1; end;
					elseif itemRarity == 3 and SellOMatic.db.profile.list_allowBlue then
						if SellOMatic_List:Check_Item(SellOMatic.db.profile.sellList,itemName) == 1 then add = 1; end;
					elseif itemRarity == 4 and SellOMatic.db.profile.list_allowEpic then
						if SellOMatic_List:Check_Item(SellOMatic.db.profile.sellList,itemName) == 1 then add = 1; end;
					end;
				elseif itemRarity > 1 and not item_tooltip:Find(ITEM_BIND_ON_EQUIP,1,3) and not item_tooltip:Find(ITEM_SOULBOUND,1,3) then
					if itemRarity == 2 and SellOMatic.db.profile.list_allowGreen then
						if SellOMatic_List:Check_Item(SellOMatic.db.profile.sellList,itemName) == 1 then add = 1; end;
					elseif itemRarity == 3 and SellOMatic.db.profile.list_allowBlue then
						if SellOMatic_List:Check_Item(SellOMatic.db.profile.sellList,itemName) == 1 then add = 1; end;
					elseif itemRarity == 4 and SellOMatic.db.profile.list_allowEpic then
						if SellOMatic_List:Check_Item(SellOMatic.db.profile.sellList,itemName) == 1 then add = 1; end;
					end;
				end;
				if add == 1 and SellOMatic.db.profile.list_useILevel then
					if itemLevel > SellOMatic.db.profile.list_iLevelValue then add = 0 end;
				end;
				if add == 1 then
					if itemStackCount > 1 then
						itemSellPrice = itemSellPrice * GetItemCount(itemName);
					end;
					SellOMatic:Add_Shopping_List(itemName, itemLink, itemRarity, itemLevel, itemSellPrice);
				end;
			end;
		end;
	end;
end;

function SellOMatic_List:Check_SaveList()
	if SellOMatic.db.profile.saveList[1] ~= nil then
		local list = SellOMatic:Get_Shopping_List();
		local items = {};
		local i,j;
		for i=1, #list, 1 do
			table.insert(items,list[i][1]);
		end;
		for i=1, #list, 1 do
			for j=1, #SellOMatic.db.profile.saveList, 1 do
				if string.find(SellOMatic.db.profile.saveList[j],items[i]) or SellOMatic.db.profile.saveList[j] == items[i] then
					SellOMatic_List:Del_From_Shopping_List(items[i]);
				end;
			end;
		end;
	end;
end;

function SellOMatic_List:Del_From_Shopping_List(item)
	local list = SellOMatic:Get_Shopping_List();
	local i;
	local items = {};
	for i=1, #list, 1 do table.insert(items,list[i][1]); end;
	for i=1, #list, 1 do
		if string.find(items[i],item) or items[i] == item then
			SellOMatic:Del_Shopping_List(i);
		end;
	end;
end;

function SellOMatic_List:Check_Item(list,item)
	local name,i;
	if list[1] ~= nil then
		for i=1, #list, 1 do
			name = list[i];
			if SellOMatic.db.profile.exactMatch then
				if item == name then
					return 1,i;
				end;
			else
				if string.find(item,name) or item == name then
					return 1,i;
				end;
			end;
		end;
	end;
	return 0;
end;

function SellOMatic:ShowList()
	SellOMatic_List:ShowList(SellOMatic.db.profile.sellList,"sell list");
	SellOMatic_List:ShowList(SellOMatic.db.profile.saveList,"save list");
end;

function SellOMatic_List:ShowList(list,list_type)
	if list[1]~= nil then
		SellOMatic:Print("#### "..list_type.." ####");
		for i,v in ipairs(list) do
			SellOMatic:Print("["..i.."] "..v);
		end;
	else
		SellOMatic:Print(list_type.." "..L["empty"]);
	end;
end;

function SellOMatic:AddItemTest(a,item)
	SellOMatic_List:Add_To_List(SellOMatic.db.profile.sellList,"sell list",item);
end;

function SellOMatic_List:Add_To_List(list,list_type,item)
	if item ~= nil and string.len(item) > 0 then
		if SellOMatic_List:Check_Item(list,item) == 0 then
			table.insert(list,item);
			SellOMatic:Print(item.." "..L["added to"].." "..list_type);
		else
			SellOMatic:Print(item.." "..L["already on"].." "..list_type);
		end;
	end;
end;

function SellOMatic_List:Del_From_List(list,list_type,item)
	if item ~= nil and string.len(item) > 0 then
		local found,i = SellOMatic_List:Check_Item(list,item);
		local num = 0;
		while found > 0 do
			table.remove(list,i);
			found,i = SellOMatic_List:Check_Item(list,item);
			num = num + 1;
		end;
		if num > 0 then
			SellOMatic:Print(item.." "..L["removed from"].." "..list_type);
		else
			SellOMatic:Print(item.." "..L["not found on"].." "..list_type);
		end;
	end;
end;

function SellOMatic:AddItem()
	frame_type = "add";
	SellOMatic:RegisterEvent("MODIFIER_STATE_CHANGED");
	SellOMatic:ShowAddFrame();
end;

function SellOMatic:DelItem()
	frame_type = "del";
	SellOMatic:RegisterEvent("MODIFIER_STATE_CHANGED");
	SellOMatic:ShowDelFrame();
end;

function SellOMatic:ResetList()
	SellOMatic:ShowResetFrame()
end;

function SellOMatic:MODIFIER_STATE_CHANGED()
	local bag,slot,itemName;
	if IsAltKeyDown() then
		bag,slot = SellOMatic_List:FindItem(GameTooltipTextLeft1:GetText());
		if bag > -1 then
			itemName = GetItemInfo(GetContainerItemLink(bag,slot));
			if frame_type == "add" then
				-- Add item to sell list
				SellOMatic_List:Add_To_List(SellOMatic.db.profile.sellList,L["sell list"],itemName);
			elseif frame_type == "del" then
				-- Find & Remove Item from sell list
				SellOMatic_List:Del_From_List(SellOMatic.db.profile.sellList,L["sell list"],itemName);
			end;
		else
			SellOMatic:Print(L["The item must be in your inventory"]);
		end;
	elseif IsControlKeyDown() then
		bag,slot = SellOMatic_List:FindItem(GameTooltipTextLeft1:GetText());
		if bag > -1 then
			itemName = GetItemInfo(GetContainerItemLink(bag,slot));
			if frame_type == "add" then
				-- Add item to save list
				SellOMatic_List:Add_To_List(SellOMatic.db.profile.saveList,L["save list"],itemName);
			elseif frame_type == "del" then
				-- Find & Remove Item from save list
				SellOMatic_List:Del_From_List(SellOMatic.db.profile.saveList,L["save list"],itemName);
			end;
		end;
	end;
end;

function SellOMatic_List:FindItem(item)
	local bag,slot,name,itemName;
	local f_bag = -1;
	local f_slot = -1;
	for bag = 0,NUM_BAG_SLOTS,1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			name = GetContainerItemLink(bag,slot);
			if name ~= nil and string.find(name, "Hitem") ~= nil then
				itemName = GetItemInfo(name);
				if item == itemName then
					f_bag = bag;
					f_slot = slot;
				end;
			end;
		end;
	end;
	return f_bag,f_slot;
end;
