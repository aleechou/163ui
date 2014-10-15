--
-- JSHB by JS
--

local AceConfigDialog3 = nil
function JSHB.SlashProcessor_JSHB(input, editbox)
	local v1, v2 = input:match("^(%S*)%s*(.-)$")
	v1 = v1:lower()
	if (v1 == "options") or (v1 == "config") or (v1 == "opt") or (v1 == "o") or (v1 == "") then
		AceConfigDialog3 = AceConfigDialog3 or LibStub("AceConfigDialog-3.0")
		if AceConfigDialog3 and AceConfigDialog3.OpenFrames["JSHB"] then
			JSHB.CloseOptions()
		else
			JSHB.OpenOptions()
		end
	elseif (v1 == "reset") then
		if (not InCombatLockdown() ) then
			print(JSHB.L["JSHB_PRE"]..JSHB.L["MOVERSSETTODEFAULT"])
			JSHB.SetDefaultMoversPositions()
		else
			print(JSHB.L["JSHB_PRE"]..JSHB.L["INCOMBATLOCKDOWN"])
		end
	elseif (v1 == "lock") or (v1 == "unlock") or (v1 == "drag") or (v1 == "move") or (v1 == "l") then
		JSHB.ToggleMoversLock()		
	elseif (v1 == "tableid") or (v1 == "table") then
		if GetMouseFocus():GetName() then
			print("TABLE:", GetMouseFocus():GetName()..(v2 ~= nil and "."..v2 or "") )
			local key, val, frameTable
			frameTable = (v2 ~= nil) and _G[GetMouseFocus():GetName()][v2] or _G[GetMouseFocus():GetName()]
			for key,val in pairs(frameTable) do
				print("Key: ", key, " Val: ", val)
			end
		end
	elseif (v1 == "mem") or (v1 == "m") then
		UpdateAddOnMemoryUsage()
		print("Memory Used:", GetAddOnMemoryUsage("JSHB") )
	elseif (v1 == "gc") then
		print("Garbage collected...")
		collectgarbage("collect")
	else
		print(format(JSHB.L["SLASHDESC1"], JSHB.myVersion) )
		print("/jsb config - " .. JSHB.L["SLASHDESC2"])
		print("/jsb lock - " .. JSHB.L["SLASHDESC3"])
		print("/jsb reset - " .. JSHB.L["SLASHDESC4"])
	end
end

function JSHB:VARIABLES_LOADED()
	--print("VARIABLES_LOADED")
	JSHB:UnregisterEvent("VARIABLES_LOADED")

	-- Modules for all classes
	do
		JSHB.RegisterConfigFunction("MOD_TIMERS", JSHB.SetupTimersModule) 							-- Timers Module
		JSHB.RegisterConfigFunction("MOD_ALERTS", JSHB.SetupAlertsModule) 							-- Alerts Module
		JSHB.RegisterConfigFunction("MOD_INTERRUPTS", JSHB.SetupInterruptsModule) 					-- Interrupts Module
		JSHB.RegisterConfigFunction("MOD_CROWDCONTROL", JSHB.SetupCrowdControlModule) 				-- Crowd Control Module
	end
	if tContains({ "HUNTER", "WARRIOR", "ROGUE", "WARLOCK" }, select(2, UnitClass("player") ) ) then
		JSHB.RegisterConfigFunction("MOD_ENERGYBAR", JSHB.SetupEnergyBarModule) 					-- Energy bar Module
	end
	if tContains({ "HUNTER", "ROGUE" }, select(2, UnitClass("player") ) ) then
		JSHB.RegisterConfigFunction("MOD_ENRAGE", JSHB.SetupEnrageModule) 							-- Enrage Module	
	end
	if tContains({ "HUNTER", "WARRIOR", "ROGUE" }, select(2, UnitClass("player") ) ) then
		JSHB.RegisterConfigFunction("MOD_ASPECTINDICATOR",JSHB.SetupAspectIndicatorModule)			-- Aspect/Stance Indicator Module
	end
	if tContains({ "HUNTER", "ROGUE" }, select(2, UnitClass("player") ) ) then
		JSHB.RegisterConfigFunction("MOD_MDANNOUNCE", JSHB.SetupMisdirectionAnnounceModule) 		-- Misdirection Announce Module
	end
	if tContains({ "HUNTER" }, select(2, UnitClass("player") ) ) then
		JSHB.RegisterConfigFunction("MOD_MASTERSCALLANNOUNCE", JSHB.SetupMastersCallAnnounceModule)	-- Master's Call Announce Module
	end
	
	-- Globally configure all modules.
	JSHB.ReconfigureJSHB()
	
	JSHB:RegisterEvent("UI_SCALE_CHANGED")
	JSHB:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	JSHB:RegisterEvent("PLAYER_LEVEL_UP")
	JSHB:RegisterEvent("PLAYER_ENTERING_WORLD")
	JSHB:RegisterEvent("SPELLS_CHANGED")
end

function JSHB:UI_SCALE_CHANGED()
	--print("UI_SCALE_CHANGED")
	JSHB.ReconfigureJSHB()
end

function JSHB:ACTIVE_TALENT_GROUP_CHANGED()
	--print("ACTIVE_TALENT_GROUP_CHANGED")
	JSHB.ReconfigureJSHB()
end

function JSHB:PLAYER_ENTERING_WORLD()
	--print("PLAYER_ENTERING_WORLD")
	JSHB.ReconfigureJSHB()
end

function JSHB:PLAYER_LEVEL_UP()
	--print("PLAYER_LEVEL_UP")
	JSHB.ReconfigureJSHB()
end

function JSHB:PostChangeProfile()
	--print("JSHB:PostChangeProfile()")
	JSHB.Options:PopulateDB()
	JSHB.ReconfigureJSHB()
end

function JSHB:SPELLS_CHANGED()
	--print("SPELLS_CHANGED")
	JSHB.SetupTimersModule()
end

function JSHB:OnInitialize()
	
	-- Register Slash commands for JS' Hunter Bar.
	SlashCmdList["JSHB"] = JSHB.SlashProcessor_JSHB
	_G["SLASH_JSHB1"] = '/jshb'
	_G["SLASH_JSHB2"] = '/jsb'
	_G["SLASH_JSHB3"] = '/js'
	
	-- JSHB tries to wait for all variables to be loaded before configuring itself.
	JSHB:RegisterEvent("VARIABLES_LOADED")
	
	-- Setup Saved Variables
	JSHB.db = LibStub("AceDB-3.0"):New("JSHB4", JSHB.defaults) -- removed , true)

	-- New installation?
	JSHB.CheckForNewInstallSetup()
	
	-- Check if we need to upgrade any database items.
	--JSHB.CheckForUpgrades()
	
	-- Register a reconfigure call for when the user changes profiles.
	JSHB.db.RegisterCallback(JSHB, "OnProfileChanged", "PostChangeProfile")
	JSHB.db.RegisterCallback(JSHB, "OnProfileCopied", "PostChangeProfile")
	JSHB.db.RegisterCallback(JSHB, "OnProfileReset", "PostChangeProfile")
	
	-- Setup the initial options panels.
	JSHB.Options.Initialize()
end
