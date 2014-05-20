SellOMatic_Item = LibStub("AceAddon-3.0"):NewAddon("SellOMatic_Item", "AceEvent-3.0", "AceConsole-3.0");
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

local item_options = {
	type = "group",
	name = L["Item Options"],
	args = {
		item_allowBoP = {
			name = L["Sell BoP"],
			desc = L["Toggles ON/OFF selling soulbound items"],
			order = 1,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		item_allowBoE = {
			name = L["Sell BoE"],
			desc = L["Toggles ON/OFF selling bind on equip items"],
			order = 2,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		item_allowWhite = {
			name = L["Sell white"],
			desc = L["Toggles ON/OFF selling white quality items"],
			order = 3,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		item_allowGreen = {
			name = L["Sell green"],
			desc = L["Toggles ON/OFF selling green quality items"],
			order = 4,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		item_allowBlue = {
			name = L["Sell blue"],
			desc = L["Toggles ON/OFF selling blue quality items"],
			order = 5,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		item_allowEpic = {
			name = L["Sell epic"],
			desc = L["Toggles ON/OFF selling epic quality items"],
			order = 6,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		item_useILevel = {
			name = L["Use iLevel"],
			desc = L["Toggles ON/OFF selling items by iLevel"],
			order = 8,
			type = "toggle",
			get = getOption,
			set = setOption,
		},
		item_iLevelValue = {
			name = L["iLevel value"],
			desc = L["Items below the iLevel value set will be sold"],
			order = 9,
			type = "range",
			min = 1,
			max = 353,
			step = 1,
			get = getOption,
			set = setOption,
		},
	},
}

function SellOMatic_Item:OnInitialize()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SellOMatic_Item", item_options);
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SellOMatic_Item", L["Item Options"], "Sell-O-Matic");
end;

function SellOMatic:Scan_Item()
	local bag, slot, name, itemName, itemLink, itemRarity, itemLevel, itemSellPrice, itemStackCount, add, _
	for bag = 0,4,1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			add = 0;
			name = GetContainerItemLink(bag,slot);
			if name ~= nil and string.find(name, "Hitem") ~= nil then
				itemName, itemLink, itemRarity, itemLevel, _, _, _, itemStackCount, _, _, itemSellPrice = GetItemInfo(name);
				item_tooltip:SetBagItem(bag,slot);
				if itemRarity > 1 and (item_tooltip:Find(ITEM_BIND_ON_EQUIP,1,3) and SellOMatic.db.profile.item_allowBoE) or (item_tooltip:Find(ITEM_SOULBOUND,1,3) and SellOMatic.db.profile.item_allowBoP) then
					if itemRarity == 2 and SellOMatic.db.profile.item_allowGreen then
						add = 1;
					elseif itemRarity == 3 and SellOMatic.db.profile.item_allowBlue then
						add = 1;
					elseif itemRarity == 4 and SellOMatic.db.profile.item_allowEpic then
						add = 1;
					end;
				elseif itemRarity == 1 and SellOMatic.db.profile.item_allowWhite then
					add = 1;
				end;
				if add == 1 and SellOMatic.db.profile.item_useILevel then
					if itemLevel > SellOMatic.db.profile.item_iLevelValue then add = 0 end;
				end;
				if add == 1 then
					if itemStackCount > 1 then
						itemSellPrice = itemSellPrice * GetItemCount(name);
					end;
					SellOMatic:Add_Shopping_List(itemName, itemLink, itemRarity, itemLevel, itemSellPrice);
				end;
			end;
		end;
	end;
end;
