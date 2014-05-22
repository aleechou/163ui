--已学物品染色
local COLOR = { r = 0.1, g = 1.0, b = 0.1 }

local WEAPON, ARMOR, CONTAINER, CONSUMABLE, GLYPH, TRADE_GOODS, RECIPE, GEM, MISCALLANEOUS, QUEST = GetAuctionItemClasses()
local KNOWABLES = { [CONSUMABLE] = true, [GLYPH] = true, [RECIPE] = true, [MISCALLANEOUS] = true }

local f = CreateFrame("GameTooltip")
f:SetOwner(WorldFrame, "ANCHOR_NONE")

local lines = {}
for i=1, 40 do
	lines[i] = f:CreateFontString()
	f:AddFontStrings(lines[i], f:CreateFontString())
end

local knowns, id = {}
local function isKnown(link)
	id = strmatch(link, "item:(%d+):")
	if ( not id ) then
		return false
	end
	if ( knowns[id] ) then
		return true
	end

	f:ClearLines()
	f:SetHyperlink(link)
	for i=1, f:NumLines() do
		if ( lines[i]:GetText() == ITEM_SPELL_KNOWN ) then
			knowns[id] = true
			return true
		end
	end
	return false
end

local numItems, offset, index, link, merchantButton, itemButton

local function merchantFrame_UpdateMerchantInfo()
	numItems = GetMerchantNumItems()
	for i=1, MERCHANT_ITEMS_PER_PAGE do
		index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
		if ( index <= numItems ) then
			link = GetMerchantItemLink(index)
			if ( link and KNOWABLES[select(6, GetItemInfo(link))] and isKnown(link) ) then
				merchantButton, itemButton = _G["MerchantItem" .. i], _G["MerchantItem" .. i .. "ItemButton"]
				if ( select(5, GetMerchantItemInfo(index)) == 0 ) then 
					SetItemButtonNameFrameVertexColor(merchantButton, COLOR.r * 0.5, COLOR.g * 0.5, COLOR.b * 0.5)
					SetItemButtonSlotVertexColor(merchantButton, COLOR.r * 0.5, COLOR.g * 0.5, COLOR.b * 0.5)
					SetItemButtonTextureVertexColor(itemButton, COLOR.r * 0.5, COLOR.g * 0.5, COLOR.b * 0.5)
					SetItemButtonNormalTextureVertexColor(itemButton, COLOR.r * 0.5, COLOR.g * 0.5, COLOR.b * 0.5)
				else
					SetItemButtonNameFrameVertexColor(merchantButton, COLOR.r, COLOR.g, COLOR.b)
					SetItemButtonSlotVertexColor(merchantButton, COLOR.r, COLOR.g, COLOR.b)
					SetItemButtonTextureVertexColor(itemButton, COLOR.r, COLOR.g, COLOR.b)
					SetItemButtonNormalTextureVertexColor(itemButton, COLOR.r, COLOR.g, COLOR.b)
				end
			end
		end
	end
end

hooksecurefunc("MerchantFrame_UpdateMerchantInfo", merchantFrame_UpdateMerchantInfo)

if ( MerchantFrame:IsVisible() and MerchantFrame.selectedTab == 1 ) then
	merchantFrame_UpdateMerchantInfo()
end

local function auctionFrameBrowse_Update()
	numItems, offset = GetNumAuctionItems("list"), FauxScrollFrame_GetOffset(BrowseScrollFrame)
	for i=1, NUM_BROWSE_TO_DISPLAY do
		index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)
		if ( index <= (numItems + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)) ) then
			link = GetAuctionItemLink("list", offset + i)
			if ( link and KNOWABLES[select(6, GetItemInfo(link))] and isKnown(link) ) then
				_G["BrowseButton" .. i .. "ItemIconTexture"]:SetVertexColor(COLOR.r, COLOR.g, COLOR.b)
			end
		end
	end
end

local function auctionFrameBid_Update()
	numItems, offset = GetNumAuctionItems("bidder"), FauxScrollFrame_GetOffset(BidScrollFrame)
	for i=1, NUM_BIDS_TO_DISPLAY do
		index = offset + i
		if ( index <= numItems ) then
			link = GetAuctionItemLink("bidder", index)
			if ( link and KNOWABLES[select(6, GetItemInfo(link))] and isKnown(link) ) then
				_G["BidButton" .. i .. "ItemIconTexture"]:SetVertexColor(COLOR.r, COLOR.g, COLOR.b)
			end
		end
	end
end

local function auctionFrameAuctions_Update()
	numItems, offset = GetNumAuctionItems("owner"), FauxScrollFrame_GetOffset(AuctionsScrollFrame)
	for i=1, NUM_AUCTIONS_TO_DISPLAY do
		index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameAuctions.page)
		if ( index <= (numItems + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameAuctions.page)) ) then
			if ( select(13, GetAuctionItemInfo("owner", offset + i)) ~= 1 ) then 
				link = GetAuctionItemLink("owner", offset + i)
				if ( link and KNOWABLES[select(6, GetItemInfo(link))] and isKnown(link) ) then
					_G["AuctionsButton" .. i .. "ItemIconTexture"]:SetVertexColor(COLOR.r, COLOR.g, COLOR.b)
				end
			end
		end
	end
end

if ( IsAddOnLoaded("Blizzard_AuctionUI") ) then
	hooksecurefunc("AuctionFrameBrowse_Update", auctionFrameBrowse_Update)
	hooksecurefunc("AuctionFrameBid_Update", auctionFrameBid_Update)
	hooksecurefunc("AuctionFrameAuctions_Update", auctionFrameAuctions_Update)
else
	f:SetScript("OnEvent", function(self, event, addonName)
		if ( not addonName or (addonName and addonName ~= "Blizzard_AuctionUI") ) then
			return
		end

		hooksecurefunc("AuctionFrameBrowse_Update", auctionFrameBrowse_Update)
		hooksecurefunc("AuctionFrameBid_Update", auctionFrameBid_Update)
		hooksecurefunc("AuctionFrameAuctions_Update", auctionFrameAuctions_Update)

		self:UnregisterEvent(event)
		self:SetScript("OnEvent", nil)
	end)

	f:RegisterEvent("ADDON_LOADED")
end
