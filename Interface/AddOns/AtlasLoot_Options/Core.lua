local AtlasLoot = _G.AtlasLoot
local Options = {}
local AL = AtlasLoot.Locales

AtlasLoot.Options = Options
local db = AtlasLoot.db

local function test(gui, content)
	gui:Add("Text")
		:Text("Test")
		:Point("CENTER")
		:Size(200, 20)
		
	local line = gui:Add("Line")
		:Point("TOP")
		:Size("full")
		--:Text("Test")	
		
	gui:Add("CheckBox")
		:Point("TOP", line, "BOTTOM", 0, -10)
		:Size("half")
		:Text("Compare allways show test")
		:DB(db.Button.Item, "alwaysShowCompareTT")
end

local function test2(gui, content)
	local testText = gui:Add("Text")
		:Text("MUHKUH")
		:Point("TOP")
		:Size("full", 20)
		:Color("white")
		:Tooltip("text")
	
	gui:Add("Line")
		:Point("TOPLEFT", testText, "BOTTOMLEFT", 0, -15)
		:Size("full")
		:Text("Test")
end

local function test3(gui, content)
	local testText = gui:Add("Text")
		:Text("This is a SubCat :O")
		:Point("TOP")
		:Size("full", 20)
		:Color("blue")
		:Tooltip(content.title, content.desc)
	
	gui:Add("Line")
		:Point("TOPLEFT", testText.frame, "BOTTOMLEFT", 0, -15)
		:Size("full")
		:Text("Test Line")
end

-- atlasloot
local function atlasloot_beta4(gui, content)
	local mmShown = gui:Add("CheckBox")
		:Point("TOPLEFT", hideBGImage)
		:Size("full")
		:Text("Show Button on Minimap.")
		:DB(db.MiniMapButton, "shown", AtlasLoot.MiniMapButton.Options_Toggle)

	local alwaysShowCompareTT = gui:Add("CheckBox")
		:Point("TOP", mmShown, "BOTTOM")
		:Size("full")
		:Text("Always show Compare Tooltip for items.")
		:DB(db.Button.Item, "alwaysShowCompareTT")

	local hideBGImage = gui:Add("CheckBox")
		:Point("TOP", alwaysShowCompareTT, "BOTTOM")
		:Size("full")
		:Text("Hide the background images behind loottables.")
		:DB(db.GUI, "hideBGImage")
end

-- windows
local function windows(gui, content)
	
end

-- windows -> atlasloot
local function windows_atlasloot(gui, content)
	
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
		title = AL["AtlasLoot"],
		desc = "Beta 4 Options.\nFOR TESTS. NOT FINAL!!!",
		quickSelect = "start",
		clickFunc = atlasloot_beta4,
	},
	--[[
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
			},
		},
	},
	]]--
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


function Options:Show()
	ALOptions:Show("start")
end
--[[
function Options.Init()
	
end
AtlasLoot:AddInitFunc(Options.Init, "AtlasLoot_Options")
]]--