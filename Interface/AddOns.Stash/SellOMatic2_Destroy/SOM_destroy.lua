SellOMatic_Destroy = LibStub("AceAddon-3.0"):NewAddon("SellOMatic_Destroy", "AceEvent-3.0", "AceConsole-3.0");
local SellOMatic = _G.SellOMatic;
local item_tooltip = LibStub("LibGratuity-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("SellOMatic");

local function getOption(info)
	return (info.arg and SellOMatic.db.profile[info.arg] or SellOMatic.db.profile[info[#info]]);
end;

local function setOption(info, value)
	local key = info.arg or info[#info];
	SellOMatic.db.profile[key] = value;
end;

local destroy_options = {
	type = "group",
	name = L["Destroy Options"],
	args = {
		destroy_intro = {
			name = L["If you can see this, Destroy module is loaded"],
			type = "description",
			fontSize = "medium",
			order = 1,
		},
		destroy_header = {
			name = L["Destroy Commands"],
			type = "header",
			order = 2,
		},
		destroy_commands = {
			name = "|cffffd700/som destroy|r "..L["destroy all junk items in your backpack"].."|n"..
					"|cffffd700/som destroy x|r "..L["destroy x junk items, where x is the number of items to destroy"],
			type = "description",
			fontSize = "medium",
			order = 3,
		},
	},
}

local destroy_list,item_count,fram,item_string,_

function SellOMatic_Destroy:OnInitialize()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SellOMatic_Destroy", destroy_options);
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SellOMatic_Destroy", L["Destroy Options"], "Sell-O-Matic");
end;

function SellOMatic_Destroy:OnEnable()
	destroy_list = {};
	item_count = 0;
	fram = {};
	item_string = "";
end;

function SellOMatic:DestroyJunk()
	SellOMatic_Destroy:FindJunk();
	local num = #destroy_list;
	SellOMatic_Destroy:SetItemString(num);
	SellOMatic_Destroy:ShowDestroyFrame(num);
end;

function SellOMatic_Destroy:FindJunk()
	local bag, slot, name, itemName, itemRarity, itemStackCount, itemSellPrice;
	for bag = 0,NUM_BAG_SLOTS,1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			name = GetContainerItemLink(bag,slot);
			if name ~= nil and string.find(name, "Hitem") ~= nil then
				itemName, _, itemRarity, _, _, _, _, itemStackCount, _, _, itemSellPrice = GetItemInfo(name);
				if itemRarity == 0 then
					if itemStackCount > 1 then
						itemSellPrice = itemSellPrice * GetItemCount(itemName);
					end;
					SellOMatic_Destroy:SetJunkList(itemName,itemSellPrice);
				end;
			end;
		end;
	end;
end;

function SellOMatic_Destroy:DestroyJunk()
	local bag, slot, name, itemName, itemLink, itemRarity;
	local num = 0;
	for bag = 0,NUM_BAG_SLOTS,1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			name = GetContainerItemLink(bag,slot);
			if name ~= nil and string.find(name, "Hitem") ~= nil then
				itemName, itemLink, itemRarity = GetItemInfo(name);
				if itemRarity == 0 then
					if SellOMatic_Destroy:CheckJunkList(itemName) then
						-- Destroy Item
						PickupContainerItem(bag,slot);
						DeleteCursorItem();
						if SellOMatic.db.profile.showFullInfo == "1-FULL" then SellOMatic:Print(L["Destroying"]..": "..itemName) end;
						num = num + 1;
					end;
				end;
			end;
		end;
	end;
	SellOMatic:Print(num.." "..L["item(s) destroyed"]);
end;

function SellOMatic_Destroy:CheckJunkList(item)
	local i;
	for i=1, #destroy_list, 1 do
		if destroy_list[i][1] == item then
			return 1;
		end;
	end;
	return 0;
end;

function SellOMatic_Destroy:ShortJunk()
	local itemSellPriceX,itemSellPriceY,x,y;
	local z = { "", 0 };
	for x=1, #destroy_list-1, 1 do
		for y=x+1, #destroy_list, 1 do
			if destroy_list[x][2] > destroy_list[y][2] then
				z = destroy_list[x];
				destroy_list[x] = destroy_list[y];
				destroy_list[y] = z;
			end;
		end;
	end;
end;

function SellOMatic_Destroy:DestroyItem(item)
	local bag, slot, name, itemName;
	local found = 0;
	for bag = 0,NUM_BAG_SLOTS,1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			if found == 0 then
				name = GetContainerItemLink(bag,slot);
				if name ~= nil and string.find(name, "Hitem") ~= nil then
					itemName = GetItemInfo(name);
					if item == itemName then
						found = 1;
						-- Destroy item
						PickupContainerItem(bag,slot);
						DeleteCursorItem();
						if SellOMatic.db.profile.showFullInfo == "1-FULL" then SellOMatic:Print(L["Destroying"]..": "..item) end;
					end;
				end;
			end;
		end;
	end;
end;

function SellOMatic:ScanXJunk(num)
	local x;
	SellOMatic_Destroy:FindJunk();
	SellOMatic_Destroy:ShortJunk();
	num = tonumber(num);
	if num > #destroy_list then num = #destroy_list end;
	SellOMatic_Destroy:SetItemString(num);
	SellOMatic_Destroy:ShowDestroyFrame(num);
end;	
	
function SellOMatic_Destroy:DestroyXJunk(num)
	local x;
	for x=1, num, 1 do
		SellOMatic_Destroy:DestroyItem(destroy_list[x][1]);
	end;
	SellOMatic_Destroy:ClearJunkList();
	SellOMatic:Print(num.." "..L["item(s) destroyed"]);
end;

function SellOMatic_Destroy:SetJunkList(item,price)
	destroy_list[#destroy_list+1] = {item,price};
end;

function SellOMatic_Destroy:ShowJunkList(num)
	local i;
	for i=1, #destroy_list, 1 do
		if num ~= nil and num >= i then
			SellOMatic:Print(destroy_list[i][1]);
		elseif num == nil then
			SellOMatic:Print(destroy_list[i][1]);
		end;
	end;
end;

function SellOMatic_Destroy:ClearJunkList()
	destroy_list = {};
end;

function SellOMatic:GetItemCount()
	return item_count;
end;

function SellOMatic_Destroy:CreateDestroyWindow()
	fram.DestroyFrame = CreateFrame("Frame","SOMDestroyFrame",UIParent);
	local dFrame = fram.DestroyFrame;
	dFrame:ClearAllPoints();
	dFrame:SetPoint("CENTER",UIParent,"TOP",0,-200);
	dFrame:SetHeight(100);
	dFrame:SetWidth(300);
	dFrame:SetFrameStrata("FULLSCREEN_DIALOG");
	dFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true,
		insets = { left = 10, right = 10, top = 10, bottom = 10 }
	});
	dFrame:SetBackdropBorderColor(1.0,1.0,1.0);
	dFrame:SetBackdropColor(0.1,0.1,0.1);
	dFrame.Text = dFrame:CreateFontString(nil,"OVERLAY","GameFontNormal");
	dFrame.Text:SetPoint("CENTER",dFrame,"TOP",0,-30);
	dFrame.Text:SetText(item_string);
	dFrame.YesButton = CreateFrame("Button",nil,dFrame,"OptionsButtonTemplate");
	dFrame.YesButton:SetPoint("CENTER",dFrame,"BOTTOM",-90,30);
	dFrame.YesButton:SetText(L["Yes"]);
	dFrame.NoButton = CreateFrame("Button",nil,dFrame,"OptionsButtonTemplate");
	dFrame.NoButton:SetPoint("CENTER",dFrame,"BOTTOM",90,30);
	dFrame.NoButton:SetScript("OnClick", function()
		SellOMatic_Destroy:ClearJunkList();
		dFrame:Hide();
	end);
	dFrame.NoButton:SetText(L["No"]);
	dFrame.ShowButton = CreateFrame("Button",nil,dFrame,"OptionsButtonTemplate");
	dFrame.ShowButton:SetPoint("CENTER",dFrame,"BOTTOM",0,30);
	dFrame.ShowButton:SetText(L["Show"]);
	dFrame:Hide();
end;

function SellOMatic_Destroy:ShowDestroyFrame(num)
	if fram.DestroyFrame == nil then SellOMatic_Destroy:CreateDestroyWindow() end;
	fram.DestroyFrame.Text:SetText(item_string);
	fram.DestroyFrame.YesButton:SetScript("OnClick", function()
		SellOMatic_Destroy:DestroyXJunk(num)
		fram.DestroyFrame:Hide();
	end);
	fram.DestroyFrame.ShowButton:SetScript("OnClick", function()
		SellOMatic_Destroy:ShowJunkList(num);
	end);
	fram.DestroyFrame:Show();
end;

function SellOMatic_Destroy:SetItemString(num)
	item_string = L["Delete"].." "..num.." "..L["item(s) from inventory?"];
end;
