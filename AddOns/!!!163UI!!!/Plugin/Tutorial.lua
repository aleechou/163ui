local ids = {1,}
local function GetPrevCompleatedTutorial(id)
    for i=2, #ids do
        if ids[i]==id then return ids[i-1] end
    end
end

local function GetNextCompleatedTutorial(id)
    for i=1, #ids-1 do
        if ids[i]==id then return ids[i+1] end
    end
end

local MAX_TUTORIAL_VERTICAL_TILE = 30;
local MAX_TUTORIAL_IMAGES = 1;

local TutorialU1Frame_TOP_HEIGHT = 80;
local TutorialU1Frame_MIDDLE_HEIGHT = 10;
local TutorialU1Frame_BOTTOM_HEIGHT = 30;
local TutorialU1Frame_WIDTH = 364;

local DISPLAY_DATA = {
	-- layers can be BACKGROUND, BORDER, ARTWORK, OVERLAY, HIGHLIGHT
	-- if you don't assign one it will default to ARTWORK

--[[
	[1] = { --TUTORIAL_QUESTGIVERS
		tileHeight = 30,
        text = "任务NPC头顶上都会有一个感叹号(\124TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0\124t)。|cffffd200右键点击|r他们可以获得一个任务。任务NPC头顶上都会有一个感叹号(\124TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0\124t)。|cffffd200右键点击|r他们可以获得一个任务。任务NPC头顶上都会有一个感叹号(\124TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0\124t)。|cffffd200右键点击|r他们可以获得一个任务。任务NPC头顶上都会有一个感叹号(\124TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0\124t)。|cffffd200右键点击|r他们可以获得一个任务。任务NPC头顶上都会有一个感叹号(\124TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0\124t)。|cffffd200右键点击|r他们可以获得一个任务。",
        title = "aaf发发发",
		textBox = {topLeft_xOff = 33, topLeft_yOff = -290, bottomRight_xOff = -29, bottomRight_yOff = 35},
		imageData1 = { "Interface\\AddOns\\!!!163UI.pics!!!\\!tdDropDown", 0, .1953125, 0, 1, w = 320, h = 250, }, --256, 200
	},
]]
};
--U1TUTORIAL_DISPLAY_DATA = DISPLAY_DATA

function TutorialU1Frame_OnLoad(self)
    CoreUIMakeMovable(TutorialU1Frame)
	for i = 1, MAX_TUTORIAL_VERTICAL_TILE do
		local texture = self:CreateTexture("TutorialU1FrameLeft"..i, "BORDER");
		texture:SetTexture("Interface\\TutorialFrame\\UI-TUTORIAL-FRAME");
		texture:SetTexCoord(0.3066406, 0.3261719, 0.656250025, 0.675781275);
		texture:SetSize(11, 10);
		texture = self:CreateTexture("TutorialU1FrameRight"..i, "BORDER");
		texture:SetTexture("Interface\\TutorialFrame\\UI-TUTORIAL-FRAME");
		texture:SetTexCoord(0.3496094, 0.3613281, 0.656250025, 0.675781275);
		texture:SetSize(7, 10);
    end
	TutorialU1FrameLeft1:SetPoint("TOPLEFT", TutorialU1FrameTop, "BOTTOMLEFT", 6, 0);
	TutorialU1FrameRight1:SetPoint("TOPRIGHT", TutorialU1FrameTop, "BOTTOMRIGHT", -1, 0);
	
	for i = 1, MAX_TUTORIAL_IMAGES do
		local texture = self:CreateTexture("TutorialU1FrameImage"..i, "ARTWORK");
        local border = self:CreateTexture();
        border:SetTexture("Interface\\BUTTONS\\UI-Quickslot-Depress")
        border:SetTexCoord(.06, .94, .06, .94)
        border:SetVertexColor(0, 0, 0)
        texture.border = border
	end

	TutorialU1Frame_ClearTextures();
end

function TutorialU1Frame_OnEvent(self, event, ...)
	if ( event == "DISPLAY_SIZE_CHANGED" ) then
		TutorialU1Frame_Update(TutorialU1Frame.id);
	end
end

function TutorialU1Frame_OnShow(self)
	self:RegisterEvent("DISPLAY_SIZE_CHANGED");
	TutorialU1Frame_CheckNextPrevButtons();
end

function TutorialU1Frame_OnHide(self)
	self:UnregisterEvent("DISPLAY_SIZE_CHANGED");
end

function TutorialU1Frame_CheckNextPrevButtons()
	local prevTutorial = GetPrevCompleatedTutorial(TutorialU1Frame.id);
	while ( prevTutorial and DISPLAY_DATA[prevTutorial].tileHeight == 0) do
		prevTutorial = GetPrevCompleatedTutorial(prevTutorial);
	end
	if ( prevTutorial ) then
		TutorialU1FramePrevButton:Enable();
	else
		TutorialU1FramePrevButton:Disable();
	end
	
	local nextTutorial = GetNextCompleatedTutorial(TutorialU1Frame.id);
	while ( nextTutorial and DISPLAY_DATA[nextTutorial].tileHeight == 0) do
		nextTutorial = GetNextCompleatedTutorial(nextTutorial);
	end	
	if ( nextTutorial ) then
		TutorialU1FrameNextButton:Enable();
	else
		TutorialU1FrameNextButton:Disable();
	end
end

function TutorialU1Frame_Update(currentTutorial)
	TutorialU1Frame_ClearTextures();
	TutorialU1Frame.id = currentTutorial;

	local displayData = DISPLAY_DATA[ currentTutorial ];
	if ( not displayData ) then
		return;
	end

	local _, className = UnitClass("player");
	local _, raceName  = UnitRace("player");
	className = strupper(className);
	raceName = strupper(raceName);
	if ( className == "DEATHKNIGHT") then
		raceName = "DEATHKNIGHT";
	end

    -- setup the frame
--[[
	if (displayData.anchorData) then
		local anchorData = displayData.anchorData;
		TutorialU1Frame:SetPoint( anchorData.align, UIParent, anchorData.align, anchorData.xOff, anchorData.yOff );
	end
]]

    local anchorParentLeft = TutorialU1FrameLeft1;
    local anchorParentRight = TutorialU1FrameRight1;
    for i = 2, displayData.tileHeight do
        local leftTexture = _G["TutorialU1FrameLeft"..i];
        local rightTexture = _G["TutorialU1FrameRight"..i];
        leftTexture:SetPoint("TOPLEFT", anchorParentLeft, "BOTTOMLEFT", 0, 0);
        rightTexture:SetPoint("TOPRIGHT", anchorParentRight, "BOTTOMRIGHT", 0, 0);
        leftTexture:Show();
        rightTexture:Show();
        anchorParentLeft = leftTexture;
        anchorParentRight = rightTexture;
    end
    TutorialU1FrameBottom:SetPoint("TOPLEFT", anchorParentLeft, "BOTTOMLEFT", 0, 0);
    TutorialU1FrameBottom:SetPoint("TOPRIGHT", anchorParentRight, "TOPRIGHT", 0, 0);

    local height = TutorialU1Frame_TOP_HEIGHT + (displayData.tileHeight * TutorialU1Frame_MIDDLE_HEIGHT) + TutorialU1Frame_BOTTOM_HEIGHT;
    TutorialU1Frame:SetSize(TutorialU1Frame_WIDTH, height);

	if (displayData.raidwarning) then
		RaidNotice_AddMessage(RaidWarningFrame, text, HIGHLIGHT_FONT_COLOR);
		return;
	end
	
	-- setup the title
	-- check for race-class specific first, then race specific, then class, then normal
	if (displayData.tileHeight > 0) then
        if (displayData.title) then
            TutorialU1FrameTitle:SetText(displayData.title);
        end
    end

	if (displayData.text) then
		TutorialU1FrameText:SetText(displayData.text);
	end
	
	if (displayData.textBox) then
		if(displayData.textBox.font) then
			TutorialU1FrameText:SetFontObject(displayData.textBox.font);
		end
		TutorialU1FrameTextScrollFrame:SetPoint("TOPLEFT", TutorialU1Frame, "TOPLEFT", displayData.textBox.topLeft_xOff, displayData.textBox.topLeft_yOff);
		TutorialU1FrameTextScrollFrame:SetPoint("BOTTOMRIGHT", TutorialU1Frame, "BOTTOMRIGHT", displayData.textBox.bottomRight_xOff, displayData.textBox.bottomRight_yOff);
	end

	-- setup the callout
	local callOut = displayData.callOut;
	if(callOut) then
		if ( callOut.align2 ) then
			TutorialU1FrameCallOut:SetPoint( callOut.align2, callOut.parent, callOut.align2, callOut.xOff2, callOut.yOff2 );
		else
			TutorialU1FrameCallOut:SetSize(callOut.width, callOut.height);
		end
		TutorialU1FrameCallOut:SetPoint( callOut.align, callOut.parent, callOut.align, callOut.xOff, callOut.yOff );
		TutorialU1FrameCallOut:Show();
	end

	-- setup images
	for i = 1, MAX_TUTORIAL_IMAGES do
		local imageTexture = _G["TutorialU1FrameImage"..i];
		local imageData = displayData["imageData"..i];
		if(imageData and imageTexture) then
            local file, left, right, top, bottom = imageData[1], imageData[2], imageData[3], imageData[4], imageData[5]
            imageTexture:SetTexture(file);
            imageTexture:SetTexCoord(left or 0, right or 1, top or 0, bottom or 1);
			imageTexture:SetPoint( "TOP", TutorialU1Frame, 5, -40);
            if imageData.w then
                imageTexture:SetSize(imageData.w, imageData.h)
            end
    		imageTexture:SetDrawLayer(imageData.layer or "BACKGROUND", 1);
            imageTexture.border:SetDrawLayer(imageData.layer or "BACKGROUND", 2);
            imageTexture.border:SetAllPoints(imageTexture)
			imageTexture:Show();
		elseif( imageTexture ) then
			imageTexture:ClearAllPoints();
			imageTexture:SetTexture("");
			imageTexture:Hide();
		end
	end

	-- show
    ShowUIPanel(TutorialU1Frame)
	--TutorialU1Frame:Show();
	TutorialU1Frame_CheckNextPrevButtons();
end

function TutorialU1Frame_ClearTextures()
	--TutorialU1Frame:ClearAllPoints();
	TutorialU1FrameBottom:ClearAllPoints();
	TutorialU1FrameTextScrollFrame:ClearAllPoints();
	TutorialU1FrameText:SetFontObject(GameFontNormal);
	TutorialU1FrameText:SetText("");
	TutorialU1FrameBackground:SetAlpha(1.0);

    -- top & left1 & right1 never have thier anchors changed; or are independantly hidden
	for i = 2, MAX_TUTORIAL_VERTICAL_TILE do
		local leftTexture = _G["TutorialU1FrameLeft"..i];
		local rightTexture = _G["TutorialU1FrameRight"..i];
		leftTexture:ClearAllPoints();
		rightTexture:ClearAllPoints();
		leftTexture:Hide();
		rightTexture:Hide();
	end

	for i = 1, MAX_TUTORIAL_IMAGES do
		local imageTexture = _G["TutorialU1FrameImage"..i];
		imageTexture:ClearAllPoints();
		imageTexture:SetTexture("");
		imageTexture:Hide();
	end

end

function TutorialU1FramePrevButton_OnClick(self)
	PlaySound("igMainMenuOptionCheckBoxOn");
	local prevTutorial = GetPrevCompleatedTutorial(TutorialU1Frame.id);
	while ( prevTutorial and DISPLAY_DATA[prevTutorial].tileHeight == 0) do
		prevTutorial = GetPrevCompleatedTutorial(prevTutorial);
	end
	if ( prevTutorial ) then
		TutorialU1Frame_Update(prevTutorial);
	end
end

function TutorialU1FrameNextButton_OnClick(self)
	PlaySound("igMainMenuOptionCheckBoxOn");
	local nextTutorial = GetNextCompleatedTutorial(TutorialU1Frame.id);
	while ( nextTutorial and DISPLAY_DATA[nextTutorial].tileHeight == 0) do
		nextTutorial = GetNextCompleatedTutorial(nextTutorial);
	end
	if ( nextTutorial ) then
		TutorialU1Frame_Update(nextTutorial);
	end
end

function TutorialU1Frame_Hide()
	PlaySound("igMainMenuClose");
	HideUIPanel(TutorialU1Frame);
end

function TutorialU1Frame_SetTutorial(datas)
    table.wipe(ids);
    for k, v in pairs(datas) do
        DISPLAY_DATA[k] = v
        table.insert(ids, k)
    end
    table.sort(ids)
    TutorialU1Frame_Update(ids[1])
end