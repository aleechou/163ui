local L = Carbonite_Strings
local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxQuest - Quest stuff
-- Copyright 2007-2012 Carbon Based Creations, LLC
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Carbonite - Addon for World of Warcraft(tm)
-- Copyright 2007-2012 Carbon Based Creations, LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Quest general

function Nx.Quest:OptsReset()

	local qopts = Nx:GetQuestOpts()

	qopts.NXShowHeaders = true
	qopts.NXSortWatchMode = 1

	qopts.NXWAutoMax = nil
	qopts.NXWVisMax = 8
	qopts.NXWShowOnMap = true
	qopts.NXWWatchParty = true

	qopts.NXWHideUnfinished = false
	qopts.NXWHideGroup = false
	qopts.NXWHideNotInZone = false
	qopts.NXWHideNotInCont = false
	qopts.NXWHideDist = 20000

	qopts.NXWPriDist = 1
	qopts.NXWPriComplete = 50
	qopts.NXWPriLevel = 20

	qopts.NXWPriGroup = -100			-- Not used yet
end

--------
-- DEBUG

--function Nx.Quest.SelectQuestLogEntry (qn)
--	Nx.prt ("QSel %s", qn)
--	Nx.Quest.OldSelectQuestLogEntry (qn)
--end

--------
-- Init quest and watch data and windows

function Nx.Quest:Init()

--	hooksecurefunc ("WatchFrame_Update", self.WatchFrame_Update)


	local opts = Nx:GetGlobalOpts()

	self.Enabled = opts["QEnable"]
	if not self.Enabled then

--		Nx.Quest = nil
		Nx.Quests = nil	-- Data
		return
	end

    --warbaby add to prevent UIParent manage
    QuestLogFrame:SetAttribute("UIPanelLayout-defined",true)
    QuestLogFrame:SetAttribute("UIPanelLayout-area",nil)
    QuestLogFrame:SetAttribute("UIPanelLayout-pushable",nil)
	
	self.GOpts = opts

	if opts["QWBlizzModify"] then
--		if not GetCVarBool ("advancedWatchFrame") then
--			SetCVar ("questFadingDisable", 1)	--V4 gone
			SetCVar ("autoQuestProgress", 0)
			SetCVar ("autoQuestWatch", 0)
--			SetCVar ("advancedWatchFrame", 1)
--			SetCVar ("watchFrameIgnoreCursor", 0)
--		end
	end

	-- DEBUG
--	self.OldSelectQuestLogEntry = SelectQuestLogEntry
--	SelectQuestLogEntry = Nx.Quest.SelectQuestLogEntry

	-- Force it to create/enable and then we disable
	GetUIPanelWidth (QuestLogFrame)
	QuestLogFrame:SetAttribute ("UIPanelLayout-enabled", false)

	if QuestLogDetailFrame then	-- Patch 3.2
		GetUIPanelWidth (QuestLogDetailFrame)
		QuestLogDetailFrame:SetAttribute ("UIPanelLayout-enabled", false)
	end

	local Map = Nx.Map

	self.QuestStartEnd = Nx.QuestStartEnd

	self.IdToQuest = {}

	self.QIds = {}					-- Our quests by id
	self.QIdsNew = {}				-- Time stamp of getting a new quest. [Id] = time()

	self.Tracking = {}
	self.Sorted = {}

	self.CurQ = {}					-- Current quests (including gotos)
	self.RealQ = {}				-- Real Blizzard quests
	self.RealQEntries = 0
	self.PartyQ = {}				-- Party quests

	self.IdToCurQ = {}

	self.HeaderExpanded = {}	-- Blizzard quest headers we expanded
	self.HeaderHide = {}			-- Names of quest headers to hide

	self.RcvPlyrLast = L["None"]
	self.RcvCnt = 0
	self.RcvTotal = 0
	self.FriendQuests = {}

	self.IconTracking = {}

	self:CalcWatchColors()

	self.TagNames = {
		["Group"] = "+",
		["Gruppe"] = "+",			-- German
		["Dungeon"] = "D",
		["Heroic"] = "H",
		["Heroisch"] = "H",		-- German
		["Raid"] = "R",
	}

	self.PerColors = {
		"|cffc00000", "|cffc03000", "|cffc06000", "|cffc09000", "|cffc0c000", "|cff90c000", "|cff60c000", "|cff30c000", "|cff00c000",
	}

	local qopts = Nx:GetQuestOpts()
	if qopts.NXBroadcastQChanges ~= nil then

		opts["QBroadcastQChanges"] = qopts.NXBroadcastQChanges	-- Convert

		qopts.NXBroadcastQChanges = nil
	end

	-- Capture

	self.CapturePlyrData = {}

	self.CapFactionAbr = {
		["Argent Crusade"] = 1,
		["Argent Dawn"] = 2,
		["Ashtongue Deathsworn"] = 3,
		["Bloodsail Buccaneers"] = 4,
		["Booty Bay"] = 5,
		["Brood of Nozdormu"] = 6,
		["Cenarion Circle"] = 7,
		["Cenarion Expedition"] = 8,
		["Darkmoon Faire"] = 9,
		["Darkspear Trolls"] = 10,
		["Darnassus"] = 11,
		["Everlook"] = 12,
		["Exodar"] = 13,
		["Explorers' League"] = 14,
		["Frenzyheart Tribe"] = 15,
		["Frostwolf Clan"] = 16,
		["Gadgetzan"] = 17,
		["Gelkis Clan Centaur"] = 18,
		["Gnomeregan Exiles"] = 19,
		["Honor Hold"] = 20,
		["Hydraxian Waterlords"] = 21,
		["Ironforge"] = 22,
		["Keepers of Time"] = 23,
		["Kirin Tor"] = 24,
		["Knights of the Ebon Blade"] = 25,
		["Kurenai"] = 26,
		["Lower City"] = 27,
		["Magram Clan Centaur"] = 28,
		["Netherwing"] = 29,
		["Ogri'la"] = 30,
		["Orgrimmar"] = 31,
		["Ratchet"] = 32,
		["Ravenholdt"] = 33,
		["Sha'tari Skyguard"] = 34,
		["Shattered Sun Offensive"] = 35,
		["Shen'dralar"] = 36,
		["Silvermoon City"] = 37,
		["Silverwing Sentinels"] = 38,
		["Sporeggar"] = 39,
		["Stormpike Guard"] = 40,
		["Stormwind"] = 41,
		["Syndicate"] = 42,
		["The Aldor"] = 43,
		["The Consortium"] = 44,
		["The Defilers"] = 45,
		["The Frostborn"] = 46,
		["The Hand of Vengeance"] = 47,
		["The Kalu'ak"] = 48,
		["The League of Arathor"] = 49,
		["The Mag'har"] = 50,
		["The Oracles"] = 51,
		["The Scale of the Sands"] = 52,
		["The Scryers"] = 53,
		["The Sha'tar"] = 54,
		["The Silver Covenant"] = 55,
		["The Sons of Hodir"] = 56,
		["The Taunka"] = 57,
		["The Violet Eye"] = 58,
		["The Wyrmrest Accord"] = 59,
		["Thorium Brotherhood"] = 60,
		["Thrallmar"] = 61,
		["Thunder Bluff"] = 62,
		["Timbermaw Hold"] = 63,
		["Tranquillien"] = 64,
		["Undercity"] = 65,
		["Valiance Expedition"] = 66,
		["Warsong Offensive"] = 67,
		["Warsong Outriders"] = 68,
		["Wildhammer Clan"] = 69,
		["Wintersaber Trainers"] = 70,
		["Zandalar Tribe"] = 71,
	}

	-- Patch quest data
--[[
	local qdata = {
		[3444] = "4^97^626^386",
		[10447] = "5^96^738^357",
--		[11514] = "4^19",
--		[11521] = "4^96",
--		[ 11541] = "2^119^538^341",
--		[111541] = "3",
--		[11546] = "4^119",
--		[11877] = "4^66",
	}

	for id, s in pairs (qdata) do

		id = id <= 100000 and id or id - 100000

		local quest = Nx.Quests[(id + 7) * 2 - 3]

		local objI, zone, x, y = strsplit ("^", s)
		objI = tonumber (objI)

		if not zone then
			quest[objI] = nil

		else
--			Nx.prt ("%s z%s", id, objI)

			local obj = quest[objI]
			if obj then

				zone = tonumber (zone)

				if x then
--					Nx.prt ("%s %s %s", id, x, y)
					x = tonumber (x) * 10
					y = tonumber (y) * 10
					local oDesc = self:UnpackObjective (obj)
					quest[objI] = format ("%c%s%c %c%c%c%c", #oDesc + 35, oDesc, zone + 35,
							floor (x / 221) + 35, x % 221 + 35, floor (y / 221) + 35, y % 221 + 35)
				else
					local oDesc, oZone, oLoc = self:UnpackObjective (obj)
					quest[objI] = format ("%c%s%c%s", #oDesc + 35, oDesc, zone + 35, strsub (obj, oLoc))
				end
			end
		end
	end
--]]

	-- Patch Molten Front
--[[
	for mungeId, q in pairs (Nx.Quests) do

		local id = (mungeId + 3) / 2 - 7		-- Decode

		if q[2] then
			local sName, zone = self:UnpackSE (q[2])
			if zone == 199 then
				Nx.prt ("qpatch %s", sName)

				local i = 1
				while q[3 + i] do
				end
			end
		end
	end
--]]

	self.DailyTypes = {
		["1"] = _TRANS("Daily"),
		["2"] = _TRANS("Daily Dungeon"),
		["3"] = _TRANS("Daily Heroic"),
	}
	self.Reputations = {
		["A"] = L["Aldor"],
		["S"] = L["Scryer"],
		["c"] = L["Consortium"],
		["e"] = L["Cenarion Expedition"],
		["g"] = L["Sha'tari Skyguard"],
		["k"] = L["Keepers of Time"],
		["l"] = L["Lower City"],
		["n"] = L["Netherwing"],
		["o"] = L["Ogri'la"],
		["s"] = L["Shattered Sun Offensive"],
		["t"] = L["Sha'tar"],
		["z"] = L["Honor Hold/Thrallmar"],
		-- WotLK
		["C"] = L["Argent Crusade"],
		["E"] = L["Explorers' League"],
		["F"] = L["Frenzyheart Tribe"],
		["f"] = L["The Frostborn"],
		["H"] = L["Horde Expedition"],
		["K"] = L["The Kalu'ak"],
		["i"] = L["Kirin Tor"],
		["N"] = L["Knights of the Ebon Blade"],
		["O"] = L["The Oracles"],
		["h"] = L["The Sons of Hodir"],
		["a"] = L["Alliance Vanguard"],
		["V"] = L["Valiance Expedition"],
		["W"] = L["Warsong Offensive"],
		["w"] = L["The Wyrmrest Accord"],
		["I"] = L["The Silver Covenant"],		-- Patch 3.1
		["R"] = L["The Sunreavers"],				-- Patch 3.1
	}
	self.Requirements = {
--		["1"] = "Alliance",		-- Already stripped out by quest side removal code
--		["2"] = "Horde",
		["oH"] = L["Ogri'la Honored"],
		["H350"] = L["Herbalism 350"],
		["M350"] = L["Mining 350"],
		["S350"] = L["Skining 350"],
		["G"] = L["Gathering Skill"],
		["nF"] = L["Netherwing Friendly"],
		["nH"] = L["Netherwing Honored"],
		["nRA"] = L["Netherwing Revered (Aldor)"],
		["nRS"] = L["Netherwing Revered (Scryer)"],
		-- WotLK
		["hH"] = L["The Sons of Hodir Honored"],
		["hR"] = L["The Sons of Hodir Revered"],
		["J375"] = L["Jewelcrafting 375"],
		["C"] = L["Cooking"],
		["F"] = L["Fishing"],
	}

	self.DailyIds = {
		-- Type ^ Reward (Gold*100+Silver) ^ Rep letter/Rep amount (000) ^ Requirement
		-- Req - H herb, M mine, S skin, G any gather, F friendly, H honored, R revered

		-- Honor Hold/Thrallmar
		[10106] = "1^70^z150",			-- Hellfire Fortifications
		[10110] = "1^70^z150",			-- Hellfire Fortifications
		-- Ogri'la
		[11023] = "1^1199^o500g500",	-- Bomb Them Again!
		[11066] = "1^1199^o350g350",	-- Wrangle More Aether Rays!
		[11080] = "1^910^o350",			-- The Relic's Emanation
		[11051] = "1^1199^o350^oH",	-- Banish More Demons
		-- Netherwing
		[11020] = "1^1199^n250",		-- A Slow Death
		[11035] = "1^1199^n250",		-- The Not-So-Friendly Skies...
		[11049] = "1^1828^n350",		-- The Great Netherwing Egg Hunt
		[11015] = "1^1199^n250",		-- Netherwing Crystals
		[11017] = "1^1199^n250^H350",	-- Netherdust Pollen (Herbalist)
		[11018] = "1^1199^n250^M350",	-- Nethercite Ore (Miner)
		[11016] = "1^1199^n250^S350",	-- Nethermine Flayer Hide (Skinner)
		[11055] = "1^1199^n350^nF",	-- The Booterang: A Cure For The Common Worthless Peon
		[11076] = "1^1828^n350^nF",	-- Picking Up The Pieces...
		[11086] = "1^1199^n500^nH",	-- Disrupting the Twilight Portal
		[11101] = "1^1828^n500^nRA",	-- The Deadliest Trap Ever Laid (Aldor)
		[11097] = "1^1828^n500^nRS",	-- The Deadliest Trap Ever Laid (Scryer)
		-- Shattered Sun
		[11514] = "1^1010^s250",		-- Maintaining the Sunwell Portal
		[11515] = "1^1199^s250",		-- Blood for Blood
		[11516] = "1^1010^s250",		-- Blast the Gateway
		[11521] = "1^1388^s350",		-- Rediscovering Your Roots
		[11523] = "1^910^s150",			-- Arm the Wards!
		[11525] = "1^910^s150",			-- Further Conversions
		[11533] = "1^910^s150",			-- The Air Strikes Must Continue
		[11536] = "1^1199^s250",		-- Don't Stop Now....
		[11537] = "1^1010^s250",		-- The Battle Must Go On
		[11540] = "1^1199^s250",		-- Crush the Dawnblade
		[11541] = "1^1199^s250",		-- Disrupt the Greengill Coast
		[11543] = "1^759^s250",			-- Keeping the Enemy at Bay
		[11544] = "1^1828^s350",		-- Ata'mal Armaments
		[11546] = "1^1199^s250",		-- Open for Business
		[11547] = "1^1199^s250",		-- Know Your Ley Lines
		[11548] = "1^-1000^s150",		-- Your Continued Support
		[11877] = "1^1010^s250",		-- Sunfury Attack Plans
		[11880] = "1^910^s250",			-- The Multiphase Survey
		[11875] = "1^1639^s250^G",		-- Gaining the Advantage
		-- Skettis
		[11008] = "1^1199^g350",		-- Fires Over Skettis
		[11085] = "1^910^g150",			-- Escape from Skettis

		-- WotLK Borean Tundra
		[11940] = "1^470^w250",			-- Drake Hunt
		[11945] = "1^500^K500",			-- Preparing for the Worst
		[13414] = "1^740^w250",			-- Aces High!
		-- WotLK Howling Fjord
		[11153] = "1^470^a 38V250^1",	-- Break the Blockade
		[11391] = "1^470^E250^1",		-- Steel Gate Patrol
		[11472] = "1^470^K500",			-- The Way to His Heart...
		-- WotLK Dragonblight
		[11960] = "1^500^K500",			-- Planning for the Future
		[12372] = "1^560^w250",			-- Defending Wyrmrest Temple
		-- WotLK Grizzly Hills
		[12437] = "1^560^^1",			-- Riding the Red Rocket
		[12444] = "1^560^a 38V250^1",	-- Blackriver Skirmish
		[12316] = "1^560^^1",			-- Keep Them at Bay!
		[12289] = "1^560^a 38V250^1",	-- Kick 'Em While They're Down
		[12296] = "1^560^a 38V250^1",	-- Life or Death
		[12268] = "1^560^^1",			-- Pieces Parts
		[12244] = "1^560^^1",			-- Shredder Repair
		[12323] = "1^560^^1",			-- Smoke 'Em Out
		[12314] = "1^560^^1",			-- Down With Captain Zorna!
		[12038] = "1^986",				-- Seared Scourge
		[12433] = "1^560",				-- Seeking Solvent
		[12170] = "1^560^H250^2",		-- Blackriver Brawl
		[12284] = "1^560^W250^2",		-- Keep 'Em on Their Heels
		[12280] = "1^560^W250^2",		-- Making Repairs
		[12288] = "1^560^W250^2",		-- Overwhelmed!
		[12270] = "1^560^W250^2",		-- Shred the Alliance
		[12315] = "1^560^^2",			-- Crush Captain Brightwater!
		[12324] = "1^560^^2",			-- Smoke 'Em Out
		[12317] = "1^560^^2",			-- Keep Them at Bay
		[12432] = "1^560^^2",			-- Riding the Red Rocket
		-- WotLK Zul'Drak
		[12501] = "1^620^C250",			-- Troll Patrol
		[12541] = "1^158^C 75",			-- Troll Patrol: The Alchemist's Apprentice
		[12502] = "1^158^C 75",			-- Troll Patrol: High Standards
		[12564] = "1^158^C 75",			-- Troll Patrol: Something for the Pain
		[12588] = "1^158^C 75",			-- Troll Patrol: Can You Dig It?
		[12568] = "1^158^C 75",			-- Troll Patrol: Done to Death
		[12509] = "1^158^C250",			-- Troll Patrol: Intestinal Fortitude
		[12591] = "1^158^C 75",			-- Troll Patrol: Throwing Down
		[12585] = "1^158^C 75",			-- Troll Patrol: Creature Comforts
		[12519] = "1^158^C 25",			-- Troll Patrol: Whatdya Want, a Medal?
		[12594] = "1^158^C 75",			-- Troll Patrol: Couldn't Care Less
		[12604] = "1^1860^C350",		-- Congratulations!
		-- WotLK Sholazar Basin
		[12704] = "1^650^O250",			-- Appeasing the Great Rain Stone
		[12761] = "1^1360^O350",		-- Mastery of the Crystals
		[12762] = "1^1360^O350",		-- Power of the Great Ones
		[12705] = "1^1360^O350",		-- Will of the Titans
		[12735] = "1^740^O500",			-- A Cleansing Song
		[12737] = "1^740^O250",			-- Song of Fecundity
		[12736] = "1^740^O250",			-- Song of Reflection
		[12726] = "1^740^O500",			-- Song of Wind and Water
		[12689] = "1^330^O***",			-- Hand of the Oracles (one time rep bonus)
		[12582] = "1^330^F***",			-- Frenzyheart Champion (one time rep bonus)
		[12702] = "1^650^F500",			-- Chicken Party!
		[12703] = "1^1360^F350",		-- Kartak's Rampage
		[12760] = "1^1360^F350",		-- Secret Strength of the Frenzyheart
		[12759] = "1^1360^F350",		-- Tools of War
		[12734] = "1^740^F500",			-- Rejek: First Blood
		[12758] = "1^740^F500",			-- A Hero's Headgear
		[12741] = "1^740^F500",			-- Strength of the Tempest (check rep??)
		[12732] = "1^740^F500",			-- The Heartblood's Strength
		-- WotLK Icecrown
		[13309] = "1^740^V250^1",		-- Assault by Air
		[13284] = "1^740^V250^1",		-- Assault by Ground
		[13336] = "1^740^V250^1",		-- Blood of the Chosen
		[13323] = "1^740^^1",			-- Drag and Drop
		[13344] = "1^740^^1",			-- Not a Bug
		[13322] = "1^740^^1",			-- Retest Now
		[13404] = "1^740^^1",			-- Static Shock Troops: the Bombardment
		[13300] = "1^740^C250^1",		-- Slaves to Saronite
		[13289] = "1^740^^1",			-- That's Abominable!
		[13292] = "1^740^^1",			-- The Solution Solution
		[13333] = "1^740^^1",			-- Capture More Dispatches
		[13297] = "1^2220^^1",			-- Neutralizing the Plague
		[13350] = "1^2220^^1",			-- No Rest For The Wicked
		[13280] = "1^740^V250^1",		-- King of the Mountain
		[13233] = "1^740^^1",			-- No Mercy!
		[13310] = "1^740^W250^2",		-- Assault by Air
		[13301] = "1^740^W250^2",		-- Assault by Ground
		[13330] = "1^740^W250^2",		-- Blood of the Chosen
		[13353] = "1^740^^2",			-- Drag and Drop
		[13365] = "1^740^^2",			-- Not a Bug
		[13357] = "1^740^^2",			-- Retest Now
		[13406] = "1^740^^2",			-- Riding the Wavelength: The Bombardment
		[13302] = "1^740^C250^2",		-- Slaves to Saronite
		[13376] = "1^740^^2",			-- Total Ohmage: The Valley of Lost Hope!
		[13276] = "1^740^^2",			-- That's Abominable!
		[13331] = "1^740^W250^2",		-- Keeping the Alliance Blind
		[13261] = "1^740^^2",			-- Volatility
		[13281] = "1^2220^^2",			-- Neutralizing the Plague
		[13368] = "1^2220^^2",			-- No Rest For The Wicked
		[13283] = "1^740^W250^2",		-- King of the Mountain
		[13234] = "1^740^^2",			-- Make Them Pay!
		[12813] = "1^740^N250",			-- From Their Corpses, Rise!
		[12838] = "1^740^N250",			-- Intelligence Gathering
		[12995] = "1^740^N250",			-- Leave Our Mark
		[12815] = "1^740^N250",			-- No Fly Zone
		[13069] = "1^740^N250",			-- Shoot 'Em Up
		[13071] = "1^370^N250",			-- Vile Like Fire!
		-- WotLK Icecrown Argent Tournament
--		[13681] = "1^740",				-- A Chip Off the Ulduar Block (OLD)
--		[13627] = "1^740",				-- Jack Me Some Lumber (OLD)
		[13625] = "1^580^I250",			-- Learning The Reins (A)
		[13677] = "1^580^R250",			-- Learning The Reins (H)
		[13671] = "1^580^I250",			-- Training In The Field (A)
		[13676] = "1^580^R250",			-- Training In The Field (H)
		[13666] = "1^580^I250",			-- A Blade Fit For A Champion (A)
		[13603] = "1^740^I250",			-- A Blade Fit For A Champion
		[13741] = "1^740^I250",			-- A Blade Fit For A Champion
		[13746] = "1^740^I250",			-- A Blade Fit For A Champion
		[13752] = "1^740^I250",			-- A Blade Fit For A Champion
		[13757] = "1^740^I250",			-- A Blade Fit For A Champion
		[13673] = "1^580^R250",			-- A Blade Fit For A Champion (H)
		[13762] = "1^740^R250",			-- A Blade Fit For A Champion
		[13768] = "1^740^R250",			-- A Blade Fit For A Champion
		[13783] = "1^740^R250",			-- A Blade Fit For A Champion
		[13773] = "1^740^R250",			-- A Blade Fit For A Champion
		[13778] = "1^740^R250",			-- A Blade Fit For A Champion
		-- WotLK The Storm Peaks
		[12994] = "1^740^h350^hH",		-- Spy Hunter
		[12833] = "1^680",				-- Overstock
		[13424] = "1^740",				-- Back to the Pit (Hyldnir Spoils)
		[12977] = "1^740^h250",			-- Blowing Hodir's Horn
		[13423] = "1^740",				-- Defending Your Title (Hyldnir Spoils)
		[13046] = "1^740^h250^hR",		-- Feeding Arngrim
		[12981] = "1^740^h250",			-- Hot and Cold
		[13422] = "1^550",				-- Maintaining Discipline (Hyldnir Spoils)
		[13006] = "1^740^h250",			-- Polishing the Helm
		[12869] = "1^680^f250",			-- Pushed Too Far
		[13425] = "1^740",				-- The Aberrations Must Die (Hyldnir Spoils)
		[13003] = "1^1480^h500^hH",	-- Thrusting Hodir's Spear
		-- WotLK Wintergrasp
		[13156] = "1^740",				-- A Rare Herb
		[13195] = "1^740",				-- A Rare Herb
		[13154] = "1^740",				-- Bones and Arrows
		[13193] = "1^740",				-- Bones and Arrows
		[13196] = "1^740",				-- Bones and Arrows
		[13199] = "1^740",				-- Bones and Arrows
		[13222] = "1^740",				-- Defend the Siege
		[13223] = "1^740",				-- Defend the Siege
		[13191] = "1^740",				-- Fueling the Demolishers
		[13197] = "1^740",				-- Fueling the Demolishers
		[13200] = "1^740",				-- Fueling the Demolishers
		[13194] = "1^740",				-- Healing with Roses
		[13201] = "1^740",				-- Healing with Roses
		[13202] = "1^740",				-- Jinxing the Walls
		[13177] = "1^740",				-- No Mercy for the Merciless
		[13179] = "1^740",				-- No Mercy for the Merciless
		[13178] = "1^740",				-- Slay them all!
		[13180] = "1^740",				-- Slay them all!
		[13538] = "1^740",				-- Southern Sabotage
		[13185] = "1^740",				-- Stop the Siege
		[13186] = "1^740",				-- Stop the Siege
		[13539] = "1^740",				-- Toppling the Towers
		[13181] = "1^740",				-- Victory in Wintergrasp
		[13183] = "1^740",				-- Victory in Wintergrasp
		[13192] = "1^740",				-- Warding the Walls
		[13153] = "1^740",				-- Warding the Warriors
		[13198] = "1^740",				-- Warding the Warriors
		-- WotLK Cooking
		[13101] = "1^580^i150^C",		-- Convention at the Legerdemain
		[13113] = "1^580^i150^C",		-- Convention at the Legerdemain
		[13100] = "1^580^i150^C",		-- Infused Mushroom Meatloaf
		[13112] = "1^580^i150^C",		-- Infused Mushroom Meatloaf
		[13107] = "1^580^i150^C",		-- Mustard Dogs!
		[13116] = "1^580^i150^C",		-- Mustard Dogs!
		[13102] = "1^580^i150^C",		-- Sewer Stew
		[13114] = "1^580^i150^C",		-- Sewer Stew
		-- WotLK Jewelcrafting
		[12958] = "1^740^i 25^J375",	-- Shipment: Blood Jade Amulet
		[12962] = "1^740^i 25^J375",	-- Shipment: Bright Armor Relic
		[12959] = "1^740^i 25^J375",	-- Shipment: Glowing Ivory Figurine
		[12961] = "1^740^i 25^J375",	-- Shipment: Intricate Bone Figurine
		[12963] = "1^740^i 25^J375",	-- Shipment: Shifting Sun Curio
		[12960] = "1^740^i 25^J375",	-- Shipment: Wicked Sun Brooch
		-- WotLK Fishing
		[13833] = "1^0^i250^F",			-- Blood Is Thicker
		[13834] = "1^0^i250^F",			-- Dangerously Delicious
		[13832] = "1^0^i250^F",			-- Jewel Of The Sewers
		[13836] = "1^0^i250^F",			-- Monsterbelly Appetite
		[13830] = "1^0^i250^F",			-- The Ghostfish
	}
	self.DailyDungeonIds = {
		-- Dungeon
		[11389] = "2^1639^c250t250",	-- Wanted: Arcatraz Sentinels
		[11371] = "2^1639^c250e250",	-- Wanted: Coilfang Myrmidons
		[11376] = "2^1639^c250l250",	-- Wanted: Malicious Instructors
		[11383] = "2^1639^c250k250",	-- Wanted: Rift Lords
		[11364] = "2^1639^c250z250",	-- Wanted: Shattered Hand Centurions
		[11500] = "2^1639^c250s250",	-- Wanted: Sisters of Torment
		[11385] = "2^1639^c250t250",	-- Wanted: Sunseeker Channelers
		[11387] = "2^1639^c250t250",	-- Wanted: Tempest-Forge Destroyers
		-- Dungeon Heroic
		[11369] = "3^2460^c250e250",	-- Wanted: A Black Stalker Egg
		[11384] = "3^2460^c350t350",	-- Wanted: A Warp Splinter Clipping
		[11382] = "3^2460^c350k350",	-- Wanted: Aeonus's Hourglass
		[11363] = "3^2460^c350z350",	-- Wanted: Bladefist's Seal
		[11362] = "3^2460^c350z350",	-- Wanted: Keli'dan's Feathered Stave
		[11375] = "3^2460^c350l350",	-- Wanted: Murmur's Whisper
		[11354] = "3^2460^c350z350",	-- Wanted: Nazan's Riding Crop
		[11386] = "3^2460^c350t350",	-- Wanted: Pathaleon's Projector
		[11373] = "3^2460^c500",		-- Wanted: Shaffar's Wondrous Pendant
		[11378] = "3^2460^c350k350",	-- Wanted: The Epoch Hunter's Head
		[11374] = "3^2460^c350l350",	-- Wanted: The Exarch's Soul Gem
		[11372] = "3^2460^c350l350",	-- Wanted: The Headfeathers of Ikiss
		[11368] = "3^2460^c350e350",	-- Wanted: The Heart of Quagmirran
		[11388] = "3^2460^c350t350",	-- Wanted: The Scroll of Skyriss
		[11499] = "3^2460^c350s350",	-- Wanted: The Signet Ring of Prince Kael'thas
		[11370] = "3^2460^c350e350",	-- Wanted: The Warlord's Treatise
		-- WotLK Dungeon
		[13240] = "2^3466^i 75",		-- Timear Foresees Centrifuge Constructs in your Future!
		[13243] = "2^3466^i 75",		-- Timear Foresees Infinite Agents in your Future!
		[13244] = "2^3466^i 75",		-- Timear Foresees Titanium Vanguards in your Future!
		[13241] = "2^3466^i 75",		-- Timear Foresees Ymirjar Berserkers in your Future!
		-- WotLK Dungeon Heroic
		[13190] = "2^4200",				-- All Things in Good Time
		[13254] = "2^4866^i 75",		-- Proof of Demise: Anub'arak
		[13256] = "2^4866^i 75",		-- Proof of Demise: Cyanigosa
		[13250] = "2^4866^i 75",		-- Proof of Demise: Gal'darah
		[13255] = "2^4866^i 75",		-- Proof of Demise: Herald Volazj
		[13245] = "2^4866^i 75",		-- Proof of Demise: Ingvar the Plunderer
		[13246] = "2^4866^i 75",		-- Proof of Demise: Keristrasza
		[13248] = "2^4866^i 75",		-- Proof of Demise: King Ymiron
		[13247] = "2^4866^i 75",		-- Proof of Demise: Ley-Guardian Eregos
		[13253] = "2^4866^i 75",		-- Proof of Demise: Loken
		[13251] = "2^4866^i 75",		-- Proof of Demise: Mal'Ganis
		[13252] = "2^4866^i 75",		-- Proof of Demise: Sjonnir The Ironshaper
		[14199] = "2^4866^i 75",		-- Proof of Demise: The Black Knight
		[13249] = "2^4866^i 75",		-- Proof of Demise: The Prophet Tharon'ja
	}
	self.DailyPVPIds = {	-- For not auto watching
		[11335] = "1",	-- AV, AB, EOS, WG both sides
		[11336] = "1",
		[11337] = "1",
		[11338] = "1",
		[11339] = "1",
		[11340] = "1",
		[11341] = "1",
		[11342] = "1",
		[13405] = "1",	-- SoA
		[13407] = "1",
		[14163] = "1",	-- IoC
		[14164] = "1",
	}

	--	DEBUG for Jamie

	Nx.Quests = Nx["Quests"] or Nx.Quests								-- Copy unmunged data to munged data
	Nx.QuestStartEnd = Nx["QuestStartEnd"] or Nx.QuestStartEnd	-- Copy unmunged data to munged data

	--	DEBUG kill all quests

--	Nx.Quests = {}

	--

	self.Map = Map:GetMap (1)

	local enFact = Nx.PlFactionNum == 1 and 1 or 2		-- Remap 0 to 2, 1 to 1
--	enFact = 2
	local qLoadLevel = UnitLevel ("player") - opts["QLevelsToLoad3"]
	local qMaxLevel = 999

	local qCnt = 0
	local maxid = 0
	local sameCnt = 0
--[[
	--DB
	local startMissingCnt = 0
	local start0Cnt = 0
	local startNoZoneCnt = 0
	local end0Cnt = 0
	local endNoZoneCnt = 0
	local obj0Cnt = 0
	local objNoZoneCnt = 0
--]]

	for mungeId, q in pairs (Nx.Quests) do

		local id = (mungeId + 3) / 2 - 7		-- Decode

--		Nx.Quests[mungeId][2] = nil
--		Nx.Quests[mungeId][3] = nil
--		Nx.Quests[mungeId][4] = nil

		qCnt = qCnt + 1
		maxid = max (id, maxid)

		local name, side, level = self:Unpack (q[1])
		if side == enFact or level > 0 and level < qLoadLevel or level > qMaxLevel then
--[[
			if side == enFact then
--				Nx.prt ("Del q %s side", id)
			else
				Nx.prt ("Del q %s level", id)
			end
--]]
			Nx.Quests[mungeId] = nil

		else

			self.IdToQuest[id] = q

			if q[3] and q[3] == q[2] then
--				q[3] = nil							-- Release mem !!!!! FIX for non enders !!!!!
				sameCnt = sameCnt + 1
			end

--			if not q[4] and q[5] then
--				Nx.prt ("q %s obj hole", id)
--			end
--[[
			--DB

			if q[2] then

				local sName = self:UnpackSE (q[2])
				local _, zone, x, y = self:GetSEPos (q[2])
				local mapId = Map.NxzoneToMapId[zone]

				if not zone then
					startNoZoneCnt = startNoZoneCnt + 1
				end

				if (x == 0 or y == 0) and mapId and not Map:IsInstanceMap (mapId) then
--					Nx.prt ("%s (%s) %s 0 start", name, id, sName)
					start0Cnt = start0Cnt + 1
				end
			else
				startMissingCnt = startMissingCnt + 1
			end
			if q[3] then

				local eName = self:UnpackSE (q[3])
				local _, zone, x, y = self:GetSEPos (q[3])
				local mapId = Map.NxzoneToMapId[zone]

				if not zone then
					endNoZoneCnt = endNoZoneCnt + 1
				end

				if (x == 0 or y == 0) and mapId and not Map:IsInstanceMap (mapId) then
--					Nx.prt ("%s (%s) %s 0 end", name, id, eName)
					end0Cnt = end0Cnt + 1
				end
			end
			for n = 4, 99 do
				if not q[n] then
					break
				end

				local oName = self:UnpackObjective (q[n])
				local _, zone, x, y = self:GetObjectivePos (q[n])
				local mapId = Map.NxzoneToMapId[zone]

				if not zone or zone == 0 then
--					Nx.prt ("%s (%s) #%s %s: no zone", name, id, n - 3, oName or "nil")
					objNoZoneCnt = objNoZoneCnt + 1
				elseif zone > 0 and zone < 220 and not mapId then
--					Nx.prt ("%s (%s) #%s %s z%s: no mapId", name, id, n - 3, oName, zone)
				end

				if (x == 0 and y ~= 0) or (x ~= 0 and y == 0) then
					Nx.prt ("? %s %s", name, id)
				end

				if (x == 0 or y == 0) and mapId and not Map:IsInstanceMap (mapId) then
--					Nx.prt ("%s (%s) #%s %s z%s: no xy", name, id, n - 3, oName, zone)
					obj0Cnt = obj0Cnt + 1
				end
			end
--]]

			self:CheckQuestSE (q, 3)

			for n = 4, 99 do
				if not q[n] then
					break
				end

				self:CheckQuestObj (q, n)
			end

		end
	end
	
	for k, v in pairs(Nx.Quests) do
		--Nx.Quest.IdToQuest[k] = nil
		local qid = (k+3)/2-7
		local qname = Locale_NxQuestName and Locale_NxQuestName[qid]
		if qname then
			local i=string.byte(v[1],1)-35+1
			Nx.Quests[k][1] = string.char(qname:len()+35)..qname..v[1]:sub(i+1)
		end    
	end
	if Locale_NxQuestCategory then
		for k,v in next,Nx.QuestCategory do
			Nx.QuestCategory[k]=Locale_NxQuestCategory[v]
			assert(Nx.QuestCategory[k], "No Quest Category Locale "..v)
		end
		Locale_NxQuestCategory = nil
	end
	if Locale_NxQuestStartEnd then
		for k,v in next,Nx.QuestStartEnd do
			Nx.QuestStartEnd[k]=Locale_NxQuestStartEnd[v]
			assert(Nx.QuestStartEnd[k], "No Quest NPC Locale "..v)
		end
		Locale_NxQuestStartEnd = nil
	end
--[[
	--DB
	Nx.prt ("------- %s quests", qCnt)
	Nx.prt ("maxid %s", maxid)
	Nx.prt ("end==start %s, no start %s", sameCnt, startMissingCnt)
	Nx.prt ("0 xy, start %s, end %s, obj %s", start0Cnt, end0Cnt, obj0Cnt)
	Nx.prt ("no zone, start %s, end %s, obj %s", startNoZoneCnt, endNoZoneCnt, objNoZoneCnt)
--]]

	--

	for mungeId, q in pairs (Nx.Quests) do

		local name, side, lvl, minlvl, next = self:Unpack (q[1])

--		if next > 0 then
--			Nx.prt ("%s %s %s", name, mungeId, next)
--		end

--		if strfind (name, "Safety First") then
--			Nx.prt ("%s %s %s", name, mungeId, next)
--		end

		if not q.CNum and next > 0 then

			local clvlmax = lvl

			local qc = q
			local cnum = 0
			while qc do
				cnum = cnum + 1
				qc.CNum = cnum

--				if strfind (name, "Vile Famil") then
--					Nx.prt ("%s %d %d %d", name, mungeId, next, cnum)
--				end

				name, side, lvl, minlvl, next = self:Unpack (qc[1])

				clvlmax = max (clvlmax, lvl)

--				next = self:UnpackNext (qc[1])
				if next == 0 then
					break
				end

				qc = self.IdToQuest[next]
			end

			q.CLvlMax = clvlmax		-- Max level in chain
		end
	end


	for lvl = 0, 90 do

		local grp = {}

		for id, q in pairs (Nx.Quests) do

			id = (id + 3) / 2 - 7

			local name, side, level = self:Unpack (q[1])

			if level == lvl then
				if side ~= enFact then

					if not q.CNum then
						tinsert (grp, format ("%s^%d", name, id))

					elseif q.CNum == 1 then

						local qc = q
						while qc do

							local pname, side, _, _, next = self:Unpack (qc[1])

--							if strfind (name, "Load Lightening") then
--								Nx.prt ("%s %d %d (%d %d)", pname, id, side, next, qc.CNum)
--							end

							tinsert (grp, format ("%s%2d^%d", name, qc.CNum, id))
							qc = self.IdToQuest[next]
							id = next
						end
					end

--					Nx.prt ("Quest "..id.." "..level)
				end
			end
		end

--		table.sort (grp)

		for _, v in ipairs (grp) do
			local name, id = strsplit ("^", v)
			tinsert (self.Sorted, tonumber (id))
		end
	end

	-- Create quest givers

	local usedIds = {}

	local starters = {}
	self.QGivers = starters

	for qsIndex, qId in ipairs (self.Sorted) do

		if not usedIds[qId] then

			local quest = self.IdToQuest[qId]
			if quest then
				local sName, zone, x, y = self:GetSEPos (quest[2])

				if zone and x ~= 0 and y ~= 0 then

					usedIds[qId] = true

					sName = format ("%s=%d%d", sName, x, y)

					local stmap = starters[zone] or {}
					starters[zone] = stmap
					local s = stmap[sName] or ""
					stmap[sName] = s .. format ("%4x", qId)
				end
			end
--		else
--			Nx.prt ("skipped %s", qId)
		end
	end

	--

	self.List:Open()
	self.Watch:Open()

	-- Menu

	local menu = Nx.Menu:Create (self.Map.Frm)
	self.IconMenu = menu

	menu:AddItem (0, L["Track"], self.Menu_OnTrack, self)
	menu:AddItem (0, L["Show Quest Log"], self.Menu_OnShowQuest, self)
	menu:AddItem (0, L["Open Quest Map"], self.Menu_OpenQuestMap, self)
	self.IconMenuIWatch = menu:AddItem (0, L["Watch"], self.Menu_OnWatch, self)

	menu:AddItem (0, L["Add Note"], self.Map.Menu_OnAddNote, self.Map)

	-- Quest area blob test
--[[
	local f = CreateFrame ("QuestPOIFrame", "NxQuestBlob", self.Map.Frm)
	self.BlobFrm = f

	f:SetFillTexture ("Interface\\WorldMap\\UI-QuestBlob-Inside")
	f:SetBorderTexture ("Interface\\WorldMap\\UI-QuestBlob-Outside")
	f:SetFillAlpha (128)
	f:SetBorderAlpha (192)
	f:SetBorderScalar (1)
--]]
	-- Hook quests

	self.BlizzAcceptQuest = AcceptQuest
	AcceptQuest = self.AcceptQuest

--	self.BlizzCompleteQuest = CompleteQuest
--	CompleteQuest = self.CompleteQuest

	self.BlizzGetQuestReward = GetQuestReward
	GetQuestReward = self.GetQuestReward

	local function func()
--		Nx.prt ("QAccept")
		if QuestGetAutoAccept() then
--			Nx.prt ("auto")
			Nx.Quest:RecordQuestAcceptOrFinish()
		end

		QuestFrameDetailPanel_OnShow()

		local auto = Nx:GetGlobalOpts()["QAutoAccept"]
		if IsShiftKeyDown() and IsControlKeyDown() then
			auto = not auto
		end
		if auto and not QuestGetAutoAccept() then
			AcceptQuest()
		end
	end

	QuestFrameDetailPanel:SetScript ("OnShow", func);

	-- Hook tooltip

	local ttHooks = {
		"SetAction", "SetAuctionItem", "SetBagItem", "SetCraftItem", "SetCraftSpell",
		"SetGuildBankItem", "SetHyperlink", "SetInboxItem", "SetInventoryItem", "SetLootItem",
		"SetLootRollItem", "SetMerchantItem", "SetQuestItem", "SetQuestLogItem", "SetTradeSkillItem",
		"SetTradeTargetItem",
	}

	for k, name in ipairs (ttHooks) do
		if not Nx.V30 or name ~= "SetCraftItem" and name ~= "SetCraftSpell" then
			hooksecurefunc (GameTooltip, name, Nx.Quest.TooltipHook)
		end
	end

	local unitNames = {	-- 5 letter and shorter words are already blocked
		"Hunter", "Paladin", "Priest",
		"Shaman", "Warlock", "Warrior", "Deathknight"
	}

	self.TTIgnore = {
		["Attack"] = true,
		["Lumber Mill"] = true,
		["Stables"] = true,
		["Blacksmith"] = true,
		["Gold Mine"] = true,
	}

	self.TTIgnore[UnitName ("player")] = true

	for _, v in pairs (unitNames) do
		self.TTIgnore[v] = true
	end

	self.TTChange = {
		["Bloodberry Bush"] = "Bloodberries",
		["Erratic Sentry"] = "Erratic Sentries",
	}

	-- ID test

--[[
	for hash, q in pairs (Nx.Quests) do

		if NxQID2BQID[q.ID] ~= q.BlizID then
			Nx.prt ("Id mismatch %d %d %d", hash, q.ID, q.BlizID)
		end
	end
--]]

	-- Hash test

--[[
	for hash, q in pairs (Nx.Quests) do

		if NxQID2BQID[q.ID] ~= q.BlizID then
			Nx.prt ("Id mismatch %d %d %d", hash, q.ID, q.BlizID)
		end
	end

	local time = GetTime()

	local failcnt = 0
	local xcnt = 0

	local loopCnt = 10

	for n = 1, loopCnt do

		for k, q in pairs (Nx.Quests) do

			if k < 0x1000000 then
				local h = self:Hash (q.title, q.level)
				if k ~= h then
					Nx.prt (format ("Hash '%s %s %s'", q.title, q.level, q.side))
					Nx.prt (format ("Hash %x %x", k, h))
					failcnt = failcnt + 1
				end
			else
				xcnt = xcnt + 1

			end
		end
	end

	time = GetTime() - time

	Nx.prt (format ("Hash %d failed, %d extended. %f secs", failcnt / loopCnt, xcnt / loopCnt, time / loopCnt))
--]]

end

function Nx.Quest:CheckQuestSE (q, n)

	local _, zone, x, y = self:GetSEPos (q[n])
	local mapId = Nx.Map.NxzoneToMapId[zone]

	if (x == 0 or y == 0) and mapId and not Nx.Map:IsInstanceMap (mapId) then
		q[n] = format ("%s# ####", strsub (q[n], 1, 2))	-- Zero it to get a red button
--		local oName = self:UnpackSE (q[n])
--		Nx.prt ("zeroed %s, %s", self:UnpackName (q[1]), oName)
	end
end

function Nx.Quest:CheckQuestObj (q, n)

	local oName, zone, x, y = self:GetObjectivePos (q[n])
	local mapId = Nx.Map.NxzoneToMapId[zone]

	if (x == 0 or y == 0) and mapId and not Nx.Map:IsInstanceMap (mapId) then		
		q[n] = format ("%c%s# ####", #oName + 35, oName)	-- Zero it to get a red button
--		Nx.prt ("zeroed %s, %s", self:UnpackName (q[1]), oName)
	end
end

--------
-- Calculate the watch colors

function Nx.Quest:CalcWatchColors()

--	Nx.QLocColors = { 1,0,0, "QuestWatchR", 0,1,0, "QuestWatchG", .2,.2,1, "QuestWatchB" }

	local opts = self.GOpts

	local colors = {}
	self.QLocColors = colors

	local a = Nx.Util_num2a (opts["QMapWatchAreaAlpha"])

	local colMax = opts["QMapWatchColorCnt"]
	local colI = 1

	for n = 1, 15 do

		local color = {}
		colors[n] = color

		local r, g, b = Nx.Util_num2rgba (opts["QMapWatchC" .. colI])
		color[1] = r
		color[2] = g
		color[3] = b
		color[4] = a
		color[5] = "QuestListWatch"

		colI = colI + 1
		colI = colI > colMax and 1 or colI
	end
end

--------
-- Menu

--warbaby added
function Nx.Quest:Menu_OpenQuestMap()
    Nx_WorldMap_OpenToQuest(self.IconMenuCur.QId)
end

function Nx.Quest:Menu_OnTrack()

	local cur = self.IconMenuCur
	local v = cur.QId * 0x10000 + self.IconMenuObjI * 0x100 + cur.QI

--	Nx.prt ("Track %x (%d)", v, self.IconMenuObjI)

	self.Watch:Set (v, true, true)

--	self.IconMenuCur
--	self.IconMenuObjI
end

function Nx.Quest:Menu_OnShowQuest()

	ShowUIPanel (QuestLogFrame)

	self.List.Bar:Select (1)

	local cur = self.IconMenuCur
	self.List:Select (cur.QId, cur.QI)
end

function Nx.Quest:Menu_OnWatch (item)

	local cur = self.IconMenuCur
	self.List:ToggleWatch (cur.QId, cur.QI, 0)
end

--------
-- Track quest acception

function Nx.Quest.AcceptQuest (...)

	Nx.Quest:RecordQuestAcceptOrFinish()
	Nx.Quest.BlizzAcceptQuest (...)
end

--------
--
--[[
function Nx.Quest.CompleteQuest (...)

--	Nx.prt ("CompleteQuest ")
--	Nx.prt ("Title '%s'", GetTitleText())

	Nx.Quest.BlizzCompleteQuest (...)
end
--]]

function Nx.Quest.GetQuestReward (choice, ...)

--	Nx.prt ("GetQuestReward %s", choice or "nil")

	local q = Nx.Quest
	q:FinishQuest()	
    q.BlizzGetQuestReward (choice, ...)	
end

function Nx.Quest:FinishQuest()

--	Nx.prt ("FinishQuest")

	local finTitle = GetTitleText()
	finTitle = self:ExtractTitle (finTitle)

	local i, cur = self:FindCur (finTitle)

	if not i then

--		Nx:ShowMessage (Nx.TXTBLUE.."Carb:\n|rCan't find quest in list!\nAn addon may have modified the title\n'" .. finTitle .. "'", "Continue")
--		assert (nil)
		return
	end

	cur.QI = 0		-- 0 so we dont get a final party message

	local qId = cur.QId

	assert (type (qId) ~= "string")

	local id = qId > 0 and qId or cur.Title
	Nx:SetQuest (id, "C", time())

	self:RecordQuestAcceptOrFinish()
	self:Capture (i, -1)

--	Nx.prt ("FinishQuest #%s (%s) %s", i, id, cur.Title)

	if cur.Q then

		self.Tracking[qId] = 0
		self:TrackOnMap (qId, 0)
	end

--	self.List:Update()
	self.Watch:Update()
end

--------
-- Do Blizzard select quest

function Nx.Quest:SelectBlizz (qi)

	if qi > 0 then

		SelectQuestLogEntry (qi)

--		QuestLog_SetSelection (qi)
--		QuestLog_Update()

--[[
		local lh = getglobal ("LightHeaded")
		if lh then

			if lh["SelectQuestLogEntry"] then
				lh["SelectQuestLogEntry"](lh)
			elseif lh["QuestLogTitleButton_OnClick"] then
				lh["QuestLogTitleButton_OnClick"](lh)
			end
		end
--]]
	end
end

--------
-- Expand any collapsed quests

function Nx.Quest:ExpandQuests()

--	if next (self.HeaderExpanded) then	-- Currently expanded?
--		Nx.prt ("ExpandQuests skip")
--		return
--	end

--	Nx.prt ("ExpandQuests")

	repeat
		local found = false
		local cnt = GetNumQuestLogEntries()

		for qn = 1, cnt do

			local title, level, tag, groupCnt, isHeader, isCollapsed = GetQuestLogTitle (qn)
			if isHeader and isCollapsed then

				local he = self.HeaderExpanded
				he[title] = true

				ExpandQuestHeader (qn)
--				Nx.prt ("Expand #%s %s %s", qn, title, isCollapsed or "nil")
				found = true
				break
			end
		end
	until not found
end

--------
-- Expand any collapsed quests

function Nx.Quest:RestoreExpandQuests()

--[[

	if self.List.Win:IsShown() then		-- Don't restore if our window is shown
--		Nx.prt ("RestoreExpandQuests skip")
		return
	end

--	Nx.prt ("RestoreExpandQuests")

	for hName in pairs (self.HeaderExpanded) do

--		Nx.prt ("Collapse %s", hName)

		local cnt = GetNumQuestLogEntries()
		for qn = 1, cnt do

			local title, level, tag, groupCnt, isHeader, isCollapsed = GetQuestLogTitle (qn)
			if isHeader and title == hName then
				CollapseQuestHeader (qn)
--				Nx.prt ("Collapse #%s %s %s", qn, title, isCollapsed or "nil")
				break
			end
		end

		self.HeaderExpanded[hName] = nil
	end

--]]

end

--------
-- Access all quests. Forces game to fetch data, so we do not get ": x/x" objectives

function Nx.Quest:AccessAllQuests()

--	Nx.prt ("AccessAllQuests")

	self:ExpandQuests()

	local qcnt = GetNumQuestLogEntries()

	for qi = 1, qcnt do

		local title, level = GetQuestLogTitle (qi)

		local lbCnt = GetNumQuestLeaderBoards (qi)
		for n = 1, lbCnt do
			GetQuestLogLeaderBoard (n, qi)
		end
	end

	self:RestoreExpandQuests()
end

--------
-- Record quests
-- Example:
--  1 Get Attack << Fake quest (no blizz Num)
--  2 Bring
--  3 Capture

function Nx.Quest:RecordQuests()

--	Nx.prt ("Record Quests")

	local qcnt = GetNumQuestLogEntries()

	for qn = 1, qcnt do	-- Test all quests

		local title, level = GetQuestLogTitle (qn)
		if level < 0 then		-- If a -1 then data not updated. QuestGuru causes this to happen when zoning
			return
		end
	end

--	local tm = GetTime()

	self:ScanBlizzQuestDataZone()			-- Capture current zone
	self:ScanBlizzQuestData()				-- Triggers RecordQuestsLog() after done

	self:RecordQuestsLog()

--	Nx.prt ("%f secs", GetTime() - tm)
end

--------

function Nx.Quest:RecordQuestsLog()

	local qcnt = GetNumQuestLogEntries()

	local opts = self.GOpts
	local curq = self.CurQ
	local oldSel = GetQuestLogSelection()

--	Nx.prt ("RecordQuestsLog %s, %s", qcnt, #curq)

	local lastChanged

	local qIds = {}
	self.QIds = qIds

	--

	local partySend

	if self.RealQEntries == qcnt then	-- No quests added or removed?

		for curi, cur in ipairs (curq) do

			local qi = cur.QI
			if qi > 0 then

				local title, level, tag, groupCnt, isHeader, isCollapsed, isComplete = GetQuestLogTitle (qi)
				title = self:ExtractTitle (title)

--				Nx.prt ("QD %s %s %s %s", title, qi, isHeader and "H1" or "H0", isComplete and "C1" or "C0")

				if cur.Title == title or cur.Title == title.."*" then		-- Still matches? --warbaby from blizzard there will be *

					local change

					if isComplete == 1 and not cur.Complete then
						Nx.prt (L["Quest Complete '%s'"], title)

						if opts["QSndPlayCompleted"] then
							self:PlaySound()
						end

						if opts["QAutoTurnInAC"] and cur.IsAutoComplete then
							ShowQuestComplete (qi)
						end

						if opts["QWRemoveComplete"] and not cur.IsAutoComplete then
							self.Watch:RemoveWatch (cur.QId, cur.QI)
							self.Watch:Update()
							change = false
						else
							change = true
						end

					end

					local lbCnt = GetNumQuestLeaderBoards (qi)
					for n = 1, lbCnt do

						local desc, _typ, done = GetQuestLogLeaderBoard (n, qi)

						--V4

						if desc and (desc ~= cur[n] or done ~= cur[n + 100]) then

--							Nx.prt ("Q Change %s->%s", desc, cur[n] or "nil")

							if opts["QWAddChanged"] then
								if change == nil then
									change = true
								end
							end

							local s1, _, oldCnt = strfind (cur[n] or "", ": (%d+)/")
							if s1 then
								oldCnt = tonumber (oldCnt)
							end

							local s1, _, newCnt = strfind (desc, ": (%d+)/")
							if s1 then
--								Nx.prt ("%s %s", i, total)
								newCnt = tonumber (newCnt)
							end

							if done or (oldCnt and newCnt and newCnt > oldCnt) then
								self:Capture (curi, n)
							end

							lastChanged = cur

							partySend = true
						end
					end

					if change and opts["QWAddChanged"] then
						self.Watch:Add (curi)
					end
				end
			end
		end

	else

		partySend = true
	end

	-- Remove real blizz quests

	local fakeq = {}

	local n = 1
	while curq[n] do

		local cur = curq[n]
		if not cur.Goto or cur.Party then
--			Nx.prt ("RecordQuests RemoveQ %s - %s", cur.Title, cur.QI)
			table.remove (curq, n)
		else
			fakeq[cur.Q] = cur
			n = n + 1
		end
	end

	-- Add blizz quests

	self.RealQ = {}

	local header = "?"

	self.RealQEntries = qcnt

	local index = #curq + 1

	for qn = 1, qcnt do

		local title, level, tag, groupCnt, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle (qn)

--		Nx.prt ("Q %d %s %s %d %s %s %s %s", qn, isHeader and "H" or " ", title, level, tag or "nil", groupCnt or "nil", isDaily or "not daily", isComplete and "C1" or "C0")

		if isHeader then
			header = title or "?"
--			if isCollapsed then
--				Nx.prt ("Q %s collapsed!", title)
--			end

		else
			title = self:ExtractTitle (title)

			SelectQuestLogEntry (qn)

			local qDesc, qObj = GetQuestLogQuestText()

			local qId, qLevel = self:GetLogIdLevel (qn)
			assert (qId)
			local quest = self.IdToQuest[qId]

--			local quest = self:Find (title, level, qDesc, qObj)
			local lbCnt = GetNumQuestLeaderBoards (qn)

			local cur = quest and fakeq[quest]
--			local DBqId = quest and self:UnpackId (quest[1])
--			assert (qId == DBqId)

			if not cur then
				cur = {}
				curq[index] = cur
				cur.Index = index
				index = index + 1

			else
				cur.Goto = nil						-- Might have been a goto quest
				cur.Index = index

				if quest then
					self.Tracking[qId] = 0
					self:TrackOnMap (qId, 0, true)
				end
			end

			qIds[qId] = cur

			cur.Q = quest
			cur.QI = qn							-- Blizzard index
			cur.QId = qId
			cur.Header = header
			cur.Title = title
			cur.ObjText = qObj
			cur.DescText = qDesc
			cur.Level = level
			cur.RealLevel = qLevel
			cur.NewTime = self.QIdsNew[qId]	-- Copy new time

			cur.Tag = tag
			cur.GCnt = groupCnt or 0

			cur.PartySize = groupCnt or 1
--			if cur.Tag then Nx.prt ("%s %s", cur.Tag, cur.GCnt) end
			if tag == "Dungeon" or tag == "Heroic" then
				cur.PartySize = 5
			elseif tag == "Raid" then
				cur.PartySize = 10
			end

			cur.TagShort = self.TagNames[tag] or ""

			cur.Daily = isDaily
			if isDaily then
				cur.TagShort = "$" .. cur.TagShort
			end

			cur.CanShare = GetQuestLogPushable()
			cur.Complete = isComplete		-- 1 is Done, nil not. Otherwise failed
			cur.IsAutoComplete = GetQuestLogIsAutoComplete (qn)

			local left = GetQuestLogTimeLeft()
			if left then
				cur.TimeExpire = time() + left
				cur.HighPri = true
			end

			cur.ItemLink, cur.ItemImg, cur.ItemCharges = GetQuestLogSpecialItemInfo (qn)

			cur.Priority = 1
			cur.Distance = 999999999
			cur.LBCnt = lbCnt

			for n = 1, lbCnt do
				local desc, typ, done = GetQuestLogLeaderBoard (n, qn)
				cur[n] = desc or "?"		--V4
				cur[n + 100] = done
			end

			local mask = 0
			local ender = quest and (quest[3] or quest[2])

			if (isComplete and ender) or lbCnt == 0 or (cur.Goto and quest[2]) then
				mask = 1

			else
				for n = 1, 99 do

					local done
					if n <= lbCnt then
						done = cur[n + 100]
					end

					local obj = quest and quest[3 + n]

					if not obj then
						break
					end

					if obj and not done then
						mask = mask + bit.lshift (1, n)
					end
				end
			end

			cur.TrackMask = mask

--			Nx.prt ("%s %x", title, mask)

			self.RealQ[title] = cur			-- For diff

			-- Calc total number in quest chain

			if quest then
				self:CalcCNumMax (cur, quest)
			end
		end
	end

	--

	if self.GOpts["QPartyShare"] and self.Watch.ButShowParty:GetPressed() then

--		Nx.prt ("-PQuest-")

		local pq = self.PartyQ

		for plName, pdata in pairs (pq) do

--			Nx.prt ("PQuest %s", plName)

			for qId, qT in pairs (pdata) do

				local quest = self.IdToQuest[qId]
				local cur = qIds[qId]

				if cur then		-- We have the quest?

					local s = format ("\n|cff8080f0%s|r", plName)

					if not cur.PartyDesc then

						cur.PartyDesc = ""
						cur.PartyNames = L["\n|cfff080f0Me"]
						cur.PartyCnt = 0
						cur.PartyComplete = cur.Complete

						for n, cnt in ipairs (qT) do
							cur[n + 200] = cur[n + 100]
							cur[n + 400] = L["\n|cfff080f0Me"] .. s
						end
					end

					cur.PartyDesc = cur.PartyDesc .. s
					cur.PartyNames = cur.PartyNames .. s
					cur.PartyCnt = cur.PartyCnt + 1
					cur.PartyComplete = cur.PartyComplete and qT.Complete

					local mask = (cur.PartyComplete or #qT == 0) and 1 or 0

					for n, cnt in ipairs (qT) do

						local total = qT[n + 100]

						local desc, done = self:CalcDesc (quest, n, cnt, total)

--						cur[n] = desc

						done = cur[n + 200] and done
						cur[n + 200] = done

						cur.PartyDesc = cur.PartyDesc .. "\n " .. desc
						cur[n + 400] = cur[n + 400] .. " " .. desc

						if not done then
							mask = mask + bit.lshift (1, n)
						end
					end

					cur.TrackMask = mask

				elseif quest then

					local name, side, lvl = self:Unpack (quest[1])

--					Nx.prt ("PartyQ %s", name)

					local cur = {}
					cur.Goto = true
					cur.Party = plName
					cur.PartyDesc = format ("\n|cff8080f0%s|r", plName)
					cur.PartyNames = cur.PartyDesc
					cur.Q = quest
					cur.QI = 0
					cur.QId = qId
					cur.Header = "Party, " .. plName
					cur.Title = name
					cur.ObjText = ""
					cur.Level = lvl
					cur.PartySize = 1
					cur.TagShort = ""
					cur.Complete = qT.Complete
					cur.Priority = 1
					cur.Distance = 999999999

					self:CalcCNumMax (cur, quest)

					tinsert (curq, cur)
					cur.Index = #curq

					cur.LBCnt = #qT

					local mask = (qT.Complete or #qT == 0) and 1 or 0

					for n, cnt in ipairs (qT) do

						local total = qT[n + 100]

						cur[n], cur[n + 100] = self:CalcDesc (quest, n, cnt, total)

						cur[n + 400] = cur.PartyNames

						if not cur[n + 100] then
							mask = mask + bit.lshift (1, n)
						end
					end

					cur.TrackMask = mask
				end
			end
		end
	end

	for curi, cur in ipairs (curq) do
		if cur.PartyCnt then
			cur.CompleteMerge = cur.PartyComplete

			for n, desc in ipairs (cur) do
				cur[n + 300] = cur[n + 200]
			end

		else
			cur.CompleteMerge = cur.Complete

			for n, desc in ipairs (cur) do
				cur[n + 300] = cur[n + 100]
			end
		end
	end

	--

	if lastChanged then
		self.QLastChanged = self:FindCurFromOld (lastChanged)
	end

	SelectQuestLogEntry (oldSel)

--	Nx.prt ("CurQ %d", #curq)

	self:SortQuests()

	if partySend then
		self:PartyStartSend()
	end

--	local map = Nx.Map:GetMap (1)
	self.Map.Guide:UpdateMapIcons()
end

--------
-- Scan
-- <QuestPOIFrame name="WorldMapBlobFrame">
--  DrawQuestBlob (id, bool)
--  UpdateMouseOverTooltip
--  GetNumTooltips()
--  GetTooltipIndex (i)

--scan blizzard quest data. If all quest are in db, this can be removed.
function Nx.Quest:ScanBlizzQuestData()

--	if Nx.Timer:IsActive ("QScanBlizz") then
--		Nx.prt ("ScanQ skip")
--		return
--	end

--	Nx.prt ("ScanQ")

	SetCVar ("questPOI", 1)		-- Enable or no POI data returned

--	self.ScanBlizzChanged = false

	self.ScanBlizzMapId = {} --1001 --warbaby changed mechanism

	-- Use delay or some quests won't be ready
	Nx.Timer:Start ("QScanBlizz", 1.0, self, self.ScanBlizzQuestDataTimer)
end

function Nx.Quest:ScanBlizzQuestDataTimer()
	if select(2, IsInInstance())=="pvp" then return end --warbaby fix battleground bug
	WatchFrame:UnregisterEvent ("WORLD_MAP_UPDATE")		-- Map::ScanContinents can enable this again

--	local tm = GetTime()

	local Map = Nx.Map
	local curMapId = Map:GetCurrentMapId()

	WorldMapFrame.blockWorldMapUpdate = true;
	self.CurQIds = self.CurQIds or {} --SeMapByID之后会导致CurQ的顺序改变, 所以必须事先记录
	table.wipe(self.CurQIds)

	for _, v in pairs(self.CurQ) do
		table.insert(self.CurQIds, v.QId)
	end

	for _, QId in next, self.CurQIds do
		local mapID, floorNumber = GetQuestWorldMapAreaID(QId);
		if ( mapID ~= 0 and not self.ScanBlizzMapId[mapID*100+floorNumber] ) then
			self.ScanBlizzMapId[mapID*100+floorNumber] = 1
			SetMapByID(mapID);
			if ( floorNumber ~= 0 ) then
				SetDungeonMapLevel(floorNumber);
			end
		end
	end

	WorldMapFrame.blockWorldMapUpdate = nil;

	WatchFrame:RegisterEvent("WORLD_MAP_UPDATE")
	self:RecordQuestsLog()

--[=[ --warbaby changed mechanism
	local mapId = self.ScanBlizzMapId
	local scanCnt = 0

	while scanCnt < 10 do
		if InCombatLockdown() then			
			return
		end

		if mapId ~= curMapId then

			Map:SetCurrentMap (mapId)		-- Triggers WORLD_MAP_UPDATE, which calls MapChanged

			scanCnt = scanCnt + 1
		end

		local cont = floor (mapId / 1000)
--		local cont = Map:IdToContZone (mapId)
		local info = Map.MapInfo[cont]

--		Nx.prt ("ScanQ %s %s", cont, mapId)

		mapId = mapId + 1
--[[
		if not info.Max then
			Nx.prtVar ("err", info)
			return
		end
--]]
		if mapId > info.Max then

--			Nx.prt ("ScanQ next %s %s", cont, mapId)

			if cont == 6 then			-- Done?

				WatchFrame:RegisterEvent ("WORLD_MAP_UPDATE")	-- Back on when done

				Map:SetCurrentMap (curMapId)

--				Nx.prt ("ScanQ changed")

				self:RecordQuestsLog()

				return
			end

			mapId = (cont + 1) * 1000 + 1
		end

		self.ScanBlizzMapId = mapId
	end
--]=]

	Map:SetCurrentMap (curMapId)

--	Nx.prt ("%f secs", GetTime() - tm)

	--return 0 --warbaby xxx only run once
end

--------
-- Called by map WORLD_MAP_UPDATE

function Nx.Quest:MapChanged()

--	Nx.prt ("MapChanged %s", Nx.Map:GetCurrentMapId())

	if self.IdToQuest then	-- Quests inited?

		self:ScanBlizzQuestDataZone()
	end
end

--warbaby get blizzard default poi
function Nx.Quest:ScanBlizzQuestDataZone()

	local num = QuestMapUpdateAllQuests()		-- Blizz calls these in this order

	if num > 0 then

		QuestPOIUpdateIcons()

		local Map = Nx.Map
		local mapId = Map:GetCurrentMapId()
		local zone = Nx.MapIdToNxzone[mapId]

		if not zone then
--			Nx.prt ("ScanQuestZone %s, %s", mapId or "nil", num)
			return
		end

--		Nx.prt ("Id %s, %s", mapId, num)

		for n = 1, num do
			local id, qi = QuestPOIGetQuestIDByVisibleIndex (n)
			if qi and qi > 0 then				
				local title, level, tag, groupCnt, isHeader, isCollapsed, isComplete = GetQuestLogTitle (qi)
				local lbCnt = GetNumQuestLeaderBoards (qi)

				local quest = self.IdToQuest[id] --or {} --warbaby xxx
				local patch = self.IdToQuest[-id] or 0  --scaned flag 0x10 is target, 0x01 is complete
				local needEnd = quest and isComplete and not quest[3]
				
				if not quest or not quest[3] or patch > 0 or needEnd or (not isComplete and lbCnt > 0 and not quest[4]) then					
					local _, x, y, objective = QuestPOIGetIconInfo (id)

					if x then	-- Miner's Fortune was found in org, but x, y, obj were nil

--						Nx.prt ("%s #%s %s %s %s %s", mapId, n, id, x or "nil", y or "nil", objective or "nil")

						quest = quest or {}
						if not quest[1] then

--							self.ScanBlizzChanged = true

							quest[1] = format ("%c%s######", #title + 35, title)

							self.IdToQuest[id] = quest

							Nx.Quests[(id + 7) * 2 - 3] = quest

							Nx.Quest:RecordQuestsLog()
						end

						x = x * 10000
						y = y * 10000

						--if needEnd or bit.band (patch, 1) then --warbaby xxx, band mean the position is scaned before
						if not quest[3] or bit.band (patch, 1) then

							patch = bit.bor (patch, 1)		-- Flag as a patched quest

							--quest[3] = format ("##%c %c%c%c%c", zone + 35,
							--		floor (x / 221) + 35, x % 221 + 35, floor (y / 221) + 35, y % 221 + 35)
							
							local complete = GetQuestLogCompletionText(qi)
							local zoneAndPos = format("%c %c%c%c%c", zone + 35,
									floor (x / 221) + 35, x % 221 + 35, floor (y / 221) + 35, y % 221 + 35)
							if complete then
								quest[3] = format("!%c%s%s", complete:len() + 35, complete, zoneAndPos)
							else
								quest[3] = "##"..zoneAndPos
							end
						end

						if not isComplete then

							--one quest can only have one point, so set all target to that point
							patch = bit.bor (patch, 2)

							local s = title
							local obj = format ("%c%s%c %c%c%c%c", #s + 35, s, zone + 35,
									floor (x / 221) + 35, x % 221 + 35, floor (y / 221) + 35, y % 221 + 35)

							for i = 1, lbCnt do
								quest[3 + i] = obj
							end
						end

						self.IdToQuest[-id] = patch

--[[
						if not self.ScanBlizzChanged and
								(q2 ~= quest[2] or q4 ~= quest[4]) then

							self.ScanBlizzChanged = true
						end
--]]
					end
				end
			end
		end
	end
end


--------

function Nx.Quest:CalcCNumMax (cur, quest)

	if quest.CNum then

		cur.CNumMax = quest.CNum - 1

		local qc = quest
		while qc do
			cur.CNumMax = cur.CNumMax + 1
			qc = self.IdToQuest[self:UnpackNext (qc[1])]
		end
	end
end

--------
-- Set quests done

function Nx.Quest:CurQSetPreviousDone()
	if InCombatLockdown() then return 10 end --warbaby add, or reload in combat will cause serious lag because script ran too long

--	local sTime = GetTime()

	local cnt = 0

	for curi, cur in ipairs (self.CurQ) do
		if cur.QI > 0 then
			cnt = cnt + self:CalcPreviousDone (cur.QId)
		end
	end

	if cnt > 0 then
		Nx.prt (L["Set %d chain quests as done"], cnt)
	end

--	Nx.prt ("Calc %f secs", GetTime() - sTime)
end

function Nx.Quest:CalcPreviousDone (qId)

	local cnt = 0

	for mungeId, q in pairs (Nx.Quests) do

		if q.CNum == 1 then		-- Only look at chain starters

			local id = (mungeId + 3) / 2 - 7
			local qc = q
			while qc do

				if id == qId then		-- Found me in chain? Mark before me complete

					local id = (mungeId + 3) / 2 - 7
					local qc = q
					while id ~= qId do

						local qStatus = Nx:GetQuest (id)
						if qStatus ~= "C" then

							cnt = cnt + 1

--							Nx.prt ("%s %s", id, qId)
							Nx:SetQuest (id, "C", time())
						end

						id = self:UnpackNext (qc[1])
						qc = self.IdToQuest[id]
					end

					break
				end

				id = self:UnpackNext (qc[1])
				qc = self.IdToQuest[id]
			end
		end
	end

	return cnt
end

--------
-- Fired on login

function Nx.Quest:GetHistoryTimer()

--	local down = GetNetStats()		-- .08 to 4. Seems to be an average since it creeps down

--	Nx.prt ("GetNetStats %f", down)

--	if down > 2.5 then	-- Wait?
--		return 2
--	end

	if not Nx.CurCharacter["QHAskedGet"] then
		Nx.CurCharacter["QHAskedGet"] = true

		local function func()
			Nx.Timer:Start ("QHistQuery", .1, Nx.Quest, Nx.Quest.QuestQueryTimer)
		end

		Nx:ShowMessage (L["Get character's quest completion data from the server?"], L["Get"], func, L["Cancel"])
	end
end

function Nx.Quest:QuestQueryTimer()

	local qc = GetQuestsCompleted()
	if not qc then
		Nx.prt (L["QuestQueryTimer wait"])
		return 1
	end

--	Nx.prtVar ("OnQuest_query_complete", qc)

	local cnt = 0

	for id in pairs (qc) do

		local qStatus = Nx:GetQuest (id)
		if qStatus ~= "C" then

			cnt = cnt + 1
			Nx:SetQuest (id, "C", time())
		end
	end

	if cnt > 0 then
		Nx.prt (L["Set %d quests as done"], cnt)
		Nx.Quest.List:Update()
	end
end


function Nx.Quest:CalcDesc (quest, objI, cnt, total)

	local desc = ""
	local obj = quest and quest[objI + 3]
	if obj then
		desc = self:UnpackObjective (obj)
	end

	if total == 0 then
		return desc, cnt == 1
	else
		return format ("%s : %d/%d", desc, cnt, total), cnt >= total
	end
end


function Nx.Quest:GetLogIdLevel (index)

	if index > 0 then
		local qlink = GetQuestLink (index)
		if qlink then
			local s1, _, id, level = strfind (qlink, L["Hquest:(%d+):(.%d*)"])
			if s1 then

--				Nx.prt ("qlink %s", gsub (qlink, "|", "^"))

				return tonumber (id), tonumber (level)
			end
		end
	end
end

function Nx.Quest:CreateLink (qId, realLevel, title)
	--warbaby add use api
	local Ind = GetQuestLogIndexByID(qId)
	if Ind and Ind>0 then
		return GetQuestLink(Ind)
	end

	if realLevel <= 0 then	-- Could be a 0
		realLevel = -1
	end
	return format (L["|cffffff00|Hquest:%s:%s|h[%s]|h|r"], qId, realLevel, title)
end

function Nx.Quest:ExtractTitle (title)

--	Nx.prt ("Orig '%s'", title)

	local _, e = strfind (title, "^%[%S+%] ")
	if e then
		title = strsub (title, e + 1)

	else
		local _, e = strfind (title, "^%d+%S* ")
		if e then
			title = strsub (title, e + 1)
		end
	end

--	Nx.prt ("'%s'", title)

	return title
end

--------
-- Sort quests

function Nx.Quest:SortQuests()

	local curq = self.CurQ

	-- Sort by level

	repeat
		local done = true

		for n = 1, #curq - 1 do

			if curq[n].Level > curq[n + 1].Level then
				curq[n], curq[n + 1] = curq[n + 1], curq[n]
				done = false
			end
		end

	until done

	-- Sort by header

	if self.List.QOpts.NXShowHeaders then

		local hdrNames = {}

		for n = 1, #curq do
			hdrNames[curq[n].Header] = 1
		end

		local hdrs = {}

		for name in pairs (hdrNames) do
			tinsert (hdrs, name)
		end

		sort (hdrs)

--		Nx.prtVar ("HDR", hdrs)

		local curq2 = curq
		curq = {}

		for _, name in ipairs (hdrs) do

			for n = 1, #curq2 do

				if curq2[n].Header == name then
					tinsert (curq, curq2[n])
				end
			end
		end

		self.CurQ = curq

--		Nx.prtVar ("curq", curq)
	end

	-- Build id mapping

	local t = {}
	self.IdToCurQ = t

	for k, cur in ipairs (curq) do

		if cur.Q then
			local id = cur.QId
			t[id] = cur
		end
	end
end

--------
-- Detect a new quest

function Nx.Quest:FindNewQuest()

	-- Id
--[[
	if self.AcceptQId then	-- Auto accept quest triggered?

		local qi = GetQuestLogIndexByID (self.AcceptQId)
		self.AcceptQId = nil

		local title = self:ExtractTitle (GetQuestLogTitle (qi))

		if not self.RealQ[title] then
			return qi
		end
	end
--]]

	-- Scan by name

	local aQName = self.AcceptQName

	if not aQName then
		return
	end

	local cnt = GetNumQuestLogEntries()

--	Nx.prt ("FindNewQuest %d", cnt)

	for qn = 1, cnt do

		local title, level, tag, groupCnt, isHeader, isCollapsed, isComplete = GetQuestLogTitle (qn)

		if not isHeader then

			title = self:ExtractTitle (title)

			if title == aQName then

				if not self.RealQ[title] then
--					Nx.prtVar ("RealQ", self.RealQ)

					self.AcceptQName = nil
					return qn
				end
			end
		end
	end
end

--------

function Nx.Quest:RecordQuestAcceptOrFinish()

	local giver = UnitName ("npc") or "?"

	local guid = UnitGUID ("npc")
	if guid then
		local typ = tonumber (strsub (guid, 3, 5), 16)
		if typ == 0 then	-- Player
			giver = "p"

		elseif bit.band (typ, 0xf) == 1 then
			local id = tonumber (strsub (guid, 6, 12), 16)
			giver = format ("%s#o%x", giver, id)

		elseif bit.band (typ, 0xf) == 3 then		-- NPC?
			local id = tonumber (strsub (guid, 7, 10), 16)
			giver = format ("%s#%x", giver, id)
		end
	end

	self.AcceptGiver = giver

	local qname = GetTitleText()		-- Also works for auto accept
	self.AcceptQName = qname

	local id = Nx.Map:GetRealMapId()
--	self.AcceptNxzone = Nx.MapIdToNxzone[id] or 0
	self.AcceptAId = Nx.IdToAId[id] or 0

	self.AcceptDLvl = 0

	if Nx.Map:GetCurrentMapId() == id then
		self.AcceptDLvl = GetCurrentMapDungeonLevel()
	end

	local map = Nx.Map:GetMap (1)
	self.AcceptX = map.PlyrRZX
	self.AcceptY = map.PlyrRZY

--	Nx.prt ("AcceptQuest (%s) (%s) %s,%s", giver, qname, self.AcceptAId, self.AcceptDLvl)

end

--------

function Nx.Quest.OnChat_msg_combat_faction_change (event, arg1)

	local self = Nx.Quest

--	Nx.prt ("OnChat_msg_combat_faction_change %s", arg1)

	local form = FACTION_STANDING_INCREASED
	form = gsub (form, "%%s", "(.+)")
	form = gsub (form, "%%d", "(%%d+)")
	local facName, rep = strmatch (arg1, form)
	rep = tonumber (rep)

	if facName and rep and self.CaptureQEndTime and GetTime() - self.CaptureQEndTime < 2 then

		local facNum = self.CapFactionAbr[facName]
		if facNum then

			local _, race = UnitRace ("player")
			if race == "Human" then
				rep = rep / 1.1 + .5
			end

--			Nx.prt ("Fac %s %s", facName, rep)

			local cap = Nx:GetCap()
			local quests = Nx:CaptureFind (cap, "Q")
			local qdata = { strsplit ("~", quests[self.CaptureQEndId]) }
			local ender, reps = strsplit ("@", qdata[2])

			local repdata = reps and { strsplit ("^", reps) } or {}
			tinsert (repdata, format ("%d %x", rep, facNum))
			reps = table.concat (repdata, "^")

			qdata[2] = format ("%s@%s", ender, reps)
			quests[self.CaptureQEndId] = table.concat (qdata, "~")	-- concat is not global!!!
		end
	end

	self.CaptureQEndTime = nil
end

--------
-- Capture a quest
-- (current index, objective # (nil for start, -1 end)

function Nx.Quest:Capture (curi, objNum)

	local Nx = Nx
	local opts = self.GOpts

	if not opts["CaptureEnable"] then
		return
	end

	local cur = self.CurQ[curi]
	local id = cur.QId

	if NxData.DebugMap and (not objNum or objNum < 0) then	-- Start or end
		Nx.prt (L["Quest Capture %s"], id or L["nil"])
	end

	if not id then
		return
	end

	local cap = Nx:GetCap()

	local facI = UnitFactionGroup ("player") == "Horde" and 1 or 0
	local quests = Nx:CaptureFind (cap, "Q")
	local saveId = id * 2 + facI

	local len = 0

	for id, str in pairs (quests) do
		len = len + 4 + #str + 1
	end

	if len > 110 * 1024 then
		return
	end

--	Nx.prt ("Cap len %s", len)

--[[
	if not objNum or objNum < 0 then
		Nx.prt ("Capture %s %s %s %.2f,%.2f", self.AcceptGiver, self.AcceptAId or 0, self.AcceptDLvl, self.AcceptX, self.AcceptY)
	else
		local map = self.Map
		Nx.prt ("Capture #%s %s %.2f,%.2f", objNum, map.RMapId, map.PlyrRZX, map.PlyrRZY)
	end
--]]

--	local ids = self:CaptureGet (quests, id)
--	ids["I"] = format ("%d^%s^%s", cur.RealLevel, cur.Title, cur.Header)

	local q = quests[saveId]

	if not q then
		q = strrep ("~", cur.LBCnt + 1)
	end

	local qdata = { strsplit ("~", q) }

	if not objNum then	-- Starter

--		local flags = bit.bor (tonumber (strsub (qdata[1], 1, 1), 16) or 0, facMask)
		local plLvl = UnitLevel ("player")

		-- 0 is reserved
		local s = Nx:PackXY (self.AcceptX, self.AcceptY)
--		qdata[1] = format ("0%s^%02x%02x%s", self.AcceptGiver, plLvl, self.AcceptAId, s)
		qdata[1] = format ("0%s^%03x%x%s", self.AcceptGiver, self.AcceptAId, self.AcceptDLvl, s)

--		Nx.prt ("Capture start %s", qdata[1])

	elseif objNum < 0 then	-- Ender

		local s = Nx:PackXY (self.AcceptX, self.AcceptY)
		qdata[2] = format ("%s^%03x%x%s", self.AcceptGiver, self.AcceptAId, self.AcceptDLvl, s)

		self.CaptureQEndTime = GetTime()
		self.CaptureQEndId = saveId

--		Nx.prt ("Capture end %s", qdata[2])

	else

		local map = self.Map
--		local nxzone = Nx.MapIdToNxzone[map.RMapId]
		local nxzone = Nx.IdToAId[map.RMapId]
		if nxzone then

			local index = objNum + 2
			local obj = qdata[index]

			if not obj then
				Nx.prt (L["Capture err %s, %s"], cur.Title, objNum)
				return
			end

			if #obj >= 3 then
				local z = tonumber (strsub (obj, 1, 3), 16)
				if nxzone ~= z then
					return
				end
			else
				obj = format ("%03x", nxzone)
			end

			local cnt = (#obj - 3) / 6
			if cnt >= 15 then
				return
			end

			qdata[index] = obj .. Nx:PackXY (map.PlyrRZX, map.PlyrRZY)

--			Nx.prt ("Capture%d #%d %s", objNum, cnt, qdata[index])
		end
	end

	quests[saveId] = table.concat (qdata, "~")	-- concat is not global!!!

--	Nx.prt ("CapStr %s", quests[saveId])
end

function Nx.Quest:CaptureGetCount()

	local cap = Nx:GetCap()
	local quests = Nx:CaptureFind (cap, "Q")

	local cnt = 0

	for id, str in pairs (quests) do
		cnt = cnt + 1
	end

	return cnt
end

--------
-- Check for newly completed quests

--[[
function Nx.Quest:CheckForNewCompleted()

	local opts = Nx:GetGlobalOpts()

	if self.RealQEntries ~= GetNumQuestLogEntries() then	-- Quests added or removed?
		return
	end

	local curq = self.CurQ

	for _, cur in ipairs (curq) do

		if cur.QI > 0 then

			local title, level, tag, groupCnt, isHeader, isCollapsed, isComplete = GetQuestLogTitle (cur.QI)

			if isComplete and not cur.Complete then
				Nx.prt ("Quest Complete '%s'", title)
--PAIDS!
				if opts["QSndPlayCompleted"] then
					self:PlaySound()
				end
--PAIDE!
				if opts["QWRemoveComplete"] then
					self.Watch:RemoveWatch (cur.QId, cur.QI)
					self.Watch:Update()
					self.List:Update()
				end

				break
			end
		end
	end
end
--]]

--------
-- Play a completed sound
-- (snd index or nil for random)

function Nx.Quest:PlaySound (sndI)

	if not sndI then

		local opts = self.GOpts
		local cnt = 0

		for n = 1, 10 do
			if opts["QSnd" .. n] then
				cnt = cnt + 1
			end
		end

		if cnt > 0 then

			local i = random (1, cnt)
			cnt = 0

			for n = 1, 10 do
				if opts["QSnd" .. n] then
					cnt = cnt + 1
					if cnt == i then
						sndI = n
						break
					end
				end
			end
		end
	end

	if sndI then
		local snd = Nx.OptsDataSounds[sndI]
		Nx:PlaySoundFile (snd)
	end
end

--------
-- Tell party of quest changes

function Nx.Quest:TellPartyOfChanges()

--PAIDS!

	if self.RealQEntries ~= GetNumQuestLogEntries() then	-- Quests added or removed?
		return
	end

	local opts = self.GOpts
	if not opts["QBroadcastQChanges"] then
		return
	end

	local curq = self.CurQ

	for _, cur in ipairs (curq) do

		if cur.QI > 0 then

			for n = 1, cur.LBCnt do

				local skip
				local desc, _, done = GetQuestLogLeaderBoard (n, cur.QI)

				if desc then
					if not done then

						local num = opts["QBroadcastQChangesNum"]
						local oldCnt = tonumber (strmatch (cur[n] or "", ": (%d+)/"))
						local newCnt = tonumber (strmatch (desc, ": (%d+)/"))
						if oldCnt and newCnt then
							if floor (oldCnt / num) == floor (newCnt / num) then
								skip = true
							end
						end
					end

					if not skip and (desc ~= cur[n] or done ~= cur[n + 100]) then

						Nx.Com:Send ("P", desc)
--						Nx.prt ("%s", desc)
					end
				end
			end
		end
	end

--PAIDE!
end

--------
-- unused???

function Nx.Quest:GetLongTitle (cur)

	local title = format ("[%d] %s", cur.Level, cur.Title)

	local quest = cur.Q
	if quest and quest.CNum then
		title = title .. format (L[" (Part %d of %d)"], quest.CNum, cur.CNumMax)
	end

	return title
end

function Nx.Quest:GetPartTitle (quest, cur)

	local s = ""

	if quest and quest.CNum then
		if cur then
			s = s .. format (L["(Part %d of %d)"], quest.CNum, cur.CNumMax)
		else
			s = s .. format (L["(Part %d)"], quest.CNum)
		end
	end

	return s
end

function Nx.Quest:FindCur (qId, qIndex)

	if type (qId) == "string" then	-- Quest title?

		for n, v in ipairs (self.CurQ) do
			if v.Title == qId then
				return n, v, qId
			end
		end

		return
	end

	if qIndex and qId == 0 then
		local i, cur = self:FindCurByIndex (qIndex)
		return i, cur, cur.Title	-- Also return string type id
	end

	assert (qId > 0)

	for n, v in ipairs (self.CurQ) do
		if v.QId == qId then
			return n, v, qId
		end
	end
end

function Nx.Quest:FindCurByIndex (qi)

	assert (qi > 0)

	local curq = self.CurQ

	for n, v in ipairs (curq) do
		if v.QI == qi then
			return n, v
		end
	end
end

function Nx.Quest:FindCurFromOld (oldCur)

	for n, cur in ipairs (self.CurQ) do
		if cur.Title == oldCur.Title and cur.ObjText == oldCur.ObjText then
			return cur
		end
	end
end

--------
-- Check if any part of quest in the map

function Nx.Quest:CheckShow (mapId, qId)

	local nxid = Nx.MapIdToNxzone[mapId]
	local quest = self.IdToQuest[qId]

	if not quest then
		return
	end

	local qname, side, lvl, minlvl, next = self:Unpack (quest[1])

	--	Check start, end and objectives
--[[
	if not quest[2] then
		Nx.prt ("quest error: %s %s", qname, qId)
		assert (quest[2])
	end
--]]
	local _, startMapId = self:UnpackSE (quest[2])
	if startMapId then
		if startMapId == nxid then
			return true
		end
	end

	if quest[3] then
		local _, endMapId = self:UnpackSE (quest[3])
		if endMapId then
			if endMapId == nxid then
				return true
			end
		end
	end

	for n = 1, 15 do

		local obj = quest[n + 3]
		if not obj then
			break
		end

		local _, objMapId = self:UnpackObjective (obj)

		if objMapId then

			if objMapId == nxid then
				return true
			end
		end
	end
end

--------
--

function Nx.Quest:WatchAtLogin()

	for n, cur in ipairs (self.CurQ) do

		local qStatus = Nx:GetQuest (cur.QId)
		if not qStatus then

--			Nx.prt ("Add watch %s", cur.Title)
			self.Watch:Add (n)

--		elseif qStatus == "W" then
--			Nx.prt ("Watched %s", cur.Title)

--		elseif qStatus == "C" then
--			Nx.prt ("Completed %s", cur.Title)

		end
	end
end

function Nx.Quest:WatchAll()

	local curq = self.CurQ
	if curq then
		for i, cur in ipairs (curq) do
			self.Watch:Add (i)
		end
	end
end

function Nx.Quest:Goto (qId)

	if qId == 0 then
		return
	end

--	Nx.prt ("Goto %s", qId)

	local i = self:FindCur (qId)

	if i then
		Nx.prt (L["Already going to quest"])
		return
	end

	local curq = self.CurQ
	local quest = self.IdToQuest[qId]

	if not quest[2] then
		Nx.prt (L["No quest starter"])
		return
	end

	local name, side, lvl = self:Unpack (quest[1])

	local cur = {}
	cur.Goto = true
	cur.Q = quest
	cur.QI = 0
	cur.QId = qId
	cur.Header = "Goto"
	cur.Title = L["Goto: "] .. name
	cur.ObjText = ""
	cur.Level = lvl
	cur.PartySize = 1
	cur.LBCnt = 0
	cur.TrackMask = 1
	cur.TagShort = ""

	cur.Priority = 1
	cur.Distance = 999999999

	cur.HighPri = true

	self:CalcCNumMax (cur, quest)

	tinsert (curq, cur)
	cur.Index = #curq

	self.Watch:Add (#curq)

	self:RecordQuests()
	self.List:Update()
end

function Nx.Quest:Abandon (qIndex, qId)

	if qIndex > 0 then

		self:ExpandQuests()

		local title, level, tag, groupCnt, isHeader = GetQuestLogTitle (qIndex)

		if not isHeader then

--			Nx.prt ("Abandon %s %s", qIndex, title)

			SelectQuestLogEntry (qIndex)
--			QuestLog_SetSelection (qIndex)

			SetAbandonQuest()
			local items = GetAbandonQuestItems()
			if items then
				StaticPopup_Hide ("ABANDON_QUEST")
				StaticPopup_Show ("ABANDON_QUEST_WITH_ITEMS", GetAbandonQuestName(), items)
			else
				StaticPopup_Hide ("ABANDON_QUEST_WITH_ITEMS")
				StaticPopup_Show ("ABANDON_QUEST", GetAbandonQuestName())
			end
		end

		self:RestoreExpandQuests()

		if qId > 0 then
			Nx:SetQuest (qId, "c")
		end

	else
		if qId > 0 then

			self.Watch:RemoveWatch (qId, qIndex)

			local i = self:FindCur (qId)
			if i then
				local curq = self.CurQ
				tremove (curq, i)
			end
		end
	end
end

--------
-- Link a quest to chat edit frame

function Nx.Quest:LinkChat (qId)

	local box = ChatEdit_ChooseBoxForSend()
	ChatEdit_ActivateChat (box)

	if box then
		local s = self.List:MakeDescLink (nil, qId, IsControlKeyDown())
		if s then
			box:Insert (s)
		end
	else

		Nx.prt (L["|cffff4040No edit box open!"])
	end
end

--------
-- Get quests from a player

function Nx.Quest:GetFromPlyr (plName)

	Nx.ShowMessageTrial()

--	Nx.prt ("GetFromPlyr %s", plName)

	self.List.Bar:Select (4)

	self.FriendQuests = {}

	self.RcvPlyr = plName
	self.RcvPlyrLast = plName

	Nx.Com:Send ("W", "Q*", plName)
end

--------
-- Clear captured quests

function Nx.Quest:ClearCaptured()
	local t = Nx:GetCap() --warbaby for squish
	t["Q"] = {}
end

--------
-- Quest com message from a player

function Nx.Quest:OnMsgQuest (plName, msg)

--	Nx.prt ("OnMsgQuest (%s) %s", plName, msg)

	local id = strsub (msg, 2, 2)

	if id == "*" then		-- Request for all quests

--		if nil then
		if not self.SendPlyr or self.SendPlyr == plName then

			Nx.prt (L["Sending quests to %s"], plName)

			self.SendPlyr = plName
			self:BuildQSendData()
			Nx.Timer:Start ("QSendAll", 0, self, self.QSendAllTimer)
		else

			Nx.Com:Send ("W", "QB", plName)
		end

	elseif id == "B" then	-- Busy

		if plName == self.RcvPlyr then

			local mode = strsub (msg, 3, 3)

			if mode == "s" then
				Nx.prt (L[" %s -share"], self.RcvPlyr)
			elseif mode == "C" then
				Nx.prt (L[" %s busy"], self.RcvPlyr)
			else
				tinsert (self.FriendQuests, L[" ^Player is busy"])
			end

			self.RcvPlyr = nil

			local pd = self.CapturePlyrData[plName]
			if pd then
				pd.RcvPlyrCapName = nil
			end
		end

	elseif id == "D" then	-- Incoming quest data

		if plName == self.RcvPlyr then

			if #msg >= 4 then

				local data = strsub (msg, 3)
				local mode = strsub (msg, 3, 3)

				if mode == "0" then

					self.RcvCnt = 0
					self.RcvTotal = tonumber (strsub (data, 3)) or 0

				elseif mode == "H" then

					tinsert (self.FriendQuests, data)
					self.List:Update()

				elseif mode == "T" then

					self.RcvCnt = self.RcvCnt + 1
					tinsert (self.FriendQuests, data)

--					Nx.prt ("Quest Data %s", data)

					self.List:Update()

				elseif mode == "O" then

					tinsert (self.FriendQuests, data)
					self.List:Update()
				end
			else
				self.RcvPlyr = nil
			end
		end

	elseif id == "p" then	-- Incoming party data

		self:OnPartyMsg (plName, msg)

	end
end

function Nx.Quest:BuildQSendData()

	local data = {}

	self.QSendData = data
	self.QSendDataI = 1

	local header
	local cnt = 0

	for n, cur in ipairs (self.CurQ) do

		if not cur.Goto then

			if cur.Header ~= header then
				header = cur.Header

				local str = format ("QDH^%s", header)
				tinsert (data, str)
			end

			local qStatus = Nx:GetQuest (cur.QId)
			local watched = qStatus == "W" and 1 or 0

			local str = format ("QDT^%s^%s^%s^%s^%s", cur.QId, watched, cur.Complete or 0, cur.Level, cur.Title)
			tinsert (data, str)

			for n = 1, cur.LBCnt do
				local str = format ("QDO^%s^%s", -n, cur[n])
				tinsert (data, str)
			end

			cnt = cnt + 1
		end
	end

	tinsert (data, "QD")

	local str = format ("QD0^%d", cnt)
	tinsert (data, 1, str)
end

function Nx.Quest:QSendAllTimer()

	local qi = self.QSendDataI
	local data = self.QSendData[qi]

	if data then

		Nx.Com:Send ("W", data, self.SendPlyr)

--		Nx.prt ("QSendAllTimer: %s", data)
	end

	self.QSendDataI = qi + 1

	if self.QSendData[self.QSendDataI] then
		return .2
	end

	self.SendPlyr = nil
end

--------
-- Show quest is not in DB

function Nx.Quest:MsgNotInDB (typ)

	if typ == "O" then
		UIErrorsFrame:AddMessage (L["This objective is not in the database"], 1, 0, 0, 1)
	elseif typ == "Z" then
		UIErrorsFrame:AddMessage (L["This objective zone is not in the database"], 1, 0, 0, 1)
	else
		UIErrorsFrame:AddMessage (L["This quest is not in the database"], 1, 0, 0, 1)
	end
end

-------------------------------------------------------------------------------

-- Troll Patrol: The Alchemist's Apprentice quest

Nx.Quest.AlchemistsApprenticeData = {

	["Abomination Guts"] = "3~4~3492~5283",
	["Amberseed"] = "3~3~3496~5157",
	["Ancient Ectoplasm"] = "3~2~3498~5157",
	["Blight Crystal"] = "3~2~3488~5347",
	["Chilled Serpent Mucus"] = "3~3~3509~5342",
	["Crushed Basilisk Crystals"] = "4~2~3487~5339",
	["Crystallized Hogsnot"] = "3~4~3494~5157",
	["Frozen Spider Ichor"] = "3~2~3472~5309",
	["Ghoul Drool"] = "4~     4~3490~5100",
	["Hairy Herring Head"] = "Floor~Crate~3511~5127",
	["Icecrown Bottled Water"] = "2~1~3499~5157",
	["Knotroot"] = "4~1~3499~5152",
	["Muddy Mire Maggots"] = "Floor~Sack~3485~5155",
	["Pickled Eagle Egg"] = "2~2~3497~5157",
	["Prismatic Mojo"] = "4~3~3491~5289",
	["Pulverized Gargoyle Teeth"] = "2~4~3494~5157",
	["Putrid Pirate Perspiration"] = "2~3~3496~5157",
	["Raptor Claw"] = "3~2~3489~5283",
	["Seasoned Slider Cider"] = "Floor~Barrel~3508~5317",
	["Shrunken Dragon's Claw"] = "3~3~3489~5093",
	["Speckled Guano"] = "2~3~3490~5093",
	["Spiky Spider Egg"] = "3~4~3510~5095",
	["Trollbane"] = "3~1~     3505~5095",
	["Wasp's Wings"] = "3~1~3499~5157",
	["Withered Batwing"] = "4~3~3496~5153",
}

function Nx.Quest:OnChat_msg_raid_boss_whisper (event, arg1)

	if arg1 then

		if GetMinimapZoneText() == "Heb'Valok" then

			local self = Nx.Quest	-- Need?
--			Nx.prt ("%s, %s, %s", arg1, arg2 or "nil", arg3 or "nil")

			local name = gsub (arg1, "!", "")

			local data = self.AlchemistsApprenticeData[name]
			if data then
				local shelf, item, x, y = strsplit ("~", data)
				x = tonumber (x) * .01
				y = tonumber (y) * .01

				local s = format (L["%s on %s in %s"], name, shelf, item)

				if tonumber (shelf) then
					s = format (L["%s, shelf %s, item %s"], name, shelf, item)
				end

				self.Map:SetTargetXY (4011, x, y, s)
			end
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Quest tooltips

function	Nx.Quest.TooltipHook()

--	Nx.prt ("TooltipHook")

	Nx.Quest:TooltipProcess()
end

function	Nx.Quest:TooltipProcess (stripColor)

	local tipStr = GameTooltipTextLeft1:GetText()
	if not tipStr then		-- Happens in WotLK on empty slots
		return
	end

--	Nx.prt ("TooltipProcess %s", tipStr)

	Nx.TooltipLastDiffText = tipStr

--	local sTime = GetTime()

	local show = Nx.Quest:TooltipProcess2 (stripColor, tipStr)
--	show = show or Nx.Warehouse:TooltipProcess()
	show = Nx.Warehouse:TooltipProcess() or show

	if show then
		GameTooltip:Show()	-- Adjusts size
	end

--	Nx.prt ("TTProcess %f secs", GetTime() - sTime)

	Nx.TooltipLastDiffNumLines = GameTooltip:NumLines()	-- Stop multiple checks
end

function	Nx.Quest:TooltipProcess2 (stripColor, tipStr)

	if not self.GOpts["QAddTooltip"] then
		return
	end

	local tip = GameTooltip

	-- Check if already added

	local textName = "GameTooltipTextLeft"
	local questStr = format (L["|cffffffffQ%suest:"], Nx.TXTBLUE)

	for n = 2, tip:NumLines() do
		local s = _G[textName .. n]:GetText()
		if s then

			local s1 = strfind (s, questStr)
			if s1 then
--				Nx.prt ("TTM #%s", GameTooltip:NumLines())
				return
			end
			if strsub (s, 1, 3) == " - " then	-- Blizz added quest info?

				local fstr = _G[textName .. (n - 1)]
				local qTitle = fstr:GetText()

				local i, cur = self:FindCur (qTitle)
				if cur then
					local color = self:GetDifficultyColor (cur.Level)
					color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
					fstr:SetText (format ("%s %s%d %s", questStr, color, cur.Level, cur.Title))
				end

				tip:AddLine (" ")		-- Add blank or same tip will not add info again

				return true;
			end
		end
	end

	-- Scan tooltip

	if stripColor then
		tipStr = gsub (tipStr, "|c%x%x%x%x%x%x%x%x", "")
	end

	if tipStr and #tipStr > 5 and #tipStr < 50 and not self.TTIgnore[tipStr] then

		tipStr = self.TTChange[tipStr] or tipStr
		local tipStrLower = strlower (tipStr)

		local curq = self.CurQ

		for curi, cur in ipairs (curq) do

			if not cur.Goto then		-- Skip Goto and Party quests

				local s1 = strfind (cur.ObjText, tipStr, 1, true)
				if not s1 then
					s1 = strfind (cur.DescText, tipStr, 1, true)
				end
				if not s1 then
					s1 = strfind (cur.ObjText, tipStrLower, 1, true)
				end
				if not s1 then
					s1 = strfind (cur.DescText, tipStrLower, 1, true)
				end
				if not s1 then
					for n = 1, cur.LBCnt do
						if cur[n] then	-- V4
							s1 = strfind (cur[n], tipStr)
							if s1 then
								break
							end
						end
					end
				end

				if s1 then

					local color = self:GetDifficultyColor (cur.Level)
					color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

					tip:AddLine (format ("%s %s%d %s", questStr, color, cur.Level, cur.Title))

					for n = 1, cur.LBCnt do
						if strfind (cur[n], tipStr) then
							local color, s1 = self:CalcPercentColor (cur[n], cur[n + 100])
							if s1 then
								local oName = strsub (cur[n], 1, s1 - 1)
								tip:AddLine (format ("    |cffb0b0b0%s%s%s", oName, color, strsub (cur[n], s1)))
							else
								tip:AddLine (format ("    %s%s", color, cur[n]))
							end
						end
					end

--					Nx.prt ("TTProcess %s #%s", tipStr, tip:NumLines())

					return true;
				end
			end
		end
	end
end

--------

function Nx.Quest:GetDifficultyColor (level)

	return GetQuestDifficultyColor (level)
end

--------

function Nx.Quest:CalcPercentColor (desc, done)

	local s1, _, i, total = strfind (desc, ": (%d+)/(%d+)")

	if done then
		return self.PerColors[9], s1
	else
		i = s1 and floor (tonumber (i) / tonumber (total) * 8.99) + 1 or 1
		return self.PerColors[i], s1
	end
end

--------

function Nx.Quest:GetZoneAchievement (always)

	local mId = Nx.Map:GetCurrentMapId()
--	local mId = Map:GetRealMapId()

	local a = Nx.Map.MapWorldInfo[mId].QAchievementId
	if a then

		local id, name, _, done = GetAchievementInfo (a)
		if always or not done then
			if GetAchievementNumCriteria(a) > 0 then 
				local _, _, done, cnt, need = GetAchievementCriteriaInfo (a, 1)
				local col = done and "|cff808080" or "|cff8080ff"
				return format ("%s%s %d/%d", col, name, cnt, need)
			end
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Quest list

----------------------------------

--------
-- Open and init or toggle Quest frame

function Nx.Quest.List:Open()

	local gopts = Nx:GetGlobalOpts()

	local qopts = Nx:GetQuestOpts()
	self.QOpts = qopts

	local TabBar = Nx.TabBar

	self.ShowAllZones = false
	self.Opened = true

	-- Create window

	local win = Nx.Window:Create ("NxQuestList")
	win:Show(false); --warbaby create and then close
	self.Win = win

	win:CreateButtons (true, true)
	win:InitLayoutData (nil, -.24, -.15, -.52, -.65)

	tinsert (UISpecialFrames, "QuestLogFrame")
	tinsert (UISpecialFrames, win.Frm:GetName())

	win.Frm:SetToplevel (true)
	win.Frm:SetMinResize (250, 120)

	win:SetUser (self, self.OnWin)
	win:RegisterEvent ("PLAYER_LOGIN", self.OnQuestUpdate)
--	win:RegisterEvent ("PLAYER_LOGOUT", self.OnQuestUpdate)
--	win:RegisterEvent ("PLAYER_LEAVING_WORLD", self.OnQuestUpdate)
    win:RegisterEvent ("QUEST_ACCEPTED", self.OnQuestUpdate)
	win:RegisterEvent ("QUEST_LOG_UPDATE", self.OnQuestUpdate)
	win:RegisterEvent ("QUEST_WATCH_UPDATE", self.OnQuestUpdate)
	win:RegisterEvent ("UPDATE_FACTION", self.OnQuestUpdate)
	win:RegisterEvent ("UNIT_QUEST_LOG_CHANGED", self.OnQuestUpdate)
	win:RegisterEvent ("QUEST_PROGRESS", self.OnQuestUpdate)
	win:RegisterEvent ("QUEST_COMPLETE", self.OnQuestUpdate)
	win:RegisterEvent ("QUEST_DETAIL", self.OnQuestUpdate)
    win:RegisterEvent ("SCENARIO_UPDATE", self.OnQuestUpdate)
    win:RegisterEvent ("SCENARIO_CRITERIA_UPDATE", self.OnQuestUpdate)
    win:RegisterEvent ("WORLD_STATE_TIMER_START", self.OnQuestUpdate)
    win:RegisterEvent ("WORLD_STATE_TIMER_STOP", self.OnQuestUpdate)	

	-- Filter Edit Box

	local f = CreateFrame ("EditBox", "NxQuestFilter", win.Frm)
	self.FilterFrm = f

	f.NxInst = self

	f:SetScript ("OnEditFocusGained", self.FilterOnEditFocusGained)
	f:SetScript ("OnEditFocusLost", self.FilterOnEditFocusLost)
	f:SetScript ("OnTextChanged", self.FilterOnTextChanged)
	f:SetScript ("OnEnterPressed", self.FilterOnEnterPressed)
	f:SetScript ("OnEscapePressed", self.FilterOnEscapePressed)

	f:SetFontObject ("NxFontS")

	local t = f:CreateTexture()
	t:SetTexture (.1, .2, .3, 1)
	t:SetAllPoints (f)
	f.texture = t

	f:SetAutoFocus (false)
	f:ClearFocus()

	win:Attach (f, 0, 1, 0, 18)

	self.FilterDesc = L["Search: [click]"]
	self.FilterDescEsc = L["Search: %[click%]"]

--	if Nx.Free then
--		self.FilterDesc = "Search: " .. Nx.FreeMsg
--	end

	self.Filters = { "", "", "", ""}

	f:SetText (self.FilterDesc)
	f:SetMaxLetters (30)

	-- List

	Nx.List:SetCreateFont ("FontQuest", 12)

	local list = Nx.List:Create (L["Quest"], 0, 0, 1, 1, win.Frm)
	self.List = list

	list:SetUser (self, self.OnListEvent)

	list:SetLineHeight (0, 6)

	list:ColumnAdd ("", 1, 20)
	list:ColumnAdd ("", 2, 300)
--	list:ColumnAdd ("Lvl", 3, 20, "CENTER")
	list:ColumnAdd ("", 3, 0)
	list:ColumnAdd ("", 4, 600)
	list:ColumnAdd ("", 5, 200)
	list:ColumnAdd ("", 6, 500)

	-- Create menu

	local menu = Nx.Menu:Create (list.Frm, 240)
	self.Menu = menu

	local menui1 = {}
	self.MenuItems1 = menui1

	local menui2 = {}
	self.MenuItems2 = menui2

	local menui3 = {}
	self.MenuItems3 = menui3

	local menui4 = {}
	self.MenuItems4 = menui4

	local item = menu:AddItem (0, L["Open Quest Map (or right click dot)"], self.Menu_OpenToQuest, self)
	tinsert (menui1, item)
    
    local item = menu:AddItem (0, "")
	tinsert (menui1, item)

	local item = menu:AddItem (0, L["Toggle High Watch Priority"], self.Menu_OnHighPri, self)
	tinsert (menui1, item)

	local item = menu:AddItem (0, L["Show Category Headers"], self.Menu_OnShowHeaders, self)
	item:SetChecked (qopts.NXShowHeaders)
	tinsert (menui1, item)

	local item = menu:AddItem (0, L["Show Objectives"], self.Menu_OnShowObjectives, self)
	item:SetChecked (qopts.NXShowObj)
	tinsert (menui1, item)

	local item = menu:AddItem (0, L["Show Only Party Quests"], self.Menu_OnShowParty, self)
	item:SetChecked (false)
	tinsert (menui1, item)

	local item = menu:AddItem (0, "")
	tinsert (menui1, item)

	local item = menu:AddItem (0, L["Watch All Quests"], self.Menu_OnWatchAll, self)
	tinsert (menui1, item)

	local item = menu:AddItem (0, L["Watch All Completed Quests"], self.Menu_OnWatchCompleted, self)
	tinsert (menui1, item)

	local item = menu:AddItem (0, "")
	tinsert (menui1, item)

	local item = menu:AddItem (0, L["Broadcast Quest Changes To Party"], nil, self)
	item:SetChecked (gopts, "QBroadcastQChanges")
	tinsert (menui1, item)
	local item = menu:AddItem (0, L["Send Quest Status To Party"], self.Menu_OnSendQInfo, self)
	tinsert (menui1, item)
	local item = menu:AddItem (0, L["Share"], self.Menu_OnShare, self)
	self.MenuIShare = item
	tinsert (menui1, item)

	local item = menu:AddItem (0, "")
	tinsert (menui1, item)
	local item = menu:AddItem (0, L["Abandon"], self.Menu_OnAbandon, self)
	tinsert (menui1, item)

	local item = menu:AddItem (0, L["Remove"], self.Menu_OnCompleted, self)
	tinsert (menui2, item)

	local item = menu:AddItem (0, L["Remove All"], self.Menu_OnHistoryRemoveAll, self)
	tinsert (menui2, item)

	local function func()
		Nx.CurCharacter["QHAskedGet"] = true
		Nx.Timer:Start ("QHistLogin", .1, Nx.Quest, Nx.Quest.QuestQueryTimer)
--		QueryQuestsCompleted()
	end
	local item = menu:AddItem (0, L["Get Completed From Server"], func, self)
	tinsert (menui2, item)

	local item = menu:AddItem (0, L["Mark As Previously Completed"], self.Menu_OnCompleted, self)
	tinsert (menui3, item)

	tinsert (menui3, menu:AddItem (0, L["Goto Quest Giver"], self.Menu_OnGoto, self))

	local item = menu:AddItem (0, "")
	tinsert (menui2, item)
	tinsert (menui3, item)

	local item = menu:AddItem (0, L["Show All Quests"], self.Menu_OnShowAllQuests, self)
	item:SetChecked (false)
	tinsert (menui2, item)
	tinsert (menui3, item)

	local item = menu:AddItem (0, L["Show Low Level Quests"], self.Menu_OnShowLowLevel, self)
	item:SetChecked (false)
--	tinsert (menui2, item)
	tinsert (menui3, item)

	local item = menu:AddItem (0, L["Show High Level Quests"], self.Menu_OnShowHighLevel, self)
	item:SetChecked (false)
--	tinsert (menui2, item)
	tinsert (menui3, item)

	local item = menu:AddItem (0, L["Show Quests From All Zones"], self.Menu_OnShowAllZones, self)
	item:SetChecked (false)
	tinsert (menui2, item)
	tinsert (menui3, item)

	local item = menu:AddItem (0, L["Show Finished Quests"], self.Menu_OnShowFinished, self)
	item:SetChecked (false)
	tinsert (menui3, item)

	local item = menu:AddItem (0, L["Show Only Non Dungeon Dailies"], self.Menu_OnShowOnlyDailies, self)
	item:SetChecked (false)
	tinsert (menui3, item)

	local item = menu:AddItem (0, "")
	tinsert (menui3, item)
	local item = menu:AddItem (0, L["Track None"], self.Menu_OnTrackNone, self)
	tinsert (menui3, item)

	local item = menu:AddItem (0, "")
	tinsert (menui1, item)
	tinsert (menui2, item)
	tinsert (menui3, item)

	local function func()
		Nx.Opts:Open ("Quest")
	end
	local item = menu:AddItem (0, L["Options..."], func)
	tinsert (menui1, item)
	tinsert (menui2, item)
	tinsert (menui3, item)

	-- Quest details

	local f = CreateFrame ("ScrollFrame", "NxQuestD", win.Frm, "NxQuestDetails")

	self.DetailsFrm = f
	f.NxSetSize = self.OnDetailsSetSize

	f:SetMovable (true)
	f:EnableMouse (true)

	f:SetFrameStrata ("MEDIUM")

	local t = f:CreateTexture()
	t:SetTexture (.7, .7, .5, 1)
	t:SetAllPoints (f)
	f.texture = t

	f:Show()

	-- Create Tab Bar

	local bar = TabBar:Create (nil, win.Frm, 1, 1)
	self.Bar = bar

	local tbH = TabBar:GetHeight()

	win:Attach (bar.Frm, 0, 1, -tbH, 1)

	bar:SetUser (self, self.OnTabBar)

	self.TabSelected = 1

	bar:AddTab (L["Current"], 1, nil, true)
	bar:AddTab (L["History"], 2)
	bar:AddTab (L["Database"], 3)
	bar:AddTab (L["Player"], 4)

	-- Old attach

--	local qdf = getglobal ("QuestLogDetailScrollFrame")
--	win:Attach (qdf, 0, 1, .6, 1)
--[[
	local t = qdf:CreateTexture()
	t:SetTexture (.7, .7, .5, .7)
	t:SetAllPoints (qdf)
	qdf.texture = t
--]]
	-- Quest log

--	local qlogf = getglobal ("QuestLogFrame")
--	win:Attach (qlogf, .8, 1, 0, 1, true)

	--

	self:AttachFrames()
end

--------
-- Attach our frames

function Nx.Quest.List:AttachFrames()

	local gopts = Nx:GetGlobalOpts()
	local win = self.Win
	local list = self.List
	local tbH = Nx.TabBar:GetHeight()

	if gopts["QSideBySide"] then

		local r = .55
		if self.TabSelected ~= 1 then
			r = 1
		end
		win:Attach (list.Frm, 0, r, 18, -tbH)
		win:Attach (self.DetailsFrm, .55, 1, 18, -tbH)

	else
		local bot = .6
		if self.TabSelected ~= 1 then
			bot = -tbH
		end
		win:Attach (list.Frm, 0, 1, 18, bot)
		win:Attach (self.DetailsFrm, 0, 1, .6, -tbH)
	end
end

function Nx.Quest.List:UpdateMenu()

	local showi = self.MenuItems1
	local hidei1 = self.MenuItems2
	local hidei2 = self.MenuItems3

	if self.TabSelected == 2 then

		showi = self.MenuItems2
		hidei1 = self.MenuItems1

	elseif self.TabSelected == 3 then

		showi = self.MenuItems3
		hidei2 = self.MenuItems1
	end

	for k, v in pairs (hidei1) do
		v:Show (false)
	end

	for k, v in pairs (hidei2) do
		v:Show (false)
	end

	for k, v in pairs (showi) do		-- Do last so items in multiple lists work
		v:Show()
	end

	if self.TabSelected == 1 then

		local show = -1
		local i = self.List:ItemGetData()
		if i then

			local qi = bit.band (i, 0xff)
			if qi > 0 then
				local i, cur = Nx.Quest:FindCurByIndex (qi)
				if cur then
					if cur.CanShare then
						show = true
					end
				end
			end
		end

		self.MenuIShare:Show (show)
	end
end

--------

function Nx.Quest:ShowUIPanel (frame)

	if self.InShowUIPanel then
		return
	end

	self.InShowUIPanel = true

	frame:Hide()

	local detailFrm = QuestLogDetailFrame
	if detailFrm then
		detailFrm:Hide()
	end

	local orig = IsAltKeyDown() and not self.IgnoreAlt
	local opts = self.GOpts
	if opts["QUseAltLKey"] then
		orig = not orig
	end

	if orig then	-- Show original quest log?

		frame:SetScale (1)

		--QuestLogFrame:SetAttribute ("UIPanelLayout-enabled", true)
		local _, _, _, x, y = QuestLogFrame:GetPoint()
		if x and floor(x + 0.5) == -999 then
			QuestLogFrame:ClearAllPoints()
			QuestLogFrame:SetPoint("TOPLEFT", 16, -116)
		end

		ShowUIPanel (frame)

		if detailFrm then
			detailFrm:SetScale (1)
		end

		self:LightHeadedAttach (frame)
	else

		local win = self.List.Win

		if win and not GameMenuFrame:IsShown() then

			self:ExpandQuests()

			local wf	= win.Frm

--			local ff = frame
--			Nx.prt ("LevS1 "..wf:GetFrameLevel().." "..ff:GetFrameLevel())

			win:Show()
			self.List:Update()
			wf:Raise()

--			Nx.prt ("LevS2 "..wf:GetFrameLevel().." "..ff:GetFrameLevel())

			frame:Show()
			--frame:SetScale (.1)
			frame:ClearAllPoints()
			frame:SetClampedToScreen(false)
			frame.__blizzMove = true
			frame:SetPoint ("TOPLEFT", -999, 999)
			frame.__blizzMove = nil

			if detailFrm then
				--detailFrm:SetScale (.1)
				detailFrm:ClearAllPoints()
				detailFrm:SetClampedToScreen(false)
				detailFrm.__blizzMove = true
				detailFrm:SetPoint ("TOPLEFT", -999, 999)
				detailFrm.__blizzMove = nil
			end

--			Nx.prt ("LevS3 "..wf:GetFrameLevel().." "..ff:GetFrameLevel())

			self:LightHeadedAttach (wf, true)
		end
	end

	self.InShowUIPanel = false
end

--------

function Nx.Quest:HideUIPanel (frame)

	QuestLogFrame:SetAttribute ("UIPanelLayout-enabled", false)

	local detailFrm = QuestLogDetailFrame
	if detailFrm then
		detailFrm:Hide()
	end

	self.List:DetailsSetWidth (285)

	self.List.Win:Show (false)

	if self.List.List:ItemGetNum() > 0 then
		self.List.List:Empty()
		collectgarbage ("collect")
	end

	self:RestoreExpandQuests()		-- Hide window first, then restore

	self.LHAttached = nil
end

function Nx.Quest:LightHeadedAttach (frm, attach, onlyLevels)

	local lh = getglobal ("LightHeaded")
	local lhf = getglobal ("LightHeadedFrame")
	if not (lh and lhf) then
		return
	end

	local db = lh["db"]
	if not db then
		return
	end

	local profile = db["profile"]
	if not profile then
		return
	end

--	Nx.prtFrame ("LightHeaded", lhf)
--	Nx.prtFrameChildren ("LightHeaded", lhf)

	lhf:SetParent (frm)

	local lvl = frm:GetFrameLevel()
	local open = profile["open"]

	if not attach then

		lvl = lvl - 1
		local x = open and -15 or -328
		lhf:ClearAllPoints()
		lhf:SetPoint ("LEFT", frm, "RIGHT", x, 0)		--  OLD -50, 19

	else

		self.LHAttached = profile
		self.LHOpen = open

		lvl = open and lvl or 1
		local x = open and -4 or -326
		lhf:ClearAllPoints()
		lhf:SetPoint ("TOPLEFT", frm, "TOPRIGHT", x, -19)
	end

	lhf:SetFrameLevel (lvl)
	Nx.Util_SetChildLevels (lhf, lvl + 1)

	if not onlyLevels then

		lhf:Show()

		if not profile["attached"] then
			lh["LockUnlockFrame"](lh)
		end
	end
end

--------
-- Frame update. Called by main addon frame

function Nx.Quest:OnUpdate (elapsed)

	if not self.List.Win:IsShown() then
--		Nx.prt ("skip")
		return
	end

	if self.LHAttached then

		local profile = self.LHAttached
		if self.LHOpen ~= profile["open"] then
			self:LightHeadedAttach (self.List.Win.Frm, true)
		end

		if Nx.Tick % 20 == 0 then
			self:LightHeadedAttach (self.List.Win.Frm, true, true)
		end
	end
end

--------
-- Select quest in list

function Nx.Quest.List:Select (qId, qI)

	local list = self.List

	for n = 1, list:ItemGetNum() do

		local i = list:ItemGetData (n)
		if i then

			local qi = bit.band (i, 0xff)
			local qid = bit.rshift (i, 16)

			if qi == qI and qid == qId then

				Nx.Quest:SelectBlizz (qi)
				list:Select (n)
				self:Update()

				break
			end
		end
	end
end

--------

function Nx.Quest.List:GetCurSelected()

	local i = self.List:ItemGetData()
	if i then

		local qi = bit.band (i, 0xff)
		local qid = bit.rshift (i, 16)
		if qid > 0 or qi > 0 then
			local _, cur = Nx.Quest:FindCur (qid, qi)
			return cur
		end
--[[
		local qi = bit.band (i, 0xff)
		if qi > 0 then

			local i, cur = Nx.Quest:FindCurByIndex (qi)
			return cur
		else

			local qid = bit.rshift (i, 16)
			local i, cur = Nx.Quest:FindCur (qid)
			return cur
		end
--]]
	end
end

--------

function Nx.Quest.List:OnWin (typ)

	if typ == "Close" then
		HideUIPanel (QuestLogFrame)
--		QuestLogFrame:Hide()
	end
end

--------

function Nx.Quest.List:FilterOnEditFocusGained()

	Nx.ShowMessageTrial()

	local this = self			--V4
	local self = this.NxInst

	local s = self.Filters[self.TabSelected]
	if s ~= "" then
		this:SetText (s)
	else
		this:SetText ("")
	end
end

function Nx.Quest.List:FilterOnEditFocusLost()

	local this = self			--V4
	local self = this.NxInst

	if self.Filters[self.TabSelected] == "" then
		this:SetText (self.FilterDesc)
	end
end

function Nx.Quest.List:FilterOnTextChanged()

	local this = self			--V4
	local self = this.NxInst
	self.Filters[self.TabSelected] = gsub (this:GetText(), self.FilterDescEsc, "")
--	Nx.prt ("Filter #%s = %s", self.TabSelected, self.Filters[self.TabSelected])
	self:Update()
end

function Nx.Quest.List:FilterOnEnterPressed()
	local this = self			--V4
	this:ClearFocus()
end

function Nx.Quest.List:FilterOnEscapePressed()

	local this = self			--V4
	local self = this.NxInst
	self.Filters[self.TabSelected] = ""

	this:ClearFocus()
end

--------

function Nx.Quest.List:OnTabBar (index, click)

	self.FilterFrm:ClearFocus()

	self.TabSelected = index

	if index == 1 then
		self.DetailsFrm:Show()
		self:AttachFrames()
	else
		self.DetailsFrm:Hide()
		self:AttachFrames()
	end

	local s = self.Filters[self.TabSelected]
	s = s ~= "" and s or self.FilterDesc
	self.FilterFrm:SetText (s)

	self:Update()
end

--------
-- Menu handlers

function Nx.Quest.List:Menu_OnGoto (item)

	local i = self.List:ItemGetData()
	if i then

		local qIndex = bit.band (i, 0xff)

		if qIndex > 0 then
			Nx.prt (L["Already have the quest!"])

		else
			local qId = bit.rshift (i, 16)
			Nx.Quest:Goto (qId)

			self:Update()
		end
	end
end

function Nx.Quest.List:Menu_OpenToQuest()
    local i = self.List:ItemGetData()
	if i then
		local qId = bit.rshift (i, 16)
        Nx_WorldMap_OpenToQuest(qId)
    end
end

function Nx.Quest.List:Menu_OnHighPri (item)

	local cur = self:GetCurSelected()
	if cur then
		cur.HighPri = not cur.HighPri
		self:Update()
	end
end

function Nx.Quest.List:Menu_OnShowHeaders (item)

	self.QOpts.NXShowHeaders = item:GetChecked()
	Nx.Quest:SortQuests()
	self:Update()
end

function Nx.Quest.List:Menu_OnShowObjectives (item)

	self.QOpts.NXShowObj = item:GetChecked()
--	Nx.Quest:SortQuests()
	self:Update()
end

function Nx.Quest.List:Menu_OnShowAllQuests (item)
	self.ShowAllQuests = item:GetChecked()
	self:Update()
end

function Nx.Quest.List:Menu_OnShowLowLevel (item)
	self.ShowLowLevel = item:GetChecked()
	self:Update()
end

function Nx.Quest.List:Menu_OnShowHighLevel (item)
	self.ShowHighLevel = item:GetChecked()
	self:Update()
end

function Nx.Quest.List:Menu_OnShowAllZones (item)
	self.ShowAllZones = item:GetChecked()
	self:Update()
end

function Nx.Quest.List:Menu_OnShowFinished (item)
	self.ShowFinished = item:GetChecked()
	self:Update()
end

function Nx.Quest.List:Menu_OnShowOnlyDailies (item)
	self.ShowOnlyDailies = item:GetChecked()
	self:Update()
end

function Nx.Quest.List:Menu_OnShowParty (item)
	self.ShowParty = item:GetChecked()
	self:Update()
end

function Nx.Quest.List:Menu_OnCompleted (item)

	local i = self.List:ItemGetData()
	if i then

		local qId = bit.rshift (i, 16)
		local qStatus, qTime = Nx:GetQuest (qId)

		if qStatus == "C" then
			qStatus = "c"
		else
			qStatus = "C"
			qTime = time()
		end

--		Nx.prt ("ToggleQuestComplete %d %s %s", qId, qStatus, qTime)

		Nx:SetQuest (qId, qStatus, qTime)

		self:Update()
		Nx.Map:GetMap(1).Guide:UpdateGatherFolders()
	end
end

function Nx.Quest.List:Menu_OnHistoryRemoveAll()

	local idT = Nx.Quest.IdToCurQ
	local questT = Nx.CurCharacter.Q

	for id in pairs (questT) do
		if not idT[id] then
			questT[id] = nil
		end
	end

	Nx.prt (L["History cleared"])
	self:Update()
end


function Nx.Quest.List:Menu_OnSortWatched (item)
	local on = item:GetChecked()
	Nx.Quest:SetWatchSortMode (on and 1 or 0)
end

function Nx.Quest.List:Menu_OnWatchAll()
	Nx.Quest:WatchAll()
	self:Update()
end

function Nx.Quest.List:Menu_OnWatchCompleted (item)

	local curq = Nx.Quest.CurQ

	if curq then

		for i, cur in ipairs (curq) do

--			Nx.prt ("Q #%d %s %s", i, cur.Title, cur.Complete or "nil")

			if cur.Complete and cur.Complete == 1 then
				Nx.Quest.Watch:Add (i)
			end
		end

		self:Update()
	end
end

function Nx.Quest.List:Menu_OnSendQInfo (item)

	local i = self.List:ItemGetData()
	if i then

		local qi = bit.band (i, 0xff)
		self:SendQuestInfo (qi)
	end
end

function Nx.Quest.List:SendQuestInfo (qi)

	if qi > 0 then

		self.SendQInfoQI = qi
		self.SendQInfoMode = -1
		self.SendQTarget = nil

		local box = Nx.FindActiveChatFrameEditBox()
		if box then
			local typ = box:GetAttribute ("chatType")
--			Nx.prt ("chattype %s", typ)
			if typ == "WHISPER" then
				self.SendQTarget = box:GetAttribute ("tellTarget")
				self.SendQLanguage = box["language"]
				ChatEdit_OnEscapePressed (box)
			end
		end

		Nx.Timer:Start ("QSendInfo", 0, self, self.OnSendQuestInfoTimer)
	end
end

function Nx.Quest.List:OnSendQuestInfoTimer()

	local qi = self.SendQInfoQI
	local i, cur = Nx.Quest:FindCurByIndex (qi)

	if not i then
		return
	end

	local sendStr
	local mode = self.SendQInfoMode

	if mode == -1 then

		sendStr = self:MakeDescLink (cur)
		mode = 0
--[[
	elseif mode == 0 then
		local str = strsub (cur.ObjText, 1, 180)
		str = format (" %s", str)
		str = gsub (str, "[\n\r\t]", "")
		if #cur.ObjText > 180 then
			str = str .. "..."
		end
		Nx.Com:Send ("P", str)
--]]
	else

		local desc = cur[mode]
		if not desc then
			return
		end

		sendStr = format ("  %s", desc)
	end

	if self.SendQTarget then
--		Nx.Com:Send ("W", sendStr, self.SendQTarget)
		SendChatMessage (sendStr, "WHISPER", self.SendQLanguage, self.SendQTarget);
	else
		Nx.Com:Send ("P", sendStr)
	end

	self.SendQInfoMode = mode + 1

	return .33
end

function Nx.Quest.List:Menu_OnShare (item)

	local i = self.List:ItemGetData()
	if i then

		local qi = bit.band (i, 0xff)
		if qi > 0 then
			if GetNumSubgroupMembers() > 0 then
				QuestLogPushQuest()
			else
				Nx.prt (L["Must be in party to share"])
			end
		end
	end
end

function Nx.Quest.List:Menu_OnAbandon (item)

	local i = self.List:ItemGetData()
	if i then

		local qIndex = bit.band (i, 0xff)
		local qId = bit.rshift (i, 16)
		Nx.Quest:Abandon (qIndex, qId)

--		self:Update()	-- Dialog gets closed!
	end
end

--[[
function Nx.Quest.List:Menu_OnTrackAll (item)

	local curq = Nx.Quest.CurQ

	if curq then

		for _, cur in ipairs (curq) do

			local quest = cur.Q
			if quest then
				Nx.Quest.Tracking[cur.QId] = 0xffffffff		-- Track all
			end
		end

		self:Update()
	end
end
--]]

function Nx.Quest.List:Menu_OnTrackNone (item)
	Nx.Quest.Watch:ClearAutoTarget()
	self:Update()
end

--------
-- On list control updates

function Nx.Quest.List:OnListEvent (eventName, sel, val2, click)

	local Quest = Nx.Quest
	local Map = Nx.Map

	local itemData = self.List:ItemGetData (sel) or 0
	local hdrCur = self.List:ItemGetDataEx (sel, 1)

	local qIndex = bit.band (itemData, 0xff)
	local qId = bit.rshift (itemData, 16)

	local shift = IsShiftKeyDown() or eventName == "mid"

--	Nx.prt (format ("Data #%d, Id%d", qIndex, qId))

	if eventName == "select" or eventName == "mid" or eventName == "back" then

		local columnId = val2

		if shift then

			if hdrCur then		-- Header?

				local setStr

				for n = sel + 1, sel + 99 do		-- Toggle watch of all

					local itemData = self.List:ItemGetData (n)
					if not itemData or itemData == 0 then
						break
					end

					local qIndex = bit.band (itemData, 0xff)
					local qId = bit.rshift (itemData, 16)

					local i, cur, id = Quest:FindCur (qId, qIndex)

					if not setStr then

						local qStatus = Nx:GetQuest (id)
						setStr = qStatus == "W" and "c" or "W"
					end

					Nx:SetQuest (id, setStr)
				end

				Quest:PartyStartSend()

			else

				-- Track or paste to chat

				local i, cur, id = Quest:FindCur (qId, qIndex)

				local box = Nx:FindActiveChatFrameEditBox()
				if box then

					local s = self:MakeDescLink (cur, id or qId, IsControlKeyDown())
					if s then
						box:Insert (s)
					end

				else

					if cur then

						-- Shift click toggles quest-watch

						local qStatus = Nx:GetQuest (id)
						if qStatus == "W" then
							Nx:SetQuest (id, "c")
						else
							Nx:SetQuest (id, "W")
						end

						Quest:PartyStartSend()
					end
				end
			end
		end

		Nx.Quest:SelectBlizz (qIndex)

		self:Update()

		if qId > 0 then

			-- 0 is quest name line
			local qObj = bit.band (bit.rshift (itemData, 8), 0xff)

			local mapId = Map:GetCurrentMapId()
			Quest:TrackOnMap (qId, qObj, qIndex > 0, shift)
			Map:SetCurrentMap (mapId)

			-- LightHeaded select

			if self.TabSelected == 3 then
				local lh = getglobal ("LightHeaded")
				if lh then
					lh["UpdateFrame"] (lh, qId)
--					Nx.prt ("LH qid %s", qId)
				end
			end
		end

	elseif eventName == "button" then
		--任务日志面板

		if IsShiftKeyDown() and qId > 0 then
			Nx.Quest:LinkChat(qId)
		elseif (IsControlKeyDown() or click == "RightButton") and qId > 0 and GetQuestLogIndexByID(qId) > 0 then
			Nx_WorldMap_OpenToQuest(qId)
		elseif hdrCur then		-- Header?

			local v
			if not Quest.HeaderHide[hdrCur.Header] then
				v = true
			end
			Quest.HeaderHide[hdrCur.Header] = v

			self:Update()

		else
			-- 0 is quest name line
			local qObj = bit.band (bit.rshift (itemData, 8), 0xff)

			if self.TabSelected == 1 then

				self:ToggleWatch (qId, qIndex, qObj, shift)

			elseif self.TabSelected == 3 then

				local tbits = Quest.Tracking[qId] or 0

				if qObj == 0 then
					Quest.Tracking[qId] = bit.bxor (tbits, 1)
				else
					Quest.Tracking[qId] = bit.bxor (tbits, bit.lshift (1, qObj))
				end

				self:Update()
			end
		end

	elseif eventName == "menu" then

		if qIndex > 0 then

			Quest:SelectBlizz (qIndex)
			self:Update()
		end

		if self.TabSelected ~= 4 then

			self:UpdateMenu()
			self.Menu:Open()
		end
	end
end

function Nx.Quest.List:ToggleWatch (qId, qIndex, qObj, shift)

	local Quest = Nx.Quest
	local Map = Nx.Map

	if qObj == 0 and not shift then

		local i, cur, id = Quest:FindCur (qId, qIndex)
		if cur then

			local qStatus = Nx:GetQuest (id)
			if qStatus == "W" then

				Nx.Quest.Watch:RemoveWatch (qId, qIndex)
			else
				Nx:SetQuest (id, "W")
			end

			Quest:PartyStartSend()
		end
	else

		if qId > 0 and qObj > 0 then	-- FIX: Diabled qObj == 0 case

			if shift and qObj == 0 or qObj > 0 then

				local tbits = Quest.Tracking[qId] or 0

				if qObj == 0 then
					if bit.band (tbits, 1) > 0 then
						Quest.Tracking[qId] = nil
					else
						Quest.Tracking[qId] = 0xffffffff		-- Track all
					end
				else
					Quest.Tracking[qId] = bit.bxor (tbits, bit.lshift (1, qObj))
				end

				self:Update()
			end

			local mapId = Map:GetCurrentMapId()
			Quest:TrackOnMap (qId, qObj, qIndex > 0, true)
			Map:SetCurrentMap (mapId)
		end
	end

	self:Update()
end

--------
-- Make a quest link
-- (cur or id can be nil)

function Nx.Quest.List:MakeDescLink (cur, id, debug)

	local qId = cur and cur.QId or id	-- Database list will have nil cur

	local Quest = Nx.Quest
	local quest = cur and cur.Q or Quest.IdToQuest[qId]

	local title = cur and cur.Title
	local realLevel = cur and cur.RealLevel

	if quest then
		local s
		local _
		s, _, realLevel = Quest:Unpack (quest[1])
		title = title or s
	end

	local level = realLevel

	if not realLevel or realLevel <= 0 then
		level = UnitLevel ("player")
	end

	local s = Quest:CreateLink (qId, realLevel, title)

	-- Needs a leading space according to Blizzard. White color breaks link

	local opts = Nx:GetGlobalOpts()
	if quest and opts["QShowLinkExtra"] then
		local part = Quest:GetPartTitle (quest, cur)
		local Ind = GetQuestLogIndexByID(qId)
		if Ind and Ind > 0 then
			level = select(2, Quest:GetLogIdLevel(Ind))
		end
		s = format (" [%s] %s%s", level, s, part)
	else
		s = format (" %s", s)
	end

	if debug then
		local fac = strsub (UnitFactionGroup ("player"), 1, 1)
		s = format ("%s[%s %d]", s, fac, qId)
	end

--	Nx.prt ("quest %s", gsub (s, "|", "^"))

	return s
end

--------
-- On quest updates

function Nx.Quest.List:OnQuestUpdate (event, ...)

--	Nx.prt ("OnQuestUpdate %s", event)

	local Quest = Nx.Quest
	local opts = Nx:GetGlobalOpts()

	if event == "PLAYER_LOGIN" then

		self.LoggingIn = true

	elseif event == "QUEST_PROGRESS" then

		local auto = opts["QAutoTurnIn"]

		if IsShiftKeyDown() and IsControlKeyDown() then
			auto = not auto
		end

		if auto then
			CompleteQuest()
--			Nx.prt ("Auto turn in")
		end

		return

	elseif event == "QUEST_COMPLETE" then

		local auto = opts["QAutoTurnIn"]

		if IsShiftKeyDown() and IsControlKeyDown() then
			auto = not auto
		end

		if auto then
			if GetNumQuestChoices() == 0 then
				QuestRewardCompleteButton_OnClick()
--				Nx.prt ("Auto turn in choice")
			end
		end

		return

	elseif event == "QUEST_DETAIL" then		-- Happens when auto accept quest is given

		if QuestGetAutoAccept() and QuestIsFromAreaTrigger() then

			Quest:RecordQuestAcceptOrFinish()

--			Quest.AcceptQId = GetQuestID()
			Nx.prt ("QUEST_DETAIL %s", GetQuestID())
		end

	elseif event == "QUEST_LOG_UPDATE" then

--		Nx.prtStack ("QUpdate")
--		Nx.prt ("#%d", GetNumQuestLogEntries())

		if self.LoggingIn then

			Quest:AccessAllQuests()
			Nx.Timer:Start ("QLogUpdate", .5, self, self.LogUpdate)	-- Small delay, so access works (0 does work)

		else

			self:LogUpdate()
		end

	elseif eve=="QUEST_ACCEPTED" then --warbaby add for multi accept
		local qIdx, qId = ...
		if opts["QWAddNew"] and not Quest.DailyPVPIds[qId] and not Quest.DailyIds[qId] and not Quest.DailyDungeonIds[qId] then
			local qStatus = Nx:GetQuest(qId)
			if not qStatus or qStatus ~= "W" then
				Nx:SetQuest(qId, "W")
				Quest:PSS()
			end
		end
	end

--	Nx.prt ("OnQuestUpdate %s Done", event)
end

--------
-- Quest Log update

function Nx.Quest.List:LogUpdate()

--	Nx.prtStack ("QUpdate")
--	Nx.prt ("#%d", GetNumQuestLogEntries())

	local Quest = Nx.Quest
	local opts = Nx:GetGlobalOpts()

	local qn

	Quest:ExpandQuests()

	if not self.LoggingIn then

		qn = Quest:FindNewQuest()
		if not qn then
--			Quest:CheckForNewCompleted()
			Quest:TellPartyOfChanges()
		end
	end

	Quest:RecordQuests()

	if self.LoggingIn then
		Nx.Timer:Start ("QWatchLogin", .7, Quest, Quest.WatchAtLogin)
		Nx.Timer:Start ("QSetPDLogin", 2, Quest, Quest.CurQSetPreviousDone)
		if opts["QHCheckCompleted"]  then
			Nx.Timer:Start ("QHistLogin", 60, Quest, Quest.GetHistoryTimer)
		end
	end

	if qn then

		local curi, cur = Quest:FindCurByIndex (qn)

		Quest.QIdsNew[cur.QId] = time()

		if opts["QWAddNew"] and not Quest.DailyPVPIds[cur.QId] then
			Quest.Watch:Add (curi)
		end

		Quest:Capture (curi)

--		Nx.prt ("OnQuestUpdate Watch %d %d", qn, i)
	end

	Quest:RestoreExpandQuests()

	self.LoggingIn = nil

	Quest.Watch:ClearCompleted()

	self:Update()
end

--------
-- Update list security stub

function Nx.Quest.List:Update()
--	Nx.Quest.List:Update_()
end

--------
-- Update list

--warbaby quest database
function Nx.Quest.List:Update_()

	if not self.Win:IsShown() then
		return
	end

--	Nx.prt ("QuestListUpdate")

	local Nx = Nx
	local Quest = Nx.Quest
	local Map = Nx.Map
	local qLocColors = Quest.QLocColors

	local opts = Nx:GetGlobalOpts()
	local showQId = opts["QShowId"]

	-- Title

	local _, i = GetNumQuestLogEntries()

	local dailyStr = ""
	local dailysDone = GetDailyQuestsCompleted()
    if opts["QShowDailyCount"] then
	  if dailysDone > 0 then
		dailyStr = L["Daily Quests Completed: |cffffffff"] .. dailysDone
	  end
    end
	if opts["QShowDailyReset"] then
		dailyStr = dailyStr .. L["|r  Daily reset: |cffffffff"] .. Nx.Util_GetTimeElapsedStr (GetQuestResetTime())
	end

	self.Win:SetTitle (format (L["Quests: |cffffffff%d/%d|r  %s"], i, MAX_QUESTS, dailyStr))

	-- List

	local list = self.List
	list:Empty()

	if self.TabSelected == 1 then

		local oldSel = GetQuestLogSelection()

		local header
		local curq = Quest.CurQ

		for n = 1, curq and #curq or 0 do

			local cur = curq[n]
			local quest = cur.Q
			local qId = cur.QId

			local title, level, tag, isComplete = cur.Title, cur.Level, cur.Tag, cur.Complete
			local qn = cur.QI

			if qn > 0 then
				SelectQuestLogEntry (qn)
			end

			local onQ = 0
			local onQStr = ""

			if qn > 0 then
				for n = 1, 4 do
					if IsUnitOnQuest (qn, "party"..n) then
						if onQ > 0 then
							onQStr = onQStr .. "," .. UnitName ("party" .. n)
						else
							onQStr = onQStr .. UnitName ("party" .. n)
						end
						onQ = onQ + 1
					end
				end
			end

			if not self.ShowParty or onQ > 0 then

				local lvlStr = "  "
				if level > 0 then
					lvlStr = format ("|cffd0d0d0%2d", level)
				end

				local color = Quest:GetDifficultyColor (level)
				color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

				local nameStr = format ("%s %s%s", lvlStr, color, title)

				if quest and quest.CNum then
					nameStr = nameStr .. format (L[" (Part %d of %d)"], quest.CNum, cur.CNumMax)
				end

				if onQ > 0 then
					nameStr = format ("(%d) %s (%s)", onQ, nameStr, onQStr)
				end

				if isComplete then
					nameStr = nameStr .. (isComplete == 1 and L["|cff80ff80 - Complete"] or "|cfff04040 - "..FAILED)
				end

				if tag and cur.GCnt > 0 then
					tag = tag .. " " .. cur.GCnt
				end

				if cur.Daily then

					if tag then
						tag = format (DAILY_QUEST_TAG_TEMPLATE, tag)
					else
						tag = DAILY
					end
				end

				local show = true

				if self.Filters[self.TabSelected] ~= "" then

					local str = strlower (format ("%s %s", nameStr, tag or ""))
					local filtStr = strlower (self.Filters[self.TabSelected])

					show = strfind (str, filtStr, 1, true)
				end

				if self.QOpts.NXShowHeaders and cur.Header ~= header then
					header = cur.Header
					if show then
						list:ItemAdd (0)
						list:ItemSet (2, format ("|cff8f8fff---- %s ----", header))
						list:ItemSetDataEx (list:ItemGetNum(), cur, 1)
						list:ItemSetButton ("QuestHdr", Quest.HeaderHide[cur.Header])
					end
				end

				if show and not Quest.HeaderHide[cur.Header] then

					local id = qId > 0 and qId or cur.Title
					local qStatus = Nx:GetQuest (id)
					local qWatched = qStatus == "W"

					list:ItemAdd (qId * 0x10000 + qn)

					local trackMode = Quest.Tracking[qId] or 0

					local butType = "QuestWatch"
					local butOn

					local trkStr = " "
					if bit.band (trackMode, 1) > 0 then
						trkStr = "*"
						butOn = true
					end

					if qWatched then
						butType = "QuestWatching"
						butOn = true
					end

					list:ItemSetButton (butType, butOn)

					if quest and showQId then
						nameStr = nameStr .. format (" [%s]", qId)
					end

					if cur.HighPri then
						nameStr = "> " .. nameStr
					end

					list:ItemSet (2, nameStr)
					list:ItemSet (4, tag)

					if self.QOpts.NXShowObj then

						local num = GetNumQuestLeaderBoards (qn)

						local str = ""
						local desc, typ, done
						local zone, loc

						for ln = 1, 15 do

							zone = nil

							local obj = quest and quest[ln + 3]

							if obj then
								desc, zone, loc = Quest:UnpackObjective (obj)
							end							
							if ln <= num then
								desc, typ, done = GetQuestLogLeaderBoard (ln, qn)
								desc = desc or "?"	--V4

							else
								if not obj then
									break
								end

								done = false
							end

							color = done and "|cff5f5f6f" or "|cff9f9faf"
							str = format ("     %s%s", color, desc)

							list:ItemAdd (qId * 0x10000 + ln * 0x100 + qn)

							local trkStr = ""

							if zone then
--								trkStr = "|cff505050o"
								list:ItemSetButton ("QuestWatch", false)
							end

							if bit.band (trackMode, bit.lshift (1, ln)) > 0 then
								list:ItemSetButton (qLocColors[ln][5], true)
							end
							list:ItemSet (1, trkStr)

							list:ItemSet (2, str)
						end
					end
				end
			end
		end

		SelectQuestLogEntry (oldSel)

	end

	-- Add history quests

	if Nx.Quests and self.TabSelected == 2 then

		local qIds = Quest.QIds

		local sortT = {}

		local showAllZones = self.ShowAllZones or self.ShowAllQuests
		local showLowLevel = self.ShowLowLevel or self.ShowAllQuests
		local showHighLevel = self.ShowHighLevel or self.ShowAllQuests
		local showFinished = self.ShowFinished or self.ShowAllQuests
		local showOnlyDailies = self.ShowOnlyDailies and not self.ShowAllQuests

		local mapId = Map:GetCurrentMapId()

		local minLevel = UnitLevel ("player") - GetQuestGreenRange()
		local maxLevel = showHighLevel and MAX_PLAYER_LEVEL or UnitLevel ("player") + 6

		-- Divider

		list:ItemAdd (0)
		list:ItemAdd (0)
		local dbTitleIndex = list:ItemGetNum()
		local dbTitleNum = 0
		list:ItemAdd (0)

		for qId in pairs (Nx.CurCharacter.Q) do			-- Loop over quests with history

--			if not Quest.IdToQuest[qId] then
--				Nx.prt ("QID %s?", qId)
--			end

			local quest = Quest.IdToQuest[qId]

			local status, qTime = Nx:GetQuest (qId)
			local qCompleted = status == "C"

			local show = qCompleted

			if show and not showAllZones then
				show = Quest:CheckShow (mapId, qId)
			end

			if show then

				local qname, side_, lvl

				if quest then
					qname, side_, lvl = Quest:Unpack (quest[1])
				else
					qname = format ("%s?", qId)
					lvl = 0
				end

--				Nx.prt ("%s [%s] %s", qname, qId, quest.CNum or "")

				local lvlStr = format ("|cffd0d0d0%2d", lvl)
				local title = qname

				if quest and quest.CNum then
					title = title .. format (L[" (Part %d)"], quest.CNum)
				end

				if showQId then
					title = title .. format (" [%s]", qId)
				end

				local dailyName = ""

				local dailyStr = Quest.DailyIds[qId] or Quest.DailyDungeonIds[qId] or Quest.DailyPVPIds[qId]
				if dailyStr then

					local typ = strsplit ("^", dailyStr)
					dailyName = format (" |cffd060d0(%s)", Quest.DailyTypes[typ])

					local age = time() - qTime
					local dayChange = 86400 - GetQuestResetTime()

					if age < dayChange then
						dailyName = dailyName .. L[" |cffff8080today"]
					end
				end

				local show = true

				if self.Filters[self.TabSelected] ~= "" then

					local str = strlower (format ("%2d %s %s%s", lvl, title, date ("%m/%d %H:%M:%S", qTime), dailyName))
					local filtStr = strlower (self.Filters[self.TabSelected])

					show = strfind (str, filtStr, 1, true)
				end

				if show then

					local t = {}
					tinsert (sortT, t)

					t.T = qTime
					t.QId = qId

					dbTitleNum = dbTitleNum + 1

					local haveStr = ""

					if qIds[qId] then
						haveStr = "|cffe0e0e0+ "
					end

					local color = Quest:GetDifficultyColor (lvl)
					color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

					t.Desc = format ("%s %s%s%s", lvlStr, haveStr, color, title)
					t.Col4 = format ("%s %s", date ("|cff9f9fcf%m/%d %H:%M:%S", qTime), dailyName)
				end
			end
		end

		sort (sortT, function (a, b) return a.T > b.T end)

		for _, qEntry in ipairs (sortT) do

			list:ItemAdd (qEntry.QId * 0x10000)
			list:ItemSet (2, qEntry.Desc)
			list:ItemSet (4, qEntry.Col4)
		end

		local str = (showAllZones and L["All"] or Map:IdToName (mapId)) .. L[" Completed"]

		list:ItemSet (2, format ("|cffc0c0c0--- %s (%d) ---", str, dbTitleNum), dbTitleIndex)
	end

	-- Add database quests

	if Nx.Quests and self.TabSelected == 3 then

		local qIds = Quest.QIds

		local sortT = {}

		local showAllZones = self.ShowAllZones or self.ShowAllQuests
		local showLowLevel = self.ShowLowLevel or self.ShowAllQuests
		local showHighLevel = self.ShowHighLevel or self.ShowAllQuests
		local showFinished = self.ShowFinished or self.ShowAllQuests
		local showOnlyDailies = self.ShowOnlyDailies and not self.ShowAllQuests

		local mapId = Map:GetCurrentMapId()

		local minLevel = UnitLevel ("player") - GetQuestGreenRange()
		local maxLevel = showHighLevel and 90 or UnitLevel ("player") + 6

		-- Divider

		list:ItemAdd (0)
		list:ItemAdd (0)
		local dbTitleIndex = list:ItemGetNum()
		local dbTitleNum = 0
		list:ItemAdd (0)

		local addBlank
		local inchain
		local showchain

--		local qsIndex = 1
--		local qsLast = #Quest.Sorted
--		while qsIndex <= qsLast do

		for qsIndex, qId in ipairs (Quest.Sorted) do

--			local qId = Quest.Sorted[qsIndex]

			local quest = Quest.IdToQuest[qId]
			if not quest then
				Nx.prt (L["nil quest %s"], qId)
			end
			local qname, side, lvl, minlvl, next = Quest:Unpack (quest[1])

			local status, qTime = Nx:GetQuest (qId)
			local qCompleted = status == "C"

			if not quest.CNum or quest.CNum == 1 then
				addBlank = true
			end

			local show = showchain

			if not inchain then

				show = true

				if quest.CLvlMax then
					inchain = true
				end

				if not showLowLevel then
					if quest.CLvlMax then
						show = show and quest.CLvlMax >= minLevel
					else
						show = show and ((lvl == 0) or (lvl >= minLevel))
					end
				end
				show = show and lvl <= maxLevel

				if show and not showAllZones then
					show = self:CheckShow (mapId, qsIndex)
				end

				showchain = show
			end

			if not Quest.DailyIds[qId] then
				if (not showFinished and qCompleted) or showOnlyDailies then
					show = false
				end
			end

			if show then

				local lvlStr = format ("|cffd0d0d0%2d", lvl)
				local title = qname

				local cati = Quest:UnpackCategory (quest[1])
				if cati > 0 then
					title = title .. " <" .. Nx.QuestCategory[cati] .. ">"
				end

				if quest.CNum then

--					if quest.CNum > 1 then
--						lvlStr = "    " .. lvlStr
--					end
					title = title .. format (L[" (Part %d)"], quest.CNum)
				end

				local tag = qCompleted and L["(History) "] or ""

				local dailyStr = Quest.DailyIds[qId] or Quest.DailyDungeonIds[qId]
				if dailyStr then
					local typ, money, rep, req = strsplit ("^", dailyStr)
					tag = format (L["|cffd060d0(%s %.2fg"], Quest.DailyTypes[typ], money / 100)
					for n = 0, 1 do	-- Only support 2 reps
						local i = n * 4 + 1
						local repChar = strsub (rep or "", i, i)
						if repChar == "" then
							break
						end
						tag = format ("%s, %s %s", tag, strsub (rep, i + 1, i + 3), Quest.Reputations[repChar])
					end
					if req and Quest.Requirements[req] then	-- 1 and 2 (Ally, Horde) not in table
						tag = tag .. L[", |cffe0c020Need "] .. Quest.Requirements[req]
					end
					tag = tag .. ")"
				end

				local filterName = ""

				local sMapName
				local sName, sMapId = Quest:UnpackSE (quest[2])
				if sMapId then
					sMapName = Map:IdToName (Map.NxzoneToMapId[sMapId])
					filterName = format ("%s(%s)", sName, sMapName)
				end

				local eMapName
				local eName, eMapId = Quest:UnpackSE (quest[3])
				if eMapId then
					eMapName = Map:IdToName (Map.NxzoneToMapId[eMapId])
					if sName ~= eName then
						filterName = format ("%s%s(%s)", filterName, eName, eMapName)
					end
				end

				local show = true

				if self.Filters[self.TabSelected] ~= "" then

					for n = 1, 15 do

						local obj = quest[n + 3]
						if not obj then
							break
						end

						local name, zone = Quest:UnpackObjective (obj)
						if zone then
							filterName = filterName .. Map:IdToName (Map.NxzoneToMapId[zone])
						end
					end

					local str = strlower (format ("%2d %s %s %s", lvl, title, filterName, tag))
					local filtStr = strlower (self.Filters[self.TabSelected])

					show = strfind (str, filtStr, 1, true)
				end

				if show then

					if addBlank then
						addBlank = false
						list:ItemAdd (0)
					end

					dbTitleNum = dbTitleNum + 1

					local trackMode = Quest.Tracking[qId] or 0

					list:ItemAdd (qId * 0x10000)

					local haveStr = ""

					if qIds[qId] then
						haveStr = "|cffe0e0e0+ "
					end

					local color = Quest:GetDifficultyColor (lvl)
					color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

					local str = format ("%s %s%s%s", lvlStr, haveStr, color, title)

					if showQId then
						str = str .. format (" [%s]", qId)
					end

					local questTip = "@" .. qId

					list:ItemSet (2, str)
					list:ItemSet (4, tag)

					if sName then
						list:ItemAdd (qId * 0x10000)

						if not eName then
							list:ItemSet (2, L["     |cff6060ffStart/End: "] .. sName)
						else
							list:ItemSet (2, L["     |cff6060ffStart: "] .. sName)
						end
						sMapName = _MapName(sMapName)
						list:ItemSet (4, sMapName)

						list:ItemSetButton ("QuestWatch", false)
						if bit.band (trackMode, 1) > 0 then
							list:ItemSetButton ("QuestWatch", true)
						end
						list:ItemSetButtonTip (questTip)
					end
					if eName then
						list:ItemAdd (qId * 0x10000 + 16 * 0x100)
						list:ItemSet (2, L["     |cff6060ffEnd: "] .. eName)
						eMapName = _MapName(eMapName)
						list:ItemSet (4, eMapName)

						list:ItemSetButton ("QuestWatch", false)
						if bit.band (trackMode, 0x10000) > 0 then
							list:ItemSetButton ("QuestWatch", true)
						end
						list:ItemSetButtonTip (questTip)
					end

					-- Objectives (max of 15)
					--warbaby quest objects, former is n=1,15
					for n = 1, ((sName or eName) and 0 or 15) do

						local obj = quest[n + 3]
						if not obj then
							break
						end

						list:ItemAdd (qId * 0x10000 + n * 0x100)

						local name, zone, loc = Quest:UnpackObjective (obj)

--						str = zone and "|cff505050o" or ""						
						if zone then
							list:ItemSetButton ("QuestWatch", false)
							list:ItemSetButtonTip (questTip)
							list:ItemSet (4, _MapName(Map:IdToName (Map.NxzoneToMapId[zone])))
						end

						if bit.band (trackMode, bit.lshift (1, n)) > 0 then
							list:ItemSetButton (qLocColors[n][5], true)
						end

--						list:ItemSet (1, str)
						list:ItemSet (2, format ("     |cff9f9faf%s", _Quest(name)))
					end
				end
			end

			if next == 0 then
				inchain = false
			end

--			qsindex = qsindex + 1
		end

		local str = (showAllZones and L["Full"] or Map:IdToName (mapId)) .. L[" Database"]

		list:ItemSet (2, format ("|cffc0c0c0--- %s (%d) ---", str, dbTitleNum), dbTitleIndex)

		local low = max (1, showLowLevel and 1 or minLevel)
		local high = min (MAX_PLAYER_LEVEL, maxLevel)
		list:ItemSet (2, format (L["|cffc0c0c0--- Levels %d to %d ---"], low, high), dbTitleIndex + 1)
	end

	-- Add other player quests

	if self.TabSelected == 4 then

		local qIds = Quest.QIds

		list:ItemAdd (0)
		list:ItemSet (2, format ("|cffc0c0c0--- %s %s/%s ---", Quest.RcvPlyrLast, Quest.RcvCnt, Quest.RcvTotal))

		for n = 1, #Quest.FriendQuests do

			local data = Quest.FriendQuests[n]
			local mode = strsub (data, 1, 1)

			list:ItemAdd (0)

			if mode == " " then		-- Simple text

				list:ItemSet (2, strsub (data, 3))

			elseif mode == "H" then

				list:ItemSet (2, format ("|cff8f8fff---- %s ----", strsub (data, 3)))

			elseif mode == "T" then

				local _, qId, watched, done, lvl, name = strsplit ("^", data)

				if qId and name then

					qId = tonumber (qId)

					if qId >= 0 then

--						watched = watched == "0" and "" or "*"

						if watched ~= "0" then
							list:ItemSet (1, "|cffcfcfcfw")
						end

						local haveStr = ""
						if qIds[qId] then
							haveStr = "|cffe0e0e0+ "
						end

						done = done == "0" and "" or L["|cff80ff80 - Complete"]

						list:ItemSet (2, format ("%s %s%s%s", lvl, haveStr, name, done))
					end
				end

			elseif mode == "O" then

				local _, qId, name = strsplit ("^", data)

				if name then

					local color = done and "|cff5f5f6f" or "|cff9f9faf"
					local str = format ("     %s%s", color, name)

					list:ItemSet (2, str)
				end
			end
		end
	end

	--

	list:Update()

	Quest.Watch:Update()

	if self.TabSelected == 1 then

		local i = list:GetSelected()
		local data = list:ItemGetData (i) or 0

--		Nx.prt ("%s %s", i, data)

		if data > 0 then
			Nx.Quest:SelectBlizz (bit.band (data, 0xff))
			NxQuestD:Show()
			Quest:UpdateQuestDetails()
		else
			NxQuestD:Hide()
		end
	end

end

function Nx.Quest.List:CheckShow (mapId, index)

	local NxzoneToMapId = Nx.Map.NxzoneToMapId
	local Quest = Nx.Quest

	while true do

		local qId = Quest.Sorted[index]

		if Quest:CheckShow (mapId, qId) then
			return true
		end

		local quest = Quest.IdToQuest[qId]
		local next = Quest:UnpackNext (quest[1])

		if next == 0 then		-- End?
			return
		end

		index = index + 1
	end
end

--------
-- Update map icons (called by map)

function Nx.Quest:UpdateIcons (map)

	Nx.Timer:ProfilerStart ("Quest UpdateIcons")

	local Nx = Nx
	local Quest = Nx.Quest
	local Map = Nx.Map
	local qLocColors = Quest.QLocColors
	local ptSz = 4 * map.ScaleDraw

	local navscale = Quest.Map.IconNavScale * 16
	local showOnMap = Quest.Watch.ButShowOnMap:GetPressed()

	local opts = self.GOpts
	local showWatchAreas = opts["QMapShowWatchAreas"]
	local trkR, trkG, trkB, trkA = Nx.Util_num2rgba (opts["QMapWatchAreaTrackColor"])
	local hovR, hovG, hovB, hovA = Nx.Util_num2rgba (opts["QMapWatchAreaHoverColor"])

	-- Update target

	local typ, tid = Map:GetTargetInfo()
	if typ == "Q" then

--		Nx.prt ("QTar %s", tid)

		local qid = floor (tid / 100)
		local i, cur = Quest:FindCur (qid)

		if cur then
			Quest:CalcDistances (cur.Index, cur.Index)
			Quest:TrackOnMap (cur.QId, tid % 100, cur.QI > 0 or cur.Party, true, true)

--			Nx.prt ("UpIcons target %s %s", typ or "nil", tid or "nil")
		end
	end

	-- Blob

--	local f = self.BlobFrm


	-- Draw completed quests

	for k, cur in ipairs (Quest.CurQ) do

		if cur.Q and cur.CompleteMerge then

			local q = cur.Q
			local obj = q[3] or q[2]

			local endName, zone, x, y = Quest:GetSEPos (obj)
			local mapId = Map.NxzoneToMapId[zone]

			if mapId then

				local wx, wy = map:GetWorldPos (mapId, x, y)
				local f = map:GetIconStatic (4)

				if map:ClipFrameW (f, wx, wy, navscale, navscale, 0) then

					f.NXType = 9000
					f.NXData = cur
					local qname = Nx.TXTBLUE .. L["Quest: "] .. cur.Title
					f.NxTip = format (L["%s\nEnd: %s (%.1f %.1f)"], qname, endName, x, y)
					if cur.PartyNames then
						f.NxTip = f.NxTip .. "\n" .. cur.PartyNames
					end
					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconQuestion")
				end
			end
		end
	end

	-- Update tracking data

	local tracking = self.IconTracking

	if map.Tick % 10 == 0 then --warbaby changed from Nx.Tick

--		tracking = {}		-- garbage creator
		wipe (tracking)

		for trackId, trackMode in pairs (Quest.Tracking) do
			tracking[trackId] = trackMode
		end

		if showOnMap then
			for k, cur in ipairs (Quest.CurQ) do
				if cur.Q and (Nx:GetQuest (cur.QId) == "W" or cur.PartyDesc) then
					tracking[cur.QId] = (tracking[cur.QId] or 0) + 0x10000		-- cur.TrackMask + i
				end
			end
		end

		self.IconTracking = tracking
	end

	-- Draw

	local areaTex = Nx.Opts.ChoicesQAreaTex[opts["QMapWatchAreaGfx"]]

	local colorPerQ = opts["QMapWatchColorPerQ"]
	local colMax = opts["QMapWatchColorCnt"]

	for trackId, trackMode in pairs (tracking) do

		local cur = Quest.IdToCurQ[trackId]
		local quest = cur and cur.Q or Quest.IdToQuest[trackId]
		local qname = Nx.TXTBLUE .. L["Quest: "] .. (cur and cur.Title or _Quest(Quest:UnpackName (quest[1])))

		local mask = showOnMap and cur and cur.TrackMask or trackMode
		local showEnd

		if bit.band (mask, 1) > 0 then

			if not (cur and (cur.QI > 0 or cur.Party)) then

				local startName, zone, x, y = Quest:GetSEPos (quest[2])
				local mapId = Map.NxzoneToMapId[zone]

				if mapId then

					local wx, wy = map:GetWorldPos (mapId, x, y)
					local f = map:GetIconStatic (4)

					if map:ClipFrameW (f, wx, wy, navscale, navscale, 0) then
						f.NxTip = format (L["%s\nStart: %s (%.1f %.1f)"], qname, startName, x, y)
						f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconExclaim")
					end
				end
			else

				showEnd = true
			end
		end

		if showEnd or bit.band (mask, 0x10000) > 0 then

			local obj = quest[3] or quest[2]

			local endName, zone, x, y = Quest:GetSEPos (obj)
			local mapId = Map.NxzoneToMapId[zone]

			if mapId and (not cur or not cur.CompleteMerge) then

				local wx, wy = map:GetWorldPos (mapId, x, y)
				local f = map:GetIconStatic (4)

				if map:ClipFrameW (f, wx, wy, navscale, navscale, 0) then

					f.NXType = 9000
					f.NXData = cur
					f.NxTip = format (L["%s\nEnd: %s (%.1f %.1f)"], qname, endName, x, y)
					if cur and cur.PartyNames then
						f.NxTip = f.NxTip .. "\n" .. cur.PartyNames
					end
					f.texture:SetVertexColor (.6, 1, .6, 1)
					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconQuestion")
--					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconQTarget")
				end
			end
		end

		-- Objectives (max of 15)

		if not cur or cur.QI > 0 or cur.Party then

			local drawArea

			if cur then
				local qStatus = Nx:GetQuest (cur.QId)
				drawArea = showWatchAreas and qStatus == "W"
			end
--			local drawArea = bit.band (trackMode, 0x10000) == 0

			for n = 1, 15 do

				local obj = quest[n + 3]
				if not obj then
					break
				end

				local objName, objZone, loc = Quest:UnpackObjective (obj)

				if objZone then

					local mapId = Map.NxzoneToMapId[objZone]

					if not mapId then
--						Nx.prt ("Nxzone error %s %s", objName, objZone)
						break
					end

--					Nx.prt ("%s zone %d %s", objName, mapId, loc)

					if loc and bit.band (mask, bit.lshift (1, n)) > 0 then

						local colI = n

						if colorPerQ then
							colI = ((cur and cur.Index or 1) - 1) % colMax + 1
						end

						local col = qLocColors[colI]
						local r = col[1]
						local g = col[2]
						local b = col[3]

						local oname = cur and cur[n] or objName

						if strbyte (obj, loc) == 32 then  -- Points

--							Nx.prt ("%s, pt %s", objName, strsub (obj, loc + 1))

							loc = loc + 1

							local cnt = floor ((#obj - loc + 1) / 4)
							local sz = navscale

							if cnt > 1 then
								sz = map:GetWorldZoneScale (mapId) / 10.02 * ptSz
							end

							for locN = loc, loc + cnt * 4 - 1, 4 do

								local x, y = Quest:UnpackLocPtOff (obj, locN)
								local wx, wy = map:GetWorldPos (mapId, x, y)

								local f = map:GetIconStatic (4)

								if map:ClipFrameW (f, wx, wy, sz, sz, 0) then

									f.NXType = 9000 + n
									f.NXData = cur

									f.NxTip = format (L["%s\nObj: %s (%.1f %.1f)"], qname, oname, x, y)
									if cur and cur[n + 400] then
										f.NxTip = f.NxTip .. "\n" .. cur[n + 400]
									end

									if cnt == 1 then
										f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconQTarget")
										f.texture:SetVertexColor (r, g, b, .9)
									else
										f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconCirclePlus")
										f.texture:SetVertexColor (r, g, b, .5)
									end
								end
							end

						else -- Spans (areas)

--							Nx.prt ("%s, spans %s", objName, strsub (obj, loc))

							local hover = Quest.IconHoverCur == cur and Quest.IconHoverObjI == n
							local tracking = bit.band (trackMode, bit.lshift (1, n)) > 0

							local tip = format (L["%s\nObj: %s"], qname, oname)
							if cur and cur[n + 400] then
								tip = tip .. "\n" .. cur[n + 400]
							end

							local x

							if cur then
								local d = cur["OD"..n]
								if d and d > 0 then
									x = cur["OX"..n]
								end
							end

							if x then
								local y = cur["OY"..n]
								local f = map:GetIcon (4)
								local sz = navscale

								if not hover then
									sz = sz * .8
								end

								if map:ClipFrameW (f, x, y, sz, sz, 0) then

									f.NXType = 9000 + n
									f.NXData = cur
									f.NxTip = tip

									f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconAreaArrows")

									if tracking then
										f.texture:SetVertexColor (.8, .8, .8, 1)
									else
										f.texture:SetVertexColor (r, g, b, .7)
									end
								end
							end

							if not cur or drawArea or hover
									or (bit.band (trackMode, bit.lshift (1, n)) > 0 and trkA > .05) then

								local scale = map:GetWorldZoneScale (mapId) / 10.02
								local cnt = floor ((#obj - loc + 1) / 4)
								local ssub = strsub

								for locN = loc, loc + cnt * 4 - 1, 4 do

									local loc1 = ssub (obj, locN, locN + 3)
									if loc1 == "" then
										break
									end

									local x, y, w, h = Quest:UnpackLocRect (loc1)									
									local wx, wy = map:GetWorldPos (mapId, x, y)

									local f = map:GetIconStatic (hover and 1)

									if areaTex then

										if map:ClipFrameTL (f, wx, wy, w * scale, h * scale) then

											f.NXType = 9000 + n
											f.NXData = cur
											f.NxTip = tip

											f.texture:SetTexture (areaTex)

											if hover then
												f.texture:SetVertexColor (hovR, hovG, hovB, hovA)
											elseif tracking then
												f.texture:SetVertexColor (trkR, trkG, trkB, trkA)
											else
												f.texture:SetVertexColor (r, g, b, col[4])
											end
										end

									else

										if map:ClipFrameTLSolid (f, wx, wy, w * scale, h * scale) then

											f.NXType = 9000 + n
											f.NXData = cur
											f.NxTip = tip

											if hover then
												f.texture:SetTexture (hovR, hovG, hovB, hovA)
											elseif tracking then
												f.texture:SetTexture (trkR, trkG, trkB, trkA)
											else
												f.texture:SetTexture (r, g, b, col[4])
											end
										end

									end
								end
							end
						end
					end
				end
			end
		end
	end

	Nx.Timer:ProfilerEnd ("Quest UpdateIcons")
end

function Nx.Quest:IconOnEnter (frm)

	local i = frm.NXType - 9000
	local cur = frm.NXData

	self.IconHoverCur = cur
	self.IconHoverObjI = i
end

function Nx.Quest:IconOnLeave (frm)

	self.IconHoverCur = nil
end

function Nx.Quest:IconOnMouseDown (frm)

	local cur = self.IconHoverCur
	if cur then

		self.IconMenuCur = cur
		self.IconMenuObjI = self.IconHoverObjI

		local qStatus = Nx:GetQuest (cur.QId)
		self.IconMenuIWatch:SetChecked (qStatus == "W")

		self.IconMenu:Open()
	end
end

--------
-- Called when details frame size changes

function Nx.Quest.List:OnDetailsSetSize (w, h)

--	Nx.prt ("QDetails %d %d", w, h)

	local scale = Nx:GetGlobalOpts()["QDetailScale"]

	NXQuestLogDetailScrollChildFrame:SetScale (scale)

	local upH = NxQuestDScrollBarScrollUpButton:GetHeight()

	local bar = NxQuestDScrollBar
	local barW = bar:GetWidth()

	local details = NxQuestD
	bar:SetPoint ("TOPLEFT", details, "TOPRIGHT", 1, -upH)
	details:SetWidth (w - barW - 1)

	local dw = (w - barW - 8) / scale

	Nx.Quest.List:DetailsSetWidth (dw)
end

function Nx.Quest.List:DetailsSetWidth (w)

--	NXQuestLogDetailScrollChildFrame:SetWidth (w)
--	QuestInfoFrame:SetWidth (w)
	QuestInfoObjectivesText:SetWidth (w)
	QuestInfoDescriptionText:SetWidth (w)
	QuestInfoItemChooseText:SetWidth (w)
--	QuestInfoRewardText:SetWidth (w)
end

--------
-- Details

function Nx.Quest:UpdateQuestDetails()

	-- 1 tick delay, since Blizz is hiding/resetting on log open
	Nx.Timer:Start ("QDetail", 0, self, self.UpdateQuestDetailsTimer)
end

function Nx.Quest:UpdateQuestDetailsTimer()

--	Nx.prt ("UpdateQuestDetails")

	QuestInfo_Display (QUEST_TEMPLATE_LOG, NXQuestLogDetailScrollChildFrame, nil, nil, "Carb")

	local r, g, b, a = Nx.Util_num2rgba (self.GOpts["QDetailBC"])
	self.List.DetailsFrm.texture:SetTexture (r, g, b, a)

	-- 0.18, 0.12, 0.06 parchment
	local r, g, b = Nx.Util_num2rgba (self.GOpts["QDetailTC"])

	local t = {
			"QuestInfoTitleHeader", "QuestInfoDescriptionHeader", "QuestInfoObjectivesHeader", "QuestInfoRewardsHeader",
			"QuestInfoDescriptionText", "QuestInfoObjectivesText", "QuestInfoGroupSize", "QuestInfoRewardText",
			"QuestInfoItemChooseText", "QuestInfoItemReceiveText", "QuestInfoSpellLearnText",
--V4 fix!!!!!!!!!!!! replace???
--			"QuestInfoHonorFrameReceiveText",
--			"QuestInfoArenaPointsFrameReceiveText",
--			"QuestInfoTalentFrameReceiveText",
			"QuestInfoXPFrameReceiveText",
	}

	for k, name in ipairs (t) do
		if not _G[name] then
			Nx.prt ("QDetails missing %s", name)
		end
		_G[name]:SetTextColor (r, g, b)
	end

	for n = 1, 10 do
		_G["QuestInfoObjective" .. n]:SetTextColor (r, g, b)
	end

--[[
	-- 3.2

	QuestFrame_SetAsLastShown (NxQuestDSC, NxQuestDSCSpacerFrame)

	Nx.Quest:FrameItems_Update()

	local questID = GetQuestLogSelection()
	local questTitle = GetQuestLogTitle (questID) or ""

	if IsCurrentQuestFailed() then
		questTitle = questTitle.." - ("..FAILED..")"
	end

--	Nx.prt ("UpdateQuestDetails %s %s", questID or "nil", questTitle or "nil")

	local title = NxQuestDSCQuestTitle
	title:SetText (questTitle)

	local _, relTo = NxQuestDSCSpacerFrame:GetPoint()
	local corner = relTo == NxQuestDSC and "TOP" or "BOTTOM"
	title:ClearAllPoints()
	title:SetPoint ("TOP", relTo, corner, 0, -10)
	title:SetPoint ("LEFT", NxQuestDSC, "LEFT", 0, 0)

	local questDescription, questObjectives = GetQuestLogQuestText()
	NxQuestDSCObjectivesText:SetText (questObjectives)

	local questTimer = GetQuestLogTimeLeft()
	if questTimer then
--		QuestLogFrame.hasTimer = 1
--		QuestLogFrame.timePassed = 0
		NxQuestDSCTimerText:Show()
		NxQuestDSCTimerText:SetText (TIME_REMAINING.." "..SecondsToTime (questTimer))
		NxQuestDSCObjective1:SetPoint ("TOPLEFT", "NxQuestDSCTimerText", "BOTTOMLEFT", 0, -10)
	else
--		QuestLogFrame.hasTimer = nil
		NxQuestDSCTimerText:Hide()
		NxQuestDSCObjective1:SetPoint ("TOPLEFT", "NxQuestDSCObjectivesText", "BOTTOMLEFT", 0, -10)
	end
	
	-- Show Quest Watch if track quest is checked
	local numObjectives = GetNumQuestLeaderBoards()

	for i = 1, numObjectives do
		local string = getglobal ("NxQuestDSCObjective"..i)
		local text, typ, finished = GetQuestLogLeaderBoard (i)
		if not text or strlen (text) == 0 then
			text = typ
		end
		if finished then
			string:SetTextColor (.2, .2, .2)
			text = text.." ("..COMPLETE..")"
		else
			string:SetTextColor (0, 0, 0)
		end
		string:SetText(text)
		string:Show()
		QuestFrame_SetAsLastShown (string, NxQuestDSCSpacerFrame)
	end

	for i = numObjectives + 1, MAX_OBJECTIVES, 1 do
		getglobal ("NxQuestDSCObjective"..i):Hide()
	end

	-- If there's money required then anchor and display it

	if GetQuestLogRequiredMoney() > 0 then

		if numObjectives > 0 then
			NxQuestDSCRequiredMoneyText:SetPoint("TOPLEFT", "NxQuestDSCObjective"..numObjectives, "BOTTOMLEFT", 0, -4)
		else
			NxQuestDSCRequiredMoneyText:SetPoint("TOPLEFT", "NxQuestDSCObjectivesText", "BOTTOMLEFT", 0, -10)
		end
		
		MoneyFrame_Update("NxQuestDSCRequiredMoneyFrame", GetQuestLogRequiredMoney())
		
		if GetQuestLogRequiredMoney() > GetMoney() then
			-- Not enough cash
			NxQuestDSCRequiredMoneyText:SetTextColor (0, 0, 0)
			SetMoneyFrameColor ("NxQuestDSCRequiredMoneyFrame", 1, .1, .1)
		else
			NxQuestDSCRequiredMoneyText:SetTextColor (.2, .2, .2)
			SetMoneyFrameColor ("NxQuestDSCRequiredMoneyFrame", 1, 1, 1)
		end
		NxQuestDSCRequiredMoneyText:Show()
		NxQuestDSCRequiredMoneyFrame:Show()
	else
		NxQuestDSCRequiredMoneyText:Hide()
		NxQuestDSCRequiredMoneyFrame:Hide()
	end

	if GetQuestLogGroupNum() > 0 then

		local suggestedGroupString = format (QUEST_SUGGESTED_GROUP_NUM, GetQuestLogGroupNum())
		NxQuestDSCSuggestedGroupNum:SetText (suggestedGroupString)
		NxQuestDSCSuggestedGroupNum:Show()
		NxQuestDSCSuggestedGroupNum:ClearAllPoints()

		if GetQuestLogRequiredMoney() > 0 then
			NxQuestDSCSuggestedGroupNum:SetPoint ("TOPLEFT", "NxQuestDSCRequiredMoneyText", "BOTTOMLEFT", 0, -4)
		elseif numObjectives > 0 then
			NxQuestDSCSuggestedGroupNum:SetPoint ("TOPLEFT", "NxQuestDSCObjective"..numObjectives, "BOTTOMLEFT", 0, -4)
		elseif questTimer then
			NxQuestDSCSuggestedGroupNum:SetPoint ("TOPLEFT", "NxQuestDSCTimerText", "BOTTOMLEFT", 0, -10)
		else
			NxQuestDSCSuggestedGroupNum:SetPoint ("TOPLEFT", "NxQuestDSCObjectivesText", "BOTTOMLEFT", 0, -10)
		end
	else
		NxQuestDSCSuggestedGroupNum:Hide()
	end

	if GetQuestLogGroupNum() > 0 then
		NxQuestDSCDescriptionTitle:SetPoint("TOPLEFT", "NxQuestDSCSuggestedGroupNum", "BOTTOMLEFT", 0, -10)

	elseif GetQuestLogRequiredMoney() > 0 then
		NxQuestDSCDescriptionTitle:SetPoint("TOPLEFT", "NxQuestDSCRequiredMoneyText", "BOTTOMLEFT", 0, -10)

	elseif numObjectives > 0 then
		NxQuestDSCDescriptionTitle:SetPoint("TOPLEFT", "NxQuestDSCObjective"..numObjectives, "BOTTOMLEFT", 0, -10)

	else
		if questTimer then
			NxQuestDSCDescriptionTitle:SetPoint ("TOPLEFT", "NxQuestDSCTimerText", "BOTTOMLEFT", 0, -10)
		else
			NxQuestDSCDescriptionTitle:SetPoint ("TOPLEFT", "NxQuestDSCObjectivesText", "BOTTOMLEFT", 0, -10)
		end
	end

	if questDescription then
		NxQuestDSCQuestDescription:SetText (questDescription)
		QuestFrame_SetAsLastShown (NxQuestDSCQuestDescription, NxQuestDSCSpacerFrame)
	end

	local numRewards = GetNumQuestLogRewards()
	local numChoices = GetNumQuestLogChoices()
	local money = GetQuestLogRewardMoney()

	if numRewards + numChoices + money > 0 then
		NxQuestDSCRewardTitleText:Show()
--		QuestFrame_SetAsLastShown (NxQuestDSCRewardTitleText, NxQuestDSCSpacerFrame)

	else
		NxQuestDSCRewardTitleText:Hide()
	end

	NxQuestDScrollBar:SetValue (0)
	NxQuestD:UpdateScrollChildRect()

--]]

end

--------
--

function Nx.Quest:FrameItems_Update (questState)

	NxQuestDSCRewardTitleText:SetPoint ("TOPLEFT", "NxQuestDSC", "TOPLEFT", 0, -10)

	local questState = "NxQuestDSC"
	local questItemName = "NxQuestDSCItem"

	local numQuestRewards
	local numQuestChoices
	local money = GetQuestLogRewardMoney()
	local spacerFrame = NxQuestDSCSpacerFrame

	numQuestRewards = GetNumQuestLogRewards()
	numQuestChoices = GetNumQuestLogChoices()

	local numQuestSpellRewards = 0
	if GetQuestLogRewardSpell() then
		numQuestSpellRewards = 1
	end

	local totalRewards = numQuestRewards + numQuestChoices + numQuestSpellRewards
	local material = QuestFrame_GetMaterial()
	local questItemReceiveText = getglobal (questState.."ItemReceiveText")

	if totalRewards == 0 and money == 0 then
		getglobal (questState.."RewardTitleText"):Hide()
	else
		getglobal (questState.."RewardTitleText"):Show()
		QuestFrame_SetTitleTextColor (getglobal (questState.."RewardTitleText"), material)
		QuestFrame_SetAsLastShown (getglobal (questState.."RewardTitleText"), spacerFrame)
	end

	if money == 0 then
		getglobal (questState.."MoneyFrame"):Hide()
	else
		getglobal (questState.."MoneyFrame"):Show()
		QuestFrame_SetAsLastShown (getglobal(questState.."MoneyFrame"), spacerFrame)
		MoneyFrame_Update (questState.."MoneyFrame", money)
	end
	
	-- Hide unused rewards

	for n = totalRewards + 1, MAX_NUM_ITEMS do
		getglobal (questItemName..n):Hide()
	end

	local questItem, name, texture, isTradeskillSpell, isSpellLearned, quality, isUsable, numItems = 1
	local rewardsCount = 0
	
	-- Setup choosable rewards

	if numQuestChoices > 0 then

		local itemChooseText = getglobal (questState.."ItemChooseText")
		itemChooseText:Show()
		QuestFrame_SetTextColor (itemChooseText, material)
		QuestFrame_SetAsLastShown (itemChooseText, spacerFrame)
		
		local index
		local baseIndex = rewardsCount

		for i = 1, numQuestChoices do

			index = i + baseIndex
			questItem = getglobal (questItemName..index)
			questItem.type = "choice"
			numItems = 1

			name, texture, numItems, quality, isUsable = GetQuestLogChoiceInfo (i)

			questItem:SetID (i)
			questItem:Show()

			-- For the tooltip
			questItem.rewardType = "item"

			getglobal (questItemName..index.."Name"):SetText(name)
			SetItemButtonCount (questItem, numItems)
			SetItemButtonTexture (questItem, texture)

			if isUsable then
				SetItemButtonTextureVertexColor (questItem, 1.0, 1.0, 1.0)
				SetItemButtonNameFrameVertexColor (questItem, 1.0, 1.0, 1.0)
			else
				SetItemButtonTextureVertexColor (questItem, 0.9, 0, 0)
				SetItemButtonNameFrameVertexColor (questItem, 0.9, 0, 0)
			end

			if i > 1 then

				if mod (i, 2) == 1 then
					questItem:SetPoint ("TOPLEFT", questItemName..(index - 2), "BOTTOMLEFT", 0, -2)
					QuestFrame_SetAsLastShown (questItem, spacerFrame)

				else
					questItem:SetPoint ("TOPLEFT", questItemName..(index - 1), "TOPRIGHT", 1, 0)
				end

			else
				questItem:SetPoint ("TOPLEFT", itemChooseText, "BOTTOMLEFT", 0, -5)
				QuestFrame_SetAsLastShown (questItem, spacerFrame)
			end

			rewardsCount = rewardsCount + 1
		end
	else
		getglobal (questState.."ItemChooseText"):Hide()
	end
	
	-- Setup spell rewards

	local learnSpellText = getglobal (questState.."SpellLearnText")

	if numQuestSpellRewards > 0 then

		learnSpellText:Show()
		QuestFrame_SetTextColor (learnSpellText, material)
		QuestFrame_SetAsLastShown (learnSpellText, spacerFrame)

		--Anchor learnSpellText if there were choosable rewards
		if rewardsCount > 0 then
			learnSpellText:SetPoint("TOPLEFT", questItemName..rewardsCount, "BOTTOMLEFT", 3, -5)
		else
			learnSpellText:SetPoint("TOPLEFT", questState.."RewardTitleText", "BOTTOMLEFT", 0, -5)
		end

		texture, name, isTradeskillSpell, isSpellLearned = GetQuestLogRewardSpell()
		
		if isTradeskillSpell then
			learnSpellText:SetText (REWARD_TRADESKILL_SPELL)
		elseif not isSpellLearned then
			learnSpellText:SetText (REWARD_AURA)
		else
			learnSpellText:SetText (REWARD_SPELL)
		end

		rewardsCount = rewardsCount + 1

		questItem = getglobal (questItemName..rewardsCount)
		questItem:Show()
		-- For the tooltip
		questItem.rewardType = "spell"
		SetItemButtonCount (questItem, 0)
		SetItemButtonTexture (questItem, texture)
		getglobal (questItemName..rewardsCount.."Name"):SetText(name)

		QuestFrame_SetAsLastShown (questItem, spacerFrame)

		questItem:SetPoint ("TOPLEFT", learnSpellText, "BOTTOMLEFT", 0, -5)
	else
		learnSpellText:Hide()
	end
	
	-- Setup mandatory rewards
	if numQuestRewards > 0 or money > 0 then

		QuestFrame_SetTextColor (questItemReceiveText, material)

		-- Anchor the reward text differently if there are choosable rewards
		if numQuestSpellRewards > 0 then
			questItemReceiveText:SetText (REWARD_ITEMS)
			questItemReceiveText:SetPoint ("TOPLEFT", questItemName..rewardsCount, "BOTTOMLEFT", 3, -5)

		elseif numQuestChoices > 0 then
			questItemReceiveText:SetText (REWARD_ITEMS)
			local index = numQuestChoices
			if mod (index, 2) == 0 then
				index = index - 1
			end
			questItemReceiveText:SetPoint ("TOPLEFT", questItemName..index, "BOTTOMLEFT", 3, -5)

		else 
			questItemReceiveText:SetText (REWARD_ITEMS_ONLY)
			questItemReceiveText:SetPoint ("TOPLEFT", questState.."RewardTitleText", "BOTTOMLEFT", 3, -5)
		end

		questItemReceiveText:Show()
		QuestFrame_SetAsLastShown (questItemReceiveText, spacerFrame)

		-- Setup mandatory rewards
		local index
		local baseIndex = rewardsCount

		for i = 1, numQuestRewards do

			index = i + baseIndex
			questItem = getglobal (questItemName..index)
			questItem.type = "reward"
			numItems = 1

			name, texture, numItems, quality, isUsable = GetQuestLogRewardInfo (i)

			questItem:SetID (i)
			questItem:Show()
			-- For the tooltip
			questItem.rewardType = "item"
			getglobal (questItemName..index.."Name"):SetText(name)
			SetItemButtonCount (questItem, numItems)
			SetItemButtonTexture (questItem, texture)

			if isUsable then
				SetItemButtonTextureVertexColor (questItem, 1.0, 1.0, 1.0)
				SetItemButtonNameFrameVertexColor (questItem, 1.0, 1.0, 1.0)
			else
				SetItemButtonTextureVertexColor (questItem, 0.5, 0, 0)
				SetItemButtonNameFrameVertexColor (questItem, 1.0, 0, 0)
			end

			if i > 1 then

				if mod (i, 2) == 1 then
					questItem:SetPoint ("TOPLEFT", questItemName..(index - 2), "BOTTOMLEFT", 0, -2)
					QuestFrame_SetAsLastShown (questItem, spacerFrame)

				else
					questItem:SetPoint ("TOPLEFT", questItemName..(index - 1), "TOPRIGHT", 1, 0)
				end

			else
				questItem:SetPoint ("TOPLEFT", questState.."ItemReceiveText", "BOTTOMLEFT", 0, -5)
				QuestFrame_SetAsLastShown (questItem, spacerFrame)

			end

			rewardsCount = rewardsCount + 1
		end
	else	
		questItemReceiveText:Hide()
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Quest watch

--------
-- Init and open

function Nx.Quest.Watch:Open()

	local opts = Nx:GetGlobalOpts()
	self.GOpts = opts
	local qopts = Nx:GetQuestOpts()

	self.Watched = {}

	self.Opened = true

	local fixedSize = opts["QWFixedSize"]

	-- Create window

--	Nx.Window:ClrSaveData ("NxQuestWatch")

	Nx.Window:SetCreateFade (1, .15)

	local border = fixedSize and true or 1

	local win = Nx.Window:Create ("NxQuestWatch", nil, nil, nil, 1, border)
	self.Win = win

	win:InitLayoutData (nil, -.80, -.35, -.2, -.1)

	win:CreateButtons (opts["QWShowClose"], nil, true)

	win:SetUser (self, self.OnWin)
	win:SetBGAlpha (0, 1)
	win.Frm:SetClampedToScreen (true)

	local xo = 0
	local yo = 0

	if not fixedSize then
		xo = 7
		yo = 3
		win:SetBorderSize (0, 7)
	end

	win:SetTitleXOff (84 + xo, -1 - yo)

--	win:SetTitle ("[  ]")
	win.UserUpdateFade = self.WinUpdateFade

	-- Update helper. Can't call directly due to validation changing function

	local function update (self)
		self:Update()
	end

	-- Buttons

	local function func (self)
		self.Menu:Open()
	end
	self.ButMenu = Nx.Button:Create (win.Frm, "QuestWatchMenu", nil, nil, 4, -5 + yo, "TOPLEFT", 1, 1, func, self)

	local function func (self)
		self.MenuPri:Open()
	end
	self.ButPri = Nx.Button:Create (win.Frm, "QuestWatchPri", nil, nil, 19, -5 + yo, "TOPLEFT", 1, 1, func, self)

	local function func (self, but)
		local qopts = Nx:GetQuestOpts()
		qopts.NXWShowOnMap = but:GetPressed()
	end
	self.ButShowOnMap = Nx.Button:Create (self.ButMenu.Frm, "QuestWatchShowOnMap", nil, nil, 29, 0, "CENTER", 1, 1, func, self)
	self.ButShowOnMap:SetPressed (qopts.NXWShowOnMap)

	local function func (self, but)
		Nx.CharOpts["QuestWatchATrack"] = but:GetPressed()
		if not but:GetPressed() and not IsShiftKeyDown() then
			Nx.Quest.Tracking = {}	-- Kill all
		end
		self:Update()
	end
	self.ButATarget = Nx.Button:Create (self.ButMenu.Frm, "QuestWatchATrack", nil, nil, 43, 0, "CENTER", 1, 1, func, self)
	self.ButATarget:SetPressed(Nx.CharOpts["QuestWatchATrack"])

	local function func (self, but)
		--print(but:GetState()); --warbaby quest givers 1 for none, 2 normal 3 daily
		Nx.CharOpts["QMapShowQuestGivers3"] = but:GetState()
		local map = Nx.Map:GetMap (1)
		map.Guide:UpdateGatherFolders()
	end
	self.ButQGivers = Nx.Button:Create (self.ButMenu.Frm, "QuestWatchGivers", nil, nil, 57, 0, "CENTER", 1, 1, func, self)
	self.ButQGivers:SetState (Nx.CharOpts["QMapShowQuestGivers3"])

	local function func (self, but)
		qopts.NXWWatchParty = but:GetPressed()
		Nx.Quest:PartyUpdateTimer()
	end
	self.ButShowParty = Nx.Button:Create (self.ButMenu.Frm, "QuestWatchParty", nil, nil, 71, 0, "CENTER", 1, 1, func, self)
	self.ButShowParty:SetPressed (qopts.NXWWatchParty == nil or qopts.NXWWatchParty)

	-- List

	Nx.List:SetCreateFont ("FontWatch", 12)

	local list = Nx.List:Create (false, 2, -2, 100, 12 * 3, win.Frm, not fixedSize, true)
	self.List = list

	list:SetUser (self, self.OnListEvent)
--	self:SetFont()

	if not fixedSize then
		list:SetMinSize (124, 1)		-- Sets the window minimum
		list.Frm:EnableMouse (false)
	end

	list:ColumnAdd ("", 1, 14)
	list:ColumnAdd (L["Name"], 2, fixedSize and 900 or 20)
--	list:ColumnAdd ("", 3, 0)
--	list:ColumnAdd ("Type", 4, 60)
--	list:ColumnAdd ("Status", 5, 500)

	win:Attach (list.Frm, 0, 1, 0, 1)

	-- Create menu button menu

	local qlist = Nx.Quest.List

	local menu = Nx.Menu:Create (list.Frm)
	self.Menu = menu

	menu:AddItem (0, L["Watch All Quests"], qlist.Menu_OnWatchAll, qlist)
	menu:AddItem (0, L["Remove All Watches"], self.Menu_OnRemoveAllWatches, self)

	menu:AddItem (0, L["Track None"], qlist.Menu_OnTrackNone, qlist)

--	local item = menu:AddItem (0, "Max Auto Track", update, self)
--	item:SetSlider (qopts, 1, 25, 1, "NXWAutoMax")

	local i = 25

	local item = menu:AddItem (0, L["Max Visible In List"], update, self)
	item:SetSlider (qopts, 1, i, 1, "NXWVisMax")

--	menu:AddItem (0, "")

	local function func()
		Nx.Opts:Open ("Quest Watch")
	end

	menu:AddItem (0, L["Options..."], func)

	-- Create priority button menu

	local menu = Nx.Menu:Create (list.Frm, 260)
	self.MenuPri = menu

	local item = menu:AddItem (0, L["Hide Unfinished Quests"], update, self)
	item:SetChecked (qopts, "NXWHideUnfinished")

	local item = menu:AddItem (0, L["Hide 5+ Group Quests"], update, self)
	item:SetChecked (qopts, "NXWHideGroup")

	local item = menu:AddItem (0, L["Hide Quests Not In Zone"], update, self)
	item:SetChecked (qopts, "NXWHideNotInZone")

--	local item = menu:AddItem (0, "Hide Quests Not On Continent", update, self)
--	item:SetChecked (qopts, "NXWHideNotInCont")

	local item = menu:AddItem (0, L["Hide Quests Farther Than"], update, self)
	item:SetSlider (qopts, 200, 20000, 1, "NXWHideDist")

	local item = menu:AddItem (0, L["Sort, Distance"], update, self)
	item:SetSlider (qopts, 0, 1, nil, "NXWPriDist")

	local item = menu:AddItem (0, L["Sort, Complete"], update, self)
	item:SetSlider (qopts, -200, 200, 1, "NXWPriComplete")

	local item = menu:AddItem (0, L["Sort, Low Level"], update, self)
	item:SetSlider (qopts, -200, 200, 1, "NXWPriLevel")

	local function func()
		Nx.Map:GetMap (1).Guide:UpdateGatherFolders()
	end

	local item = menu:AddItem (0, L["Quest Giver Lower Levels To Show"], func, self)
	item:SetSlider (opts, 0, 90, 1, "QMapQuestGiversLowLevel")

	local item = menu:AddItem (0, L["Quest Giver Higher Levels To Show"], func, self)
	item:SetSlider (opts, 0, 90, 1, "QMapQuestGiversHighLevel")

	local function func()
		Nx.CurCharacter["QHAskedGet"] = true
		Nx.Timer:Start ("QHistLogin", .1, Nx.Quest, Nx.Quest.QuestQueryTimer)
	end
	local item = menu:AddItem (0, "Get Completed From Server", func, self)

    local function func()
        Nx.Quest.Watch.GOpts["QWAchTrack"] = not Nx.Quest.Watch.GOpts["QWAchTrack"]
        Nx.Quest.Watch:UpdateList();
    end
    local item=menu:AddItem(0, "Toggle achievements and default watch list", func, self)

--	local item = menu:AddItem (0, "Group", update, self)
--	item:SetSlider (qopts, -200, 200, 1, "NXWPriGroup")

	-- Create watch button menu

	local menu = Nx.Menu:Create (list.Frm)
	self.WatchMenu = menu

	menu:AddItem (0, L["Remove Watch"], self.Menu_OnRemoveWatch, self)
	menu:AddItem (0, L["Link Quest (shift right click)"], self.Menu_OnLinkQuest, self)
	menu:AddItem (0, L["Show Quest Log (alt right click)"], self.Menu_OnShowQuest, self)
	menu:AddItem (0, L["Show On Map (shift left click)"], self.Menu_OnShowMap, self)
	menu:AddItem (0, L["Open Quest Map (control left click)"], self.Menu_OpenToQuest, self)
	menu:AddItem (0, L["Share"], self.Menu_OnShare, self)

	menu:AddItem (0, "")
	menu:AddItem (0, L["Abandon"], self.Menu_OnAbandon, self)

	--

	self.FirstUpdate = true
	self.FlashColor = 0

	--

	self:SetSortMode (1)

	--warbaby after show fullscreen map, watch list will be shown instantly.
	local instantShow = function() if Nx.Quest.CurQ then Nx.Quest.Watch:UpdateList() end end
	win.Frm:HookScript("OnShow", instantShow)
	if CoreScheduleTimer then
		CoreScheduleTimer(false, 0.1, instantShow) --warbaby xxx
	end
end

function Nx.Quest.Watch:Menu_OpenToQuest()
	if not self.MenuQIndex then return end
	local qId = select(9, GetQuestLogTitle(self.MenuQIndex))
	if qId and qId>0 and GetQuestLogIndexByID(qId)>0 then
		Nx_WorldMap_OpenToQuest(qId)
	end
end

--------
-- Setup list font

function Nx.Quest.Watch:FixedChange()

	Nx.Window:ClrSaveData ("NxQuestWatch")
end

--------
-- Setup list font

--[[
function Nx.Quest.Watch:SetFont()

	local opts = Nx:GetGlobalOpts()

	local sz = opts["QWLargeFont"] and 15 or 12
	self.List:SetFont (sz)

	local sz = opts["QWLargeFont"] and 15 or 13
	self.List:SetLineHeight (sz, 0)
end
--]]

--------

function Nx.Quest.Watch:OnWin (typ)
	self:Update()
end

--------

function Nx.Quest.Watch:Menu_OnRemoveWatch (item)

	self:RemoveWatch (self.MenuQId, self.MenuQIndex)
	self:Update()
	Nx.Quest.List:Update()
end

function Nx.Quest.Watch:Menu_OnShowQuest()

	ShowUIPanel (QuestLogFrame)

	Nx.Quest.List.Bar:Select (1)
	Nx.Quest.List:Select (self.MenuQId, self.MenuQIndex)
end

function Nx.Quest.Watch:Menu_OnShowMap (item)

	self:Set (self.MenuItemData, true)
end

function Nx.Quest.Watch:Menu_OnLinkQuest()

	Nx.Quest:LinkChat (self.MenuQId)
end

function Nx.Quest.Watch:Menu_OnShare (item)

	local qi = self.MenuQIndex
	if qi > 0 then

		if GetNumSubgroupMembers() > 0 then
			Nx.Quest:ExpandQuests()
--			Nx.Quest.List:Select (self.MenuQId, self.MenuQIndex)
			QuestLogPushQuest (qi)
			Nx.Quest:RestoreExpandQuests()
		else
			Nx.prt (L["Must be in party to share"])
		end
	end
end

function Nx.Quest.Watch:Menu_OnAbandon (item)
	Nx.Quest.List:Select (self.MenuQId, self.MenuQIndex)
	Nx.Quest:Abandon (self.MenuQIndex, self.MenuQId)
end

function Nx.Quest.Watch:Menu_OnRemoveAllWatches (item)

	local curq = Nx.Quest.CurQ

	for n = 1, curq and #curq or 0 do

		local cur = curq[n]
		self:RemoveWatch (cur.QId, cur.QI)
	end

	self:Update()
	Nx.Quest.List:Update()
end

function Nx.Quest.Watch:RemoveWatch (qId, qI)

	local i, cur, id = Nx.Quest:FindCur (qId, qI)

	if i then

		local qStatus, qTime = Nx:GetQuest (id)
		if qStatus == "W" then

			Nx:SetQuest (id, "c", qTime)
			Nx.Quest:PartyStartSend()

			if qId > 0 then
				Nx.Quest.Tracking[qId] = nil

				if Nx.Quest:IsTargeted (qId) then
					Nx.Quest.Map:ClearTargets()
				end
			end
		end

		if IsQuestWatched (qI) then	-- Blizz crap? Remove
			RemoveQuestWatch (qI)
		end
	end
end

--------
-- Show or hide

function Nx.NXWatchKeyToggleMini()

	local self = Nx.Quest.Watch
--	self.ButMini:SetPressed (not self.ButMini:GetPressed())

	self.Win:ToggleMinimize()
	self:Update()
end

function Nx.NXWatchKeyUseItem()

	if NxListFrms1 then
		NxListFrms1:Click()
	end
end

function Nx.Quest.Watch:ClearAutoTarget (keepTracking)

	if Nx.Quest.Enabled then

		if not keepTracking then
			Nx.Quest.Tracking = {}	-- Kill all
		end
		self.ButATarget:SetPressed (false)
		self:Update()
	end
end

--------
-- Set sort mode

function Nx.Quest.Watch:SetSortMode (mode)

	Nx.Timer:Start ("QuestWatchUpdate", .01, self, self.OnUpdateTimer)

--[[
	local qopts = Nx:GetQuestOpts()
	qopts.NXSortWatchMode = mode

	if mode == 1 then
		Nx.Timer:Start ("QuestWatchUpdate", .01, self, self.OnUpdateTimer)

	else
		Nx.Timer:Stop ("QuestWatchUpdate")

		local curq = self.CurQ

		for n = 1, curq and #curq or 0 do
			local cur = curq[n]
			cur.Distance = 999999999
			cur.CloseObjI = -1
		end

		self.Watch:Update()
	end
--]]
end

function Nx.Quest.Watch:OnUpdateTimer (item)

	if not Nx.Timer:IsActive ("QuestWatchDist") then
		self:Update()
		self.CalcDistCnt = 3
	end
	return 1.5
end

--------
-- Update list security stub

function Nx.Quest.Watch:Update()
--	Nx.Quest.Watch:Update_()
end

function Nx.Quest.Watch:Update_()

--	Nx.prt ("Watch update")
--[[
	if Nx.Free then
		local ver = GetBuildInfo()
		if ver ~= "2.3.3" then

			local function func()
				Nx.prt ("data error")
			end

			Nx.Timer:Start ("WatchDataError", .1, self, func)
			return
		end
	end
--]]

	self.CalcDistI = 1
	self.CalcDistCnt = 20
	Nx.Timer:Start ("QuestWatchDist", 0, self, self.OnTimer)
end

function Nx.Quest.Watch:OnTimer (item)

	local curq = Nx.Quest.CurQ
	if not curq then	-- Bad stuff?
		return
	end

	local i = self.CalcDistI
	local cnt = self.CalcDistCnt

	Nx.Quest:CalcDistances (i, i + cnt - 1)

	i = i + cnt

	if i <= #curq then
		self.CalcDistI = i
		return .02
	end

	local watched = self:UpdateList()

--	Nx.Quest:Route (watched)
end

--------
-- Update watch list

function Nx.Quest.Watch:UpdateList()

--	Nx.prt ("QWatchUpdate")

	local Nx = Nx
	local Quest = Nx.Quest
	local Map = Nx.Map

	Nx.Timer:ProfilerStart ("Watch UpList")

	local qopts = Nx:GetQuestOpts()
	local hideUnfinished = qopts["NXWHideUnfinished"]
	local hideGroup = qopts["NXWHideGroup"]
	local hideNotInZone = qopts["NXWHideNotInZone"]
	local hideNotInCont = qopts["NXWHideNotInCont"]
	local hideDist = qopts["NXWHideDist"] >= 19900 and 99999 or qopts["NXWHideDist"]
	local hideDist = hideDist / 4.575		-- Convert to world units
	local priDist = qopts.NXWPriDist

	local gopts = self.GOpts

	local fixedSize = gopts["QWFixedSize"]
	local showDist = gopts["QWShowDist"]
	local showPerColor = gopts["QWShowPerColor"]
	local hideDoneObj = gopts["QWHideDoneObj"]

	local compColor = Nx.Util_num2colstr (gopts["QWCompleteColor"])
	local incompColor = Nx.Util_num2colstr (gopts["QWIncompleteColor"])
	local oCompColor = Nx.Util_num2colstr (gopts["QWOCompleteColor"])
	local oIncompColor = Nx.Util_num2colstr (gopts["QWOIncompleteColor"])

	-- List

	local list = self.List

	local oldw, oldh = list:GetSize()

	list:SetBGColor (Nx.Util_num2rgba (gopts["QWBGColor"]))

	list:Empty()


	local watched = wipe (self.Watched)

	local curq = Quest.CurQ
	if curq then

		for n, cur in ipairs (curq) do

			local qId = cur.QId
			local id = qId > 0 and qId or cur.Title
			local qStatus = Nx:GetQuest (id)
			local qWatched = qStatus == "W" or cur.PartyDesc

--			Nx.prt ("qid %s %s dist %s", qId, qStatus, cur.Distance)

			if qWatched and (cur.Distance < hideDist or cur.Distance > 999999) then

				if (not hideUnfinished or cur.CompleteMerge) and
					(not hideGroup or cur.PartySize < 5) and
					(not hideNotInZone or cur.InZone) and
					(not hideNotInCont or cur.InCont) then

					local d = max (cur.Distance * priDist * cur.Priority * 10 + cur.Priority * 100, 0)
					d = cur.HighPri and 0 or d
					d = floor (d) * 256 + n
					tinsert (watched, d)
				end
			end
		end

		sort (watched)
		local disti = watched[1]

		-- Auto target objective of closest quest

		if self.ButATarget:GetPressed() then

			if disti then
				local cur = curq[bit.band (disti, 0xff)]
				Quest:CalcAutoTrack (cur)
			end
		end

		-- Remember closest quest for com

		self.ClosestCur = disti and curq[bit.band (disti, 0xff)]

		--

		if not self.Win:IsSizeMin() and self.Win:IsVisible() then
			self.FlashColor = (self.FlashColor + 1) % 2
			list:SetItemFrameScaleAlpha (gopts["QWItemScale"], Nx.Util_num2a (gopts["QWItemAlpha"]))
			if gopts["QWHideBlizz"] then
				WatchFrame:Hide()		-- Hide Blizzard's
			end
			if gopts["QWChalTrack"] then
			  local cTimer ={GetWorldElapsedTimers()}
				for _,id in ipairs(cTimer) do
 		          local description, elapsedTime, isChallengeModeTimer = GetWorldElapsedTime(id) 
 		          if isChallengeModeTimer > 0 then
 		            list:ItemAdd(0)
 			        list:ItemSet(2,format("|cffff8888%s",description))
 			        list:ItemSetButton("QuestWatchTip",false)
 			        local s = "  |cffffffff" .. SecondsToTime(elapsedTime)
 			        list:ItemAdd(0)
 			        list:ItemSet(2,s)
 		          end
 		        end			
			end
			if gopts["QWScenTrack"] then
				local name, currentStage, numStages = C_Scenario.GetInfo()
				if (currentStage > 0) then
					local stageName, stageDescription, numCriteria = C_Scenario.GetStepInfo()	      
					list:ItemAdd(0)
					list:ItemSet(2,format(L["|cffff8888Scenario: %s"],name))		  
					list:ItemSetButtonTip(stageDescription)
					list:ItemSetButton("QuestWatchTip",false)
					if (currentStage <= numStages) then		    
						s = format(L["  |cffff0000Stage [|cffffffff%d|cffff0000/|cffffffff%d|cffff0000]:|cff00ff00%s"], currentStage, numStages,stageName)
					else			
						s = L["  |cffff0000[|cffffffffComplete|cffff0000]"]
					end
					list:ItemAdd(0)
					list:ItemSet(2,s)		  		  
				end
			end						
			if gopts["QWAchTrack"] then
				local ach = { GetTrackedAchievements() }
				for _, id in ipairs (ach) do
					local aId, aName, aPoints, aComplete, aMonth, aDay, aYear, aDesc = GetAchievementInfo (id)
					if aName then		-- Person had nil name happen
						list:ItemAdd (0)
						list:ItemSet (2, format (L["|cffdf9fffAchievement: %s"], aName))
						local numC = GetAchievementNumCriteria (id)
						local progressCnt = 0
						local tip = aDesc
						for n = 1, numC do
							local cName, cType, cComplete, cQuantity, cReqQuantity = GetAchievementCriteriaInfo (id, n)
							local color = cComplete and "|cff80ff80" or "|cffa0a0a0"
							if not cComplete and cReqQuantity > 1 and cQuantity > 0 then
								progressCnt = progressCnt + 1
								tip = tip .. format ("\n%s%s: %s / %s", color, cName, cQuantity, cReqQuantity)
							else
								tip = tip .. format ("\n%s%s", color, cName)
							end
						end
						list:ItemSetButton ("QuestWatchTip", false)
						list:ItemSetButtonTip (tip)
						local showCnt = 0
						for n = 1, numC do
							local cName, cType, cComplete, cQuantity, cReqQuantity = GetAchievementCriteriaInfo (id, n)
							if not cComplete and (progressCnt <= 3 or cQuantity > 0) then
								list:ItemAdd (0)
								local s = "  |cffcfafcf"
								if numC == 1 then
									if cReqQuantity > 1 then
										s = s .. format ("%s/%s", cQuantity, cReqQuantity)
									else
										s = s .. cName
									end
								else
									s = s .. cName
									if cReqQuantity > 1 then
										s = s .. format (": %s/%s", cQuantity, cReqQuantity)
									end
								end
								showCnt = showCnt + 1
								if showCnt >= 3 then
									s = s .. "..."
								end
								list:ItemSet (2, s)
								if showCnt >= 3 then
									break
								end
							end
						end
					end
				end
			end
			
			local s = gopts["QWAchZoneShow"] and Nx.Quest:GetZoneAchievement()
			if s then
				list:ItemAdd (0)
				list:ItemSet (2, s)
			end

--			Nx.prtVar ("Watched", watched)

			local watchNum = 1

			for _, distn in ipairs (watched) do

				local n = bit.band (distn, 0xff)

				local cur = curq[n]
				local qId = cur.QId

				if 1 then

					local level, isComplete = cur.Level, cur.CompleteMerge
					local quest = cur.Q
					local qi = cur.QI
					local lbNum = cur.LBCnt

--					local link, item, charges = GetQuestLogSpecialItemInfo (questIndex)

					list:ItemAdd (qId * 0x10000 + qi)

					local trackMode = Quest.Tracking[qId] or 0
					local obj = quest and (quest[3] or quest[2])					
					if qId == 0 then
						list:ItemSetButton ("QuestWatchErr", false)

					elseif not obj then

--						Nx.prt ("not obj")
						list:ItemSetButton ("QuestWatchErr", false)

					elseif isComplete or lbNum == 0 then

						local butType = "QuestWatch"
						local pressed = false

						if bit.band (trackMode, 1) > 0 then
							pressed = true
						end

						if Quest:IsTargeted (qId, 0) then
							butType = "QuestWatchTarget"
						end

						local name, zone = Quest:GetSEPos (obj)
						if not zone or not Map.NxzoneToMapId[zone] then
							butType = "QuestWatchErr"
						end

						if isComplete and cur.IsAutoComplete then
							butType = "QuestWatchAC"
							pressed = false
						end

						list:ItemSetButton (butType, pressed)
					else

						list:ItemSetButton ("QuestWatchTip", false)
					end

					if not isComplete and cur.ItemLink and gopts["QWItemScale"] >= 1 then
						list:ItemSetFrame ("WatchItem~" .. cur.QI .. "~" .. cur.ItemImg .. "~" .. cur.ItemCharges)
					end

					list:ItemSetButtonTip (cur.ObjText .. (cur.PartyDesc or ""))

					local color = isComplete and compColor or incompColor

					local lvlStr = ""
					if level > 0 then
						local col = Quest:GetDifficultyColor (level)
						lvlStr = format ("|cff%02x%02x%02x%2d%s ", col.r * 255, col.g * 255, col.b * 255, level, cur.TagShort)
					end

					local nameStr = format ("%s%s%s", lvlStr, color, cur.Title)

					if cur.NewTime and time() < cur.NewTime + 60 then
						nameStr = format (L["|cff00%2x00New: %s"], self.FlashColor * 200 + 55, nameStr)
					end

					if isComplete then

						local obj = quest and (quest[3] or quest[2])

						if lbNum > 0 or not obj then
							nameStr = nameStr .. (isComplete == 1 and L["|cff80ff80 (Complete)"] or "|cfff04040 - " .. FAILED)

						else
							local desc = Quest:UnpackSE (obj)
							nameStr = format ("%s |cffffffff(%s)", nameStr, desc)
						end
					end

					if showDist then
						local d = cur.Distance * 4.575

						if d < 1000 then
							nameStr = format (L["%s |cff808080%d yds"], nameStr, d)
						elseif cur.Distance < 99999 then
							nameStr = format (L["%s |cff808080%.1fK yds"], nameStr, d / 1000)
						end
					end

					if cur.PartyCnt then
						nameStr = format ("%s |cffb0b0f0(+%s)", nameStr, cur.PartyCnt)
					end

					if cur.Party then
						nameStr = nameStr .. " |cffb0b0f0" .. cur.Party
					end

					list:ItemSet (2, nameStr)


					if cur.TimeExpire then	-- Have a timer?
						list:ItemAdd (0)
						list:ItemSet (2, format ("  |cfff06060%s %s", TIME_REMAINING, SecondsToTime (cur.TimeExpire - time())))
					end

					if isComplete and cur.IsAutoComplete then
						list:ItemAdd (0)
						list:ItemSet (2, format (L["|cff%2x0000--- Click ? to complete ---"], self.FlashColor * 200 + 55))
					end


					if qi > 0 or cur.Party then

						local desc, done
						local zone, loc
						local lnOffset = -1

						for ln = 1, 31 do

							local obj = quest and quest[ln + 3]

							if not obj and ln > lbNum then
--[[
								if ln == 1 then
									obj = quest[3] or quest[2]
								else
									break
								end
--]]
								break
							end

							zone = nil
							done = isComplete

							if obj then
								desc, zone, loc = Quest:UnpackObjective (obj)
							end

							if ln <= lbNum then
								desc = cur[ln]
								done = cur[ln + 300]
							end

							if not (hideDoneObj and done) then

								if showPerColor then
									if done then
										color = Quest.PerColors[9]
									else

										local s1, _, i, total = strfind (desc, ": (%d+)/(%d+)")
										if s1 then
--											Nx.prt ("%s %s", i, total)
											i = floor (tonumber (i) / tonumber (total) * 8.99) + 1
										else
											i = 1
										end

										color = Quest.PerColors[i]
									end
								else
									color = done and oCompColor or oIncompColor
								end

								if gopts["QWOCntFirst"] then
									local s1, s2 = strmatch (desc, "(.+): (.+)")
									if s2 then
										desc = format ("%s: %s", s2, s1)
									end
								end

								local str = color .. (desc or "?")	--V4

								if not done then
									local d = cur["OD"..ln]
									if d and d < .5 then			-- Not in yards
										str = "*" .. str
									end
								end

								list:ItemAdd (qId * 0x10000 + ln * 0x100 + qi)
								list:ItemSetOffset (16, lnOffset)

								local butType = "QuestWatchErr"

								if zone then
									if Map.NxzoneToMapId[zone] then
										butType = "QuestWatch"
										if Quest:IsTargeted (qId, ln) then
											butType = "QuestWatchTarget"
										end
									end
								end

--								Nx.prt ("watch %s %s %s", qId, zone or "nil", butType or "nil")

								if not done and butType then

									if bit.band (trackMode, bit.lshift (1, ln)) > 0 then
										list:ItemSetButton (butType, true)
									else
										list:ItemSetButton (butType, nil)
									end
								end

								if not fixedSize then

									local maxCOpt = gopts["QWOMaxLen"] + 10
									local maxC = maxCOpt

									while #str > maxC do

										for cn = maxC, 12, -1 do
											if strbyte (str, cn) == 32 then		-- Find last space
												maxC = cn - 1
												break
											end
										end

										local s = strsub (str, 1, maxC)
										list:ItemSet (2, s)

										str = color .. strsub (str, maxC + 1)
										list:ItemAdd (qId * 0x10000 + ln * 0x100 + qi)
										list:ItemSetOffset (16, lnOffset)

										maxC = maxCOpt
									end
								end

								list:ItemSet (2, str)

								lnOffset = lnOffset - 1
							end
						end
					end

					if not fixedSize and watchNum >= qopts.NXWVisMax then
						list:ItemAdd (0)
						list:ItemSet (2, " ...")
						break
					end

					watchNum = watchNum + 1
				end
			end
		end
	end

	if fixedSize then
		list:FullUpdate()
	else
--		Nx.prt ("QWL Up")
		list:Update()
	end

	-- Grow upwards

	if self.Win:IsSizeMin() then
		self.FirstUpdate = true
		self.Win:SetTitle ("")

	else

		local w, h = list:GetSize()

		if gopts["QWGrowUp"] and not self.FirstUpdate then

			h = h - oldh
--			Nx.prt ("h dif %s", h)
			self.Win:OffsetPos (0, h)
		end

		if w < 127 then
			self.Win:SetTitle ("")
		else
			local _, i = GetNumQuestLogEntries()
			self.Win:SetTitle (format ("|cff40af40%d/25", i))
		end

		self.FirstUpdate = nil
	end

	Nx.Timer:ProfilerEnd ("Watch UpList")

	return watched
end

--------

function Nx.Quest.Watch:ShowUpdate()
	self.Win.RaidHid = nil
	if self.GOpts["QWHideRaid"] then
		if IsInRaid() then
			self.Win.Frm:Hide()
			self.Win.RaidHid = true
		else
			self.Win.Frm:Show()
		end
	end
end

--------
-- Called by Window update
-- Self = win

function Nx.Quest.Watch:WinUpdateFade (fade, force)

	if self.GOpts["QWFadeAll"] or force then

		self.Win:SetTitleColors (1, 1, 1, fade)
		self.List.Frm:SetAlpha (fade)

		self.ButMenu.Frm:SetAlpha (fade)
		self.ButPri.Frm:SetAlpha (fade)
		self.ButShowOnMap.Frm:SetAlpha (fade)
		self.ButATarget.Frm:SetAlpha (fade)
	end
end

--------
-- On list control updates

function Nx.Quest.Watch:OnListEvent (eventName, val1, val2, click, but)

--	Nx.prt ("QuestListUpdate "..eventName)

	if eventName == "button" then

		local Quest = Nx.Quest

		-- val1 = id
		-- val2 = pressed

		local data = self.List:ItemGetData (val1)

		if data then

			local qIndex = bit.band (data, 0xff)
			local qId = bit.rshift (data, 16)

			local typ = but:GetType()

			if click == "LeftButton" then

--				Nx.prt ("Data #%d, Id%d", qIndex, qId)
--				Nx.prt ("List but %s", but:GetType().WatchError or "nil")

				if typ.WatchError then
					Quest:MsgNotInDB ("O")
				else

					if IsAltKeyDown() then
						Quest.List:SendQuestInfo (qIndex)

					else

						if typ.WatchTip then
--[[
							local i, cur = Quest:FindCur (qId, qIndex)
							if cur.ItemLink then
								UseQuestLogSpecialItem (qIndex)
							end
--]]
							val2 = false	-- Can't turn on cause will track missing stuff
							self:Set (data, val2)
--[[
							local i, cur = Quest:FindCur (qId, qIndex)
							if i then

								for n = cur.LBCnt, 1, -1 do

									data = bit.band (data, 0xffff00ff) + n * 0x100

--									Nx.prtVar ("", data)
									self:Set (data, val2, not IsShiftKeyDown())
								end
							end
--]]
						else

							local i, cur = Quest:FindCur (qId, qIndex)
							if cur and cur.CompleteMerge and cur.IsAutoComplete then
--								Nx.prt ("ShowQuestComplete %s", qIndex)
								ShowQuestComplete (qIndex)

							else
								self:Set (data, val2, not IsShiftKeyDown())

							end

						end
					end
				end

			elseif click == "RightButton" then

				if typ.WatchTip then
					return
				end

				if IsAltKeyDown() then
					Quest.IgnoreAlt = true
					ShowUIPanel (QuestLogFrame)
					Quest.IgnoreAlt = nil
					Quest.List.Bar:Select (1)
					Quest.List:Select (qId, qIndex)

				elseif IsShiftKeyDown() then

					Quest:LinkChat (qId)

				else
					self.MenuItemData = data
					self.MenuQIndex = qIndex
					self.MenuQId = qId

					self.WatchMenu:Open()
				end
			end
		end
	end
end

--------
--

function Nx.Quest.Watch:Set (data, on, track)

	local Quest = Nx.Quest

	local qIndex = bit.band (data, 0xff)
	local qId = bit.rshift (data, 16)

	if qId > 0 then

		local i, cur = Quest:FindCur (qId, qIndex)

		if not (cur and cur.Q) then
			Quest:MsgNotInDB()
			return
		end

--		Nx.prt ("Q Set %s %s", i, cur and cur.Name or "nil")

		local q = cur.Q
		if not q[2] and not q[3] then

			Quest:MsgNotInDB()
			return
		end

		self:ClearAutoTarget (true)

		-- 0 is quest name line
		local qObj = bit.band (bit.rshift (data, 8), 0xff)

		local tbits = Quest.Tracking[qId] or 0

		if track then

			Quest.Tracking = {}	-- Kill all
			tbits = 0

			if not Quest:IsTargeted (qId, qObj) then
				on = true	-- Force on if on but not tracked
			end
		end

		if IsControlKeyDown() then
			on = false		-- Force off
		end

		if qObj == 0 then

			if on == false then
				Quest.Tracking[qId] = nil
			else
				Quest.Tracking[qId] = cur.TrackMask		-- Track all
			end
		else

			if on == false then
				Quest.Tracking[qId] = bit.band (tbits, bit.bnot (bit.lshift (1, qObj)))
			else
				Quest.Tracking[qId] = bit.bor (tbits, bit.lshift (1, qObj))
			end
		end

		if track then
			self:ClearCompleted (qId)
		end

		Quest:TrackOnMap (qId, qObj, qIndex > 0, track)

		self:Update()
		Quest.List:Update()

	else

		Quest:MsgNotInDB()
	end

end

--------
-- Add quest to watch
-- (CurQ number)

function Nx.Quest.Watch:Add (curi)

	local Quest = Nx.Quest
	local cur = Quest.CurQ[curi]

	local qId = cur.QId > 0 and cur.QId or cur.Title
	local qStatus = Nx:GetQuest (qId)

	if not qStatus or qStatus ~= "W" then		-- Pointless compare?

		Nx:SetQuest (qId, "W")
		Quest:PartyStartSend()
	end
end

--------
-- Clear completed quests

function Nx.Quest.Watch:ClearCompleted (qIdMatch)

	local Quest = Nx.Quest

	self:Update()	-- Get list in sync with quests if added or removed

	local list = self.List

	for ln = 1, list:ItemGetNum() do

		local i = list:ItemGetData (ln)
		if i then

			local qIndex = bit.band (i, 0xff)
			local qId = bit.rshift (i, 16)

			if qId > 0 and (not qIdMatch or qIdMatch == qId) then

				local _, cur = Quest:FindCur (qId)
				if cur then

					local qComplete = cur.CompleteMerge	-- Remember for objectives
					local qObj = bit.band (bit.rshift (i, 8), 0xff)

--					Nx.prt ("Data #%d Id %d Obj %d C=%s", qIndex, qId, qObj, tostring (cur.CompleteMerge))

					local tbits = Quest.Tracking[qId] or 0

					if tbits > 0 then

						local objmask = bit.lshift (1, qObj)

						if qObj == 0 then
							if qComplete then

								local qStatus, qTime = Nx:GetQuest (qId)

								if qStatus ~= "C" then
--									Nx.prt ("track on")
									-- Turn on

									if Nx.Quest:IsTargeted (qId) then
										Quest.Tracking[qId] = bit.bor (tbits, objmask)
										Quest:TrackOnMap (qId, 0, qIndex > 0, true)
									end
								end
							end

						else
							local desc
							local done = qComplete
							local num = cur.LBCnt

							if qObj <= num then
								desc = cur[qObj]
								done = cur[qObj + 300]
							end

							if done then

								local on = bit.band (tbits, objmask)

								if on > 0 then
									-- Turn off
									Quest.Tracking[qId] = bit.band (tbits, bit.bnot (objmask))
									Quest:TrackOnMap (qId, qObj, qIndex > 0)
								end
							end
						end
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

function Nx.Quest:CreateGiverIconMenu (mainMenu, frm)

	local completedMenu = Nx.Menu:Create (frm)
	self.GiverIconMenuCompleted = completedMenu
	self.GiverIconMenuICompleted = mainMenu:AddSubMenu (completedMenu, "Quest Completion...")

	self.GiverIconMenuICompletedT = {}

	for n = 1, 29 do

		local function func (self, item)

			local s = item:GetChecked() and "C" or "c"
			Nx:SetQuest (item.UData, s, time())

			if item:GetChecked() then
				self:CalcPreviousDone (item.UData)
			end

			self:UpdateGiverIconMenu()
			self.GiverIconMenuCompleted:Update()

			local map = Nx.Map:GetMap (1)
			map.Guide:UpdateMapIcons()
		end

		self.GiverIconMenuICompletedT[n] = completedMenu:AddItem (0, "?", func, self)
		self.GiverIconMenuICompletedT[n]:SetChecked()
	end

	--

	local infoMenu = Nx.Menu:Create (frm)
	self.GiverIconMenuInfo = infoMenu
	self.GiverIconMenuIInfo = mainMenu:AddSubMenu (infoMenu, L["Quest Info (shift click - goto)..."])

	self.GiverIconMenuIInfoT = {}

	for n = 1, 29 do

		local function func (self, item)
--			Nx.prt ("%s", item.Text)

			if not IsShiftKeyDown() then
				local link = self:CreateLink (item.UData, -1, "x")
				SetItemRef (link)
			else

				self:Goto (item.UData)
			end
		end

		self.GiverIconMenuIInfoT[n] = infoMenu:AddItem (0, "?", func, self)
	end
end

function Nx.Quest:OpenGiverIconMenu (icon, typ)

	self.GiverIconMenuICompleted:Show (false)
	self.GiverIconMenuIInfo:Show (false)

	if typ ~= 3000 then
		return
	end

	self.GiverIconMenuCompleted:Show (false)
	self.GiverIconMenuInfo:Show (false)

	if icon.UDataQuestGiverD then
		self.GiverIconMenuICompleted:Show()
		self.GiverIconMenuIInfo:Show()

		self.GiverIconMenuCompletedD = icon.UDataQuestGiverD

		self:UpdateGiverIconMenu()
	end
end

function Nx.Quest:UpdateGiverIconMenu()

	local qdata = self.GiverIconMenuCompletedD

	local qIds = self.QIds
	local curI = 1

	for n = 1, #qdata, 4 do
		local qId = tonumber (strsub (qdata, n, n + 3), 16)

		local quest = self.IdToQuest[qId]
		local qname, _, lvl, minlvl = self:Unpack (quest[1])

		local col = ""

		local status, qTime = Nx:GetQuest (qId)
		if status == "C" then
			col = "|cff808080"
		else
			if qIds[qId] then
				col = "|cffa0f0a0"
			end
		end

		local s = format ("%s%d %s", col, lvl, qname)

--		Nx.prt ("Menu %s", s)

		local menuI = self.GiverIconMenuICompletedT[curI]
		if not menuI then
			break
		end

		menuI:Show()
		menuI:SetText (s)
		menuI.UData = qId
		menuI:SetChecked (status == "C")

		local menuI = self.GiverIconMenuIInfoT[curI]

		menuI:Show()
		menuI:SetText (s)
		menuI.UData = qId

		curI = curI + 1
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--------
-- Track quest on map

function Nx.Quest:CalcAutoTrack (cur)

	local Nx = Nx
	local Quest = Nx.Quest
	local curq = Quest.CurQ
	local qopts = Nx:GetQuestOpts()

	Quest.Tracking = {}
	local closest = false
	local dist = 99999999

	if cur.Q then

--		Quest.Tracking[cur.QId] = cur.TrackMask

		local closeI = cur.CloseObjI
		if closeI and closeI >= 0 then

			Quest.Tracking[cur.QId] = cur.TrackMask			-- bit.lshift (1, closeI)
			Quest:TrackOnMap (cur.QId, closeI, cur.QI > 0 or cur.Party, true, true)
		end

		for objn = 1, 15 do

			local obj = cur.Q[objn + 3]
			if not obj then
				break
			end

			local obit = bit.lshift (1, objn)
			if bit.band (cur.TrackMask, obit) > 0 then

				if Quest:GetObjectiveType (obj) == 1 then

					local d = cur["OD"..objn]

					if d and d < dist then
						dist = d
						closest = cur
--						Quest.ClosestSpanI = objn
					end
				end
			end
		end
	end

--	Quest.ClosestSpanCur = closest
end

--------
-- Is targeted already?

function Nx.Quest:IsTargeted (qId, qObj, x1, y1, x2, y2)

	local typ, tid = Nx.Map:GetTargetInfo()
	if typ == "Q" then

		local tqid = floor (tid / 100)
		if tqid == qId then		-- Same as us?

			if x1 then
				local tx1, ty1, tx2, ty2 = Nx.Map:GetTargetPos()
				if x1 ~= tx1 or y1 ~= ty1 or x2 ~= tx2 or y2 ~= ty2 then
					return
				end
			end

			if not qObj then
				return true
			end

			if tid % 100 == qObj then
				return true
			end
		end
	end
end

--------
-- Track quest on map

function Nx.Quest:TrackOnMap (qId, qObj, useEnd, target, skipSame)

	local Quest = Nx.Quest
	local Map = Nx.Map
	local BlizIndex = nil    
	local quest = Quest.IdToQuest[qId]
	
	if self.GOpts["QSync"] then		
		local i = 1
		while GetQuestLogTitle(i) do
			local _, _, _, _, _, _, _, _, questID = GetQuestLogTitle(i)
			if questID == qId then
				BlizIndex = i
			else
				if (IsQuestWatched(i)) then
					RemoveQuestWatch(i)
				end
			end
		i = i + 1
		end	
	end
	if quest then

		local tbits = Quest.Tracking[qId] or 0
--[[
		if tbits == 0 then	-- Nothing tracked?

			local typ, tid = Map:GetTargetInfo()
			if typ == "Q" then

				local tqid = floor (tid / 100)
				if tqid == qId then		-- Same as us?
					self.Map:ClearTargets()
				end
			end
			return
		end
--]]
		local track = bit.band (tbits, bit.lshift (1, qObj))

		local questObj
		local name, zone, loc

		if qObj == 0 then
			questObj = useEnd and quest[3] or quest[2]
			name, zone, loc = Quest:UnpackSE (questObj)
		else
			questObj = quest[qObj + 3]
			name, zone, loc = Quest:UnpackObjective (questObj)
		end

--		Nx.prt ("TrackOnMap %s %s %s %s %s", qId, qObj, track, name, zone)

		if track > 0 and zone then
			if self.GOpts["QSync"] then
				if BlizIndex then
					if not (IsQuestWatched(BlizIndex)) then
						AddQuestWatch(BlizIndex)
					end	
				end
			end
	local QMap = NxMap1.NxMap
	if not InCombatLockdown() then	
		local cur = self.QIds[qId]
		if cur then
			if not cur.Complete then		
				QMap.QuestWin:DrawNone();
				if Nx.CharOpts["MapShowQuestBlobs"] then
					QMap.QuestWin:DrawBlob(qId,true)
					QMap:ClipZoneFrm( QMap.Cont, QMap.Zone, QMap.QuestWin, 1 )
					QMap.QuestWin:SetFrameLevel(QMap.Level)		
					QMap.QuestWin:SetFillAlpha(255 * QMap.QuestAlpha)
					QMap.QuestWin:SetBorderAlpha( 255 * QMap.QuestAlpha )		
					QMap.QuestWin:Show()		
				else
					QMap.QuestWin:Hide()
				end
			end
		end
	end
	
			local mId = Map.NxzoneToMapId[zone]
			if mId then

				if target then

					local x1, y1, x2, y2

					if qObj > 0 then

						local map = Map:GetMap (1)
						local px = map.PlyrX
						local py = map.PlyrY

						-- FIX!!!!!!!!!!!!

--						x1, y1, x2, y2 = Quest:GetClosestObjectiveRect (questObj, mId, px, py)
						x1, y1 = Quest:GetClosestObjectivePos (questObj, loc, mId, px, py)
						x2 = x1
						y2 = y1
					else

						x1, y1, x2, y2 = Quest:GetObjectiveRect (questObj, loc)
						x1, y1 = Map:GetWorldPos (mId, x1, y1)
						x2, y2 = Map:GetWorldPos (mId, x2, y2)
					end

					local cur = self.QIds[qId]
--					local _, cur = self:FindCur (qId)
					if cur then
						if qObj > 0 then
							name = cur[qObj] or name
--							Nx.prt ("TrackOnMap name %s", name)
						end

						if cur.Complete then
							name = name .. L[" |cff80ff80(Complete)"]
						end
					end

					if skipSame then
						if self:IsTargeted (qId, qObj, x1, y1, x2, y2) then

							Map:SetTargetName (name)
							return
						end
					end

					self.Map:SetTarget ("Q", x1, y1, x2, y2, false, qId * 100 + qObj, name, false, mId)
--					Nx.prt ("TrackOnMap %s %s %s", qId, qObj, name)

					self.Map.Guide:ClearAll()
				end

				self.Map:GotoPlayer()

			else
				Nx.Quest:MsgNotInDB ("Z")
--				Nx.prt ("quest zone %s", zone)
			end

		else	-- Clear tracking

			local typ, tid = Map:GetTargetInfo()
			if typ == "Q" then

				local tqid = floor (tid / 100)
				if tqid == qId then		-- Same quest as us?

					if tbits == 0 or (tid == qId * 100 + qObj) then
						if self.GOpts["QSync"] then
							RemoveQuestWatch(BlizIndex)
						end
						self.Map:ClearTargets()
						if not InCombatLockdown() then						
							local QMap = NxMap1.NxMap						
							QMap.QuestWin:DrawNone();
							QMap.QuestWin:Hide()
						end
					end
				end
			end
		end
	end
end

--------
-- Unpack quest info
-- Format: (b) is byte
--  name len (b), name str, side (b), level (b), min lvl (b), next id (b3), category (b)

function Nx.Quest:Unpack (info)

	local strbyte = strbyte
	local i = strbyte (info, 1) - 35 + 1
	local name = strsub (info, 2, i)
	local side, lvl, minlvl, n1, n2, n3 = strbyte (info, i + 1, i + 6)
	local nextId = (n1 - 35) * 48841 + (n2 - 35) * 221 + n3 - 35
--	if nextId > 0 then
--		nextId = (nextId + 3) / 2 - 7
--	end

	return _Quest(name), side - 35, lvl - 35, minlvl - 35, nextId
end

--------
-- Unpack quest name

function Nx.Quest:UnpackName (info)

	local i = strbyte (info, 1) - 35 + 1
	return strsub (info, 2, i)
end

--------
-- Unpack quest next id

function Nx.Quest:UnpackNext (info)

	local sb = strbyte
	local i = sb (info, 1) - 35 + 1
	return (sb (info, i + 4) - 35) * 48841 + (sb (info, i + 5) - 35) * 221 + sb (info, i + 6) - 35
end

--------
-- Unpack quest category

function Nx.Quest:UnpackCategory (info)

	local i = strbyte (info, 1) - 35 + 1 + 7
	return strbyte (info, i) - 35
end

--------
-- Unpack start/end
-- Format: name index (byte x2), zone (byte), location data (may start with space)
-- Example: 00,1, xxyy
-- Example: 00,1,xywh

function Nx.Quest:UnpackSE (obj)

	if not obj then
		return
	end

	local i = (strbyte (obj) - 35) * 221 + (strbyte (obj, 2) - 35)
	local name = self.QuestStartEnd[i]

	if not name then
--		Nx.prt ("UnpackSE err %s (%s)", i, obj)
		name = "?"
	end

	if #obj == 2 then
		return name
	end

	local zone = strbyte (obj, 3) - 35
	name = _NPC(name)

	return name, zone, 4
end

--------
-- Unpack objective or start/end
-- Format: name length (byte), name string, zone (byte), location data (may start with space)
-- Example: 3,the,1, xxyy
-- Example: 3,end,1,xywh

function Nx.Quest:UnpackObjective (obj)

	if not obj then
		return
	end

	local i = strbyte (obj) - 35 + 1
	local desc = strsub (obj, 2, i)

	if #obj == i then
		desc = _NPC(desc)
		return desc
	end

	local zone = strbyte (obj, i + 1) - 35
	desc = _NPC(desc)

	return desc, zone, i + 2
end

--------
-- Get type of objective (not start/end)

function Nx.Quest:GetObjectiveType (obj)

	local loc = strbyte (obj) - 35 + 3
	local typ = strbyte (obj, loc) or 0			-- Can be nil somehow

	if typ <= 33 then  -- Points
		return 0
	end

	return 1		-- Spans
end

--------
-- Get centered position of start/end

function Nx.Quest:GetSEPos (str)

	local name, zone, loc = self:UnpackSE (str)

	if zone then
		name = _Quest(name)
		return name, zone, self:GetPosLoc (str, loc)		-- x, y
	end
end

--------
-- Get centered position of objective

function Nx.Quest:GetObjectivePos (str)

	local name, zone, loc = self:UnpackObjective (str)

	if zone then
		name = _Quest(name)
		return name, zone, self:GetPosLoc (str, loc)		-- x, y
	end
end

--------
-- Get centered position from location string

function Nx.Quest:GetPosLoc (str, loc)

	local cnt
	local ox = 0
	local oy = 0

	local typ = strbyte (str, loc)

	if typ == 32 then  -- Point

		cnt = floor ((#str - loc) / 4)

		local x, y

		for locN = loc + 1, loc + cnt * 4, 4 do

--			local loc1 = strsub (str, locN, locN + 3)
--			assert (loc1 ~= "")

			x, y = self:UnpackLocPtOff (str, locN)
			ox = ox + x
			oy = oy + y
		end

	elseif typ == 33 then  -- Relative point (for Icecrown airships)

		cnt = 1
		ox, oy = self:UnpackLocPtRelative (str, loc + 1)

	else -- Multiple locations

		loc = loc - 1
		local loopCnt = floor ((#str - loc) / 4)
		cnt = 0

		for locN = loc + 1, loc + loopCnt * 4, 4 do

			local loc1 = strsub (str, locN, locN + 3)
--			assert (loc1 ~= "")

--			prtVar ("Loc1", loc1)

			local x, y, w, h = self:UnpackLocRect (loc1)

			w = w / 1002 * 100
			h = h / 668 * 100

			local area = w * h
			cnt = cnt + area
			ox = ox + (x + w * .5) * area
			oy = oy + (y + h * .5) * area				
--			Nx.prt ("#%f %f %f %f %f (%f)", cnt, x, y, w, h, area)
		end
	end

	ox = ox / cnt
	oy = oy / cnt

	return ox, oy
end

--------

function Nx.Quest:UnpackLocPtRelative (str, loc)

	local cnt
	local ox, oy = Nx.Quest:UnpackLocPtOff (str, loc)

	ox = ox - 50
	oy = oy - 50

	for n = 1, GetNumBattlefieldVehicles() do

		local x, y, unitName, possessed, typ, dir, player = GetBattlefieldVehicleInfo (n)
		if x and not player then

			if typ == Nx.AirshipType then
				cnt = 1

				dir = dir / PI * 180
				oy = oy / 1.5
				ox, oy = ox * cos (dir) + oy * sin (dir), (ox * -sin (dir) + oy * cos (dir)) * 1.5
				ox = x * 100 + ox
				oy = y * 100 + oy

--				Nx.prt ("%s Airship %s %s %s", name, typ, ox, oy)
				break
			end
		end
	end

	if not cnt then
		ox = ox + 62
		oy = oy + 42
	end

	return ox, oy
end

--------


--[[
function Nx.Quest:Route (watched)

	if not IsControlKeyDown() then
		return
	end

	local Nx = Nx
	local Quest = Nx.Quest
	local qopts = Nx:GetQuestOpts()
	local Map = Nx.Map
	local map = Map:GetMap (1)
	local px = map.PlyrX
	local py = map.PlyrY
	local playerLevel = UnitLevel ("player")

	local curq = self.CurQ
	if not curq then	-- Bad stuff?
		return
	end

	local points = {}

	for _, distn in ipairs (watched) do

		local n = bit.band (distn, 0xff)

		local cur = curq[n]
		local qi = cur.QI
		local qId = cur.QId

		local id = qId > 0 and qId or cur.Title
		local qStatus = Nx:GetQuest (id)
		local qWatched = (qStatus == "W")
		local quest = cur.Q

		if quest and qWatched then

			local cnt = (cur.Complete or cur.LBCnt == 0) and 0 or 99

			for qObj = 0, cnt do

				local questObj

				if qObj == 0 then
					questObj = qi > 0 and quest[3] or quest[2]	-- Start if goto or no end?
				else
					questObj = quest[qObj + 3]
				end

				if not questObj then
					break
				end

				if bit.band (cur.TrackMask, bit.lshift (1, qObj)) > 0 then

					local wx = cur["OX"..qObj]
					if wx then
						local pt = {}
						tinsert (points, pt)

						local wy = cur["OY"..qObj]

						local x, y = map:GetZonePos (map.MapId, wx, wy)
						pt.X = x
						pt.Y = y
					end
				end
			end
		end
	end

	map:RouteQuests (points)
end
--]]

--------
-- Calc watch distance

function Nx.Quest:CalcDistances (n1, n2)

	local Nx = Nx
	local Quest = Nx.Quest
	local qopts = Nx:GetQuestOpts()
	local Map = Nx.Map
	local map = Map:GetMap (1)
	local px = map.PlyrX
	local py = map.PlyrY
	local playerLevel = UnitLevel ("player")

	local curq = self.CurQ
	if not curq then	-- Bad stuff?
		return
	end

	for n = n1, n2 do

		local cur = curq[n]

		if not cur then
			break
		end

		local qi = cur.QI
		local qId = cur.QId

		local id = qId > 0 and qId or cur.Title
		local qStatus = Nx:GetQuest (id)
		local qWatched = (qStatus == "W")
		local quest = cur.Q

		cur.Priority = 1
		cur.Distance = 999999999
		cur.CloseObjI = -1

		if cur.Complete and cur.IsAutoComplete then
			cur.Distance = 0
		end

--		if quest and (qWatched or Nx.Free) then
		if quest then

			local cnt = (cur.CompleteMerge or cur.LBCnt == 0) and 0 or 99

			for qObj = 0, cnt do

				local questObj

				if qObj == 0 then
					questObj = (qi > 0 or cur.Party) and quest[3] or quest[2]	-- Start if goto or no end?
				else
					questObj = quest[qObj + 3]
				end

				if not questObj then
					break
				end

				if bit.band (cur.TrackMask, bit.lshift (1, qObj)) > 0 then

					local _, zone, loc

					if qObj == 0 then
						_, zone, loc = self:UnpackSE (questObj)
					else
						_, zone, loc = self:UnpackObjective (questObj)
					end

					if zone then

						local mId = Map.NxzoneToMapId[zone]
						if mId then

							local x, y = self:GetClosestObjectivePos (questObj, loc, mId, px, py)
							local dist = ((x - px) ^ 2 + (y - py) ^ 2) ^ .5

							if dist < cur.Distance then
								cur.CloseObjI = qObj
								cur.Distance = dist
							end

							cur["OX"..qObj] = x
							cur["OY"..qObj] = y
							cur["OD"..qObj] = dist
						end
					end
				end
			end

--PAIDS!
			local pri = 0

			-- Player lvl 30. PriLevel = 20
			-- Q1  100 Lvl 30: 0 ldif = 0
			-- Q2  400 Lvl 20: 10 ldif = 200, .1, 90% = 360
			-- Q3 2000 Lvl 25: 5 ldif = 100, .05, 95% = 1900

			-- Player lvl 30. PriLevel = 200
			-- Q1  100 Lvl 30: 0 ldif = 0
			-- Q2  400 Lvl 20: 10 ldif = 2000, .99, 1% = 4
			-- Q3 2000 Lvl 25: 5 ldif = 1000, .5, 50% = 1000

			-- Formula: cur.Distance * priDist * cur.Priority * 10 + cur.Priority * 100

			if cur.CompleteMerge then
				pri = qopts.NXWPriComplete * 8	-- +-1600

			else
				-- 20 default. 10 lvls max diff * 200 = +-2000
				local l = min (playerLevel - cur.Level, 10)
				l = max (l, -10)
				pri = l * qopts.NXWPriLevel
			end

			cur.Priority = 1 - pri / 2010

			cur.InZone = Quest:CheckShow (map.RMapId, qId)
--PAIDE!
		end
	end
end

--------
-- Get closest position of objective or start/end

function Nx.Quest:GetClosestObjectivePos (str, loc, mapId, px, py)

	local Map = Nx.Map

	if strbyte (str, loc) <= 33 then  -- Point

		local x1, y1, x2, y2 = self:GetObjectiveRect (str, loc)
		x1, y1 = Map:GetWorldPos (mapId, (x1 + x2) / 2, (y1 + y2) / 2)
		return x1, y1

	else -- Multiple locations

		local closeDist = 999999999
		local closeX, closeY

		loc = loc - 1
		local loopCnt = floor ((#str - loc) / 4)
		cnt = 0

		for locN = loc + 1, loc + loopCnt * 4, 4 do

			local x, y

			local loc1 = strsub (str, locN, locN + 3)
			assert (loc1 ~= "")

			local x, y, w, h = self:UnpackLocRect (loc1)
			w = w / 1002 * 100
			h = h / 668 * 100

			local wx1, wy1 = Map:GetWorldPos (mapId, x, y)
			local wx2, wy2 = Map:GetWorldPos (mapId, x + w, y + h)

			x = wx1		-- Top left
			y = wy1

			if px >= wx1 and px <= wx2 then
				if py >= wy1 and py <= wy2 then		-- Within span?
					return px, py
				end
				x = px

			elseif px >= wx2 then	-- Right of span?
				x = wx2
			end

			if py >= wy1 then		-- Y within span?
				y = py
			end
			if py >= wy2 then	-- Below span?
				y = wy2
			end

			local dist = (x - px) ^ 2 + (y - py) ^ 2
			if dist < closeDist then
				closeDist = dist
				closeX = x
				closeY = y
			end

--			Nx.prt ("#%f %f %f %f %f (%f)", cnt, x, y, w, h, area)
		end

		return closeX, closeY
	end
end

--------
-- Get closest rectangle of objective or start/end

--[[

function Nx.Quest:GetClosestObjectiveRect (str, mapId, px, py)

	local Map = Nx.Map
	local Quest = Nx.Quest

	local name, zone, loc = Quest:UnpackObjective (str)

	if not zone then
		return
	end

	local close
	local closeX, closeY
	local closeDist = 999999999

	if strbyte (str, loc) <= 33 then  -- Point

		local x1, y1, x2, y2 = self:GetObjectiveRect (str, loc)
		x1, y1 = Map:GetWorldPos (mapId, x1, y1)
		x2, y2 = Map:GetWorldPos (mapId, x2, y2)
		return x1, y1, x2, y2

	else -- Multiple locations

		loc = loc - 1
		local loopCnt = floor ((#str - loc) / 4)
		cnt = 0

		for locN = loc + 1, loc + loopCnt * 4, 4 do

			local loc1 = strsub (str, locN, locN + 3)
			assert (loc1 ~= "")

			local x, y, w, h = Quest:UnpackLocRect (loc1)
			w = w / 1002 * 100
			h = h / 668 * 100

			local wx1, wy1 = Map:GetWorldPos (mapId, x, y)
			local wx2, wy2 = Map:GetWorldPos (mapId, x + w, y + h)

			-- Inside box?
--			if px >= wx1 and px <= wx2 and py >= wy1 and py <= wy2 then
--				return px - 40, py - 40, px + 40, py + 40
--			end

			x = wx1		-- Top left
			y = wy1

			if px >= wx1 and px <= wx2 then
				if py >= wy1 and py <= wy2 then		-- Within span?
					closeDist = 0
					close = loc1
--					return px, py
				end
				x = px

			elseif px >= wx2 then	-- Right of span?
				x = wx2
			end

			if py >= wy1 then		-- Y within span?
				y = py
			end
			if py >= wy2 then	-- Below span?
				y = wy2
			end

			local dist = (x - px) ^ 2 + (y - py) ^ 2
			if dist < closeDist then
				closeDist = dist
				close = loc1
			end

--			Nx.prt ("#%f %f %f %f %f (%f)", cnt, x, y, w, h, area)
		end

		local x, y, w, h = Quest:UnpackLocRect (close)
		w = w / 1002 * 100
		h = h / 668 * 100
		local x1, y1 = Nx.Map:GetWorldPos (mapId, x - 3, y - 3)
		local x2, y2 = Nx.Map:GetWorldPos (mapId, x + w + 3, y + h + 3)

		return x1, y1, x2, y2
	end
end

--]]

--------
-- Get size of objective or start/end

function Nx.Quest:GetObjectiveRect (str, loc)

	local Quest = Nx.Quest

	local x1 = 100
	local y1 = 100
	local x2 = 0
	local y2 = 0
	local cnt

	if strbyte (str, loc) == 32 then  -- Point

		cnt = floor ((#str - loc) / 4)
		local x, y

		for locN = loc + 1, loc + cnt * 4, 4 do

--			local loc1 = strsub (str, locN, locN + 3)
--			assert (loc1 ~= "")

			x, y = Quest:UnpackLocPtOff (str, locN)
			x1 = min (x1, x)
			y1 = min (y1, y)
			x2 = max (x2, x)
			y2 = max (y2, y)
		end

	elseif strbyte (str, loc) == 33 then  -- Point

		x1, y1 = Quest:UnpackLocPtRelative (str, loc + 1)
		x2, y2 = x1, y1

	else -- Multiple locations

		loc = loc - 1

		cnt = floor ((#str - loc) / 4)

		for locN = loc + 1, loc + cnt * 4, 4 do

			local loc1 = strsub (str, locN, locN + 3)
--			assert (loc1 ~= "")

			local x, y, w, h = Quest:UnpackLocRect (loc1)

			x1 = min (x1, x)
			y1 = min (y1, y)
			x2 = max (x2, x + w / 1002 * 100)
			y2 = max (y2, y + h / 668 * 100)

--			Nx.prt ("Rect %f %f %f %f", x, y, w, h)
		end
	end

--	Nx.prt ("RectMinMax %f %f %f %f", x1, y1, x2, y2)

	return x1, y1, x2, y2
end

--------
-- Unpack location data " xywh" or "xxyy"
-- (string, offset)

function Nx.Quest:UnpackLoc (locStr, off)

	local isPt = strbyte (locStr, off) <= 33		-- Space or !

	if isPt then

		local x1, x2, y1, y2 = strbyte (locStr, 1 + off, 4 + off)
		return	((x1 - 35) * 221 + (x2 - 35)) / 100,
					((y1 - 35) * 221 + (y2 - 35)) / 100
	end

	local x, y, w, h = strbyte (locStr, 0 + off, 3 + off)

	return	(x - 35) * .5,		-- * 100 / 200, Optimised
				(y - 35) * .5		-- * 100 / 200

--	return	(x - 35) * .5 + (w - 35) * 2.505,	-- * 100 / 200, * 1002 / 200, Optimised (center)
--				(y - 35) * .5 + (h - 35) * 1.67		-- * 100 / 200, * 668 / 200
end

--------
-- Unpack location data "xywh"
-- (string)

function Nx.Quest:UnpackLocRect (locStr)

	local x, y, w, h = strbyte (locStr, 1, 4)

	return	(x - 35) * .5,		-- * 100 / 200	Optimised
				(y - 35) * .5,		-- * 100 / 200
				(w - 35) * 5.01,	-- * 1002 / 200,
				(h - 35) * 3.34	-- * 668 / 200
end

--------
-- Unpack location data point "xxyy"
-- (string)

function Nx.Quest:UnpackLocPt (locStr)

	local x1, x2, y1, y2 = strbyte (locStr, 1, 4)
	return	((x1 - 35) * 221 + (x2 - 35)) / 100,
				((y1 - 35) * 221 + (y2 - 35)) / 100
end

--------
-- Unpack location data point "xxyy"
-- (string)

function Nx.Quest:UnpackLocPtOff (locStr, off)

	local x1, x2, y1, y2 = strbyte (locStr, off, 3 + off)
	return	((x1 - 35) * 221 + (x2 - 35)) / 100,
				((y1 - 35) * 221 + (y2 - 35)) / 100
end

--------
-- Calculate first level 24 bit quest hash

--[[
function Nx.Quest:Hash (title, level)

	local str = title..level
	local h1 = 0
	local h2 = 0
	local h3 = 0
	local b1
	local b2
	local b3

	local strLen = #str
	local len = floor (strLen / 3) * 3

--	Nx.prt (format ("Hash %d %d"))

	for n = 1, len, 3 do

		b1, b2, b3 = strbyte (str, n, n + 2)
		h1 = h1 + b1
		h2 = h2 + b2
		h3 = h3 + b3
	end

	if strLen - len == 1 then
		h1 = h1 + strbyte (str, strLen)

	elseif strLen - len == 2 then
		h1 = h1 + strbyte (str, strLen - 1)
		h2 = h2 + strbyte (str, strLen)
	end

	return bit.band (h1, 0xff) + bit.band (h2, 0xff) * 0x100 + bit.band (h3, 0xff) * 0x10000
end
--]]

--------
-- Find quest in quests data from Blizzard title, level, description and objective

--[[
function Nx.Quest:Find (title, level, desc, obj)

	local hash = self:Hash (title, level)

	local quest = Nx.Quests[hash]

	if quest then

		local hashPat = self:UHash (quest[1])
		if #hashPat > 0 then

			local found

			for n = 1, #hashPat, 4 do

				local mode = strbyte (hashPat, n, n)
				local off = tonumber (strsub (hashPat, n + 1, n + 2), 16) + 1
				local match = strsub (hashPat, n + 3, n + 3)

--				Nx.prt ("QFind #%d %d %d %s", n, mode, off, match)

				if mode == 48 then

					found = strsub (obj, off, off) == match

				elseif mode == 49 then

					found = strsub (obj, -off, -off) == match

				elseif mode == 50 then

					found = strsub (desc, off, off) == match

				elseif mode == 51 then

					found = strsub (desc, -off, -off) == match

				elseif mode >= 97 then

					local cnt = mode - 96
					local match = ","

					if mode >= 103 then
						cnt = mode - 102
						match = "."
					end

					local i = 1
					for findN = 1, cnt do
						i = strfind (desc, match, i)
						if not i then
							break
						end
						i = i + 1
					end

					if i then
						off = off + i - 1
						found = strsub (desc, off, off) == match
					end

				else
					Nx.prt ("QFind bad mode %d", mode)

				end

				if found then
					return Nx.Quests[hash + (n - 1) / 4 * 0x1000000]
				end

			end

			quest = nil
		end
	end

	if not quest then

		if level > 0 then	-- Only recurse once
			-- Quest level my be -1, so Jamie exports as 0
			return self:Find (title, 0, desc, obj)
		end

		if Nx.Quest.Debug then
			Nx.prt ("QFind Failed to find %s %d", title, level)
		end
	end

	return quest
end
--]]

-------------------------------------------------------------------------------
-- Com send / rcv

function Nx.Quest:BuildComSend()

	local _
	local cur = self.Watch.ClosestCur
	local obj = 0
	local flgs = 2			-- Not a targeted quest flag

	if self.QLastChanged then	-- Quest change? Com nils this once send to zone

		cur = self.QLastChanged
--		Nx.prt ("Q Send Change %s", cur.Title)

	else
		local typ, tid = Nx.Map:GetTargetInfo()
		if typ == "Q" then

			local qid = floor (tid / 100)
			_, cur = self:FindCur (qid)
			obj = tid % 100
			flgs = 0
		end
	end

	if cur then

		if cur.Complete then
			flgs = flgs + 1
		end

		local str = format ("%04x%c%c%c", cur.QId, obj+35, flgs+35, cur.LBCnt+35)

		for n = 1, cur.LBCnt do

			local s1, _, cnt, total = strfind (cur[n], ": (%d+)/(%d+)")
			if s1 then
				total = tonumber (total)
				if total > 50 then
					cnt = cnt / total * 60
					total = 60
				end
				cnt = cnt + 2
			else
				cnt = 0
				if cur[n + 100] then		-- Done?
					cnt = 1
				end
				total = 0
			end

			str = str .. format ("%c%c", cnt + 35, total + 35)
		end

--		Nx.prt ("QSend %s", str)

		return str, 4
	end

	return "", 0
end

function Nx.Quest:DecodeComRcv (info, msg)

	--	msg = "0000###"

	if not msg or #msg < 7 then	-- Too short?
		return	-- error, so nil length
	end

	local lbcnt = strbyte (msg, 7) - 35

	if not self.Enabled then
		return 7 + lbcnt * 2		-- Message length
	end

	local qId = tonumber (strsub (msg, 1, 4), 16) or 0
	local quest = self.IdToQuest[qId]

	if not quest then						-- Unknown quest?
		info.QStr = format (L["\nQuest %s"], qId)
		return
	end

	local name, side, lvl = self:Unpack (quest[1])

	local obji = strbyte (msg, 5) - 35
	local flgs = strbyte (msg, 6) - 35

	local targetStr = ""

	if bit.band (flgs, 2) == 0 then
		targetStr = "*"
	end

	local str = format ("\n|r%s%d |cffcfcf0f%s", targetStr, lvl, name)

	if bit.band (flgs, 1) > 0 then
		str = str .. L[" (Complete)"]
	end

	if #msg >= 7 + lbcnt * 2 then

		for n = 1, lbcnt do
			local off = (n - 1) * 2
			local cnt = strbyte (msg, 8 + off) - 35
			local total = strbyte (msg, 9 + off) - 35

			local obj = quest[n + 3]
			if obj then
				local oname = self:UnpackObjective (obj)

				if obji == n then
					oname = "|cffcfcfff" .. oname
				else
					oname = "|cffafafaf" .. oname
				end

				if cnt == 0 then
					str = str .. format ("\n  %s", oname)
				elseif cnt == 1 then
					str = str .. format (L["\n  %s (done)"], oname)
				else
					str = str .. format ("\n  %s %d/%d", oname, cnt - 2, total)
				end
			end
		end

--	else
--		Nx.prt ("DecodeComRcv error quest %s", qId)

	end

	info.QStr = str

	return 7 + lbcnt * 2		-- Message length
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Party quests

function Nx.Quest.OnParty_members_changed()

	local self = Nx.Quest

--	Nx.prt ("OnParty_members_changed")


	self.Watch:ShowUpdate()


	local pq = self.PartyQ

	for name in pairs (pq) do

		local found

		for n = 1, GetNumSubgroupMembers() do

			local pname = UnitName ("party" .. n)
			if name == pname then
				found = true
				break
			end
		end

		if not found then
			pq[name] = nil
--			Nx.prt ("Old %s", name)

			Nx.Timer:Start ("QPartyUpdate", 1, self, self.PartyUpdateTimer)
		end
	end

	if IsInRaid() then	-- In raid?
		return
	end

	if GetNumSubgroupMembers() == 0 then	-- Left party?
		return
	end

	local doSend

	for n = 1, GetNumSubgroupMembers() do

		local unit = "party" .. n
		local name = UnitName (unit)

		if not pq[name] then
			doSend = true
			pq[name] = {}
--			Nx.prt ("New %s %s", unit, name)
		end
	end

	if doSend then
		self:PartyStartSend()
	end
end

--------
-- Handle party message

function Nx.Quest:OnPartyMsg (plName, msg)

	if not self.GOpts["QPartyShare"] then
		return
	end

	-- msg = "Qp1iiiifo111122223333"

--	Nx.prt ("OnPartyMsg %s: %s", plName, msg)

	local pq = self.PartyQ
	local pl = pq[plName]

	if pl then

		if strbyte (msg, 3) == 49 then	-- "1" clear?
			pl = {}
			pq[plName] = pl
		end

		local Quest = Nx.Quest
		local off = 4

		for n = 1, 99 do

			if #msg < off + 5 then	-- No more?
				break
			end

			local qId = tonumber (strsub (msg, off, off + 3), 16) or 0
			local flgs, oCnt = strbyte (msg, off + 4, off + 5)
			flgs = flgs - 35
			oCnt = oCnt - 35

			if #msg < off + 5 + oCnt * 4 then	-- Too short?
				break
			end

			local quest = self.IdToQuest[qId]
			if quest then

				local q = pl[qId] or {}
				pl[qId] = q

				q.Complete = bit.band (flgs, 1) == 1 and 1 or nil

--				Nx.prt ("%s: %s %x %s", plName, qId, flgs, oCnt)

				for i = 1, oCnt do

					local o = off + 6 + (i - 1) * 4
					local cnt = tonumber (strsub (msg, o, o + 1), 16) or 0
					local total = tonumber (strsub (msg, o + 2, o + 3), 16) or 0

					q[i] = cnt
					q[i + 100] = total
				end
			end

			off = off + 6 + oCnt * 4
		end
	end

	Nx.Timer:Start ("QPartyUpdate", .7, self, self.PartyUpdateTimer)
end

--------

function Nx.Quest:PartyUpdateTimer()

	self:RecordQuests()
	self.Watch:Update()
end

--------

function Nx.Quest:PartyStartSend()

	if IsInRaid() or GetNumSubgroupMembers() == 0 then
		return
	end

	if self.GOpts["QPartyShare"] then
		Nx.Timer:Start ("QSendParty", .5, self, self.PartyBuildSendData)
	end
end

function Nx.Quest:PartyBuildSendData()

	local data = {}

	self.PartySendData = data
	self.PartySendDataI = 1

	local sendStr = ""

	for n, cur in ipairs (self.CurQ) do

		local qId = cur.QId

		if not cur.Goto and Nx:GetQuest (qId) == "W" then

			local flgs = 0

			if cur.Complete then
				flgs = flgs + 1
			end

			local str = format ("%04x%c%c", qId, flgs + 35, cur.LBCnt + 35)

			for n = 1, cur.LBCnt do

				local _, _, cnt, total = strfind (cur[n], ": (%d+)/(%d+)")
				cnt = tonumber (cnt)
				total = tonumber (total)

				if cnt and total then
					if cnt > 200 then
						cnt = 200
					end
				else
					cnt = 0
					if cur[n + 100] then		-- Done?
						cnt = 1
					end
					total = 0
				end

				str = str .. format ("%02x%02x", cnt, total)
			end

			sendStr = sendStr .. str

			if #sendStr > 80 then
				tinsert (data, sendStr)
				sendStr = ""
			end
		end
	end

	if #sendStr > 0 or #data == 0 then
		tinsert (data, sendStr)
	end

	Nx.Timer:Start ("QSendParty", 0, self, self.PartySendTimer)

	return 0
end

function Nx.Quest:PartySendTimer()

	local qi = self.PartySendDataI
	local data = self.PartySendData[qi]

	if data then
		local s = qi == 1 and "1" or " "
		Nx.Com:Send ("p", "Qp" .. s .. data)
--		Nx.prt ("PQSend %s", data)
	end

	self.PartySendDataI = qi + 1

	if self.PartySendData[self.PartySendDataI] then
		return .15
	end
end

-------------------------------------------------------------------------------
-- EOF










