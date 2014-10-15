--
-- JSHB - LibSharedMedia interface without needing the library
--

local tableinsert = table.insert

JSHB.defaultFonts = {
	{ text = "Arial Narrow", 		value = "Fonts\\ARIALN.TTF", 											font = "Fonts\\ARIALN.TTF" },
	{ text = "Big Noodle", 			value = "Interface\\AddOns\\JSHB\\media\\fonts\\BigNoodle.ttf", 	font = "Interface\\AddOns\\JSHB\\media\\fonts\\BigNoodle.ttf" },
	{ text = "Friz Quadrata TT", 	value = "Fonts\\FRIZQT__.TTF", 											font = "Fonts\\FRIZQT__.TTF" },
	{ text = "Morpheus", 			value = "Fonts\\MORPHEUS.ttf", 											font = "Fonts\\MORPHEUS.ttf" },
	{ text = "Skurri", 				value = "Fonts\\skurri.ttf", 											font = "Fonts\\skurri.ttf" }
}

JSHB.defaultTextures = { -- statusbar
	{ text = "Blank", 				value = "Interface\\AddOns\\JSHB\\media\\textures\\blank.tga", 	statusbar = "Interface\\AddOns\\JSHB\\media\\textures\\blank.tga" },
	{ text = "Blizzard",			value = "Interface\\TargetingFrame\\UI-StatusBar", 						statusbar = "Interface\\TargetingFrame\\UI-StatusBar" },
	{ text = "Solid", 				value = "Interface\\AddOns\\JSHB\\media\\textures\\solid.tga", 	statusbar = "Interface\\AddOns\\JSHB\\media\\textures\\solid.tga" },
	{ text = "Glaze",				value = "Interface\\AddOns\\JSHB\\media\\textures\\glaze.tga", 	statusbar = "Interface\\AddOns\\JSHB\\media\\textures\\glaze.tga" },
	{ text = "Otravi",				value = "Interface\\AddOns\\JSHB\\media\\textures\\otravi.tga", 	statusbar = "Interface\\AddOns\\JSHB\\media\\textures\\otravi.tga" },
	{ text = "Smooth",				value = "Interface\\AddOns\\JSHB\\media\\textures\\smooth.tga", 	statusbar = "Interface\\AddOns\\JSHB\\media\\textures\\smooth.tga" }
}

JSHB.defaultBorders = {
	{ text = "None", 						value = "", 															border = "" },
	{ text = "Blizzard Achievement Wood", 	value = "Interface\\AchievementFrame\\UI-Achievement-WoodBorder", 		border = "Interface\\AchievementFrame\\UI-Achievement-WoodBorder" },
	{ text = "Blizzard Chat Bubble", 		value = "Interface\\Tooltips\\ChatBubble-Backdrop", 					border = "Interface\\Tooltips\\ChatBubble-Backdrop" },
	{ text = "Blizzard Dialog", 			value = "Interface\\DialogFrame\\UI-DialogBox-Border", 					border = "Interface\\DialogFrame\\UI-DialogBox-Border" },
	{ text = "Blizzard Dialog Gold", 		value = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border", 			border = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border" },
	{ text = "Blizzard Party", 				value = "Interface\\CHARACTERFRAME\\UI-Party-Border", 					border = "Interface\\CHARACTERFRAME\\UI-Party-Border" },
	{ text = "Blizzard Tooltip", 			value = "Interface\\Tooltips\\UI-Tooltip-Border", 						border = "Interface\\Tooltips\\UI-Tooltip-Border" },
	{ text = "Solid", 						value = "Interface\\AddOns\\JSHB\\media\\textures\\solid.tga", 	border = "Interface\\AddOns\\JSHB\\media\\textures\\solidborder.tga" }
}

JSHB.defaultBackgrounds = {
	{ text = "None", 							value = "", 																		background = "" },
	{ text = "Blizzard Dialog Background", 		value = "Interface\\DialogFrame\\UI-DialogBox-Background", 							background = "Interface\\DialogFrame\\UI-DialogBox-Background" },
	{ text = "Blizzard Dialog Background Dark", value = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", 					background = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark" },
	{ text = "Blizzard Dialog Background Gold", value = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background",						background = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background" },
	{ text = "Blizzard Low Health", 			value = "Interface\\FullScreenTextures\\LowHealth", 								background = "Interface\\FullScreenTextures\\LowHealth" },
	{ text = "Blizzard Marble", 				value = "Interface\\FrameGeneral\\UI-Background-Marble", 							background = "Interface\\FrameGeneral\\UI-Background-Marble" },
	{ text = "Blizzard Out of Control", 		value = "Interface\\FullScreenTextures\\OutOfControl", 								background = "Interface\\FullScreenTextures\\OutOfControl" },
	{ text = "Blizzard Parchment", 				value = "Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal", 		background = "Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal" },
	{ text = "Blizzard Parchment 2", 			value = "Interface\\AchievementFrame\\UI-GuildAchievement-Parchment-Horizontal", 	background = "Interface\\AchievementFrame\\UI-GuildAchievement-Parchment-Horizontal" },
	{ text = "Blizzard Rock", 					value = "Interface\\FrameGeneral\\UI-Background-Rock", 								background = "Interface\\FrameGeneral\\UI-Background-Rock" },
	{ text = "Blizzard Tabard Background", 		value = "Interface\\TabardFrame\\TabardFrameBackground", 							background = "Interface\\TabardFrame\\TabardFrameBackground" },
	{ text = "Blizzard Tooltip", 				value = "Interface\\Tooltips\\UI-Tooltip-Background", 								background = "Interface\\Tooltips\\UI-Tooltip-Background" },
	{ text = "Solid", 							value = "Interface\\Buttons\\WHITE8X8", 											background = "Interface\\Buttons\\WHITE8X8" }
}

JSHB.defaultSounds = {
	{ text = "Default",			value = "Sound\\interface\\RaidWarning.wav", 					sound = "Sound\\interface\\RaidWarning.wav" },
	{ text = "Alliance Bell", 	value = "Sound\\Doodad\\BellTollAlliance.wav", 					sound = "Sound\\Doodad\\BellTollAlliance.wav" },
	{ text = "Cannon Blast", 	value = "Sound\\Doodad\\Cannon01_BlastA.wav", 					sound = "Sound\\Doodad\\Cannon01_BlastA.wav" },
	{ text = "Classic", 		value = "Sound\\Doodad\\BellTollNightElf.wav", 					sound = "Sound\\Doodad\\BellTollNightElf.wav" },
	{ text = "Ding", 			value = "Sound\\interface\\AlarmClockWarning3.wav", 			sound = "Sound\\interface\\AlarmClockWarning3.wav" },
	{ text = "Dynamite", 		value = "Sound\\Spells\\DynamiteExplode.wav", 					sound = "Sound\\Spells\\DynamiteExplode.wav" },
	{ text = "Gong", 			value = "Sound\\Doodad\\G_GongTroll01.wav", 					sound = "Sound\\Doodad\\G_GongTroll01.wav" },
	{ text = "Horde Bell", 		value = "Sound\\Doodad\\BellTollHorde.wav",						sound = "Sound\\Doodad\\BellTollHorde.wav" },
	{ text = "Raid Warning",	value = "Sound\\interface\\RaidWarning.wav", 					sound = "Sound\\interface\\RaidWarning.wav" },
	{ text = "Serpent", 		value = "Sound\\Creature\\TotemAll\\SerpentTotemAttackA.wav", 	sound = "Sound\\Creature\\TotemAll\\SerpentTotemAttackA.wav" },
	{ text = "Tribal Bell", 	value = "Sound\\Doodad\\BellTollTribal.wav", 					sound = "Sound\\Doodad\\BellTollTribal.wav" }
}

local function CheckIfTableHasKey(tbl, key, checkFor, newEntry)
	for i=1,#tbl do
		if (tbl[i][key] == checkFor) then
			return
		end
	end
	tableinsert(tbl, newEntry)
end

function JSHB.GetLSMValueByKey(tbl, key, defaultKey, returnKey)
	for i=1,#tbl do
		if (tbl[i].text == key) then
			return tbl[i][returnKey or "value"]
		end
	end
	if defaultKey then
		return JSHB.GetLSMValueByKey(tbl, defaultKey, nil, returnKey)
	end
	return nil
end

function JSHB.MakeLSMHashTable(tbl, valueKeyStr)
	local newTable = {}
	for k, v in pairs(tbl) do
		newTable[v.text] = v[valueKeyStr]
	end
	return newTable
end

local LSM3 = nil
function JSHB.GetLibSharedMedia3()
	if LSM3 then return LSM3 end
	if (LibStub and LibStub("LibSharedMedia-3.0", true) ) then
		LSM3 = LibStub("LibSharedMedia-3.0", true)
		LSM3.RegisterCallback(JSHB, "LibSharedMedia_Registered", "UpdateSharedMedia3")
	end
	return LSM3
end

--
-- Callback/update function for registering our media to LSM3 and vice-versa
--
function JSHB.UpdateSharedMedia3(mediatype, key, val)
	if JSHB.GetLibSharedMedia3() then
		if (val == "font") or (mediatype == nil) then
			for i=1,#JSHB.defaultFonts do
				JSHB.GetLibSharedMedia3():Register("font", JSHB.defaultFonts[i].text, JSHB.defaultFonts[i].font)
			end
			for k,v in next, JSHB.GetLibSharedMedia3():HashTable("font") do
				if k ~= "None" then
					CheckIfTableHasKey(JSHB.defaultFonts, "text", k, {text=k, value=v, font=v})
				end
			end
		end
		if (val == "statusbar") or (mediatype == nil) then
			for i=1,#JSHB.defaultTextures do
				JSHB.GetLibSharedMedia3():Register("statusbar", JSHB.defaultTextures[i].text, JSHB.defaultTextures[i].statusbar)
			end
			for k,v in next, JSHB.GetLibSharedMedia3():HashTable("statusbar") do
				if k ~= "None" then
					CheckIfTableHasKey(JSHB.defaultTextures, "text", k, {text=k, value=v, statusbar=v})
				end
			end
		end
		if (val == "border") or (mediatype == nil) then	
			for i=1,#JSHB.defaultBorders do
				JSHB.GetLibSharedMedia3():Register("border", JSHB.defaultBorders[i].text, JSHB.defaultBorders[i].border)
			end
			for k,v in next, JSHB.GetLibSharedMedia3():HashTable("border") do
				if k ~= "None" then
					CheckIfTableHasKey(JSHB.defaultBorders, "text", k, {text=k, value=v, border=v})
				end
			end
		end
		if (val == "background") or (mediatype == nil) then	
			for i=1,#JSHB.defaultBackgrounds do
				JSHB.GetLibSharedMedia3():Register("background", JSHB.defaultBackgrounds[i].text, JSHB.defaultBackgrounds[i].background)
			end
			for k,v in next, JSHB.GetLibSharedMedia3():HashTable("background") do
				if k ~= "None" then
					CheckIfTableHasKey(JSHB.defaultBackgrounds, "text", k, {text=k, value=v, border=v})
				end
			end
		end
		if (val == "sound") or (mediatype == nil) then	
			for i=1,#JSHB.defaultSounds do
				JSHB.GetLibSharedMedia3():Register("sound", JSHB.defaultSounds[i].text, JSHB.defaultSounds[i].sound)
			end
			for k,v in next, JSHB.GetLibSharedMedia3():HashTable("sound") do
				if k ~= "None" then
					CheckIfTableHasKey(JSHB.defaultSounds, "text", k, {text=k, value=v, sound=v})
				end
			end
		end
	end
end

--
-- Call the update function on load, if LSM3 was loaded it'll be pre-populated
-- if it was not found on load, it'll try to update when JSHB.GetLibSharedMedia3() is called
--
JSHB.UpdateSharedMedia3()

--[[
-- For testing that we are actually populating local tables
function JSHB.testit()
	for i=1,#JSHB.defaultTextures do
		print(JSHB.defaultTextures[i].text)
	end
end
--]]
