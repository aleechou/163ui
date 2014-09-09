local function getIdFromLink(link)
	if not link then return end

-- 	local _, _, id,name = strfind(link, "|Hitem:(%d+):.+%[(.+)%]")
	local _, _, id = strfind(link, "item:(%d+):")

	if not id then
--  	local _, _, id, name = strfind(link, "|Henchant:(%d+)|h%[(.+)%]")
		local _, _, id = strfind(link, "enchant:(%d+)")

		if id then
			return -tonumber(id)
		end
	else
		return tonumber(id)
	end
end

function TradeskillInfo:AuctionFrameBrowse_Update()

	if not self:ColoringAHRecipes() then return end
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)
	for i=1, NUM_BROWSE_TO_DISPLAY do
		local index = offset + i
		local button = _G["BrowseButton"..i]

		if button:IsVisible() then

			local iconTexture
			if button.Icon then  -- cached or from Auc-Advanced Compact-UI
				iconTexture = button.Icon
			else
				button.Icon = _G["BrowseButton"..i.."ItemIconTexture"] -- cache the icon texture
				iconTexture = button.Icon
			end
			if button.id then  -- contains real index when sorted in Compact-UI level
				index = button.id
			end

			local recipeLink = GetAuctionItemLink("list", index)
			--self:Print("Item: %d(%d) %d %s",i,index,recipeId,recipeLink)
			self:ColoringAH(recipeLink,iconTexture)
		end
	end

end


function TradeskillInfo:ColoringAH(recipeLink,iconTexture)
	if not self:ColoringAHRecipes() then return end

	local recipeId = getIdFromLink(recipeLink)
	local id = self:GetRecipeItem(recipeId)

	if id then
		local you,alt = self:GetCombineAvailability(id)
		--self:Print("recipe: %s you %d alt %d",id,you,alt)
		-- 0 = Unavailable, 1 = known, 2 = learnable, 3 = will be able to learn
		if you == 2 then
			local c = self.db.profile.AHColorLearnable
			iconTexture:SetVertexColor(c.r, c.g, c.b)
		elseif alt == 2 then
			local c = self.db.profile.AHColorAltLearnable
			iconTexture:SetVertexColor(c.r, c.g, c.b)
		elseif you == 3 then
			local c = self.db.profile.AHColorWillLearn
			iconTexture:SetVertexColor(c.r, c.g, c.b)
		elseif alt == 3 then
			local c = self.db.profile.AHColorAltWillLearn
			iconTexture:SetVertexColor(c.r, c.g, c.b)
		else
			local c = self.db.profile.AHColorUnavailable
			iconTexture:SetVertexColor(c.r, c.g, c.b)
		end
--				local knownBy = self:GetCombineKnownBy(id)
--				local learnableBy = self:GetCombineLearnableBy(id)
--				local availableTo = self:GetCombineAvailableTo(id)
--				if learnableBy then
--					iconTexture:SetVertexColor(1.0, 0.1, 0.1)
--				elseif availableTo then
--					iconTexture:SetVertexColor(1.0, 0.1, 0.1)
--				elseif knownBy then
--					iconTexture:SetVertexColor(1.0, 0.1, 0.1)
--				end
	elseif button.id then  -- button.id is set only by Compact-UI we need to fix texture colors.
		local _, _, _, _, canUse =  GetAuctionItemInfo("list", index)
		if ( not canUse ) then
			iconTexture:SetVertexColor(1.0, 0.1, 0.1)  -- item is not usable
		else
			iconTexture:SetVertexColor(1.0, 1.0, 1.0)  -- usable, non-recipe item
		end
	end
end





if BaudAuctionBrowseScrollBar_Update then
	BaudAuctionBrowseScrollBar_Update = function ()
	    FauxScrollFrame_Update(ScrollBar, #SearchResults, ScrollBox.Entries, 16);
	    local Entry, Index, Text;
	    Highlight:Hide();
	    local Selected = GetSelectedAuctionItem("list");
	    if (Selected == 0) then
	        Selected = SelectedItem;
	        Highlight:SetVertexColor(0, 0, 0.5);
	    else
	        Selected = CurrentPage * NUM_AUCTION_ITEMS_PER_PAGE + Selected;
	        Highlight:SetVertexColor(0.5, 0.5, 0);
	    end

	    for Line = 1, ScrollBox.Entries do
	        
	        Entry = getglobal(ScrollBox:GetName() .. "Entry" .. Line);
	        Index = Line + FauxScrollFrame_GetOffset(ScrollBar);
	        if (Index > #SearchResults) then
	            Entry:Hide();
	            Entry.itemLink = nil
	        else
	            Index = BrowseDisplay[Index];
	            Entry.Index = Index;
	            SearchItem = SearchResults[Index];
	            if (not SearchItem) then return end
	            Entry.itemLink = SearchItem[5] and strmatch(SearchItem[14], "(item[:%-%d]+)") --for AlreadyKnown
	            getglobal(Entry:GetName() .. "Texture"):SetTexture(SearchItem[2]);
	            for Key, Value in ipairs(Columns) do
	                getglobal(Entry:GetName() .. "Text" .. Key):SetText(Value.Display());
	            end
	            if (Index == Selected) then
	                Highlight:SetPoint("TOP", Entry);
	                Highlight:Show();
	            end
	            Entry:Show();
	        end
	    end
	end
end



table.getnn = function(ht)
    local n = 0;
    for _, v in pairs(ht) do
        n = n + 1;
    end
    return n;
end