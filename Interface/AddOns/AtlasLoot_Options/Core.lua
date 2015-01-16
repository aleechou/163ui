local AtlasLoot = _G.AtlasLoot
local Options = {}
local AL = AtlasLoot.Locales

AtlasLoot.Options = Options
local db = AtlasLoot.db

local function ShowTestSet()
	AtlasLoot.GUI.SetViewFrame:SetAtlasLootItemSet("GMTESTSET", "global")
end

-- windows
local function windows(gui, content)
	local last
	
	last = gui:Add("CheckBox")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Always show item comparison."])
		:DB(db.Button.Item, "alwaysShowCompareTT")
		
	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Always show quick preview."])
		:DB(db.Button.Item, "alwaysShowPreviewTT")
end

-- windows -> atlasloot
local function windows_atlasloot(gui, content)
	local last
	
	last = gui:Add("Line")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Main Window"])
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(0.5, 1.5, 0.01)
		:Text(AL["Scale"])
		:DB(db.GUI.mainFrame, "scale", AtlasLoot.GUI.RefreshMainFrame)	
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.mainFrame, "bgColor", AtlasLoot.GUI.RefreshMainFrame)	
	
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Title"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.mainFrame.title, "bgColor", AtlasLoot.GUI.RefreshMainFrame)		
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.GUI.mainFrame.title, "textColor", AtlasLoot.GUI.RefreshMainFrame)	
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(10, 20, 1)
		:Text(AL["Font size"])
		:DB(db.GUI.mainFrame.title, "size", AtlasLoot.GUI.RefreshMainFrame)
		
	last = gui:Add("Button")
		:Point("BOTTOMRIGHT", nil, "BOTTOMRIGHT", -2, 2)
		:Text(AL["Reset frame position"])
		:Click(AtlasLoot.GUI.ResetFrames)
		:Confirm(format(AL["Reset position of the |cff33ff99\"%s\"|r window."], AL["AtlasLoot"]))	
end

local function windows_atlasloot_contenttopbar(gui, content)
	local last

	-- background
	last = gui:Add("Line")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Background"])
		
	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Use content color if available."])
		:DB(db.GUI.contentTopBar, "useContentColor", AtlasLoot.GUI.RefreshContentBackGround)
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.contentTopBar, "bgColor", AtlasLoot.GUI.RefreshContentBackGround)
		
	-- font
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Font"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.GUI.contentTopBar.font, "color", AtlasLoot.GUI.RefreshFonts)	
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(10, 30, 1)
		:Text(AL["Font size"])
		:DB(db.GUI.contentTopBar.font, "size", AtlasLoot.GUI.RefreshFonts)
end

local function windows_atlasloot_content(gui, content)
	local last
	
	last = gui:Add("CheckBox")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Show background image if available."])
		:DB(db.GUI.content, "showBgImage", AtlasLoot.GUI.RefreshContentBackGround)
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.content, "bgColor", AtlasLoot.GUI.RefreshContentBackGround)
end

local function windows_atlasloot_contentbottombar(gui, content)
	local last
		
	last = gui:Add("CheckBox")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Use content color if available."])
		:DB(db.GUI.contentBottomBar, "useContentColor", AtlasLoot.GUI.RefreshContentBackGround)
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.contentBottomBar, "bgColor", AtlasLoot.GUI.RefreshContentBackGround)
end

-- windows -> setview
local function windows_setview(gui, content)
	local last
	
	last = gui:Add("Line")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Main Window"])
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(0.5, 1.5, 0.01)
		:Text(AL["Scale"])
		:DB(db.SetViewFrame.mainFrame, "scale", AtlasLoot.GUI.SetViewFrame.RefreshStyle)	
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.SetViewFrame.mainFrame, "bgColor", AtlasLoot.GUI.SetViewFrame.RefreshStyle)	
	
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Title"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.SetViewFrame.mainFrame.title, "bgColor", AtlasLoot.GUI.SetViewFrame.RefreshStyle)		
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.SetViewFrame.mainFrame.title, "textColor", AtlasLoot.GUI.SetViewFrame.RefreshStyle)	
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(10, 20, 1)
		:Text(AL["Font size"])
		:DB(db.SetViewFrame.mainFrame.title, "size", AtlasLoot.GUI.SetViewFrame.RefreshStyle)
		
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Model"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.SetViewFrame.mainFrame, "bgColorModel", AtlasLoot.GUI.SetViewFrame.RefreshStyle)

		
	-- test
	last = gui:Add("Button")
		:Point("BOTTOMLEFT", nil, "BOTTOMLEFT", 2, 2)
		:Text(AL["Preview"])
		:Click(AtlasLoot.GUI.SetViewFrame.ShowPreviewSet)
		
	last = gui:Add("Button")
		:Point("BOTTOMRIGHT", nil, "BOTTOMRIGHT", -2, 2)
		:Text(AL["Reset frame position"])
		:Click(AtlasLoot.GUI.SetViewFrame.ResetFrames)
		:Confirm(format(AL["Reset position of the |cff33ff99\"%s\"|r window."], AL["Set View"]))	
end

local function windows_setview_contenttopbottom(gui, content)
	local last

	last = gui:Add("Line")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Background"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.SetViewFrame.contentTopBottom, "bgColor", AtlasLoot.GUI.SetViewFrame.RefreshStyle)
		
	-- font
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Font"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.SetViewFrame.contentTopBottom, "textColor", AtlasLoot.GUI.SetViewFrame.RefreshStyle)	
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(5, 20, 1)
		:Text(AL["Font size"])
		:DB(db.SetViewFrame.contentTopBottom, "textSize", AtlasLoot.GUI.SetViewFrame.RefreshStyle)
end

local function windows_setview_content(gui, content)
	local last

	last = gui:Add("Line")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Background"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.SetViewFrame.content, "bgColor", AtlasLoot.GUI.SetViewFrame.RefreshStyle)
		
	-- font
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Font"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.SetViewFrame.content, "textColor", AtlasLoot.GUI.SetViewFrame.RefreshStyle)	
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(5, 20, 1)
		:Text(AL["Font size"])
		:DB(db.SetViewFrame.content, "textSize", AtlasLoot.GUI.SetViewFrame.RefreshStyle)
end

-- windows -> quickloot
local function windows_quickloot(gui, content)
	local last
	
	-- main window
	last = gui:Add("Line")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Main Window"])
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(0.5, 1.5, 0.01)
		:Text(AL["Scale"])
		:DB(db.QuickLootFrame.mainFrame, "scale", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)	
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.QuickLootFrame.mainFrame, "bgColor", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)	
	
	-- Title
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Title"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.QuickLootFrame.mainFrame.title, "bgColor", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)		
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.QuickLootFrame.mainFrame.title, "textColor", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)	
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(10, 20, 1)
		:Text(AL["Font size"])
		:DB(db.QuickLootFrame.mainFrame.title, "size", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)
		
	-- SUbTitle
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Subtitle"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.QuickLootFrame.mainFrame.subTitle, "bgColor", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)		
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.QuickLootFrame.mainFrame.subTitle, "textColor", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)	
		
	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(10, 20, 1)
		:Text(AL["Font size"])
		:DB(db.QuickLootFrame.mainFrame.subTitle, "size", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)
	
	-- Content
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Content"])
		
	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.QuickLootFrame.mainFrame.content, "bgColor", AtlasLoot.GUI.QuickLootFrame.RefreshStyle)		
	
	-- test
	last = gui:Add("Button")
		:Point("BOTTOMLEFT", nil, "BOTTOMLEFT", 2, 2)
		:Text(AL["Preview"])
		:Click(AtlasLoot.Addons.BonusRoll.Preview)
		
	last = gui:Add("Button")
		:Point("BOTTOMRIGHT", nil, "BOTTOMRIGHT", -2, 2)
		:Text(AL["Reset frame position"])
		:Click(AtlasLoot.GUI.QuickLootFrame.ResetFrames)
		:Confirm(format(AL["Reset position of the |cff33ff99\"%s\"|r window."], AL["Quick Loot"]))	
end

-- minimap Button
local function minimapbutton(gui, content)
	local last
	last = gui:Add("CheckBox")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Show minimap button."])
		:DB(db.MiniMapButton, "shown", AtlasLoot.MiniMapButton.Options_Toggle)
		
	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Lock minimap button around minimap."])
		:DB(db.MiniMapButton, "lockedAroundMiniMap")			
		
	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Lock minimap button."])
		:DB(db.MiniMapButton, "locked")	
		
	last = gui:Add("Button")
		:Point("BOTTOMRIGHT", nil, "BOTTOMRIGHT", -2, 2)
		:Text(AL["Reset position of minimap button"])
		:Click(AtlasLoot.MiniMapButton.ResetFrames)
		:Confirm(AL["Reset position of the |cff33ff99\"Minimap button\"|r."])	
end

-- addons -> bonusloot
local function addons_bonusloot(gui, content)
	gui:Add("CheckBox")
		:Point("TOPLEFT")
		:Size("half")
		:Text(ENABLE)
		:DB(db.Addons.BonusRoll, "enabled")
end

local ALOptions = LibStub("ALOptions-1.0"):Register(AL["AtlasLoot"], AL["AtlasLoot Options"], AtlasLoot.__addonrevision, AtlasLoot.db.profile, {
	{
		title = AL["Windows"],
		--desc = "",
		quickSelect = "start",
		clickFunc = windows,
		content = {
			{
				title = AL["AtlasLoot"],
				--desc = "",
				clickFunc = windows_atlasloot,
				content = {
					{
						title = AL["Content top bar"],
						--desc = "",
						clickFunc = windows_atlasloot_contenttopbar,
					},
					{
						title = AL["Content"],
						--desc = "",
						clickFunc = windows_atlasloot_content,
					},
					{
						title = AL["Content bottom bar"],
						--desc = "",
						clickFunc = windows_atlasloot_contentbottombar,
					},
				},
			},
			{
				title = AL["Set View"],
				--desc = "",
				clickFunc = windows_setview,
				content = {
					{
						title = AL["Content top/bottom bar"],
						--desc = "",
						clickFunc = windows_setview_contenttopbottom,
					},
					{
						title = AL["Content"],
						--desc = "",
						clickFunc = windows_setview_content,
					},
				}
			},
			{
				title = AL["Quick Loot"],
				--desc = "",
				clickFunc = windows_quickloot,
			}
		},
	},
	{
		title = AL["Minimap Button"],
		--desc = "Test 2 description",
		clickFunc = minimapbutton,
	},
	{
		title = ADDONS,
		--desc = "Test 2 description",
		--clickFunc = test2,
		content = {
			{
				title = AL["Bonus Loot"],
				desc = AL["A window with possible loot is shown if a Bonus Roll is started."],
				clickFunc = addons_bonusloot,
			},
		},
	},

})

local fistShown = true
function Options:Show()
	ALOptions:Show(fistShown and "start" or nil)
	fistShown = nil
end
--[[
function Options.Init()
	
end
AtlasLoot:AddInitFunc(Options.Init, "AtlasLoot_Options")
]]--