local SellOMatic = _G.SellOMatic;
local L = LibStub("AceLocale-3.0"):GetLocale("SellOMatic");
local fram = {};

function fram:CreateAddWindow()
	fram.AddFrame = CreateFrame("Frame","SOMAddFrame",UIParent);
	local addFrame = fram.AddFrame;
	addFrame:ClearAllPoints();
	addFrame:SetPoint("CENTER",UIParent,"TOP",0,-200);
	addFrame:SetHeight(140);
	addFrame:SetWidth(350);
	addFrame:SetFrameStrata("FULLSCREEN_DIALOG");
	addFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true,
		insets = { left = 10, right = 10, top = 10, bottom = 10 }
	});
	addFrame:SetBackdropBorderColor(1.0,1.0,1.0);
	addFrame:SetBackdropColor(0.1,0.1,0.1);
	addFrame.Text1 = addFrame:CreateFontString(nil,"OVERLAY","GameFontNormal");
	addFrame.Text1:SetPoint("CENTER",addFrame,"TOP",0,-30);
	addFrame.Text1:SetText(L["Hover over the item you want to add"]);
	addFrame.Text2 = addFrame:CreateFontString(nil,"OVERLAY","GameFontNormal");
	addFrame.Text2:SetPoint("TOPLEFT",addFrame,"TOPLEFT",50,-50);
	addFrame.Text2:SetText(L["Press ALT to add item to sell list"]);
	addFrame.Text3 = addFrame:CreateFontString(nil,"OVERLAY","GameFontNormal");
	addFrame.Text3:SetPoint("TOPLEFT",addFrame,"TOPLEFT",50,-70);
	addFrame.Text3:SetText(L["Press CTRL to add item to save list"]);
	addFrame.Button = CreateFrame("Button",nil,addFrame,"OptionsButtonTemplate");
	addFrame.Button:SetPoint("CENTER",addFrame,"BOTTOM",0,30);
	addFrame.Button:SetScript("OnClick", function()
		SellOMatic:UnregisterEvent("MODIFIER_STATE_CHANGED");
		addFrame:Hide();
	end);
	addFrame.Button:SetText(L["Done"]);
	addFrame:Hide();
end;

function fram:CreateDelWindow()
	fram.DelFrame = CreateFrame("Frame","SOMDelFrame",UIParent);
	local delFrame = fram.DelFrame;
	delFrame:ClearAllPoints();
	delFrame:SetPoint("CENTER",UIParent,"TOP",0,-200);
	delFrame:SetHeight(140);
	delFrame:SetWidth(350);
	delFrame:SetFrameStrata("FULLSCREEN_DIALOG");
	delFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true,
		insets = { left = 10, right = 10, top = 10, bottom = 10 }
	});
	delFrame:SetBackdropBorderColor(1.0,1.0,1.0);
	delFrame:SetBackdropColor(0.1,0.1,0.1);
	delFrame.Text1 = delFrame:CreateFontString(nil,"OVERLAY","GameFontNormal");
	delFrame.Text1:SetPoint("CENTER",delFrame,"TOP",0,-30);
	delFrame.Text1:SetText(L["Hover over the item you want to remove"]);
	delFrame.Text2 = delFrame:CreateFontString(nil,"OVERLAY","GameFontNormal");
	delFrame.Text2:SetPoint("TOPLEFT",delFrame,"TOPLEFT",50,-50);
	delFrame.Text2:SetText(L["Press ALT to remove item from sell list"]);
	delFrame.Text3 = delFrame:CreateFontString(nil,"OVERLAY","GameFontNormal");
	delFrame.Text3:SetPoint("TOPLEFT",delFrame,"TOPLEFT",50,-70);
	delFrame.Text3:SetText(L["Press CTRL to remove item from save list"]);
	delFrame.Button = CreateFrame("Button",nil,delFrame,"OptionsButtonTemplate");
	delFrame.Button:SetPoint("CENTER",delFrame,"BOTTOM",0,30);
	delFrame.Button:SetScript("OnClick", function()
		SellOMatic:UnregisterEvent("MODIFIER_STATE_CHANGED");
		delFrame:Hide();
	end);
	delFrame.Button:SetText(L["Done"]);
	delFrame:Hide();
end;

function fram:CreateButtons()
	fram.ButtonFrame = CreateFrame("Frame","SOMButtonFrame",SellButton);
	local bFrame = fram.ButtonFrame;
	bFrame:ClearAllPoints();
	bFrame:SetPoint("TOP",SellButton,"TOP",25,-2);
	bFrame:SetFrameStrata("HIGH");
	bFrame:SetHeight(28);
	bFrame:SetWidth(10);
	bFrame.PlusButton = CreateFrame("Button",nil,bFrame,"OptionsButtonTemplate");
	bFrame.PlusButton:SetPoint("CENTER",bFrame,"TOP",0,-5);
	bFrame.PlusButton:SetWidth(16);
	bFrame.PlusButton:SetHeight(16);
	bFrame.PlusButton:SetText("+");
	bFrame.PlusButton:SetScript("OnClick", function()
		SellOMatic:AddItem();
	end);
	bFrame.MinusButton = CreateFrame("Button",nil,bFrame,"OptionsButtonTemplate");
	bFrame.MinusButton:SetPoint("CENTER",bFrame,"BOTTOM",0,5);
	bFrame.MinusButton:SetWidth(16);
	bFrame.MinusButton:SetHeight(16);
	bFrame.MinusButton:SetText("-");
	bFrame.MinusButton:SetScript("OnClick", function()
		SellOMatic:DelItem();
	end);
	bFrame:Hide();
end;

function fram:CreateResetWindow()
	fram.ResetFrame = CreateFrame("Frame","SOMResetFrame",UIParent);
	local resetFrame = fram.ResetFrame
	resetFrame:ClearAllPoints()
	resetFrame:SetPoint("CENTER",UIParent,"TOP",0,-200)
	resetFrame:SetHeight(100)
	resetFrame:SetWidth(360)
	resetFrame:SetFrameStrata("FULLSCREEN_DIALOG")
	resetFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true,
		insets = { left = 10, right = 10, top = 10, bottom = 10 }
	})
	resetFrame:SetBackdropBorderColor(1.0,1.0,1.0)
	resetFrame:SetBackdropColor(0.1,0.1,0.1)
	resetFrame.Text1 = resetFrame:CreateFontString(nil,"OVERLAY","GameFontNormal")
	resetFrame.Text1:SetPoint("CENTER",resetFrame,"TOP",0,-30)
	resetFrame.Text1:SetText(L["Which list do you want to reset?"])
	resetFrame.Button1 = CreateFrame("Button",nil,resetFrame,"OptionsButtonTemplate")
	resetFrame.Button1:SetPoint("CENTER",resetFrame,"BOTTOM",100,30)
	resetFrame.Button1:SetText(L["Sell List"])
	resetFrame.Button1:SetScript("OnClick", function()
		SellOMatic:EmptyList("sell")
		resetFrame:Hide()
	end)
	resetFrame.Button2 = CreateFrame("Button",nil,resetFrame,"OptionsButtonTemplate")
	resetFrame.Button2:SetPoint("CENTER",resetFrame,"BOTTOM",-100,30)
	resetFrame.Button2:SetText(L["Save List"])
	resetFrame.Button2:SetScript("OnClick", function()
		SellOMatic:EmptyList("save")
		resetFrame:Hide()
	end)
	resetFrame.Button3 = CreateFrame("Button",nil,resetFrame,"OptionsButtonTemplate")
	resetFrame.Button3:SetPoint("CENTER",resetFrame,"BOTTOM",0,30)
	resetFrame.Button3:SetText(L["Cancel"])
	resetFrame.Button3:SetScript("OnClick", function()
		resetFrame:Hide()
	end)
	resetFrame:Hide()
end

function SellOMatic:ShowAddFrame()
	if fram.AddFrame == nil then fram:CreateAddWindow() end;
	fram.AddFrame:Show();
end;

function SellOMatic:ShowDelFrame()
	if fram.DelFrame == nil then fram:CreateDelWindow() end;
	fram.DelFrame:Show();
end;

function SellOMatic:ShowButtonFrame()
	if fram.ButtonFrame == nil then fram:CreateButtons() end;
	fram.ButtonFrame:Show();
end;

function SellOMatic:HideButtonFrame()
	fram.ButtonFrame:Hide();
end;

function SellOMatic:ShowResetFrame()
	if fram.ResetFrame == nil then fram:CreateResetWindow() end
	fram.ResetFrame:Show()
end
