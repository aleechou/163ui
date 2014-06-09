--[[Ideas:
  Auctioning multiple items at once
  ...ace\AddOns\Blizzard_AuctionUI\Blizzard_AuctionUI.lua:1404: attempt to compare number with nil
]]

local huanhuad = LibStub("LibItemData-1.0")
local HideBliz = {
  BrowseQualitySort,
  BrowseLevelSort,
  BrowseDurationSort,
  BrowseHighBidderSort,
  BrowseCurrentBidSort,
};

local AuctionTime = {"< 30m", "30m-2h", "2h-12h", "> 12h"};

local SortColumn = 6;
local SortReverse;
local BrowseDisplay = {};
local SelectedItem;
local SearchParam;
local SearchDelay = 0;
local CurrentPage;
local ScanPage;
local ScanFrame = CreateFrame("Frame", nil, AuctionFrame);
ScanFrame:Hide();
local UpdateResults = CreateFrame("Frame", nil, AuctionFrame);
UpdateResults:Hide();
local ScrollBox, ScrollBar, Highlight;
local Config;

local SearchResults = {};

local function GetIDFromLink(link)
	if not link then
		return
	end
	local found, _, str = link:find("^|c%x+|H(.+)|h%[.+%]")

	if not found then
		return
	end

	local _, id = (":"):split(str)
	return tonumber(id)
end

local SearchItem;
local Text;
local Columns = {
  {Name = NAME, Width = 150, Align = "LEFT", Display = function()
		Text = "|c" .. select(4,GetItemQualityColor(SearchItem[4]))..(SearchItem[1]or "Unknown");
--    Text = select(4,GetItemQualityColor(SearchItem[4]))..(SearchItem[1]or "Unknown");
    if(SearchItem[3] > 1)then
      Text = SearchItem[3].." "..Text;
    end
--    local itemID = GetIDFromLink(SearchItem[15])
--    ChatFrame1:AddMessage(itemID);
    if (huanhuad:FindItem(SearchItem[15])) then
      Text = Text.."|r |cffDD75ff幻化|r";
    end

    return Text;
  end, Sort = 1},
  {Name = LEVEL_ABBR, Width = 50, Align = "CENTER", Display = function()
    return SearchItem[6];
  end, Sort = 6},
  {Name = CLOSES_IN, Width = 75, Align = "CENTER", Display = function()
    return AuctionTime[SearchItem[14]];
  end, Sort = 14},
  {Name = AUCTION_CREATOR, Width = 75, Align = "CENTER", Display = function()
    return SearchItem[13];
  end, Sort = 13},
  {Name = BID.."单价", Width = 85, Align = "RIGHT", Display = function()
    Text = BaudAuctionToMoney(SearchItem[17]);
    if SearchItem[12]then
      Text = "|cffDD75ff*|r"..Text;  --Your bid
    elseif(SearchItem[11]~=0)then
      Text = "|cff00f0f0*|r"..Text;  --Other bid
    end
    return Text;
  end, Sort = 17},
  {Name = "一口单价", Width = 85, Align = "RIGHT", Display = function()
    return (SearchItem[10]==0)and "None" or BaudAuctionToMoney(SearchItem[18]);
  end, Sort = 18},
  {Name = BUYOUT, Width = 65, Align = "RIGHT", Display = function()
    return (SearchItem[10]==0)and "None" or BaudAuctionToMoney(SearchItem[10]);
  end, Sort = 10},
};


function BaudAuctionToMoney(Money)
  Money = floor(Money);
  local Text = "";
  if(Money % 100 > 0)and(Money < 10000)or(Money==0)then
    --203,163,133
    Text = "|cffba795a"..(Money % 100).."c|r";
  end
  Money = floor(Money / 100);
  if(Money % 100 > 0)and(Money < 100000)then
    --C0C0C0
    Text = (Money % 100).."s"..Text;
  end
  Money = floor(Money / 100);
  if(Money > 0)then
    --227,216,128
    Text = "|cfff0f020"..Money.."g|r"..Text;
  end
  return Text;
end


local EventFuncs = {
  ADDON_LOADED = function(self, AddOn)
    if(AddOn~="BaudAuction")then
      return;
    end
    Config = BaudAuctionConfig;
    if not Config then
      Config = {};
      BaudAuctionConfig = Config;
    end
    BrowseSearchButton:SetScript("OnUpdate",nil);
    hooksecurefunc("AuctionFrameBrowse_Update", function()
      BrowseNoResultsText:Hide();
    end);
  end,

  AUCTION_HOUSE_CLOSED = function()
    BaudAuctionProgress:Hide();
    wipe(SearchResults);
    SearchParam = nil;
    ScanPage = nil;
    SelectedItem = nil;
    BaudAuctionSortBrowseList();
--[[    AuctionFrame:ClearAllPoints();
    AuctionFrame:SetPoint("TOPLEFT",0,-104);]]
  end,

  AUCTION_ITEM_LIST_UPDATE = function()
    UpdateResults:Show();
  end,
};


function BaudAuction_OnLoad(self)
  AuctionFrame:SetMovable(true);
  AuctionFrame:RegisterForDrag("LeftButton");
  AuctionFrame:SetScript("OnDragStart", BaudAuction_OnDragStart);
  AuctionFrame:SetScript("OnDragStop", BaudAuction_OnDragStop);

  for Key, Value in pairs(EventFuncs)do
    self:RegisterEvent(Key);
  end
  self:SetScript("OnEvent", function(self, event, ...)
    EventFuncs[event](self, ...);
  end);

  AuctionFrameBrowse:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE");
  NUM_BROWSE_TO_DISPLAY = 0;

  for Key, Value in ipairs(HideBliz)do
    Value:Hide();
  end
  for Index = 1, 8 do
    getglobal("BrowseButton"..Index):Hide();
  end

  ScrollBox = BaudAuctionBrowseScrollBox;
  ScrollBar = getglobal(ScrollBox:GetName().."ScrollBar");
  Highlight = getglobal(ScrollBox:GetName().."Highlight");

  local Left = 26;
  local Button, Text, Texture;
  for Key, Value in ipairs(Columns)do
    Button = CreateFrame("Button",self:GetName().."Col"..Key, self, "AuctionSortButtonTemplate");
    Button:SetID(Key);
    Button:SetNormalTexture(nil);
    Value.Header = Button;
    Button:SetWidth(Value.Width);
    Button:SetHeight(19);
    Button:SetScript("OnClick", BaudAuctionColumn_OnClick);
    Button:SetPoint("BOTTOMLEFT", ScrollBox, "TOPLEFT", Left, 0);
    Text = getglobal(Button:GetName().."Text");--Button:CreateFontString(Button:GetName().."Text", "ARTWORK", "GameFontNormal");
    Text:SetText(Value.Name);
    Left = Left + Value.Width;
  end

  local Entry;
  ScrollBox.Entries = 19;

  local function ChildClickFunc(self)
    BaudAuctionBrowseEntry_OnClick(self:GetParent());
  end
  for Index = 1, ScrollBox.Entries do
    Entry = CreateFrame("Button", ScrollBox:GetName().."Entry"..Index, ScrollBox);
    Entry:SetHeight(16);
    Entry:SetPoint("LEFT", 6, 0);
    Entry:SetPoint("RIGHT", -6, 0);
    Entry:SetPoint("TOP", 0, -3 - (Index - 1) * 16);
    Entry:Hide();
    Entry:SetID(0); --Hack for using Blizzard's on enter function
    Button = CreateFrame("Button", Entry:GetName().."Icon", Entry);
    Button:SetPoint("LEFT");
    Button:SetHeight(16);
    Button:SetWidth(16);
    Button:CreateTexture(Entry:GetName().."Texture", "ARTWORK"):SetAllPoints();
    Button:EnableMouse(true);
    Button:SetScript("OnEnter", BaudAuctionBrowseEntry_OnEnter);
    Button:SetScript("OnLeave", BaudAuctionBrowseEntry_OnLeave);
    Button:SetScript("OnClick", ChildClickFunc);
    --Button:SetScript("OnUpdate", BaudAuctionBrowseEntry_OnUpdate);
    for Key, Value in ipairs(Columns)do
      Text = Entry:CreateFontString(Entry:GetName().."Text"..Key, "ARTWORK", "GameFontHighlight");
      Text:SetPoint("TOP");
      Text:SetPoint("BOTTOM");
      Text:SetPoint("LEFT", Value.Header);
      Text:SetPoint("RIGHT", Value.Header);
      Text:SetJustifyH(Value.Align);
    end
--    Entry:RegisterForClicks("RightButtonUp");
    Entry:SetScript("OnClick", BaudAuctionBrowseEntry_OnClick);
  end

--  DEFAULT_CHAT_FRAME:AddMessage("Baud Auction: AddOn loaded.");
end


function BaudAuctionUpdateProgress(Progress)
  BaudAuctionProgressBar:SetValue(Progress);
  BaudAuctionProgressBarText:SetText(floor(Progress * 100 + 0.5).."%");
  if(Progress >= 1)then
    BaudAuctionProgressBarText2:SetText("搜索完成");
    BaudAuctionProgressBarDots:Hide();
    BaudAuctionProgress.Finish = GetTime();
  else
    BaudAuctionProgressBarText2:SetText("搜索中...");
    BaudAuctionProgressBarDots:Show();
  end
  BaudAuctionProgress:Show();
end


function BaudAuctionProgress_OnUpdate(self)
  if not BaudAuctionProgress.Finish then
    BaudAuctionProgressBarDots:SetText(strrep(".", floor(GetTime()) % 4));
    return;
  end
  local Elapsed = GetTime() - BaudAuctionProgress.Finish - 1;
  if(Elapsed < 0)then
    return;
  end
  if(Elapsed > 1)then
    self:Hide();
  end
  self:SetAlpha(1 - Elapsed);
end


function BaudAuctionUpdateBidButtons()
  local Index = GetSelectedAuctionItem("list");
  if(Index==0)then
    BrowseBidButton:Disable();
    BrowseBuyoutButton:Disable();
  else
    AuctionFrame.buyoutPrice = select(10, GetAuctionItemInfo("list",Index));
    BrowseBidButton:Enable();
    if(AuctionFrame.buyoutPrice > 0)then
      BrowseBuyoutButton:Enable();
    else
      BrowseBuyoutButton:Disable();
    end
  end
end


function BaudAuctionIsMatch(Item1, Item2)
  if not Item1 or not Item2 then
    return;
  end
  for Index = 1, 12 do
    if(Item1[Index]~=Item2[Index])then
      return;
    end
  end
  return true;
end


function BaudAuctionListUpdate()
  UpdateResults:Hide();
  if not SearchParam then
    return;
  end

  local Batch, Total = GetNumAuctionItems("list");
  if(Total==0)then
    BrowseNoResultsText:SetText(BROWSE_NO_RESULTS);
    BrowseNoResultsText:Show();
  end

  CurrentPage = SearchParam[7];

  if(ScanPage==CurrentPage)then
    local Progress = (Total == 0)and 1 or ((ScanPage + 1) / ceil(Total / NUM_AUCTION_ITEMS_PER_PAGE));
    BaudAuctionUpdateProgress(Progress);
    if(Progress >= 1)then
      ScanPage = nil;
    else
      ScanPage = ScanPage + 1;
    end
  end
  
--  ChatFrame1:AddMessage(Batch.." results, "..Total.." Total, page "..CurrentPage);
  local Offset = NUM_AUCTION_ITEMS_PER_PAGE * CurrentPage;
--[[  local OldData;
  if(Offset + NUM_AUCTION_ITEMS_PER_PAGE < Total)then
    OldData = {};
    for Index = 1, NUM_AUCTION_ITEMS_PER_PAGE do
      OldData[Index] = SearchResults[Offset + Index];
    end
  end]]

  local SelectedData;
  if SelectedItem and(SelectedItem > Offset)and(SelectedItem <= Offset + NUM_AUCTION_ITEMS_PER_PAGE)then
    SelectedData = SearchResults[SelectedItem];
  end

  local Item;
  for Index = 1, Batch do
    --name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner  = GetAuctionItemInfo("type",
    Item = {GetAuctionItemInfo("list",Index)};
		-- name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("list", offset + i);

--[[    if(Item[1]==nil)then
      Item[1] = "Unknown";
    end]]
    Item[13] = Item[14];
    Item[15] = Item[17];
    --Item[13] = Item[15];大服务器
    Item[14] = GetAuctionItemTimeLeft("list",Index);
    Item[19] = GetAuctionItemLink("list", Index);
    Item[16] = (Item[11]~=0)and(Item[11] + Item[9])or Item[8]; --Minimum bid amount, including beating an existing bid
    if(Item[10]~=0)and(Item[16] > Item[10])then
      Item[16] = Item[10]; --Bid price cannot exceed buyout price
    end
    Item[17] = Item[16] / Item[3];
    Item[18] = Item[10] / Item[3];  --Per unit price for sorting
--[[    if OldData then
      for Key, Value in ipairs(OldData)do
        if BaudAuctionIsMatch(Value, Item)then
          tremove(OldData, Key);
          break;
        end
      end
    end]]
    SearchResults[Index + Offset] = Item;
  end
  
  for Index = Total + 1, #SearchResults do
    SearchResults[Index] = nil;
  end

  if SelectedData then
    if BaudAuctionIsMatch(SearchResults[SelectedItem], SelectedData)then
      BaudAuctionSelectItem();
    end
    SelectedItem = nil;
  end

  BaudAuctionUpdateBidButtons();
  BaudAuctionSortBrowseList();
end


UpdateResults:SetScript("OnUpdate", BaudAuctionListUpdate);
ScanFrame:SetScript("OnUpdate", function(self)
  if not(ScanPage or SelectedItem)then
    self:Hide();
    return;
  end
  if CanSendAuctionQuery()and(SearchDelay <= GetTime())then
    local Selected = GetSelectedAuctionItem("list");
    if(Selected~=0)then
      SelectedItem = NUM_AUCTION_ITEMS_PER_PAGE * CurrentPage + Selected;
    end
    SearchParam[7] = ScanPage or ceil(SelectedItem / NUM_AUCTION_ITEMS_PER_PAGE - 1);
    QueryAuctionItems(unpack(SearchParam));
    SearchDelay = GetTime() + 1;
  end
end);


function BaudAuctionSearchCancelButton_OnClick()
  if BaudAuctionProgress.Finish then
    return;
  end
  BaudAuctionProgress.Finish = GetTime();
  ScanPage = nil;
  BaudAuctionProgressBarText2:SetText("搜索已取消");
  BaudAuctionProgressBarDots:Hide();
  CloseAuctionStaticPopups();
end


function BaudAuction_OnShow()
  BaudAuctionSortBrowseList();
end


function BaudAuction_OnHide()
end


function BaudAuction_OnDragStart(self)
  self:StartMoving();
end


function BaudAuction_OnDragStop(self)
  self:StopMovingOrSizing();
  self:SetUserPlaced(false);
end


function BaudAuctionColumn_OnClick(self)
  PlaySound("igMainMenuOptionCheckBoxOn");
  if(self:GetID()==SortColumn)then
    SortReverse = not SortReverse;
  else
    SortColumn = self:GetID();
    SortReverse = nil;
  end
  BaudAuctionSortBrowseList();
end


function BaudAuctionSelectItem()
  if(CurrentPage == ceil(SelectedItem / NUM_AUCTION_ITEMS_PER_PAGE) - 1)then
    SetSelectedAuctionItem("list", (SelectedItem - 1) % NUM_AUCTION_ITEMS_PER_PAGE + 1);
    SelectedItem = nil;
  else
    SetSelectedAuctionItem("list", 0);
  end
end


function BaudAuctionBrowseEntry_OnClick(self)
  if IsControlKeyDown() then
    DressUpItemLink(SearchResults[self.Index][19]);
  elseif ( IsShiftKeyDown() ) then
    ChatEdit_InsertLink(SearchResults[self.Index][19]);
  else
    SelectedItem = self.Index;
    ScanFrame:Show();
    if(ShowOnPlayerCheckButton:GetChecked() == 1)then
      DressUpItemLink(SearchResults[SelectedItem][19]);
    end
    MoneyInputFrame_SetCopper(BrowseBidPrice, SearchResults[SelectedItem][16]);
    BaudAuctionSelectItem();
    BaudAuctionUpdateBidButtons();
    BaudAuctionBrowseScrollBar_Update();
  end
end


local HackFrame = CreateFrame("Frame", "BrowseButton0");
local RefreshFunc = function(self)
  if GameTooltip:IsOwned(self)then
    BaudAuctionBrowseEntry_OnEnter(self);
  else
    self:SetScript("OnUpdate", nil);
  end
end
function BaudAuctionBrowseEntry_OnEnter(self)
  local Index = self:GetParent().Index;
  local Item = SearchResults[Index];
  if(CurrentPage==floor((Index - 1) / NUM_AUCTION_ITEMS_PER_PAGE))then
  	--GameTooltip:SetAuctionItem("list", (Index - 1) % NUM_AUCTION_ITEMS_PER_PAGE + 1);
  	--The way this is designed is to work using the original Blizzard function so that other addons can hook on
    HackFrame.itemCount = Item[3];
    HackFrame.bidAmount = (Item[11]~=0)and Item[11]or Item[8];
    HackFrame.buyoutPrice = Item[10];
  	AuctionFrameItem_OnEnter(self, "list", (Index - 1) % NUM_AUCTION_ITEMS_PER_PAGE + 1);
    self.UpdateTooltip = nil;
  	self:SetScript("OnUpdate", RefreshFunc);
  	return;
  elseif not Item[19]then
    return;
  end
  self.UpdateTooltip = BaudAuctionBrowseEntry_OnEnter;
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
  GameTooltip:SetHyperlink(strmatch(Item[19], "(item[:%-%d]+)"));
  if(Item[3] > 1)then
    if Item[12]then
      GameTooltip:AddLine("|n");
      SetTooltipMoney(GameTooltip, ceil(Item[11] / Item[3]), "STATIC", "<"..AUCTION_TOOLTIP_BID_PREFIX, ">");
    end
    if(Item[10] > 0)then
      SetTooltipMoney(GameTooltip, ceil(Item[10] / Item[3]), "STATIC", "<"..AUCTION_TOOLTIP_BUYOUT_PREFIX, ">");
    end
    GameTooltip:Show();
  end
	GameTooltip_ShowCompareItem();
	if IsModifiedClick("DRESSUP")then
		ShowInspectCursor();
	else
		ResetCursor();
	end
end


function BaudAuctionBrowseEntry_OnLeave()
  GameTooltip:Hide();
  ResetCursor();
end


hooksecurefunc("QueryAuctionItems", function(...)
--  ChatFrame1:AddMessage("Item search page "..select(7, ...));
  SearchDelay = GetTime() + 1;
  --table.foreach({...},print);
  if(select(7, ...)==0 and SelectedItem == nil) then
    SearchResults = {};
    SelectedItem = nil;
    ScanPage = 0;
    ScanFrame:Show();
    SearchParam = {...};
    BaudAuctionUpdateProgress(0);
    BaudAuctionProgress.Finish = nil;
    BaudAuctionProgress:SetAlpha(1);
    BaudAuctionProgress:Show();
  end
end);


hooksecurefunc("AuctionFrameBrowse_Search", function()
  AuctionFrameBrowse.isSearching = nil;
  BrowseNoResultsText:Hide();
  BrowseSearchDotsText:Hide();
end);


function BaudAuctionSortBrowseList()
  BaudAuctionArrow:ClearAllPoints();
  BaudAuctionArrow:SetPoint("LEFT", getglobal(Columns[SortColumn].Header:GetName().."Text"), "RIGHT", 3, -2);
  if SortReverse then
    BaudAuctionArrow:SetTexCoord(0, 0.5625, 1.0, 0);
  else
    BaudAuctionArrow:SetTexCoord(0, 0.5625, 0, 1.0);
  end

  for Index = #SearchResults + 1, #BrowseDisplay do
    BrowseDisplay[Index] = nil;
  end
  for Index = 1, #SearchResults do
    BrowseDisplay[Index] = Index;
  end

  local Sort = Columns[SortColumn].Sort;
  table.sort(BrowseDisplay, function(a, b)
    if(SearchResults and SearchResults[a] and SearchResults[b]) then
    if(SearchResults[a][Sort]==SearchResults[b][Sort])then
      return(a < b);
    elseif not SortReverse then
      return(SearchResults[a][Sort] < SearchResults[b][Sort]);
    else
      return(SearchResults[a][Sort] > SearchResults[b][Sort]);
    end
    end
  end);
  BaudAuctionBrowseScrollBar_Update();
end


function BaudAuctionBrowseScrollBar_Update()
  FauxScrollFrame_Update(ScrollBar, #SearchResults, ScrollBox.Entries, 16);
  local Entry, Index, Text;
  Highlight:Hide();
  local Selected = GetSelectedAuctionItem("list");
  if(Selected==0)then
    Selected = SelectedItem;
    Highlight:SetVertexColor(0, 0, 0.5);
  else
    Selected = CurrentPage * NUM_AUCTION_ITEMS_PER_PAGE + Selected;
    Highlight:SetVertexColor(0.5, 0.5, 0);
  end

  for Line = 1, ScrollBox.Entries do
    Entry = getglobal(ScrollBox:GetName().."Entry"..Line);
    Index = Line + FauxScrollFrame_GetOffset(ScrollBar);
    if(Index > #SearchResults)then
      Entry:Hide();
    else
      Index = BrowseDisplay[Index];
      Entry.Index = Index;
      SearchItem = SearchResults[Index];
      if(not SearchItem) then return end
      getglobal(Entry:GetName().."Texture"):SetTexture(SearchItem[2]);
      for Key, Value in ipairs(Columns)do
        getglobal(Entry:GetName().."Text"..Key):SetText(Value.Display());
      end
      if(Index==Selected)then
        Highlight:SetPoint("TOP", Entry);
        Highlight:Show();
      end
      Entry:Show();
    end
  end
end