-- $Id: Panel.lua 4201 2013-05-05 16:05:37Z lag123 $
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local buttonPanelLoadet = false

local db
local dbDefaults = {
	profile = {
		buttons = { ["*"] = true }
	},
}

local getOptions
do
 	local function getOpt(info)
		return db.buttons[info[#info]]
	end
	
	local function getOptAtlasLoot(info)
		return AtlasLoot.db.profile[info[#info]]
	end
	
	local function setOpt(info, value)
		db.buttons[info[#info]] = value
		AtlasLoot:RefreshAtlasLootPanel()
		return db.buttons[info[#info]]
	end
	
	local options
	function getOptions()
		if not options then
			options = {
				type = "group",
				name = "AtlasLootPanel",
				order = 600,
				childGroups = "tab",
				args = {
					HidePanel = {
						type = "toggle",
						name = AL["Hide Panel"],--AL["Hide AtlasLoot Panel"],
						--desc = ,
						order = 10,
						get = getOptAtlasLoot,
						set = AtlasLoot.OptionsHidePanel,
					},
					Buttons = {						
						type = "group",
						inline = true,
						name = AL["Buttons"],
						order = 20,
						args = {
						
						},
					},
					
				},
			}
		end
		local order = 1
		
		for buttonOrder,button in ipairs(AtlasLoot:PanelGetSortedButtonsTable()) do
			options.args.Buttons.args[button.saveName] = {
				type = "toggle",
				name = button.clearText or button.text,
				--,
				order = order,
				get = getOpt,
				set = setOpt,
				disabled = button.disabled,
			}
			order = order + 1
		end
		
		if not options.args.Buttons.args[AL["QuickLook"]] then
			options.args.Buttons.args[AL["QuickLook"]] = {
				type = "toggle",
				name = AL["QuickLook"],
				--,
				order = order,
				get = getOpt,
				set = setOpt,
			}
			order = order + 1
		end
		options.args.Buttons.args[AL["QuickLook"]].disabled = not AtlasLoot.db.profile.EnableQuickLook
		
			
		options.args.Buttons.args["SearchFrame"] = {
			type = "toggle",
			name = AL["Search"],
			--,
			order = order,
			get = getOpt,
			set = setOpt,
		}
		return options
	end
	
end

local function Init_ButtonList()
	if AtlasLoot.PanelButtonList then return end
	AtlasLoot.PanelButtonList = {
		WorldEvents = {
			text = AL["World Events"],
			lootPage = "WORLDEVENTMENU",
			order = 10,
		},
		Collections = {
			text = AL["Collections"],
			lootPage = "SETMENU",
			order = 20,
		},
		Factions = {
			text = AL["Factions"],
			lootPage = "REPMENU",
			order = 30,
		},
		PvPRewards = {
			text = AL["PvP Rewards"],
			lootPage = "PVPMENU",
			order = 40,
		},
		Crafting = {
			text = AL["Crafting"],
			lootPage = "CRAFTINGMENU",
			order = 50,
		},
		Options = {
			text = AL["Options"],
			func = AtlasLoot.OptionsToggle,
			order = 70,
		},
		LoadModules = {
			text = AL["Load Modules"],
			func = function() AtlasLoot:LoadModule("all") end,
			order = 80,
		},
	}
end

-- LootPanel
do
	local ButtonListLines = {}
	local panelMaxWidth = 725

	local lastLineButtonList = 1
	local curLineButtonList, curLinePosButtonList = 1, -25
	local numButtonsButtonList, curWidthButtonList = 1, 0
	local startNewLine = true
	local searchFrameWidth = 0
	
	local function ShowSearchFrame(frame)
		if db.buttons.SearchFrame then
			curLinePosButtonList = curLinePosButtonList - 15
			ButtonListLines["SearchFrame"]:SetPoint("CENTER", frame, "TOP", 0, curLinePosButtonList)
			ButtonListLines["SearchFrame"]:Show()
			curLinePosButtonList = curLinePosButtonList - 7
		else
			ButtonListLines["SearchFrame"]:Hide()
		end
	end
	
	local function onShow(self)
		if self:GetParent():GetName() == "UIParent" then
			self:Hide()
		end
	end
	
	local function LootTableButton_OnClick(self)
		if self.lootPageType then AtlasLoot.db.profile.LootTableType = self.lootPageType end
		local done
		if AtlasLoot.DefaultFrame_SetInstance then
			if AtlasLootDefaultFrame and AtlasLootDefaultFrame:IsShown() then
				local tLocation = AtlasLoot:GetTableLoaction(self.lootPage)
				if tLocation and AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]["Info"][2] then
					AtlasLoot:DefaultFrame_SetInstance(AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]["Info"][2], tLocation[2], self.lootPage)
					done = true
				end
			end
		end
		if not done then
			AtlasLoot:ShowLootPage(self.lootPage)
		end
	end
	
	local function LootTableButton_OnEnter(self)
		if self.tt then
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 5);
			GameTooltip:AddLine(self.tt);
			GameTooltip:Show();
		end
	end
	
	local function LootTableButton_OnLeave(self)
		if(GameTooltip:IsVisible()) then
			GameTooltip:Hide();
		end
	end
	
	local function showLastSearchResult()
		AtlasLoot:CompareFrame_Search(AtlasLoot.db.profile.LastSearch, "save")
	end
	
	local function CreateLootTableButton(frame, info)
		if not info then return end
		if not info.text then info.text = info.saveName end
		if not frame["ButtonList"] then frame["ButtonList"] = {} end
		local ButtonFrame, LineFrame
		local pos = numButtonsButtonList
		-- Create new LineFrame 
		if not ButtonListLines[curLineButtonList] then 
			ButtonListLines[curLineButtonList] = CreateFrame("FRAME", nil, frame)
			ButtonListLines[curLineButtonList]:SetHeight(20)
			ButtonListLines[curLineButtonList]:SetWidth(0)
			ButtonListLines[curLineButtonList]:SetPoint("CENTER", frame, "TOP", 0, curLinePosButtonList)
		end
		LineFrame = ButtonListLines[curLineButtonList]
		-- Create new ButtonFrame
		if not frame["ButtonList"][pos] then
			frame["ButtonList"][pos] = CreateFrame("Button", "AtlasLoot_PanelButton_"..pos, LineFrame, "UIPanelButtonTemplate")
		end
		ButtonFrame = frame["ButtonList"][pos]
		-- Set ButtonText and Button Width
		ButtonFrame:SetText(info.text)
		ButtonFrame:SetWidth(ButtonFrame:GetTextWidth()+20)
		ButtonFrame:SetHeight(20)
		if ButtonFrame:GetWidth() < 120 then
			ButtonFrame:SetWidth(120)
		end
		-- Check if we need a new ButtonLine
		curWidthButtonList = curWidthButtonList + ButtonFrame:GetWidth()
		if curWidthButtonList > panelMaxWidth+5 then
			curWidthButtonList = 0
			startNewLine = true
			curLineButtonList = curLineButtonList + 1
			curLinePosButtonList = curLinePosButtonList - 22
			ButtonFrame:Hide()
			CreateLootTableButton(frame, info)
			return
		end
		LineFrame:SetWidth(curWidthButtonList)
		--SetPoint
		if startNewLine then
			ButtonFrame:SetPoint("TOPLEFT", LineFrame, "TOPLEFT")
			startNewLine = false
		else
			ButtonFrame:SetPoint("LEFT", frame["ButtonList"][pos-1], "RIGHT", 0, 0)
		end
		
		ButtonFrame.lootPage = info.lootPage
		ButtonFrame.lootPageType = info.lootPageType
		ButtonFrame:Enable()
		if info.lootPage then
			ButtonFrame:SetScript("OnClick", LootTableButton_OnClick)
		elseif info.func then
			ButtonFrame:SetScript("OnClick", info.func)
		else
			ButtonFrame:SetScript("OnClick", nil)
			ButtonFrame:Disable()
		end
		ButtonFrame.tt = info.tt
		ButtonFrame:SetScript("OnEnter", LootTableButton_OnEnter)
		ButtonFrame:SetScript("OnLeave", LootTableButton_OnLeave)
		ButtonFrame:SetFrameLevel( ButtonFrame:GetParent():GetFrameLevel() + 1 )
		ButtonFrame:Show()
		numButtonsButtonList = numButtonsButtonList + 1
	end
	
	--- Adds an button to the AtlasLoot Panel
	-- @param name the name of the button (Not the displayed name)
	-- @param info table with informations about the button
	-- @usage AtlasLoot:PanelAddButton("TestButton", {name = "Test Button Loc", func = function() print("OnClick") end })
	function AtlasLoot:PanelAddButton(name, info)
		if not AtlasLoot.PanelButtonList then Init_ButtonList() end
		if not AtlasLoot.PanelButtonList[name] then AtlasLoot.PanelButtonList[name] = {} end
		for k,v in pairs(info) do
			AtlasLoot.PanelButtonList[name][k] = v
		end
		info = nil
		if buttonPanelLoadet then
			AtlasLoot:RefreshAtlasLootPanel()
			AtlasLoot:RefreshModuleOptions()
		end
	end
	
	function AtlasLoot:PanelSetButtonEnable(name, value)
		if AtlasLoot.PanelButtonList[name] then
			AtlasLoot.PanelButtonList[name].disabled = not value
			
			if buttonPanelLoadet then
				AtlasLoot:RefreshAtlasLootPanel()
				AtlasLoot:RefreshModuleOptions()
			end
		end
	end
	
	function AtlasLoot:PanelGetSortedButtonsTable()
		local tab = {}
		for k,v in pairs(AtlasLoot.PanelButtonList) do 
			tab[#tab+1] = v 
			tab[#tab].saveName = k
			if not tab[#tab].order then tab[#tab].order = 1000 end
		end
		
		table.sort(tab, function(a,b) return (a.order < b.order) end)
		
		for i = 1,AtlasLoot.db.profile.NumQuickLooks do
			if AtlasLoot.db.profile.QuickLooks[i].lootPage or AtlasLoot.db.profile.ShowUnusedQuickLooks then
				tab[#tab+1] = {
					text = AtlasLoot:GetQuickLookName(i),
					clearText = AL["QuickLook"],
					tt = AtlasLoot:GetQuickLookName(i, true),
					lootPage = AtlasLoot.db.profile.QuickLooks[i].lootPage,
					lootPageType = AtlasLoot.db.profile.QuickLooks[i].lootPageType, --AtlasLoot.db.profile.QuickLooks[num].lootTableType = AtlasLoot.db.profile.LootTableType
					saveName = AL["QuickLook"],
					disabled = not AtlasLoot.db.profile.EnableQuickLook,
				}
			end
		end

		return tab
	end
	
	function AtlasLoot:RefreshAtlasLootPanel()
		db = self.Paneldb.profile
		local Frame = AtlasLoot.AtlasLootPanel
		
		Frame:SetHeight(35)
		Frame:SetWidth(180)
		lastLineButtonList = 1
		curLineButtonList, curLinePosButtonList = 1, -25
		numButtonsButtonList, curWidthButtonList = 1, 0
		startNewLine = true
		if Frame["ButtonList"] then
			for k,v in ipairs(Frame["ButtonList"]) do
				Frame["ButtonList"][k]:Hide()
			end
		end
		for _,button in ipairs(AtlasLoot:PanelGetSortedButtonsTable()) do
			if button and db.buttons[button.saveName] and not button.disabled then
				CreateLootTableButton(Frame, button)
			end
		end
		ShowSearchFrame(Frame)
		Frame:SetHeight(35 + (-(curLinePosButtonList)))
		if curLineButtonList > 1 then
			Frame:SetWidth(745)
		else
			Frame:SetWidth(60 + curWidthButtonList)
		end
		
		if Frame:GetWidth() < 180 then
			Frame:SetWidth(745)
		end
	end

	function AtlasLoot:CreateAtlasLootPanel()
		if AtlasLoot.AtlasLootPanel then return end
		self.Paneldb = AtlasLoot.db:RegisterNamespace("AtlasLootPanel", dbDefaults)
		db = self.Paneldb.profile
		
		AtlasLoot:RegisterModuleOptions("AtlasLootPanel", getOptions, AL["Panel"])
		Init_ButtonList()
		
		AtlasLoot.AtlasLootPanel = CreateFrame("Frame","AtlasLootPanel")

		local Frame = AtlasLoot.AtlasLootPanel
		Frame:ClearAllPoints()
		
		Frame:SetParent(UIParent)
		Frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
		Frame:SetFrameLevel(Frame:GetParent():GetFrameLevel() + 1)
		Frame:SetWidth(180)
		Frame:SetHeight(35)
		Frame:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
								edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
								tile = true, tileSize = 32, edgeSize = 32, 
								insets = { left = 11, right = 12, top = 12, bottom = 11 }})
		Frame:SetScript("OnShow", onShow)

		Frame.TitelBg = Frame:CreateTexture(nil,"ARTWORK")
		Frame.TitelBg:SetPoint("BOTTOM", Frame, "BOTTOM", 0, -35)
		Frame.TitelBg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		Frame.TitelBg:SetHeight(59)
		Frame.TitelBg:SetWidth(275)
			
		Frame.Titel = Frame:CreateFontString(nil,"ARTWORK","GameFontNormal")
		Frame.Titel:SetPoint("BOTTOM", Frame.TitelBg, "BOTTOM", 0, 34)
		Frame.Titel:SetText("Atlasloot Enhanced")

		ButtonListLines["SearchFrame"] = CreateFrame("FRAME", nil, Frame)
		ButtonListLines["SearchFrame"]:SetHeight(20)
		ButtonListLines["SearchFrame"]:SetWidth(0)
		ButtonListLines["SearchFrame"]:SetPoint("CENTER", Frame, "TOP", 0, curLinePosButtonList)
		
		local SearchFrame = ButtonListLines["SearchFrame"]
		
		SearchFrame.SearchBox = CreateFrame("EditBox", "AtlasLootPanelSearch_Box", SearchFrame, "InputBoxTemplate")
		SearchFrame.SearchBox:SetPoint("TOPLEFT", SearchFrame, "TOPLEFT")
		SearchFrame.SearchBox:SetWidth(250)
		SearchFrame.SearchBox:SetHeight(35)
		SearchFrame.SearchBox:SetAutoFocus(false)
		SearchFrame.SearchBox:SetTextInsets(0, 8, 0, 0)
		SearchFrame.SearchBox:SetMaxLetters(100)
		SearchFrame.SearchBox:SetScript("OnEnterPressed",function(self) 
								AtlasLoot:CompareFrame_Search(SearchFrame.SearchBox:GetText(), "save")
								SearchFrame.SearchBox:ClearFocus()
							end)
		searchFrameWidth = searchFrameWidth + SearchFrame.SearchBox:GetWidth()
		
		SearchFrame.Search = CreateFrame("Button","AtlasLootPanelSearch_SearchButton",SearchFrame,"UIPanelButtonTemplate")
		SearchFrame.Search:SetText(AL["Search"])
		SearchFrame.Search:SetWidth(69)
		SearchFrame.Search:SetHeight(20)
		SearchFrame.Search:SetPoint("LEFT", SearchFrame.SearchBox, "RIGHT", 0, 0)
		SearchFrame.Search:SetScript("OnClick",function() 
								AtlasLoot:CompareFrame_Search(SearchFrame.SearchBox:GetText(), "save")
								SearchFrame.SearchBox:ClearFocus()
							end)
		searchFrameWidth = searchFrameWidth + SearchFrame.Search:GetWidth()
					
		
		SearchFrame.SearchSelectModule = AtlasLoot:CreateSearchModuleDropDown(SearchFrame, {"LEFT", SearchFrame.Search, "RIGHT", 0, 0}, "AtlasLootPanelSearch_SelectModuel")
		--[[				
		SearchFrame.SearchOptions = CreateFrame("Button",nil,SearchFrame)
		SearchFrame.SearchOptions:SetWidth(28)
		SearchFrame.SearchOptions:SetHeight(28)
		SearchFrame.SearchOptions:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
		SearchFrame.SearchOptions:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
		SearchFrame.SearchOptions:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
		SearchFrame.SearchOptions:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
		SearchFrame.SearchOptions:SetFrameStrata("HIGH")
		SearchFrame.SearchOptions:SetPoint("LEFT", SearchFrame.Search, "RIGHT", 0, 0)
		SearchFrame.SearchOptions:SetScript("OnClick", AtlasLoot.ShowSearchOptions)
		]]--
		
		SearchFrame.Clear = CreateFrame("Button","AtlasLootPanelSearch_ClearButton",SearchFrame,"UIPanelButtonTemplate")
		SearchFrame.Clear:SetText(AL["Clear"])
		SearchFrame.Clear:SetWidth(58)
		SearchFrame.Clear:SetHeight(20)
		SearchFrame.Clear:SetPoint("LEFT", SearchFrame.SearchSelectModule, "RIGHT", 0, 0)
		SearchFrame.Clear:SetScript("OnClick",function() 
								SearchFrame.SearchBox:SetText("")
								SearchFrame.SearchBox:ClearFocus()
							end)
		searchFrameWidth = searchFrameWidth + SearchFrame.Clear:GetWidth()
							
		SearchFrame.LastResult = CreateFrame("Button","AtlasLootPanelSearch_LastResultButton",SearchFrame,"UIPanelButtonTemplate")
		SearchFrame.LastResult:SetText(AL["Last Result"])
		SearchFrame.LastResult:SetWidth(120)
		SearchFrame.LastResult:SetHeight(20)
		SearchFrame.LastResult:SetPoint("LEFT", SearchFrame.Clear, "RIGHT", 0, 0)
		SearchFrame.LastResult:SetScript("OnClick", showLastSearchResult)	
		searchFrameWidth = searchFrameWidth + SearchFrame.LastResult:GetWidth()
		
		ButtonListLines["SearchFrame"]:SetWidth(searchFrameWidth)
		ButtonListLines["SearchFrame"]:Hide()
		AtlasLoot.AtlasLootPanel:Hide()
		
		AtlasLoot.SearchBox = SearchFrame.SearchBox
		AtlasLoot:RefreshAtlasLootPanel()
		buttonPanelLoadet = true
		Frame:Hide()
	end

end